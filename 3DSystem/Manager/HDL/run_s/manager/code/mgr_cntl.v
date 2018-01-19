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
`include "pe_array.vh"
`include "pe.vh"
`include "wu_memory.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "mgr_noc_cntl.vh"
`include "mgr_cntl.vh"
`include "python_typedef.vh"


module mgr_cntl (  

            //-------------------------------------------------------------------------------------------------
            // Configuration
            //
            output  reg  [`MGR_WU_ADDRESS_RANGE           ]    mcntl__wuf__start_addr           ,  // first WU address
            output  reg                                        mcntl__wuf__enable               ,
            output  reg                                        xxx__wuf__stall                  ,

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
   

  reg                                         wud__mcntl__valid_d1                                  ;
  wire                                        mcntl__wud__ready_e1                                  ;
  reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mcntl__dcntl_d1                                  ;  
  reg    [`MGR_STD_OOB_TAG_RANGE         ]    wud__mcntl__tag_d1                                    ;
  reg    [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mcntl__option_type_d1    [`MGR_WU_OPT_PER_INST ] ;
  reg    [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mcntl__option_value_d1   [`MGR_WU_OPT_PER_INST ] ;

  wire                                        start_of_wu_descriptor                                ;  // dcntl == SOM
  wire                                        middle_of_wu_descriptor                               ;  // dcntl == MOM
  wire                                        end_of_wu_descriptor                                  ;  // dcntl == EOM

  reg      [`MGR_WU_EXTD_TUPLE_RANGE     ]    extended_tuple                                        ; // temporary store tuple[0,1] as extended

  reg      [`MGR_WU_CONFIG_MODE_REG_ID_RANGE  ]    mode_reg_id                                       ;
  reg      [`MGR_WU_CONFIG_MODE_REG_VAL_RANGE ]    mode_reg_value                                    ;

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

  wire                                              from_noc_valid      ; 
  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     from_noc_cntl       ; 
  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     from_noc_type       ; 
  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     from_noc_ptype      ; 
  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     from_noc_data       ; 
  wire                                              from_noc_pvalid     ; 
  wire [`MGR_ARRAY_HOST_ID_RANGE              ]     from_noc_srcId      ; 
  wire                                              from_noc_read       ; 
      
  // State register 
  reg [`MGR_CNTL_MAIN_STATE_RANGE ] mgr_cntl_main_state      ; // state flop
  reg [`MGR_CNTL_MAIN_STATE_RANGE ] mgr_cntl_main_state_next ;

  always @(posedge clk)
    begin
      mgr_cntl_main_state <= ( reset_poweron ) ? `MGR_CNTL_MAIN_INIT        :
                                                 mgr_cntl_main_state_next  ;
    end

  always @(*)
    begin
      case (mgr_cntl_main_state)
        
        // first we need to download instructions
        `MGR_CNTL_MAIN_INIT: 
          //mgr_cntl_main_state_next =   `MGR_CNTL_MAIN_RUN ;
          mgr_cntl_main_state_next =   (sys__mgr__mgrId == `MGR_WU_MEMORY_INIT_ID ) ? `MGR_CNTL_MAIN_DNLD_INST : `MGR_CNTL_MAIN_RUN ; // FIXME

        `MGR_CNTL_MAIN_DNLD_INST: 
          mgr_cntl_main_state_next =  ( wum_address == `MGR_WU_MEMORY_INIT_ENTRIES       ) ? `MGR_CNTL_MAIN_DNLD_INST_COMPLETE :
                                                                                             `MGR_CNTL_MAIN_DNLD_INST          ;

        `MGR_CNTL_MAIN_DNLD_INST_COMPLETE: 
          mgr_cntl_main_state_next =    `MGR_CNTL_MAIN_RUN          ;
                                                                                                                         
        `MGR_CNTL_MAIN_RUN: 
          mgr_cntl_main_state_next =  
                                      ( from_noc_valid  && (from_noc_cntl == `COMMON_STD_INTF_CNTL_SOM) && (from_noc_srcId == {1'b0, sys__mgr__mgrId})) ? `MGR_CNTL_MAIN_ERR      : // from same SSC??
                                      ( from_noc_valid  && (from_noc_cntl != `COMMON_STD_INTF_CNTL_SOM)                                               ) ? `MGR_CNTL_MAIN_ERR      : // first isnt SOM??
                                      ( from_noc_valid  && (from_noc_cntl == `COMMON_STD_INTF_CNTL_SOM)                                               ) ? `MGR_CNTL_MAIN_RCV      : 
                                                                                                                                                          `MGR_CNTL_MAIN_RUN     ;
  
        `MGR_CNTL_MAIN_RCV: 
          mgr_cntl_main_state_next =  
                                      ( from_noc_valid  && (from_noc_cntl == `COMMON_STD_INTF_CNTL_EOM)) ? `MGR_CNTL_MAIN_RUN      : 
                                                                                                           `MGR_CNTL_MAIN_RCV       ;
  

        `MGR_CNTL_MAIN_COMPLETE: 
          mgr_cntl_main_state_next =   `MGR_CNTL_MAIN_RUN ;


        `MGR_CNTL_MAIN_ERR: 
          mgr_cntl_main_state_next =   `MGR_CNTL_MAIN_ERR ;


        default:
          mgr_cntl_main_state_next =   `MGR_CNTL_MAIN_RUN     ; 

      endcase // case (mgr_cntl_main_state)
    end // always @ (*)


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // FSM assignments
      
  always @(posedge clk) 
    begin
      case (mgr_cntl_main_state)  // parallel_case

        `MGR_CNTL_MAIN_INIT :
          begin
            wum_address <= 'd0 ;
          end

        `MGR_CNTL_MAIN_DNLD_INST :
          begin
            // its valid if reading
            wum_address <= ( from_noc_read && (from_noc_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_DATA)   ) ? wum_address + 'd1 : wum_address ;
          end

        default:
          begin
            wum_address <= wum_address ;
          end

      endcase
    end

  always @(*)
    begin
      case (mgr_cntl_main_state)  // parallel_case

        `MGR_CNTL_MAIN_INIT :
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
        `MGR_CNTL_MAIN_DNLD_INST :
          begin
            mcntl__wum__enable_inst_dnld_e1    = 'd1 ;

            mcntl__wum__address_e1             = wum_address ;
            mcntl__wum__valid_e1               = from_noc_read & (from_noc_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_DATA) ;
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
      mcntl__wuf__enable      <= (reset_poweron                            ) ? 1'b0               :
                                 (mgr_cntl_main_state == `MGR_CNTL_MAIN_RUN) ? 1'b1               : 
                                                                               mcntl__wuf__enable ;
      xxx__wuf__stall         <= 1'b0    ;
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
  //   - Storage descriptor
  //

  genvar gvi;
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

      end
  endgenerate


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

  always @(*)
    begin
       extended_tuple = {from_WuDecode_Fifo[0].write_option_type [0], from_WuDecode_Fifo[0].write_option_value [0], from_WuDecode_Fifo[0].write_option_type [1], from_WuDecode_Fifo[0].write_option_value [1]};
       
       mode_reg_value  =  extended_tuple [`MGR_WU_EXTD_TUPLE_MODE_REG_VAL_RANGE ] ;
       mode_reg_id     =  extended_tuple [`MGR_WU_EXTD_TUPLE_MODE_REG_ID_RANGE  ] ;
    end

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
        wire                                                  pipe_valid   ;
        reg                                                   pipe_read    ;
        reg  [`MGR_CNTL_FROM_NOC_AGGREGATE_FIFO_RANGE ]       pipe_data    ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MGR_CNTL_FROM_NOC_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MGR_CNTL_FROM_NOC_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MGR_CNTL_FROM_NOC_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ( write_data            ),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid            ),
                                .pipe_data        ( pipe_data             ),
                                .pipe_read        ( pipe_read             ),

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

        assign clear = 1'b0 ;
     
        //----------------------------------------------------------------------------------------------------
        // Write data fields assigned to interface outside generate

        //----------------------------------------------------------------------------------------------------
        // Extract read data
        wire [`COMMON_STD_INTF_CNTL_RANGE           ]     pipe_cntl        ; 
        wire [`MGR_ARRAY_HOST_ID_RANGE              ]     pipe_srcId       ; 
        wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     pipe_type        ; 
        wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     pipe_ptype       ; 
        wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     pipe_mem_data    ; 
        wire                                              pipe_pvalid      ; 

        assign {pipe_cntl, pipe_srcId, pipe_type, pipe_ptype, pipe_pvalid, pipe_mem_data} = pipe_data ;
        //----------------------------------------------------------------------------------------------------

        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ); 
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM);

        assign  from_noc_read     =   pipe_read        ;
        assign  from_noc_valid    =   pipe_valid       ;
        assign  from_noc_cntl     =   pipe_cntl        ;
        assign  from_noc_srcId    =   pipe_srcId       ;
        assign  from_noc_type     =   pipe_type        ;
        assign  from_noc_ptype    =   pipe_ptype       ;
        assign  from_noc_data     =   pipe_mem_data    ;
        assign  from_noc_pvalid   =   pipe_pvalid      ;
      
      end
  endgenerate

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


  assign from_noc_fifo[0].pipe_read       =  mwc__mcntl__ready_d1 & from_noc_fifo[0].pipe_valid ;


  // end of input fifos
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  always @(*)
    begin
      mcntl__mwc__valid_e1     =   from_noc_valid & from_noc_read & (mgr_cntl_main_state != `MGR_CNTL_MAIN_ERR) & (from_noc_srcId != `MGR_ARRAY_HOST_ID)       ;  // FIXME
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

  //--------------------------------------------------
  // 
  //  FIXME - pass thru
  //
  /*
  always @(*)
    begin
      mcntl__mwc__valid_e1     =   noc__mcntl__dp_valid_d1 & (mgr_cntl_main_state != `MGR_CNTL_MAIN_ERR) ;
      mcntl__mwc__cntl_e1      =   noc__mcntl__dp_cntl_d1     ;
      mcntl__mwc__type_e1      =   noc__mcntl__dp_type_d1     ;
      mcntl__mwc__ptype_e1     =   noc__mcntl__dp_ptype_d1    ;
      mcntl__mwc__data_e1      =   noc__mcntl__dp_data_d1     ;
      mcntl__mwc__pvalid_e1    =   noc__mcntl__dp_pvalid_d1   ;
      mcntl__mwc__mgrId_e1     =   noc__mcntl__dp_mgrId_d1    ;
      mcntl__noc__dp_ready_e1  =   mwc__mcntl__ready_d1       ;
    end
  */

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

  assign to_noc_fifo[0].write         =   from_rdp_fifo[0].pipe_valid & ~to_noc_fifo[0].almost_full  ;
  assign to_noc_fifo[0].pipe_read     =   to_noc_fifo[0].pipe_valid & noc__mcntl__dp_ready_d1 ;
  always @(*)
    begin
      to_noc_fifo[0].write_cntl       =   from_rdp_fifo[0].pipe_cntl      ;
      to_noc_fifo[0].write_type       =   from_rdp_fifo[0].pipe_type      ;
      to_noc_fifo[0].write_ptype      =   from_rdp_fifo[0].pipe_ptype     ;
      to_noc_fifo[0].write_desttype   =   from_rdp_fifo[0].pipe_desttype  ;
      to_noc_fifo[0].write_pvalid     =   from_rdp_fifo[0].pipe_pvalid    ;
      to_noc_fifo[0].write_data       =   from_rdp_fifo[0].pipe_data      ;
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


endmodule
