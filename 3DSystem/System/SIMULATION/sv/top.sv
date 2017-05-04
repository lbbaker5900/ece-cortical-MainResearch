/*********************************************************************************************
    File name   : top.sv
    Author      : Lee B Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Dec 2016
    Email       : lbbaker@ncsu.edu
    
    Description : This module is the top level. It contains the connections to and from the 
                  management layer, pe's and internal probe interfaces.
*********************************************************************************************/

`timescale 1ns/10ps

`include "../../../PEArray/SIMULATION/common/TB_common.vh"
`include "common.vh"
`include "stack_interface.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "manager_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

import virtual_interface::*;

module top;



    // system clock and reset
    logic reset_poweron       ;
    logic clk    =  0 ;

    always #5ns clk=~clk;

    initial begin
        reset_poweron            = 1;
        #100ns reset_poweron     = 0;
    end

    //----------------------------------------------------------------------------------------------------
    // Instantiate an interface for every pe/lane/stream pair
    // Downstream
    //                              pe  lane
    st_gen_ifc      GenStackBus            [`PE_ARRAY_NUM_OF_PE]                        (.clk                 ( clk           ));  
    std_oob_ifc     DownstreamStackBusOOB  [`PE_ARRAY_NUM_OF_PE]                        (.clk_oob             ( clk           ));  
    std_lane_ifc    DownstreamStackBusLane [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] (.clk_lane            ( clk           ));  // [64] shorthand for [0:63] ....
    stu_ifc         UpstreamStackBus       [`PE_ARRAY_NUM_OF_PE]                        (.clk                 ( clk           ));  



    //----------------------------------------------------------------------------------------------------
    // Probe interface(s)
    //
    //----------------------------------------------------------------------------------------------------
    // Write Memory probe
    pe_dma2mem_ifc    Dma2Mem      [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] (clk);  // shorthand for [0:63] ....

    //
    //----------------------------------------------------------------------------------------------------
    // local NoC interfaces
    locl_to_noc_ifc   LocalToNocIfc        [`MGR_ARRAY_NUM_OF_MGR] (clk); 
    locl_from_noc_ifc LocalFromNocIfc      [`MGR_ARRAY_NUM_OF_MGR] (clk); 
/*
    mailbox           mgr2noc_p            [`MGR_ARRAY_NUM_OF_MGR]      ;  // capture packets sent by manager to NoC
    mailbox           noc2mgr_p            [`MGR_ARRAY_NUM_OF_MGR]      ;  // capture packets received by manager from NoC
*/

    //----------------------------------------------------------------------------------------------------
    // Probe interface(s) for forcing
    //
    // Regfile interface from SIMD
    regFileScalar2stOpCntl_ifc  RegFileScalar2StOpCntl    [`PE_ARRAY_NUM_OF_PE]                        (clk);
    regFileLane2stOpCntl_ifc    RegFileLane2StOpCntl      [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] (clk);

    // Load/Store interface from SIMD
    loadStore2memCntl_ifc       LoadStore2memCntl         [`PE_ARRAY_NUM_OF_PE]                        (clk);

    //----------------------------------------------------------------------------------------------------
    // System
    //

    system system_inst (
       
        .clk               ( clk       ),
        .reset_poweron     ( reset_poweron     )
    );


    
    //----------------------------------------------------------------------------------------------------
    // Testbench
    //
        test  ti  (
                   .GenStackBus                ( GenStackBus               ) ,  // array of General Stack signals
                   .DownstreamStackBusOOB      ( DownstreamStackBusOOB     ) ,  // array of downstream stack bus OOB interfaces to each PE
                   .DownstreamStackBusLane     ( DownstreamStackBusLane    ) ,  // array of interfaces for each downstream pe/lane stack bus
                   .UpstreamStackBus           ( UpstreamStackBus          ) ,  // array of upstream stack bus OOB interfaces to each PE

                   .Dma2Mem                    ( Dma2Mem                   ) ,  // array of monitor probes for the DMA to Memory interface for each PE/Lane
                   .LocalToNocIfc              ( LocalToNocIfc             ) ,  // array of probes to monitor Manager NoC packets sent to NoC and received from NoC
                   .LocalFromNocIfc            ( LocalFromNocIfc           ) ,  // 
                   // to debug the NoC, we will predict what packets should be received and sent to the NoC
                   //.mgr2noc_p                  ( mgr2noc_p                 ) ,  // What NoC packets has a manager sent to the NoC
                   //.noc2mgr_p                  ( noc2mgr_p                 ) ,  // What NoC packets has a manager received from the NoC

                   .RegFileScalar2StOpCntl     ( RegFileScalar2StOpCntl    ) ,  // array of driver probes for the RegFile Scalar registers to stOp Controller for each PE
                   .RegFileLane2StOpCntl       ( RegFileLane2StOpCntl      ) ,  // array of driver probes for the RegFile Vector registers to stOp Controller for each PE/Lane
                   .LoadStore2memCntl          ( LoadStore2memCntl         ) ,  // array of driver probes for the Load/Store from SIMD to memory controller for each PE

                   .reset                      ( reset_poweron             ) 
                  );

    //-------------------------------------------------------------------------------------------
    // General system connectivity
    //  - loop thisSync to allSync from st_gen_ifc
    `include "pe_sys_general_connections.vh"

    //----------------------------------------------------------------------------------------------------
    // Connect interfaces
    //
      
    // General System Interface
    //  - connect general signals inside manager from st_gen_ifc
    `include "TB_system_general_assignments.vh"
    
    // Downstream Stack bus OOB Interface
    //  - connect OOB signals inside manager from std_oob_ifc
    `include "TB_system_stack_bus_downstream_oob_assignments.vh"
    
    // Downstream Stack bus Interface
    //  - connect Lane signals inside manager from std_lane_ifc
    `include "TB_system_stack_bus_downstream_assignments.vh"
    
    // Upstream Stack bus Interface
    //  - connect upstream signals inside manager from stu_ifc
    `include "TB_system_stack_bus_upstream_assignments.vh"

    //----------------------------------------------------------------------------------------------------
    // Probes
    //
    // DMA to memory interface for result check
    genvar pe;
    genvar lane;
    generate
       for (pe=0; pe<`PE_ARRAY_NUM_OF_PE; pe=pe+1)
           begin
               for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane=lane+1)
                   begin
                       // only observe stream 0
                       assign Dma2Mem[pe][lane].dma__memc__write_valid      = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__write_valid0        ;
                       assign Dma2Mem[pe][lane].dma__memc__write_address    = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__write_address0      ;
                       assign Dma2Mem[pe][lane].dma__memc__write_data       = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__write_data0         ;
                       assign Dma2Mem[pe][lane].dma__memc__read_valid       = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__read_valid0         ;
                       assign Dma2Mem[pe][lane].dma__memc__read_address     = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__read_address0       ;
                       assign Dma2Mem[pe][lane].dma__memc__read_pause       = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.dma__memc__read_pause0         ;

                       assign Dma2Mem[pe][lane].memc__dma__write_ready      = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.memc__dma__write_ready0        ;
                       assign Dma2Mem[pe][lane].memc__dma__read_data        = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.memc__dma__read_data0          ;
                       assign Dma2Mem[pe][lane].memc__dma__read_data_valid  = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.memc__dma__read_data_valid0    ;
                       assign Dma2Mem[pe][lane].memc__dma__read_ready       = system_inst.pe_array_inst.pe_inst[pe].pe.stOp_lane[lane].streamingOps_datapath.dma_cont.memc__dma__read_ready0         ;
                   end
           end
    endgenerate

    genvar mgr;
    generate
       for (mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1)
           begin
             // only observe stream 0
             assign LocalToNocIfc[mgr].locl__noc__dp_valid      = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.locl__noc__dp_valid   ;
             assign LocalToNocIfc[mgr].noc__locl__dp_ready      = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.noc__locl__dp_ready   ;
             assign LocalToNocIfc[mgr].locl__noc__dp_cntl       = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.locl__noc__dp_cntl    ;
             assign LocalToNocIfc[mgr].locl__noc__dp_type       = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.locl__noc__dp_type    ;
             assign LocalToNocIfc[mgr].locl__noc__dp_ptype      = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.locl__noc__dp_ptype   ;
             assign LocalToNocIfc[mgr].locl__noc__dp_desttype   = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.locl__noc__dp_desttype;
             assign LocalToNocIfc[mgr].locl__noc__dp_pvalid     = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.locl__noc__dp_pvalid  ;
             assign LocalToNocIfc[mgr].locl__noc__dp_data       = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.locl__noc__dp_data    ;

             assign LocalFromNocIfc[mgr].noc__locl__dp_valid    = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.noc__locl__dp_valid   ;
             assign LocalFromNocIfc[mgr].locl__noc__dp_ready    = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.locl__noc__dp_ready   ;
             assign LocalFromNocIfc[mgr].noc__locl__dp_cntl     = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.noc__locl__dp_cntl    ;
             assign LocalFromNocIfc[mgr].noc__locl__dp_type     = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.noc__locl__dp_type    ;
             assign LocalFromNocIfc[mgr].noc__locl__dp_ptype    = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.noc__locl__dp_ptype   ;
             assign LocalFromNocIfc[mgr].noc__locl__dp_data     = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.noc__locl__dp_data    ;
             assign LocalFromNocIfc[mgr].noc__locl__dp_mgrId    = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.noc__locl__dp_mgrId   ;
           end
    endgenerate

    //----------------------------------------------------------------------------------------------------
    // Forces
    //
    // connect regFile interfaces to SIMD regFile to streaming Ops controller interface
    `ifdef TB_ENABLE_REGFILE_DRIVER
    generate
       for (pe=0; pe<`PE_ARRAY_NUM_OF_PE; pe=pe+1)
           begin
               assign RegFileScalar2StOpCntl[pe].ready                  =  system_inst.pe_array_inst.pe_inst[pe].pe.pe__sys__ready    ;  //.TB_regFileScalarDrv2stOpCntl
               assign RegFileScalar2StOpCntl[pe].complete               =  system_inst.pe_array_inst.pe_inst[pe].pe.pe__sys__complete ;  //.TB_regFileScalarDrv2stOpCntl
               assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__rs0      =  RegFileScalar2StOpCntl[pe].rs0                 ;  //.TB_regFileScalarDrv2stOpCntl
               assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__rs1      =  RegFileScalar2StOpCntl[pe].rs1                 ;  //.TB_regFileScalarDrv2stOpCntl
               for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane=lane+1)
                   begin
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__lane_r128[lane] =   RegFileLane2StOpCntl[pe][lane].r128 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__lane_r129[lane] =   RegFileLane2StOpCntl[pe][lane].r129 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__lane_r130[lane] =   RegFileLane2StOpCntl[pe][lane].r130 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__lane_r131[lane] =   RegFileLane2StOpCntl[pe][lane].r131 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__lane_r132[lane] =   RegFileLane2StOpCntl[pe][lane].r132 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__lane_r133[lane] =   RegFileLane2StOpCntl[pe][lane].r133 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__lane_r134[lane] =   RegFileLane2StOpCntl[pe][lane].r134 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.simd__cntl__lane_r135[lane] =   RegFileLane2StOpCntl[pe][lane].r135 ;  //.TB_regFileLaneDrv2stOpCntl
                   end
           end
    endgenerate
    `endif

    // connect Load/Store interface between SIMD and memory Controller
    generate
       for (pe=0; pe<`PE_ARRAY_NUM_OF_PE; pe=pe+1)
           begin
               assign system_inst.pe_array_inst.pe_inst[pe].pe.ldst__memc__request        =   LoadStore2memCntl [pe].ldst__memc__request       ;
               assign system_inst.pe_array_inst.pe_inst[pe].pe.ldst__memc__released       =   LoadStore2memCntl [pe].ldst__memc__released      ;
               assign system_inst.pe_array_inst.pe_inst[pe].pe.ldst__memc__write_address  =   LoadStore2memCntl [pe].ldst__memc__write_address ;
               assign system_inst.pe_array_inst.pe_inst[pe].pe.ldst__memc__write_data     =   LoadStore2memCntl [pe].ldst__memc__write_data    ;
               assign system_inst.pe_array_inst.pe_inst[pe].pe.ldst__memc__read_address   =   LoadStore2memCntl [pe].ldst__memc__read_address  ;
               assign system_inst.pe_array_inst.pe_inst[pe].pe.ldst__memc__write_valid    =   LoadStore2memCntl [pe].ldst__memc__write_valid   ;
               assign system_inst.pe_array_inst.pe_inst[pe].pe.ldst__memc__read_valid     =   LoadStore2memCntl [pe].ldst__memc__read_valid    ;
           end
    endgenerate

    generate
       for (pe=0; pe<`PE_ARRAY_NUM_OF_PE; pe=pe+1)
           begin
             initial
               begin
                 force DownstreamStackBusOOB[pe].sys__pe__allSynchronized  = 1  ;
               end
           end
    endgenerate


    /*
    dut_probe_dma2mem probe_dma2mem(
             `include "TB_probe_dma2mem_connection.vh" 
                               );
    */
    //----------------------------------------------------------------------------------------------------
 


    //----------------------------------------------------------------------------------------------------
    // Testbench - random forces
    //

    /*
    int numOfTypes;
  
    initial
        begin
             numOfTypes = 20;
      
            @(posedge clk);
            `include "test_simd_init.vh"
            @(posedge clk);
            `include "test_std_std_fpmac_to_mem_init_step1.vh"
        end
     */

endmodule : top
