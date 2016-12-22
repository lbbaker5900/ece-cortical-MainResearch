/*********************************************************************************************
    File name   : regFile_driver.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Dec 2016
    Email       : lbbaker@ncsu.edu
    
    Description : Drives the register file ports into the streaming Ops controller
                  FIXME : not required once we get the SIMD path working
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

class regFile_driver;
    
    int       Id [2]        ; // PE
    mailbox   gen2rfP      ;
    event     gen2rfP_ack  ;
    event     finished      ;

    base_operation sys_operation;

    vRegFileScalarDrv2stOpCntl_T  vP_srf ;
    vRegFileLaneDrv2stOpCntl_T    vP_vrf ;

    int i=0,j=0;
    int found = 0;

    function new (
                  input int                             Id[2]         ,
                  input vRegFileScalarDrv2stOpCntl_T    vP_srf        ,
                  input vRegFileLaneDrv2stOpCntl_T      vP_vrf        ,
                  input mailbox                         gen2rfP       ,
                  input event                           gen2rfP_ack ) ;

        this.Id           = Id            ;
        this.vP_srf       = vP_srf        ;
        this.vP_vrf       = vP_vrf        ;
        this.gen2rfP      = gen2rfP       ;
        this.gen2rfP_ack  = gen2rfP_ack   ;
    endfunction

    task run (); 

        sys_operation=new();

        forever 
            begin
                if ( gen2rfP.num() != 0 )
                    begin
                        $display ($time,": INFO:REGFILE DRIVER :: Operation received for {%02d,%02d}", Id[0], Id[1]);
                        gen2rfP.peek(sys_operation);   //Taking the transaction from the generator mailbox
                        //$display("@%0t LEE: Received FP MAC operation from driver: {%0d,%0d} with expected result of %f, %f <> %f\n", $time,Id[0], Id[1], sys_operation.result, sys_operation.resultHigh, sys_operation.resultLow, );
/*
                        vP_srf.rs0 = {32{1'b1}};
                        vP_srf.rs1 = {32{1'b1}};
                        //while(~this.finished.triggered)
                        // waiting for the event doesnt seem to work????
                        while(found == 0)
                            begin
                                @(vP_vrf.cb);
                                if (vP_vrf.cb.dma__memc__write_valid)
                                    begin
                                        //$display ($time,": INFO:PASS:MEM_CHECKER :: Correct value Writen to memory {%d,%d} : Hex : %h, FP : %f\n", Id[0], Id[1], vP_vrf.cb.dma__memc__write_data, $bitstoshortreal(vP_vrf.cb.dma__memc__write_data));
                                        found = 1 ;
                                        // check for floating point within a tolerance
                                        // FIXME:
                                        if (($bitstoshortreal(vP_vrf.cb.dma__memc__write_data) > sys_operation.resultLow) && ($bitstoshortreal(vP_vrf.cb.dma__memc__write_data) < sys_operation.resultHigh))
                                            $display ($time,": ERROR:MEM_CHECKER :: incorrect result data for {%d,%d}: expected %f, observed %f\n", Id[0], Id[1], sys_operation.result, $bitstoshortreal(vP_vrf.cb.dma__memc__write_data));
                                        else
                                            $display ($time,": INFO:PASS:MEM_CHECKER :: Correct result writen to memory {%d,%d} : Hex : %h, FP : %f\n", Id[0], Id[1], vP_vrf.cb.dma__memc__write_data, $bitstoshortreal(vP_vrf.cb.dma__memc__write_data));

                                        -> this.finished ;
                                    end
                            end
*/
                        gen2rfP.get(sys_operation);   //Remove the transaction from the driver mailbox
                        -> gen2rfP_ack;
                        $display ($time,": INFO:REGFILE DRIVER :: Operation driven for {%02d,%02d}", Id[0], Id[1]);
                    end
                else
                    begin
                         @(vP_vrf.cb_out);
                    end
 
            end
    endtask


endclass
