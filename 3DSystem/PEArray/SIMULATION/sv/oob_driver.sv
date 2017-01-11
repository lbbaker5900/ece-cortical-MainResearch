/*********************************************************************************************
    File name   : oob_driver.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Jan 2017
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains the oob driver.
                  It takes the operation from the manager and generators and drives it through the stack interface.
                  The oob driver accesses all lanes so it will wait for the manager operation and each generator operation before driving the bus.
                  We need generator info because the generator randomizes the address for each lane.
*********************************************************************************************/

`include "common.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

`include "TB_streamingOps_cntl.vh"  // might cause an error if this is included in any of the above files


import virtual_interface::*;
import operation::*;

class oob_driver;

    int       Id                                             ; // oob is per PE
                                                           
    mailbox   mgr2oob                                        ;
    event     mgr2oob_ack                                    ;

    mailbox   gen2oob     [`PE_NUM_OF_EXEC_LANES_RANGE ]     ;
    event     gen2oob_ack [`PE_NUM_OF_EXEC_LANES_RANGE ]     ;


    oob_packet       oob_packet_gen     ;  // constructed from the sys_operation and sent to the OOB process 
    oob_packet       oob_packet_new     ;  // used in OOB process

    // OOB driver needs oob signals and lane signals to send oob packet
    vSysOob2PeArray_T  vSysOob2PeArray                                 ;  // FIXME: OOB is a per PE interface but we have driver objects for all PE/Lanes
    vSysLane2PeArray_T vSysLane2PeArray [`PE_NUM_OF_EXEC_LANES_RANGE ] ;
    vSysLane2PeArray_T tmp_vSysLane2PeArray ;

    //----------------------------------------------------------------------------------------------------
    // Misc

    // Drive regFile interface
    // FIXME: may go away once SIMD and result path is working
    mailbox   oob2rfP                                        ;
    event     oob2rfP_ack                                    ;
    mailbox   tmp_oob2rfP                                    ;
    event     tmp_oob2rfP_ack                                ;

    //----------------------------------------------------------------------------------------------------



    function new (
                  input int                   Id                                           ,
                  input mailbox               mgr2oob                                      ,   
                  input event                 mgr2oob_ack                                  ,
                  input mailbox               gen2oob           [`PE_NUM_OF_EXEC_LANES   ] ,
                  input event                 gen2oob_ack       [`PE_NUM_OF_EXEC_LANES   ] ,
                  input vSysOob2PeArray_T     vSysOob2PeArray                              ,
                  input vSysLane2PeArray_T    vSysLane2PeArray  [`PE_NUM_OF_EXEC_LANES   ] );

        this.Id                  = Id                         ;
        this.mgr2oob             = mgr2oob                    ;
        this.mgr2oob_ack         = mgr2oob_ack                ;
        this.gen2oob             = gen2oob                    ;
        this.gen2oob_ack         = gen2oob_ack                ;
        this.vSysOob2PeArray     = vSysOob2PeArray            ;
        this.vSysLane2PeArray    = vSysLane2PeArray           ;
    endfunction

    task run();
        //$display("@%0t:%s:%0d: LEE: Running OOB driver : {%0d,%0d}\n", $time, `__FILE__, `__LINE__, Id[0], Id[1]);

        // OOB process will configure the PE (WIP)
            forever
                begin
                    if ( mgr2oob.num() != 0 )
                        begin
                            while(mgr2oob.num() != 0)
                                begin
                                    mgr2oob.peek(oob_packet_new) ;                             //Taking the instruction from generator 
                                    $display("@%0t%s:%0d:LEE:oob_driver.sv: {%0d} received OOB packet from manager: %0b", $time, `__FILE__, `__LINE__, Id, oob_packet_new.stOp_operation );

                                    // FIXME:needs to collect oob_packets from the generator also before constructing WU
           
           
                                    vSysOob2PeArray.cb_test.std__pe__oob_valid        <= 0  ;  // FIXME: temporary drive OOB to non-X
                                    vSysOob2PeArray.cb_test.std__pe__oob_cntl         <= 0  ;  
                                    vSysOob2PeArray.cb_test.sys__pe__allSynchronized  <= 1  ;

                                    for (int lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane=lane+1) 
                                        begin
                                             //@(tmp_vSysLane2PeArray[lane].cb_test);
                                             vSysLane2PeArray[lane].cb_test.std__pe__lane_strm0_data_valid  <= 0  ;
                                             vSysLane2PeArray[lane].cb_test.std__pe__lane_strm0_cntl        <= 0  ;         //Passing the instruction to the system interface
                                             vSysLane2PeArray[lane].cb_test.std__pe__lane_strm0_data        <= 32'hdead_beef  ;
                                             vSysLane2PeArray[lane].cb_test.std__pe__lane_strm0_data_mask   <= 0  ;
                                             vSysLane2PeArray[lane].cb_test.std__pe__lane_strm1_data_valid  <= 0  ;
                                             vSysLane2PeArray[lane].cb_test.std__pe__lane_strm1_cntl        <= 0  ;         //Passing the instruction to the system interface
                                             vSysLane2PeArray[lane].cb_test.std__pe__lane_strm1_data        <= 32'hbabe_cafe  ;
                                             vSysLane2PeArray[lane].cb_test.std__pe__lane_strm1_data_mask   <= 0  ;

                                             // FIXME: OOB WIP so drive regFile
                                             //oob2rfP[lane].put(oob_packet_new)                   ;
                                             //@oob2rfP_ack[lane]                                  ;  // wait for regFile inputs to be driven
                                        end 

                                    mgr2oob.get(oob_packet_new)  ;  //Removing the instruction from generator mailbox
                                    
                                end  // while
                                $display("@%0t:%s:%0d:INFO: {%d,%d} Completed driving OOB", $time, `__FILE__, `__LINE__, Id[0], Id[1] );
                            end
                    // watch out for infinite loop if commenting out this section of code
                    // a forever loop will need an @clk
                    else
                        begin 
                            @(vSysOob2PeArray.cb_test);
                            vSysOob2PeArray.cb_test.std__pe__oob_valid        <= 0  ;  // FIXME: temporary drive OOB to non-X
                            vSysOob2PeArray.cb_test.std__pe__oob_cntl         <= 0  ;  
                            vSysOob2PeArray.cb_test.sys__pe__allSynchronized  <= 1  ;
                        end  // if

                end  // forever
    endtask


endclass
