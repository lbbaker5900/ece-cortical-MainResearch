/*********************************************************************************************

    File name   : main_mem_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

    Description : Take commands fro mrc_cntl and access dram
                  
      Note: leveraged from https://github.ncsu.edu/ECE-Memory-Controller-IS/ece-diram4-memory-controller/blob/master/HDL/run_s/scheduler

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "main_mem_cntl.vh"
`include "dram_access_timer.vh"

module main_mem_cntl (

            //-------------------------------
            // Main Memory Controller interface
            //
            input   wire                                          mrc__mmc__valid   [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE     ]      mrc__mmc__cntl    [`MGR_NUM_OF_STREAMS ]     ,
            output  reg                                           mmc__mrc__ready   [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mrc__mmc__channel [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [`MGR_DRAM_BANK_ADDRESS_RANGE    ]      mrc__mmc__bank    [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mrc__mmc__page    [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [`MGR_DRAM_WORD_ADDRESS_RANGE    ]      mrc__mmc__word    [`MGR_NUM_OF_STREAMS ]     ,
                                                                                    
            // MMC provides data from each DRAM channel
            // - response must be in order of request
            output  reg   [`MGR_NUM_OF_STREAMS_RANGE            ]                                 mmc__mrc__valid   [`MGR_DRAM_NUM_CHANNELS ]                        ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE          ]                                 mmc__mrc__cntl    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ] ,
            input   wire  [`MGR_NUM_OF_STREAMS_RANGE            ]                                 mrc__mmc__ready   [`MGR_DRAM_NUM_CHANNELS ]                        ,
            output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   mmc__mrc__data    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ] ,

            //--------------------------------------------------------------------------------
            // DFI Interface
            // - provide per channel signals
            // - DFI will handle SDR->DDR conversion
            input   wire                                                                          dfi__mmc__init_done                             ,
            input   wire                                                                          dfi__mmc__valid      [`MGR_DRAM_NUM_CHANNELS ]  ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE          ]                                 dfi__mmc__cntl       [`MGR_DRAM_NUM_CHANNELS ]  ,
            input   wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   dfi__mmc__data       [`MGR_DRAM_NUM_CHANNELS ]  ,

            output  reg                                                                           mmc__dfi__cs         [`MGR_DRAM_NUM_CHANNELS ]  ,
            output  reg                                                                           mmc__dfi__cmd0       [`MGR_DRAM_NUM_CHANNELS ]  ,
            output  reg                                                                           mmc__dfi__cmd1       [`MGR_DRAM_NUM_CHANNELS ]  ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE         ]                                 mmc__dfi__bank       [`MGR_DRAM_NUM_CHANNELS ]  ,
            output  reg   [`MGR_DRAM_PHY_ADDRESS_RANGE          ]                                 mmc__dfi__addr       [`MGR_DRAM_NUM_CHANNELS ]  ,
            output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   mmc__dfi__data       [`MGR_DRAM_NUM_CHANNELS ]  ,

  
            //-------------------------------
            // General
            //
            input   wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input   wire                           clk             ,
            input   wire                           reset_poweron  
 
              );   

  
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Register inputs and outputs

  //--------------------------------------------------
  // Memory request input
  reg                                           mrc__mmc__valid_d1   [`MGR_NUM_OF_STREAMS ]   ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE     ]      mrc__mmc__cntl_d1    [`MGR_NUM_OF_STREAMS ]   ;
  reg                                           mmc__mrc__ready_e1   [`MGR_NUM_OF_STREAMS ]   ;
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mrc__mmc__channel_d1 [`MGR_NUM_OF_STREAMS ]   ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]      mrc__mmc__bank_d1    [`MGR_NUM_OF_STREAMS ]   ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mrc__mmc__page_d1    [`MGR_NUM_OF_STREAMS ]   ;
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE    ]      mrc__mmc__word_d1    [`MGR_NUM_OF_STREAMS ]   ;
       
  always @(posedge clk) 
    begin
      for (int strm=0; strm<`MGR_NUM_OF_STREAMS ; strm++)
        begin: mem_request
          mrc__mmc__valid_d1   [strm ]  <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__valid    [strm ] ; 
          mrc__mmc__cntl_d1    [strm ]  <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__cntl     [strm ] ; 
          mmc__mrc__ready      [strm ]  <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__ready_e1 [strm ] ; 
          mrc__mmc__channel_d1 [strm ]  <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__channel  [strm ] ; 
          mrc__mmc__bank_d1    [strm ]  <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__bank     [strm ] ; 
          mrc__mmc__page_d1    [strm ]  <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__page     [strm ] ; 
          mrc__mmc__word_d1    [strm ]  <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__word     [strm ] ; 
        end
    end

  reg  [`MGR_NUM_OF_STREAMS_RANGE            ]                                   mmc__mrc__valid_e1   [`MGR_DRAM_NUM_CHANNELS ]                        ;
  reg  [`COMMON_STD_INTF_CNTL_RANGE          ]                                   mmc__mrc__cntl_e1    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ] ;
  reg  [`MGR_NUM_OF_STREAMS_RANGE            ]                                   mrc__mmc__ready_d1   [`MGR_DRAM_NUM_CHANNELS ]                        ;
  reg  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]    mmc__mrc__data_e1    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ] ;

  genvar chan, strm, word, bank ;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: mem_response
        for (strm=0; strm<`MGR_NUM_OF_STREAMS ; strm++)
          begin: mem_response
            always @(posedge clk)
              begin
                mmc__mrc__valid    [chan] [strm ] <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__valid_e1 [chan] [strm ] ; 
                mmc__mrc__cntl     [chan] [strm ] <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__cntl_e1  [chan] [strm ] ; 
                mrc__mmc__ready_d1 [chan] [strm ] <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__ready    [chan] [strm ] ; 
              end
            for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
              begin: mem_response
                always @(posedge clk)
                  begin
                    mmc__mrc__data     [chan] [strm] [word] <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__data_e1  [chan] [strm] [word] ; 
                  end
              end
          end
      end
  endgenerate

  // FIXME
  generate
      for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
        begin: fixme1
          for (strm=0; strm<`MGR_NUM_OF_STREAMS ; strm++)
            begin: fixme2
              always @(posedge clk)
                begin
                  mmc__mrc__valid_e1 [chan][strm] <= 0;
                end
            end
        end
  endgenerate

  // - DFI will handle SDR->DDR conversion
  reg                                                                          dfi__mmc__init_done_d1                            ;
  reg                                                                          dfi__mmc__valid_d1      [`MGR_DRAM_NUM_CHANNELS ] ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE        ]                                  dfi__mmc__cntl_d1       [`MGR_DRAM_NUM_CHANNELS ] ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]    dfi__mmc__data_d1       [`MGR_DRAM_NUM_CHANNELS ] ;

  always @(posedge clk)
    begin
      dfi__mmc__init_done_d1  <=  dfi__mmc__init_done ;
    end

  always @(posedge clk)
    begin
      for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
        begin: from_dfi_valid
          dfi__mmc__valid_d1 [chan]  <=  dfi__mmc__valid [chan] ;
          dfi__mmc__cntl_d1  [chan]  <=  dfi__mmc__cntl  [chan] ;
        end
    end

  always @(posedge clk)
    begin
      for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
        begin: from_dfi_data
          for (int word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
            begin: from_dfi_data_word
              dfi__mmc__data_d1 [chan][word]  <=  dfi__mmc__data [chan][word] ;
            end
        end
    end

  reg                                                                          mmc__dfi__cs_e1     [`MGR_DRAM_NUM_CHANNELS ]  ;
  reg                                                                          mmc__dfi__cmd0_e1   [`MGR_DRAM_NUM_CHANNELS ]  ;
  reg                                                                          mmc__dfi__cmd1_e1   [`MGR_DRAM_NUM_CHANNELS ]  ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE       ]                                  mmc__dfi__bank_e1   [`MGR_DRAM_NUM_CHANNELS ]  ;
  reg   [`MGR_DRAM_PHY_ADDRESS_RANGE        ]                                  mmc__dfi__addr_e1   [`MGR_DRAM_NUM_CHANNELS ]  ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]    mmc__dfi__data_e1   [`MGR_DRAM_NUM_CHANNELS ]  ;

  always @(posedge clk)
    begin
      for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
        begin: to_dfi

          mmc__dfi__cs   [chan]            <=  mmc__dfi__cs_e1   [chan] ;
          mmc__dfi__cmd0 [chan]            <=  mmc__dfi__cmd0_e1 [chan] ;
          mmc__dfi__cmd1 [chan]            <=  mmc__dfi__cmd1_e1 [chan] ;
          mmc__dfi__bank [chan]            <=  mmc__dfi__bank_e1 [chan] ;
          mmc__dfi__addr [chan]            <=  mmc__dfi__addr_e1 [chan] ;

          for (int word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
            begin: to_dfi_data_word
              mmc__dfi__data [chan][word]  <=  mmc__dfi__data_e1 [chan][word] ;
            end
        end
    end

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Request input FIFO

  // Remember, cannot use a variable to index into a generate, so create a variable outside the generate, set that variable inside the generate and index the variable with a variable
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE        ]   requested_bank       [`MGR_NUM_OF_STREAMS] [`MGR_DRAM_NUM_CHANNELS] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]   requested_page       [`MGR_NUM_OF_STREAMS] [`MGR_DRAM_NUM_CHANNELS] ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE      ]   requested_line       [`MGR_NUM_OF_STREAMS] [`MGR_DRAM_NUM_CHANNELS] ;
  `endif
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   request_valid        [`MGR_NUM_OF_STREAMS]                          ;
  reg  [`MGR_NUM_OF_STREAMS_VECTOR          ]   request_pipe_read                          [`MGR_DRAM_NUM_CHANNELS] ;

  generate
    for (strm=0; strm<`MGR_NUM_OF_STREAMS ; strm=strm+1) 
      begin: request_fifo

        wire  clear        ;
        wire  almost_full  ;
        reg                                            write          ;
        wire                                           is_read  = 1'b1 ;  // FIXME
        wire                                           is_write = 1'b0 ;  // FIXME
        wire                                           pipe_valid     ;
        reg                                            pipe_read      ;

        wire  [ `COMMON_STD_INTF_CNTL_RANGE     ]      pipe_cntl     ;
        wire                                           pipe_is_read  ;
        wire                                           pipe_is_write ;
        wire  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      pipe_channel  ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      pipe_bank     ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      pipe_page     ;
        wire  [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      pipe_word     ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE
          wire  [ `MGR_DRAM_LINE_ADDRESS_RANGE  ]      pipe_line     ;
        `endif

        wire                                           pipe_peek_valid    ;
        wire  [ `COMMON_STD_INTF_CNTL_RANGE     ]      pipe_peek_cntl     ;
        wire                                           pipe_peek_is_read  ;
        wire                                           pipe_peek_is_write ;
        wire  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      pipe_peek_channel  ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      pipe_peek_bank     ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      pipe_peek_page     ;
        wire  [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      pipe_peek_word     ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE
          wire  [ `MGR_DRAM_LINE_ADDRESS_RANGE  ]      pipe_peek_line     ;
        `endif

        wire                                           pipe_peek_twoIn_valid    ;
        wire  [ `COMMON_STD_INTF_CNTL_RANGE     ]      pipe_peek_twoIn_cntl     ;
        wire                                           pipe_peek_twoIn_is_read  ;
        wire                                           pipe_peek_twoIn_is_write ;
        wire  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      pipe_peek_twoIn_channel  ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      pipe_peek_twoIn_bank     ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      pipe_peek_twoIn_page     ;
        wire  [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      pipe_peek_twoIn_word     ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE
          wire  [ `MGR_DRAM_LINE_ADDRESS_RANGE  ]      pipe_peek_twoIn_line     ;
        `endif


        generic_pipelined_w_peek_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_REQUEST_FIFO_DEPTH                 ),
                                        .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_REQUEST_FIFO_ALMOST_FULL_THRESHOLD ),
                                        .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ({mrc__mmc__cntl_d1 [strm], is_read, is_write, mrc__mmc__channel_d1 [strm], mrc__mmc__bank_d1 [strm], mrc__mmc__page_d1 [strm], mrc__mmc__word_d1 [strm]}),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid            ),
                                .pipe_data        ({pipe_cntl, pipe_is_read, pipe_is_write, pipe_channel, pipe_bank, pipe_page, pipe_word}),
                                .pipe_read        ( pipe_read             ),

                                .pipe_peek_valid       ( pipe_peek_valid       ),
                                .pipe_peek_data        ({pipe_peek_cntl, pipe_peek_is_read, pipe_peek_is_write, pipe_peek_channel, pipe_peek_bank, pipe_peek_page, pipe_peek_word}), 
                                .pipe_peek_twoIn_valid ( pipe_peek_twoIn_valid ),
                                .pipe_peek_twoIn_data  ({pipe_peek_twoIn_cntl, pipe_peek_twoIn_is_read, pipe_peek_twoIn_is_write, pipe_peek_twoIn_channel, pipe_peek_twoIn_bank, pipe_peek_twoIn_page, pipe_peek_twoIn_word}), 

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM); 
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM);

        `ifdef  MGR_DRAM_REQUEST_LT_PAGE
          assign pipe_line = pipe_word [`MGR_DRAM_LINE_IN_WORD_ADDRESS ] ;
        `endif

        always @(*)
          begin
            mmc__mrc__ready_e1 [strm] = ~almost_full              ;
            write                     = mrc__mmc__valid_d1 [strm] ;
          end

        assign clear = 1'b0 ;
 
        // Note: couldnt do this with net and assign, had to use procedural block and reg
        for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
          begin
            always @(*)
              begin
                request_valid  [strm] [chan]    = pipe_valid & (pipe_channel == chan) ;
                requested_bank [strm] [chan]    = pipe_bank                           ;
                requested_page [strm] [chan]    = pipe_page                           ;
                `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                      
                  requested_line [strm] [chan]  = pipe_line                           ;
                `endif
              end
          end

        always @(*)
          begin
            pipe_read = request_pipe_read [0] [strm] | request_pipe_read [1] [strm] ; // read if either channel stream is reading e.g. mutually exclusive
          end

      end
  endgenerate

 /* experiment with above assign issue 
  generate
    for (strm=0; strm<`MGR_NUM_OF_STREAMS; strm++)
      begin
        always @(*)
          begin
            request_valid  [strm] [request_fifo[strm].pipe_channel] = request_fifo[strm].pipe_valid ;
            requested_bank [strm] [request_fifo[strm].pipe_channel] = request_fifo[strm].pipe_bank  ;
            requested_page [strm] [request_fifo[strm].pipe_channel] = request_fifo[strm].pipe_page  ;
          end
      end
  endgenerate
        */

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Open Page registers
  //  - contains page open status
  //  - contains dram access timer for bank

  // Remember, cannot use a variable to index into a generate, so create a variable outside the generate, set that variable inside the generate and index the variable with a variable
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    channel_bank_open_page        [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`MGR_DRAM_NUM_BANKS_VECTOR_RANGE ]    channel_bank_a_page_is_open   [`MGR_DRAM_NUM_CHANNELS]                          ;
  //reg  [`MGR_DRAM_NUM_BANKS_VECTOR_RANGE ]    set_a_page_is_open           [`MGR_DRAM_NUM_CHANNELS]                          ;
  //reg  [`MGR_DRAM_NUM_BANKS_VECTOR_RANGE ]    clear_a_page_is_open         [`MGR_DRAM_NUM_CHANNELS]                          ;
  //reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    opening_page_id              [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
                                         
  // Set the page status. Either stream can set the page status but only one will be activve at a time
  // So genearte the page status by ORing the access_set_valid [chan][bank]
  reg  [`MGR_NUM_OF_STREAMS_RANGE        ]    access_set_valid              [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]                       ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE      ]    access_set_cmd                [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ] [`MGR_NUM_OF_STREAMS] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    access_set_page               [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ] [`MGR_NUM_OF_STREAMS] ;
  reg  [`MGR_NUM_OF_STREAMS_RANGE        ]    access_set_strm               [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]                       ;

  // The checker fsm will check page and cache commands separately but never to the same bank at the same time
  // So the checker will or the requests
  reg                                         page_cmd_grant_request_valid  [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`MGR_NUM_OF_STREAMS_RANGE        ]    page_cmd_grant_request_strm   [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE      ]    page_cmd_grant_request_cmd    [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    page_cmd_grant_request_page   [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;

  reg                                         cache_cmd_grant_request_valid [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`MGR_NUM_OF_STREAMS_RANGE        ]    cache_cmd_grant_request_strm  [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE      ]    cache_cmd_grant_request_cmd   [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    cache_cmd_grant_request_page  [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;

  reg                                         can_go                        [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg                                         can_go_checker_ready          [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg                                         adjacent_bank_request         [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;

  // FIXME :tie off adjacent bank request
  always @(posedge clk)  // remember, need an event
    begin
      for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
        begin: adjacent_bank_request_chan
          for (int bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
            begin: adj_bank
              adjacent_bank_request [chan][bank] = 1'b0 ;
            end
        end
    end

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: chan_info
        for (bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
          begin: bank_info
        
            reg                                     a_page_is_open       ;
            reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE ]    open_page_id         ;
        
            reg                                     chan_bank_set_valid         ;
            reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE  ]   chan_bank_set_cmd           ;
            reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE ]   chan_bank_set_page          ;

            reg                                     chan_bank_request_valid         ;
            reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE  ]   chan_bank_request_cmd           ;
            reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE ]   chan_bank_request_page          ;
            reg                                     chan_bank_adjacent_bank_request ;

            wire                                    chan_bank_can_go_valid          ;
            wire                                    chan_bank_can_go                ;
            wire                                    chan_bank_checker_ready         ;

            always @(posedge clk)
              begin
                a_page_is_open  <= ( reset_poweron                                                    )  ? 1'b0           :
                                   ((chan_bank_set_cmd == `DRAM_ACC_CMD_IS_PO ) && chan_bank_set_valid)  ? 1'b1           :
                                   ((chan_bank_set_cmd == `DRAM_ACC_CMD_IS_PC ) && chan_bank_set_valid)  ? 1'b0           :
                                                                                                           a_page_is_open ; 
        
                open_page_id    <= ( reset_poweron                                                    )  ? {`MGR_DRAM_PAGE_ADDRESS_WIDTH {1'b1 }} :
                                   ((chan_bank_set_cmd == `DRAM_ACC_CMD_IS_PO ) && chan_bank_set_valid)  ? chan_bank_set_page                     :
                                   ((chan_bank_set_cmd == `DRAM_ACC_CMD_IS_PC ) && chan_bank_set_valid)  ? {`MGR_DRAM_PAGE_ADDRESS_WIDTH {1'b1 }} :
                                                                                                           open_page_id                           ; 
              end

            //----------------------------------------------------------------------------------------------------
            //Bank Access timer
            // - provide command, timer grants permission to place command in final queue

            dram_access_timer dram_access_timer(

                //-------------------------------
                // Outputs
                .can_go                  ( chan_bank_can_go        ),
                .can_go_valid            ( chan_bank_can_go_valid  ),
                .ready                   ( chan_bank_checker_ready ),

                //-------------------------------
                // Inputs
                .request_valid           ( chan_bank_request_valid         ),
                .request_cmd             ( chan_bank_request_cmd           ),
                                                                
                .adjacent_bank_request   ( chan_bank_adjacent_bank_request ),
               
                //-------------------------------
                // General
                //
                .sys__mgr__mgrId         ( sys__mgr__mgrId         ),
                .clk                     ( clk                     ),
                .reset_poweron           ( reset_poweron           ) 

                );   

            always @(*)
              begin
                // The checker fsm performs the grant request as it pulls commands from the sequence fifo, but it wont simultaneously to the same bank
                chan_bank_request_valid         =  page_cmd_grant_request_valid  [chan] [bank] | cache_cmd_grant_request_valid [chan] [bank] ;

                chan_bank_request_cmd           = (page_cmd_grant_request_valid  [chan] [bank]) ? page_cmd_grant_request_cmd   [chan] [bank] :
                                                                                                  cache_cmd_grant_request_cmd  [chan] [bank] ;

                chan_bank_request_page           = (page_cmd_grant_request_valid [chan] [bank]) ? page_cmd_grant_request_page  [chan] [bank] :
                                                                                                  cache_cmd_grant_request_page [chan] [bank] ;

                chan_bank_adjacent_bank_request = adjacent_bank_request [chan] [bank] ;
              end

            // The CMD_SEQ fsm sets the page status
            always @(*)
              begin
                chan_bank_set_valid         = |access_set_valid  [chan] [bank] ; // either stream

                chan_bank_set_cmd           = access_set_valid  [chan] [bank] [0] ? access_set_cmd  [chan] [bank] [0] :
                                                                                    access_set_cmd  [chan] [bank] [1] ;             

                chan_bank_set_page          = access_set_valid  [chan] [bank] [0] ? access_set_page [chan] [bank] [0] :
                                                                                    access_set_page [chan] [bank] [1] ;             
              end

            // use because we cannot index the generate with a variable
            always @(*)
              begin
                can_go                      [chan] [bank] = chan_bank_can_go & chan_bank_can_go_valid ;
                can_go_checker_ready        [chan] [bank] = chan_bank_checker_ready                   ;
                channel_bank_a_page_is_open [chan] [bank] = a_page_is_open   ; 
                channel_bank_open_page      [chan] [bank] = open_page_id     ; 
              end
        

          end
      end
  endgenerate


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // DRAM Command generation FSM
  //  - take memory requests and determine how many commands associated with each request
  //  - If read with nothing open, generate PO-CR
  //  - If read with mismatched open page, generate PC-PO-CR
  //  - read to open page, generate CR
  //  etc.
  //
  //  - generate command then present to target banks access timer before placing command in final queue
  // 
  // Remember, cannot use a variable to index into a generate, so create a variable outside the generate, set that variable inside the generate and index the variable with a variable
  //
  // The select FSM will use these signals to start a selection
  reg  [`MGR_NUM_OF_STREAMS_VECTOR     ]    strm_access_request   [`MGR_DRAM_NUM_CHANNELS]                        ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE    ]    strm_access_cmd       [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  reg  [`DRAM_ACC_SEQ_TYPE_RANGE       ]    strm_access_sequence  [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE   ]    strm_access_bank      [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE   ]    strm_access_page      [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                              
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE ]    strm_access_line       [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  `endif

  // The select FSM will use this signal to complete a selection
  reg  [`MGR_NUM_OF_STREAMS_VECTOR     ]    strm_access_done      [`MGR_DRAM_NUM_CHANNELS]                        ;
  
  // The select FSM will use these registered values to make decisions whilst a request is being processed 
  reg  [`MGR_NUM_OF_STREAMS_RANGE      ]    strm_is_read_latched  [`MGR_DRAM_NUM_CHANNELS]                        ;
  reg  [`MGR_NUM_OF_STREAMS_RANGE      ]    strm_is_write_latched [`MGR_DRAM_NUM_CHANNELS]                        ;

  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE   ]    strm_bank_latched     [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE   ]    strm_page_latched     [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                              
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE ]    strm_line_latched     [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  `endif                                                       
                                                               
  reg  [`MGR_NUM_OF_STREAMS_VECTOR     ]    strm_enable           [`MGR_DRAM_NUM_CHANNELS]                        ;  // channel has granted stream access. Access granted to both streams if accessing different banks
  reg  [`MMC_CNTL_CMD_GEN_TAG_RANGE    ]    strm_tag              [`MGR_DRAM_NUM_CHANNELS]                        ;  // this tag goes with page and cache commands generate by a strm fsm
  reg  [`DRAM_ACC_SEQ_TYPE_RANGE       ]    strm_seq_type         [`MGR_DRAM_NUM_CHANNELS]                        ;  
     
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: chan_cmd_gen_fsm
        for (strm=0; strm<`MGR_NUM_OF_STREAMS ; strm=strm+1) 
          begin: strm_fsm

            reg [`MMC_CNTL_CMD_GEN_STATE_RANGE ] mmc_cntl_cmd_gen_state      ; // state flop
            reg [`MMC_CNTL_CMD_GEN_STATE_RANGE ] mmc_cntl_cmd_gen_state_next ;
            
            // State register 
            always @(posedge clk)
              begin
                mmc_cntl_cmd_gen_state <= ( reset_poweron ) ? `MMC_CNTL_CMD_GEN_WAIT        :
                                                               mmc_cntl_cmd_gen_state_next  ;
              end
            
            //--------------------------------------------------
            // Assumptions:
            //  - 

            // local bank commands, outside this genblk the commands are merged and sent to bank info genblk
            //wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE ]   opening_page_id      ;
            //wire                                    set_a_page_is_open   ;
            //wire                                    clear_a_page_is_open ;

            // As this fsm determines the command, it requests access to the final queue via the access timer in the
            // bank info genblk
            wire                                       strm_request          ;  // command to access timer
            wire                                       strm_request_is_read  ;
            wire                                       strm_request_is_write ;
            wire                                       strm_request_done     ;  // command to access timer
            wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   strm_request_cmd      ;
            wire  [`DRAM_ACC_SEQ_TYPE_RANGE        ]   strm_request_sequence ;
            wire  [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   strm_request_bank     ;
            wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   strm_request_page     ;
            wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]   strm_request_chan     ;
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                 
              wire  [`MGR_DRAM_LINE_ADDRESS_RANGE  ]   strm_request_line     ;
            `endif                                                           
            //                                                               
            reg   [`DRAM_ACC_CMD_SEQ_RANGE         ]   strm_cmd_sequence        ;
            reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   strm_cmd_sequence_codes  [`DRAM_ACC_CMD_SEQ_MAX_LENGTH ] ;  // contains the actual sequence e.g. {PC, PO, CR, NOP}
            reg   [`DRAM_ACC_CMD_SEQ_COUNT_RANGE   ]   strm_cmd_index           ;  // index into sequence vector
            reg   [`MMC_CNTL_CMD_GEN_STATE_RANGE   ]   strm_cmd_code_state_next ;  // let the code define the enxt state
            reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   strm_cmd_code_write_next ;  // latch the next state code to write to the sequence fifo
            
            reg                                        strm_page_cmd_write      ;  // write the command to the sequence fifo
            reg                                        strm_cache_cmd_write     ;  // write the command to the sequence fifo


            always @(*)
              begin
                case (mmc_cntl_cmd_gen_state)
                  
                  `MMC_CNTL_CMD_GEN_WAIT: 
                    // The channel stream select logic will not enable this fsm unless this streams request fifo is requesting this channel
                    mmc_cntl_cmd_gen_state_next =  ( strm_enable  [chan][strm] ) ?   `MMC_CNTL_CMD_GEN_DECODE_SEQUENCE  :
                                                                                     `MMC_CNTL_CMD_GEN_WAIT             ;
       
                  `MMC_CNTL_CMD_GEN_DECODE_SEQUENCE: 
                    mmc_cntl_cmd_gen_state_next =  strm_cmd_code_state_next ;
       
                  `MMC_CNTL_CMD_GEN_PC: 
                    mmc_cntl_cmd_gen_state_next =  strm_cmd_code_state_next ;
       
                  `MMC_CNTL_CMD_GEN_PO: 
                    mmc_cntl_cmd_gen_state_next =  strm_cmd_code_state_next ;
/*       
                  `MMC_CNTL_CMD_GEN_POCR: 
                    mmc_cntl_cmd_gen_state_next =  strm_cmd_code_state_next ;
       
                  `MMC_CNTL_CMD_GEN_POCW: 
                    mmc_cntl_cmd_gen_state_next =  strm_cmd_code_state_next ;
*/
       
                  `MMC_CNTL_CMD_GEN_CR: 
                    mmc_cntl_cmd_gen_state_next =  strm_cmd_code_state_next ;
       
                  `MMC_CNTL_CMD_GEN_CW: 
                    mmc_cntl_cmd_gen_state_next =  strm_cmd_code_state_next ;
       
                  `MMC_CNTL_CMD_GEN_PR: 
                    mmc_cntl_cmd_gen_state_next =  strm_cmd_code_state_next ;
       
       
                  `MMC_CNTL_CMD_GEN_ERR: 
                    mmc_cntl_cmd_gen_state_next =  `MMC_CNTL_CMD_GEN_ERR       ;
       
                  default:
                    mmc_cntl_cmd_gen_state_next = `MMC_CNTL_CMD_GEN_WAIT ;
              
                endcase // case (mmc_cntl_cmd_gen_state)
              end // always @ (*)

            // State transition dictated by command sequence
            always @(posedge clk)
              begin
                strm_cmd_index  <= (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT           ) ? 'd0                : 
                                                                                                   strm_cmd_index +1  ;
              end
            always @(*)
              begin
                case (strm_cmd_sequence_codes [strm_cmd_index]) // synopsys parallel_case
                  `DRAM_ACC_CMD_IS_PO :
                    strm_cmd_code_state_next = `MMC_CNTL_CMD_GEN_PO  ;
                  `DRAM_ACC_CMD_IS_PC :
                    strm_cmd_code_state_next = `MMC_CNTL_CMD_GEN_PC ;
                  `DRAM_ACC_CMD_IS_CR :
                    strm_cmd_code_state_next = `MMC_CNTL_CMD_GEN_CR  ;
                  `DRAM_ACC_CMD_IS_CW :
                    strm_cmd_code_state_next = `MMC_CNTL_CMD_GEN_CW ;
                  `DRAM_ACC_CMD_IS_PR :
                    strm_cmd_code_state_next = `MMC_CNTL_CMD_GEN_PR ;
                  `DRAM_ACC_CMD_IS_NOP:
                    strm_cmd_code_state_next = `MMC_CNTL_CMD_GEN_WAIT ;
                endcase
              end
            // latch the write code in preparation for being in the next state
            always @(posedge clk)
              begin
                strm_cmd_code_write_next = strm_cmd_sequence_codes [strm_cmd_index] ;
              end
            //--------------------------------------------------
            // Control
            //  - 

          for (bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
            begin: set_bank_info
              always @(posedge clk)
                begin
                 if (bank == strm_bank_latched[chan][strm])
                   begin
                     access_set_valid  [chan] [bank] [strm] <= (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PO) | 
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PC) ;
                     access_set_cmd    [chan] [bank] [strm] <= (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PO) ?  `DRAM_ACC_CMD_IS_PO  :
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PC) ?  `DRAM_ACC_CMD_IS_PO  :
                                                                                                                   `DRAM_ACC_CMD_IS_NOP ;
                     access_set_page   [chan] [bank] [strm] <= strm_page_latched[chan][strm] ;
                   end
                 else
                   begin
                     access_set_valid  [chan] [bank] [strm] <= 1'b0 ;
                     access_set_cmd    [chan] [bank] [strm] <= 'd0  ;
                     access_set_page   [chan] [bank] [strm] <= 'd0  ;
                   end
                end
            end
         

            // Write to the sequence fifo
            always @(*)
              begin
                strm_page_cmd_write  = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PC) |
                                       (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PO) |
                                       (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PR) ;
                                                                                                    
                strm_cache_cmd_write = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_CR) |
                                       (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_CW) ;
                                                                                                    
              end

            always @(posedge clk)
              begin
                casex ({(mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT), channel_bank_a_page_is_open[chan][strm_request_bank], (channel_bank_open_page [chan][strm_request_bank] == strm_request_page), strm_request_is_read, strm_request_is_write})  // synopsys parallel_case

                  5'b10x10 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_POCR   ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_PO         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_CR         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b10x01 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_POCW   ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_PO         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_CW         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11110 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_CR     ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_CR         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11101 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_CW     ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_CW         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11010 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_PCPOCR ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_PC         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_PO         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_CR         ;
                      strm_cmd_sequence_codes[4]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11001 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_PCPOCW ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_PC         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_PO         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_CW         ;
                      strm_cmd_sequence_codes[4]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  // if we are not reading or writing, then assume its a page refresh
                  5'b10x00 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_PR     ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_PR         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11x00 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_PCPR   ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_PC         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_PR         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  default :
                    begin
                      strm_cmd_sequence           <=  strm_cmd_sequence              ;
                      for (int cmd=0; cmd < `DRAM_ACC_CMD_SEQ_MAX_LENGTH; cmd++)
                        begin
                          strm_cmd_sequence_codes[cmd]  <=  strm_cmd_sequence_codes[cmd] ;
                        end
                    end

                endcase
              end


            reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   strm_cmd_code_next       ;

            // Whilst in the wait state, keep latching the request fifo output. Once this stream is selected, we will immediately move from the WAIT state
            always @(posedge clk)
              begin
                strm_is_read_latched  [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_is_read  : strm_is_read_latched  [chan] [strm]  ;
                strm_is_write_latched [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_is_write : strm_is_write_latched [chan] [strm]  ;

                strm_bank_latched     [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_bank     : strm_bank_latched     [chan] [strm]  ;
                strm_page_latched     [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_page     : strm_page_latched     [chan] [strm]  ;
                `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                                                                                        
                  strm_line_latched   [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_line     : strm_line_latched     [chan] [strm]  ;
                `endif
              end

            always @(*)
              begin
                request_pipe_read [chan][strm]  = strm_enable [chan][strm] ;  // strm_enable is a pulse
                                                                                                    
              end

            //assign  opening_page_id       = request_fifo[strm].pipe_page & {`MGR_DRAM_PAGE_ADDRESS_WIDTH { mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PO }} ;
            //assign  set_a_page_is_open    = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PO  ) ;
            //assign  clear_a_page_is_open  = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PC ) ;

            // The stream request valid is sent to the channel select logic which in turn will enable this fsm
            //  - stream is valid if waiting and the streams request fifo wants this channel or
            //  - the stream has not yet been granted cache access
            assign  strm_request               = ((mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT ) & request_fifo[strm].pipe_valid && (strm_request_chan == chan)) ;
                                               
            assign  strm_request_done          = (strm_cmd_sequence_codes [strm_cmd_index] == `DRAM_ACC_CMD_IS_NOP ) ;  // when we hit NOP, we are done
                                               
            assign  strm_request_cmd           = strm_cmd_sequence_codes [strm_cmd_index] ;
            assign  strm_request_sequence      = strm_cmd_sequence                        ;
                                               
            assign  strm_request_is_read       = request_fifo[strm].pipe_is_read  ;
            assign  strm_request_is_write      = request_fifo[strm].pipe_is_write ;
                                               
            assign  strm_request_chan          = request_fifo[strm].pipe_channel  ;
            assign  strm_request_bank          = request_fifo[strm].pipe_bank     ;
            assign  strm_request_page          = request_fifo[strm].pipe_page     ;
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
              assign  strm_request_line        = request_fifo[strm].pipe_line     ;
            `endif

            always @(*)
              begin
                strm_access_request  [chan] [strm] = strm_request              ;
                strm_access_done     [chan] [strm] = strm_request_done         ;
                strm_access_cmd      [chan] [strm] = strm_request_cmd          ;
                strm_access_sequence [chan] [strm] = strm_request_sequence     ;
                strm_access_bank     [chan] [strm] = strm_request_bank         ;
                strm_access_page     [chan] [strm] = strm_request_page         ;
                `ifdef  MGR_DRAM_REQUEST_LT_PAGE                               
                  strm_access_line   [chan] [strm] = strm_request_line         ;
                `endif

              end
          end
      end
  endgenerate

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Channel selects stream
  //  - select the stream based on request_valid
  //  - steer the selected command to the bank info access tiner
  //  - steer can_go to stream fsm
      

  // Select and steer the access timer request
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: channel_strm_select_fsm

        reg  [`MMC_CNTL_STRM_SEL_STATE_RANGE ]  mmc_cntl_strm_sel_state      ; // state flop
        reg  [`MMC_CNTL_STRM_SEL_STATE_RANGE ]  mmc_cntl_strm_sel_state_next ;
        
        // State register 
        always @(posedge clk)
          begin
            mmc_cntl_strm_sel_state <= ( reset_poweron ) ? `MMC_CNTL_STRM_SEL_WAIT        :
                                                            mmc_cntl_strm_sel_state_next  ;
          end
        
        //--------------------------------------------------
        // Assumptions:
        //  - 

        always @(*)
          begin
            case (mmc_cntl_strm_sel_state)
              
              // Wait for data from all the sources before transferring to NoC
              //  - we select stream 0  first if streams request together
              //  - maybe add wait state that has knowledge of last stream processed e.g. WAIT_STRM0_LAST -> transiton to STRM10
              //
              //  FIXME: Should we consider both streams accessing the same bank/page/line ??

              `MMC_CNTL_STRM_SEL_WAIT: 
                // let both channel streams continue if they are accessing different banks
                mmc_cntl_strm_sel_state_next =  ( strm_access_request [chan][0]                                                                                                ) ?  `MMC_CNTL_STRM_SEL_STRM0  :
                                                ( strm_access_request [chan][1]                                                                                                ) ?  `MMC_CNTL_STRM_SEL_STRM1  :
                                                                                                                                                                                    `MMC_CNTL_STRM_SEL_WAIT   ;
      
              `MMC_CNTL_STRM_SEL_STRM0: 
                mmc_cntl_strm_sel_state_next =  ( strm_access_done  [chan][0] &&  strm_access_request [chan][1]                                                 ) ?  `MMC_CNTL_STRM_SEL_STRM1  :
                                                ( strm_access_done  [chan][0]                                                                                   ) ?  `MMC_CNTL_STRM_SEL_WAIT   :
                                                                                                                                                                     `MMC_CNTL_STRM_SEL_STRM0  ;
                                                                                                                                            
              `MMC_CNTL_STRM_SEL_STRM1:                                                                                                     
                mmc_cntl_strm_sel_state_next =  ( strm_access_done  [chan][1] && strm_access_request [chan][0]                                                 ) ?  `MMC_CNTL_STRM_SEL_STRM0  :
                                                ( strm_access_done  [chan][1]                                                                                  ) ?  `MMC_CNTL_STRM_SEL_WAIT   :
                                                                                                                                                                    `MMC_CNTL_STRM_SEL_STRM1  ;
                                                                                                                                              
                                                                                                                                              
              // If streams are accessing different banks in the same channel, maintain order in which streams gain access to the channel using the state
              //  - STRM01 - stream 0 is first
              //  - STRM10 - stream 1 is first
              /*
              `MMC_CNTL_STRM_SEL_STRM01:                                                                                                      
                mmc_cntl_strm_sel_state_next =  ( strm_access_done  [chan][0] &&  strm_access_done  [chan][1]) ?  `MMC_CNTL_STRM_SEL_SEND1_NEXT   :  // we will send stream0's command then stream1's next
                                                (~strm_access_done  [chan][0] &&  strm_access_done  [chan][1]) ?  `MMC_CNTL_STRM_SEL_STRM0        :  // strm0 was next but strm 1 is done, so let it pass
                                                ( strm_access_done  [chan][0] && ~strm_access_done  [chan][1]) ?  `MMC_CNTL_STRM_SEL_STRM1        : 
                                                                                                                  `MMC_CNTL_STRM_SEL_STRM01       ;
      
              `MMC_CNTL_STRM_SEL_STRM10:                                                                                                    
                mmc_cntl_strm_sel_state_next =  ( strm_access_done  [chan][0] &&  strm_access_done  [chan][1]) ?  `MMC_CNTL_STRM_SEL_SEND0_NEXT   :  // we will send stream1's command then stream0's next
                                                (~strm_access_done  [chan][0] &&  strm_access_done  [chan][1]) ?  `MMC_CNTL_STRM_SEL_STRM0        :
                                                ( strm_access_done  [chan][0] && ~strm_access_done  [chan][1]) ?  `MMC_CNTL_STRM_SEL_STRM1        :
                                                                                                                  `MMC_CNTL_STRM_SEL_STRM10       ;
 
      
              `MMC_CNTL_STRM_SEL_SEND0_NEXT: 
                mmc_cntl_strm_sel_state_next =  `MMC_CNTL_STRM_SEL_WAIT       ;
      
              `MMC_CNTL_STRM_SEL_SEND1_NEXT: 
                mmc_cntl_strm_sel_state_next =  `MMC_CNTL_STRM_SEL_WAIT       ;
              */
      
              `MMC_CNTL_STRM_SEL_ERR: 
                mmc_cntl_strm_sel_state_next =  `MMC_CNTL_STRM_SEL_ERR       ;
      
              default:
                mmc_cntl_strm_sel_state_next = `MMC_CNTL_STRM_SEL_WAIT ;
          
            endcase // case (mmc_cntl_strm_sel_state)
          end // always @ (*)


        //--------------------------------------------------
        // Control
        //  - 

        for (strm=0; strm<`MGR_NUM_OF_STREAMS ; strm=strm+1) 
          begin: strm_ena
            always @(posedge clk)
              begin
                // Stream enable is a pulse that initiates command sequence generation and reads the request fifo
                strm_enable  [chan][strm] <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_WAIT ) & ( (strm == 0) &  strm_access_request [chan][0]                                 )) |
                                             ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_WAIT ) & ( (strm == 1) & ~strm_access_request [chan][0] & strm_access_request [chan][1] )) |
                                             ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1) & ( (strm == 0) &  strm_access_done    [chan][1] & strm_access_request [chan][0] )) |
                                             ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0) & ( (strm == 1) &  strm_access_done    [chan][0] & strm_access_request [chan][1] ))   ;
              end
          end

        always @(posedge clk)
          begin
            // Stream enable is a pulse that initiates command sequence generation and reads the request fifo
            strm_tag   [chan]  =  ( reset_poweron                                  ) ? 'd0                :
                                  ( |strm_enable [chan][0] | |strm_enable[chan][1] ) ? strm_tag [chan] +1 :
                                                                                       strm_tag [chan]    ;
          end

        // Write the commands into the sequence fifo
        //  - only once chan/strm is selected at a time

        always @(*)
          begin

            cmd_seq_page_fifo  [chan].write      = chan_cmd_gen_fsm [chan].strm_fsm[0].strm_page_cmd_write  | chan_cmd_gen_fsm [chan].strm_fsm[1].strm_page_cmd_write  ;
            cmd_seq_cache_fifo [chan].write      = chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cache_cmd_write | chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cache_cmd_write ;

            // page fifo
            case ({chan_cmd_gen_fsm [chan].strm_fsm[0].strm_page_cmd_write, chan_cmd_gen_fsm [chan].strm_fsm[1].strm_page_cmd_write})  // synopsys parallel_case
              2'b10 :
                begin
                  cmd_seq_page_fifo  [chan].write_cmd       = chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cmd_code_write_next ;
                  cmd_seq_page_fifo  [chan].write_bank      = strm_bank_latched [chan][0] ;
                  cmd_seq_page_fifo  [chan].write_page      = strm_page_latched [chan][0] ;
                  cmd_seq_page_fifo  [chan].write_tag       = strm_tag [chan] ;
                  cmd_seq_page_fifo  [chan].write_seq_type  = strm_access_sequence [chan][0] ;
                  cmd_seq_page_fifo  [chan].write_strm      = (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1) ;
                end                                         
              2'b01 :                                       
                begin                                       
                  cmd_seq_page_fifo  [chan].write_cmd       = chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cmd_code_write_next ;
                  cmd_seq_page_fifo  [chan].write_bank      = strm_bank_latched [chan][1] ;
                  cmd_seq_page_fifo  [chan].write_page      = strm_page_latched [chan][1] ;
                  cmd_seq_page_fifo  [chan].write_tag       = strm_tag [chan] ;
                  cmd_seq_page_fifo  [chan].write_seq_type  = strm_access_sequence [chan][1] ;
                  cmd_seq_page_fifo  [chan].write_strm      = (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1) ;
                end                                         
              default:                                      
                begin                                       
                  cmd_seq_page_fifo  [chan].write_cmd       = 1'b0 ;
                  cmd_seq_page_fifo  [chan].write_bank      = 'd0 ;
                  cmd_seq_page_fifo  [chan].write_page      = 'd0 ;
                  cmd_seq_page_fifo  [chan].write_tag       = strm_tag [chan] ;
                  cmd_seq_page_fifo  [chan].write_seq_type  = `DRAM_ACC_CMD_SEQ_IS_NOP  ;
                  cmd_seq_page_fifo  [chan].write_strm      = (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1) ;
                end
            endcase

            // Cache fifo
            case ({chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cache_cmd_write, chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cache_cmd_write})  // synopsys parallel_case
              2'b10 :
                begin
                  cmd_seq_cache_fifo  [chan].write_cmd       = chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cmd_code_write_next ;
                  //cmd_seq_cache_fifo  [chan].write_cmd       = chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cmd_sequence_codes [chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cmd_index ] ;
                  cmd_seq_cache_fifo  [chan].write_bank      = strm_bank_latched [chan][0] ;
                  cmd_seq_cache_fifo  [chan].write_page      = strm_page_latched [chan][0] ;
                  cmd_seq_cache_fifo  [chan].write_line      = strm_line_latched [chan][0] ;
                  cmd_seq_cache_fifo  [chan].write_tag       = strm_tag [chan] ;
                  cmd_seq_cache_fifo  [chan].write_seq_type  = strm_access_sequence [chan][0] ;
                  cmd_seq_cache_fifo  [chan].write_strm      = (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1) ;
                end                                          
              2'b01 :                                        
                begin                                        
                  cmd_seq_cache_fifo  [chan].write_cmd       = chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cmd_code_write_next ;
                  //cmd_seq_cache_fifo  [chan].write_cmd       = chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cmd_sequence_codes [chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cmd_index ] ;
                  cmd_seq_cache_fifo  [chan].write_bank      = strm_bank_latched [chan][1] ;
                  cmd_seq_cache_fifo  [chan].write_page      = strm_page_latched [chan][1] ;
                  cmd_seq_cache_fifo  [chan].write_line      = strm_line_latched [chan][1] ;
                  cmd_seq_cache_fifo  [chan].write_tag       = strm_tag [chan] ;
                  cmd_seq_cache_fifo  [chan].write_seq_type  = strm_access_sequence [chan][1] ;
                  cmd_seq_cache_fifo  [chan].write_strm      = (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1) ;
                end                                          
              default:                                       
                begin                                        
                  cmd_seq_cache_fifo  [chan].write_cmd       = 1'b0 ;
                  cmd_seq_cache_fifo  [chan].write_bank      = 'd0 ;
                  cmd_seq_cache_fifo  [chan].write_page      = 'd0 ;
                  cmd_seq_cache_fifo  [chan].write_line      = 'd0 ;
                  cmd_seq_cache_fifo  [chan].write_tag       = strm_tag [chan] ;
                  cmd_seq_cache_fifo  [chan].write_seq_type  = `DRAM_ACC_CMD_SEQ_IS_NOP  ;
                  cmd_seq_cache_fifo  [chan].write_strm      = (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1) ;
                end
            endcase

          end
      end
  endgenerate


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Command Sequence FIFOs
  // - for page and cache commands sequences, the outputs are checked for can_go before transferring to final queue
  //

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: cmd_seq_page_fifo

        wire                                                   clear                 ;
        wire                                                   almost_full           ;
        reg                                                    write                 ;
        wire  [`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_RANGE ]   write_data            ;
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                 ]   write_tag             ;
        reg   [`DRAM_ACC_SEQ_TYPE_RANGE                    ]   write_seq_type        ;
        reg   [`MGR_STREAM_ADDRESS_RANGE                   ]   write_strm            ;
        reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE                 ]   write_cmd             ;
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE                ]   write_bank            ;
        reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE                ]   write_page            ;

        wire                                                   pipe_valid            ;
        reg                                                    pipe_read             ;
                                                                                
        wire  [`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_RANGE ]   pipe_data             ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE                 ]   pipe_tag              ;
        wire  [`DRAM_ACC_SEQ_TYPE_RANGE                    ]   pipe_seq_type         ;
        wire  [`MGR_STREAM_ADDRESS_RANGE                   ]   pipe_strm             ;
        wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE                 ]   pipe_cmd              ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                ]   pipe_bank             ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE                ]   pipe_page             ;

        wire  [`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_RANGE ]   pipe_peek_data        ;
        wire                                                   pipe_peek_valid       ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE                 ]   pipe_peek_tag         ;
        wire  [`DRAM_ACC_SEQ_TYPE_RANGE                    ]   pipe_peek_seq_type    ;
        wire  [`MGR_STREAM_ADDRESS_RANGE                   ]   pipe_peek_strm        ;
        wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE                 ]   pipe_peek_cmd         ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                ]   pipe_peek_bank        ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE                ]   pipe_peek_page        ;
                                                          
        wire                                                   pipe_peek_twoIn_valid ;
        wire  [`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_RANGE ]   pipe_peek_twoIn_data  ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE                 ]   pipe_peek_twoIn_tag   ;
        wire  [`DRAM_ACC_SEQ_TYPE_RANGE                    ]   pipe_peek_twoIn_seq_type ;
        wire  [`MGR_STREAM_ADDRESS_RANGE                   ]   pipe_peek_twoIn_strm  ;
        wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE                 ]   pipe_peek_twoIn_cmd   ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                ]   pipe_peek_twoIn_bank  ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE                ]   pipe_peek_twoIn_page  ;


        generic_pipelined_w_peek_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH                 ),
                                        .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_PAGE_CMD_SEQ_FIFO_ALMOST_FULL_THRESHOLD ),
                                        .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_WIDTH       )
                        ) page_cmd_gpfifo (
                                 // Status
                                .almost_full           ( almost_full           ),
                                 // Write                                      
                                .write                 ( write                 ),
                                .write_data            ( write_data            ),
                                 // Read                                       
                                .pipe_valid            ( pipe_valid            ),
                                .pipe_data             ( pipe_data             ),
                                .pipe_read             ( pipe_read             ),

                                .pipe_peek_valid       ( pipe_peek_valid       ),
                                .pipe_peek_data        ( pipe_peek_data        ),
                                .pipe_peek_twoIn_valid ( pipe_peek_twoIn_valid ),
                                .pipe_peek_twoIn_data  ( pipe_peek_twoIn_data  ),

                                // General
                                .clear                 ( clear                 ),
                                .reset_poweron         ( reset_poweron         ),
                                .clk                   ( clk                   )
                                );

          assign write_data  = {write_strm, write_tag, write_seq_type, write_cmd, write_bank, write_page} ;

          assign {pipe_strm,            pipe_tag,            pipe_seq_type,            pipe_cmd,            pipe_bank,            pipe_page           } = pipe_data            ;
          assign {pipe_peek_strm,       pipe_peek_tag,       pipe_peek_seq_type,       pipe_peek_cmd,       pipe_peek_bank,       pipe_peek_page      } = pipe_peek_data       ;
          assign {pipe_peek_twoIn_strm, pipe_peek_twoIn_tag, pipe_peek_twoIn_seq_type, pipe_peek_twoIn_cmd, pipe_peek_twoIn_bank, pipe_peek_twoIn_page} = pipe_peek_twoIn_data ;

        assign clear = 1'b0 ;
 
        always @(*)
          begin
            pipe_read = pipe_valid ;  // FIXME - may be ok
          end

      end
  endgenerate


  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: cmd_seq_cache_fifo

        wire                                                    clear                 ;
        wire                                                    almost_full           ;
        reg                                                     write                 ;
        wire  [`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_RANGE ]   write_data            ;
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   write_tag             ;
        reg   [`DRAM_ACC_SEQ_TYPE_RANGE                     ]   write_seq_type        ;
        reg   [`MGR_STREAM_ADDRESS_RANGE                    ]   write_strm            ;
        reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE                  ]   write_cmd             ;
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   write_bank            ;
        reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   write_page            ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                              
          reg   [`MGR_DRAM_LINE_ADDRESS_RANGE               ]   write_line            ;
        `endif                                              
                                                            
        wire                                                    pipe_valid            ;
        reg                                                     pipe_read             ;
                                                                                
        wire  [`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_RANGE ]   pipe_data             ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   pipe_tag              ;
        wire  [`DRAM_ACC_SEQ_TYPE_RANGE                     ]   pipe_seq_type         ;
        wire  [`MGR_STREAM_ADDRESS_RANGE                    ]   pipe_strm             ;
        wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE                  ]   pipe_cmd              ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_bank             ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_page             ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                              
          wire  [`MGR_DRAM_LINE_ADDRESS_RANGE               ]   pipe_line             ;
        `endif

        wire  [`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_RANGE ]   pipe_peek_data        ;
        wire                                                    pipe_peek_valid       ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   pipe_peek_tag         ;
        wire  [`DRAM_ACC_SEQ_TYPE_RANGE                     ]   pipe_peek_seq_type    ;
        wire  [`MGR_STREAM_ADDRESS_RANGE                    ]   pipe_peek_strm        ;
        wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE                  ]   pipe_peek_cmd         ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_peek_bank        ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_peek_page        ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                              
          wire  [`MGR_DRAM_LINE_ADDRESS_RANGE               ]   pipe_peek_line        ;
        `endif                                              
                                                            
        wire                                                    pipe_peek_twoIn_valid    ;
        wire  [`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_RANGE ]   pipe_peek_twoIn_data     ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   pipe_peek_twoIn_tag      ;
        wire  [`DRAM_ACC_SEQ_TYPE_RANGE                     ]   pipe_peek_twoIn_seq_type ;
        wire  [`MGR_STREAM_ADDRESS_RANGE                    ]   pipe_peek_twoIn_strm     ;
        wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE                  ]   pipe_peek_twoIn_cmd      ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_peek_twoIn_bank     ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_peek_twoIn_page     ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                                 
          wire  [`MGR_DRAM_LINE_ADDRESS_RANGE               ]   pipe_peek_twoIn_line     ;
        `endif


        generic_pipelined_w_peek_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH                 ),
                                        .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_CACHE_CMD_SEQ_FIFO_ALMOST_FULL_THRESHOLD ),
                                        .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_WIDTH       )
                        ) page_cmd_gpfifo (
                                 // Status
                                .almost_full           ( almost_full           ),
                                 // Write                                      
                                .write                 ( write                 ),
                                .write_data            ( write_data            ),
                                 // Read                                       
                                .pipe_valid            ( pipe_valid            ),
                                .pipe_data             ( pipe_data             ),
                                .pipe_read             ( pipe_read             ),

                                .pipe_peek_valid       ( pipe_peek_valid       ),
                                .pipe_peek_data        ( pipe_peek_data        ),
                                .pipe_peek_twoIn_valid ( pipe_peek_twoIn_valid ),
                                .pipe_peek_twoIn_data  ( pipe_peek_twoIn_data  ),

                                // General
                                .clear                 ( clear                 ),
                                .reset_poweron         ( reset_poweron         ),
                                .clk                   ( clk                   )
                                );

        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                       
          assign write_data  = {write_strm, write_tag, write_seq_type, write_cmd, write_bank, write_page, write_line} ;

          assign {pipe_strm,            pipe_tag,            pipe_seq_type,            pipe_cmd,            pipe_bank,            pipe_page,            pipe_line           } = pipe_data            ;
          assign {pipe_peek_strm,       pipe_peek_tag,       pipe_peek_seq_type,       pipe_peek_cmd,       pipe_peek_bank,       pipe_peek_page,       pipe_peek_line      } = pipe_peek_data       ;
          assign {pipe_peek_twoIn_strm, pipe_peek_twoIn_tag, pipe_peek_twoIn_seq_type, pipe_peek_twoIn_cmd, pipe_peek_twoIn_bank, pipe_peek_twoIn_page, pipe_peek_twoIn_line} = pipe_peek_twoIn_data ;
        `else
          assign write_data  = {write_strm, write_tag, write_cmd, write_bank, write_page} ;

          assign {pipe_strm,            pipe_tag,            pipe_seq_type,            pipe_cmd,            pipe_bank,            pipe_page           } = pipe_data            ;
          assign {pipe_peek_strm,       pipe_peek_tag,       pipe_peek_seq_type,       pipe_peek_cmd,       pipe_peek_bank,       pipe_peek_page      } = pipe_peek_data       ;
          assign {pipe_peek_twoIn_strm, pipe_peek_twoIn_tag, pipe_peek_twoIn_seq_type, pipe_peek_twoIn_cmd, pipe_peek_twoIn_bank, pipe_peek_twoIn_page} = pipe_peek_twoIn_data ;
        `endif

        assign clear = 1'b0 ;
 
      end
  endgenerate

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Pass command sequence fifos
  //  - test if command at head of sequence fifo can_go
  //  - 
  //  -
      
  reg                                        chan_final_queue_valid   [`MGR_DRAM_NUM_CHANNELS]  ; 
  reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   chan_final_queue_cmd     [`MGR_DRAM_NUM_CHANNELS]  ;
  reg   [`MGR_STREAM_ADDRESS_RANGE       ]   chan_final_queue_strm    [`MGR_DRAM_NUM_CHANNELS]  ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   chan_final_queue_bank    [`MGR_DRAM_NUM_CHANNELS]  ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   chan_final_queue_page    [`MGR_DRAM_NUM_CHANNELS]  ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                    
    reg   [`MGR_DRAM_LINE_ADDRESS_RANGE  ]   chan_final_queue_line    [`MGR_DRAM_NUM_CHANNELS]  ;
  `endif


  // Select and steer the access timer request
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: cmd_seq_pass_fsm

        reg [`MMC_CNTL_CMD_CHECK_STATE_RANGE ] mmc_cntl_cmd_check_state      ; // state flop
        reg [`MMC_CNTL_CMD_CHECK_STATE_RANGE ] mmc_cntl_cmd_check_state_next ;
        
        // State register 
        always @(posedge clk)
          begin
            mmc_cntl_cmd_check_state <= ( reset_poweron ) ? `MMC_CNTL_CMD_CHECK_WAIT        :
                                                            mmc_cntl_cmd_check_state_next  ;
          end
        
        //--------------------------------------------------
        // Control signals
        //  - 

        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   last_page_tag         ;  // last read tag
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   last_cache_tag        ;  // last read tag
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   delta_tag             ;  // keep track of difference between page and cache reads
                                                                                         // >0 means page is ahead
        wire                                                    delta_tag_gt0         ;
        wire                                                    tags_synced           ; // if last tag is the same in both

        wire                                                    page_cmd_requested    ; // 
        wire                                                    cache_cmd_requested   ; // 

        always @(*)
          begin
            case (mmc_cntl_cmd_check_state)
              
              // Page Open commands over cache commands
              // When we see a page close, we need to stop and wait until all cache commands have been serviced up to the page close tag 
              // cache commands can only be serviced up to the current page command tag. 
              // e.g. dont let cache commands jump ahead (I dont think that can happen anyway)
              //  - keep track of which fifo is ahead by tracking the tag
              // e.g. deltaTag <=0

              `MMC_CNTL_CMD_CHECK_WAIT: 
                // Always make sure we start on a PO - this is a debug state, we dont come back here
                mmc_cntl_cmd_check_state_next =  ( cmd_seq_page_fifo [chan].pipe_valid && (cmd_seq_page_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PO)) ?  `MMC_CNTL_CMD_CHECK_INIT   :
                                                 ( cmd_seq_page_fifo [chan].pipe_valid && (cmd_seq_page_fifo [chan].pipe_cmd != `DRAM_ACC_CMD_IS_PO)) ?  `MMC_CNTL_CMD_CHECK_ERR    :  // cant start with non PO
                                                 ( cmd_seq_cache_fifo[chan].pipe_valid                                                              ) ?  `MMC_CNTL_CMD_CHECK_ERR    :  // cant start with a cache command
                                                                                                                                                         `MMC_CNTL_CMD_CHECK_WAIT   ;
              `MMC_CNTL_CMD_CHECK_INIT: 
                // Always make sure we start on a PO
                mmc_cntl_cmd_check_state_next =  ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PO)               ) ?  `MMC_CNTL_CMD_CHECK_PO   :
                                                 ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PC) && tags_synced) ?  `MMC_CNTL_CMD_CHECK_PC   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CR)               ) ?  `MMC_CNTL_CMD_CHECK_CR   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CW)               ) ?  `MMC_CNTL_CMD_CHECK_CW   :
                                                                                                                                                                          `MMC_CNTL_CMD_CHECK_INIT ;
                                                                                                    
              `MMC_CNTL_CMD_CHECK_PO: 
                // Always make sure we start on a PO
                mmc_cntl_cmd_check_state_next =  (~can_go [chan][cmd_seq_page_fifo [chan].pipe_bank]                                                                 ) ?  `MMC_CNTL_CMD_CHECK_PO   :
                                                 ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PO)               ) ?  `MMC_CNTL_CMD_CHECK_PO   :
                                                 ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PC) && tags_synced) ?  `MMC_CNTL_CMD_CHECK_PC   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CR)               ) ?  `MMC_CNTL_CMD_CHECK_CR   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CW)               ) ?  `MMC_CNTL_CMD_CHECK_CW   :
                                                                                                                                                                          `MMC_CNTL_CMD_CHECK_INIT ;
              `MMC_CNTL_CMD_CHECK_PC: 
                // Always make sure we start on a PO
                mmc_cntl_cmd_check_state_next =  (~can_go [chan][cmd_seq_page_fifo [chan].pipe_bank]                                                                 ) ?  `MMC_CNTL_CMD_CHECK_PC   :
                                                 ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PO)               ) ?  `MMC_CNTL_CMD_CHECK_PO   :
                                                 ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PC) && tags_synced) ?  `MMC_CNTL_CMD_CHECK_PC   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CR)               ) ?  `MMC_CNTL_CMD_CHECK_CR   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CW)               ) ?  `MMC_CNTL_CMD_CHECK_CW   :
                                                                                                                                                                          `MMC_CNTL_CMD_CHECK_INIT ;
              `MMC_CNTL_CMD_CHECK_CR: 
                // Always make sure we start on a PO
                mmc_cntl_cmd_check_state_next =  (~can_go [chan][cmd_seq_cache_fifo [chan].pipe_bank]                                                                ) ?  `MMC_CNTL_CMD_CHECK_CR   :
                                                 ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PO)               ) ?  `MMC_CNTL_CMD_CHECK_PO   :
                                                 ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PC) && tags_synced) ?  `MMC_CNTL_CMD_CHECK_PC   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CR)               ) ?  `MMC_CNTL_CMD_CHECK_CR   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CW)               ) ?  `MMC_CNTL_CMD_CHECK_CW   :
                                                                                                                                                                          `MMC_CNTL_CMD_CHECK_INIT ;
              `MMC_CNTL_CMD_CHECK_CW: 
                // Always make sure we start on a PO
                mmc_cntl_cmd_check_state_next =  (~can_go [chan][cmd_seq_cache_fifo [chan].pipe_bank]                                                                ) ?  `MMC_CNTL_CMD_CHECK_CW   :
                                                 ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PO)               ) ?  `MMC_CNTL_CMD_CHECK_PO   :
                                                 ( cmd_seq_page_fifo  [chan].pipe_valid && (cmd_seq_page_fifo  [chan].pipe_cmd == `DRAM_ACC_CMD_IS_PC) && tags_synced) ?  `MMC_CNTL_CMD_CHECK_PC   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CR)               ) ?  `MMC_CNTL_CMD_CHECK_CR   :
                                                 ( cmd_seq_cache_fifo [chan].pipe_valid && (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_CW)               ) ?  `MMC_CNTL_CMD_CHECK_CW   :
                                                                                                                                                                          `MMC_CNTL_CMD_CHECK_INIT ;
      
              `MMC_CNTL_CMD_CHECK_ERR: 
                mmc_cntl_cmd_check_state_next =  `MMC_CNTL_CMD_CHECK_ERR       ;
      
              default:
                mmc_cntl_cmd_check_state_next = `MMC_CNTL_CMD_CHECK_WAIT ;
          
            endcase // case (mmc_cntl_cmd_check_state)
          end // always @ (*)

        //--------------------------------------------------
        // Control
        //  - 

        assign  delta_tag_gt0  =  delta_tag[`MMC_CNTL_CMD_GEN_TAG_MSB ] ;  // value is negative if msb=1
        assign  tags_synced    =  last_page_tag == last_cache_tag ;

        assign  page_cmd_requested   = (mmc_cntl_cmd_check_state == `MMC_CNTL_CMD_CHECK_PO) | (mmc_cntl_cmd_check_state == `MMC_CNTL_CMD_CHECK_PC) | (mmc_cntl_cmd_check_state == `MMC_CNTL_CMD_CHECK_PR) ;
        assign  cache_cmd_requested  = (mmc_cntl_cmd_check_state == `MMC_CNTL_CMD_CHECK_CR) | (mmc_cntl_cmd_check_state == `MMC_CNTL_CMD_CHECK_CW) ;

        // we need to account for the fact that a page tag might have two cmds associated with it
        always @(posedge clk)
          begin
            last_page_tag       <= (reset_poweron                      ) ? 'd0                                :
                                   (cmd_seq_page_fifo [chan].pipe_read ) ? cmd_seq_page_fifo [chan].pipe_tag  :
                                                                           last_page_tag                      ;

            last_cache_tag      <= (reset_poweron                      ) ? 'd0                                :
                                   (cmd_seq_cache_fifo [chan].pipe_read) ? cmd_seq_cache_fifo [chan].pipe_tag :
                                                                           last_cache_tag                     ;

            delta_tag           <= (reset_poweron                                                                                ) ? 'd0             :
                                   (cmd_seq_page_fifo  [chan].pipe_read && (cmd_seq_page_fifo [chan].pipe_tag  != last_page_tag )) ? delta_tag + 'd1 :
                                   (cmd_seq_cache_fifo [chan].pipe_read && (cmd_seq_cache_fifo [chan].pipe_tag != last_cache_tag)) ? delta_tag - 'd1 :
                                                                                                                                     delta_tag       ;

          end

        for (bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank++) 
          begin: set_access_req
            always @(posedge clk)
              begin
                page_cmd_grant_request_valid [chan][bank] <=  can_go_checker_ready [chan][bank] & page_cmd_requested & (cmd_seq_page_fifo [chan].pipe_bank == bank) ;
                                                                                                                                                                                                        
                page_cmd_grant_request_strm  [chan][bank] <= { `DRAM_ACC_NUM_OF_CMDS_WIDTH {page_cmd_requested }} & { `DRAM_ACC_NUM_OF_CMDS_WIDTH  {cmd_seq_page_fifo [chan].pipe_bank == bank}} & cmd_seq_page_fifo [chan].pipe_strm  ;
                                                                                                    
                page_cmd_grant_request_page  [chan][bank] <= { `DRAM_ACC_NUM_OF_CMDS_WIDTH {page_cmd_requested }} & { `DRAM_ACC_NUM_OF_CMDS_WIDTH  {cmd_seq_page_fifo [chan].pipe_bank == bank}} & cmd_seq_page_fifo [chan].pipe_page  ;
                                                                                                    
                page_cmd_grant_request_cmd   [chan][bank] <= { `DRAM_ACC_NUM_OF_CMDS_WIDTH {page_cmd_requested }} & { `DRAM_ACC_NUM_OF_CMDS_WIDTH  {cmd_seq_page_fifo [chan].pipe_bank == bank}} & cmd_seq_page_fifo [chan].pipe_cmd   ;
                                                                                                    
                cache_cmd_grant_request_valid[chan][bank] <=  can_go_checker_ready [chan][bank] & cache_cmd_requested & (cmd_seq_cache_fifo [chan].pipe_bank == bank) ;
                                                                                                                                                                                                        
                cache_cmd_grant_request_strm [chan][bank] <= { `DRAM_ACC_NUM_OF_CMDS_WIDTH {cache_cmd_requested}} & { `DRAM_ACC_NUM_OF_CMDS_WIDTH  {cmd_seq_cache_fifo[chan].pipe_bank == bank}} & cmd_seq_cache_fifo[chan].pipe_strm  ;
                                                                                                   
                cache_cmd_grant_request_page [chan][bank] <= { `DRAM_ACC_NUM_OF_CMDS_WIDTH {cache_cmd_requested}} & { `DRAM_ACC_NUM_OF_CMDS_WIDTH  {cmd_seq_cache_fifo[chan].pipe_bank == bank}} & cmd_seq_cache_fifo[chan].pipe_page  ;
                                                                                                    
                cache_cmd_grant_request_cmd  [chan][bank] <= { `DRAM_ACC_NUM_OF_CMDS_WIDTH {cache_cmd_requested}} & { `DRAM_ACC_NUM_OF_CMDS_WIDTH  {cmd_seq_cache_fifo[chan].pipe_bank == bank}} & cmd_seq_cache_fifo[chan].pipe_cmd   ;
                                                                                                    
              end
          end

        // Read sequence fifos
        always @(*)
          begin
            cmd_seq_page_fifo [chan].pipe_read   =  page_cmd_requested  && can_go [chan][cmd_seq_page_fifo [chan].pipe_bank] ;
            cmd_seq_cache_fifo [chan].pipe_read  =  cache_cmd_requested && can_go [chan][cmd_seq_cache_fifo[chan].pipe_bank] ;
          end



        always @(posedge clk)
          begin
            chan_final_queue_valid [chan]   <=    cmd_seq_page_fifo [chan].pipe_read | 
                                                  cmd_seq_cache_fifo[chan].pipe_read ;

            chan_final_queue_cmd   [chan]   <=  ( cmd_seq_page_fifo [chan].pipe_read ) ? cmd_seq_page_fifo [chan].pipe_cmd :
                                                                                         cmd_seq_cache_fifo[chan].pipe_cmd ;

            chan_final_queue_strm  [chan]   <=  ( cmd_seq_page_fifo [chan].pipe_read ) ? cmd_seq_page_fifo [chan].pipe_strm :
                                                                                         cmd_seq_cache_fifo[chan].pipe_strm ;

            chan_final_queue_bank  [chan]   <=  ( cmd_seq_page_fifo [chan].pipe_read ) ? cmd_seq_page_fifo [chan].pipe_bank :
                                                                                         cmd_seq_cache_fifo[chan].pipe_bank ;

            chan_final_queue_page  [chan]   <=  ( cmd_seq_page_fifo [chan].pipe_read ) ? cmd_seq_page_fifo [chan].pipe_page :
                                                                                         cmd_seq_cache_fifo[chan].pipe_page ;

            `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                    
              chan_final_queue_line[chan]   <=  cmd_seq_cache_fifo[chan].pipe_line ;
            `endif
          end

      end
  endgenerate


  
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Final command fifos
  // - for page and cache commands, the page and cache fifos always have a corresponding entry
  //  e.g. PO-NOP, NOP-CR
  //

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: final_page_cmd_fifo

        wire                                                     clear                 ;
        wire                                                     almost_full           ;
        reg                                                      write                 ;
        wire  [`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   write_data            ;

        wire                                                     pipe_peek_valid       ;
        wire  [`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   pipe_peek_data        ;
        wire                                                     pipe_peek_twoIn_valid ;
        wire  [`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   pipe_peek_twoIn_data  ;
        wire                                                     pipe_valid            ;
        wire  [`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   pipe_data             ;
        reg                                                      pipe_read             ;

        reg   [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE      ]   write_cmd             ;
        reg   [ `MGR_STREAM_ADDRESS_RANGE                    ]   write_strm            ;
        reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE                 ]   write_bank            ;
        reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   write_page            ;
                                                                                      
        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE      ]   pipe_cmd              ;
        wire  [ `MGR_STREAM_ADDRESS_RANGE                    ]   pipe_strm             ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_bank             ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_page             ;

        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE      ]   pipe_peek_cmd         ;
        wire  [ `MGR_STREAM_ADDRESS_RANGE                    ]   pipe_peek_strm        ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_peek_bank        ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_peek_page        ;

        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE      ]   pipe_peek_twoIn_cmd   ;
        wire  [ `MGR_STREAM_ADDRESS_RANGE                    ]   pipe_peek_twoIn_strm  ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_peek_twoIn_bank  ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_peek_twoIn_page  ;


        generic_pipelined_w_peek_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH                 ),
                                        .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_ALMOST_FULL_THRESHOLD ),
                                        .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                 // Status
                                .almost_full           ( almost_full           ),
                                 // Write                                      
                                .write                 ( write                 ),
                                .write_data            ( write_data            ),
                                 // Read                                  
                                .pipe_peek_valid       ( pipe_peek_valid       ),
                                .pipe_peek_data        ( pipe_peek_data        ),
                                .pipe_peek_twoIn_valid ( pipe_peek_twoIn_valid ),
                                .pipe_peek_twoIn_data  ( pipe_peek_twoIn_data  ),
                                .pipe_valid            ( pipe_valid            ),
                                .pipe_data             ( pipe_data             ),
                                .pipe_read             ( pipe_read             ),

                                // General
                                .clear                 ( clear                 ),
                                .reset_poweron         ( reset_poweron         ),
                                .clk                   ( clk                   )
                                );

        assign clear = 1'b0 ;

        assign write_data  = {write_strm, write_cmd, write_bank, write_page} ;

        assign {pipe_strm,            pipe_cmd,            pipe_bank,            pipe_page           } = pipe_data            ;
        assign {pipe_peek_strm,       pipe_peek_cmd,       pipe_peek_bank,       pipe_peek_page      } = pipe_peek_data       ;
        assign {pipe_peek_twoIn_strm, pipe_peek_twoIn_cmd, pipe_peek_twoIn_bank, pipe_peek_twoIn_page} = pipe_peek_twoIn_data ;

        always @(posedge clk)
          begin
            if (reset_poweron || !dfi__mmc__init_done_d1)
              begin
                write         <= 1'b0 ;
                write_cmd     <=  'd0 ;
                write_strm    <=  'd0 ;
                write_bank    <=  'd0 ;
                write_page    <=  'd0 ;
              end
            else
              begin
                casex ({chan_final_queue_valid [chan], chan_final_queue_cmd [chan]})  // synopsys parallel_case
                
                  {1'b1, `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_PO } :
                     begin
                       write         <= 1'b1                           ;
                       write_cmd     <=  `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PO ;
                       write_strm    <=  chan_final_queue_strm [chan]  ;
                       write_bank    <=  chan_final_queue_bank [chan]  ;
                       write_page    <=  chan_final_queue_page [chan]  ;
                     end
                  {1'b1, `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_PC } :
                     begin
                       write         <= 1'b1                           ;
                       write_cmd     <=  `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PC ;
                       write_strm    <=  chan_final_queue_strm [chan]  ;
                       write_bank    <=  chan_final_queue_bank [chan]  ;
                       write_page    <=  chan_final_queue_page [chan]  ;
                     end
                  {1'b1, `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_PR } :
                     begin
                       write         <= 1'b1                           ;
                       write_cmd     <=  `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PR ;
                       write_strm    <=  chan_final_queue_strm [chan]  ;
                       write_bank    <=  chan_final_queue_bank [chan]  ;
                       write_page    <=  chan_final_queue_page [chan]  ;
                     end
                  {1'b0, {`DRAM_ACC_NUM_OF_CMDS_WIDTH {1'bx}} } :
                     begin
                       write         <= 1'b0                           ;
                       write_cmd     <=  `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_NOP ;
                       write_strm    <=  chan_final_queue_strm [chan]  ;
                       write_bank    <=  chan_final_queue_bank [chan]  ;
                       write_page    <=  chan_final_queue_page [chan]  ;
                     end
                
                  default:
                     begin
                       write         <= 1'b1                  ;
                       write_cmd     <= `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_NOP ;
                       write_strm    <=  'd0                  ;
                       write_bank    <=  'd0                  ;
                       write_page    <=  'd0                  ;
                     end
        
                endcase
              end
          end
      end
  endgenerate


  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: final_cache_cmd_fifo

        wire                                                      clear                 ;
        wire                                                      almost_full           ;
        reg                                                       write                 ;

        wire                                                      pipe_valid            ;
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   pipe_data             ;

        wire                                                      pipe_peek_valid       ;
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   pipe_peek_data        ;
        wire                                                      pipe_peek_twoIn_valid ;
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   pipe_peek_twoIn_data  ;
        reg                                                       pipe_read             ;
                                                                                        
        reg   [`MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_RANGE       ]   write_cmd             ;
        reg   [`MGR_STREAM_ADDRESS_RANGE                      ]   write_strm            ;
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE                   ]   write_bank            ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                                
          reg   [`MGR_DRAM_LINE_ADDRESS_RANGE                 ]   write_line            ;
        `endif                                                                          
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   write_data            ;
                                                                                        
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_RANGE       ]   pipe_cmd              ;
        wire  [`MGR_STREAM_ADDRESS_RANGE                      ]   pipe_strm             ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                   ]   pipe_bank             ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                                
          wire  [`MGR_DRAM_LINE_ADDRESS_RANGE                 ]   pipe_line             ;
        `endif

        wire  [`MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_RANGE       ]   pipe_peek_cmd         ;
        wire  [`MGR_STREAM_ADDRESS_RANGE                      ]   pipe_peek_strm        ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                   ]   pipe_peek_bank        ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                                
          wire  [`MGR_DRAM_LINE_ADDRESS_RANGE                 ]   pipe_peek_line        ;
        `endif
      
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_RANGE       ]   pipe_peek_twoIn_cmd   ;
        wire  [`MGR_STREAM_ADDRESS_RANGE                      ]   pipe_peek_twoIn_strm  ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                   ]   pipe_peek_twoIn_bank  ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                                
          wire  [`MGR_DRAM_LINE_ADDRESS_RANGE                 ]   pipe_peek_twoIn_line  ;
        `endif
      

        generic_pipelined_w_peek_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH                 ),
                          .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_CACHE_CMD_FINAL_FIFO_ALMOST_FULL_THRESHOLD ),
                          .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_WIDTH       )
                        ) generic_pipelined_w_peek_fifo (
                                 // Status
                                .almost_full           ( almost_full           ),
                                 // Write                                      
                                .write                 ( write                 ),
                                .write_data            ( write_data            ),
                                 // Read                                  
                                .pipe_peek_valid       ( pipe_peek_valid       ),
                                .pipe_peek_data        ( pipe_peek_data        ),
                                .pipe_peek_twoIn_valid ( pipe_peek_twoIn_valid ),
                                .pipe_peek_twoIn_data  ( pipe_peek_twoIn_data  ),
                                .pipe_valid            ( pipe_valid            ),
                                .pipe_data             ( pipe_data             ),
                                .pipe_read             ( pipe_read             ),
                                                       
                                // General             
                                .clear                 ( clear                 ),
                                .reset_poweron         ( reset_poweron         ),
                                .clk                   ( clk                   )
                                );

        assign clear = 1'b0 ;

        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                       
          assign write_data  = {write_strm, write_cmd, write_bank, write_line} ;

          assign {pipe_strm,            pipe_cmd,            pipe_bank,            pipe_line           } = pipe_data            ;
          assign {pipe_peek_strm,       pipe_peek_cmd,       pipe_peek_bank,       pipe_peek_line      } = pipe_peek_data       ;
          assign {pipe_peek_twoIn_strm, pipe_peek_twoIn_cmd, pipe_peek_twoIn_bank, pipe_peek_twoIn_line} = pipe_peek_twoIn_data ;
        `else
          assign write_data  = {write_strm, write_cmd, write_bank} ;

          assign {pipe_strm,            pipe_cmd,            pipe_bank           } = pipe_data            ;
          assign {pipe_peek_strm,       pipe_peek_cmd,       pipe_peek_bank      } = pipe_peek_data       ;
          assign {pipe_peek_twoIn_strm, pipe_peek_twoIn_cmd, pipe_peek_twoIn_bank} = pipe_peek_twoIn_data ;
        `endif

        always @(posedge clk)
          begin
            if (reset_poweron || !dfi__mmc__init_done_d1)
              begin
                write         <= 1'b0 ;
                write_cmd     <=  'd0 ;
                write_bank    <=  'd0 ;
                write_strm    <=  'd0 ;
                `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                    
                  write_line  <=  'd0                  ;
                `endif
              end
            else
              begin
                casex ({chan_final_queue_valid [chan], chan_final_queue_cmd [chan]})  // synopsys parallel_case
                
                  {1'b1, `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_CR } :
                     begin
                       write         <= 1'b1                           ;
                       write_cmd     <=  `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CR ;
                       write_strm    <=  chan_final_queue_strm [chan]  ;
                       write_bank    <=  chan_final_queue_bank [chan]  ;
                       `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                    
                         write_line  <=  chan_final_queue_line [chan]  ;
                       `endif
                     end
                  {1'b1, `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_CW } :
                     begin
                       write         <= 1'b1                           ;
                       write_cmd     <=  `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW ;
                       write_strm    <=  chan_final_queue_strm [chan]  ;
                       write_bank    <=  chan_final_queue_bank [chan]  ;
                       `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                    
                         write_line  <=  chan_final_queue_line [chan]  ;
                       `endif
                     end
                  {1'b0, {`DRAM_ACC_NUM_OF_CMDS_WIDTH {1'bx}} } :
                     begin
                       write         <= 1'b0                           ;
                       write_cmd     <=  `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP ;
                       write_strm    <=  chan_final_queue_strm [chan]  ;
                       write_bank    <=  chan_final_queue_bank [chan]  ;
                       `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                    
                         write_line  <=  chan_final_queue_line [chan]  ;
                       `endif
                     end
                  default:
                     begin
                       write         <= 1'b1                  ;
                       write_cmd     <=  `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP ;
                       write_strm    <=  'd0                  ;
                       write_bank    <=  'd0                  ;
                       `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                    
                         write_line  <=  'd0                  ;
                       `endif
                     end
        
                endcase
              end
          end
      end
  endgenerate


  //----------------------------------------------------------------------------------------------------
  // Control page and cache clock phases
  reg dram_cmd_mode;

  always@(posedge clk)
  begin
    if(reset_poweron || !dfi__mmc__init_done_d1)
       dram_cmd_mode <= 0;
    else
       dram_cmd_mode <= ~dram_cmd_mode; 
  end
  
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------
  // DFI Sequencer FSM(s)
  //  - read the channel command page and cache fifo and sequence commands to DRAM
  // 
  //------------------------------------------------------------------------------------------
   
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: dfi_seq_fsm

        reg [`MMC_CNTL_DFI_SEQ_STATE_RANGE ] mmc_cntl_seq_state ;
        reg [`MMC_CNTL_DFI_SEQ_STATE_RANGE ] mmc_cntl_seq_state_next ;
        
        always@(posedge clk)
          begin
              mmc_cntl_seq_state <= ( reset_poweron ) ? `MMC_CNTL_DFI_SEQ_WAIT     :
                                                        mmc_cntl_seq_state_next    ;
          end
        
        always@(*)
          begin
        
            //----------------------------------------------------------------------------------------------------
            // Default drive values
        
            {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1 [chan]} = `MGR_DRAM_COMMAND_NOP ;
            mmc__dfi__bank_e1 [chan]                                                     = 'd0                   ; 
            mmc__dfi__addr_e1 [chan]                                                     = 'd0                   ; 
            for (int word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
              begin
                mmc__dfi__data_e1 [chan] [word]                                          = 'd0                   ;
              end

            final_page_cmd_fifo [chan].pipe_read  = 1'b0 ;
            final_cache_cmd_fifo[chan].pipe_read  = 1'b0 ;
        
            //----------------------------------------------------------------------------------------------------
            // State defined drive values
        
            case(mmc_cntl_seq_state)
            
                `MMC_CNTL_DFI_SEQ_WAIT: 
                    begin
            
                    if(reset_poweron || !dfi__mmc__init_done_d1 || !final_page_cmd_fifo[chan].pipe_valid || (dram_cmd_mode == 1'b1)) //if initialization not done
                      begin
                          mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WAIT;
                      end
                    // we will always see a page command first, but ensure we first respond to page command after reset to synchronize with the DiRAM4
                    else  
                      begin

                          final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                          final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;

                          // From the WAIT state, the next state can be either a page command or a page command with write data
                          // so if the RW command fifo isnt empty and the RW command is a write, we need to read the target data fifo based on the
                          // "peeked" RW bank address

                          if (final_page_cmd_fifo[chan].pipe_peek_twoIn_valid &&  ((final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CR ) || (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP )))
                            begin
                              mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                            end
                          else if (final_page_cmd_fifo[chan].pipe_peek_twoIn_valid &&  (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW ) )
                            begin
                              mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
            
                              // FIXME
                              // need to prepare write data to be output one cycle early with page command
                              // setect data based on stream id in final queue
                              //`include "sch_driver_peek_select_data_fifo.vh"  
                            end
                          else
                            begin
                              mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                            end
            
                     end   
                   end
            
                `MMC_CNTL_DFI_SEQ_PAGE_CMD: 
                    begin
                        // This state dram_cmd_mode == 1
                    
                        //--------------------------------------------------
                        // DFI Output
                        case (final_page_cmd_fifo[chan].pipe_cmd)

                          `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PO :
                            {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_PO ;

                          `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PC :
                            {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_PC ;

                          `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PR :
                            {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_PR ;

                          `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_NOP :
                            {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_NOP ;

                        endcase
                    
                        mmc__dfi__bank_e1 [chan]  =  final_page_cmd_fifo[chan].pipe_bank ;
                        mmc__dfi__addr_e1 [chan]  =  final_page_cmd_fifo[chan].pipe_page ;          
                        //--------------------------------------------------
                    
                        if (!final_page_cmd_fifo[chan].pipe_valid)  // no data
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
                        else if (final_cache_cmd_fifo[chan].pipe_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP )  // queue has data but the next RW is not a valid RW command
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
                        else
                          // if the RW command fifo isnt empty, we either got to the page command because the RW fifo contains a read 
                          // 'or' a write command has just arrived
                          // If a write command has just arrived, its too late to preread the data to have it available during this current command phase,
                          // so we'll jump to the RW NOP state where we can assert the data fifo read enable and then we'll jump to the PAGE_CMD_WITH_WR_DATA state
                          begin
                            if (final_cache_cmd_fifo[chan].pipe_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CR)
                              begin

                                mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_RD_CMD;

                                final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                                final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;

                              end
                            // The only option left is a WR in the RW cmd fifo
                            // jump to the NOP_RW_CMD state so we can pre-load the
                            // data during the next PG phase
                            else
                              begin
                                mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                              end
                          end              
                    end
            
                `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA: 
                    begin
                        // This state dram_cmd_mode == 1
                        //
                        // To get to this state, we have pre-read the RW fifo and write data fifo, so drive the write data using the RW bank address
                        // We also know the next 'RW' phase is a write and as we have pre-read the RW fifo just transition to the WR_CMD state
                    
                        //--------------------------------------------------
                        // DFI Output
                        //  - It is a valid 'Page' phase, so drive the DFI interface
                        case (final_page_cmd_fifo[chan].pipe_cmd)

                          `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PO :
                            {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_PO ;

                          `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PC :
                            {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_PC ;

                          `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PR :
                            {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_PR ;

                          `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_NOP :
                            {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_NOP ;

                        endcase
                    
                        mmc__dfi__bank_e1 [chan]   =  final_page_cmd_fifo[chan].pipe_bank ;
                        mmc__dfi__addr_e1 [chan]   =  final_page_cmd_fifo[chan].pipe_page ;          
                        //--------------------------------------------------
        
                        final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                        final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;

                        // We already know the next RW command is a WR and we have pre-read the write data fifo, so use the peeked RW bank addr to 
                        // select data to drive onto the dfi interface drv__dfi__data[1:2]
                        // remember, we write the first chunk of data during the PG cmd phase prior to the WR during the RW phase
                        // FIXME
                        //`include "sch_driver_peek_get_data_fifo.vh"  
                    
                         // We know the next 'RW' phase is a write so transition to the WR_CMD state and load the second data word  
                         // Remember, we had pre-read the RW fifo so no RW fifo reads occur in this state
                         mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WR_CMD;
                    
                        // Pre-read the write data fifo based on the bank address in the peeked RW bank address fifo
                        // FIXME
                        // `include "sch_driver_select_data_fifo.vh"  
                    end
            
                `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD: 
                    begin
                        // This state dram_cmd_mode == 1
                    
                        if (!final_page_cmd_fifo[chan].pipe_valid)  // no data
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
              
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP )  // queue has data but the next RW is not a valid RW command
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
                        else
                          // if the RW command fifo isnt empty, we either got to the page command because the RW fifo contains a read 
                          // 'or' a write command has just arrived
                          // If a write command has just arrived, its too late to preread the data to have it available during this current command phase,
                          // so we'll jump to the RW NOP state where we can assert the data fifo read enable and then we'll jump to the PAGE_CMD_WITH_WR_DATA state
                          begin
                            if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CR)
                              begin
                                mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_RD_CMD;

                                final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                                final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;

                              end
                            // The only option left is a WR in the RW cmd fifo
                            // jump to the NOP_RW_CMD state so we can pre-load the
                            // data during the next PG phase
                            else
                              begin
                                mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                              end
                          end              
                    end
            
            
                `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA: 
                    begin
                        // This state dram_cmd_mode == 1
                        //
                        // To get to this state, we have pre-read the RW fifo and write data fifo, so drive the write data using the RW bank address
                        // So we know the next 'RW' phase will be a write
                        //
                        //`SCH_DRIVER_READ_FINAL_QUEUES 
                        final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                        final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;
                    
                        // Output of write data fifo is valid so drive onto dfi interface
                        // driver drv__dfi__data[1:2]
                        // FIXME
                        //`include "sch_driver_peek_get_data_fifo.vh"  
                    
                        // We know the next 'RW' phase is a write so transition to the WR_CMD state and load the second data word  
                        // Remember, we had pre-read the RW fifo so no RW fifo reads occur in this state
                        mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WR_CMD;
                       
                        //FIXME
                        //`include "sch_driver_select_data_fifo.vh"  
                    end
            
                `MMC_CNTL_DFI_SEQ_RD_CMD: 
                    begin
                    
                        // This state dram_cmd_mode == 0
                        {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_CR              ;
                        mmc__dfi__bank_e1 [chan]                                              = final_cache_cmd_fifo[chan].pipe_bank ; 
                        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                       
                          mmc__dfi__addr_e1 [chan]                                            = final_cache_cmd_fifo[chan].pipe_line ; 
                        `else
                          mmc__dfi__addr_e1 [chan]                                            = 'd0                               ;
                        `endif
                        for (int word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
                          begin
                            mmc__dfi__data_e1 [chan] [word]                                   = 'd0                   ;
                          end
                        
                        `include "main_mem_cntl_dfi_seq_rw_state_transitions.vh"  
                    
                    end
            
                `MMC_CNTL_DFI_SEQ_WR_CMD:
                    begin
                    
                        // This state dram_cmd_mode == 0
                        {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_CW              ;
                        mmc__dfi__bank_e1 [chan]                                              = final_cache_cmd_fifo[chan].pipe_bank ; 
                        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                       
                          mmc__dfi__addr_e1 [chan]                                            = final_cache_cmd_fifo[chan].pipe_line ; 
                        `else
                          mmc__dfi__addr_e1 [chan]                                            = 'd0                               ;
                        `endif
                        for (int word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
                          begin
                            mmc__dfi__data_e1 [chan] [word]                                   = 'd0                   ;
                          end

                        `include "main_mem_cntl_dfi_seq_rw_state_transitions.vh"  
                        //`include "sch_driver_get_data_fifo.vh"  
                    end
            
                `MMC_CNTL_DFI_SEQ_NOP_RW_CMD: 
                    begin
                        `include "main_mem_cntl_dfi_seq_rw_state_transitions.vh"  
                    end
      
                default:
                    begin
        		mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WAIT;
                    end
      
            endcase 
          end
      end
  endgenerate

  // end of DFI Sequencer FSM(s)
  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Return path FIFOs
  //
  // 1) A fifo containing to which stream the next data should be directed
  //   - carry tag for debug (FIXME: remove later )
  //   - use a fifo per channel
  // 2) A FIFO containing return data
  //   - use the almost full to flow control memory requests
  //   - FIXME: May be able to remove this fifo and combine with mmc fifo in the mrc module
  //   - FIXME: perhaps we should use the mrc ready to flow control memory requests or restrict number of outstanding requests to 32???
  //

  
  reg  [`MGR_NUM_OF_STREAMS_VECTOR          ]   sending_to_stream     [`MGR_DRAM_NUM_CHANNELS ] ;  // indicates a channel return data fsm is sending

  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   set_send_to_stream    [`MGR_NUM_OF_STREAMS ];  // the channel return data fsm sets this if it is sending to the stream
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   clear_send_to_stream  [`MGR_NUM_OF_STREAMS ]; 

  //------------------------------------------
  // Target stream fifo

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: data_return_id

        wire  clear        ;
        wire  almost_full  ;
        wire                                                     write        ;
        wire  [`MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_RANGE   ]   write_data   ;
        wire                                                     pipe_valid   ;
        wire                                                     pipe_read    ;
        wire  [`MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_RANGE   ]   pipe_data    ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_READPATH_TAG_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_READPATH_TAG_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_WIDTH       )
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

        assign  write      =  cmd_seq_cache_fifo[chan].pipe_read ;
        assign  write_data =  {cmd_seq_cache_fifo[chan].pipe_strm, cmd_seq_cache_fifo[chan].pipe_tag};

        wire  [`MGR_STREAM_ADDRESS_RANGE    ]   pipe_strm     ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE  ]   pipe_tag      ;

        assign  {pipe_strm, pipe_tag}  =  pipe_data  ;

      end
  endgenerate

  //------------------------------------------
  // Return data fifo

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: from_dfi_fifo

        wire  clear        ;
        wire  almost_full  ;  
        wire                                               write          ;
        reg   [`MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_RANGE ]   write_data     ;
        wire                                               pipe_valid     ;
        wire                                               pipe_read      ;
        wire  [`COMMON_STD_INTF_CNTL_RANGE             ]   pipe_cntl      ;
        wire  [`MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_RANGE ]   pipe_data      ;
        wire  [`MGR_DRAM_INTF_RANGE                    ]   pipe_dram_data ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_FROM_DFI_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_FROM_DFI_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_WIDTH       )
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

        assign write  = dfi__mmc__valid_d1 [chan] ; 
        always @(*)
          begin
            write_data [`MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_RANGE ] = dfi__mmc__cntl_d1 [chan] ;
          end
        for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS; word=word+1) 
          begin: return_data
            always @(*)
              begin
                // FIXME : 32
                write_data [(word+1)*32-1 : word*32]   = dfi__mmc__data_d1 [chan][word] ;
              end
          end

        assign  pipe_cntl      =  pipe_data[`MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_RANGE ];
        assign  pipe_dram_data =  pipe_data[`MMC_CNTL_FROM_DFI_AGGREGATE_DATA_RANGE ];

        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    );  // use with pipe_valid
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    );  // use with pipe_valid
      end
  endgenerate

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Direct channel return data to requesting stream
      
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: rdp_fsm

        reg  [`MMC_CNTL_RDP_STATE_RANGE ]  mmc_cntl_rdp_state      ; // state flop
        reg  [`MMC_CNTL_RDP_STATE_RANGE ]  mmc_cntl_rdp_state_next ;
        
        // State register 
        always @(posedge clk)
          begin
            mmc_cntl_rdp_state <= ( reset_poweron ) ? `MMC_CNTL_RDP_WAIT        :
                                                       mmc_cntl_rdp_state_next  ;
          end
        
        always @(*)
          begin
            case (mmc_cntl_rdp_state)

              `MMC_CNTL_RDP_WAIT: 
                begin
                // let both channel streams continue if they are accessing different banks
                // FIXME - using hard value for stream id
                mmc_cntl_rdp_state_next =  (from_dfi_fifo[chan].pipe_valid && (data_return_id[chan].pipe_strm == 'd0) && ~|sending_to_stream[0] && mrc__mmc__ready_d1[0] ) ?  `MMC_CNTL_RDP_STRM0  :
                                           (from_dfi_fifo[chan].pipe_valid && (data_return_id[chan].pipe_strm == 'd1) && ~|sending_to_stream[1] && mrc__mmc__ready_d1[1] ) ?  `MMC_CNTL_RDP_STRM1  :
                                                                                                                                                                             `MMC_CNTL_RDP_WAIT   ;
                end

              `MMC_CNTL_RDP_STRM0: 
                mmc_cntl_rdp_state_next =  ( from_dfi_fifo[chan].pipe_eom) ?  `MMC_CNTL_RDP_WAIT   :
                                                                              `MMC_CNTL_RDP_STRM0  ;
                                                                                                                                            
              `MMC_CNTL_RDP_STRM1: 
                mmc_cntl_rdp_state_next =  ( from_dfi_fifo[chan].pipe_eom) ?  `MMC_CNTL_RDP_WAIT   :
                                                                              `MMC_CNTL_RDP_STRM1  ;
                                                                                                                                            
              `MMC_CNTL_RDP_ERR: 
                mmc_cntl_rdp_state_next =  `MMC_CNTL_RDP_ERR       ;
      
              default:
                mmc_cntl_rdp_state_next = `MMC_CNTL_RDP_WAIT ;
          
            endcase // case (mmc_cntl_rdp_state)
          end // always @ (*)

        always @(*)
          begin
            set_send_to_stream [0][chan] = (mmc_cntl_rdp_state == `MMC_CNTL_RDP_WAIT ) & (data_return_id[chan].pipe_strm == 'd0) & ~|sending_to_stream[0] & mrc__mmc__ready_d1[0]  ;
            set_send_to_stream [1][chan] = (mmc_cntl_rdp_state == `MMC_CNTL_RDP_WAIT ) & (data_return_id[chan].pipe_strm == 'd1) & ~|sending_to_stream[1] & mrc__mmc__ready_d1[1]  ;

            clear_send_to_stream [0][chan] = (mmc_cntl_rdp_state == `MMC_CNTL_RDP_STRM0 ) & from_dfi_fifo[chan].pipe_eom ;
            clear_send_to_stream [1][chan] = (mmc_cntl_rdp_state == `MMC_CNTL_RDP_STRM1 ) & from_dfi_fifo[chan].pipe_eom ;
          end

        wire  read_id_fifo     ;  // read the tag/strm ID fifo
        wire  read_data_fifo   ;  // read the dfi data fifo

        assign read_id_fifo    =   set_send_to_stream [0][chan] | set_send_to_stream [1][chan] ;
        assign read_data_fifo  =  (set_send_to_stream [0][chan] | set_send_to_stream [1][chan]) | (mmc_cntl_rdp_state != `MMC_CNTL_RDP_WAIT );  // if not waiting, we are sending

        // add a pipeline to data to align with the read signal
        reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   strm_data    ;
        for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS; word=word+1) 
          begin: strm_data_reg
            always @(posedge clk)
              begin
                strm_data  [word] <= from_dfi_fifo[chan].pipe_dram_data [(word+1)*32-1 : word*32] ;
              end
          end

      end
  endgenerate

  // Only one channel can be sending to the stream
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin
        for (strm=0; strm<`MGR_NUM_OF_STREAMS; strm=strm+1) 
          begin: return_status
            always @(posedge clk)
              begin
                sending_to_stream [chan][strm] <= (reset_poweron                    ) ? 1'b0                           :
                                                  (set_send_to_stream   [chan][strm]) ? 1'b1                           :
                                                  (clear_send_to_stream [chan][strm]) ? 1'b0                           :
                                                                                        sending_to_stream [chan][strm] ;
              end
          end
      end
  endgenerate


  // For each stream, grab the data from the sending channel
  reg                                                                           strm_data_valid    [`MGR_NUM_OF_STREAMS ] ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   strm_data          [`MGR_NUM_OF_STREAMS ] ;

  generate
    for (strm=0; strm<`MGR_NUM_OF_STREAMS; strm=strm+1) 
      begin
        always @(posedge clk)
          begin
            strm_data_valid [strm]  <=  (reset_poweron ) ? 1'b0                                                       :
                                                            sending_to_stream [0][strm] | sending_to_stream [1][strm] ;
          end
      end
  endgenerate
  generate
    for (strm=0; strm<`MGR_NUM_OF_STREAMS; strm=strm+1) 
      begin
        for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS; word=word+1) 
          begin: return_data
            always @(posedge clk)
              begin
                // FIXME : 32
                strm_data [strm][word] <= (sending_to_stream [0][strm] ) ? rdp_fsm[0].strm_data[word] :
                                          (sending_to_stream [1][strm] ) ? rdp_fsm[1].strm_data[word] :
                                                                           'd0                        ;
              end 
          end
      end
  endgenerate

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //
  endmodule 
  
