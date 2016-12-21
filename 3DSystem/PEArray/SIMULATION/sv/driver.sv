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

    mailbox   drv2lane []      ;  // create a mailbox for each stream driver
    int transaction    []      ;

    mailbox   drv2memP         ;
    event     drv2memP_ack     ;

    base_operation   sys_operation      ;
    stream_operation tmp_strm_operation ;
    stream_operation strm_operation [] ;

    // FIXME : doesnt need all interfaces
    vSysLane2PeArray_T vSysLane2PeArray ;

    function new (
                  input int                  Id[2]              ,
                  input mailbox              gen2drv            ,                  //Retrieving mailboxes and virtual system interface.
                  input event                gen2drv_ack        ,
                  input event                new_operation      ,
                  input vSysLane2PeArray_T   vSysLane2PeArray   ,
                  input mailbox              drv2memP           ,
                  input event                drv2memP_ack       );

        this.Id                  = Id                         ;
        this.gen2drv             = gen2drv                    ;
        this.gen2drv_ack         = gen2drv_ack                ;
        this.new_operation       = new_operation              ;
        this.vSysLane2PeArray    = vSysLane2PeArray           ;
        this.drv2memP            = drv2memP                   ;
        this.drv2memP_ack        = drv2memP_ack               ;
        this.drv2lane            = new[`PE_NUM_OF_STREAMS  ]  ;
        for (int i=0; i<drv2lane.size(); i++)
            begin
                this.drv2lane[i]            = new             ;
            end
        this.strm_operation      = new[`PE_NUM_OF_STREAMS  ]  ;
        this.transaction         = new[`PE_NUM_OF_STREAMS  ]  ;
        //for (int i=0; i<transaction.size(); i++)
        //    begin
        //        this.transaction[i]   = new(0)                ;
        //    end
    endfunction

    task run();

        // Spawn 3 processes:
        // - first receives operations from the generator and splits it into two stream operations
        // - the other two look for the stream operation from the first process and drive it onto there corresponding stream 
        fork
            begin
                forever
                    begin
                        // take the transaction from the generator and split it into two streams
                        @(vSysLane2PeArray.cb_test);
                        //$display("@%0t : LEE: {%d,%d} Check mailbox", $time, Id[0], Id[1] );
                        if ( gen2drv.num() != 0 )
                            begin
                                //$display("@%0t : LEE: {%d,%d} received system trans", $time, Id[0], Id[1] );
                                gen2drv.peek(sys_operation);                                                //Taking the instruction from generator 
                                //$display("@%0t : LEE: IDs : { %d } ", $time, sys_operation.id);
                                //$display("@%0t : LEE: IDs : { %d } ", $time, strm_operation[1].id);
                    
                                for (int i=0; i<strm_operation.size(); i++)
                                    begin
                                        tmp_strm_operation                  = new            ;
                                        tmp_strm_operation.id               = sys_operation.id               ;
                                        tmp_strm_operation.operands         = new[sys_operation.numberOfOperands](sys_operation.operands[i])      ;
                                        tmp_strm_operation.numberOfOperands = sys_operation.numberOfOperands ;
                                        //tmp_strm_operation.operands         = sys_operation.operands[i]      ;
                                        drv2lane[i].put(tmp_strm_operation)                    ;
                                    end


                                // put operations into golden mailbox
                                drv2memP.put(sys_operation) ;  //Putting the instruction into the golden model mailbox                                              
                                //$display("@%0t LEE: Send FP MAC operation to mem_checker: {%0d,%0d} with expected result of %f, %f <> %f\n", $time,Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, );
                                @drv2memP_ack               ;
             
                                gen2drv.get(sys_operation)  ;  //Removing the instruction from generator mailbox
                                -> gen2drv_ack;
                                //$display("@%0t : LEE: {%d,%d} Passed to stream drivers", $time, Id[0], Id[1] );
                                                
                            end
                    end
            end
            // FIXME : should use generate for the two following processes, but need to separate streams into separate interfaces so they can be indexed
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
