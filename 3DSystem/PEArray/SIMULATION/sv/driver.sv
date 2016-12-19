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

    mailbox   drv2memP         ;
    event     drv2memP_ack     ;

    base_operation sys_operation;

    // FIXME : doesnt need all interfaces
    vSys2PeArray_T vSys2PeArray ;

    function new (
                  input int                  Id[2]          ,
                  input mailbox              gen2drv        ,                  //Retrieving mailboxes and virtual system interface.
                  input event                gen2drv_ack    ,
                  input event                new_operation  ,
                  input vSys2PeArray_T       vSys2PeArray   ,
                  input mailbox              drv2memP       ,
                  input event                drv2memP_ack   );

        this.Id              = Id            ;
        this.gen2drv         = gen2drv       ;
        this.gen2drv_ack     = gen2drv_ack   ;
        this.new_operation   = new_operation ;
        this.vSys2PeArray    = vSys2PeArray  ;
        this.drv2memP        = drv2memP      ;
        this.drv2memP_ack    = drv2memP_ack  ;
    endfunction

    int transaction = 0;
    task run();
        forever
            begin
                if ( gen2drv.num() != 0 )
                    begin
                        //$display("@%0t LEE: {%d,%d} number of operations : %0d", $time, Id[0], Id[1], gen2drv.num() );
                
                        while(gen2drv.num() != 0)
                            begin
                                gen2drv.peek(sys_operation);                                                //Taking the instruction from generator 
                                //if ((Id[0] == 0) && (Id[1] == 1))  // REMEMBER: comment out both lines
                                //    $display("@%0t LEE: Driver {%d,%d} received transaction id : %0d with %d operands", $time, Id[0], Id[1], sys_operation.id, sys_operation.numberOfOperands);
                                while (transaction < sys_operation.numberOfOperands)
                                    begin
                                        @(vSys2PeArray.cb_test);
// FIXME need to fork-join streams

                                        if ((vSys2PeArray.cb_test.pe__std__lane_strm0_ready) && (vSys2PeArray.cb_test.pe__std__lane_strm1_ready))
                                            begin
                                                //$display("@%0t LEE: Driving stream0 transaction %d with value : %0d", $time,transaction, sys_operation.operands[0][transaction]);
                                                vSys2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 1  ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm0_cntl        <= ((transaction == 0) && (transaction == (sys_operation.numberOfOperands-1))) ?  `COMMON_STD_INTF_CNTL_SOM_EOM     :
                                                                                                        ( transaction == 0                                                        ) ?  `COMMON_STD_INTF_CNTL_SOM         :
                                                                                                        ( transaction == (sys_operation.numberOfOperands-1)                       ) ?  `COMMON_STD_INTF_CNTL_EOM         :
                                                                                                                                                                                       `COMMON_STD_INTF_CNTL_MOM         ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm0_data        <= sys_operation.operands[0][transaction]  ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm0_data_mask   <= 0  ;
                                                
                                                //$display("@%0t LEE: Driving stream1 transaction %d with value : %0d", $time,transaction, sys_operation.operands[1][transaction]);
                                                vSys2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 1  ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm1_cntl        <= ((transaction == 0) && (transaction == (sys_operation.numberOfOperands-1))) ?  `COMMON_STD_INTF_CNTL_SOM_EOM     :
                                                                                                        ( transaction == 0                                                        ) ?  `COMMON_STD_INTF_CNTL_SOM         :
                                                                                                        ( transaction == (sys_operation.numberOfOperands-1)                       ) ?  `COMMON_STD_INTF_CNTL_EOM         :
                                                                                                                                                                                       `COMMON_STD_INTF_CNTL_MOM         ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm1_data        <= sys_operation.operands[1][transaction]  ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm1_data_mask   <= 0  ;

                                                transaction = transaction + 1;
                                                
                                            end
                                        else
                                            begin
                                                vSys2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 0  ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm0_cntl        <= 0  ;         //Passing the instruction to the system interface
                                                vSys2PeArray.cb_test.std__pe__lane_strm0_data        <= 0  ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm0_data_mask   <= 0  ;
                                  
                                                vSys2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 0  ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm1_cntl        <= 0  ;         //Passing the instruction to the system interface
                                                vSys2PeArray.cb_test.std__pe__lane_strm1_data        <= 0  ;
                                                vSys2PeArray.cb_test.std__pe__lane_strm1_data_mask   <= 0  ;
                                            end
                                    end

                                // put operations into golden mailbox
                                drv2memP.put(sys_operation) ;  //Putting the instruction into the golden model mailbox                                              
                                @drv2memP_ack               ;

                                gen2drv.get(sys_operation)  ;  //Removing the instruction from generator mailbox
                                
                            end  // while
                            // processed sequence, acknowledge generator for new sequence
                            $display("@%0t : INFO: {%d,%d} Completed driving sequence", $time, Id[0], Id[1] );
                            -> gen2drv_ack;
                        end
                else
                    begin 
                        @(vSys2PeArray.cb_test);
                        //if ((Id[0] == 0) && (Id[1] == 0))
                        //    $display("@%0t LEE: Driver {%d,%d} driving NULL", $time, Id[0], Id[1]);
                        vSys2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 0  ;
                        vSys2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 0  ;
                    end  // if
            end  // forever
    endtask

    task run_req();                                        //This task checks the busy signal and asserts/desserts the request signal.
        repeat (20)                                        //If busy is high, then request should remain low and if busy is low then request goes high.
            begin
                vSys2PeArray.cb_test.std__pe__lane_strm0_data_valid  <= 0  ;
                vSys2PeArray.cb_test.std__pe__lane_strm1_data_valid  <= 0  ;
                @(vSys2PeArray.cb_test);
            end
    endtask

endclass
