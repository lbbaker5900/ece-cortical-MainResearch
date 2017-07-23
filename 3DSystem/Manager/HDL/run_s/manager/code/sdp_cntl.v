/*********************************************************************************************

    File name   : sdp_cntl.v
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


module sdp_cntl (  

            input   wire                                           xxx__sdp__storage_desc_processing_enable     ,
            output  reg                                            sdp__xxx__storage_desc_processing_complete   ,
            input   wire  [`MGR_STORAGE_DESC_ADDRESS_RANGE  ]      xxx__sdp__storage_desc_ptr                   ,  // pointer to local storage descriptor although msb's contain manager ID, so remove
            input   wire  [`MGR_NUM_LANES_RANGE             ]      xxx__sdp__num_lanes                          ,
            input   wire  [`MGR_INST_OPTION_TRANSFER_RANGE  ]      xxx__sdp__txfer_type                         ,
            input   wire  [`MGR_INST_OPTION_TGT_RANGE       ]      xxx__sdp__target                             ,

            //-------------------------------
            // Main Memory Controller interface
            // - response must be in order
            //
            output  reg                                            sdp__xxx__mem_request_valid              ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      sdp__xxx__mem_request_cntl               ,
            input   wire                                           xxx__sdp__mem_request_ready              ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      sdp__xxx__mem_request_channel            ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      sdp__xxx__mem_request_bank               ,
            output  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      sdp__xxx__mem_request_page               ,
            output  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE     ]      sdp__xxx__mem_request_word               ,

            input   wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   xxx__sdp__mem_request_channel_data_valid                          ,  // valid data from channel data fifo

            input   wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   xxx__sdp__mem_request_valid                                       ,
            //output  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   sdp__xxx__mem_request_ack                                         ,  // actually a read to the request feedback fifo
            // Contains the associated address for the next mmc line
            // - automatically updated when "get_line" is asserted
            input   wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]   xxx__sdp__mem_request_channel            [`MGR_DRAM_NUM_CHANNELS ],
            input   wire  [`MGR_DRAM_BANK_ADDRESS_RANGE        ]   xxx__sdp__mem_request_bank               [`MGR_DRAM_NUM_CHANNELS ],
            input   wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]   xxx__sdp__mem_request_page               [`MGR_DRAM_NUM_CHANNELS ],
            input   wire  [`MGR_DRAM_WORD_ADDRESS_RANGE        ]   xxx__sdp__mem_request_word               [`MGR_DRAM_NUM_CHANNELS ],
                                                                                                                    
            //-------------------------------
            // from MMC fifo Control
            output  reg   [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   sdp__xxx__get_next_line                                    ,
            output  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_valid                                       ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE         ]   sdp__xxx__lane_cntl                                        ,
            output  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_enable                                      ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]   sdp__xxx__lane_channel_ptr [`MGR_NUM_OF_EXEC_LANES_RANGE ] ,
            output  reg   [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE  ]   sdp__xxx__lane_word_ptr    [`MGR_NUM_OF_EXEC_LANES_RANGE ] ,
            output  reg                                            sdp__xxx__current_channel                                  ,
            input   wire  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   xxx__sdp__lane_ready                                       ,
           

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
 
  //--------------------------------------------------
  // to Main Memory Controller
  
  reg                                            sdp__xxx__mem_request_valid_e1      ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      sdp__xxx__mem_request_cntl_e1       ;
  reg                                            xxx__sdp__mem_request_ready_d1      ;
  reg   [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      sdp__xxx__mem_request_channel_e1    ;
  reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      sdp__xxx__mem_request_bank_e1       ;
  reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      sdp__xxx__mem_request_page_e1       ;
  reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      sdp__xxx__mem_request_word_e1       ;



  //--------------------------------------------------
  // to Main Memory Controller
  
  always @(posedge clk) 
    begin
      sdp__xxx__mem_request_valid      <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_valid_e1   ;
      sdp__xxx__mem_request_cntl       <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_cntl_e1    ;
      xxx__sdp__mem_request_ready_d1   <=   ( reset_poweron   ) ? 'd0  :  xxx__sdp__mem_request_ready      ;
      sdp__xxx__mem_request_channel    <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_channel_e1 ;
      sdp__xxx__mem_request_bank       <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_bank_e1    ;
      sdp__xxx__mem_request_page       <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_page_e1    ;
      sdp__xxx__mem_request_word       <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_word_e1    ;
    end

  wire                                            sdpr__sdps__cfg_valid       ;
  wire   [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]   sdpr__sdps__cfg_addr        ;
  wire   [`MGR_INST_OPTION_ORDER_RANGE        ]   sdpr__sdps__cfg_accessOrder ;
  wire                                            sdps__sdpr__cfg_ready       ;
  wire                                            sdps__sdpr__complete        ;
  wire                                            sdpr__sdps__complete        ;
                                                  
  wire                                            sdpr__sdps__consJump_valid  ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE         ]   sdpr__sdps__consJump_cntl   ;
  wire   [`MGR_INST_CONS_JUMP_RANGE           ]   sdpr__sdps__consJump_value  ;
  wire                                            sdps__sdpr__consJump_ready  ;

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Storage Descriptor Memory Request Generator
  // - Contains the storage descriptor and consequtive/jump memory
  // - generates memory requests and passes starting address and consequtive/jump values to the storage descriptor stream controller

  sdp_request_cntl sdp_request_cntl (  

            .xxx__sdp__storage_desc_processing_enable     ( xxx__sdp__storage_desc_processing_enable   ),
            //.sdp__xxx__storage_desc_processing_complete   ( sdp__xxx__storage_desc_processing_complete ),
            .sdp__xxx__storage_desc_processing_complete   ( ),
            .xxx__sdp__storage_desc_ptr                   ( xxx__sdp__storage_desc_ptr                 ),  // pointer to local storage descriptor although msb's contain manager ID, so remove
            .xxx__sdp__num_lanes                          ( xxx__sdp__num_lanes                        ),
            .xxx__sdp__txfer_type                         ( xxx__sdp__txfer_type                       ),
            .xxx__sdp__target                             ( xxx__sdp__target                           ),
/*
            .sdp__xxx__mem_request_valid                  ( sdp__xxx__mem_request_valid                ),
            .sdp__xxx__mem_request_cntl                   ( sdp__xxx__mem_request_cntl                 ),
*/
            .sdp__xxx__mem_request_valid                  ( ),
            .sdp__xxx__mem_request_cntl                   ( ),
            .xxx__sdp__mem_request_ready                  ( xxx__sdp__mem_request_ready                ),
/*
            .sdp__xxx__mem_request_channel                ( sdp__xxx__mem_request_channel              ),
            .sdp__xxx__mem_request_bank                   ( sdp__xxx__mem_request_bank                 ),
            .sdp__xxx__mem_request_page                   ( sdp__xxx__mem_request_page                 ),
            .sdp__xxx__mem_request_word                   ( sdp__xxx__mem_request_word                 ),
*/
            .sdp__xxx__mem_request_channel                ( ),
            .sdp__xxx__mem_request_bank                   ( ),
            .sdp__xxx__mem_request_page                   ( ),
            .sdp__xxx__mem_request_word                   ( ),

            .sdpr__sdps__cfg_valid                        ( sdpr__sdps__cfg_valid                      ),
            .sdpr__sdps__cfg_addr                         ( sdpr__sdps__cfg_addr                       ),
            .sdpr__sdps__cfg_accessOrder                  ( sdpr__sdps__cfg_accessOrder                ),
            .sdps__sdpr__cfg_ready                        ( sdps__sdpr__cfg_ready                      ),
            .sdps__sdpr__complete                         ( sdps__sdpr__complete                       ),
            .sdpr__sdps__complete                         ( sdpr__sdps__complete                       ),

            .sdpr__sdps__consJump_valid                   ( sdpr__sdps__consJump_valid                 ),
            .sdpr__sdps__consJump_cntl                    ( sdpr__sdps__consJump_cntl                  ),
            .sdpr__sdps__consJump_value                   ( sdpr__sdps__consJump_value                 ),
            .sdps__sdpr__consJump_ready                   ( sdps__sdpr__consJump_ready                 ),

            //------------------------------
            // General
            //
            .sys__mgr__mgrId                              ( sys__mgr__mgrId ),
            .clk                                          ( clk             ),
            .reset_poweron                                ( reset_poweron   )
                        );
 
  sdp_stream_cntl sdp_stream_cntl (  

            .xxx__sdp__storage_desc_processing_enable     ( xxx__sdp__storage_desc_processing_enable   ),
            .xxx__sdp__storage_desc_ptr                   ( xxx__sdp__storage_desc_ptr                 ),  // pointer to local storage descriptor although msb's contain manager ID, so remove
            .xxx__sdp__num_lanes                          ( xxx__sdp__num_lanes                        ),
            .xxx__sdp__txfer_type                         ( xxx__sdp__txfer_type                       ),
            .xxx__sdp__target                             ( xxx__sdp__target                           ),

            //-------------------------------
            // from MMC fifo Control
            .xxx__sdp__mem_request_channel_data_valid                ,  // valid data from channel data fifo and downstream ready

            // Contains the associated address for the next mmc line
            // - automatically updated when "get_line" is asserted
            .xxx__sdp__mem_request_valid                  ( xxx__sdp__mem_request_valid              ),
            .xxx__sdp__mem_request_channel                ( xxx__sdp__mem_request_channel            ),
            .xxx__sdp__mem_request_bank                   ( xxx__sdp__mem_request_bank               ),
            .xxx__sdp__mem_request_page                   ( xxx__sdp__mem_request_page               ),
            .xxx__sdp__mem_request_word                   ( xxx__sdp__mem_request_word               ),
            //.sdp__xxx__mem_request_ack   (  ),  // actually a read to the request feedback fifo
/*
            .sdp__xxx__get_next_line                      ( sdp__xxx__get_next_line                    ),
            .sdp__xxx__lane_valid                         ( sdp__xxx__lane_valid                       ),
            .sdp__xxx__lane_cntl                          ( sdp__xxx__lane_cntl                        ),
            .sdp__xxx__lane_enable                        ( sdp__xxx__lane_enable                      ),
            .sdp__xxx__lane_channel_ptr                   ( sdp__xxx__lane_channel_ptr                 ),
            .sdp__xxx__lane_word_ptr                      ( sdp__xxx__lane_word_ptr                    ),
            .sdp__xxx__current_channel                    ( sdp__xxx__current_channel                  ),
*/
            .sdp__xxx__get_next_line                      (               ),
            .sdp__xxx__lane_valid                         (               ),
            .sdp__xxx__lane_cntl                          (               ),
            .sdp__xxx__lane_enable                        (               ),
            .sdp__xxx__lane_channel_ptr                   (               ),
            .sdp__xxx__lane_word_ptr                      (               ),
            .sdp__xxx__current_channel                    (               ),

            .xxx__sdp__lane_ready                         ( xxx__sdp__lane_ready                       ),
           

            //-------------------------------
            // from Storage Descriptor request control
            // - sent here during request generation request generation happens faster than streaming
            // - two buses :, cfg contains start address and access order and we receive one transaction per stream
            //                consJump contains the set of consequtive/jump fields which may be one or more
            //
            .sdpr__sdps__cfg_valid                        ( sdpr__sdps__cfg_valid                      ),
            .sdpr__sdps__cfg_addr                         ( sdpr__sdps__cfg_addr                       ),
            .sdpr__sdps__cfg_accessOrder                  ( sdpr__sdps__cfg_accessOrder                ),
            .sdps__sdpr__cfg_ready                        ( sdps__sdpr__cfg_ready                      ),
            .sdps__sdpr__complete                         ( sdps__sdpr__complete                       ),
            .sdpr__sdps__complete                         ( sdpr__sdps__complete                       ),

            .sdpr__sdps__consJump_valid                   ( sdpr__sdps__consJump_valid                 ),
            .sdpr__sdps__consJump_cntl                    ( sdpr__sdps__consJump_cntl                  ),
            .sdpr__sdps__consJump_value                   ( sdpr__sdps__consJump_value                 ),
            .sdps__sdpr__consJump_ready                   ( sdps__sdpr__consJump_ready                 ),

            //
            //-------------------------------
            // General
            //
            .sys__mgr__mgrId                              ( sys__mgr__mgrId ),
            .clk                                          ( clk             ),
            .reset_poweron                                ( reset_poweron   )
                        );

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Process Descriptor FSM
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // - Take storage descriptor option tuples from the WU fifo and construct starting address, number of lanes
  //   target and transfer type (vector/scalar).
  // - Send initial memory request based on starting channel/bank/page/word
  //   Extract the consequtive/jump tuples and pipeline memory requests
  //   Pass the consequtive/jump tuples to another fifo which will be processed by the streaming fsm
  //   Note: We have to send to another fifo because we want to pipeline the memory page accesses
  // - With memory requests, we always request the starting chan/bank/page but we will also grab the next channel also.
  //   So we need to form an address using only the chan, bank and page based on the increment order of page,bank,chan and increment and request this chan/bank/page also
      
  // State register 
  reg [`SDP_CNTL_PROC_STORAGE_DESC_STATE_RANGE ] sdp_cntl_proc_storage_desc_state      ; // state flop
  reg [`SDP_CNTL_PROC_STORAGE_DESC_STATE_RANGE ] sdp_cntl_proc_storage_desc_state_next ;

  always @(posedge clk)
    begin
      sdp_cntl_proc_storage_desc_state <= ( reset_poweron ) ? `SDP_CNTL_PROC_STORAGE_DESC_WAIT        :
                                                               sdp_cntl_proc_storage_desc_state_next  ;
    end
  
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------


  // the storage pointers are array wide and include manager ID in MSB's, so remove for address to local storage pointer memory
  wire  [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE ]      local_storage_desc_ptr =  xxx__sdp__storage_desc_ptr [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE] ;  // remove manager ID msb's

  // need to loop thru all consequtive jump fields until we hit EOM
  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]  consJumpMemory_cntl       ;  // cons/jump delineator
  reg   [`MGR_INST_CONS_JUMP_RANGE                      ]  consJumpMemory_value      ;  // cons/jump value
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  consJumpPtr               ;
  reg                                                      inc_consJumpPtr           ;  // cycle thru consequtive and jump memory
                                                                                     
  reg   [`MGR_DRAM_ADDRESS_RANGE                        ]  storage_desc_address       ;  // main memory address in storage descriptor
  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE                  ]  storage_desc_local_address ;  // local main memory address in storage descriptor
  reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]  storage_desc_accessOrder   ;  // how to increment Chan/Bank/Page/Word e.g. CWBP, WCBP
  wire                                                     consJumpMemory_som         ;
  wire                                                     consJumpMemory_som_eom     ;
  wire                                                     consJumpMemory_eom         ;
  reg                                                      first_time_thru            ;  // need to make sure for the first cycle we request the starting bank/page
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  storage_desc_consJumpPtr   ;

  wire                                                     to_strm_fsm_fifo_ready    ;

  reg                                                      requests_complete         ;
  reg                                                      generate_requests         ;
  reg   [`SDP_CNTL_CHAN_BIT_RANGE                       ]  channel_requested         ;  // which channels have been requested with current bank/page
  reg                                                      bank_change               ;  // check current increment vs previous last request
  reg                                                      page_change               ;
  reg                                                      channel_change            ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg    [`SDP_CNTL_LINE_BIT_RANGE                    ]  line_requested            ;  // which lines have been requested with current bank/page
    reg                                                    line_change               ;
  `endif

  // The SDP_CNTL_DESC FSM extracts the decriptor and handles memory requests
  // The SDP_CNTL_STRM FSM increments thru the words in the from_mmc_fifo
  //
  reg  desc_processor_strm_ack  ;  // ack the strm fsm to allow both fsm's to complete together
  reg  completed_streaming      ;  // strm fsm has completed the cons/jump memory tuples

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // State Transitions
  
  always @(*)
    begin
      case (sdp_cntl_proc_storage_desc_state)
        
        `SDP_CNTL_PROC_STORAGE_DESC_WAIT: 
          sdp_cntl_proc_storage_desc_state_next =   ( xxx__sdp__storage_desc_processing_enable ) ? `SDP_CNTL_PROC_STORAGE_DESC_READ : 
                                                                                         `SDP_CNTL_PROC_STORAGE_DESC_WAIT ;
  

        //----------------------------------------------------------------------------------------------------
        // We have cycled thru the descriptor and extracted all information
        // e.g.
        // - storage descriptor pointer
        // - number of lanes
        // - transfer type
        // - target
  
        // The storage descriptor pointer is valid in this state, the memory is registered so it will be valid next state
        // - send the storage descriptor address field to the main system memory (DRAM)
        `SDP_CNTL_PROC_STORAGE_DESC_READ: 
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID ;
                                      
        // Storage Descriptor address is valid so we can send the memory request
        // Pointer to cons/jump memory will be valid, now wait one clk for output of consequtive/jump memory to be valid
        // Always generate requests first time in, so jump to GENERATE_REQ
        `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID: 
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA;
                                      
        // Memory requests will occur if the consequtive increment moves to another page
        // Make sure we transition right thru this state
        `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA : 
       //   sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHB   ;
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC      ;

       // `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHB : 
       //   sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC      ;

        // Make sure strm fifo can take cons/jump before reading
        // - mem_end currently points to beginning of next consequtive phase
        `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO : 
          sdp_cntl_proc_storage_desc_state_next =  ( to_strm_fsm_fifo_ready) ? `SDP_CNTL_PROC_STORAGE_DESC_CONS_FIELD           :
                                                                  `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO      ;


        // Cycle thru all cons/jump fields
        //
        `SDP_CNTL_PROC_STORAGE_DESC_CONS_FIELD: 
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS ;

        // we now have the start address and end of cons/jump phase address
        // set pbc_inc to start and pbc_end to boundaries of consequtive phase.
        `SDP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS: 
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC ;

        // start points to first consequtive address, end points to last consequtive address
        // pbc_last_end points to last address of previous consequtive phase
        // pbc_inc is the first address of the current consequtive phase
        // CHeck if last_end != inc. If so, generate requests and set last_end = inc
        `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC: 
          sdp_cntl_proc_storage_desc_state_next =  ( first_time_thru                              ) ? `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO       :  // we will get here first time thru after the initial request
                                                   ( generate_requests                            ) ? `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA      :
                                                   ( requests_complete  && ~consJumpMemory_eom    ) ? `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD            :
                                                   ( requests_complete  &&  consJumpMemory_eom    ) ? `SDP_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE  :
                                                                                                      `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC               ;

        `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD: 
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO    ;

        // Cycle thru all cons/jump fields
        `SDP_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE: 
          sdp_cntl_proc_storage_desc_state_next =  (completed_streaming)  ? `SDP_CNTL_PROC_STORAGE_DESC_COMPLETE             :
                                                                            `SDP_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE ;

        `SDP_CNTL_PROC_STORAGE_DESC_COMPLETE: 
          sdp_cntl_proc_storage_desc_state_next =   (~xxx__sdp__storage_desc_processing_enable ) ? `SDP_CNTL_PROC_STORAGE_DESC_WAIT : 
                                                                                         `SDP_CNTL_PROC_STORAGE_DESC_COMPLETE ;
  
  
        // May not need all these states, but it will help with debug
        // Latch state on error
        `SDP_CNTL_PROC_STORAGE_DESC_ERR:
          sdp_cntl_proc_storage_desc_state_next = `SDP_CNTL_PROC_STORAGE_DESC_ERR ;
  
        default:
          sdp_cntl_proc_storage_desc_state_next = `SDP_CNTL_PROC_STORAGE_DESC_WAIT ;
    
      endcase // case (sdp_cntl_proc_storage_desc_state)
    end // always @ (*)
  
  //----------------------------------------------------------------------------------------------------
  // Assignments

  always @(posedge clk)
    begin
      sdp__xxx__storage_desc_processing_complete  <= ( reset_poweron )  ? 1'b0 : 
                                                                ( sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_COMPLETE) ;

    end

  always @(posedge clk)
    begin
      desc_processor_strm_ack  <= ( reset_poweron )  ? 1'b0 : 
                                                       ( sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE) ;

    end

  // Extract address fields from storage pointer address
  //  - for debug right now

  reg  [ `MGR_MGR_ID_RANGE              ]    storage_desc_mgr     ;
  reg  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE]    storage_desc_channel ;
  reg  [ `MGR_DRAM_BANK_ADDRESS_RANGE   ]    storage_desc_bank    ;
  reg  [ `MGR_DRAM_PAGE_ADDRESS_RANGE   ]    storage_desc_page    ;
`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  reg  [ `MGR_DRAM_LINE_ADDRESS_RANGE   ]    storage_desc_line    ;  // if a dram access reads less than a page, we need to generate additional memory requests when we transition a line
`endif
  reg  [ `MGR_DRAM_WORD_ADDRESS_RANGE   ]    storage_desc_word    ;
  always @(*)
    begin
      storage_desc_local_address  =  storage_desc_address[`MGR_DRAM_LOCAL_ADDRESS_RANGE      ]  ;
      storage_desc_mgr            =  storage_desc_address[`MGR_DRAM_ADDRESS_MGR_FIELD_RANGE  ]  ;
      storage_desc_channel        =  storage_desc_address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  ;
      storage_desc_bank           =  storage_desc_address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  ;
      storage_desc_page           =  storage_desc_address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  ;
      `ifdef  MGR_DRAM_REQUEST_LT_PAGE
        storage_desc_line         =  storage_desc_address[`MGR_DRAM_ADDRESS_LINE_FIELD_RANGE ]  ;
      `endif
      storage_desc_word           =  storage_desc_address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  ;
    end
          
  // Form an address using the base address fields ordered based on access order
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]    mem_start_address     ;  // Start address for a consequtive phase
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]    mem_end_address       ;  // address we increment for each jump
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]    mem_last_end_address       ;  // address we increment for each jump

  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg  [`MGR_DRAM_PBCL_RANGE              ]    pbc_end_addr         ;  // 
    reg  [`MGR_DRAM_PBCL_RANGE              ]    pbc_inc_addr         ;  // 
    reg  [`MGR_DRAM_PBCL_RANGE              ]    pbc_last_end_addr    ;  // last requested. Use to check for changes during increment
  `else
    reg  [`MGR_DRAM_PBC_RANGE               ]    pbc_end_addr         ;  // 
    reg  [`MGR_DRAM_PBC_RANGE               ]    pbc_inc_addr         ;  // 
    reg  [`MGR_DRAM_PBC_RANGE               ]    pbc_last_end_addr    ;  // last requested. Use to check for changes during increment
  `endif
 
  reg  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]    mem_start_channel   ;
  reg  [ `MGR_DRAM_BANK_ADDRESS_RANGE       ]    mem_start_bank      ;
  reg  [ `MGR_DRAM_PAGE_ADDRESS_RANGE       ]    mem_start_page      ;
  reg  [ `MGR_DRAM_WORD_ADDRESS_RANGE       ]    mem_start_word      ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg  [ `MGR_DRAM_LINE_ADDRESS_RANGE     ]    mem_start_line      ;
  `endif

  reg  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]    mem_end_channel       ;  // formed address in access order for incrementing
  reg  [ `MGR_DRAM_BANK_ADDRESS_RANGE       ]    mem_end_bank          ;
  reg  [ `MGR_DRAM_PAGE_ADDRESS_RANGE       ]    mem_end_page          ;
  reg  [ `MGR_DRAM_WORD_ADDRESS_RANGE       ]    mem_end_word          ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg  [ `MGR_DRAM_LINE_ADDRESS_RANGE     ]    mem_end_line          ;
  `endif

  reg  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]    mem_last_end_channel       ;  // formed address in access order for incrementing
  reg  [ `MGR_DRAM_BANK_ADDRESS_RANGE       ]    mem_last_end_bank          ;
  reg  [ `MGR_DRAM_PAGE_ADDRESS_RANGE       ]    mem_last_end_page          ;
  reg  [ `MGR_DRAM_WORD_ADDRESS_RANGE       ]    mem_last_end_word          ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg  [ `MGR_DRAM_LINE_ADDRESS_RANGE     ]    mem_last_end_line          ;
  `endif

  always @(posedge clk)
    begin
      first_time_thru <= (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_WAIT    ) ? 1'b1            :
                         (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC ) ? 1'b0            :
                                                                            first_time_thru ;  
    end

  reg create_mem_request ;
  always @(*)
    begin 
      create_mem_request  = ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA  ))  ; //|
    end

`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  always @(*)
    begin
      case (storage_desc_accessOrder)  // synopsys parallel_case full_case
        PY_WU_INST_ORDER_TYPE_WCBP :
          begin
            requests_complete =  (pbc_end_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ] ) ;
                                            
            
            bank_change       =  (pbc_last_end_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] ) ;  // as we increment thru the consequtive phase, check if we have changed bank or page
            page_change       =  (pbc_last_end_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] ) ;  
            channel_change    =  (pbc_last_end_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ) ;  
            line_change       =  (pbc_last_end_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ] ) ;  
            
            generate_requests =  (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC                     ) &
                                 (  bank_change                                                      |
                                    page_change                                                      |
                                    ( channel_change & (~channel_requested[pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]])) |
                                    ( line_change    & (~line_requested   [pbc_inc_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ]]))) ;
          end
        PY_WU_INST_ORDER_TYPE_CWBP :
          begin
            requests_complete =  (pbc_end_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ] ) ;
                                            
            
            bank_change       =  (pbc_last_end_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] ) ;  // as we increment thru the consequtive phase, check if we have changed bank or page
            page_change       =  (pbc_last_end_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] ) ;  
            channel_change    =  (pbc_last_end_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] ) ;  
            line_change       =  (pbc_last_end_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ] ) ;  
            
            generate_requests =  (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC                     ) &
                                 (  bank_change                                                      |
                                    page_change                                                      |
                                    ( channel_change & (~channel_requested[pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ]])) |
                                    ( line_change    & (~line_requested   [pbc_inc_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ]]))) ;
          end
      endcase
    end
                                         
`else
  always @(*)
    begin
      requests_complete =  (pbc_end_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ) &
                           (pbc_end_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ) &
                           (pbc_end_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ) ;
                                      
      
      bank_change       =  (pbc_last_end_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ) ;  // as we increment thru the consequtive phase, check if we have changed bank or page
      page_change       =  (pbc_last_end_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ) ;  
      channel_change    =  (pbc_last_end_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ) ;  
      
      generate_requests =  (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC                     ) &
                           (  bank_change                                                      |
                              page_change                                                      |
                              ( channel_change & (~channel_requested[pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ]]))) ;
    end
                                         
`endif
                                         

  //---------------------------------------------------------------------------------
  // Consequtive/Jump Memory Control
  //

  // address the cons/jump memory as soon as the pointer from the main storage
  // desc memory is valid but then use address from fsm
  always @(posedge clk)
    begin
      consJumpPtr <= ( sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID  ) ? storage_desc_consJumpPtr : // grab cons/jump ptr from descriptor
                     ( inc_consJumpPtr                                      ) ? consJumpPtr+1            :
                                                                                consJumpPtr              ;
         
    end

  // increment the ptr each time we are about to enter that the state that uses the output
  always @(*)
    begin
      inc_consJumpPtr     =  ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC          ) &  requests_complete & ~generate_requests & ~consJumpMemory_som & ~consJumpMemory_eom ) |  // transition to JUMP state
                             ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO  ) &  to_strm_fsm_fifo_ready                                       & ~consJumpMemory_eom ) ;  // transition to CONS state
    end

  //----------------------------------------------------------------------------------------------------
  //
  // Construct Memory requests
  //
  // These regs will be initialized to the storage descriptor base address and then incremented based on access order
  // When the addresses transtition to another bank or page, a memory request will be generated


  // Set end of current consequtive phase
  always @(posedge clk)
    begin
      // Initialize starting increment address
      if ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) && (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID ))
        begin
          mem_end_address      <=  {storage_desc_page, storage_desc_bank, storage_desc_channel, storage_desc_word, 2'b00} ;  // byte address
        end
      else if ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) && (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID ))
        begin
          mem_end_address      <=  {storage_desc_page, storage_desc_bank, storage_desc_word, storage_desc_channel, 2'b00} ;  // byte address
        end
      // increment using number of consequtive onyy if strm fsm can take the cons/jump
      else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CONS_FIELD ) 
        begin
          // FIXME: Need to accomodate a consequtive value traversing multiple bank/pages
          // Jump value is from previous end location so add consequtive and jump to start address to get next start address
          mem_end_address      <=  mem_end_address + {consJumpMemory_value, 2'b00} ;  // account for byte address 
        end
      // increment using jump 
      else if ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD ) && ~consJumpMemory_eom)
        begin
          // Jump value is from previous inc location
          mem_end_address   <=  mem_end_address + {consJumpMemory_value, 2'b00} ;  // account for byte address
        end
    end

  always @(posedge clk)
    begin
      if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID )
        begin
          mem_start_address <=  {storage_desc_channel, storage_desc_bank, storage_desc_page, storage_desc_word, 2'b00} ;
        end
      // when we enter the CHECK_STRM state the mem_end address points to beginning of next consequtive phase
      else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO )
        begin
          mem_start_address <=  {mem_end_channel, mem_end_bank, mem_end_page, mem_end_word, 2'b00} ;
        end
    end

  always @(posedge clk)
    begin
      if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID )
        begin
          if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
            begin
              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                pbc_inc_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_channel, storage_desc_line};
              `else
                pbc_inc_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_channel};
              `endif
            end
          else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP)
            begin
              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                pbc_inc_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_line, storage_desc_channel};
              `else
                pbc_inc_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_channel};
              `endif
            end
        end
      else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS )
        begin
          if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
            begin
              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                pbc_inc_addr    <=  {mem_start_page, mem_start_bank, mem_start_channel, mem_start_line} ;
              `else
                pbc_inc_addr    <=  {mem_start_page, mem_start_bank, mem_start_channel} ;
              `endif
            end
          else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP)
            begin
              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                pbc_inc_addr    <=  {mem_start_page, mem_start_bank, mem_start_line, mem_start_channel} ;
              `else
                pbc_inc_addr    <=  {mem_start_page, mem_start_bank, mem_start_channel} ;
              `endif
            end
        end
      // increment during first request to generate second request chan/bank/page
      else if ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC ) && ~generate_requests)
        begin
          pbc_inc_addr    <=  pbc_inc_addr + 'd1 ;
        end

      // the request may occur with inc == end, so dont increment past end
      else if ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA ) && ~requests_complete)
        begin
          pbc_inc_addr    <=  pbc_inc_addr + 'd1 ;
        end
    end

  genvar chan;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: chan_requested
        always @(posedge clk)
          begin
            if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_WAIT )
              begin
                channel_requested[chan]    <=  1'b0    ;
              end
            if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS )
              begin
                channel_requested[chan]    <= (mem_start_bank != mem_last_end_bank) ? 1'b0                    :
                                              (mem_start_page != mem_last_end_page) ? 1'b0                    :
                                                                                      channel_requested[chan] ;
              end
            else if ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC ) && generate_requests)
              begin
                channel_requested[chan]    <= (bank_change                                                               ) ? 1'b0                    :
                                              (page_change                                                               ) ? 1'b0                    :
                                              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                                                ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) && line_change ) ? 1'b0                    :
                                              `endif
                                                                                                                             channel_requested[chan] ;
              end
            else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA )
              begin
                // if we are about to request <chan>, make sure it hasnt been requested already with this bank and page
                if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
                  begin
                    `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                      channel_requested[chan]    <=  (pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] == chan) ? 1'b1                    :
                                                                                                                channel_requested[chan] ;
                    `else
                      channel_requested[chan]    <=  (pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] == chan) ? 1'b1                    :
                                                                                                               channel_requested[chan] ;
                    `endif
                  end
                else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
                  begin
                    `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                      channel_requested[chan]    <=  (pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] == chan) ? 1'b1                    :
                                                                                                                channel_requested[chan] ;
                    `else
                      channel_requested[chan]    <=  (pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] == chan) ? 1'b1                    :
                                                                                                               channel_requested[chan] ;
                    `endif
                  end
              end
          end
      end
  endgenerate

`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  genvar line;
  generate
    for (line=0; line<`MGR_DRAM_NUM_LINES ; line=line+1) 
      begin: line_req
        always @(posedge clk)
          begin
            if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_WAIT )
              begin
                line_requested[line]    <=  1'b0    ;
              end
            if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS )
              begin
                line_requested[line]    <= (mem_start_bank    != mem_last_end_bank   ) ? 1'b0                 :
                                           (mem_start_page    != mem_last_end_page   ) ? 1'b0                 :
                                           (mem_start_channel != mem_last_end_channel) ? 1'b0                 :
                                                                                         line_requested[line] ;
              end
            else if ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC ) && generate_requests)
              begin
                line_requested[line]    <= (bank_change                                                                ) ? 1'b0                 :
                                           (page_change                                                                ) ? 1'b0                 :
                                           ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) && channel_change ) ? 1'b0                 :
                                                                                                                           line_requested[line] ;
              end
            else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA )
              begin
                // if we are about to request <line>, make sure it hasnt been requested already with this bank and page
                line_requested[line]    <=  ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) && (pbc_inc_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ] == line)) ? 1'b1                 :
                                            ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) && (pbc_inc_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ] == line)) ? 1'b1                 :
                                                                                                                                                                     line_requested[line] ;
              end
          end
      end
  endgenerate
`endif


  always @(posedge clk)
    begin
      if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID )
        begin
          // set req == end to generate the first requests
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
            if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                pbc_end_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_channel, storage_desc_line};
              end
            else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                pbc_end_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_line, storage_desc_channel};
              end
          `else
            pbc_end_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_channel};
          `endif
        end
      else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS )
        begin
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
            if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                pbc_end_addr <=  {mem_end_page, mem_end_bank, mem_end_channel, mem_end_line};
              end
            else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                pbc_end_addr <=  {mem_end_page, mem_end_bank, mem_end_line, mem_end_channel};
              end
          `else
            pbc_end_addr <=  {mem_end_page, mem_end_bank, mem_end_channel};
          `endif
        end
    end

  always @(posedge clk)
    begin
      if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID )
        begin
          mem_last_end_address <=  {storage_desc_channel, storage_desc_bank, storage_desc_page, storage_desc_word, 2'b00} ;
        end
      else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD )
        begin
          // mem_addr is current set to end of CONS phase, so set last req to end of previous consequtive phase
          mem_last_end_address <=  {mem_end_channel, mem_end_bank, mem_end_page, mem_end_word, 2'b00} ;
        end
    end

  always @(posedge clk)
    begin
      if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID )
        begin
          if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
            begin
              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                pbc_last_end_addr    <=  {storage_desc_page, storage_desc_bank, storage_desc_channel, storage_desc_line};
              `else
                pbc_last_end_addr    <=  {storage_desc_page, storage_desc_bank, storage_desc_channel};
              `endif
            end
          else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
            begin
              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                pbc_last_end_addr    <=  {storage_desc_page, storage_desc_bank, storage_desc_line, storage_desc_channel};
              `else
                pbc_last_end_addr    <=  {storage_desc_page, storage_desc_bank, storage_desc_channel};
              `endif
            end
        end
      else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD )
        begin
          // mem_addr is current set to end of CONS phase, so set last req to end of previous consequtive phase
          if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
            begin
              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                pbc_last_end_addr    <=  {mem_end_page, mem_end_bank, mem_end_channel, mem_end_line};
              `else
                pbc_last_end_addr    <=  {mem_end_page, mem_end_bank, mem_end_channel};
              `endif
            end
          else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
            begin
              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                pbc_last_end_addr    <=  {mem_end_page, mem_end_bank, mem_end_line, mem_end_channel};
              `else
                pbc_last_end_addr    <=  {mem_end_page, mem_end_bank, mem_end_channel};
              `endif
            end
        end
      //else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHB )
      else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA )
        begin
          // mem_addr is current set to end of CONS phase, so set last req to end of previous consequtive phase
          if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
            begin
             `ifdef  MGR_DRAM_REQUEST_LT_PAGE
               pbc_last_end_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ] ;
             `else
               pbc_last_end_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
             `endif
            end
          else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
            begin
             `ifdef  MGR_DRAM_REQUEST_LT_PAGE
               pbc_last_end_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ] ;
             `else
               pbc_last_end_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ;
               pbc_last_end_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] <= pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
             `endif
            end
        end
    end

  // extract chan/bank/page/word fields from ordered address
  always @(*)
    begin
      if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
        begin
          mem_end_channel =  mem_end_address[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
          mem_end_bank    =  mem_end_address[`MGR_DRAM_WCBP_ORDER_BANK_FIELD_RANGE ]  ;
          mem_end_page    =  mem_end_address[`MGR_DRAM_WCBP_ORDER_PAGE_FIELD_RANGE ]  ;
          mem_end_word    =  mem_end_address[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
            mem_end_line    =  mem_end_address[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
          `endif
        end
      else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
        begin
          mem_end_channel =  mem_end_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
          mem_end_bank    =  mem_end_address[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
          mem_end_page    =  mem_end_address[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
          mem_end_word    =  mem_end_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
            mem_end_line    =  mem_end_address[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
          `endif
        end
    end

  // extract chan/bank/page/word fields from previous request address
  always @(*)
    begin
      mem_start_channel =  mem_start_address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  ;
      mem_start_bank    =  mem_start_address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  ;
      mem_start_page    =  mem_start_address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  ;
      mem_start_word    =  mem_start_address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  ;
      `ifdef  MGR_DRAM_REQUEST_LT_PAGE
        mem_start_line    =  mem_start_address[`MGR_DRAM_ADDRESS_LINE_FIELD_RANGE ]  ;
      `endif
    end

  always @(*)
    begin
      mem_last_end_channel =  mem_last_end_address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  ;
      mem_last_end_bank    =  mem_last_end_address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  ;
      mem_last_end_page    =  mem_last_end_address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  ;
      mem_last_end_word    =  mem_last_end_address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  ;
      `ifdef  MGR_DRAM_REQUEST_LT_PAGE
        mem_last_end_line    =  mem_last_end_address[`MGR_DRAM_ADDRESS_LINE_FIELD_RANGE ]  ;
      `endif
    end


  always @(*)
    begin
      sdp__xxx__mem_request_valid_e1   =  create_mem_request                            ;
      sdp__xxx__mem_request_cntl_e1    = `COMMON_STD_INTF_CNTL_SOM_EOM                  ;  // memory request is single cycle
      case (storage_desc_accessOrder)  // synopsys parallel_case full_case
        PY_WU_INST_ORDER_TYPE_WCBP :
          begin
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
              sdp__xxx__mem_request_channel_e1 =  pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
              sdp__xxx__mem_request_bank_e1    =  pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] ;
              sdp__xxx__mem_request_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] ;
              sdp__xxx__mem_request_word_e1    = {pbc_inc_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ], {`MGR_DRAM_WORD_ADDRESS_WIDTH-`MGR_DRAM_LINE_ADDRESS_WIDTH {1'b0}}} ;
            `else
              sdp__xxx__mem_request_channel_e1 =  pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
              sdp__xxx__mem_request_bank_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ;
              sdp__xxx__mem_request_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              sdp__xxx__mem_request_word_e1    =  'd0                                           ;
            `endif
          end
        PY_WU_INST_ORDER_TYPE_CWBP :
          begin
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
              sdp__xxx__mem_request_channel_e1 =  pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] ;
              sdp__xxx__mem_request_bank_e1    =  pbc_inc_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] ;
              sdp__xxx__mem_request_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] ;
              sdp__xxx__mem_request_word_e1    = {pbc_inc_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ], {`MGR_DRAM_WORD_ADDRESS_WIDTH-`MGR_DRAM_LINE_ADDRESS_WIDTH {1'b0}}} ;
            `else
              sdp__xxx__mem_request_channel_e1 =  pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
              sdp__xxx__mem_request_bank_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ;
              sdp__xxx__mem_request_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              sdp__xxx__mem_request_word_e1    =  'd0                                           ;
            `endif
          end
      endcase
    end


  //---------------------------------------------------------------------------------
  //---------------------------------------------------------------------------------
  // DRAM Address and Consequtive/Jump FIFOs to stream fsm
  //  - two FIFOs
  //    a) all the consequtive and jump fields along with cntl for delineation
  //    b) single address associated with each cons/jump group 
  //
  //  a) Cons/Jump FIFO
  genvar gvi ;
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

    
        wire   [`COMMON_STD_INTF_CNTL_RANGE ]  pipe_consJumpCntl   ;
        wire   [`MGR_INST_CONS_JUMP_RANGE   ]  pipe_consJumpValue ;
        assign  {pipe_consJumpCntl, pipe_consJumpValue} = pipe_data ;

        wire   pipe_som     =  (pipe_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM    ); 
        wire   pipe_eom     =  (pipe_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_consJumpCntl == `COMMON_STD_INTF_CNTL_EOM);
      end
  endgenerate

  reg  to_strm_fsm_fifo_write ;
  always @(*)
    begin
     to_strm_fsm_fifo_write  = (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CONS_FIELD) | (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD) ;
    end

  assign  consJump_to_strm_fsm_fifo[0].clear       = 1'b0    ;
  assign  consJump_to_strm_fsm_fifo[0].write       = to_strm_fsm_fifo_write  ;
  assign  consJump_to_strm_fsm_fifo[0].write_data  = {consJumpMemory_cntl, consJumpMemory_value};


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

    
        wire   [`MGR_DRAM_LOCAL_ADDRESS_RANGE    ]  pipe_addr           ;
        wire   [`MGR_INST_OPTION_ORDER_RANGE     ]  pipe_order          ;
        wire   [`MGR_INST_OPTION_TGT_RANGE       ]  pipe_tgt            ;
        wire   [`MGR_INST_OPTION_TRANSFER_RANGE  ]  pipe_transfer_type  ;
        wire   [`MGR_NUM_LANES_RANGE             ]  pipe_num_lanes      ;  // 0-32 so need 6 bits
        assign  {pipe_num_lanes, pipe_transfer_type, pipe_tgt, pipe_order, pipe_addr}        = pipe_data   ;

      end
  endgenerate

  assign  addr_to_strm_fsm_fifo[0].clear       = 1'b0    ;
  assign  addr_to_strm_fsm_fifo[0].write       = (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID) ;
  assign  addr_to_strm_fsm_fifo[0].write_data  = {xxx__sdp__num_lanes, xxx__sdp__txfer_type, xxx__sdp__target, storage_desc_accessOrder, storage_desc_local_address} ;


  // Flow control DESC fsm if either fifo becomes almost full
  assign  to_strm_fsm_fifo_ready    = ~consJump_to_strm_fsm_fifo[0].almost_full & ~addr_to_strm_fsm_fifo[0].almost_full ;


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



  // end of to stream fifo's
  //---------------------------------------------------------------------------------
  //
 
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Memories
  //----------------------------------------------------------------------------------------------------
  //

  //--------------------------------------------------
  // Storage Descriptor Memory
  
  // The sorage descriptor pointer in the descriptor points to a location in this memory
  // There are 5 memory
  //   i) Address_mem       - Starting address of storage
  //  ii) AccessOrder_mem   - How the memory will be accessed
  // iii) consJumpPtr_mem   - pointer to the first consequtive field in the consJumpPtr
  //  iv) consJumpCntl_mem  - consequtive/jump field delineation
  //   v) consJump_mem      - consequtive/jump value
  
  // FIXME: instantiate one real memory for now to ensure funcrionality
  // Will need to merge Address_mem, AccessOrder_mem and consJumpPtr_mem into one device
  // e.g. merge memories 1,2,3 and merge 4,5
  
  wire   [`MGR_DRAM_ADDRESS_RANGE                        ]  sdmem_Address       ;
  wire   [`MGR_INST_OPTION_ORDER_RANGE                   ]  sdmem_AccessOrder   ;
  wire   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  sdmem_consJumpPtr   ;


  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: storageDesc_mem

        generic_1port_memory #(.GENERIC_MEM_DEPTH          (`MGR_LOCAL_STORAGE_DESC_MEMORY_DEPTH  ),
                               .GENERIC_MEM_REGISTERED_OUT (0                                     ),
                               .GENERIC_MEM_DATA_WIDTH     (`MGR_LOCAL_STORAGE_DESC_AGGREGATE_MEM_WIDTH )
                        ) gmemory ( 
                        
                        //---------------------------------------------------------------
                        // Port 
                        .portA_address       ( local_storage_desc_ptr          ),
                        .portA_write_data    ( {`MGR_LOCAL_STORAGE_DESC_AGGREGATE_MEM_WIDTH {1'b0}} ),
                        .portA_read_data     ( {sdmem_Address, sdmem_consJumpPtr, sdmem_AccessOrder}),
                        .portA_enable        ( 1'b1                             ), 
                        .portA_write         ( 1'b0                             ),
                        
                        //---------------------------------------------------------------
                        // General
                        .reset_poweron       ( reset_poweron             ),
                        .clk                 ( clk                       )
                        ) ;
  // Note: parameters must be fixed, so have to load directly
  //defparam gmemory.GENERIC_MEM_INIT_FILE   =    $sformatf("./inputFiles/manager_%0d_layer1_storageDescriptor_readmem.dat", sys__mgr__mgrId);
        `ifndef SYNTHESIS
          initial
            begin
              @(negedge reset_poweron);
              $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptor_readmem.dat", sys__mgr__mgrId), gmemory.mem);
            end
        `endif
      end
  endgenerate

  wire   [`COMMON_STD_INTF_CNTL_RANGE                    ]  sdmem_consJumpCntl  ;
  wire   [`MGR_INST_CONS_JUMP_RANGE                      ]  sdmem_consJump      ;

  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: storageDescConsJump_mem

        generic_1port_memory #(.GENERIC_MEM_DEPTH          (`MGR_LOCAL_STORAGE_DESC_CONSJUMP_MEMORY_DEPTH        ),
                               .GENERIC_MEM_REGISTERED_OUT (0                                                    ),
                               .GENERIC_MEM_DATA_WIDTH     (`MGR_LOCAL_STORAGE_DESC_CONSJUMP_AGGREGATE_MEM_WIDTH )
                        ) gmemory ( 
                        //---------------------------------------------------------------
                        // Port
                        .portA_address       ( consJumpPtr                      ),
                        .portA_write_data    ( {`MGR_LOCAL_STORAGE_DESC_CONSJUMP_AGGREGATE_MEM_WIDTH {1'b0}} ),
                        .portA_read_data     ( {sdmem_consJumpCntl, sdmem_consJump}),
                        .portA_enable        ( 1'b1                             ), 
                        .portA_write         ( 1'b0                             ),
                        
                        //---------------------------------------------------------------
                        // General
                        .reset_poweron       ( reset_poweron             ),
                        .clk                 ( clk                       )
                        ) ;
        `ifndef SYNTHESIS
          initial
            begin
              @(negedge reset_poweron);
              $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorConsJump_readmem.dat", sys__mgr__mgrId), gmemory.mem);
            end
        `endif
      end
  endgenerate


  assign  storage_desc_consJumpPtr = sdmem_consJumpPtr      ;


        
  //----------------------------------------------------------------------------------------------------
  // end memories
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------


  // wires to make FSM decodes look cleaner
  assign consJumpMemory_cntl      = sdmem_consJumpCntl  ;  // cons/jump delineator for fsm
  assign consJumpMemory_value     = sdmem_consJump      ;  // cons/jump delineator for fsm
  assign storage_desc_address     = sdmem_Address       ;  // main memory address in storage descriptor
  assign storage_desc_accessOrder = sdmem_AccessOrder   ;  // how to increment Chan/Bank/Page/Word
  assign consJumpMemory_som       =  (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM    ) ; 
  assign consJumpMemory_som_eom   =  (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM_EOM) ;
  assign consJumpMemory_eom       =  (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_EOM);


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
  reg                                             ok_to_send                 ;  // if from_mmc data is available and the downstream is ready


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
          sdp_cntl_stream_state_next =  (desc_processor_strm_ack) ? `SDP_CNTL_STRM_WAIT     :
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
      completed_streaming <= ( reset_poweron )  ? 1'b0 : 
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

  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE   ]   strm_next_cons_start_address ;  // pre-calculated next consequtive phase address
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE   ]   strm_inc_address             ;  // address we increment for each jump
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE   ]   strm_inc_address_e1          ;  
 
  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE]    strm_next_cons_start_channel ;
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE   ]    strm_next_cons_start_bank    ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE   ]    strm_next_cons_start_page    ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                        
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE ]    strm_next_cons_start_line    ; 
  `endif                                                                  
  reg  [`MGR_DRAM_WORD_ADDRESS_RANGE   ]    strm_next_cons_start_word    ;
                                                                          
  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE]    strm_inc_channel             ;  // formed address in access order for incrementing
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE   ]    strm_inc_bank                ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE   ]    strm_inc_page                ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                        
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE ]    strm_inc_line                ; 
  `endif                                                                  
  reg  [`MGR_DRAM_WORD_ADDRESS_RANGE   ]    strm_inc_word                ;
                                                                          
  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE]    strm_inc_channel_e1          ;  // 
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE   ]    strm_inc_bank_e1             ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE   ]    strm_inc_page_e1             ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                        
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE ]    strm_inc_line_e1             ; 
  `endif                                                                  
  reg  [`MGR_DRAM_WORD_ADDRESS_RANGE   ]    strm_inc_word_e1             ;

  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                        
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE ]    xxx__sdp__mem_request_line [`MGR_DRAM_NUM_CHANNELS ]  ;   // the MRC provides the word address of the mmc response, but we need the line 
    generate
      for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      always @(*)
        begin
          case (strm_accessOrder)  // synopsys parallel_case full_case
            PY_WU_INST_ORDER_TYPE_WCBP :
              begin
                xxx__sdp__mem_request_line [chan]  = xxx__sdp__mem_request_word [chan][`MGR_DRAM_LINE_IN_WORD_ADDRESS ] ;
              end
            PY_WU_INST_ORDER_TYPE_CWBP :
              begin
                xxx__sdp__mem_request_line [chan]  = xxx__sdp__mem_request_word [chan][`MGR_DRAM_LINE_IN_WORD_ADDRESS ] ;
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
                                           ((strm_inc_bank_e1 != xxx__sdp__mem_request_bank[strm_inc_channel_e1]) | 
                                            (strm_inc_page_e1 != xxx__sdp__mem_request_page[strm_inc_channel_e1]) | 
                                            `ifdef MGR_DRAM_REQUEST_LT_PAGE
                                              (strm_inc_line_e1 != xxx__sdp__mem_request_line[strm_inc_channel_e1])))  ;
                                            `else
                                              1'b0)) ;
                                            `endif
/*
          sdp__xxx__get_next_line[chan]  = (strm_inc_channel_e1 == chan) &
                                           ((strm_inc_bank_e1 != xxx__sdp__mem_request_bank[strm_inc_channel_e1]) | 
                                            (strm_inc_page_e1 != xxx__sdp__mem_request_page[strm_inc_channel_e1]) | 
                                            `ifdef MGR_DRAM_REQUEST_LT_PAGE
                                              (strm_inc_line_e1 != xxx__sdp__mem_request_line[strm_inc_channel_e1]))  ;
                                            `else
                                              1'b0 ;
                                            `endif
*/
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
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
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
                `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                  strm_inc_line_e1    =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                strm_inc_channel_e1 =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                strm_inc_bank_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                strm_inc_page_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                strm_inc_word_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                  strm_inc_line_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
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
                `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                  strm_inc_line_e1    =  strm_inc_address_e1[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                strm_inc_channel_e1 =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                strm_inc_bank_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                strm_inc_page_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                strm_inc_word_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                  strm_inc_line_e1    =  strm_inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
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
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
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
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
            strm_inc_line                <=  strm_inc_line_e1  ;
          `endif
        end
      else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP)
        begin
          strm_inc_channel             <=  strm_inc_channel_e1 ;
          strm_inc_bank                <=  strm_inc_bank_e1    ;
          strm_inc_page                <=  strm_inc_page_e1    ;
          strm_inc_word                <=  strm_inc_word_e1    ;
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
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
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
            strm_next_cons_start_line    =  strm_next_cons_start_address[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
          `endif
        end
      else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
        begin
          strm_next_cons_start_channel =  strm_next_cons_start_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
          strm_next_cons_start_bank    =  strm_next_cons_start_address[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
          strm_next_cons_start_page    =  strm_next_cons_start_address[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
          strm_next_cons_start_word    =  strm_next_cons_start_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
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

