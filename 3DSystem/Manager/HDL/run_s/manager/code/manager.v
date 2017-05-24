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
// test related defines
`ifdef TESTING
//`include "TB_common.vh"
`endif

//--------------------------------------------------
// RTL related defines
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "mgr_noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"

module manager (

            //-------------------------------
            // NoC
            //
            `include "manager_noc_cntl_noc_ports.vh"
 

            //-------------------------------
            // Stack Bus - OOB Downstream
            //
            // OOB controls how the lanes are interpreted
            mgr__std__oob_cntl        , 
            mgr__std__oob_valid       , 
            std__mgr__oob_ready       , 
            mgr__std__oob_type        , 
            mgr__std__oob_data        , 

            //-------------------------------
            // Stack Bus - Downstream
            //
            `include "manager_stack_bus_downstream_ports.vh"

            //-------------------------------
            // Stack Bus - Upstream
            //
            stu__mgr__valid         ,
            stu__mgr__cntl          ,
            mgr__stu__ready         ,
            stu__mgr__type          ,  // Control or Data, Vector or scalar
            stu__mgr__data          ,
            stu__mgr__oob_data      ,
 
            //-------------------------------
            // General control and status 
            sys__mgr__mgrId               , 
            mgr__sys__allSynchronized     , 
            sys__mgr__thisSynchronized    , 
            sys__mgr__ready               , 
            sys__mgr__complete            , 

            clk                    ,
            reset_poweron    
 
    );

  input                               clk                ;
  input                               reset_poweron      ;

  // General control and status                                
  input   [`MGR_MGR_ID_RANGE    ]     sys__mgr__mgrId               ;
  output                              mgr__sys__allSynchronized     ;
  input                               sys__mgr__thisSynchronized    ; 
  input                               sys__mgr__ready               ; 
  input                               sys__mgr__complete            ; 



  //-------------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream

  // OOB carries PE configuration    
  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl            ; 
  output                                          mgr__std__oob_valid           ; 
  input                                           std__mgr__oob_ready           ; 
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type            ; 
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data            ; 

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Downstream

  // carries lane arguments
  `include "manager_stack_bus_downstream_port_declarations.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //
  input                                          stu__mgr__valid       ;
  input   [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl        ;
  output                                         mgr__stu__ready       ;
  input   [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type        ;  // Control or Data, Vector or scalar
  input   [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data        ;
  input   [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data    ;
 




  //-------------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------
  // Regs and Wires
  
  wire    [`MGR_MGR_ID_RANGE    ]     sys__mgr__mgrId    ;

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
  // NoC
  //
  `include "manager_noc_cntl_noc_ports_declaration.vh"

  `include "noc_to_mgrArray_connection_wires.vh"

  `include "manager_noc_connection_wires.vh"

  wire  [`MGR_WU_ADDRESS_RANGE    ]     mcntl__wuf__start_addr  ;  // first WU address
  wire                                  mcntl__wuf__enable      ;

  //-------------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------
  // Temporary assignments
  // FIXME
  assign  mcntl__wuf__start_addr  = 24'd0   ;
  assign  mcntl__wuf__enable      = 1'b1    ;
  wire    xxx__wuf__stall         = 1'b0    ;




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
          .wum__wuf__stall         ( wum__wuf__stall          ),
 
          //-------------------------------
          // Control
          .mcntl__wuf__enable      ( mcntl__wuf__enable       ),
          .mcntl__wuf__start_addr  ( mcntl__wuf__start_addr   ),

          //-------------------------------
          // 
          .xxx__wuf__stall         ( xxx__wuf__stall          ),
 
          //-------------------------------
          // General
          .clk                     ( clk                      ),
          .reset_poweron           ( reset_poweron            )
        );


  //-------------------------------------------------------------------------------------------------
  // WU Memory
  // 
  wire                                       wum__wud__valid       ; 
  wire                                       wud__wum__ready       ; 
  wire  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl       ;  // instruction delineator
  wire  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl       ;  // descriptor delineator
  wire  [`MGR_INST_TYPE_RANGE           ]    wum__wud__op          ;  // NOP, OP, MR, MW
  // WU Instruction option fields
  wire  [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST ] ;  // 
  wire  [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST ] ;  // 

  wu_memory wu_memory (
  
          .valid                   ( wuf__wum__read           ),  // used to initiate readmemh

          //-------------------------------
          // From WU fetch 
          .wuf__wum__read          ( wuf__wum__read           ),
          .wuf__wum__addr          ( wuf__wum__addr           ),
          .wum__wuf__stall         ( wum__wuf__stall          ),
 
          //-------------------------------
          // To WU decode
          .wum__wud__valid         ( wum__wud__valid          ),
          .wud__wum__ready         ( wud__wum__ready          ),
          .wum__wud__icntl         ( wum__wud__icntl          ),
          .wum__wud__dcntl         ( wum__wud__dcntl          ),
          .wum__wud__op            ( wum__wud__op             ),
          .wum__wud__option_type   ( wum__wud__option_type    ),
          .wum__wud__option_value  ( wum__wud__option_value   ),

          //-------------------------------
          // General
          .sys__mgr__mgrId         ( sys__mgr__mgrId          ),

          .clk                     ( clk                      ),
          .reset_poweron           ( reset_poweron            )
        );

  //-------------------------------------------------------------------------------------------------
  // WU decode
  // 

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
  wire   [`MGR_WU_OPT_TYPE_RANGE         ]      wud__mrc0__option_type    [`MGR_WU_OPT_PER_INST ] ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__mrc0__option_value   [`MGR_WU_OPT_PER_INST ] ;

  wire                                          wud__mrc1__valid         ;
  wire                                          mrc1__wud__ready         ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__mrc1__cntl          ; 
  wire   [`MGR_WU_OPT_TYPE_RANGE         ]      wud__mrc1__option_type    [`MGR_WU_OPT_PER_INST ] ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__mrc1__option_value   [`MGR_WU_OPT_PER_INST ] ;

  wire                                          wud__rdp__valid         ;
  wire                                          rdp__wud__ready         ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__rdp__dcntl         ; 
  wire   [`MGR_STD_OOB_TAG_RANGE         ]      wud__rdp__tag           ;
  wire   [`MGR_WU_OPT_TYPE_RANGE         ]      wud__rdp__option_type    [`MGR_WU_OPT_PER_INST ] ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__rdp__option_value   [`MGR_WU_OPT_PER_INST ] ;


  wu_decode wu_decode (
  
          //-------------------------------
          // from WU Memory
          .wum__wud__valid         ( wum__wud__valid          ),
          .wud__wum__ready         ( wud__wum__ready          ),
          .wum__wud__icntl         ( wum__wud__icntl          ),
          .wum__wud__dcntl         ( wum__wud__dcntl          ),
          .wum__wud__op            ( wum__wud__op             ),
          .wum__wud__option_type   ( wum__wud__option_type    ),
          .wum__wud__option_value  ( wum__wud__option_value   ),

          //-------------------------------
          // Stack Down OOB driver
          //
          .wud__odc__valid         ( wud__odc__valid     ),
          .wud__odc__cntl          ( wud__odc__cntl      ),  // used to delineate upstream packet data
          .odc__wud__ready         ( odc__wud__ready     ),
          .wud__odc__tag           ( wud__odc__tag       ),  // Use this to match with WU and take all the data 
          .wud__odc__num_lanes     ( wud__odc__num_lanes ),  // The data may vary so check for cntl=EOD when reading this interface
          .wud__odc__stOp_cmd      ( wud__odc__stOp_cmd  ),  // The data may vary so check for cntl=EOD when reading this interface
          .wud__odc__simd_cmd      ( wud__odc__simd_cmd  ),  // The data may vary so check for cntl=EOD when reading this interface

          //-------------------------------
          // Return Data Processor
          //
          .wud__rdp__valid         ( wud__rdp__valid         ),
          .wud__rdp__dcntl         ( wud__rdp__dcntl         ),  // used to delineate descriptor
          .rdp__wud__ready         ( rdp__wud__ready         ),
          .wud__rdp__tag           ( wud__rdp__tag           ),  // Use this to match with WU and take all the data 
          .wud__rdp__option_type   ( wud__rdp__option_type   ),  // Only send tuples
          .wud__rdp__option_value  ( wud__rdp__option_value  ),

          //-------------------------------
          // Memory Read Controller
          //
          .wud__mrc0__valid         ( wud__mrc0__valid         ),
          .wud__mrc0__cntl          ( wud__mrc0__cntl          ),  // used to delineate descriptor
          .mrc0__wud__ready         ( mrc0__wud__ready         ),
          .wud__mrc0__option_type   ( wud__mrc0__option_type   ),  // Only send tuples
          .wud__mrc0__option_value  ( wud__mrc0__option_value  ),

          .wud__mrc1__valid         ( wud__mrc1__valid         ),
          .wud__mrc1__cntl          ( wud__mrc1__cntl          ),  // used to delineate descriptor
          .mrc1__wud__ready         ( mrc1__wud__ready         ),
          .wud__mrc1__option_type   ( wud__mrc1__option_type   ),  // Only send tuples
          .wud__mrc1__option_value  ( wud__mrc1__option_value  ),


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
          .wud__odc__valid         ( wud__odc__valid     ),
          .wud__odc__cntl          ( wud__odc__cntl      ),  // used to delineate upstream packet data
          .odc__wud__ready         ( odc__wud__ready     ),
          .wud__odc__tag           ( wud__odc__tag       ),  // Use this to match with WU and take all the data 
          .wud__odc__num_lanes     ( wud__odc__num_lanes ),  // The data may vary so check for cntl=EOD when reading this interface
          .wud__odc__stOp_cmd      ( wud__odc__stOp_cmd  ),  // The data may vary so check for cntl=EOD when reading this interface
          .wud__odc__simd_cmd      ( wud__odc__simd_cmd  ),  // The data may vary so check for cntl=EOD when reading this interface

          //-------------------------------
          // Stack Bus - OOB Downstream
          // FIXME: currently driven by testbench
          `ifdef TB_SYSTEM_DRIVES_OOB_PACKET
            .mgr__std__oob_cntl       ( mgr__std__oob_cntl   ), 
            .mgr__std__oob_valid      ( mgr__std__oob_valid  ), 
            .std__mgr__oob_ready      ( std__mgr__oob_ready  ), 
            .mgr__std__oob_type       ( mgr__std__oob_type   ), 
            .mgr__std__oob_data       ( mgr__std__oob_data   ), 
          `else
            .mgr__std__oob_cntl       (  ), 
            .mgr__std__oob_valid      (  ), 
            .std__mgr__oob_ready      ( std__mgr__oob_ready       ), 
            .mgr__std__oob_type       (  ), 
            .mgr__std__oob_data       (  ), 
          `endif

          //-------------------------------
          // General
          .sys__mgr__mgrId         ( sys__mgr__mgrId          ),
          .clk                     ( clk                      ),
          .reset_poweron           ( reset_poweron            ) 
        );


  //-------------------------------------------------------------------------------------------------
  // Memory Read Controller 
  //  - instance for each argument

  genvar gvi;
  generate
    for (gvi=0; gvi<`MGR_NUM_OF_STREAMS; gvi=gvi+1) 
      begin: mrc_cntl_strm_inst

        //----------------------------------------------------------------------------------------------------
        // Stack Downstream
        wire                                        std__mrc__lane_ready  [`MGR_NUM_OF_EXEC_LANES_RANGE ];
        wire  [`COMMON_STD_INTF_CNTL_RANGE      ]   mrc__std__lane_cntl   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
        wire  [`STACK_DOWN_INTF_STRM_DATA_RANGE ]   mrc__std__lane_data   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
        wire                                        mrc__std__lane_valid  [`MGR_NUM_OF_EXEC_LANES_RANGE ];
      
        //----------------------------------------------------------------------------------------------------
        // WU Decoder
        wire                                        wud__mrc__valid                                      ;  // send MR descriptors
        wire  [`COMMON_STD_INTF_CNTL_RANGE      ]   wud__mrc__cntl                                       ;  // descriptor delineator
        wire                                        mrc__wud__ready                                      ;
        wire  [`MGR_WU_OPT_TYPE_RANGE           ]   wud__mrc__option_type   [`MGR_WU_OPT_PER_INST ]      ;  // WU Instruction option fields
        wire  [`MGR_WU_OPT_VALUE_RANGE          ]   wud__mrc__option_value  [`MGR_WU_OPT_PER_INST ]      ;  

        //----------------------------------------------------------------------------------------------------
        // Main memory Controller
        wire                                           mrc__mmc__valid                                     ;
        wire  [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mmc__cntl                                      ;
        wire                                           mmc__mrc__ready                                     ;
        wire  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mrc__mmc__channel                                   ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mrc__mmc__bank                                      ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mrc__mmc__page                                      ;
        wire  [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      mrc__mmc__word                                      ;
                                                                                                           
        wire                                           mmc__mrc__valid                                     ;
        wire  [`COMMON_STD_INTF_CNTL_RANGE      ]      mmc__mrc__cntl                                      ;
        wire                                           mrc__mmc__ready                                     ;
        wire  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__mrc__data      [`MGR_NUM_OF_EXEC_LANES_RANGE ] ;

        mrc_cntl mrc_cntl (
        
                //-------------------------------
                // from WU Decoder
                //
                .wud__mrc__valid         ( wud__mrc__valid         ),
                .wud__mrc__cntl          ( wud__mrc__cntl          ),  // used to delineate descriptor
                .mrc__wud__ready         ( mrc__wud__ready         ),
                .wud__mrc__option_type   ( wud__mrc__option_type   ),  // Only send tuples
                .wud__mrc__option_value  ( wud__mrc__option_value  ),
      
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
                // General
                //
                .sys__mgr__mgrId         ( sys__mgr__mgrId         ),
                .clk                     ( clk                     ),
                .reset_poweron           ( reset_poweron           ) 
              );

      end
  endgenerate

  //******************************
  // ****  DEBUG  ****
  // FIXME
  //******************************
  genvar lane ;
  generate
    for (lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
      begin: debug_data
        assign mrc_cntl_strm_inst[0].mmc__mrc__valid = mrc_cntl_strm_inst[0].mrc__mmc__ready;
        assign mrc_cntl_strm_inst[1].mmc__mrc__valid = mrc_cntl_strm_inst[1].mrc__mmc__ready;

        assign mrc_cntl_strm_inst[0].mmc__mrc__ready = 1'b1;
        assign mrc_cntl_strm_inst[1].mmc__mrc__ready = 1'b1;

        assign mrc_cntl_strm_inst[0].mmc__mrc__cntl  = 2'b11 ;
        assign mrc_cntl_strm_inst[1].mmc__mrc__cntl  = 2'b11 ;
        assign mrc_cntl_strm_inst[0].mmc__mrc__data [lane] = lane+1024;
        assign mrc_cntl_strm_inst[1].mmc__mrc__data [lane] = lane+8192;
      end
  endgenerate
  //******************************
  //******************************

  // Connect packed array port of MRC(s) to WU Decoder
  `include "manager_mrc_cntl_wud_connections.vh"
  
  // Connect packed array port of MRC(s) to individual stack downstream wires
  `include "manager_mrc_cntl_stack_bus_downstream_connections.vh"


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
  wire    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__mwc__ptype      ; 
  wire                                                rdp__mwc__pvalid     ; 
  wire    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__mwc__data       ; 

  rdp_cntl rdp_cntl (

            //-------------------------------
            // From Stack Upstream
            //
            .stuc__rdp__valid         ( stuc__rdp__valid   ),
            .stuc__rdp__cntl          ( stuc__rdp__cntl    ),  // used to delineate upstream packet data
            .rdp__stuc__ready         ( rdp__stuc__ready   ),
            .stuc__rdp__tag           ( stuc__rdp__tag     ),  // Use this to match with WU and take all the data 
            .stuc__rdp__data          ( stuc__rdp__data    ),  // The data may vary so check for cntl=EOD when reading this interface


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
            .mwc__rdp__ready         ( 1'b1         ), // FIXME
            //.mwc__rdp__ready         ( mwc__rdp__ready         ), 
            .rdp__mwc__cntl          ( rdp__mwc__cntl          ), 
            .rdp__mwc__ptype         ( rdp__mwc__ptype         ), 
            .rdp__mwc__pvalid        ( rdp__mwc__pvalid        ), 
            .rdp__mwc__data          ( rdp__mwc__data          ), 

            //-------------------------------
            // to NoC
            //
            // Control-Path (cp) to NoC 
            .rdp__noc__cp_valid      ( rdp__noc__cp_valid      ), 
            .noc__rdp__cp_ready      ( 1'b1      ), // FIXME
            .rdp__noc__cp_cntl       ( rdp__noc__cp_cntl       ), 
            .rdp__noc__cp_type       ( rdp__noc__cp_type       ), 
            .rdp__noc__cp_ptype      ( rdp__noc__cp_ptype      ), 
            .rdp__noc__cp_desttype   ( rdp__noc__cp_desttype   ), 
            .rdp__noc__cp_pvalid     ( rdp__noc__cp_pvalid     ), 
            .rdp__noc__cp_data       ( rdp__noc__cp_data       ), 
                                                                          
             // Data-Path (dp) to NoC                                     
            .rdp__noc__dp_valid      ( rdp__noc__dp_valid      ), 
            .noc__rdp__dp_ready      ( 1'b1      ), // FIXME
            .rdp__noc__dp_cntl       ( rdp__noc__dp_cntl       ), 
            .rdp__noc__dp_type       ( rdp__noc__dp_type       ), 
            .rdp__noc__dp_ptype      ( rdp__noc__dp_ptype      ), 
            .rdp__noc__dp_desttype   ( rdp__noc__dp_desttype   ), 
            .rdp__noc__dp_pvalid     ( rdp__noc__dp_pvalid     ), 
            .rdp__noc__dp_data       ( rdp__noc__dp_data       ), 

            //-------------------------------
            // Config
            //
            .cfg__rdp__check_tag     ( 1'b0                    ),  // FIXME: current sim environment doesn enfore tag order

            //-------------------------------
            // General
            //
            .sys__mgr__mgrId         ( sys__mgr__mgrId    ),
            .clk                     ( clk                ),
            .reset_poweron           ( reset_poweron      ) 
 
    );

  // FIXME
  assign rcp__stuc__ready = 1;

  //-------------------------------------------------------------------------------------------------
  // NoC Interface
  // 
  mgr_noc_cntl mgr_noc_cntl (

                        // Control-Path (cp) to NoC 
                       .locl__noc__cp_valid          ( rdp__noc__cp_valid           ), 
                       .noc__locl__cp_ready          ( noc__rdp__cp_ready           ), 
                       .locl__noc__cp_cntl           ( rdp__noc__cp_cntl            ), 
                       .locl__noc__cp_type           ( rdp__noc__cp_type            ), 
                       .locl__noc__cp_ptype          ( rdp__noc__cp_ptype           ), 
                       .locl__noc__cp_desttype       ( rdp__noc__cp_desttype        ), 
                       .locl__noc__cp_pvalid         ( rdp__noc__cp_pvalid          ), 
                       .locl__noc__cp_data           ( rdp__noc__cp_data            ), 
                                                                                     
                        // Data-Path (dp) to NoC                                     
                       .locl__noc__dp_valid          ( rdp__noc__dp_valid           ), 
                       .noc__locl__dp_ready          ( noc__rdp__dp_ready           ), 
                       .locl__noc__dp_cntl           ( rdp__noc__dp_cntl            ), 
                       .locl__noc__dp_type           ( rdp__noc__dp_type            ), 
                       .locl__noc__dp_ptype          ( rdp__noc__dp_ptype           ), 
                       .locl__noc__dp_desttype       ( rdp__noc__dp_desttype        ), 
                       .locl__noc__dp_pvalid         ( rdp__noc__dp_pvalid          ), 
                       .locl__noc__dp_data           ( rdp__noc__dp_data            ), 

                        // Data-Path (cp) from NoC 
                       .noc__locl__cp_valid          ( noc__mcntl__cp_valid         ), 
                       .locl__noc__cp_ready          ( mcntl__noc__cp_ready         ), 
                       .noc__locl__cp_cntl           ( noc__mcntl__cp_cntl          ), 
                       .noc__locl__cp_type           ( noc__mcntl__cp_type          ), 
                       .noc__locl__cp_ptype          ( noc__mcntl__cp_ptype         ), 
                       .noc__locl__cp_data           ( noc__mcntl__cp_data          ), 
                       .noc__locl__cp_pvalid         ( noc__mcntl__cp_pvalid        ), 
                       .noc__locl__cp_mgrId          ( noc__mcntl__cp_mgrId         ), 
                       
                        // Data-Path (dp) from NoC 
                       .noc__locl__dp_valid          ( noc__mcntl__dp_valid         ), 
                       .locl__noc__dp_ready          ( mcntl__noc__dp_ready         ), 
                       .noc__locl__dp_cntl           ( noc__mcntl__dp_cntl          ), 
                       .noc__locl__dp_type           ( noc__mcntl__dp_type          ), 
                       .noc__locl__dp_ptype          ( noc__mcntl__dp_ptype         ), 
                       .noc__locl__dp_data           ( noc__mcntl__dp_data          ), 
                       .noc__locl__dp_pvalid         ( noc__mcntl__dp_pvalid        ), 
                       .noc__locl__dp_mgrId          ( noc__mcntl__dp_mgrId         ), 

                        // Connections to external NoC
                        `include "manager_noc_cntl_noc_ports_instance_ports.vh"

                       .sys__mgr__mgrId              ( sys__mgr__mgrId             ), // FIXME: make localId
                       .clk                          ( clk                         ),
                       .reset_poweron                ( reset_poweron               )
                          
  );

  // FIXME
  assign mcntl__noc__cp_ready = 1;
  assign mcntl__noc__dp_ready = 1;




endmodule

