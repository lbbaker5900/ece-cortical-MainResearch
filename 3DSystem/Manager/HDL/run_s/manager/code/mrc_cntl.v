/*********************************************************************************************

    File name   : mrc_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

    Description :Contains the WU instructions

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
            output  reg                                            mrc__std__lane_valid    [`MGR_NUM_OF_EXEC_LANES_RANGE ],
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__std__lane_cntl     [`MGR_NUM_OF_EXEC_LANES_RANGE ],
            input   wire                                           std__mrc__lane_ready    [`MGR_NUM_OF_EXEC_LANES_RANGE ],
            output  reg   [`STACK_DOWN_INTF_STRM_DATA_RANGE ]      mrc__std__lane_data     [`MGR_NUM_OF_EXEC_LANES_RANGE ],

            //-------------------------------
            // Main Memory Controller interface
            // - response must be in order
            //
            output  reg                                            mrc__mmc__valid                                   ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      mrc__mmc__cntl                                    ,
            input   wire                                           mmc__mrc__ready                                   ,
            output  reg   [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mrc__mmc__channel                                 ,
            output  reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mrc__mmc__bank                                    ,
            output  reg   [ `MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mrc__mmc__page                                    ,
            output  reg   [ `MGR_DRAM_WORD_ADDRESS_RANGE    ]      mrc__mmc__word                                    ,
                                                                                                                    
            // MMC provides data from each DRAM channel
            input   wire                                           mmc__mrc__valid   [`MGR_DRAM_NUM_CHANNELS ]                                 ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE      ]      mmc__mrc__cntl    [`MGR_DRAM_NUM_CHANNELS ]                                 ,
            output  reg                                            mrc__mmc__ready   [`MGR_DRAM_NUM_CHANNELS ]                                 ,
            input   wire  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__mrc__data    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] ,

            //-------------------------------
            // General
            //
            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input  wire                           clk             ,
            input  wire                           reset_poweron  
                        );

    /*
     localparam MGR_DRAM_NUM_LINES = `MGR_DRAM_NUM_LINES ;
     `undef MGR_DRAM_REQUEST_LT_PAGE
     if (MGR_DRAM_NUM_LINES != 0)
       begin
        `define MGR_DRAM_REQUEST_LT_PAGE
      end
    */
    //----------------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------------
    // Registers and Wires
 
    //-------------------------------
    // Stack Bus - Downstream arguments
    //
    reg                                         std__mrc__lane_ready_d1  [`MGR_NUM_OF_EXEC_LANES_RANGE ];
    wire  [`COMMON_STD_INTF_CNTL_RANGE      ]   mrc__std__lane_cntl_e1   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
    wire  [`STACK_DOWN_INTF_STRM_DATA_RANGE ]   mrc__std__lane_data_e1   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
    wire                                        mrc__std__lane_valid_e1  [`MGR_NUM_OF_EXEC_LANES_RANGE ];

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
    reg  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]    mmc__mrc__data_d1    [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ] ;

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

  genvar gvi;
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
            fifo_pipe_valid <= ( reset_poweron      ) ? 'b0               :
                               ( read               ) ? 'b1               :
                               ( fifo_pipe_read     ) ? 'b0               :
                                                         fifo_pipe_valid  ;
          end

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
  //----------------------------------------------------------------------------------------------------
  // Process Descriptor FSM
  //----------------------------------------------------------------------------------------------------
  // - Take storage descriptor option tuples from the WU fifo and construct starting address, number of lanes
  //   target and transfer type (vector/scalar).
  // - Send initial memory request based on starting channel/bank/page/word
  //   Extract the consequtive/jump tuples and pipeline memory requests
  //   Pass the consequtive/jump tuples to another fifo which will be processed by the streaming fsmA
  //   Note: We have to send to another fifo because we want to pipeline the memory page accesses
  // - With memory requests, we always request the starting chan/bank/page but we will also grab the next channel also.
  //   So we need to form an address using only the chan, bank and page based on the increment order of page,bank,chan and increment and request this chan/bank/page also
      
  // State register 
  reg [`MRC_CNTL_DESC_STATE_RANGE ] mrc_cntl_desc_state      ; // state flop
  reg [`MRC_CNTL_DESC_STATE_RANGE ] mrc_cntl_desc_state_next ;

  always @(posedge clk)
    begin
      mrc_cntl_desc_state <= ( reset_poweron ) ? `MRC_CNTL_DESC_WAIT             :
                                                  mrc_cntl_desc_state_next  ;
    end
  
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

  always @(posedge clk)
    begin
      num_lanes        <=  ( reset_poweron                                                                                                                     ) ?  'd0                                  :
                           ( option[0].contains_num_lanes &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[0] :
                           ( option[1].contains_num_lanes &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[1] :
                           ( option[2].contains_num_lanes &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[2] :
                           ( mrc_cntl_desc_state == `MRC_CNTL_DESC_COMPLETE                                                                                         ) ? 'd0                                   :
                                                                                                                                                                   num_lanes                             ;

      // storage descriptor option type will always be in tuple 0  or tuple 1 because its an extended tuple
      storage_desc_ptr <=  ( reset_poweron                                                                                                                       ) ?  'd0                                                                                                                :
                           ( option[0].contains_storage_ptr &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? {from_Wud_Fifo[0].pipe_option_value[0], from_Wud_Fifo[0].pipe_option_type[1],from_Wud_Fifo[0].pipe_option_value[1]} :
                           ( option[1].contains_storage_ptr &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? {from_Wud_Fifo[0].pipe_option_value[1], from_Wud_Fifo[0].pipe_option_type[2],from_Wud_Fifo[0].pipe_option_value[2]} :
                           ( mrc_cntl_desc_state == `MRC_CNTL_DESC_COMPLETE                                                                                           ) ? 'd0                                                                                                                 :
                                                                                                                                                                     storage_desc_ptr                                                                                                    ;

      txfer_type       <=  ( reset_poweron                                                                                                                      ) ?  'd0                                  :
                           ( option[0].contains_txfer_type &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[0] :
                           ( option[1].contains_txfer_type &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[1] :
                           ( option[2].contains_txfer_type &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[2] :
                           ( mrc_cntl_desc_state == `MRC_CNTL_DESC_COMPLETE                                                                                          ) ? 'd0                                   :
                                                                                                                                                                    txfer_type                            ;

      target           <=  ( reset_poweron                                                                                                                  ) ?  'd0                                  :
                           ( option[0].contains_target &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[0] :
                           ( option[1].contains_target &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[1] :
                           ( option[2].contains_target &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[2] :
                           ( mrc_cntl_desc_state == `MRC_CNTL_DESC_COMPLETE                                                                                      ) ? 'd0                                   :
                                                                                                                                                                target                                ;

    end

  // the storage pointers are array wide and include manager ID in MSB's, so remove for address to local storage pointer memory
  wire  [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE ]      local_storage_desc_ptr =  storage_desc_ptr [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE] ;  // remove manager ID msb's

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

  reg                                                      generate_mem_request      ;
  reg                                                      requests_complete         ;
  reg                                                      generate_requests         ;
  reg   [`MRC_CNTL_CHAN_BIT_RANGE                       ]  channel_requested         ;  // which channels have been requested with current bank/page
  reg                                                      bank_change               ;  // check current increment vs previous last request
  reg                                                      page_change               ;
  reg                                                      channel_change            ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
    reg    [`MRC_CNTL_LINE_BIT_RANGE                    ]  line_requested            ;  // which lines have been requested with current bank/page
    reg                                                    line_change               ;
  `endif

  // The MRC_CNTL_DESC FSM extracts the decriptor and handles memory requests
  // The MRC_CNTL_STRM FSM increments thru the words in the from_mmc_fifo
  //
  wire completed_streaming ;  // strm fsm has completed the cons/jump memory tuples

  //--------------------------------------------------
  // State Transitions
  
  always @(*)
    begin
      case (mrc_cntl_desc_state)
        
        `MRC_CNTL_DESC_WAIT: 
          mrc_cntl_desc_state_next =   ( from_Wud_Fifo[0].pipe_valid && ~from_Wud_Fifo[0].pipe_som ) ? `MRC_CNTL_DESC_ERR           :  // right now assume MR desciptors are multi-cycle
                                       ( from_Wud_Fifo[0].pipe_valid                               ) ? `MRC_CNTL_DESC_EXTRACT  :  // pull all we need from the descriptor then start memory access
                                                                                                       `MRC_CNTL_DESC_WAIT     ;
  
        // Cycle thru memory descriptor grabing num_lanes, txfer_type, target and storage descriptor pointer
        `MRC_CNTL_DESC_EXTRACT: 
          mrc_cntl_desc_state_next =   ( from_Wud_Fifo[0].pipe_valid &&  from_Wud_Fifo[0].pipe_eom ) ? `MRC_CNTL_DESC_READ    :  // read the descriptor
                                                                                                       `MRC_CNTL_DESC_EXTRACT ;
  
        // The storage descriptor pointer is valid in this state, the memory is registered so it will be valid next state
        // - send the storage descriptor address field to the main system memory (DRAM)
        `MRC_CNTL_DESC_READ: 
          mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_MEM_OUT_VALID ;
                                      
        // Storage Descriptor address is valid so we can send the memory request
        // Pointer to cons/jump memory will be valid, now wait one clk for output of consequtive/jump memory to be valid
        // Always generate requests first time in, so jump to GENERATE_REQ
        `MRC_CNTL_DESC_MEM_OUT_VALID: 
          mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_GENERATE_REQ_CHA;
                                      
        // Memory requests will occur if the consequtive increment moves to another page
        // Make sure we transition right thru this state
        `MRC_CNTL_DESC_GENERATE_REQ_CHA : 
       //   mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_GENERATE_REQ_CHB   ;
          mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_INC_PBC      ;

       // `MRC_CNTL_DESC_GENERATE_REQ_CHB : 
       //   mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_INC_PBC      ;

        // Make sure strm fifo can take cons/jump before reading
        // - mem_end currently points to beginning of next consequtive phase
        `MRC_CNTL_DESC_CHECK_STRM_FIFO : 
          mrc_cntl_desc_state_next =  ( to_strm_fsm_fifo_ready) ? `MRC_CNTL_DESC_CONS_FIELD           :
                                                                  `MRC_CNTL_DESC_CHECK_STRM_FIFO      ;


        // Cycle thru all cons/jump fields
        //
        `MRC_CNTL_DESC_CONS_FIELD: 
          mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_CALC_NUM_REQS ;

        // we now have the start address and end of cons/jump phase address
        // set pbc_inc to start and pbc_end to boundaries of consequtive phase.
        `MRC_CNTL_DESC_CALC_NUM_REQS: 
          mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_INC_PBC ;

        // start points to first consequtive address, end points to last consequtive address
        // pbc_last_end points to last address of previous consequtive phase
        // pbc_inc is the first address of the current consequtive phase
        // CHeck if last_end != inc. If so, generate requests and set last_end = inc
        `MRC_CNTL_DESC_INC_PBC: 
          mrc_cntl_desc_state_next =  ( first_time_thru                              ) ? `MRC_CNTL_DESC_CHECK_STRM_FIFO  :  // we will get here first time thru after the initial request
                                      ( generate_requests                            ) ? `MRC_CNTL_DESC_GENERATE_REQ_CHA :
                                      ( requests_complete  && ~consJumpMemory_eom    ) ? `MRC_CNTL_DESC_JUMP_FIELD       :
                                      ( requests_complete  &&  consJumpMemory_eom    ) ? `MRC_CNTL_DESC_WAIT_STREAM_COMPLETE  :
                                                                                         `MRC_CNTL_DESC_INC_PBC          ;

        `MRC_CNTL_DESC_JUMP_FIELD: 
          mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_CHECK_STRM_FIFO    ;

        // Cycle thru all cons/jump fields
        `MRC_CNTL_DESC_WAIT_STREAM_COMPLETE: 
          mrc_cntl_desc_state_next =  (completed_streaming)  ? `MRC_CNTL_DESC_COMPLETE  :
                                                               `MRC_CNTL_DESC_WAIT_STREAM_COMPLETE    ;
        `MRC_CNTL_DESC_COMPLETE: 
          mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_WAIT ;
                                      
  
        // May not need all these states, but it will help with debug
        // Latch state on error
        `MRC_CNTL_DESC_ERR:
          mrc_cntl_desc_state_next = `MRC_CNTL_DESC_ERR ;
  
        default:
          mrc_cntl_desc_state_next = `MRC_CNTL_DESC_WAIT ;
    
      endcase // case (mrc_cntl_desc_state)
    end // always @ (*)
  
  //----------------------------------------------------------------------------------------------------
  // Assignments
  
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


  assign from_Wud_Fifo[0].pipe_read = (from_Wud_Fifo[0].pipe_valid && (mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT   ) && ~from_Wud_Fifo[0].pipe_som ) |
                                      (from_Wud_Fifo[0].pipe_valid && (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT)                               ) ;

  always @(posedge clk)
    begin
      first_time_thru <= (mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT    ) ? 1'b1            :
                         (mrc_cntl_desc_state == `MRC_CNTL_DESC_INC_PBC ) ? 1'b0            :
                                                                            first_time_thru ;  
    end

  reg create_mem_request ;
  always @(*)
    begin 
      create_mem_request  = ((mrc_cntl_desc_state == `MRC_CNTL_DESC_GENERATE_REQ_CHA  ))  ; //|
//                             (mrc_cntl_desc_state == `MRC_CNTL_DESC_GENERATE_REQ_CHB )) ;
    end

`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  always @(*)
    begin
      case (storage_desc_accessOrder)  // synopsys parallel_case synopsys full_case
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
            
            generate_requests =  (mrc_cntl_desc_state == `MRC_CNTL_DESC_INC_PBC                     ) &
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
            
            generate_requests =  (mrc_cntl_desc_state == `MRC_CNTL_DESC_INC_PBC                     ) &
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
      
      generate_requests =  (mrc_cntl_desc_state == `MRC_CNTL_DESC_INC_PBC                     ) &
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
      consJumpPtr <= ( mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID  ) ? storage_desc_consJumpPtr : // grab cons/jump ptr from descriptor
                     ( inc_consJumpPtr                                      ) ? consJumpPtr+1            :
                                                                                consJumpPtr              ;
         
    end

  // increment the ptr each time we are about to enter that the state that uses the output
  always @(*)
    begin
      inc_consJumpPtr     =  ((mrc_cntl_desc_state == `MRC_CNTL_DESC_INC_PBC          ) &  requests_complete & ~generate_requests & ~consJumpMemory_som & ~consJumpMemory_eom ) |  // transition to JUMP state
                             ((mrc_cntl_desc_state == `MRC_CNTL_DESC_CHECK_STRM_FIFO  ) &  to_strm_fsm_fifo_ready                                       & ~consJumpMemory_eom ) ;  // transition to CONS state
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
      if ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) && (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID ))
        begin
          mem_end_address      <=  {storage_desc_page, storage_desc_bank, storage_desc_channel, storage_desc_word, 2'b00} ;  // byte address
        end
      else if ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) && (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID ))
        begin
          mem_end_address      <=  {storage_desc_page, storage_desc_bank, storage_desc_word, storage_desc_channel, 2'b00} ;  // byte address
        end
      // increment using number of consequtive onyy if strm fsm can take the cons/jump
      else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_CONS_FIELD ) 
        begin
          // FIXME: Need to accomodate a consequtive value traversing multiple bank/pages
          // Jump value is from previous end location so add consequtive and jump to start address to get next start address
          mem_end_address      <=  mem_end_address + {consJumpMemory_value, 2'b00} ;  // account for byte address 
        end
      // increment using jump 
      else if ((mrc_cntl_desc_state == `MRC_CNTL_DESC_JUMP_FIELD ) && ~consJumpMemory_eom)
        begin
          // Jump value is from previous inc location
          mem_end_address   <=  mem_end_address + {consJumpMemory_value, 2'b00} ;  // account for byte address
        end
    end

  always @(posedge clk)
    begin
      if (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID )
        begin
          mem_start_address <=  {storage_desc_channel, storage_desc_bank, storage_desc_page, storage_desc_word, 2'b00} ;
        end
      // when we enter the CHECK_STRM state the mem_end address points to beginning of next consequtive phase
      else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_CHECK_STRM_FIFO )
        begin
          mem_start_address <=  {mem_end_channel, mem_end_bank, mem_end_page, mem_end_word, 2'b00} ;
        end
    end

  always @(posedge clk)
    begin
      if (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID )
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
      else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_CALC_NUM_REQS )
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
      else if ((mrc_cntl_desc_state == `MRC_CNTL_DESC_INC_PBC ) && ~generate_requests)
        begin
          pbc_inc_addr    <=  pbc_inc_addr + 'd1 ;
        end

      // the request may occur with inc == end, so dont increment past end
      else if ((mrc_cntl_desc_state == `MRC_CNTL_DESC_GENERATE_REQ_CHA ) && ~requests_complete)
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
            if (mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT )
              begin
                channel_requested[chan]    <=  1'b0    ;
              end
            if (mrc_cntl_desc_state == `MRC_CNTL_DESC_CALC_NUM_REQS )
              begin
                channel_requested[chan]    <= (mem_start_bank != mem_last_end_bank) ? 1'b0                    :
                                              (mem_start_page != mem_last_end_page) ? 1'b0                    :
                                                                                      channel_requested[chan] ;
              end
            else if ((mrc_cntl_desc_state == `MRC_CNTL_DESC_INC_PBC ) && generate_requests)
              begin
                channel_requested[chan]    <= (bank_change                                                               ) ? 1'b0                    :
                                              (page_change                                                               ) ? 1'b0                    :
                                              `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                                                ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) && line_change ) ? 1'b0                    :
                                              `endif
                                                                                                                             channel_requested[chan] ;
              end
            else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_GENERATE_REQ_CHA )
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
      begin: line_requeste
        always @(posedge clk)
          begin
            if (mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT )
              begin
                line_requested[line]    <=  1'b0    ;
              end
            if (mrc_cntl_desc_state == `MRC_CNTL_DESC_CALC_NUM_REQS )
              begin
                line_requested[line]    <= (mem_start_bank    != mem_last_end_bank   ) ? 1'b0                 :
                                           (mem_start_page    != mem_last_end_page   ) ? 1'b0                 :
                                           (mem_start_channel != mem_last_end_channel) ? 1'b0                 :
                                                                                         line_requested[line] ;
              end
            else if ((mrc_cntl_desc_state == `MRC_CNTL_DESC_INC_PBC ) && generate_requests)
              begin
                line_requested[line]    <= (bank_change                                                                ) ? 1'b0                 :
                                           (page_change                                                                ) ? 1'b0                 :
                                           ((storage_desc_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) && channel_change ) ? 1'b0                 :
                                                                                                                           line_requested[line] ;
              end
            else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_GENERATE_REQ_CHA )
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
      if (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID )
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
      else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_CALC_NUM_REQS )
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
      if (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID )
        begin
          mem_last_end_address <=  {storage_desc_channel, storage_desc_bank, storage_desc_page, storage_desc_word, 2'b00} ;
        end
      else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_JUMP_FIELD )
        begin
          // mem_addr is current set to end of CONS phase, so set last req to end of previous consequtive phase
          mem_last_end_address <=  {mem_end_channel, mem_end_bank, mem_end_page, mem_end_word, 2'b00} ;
        end
    end

  always @(posedge clk)
    begin
      if (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID )
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
      else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_JUMP_FIELD )
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
      //else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_GENERATE_REQ_CHB )
      else if (mrc_cntl_desc_state == `MRC_CNTL_DESC_GENERATE_REQ_CHA )
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
      mrc__mmc__valid_e1   =  create_mem_request                            ;
      mrc__mmc__cntl_e1    = `COMMON_STD_INTF_CNTL_SOM_EOM                  ;  // memory request is single cycle
      case (storage_desc_accessOrder)  // synopsys parallel_case synopsys full_case
        PY_WU_INST_ORDER_TYPE_WCBP :
          begin
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
              mrc__mmc__channel_e1 =  pbc_inc_addr[`MGR_DRAM_PBCL_CHAN_FIELD_RANGE ] ;
              mrc__mmc__bank_e1    =  pbc_inc_addr[`MGR_DRAM_PBCL_BANK_FIELD_RANGE ] ;
              mrc__mmc__page_e1    =  pbc_inc_addr[`MGR_DRAM_PBCL_PAGE_FIELD_RANGE ] ;
              mrc__mmc__word_e1    = {pbc_inc_addr[`MGR_DRAM_PBCL_LINE_FIELD_RANGE ], {`MGR_DRAM_WORD_ADDRESS_WIDTH-`MGR_DRAM_LINE_ADDRESS_WIDTH {1'b0}}} ;
            `else
              mrc__mmc__channel_e1 =  pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
              mrc__mmc__bank_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ;
              mrc__mmc__page_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              mrc__mmc__word_e1    =  'd0                                           ;
            `endif
          end
        PY_WU_INST_ORDER_TYPE_CWBP :
          begin
            `ifdef  MGR_DRAM_REQUEST_LT_PAGE
              mrc__mmc__channel_e1 =  pbc_inc_addr[`MGR_DRAM_PBLC_CHAN_FIELD_RANGE ] ;
              mrc__mmc__bank_e1    =  pbc_inc_addr[`MGR_DRAM_PBLC_BANK_FIELD_RANGE ] ;
              mrc__mmc__page_e1    =  pbc_inc_addr[`MGR_DRAM_PBLC_PAGE_FIELD_RANGE ] ;
              mrc__mmc__word_e1    = {pbc_inc_addr[`MGR_DRAM_PBLC_LINE_FIELD_RANGE ], {`MGR_DRAM_WORD_ADDRESS_WIDTH-`MGR_DRAM_LINE_ADDRESS_WIDTH {1'b0}}} ;
            `else
              mrc__mmc__channel_e1 =  pbc_inc_addr[`MGR_DRAM_PBC_CHAN_FIELD_RANGE ] ;
              mrc__mmc__bank_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_BANK_FIELD_RANGE ] ;
              mrc__mmc__page_e1    =  pbc_inc_addr[`MGR_DRAM_PBC_PAGE_FIELD_RANGE ] ;
              mrc__mmc__word_e1    =  'd0                                           ;
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
  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: consJump_to_strm_fsm_fifo

        wire  clear        ;
        wire  almost_full  ;
        wire                                              write        ;
        wire  [`MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_RANGE ]   write_data   ;
        wire                                              pipe_valid   ;
        wire                                              pipe_read    ;
        wire  [`MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_RANGE ]   pipe_data    ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MRC_CNTL_CJ_TO_STRM_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_WIDTH       )
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
     to_strm_fsm_fifo_write  = (mrc_cntl_desc_state == `MRC_CNTL_DESC_CONS_FIELD) | (mrc_cntl_desc_state == `MRC_CNTL_DESC_JUMP_FIELD) ;
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
        wire  [`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_RANGE ]   write_data   ;
        wire                                                   pipe_valid   ;
        wire                                                   pipe_read    ;
        wire  [`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_RANGE ]   pipe_data    ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MRC_CNTL_ADDR_TO_STRM_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_WIDTH       )
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
  assign  addr_to_strm_fsm_fifo[0].write       = (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ;
  assign  addr_to_strm_fsm_fifo[0].write_data  = {num_lanes, txfer_type, target, storage_desc_accessOrder, storage_desc_local_address} ;


  // Flow control DESC fsm if either fifo becomes almost full
  assign  to_strm_fsm_fifo_ready    = ~consJump_to_strm_fsm_fifo[0].almost_full & ~addr_to_strm_fsm_fifo[0].almost_full ;



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
  
  //--------------------------------------------------
  // i) Storage Descriptor Address Memory
  
  //reg   [`MGR_DRAM_ADDRESS_RANGE                        ]  sdmem_Address       , sdmem_Address_e1       ;  
  wire   [`MGR_DRAM_ADDRESS_RANGE                        ]  sdmem_Address       ;
  //reg   [`MGR_DRAM_ADDRESS_RANGE                        ]  Address_mem         [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  
  generic_memory #(.GENERIC_MEM_DEPTH          (`MGR_LOCAL_STORAGE_DESC_MEMORY_DEPTH  ),
                   .GENERIC_MEM_REGISTERED_OUT (0                                     ),
                   .GENERIC_MEM_DATA_WIDTH     (`MGR_DRAM_ADDRESS_WIDTH               )
                  ) Address_mem ( 
                  //---------------------------------------------------------------
                  // Port A 
                  .portA_address       ( {$clog2(`MGR_LOCAL_STORAGE_DESC_MEMORY_DEPTH ) {1'b0}} ),
                  .portA_write_data    ( {`MGR_DRAM_ADDRESS_WIDTH {1'b0}} ),
                  .portA_read_data     (             ),
                  .portA_enable        ( 1'b0        ), 
                  .portA_write         ( 1'b0        ),
                  
                  //---------------------------------------------------------------
                  // Port B 
                  .portB_address       ( local_storage_desc_ptr ),
                  .portB_write_data    ( {`MGR_DRAM_ADDRESS_WIDTH {1'b0}} ),
                  .portB_read_data     ( sdmem_Address       ),
                  .portB_enable        ( 1'b1                             ), 
                  .portB_write         ( 1'b0                             ),
                  
                  //---------------------------------------------------------------
                  // General
                  .reset_poweron       ( reset_poweron             ),
                  .clk                 ( clk                       )
                  ) ;
/*
  always @(*) 
    begin 
      #0.3    sdmem_AccessOrder_e1         =  AccessOrder_mem  [local_storage_desc_ptr ] ;
    end
  always @(posedge clk) 
    begin 
      sdmem_Address             <=  sdmem_Address_e1        ;
    end
*/
  initial
    begin
      @(negedge reset_poweron);
      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorAddress_readmem.dat"        , sys__mgr__mgrId) , Address_mem.mem      );
      //$readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorAddress_readmem.dat"        , sys__mgr__mgrId) , Address_mem      );
    end


  //--------------------------------------------------
  // ii) Access Order Memory
  
  reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]  sdmem_AccessOrder   , sdmem_AccessOrder_e1   ;
  reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]  AccessOrder_mem     [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  
  always @(*) 
    begin 
      #0.3    sdmem_AccessOrder_e1         =  AccessOrder_mem  [local_storage_desc_ptr ] ;
    end
  always @(posedge clk) 
    begin 
      sdmem_AccessOrder         <=  sdmem_AccessOrder_e1    ;
    end

  initial
    begin
      @(negedge reset_poweron);
      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorAccessOrder_readmem.dat"    , sys__mgr__mgrId) , AccessOrder_mem  );
    end



  //--------------------------------------------------
  // iii) ConsJump Pointer Memory
  
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  sdmem_consJumpPtr   , sdmem_consJumpPtr_e1   ;  
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  consJumpPtr_mem     [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  
  always @(*) 
    begin 
      #0.3    sdmem_consJumpPtr_e1         =  consJumpPtr_mem  [local_storage_desc_ptr ] ;
    end
  always @(posedge clk) 
    begin 
      sdmem_consJumpPtr         <=  sdmem_consJumpPtr_e1    ;
    end
  initial
    begin
      @(negedge reset_poweron);
      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorPtr_readmem.dat"            , sys__mgr__mgrId) , consJumpPtr_mem  );
    end




  //--------------------------------------------------
  // iv) ConsJump Cntl Memory

  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]  sdmem_consJumpCntl  , sdmem_consJumpCntl_e1  ;  // cons/jump delineator
  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]  consJumpCntl_mem    [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_MEMORY_RANGE ] ;  // cons/jump delineator
  always @(*) 
    begin 
      #0.3    sdmem_consJumpCntl_e1        =  consJumpCntl_mem [consJumpPtr   ] ;
    end
  always @(posedge clk) 
    begin 
      sdmem_consJumpCntl        <=  sdmem_consJumpCntl_e1   ;
    end
  initial
    begin
      @(negedge reset_poweron);
      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorConsJumpCntl_readmem.dat"   , sys__mgr__mgrId) , consJumpCntl_mem );
    end


  //--------------------------------------------------
  // v) ConsJump Value Memory

  reg   [`MGR_INST_CONS_JUMP_RANGE                      ]  sdmem_consJump      , sdmem_consJump_e1      ;  
  reg   [`MGR_INST_CONS_JUMP_RANGE                      ]  consJump_mem        [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_MEMORY_RANGE ] ;  
  always @(*) 
    begin 
      #0.3    sdmem_consJump_e1            =  consJump_mem     [consJumpPtr   ] ;
    end
  always @(posedge clk) 
    begin 
      sdmem_consJump            <=  sdmem_consJump_e1       ;
    end
  initial
    begin
      @(negedge reset_poweron);
      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorConsJumpFields_readmem.dat" , sys__mgr__mgrId) , consJump_mem     );
    end
  


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
  // - Take the conseqtive/jump tuples from the intermediate fifo and start streaming data
  // - If page line changes occur, assume the next line is in the from_mmc_fifo because its been pipelined
  //   by the descriptor processing fsm
  // - The stream fsm will keep a register for channel 0 and channel 1 and  draw from these two registers as required when incrementing
      
  // State register 
  reg [`MRC_CNTL_STRM_STATE_RANGE ] mrc_cntl_stream_state      ; // state flop
  reg [`MRC_CNTL_STRM_STATE_RANGE ] mrc_cntl_stream_state_next ;

  always @(posedge clk)
    begin
      mrc_cntl_stream_state <= ( reset_poweron ) ? `MRC_CNTL_STRM_WAIT          :
                                                    mrc_cntl_stream_state_next  ;
    end
  
  //----------------------------------------------------------------------------------------------------
  // FSM Registers
  //

  reg  [`MRC_CNTL_CONS_COUNTER_RANGE ]      consequtive_counter ;
  reg  [`MGR_INST_CONS_JUMP_RANGE    ]      jump_value_for_strm ;
  
  //--------------------------------------------------
  // State Transitions
  
  always @(*)
    begin
      case (mrc_cntl_stream_state)
        
        `MRC_CNTL_STRM_WAIT: 
          mrc_cntl_stream_state_next =  ( consJump_to_strm_fsm_fifo[0].pipe_valid && consJump_to_strm_fsm_fifo[0].pipe_valid) ? `MRC_CNTL_STRM_LOAD_FIRST_CONS_COUNT :  // load consequtive words counter
                                                                                                                                `MRC_CNTL_STRM_WAIT        ;
  
        // wait for consequtive counter to time out
        //  - transition straight thru this state
        `MRC_CNTL_STRM_LOAD_FIRST_CONS_COUNT: 
          mrc_cntl_stream_state_next =  (consJump_to_strm_fsm_fifo[0].pipe_eom ) ? `MRC_CNTL_STRM_COUNT_CONS      :
                                                                                   `MRC_CNTL_STRM_LOAD_JUMP_VALUE ;

        // wait for consequtive counter to time out
        `MRC_CNTL_STRM_LOAD_JUMP_VALUE: 
          mrc_cntl_stream_state_next =  ( consJump_to_strm_fsm_fifo[0].pipe_valid) ? `MRC_CNTL_STRM_COUNT_CONS :  // load consequtive words counter
                                                                                     `MRC_CNTL_STRM_LOAD_JUMP_VALUE ;

        // wait for consequtive counter to time out
        `MRC_CNTL_STRM_COUNT_CONS: 
          mrc_cntl_stream_state_next =  ((consequtive_counter == 'd0                              ) && consJump_to_strm_fsm_fifo[0].pipe_eom) ? `MRC_CNTL_STRM_COMPLETE        :
                                        ((consequtive_counter[`MRC_CNTL_CONS_COUNTER_MSB]  == 1'b1) && consJump_to_strm_fsm_fifo[0].pipe_eom) ? `MRC_CNTL_STRM_COMPLETE        :  // check for negative
                                        ((consequtive_counter == 'd0                              )                                         ) ? `MRC_CNTL_STRM_LOAD_JUMP_VALUE :
                                        ((consequtive_counter[`MRC_CNTL_CONS_COUNTER_MSB]  == 1'b1)                                         ) ? `MRC_CNTL_STRM_LOAD_JUMP_VALUE :  // check for negative
                                                                                                                                                `MRC_CNTL_STRM_COUNT_CONS      ;

 //       `MRC_CNTL_STRM_JUMP_VALUE_WAIT: 
 //         mrc_cntl_stream_state_next =                                                          `MRC_CNTL_STRM_LOAD_JUMP_VALUE ;

        `MRC_CNTL_STRM_COMPLETE: 
          mrc_cntl_stream_state_next =  `MRC_CNTL_STRM_WAIT ;
                                      
  
        // May not need all these states, but it will help with debug
        // Latch state on error
        `MRC_CNTL_STRM_ERR:
          mrc_cntl_stream_state_next = `MRC_CNTL_STRM_ERR ;
  
        default:
          mrc_cntl_stream_state_next = `MRC_CNTL_STRM_WAIT ;
    
      endcase // case (mrc_cntl_stream_state)
    end // always @ (*)
  
  //----------------------------------------------------------------------------------------------------

  assign  addr_to_strm_fsm_fifo[0].pipe_read           =  (mrc_cntl_stream_state == `MRC_CNTL_STRM_LOAD_FIRST_CONS_COUNT);

  assign  consJump_to_strm_fsm_fifo[0].pipe_read       = ((mrc_cntl_stream_state == `MRC_CNTL_STRM_LOAD_FIRST_CONS_COUNT)                                           ) |
                                                         ((mrc_cntl_stream_state == `MRC_CNTL_STRM_LOAD_JUMP_VALUE      ) &  consJump_to_strm_fsm_fifo[0].pipe_valid) |
                                                         ((mrc_cntl_stream_state == `MRC_CNTL_STRM_COUNT_CONS           ) & (consequtive_counter == 'd0)           ) ;


  assign completed_streaming = (mrc_cntl_stream_state == `MRC_CNTL_STRM_COMPLETE) ;

  always @(posedge clk)
    begin
      consequtive_counter <=  ( reset_poweron )  ? 'd0  :  
                              (                                (mrc_cntl_stream_state == `MRC_CNTL_STRM_LOAD_FIRST_CONS_COUNT)) ? consJump_to_strm_fsm_fifo[0].pipe_consJumpValue             :  
                              ((consequtive_counter == 'd0) && (mrc_cntl_stream_state == `MRC_CNTL_STRM_COUNT_CONS           )) ? consJump_to_strm_fsm_fifo[0].pipe_consJumpValue             :  
                              ( addr_to_strm_fsm_fifo[0].pipe_transfer_type == PY_WU_INST_TXFER_TYPE_BCAST                    ) ? consequtive_counter-1                                       :
                              ( addr_to_strm_fsm_fifo[0].pipe_transfer_type == PY_WU_INST_TXFER_TYPE_VECTOR                   ) ? consequtive_counter-addr_to_strm_fsm_fifo[0].pipe_num_lanes :
                                                                                                                                  consequtive_counter                                         ;  // will only occur with error
    end
  always @(posedge clk)
    begin
      jump_value_for_strm          <=  ( reset_poweron )  ? 'd0  :  
                              ((mrc_cntl_stream_state == `MRC_CNTL_STRM_LOAD_JUMP_VALUE)) ? consJump_to_strm_fsm_fifo[0].pipe_consJumpValue  : 
                                                                                            jump_value_for_strm            ;
    end

  reg  [`MGR_INST_OPTION_ORDER_RANGE    ]    strm_accessOrder       ;

  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE   ]    strm_request_address   ;  // main memory address for additional requests
  reg  [`MGR_DRAM_LOCAL_ADDRESS_RANGE   ]    strm_inc_address       ;  // address we increment for each jump
 
  reg  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE]    strm_request_channel   ;
  reg  [ `MGR_DRAM_BANK_ADDRESS_RANGE   ]    strm_request_bank      ;
  reg  [ `MGR_DRAM_PAGE_ADDRESS_RANGE   ]    strm_request_page      ;
  reg  [ `MGR_DRAM_WORD_ADDRESS_RANGE   ]    strm_request_word      ;

  reg  [ `MGR_DRAM_CHANNEL_ADDRESS_RANGE]    strm_inc_channel       ;  // formed address in access order for incrementing
  reg  [ `MGR_DRAM_BANK_ADDRESS_RANGE   ]    strm_inc_bank          ;
  reg  [ `MGR_DRAM_PAGE_ADDRESS_RANGE   ]    strm_inc_page          ;
  reg  [ `MGR_DRAM_WORD_ADDRESS_RANGE   ]    strm_inc_word          ;

  always @(*)
    begin
      if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
        begin
          strm_inc_channel =  strm_inc_address[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
          strm_inc_bank    =  strm_inc_address[`MGR_DRAM_WCBP_ORDER_BANK_FIELD_RANGE ]  ;
          strm_inc_page    =  strm_inc_address[`MGR_DRAM_WCBP_ORDER_PAGE_FIELD_RANGE ]  ;
          strm_inc_word    =  strm_inc_address[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
        end
      else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
        begin
          strm_inc_channel =  strm_inc_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
          strm_inc_bank    =  strm_inc_address[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
          strm_inc_page    =  strm_inc_address[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
          strm_inc_word    =  strm_inc_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
        end
    end

  // extract chan/bank/page/word fields from previous request address
  always @(*)
    begin
      strm_request_channel =  strm_request_address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  ;
      strm_request_bank    =  strm_request_address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  ;
      strm_request_page    =  strm_request_address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  ;
      strm_request_word    =  strm_request_address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  ;
    end

  // access order stays static during increment phase
  always @(*)
    begin
      strm_accessOrder      =  addr_to_strm_fsm_fifo[0].pipe_order ;
    end
  // we will set the request address to the start of each cons/jump group
  always @(posedge clk)
    begin
      strm_request_address  =  (addr_to_strm_fsm_fifo[0].pipe_read) ?  addr_to_strm_fsm_fifo[0].pipe_addr  : strm_request_address   ;
    end

  // Load the increment address in the order of increment
  always @(posedge clk)
    begin
      if ((addr_to_strm_fsm_fifo[0].pipe_read == PY_WU_INST_ORDER_TYPE_WCBP) && (addr_to_strm_fsm_fifo[0].pipe_read))
        begin
          strm_inc_address[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ] =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  ;
          strm_inc_address[`MGR_DRAM_WCBP_ORDER_BANK_FIELD_RANGE ] =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  ;
          strm_inc_address[`MGR_DRAM_WCBP_ORDER_PAGE_FIELD_RANGE ] =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  ;
          strm_inc_address[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ] =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  ;
        end
      if ((addr_to_strm_fsm_fifo[0].pipe_read == PY_WU_INST_ORDER_TYPE_CWBP) && (addr_to_strm_fsm_fifo[0].pipe_read))
        begin
          strm_inc_address[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ] =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  ;
          strm_inc_address[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ] =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  ;
          strm_inc_address[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ] =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  ;
          strm_inc_address[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ] =  addr_to_strm_fsm_fifo[0].pipe_addr[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  ;
        end
    end

  //-------------------------------------------------------------------------------------------
  //------------------------------------------
  // Main Memory Controller FIFO's
  //
  // these are the big memroies so we can absorb data from back-to-back page opens and provide data during back-to-back page closes
  // see  https://github.ncsu.edu/lbbaker/ece-cortical-MainResearch/tree/master/3DSystem/DOC/DramReadBuffer.pdf

  generate
    for (gvi=0; gvi<`MGR_DRAM_NUM_CHANNELS ; gvi=gvi+1) 
      begin: from_mmc_fifo

        wire  clear        ;
        wire  almost_full  ;
        wire                                                 write        ;
        wire  [`MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_RANGE   ]   write_data   ;
        wire                                                 pipe_valid   ;
        wire                                                 pipe_read    ;
        wire  [`MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_RANGE   ]   pipe_data    ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MRC_CNTL_FROM_MMC_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MRC_CNTL_FROM_MMC_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_WIDTH       )
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

        // FIXME
        assign pipe_read = pipe_valid ;
    
      end
  endgenerate


  genvar word;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin
        assign from_mmc_fifo[chan].clear    = 1'b0  ;
        assign from_mmc_fifo[chan].write_data [`MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_RANGE ]  = mmc__mrc__cntl_d1 [chan]  ;
        assign from_mmc_fifo[chan].write_data [`MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_RANGE ]  = mmc__mrc__cntl_d1 [chan]  ;
        for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS ; word++)
          begin: mmc_fifo_data
            assign from_mmc_fifo[chan].write_data [(word+1)*`MGR_EXEC_LANE_WIDTH-1 : word*`MGR_EXEC_LANE_WIDTH]   = mmc__mrc__data_d1 [chan][word] ;
          end
        assign from_mmc_fifo[chan].write   =   mmc__mrc__valid_d1 [chan]       ;
        assign  mrc__mmc__ready_e1 [chan]  =  ~from_mmc_fifo[chan].almost_full ;
      end
  endgenerate



  // Pointer to word in a page
  //  - initially set to storage pointer word address offset by lane ID
  //  - increment by number of active lanes
  reg  [ `STACK_DOWN_INTF_STRM_DATA_RANGE   ]      lane_word        [`MGR_NUM_OF_EXEC_LANES_RANGE ] ; // value driven to downstream stack bus
  reg  [ `MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE ]      lane_word_ptr    [`MGR_NUM_OF_EXEC_LANES_RANGE ] ; 
  reg  [ `MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE ]      lane_word_inc    [`MGR_NUM_OF_EXEC_LANES_RANGE ] ; // value to increment the pointer by
  reg  [ `MGR_NUM_OF_EXEC_LANES_RANGE       ]      lane_word_enable                                 ;  // vector of lane enables based on number of active lanes
  //genvar lane ;
  //generate
  always @(posedge clk)
    begin
      for (int lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
        begin: word_ptrs
          lane_word_enable[lane]  <= (mrc_cntl_stream_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? (num_lanes >  lane)        :
                                                                                             lane_word_enable[lane]     ;
          lane_word_ptr   [lane]  <= (mrc_cntl_stream_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? storage_desc_word + lane   :
                                                                                             lane_word_ptr[lane]        ;
          lane_word_inc   [lane]  <= (mrc_cntl_stream_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? num_lanes                  :
                                                                                             lane_word_inc[lane]        ;
        end
    end
  //endgenerate

  genvar lane ;
  generate
    for (lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
      begin: select_data
        always @(*)
         begin
           selectPageWord (lane_word_ptr[lane], from_mmc_fifo[0].pipe_data, lane_word[lane]);
         end
      end
  endgenerate



  //----------------------------------------------------------------------------------------------------
  //
  //
  //
  task selectPageWord ( input  logic [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE ] select, input logic [`MGR_MMC_TO_MRC_INTF_RANGE ] in,
                        output logic [`STACK_DOWN_INTF_STRM_DATA_RANGE ] out); 
    // FIXME: look at how to synthesize
    begin
      `include "manager_mrc_cntl_word_lane_mux.vh"
    end
  endtask


  //----------------------------------------------------------------------------------------------------
  //
  //
  //
endmodule

