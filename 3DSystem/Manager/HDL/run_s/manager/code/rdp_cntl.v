/*********************************************************************************************

    File name   : rdp_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module collects the upstream tag and data and matches with the WU.
                  Both write requests and NoC packets are constructed
                  Module name = <rdp>

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "mgr_noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "wu_fetch.vh"
`include "wu_decode.vh"
`include "python_typedef.vh"
`include "rdp_cntl.vh"


package rdp_cntl_types;

  typedef logic  [`MGR_WU_OPT_TYPE_RANGE    ]    d_wud__rdp__option_type_t    [`MGR_WU_OPT_PER_INST ] ;  // WU Instruction option fields
  typedef logic  [`MGR_WU_OPT_VALUE_RANGE   ]    d_wud__rdp__option_value_t   [`MGR_WU_OPT_PER_INST ] ;  

endpackage: rdp_cntl_types

import rdp_cntl_types::*;

module rdp_cntl (

            //-------------------------------
            // Input from Work Unit Decoder
            //
            wud__rdp__valid             ,  // receive tag and MR tuples
            rdp__wud__ready             ,
            wud__rdp__dcntl             ,
            wud__rdp__tag               ,
            wud__rdp__option_type       ,
            wud__rdp__option_value      ,

            //-------------------------------
            // Input from Upstream Stack Bus 
            //
            stuc__rdp__valid         ,
            stuc__rdp__cntl          ,  // used to delineate upstream packet data
            rdp__stuc__ready         ,
            stuc__rdp__tag           ,  // Use this to match with WU and take all the data 
            stuc__rdp__data          ,  // The data may vary so check for cntl=EOD when reading this interface

            //-------------------------------
            // Memory Write Combine/Cache Interface
            //
            rdp__mwc__valid          , 
            rdp__mwc__cntl           , 
            mwc__rdp__ready          , 
            rdp__mwc__ptype          , 
            rdp__mwc__pvalid         , 
            rdp__mwc__data           , 

            //-------------------------------
            // NoC interface
            //
            // Control-Path (cp) to NoC 
            rdp__noc__cp_valid       , 
            rdp__noc__cp_cntl        , 
            noc__rdp__cp_ready       , 
            rdp__noc__cp_type        , 
            rdp__noc__cp_ptype       , 
            rdp__noc__cp_desttype    , 
            rdp__noc__cp_pvalid      , 
            rdp__noc__cp_data        , 

            // Data-Path (dp) to NoC 
            rdp__noc__dp_valid       , 
            rdp__noc__dp_cntl        , 
            noc__rdp__dp_ready       , 
            rdp__noc__dp_type        , 
            rdp__noc__dp_ptype       , 
            rdp__noc__dp_desttype    , 
            rdp__noc__dp_pvalid      , 
            rdp__noc__dp_data        , 

            //-------------------------------
            // Config
            //
            cfg__rdp__check_tag      ,

            //-------------------------------
            // General
            //
            sys__mgr__mgrId          ,
            clk                      ,
            reset_poweron    
 
    );

  //----------------------------------------------------------------------------------------------------
  // General

  input                                     clk                          ;
  input                                     reset_poweron                ;
  input   [`MGR_MGR_ID_RANGE    ]           sys__mgr__mgrId              ;


  //----------------------------------------------------------------------------------------------------
  // Config

  input                                     cfg__rdp__check_tag          ;

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //
  input                                          stuc__rdp__valid       ;
  input   [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rdp__cntl        ;
  output                                         rdp__stuc__ready       ;
  input   [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rdp__tag         ;  // Match Tag with tag from wu_decoder
  input   [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rdp__data        ;
 

  //-------------------------------------------------------------------------------------------------
  // Work Unit Decoder interface
  //
  input                                       wud__rdp__valid                ;
  output                                      rdp__wud__ready                ;
  input  [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__rdp__dcntl                ;  // descriptor delineator
  input  [`MGR_STD_OOB_TAG_RANGE         ]    wud__rdp__tag                  ;  // decoder generates tag for Return data proc and Downstream OOB
  input  [`MGR_WU_OPT_TYPE_RANGE         ]    wud__rdp__option_type    [`MGR_WU_OPT_PER_INST ] ;  // WU Instruction option fields
  input  [`MGR_WU_OPT_VALUE_RANGE        ]    wud__rdp__option_value   [`MGR_WU_OPT_PER_INST ] ;  
  //input     d_wud__rdp__option_type_t  wud__rdp__option_type     ;  // WU Instruction option fields
  //input     d_wud__rdp__option_value_t wud__rdp__option_value    ;  





  //-------------------------------------------------------------------------------------------------
  // Memory Write Combine/Cache Interface
  //
  // - Data and memory write descriptors
  output                                              rdp__mwc__valid      ; 
  output  [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__mwc__cntl       ; 
  input                                               mwc__rdp__ready      ; 
  output  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__mwc__ptype      ; 
  output                                              rdp__mwc__pvalid     ; 
  output  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__mwc__data       ; 
  
  //-------------------------------------------------------------------------------------------------
  // NoC interface
  //
  // Control-Path (cp) to NoC '
  output                                              rdp__noc__cp_valid      ; 
  output  [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__noc__cp_cntl       ; 
  input                                               noc__rdp__cp_ready      ; 
  output  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__noc__cp_type       ; 
  output  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__noc__cp_ptype      ; 
  output  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  rdp__noc__cp_desttype   ; 
  output                                              rdp__noc__cp_pvalid     ; 
  output  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__noc__cp_data       ; 
  
  // Data-Path (dp) to NoC '
  output                                              rdp__noc__dp_valid      ; 
  output  [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__noc__dp_cntl       ; 
  input                                               noc__rdp__dp_ready      ; 
  output  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__noc__dp_type       ; 
  output  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__noc__dp_ptype      ; 
  output  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  rdp__noc__dp_desttype   ; 
  output                                              rdp__noc__dp_pvalid     ; 
  output  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__noc__dp_data       ; 


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registers/Wires

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //

  wire                                           stuc__rdp__valid       ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rdp__cntl        ;
  reg                                            rdp__stuc__ready       ;
  wire    [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rdp__tag         ;  // tag size is the same as sent to PE
  wire    [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rdp__data        ;
 
  reg                                            stuc__rdp__valid_d1    ;
  reg     [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rdp__cntl_d1     ;
  wire                                           rdp__stuc__ready_e1    ;
  reg     [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rdp__tag_d1      ;  // tag size is the same as sent to PE
  reg     [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rdp__data_d1     ;

  //-------------------------------------------------------------------------------------------------
  // Work Unit Decoder interface
  //
  wire                                        wud__rdp__valid                ;
  reg                                         rdp__wud__ready                ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__rdp__dcntl                ;  // descriptor delineator
  wire   [`MGR_STD_OOB_TAG_RANGE         ]    wud__rdp__tag                  ;  // decoder generates tag for Return data proc and Downstream OOB
  wire   [`MGR_WU_OPT_TYPE_RANGE         ]    wud__rdp__option_type    [`MGR_WU_OPT_PER_INST ] ;
  wire   [`MGR_WU_OPT_VALUE_RANGE        ]    wud__rdp__option_value   [`MGR_WU_OPT_PER_INST ] ; 

  reg                                         wud__rdp__valid_d1             ;
  wire                                        rdp__wud__ready_e1             ;
  reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__rdp__dcntl_d1             ;  
  reg    [`MGR_STD_OOB_TAG_RANGE         ]    wud__rdp__tag_d1               ;
  reg    [`MGR_WU_OPT_TYPE_RANGE         ]    wud__rdp__option_type_d1    [`MGR_WU_OPT_PER_INST ] ;
  reg    [`MGR_WU_OPT_VALUE_RANGE        ]    wud__rdp__option_value_d1   [`MGR_WU_OPT_PER_INST ] ;

 
  //-------------------------------------------------------------------------------------------------
  // WU Decode and Stuc combine
  //
  wire                                     wud_data_available          ;
  wire                                     stuc_data_available         ;
  reg  [`RDP_CNTL_NUM_LANES_RANGE       ]  num_of_valid_lanes          ;  // how many words are valid from stack upstream packet
  reg                                      write_storage_ptr_tmp_valid ;
  reg  [`COMMON_STD_INTF_CNTL_RANGE     ]  write_storage_ptr_tmp_cntl  ;
  reg  [`MGR_STORAGE_DESC_ADDRESS_RANGE ]  write_storage_ptr_tmp       ;
  wire                                     wud_fifo_contains_wr_ptr    ;
  wire                                     wud_fifo_read               ;
  wire                                     wr_ptrs_all_sent            ;
  wire                                     destAddr_localFifo_write    ;
  wire                                     ptr_localFifo_write         ;
  wire                                     ptr_localFifo_almost_full   ;
  wire                                     wr_ptrs_all_stored          ;
  reg                                      wr_ptrs_all_stored_d1       ;
  wire                                     data_all_sent               ;
  wire                                     start_of_wu_descriptor      ;  // dcntl == SOM
  wire                                     middle_of_wu_descriptor     ;  // dcntl == MOM
  wire                                     end_of_wu_descriptor        ;  // dcntl == EOM
  reg  [`MGR_STD_OOB_TAG_RANGE          ]  current_tag                 ;  // waiting for this tag's return data


  //-------------------------------------------------------------------------------------------------
  // Memory Write Combine/Cache Interface
  //
  // - Data and memory write descriptors
  reg                                                 rdp__mwc__valid      ; 
  reg     [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__mwc__cntl       ; 
  wire                                                mwc__rdp__ready      ; 
  reg     [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__mwc__ptype      ; 
  reg                                                 rdp__mwc__pvalid     ; 
  reg     [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__mwc__data       ; 
  
  wire                                                rdp__mwc__valid_e1   ; 
  wire    [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__mwc__cntl_e1    ; 
  reg                                                 mwc__rdp__ready_d1   ; 
  wire    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__mwc__ptype_e1   ; 
  wire                                                rdp__mwc__pvalid_e1  ; 
  wire    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__mwc__data_e1    ; 
  

  //-------------------------------------------------------------------------------------------------
  // NoC interface
  //
  // Control-Path (cp) to NoC '
  reg                                                 rdp__noc__cp_valid      ; 
  reg     [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__noc__cp_cntl       ; 
  wire                                                noc__rdp__cp_ready      ; 
  reg     [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__noc__cp_type       ; 
  reg     [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__noc__cp_ptype      ; 
  reg     [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  rdp__noc__cp_desttype   ; 
  reg                                                 rdp__noc__cp_pvalid     ; 
  reg     [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__noc__cp_data       ; 
  
  // Data-Path (dp) to NoC '
  reg                                                 rdp__noc__dp_valid      ; 
  reg     [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__noc__dp_cntl       ; 
  wire                                                noc__rdp__dp_ready      ; 
  reg     [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__noc__dp_type       ; 
  reg     [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__noc__dp_ptype      ; 
  reg     [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  rdp__noc__dp_desttype   ; 
  reg                                                 rdp__noc__dp_pvalid     ; 
  reg     [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__noc__dp_data       ; 

  wire                                                rdp__noc__cp_valid_e1    ; 
  wire    [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__noc__cp_cntl_e1     ; 
  reg                                                 noc__rdp__cp_ready_d1    ; 
  wire    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__noc__cp_type_e1     ; 
  wire    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__noc__cp_ptype_e1    ; 
  wire    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  rdp__noc__cp_desttype_e1 ; 
  wire                                                rdp__noc__cp_pvalid_e1   ; 
  wire    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__noc__cp_data_e1     ; 
  
  wire                                                rdp__noc__dp_valid_e1    ; 
  wire    [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__noc__dp_cntl_e1     ; 
  reg                                                 noc__rdp__dp_ready_d1    ; 
  wire    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__noc__dp_type_e1     ; 
  wire    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__noc__dp_ptype_e1    ; 
  wire    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  rdp__noc__dp_desttype_e1 ; 
  wire                                                rdp__noc__dp_pvalid_e1   ; 
  wire    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__noc__dp_data_e1     ; 
  

  //-------------------------------------------------------------------------------------------------
  // Memory Write Descriptor Packet Output
  //  - create the packet output then steer to NoC and MWC based on pointer destination local and/or notlocal
  wire                                                wrDescOutputPkt_valid_e1     ; 
  wire    [`COMMON_STD_INTF_CNTL_RANGE             ]  wrDescOutputPkt_cntl_e1      ; 
  reg     [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  wrDescOutputPkt_type_e1      ; 
  wire    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  wrDescOutputPkt_ptype_e1     ; 
  reg     [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  wrDescOutputPkt_desttype_e1  ;  
  wire                                                wrDescOutputPkt_pvalid_e1    ; 
  wire    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  wrDescOutputPkt_data_e1      ; 


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registered Inputs and Outputs

  always @(posedge clk)
    begin
      stuc__rdp__valid_d1        <= ( reset_poweron   ) ? 'd0  :  stuc__rdp__valid       ;
      stuc__rdp__cntl_d1         <= ( reset_poweron   ) ? 'd0  :  stuc__rdp__cntl        ;
      rdp__stuc__ready           <= ( reset_poweron   ) ? 'd0  :  rdp__stuc__ready_e1    ;
      stuc__rdp__tag_d1          <= ( reset_poweron   ) ? 'd0  :  stuc__rdp__tag         ;
      stuc__rdp__data_d1         <= ( reset_poweron   ) ? 'd0  :  stuc__rdp__data        ;
    end

    always @(posedge clk) 
      begin
        rdp__wud__ready          <=   ( reset_poweron   ) ? 'd0  :  rdp__wud__ready_e1   ;
        wud__rdp__valid_d1       <=   ( reset_poweron   ) ? 'd0  :  wud__rdp__valid      ;
        wud__rdp__dcntl_d1       <=   ( reset_poweron   ) ? 'd0  :  wud__rdp__dcntl      ;
        wud__rdp__tag_d1         <=   ( reset_poweron   ) ? 'd0  :  wud__rdp__tag        ;
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_in
            wud__rdp__option_type_d1  [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__rdp__option_type  [opt]  ;
            wud__rdp__option_value_d1 [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__rdp__option_value [opt]  ;
          end
      end

  always @(posedge clk)
    begin
      rdp__noc__cp_valid         <= ( reset_poweron   ) ? 'd0  :  rdp__noc__cp_valid_e1     ;
      rdp__noc__cp_cntl          <= ( reset_poweron   ) ? 'd0  :  rdp__noc__cp_cntl_e1      ;
      noc__rdp__cp_ready_d1      <= ( reset_poweron   ) ? 'd0  :  noc__rdp__cp_ready        ;
      rdp__noc__cp_type          <= ( reset_poweron   ) ? 'd0  :  rdp__noc__cp_type_e1      ;
      rdp__noc__cp_ptype         <= ( reset_poweron   ) ? 'd0  :  rdp__noc__cp_ptype_e1     ;
      rdp__noc__cp_desttype      <= ( reset_poweron   ) ? 'd0  :  rdp__noc__cp_desttype_e1  ;
      rdp__noc__cp_pvalid        <= ( reset_poweron   ) ? 'd0  :  rdp__noc__cp_pvalid_e1    ;
      rdp__noc__cp_data          <= ( reset_poweron   ) ? 'd0  :  rdp__noc__cp_data_e1      ;

      rdp__noc__dp_valid         <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_valid_e1     ;
      rdp__noc__dp_cntl          <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_cntl_e1      ;
      noc__rdp__dp_ready_d1      <= ( reset_poweron   ) ? 'd0  :  noc__rdp__dp_ready        ;
      rdp__noc__dp_type          <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_type_e1      ;
      rdp__noc__dp_ptype         <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_ptype_e1     ;
      rdp__noc__dp_desttype      <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_desttype_e1  ;
      rdp__noc__dp_pvalid        <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_pvalid_e1    ;
      rdp__noc__dp_data          <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_data_e1      ;
    end

  always @(posedge clk)
    begin
      rdp__mwc__valid     <= ( reset_poweron   ) ? 'd0  :  rdp__mwc__valid_e1  ;
      rdp__mwc__cntl      <= ( reset_poweron   ) ? 'd0  :  rdp__mwc__cntl_e1   ;
      mwc__rdp__ready_d1  <= ( reset_poweron   ) ? 'd0  :  mwc__rdp__ready     ;
      rdp__mwc__ptype     <= ( reset_poweron   ) ? 'd0  :  rdp__mwc__ptype_e1  ;
      rdp__mwc__pvalid    <= ( reset_poweron   ) ? 'd0  :  rdp__mwc__pvalid_e1 ;
      rdp__mwc__data      <= ( reset_poweron   ) ? 'd0  :  rdp__mwc__data_e1   ;
    end
  //----------------------------------------------------------------------------------------------------
  // From WU Decode
  //   - Storage descriptor
  //   - Tag 
  //

  // Put in a generate in case we decide to extend to multiple upstream lanes

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
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`RDP_CNTL_WU_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`RDP_CNTL_WU_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_STD_OOB_TAG_WIDTH+`MGR_WU_OPT_PER_INST*`MGR_WU_OPT_TYPE_WIDTH+`MGR_WU_OPT_PER_INST*`MGR_WU_OPT_VALUE_WIDTH )
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
  assign from_WuDecode_Fifo[0].write   =   wud__rdp__valid_d1  ;
  always @(*)
    begin
      from_WuDecode_Fifo[0].write_dcntl    =   wud__rdp__dcntl_d1   ;
      from_WuDecode_Fifo[0].write_tag      =   wud__rdp__tag_d1     ;
      for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
        begin: option_in
          from_WuDecode_Fifo[0].write_option_type  [opt]   =   wud__rdp__option_type_d1  [opt]  ;
          from_WuDecode_Fifo[0].write_option_value [opt]   =   wud__rdp__option_value_d1 [opt]  ;
        end
    end
         
  assign start_of_wu_descriptor          = from_WuDecode_Fifo[0].pipe_valid & (from_WuDecode_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM) ;
  assign middle_of_wu_descriptor         = from_WuDecode_Fifo[0].pipe_valid & (from_WuDecode_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM) ;
  assign end_of_wu_descriptor            = from_WuDecode_Fifo[0].pipe_valid & (from_WuDecode_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM) ;
  assign rdp__wud__ready_e1              = ~from_WuDecode_Fifo[0].almost_full  ;




  //----------------------------------------------------------------------------------------------------
  // From Stack Upstream
  //   - Data
  //   - Tag 
  //

  // Put in a generate in case we decide to extend to multiple upstream lanes

  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Stuc_Fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_cntl         ;
        reg    [`MGR_STD_OOB_TAG_RANGE          ]         write_tag          ;
        reg    [`STACK_UP_INTF_DATA_RANGE       ]         write_data         ;
                                                                           
        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_cntl          ;
        wire   [`MGR_STD_OOB_TAG_RANGE          ]         read_tag           ;
        wire   [`STACK_UP_INTF_DATA_RANGE       ]         read_data          ;

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`RDP_CNTL_STUC_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`RDP_CNTL_STUC_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_STD_OOB_TAG_WIDTH+`STACK_UP_INTF_DATA_WIDTH)
                        ) gfifo (
                                          // Status
                                         .empty            ( empty                                     ),
                                         .almost_full      ( almost_full                               ),
                                         .almost_empty     (                                           ),
                                         .depth            (                                           ),
                                          // Write                                                     
                                         .write            ( write                                     ),
                                         .write_data       ( {write_cntl, write_tag, write_data}       ),
                                          // Read                                                
                                         .read             ( read                                      ),
                                         .read_data        ( { read_cntl,  read_tag,  read_data}       ),

                                         // General
                                         .clear            ( clear                                     ),
                                         .reset_poweron    ( reset_poweron                             ),
                                         .clk              ( clk                                       )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_cntl         ;
        reg    [`MGR_STD_OOB_TAG_RANGE          ]            pipe_tag          ;
        reg    [`STACK_UP_INTF_DATA_RANGE       ]            pipe_data         ;
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
            pipe_cntl           <= ( fifo_pipe_read     ) ? read_cntl            :
                                                            pipe_cntl            ;
            pipe_tag            <= ( fifo_pipe_read     ) ? read_tag             :
                                                            pipe_tag             ;
            pipe_data           <= ( fifo_pipe_read     ) ? read_data            :
                                                            pipe_data            ;
          end

      end
  endgenerate


  assign from_Stuc_Fifo[0].clear   =   1'b0                ;
  assign from_Stuc_Fifo[0].write   =   stuc__rdp__valid_d1  ;
  always @(*)
    begin
      from_Stuc_Fifo[0].write_cntl     =   stuc__rdp__cntl_d1   ;
      from_Stuc_Fifo[0].write_tag      =   stuc__rdp__tag_d1    ;
      from_Stuc_Fifo[0].write_data     =   stuc__rdp__data_d1   ;
    end
         
  assign rdp__stuc__ready_e1              = ~from_Stuc_Fifo[0].almost_full  ;

  assign data_all_sent    = from_Stuc_Fifo[0].pipe_valid & from_Stuc_Fifo[0].pipe_read & ((from_Stuc_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM) || (from_Stuc_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ;


  //----------------------------------------------------------------------------------------------------
  // Tag Recombine FSM
  //  - generate command to local memory write controller
  //  - generate memory write packet to NoC
  //

  reg [`RDP_CNTL_TAG_DATA_COMBINE_STATE_RANGE ] rdp_cntl_tag_data_combine_state      ; // state flop
  reg [`RDP_CNTL_TAG_DATA_COMBINE_STATE_RANGE ] rdp_cntl_tag_data_combine_state_next ;
  
  
  // State register 
  always @(posedge clk)
    begin
      rdp_cntl_tag_data_combine_state <= ( reset_poweron ) ? `RDP_CNTL_TAG_DATA_COMBINE_WAIT        :
                                                              rdp_cntl_tag_data_combine_state_next  ;
    end
  
  //--------------------------------------------------
  // Assumptions:
  //  - destination blocks can absorb entire transaction if they are ready e.g. we wont flow control during the transfer but once all destinations are ready
  //    the transfer(s) will run to completion
  
  always @(*)
    begin
      case (rdp_cntl_tag_data_combine_state)
        
        // Note: the pipe will not be read unless all affected destination modules are ready
        // Right now, inputs from WUD are expected to be at least 2 cycles, so only check for SOM, SOM_EOM will flag an error
        // As soon as we get a descriptor from WUD, start extracting wr_ptrs to determine destination bit-field and to save wr_ptr for NoC packet
        // The first read will place any wr_ptr in the write_storage_ptr_tmp register
        
        `RDP_CNTL_TAG_DATA_COMBINE_WAIT: 
          rdp_cntl_tag_data_combine_state_next =  ( wud_fifo_contains_wr_ptr && start_of_wu_descriptor) ? `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR      :  // First cycle contains wr_ptr and by default the temporary register wont be valid. Set cntl=SOD in case we need to write in FIRST_PTR state
                                                  ( wud_data_available       && start_of_wu_descriptor) ? `RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_PTR   :  // First cycle doesnt contain wr_ptr
                                                  ( wud_data_available                                ) ? `RDP_CNTL_TAG_DATA_COMBINE_ERR               :  // wu descriptor always more than 1-cycle
                                                                                                          `RDP_CNTL_TAG_DATA_COMBINE_WAIT              ;

        // Read the {option, value} tuples from the WU Decoder so we can form a destination bitfield for the NoC and prepare for stack upstream data
        // FIXME: We will likely have to save a MW pointer for each PE, so assume we need to remove 64 storage pointers from the WU decode FIFO and store locally
        // if tuple contains wr_ptr and dcntl==EOM, then store wr_ptr in local fifo with cntl=SOM_EOM and goto WR_PTRS_COMPLETE state where the local fifo will be written with the temp register
        // Note: do not write local ptr fifo in this state
        //
        // This state has a tmp ptr with cntl=SOM
        // 1) If we get end-of-desc and no wr_ptr, then state=ERR
        // 2) If we get end-of-desc and we do see a wr_ptr, then set cntl=SOM_EOM to store last ptr in state==WR_PTRS_COMPLETE. 
        // 3) If we dont get end-of-desc and we do see a wr_ptr, then set cntl=SOM for possible store in state==FIRST_WR_PTR 
        `RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_PTR: 
          rdp_cntl_tag_data_combine_state_next =  ( wud_fifo_read &&  wud_fifo_contains_wr_ptr && end_of_wu_descriptor   ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :  // There is only one wr_ptr, store temp reg with ptr and cntl=SOD_EOD and write in WR_PTRS_COMPLETE state
                                                  ( wud_fifo_read &&  wud_fifo_contains_wr_ptr                           ) ? `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR     :  // might be more than one, so leave cntl=SOD for now
                                                  ( wud_fifo_read && ~wud_fifo_contains_wr_ptr && end_of_wu_descriptor   ) ? `RDP_CNTL_TAG_DATA_COMBINE_ERR              :  // didnt see any wr ptr's
                                                                                                                             `RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_PTR  ;  // just wait reading any descriptor info that isnt a wr ptr

        // This state has a tmp ptr with cntl=SOM
        // 1) If we get end-of-desc and no wr_ptr, then dont write current but set cntl=SOM_EOM and store this single ptr in state==WR_PTRS_COMPLETE. 
        // 2) If we get end-of-desc and we do see another wr_ptr, then write current with its cntl=SOM and set cntl=EOM to store last ptr in state==WR_PTRS_COMPLETE. 
        // 3) If we dont get end-of-desc and we do see another wr_ptr, then write current with its cntl=SOM and set cntl=MOM for possible store in state==HOLD_WR_PTR. 
        `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR: 
          rdp_cntl_tag_data_combine_state_next =  ( wud_fifo_read &&  wud_fifo_contains_wr_ptr && end_of_wu_descriptor   ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :  // There is two wr_ptrs and cntl=SOD, so write tmp to local fifo and load cntl=EOD and write 2nd transfer in WR_PTRS_COMPLETE state
                                                  ( wud_fifo_read && ~wud_fifo_contains_wr_ptr && end_of_wu_descriptor   ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :  // There is one wr_ptr, so DO NOT write tmp to local fifo but load cntl=SOD_EOD and write the single transfer in WR_PTRS_COMPLETE state
                                                  ( wud_fifo_read &&  wud_fifo_contains_wr_ptr                           ) ? `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      :  // another wr ptr so there will be >1 cycle in transfer but we dont know if this is the last, cntl is already SOD so write tmp to local fifo and cntl=MOD and write the single transfer in WR_PTRS_COMPLETE state
                                                  ( wud_fifo_read                                                        ) ? `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR     :  // data available but no wr_ptr
                                                                                                                             `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR     ;

        // This state has a tmp ptr with cntl=MOM
        // In this state, we know there will be more than one transfer, so hold at least one ptr until we get end-of-desc and then set cntl=EOD and goto WR_PTRS_COMPLETE state where the last transfer will be written
        // 1) If we get end-of-desc and no wr_ptr, then dont write current but set cntl=SOM_EOM and store this now last ptr in state==WR_PTRS_COMPLETE. 
        // 2) If we get end-of-desc and we do see another wr_ptr, then write current with its cntl=MOM and set cntl=EOM to store last ptr in state==WR_PTRS_COMPLETE. 
        // 3) If we dont get end-of-desc and we do see another wr_ptr, then write current with its cntl=MOM  and leave cntl at MOM
        `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR: 
          rdp_cntl_tag_data_combine_state_next =  ( wud_fifo_contains_wr_ptr && end_of_wu_descriptor    ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :
                                                  ( wud_fifo_contains_wr_ptr && middle_of_wu_descriptor ) ? `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      :
                                                  ( wud_data_available       && end_of_wu_descriptor    ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :  // EOD and no wr_ptr
                                                  ( wud_data_available       && middle_of_wu_descriptor ) ? `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      :  // MOD and no wr_ptr
                                                                                                            `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      ;
        // need to find num_lanes and all write pointers
        //  - the write pointers will be written to a local fifo. We dont know how many there are so pause on each mem ptr so we can check if another is coming before writing the CNTL field
        //  - in this state, we write the final ptr if the tmp storage is valid
        `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE: 
          rdp_cntl_tag_data_combine_state_next =   `RDP_CNTL_TAG_DATA_COMBINE_START_BUILD_NOC_PKT ;
        
        `RDP_CNTL_TAG_DATA_COMBINE_START_BUILD_NOC_PKT: 
          rdp_cntl_tag_data_combine_state_next =  ( noc__rdp__dp_ready_d1 ) ? `RDP_CNTL_TAG_DATA_COMBINE_SEND_BITFIELD  :
                                                                              `RDP_CNTL_TAG_DATA_COMBINE_START_BUILD_NOC_PKT  ;
        
        `RDP_CNTL_TAG_DATA_COMBINE_SEND_BITFIELD: 
          rdp_cntl_tag_data_combine_state_next =  `RDP_CNTL_TAG_DATA_COMBINE_SEND_WR_PTRS           ;
        
        `RDP_CNTL_TAG_DATA_COMBINE_SEND_WR_PTRS: 
          rdp_cntl_tag_data_combine_state_next =  ( wr_ptrs_all_sent )  ? `RDP_CNTL_TAG_DATA_COMBINE_SEND_DATA     :
                                                                          `RDP_CNTL_TAG_DATA_COMBINE_SEND_WR_PTRS  ;
        
        `RDP_CNTL_TAG_DATA_COMBINE_SEND_DATA: 
          rdp_cntl_tag_data_combine_state_next =  ( data_all_sent )  ? `RDP_CNTL_TAG_DATA_COMBINE_COMPLETE   :
                                                                       `RDP_CNTL_TAG_DATA_COMBINE_SEND_DATA  ;
        
        `RDP_CNTL_TAG_DATA_COMBINE_COMPLETE: 
          rdp_cntl_tag_data_combine_state_next =  `RDP_CNTL_TAG_DATA_COMBINE_WAIT           ;
        
        // Latch state on error
        `RDP_CNTL_TAG_DATA_COMBINE_ERR:
          rdp_cntl_tag_data_combine_state_next = `RDP_CNTL_TAG_DATA_COMBINE_ERR ;
  
        default:
          rdp_cntl_tag_data_combine_state_next = `RDP_CNTL_TAG_DATA_COMBINE_WAIT ;
    
      endcase // case (rdp_cntl_tag_data_combine_state)
    end // always @ (*)
  
  //----------------------------------------------------------------------------------------------------
  // Assignments
  //

  // Always read the WU Descriptor FIFO unless the temporary reg is valid and the local ptr fifo is almost full
  assign wud_fifo_read                   =    wud_data_available & 
                                            ~(wud_fifo_contains_wr_ptr & write_storage_ptr_tmp_valid & ptr_localFifo_almost_full) &  // cant transfer to temporary ptr register, so dont read
                                            ((rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WAIT            ) |  
                                             (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_PTR ) |  
//                                             (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WAIT_FOR_WR_PTR ) |  
                                             (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR    ) |  
                                             (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR     ));  

  assign from_WuDecode_Fifo[0].pipe_read =   wud_fifo_read ;

  // We always load the pointer into the tmp register prior to loading into the local storage FIFO
  // We hold the pointer in this temp register unless we are about to read another pointer, so once valid, it stays valid until the descriptor has been completely
  // read from the WU descriptor fifo
  always @(posedge clk)
    begin
      write_storage_ptr_tmp_valid <=  ( reset_poweron                                                                        ) ? 1'b0                        :
                                      ( wud_fifo_contains_wr_ptr && wud_fifo_read                                            ) ? 1'b1                        :
                                      ( rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE       ) ? 1'b0                        :
                                                                                                                                 write_storage_ptr_tmp_valid ;
      write_storage_ptr_tmp_cntl  <=  ( reset_poweron                                                                                                                                           ) ? `COMMON_STD_INTF_CNTL_SOM     :  
                                      (                                                                        (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WAIT             )) ? `COMMON_STD_INTF_CNTL_SOM     :
                                                          
                                      ( wud_fifo_read &&  wud_fifo_contains_wr_ptr &&  end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_PTR  )) ? `COMMON_STD_INTF_CNTL_SOM_EOM :  // single transfer will be written in state==WR_PTRS_COMPLETE
                                                          
                                      ( wud_fifo_read && ~wud_fifo_contains_wr_ptr &&  end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR     )) ? `COMMON_STD_INTF_CNTL_SOM_EOM :  // single transfer will be written in state==WR_PTRS_COMPLETE 
                                      ( wud_fifo_read &&  wud_fifo_contains_wr_ptr &&  end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR     )) ? `COMMON_STD_INTF_CNTL_EOM     :  // Two transfers, 2nd transfer will be written in state==WR_PTRS_COMPLETE 
                                      ( wud_fifo_read &&  wud_fifo_contains_wr_ptr && ~end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR     )) ? `COMMON_STD_INTF_CNTL_MOM     :  // write current SOD and prepate cntl=MOM for state==HOLD_WR_PTR
                                                          
                                      ( wud_fifo_read && ~wud_fifo_contains_wr_ptr &&  end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      )) ? `COMMON_STD_INTF_CNTL_EOM     :  // Multiple transfers, last transfer will be written in state==WR_PTRS_COMPLETE 
                                      ( wud_fifo_read &&  wud_fifo_contains_wr_ptr &&  end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      )) ? `COMMON_STD_INTF_CNTL_EOM     :
                                                                                                                                                                                                     write_storage_ptr_tmp_cntl   ;
    end

  always @(posedge clk)
    begin
      current_tag          <= ( reset_poweron                                                                                                                                                               ) ? 'd0                            :
                              ( from_WuDecode_Fifo[0].pipe_read  && ((from_WuDecode_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM) || (from_WuDecode_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM))) ? from_WuDecode_Fifo[0].pipe_tag : 
                                                                                                                                                                                                                current_tag                    ; // 
    end


  assign wud_data_available              = from_WuDecode_Fifo[0].pipe_valid ;
  assign stuc_data_available             = from_Stuc_Fifo[0].pipe_valid     ;


  //----------------------------------------------------------------------------------------------------
  // Local Memory Write Tuple and destination bitmask address storage
  //  - store each MR tuple
  //  - store the bitMask destination address created from the manager ID bit in the write pointer address
  //
  // Two separate fifo's, there might be multiple write pointers per NoC packet but there will be one bitmask destination address for
  // each group of Mwrite pointer tuples

  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: storagePtr_LocalFifo

        // Write data
        // Need cntl because number of write storage ptrs per descriptor varies
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_cntl         ;
        reg    [`MGR_STORAGE_DESC_ADDRESS_RANGE ]         write_storage_ptr  ;  // pointer is {mgrId, localDescAddress}
                                                                             
        // Read data                                                         
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_cntl          ;
        wire   [`MGR_STORAGE_DESC_ADDRESS_RANGE ]         read_storage_ptr   ;
                                                                             
        // Control                                                           
        wire                                              clear              ; 
        wire                                              empty              ; 
        wire                                              almost_full        ; 
        wire                                              read               ; 
        wire                                              write              ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`RDP_CNTL_MW_PTR_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`RDP_CNTL_MW_PTR_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_STORAGE_DESC_ADDRESS_WIDTH)
                        ) gfifo (
                                          // Status
                                         .empty            ( empty                      ),
                                         .almost_full      ( almost_full                ),
                                         .almost_empty     (                            ),
                                         .depth            (                            ),
                                          // Write                                      
                                         .write            ( write                      ),
                                         .write_data       ( {write_cntl, write_storage_ptr }), 
                                          // Read                                       
                                         .read             ( read                       ),
                                         .read_data        ( { read_cntl,  read_storage_ptr }), 

                                         // General
                                         .clear            ( clear                      ),
                                         .reset_poweron    ( reset_poweron              ),
                                         .clk              ( clk                        )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_cntl         ;
        reg    [`MGR_STORAGE_DESC_ADDRESS_RANGE ]            pipe_storage_ptr  ;
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
            pipe_valid          <= ( reset_poweron      ) ? 'b0                :
                                   ( fifo_pipe_read     ) ? 'b1                :
                                   ( pipe_read          ) ? 'b0                :
                                                             pipe_valid        ;
        
            // if we are reading, transfer from previous pipe stage. 
            pipe_cntl           <= ( fifo_pipe_read     ) ? read_cntl          :
                                                            pipe_cntl          ;
            pipe_storage_ptr    <= ( fifo_pipe_read     ) ? read_storage_ptr   :
                                                            pipe_storage_ptr   ;
          end

      end
  endgenerate

  assign storagePtr_LocalFifo[0].clear = 1'b0 ;
  // write to the local ptr fifo if the tmp reg is valid and we are about to reload the tmp reg or the tmp reg has a valid ptr and we are done with the descriptor.
  // Remember, if there is descriptor data available, we read it.
  //
  assign ptr_localFifo_almost_full       =   storagePtr_LocalFifo[0].almost_full ;

  assign ptr_localFifo_write             =   ~ptr_localFifo_almost_full   &
                                            (wud_fifo_read & wud_fifo_contains_wr_ptr & write_storage_ptr_tmp_valid  |
                                                                                      & write_storage_ptr_tmp_valid  & (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE)) ;

  assign storagePtr_LocalFifo[0].write   =   ptr_localFifo_write         ;

  assign storagePtr_LocalFifo[0].write_cntl         = write_storage_ptr_tmp_cntl ;
  assign storagePtr_LocalFifo[0].write_storage_ptr  = write_storage_ptr_tmp      ;

  assign wr_ptrs_all_sent   = storagePtr_LocalFifo[0].pipe_valid & storagePtr_LocalFifo[0].pipe_read & ((storagePtr_LocalFifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM) || (storagePtr_LocalFifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ;
  assign wr_ptrs_all_stored = storagePtr_LocalFifo[0].write & ((storagePtr_LocalFifo[0].write_cntl == `COMMON_STD_INTF_CNTL_EOM) || (storagePtr_LocalFifo[0].write_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ;

  // Write to local storage pointer FIFO
  `include "rdp_cntl_option_tuple_extract.vh"


  //------------------------------------------------------------------------------------------------------------------------
  // FIFO for single entry per NoC packet
  //  - destination address
  //  - number of lanes
  //  - tag
  //  - flag to indicate a local pointer is in the descriptor
  // As we write the write pointers into the fifo, use the manager address field from the pointer address to add a bit to the desination bit mask. When the
  // last write pointer is written, write the destination address into its fifo.
  //
 
  reg    [`MGR_MGR_ID_BITMASK_RANGE       ]         aggregateNocDestBitMaskAddr     ;  // accumulate address bits here
  reg    [`MGR_MGR_ID_BITMASK_RANGE       ]         currPtrDestBitMaskAddr          ;  // bit mask of ptr being written into fifo
  wire   [`MGR_MGR_ID_RANGE               ]         currPtrManager                  ;  // manager ID of ptr being written into fifo
  reg                                               onePtrIsLocal                   ;  // one of the ptr's being written into fifo is for this manager
  reg                                               onePtrIsNotLocal                ;  // one of the ptr's being written into fifo is for another manager
  
  assign currPtrManager = write_storage_ptr_tmp [`MGR_STORAGE_DESC_MGR_ID_FIELD_RANGE ]  ;  // extract manager ID from pointer

  `include "rdp_cntl_create_noc_bitmask_address.vh"

  always @(posedge clk)
    begin
      onePtrIsLocal               <= ( reset_poweron                 ) ? 'd0                                                   :
                                     ( destAddr_localFifo_write      ) ? 'd0                                                   :  // clear after write
                                     ( storagePtr_LocalFifo[0].write ) ? (onePtrIsLocal | (currPtrManager == sys__mgr__mgrId)) :
                                                                         onePtrIsLocal                                         ;

      onePtrIsNotLocal            <= ( reset_poweron                 ) ? 'd0                                                      :
                                     ( destAddr_localFifo_write      ) ? 'd0                                                      :  // clear after write
                                     ( storagePtr_LocalFifo[0].write ) ? (onePtrIsNotLocal | (currPtrManager != sys__mgr__mgrId)) :
                                                                         onePtrIsNotLocal                                         ;

      aggregateNocDestBitMaskAddr <= ( reset_poweron                 ) ? 'd0                                                    :
                                     ( destAddr_localFifo_write      ) ? 'd0                                                    :  // clear after write
                                     ( storagePtr_LocalFifo[0].write ) ? (aggregateNocDestBitMaskAddr | currPtrDestBitMaskAddr) :
                                                                         aggregateNocDestBitMaskAddr                            ;
    end

  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: storageDestAddr_LocalFifo

        // Write data
        // Dont really need cntl as there is one destination address per NoC packet
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_cntl         ;
        reg    [`MGR_STD_OOB_TAG_RANGE          ]         write_tag          ;  // this tag should match the tag from the stuc FIFO
        reg                                               write_oneIsLocal   ;  // at least one of the pointers is for this manager
        reg                                               write_oneIsNotLocal;  // at least one of the pointers is for another manager
        reg    [`RDP_CNTL_NUM_LANES_RANGE       ]         write_numLanes     ;
        reg    [`MGR_MGR_ID_BITMASK_RANGE       ]         write_destAddr     ;
                                                                             
        // Read data                                                         
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_cntl          ;
        wire   [`MGR_STD_OOB_TAG_RANGE          ]         read_tag           ;
        wire                                              read_oneIsLocal    ; 
        wire                                              read_oneIsNotLocal ; 
        wire   [`RDP_CNTL_NUM_LANES_RANGE       ]         read_numLanes      ;
        wire   [`MGR_MGR_ID_BITMASK_RANGE       ]         read_destAddr      ;
                                                                             
        // Control                                                           
        wire                                              clear              ; 
        wire                                              empty              ; 
        wire                                              almost_full        ; 
        wire                                              read               ; 
        wire                                              write              ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`RDP_CNTL_TO_NOC_DEST_ADDR_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`RDP_CNTL_TO_NOC_DEST_ADDR_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+1+1+`MGR_STD_OOB_TAG_WIDTH+`RDP_CNTL_NUM_LANES_WIDTH+`MGR_MGR_ID_BITMASK_WIDTH)
                        ) gfifo (
                                          // Status
                                         .empty            ( empty                      ),
                                         .almost_full      ( almost_full                ),
                                         .almost_empty     (                            ),
                                         .depth            (                            ),
                                          // Write                                      
                                         .write            ( write                      ),
                                         .write_data       ( {write_cntl, write_tag, write_oneIsLocal, write_oneIsNotLocal, write_numLanes, write_destAddr }), 
                                          // Read                                                         
                                         .read             ( read                       ), 
                                         .read_data        ( { read_cntl,  read_tag,  read_oneIsLocal,  read_oneIsNotLocal,  read_numLanes,  read_destAddr }), 

                                         // General
                                         .clear            ( clear                      ),
                                         .reset_poweron    ( reset_poweron              ),
                                         .clk              ( clk                        )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_cntl         ;
        reg    [`MGR_STD_OOB_TAG_RANGE          ]            pipe_tag          ;
        reg                                                  pipe_oneIsLocal   ;
        reg                                                  pipe_oneIsNotLocal;
        reg    [`RDP_CNTL_NUM_LANES_RANGE       ]            pipe_numLanes     ;
        reg    [`MGR_MGR_ID_BITMASK_RANGE       ]            pipe_destAddr     ;
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
            pipe_valid          <= ( reset_poweron      ) ? 'b0                :
                                   ( fifo_pipe_read     ) ? 'b1                :
                                   ( pipe_read          ) ? 'b0                :
                                                             pipe_valid        ;
        
            // if we are reading, transfer from previous pipe stage. 
            pipe_cntl           <= ( fifo_pipe_read     ) ? read_cntl          :
                                                            pipe_cntl          ;
            pipe_tag            <= ( fifo_pipe_read     ) ? read_tag           :
                                                            pipe_tag           ;
            pipe_oneIsLocal     <= ( fifo_pipe_read     ) ? read_oneIsLocal    :
                                                            pipe_oneIsLocal    ;
            pipe_oneIsNotLocal  <= ( fifo_pipe_read     ) ? read_oneIsNotLocal :
                                                            pipe_oneIsNotLocal ;
            pipe_numLanes       <= ( fifo_pipe_read     ) ? read_numLanes      :
                                                            pipe_numLanes      ;
            pipe_destAddr       <= ( fifo_pipe_read     ) ? read_destAddr      :
                                                            pipe_destAddr      ;
          end

      end
  endgenerate

  assign storageDestAddr_LocalFifo[0].clear = 1'b0 ;

  // write the destination address one cycle after we have completed writing all the pointers
  // This allows the last mask bit to be set before writing
  always @(posedge clk)
    begin
      wr_ptrs_all_stored_d1 <= wr_ptrs_all_stored ;
    end
  assign destAddr_localFifo_write                            = wr_ptrs_all_stored_d1         ;
  assign storageDestAddr_LocalFifo[0].write                  = destAddr_localFifo_write      ;
  assign storageDestAddr_LocalFifo[0].write_cntl             = `COMMON_STD_INTF_CNTL_SOM_EOM ;
  assign storageDestAddr_LocalFifo[0].write_tag              = current_tag                   ;
  assign storageDestAddr_LocalFifo[0].write_oneIsLocal       = onePtrIsLocal                 ;
  assign storageDestAddr_LocalFifo[0].write_oneIsNotLocal    = onePtrIsNotLocal              ;
  assign storageDestAddr_LocalFifo[0].write_numLanes         = num_of_valid_lanes            ;
  assign storageDestAddr_LocalFifo[0].write_destAddr         = aggregateNocDestBitMaskAddr   ;

  //assign storagePtr_LocalFifo[0].pipe_read          = storagePtr_LocalFifo[0].pipe_valid      ;
  //assign storageDestAddr_LocalFifo[0].pipe_read     = storageDestAddr_LocalFifo[0].pipe_valid ;


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // NoC Memory Write Packet Generator
  //  - generate NoC packet using contents of:
  //    * Data from from_Stuc_Fifo
  //    * Destination bitfield and number of valid words from storageDestAddr_LocalFifo
  //    * Memory Write pointers from storagePtr_LocalFifo
  //

  reg [`RDP_CNTL_NOC_PKT_GEN_STATE_RANGE ] rdp_cntl_noc_data_packet_gen_state      ; // state flop
  reg [`RDP_CNTL_NOC_PKT_GEN_STATE_RANGE ] rdp_cntl_noc_data_packet_gen_state_next ;
  
  
  // State register 
  always @(posedge clk)
    begin
      rdp_cntl_noc_data_packet_gen_state <= ( reset_poweron ) ? `RDP_CNTL_NOC_PKT_GEN_WAIT               :
                                                                rdp_cntl_noc_data_packet_gen_state_next  ;
    end
  
  //------------------------------------------------------------------------------------------
  // FSM Regs and Wires

  // Create wires for source of data for NoC packets and local memory write
  wire                                              from_Stuc_valid                       =  from_Stuc_Fifo[0].pipe_valid                      ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         from_Stuc_cntl                        =  from_Stuc_Fifo[0].pipe_cntl                       ;
  wire   [`MGR_STD_OOB_TAG_RANGE          ]         from_Stuc_tag                         =  from_Stuc_Fifo[0].pipe_tag                        ;
  wire   [`STACK_UP_INTF_DATA_RANGE       ]         from_Stuc_data                        =  from_Stuc_Fifo[0].pipe_data                       ;
  wire                                              from_Stuc_eom                         =  (from_Stuc_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (from_Stuc_cntl == `COMMON_STD_INTF_CNTL_EOM) ;
                                                                                                                                               
  wire                                              from_wrPtrFifo_valid                  =  storagePtr_LocalFifo[0].pipe_valid                ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         from_wrPtrFifo_cntl                   =  storagePtr_LocalFifo[0].pipe_cntl                 ;
  wire   [`MGR_STORAGE_DESC_ADDRESS_RANGE ]         from_WrPtrFifo_wrPtr                  =  storagePtr_LocalFifo[0].pipe_storage_ptr          ;
  wire                                              from_wrPtrFifo_eom                    =  (from_wrPtrFifo_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (from_wrPtrFifo_cntl == `COMMON_STD_INTF_CNTL_EOM) ;
                                                                                          
  wire                                              from_NocInfoFifo_valid                =  storageDestAddr_LocalFifo[0].pipe_valid           ; 
  wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         from_NocInfoFifo_cntl                 =  storageDestAddr_LocalFifo[0].pipe_cntl            ;
  wire   [`MGR_STD_OOB_TAG_RANGE          ]         from_NocInfoFifo_tag                  =  storageDestAddr_LocalFifo[0].pipe_tag             ; 
  wire                                              from_NocInfoFifo_oneIsLocal           =  storageDestAddr_LocalFifo[0].pipe_oneIsLocal      ; 
  wire                                              from_NocInfoFifo_oneIsNotLocal        =  storageDestAddr_LocalFifo[0].pipe_oneIsNotLocal   ; 
  wire   [`RDP_CNTL_NUM_LANES_RANGE       ]         from_NocInfoFifo_numLanes             =  storageDestAddr_LocalFifo[0].pipe_numLanes        ;
  wire   [`MGR_MGR_ID_BITMASK_RANGE       ]         from_NocInfoFifo_destAddr             =  storageDestAddr_LocalFifo[0].pipe_destAddr        ;

  // check if the pointer include a local pointer and/or a pointer destined for another manager and test the local ready flag and/or NoC ready flag
  wire                                              wr_destinations_ready                 = (~from_NocInfoFifo_oneIsLocal | mwc__rdp__ready_d1) & (~from_NocInfoFifo_oneIsNotLocal | noc__rdp__dp_ready_d1) ;

  // we need to transfer the required number of words to satisfy the write descriptor. We transfer two words, so set our counter to numLanes[.:1] and use numLanes[0] to set payLoad valid to show
  // whether both words are valid in the transfer (the mem wr descriptor will know but lets capture pValid for completeness.
  reg  [`RDP_CNTL_NUM_LANES_MSB: `RDP_CNTL_NUM_LANES_LSB+1  ]  dataCount                                                                                    ;  // decrement by pairs of lanes
  wire [`RDP_CNTL_NUM_LANES_MSB: `RDP_CNTL_NUM_LANES_LSB+1  ]  numLanesDiv2  = from_NocInfoFifo_numLanes[`RDP_CNTL_NUM_LANES_MSB: `RDP_CNTL_NUM_LANES_LSB+1 ]  ;  // set initial count
  wire                                                         dataCountOdd  = from_NocInfoFifo_numLanes[0]                                                 ;  // use to set pValid in last transfer
  wire                                                         lastDataCycle = ((dataCount == 'd1) && ~dataCountOdd)|| ((dataCount == 'd0) && dataCountOdd) ;  // last cycle will be 1 or 2 words
  always @(posedge clk)
    begin
      dataCount <= ( reset_poweron                                                                                                              ) ? 'd0                                       :
//                   ( rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_WAIT                                  ) ? `MGR_EXEC_LANE_ID_WIDTH-1 'd0             :  
//                   ((rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_READ_DATA  ) && wr_destinations_ready ) ? dataCount + `MGR_EXEC_LANE_ID_WIDTH-1 'd1 :  // increment after we have transferred two words
                   ( rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_WAIT                                                           ) ? numLanesDiv2     :  
                   ((rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR    ) && wr_destinations_ready && from_wrPtrFifo_eom ) ? dataCount -  'd1 :  // starting data
                   ((rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_PAD_NOP       ) && wr_destinations_ready                       ) ? dataCount -  'd1 :  // starting data
                   ((rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_START_DATA    ) && wr_destinations_ready                       ) ? dataCount -  'd1 :  // increment after we have transferred two words
                   ((rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_READ_DATA     ) && wr_destinations_ready                       ) ? dataCount -  'd1 :  // increment after we have transferred two words
                   ((rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_TRANSFER_DATA ) && wr_destinations_ready                       ) ? dataCount -  'd1 :  // increment after we have transferred two words
                   ((rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_LAST_DATA     ) && wr_destinations_ready                       ) ? dataCount -  'd1 :  // increment after we have transferred two words
                                                                                                                                                    dataCount                                 ;
    end
  //--------------------------------------------------
  // Assumptions:
  //  - destination blocks can absorb entire transaction if they are ready e.g. we wont flow control during the transfer but once all destinations are ready
  //    the transfer(s) will run to completion
  
  always @(*)
    begin
      case (rdp_cntl_noc_data_packet_gen_state)
        
        // Wait for data from all the sources before transferring to NoC
        `RDP_CNTL_NOC_PKT_GEN_WAIT: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( from_Stuc_valid && from_NocInfoFifo_valid && (from_Stuc_tag != from_NocInfoFifo_tag) && cfg__rdp__check_tag) ?   `RDP_CNTL_NOC_PKT_GEN_TAG_ERR    :  // check tags
                                                     ( from_Stuc_valid && from_wrPtrFifo_valid   && from_NocInfoFifo_valid                                        ) ?   `RDP_CNTL_NOC_PKT_GEN_SEND_ADDR  :
                                                                                                                                                                        `RDP_CNTL_NOC_PKT_GEN_WAIT       ;

        // Transfer Header. Assert out_valid, set headerFields: {cntl=SOM, src=this.mgrId, prio=data, outDestType=bitfield, output=destAddr}, dont read addr pipe yet.
        `RDP_CNTL_NOC_PKT_GEN_SEND_ADDR: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( wr_destinations_ready ) ?   `RDP_CNTL_NOC_PKT_GEN_START_PTR  : // transfer header of packet
                                                                                   `RDP_CNTL_NOC_PKT_GEN_SEND_ADDR  ;


        // The destination bus is wide enough for extended tuples, so hold one in a register before sending two tuples

        // grab first ptr: 
        // a) if theres only one, then copy into output register and goto state=PAD_NOP to add 2nd NOP tuple and output the data.                Deassert out_valid, set fields: {cntl=MOM, type=descWrData, pType=tuples, prio=data, optionType0=storage, extdValue0=wrPtr}, read wrPtr pipe.
        // b) if theres more than one, then copy current into output register and goto state=APPEND_PTR to add another ptr and output the data.  Deassert out_valid, set fields: {cntl=MOM, type=descWrData, pType=tuples, prio=data, optionType0=storage, extdValue0=wrPtr}, read wrPtr pipe.
        `RDP_CNTL_NOC_PKT_GEN_START_PTR: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( wr_destinations_ready &&  from_wrPtrFifo_eom ) ?   `RDP_CNTL_NOC_PKT_GEN_PAD_NOP     :  // odd number of tuples so transfer will need to include NOP tuple type
                                                     ( wr_destinations_ready && ~from_wrPtrFifo_eom ) ?   `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR  :  // odd number of tuples so transfer will need to include NOP tuple type
                                                                                                          `RDP_CNTL_NOC_PKT_GEN_START_PTR   ;

        // Assert out_valid, set fields: {optionType1=storage, extdValue1=wr_ptr}, read wrPtr pipe.
        `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( wr_destinations_ready &&  from_wrPtrFifo_eom && (from_NocInfoFifo_numLanes == 'd0) ) ?   `RDP_CNTL_NOC_PKT_GEN_DATA_ERR      :   // no data??
                                                     ( wr_destinations_ready &&  from_wrPtrFifo_eom && lastDataCycle                      ) ?   `RDP_CNTL_NOC_PKT_GEN_LAST_DATA     :   // last cycle
                                                     ( wr_destinations_ready &&  from_wrPtrFifo_eom                                       ) ?   `RDP_CNTL_NOC_PKT_GEN_START_DATA    :
                                                     ( wr_destinations_ready && ~from_wrPtrFifo_eom                                       ) ?   `RDP_CNTL_NOC_PKT_GEN_TRANSFER_PTRS : 
                                                                                                                                                `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR    ;

        // grab addtional ptr: 
        // a) if its the last one, then copy into output register and goto state=PAD_NOP to add 2nd NOP tuple and output the data.               Deassert out_valid, set fields: {cntl=MOM, type=descWrData, pType=tuples, prio=data, optionType0=storage, extdValue0=wrPtr}, read wrPtr pipe.
        // b) if theres more to come, then copy current into output register and goto state=APPEND_PTR to add another ptr and output the data.   Deassert out_valid, set fields: {cntl=MOM, type=descWrData, pType=tuples, prio=data, optionType0=storage, extdValue0=wrPtr}, read wrPtr pipe.
        `RDP_CNTL_NOC_PKT_GEN_TRANSFER_PTRS: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( wr_destinations_ready &&  from_wrPtrFifo_eom ) ?   `RDP_CNTL_NOC_PKT_GEN_PAD_NOP       :  // odd number of tuples so transfer will need to include NOP tuple type
                                                     ( wr_destinations_ready && ~from_wrPtrFifo_eom ) ?   `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR    : 
                                                                                                          `RDP_CNTL_NOC_PKT_GEN_TRANSFER_PTRS ;
        // Add an extra NOP tuple to pad wide bus. Assert out_valid, set fields: {optionType1=NOP, extdValue1=0}.
        `RDP_CNTL_NOC_PKT_GEN_PAD_NOP: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( wr_destinations_ready &&  from_wrPtrFifo_eom && (from_NocInfoFifo_numLanes == 'd0) ) ?   `RDP_CNTL_NOC_PKT_GEN_DATA_ERR      :   // no data??
                                                     ( wr_destinations_ready &&  from_wrPtrFifo_eom && lastDataCycle                      ) ?   `RDP_CNTL_NOC_PKT_GEN_LAST_DATA     :   // last cycle
                                                     ( wr_destinations_ready                                                              ) ?   `RDP_CNTL_NOC_PKT_GEN_START_DATA :   // assume first chunk of data transferred on this transition
                                                                                                                                                `RDP_CNTL_NOC_PKT_GEN_PAD_NOP    ;

        // All states prior set dataCount=1. End-of-Data when dataCount=numLanes. We increment dataCount by 2 because there are two words per transfer, but use the lsb of numLanes to set pValid (e.g. if numLanes is odd, set last pValid=0 (~numLanes[0])
        // This is the drive first bus half so dont worry about stuc EOM yet
        // a) if we only need this transfer: Assert out_valid, set fields: {cntl=EOM, pValid=~numLanes[0], data=stucData[0], pType=data, prio=data}, DO NOT read stucData pipe
        // b) if we need more transfers    : Assert out_valid, set fields: {cntl=MOM, pValid=1,            data=stucData[0], pType=data, prio=data}, DO NOT read stucData pipe
        `RDP_CNTL_NOC_PKT_GEN_START_DATA: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( wr_destinations_ready &&  lastDataCycle      ) ?   `RDP_CNTL_NOC_PKT_GEN_LAST_DATA  : // if we are at stuc eom or not, let flush state deal with the reads
                                                     ( wr_destinations_ready                        ) ?   `RDP_CNTL_NOC_PKT_GEN_READ_DATA   : 
                                                                                                          `RDP_CNTL_NOC_PKT_GEN_START_DATA  ;
        // use the 2nd half of the stuc data and read next double word from the stuc fifo
        // a) if we only need this transfer: Assert out_valid, set fields: {cntl=EOM, pValid=~numLanes[0], data=stucData[0], pType=data, prio=data}, read stucData pipe
        // b) if we need more transfers    : Assert out_valid, set fields: {cntl=MOM, pValid=1,            data=stucData[0], pType=data, prio=data}, read stucData pipe
        `RDP_CNTL_NOC_PKT_GEN_READ_DATA  : 
          rdp_cntl_noc_data_packet_gen_state_next =  ( wr_destinations_ready && lastDataCycle  && ~from_Stuc_eom ) ?   `RDP_CNTL_NOC_PKT_GEN_LAST_DATA     :  // transferred enuff data and no more stuc data
                                                     ( wr_destinations_ready &&                    from_Stuc_eom ) ?   `RDP_CNTL_NOC_PKT_GEN_DATA_ERR      :  // not enuff data yet and no more stuc data
                                                     ( wr_destinations_ready                                     ) ?   `RDP_CNTL_NOC_PKT_GEN_TRANSFER_DATA : 
                                                                                                                       `RDP_CNTL_NOC_PKT_GEN_READ_DATA     ;

        // use the 1st half of the stuc data
        // a) if we only need this transfer: Assert out_valid, set fields: {cntl=EOM, pValid=~numLanes[0], data=stucData[0], pType=data, prio=data}, read stucData pipe
        // b) if we need more transfers    : Assert out_valid, set fields: {cntl=MOM, pValid=1,            data=stucData[0], pType=data, prio=data}, read stucData pipe
        `RDP_CNTL_NOC_PKT_GEN_TRANSFER_DATA: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( wr_destinations_ready &&  lastDataCycle      ) ?   `RDP_CNTL_NOC_PKT_GEN_LAST_DATA  : // if we are at stuc eom or not, let flush state deal with the reads
                                                     ( wr_destinations_ready                        ) ?   `RDP_CNTL_NOC_PKT_GEN_READ_DATA   : 
                                                                                                          `RDP_CNTL_NOC_PKT_GEN_TRANSFER_DATA  ;

        // Last cycle
        `RDP_CNTL_NOC_PKT_GEN_LAST_DATA: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( wr_destinations_ready ) ?   `RDP_CNTL_NOC_PKT_GEN_FLUSH_STUC  : // if we are at stuc eom or not, let flush state deal with the reads
                                                                                   `RDP_CNTL_NOC_PKT_GEN_LAST_DATA  ;

        // We have completed transferring packet so just loop reading stuc pipe
        `RDP_CNTL_NOC_PKT_GEN_FLUSH_STUC: 
          rdp_cntl_noc_data_packet_gen_state_next =  ( from_Stuc_eom ) ?   `RDP_CNTL_NOC_PKT_GEN_COMPLETE   :  
                                                                           `RDP_CNTL_NOC_PKT_GEN_FLUSH_STUC ;

        // read from_NocInfoFifo 
        `RDP_CNTL_NOC_PKT_GEN_COMPLETE: 
          rdp_cntl_noc_data_packet_gen_state_next =  `RDP_CNTL_NOC_PKT_GEN_WAIT              ;

        // Latch state on error
        `RDP_CNTL_NOC_PKT_GEN_TAG_ERR:
          rdp_cntl_noc_data_packet_gen_state_next = `RDP_CNTL_NOC_PKT_GEN_TAG_ERR ;
        `RDP_CNTL_NOC_PKT_GEN_DATA_ERR:
          rdp_cntl_noc_data_packet_gen_state_next = `RDP_CNTL_NOC_PKT_GEN_DATA_ERR ;
  
        default:
          rdp_cntl_noc_data_packet_gen_state_next = `RDP_CNTL_NOC_PKT_GEN_WAIT ;
    
      endcase // case (rdp_cntl_noc_data_packet_gen_state)
    end // always @ (*)
  

  assign  storagePtr_LocalFifo[0].pipe_read       = (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_START_PTR    ) & wr_destinations_ready |
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR   ) & wr_destinations_ready |
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_TRANSFER_PTRS) & wr_destinations_ready ;
                                                                                                    
  assign  from_Stuc_Fifo[0].pipe_read             = (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_READ_DATA    ) & wr_destinations_ready |
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_FLUSH_STUC   )                         ;  // if we are in FLUSH_STUC, we know the pipe is valid
                                                                                                    
  assign  storageDestAddr_LocalFifo[0].pipe_read  = (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_COMPLETE     )                         ;  // all done, clear info FIFO

  assign  wrDescOutputPkt_valid_e1                = (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_SEND_ADDR     ) & wr_destinations_ready |  
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR    ) & wr_destinations_ready |  
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_PAD_NOP       ) & wr_destinations_ready |
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_START_DATA    ) & wr_destinations_ready |
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_READ_DATA     ) & wr_destinations_ready |
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_TRANSFER_DATA ) & wr_destinations_ready |
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_LAST_DATA     ) & wr_destinations_ready ;

  assign  wrDescOutputPkt_cntl_e1                 = (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_SEND_ADDR     )  ? `COMMON_STD_INTF_CNTL_SOM  :   
                                                    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_LAST_DATA     )  ? `COMMON_STD_INTF_CNTL_EOM  :   
                                                                                                                                    `COMMON_STD_INTF_CNTL_MOM  ;

  reg      [`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] tuple_cycle_val0   ; // store lower tuple before reading second write pointer
  always @(posedge clk)
    begin
      tuple_cycle_val0   <= ((rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_START_PTR     ) & wr_destinations_ready ) ? from_WrPtrFifo_wrPtr :
                            ((rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_TRANSFER_PTRS ) & wr_destinations_ready ) ? from_WrPtrFifo_wrPtr :
                                                                                                                                      tuple_cycle_val0     ;
    end

  wire     [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  header_cycle_data_fields = from_NocInfoFifo_destAddr   ;
  wire     [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  tuple_cycle_data_fields  ;
  assign  tuple_cycle_data_fields [`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE    ]  =  PY_WU_INST_OPT_TYPE_MEMORY ;
  assign  tuple_cycle_data_fields [`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE  ]  =  tuple_cycle_val0     ;
  assign  tuple_cycle_data_fields [`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE    ]  =  (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_PAD_NOP) ? PY_WU_INST_OPT_TYPE_NOP    :  // there was an odd number of wr_ptr's
                                                                                                                                                                     PY_WU_INST_OPT_TYPE_MEMORY ;
  assign  tuple_cycle_data_fields [`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE  ]  =  (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_PAD_NOP) ? 'd0                        :  // there was an odd number of wr_ptr's
                                                                                                                                                                     from_WrPtrFifo_wrPtr       ;

  // When we are in the last data cycle, take the upper or lower of the 4 words based on the 2 LSB of numLanes
  // e.g. 001 -> lower, 010 -> lower, 011 -> upper, 100 -> upper  Note: 000 is invalid
  wire   [`STACK_UP_INTF_DATA_RANGE ]    from_Stuc_last_data  =  (from_NocInfoFifo_numLanes[1:0] == 'd1) ? from_Stuc_data[`STACK_UP_INTF_DATA_LOWER_HALF_RANGE ] :  // 1
                                                                 (from_NocInfoFifo_numLanes[1:0] == 'd2) ? from_Stuc_data[`STACK_UP_INTF_DATA_LOWER_HALF_RANGE ] :  // 2
                                                                 (from_NocInfoFifo_numLanes[1:0] == 'd3) ? from_Stuc_data[`STACK_UP_INTF_DATA_UPPER_HALF_RANGE ] :  // 3
                                                                                                           from_Stuc_data[`STACK_UP_INTF_DATA_UPPER_HALF_RANGE ] ;  // 4
                                                                                                    
  assign  wrDescOutputPkt_data_e1  =    (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_SEND_ADDR     ) ? header_cycle_data_fields :
                                        (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR    ) ? tuple_cycle_data_fields  :
                                        (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_PAD_NOP       ) ? tuple_cycle_data_fields  :
                                        (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_START_DATA    ) ? from_Stuc_data[`STACK_UP_INTF_DATA_LOWER_HALF_RANGE ] :
                                        (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_READ_DATA     ) ? from_Stuc_data[`STACK_UP_INTF_DATA_UPPER_HALF_RANGE ] :
                                        (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_TRANSFER_DATA ) ? from_Stuc_data[`STACK_UP_INTF_DATA_LOWER_HALF_RANGE ] :
                                        (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_LAST_DATA     ) ? from_Stuc_last_data                                       :
                                                                                                                       {`MGR_NOC_CONT_INTERNAL_DATA_WIDTH {1'b1}}                ;

  assign  wrDescOutputPkt_pvalid_e1  = (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_PAD_NOP    ) ? `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_ONE  :  // there was an odd number of wr_ptr's
                                       ((wrDescOutputPkt_cntl_e1 == `COMMON_STD_INTF_CNTL_EOM) && dataCountOdd ) ? `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_ONE  :  // there was an odd number of lanes activated
                                                                                                                   `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH ;                                                                                           

  assign  wrDescOutputPkt_type_e1     = `MGR_NOC_CONT_TYPE_DESC_WRITE_DATA          ; 
  assign  wrDescOutputPkt_desttype_e1 = `MGR_NOC_CONT_DESTINATION_ADDR_TYPE_BITMASK ; 

  assign  wrDescOutputPkt_ptype_e1   = (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_SEND_ADDR     ) ? `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_HEADER :
                                       (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_START_PTR     ) ? `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_TUPLES :
                                       (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR    ) ? `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_TUPLES :
                                       (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_TRANSFER_PTRS ) ? `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_TUPLES :
                                       (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_PAD_NOP       ) ? `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_TUPLES :
                                                                                                                      `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_DATA   ;

  //--------------------------------------------------
  // Connect to MWC and NoC based on whether there is a write pointer destined
  // for the local manager and/or another manager
  //
  // Remember for the packet to the NoC, deassert the bit that refers to this manager
  reg [`MGR_MGR_ID_BITMASK_RANGE      ] thisMgrBitMask       ; 

  `include "mgr_noc_cntl_create_thisMgr_bitmask_address.vh"


  assign      rdp__mwc__valid_e1         =  wrDescOutputPkt_valid_e1 & from_NocInfoFifo_oneIsLocal   ; 
  assign      rdp__mwc__cntl_e1          =  wrDescOutputPkt_cntl_e1   ; 
  assign      rdp__mwc__ptype_e1         =  wrDescOutputPkt_ptype_e1  ; 
  assign      rdp__mwc__pvalid_e1        =  wrDescOutputPkt_pvalid_e1 ; 
  assign      rdp__mwc__data_e1          =  wrDescOutputPkt_data_e1   ; 
                                         
  assign      rdp__noc__dp_valid_e1      =  wrDescOutputPkt_valid_e1 & from_NocInfoFifo_oneIsNotLocal   ; 
  assign      rdp__noc__dp_cntl_e1       =  wrDescOutputPkt_cntl_e1   ; 
  assign      rdp__noc__dp_type_e1       =  wrDescOutputPkt_type_e1   ; 
  assign      rdp__noc__dp_desttype_e1   =  wrDescOutputPkt_desttype_e1  ; 
  assign      rdp__noc__dp_ptype_e1      =  wrDescOutputPkt_ptype_e1  ; 
  assign      rdp__noc__dp_pvalid_e1     =  wrDescOutputPkt_pvalid_e1 ; 
  assign      rdp__noc__dp_data_e1       =  (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_SEND_ADDR ) ? (wrDescOutputPkt_data_e1  & ~thisMgrBitMask) :  // mask out this Manager bit in the address
                                                                                                                        wrDescOutputPkt_data_e1                     ;




  //------------------------------------------------------------------------------------------------------------------------
  // Temporary - FIXME
  //
  assign      rdp__noc__cp_valid_e1      = 'd0     ; 
  assign      rdp__noc__cp_cntl_e1       = 'd0     ;   
  assign      rdp__noc__cp_type_e1       = 'd0     ;   
  assign      rdp__noc__cp_desttype_e1   = 'd0     ;   
  assign      rdp__noc__cp_ptype_e1      = 'd0     ;   
  assign      rdp__noc__cp_pvalid_e1     = 'd0     ;   
  assign      rdp__noc__cp_data_e1       = 'd0     ;   




endmodule




