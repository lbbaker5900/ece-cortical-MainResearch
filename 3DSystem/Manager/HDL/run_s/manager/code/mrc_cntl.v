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

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // MR Descriptor FIFO
  //

  // Put in a generate in case we decide to extend to multiple upstream lanes

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
                                         //.almost_empty     ( almost_empty                                              ),
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
  // Process Descriptor FSM
  //
      
  // State register 
  reg [`MRC_CNTL_STATE_RANGE ] mrc_cntl_desc_state      ; // state flop
  reg [`MRC_CNTL_STATE_RANGE ] mrc_cntl_desc_state_next ;

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
  reg  [`MGR_WU_OPT_VALUE_RANGE         ]      txfer_type        ;  // FIXME: wastes bits by using option_value for range
  reg  [`MGR_WU_OPT_VALUE_RANGE         ]      target            ;

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
                           ( mrc_cntl_desc_state == `MRC_CNTL_COMPLETE                                                                                         ) ? 'd0                                   :
                                                                                                                                                                   num_lanes                             ;

      // storage descriptor option type will always be in tuple 0  or tuple 1 because its an extended tuple
      storage_desc_ptr <=  ( reset_poweron                                                                                                                       ) ?  'd0                                                                                                                :
                           ( option[0].contains_storage_ptr &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? {from_Wud_Fifo[0].pipe_option_value[0], from_Wud_Fifo[0].pipe_option_type[1],from_Wud_Fifo[0].pipe_option_value[1]} :
                           ( option[1].contains_storage_ptr &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? {from_Wud_Fifo[0].pipe_option_value[1], from_Wud_Fifo[0].pipe_option_type[2],from_Wud_Fifo[0].pipe_option_value[2]} :
                           ( mrc_cntl_desc_state == `MRC_CNTL_COMPLETE                                                                                           ) ? 'd0                                                                                                                 :
                                                                                                                                                                     storage_desc_ptr                                                                                                    ;

      txfer_type       <=  ( reset_poweron                                                                                                                      ) ?  'd0                                  :
                           ( option[0].contains_txfer_type &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[0] :
                           ( option[1].contains_txfer_type &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[1] :
                           ( option[2].contains_txfer_type &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[2] :
                           ( mrc_cntl_desc_state == `MRC_CNTL_COMPLETE                                                                                          ) ? 'd0                                   :
                                                                                                                                                                    txfer_type                            ;

      target           <=  ( reset_poweron                                                                                                                  ) ?  'd0                                  :
                           ( option[0].contains_target &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[0] :
                           ( option[1].contains_target &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[1] :
                           ( option[2].contains_target &&((mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT ) || (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT ))) ? from_Wud_Fifo[0].pipe_option_value[2] :
                           ( mrc_cntl_desc_state == `MRC_CNTL_COMPLETE                                                                                      ) ? 'd0                                   :
                                                                                                                                                                target                                ;

    end

  // the storage pointers are array wide and include manager ID in MSB's, so remove for address to local storage pointer memory
  wire  [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE ]      local_storage_desc_ptr =  storage_desc_ptr [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE] ;  // remove manager ID msb's

  // need to loop thru all consequtive jump fields until we hit EOM
  reg   [`COMMON_STD_INTF_CNTL_RANGE           ]  consJumpMemory_cntl  ;  // cons/jump delineator
  reg   [`MGR_DRAM_ADDRESS_RANGE               ]  storage_desc_address ;  // main memory address in storage descriptor

  //--------------------------------------------------
  // State Transitions
  
  always @(*)
    begin
      case (mrc_cntl_desc_state)
        
        `MRC_CNTL_DESC_WAIT: 
          mrc_cntl_desc_state_next =   ( from_Wud_Fifo[0].pipe_valid && ~from_Wud_Fifo[0].pipe_som ) ? `MRC_CNTL_ERR           :  // right now assume MR desciptors are multi-cycle
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
                                      
        // Pointer to cons/jump memory will be valid, now wait one clk for output of consequtive/jump memory to be valid
        `MRC_CNTL_DESC_MEM_OUT_VALID: 
          mrc_cntl_desc_state_next =  `MRC_CNTL_CONS_JUMP_MEM_OUT_VALID;
                                      
        // Cycle thru all cons/jump fields
        `MRC_CNTL_CONS_JUMP_MEM_OUT_VALID: 
          mrc_cntl_desc_state_next =  (consJumpMemory_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) ? `MRC_CNTL_COMPLETE                :
                                      (consJumpMemory_cntl == `COMMON_STD_INTF_CNTL_EOM    ) ? `MRC_CNTL_COMPLETE                :
                                                                                               `MRC_CNTL_CONS_JUMP_MEM_OUT_VALID ;


        `MRC_CNTL_COMPLETE: 
          mrc_cntl_desc_state_next =  `MRC_CNTL_DESC_WAIT ;
                                      
  
        // May not need all these states, but it will help with debug
        // Latch state on error
        `MRC_CNTL_ERR:
          mrc_cntl_desc_state_next = `MRC_CNTL_ERR ;
  
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
  reg  [ `MGR_DRAM_WORD_ADDRESS_RANGE   ]    storage_desc_word    ;
  always @(posedge clk)
    begin
      storage_desc_mgr     <=  ( reset_poweron )  ? 'd0  :  (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? storage_desc_address[`MGR_DRAM_ADDRESS_MGR_FIELD_RANGE  ]  : storage_desc_mgr     ;
      storage_desc_channel <=  ( reset_poweron )  ? 'd0  :  (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? storage_desc_address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ]  : storage_desc_channel ;
      storage_desc_bank    <=  ( reset_poweron )  ? 'd0  :  (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? storage_desc_address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ]  : storage_desc_bank    ;
      storage_desc_page    <=  ( reset_poweron )  ? 'd0  :  (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? storage_desc_address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ]  : storage_desc_page    ;
      storage_desc_word    <=  ( reset_poweron )  ? 'd0  :  (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? storage_desc_address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ]  : storage_desc_word    ;
    end
          

  assign from_Wud_Fifo[0].pipe_read = (from_Wud_Fifo[0].pipe_valid && (mrc_cntl_desc_state == `MRC_CNTL_DESC_WAIT   ) && ~from_Wud_Fifo[0].pipe_som ) |
                                      (from_Wud_Fifo[0].pipe_valid && (mrc_cntl_desc_state == `MRC_CNTL_DESC_EXTRACT)                               ) ;



  //----------------------------------------------------------------------------------------------------
  // Storage Descriptor Memory Control
  //

  wire read_storage_desc_memory ; 

  assign read_storage_desc_memory = 1'b1 ;



  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Memories
  //----------------------------------------------------------------------------------------------------
  //



  reg   [`MGR_DRAM_ADDRESS_RANGE                        ]  Address         [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  
  reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]  AccessOrder     [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  consJumpPtr     [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  

  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]  consJumpCntl    [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_MEMORY_RANGE ] ;  // cons/jump delineator
  reg   [`MGR_INST_CONS_JUMP_RANGE                      ]  consJump        [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_MEMORY_RANGE ] ;  

  
  // The memory is updated using the testbench, so everytime we see an read, reload the memory
  always @(posedge read_storage_desc_memory) 
    begin

      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorAddress_readmem.dat"        , sys__mgr__mgrId) , Address      );
      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorAccessOrder_readmem.dat"    , sys__mgr__mgrId) , AccessOrder  );
      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorPtr_readmem.dat"            , sys__mgr__mgrId) , consJumpPtr  );
      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorConsJumpCntl_readmem.dat"   , sys__mgr__mgrId) , consJumpCntl );
      $readmemh($sformatf("./inputFiles/manager_%0d_layer1_storageDescriptorConsJumpFields_readmem.dat" , sys__mgr__mgrId) , consJump     );
    end
  
  reg   [`MGR_DRAM_ADDRESS_RANGE                        ]  sdmem_Address       , sdmem_Address_e1       ;  
  reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]  sdmem_AccessOrder   , sdmem_AccessOrder_e1   ;
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  sdmem_consJumpPtr   , sdmem_consJumpPtr_e1   ;  
                                                                                
  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]  sdmem_consJumpCntl  , sdmem_consJumpCntl_e1  ;  // cons/jump delineator
  reg   [`MGR_INST_CONS_JUMP_RANGE                      ]  sdmem_consJump      , sdmem_consJump_e1      ;  


    //----------------------------------------------------------------------------------------------------
    // Storage Descriptor Memory
    
    //--------------------------------------------------
    // Main Storage Descriptor memory
    
    always @(*) 
      begin 
        #0.3    sdmem_Address_e1             =  Address      [local_storage_desc_ptr ] ;
        #0.3    sdmem_AccessOrder_e1         =  AccessOrder  [local_storage_desc_ptr ] ;
        #0.3    sdmem_consJumpPtr_e1         =  consJumpPtr  [local_storage_desc_ptr ] ;
      end

    always @(posedge clk) 
      begin 
        sdmem_Address             <=  sdmem_Address_e1        ;
        sdmem_AccessOrder         <=  sdmem_AccessOrder_e1    ;
        sdmem_consJumpPtr         <=  sdmem_consJumpPtr_e1    ;
      end

  reg [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  tmp_consJumpPtr, tmp_consJumpPtr_d1 ;
  always @(posedge clk)
    begin
      tmp_consJumpPtr_d1 <= (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? tmp_consJumpPtr+1    : //point to the next location in case there are multiple cons/jump fields
                                                                                    tmp_consJumpPtr_d1+1 ;
         
    end
  // address the cons/jump memory as soon as the pointer from the main storage
  // desc memory is valid but then use address from fsm
  always @(*)
    begin
      tmp_consJumpPtr = (mrc_cntl_desc_state == `MRC_CNTL_DESC_MEM_OUT_VALID) ? sdmem_consJumpPtr  :
                                                                                tmp_consJumpPtr_d1 ;
    end

    //--------------------------------------------------
    // Consequitve/Jump Memory
   
    always @(*) 
      begin 
        #0.3    sdmem_consJumpCntl_e1        =  consJumpCntl [tmp_consJumpPtr   ] ;
        #0.3    sdmem_consJump_e1            =  consJump     [tmp_consJumpPtr   ] ;
      end

    always @(posedge clk) 
      begin 
        sdmem_consJumpCntl        <=  sdmem_consJumpCntl_e1   ;
        sdmem_consJump            <=  sdmem_consJump_e1       ;
      end

        
  //----------------------------------------------------------------------------------------------------
  // end memories
  //----------------------------------------------------------------------------------------------------

  assign consJumpMemory_cntl  = sdmem_consJumpCntl  ;  // cons/jump delineator for fsm
  assign storage_desc_address = sdmem_Address       ;  // main memory address in storage descriptor

  //----------------------------------------------------------------------------------------------------
  //
  //
  //

endmodule
