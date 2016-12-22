/*********************************************************************************************
    File name   : loadStore_driver.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Dec 2016
    Email       : lbbaker@ncsu.edu
    
    Description : Drives the load/store ports from the SIMD into the memory controller
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

class loadStore_driver;
    
    int       Id [2]         ; // PE
    //mailbox   gen2ldstP      ;
    //event     gen2ldstP_ack  ;
    event     finished       ;

    base_operation sys_operation;

    vLoadStoreDrv2memCntl_T  vP_ldst ;

    int i=0,j=0;
    int found = 0;

    function new (
                  input int                             Id[2]           ,
                  input vLoadStoreDrv2memCntl_T         vP_ldst         );
//                  input mailbox                         gen2ldstP       ,
//                  input event                           gen2ldstP_ack ) ;

        this.Id             = Id              ;
        this.vP_ldst        = vP_ldst         ;
        //this.gen2ldstP      = gen2ldstP       ;
        //this.gen2ldstP_ack  = gen2ldstP_ack   ;
    endfunction

    task run (); 

        sys_operation=new();

        forever 
            begin
                //$display ($time,": INFO:LDST DRIVER :: Initialize load/store for {%02d,%02d}", Id[0], Id[1]);
                @(vP_ldst.cb_out);
/*
                if ( gen2ldstP.num() != 0 )
                    begin
                        $display ($time,": INFO:LDST DRIVER :: Operation received for {%02d,%02d}", Id[0], Id[1]);
                        gen2ldstP.peek(sys_operation);   //Taking the transaction from the generator mailbox
                        gen2ldstP.get(sys_operation);   //Remove the transaction from the driver mailbox
                        -> gen2ldstP_ack;
                        $display ($time,": INFO:LDST DRIVER :: Operation driven for {%02d,%02d}", Id[0], Id[1]);
                    end
                else
                    begin
                         @(vP_ldst.cb_out);
                    end
 */
            end
    endtask


endclass
