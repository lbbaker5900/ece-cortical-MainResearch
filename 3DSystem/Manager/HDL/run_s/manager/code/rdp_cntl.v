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
            wuc__rdp__valid         ,
            wuc__rdp__cntl          ,  // used to delineate WU packet
            rdp__wuc__ready         ,
            wuc__rdp__type          ,  // e.g. memory write
            //wuc__rdp__tag           ,  // Use this to match with WU and take all the data 
            wuc__rdp__mem_desc_ptr  ,  // memory descriptor pointer
            wuc__rdp__num_words     ,  // How many words in the upstream packet are valid

            //-------------------------------
            // Input from OOB downstream controller
            //
            odc__rdp__valid         ,
            odc__rdp__cntl          ,  // used to delineate WU packet
            rdp__odc__ready         ,
            odc__rdp__tag           ,  // ODC generates tag once packet sent

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
  // Work Unit controller interface
  //
  input                                          wuc__rdp__valid         ;
  input   [`COMMON_STD_INTF_CNTL_RANGE    ]      wuc__rdp__cntl          ;
  output                                         rdp__wuc__ready         ;
  input   [`WU_CNTL_TYPE_RANGE            ]      wuc__rdp__type          ;  // e.g. memory write
  input   [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      wuc__rdp__tag           ;  // tag size is the same as sent to PE
  input   [`WU_CNTL_MEMORY_PTR_RANGE      ]      wuc__rdp__mem_desc_ptr  ;  // memory descriptor pointer. All the memory descriptor pointers will be collected to form the local memory write and/or NoC packet
  input   [`WU_CNTL_NUM_WORDS_RANGE       ]      wuc__rdp__num_words     ;  // How many words in the upstream packet are valid


  //-------------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream controller
  //
  input                                          odc__rdp__valid       ;
  input   [`COMMON_STD_INTF_CNTL_RANGE    ]      odc__rdp__cntl        ;
  output                                         rdp__odc__ready       ;
  input   [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      odc__rdp__tag         ;  // tag size is the same as sent to PE
 


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
  // Work Unit controller interface
  //
  wire                                           wuc__rdp__valid            ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE    ]      wuc__rdp__cntl             ;
  reg                                            rdp__wuc__ready            ;
  wire    [`WU_CNTL_TYPE_RANGE            ]      wuc__rdp__type             ;  // e.g. memory write
  wire    [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      wuc__rdp__tag              ;  // Use this to match with WU and take all the data 
  wire    [`WU_CNTL_MEMORY_PTR_RANGE      ]      wuc__rdp__mem_desc_ptr     ;  // memory descriptor pointer
  wire    [`WU_CNTL_NUM_WORDS_RANGE       ]      wuc__rdp__num_words        ;  // How many words in the upstream packet are valid

  reg                                            wuc__rdp__valid_d1         ;
  reg     [`COMMON_STD_INTF_CNTL_RANGE    ]      wuc__rdp__cntl_d1          ;
  wire                                           rdp__wuc__ready_e1         ;
  reg     [`WU_CNTL_TYPE_RANGE            ]      wuc__rdp__type_d1          ;  // e.g. memory write
  reg     [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      wuc__rdp__tag_d1           ;  // Use this to match with WU and take all the data 
  reg     [`WU_CNTL_MEMORY_PTR_RANGE      ]      wuc__rdp__mem_desc_ptr_d1  ;  // memory descriptor pointer
  reg     [`WU_CNTL_NUM_WORDS_RANGE       ]      wuc__rdp__num_words_d1     ;  // How many words in the upstream packet are valid


  //-------------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream controller
  //
  wire                                           odc__rdp__valid       ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE    ]      odc__rdp__cntl        ;
  wire                                           rdp__odc__ready       ;
  wire    [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      odc__rdp__tag         ;  // tag size is the same as sent to PE
 
  reg                                            odc__rdp__valid_d1       ;
  reg     [`COMMON_STD_INTF_CNTL_RANGE    ]      odc__rdp__cntl_d1        ;
  wire                                           rdp__odc__ready_e1       ;
  reg     [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      odc__rdp__tag_d1         ;  // tag size is the same as sent to PE
 
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
                                                                                         
      wuc__rdp__valid_d1         <= ( reset_poweron   ) ? 'd0  :  wuc__rdp__valid        ;
      wuc__rdp__cntl_d1          <= ( reset_poweron   ) ? 'd0  :  wuc__rdp__cntl         ;
      rdp__wuc__ready            <= ( reset_poweron   ) ? 'd0  :  rdp__wuc__ready_e1     ;
      wuc__rdp__type_d1          <= ( reset_poweron   ) ? 'd0  :  wuc__rdp__type         ;
      wuc__rdp__tag_d1           <= ( reset_poweron   ) ? 'd0  :  wuc__rdp__tag          ;
      wuc__rdp__mem_desc_ptr_d1  <= ( reset_poweron   ) ? 'd0  :  wuc__rdp__mem_desc_ptr ;
      wuc__rdp__num_words_d1     <= ( reset_poweron   ) ? 'd0  :  wuc__rdp__num_words    ;

    end


  always @(posedge clk)
    begin
      odc__rdp__valid_d1         <= ( reset_poweron   ) ? 'd0  :  odc__rdp__valid        ;
      odc__rdp__cntl_d1          <= ( reset_poweron   ) ? 'd0  :  odc__rdp__cntl         ;
      rdp__odc__ready            <= ( reset_poweron   ) ? 'd0  :  rdp__odc__ready_e1     ;
      odc__rdp__tag_d1           <= ( reset_poweron   ) ? 'd0  :  odc__rdp__tag          ;
    end

  //----------------------------------------------------------------------------------------------------
  // Upstream Input FIFO
  //

  // Put in a generate in case we decide to extend to multiple upstream lanes

  genvar gvi;
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Wuc_Fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_cntl          ;
        wire   [`WU_CNTL_TYPE_RANGE             ]         write_type          ;  // e.g. memory write
        wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]         write_tag           ;  // Use this to match with WU and take all the data 
        wire   [`WU_CNTL_MEMORY_PTR_RANGE       ]         write_mem_desc_ptr  ;  // memory descriptor pointer
        wire   [`WU_CNTL_NUM_WORDS_RANGE        ]         write_num_words     ;  // How many words in the upstream packet are valid
                                                                           
        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_cntl           ;
        wire   [`WU_CNTL_TYPE_RANGE             ]         read_type           ; 
        wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]         read_tag            ; 
        wire   [`WU_CNTL_MEMORY_PTR_RANGE       ]         read_mem_desc_ptr   ; 
        wire   [`WU_CNTL_NUM_WORDS_RANGE        ]         read_num_words      ; 

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`RDP_CNTL_RX_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`RDP_CNTL_RX_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`WU_CNTL_TYPE_WIDTH+`STACK_DOWN_OOB_INTF_TAG_WIDTH+`WU_CNTL_MEMORY_PTR_WIDTH+`WU_CNTL_NUM_WORDS_WIDTH )
                        ) stu_rx_fifo (
                                          // Status
                                         .empty            ( empty                                                                     ),
                                         .almost_full      ( almost_full                                                               ),
                                          // Write                                                                                     
                                         .write            ( write                                                                     ),
                                         .write_data       ( {write_cntl, write_type, write_tag, write_mem_desc_ptr, write_num_words } ),
                                          // Read                                    
                                         .read             ( read                                                                      ),
                                         .read_data        ( {read_cntl, read_type, read_tag, read_mem_desc_ptr, read_num_words      } ),

                                         // General
                                         .clear            ( clear                                                                     ),
                                         .reset_poweron    ( reset_poweron                                                             ),
                                         .clk              ( clk                                                                       )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_cntl         ;
        reg    [`WU_CNTL_TYPE_RANGE             ]            pipe_type         ; 
        reg    [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]            pipe_tag          ; 
        reg    [`WU_CNTL_MEMORY_PTR_RANGE       ]            pipe_mem_desc_ptr ; 
        reg    [`WU_CNTL_NUM_WORDS_RANGE        ]            pipe_num_words    ; 
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
            pipe_valid         <= ( reset_poweron      ) ? 'b0                :
                                  ( fifo_pipe_read     ) ? 'b1                :
                                  ( pipe_read          ) ? 'b0                :
                                                            pipe_valid        ;
                                                                              
            // if we are reading, transfer from previous pipe stage.          
            pipe_cntl          <= ( fifo_pipe_read     ) ? read_cntl          :
                                                           pipe_cntl          ;
            pipe_type          <= ( fifo_pipe_read     ) ? read_type          :
                                                           pipe_type          ;
            pipe_tag           <= ( fifo_pipe_read     ) ? read_tag           :
                                                           pipe_tag           ;
            pipe_mem_desc_ptr  <= ( fifo_pipe_read     ) ? read_mem_desc_ptr  :
                                                           pipe_mem_desc_ptr  ;
            pipe_num_words     <= ( fifo_pipe_read     ) ? read_num_words     :
                                                           pipe_num_words     ;
          end

      end
  endgenerate


  //----------------------------------------------------------------------------------------------------
  // Upstream Packet Processing FSM
  //

  reg [`RDP_CNTL_RX_CNTL_STATE_RANGE ] rdp_cntl_rx_cntl_state      ; // state flop
  reg [`RDP_CNTL_RX_CNTL_STATE_RANGE ] rdp_cntl_rx_cntl_state_next ;
  
  

  // State register 
  always @(posedge clk)
    begin
      rdp_cntl_rx_cntl_state <= ( reset_poweron ) ? `RDP_CNTL_RX_CNTL_WAIT       :
                                                    rdp_cntl_rx_cntl_state_next  ;
    end
  
  // Every cycle of the OOB packet, examine each {option, value} tuple and set local config
  // Once the packet has completed, initiate the command.
  // Note: a) we might choose to start commands such as stOp as soon as the tuple is observed
  //       b) FIXME:There is currentlyno checking to see if a option is repeated or if an option is invalid
  //       c) Make error checking more robust as this is an external interface
  //
  //       FIXME: I am adding what might be redundant states as I suspect coordinating stOp's and SIMD might take a few states
 
  always @(*)
    begin
      case (rdp_cntl_rx_cntl_state)

        
        `RDP_CNTL_RX_CNTL_WAIT: 
          rdp_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `RDP_CNTL_RX_CNTL_SOM          :  // start processing command
                                         ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `RDP_CNTL_RX_CNTL_START        :  // initiate command
                                         ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `RDP_CNTL_RX_CNTL_ERR          :  // error
                                         ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `RDP_CNTL_RX_CNTL_ERR          :  // error
                                                                                                                                           `RDP_CNTL_RX_CNTL_WAIT         ;
  

        `RDP_CNTL_RX_CNTL_SOM: // start of message
          rdp_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `RDP_CNTL_RX_CNTL_MOM          :  // continue processing command
                                         ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `RDP_CNTL_RX_CNTL_START        :  // initiate command
                                         ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `RDP_CNTL_RX_CNTL_ERR          :  // error
                                         ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `RDP_CNTL_RX_CNTL_ERR          :  // error
                                                                                                                                           `RDP_CNTL_RX_CNTL_SOM          ;

        `RDP_CNTL_RX_CNTL_MOM: // middle of message
          rdp_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `RDP_CNTL_RX_CNTL_MOM          :  // continue processing command
                                         ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `RDP_CNTL_RX_CNTL_START        :  // initiate command
                                         ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `RDP_CNTL_RX_CNTL_ERR          :  // error
                                         ( from_Stu_Fifo[0].pipe_valid && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `RDP_CNTL_RX_CNTL_ERR          :  // error
                                                                                                                                           `RDP_CNTL_RX_CNTL_SOM          ;


        // Transition directly to wait complete so this will create a pulse and the option tuple has been latched
        // This state generates a pulse, so beware of adding conditions
        `RDP_CNTL_RX_CNTL_START    :
          rdp_cntl_rx_cntl_state_next =   `RDP_CNTL_RX_CNTL_OP_RUNNING ;  // 

        // make sure the operations have started to allow for some time for simd and/or stOp to get started
        `RDP_CNTL_RX_CNTL_OP_RUNNING:
          rdp_cntl_rx_cntl_state_next =   ( stOp_complete            ) ? `RDP_CNTL_RX_CNTL_WAIT_COMPLETE_DEASSERTED  :  // 
                                                                            `RDP_CNTL_RX_CNTL_OP_RUNNING     ;  // 

        `RDP_CNTL_RX_CNTL_WAIT_COMPLETE_DEASSERTED:
          rdp_cntl_rx_cntl_state_next =   ( stOp_complete            ) ? `RDP_CNTL_RX_CNTL_WAIT_COMPLETE_DEASSERTED         :  // 
                                                                            `RDP_CNTL_RX_CNTL_COMPLETE    ;  // 

        `RDP_CNTL_RX_CNTL_COMPLETE:
          rdp_cntl_rx_cntl_state_next =   ( simd__cntl__tag_ready_d1 ) ? `RDP_CNTL_RX_CNTL_WAIT        :  // 
                                                                            `RDP_CNTL_RX_CNTL_COMPLETE    ;  // if the simd isnt ready for the tag, dont perform the next operation

        // Latch state on error
        `RDP_CNTL_RX_CNTL_ERR:
          rdp_cntl_rx_cntl_state_next = `RDP_CNTL_RX_CNTL_ERR ;
  
        default:
          rdp_cntl_rx_cntl_state_next = `RDP_CNTL_RX_CNTL_WAIT ;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //
  assign from_Stu_Fifo[0].pipe_read   =   (rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_WAIT) & from_Stu_Fifo[0].pipe_valid |
                                          (rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_SOM ) & from_Stu_Fifo[0].pipe_valid |
                                          (rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_MOM ) & from_Stu_Fifo[0].pipe_valid ;


  always @(*)
    begin
  
      start_stOp_operation    = (rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_START                   ) & contained_stOp ;
      stop_stOp_operation     = (rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_WAIT_COMPLETE_DEASSERTED) & contained_stOp ;
      start_simd_operation    = (rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_START                   ) & contained_simd ;
      stop_simd_operation     = (rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_WAIT_COMPLETE_DEASSERTED) & contained_simd ;

    end

  // examine {option, value} tuples and set local fields
  always @(posedge clk)
    begin
      contained_stOp           <=  ( reset_poweron                                                                                                               ) ? 1'b0           :
                                   ( from_Stu_Fifo[0].pipe_valid  && (from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION0_RANGE] == STD_PACKET_OOB_OPT_STOP_CMD)) ? 1'b1           :
                                   ( from_Stu_Fifo[0].pipe_valid  && (from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION1_RANGE] == STD_PACKET_OOB_OPT_STOP_CMD)) ? 1'b1           :
                                   ((rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_COMPLETE                                                                 )) ? 1'b0           :  // clear when packet and operation complete
                                                                                                                                                                     contained_stOp ;

      // FIXME
      contained_simd           <=  ( reset_poweron                                                                                                               ) ? 1'b0           :
                                                                                                                                                                     contained_simd ;

      // pointer to stOp operation control memory
      stOp_optionPtr           <=  ( reset_poweron                                                                                                               ) ?  'd0                                                            :
                                   ( from_Stu_Fifo[0].pipe_valid  && (from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION0_RANGE] == STD_PACKET_OOB_OPT_STOP_CMD)) ? from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION0_DATA_RANGE] :
                                   ( from_Stu_Fifo[0].pipe_valid  && (from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION1_RANGE] == STD_PACKET_OOB_OPT_STOP_CMD)) ? from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION1_DATA_RANGE] :
                                                                                                                                                                     stOp_optionPtr                                                  ;

      // FIXME
      simd_optionPtr           <=  ( reset_poweron                                                                                                               ) ?  'd0                                                       :
                                                                                                                                                                     simd_optionPtr                                             ;

      tag                      <=  ( reset_poweron                                                                                                               ) ?  'd0                                                            :
                                   ( from_Stu_Fifo[0].pipe_valid  && (from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION0_RANGE] ==  STD_PACKET_OOB_OPT_TAG )) ? from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION0_DATA_RANGE] :
                                   ( from_Stu_Fifo[0].pipe_valid  && (from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION1_RANGE] ==  STD_PACKET_OOB_OPT_TAG )) ? from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION1_DATA_RANGE] :
                                                                                                                                                                     tag                                                             ;

      // if we dont get a number of active lanes, assume all are active, set all active at begining of oob packet
      numberOfActiveLanes      <=  ( reset_poweron                                                                                                                     ) ?  { `PE_NUM_OF_EXEC_LANES {1'b1}}                                :
                                   ( oob_packet_starting                                                                                                               ) ?  { `PE_NUM_OF_EXEC_LANES {1'b1}}                                :
                                   ( from_Stu_Fifo[0].pipe_valid  && (from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION0_RANGE] == STD_PACKET_OOB_OPT_NUM_LANES  )) ? from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION0_DATA_RANGE] :
                                   ( from_Stu_Fifo[0].pipe_valid  && (from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION1_RANGE] == STD_PACKET_OOB_OPT_NUM_LANES  )) ? from_Stu_Fifo[0].pipe_data[`RDP_CNTL_OOB_OPTION1_DATA_RANGE] :
                                                                                                                                                                           numberOfActiveLanes                                             ;


    end

  // activate lanes. Number of lanes start from '0'
  always @(*)
    begin
      case(numberOfActiveLanes)
        `include "rdp_cntl_lane_enable_assignments.vh"
        default:
          begin
            execLanesActive  = 'd0     ;
          end
      endcase
    end

  assign oob_packet_starting     = (rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_WAIT) & (rdp_cntl_rx_cntl_state_next != `RDP_CNTL_RX_CNTL_WAIT) ;  // transitioning out of WAIT

  assign cntl__simd__tag         = tag     ;

  // send the tag as soon as we start the operations 
  //   - only send tags whose operations are FPMAC
  //   - this assumes we only use FPMAC operations that send a result to a reg in the simd
  assign cntl__simd__tag_valid   = (rdp_cntl_rx_cntl_state == `RDP_CNTL_RX_CNTL_START    ) & simd__cntl__tag_ready_d1 & (stOp_operation[`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE ] == `STREAMING_OP_CNTL_OPERATION_FP_MAC ) ;  // FIXME : may need to handle tags in simd


endmodule





