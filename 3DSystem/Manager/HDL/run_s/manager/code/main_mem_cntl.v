/*********************************************************************************************

    File name   : main_mem_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

    Description : Take memory requests from mrc(s) and access dram
                  
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

            //------------------------------------------------------------------------------------------------------------------------
            // Main Memory Controller interface
            //
            //-----------------------------------------------------------------------
            // Read Interface(s)
            input   wire  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]                                xxx__mmc__valid                                ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE           ]                                xxx__mmc__cntl    [`MMC_CNTL_NUM_OF_INTF ]     ,
            input   wire  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]                                xxx__mmc__read                                 ,
            output  reg   [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]                                mmc__xxx__ready                                ,
            input   wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE       ]                                xxx__mmc__channel [`MMC_CNTL_NUM_OF_INTF ]     ,
            input   wire  [`MGR_DRAM_BANK_ADDRESS_RANGE          ]                                xxx__mmc__bank    [`MMC_CNTL_NUM_OF_INTF ]     ,
            input   wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE          ]                                xxx__mmc__page    [`MMC_CNTL_NUM_OF_INTF ]     ,
            input   wire  [`MGR_DRAM_WORD_ADDRESS_RANGE          ]                                xxx__mmc__word    [`MMC_CNTL_NUM_OF_INTF ]     ,
                                                                                     
            //-----------------------------------------------------------------------
            // Read Data Interface(s)
            // MMC provides data from each DRAM channel          
            // - response must be in order of request            
            output  reg   [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE  ]                                 mmc__xxx__valid   [`MGR_DRAM_NUM_CHANNELS    ]                               ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE           ]                                 mmc__xxx__cntl    [`MGR_DRAM_NUM_CHANNELS    ] [`MMC_CNTL_NUM_OF_READ_INTF ] ,
            input   wire  [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE  ]                                 xxx__mmc__ready   [`MGR_DRAM_NUM_CHANNELS    ]                               ,
            output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE  ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   mmc__xxx__data    [`MGR_DRAM_NUM_CHANNELS    ] [`MMC_CNTL_NUM_OF_READ_INTF ] ,

            //----------------------------------------------------------------------- 
            // Write Data Interface(s)
            //
            // Data associated with request (note: dont forget it needs to be in the same order as the request)
            input   wire  [`MMC_CNTL_NUM_OF_WRITE_INTF_VEC_RANGE ]                                 xxx__mmc__data_valid                                   ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE           ]                                 xxx__mmc__data_cntl    [`MMC_CNTL_NUM_OF_WRITE_INTF ]  ,
            input   wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE       ]                                 xxx__mmc__data_channel [`MMC_CNTL_NUM_OF_WRITE_INTF ]  ,
            input   wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE  ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  xxx__mmc__data         [`MMC_CNTL_NUM_OF_WRITE_INTF ]  ,
            input   wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE  ]                                 xxx__mmc__data_mask    [`MMC_CNTL_NUM_OF_WRITE_INTF ]  ,
            output  reg   [`MMC_CNTL_NUM_OF_WRITE_INTF_VEC_RANGE ]                                 mmc__xxx__data_ready                                   ,

            //------------------------------------------------------------------------------------------------------------------------
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

  
            //------------------------------------------------------------------------------------------------------------------------
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

  reg   [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE ]      xxx__mmc__valid_d1                              ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE     ]      xxx__mmc__cntl_d1    [`MMC_CNTL_NUM_OF_INTF ]   ;
  reg   [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE ]      xxx__mmc__read_d1                               ;
  reg   [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE ]      mmc__xxx__ready_e1                              ;
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      xxx__mmc__channel_d1 [`MMC_CNTL_NUM_OF_INTF ]   ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]      xxx__mmc__bank_d1    [`MMC_CNTL_NUM_OF_INTF ]   ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]      xxx__mmc__page_d1    [`MMC_CNTL_NUM_OF_INTF ]   ;
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE    ]      xxx__mmc__word_d1    [`MMC_CNTL_NUM_OF_INTF ]   ;
       
  always @(posedge clk) 
    begin
      for (int intf=0; intf<`MMC_CNTL_NUM_OF_INTF ; intf++)
        begin: mem_request
          xxx__mmc__valid_d1   [intf ]  <=   ( reset_poweron   ) ? 'd0  :  xxx__mmc__valid    [intf ] ; 
          xxx__mmc__cntl_d1    [intf ]  <=   ( reset_poweron   ) ? 'd0  :  xxx__mmc__cntl     [intf ] ; 
          xxx__mmc__read_d1    [intf ]  <=   ( reset_poweron   ) ? 'd0  :  xxx__mmc__read     [intf ] ; 
          mmc__xxx__ready      [intf ]  <=   ( reset_poweron   ) ? 'd0  :  mmc__xxx__ready_e1 [intf ] ; 
          xxx__mmc__channel_d1 [intf ]  <=   ( reset_poweron   ) ? 'd0  :  xxx__mmc__channel  [intf ] ; 
          xxx__mmc__bank_d1    [intf ]  <=   ( reset_poweron   ) ? 'd0  :  xxx__mmc__bank     [intf ] ; 
          xxx__mmc__page_d1    [intf ]  <=   ( reset_poweron   ) ? 'd0  :  xxx__mmc__page     [intf ] ; 
          xxx__mmc__word_d1    [intf ]  <=   ( reset_poweron   ) ? 'd0  :  xxx__mmc__word     [intf ] ; 
        end
    end

  //--------------------------------------------------
  // Memory Read response data
  //
  reg  [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE ]                                   mmc__xxx__valid_e1   [`MGR_DRAM_NUM_CHANNELS ]                        ;
  reg  [`COMMON_STD_INTF_CNTL_RANGE          ]                                   mmc__xxx__cntl_e1    [`MGR_DRAM_NUM_CHANNELS ] [`MMC_CNTL_NUM_OF_READ_INTF ] ;
  reg  [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE ]                                   xxx__mmc__ready_d1   [`MGR_DRAM_NUM_CHANNELS ]                        ;
  reg  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]    mmc__xxx__data_e1    [`MGR_DRAM_NUM_CHANNELS ] [`MMC_CNTL_NUM_OF_READ_INTF ] ;

  genvar chan, rd_intf, word, bank ;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: mem_response
        for (rd_intf=0; rd_intf<`MMC_CNTL_NUM_OF_READ_INTF ; rd_intf++)
          begin: mem_response
            always @(posedge clk)
              begin
                mmc__xxx__valid    [chan] [rd_intf ] <=   ( reset_poweron   ) ? 'd0  :  mmc__xxx__valid_e1 [chan] [rd_intf ] ; 
                mmc__xxx__cntl     [chan] [rd_intf ] <=                                 mmc__xxx__cntl_e1  [chan] [rd_intf ] ; 
                xxx__mmc__ready_d1 [chan] [rd_intf ] <=                                 xxx__mmc__ready    [chan] [rd_intf ] ; 
              end
            for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
              begin: mem_response
                always @(posedge clk)
                  begin
                    mmc__xxx__data     [chan] [rd_intf] [word] <=   mmc__xxx__data_e1  [chan] [rd_intf] [word] ; 
                  end
              end
          end
      end
  endgenerate

  //--------------------------------------------------
  // Memory Write data
  //
  // Data associated with request (note: dont forget it needs to be in the same order as the request)
  reg   [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE ]                                 xxx__mmc__data_valid_d1                                   ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE          ]                                 xxx__mmc__data_cntl_d1    [`MMC_CNTL_NUM_OF_WRITE_INTF ]  ;
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 xxx__mmc__data_channel_d1 [`MMC_CNTL_NUM_OF_WRITE_INTF ]  ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  xxx__mmc__data_d1         [`MMC_CNTL_NUM_OF_WRITE_INTF ]  ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ]                                 xxx__mmc__data_mask_d1    [`MMC_CNTL_NUM_OF_WRITE_INTF ]  ;
  wire  [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE ]                                 mmc__xxx__data_ready_e1                                   ;

  genvar wr_intf ;
  generate
    for (wr_intf=0; wr_intf<`MMC_CNTL_NUM_OF_WRITE_INTF ; wr_intf++)
      begin: mem_write_data
        always @(posedge clk)
          begin
            xxx__mmc__data_valid_d1   [wr_intf ] <=   ( reset_poweron   ) ? 'd0  :  xxx__mmc__data_valid    [wr_intf ] ; 
            xxx__mmc__data_channel_d1 [wr_intf ] <=                                 xxx__mmc__data_channel  [wr_intf ] ; 
            mmc__xxx__data_ready      [wr_intf ] <=                                 mmc__xxx__data_ready_e1 [wr_intf ] ; 
          end
        for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
          begin: mem_response
            always @(posedge clk)
              begin
                xxx__mmc__data_d1      [wr_intf ] [word] <=   xxx__mmc__data      [wr_intf] [word] ; 
                xxx__mmc__data_mask_d1 [wr_intf ] [word] <=   xxx__mmc__data_mask [wr_intf] [word] ; 
              end
          end
      end
  endgenerate


  //----------------------------------------------------------------------- 
  // - DFI will handle SDR->DDR conversion
  reg                                                                          dfi__mmc__init_done_d1                            ;
  reg                                                                          dfi__mmc__valid_d1      [`MGR_DRAM_NUM_CHANNELS ] ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE        ]                                  dfi__mmc__cntl_d1       [`MGR_DRAM_NUM_CHANNELS ] ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]  dfi__mmc__data_d1       [`MGR_DRAM_NUM_CHANNELS ] ;

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
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]  mmc__dfi__data_e1   [`MGR_DRAM_NUM_CHANNELS ]  ;

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

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Write Data
  //

  generate
    for (wr_intf=0; wr_intf<`MMC_CNTL_NUM_OF_WRITE_INTF ; wr_intf=wr_intf+1) 
      begin: write_data_fifo

        wire                                                 clear        ;
        wire                                                 almost_full  ;
        wire                                                 empty        ;

        wire                                                 write        ;
        wire  [`MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_RANGE   ]   write_data   ;

        wire                                                 read         ;
        wire  [`MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_RANGE   ]   read_data    ;

        generic_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_FROM_MWC_FIFO_DEPTH                 ),
                       .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_FROM_MWC_FIFO_ALMOST_FULL_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_WIDTH       )
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

        assign clear = 1'b0 ;

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        always @(posedge clk)
          begin
            fifo_pipe_valid <= ( reset_poweron      ) ? 'b0               :
                               ( read               ) ? 'b1               :
                               ( fifo_pipe_read     ) ? 'b0               :
                                                         fifo_pipe_valid  ;
          end

        reg                                                  pipe_valid   ;
        wire                                                 pipe_read    ;
        reg   [`MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_RANGE   ]   pipe_data    ;

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

        reg pipe_has_two  ;
        always @(*)
          begin
            pipe_has_two  =  pipe_valid & fifo_pipe_valid ; // need two lines before we initiates a write
          end

      end
  endgenerate


  reg  [`MMC_CNTL_NUM_OF_WRITE_INTF_VEC_RANGE ]   strm_write_data_read [`MGR_DRAM_NUM_CHANNELS ]  ;

  generate
    for (wr_intf=0; wr_intf<`MMC_CNTL_NUM_OF_WRITE_INTF ; wr_intf++)
      begin : wr_data_to_fifo
        assign write_data_fifo[wr_intf].write_data [`MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_RANGE ]  = xxx__mmc__data_cntl_d1 [wr_intf]  ;
        assign write_data_fifo[wr_intf].write_data [`MMC_CNTL_FROM_MWC_AGGREGATE_MASK_RANGE ]  = xxx__mmc__data_mask_d1 [wr_intf]  ;

        for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
          begin: mmc_fifo_data
            assign write_data_fifo[wr_intf].write_data [(word+1)*`MGR_EXEC_LANE_WIDTH-1 : word*`MGR_EXEC_LANE_WIDTH]   = xxx__mmc__data_d1 [wr_intf][word] ;
          end

        assign write_data_fifo[wr_intf].write   =   xxx__mmc__data_valid_d1 [wr_intf]       ;
        assign  mmc__xxx__data_ready_e1 [wr_intf]  =  ~write_data_fifo[wr_intf].almost_full ;

        //assign write_data_fifo[wr_intf].pipe_read = write_data_fifo[wr_intf].pipe_valid ; // FIXME sdp__xxx__get_next_line[wr_intf] ;  
        assign write_data_fifo[wr_intf].pipe_read =  strm_write_data_read [0][wr_intf] | strm_write_data_read [0][wr_intf]; // either channel might read fifo
      end
  endgenerate

  wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   write_data_fifo_output_data [`MMC_CNTL_NUM_OF_WRITE_INTF ] ;
  generate
    for (wr_intf=0; wr_intf<`MMC_CNTL_NUM_OF_WRITE_INTF ; wr_intf++)
      begin : wr_data_fifo_output
        for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
          begin: mmc_fifo_data
            assign write_data_fifo_output_data [wr_intf][word]  =  write_data_fifo[wr_intf].pipe_data[(word+1)*`MGR_EXEC_LANE_WIDTH-1 : word*`MGR_EXEC_LANE_WIDTH] ;
          end
      end
  endgenerate


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Request input FIFO

  // Remember, cannot use a variable to index into a generate, so create a variable outside the generate, set that variable inside the generate and index the variable with a variable
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE        ]   requested_bank       [`MMC_CNTL_NUM_OF_INTF] [`MGR_DRAM_NUM_CHANNELS] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]   requested_page       [`MMC_CNTL_NUM_OF_INTF] [`MGR_DRAM_NUM_CHANNELS] ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE      ]   requested_line       [`MMC_CNTL_NUM_OF_INTF] [`MGR_DRAM_NUM_CHANNELS] ;
  `endif
  reg  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   request_valid        [`MMC_CNTL_NUM_OF_INTF]                          ;
  reg  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE     ]   request_pipe_read                            [`MGR_DRAM_NUM_CHANNELS] ;

  genvar intf;
  generate
    for (intf=0; intf<`MMC_CNTL_NUM_OF_INTF ; intf=intf+1) 
      begin: request_fifo

        wire  clear        ;
        wire  almost_full  ;
        reg                                                 write          ;
        reg   [`MMC_CNTL_REQUEST_AGGREGATE_FIFO_RANGE ]     write_data     ;
        wire                                                pipe_valid     ;
        reg                                                 pipe_read      ;
                                                      
        wire  [`MMC_CNTL_REQUEST_AGGREGATE_FIFO_RANGE ]     pipe_data     ;
        reg   [ `COMMON_STD_INTF_CNTL_RANGE           ]     pipe_cntl     ;
        reg                                                 pipe_is_read  ;
        reg                                                 pipe_is_write ;
        reg   [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE       ]     pipe_channel  ;
        reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE          ]     pipe_bank     ;
        reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE          ]     pipe_page     ;
        reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE          ]     pipe_word     ;
        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE              
          wire  [ `MGR_DRAM_LINE_ADDRESS_RANGE        ]     pipe_line     ;
        `endif


        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_REQUEST_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_REQUEST_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH       )
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
 
        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM); 
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM);

        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
          assign pipe_line = pipe_word [`MGR_DRAM_LINE_IN_WORD_ADDRESS_RANGE ] ;
        `endif


        // Note: couldnt do this with net and assign, had to use procedural block and reg
        for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
          begin
            always @(*)
              begin
                request_valid  [intf] [chan]    = pipe_valid & (pipe_channel == chan) ;
                requested_bank [intf] [chan]    = pipe_bank                           ;
                requested_page [intf] [chan]    = pipe_page                           ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                      
                  requested_line [intf] [chan]  = pipe_line                           ;
                `endif
              end
          end

        always @(*)
          begin
            {pipe_cntl, pipe_is_read, pipe_is_write, pipe_channel, pipe_bank, pipe_page, pipe_word} = pipe_data;
          end

      end
  endgenerate

  // connect request fifo
  generate
    for (intf=0; intf<`MMC_CNTL_NUM_OF_INTF ; intf=intf+1) 
      begin: request_fifo_ready
        always @(*)
          begin
            if (intf == 2)
              begin
                mmc__xxx__ready_e1 [intf]       = ~request_fifo[intf].almost_full  ;
                request_fifo[intf].write        =  xxx__mmc__valid_d1 [intf]          ;
                request_fifo[intf].pipe_read    =  request_pipe_read [0] [intf] | request_pipe_read [1] [intf] ; // read if either channel stream is reading e.g. mutually exclusive
                //                                                               ****  rd                      wr  ****
                request_fifo[intf].write_data   =  { xxx__mmc__cntl_d1 [intf], xxx__mmc__read_d1 [intf],~xxx__mmc__read_d1 [intf], xxx__mmc__channel_d1 [intf], xxx__mmc__bank_d1 [intf], xxx__mmc__page_d1 [intf], xxx__mmc__word_d1 [intf]} ;
              end
            else
              begin
                mmc__xxx__ready_e1 [intf]       = ~request_fifo[intf].almost_full              ;
                request_fifo[intf].write        =  xxx__mmc__valid_d1 [intf]                   ;
                request_fifo[intf].pipe_read    =  request_pipe_read [0] [intf] | request_pipe_read [1] [intf] ; // read if either channel stream is reading e.g. mutually exclusive
                //                                                               ****  rd                      wr  ****
                request_fifo[intf].write_data   =  { xxx__mmc__cntl_d1 [intf], xxx__mmc__read_d1 [intf],~xxx__mmc__read_d1 [intf], xxx__mmc__channel_d1 [intf], xxx__mmc__bank_d1 [intf], xxx__mmc__page_d1 [intf], xxx__mmc__word_d1 [intf]} ;
              end
          end
      end
  endgenerate


//// /* experiment with above assign issue 
////  generate
////    for (strm=0; strm<`MMC_CNTL_NUM_OF_INTF ; strm++)
////      begin
////        always @(*)
////          begin
////            request_valid  [strm] [request_fifo[strm].pipe_channel] = request_fifo[strm].pipe_valid ;
////            requested_bank [strm] [request_fifo[strm].pipe_channel] = request_fifo[strm].pipe_bank  ;
////            requested_page [strm] [request_fifo[strm].pipe_channel] = request_fifo[strm].pipe_page  ;
////          end
////      end
////  endgenerate
////        */

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Open Page registers
  //  - contains page open status
  //  - contains dram access timer for bank

  // Remember, cannot use a variable to index into a generate, so create a variable outside the generate, set that variable inside the generate and index the variable with a variable
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    channel_bank_open_page        [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`MGR_DRAM_NUM_BANKS_VECTOR_RANGE ]    channel_bank_a_page_is_open   [`MGR_DRAM_NUM_CHANNELS]                          ;
                                         
  // Set the page status. Either stream can set the page status but only one will be activve at a time
  // So genearte the page status by ORing the access_set_valid [chan][bank]
  reg  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE  ]    access_set_valid              [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]                       ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE      ]    access_set_cmd                [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ] [`MMC_CNTL_NUM_OF_INTF ] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]    access_set_page               [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ] [`MMC_CNTL_NUM_OF_INTF ] ;

  // The checker fsm will check page and cache commands separately but never to the same bank at the same time
  // So the checker will or the requests
  reg                                         page_cmd_grant_request_valid  [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE      ]    page_cmd_grant_request_cmd    [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;

  reg                                         cache_cmd_grant_request_valid [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE      ]    cache_cmd_grant_request_cmd   [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;

  reg  [`DRAM_ACC_NUM_OF_CMDS_VECTOR     ]    cmd_can_go                    [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS  ]  ;
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
            reg                                     chan_bank_adjacent_bank_request ;

            wire  [`DRAM_ACC_NUM_OF_CMDS_VECTOR ]   chan_bank_cmd_can_go            ; // vector in order of DRAM_ACC_CMD_IS_*
            //wire                                    chan_bank_can_go_valid          ;
            //wire                                    chan_bank_can_go                ;
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
                .cmd_can_go              ( chan_bank_cmd_can_go    ),
                //.can_go                  ( chan_bank_can_go        ),
                //.can_go_valid            ( chan_bank_can_go_valid  ),
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

                chan_bank_adjacent_bank_request = adjacent_bank_request [chan] [bank] ;
              end

            // The CMD_SEQ fsm sets the page status at the end of the sequence
            always @(*)
              begin
                chan_bank_set_valid         = |access_set_valid  [chan] [bank] ; // either stream

                chan_bank_set_cmd           = access_set_valid  [chan] [bank] [0] ? access_set_cmd  [chan] [bank] [0] :
                                              access_set_valid  [chan] [bank] [1] ? access_set_cmd  [chan] [bank] [1] :
                                                                                    access_set_cmd  [chan] [bank] [2] ;             

                chan_bank_set_page          = access_set_valid  [chan] [bank] [0] ? access_set_page [chan] [bank] [0] :
                                              access_set_valid  [chan] [bank] [1] ? access_set_page [chan] [bank] [1] :
                                                                                    access_set_page [chan] [bank] [2] ;             
              end

            // use because we cannot index the generate with a variable
            always @(*)
              begin
                cmd_can_go                  [chan] [bank] = chan_bank_cmd_can_go                      ;
                //can_go                      [chan] [bank] = chan_bank_can_go & chan_bank_can_go_valid ;
                can_go_checker_ready        [chan] [bank] = chan_bank_checker_ready                   ;
                channel_bank_a_page_is_open [chan] [bank] = a_page_is_open                            ; 
                channel_bank_open_page      [chan] [bank] = open_page_id                              ; 
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
  reg  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]    strm_access_request         [`MGR_DRAM_NUM_CHANNELS]                          ;
  reg  [`DRAM_ACC_NUM_OF_CMDS_RANGE           ]    strm_access_cmd             [`MGR_DRAM_NUM_CHANNELS] [`MMC_CNTL_NUM_OF_INTF ] ;
  reg  [`DRAM_ACC_SEQ_TYPE_RANGE              ]    strm_access_sequence        [`MGR_DRAM_NUM_CHANNELS] [`MMC_CNTL_NUM_OF_INTF ] ;
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE          ]    strm_access_bank            [`MGR_DRAM_NUM_CHANNELS] [`MMC_CNTL_NUM_OF_INTF ] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE          ]    strm_access_page            [`MGR_DRAM_NUM_CHANNELS] [`MMC_CNTL_NUM_OF_INTF ] ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                             
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE        ]    strm_access_line            [`MGR_DRAM_NUM_CHANNELS] [`MMC_CNTL_NUM_OF_INTF ] ;
  `endif                                                                       
                                                                               
  // The select FSM will use this signal to complete a selection               
  reg  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]    strm_access_done            [`MGR_DRAM_NUM_CHANNELS]                          ;
  
  // The select FSM will use these registered values to make decisions whilst a request is being processed 
  reg  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]    strm_is_read_latched        [`MGR_DRAM_NUM_CHANNELS]                          ;
  reg  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]    strm_is_write_latched       [`MGR_DRAM_NUM_CHANNELS]                          ;
                                                                               
  reg  [`MGR_DRAM_BANK_ADDRESS_RANGE          ]    strm_bank_latched           [`MGR_DRAM_NUM_CHANNELS] [`MMC_CNTL_NUM_OF_INTF ] ;
  reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE          ]    strm_page_latched           [`MGR_DRAM_NUM_CHANNELS] [`MMC_CNTL_NUM_OF_INTF ] ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                             
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE        ]    strm_line_latched           [`MGR_DRAM_NUM_CHANNELS] [`MMC_CNTL_NUM_OF_INTF ] ;
  `endif                                                                       
                                                                               
  reg  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]    strm_enable                 [`MGR_DRAM_NUM_CHANNELS]                          ;  // Channel has granted stream access. Access granted to both streams if accessing different banks
  reg  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]    strm_enable_e1              [`MGR_DRAM_NUM_CHANNELS]                          ;  
  reg  [`MMC_CNTL_CMD_GEN_TAG_RANGE           ]    strm_tag                    [`MGR_DRAM_NUM_CHANNELS]                          ;  // This tag goes with page and cache commands generate by a strm fsm
                                                                                                                                   // The tag may prove useful is we experience ordering deadlock 
  reg  [`DRAM_ACC_SEQ_TYPE_RANGE              ]    strm_seq_type               [`MGR_DRAM_NUM_CHANNELS]                          ;  
     
  // Write 
  reg  [`MMC_CNTL_NUM_OF_INTF_VEC_RANGE       ]    strm_write_data_available   [`MGR_DRAM_NUM_CHANNELS]                          ;

  // When we place a PC in the sequence fifo, we also write how many CWs/CRs were in the cache sequence FIFO prior to this PC. We will call this the cache counter or CCi.
  // As we encounter CRs/CWs at the output of the cache sequence FIFO, we increment another counter, we will call that the CCo. 
  // When we encounter a PC at the output of the sequence FIFO, we compare CCi vs CCo. If CCi > CCo the PC must stall.
  //
  reg   [`MMC_CNTL_CMD_GEN_OP_COUNT_RANGE     ]   po_counter_in                [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS ] ;
  reg   [`MMC_CNTL_CMD_GEN_OP_COUNT_RANGE     ]   cache_counter_in             [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS ] ;
  reg   [`MMC_CNTL_CMD_GEN_OP_COUNT_RANGE     ]   cache_counter_out            [`MGR_DRAM_NUM_CHANNELS] [`MGR_DRAM_NUM_BANKS ] ;

  genvar strm;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: chan_cmd_gen_fsm
        for (strm=0; strm<`MMC_CNTL_NUM_OF_INTF ; strm=strm+1) 
          begin: strm_fsm

            //reg [`MMC_CNTL_CMD_GEN_STATE_RANGE ] mmc_cntl_cmd_gen_state      ; // state flop
            //reg [`MMC_CNTL_CMD_GEN_STATE_RANGE ] mmc_cntl_cmd_gen_state_next ;
            mmc_cntl_cmd_gen_fsm_enum  mmc_cntl_cmd_gen_state      ; // state flop
            mmc_cntl_cmd_gen_fsm_enum  mmc_cntl_cmd_gen_state_next ;
            
            // State register 
            always @(posedge clk)
              begin
                mmc_cntl_cmd_gen_state <= ( reset_poweron ) ? MMC_CNTL_CMD_GEN_WAIT        :
                                                               mmc_cntl_cmd_gen_state_next  ;
              end
            
            //--------------------------------------------------
            // Assumptions:
            //  - 

            // As this fsm determines the command, it requests access to the final queue via the access timer in the
            // bank info genblk
            wire                                       strm_request            ;  // command to stream select fsm
            wire                                       strm_wr_data_available  ;  // 
            wire                                       strm_request_is_read    ;
            wire                                       strm_request_is_write   ;
            wire                                       strm_request_done       ;  // command to access timer
            wire  [`DRAM_ACC_SEQ_TYPE_RANGE        ]   strm_request_sequence   ;
            wire  [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   strm_request_bank       ;
            wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   strm_request_page       ;
            wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]   strm_request_chan       ;
            `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                   
              wire  [`MGR_DRAM_LINE_ADDRESS_RANGE  ]   strm_request_line       ;
            `endif                                                           
            //                                                               
            reg   [`DRAM_ACC_CMD_SEQ_RANGE         ]   strm_cmd_sequence                                               ;
            reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   strm_cmd_sequence_codes         [`DRAM_ACC_CMD_SEQ_MAX_LENGTH ] ;  // contains the actual sequence e.g. {PC, PO, CR, NOP}
            mmc_cntl_cmd_gen_fsm_enum                  strm_cmd_code_state_next                                        ;  // let the code define the enxt state
                                                                                                                       
            reg                                        strm_cmd_write                                                  ;  // write the command to the sequence fifo

            reg                                        update_cci                                                      ;  // increment the cache operation in counter
            reg                                        initialize_cci                                                  ;  // increment the cache operation in counter


            always @(*)
              begin
                case (mmc_cntl_cmd_gen_state)
                  
                  MMC_CNTL_CMD_GEN_WAIT: 
                    // The channel stream select logic will not enable this fsm unless this streams request fifo is requesting this channel
                    mmc_cntl_cmd_gen_state_next =  ( strm_enable [chan][strm] ) ?   MMC_CNTL_CMD_GEN_DECODE_SEQUENCE  :
                                                                                    MMC_CNTL_CMD_GEN_WAIT             ;
       
                  MMC_CNTL_CMD_GEN_DECODE_SEQUENCE: 
                    mmc_cntl_cmd_gen_state_next =  strm_cmd_code_state_next          ;
                                                   //( ~cmd_seq_pc_fifo  [chan].almost_full && ~cmd_seq_po_fifo  [chan].almost_full && ~cmd_seq_cache_fifo [chan].almost_full) ? strm_cmd_code_state_next          :  // a sequence will always contain a page and cache command
                                                   //                                                                                                                            MMC_CNTL_CMD_GEN_DECODE_SEQUENCE ;  // need to add PR (FIXME)

                  //----------------------------------------------------------------------------------------------------
                  // These states are transitory. We write the commands into the sequence fifos
                  // FIXME: These states are mainly for debug and can be consolidated
                  MMC_CNTL_CMD_GEN_POCR: 
                    mmc_cntl_cmd_gen_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                                                                             
                  MMC_CNTL_CMD_GEN_POCW: 
                    mmc_cntl_cmd_gen_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                                                                             
                  MMC_CNTL_CMD_GEN_CR: 
                    mmc_cntl_cmd_gen_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                                                                             
                  MMC_CNTL_CMD_GEN_CW: 
                    mmc_cntl_cmd_gen_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                                                                             
                  MMC_CNTL_CMD_GEN_PCPOCR: 
                    mmc_cntl_cmd_gen_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                                                                             
                  MMC_CNTL_CMD_GEN_PCPOCW: 
                    mmc_cntl_cmd_gen_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                                                                             
                  MMC_CNTL_CMD_GEN_PCPR: 
                    mmc_cntl_cmd_gen_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                                                                             
                  MMC_CNTL_CMD_GEN_PR: 
                    mmc_cntl_cmd_gen_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                                                                             
                  //----------------------------------------------------------------------------------------------------
       
                  MMC_CNTL_CMD_GEN_ERR: 
                    mmc_cntl_cmd_gen_state_next =  MMC_CNTL_CMD_GEN_ERR ;
       
                  default:
                    mmc_cntl_cmd_gen_state_next = MMC_CNTL_CMD_GEN_WAIT ;
              
                endcase // case (mmc_cntl_cmd_gen_state)
              end // always @ (*)


            always @(*)
              begin
                case (strm_cmd_sequence) // synopsys parallel_case
                  `DRAM_ACC_CMD_SEQ_IS_POCR :
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_POCR  ;
                  `DRAM_ACC_CMD_SEQ_IS_POCW :
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_POCW  ;
                  `DRAM_ACC_CMD_SEQ_IS_CR :
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_CR  ;
                  `DRAM_ACC_CMD_SEQ_IS_CW :
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_CW  ;
                  `DRAM_ACC_CMD_SEQ_IS_PCPOCR :
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_PCPOCR  ;
                  `DRAM_ACC_CMD_SEQ_IS_PCPOCW :
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_PCPOCW  ;
                  `DRAM_ACC_CMD_SEQ_IS_PCPR :
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_PCPR  ;
                  `DRAM_ACC_CMD_SEQ_IS_PR :
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_PR  ;
                  `DRAM_ACC_CMD_SEQ_IS_NOP:
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                  default:
                    strm_cmd_code_state_next = MMC_CNTL_CMD_GEN_WAIT ;
                endcase
              end
          //--------------------------------------------------
          // Control
          //  - 

          // The CMD_SEQ fsm sets the page status at the end of the sequence
          for (bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
            begin: set_bank_info
              always @(posedge clk)
                begin
                 if (bank == strm_bank_latched[chan][strm])
                   begin
                     access_set_valid  [chan] [bank] [strm] <= (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_POCR   ) |
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_POCW   ) |
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_CR     ) |
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_CW     ) |
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PCPOCR ) |
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PCPOCW ) |
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PCPR   ) |
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PR     ) ;

                     access_set_cmd    [chan] [bank] [strm] <= (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_POCR   ) ?  `DRAM_ACC_CMD_IS_PO  :
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_POCW   ) ?  `DRAM_ACC_CMD_IS_PO  :
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PCPOCR ) ?  `DRAM_ACC_CMD_IS_PO  :
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PCPOCW ) ?  `DRAM_ACC_CMD_IS_PO  :
                                                               (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_PCPR   ) ?  `DRAM_ACC_CMD_IS_PC  :
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
                strm_cmd_write  = (mmc_cntl_cmd_gen_state != `MMC_CNTL_CMD_GEN_WAIT) & (mmc_cntl_cmd_gen_state != `MMC_CNTL_CMD_GEN_DECODE_SEQUENCE) ;
              end

/*
 * Keep in case generate needs to be reworked
            for (int bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
              begin
                cache_counter_in [chan][bank] <= ( reset_poweron ) ? 'd0 : (bank == strm_request_bank)  ?  cache_counter_in[chan][bank] + 'd1 :  cache_counter_in[chan][bank] ;
              end
*/
            // Remember, the CCI is designed to let the PC command we are about to send how many Cache commands must be accounted for before this PC can execute
            // So we send the previous CCI and then update to reflect how many commands we are introducing.
            // The only sequence that will cause teh CCI to increment are CW or CR. All others, which will be sequences starting with PC or PO will set the CCI for that 
            // bank to '1'
            // 
            // We have already sent the previous CCI, so now update the current CCI to reflect the current commands contribution
            //
            always @(*)
              begin
                for (int bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
                  begin
                    if ((mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_DECODE_SEQUENCE))
                      begin
                        case (strm_cmd_sequence) // synopsys parallel_case

                          `DRAM_ACC_CMD_SEQ_IS_POCR :
                            begin
                              update_cci = 1'b0 ;
                            end
                          `DRAM_ACC_CMD_SEQ_IS_POCW :
                            begin
                              update_cci = 1'b0 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_CR :
                            begin
                              update_cci = 1'b1 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_CW :
                            begin
                              update_cci = 1'b1 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_PCPOCR :
                            begin
                              update_cci = 1'b0 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_PCPOCW :
                            begin
                              update_cci = 1'b0 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_PCPR :
                            begin
                              update_cci = 1'b0 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_PR :
                            begin
                              update_cci = 1'b0 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_NOP:
                            begin
                              update_cci = 1'b0 ;
                            end
                          default:
                            begin
                              update_cci = 1'b0 ;
                            end

                        endcase
                      end
                    else
                      begin
                        update_cci = 1'b0 ;
                      end
                  end
              end
            // clear CCI after we send the PC command
            // This is setting the state of the CCI for the next PC command
            always @(*)
              begin
                for (int bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
                  begin
                    if ((mmc_cntl_cmd_gen_state != `MMC_CNTL_CMD_GEN_WAIT) && (mmc_cntl_cmd_gen_state != `MMC_CNTL_CMD_GEN_DECODE_SEQUENCE))
                      begin
                        case (strm_cmd_sequence) // synopsys parallel_case

                          `DRAM_ACC_CMD_SEQ_IS_POCR :
                            begin
                              initialize_cci = 1'b1 ;
                            end
                          `DRAM_ACC_CMD_SEQ_IS_POCW :
                            begin
                              initialize_cci = 1'b1 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_CR :
                            begin
                              initialize_cci = 1'b0 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_CW :
                            begin
                              initialize_cci = 1'b0 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_PCPOCR :
                            begin
                              initialize_cci = 1'b1 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_PCPOCW :
                            begin
                              initialize_cci = 1'b1 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_PCPR :
                            begin
                              initialize_cci = 1'b1 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_PR :
                            begin
                              initialize_cci = 1'b0 ;
                            end
                       
                          `DRAM_ACC_CMD_SEQ_IS_NOP:
                            begin
                              initialize_cci = 1'b0 ;
                            end
                          default:
                            begin
                              initialize_cci = 1'b0 ;
                            end

                        endcase
                      end
                    else
                      begin
                        initialize_cci = 1'b0 ;
                      end
                  end
              end

            always @(posedge clk)
              begin
                casex ({(mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT), channel_bank_a_page_is_open[chan][strm_request_bank], (channel_bank_open_page [chan][strm_request_bank] == strm_request_page), strm_request_is_read, strm_request_is_write})  // synopsys parallel_case

                  5'b10x10 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_POCR   ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_PO         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_CR         ;
                      strm_cmd_sequence_codes[3]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b10x01 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_POCW   ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_PO         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_CW         ;
                      strm_cmd_sequence_codes[3]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11110 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_CR     ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_CR         ;
                      strm_cmd_sequence_codes[3]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11101 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_CW     ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_CW         ;
                      strm_cmd_sequence_codes[3]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11010 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_PCPOCR ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_PC         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_PO         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_CR         ;
                      strm_cmd_sequence_codes[3]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11001 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_PCPOCW ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_PC         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_PO         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_CW         ;
                      strm_cmd_sequence_codes[3]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  // if we are not reading or writing, then assume its a page refresh
                  5'b10x00 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_PR     ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_PR         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                      strm_cmd_sequence_codes[3]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                    end

                  5'b11x00 :
                    begin
                      strm_cmd_sequence           <=  'd `DRAM_ACC_CMD_SEQ_IS_PCPR   ;
                      strm_cmd_sequence_codes[0]  <=  'd `DRAM_ACC_CMD_IS_PC         ;
                      strm_cmd_sequence_codes[1]  <=  'd `DRAM_ACC_CMD_IS_PR         ;
                      strm_cmd_sequence_codes[2]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
                      strm_cmd_sequence_codes[3]  <=  'd `DRAM_ACC_CMD_IS_NOP        ;
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


            // Whilst in the wait state, keep latching the request fifo output. Once this stream is selected, we will immediately move from the WAIT state
            always @(posedge clk)
              begin
                strm_is_read_latched  [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_is_read  : strm_is_read_latched  [chan] [strm]  ;
                strm_is_write_latched [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_is_write : strm_is_write_latched [chan] [strm]  ;

                strm_bank_latched     [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_bank     : strm_bank_latched     [chan] [strm]  ;
                strm_page_latched     [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_page     : strm_page_latched     [chan] [strm]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                                                                                        
                  strm_line_latched   [chan] [strm] = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT) ? strm_request_line     : strm_line_latched     [chan] [strm]  ;
                `endif
              end

            always @(*)
              begin
                request_pipe_read [chan][strm]  = strm_enable [chan][strm] ;  // strm_enable is a pulse
                                                                                                    
              end

            // The stream request valid is sent to the channel select logic which in turn will enable this fsm
            //  - stream is valid if waiting and the streams request fifo wants this channel or
            //  - the stream has not yet been granted cache access
            if (strm == 2)
              begin
                assign  strm_wr_data_available = write_data_fifo[0].pipe_has_two ;  // need a full cache line before we initiate a write
                assign  strm_request           = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT ) & 
                                                 ( ~cmd_seq_pc_fifo  [chan].almost_full && ~cmd_seq_po_fifo  [chan].almost_full && ~cmd_seq_cache_fifo [chan].almost_full)              &
                                                 (request_fifo[strm].pipe_valid & (strm_request_chan == chan) & (&xxx__mmc__ready_d1[chan]) & 
                                                 (request_fifo[strm].pipe_is_read | (request_fifo[strm].pipe_is_write & strm_wr_data_available ))) ;  // FIXME : both have to be ready??
              end
            else
              begin
                assign  strm_wr_data_available = 'd0 ;
                assign  strm_request           = (mmc_cntl_cmd_gen_state == `MMC_CNTL_CMD_GEN_WAIT ) & 
                                                 ( ~cmd_seq_pc_fifo  [chan].almost_full && ~cmd_seq_po_fifo  [chan].almost_full && ~cmd_seq_cache_fifo [chan].almost_full)              &
                                                  request_fifo[strm].pipe_valid & (strm_request_chan == chan) & (&xxx__mmc__ready_d1[chan]) & (request_fifo[strm].pipe_is_read | (request_fifo[strm].pipe_is_write & strm_wr_data_available )) ;  // FIXME : both have to be ready??
              end
                                               
            assign  strm_request_done          = (mmc_cntl_cmd_gen_state != `MMC_CNTL_CMD_GEN_WAIT ) & (mmc_cntl_cmd_gen_state != `MMC_CNTL_CMD_GEN_DECODE_SEQUENCE ) ;  // there is one state transition after the decode sequence
                                               
            assign  strm_request_sequence      = strm_cmd_sequence                        ;
                                               
            assign  strm_request_is_read       = request_fifo[strm].pipe_is_read  ;
            assign  strm_request_is_write      = request_fifo[strm].pipe_is_write ;
                                               
            assign  strm_request_chan          = request_fifo[strm].pipe_channel  ;
            assign  strm_request_bank          = request_fifo[strm].pipe_bank     ;
            assign  strm_request_page          = request_fifo[strm].pipe_page     ;
            `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
              assign  strm_request_line        = request_fifo[strm].pipe_line     ;
            `endif

            always @(*)
              begin
                strm_access_request  [chan] [strm] = strm_request              ;
                strm_access_done     [chan] [strm] = strm_request_done         ;
                strm_access_sequence [chan] [strm] = strm_request_sequence     ;
                strm_access_bank     [chan] [strm] = strm_request_bank         ;
                strm_access_page     [chan] [strm] = strm_request_page         ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                               
                  strm_access_line   [chan] [strm] = strm_request_line         ;
                `endif

                strm_write_data_available [chan] [strm] = strm_wr_data_available ;
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
        reg                                                     last_bank_valid    ;  // initially not ready
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   last_bank          ;  // The previous stream accessed this bank. Use this to delay enabling the next stream if it is accessing the
                                                                                      // same bank to let the channel status to stabilize

        always @(*)
          begin
            case (mmc_cntl_strm_sel_state)
              
              //  - we select stream 0 first if streams request together
              //  - maybe add wait state that has knowledge of last stream processed e.g. WAIT_STRM0_LAST -> transiton to STRM10
              //
              //  FIXME: Should we consider both streams accessing the same bank/page/line ??

              `MMC_CNTL_STRM_SEL_WAIT: 
                // let both channel streams continue if they are accessing different banks
                mmc_cntl_strm_sel_state_next =  ( strm_access_request [chan][2] ) ?  `MMC_CNTL_STRM_SEL_WRITE_INTF0 :
                                                ( strm_access_request [chan][0] ) ?  `MMC_CNTL_STRM_SEL_STRM0       :
                                                ( strm_access_request [chan][1] ) ?  `MMC_CNTL_STRM_SEL_STRM1       :
                                                                                     `MMC_CNTL_STRM_SEL_WAIT        ;
      
              `MMC_CNTL_STRM_SEL_WRITE_INTF0: 
                mmc_cntl_strm_sel_state_next =  ( strm_access_done  [chan][2] && strm_access_request [chan][2] && (!last_bank_valid || (last_bank != strm_access_bank [chan] [2]))) ?  `MMC_CNTL_STRM_SEL_WRITE_INTF0  :
                                                ( strm_access_done  [chan][2] && strm_access_request [chan][0] && (!last_bank_valid || (last_bank != strm_access_bank [chan] [0]))) ?  `MMC_CNTL_STRM_SEL_STRM0        :
                                                ( strm_access_done  [chan][2] && strm_access_request [chan][1] && (!last_bank_valid || (last_bank != strm_access_bank [chan] [1]))) ?  `MMC_CNTL_STRM_SEL_STRM1        :
                                                ( strm_access_done  [chan][2] && strm_access_request [chan][2]                                                                    ) ?  `MMC_CNTL_STRM_SEL_PAUSE1  :
                                                ( strm_access_done  [chan][2] && strm_access_request [chan][0]                                                                    ) ?  `MMC_CNTL_STRM_SEL_PAUSE1        :
                                                ( strm_access_done  [chan][2] && strm_access_request [chan][1]                                                                    ) ?  `MMC_CNTL_STRM_SEL_PAUSE1        :
                                                ( strm_access_done  [chan][2]                                                                                                     ) ?  `MMC_CNTL_STRM_SEL_WAIT         :
                                                                                                                                                                                       `MMC_CNTL_STRM_SEL_WRITE_INTF0  ;
              `MMC_CNTL_STRM_SEL_STRM0: 
                mmc_cntl_strm_sel_state_next =  ( strm_access_done  [chan][0] && strm_access_request [chan][2] && (!last_bank_valid || (last_bank != strm_access_bank [chan] [2]))) ?  `MMC_CNTL_STRM_SEL_WRITE_INTF0  :
                                                ( strm_access_done  [chan][0] && strm_access_request [chan][1] && (!last_bank_valid || (last_bank != strm_access_bank [chan] [1]))) ?  `MMC_CNTL_STRM_SEL_STRM1        :
                                                ( strm_access_done  [chan][0]                                  && (!last_bank_valid || (last_bank != strm_access_bank [chan] [0]))) ?  `MMC_CNTL_STRM_SEL_WAIT         :
                                                ( strm_access_done  [chan][0] && strm_access_request [chan][2]                                                                    ) ?  `MMC_CNTL_STRM_SEL_PAUSE1  :
                                                ( strm_access_done  [chan][0] && strm_access_request [chan][1]                                                                    ) ?  `MMC_CNTL_STRM_SEL_PAUSE1        :
                                                ( strm_access_done  [chan][0]                                                                                                     ) ?  `MMC_CNTL_STRM_SEL_PAUSE1         :
                                                                                                                                                                                       `MMC_CNTL_STRM_SEL_STRM0        ;
                                                                                                               
              `MMC_CNTL_STRM_SEL_STRM1:                                                                        
                mmc_cntl_strm_sel_state_next =  ( strm_access_done  [chan][1] && strm_access_request [chan][2] && (!last_bank_valid || (last_bank != strm_access_bank [chan] [2]))) ?  `MMC_CNTL_STRM_SEL_WRITE_INTF0  :
                                                ( strm_access_done  [chan][1] && strm_access_request [chan][0] && (!last_bank_valid || (last_bank != strm_access_bank [chan] [0]))) ?  `MMC_CNTL_STRM_SEL_STRM0        :
                                                ( strm_access_done  [chan][1]                                  && (!last_bank_valid || (last_bank != strm_access_bank [chan] [1]))) ?  `MMC_CNTL_STRM_SEL_WAIT         :
                                                ( strm_access_done  [chan][1] && strm_access_request [chan][2]                                                                    ) ?  `MMC_CNTL_STRM_SEL_PAUSE1  :
                                                ( strm_access_done  [chan][1] && strm_access_request [chan][0]                                                                    ) ?  `MMC_CNTL_STRM_SEL_PAUSE1        :
                                                ( strm_access_done  [chan][1]                                                                                                     ) ?  `MMC_CNTL_STRM_SEL_PAUSE1         :
                                                                                                                                                                                       `MMC_CNTL_STRM_SEL_STRM1        ;
                                                                                                                                              
              `MMC_CNTL_STRM_SEL_PAUSE1: 
                mmc_cntl_strm_sel_state_next =  `MMC_CNTL_STRM_SEL_PAUSE2       ;
      
              `MMC_CNTL_STRM_SEL_PAUSE2: 
                mmc_cntl_strm_sel_state_next =  `MMC_CNTL_STRM_SEL_WAIT       ;
      
              default:
                mmc_cntl_strm_sel_state_next = `MMC_CNTL_STRM_SEL_WAIT ;
          
            endcase // case (mmc_cntl_strm_sel_state)
          end // always @ (*)


        //--------------------------------------------------
        // Control
        //  - 

        for (strm=0; strm<`MMC_CNTL_NUM_OF_INTF ; strm=strm+1) 
          begin: strm_ena_e1

            always @(*)
              begin
                case (mmc_cntl_strm_sel_state)  // synopsys parallel_case  full_case
                  `MMC_CNTL_STRM_SEL_WAIT :
                    begin
                      strm_enable_e1 [chan][strm] = ((                               (strm == 2) &  strm_access_request [chan][2]                                                                   )) |
                                                    ((                               (strm == 0) & ~strm_access_request [chan][2]  &  strm_access_request [chan][0]                                 )) |
                                                    ((                               (strm == 1) & ~strm_access_request [chan][2]  & ~strm_access_request [chan][0] & strm_access_request [chan][1] )) ;
                    end
                  `MMC_CNTL_STRM_SEL_STRM0 :
                    begin
                      strm_enable_e1 [chan][strm] = (( strm_access_done [chan][0]  & (strm == 2) &  strm_access_request [chan][2]                                                                   & (!last_bank_valid | (last_bank != strm_access_bank [chan] [2])))) |
                                                    (( strm_access_done [chan][0]  & (strm == 1) & ~strm_access_request [chan][2]  &  strm_access_request [chan][1]                                 & (!last_bank_valid | (last_bank != strm_access_bank [chan] [1])))) |
                                                    (( strm_access_done [chan][0]  & (strm == 0) & ~strm_access_request [chan][2]  & ~strm_access_request [chan][1] & strm_access_request [chan][0] & (!last_bank_valid | (last_bank != strm_access_bank [chan] [0])))) ;
                    end
                  `MMC_CNTL_STRM_SEL_STRM1 :
                    begin
                      strm_enable_e1 [chan][strm] = (( strm_access_done [chan][1]  & (strm == 2) &  strm_access_request [chan][2]                                                                   & (!last_bank_valid | (last_bank != strm_access_bank [chan] [2])))) |
                                                    (( strm_access_done [chan][1]  & (strm == 0) & ~strm_access_request [chan][2]  &  strm_access_request [chan][0]                                 & (!last_bank_valid | (last_bank != strm_access_bank [chan] [0])))) |
                                                    (( strm_access_done [chan][1]  & (strm == 1) & ~strm_access_request [chan][2]  & ~strm_access_request [chan][0] & strm_access_request [chan][1] & (!last_bank_valid | (last_bank != strm_access_bank [chan] [1])))) ;
                    end
                  `MMC_CNTL_STRM_SEL_WRITE_INTF0:
                    begin
                      strm_enable_e1 [chan][strm] = (( strm_access_done [chan][2]  & (strm == 2) &  strm_access_request [chan][2]                                                                   & (!last_bank_valid | (last_bank != strm_access_bank [chan] [2])))) |
                                                    (( strm_access_done [chan][2]  & (strm == 0) & ~strm_access_request [chan][2]  &  strm_access_request [chan][0]                                 & (!last_bank_valid | (last_bank != strm_access_bank [chan] [0])))) |
                                                    (( strm_access_done [chan][2]  & (strm == 1) & ~strm_access_request [chan][2]  & ~strm_access_request [chan][0] & strm_access_request [chan][1] & (!last_bank_valid | (last_bank != strm_access_bank [chan] [1])))) ;
                    end
                  default:
                    begin
                      strm_enable_e1 [chan][strm] = 1'b0 ;
                    end
                endcase
/*
 * FIXME: Use this when ready
 *
                // Stream enable is a pulse that initiates command sequence generation and reads the request fifo
                strm_enable_e1 [chan][strm] <= ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_WAIT        ) & (                               (strm == 2) &  strm_access_request [chan][2]                                                                   )) |
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_WAIT        ) & (                               (strm == 0) & ~strm_access_request [chan][2]  &  strm_access_request [chan][0]                                 )) |
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_WAIT        ) & (                               (strm == 1) & ~strm_access_request [chan][2]  & ~strm_access_request [chan][0] & strm_access_request [chan][1] )) |
                                             
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_WRITE_INTF0 ) & ( strm_access_done [chan][2]  & (strm == 2) &  strm_access_request [chan][2]                                                                   )) |
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_WRITE_INTF0 ) & ( strm_access_done [chan][2]  & (strm == 0) & ~strm_access_request [chan][2]  &  strm_access_request [chan][0]                                 )) |
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_WRITE_INTF0 ) & ( strm_access_done [chan][2]  & (strm == 1) & ~strm_access_request [chan][2]  & ~strm_access_request [chan][0] & strm_access_request [chan][1] )) |
                                                                                                      
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0       ) & ( strm_access_done [chan][0]  & (strm == 2) &  strm_access_request [chan][2]                                                                   )) |
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0       ) & ( strm_access_done [chan][0]  & (strm == 1) & ~strm_access_request [chan][2]  &  strm_access_request [chan][1]                                 )) |
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM0       ) & ( strm_access_done [chan][0]  & (strm == 0) & ~strm_access_request [chan][2]  & ~strm_access_request [chan][1] & strm_access_request [chan][0] )) |
                                                                                                      
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1       ) & ( strm_access_done [chan][1]  & (strm == 2) &  strm_access_request [chan][2]                                                                   )) |
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1       ) & ( strm_access_done [chan][1]  & (strm == 0) & ~strm_access_request [chan][2]  &  strm_access_request [chan][0]                                 )) |
                                               ((mmc_cntl_strm_sel_state == `MMC_CNTL_STRM_SEL_STRM1       ) & ( strm_access_done [chan][1]  & (strm == 1) & ~strm_access_request [chan][2]  & ~strm_access_request [chan][0] & strm_access_request [chan][1] )) ;
*/
              end
          end
        for (strm=0; strm<`MMC_CNTL_NUM_OF_INTF ; strm=strm+1) 
          begin: strm_ena
            always @(posedge clk)
              begin
                strm_enable [chan][strm] <= ( reset_poweron ) ? 'd0 : strm_enable_e1 [chan][strm] ;
              end
          end

        always @(posedge clk)
          begin
            case (mmc_cntl_strm_sel_state)  // synopsys parallel_case
              `MMC_CNTL_STRM_SEL_STRM0 :
                begin
                  last_bank_valid  <= ( reset_poweron ) ? 'd0   : 1'b1 ;
                  last_bank        <= ( reset_poweron ) ? 'd0   : strm_access_bank [chan][0] ;
                end
              `MMC_CNTL_STRM_SEL_STRM1 :
                begin
                  last_bank_valid  <= ( reset_poweron ) ? 'd0   : 1'b1 ;
                  last_bank        <= ( reset_poweron ) ? 'd0   : strm_access_bank [chan][1] ;
                end
              `MMC_CNTL_STRM_SEL_WRITE_INTF0:
                begin
                  last_bank_valid  <= ( reset_poweron ) ? 'd0   : 1'b1 ;
                  last_bank        <= ( reset_poweron ) ? 'd0   : strm_access_bank [chan][2] ;
                end
              default:
                begin
                  last_bank_valid  <= ( reset_poweron ) ? 'd0   : last_bank_valid ;
                  last_bank        <= ( reset_poweron ) ? 'd0   : last_bank ;
                end
            endcase
          end


        always @(posedge clk)
          begin
            // Stream enable is a pulse that initiates command sequence generation and reads the request fifo
            strm_tag   [chan]  =  ( reset_poweron                                                          ) ? 'd0                :
                                  ( |strm_enable [chan][0] | |strm_enable[chan][1] | |strm_enable[chan][2] ) ? strm_tag [chan] +1 :
                                                                                                               strm_tag [chan]    ;
          end

        // Update cache Counter(s)
        for (bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
          begin
            always @(posedge clk)
              begin
                case ({chan_cmd_gen_fsm [chan].strm_fsm[0].update_cci    , chan_cmd_gen_fsm [chan].strm_fsm[1].update_cci    , chan_cmd_gen_fsm [chan].strm_fsm[2].update_cci    , 
                       chan_cmd_gen_fsm [chan].strm_fsm[0].initialize_cci, chan_cmd_gen_fsm [chan].strm_fsm[1].initialize_cci, chan_cmd_gen_fsm [chan].strm_fsm[2].initialize_cci} )  // synopsys parallel_case
                  6'b100_000 :
                    cache_counter_in [chan][bank] <= ( reset_poweron ) ? 'd0 : ((bank == strm_bank_latched[chan][0]))  ?  cache_counter_in[chan][bank] + 'd1 :  cache_counter_in[chan][bank] ;
                  6'b010_000 :
                    cache_counter_in [chan][bank] <= ( reset_poweron ) ? 'd0 : ((bank == strm_bank_latched[chan][1]))  ?  cache_counter_in[chan][bank] + 'd1 :  cache_counter_in[chan][bank] ;
                  6'b001_000 :                                                                                      
                    cache_counter_in [chan][bank] <= ( reset_poweron ) ? 'd0 : ((bank == strm_bank_latched[chan][2]))  ?  cache_counter_in[chan][bank] + 'd1 :  cache_counter_in[chan][bank] ;
                  6'b000_100 :                                                                                      
                    cache_counter_in [chan][bank] <= ( reset_poweron ) ? 'd0 : ((bank == strm_bank_latched[chan][0]))  ?  'd1 :  cache_counter_in[chan][bank] ;
                  6'b000_010 :                                                                                      
                    cache_counter_in [chan][bank] <= ( reset_poweron ) ? 'd0 : ((bank == strm_bank_latched[chan][1]))  ?  'd1 :  cache_counter_in[chan][bank] ;
                  6'b000_001 :                                                                                      
                    cache_counter_in [chan][bank] <= ( reset_poweron ) ? 'd0 : ((bank == strm_bank_latched[chan][2]))  ?  'd1 :  cache_counter_in[chan][bank] ;
                  default:
                    cache_counter_in [chan][bank] <= ( reset_poweron ) ? 'd0 : cache_counter_in[chan][bank] ;
                endcase
              end
          end

        // Write the commands into the sequence fifo
        //  - only once chan/strm is selected at a time

        always @(*)
          begin

            cmd_seq_pc_fifo    [chan].write    = chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cmd_write  | chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cmd_write  | chan_cmd_gen_fsm [chan].strm_fsm[2].strm_cmd_write ;
            cmd_seq_po_fifo    [chan].write    = chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cmd_write  | chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cmd_write  | chan_cmd_gen_fsm [chan].strm_fsm[2].strm_cmd_write ;
            cmd_seq_cache_fifo [chan].write    = chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cmd_write  | chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cmd_write  | chan_cmd_gen_fsm [chan].strm_fsm[2].strm_cmd_write ;

            // page fifo
            case ({chan_cmd_gen_fsm [chan].strm_fsm[0].strm_cmd_write, chan_cmd_gen_fsm [chan].strm_fsm[1].strm_cmd_write, chan_cmd_gen_fsm [chan].strm_fsm[2].strm_cmd_write})  // synopsys parallel_case
              3'b100:
                begin
                  // PC Commands
                  cmd_seq_pc_fifo     [chan].write_cmd          = chan_cmd_gen_fsm     [chan].strm_fsm[0].strm_cmd_sequence_codes [0] ;
                  cmd_seq_pc_fifo     [chan].write_bank         = strm_bank_latched    [chan][0] ;
                  cmd_seq_pc_fifo     [chan].write_page         = strm_page_latched    [chan][0] ;
                  cmd_seq_pc_fifo     [chan].write_tag          = strm_tag             [chan] ;
                  cmd_seq_pc_fifo     [chan].write_seq_type     = strm_access_sequence [chan][0] ;
                  cmd_seq_pc_fifo     [chan].write_strm         = 'd0 ;
                  cmd_seq_pc_fifo     [chan].write_cci          = cache_counter_in[chan][strm_bank_latched[chan][0] ]   ;

                  // PO Commands (or PR)
                  cmd_seq_po_fifo     [chan].write_cmd          = chan_cmd_gen_fsm     [chan].strm_fsm[0].strm_cmd_sequence_codes [1] ;
                  cmd_seq_po_fifo     [chan].write_bank         = strm_bank_latched    [chan][0] ;
                  cmd_seq_po_fifo     [chan].write_page         = strm_page_latched    [chan][0] ;
                  cmd_seq_po_fifo     [chan].write_tag          = strm_tag             [chan] ;
                  cmd_seq_po_fifo     [chan].write_seq_type     = strm_access_sequence [chan][0] ;
                  cmd_seq_po_fifo     [chan].write_strm         = 'd0 ;

                  // Cache Commands 
                  // - NOP in cache fifo
                  cmd_seq_cache_fifo    [chan].write_cmd          = chan_cmd_gen_fsm     [chan].strm_fsm[0].strm_cmd_sequence_codes [2] ;
                  cmd_seq_cache_fifo    [chan].write_bank         = strm_bank_latched    [chan][0] ;
                  cmd_seq_cache_fifo    [chan].write_page         = strm_page_latched    [chan][0] ;
                  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                  
                    cmd_seq_cache_fifo  [chan].write_line         = strm_line_latched    [chan][0] ;
                  `endif                                          
                  cmd_seq_cache_fifo    [chan].write_tag          = strm_tag             [chan] ;
                  cmd_seq_cache_fifo    [chan].write_seq_type     = strm_access_sequence [chan][0] ;
                  cmd_seq_cache_fifo    [chan].write_strm         = 'd0 ;

                end                                         
              3'b010:                                       
                begin                                       
                  // PC Commands
                  cmd_seq_pc_fifo     [chan].write_cmd          = chan_cmd_gen_fsm     [chan].strm_fsm[1].strm_cmd_sequence_codes [0] ;
                  cmd_seq_pc_fifo     [chan].write_bank         = strm_bank_latched    [chan][1] ;
                  cmd_seq_pc_fifo     [chan].write_page         = strm_page_latched    [chan][1] ;
                  cmd_seq_pc_fifo     [chan].write_tag          = strm_tag             [chan] ;
                  cmd_seq_pc_fifo     [chan].write_seq_type     = strm_access_sequence [chan][1] ;
                  cmd_seq_pc_fifo     [chan].write_strm         = 'd1 ;
                  cmd_seq_pc_fifo     [chan].write_cci          = cache_counter_in[chan][strm_bank_latched[chan][1] ]   ;

                  // PO Commands (or PR)
                  cmd_seq_po_fifo     [chan].write_cmd          = chan_cmd_gen_fsm     [chan].strm_fsm[1].strm_cmd_sequence_codes [1] ;
                  cmd_seq_po_fifo     [chan].write_bank         = strm_bank_latched    [chan][1] ;
                  cmd_seq_po_fifo     [chan].write_page         = strm_page_latched    [chan][1] ;
                  cmd_seq_po_fifo     [chan].write_tag          = strm_tag             [chan] ;
                  cmd_seq_po_fifo     [chan].write_seq_type     = strm_access_sequence [chan][1] ;
                  cmd_seq_po_fifo     [chan].write_strm         = 'd1 ;

                  // Cache Commands 
                  // - NOP in cache fifo
                  cmd_seq_cache_fifo    [chan].write_cmd          = chan_cmd_gen_fsm     [chan].strm_fsm[1].strm_cmd_sequence_codes [2] ;
                  cmd_seq_cache_fifo    [chan].write_bank         = strm_bank_latched    [chan][1] ;
                  cmd_seq_cache_fifo    [chan].write_page         = strm_page_latched    [chan][1] ;
                  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                  
                    cmd_seq_cache_fifo  [chan].write_line         = strm_line_latched    [chan][1] ;
                  `endif                                          
                  cmd_seq_cache_fifo    [chan].write_tag          = strm_tag             [chan] ;
                  cmd_seq_cache_fifo    [chan].write_seq_type     = strm_access_sequence [chan][1] ;
                  cmd_seq_cache_fifo    [chan].write_strm         = 'd1 ;
                end                                         
              3'b001:                                       
                begin                                       
                  // PC Commands
                  cmd_seq_pc_fifo     [chan].write_cmd          = chan_cmd_gen_fsm     [chan].strm_fsm[2].strm_cmd_sequence_codes [0] ;
                  cmd_seq_pc_fifo     [chan].write_bank         = strm_bank_latched    [chan][2] ;
                  cmd_seq_pc_fifo     [chan].write_page         = strm_page_latched    [chan][2] ;
                  cmd_seq_pc_fifo     [chan].write_tag          = strm_tag             [chan] ;
                  cmd_seq_pc_fifo     [chan].write_seq_type     = strm_access_sequence [chan][2] ;
                  cmd_seq_pc_fifo     [chan].write_strm         = 'd2 ;
                  cmd_seq_pc_fifo     [chan].write_cci          = cache_counter_in[chan][strm_bank_latched[chan][2] ]   ;

                  // PO Commands (or PR)
                  cmd_seq_po_fifo     [chan].write_cmd          = chan_cmd_gen_fsm     [chan].strm_fsm[2].strm_cmd_sequence_codes [1] ;
                  cmd_seq_po_fifo     [chan].write_bank         = strm_bank_latched    [chan][2] ;
                  cmd_seq_po_fifo     [chan].write_page         = strm_page_latched    [chan][2] ;
                  cmd_seq_po_fifo     [chan].write_tag          = strm_tag             [chan] ;
                  cmd_seq_po_fifo     [chan].write_seq_type     = strm_access_sequence [chan][2] ;
                  cmd_seq_po_fifo     [chan].write_strm         = 'd2 ;

                  // Cache Commands 
                  // - NOP in cache fifo
                  cmd_seq_cache_fifo    [chan].write_cmd          = chan_cmd_gen_fsm     [chan].strm_fsm[2].strm_cmd_sequence_codes [2] ;
                  cmd_seq_cache_fifo    [chan].write_bank         = strm_bank_latched    [chan][2] ;
                  cmd_seq_cache_fifo    [chan].write_page         = strm_page_latched    [chan][2] ;
                  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                     
                    cmd_seq_cache_fifo  [chan].write_line         = strm_line_latched    [chan][2] ;
                  `endif                                          
                  cmd_seq_cache_fifo    [chan].write_tag          = strm_tag             [chan] ;
                  cmd_seq_cache_fifo    [chan].write_seq_type     = strm_access_sequence [chan][2] ;
                  cmd_seq_cache_fifo    [chan].write_strm         = 'd2 ;
                end                                         


              default:                                         
                begin                                          
                  // Page Commands
                  cmd_seq_pc_fifo     [chan].write_cmd          = 1'b0 ;
                  cmd_seq_pc_fifo     [chan].write_bank         = 'd0 ;
                  cmd_seq_pc_fifo     [chan].write_page         = 'd0 ;
                  cmd_seq_pc_fifo     [chan].write_tag          = strm_tag [chan] ;
                  cmd_seq_pc_fifo     [chan].write_seq_type     = `DRAM_ACC_CMD_SEQ_IS_NOP  ;
                  cmd_seq_pc_fifo     [chan].write_strm         = 'd0 ;
                  cmd_seq_pc_fifo     [chan].write_cci          = 'd0 ;

                  // Page Commands
                  cmd_seq_po_fifo     [chan].write_cmd          = 1'b0 ;
                  cmd_seq_po_fifo     [chan].write_bank         = 'd0 ;
                  cmd_seq_po_fifo     [chan].write_page         = 'd0 ;
                  cmd_seq_po_fifo     [chan].write_tag          = strm_tag [chan] ;
                  cmd_seq_po_fifo     [chan].write_seq_type     = `DRAM_ACC_CMD_SEQ_IS_NOP  ;
                  cmd_seq_po_fifo     [chan].write_strm         = 'd0 ;

                  // Cache Commands 
                  cmd_seq_cache_fifo    [chan].write_cmd       = 1'b0 ;
                  cmd_seq_cache_fifo    [chan].write_bank      = 'd0 ;
                  cmd_seq_cache_fifo    [chan].write_page      = 'd0 ;
                  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                               
                    cmd_seq_cache_fifo  [chan].write_line      = 'd0 ;
                  `endif                
                  cmd_seq_cache_fifo    [chan].write_tag       = strm_tag [chan] ;
                  cmd_seq_cache_fifo    [chan].write_seq_type  = `DRAM_ACC_CMD_SEQ_IS_NOP  ;
                  cmd_seq_cache_fifo    [chan].write_strm      = 'd0 ;
                end
            endcase

          end
      end
  endgenerate


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Command Sequence FIFOs
  // - for page and cache commands sequences, the outputs are checked for can_go before transferring to final queue
  // - PCPOCx sequences also use the PO layby fifo 
  //

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: cmd_seq_pc_fifo

        wire                                                   clear                 ;
        wire                                                   almost_full           ;
        reg                                                    write                 ;
        wire  [`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_RANGE ]   write_data            ;
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                 ]   write_tag             ;
        reg   [`DRAM_ACC_SEQ_TYPE_RANGE                    ]   write_seq_type        ;
        reg   [`MMC_CNTL_NUM_OF_INTF_RANGE                 ]   write_strm            ;
        reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE                 ]   write_cmd             ;
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE                ]   write_bank            ;
        reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE                ]   write_page            ;
        reg   [`MMC_CNTL_CMD_GEN_OP_COUNT_RANGE            ]   write_cci             ;  // cache command count

        wire                                                   pipe_valid            ;
        reg                                                    pipe_read             ;
                                                                                
        wire  [`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_RANGE ]   pipe_data             ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE                 ]   pipe_tag              ;
        wire  [`DRAM_ACC_SEQ_TYPE_RANGE                    ]   pipe_seq_type         ;
        wire  [`MMC_CNTL_NUM_OF_INTF_RANGE                 ]   pipe_strm             ;
        wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE                 ]   pipe_cmd              ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                ]   pipe_bank             ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE                ]   pipe_page             ;
        reg   [`MMC_CNTL_CMD_GEN_OP_COUNT_RANGE            ]   pipe_cci              ;  // cache command count


        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_WIDTH       )
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

                                // General
                                .clear                 ( clear                 ),
                                .reset_poweron         ( reset_poweron         ),
                                .clk                   ( clk                   )
                                );

          assign write_data  = {write_strm, write_tag, write_seq_type, write_cmd, write_bank, write_page, write_cci} ;

          assign {pipe_strm, pipe_tag, pipe_seq_type, pipe_cmd, pipe_bank, pipe_page, pipe_cci} = pipe_data            ;

        assign clear = 1'b0 ;
 
      end
  endgenerate

  // PO layby fifo
  // - stores PO associated with PCPOCR sequence to allow other PC's to proceed
  //

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: cmd_seq_po_fifo

        wire                                                    clear                 ;
        wire                                                    almost_full           ;
        reg                                                     write                 ;
        wire  [`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_RANGE ]   write_data            ;
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   write_tag             ;
        reg   [`DRAM_ACC_SEQ_TYPE_RANGE                     ]   write_seq_type        ;
        reg   [`MMC_CNTL_NUM_OF_INTF_RANGE                  ]   write_strm            ;
        reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE                  ]   write_cmd             ;
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   write_bank            ;
        reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   write_page            ;

        wire                                                    pipe_valid            ;
        reg                                                     pipe_read             ;
                                                                                
        wire  [`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_RANGE ]   pipe_data             ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   pipe_tag              ;
        wire  [`DRAM_ACC_SEQ_TYPE_RANGE                     ]   pipe_seq_type         ;
        wire  [`MMC_CNTL_NUM_OF_INTF_RANGE                  ]   pipe_strm             ;
        wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE                  ]   pipe_cmd              ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_bank             ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_page             ;


        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_WIDTH       )
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

                                // General
                                .clear                 ( clear                 ),
                                .reset_poweron         ( reset_poweron         ),
                                .clk                   ( clk                   )
                                );

          assign write_data  = {write_strm, write_tag, write_seq_type, write_cmd, write_bank, write_page} ;

          assign {pipe_strm,            pipe_tag,            pipe_seq_type,            pipe_cmd,            pipe_bank,            pipe_page           } = pipe_data            ;

        assign clear = 1'b0 ;
 
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
        reg   [`MMC_CNTL_NUM_OF_INTF_RANGE                  ]   write_strm            ;
        reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE                  ]   write_cmd             ;
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   write_bank            ;
        reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   write_page            ;
        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                              
          reg   [`MGR_DRAM_LINE_ADDRESS_RANGE               ]   write_line            ;
        `endif                                              
                                                            
        wire                                                    pipe_valid            ;
        reg                                                     pipe_read             ;
                                                                                
        wire  [`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_RANGE ]   pipe_data             ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   pipe_tag              ;
        wire  [`DRAM_ACC_SEQ_TYPE_RANGE                     ]   pipe_seq_type         ;
        wire  [`MMC_CNTL_NUM_OF_INTF_RANGE                  ]   pipe_strm             ;
        wire  [`DRAM_ACC_NUM_OF_CMDS_RANGE                  ]   pipe_cmd              ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_bank             ;
        wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_page             ;
        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                              
          wire  [`MGR_DRAM_LINE_ADDRESS_RANGE               ]   pipe_line             ;
        `endif


        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_CACHE_CMD_SEQ_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_WIDTH       )
                        ) cache_cmd_gpfifo (
                                 // Status
                                .almost_full           ( almost_full           ),
                                 // Write                                      
                                .write                 ( write                 ),
                                .write_data            ( write_data            ),
                                 // Read                                       
                                .pipe_valid            ( pipe_valid            ),
                                .pipe_data             ( pipe_data             ),
                                .pipe_read             ( pipe_read             ),

                                // General
                                .clear                 ( clear                 ),
                                .reset_poweron         ( reset_poweron         ),
                                .clk                   ( clk                   )
                                );

        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                       
          assign write_data  = {write_strm, write_tag, write_seq_type, write_cmd, write_bank, write_page, write_line} ;

          assign {pipe_strm,            pipe_tag,            pipe_seq_type,            pipe_cmd,            pipe_bank,            pipe_page,            pipe_line           } = pipe_data            ;
        `else
          assign write_data  = {write_strm, write_tag, write_cmd, write_bank, write_page} ;

          assign {pipe_strm,            pipe_tag,            pipe_seq_type,            pipe_cmd,            pipe_bank,            pipe_page           } = pipe_data            ;
        `endif

        assign clear = 1'b0 ;
 
      end
  endgenerate

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Pass command sequence fifos
  //  - test if command at head of sequence fifo can_go using dram_access_timer status
  //  - 
  //  -
      
  reg                                        chan_final_queue_valid   [`MGR_DRAM_NUM_CHANNELS]  ; 
  reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE     ]   chan_final_queue_cmd     [`MGR_DRAM_NUM_CHANNELS]  ;
  reg   [`MMC_CNTL_NUM_OF_INTF_RANGE     ]   chan_final_queue_strm    [`MGR_DRAM_NUM_CHANNELS]  ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]   chan_final_queue_bank    [`MGR_DRAM_NUM_CHANNELS]  ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]   chan_final_queue_page    [`MGR_DRAM_NUM_CHANNELS]  ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                    
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

        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE                 ]   last_bank                             ;  // last read bank from either page or cache cmd
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   last_pc_tag                           ;  // last read tag
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   last_po_tag                           ;  // last read tag
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   last_cache_tag                        ;  // last read tag
        reg   [`DRAM_ACC_NUM_OF_CMDS_RANGE                  ]   last_page_cmd                         ;  // we need to consider PC-PO associated with the same tag
                                                                                                         // If we see this situation, direct the PO to a holding fifo to allow more PC's to flow
        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   pc_cache_delta_tag                    ;  // keep track of difference between page and cache reads
        wire                                                    pc_cache_delta_tag_ge0                ;
        wire                                                    pc_cache_delta_tag_gt0                ;
        wire                                                    pc_cache_delta_tag_ne0                ;
        wire                                                    pc_and_cache_tags_synced              ;  // if last tag is the same in both

        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   po_cache_delta_tag                    ;  // keep track of difference between page and cache reads
        wire                                                    po_cache_delta_tag_ge0                ;
        wire                                                    po_cache_delta_tag_gt0                ;
        wire                                                    po_cache_delta_tag_ne0                ;
        wire                                                    po_and_cache_tags_synced              ;  // if last tag is the same in both

        reg   [`MMC_CNTL_CMD_GEN_TAG_RANGE                  ]   pc_po_delta_tag                       ;  // keep track of difference between page and cache reads
        wire                                                    pc_po_delta_tag_ge0                   ;
        wire                                                    pc_po_delta_tag_gt0                   ;
        wire                                                    pc_po_delta_tag_ne0                   ;
        wire                                                    pc_and_po_tags_synced                 ;  // if last tag is the same in both

        wire                                                    pc_sequence_is_PCPOCx                 ;  // we will load the PO layby fifo when we see a PCPOCR or PCPOCW
        wire                                                    po_sequence_is_PCPOCx                 ;  // we will load the PO layby fifo when we see a PCPOCR or PCPOCW
                                                                                                              
        wire                                                    page_cmd_pc_requested                 ; 
        wire                                                    page_cmd_po_requested                 ; 
        wire                                                    cache_cmd_requested                   ; 

        wire                                                    page_cmd_pc_accepted                  ; 
        wire                                                    page_cmd_po_accepted                  ; 
        wire                                                    cache_cmd_accepted                    ; 

        wire                                                    page_cmd_pc_read                      ; 
        wire                                                    page_cmd_po_read                      ; 
        wire                                                    cache_cmd_read                        ;

        wire                                                    page_cmd_pc_ready_to_go               ;
        wire                                                    page_cmd_po_ready_to_go               ;
        wire                                                    cache_cmd_ready_to_go                 ; 


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
                mmc_cntl_cmd_check_state_next =  ( page_cmd_po_requested   ) ?  `MMC_CNTL_CMD_CHECK_PAGE_INIT         :  // 
                                                                                `MMC_CNTL_CMD_CHECK_WAIT       ;
              `MMC_CNTL_CMD_CHECK_PAGE_INIT: 
                mmc_cntl_cmd_check_state_next =  ( page_cmd_pc_requested && (cache_cmd_requested && (cmd_seq_pc_fifo [chan].pipe_bank != cmd_seq_cache_fifo [chan].pipe_bank))) ? `MMC_CNTL_CMD_CHECK_CACHE_INIT : 
                                                 ( page_cmd_po_requested && (cache_cmd_requested && (cmd_seq_po_fifo [chan].pipe_bank != cmd_seq_cache_fifo [chan].pipe_bank))) ? `MMC_CNTL_CMD_CHECK_CACHE_INIT : 
                                                 ( page_cmd_pc_requested                                                                                                      ) ? `MMC_CNTL_CMD_CHECK_PC           : 
                                                 ( page_cmd_po_requested                                                                                                      ) ? `MMC_CNTL_CMD_CHECK_PO      : 
                                                 ( cache_cmd_requested                                                                                                        ) ? `MMC_CNTL_CMD_CHECK_CACHE_INIT   :
                                                                                                                                                                                  `MMC_CNTL_CMD_CHECK_PAGE_INIT      ;
                                                                                                    
                                                                                                    
              `MMC_CNTL_CMD_CHECK_CACHE_INIT: 
                mmc_cntl_cmd_check_state_next =  ( cache_cmd_requested && (page_cmd_po_requested && (cmd_seq_po_fifo [chan].pipe_bank != cmd_seq_cache_fifo [chan].pipe_bank))) ? `MMC_CNTL_CMD_CHECK_PAGE_INIT : 
                                                 ( cache_cmd_requested && (page_cmd_pc_requested && (cmd_seq_pc_fifo [chan].pipe_bank != cmd_seq_cache_fifo [chan].pipe_bank))) ? `MMC_CNTL_CMD_CHECK_PAGE_INIT : 
                                                 ( cache_cmd_requested     ) ? `MMC_CNTL_CMD_CHECK_CACHE    :
                                                 ( page_cmd_pc_requested || page_cmd_po_requested                                                                             ) ? `MMC_CNTL_CMD_CHECK_PAGE_INIT      : 
                                                                              `MMC_CNTL_CMD_CHECK_CACHE_INIT ;
                                                                                                    
              `MMC_CNTL_CMD_CHECK_PC: 
                mmc_cntl_cmd_check_state_next =  ( page_cmd_po_requested && (last_bank != cmd_seq_po_fifo    [chan].pipe_bank)) ? `MMC_CNTL_CMD_CHECK_PAGE_INIT : 
                                                 ( cache_cmd_requested   && (last_bank != cmd_seq_cache_fifo [chan].pipe_bank)) ? `MMC_CNTL_CMD_CHECK_CACHE_INIT : 
                                                 ( page_cmd_pc_requested && (last_bank != cmd_seq_pc_fifo    [chan].pipe_bank)) ? `MMC_CNTL_CMD_CHECK_PAGE_INIT : 
                                                                                                                                  `MMC_CNTL_CMD_CHECK_PAGE_WAIT      ;
                                                                                                    
              `MMC_CNTL_CMD_CHECK_PO: 
                mmc_cntl_cmd_check_state_next =  ( cache_cmd_requested   && (last_bank != cmd_seq_cache_fifo [chan].pipe_bank)) ? `MMC_CNTL_CMD_CHECK_CACHE_INIT : 
                                                 ( page_cmd_pc_requested && (last_bank != cmd_seq_pc_fifo    [chan].pipe_bank)) ? `MMC_CNTL_CMD_CHECK_PAGE_INIT : 
                                                 ( page_cmd_po_requested && (last_bank != cmd_seq_po_fifo    [chan].pipe_bank)) ? `MMC_CNTL_CMD_CHECK_PAGE_INIT : 
                                                                                                                                  `MMC_CNTL_CMD_CHECK_PAGE_WAIT      ;
                                                                                                    
              `MMC_CNTL_CMD_CHECK_CACHE: 
                mmc_cntl_cmd_check_state_next =  ( page_cmd_pc_requested && (last_bank != cmd_seq_pc_fifo    [chan].pipe_bank)) ? `MMC_CNTL_CMD_CHECK_PAGE_INIT : 
                                                 ( page_cmd_po_requested && (last_bank != cmd_seq_po_fifo    [chan].pipe_bank)) ? `MMC_CNTL_CMD_CHECK_PAGE_INIT : 
                                                 ( cache_cmd_requested   && (last_bank != cmd_seq_cache_fifo [chan].pipe_bank)) ? `MMC_CNTL_CMD_CHECK_CACHE_INIT : 
                                                                                                                                  `MMC_CNTL_CMD_CHECK_CACHE_WAIT      ;
                                                                                                    


              // allow a cycle for the checker ready to propagate
              `MMC_CNTL_CMD_CHECK_PAGE_WAIT: 
                mmc_cntl_cmd_check_state_next =  `MMC_CNTL_CMD_CHECK_CACHE_INIT  ;
                                                                                                    
              `MMC_CNTL_CMD_CHECK_CACHE_WAIT: 
                mmc_cntl_cmd_check_state_next =  `MMC_CNTL_CMD_CHECK_PAGE_INIT ;
                                                                                                    
              default:
                mmc_cntl_cmd_check_state_next = `MMC_CNTL_CMD_CHECK_WAIT ;
          
            endcase // case (mmc_cntl_cmd_check_state)
          end // always @ (*)

        //--------------------------------------------------
        // Control
        //  - 

        // Update output cache Counter(s)
        for (bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
          begin
            always @(posedge clk)
              begin
                case ({cache_cmd_accepted, page_cmd_pc_accepted})

                  2'b10 :
                    cache_counter_out [chan][bank] <= ( reset_poweron ) ? 'd0 : (bank == cmd_seq_cache_fifo [chan].pipe_bank)  ?  cache_counter_out[chan][bank] + 'd1 :  cache_counter_out[chan][bank] ;
                  2'b01 :
                    cache_counter_out [chan][bank] <= ( reset_poweron ) ? 'd0 : (bank == cmd_seq_pc_fifo [chan].pipe_bank   )  ?  'd0 :  cache_counter_out[chan][bank] ;
                  default:
                    cache_counter_out [chan][bank] <= ( reset_poweron ) ? 'd0 : cache_counter_out[chan][bank] ;

                endcase
              end
          end

        assign  pc_cache_delta_tag_ge0          =  ~pc_cache_delta_tag[`MMC_CNTL_CMD_GEN_TAG_MSB ] ;  // value is negative if msb=1
        assign  pc_cache_delta_tag_ne0          =  |pc_cache_delta_tag                             ;  // we will only let cache commands go if pc_cache_delta_tag > 0 e.g. if the tag associated with the page command has gone
        assign  pc_cache_delta_tag_gt0          =  pc_cache_delta_tag_ge0 & pc_cache_delta_tag_ne0 ;
        assign  pc_and_cache_tags_synced        =  cmd_seq_pc_fifo  [chan].pipe_valid & cmd_seq_cache_fifo [chan].pipe_valid & (cmd_seq_pc_fifo [chan].pipe_tag == cmd_seq_cache_fifo [chan].pipe_tag) ;

        assign  po_cache_delta_tag_ge0          =  ~po_cache_delta_tag[`MMC_CNTL_CMD_GEN_TAG_MSB ] ;  // value is negative if msb=1
        assign  po_cache_delta_tag_ne0          =  |po_cache_delta_tag                             ;  // we will only let cache commands go if po_cache_delta_tag > 0 e.g. if the tag associated with the page command has gone
        assign  po_cache_delta_tag_gt0          =  po_cache_delta_tag_ge0 & po_cache_delta_tag_ne0 ;
        assign  po_and_cache_tags_synced        =  cmd_seq_po_fifo  [chan].pipe_valid & cmd_seq_cache_fifo [chan].pipe_valid & (cmd_seq_po_fifo [chan].pipe_tag == cmd_seq_cache_fifo [chan].pipe_tag) ;

        assign  pc_po_delta_tag_ge0             =  ~pc_po_delta_tag[`MMC_CNTL_CMD_GEN_TAG_MSB ]    ;  // value is negative if msb=1
        assign  pc_po_delta_tag_ne0             =  |pc_po_delta_tag                                ;  // we will only let cache commands go if pc_po_delta_tag > 0 e.g. if the tag associated with the page command has gone
        assign  pc_po_delta_tag_gt0             =  pc_po_delta_tag_ge0 & pc_po_delta_tag_ne0       ;
        assign  pc_and_po_tags_synced           =  cmd_seq_pc_fifo  [chan].pipe_valid & cmd_seq_po_fifo [chan].pipe_valid & (cmd_seq_pc_fifo [chan].pipe_tag == cmd_seq_po_fifo [chan].pipe_tag) ;

        assign  pc_sequence_is_PCPOCx           =  (cmd_seq_pc_fifo [chan].pipe_seq_type == `DRAM_ACC_CMD_SEQ_IS_PCPOCR) | (cmd_seq_pc_fifo [chan].pipe_seq_type == `DRAM_ACC_CMD_SEQ_IS_PCPOCW) ;
        assign  po_sequence_is_PCPOCx           =  (cmd_seq_po_fifo [chan].pipe_seq_type == `DRAM_ACC_CMD_SEQ_IS_PCPOCR) | (cmd_seq_po_fifo [chan].pipe_seq_type == `DRAM_ACC_CMD_SEQ_IS_PCPOCW) ;
        

                                                                                          /*|<-------------------- index into array of dram command timer status ----------------->|*/
        assign  page_cmd_pc_ready_to_go         = cmd_seq_pc_fifo    [chan].pipe_valid  & (cmd_can_go[chan][cmd_seq_pc_fifo    [chan].pipe_bank][cmd_seq_pc_fifo    [chan].pipe_cmd] == 1'b1) & (cmd_seq_pc_fifo    [chan].pipe_cmd != `DRAM_ACC_CMD_IS_NOP); //) ; // page command available and timer ready
        assign  page_cmd_po_ready_to_go         = cmd_seq_po_fifo    [chan].pipe_valid  & (cmd_can_go[chan][cmd_seq_po_fifo    [chan].pipe_bank][cmd_seq_po_fifo    [chan].pipe_cmd] == 1'b1) & (cmd_seq_po_fifo    [chan].pipe_cmd != `DRAM_ACC_CMD_IS_NOP); //) ; // page command available and timer ready
        assign  cache_cmd_ready_to_go           = cmd_seq_cache_fifo [chan].pipe_valid  & (cmd_can_go[chan][cmd_seq_cache_fifo [chan].pipe_bank][cmd_seq_cache_fifo [chan].pipe_cmd] == 1'b1) & (cmd_seq_cache_fifo [chan].pipe_cmd != `DRAM_ACC_CMD_IS_NOP); //) ; // cache command available and timer ready

                                                                             /*|<------------------ have we seen enough cache commands for this bank?------------------->|*/
        assign  page_cmd_pc_requested           =  page_cmd_pc_ready_to_go & ((cmd_seq_pc_fifo [chan].pipe_cci == cache_counter_out[chan][cmd_seq_pc_fifo [chan].pipe_bank]) | (pc_and_po_tags_synced & po_and_cache_tags_synced)) ;
        assign  page_cmd_po_requested           =  (page_cmd_po_ready_to_go & ~pc_and_po_tags_synced) | (cmd_seq_pc_fifo    [chan].pipe_valid & (cmd_seq_pc_fifo    [chan].pipe_cmd == `DRAM_ACC_CMD_IS_NOP)) ;
        assign  cache_cmd_requested             =  cache_cmd_ready_to_go   & po_cache_delta_tag_gt0 & ~pc_and_cache_tags_synced  ;

        assign  page_cmd_pc_accepted            = (mmc_cntl_cmd_check_state == `MMC_CNTL_CMD_CHECK_PAGE_INIT  ) & page_cmd_pc_requested & ~page_cmd_po_requested   ;  // the accepted signals cause bank status updates and fifo reads to occur
        assign  page_cmd_po_accepted            = (mmc_cntl_cmd_check_state == `MMC_CNTL_CMD_CHECK_PAGE_INIT  ) & page_cmd_po_requested  ;  // the accepted signals cause bank status updates and fifo reads to occur
        assign  cache_cmd_accepted              = (mmc_cntl_cmd_check_state == `MMC_CNTL_CMD_CHECK_CACHE_INIT ) & cache_cmd_requested    ;
                                                
        assign  page_cmd_pc_read                = page_cmd_pc_accepted  | (cmd_seq_pc_fifo    [chan].pipe_valid & (cmd_seq_pc_fifo    [chan].pipe_cmd == `DRAM_ACC_CMD_IS_NOP)) ;
        assign  page_cmd_po_read                = page_cmd_po_accepted  | (cmd_seq_po_fifo    [chan].pipe_valid & (cmd_seq_po_fifo    [chan].pipe_cmd == `DRAM_ACC_CMD_IS_NOP)) ;
        assign  cache_cmd_read                  = cache_cmd_accepted    | (cmd_seq_cache_fifo [chan].pipe_valid & (cmd_seq_cache_fifo [chan].pipe_cmd == `DRAM_ACC_CMD_IS_NOP)) ;
                                                
        // we need to account for the fact that a page tag might have two cmds associated with it
        always @(posedge clk)
          begin
            last_bank           <= (reset_poweron         ) ? 'd0                                 :
                                   (page_cmd_pc_accepted  ) ? cmd_seq_pc_fifo    [chan].pipe_bank :
                                   (page_cmd_po_accepted  ) ? cmd_seq_po_fifo    [chan].pipe_bank :
                                   (cache_cmd_accepted    ) ? cmd_seq_cache_fifo [chan].pipe_bank :
                                                              last_bank                           ;

            last_page_cmd       <= (reset_poweron         ) ? 'd0                                :
                                   (page_cmd_pc_accepted  ) ? cmd_seq_pc_fifo [chan].pipe_cmd    :
                                   (page_cmd_po_accepted  ) ? cmd_seq_po_fifo [chan].pipe_cmd    :
                                                              last_page_cmd                      ;

            last_pc_tag         <= (reset_poweron         ) ? 'd0                                :
                                   (page_cmd_pc_accepted  ) ? cmd_seq_pc_fifo [chan].pipe_tag    :
                                                              last_pc_tag                        ;

            last_po_tag         <= (reset_poweron         ) ? 'd0                                :
                                   (page_cmd_po_accepted  ) ? cmd_seq_po_fifo [chan].pipe_tag    :
                                                              last_po_tag                        ;

            last_cache_tag      <= (reset_poweron         ) ? 'd0                                :
                                   (cache_cmd_accepted    ) ? cmd_seq_cache_fifo [chan].pipe_tag :
                                                              last_cache_tag                     ;

            pc_cache_delta_tag  <= (reset_poweron                        ) ? 'd0                      :
                                   (page_cmd_pc_read && cache_cmd_read   ) ? pc_cache_delta_tag       :
                                   (page_cmd_pc_read                     ) ? pc_cache_delta_tag + 'd1 :
                                   (cache_cmd_read                       ) ? pc_cache_delta_tag - 'd1 :
                                                                             pc_cache_delta_tag       ;

            po_cache_delta_tag  <= (reset_poweron                        ) ? 'd0                      :
                                   (page_cmd_po_read && cache_cmd_read   ) ? po_cache_delta_tag       :
                                   (page_cmd_po_read                     ) ? po_cache_delta_tag + 'd1 :
                                   (cache_cmd_read                       ) ? po_cache_delta_tag - 'd1 :
                                                                             po_cache_delta_tag       ;

            pc_po_delta_tag     <= (reset_poweron                        ) ? 'd0                      :
                                   (page_cmd_pc_read && page_cmd_po_read ) ? pc_po_delta_tag          :
                                   (page_cmd_pc_read                     ) ? pc_po_delta_tag + 'd1    :
                                   (page_cmd_po_read                     ) ? pc_po_delta_tag - 'd1    :
                                                                             pc_po_delta_tag          ;

          end

        for (bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank++) 
          begin: set_access_req
            always @(*)
              begin
                page_cmd_grant_request_valid [chan][bank] =  (page_cmd_pc_accepted  & (cmd_seq_pc_fifo [chan].pipe_bank == bank) & (cmd_seq_pc_fifo [chan].pipe_cmd != `DRAM_ACC_CMD_IS_NOP)) | (page_cmd_po_accepted  & (cmd_seq_po_fifo [chan].pipe_bank == bank) & (cmd_seq_po_fifo [chan].pipe_cmd != `DRAM_ACC_CMD_IS_NOP)) ;
                                                                                                                                                                                                        
                page_cmd_grant_request_cmd   [chan][bank] = ({ `DRAM_ACC_NUM_OF_CMDS_WIDTH {page_cmd_pc_accepted  }} & { `DRAM_ACC_NUM_OF_CMDS_WIDTH  {cmd_seq_pc_fifo [chan].pipe_bank == bank}} & cmd_seq_pc_fifo [chan].pipe_cmd) |
                                                            ({ `DRAM_ACC_NUM_OF_CMDS_WIDTH {page_cmd_po_accepted  }} & { `DRAM_ACC_NUM_OF_CMDS_WIDTH  {cmd_seq_po_fifo [chan].pipe_bank == bank}} & cmd_seq_po_fifo [chan].pipe_cmd) ;

                                                                                                    
                cache_cmd_grant_request_valid[chan][bank] =  can_go_checker_ready [chan][bank] & cache_cmd_accepted  & (cmd_seq_cache_fifo [chan].pipe_bank == bank) ;
                                                                                                   
                cache_cmd_grant_request_cmd  [chan][bank] = { `DRAM_ACC_NUM_OF_CMDS_WIDTH {cache_cmd_accepted }} & { `DRAM_ACC_NUM_OF_CMDS_WIDTH  {cmd_seq_cache_fifo[chan].pipe_bank == bank}} & cmd_seq_cache_fifo[chan].pipe_cmd   ;
                                                                                                    
              end
          end

        // Read sequence fifos
        always @(*)
          begin
            cmd_seq_pc_fifo    [chan].pipe_read  =  page_cmd_pc_read        ;
            cmd_seq_po_fifo    [chan].pipe_read  =  page_cmd_po_read        ;
            cmd_seq_cache_fifo [chan].pipe_read  =  cache_cmd_read          ;
          end



        always @(posedge clk)
          begin
            case ({(cmd_seq_pc_fifo   [chan].pipe_read & (cmd_seq_pc_fifo    [chan].pipe_cmd != `DRAM_ACC_CMD_IS_NOP)), 
                   (cmd_seq_po_fifo   [chan].pipe_read & (cmd_seq_po_fifo    [chan].pipe_cmd != `DRAM_ACC_CMD_IS_NOP)), 
                   (cmd_seq_cache_fifo[chan].pipe_read & (cmd_seq_cache_fifo [chan].pipe_cmd != `DRAM_ACC_CMD_IS_NOP))}) // synopsys parallel_case
              3'b100:
                begin
                  chan_final_queue_valid  [chan]   <=   1'b1                                ;
                  chan_final_queue_cmd    [chan]   <=   cmd_seq_pc_fifo [chan].pipe_cmd     ;
                  chan_final_queue_strm   [chan]   <=   cmd_seq_pc_fifo [chan].pipe_strm    ;
                  chan_final_queue_bank   [chan]   <=   cmd_seq_pc_fifo [chan].pipe_bank    ;
                  chan_final_queue_page   [chan]   <=   cmd_seq_pc_fifo [chan].pipe_page    ;
                end                                                                         
                                                                                            
              3'b010:                                                                       
                begin                                                                       
                  chan_final_queue_valid  [chan]   <=   1'b1                                ;
                  chan_final_queue_cmd    [chan]   <=   cmd_seq_po_fifo [chan].pipe_cmd     ;
                  chan_final_queue_strm   [chan]   <=   cmd_seq_po_fifo [chan].pipe_strm    ;
                  chan_final_queue_bank   [chan]   <=   cmd_seq_po_fifo [chan].pipe_bank    ;
                  chan_final_queue_page   [chan]   <=   cmd_seq_po_fifo [chan].pipe_page    ;
                end

              3'b001:
                begin
                  chan_final_queue_valid  [chan]   <=   1'b1                                ;
                  chan_final_queue_cmd    [chan]   <=   cmd_seq_cache_fifo [chan].pipe_cmd  ;
                  chan_final_queue_strm   [chan]   <=   cmd_seq_cache_fifo [chan].pipe_strm ;
                  chan_final_queue_bank   [chan]   <=   cmd_seq_cache_fifo [chan].pipe_bank ;
                  chan_final_queue_page   [chan]   <=   cmd_seq_cache_fifo [chan].pipe_page ;
                  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                    
                    chan_final_queue_line[chan]    <=   cmd_seq_cache_fifo [chan].pipe_line ;
                  `endif
                end

              default:
                begin
                  chan_final_queue_valid  [chan]   <=   1'b0                                ;
                  chan_final_queue_cmd    [chan]   <=   chan_final_queue_cmd    [chan]      ;
                  chan_final_queue_strm   [chan]   <=   chan_final_queue_strm   [chan]      ;
                  chan_final_queue_bank   [chan]   <=   chan_final_queue_bank   [chan]      ;
                  chan_final_queue_page   [chan]   <=   chan_final_queue_page   [chan]      ;
                  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                    
                    chan_final_queue_line[chan]    <=   chan_final_queue_line   [chan]      ;
                  `endif
                end
           endcase
/*
            chan_final_queue_valid [chan]   <=    cmd_seq_pc_fifo [chan].pipe_read | 
                                                  cmd_seq_po_fifo [chan].pipe_read | 
                                                  cmd_seq_cache_fifo[chan].pipe_read ;

            chan_final_queue_cmd   [chan]   <=  ( cmd_seq_pc_fifo [chan].pipe_read ) ? cmd_seq_pc_fifo [chan].pipe_cmd :
                                                                                         cmd_seq_cache_fifo[chan].pipe_cmd ;

            chan_final_queue_strm  [chan]   <=  ( cmd_seq_pc_fifo [chan].pipe_read ) ? cmd_seq_pc_fifo [chan].pipe_strm :
                                                                                         cmd_seq_cache_fifo[chan].pipe_strm ;

            chan_final_queue_bank  [chan]   <=  ( cmd_seq_pc_fifo [chan].pipe_read ) ? cmd_seq_pc_fifo [chan].pipe_bank :
                                                                                         cmd_seq_cache_fifo[chan].pipe_bank ;

            chan_final_queue_page  [chan]   <=  ( cmd_seq_pc_fifo [chan].pipe_read ) ? cmd_seq_pc_fifo [chan].pipe_page :
                                                                                         cmd_seq_cache_fifo[chan].pipe_page ;

            `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                    
              chan_final_queue_line[chan]   <=  cmd_seq_cache_fifo[chan].pipe_line ;
            `endif
*/
          end

      end
  endgenerate



  //----------------------------------------------------------------------------------------------------
  
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
        reg   [ `MMC_CNTL_NUM_OF_INTF_RANGE                  ]   write_strm            ;
        reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE                 ]   write_bank            ;
        reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   write_page            ;
                                                                                      
        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE      ]   pipe_cmd              ;
        wire  [ `MMC_CNTL_NUM_OF_INTF_RANGE                  ]   pipe_strm             ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_bank             ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_page             ;

        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE      ]   pipe_peek_cmd         ;
        wire  [ `MMC_CNTL_NUM_OF_INTF_RANGE                  ]   pipe_peek_strm        ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE                 ]   pipe_peek_bank        ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE                 ]   pipe_peek_page        ;

        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE      ]   pipe_peek_twoIn_cmd   ;
        wire  [ `MMC_CNTL_NUM_OF_INTF_RANGE                  ]   pipe_peek_twoIn_strm  ;
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
        reg   [`MMC_CNTL_NUM_OF_INTF_RANGE                    ]   write_strm            ;
        reg   [`MGR_DRAM_BANK_ADDRESS_RANGE                   ]   write_bank            ;
        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                                
          reg   [`MGR_DRAM_LINE_ADDRESS_RANGE                 ]   write_line            ;
        `endif                                                                          
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_RANGE ]   write_data            ;
                                                                                        
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_RANGE       ]   pipe_cmd              ;
        wire  [`MMC_CNTL_NUM_OF_INTF_RANGE                    ]   pipe_strm             ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                   ]   pipe_bank             ;
        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                                
          wire  [`MGR_DRAM_LINE_ADDRESS_RANGE                 ]   pipe_line             ;
        `endif

        wire  [`MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_RANGE       ]   pipe_peek_cmd         ;
        wire  [`MMC_CNTL_NUM_OF_INTF_RANGE                    ]   pipe_peek_strm        ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                   ]   pipe_peek_bank        ;
        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                                
          wire  [`MGR_DRAM_LINE_ADDRESS_RANGE                 ]   pipe_peek_line        ;
        `endif
      
        wire  [`MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_RANGE       ]   pipe_peek_twoIn_cmd   ;
        wire  [`MMC_CNTL_NUM_OF_INTF_RANGE                    ]   pipe_peek_twoIn_strm  ;
        wire  [`MGR_DRAM_BANK_ADDRESS_RANGE                   ]   pipe_peek_twoIn_bank  ;
        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                                
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

        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                       
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
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                    
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
                       `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                    
                         write_line  <=  chan_final_queue_line [chan]  ;
                       `endif
                     end
                  {1'b1, `DRAM_ACC_NUM_OF_CMDS_WIDTH 'd`DRAM_ACC_CMD_IS_CW } :
                     begin
                       write         <= 1'b1                           ;
                       write_cmd     <=  `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW ;
                       write_strm    <=  chan_final_queue_strm [chan]  ;
                       write_bank    <=  chan_final_queue_bank [chan]  ;
                       `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                    
                         write_line  <=  chan_final_queue_line [chan]  ;
                       `endif
                     end
                  {1'b0, {`DRAM_ACC_NUM_OF_CMDS_WIDTH {1'bx}} } :
                     begin
                       write         <= 1'b0                           ;
                       write_cmd     <=  `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP ;
                       write_strm    <=  chan_final_queue_strm [chan]  ;
                       write_bank    <=  chan_final_queue_bank [chan]  ;
                       `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                    
                         write_line  <=  chan_final_queue_line [chan]  ;
                       `endif
                     end
                  default:
                     begin
                       write         <= 1'b1                  ;
                       write_cmd     <=  `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP ;
                       write_strm    <=  'd0                  ;
                       write_bank    <=  'd0                  ;
                       `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                    
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
  //  - the head of the FIFO gets sent directly to the dram if the fsm is in
  //  the correct page/cache phase
  //  - if we see the head will be empty, we always jump to a NOHEAD state
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
        
            for (int wr_intf=0; wr_intf<`MMC_CNTL_NUM_OF_WRITE_INTF ; wr_intf++)
              begin
                strm_write_data_read [chan][wr_intf]  =  1'b0 ;
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

                          //final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                          //final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;

                          // From the WAIT state, the next state can be either a page command or a page command with write data
                          // so if the RW command fifo isnt empty and the RW command is a write, we need to read the target data fifo based on the
                          // "peeked" RW bank address

                          if (final_page_cmd_fifo[chan].pipe_peek_valid &&  ((final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CR ) || (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP )))
                            begin
                              mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                            end
                          else if (final_page_cmd_fifo[chan].pipe_peek_valid &&  (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW ) )
                            begin
                              mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
                            end
                          else
                            begin
                              mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                            end
            
                     end   
                   end
            
                //------------------------------------------------------------------------------------------------------------------------------------------------------
                //------------------------------------------------------------------------------------------------------------------------------------------------------
                // Page Command states
                //

                `MMC_CNTL_DFI_SEQ_PAGE_CMD: 
                    begin
                        // This state dram_cmd_mode == 1
                        final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                        final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;
                    
                        mmc__dfi__bank_e1 [chan]  =  final_page_cmd_fifo[chan].pipe_bank ;
                        mmc__dfi__addr_e1 [chan]  =  final_page_cmd_fifo[chan].pipe_page ;          
                    
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

                        //--------------------------------------------------
                    
                        if (!final_page_cmd_fifo[chan].pipe_peek_valid)  // no commands coming
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOHEAD_NOP_RW_CMD;
                          end
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP )  // queue has data but the next RW is not a valid RW command
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
                        else
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_RD_CMD;
                          end
                    end
            
                `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA: 
                    begin
                        // This state dram_cmd_mode == 1
                        //
                        // To get to this state, we have pre-read the RW fifo and write data fifo, so drive the write data using the RW bank address
                        // We also know the next 'RW' phase is a write and as we have pre-read the RW fifo just transition to the WR_CMD state
                    
                        final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                        final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;

                        strm_write_data_read [chan][0] = 1'b1 ;  // FIXME: only one write interface???
                        for (int word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
                          begin
                            mmc__dfi__data_e1 [chan] [word]  = write_data_fifo_output_data [0][word];  // FIXME: hard coded write interface
                          end


                        mmc__dfi__bank_e1 [chan]  =  final_page_cmd_fifo[chan].pipe_bank ;
                        mmc__dfi__addr_e1 [chan]  =  final_page_cmd_fifo[chan].pipe_page ;          

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
                    
                        //--------------------------------------------------
        
                        // We already know the next 'RW' phase is a write so transition to the WR_CMD state and load the second data word  
                        mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WR_CMD;
                    
                    end
            
                `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD: 
                    begin
                        // This state dram_cmd_mode == 1
                        // If we are here, the pipe has a NOP page command so it must have a valid CR command at the head
                    
                        if (final_cache_cmd_fifo[chan].pipe_valid)
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_RD_CMD;
                          end
/*
                        else if (~final_page_cmd_fifo[chan].pipe_peek_valid)
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOHEAD_NOP_RW_CMD;
                          end
&*/
                        else if ((final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP ))  // queue has data but the next RW is not a valid RW command  
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
                        else
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_RD_CMD;
                          end              
                    end

                // Head of fifo is empty
                `MMC_CNTL_DFI_SEQ_NOHEAD_NOP_PAGE_CMD: 
                    begin
                        // This state dram_cmd_mode == 1
                        // There should be nothing at the head of the fifo(s)
                        if (final_cache_cmd_fifo[chan].pipe_valid)
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_ERR;
                          end
                        else if (~final_page_cmd_fifo[chan].pipe_peek_valid)
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOHEAD_NOP_RW_CMD;
                          end
                        else if ((final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP ))  // queue has data but the next RW is not a valid RW command  
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
                        else
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_RD_CMD;
                          end              
                    end
            
                `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA: 
                    begin
                        // This state dram_cmd_mode == 1

                        strm_write_data_read [chan][0] = 1'b1 ;  // FIXME: only one write interface???

                        mmc__dfi__bank_e1 [chan]  =  final_page_cmd_fifo[chan].pipe_bank ;
                        mmc__dfi__addr_e1 [chan]  =  final_page_cmd_fifo[chan].pipe_page ;          

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
                    
                        //--------------------------------------------------
        
                        // We already know the next 'RW' phase is a write so transition to the WR_CMD state and load the second data word  
                        mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WR_CMD;
                    
                    end
            
                //------------------------------------------------------------------------------------------------------------------------------------------------------
                //------------------------------------------------------------------------------------------------------------------------------------------------------
                // Cache Command states
                //

                `MMC_CNTL_DFI_SEQ_RD_CMD: 
                    begin
                        // This state dram_cmd_mode == 0
                        // Assumptions:
                        // a) Current command is CR
                        
                        final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                        final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;

                        {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_CR              ;

                        mmc__dfi__bank_e1 [chan]                                              = final_cache_cmd_fifo[chan].pipe_bank ; 
                        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                       
                          mmc__dfi__addr_e1 [chan]                                            = final_cache_cmd_fifo[chan].pipe_line ; 
                        `else
                          mmc__dfi__addr_e1 [chan]                                            = 'd0                               ;
                        `endif
                    
                        if (!final_page_cmd_fifo[chan].pipe_peek_valid  )
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOHEAD_NOP_PAGE_CMD;
                          end
                        // next is nop page command with write data
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW)
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA;
                          end
                        // next is page command with write data
                        else if ((final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP) && (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW))
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
                          end
                        // next is page command
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP)
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                          end
                        else
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD;
                          end
                    
                    end
            
                `MMC_CNTL_DFI_SEQ_WR_CMD:
                    begin
                        // This state dram_cmd_mode == 0
                        // Assumptions:
                        // a) Current command is CW
                        
                        final_page_cmd_fifo [chan].pipe_read  = 1'b1 ;
                        final_cache_cmd_fifo[chan].pipe_read  = 1'b1 ;

                        //strm_write_data_read [chan][0] = 1'b1 ;  // FIXME: only one write interface???

                        {mmc__dfi__cs_e1 [chan], mmc__dfi__cmd1_e1 [chan], mmc__dfi__cmd0_e1[chan]} = `MGR_DRAM_COMMAND_CW              ;

                        mmc__dfi__bank_e1 [chan]                                              = final_cache_cmd_fifo[chan].pipe_bank ; 
                        `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                       
                          mmc__dfi__addr_e1 [chan]                                            = final_cache_cmd_fifo[chan].pipe_line ; 
                        `else
                          mmc__dfi__addr_e1 [chan]                                            = 'd0                               ;
                        `endif

                        if (!final_page_cmd_fifo[chan].pipe_peek_valid  )
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOHEAD_NOP_PAGE_CMD;
                          end
                        // next is nop page command with write data
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW)
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA;
                          end
                        // next is page command with write data
                        else if ((final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP) && (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW))
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
                          end
                        // next is page command
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP)
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                          end
                        else
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD;
                          end
                    
                    end
            
                `MMC_CNTL_DFI_SEQ_NOP_RW_CMD: 
                    begin
                        // This state dram_cmd_mode == 0
                        // Assumptions:
                        // a) Current head of fifo is page command, so next page command is valid

                        // Peek is valid and CW, so next is page command with write data
                        if (final_page_cmd_fifo[chan].pipe_peek_valid && (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW))
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
                          end
                        else if (!final_page_cmd_fifo[chan].pipe_peek_valid && final_cache_cmd_fifo[chan].pipe_peek_twoIn_valid && (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW))
                        // the peek entry is invalid so the twoIn value will automatically move up
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
                          end
                        else
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                          end
                    end
      
                `MMC_CNTL_DFI_SEQ_NOHEAD_NOP_RW_CMD: 
                    begin
                        // This state dram_cmd_mode == 0
                    
                        if (!final_page_cmd_fifo[chan].pipe_peek_valid  )
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOHEAD_NOP_PAGE_CMD;
                          end
                        // next is nop page command with write data
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW)
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA;
                          end
                        // next is page command with write data
                        else if ((final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP) && (final_cache_cmd_fifo[chan].pipe_peek_twoIn_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW))
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
                          end
                        // next is page command
                        else if (final_cache_cmd_fifo[chan].pipe_peek_cmd == `MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP)
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                          end
                        else
                          begin
                            // Command fifo empty so just jump to the NOP PG phase
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD;
                          end
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

  
  reg  [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE          ]   grant_send_to_stream       [`MGR_DRAM_NUM_CHANNELS ] ;  // indicates a channel return data fsm is sending
                                                                          
  reg  [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE          ]   request_send_to_stream     [`MGR_DRAM_NUM_CHANNELS ] ;  // the channel return data fsm sets this if it is sending to the stream
  reg  [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE          ]   waiting_to_send_to_stream  [`MGR_DRAM_NUM_CHANNELS ] ;  // make sure the other channel is waiting for a stream 

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

        assign  clear      =  1'b0  ;

        assign  write      =  cmd_seq_cache_fifo[chan].pipe_read & (cmd_seq_cache_fifo[chan].pipe_cmd == `DRAM_ACC_CMD_IS_CR);
        assign  write_data =  {cmd_seq_cache_fifo[chan].pipe_strm, cmd_seq_cache_fifo[chan].pipe_tag};

        wire  [`MMC_CNTL_NUM_OF_INTF_RANGE    ]   pipe_strm     ;
        wire  [`MMC_CNTL_CMD_GEN_TAG_RANGE  ]   pipe_tag      ;

        assign  {pipe_strm, pipe_tag}  =  pipe_data  ;

        assign  pipe_read = rdp_fsm[chan].read_id_fifo ;

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
            mmc_cntl_rdp_state <= ( reset_poweron ) ? `MMC_CNTL_RDP_WAIT:
                                                       mmc_cntl_rdp_state_next  ;
          end
        
        always @(*)
          begin
            case (mmc_cntl_rdp_state)

              // Let both channel streams continue if they are accessing different banks
              // What about conflicts?
              // a) In the high priority (HP) state, this channel goes first, but it goes to the low priority(LP) state
              // b) In the low priority (LP) state, ther channel waits but it goes to the high priority(LP) state
              //
              // Be careful, when both channels are in the WAIT state, only one will be granted access to a channel conflict.
              // However, the other channel may be granted to a stream because its not yet in the WAIT state, so dont proceed until we see the other channel isnt granted
              // e.g. ther other channels grant will be deasserted once it comes back to the WAIT state
              //
              // Note: Should we simply use tag??? FIXME
              //  - what when most requests are from one stream???

              `MMC_CNTL_RDP_WAIT: 
                begin
                  mmc_cntl_rdp_state_next =  (dfi__mmc__valid_d1[chan] && (data_return_id[chan].pipe_strm == 'd0)) ?  `MMC_CNTL_RDP_STRM0  :
                                             (dfi__mmc__valid_d1[chan] && (data_return_id[chan].pipe_strm == 'd1)) ?  `MMC_CNTL_RDP_STRM1  :
                                                                                                                      `MMC_CNTL_RDP_WAIT   ;                                         
                end                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                         

              `MMC_CNTL_RDP_STRM0: 
                mmc_cntl_rdp_state_next =  ( dfi__mmc__valid_d1[chan]) ?  `MMC_CNTL_RDP_WAIT  :
                                                                          `MMC_CNTL_RDP_STRM0 ;
              `MMC_CNTL_RDP_STRM1: 
                mmc_cntl_rdp_state_next =  ( dfi__mmc__valid_d1[chan]) ?  `MMC_CNTL_RDP_WAIT  :
                                                                          `MMC_CNTL_RDP_STRM1 ;
                                                                                                                                            
                                                                                                                                            
              `MMC_CNTL_RDP_ERR: 
                mmc_cntl_rdp_state_next =  `MMC_CNTL_RDP_ERR       ;
      
              default:
                mmc_cntl_rdp_state_next = `MMC_CNTL_RDP_WAIT ;
          
            endcase // case (mmc_cntl_rdp_state)
          end // always @ (*)


        wire      read_id_fifo     ;  // read the tag/strm ID fifo

        assign read_id_fifo    =  (mmc_cntl_rdp_state == `MMC_CNTL_RDP_STRM0 ) | (mmc_cntl_rdp_state == `MMC_CNTL_RDP_STRM1 );

        // add a pipeline to data to align with the read signal
        reg   [`MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE           ]                                 strm_valid ;
        reg   [`COMMON_STD_INTF_CNTL_RANGE          ]                                 strm_cntl  ;
        reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [`MGR_EXEC_LANE_WIDTH_RANGE ]   strm_data  ;

        //----------------------------------------------------------------------------------------------------
        always @(posedge clk)
          begin
            strm_valid[0]   <= ((mmc_cntl_rdp_state == `MMC_CNTL_RDP_WAIT ) & dfi__mmc__valid_d1[chan] && (data_return_id[chan].pipe_strm == 'd0)) | ((mmc_cntl_rdp_state == `MMC_CNTL_RDP_STRM0 ) & dfi__mmc__valid_d1[chan]) ;
            strm_valid[1]   <= ((mmc_cntl_rdp_state == `MMC_CNTL_RDP_WAIT ) & dfi__mmc__valid_d1[chan] && (data_return_id[chan].pipe_strm == 'd1)) | ((mmc_cntl_rdp_state == `MMC_CNTL_RDP_STRM1 ) & dfi__mmc__valid_d1[chan]) ;
            strm_cntl       <= (mmc_cntl_rdp_state == `MMC_CNTL_RDP_WAIT ) ? `COMMON_STD_INTF_CNTL_SOM : 
                                                                            `COMMON_STD_INTF_CNTL_EOM ;
          end

        for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS; word=word+1) 
          begin: strm_data_reg
            always @(posedge clk)
              begin
                //strm_data  [word] <= dfi__mmc__data_d1[chan] [(word+1)*32-1 : word*32] ;
                strm_data  [word] <= dfi__mmc__data_d1[chan] [word] ;
              end
          end

      end
  endgenerate


  // For each stream, grab the data from the sending channel

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin
        for (strm=0; strm<`MMC_CNTL_NUM_OF_READ_INTF; strm=strm+1) 
          begin
            always @(*)
              begin
                mmc__xxx__valid_e1 [chan][strm]  =  rdp_fsm[chan].strm_valid[strm] ;
              end
          end
      end
  endgenerate

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin
        for (strm=0; strm<`MMC_CNTL_NUM_OF_READ_INTF; strm=strm+1) 
          begin
            always @(*)
              begin
                mmc__xxx__cntl_e1 [chan][strm] = rdp_fsm[chan].strm_cntl ;
              end 
            for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS; word=word+1) 
              begin: return_data
                always @(*)
                  begin
                    mmc__xxx__data_e1 [chan][strm][word] = rdp_fsm[chan].strm_data[word] ;
                  end 
              end
          end
      end
  endgenerate



  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //

endmodule 
  
