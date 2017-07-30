/*********************************************************************************************

    File name   : sdp_request_cntl.v
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


module sdp_request_cntl (  

            input   wire                                           xxx__sdp__storage_desc_processing_enable     ,
            output  reg                                            sdp__xxx__storage_desc_processing_complete   ,
            input   wire  [`MGR_STORAGE_DESC_ADDRESS_RANGE  ]      xxx__sdp__storage_desc_ptr                   ,  // pointer to local storage descriptor although msb's contain manager ID, so remove
            //input   wire  [`MGR_NUM_LANES_RANGE             ]      xxx__sdp__num_lanes                          ,
            //input   wire  [`MGR_INST_OPTION_TRANSFER_RANGE  ]      xxx__sdp__txfer_type                         ,
            //input   wire  [`MGR_INST_OPTION_TGT_RANGE       ]      xxx__sdp__target                             ,

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

            //-------------------------------
            // to Storage Descriptor Stream control
            // - send during request generation
            // - we create the requests as fast as possible and send to stream control so streaming can occur as MMC response 
            //   data becomes available
            output reg                                             sdpr__sdps__cfg_valid       ,
            output reg    [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]   sdpr__sdps__cfg_addr        ,
            output reg    [`MGR_INST_OPTION_ORDER_RANGE        ]   sdpr__sdps__cfg_accessOrder ,
            input  wire                                            sdps__sdpr__cfg_ready       ,
            input  wire                                            sdps__sdpr__complete        ,
            output reg                                             sdpr__sdps__complete        ,
                                                                   
            output reg                                             sdpr__sdps__consJump_valid ,
            output reg    [`COMMON_STD_INTF_CNTL_RANGE         ]   sdpr__sdps__consJump_cntl  ,
            output reg    [`MGR_INST_CONS_JUMP_RANGE           ]   sdpr__sdps__consJump_value ,
            input  reg                                             sdps__sdpr__consJump_ready ,


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
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      sdp__xxx__mem_request_channel_e1    ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      sdp__xxx__mem_request_bank_e1       ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      sdp__xxx__mem_request_page_e1       ;
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE     ]      sdp__xxx__mem_request_word_e1       ;



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
  reg                                                      force_channel_request      ;  // Used when the consequtive addresses are in the same line and the PBLC address starts and finishes
                                                                                         // on the same channel ID. This condition would generate only the initial request unless we force the other channel to be requested
                                                                                         // Need to make sure we maintain the order
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  storage_desc_consJumpPtr   ;

  reg                                                      to_strm_fsm_fifo_ready    ;

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
  always @(*)
    begin
      completed_streaming    = sdps__sdpr__complete     ;
      sdpr__sdps__complete   = desc_processor_strm_ack  ;
      to_strm_fsm_fifo_ready = sdps__sdpr__consJump_ready & sdps__sdpr__consJump_ready ;
    end

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
          sdp_cntl_proc_storage_desc_state_next =                           `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC      ;

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
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_CHECK_PBC_VALUES ;

        `SDP_CNTL_PROC_STORAGE_DESC_CHECK_PBC_VALUES: 
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC ;

        // start points to first consequtive address, end points to last consequtive address
        // pbc_last_end points to last address of previous consequtive phase
        // pbc_inc is the first address of the current consequtive phase
        // CHeck if last_end != inc. If so, generate requests and set last_end = inc
        `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC: 
          sdp_cntl_proc_storage_desc_state_next =  ( first_time_thru                              ) ? `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO       :  // we will get here first time thru after the initial request
                                                   ( generate_requests || force_channel_request   ) ? `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA      :
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
 
  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]    mem_start_channel   ;
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE       ]    mem_start_bank      ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE       ]    mem_start_page      ;
  reg  [`MGR_DRAM_WORD_ADDRESS_RANGE       ]    mem_start_word      ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE     ]    mem_start_line      ;
  `endif

  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]    mem_end_channel       ;  // formed address in access order for incrementing
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE       ]    mem_end_bank          ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE       ]    mem_end_page          ;
  reg  [`MGR_DRAM_WORD_ADDRESS_RANGE       ]    mem_end_word          ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE     ]    mem_end_line          ;
  `endif

  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]    mem_last_end_channel       ;  // formed address in access order for incrementing
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE       ]    mem_last_end_bank          ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE       ]    mem_last_end_page          ;
  reg  [`MGR_DRAM_WORD_ADDRESS_RANGE       ]    mem_last_end_word          ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE     ]    mem_last_end_line          ;
  `endif

  // Keep track of the last channel requested address 
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    channel_last_requested_valid                          ;
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE        ]    channel_last_requested_bank [`MGR_DRAM_NUM_CHANNELS ] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]    channel_last_requested_page [`MGR_DRAM_NUM_CHANNELS ] ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE          
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE      ]    channel_last_requested_line [`MGR_DRAM_NUM_CHANNELS ] ;
  `endif

  always @(posedge clk)
    begin
      // we use first_time_thru during the INC_PBC state so we create the start end address after the single first request has been generated.
      // We also use it in the CONS_FIELD state to test if the start channel is one and the end address remains in the line one of two things may happen:
      // a) the end address might be on channel '0', in which case the end PBLC (PBLCe) will be less than the current incrementing PBLC (PBLCi).
      //  e.g. Pe == Pi, Be == Bi,  Le == Li but Ce != Ci and Ci > Ce, so when the PBLCi start incrementing, we'll create "a lot of" erroneous requests.
      //  This wont occur in the PBCL case.
      //  So in the PBLC case, test if Pe == Pi, Be == Bi, Le == Li, Ci>Ce and (mem_end_word-mem_inc_word) > 1, then set Ci=Ce. Because pbc_last address will equal
      //  the actual PBLCi, now Cl != Ci and a request will be generate.
      /*
      first_time_thru <= (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_WAIT       ) ? 1'b1            :
             //          (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC    ) ? 1'b0            :
                         (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CONS_FIELD ) ? 1'b0            :  // we use 
                                                                                                         first_time_thru ;  
      */
      case (sdp_cntl_proc_storage_desc_state)  // synopsys parallel_case
        `SDP_CNTL_PROC_STORAGE_DESC_WAIT:
           begin
             first_time_thru <= 1'b1 ;
             force_channel_request   <= 1'b0   ;
           end

        `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC:
           begin
             first_time_thru <= first_time_thru ;
             force_channel_request   <= 1'b0   ;
           end

        `SDP_CNTL_PROC_STORAGE_DESC_CONS_FIELD:
           begin
             first_time_thru <= first_time_thru ;
             force_channel_request   <= 1'b0   ;
           end

        `SDP_CNTL_PROC_STORAGE_DESC_CHECK_PBC_VALUES:
           begin
             first_time_thru <= 1'b0 ;
             force_channel_request   <= (consJumpMemory_value > 0) & 
                                        `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                                          pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] & 
                                        `else
                                          pbc_inc_addr [`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] & 
                                        `endif
                                        (mem_start_page == mem_end_page) & (mem_start_bank == mem_end_bank) & (mem_start_line == mem_end_line) ;
           end

        `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA:
           begin
             first_time_thru <= first_time_thru ;
             force_channel_request   <= 1'b0 ;
           end

        default:
           begin
             first_time_thru <= first_time_thru ;
             force_channel_request   <= force_channel_request   ;
           end
      endcase
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
      case (sdp_cntl_proc_storage_desc_state)  // synopsys parallel_case

        `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID:
           begin
             case (storage_desc_accessOrder)  // synopsys parallel_case
               PY_WU_INST_ORDER_TYPE_WCBP:
                 begin
                   `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                     pbc_inc_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_channel, storage_desc_line};
                   `else
                     pbc_inc_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_channel};
                   `endif
                 end
               PY_WU_INST_ORDER_TYPE_CWBP:
                 begin
                   `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                     pbc_inc_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_line, storage_desc_channel};
                   `else
                     pbc_inc_addr <=  {storage_desc_page, storage_desc_bank, storage_desc_channel};
                   `endif
                 end
               default:
                  begin
                    pbc_inc_addr <= pbc_inc_addr ;
                  end
             endcase
           end

        `SDP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS:
           begin
             case (storage_desc_accessOrder)  // synopsys parallel_case
               PY_WU_INST_ORDER_TYPE_WCBP:
                 begin
                   `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                     pbc_inc_addr    <=  {mem_start_page, mem_start_bank, mem_start_channel, mem_start_line} ;
                   `else
                     pbc_inc_addr    <=  {mem_start_page, mem_start_bank, mem_start_channel} ;
                   `endif
                 end
               PY_WU_INST_ORDER_TYPE_CWBP:
                 begin
                   `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                     pbc_inc_addr    <=  {mem_start_page, mem_start_bank, mem_start_line, mem_start_channel} ;
                   `else
                     pbc_inc_addr    <=  {mem_start_page, mem_start_bank, mem_start_channel} ;
                   `endif
                 end
               default:
                  begin
                    pbc_inc_addr <= pbc_inc_addr ;
                  end
             endcase
           end

        // Test if the start channel is one and the end address remains in the line one of two things may happen:
        // a) the end address might be on channel '0', in which case the end PBLC (PBLCe) will be less than the current incrementing PBLC (PBLCi).
        //  e.g. Pe == Pi, Be == Bi,  Le == Li but Ce != Ci and Ci > Ce, so when the PBLCi start incrementing, we'll create "a lot of" erroneous requests.
        //  This wont occur in the PBCL case.
        //  So in the PBLC case, test if Pe == Pi, Be == Bi, Le == Li, Ci>Ce and (mem_end_word-mem_inc_word) > 1, then set Ci=Ce. Because pbc_last address will equal
        //  the actual PBLCi, now Cl != Ci and a request will be generate.
        `SDP_CNTL_PROC_STORAGE_DESC_CHECK_PBC_VALUES:
           begin
             case (storage_desc_accessOrder)  // synopsys parallel_case
               PY_WU_INST_ORDER_TYPE_CWBP:
                 begin
                   `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                     if ((consJumpMemory_value > 0) && (mem_start_page == mem_end_page) && (mem_start_bank == mem_end_bank) && (mem_start_line == mem_end_line))
                       begin
                         pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ];
                         pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ];
                         pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ];
                         pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ];
                         //pbc_inc_addr    <=  {mem_end_page, mem_end_bank, mem_end_line, mem_end_channel} ;  // FIXME
                       end
                     else
                       begin
                         pbc_inc_addr    <=  pbc_inc_addr ;
                       end
                   `else
                     if ((consJumpMemory_value > 0) && (mem_start_page == mem_end_page) && (mem_start_bank == mem_end_bank))
                       begin
                         pbc_inc_addr    <=  {mem_end_page, mem_end_bank, mem_end_channel} ;
                       end
                     else
                       begin
                         pbc_inc_addr    <=  pbc_inc_addr ;
                       end
                   `endif
                 end
               default:
                  begin
                    pbc_inc_addr <= pbc_inc_addr ;
                  end
             endcase
           end

        `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC:
           begin
             //pbc_inc_addr    <=  (~generate_requests && ~force_channel_request) ? pbc_inc_addr + 'd1 : pbc_inc_addr  ;
             case ({force_channel_request, generate_requests})  // 
               2'b00:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr + 'd1 ;
                 end
               2'b01:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
               2'b10:
                 begin
                   pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ];
                   pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ];  // invert channel
                   pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ];
                   pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ];
                 end
               2'b11:
                 begin
                   pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ];
                   pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ];  // invert channel
                   pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ];
                   pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ];
                 end
               default:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
             endcase
           end

        `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA:
           begin
             //pbc_inc_addr    <=  (~requests_complete && ~force_channel_request) ? pbc_inc_addr + 'd1 : pbc_inc_addr  ;
             case ({force_channel_request, requests_complete})  // sysnopsys parallel_case
               2'b00:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr + 'd1 ;
                 end
               2'b01:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
               2'b10:
                 begin
                   pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ];
                   pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ];  // invert channel
                   pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ];
                   pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ];
                 end
               2'b11:
                 begin
                   pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_LINE_FIELD_RANGE ];
                   pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ];  // invert channel
                   pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ];
                   pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ]   <=  pbc_inc_addr [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ];
                 end
               default:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
             endcase
           end

        default:
           begin
             pbc_inc_addr <= pbc_inc_addr ;
           end
      endcase
    end
/*
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
      // Test if the start channel is one and the end address remains in the line one of two things may happen:
      // a) the end address might be on channel '0', in which case the end PBLC (PBLCe) will be less than the current incrementing PBLC (PBLCi).
      //  e.g. Pe == Pi, Be == Bi,  Le == Li but Ce != Ci and Ci > Ce, so when the PBLCi start incrementing, we'll create "a lot of" erroneous requests.
      //  This wont occur in the PBCL case.
      //  So in the PBLC case, test if Pe == Pi, Be == Bi, Le == Li, Ci>Ce and (mem_end_word-mem_inc_word) > 1, then set Ci=Ce. Because pbc_last address will equal
      //  the actual PBLCi, now Cl != Ci and a request will be generate.
      else if (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CHECK_PBC_VALUES )
        begin
          if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP)
            begin
              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                if ((consJumpMemory_value > 0) && (mem_start_page == mem_end_page) && (mem_start_bank == mem_end_bank) && (mem_start_line == mem_end_line))
                  begin
                    pbc_inc_addr    <=  {mem_end_page, mem_end_bank, mem_end_line, mem_end_channel} ;
                  end
              `else
                if ((consJumpMemory_value > 0) && (mem_start_page == mem_end_page) && (mem_start_bank == mem_end_bank))
                  begin
                    pbc_inc_addr    <=  {mem_end_page, mem_end_bank, mem_end_channel} ;
                  end
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
*/

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
      else 
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


  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: chan_last_requested
        always @(posedge clk)
          begin
            channel_last_requested_valid [chan]      <=   create_mem_request  & ( pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] == chan) ;
            channel_last_requested_bank  [chan]      <= ( create_mem_request && ( pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] == chan)) ? pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] : channel_last_requested_bank [chan] ;
            channel_last_requested_page  [chan]      <= ( create_mem_request && ( pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] == chan)) ? pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] : channel_last_requested_page [chan] ;
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                 channel_last_requested_line [chan]  <= ( create_mem_request && ( pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] == chan)) ? pbc_inc_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ] : channel_last_requested_line [chan] ;
            `endif  
          end
      end
  endgenerate

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
  //  To SDP stream controller

  always @(*)
    begin
     sdpr__sdps__consJump_valid   = (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CONS_FIELD) | (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD) ;
     sdpr__sdps__consJump_cntl    = consJumpMemory_cntl  ;
     sdpr__sdps__consJump_value   = consJumpMemory_value ;
    end

  always @(*)
    begin
     sdpr__sdps__cfg_valid        = (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID) ;
     sdpr__sdps__cfg_addr         = storage_desc_local_address ;
     sdpr__sdps__cfg_accessOrder  = storage_desc_accessOrder   ;
    end
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

  genvar gvi ;
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


  // wires to make FSM decodes look cleaner
  assign consJumpMemory_cntl      = sdmem_consJumpCntl  ;  // cons/jump delineator for fsm
  assign consJumpMemory_value     = sdmem_consJump      ;  // cons/jump delineator for fsm
  assign storage_desc_address     = sdmem_Address       ;  // main memory address in storage descriptor
  assign storage_desc_accessOrder = sdmem_AccessOrder   ;  // how to increment Chan/Bank/Page/Word
  assign consJumpMemory_som       =  (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM    ) ; 
  assign consJumpMemory_som_eom   =  (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM_EOM) ;
  assign consJumpMemory_eom       =  (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_EOM);

        
  //----------------------------------------------------------------------------------------------------
  // end memories
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
 
  //----------------------------------------------------------------------------------------------------
  //
  //
  //
endmodule
