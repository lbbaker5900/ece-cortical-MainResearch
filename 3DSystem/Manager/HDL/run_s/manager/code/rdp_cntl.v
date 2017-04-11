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
`include "noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "wu_fetch.vh"
`include "wu_decode.vh"
`include "python_typedef.vh"
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
            sys__mgr__mgrId         ,
            clk                     ,
            reset_poweron    
 
    );

  //----------------------------------------------------------------------------------------------------
  // General

  input                                     clk                          ;
  input                                     reset_poweron                ;
  input   [`MGR_MGR_ID_RANGE    ]           sys__mgr__mgrId              ;


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
  // WU Decode and Stuc combine
  //
  wire                                     wud_data_available          ;
  wire                                     stuc_data_available         ;
  reg  [`MGR_EXEC_LANE_ID_RANGE       ]    num_of_valid_lanes          ;  // how many words are valid from stack upstream packet
  reg                                      write_storage_ptr_tmp_valid ;
  reg  [`COMMON_STD_INTF_CNTL_RANGE   ]    write_storage_ptr_tmp_cntl  ;
  reg  [`MGR_WU_EXTD_OPT_VALUE_RANGE  ]    write_storage_ptr_tmp       ;
  wire                                     wud_fifo_contains_wr_ptr    ;
  wire                                     wr_ptrs_all_sent            ;
  wire                                     data_all_sent               ;
  wire                                     start_of_wu_descriptor      ;  // dcntl == SOM
  wire                                     middle_of_wu_descriptor     ;  // dcntl == MOM
  wire                                     end_of_wu_descriptor        ;  // dcntl == EOM

  //-------------------------------------------------------------------------------------------------
  // NoC interface
  //
  // Control-Path (cp) to NoC 
  wire                                            noc__rdp__cp_ready      ; 
  wire [`COMMON_STD_INTF_CNTL_RANGE             ] rdp__noc__cp_cntl       ; 
  wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] rdp__noc__cp_type       ; 
  wire [`PE_NOC_INTERNAL_DATA_RANGE             ] rdp__noc__cp_data       ; 
  wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] rdp__noc__cp_laneId     ; 
  wire                                            rdp__noc__cp_strmId     ; 
  wire                                            rdp__noc__cp_valid      ; 
  
  // Data-Path (dp) to NoC
  wire                                            noc__rdp__dp_ready      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE             ] rdp__noc__dp_cntl       ; 
  reg  [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] rdp__noc__dp_type       ; 
  reg  [`PE_PE_ID_RANGE                         ] rdp__noc__dp_peId       ; 
  reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] rdp__noc__dp_laneId     ; 
  reg                                             rdp__noc__dp_strmId     ; 
  reg  [`STREAMING_OP_CNTL_DATA_RANGE           ] rdp__noc__dp_data       ; 
  reg                                             rdp__noc__dp_valid      ; 


  reg                                             noc__rdp__dp_ready_d1   ; 
  wire [`COMMON_STD_INTF_CNTL_RANGE             ] rdp__noc__dp_cntl_e1    ; 
  wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] rdp__noc__dp_type_e1    ; 
  wire [`PE_PE_ID_RANGE                         ] rdp__noc__dp_peId_e1    ; 
  wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] rdp__noc__dp_laneId_e1  ; 
  wire                                            rdp__noc__dp_strmId_e1  ; 
  wire [`STREAMING_OP_CNTL_DATA_RANGE           ] rdp__noc__dp_data_e1    ; 
  wire                                            rdp__noc__dp_valid_e1   ; 

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
      noc__rdp__dp_ready_d1        <= ( reset_poweron   ) ? 'd0  :  noc__rdp__dp_ready       ;
      rdp__noc__dp_cntl            <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_cntl_e1     ;
      rdp__noc__dp_type            <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_type_e1     ;
      rdp__noc__dp_peId            <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_peId_e1     ;
      rdp__noc__dp_laneId          <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_laneId_e1   ;
      rdp__noc__dp_strmId          <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_strmId_e1   ;
      rdp__noc__dp_data            <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_data_e1     ;
      rdp__noc__dp_valid           <= ( reset_poweron   ) ? 'd0  :  rdp__noc__dp_valid_e1    ;
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
        reg    [`MGR_STD_OOB_TAG_RANGE          ]         read_tag            ;
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
                        ) instr_fifo (
                                          // Status
                                         .empty            ( empty                                                ),
                                         .almost_full      ( almost_full                                          ),
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
        reg    [`MGR_STD_OOB_TAG_RANGE          ]         read_tag           ;
        reg    [`STACK_UP_INTF_DATA_RANGE       ]         read_data          ;

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
                        ) instr_fifo (
                                          // Status
                                         .empty            ( empty                                     ),
                                         .almost_full      ( almost_full                               ),
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
          rdp_cntl_tag_data_combine_state_next =  ( wud_fifo_contains_wr_ptr && start_of_wu_descriptor) ? `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR      :  // First cycle contains wr_ptr
                                                  ( wud_data_available       && start_of_wu_descriptor) ? `RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_DATA  :  // First cycle doesnt contain wr_ptr
                                                  ( wud_data_available                                ) ? `RDP_CNTL_TAG_DATA_COMBINE_ERR               :  // wu descriptor always more than 1-cycle
                                                                                                          `RDP_CNTL_TAG_DATA_COMBINE_WAIT              ;

        // Read the {option, value} tuples from the WU Decoder so we can form a destination bitfield for the NoC and prepare for stack upstream data
        // FIXME: We will likely have to save a MW pointer for each PE, so assume we need to remove 64 storage pointers from the WU decode FIFO and store locally
        // if tuple contains wr_ptr and dcntl==EOM, then store wr_ptr in local fifo with cntl=SOM_EOM
        `RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_DATA: 
          rdp_cntl_tag_data_combine_state_next =  ( wud_fifo_contains_wr_ptr && end_of_wu_descriptor   ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :  // There is only one wr_ptr, put tmp ptr into local FIFO
                                                  ( wud_fifo_contains_wr_ptr                           ) ? `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR     :
                                                  ( wud_data_available                                 ) ? `RDP_CNTL_TAG_DATA_COMBINE_WAIT_FOR_WR_PTR  :  // data available but no wr_ptr
                                                                                                           `RDP_CNTL_TAG_DATA_COMBINE_WAIT             ;

        `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR: 
          rdp_cntl_tag_data_combine_state_next =  ( wud_fifo_contains_wr_ptr && end_of_wu_descriptor   ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :  // There is only one wr_ptr, put tmp ptr into local FIFO
                                                  ( wud_fifo_contains_wr_ptr                           ) ? `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      :
                                                  ( wud_data_available                                 ) ? `RDP_CNTL_TAG_DATA_COMBINE_WAIT_FOR_WR_PTR  :  // data available but no wr_ptr
                                                                                                           `RDP_CNTL_TAG_DATA_COMBINE_WAIT             ;

        // Hold wr_ptr, if we dont get another wr_ptr, write to local fifo with cntl=SOM_EOM, if we see another wr_ptr with dcntl=EOM, save held wr_ptr
        // with cntl=SOM and then store current wr_ptr with cntl=EOM. If we get another wr_ptr without dcntl=EOM, store held wr_ptr and hold current wr_ptr
        `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR: 
          rdp_cntl_tag_data_combine_state_next =  ( wud_fifo_contains_wr_ptr && end_of_wu_descriptor    ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :
                                                  ( wud_fifo_contains_wr_ptr && middle_of_wu_descriptor ) ? `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      :
                                                  ( wud_data_available       && end_of_wu_descriptor    ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :  // EOD and no wr_ptr
                                                  ( wud_data_available       && middle_of_wu_descriptor ) ? `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      :  // MOD and no wr_ptr
                                                                                                            `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      ;
        `RDP_CNTL_TAG_DATA_COMBINE_WAIT_FOR_WR_PTR: 
          rdp_cntl_tag_data_combine_state_next =  ( wud_fifo_contains_wr_ptr && end_of_wu_descriptor    ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :  // EOD and has wr_ptr
                                                  ( wud_fifo_contains_wr_ptr && middle_of_wu_descriptor ) ? `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      :  // MOD and has wr_ptr
                                                  ( wud_data_available       && end_of_wu_descriptor    ) ? `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE :  // EOD and no wr_ptr
                                                  ( wud_data_available       && middle_of_wu_descriptor ) ? `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      :  // MOD and no wr_ptr
                                                                                                            `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR      ;
        // need to find num_lanes and all write pointers
        //  - the write pointers will be written to a local fifo. We dont know how many there are so pause on each mem ptr so we can check if another is coming before writing the CNTL field
        //  - in this state, we write the final ptr if the tmp storage is valid
        `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE: 
          rdp_cntl_tag_data_combine_state_next =   `RDP_CNTL_TAG_DATA_COMBINE_BUILD_NOC_PKT ;
        
        `RDP_CNTL_TAG_DATA_COMBINE_BUILD_NOC_PKT: 
          rdp_cntl_tag_data_combine_state_next =  ( noc__rdp__dp_ready_d1 ) ? `RDP_CNTL_TAG_DATA_COMBINE_SEND_BITFIELD  :
                                                                              `RDP_CNTL_TAG_DATA_COMBINE_BUILD_NOC_PKT  ;
        
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


  assign from_WuDecode_Fifo[0].pipe_read =   wud_data_available && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WAIT            ) |  
                                             wud_data_available && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_DATA) |  
                                             wud_data_available && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WAIT_FOR_WR_PTR ) |  
                                             wud_data_available && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR     ) ;  

  always @(posedge clk)
    begin
      write_storage_ptr_tmp_valid <=  ( reset_poweron                                                                                          ) ? 1'b0                        :
                                      ( wud_fifo_contains_wr_ptr && from_WuDecode_Fifo[0].pipe_read                                            ) ? 1'b1                        :
                                      (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE                          ) ? 1'b0                        :
                                                                                                                                                   write_storage_ptr_tmp_valid ;

      write_storage_ptr_tmp_cntl  <=  ( reset_poweron                                                                                                                      ) ? `COMMON_STD_INTF_CNTL_SOM      :  
                                      ( wud_fifo_contains_wr_ptr &&                          (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WAIT           )) ? `COMMON_STD_INTF_CNTL_SOM     :
                                      ( wud_fifo_contains_wr_ptr &&  end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR   )) ? `COMMON_STD_INTF_CNTL_EOM     :
                                      ( wud_data_available       &&  end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR   )) ? `COMMON_STD_INTF_CNTL_SOM_EOM :
                                      ( wud_fifo_contains_wr_ptr &&  end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR    )) ? `COMMON_STD_INTF_CNTL_EOM     :
                                      ( wud_fifo_contains_wr_ptr && ~end_of_wu_descriptor && (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR    )) ? `COMMON_STD_INTF_CNTL_MOM     :
                                                                                                                                                                                 write_storage_ptr_tmp_cntl   ;
    end



  assign from_Stuc_Fifo[0].pipe_read     = stuc_data_available              ;


  assign wud_data_available              = from_WuDecode_Fifo[0].pipe_valid ;
  assign stuc_data_available             = from_Stuc_Fifo[0].pipe_valid     ;


  //----------------------------------------------------------------------------------------------------
  // Local Memory Write Tuple storage
  //

  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: storagePtr_LocalFifo

        // Write data
        // Need cntl because number of write storage ptrs per descriptor varies
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_cntl         ;
        reg    [`MGR_WU_EXTD_OPT_VALUE_RANGE    ]         write_storage_ptr  ;
                                                                             
        // Read data                                                         
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_cntl          ;
        wire   [`MGR_WU_EXTD_OPT_VALUE_RANGE    ]         read_storage_ptr   ;
                                                                             
        // Control                                                           
        wire                                              clear              ; 
        wire                                              empty              ; 
        wire                                              almost_full        ; 
        wire                                              read               ; 
        wire                                              write              ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`RDP_CNTL_WU_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`RDP_CNTL_WU_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_WU_EXTD_OPT_VALUE_WIDTH)
                        ) instr_fifo (
                                          // Status
                                         .empty            ( empty                      ),
                                         .almost_full      ( almost_full                ),
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
        reg    [`MGR_WU_EXTD_OPT_VALUE_RANGE    ]            pipe_storage_ptr  ;
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

  // write to the local ptr fifo if the tmp reg is valid and we are about to reload the tmp reg
  assign storagePtr_LocalFifo[0].write   =   write_storage_ptr_tmp_valid  & wud_fifo_contains_wr_ptr                                                                                    |
                                             write_storage_ptr_tmp_valid  &                          & (rdp_cntl_tag_data_combine_state == `RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE) ;

  assign storagePtr_LocalFifo[0].write_cntl         = write_storage_ptr_tmp_cntl ;
  assign storagePtr_LocalFifo[0].write_storage_ptr  = write_storage_ptr_tmp      ;
  

  // Write to local storage pointer FIFO
  `include "rdp_cntl_option_tuple_extract.vh"

  assign from_WuDecode_Fifo[0].pipe_read   = from_WuDecode_Fifo[0].pipe_valid & from_Stuc_Fifo[0].pipe_valid     ;

  assign storagePtr_LocalFifo[0].pipe_read = 1'b1 ;
         
  assign rdp__wud__ready_e1              = ~from_WuDecode_Fifo[0].almost_full  ;





  assign  rdp__noc__cp_valid    = 1'b0      ; 
  assign  rdp__noc__dp_valid_e1 = 1'b0      ; 

endmodule

/*
typedef enum logic [2 :0] { 
                   PY_WU_INST_OPT_TYPE_NOP      =  0, 
                   PY_WU_INST_OPT_TYPE_SRC      =  1, 
                   PY_WU_INST_OPT_TYPE_TGT      =  2, 
                   PY_WU_INST_OPT_TYPE_TXFER    =  3, 
                   PY_WU_INST_OPT_TYPE_NUM_OF_LANES =  4, 
                   PY_WU_INST_OPT_TYPE_STOP     =  5, 
                   PY_WU_INST_OPT_TYPE_SIMDOP   =  6, 
                   PY_WU_INST_OPT_TYPE_MEMORY   =  7 
                           } python_option_type ; 

*/



