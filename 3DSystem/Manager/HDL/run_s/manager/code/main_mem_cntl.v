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
            input   wire                                           mrc__mmc__valid   [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mmc__cntl    [`MGR_NUM_OF_STREAMS ]     ,
            output  reg                                            mmc__mrc__ready   [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mrc__mmc__channel [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mrc__mmc__bank    [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mrc__mmc__page    [`MGR_NUM_OF_STREAMS ]     ,
            input   wire  [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      mrc__mmc__word    [`MGR_NUM_OF_STREAMS ]     ,
                                                                                    
            // MMC provides data from each DRAM channel
            // - response must be in order of request
            output  reg                                            mmc__mrc__valid   [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ]                                   ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mmc__mrc__cntl    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ]                                   ,
            input   wire                                           mrc__mmc__ready   [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ]                                   ,
            output  reg   [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__mrc__data    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] ,

            //--------------------------------------------------------------------------------
            // DFI Interface
            // - provide per channel signals
            // - DFI will handle SDR->DDR conversion
            input   wire                                           dfi__mmc__init_done                                                                                  ,
            input   wire  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      dfi__mmc__data       [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ]                     ,
            input   wire                                           dfi__mmc__valid      [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg                                            mmc__dfi__cs         [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg                                            mmc__dfi__cmd0       [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg                                            mmc__dfi__cmd1       [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mmc__dfi__bank       [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg   [ `MGR_DRAM_ADDRESS_RANGE         ]      mmc__dfi__addr       [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg   [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__dfi__data       [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ]                     ,

  
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
  reg                                            mrc__mmc__valid_d1   [`MGR_NUM_OF_STREAMS ]   ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mmc__cntl_d1    [`MGR_NUM_OF_STREAMS ]   ;
  reg                                            mmc__mrc__ready_e1   [`MGR_NUM_OF_STREAMS ]   ;
  reg   [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mrc__mmc__channel_d1 [`MGR_NUM_OF_STREAMS ]   ;
  reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mrc__mmc__bank_d1    [`MGR_NUM_OF_STREAMS ]   ;
  reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mrc__mmc__page_d1    [`MGR_NUM_OF_STREAMS ]   ;
  reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      mrc__mmc__word_d1    [`MGR_NUM_OF_STREAMS ]   ;
       
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

  reg                                         mmc__mrc__valid_e1   [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ]                                 ;
  reg  [`COMMON_STD_INTF_CNTL_RANGE      ]    mmc__mrc__cntl_e1    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ]                                 ;
  reg                                         mrc__mmc__ready_d1   [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ]                                 ;
  reg  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]    mmc__mrc__data_e1    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] ;

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
  reg                                            dfi__mmc__init_done_d1                                                              ;
  reg   [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      dfi__mmc__data_d1       [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] ;
  reg                                            dfi__mmc__valid_d1      [`MGR_DRAM_NUM_CHANNELS ]                                   ;
  always @(posedge clk)
    begin
      dfi__mmc__init_done_d1  <=  dfi__mmc__init_done ;
    end

  always @(posedge clk)
    begin
      for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
        begin: from_dfi_valid
          dfi__mmc__valid_d1 [chan]  <=  dfi__mmc__valid [chan] ;
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

  reg                                            mmc__dfi__cs_e1         [`MGR_DRAM_NUM_CHANNELS ]                                   ;
  reg                                            mmc__dfi__cmd0_e1       [`MGR_DRAM_NUM_CHANNELS ]                                   ;
  reg                                            mmc__dfi__cmd1_e1       [`MGR_DRAM_NUM_CHANNELS ]                                   ;
  reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mmc__dfi__bank_e1       [`MGR_DRAM_NUM_CHANNELS ]                                   ;
  reg   [ `MGR_DRAM_ADDRESS_RANGE         ]      mmc__dfi__addr_e1       [`MGR_DRAM_NUM_CHANNELS ]                                   ;
  reg   [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__dfi__data_e1       [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] ;

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
        reg                                            write        ;
        wire                                           pipe_valid   ;
        reg                                            pipe_read    ;

        wire  [ `COMMON_STD_INTF_CNTL_RANGE     ]      pipe_cntl     ;
        wire  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      pipe_channel  ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      pipe_bank     ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      pipe_page     ;
        wire  [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      pipe_word     ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE
          wire  [ `MGR_DRAM_LINE_ADDRESS_RANGE  ]      pipe_line     ;
        `endif

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_REQUEST_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_REQUEST_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ({mrc__mmc__cntl_d1 [strm], mrc__mmc__channel_d1 [strm], mrc__mmc__bank_d1 [strm], mrc__mmc__page_d1 [strm], mrc__mmc__word_d1 [strm]}),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid            ),
                                .pipe_data        ({pipe_cntl, pipe_channel, pipe_bank, pipe_page, pipe_word}),
                                .pipe_read        ( pipe_read             ),

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
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    channel_bank_open_page       [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`MGR_DRAM_NUM_BANKS_VECTOR_RANGE ]    channel_bank_a_page_is_open  [`MGR_DRAM_NUM_CHANNELS]                          ;
  //reg  [`MGR_DRAM_NUM_BANKS_VECTOR_RANGE ]    set_a_page_is_open           [`MGR_DRAM_NUM_CHANNELS]                          ;
  //reg  [`MGR_DRAM_NUM_BANKS_VECTOR_RANGE ]    clear_a_page_is_open         [`MGR_DRAM_NUM_CHANNELS]                          ;
  //reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    opening_page_id              [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
                                         
  reg                                         access_request_valid         [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`MGR_NUM_OF_STREAMS_RANGE        ]    access_request_strm          [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE      ]    access_request_cmd           [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    access_request_page          [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg                                         can_go                       [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg                                         adjacent_bank_request        [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;

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
        
            reg                                     chan_bank_request_valid         ;
            reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE  ]   chan_bank_request_cmd           ;
            reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE ]   chan_bank_request_page          ;
            reg                                     chan_bank_adjacent_bank_request ;

            wire                                    chan_bank_can_go                ;

            always @(posedge clk)
              begin
                a_page_is_open  <= ( reset_poweron                                                     )  ? 1'b0           :
                                   ((chan_bank_request_cmd == `DRAM_ACC_CMD_IS_PO ) && chan_bank_can_go)  ? 1'b1           :
                                   ((chan_bank_request_cmd == `DRAM_ACC_CMD_IS_PC ) && chan_bank_can_go)  ? 1'b0           :
                                                                                                            a_page_is_open ; 
        
                open_page_id    <= ( reset_poweron                                                     )  ? {`MGR_DRAM_PAGE_ADDRESS_WIDTH {1'b1 }} :
                                   ((chan_bank_request_cmd == `DRAM_ACC_CMD_IS_PO ) && chan_bank_can_go)  ? chan_bank_request_page                 :
                                   ((chan_bank_request_cmd == `DRAM_ACC_CMD_IS_PC ) && chan_bank_can_go)  ? {`MGR_DRAM_PAGE_ADDRESS_WIDTH {1'b1 }} :
                                                                                                            open_page_id                           ; 
              end

            //----------------------------------------------------------------------------------------------------
            //Bank Access timer
            // - provide command, timer grants permission to place command in final queue

            dram_access_timer dram_access_timer(

                //-------------------------------
                // Outputs
                .can_go                  ( chan_bank_can_go  ),

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
                chan_bank_request_valid         = access_request_valid  [chan] [bank] ;
                chan_bank_request_cmd           = access_request_cmd    [chan] [bank] ;
                chan_bank_request_page          = access_request_page   [chan] [bank] ;
                chan_bank_adjacent_bank_request = adjacent_bank_request [chan] [bank] ;
              end

            // use because we cannot index the generate with a variable
            always @(*)
              begin
                can_go                      [chan] [bank] = chan_bank_can_go ;
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
  reg  [`MGR_NUM_OF_STREAMS_VECTOR   ]    strm_access_valid    [`MGR_DRAM_NUM_CHANNELS]                        ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE  ]    strm_access_cmd      [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE ]    strm_access_bank     [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE ]    strm_access_page     [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE ]  strm_access_line     [`MGR_DRAM_NUM_CHANNELS] [`MGR_NUM_OF_STREAMS ] ;
  `endif
  reg  [`MGR_NUM_OF_STREAMS_VECTOR   ]    strm_enabled         [`MGR_DRAM_NUM_CHANNELS]                        ;  // channel has granted stream access. Access granted to both streams if accessing different banks
     
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
            wire                                       strm_request_valid   ;  // command to access timer
            wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   strm_request_cmd     ;
            wire  [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   strm_request_bank    ;
            wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   strm_request_page    ;
            wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]   strm_request_chan    ;
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
              wire  [`MGR_DRAM_LINE_ADDRESS_RANGE ]   strm_request_line  ;
            `endif
            //   
            
            always @(*)
              begin
                case (mmc_cntl_cmd_gen_state)
                  
                  `MMC_CNTL_CMD_GEN_WAIT: 
                    // The channel stream select logic will not enable this fsm unless this streams request fifo is requesting this channel
                    mmc_cntl_cmd_gen_state_next =  ( strm_enabled [chan][strm] && ( channel_bank_a_page_is_open[chan][strm_request_bank] && (channel_bank_open_page [chan][strm_request_bank] == strm_request_page))                                    ) ?   `MMC_CNTL_CMD_GEN_LINE_READ  :
                                                   ( strm_enabled [chan][strm] && ( channel_bank_a_page_is_open[chan][strm_request_bank] && (channel_bank_open_page [chan][strm_request_bank] != strm_request_page)) && can_go [chan][strm_request_bank]) ?   `MMC_CNTL_CMD_GEN_LINE_READ  :  // PC accepted, jump right to line read
                                                   ( strm_enabled [chan][strm] && ( channel_bank_a_page_is_open[chan][strm_request_bank] && (channel_bank_open_page [chan][strm_request_bank] != strm_request_page))                                    ) ?   `MMC_CNTL_CMD_GEN_PAGE_CLOSE :
                                                   ( strm_enabled [chan][strm] && (~channel_bank_a_page_is_open[chan][strm_request_bank]                                                                           ) && can_go [chan][strm_request_bank]) ?   `MMC_CNTL_CMD_GEN_LINE_READ  :  // PO accepted, jump right to line read
                                                   ( strm_enabled [chan][strm] && (~channel_bank_a_page_is_open[chan][strm_request_bank]                                                                           )                                    ) ?   `MMC_CNTL_CMD_GEN_PAGE_OPEN  :
                                                                                                                                                                                                                                                              `MMC_CNTL_CMD_GEN_WAIT       ;
       
                  `MMC_CNTL_CMD_GEN_PAGE_CLOSE: 
                    mmc_cntl_cmd_gen_state_next =  ( strm_enabled [chan][strm] && can_go [chan][strm_request_bank]) ? `MMC_CNTL_CMD_GEN_PAGE_OPEN  :
                                                                                                                      `MMC_CNTL_CMD_GEN_PAGE_CLOSE ;
       
                  `MMC_CNTL_CMD_GEN_PAGE_OPEN: 
                    mmc_cntl_cmd_gen_state_next =  ( strm_enabled [chan][strm] && can_go [chan][strm_request_bank]) ? `MMC_CNTL_CMD_GEN_LINE_READ  :
                                                                                                                      `MMC_CNTL_CMD_GEN_PAGE_OPEN  ;
       
       
                  `MMC_CNTL_CMD_GEN_LINE_READ: 
                    mmc_cntl_cmd_gen_state_next =  ( strm_enabled [chan][strm] && can_go [chan][strm_request_bank]) ? `MMC_CNTL_CMD_GEN_WAIT       :
                                                                                                                      `MMC_CNTL_CMD_GEN_LINE_READ  ;
       
                  `MMC_CNTL_CMD_GEN_LINE_WRITE: 
                    mmc_cntl_cmd_gen_state_next =  ( strm_enabled [chan][strm] && can_go [chan][strm_request_bank]) ? `MMC_CNTL_CMD_GEN_WAIT       :
                                                                                                                      `MMC_CNTL_CMD_GEN_LINE_WRITE ;
       
       
                  `MMC_CNTL_CMD_GEN_ERR: 
                    mmc_cntl_cmd_gen_state_next =  `MMC_CNTL_CMD_GEN_ERR       ;
       
                  default:
                    mmc_cntl_cmd_gen_state_next = `MMC_CNTL_CMD_GEN_WAIT ;
              
                endcase // case (mmc_cntl_cmd_gen_state)
              end // always @ (*)

            //--------------------------------------------------
            // Control
            //  - 
            always @(*)
              begin
                request_pipe_read [chan][strm]  = can_go [chan][strm_request_bank] & ((mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_LINE_READ ) | (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_LINE_WRITE )) ;
              end

            //assign  opening_page_id       = request_fifo[strm].pipe_page & {`MGR_DRAM_PAGE_ADDRESS_WIDTH { mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PAGE_OPEN }} ;
            //assign  set_a_page_is_open    = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PAGE_OPEN  ) ;
            //assign  clear_a_page_is_open  = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PAGE_CLOSE ) ;

            // The stream request valid is sent to the channel select logic which in turn will enable this fsm
            //  - stream is valid if waiting and the streams request fifo wants this channel or
            //  - the stream has not yet been granted cache access
            assign  strm_request_valid    = ((mmc_cntl_cmd_gen_state != `MMC_CNTL_CMD_GEN_WAIT ) & (((mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_LINE_READ ) & ~can_go [chan][strm_request_bank]) | ((mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_LINE_WRITE) & ~can_go [chan][strm_request_bank]))) |  // as soon as the line request can go, deassert request
                                            ((mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT ) & request_fifo[strm].pipe_valid && (strm_request_chan == chan)) ;

            assign  strm_request_cmd      = ({`DRAM_ACC_NUM_OF_CMDS_WIDTH {((mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) &&  channel_bank_a_page_is_open[chan][strm_request_bank] && (channel_bank_open_page [chan][strm_request_bank] == strm_request_page))}} & `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_CR) |
                                            ({`DRAM_ACC_NUM_OF_CMDS_WIDTH {((mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) &&  channel_bank_a_page_is_open[chan][strm_request_bank] && (channel_bank_open_page [chan][strm_request_bank] != strm_request_page))}} & `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_PC) |
                                            ({`DRAM_ACC_NUM_OF_CMDS_WIDTH {((mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) && ~channel_bank_a_page_is_open[chan][strm_request_bank]                                                                           )}} & `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_PO) |

                                            ({`DRAM_ACC_NUM_OF_CMDS_WIDTH {(mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PAGE_OPEN                                                                                                                                 )}} & `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_PO) |
                                            ({`DRAM_ACC_NUM_OF_CMDS_WIDTH {(mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PAGE_CLOSE                                                                                                                                )}} & `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_PC) |
                                            ({`DRAM_ACC_NUM_OF_CMDS_WIDTH {(mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_LINE_READ                                                                                                                                 )}} & `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_CR) |
                                            ({`DRAM_ACC_NUM_OF_CMDS_WIDTH {(mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_LINE_WRITE                                                                                                                                )}} & `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_CW)  ;

            assign  strm_request_chan     = request_fifo[strm].pipe_channel ;
            assign  strm_request_bank     = request_fifo[strm].pipe_bank    ;
            assign  strm_request_page     = request_fifo[strm].pipe_page    ;
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
              assign  strm_request_line     = request_fifo[strm].pipe_line    ;
            `endif

            always @(*)
              begin
                strm_access_valid [chan] [strm] = strm_request_valid ;
                strm_access_cmd   [chan] [strm] = strm_request_cmd   ;
                strm_access_bank  [chan] [strm] = strm_request_bank  ;
                strm_access_page  [chan] [strm] = strm_request_page  ;
                `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                  strm_access_line  [chan] [strm] = strm_request_line  ;
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
      begin: channel_strm_select_fsm

        reg [`MMC_CNTL_STRM_SEL_STATE_RANGE ] mmc_cntl_strm_sel_state      ; // state flop
        reg [`MMC_CNTL_STRM_SEL_STATE_RANGE ] mmc_cntl_strm_sel_state_next ;
        
        // State register 
        always @(posedge clk)
          begin
            mmc_cntl_strm_sel_state <= ( reset_poweron ) ? `MMC_CNTL_STRM_SEL_WAIT        :
                                                            mmc_cntl_strm_sel_state_next  ;
          end
        
        //--------------------------------------------------
        // Assumptions:
        //  - 
        //reg   [`MGR_NUM_OF_STREAMS_VECTOR   ]      request_valid                          ;

        always @(*)
          begin
            case (mmc_cntl_strm_sel_state)
              
              // Wait for data from all the sources before transferring to NoC
              //  - we select stream 0  first if streams request together
              //  - maybe add wait state that has knowledge of last stream processed e.g. WAIT_STRM0_LAST -> transiton to STRM10
              `MMC_CNTL_STRM_SEL_WAIT: 
                // let both channel streams continue if they are accessing different banks
                mmc_cntl_strm_sel_state_next =  ( strm_access_valid [chan][0] && strm_access_valid [chan][1] && (strm_access_bank [chan][0] != strm_access_bank [chan][1]) ) ?  `MMC_CNTL_STRM_SEL_STRM01 :  // default to letting stream 0 go first
                                                ( strm_access_valid [chan][0]                                                                                              ) ?  `MMC_CNTL_STRM_SEL_STRM0  :
                                                ( strm_access_valid [chan][1]                                                                                              ) ?  `MMC_CNTL_STRM_SEL_STRM1  :
                                                                                                                                                                                `MMC_CNTL_STRM_SEL_WAIT   ;
      
              `MMC_CNTL_STRM_SEL_STRM0: 
                mmc_cntl_strm_sel_state_next =  ( strm_access_valid [chan][0] && strm_access_valid [chan][1] && (strm_access_bank [chan][0] != strm_access_bank [chan][1]) ) ?  `MMC_CNTL_STRM_SEL_STRM01 :  // if a stream 1 request occured after we transitioned here
                                                (~strm_access_valid [chan][0] && strm_access_valid [chan][1] ) ?  `MMC_CNTL_STRM_SEL_STRM1  :
                                                (~strm_access_valid [chan][0]                                ) ?  `MMC_CNTL_STRM_SEL_WAIT   :
                                                                                                                  `MMC_CNTL_STRM_SEL_STRM0  ;
                                                                                                                                            
              `MMC_CNTL_STRM_SEL_STRM1:                                                                                                     
                mmc_cntl_strm_sel_state_next =  ( strm_access_valid [chan][1] && strm_access_valid [chan][0] && (strm_access_bank [chan][0] != strm_access_bank [chan][1]) ) ?  `MMC_CNTL_STRM_SEL_STRM10 :  // if a stream 0 request occured after we transitioned here
                                                (~strm_access_valid [chan][1] && strm_access_valid [chan][0] ) ?  `MMC_CNTL_STRM_SEL_STRM0  :
                                                (~strm_access_valid [chan][1]                                ) ?  `MMC_CNTL_STRM_SEL_WAIT   :
                                                                                                                  `MMC_CNTL_STRM_SEL_STRM1  ;
                                                                                                                                              
                                                                                                                                              
              // If streams are accessing different banks in the same channel, maintain order in which streams gain access to the channel using the state
              //  - STRM01 - stream 0 is first
              //  - STRM10 - stream 1 is first
              `MMC_CNTL_STRM_SEL_STRM01:                                                                                                      
                mmc_cntl_strm_sel_state_next =  (~strm_access_valid [chan][0] && ~strm_access_valid [chan][1]) ?  `MMC_CNTL_STRM_SEL_SEND1_NEXT   :  // we will send stream0's command then stream1's next
                                                ( strm_access_valid [chan][0] && ~strm_access_valid [chan][1]) ?  `MMC_CNTL_STRM_SEL_STRM0        :  // strm0 was next but strm 1 is done, so let it pass
                                                (~strm_access_valid [chan][0] &&  strm_access_valid [chan][1]) ?  `MMC_CNTL_STRM_SEL_STRM1        : 
                                                                                                                  `MMC_CNTL_STRM_SEL_STRM01       ;
      
              `MMC_CNTL_STRM_SEL_STRM10:                                                                                                    
                mmc_cntl_strm_sel_state_next =  (~strm_access_valid [chan][0] && ~strm_access_valid [chan][1]) ?  `MMC_CNTL_STRM_SEL_SEND0_NEXT   :  // we will send stream1's command then stream0's next
                                                ( strm_access_valid [chan][0] && ~strm_access_valid [chan][1]) ?  `MMC_CNTL_STRM_SEL_STRM0        :
                                                (~strm_access_valid [chan][0] &&  strm_access_valid [chan][1]) ?  `MMC_CNTL_STRM_SEL_STRM1        :
                                                                                                                  `MMC_CNTL_STRM_SEL_STRM10       ;
      
              `MMC_CNTL_STRM_SEL_SEND0_NEXT: 
                mmc_cntl_strm_sel_state_next =  `MMC_CNTL_STRM_SEL_WAIT       ;
      
              `MMC_CNTL_STRM_SEL_SEND1_NEXT: 
                mmc_cntl_strm_sel_state_next =  `MMC_CNTL_STRM_SEL_WAIT       ;
      
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
          begin: strm_enable
            always @(*)
              begin
                strm_enabled  [chan][strm] = ((strm == 0) & (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0)) | ((strm == 1) & (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1)) | (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) | (mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10);
              end
          end

        for (bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank++) 
          begin: bank_access
            always @(*)
              begin
                access_request_valid [chan][bank] = (strm_enabled[chan][0] & (requested_bank[0][chan] == bank)) | 
                                                    (strm_enabled[chan][1] & (requested_bank[1][chan] == bank)) ;
              
                access_request_cmd   [chan][bank] = ( strm_enabled[chan][0] && (strm_access_bank [chan][0] == bank)) ? strm_access_cmd [chan][0] :
                                                    ( strm_enabled[chan][1] && (strm_access_bank [chan][1] == bank)) ? strm_access_cmd [chan][1] : 
                                                                                                                       `DRAM_ACC_CMD_IS_NOP      ;

                access_request_page  [chan][bank] = ( strm_enabled[chan][0] && (strm_access_bank [chan][0] == bank)) ? strm_access_page [chan][0] :
                                                    ( strm_enabled[chan][1] && (strm_access_bank [chan][1] == bank)) ? strm_access_page [chan][1] : 
                                                                                                                       {`MGR_DRAM_PAGE_ADDRESS_WIDTH {1'b1 }} ;  // make clear using all 1's
              end
          end

        reg                                        final_queue_valid        ;  // write to final queue
        reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   final_queue_cmd          ;
        reg   [`MGR_STREAM_ADDRESS_RANGE       ]   final_queue_strm         ;
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   final_queue_bank         ;
        reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   final_queue_page         ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                    
          reg   [`MGR_DRAM_LINE_ADDRESS_RANGE  ]   final_queue_line         ;
        `endif

        reg                                        next_final_queue_valid   ;  // write to final queue after other stream
        reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   next_final_queue_cmd     ;
        reg   [`MGR_STREAM_ADDRESS_RANGE       ]   next_final_queue_strm    ;
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   next_final_queue_bank    ;
        reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   next_final_queue_page    ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE
          reg   [`MGR_DRAM_LINE_ADDRESS_RANGE  ]   next_final_queue_line    ;
        `endif
   
        always @(posedge clk)
          begin
            // FIXME - can make if ~WAIT
            final_queue_valid   <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0 ) /*& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]]) |
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1 ) /*& ~strm_access_valid [chan][1]*/ & can_go [chan][strm_access_bank[chan][1]]) |
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]]) |
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]]) |
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*& ~strm_access_valid [chan][1]*/ & can_go [chan][strm_access_bank[chan][0]]) |
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*& ~strm_access_valid [chan][1]*/ & can_go [chan][strm_access_bank[chan][1]]) ;
                                                    
            final_queue_cmd     <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_cmd [chan][0]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_cmd [chan][1]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_cmd [chan][1]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_cmd [chan][0]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_cmd [chan][0]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_cmd [chan][1]     :
                                                                                                                                                                               `MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_NOP ;
                                                    
            final_queue_strm    <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? 'd0     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? 'd1     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? 'd1     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? 'd0     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? 'd0     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? 'd1     :
                                                                                                                                                                               'd0     ;

            final_queue_bank    <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_bank [chan][0]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_bank [chan][1]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_bank [chan][1]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_bank [chan][0]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_bank [chan][0]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_bank [chan][1]     :
                                                                                                                                                                               'd0                            ;

            final_queue_page    <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_page [chan][0]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_page [chan][1]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_page [chan][1]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_page [chan][0]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_page [chan][0]     :
                                   ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_page [chan][1]     :
                                                                                                                                                                               'd0                            ;

            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
              final_queue_line    <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_line [chan][0]     :
                                     ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_line [chan][1]     :
                                     ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_line [chan][1]     :
                                     ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_line [chan][0]     :
                                     ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] )  ? strm_access_line [chan][0]     :
                                     ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1 ) /*&& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][1]] )  ? strm_access_line [chan][1]     :
                                                                                                                                                                                 'd0                            ;
            `endif
            
          end

        always @(posedge clk)
          begin
            next_final_queue_valid   <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*& ~strm_access_valid [chan][0]*/ & can_go [chan][strm_access_bank[chan][0]] & can_go [chan][strm_access_bank[chan][1]]) |
                                        ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM10) /*& ~strm_access_valid [chan][1]*/ & can_go [chan][strm_access_bank[chan][0]] & can_go [chan][strm_access_bank[chan][1]]) ;
                                                    
            next_final_queue_cmd     <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ )  ? strm_access_cmd [chan][1]    :
                                                                                                                                         strm_access_cmd [chan][0]    ;
                                                                                                  
            next_final_queue_strm    <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ )  ? 'd1    :
                                                                                                                                         'd0    ;
                                                                                                  
            next_final_queue_bank    <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ )  ? strm_access_bank[chan][1]    :
                                                                                                                                         strm_access_bank[chan][0]    ;
                                                                                                  
            next_final_queue_page    <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ )  ? strm_access_page[chan][1]    :
                                                                                                                                         strm_access_page[chan][0]    ;

            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
              next_final_queue_line    <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM01) /*&& ~strm_access_valid [chan][0]*/ )  ? strm_access_line[chan][1]  :
                                                                                                                                           strm_access_line[chan][0]  ;
            `endif
            
          end

        always @(posedge clk)
          begin
            chan_final_queue_valid   [chan]   <=  final_queue_valid | next_final_queue_valid ;

            chan_final_queue_cmd     [chan]   <=  ( final_queue_valid      )  ? final_queue_cmd      : 
                                                  ( next_final_queue_valid )  ? next_final_queue_cmd : 
                                                                                final_queue_cmd      ; 

            chan_final_queue_strm    [chan]   <=  ( final_queue_valid      )  ? final_queue_strm     : 
                                                  ( next_final_queue_valid )  ? next_final_queue_strm: 
                                                                                final_queue_strm     ; 

            chan_final_queue_bank    [chan]   <=  ( final_queue_valid      )  ? final_queue_bank     : 
                                                  ( next_final_queue_valid )  ? next_final_queue_bank: 
                                                                                final_queue_bank     ; 

            chan_final_queue_page    [chan]   <=  ( final_queue_valid      )  ? final_queue_page     : 
                                                  ( next_final_queue_valid )  ? next_final_queue_page: 
                                                                                final_queue_page     ; 

            `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                    
              chan_final_queue_line    [chan]   <=  ( final_queue_valid      )  ? final_queue_line     : 
                                                    ( next_final_queue_valid )  ? next_final_queue_line: 
                                                                                  final_queue_line     ; 
            `endif
          end

      end
  endgenerate


/*

  // Examine state of stream FSMs and set channel bank/page state
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: set_chan_bank
        always @(*)
          begin
            for (int bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
              begin
                opening_page_id      [chan][bank] =   'd0   ;
                set_a_page_is_open   [chan][bank] =  1'b0   ;
                clear_a_page_is_open [chan][bank] =  1'b0   ;
              end
            // [channel:0] 
            case({chan_cmd_gen_fsm[chan].strm[0].set_a_page_is_open, chan_cmd_gen_fsm[chan].strm[1].set_a_page_is_open})
              2'b01:
                begin
                  opening_page_id      [chan][request_fifo[1].pipe_bank] =  request_fifo[1].pipe_page ;
                  set_a_page_is_open   [chan][request_fifo[1].pipe_bank] =  1'b1                      ;
                end
      
              2'b10:
                begin
                  opening_page_id      [chan][request_fifo[1].pipe_bank] =  request_fifo[1].pipe_page ;
                  set_a_page_is_open   [chan][request_fifo[1].pipe_bank] =  1'b1                      ;
                end
      
            endcase
          end
      end
  endgenerate
*/

  
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Final command fifos
  // - for page and cache commands, keep a free-running fifo charged with NOPs or CMDs along with bank and address
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
        wire                                                     pipe_read             ;

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


        mmc_final_queue #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_WIDTH       )
                        ) mmc_final_queue (
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
                case ({chan_final_queue_valid [chan], chan_final_queue_cmd [chan]})  // synopsys parallel_case
                
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
        wire                                                      pipe_peek_valid       ;
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   pipe_peek_data        ;
        wire                                                      pipe_peek_twoIn_valid ;
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   pipe_peek_twoIn_data  ;
        wire                                                      pipe_valid            ;
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   pipe_data             ;
        wire                                                      pipe_read             ;
                                                                                        
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
      

        mmc_final_queue #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH                 ),
                          .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_CACHE_CMD_FINAL_FIFO_ALMOST_FULL_THRESHOLD ),
                          .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_WIDTH       )
                        ) mmc_final_queue (
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
                case ({chan_final_queue_valid [chan], chan_final_queue_cmd [chan]})  // synopsys parallel_case
                
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

  // FIXME
  assign   final_page_cmd_fifo[0].pipe_read   = final_page_cmd_fifo[0].pipe_valid ;
  assign   final_page_cmd_fifo[1].pipe_read   = final_page_cmd_fifo[0].pipe_valid ;

  assign   final_cache_cmd_fifo[0].pipe_read  = final_page_cmd_fifo[0].pipe_valid ;
  assign   final_cache_cmd_fifo[1].pipe_read  = final_page_cmd_fifo[0].pipe_valid ;


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

                          // From the WAIT state, the next state can be either a page command or a page command with write data
                          // so if the RW command fifo isnt empty and the RW command is a write, we need to read the target data fifo based on the
                          // "peeked" RW bank address

                          if (final_cache_cmd_fifo[chan].pipe_peek_twoIn_valid &&  ((final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CR ) || (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP )))
                            begin
                              mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                            end
                          else if (final_cache_cmd_fifo[chan].pipe_peek_twoIn_valid &&  (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW ) )
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
                    
                        if (final_cache_cmd_fifo[chan].pipe_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP )  // queue has data but the next RW is not a valid RW command
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
                    
                        if(!final_page_cmd_fifo[chan].pipe_valid)  // empty
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
                        //`SCH_DRIVER_READ_FINAL_QUEUES 
                    
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
 
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //
  endmodule 
  
