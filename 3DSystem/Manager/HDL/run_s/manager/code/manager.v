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
`include "noc_cntl.vh"
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
  output[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl            ; 
  output                                        mgr__std__oob_valid           ; 
  input                                         std__mgr__oob_ready           ; 
  output[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type            ; 
  output[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data            ; 

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
  wire   [`MGR_EXEC_LANE_ID_RANGE        ]      wud__odc__num_lanes     ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__stOp_cmd      ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__simd_cmd      ;

  // FIXME
  assign odc__wud__ready = 1'b1 ;
 
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
          // General
          .sys__mgr__mgrId         ( sys__mgr__mgrId          ),
          .clk                     ( clk                      ),
          .reset_poweron           ( reset_poweron            ) 
        );

  //-------------------------------------------------------------------------------------------------
  // Stack Upstream Interface
  // 
  wire                                          stuc__rdp__valid       ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rdp__cntl        ;
  wire                                          rdp__stuc__ready       ;
  wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rdp__tag         ;  // tag size is the same as sent to PE
  wire   [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rdp__data        ;
 
  //-------------------------------------------------------------------------------------------------
  // Control Processor Interface
  //
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

  // FIXME
  assign rcp__stuc__ready = 1;
  assign rdp__stuc__ready = 1;

  //-------------------------------------------------------------------------------------------------
  // NoC Interface
  // 
  noc_cntl noc_cntl (

                        // Control-Path (cp) to NoC 
                       .noc__scntl__cp_ready          ( noc__rdp__cp_ready           ), 
                       .scntl__noc__cp_cntl           ( rdp__noc__cp_cntl            ), 
                       .scntl__noc__cp_type           ( rdp__noc__cp_type            ), 
                       .scntl__noc__cp_data           ( rdp__noc__cp_data            ), 
                       .scntl__noc__cp_laneId         ( rdp__noc__cp_laneId          ), 
                       .scntl__noc__cp_strmId         ( rdp__noc__cp_strmId          ), 
                       .scntl__noc__cp_valid          ( rdp__noc__cp_valid           ), 
                                                                                     
                        // Data-Path (dp) to NoC                                     
                       .noc__scntl__dp_ready          ( noc__rdp__dp_ready           ), 
                       .scntl__noc__dp_type           ( rdp__noc__dp_type            ), 
                       .scntl__noc__dp_cntl           ( rdp__noc__dp_cntl            ), 
                       .scntl__noc__dp_peId           ( rdp__noc__dp_peId            ), 
                       .scntl__noc__dp_laneId         ( rdp__noc__dp_laneId          ), 
                       .scntl__noc__dp_strmId         ( rdp__noc__dp_strmId          ), 
                       .scntl__noc__dp_data           ( rdp__noc__dp_data            ), 
                       .scntl__noc__dp_valid          ( rdp__noc__dp_valid           ), 

                        // Data-Path (cp) from NoC 
                       .scntl__noc__cp_ready          ( mcntl__noc__cp_ready         ), 
                       .noc__scntl__cp_cntl           ( noc__mcntl__cp_cntl          ), 
                       .noc__scntl__cp_type           ( noc__mcntl__cp_type          ), 
                       .noc__scntl__cp_data           ( noc__mcntl__cp_data          ), 
                       .noc__scntl__cp_peId           ( noc__mcntl__cp_peId          ), 
                       .noc__scntl__cp_laneId         ( noc__mcntl__cp_laneId        ), 
                       .noc__scntl__cp_strmId         ( noc__mcntl__cp_strmId        ), 
                       .noc__scntl__cp_valid          ( noc__mcntl__cp_valid         ), 
                       
                        // Data-Path (dp) from NoC 
                       .scntl__noc__dp_ready          ( mcntl__noc__dp_ready         ), 
                       .noc__scntl__dp_cntl           ( noc__mcntl__dp_cntl          ), 
                       .noc__scntl__dp_type           ( noc__mcntl__dp_type          ), 
                       .noc__scntl__dp_laneId         ( noc__mcntl__dp_laneId        ), 
                       .noc__scntl__dp_strmId         ( noc__mcntl__dp_strmId        ), 
                       .noc__scntl__dp_data           ( noc__mcntl__dp_data          ), 
                       .noc__scntl__dp_valid          ( noc__mcntl__dp_valid         ), 

                        // Connections to external NoC
                        `include "manager_noc_cntl_noc_ports_instance_ports.vh"

                       .peId                         ( sys__mgr__mgrId             ),
                       .clk                          ( clk                         ),
                       .reset_poweron                ( reset_poweron               )
                          
  );
endmodule

