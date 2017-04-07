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
`include "wu_fetch.vh"
`include "wu_cntl.vh"
`include "rdp_cntl.vh"




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
            // NoC interface
            //
            // Control-Path (cp) to NoC 
            noc__rdp__cp_ready      , 
            rdp__noc__cp_cntl       , 
            rdp__noc__cp_type       , 
            rdp__noc__cp_data       , 
            rdp__noc__cp_laneId     , 
            rdp__noc__cp_strmId     , 
            rdp__noc__cp_valid      , 
            // Data-Path (dp) to NoC 
            noc__rdp__dp_ready      , 
            rdp__noc__dp_cntl       , 
            rdp__noc__dp_type       , 
            rdp__noc__dp_peId       , 
            rdp__noc__dp_laneId     , 
            rdp__noc__dp_strmId     , 
            rdp__noc__dp_data       , 
            rdp__noc__dp_valid      , 

            //-------------------------------
            // General
            //
            clk              ,
            reset_poweron    
 
    );

  //----------------------------------------------------------------------------------------------------
  // General

  input                                           clk                          ;
  input                                           reset_poweron                ;


  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //
  input                                          stuc__rdp__valid       ;
  input   [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rdp__cntl        ;
  output                                         rdp__stuc__ready       ;
  input   [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rdp__tag         ;  // tag size is the same as sent to PE
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





  //-------------------------------------------------------------------------------------------------
  // NoC interface
  //
  // Control-Path (cp) to NoC '
  input                                             noc__rdp__cp_ready      ; 
  output [`COMMON_STD_INTF_CNTL_RANGE             ] rdp__noc__cp_cntl       ; 
  output [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] rdp__noc__cp_type       ; 
  output [`PE_NOC_INTERNAL_DATA_RANGE             ] rdp__noc__cp_data       ; 
  output [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] rdp__noc__cp_laneId     ; 
  output                                            rdp__noc__cp_strmId     ; 
  output                                            rdp__noc__cp_valid      ; 
  
  // Data-Path (dp) to NoC '
  input                                             noc__rdp__dp_ready      ; 
  output [`COMMON_STD_INTF_CNTL_RANGE             ] rdp__noc__dp_cntl       ; 
  output [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] rdp__noc__dp_type       ; 
  output [`PE_PE_ID_RANGE                         ] rdp__noc__dp_peId       ; 
  output [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] rdp__noc__dp_laneId     ; 
  output                                            rdp__noc__dp_strmId     ; 
  output [`STREAMING_OP_CNTL_DATA_RANGE           ] rdp__noc__dp_data       ; 
  output                                            rdp__noc__dp_valid      ; 


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
  // NoC interface
  //
  // Control-Path (cp) to NoC '
  wire                                            noc__rdp__cp_ready      ; 
  wire [`COMMON_STD_INTF_CNTL_RANGE             ] rdp__noc__cp_cntl       ; 
  wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] rdp__noc__cp_type       ; 
  wire [`PE_NOC_INTERNAL_DATA_RANGE             ] rdp__noc__cp_data       ; 
  wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] rdp__noc__cp_laneId     ; 
  wire                                            rdp__noc__cp_strmId     ; 
  wire                                            rdp__noc__cp_valid      ; 
  
  // Data-Path (dp) to NoC '
  wire                                            noc__rdp__dp_ready      ; 
  wire [`COMMON_STD_INTF_CNTL_RANGE             ] rdp__noc__dp_cntl       ; 
  wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] rdp__noc__dp_type       ; 
  wire [`PE_PE_ID_RANGE                         ] rdp__noc__dp_peId       ; 
  wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] rdp__noc__dp_laneId     ; 
  wire                                            rdp__noc__dp_strmId     ; 
  wire [`STREAMING_OP_CNTL_DATA_RANGE           ] rdp__noc__dp_data       ; 
  wire                                            rdp__noc__dp_valid      ; 

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
                                                                                         
      wud__rdp__valid_d1         <= ( reset_poweron   ) ? 'd0  :  wud__rdp__valid        ;
      wud__rdp__cntl_d1          <= ( reset_poweron   ) ? 'd0  :  wud__rdp__cntl         ;
      rdp__wud__ready            <= ( reset_poweron   ) ? 'd0  :  rdp__wud__ready_e1     ;
      wud__rdp__type_d1          <= ( reset_poweron   ) ? 'd0  :  wud__rdp__type         ;
      wud__rdp__tag_d1           <= ( reset_poweron   ) ? 'd0  :  wud__rdp__tag          ;
      wud__rdp__mem_desc_ptr_d1  <= ( reset_poweron   ) ? 'd0  :  wud__rdp__mem_desc_ptr ;
      wud__rdp__num_words_d1     <= ( reset_poweron   ) ? 'd0  :  wud__rdp__num_words    ;

    end




endmodule





