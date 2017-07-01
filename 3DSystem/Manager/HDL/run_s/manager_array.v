/*********************************************************************************************

    File name   : manager_array.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor Manager array.
                  It instantiates an array of Managers which include a :

*********************************************************************************************/
    


`include "common.vh"
`include "stack_interface.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mgr_noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "manager.vh"
`include "manager_array.vh"
`include "noc_interMgr_port_Bitmasks.vh"

`timescale 1ns/10ps

module manager_array (

        //-------------------------------------------------------------------------------------------
        // DFI Interface to DRAM
        clk_diram_ck   ,  
        dfi__phy__cs   ,
        dfi__phy__cmd1 ,
        dfi__phy__cmd0 ,
        dfi__phy__data ,
        dfi__phy__addr ,
        dfi__phy__bank ,

        //-------------------------------------------------------------------------------------------
        // DFI Interface from DRAM
        clk_diram_cq    , 
        phy__dfi__valid ,
        phy__dfi__data  ,

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_manager_sys_general_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - OOB Downstream
        `include "system_manager_stack_bus_downstream_oob_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_manager_stack_bus_downstream_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        `include "system_manager_stack_bus_upstream_ports.vh"

        //--------------------------------------------------------------------------------
        // Clocks for SDR/DDR
        clk_diram       ,
        clk_diram2x     ,

        //-------------------------------------------------------------------------------------------
        // General
        clk              ,
        reset_poweron    
 
);


  //--------------------------------------------------------------------------------
  // Clocks for SDR/DDR
  input                      clk_diram      ;
  input                      clk_diram2x    ;
  
  //-------------------------------------------------------------------------------------------
  // General

  input                      clk            ;
  input                      reset_poweron  ;

  //--------------------------------------------------------------------------------
  // DFI Interface to DRAM
  //
  output                                        clk_diram_ck   [`MGR_ARRAY_NUM_OF_MGR ] ;
  output                                        dfi__phy__cs   [`MGR_ARRAY_NUM_OF_MGR ] ; 
  output                                        dfi__phy__cmd1 [`MGR_ARRAY_NUM_OF_MGR ] ; 
  output                                        dfi__phy__cmd0 [`MGR_ARRAY_NUM_OF_MGR ] ;
  output   [ `MGR_DRAM_INTF_RANGE            ]  dfi__phy__data [`MGR_ARRAY_NUM_OF_MGR ] ;
  output   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__bank [`MGR_ARRAY_NUM_OF_MGR ] ;
  output   [ `MGR_DRAM_PHY_ADDRESS_RANGE     ]  dfi__phy__addr [`MGR_ARRAY_NUM_OF_MGR ] ;

  //--------------------------------------------------------------------------------
  // DFI Interface from DRAM
  //
  input                                         clk_diram_cq    [`MGR_ARRAY_NUM_OF_MGR ] ;
  input                                         phy__dfi__valid [`MGR_ARRAY_NUM_OF_MGR ] ;
  input    [ `MGR_DRAM_INTF_RANGE            ]  phy__dfi__data  [`MGR_ARRAY_NUM_OF_MGR ] ;

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  `include "system_manager_sys_general_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  `include "system_manager_stack_bus_downstream_oob_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_manager_stack_bus_downstream_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_manager_stack_bus_upstream_port_declarations.vh"


  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Regs and wires

  //-------------------------------------------------------------------------------------------
  // NoC
  //`include "manager_noc_connection_wires.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  `include "system_manager_sys_general_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  `include "system_manager_stack_bus_downstream_oob_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_manager_stack_bus_downstream_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_manager_stack_bus_upstream_instance_wires.vh"
  
 
  genvar gvi;
  generate
    for (gvi=0; gvi<`MGR_ARRAY_NUM_OF_MGR; gvi=gvi+1) 
      begin: mgr_inst

        //--------------------------------------------------------------------------------
        // DFI Interface to DRAM
        //
        wire                                       clk_diram_ck   ;
        wire                                       dfi__phy__cs   ; 
        wire                                       dfi__phy__cmd1 ; 
        wire                                       dfi__phy__cmd0 ;
        wire  [ `MGR_DRAM_INTF_RANGE            ]  dfi__phy__data ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__bank ;
        wire  [ `MGR_DRAM_PHY_ADDRESS_RANGE     ]  dfi__phy__addr ;

        //--------------------------------------------------------------------------------
        // DFI Interface from DRAM
        //
        wire                                       clk_diram_cq    ;
        wire                                       phy__dfi__valid ;
        wire  [ `MGR_DRAM_INTF_RANGE            ]  phy__dfi__data  ;

        //-------------------------------------------------------------------------------------------------
        // General control and status 
        wire [`PE_PE_ID_RANGE                 ]     sys__mgr__mgrId               ; 
        wire                                        mgr__sys__allSynchronized     ; 
        wire                                        sys__mgr__thisSynchronized    ; 
        wire                                        sys__mgr__ready               ; 
        wire                                        sys__mgr__complete            ; 

        //-------------------------------------------------------------------------------------------------
        // Stack Bus OOB downstream Interface
        //  - OOB carries PE configuration  
        wire[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl            ; 
        wire                                        mgr__std__oob_valid           ; 
        wire                                        std__mgr__oob_ready           ; 
        wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type            ; 
        wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data            ; 

        //-------------------------------------------------------------------------------------------------
        // Stack Bus downstream Interface
        `include "manager_stack_bus_downstream_instance_wires.vh"

        //-------------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        //
        wire                                           stu__mgr__valid       ;
        wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl        ;
        wire                                           mgr__stu__ready       ;
        wire    [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type        ;  // Control or Data, Vector or scalar
        wire    [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data        ;
        wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data    ;
 
        //-------------------------------------------------------------------------------------------------
        // NoC Interface
        `include "manager_noc_instance_wires.vh"

        assign sys__mgr__mgrId = gvi;

        manager manager (
   
                //--------------------------------------------------------------------------------
                // DFI Interface to DRAM
                //
                .clk_diram_ck         ( clk_diram_ck      ), 
                .dfi__phy__cs         ( dfi__phy__cs      ),
                .dfi__phy__cmd1       ( dfi__phy__cmd1    ),
                .dfi__phy__cmd0       ( dfi__phy__cmd0    ),
                .dfi__phy__data       ( dfi__phy__data    ),
                .dfi__phy__addr       ( dfi__phy__addr    ),
                .dfi__phy__bank       ( dfi__phy__bank    ),

                //--------------------------------------------------------------------------------
                // DFI Interface from DRAM
                //
                .clk_diram_cq         ( clk_diram_cq       ),
                .phy__dfi__valid      ( phy__dfi__valid    ),
                .phy__dfi__data       ( phy__dfi__data     ),
                
                //-------------------------------
                // NoC Interface
                `include "manager_noc_instance_ports.vh"
   
                //-------------------------------
                // Stack Bus OOB downstream Interface
                //  - OOB carries PE configuration  
                .mgr__std__oob_cntl     ( mgr__std__oob_cntl     ), 
                .mgr__std__oob_valid    ( mgr__std__oob_valid    ), 
                .std__mgr__oob_ready    ( std__mgr__oob_ready    ), 
                .mgr__std__oob_type     ( mgr__std__oob_type     ), 
                .mgr__std__oob_data     ( mgr__std__oob_data     ), 

                //-------------------------------
                // Stack Bus downstream Interface
                `include "manager_stack_bus_downstream_instance_ports.vh"
   
                //-------------------------------
                // Stack Bus - Upstream
                .stu__mgr__valid        ( stu__mgr__valid        ),
                .stu__mgr__cntl         ( stu__mgr__cntl         ),
                .mgr__stu__ready        ( mgr__stu__ready        ),
                .stu__mgr__type         ( stu__mgr__type         ),  // Control or Data, Vector or scalar
                .stu__mgr__data         ( stu__mgr__data         ),
                .stu__mgr__oob_data     ( stu__mgr__oob_data     ),
 
                //-------------------------------
                // General control and status  
                .sys__mgr__mgrId              ( sys__mgr__mgrId             ), 
                .mgr__sys__allSynchronized    ( mgr__sys__allSynchronized   ), 
                .sys__mgr__thisSynchronized   ( sys__mgr__thisSynchronized  ), 
                .sys__mgr__ready              ( sys__mgr__ready             ), 
                .sys__mgr__complete           ( sys__mgr__complete          ), 
                //`include "manager_sys_general_instance_ports.vh"

                //-------------------------------
                // Clocks for SDR/DDR
                .clk_diram            ( clk_diram      ),
                .clk_diram2x          ( clk_diram2x    ),


                //-------------------------------
                // General
                //
                .clk                          ( clk                         ),
                .reset_poweron                ( reset_poweron               )
              );
      end
  endgenerate

  //-------------------------------------------------------------------------------------------
  // DRAM connectivity
  genvar mgr;
  generate
    for (mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1) 
      begin: dram_connect
        assign   clk_diram_ck   [mgr]   =  mgr_inst[mgr].clk_diram_ck   ;
        assign   dfi__phy__cs   [mgr]   =  mgr_inst[mgr].dfi__phy__cs   ;
        assign   dfi__phy__cmd1 [mgr]   =  mgr_inst[mgr].dfi__phy__cmd1 ;
        assign   dfi__phy__cmd0 [mgr]   =  mgr_inst[mgr].dfi__phy__cmd0 ;
        assign   dfi__phy__data [mgr]   =  mgr_inst[mgr].dfi__phy__data ;
        assign   dfi__phy__addr [mgr]   =  mgr_inst[mgr].dfi__phy__addr ;
        assign   dfi__phy__bank [mgr]   =  mgr_inst[mgr].dfi__phy__bank ;

        assign   mgr_inst[mgr].clk_diram_cq     =  clk_diram_cq    [mgr] ;
        assign   mgr_inst[mgr].phy__dfi__valid  =  phy__dfi__valid [mgr] ;
        assign   mgr_inst[mgr].phy__dfi__data   =  phy__dfi__data  [mgr] ;
      end
  endgenerate

  //-------------------------------------------------------------------------------------------
  // General system connectivity
  `include "manager_sys_general_connections.vh"
  
  //-------------------------------------------------------------------------------------------------
  // Stack Bus OOB Downstream connections
  `include "system_manager_stack_bus_downstream_oob_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus Downstream connections
  `include "system_manager_stack_bus_downstream_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus Upstream connections
  `include "system_manager_stack_bus_upstream_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Inter Manager NoC Connectivity      
  `include "noc_interMgr_connections.vh"
  `include "noc_interMgr_port_Bitmask_assignments.vh"



endmodule  /*managerArray*/

