/*********************************************************************************************

    File name   : mgr_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

    Description : This will be the module that communicates with the host.
                  It may well be a small CPU or maybe SIMD.
                  For now, it takes the NoC packets and passes them directly to the MWC

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "python_typedef.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "wu_decode.vh"
`include "wu_memory.vh"
`include "mgr_noc_cntl.vh"
`include "stack_interface.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "mgr_cntl.vh"


module mgr_cntl (  

            //-------------------------------------------------------------------------------------------------
            // Configuration
            //
            output  reg  [`MGR_WU_ADDRESS_RANGE           ]    mcntl__wuf__start_addr           ,  // first WU address
            output  reg                                        mcntl__wuf__enable               ,
            output  reg                                        mcntl__wuf__stall                ,
            output  reg                                        mcntl__wud__stall                ,
            output  reg                                        mcntl__wuf__release              ,
            output  reg                                        mcntl__wud__release              ,
            input   wire                                       wuf__mcntl__stalled              ,
            input   wire                                       wud__mcntl__stalled              ,

            // Instruction download
            output  reg                                        mcntl__wum__enable_inst_dnld     ,
            output  reg                                        mcntl__wum__valid                ,
            output  reg   [`MGR_WU_ADDRESS_RANGE          ]    mcntl__wum__address              ,
            input   wire                                       wum__mcntl__ready                ,
            // WU Instruction delineators
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE    ]    mcntl__wum__icntl                ,  // instruction delineator
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE    ]    mcntl__wum__dcntl                ,  // descriptor delineator
            output  reg   [`MGR_INST_TYPE_RANGE           ]    mcntl__wum__op                   ,  // NOP, OP, MR, MW
            
            // WU Instruction option fields
            output  reg   [`MGR_WU_OPT_TYPE_RANGE         ]    mcntl__wum__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ,  // 
            output  reg   [`MGR_WU_OPT_VALUE_RANGE        ]    mcntl__wum__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ,  // 

            //-------------------------------------------------------------------------------------------------
            // Status
            //
            input   wire  [`WUM_MAX_INST_RANGE            ]    wum__mcntl__inst_count         ,


            //-------------------------------
            // From WU Decoder
            // - config descriptors (sync and data)
            input   reg                                       wud__mcntl__valid                ,
            output  reg                                       mcntl__wud__ready                ,
            input   reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mcntl__dcntl                ,  // descriptor delineator
            input   reg  [`MGR_STD_OOB_TAG_RANGE         ]    wud__mcntl__tag                  ,  // decoder generates tag for Return data proc and Downstream OOB
            input   reg  [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mcntl__option_type    [`MGR_WU_OPT_PER_INST ] ,  // WU Instruction option fields
            input   reg  [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mcntl__option_value   [`MGR_WU_OPT_PER_INST ] ,  

            //-------------------------------
            // DMA from Memory read to NoC 
            //
            input   wire [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ]      mrc__mcntl__lane_valid                                       ,
            input   wire [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mcntl__lane_cntl     [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ],
            output  reg  [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ]      mcntl__mrc__lane_ready                                       ,
            input   wire [`MGR_STD_LANE_DATA_RANGE         ]      mrc__mcntl__lane_data     [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ],

            //-------------------------------------------------------------------------------------------------
            // NoC interface
            //
            //---------------------------------------------------------------------------
            // from NoC 
            // - control
            input  wire                                              noc__mcntl__cp_valid      , 
            input  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     noc__mcntl__cp_cntl       , 
            input  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     noc__mcntl__cp_type       , 
            input  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     noc__mcntl__cp_ptype      , 
            input  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     noc__mcntl__cp_data       , 
            input  wire                                              noc__mcntl__cp_pvalid     , 
            input  wire [`MGR_ARRAY_HOST_ID_RANGE              ]     noc__mcntl__cp_mgrId      , 
            output reg                                               mcntl__noc__cp_ready      , 
            // - data
            input  wire                                              noc__mcntl__dp_valid      , 
            input  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     noc__mcntl__dp_cntl       , 
            input  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     noc__mcntl__dp_type       , 
            input  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     noc__mcntl__dp_ptype      , 
            input  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     noc__mcntl__dp_data       , 
            input  wire                                              noc__mcntl__dp_pvalid     , 
            input  wire [`MGR_ARRAY_HOST_ID_RANGE              ]     noc__mcntl__dp_mgrId      , 
            output reg                                               mcntl__noc__dp_ready      , 

            //---------------------------------------------------------------------------
            // to NoC 
            // - control
            output  reg                                                mcntl__noc__cp_valid      , 
            output  reg    [`COMMON_STD_INTF_CNTL_RANGE             ]  mcntl__noc__cp_cntl       , 
            input   wire                                               noc__mcntl__cp_ready      , 
            output  reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  mcntl__noc__cp_type       , 
            output  reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  mcntl__noc__cp_ptype      , 
            output  reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  mcntl__noc__cp_desttype   , 
            output  reg                                                mcntl__noc__cp_pvalid     , 
            output  reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  mcntl__noc__cp_data       , 
                    
            // - data
            output  reg                                                mcntl__noc__dp_valid      , 
            output  reg    [`COMMON_STD_INTF_CNTL_RANGE             ]  mcntl__noc__dp_cntl       , 
            input   wire                                               noc__mcntl__dp_ready      , 
            output  reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  mcntl__noc__dp_type       , 
            output  reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  mcntl__noc__dp_ptype      , 
            output  reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  mcntl__noc__dp_desttype   , 
            output  reg                                                mcntl__noc__dp_pvalid     , 
            output  reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  mcntl__noc__dp_data       , 
  
            //-------------------------------------------------------------------------------------------------
            // from RDP (to NoC)
            // 
            input   wire                                               rdp__mcntl__noc_valid      , 
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE              ]  rdp__mcntl__noc_cntl       , 
            output  reg                                                mcntl__rdp__noc_ready      , 
            input   wire  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE      ]  rdp__mcntl__noc_type       , 
            input   wire  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE     ]  rdp__mcntl__noc_ptype      , 
            input   wire  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE        ]  rdp__mcntl__noc_desttype   , 
            input   wire                                               rdp__mcntl__noc_pvalid     , 
            input   wire  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE        ]  rdp__mcntl__noc_data       , 
 
            
            //-------------------------------------------------------------------------------------------------
            // to MWC
            output reg                                               mcntl__mwc__valid      , 
            output reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__mwc__cntl       , 
            output reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__mwc__type       , 
            output reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__mwc__ptype      , 
            output reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__mwc__data       , 
            output reg                                               mcntl__mwc__pvalid     , 
            output reg  [`MGR_MGR_ID_RANGE                     ]     mcntl__mwc__mgrId      , 
            input  wire                                              mwc__mcntl__ready      , 

  

            //-------------------------------------------------------------------------------------------------
            // General
            //
            output reg                            mcntl__mwc__flush ,  // release any held write data. Likely used at end of a sequence

            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId   ,
                                                                    
            input  wire                           clk               ,
            input  wire                           reset_poweron  
                        );


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registers and Wires
   

  //-------------------------------
  // DMA from Memory read to NoC 
  //
  reg                                        mcntl__wuf__stall_e1                ;
  reg                                        mcntl__wud__stall_e1                ;
  reg                                        mcntl__wuf__release_e1              ;
  reg                                        mcntl__wud__release_e1              ;
  reg                                        wuf__mcntl__stalled_d1              ;
  reg                                        wud__mcntl__stalled_d1              ;
  //-------------------------------
  // DMA from Memory read to NoC 
  //
  reg   [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ]      mrc__mcntl__lane_valid_d1                                       ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mcntl__lane_cntl_d1     [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ];
  wire  [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ]      mcntl__mrc__lane_ready_e1                                       ;
  reg   [`MGR_STD_LANE_DATA_RANGE         ]      mrc__mcntl__lane_data_d1     [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE ];

  reg                                         wud__mcntl__valid_d1                                  ;
  wire                                        mcntl__wud__ready_e1                                  ;
  reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mcntl__dcntl_d1                                  ;  
  reg    [`MGR_STD_OOB_TAG_RANGE         ]    wud__mcntl__tag_d1                                    ;
  reg    [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mcntl__option_type_d1    [`MGR_WU_OPT_PER_INST ] ;
  reg    [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mcntl__option_value_d1   [`MGR_WU_OPT_PER_INST ] ;

  wire                                        start_of_wu_descriptor                                ;  // dcntl == SOM
  wire                                        middle_of_wu_descriptor                               ;  // dcntl == MOM
  wire                                        end_of_wu_descriptor                                  ;  // dcntl == EOM


  reg    [`MGR_WU_OPT_PER_INST_RANGE        ]    mode_reg_valid                              ;
  reg    [`MGR_WU_OPT_TYPE_RANGE            ]    mode_reg_type        [`MGR_WU_OPT_PER_INST] ;
  reg    [`MGR_WU_CONFIG_MODE_REG_ID_RANGE  ]    mode_reg_id          [`MGR_WU_OPT_PER_INST] ;
  reg    [`MGR_WU_CONFIG_MODE_REG_VAL_RANGE ]    mode_reg_value       [`MGR_WU_OPT_PER_INST] ;


  //-------------------------------------------------------------------------------------------------
  // to WUM
  reg                                        mcntl__wum__enable_inst_dnld_e1 ;
  reg                                        mcntl__wum__valid_e1            ;
  reg                                        wum__mcntl__ready_d1            ;
  reg   [`MGR_WU_ADDRESS_RANGE          ]    mcntl__wum__address_e1          ;
  // WU Instruction delineators
  reg   [`COMMON_STD_INTF_CNTL_RANGE    ]    mcntl__wum__icntl_e1            ;  // instruction delineator
  reg   [`COMMON_STD_INTF_CNTL_RANGE    ]    mcntl__wum__dcntl_e1            ;  // descriptor delineator
  reg   [`MGR_INST_TYPE_RANGE           ]    mcntl__wum__op_e1               ;  // NOP, OP, MR, MW
  
  // WU Instruction option fields
  reg   [`MGR_WU_OPT_TYPE_RANGE         ]    mcntl__wum__option_type_e1    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
  reg   [`MGR_WU_OPT_VALUE_RANGE        ]    mcntl__wum__option_value_e1   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 

  //-------------------------------------------------------------------------------------------------
  // from NoC 
  reg                                               noc__mcntl__cp_valid_d1      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     noc__mcntl__cp_cntl_d1       ; 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     noc__mcntl__cp_type_d1       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     noc__mcntl__cp_ptype_d1      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     noc__mcntl__cp_data_d1       ; 
  reg                                               noc__mcntl__cp_pvalid_d1     ; 
  reg  [`MGR_ARRAY_HOST_ID_RANGE              ]     noc__mcntl__cp_mgrId_d1      ; 
  wire                                              mcntl__noc__cp_ready_e1      ; 

  reg                                               noc__mcntl__dp_valid_d1      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     noc__mcntl__dp_cntl_d1       ; 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     noc__mcntl__dp_type_d1       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     noc__mcntl__dp_ptype_d1      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     noc__mcntl__dp_data_d1       ; 
  reg                                               noc__mcntl__dp_pvalid_d1     ; 
  reg  [`MGR_ARRAY_HOST_ID_RANGE              ]     noc__mcntl__dp_mgrId_d1      ; 
  reg                                               mcntl__noc__dp_ready_e1      ; 

  // tp NoC 
  wire                                              mcntl__noc__cp_valid_e1      ; 
  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__noc__cp_cntl_e1       ; 
  reg                                               noc__mcntl__cp_ready_d1      ; 
  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__noc__cp_type_e1       ; 
  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__noc__cp_ptype_e1      ; 
  wire [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE     ]     mcntl__noc__cp_desttype_e1   ; 
  wire                                              mcntl__noc__cp_pvalid_e1     ; 
  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__noc__cp_data_e1       ; 
                                                                                 
  reg                                               mcntl__noc__dp_valid_e1      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__noc__dp_cntl_e1       ; 
  reg                                               noc__mcntl__dp_ready_d1      ; 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__noc__dp_type_e1       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__noc__dp_ptype_e1      ; 
  reg  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE     ]     mcntl__noc__dp_desttype_e1   ; 
  reg                                               mcntl__noc__dp_pvalid_e1     ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__noc__dp_data_e1       ; 
  
  
  //-------------------------------------------------------------------------------------------------
  // from RDP
  // Aggregate Data-path (dp) to NoC               
  reg                                               rdp__mcntl__noc_valid_d1      ; 
  reg    [`COMMON_STD_INTF_CNTL_RANGE          ]    rdp__mcntl__noc_cntl_d1       ; 
  wire                                              mcntl__rdp__noc_ready_p1      ; 
  reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    rdp__mcntl__noc_type_d1       ; 
  reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    rdp__mcntl__noc_ptype_d1      ; 
  reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    rdp__mcntl__noc_desttype_d1   ; 
  reg                                               rdp__mcntl__noc_pvalid_d1     ; 
  reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    rdp__mcntl__noc_data_d1       ; 

  //-------------------------------------------------------------------------------------------------
  // to MWC
  reg                                               mcntl__mwc__valid_e1      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__mwc__cntl_e1       ; 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__mwc__type_e1       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__mwc__ptype_e1      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__mwc__data_e1       ; 
  reg                                               mcntl__mwc__pvalid_e1     ; 
  reg  [`MGR_ARRAY_HOST_ID_RANGE              ]     mcntl__mwc__mgrId_e1      ; 
  reg                                               mwc__mcntl__ready_d1      ; 

  

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registered Inputs and Outputs

    always @(posedge clk) 
      begin
        mcntl__wuf__stall                   <=  mcntl__wuf__stall_e1      ;
        mcntl__wud__stall                   <=  mcntl__wud__stall_e1      ;
        mcntl__wuf__release                 <=  mcntl__wuf__release_e1    ;
        mcntl__wud__release                 <=  mcntl__wud__release_e1    ;
        wuf__mcntl__stalled_d1              <=  wuf__mcntl__stalled       ;
        wud__mcntl__stalled_d1              <=  wud__mcntl__stalled       ;
      end

  genvar gvi ;
  generate
    for (gvi=0; gvi<`MGR_CNTL_NUM_OF_DMA_LANES; gvi=gvi+1) 
      begin
        always @(posedge clk)
          begin
            mrc__mcntl__lane_valid_d1 [gvi]   <=  mrc__mcntl__lane_valid    [gvi] ;
            mrc__mcntl__lane_cntl_d1  [gvi]   <=  mrc__mcntl__lane_cntl     [gvi] ;
            mcntl__mrc__lane_ready    [gvi]   <=  mcntl__mrc__lane_ready_e1 [gvi] ;
            mrc__mcntl__lane_data_d1  [gvi]   <=  mrc__mcntl__lane_data     [gvi] ;
          end
      end
  endgenerate
  //-------------------------------------------------------------------------------------------------
  // to WUM
    always @(posedge clk) 
      begin
        mcntl__wum__enable_inst_dnld <=  (reset_poweron) ? 1'b0 : mcntl__wum__enable_inst_dnld_e1 ;
        mcntl__wum__valid            <=  (reset_poweron) ? 1'b0 : mcntl__wum__valid_e1            ;
        wum__mcntl__ready_d1         <=  wum__mcntl__ready               ;
                                                                         
        mcntl__wum__address          <=  mcntl__wum__address_e1          ;
        mcntl__wum__icntl            <=  mcntl__wum__icntl_e1            ;
        mcntl__wum__dcntl            <=  mcntl__wum__dcntl_e1            ;
        mcntl__wum__op               <=  mcntl__wum__op_e1               ;
        /*
       for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
         begin: option_out
           mcntl__wum__option_type    [opt]  <=  mcntl__wum__option_type_e1    [opt] ;
           mcntl__wum__option_value   [opt]  <=  mcntl__wum__option_value_e1   [opt] ;
         end
        */
      end
  genvar opt;
  generate
    for (opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
      begin
        always @(posedge clk) 
          begin
             mcntl__wum__option_type    [opt]  <=  mcntl__wum__option_type_e1    [opt] ;
             mcntl__wum__option_value   [opt]  <=  mcntl__wum__option_value_e1   [opt] ;
          end
      end
  endgenerate

  //--------------------------------------------------
  // from NoC
  
  always @(posedge clk) 
    begin
      noc__mcntl__cp_valid_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_valid      ;
      noc__mcntl__cp_cntl_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_cntl       ;
      noc__mcntl__cp_type_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_type       ;
      noc__mcntl__cp_ptype_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_ptype      ;
      noc__mcntl__cp_data_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_data       ;
      noc__mcntl__cp_pvalid_d1   <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_pvalid     ;
      noc__mcntl__cp_mgrId_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_mgrId      ;
      mcntl__noc__cp_ready       <=   ( reset_poweron   ) ? 'd0  : mcntl__noc__cp_ready_e1   ;

      noc__mcntl__dp_valid_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_valid      ;
      noc__mcntl__dp_cntl_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_cntl       ;
      noc__mcntl__dp_type_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_type       ;
      noc__mcntl__dp_ptype_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_ptype      ;
      noc__mcntl__dp_data_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_data       ;
      noc__mcntl__dp_pvalid_d1   <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_pvalid     ;
      noc__mcntl__dp_mgrId_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_mgrId      ;
      mcntl__noc__dp_ready       <=   ( reset_poweron   ) ? 'd0  : mcntl__noc__dp_ready_e1   ;
    end

  //--------------------------------------------------
  // to NoC
  
  always @(posedge clk)
    begin
      mcntl__noc__cp_valid       <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__cp_valid_e1    ;
      mcntl__noc__cp_cntl        <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__cp_cntl_e1     ;
      noc__mcntl__cp_ready_d1    <= ( reset_poweron   ) ? 'd0  :  noc__mcntl__cp_ready       ;
      mcntl__noc__cp_type        <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__cp_type_e1     ;
      mcntl__noc__cp_ptype       <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__cp_ptype_e1    ;
      mcntl__noc__cp_desttype    <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__cp_desttype_e1 ;
      mcntl__noc__cp_pvalid      <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__cp_pvalid_e1   ;
      mcntl__noc__cp_data        <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__cp_data_e1     ;

      mcntl__noc__dp_valid       <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__dp_valid_e1    ;
      mcntl__noc__dp_cntl        <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__dp_cntl_e1     ;
      noc__mcntl__dp_ready_d1    <= ( reset_poweron   ) ? 'd0  :  noc__mcntl__dp_ready       ;
      mcntl__noc__dp_type        <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__dp_type_e1     ;
      mcntl__noc__dp_ptype       <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__dp_ptype_e1    ;
      mcntl__noc__dp_desttype    <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__dp_desttype_e1 ;
      mcntl__noc__dp_pvalid      <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__dp_pvalid_e1   ;
      mcntl__noc__dp_data        <= ( reset_poweron   ) ? 'd0  :  mcntl__noc__dp_data_e1     ;
    end

    always @(posedge clk) 
      begin
        rdp__mcntl__noc_valid_d1       <= ( reset_poweron   ) ? 'd0  :  rdp__mcntl__noc_valid       ;
        rdp__mcntl__noc_cntl_d1        <= ( reset_poweron   ) ? 'd0  :  rdp__mcntl__noc_cntl        ;
        mcntl__rdp__noc_ready          <= ( reset_poweron   ) ? 'd0  :  mcntl__rdp__noc_ready_p1    ;
        rdp__mcntl__noc_type_d1        <= ( reset_poweron   ) ? 'd0  :  rdp__mcntl__noc_type        ;
        rdp__mcntl__noc_ptype_d1       <= ( reset_poweron   ) ? 'd0  :  rdp__mcntl__noc_ptype       ;
        rdp__mcntl__noc_desttype_d1    <= ( reset_poweron   ) ? 'd0  :  rdp__mcntl__noc_desttype    ;
        rdp__mcntl__noc_pvalid_d1      <= ( reset_poweron   ) ? 'd0  :  rdp__mcntl__noc_pvalid      ;
        rdp__mcntl__noc_data_d1        <= ( reset_poweron   ) ? 'd0  :  rdp__mcntl__noc_data        ;
      end

    always @(posedge clk) 
      begin
        mcntl__wud__ready          <=   ( reset_poweron   ) ? 'd0  :  mcntl__wud__ready_e1   ;
        wud__mcntl__valid_d1       <=   ( reset_poweron   ) ? 'd0  :  wud__mcntl__valid      ;
        wud__mcntl__dcntl_d1       <=   ( reset_poweron   ) ? 'd0  :  wud__mcntl__dcntl      ;
        wud__mcntl__tag_d1         <=   ( reset_poweron   ) ? 'd0  :  wud__mcntl__tag        ;
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_in
            wud__mcntl__option_type_d1  [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mcntl__option_type  [opt]  ;
            wud__mcntl__option_value_d1 [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mcntl__option_value [opt]  ;
          end
      end

  //-------------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------
  // Configuration
  //  - FIXME temporary assignments
  
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // WUD Communication FSM
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // - decode mode registers
  // - coordinate nformation transfer
  //

  reg    [`MGR_STD_OOB_TAG_RANGE            ]    cfg_tag                        ;  // one tag per cfg instruction

  reg    [`MGR_WU_OPT_PER_INST_RANGE        ]    cfg_data_mode_reg_valid        ;  // only expect one cfg mode reg per instruction
  reg    [`MGR_WU_OPT_TYPE_RANGE            ]    cfg_data_mode_reg_type         ;
  reg    [`MGR_WU_CONFIG_MODE_REG_ID_RANGE  ]    cfg_data_mode_reg_id           ;
  reg    [`MGR_WU_CONFIG_MODE_REG_VAL_RANGE ]    cfg_data_mode_reg_value        ;

  reg    [`MGR_WU_OPT_PER_INST_RANGE        ]    cfg_sync_mode_reg_valid        ;  // only expect one sync mode reg per instruction
  reg    [`MGR_WU_OPT_TYPE_RANGE            ]    cfg_sync_mode_reg_type         ;
  reg    [`MGR_WU_CONFIG_MODE_REG_ID_RANGE  ]    cfg_sync_mode_reg_id           ;
  reg    [`MGR_WU_CONFIG_MODE_REG_VAL_RANGE ]    cfg_sync_mode_reg_value        ;

  reg                                            cfg_storage_desc_ptr_valid     ;
  reg    [`MGR_WU_OPT_TYPE_RANGE            ]    cfg_storage_desc_ptr_type      ;  // keep for debug
  reg    [`MGR_WU_EXTD_OPT_VALUE_RANGE      ]    cfg_storage_desc_ptr_value     ;
                                                                                
  wire                                           process_wud                    ;
  wire                                           from_wud_valid                 ;
  wire                                           from_wud_sod                   ;
  wire                                           from_wud_eod                   ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE       ]    from_wud_dcntl                 ;
  wire   [`MGR_STD_OOB_TAG_RANGE            ]    from_wud_tag                   ;
  wire   [`MGR_WU_OPT_TYPE_RANGE            ]    from_wud_option_type     [`MGR_WU_OPT_PER_INST_RANGE ]  ; 
  wire   [`MGR_WU_OPT_VALUE_RANGE           ]    from_wud_option_value    [`MGR_WU_OPT_PER_INST_RANGE ]  ;
  wire                                           from_wud_read                  ;

  wire                                           from_mrc_lanes_valid         ;
  wire                                           upld_transfer_mrc_to_noc     ;  
  wire                                           upld_transfer_one_mrc_to_noc ;  
  wire   [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE  ]    from_mrc_valid               ;
  wire   [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE  ]    from_mrc_som                 ;
  wire   [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE  ]    from_mrc_mom                 ;
  wire   [`MGR_CNTL_NUM_OF_DMA_LANES_RANGE  ]    from_mrc_eom                 ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE       ]    from_mrc_cntl                [`MGR_CNTL_NUM_OF_DMA_LANES ] ;
  wire   [`STREAMING_OP_DATA_RANGE          ]    from_mrc_data                [`MGR_CNTL_NUM_OF_DMA_LANES ] ;
  wire                                           from_mrc_read                [`MGR_CNTL_NUM_OF_DMA_LANES ] ;
      

  reg                                               processing_config_upld     ;  // sending data to host
  reg                                               processing_sync_to_host    ;  
  reg                                               processing_sync_to_ssc     ;  
  reg                                               processing_config_upld_d1  ;  // sending data to host
  reg                                               processing_sync_to_host_d1 ;  
  reg                                               processing_sync_to_ssc_d1  ;  

  reg    [`COMMON_STD_INTF_CNTL_RANGE          ]    config_to_noc_cntl         ;
  reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    config_to_noc_type         ; 
  reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    config_to_noc_ptype        ; 
  reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    config_to_noc_desttype     ; 
  reg                                               config_to_noc_pvalid       ; 
  reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    config_to_noc_data         ; 
  reg                                               config_upld_fifo_write     ;
  reg                                               config_sync_fifo_write     ;

  reg                                               to_noc_almost_full         ;


  reg    [`MGR_WU_CONFIG_MODE_REG_VAL_P1_RANGE                 ]    upld_word_count            ;  // extra bit to account for negative
  reg    [`MGR_NOC_CONT_EXTERNAL_MTU_DATA_CYCLE_COUNT_P1_RANGE ]    noc_data_cycle_count  ;
  reg                                                               noc_data_mtu_cycle    ;
  reg                                                               upld_noc_data_first_pkt    ;
  reg                                                               upld_noc_data_last_pkt     ;

  // State register 
  reg [`MGR_CNTL_MAIN_STATE_RANGE ] mgr_cntl_main_state      ; // state flop
  reg [`MGR_CNTL_MAIN_STATE_RANGE ] mgr_cntl_main_state_next ;

  always @(posedge clk)
    begin
      mgr_cntl_main_state <= ( reset_poweron ) ? `MGR_CNTL_MAIN_WAIT        :
                                                 mgr_cntl_main_state_next  ;
    end

  always @(*)
    begin
      case (mgr_cntl_main_state)  // synopsys parallel_case
        
        `MGR_CNTL_MAIN_WAIT: 
          mgr_cntl_main_state_next =   (from_wud_valid ) ? `MGR_CNTL_MAIN_START_WUD :
                                                           `MGR_CNTL_MAIN_WAIT      ; 

        `MGR_CNTL_MAIN_START_WUD: 
          mgr_cntl_main_state_next =   (from_wud_eod   ) ? `MGR_CNTL_MAIN_COMPLETE_WUD :
                                                           `MGR_CNTL_MAIN_PROCESS_WUD      ; 

        `MGR_CNTL_MAIN_PROCESS_WUD: 
          mgr_cntl_main_state_next =   (from_wud_valid && from_wud_eod   ) ? `MGR_CNTL_MAIN_COMPLETE_WUD :
                                                                             `MGR_CNTL_MAIN_PROCESS_WUD  ; 

        `MGR_CNTL_MAIN_COMPLETE_WUD: 
          mgr_cntl_main_state_next =   (cfg_data_mode_reg_valid && (cfg_data_mode_reg_id ==  `MGR_WU_EXTD_TUPLE_MODE_REG_TXFER_MEM_UPLD))  ? `MGR_CNTL_MAIN_MEM_UPLD_HEADER :
                                       (cfg_data_mode_reg_valid && (cfg_data_mode_reg_id ==  `MGR_WU_EXTD_TUPLE_MODE_REG_TXFER_MEM_DNLD))  ? `MGR_CNTL_MAIN_MEM_DNLD        :
                                       (cfg_sync_mode_reg_valid && (cfg_sync_mode_reg_id ==  `MGR_WU_EXTD_TUPLE_MODE_REG_SYNC_SEND     ))  ? `MGR_CNTL_MAIN_SYNC_SEND_HEADER :
                                                                                                                                             `MGR_CNTL_MAIN_WAIT            ; 
  
        // must be preceded by a flush
        `MGR_CNTL_MAIN_MEM_UPLD_HEADER: 
          mgr_cntl_main_state_next =   (~to_noc_almost_full && (upld_word_count == 'd1)  )  ?  `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT   :
                                       (~to_noc_almost_full && (upld_word_count == 'd2)  )  ?  `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT   :
                                       (~to_noc_almost_full                              )  ?  `MGR_CNTL_MAIN_MEM_UPLD_DATA           :
                                                                                               `MGR_CNTL_MAIN_MEM_UPLD_HEADER         ;

        `MGR_CNTL_MAIN_MEM_UPLD_DATA: 
          mgr_cntl_main_state_next =   ((upld_word_count == 'd3   ) && upld_transfer_mrc_to_noc  )  ?  `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT   :
                                       ((upld_word_count == 'd4   ) && upld_transfer_mrc_to_noc  )  ?  `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT   :
                                       ( noc_data_mtu_cycle    && upld_transfer_mrc_to_noc  )  ?  `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT   :
                                                                                                       `MGR_CNTL_MAIN_MEM_UPLD_DATA           ;

        `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT: 
          mgr_cntl_main_state_next =   ((upld_word_count == 'd1   ) && upld_transfer_one_mrc_to_noc  )  ?  `MGR_CNTL_MAIN_COMPLETE     :
                                       ((upld_word_count == 'd2   ) && upld_transfer_mrc_to_noc      )  ?  `MGR_CNTL_MAIN_COMPLETE     :
                                       (                               upld_transfer_mrc_to_noc      )  ?  `MGR_CNTL_MAIN_MEM_UPLD_HEADER       :
                                                                                                           `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT ;

        `MGR_CNTL_MAIN_SYNC_SEND_HEADER: 
          mgr_cntl_main_state_next =   (~to_noc_almost_full )  ?  `MGR_CNTL_MAIN_SYNC_SEND :
                                                                  `MGR_CNTL_MAIN_SYNC_SEND_HEADER  ;
                                                        
        `MGR_CNTL_MAIN_SYNC_SEND: 
          mgr_cntl_main_state_next =   (~to_noc_almost_full &&  noc_data_mtu_cycle    )  ?  `MGR_CNTL_MAIN_SYNC_SEND_END :
                                                                                          `MGR_CNTL_MAIN_SYNC_SEND              ;
                                                        
        `MGR_CNTL_MAIN_SYNC_SEND_END: 
          mgr_cntl_main_state_next =   (~to_noc_almost_full )  ?  `MGR_CNTL_MAIN_COMPLETE :
                                                                  `MGR_CNTL_MAIN_SYNC_SEND_END              ;
        `MGR_CNTL_MAIN_MEM_DNLD: 
          mgr_cntl_main_state_next =   `MGR_CNTL_MAIN_COMPLETE ;
                                                        

        `MGR_CNTL_MAIN_COMPLETE: 
          mgr_cntl_main_state_next =   ( ~wud__mcntl__stalled_d1 ) ? `MGR_CNTL_MAIN_WAIT      :
                                                                   `MGR_CNTL_MAIN_COMPLETE ;
                                                        
        `MGR_CNTL_MAIN_ERR: 
          mgr_cntl_main_state_next =   `MGR_CNTL_MAIN_ERR ;


        default:
          mgr_cntl_main_state_next =   `MGR_CNTL_MAIN_WAIT     ; 

      endcase // case (mgr_cntl_main_state)
    end // always @ (*)


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //
  assign process_wud = (mgr_cntl_main_state == `MGR_CNTL_MAIN_START_WUD ) | (mgr_cntl_main_state == `MGR_CNTL_MAIN_PROCESS_WUD ) | (mgr_cntl_main_state == `MGR_CNTL_MAIN_COMPLETE_WUD );
  
  always @(*)
    begin
      mcntl__wud__release_e1 = (mgr_cntl_main_state == `MGR_CNTL_MAIN_COMPLETE ) ;
    end

  always @(*)
    begin
      processing_config_upld    = (mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_HEADER  ) | (mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_DATA ) | (mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT ) ;
      processing_sync_to_host   = (mgr_cntl_main_state == `MGR_CNTL_MAIN_SYNC_SEND_HEADER ) | (mgr_cntl_main_state == `MGR_CNTL_MAIN_SYNC_SEND     ) | (mgr_cntl_main_state == `MGR_CNTL_MAIN_SYNC_SEND_END         ) ;
    end

  always @(posedge clk)
    begin
      upld_word_count           <= ((mgr_cntl_main_state == `MGR_CNTL_MAIN_COMPLETE_WUD            )                             )   ? cfg_data_mode_reg_value :
                                   ((mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_DATA           ) && upld_transfer_mrc_to_noc )   ? upld_word_count - 'd2   :
                                   ((mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT   ) && upld_transfer_mrc_to_noc )   ? upld_word_count - 'd2   :
                                                                                                                                       upld_word_count         ;
    end

  always @(posedge clk)
    begin
      upld_noc_data_last_pkt    <= ((mgr_cntl_main_state == `MGR_CNTL_MAIN_COMPLETE_WUD            ) && (cfg_data_mode_reg_value <= `MGR_NOC_CONT_EXTERNAL_MTU_WORDS_PER_PKT))     ? 1'b1 :
                                   ((mgr_cntl_main_state == `MGR_CNTL_MAIN_COMPLETE_WUD            )                                                                         )     ? 1'b0 :
                                   ((mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_DATA           ) && (upld_word_count          < `MGR_NOC_CONT_EXTERNAL_MTU_WORDS_PER_PKT))     ? 1'b1 :
                                   ((mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT   ) && (upld_word_count          < `MGR_NOC_CONT_EXTERNAL_MTU_WORDS_PER_PKT))     ? 1'b1 :
                                                                                                                                                                                    upld_noc_data_last_pkt ;

      upld_noc_data_first_pkt   <= ((mgr_cntl_main_state == `MGR_CNTL_MAIN_COMPLETE_WUD          )                              )     ? 1'b1 :                            
                                   ((mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT ) && upld_transfer_mrc_to_noc  )     ? 1'b0 :
                                                                                                                                        upld_noc_data_first_pkt ;
    end

  always @(posedge clk)
    begin
      noc_data_cycle_count      <= ((mgr_cntl_main_state == `MGR_CNTL_MAIN_COMPLETE_WUD            )                             )   ? 'd1                        :
                                   ((mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_DATA           ) && upld_transfer_mrc_to_noc )   ? noc_data_cycle_count + 'd1 :
                                   ((mgr_cntl_main_state == `MGR_CNTL_MAIN_SYNC_SEND               ) && ~to_noc_almost_full      )   ? noc_data_cycle_count + 'd1 :
                                   ((mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT   ) && upld_transfer_mrc_to_noc )   ? 'd1                        :
                                                                                                                                       noc_data_cycle_count       ;

    end

  always @(*)
    begin

      noc_data_mtu_cycle   = (noc_data_cycle_count == `MGR_NOC_CONT_EXTERNAL_MTU_CYCLES_PER_PKT_M1 );
 
    end


  assign    from_mrc_lanes_valid            = from_mrc_valid[0] & from_mrc_valid[1] ;
  assign    upld_transfer_mrc_to_noc        = processing_config_upld & from_mrc_lanes_valid  & ~to_noc_almost_full ;
  assign    upld_transfer_one_mrc_to_noc    = processing_config_upld & from_mrc_valid[0]     & ~to_noc_almost_full ;

  always @(posedge clk)
    begin
      processing_config_upld_d1    <= processing_config_upld  ;   
      processing_sync_to_host_d1   <= processing_sync_to_host ;

      config_to_noc_type      <= ( processing_sync_to_host ) ?   `MGR_NOC_CONT_TYPE_CFG              :
                                 ( upld_noc_data_last_pkt  ) ?  `MGR_NOC_CONT_TYPE_CFG_DMA_DATA_EOD  :
                                 ( upld_noc_data_first_pkt ) ?  `MGR_NOC_CONT_TYPE_CFG_DMA_DATA_SOD  :
                                                                `MGR_NOC_CONT_TYPE_CFG_DMA_DATA      ;
                                                                                                    

      //config_to_noc_desttype  <= `MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_MCAST_BITFIELD    ; 
      config_to_noc_desttype  <= `MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_UNICAST             ;
      config_to_noc_pvalid    <= (upld_word_count != 'd1) ; 

      //config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE ]     <= (mgr_cntl_main_state == `MGR_CNTL_MAIN_MEM_UPLD_HEADER         ) ? {{30'd0, 1'b1, 1'b0}}       : // FIXME
      case (mgr_cntl_main_state)
        `MGR_CNTL_MAIN_MEM_UPLD_HEADER :
          begin
            config_to_noc_cntl                                                               <= `COMMON_STD_INTF_CNTL_SOM       ;
            config_to_noc_ptype                                                              <= `MGR_NOC_CONT_PAYLOAD_TYPE_NOP  ;
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_HEADER_UNICAST_DEST_ADDR_RANGE ]     <= `MGR_ARRAY_HOST_ID              ;
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_HEADER_UNICAST_PAD_RANGE       ]     <= 'd0                             ;
            config_upld_fifo_write                                                           <= ~to_noc_almost_full             ;
            config_sync_fifo_write                                                           <= 1'b0                            ;
          end
        `MGR_CNTL_MAIN_MEM_UPLD_DATA :
          begin
            config_to_noc_cntl                                                               <= `COMMON_STD_INTF_CNTL_MOM       ;
            config_to_noc_ptype                                                              <= `MGR_NOC_CONT_PAYLOAD_TYPE_DATA ; 
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE ]             <= from_mrc_data[0]                ;
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE ]             <= from_mrc_data[1]                ;
            config_upld_fifo_write                                                           <= upld_transfer_mrc_to_noc        ;
            config_sync_fifo_write                                                           <= 1'b0                            ;
          end                                                                               
        `MGR_CNTL_MAIN_MEM_UPLD_DATA_END_PKT :                                              
          begin                                                                             
            config_to_noc_cntl                                                               <= `COMMON_STD_INTF_CNTL_EOM       ;
            config_to_noc_ptype                                                              <= `MGR_NOC_CONT_PAYLOAD_TYPE_DATA ; 
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE ]             <= from_mrc_data[0]                ;
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE ]             <= from_mrc_data[1]                ;
            config_upld_fifo_write                                                           <= ((upld_word_count == 'd1) & upld_transfer_one_mrc_to_noc) | upld_transfer_mrc_to_noc ;
            config_sync_fifo_write                                                           <= 1'b0                            ;
          end
        `MGR_CNTL_MAIN_SYNC_SEND_HEADER :
          begin
            config_to_noc_cntl                                                               <= `COMMON_STD_INTF_CNTL_SOM       ;
            config_to_noc_ptype                                                              <= `MGR_NOC_CONT_PAYLOAD_TYPE_NOP  ;
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_HEADER_UNICAST_DEST_ADDR_RANGE ]     <= `MGR_ARRAY_HOST_ID              ;
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_HEADER_UNICAST_PAD_RANGE       ]     <= 'd0                             ;
            config_upld_fifo_write                                                           <= 1'b0                            ;
            config_sync_fifo_write                                                           <= ~to_noc_almost_full             ;
          end
        `MGR_CNTL_MAIN_SYNC_SEND :
          begin
            config_to_noc_cntl                                                               <= `COMMON_STD_INTF_CNTL_MOM       ;
            config_to_noc_ptype                                                              <= `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ; 
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE ]             <= {cfg_data_mode_reg_type, cfg_data_mode_reg_type, cfg_data_mode_reg_value};
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE ]             <= {{`MGR_WU_OPT_TYPE_WIDTH 'd `MGR_INST_OPTION_TYPE_NOP},  {{`MGR_WU_EXTD_OPT_VALUE_WIDTH {1'b1}}}} ;
            config_upld_fifo_write                                                           <= 1'b0                            ;
            config_sync_fifo_write                                                           <= ~to_noc_almost_full;
          end                                                                               
        `MGR_CNTL_MAIN_SYNC_SEND_END :
          begin
            config_to_noc_cntl                                                               <= `COMMON_STD_INTF_CNTL_EOM       ;
            config_to_noc_ptype                                                              <= `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ; 
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE ]             <= {{`MGR_WU_OPT_TYPE_WIDTH 'd `MGR_INST_OPTION_TYPE_NOP},  {{`MGR_WU_EXTD_OPT_VALUE_WIDTH {1'b1}}}} ;
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE ]             <= {{`MGR_WU_OPT_TYPE_WIDTH 'd `MGR_INST_OPTION_TYPE_NOP},  {{`MGR_WU_EXTD_OPT_VALUE_WIDTH {1'b1}}}} ;
            config_upld_fifo_write                                                           <= 1'b0                            ;
            config_sync_fifo_write                                                           <= ~to_noc_almost_full;
          end                                                                               
        default:                                                                            
          begin                                                                             
            config_to_noc_cntl                                                               <=  'd0 ;
            config_to_noc_ptype                                                              <=  'd0 ;
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE ]             <=  'd0 ;
            config_to_noc_data  [`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE ]             <=  'd0 ;
            config_upld_fifo_write                                                           <=  'd0 ;
            config_sync_fifo_write                                                           <=  'd0 ;
          end
      endcase

    end
  //--------------------------------------------------


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // NoC Communication FSM
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // - manage host communication
  // - aggegate exceptions
  // - configuration
  //

  reg  [`MGR_WU_ADDRESS_RANGE                 ]     wum_address         ; 

  wire                                              from_noc_peek_valid  ,    from_noc_valid      ; 
  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     from_noc_peek_cntl   ,    from_noc_cntl       ; 
  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     from_noc_peek_type   ,    from_noc_type       ; 
  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     from_noc_peek_ptype  ,    from_noc_ptype      ; 
  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     from_noc_peek_data   ,    from_noc_data       ; 
  wire                                              from_noc_peek_pvalid ,    from_noc_pvalid     ; 
  wire [`MGR_ARRAY_HOST_ID_RANGE              ]     from_noc_peek_srcId  ,    from_noc_srcId      ; 
  wire                                              from_noc_peek_read   ,    from_noc_read       ; 
      
  // State register 
  reg [`MGR_CNTL_NOC_CNTL_STATE_RANGE ] mgr_cntl_noc_cntl_state      ; // state flop
  reg [`MGR_CNTL_NOC_CNTL_STATE_RANGE ] mgr_cntl_noc_cntl_state_next ;

  always @(posedge clk)
    begin
      mgr_cntl_noc_cntl_state <= ( reset_poweron ) ? `MGR_CNTL_NOC_CNTL_INST_DNLD_INIT        :
                                                 mgr_cntl_noc_cntl_state_next  ;
    end

  always @(*)
    begin
      case (mgr_cntl_noc_cntl_state)
        
        // first we need to download instructions
        `MGR_CNTL_NOC_CNTL_INST_DNLD_INIT: 
          //mgr_cntl_noc_cntl_state_next =   `MGR_CNTL_NOC_CNTL_WAIT ;
          //mgr_cntl_noc_cntl_state_next =   `MGR_CNTL_NOC_CNTL_DNLD_INST ;
          mgr_cntl_noc_cntl_state_next =   (sys__mgr__mgrId == `MGR_WU_MEMORY_INIT_ID ) ? `MGR_CNTL_NOC_CNTL_DNLD_INST : `MGR_CNTL_NOC_CNTL_WAIT ; // FIXME

        `MGR_CNTL_NOC_CNTL_DNLD_INST: 
          mgr_cntl_noc_cntl_state_next =  ((from_noc_cntl == `COMMON_STD_INTF_CNTL_EOM) && (from_noc_type == `MGR_NOC_CONT_TYPE_INSTRUCTION_EOD) && from_noc_read) ? `MGR_CNTL_NOC_CNTL_DNLD_INST_COMPLETE :
                                                                                                                                                                 `MGR_CNTL_NOC_CNTL_DNLD_INST          ;

        `MGR_CNTL_NOC_CNTL_DNLD_INST_COMPLETE: 
          mgr_cntl_noc_cntl_state_next =    `MGR_CNTL_NOC_CNTL_WAIT          ;
                                                                                                                         
        //----------------------------------------------------------------------------------------------------
        // In these states, all packets from NoC are directed toward the MWC
        //
        `MGR_CNTL_NOC_CNTL_WAIT: 
          mgr_cntl_noc_cntl_state_next =  
                                      ( from_noc_valid  && (from_noc_cntl == `COMMON_STD_INTF_CNTL_SOM) && (from_noc_srcId == {1'b0, sys__mgr__mgrId})                                        ) ? `MGR_CNTL_NOC_CNTL_ERR      : // from same SSC??
                                      ( from_noc_valid  && (from_noc_cntl != `COMMON_STD_INTF_CNTL_SOM)                                                                                       ) ? `MGR_CNTL_NOC_CNTL_ERR      : // first isnt SOM??
                                      ( from_noc_valid  && (from_noc_cntl == `COMMON_STD_INTF_CNTL_SOM) &&  from_noc_peek_valid && (from_noc_peek_type == `MGR_NOC_CONT_TYPE_DESC_WRITE_DATA) ) ? `MGR_CNTL_NOC_CNTL_MWC_RCV  : 
                                                                                                                                                                                                  `MGR_CNTL_NOC_CNTL_WAIT  ;
  
 
        `MGR_CNTL_NOC_CNTL_MWC_RCV: 
          mgr_cntl_noc_cntl_state_next =  
                                      ( from_noc_valid  && (from_noc_cntl == `COMMON_STD_INTF_CNTL_EOM)) ? `MGR_CNTL_NOC_CNTL_WAIT      : 
                                                                                                           `MGR_CNTL_NOC_CNTL_MWC_RCV       ;
  

        `MGR_CNTL_NOC_CNTL_COMPLETE: 
          mgr_cntl_noc_cntl_state_next =   `MGR_CNTL_NOC_CNTL_WAIT ;


        `MGR_CNTL_NOC_CNTL_ERR: 
          mgr_cntl_noc_cntl_state_next =   `MGR_CNTL_NOC_CNTL_ERR ;


        default:
          mgr_cntl_noc_cntl_state_next =   `MGR_CNTL_NOC_CNTL_WAIT     ; 

      endcase // case (mgr_cntl_noc_cntl_state)
    end // always @ (*)


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // FSM assignments
      
  always @(posedge clk) 
    begin
      case (mgr_cntl_noc_cntl_state)  // parallel_case

        `MGR_CNTL_NOC_CNTL_INST_DNLD_INIT :
          begin
            wum_address <= 'd0 ;
          end

        `MGR_CNTL_NOC_CNTL_DNLD_INST :
          begin
            // its valid if reading
            // only send instruction payload to wum
            wum_address <= ( from_noc_read && ((from_noc_type == `MGR_NOC_CONT_TYPE_INSTRUCTION_SOD) || (from_noc_type == `MGR_NOC_CONT_TYPE_INSTRUCTION) || (from_noc_type == `MGR_NOC_CONT_TYPE_INSTRUCTION_EOD))) ? wum_address + 'd1 : wum_address ;
          end

        default:
          begin
            wum_address <= wum_address ;
          end

      endcase
    end

  always @(*)
    begin
      case (mgr_cntl_noc_cntl_state)  // parallel_case

        `MGR_CNTL_NOC_CNTL_INST_DNLD_INIT :
          begin
            mcntl__wum__enable_inst_dnld_e1    = 'd1 ;

            mcntl__wum__address_e1             = 'd0 ;
            mcntl__wum__valid_e1               = 'd0 ;
            mcntl__wum__icntl_e1               = 'd0 ;   
            mcntl__wum__dcntl_e1               = 'd0 ;   
            mcntl__wum__op_e1                  = 'd0 ;  
            mcntl__wum__option_type_e1  [0]    = 'd0 ;     
            mcntl__wum__option_value_e1 [0]    = 'd0 ;     
            mcntl__wum__option_type_e1  [1]    = 'd0 ;     
            mcntl__wum__option_value_e1 [1]    = 'd0 ;     
            mcntl__wum__option_type_e1  [2]    = 'd0 ;     
            mcntl__wum__option_value_e1 [2]    = 'd0 ;     
          end
        `MGR_CNTL_NOC_CNTL_DNLD_INST :
          begin
            mcntl__wum__enable_inst_dnld_e1    = 'd1 ;

            mcntl__wum__address_e1             = wum_address ;
            mcntl__wum__valid_e1               = from_noc_read & ( from_noc_read && ((from_noc_type == `MGR_NOC_CONT_TYPE_INSTRUCTION_SOD) | (from_noc_type == `MGR_NOC_CONT_TYPE_INSTRUCTION) | (from_noc_type == `MGR_NOC_CONT_TYPE_INSTRUCTION_EOD))) ;
            mcntl__wum__icntl_e1               = from_noc_data [`MGR_INSTRUCTION_MEMORY_AGGREGATE_ICNTL_RANGE       ];   
            mcntl__wum__dcntl_e1               = from_noc_data [`MGR_INSTRUCTION_MEMORY_AGGREGATE_DCNTL_RANGE       ];   
            mcntl__wum__op_e1                  = from_noc_data [`MGR_INSTRUCTION_MEMORY_AGGREGATE_OPER_RANGE        ];  
            mcntl__wum__option_type_e1  [0]    = from_noc_data [`MGR_INSTRUCTION_MEMORY_AGGREGATE_OPT_TYPE0_RANGE   ];     
            mcntl__wum__option_value_e1 [0]    = from_noc_data [`MGR_INSTRUCTION_MEMORY_AGGREGATE_OPT_VAL0_RANGE    ];     
            mcntl__wum__option_type_e1  [1]    = from_noc_data [`MGR_INSTRUCTION_MEMORY_AGGREGATE_OPT_TYPE1_RANGE   ];     
            mcntl__wum__option_value_e1 [1]    = from_noc_data [`MGR_INSTRUCTION_MEMORY_AGGREGATE_OPT_VAL1_RANGE    ];     
            mcntl__wum__option_type_e1  [2]    = from_noc_data [`MGR_INSTRUCTION_MEMORY_AGGREGATE_OPT_TYPE2_RANGE   ];     
            mcntl__wum__option_value_e1 [2]    = from_noc_data [`MGR_INSTRUCTION_MEMORY_AGGREGATE_OPT_VAL2_RANGE    ];     
          end

        default:
          begin
            mcntl__wum__enable_inst_dnld_e1    = 'd0 ;

            mcntl__wum__address_e1             = 'd0 ;
            mcntl__wum__valid_e1               = 'd0 ;
            mcntl__wum__icntl_e1               = 'd0 ;   
            mcntl__wum__dcntl_e1               = 'd0 ;   
            mcntl__wum__op_e1                  = 'd0 ;  
            mcntl__wum__option_type_e1  [0]    = 'd0 ;     
            mcntl__wum__option_value_e1 [0]    = 'd0 ;     
            mcntl__wum__option_type_e1  [1]    = 'd0 ;     
            mcntl__wum__option_value_e1 [1]    = 'd0 ;     
            mcntl__wum__option_type_e1  [2]    = 'd0 ;     
            mcntl__wum__option_value_e1 [2]    = 'd0 ;     
          end

      endcase
    end

  always @(posedge clk)
    begin
      mcntl__wuf__start_addr  <= 24'd0   ;

      mcntl__wuf__enable      <= (reset_poweron                                     ) ? 1'b0               :
                                 (mgr_cntl_noc_cntl_state == `MGR_CNTL_NOC_CNTL_WAIT) ? 1'b1               : 
                                                                                        mcntl__wuf__enable ;

      mcntl__wuf__stall_e1    <= 1'b0    ;
      mcntl__wud__stall_e1    <= 1'b0    ;
      mcntl__wuf__release_e1  <= 1'b0    ;
      mcntl__wud__release_e1  <= 1'b0    ;

      mcntl__mwc__flush       <= 1'b0    ;
    end


  generate
    for (opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
      begin
        always @(*)
          begin
          end
      end
  endgenerate

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
 
  //--------------------------------------------------
  // to MWC
  
  always @(posedge clk) 
    begin
      mcntl__mwc__valid        <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__valid_e1    ;
      mcntl__mwc__cntl         <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__cntl_e1     ;
      mcntl__mwc__type         <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__type_e1     ;
      mcntl__mwc__ptype        <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__ptype_e1    ;
      mcntl__mwc__data         <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__data_e1     ;
      mcntl__mwc__pvalid       <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__pvalid_e1   ;
      mcntl__mwc__mgrId        <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__mgrId_e1    ;
      mwc__mcntl__ready_d1     <=   ( reset_poweron   ) ? 'd0  : mwc__mcntl__ready       ;
    end


  // FIXME
  assign  mcntl__noc__cp_ready_e1   = 1'b1 ;


  //----------------------------------------------------------------------------------------------------
  // From WU Decode
  //   - 
  //

  reg    [`MGR_WU_OPT_PER_INST_RANGE      ]            pipe_option_extd_valid                               ;
  reg    [`MGR_WU_OPT_TYPE_RANGE          ]            pipe_option_extd_type         [`MGR_WU_OPT_PER_INST] ;
  reg    [`MGR_WU_EXTD_OPT_VALUE_RANGE    ]            pipe_option_extd_value        [`MGR_WU_OPT_PER_INST] ;
  reg                                                  pipe_option_is_extd_type      [`MGR_WU_OPT_PER_INST] ;
  reg                                                  pipe_option_is_cfg_sync       [`MGR_WU_OPT_PER_INST] ;
  reg                                                  pipe_option_is_cfg_data       [`MGR_WU_OPT_PER_INST] ;

  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_WuDecode_Fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_dcntl         ;
        reg    [`MGR_STD_OOB_TAG_RANGE          ]         write_tag           ;
        reg    [`MGR_WU_OPT_TYPE_RANGE          ]         write_option_type    [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        reg    [`MGR_WU_OPT_VALUE_RANGE         ]         write_option_value   [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
                                                                           
        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_dcntl          ;
        wire   [`MGR_STD_OOB_TAG_RANGE          ]         read_tag            ;
        wire   [`MGR_WU_OPT_TYPE_RANGE          ]         read_option_type     [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        wire   [`MGR_WU_OPT_VALUE_RANGE         ]         read_option_value    [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`MGR_CNTL_WU_FIFO_FIFO_DEPTH                 ), 
                       .GENERIC_FIFO_THRESHOLD  (`MGR_CNTL_WU_FIFO_FIFO_ALMOST_FULL_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`MGR_CNTL_WU_FIFO_AGGREGATE_FIFO_WIDTH       )
                        ) gfifo (
                                          // Status
                                         .empty            ( empty                                                ),
                                         .almost_full      ( almost_full                                          ),
                                         .almost_empty     (                                                      ),
                                         .depth            (                                                      ),
                                          // Write                                                               
                                         .write            ( write                                                ),
                                         .write_data       ( {write_dcntl, write_tag, write_option_type[0], write_option_value[0],
                                                                                                  write_option_type[1], write_option_value[1],
                                                                                                  write_option_type[2], write_option_value[2]}),
                                          // Read                                                
                                         .read             ( read                                  ),
                                         .read_data        ( {read_dcntl,  read_tag,  read_option_type[0],  read_option_value[0],
                                                                                                   read_option_type[1],  read_option_value[1],
                                                                                                   read_option_type[2],  read_option_value[2]}),

                                         // General
                                         .clear            ( clear                                                ),
                                         .reset_poweron    ( reset_poweron                                        ),
                                         .clk              ( clk                                                  )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_dcntl        ;
        reg    [`MGR_STD_OOB_TAG_RANGE          ]            pipe_tag          ;
        reg    [`MGR_WU_OPT_TYPE_RANGE          ]            pipe_option_type  [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        reg    [`MGR_WU_OPT_VALUE_RANGE         ]            pipe_option_value [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        wire                                                 pipe_read         ;


        assign read           = ~empty          & (~fifo_pipe_valid | fifo_pipe_read) ; // keep the pipe charged
        assign fifo_pipe_read = fifo_pipe_valid & (~pipe_valid      | pipe_read     ) ; 

        // If we are reading the fifo, then this stage will be valid
        // If we are not reading the fifo but the next stage is reading this stage, then this stage will not be valid
        always @(posedge clk)
          begin
            fifo_pipe_valid <= ( reset_poweron      ) ? 'b0               :
                               ( read               ) ? 'b1               :
                               ( fifo_pipe_read     ) ? 'b0               :
                                                         fifo_pipe_valid  ;
          end

        always @(posedge clk)
          begin
            // If we are reading the previous stage, then this stage will be valid
            // otherwise if we are reading this stage this stage will not be valid
            pipe_valid      <= ( reset_poweron      ) ? 'b0              :
                               ( fifo_pipe_read     ) ? 'b1              :
                               ( pipe_read          ) ? 'b0              :
                                                         pipe_valid      ;
        
            // if we are reading, transfer from previous pipe stage. 
            pipe_dcntl          <= ( fifo_pipe_read     ) ? read_dcntl           :
                                                            pipe_dcntl           ;
            pipe_tag            <= ( fifo_pipe_read     ) ? read_tag             :
                                                            pipe_tag             ;
            pipe_option_type[0] <= ( fifo_pipe_read     ) ? read_option_type[0]  :
                                                            pipe_option_type[0]  ;
            pipe_option_type[1] <= ( fifo_pipe_read     ) ? read_option_type[1]  :
                                                            pipe_option_type[1]  ;
            pipe_option_type[2] <= ( fifo_pipe_read     ) ? read_option_type[2]  :
                                                            pipe_option_type[2]  ;
            pipe_option_value[0] <= ( fifo_pipe_read    ) ? read_option_value[0] :
                                                            pipe_option_value[0] ;
            pipe_option_value[1] <= ( fifo_pipe_read    ) ? read_option_value[1] :
                                                            pipe_option_value[1] ;
            pipe_option_value[2] <= ( fifo_pipe_read    ) ? read_option_value[2] :
                                                            pipe_option_value[2] ;
          end

        wire   pipe_sod     =  (pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM); 
        wire   pipe_eod     =  (pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM);
        

      end
  endgenerate

  assign   from_wud_valid          =    from_WuDecode_Fifo[0].pipe_valid            ;
  assign   from_wud_sod            =    from_WuDecode_Fifo[0].pipe_sod              ;
  assign   from_wud_eod            =    from_WuDecode_Fifo[0].pipe_eod              ;
  assign   from_wud_dcntl          =    from_WuDecode_Fifo[0].pipe_dcntl            ;
  assign   from_wud_tag            =    from_WuDecode_Fifo[0].pipe_tag              ;
  assign   from_wud_option_type    =    from_WuDecode_Fifo[0].pipe_option_type      ;
  assign   from_wud_option_value   =    from_WuDecode_Fifo[0].pipe_option_value     ;
  assign   from_wud_read           =    from_WuDecode_Fifo[0].pipe_read             ;


  generate
    for (opt=0; opt<`MGR_WU_OPT_PER_INST; opt=opt+1) 
      begin: extd_tuple_decode
        always @(*)
          begin
            isExtdTuple(pipe_option_is_extd_type[opt], from_WuDecode_Fifo[0].read_option_type[opt]);
          end

        if (opt == 0)
         begin
           always @(posedge clk)
             begin
               pipe_option_extd_type        [opt]  <=  ( from_WuDecode_Fifo[0].fifo_pipe_read &&  pipe_option_is_extd_type[opt] ) ? {from_WuDecode_Fifo[0].read_option_type [opt]} :
                                                                                                                                    pipe_option_extd_type        [opt] ;
                                                                                                                               
               pipe_option_extd_value       [opt]  <=  ( from_WuDecode_Fifo[0].fifo_pipe_read &&  pipe_option_is_extd_type[opt] ) ? {from_WuDecode_Fifo[0].read_option_type [opt], from_WuDecode_Fifo[0].read_option_value [opt], from_WuDecode_Fifo[0].read_option_type [opt+1], from_WuDecode_Fifo[0].read_option_value [opt+1]}  : 
                                                                                                                                    pipe_option_extd_value       [opt] ;
                                                                                                                               
               pipe_option_extd_valid       [opt]  <=  ( reset_poweron ) ? 1'b0 :                                              
                                                       ( from_WuDecode_Fifo[0].fifo_pipe_read &&  pipe_option_is_extd_type[opt] ) ? 1'b1                               :
                                                                                                                                    pipe_option_extd_valid             [opt] ;
             end
         end
        else if (opt == 1)
         begin
           always @(posedge clk)
             begin
               pipe_option_extd_type        [opt]  <=  ( from_WuDecode_Fifo[0].fifo_pipe_read && ~pipe_option_is_extd_type[opt-1] && pipe_option_is_extd_type[opt]) ? {from_WuDecode_Fifo[0].read_option_type [opt]} :
                                                                                                                                                                      pipe_option_extd_type        [opt]  ;
                                                                                                                                                                  
               pipe_option_extd_value       [opt]  <=  ( from_WuDecode_Fifo[0].fifo_pipe_read && ~pipe_option_is_extd_type[opt-1] && pipe_option_is_extd_type[opt]) ? {from_WuDecode_Fifo[0].read_option_type [opt], from_WuDecode_Fifo[0].read_option_value [opt], from_WuDecode_Fifo[0].read_option_type [opt+1], from_WuDecode_Fifo[0].read_option_value [opt+1]}  : 
                                                                                                                                                                      pipe_option_extd_value       [opt]  ;
                                                                                                                                                                  
               pipe_option_extd_valid       [opt]  <=  ( reset_poweron ) ? 1'b0 :     
                                                       ( from_WuDecode_Fifo[0].fifo_pipe_read && ~pipe_option_is_extd_type[opt-1] && pipe_option_is_extd_type[opt]) ? 1'b1                               :
                                                                                                                                                                      pipe_option_extd_valid             [opt] ;
             end
         end
        else 
         begin
           always @(posedge clk)
             begin
               pipe_option_extd_valid       [opt]  <=  'b0  ;
               pipe_option_extd_type        [opt]  <=  'd0  ;
               pipe_option_extd_value       [opt]  <=  'd0  ;
             end
         end
      always @(posedge clk)
        begin
           mode_reg_valid    [opt]  <=  pipe_option_extd_valid       [opt]                                         ;
           mode_reg_type     [opt]  <=  pipe_option_extd_type        [opt]                                         ;
           mode_reg_id       [opt]  <=  pipe_option_extd_value       [opt][`MGR_WU_EXTD_TUPLE_MODE_REG_ID_RANGE  ] ;
           mode_reg_value    [opt]  <=  pipe_option_extd_value       [opt][`MGR_WU_EXTD_TUPLE_MODE_REG_VAL_RANGE ] ;
        end
      end
  endgenerate

  always @(posedge clk)
    begin
      cfg_data_mode_reg_valid <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                                                     )  ?  1'b0                                                               :
                                 ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_CFG_DATA ))  ?  1'b1                                                               :
                                 ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_CFG_DATA ))  ?  1'b1                                                               :
                                 ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_CFG_DATA ))  ?  1'b1                                                               :
                                                                                                                                                                                        cfg_data_mode_reg_valid                                            ;

      cfg_data_mode_reg_type  <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                 )  ?   'd0                      :
                                 ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_type [0] :
                                 ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_type [1] :
                                 ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_type [2] :
                                                                                                                                                    cfg_data_mode_reg_type    ;

      cfg_data_mode_reg_id    <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                                                     )  ?   'd0                                                               :
                                 ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_CFG_DATA ))  ?  pipe_option_extd_value [0][`MGR_WU_EXTD_TUPLE_MODE_REG_ID_RANGE  ] :
                                 ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_CFG_DATA ))  ?  pipe_option_extd_value [1][`MGR_WU_EXTD_TUPLE_MODE_REG_ID_RANGE  ] :
                                 ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_CFG_DATA ))  ?  pipe_option_extd_value [2][`MGR_WU_EXTD_TUPLE_MODE_REG_ID_RANGE  ] :
                                                                                                                                                                                        cfg_data_mode_reg_id                                               ;
      cfg_data_mode_reg_value <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                                                     )  ?   'd0                                                               :
                                 ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_CFG_DATA ))  ?  pipe_option_extd_value [0][`MGR_WU_EXTD_TUPLE_MODE_REG_VAL_RANGE ] :
                                 ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_CFG_DATA ))  ?  pipe_option_extd_value [1][`MGR_WU_EXTD_TUPLE_MODE_REG_VAL_RANGE ] :
                                 ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_CFG_DATA ))  ?  pipe_option_extd_value [2][`MGR_WU_EXTD_TUPLE_MODE_REG_VAL_RANGE ] :
                                                                                                                                                                                        cfg_data_mode_reg_value                                            ;
    end


  always @(posedge clk)
    begin
      cfg_sync_mode_reg_valid <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                                                     )  ?  1'b0                                                               :
                                 ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  1'b1                                                               :
                                 ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  1'b1                                                               :
                                 ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  1'b1                                                               :
                                                                                                                                                                                        cfg_sync_mode_reg_valid                                            ;

      cfg_sync_mode_reg_type  <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                 )  ?   'd0                      :
                                 ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_type [0] :
                                 ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_type [1] :
                                 ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_type [2] :
                                                                                                                                                    cfg_sync_mode_reg_type    ;

      cfg_sync_mode_reg_id    <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                                                     )  ?   'd0                                                               :
                                 ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_value [0][`MGR_WU_EXTD_TUPLE_MODE_REG_ID_RANGE  ] :
                                 ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_value [1][`MGR_WU_EXTD_TUPLE_MODE_REG_ID_RANGE  ] :
                                 ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_value [2][`MGR_WU_EXTD_TUPLE_MODE_REG_ID_RANGE  ] :
                                                                                                                                                                                        cfg_sync_mode_reg_id                                               ;
      cfg_sync_mode_reg_value <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                                                     )  ?   'd0                                                               :
                                 ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_value [0][`MGR_WU_EXTD_TUPLE_MODE_REG_VAL_RANGE ] :
                                 ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_value [1][`MGR_WU_EXTD_TUPLE_MODE_REG_VAL_RANGE ] :
                                 ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_CFG_SYNC ))  ?  pipe_option_extd_value [2][`MGR_WU_EXTD_TUPLE_MODE_REG_VAL_RANGE ] :
                                                                                                                                                                                        cfg_sync_mode_reg_value                                            ;
    end

  always @(posedge clk)
    begin
      cfg_storage_desc_ptr_valid  <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                                                   )  ?  1'b0                       :
                                     ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_MEMORY ))  ?  1'b1                       :
                                     ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_MEMORY ))  ?  1'b1                       :
                                     ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_MEMORY ))  ?  1'b1                       :
                                                                                                                                                                                          cfg_storage_desc_ptr_valid ;

      cfg_storage_desc_ptr_type   <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                                                   )  ?   'd0                       :
                                     ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_MEMORY ))  ?  pipe_option_extd_type  [0] :
                                     ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_MEMORY ))  ?  pipe_option_extd_type  [1] :
                                     ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_MEMORY ))  ?  pipe_option_extd_type  [2] :
                                                                                                                                                                                          cfg_storage_desc_ptr_type  ;

      cfg_storage_desc_ptr_value  <= ( mgr_cntl_main_state == `MGR_CNTL_MAIN_WAIT                                                                                                   )  ?   'd0                       :
                                     ((process_wud) && pipe_option_extd_valid [0] && (pipe_option_extd_type[0] == `MGR_INST_OPTION_TYPE_MEMORY ))  ?  pipe_option_extd_value [0] :
                                     ((process_wud) && pipe_option_extd_valid [1] && (pipe_option_extd_type[1] == `MGR_INST_OPTION_TYPE_MEMORY ))  ?  pipe_option_extd_value [1] :
                                     ((process_wud) && pipe_option_extd_valid [2] && (pipe_option_extd_type[2] == `MGR_INST_OPTION_TYPE_MEMORY ))  ?  pipe_option_extd_value [2] :
                                                                                                                                                                                          cfg_storage_desc_ptr_value ;
    end

  always @(posedge clk)
    begin
      cfg_tag  <= (mgr_cntl_main_state == `MGR_CNTL_MAIN_START_WUD ) ?  wud__mcntl__tag_d1 :
                                                                        cfg_tag            ;
    end



  assign from_WuDecode_Fifo[0].clear   =   1'b0                ;
  assign from_WuDecode_Fifo[0].write   =   wud__mcntl__valid_d1  ;
  always @(*)
    begin
      from_WuDecode_Fifo[0].write_dcntl    =   wud__mcntl__dcntl_d1   ;
      from_WuDecode_Fifo[0].write_tag      =   wud__mcntl__tag_d1     ;
      for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
        begin: option_in
          from_WuDecode_Fifo[0].write_option_type  [opt]   =   wud__mcntl__option_type_d1  [opt]  ;
          from_WuDecode_Fifo[0].write_option_value [opt]   =   wud__mcntl__option_value_d1 [opt]  ;
        end
    end
         
  assign start_of_wu_descriptor          = from_WuDecode_Fifo[0].pipe_valid & (from_WuDecode_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM) ;
  assign middle_of_wu_descriptor         = from_WuDecode_Fifo[0].pipe_valid & (from_WuDecode_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM) ;
  assign end_of_wu_descriptor            = from_WuDecode_Fifo[0].pipe_valid & (from_WuDecode_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM) ;
  assign mcntl__wud__ready_e1            = ~from_WuDecode_Fifo[0].almost_full  ;


  assign from_WuDecode_Fifo[0].pipe_read   =   (mgr_cntl_main_state == `MGR_CNTL_MAIN_PROCESS_WUD ) | (mgr_cntl_main_state == `MGR_CNTL_MAIN_COMPLETE_WUD );

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // NoC FIFO
  // - from NoC
  // 
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  genvar intf ;
  generate
    for (intf=0; intf<1 ; intf=intf+1) 
      begin: from_noc_fifo


        wire  clear        ;
        wire  almost_full  ;

        // Write 
        wire                                                  write        ;
        reg  [`MGR_CNTL_FROM_NOC_AGGREGATE_FIFO_RANGE ]       write_data   ;

        // Write 
        wire                                                  pipe_read             ;
        wire                                                  pipe_valid            ;
        wire  [`MGR_CNTL_FROM_NOC_AGGREGATE_FIFO_RANGE ]      pipe_data             ;
        wire                                                  pipe_peek_valid       ;
        wire  [`MGR_CNTL_FROM_NOC_AGGREGATE_FIFO_RANGE ]      pipe_peek_data        ;
        wire                                                  pipe_peek_twoIn_valid ;
        wire  [`MGR_CNTL_FROM_NOC_AGGREGATE_FIFO_RANGE ]      pipe_peek_twoIn_data  ;

        generic_pipelined_w_peek_fifo #(.GENERIC_FIFO_DEPTH      (`MGR_CNTL_FROM_NOC_FIFO_DEPTH                 ),
                                        .GENERIC_FIFO_THRESHOLD  (`MGR_CNTL_FROM_NOC_FIFO_ALMOST_FULL_THRESHOLD ),
                                        .GENERIC_FIFO_DATA_WIDTH (`MGR_CNTL_FROM_NOC_AGGREGATE_FIFO_WIDTH       )
                                       ) gpfifo (
                                 // Status
                                .almost_full           ( almost_full           ),
                                 // Write                                      
                                .write                 ( write                 ),
                                .write_data            ( write_data            ),
                                 // Read                                  
                                 // Read                                  
                                .pipe_peek_valid       ( pipe_peek_valid       ),
                                .pipe_peek_data        ( pipe_peek_data        ),
                                .pipe_peek_twoIn_valid ( pipe_peek_twoIn_valid ),
                                .pipe_peek_twoIn_data  ( pipe_peek_twoIn_data  ),
                                .pipe_valid            ( pipe_valid            ),
                                .pipe_data             ( pipe_data             ),
                                .pipe_read             ( pipe_read             ),

                                // General
                                .clear                 ( clear                 ),
                                .reset_poweron         ( reset_poweron         ),
                                .clk                   ( clk                   )
                                );

        assign clear = 1'b0 ;
     
        //----------------------------------------------------------------------------------------------------
        // Write data fields assigned to interface outside generate

        //----------------------------------------------------------------------------------------------------
        // Extract read data
        //  - pipeline so we can parse the option tuple cycle
        reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     pipe_peek_twoIn_cntl        ,  pipe_peek_cntl        ,  pipe_cntl        ; 
        reg  [`MGR_ARRAY_HOST_ID_RANGE              ]     pipe_peek_twoIn_srcId       ,  pipe_peek_srcId       ,  pipe_srcId       ; 
        reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     pipe_peek_twoIn_type        ,  pipe_peek_type        ,  pipe_type        ; 
        reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     pipe_peek_twoIn_ptype       ,  pipe_peek_ptype       ,  pipe_ptype       ; 
        reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     pipe_peek_twoIn_mem_data    ,  pipe_peek_mem_data    ,  pipe_mem_data    ; 
        reg                                               pipe_peek_twoIn_pvalid      ,  pipe_peek_pvalid      ,  pipe_pvalid      ; 


        assign {pipe_cntl           , pipe_srcId           , pipe_type           , pipe_ptype           , pipe_pvalid           , pipe_mem_data           } = pipe_data ;
        assign {pipe_peek_cntl      , pipe_peek_srcId      , pipe_peek_type      , pipe_peek_ptype      , pipe_peek_pvalid      , pipe_peek_mem_data      } = pipe_peek_data ;
        assign {pipe_peek_twoIn_cntl, pipe_peek_twoIn_srcId, pipe_peek_twoIn_type, pipe_peek_twoIn_ptype, pipe_peek_twoIn_pvalid, pipe_peek_twoIn_mem_data} = pipe_peek_twoIn_data ;
        //----------------------------------------------------------------------------------------------------
        //

        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ); 
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM);
        

      
      end
  endgenerate

  assign  from_noc_peek_valid    =   from_noc_fifo[0].pipe_peek_valid       ;
  assign  from_noc_peek_cntl     =   from_noc_fifo[0].pipe_peek_cntl        ;
  assign  from_noc_peek_srcId    =   from_noc_fifo[0].pipe_peek_srcId       ;
  assign  from_noc_peek_type     =   from_noc_fifo[0].pipe_peek_type        ;
  assign  from_noc_peek_ptype    =   from_noc_fifo[0].pipe_peek_ptype       ;
  assign  from_noc_peek_data     =   from_noc_fifo[0].pipe_peek_mem_data    ;
  assign  from_noc_peek_pvalid   =   from_noc_fifo[0].pipe_peek_pvalid      ;
  
  assign  from_noc_read          =   from_noc_fifo[0].pipe_read             ;
  assign  from_noc_valid         =   from_noc_fifo[0].pipe_valid            ;
  assign  from_noc_cntl          =   from_noc_fifo[0].pipe_cntl             ;
  assign  from_noc_srcId         =   from_noc_fifo[0].pipe_srcId            ;
  assign  from_noc_type          =   from_noc_fifo[0].pipe_type             ;
  assign  from_noc_ptype         =   from_noc_fifo[0].pipe_ptype            ;
  assign  from_noc_data          =   from_noc_fifo[0].pipe_mem_data         ;
  assign  from_noc_pvalid        =   from_noc_fifo[0].pipe_pvalid           ;

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Connect inputs from rdp and mcntl to intf_fifos 

  //----------------------------------------------------------------------------------------------------
  // Write data fields
  assign from_noc_fifo[0].write       =  noc__mcntl__dp_valid_d1 ;
  assign from_noc_fifo[0].write_data  = {noc__mcntl__dp_cntl_d1, noc__mcntl__dp_mgrId_d1, noc__mcntl__dp_type_d1, noc__mcntl__dp_ptype_d1, noc__mcntl__dp_pvalid_d1, noc__mcntl__dp_data_d1};
  always @(*)
    begin
      mcntl__noc__dp_ready_e1    = ~from_noc_fifo[0].almost_full ;
    end

  wire noc_to_mwc = ((mgr_cntl_noc_cntl_state == `MGR_CNTL_NOC_CNTL_WAIT     ) & from_noc_valid & (from_noc_peek_valid && (from_noc_peek_type == `MGR_NOC_CONT_TYPE_DESC_WRITE_DATA))) | 
                    ((mgr_cntl_noc_cntl_state == `MGR_CNTL_NOC_CNTL_MWC_RCV  ) & from_noc_valid) ;

  wire noc_to_wum = ((mgr_cntl_noc_cntl_state == `MGR_CNTL_NOC_CNTL_DNLD_INST) & from_noc_valid) ;

  assign from_noc_fifo[0].pipe_read   =  mwc__mcntl__ready_d1 & noc_to_mwc |
                                         wum__mcntl__ready_d1 & noc_to_wum ;


  // end of input fifos
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  always @(*)
    begin
      mcntl__mwc__valid_e1     =   from_noc_read & noc_to_mwc                                   ;
      mcntl__mwc__cntl_e1      =   from_noc_cntl                                                ;
      mcntl__mwc__type_e1      =   from_noc_type                                                ;
      mcntl__mwc__ptype_e1     =   from_noc_ptype                                               ;
      mcntl__mwc__data_e1      =   from_noc_data                                                ;
      mcntl__mwc__pvalid_e1    =   from_noc_pvalid                                              ;
      mcntl__mwc__mgrId_e1     =   from_noc_srcId  [`MGR_MGR_ID_RANGE ]                         ;

    end


  //------------------------------------------------------------------------------------------------------------------------
  // Temporary - FIXME
  // control path not currently used
  assign      mcntl__noc__cp_valid_e1      = 'd0     ; 
  assign      mcntl__noc__cp_cntl_e1       = 'd0     ;   
  assign      mcntl__noc__cp_type_e1       = 'd0     ;   
  assign      mcntl__noc__cp_desttype_e1   = 'd0     ;   
  assign      mcntl__noc__cp_ptype_e1      = 'd0     ;   
  assign      mcntl__noc__cp_pvalid_e1     = 'd0     ;   
  assign      mcntl__noc__cp_data_e1       = 'd0     ;   


  //------------------------------------------------------------
  // RDP to NoC FIFO
  //

  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_rdp_fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE          ]    write_cntl       ;
        reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    write_type       ; 
        reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    write_ptype      ; 
        reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    write_desttype   ; 
        reg                                               write_pvalid     ; 
        reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    write_data       ; 

        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE          ]    pipe_cntl        ;
        wire   [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    pipe_type        ; 
        wire   [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    pipe_ptype       ; 
        wire   [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    pipe_desttype    ; 
        wire                                              pipe_pvalid      ; 
        wire   [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    pipe_data        ; 

        // Control
        wire                                              clear            ; 
        wire                                              almost_full      ; 
        wire                                              pipe_read        ; 
        wire                                              write            ; 
 
        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH                 ), 
                                 .GENERIC_FIFO_THRESHOLD  (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_NOC_CONT_NOC_PACKET_TYPE_WIDTH+`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_WIDTH+`MGR_NOC_CONT_NOC_DEST_TYPE_WIDTH+1+`MGR_NOC_CONT_INTERNAL_DATA_WIDTH)
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ( {write_cntl, write_type, write_ptype, write_desttype, write_pvalid, write_data}),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid                 ),
                                .pipe_data        ( { pipe_cntl,  pipe_type,  pipe_ptype,  pipe_desttype,  pipe_pvalid,  pipe_data}),
                                .pipe_read        ( pipe_read                  ),

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

        assign clear   =   1'b0                ;

      end
  endgenerate

  //--------------------------------------------------
  // Connect RDP fifo to ports

  assign from_rdp_fifo[0].write         =   rdp__mcntl__noc_valid_d1  ;
  assign from_rdp_fifo[0].pipe_read     =   from_rdp_fifo[0].pipe_valid & noc__mcntl__dp_ready_d1 ;
  always @(*)
    begin
      from_rdp_fifo[0].write_cntl       =   rdp__mcntl__noc_cntl_d1     ;
      from_rdp_fifo[0].write_type       =   rdp__mcntl__noc_type_d1     ;
      from_rdp_fifo[0].write_ptype      =   rdp__mcntl__noc_ptype_d1    ;
      from_rdp_fifo[0].write_desttype   =   rdp__mcntl__noc_desttype_d1 ;
      from_rdp_fifo[0].write_pvalid     =   rdp__mcntl__noc_pvalid_d1   ;
      from_rdp_fifo[0].write_data       =   rdp__mcntl__noc_data_d1     ;
    end
         
  assign mcntl__rdp__noc_ready_p1              = ~from_rdp_fifo[0].almost_full  ;

  /*
  always @(*)
    begin
      mcntl__noc__dp_valid_e1      =   from_rdp_fifo[0].pipe_read      ;
      mcntl__noc__dp_cntl_e1       =   from_rdp_fifo[0].pipe_cntl      ;
      mcntl__noc__dp_type_e1       =   from_rdp_fifo[0].pipe_type      ;
      mcntl__noc__dp_ptype_e1      =   from_rdp_fifo[0].pipe_ptype     ;
      mcntl__noc__dp_desttype_e1   =   from_rdp_fifo[0].pipe_desttype  ;
      mcntl__noc__dp_pvalid_e1     =   from_rdp_fifo[0].pipe_pvalid    ;
      mcntl__noc__dp_data_e1       =   from_rdp_fifo[0].pipe_data      ;
    end
  */

  //------------------------------------------------------------
  // Aggregate to NoC FIFO
  //

  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: to_noc_fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE          ]    write_cntl       ;
        reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    write_type       ; 
        reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    write_ptype      ; 
        reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    write_desttype   ; 
        reg                                               write_pvalid     ; 
        reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    write_data       ; 

        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE          ]    pipe_cntl        ;
        wire   [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    pipe_type        ; 
        wire   [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    pipe_ptype       ; 
        wire   [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    pipe_desttype    ; 
        wire                                              pipe_pvalid      ; 
        wire   [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    pipe_data        ; 

        // Control
        wire                                              clear            ; 
        wire                                              almost_full      ; 
        wire                                              pipe_read        ; 
        wire                                              write            ; 
 
        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH                 ), 
                                 .GENERIC_FIFO_THRESHOLD  (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_NOC_CONT_NOC_PACKET_TYPE_WIDTH+`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_WIDTH+`MGR_NOC_CONT_NOC_DEST_TYPE_WIDTH+1+`MGR_NOC_CONT_INTERNAL_DATA_WIDTH)
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ( {write_cntl, write_type, write_ptype, write_desttype, write_pvalid, write_data}),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid                 ),
                                .pipe_data        ( { pipe_cntl,  pipe_type,  pipe_ptype,  pipe_desttype,  pipe_pvalid,  pipe_data}),
                                .pipe_read        ( pipe_read                  ),

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

        assign clear   =   1'b0                ;

      end
  endgenerate

  //--------------------------------------------------
  // Connect to NoC fifo to ports

  assign to_noc_fifo[0].write         =   ( processing_config_upld_d1  ) ? config_upld_fifo_write                                     :
                                          ( processing_sync_to_host_d1 ) ? config_sync_fifo_write                                     :
                                                                           from_rdp_fifo[0].pipe_valid & ~to_noc_fifo[0].almost_full  ;
                                                                      

  assign to_noc_fifo[0].pipe_read     =   to_noc_fifo[0].pipe_valid & noc__mcntl__dp_ready_d1 ;

  always @(*)
    begin
      to_noc_almost_full       =   to_noc_fifo[0].almost_full ;
      if (processing_config_upld_d1 | processing_sync_to_host_d1 )
        begin
          to_noc_fifo[0].write_cntl       =   config_to_noc_cntl         ;
          to_noc_fifo[0].write_type       =   config_to_noc_type         ;
          to_noc_fifo[0].write_ptype      =   config_to_noc_ptype        ;
          to_noc_fifo[0].write_desttype   =   config_to_noc_desttype     ;
          to_noc_fifo[0].write_pvalid     =   config_to_noc_pvalid       ;
          to_noc_fifo[0].write_data       =   config_to_noc_data         ;
        end
      else
        begin
          to_noc_fifo[0].write_cntl       =   from_rdp_fifo[0].pipe_cntl      ;
          to_noc_fifo[0].write_type       =   from_rdp_fifo[0].pipe_type      ;
          to_noc_fifo[0].write_ptype      =   from_rdp_fifo[0].pipe_ptype     ;
          to_noc_fifo[0].write_desttype   =   from_rdp_fifo[0].pipe_desttype  ;
          to_noc_fifo[0].write_pvalid     =   from_rdp_fifo[0].pipe_pvalid    ;
          to_noc_fifo[0].write_data       =   from_rdp_fifo[0].pipe_data      ;
        end
    end
         
  always @(*)
    begin
      mcntl__noc__dp_valid_e1      =   to_noc_fifo[0].pipe_read      ;
      mcntl__noc__dp_cntl_e1       =   to_noc_fifo[0].pipe_cntl      ;
      mcntl__noc__dp_type_e1       =   to_noc_fifo[0].pipe_type      ;
      mcntl__noc__dp_ptype_e1      =   to_noc_fifo[0].pipe_ptype     ;
      mcntl__noc__dp_desttype_e1   =   to_noc_fifo[0].pipe_desttype  ;
      mcntl__noc__dp_pvalid_e1     =   to_noc_fifo[0].pipe_pvalid    ;
      mcntl__noc__dp_data_e1       =   to_noc_fifo[0].pipe_data      ;
    end


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // DMA data from memory read
  // - use same fifo as streaming op

  generate
    for (gvi=0; gvi<`MGR_CNTL_NUM_OF_DMA_LANES; gvi=gvi+1) 
      begin: from_mrc_fifo

        wire    [`COMMON_STD_INTF_CNTL_RANGE   ]    write_cntl       ;
        wire    [`STREAMING_OP_DATA_RANGE      ]    write_data       ; 
        wire                                        write            ; 

        // Read data                                                       
        wire                                       pipe_valid       ; 
        wire                                       pipe_read        ; 
        wire   [`COMMON_STD_INTF_CNTL_RANGE   ]    pipe_cntl        ;
        wire   [`STREAMING_OP_DATA_RANGE      ]    pipe_data        ; 

        // Control
        wire                                       almost_full      ; 

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`STREAMING_OP_INPUT_FIFO_DEPTH                      ), 
                                 .GENERIC_FIFO_THRESHOLD  (`STREAMING_OP_INPUT_FIFO_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ( {write_cntl, write_data}),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid                 ),
                                .pipe_data        ( { pipe_cntl,  pipe_data}),
                                .pipe_read        ( pipe_read                  ),

                                // General
                                .clear            ( 1'b0                  ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );
        wire  pipe_som  = (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM) || (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)  ;
        wire  pipe_mom  = (pipe_cntl == `COMMON_STD_INTF_CNTL_MOM)                              ;
        wire  pipe_eom  = (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM) || (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)  ;
      end
  endgenerate
  
  generate
    for (gvi=0; gvi<`MGR_CNTL_NUM_OF_DMA_LANES; gvi=gvi+1) 
      begin: drive_from_mrc_fifo
        assign from_mrc_fifo[gvi].write         =  mrc__mcntl__lane_valid_d1 [gvi]  ;
        assign from_mrc_fifo[gvi].write_cntl    =  mrc__mcntl__lane_cntl_d1  [gvi]  ;
        assign from_mrc_fifo[gvi].write_data    =  mrc__mcntl__lane_data_d1  [gvi]  ;

        assign mcntl__mrc__lane_ready_e1 [gvi]  = ~from_mrc_fifo[gvi].almost_full ;

        assign from_mrc_fifo[gvi].pipe_read   =  from_mrc_fifo[gvi].pipe_valid ;  // FIXME
      end
  endgenerate

  generate
    for (gvi=0; gvi<`MGR_CNTL_NUM_OF_DMA_LANES; gvi=gvi+1) 
      begin: from_mrc_assignments
        assign   from_mrc_valid        [gvi]  = from_mrc_fifo[gvi].pipe_valid   ;
        assign   from_mrc_som          [gvi]  = from_mrc_fifo[gvi].pipe_som     ;
        assign   from_mrc_mom          [gvi]  = from_mrc_fifo[gvi].pipe_mom     ;
        assign   from_mrc_eom          [gvi]  = from_mrc_fifo[gvi].pipe_eom     ;
        assign   from_mrc_cntl         [gvi]  = from_mrc_fifo[gvi].pipe_cntl    ;
        assign   from_mrc_data         [gvi]  = from_mrc_fifo[gvi].pipe_data    ;

        assign   from_mrc_fifo[gvi].pipe_read =  from_mrc_read     [gvi]    ;
      end
  endgenerate

  
endmodule
