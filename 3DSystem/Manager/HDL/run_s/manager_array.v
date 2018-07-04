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
        clk_diram_cntl_ck   ,  
        dfi__phy__cs        ,
        dfi__phy__cmd1      ,
        dfi__phy__cmd0      ,
        dfi__phy__addr      ,
        dfi__phy__bank      ,

        clk_diram_data_ck   ,  
        dfi__phy__data      ,
        dfi__phy__data_mask ,

        //-------------------------------------------------------------------------------------------
        // DFI Interface from DRAM
        clk_diram_cq    , 
        phy__dfi__valid ,
        phy__dfi__data  ,

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        //`include "system_manager_sys_general_ports.vh"
        // General control and status                    
        mgr__sys__allSynchronized                    ,
        sys__mgr__thisSynchronized                   ,
        sys__mgr__ready                              ,
        sys__mgr__complete                           ,


        //-------------------------------------------------------------------------------------------
        // Stack Bus - OOB Downstream
        //`include "system_manager_stack_bus_downstream_oob_ports.vh"
        // OOB controls the PE                          
        // For now assume OOB is separate to lanes      
        mgr__std__oob_cntl                           ,
        mgr__std__oob_valid                          ,
        std__mgr__oob_ready                          ,
        mgr__std__oob_type                           ,
        mgr__std__oob_data                           ,


        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        //`include "system_manager_stack_bus_downstream_ports.vh"
        // - Manager Lane arguments to the PE                          
        std__mgr__lane_strm_ready       ,
        mgr__std__lane_strm_cntl        ,
        mgr__std__lane_strm_data        ,
        mgr__std__lane_strm_data_valid  ,


        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        //`include "system_manager_stack_bus_upstream_ports.vh"
        stu__mgr__valid          ,
        stu__mgr__cntl           ,
        mgr__stu__ready          ,
        stu__mgr__type           ,
        stu__mgr__data           ,
        stu__mgr__oob_data       ,

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
  output                                       clk_diram_cntl_ck     [`MGR_ARRAY_NUM_OF_MGR ] ;
  output                                       dfi__phy__cs          [`MGR_ARRAY_NUM_OF_MGR ] ; 
  output                                       dfi__phy__cmd1        [`MGR_ARRAY_NUM_OF_MGR ] ; 
  output                                       dfi__phy__cmd0        [`MGR_ARRAY_NUM_OF_MGR ] ;
  output   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__bank        [`MGR_ARRAY_NUM_OF_MGR ] ;
  output   [`MGR_DRAM_PHY_ADDRESS_RANGE     ]  dfi__phy__addr        [`MGR_ARRAY_NUM_OF_MGR ] ;
                                                                      
  output   [`MGR_DRAM_CLK_GROUP_RANGE       ]  clk_diram_data_ck     [`MGR_ARRAY_NUM_OF_MGR ] ;
  output   [`MGR_DRAM_INTF_RANGE            ]  dfi__phy__data        [`MGR_ARRAY_NUM_OF_MGR ] ;
  output   [`MGR_DRAM_INTF_MASK_RANGE       ]  dfi__phy__data_mask   [`MGR_ARRAY_NUM_OF_MGR ] ;

  //--------------------------------------------------------------------------------
  // DFI Interface from DRAM
  //
  output   [`MGR_DRAM_CLK_GROUP_RANGE       ]  clk_diram_cq    [`MGR_ARRAY_NUM_OF_MGR ] ;
  output   [`MGR_DRAM_CLK_GROUP_RANGE       ]  phy__dfi__valid [`MGR_ARRAY_NUM_OF_MGR ] ;
  input    [`MGR_DRAM_INTF_RANGE            ]  phy__dfi__data  [`MGR_ARRAY_NUM_OF_MGR ] ;

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  // - General control and status                                                   
  //`include "system_manager_sys_general_port_declarations.vh"
  output                                        mgr__sys__allSynchronized    [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  input                                         sys__mgr__thisSynchronized   [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  input                                         sys__mgr__ready              [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  input                                         sys__mgr__complete           [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;

  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  //`include "system_manager_stack_bus_downstream_oob_port_declarations.vh"
  // - OOB controls how the lanes are interpreted                                  
  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl     [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;
  output                                          mgr__std__oob_valid    [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;
  input                                           std__mgr__oob_ready    [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type     [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data     [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  //`include "system_manager_stack_bus_downstream_port_declarations.vh"
  input                                         std__mgr__lane_strm_ready       [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
  output  [`COMMON_STD_INTF_CNTL_RANGE      ]   mgr__std__lane_strm_cntl        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
  output  [`STACK_DOWN_INTF_STRM_DATA_RANGE ]   mgr__std__lane_strm_data        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
  output                                        mgr__std__lane_strm_data_valid  [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;


  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //`include "system_manager_stack_bus_upstream_port_declarations.vh"
  input                                          stu__mgr__valid         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  input   [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  output                                         mgr__stu__ready         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  input   [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  input   [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  input   [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data      [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;



  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Regs and wires

  //-------------------------------------------------------------------------------------------
  // NoC
  //`include "manager_noc_connection_wires.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  //`include "system_manager_sys_general_instance_wires.vh"
  wire                                        mgr__sys__allSynchronized    [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire                                        sys__mgr__thisSynchronized   [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire                                        sys__mgr__ready              [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire                                        sys__mgr__complete           [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  //`include "system_manager_stack_bus_downstream_oob_instance_wires.vh"
  wire [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire                                         mgr__std__oob_valid         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire                                         std__mgr__oob_ready         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  //`include "system_manager_stack_bus_downstream_instance_wires.vh"
  wire                                        std__mgr__lane_strm_ready       [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]   mgr__std__lane_strm_cntl        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]   mgr__std__lane_strm_data        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire                                        mgr__std__lane_strm_data_valid  [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;

  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //`include "system_manager_stack_bus_upstream_instance_wires.vh"
  wire                                           stu__mgr__valid         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire                                           mgr__stu__ready         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data      [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  
 
  genvar gvi;
  generate
    for (gvi=0; gvi<`MGR_ARRAY_NUM_OF_MGR; gvi=gvi+1) 
      begin: mgr_inst

        //--------------------------------------------------------------------------------
        // DFI Interface to DRAM
        //
        wire                                      clk_diram_cntl_ck   ;
        wire                                      dfi__phy__cs        ; 
        wire                                      dfi__phy__cmd1      ; 
        wire                                      dfi__phy__cmd0      ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__bank      ;
        wire  [`MGR_DRAM_PHY_ADDRESS_RANGE     ]  dfi__phy__addr      ;
                                                                      
        wire  [`MGR_DRAM_CLK_GROUP_RANGE       ]  clk_diram_data_ck   ;
        wire  [`MGR_DRAM_INTF_RANGE            ]  dfi__phy__data      ;
        wire  [`MGR_DRAM_INTF_MASK_RANGE       ]  dfi__phy__data_mask ;

        //--------------------------------------------------------------------------------
        // DFI Interface from DRAM
        //
        wire  [`MGR_DRAM_CLK_GROUP_RANGE       ]  clk_diram_cq    ;
        wire  [`MGR_DRAM_CLK_GROUP_RANGE       ]  phy__dfi__valid ;
        wire  [`MGR_DRAM_INTF_RANGE            ]  phy__dfi__data  ;

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
        //`include "manager_stack_bus_downstream_instance_wires.vh"
        wire                                           std__mgr__lane_strm_ready       [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
        wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane_strm_cntl        [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
        wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane_strm_data        [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
        wire                                           mgr__std__lane_strm_data_valid  [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;

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
        //`include "manager_noc_instance_wires.vh"
        wire                                         mgr__noc__port_valid            [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ];
        wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  mgr__noc__port_cntl             [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ];
        wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  mgr__noc__port_data             [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ];
        wire                                         noc__mgr__port_fc               [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ];
        wire                                         noc__mgr__port_valid            [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ];
        wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  noc__mgr__port_cntl             [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ];
        wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__mgr__port_data             [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ];
        wire                                         mgr__noc__port_fc               [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ];
        wire   [`MGR_HOST_MGR_ID_BITMASK_RANGE    ]  sys__mgr__port_destinationMask  [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ];

        assign sys__mgr__mgrId = gvi;

        manager manager (
   
                //--------------------------------------------------------------------------------
                // DFI Interface to DRAM
                //
                .clk_diram_cntl_ck      ( clk_diram_cntl_ck     ), 
                .dfi__phy__cs           ( dfi__phy__cs          ),
                .dfi__phy__cmd1         ( dfi__phy__cmd1        ),
                .dfi__phy__cmd0         ( dfi__phy__cmd0        ),
                .dfi__phy__addr         ( dfi__phy__addr        ),
                .dfi__phy__bank         ( dfi__phy__bank        ),
                                                                
                .clk_diram_data_ck      ( clk_diram_data_ck     ), 
                .dfi__phy__data         ( dfi__phy__data        ),
                .dfi__phy__data_mask    ( dfi__phy__data_mask   ),

                //--------------------------------------------------------------------------------
                // DFI Interface from DRAM
                //
                .clk_diram_cq         ( clk_diram_cq       ),
                .phy__dfi__valid      ( phy__dfi__valid    ),
                .phy__dfi__data       ( phy__dfi__data     ),
                
                //-------------------------------
                // NoC Interface
                //`include "manager_noc_instance_ports.vh"
                .mgr__noc__port_valid           ( mgr__noc__port_valid           ),
                .mgr__noc__port_cntl            ( mgr__noc__port_cntl            ),
                .mgr__noc__port_data            ( mgr__noc__port_data            ),
                .noc__mgr__port_fc              ( noc__mgr__port_fc              ),
                .noc__mgr__port_valid           ( noc__mgr__port_valid           ),
                .noc__mgr__port_cntl            ( noc__mgr__port_cntl            ),
                .noc__mgr__port_data            ( noc__mgr__port_data            ),
                .mgr__noc__port_fc              ( mgr__noc__port_fc              ),
                .sys__mgr__port_destinationMask ( sys__mgr__port_destinationMask ),
   
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
                //`include "manager_stack_bus_downstream_instance_ports.vh"
                .std__mgr__lane_strm_ready         ( std__mgr__lane_strm_ready      ),      
                .mgr__std__lane_strm_cntl          ( mgr__std__lane_strm_cntl       ),      
                .mgr__std__lane_strm_data          ( mgr__std__lane_strm_data       ),      
                .mgr__std__lane_strm_data_valid    ( mgr__std__lane_strm_data_valid ),      
   
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
        assign   clk_diram_cntl_ck   [mgr]      =  mgr_inst[mgr].clk_diram_cntl_ck   ;
        assign   dfi__phy__cs        [mgr]      =  mgr_inst[mgr].dfi__phy__cs        ;
        assign   dfi__phy__cmd1      [mgr]      =  mgr_inst[mgr].dfi__phy__cmd1      ;
        assign   dfi__phy__cmd0      [mgr]      =  mgr_inst[mgr].dfi__phy__cmd0      ;
        assign   dfi__phy__addr      [mgr]      =  mgr_inst[mgr].dfi__phy__addr      ;
        assign   dfi__phy__bank      [mgr]      =  mgr_inst[mgr].dfi__phy__bank      ;
                                               
        assign   clk_diram_data_ck   [mgr]      =  mgr_inst[mgr].clk_diram_data_ck   ;
        assign   dfi__phy__data      [mgr]      =  mgr_inst[mgr].dfi__phy__data      ;
        assign   dfi__phy__data_mask [mgr]      =  mgr_inst[mgr].dfi__phy__data_mask ;
                                                                                     
        assign   mgr_inst[mgr].clk_diram_cq     =  clk_diram_cq    [mgr]             ;
        assign   mgr_inst[mgr].phy__dfi__valid  =  phy__dfi__valid [mgr]             ;
        assign   mgr_inst[mgr].phy__dfi__data   =  phy__dfi__data  [mgr]             ;
      end
  endgenerate

  //-------------------------------------------------------------------------------------------
  // General system connectivity
  //`include "manager_sys_general_connections.vh"
  // - Send an 'all' synchronized to all Managers's 
  // - sys__mgr__thisSyncnronized basically means all the streams in a PE are complete
  // - The PE controller will move to a 'final' state once it receives sys__pe__allSynchronized
  /*
  wire    mgr__sys__allSynchronized ;
  for (int mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1) 
    begin
      mgr__sys__allSynchronized = mgr__sys__allSynchronized & mgr_inst[mgr].sys__mgr__thisSynchronized ;
    end
  */

  generate
    for (genvar mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1) 
      begin
        assign  mgr__sys__allSynchronized               [mgr]  =  mgr_inst[mgr].mgr__sys__allSynchronized       ;
        assign  mgr_inst[mgr].sys__mgr__thisSynchronized       =  sys__mgr__thisSynchronized              [mgr] ;
        assign  mgr_inst[mgr].sys__mgr__ready                  =  sys__mgr__ready                         [mgr] ;
        assign  mgr_inst[mgr].sys__mgr__complete               =  sys__mgr__complete                      [mgr] ;
      end
  endgenerate
  
  //-------------------------------------------------------------------------------------------------
  // Stack Bus OOB Downstream connections
  //`include "system_manager_stack_bus_downstream_oob_instance_connections.vh"
  generate
    for (genvar mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1) 
      begin
        assign  mgr__std__oob_cntl                [mgr]         =  mgr_inst[mgr].mgr__std__oob_cntl         ;
        assign  mgr__std__oob_valid               [mgr]         =  mgr_inst[mgr].mgr__std__oob_valid        ;
        assign  mgr_inst[mgr].std__mgr__oob_ready               =  std__mgr__oob_ready                [mgr] ;
        assign  mgr__std__oob_type                [mgr]         =  mgr_inst[mgr].mgr__std__oob_type         ;
        assign  mgr__std__oob_data                [mgr]         =  mgr_inst[mgr].mgr__std__oob_data         ;
      end
  endgenerate


  //-------------------------------------------------------------------------------------------------
  // Stack Bus Downstream connections
  //`include "system_manager_stack_bus_downstream_instance_connections.vh"
  generate
    for (genvar mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1) 
      begin
        for (genvar lane=0; lane<`MGR_NUM_OF_EXEC_LANES ; lane=lane+1) 
          begin
            for (genvar strm=0; strm<`MGR_NUM_OF_STREAMS ; strm=strm+1) 
              begin
                assign  mgr_inst[mgr].std__mgr__lane_strm_ready      [lane] [strm]   =  std__mgr__lane_strm_ready                    [mgr] [lane] [strm]     ;
                assign  mgr__std__lane_strm_cntl               [mgr] [lane] [strm]   =  mgr_inst[mgr].mgr__std__lane_strm_cntl             [lane] [strm]     ;
                assign  mgr__std__lane_strm_data               [mgr] [lane] [strm]   =  mgr_inst[mgr].mgr__std__lane_strm_data             [lane] [strm]     ;
                assign  mgr__std__lane_strm_data_valid         [mgr] [lane] [strm]   =  mgr_inst[mgr].mgr__std__lane_strm_data_valid       [lane] [strm]     ;
              end
          end
      end
  endgenerate


  //-------------------------------------------------------------------------------------------------
  // Stack Bus Upstream connections
  //`include "system_manager_stack_bus_upstream_instance_connections.vh"
  generate
    for (genvar mgr=0; mgr<`MGR_ARRAY_NUM_OF_MGR; mgr=mgr+1) 
      begin
        assign   mgr_inst[mgr].stu__mgr__valid           =   stu__mgr__valid                [mgr]   ;
        assign   mgr_inst[mgr].stu__mgr__cntl            =   stu__mgr__cntl                 [mgr]   ;
        assign   mgr__stu__ready                  [mgr]  =   mgr_inst[mgr].mgr__stu__ready          ;
        assign   mgr_inst[mgr].stu__mgr__type            =   stu__mgr__type                 [mgr]   ;
        assign   mgr_inst[mgr].stu__mgr__data            =   stu__mgr__data                 [mgr]   ;
        assign   mgr_inst[mgr].stu__mgr__oob_data        =   stu__mgr__oob_data             [mgr]   ;
      end
  endgenerate


  //-------------------------------------------------------------------------------------------------
  // Inter Manager NoC Connectivity      
  `include "noc_interMgr_connections.vh"
  `include "noc_interMgr_port_Bitmask_assignments.vh"



endmodule  /*managerArray*/

