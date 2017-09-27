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
            input   wire  [`MGR_NUM_LANES_RANGE             ]      xxx__sdp__num_lanes_m1                       ,
            input   wire  [`MGR_INST_OPTION_TRANSFER_RANGE  ]      xxx__sdp__txfer_type                         ,
            input   wire  [`MGR_INST_OPTION_TGT_RANGE       ]      xxx__sdp__target                             ,

            input   wire  [`MGR_NUM_OF_EXEC_LANES_RANGE     ]      xxx__sdp__lane_enable                        , 
            //-------------------------------
            // from MMC fifo Control
            input   wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   xxx__sdp__mem_request_channel_data_valid     ,  // valid data from channel data fifo and downstream ready

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
            input   wire   [`MGR_DRAM_LINE_ADDRESS_RANGE     ]      sdpr__sdps__response_id_line               ,


            output  reg   [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   sdp__xxx__get_next_line                                    ,
            output  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_valid                                       ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE         ]   sdp__xxx__lane_cntl        [`MGR_NUM_OF_EXEC_LANES_RANGE ] ,
            output  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_enable                                      ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]   sdp__xxx__lane_channel_ptr [`MGR_NUM_OF_EXEC_LANES_RANGE ] ,
            output  reg   [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE  ]   sdp__xxx__lane_word_ptr    [`MGR_NUM_OF_EXEC_LANES_RANGE ] ,
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
            input  wire   [`MGR_INST_CONS_JUMP_FIELD_RANGE     ]   sdpr__sdps__consJump_value  ,
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
  // Register
  //
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE     ]      exec_lane_enable    ;
  always @(posedge clk)
    begin
      exec_lane_enable  <= xxx__sdp__lane_enable  ;
    end

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
    
        wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  pipe_consJumpCntl   ;
        wire   [`MGR_INST_CONS_JUMP_FIELD_RANGE   ]  pipe_consJumpValue ;
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
        assign  write_data  = {xxx__sdp__num_lanes_m1, xxx__sdp__num_lanes, xxx__sdp__txfer_type, xxx__sdp__target, sdpr__sdps__cfg_accessOrder, sdpr__sdps__cfg_addr} ;

        wire   [`MGR_DRAM_LOCAL_ADDRESS_RANGE    ]  pipe_addr           ;
        wire   [`MGR_INST_OPTION_ORDER_RANGE     ]  pipe_order          ;
        wire   [`MGR_INST_OPTION_TGT_RANGE       ]  pipe_tgt            ;
        wire   [`MGR_INST_OPTION_TRANSFER_RANGE  ]  pipe_transfer_type  ;
        wire   [`MGR_NUM_LANES_RANGE             ]  pipe_num_lanes      ;  // 0-32 so need 6 bits
        wire   [`MGR_NUM_LANES_RANGE             ]  pipe_num_lanes_m1   ; 
        assign  {pipe_num_lanes_m1, pipe_num_lanes, pipe_transfer_type, pipe_tgt, pipe_order, pipe_addr}        = pipe_data   ;

        // Flow control DESC fsm if either fifo becomes almost full
        assign  sdps__sdpr__cfg_ready       = ~almost_full ;

      end
  endgenerate


  wire   [`MGR_NUM_LANES_RANGE             ]  num_lanes      ;  // 0-32 so need 6 bits
  wire   [`MGR_NUM_LANES_RANGE             ]  num_lanes_m1   ; 
  
  assign     num_lanes      =   addr_to_strm_fsm_fifo[0].pipe_num_lanes   ;
  assign     num_lanes_m1   =   addr_to_strm_fsm_fifo[0].pipe_num_lanes_m1;


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
  // Easier signal from from mmc data valid
  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   from_mmc_data_valid   ;
  assign from_mmc_data_valid    = xxx__sdp__mem_request_channel_data_valid  ;

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Response ID FIFO
  //
  //  - this fifo is the address of the channel from_mmc fifo data
  //  - the sdp_stream_cntl will use this to check if the current consequtive stream address is at the head of the from_mmc fifo

  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   response_id_valid                               ;
  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   response_id_in_progress                         ;
  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   response_id_fifo_read                           ;
  wire  [`MGR_DRAM_BANK_ADDRESS_RANGE        ]   response_id_bank      [`MGR_DRAM_NUM_CHANNELS ] ;
  wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]   response_id_page      [`MGR_DRAM_NUM_CHANNELS ] ;
  wire  [`MGR_DRAM_LINE_ADDRESS_RANGE        ]   response_id_line      [`MGR_DRAM_NUM_CHANNELS ] ;
                                                           
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: response_id_fifo

        wire                                               clear         ;
        wire                                               almost_full   ;
        wire                                               empty         ;
                                                           
        reg                                                write         ;
        reg   [`COMMON_STD_INTF_CNTL_RANGE             ]   write_cntl    ;
        reg   [`SDP_CNTL_RESPONSE_AGGREGATE_FIFO_RANGE ]   write_data    ;
                                                           
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE            ]   write_bank    ;
        reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE            ]   write_page    ;
        reg   [`MGR_DRAM_LINE_ADDRESS_RANGE            ]   write_line    ;
                                                           
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

       // Always send the ESOM and EOM to both fifos.
       // The actuall response IDs only are only with MOM
        always @(*)
          begin
            write         =  sdpr__sdps__response_id_valid & ((sdpr__sdps__response_id_channel == chan) | 
                                                              (sdpr__sdps__response_id_cntl ==  `COMMON_STD_INTF_CNTL_SOM ) |
                                                              (sdpr__sdps__response_id_cntl ==  `COMMON_STD_INTF_CNTL_EOM ) ) ;
            write_cntl    =  sdpr__sdps__response_id_cntl                                              ;
            write_bank    =  sdpr__sdps__response_id_bank                                              ;
            write_page    =  sdpr__sdps__response_id_page                                              ;
            write_line    =  sdpr__sdps__response_id_line                                              ;
          end
        always @(*)
          begin
            write_data  =  {write_cntl, write_bank, write_page, write_line};
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
        reg   [`COMMON_STD_INTF_CNTL_RANGE             ]   pipe_cntl      ;
        reg                                                pipe_read      ;
        reg   [`SDP_CNTL_RESPONSE_AGGREGATE_FIFO_RANGE ]   pipe_data      ;
                                                           
        reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE           ]   pipe_bank     ;
        reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE           ]   pipe_page     ;
        reg   [ `MGR_DRAM_LINE_ADDRESS_RANGE           ]   pipe_line     ;

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
            {pipe_cntl, pipe_bank, pipe_page, pipe_line} = pipe_data ;
          end

        assign    pipe_read                  = response_id_fifo_read [chan]  ;

        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM ); 
        wire   pipe_mom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_MOM ) ;
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM ) ;

        reg    response_id_in_progress ;
        always @(posedge clk)
          begin
            response_id_in_progress   = ( reset_poweron          ) ? 1'b0                    :
                                        ( pipe_eom &&  pipe_read ) ? 1'b0                    :
                                        ( pipe_som &&  pipe_read ) ? 1'b1                    :
                                                                     response_id_in_progress ;
          end

      end
  endgenerate
  
  always @(*)
    begin
      sdps__sdpr__response_id_ready  = ~response_id_fifo[0].almost_full & ~response_id_fifo[1].almost_full ;  // FIXME
    end

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin
        assign  response_id_in_progress [chan]  =  response_id_fifo[chan].response_id_in_progress                      ;
        assign  response_id_valid       [chan]  =  response_id_fifo[chan].pipe_valid & response_id_fifo[chan].pipe_mom ;
        assign  response_id_bank        [chan]  =  response_id_fifo[chan].pipe_bank                                    ;
        assign  response_id_page        [chan]  =  response_id_fifo[chan].pipe_page                                    ;
        assign  response_id_line        [chan]  =  response_id_fifo[chan].pipe_line                                    ;
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
  //----------------------------------------------------------------------------------------------------
  //
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   
  // State register 
  reg [`SDP_CNTL_STRM_CNTL_STATE_RANGE ] sdp_cntl_stream_cntl_state      ; // state flop
  reg [`SDP_CNTL_STRM_CNTL_STATE_RANGE ] sdp_cntl_stream_cntl_state_next ;
  
  always @(posedge clk)
    begin
      sdp_cntl_stream_cntl_state <= ( reset_poweron ) ? `SDP_CNTL_STRM_CNTL_WAIT          :
                                                         sdp_cntl_stream_cntl_state_next  ;
    end
  
  //----------------------------------------------------------------------------------------------------
  // FSM Registers
  //
  reg   [`SDP_CNTL_REQUEST_COUNTER_RANGE     ]   request_read_diff          [`MGR_DRAM_NUM_CHANNELS ]  ; // keep track of the difference between response_id_fifo and mmc_fifo reads
  reg   [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   request_read_diff_lt0                                 ; // use this to make sure we flush the mmc fifo
  reg   [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   request_read_diff_gt0                                 ; // response ID reads > mmc_fifo reads
  reg   [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   request_read_diff_eq0                                 ; 
                                                                                                       
  reg                                            running                                               ;  // starting flushing the mmc_fifos and response_id fifos
  reg                                            force_flush                                           ;  // starting flushing the mmc_fifos and response_id fifos
  reg                                            flush_complete                                        ;  // starting flushing the mmc_fifos and response_id fifos
  reg                                            streaming_complete                                    ;  // starting flushing the mmc_fifos and response_id fifos
                                                                                                       ;  // output to mmc fifo
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]    lanes_req_next_line        [`MGR_DRAM_NUM_CHANNELS ]  ;  // global lanes_req_next_line vector
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    lanes_sending              [`MGR_DRAM_NUM_CHANNELS ]  ; 
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    lanes_address_match        [`MGR_DRAM_NUM_CHANNELS ]  ;  // lanes current pointer matches with a channel data
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    all_lanes_req_next_line                               ; 
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    at_least_one_force_req_next_line                      ; 
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    at_least_one_req_next_line                            ; 
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]    lanes_force_req_next_line  [`MGR_DRAM_NUM_CHANNELS ]  ;  // conditions where we need to read but not all lanes want to get
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    get_next_line                                         ;  // output to mmc fifo
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    lanes_running                                         ;  // vector of running flags
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    block_request                                         ;  // if a lane matches channel data but isnt sending
                                                                                                       
  reg                                            all_lanes_loaded_jump                                 ;  // lanes can proceed
  reg                                            all_lanes_loaded_consequtive                          ;  // ifolanes can proceed
  reg                                            all_lanes_complete                                    ;  // flag to tell all lanes to transition to wait. Also used to read addr fifo
  //--------------------------------------------------
  // State Transitions
  // synopsys one_hot sdp_cntl_stream_cntl_state
  //
  always @(*)
    begin
      case (sdp_cntl_stream_cntl_state)  // synopsys parallel_case full_case
        
        `SDP_CNTL_STRM_CNTL_WAIT: 
          sdp_cntl_stream_cntl_state_next =  ( |exec_lane_enable ) ? `SDP_CNTL_STRM_CNTL_RUNNING : // start when at least one lane is emabled
                                                                     `SDP_CNTL_STRM_CNTL_WAIT ;
  
        `SDP_CNTL_STRM_CNTL_RUNNING: 
          sdp_cntl_stream_cntl_state_next =  ( all_lanes_complete ) ? `SDP_CNTL_STRM_CNTL_FLUSH_REQUESTS:  
                                                                      `SDP_CNTL_STRM_CNTL_RUNNING          ;
  
  
        `SDP_CNTL_STRM_CNTL_FLUSH_REQUESTS: 
          sdp_cntl_stream_cntl_state_next =  (( ~response_id_in_progress[0] && ~response_id_in_progress[1]) && request_read_diff_eq0[0] && request_read_diff_eq0[1]) ? `SDP_CNTL_STRM_CNTL_COMPLETE       :
                                                                                                                                                                       `SDP_CNTL_STRM_CNTL_FLUSH_REQUESTS ;  
  
        `SDP_CNTL_STRM_CNTL_COMPLETE: 
          sdp_cntl_stream_cntl_state_next =  (sdpr__sdps__complete ) ? `SDP_CNTL_STRM_CNTL_WAIT_DISABLE :
                                                                       `SDP_CNTL_STRM_CNTL_COMPLETE     ;
                                      
        `SDP_CNTL_STRM_CNTL_WAIT_DISABLE: 
          sdp_cntl_stream_cntl_state_next =  (~|exec_lane_enable ) ? `SDP_CNTL_STRM_CNTL_WAIT     :
                                                                     `SDP_CNTL_STRM_CNTL_WAIT_DISABLE ;
                                             
  
        // May not need all these states, but it will help with debug
        // Latch state on error
        `SDP_CNTL_STRM_CNTL_ERR:
          sdp_cntl_stream_cntl_state_next = `SDP_CNTL_STRM_CNTL_ERR ;
  
    
      endcase // case (sdp_cntl_stream_cntl_state)
    end // always @ (*)
 
  //----------------------------------------------------------------------------------------------------
  // FSM Registers
  //
  // Keep track of channel response ID and data reads
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin : read_diff
        always @(posedge clk)
          begin
            request_read_diff [chan]  <=  (  reset_poweron                                                                        ) ? 'd0                            :
                                          (  get_next_line [chan] &&  (response_id_fifo_read [chan] && response_id_valid [chan])  ) ? request_read_diff [chan]       :  // ignore the dummy response_id SOM and EOM
                                          (  get_next_line [chan]                                                                 ) ? request_read_diff [chan] - 'd1 :
                                          (                           (response_id_fifo_read [chan] && response_id_valid [chan])  ) ? request_read_diff [chan] + 'd1 :
                                                                                                                                      request_read_diff [chan]       ;
          end

        always @(*)
          begin
            request_read_diff_lt0 [chan] =    request_read_diff     [chan][`SDP_CNTL_REQUEST_COUNTER_MSB ] ;
            request_read_diff_gt0 [chan] =   ~request_read_diff_lt0 [chan]& |request_read_diff [chan]      ;
            request_read_diff_eq0 [chan] = ~(|request_read_diff     [chan])                                ;
          end 
      end
  endgenerate
 
  always @(*)
    begin
      running             =   (sdp_cntl_stream_cntl_state == `SDP_CNTL_STRM_CNTL_RUNNING        ) ;
      force_flush         =   (sdp_cntl_stream_cntl_state == `SDP_CNTL_STRM_CNTL_FLUSH_REQUESTS ) ;
      flush_complete      =   (sdp_cntl_stream_cntl_state == `SDP_CNTL_STRM_CNTL_COMPLETE       ) ;
      streaming_complete  =   (sdp_cntl_stream_cntl_state == `SDP_CNTL_STRM_CNTL_COMPLETE       ) ;
    end
                                                                                            
  //--------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Stream Data FSM
  //----------------------------------------------------------------------------------------------------
  //
  // - Take the consequtive/jump tuples from the intermediate fifo and start streaming data
  // - If page line changes occur, assume the next line is in the from_mmc_fifo because its been pipelined
  //   by the descriptor processing fsm
  // - The stream fsm will keep a register for channel 0 and channel 1 and draw from these two registers as required when incrementing
      
  //----------------------------------------------------------------------------------------------------
  // FSM Registers
  //
  
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]     lane_match                     [`MGR_DRAM_NUM_CHANNELS ];  //  head of response ID fifo matches our current stream count
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]     lane_next_match                [`MGR_DRAM_NUM_CHANNELS ];  //  lane's next addres matches current mmc_data/response_id contents
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]     neither_match                  [`MGR_DRAM_NUM_CHANNELS ];  // the lanes current or next address doesnt match available data/ID

  reg                                             total_mismatch                 [`MGR_DRAM_NUM_CHANNELS ];  // not one lane matches either channel data
  
  reg  [`MGR_INST_CONS_JUMP_FIELD_RANGE     ]     consequtive_value_for_strm     ;  // latched consequtive and jump values so we can calculate the next consequitve start address while we are running thru cons phase
  reg  [`MGR_INST_CONS_JUMP_FIELD_RANGE     ]     jump_value_for_strm            ;
  
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]     lane_complete                  ;  // global lane complete vector
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]     lanes_loading_jump             ;  // vector of flags indicating which lanes need to laod from the consJump fifo
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]     lanes_loading_consequtive      ;  
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]     lanes_loaded_jump              ;  // vector of flags indicating which lanes need to laod from the consJump fifo
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]     lanes_loaded_consequtive       ;  
  
  genvar lane;
  generate
    for (lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
      begin: lane_fsm
        reg  [`SDP_CNTL_CONS_COUNTER_RANGE        ]    consequtive_counter             ;
        reg                                            consequtive_counter_le0         ;  //
                                                                                   
        reg                                            last_consequtive                ;  // we have seen the end-of-consJump so after this last phase we exit
        reg                                            destination_ready               ;  // if from_mmc data is available and the downsteram is ready

        // we always send if the data in the fifo is what we want and the destination is ready.
        // But if we send the data but another lane cant, the data will still be sitting in the fifo. If the next data is in the 
        reg                                            sent_data_without_increment     ;  // if this line sent and requested a new line but other lanes blocked the get_line : FIXME not sure valid anymore
        reg                                            send_data                       ;  // if the current address matches and the data is valid, just send
                                                                                          // The assumption is that two lanes might get out of sync because perhaps they start won two different lines in the same channel
        reg                                            req_next_line_but_not_accepted  ;  // In that case, we allow the read for the lane that wants line 0 but stall it until the read occurs
        //reg                                          req_next_line_and_accepted      ;  // In this case, we have to log that we have sent to avoid multiple sends of the same data
      
        reg                                            lane_data_available             ; 
        reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    lane_address_match              ; 
        reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    lane_address_next_match         ; 
  
        reg                                            lane_running                    ;  // 
        reg                                            first_transaction               ;  // use to set SOM
        reg  [`COMMON_STD_INTF_CNTL_RANGE         ]    lane_cntl                       ;
        reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    req_next_line                   ;  // local req_next_line
        reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    force_req_next_line             ;  // special conditions, e.g. when starting, all lanes must have data available
        reg                                            complete                        ;  // local
        reg                                            loading_jump                    ;  // Tell all lanes this lane wants to load jump
        reg                                            loading_consequtive             ;  // Tell all lanes this lane wants to load consequtive
        reg                                            loaded_jump                     ;  // Tell all lanes this lane wants to load jump
        reg                                            loaded_consequtive              ;  // Tell all lanes this lane wants to load consequtive
  
        //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // We need to maintain a per lane pointer to control reading the response ID fifo
        reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE      ]     lane_inc_address             ;  // create a unique address for each lane as we may cross a channel/bank/page boundary
        reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE      ]     lane_inc_address_e1          ;  // create a unique address for each lane as we may cross a channel/bank/page boundary
        //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE     ]     lane_next_inc_cons_start_address ;  // pre-calculated next consequtive phase address
      
        reg                                            lane_bank_lsb                ; 
  
        reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]     lane_channel_ptr             ; 
        reg  [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE ]     lane_word_ptr                ; 
        reg  [`MGR_DRAM_BANK_DIV2_ADDRESS_RANGE  ]     lane_bank_ptr                ; 
        reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE       ]     lane_page_ptr                ; 
         `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                
           reg [`MGR_DRAM_LINE_ADDRESS_RANGE      ]     lane_line_ptr               ;
         `endif                                                                      
   
        reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]     lane_channel_ptr_e1          ; 
        reg  [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE ]     lane_word_ptr_e1             ; 
        reg  [`MGR_DRAM_BANK_DIV2_ADDRESS_RANGE  ]     lane_bank_ptr_e1             ; 
        reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE       ]     lane_page_ptr_e1             ; 
        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                
          reg [`MGR_DRAM_LINE_ADDRESS_RANGE      ]     lane_line_ptr_e1             ;
        `endif                                                                      
   
        //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
       
        // State register 
        reg [`SDP_CNTL_STRM_DATA_STATE_RANGE ] sdp_cntl_stream_data_state      ; // state flop
        reg [`SDP_CNTL_STRM_DATA_STATE_RANGE ] sdp_cntl_stream_data_state_next ;
        
        always @(posedge clk)
          begin
            sdp_cntl_stream_data_state <= ( reset_poweron ) ? `SDP_CNTL_STRM_DATA_WAIT          :
                                                               sdp_cntl_stream_data_state_next  ;
          end
     
        //--------------------------------------------------
        // State Transitions
        
        always @(*)
          begin
            case (sdp_cntl_stream_data_state)  // synopsys parallel_case full_case
              
              `SDP_CNTL_STRM_DATA_WAIT: 
                sdp_cntl_stream_data_state_next =  ( exec_lane_enable [lane]  ) ? `SDP_CNTL_STRM_DATA_INIT : 
                                                                                  `SDP_CNTL_STRM_DATA_WAIT ;
        
              `SDP_CNTL_STRM_DATA_INIT: 
                sdp_cntl_stream_data_state_next =  ( consJump_to_strm_fsm_fifo[0].pipe_valid && addr_to_strm_fsm_fifo[0].pipe_valid ) ? `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT :  // load consequtive words counter
                                                                                                                                        `SDP_CNTL_STRM_DATA_INIT                  ;
        
              // wait for consequtive counter to time out
              //  - transition straight thru this state
              `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT: 
                sdp_cntl_stream_data_state_next =  ( all_lanes_loaded_consequtive && consJump_to_strm_fsm_fifo[0].pipe_eom ) ? `SDP_CNTL_STRM_DATA_COUNT_CONS            :
                                                   ( all_lanes_loaded_consequtive                                          ) ? `SDP_CNTL_STRM_DATA_LOAD_JUMP_VALUE       :
                                                                                                                               `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT ;
       
              // a) Start streaming
              // b) Save jump value to pre-calculate next start address
              // If we dont yet have a jump value and the counter terminates, then we stay here
              // We are always in this state when we are expecting the next jump value
              `SDP_CNTL_STRM_DATA_LOAD_JUMP_VALUE: 
                sdp_cntl_stream_data_state_next =  (all_lanes_loaded_jump   ) ? `SDP_CNTL_STRM_DATA_COUNT_CONS      : 
                                                                                `SDP_CNTL_STRM_DATA_LOAD_JUMP_VALUE ;
       
              // Pre-calculate next consequtive phase start address
              // wait for consequtive counter to time out
              // we are always in this state when we are expecting the next consequtive value
              `SDP_CNTL_STRM_DATA_COUNT_CONS: 
                sdp_cntl_stream_data_state_next =  ( consequtive_counter_le0 && last_consequtive && send_data                                                    ) ? `SDP_CNTL_STRM_DATA_COMPLETE        :
                                                   ( consequtive_counter_le0 && consJump_to_strm_fsm_fifo[0].pipe_valid && consJump_to_strm_fsm_fifo[0].pipe_eom ) ? `SDP_CNTL_STRM_DATA_COUNT_CONS      :  // starting last consequtive
                                                   ( all_lanes_loaded_consequtive                                                                                ) ? `SDP_CNTL_STRM_DATA_LOAD_JUMP_VALUE :
                                                                                                                                                                     `SDP_CNTL_STRM_DATA_COUNT_CONS      ;
       
              // WHen we generate requests, we may a) generate an unneeded channel request or be left with an unused line.
              // As each group generates its own set of requests regardless of whether the request for the end of the last group is the same as the first request of the next, we still 
              // prefer at this stage to flush all previous requests
       
              `SDP_CNTL_STRM_DATA_COMPLETE: 
                sdp_cntl_stream_data_state_next =  ( flush_complete  ) ? `SDP_CNTL_STRM_DATA_WAIT_DISABLE :
                                                                         `SDP_CNTL_STRM_DATA_COMPLETE     ;
                                            
              `SDP_CNTL_STRM_DATA_WAIT_DISABLE: 
                sdp_cntl_stream_data_state_next =  (~exec_lane_enable[lane] ) ? `SDP_CNTL_STRM_DATA_WAIT         :
                                                                                `SDP_CNTL_STRM_DATA_WAIT_DISABLE ;
                                            
        
              // May not need all these states, but it will help with debug
              // Latch state on error
              `SDP_CNTL_STRM_DATA_ERR:
                sdp_cntl_stream_data_state_next = `SDP_CNTL_STRM_DATA_ERR ;
        
          
            endcase // case (sdp_cntl_stream_data_state)
          end // always @ (*)
   
        //--------------------------------------------------
        // 
        
        always @(*)
          begin
            case (sdp_cntl_stream_data_state)  // synopsys parallel_case
              
              `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT: 
                begin
                  loading_consequtive    = consJump_to_strm_fsm_fifo[0].pipe_valid & ~loaded_consequtive ;
                  loading_jump           = 1'b0 ;
                end
              `SDP_CNTL_STRM_DATA_COUNT_CONS: 
                begin
                  loading_consequtive    = ~req_next_line_but_not_accepted & ( destination_ready & lane_data_available &  consJump_to_strm_fsm_fifo[0].pipe_valid & consequtive_counter_le0 & ~last_consequtive & ~loaded_consequtive ) ;
                  loading_jump           = 1'b0 ;
                end
              `SDP_CNTL_STRM_DATA_LOAD_JUMP_VALUE : 
                begin
                  loading_consequtive    = 1'b0 ;
                  loading_jump           = ~req_next_line_but_not_accepted  & ( consJump_to_strm_fsm_fifo[0].pipe_valid & destination_ready & lane_data_available & ~loaded_jump ) ;
                end
              default:
                begin
                  loading_consequtive    = 1'b0 ;
                  loading_jump           = 1'b0 ;
                end
            endcase // case (sdp_cntl_stream_data_state)
          end
   
        always @(posedge clk)
          begin
            case (sdp_cntl_stream_data_state)  // synopsys parallel_case 
              
              `SDP_CNTL_STRM_DATA_WAIT: 
                begin
                  loaded_consequtive    = 1'b0   ;
                  loaded_jump           = 1'b0   ;
                end
              `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT: 
                begin
                  loaded_consequtive    = ( all_lanes_loaded_consequtive    ) ? 1'b0                :
                                          ( loading_consequtive             ) ? 1'b1                :
                                                                                loaded_consequtive  ;
                  loaded_jump           = loaded_jump         ;
                end
              `SDP_CNTL_STRM_DATA_COUNT_CONS: 
                begin
                  loaded_consequtive    = ( all_lanes_loaded_consequtive    ) ? 1'b0                :
                                          ( loading_consequtive             ) ? 1'b1                :
                                                                                loaded_consequtive  ;
                  loaded_jump           = 1'b0   ;
                end
              `SDP_CNTL_STRM_DATA_LOAD_JUMP_VALUE: 
                begin
                  loaded_consequtive    = 1'b0   ;
                  loaded_jump           = ( all_lanes_loaded_jump           ) ? 1'b0                :
                                          ( loading_jump                    ) ? 1'b1                :
                                                                                loaded_jump         ;
                end
              default:
                begin
                  loaded_consequtive    = loaded_consequtive  ;
                  loaded_jump           = loaded_jump         ;
                end
            endcase
                                                                                                   
          end

        always @(*)
          begin
            complete = (sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_COMPLETE       );
          end
        
        always @(*)
          begin
            consequtive_counter_le0 = (consequtive_counter[`SDP_CNTL_CONS_COUNTER_MSB]  == 1'b1) | (consequtive_counter == 'd0) ;
          end
        
        always @(posedge clk)
          begin
            case (sdp_cntl_stream_data_state)  // synopsys parallel_case
              
              `SDP_CNTL_STRM_DATA_INIT: 
                begin
                  last_consequtive <= 1'b0  ;
                end
              `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT: 
                begin
                  last_consequtive <= (consJump_to_strm_fsm_fifo[0].pipe_valid & consJump_to_strm_fsm_fifo[0].pipe_eom) ? 1'b1             :  // if theres only one consequtive field, we load consequive counter and set last
                                                                                                                          last_consequtive ;
                end
              `SDP_CNTL_STRM_DATA_COUNT_CONS: 
                begin
                  last_consequtive <= ( req_next_line_but_not_accepted                                                                          ) ?  last_consequtive :
                                      (consequtive_counter_le0 & consJump_to_strm_fsm_fifo[0].pipe_valid & consJump_to_strm_fsm_fifo[0].pipe_eom) ?  1'b1             :
                                                                                                                                                     last_consequtive ;
                end
              default:
                begin
                  last_consequtive <= last_consequtive ;
                end
            endcase // case (sdp_cntl_stream_data_state)
          end

        always @(posedge clk)
          begin
            lane_bank_lsb    <= ((sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_INIT                 ))  ? addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_BANK_FIELD_LSB ] :
                                                                                                               lane_bank_lsb                                                         ;
          end

        always @(*)
          begin
            req_next_line_but_not_accepted  =  req_next_line [lane_channel_ptr_e1] & ~get_next_line [lane_channel_ptr_e1] ;
          end
       
       always @(posedge clk)
         begin
           case (sdp_cntl_stream_data_state)  // synopsys parallel_case
             `SDP_CNTL_STRM_DATA_INIT :
               begin
                 lane_inc_address <=  lane_inc_address_e1 ;
               end
             default:
               begin   
                 //  Increment address if we are sending and we are requesting next line and our request is accepted
                 //  If however we previously sent and we requested a new line but the request was rejected, we actually did send but we didnt increment.
                 //  So now we store the fact we didnt increment in "sent_data_without_increment" and assume the next time our request is accepted its to satisfy the previous request
                 //  when we sent without request accept.
                 //  request is accepted
                 //
                 //                               previous data was sent at                                   requested next line and accepted   
                 //                               the same time as requesting                               e.g. ~ (requested . ~accepted)
                 //                               wasnt accepted                                                            v
                 //                                            v                     |<------------------------------------------------------------------------->|
                 lane_inc_address <= (( send_data || sent_data_without_increment) && (~req_next_line [lane_channel_ptr_e1] || get_next_line [lane_channel_ptr_e1])) ?  lane_inc_address_e1 :
                                                                                                                                                                       lane_inc_address    ;
               end
           endcase
         end
   
       always @(posedge clk)
         begin
           sent_data_without_increment <= ( reset_poweron                                                                                                                 ) ?  1'b0                        :

                                          //( send_data && req_next_line [lane_channel_ptr_e1] &&  (sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT)) ?  1'b1                        :  // only allow one transfer during the initial wait state
                                                                                                                                                                                                              // where we are all waiting for data to be available for each line
                                                                                                                                                                                                              // data sent and a get_line was rejected, so block sends until we see the all_get_line
                 //                                                            requested next line and rejected
                 //                                                             e.g. ~requested . ~accepted)
                 //                                                                           v
                 //                                      |<------------------------------------------------------------------------->|
                                          ( send_data && req_next_line [lane_channel_ptr_e1] && ~get_next_line [lane_channel_ptr_e1]                                      ) ?  1'b1                        :  // If we send current but next is rejected, leave the current and next address alone
                                          (                                                      get_next_line [lane_channel_ptr_e1]                                      ) ?  1'b0                        :  // but set this flag to ensure we dont resend current data. We dot his because all data
                                                                                                                                                                                                              // is requested using next address

                                                                                                                                                                               sent_data_without_increment ;
           // use for setting SOM and to avoid sending more than one transaction during FIRST_CONS state
           first_transaction           <= ( reset_poweron      )  ?  1'b1              :
                                          ( ~lane_running      )  ?  1'b1              : 
                                          ( send_data          )  ?  1'b0              :  // clear when we send first
                                                                     first_transaction ;
         end
   

       always @(*)
         begin
           case (sdp_cntl_stream_data_state)  // synopsys parallel_case full_case
           
             `SDP_CNTL_STRM_DATA_INIT :
               begin
                
                 case (strm_transfer_type )  // synopsys parallel_case full_case
                 
                   PY_WU_INST_TXFER_TYPE_VECTOR:
                     begin
                       case (strm_accessOrder )  // synopsys parallel_case full_case
                         PY_WU_INST_ORDER_TYPE_WCBP:
                           begin
                             lane_inc_address_e1         =  {addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE      ], 
                                                             addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_BANK_DIV2_FIELD_RANGE ], 
                                                             addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE      ], 
                                                             addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE      ],
                                                             2'b00 } + {lane, 2'b00} ;
                           end
                         PY_WU_INST_ORDER_TYPE_CWBP:
                           begin
                             lane_inc_address_e1         =  {addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE      ], 
                                                             addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_BANK_DIV2_FIELD_RANGE ], 
                                                             addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE      ],
                                                             addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE      ], 
                                                             2'b00 } + {lane, 2'b00} ;
                           end
                       endcase //(strm_accessOrder )
                     end

                   PY_WU_INST_TXFER_TYPE_BCAST :
                     begin
                       lane_inc_address_e1         =  {addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE      ], 
                                                       addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_BANK_DIV2_FIELD_RANGE ], 
                                                       addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE      ],
                                                       addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE      ], 
                                                       2'b00 } ;
                     end
                 endcase //(strm_transfer_type )
   
               end
      
             `SDP_CNTL_STRM_DATA_COUNT_CONS:
               begin
                 case (strm_transfer_type )  // synopsys parallel_case full_case
                   PY_WU_INST_TXFER_TYPE_VECTOR:
                     begin
                       lane_inc_address_e1    =   (consequtive_counter_le0     ) ?  lane_next_inc_cons_start_address      :
                                                                                    lane_inc_address + {num_lanes, 2'b00} ;

                     end
                   PY_WU_INST_TXFER_TYPE_BCAST :
                     begin
                       lane_inc_address_e1    =   (consequtive_counter_le0     ) ?  lane_next_inc_cons_start_address      :
                                                                                    lane_inc_address + 'd4                ;
                     end
                 endcase //(strm_transfer_type )
               end
   
             `SDP_CNTL_STRM_DATA_LOAD_JUMP_VALUE  :
               begin
                 case (strm_transfer_type )  // synopsys parallel_case full_case
                   PY_WU_INST_TXFER_TYPE_VECTOR:
                     begin
                       lane_inc_address_e1    =   lane_inc_address + {num_lanes, 2'b00} ;
                     end
                   PY_WU_INST_TXFER_TYPE_BCAST :
                     begin
                       lane_inc_address_e1    =   lane_inc_address + 'd4                ;
                     end
                 endcase //(strm_transfer_type )
               end                            
                                              
             default:                         
               begin                          
                 case (strm_transfer_type )  // synopsys parallel_case full_case
                   PY_WU_INST_TXFER_TYPE_VECTOR:
                     begin
                       lane_inc_address_e1    =   lane_inc_address + {num_lanes, 2'b00} ;
                     end
                   PY_WU_INST_TXFER_TYPE_BCAST :
                     begin
                       lane_inc_address_e1    =   lane_inc_address + 'd4                ;
                     end
                 endcase //(strm_transfer_type )
               end
           endcase
   
         end
   
       always @(*)
         begin
     
           lane_cntl  =   ( first_transaction                                                                                             )  ? `COMMON_STD_INTF_CNTL_SOM :
                          ((sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_COUNT_CONS ) && consequtive_counter_le0 && last_consequtive )  ? `COMMON_STD_INTF_CNTL_EOM :
                                                                                                                                               `COMMON_STD_INTF_CNTL_MOM ;
               
           if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
             begin
               lane_channel_ptr =  lane_inc_address[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE             ]  ;
               lane_bank_ptr    =  lane_inc_address[`MGR_DRAM_WCBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_page_ptr    =  lane_inc_address[`MGR_DRAM_WCBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_word_ptr    =  lane_inc_address[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE             ]  ;
               `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                 lane_line_ptr  =  lane_inc_address[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE             ]  ;
               `endif
             end
           else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
             begin
               lane_channel_ptr =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE             ]  ;
               lane_bank_ptr    =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_page_ptr    =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_word_ptr    =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE             ]  ;
               `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                 lane_line_ptr  =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE             ]  ;
               `endif
             end
           else 
             begin
               lane_channel_ptr =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE             ]  ;
               lane_bank_ptr    =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_page_ptr    =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_word_ptr    =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE             ]  ;
               `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                 lane_line_ptr  =  lane_inc_address[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE             ]  ;
               `endif
             end
   
           if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
             begin
               lane_channel_ptr_e1 =  lane_inc_address_e1[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE             ]  ;
               lane_bank_ptr_e1    =  lane_inc_address_e1[`MGR_DRAM_WCBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_page_ptr_e1    =  lane_inc_address_e1[`MGR_DRAM_WCBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_word_ptr_e1    =  lane_inc_address_e1[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE             ]  ;
               `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                 lane_line_ptr_e1  =  lane_inc_address_e1[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE             ]  ;
               `endif
             end
           else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
             begin
               lane_channel_ptr_e1 =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE             ]  ;
               lane_bank_ptr_e1    =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_page_ptr_e1    =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_word_ptr_e1    =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE             ]  ;
               `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                 lane_line_ptr_e1  =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE             ]  ;
               `endif
             end
           else 
             begin
               lane_channel_ptr_e1 =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE             ]  ;
               lane_bank_ptr_e1    =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_page_ptr_e1    =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
               lane_word_ptr_e1    =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE             ]  ;
               `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                 lane_line_ptr_e1  =  lane_inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE             ]  ;
               `endif
             end
     
   
           lane_data_available  = from_mmc_data_valid [lane_channel_ptr] & lane_address_match [lane_channel_ptr];
   
           // make sure pe is ready and there is data in the from_mmc_fifo and the required data matches the response fifo
           //destination_ready  = lane_data_available & xxx__sdp__lane_ready[lane] ;
           destination_ready  = xxx__sdp__lane_ready[lane] ;
   
   
         end
         
       for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
         begin
           always @(*) 
             begin
               lane_address_match      [chan]  = (lane_channel_ptr == chan)  & response_id_valid [lane_channel_ptr] & 
                                                 (({lane_bank_ptr, lane_bank_lsb} == response_id_bank[chan]) & (lane_page_ptr == response_id_page[chan]) & 
                                                 `ifdef MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                                                   (lane_line_ptr == response_id_line[chan]))  ;
                                                 `else
                                                   1'b0) ;
                                                 `endif
            
               lane_address_next_match [chan]   = (((lane_channel_ptr_e1 == chan) & response_id_valid [lane_channel_ptr_e1]))  & //| (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP))  &
                                                   (({lane_bank_ptr_e1 , lane_bank_lsb} == response_id_bank[chan]) & (lane_page_ptr_e1  == response_id_page[chan]) & 
                                                    `ifdef MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                                                      (lane_line_ptr_e1  == response_id_line[chan]))  ;
                                                    `else
                                                      1'b0) ;
                                                    `endif
               // use outside generate
               lane_match                    [chan][lane]  =  lane_address_match      [chan] & exec_lane_enable [lane] ;
               lane_next_match               [chan][lane]  =  lane_address_next_match [chan] & exec_lane_enable [lane] ;

               neither_match                 [chan][lane]  = ((lane_channel_ptr == chan) & ~lane_address_match [chan]) & ((lane_channel_ptr_e1 == chan) & ~lane_address_next_match [chan]) & from_mmc_data_valid [chan] & response_id_valid [chan]  ;
             end
         end
   
       always @(*) 
         begin
           lane_running      = ((sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_COUNT_CONS) | (sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_LOAD_JUMP_VALUE)) ;
      
           send_data        = lane_running & destination_ready & lane_data_available & ~sent_data_without_increment ; //& ~((sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT) & loading_consequtive) ;  // First time thru dont send at the same time as loading consequtive otherwise we miss a consequtive_counter step
         end
   
       always @(posedge clk)
         begin
           consequtive_counter <=  ( reset_poweron || ~exec_lane_enable [lane]                                                                                                                       )  ? 'd0                                                        :
                                   ( (sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_INIT)                                                                                                        ) ? consequtive_value_for_strm  :
                                   ( loading_consequtive                                                                                                                                             ) ? consequtive_value_for_strm                                  :
                                   ( send_data && (strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST )                                                                                               ) ? consequtive_counter-1                                       :  
                                   ( send_data && (strm_transfer_type == PY_WU_INST_TXFER_TYPE_VECTOR)                                                                                               ) ? consequtive_counter-num_lanes :  
                                                                                                                                                                                                         consequtive_counter                                         ;  // will only occur with error
         end
   
       for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
         begin: get_line
           always @(*) 
             begin                        //                  there is always a "current" line   
                                          //                              v                                                                                                                                     /
       //        req_next_line [chan]        = ((lane_running & (send_data | sent_data_without_increment) /*destination_ready*/ & (lane_channel_ptr_e1 == chan) & ~lane_address_next_match [chan] ) | complete)  // if complete, set to avoid blocking other lanes// & from_mmc_data_valid [chan] ) //;
       //                                     | 
       //                                      // Special case 1: starting with 2nd line, next is other channel so next is valid 
       //                                      ((sdp_cntl_stream_data_state != `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT) & (strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST  ) & (from_mmc_data_valid [chan] & response_id_valid[chan] & ~lane_address_match[chan] & (~lane_address_next_match[chan] & (lane_channel_ptr_e1 != lane_channel_ptr ))))  |
       //                                      ((sdp_cntl_stream_data_state != `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT) & (strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST  ) & (from_mmc_data_valid [chan] & response_id_valid[chan] & ~lane_address_match[chan] & ~lane_address_next_match[chan])) 
       //                                        | 
       //                                      ((sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT) & (from_mmc_data_valid [lane_channel_ptr] & response_id_valid[lane_channel_ptr] & ~lane_address_match[lane_channel_ptr] & ~lane_address_next_match[lane_channel_ptr])) ; // in case the first data is in the 2nd line
       //                                  
       // Mainly used for when we start streaming. If a lane starts with the 2nd memory line, there wont actually be data available. So force a read to ensure all lanes start with valid data
       // I dont think theres a case when we could inadvertantly read and another lane might need that next
       // Unfortunately, we do have cases where two lanes might point to the same channel but require different lines, so we cant for a read
       //        force_req_next_line [chan]  = destination_ready & (lane_channel_ptr == chan) &   
       //                                ((sdp_cntl_stream_data_state == `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT) & first_transaction & (from_mmc_data_valid [lane_channel_ptr] & response_id_valid[lane_channel_ptr] & ~lane_address_match[lane_channel_ptr] & ~lane_address_next_match[lane_channel_ptr]) ); //&  ~at_least_one_req_next_line [chan])  ;  // in case the first data is in the 2nd line

               case (sdp_cntl_stream_data_state)  // synopsys parallel_case
                 
                 `SDP_CNTL_STRM_DATA_LOAD_FIRST_CONS_COUNT: 
                   begin
                     req_next_line [chan]        = 1'b0 ;
                     force_req_next_line [chan]  = 1'b0 ;
                   end
             
                 `SDP_CNTL_STRM_DATA_COUNT_CONS: 
                   begin
                     req_next_line [chan]        = ( lane_running & (send_data | sent_data_without_increment) /*destination_ready*/ & (lane_channel_ptr_e1 == chan) & ~lane_address_next_match [chan]                                                                         )  ?  1'b1  :
                                                   ((strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST  ) & (from_mmc_data_valid [chan] & response_id_valid[chan] & ~lane_address_match[chan] & (~lane_address_next_match[chan] & (lane_channel_ptr_e1 != lane_channel_ptr ))))  ?  1'b1  :
                                                   ((strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST  ) & (from_mmc_data_valid [chan] & response_id_valid[chan] & ~lane_address_match[chan] & (~lane_address_next_match[chan]                                             )))  ?  1'b1  :
                                                                                                                                                                                                                                                                                    1'b0  ;
                     force_req_next_line [chan]  = (destination_ready & (lane_channel_ptr == chan) & first_transaction & (from_mmc_data_valid [lane_channel_ptr] & response_id_valid[lane_channel_ptr] & ~lane_address_match[lane_channel_ptr] & ~lane_address_next_match[lane_channel_ptr])) ;
                   end
             
                 `SDP_CNTL_STRM_DATA_LOAD_JUMP_VALUE: 
                   begin
                     req_next_line [chan]        = ( lane_running & (send_data | sent_data_without_increment) /*destination_ready*/ & (lane_channel_ptr_e1 == chan) & ~lane_address_next_match [chan]                                                                         )  ?  1'b1  :
                                                   ((strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST  ) & (from_mmc_data_valid [chan] & response_id_valid[chan] & ~lane_address_match[chan] & (~lane_address_next_match[chan] & (lane_channel_ptr_e1 != lane_channel_ptr ))))  ?  1'b1  :
                                                   ((strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST  ) & (from_mmc_data_valid [chan] & response_id_valid[chan] & ~lane_address_match[chan] & (~lane_address_next_match[chan]                                             )))  ?  1'b1  :
                                                                                                                                                                                                                                                                                    1'b0  ;
                     force_req_next_line [chan]  = 1'b0  ;
                   end
             
                 `SDP_CNTL_STRM_DATA_COMPLETE: 
                   begin
                     req_next_line [chan]        = 1'b1 ;  // if complete, set to avoid blocking other lanes// & from_mmc_data_valid [chan] ) //;
                     force_req_next_line [chan]  = 1'b0  ;

                   end
                 default:
                   begin
                     req_next_line [chan]        = ( complete                                                                                                                                                                                                                 )  ?  1'b1  :  // if complete, set to avoid blocking other lanes// & from_mmc_data_valid [chan] ) //;
                                                   ( lane_running & (send_data | sent_data_without_increment) /*destination_ready*/ & (lane_channel_ptr_e1 == chan) & ~lane_address_next_match [chan]                                                                         )  ?  1'b1  :
                                                                                                                                                                                                                                                                                    1'b0  ;
                     force_req_next_line [chan]  = 1'b0  ;
                                                                                                    
                   end
               endcase // case (sdp_cntl_stream_data_state)
             end
         end
   
       always @(posedge clk)
         begin
       
           case (sdp_cntl_stream_data_state) // synopsys parallel_case
             
             `SDP_CNTL_STRM_DATA_INIT: 
               begin
                 lane_next_inc_cons_start_address <= lane_inc_address_e1 ;  // address already ordered
               end
       
             default:
               begin
                 case ({loading_consequtive, loading_jump})  // synopsys parallel_case
                   2'b10:
                     lane_next_inc_cons_start_address <= lane_next_inc_cons_start_address + {consequtive_value_for_strm, 2'b00} ;
                   2'b01:
                     lane_next_inc_cons_start_address <= lane_next_inc_cons_start_address + {jump_value_for_strm       , 2'b00} ;
                   default:
                     lane_next_inc_cons_start_address <= lane_next_inc_cons_start_address ;
                 endcase
               end
           endcase // case (sdp_cntl_stream_data_state)
         end // always @ (*)
   
       always @(*) 
         begin
           sdp__xxx__lane_valid        [lane]  =  send_data        ;
           sdp__xxx__lane_cntl         [lane]  =  lane_cntl        ;
           sdp__xxx__lane_enable       [lane]  =  lane_running     ;
           sdp__xxx__lane_channel_ptr  [lane]  =  lane_channel_ptr ;
           sdp__xxx__lane_word_ptr     [lane]  =  lane_word_ptr    ;
         end
   
       end
  endgenerate
   
   
   generate
     for (lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
       begin: glob_assigns
         always @(*) 
           begin
             lane_complete             [lane]    =   lane_fsm[lane].complete                     ;
             lanes_loading_jump        [lane]    =   lane_fsm[lane].loading_jump                 ;  
             lanes_loading_consequtive [lane]    =   lane_fsm[lane].loading_consequtive          ;  
             lanes_loaded_jump         [lane]    =   lane_fsm[lane].loaded_jump                  ;  
             lanes_loaded_consequtive  [lane]    =   lane_fsm[lane].loaded_consequtive           ;  
             lanes_running             [lane]    =   lane_fsm[lane].lane_running                 ;  
           end
       end
   endgenerate
   
   always @(*)
     begin
       all_lanes_loaded_jump        = &(lanes_loading_jump        | lanes_loaded_jump        | ~exec_lane_enable) & running ;  // need at least one lane enabled
       all_lanes_loaded_consequtive = &(lanes_loading_consequtive | lanes_loaded_consequtive | ~exec_lane_enable) & running ;

       all_lanes_complete         = (&(lane_complete | ~exec_lane_enable)) ;
     end
   
   generate
     for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
       begin: get_line
         for (lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
           begin
             always @(*) 
               begin
                 lanes_req_next_line        [chan][lane]    =   lane_fsm[lane].req_next_line      [chan] ;
                 lanes_force_req_next_line  [chan][lane]    =   lane_fsm[lane].force_req_next_line[chan] ;
                 lanes_sending              [chan][lane]    =   (lane_fsm[lane].send_data | lane_fsm[lane].sent_data_without_increment) & (lane_fsm[lane].lane_channel_ptr == chan)  ;
                 lanes_address_match        [chan][lane]    =   lane_fsm[lane].lane_address_match[chan]          ;
               end
           end
       end
   endgenerate
   
   
   generate
     for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
       begin: all_lanes_get_line
         always @(*) 
           begin
             all_lanes_req_next_line          [chan]     =  &(lanes_req_next_line      [chan] | ~exec_lane_enable ); //| ~lanes_running ) ;
             at_least_one_req_next_line       [chan]     =  |(lanes_req_next_line      [chan] &  exec_lane_enable ); //&  lanes_running ) ;
             at_least_one_force_req_next_line [chan]     =  |(lanes_force_req_next_line[chan] &  exec_lane_enable ); //&  lanes_running ) ;

             block_request                    [chan]     =  |(lanes_address_match [chan] & ~lanes_sending [chan] & ~lane_complete)  ;  // if a lane matches a channels data but isnt sending
           end
       end
   endgenerate

   generate
     for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
       begin: total_miss
         always @(*) 
           begin
             total_mismatch [chan]       = (running & &(neither_match [chan] | ~exec_lane_enable)) ;
           end
       end
   endgenerate
   
   always @(*)
     begin
     end
   
   // only get next line if all lanes req_next_line
   generate
     for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
       begin
         always @(*)
           begin
             get_next_line[chan] = ((all_lanes_req_next_line[chan] | at_least_one_force_req_next_line[chan]) & from_mmc_data_valid [chan] & running & ~block_request [chan] ) | //& ~|(lane_match_but_not_destination_ready [chan] ) & ~|(lane_next_match[chan] )) |   // Dont read if a lanes next address matches the contents of the mmc/response fifo or
                                   (total_mismatch  [chan]                                                                                          & ~block_request [chan] ) |
                                   (force_flush & request_read_diff_gt0 [chan]                                                                      & ~block_request [chan] ) ;   // a lane matches the contents but cant yet use it
           end
       end
   endgenerate
     
   generate
     for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
       begin
         always @(*)
           begin
             sdp__xxx__get_next_line[chan] = get_next_line [chan] ;
           end
       end
   endgenerate
     
   // Dont read address until we are done. That way the pipe_addr is the valid start address
   assign  addr_to_strm_fsm_fifo[0].pipe_read           =  sdpr__sdps__complete  & streaming_complete ;
   
   assign  consJump_to_strm_fsm_fifo[0].pipe_read       =  (all_lanes_loaded_jump        ) | 
                                                           (all_lanes_loaded_consequtive ) ;
   
   
   always @(posedge clk)
     begin
       sdps__sdpr__complete   <= ( reset_poweron )  ? 1'b0 : 
                                                      streaming_complete ;
     end
   
   // Save jump and consequtive values while we are running thru the consequtive phase
   always @(*)
     begin
       consequtive_value_for_strm  = consJump_to_strm_fsm_fifo[0].pipe_consJumpValue  ;
       jump_value_for_strm         = consJump_to_strm_fsm_fifo[0].pipe_consJumpValue  ;
     end
   
   // We must only decrement the counter if the data is available and the response ID matches. 
   // Remember, we always read a cacheline, so if we only need one line of a two line cacheline, we have to flush the response ID fifo and the data fifo, so dont increment 
   // until the response_id matches and thus the data matches.
   
   //------------------------------------------------------------------------------------------------------------------------------------------------------
   // Check the output of the channel request ID fifo to determine if the output of the from_mmc fifo is the line bank/page/line we need
   // - use the "next" stream address
   
   
   // DO NOT put in above procedure as req_next_line uses lane_next_match
/*
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      always @(*) 
        begin
          response_id_ms_lane_match [chan]      =  (({strm_inc_ms_lane_bank, strm_inc_ms_lane_bank_lsb} == response_id_bank[strm_inc_ms_lane_channel]) & 
                                            (strm_inc_ms_lane_page == response_id_page[strm_inc_ms_lane_channel]) & 
                                            `ifdef MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                                              (strm_inc_ms_lane_line == response_id_line[strm_inc_ms_lane_channel]))  ;
                                            `else
                                              1'b0) ;
                                            `endif

          response_id_ms_lane_next_match [chan]  =  (({strm_inc_ms_lane_bank_e1, strm_inc_ms_lane_bank_lsb_e1} == response_id_bank[strm_inc_ms_lane_channel_e1]) & 
                                            (strm_inc_ms_lane_page_e1 == response_id_page[strm_inc_ms_lane_channel_e1]) & 
                                            `ifdef MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                                              (strm_inc_ms_lane_line_e1 == response_id_line[strm_inc_ms_lane_channel_e1]))  ;
                                            `else
                                              1'b0) ;
                                            `endif
        end
  endgenerate
*/
 
  assign  response_id_fifo_read[0] =  (running     & response_id_fifo[0].pipe_som & response_id_fifo[0].pipe_valid) |                // remove dummy SOM
                                      (running     & get_next_line[0]) |                                                   // track mmc data
                                      (force_flush & response_id_fifo[0].response_id_in_progress & response_id_fifo[0].pipe_valid);  // remove dummy EOM

  assign  response_id_fifo_read[1] =  (running     & response_id_fifo[1].pipe_som & response_id_fifo[1].pipe_valid) |
                                      (running     & get_next_line[1]) | 
                                      (force_flush & response_id_fifo[1].response_id_in_progress & response_id_fifo[1].pipe_valid);


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------


  
  //----------------------------------------------------------------------------------------------------
  //
  //
  //
endmodule

