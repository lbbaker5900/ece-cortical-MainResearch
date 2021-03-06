/*********************************************************************************************

    File name   : manager.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor Manager.
                  It runs work-units, reads dat from the dram and sends to he PE, takes upstream data from the
                  PE and writes it back to DRAM (locally or thru the NoC.

*********************************************************************************************/
    
`timescale 1ns/10ps


//--------------------------------------------------
// RTL related defines
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "wu_memory.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "mgr_noc_cntl.vh"
`include "mwc_cntl.vh"
`include "main_mem_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mgr_cntl.vh"

module manager (

            //--------------------------------------------------------------------------------
            // DFI Interface to DRAM
            //
            output   wire                                      clk_diram_cntl_ck   ,  // Control group clock
            output   wire                                      dfi__phy__cs        ,
            output   wire                                      dfi__phy__cmd1      ,
            output   wire                                      dfi__phy__cmd0      ,
            output   wire  [`MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__bank      ,
            output   wire  [`MGR_DRAM_PHY_ADDRESS_RANGE     ]  dfi__phy__addr      ,
                                                                                   
            output   wire  [`MGR_DRAM_CLK_GROUP_RANGE       ]  clk_diram_data_ck   ,  // Data group clocks
            output   wire  [`MGR_DRAM_INTF_RANGE            ]  dfi__phy__data      ,
            output   wire  [`MGR_DRAM_INTF_MASK_RANGE       ]  dfi__phy__data_mask ,

            //--------------------------------------------------------------------------------
            // DFI Interface from DRAM
            //
            input   wire  [`MGR_DRAM_CLK_GROUP_RANGE        ]  clk_diram_cq    ,
            input   wire  [`MGR_DRAM_CLK_GROUP_RANGE        ]  phy__dfi__valid ,
            input   wire  [`MGR_DRAM_INTF_RANGE             ]  phy__dfi__data  ,

            //-------------------------------
            // NoC
            //
            //`include "manager_noc_cntl_noc_ports_and_declaration.vh"
            // port
            output   wire                                         mgr__noc__port_valid            [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ],
            output   wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  mgr__noc__port_cntl             [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ],
            output   wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  mgr__noc__port_data             [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ],
            input    wire                                         noc__mgr__port_fc               [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ],
            input    wire                                         noc__mgr__port_valid            [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ],
            input    wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  noc__mgr__port_cntl             [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ],
            input    wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__mgr__port_data             [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ],
            output   wire                                         mgr__noc__port_fc               [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ],
            input    wire   [`MGR_HOST_MGR_ID_BITMASK_RANGE    ]  sys__mgr__port_destinationMask  [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ],


            //-------------------------------
            // Stack Bus - OOB Downstream
            //
            // OOB controls how the lanes are interpreted
            output  wire [`COMMON_STD_INTF_CNTL_RANGE     ]    mgr__std__oob_cntl        , 
            output  wire                                       mgr__std__oob_valid       , 
            input   wire                                       std__mgr__oob_ready       , 
            output  wire [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]    mgr__std__oob_type        , 
            output  wire [`STACK_DOWN_OOB_INTF_DATA_RANGE ]    mgr__std__oob_data        , 

            //-------------------------------
            // Stack Bus - Downstream
            //
            //`include "manager_stack_bus_downstream_ports_and_declaration.vh"
            // Lane operand bus                  
            input   wire                                            std__mgr__lane_strm_ready      [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ,
            output  wire [`COMMON_STD_INTF_CNTL_RANGE       ]       mgr__std__lane_strm_cntl       [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ,
            output  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       mgr__std__lane_strm_data       [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ,
            output  wire                                            mgr__std__lane_strm_data_valid [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ,


            //-------------------------------
            // Stack Bus - Upstream
            //
            input   wire                                    stu__mgr__valid         ,
            input   wire [`COMMON_STD_INTF_CNTL_RANGE   ]   stu__mgr__cntl          ,
            output  wire                                    mgr__stu__ready         ,
            input   wire [`STACK_UP_INTF_TYPE_RANGE     ]   stu__mgr__type          ,  // Control or Data, Vector or scalar
            input   wire [`STACK_UP_INTF_DATA_RANGE     ]   stu__mgr__data          ,
            input   wire [`STACK_UP_INTF_OOB_DATA_RANGE ]   stu__mgr__oob_data      ,
 
            //-------------------------------
            // General control and status 
            output  wire                                    mgr__sys__allSynchronized     , 
            input   wire                                    sys__mgr__thisSynchronized    , 
            input   wire                                    sys__mgr__ready               , 
            input   wire                                    sys__mgr__complete            , 
                    
            //-------------------------------
            // General
            //
            input   wire  [`MGR_MGR_ID_RANGE            ]   sys__mgr__mgrId ,
                    
            //--------------------------------------------------------------------------------
            // Clocks for SDR/DDR
            input   wire                                    clk_diram       ,
            input   wire                                    clk_diram2x     ,
                                                           
            //--------------------------------------------------------------------------------
            // General
            input   wire                                    clk             ,
            input   wire                                    reset_poweron  
 
    );



  //-------------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------
  // Regs and Wires
  

  //-------------------------------------------------------------------------------------------------
  // Configuration
  //
  wire  [`MGR_WU_ADDRESS_RANGE    ]     mcntl__wuf__start_addr  ;  // first WU address
  wire                                  mcntl__wuf__enable      ;

  wire                                  mcntl__wuf__stall       ;
  wire                                  mcntl__wuf__release     ;
  wire                                  wuf__mcntl__stalled     ;

  wire                                  mcntl__wud__stall       ;
  wire                                  mcntl__wud__release     ;
  wire                                  wud__mcntl__stalled     ;


  wire  [`MGR_CNTL_STORAGE_DESC_USERS_RANGE             ]    mcntl__xxx__enable_sdmem_dnld   ;
  wire                                                       mcntl__xxx__sdmem_valid         ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__xxx__sdmem_cntl          ;  // interface delineator
  wire  [`MGR_CNTL_STORAGE_DESC_USERS_RANGE             ]    xxx__mcntl__sdmem_ready         ;

  wire  [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE          ]    mcntl__xxx__sdmem_address       ;
  wire  [`MGR_DRAM_ADDRESS_RANGE                        ]    mcntl__xxx__sdmem_addr          ;
  wire  [`MGR_INST_OPTION_ORDER_RANGE                   ]    mcntl__xxx__sdmem_order         ;
  wire  [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__xxx__sdmem_consJump_ptr  ;


  wire  [`MGR_CNTL_STORAGE_DESC_USERS_RANGE             ]    mcntl__xxx__enable_cjmem_dnld   ;
  wire                                                       mcntl__xxx__cjmem_valid         ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__xxx__cjmem_cntl          ;  // interface delineator
  wire  [`MGR_CNTL_STORAGE_DESC_USERS_RANGE             ]    xxx__mcntl__cjmem_ready         ;

  wire  [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__xxx__cjmem_address       ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__xxx__cjmem_consJump_cntl ;
  wire  [`MGR_INST_CONS_JUMP_FIELD_RANGE                ]    mcntl__xxx__cjmem_consJump_val  ;

  //-------------------------------------------------------------------------------------------------
  // NoC
  //

   // Data-Path (dp) to NoC 
   wire                                             rdp__mcntl__noc_valid      ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__mcntl__noc_cntl       ; 
   wire                                             mcntl__rdp__noc_ready      ; 
   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__mcntl__noc_type       ; 
   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__mcntl__noc_ptype      ; 
   wire [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  rdp__mcntl__noc_desttype   ; 
   wire                                             rdp__mcntl__noc_pvalid     ; 
   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__mcntl__noc_data       ; 

   // Control-Path (cp) to NoC 
   wire                                             mcntl__noc__cp_valid    ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ]  mcntl__noc__cp_cntl     ; 
   wire                                             noc__mcntl__cp_ready    ; 
   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  mcntl__noc__cp_type     ; 
   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  mcntl__noc__cp_ptype    ; 
   wire [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  mcntl__noc__cp_desttype ; 
   wire                                             mcntl__noc__cp_pvalid   ; 
   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  mcntl__noc__cp_data     ; 

   // Data-Path (dp) to NoC 
   wire                                             mcntl__noc__dp_valid    ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ]  mcntl__noc__dp_cntl     ; 
   wire                                             noc__mcntl__dp_ready    ; 
   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  mcntl__noc__dp_type     ; 
   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  mcntl__noc__dp_ptype    ; 
   wire [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  mcntl__noc__dp_desttype ; 
   wire                                             mcntl__noc__dp_pvalid   ; 
   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  mcntl__noc__dp_data     ; 

   // Data-Path (cp) from NoC 
   wire                                             noc__mcntl__cp_valid    ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ]  noc__mcntl__cp_cntl     ; 
   wire                                             mcntl__noc__cp_ready    ; 
   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  noc__mcntl__cp_type     ; 
   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  noc__mcntl__cp_ptype    ; 
   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  noc__mcntl__cp_data     ; 
   wire                                             noc__mcntl__cp_pvalid   ; 
   wire [`MGR_ARRAY_HOST_ID_RANGE                ]  noc__mcntl__cp_mgrId    ; 

   // Data-Path (dp) from NoC 
   wire                                             noc__mcntl__dp_valid    ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ]  noc__mcntl__dp_cntl     ; 
   wire                                             mcntl__noc__dp_ready    ; 
   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  noc__mcntl__dp_type     ; 
   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  noc__mcntl__dp_ptype    ; 
   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  noc__mcntl__dp_data     ; 
   wire                                             noc__mcntl__dp_pvalid   ; 
   wire [`MGR_ARRAY_HOST_ID_RANGE                ]  noc__mcntl__dp_mgrId    ; 

  //-------------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------
  // Instances
  //

  //-------------------------------------------------------------------------------------------------
  // WU Fetch
  // 

  wire  [`MGR_WU_ADDRESS_RANGE    ]     wuf__wum__addr       ;
  wire                                  wuf__wum__read       ; 
  wire                                  wum__wuf__stall      ; 

  wu_fetch wu_fetch (
  
            //-------------------------------
            // To WU memory
            .wuf__wum__read          ( wuf__wum__read           ),
            .wuf__wum__addr          ( wuf__wum__addr           ),

            //-------------------------------
            // Control
            .mcntl__wuf__enable      ( mcntl__wuf__enable       ),
            .mcntl__wuf__start_addr  ( mcntl__wuf__start_addr   ),
        
            //-------------------------------
            // 
            .mcntl__wuf__stall       ( mcntl__wuf__stall        ),
            .mcntl__wuf__release     ( mcntl__wuf__release      ),
            .wuf__mcntl__stalled     ( wuf__mcntl__stalled      ),
        
            .wum__wuf__stall         ( wum__wuf__stall          ),
        
            //-------------------------------
            // General
            .clk                     ( clk                      ),
            .reset_poweron           ( reset_poweron            )
        );


  //-------------------------------------------------------------------------------------------------
  // WU Memory
  // 
  // Instruction download from mcntl
  wire                                       mcntl__wum__enable_inst_dnld                             ;
  wire                                       mcntl__wum__valid                                        ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE    ]    mcntl__wum__cntl                                         ;
  wire                                       wum__mcntl__ready                                        ;

  wire  [`MGR_WU_ADDRESS_RANGE          ]    mcntl__wum__address                                      ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE    ]    mcntl__wum__icntl                                        ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE    ]    mcntl__wum__dcntl                                        ;
  wire  [`MGR_INST_TYPE_RANGE           ]    mcntl__wum__op                                           ;
  wire  [`MGR_WU_OPT_TYPE_RANGE         ]    mcntl__wum__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;
  wire  [`MGR_WU_OPT_VALUE_RANGE        ]    mcntl__wum__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;

  // to WUD
  wire                                       wum__wud__valid       ; 
  wire                                       wud__wum__ready       ; 
  wire  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl       ;  // instruction delineator
  wire  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl       ;  // descriptor delineator
  wire  [`MGR_INST_TYPE_RANGE           ]    wum__wud__op          ;  // NOP, OP, MR, MW
  // WU Instruction option fields
  wire  [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST ] ;  // 
  wire  [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST ] ;  // 

  wire  [`WUM_MAX_INST_RANGE            ]    wum__mcntl__inst_count  ;  // instruction count

  wu_memory wu_memory (
  
            //-------------------------
            // Configuration
            // - instruction download
            .mcntl__wum__enable_inst_dnld  ( mcntl__wum__enable_inst_dnld  ),
            .mcntl__wum__valid             ( mcntl__wum__valid             ),
            .mcntl__wum__cntl              ( mcntl__wum__cntl              ),  // interface delineator
            .wum__mcntl__ready             ( wum__mcntl__ready             ),
            
            .mcntl__wum__address           ( mcntl__wum__address           ),  // IM address
                                                                               // instruction contents
            .mcntl__wum__icntl             ( mcntl__wum__icntl             ),  // IM instruction delineator
            .mcntl__wum__dcntl             ( mcntl__wum__dcntl             ),  // IM descriptor delineator
            .mcntl__wum__op                ( mcntl__wum__op                ),
            .mcntl__wum__option_type       ( mcntl__wum__option_type       ),
            .mcntl__wum__option_value      ( mcntl__wum__option_value      ),
                                                                           
            //-------------------------
            // From WU fetch                                               
            .wuf__wum__read                ( wuf__wum__read                ),
            .wuf__wum__addr                ( wuf__wum__addr                ),
            .wum__wuf__stall               ( wum__wuf__stall               ),
                                                                           
            //-------------------------
            // To WU decode                                                
            .wum__wud__valid               ( wum__wud__valid               ),
            .wud__wum__ready               ( wud__wum__ready               ),
            .wum__wud__icntl               ( wum__wud__icntl               ),
            .wum__wud__dcntl               ( wum__wud__dcntl               ),
            .wum__wud__op                  ( wum__wud__op                  ),
            .wum__wud__option_type         ( wum__wud__option_type         ),
            .wum__wud__option_value        ( wum__wud__option_value        ),
                                                                           
            //-------------------------
            // Config/Status                                               
            .wum__mcntl__inst_count        ( wum__mcntl__inst_count        ),
                                                                           
            //-------------------------
            // General                                                     
            .sys__mgr__mgrId               ( sys__mgr__mgrId               ),
                                                                           
            .clk                           ( clk                           ),
            .reset_poweron                 ( reset_poweron                 )
        );

  //-------------------------------------------------------------------------------------------------
  // WU decode
  // 

  wire                                          wud__mcntl__valid         ;
  wire                                          mcntl__wud__ready         ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__mcntl__dcntl         ; 
  wire   [`MGR_STD_OOB_TAG_RANGE         ]      wud__mcntl__tag           ;
  wire   [`MGR_WU_OPT_TYPE_RANGE         ]      wud__mcntl__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__mcntl__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;

  wire                                          wud__odc__valid         ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__odc__cntl          ;
  wire                                          odc__wud__ready         ;
  wire   [`MGR_STD_OOB_TAG_RANGE         ]      wud__odc__tag           ;
  wire   [`MGR_NUM_LANES_RANGE           ]      wud__odc__num_lanes     ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__stOp_cmd      ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__simd_cmd      ;

  wire                                          wud__mrc0__valid         ;
  wire                                          mrc0__wud__ready         ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__mrc0__cntl          ; 
  wire   [`MGR_WU_OPT_TYPE_RANGE         ]      wud__mrc0__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__mrc0__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;
  wire   [`MGR_STD_OOB_TAG_RANGE         ]      wud__mrc0__tag           ;

  wire                                          wud__mrc1__valid         ;
  wire                                          mrc1__wud__ready         ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__mrc1__cntl          ; 
  wire   [`MGR_WU_OPT_TYPE_RANGE         ]      wud__mrc1__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__mrc1__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;
  wire   [`MGR_STD_OOB_TAG_RANGE         ]      wud__mrc1__tag           ;

  wire                                          wud__rdp__valid         ;
  wire                                          rdp__wud__ready         ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__rdp__dcntl         ; 
  wire   [`MGR_STD_OOB_TAG_RANGE         ]      wud__rdp__tag           ;
  wire   [`MGR_WU_OPT_TYPE_RANGE         ]      wud__rdp__option_type    [`MGR_WU_OPT_PER_INST ] ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__rdp__option_value   [`MGR_WU_OPT_PER_INST ] ;


  wu_decode wu_decode (
  
            //-------------------------------
            // System Controller
            // - control
            .mcntl__wud__stall         ( mcntl__wud__stall         ),
            .mcntl__wud__release       ( mcntl__wud__release       ),
            .wud__mcntl__stalled       ( wud__mcntl__stalled       ),

            // - descriptors
            .wud__mcntl__valid         ( wud__mcntl__valid         ),
            .wud__mcntl__dcntl         ( wud__mcntl__dcntl         ),  // used to delineate descriptor
            .mcntl__wud__ready         ( mcntl__wud__ready         ),
            .wud__mcntl__tag           ( wud__mcntl__tag           ),  // Use this to match with WU and take all the data 
            .wud__mcntl__option_type   ( wud__mcntl__option_type   ),  // Only send tuples
            .wud__mcntl__option_value  ( wud__mcntl__option_value  ),
        
            //-------------------------------
            // from WU Memory
            .wum__wud__valid           ( wum__wud__valid           ),
            .wud__wum__ready           ( wud__wum__ready           ),
            .wum__wud__icntl           ( wum__wud__icntl           ),
            .wum__wud__dcntl           ( wum__wud__dcntl           ),
            .wum__wud__op              ( wum__wud__op              ),
            .wum__wud__option_type     ( wum__wud__option_type     ),
            .wum__wud__option_value    ( wum__wud__option_value    ),
         
            //-------------------------------
            // Stack Down OOB driver
            //
            .wud__odc__valid           ( wud__odc__valid           ),
            .wud__odc__cntl            ( wud__odc__cntl            ),  // used to delineate upstream packet data
            .odc__wud__ready           ( odc__wud__ready           ),
            .wud__odc__tag             ( wud__odc__tag             ),  // Use this to match with WU and take all the data 
            .wud__odc__num_lanes       ( wud__odc__num_lanes       ),  // The data may vary so check for cntl=EOD when reading this interface
            .wud__odc__stOp_cmd        ( wud__odc__stOp_cmd        ),  // The data may vary so check for cntl=EOD when reading this interface
            .wud__odc__simd_cmd        ( wud__odc__simd_cmd        ),  // The data may vary so check for cntl=EOD when reading this interface
         
            //-------------------------------
            // Main Manager Controller
            //

            //-------------------------------
            // Return Data Processor
            //
            .wud__rdp__valid           ( wud__rdp__valid           ),
            .wud__rdp__dcntl           ( wud__rdp__dcntl           ),  // used to delineate descriptor
            .rdp__wud__ready           ( rdp__wud__ready           ),
            .wud__rdp__tag             ( wud__rdp__tag             ),  // Use this to match with WU and take all the data 
            .wud__rdp__option_type     ( wud__rdp__option_type     ),  // Only send tuples
            .wud__rdp__option_value    ( wud__rdp__option_value    ),
                                                                   
            //-------------------------------
            // Memory Read Controller
            //
            .wud__mrc0__valid          ( wud__mrc0__valid          ),
            .wud__mrc0__cntl           ( wud__mrc0__cntl           ),  // used to delineate descriptor
            .mrc0__wud__ready          ( mrc0__wud__ready          ),
            .wud__mrc0__option_type    ( wud__mrc0__option_type    ),  // Only send tuples
            .wud__mrc0__option_value   ( wud__mrc0__option_value   ),
            .wud__mrc0__tag            ( wud__mrc0__tag            ), 
                                                                   
            .wud__mrc1__valid          ( wud__mrc1__valid          ),
            .wud__mrc1__cntl           ( wud__mrc1__cntl           ),  // used to delineate descriptor
            .mrc1__wud__ready          ( mrc1__wud__ready          ),
            .wud__mrc1__option_type    ( wud__mrc1__option_type    ),  // Only send tuples
            .wud__mrc1__option_value   ( wud__mrc1__option_value   ),
            .wud__mrc1__tag            ( wud__mrc1__tag            ), 
         
         
            //-------------------------------
            // General
            .sys__mgr__mgrId         ( sys__mgr__mgrId          ),
            .clk                     ( clk                      ),
            .reset_poweron           ( reset_poweron            ) 
        );

  //-------------------------------------------------------------------------------------------------
  // OOB Downstream Transmitter
  // 

  oob_downstream_cntl oob_downstream_cntl (
  
            //-------------------------------
            // From WU Decoder
            //
            .wud__odc__valid            ( wud__odc__valid      ),
            .wud__odc__cntl             ( wud__odc__cntl       ),  // used to delineate upstream packet data
            .odc__wud__ready            ( odc__wud__ready      ),
            .wud__odc__tag              ( wud__odc__tag        ),  // Use this to match with WU and take all the data 
            .wud__odc__num_lanes        ( wud__odc__num_lanes  ),  // The data may vary so check for cntl=EOD when reading this interface
            .wud__odc__stOp_cmd         ( wud__odc__stOp_cmd   ),  // The data may vary so check for cntl=EOD when reading this interface
            .wud__odc__simd_cmd         ( wud__odc__simd_cmd   ),  // The data may vary so check for cntl=EOD when reading this interface
          
            //-------------------------------
            // Stack Bus - OOB Downstream
            // FIXME: currently driven by testbench
            `ifndef TB_DRIVES_OOB_PACKET
              .mgr__std__oob_cntl       ( mgr__std__oob_cntl   ), 
              .mgr__std__oob_valid      ( mgr__std__oob_valid  ), 
              .std__mgr__oob_ready      ( std__mgr__oob_ready  ), 
              .mgr__std__oob_type       ( mgr__std__oob_type   ), 
              .mgr__std__oob_data       ( mgr__std__oob_data   ), 
            `else
              .mgr__std__oob_cntl       (                      ), 
              .mgr__std__oob_valid      (                      ), 
              .std__mgr__oob_ready      ( std__mgr__oob_ready  ), 
              .mgr__std__oob_type       (                      ), 
              .mgr__std__oob_data       (                      ), 
            `endif
          
            //-------------------------------
            // General
            .sys__mgr__mgrId            ( sys__mgr__mgrId      ),
            .clk                        ( clk                  ),
            .reset_poweron              ( reset_poweron        ) 
        );


  //-------------------------------------------------------------------------------------------------
  // Memory Read Controller 
  //  - instance for each argument

  genvar gvi;
  generate
    for (gvi=0; gvi<`MGR_NUM_OF_STREAMS; gvi=gvi+1) 
      begin: mrc_cntl_strm_inst

        //----------------------------------------------------------------------------------------------------
        // DMA to NoC (via mcntl)
        wire [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ]      mrc__mcntl__lane_valid                                       ;
        wire [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mcntl__lane_cntl     [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ];
        wire [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ]      mcntl__mrc__lane_ready                                       ;
        wire [`MGR_STD_LANE_DATA_RANGE         ]      mrc__mcntl__lane_data     [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ];

        //----------------------------------------------------------------------------------------------------
        // Stack Downstream
        wire  [`MGR_NUM_OF_EXEC_LANES_RANGE     ]   std__mrc__lane_ready                                 ;
        wire  [`COMMON_STD_INTF_CNTL_RANGE      ]   mrc__std__lane_cntl   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
        wire  [`STACK_DOWN_INTF_STRM_DATA_RANGE ]   mrc__std__lane_data   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
        wire  [`MGR_NUM_OF_EXEC_LANES_RANGE     ]   mrc__std__lane_valid                                 ;
      
        //----------------------------------------------------------------------------------------------------
        // WU Decoder
        wire                                        wud__mrc__valid                                      ;  // send MR descriptors
        wire  [`COMMON_STD_INTF_CNTL_RANGE      ]   wud__mrc__cntl                                       ;  // descriptor delineator
        wire  [`MGR_STD_OOB_TAG_RANGE           ]   wud__mrc__tag                                        ;  // mmc needs to service tag requests before tag+1
        wire                                        mrc__wud__ready                                      ;
        wire  [`MGR_WU_OPT_TYPE_RANGE           ]   wud__mrc__option_type   [`MGR_WU_OPT_PER_INST_RANGE ];  // WU Instruction option fields
        wire  [`MGR_WU_OPT_VALUE_RANGE          ]   wud__mrc__option_value  [`MGR_WU_OPT_PER_INST_RANGE ];  

        //----------------------------------------------------------------------------------------------------
        // Main memory Controller
        wire                                           mrc__mmc__valid      ;
        wire  [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mmc__cntl       ;
        wire  [`MGR_STD_OOB_TAG_RANGE           ]      mrc__mmc__tag        ;  // mmc needs to service tag requests before tag+1
        wire                                           mmc__mrc__ready      ;
        wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      mrc__mmc__channel    ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      mrc__mmc__bank       ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      mrc__mmc__page       ;
        wire  [`MGR_DRAM_WORD_ADDRESS_RANGE     ]      mrc__mmc__word       ;
                                                                                                           
        wire                                                                          mmc__mrc__valid [`MGR_DRAM_NUM_CHANNELS ] ;
        wire  [`COMMON_STD_INTF_CNTL_RANGE          ]                                 mmc__mrc__cntl  [`MGR_DRAM_NUM_CHANNELS ] ;
        wire                                                                          mrc__mmc__ready [`MGR_DRAM_NUM_CHANNELS ] ;
        wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  mmc__mrc__data  [`MGR_DRAM_NUM_CHANNELS ] ;

        mrc_cntl mrc_cntl (
        
                //-------------------------------
                // from WU Decoder
                //
                .wud__mrc__valid         ( wud__mrc__valid         ),
                .wud__mrc__cntl          ( wud__mrc__cntl          ),  // used to delineate descriptor
                .wud__mrc__tag           ( wud__mrc__tag           ), 
                .mrc__wud__ready         ( mrc__wud__ready         ),
                .wud__mrc__option_type   ( wud__mrc__option_type   ),  // Only send tuples
                .wud__mrc__option_value  ( wud__mrc__option_value  ),
      
                //-------------------------------
                // to NoC (via mcntl)
                //
                .mcntl__mrc__lane_ready  ( mcntl__mrc__lane_ready  ),
                .mrc__mcntl__lane_cntl   ( mrc__mcntl__lane_cntl   ),
                .mrc__mcntl__lane_data   ( mrc__mcntl__lane_data   ),
                .mrc__mcntl__lane_valid  ( mrc__mcntl__lane_valid  ),
      
                //-------------------------------
                // to Stack Downstream lanes
                //
                .std__mrc__lane_ready    ( std__mrc__lane_ready    ),
                .mrc__std__lane_cntl     ( mrc__std__lane_cntl     ),
                .mrc__std__lane_data     ( mrc__std__lane_data     ),
                .mrc__std__lane_valid    ( mrc__std__lane_valid    ),
      
                //-------------------------------
                // to/from MMC
                //
                .mrc__mmc__valid         ( mrc__mmc__valid         ),                         
                .mrc__mmc__cntl          ( mrc__mmc__cntl          ),                         
                .mrc__mmc__tag           ( mrc__mmc__tag           ),                         
                .mmc__mrc__ready         ( mmc__mrc__ready         ),                         
                .mrc__mmc__channel       ( mrc__mmc__channel       ),                         
                .mrc__mmc__bank          ( mrc__mmc__bank          ),                         
                .mrc__mmc__page          ( mrc__mmc__page          ),                         
                .mrc__mmc__word          ( mrc__mmc__word          ),                         
                                                                                           
                .mmc__mrc__valid         ( mmc__mrc__valid         ),                         
                .mmc__mrc__cntl          ( mmc__mrc__cntl          ),                         
                .mrc__mmc__ready         ( mrc__mmc__ready         ),                         
                .mmc__mrc__data          ( mmc__mrc__data          ),                         

                //-------------------------------
                // storage descriptor and cons/jump memory download
                //
                .mcntl__sdp__enable_sdmem_dnld    ( mcntl__xxx__enable_sdmem_dnld [gvi] ),  // MRC0 is sdmem user 0, MRC1 is user 1 (see macro MGR_CNTL_STORAGE_DESC_USERS_MRC0 and MRC1)
                                                  
                .mcntl__sdp__sdmem_valid          ( mcntl__xxx__sdmem_valid             ),
                .mcntl__sdp__sdmem_cntl           ( mcntl__xxx__sdmem_cntl              ),
                .sdp__mcntl__sdmem_ready          ( xxx__mcntl__sdmem_ready       [gvi] ),  // MRC0 is sdmem user 0, MRC1 is user 1 (see macro MGR_CNTL_STORAGE_DESC_USERS_MRC0 and MRC1)
                                                  
                .mcntl__sdp__sdmem_address        ( mcntl__xxx__sdmem_address           ),
                .mcntl__sdp__sdmem_addr           ( mcntl__xxx__sdmem_addr              ),
                .mcntl__sdp__sdmem_order          ( mcntl__xxx__sdmem_order             ),
                .mcntl__sdp__sdmem_consJump_ptr   ( mcntl__xxx__sdmem_consJump_ptr      ),
                                                  
                .mcntl__sdp__enable_cjmem_dnld    ( mcntl__xxx__enable_cjmem_dnld [gvi] ),  // MRC0 is cjmem user 0, MRC1 is user 1 (see macro MGR_CNTL_STORAGE_DESC_USERS_MRC0 and MRC1)
                                                  
                .mcntl__sdp__cjmem_valid          ( mcntl__xxx__cjmem_valid             ),
                .mcntl__sdp__cjmem_cntl           ( mcntl__xxx__cjmem_cntl              ),
                .sdp__mcntl__cjmem_ready          ( xxx__mcntl__cjmem_ready       [gvi] ),  // MRC0 is cjmem user 0, MRC1 is user 1 (see macro MGR_CNTL_STORAGE_DESC_USERS_MRC0 and MRC1)
                                                  
                .mcntl__sdp__cjmem_address        ( mcntl__xxx__cjmem_address           ),
                .mcntl__sdp__cjmem_consJump_cntl  ( mcntl__xxx__cjmem_consJump_cntl     ),
                .mcntl__sdp__cjmem_consJump_val   ( mcntl__xxx__cjmem_consJump_val      ),

                //-------------------------------
                // General
                //
                .sys__mgr__mgrId         ( sys__mgr__mgrId         ),
                .clk                     ( clk                     ),
                .reset_poweron           ( reset_poweron           ) 
              );

      end
  endgenerate

  //------------------------------------------------------------------------------------------------------------------------
  // Main Memory Controller interface
  //
  //----------------------------------------------------------------------------------------------------
  // Request
  wire  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE  ]      xxx__mmc__valid                                ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE      ]      xxx__mmc__cntl    [`MMC_CNTL_NUM_OF_INTF ]     ;
  wire  [`MGR_STD_OOB_TAG_RANGE           ]      xxx__mmc__tag     [`MMC_CNTL_NUM_OF_INTF ]     ; // mmc needs to service tag requests before tag+1
//  wire  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE  ]      xxx__mmc__read                                 ;
  wire  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE  ]      mmc__xxx__ready                                ;
  wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      xxx__mmc__channel [`MMC_CNTL_NUM_OF_INTF ]     ;
  wire  [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      xxx__mmc__bank    [`MMC_CNTL_NUM_OF_INTF ]     ;
  wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      xxx__mmc__page    [`MMC_CNTL_NUM_OF_INTF ]     ;
  wire  [`MGR_DRAM_WORD_ADDRESS_RANGE     ]      xxx__mmc__word    [`MMC_CNTL_NUM_OF_INTF ]     ;
                                                                          
  //----------------------------------------------------------------------------------------------------
  // Read Data
  //
  // MMC provides data from each DRAM channel
  // - response must be in order of request
  wire  [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE  ]                                 mmc__xxx__valid [`MGR_DRAM_NUM_CHANNELS ]                        ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE           ]                                 mmc__xxx__cntl  [`MGR_DRAM_NUM_CHANNELS ] [`MMC_CNTL_NUM_OF_READ_INTF ] ;
  wire  [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE  ]                                 xxx__mmc__ready [`MGR_DRAM_NUM_CHANNELS ]                        ;
  wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE  ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   mmc__xxx__data  [`MGR_DRAM_NUM_CHANNELS ] [`MMC_CNTL_NUM_OF_READ_INTF ] ;


  //----------------------------------------------------------------------------------------------------
  // Write Data
  //
  wire  [`MMC_CNTL_NUM_OF_WRITE_INTF_VEC_RANGE ]                                 xxx__mmc__data_valid                                  ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE           ]                                 xxx__mmc__data_cntl    [`MMC_CNTL_NUM_OF_WRITE_INTF ] ;
  wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE       ]                                 xxx__mmc__data_channel [`MMC_CNTL_NUM_OF_WRITE_INTF ] ;
  wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE  ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  xxx__mmc__data         [`MMC_CNTL_NUM_OF_WRITE_INTF ] ;
  wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE  ]                                 xxx__mmc__data_mask    [`MMC_CNTL_NUM_OF_WRITE_INTF ] ;
  wire  [`MMC_CNTL_NUM_OF_WRITE_INTF_VEC_RANGE ]                                 mmc__xxx__data_ready                                  ;
                                                                                                     

  //----------------------------------------------------------------------------------------------------
  // DFI
  wire                                                                           dfi__mmc__init_done                              ;
  wire                                                                           dfi__mmc__valid      [`MGR_DRAM_NUM_CHANNELS ]   ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE           ]                                 dfi__mmc__cntl       [`MGR_DRAM_NUM_CHANNELS ]   ;
  wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE  ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   dfi__mmc__data       [`MGR_DRAM_NUM_CHANNELS ]   ;
  wire                                                                           mmc__dfi__cs         [`MGR_DRAM_NUM_CHANNELS ]   ;
  wire                                                                           mmc__dfi__cmd0       [`MGR_DRAM_NUM_CHANNELS ]   ;
  wire                                                                           mmc__dfi__cmd1       [`MGR_DRAM_NUM_CHANNELS ]   ;
  wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE  ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   mmc__dfi__data       [`MGR_DRAM_NUM_CHANNELS ]   ;
  wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE  ]                                 mmc__dfi__data_mask  [`MGR_DRAM_NUM_CHANNELS ]   ;
  wire  [`MGR_DRAM_BANK_ADDRESS_RANGE          ]                                 mmc__dfi__bank       [`MGR_DRAM_NUM_CHANNELS ]   ;
  wire  [`MGR_DRAM_PHY_ADDRESS_RANGE           ]                                 mmc__dfi__addr       [`MGR_DRAM_NUM_CHANNELS ]   ;

  main_mem_cntl main_mem_cntl (

            //--------------------------------------------------------------------------------
            // Main Memory Controller interface
            //
            // Requests
            .xxx__mmc__valid         ( xxx__mmc__valid        ),
            .xxx__mmc__read          ( {1'b0, 1'b1, 1'b1}     ),  // mwc, mrc1, mrc0
            .xxx__mmc__cntl          ( xxx__mmc__cntl         ),
            .xxx__mmc__tag           ( xxx__mmc__tag          ),
            .mmc__xxx__ready         ( mmc__xxx__ready        ),
            .xxx__mmc__channel       ( xxx__mmc__channel      ),
            .xxx__mmc__bank          ( xxx__mmc__bank         ),
            .xxx__mmc__page          ( xxx__mmc__page         ),
            .xxx__mmc__word          ( xxx__mmc__word         ),
                                                           
            // Read Data
            .mmc__xxx__valid         ( mmc__xxx__valid        ),
            .mmc__xxx__cntl          ( mmc__xxx__cntl         ),
            .xxx__mmc__ready         ( xxx__mmc__ready        ),
            .mmc__xxx__data          ( mmc__xxx__data         ),
            
            // Write Data
            .xxx__mmc__data_valid    ( xxx__mmc__data_valid    ),                         
            .xxx__mmc__data_cntl     ( xxx__mmc__data_cntl     ),                         
            .xxx__mmc__data_channel  ( xxx__mmc__data_channel  ),                         
            .xxx__mmc__data          ( xxx__mmc__data          ),                         
            .xxx__mmc__data_mask     ( xxx__mmc__data_mask     ),                         
            .mmc__xxx__data_ready    ( mmc__xxx__data_ready    ),                         

            //--------------------------------------------------------------------------------
            // DFI Interface
            // - provide per channel signals
            // - DFI will handle SDR->DDR conversion
            .dfi__mmc__init_done     ( dfi__mmc__init_done    ),
            .dfi__mmc__valid         ( dfi__mmc__valid        ),
            .dfi__mmc__cntl          ( dfi__mmc__cntl         ),
            .dfi__mmc__data          ( dfi__mmc__data         ),
            .mmc__dfi__cs            ( mmc__dfi__cs           ),
            .mmc__dfi__cmd0          ( mmc__dfi__cmd0         ),
            .mmc__dfi__cmd1          ( mmc__dfi__cmd1         ),
            .mmc__dfi__data          ( mmc__dfi__data         ), 
            .mmc__dfi__data_mask     ( mmc__dfi__data_mask    ),
            .mmc__dfi__bank          ( mmc__dfi__bank         ),
            .mmc__dfi__addr          ( mmc__dfi__addr         ),

  
            //--------------------------------------------------------------------------------
            // General
            //
            .sys__mgr__mgrId         ( sys__mgr__mgrId         ),
            .clk                     ( clk                     ),
            .reset_poweron           ( reset_poweron           ) 
 
              );   

  genvar chan, strm, word ;
  generate
    for (strm=0; strm<`MGR_NUM_OF_STREAMS; strm=strm+1) 
      begin: mrc_mmc_connect
        assign    xxx__mmc__valid   [strm]                 =   mrc_cntl_strm_inst[strm].mrc__mmc__valid   ;
        assign    xxx__mmc__cntl    [strm]                 =   mrc_cntl_strm_inst[strm].mrc__mmc__cntl    ;
        assign    xxx__mmc__tag     [strm]                 =   mrc_cntl_strm_inst[strm].mrc__mmc__tag     ;
        assign    xxx__mmc__channel [strm]                 =   mrc_cntl_strm_inst[strm].mrc__mmc__channel ;
        assign    xxx__mmc__bank    [strm]                 =   mrc_cntl_strm_inst[strm].mrc__mmc__bank    ;
        assign    xxx__mmc__page    [strm]                 =   mrc_cntl_strm_inst[strm].mrc__mmc__page    ;
        assign    xxx__mmc__word    [strm]                 =   mrc_cntl_strm_inst[strm].mrc__mmc__word    ;
        assign    mrc_cntl_strm_inst[strm].mmc__mrc__ready =   mmc__xxx__ready   [strm]                   ;
      end
  endgenerate
  generate
    for (strm=0; strm<`MGR_NUM_OF_STREAMS; strm=strm+1) 
      begin: mmc_mrc_connect
        for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
          begin: mmc_mrc_chan_connect
            assign    mrc_cntl_strm_inst[strm].mmc__mrc__valid[chan] =   mmc__xxx__valid  [chan] [strm]                   ;
            assign    mrc_cntl_strm_inst[strm].mmc__mrc__cntl [chan] =   mmc__xxx__cntl   [chan] [strm]                   ;
            assign    mrc_cntl_strm_inst[strm].mmc__mrc__data [chan] =   mmc__xxx__data   [chan] [strm]                   ;

            assign    xxx__mmc__ready   [chan]                [strm] =   mrc_cntl_strm_inst[strm].mrc__mmc__ready[chan]   ;
          end
      end
  endgenerate

  dfi dfi( 
            //--------------------------------------------------------------------------------
            // DFI Interface from MMC
            // - provide per channel signals
            // - DFI will handle SDR->DDR conversion
            //
            .dfi__mmc__init_done  ( dfi__mmc__init_done    ),
            .dfi__mmc__valid      ( dfi__mmc__valid        ),
            .dfi__mmc__cntl       ( dfi__mmc__cntl         ),
            .dfi__mmc__data       ( dfi__mmc__data         ),
            .mmc__dfi__cs         ( mmc__dfi__cs           ),
            .mmc__dfi__cmd0       ( mmc__dfi__cmd0         ),
            .mmc__dfi__cmd1       ( mmc__dfi__cmd1         ),
            .mmc__dfi__data       ( mmc__dfi__data         ),
            .mmc__dfi__data_mask  ( mmc__dfi__data_mask    ),
            .mmc__dfi__bank       ( mmc__dfi__bank         ),
            .mmc__dfi__addr       ( mmc__dfi__addr         ),
            
            
            //--------------------------------------------------------------------------------
            // DFI Interface to DRAM
            //
            .clk_diram_cntl_ck    ( clk_diram_cntl_ck      ), 
            .dfi__phy__cs         ( dfi__phy__cs           ),
            .dfi__phy__cmd1       ( dfi__phy__cmd1         ),
            .dfi__phy__cmd0       ( dfi__phy__cmd0         ),
            .dfi__phy__addr       ( dfi__phy__addr         ),
            .dfi__phy__bank       ( dfi__phy__bank         ),
            .clk_diram_data_ck    ( clk_diram_data_ck      ), 
            .dfi__phy__data       ( dfi__phy__data         ),
            .dfi__phy__data_mask  ( dfi__phy__data_mask    ),
                                                           
            //--------------------------------------------------------------------------------
            // DFI Interface from DRAM                     
            //                                             
            .clk_diram_cq         ( clk_diram_cq           ),
            .phy__dfi__valid      ( phy__dfi__valid        ),
            .phy__dfi__data       ( phy__dfi__data         ),
            
            //--------------------------------------------------------------------------------
            // Clocks for SDR/DDR
            .clk_diram            ( clk_diram              ),
            .clk_diram2x          ( clk_diram2x            ),

            //-------------------------------
            // General
            //
            .clk                  ( clk                    ),
            .reset_poweron        ( reset_poweron          ) 
 

            );
    

  // Connect packed array port of MRC(s) to WU Decoder
  `include "manager_mrc_cntl_wud_connections.vh"
  
  //------------------------------------------------------------------------------------------------------------------------
  // Connect packed array port of MRC(s) to individual stack downstream wires
  //`include "manager_mrc_cntl_stack_bus_downstream_connections.vh"
  // Lane N                 
  // 
  generate
    for (genvar lane=0; lane<`MGR_NUM_OF_EXEC_LANES ; lane=lane+1) 
      begin
        for (genvar strm=0; strm<`MGR_NUM_OF_STREAMS ; strm=strm+1) 
          begin
            // Stream 
            assign mrc_cntl_strm_inst[strm].std__mrc__lane_ready [lane]              =   std__mgr__lane_strm_ready                     [lane] [strm] ;   
            assign mgr__std__lane_strm_cntl                      [lane] [strm]       =   mrc_cntl_strm_inst[strm].mrc__std__lane_cntl  [lane]        ; 
            assign mgr__std__lane_strm_data                      [lane] [strm]       =   mrc_cntl_strm_inst[strm].mrc__std__lane_data  [lane]        ; 
            assign mgr__std__lane_strm_data_valid                [lane] [strm]       =   mrc_cntl_strm_inst[strm].mrc__std__lane_valid [lane]        ; 
          end
      end
  endgenerate



  //-------------------------------------------------------------------------------------------------
  // Stack Upstream Interface
  // 
  wire                                          stuc__rdp__valid       ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rdp__cntl        ;
  wire                                          rdp__stuc__ready       ;
  wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rdp__tag         ;  // tag size is the same as sent to PE
  wire   [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rdp__data        ;
 
  wire                                          stuc__rcp__valid       ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rcp__cntl        ;
  wire                                          rcp__stuc__ready       ;
  wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rcp__tag         ;  // tag size is the same as sent to PE
  wire   [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rcp__data        ;

  stu_cntl stu_cntl (

            //-------------------------------
            // Stack Bus - Upstream
            //
            .stu__mgr__valid         ( stu__mgr__valid     ),
            .stu__mgr__cntl          ( stu__mgr__cntl      ),
            .mgr__stu__ready         ( mgr__stu__ready     ),
            //.mgr__stu__ready         ( ),
            .stu__mgr__type          ( stu__mgr__type      ),  
            .stu__mgr__data          ( stu__mgr__data      ),
            .stu__mgr__oob_data      ( stu__mgr__oob_data  ),
 
            //-------------------------------
            // Return data processor output
            //
            .stuc__rdp__valid         ( stuc__rdp__valid   ),
            .stuc__rdp__cntl          ( stuc__rdp__cntl    ),  // used to delineate upstream packet data
            .rdp__stuc__ready         ( rdp__stuc__ready   ),
            .stuc__rdp__tag           ( stuc__rdp__tag     ),  // Use this to match with WU and take all the data 
            .stuc__rdp__data          ( stuc__rdp__data    ),  // The data may vary so check for cntl=EOD when reading this interface

            //-------------------------------
            // Return Control packet processor output
            //  - TBD - may not use
            //
            .stuc__rcp__valid         ( stuc__rcp__valid   ),
            .stuc__rcp__cntl          ( stuc__rcp__cntl    ),  // used to delineate upstream packet data
            .rcp__stuc__ready         ( rcp__stuc__ready   ),
            .stuc__rcp__tag           ( stuc__rcp__tag     ),  // Use this to match with WU and take all the data 
            .stuc__rcp__data          ( stuc__rcp__data    ),  // The data may vary so check for cntl=EOD when reading this interface

            //-------------------------------
            // General
            //
            .clk                      ( clk                ),
            .reset_poweron            ( reset_poweron      ) 
 
    );

  //-------------------------------------------------------------------------------------------------
  // Response Data Processor
  // 

  // Memory Write Combine/Cache Interface
  wire                                                rdp__mwc__valid      ; 
  wire    [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__mwc__cntl       ; 
  wire                                                mwc__rdp__ready      ; 
  wire    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__mwc__type       ; 
  wire    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__mwc__ptype      ; 
  wire                                                rdp__mwc__pvalid     ; 
  wire    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__mwc__data       ; 

  rdp_cntl rdp_cntl (

            //-------------------------------
            // From Stack Upstream
            //
            .stuc__rdp__valid         ( stuc__rdp__valid       ),
            .stuc__rdp__cntl          ( stuc__rdp__cntl        ),  // used to delineate upstream packet data
            .rdp__stuc__ready         ( rdp__stuc__ready       ),
            .stuc__rdp__tag           ( stuc__rdp__tag         ),  // Use this to match with WU and take all the data 
            .stuc__rdp__data          ( stuc__rdp__data        ),  // The data may vary so check for cntl=EOD when reading this interface


            //-------------------------------
            // from WU Decoder
            //
            .wud__rdp__valid         ( wud__rdp__valid         ),
            .wud__rdp__dcntl         ( wud__rdp__dcntl         ),  // used to delineate descriptor
            .rdp__wud__ready         ( rdp__wud__ready         ),
            .wud__rdp__tag           ( wud__rdp__tag           ),  // Use this to match with WU and take all the data 
            .wud__rdp__option_type   ( wud__rdp__option_type   ),  // Only send tuples
            .wud__rdp__option_value  ( wud__rdp__option_value  ),

            //-------------------------------
            // to Memory Write Combine
            //   - make interface same/similar to NoC interface because memory write combine module will have to deal with NoC packets anyway
            .rdp__mwc__valid         ( rdp__mwc__valid         ), 
            .mwc__rdp__ready         ( mwc__rdp__ready         ), 
            .rdp__mwc__cntl          ( rdp__mwc__cntl          ), 
            .rdp__mwc__type          ( rdp__mwc__type          ), 
            .rdp__mwc__ptype         ( rdp__mwc__ptype         ), 
            .rdp__mwc__pvalid        ( rdp__mwc__pvalid        ), 
            .rdp__mwc__data          ( rdp__mwc__data          ), 

            //-------------------------------
            // to NoC (via mcntl)
            //
            // Data-Path (dp) to NoC                                     
            .rdp__mcntl__noc_valid      ( rdp__mcntl__noc_valid      ), 
            .mcntl__rdp__noc_ready      ( mcntl__rdp__noc_ready      ),
            .rdp__mcntl__noc_cntl       ( rdp__mcntl__noc_cntl       ), 
            .rdp__mcntl__noc_type       ( rdp__mcntl__noc_type       ), 
            .rdp__mcntl__noc_ptype      ( rdp__mcntl__noc_ptype      ), 
            .rdp__mcntl__noc_desttype   ( rdp__mcntl__noc_desttype   ), 
            .rdp__mcntl__noc_pvalid     ( rdp__mcntl__noc_pvalid     ), 
            .rdp__mcntl__noc_data       ( rdp__mcntl__noc_data       ), 

            //-------------------------------
            // Config
            //
            .cfg__rdp__check_tag     ( 1'b0                    ),  // FIXME: current sim environment doesn enfore tag order

            //-------------------------------
            // General
            //
            .sys__mgr__mgrId         ( sys__mgr__mgrId         ),
            .clk                     ( clk                     ),
            .reset_poweron           ( reset_poweron           ) 
 
    );

  // FIXME
  assign rcp__stuc__ready = 1;

  //-------------------------------------------------------------------------------------------------
  // NoC Interface
  // 
  mgr_noc_cntl mgr_noc_cntl (

             // Control-Path (cp) to NoC 
            .locl__noc__cp_valid          ( mcntl__noc__cp_valid       ), 
            .noc__locl__cp_ready          ( noc__mcntl__cp_ready       ), 
            .locl__noc__cp_cntl           ( mcntl__noc__cp_cntl        ), 
            .locl__noc__cp_type           ( mcntl__noc__cp_type        ), 
            .locl__noc__cp_ptype          ( mcntl__noc__cp_ptype       ), 
            .locl__noc__cp_desttype       ( mcntl__noc__cp_desttype    ), 
            .locl__noc__cp_pvalid         ( mcntl__noc__cp_pvalid      ), 
            .locl__noc__cp_data           ( mcntl__noc__cp_data        ), 
                                                                      
             // Data-Path (dp) to NoC                                 
            .locl__noc__dp_valid          ( mcntl__noc__dp_valid       ), 
            .noc__locl__dp_ready          ( noc__mcntl__dp_ready       ), 
            .locl__noc__dp_cntl           ( mcntl__noc__dp_cntl        ), 
            .locl__noc__dp_type           ( mcntl__noc__dp_type        ), 
            .locl__noc__dp_ptype          ( mcntl__noc__dp_ptype       ), 
            .locl__noc__dp_desttype       ( mcntl__noc__dp_desttype    ), 
            .locl__noc__dp_pvalid         ( mcntl__noc__dp_pvalid      ), 
            .locl__noc__dp_data           ( mcntl__noc__dp_data        ), 

             // Data-Path (cp) from NoC 
            .noc__locl__cp_valid          ( noc__mcntl__cp_valid     ), 
            .locl__noc__cp_ready          ( mcntl__noc__cp_ready     ), 
            .noc__locl__cp_cntl           ( noc__mcntl__cp_cntl      ), 
            .noc__locl__cp_type           ( noc__mcntl__cp_type      ), 
            .noc__locl__cp_ptype          ( noc__mcntl__cp_ptype     ), 
            .noc__locl__cp_data           ( noc__mcntl__cp_data      ), 
            .noc__locl__cp_pvalid         ( noc__mcntl__cp_pvalid    ), 
            .noc__locl__cp_mgrId          ( noc__mcntl__cp_mgrId     ), 
                                                                     
             // Data-Path (dp) from NoC                              
            .noc__locl__dp_valid          ( noc__mcntl__dp_valid     ), 
            .locl__noc__dp_ready          ( mcntl__noc__dp_ready     ), 
            .noc__locl__dp_cntl           ( noc__mcntl__dp_cntl      ), 
            .noc__locl__dp_type           ( noc__mcntl__dp_type      ), 
            .noc__locl__dp_ptype          ( noc__mcntl__dp_ptype     ), 
            .noc__locl__dp_data           ( noc__mcntl__dp_data      ), 
            .noc__locl__dp_pvalid         ( noc__mcntl__dp_pvalid    ), 
            .noc__locl__dp_mgrId          ( noc__mcntl__dp_mgrId     ), 

             // Connections to external NoC
             //`include "manager_noc_cntl_noc_ports_instance_ports.vh"
             .mgr__noc__port_valid           ( mgr__noc__port_valid           ),
             .mgr__noc__port_cntl            ( mgr__noc__port_cntl            ),
             .mgr__noc__port_data            ( mgr__noc__port_data            ),
             .noc__mgr__port_fc              ( noc__mgr__port_fc              ),
             .noc__mgr__port_valid           ( noc__mgr__port_valid           ),
             .noc__mgr__port_cntl            ( noc__mgr__port_cntl            ),
             .noc__mgr__port_data            ( noc__mgr__port_data            ),
             .mgr__noc__port_fc              ( mgr__noc__port_fc              ),
             .sys__mgr__port_destinationMask ( sys__mgr__port_destinationMask ),


            .sys__mgr__mgrId              ( sys__mgr__mgrId          ), 
            .clk                          ( clk                      ),
            .reset_poweron                ( reset_poweron            )
                          
  );




  //----------------------------------------------------------------------------------------------------
  // Memory Write Controller

  // 
  wire                                             mcntl__mwc__valid      ; 
  wire [`COMMON_STD_INTF_CNTL_RANGE             ]  mcntl__mwc__cntl       ; 
  wire                                             mwc__mcntl__ready      ; 
  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  mcntl__mwc__type       ; 
  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  mcntl__mwc__ptype      ; 
  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  mcntl__mwc__data       ; 
  wire                                             mcntl__mwc__pvalid     ; 
  wire [`MGR_MGR_ID_RANGE                       ]  mcntl__mwc__mgrId      ; 

  wire                                             mcntl__mwc__flush      ; 

  mwc_cntl mwc_cntl (
  
  
            //-------------------------------
            // Data-Path from MCntl
            // - likely data from another Manager via NoC                                

            .mcntl__mwc__valid       ( mcntl__mwc__valid           ), 
            .mwc__mcntl__ready       ( mwc__mcntl__ready           ), 
            .mcntl__mwc__cntl        ( mcntl__mwc__cntl            ), 
            .mcntl__mwc__type        ( mcntl__mwc__type            ), 
            .mcntl__mwc__ptype       ( mcntl__mwc__ptype           ), 
            .mcntl__mwc__data        ( mcntl__mwc__data            ), 
            .mcntl__mwc__pvalid      ( mcntl__mwc__pvalid          ), 
            .mcntl__mwc__mgrId       ( mcntl__mwc__mgrId           ), 
                                                                   
            //-------------------------------                      
            // from Return Data Processor Interface                
                                                                   
            .rdp__mwc__valid         ( rdp__mwc__valid             ), 
            .mwc__rdp__ready         ( mwc__rdp__ready             ), 
            .rdp__mwc__cntl          ( rdp__mwc__cntl              ), 
            .rdp__mwc__type          ( rdp__mwc__type              ), 
            .rdp__mwc__ptype         ( rdp__mwc__ptype             ), 
            .rdp__mwc__pvalid        ( rdp__mwc__pvalid            ), 
            .rdp__mwc__data          ( rdp__mwc__data              ), 
                                                                   
            //-------------------------------                      
            // to MMC                                              
                                                                   
            // Request                                             
            .mwc__mmc__valid         ( xxx__mmc__valid        [2]  ),  // [2] because interfaces [0:1] go to MRC
            .mwc__mmc__cntl          ( xxx__mmc__cntl         [2]  ),                         
            .mwc__mmc__tag           ( xxx__mmc__tag          [2]  ),                         
            .mmc__mwc__ready         ( mmc__xxx__ready        [2]  ),                         
            .mwc__mmc__channel       ( xxx__mmc__channel      [2]  ),                         
            .mwc__mmc__bank          ( xxx__mmc__bank         [2]  ),                         
            .mwc__mmc__page          ( xxx__mmc__page         [2]  ),                         
            .mwc__mmc__word          ( xxx__mmc__word         [2]  ),                         
                                                                   
            // Write Data                                          
            .mwc__mmc__data_valid    ( xxx__mmc__data_valid   [0]  ),  // [0] because only one write interface 
            .mwc__mmc__data_cntl     ( xxx__mmc__data_cntl    [0]  ),                         
            .mwc__mmc__data_channel  ( xxx__mmc__data_channel [0]  ),                         
            .mwc__mmc__data          ( xxx__mmc__data         [0]  ),                         
            .mwc__mmc__data_mask     ( xxx__mmc__data_mask    [0]  ),                         
            .mmc__mwc__data_ready    ( mmc__xxx__data_ready   [0]  ),                         
                                                                                           
            //-------------------------------
            // storage descriptor and cons/jump memory download
            //
            .mcntl__mwc__enable_sdmem_dnld    ( mcntl__xxx__enable_sdmem_dnld [`MGR_CNTL_STORAGE_DESC_USERS_MWC ] ),
                                              
            .mcntl__mwc__sdmem_valid          ( mcntl__xxx__sdmem_valid                                           ),
            .mcntl__mwc__sdmem_cntl           ( mcntl__xxx__sdmem_cntl                                            ),
            .mwc__mcntl__sdmem_ready          ( xxx__mcntl__sdmem_ready       [`MGR_CNTL_STORAGE_DESC_USERS_MWC ] ),
                                              
            .mcntl__mwc__sdmem_address        ( mcntl__xxx__sdmem_address                                         ),
            .mcntl__mwc__sdmem_addr           ( mcntl__xxx__sdmem_addr                                            ),
            .mcntl__mwc__sdmem_order          ( mcntl__xxx__sdmem_order                                           ),
            .mcntl__mwc__sdmem_consJump_ptr   ( mcntl__xxx__sdmem_consJump_ptr                                    ),
                                              
            .mcntl__mwc__enable_cjmem_dnld    ( mcntl__xxx__enable_cjmem_dnld [`MGR_CNTL_STORAGE_DESC_USERS_MWC ] ),
                                              
            .mcntl__mwc__cjmem_valid          ( mcntl__xxx__cjmem_valid                                           ),
            .mcntl__mwc__cjmem_cntl           ( mcntl__xxx__cjmem_cntl                                            ),
            .mwc__mcntl__cjmem_ready          ( xxx__mcntl__cjmem_ready       [`MGR_CNTL_STORAGE_DESC_USERS_MWC ] ),
                                              
            .mcntl__mwc__cjmem_address        ( mcntl__xxx__cjmem_address                                         ),
            .mcntl__mwc__cjmem_consJump_cntl  ( mcntl__xxx__cjmem_consJump_cntl                                   ),
            .mcntl__mwc__cjmem_consJump_val   ( mcntl__xxx__cjmem_consJump_val                                    ),

            //-------------------------------                      
            // General                                             
            //                                                     
            .mcntl__mwc__flush       ( mcntl__mwc__flush           ),
            .sys__mgr__mgrId         ( sys__mgr__mgrId             ),
            .clk                     ( clk                         ),
            .reset_poweron           ( reset_poweron               ) 
        );


  //----------------------------------------------------------------------------------------------------
  // Main Controller

  mgr_cntl mgr_cntl (
  
  
            //-------------------------------------------------------------------------------------------------
            // Configuration
            //
            //-------------------------------
            // - instruction download
            .mcntl__wum__enable_inst_dnld   ( mcntl__wum__enable_inst_dnld  ),
            .mcntl__wum__valid              ( mcntl__wum__valid             ),
            .mcntl__wum__cntl               ( mcntl__wum__cntl              ),
            .wum__mcntl__ready              ( wum__mcntl__ready             ),
            .mcntl__wum__address            ( mcntl__wum__address           ),
            .mcntl__wum__icntl              ( mcntl__wum__icntl             ),
            .mcntl__wum__dcntl              ( mcntl__wum__dcntl             ),
            .mcntl__wum__op                 ( mcntl__wum__op                ),
            .mcntl__wum__option_type        ( mcntl__wum__option_type       ),
            .mcntl__wum__option_value       ( mcntl__wum__option_value      ),

            //-------------------------------
            // - storage descriptor memory download
            .mcntl__xxx__enable_sdmem_dnld  ( mcntl__xxx__enable_sdmem_dnld     ),
            .mcntl__xxx__sdmem_valid        ( mcntl__xxx__sdmem_valid           ),
            .mcntl__xxx__sdmem_cntl         ( mcntl__xxx__sdmem_cntl            ),
            .xxx__mcntl__sdmem_ready        ( xxx__mcntl__sdmem_ready           ),
            .mcntl__xxx__sdmem_address      ( mcntl__xxx__sdmem_address         ),
            .mcntl__xxx__sdmem_addr         ( mcntl__xxx__sdmem_addr            ),
            .mcntl__xxx__sdmem_order        ( mcntl__xxx__sdmem_order           ),
            .mcntl__xxx__sdmem_consJump_ptr ( mcntl__xxx__sdmem_consJump_ptr    ),

            //--------------s----------------
            // - cons/jump memory download
            .mcntl__xxx__enable_cjmem_dnld    ( mcntl__xxx__enable_cjmem_dnld     ),
            .mcntl__xxx__cjmem_valid          ( mcntl__xxx__cjmem_valid           ),
            .mcntl__xxx__cjmem_cntl           ( mcntl__xxx__cjmem_cntl            ),
            .xxx__mcntl__cjmem_ready          ( xxx__mcntl__cjmem_ready           ),
            .mcntl__xxx__cjmem_address        ( mcntl__xxx__cjmem_address         ),
            .mcntl__xxx__cjmem_consJump_cntl  ( mcntl__xxx__cjmem_consJump_cntl   ),
            .mcntl__xxx__cjmem_consJump_val   ( mcntl__xxx__cjmem_consJump_val    ),

            //-------------------------------
            .mcntl__wuf__start_addr         ( mcntl__wuf__start_addr        ),  // first WU address
            .mcntl__wuf__enable             ( mcntl__wuf__enable            ),

            .mcntl__wuf__stall              ( mcntl__wuf__stall             ),
            .mcntl__wuf__release            ( mcntl__wuf__release           ),
            .wuf__mcntl__stalled            ( wuf__mcntl__stalled           ),

            .mcntl__wud__stall              ( mcntl__wud__stall             ),
            .mcntl__wud__release            ( mcntl__wud__release           ),
            .wud__mcntl__stalled            ( wud__mcntl__stalled           ),

            //-------------------------------
            // Status
            .wum__mcntl__inst_count         ( wum__mcntl__inst_count        ),

            //-------------------------------
            // to NoC (via mcntl)
            //
            .mcntl__mrc__lane_ready         ( mrc_cntl_strm_inst[0].mcntl__mrc__lane_ready  ),
            .mrc__mcntl__lane_cntl          ( mrc_cntl_strm_inst[0].mrc__mcntl__lane_cntl   ),
            .mrc__mcntl__lane_data          ( mrc_cntl_strm_inst[0].mrc__mcntl__lane_data   ),
            .mrc__mcntl__lane_valid         ( mrc_cntl_strm_inst[0].mrc__mcntl__lane_valid  ),
      
            //-------------------------------
            // from WU Decoder
            //
            .wud__mcntl__valid              ( wud__mcntl__valid             ),
            .wud__mcntl__dcntl              ( wud__mcntl__dcntl             ),  // used to delineate descriptor
            .mcntl__wud__ready              ( mcntl__wud__ready             ),
            .wud__mcntl__tag                ( wud__mcntl__tag               ),  // Use this to match with WU and take all the data 
            .wud__mcntl__option_type        ( wud__mcntl__option_type       ),  // Only send tuples
            .wud__mcntl__option_value       ( wud__mcntl__option_value      ),

            //-------------------------------
            // from NoC
            //
            // Control-Path (cp) from NoC                                
            .noc__mcntl__cp_valid           ( noc__mcntl__cp_valid          ), 
            .mcntl__noc__cp_ready           ( mcntl__noc__cp_ready          ), 
            .noc__mcntl__cp_cntl            ( noc__mcntl__cp_cntl           ), 
            .noc__mcntl__cp_type            ( noc__mcntl__cp_type           ), 
            .noc__mcntl__cp_ptype           ( noc__mcntl__cp_ptype          ), 
            .noc__mcntl__cp_data            ( noc__mcntl__cp_data           ), 
            .noc__mcntl__cp_pvalid          ( noc__mcntl__cp_pvalid         ), 
            .noc__mcntl__cp_mgrId           ( noc__mcntl__cp_mgrId          ), 
            
            // Data-Path (dp) from NoC                                
            .noc__mcntl__dp_valid           ( noc__mcntl__dp_valid          ), 
            .mcntl__noc__dp_ready           ( mcntl__noc__dp_ready          ), 
            .noc__mcntl__dp_cntl            ( noc__mcntl__dp_cntl           ), 
            .noc__mcntl__dp_type            ( noc__mcntl__dp_type           ), 
            .noc__mcntl__dp_ptype           ( noc__mcntl__dp_ptype          ), 
            .noc__mcntl__dp_data            ( noc__mcntl__dp_data           ), 
            .noc__mcntl__dp_pvalid          ( noc__mcntl__dp_pvalid         ), 
            .noc__mcntl__dp_mgrId           ( noc__mcntl__dp_mgrId          ), 
            
            //-------------------------------
            // to NoC
            //
            // Control-Path (cp) to NoC 
            .mcntl__noc__cp_valid           ( mcntl__noc__cp_valid          ), 
            .noc__mcntl__cp_ready           ( 1'b1                          ), // FIXME         
            .mcntl__noc__cp_cntl            ( mcntl__noc__cp_cntl           ), 
            .mcntl__noc__cp_type            ( mcntl__noc__cp_type           ), 
            .mcntl__noc__cp_ptype           ( mcntl__noc__cp_ptype          ), 
            .mcntl__noc__cp_desttype        ( mcntl__noc__cp_desttype       ), 
            .mcntl__noc__cp_pvalid          ( mcntl__noc__cp_pvalid         ), 
            .mcntl__noc__cp_data            ( mcntl__noc__cp_data           ), 
                                                                        
             // Data-Path (dp) to NoC                                   
            .mcntl__noc__dp_valid           ( mcntl__noc__dp_valid          ), 
            .noc__mcntl__dp_ready           ( noc__mcntl__dp_ready          ),
            .mcntl__noc__dp_cntl            ( mcntl__noc__dp_cntl           ), 
            .mcntl__noc__dp_type            ( mcntl__noc__dp_type           ), 
            .mcntl__noc__dp_ptype           ( mcntl__noc__dp_ptype          ), 
            .mcntl__noc__dp_desttype        ( mcntl__noc__dp_desttype       ), 
            .mcntl__noc__dp_pvalid          ( mcntl__noc__dp_pvalid         ), 
            .mcntl__noc__dp_data            ( mcntl__noc__dp_data           ), 
            
            //-------------------------------
            // to NoC (via mcntl)
            //
            .rdp__mcntl__noc_valid           ( rdp__mcntl__noc_valid      ), 
            .mcntl__rdp__noc_ready           ( mcntl__rdp__noc_ready      ),
            .rdp__mcntl__noc_cntl            ( rdp__mcntl__noc_cntl       ), 
            .rdp__mcntl__noc_type            ( rdp__mcntl__noc_type       ), 
            .rdp__mcntl__noc_ptype           ( rdp__mcntl__noc_ptype      ), 
            .rdp__mcntl__noc_desttype        ( rdp__mcntl__noc_desttype   ), 
            .rdp__mcntl__noc_pvalid          ( rdp__mcntl__noc_pvalid     ), 
            .rdp__mcntl__noc_data            ( rdp__mcntl__noc_data       ), 

            //-------------------------------
            // Data-Path to Memory Write Controller
            // - likely data from another Manager via NoC                                

            .mcntl__mwc__valid              ( mcntl__mwc__valid             ), 
            .mwc__mcntl__ready              ( mwc__mcntl__ready             ), 
            .mcntl__mwc__cntl               ( mcntl__mwc__cntl              ), 
            .mcntl__mwc__type               ( mcntl__mwc__type              ), 
            .mcntl__mwc__ptype              ( mcntl__mwc__ptype             ), 
            .mcntl__mwc__data               ( mcntl__mwc__data              ), 
            .mcntl__mwc__pvalid             ( mcntl__mwc__pvalid            ), 
            .mcntl__mwc__mgrId              ( mcntl__mwc__mgrId             ), 
            
            //-------------------------------
            // General
            //
            .mcntl__mwc__flush              ( mcntl__mwc__flush             ),
                                                                           
            .sys__mgr__mgrId                ( sys__mgr__mgrId               ),
            .clk                            ( clk                           ),
            .reset_poweron                  ( reset_poweron                 ) 
        );


endmodule

