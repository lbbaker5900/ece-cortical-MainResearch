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

    int      i=0,j=0         ;
    logic    found           ;
    logic    addressGood     ;
    logic    addressBad      ;
    logic    dataGood        ;
    logic    dataBad         ;

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
                        //$display ("@%0t::%s:%0d:: INFO:MEM_CHECKER :: Operation driven for {%02d,%02d}", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
                        drv2memP.peek(sys_operation);   //Taking the transaction from the driver mailbox
                        //$display("@%0t:%s:%0d: DEBUG: Received FP MAC operation from driver: {%0d,%0d} with expected result of %f, %f <> %f written to address %h", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, sys_operation.destinationAddress[0]);
                        //while(~this.finished.triggered)
                        // waiting for the event doesnt seem to work????

                        write_address = sys_operation.destinationAddress[0][`PE_CHIPLET_ADDRESS_RANGE ] ; 
                        transactionCount = 0 ;  // if there are multiple writes to memory

                        found         =  0;
                        addressBad    =  0;
                        dataBad       =  0;
                        
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
                                                    begin
                                                        $display ("@%0t:%s:%0d:ERROR:MEM_CHECKER :: incorrect result data for {%0d,%0d}: expected %f, observed %f", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.result, $bitstoshortreal(vP_mem.cb.dma__memc__write_data));
                                                        dataBad = 1 ;
                                                    end
                                               else 

                                                // check address
                                                if (vP_mem.cb.dma__memc__write_address != sys_operation.destinationAddress[0][`PE_CHIPLET_ADDRESS_RANGE ]) 
                                                    begin
                                                        $display ("@%0t:%s:%0d:ERROR:MEM_CHECKER :: incorrect address for {%0d,%0d}: expected %h, observed %h", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.destinationAddress[0][`PE_CHIPLET_ADDRESS_RANGE ], vP_mem.cb.dma__memc__write_address);
                                                        addressBad = 1 ;
                                                    end


                                                if (~dataBad && ~addressBad)
                                                    begin
                                                        $display ("@%0t::%s:%0d:PASS:MEM_CHECKER :: Correct result written to memory {%0d,%0d} ::Addr:%0h ::Data:Hex:%h, FP:%f", $time, `__FILE__, `__LINE__, Id[0], Id[1], vP_mem.cb.dma__memc__write_address, vP_mem.cb.dma__memc__write_data, $bitstoshortreal(vP_mem.cb.dma__memc__write_data));
                                                    end
                                                else if (~dataBad)
                                                    begin
                                                        $display ("@%0t::%s:%0d::PASS:MEM_CHECKER :: Correct result written to memory {%0d,%0d} : Hex : %h, FP : %f", $time, `__FILE__, `__LINE__, Id[0], Id[1], vP_mem.cb.dma__memc__write_data, $bitstoshortreal(vP_mem.cb.dma__memc__write_data));
                                                    end
                                                else if (~addressBad)
                                                    begin
                                                        $display ("@%0t::%s:%0d:PASS:MEM_CHECKER :: Correct address for result {%0d,%0d} : Hex : %h", $time, `__FILE__, `__LINE__, Id[0], Id[1], vP_mem.cb.dma__memc__write_address);
                                                    end


                                      
                                                -> this.finished ;
                                            end
                                        else if (sys_operation.OpCode == `STREAMING_OP_CNTL_OPERATION_NOP )
                                            begin
                                                // NOP means we are copying N operands to memory
                                      
                                                if (vP_mem.cb.dma__memc__write_data != sys_operation.operands[0][transactionCount])
                                                    $display ("@%0t:%s:%0d:ERROR:MEM_CHECKER :: incorrect data for {%0d,%0d}: transaction %0d expected %h, observed %h", $time, `__FILE__, `__LINE__, Id[0], Id[1], transactionCount, sys_operation.operands[0][transactionCount], vP_mem.cb.dma__memc__write_data);
                                      
                                                // check address
                                                if (vP_mem.cb.dma__memc__write_address !=  write_address) 
                                                    $display ("@%0t:%s:%0d:ERROR:MEM_CHECKER :: incorrect address for {%0d,%0d}: expected %h, observed %h", $time, `__FILE__, `__LINE__, Id[0], Id[1], write_address, vP_mem.cb.dma__memc__write_address);

                                                if (sys_operation.numberOfOperands == (transactionCount+1))
                                                    begin
                                                        $display ("@%0t:%s:%0d:PASS:MEM_CHECKER :: Correct data written to memory {%0d,%0d} starting at address : %h", $time, `__FILE__, `__LINE__, Id[0], Id[1], sys_operation.destinationAddress[0][`PE_CHIPLET_ADDRESS_RANGE ]);

                                                        found = 1 ;
                                                        -> this.finished ;
                                                    end
                                                //$display ("@%0t:%s:%0d:DEBUG:MEM_CHECKER :: data for {%0d,%0d}: transaction %6d of %6d,  expected %h, observed %h", $time, `__FILE__, `__LINE__, Id[0], Id[1], transactionCount, sys_operation.numberOfOperands, sys_operation.operands[0][transactionCount], vP_mem.cb.dma__memc__write_data);

                                                write_address    = write_address    + 1 ;
                                                transactionCount = transactionCount + 1 ;
                                            end
                                    end
                            end

                        $display("@%0t:%s:%0d:DEBUG: {%0d,%0d} send mem_checker ack", $time, `__FILE__, `__LINE__, Id[0], Id[1]);
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
