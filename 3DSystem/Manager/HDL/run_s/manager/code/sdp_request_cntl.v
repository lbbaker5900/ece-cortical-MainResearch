/*********************************************************************************************

    File name   : sdp_request_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : July 2017
    email       : lbbaker@ncsu.edu

    Description : Take storage descriptor pointer, number of lanes, transfer type and target and generate memory access commands. 

                  Actual memory Requests will be for a "cacheline" which by default is two 2048-bit transactions from the MMC.
                  The stream controller operates on each 2048-bit transaction from the MMC. This is referred to as a "line".
                  So when this request module identifies a need for a particular channel/bank/page/line, a request will be made for the channel
                  channel/bank/page/cacheline that contains the required "line".

                  Our default operation is a page is 4096 bits and with a burst of two and a 2048-bit interface, a cacheline is an entire page and a line
                  is half a cacheline (page).

                  When 2048-bit transactions are returned we also need to identify which "line" is represented so the stream controller can direct words
                  to the corresponding stack lane.
                  So we generate cacheline requests to the memory we also provide a channel/bank/page/line ID for the stream controller which will correspond
                  with valid transactions returned by the MMC.
                  The stream controller will match the returned transaction with the required line and read the 2048-bit transactions. If the channel/bank/page/line
                  does not match the required line, the stream controller assumes the transactions is a result of getting a line that is not required but
                  is a by-product of having to read a full cacheline even though only half of the cachelien is required.
 
                  e.g. In the default case, a cacheline is a page and a line is half a cacheline.  
                  a) If the required line is the first line in the cacheline, a request is made and the mmc returns a transaction matching the required channel/bank/page/line. 
                     The the next line is the cacheline is required next, a memory request will not be performed but an ID will be sent to the stream controller identifying 
                     the next transaction as the 2nd line. The stream controller will grab the first line, determine it also needs the second line and grab that also.

                  b) If the required line is the second line in the cacheline, a request is made and the mmc returns a transaction matching the first line that isnt required.
                     The stream controller will see the ID doesnt match the required line, read the transaction and discard. The next line is the cacheline required, 
                     the stream controller will grab this second line and demux the data onto the downstream bus.
                     Although this case is wasteful, it is expected these single transaction drops will be swamped.

                  
                  Note: This module will be used by the memory read controller(s) and the memory write controller.

                  

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "python_typedef.vh"
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


module sdp_request_cntl (  

            input   wire  [`MGR_NUM_OF_EXEC_LANES_RANGE     ]      xxx__sdp__lane_enable                        , 
            input   wire  [`MGR_STD_OOB_TAG_RANGE           ]      xxx__sdp__tag                                ,  // mmc needs to service tag requests before tag+1
            input   wire  [`MGR_NUM_LANES_RANGE             ]      xxx__sdp__num_lanes                          ,
            input   wire  [`MGR_NUM_LANES_RANGE             ]      xxx__sdp__num_lanes_m1                       ,
            input   wire  [`MGR_INST_OPTION_TRANSFER_RANGE  ]      xxx__sdp__txfer_type                         ,

            input   wire                                           xxx__sdp__storage_desc_processing_enable     ,
            output  reg                                            sdp__xxx__storage_desc_processing_complete   ,
            input   wire  [`MGR_STORAGE_DESC_ADDRESS_RANGE  ]      xxx__sdp__storage_desc_ptr                   ,  // pointer to local storage descriptor although msb's contain manager ID, so remove

            //-------------------------------
            // Main Memory Controller interface
            // - response must be in order
            //
            output  reg                                            sdp__xxx__mem_request_valid              ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      sdp__xxx__mem_request_cntl               ,
            output  reg   [`MGR_STD_OOB_TAG_RANGE           ]      sdp__xxx__mem_request_tag                ,  // mmc needs to service tag requests before tag+1
            input   wire                                           xxx__sdp__mem_request_ready              ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      sdp__xxx__mem_request_channel            ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      sdp__xxx__mem_request_bank               ,
            output  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      sdp__xxx__mem_request_page               ,
            output  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE     ]      sdp__xxx__mem_request_word               ,

            //-------------------------------
            // to Storage Descriptor Stream control
            // - ID for each returned line (cycle)
            //
            output  reg                                            sdpr__sdps__response_id_valid              ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      sdpr__sdps__response_id_cntl               ,
            input   wire                                           sdps__sdpr__response_id_ready              ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      sdpr__sdps__response_id_channel            ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      sdpr__sdps__response_id_bank               ,
            output  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      sdpr__sdps__response_id_page               ,
            output  reg   [`MGR_DRAM_LINE_ADDRESS_RANGE     ]      sdpr__sdps__response_id_line               ,

            //-------------------------------
            // to Storage Descriptor Stream control
            // - send during request generation
            // - we create the requests as fast as possible and send to stream control so streaming can occur as MMC response 
            //   data becomes available
            output reg                                             sdpr__sdps__cfg_valid       ,
            output reg    [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]   sdpr__sdps__cfg_addr        ,
            output reg    [`MGR_INST_OPTION_ORDER_RANGE        ]   sdpr__sdps__cfg_accessOrder ,
            output reg    [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdpr__sdps__cfg_lane_enable , 
            input  wire                                            sdps__sdpr__cfg_ready       ,
            input  wire                                            sdps__sdpr__complete        ,
            output reg                                             sdpr__sdps__complete        ,
                                                                   
            output reg                                             sdpr__sdps__consJump_valid ,
            output reg    [`COMMON_STD_INTF_CNTL_RANGE         ]   sdpr__sdps__consJump_cntl  ,
            output reg    [`MGR_INST_CONS_JUMP_FIELD_RANGE     ]   sdpr__sdps__consJump_value ,
            input  reg                                             sdps__sdpr__consJump_ready ,


            //----------------------------------------------------------------------------------------------------
            //----------------------------------------------------------------------------------------------------
            // Config/Status
            
            //-------------------------------------------------------------------------------------------------
            // Storage descriptor download

            input   wire                                                       mcntl__sdp__enable_sdmem_dnld   ,

            input   wire                                                       mcntl__sdp__sdmem_valid         ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__sdp__sdmem_cntl          ,
            output  reg                                                        sdp__mcntl__sdmem_ready         ,

            input   wire  [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE          ]    mcntl__sdp__sdmem_address       ,

            // Storage descriptor memory contents
            input   wire  [`MGR_DRAM_ADDRESS_RANGE                        ]    mcntl__sdp__sdmem_addr          ,
            input   wire  [`MGR_INST_OPTION_ORDER_RANGE                   ]    mcntl__sdp__sdmem_order         ,
            input   wire  [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__sdp__sdmem_consJump_ptr  ,
            
            
            input   wire                                                       mcntl__sdp__enable_cjmem_dnld   ,

            input   wire                                                       mcntl__sdp__cjmem_valid         ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__sdp__cjmem_cntl          ,
            output  reg                                                        sdp__mcntl__cjmem_ready         ,

            input   wire  [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__sdp__cjmem_address       ,

            // Cons/jump memory contents
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__sdp__cjmem_consJump_cntl ,
            input   wire  [`MGR_INST_CONS_JUMP_FIELD_RANGE                ]    mcntl__sdp__cjmem_consJump_val  ,

            //----------------------------------------------------------------------------------------------------
            //----------------------------------------------------------------------------------------------------
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
  reg   [`MGR_STD_OOB_TAG_RANGE           ]      sdp__xxx__mem_request_tag_e1        ;  // mmc needs to service tag requests before tag+1
  reg                                            xxx__sdp__mem_request_ready_d1      ;
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      sdp__xxx__mem_request_channel_e1    ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      sdp__xxx__mem_request_bank_e1       ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      sdp__xxx__mem_request_page_e1       ;
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE     ]      sdp__xxx__mem_request_word_e1       ;


  //-------------------------------
  // to Storage Descriptor Stream control
  // - ID for each returned line (cycle)
  //
  reg                                            sdpr__sdps__response_id_valid_e1     ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      sdpr__sdps__response_id_cntl_e1      ;
  reg                                            sdps__sdpr__response_id_ready_d1     ;
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      sdpr__sdps__response_id_channel_e1   ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      sdpr__sdps__response_id_bank_e1      ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      sdpr__sdps__response_id_page_e1      ;
  reg   [`MGR_DRAM_LINE_ADDRESS_RANGE     ]      sdpr__sdps__response_id_line_e1      ;

   //-------------------------------------------------------------------------------------------------
   // Storage descriptor download
 
   reg                                                        mcntl__sdp__enable_sdmem_dnld_d1   ;

   reg                                                        mcntl__sdp__sdmem_valid_d1         ;
   reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__sdp__sdmem_cntl_d1          ;
   wire                                                       sdp__mcntl__sdmem_ready_e1         ;

   reg   [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE          ]    mcntl__sdp__sdmem_address_d1       ;
   // Storage descriptor memory contents
   reg   [`MGR_DRAM_ADDRESS_RANGE                        ]    mcntl__sdp__sdmem_addr_d1          ;
   reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]    mcntl__sdp__sdmem_order_d1         ;
   reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__sdp__sdmem_consJump_ptr_d1  ;
            

  reg                                                        mcntl__sdp__enable_cjmem_dnld_d1   ;

  reg                                                        mcntl__sdp__cjmem_valid_d1         ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__sdp__cjmem_cntl_d1          ;
  wire                                                       sdp__mcntl__cjmem_ready_e1         ;

  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__sdp__cjmem_address_d1       ;
  // Storage descriptor memory contents
  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__sdp__cjmem_consJump_cntl_d1 ;
  reg   [`MGR_INST_CONS_JUMP_FIELD_RANGE                ]    mcntl__sdp__cjmem_consJump_val_d1  ;
            


  //--------------------------------------------------
  // to Main Memory Controller
  
  always @(posedge clk) 
    begin
      sdp__xxx__mem_request_valid      <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_valid_e1   ;
      sdp__xxx__mem_request_cntl       <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_cntl_e1    ;
      sdp__xxx__mem_request_tag        <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_tag_e1     ;
      xxx__sdp__mem_request_ready_d1   <=   ( reset_poweron   ) ? 'd0  :  xxx__sdp__mem_request_ready      ;
      sdp__xxx__mem_request_channel    <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_channel_e1 ;
      sdp__xxx__mem_request_bank       <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_bank_e1    ;
      sdp__xxx__mem_request_page       <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_page_e1    ;
      sdp__xxx__mem_request_word       <=   ( reset_poweron   ) ? 'd0  :  sdp__xxx__mem_request_word_e1    ;
    end

  //-------------------------------
  // to Storage Descriptor Stream control

  always @(posedge clk) 
    begin
      sdpr__sdps__response_id_valid     <=   ( reset_poweron   ) ? 'd0  :  sdpr__sdps__response_id_valid_e1   ;
      sdpr__sdps__response_id_cntl      <=   ( reset_poweron   ) ? 'd0  :  sdpr__sdps__response_id_cntl_e1    ;
      sdps__sdpr__response_id_ready_d1  <=   ( reset_poweron   ) ? 'd0  :  sdps__sdpr__response_id_ready      ;
      sdpr__sdps__response_id_channel   <=   ( reset_poweron   ) ? 'd0  :  sdpr__sdps__response_id_channel_e1 ;
      sdpr__sdps__response_id_bank      <=   ( reset_poweron   ) ? 'd0  :  sdpr__sdps__response_id_bank_e1    ;
      sdpr__sdps__response_id_page      <=   ( reset_poweron   ) ? 'd0  :  sdpr__sdps__response_id_page_e1    ;
      sdpr__sdps__response_id_line      <=   ( reset_poweron   ) ? 'd0  :  sdpr__sdps__response_id_line_e1    ;
    end

  //-------------------------------------------------------------------------------------------------
  // Storage descriptor download
  //
    always @(posedge clk) 
      begin
        mcntl__sdp__enable_sdmem_dnld_d1   <=  (reset_poweron) ? 1'b0 : mcntl__sdp__enable_sdmem_dnld     ;

        mcntl__sdp__sdmem_valid_d1         <=  (reset_poweron) ? 1'b0 : mcntl__sdp__sdmem_valid           ;
        mcntl__sdp__sdmem_cntl_d1          <=                           mcntl__sdp__sdmem_cntl            ;
                                                                                                       
        sdp__mcntl__sdmem_ready            <=                           sdp__mcntl__sdmem_ready_e1        ;
                                                                                                       
        mcntl__sdp__sdmem_address_d1       <=                           mcntl__sdp__sdmem_address         ;
        mcntl__sdp__sdmem_addr_d1          <=                           mcntl__sdp__sdmem_addr            ;
        mcntl__sdp__sdmem_order_d1         <=                           mcntl__sdp__sdmem_order           ;
        mcntl__sdp__sdmem_consJump_ptr_d1  <=                           mcntl__sdp__sdmem_consJump_ptr    ;
      end

    always @(posedge clk) 
      begin
        mcntl__sdp__enable_cjmem_dnld_d1   <=  (reset_poweron) ? 1'b0 : mcntl__sdp__enable_cjmem_dnld     ;
                                                                                                          
        mcntl__sdp__cjmem_valid_d1         <=  (reset_poweron) ? 1'b0 : mcntl__sdp__cjmem_valid           ;
        mcntl__sdp__cjmem_cntl_d1          <=                           mcntl__sdp__cjmem_cntl            ;
                                                                                                          
        sdp__mcntl__cjmem_ready            <=                           sdp__mcntl__cjmem_ready_e1        ;
                                                                                                          
        mcntl__sdp__cjmem_address_d1       <=                           mcntl__sdp__cjmem_address         ;
        mcntl__sdp__cjmem_consJump_cntl_d1 <=                           mcntl__sdp__cjmem_consJump_cntl   ;
        mcntl__sdp__cjmem_consJump_val_d1  <=                           mcntl__sdp__cjmem_consJump_val    ;
      end

    // FIXME ?? Do I need ready
    // Remember, regs cant be used when assigning to fixed value
    assign    sdp__mcntl__sdmem_ready_e1         =                           1'b1 ;
    assign    sdp__mcntl__cjmem_ready_e1         =                           1'b1 ;


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
  reg   [`MGR_INST_CONS_JUMP_FIELD_RANGE                ]  consJumpMemory_value      ;  // cons/jump value
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  consJumpPtr               ;
  reg                                                      inc_consJumpPtr           ;  // cycle thru consequtive and jump memory
                                                                                     
  reg   [`MGR_DRAM_ADDRESS_RANGE                        ]  storage_desc_address       ;  // main memory address in storage descriptor
  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE                  ]  storage_desc_local_address ;  // local main memory address in storage descriptor
  reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]  storage_desc_accessOrder   ;  // how to increment Chan/Bank/Page/Word e.g. CWBP, WCBP
  wire                                                     consJumpMemory_som         ;
  wire                                                     consJumpMemory_som_eom     ;
  wire                                                     consJumpMemory_eom         ;

  wire  [`MGR_INST_OPTION_TRANSFER_RANGE ]   strm_transfer_type           ;
  assign strm_transfer_type  =  xxx__sdp__txfer_type                           ;

  //----------------------------------------------------------------------------------------------------
  // Flags for special situations
  reg                                                      first_time_thru                     ;  // need to make sure for the first cycle we request the starting bank/page

  reg                                                      force_disable_request               ;  
                                                                                                  
  reg                                                      force_cons_request                  ;  // force either chan0 or chan1
  reg                                                      force_jump_request                  ;  // FIXME force_jump_.* always 0, delete???
  reg                                                      force_cons_chan01_request           ;  // force chan0 then chan1 at consequtive phase start
  reg                                                      force_cons_chan10_request           ;  // force chan1 then chan0 at consequtive phase start
  reg                                                      force_jump_chan01_request           ;  // force chan0 then chan1 at jump phase
  reg                                                      force_jump_chan10_request           ;  // force chan1 then chan0 at jump phase 
  reg                                                      force_cons_chan0_request            ;  // Used when the consequtive addresses are in the same line and the PBLC address starts and finishes
  reg                                                      force_cons_chan1_request            ;  // on the same channel ID. This condition would generate only the initial request unless we force the other channel to be requested
  reg                                                      force_jump_chan0_request            ;  
  reg                                                      force_jump_chan1_request            ;  

  always @(*)
    begin
      force_cons_request  =  force_cons_chan01_request | force_cons_chan10_request | force_cons_chan0_request | force_cons_chan1_request ;
      force_jump_request  =  force_jump_chan01_request | force_jump_chan10_request | force_jump_chan0_request | force_jump_chan1_request ;
    end
  //----------------------------------------------------------------------------------------------------

  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  storage_desc_consJumpPtr   ;

  reg                                                      stream_proc_ready         ;

  reg                                                      requests_complete         ;
  reg                                                      generate_requests         ;
  reg                                                      bank_change               ;  // check current increment vs previous last request
  reg                                                      page_change               ;
  reg                                                      channel_change            ;
  `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
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
      stream_proc_ready      = sdps__sdpr__consJump_ready & sdps__sdpr__consJump_ready ;
      //stream_proc_ready      = sdps__sdpr__consJump_ready & sdps__sdpr__response_id_ready & sdps__sdpr__cfg_ready ;
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
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST;
                                      
        // Memory requests will occur if the consequtive increment moves to another page
        // Make sure we transition right thru this state
        `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST : 
          sdp_cntl_proc_storage_desc_state_next =     (xxx__sdp__mem_request_ready_d1 && sdps__sdpr__response_id_ready_d1) ? `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_EXTRA_RESPONSE_ID :  // do not generate request if MMC not ready or SDPS not ready
                                                                                                                             `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST           ;

        `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_EXTRA_RESPONSE_ID : 
          sdp_cntl_proc_storage_desc_state_next =     `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC   ;

       // `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHB : 
       //   sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC      ;

        // Make sure strm fifo can take cons/jump before reading
        // - cj currently points to beginning of next consequtive phase
        `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO : 
          sdp_cntl_proc_storage_desc_state_next =  ( sdps__sdpr__consJump_ready ) ? `SDP_CNTL_PROC_STORAGE_DESC_CONS_FIELD           :
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


        // When we enter this state, start points to first consequtive address, end points to last consequtive address, pbc_last_end points to last address of previous consequtive phase
        // and pbc_inc is the first address of the current consequtive phase.
        // We start checking if last_end(chan,bank,page) != inc(chan,bank,page). 
        // If so, we have crossed a major memory boundary and we need to generate a request.
        // generate the request then set last_end = inc and continue
        //
        // There are two special cases:
        // a) First time we initially generate a request for the very start of the stream. So we transition thru the generate state before entering this state.
        //    Now it may turn out that the first request of the current stream is the same as the last request of the previous stream, btu we dont try to take advantage. 
        //    So either way, generate a request when we starg a new stream.
        // b) During a stream, when we increment based on PBLC, the channel will toggle multiple times. if the start and end channel are the same, it may look like
        //    we have completed the stream e.g. PBLC_inc == PBLC_end. So in this case, we force a request to be generated.


        `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC: 
          sdp_cntl_proc_storage_desc_state_next =  ( first_time_thru                                              ) ? `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO       :  // we will get here first time thru after the initial request
                                                   ( generate_requests || force_cons_request || force_jump_request) ? `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST      :
                                                   ( requests_complete  && ~consJumpMemory_eom                    ) ? `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD            :
                                                   ( requests_complete  &&  consJumpMemory_eom                    ) ? `SDP_CNTL_PROC_STORAGE_DESC_REQUESTS_COMPLETE     :
                                                                                                                      `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC               ;

        `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD: 
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO    ;

        //------------------------------------------------------------------------------------------------------------------------------------------------------
        // Completed requests
        
        `SDP_CNTL_PROC_STORAGE_DESC_REQUESTS_COMPLETE: 
          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE    ;  // create a request EOM during this transition

        // Cycle thru all cons/jump fields
        `SDP_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE: 
// LEE

//          sdp_cntl_proc_storage_desc_state_next =  (completed_streaming)  ? `SDP_CNTL_PROC_STORAGE_DESC_COMPLETE             :
//                                                                            `SDP_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE ;


          sdp_cntl_proc_storage_desc_state_next =  `SDP_CNTL_PROC_STORAGE_DESC_COMPLETE    ;
                                                   

        `SDP_CNTL_PROC_STORAGE_DESC_COMPLETE: 
          sdp_cntl_proc_storage_desc_state_next =   (~xxx__sdp__storage_desc_processing_enable ) ? `SDP_CNTL_PROC_STORAGE_DESC_WAIT     : 
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
      sdp__xxx__storage_desc_processing_complete  <= ( reset_poweron )  ? 1'b0 : ( sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_COMPLETE) ;

    end

  always @(posedge clk)
    begin
      desc_processor_strm_ack  <= ( reset_poweron )  ? 1'b0 : ( sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE) ;

    end

  // Extract address fields from storage pointer address
  //  - for debug right now

  reg  [ `MGR_MGR_ID_RANGE              ]    storage_desc_mgr      ;
  reg  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE]    storage_desc_channel  ;
  reg  [ `MGR_DRAM_BANK_ADDRESS_RANGE   ]    storage_desc_bank     ;
  reg                                        storage_desc_bank_lsb ;  // temporary store of bank lsb as we increment thru the consequtive/jump phases
  reg  [ `MGR_DRAM_PAGE_ADDRESS_RANGE   ]    storage_desc_page     ;
`ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                         
  reg  [ `MGR_DRAM_LINE_ADDRESS_RANGE   ]    storage_desc_cline     ;  // if a dram access reads less than a page, we need to generate additional memory requests when we transition a line
`endif                                                             
  reg  [ `MGR_DRAM_WORD_ADDRESS_RANGE   ]    storage_desc_word     ;
  always @(*)
    begin
      storage_desc_local_address  =  storage_desc_address[`MGR_DRAM_LOCAL_ADDRESS_RANGE      ]  ;
      storage_desc_mgr            =  storage_desc_address[`MGR_DRAM_ADDRESS_MGR_FIELD_RANGE  ]  ;
      storage_desc_channel        =  storage_desc_address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  ;
      storage_desc_bank           =  storage_desc_address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  ;
      storage_desc_page           =  storage_desc_address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  ;
      `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
        storage_desc_cline         =  storage_desc_address[`MGR_DRAM_ADDRESS_LINE_FIELD_RANGE ]  ;
      `endif
      storage_desc_word           =  storage_desc_address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  ;
    end
          
  // Form an address using the base address fields ordered based on access order
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]    mem_start_address                ;  // Start address for a consequtive phase
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]    mem_ms_lane_start_address        ;  // Start address for the last active lane
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]    cj_address                       ;  // address we increment for each jump
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]    cj_ms_lane_address               ;  // address we increment for each jump
  //reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE     ]    mem_last_end_address             ;  // address we increment for each jump
                                                                                  
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //Note:  When you are looking at a PBC address, its actually Bank/2 - so 4 bits for bank
  //
  //       PBC => {pppppppppppp, bbbb, c}
  //
  //
  `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE                                          
    reg  [`MGR_DRAM_PBCL_RANGE              ]    pbc_end_addr                     ;  // 
                                                                                  
    reg  [`MGR_DRAM_PBCL_RANGE              ]    pbc_inc_addr                     ;  // 
                                                                                  
    reg  [`MGR_DRAM_PBCL_RANGE              ]    pbc_last_end_addr                ;  // last requested. Use to check for changes during increment
  `else                                                                           
    reg  [`MGR_DRAM_PBC_RANGE               ]    pbc_end_addr                     ;  // 
    reg  [`MGR_DRAM_PBC_RANGE               ]    pbc_inc_addr                     ;  // 
    reg  [`MGR_DRAM_PBC_RANGE               ]    pbc_last_end_addr                ;  // last requested. Use to check for changes during increment
  `endif                                                                          
  reg                                            pbc_last_end_is_cons_tm1_end     ;  // indicates the pbc_last_end_addr currently points to cons(t-1).end
                                                                                                    
                                                                                  
  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]    pbc_end_addr_chan                ;  // use for consequtive/jump boundary checks
  reg  [`MGR_DRAM_BANK_DIV2_ADDRESS_RANGE   ]    pbc_end_addr_bank                ;  //               "
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]    pbc_end_addr_page                ;  //               "
  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]    pbc_inc_addr_chan                ;  // use for consequtive/jump boundary checks
  reg  [`MGR_DRAM_BANK_DIV2_ADDRESS_RANGE   ]    pbc_inc_addr_bank                ;  //               "
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]    pbc_inc_addr_page                ;  //               "
  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]    pbc_last_end_addr_chan           ;  // use for consequtive/jump boundary checks
  reg  [`MGR_DRAM_BANK_DIV2_ADDRESS_RANGE   ]    pbc_last_end_addr_bank           ;  //               "
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]    pbc_last_end_addr_page           ;  //               "

  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    pbc_last_requested_valid                          ;  // Keep track of the previously requested bank/page for each channel
  reg  [`MGR_DRAM_BANK_DIV2_ADDRESS_RANGE   ]    pbc_bank_last_requested [`MGR_DRAM_NUM_CHANNELS ] ;  // 
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]    pbc_page_last_requested [`MGR_DRAM_NUM_CHANNELS ] ;  // LEE
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]    pbc_last_requested_mismatch                       ;  // when generating a request, check if we have loaded both channels

  // extract the bank/page/chan sub-fields
  // Would have been nice to use a struct, maybe next time
  always @(*)
    begin
      `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE                                
        case (storage_desc_accessOrder)  // synopsys full_case
          PY_WU_INST_ORDER_TYPE_CWBP:
            begin
                pbc_end_addr_chan        =   pbc_end_addr        [`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] ;
                pbc_end_addr_bank        =   pbc_end_addr        [`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] ;
                pbc_end_addr_page        =   pbc_end_addr        [`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] ;
                pbc_inc_addr_chan        =   pbc_inc_addr        [`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] ;
                pbc_inc_addr_bank        =   pbc_inc_addr        [`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] ;
                pbc_inc_addr_page        =   pbc_inc_addr        [`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] ;
                pbc_last_end_addr_chan   =   pbc_last_end_addr   [`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] ;
                pbc_last_end_addr_bank   =   pbc_last_end_addr   [`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] ;
                pbc_last_end_addr_page   =   pbc_last_end_addr   [`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] ;
            end
          PY_WU_INST_ORDER_TYPE_WCBP:
            begin
                pbc_end_addr_chan        =   pbc_end_addr        [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
                pbc_end_addr_bank        =   pbc_end_addr        [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] ;
                pbc_end_addr_page        =   pbc_end_addr        [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] ;
                pbc_inc_addr_chan        =   pbc_inc_addr        [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
                pbc_inc_addr_bank        =   pbc_inc_addr        [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] ;
                pbc_inc_addr_page        =   pbc_inc_addr        [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] ;
                pbc_last_end_addr_chan   =   pbc_last_end_addr   [`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
                pbc_last_end_addr_bank   =   pbc_last_end_addr   [`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] ;
                pbc_last_end_addr_page   =   pbc_last_end_addr   [`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] ;
            end
        endcase
      `else
        pbc_end_addr_chan        =   pbc_end_addr        [`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
        pbc_end_addr_bank        =   pbc_end_addr        [`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ;
        pbc_end_addr_page        =   pbc_end_addr        [`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
        pbc_inc_addr_chan        =   pbc_inc_addr        [`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
        pbc_inc_addr_bank        =   pbc_inc_addr        [`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ;
        pbc_inc_addr_page        =   pbc_inc_addr        [`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
        pbc_last_end_addr_chan   =   pbc_last_end_addr   [`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
        pbc_last_end_addr_bank   =   pbc_last_end_addr   [`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ;
        pbc_last_end_addr_page   =   pbc_last_end_addr   [`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
      `endif
    end

  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]    mem_start_channel      ;
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE        ]    mem_start_bank         ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]    mem_start_page         ;
  reg  [`MGR_DRAM_WORD_ADDRESS_RANGE        ]    mem_start_word         ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                            
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE      ]    mem_start_line         ;
  `endif                                                                
  `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE                                
    reg  [`MGR_DRAM_CLINE_ADDRESS_RANGE     ]    mem_start_cline        ;
  `endif                                                                
                                                                        
  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]    cj_channel             ;  // formed address in access order for incrementing
  reg  [`MGR_DRAM_BANK_DIV2_ADDRESS_RANGE   ]    cj_bank                ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]    cj_page                ;
  reg  [`MGR_DRAM_WORD_ADDRESS_RANGE        ]    cj_word                ;
  `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE                                
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE      ]    cj_cline               ;
  `endif
  reg  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]    cj_ms_lane_channel             ;  // formed address in access order for incrementing
  reg  [`MGR_DRAM_BANK_DIV2_ADDRESS_RANGE   ]    cj_ms_lane_bank                ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]    cj_ms_lane_page                ;
  reg  [`MGR_DRAM_WORD_ADDRESS_RANGE        ]    cj_ms_lane_word                ;
  `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE                                
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE      ]    cj_ms_lane_cline               ;
  `endif

  //------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------
  // Special Conditions
  /*
  We use first_time_thru during the INC_PBC state so we create the start end address after the single first request has been generated.
  We also use it in the CONS_FIELD state to test if the start channel is one and the end address remains in the line one of two things may happen:
  a) the end address might be on channel '0', in which case the end PBLC (PBLCe) will be less than the current incrementing PBLC (PBLCi).
   e.g. Pe == Pi, Be == Bi,  Le == Li but Ce != Ci and Ci > Ce, so when the PBLCi start incrementing, we'll create "a lot of" erroneous requests.
   This wont occur in the PBCL case.
   So in the PBLC case, test if Pe == Pi, Be == Bi, Le == Li, Ci>Ce and (cj_word-mem_inc_word) > 1, then set Ci=Ce. Because pbc_last address will equal
   the actual PBLCi, now Cl != Ci and a request will be generate.
  Test if the start channel is one and the end address remains in the line one of two things may happen:
  a) the end address might be on channel '0', in which case the end PBLC (PBLCe) will be less than the current incrementing PBLC (PBLCi).
   e.g. Pe == Pi, Be == Bi,  Le == Li but Ce != Ci and Ci > Ce, so when the PBLCi start incrementing, we'll create "a lot of" erroneous requests.
   This wont occur in the PBCL case.
   So in the PBLC case, test if Pe == Pi, Be == Bi, Le == Li, Ci>Ce and (cj_word-mem_inc_word) > 1, then set Ci=Ce. Because pbc_last address will equal
   the actual PBLCi, now Cl != Ci and a request will be generate.
  
  We use pbc_inc_addr and pbc_last_end_addr to determine if a request is required.
  If pbc_inc_addr != pbc_last_end then gen_req
  At the transition to a new consequtive phase, pbc_last_end points to the end of the previous consequtive phase and pbc_inc points to the 
  start of the next phase. If a request is required, generate and set pbc_last_end = pbc_inc and start incrementing pbc_inc
  Each time we generate a request, set pbc_last_end = pbc_inc
  When pbc_inc == pbc_end, get next jump value

                       cons(t-1).start                 cons(t-1).end
                              V______________________________V                  _____________________________
           Phases ------------|______________________________|-----------------|_____________________________|--------------
                                                                        
                              |<-----consequtive(t-1)------->|<---Jump(t-1)--->|<-------consequtive(t)------>|<---Jump(t)---

                               ______________________________                   _____________________________
                   -----------|______________________________|-----------------|_____________________________|--------------
                                                             ^                 ^                             ^
                                                        pbc_last_end       pbc_inc_addr                   pbc_end
                                                                           mem_start                         
                                                                            gen_req                      
                               ______________________________                   _____________________________
                  ------------|______________________________|-----------------|____________|________________|--------------
                                                                               ^        ^                    ^
                                                                               |   pbc_inc_addr           pbc_end
                                                                         pbc_last_end                                        
                                                                           mem_start                         
                                                                            gen_req
                               ______________________________                   _____________________________
                  ------------|______________________________|-----------------|____________|________________|--------------
                                                                               ^            ^                ^
                                                                               |       pbc_inc_addr       pbc_end
                                                                         pbc_last_end       |                                
                                                                           mem_start        |                
                                                                                         gen_req
                               ______________________________                   _____________________________
                  ------------|______________________________|-----------------|____________|________________|--------------
                                                                               ^            ^        ^      ^
                                                                               |            |   pbc_inc_addr|
                                                                                       pbc_last_end       pbc_end
                                                                           mem_start       
                                                                                       
  Note: If we jump to a new consequtive and we remain in a page, and we are incrementing based on page/bank/line/channel, 
        we need to make sure we make channel requests.
        For example, during the jump, pbc_last_end == cons_end(t-1) and pbc_inc = cons_start(t) 
        If we stay in the page, the only thing that incremented was channel. If cons_end(t-1).chan = 0 and cons_start(t).chan=1 then we
        will see pbc_inc != pbc_last_end and generate a request to channel 0. We set pbc_last_end = pbc_inc and increment pbc_inc such that pbc_inc.chan = 1
        Now, pbc_last_end.chan != pbc_inc.chan and we generate a request to channel 1, sweet.

        But what happens if pbc_last_end.chan = 1 and pbc_inc.chan = 0. Well, it actually looks like pbc_inc > pbc_last_end, but in reality, the gap may have
        incremented channel multiple times. Why?
        This "will" happen during ROI read. We read a CL and set data word by word, first from channel 0 then channel 1 (or visa versa)
        So during the ROI read, we actually read the two pages chan0/bank/page and chan1/bank/page and just start sending the words.
        So if the gap or cons is such that the only address thats toggling is the channel, we need to force the requests to occur
        Conditions:
            pbc_last_end.bank == pbc_inc.bank
            pbc_last_end.page == pbc_inc.page
            and                               pbc_last_end.chan   pbc_inc.chan
                                                      0                0         Force request to chan 0 followed by 1
                                                      0                1         Normal situation
                                                      1                0         Force request to chan 0 followed by 1
                                                      1                1         Force request to chan 1 followed by 0

        We make this check during the CHECK_PBC_VALUES state and we response to the forces during the INC_PBC state and GENERATE_REQ states
        using the force_cons_chan*_request signals 

        There is another case.
        When we make the jump, we set three addresses, pbc_last_end points to cons(t-1).end, pbc_inc points to cons(t).start and pbc_end to cons(t).end
        So without the test we may not perform a channel request during the jump from cons(t-1).end to cons(t).start but we might immediately also not
        make a channel request during cons(t).start to cons(t).end. So when we make the jump, we need to check for both conditions
            pbc_inc.bank == pbc_end.bank
            pbc_inc.page == pbc_end.page
            and                                  pbc_inc.chan    pbc_end.chan
                                                      0                0         Force request to chan 0 followed by 1
                                                      0                1         Normal situation
                                                      1                0         Force request to chan 0 followed by 1
                                                      1                1         Force request to chan 1 followed by 0

  Note:  When you are looking at a PBC address, its actually Bank/2 - {pppppppppppp, bbbb, c}
      */

  genvar chan;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: last_mismatch
        always @(*)
          begin
            pbc_last_requested_mismatch [chan] = ~pbc_last_requested_valid[chan] | (pbc_last_end_addr_bank != pbc_bank_last_requested[chan]) | (pbc_last_end_addr_page != pbc_page_last_requested[chan]);
          end
      end
  endgenerate
//                 case ({(~pbc_last_requested_valid[1] | (pbc_last_end_addr_bank != pbc_bank_last_requested[1]) | (pbc_last_end_addr_page != pbc_page_last_requested[1])), (~pbc_last_requested_valid[0] | (pbc_last_end_addr_bank != pbc_bank_last_requested[0]) | (pbc_last_end_addr_page != pbc_page_last_requested[0]))})  

  always @(posedge clk)
    begin
      case (sdp_cntl_proc_storage_desc_state)  // synopsys parallel_case

        `SDP_CNTL_PROC_STORAGE_DESC_WAIT:
           begin
             first_time_thru                  <= 1'b1   ;
             force_cons_chan0_request         <= 1'b0   ;
             force_cons_chan1_request         <= 1'b0   ;
             force_cons_chan01_request        <= 1'b0   ;
             force_cons_chan10_request        <= 1'b0   ;
             force_jump_chan0_request         <= 1'b0   ;
             force_jump_chan1_request         <= 1'b0   ;
             force_jump_chan01_request        <= 1'b0   ;
             force_jump_chan10_request        <= 1'b0   ;
             force_disable_request            <= 1'b0   ;
           end

        `SDP_CNTL_PROC_STORAGE_DESC_CHECK_PBC_VALUES:
           begin
             first_time_thru                  <= 1'b0 ;
             // if last_end_addr points to cons(t-1).end, and cons(t).start is in the same bank/page, then assume the channels with this bank/page have already been requested
             //force_disable_request            <= pbc_last_end_is_cons_tm1_end & ((pbc_inc_addr_bank == pbc_last_end_addr_bank) & (pbc_inc_addr_page == pbc_last_end_addr_page));
             force_disable_request            <= pbc_last_end_is_cons_tm1_end & pbc_last_requested_valid [pbc_inc_addr_chan] & (pbc_inc_addr_bank == pbc_bank_last_requested [pbc_inc_addr_chan]) & (pbc_page_last_requested [pbc_inc_addr_chan] == pbc_inc_addr_page);

             case (storage_desc_accessOrder)
               PY_WU_INST_ORDER_TYPE_CWBP:
                 begin
                   if (((pbc_inc_addr_bank == pbc_end_addr_bank) && (pbc_inc_addr_page == pbc_end_addr_page) && ~(pbc_last_end_is_cons_tm1_end && (pbc_inc_addr_bank == pbc_last_end_addr_bank) && (pbc_inc_addr_page == pbc_last_end_addr_page))))
                     begin
                       case ({first_time_thru, pbc_inc_addr_chan, pbc_end_addr_chan})
                         3'b000:
                           begin
                             force_cons_chan0_request  <= 1'b0 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b1 ;
                             force_cons_chan10_request <= 1'b0 ;
                           end
                         3'b001:
                           begin
                             force_cons_chan0_request  <= 1'b0 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b0 ;
                           end
                         3'b010:
                           begin
                             force_cons_chan0_request  <= 1'b0 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b1 ;
                           end
                         3'b011:
                           begin
                             force_cons_chan0_request  <= 1'b0 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b1 ;
                           end
                         // first time thru we assume the first request has been performed
                         3'b100:
                           begin
                             force_cons_chan0_request  <= 1'b0 ;
                             force_cons_chan1_request  <= 1'b1 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b0 ;
                           end
                         3'b101:
                           begin
                             force_cons_chan0_request  <= 1'b0 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b0 ;
                           end
                         3'b110:
                           begin
                             force_cons_chan0_request  <= 1'b1 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b0 ;
                           end
                         3'b111:
                           begin
                             force_cons_chan0_request  <= 1'b1 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b0 ;
                           end

                       endcase  // case ({pbc_inc_addr_chan, pbc_end_addr_chan})
                     end
                   // Consider the case where we jump to a new consequtive and the start bank isnt equal to the end bank
                   // If the start channel is 1, we will increment to the next bank but we wont have requested channel 0
                   else if ((pbc_inc_addr_bank != pbc_end_addr_bank) && pbc_last_end_is_cons_tm1_end )
                     begin
                       case ({first_time_thru, pbc_inc_addr_chan})
                         2'b01:
                           begin
                             force_cons_chan0_request  <= 1'b0 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b1 ;
                           end
                         // first time thru we assume the first request has been performed
                         2'b11:
                           begin
                             force_cons_chan0_request  <= 1'b1 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b0 ;
                           end
                         default
                           begin
                             force_cons_chan0_request  <= 1'b0 ;
                             force_cons_chan1_request  <= 1'b0 ;
                             force_cons_chan01_request <= 1'b0 ;
                             force_cons_chan10_request <= 1'b0 ;
                           end

                       endcase  // case ({pbc_inc_addr_chan, pbc_end_addr_chan})
                     end
                 end
               default:
                 begin
                   force_cons_chan0_request  <= 1'b0 ;
                   force_cons_chan1_request  <= 1'b0 ;
                   force_cons_chan01_request <= 1'b0 ;
                   force_cons_chan10_request <= 1'b0 ;
                 end
             endcase  // case (storage_desc_accessOrder)

           end  //`SDP_CNTL_PROC_STORAGE_DESC_CHECK_PBC_VALUES:

        `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_EXTRA_RESPONSE_ID:
           begin

             if (force_cons_request)
               begin
                 case ({force_cons_chan01_request, force_cons_chan10_request })  // synopsys full_case parallel_case
                   2'b00:
                     begin
                       force_cons_chan0_request  <= 1'b0 ;
                       force_cons_chan1_request  <= 1'b0 ;
                       force_cons_chan01_request <= 1'b0 ;
                       force_cons_chan10_request <= 1'b0 ;
                     end
                   2'b01:
                     begin
                       force_cons_chan0_request  <= 1'b1 ;
                       force_cons_chan1_request  <= 1'b0 ;
                       force_cons_chan01_request <= 1'b0 ;
                       force_cons_chan10_request <= 1'b0 ;
                     end
                   2'b10:
                     begin
                       force_cons_chan0_request  <= 1'b0 ;
                       force_cons_chan1_request  <= 1'b1 ;
                       force_cons_chan01_request <= 1'b0 ;
                       force_cons_chan10_request <= 1'b0 ;
                     end
                 endcase  // case ({force_cons_chan01_request, force_cons_chan10_request })
               end
             else if (requests_complete && ~first_time_thru && (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP))
               begin
                 // if we are completing a consequtive zone, the access order is CWBP and we havent fetched both channels, then anticipate we have jumped over a channel
                 // e.g. pbc_start = 0,24,1,  pbc_end = 0,26,0
                 //      pbc_start = 0, 8,1,  pbc_end = 0,10,1
                 // We saw this mainly during the writeback testing where we are writing back 32 words in CWBP order and the address crossed a bank/channel boundary
                 //case ({(~pbc_last_requested_valid[1] | (pbc_last_end_addr_bank != pbc_bank_last_requested[1]) | (pbc_last_end_addr_page != pbc_page_last_requested[1])), (~pbc_last_requested_valid[0] | (pbc_last_end_addr_bank != pbc_bank_last_requested[0]) | (pbc_last_end_addr_page != pbc_page_last_requested[0]))})  
                 case ({pbc_last_requested_mismatch[1],  pbc_last_requested_mismatch[0]})
                   2'b00:
                     begin
                       force_cons_chan0_request  <= 1'b0 ;
                       force_cons_chan1_request  <= 1'b0 ;
                       force_cons_chan01_request <= 1'b0 ;
                       force_cons_chan10_request <= 1'b0 ;
                     end
                   2'b01:
                     begin
                       force_cons_chan0_request  <= 1'b1 ;
                       force_cons_chan1_request  <= 1'b0 ;
                       force_cons_chan01_request <= 1'b0 ;
                       force_cons_chan10_request <= 1'b0 ;
                     end
                   2'b10:
                     begin
                       force_cons_chan0_request  <= 1'b0 ;
                       force_cons_chan1_request  <= 1'b1 ;
                       force_cons_chan01_request <= 1'b0 ;
                       force_cons_chan10_request <= 1'b0 ;
                     end
                 endcase  // case ({force_cons_chan01_request, force_cons_chan10_request })
               end

           end  //`SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST:


        default:
           begin
             force_disable_request            <= 1'b0                             ;  // clear as soon as we have been in PBC_INC 
             first_time_thru                  <= first_time_thru                  ;
             force_cons_chan0_request         <= force_cons_chan0_request         ;
             force_cons_chan1_request         <= force_cons_chan1_request         ;
             force_cons_chan01_request        <= force_cons_chan01_request        ;
             force_cons_chan10_request        <= force_cons_chan10_request        ;
           end
      endcase
    end

  // end of Special Conditions
  //
  //------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------

  reg create_mem_request ;
  reg create_response_id     ;  // make sure the stream controller knows the full address of each returned transaction from the mmc
  always @(*)
    begin 
      case (storage_desc_accessOrder)  // synopsys parallel_case full_case
        PY_WU_INST_ORDER_TYPE_WCBP :
          begin
            create_mem_request  = ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST ) & xxx__sdp__mem_request_ready_d1 & sdps__sdpr__response_id_ready_d1) ; //                &
          end
        PY_WU_INST_ORDER_TYPE_CWBP :
          begin
            create_mem_request  = ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST ) & xxx__sdp__mem_request_ready_d1 & sdps__sdpr__response_id_ready_d1)  ; //              &
          end
        default:
          begin
            create_mem_request  = 'd0 ;
          end
      endcase

      // We need to feed the mmc line address back to the steram controller
      create_response_id      =  ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_READ                       )                                  ) |
                                 ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST           ) & xxx__sdp__mem_request_ready_d1 & sdps__sdpr__response_id_ready_d1 ) |
                                 ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_EXTRA_RESPONSE_ID )                                  ) |
                                 ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_REQUESTS_COMPLETE          )                                  ) ;

    end

`ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
  always @(*)
    begin
      case (storage_desc_accessOrder)  // synopsys parallel_case full_case
        PY_WU_INST_ORDER_TYPE_WCBP :
          begin
            requests_complete =  (pbc_end_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE  ] == pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE  ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE  ] == pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE  ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE  ] == pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE  ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBCL_CLINE_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBCL_CLINE_FIELD_RANGE ] ) ;
                                            
            
            bank_change       =  (pbc_last_end_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE  ] != pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE  ] ) ;  // as we increment thru the consequtive phase, check if we have changed bank or page
            page_change       =  (pbc_last_end_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE  ] != pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE  ] ) ;  
            channel_change    =  (pbc_last_end_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE  ] != pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE  ] ) ;  
            line_change       =  (pbc_last_end_addr[`MGR_DRAM_PBCL_CLINE_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBCL_CLINE_FIELD_RANGE ] ) ;  
            
            generate_requests =  ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC ) & (bank_change | page_change | channel_change | line_change)) & ~force_disable_request ; //&
/*
                                   ~(  channel_last_requested_valid [pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]]                                                    &
                                      (channel_last_requested_bank  [pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]] == pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ]) &
                                      (channel_last_requested_page  [pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]] == pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ]) &
                                      (channel_last_requested_cline  [pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ]] == pbc_inc_addr[`MGR_DRAM_PBCL_CLINE_FIELD_RANGE ])) ;
*/
          end
        PY_WU_INST_ORDER_TYPE_CWBP :
          begin
            requests_complete =  (pbc_end_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE  ] == pbc_inc_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE  ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE  ] == pbc_inc_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE  ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE  ] == pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE  ] ) &
                                 (pbc_end_addr[`MGR_DRAM_PBLC_CLINE_FIELD_RANGE ] == pbc_inc_addr[`MGR_DRAM_PBLC_CLINE_FIELD_RANGE ] ) ;
                                            
            
            bank_change       =  (pbc_last_end_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE  ] != pbc_inc_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE  ] ) ;  // as we increment thru the consequtive phase, check if we have changed bank or page
            page_change       =  (pbc_last_end_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE  ] != pbc_inc_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE  ] ) ;  
            channel_change    =  (pbc_last_end_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE  ] != pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE  ] ) ;  
            line_change       =  (pbc_last_end_addr[`MGR_DRAM_PBLC_CLINE_FIELD_RANGE ] != pbc_inc_addr[`MGR_DRAM_PBLC_CLINE_FIELD_RANGE ] ) ;  
            
            generate_requests =  ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC ) & (bank_change | page_change | channel_change | line_change)) & ~force_disable_request ; //&
/*
                                   ~(  channel_last_requested_valid [pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ]]                                                    &
                                      (channel_last_requested_bank  [pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ]] == pbc_inc_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ]) &
                                      (channel_last_requested_page  [pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ]] == pbc_inc_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ]) &
                                      (channel_last_requested_cline  [pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ]] == pbc_inc_addr[`MGR_DRAM_PBLC_CLINE_FIELD_RANGE ])) ;
*/
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
      
      generate_requests =  ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC ) & (bank_change | page_change | channel_change )) & ~force_disable_request ; // &
/*
                             ~(  channel_last_requested_valid [pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ]]                                                    &
                                (channel_last_requested_bank  [pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ]] == pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ]) &
                                (channel_last_requested_page  [pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ]] == pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ]) ) ;
*/
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
                     ( inc_consJumpPtr                                                                ) ? consJumpPtr+1            :
                                                                                                          consJumpPtr              ;
         
    end

  // increment the ptr each time we are about to enter that the state that uses the output
  always @(*)
    begin
      inc_consJumpPtr     =  ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC          ) &  ~force_cons_request & ~force_jump_request & requests_complete & ~generate_requests & ~consJumpMemory_som & ~consJumpMemory_eom ) |  // transition to JUMP state
                             ((sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO  ) &  sdps__sdpr__consJump_ready & ~consJumpMemory_eom ) ;  // transition to CONS state
    end

  //----------------------------------------------------------------------------------------------------
  //
  // Construct Memory requests
  //
  // These regs will be initialized to the storage descriptor base address and then incremented based on access order
  // When the addresses transtition to another bank or page, a memory request will be generated

  always @(posedge clk)
    begin
      case (sdp_cntl_proc_storage_desc_state)  // synopsys parallel_case
        `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID :
          begin
            storage_desc_bank_lsb <= storage_desc_bank[0] ;  // temporary store of bank lsb as we increment thru the consequtive/jump phases
          end
        default:
          begin
            storage_desc_bank_lsb <=  storage_desc_bank_lsb ;
          end
      endcase
    end

  // Set end of current consequtive phase
  always @(posedge clk)
    begin
      case (sdp_cntl_proc_storage_desc_state)  // synopsys parallel_case
        `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID :
          begin
            // Initialize starting increment address
            case (storage_desc_accessOrder )  // synopsys parallel_case
              PY_WU_INST_ORDER_TYPE_WCBP:
                begin
                  cj_address              <=  {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_channel, storage_desc_word, 2'b00} ;
                  cj_ms_lane_address      <=  (strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST  ) ? {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_channel, storage_desc_word, 2'b00} :
                                              (strm_transfer_type == PY_WU_INST_TXFER_TYPE_VECTOR ) ? {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_channel, storage_desc_word, 2'b00} + {xxx__sdp__num_lanes_m1, 2'b00} : 
                                                                                                      {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_channel, storage_desc_word, 2'b00} ;
                end
              PY_WU_INST_ORDER_TYPE_CWBP:
                begin
                  cj_address              <=  {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_word,  storage_desc_channel, 2'b00} ;  // byte address
                  cj_ms_lane_address      <=  (strm_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST  ) ? {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_word, storage_desc_channel, 2'b00} :
                                              (strm_transfer_type == PY_WU_INST_TXFER_TYPE_VECTOR ) ? {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_word, storage_desc_channel, 2'b00} + {xxx__sdp__num_lanes_m1, 2'b00} : 
                                                                                                      {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_word, storage_desc_channel, 2'b00} ;
                  //cj_ms_lane_address      <=  {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_word,  storage_desc_channel, 2'b00} + {xxx__sdp__num_lanes_m1, 2'b00} ; 
                  //cj_ms_lane_address      <=  {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_word, storage_desc_channel, 2'b00} + {consJumpMemory_value, 2'b00} ;  // byte address
                end
              default:
                begin
                  cj_address           <=  cj_address ;
                  cj_ms_lane_address   <=  cj_ms_lane_address ;
                end
            endcase
          end
        `SDP_CNTL_PROC_STORAGE_DESC_CONS_FIELD :
          begin
            // FIXME: Need to accomodate a consequtive value traversing multiple bank/pages
            // Jump value is from previous end location so add consequtive and jump to start address to get next start address
            cj_address              <=  cj_address         + {consJumpMemory_value, 2'b00} ;  // account for byte address 
            cj_ms_lane_address      <=  cj_ms_lane_address + {consJumpMemory_value, 2'b00} ;  // account for byte address 
          end
        `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD :
          begin
            cj_address           <=  (~consJumpMemory_eom) ? cj_address         + {consJumpMemory_value, 2'b00} :  // account for byte address
                                                             cj_address                                 ;
            cj_ms_lane_address   <=  (~consJumpMemory_eom) ? cj_ms_lane_address + {consJumpMemory_value, 2'b00} :  // account for byte address
                                                             cj_ms_lane_address                                 ;
          end
        default:
          begin
            cj_address   <=  cj_address ;
            cj_ms_lane_address   <=  cj_ms_lane_address ;
          end
      endcase
    end

  always @(posedge clk)
    begin
      case (sdp_cntl_proc_storage_desc_state)  // synopsys parallel_case

        `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID:
          begin
            mem_start_address           <=  {storage_desc_channel, storage_desc_bank, storage_desc_page, storage_desc_word, 2'b00} ;
            mem_ms_lane_start_address   <=  {storage_desc_channel, storage_desc_bank, storage_desc_page, storage_desc_word, 2'b00} + {xxx__sdp__num_lanes_m1, 2'b00} ;
          end

        `SDP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO :
          begin
            // when we enter the CHECK_STRM state the cj address points to beginning of next consequtive phase
            mem_start_address         <=  {        cj_channel,         cj_bank, storage_desc_bank_lsb,         cj_page,         cj_word, 2'b00} ;
            mem_ms_lane_start_address <=  {cj_ms_lane_channel, cj_ms_lane_bank, storage_desc_bank_lsb, cj_ms_lane_page, cj_ms_lane_word, 2'b00} ;
          end

        default:
          begin
            mem_start_address         <=  mem_start_address         ;
            mem_ms_lane_start_address <=  mem_ms_lane_start_address ;
          end
      endcase
    end

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // **** Remember :page, bank/2, channel****
  //       PBC => {pppppppppppp, bbbb, c}
  //
  always @(posedge clk)
    begin
      case (sdp_cntl_proc_storage_desc_state)  // synopsys parallel_case

        `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID:
           begin
             case (storage_desc_accessOrder)  // synopsys parallel_case
               PY_WU_INST_ORDER_TYPE_WCBP:
                 begin
                   `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                     pbc_inc_addr <=  {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_channel, storage_desc_cline} ; 
                   `else
                     pbc_inc_addr <=  {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_channel} ;
                   `endif
                 end
               PY_WU_INST_ORDER_TYPE_CWBP:
                 begin
                   `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                     pbc_inc_addr <=  {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_cline, storage_desc_channel} ; 
                   `else
                     pbc_inc_addr <=  {storage_desc_page, {storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ]}, storage_desc_channel} ; 
                   `endif
                 end
               default:
                  begin
                    pbc_inc_addr <= pbc_inc_addr ;
                  end
             endcase
             pbc_last_requested_valid   <= 2'b00 ; // Keep track of the previously requested bank/page for each channel
           end

        `SDP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS:
           begin
             case (storage_desc_accessOrder)  // synopsys parallel_case
               PY_WU_INST_ORDER_TYPE_WCBP:
                 begin
                   `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                     pbc_inc_addr    <=  {mem_start_page, mem_start_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], mem_start_channel, mem_start_cline} ;
                   `else
                     pbc_inc_addr    <=  {mem_start_page, mem_start_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], mem_start_channel} ;
                   `endif
                 end
               PY_WU_INST_ORDER_TYPE_CWBP:
                 begin
                   `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                     pbc_inc_addr    <=  {mem_start_page, mem_start_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], mem_start_cline, mem_start_channel} ;
                   `else
                     pbc_inc_addr    <=  {mem_start_page, mem_start_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], mem_start_channel} ;
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
             casex ({force_jump_request, force_cons_request, generate_requests})  // 
               3'b000:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr + 'd1 ;
                 end
               3'b001:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
               3'b01x:
                 begin
                     pbc_inc_addr    <=  pbc_inc_addr ;
                     // cannot set to pbc_end because pbc_end might be a few banks away and we might miss some requests
                     // e.g. pbc_inc = 0,4.1, pbc_end = 0,8,1
                     // but we need to force a channel 1 request in bank 4, and we will jumo right to 0,8,1 and miss bank 6
                     //pbc_inc_addr    <=  pbc_end_addr ;  // if we are forcing a request, set inc -> end.
                 end
               3'b1xx:
                 begin
                     pbc_inc_addr    <=  pbc_inc_addr ;
                 end
               default:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
             endcase
           end


        `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST:
           begin
             casex ({(xxx__sdp__mem_request_ready_d1 & sdps__sdpr__response_id_ready_d1), force_cons_request, requests_complete}) 
               3'b0xx:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
               3'b100:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
               3'b101:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
               3'b110:
                 begin
                     pbc_inc_addr    <=  pbc_inc_addr ;
                 end
               3'b111:
                 begin
                     pbc_inc_addr    <=  pbc_inc_addr ;
                 end
               default:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr  ;
                 end
             endcase

             pbc_last_requested_valid [0] <= (force_cons_chan0_request || force_cons_chan01_request )  ?  1'b1                         :
                                             (pbc_inc_addr_chan == 'd0                              )  ?  1'b1                         :
                                                                                                          pbc_last_requested_valid [0] ;
             pbc_last_requested_valid [1] <= (force_cons_chan1_request || force_cons_chan10_request )  ?  1'b1                         :
                                             (pbc_inc_addr_chan == 'd1                              )  ?  1'b1                         :
                                                                                                          pbc_last_requested_valid [1] ;
             pbc_bank_last_requested  [0] <= (force_cons_chan0_request || force_cons_chan01_request )  ?  pbc_inc_addr_bank            :
                                             (pbc_inc_addr_chan == 'd0                              )  ?  pbc_inc_addr_bank            :
                                                                                                          pbc_bank_last_requested  [0] ;
             pbc_bank_last_requested  [1] <= (force_cons_chan1_request || force_cons_chan10_request )  ?  pbc_inc_addr_bank            :
                                             (pbc_inc_addr_chan == 'd1                              )  ?  pbc_inc_addr_bank            :
                                                                                                          pbc_bank_last_requested  [1] ;
             pbc_page_last_requested  [0] <= (force_cons_chan0_request || force_cons_chan01_request )  ?  pbc_inc_addr_page            :
                                             (pbc_inc_addr_chan == 'd0                              )  ?  pbc_inc_addr_page            :
                                                                                                          pbc_page_last_requested  [0] ;
             pbc_page_last_requested  [1] <= (force_cons_chan1_request || force_cons_chan10_request )  ?  pbc_inc_addr_page            :
                                             (pbc_inc_addr_chan == 'd1                              )  ?  pbc_inc_addr_page            :
                                                                                                          pbc_page_last_requested  [1] ;
           end

        `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_EXTRA_RESPONSE_ID:
           begin
             // if we are at the end of a consequtive phase, dont increment the pbc_inc_addr past the pbc_end_addr
             casex ({requests_complete, force_cons_request, pbc_last_requested_mismatch[1],  pbc_last_requested_mismatch[0]})
               4'b0000:
                 begin
                   pbc_inc_addr    <=  pbc_inc_addr + 'd1 ;
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


  always @(posedge clk)
    begin
      case (sdp_cntl_proc_storage_desc_state)  // synopsys parallel_case
        `SDP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID :
          begin
            //---------------------------------------------------------------------------
            // pbc_end_addr
            //
            // set req == end to generate the first requests
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
                begin
                  pbc_end_addr <=  {storage_desc_page, storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], storage_desc_channel, storage_desc_cline};
                end
              else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
                begin
                  pbc_end_addr <=  {storage_desc_page, storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], storage_desc_cline, storage_desc_channel};
                end
            `else
              pbc_end_addr <=  {storage_desc_page, storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], storage_desc_channel};
            `endif

            //---------------------------------------------------------------------------
            // pbc_last_end_addr
            //
            if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  pbc_last_end_addr    <=  {storage_desc_page, storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], storage_desc_channel, storage_desc_cline};
                `else
                  pbc_last_end_addr    <=  {storage_desc_page, storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], storage_desc_channel};
                `endif
              end
            else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  pbc_last_end_addr    <=  {storage_desc_page, storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], storage_desc_cline, storage_desc_channel};
                `else
                  pbc_last_end_addr    <=  {storage_desc_page, storage_desc_bank[`MGR_DRAM_BANK_ADDRESS_WO_LSB_RANGE ], storage_desc_channel};
                `endif
              end
            
            //---------------------------------------------------------------------------
          end

        `SDP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS :
          begin
            //---------------------------------------------------------------------------
            // pbc_end_addr
            //
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
                begin
                  pbc_end_addr <=  {cj_ms_lane_page, cj_ms_lane_bank, cj_ms_lane_channel, cj_ms_lane_cline};
                end
              else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
                begin
                  pbc_end_addr <=  {cj_ms_lane_page, cj_ms_lane_bank, cj_ms_lane_cline, cj_ms_lane_channel};
                end
            `else
              pbc_end_addr <=  {cj_ms_lane_page, cj_ms_lane_bank, cj_ms_lane_channel};
            `endif

            //---------------------------------------------------------------------------
            // pbc_last_end_addr
            //
            pbc_last_end_addr    <=  pbc_last_end_addr      ;

            //---------------------------------------------------------------------------

          end

        `SDP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD :
          begin
            //---------------------------------------------------------------------------
            // pbc_end_addr
            //
            pbc_end_addr                    <=  pbc_end_addr        ;

            //---------------------------------------------------------------------------
            // pbc_last_end_addr
            //
            // mem_addr is current set to end of CONS phase, so set last req to end of previous consequtive phase
            // cj_address is currently cons(t).end and about to be set to cons(t+1).start
            // set pbc_last_end to cons(t).end
            if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  pbc_last_end_addr    <=  {cj_ms_lane_page, cj_ms_lane_bank, cj_ms_lane_channel, cj_ms_lane_cline};
                `else
                  pbc_last_end_addr    <=  {cj_ms_lane_page, cj_ms_lane_bank, cj_ms_lane_channel};
                `endif
              end
            else if (storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  pbc_last_end_addr    <=  {cj_ms_lane_page, cj_ms_lane_bank, cj_ms_lane_cline, cj_ms_lane_channel};
                `else
                  pbc_last_end_addr    <=  {cj_ms_lane_page, cj_ms_lane_bank, cj_ms_lane_channel};
                `endif
              end

            pbc_last_end_is_cons_tm1_end <= 1'b1                 ;

            //---------------------------------------------------------------------------
          end

        `SDP_CNTL_PROC_STORAGE_DESC_INC_PBC:
           begin
             case ({force_jump_request, force_cons_chan0_request, generate_requests})  // 
               3'b000:
                 begin
                   pbc_end_addr    <=  pbc_end_addr  ;
                 end
               3'b001:
                 begin
                   pbc_end_addr    <=  pbc_end_addr  ;
                 end
               3'b01x:
                 begin
                     pbc_end_addr    <=  pbc_inc_addr ;
                 end
               3'b1xx:
                 begin
                     pbc_end_addr    <=  pbc_end_addr ;
                 end
               default:
                 begin
                   pbc_end_addr    <=  pbc_end_addr  ;
                 end
             endcase
           end

        `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST :
          begin
            //---------------------------------------------------------------------------
            // pbc_end_addr
            //
            pbc_end_addr         <=  pbc_end_addr           ;

            //---------------------------------------------------------------------------
            // pbc_last_end_addr
            //
            // mem_addr is current set to end of CONS phase, so set last req to end of previous consequtive phase
            pbc_last_end_addr               <=  pbc_inc_addr   ;
            pbc_last_end_is_cons_tm1_end <= 1'b0            ;
            //---------------------------------------------------------------------------
          end

        default:
          begin
            pbc_end_addr         <=  pbc_end_addr           ;
            pbc_last_end_addr    <=  pbc_last_end_addr      ;
          end
      endcase
    end

  // extract chan/bank/page/word fields from ordered address
  always @(*)
    begin
      case (storage_desc_accessOrder )  // synopsys parallel_case
        PY_WU_INST_ORDER_TYPE_WCBP:
          begin
            cj_channel =  cj_address[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
            cj_bank    =  cj_address[`MGR_DRAM_WCBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_page    =  cj_address[`MGR_DRAM_WCBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_word    =  cj_address[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              cj_cline  =  cj_address[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
            `endif
          end
       
        PY_WU_INST_ORDER_TYPE_CWBP:
          begin
            cj_channel =  cj_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
            cj_bank    =  cj_address[`MGR_DRAM_CWBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_page    =  cj_address[`MGR_DRAM_CWBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_word    =  cj_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              cj_cline  =  cj_address[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
            `endif
          end
       
        default:
          begin
            cj_channel =  cj_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
            cj_bank    =  cj_address[`MGR_DRAM_CWBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_page    =  cj_address[`MGR_DRAM_CWBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_word    =  cj_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              cj_cline  =  cj_address[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
            `endif
          end
      endcase
    end

  always @(*)
    begin
      case (storage_desc_accessOrder )  // synopsys parallel_case
        PY_WU_INST_ORDER_TYPE_WCBP:
          begin
            cj_ms_lane_channel =  cj_ms_lane_address[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
            cj_ms_lane_bank    =  cj_ms_lane_address[`MGR_DRAM_WCBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_ms_lane_page    =  cj_ms_lane_address[`MGR_DRAM_WCBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_ms_lane_word    =  cj_ms_lane_address[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              cj_ms_lane_cline  =  cj_ms_lane_address[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
            `endif
          end
       
        PY_WU_INST_ORDER_TYPE_CWBP:
          begin
            cj_ms_lane_channel =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
            cj_ms_lane_bank    =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_ms_lane_page    =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_ms_lane_word    =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              cj_ms_lane_cline  =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
            `endif
          end
       
        default:
          begin
            cj_ms_lane_channel =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
            cj_ms_lane_bank    =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_BANK_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_ms_lane_page    =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_PAGE_WO_BANK_LSB_FIELD_RANGE ]  ;
            cj_ms_lane_word    =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              cj_ms_lane_cline  =  cj_ms_lane_address[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
            `endif
          end
      endcase
    end

  // extract chan/bank/page/word fields from previous request address
  always @(*)
    begin
      mem_start_channel =  mem_start_address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  ;
      mem_start_bank    =  mem_start_address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  ;
      mem_start_page    =  mem_start_address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  ;
      mem_start_word    =  mem_start_address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  ;
      `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
        mem_start_line  =  mem_start_address[`MGR_DRAM_ADDRESS_LINE_FIELD_RANGE ]  ;
      `endif
      `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
        mem_start_cline  =  mem_start_address[`MGR_DRAM_ADDRESS_CLINE_FIELD_RANGE ]  ;
      `endif
    end

  always @(*)
    begin
      sdp__xxx__mem_request_valid_e1   =  create_mem_request                            ;
      sdp__xxx__mem_request_cntl_e1    = `COMMON_STD_INTF_CNTL_SOM_EOM                  ;  // memory request is single cycle
      sdp__xxx__mem_request_tag_e1     = xxx__sdp__tag                                  ;
      case (storage_desc_accessOrder)  // synopsys parallel_case full_case
        PY_WU_INST_ORDER_TYPE_WCBP :
          begin
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              sdp__xxx__mem_request_channel_e1 =  (force_cons_chan0_request || force_cons_chan01_request )  ?  1'b0   :
                                                  (force_cons_chan1_request || force_cons_chan10_request )  ?  1'b1   :
                                                                                                               pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
              sdp__xxx__mem_request_bank_e1    = {pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ], storage_desc_bank_lsb}  ;
              sdp__xxx__mem_request_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] ;
              sdp__xxx__mem_request_word_e1    = 'd0 ;  // FIXME : always aligned requests but need to be more flexible if there are more than two lines in a cacheline
            `else
              sdp__xxx__mem_request_channel_e1 =  (force_cons_chan0_request || force_cons_chan01_request )  ?  1'b0   :
                                                  (force_cons_chan1_request || force_cons_chan10_request )  ?  1'b1   :
                                                                                                               pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
              sdp__xxx__mem_request_bank_e1    = {pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ], storage_desc_bank_lsb}  ;
              sdp__xxx__mem_request_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              sdp__xxx__mem_request_word_e1    =  'd0                                           ;
            `endif
          end
        PY_WU_INST_ORDER_TYPE_CWBP :
          begin
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  // MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              sdp__xxx__mem_request_channel_e1 =  (force_cons_chan0_request || force_cons_chan01_request )  ?  1'b0   :
                                                  (force_cons_chan1_request || force_cons_chan10_request )  ?  1'b1   :
                                                                                                               pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
              sdp__xxx__mem_request_bank_e1    = {pbc_inc_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ], storage_desc_bank_lsb}  ;
              sdp__xxx__mem_request_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] ;
              sdp__xxx__mem_request_word_e1    =  'd0                                           ;
            `else
              sdp__xxx__mem_request_channel_e1 =  (force_cons_chan0_request || force_cons_chan01_request )  ?  1'b0   :
                                                  (force_cons_chan1_request || force_cons_chan10_request )  ?  1'b1   :
                                                                                                               pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
              sdp__xxx__mem_request_bank_e1    = {pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ], storage_desc_bank_lsb}  ;
              sdp__xxx__mem_request_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              sdp__xxx__mem_request_word_e1    =  'd0                                           ;
            `endif
          end
      endcase
    end
  always @(*)
    begin
      sdpr__sdps__response_id_valid_e1   =  create_response_id ;

      //  We always send a SOM and EOM but these are used purely for delineation and dont have a MMC data association
      //  We do this so we can flush any extra requests
      case (sdp_cntl_proc_storage_desc_state )
        `SDP_CNTL_PROC_STORAGE_DESC_READ :
          begin
            sdpr__sdps__response_id_cntl_e1    = `COMMON_STD_INTF_CNTL_SOM    ;  // dummy start
          end
        `SDP_CNTL_PROC_STORAGE_DESC_REQUESTS_COMPLETE:
          begin
            sdpr__sdps__response_id_cntl_e1    = `COMMON_STD_INTF_CNTL_EOM    ;  // memory request 
          end
        default:
          begin
            sdpr__sdps__response_id_cntl_e1    = `COMMON_STD_INTF_CNTL_MOM    ;  // dummy end
          end
      endcase

      case (storage_desc_accessOrder)  // synopsys parallel_case full_case
        PY_WU_INST_ORDER_TYPE_WCBP :
          begin
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  
              sdpr__sdps__response_id_channel_e1 = (force_cons_chan0_request || force_cons_chan01_request )  ?  1'b0   :
                                                   (force_cons_chan1_request || force_cons_chan10_request )  ?  1'b1   :
                                                                                                                pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
              sdpr__sdps__response_id_bank_e1    = {pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ], storage_desc_bank_lsb}  ;
              sdpr__sdps__response_id_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              sdpr__sdps__response_id_line_e1    = (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST          ) ?  'd0 :
                                                   (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_EXTRA_RESPONSE_ID) ?  'd1 :
                                                                                                                                                   'd0 ;
            `else
              sdpr__sdps__response_id_channel_e1 =   (force_cons_chan0_request || force_cons_chan01_request )  ?  1'b0   :
                                                     (force_cons_chan1_request || force_cons_chan10_request )  ?  1'b1   :
                                                                                                                  pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
              sdpr__sdps__response_id_bank_e1    = {pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ], storage_desc_bank_lsb}  ;
              sdpr__sdps__response_id_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              sdpr__sdps__response_id_line_e1    = (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST          ) ?  'd0 :
                                                   (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_EXTRA_RESPONSE_ID) ?  'd1 :
                                                                                                                                                   'd0 ;
            `endif
          end
        PY_WU_INST_ORDER_TYPE_CWBP :
          begin
            `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE  
              sdpr__sdps__response_id_channel_e1  =  (force_cons_chan0_request || force_cons_chan01_request )  ?  1'b0   :
                                                     (force_cons_chan1_request || force_cons_chan10_request )  ?  1'b1   :
                                                                                                                  pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
              sdpr__sdps__response_id_bank_e1     =  {pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ], storage_desc_bank_lsb}  ;
              sdpr__sdps__response_id_page_e1     =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              sdpr__sdps__response_id_line_e1     = (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST          ) ?  'd0 :
                                                    (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_EXTRA_RESPONSE_ID) ?  'd1 :
                                                                                                                                                    'd0 ;
            `else
              sdpr__sdps__response_id_channel_e1 =  (force_cons_chan0_request || force_cons_chan01_request )  ?  1'b0   :
                                                    (force_cons_chan1_request || force_cons_chan10_request )  ?  1'b1   :
                                                                                                                 pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
              sdpr__sdps__response_id_bank_e1    = {pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ], storage_desc_bank_lsb} ;
              sdpr__sdps__response_id_page_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              sdpr__sdps__response_id_line_e1     = (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_REQUEST          ) ?  'd0 :
                                                    (sdp_cntl_proc_storage_desc_state == `SDP_CNTL_PROC_STORAGE_DESC_GENERATE_EXTRA_RESPONSE_ID) ?  'd1 :
                                                                                                                                                    'd0 ;
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
     sdpr__sdps__cfg_lane_enable  = xxx__sdp__lane_enable      ;
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
  
  wire   [`MGR_DRAM_ADDRESS_RANGE                        ]  sdmem_Address          ;
  wire   [`MGR_INST_OPTION_ORDER_RANGE                   ]  sdmem_AccessOrder      ;
  wire   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  sdmem_consJumpPtr      ;

  reg    [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE          ]  sdmem_storage_desc_ptr ;
  reg                                                       sdmem_write            ;
  reg    [`MGR_LOCAL_STORAGE_DESC_AGGREGATE_MEM_RANGE    ]  sdmem_write_data       ;

  genvar gvi ;
  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: storageDesc_mem

        generic_1port_memory #(.GENERIC_MEM_DEPTH          (`MGR_LOCAL_STORAGE_DESC_MEMORY_DEPTH        ),
                               .GENERIC_MEM_REGISTERED_OUT (0                                           ),
                               .GENERIC_MEM_DATA_WIDTH     (`MGR_LOCAL_STORAGE_DESC_AGGREGATE_MEM_WIDTH )
                        ) gmemory ( 
                        
                        //---------------------------------------------------------------
                        // Initialize
                        //
                        `ifndef SYNTHESIS
                           .memFile ($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptor_readmem.dat", sys__mgr__mgrId)),
                        `endif

                        //---------------------------------------------------------------
                        // Port 
                        .portA_address       ( sdmem_storage_desc_ptr                               ),
                        .portA_write_data    ( sdmem_write_data                                     ),
                        .portA_read_data     ( {sdmem_Address, sdmem_consJumpPtr, sdmem_AccessOrder}),
                        .portA_enable        ( 1'b1                                                 ), 
                        .portA_write         ( sdmem_write                                          ),
                        
                        //---------------------------------------------------------------
                        // General
                        .reset_poweron       ( reset_poweron                                        ),
                        .clk                 ( clk                                                  )
                        ) ;

      end
  endgenerate

  always @(*)
    begin
      sdmem_write             =   mcntl__sdp__enable_sdmem_dnld_d1 &  mcntl__sdp__sdmem_valid_d1       ;

      sdmem_storage_desc_ptr  =  (mcntl__sdp__enable_sdmem_dnld_d1 )  ?   mcntl__sdp__sdmem_address_d1 :  // Host load of storage desc memory
                                                                          local_storage_desc_ptr       ;

      sdmem_write_data        =  {mcntl__sdp__sdmem_addr, mcntl__sdp__sdmem_consJump_ptr, mcntl__sdp__sdmem_order}  ;
    end

  wire   [`COMMON_STD_INTF_CNTL_RANGE               ]  sdmem_consJumpCntl  ;
  wire   [`MGR_INST_CONS_JUMP_FIELD_RANGE           ]  sdmem_consJump      ;


  reg    [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE       ]  cjmem_consJumpPtr      ;
  reg                                                             cjmem_write            ;
  reg    [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_AGGREGATE_MEM_RANGE ]  cjmem_write_data       ;

  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: storageDescConsJump_mem

        generic_1port_memory #(.GENERIC_MEM_DEPTH          (`MGR_LOCAL_STORAGE_DESC_CONSJUMP_MEMORY_DEPTH        ),
                               .GENERIC_MEM_REGISTERED_OUT (0                                                    ),
                               .GENERIC_MEM_DATA_WIDTH     (`MGR_LOCAL_STORAGE_DESC_CONSJUMP_AGGREGATE_MEM_WIDTH )
                        ) gmemory ( 

                        //---------------------------------------------------------------
                        // Initialize
                        //
                        `ifndef SYNTHESIS
                           .memFile ($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorConsJump_readmem.dat", sys__mgr__mgrId)),
                        `endif

                        //---------------------------------------------------------------
                        // Port
                        .portA_address       ( cjmem_consJumpPtr                   ),
                        .portA_write_data    ( cjmem_write_data                    ),
                        .portA_read_data     ( {sdmem_consJumpCntl, sdmem_consJump}),
                        .portA_enable        ( 1'b1                                ), 
                        .portA_write         ( cjmem_write                         ),
                        
                        //---------------------------------------------------------------
                        // General
                        .reset_poweron       ( reset_poweron                       ),
                        .clk                 ( clk                                 )
                        ) ;


      end
  endgenerate

  always @(*)
    begin
      cjmem_write             =   mcntl__sdp__enable_cjmem_dnld_d1 &  mcntl__sdp__cjmem_valid_d1       ;

      cjmem_consJumpPtr       =  (mcntl__sdp__enable_cjmem_dnld_d1 )  ?   mcntl__sdp__cjmem_address_d1 :  // Host load of consJump memory
                                                                          consJumpPtr                  ;

      cjmem_write_data        =  {mcntl__sdp__cjmem_consJump_cntl_d1,  mcntl__sdp__cjmem_consJump_val_d1 } ;
    end


  assign  storage_desc_consJumpPtr = sdmem_consJumpPtr      ;


  // wires to make FSM decodes look cleaner
  assign consJumpMemory_cntl      = sdmem_consJumpCntl  ;  // cons/jump delineator for fsm
  assign consJumpMemory_value     = sdmem_consJump      ;  // cons/jump delineator for fsm
  assign storage_desc_address     = sdmem_Address       ;  // main memory address in storage descriptor
  assign storage_desc_accessOrder = sdmem_AccessOrder   ;  // how to increment Chan/Bank/Page/Word
  assign consJumpMemory_som       =  (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM    ) ; 
  assign consJumpMemory_som_eom   =  (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM_EOM) ;
  assign consJumpMemory_eom       =  (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (sdmem_consJumpCntl == `COMMON_STD_INTF_CNTL_EOM);

/*
   reg                                                        mcntl__sdp__enable_sdmem_dnld_d1   ;

   reg                                                        mcntl__sdp__sdmem_valid_d1         ;
   reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__sdp__sdmem_cntl_d1          ;
   reg                                                        sdp__mcntl__sdmem_ready_e1         ;

   reg   [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE          ]    mcntl__sdp__sdmem_address_d1       ;
   // Storage descriptor memory contents
   reg   [`MGR_DRAM_ADDRESS_RANGE                        ]    mcntl__sdp__sdmem_addr_d1          ;
   reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]    mcntl__sdp__sdmem_order_d1         ;
   reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__sdp__sdmem_consJump_ptr_d1  ;
            

  reg                                                        mcntl__sdp__enable_cjmem_dnld_d1   ;

  reg                                                        mcntl__sdp__cjmem_valid_d1         ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__sdp__cjmem_cntl_d1          ;
  reg                                                        sdp__mcntl__cjmem_ready_e1         ;

  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__sdp__cjmem_address_d1       ;
  // Storage descriptor memory contents
  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__sdp__cjmem_consJump_cntl_d1 ;
  reg   [`MGR_INST_CONS_JUMP_FIELD_RANGE                ]    mcntl__sdp__cjmem_consJump_val_d1  ;
            
*/

  //----------------------------------------------------------------------------------------------------
  // end memories
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
 
  //----------------------------------------------------------------------------------------------------
  //
  //
  //
endmodule
