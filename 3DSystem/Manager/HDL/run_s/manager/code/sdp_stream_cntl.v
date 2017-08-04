/*********************************************************************************************

    File name   : sdp_stream_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : July 2017
    email       : lbbaker@ncsu.edu

    Description : Take storage descriptor pointer, number of lanes, transfer type and target and generate memory access commands. 

                  Note: This module will be used by the memory read controller(s) and the memory write controller.

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "pe_cntl.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "wu_memory.vh"
`include "wu_decode.vh"
`include "sdp_cntl.vh"
`include "python_typedef.vh"


module sdp_stream_cntl (  

            input   wire                                           xxx__sdp__storage_desc_processing_enable     ,
            input   wire  [`MGR_STORAGE_DESC_ADDRESS_RANGE  ]      xxx__sdp__storage_desc_ptr                   ,  // pointer to local storage descriptor although msb's contain manager ID, so remove
            input   wire  [`MGR_NUM_LANES_RANGE             ]      xxx__sdp__num_lanes                          ,
            input   wire  [`MGR_INST_OPTION_TRANSFER_RANGE  ]      xxx__sdp__txfer_type                         ,
            input   wire  [`MGR_INST_OPTION_TGT_RANGE       ]      xxx__sdp__target                             ,

            //-------------------------------
            // from MMC fifo Control
            input   wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   xxx__sdp__mem_request_channel_data_valid                ,  // valid data from channel data fifo and downstream ready

            // Contains the associated address for the next mmc line
            // - automatically updated when "get_line" is asserted
            //
            //
            input   wire                                            sdpr__sdps__response_id_valid              ,
            input   wire   [`COMMON_STD_INTF_CNTL_RANGE      ]      sdpr__sdps__response_id_cntl               ,
            output  reg                                             sdps__sdpr__response_id_ready              ,
            input   wire   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      sdpr__sdps__response_id_channel            ,
            input   wire   [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      sdpr__sdps__response_id_bank               ,
            input   wire   [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      sdpr__sdps__response_id_page               ,
            input   wire   [`MGR_DRAM_WORD_ADDRESS_RANGE     ]      sdpr__sdps__response_id_word               ,


            output  reg   [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   sdp__xxx__get_next_line                                    ,
            output  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_valid                                       ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE         ]   sdp__xxx__lane_cntl                                        ,
            output  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_enable                                      ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]   sdp__xxx__lane_channel_ptr [`MGR_NUM_OF_EXEC_LANES_RANGE ] ,
            output  reg   [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE  ]   sdp__xxx__lane_word_ptr    [`MGR_NUM_OF_EXEC_LANES_RANGE ] ,
            output  reg                                            sdp__xxx__current_channel                                  ,
            input   wire  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   xxx__sdp__lane_ready                                       ,
           

            //-------------------------------
            // from Storage Descriptor request control
            // - sent here during request generation request generation happens faster than streaming
            // - two buses :, cfg contains start address and access order and we receive one transaction per stream
            //                consJump contains the set of consequtive/jump fields which may be one or more
            //
            input  wire                                            sdpr__sdps__cfg_valid       ,
            input  wire   [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]   sdpr__sdps__cfg_addr        ,
            input  wire   [`MGR_INST_OPTION_ORDER_RANGE        ]   sdpr__sdps__cfg_accessOrder ,
            output wire                                            sdps__sdpr__cfg_ready       ,
            output reg                                             sdps__sdpr__complete        ,
            input  wire                                            sdpr__sdps__complete        ,
                                                                   
            input  wire                                            sdpr__sdps__consJump_valid  ,
            input  wire   [`COMMON_STD_INTF_CNTL_RANGE         ]   sdpr__sdps__consJump_cntl   ,
            input  wire   [`MGR_INST_CONS_JUMP_RANGE           ]   sdpr__sdps__consJump_value  ,
            output wire                                            sdps__sdpr__consJump_ready  ,

            //
            //-------------------------------
            // General
            //
            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input  wire                           clk             ,
            input  wire                           reset_poweron  
                        );


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registers and Wires
 

  //---------------------------------------------------------------------------------
  //---------------------------------------------------------------------------------
  // DRAM Address and Consequtive/Jump FIFOs from request controller 
  //  - two FIFOs
  //    a) all the consequtive and jump fields along with cntl for delineation
  //    b) single address associated with each cons/jump group 
  //
  //  a) Cons/Jump FIFO
  genvar gvi, chan ;
  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: consJump_to_strm_fsm_fifo

        wire  clear        ;
        wire  almost_full  ;
        wire                                                 write        ;
        wire  [`SDP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_RANGE ]   write_data   ;
        wire                                                 pipe_valid   ;
        wire                                                 pipe_read    ;
        wire  [`SDP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_RANGE ]   pipe_data    ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`SDP_CNTL_CJ_TO_STRM_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`SDP_CNTL_CJ_TO_STRM_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`SDP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_WIDTH       )
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

        assign  clear = 1'b0 ;    

        assign  sdps__sdpr__consJump_ready = ~almost_full ;
        
        assign  write       =  sdpr__sdps__consJump_valid ;
        assign  write_data  = {sdpr__sdps__consJump_cntl, sdpr__sdps__consJump_value};
    
        wire   [`COMMON_STD_INTF_CNTL_RANGE ]  pipe_consJumpCntl   ;
        wire   [`MGR_INST_CONS_JUMP_RANGE   ]  pipe_consJumpValue ;
        assign  {pipe_consJumpCntl, pipe_consJumpValue} = pipe_data ;

        wire   pipe_som     =  (pipe_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM    ); 
        wire   pipe_eom     =  (pipe_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_consJumpCntl == `COMMON_STD_INTF_CNTL_EOM);
      end
  endgenerate


  // b) Start Address FIFO 
  //
  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: addr_to_strm_fsm_fifo

        wire  clear        ;
        wire  almost_full  ;
        wire                                                   write        ;
        wire  [`SDP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_RANGE ]   write_data   ;
        wire                                                   pipe_valid   ;
        wire                                                   pipe_read    ;
        wire  [`SDP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_RANGE ]   pipe_data    ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`SDP_CNTL_ADDR_TO_STRM_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`SDP_CNTL_ADDR_TO_STRM_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`SDP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_WIDTH       )
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

        assign  clear = 1'b0 ;    

        assign  write       = sdpr__sdps__cfg_valid        ;
        assign  write_data  = {xxx__sdp__num_lanes, xxx__sdp__txfer_type, xxx__sdp__target, sdpr__sdps__cfg_accessOrder, sdpr__sdps__cfg_addr} ;

        wire   [`MGR_DRAM_LOCAL_ADDRESS_RANGE    ]  pipe_addr           ;
        wire   [`MGR_INST_OPTION_ORDER_RANGE     ]  pipe_order          ;
        wire   [`MGR_INST_OPTION_TGT_RANGE       ]  pipe_tgt            ;
        wire   [`MGR_INST_OPTION_TRANSFER_RANGE  ]  pipe_transfer_type  ;
        wire   [`MGR_NUM_LANES_RANGE             ]  pipe_num_lanes      ;  // 0-32 so need 6 bits
        assign  {pipe_num_lanes, pipe_transfer_type, pipe_tgt, pipe_order, pipe_addr}        = pipe_data   ;

        // Flow control DESC fsm if either fifo becomes almost full
        assign  sdps__sdpr__cfg_ready       = ~almost_full ;

      end
  endgenerate




  //----------------------------------------------------------------------------------------------------
  // Output of addr_to_strm_fsm_fifo
  //
  reg  [`MGR_INST_OPTION_ORDER_RANGE    ]   strm_accessOrder             ;
  reg  [`MGR_INST_OPTION_TRANSFER_RANGE ]   strm_transfer_type           ;

  // access order and transfer_type stays static during increment phase
  always @(*)
    begin
      strm_accessOrder      =  addr_to_strm_fsm_fifo[0].pipe_order         ;
      strm_transfer_type    =  addr_to_strm_fsm_fifo[0].pipe_transfer_type ;
    end
  //----------------------------------------------------------------------------------------------------



  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Response ID FIFO
  //
  //  - this fifo is the address of the channel from_mmc fifo data
  //  - the sdp_stream_cntl will use this to check if the current consequtive stream address is at the head of the from_mmc fifo

  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   response_id_valid                               ;
  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   response_id_fifo_read                           ;
  wire  [`MGR_DRAM_BANK_ADDRESS_RANGE        ]   response_id_bank      [`MGR_DRAM_NUM_CHANNELS ] ;
  wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]   response_id_page      [`MGR_DRAM_NUM_CHANNELS ] ;
  wire  [`MGR_DRAM_WORD_ADDRESS_RANGE        ]   response_id_word      [`MGR_DRAM_NUM_CHANNELS ] ;
                                                           
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: response_id_fifo

        wire                                               clear         ;
        wire                                               almost_full   ;
        wire                                               empty         ;
                                                           
        reg                                                write         ;
        reg   [`SDP_CNTL_RESPONSE_AGGREGATE_FIFO_RANGE ]   write_data    ;
                                                           
        reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE           ]   write_bank    ;
        reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE           ]   write_page    ;
        reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE           ]   write_word    ;
                                                           
        wire                                               read          ;
        wire  [`SDP_CNTL_RESPONSE_AGGREGATE_FIFO_RANGE ]   read_data     ;



        generic_fifo #(.GENERIC_FIFO_DEPTH      (`SDP_CNTL_RESPONSE_FIFO_DEPTH                 ),
                       .GENERIC_FIFO_THRESHOLD  (`SDP_CNTL_RESPONSE_FIFO_ALMOST_FULL_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`SDP_CNTL_RESPONSE_AGGREGATE_FIFO_WIDTH       )
                        ) gfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                .empty            ( empty                 ),
                                .depth            (                       ),
                                .almost_empty     (                       ),

                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ( write_data            ),
                                 // Read                                  
                                .read_data        ( read_data             ),
                                .read             ( read                  ),

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

        assign  clear = 1'b0 ;

        always @(*)
          begin
            write         =  sdpr__sdps__response_id_valid & (sdpr__sdps__response_id_channel == chan) ;
            write_bank    =  sdpr__sdps__response_id_bank                                              ;
            write_page    =  sdpr__sdps__response_id_page                                              ;
            write_word    =  sdpr__sdps__response_id_word                                              ;
          end
        always @(*)
          begin
            write_data  =  {write_bank, write_page, write_word};
          end

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                fifo_pipe_valid   ;
        wire                                               fifo_pipe_read    ;

        // pipe stage
        always @(posedge clk)
          begin
            fifo_pipe_valid <= ( reset_poweron      ) ? 'b0               :
                               ( read               ) ? 'b1               :
                               ( fifo_pipe_read     ) ? 'b0               :
                                                         fifo_pipe_valid  ;
          end
        reg                                                pipe_valid     ;
        reg                                                pipe_read      ;
        reg   [`SDP_CNTL_RESPONSE_AGGREGATE_FIFO_RANGE ]   pipe_data      ;
                                                           
        reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE           ]   pipe_bank     ;
        reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE           ]   pipe_page     ;
        reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE           ]   pipe_word     ;

        assign read           = ~empty          & (~fifo_pipe_valid | fifo_pipe_read) ; // keep the pipe charged
        assign fifo_pipe_read = fifo_pipe_valid & (~pipe_valid      | pipe_read     ) ; 

        always @(posedge clk)
          begin
            // If we are reading the previous stage, then this stage will be valid
            // otherwise if we are reading this stage this stage will not be valid
            pipe_valid      <= ( reset_poweron      ) ? 'b0              :
                               ( fifo_pipe_read     ) ? 'b1              :
                               ( pipe_read          ) ? 'b0              :
                                                         pipe_valid      ;
        
            // if we are reading, transfer from previous pipe stage. 
            pipe_data           <= ( fifo_pipe_read     ) ? read_data            :
                                                            pipe_data            ;
          end



        always @(*)
          begin
            {pipe_bank, pipe_page, pipe_word} = pipe_data ;
          end

        assign    pipe_read                  = response_id_fifo_read [chan]  ;

      end
  endgenerate
  
  always @(*)
    begin
      sdps__sdpr__response_id_ready  = ~response_id_fifo[0].almost_full & ~response_id_fifo[1].almost_full ;  // FIXME
    end
  assign  response_id_fifo_read[0] =  response_id_fifo[0].pipe_valid ;  // FIXME
  assign  response_id_fifo_read[1] =  response_id_fifo[1].pipe_valid ;

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin
        assign  response_id_valid [chan]      =  response_id_fifo[chan].pipe_valid      ;
        assign  response_id_bank  [chan]      =  response_id_fifo[chan].pipe_bank       ;
        assign  response_id_page  [chan]      =  response_id_fifo[chan].pipe_page       ;
        assign  response_id_word  [chan]      =  response_id_fifo[chan].pipe_word       ;
      end
  endgenerate

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------


  // end of to stream fifo's
  //---------------------------------------------------------------------------------
  //

  //----------------------------------------------------------------------------------------------------
  //
  //
  //
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Stream Data FSM
  //----------------------------------------------------------------------------------------------------
  //
  // - Take the consequtive/jump tuples from the intermediate fifo and start streaming data
  // - If page line changes occur, assume the next line is in the from_mmc_fifo because its been pipelined
  //   by the descriptor processing fsm
  // - The stream fsm will keep a register for channel 0 and channel 1 and  draw from these two registers as required when incrementing
      
  // State register 
  reg [`SDP_CNTL_STRM_STATE_RANGE ] sdp_cntl_stream_state      ; // state flop
  reg [`SDP_CNTL_STRM_STATE_RANGE ] sdp_cntl_stream_state_next ;

  always @(posedge clk)
    begin
      sdp_cntl_stream_state <= ( reset_poweron ) ? `SDP_CNTL_STRM_WAIT          :
                                                    sdp_cntl_stream_state_next  ;
    end
  
  //----------------------------------------------------------------------------------------------------
  // FSM Registers
  //

  reg  [`SDP_CNTL_CONS_COUNTER_RANGE        ]     consequtive_counter        ;
  reg                                             consequtive_counter_le0    ;  //
  reg                                             last_consequtive           ;  // we have seen the end-of-consJump so after this last phase we exit
  reg  [`MGR_INST_CONS_JUMP_RANGE           ]     consequtive_value_for_strm ;  // latched consequtive and jump values so we can calculate the next consequitve start address while we are running thru cons phase
  reg  [`MGR_INST_CONS_JUMP_RANGE           ]     jump_value_for_strm        ;
  reg                                             next_channel               ;  // about to access data from channel fifo n
  reg                                             ok_to_send                 ;  // if from_mmc data is available and the downsteram is ready


  //--------------------------------------------------
  // State Transitions
  
  always @(*)
    begin
      case (sdp_cntl_stream_state)
        
        `SDP_CNTL_STRM_WAIT: 
          sdp_cntl_stream_state_next =  ( addr_to_strm_fsm_fifo[0].pipe_valid && consJump_to_strm_fsm_fifo[0].pipe_valid) ? `SDP_CNTL_STRM_LOAD_FIRST_CONS_COUNT :  // load consequtive words counter
                                                                                                                            `SDP_CNTL_STRM_WAIT        ;
  
        // wait for consequtive counter to time out
        //  - transition straight thru this state
        `SDP_CNTL_STRM_LOAD_FIRST_CONS_COUNT: 
          sdp_cntl_stream_state_next =  (ok_to_send && consJump_to_strm_fsm_fifo[0].pipe_eom ) ? `SDP_CNTL_STRM_COUNT_CONS            :
                                        (ok_to_send                                          ) ? `SDP_CNTL_STRM_LOAD_JUMP_VALUE       :
                                                                                                 `SDP_CNTL_STRM_LOAD_FIRST_CONS_COUNT ;

        // a) Start streaming
        // b) Save jump value to pre-calculate next start address
        // If we dont yet have a jump value and the counter terminates, then we stay here
        // We are always in this state when we are expecting the next jump value
        `SDP_CNTL_STRM_LOAD_JUMP_VALUE: 
          sdp_cntl_stream_state_next =  (ok_to_send && consJump_to_strm_fsm_fifo[0].pipe_valid) ? `SDP_CNTL_STRM_COUNT_CONS      : 
                                                                                                  `SDP_CNTL_STRM_LOAD_JUMP_VALUE ;

        // Pre-calculate next consequtive phase start adderss
        // wait for consequtive counter to time out
        // we are always in this state when we are expecting the next consequtive value
        `SDP_CNTL_STRM_COUNT_CONS: 
          sdp_cntl_stream_state_next =  ( consequtive_counter_le0 && last_consequtive                                                                 ) ? `SDP_CNTL_STRM_COMPLETE        :
                                        ( consequtive_counter_le0 && consJump_to_strm_fsm_fifo[0].pipe_valid && consJump_to_strm_fsm_fifo[0].pipe_eom ) ? `SDP_CNTL_STRM_COUNT_CONS      :  // starting last consequtive
                                        ( consequtive_counter_le0 && consJump_to_strm_fsm_fifo[0].pipe_valid                                          ) ? `SDP_CNTL_STRM_LOAD_JUMP_VALUE :
                                                                                                                                                          `SDP_CNTL_STRM_COUNT_CONS      ;


        `SDP_CNTL_STRM_COMPLETE: 
          sdp_cntl_stream_state_next =  (sdpr__sdps__complete  ) ? `SDP_CNTL_STRM_WAIT     :
                                                                   `SDP_CNTL_STRM_COMPLETE ;
                                      
  
        // May not need all these states, but it will help with debug
        // Latch state on error
        `SDP_CNTL_STRM_ERR:
          sdp_cntl_stream_state_next = `SDP_CNTL_STRM_ERR ;
  
        default:
          sdp_cntl_stream_state_next = `SDP_CNTL_STRM_WAIT ;
    
      endcase // case (sdp_cntl_stream_state)
    end // always @ (*)
  
  //----------------------------------------------------------------------------------------------------

  // Dont read address until we are done. That way the pipe_addr is the valid start address
  assign  addr_to_strm_fsm_fifo[0].pipe_read           =  (sdp_cntl_stream_state == `SDP_CNTL_STRM_COMPLETE);

  assign  consJump_to_strm_fsm_fifo[0].pipe_read       = ((sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_FIRST_CONS_COUNT) &  ok_to_send & ~consJump_to_strm_fsm_fifo[0].pipe_eom                                                                                         ) |  // leave consJump fifo output alone so we keep valid and eom 
                                                         ((sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_JUMP_VALUE      ) &  ok_to_send &                                          consJump_to_strm_fsm_fifo[0].pipe_valid                                               ) |
                                                         ((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS           ) &                                              consJump_to_strm_fsm_fifo[0].pipe_valid  & consequtive_counter_le0 & ~last_consequtive) ;

  assign ok_to_send  = xxx__sdp__mem_request_channel_data_valid [sdp__xxx__current_channel] & (&xxx__sdp__lane_ready) ;

  always @(*)
    begin
      consequtive_counter_le0 = (consequtive_counter[`SDP_CNTL_CONS_COUNTER_MSB]  == 1'b1) | (consequtive_counter == 'd0) ;
    end

  always @(posedge clk)
    begin
      last_consequtive <= ((sdp_cntl_stream_state == `SDP_CNTL_STRM_WAIT                 )                                                                                                            )  ? 1'b0             : 
                          ((sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_FIRST_CONS_COUNT) & consequtive_counter_le0 & consJump_to_strm_fsm_fifo[0].pipe_valid & consJump_to_strm_fsm_fifo[0].pipe_eom)  ? 1'b1             :  // if theres only one consequtive field, we load consequive counter and set last
                          ((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS           ) & consequtive_counter_le0 & consJump_to_strm_fsm_fifo[0].pipe_valid & consJump_to_strm_fsm_fifo[0].pipe_eom)  ? 1'b1             :
                                                                                                                                                                                                           last_consequtive ;
    end

  always @(posedge clk)
    begin
      sdps__sdpr__complete   <= ( reset_poweron )  ? 1'b0 : 
                                                     (sdp_cntl_stream_state == `SDP_CNTL_STRM_COMPLETE) ;
    end

  always @(posedge clk)
    begin
      consequtive_counter <=  ( reset_poweron                                                                                                                                                             )  ? 'd0                                                        :
                              (                                                                                                            (sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_FIRST_CONS_COUNT)) ? consJump_to_strm_fsm_fifo[0].pipe_consJumpValue             :  
                              (~ok_to_send                                                                                                     ) ? consequtive_counter                                         :  // data not yet available

                              ( consequtive_counter_le0  &&  consJump_to_strm_fsm_fifo[0].pipe_valid  && (sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS           )) ? consJump_to_strm_fsm_fifo[0].pipe_consJumpValue             :  
                              ( consequtive_counter_le0                                                                                                                 ) ? consequtive_counter                                         :  // jump data not yet available
/*

                              ((consequtive_counter                             ==  'd0) &&  consJump_to_strm_fsm_fifo[0].pipe_valid    && (sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS           )) ? consJump_to_strm_fsm_fifo[0].pipe_consJumpValue             :  
                              ((consequtive_counter[`SDP_CNTL_CONS_COUNTER_MSB] == 1'b1) &&  consJump_to_strm_fsm_fifo[0].pipe_valid    && (sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS           )) ? consJump_to_strm_fsm_fifo[0].pipe_consJumpValue             :  
                              ((consequtive_counter                             ==  'd0) || (consequtive_counter[`SDP_CNTL_CONS_COUNTER_MSB] == 1'b1)                                                     ) ? consequtive_counter                                         :  // jump data not yet available
*/
                              ( strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST                                                                                                ) ? consequtive_counter-1                                       :
                              ( strm_transfer_type == PY_WU_INST_TXFER_TYPE_VECTOR                                                                                               ) ? consequtive_counter-addr_to_strm_fsm_fifo[0].pipe_num_lanes :
                                                                                                                                                                                                              consequtive_counter                                         ;  // will only occur with error
    end

  // Save jump and consequtive values while we are running thru the consequtive phase
  always @(*)
    begin
      consequtive_value_for_strm  = consJump_to_strm_fsm_fifo[0].pipe_consJumpValue  ;
      jump_value_for_strm         = consJump_to_strm_fsm_fifo[0].pipe_consJumpValue  ;
    end

  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE   ]   strm_next_cons_start_address ;  // pre-calculated next consequtive phase address
  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE   ]   strm_inc_address             ;  // address we increment for each jump
  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE   ]   strm_inc_address_e1          ;  
        
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]   strm_next_cons_start_channel ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   strm_next_cons_start_bank    ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   strm_next_cons_start_page    ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                        
    reg [`MGR_DRAM_LINE_ADDRESS_RANGE    ]   strm_next_cons_start_line    ; 
  `endif                                                                  
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE    ]   strm_next_cons_start_word    ;
                                                                           
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]   strm_inc_channel             ;  // formed address in access order for incrementing
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   strm_inc_bank                ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   strm_inc_page                ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                        
    reg [`MGR_DRAM_LINE_ADDRESS_RANGE    ]   strm_inc_line                ; 
  `endif                                                                  
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE    ]   strm_inc_word                ;
                                                                           
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]   strm_inc_channel_e1          ;  // 
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   strm_inc_bank_e1             ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   strm_inc_page_e1             ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                        
    reg [`MGR_DRAM_LINE_ADDRESS_RANGE    ]   strm_inc_line_e1             ; 
  `endif                                                                  
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE    ]   strm_inc_word_e1             ;
                                         
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                        
    reg [`MGR_DRAM_LINE_ADDRESS_RANGE    ]   response_id_line [`MGR_DRAM_NUM_CHANNELS ]  ;   // the MRC provides the word address of the mmc response, but we need the line 

    generate
      for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      always @(*)
        begin
          case (strm_accessOrder)  // synopsys parallel_case full_case
            PY_WU_INST_ORDER_TYPE_WCBP :
              begin
                response_id_line [chan]  = response_id_word [chan][`MGR_DRAM_LINE_IN_WORD_ADDRESS_RANGE ] ;
              end
            PY_WU_INST_ORDER_TYPE_CWBP :
              begin
                response_id_line [chan]  = response_id_word [chan][`MGR_DRAM_LINE_IN_WORD_ADDRESS_RANGE ] ;
              end
          endcase
        end
    endgenerate
  `endif                                                                  

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Check the output of the channel request ID fifo to determine if the output of the from_mmc fifo is the line bank/page/line we need
  // - use the "next" stream address
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      always @(*) 
        begin
          sdp__xxx__get_next_line[chan]  = ((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS) & consequtive_counter_le0 && last_consequtive) | // flush last transaction
                                           (((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS) | (sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS)) &
                                           (strm_inc_channel_e1 == chan) &
                                           ((strm_inc_bank_e1 != response_id_bank[strm_inc_channel_e1]) | 
                                            (strm_inc_page_e1 != response_id_page[strm_inc_channel_e1]) | 
                                            `ifdef MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                                              (strm_inc_line_e1 != response_id_line[strm_inc_channel_e1])))  ;
                                            `else
                                              1'b0)) ;
                                            `endif
        end
  endgenerate

  always @(*)
    begin
      sdp__xxx__current_channel     =  strm_inc_channel    ;
      next_channel                  =  strm_inc_channel_e1 ;
    end

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Stream address
  //  - this is the address we increment to access the line from the MMC
  //    We increment this address until we hit boundaries formed from the consequtive and jump fields from the storage descriptor
  //    Note: We increemnt based on word so the 2 lsbs dont change
  //   - Initially load increment address based on storage descriptor start address reordering the fields based on the access order
  //   - Increment based on number of lanes
  // ****************************************************************************************************
  // ****************************************************************************************************
  // We try to account for byte address by adding 2 bits to the word address.
  // But strm_address isnt really the byte address when the access order is CWBP because we are adding 2 bits to the channel, so be careful when
  // interpreting the stream address
  // ****************************************************************************************************
  // ****************************************************************************************************

  always @(*)
    begin

      case (sdp_cntl_stream_state)

        `SDP_CNTL_STRM_WAIT :
          begin
            // extract fields from start address
            strm_inc_channel_e1 =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  ;
            strm_inc_bank_e1    =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  ;
            strm_inc_page_e1    =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  ;
            strm_inc_word_e1    =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  ;
            `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              strm_inc_line_e1         =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_LINE_FIELD_RANGE ]  ;
            `endif
            // reorder fields for incrementing
            if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                strm_inc_address_e1 =  {strm_inc_page_e1, strm_inc_bank_e1, strm_inc_channel_e1, strm_inc_word_e1, 2'b00};
              end
            else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                strm_inc_address_e1 =  {strm_inc_page_e1, strm_inc_bank_e1, strm_inc_word_e1, strm_inc_channel_e1, 2'b00};
              end
            else 
              begin
                strm_inc_address_e1 =  {strm_inc_page_e1, strm_inc_bank_e1, strm_inc_word_e1, strm_inc_channel_e1, 2'b00};
              end
          end

        `SDP_CNTL_STRM_LOAD_JUMP_VALUE  :
          begin
            strm_inc_address_e1   = (~ok_to_send                                         ) ? strm_inc_address                                                    :
                                    (strm_transfer_type == PY_WU_INST_TXFER_TYPE_VECTOR  ) ? strm_inc_address + {addr_to_strm_fsm_fifo[0].pipe_num_lanes, 2'b00} :
                                    (strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST   ) ? strm_inc_address + 'd4                                              :
                                                                                             strm_inc_address                                                    ;
            // Extract fields (mainly for debug)
            if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                strm_inc_channel_e1 =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
                strm_inc_bank_e1    =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_BANK_FIELD_RANGE ]  ;
                strm_inc_page_e1    =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_PAGE_FIELD_RANGE ]  ;
                strm_inc_word_e1    =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  strm_inc_line_e1  =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                strm_inc_channel_e1 =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                strm_inc_bank_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                strm_inc_page_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                strm_inc_word_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  strm_inc_line_e1  =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else 
              begin
                strm_inc_channel_e1 =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                strm_inc_bank_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                strm_inc_page_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                strm_inc_word_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  strm_inc_line_e1  =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end

          end


        `SDP_CNTL_STRM_COUNT_CONS:
          begin
            strm_inc_address_e1   = (~ok_to_send                                        ) ? strm_inc_address                                                    :
                                    (consequtive_counter_le0                            ) ? strm_next_cons_start_address                                        :
                                    (strm_transfer_type == PY_WU_INST_TXFER_TYPE_VECTOR ) ? strm_inc_address + {addr_to_strm_fsm_fifo[0].pipe_num_lanes, 2'b00} :
                                    (strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST  ) ? strm_inc_address + 'd4                                              :
                                                                                            strm_inc_address                                                    ;

            if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                strm_inc_channel_e1 =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
                strm_inc_bank_e1    =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_BANK_FIELD_RANGE ]  ;
                strm_inc_page_e1    =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_PAGE_FIELD_RANGE ]  ;
                strm_inc_word_e1    =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  strm_inc_line_e1  =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                strm_inc_channel_e1 =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                strm_inc_bank_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                strm_inc_page_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                strm_inc_word_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  strm_inc_line_e1  =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else 
              begin
                strm_inc_channel_e1 =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                strm_inc_bank_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                strm_inc_page_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                strm_inc_word_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  strm_inc_line_e1  =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end

          end

        default:
          begin
            strm_inc_address_e1 =  strm_inc_address ;
            strm_inc_channel_e1 =  strm_inc_channel ;
            strm_inc_bank_e1    =  strm_inc_bank    ;
            strm_inc_page_e1    =  strm_inc_page    ;
            strm_inc_word_e1    =  strm_inc_word    ;
            `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              strm_inc_line_e1    =  strm_inc_line    ;
            `endif
          end

      endcase
    end

  // Register the stream address
  always @(posedge clk)
    begin

      strm_inc_address     <=  ( reset_poweron ) ? 'd0 : strm_inc_address_e1 ;

      if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
        begin
          strm_inc_channel             <=  strm_inc_channel_e1 ;
          strm_inc_bank                <=  strm_inc_bank_e1    ;
          strm_inc_page                <=  strm_inc_page_e1    ;
          strm_inc_word                <=  strm_inc_word_e1    ;
          `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
            strm_inc_line                <=  strm_inc_line_e1  ;
          `endif
        end
      else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP)
        begin
          strm_inc_channel             <=  strm_inc_channel_e1 ;
          strm_inc_bank                <=  strm_inc_bank_e1    ;
          strm_inc_page                <=  strm_inc_page_e1    ;
          strm_inc_word                <=  strm_inc_word_e1    ;
          `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
            strm_inc_line                <=  strm_inc_line_e1  ;
          `endif
        end
    end // always @ (*)
  
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //
  // While we are running thru the consequtive phase, pre-calculate the next cons phase start address
  //  - this address will be transferred to the stream address at a consequtive boundary

  always @(posedge clk)
    begin

      case (sdp_cntl_stream_state)
        
        `SDP_CNTL_STRM_WAIT: 
          begin
            strm_next_cons_start_address <= strm_inc_address_e1 ;  // address already ordered
          end

        `SDP_CNTL_STRM_LOAD_FIRST_CONS_COUNT: 
          begin
            strm_next_cons_start_address <= (ok_to_send) ? strm_next_cons_start_address + {consequtive_value_for_strm, 2'b00} :
                                                           strm_next_cons_start_address                                       ;
          end

        `SDP_CNTL_STRM_LOAD_JUMP_VALUE: 
          begin
            strm_next_cons_start_address <= (~ok_to_send                               ) ? strm_next_cons_start_address                                 : 
                                            ( consJump_to_strm_fsm_fifo[0].pipe_valid  ) ? strm_next_cons_start_address + {jump_value_for_strm, 2'b00}  : // remember its a byte address
                                                                                           strm_next_cons_start_address                                 ;
          end

        `SDP_CNTL_STRM_COUNT_CONS :
          begin
            // next inc address loaded with start in FIRST_CONS_COUNT state
            strm_next_cons_start_address <= ((consequtive_counter == 'd0                              ) && consJump_to_strm_fsm_fifo[0].pipe_valid) ? strm_next_cons_start_address + {consequtive_value_for_strm, 2'b00}  :
                                            ((consequtive_counter[`SDP_CNTL_CONS_COUNTER_MSB]  == 1'b1) && consJump_to_strm_fsm_fifo[0].pipe_valid) ? strm_next_cons_start_address + {consequtive_value_for_strm, 2'b00}  :
                                                                                                                                                      strm_next_cons_start_address                               ;
          end

        default:
          begin
            strm_next_cons_start_address <=  ( reset_poweron ) ? 'd0 : strm_next_cons_start_address ;
          end

      endcase // case (sdp_cntl_stream_state)
    end // always @ (*)
  
  
  always @(*)
    begin
      if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
        begin
          strm_next_cons_start_channel =  strm_next_cons_start_address[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
          strm_next_cons_start_bank    =  strm_next_cons_start_address[`MGR_DRAM_WCBP_ORDER_BANK_FIELD_RANGE ]  ;
          strm_next_cons_start_page    =  strm_next_cons_start_address[`MGR_DRAM_WCBP_ORDER_PAGE_FIELD_RANGE ]  ;
          strm_next_cons_start_word    =  strm_next_cons_start_address[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
          `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
            strm_next_cons_start_line    =  strm_next_cons_start_address[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
          `endif
        end
      else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
        begin
          strm_next_cons_start_channel =  strm_next_cons_start_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
          strm_next_cons_start_bank    =  strm_next_cons_start_address[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
          strm_next_cons_start_page    =  strm_next_cons_start_address[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
          strm_next_cons_start_word    =  strm_next_cons_start_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
          `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
            strm_next_cons_start_line    =  strm_next_cons_start_address[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
          `endif
        end
    end

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Pointer to word in a page
  //  - initially set to storage pointer word address offset by lane ID
  //  - increment by number of active lanes

  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]      lane_channel_ptr [`MGR_NUM_OF_EXEC_LANES_RANGE ] ; 
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE ]            lane_valid                                       ; 
  reg  [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE ]      lane_word_ptr    [`MGR_NUM_OF_EXEC_LANES_RANGE ] ; 
  reg  [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE ]      lane_word_inc    [`MGR_NUM_OF_EXEC_LANES_RANGE ] ; // value to increment the pointer by
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE ]            lane_enable                                      ;  // vector of lane enables based on number of active lanes
  reg  [`COMMON_STD_INTF_CNTL_RANGE        ]      lane_cntl                                        ;
  //genvar lane ;
  //generate
  always @(posedge clk)
    begin
      lane_cntl  <=  ((sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_FIRST_CONS_COUNT)                                                )  ? `COMMON_STD_INTF_CNTL_SOM :
                     ((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS           ) && consequtive_counter_le0 && last_consequtive )  ? `COMMON_STD_INTF_CNTL_EOM :
                                                                                                                                          `COMMON_STD_INTF_CNTL_MOM ;
          
      for (int lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
        begin: word_ptrs
          lane_enable     [lane]  <= (reset_poweron                                                                                                    ) ?  'd0                           :
                                     ((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS) || (sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_JUMP_VALUE)) ? (xxx__sdp__num_lanes >  lane)  :
                                                                                                                                                            lane_enable[lane]             ;

          lane_valid      [lane]  <= (reset_poweron                                                                                                    ) ?  'd0                           :                                      
                                     ((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS) || (sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_JUMP_VALUE)) ?  ok_to_send                    :
                                                                                                                                                            'd0                           ;

          lane_channel_ptr[lane]  <= (reset_poweron                                                                                                    ) ?  'd0                           :
                                     ((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS) || (sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_JUMP_VALUE)) ?  strm_inc_channel              :
                                                                                                                                                            lane_channel_ptr[lane]        ;

          lane_word_ptr   [lane]  <= (reset_poweron                                                                                                                                                              ) ?  'd0                           :
                                     (((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS) || (sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_JUMP_VALUE)) && (strm_transfer_type == PY_WU_INST_TXFER_TYPE_VECTOR)) ?  strm_inc_word + lane          :
                                                                                                                                                                                                                      lane_word_ptr[lane]           ;

          lane_word_inc   [lane]  <= (reset_poweron                                                                                                    ) ?  'd0                           :
                                     ((sdp_cntl_stream_state == `SDP_CNTL_STRM_COUNT_CONS) || (sdp_cntl_stream_state == `SDP_CNTL_STRM_LOAD_JUMP_VALUE)) ?  xxx__sdp__num_lanes           :
                                                                                                                                                            lane_word_inc[lane]           ;
        end
    end
  //endgenerate
  
  always @(*)
    begin
      sdp__xxx__lane_valid        =  lane_valid       ;
      sdp__xxx__lane_cntl         =  lane_cntl        ;
      sdp__xxx__lane_enable       =  lane_enable      ;
      sdp__xxx__lane_channel_ptr  =  lane_channel_ptr ;
      sdp__xxx__lane_word_ptr     =  lane_word_ptr    ;
    end
  //----------------------------------------------------------------------------------------------------
  //
  //
  //
endmodule

