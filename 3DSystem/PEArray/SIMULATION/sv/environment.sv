/************************************************************************************************
    File name   : environment.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Aug 2016
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains the verification environment. It contains the objects of
                  generator, driver and scoreboards & checkers of all the blocks.
                  This class has 4 basic functions
                  new()     : This function retrieves the interafces, mailboxes, events etc.
                              passed by the testbench.
                  build()   : This function allocates a memory to the objects and pass the
                              required interfaces, mailboxes and events.
                  run()     : This function spawns the run functions of all the objects in parallel.
                  wrap_up() : This function marks the end of testing.

                  Note: leveraged from https://github.ncsu.edu/ECE-Memory-Controller-IS/ece-diram4-memory-controller

*************************************************************************************************/
`timescale 1ns/10ps

`include "common.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "streamingOps_cntl.vh"

`include "interface.sv"
`include "manager.sv"
`include "generator.sv"
`include "driver.sv"
`include "oob_driver.sv"
`include "upstream_checker.sv"
`include "mem_checker.sv"
`include "regFile_driver.sv"
`include "loadStore_driver.sv"

import virtual_interface::*;

class Environment;
    // each generator/driver pair handles the two streams in each pe/lane
    manager            mgr               [`PE_ARRAY_NUM_OF_PE]                        ;
    generator          gen               [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ; 
    driver             drv               [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ;
    oob_driver         oob_drv           [`PE_ARRAY_NUM_OF_PE]                        ;
    upstream_checker   up_check          [`PE_ARRAY_NUM_OF_PE]                        ;
    mem_checker        mem_check         [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ;
    regFile_driver     rf_driver         [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ;
    loadStore_driver   ldst_driver       [`PE_ARRAY_NUM_OF_PE]                        ;


    mailbox       mgr2oob          [`PE_ARRAY_NUM_OF_PE]                         ;
    event         mgr2oob_ack      [`PE_ARRAY_NUM_OF_PE]                         ; 

    // generator provides customized addresses for OOB driver
    mailbox       gen2oob          [`PE_ARRAY_NUM_OF_PE]                         ;  // all generators put their oob_packet in the same mailbox 
    event         gen2oob_ack      [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;  // but all generators get their own ack

    mailbox       mgr2gen          [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;
    event         mgr2gen_ack      [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ; 

    mailbox       gen2drv          [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;
    event         gen2drv_ack      [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ; 

    mailbox       mgr2up           [`PE_ARRAY_NUM_OF_PE]                         ;  // manager sends transaction type to upstream checker, generator sends expected values
    mailbox       gen2up           [`PE_ARRAY_NUM_OF_PE]                         ;

    // an operation defines what is sent on both the streams in a pe/lane
    event         new_operation    [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ; 
    event         final_operation  [`PE_ARRAY_NUM_OF_PE]                         ;

    mailbox       drv2memP         [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;
    event         drv2memP_ack     [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;  

    mailbox       gen2rfP          [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;
    event         gen2rfP_ack      [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;  

    //mailbox       gen2ldstP         ;
    //event         gen2ldstP_ack    [`PE_ARRAY_NUM_OF_PE]                        ;

    // an array of all stream interfaces in the system
    vDownstreamStackBusOOB_T      vDownstreamStackBusOOB           [`PE_ARRAY_NUM_OF_PE]                         ;
    vDownstreamStackBusLane_T            vDownstreamStackBusLane                 [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;
    vUpstreamStackBus_T        vUpstreamStackBus             [`PE_ARRAY_NUM_OF_PE]                         ;

    // an array of all dma to memory interfaces in the system
    vDma2Mem_T             vDma2Mem                              [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;

    // an array of all regFile scalar and vector signals to stOp controller
    vRegFileScalarDrv2stOpCntl_T vRegFileScalarDrv2stOpCntl      [`PE_ARRAY_NUM_OF_PE]                         ;
    vRegFileLaneDrv2stOpCntl_T   vRegFileLaneDrv2stOpCntl        [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES]  ;

    // an array of all SIMD load/store interfaces into the memory controller
    vLoadStoreDrv2memCntl_T      vLoadStoreDrv2memCntl           [`PE_ARRAY_NUM_OF_PE]                         ;

    //----------------------------------------------------------------------------------------------------
    // 
    function new (
                    // Retrieving the interface passed from the testbench in order to pass it to the required blocks.
                    input vDownstreamStackBusOOB_T     vDownstreamStackBusOOB          [`PE_ARRAY_NUM_OF_PE]                        ,
                    input vDownstreamStackBusLane_T           vDownstreamStackBusLane                [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ,
                    input vUpstreamStackBus_T       vUpstreamStackBus            [`PE_ARRAY_NUM_OF_PE]                        ,
                    input vDma2Mem_T                   vDma2Mem                        [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ,
                    input vRegFileScalarDrv2stOpCntl_T vRegFileScalarDrv2stOpCntl      [`PE_ARRAY_NUM_OF_PE]                        ,
                    input vRegFileLaneDrv2stOpCntl_T   vRegFileLaneDrv2stOpCntl        [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] ,
                    input vLoadStoreDrv2memCntl_T      vLoadStoreDrv2memCntl           [`PE_ARRAY_NUM_OF_PE]                        
                );
        this.vDownstreamStackBusLane            =   vDownstreamStackBusLane            ;
        this.vDownstreamStackBusOOB             =   vDownstreamStackBusOOB             ;
        this.vUpstreamStackBus             =   vUpstreamStackBus             ;
        this.vDma2Mem                    =   vDma2Mem                    ;
        this.vRegFileScalarDrv2stOpCntl  =   vRegFileScalarDrv2stOpCntl  ;
        this.vRegFileLaneDrv2stOpCntl    =   vRegFileLaneDrv2stOpCntl    ;
        this.vLoadStoreDrv2memCntl       =   vLoadStoreDrv2memCntl       ;
    endfunction

    task build();                                 //This task passes the required interfaces, mailboxes, events to the objects of driver, generator and respective scoreboards.
        int Id [2];
        for (int pe=0; pe<`PE_ARRAY_NUM_OF_PE; pe++)
            begin
                //gen2ldstP   = new () ;
                mgr2oob     [pe]  = new () ;
                gen2oob     [pe]  = new () ;
                mgr2up      [pe]  = new () ;
                gen2up      [pe]  = new () ;

                ldst_driver [pe]  = new ( Id,            vLoadStoreDrv2memCntl [pe] ); // ,                                      gen2ldstP, gen2ldstP_ack [pe]        );  // load/store driver for mem controller inputs
                for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
                    begin
                        vDownstreamStackBusLane[pe][lane].cb_test.std__pe__lane_strm0_data_valid  <= 1'b0;
                        vDownstreamStackBusLane[pe][lane].cb_test.std__pe__lane_strm1_data_valid  <= 1'b0;

                        //$display("@%0t:%s:%0d: LEE: Create generators and drivers : {%0d,%0d,%0d}\n", $time, `__FILE__, `__LINE__,pe,lane,stream);
                        Id = {pe, lane};
                        mgr2gen     [pe][lane]  = new () ;  // each manager will have mailboxes for each of its lane generators
                        gen2drv     [pe][lane]  = new () ;
                        drv2memP    [pe][lane]  = new () ;
                        gen2rfP     [pe][lane]  = new () ;
                        // remember, each gen/drv tuple handle both streams in a lane
                        gen         [pe][lane]  = new ( Id, mgr2gen[pe][lane] , mgr2gen_ack[pe][lane], gen2drv[pe][lane] , gen2drv_ack[pe][lane], gen2oob[pe] , gen2oob_ack[pe][lane], new_operation[pe][lane], vDownstreamStackBusOOB [pe]       ,   vDownstreamStackBusLane [pe][lane] ,        gen2rfP[pe][lane],    gen2rfP_ack[pe][lane]  , gen2up [pe] );
                        drv         [pe][lane]  = new ( Id, gen2drv[pe][lane] , gen2drv_ack[pe][lane], new_operation[pe][lane],                             vDownstreamStackBusOOB [pe]       ,   vDownstreamStackBusLane [pe][lane] ,       drv2memP[pe][lane],   drv2memP_ack[pe][lane]  );
                        mem_check   [pe][lane]  = new ( Id,                                                                                                       vDma2Mem  [pe][lane] ,                                       drv2memP[pe][lane],   drv2memP_ack[pe][lane]  );  // monitor dma to memory interface for result check
                        rf_driver   [pe][lane]  = new ( Id,                                                                                      vRegFileScalarDrv2stOpCntl [pe]       , vRegFileLaneDrv2stOpCntl [pe][lane] ,  gen2rfP[pe][lane],   gen2rfP_ack [pe][lane]  );  // RegFile driver for stOp controller inputs
                    end
                 
                mgr         [pe]  = new ( pe, mgr2oob[pe] , mgr2oob_ack[pe], mgr2gen[pe] , mgr2gen_ack[pe],  final_operation[pe], vDownstreamStackBusOOB [pe],   vDownstreamStackBusLane [pe] , mgr2up [pe]);
                oob_drv     [pe]  = new ( pe, mgr2oob[pe],  mgr2oob_ack[pe], gen2oob[pe],  gen2oob_ack[pe],                       vDownstreamStackBusOOB [pe],   vDownstreamStackBusLane [pe] );
                up_check    [pe]  = new ( pe, vUpstreamStackBus [pe],  mgr2up [pe], gen2up [pe] ) ;
            end


    endtask

    task run();                                                       //This task spawns parallel run tasks of generator, driver, golden models and their respective checkers.
        /* */
        // Remove when driving via OOB packet
        $display("@%0t:%s:%0d: : INFO:ENV: Reset generators and drivers \n", $time, `__FILE__, `__LINE__,);
        fork                                                          
            // We have a generator, driver and checker for every pe/lane
            `include "TB_reset_generators_and_drivers.vh"
        join
        /* */

        $display("@%0t:%s:%0d: : INFO:ENV: Run generators and drivers \n", $time, `__FILE__, `__LINE__,);
        fork                                                          
            // We have a generator, driver and checker for every pe/lane
            `include "TB_start_generators_and_drivers.vh"
            // gen.run();
            // drv.run();
        join_none

        //$display("@%0t%s:%0d: LEE: Wait for final operation\n", $time, `__FILE__, `__LINE__,);
        fork                                                          //These end after the manager triggers the event "final_operation" after generating the final transaction.
            `include "TB_wait_for_final_operation.vh"
        join

        //join_none
        //wait fork ;
        //$display("@%0t:%s:%0d: LEE: Drivers taken all operations \n", $time, `__FILE__, `__LINE__);

/*
        // check all memory checkers have finished
        for (int pe=0; pe<`PE_ARRAY_NUM_OF_PE; pe++)
            begin
                for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
                    begin
                        // this will help finding any unfinished checkers
                        $display("@%0t:%s:%0d: INFO: Mem checker complete : {%0d,%0d}\n", $time, `__FILE__, `__LINE__,pe,lane);
                        //wait (mem_check[pe][lane].finished.triggered);  // doesnt seem to work???
                        wait (mem_check[pe][lane].found == 1);
                        //$display("@%0t:%s:%0d: LEE: Mem checker complete : {%0d,%0d}\n", $time, `__FILE__, `__LINE__,pe,lane);
                        mem_check[pe][lane].finished = null ;
                    end
            end
*/

    endtask

    task wrap_up();                                               //This task marks the completion of verification.
        $display("@%0t:%s:%0d:Complete!",$time, `__FILE__, `__LINE__);
    endtask : wrap_up


endclass
