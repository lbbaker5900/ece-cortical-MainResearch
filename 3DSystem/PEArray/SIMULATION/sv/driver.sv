/*********************************************************************************************
    File name   : driver.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains the driver, i.e. it takes the operation from the generator
                  and drives it through the stack interface. 
                  It also performs the function
                  of tracking the ready signal to the system from the PE.
*********************************************************************************************/

`include "common.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"


import virtual_interface::*;
import operation::*;

class driver;
    int       Id [2]           ; // PE, Lane, Stream
    mailbox   gen2drv          ;
    event     gen2drv_ack      ;
    event     new_operation    ;

    mailbox   drv2oob          ;  // create a mailbox for the OOB
    mailbox   drv2lane []      ;  // create a mailbox for each stream driver
    int transaction    []      ;

    // observe memory interface to check result
    // FIXME: may go away once SIMD and result path is working
    mailbox   drv2memP         ;
    event     drv2memP_ack     ;

    base_operation   sys_operation      ;
    base_operation   oob_operation      ;  // a copy of the sys_operation sent to the OOB process
    stream_operation tmp_strm_operation ;
    stream_operation strm_operation [] ;

    // FIXME : doesnt need all interfaces
    vSysOob2PeArray_T  vSysOob2PeArray  ;  // FIXME: OOB is a per PE interface but we have driver objects for all PE/Lanes
    vSysLane2PeArray_T vSysLane2PeArray ;

    function new (
                  input int                  Id[2]              ,
                  input mailbox              gen2drv            ,                  //Retrieving mailboxes and virtual system interface.
                  input event                gen2drv_ack        ,
                  input event                new_operation      ,
                  input vSysOob2PeArray_T    vSysOob2PeArray    ,
                  input vSysLane2PeArray_T   vSysLane2PeArray   ,
                  input mailbox              drv2memP           ,
                  input event                drv2memP_ack       );

        this.Id                  = Id                         ;
        this.gen2drv             = gen2drv                    ;
        this.gen2drv_ack         = gen2drv_ack                ;
        this.new_operation       = new_operation              ;
        this.vSysOob2PeArray     = vSysOob2PeArray            ;
        this.vSysLane2PeArray    = vSysLane2PeArray           ;
        this.drv2memP            = drv2memP                   ;
        this.drv2memP_ack        = drv2memP_ack               ;
        this.drv2oob             = new                        ;
        this.drv2lane            = new[`PE_NUM_OF_STREAMS  ]  ;
        for (int i=0; i<drv2lane.size(); i++)
            begin
                this.drv2lane[i]            = new             ;
            end
        this.oob_operation       = new                        ;  // create a separate base_operation so we can split OOB into a different class in future
        this.strm_operation      = new[`PE_NUM_OF_STREAMS  ]  ;
        this.transaction         = new[`PE_NUM_OF_STREAMS  ]  ;
        //for (int i=0; i<transaction.size(); i++)
        //    begin
        //        this.transaction[i]   = new(0)                ;
        //    end
    endfunction

    task run();

        // Spawn 4 processes:
        // - first receives operations from the generator and splits it into two stream operations
        // - an OOB process will configure the PE (WIP)
        // - the other two look for the stream operation from the first process and drive it onto there corresponding stream 
        fork
            begin
                forever
                    begin
                        // take the transaction from the generator, splits it into two streams and sends a stream operation to both the processes
                        // and send the sys_operation to the OOB process
                        @(vSysLane2PeArray.cb_test);
                        //$display("@%0t : LEE: {%d,%d} Check mailbox", $time, Id[0], Id[1] );
                        if ( gen2drv.num() != 0 )
                            begin
                                //$display("@%0t : LEE: {%d,%d} received system trans", $time, Id[0], Id[1] );
                                gen2drv.peek(sys_operation);                                                //Taking the instruction from generator 
                                //$display("@%0t : LEE: IDs : { %d } ", $time, sys_operation.id);
                                //$display("@%0t : LEE: IDs : { %d } ", $time, strm_operation[1].id);
                    
                                drv2oob.put(sys_operation)                    ;  // oob needs to prepare the PE
                                // FIXME: Need to wait for the OOB process to send WU packet to PE (WIP)

                                // create stream objects and send to process driving downstream stream stack bus
                                for (int i=0; i<sys_operation.stOp_operation.numberOfSrcStreams; i++)
                                    begin
                                        tmp_strm_operation                  = new            ;
                                        tmp_strm_operation.tId              = sys_operation.tId               ;
                                        tmp_strm_operation.operands         = new[sys_operation.numberOfOperands](sys_operation.operands[i])      ;
                                        tmp_strm_operation.numberOfOperands = sys_operation.numberOfOperands ;
                                        //tmp_strm_operation.operands         = sys_operation.operands[i]      ;
                                        drv2lane[i].put(tmp_strm_operation)                    ;
                                        $display("@%0t : LEE: {%d,%d} Passed to stream driver %1d", $time, Id[0], Id[1], i );
                                    end


                                // put operations into golden mailbox
                                drv2memP.put(sys_operation) ;  //Putting the instruction into the golden model mailbox                                              
                                //$display("@%0t LEE: Send operation to mem_checker: {%0d,%0d} with expected result of %f, %f <> %f\n", $time,Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, );
                                @drv2memP_ack               ;
             
                                gen2drv.get(sys_operation)  ;  //Removing the instruction from generator mailbox
                                -> gen2drv_ack;
                                //$display("@%0t : LEE: {%d,%d} Passed to stream drivers", $time, Id[0], Id[1] );
                                                
                            end
                    end
            end
            // FIXME: currently PE OOB passed to all stream drivers so all lane drivers will drive single per PE OOB interface
            // OOB needs to configure PE before streaming
            begin
                forever
                    begin
                        if ( drv2oob.num() != 0 )
                            begin
                                while(drv2oob.num() != 0)
                                    begin
                                        drv2oob.peek(oob_operation);                                                //Taking the instruction from generator 
           
                                        @(vSysOob2PeArray.cb_test);
           
                                        vSysOob2PeArray.cb_test.std__pe__oob_valid        <= 0  ;  // FIXME: temporary drive OOB to non-X
                                        vSysOob2PeArray.cb_test.std__pe__oob_cntl         <= 0  ;  
                                        vSysOob2PeArray.cb_test.sys__pe__allSynchronized  <= 1  ;
           
                                        drv2oob.get(oob_operation)  ;  //Removing the instruction from generator mailbox
                                        
                                    end  // while
                                    $display("@%0t : INFO: {%d,%d} Completed driving OOB", $time, Id[0], Id[1] );
                                end
                        else
                            begin 
                                @(vSysOob2PeArray.cb_test);
                                vSysOob2PeArray.cb_test.std__pe__oob_valid        <= 0  ;  // FIXME: temporary drive OOB to non-X
                                vSysOob2PeArray.cb_test.std__pe__oob_cntl         <= 0  ;  
                                vSysOob2PeArray.cb_test.sys__pe__allSynchronized  <= 0  ;
                            end  // if
                    end  // forever
            end
            // FIXME : should use generate for the two following processes, but need to separate streams into separate interfaces so they can be indexed
            // dont think a generate can be put inside a class or task
            begin
                forever
                    begin
                        if ( drv2lane[0].num() != 0 )
                            begin
                                while(drv2lane[0].num() != 0)
                                    begin
                                        drv2lane[0].peek(strm_operation[0]);                                                //Taking the instruction from generator 
           
                                        while (transaction[0] < strm_operation[0].numberOfOperands)
                                            begin
                                                @(vSysLane2PeArray.cb_test);
           
                                                if (vSysLane2PeArray.cb_test.pe__std__lane_strm0_ready) 
                                                    begin
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 1  ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm0_cntl        <= ((transaction[0] == 0) && (transaction[0] == (strm_operation[0].numberOfOperands-1))) ?  `COMMON_STD_INTF_CNTL_SOM_EOM     :
                                                                                                                    ( transaction[0] == 0                                                           ) ?  `COMMON_STD_INTF_CNTL_SOM         :
                                                                                                                    ( transaction[0] == (strm_operation[0].numberOfOperands-1)                          ) ?  `COMMON_STD_INTF_CNTL_EOM         :
                                                                                                                                                                                                         `COMMON_STD_INTF_CNTL_MOM         ;
                                                        //if ((Id[0]==0)&&(Id[1]==0))
                                                        //    $display("LEE: operand%d , %h\n", transaction[0], strm_operation[0].operands[transaction[0]] ) ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm0_data        <= strm_operation[0].operands[transaction[0]]  ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm0_data_mask   <= 0  ;
                                                        
                                                        transaction[0] = transaction[0] + 1;
                                                        
                                                    end
                                                else
                                                    begin
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 0  ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm0_cntl        <= 0  ;         //Passing the instruction to the system interface
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm0_data        <= 0  ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm0_data_mask   <= 0  ;
                                                    end
                                            end
           
                                        drv2lane[0].get(strm_operation[0])  ;  //Removing the instruction from generator mailbox
                                        
                                    end  // while
                                    // processed sequence, acknowledge generator for new sequence
                                    $display("@%0t : INFO: {%d,%d} Completed driving stream 0 sequence", $time, Id[0], Id[1] );
                                end
                        else
                            begin 
                                @(vSysLane2PeArray.cb_test);
                                vSysLane2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 0  ;
                            end  // if
                    end  // forever
            end
            begin
                forever
                    begin
                        if ( drv2lane[1].num() != 0 )
                            begin
                                while(drv2lane[1].num() != 0)
                                    begin
                                        drv2lane[1].peek(strm_operation[1]);                                                //Taking the instruction from generator 
           
                                        while (transaction[1] < strm_operation[1].numberOfOperands)
                                            begin
                                                @(vSysLane2PeArray.cb_test);
           
                                                if (vSysLane2PeArray.cb_test.pe__std__lane_strm1_ready) 
                                                    begin
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 1  ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm1_cntl        <= ((transaction[1] == 0) && (transaction[1] == (strm_operation[1].numberOfOperands-1))) ?  `COMMON_STD_INTF_CNTL_SOM_EOM     :
                                                                                                                    ( transaction[1] == 0                                                           ) ?  `COMMON_STD_INTF_CNTL_SOM         :
                                                                                                                    ( transaction[1] == (strm_operation[1].numberOfOperands-1)                          ) ?  `COMMON_STD_INTF_CNTL_EOM         :
                                                                                                                                                                                                         `COMMON_STD_INTF_CNTL_MOM         ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm1_data        <= strm_operation[1].operands[transaction[1]]  ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm1_data_mask   <= 0  ;
                                                        
                                                        transaction[1] = transaction[1] + 1;
                                                        
                                                    end
                                                else
                                                    begin
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 0  ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm1_cntl        <= 0  ;         //Passing the instruction to the system interface
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm1_data        <= 0  ;
                                                        vSysLane2PeArray.cb_test.std__pe__lane_strm1_data_mask   <= 0  ;
                                                    end
                                            end
           
                                        drv2lane[1].get(strm_operation[1])  ;  //Removing the instruction from generator mailbox
                                        
                                    end  // while
                                    // processed sequence, acknowledge generator for new sequence
                                    $display("@%0t : INFO: {%d,%d} Completed driving stream 1 sequence", $time, Id[0], Id[1] );
                                end
                        else
                            begin 
                                @(vSysLane2PeArray.cb_test);
                                vSysLane2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 0  ;
                            end  // if
                    end  // forever
            end
        join
    endtask

    task run_req();                                        //This task checks the busy signal and asserts/desserts the request signal.
        repeat (20)                                        //If busy is high, then request should remain low and if busy is low then request goes high.
            begin
                vSysLane2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 0  ;
                vSysLane2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 0  ;
                @(vSysLane2PeArray.cb_test);
            end
    endtask

endclass
