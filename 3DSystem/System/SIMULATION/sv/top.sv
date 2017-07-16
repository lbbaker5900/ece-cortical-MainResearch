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
`include "manager.vh"
`include "manager_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

import virtual_interface::*;

module top;



    // system clock and reset
    logic reset_poweron       ;
    logic clk    =  0 ;
    logic clk2x  =  0 ;

    always #2.5ns clk2x = ~clk2x;
    always @(posedge clk2x)
      clk = ~clk;

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
    std_lane_ifc    DownstreamStackBusLane [`PE_ARRAY_NUM_OF_PE][`PE_NUM_OF_EXEC_LANES] [`MGR_NUM_OF_STREAMS] (.clk_lane            ( clk           ));  // [64] shorthand for [0:63] ....
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

    //
    //----------------------------------------------------------------------------------------------------
    // WU Decoder to OOB
    wud_to_oob_ifc  WudToOobIfc        [`MGR_ARRAY_NUM_OF_MGR] (clk);

    //----------------------------------------------------------------------------------------------------
    // WU Decoder to Memory Read Interfaces
    //wud_to_mrc_ifc  WudToMrcIfc        [`MGR_ARRAY_NUM_OF_MGR] [`MGR_NUM_OF_STREAMS] (clk); 
    descriptor_ifc  WudToMrcIfc        [`MGR_ARRAY_NUM_OF_MGR] [`MGR_NUM_OF_STREAMS] (clk); 

    //----------------------------------------------------------------------------------------------------
    // Memory Read Controller to Stack Downstream interfaces
    mrc_to_std_ifc  MrcToStdIfc        [`MGR_ARRAY_NUM_OF_MGR] [`MGR_NUM_OF_STREAMS] (clk);

    //----------------------------------------------------------------------------------------------------
    // Probe interface(s) for forcing
    //
    // Regfile interface from SIMD
    regFileScalar2stOpCntl_ifc  RegFileScalar2StOpCntl    [`PE_ARRAY_NUM_OF_PE]                        (clk);
    regFileLane2stOpCntl_ifc    RegFileLane2StOpCntl      [`PE_ARRAY_NUM_OF_PE] [`PE_NUM_OF_EXEC_LANES] (clk);

    // Load/Store interface from SIMD
    loadStore2memCntl_ifc       LoadStore2memCntl         [`PE_ARRAY_NUM_OF_PE]                        (clk);

    //----------------------------------------------------------------------------------------------------
    // DRAM
    diram_ifc   DramIfc        [`MGR_ARRAY_NUM_OF_MGR] (.clk   ( clk  ),
                                                        .clk2x ( clk2x)
                                                       ); 

    //----------------------------------------------------------------------------------------------------
    // System
    //

    //--------------------------------------------------------------------------------
    // DFI Interface to DRAM
    //
    wire                                         clk_diram_cntl_ck   [`MGR_ARRAY_NUM_OF_MGR ] ;
    wire                                         dfi__phy__cs        [`MGR_ARRAY_NUM_OF_MGR ] ; 
    wire                                         dfi__phy__cmd1      [`MGR_ARRAY_NUM_OF_MGR ] ; 
    wire                                         dfi__phy__cmd0      [`MGR_ARRAY_NUM_OF_MGR ] ;
    wire     [`MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__bank      [`MGR_ARRAY_NUM_OF_MGR ] ;
    wire     [`MGR_DRAM_PHY_ADDRESS_RANGE     ]  dfi__phy__addr      [`MGR_ARRAY_NUM_OF_MGR ] ;
    
    wire     [`MGR_DRAM_CLK_GROUP_RANGE       ]  clk_diram_data_ck   [`MGR_ARRAY_NUM_OF_MGR ] ;
    wire     [`MGR_DRAM_INTF_RANGE            ]  dfi__phy__data      [`MGR_ARRAY_NUM_OF_MGR ] ;
    
    //--------------------------------------------------------------------------------
    // DFI Interface from DRAM
    //
    wire     [`MGR_DRAM_CLK_GROUP_RANGE       ]  clk_diram_cq        [`MGR_ARRAY_NUM_OF_MGR ] ;
    wire     [`MGR_DRAM_CLK_GROUP_RANGE       ]  phy__dfi__valid     [`MGR_ARRAY_NUM_OF_MGR ] ;
    wire     [`MGR_DRAM_INTF_RANGE            ]  phy__dfi__data      [`MGR_ARRAY_NUM_OF_MGR ] ;

    system system_inst (
       
        //--------------------------------------------------------------------------------
        // DFI Interface to DRAM
        //
        .clk_diram_cntl_ck    ( clk_diram_cntl_ck  ), 
        .dfi__phy__cs         ( dfi__phy__cs       ),
        .dfi__phy__cmd1       ( dfi__phy__cmd1     ),
        .dfi__phy__cmd0       ( dfi__phy__cmd0     ),
        .dfi__phy__addr       ( dfi__phy__addr     ),
        .dfi__phy__bank       ( dfi__phy__bank     ),
                                                   
        .clk_diram_data_ck    ( clk_diram_data_ck  ), 
        .dfi__phy__data       ( dfi__phy__data     ),

        //--------------------------------------------------------------------------------
        // DFI Interface from DRAM
        //
        .clk_diram_cq         ( clk_diram_cq       ),
        .phy__dfi__valid      ( phy__dfi__valid    ),
        .phy__dfi__data       ( phy__dfi__data     ),

        //--------------------------------------------------------------------------------
        // Clocks for SDR/DDR
        .clk_diram            ( clk                ),
        .clk_diram2x          ( clk2x              ),

        //--------------------------------------------------------------------------------
        // General
        //
        .clk                  ( clk                ),
        .reset_poweron        ( reset_poweron      )
    );


    
    //----------------------------------------------------------------------------------------------------
    // Testbench
    //
        test  ti  (
                   .GenStackBus                ( GenStackBus               ) ,  // array of General Stack signals
                   .DownstreamStackBusOOB      ( DownstreamStackBusOOB     ) ,  // array of downstream stack bus OOB interfaces to each PE
                   .DownstreamStackBusLane     ( DownstreamStackBusLane    ) ,  // array of interfaces for each downstream pe/lane stack bus
                   .UpstreamStackBus           ( UpstreamStackBus          ) ,  // array of upstream stack bus OOB interfaces to each PE

                   //
                   .Dma2Mem                    ( Dma2Mem                   ) ,  // array of monitor probes for the DMA to Memory interface for each PE/Lane

                   // Local NoC Interfaces
                   .LocalToNocIfc              ( LocalToNocIfc             ) ,  // array of probes to monitor Manager NoC packets sent to NoC and received from NoC
                   .LocalFromNocIfc            ( LocalFromNocIfc           ) ,  // 

                   // WU Decoder to OOB Downstream Interfaces
                   .WudToOobIfc                ( WudToOobIfc               ),

                   // WU Decoder to Memory Read Interfaces
                   .WudToMrcIfc                ( WudToMrcIfc               ),

                   .RegFileScalar2StOpCntl     ( RegFileScalar2StOpCntl    ) ,  // array of driver probes for the RegFile Scalar registers to stOp Controller for each PE
                   .RegFileLane2StOpCntl       ( RegFileLane2StOpCntl      ) ,  // array of driver probes for the RegFile Vector registers to stOp Controller for each PE/Lane
                   .LoadStore2memCntl          ( LoadStore2memCntl         ) ,  // array of driver probes for the Load/Store from SIMD to memory controller for each PE

                   // DRAM
                   .DramIfc                    ( DramIfc                   ) ,  // array of dram interfaces

                   .reset                      ( reset_poweron             ) 
                  );

    //----------------------------------------------------------------------------------------------------
    // DiRAM4
    //
    genvar mgr;
    localparam MGR_ARRAY_NUM_OF_MGR = `MGR_ARRAY_NUM_OF_MGR ;
    generate
      if (MGR_ARRAY_NUM_OF_MGR <= 4)
        begin : diram
            for (mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1) 
              begin : diram_port_arrays
 
                wire  qvld ;
                wire  cq   ;
                diram4   #(.DQ_WIDTH    (`MGR_DRAM_INTF_WIDTH),
                           .PORT_COUNT  (                   1),
                           .DO_MEM_INIT (                   1)
                          )
                          diram_inst(
                                    .clk       ( clk ),
                                    .clk_n     (~clk ),
                                                
                                    .cs_n      ( dfi__phy__cs    [mgr] ),                     
                                    .cmd1      ( dfi__phy__cmd1  [mgr] ), 
                                    .cmd0      ( dfi__phy__cmd0  [mgr] ), 
                                    .addr      ( dfi__phy__addr  [mgr] ),
                                    .baddr     ( dfi__phy__bank  [mgr] ),
                                                                 
                                    .d         ( dfi__phy__data  [mgr] ),
                                    //.q         ( ),
                                    .q         ( phy__dfi__data  [mgr] ),
                                    .cq_n      (                       ),
                                    .cq        ( cq                    ),
                                    .qvld      ( qvld                  )
                                    );

                assign  phy__dfi__valid [mgr] = {`MGR_DRAM_CLK_GROUP_WIDTH {qvld}} ;
                assign  clk_diram_cq    [mgr] = {`MGR_DRAM_CLK_GROUP_WIDTH {cq  }} ;
              end
        end
    endgenerate
    
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
    `ifndef TB_SYSTEM_DRIVES_OOB_PACKET
      `include "TB_system_stack_bus_downstream_oob_assignments.vh"
    `endif
    
    // Downstream Stack bus Interface
    //  - connect Lane signals inside manager from std_lane_ifc
    `include "TB_system_stack_bus_downstream_assignments.vh"
    
    // Upstream Stack bus Interface
    //  - connect upstream signals inside manager from stu_ifc
    `include "TB_system_stack_bus_upstream_assignments.vh"

    //----------------------------------------------------------------------------------------------------
    // Probes
    //
    //------------------------------------------------------------
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

    //------------------------------------------------------------
    // Local NoC Interfaces
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
             assign LocalFromNocIfc[mgr].noc__locl__dp_pvalid   = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.noc__locl__dp_pvalid  ;
             assign LocalFromNocIfc[mgr].noc__locl__dp_mgrId    = system_inst.manager_array_inst.mgr_inst[mgr].manager.mgr_noc_cntl.noc__locl__dp_mgrId   ;
           end
    endgenerate

    //------------------------------------------------------------
    // WU Decoder to OOB Downstream Interfaces
    generate
       for (mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1)
           begin
             assign WudToOobIfc[mgr].valid        = system_inst.manager_array_inst.mgr_inst[mgr].manager.oob_downstream_cntl.wud__odc__valid     ;
             assign WudToOobIfc[mgr].cntl         = system_inst.manager_array_inst.mgr_inst[mgr].manager.oob_downstream_cntl.wud__odc__cntl      ;
             assign WudToOobIfc[mgr].ready        = system_inst.manager_array_inst.mgr_inst[mgr].manager.oob_downstream_cntl.odc__wud__ready     ;
             assign WudToOobIfc[mgr].tag          = system_inst.manager_array_inst.mgr_inst[mgr].manager.oob_downstream_cntl.wud__odc__tag       ;
             assign WudToOobIfc[mgr].num_lanes    = system_inst.manager_array_inst.mgr_inst[mgr].manager.oob_downstream_cntl.wud__odc__num_lanes ;
             assign WudToOobIfc[mgr].stOp_cmd     = system_inst.manager_array_inst.mgr_inst[mgr].manager.oob_downstream_cntl.wud__odc__stOp_cmd  ;
             assign WudToOobIfc[mgr].simd_cmd     = system_inst.manager_array_inst.mgr_inst[mgr].manager.oob_downstream_cntl.wud__odc__simd_cmd  ;
           end
    endgenerate

    //------------------------------------------------------------
    // WU Decoder to memory Read Interfaces
    //
    /*
    genvar memIfc;
    genvar opt;
    generate
      for (mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1)
        begin
          for (memIfc=0; memIfc<`MGR_NUM_OF_STREAMS; memIfc=memIfc+1)
            begin
              if (memIfc == 0)
                begin
                  assign WudToMrcIfc[mgr][memIfc].wud__mrc__valid       = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc0__valid   ;
                  assign WudToMrcIfc[mgr][memIfc].mrc__wud__ready       = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.mrc0__wud__ready   ;
                  assign WudToMrcIfc[mgr][memIfc].wud__mrc__cntl        = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc0__cntl    ;
                  for (opt=0; opt<`MGR_WU_OPT_PER_INST; opt=opt+1)
                    begin
                      assign WudToMrcIfc[mgr][memIfc].wud__mrc__option_type  [opt]     = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc0__option_type  [opt];
                      assign WudToMrcIfc[mgr][memIfc].wud__mrc__option_value [opt]     = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc0__option_value [opt];
                    end
                end
              else
                begin
                  assign WudToMrcIfc[mgr][memIfc].wud__mrc__valid       = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc1__valid   ;
                  assign WudToMrcIfc[mgr][memIfc].mrc__wud__ready       = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.mrc1__wud__ready   ;
                  assign WudToMrcIfc[mgr][memIfc].wud__mrc__cntl        = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc1__cntl    ;
                  for (opt=0; opt<`MGR_WU_OPT_PER_INST; opt=opt+1)
                    begin
                      assign WudToMrcIfc[mgr][memIfc].wud__mrc__option_type  [opt]     = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc1__option_type  [opt];
                      assign WudToMrcIfc[mgr][memIfc].wud__mrc__option_value [opt]     = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc1__option_value [opt];
                    end
                end
            end
        end
    endgenerate
    */

    genvar memIfc;
    genvar opt;
    generate
      for (mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1)
        begin
          for (memIfc=0; memIfc<`MGR_NUM_OF_STREAMS; memIfc=memIfc+1)
            begin
              if (memIfc == 0)
                begin
                  assign WudToMrcIfc[mgr][memIfc].valid       = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc0__valid   ;
                  assign WudToMrcIfc[mgr][memIfc].ready       = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.mrc0__wud__ready   ;
                  assign WudToMrcIfc[mgr][memIfc].cntl        = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc0__cntl    ;
                  for (opt=0; opt<`MGR_WU_OPT_PER_INST; opt=opt+1)
                    begin
                      assign WudToMrcIfc[mgr][memIfc].option_type  [opt]     = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc0__option_type  [opt];
                      assign WudToMrcIfc[mgr][memIfc].option_value [opt]     = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc0__option_value [opt];
                    end
                end
              else
                begin
                  assign WudToMrcIfc[mgr][memIfc].valid       = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc1__valid   ;
                  assign WudToMrcIfc[mgr][memIfc].ready       = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.mrc1__wud__ready   ;
                  assign WudToMrcIfc[mgr][memIfc].cntl        = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc1__cntl    ;
                  for (opt=0; opt<`MGR_WU_OPT_PER_INST; opt=opt+1)
                    begin
                      assign WudToMrcIfc[mgr][memIfc].option_type  [opt]     = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc1__option_type  [opt];
                      assign WudToMrcIfc[mgr][memIfc].option_value [opt]     = system_inst.manager_array_inst.mgr_inst[mgr].manager.wu_decode.wud__mrc1__option_value [opt];
                    end
                end
            end
        end
    endgenerate

    //------------------------------------------------------------
    // DRAM

    generate
       for (mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1)
           begin
             assign DramIfc[mgr].clk_diram_cntl_ck     = clk_diram_cntl_ck  [mgr]   ;
             assign DramIfc[mgr].dfi__phy__cs          = dfi__phy__cs       [mgr]   ;
             assign DramIfc[mgr].dfi__phy__cmd1        = dfi__phy__cmd1     [mgr]   ;
             assign DramIfc[mgr].dfi__phy__cmd0        = dfi__phy__cmd0     [mgr]   ;
             assign DramIfc[mgr].dfi__phy__addr        = dfi__phy__addr     [mgr]   ;
             assign DramIfc[mgr].dfi__phy__bank        = dfi__phy__bank     [mgr]   ;

             assign DramIfc[mgr].clk_diram_data_ck     = clk_diram_data_ck  [mgr]   ;
             assign DramIfc[mgr].dfi__phy__data        = dfi__phy__data     [mgr]   ;

             assign DramIfc[mgr].clk_diram_cq          = clk_diram_cq       [mgr]   ;
             assign DramIfc[mgr].phy__dfi__valid       = phy__dfi__valid    [mgr]   ;
             assign DramIfc[mgr].phy__dfi__data        = phy__dfi__data     [mgr]   ;

           end
    endgenerate

    //------------------------------------------------------------
    // Memory Read to Stack Downstream Interfaces
/*
    genvar el;
    generate
      for (mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1)
        begin
          for (memIfc=0; memIfc<`MGR_NUM_OF_STREAMS; memIfc=memIfc+1)
            begin
              for (el=0; el<`MGR_NUM_OF_STREAMS; el=el+1)
                begin
                  assign  system_inst.manager_array_inst.mgr_inst[mgr].manager.mrc_cntl_strm_inst[memIfc].mrc__std__lane_valid [el]  =  MrcToStdIfc[mgr][memIfc].mrc__std__lane_valid [el]  ;
                  assign  system_inst.manager_array_inst.mgr_inst[mgr].manager.mrc_cntl_strm_inst[memIfc].mrc__std__lane_cntl  [el]  =  MrcToStdIfc[mgr][memIfc].mrc__std__lane_cntl  [el]  ;

                  // let the system drive ready
                  //assign  MrcToStdIfc[mgr][memIfc].std__mrc__lane_ready [el]  = system_inst.manager_array_inst.mgr_inst[mgr].manager.mrc_cntl_strm_inst[memIfc].std__mrc__lane_ready [el] ;
              
                end
            end
        end
    endgenerate
*/


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
               assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__rs0      =  RegFileScalar2StOpCntl[pe].rs0                 ;  //.TB_regFileScalarDrv2stOpCntl
               assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__rs1      =  RegFileScalar2StOpCntl[pe].rs1                 ;  //.TB_regFileScalarDrv2stOpCntl
               for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane=lane+1)
                   begin
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__lane_r128[lane] =   RegFileLane2StOpCntl[pe][lane].r128 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__lane_r129[lane] =   RegFileLane2StOpCntl[pe][lane].r129 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__lane_r130[lane] =   RegFileLane2StOpCntl[pe][lane].r130 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__lane_r131[lane] =   RegFileLane2StOpCntl[pe][lane].r131 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__lane_r132[lane] =   RegFileLane2StOpCntl[pe][lane].r132 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__lane_r133[lane] =   RegFileLane2StOpCntl[pe][lane].r133 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__lane_r134[lane] =   RegFileLane2StOpCntl[pe][lane].r134 ;  //.TB_regFileLaneDrv2stOpCntl
                       assign system_inst.pe_array_inst.pe_inst[pe].pe.cntl__simd__lane_r135[lane] =   RegFileLane2StOpCntl[pe][lane].r135 ;  //.TB_regFileLaneDrv2stOpCntl
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


  //******************************
  //******************************
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
