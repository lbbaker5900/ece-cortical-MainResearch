/*********************************************************************************************
    File name   : mem_checker.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    Email       : lbbaker@ncsu.edu
    
    Description : Checks for writes to memory
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

class mem_checker;
    
    int       Id [2]        ; // PE, Lane, Stream
    mailbox   drv2memP      ;
    event     drv2memP_ack  ;
    event     finished      ;

    base_operation sys_operation;

    vDma2Mem_T vP_mem ;

    //----------------------------------------------------------------------------------------------------
    //
    int write_address    ; // keep track of incremental addresses
    int transactionCount ;

    int i=0,j=0;
    int found = 0;

    function new (
                  input int          Id[2]        ,
                  input vDma2Mem_T   vP_mem       ,
                  input mailbox      drv2memP     ,
                  input event        drv2memP_ack );

        this.Id           = Id            ;
        this.vP_mem       = vP_mem        ;
        this.drv2memP     = drv2memP      ;
        this.drv2memP_ack = drv2memP_ack  ;
    endfunction

    task run (); 

        sys_operation=new();


        forever 
            begin
                if ( drv2memP.num() != 0 )
                    begin
                        //$display ($time,":%s:%0d:: INFO:MEM_CHECKER :: Operation driven for {%02d,%02d}", `__FILE__, `__LINE__, Id[0], Id[1]);
                        drv2memP.peek(sys_operation);   //Taking the transaction from the driver mailbox
                        //$display("@%0t:%s:%0d: LEE: Received FP MAC operation from driver: {%0d,%0d} with expected result of %f, %f <> %f written to address %h\n", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, sys_operation.destinationAddress[0]);
                        //while(~this.finished.triggered)
                        // waiting for the event doesnt seem to work????

                        write_address = sys_operation.destinationAddress[0][`PE_CHIPLET_ADDRESS_RANGE ] ; 
                        transactionCount = 0 ;  // if there are multiple writes to memory

                        found = 0;
                        while(found == 0)
                            begin
                                @(vP_mem.cb);
                                if (vP_mem.cb.dma__memc__write_valid)
                                    begin
                                        if (sys_operation.OpCode == `STREAMING_OP_CNTL_OPERATION_FP_MAC )
                                            begin
                                                // FP MAC has only one result written to memory
                                                found = 1 ;
                                      
                                                // FIXME : check for floating point within a tolerance
                                                if (($bitstoshortreal(vP_mem.cb.dma__memc__write_data) < sys_operation.resultLow) || ($bitstoshortreal(vP_mem.cb.dma__memc__write_data) > sys_operation.resultHigh))
                                                    $display ($time,": ERROR:MEM_CHECKER :: incorrect result data for {%d,%d}: expected %f, observed %f\n", Id[0], Id[1], sys_operation.result, $bitstoshortreal(vP_mem.cb.dma__memc__write_data));
                                                else
                                                    $display ($time,":%s:%0d: INFO:PASS:MEM_CHECKER :: Correct result written to memory {%d,%d} : Hex : %h, FP : %f\n", `__FILE__, `__LINE__, Id[0], Id[1], vP_mem.cb.dma__memc__write_data, $bitstoshortreal(vP_mem.cb.dma__memc__write_data));
                                      
                                                // check address
                                                if (vP_mem.cb.dma__memc__write_address != sys_operation.destinationAddress[0][`PE_CHIPLET_ADDRESS_RANGE ]) 
                                                    $display ($time,":%s:%0d: ERROR:MEM_CHECKER :: incorrect address for {%d,%d}: expected %h, observed %h\n", `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.destinationAddress[0][`PE_CHIPLET_ADDRESS_RANGE ], vP_mem.cb.dma__memc__write_address);
                                                else
                                                    $display ($time,":%s:%0d:: INFO:PASS:MEM_CHECKER :: Correct address for result {%d,%d} : Hex : %h\n", `__FILE__, `__LINE__, Id[0], Id[1], vP_mem.cb.dma__memc__write_address);
                                      
                                                -> this.finished ;
                                            end
                                        else if (sys_operation.OpCode == `STREAMING_OP_CNTL_OPERATION_NOP )
                                            begin
                                                // NOP means we are copying N operands to memory
                                      
                                                if (vP_mem.cb.dma__memc__write_data != sys_operation.operands[0][transactionCount])
                                                    $display ($time,":%s:%0d: ERROR:MEM_CHECKER :: incorrect data for {%d,%d}: transaction %6d expected %h, observed %h\n", `__FILE__, `__LINE__, Id[0], Id[1], transactionCount, sys_operation.operands[0][transactionCount], vP_mem.cb.dma__memc__write_data);
                                      
                                                // check address
                                                if (vP_mem.cb.dma__memc__write_address !=  write_address) 
                                                    $display ($time,":%s:%0d: ERROR:MEM_CHECKER :: incorrect address for {%d,%d}: expected %h, observed %h\n", `__FILE__, `__LINE__, Id[0], Id[1], write_address, vP_mem.cb.dma__memc__write_address);

                                                if (sys_operation.numberOfOperands == (transactionCount+1))
                                                    begin
                                                        $display ($time,":%s:%0d: INFO:PASS:MEM_CHECKER :: Correct data written to memory {%d,%d} starting at address : %h\n", `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.destinationAddress[0][`PE_CHIPLET_ADDRESS_RANGE ]);

                                                        found = 1 ;
                                                        -> this.finished ;
                                                    end
                                                //$display ($time,": LEE:MEM_CHECKER :: data for {%d,%d}: transaction %6d of %6d,  expected %h, observed %h\n", Id[0], Id[1], transactionCount, sys_operation.numberOfOperands, sys_operation.operands[0][transactionCount], vP_mem.cb.dma__memc__write_data);

                                                write_address    = write_address    + 1 ;
                                                transactionCount = transactionCount + 1 ;
                                            end
                                    end
                            end

                        -> drv2memP_ack;
                        drv2memP.get(sys_operation);   //Remove the transaction from the driver mailbox
                    end
                else
                    begin
                         @(vP_mem.cb);
                    end
 
            end
    endtask


endclass
