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
`include "manager.vh"
`include "main_mem_cntl.vh"

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
            output  reg                                            mmc__mrc__valid   [`MGR_DRAM_NUM_CHANNELS ]                                   [`MGR_NUM_OF_STREAMS ] ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mmc__mrc__cntl    [`MGR_DRAM_NUM_CHANNELS ]                                   [`MGR_NUM_OF_STREAMS ] ,
            input   wire                                           mrc__mmc__ready   [`MGR_DRAM_NUM_CHANNELS ]                                   [`MGR_NUM_OF_STREAMS ] ,
            output  reg   [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__mrc__data    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] [`MGR_NUM_OF_STREAMS ] ,

            //--------------------------------------------------------------------------------
            // DFI Interface
            // - provide per channel signals
            // - DFI will handle SDR->DDR conversion
            input   wire                                           dfi__mmc__init_done                                                                                  ,
            input   wire  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      dfi__mmc__chan_data  [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ]                     ,
            input   wire                                           dfi__mmc__valid      [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg                                            mmc__dfi__cs         [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg                                            mmc__dfi__cmd0       [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg                                            mmc__dfi__cmd1       [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg   [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__dfi__chan_data  [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ]                     ,
            output  reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mmc__dfi__bank       [`MGR_DRAM_NUM_CHANNELS ]                                                       ,
            output  reg   [ `MGR_DRAM_ADDRESS_RANGE         ]      mmc__dfi__addr       [`MGR_DRAM_NUM_CHANNELS ]                                                       ,

  
            //-------------------------------
            // General
            //
            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input  wire                           clk             ,
            input  wire                           reset_poweron  
 
              );   

/*
  localparam   PO   =  3'b000 ; 
  localparam   PC   =  3'b001 ; 
  localparam   PR   =  3'b100 ;
  localparam   CR   =  3'b010 ;
  localparam   CW   =  3'b011 ;
  localparam   NOP  =  3'b111 ;
*/
  
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
  reg  [`COMMON_STD_INTF_CNTL_RANGE      ]    mmc__mrc__cntl_d1    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ]                                 ;
  reg                                         mrc__mmc__ready_e1   [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ]                                 ;
  reg  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]    mmc__mrc__data_e1    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_NUM_OF_STREAMS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] ;

  always @(posedge clk) 
    begin
      for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
        begin: mem_response
          for (int strm=0; strm<`MGR_NUM_OF_STREAMS ; strm++)
            begin: mem_response
              mmc__mrc__valid    [chan] [strm ] <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__valid_e1 [chan] [strm ] ; 
              mmc__mrc__cntl     [chan] [strm ] <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__cntl_e1  [chan] [strm ] ; 
              mrc__mmc__ready_d1 [chan] [strm ] <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__ready    [chan] [strm ] ; 
              mmc__mrc__data     [chan] [strm ] <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__data_e1  [chan] [strm ] ; 
            end
        end
    end

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Request input FIFO

  genvar strm ;
  generate
    for (strm=0; strm<`MGR_NUM_OF_STREAMS ; strm=strm+1) 
      begin: request_fifo

        wire  clear        ;
        wire  almost_full  ;
        wire                                           write        ;
        wire                                           pipe_valid   ;
        wire                                           pipe_read    ;

        wire  [ `COMMON_STD_INTF_CNTL_RANGE     ]      pipe_cntl     ;
        wire  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      pipe_channel  ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      pipe_bank     ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      pipe_page     ;
        wire  [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      pipe_word     ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_REQUEST_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_REQUEST_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ({mrc__mmc__cntl_d1, mrc__mmc__channel_d1, mrc__mmc__bank_d1, mrc__mmc__page_d1, mrc__mmc__word_d1}),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid            ),
                                .pipe_data        ({pipe_cntl, pipe_channel, pipe_bank, pipe_page, pipe_word}),
                                .pipe_read        ( pipe_read             ),

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ); 
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM);

        always @(*)
          begin
            mmc__mrc__ready_e1 [strm] = ~almost_full              ;
            write                     = mrc__mmc__valid_d1 [strm] ;
          end

      end
  endgenerate


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Open Page registers

  genvar chan, bank ;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_BANKS ; chan=chan+1) 
      begin: chan_bank_info
        for (bank=0; bank<`MGR_DRAM_NUM_BANKS ; bank=bank+1) 
          begin: bank_info
        
            reg                                     a_page_is_open       ;
            reg  [`MGR_DRAM_PAGE_ADDRESS_RANGE ]    open_page_id         ;
        
            wire                                    set_a_page_is_open   ;
            wire                                    clear_a_page_is_open ;
        
            always @(posedge clk)
              begin
                a_page_is_open  <= ( reset_poweron        ) ? 1'b0           :
                                   ( set_a_page_is_open   ) ? 1'b1           :
                                   ( clear_a_page_is_open ) ? 1'b0           :
                                                              a_page_is_open ; 
        
                open_page_id    <= ( reset_poweron        ) ?  'd0              :
                                   ( set_open_page_id     ) ? pipe_request_page :
                                                              open_page_id      ; 
              end
        
          end
      end
  endgenerate

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: chan_cmd_gen_fsm
        for (strm=0; strm<`MGR_NUM_OF_STREAMS ; strm=strm+1) 
          begin: strm_fsm
            //----------------------------------------------------------------------------------------------------
            //----------------------------------------------------------------------------------------------------
            // DRAM Command generation FSM
            //  - take memory requests and determine how many commands associated with each request
            //  - If read with nothing open, generate PO-CR
            //  - If read with mismatched open page, generate PC-PO-CR
            //  - read to open page, generate CR
            //  etc.
            // 
          
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
            //   
            
            always @(*)
              begin
                case (mmc_cntl_cmd_gen_state)
                  
                  // Wait for data from all the sources before transferring to NoC
                  `MMC_CNTL_CMD_GEN_WAIT: 
                    mmc_cntl_cmd_gen_state_next =  (( request_fifo[strm].pipe_valid                                                                                                                                                     ) && 
                                                    ( request_fifo[strm].pipe_channel == chan                                                                                                                                            ) && 
                                                    ( chan_bank_info[chan].bank_info[request_fifo[strm].pipe_bank].a_page_is_open && (chan_bank_info[chan].bank_info[request_fifo[strm].pipe_bank].open_page_id == request_fifo[strm].pipe_page))      ) ?   `MMC_CNTL_CMD_GEN_OPEN_PAGE_MATCH     :
                                                   (( request_fifo[strm].pipe_valid                                                                                                                                                     ) && 
                                                    ( request_fifo[strm].pipe_channel == chan                                                                                                                                            ) && 
                                                    ( chan_bank_info[chan].bank_info[request_fifo[strm].pipe_bank].a_page_is_open && (chan_bank_info[chan].bank_info[request_fifo[strm].pipe_bank].open_page_id == request_fifo[strm].pipe_page))      ) ?   `MMC_CNTL_CMD_GEN_OPEN_PAGE_MISMATCH  :
                                                                                                                                                                                                                                                           `MMC_CNTL_CMD_GEN_WAIT                ;
       
                  `MMC_CNTL_CMD_GEN_OPEN_PAGE_MATCH: 
                    mmc_cntl_cmd_gen_state_next =  `MMC_CNTL_CMD_GEN_PAGE_READ       ;
       
                  `MMC_CNTL_CMD_GEN_OPEN_PAGE_MISMATCH: 
                    mmc_cntl_cmd_gen_state_next =  `MMC_CNTL_CMD_GEN_PAGE_CLOSE      ;
       
                  `MMC_CNTL_CMD_GEN_PAGE_CLOSE: 
                    mmc_cntl_cmd_gen_state_next =  `MMC_CNTL_CMD_GEN_PAGE_OPEN       ;
       
                  `MMC_CNTL_CMD_GEN_PAGE_OPEN: 
                    mmc_cntl_cmd_gen_state_next =  `MMC_CNTL_CMD_GEN_PAGE_READ       ;
       
                  `MMC_CNTL_CMD_GEN_PAGE_READ: 
                    mmc_cntl_cmd_gen_state_next =  `MMC_CNTL_CMD_GEN_WAIT       ;
       
                  `MMC_CNTL_CMD_GEN_OPEN_PAGE_MISMATCH: 
                    mmc_cntl_cmd_gen_state_next =  `MMC_CNTL_CMD_GEN_WAIT       ;
       
                  `MMC_CNTL_CMD_GEN_ERR: 
                    mmc_cntl_cmd_gen_state_next =  `MMC_CNTL_CMD_GEN_ERR       ;
       
                  default:
                    mmc_cntl_cmd_gen_state_next = `MMC_CNTL_CMD_GEN_WAIT ;
              
                endcase // case (mmc_cntl_cmd_gen_state)
              end // always @ (*)

            //--------------------------------------------------
            // COntrol
            //  - 
            assign  storagePtr_LocalFifo[0].pipe_read       = (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_START_PTR    ) & wr_destinations_ready |
                                                              (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_APPEND_PTR   ) & wr_destinations_ready |
                                                              (rdp_cntl_noc_data_packet_gen_state == `RDP_CNTL_NOC_PKT_GEN_TRANSFER_PTRS) & wr_destinations_ready ;
          end
  endgenerate

  
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Final command fifos
  // - for page and cache commands, keep a free-running fifo charged with NOPs or CMDs along with bank and address
  //

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: final_page_cmd_fifo

        wire  clear        ;
        wire  almost_full  ;
        wire                                           write        ;
        wire                                           pipe_valid   ;
        wire                                           pipe_read    ;

        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE ]      write_cmd     ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE            ]      write_bank    ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE            ]      write_page    ;

        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE ]      pipe_cmd      ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE            ]      pipe_bank     ;
        wire  [ `MGR_DRAM_PAGE_ADDRESS_RANGE            ]      pipe_page     ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ({write_cmd, write_bank, write_page}),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid            ),
                                .pipe_data        ({pipe_cmd, pipe_bank, pipe_page}),
                                .pipe_read        ( pipe_read             ),

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

      end
  endgenerate


  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: final_cache_cmd_fifo

        wire  clear        ;
        wire  almost_full  ;
        wire                                           write        ;
        wire                                           pipe_valid   ;
        wire                                           pipe_read    ;

        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE        ]   write_cmd     ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE                   ]   write_bank    ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                       
          wire  [ `MGR_DRAM_LINE_ADDRESS_RANGE                 ]   write_line    ;
        `endif
        wire  [ `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_WIDTH ]   write_data    ;

        wire  [ `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE        ]   pipe_cmd      ;
        wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE                   ]   pipe_bank     ;
        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                       
          wire  [ `MGR_DRAM_LINE_ADDRESS_RANGE                 ]   pipe_line     ;
        `endif
        wire  [ `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_WIDTH ]   pipe_data     ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ( write_data            )
                                 // Read                                  
                                .pipe_valid       ( pipe_valid            ),
                                .pipe_data        ( pipe_data             ),
                                .pipe_read        ( pipe_read             ),

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

        `ifdef  MGR_DRAM_REQUEST_LT_PAGE                       
          assign write_data  = {write_cmd, write_bank, write_line} ;
          assign {pipe_cmd, pipe_bank, pipe_line} = pipe_data ;
        `else
          assign write_data  = {write_cmd, write_bank} ;
          assign {pipe_cmd, pipe_bank} = pipe_data ;
        `endif

      end
  endgenerate


  
  //----------------------------------------------------------------------------------------------------
  // Control page and cache clock phases
  reg dram_cmd_mode;

  always@(posedge clock)
  begin
    if(reset_poweron || !dfi__drv__init_done)
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
        
        always@(posedge clock)
          begin
            if(reset)
              mmc_cntl_seq_state <= ( reset_poweron ) ? `MMC_CNTL_DFI_SEQ_WAIT     :
                                                        mmc_cntl_seq_state_next    ;
          end
        
        // now we only really have one fifo, create a generic command fifo empty and
        // cerate an error flags if the two empty signals arent the same
        wire fq__drv__cmd_empty               = fq__drv__pgcmd_cmd_empty ;
        wire fq__drv__cmd_hasTwoOrMoreEntires = fq__drv__pgcmd_hasTwoOrMoreEntires ;
        
        wire exc_fq__drv__cmd_fifo_error = (fq__drv__pgcmd_cmd_empty != fq__drv__rwcmd_cmd_empty                     ) |
                                           (fq__drv__pgcmd_hasTwoOrMoreEntires != fq__drv__rwcmd_hasTwoOrMoreEntires ) ;
        
        always@(*)
          begin
        
            //----------------------------------------------------------------------------------------------------
            // Default drive values
        
            `SCH_DRIVER_DO_NOT_READ_FINAL_QUEUES 
        
            {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b000 ;  // NOP
            drv__dfi__bank_addr                          = 0      ; 
            drv__dfi__rc_addr                            = 0      ; 
            drv__dfi__data1                              = 0      ;
            drv__dfi__data2                              = 0      ;
            
            `include "sch_driver_data_rd_en_disable.vh"  
        
            //----------------------------------------------------------------------------------------------------
            // State defined drive values
        
            case(mmc_cntl_seq_state)
            
                `MMC_CNTL_DFI_SEQ_WAIT: 
                    begin
            
                    if(reset || !dfi__drv__init_done || fq__drv__cmd_empty || (dram_cmd_mode == 1'b1)) //if initialization not done
                      begin
                          mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WAIT;
                      end
                    // we will always see a page command first, but ensure we first respond to page command after reset to synchronize with the DiRAM4
                    else  
                      begin
            
                         `SCH_DRIVER_READ_FINAL_QUEUES 
        
                         // From the WAIT state, the next state can be     // so if the RW command fifo isnt empty and the RW command is a write, we need to read the target data fifo based on the
                         // "peeked" RW bank address
                          // first time thu its gonna be 
                          if      (fq__drv__cmd_hasTwoOrMoreEntires &&  (fq__drv__rwcmd_cmd_peek_twoIn_rd_data == CR) || (fq__drv__rwcmd_cmd_peek_twoIn_rd_data == NOP))
                            begin
                              mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD;
                            end
                          else if (fq__drv__cmd_hasTwoOrMoreEntires &&  fq__drv__rwcmd_cmd_peek_twoIn_rd_data == CW)
                            begin
                              mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA;
            
                              // need to prepare write data to be output one cycle early with page command
                              `include "sch_driver_peek_select_data_fifo.vh"  
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
                    
                        // DFI Output
                        if(fq__drv__pgcmd_cmd_rd_data == PO)
                           {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b011; //page open  // FIXME : use defines
                        else if(fq__drv__pgcmd_cmd_rd_data == PC)
                           {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b010; //page close
                        else if(fq__drv__pgcmd_cmd_rd_data == PR)
                           {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b001; //page refresh
                        else if(fq__drv__pgcmd_cmd_rd_data == NOP)
                           {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b000; //nop
                    
                        drv__dfi__bank_addr                             = fq__drv__pgcmd_bank_addr_rd_data; 
                        drv__dfi__rc_addr                               = fq__drv__pgcmd_page_addr_rd_data; 
                    
                        if(fq__drv__cmd_empty)
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
              
                        else if (fq__drv__rwcmd_cmd_peek_rd_data == NOP)  // queue has data but the next RW is not a valid RW command
                          begin
        
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
                        else
                          // if the RW command fifo isnt empty, we either got to the page command because the RW fifo contains a read 
                          // 'or' a write command has just arrived
                          // If a write command has just arrived, its too late to preread the data to have it available during this current command phase,
                          // so we'll jump to the RW NOP state where we can assert the data fifo read enable and then we'll jump to the PAGE_CMD_WITH_WR_DATA state
                          begin
            
                            if      (fq__drv__rwcmd_cmd_peek_rd_data == CR)
                              begin
                                `SCH_DRIVER_READ_FINAL_QUEUES 
        
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
                    
                        // It is a valid 'Page' phase, so drive the DFI interface
                        if(fq__drv__pgcmd_cmd_rd_data == PO)
                           {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b011; //page open
                        else if(fq__drv__pgcmd_cmd_rd_data == PC)
                           {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b010; //page close
                        else if(fq__drv__pgcmd_cmd_rd_data == PR)
                           {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b001; //page refresh
                        else if(fq__drv__pgcmd_cmd_rd_data == NOP)
                           {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b000; //nop
                    
                        drv__dfi__bank_addr                             = fq__drv__pgcmd_bank_addr_rd_data; 
                        drv__dfi__rc_addr                               = fq__drv__pgcmd_page_addr_rd_data; 
                    
                        `SCH_DRIVER_READ_FINAL_QUEUES 
        
                        // We already know the next RW command is a WR and we have pre-read the write data fifo, so use the peeked RW bank addr to 
                        // select data to drive onto the dfi interface drv__dfi__data[1:2]
                        // remember, we write the first chunk of data during the PG cmd phase prior to the WR during the RW phase
                        `include "sch_driver_peek_get_data_fifo.vh"  
                    
                         // We know the next 'RW' phase is a write so transition to the WR_CMD state and load the second data word  
                         // Remember, we had pre-read the RW fifo so no RW fifo reads occur in this state
                         mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WR_CMD;
                    
                        // Pre-read the write data fifo based on the bank address in the peeked RW bank address fifo
                         `include "sch_driver_select_data_fifo.vh"  
                    end
            
                `MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD: 
                    begin
                        // This state dram_cmd_mode == 1
                    
                        if(fq__drv__cmd_empty)
                          begin
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
              
                        else if (fq__drv__rwcmd_cmd_peek_rd_data == NOP)  // queue has data but the next RW is not a valid RW command
                          begin
        
                            mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_NOP_RW_CMD;
                          end
                        else
                          // if the RW command fifo isnt empty, we either got to the page command because the RW fifo contains a read 
                          // 'or' a write command has just arrived
                          // If a write command has just arrived, its too late to preread the data to have it available during this current command phase,
                          // so we'll jump to the RW NOP state where we can assert the data fifo read enable and then we'll jump to the PAGE_CMD_WITH_WR_DATA state
                          begin
            
                            if      (fq__drv__rwcmd_cmd_peek_rd_data == CR)
                              begin
                                `SCH_DRIVER_READ_FINAL_QUEUES 
        
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
                        `SCH_DRIVER_READ_FINAL_QUEUES 
                    
                        // Output of write data fifo is valid so drive onto dfi interface
                        // driver drv__dfi__data[1:2]
                        `include "sch_driver_peek_get_data_fifo.vh"  
                    
                        // We know the next 'RW' phase is a write so transition to the WR_CMD state and load the second data word  
                        // Remember, we had pre-read the RW fifo so no RW fifo reads occur in this state
                        mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WR_CMD;
                    
                        `include "sch_driver_select_data_fifo.vh"  
                    end
            
                `MMC_CNTL_DFI_SEQ_RD_CMD: 
                    begin
                    
                        // This state dram_cmd_mode == 0
                        {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b010; //cache read 
                        drv__dfi__bank_addr                          = fq__drv__rwcmd_bank_addr_rd_data; 
                        drv__dfi__rc_addr                            = fq__drv__rwcmd_cache_addr_rd_data; 
                        drv__dfi__data1                              = 0;
                        drv__dfi__data2                              = 0;
                    
                        `include "sch_driver_rw_state_transitions.vh"  
                    
                    end
            
                `MMC_CNTL_DFI_SEQ_WR_CMD:
                    begin
                    
                        // This state dram_cmd_mode == 0
                        {drv__dfi__cs,drv__dfi__cmd1,drv__dfi__cmd0} = 3'b011; //cache write 
                        drv__dfi__bank_addr                          = fq__drv__rwcmd_bank_addr_rd_data; 
                        drv__dfi__rc_addr                            = fq__drv__rwcmd_cache_addr_rd_data; 
                    
                        `include "sch_driver_rw_state_transitions.vh"  
                        `include "sch_driver_get_data_fifo.vh"  
                    end
            
                `MMC_CNTL_DFI_SEQ_NOP_RW_CMD: 
                    begin
                        `include "sch_driver_rw_state_transitions.vh"  
                    end
      
                default:
                    begin
        		mmc_cntl_seq_state_next = `MMC_CNTL_DFI_SEQ_WAIT;
                    end
      
            endcase 
          end
       
  endgenerate

  // end of DFI Sequencer FSM(s)
  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
 
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //
  endmodule 
  
