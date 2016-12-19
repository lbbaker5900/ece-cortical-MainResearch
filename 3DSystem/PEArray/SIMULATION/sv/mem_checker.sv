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

    // FIXME : doesnt need all interfaces
    vDma2Mem_T vP_mem ;

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
                        $display ($time,": INFO:MEM_CHECKER :: Operation driven for {%02d,%02d}", Id[0], Id[1]);
                        drv2memP.peek(sys_operation);   //Taking the transaction from the driver mailbox
                        -> drv2memP_ack;
                        //while(~this.finished.triggered)
                        // waiting for the event doesnt seem to work????
                        while(found == 0)
                            begin
                                @(vP_mem.cb);
                                if (vP_mem.cb.dma__memc__write_valid)
                                    begin
                                        $display ($time,": INFO:MEM_CHECKER :: Write to memory {%d,%d} : Hex : %h, FP : %f\n", Id[0], Id[1], vP_mem.cb.dma__memc__write_data, $bitstoshortreal(vP_mem.cb.dma__memc__write_data));
                                        found = 1 ;
                                        // check for floating point within a tolerance
                                        // FIXME:
                                        if (($bitstoshortreal(vP_mem.cb.dma__memc__write_data) > sys_operation.resultLow) && ($bitstoshortreal(vP_mem.cb.dma__memc__write_data) < sys_operation.resultHigh))
                                            $display ($time,": ERROR:MEM_CHECKER :: incorrect result data for {%d,%d}: expected %f, observed %f\n", Id[0], Id[1], sys_operation.result, $bitstoshortreal(vP_mem.cb.dma__memc__write_data));
                                        -> this.finished ;
                                    end
                            end
                        drv2memP.get(sys_operation);   //Remove the transaction from the driver mailbox
                    end
                else
                    begin
                         @(vP_mem.cb);
                    end
 
            end
    endtask


endclass
