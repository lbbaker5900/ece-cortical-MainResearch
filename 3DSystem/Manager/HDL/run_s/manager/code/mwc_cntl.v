/*********************************************************************************************

    File name   : mwc_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

    Description : Receives memory descriptors and data from the NoC and writes data to main memory
                  Introduce a custom access to the DRAM known as "masked" cache write
                  The burst of two will be broken into a mask and a data phase or a phase with mask and data
                  e.g. we would like byte-wise masks
                  The cache line may be 256 bytes, so we break the cache line into two chunks and provide a mask/data phase 

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "mgr_noc_cntl.vh"
`include "mwc_cntl.vh"
`include "python_typedef.vh"


module mwc_cntl (  

            //-------------------------------------------------------------------------------------------------
            // from Main Controller
            //  - likely from NoC via mcntl 
            input  wire                                              mcntl__mwc__valid      , 
            input  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__mwc__cntl       , 
            output reg                                               mwc__mcntl__ready      , 
            input  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__mwc__type       ,   
            input  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__mwc__ptype      , 
            input  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__mwc__data       , 
            input  wire                                              mcntl__mwc__pvalid     , 
            input  wire [`MGR_MGR_ID_RANGE                     ]     mcntl__mwc__mgrId      ,   // dont need this

            //-------------------------------------------------------------------------------------------------
            // Return Data Processor Interface
            //
            // - Data and memory write descriptors
            input   wire                                             rdp__mwc__valid      , 
            input   wire [`COMMON_STD_INTF_CNTL_RANGE          ]     rdp__mwc__cntl       , 
            output  reg                                              mwc__rdp__ready      , 
            input   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]     rdp__mwc__type       ,   
            input   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]     rdp__mwc__ptype      , 
            input   wire                                             rdp__mwc__pvalid     , 
            input   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]     rdp__mwc__data       , 
  
            //-------------------------------------------------------------------------------------------------
            // Main Memory Controller interface
            //
            // Requests are sent out ahead of data
            output  reg                                                                           mwc__mmc__valid         ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE          ]                                 mwc__mmc__cntl          ,
            output  reg   [`MGR_STD_OOB_TAG_RANGE               ]                                 mwc__mmc__tag           ,  // tie to zero as write interface isnt conditioned on operation tag
            input   wire                                                                          mmc__mwc__ready         ,
                                                                                                                          
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 mwc__mmc__channel       ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE         ]                                 mwc__mmc__bank          ,
            output  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE         ]                                 mwc__mmc__page          ,
            output  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE         ]                                 mwc__mmc__word          ,

            // Data associated with request (note: dont forget it needs to be in the same order as the request)
            output  reg                                                                           mwc__mmc__data_valid    ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE           ]                                mwc__mmc__data_cntl     ,
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 mwc__mmc__data_channel  ,
            output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  mwc__mmc__data          ,
            output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ]                                 mwc__mmc__data_mask     ,
            input   wire                                                                          mmc__mwc__data_ready    ,
                                                                                                                    

            //----------------------------------------------------------------------------------------------------
            //----------------------------------------------------------------------------------------------------
            // Config/Status
            
            //-------------------------------------------------------------------------------------------------
            // Storage descriptor download

            input   wire                                                       mcntl__mwc__enable_sdmem_dnld   ,

            input   wire                                                       mcntl__mwc__sdmem_valid         ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__mwc__sdmem_cntl          ,
            output  reg                                                        mwc__mcntl__sdmem_ready         ,

            input   wire  [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE          ]    mcntl__mwc__sdmem_address       ,

            // Storage descriptor memory contents
            input   wire  [`MGR_DRAM_ADDRESS_RANGE                        ]    mcntl__mwc__sdmem_addr          ,
            input   wire  [`MGR_INST_OPTION_ORDER_RANGE                   ]    mcntl__mwc__sdmem_order         ,
            input   wire  [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__mwc__sdmem_consJump_ptr  ,
            

            input   wire                                                       mcntl__mwc__enable_cjmem_dnld   ,

            input   wire                                                       mcntl__mwc__cjmem_valid         ,
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__mwc__cjmem_cntl          ,
            output  reg                                                        mwc__mcntl__cjmem_ready         ,

            input   wire  [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__mwc__cjmem_address       ,

            // Cons/jump memory contents
            input   wire  [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__mwc__cjmem_consJump_cntl ,
            input   wire  [`MGR_INST_CONS_JUMP_FIELD_RANGE                ]    mcntl__mwc__cjmem_consJump_val  ,

            
            //-------------------------------------------------------------------------------------------------
            // General
            //
            input  wire                           mcntl__mwc__flush ,  // release any held write data. Likely used at end of a sequence

            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId   ,

            input  wire                           clk               ,
            input  wire                           reset_poweron  
                        );

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registers and Wires
 
  //-------------------------------------------------------------------------------------------------
  // Storage descriptor download
 
  reg                                                        mcntl__mwc__enable_sdmem_dnld_d1   ;

  reg                                                        mcntl__mwc__sdmem_valid_d1         ;
  reg                                                        mcntl__mwc__sdmem_cntl_d1          ;
  reg                                                        mwc__mcntl__sdmem_ready_e1         ;

  reg   [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE          ]    mcntl__mwc__sdmem_address_d1       ;
  // Storage descriptor memory contents
  reg   [`MGR_DRAM_ADDRESS_RANGE                        ]    mcntl__mwc__sdmem_addr_d1          ;
  reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]    mcntl__mwc__sdmem_order_d1         ;
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__mwc__sdmem_consJump_ptr_d1  ;
            

  reg                                                        mcntl__mwc__enable_cjmem_dnld_d1   ;

  reg                                                        mcntl__mwc__cjmem_valid_d1         ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]    mcntl__mwc__cjmem_cntl_d1          ;
  reg                                                        mwc__mcntl__cjmem_ready_e1         ;

  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__mwc__cjmem_address_d1       ;
  // Storage descriptor memory contents
  reg   [`MGR_DRAM_ADDRESS_RANGE                        ]    mcntl__mwc__cjmem_addr_d1          ;
  reg   [`MGR_INST_OPTION_ORDER_RANGE                   ]    mcntl__mwc__cjmem_order_d1         ;
  reg   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]    mcntl__mwc__cjmem_consJump_val_d1  ;
            

  //-------------------------------------------------------------------------------------------------
  // from MCNTL (NoC)
  reg                                               mcntl__mwc__valid_d1      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__mwc__cntl_d1       ; 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__mwc__type_d1       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__mwc__ptype_d1      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__mwc__data_d1       ; 
  reg                                               mcntl__mwc__pvalid_d1     ; 
  //reg  [`MGR_MGR_ID_RANGE                   ]     mcntl__mwc__mgrId_d1      ; 
  reg                                               mwc__mcntl__ready_e1      ; 


  //-------------------------------------------------------------------------------------------------
  // from RDP (local)
  reg                                               rdp__mwc__valid_d1      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     rdp__mwc__cntl_d1       ; 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     rdp__mwc__type_d1       ;
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     rdp__mwc__ptype_d1      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     rdp__mwc__data_d1       ; 
  reg                                               rdp__mwc__pvalid_d1     ; 
  reg                                               mwc__rdp__ready_e1      ; 


  //--------------------------------------------------
  // to Main Memory Controller
  
  reg                                           mwc__mmc__valid_e1      ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE     ]      mwc__mmc__cntl_e1       ;
  reg   [`MGR_STD_OOB_TAG_RANGE          ]      mwc__mmc__tag_e1        ;
  reg                                           mmc__mwc__ready_d1      ;
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mwc__mmc__channel_e1    ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]      mwc__mmc__bank_e1       ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mwc__mmc__page_e1       ;
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE    ]      mwc__mmc__word_e1       ;

  reg                                                                           mwc__mmc__data_valid_e1    ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE           ]                                mwc__mmc__data_cntl_e1     ;
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 mwc__mmc__data_channel_e1  ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  mwc__mmc__data_e1          ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ]                                 mwc__mmc__data_mask_e1     ;
  reg                                                                           mmc__mwc__data_ready_d1    ;

  wire   mmc_ready ;  // aggegate mmc readys
  assign mmc_ready = mmc__mwc__ready_d1 & mmc__mwc__data_ready_d1 ;

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Register inputs and outputs

  //-------------------------------------------------------------------------------------------------
  // Storage descriptor download
  //
    always @(posedge clk) 
      begin
        mcntl__mwc__enable_sdmem_dnld_d1   <=  (reset_poweron) ? 1'b0 : mcntl__mwc__enable_sdmem_dnld     ;
        mcntl__mwc__sdmem_valid_d1         <=  (reset_poweron) ? 1'b0 : mcntl__mwc__sdmem_valid           ;
        mcntl__mwc__sdmem_cntl_d1          <=                           mcntl__mwc__sdmem_cntl            ;
                                                                                                       
        mwc__mcntl__sdmem_ready            <=                           mwc__mcntl__sdmem_ready_e1        ;
                                                                                                       
        mcntl__mwc__sdmem_address_d1       <=                           mcntl__mwc__sdmem_address         ;
        mcntl__mwc__sdmem_addr_d1          <=                           mcntl__mwc__sdmem_addr            ;
        mcntl__mwc__sdmem_order_d1         <=                           mcntl__mwc__sdmem_order           ;
        mcntl__mwc__sdmem_consJump_ptr_d1  <=                           mcntl__mwc__sdmem_consJump_ptr    ;
      end

  //--------------------------------------------------
  // from MCNTL
  
  always @(posedge clk) 
    begin
      mcntl__mwc__valid_d1    <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__valid      ;
      mcntl__mwc__cntl_d1     <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__cntl       ;
      mcntl__mwc__type_d1     <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__type       ;
      mcntl__mwc__ptype_d1    <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__ptype      ;
      mcntl__mwc__data_d1     <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__data       ;
      mcntl__mwc__pvalid_d1   <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__pvalid     ;
      //mcntl__mwc__mgrId_d1  <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__mgrId      ;
      mwc__mcntl__ready       <=   ( reset_poweron   ) ? 'd0  : mwc__mcntl__ready_e1   ;
    end

  //--------------------------------------------------
  // from RDP
  
  always @(posedge clk) 
    begin
      rdp__mwc__valid_d1    <=   ( reset_poweron   ) ? 'd0  : rdp__mwc__valid      ;
      rdp__mwc__cntl_d1     <=   ( reset_poweron   ) ? 'd0  : rdp__mwc__cntl       ;
      rdp__mwc__type_d1     <=   ( reset_poweron   ) ? 'd0  : rdp__mwc__type       ;
      rdp__mwc__ptype_d1    <=   ( reset_poweron   ) ? 'd0  : rdp__mwc__ptype      ;
      rdp__mwc__data_d1     <=   ( reset_poweron   ) ? 'd0  : rdp__mwc__data       ;
      rdp__mwc__pvalid_d1   <=   ( reset_poweron   ) ? 'd0  : rdp__mwc__pvalid     ;
      mwc__rdp__ready       <=   ( reset_poweron   ) ? 'd0  : mwc__rdp__ready_e1   ;
    end


  //--------------------------------------------------
  // to Main Memory Controller
  
  always @(posedge clk) 
    begin
      mwc__mmc__valid           <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__valid_e1        ;
      mwc__mmc__cntl            <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__cntl_e1         ;
      mwc__mmc__tag             <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__tag_e1          ;
      mmc__mwc__ready_d1        <=   ( reset_poweron   ) ? 'd0  :  mmc__mwc__ready           ;
      mwc__mmc__channel         <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__channel_e1      ;
      mwc__mmc__bank            <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__bank_e1         ;
      mwc__mmc__page            <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__page_e1         ;
      mwc__mmc__word            <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__word_e1         ;

      mwc__mmc__data_valid      <=   ( reset_poweron   ) ? 'd0  : mwc__mmc__data_valid_e1    ;
      mwc__mmc__data_cntl       <=   ( reset_poweron   ) ? 'd0  : mwc__mmc__data_cntl_e1     ;
      mwc__mmc__data_channel    <=   ( reset_poweron   ) ? 'd0  : mwc__mmc__data_channel_e1  ;
      mwc__mmc__data            <=   ( reset_poweron   ) ? 'd0  : mwc__mmc__data_e1          ;
      mwc__mmc__data_mask       <=   ( reset_poweron   ) ? 'd0  : mwc__mmc__data_mask_e1     ;
      mmc__mwc__data_ready_d1   <=   ( reset_poweron   ) ? 'd0  : mmc__mwc__data_ready       ;

    end

  //------------------------------------------------------------------------------------------------------------------------
  // State register 
  reg [`MWC_CNTL_INPUT_ARB_STATE_RANGE ] mwc_cntl_input_arb_state      ; // state flop
  reg [`MWC_CNTL_INPUT_ARB_STATE_RANGE ] mwc_cntl_input_arb_state_next ;

  always @(posedge clk)
    begin
      mwc_cntl_input_arb_state <= ( reset_poweron ) ? `MWC_CNTL_INPUT_ARB_WAIT       :
                                                      mwc_cntl_input_arb_state_next  ;
    end
  
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Input Select FSM
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // - Give priority to NoC

  //------------------------------------------------------------------------------------------------------------------------
  // FSM wires/registers
  //
  reg                            enable_rdp_fsm                   ;  
  reg                            rdp_fsm_complete                 ;  
  reg                            enable_mcntl_fsm                 ;  
  reg                            mcntl_fsm_complete               ;  

  //------------------------------------------------------------------------------------------------------------------------
  // State Transitions
  //
  always @(*)
    begin
      case (mwc_cntl_input_arb_state)  // synopsys parallel_case full_case
        
        `MWC_CNTL_INPUT_ARB_WAIT: 
          mwc_cntl_input_arb_state_next =   ( input_intf_fifo[0].pipe_valid  ) ? `MWC_CNTL_INPUT_ARB_RDP    :  
                                            ( input_intf_fifo[1].pipe_valid  ) ? `MWC_CNTL_INPUT_ARB_MCNTL  :  
                                                                                 `MWC_CNTL_INPUT_ARB_WAIT   ;

        `MWC_CNTL_INPUT_ARB_RDP: 
          mwc_cntl_input_arb_state_next =   (intf_fsm[0].complete ) ? `MWC_CNTL_INPUT_ARB_COMPLETE :  
                                                                      `MWC_CNTL_INPUT_ARB_RDP      ;
  
        `MWC_CNTL_INPUT_ARB_MCNTL: 
          mwc_cntl_input_arb_state_next =   (intf_fsm[1].complete ) ? `MWC_CNTL_INPUT_ARB_COMPLETE :  
                                                                      `MWC_CNTL_INPUT_ARB_MCNTL    ;
  
  
        // wait for the input fsm to deassert complete
        `MWC_CNTL_INPUT_ARB_COMPLETE : 
          mwc_cntl_input_arb_state_next =   (intf_fsm[0].complete || intf_fsm[1].complete)  ? `MWC_CNTL_INPUT_ARB_COMPLETE :  
                                                                                              `MWC_CNTL_INPUT_ARB_WAIT     ;
  
        default:
          mwc_cntl_input_arb_state_next =   `MWC_CNTL_INPUT_ARB_WAIT   ;


      endcase // case (mrc_cntl_input_arb_state)
    end // always @ (*)
      
  //------------------------------------------------------------------------------------------------------------------------
  // State Decodes
  //
  //----------------------------------------------------------------------------------------------------
  // Combinatorial Decodes
  //
    
  always @(*)
    begin

      case (mwc_cntl_input_arb_state)  // synopsys parallel_case
        
        `MWC_CNTL_INPUT_ARB_RDP: 
          begin
            enable_rdp_fsm                  = 1'b1 ;
            enable_mcntl_fsm                = 1'b0 ;
          end
        
        `MWC_CNTL_INPUT_ARB_MCNTL: 
          begin
            enable_rdp_fsm                  = 1'b0 ;
            enable_mcntl_fsm                = 1'b1 ;
          end
        
        default:
          begin
            enable_rdp_fsm                  = 1'b0 ;
            enable_mcntl_fsm                = 1'b0 ;
          end
    
      endcase // case (mrc_cntl_input_arb_state)
    end // always @ (*)
    
  //----------------------------------------------------------------------------------------------------
  // Registered Decodes
  //
  //
  // end of State Decodes
  //------------------------------------------------------------------------------------------------------------------------
      

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Input interface FIFOs
  // - from RDP and MCntl
  // 
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  genvar intf ;
  generate
    for (intf=0; intf<`MWC_CNTL_NUM_OF_INPUT_INTF ; intf=intf+1) 
      begin: input_intf_fifo


        wire  clear        ;
        wire  almost_full  ;

        // Write 
        wire                                                  write        ;
        reg  [`MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_RANGE ]     write_data   ;

        // Write 
        wire                                                  pipe_valid   ;
        reg                                                   pipe_read    ;
        reg  [`MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_RANGE ]     pipe_data    ;

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`MWC_CNTL_FROM_MCNTL_FIFO_DEPTH                 ),
                                 .GENERIC_FIFO_THRESHOLD  (`MWC_CNTL_FROM_MCNTL_FIFO_ALMOST_FULL_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_WIDTH       )
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
     
        //----------------------------------------------------------------------------------------------------
        // Write data fields assigned to interface outside generate

        //----------------------------------------------------------------------------------------------------
        // Extract read data
        wire [`COMMON_STD_INTF_CNTL_RANGE           ]     pipe_cntl        ; 
        wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     pipe_type        ; 
        wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     pipe_ptype       ; 
        wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     pipe_mem_data    ; 
        wire                                              pipe_pvalid      ; 

        assign {pipe_cntl, pipe_type, pipe_ptype, pipe_pvalid, pipe_mem_data} = pipe_data ;
        //----------------------------------------------------------------------------------------------------

        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM); 
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM);

      end
  endgenerate

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Connect inputs from rdp and mcntl to intf_fifos 

  //----------------------------------------------------------------------------------------------------
  // Write data fields
  assign input_intf_fifo[0].write       =  rdp__mwc__valid_d1 ;

  assign input_intf_fifo[0].write_data  = {rdp__mwc__cntl_d1, rdp__mwc__type_d1, rdp__mwc__ptype_d1, rdp__mwc__pvalid_d1, rdp__mwc__data_d1};

  always @(*)
    begin
      mwc__rdp__ready_e1    = ~input_intf_fifo[0].almost_full ;
    end

  assign input_intf_fifo[1].write       =  mcntl__mwc__valid_d1 ;
  assign input_intf_fifo[1].write_data  = {mcntl__mwc__cntl_d1, mcntl__mwc__type_d1, mcntl__mwc__ptype_d1, mcntl__mwc__pvalid_d1, mcntl__mwc__data_d1};
  always @(*)
    begin
      mwc__mcntl__ready_e1  = ~input_intf_fifo[1].almost_full ;
    end

  // end of input fifos
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  //------------------------------------------------------------------------------------------------------------------------
  // Address for incrementing to index into holding register
  // - we will load it with the starting address from the SDP_REQ module, then increment thru the number of active lanes and for each lane write the value
  //   and the amsk fields of the holding register

  reg                                                                           inc_address_data_valid  ; // pipe data available
  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE        ]                                 inc_address             ; 
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 inc_channel             ; 
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE         ]                                 inc_bank                ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE         ]                                 inc_page                ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                                                           
    reg [`MGR_DRAM_LINE_ADDRESS_RANGE         ]                                 inc_line                ; 
  `endif                                                                                                     
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE         ]                                 inc_word                ;

  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE        ]                                 inc_address_e1          ;  
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 inc_channel_e1          ; 
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE         ]                                 inc_bank_e1             ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE         ]                                 inc_page_e1             ;
  `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE                                                                           
    reg [`MGR_DRAM_LINE_ADDRESS_RANGE         ]                                 inc_line_e1             ; 
  `endif                                                                                                     
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE         ]                                 inc_word_e1             ;

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Extract Descriptor FSM
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // - Take storage descriptor option tuples from the fifo and construct starting address and word locations
  // - Give priority to NoC
  //

  reg   [`MGR_STORAGE_DESC_ADDRESS_RANGE        ]      storage_desc_ptr                 ;  // pointer to local storage descriptor although msb's contain manager ID, so remove
  reg                                                  storage_desc_address_valid       ;
  reg                                                  storage_desc_address_latched     ;  // let inc_address_e1 hold it once we see a valid address

  reg   [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_RANGE ]  held_addr_hit           [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ]  ;  // word address in holding register
  reg                                                  held_available          [`MGR_DRAM_NUM_CHANNELS ]            ;
  reg                                                  held_accept             [`MGR_DRAM_NUM_CHANNELS ]            ;  // empty location or hit
  reg   [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_RANGE ]  held_entry_clear        [`MGR_DRAM_NUM_CHANNELS ]            ;  // clear entry during single register flush


  generate
    for (intf=0; intf<`MWC_CNTL_NUM_OF_INPUT_INTF ; intf=intf+1) 
      begin : intf_fsm


        //------------------------------------------------------------------------------------------------------------------------
        // State register 
        reg [`MWC_CNTL_PTR_DATA_RCV_STATE_RANGE ] mwc_cntl_extract_desc_state      ; // state flop
        reg [`MWC_CNTL_PTR_DATA_RCV_STATE_RANGE ] mwc_cntl_extract_desc_state_next ;
      
        always @(posedge clk)
          begin
            mwc_cntl_extract_desc_state <= ( reset_poweron ) ? `MWC_CNTL_PTR_DATA_RCV_WAIT        :
                                                                mwc_cntl_extract_desc_state_next  ;
          end
        
        //------------------------------------------------------------------------------------------------------------------------
        // FSM wires/registers
        //
        wire                                                  enable                          ;  // the fsm is told to start
        reg                                                   complete                        ;  // other fsm wont be allowed to start until this one is complete

        wire                                                  pipe_valid                      ;
        reg                                                   pipe_read                       ;
        wire [`MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_RANGE ]     pipe_data                       ;
        wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE       ]     pipe_type                      ; 
        wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE      ]     pipe_ptype                      ; 
        wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE         ]     pipe_mem_data                   ; 
        wire                                                  pipe_pvalid                     ; 
        wire                                                  pipe_som                        ;
        wire                                                  pipe_eom                        ;

        reg   [`MGR_NOC_INTERNAL_INTF_NUM_WORDS_RANGE   ]     contains_storage_ptr            ;  // Each transaction may have a storage descriptor per word
        reg                                                   contains_data                   ;
        reg   [`MGR_STORAGE_DESC_ADDRESS_RANGE          ]     storage_desc_ptr                ;  // pointer to local storage descriptor although msb's contain manager ID, so remove
        reg   [`MGR_STORAGE_DESC_ADDRESS_RANGE          ]     storage_desc_ptr_wire           ;  
        reg                                                   storage_desc_address_valid      ;  // only should see one storage descriptor for this SSC
        reg   [`MGR_MGR_ID_RANGE                        ]     storage_desc_ptr_mgr_id         ;  // extract manager ID from descriptor

        reg                                                   performing_dma                  ;  // latch dma so we can process multiple packets
        reg                                                   is_cfg_dma_start                ;  
        reg                                                   is_cfg_dma                      ;  
        reg                                                   is_cfg_dma_end                  ;  
        reg                                                   is_desc_wr_type                 ;  
        reg                                                   is_desc_wr_data                 ;  

        reg                                                   holding_reg_clear               ;  

        reg   [`MWC_CNTL_CACHE_ENTRY_LINES_RANGE        ]     holding_reg_line_count          ;  // cycle thru cache entries (actually cycle thru each line)
        reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE          ]     holding_reg_chan_ptr            ; 
        reg   [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_RANGE   ]     holding_reg_chan_cline_ptr      ;
        reg   [`MGR_DRAM_LINE_ADDRESS_RANGE             ]     holding_reg_chan_cline_line_ptr ;                             
        //------------------------------------------------------------------------------------------------------------------------
        // State Transitions
        //
        always @(*)
          begin
            case (mwc_cntl_extract_desc_state)  // synopsys parallel_case)
              
              `MWC_CNTL_PTR_DATA_RCV_WAIT: 
                mwc_cntl_extract_desc_state_next =   ( enable       ) ? `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF:  
                                                                        `MWC_CNTL_PTR_DATA_RCV_WAIT        ;
      
              //------------------------------------------------------------------------------------------------------------------------------------------------------
              // RDP
              //
              // Keep reading until we see descriptor cycle
              // We wont read if there is data or a desc ptr
              `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF: 
                mwc_cntl_extract_desc_state_next =   ( pipe_som                                      ) ? `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF :  // remove header
                                                     (|contains_storage_ptr                          ) ? `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_INTF :  // transition if either word is a storage ptr
                                                     ( contains_data && is_cfg_dma                   ) ? `MWC_CNTL_PTR_DATA_RCV_DMA                      :  
                                                     ( contains_data                                 ) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_DATA             :  
                                                                                                         `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF ;
        
        
              `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_INTF : 
                mwc_cntl_extract_desc_state_next =   ( contains_storage_ptr[0] && (storage_desc_ptr_mgr_id == sys__mgr__mgrId)) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_INTF :  // read the descriptor
                                                                                                                                  `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_INTF   ;
      
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_INTF : 
                mwc_cntl_extract_desc_state_next =    `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE ;    // got start address, so read fifo
      
      
              `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_INTF : 
                mwc_cntl_extract_desc_state_next =   ( contains_storage_ptr[1] && (storage_desc_ptr_mgr_id == sys__mgr__mgrId )) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_INTF         :  // read the descriptor
                                                                                                                                   `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE                 ;
      
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_INTF : 
                mwc_cntl_extract_desc_state_next =   `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE ;  // got start address, so read fifo
      
              // read fifo as we have grabed pointer
              `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE : 
                mwc_cntl_extract_desc_state_next =    `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF;
      
      
              // Latch the fact that we are starting a Host download and stop processing once we get DMA_END
              `MWC_CNTL_PTR_DATA_RCV_DMA : 
                mwc_cntl_extract_desc_state_next =    `MWC_CNTL_PTR_DATA_RCV_PROCESS_DATA;
      
      
      
              //----------------------------------------------------------------------------------------------------
              // Keep data processing in the same FSM for now, but its turning into a lot of states
              
      
              // An extra cycle for loading regs
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_DATA : 
                mwc_cntl_extract_desc_state_next =   `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER ;
                                                                                                             
      
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER : 
                mwc_cntl_extract_desc_state_next =   ( pipe_valid && ~held_accept[inc_channel]                                                                            ) ? `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER :  // no where to put data
                                                     ( pipe_valid &&  pipe_eom && (pipe_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_ONE) && performing_dma ) ? `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE                   :  // only one word valid in last cycle
                                                     ( pipe_valid &&  pipe_eom && (pipe_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_ONE)                   ) ? `MWC_CNTL_PTR_DATA_RCV_FLUSH_ALL_HOLDING_REGS            :  // only one word valid in last cycle
                                                     ( pipe_valid                                                                                                         ) ? `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER  :  
                                                                                                                                                                              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER  ;
      
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER : 
              // we dont get here unless the pipe is valid, so dont bother checking
                mwc_cntl_extract_desc_state_next =   ( pipe_valid && ~held_accept[inc_channel]                     ) ? `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER :  // no where to put data
                                                     ( pipe_valid && pipe_eom && performing_dma                    ) ? `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE                   :  // both words valid in last cycle
                                                     ( pipe_valid && pipe_eom                                      ) ? `MWC_CNTL_PTR_DATA_RCV_FLUSH_ALL_HOLDING_REGS            :  // both words valid in last cycle
                                                     ( pipe_valid                                                  ) ? `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER  :
                                                                                                                       `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER  ;
      
      
              //----------------------------------------------------------------------------------------------------
              // Flush last accessed to make space
              //
              `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER : 
                mwc_cntl_extract_desc_state_next =   (~mmc_ready                                                                  )  ?  `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER :  // stall immediately as MMC has small fifo
                                                     ((holding_reg_line_count == `MWC_CNTL_CACHE_ENTRY_LINES-1)                   )  ?  `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER  :
                                                                                                                                        `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER ;
              
              `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER : 
                mwc_cntl_extract_desc_state_next =   (~mmc_ready                                                                  )  ?  `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER :  // stall immediately as MMC has small fifo
                                                     ((holding_reg_line_count == `MWC_CNTL_CACHE_ENTRY_LINES-1)                   )  ?  `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER  :
                                                                                                                                        `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER ;
              
              //----------------------------------------------------------------------------------------------------
              // Flush all valid data in holding register(s)
              //
              `MWC_CNTL_PTR_DATA_RCV_FLUSH_ALL_HOLDING_REGS : 
                mwc_cntl_extract_desc_state_next =   (~mmc_ready                                                                  )  ?  `MWC_CNTL_PTR_DATA_RCV_FLUSH_ALL_HOLDING_REGS :  // stall immediately as MMC has small fifo
                                                     ((holding_reg_line_count == `MWC_CNTL_CACHE_ENTRY_LINES-1) && performing_dma )  ?  `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE    :  // holding_reg_line_count is a counter going thru the holding regs flushing each
                                                     ((holding_reg_line_count == `MWC_CNTL_CACHE_ENTRY_LINES-1)                   )  ?  `MWC_CNTL_PTR_DATA_RCV_COMPLETE           :
                                                                                                                                        `MWC_CNTL_PTR_DATA_RCV_FLUSH_ALL_HOLDING_REGS ;
              
              
              //----------------------------------------------------------------------------------------------------
              // Complete
              //
              // wait for enable to be deasserted
              `MWC_CNTL_PTR_DATA_RCV_COMPLETE : 
                mwc_cntl_extract_desc_state_next =   ( enable ) ? `MWC_CNTL_PTR_DATA_RCV_COMPLETE:  
                                                                  `MWC_CNTL_PTR_DATA_RCV_WAIT        ;
      
              `MWC_CNTL_PTR_DATA_RCV_ERR : 
                mwc_cntl_extract_desc_state_next =   `MWC_CNTL_PTR_DATA_RCV_ERR        ;
      
      
              default:
                mwc_cntl_extract_desc_state_next =   `MWC_CNTL_PTR_DATA_RCV_WAIT        ;
      
      
            endcase // case (mrc_cntl_extract_desc_state)
          end // always @ (*)
      
        //------------------------------------------------------------------------------------------------------------------------
        // State Decodes
        //
        //----------------------------------------------------------------------------------------------------
        // Combinatorial Decodes
        //
        always @(*)
          begin
            case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
              `MWC_CNTL_PTR_DATA_RCV_WAIT: 
                begin
                  holding_reg_clear = 1'b1 ;
                end
              default:
                begin
                  holding_reg_clear = 1'b0 ;
                end
            endcase
          end

        always @(posedge clk)
          begin
            case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
              `MWC_CNTL_PTR_DATA_RCV_WAIT :
                begin
                  storage_desc_address_valid <= 1'b0 ;
                end
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_INTF : 
                begin
                  storage_desc_address_valid <= 1'b1 ;
                end
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_INTF : 
                begin
                  storage_desc_address_valid <= 1'b1 ;
                end
              default:
                begin
                  storage_desc_address_valid <= storage_desc_address_valid ;
                end
            endcase
          end

        always @(*)
          begin

            for (int w=0; w<`MGR_NOC_INTERNAL_INTF_NUM_WORDS ; w++)
              begin
                contains_storage_ptr [w]    = 'd0  ;
              end

            contains_data                   = 'd0  ;
            storage_desc_ptr_wire           = 'd0  ;
            storage_desc_ptr_mgr_id         = 'd0  ;
            pipe_read                       = 'd0  ;
            complete                        = 'd0  ;  

            case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
              
              // Remove header
              `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF: 
                begin
                  contains_storage_ptr [0] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_storage_ptr [1] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_data            = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_DATA ));
                                                                                                          
                  complete    = 1'b0 ;
                  pipe_read   = ~|contains_storage_ptr & ~contains_data ;

                end
      
              `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_INTF : 
                begin
                  contains_storage_ptr [0] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_storage_ptr [1] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_data            = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_DATA ));
                                                                                                          
                  storage_desc_ptr_wire     = pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] ;
                  storage_desc_ptr_mgr_id   =  storage_desc_ptr_wire [`MGR_STORAGE_DESC_MGR_ID_FIELD_RANGE  ] ;  // extract manager ID msb's

                end
              
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_INTF : 
                begin
                  contains_storage_ptr [0] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_storage_ptr [1] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_data            = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_DATA ));
                                                                                                          
                                                                                                          
                end
              
              `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_INTF : 
                begin
                  contains_storage_ptr [0] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_storage_ptr [1] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_data            = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_DATA ));
                                                                                                          
                  storage_desc_ptr_wire     = pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ] ;
                  storage_desc_ptr_mgr_id   =  storage_desc_ptr_wire [`MGR_STORAGE_DESC_MGR_ID_FIELD_RANGE  ] ;  // extract manager ID msb's

                end
              
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_INTF : 
                begin
                  contains_storage_ptr [0] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_storage_ptr [1] = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) ;
                  contains_data            = pipe_valid & ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_DATA ));
                                                                                                          
                end
              
              `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE : 
                begin
                  pipe_read   = 1'b1 ;
                end
      
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER : 
                begin
                  pipe_read   = ( pipe_valid && pipe_eom && (pipe_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_ONE)) ;  // read last data if last transaction and only one word is valid
                end
              
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER : 
                begin
                  pipe_read   = pipe_valid ;  // we have processed both words
                end
              

              `MWC_CNTL_PTR_DATA_RCV_COMPLETE : 
                begin
                  complete    = 1'b1 ;
                end
              
              default:
                begin
                  contains_storage_ptr            = 'd0  ;
                  contains_data                   = 'd0  ;
                  storage_desc_ptr_mgr_id         = 'd0  ;
                  pipe_read                       = 'd0  ;
                  complete                        = 'd0  ;  
                end
      
      
            endcase // case (mrc_cntl_extract_desc_state)
          end // always @ (*)
      
        //----------------------------------------------------------------------------------------------------
        // Registered Decodes
        //
        always @(posedge clk)
          begin
            case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
              `MWC_CNTL_PTR_DATA_RCV_FLUSH_ALL_HOLDING_REGS : 
                begin
                  holding_reg_line_count     <= (mmc_ready ) ? holding_reg_line_count + 'd1 :
                                                               holding_reg_line_count       ;
                end
              `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER : 
                begin
                  holding_reg_line_count     <= (mmc_ready ) ? holding_reg_line_count + 'd1 :
                                                               holding_reg_line_count       ;
                end
              `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER : 
                begin
                  holding_reg_line_count     <= (mmc_ready ) ? holding_reg_line_count + 'd1 :
                                                               holding_reg_line_count       ;
                end
              
              default:
                begin
                  holding_reg_line_count     <= 'd0 ;
                end
            endcase // case (mrc_cntl_extract_desc_state)
          end // always @ (posedge clk
        always @(*)
          begin
            holding_reg_chan_cline_ptr          =  holding_reg_line_count[`MWC_CNTL_CACHE_LINE_PTR_RANGE ];
            holding_reg_chan_ptr                =  holding_reg_line_count[`MWC_CNTL_CHAN_CLINE_PTR_RANGE ];
            holding_reg_chan_cline_line_ptr     =  holding_reg_line_count[`MWC_CNTL_CLINE_LINE_PTR_RANGE ];
          end

        always @(posedge clk)
          begin
            case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
              
      
              `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_INTF : 
                begin
                  storage_desc_ptr     <= pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] ;
                end
              
              `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_INTF : 
                begin
                  storage_desc_ptr     <= pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ] ;
                end
              
              default:
                begin
                  storage_desc_ptr     <= storage_desc_ptr ;
                end
      
      
            endcase // case (mrc_cntl_extract_desc_state)
          end // always @ (posedge clk
      
        always @(posedge clk)
          begin
            case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
              `MWC_CNTL_PTR_DATA_RCV_WAIT : 
                begin
                  performing_dma     <= 'd0 ;
                end
              `MWC_CNTL_PTR_DATA_RCV_DMA : 
                begin
                  performing_dma     <= (is_cfg_dma_start             ) ? 'd1              :
                                        (is_cfg_dma_end               ) ? 'd0              :
                                                                           performing_dma  ;
                end
            endcase // case (mrc_cntl_extract_desc_state)
          end // always @ (posedge clk

        always @(*)
          begin
            isCfgDma     (is_cfg_dma      , pipe_type);  
            isCfgDmaStart(is_cfg_dma_start, pipe_type);  
            isCfgDmaEnd  (is_cfg_dma_end  , pipe_type);  
            isWrDescType (is_desc_wr_type , pipe_type);                 
            isNocData    (is_desc_wr_data , pipe_type);                 
          end
        //
        // end of State Decodes
        //------------------------------------------------------------------------------------------------------------------------
      
    end
  endgenerate

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Connect inputs from rdp and mcntl fifos to interface fsm

  generate
    for (intf=0; intf<`MWC_CNTL_NUM_OF_INPUT_INTF ; intf=intf+1) 
      begin
        assign  intf_fsm[intf].pipe_valid    =  input_intf_fifo[intf].pipe_valid    ;
        assign  intf_fsm[intf].pipe_som      =  input_intf_fifo[intf].pipe_som      ;
        assign  intf_fsm[intf].pipe_eom      =  input_intf_fifo[intf].pipe_eom      ;
        assign  intf_fsm[intf].pipe_type     =  input_intf_fifo[intf].pipe_type     ;
        assign  intf_fsm[intf].pipe_ptype    =  input_intf_fifo[intf].pipe_ptype    ;
        assign  intf_fsm[intf].pipe_data     =  input_intf_fifo[intf].pipe_data     ;
        assign  intf_fsm[intf].pipe_mem_data =  input_intf_fifo[intf].pipe_mem_data ;
        assign  intf_fsm[intf].pipe_pvalid   =  input_intf_fifo[intf].pipe_pvalid   ;
  
        assign  input_intf_fifo[intf].pipe_read    = intf_fsm[intf].pipe_read       ;
      end
  endgenerate

  assign  intf_fsm[0].enable    =  enable_rdp_fsm        ;
  assign  intf_fsm[1].enable    =  enable_mcntl_fsm      ;
  assign  rdp_fsm_complete      =  intf_fsm[0].complete  ;
  assign  mcntl_fsm_complete    =  intf_fsm[1].complete  ;

  //end of input fsm
  //------------------------------------------------------------------------------------------------------------------------------------------------------


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Storage Descriptor Memory Request Generator
  // - Contains the storage descriptor and consequtive/jump memory
  // - generates memory requests
  // - the mwc cntl holds the requests and fills the data associated with the request


  always @(*)
    begin
      case ({enable_rdp_fsm, enable_mcntl_fsm}) // synopsys parallel_case
        2'b10:
          begin
            storage_desc_ptr            =  intf_fsm[0].storage_desc_ptr           ;
            //storage_desc_address_valid  =  intf_fsm[0].storage_desc_address_valid ;
          end
        2'b01:
          begin
            storage_desc_ptr            =  intf_fsm[1].storage_desc_ptr ;
            //storage_desc_address_valid  =  intf_fsm[1].storage_desc_address_valid ;
          end
        default
          begin
            storage_desc_ptr  =  'd0 ;
          end
      endcase
    end

  
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
  
  // the storage pointers are array wide and include manager ID in MSB's, so remove for address to local storage pointer memory
  wire  [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE ]      local_storage_desc_ptr =  storage_desc_ptr [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE] ;  // remove manager ID msb's

  wire   [`MGR_DRAM_ADDRESS_RANGE                        ]  sdmem_Address               ;
  wire   [`MGR_INST_OPTION_ORDER_RANGE                   ]  sdmem_AccessOrder           ; // FIXME : change instruction gen
  reg    [`MGR_INST_OPTION_ORDER_RANGE                   ]  sdmem_AccessOrder_latched   ; // FIXME : change instruction gen
  wire   [`MGR_LOCAL_STORAGE_DESC_CONSJUMP_ADDRESS_RANGE ]  sdmem_consJumpPtr           ;

  genvar gvi ;
  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: storageDesc_mem

        generic_1port_memory #(.GENERIC_MEM_DEPTH          (`MGR_LOCAL_STORAGE_DESC_MEMORY_DEPTH  ),
                               .GENERIC_MEM_REGISTERED_OUT (0                                     ),
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
      end
  endgenerate
  
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Hold the data in a holding register and fill entries and word mask as data arrives
  // - pass to MMC once a new channel/bank/page/line is seen from the sdp_request control
  // - need to manage how long to hold data FIXME: should we respond to the MMC if it sees a waiting write but needs to read??? (sounds too hard)
  

  //------------------------------------------------------------------------------------------------------------------------
  // Holding register
  // - keed holding register(s) for each channel

  reg   [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_RANGE ]                                held_valid          [`MGR_DRAM_NUM_CHANNELS ]                                     ;
  //reg                                                                              held_available      [`MGR_DRAM_NUM_CHANNELS ]                                     ;
  reg   [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_RANGE     ]                                held_next_available [`MGR_DRAM_NUM_CHANNELS ]                                     ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE               ]                                held_bank           [`MGR_DRAM_NUM_CHANNELS ] [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ] ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE               ]                                held_page           [`MGR_DRAM_NUM_CHANNELS ] [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ] ;
  `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE
    reg  [`MGR_DRAM_CLINE_ADDRESS_RANGE             ]                                held_cline          [`MGR_DRAM_NUM_CHANNELS ] [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ] ;  // if a dram access reads less than a page, we need to generate additional memory requests when we transition a line
  `endif                                                                                                                                                       
  reg   [`MWC_CNTL_CACHE_ENTRY_WORD_VEC_RANGE       ] [`MGR_EXEC_LANE_WIDTH_RANGE ]  held_data           [`MGR_DRAM_NUM_CHANNELS ] [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ] ;
  reg   [`MWC_CNTL_CACHE_ENTRY_WORD_VEC_RANGE       ]                                held_mask           [`MGR_DRAM_NUM_CHANNELS ] [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ] ;
  reg   [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_RANGE ]                                held_last_accessed  [`MGR_DRAM_NUM_CHANNELS ]                                     ;
  reg   [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_RANGE ]                                held_update         [`MGR_DRAM_NUM_CHANNELS ]                                     ;

  //output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  mwc__mmc__data          ,
  //output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ]                                 mwc__mmc__data_mask     ,
                                                                                                          
  //reg   [`MGR_INST_OPTION_ORDER_RANGE               ]                                held_accessOrder    [`MGR_DRAM_NUM_CHANNELS ] [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ] ;


  //----------------------------------------------------------------------------------------------------
  // extract the state of the selected interface fsm and fifo 
  reg  [`MWC_CNTL_PTR_DATA_RCV_STATE_RANGE        ]     mwc_cntl_extract_desc_state  ; // state flop
  reg                                                   pipe_valid                   ;
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE         ]     pipe_mem_data                ; 

  reg                                                   holding_reg_clear            ;

  always @(*)
    begin
      case ({enable_rdp_fsm, enable_mcntl_fsm}) // synopsys parallel_case
        2'b10:
          begin
            mwc_cntl_extract_desc_state  =  intf_fsm[0].mwc_cntl_extract_desc_state ;
            holding_reg_clear            =  intf_fsm[0].holding_reg_clear           ;

            pipe_valid                   =  input_intf_fifo[0].pipe_valid           ;
            pipe_mem_data                =  input_intf_fifo[0].pipe_mem_data        ;
          end
        2'b01:
          begin
            mwc_cntl_extract_desc_state  =  intf_fsm[1].mwc_cntl_extract_desc_state ;
            holding_reg_clear            =  intf_fsm[1].holding_reg_clear           ;

            pipe_valid                   =  input_intf_fifo[1].pipe_valid           ;
            pipe_mem_data                =  input_intf_fifo[1].pipe_mem_data        ;
          end
        default
          begin
            mwc_cntl_extract_desc_state  =  'd0    ;  // set to invalid state if neither input fsm is selected
            pipe_valid                   =  'd0    ;
            pipe_mem_data                =  'd0    ;
            holding_reg_clear            = 1'b1    ;
          end
      endcase
    end
  //----------------------------------------------------------------------------------------------------
  
  always @(*)
    begin
      storage_desc_address_valid = intf_fsm[0].storage_desc_address_valid | intf_fsm[1].storage_desc_address_valid ;
    end

  always @(*)
    begin
      case ({enable_rdp_fsm, enable_mcntl_fsm}) // synopsys parallel_case
        2'b10:
          begin
            inc_address_data_valid  =  intf_fsm[0].pipe_valid & ((intf_fsm[0].mwc_cntl_extract_desc_state == `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER) | 
                                                                 (intf_fsm[0].mwc_cntl_extract_desc_state == `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER) );
          end
        2'b01:
          begin
            inc_address_data_valid  =  intf_fsm[1].pipe_valid & ((intf_fsm[1].mwc_cntl_extract_desc_state == `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER) | 
                                                                 (intf_fsm[1].mwc_cntl_extract_desc_state == `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER) );
          end
        default
          begin
            inc_address_data_valid  =  'd0 ;
          end
      endcase
    end

  genvar entry ;
  genvar chan ;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: entry_clr
        for (entry=0; entry<`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ; entry++)
          begin
            always @(*)
              begin
                case ({enable_rdp_fsm, enable_mcntl_fsm}) // synopsys parallel_case
                  2'b10:
                    begin
                      held_entry_clear[chan][entry]  =  mmc_ready & (chan == inc_channel) & ~held_last_accessed [chan][entry] & ((intf_fsm[0].mwc_cntl_extract_desc_state == `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER) | 
                                                                                                                                 (intf_fsm[0].mwc_cntl_extract_desc_state == `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER) );
                    end
                  2'b01:
                    begin
                      held_entry_clear[chan][entry]  =  mmc_ready & (chan == inc_channel) & ~held_last_accessed [chan][entry] & ((intf_fsm[1].mwc_cntl_extract_desc_state == `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER) | 
                                                                                                                                 (intf_fsm[1].mwc_cntl_extract_desc_state == `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER) );
                    end
                  default
                    begin
                      held_entry_clear[chan][entry]  =  'd0 ;
                    end
                endcase
              end
          end
      end
  endgenerate

  // We will initially form a channel/bank/page/line addresses based on the start address from the sdp request controller.
  // An overall address is formed based on the chan/bank/page/line fields and the access order.
  // As we grab each word, we will use this address to index into the holding register.
  // The address will be incremented for each word
  
  always @(posedge clk)
    begin
      case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
        `MWC_CNTL_PTR_DATA_RCV_WAIT :
          begin
            storage_desc_address_latched <= 1'b0 ;
          end
        `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE :
          begin
            storage_desc_address_latched <= storage_desc_address_valid;
          end
        default:
          begin
            storage_desc_address_latched <= storage_desc_address_latched ;
          end
      endcase
    end

  always @(posedge clk)
    begin

      sdmem_AccessOrder_latched <= sdmem_AccessOrder_latched ;

      case (mwc_cntl_extract_desc_state)  // synopsys parallel_case

        `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE :
          begin
            // reorder fields for incrementing
            if (~storage_desc_address_latched)  // if the current storage desc is to local SSC. We will only se one to this SSC
              begin
                sdmem_AccessOrder_latched <= sdmem_AccessOrder ;
              end
            else
              begin
                sdmem_AccessOrder_latched <= sdmem_AccessOrder_latched ;
              end
          end

        default:
          begin
            sdmem_AccessOrder_latched <= sdmem_AccessOrder_latched ;
          end

      endcase
    end

  always @(*)
    begin

      inc_address_e1 =  inc_address ;

      case (mwc_cntl_extract_desc_state)  // synopsys parallel_case

        `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE :
          begin
            // reorder fields for incrementing
            if (~storage_desc_address_latched)  // if the current storage desc is to local SSC. We will only se one to this SSC
              begin
                if (sdmem_AccessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
                  begin
                    inc_address_e1 =  {sdmem_Address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ] , 
                                       sdmem_Address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ] , 
                                       sdmem_Address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ] , 
                                       sdmem_Address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ] , 
                                       2'b00                                              };
                  end
                else if (sdmem_AccessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
                  begin
                    inc_address_e1 =  {sdmem_Address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ] , 
                                       sdmem_Address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ] , 
                                       sdmem_Address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ] , 
                                       sdmem_Address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ] , 
                                       2'b00                                              };
                  end
                else 
                  begin
                    inc_address_e1 =  {sdmem_Address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ] , 
                                       sdmem_Address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ] , 
                                       sdmem_Address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ] , 
                                       sdmem_Address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ] , 
                                       2'b00                                              };
                  end
              end
          end

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :
          begin
            // increment if pipe is valid
            //inc_address_e1 =  inc_address + ({`MGR_DRAM_LOCAL_ADDRESS_WIDTH {pipe_valid}} & (`MGR_DRAM_LOCAL_ADDRESS_WIDTH 'd4)) ;
            inc_address_e1 =  (held_accept[inc_channel] && pipe_valid )  ? inc_address + 'd4 :
                                                                           inc_address       ;
          end

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER :
          begin
            //inc_address_e1 =  inc_address + (`MGR_DRAM_LOCAL_ADDRESS_WIDTH 'd4) ;
            inc_address_e1 =  (held_accept[inc_channel] )  ?  inc_address + 'd4 :
                                                              inc_address       ;
          end

        default:
          begin
            inc_address_e1 =  inc_address ;
          end

      endcase
    end

  // Extract chan/bank/page/line
  always @(*)
    begin
      case (mwc_cntl_extract_desc_state)  // synopsys parallel_case

        // first load of INC the sdmem_AccessOrder hasnt been latched, so use value directly from memory
        `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE :
          begin
            if (sdmem_AccessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                inc_channel_e1 =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
                inc_bank_e1    =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_BANK_FIELD_RANGE ]  ;
                inc_page_e1    =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_PAGE_FIELD_RANGE ]  ;
                inc_word_e1    =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  inc_line_e1  =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else if (sdmem_AccessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                inc_channel_e1 =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                inc_bank_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                inc_page_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                inc_word_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  inc_line_e1  =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else 
              begin
                inc_channel_e1 =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                inc_bank_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                inc_page_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                inc_word_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  inc_line_e1  =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
          end
        // AFter first load of INC, use latched sdmem_AccessOrder because memory output not stable
        default:
          begin
            if (sdmem_AccessOrder_latched == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                inc_channel_e1 =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
                inc_bank_e1    =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_BANK_FIELD_RANGE ]  ;
                inc_page_e1    =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_PAGE_FIELD_RANGE ]  ;
                inc_word_e1    =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  inc_line_e1  =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else if (sdmem_AccessOrder_latched == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                inc_channel_e1 =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                inc_bank_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                inc_page_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                inc_word_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  inc_line_e1  =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
            else 
              begin
                inc_channel_e1 =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
                inc_bank_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
                inc_page_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
                inc_word_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
                `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
                  inc_line_e1  =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
                `endif
              end
          end
      endcase
    end // always @ (*)

  // Register the stream address and individual fields
  always @(posedge clk)
    begin
      inc_address     <=  inc_address_e1 ;
      inc_channel     <=  inc_channel_e1 ;
      inc_bank        <=  inc_bank_e1    ;
      inc_page        <=  inc_page_e1    ;
      inc_word        <=  inc_word_e1    ;
      `ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
        inc_line      <=  inc_line_e1    ;
      `endif
    end 


  always @(posedge clk)
    begin
      //mwc__mmc__valid_e1  =  1'b0     ;
      //mwc__mmc__data_valid_e1  =  1'b0     ;
    end

  reg   [`MWC_CNTL_CACHE_ENTRY_LINES_RANGE        ]     holding_reg_line_count          ;  // cycle thru cache entries (actually cycle thru each line)
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE          ]     holding_reg_chan_ptr            ; 
  reg   [`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_RANGE   ]     holding_reg_chan_cline_ptr           ;
  reg   [`MGR_DRAM_LINE_ADDRESS_RANGE             ]     holding_reg_chan_cline_line_ptr            ;                             
  always @(*)
    begin
      case ({enable_rdp_fsm, enable_mcntl_fsm}) // synopsys parallel_case
        2'b10:
          begin
            holding_reg_line_count            = intf_fsm[0].holding_reg_line_count ;
            holding_reg_chan_ptr              = intf_fsm[0].holding_reg_chan_ptr   ; 
            holding_reg_chan_cline_ptr        = intf_fsm[0].holding_reg_chan_cline_ptr  ;
            holding_reg_chan_cline_line_ptr   = intf_fsm[0].holding_reg_chan_cline_line_ptr   ;
          end
        2'b01:
          begin
            holding_reg_line_count            = intf_fsm[1].holding_reg_line_count ;
            holding_reg_chan_ptr              = intf_fsm[1].holding_reg_chan_ptr   ; 
            holding_reg_chan_cline_ptr        = intf_fsm[1].holding_reg_chan_cline_ptr  ;
            holding_reg_chan_cline_line_ptr   = intf_fsm[1].holding_reg_chan_cline_line_ptr   ;
          end
        default:
          begin
            holding_reg_line_count            = 'd0 ;
            holding_reg_chan_ptr              = 'd0 ;
            holding_reg_chan_cline_ptr        = 'd0 ;
            holding_reg_chan_cline_line_ptr   = 'd0 ;
          end
      endcase
    end

  always @(*)
    begin
      case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
        `MWC_CNTL_PTR_DATA_RCV_FLUSH_ALL_HOLDING_REGS :
          begin
            mwc__mmc__data_valid_e1     =  held_valid [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] & mmc_ready ;

            mwc__mmc__data_cntl_e1      =  (holding_reg_chan_cline_line_ptr   == 'd0) ? `COMMON_STD_INTF_CNTL_SOM  :
                                                                                        `COMMON_STD_INTF_CNTL_EOM  ;
            mwc__mmc__data_channel_e1   =  holding_reg_chan_ptr      ;

            mwc__mmc__data_e1           =  (holding_reg_chan_cline_line_ptr == 'd0) ?   held_data  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE0_RANGE ] :
                                                                                        held_data  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE1_RANGE ] ;
            mwc__mmc__data_mask_e1      =  (holding_reg_chan_cline_line_ptr == 'd0) ?   held_mask  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE0_RANGE ] :
                                                                                        held_mask  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE1_RANGE ] ;
          end
        `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER :
          begin
            mwc__mmc__data_valid_e1     =  (holding_reg_chan_ptr == inc_channel) & ~held_last_accessed [holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] & mmc_ready ;

            mwc__mmc__data_cntl_e1      =  (holding_reg_chan_cline_line_ptr   == 'd0) ? `COMMON_STD_INTF_CNTL_SOM  :
                                                                                        `COMMON_STD_INTF_CNTL_EOM  ;
            mwc__mmc__data_channel_e1   =  holding_reg_chan_ptr      ;

            mwc__mmc__data_e1           =  (holding_reg_chan_cline_line_ptr == 'd0) ?   held_data  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE0_RANGE ] :
                                                                                        held_data  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE1_RANGE ] ;
            mwc__mmc__data_mask_e1      =  (holding_reg_chan_cline_line_ptr == 'd0) ?   held_mask  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE0_RANGE ] :
                                                                                        held_mask  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE1_RANGE ] ;
          end
        `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER :
          begin
            mwc__mmc__data_valid_e1     =  (holding_reg_chan_ptr == inc_channel) & ~held_last_accessed [holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] & mmc_ready ;

            mwc__mmc__data_cntl_e1      =  (holding_reg_chan_cline_line_ptr   == 'd0) ? `COMMON_STD_INTF_CNTL_SOM  :
                                                                                        `COMMON_STD_INTF_CNTL_EOM  ;
            mwc__mmc__data_channel_e1   =  holding_reg_chan_ptr      ;

            mwc__mmc__data_e1           =  (holding_reg_chan_cline_line_ptr == 'd0) ?   held_data  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE0_RANGE ] :
                                                                                        held_data  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE1_RANGE ] ;
            mwc__mmc__data_mask_e1      =  (holding_reg_chan_cline_line_ptr == 'd0) ?   held_mask  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE0_RANGE ] :
                                                                                        held_mask  [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] [`MWC_CNTL_CLINE_LINE1_RANGE ] ;
          end

        default:
          begin
            mwc__mmc__data_valid_e1     =  1'b0  ;
            mwc__mmc__data_cntl_e1      =   'd0  ;
            mwc__mmc__data_channel_e1   =   'd0  ;
            mwc__mmc__data_e1           =   'd0  ;
            mwc__mmc__data_mask_e1      =   'd0  ;
          end

      endcase
    end
    
  always @(*)
    begin
      case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
        `MWC_CNTL_PTR_DATA_RCV_FLUSH_ALL_HOLDING_REGS :
          begin
            mwc__mmc__valid_e1         = held_valid [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] &  (holding_reg_chan_cline_line_ptr   == 'd0) & mmc_ready;
            //mwc__mmc__valid_e1         = 'd0 ;
            mwc__mmc__cntl_e1          = `COMMON_STD_INTF_CNTL_SOM_EOM  ;
            mwc__mmc__tag_e1           =   'd0  ;
            mwc__mmc__channel_e1       = holding_reg_chan_ptr      ;
            mwc__mmc__bank_e1          = held_bank [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] ;
            mwc__mmc__page_e1          = held_page [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] ;
            mwc__mmc__word_e1          = 'd0;
          end
        `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER :
          begin
            mwc__mmc__valid_e1         = (holding_reg_chan_ptr == inc_channel) & ~held_last_accessed [holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] & (holding_reg_chan_cline_line_ptr   == 'd0) & mmc_ready;
            //mwc__mmc__valid_e1         = 'd0 ;
            mwc__mmc__cntl_e1          = `COMMON_STD_INTF_CNTL_SOM_EOM  ;
            mwc__mmc__tag_e1           =   'd0  ;
            mwc__mmc__channel_e1       = holding_reg_chan_ptr      ;
            mwc__mmc__bank_e1          = held_bank [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] ;
            mwc__mmc__page_e1          = held_page [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] ;
            mwc__mmc__word_e1          = 'd0;
          end
        `MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER :
          begin
            mwc__mmc__valid_e1         = (holding_reg_chan_ptr == inc_channel) & ~held_last_accessed [holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] & (holding_reg_chan_cline_line_ptr   == 'd0) & mmc_ready;
            //mwc__mmc__valid_e1         = 'd0 ;
            mwc__mmc__cntl_e1          = `COMMON_STD_INTF_CNTL_SOM_EOM  ;
            mwc__mmc__tag_e1           =   'd0  ;
            mwc__mmc__channel_e1       = holding_reg_chan_ptr      ;
            mwc__mmc__bank_e1          = held_bank [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] ;
            mwc__mmc__page_e1          = held_page [ holding_reg_chan_ptr  ] [holding_reg_chan_cline_ptr  ] ;
            mwc__mmc__word_e1          = 'd0;
          end

        default:
          begin
            mwc__mmc__valid_e1     =  1'b0  ;
            mwc__mmc__cntl_e1      =   'd0  ;
            mwc__mmc__tag_e1       =   'd0  ;
            mwc__mmc__channel_e1   =   'd0  ;
            mwc__mmc__bank_e1      =   'd0  ;
            mwc__mmc__page_e1      =   'd0  ;
            mwc__mmc__word_e1      =   'd0  ;
          end

      endcase
    end
    

  // Find an available entry
/*
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: check_avail
        always @(*)
          begin
            held_next_available [chan]   = 'd0 ;
            for (int e=0; e<`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ; e++)
              begin
                held_next_available [chan]   = (~held_valid[chan][e]) ? e : held_next_available [chan] ;
              end
          end
      end
  endgenerate
*/
  always @(*)
    begin
      held_available      [0]   = ~&held_valid [0]  ;
      held_available      [1]   = ~&held_valid [1]  ;

      held_next_available [0]   = (~held_valid[0][0]) ? 'd0:
                                                        'd1;
      held_next_available [1]   = (~held_valid[1][0]) ? 'd0:
                                                        'd1;

      held_accept         [0]   =  |held_addr_hit[0] | held_available[0] ;  // holding register will accept data if a current entry hits or there is an invalid entry (available)
      held_accept         [1]   =  |held_addr_hit[1] | held_available[1] ;
    end

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: check_hit
        for (entry=0; entry<`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ; entry++)
          begin
            always @(*)
              begin
                held_addr_hit[chan][entry]  =  (chan == inc_channel) & held_valid[chan][entry] & ((held_bank [chan][entry] == inc_bank) & 
                                                                                                  (held_page [chan][entry] == inc_page) &                                                
                                                                                                `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE
                                                                                                  (held_cline [chan][entry] == inc_line));
                                                                                                `else
                                                                                                  1'b1 );
                                                                                                `endif
              end
          end
      end
  endgenerate

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: set_entry
        for (entry=0; entry<`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ; entry++)
          begin
            always @(posedge clk)
              begin
                held_valid   [chan][entry]   <=  ( holding_reg_clear                                                                      ) ? 1'b0                     :
                                                 ( held_entry_clear [chan][entry]                                                         ) ? 1'b0                    :
                                                 ( |held_addr_hit [chan]                                                                  ) ? held_valid [chan][entry] :  // an entry already holds data
                                                 ((chan == inc_channel) && inc_address_data_valid && (held_next_available [chan] == entry)) ? 1'b1                     :
                                                                                                                                              held_valid [chan][entry] ;
                                                                                                            
                held_bank    [chan][entry]   <=  ( held_valid [chan][entry]                                                               ) ? held_bank [chan][entry] :
                                                 ((chan == inc_channel) && inc_address_data_valid && (held_next_available [chan] == entry)) ? inc_bank                :
                                                                                                                                              held_bank [chan][entry] ;
                                                                                                            
                held_page    [chan][entry]   <=  ( held_valid [chan][entry]                                                               ) ? held_page [chan][entry] :
                                                 ((chan == inc_channel) && inc_address_data_valid && (held_next_available [chan] == entry)) ? inc_page                :
                                                                                                                                              held_page [chan][entry] ;
                                                                                                            
                `ifdef  MGR_DRAM_REQUEST_CLINE_LT_PAGE
                held_cline    [chan][entry]   <= ( held_valid [chan][entry]                                                               ) ? held_cline [chan][entry]                          :
                                                 ((chan == inc_channel) && inc_address_data_valid && (held_next_available [chan] == entry)) ? inc_word [`MGR_DRAM_CLINE_IN_WORD_ADDRESS_RANGE ] :
                                                                                                                                              held_cline [chan][entry]                          ;
                `endif

              end
          end
      end
  endgenerate

  genvar word;
  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: load_hold
        for (entry=0; entry<`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ; entry++)
          begin
            for (word=0; word<`MGR_DRAM_NUM_WORDS_PER_CLINE; word++)
              begin
                always @(posedge clk)
                  begin

                    case (mwc_cntl_extract_desc_state)
                      `MWC_CNTL_PTR_DATA_RCV_WAIT :
                        begin
                          held_mask [chan][entry][word] <=  'd0 ;
                          held_data [chan][entry][word] <= held_data [chan][entry][word] ;
                        end

                      `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :
                        begin
                          if ((chan == inc_channel) && inc_address_data_valid && (held_addr_hit [chan][entry] || (~|held_addr_hit [chan] && (held_next_available[chan] == entry) && held_accept[chan])))
                            begin
                              held_mask [chan][entry][word] <=  (word == inc_word) ? 1'b1                                                           :
                                                                                     held_mask [chan][entry][word]                                  ;
                              held_data [chan][entry][word] <=  (word == inc_word) ? pipe_mem_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE ] :
                                                                                     held_data [chan][entry][word]                                  ;
                            end
                        end
                   
                      `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER :
                        begin
                          if ((chan == inc_channel) && inc_address_data_valid && (held_addr_hit [chan][entry] || (~|held_addr_hit [chan] && (held_next_available[chan] == entry) && held_accept[chan])))
                            begin
                              held_mask [chan][entry][word] <=  (word == inc_word) ? 1'b1                                                           :
                                                                                     held_mask [chan][entry][word]                                  ;
                              held_data [chan][entry][word] <=  (word == inc_word) ? pipe_mem_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE ] :
                                                                                     held_data [chan][entry][word]                                  ;
                            end
                        end
                   
                      default:
                        begin
                          held_mask [chan][entry][word] <= held_mask [chan][entry][word] ;
                          held_data [chan][entry][word] <= held_data [chan][entry][word] ;
                        end
                    endcase
                  end
              end
          end
      end
  endgenerate


  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: hold_updated
        always @(*)
          begin
            case (mwc_cntl_extract_desc_state)
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :
                begin
                 for (int entry=0; entry<`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ; entry++)
                   begin
                     held_update [chan][entry] = ((chan == inc_channel) && inc_address_data_valid && (held_addr_hit [chan][entry] || (~|held_addr_hit [chan] && (held_next_available[chan] == entry) && held_accept[chan])));
                   end
                end
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER :
                begin
                 for (int entry=0; entry<`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ; entry++)
                   begin
                     held_update [chan][entry] = ((chan == inc_channel) && inc_address_data_valid && (held_addr_hit [chan][entry] || (~|held_addr_hit [chan] && (held_next_available[chan] == entry) && held_accept[chan])));
                   end
                end
              default:
                begin
                 for (int entry=0; entry<`MWC_CNTL_CACHE_ENTRIES_PER_CHAN ; entry++)
                   begin
                     held_update [chan][entry] = 1'b0 ;
                   end
                end
            endcase
          end
      end
  endgenerate

  generate
    for (chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
      begin: set_accessed
        always @(posedge clk)
          begin
            case (mwc_cntl_extract_desc_state)
              `MWC_CNTL_PTR_DATA_RCV_WAIT :
                begin
                  held_last_accessed [chan] <=  'd0 ;
                end

              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :
                begin
                  if (|held_update [chan])
                    begin
                      held_last_accessed [chan] <=  held_update [chan]  ;
                    end
                  else
                    begin
                      held_last_accessed [chan] <=  held_last_accessed [chan]  ;
                    end
                end
           
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER :
                begin
                  if (|held_update [chan])
                    begin
                      held_last_accessed [chan] <=  held_update [chan]  ;
                    end
                  else
                    begin
                      held_last_accessed [chan] <=  held_last_accessed [chan]  ;
                    end
                end
           
              default:
                begin
                  held_last_accessed [chan] <=  held_last_accessed [chan] ;
                end
            endcase
          end
      end
  endgenerate

//------------------------------------------------------------------------------------------------------------------------------------------------------

endmodule
