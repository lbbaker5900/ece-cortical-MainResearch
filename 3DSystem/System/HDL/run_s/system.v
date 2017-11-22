/*********************************************************************************************

    File name   : system.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor System.
                  It instantiates an array of Managers, an array of PE's and a stack bus module.

*********************************************************************************************/
    


`include "common.vh"
`include "stack_interface.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "manager.vh"
`include "manager_array.vh"
`include "noc_interMgr_port_Bitmasks.vh"

`timescale 1ns/10ps

module system (

        //-----------------------------------------------------------------------------------------------------
        // DFI Interface to DRAM
        output  wire                                           clk_diram_cntl_ck   [`MGR_ARRAY_NUM_OF_MGR ] ,
        output  wire                                           dfi__phy__cs        [`MGR_ARRAY_NUM_OF_MGR ] , 
        output  wire                                           dfi__phy__cmd1      [`MGR_ARRAY_NUM_OF_MGR ] , 
        output  wire                                           dfi__phy__cmd0      [`MGR_ARRAY_NUM_OF_MGR ] ,
        output  wire       [`MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__bank      [`MGR_ARRAY_NUM_OF_MGR ] ,
        output  wire       [`MGR_DRAM_PHY_ADDRESS_RANGE     ]  dfi__phy__addr      [`MGR_ARRAY_NUM_OF_MGR ] ,
        
        output  wire       [`MGR_DRAM_CLK_GROUP_RANGE       ]  clk_diram_data_ck   [`MGR_ARRAY_NUM_OF_MGR ] ,
        output  wire       [`MGR_DRAM_INTF_RANGE            ]  dfi__phy__data      [`MGR_ARRAY_NUM_OF_MGR ] ,
        output  wire       [`MGR_DRAM_INTF_MASK_RANGE       ]  dfi__phy__data_mask [`MGR_ARRAY_NUM_OF_MGR ] ,
        
        //-----------------------------------------------------------------------------------------------------
        // DFI Interface from DRAM
        //
        input   wire       [`MGR_DRAM_CLK_GROUP_RANGE       ]  clk_diram_cq        [`MGR_ARRAY_NUM_OF_MGR ] ,
        input   wire       [`MGR_DRAM_CLK_GROUP_RANGE       ]  phy__dfi__valid     [`MGR_ARRAY_NUM_OF_MGR ] ,
        input   wire       [`MGR_DRAM_INTF_RANGE            ]  phy__dfi__data      [`MGR_ARRAY_NUM_OF_MGR ] ,

        //-----------------------------------------------------------------------------------------------------
        // Clocks for SDR/DDR
        input   wire                                           clk_diram                                    ,
        input   wire                                           clk_diram2x                                  ,
                                                                                                         
        //-----------------------------------------------------------------------------------------------------
        // General                                                                                       
        input   wire                                           clk                                          ,
        input   wire                                           reset_poweron                                
 
);



  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Regs and wires

  //--------------------------------------------------------------------------------
  // DFI Interface to DRAM
  //
  /*
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
  */

  //-------------------------------------------------------------------------------------------
  // NoC
  //`include "manager_noc_connection_wires.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  `include "system_manager_sys_general_instance_wires.vh"
  `include "system_pe_sys_general_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_manager_stack_bus_downstream_oob_instance_wires.vh"
  `include "system_pe_stack_bus_downstream_oob_instance_wires.vh"

  `include "system_manager_stack_bus_downstream_instance_wires.vh"
  `include "system_pe_stack_bus_downstream_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_manager_stack_bus_upstream_instance_wires.vh"
  `include "system_pe_stack_bus_upstream_instance_wires.vh"
  
  
  //-------------------------------------------------------------------------------------------
  // Array of Managers

  manager_array manager_array_inst (
  
        //--------------------------------------------------------------------------------
        // DFI Interface to DRAM
        //
        .clk_diram_cntl_ck    ( clk_diram_cntl_ck   ), 
        .dfi__phy__cs         ( dfi__phy__cs        ),
        .dfi__phy__cmd1       ( dfi__phy__cmd1      ),
        .dfi__phy__cmd0       ( dfi__phy__cmd0      ),
        .dfi__phy__addr       ( dfi__phy__addr      ),
        .dfi__phy__bank       ( dfi__phy__bank      ),
                                                    
        .clk_diram_data_ck    ( clk_diram_data_ck   ), 
        .dfi__phy__data       ( dfi__phy__data      ),
        .dfi__phy__data_mask  ( dfi__phy__data_mask ),

        //--------------------------------------------------------------------------------
        // DFI Interface from DRAM
        //
        .clk_diram_cq         ( clk_diram_cq       ),
        .phy__dfi__valid      ( phy__dfi__valid    ),
        .phy__dfi__data       ( phy__dfi__data     ),

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_manager_array_sys_general_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - OOB Downstream
        `include "system_manager_array_stack_bus_downstream_oob_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_manager_array_stack_bus_downstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        `include "system_manager_array_stack_bus_upstream_instance_ports.vh"

        //--------------------------------------------------------------------------------
        // Clocks for SDR/DDR
        .clk_diram       ( clk_diram     ),
        .clk_diram2x     ( clk_diram2x   ),

        //-------------------------------------------------------------------------------------------
        // General
        .clk             ( clk           ),
        .reset_poweron   ( reset_poweron )
        );
 

  //-------------------------------------------------------------------------------------------
  // Array of PE's

  pe_array pe_array_inst (

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_pe_array_sys_general_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - OOB Downstream
        `include "system_pe_array_stack_bus_downstream_oob_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_pe_array_stack_bus_downstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        `include "system_pe_array_stack_bus_upstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // General
        .clk             ( clk           ) ,
        .reset_poweron   ( reset_poweron )
 
);

  //-------------------------------------------------------------------------------------------
  // Stack Interface

  stack_bus stack_bus_inst (

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_manager_array_sys_general_instance_ports.vh"
        `include "system_pe_array_sys_general_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_manager_array_stack_bus_downstream_oob_instance_ports.vh"
        `include "system_pe_array_stack_bus_downstream_oob_instance_ports.vh"

        `include "system_manager_array_stack_bus_downstream_instance_ports.vh"
        `include "system_pe_array_stack_bus_downstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        `include "system_manager_array_stack_bus_upstream_instance_ports.vh"
        `include "system_pe_array_stack_bus_upstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // General
        .clk             ( clk           ) ,
        .reset_poweron   ( reset_poweron )
 
        );

endmodule 

