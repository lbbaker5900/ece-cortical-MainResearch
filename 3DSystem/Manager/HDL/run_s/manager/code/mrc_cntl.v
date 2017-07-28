/*********************************************************************************************

    File name   : mrc_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

    Description : Take descriptors from the WU decoder and constructs main memory read requests

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
`include "mrc_cntl.vh"
`include "python_typedef.vh"


module mrc_cntl (  

            //-------------------------------
            // From WU Decoder
            // - receiver MR descriptorss
            //
            input   wire                                           wud__mrc__valid                                 ,  // send MR descriptors
            output  reg                                            mrc__wud__ready                                 ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE    ]        wud__mrc__cntl                                  ,  // descriptor delineator
            input   wire  [`MGR_WU_OPT_TYPE_RANGE         ]        wud__mrc__option_type   [`MGR_WU_OPT_PER_INST ] ,  // WU Instruction option fields
            input   wire  [`MGR_WU_OPT_VALUE_RANGE        ]        wud__mrc__option_value  [`MGR_WU_OPT_PER_INST ] ,  
            
            //-------------------------------
            // Stack Bus - Downstream arguments
            //
            output  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE     ]      mrc__std__lane_valid                                   ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__std__lane_cntl     [`MGR_NUM_OF_EXEC_LANES_RANGE ],
            input   wire  [`MGR_NUM_OF_EXEC_LANES_RANGE     ]      std__mrc__lane_ready                                   ,
            output  reg   [`STACK_DOWN_INTF_STRM_DATA_RANGE ]      mrc__std__lane_data     [`MGR_NUM_OF_EXEC_LANES_RANGE ],

            //-------------------------------
            // Main Memory Controller interface
            // - response must be in order
            //
            output  reg                                            mrc__mmc__valid                                   ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mmc__cntl                                    ,
            input   wire                                           mmc__mrc__ready                                   ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE  ]      mrc__mmc__channel                                 ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE     ]      mrc__mmc__bank                                    ,
            output  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE     ]      mrc__mmc__page                                    ,
            output  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE     ]      mrc__mmc__word                                    ,
                                                                                                                    
            // MMC provides data from each DRAM channel
            input   wire                                                                          mmc__mrc__valid [`MGR_DRAM_NUM_CHANNELS ] ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE          ]                                 mmc__mrc__cntl  [`MGR_DRAM_NUM_CHANNELS ] ,
            output  reg                                                                           mrc__mmc__ready [`MGR_DRAM_NUM_CHANNELS ] ,
            input   wire  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  mmc__mrc__data  [`MGR_DRAM_NUM_CHANNELS ] ,

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
 
  //-------------------------------
  // Stack Bus - Downstream arguments
  //
  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE     ]   std__mrc__lane_ready_d1                                 ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]   mrc__std__lane_cntl_e1   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
  reg   [`STACK_DOWN_INTF_STRM_DATA_RANGE ]   mrc__std__lane_data_e1   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
  reg   [`MGR_NUM_OF_EXEC_LANES_RANGE     ]   mrc__std__lane_valid_e1                                 ;

  //--------------------------------------------------
  // Memory Read Controller(s)
  
  reg                                         wud__mrc__valid_d1             ;
  reg                                         mrc__wud__ready_e1             ;
  reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mrc__cntl_d1              ;  
  reg    [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mrc__option_type_d1    [`MGR_WU_OPT_PER_INST ] ;
  reg    [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mrc__option_value_d1   [`MGR_WU_OPT_PER_INST ] ;


  //--------------------------------------------------
  // from Main Memory Controller
  
  reg                                         mmc__mrc__valid_d1   [`MGR_DRAM_NUM_CHANNELS ]                                 ;
  reg  [`COMMON_STD_INTF_CNTL_RANGE      ]    mmc__mrc__cntl_d1    [`MGR_DRAM_NUM_CHANNELS ]                                 ;
  wire                                        mrc__mmc__ready_e1   [`MGR_DRAM_NUM_CHANNELS ]                                 ;
  reg  [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]    mmc__mrc__data_d1  [`MGR_DRAM_NUM_CHANNELS ]  ;

  //--------------------------------------------------
  // to Main Memory Controller

  reg                                            mrc__mmc__valid_e1      ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mmc__cntl_e1       ;
  reg                                            mmc__mrc__ready_d1      ;
  reg   [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mrc__mmc__channel_e1    ;
  reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mrc__mmc__bank_e1       ;
  reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mrc__mmc__page_e1       ;
  reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      mrc__mmc__word_e1       ;


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Register inputs and outputs

  //--------------------------------------------------
  // Stack Bus - Downstream arguments
  //  - we have an output for each execution lane
  
  always @(posedge clk) 
    begin
      for (int lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
        begin: lane_drive
          mrc__std__lane_valid    [lane]  <=   ( reset_poweron   ) ? 'd0  :  mrc__std__lane_valid_e1 [lane]  ; 
          mrc__std__lane_cntl     [lane]  <=   ( reset_poweron   ) ? 'd0  :  mrc__std__lane_cntl_e1  [lane]  ;
          mrc__std__lane_data     [lane]  <=   ( reset_poweron   ) ? 'd0  :  mrc__std__lane_data_e1  [lane]  ;
          std__mrc__lane_ready_d1 [lane]  <=   ( reset_poweron   ) ? 'd0  :  std__mrc__lane_ready    [lane]  ;
        end
    end

  //--------------------------------------------------
  // from WU Decoder
  
  always @(posedge clk) 
    begin
      wud__mrc__valid_d1        <=   ( reset_poweron   ) ? 'd0  :  wud__mrc__valid        ;
      wud__mrc__cntl_d1         <=   ( reset_poweron   ) ? 'd0  :  wud__mrc__cntl        ;

      for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
        begin: option_in
          wud__mrc__option_type_d1  [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mrc__option_type  [opt]  ;
          wud__mrc__option_value_d1 [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mrc__option_value [opt]  ;
        end

      mrc__wud__ready        <=   ( reset_poweron   ) ? 'd0  :  mrc__wud__ready_e1       ;

    end

  //--------------------------------------------------
  // from Main Memory Controller
  
  always @(posedge clk) 
    begin
      for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
        begin
          mmc__mrc__valid_d1 [chan]       <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__valid [chan] ;
          mmc__mrc__cntl_d1  [chan]       <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__cntl  [chan] ;
         
          for (int word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
            begin: data
              mmc__mrc__data_d1 [chan][word] <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__data [chan][word]  ;
            end
         
          mrc__mmc__ready [chan]          <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__ready_e1 [chan] ;

        end
    end
    //--------------------------------------------------
    // to Main Memory Controller

    always @(posedge clk) 
      begin
        mrc__mmc__valid      <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__valid_e1   ;
        mrc__mmc__cntl       <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__cntl_e1    ;
        mmc__mrc__ready_d1   <=   ( reset_poweron   ) ? 'd0  :  mmc__mrc__ready      ;
        mrc__mmc__channel    <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__channel_e1 ;
        mrc__mmc__bank       <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__bank_e1    ;
        mrc__mmc__page       <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__page_e1    ;
        mrc__mmc__word       <=   ( reset_poweron   ) ? 'd0  :  mrc__mmc__word_e1    ;
      end


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // MR Descriptor FIFO
  //

  genvar gvi,chan;
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Wud_Fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_cntl          ;
        reg    [`MGR_WU_OPT_TYPE_RANGE          ]         write_option_type    [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        reg    [`MGR_WU_OPT_VALUE_RANGE         ]         write_option_value   [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
                                                                           
        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_cntl           ;
        wire   [`MGR_WU_OPT_TYPE_RANGE          ]         read_option_type     [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        wire   [`MGR_WU_OPT_VALUE_RANGE         ]         read_option_value    [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        //wire                                              almost_empty     ; 
        wire                                              read             ; 
        wire                                              write            ; 
 
        // Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`MRC_CNTL_DESC_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`MRC_CNTL_DESC_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_WU_OPT_PER_INST*`MGR_WU_OPT_TYPE_WIDTH+`MGR_WU_OPT_PER_INST*`MGR_WU_OPT_VALUE_WIDTH )
                        ) gfifo (
                                          // Status
                                         .empty            ( empty                                                     ),
                                         .almost_full      ( almost_full                                               ),
                                         .almost_empty     (                                                           ),
                                         .depth            (                                                           ),

                                          // Write                                                                    
                                         .write            ( write                                                     ),
                                         .write_data       ( {write_cntl,  write_option_type[0], write_option_value[0],
                                                                           write_option_type[1], write_option_value[1],
                                                                           write_option_type[2], write_option_value[2]}),
                                          // Read                          
                                         .read             ( read                                                      ),
                                         .read_data        ( { read_cntl,   read_option_type[0],  read_option_value[0],
                                                                            read_option_type[1],  read_option_value[1],
                                                                            read_option_type[2],  read_option_value[2]}),

                                         // General
                                         .clear            ( clear                                                     ),
                                         .reset_poweron    ( reset_poweron                                             ),
                                         .clk              ( clk                                                       )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        // pipe stage
        always @(posedge clk)
          begin
            fifo_pipe_valid <= ( reset_poweron      ) ? 'b0               :
                               ( read               ) ? 'b1               :
                               ( fifo_pipe_read     ) ? 'b0               :
                                                         fifo_pipe_valid  ;
          end
        reg                                                  pipe_valid        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_cntl         ;
        reg    [`MGR_WU_OPT_TYPE_RANGE          ]            pipe_option_type  [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        reg    [`MGR_WU_OPT_VALUE_RANGE         ]            pipe_option_value [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        wire                                                 pipe_read         ;

        assign read           = ~empty          & (~fifo_pipe_valid | fifo_pipe_read) ; // keep the pipe charged
        assign fifo_pipe_read = fifo_pipe_valid & (~pipe_valid      | pipe_read     ) ; 

        // If we are reading the fifo, then this stage will be valid
        // If we are not reading the fifo but the next stage is reading this stage, then this stage will not be valid

        always @(posedge clk)
          begin
            // If we are reading the previous stage, then this stage will be valid
            // otherwise if we are reading this stage this stage will not be valid
            pipe_valid      <= ( reset_poweron      ) ? 'b0              :
                               ( fifo_pipe_read     ) ? 'b1              :
                               ( pipe_read          ) ? 'b0              :
                                                         pipe_valid      ;
        
            // if we are reading, transfer from previous pipe stage. 
            pipe_cntl           <= ( fifo_pipe_read     ) ? read_cntl            :
                                                            pipe_cntl            ;
            pipe_option_type[0] <= ( fifo_pipe_read     ) ? read_option_type[0]  :
                                                            pipe_option_type[0]  ;
            pipe_option_type[1] <= ( fifo_pipe_read     ) ? read_option_type[1]  :
                                                            pipe_option_type[1]  ;
            pipe_option_type[2] <= ( fifo_pipe_read     ) ? read_option_type[2]  :
                                                            pipe_option_type[2]  ;
            pipe_option_value[0] <= ( fifo_pipe_read    ) ? read_option_value[0] :
                                                            pipe_option_value[0] ;
            pipe_option_value[1] <= ( fifo_pipe_read    ) ? read_option_value[1] :
                                                            pipe_option_value[1] ;
            pipe_option_value[2] <= ( fifo_pipe_read    ) ? read_option_value[2] :
                                                            pipe_option_value[2] ;
          end

        // wires to make FSM decodes look cleaner
        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    );  // use with pipe_valid
        //wire   pipe_mom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    );  // use with pipe_valid
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    );  // use with pipe_valid
        //wire   pipe_som_eom =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM);  // use with pipe_valid

      end
  endgenerate


  assign from_Wud_Fifo[0].clear   =   1'b0                ;
  assign from_Wud_Fifo[0].write   =   wud__mrc__valid_d1  ;
  always @(*)
    begin
      from_Wud_Fifo[0].write_cntl    =   wud__mrc__cntl_d1   ;
      for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
        begin: option_in
          from_Wud_Fifo[0].write_option_type  [opt]   =   wud__mrc__option_type_d1  [opt]  ;
          from_Wud_Fifo[0].write_option_value [opt]   =   wud__mrc__option_value_d1 [opt]  ;
        end
    end
         
  assign mrc__wud__ready_e1              = ~from_Wud_Fifo[0].almost_full  ;



  //----------------------------------------------------------------------------------------------------
  // Examine all the options in each tuple
  // Extract:
  //   - number of lanes
  //   - pointer to the storage descriptor
  //   - memory to target transfer type (vector or broadcast)
  //   - the target (arg0 or arg1 downstream)
  //

  reg  [`MGR_NUM_LANES_RANGE            ]      num_lanes         ;  // 0-32 so need 6 bits
  // for memory reads, we assume one storage descriptor pointer
  reg  [`MGR_STORAGE_DESC_ADDRESS_RANGE ]      storage_desc_ptr  ;  // pointer to local storage descriptor although msb's contain manager ID, so remove
  // use option tuple range
  reg  [`MGR_INST_OPTION_TRANSFER_RANGE ]      txfer_type        ;  // FIXME: wastes bits by using option_value for range
  reg  [`MGR_INST_OPTION_TGT_RANGE      ]      target            ;

  wire                                         extracting_descriptor_state   ;  // Descriptor FSM in states where the descriptor is being processed
  wire                                         descriptor_fsm_complete       ;  // Descriptor FSM in complete state

  genvar optNum;
  generate
    for (optNum=0; optNum<`MGR_WU_OPT_PER_INST; optNum=optNum+1) 
      begin: option

        // create a pulse when the tuples contain what we are looking for
        wire   contains_num_lanes    ;  
        wire   contains_storage_ptr  ;  
        wire   contains_txfer_type   ;  
        wire   contains_target       ;  

        assign contains_num_lanes   = from_Wud_Fifo[0].pipe_valid  && (from_Wud_Fifo[0].pipe_option_type[optNum] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES ) ;
        assign contains_storage_ptr = from_Wud_Fifo[0].pipe_valid  && (from_Wud_Fifo[0].pipe_option_type[optNum] == PY_WU_INST_OPT_TYPE_MEMORY       ) ;
        assign contains_target      = from_Wud_Fifo[0].pipe_valid  && (from_Wud_Fifo[0].pipe_option_type[optNum] == PY_WU_INST_OPT_TYPE_TGT          ) ;  // arg0 or arg1 
        assign contains_txfer_type  = from_Wud_Fifo[0].pipe_valid  && (from_Wud_Fifo[0].pipe_option_type[optNum] == PY_WU_INST_OPT_TYPE_TXFER        ) ;  // bcast or vector

      end
  endgenerate

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Extract option values
  always @(posedge clk)
    begin
      num_lanes        <=  ( reset_poweron                                                ) ?  'd0                                  :
                           ( option[0].contains_num_lanes && extracting_descriptor_state  ) ? from_Wud_Fifo[0].pipe_option_value[0] :
                           ( option[1].contains_num_lanes && extracting_descriptor_state  ) ? from_Wud_Fifo[0].pipe_option_value[1] :
                           ( option[2].contains_num_lanes && extracting_descriptor_state  ) ? from_Wud_Fifo[0].pipe_option_value[2] :
                           ( descriptor_fsm_complete                                      ) ? 'd0                                   :
                                                                                              num_lanes                             ;

      // storage descriptor option type will always be in tuple 0 or tuple 1 because its an extended tuple
      storage_desc_ptr <=  ( reset_poweron                                                ) ?  'd0                                                                                                                :
                           ( option[0].contains_storage_ptr && extracting_descriptor_state) ? {from_Wud_Fifo[0].pipe_option_value[0], from_Wud_Fifo[0].pipe_option_type[1],from_Wud_Fifo[0].pipe_option_value[1]} :
                           ( option[1].contains_storage_ptr && extracting_descriptor_state) ? {from_Wud_Fifo[0].pipe_option_value[1], from_Wud_Fifo[0].pipe_option_type[2],from_Wud_Fifo[0].pipe_option_value[2]} :
                           ( descriptor_fsm_complete                                      ) ? 'd0                                                                                                                 :
                                                                                              storage_desc_ptr                                                                                                    ;

      txfer_type       <=  ( reset_poweron                                                ) ?  'd0                                  :
                           ( option[0].contains_txfer_type && extracting_descriptor_state ) ? from_Wud_Fifo[0].pipe_option_value[0] :
                           ( option[1].contains_txfer_type && extracting_descriptor_state ) ? from_Wud_Fifo[0].pipe_option_value[1] :
                           ( option[2].contains_txfer_type && extracting_descriptor_state ) ? from_Wud_Fifo[0].pipe_option_value[2] :
                           ( descriptor_fsm_complete                                      ) ? 'd0                                   :
                                                                                              txfer_type                            ;

      target           <=  ( reset_poweron                                                ) ?  'd0                                  :
                           ( option[0].contains_target && extracting_descriptor_state     ) ? from_Wud_Fifo[0].pipe_option_value[0] :
                           ( option[1].contains_target && extracting_descriptor_state     ) ? from_Wud_Fifo[0].pipe_option_value[1] :
                           ( option[2].contains_target && extracting_descriptor_state     ) ? from_Wud_Fifo[0].pipe_option_value[2] :
                           ( descriptor_fsm_complete                                      ) ? 'd0                                   :
                                                                                              target                                ;
    end


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Extract Descriptor FSM
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // - Take storage descriptor option tuples from the WU fifo and construct starting address, number of lanes
  //   target and transfer type (vector/scalar).
  // - Send initial memory request based on starting channel/bank/page/word
  //   Extract the consequtive/jump tuples and pipeline memory requests
  //   Pass the consequtive/jump tuples to another fifo which will be processed by the streaming fsm
  //   Note: We have to send to another fifo because we want to pipeline the memory page accesses
  // - With memory requests, we always request the starting chan/bank/page but we will also grab the next channel also.
  //   So we need to form an address using only the chan, bank and page based on the increment order of page,bank,chan and increment and request this chan/bank/page also
  //

  reg  storage_desc_processing_enable    ;  // tell the storage descriptor processor fsm to start
  wire storage_desc_processing_complete ;  // storage descriptor processor fsm complete
      
  // State register 
  reg [`MRC_CNTL_EXTRACT_DESC_STATE_RANGE ] mrc_cntl_extract_desc_state      ; // state flop
  reg [`MRC_CNTL_EXTRACT_DESC_STATE_RANGE ] mrc_cntl_extract_desc_state_next ;

  always @(posedge clk)
    begin
      mrc_cntl_extract_desc_state <= ( reset_poweron ) ? `MRC_CNTL_EXTRACT_DESC_WAIT        :
                                                          mrc_cntl_extract_desc_state_next  ;
    end
  

  always @(*)
    begin
      case (mrc_cntl_extract_desc_state)
        
        `MRC_CNTL_EXTRACT_DESC_WAIT: 
          mrc_cntl_extract_desc_state_next =   ( from_Wud_Fifo[0].pipe_valid && ~from_Wud_Fifo[0].pipe_som ) ? `MRC_CNTL_EXTRACT_DESC_ERR      :  // right now assume MR desciptors are multi-cycle
                                               ( from_Wud_Fifo[0].pipe_valid                               ) ? `MRC_CNTL_EXTRACT_DESC_EXTRACT  :  // pull all we need from the descriptor then start memory access
                                                                                                               `MRC_CNTL_EXTRACT_DESC_WAIT     ;
  
        // Cycle thru memory descriptor grabing num_lanes, txfer_type, target and storage descriptor pointer
        // Dont leave this state until we see the end-of-descriptor
        `MRC_CNTL_EXTRACT_DESC_EXTRACT: 
          mrc_cntl_extract_desc_state_next =   ( from_Wud_Fifo[0].pipe_valid && from_Wud_Fifo[0].pipe_eom ) ? `MRC_CNTL_EXTRACT_DESC_START_PROCESSING :  // read the descriptor
                                                                                                              `MRC_CNTL_EXTRACT_DESC_EXTRACT          ;

        // Cycle thru memory descriptor grabing num_lanes, txfer_type, target and storage descriptor pointer
        // Dont leave this state until we see the end-of-descriptor
        `MRC_CNTL_EXTRACT_DESC_START_PROCESSING: 
          mrc_cntl_extract_desc_state_next =   ( storage_desc_processing_complete ) ? `MRC_CNTL_EXTRACT_DESC_COMPLETE         :
                                                                                      `MRC_CNTL_EXTRACT_DESC_START_PROCESSING ;

        `MRC_CNTL_EXTRACT_DESC_COMPLETE: 
          mrc_cntl_extract_desc_state_next =   (~storage_desc_processing_complete ) ? `MRC_CNTL_EXTRACT_DESC_WAIT     :
                                                                                      `MRC_CNTL_EXTRACT_DESC_COMPLETE ;

        default:
          mrc_cntl_extract_desc_state_next =   `MRC_CNTL_EXTRACT_DESC_WAIT     ;

      endcase // case (mrc_cntl_extract_desc_state)
    end // always @ (*)


  assign from_Wud_Fifo[0].pipe_read = (from_Wud_Fifo[0].pipe_valid && (mrc_cntl_extract_desc_state == `MRC_CNTL_EXTRACT_DESC_WAIT   ) && ~from_Wud_Fifo[0].pipe_som ) |
                                      (from_Wud_Fifo[0].pipe_valid && (mrc_cntl_extract_desc_state == `MRC_CNTL_EXTRACT_DESC_EXTRACT)                               ) ;

  assign  extracting_descriptor_state  =  ((mrc_cntl_extract_desc_state == `MRC_CNTL_EXTRACT_DESC_WAIT     ) || (mrc_cntl_extract_desc_state == `MRC_CNTL_EXTRACT_DESC_EXTRACT )) ;
  assign  descriptor_fsm_complete      =   (mrc_cntl_extract_desc_state == `MRC_CNTL_EXTRACT_DESC_COMPLETE )                                                                      ;

  always @(posedge clk)
    begin
      storage_desc_processing_enable  <= ( reset_poweron )  ? 1'b0 : 
                                        ( mrc_cntl_extract_desc_state == `MRC_CNTL_EXTRACT_DESC_START_PROCESSING   ) ? 1'b1                          :
                                        ( mrc_cntl_extract_desc_state == `MRC_CNTL_EXTRACT_DESC_COMPLETE) ? 1'b0                          :
                                                                                                                       storage_desc_processing_enable ;

    end
      

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Storage Descriptor processor
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // - Generate memory requests from tuple options

  wire  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_valid                                                     ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE         ]   sdp__xxx__lane_cntl                                                      ;
  wire  [`MGR_NUM_OF_EXEC_LANES_RANGE        ]   sdp__xxx__lane_enable                                                    ;
  wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]   sdp__xxx__lane_channel_ptr               [`MGR_NUM_OF_EXEC_LANES_RANGE ] ;
  wire  [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE  ]   sdp__xxx__lane_word_ptr                  [`MGR_NUM_OF_EXEC_LANES_RANGE ] ; 

  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   mem_request_channel_data_valid                                           ;  // valid data from channel data fifo
  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   sdp__xxx__get_next_line                                                  ;

  // Associate this address with the response from the MMC
  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   xxx__sdp__mem_request_valid                                              ;
//  wire  [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE ]   sdp__xxx__mem_request_ack                                                ;  // actually a read to the request feedback fifo
  wire  [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]   xxx__sdp__mem_request_channel            [`MGR_DRAM_NUM_CHANNELS ]       ;
  wire  [`MGR_DRAM_BANK_ADDRESS_RANGE        ]   xxx__sdp__mem_request_bank               [`MGR_DRAM_NUM_CHANNELS ]       ;
  wire  [`MGR_DRAM_PAGE_ADDRESS_RANGE        ]   xxx__sdp__mem_request_page               [`MGR_DRAM_NUM_CHANNELS ]       ;
  wire  [`MGR_DRAM_WORD_ADDRESS_RANGE        ]   xxx__sdp__mem_request_word               [`MGR_DRAM_NUM_CHANNELS ]       ;

  sdp_cntl sdp_cntl (  

           .xxx__sdp__storage_desc_processing_enable     ( storage_desc_processing_enable    ),
           .sdp__xxx__storage_desc_processing_complete   ( storage_desc_processing_complete  ),
           .xxx__sdp__storage_desc_ptr                   ( storage_desc_ptr                  ),  // pointer to local storage descriptor although msb's contain manager ID, so remove
           .xxx__sdp__num_lanes                          ( num_lanes                         ),
           .xxx__sdp__txfer_type                         ( txfer_type                        ),
           .xxx__sdp__target                             ( target                            ),

           //-------------------------------
           // Main Memory Controller interface
           // - response must be in order
           //
           .sdp__xxx__mem_request_valid                  ( mrc__mmc__valid_e1                ),
           .sdp__xxx__mem_request_cntl                   ( mrc__mmc__cntl_e1                 ),
           .xxx__sdp__mem_request_ready                  ( mmc__mrc__ready_d1 & ~request_fifo_fb[0].almost_full & ~request_fifo_fb[1].almost_full ),  // stop requests if MMC or feedback fifo not ready
           .sdp__xxx__mem_request_channel                ( mrc__mmc__channel_e1              ),
           .sdp__xxx__mem_request_bank                   ( mrc__mmc__bank_e1                 ),
           .sdp__xxx__mem_request_page                   ( mrc__mmc__page_e1                 ),
           .sdp__xxx__mem_request_word                   ( mrc__mmc__word_e1                 ),

           .xxx__sdp__mem_request_channel_data_valid     ( mem_request_channel_data_valid    ),
           .xxx__sdp__mem_request_valid                  ( xxx__sdp__mem_request_valid       ),
           //.sdp__xxx__mem_request_ack                    ( sdp__xxx__mem_request_ack         ),
           .xxx__sdp__mem_request_channel                ( xxx__sdp__mem_request_channel     ),
           .xxx__sdp__mem_request_bank                   ( xxx__sdp__mem_request_bank        ),
           .xxx__sdp__mem_request_page                   ( xxx__sdp__mem_request_page        ),
           .xxx__sdp__mem_request_word                   ( xxx__sdp__mem_request_word        ),


           //-------------------------------
           // from MMC fifo Control
           //
            .sdp__xxx__get_next_line                     ( sdp__xxx__get_next_line           ),
            .sdp__xxx__lane_enable                       ( sdp__xxx__lane_enable             ),
            .sdp__xxx__lane_valid                        ( sdp__xxx__lane_valid              ),
            .sdp__xxx__lane_cntl                         ( sdp__xxx__lane_cntl               ),
            .sdp__xxx__lane_channel_ptr                  ( sdp__xxx__lane_channel_ptr        ),
            .sdp__xxx__lane_word_ptr                     ( sdp__xxx__lane_word_ptr           ),
            .sdp__xxx__current_channel                   ( sdp__xxx__current_channel         ),
            .xxx__sdp__lane_ready                        ( std__mrc__lane_ready_d1           ),
                                                                                                                    
            //-------------------------------
            // General
            //
            .sys__mgr__mgrId                             ( sys__mgr__mgrId                   ),
            .clk                                         ( clk                               ),
            .reset_poweron                               ( reset_poweron                     ) 
            );



  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Request FIFO
  //
  //  - this fifo is the address of the channel from_mmc fifo data
  //  - the sdp_cntl will use this to check if the current consequtive stream address is at the head of the from_mmc fifo

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: request_fifo_fb

        wire                                               clear         ;
        wire                                               almost_full   ;
        wire                                               empty         ;
                                                           
        reg                                                write         ;
        reg   [`MRC_CNTL_REQUEST_AGGREGATE_FIFO_RANGE ]    write_data    ;
                                                           
        reg   [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE       ]    write_channel ;
        reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE          ]    write_bank    ;
        reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE          ]    write_page    ;
        reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE          ]    write_word    ;
                                                           
        wire                                               read          ;
        wire  [`MRC_CNTL_REQUEST_AGGREGATE_FIFO_RANGE ]    read_data     ;



        generic_fifo #(.GENERIC_FIFO_DEPTH      (`MRC_CNTL_REQUEST_FIFO_DEPTH                 ),
                       .GENERIC_FIFO_THRESHOLD  (`MRC_CNTL_REQUEST_FIFO_ALMOST_FULL_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`MRC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH       )
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
            write         =  mrc__mmc__valid_e1 & (mrc__mmc__channel_e1 == chan) ;
            write_channel =  mrc__mmc__channel_e1                                ;
            write_bank    =  mrc__mmc__bank_e1                                   ;
            write_page    =  mrc__mmc__page_e1                                   ;
            write_word    =  mrc__mmc__word_e1                                   ;
          end
        always @(*)
          begin
            write_data  =  {write_channel, write_bank, write_page, write_word};
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
        reg   [`MRC_CNTL_REQUEST_AGGREGATE_FIFO_RANGE ]    pipe_data      ;
                                                           
        reg   [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE       ]    pipe_channel  ;
        reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE          ]    pipe_bank     ;
        reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE          ]    pipe_page     ;
        reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE          ]    pipe_word     ;

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
            {pipe_channel, pipe_bank, pipe_page, pipe_word} = pipe_data ;
          end

        assign    xxx__sdp__mem_request_valid  [chan]  = pipe_valid                       ;         
        assign    xxx__sdp__mem_request_channel[chan]  = pipe_channel                     ;
        assign    xxx__sdp__mem_request_bank   [chan]  = pipe_bank                        ;
        assign    xxx__sdp__mem_request_page   [chan]  = pipe_page                        ;
        assign    xxx__sdp__mem_request_word   [chan]  = pipe_word                        ;
        assign    pipe_read                            = sdp__xxx__get_next_line[chan]    ;

      end
  endgenerate
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Main Memory Controller FIFO's
  //
  // these are the big memories so we can absorb data from back-to-back page opens and provide data during back-to-back page closes
  // see  https://github.ncsu.edu/lbbaker/ece-cortical-MainResearch/tree/master/3DSystem/DOC/DramReadBuffer.pdf

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan=chan+1) 
      begin: from_mmc_fifo

        wire                                                 clear        ;
        wire                                                 almost_full  ;
        wire                                                 empty        ;

        wire                                                 write        ;
        wire  [`MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_RANGE   ]   write_data   ;

        wire                                                 read         ;
        wire  [`MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_RANGE   ]   read_data    ;

        generic_fifo #(.GENERIC_FIFO_DEPTH      (`MRC_CNTL_FROM_MMC_FIFO_DEPTH                 ),
                       .GENERIC_FIFO_THRESHOLD  (`MRC_CNTL_FROM_MMC_FIFO_ALMOST_FULL_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_WIDTH       )
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
        reg   [`MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_RANGE   ]   pipe_data    ;

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
        // used by stream fsm
        assign mem_request_channel_data_valid [chan] = pipe_valid ;

      end
  endgenerate


  genvar word;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin
        assign from_mmc_fifo[chan].write_data [`MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_RANGE ]  = mmc__mrc__cntl_d1 [chan]  ;

        for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
          begin: mmc_fifo_data
            assign from_mmc_fifo[chan].write_data [(word+1)*`MGR_EXEC_LANE_WIDTH-1 : word*`MGR_EXEC_LANE_WIDTH]   = mmc__mrc__data_d1 [chan][word] ;
          end

        assign from_mmc_fifo[chan].write   =   mmc__mrc__valid_d1 [chan]       ;
        assign  mrc__mmc__ready_e1 [chan]  =  ~from_mmc_fifo[chan].almost_full ;

        assign from_mmc_fifo[chan].pipe_read = sdp__xxx__get_next_line[chan] ;  // after a read with no more data, pipe_valid is deasserted
      end
  endgenerate
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Lane selection for downstream data

  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE       ]      lane_valid                                       ;
  reg  [`MGR_NUM_OF_EXEC_LANES_RANGE       ]      lane_enable                                      ;
  reg  [`STACK_DOWN_INTF_STRM_DATA_RANGE   ]      lane_word        [`MGR_NUM_OF_EXEC_LANES_RANGE ] ; // value driven to downstream stack bus
  reg  [`COMMON_STD_INTF_CNTL_RANGE        ]      lane_cntl                                        ;
  // Mux per lane

  always @(*)
    begin
      lane_cntl = sdp__xxx__lane_cntl ;
    end
  genvar lane ;
  generate
    for (lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
      begin: select_data
        always @(*)
         begin
           lane_valid[lane]  =  sdp__xxx__lane_valid[lane] & sdp__xxx__lane_enable[lane] ;

           // Use selecteWord task to direct from_mmc_fifo data to the downstream lane
           selectLineWord (sdp__xxx__lane_channel_ptr [lane] ,   // chan_select
                           sdp__xxx__lane_word_ptr    [lane] ,   // word_select
                           from_mmc_fifo[0].pipe_data        ,   // chan0      
                           from_mmc_fifo[1].pipe_data        ,   // chan1      
                           lane_word[lane]                   );  // out        
         end
      end
  endgenerate

  // Currently the testbench drives downstream data 
  `ifndef TESTING
    generate
      for (lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
        begin: drive_std
          always @(*)
           begin
             mrc__std__lane_valid_e1 [lane]  = lane_valid [lane] ; 
             mrc__std__lane_cntl_e1  [lane]  = lane_cntl         ;
             mrc__std__lane_data_e1  [lane]  = lane_word [lane]  ;
           end
        end
    endgenerate
  `endif

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Tasks
  //
  //
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Lane data select task

  task selectLineWord ( input  logic [`MGR_DRAM_CHANNEL_ADDRESS_RANGE    ] chan_select , 
                        input  logic [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE ] word_select , 
                        input  logic [`MGR_MMC_TO_MRC_INTF_RANGE         ] chan0       ,
                        input  logic [`MGR_MMC_TO_MRC_INTF_RANGE         ] chan1       ,
                        output logic [`STACK_DOWN_INTF_STRM_DATA_RANGE   ] out         ); 
    // FIXME: look at how to synthesize
    begin
      `include "manager_mrc_cntl_word_lane_mux.vh"
    end
  endtask

  //------------------------------------------------------------------------------------------------------------------------------------------------------

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------------------------
  //
  //
  //
endmodule

