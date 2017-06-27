/*********************************************************************************************
    File name   : dram_driver.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    Email       : lbbaker@ncsu.edu
    
    Description : Drives the register file ports into the streaming Ops controller
                  FIXME : not required once we get the SIMD path working
*********************************************************************************************/

`include "TB_common.vh"
`include "common.vh"
`include "manager.vh"
`include "manager_array.vh"


import virtual_interface::*;
import operation::*;

class dram_driver;
    
    int       Id        ; // Manager


    vDiRam_T  vP_dram ;

    int i=0,j=0;
    int found = 0;

    function new (
                  input int                             Id         ,
                  input vDiRam_T                        vP_dram    ) ;

        this.Id           = Id            ;
        this.vP_dram      = vP_dram       ;
    endfunction

    task run (); 

        //----------------------------------------------------------------------------------------------------
        forever 
          begin
               @(vP_dram.cb_out);
              //------------------------------------------
              // Drive default for now
              //
              
              //$display("@%0t:%s:%0d: INFO:{%0d}: Driving WU via RegFile driver with contents of OOB packet from generator : {%0d,%0d}", $time, `__FILE__, `__LINE__, this.Id[0], oob_packet_new.Id[0], oob_packet_new.Id[1]);
              vP_dram.clk_diram_cq       <= ~vP_dram.clk_diram_cq ;
              vP_dram.phy__dfi__valid    <= 'd0       ;
              vP_dram.phy__dfi__data     <= 'd0       ;

          end
    endtask

    task reset (); 

        vP_dram.clk_diram_cq       <= 'd0       ;
        vP_dram.phy__dfi__valid    <= 'd0       ;
        vP_dram.phy__dfi__data     <= 'd0       ;
                        
    endtask


endclass
