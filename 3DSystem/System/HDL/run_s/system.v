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
  // Stack Bus - General
  //`include "system_manager_sys_general_instance_wires.vh"
  wire                                        mgr__sys__allSynchronized    [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire                                        sys__mgr__thisSynchronized   [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire                                        sys__mgr__ready              [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire                                        sys__mgr__complete           [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;

  //`include "system_pe_sys_general_instance_wires.vh"
  wire                                        sys__pe__allSynchronized     [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  wire                                        pe__sys__thisSynchronized    [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  wire                                        pe__sys__ready               [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  wire                                        pe__sys__complete            [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  //`include "system_manager_stack_bus_downstream_oob_instance_wires.vh"
  // OOB controls how the lanes are interpreted                                
  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire                                        mgr__std__oob_valid         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire                                        std__mgr__oob_ready         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;

  //`include "system_pe_stack_bus_downstream_oob_instance_wires.vh"
  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl          [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire                                        std__pe__oob_valid         [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire                                        pe__std__oob_ready         [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type          [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data          [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;


  //`include "system_manager_stack_bus_downstream_instance_wires.vh"
  wire                                        std__mgr__lane_strm_ready       [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]   mgr__std__lane_strm_cntl        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]   mgr__std__lane_strm_data        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire                                        mgr__std__lane_strm_data_valid  [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;

  //`include "system_pe_stack_bus_downstream_instance_wires.vh"
  wire                                        pe__std__lane_strm_ready        [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]   std__pe__lane_strm_cntl         [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]   std__pe__lane_strm_data         [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire                                        std__pe__lane_strm_data_valid   [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;

  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //`include "system_manager_stack_bus_upstream_instance_wires.vh"
  wire                                           stu__mgr__valid         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire                                           mgr__stu__ready         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data      [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;

  //`include "system_pe_stack_bus_upstream_instance_wires.vh"
  wire                                           pe__stu__valid          [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl           [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire                                           stu__pe__ready          [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire    [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type           [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire    [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data           [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data       [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;

  
  
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
        //`include "system_manager_array_sys_general_instance_ports.vh"
        .mgr__sys__allSynchronized            ( mgr__sys__allSynchronized  ),
        .sys__mgr__thisSynchronized           ( sys__mgr__thisSynchronized ),
        .sys__mgr__ready                      ( sys__mgr__ready            ),
        .sys__mgr__complete                   ( sys__mgr__complete         ),


        //-------------------------------------------------------------------------------------------
        // Stack Bus - OOB Downstream
        //`include "system_manager_array_stack_bus_downstream_oob_instance_ports.vh"
        // OOB controls the PE                          
        // For now assume OOB is separate to lanes      
        .mgr__std__oob_cntl                         ( mgr__std__oob_cntl   ),
        .mgr__std__oob_valid                        ( mgr__std__oob_valid  ),
        .std__mgr__oob_ready                        ( std__mgr__oob_ready  ),
        .mgr__std__oob_type                         ( mgr__std__oob_type   ),
        .mgr__std__oob_data                         ( mgr__std__oob_data   ),


        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        //`include "system_manager_array_stack_bus_downstream_instance_ports.vh"
        .std__mgr__lane_strm_ready           ( std__mgr__lane_strm_ready       ),
        .mgr__std__lane_strm_cntl            ( mgr__std__lane_strm_cntl        ),
        .mgr__std__lane_strm_data            ( mgr__std__lane_strm_data        ),
        .mgr__std__lane_strm_data_valid      ( mgr__std__lane_strm_data_valid  ),


        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        //`include "system_manager_array_stack_bus_upstream_instance_ports.vh"
        .stu__mgr__valid        ( stu__mgr__valid     ),
        .stu__mgr__cntl         ( stu__mgr__cntl      ),
        .mgr__stu__ready        ( mgr__stu__ready     ),
        .stu__mgr__type         ( stu__mgr__type      ),
        .stu__mgr__data         ( stu__mgr__data      ),
        .stu__mgr__oob_data     ( stu__mgr__oob_data  ),


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
        //`include "system_pe_array_sys_general_instance_ports.vh"
        // General control and status                  
        .sys__pe__allSynchronized                  ( sys__pe__allSynchronized   ),
        .pe__sys__thisSynchronized                 ( pe__sys__thisSynchronized  ),
        .pe__sys__ready                            ( pe__sys__ready             ),
        .pe__sys__complete                         ( pe__sys__complete          ),

        //-------------------------------------------------------------------------------------------
        // Stack Bus - OOB Downstream
        //`include "system_pe_array_stack_bus_downstream_oob_instance_ports.vh"
        // OOB controls the PE                         
        // For now assume OOB is separate to lanes     
        .std__pe__oob_cntl                         ( std__pe__oob_cntl   ),
        .std__pe__oob_valid                        ( std__pe__oob_valid  ),
        .pe__std__oob_ready                        ( pe__std__oob_ready  ),
        .std__pe__oob_type                         ( std__pe__oob_type   ),
        .std__pe__oob_data                         ( std__pe__oob_data   ),


        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        //`include "system_pe_array_stack_bus_downstream_instance_ports.vh"
        // Downstream argument streams            
        .pe__std__lane_strm_ready      ( pe__std__lane_strm_ready      ),
        .std__pe__lane_strm_cntl       ( std__pe__lane_strm_cntl       ),
        .std__pe__lane_strm_data       ( std__pe__lane_strm_data       ),
        .std__pe__lane_strm_data_valid ( std__pe__lane_strm_data_valid ),


        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        //`include "system_pe_array_stack_bus_upstream_instance_ports.vh"
        .pe__stu__valid        ( pe__stu__valid     ),
        .pe__stu__cntl         ( pe__stu__cntl      ),
        .stu__pe__ready        ( stu__pe__ready     ),
        .pe__stu__type         ( pe__stu__type      ),
        .pe__stu__data         ( pe__stu__data      ),
        .pe__stu__oob_data     ( pe__stu__oob_data  ),

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
        //`include "system_manager_array_sys_general_instance_ports.vh"
        .mgr__sys__allSynchronized            ( mgr__sys__allSynchronized  ),
        .sys__mgr__thisSynchronized           ( sys__mgr__thisSynchronized ),
        .sys__mgr__ready                      ( sys__mgr__ready            ),
        .sys__mgr__complete                   ( sys__mgr__complete         ),
        //`include "system_pe_array_sys_general_instance_ports.vh"
        .sys__pe__allSynchronized                  ( sys__pe__allSynchronized   ),
        .pe__sys__thisSynchronized                 ( pe__sys__thisSynchronized  ),
        .pe__sys__ready                            ( pe__sys__ready             ),
        .pe__sys__complete                         ( pe__sys__complete          ),

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        //`include "system_manager_array_stack_bus_downstream_oob_instance_ports.vh"
        .mgr__std__oob_cntl                         ( mgr__std__oob_cntl   ),
        .mgr__std__oob_valid                        ( mgr__std__oob_valid  ),
        .std__mgr__oob_ready                        ( std__mgr__oob_ready  ),
        .mgr__std__oob_type                         ( mgr__std__oob_type   ),
        .mgr__std__oob_data                         ( mgr__std__oob_data   ),
        //`include "system_pe_array_stack_bus_downstream_oob_instance_ports.vh"
        .std__pe__oob_cntl                         ( std__pe__oob_cntl   ),
        .std__pe__oob_valid                        ( std__pe__oob_valid  ),
        .pe__std__oob_ready                        ( pe__std__oob_ready  ),
        .std__pe__oob_type                         ( std__pe__oob_type   ),
        .std__pe__oob_data                         ( std__pe__oob_data   ),

        //`include "system_manager_array_stack_bus_downstream_instance_ports.vh"
        .std__mgr__lane_strm_ready           ( std__mgr__lane_strm_ready       ),
        .mgr__std__lane_strm_cntl            ( mgr__std__lane_strm_cntl        ),
        .mgr__std__lane_strm_data            ( mgr__std__lane_strm_data        ),
        .mgr__std__lane_strm_data_valid      ( mgr__std__lane_strm_data_valid  ),
        //`include "system_pe_array_stack_bus_downstream_instance_ports.vh"
        .pe__std__lane_strm_ready      ( pe__std__lane_strm_ready      ),
        .std__pe__lane_strm_cntl       ( std__pe__lane_strm_cntl       ),
        .std__pe__lane_strm_data       ( std__pe__lane_strm_data       ),
        .std__pe__lane_strm_data_valid ( std__pe__lane_strm_data_valid ),

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        //`include "system_manager_array_stack_bus_upstream_instance_ports.vh"
        .stu__mgr__valid        ( stu__mgr__valid     ),
        .stu__mgr__cntl         ( stu__mgr__cntl      ),
        .mgr__stu__ready        ( mgr__stu__ready     ),
        .stu__mgr__type         ( stu__mgr__type      ),
        .stu__mgr__data         ( stu__mgr__data      ),
        .stu__mgr__oob_data     ( stu__mgr__oob_data  ),
        //`include "system_pe_array_stack_bus_upstream_instance_ports.vh"
        .pe__stu__valid        ( pe__stu__valid     ),
        .pe__stu__cntl         ( pe__stu__cntl      ),
        .stu__pe__ready        ( stu__pe__ready     ),
        .pe__stu__type         ( pe__stu__type      ),
        .pe__stu__data         ( pe__stu__data      ),
        .pe__stu__oob_data     ( pe__stu__oob_data  ),

        //-------------------------------------------------------------------------------------------
        // General
        .clk             ( clk           ) ,
        .reset_poweron   ( reset_poweron )
 
        );

endmodule 

