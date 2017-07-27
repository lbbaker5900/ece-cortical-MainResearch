/*********************************************************************************************

    File name   : mwc_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

    Description : Receives memory descriptors and data from the NoC and writes data to main memory
                  Introduce a custom access to teh DRAM known as "masked" cache write
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
            input  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__mwc__type       ,   // dont need this
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
            input   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]     rdp__mwc__ptype      , 
            input   wire                                             rdp__mwc__pvalid     , 
            input   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]     rdp__mwc__data       , 
  
            //-------------------------------------------------------------------------------------------------
            // Main Memory Controller interface
            //
            // Requests are sent out ahead of data
            output  reg                                                                           mwc__mmc__valid         ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE          ]                                 mwc__mmc__cntl          ,
            input   wire                                                                          mmc__mwc__ready         ,
                                                                                                                          
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 mwc__mmc__channel       ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE         ]                                 mwc__mmc__bank          ,
            output  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE         ]                                 mwc__mmc__page          ,
            output  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE         ]                                 mwc__mmc__word          ,

            // Data associated with request (note: dont forget it needs to be in the same order as the request)
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 mwc__mmc__data_channel  ,
            output  reg                                                                           mwc__mmc__data_valid    ,
            output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  mwc__mmc__data          ,
            output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ]                                 mwc__mmc__data_mask     ,
                                                                                                                    

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
  // from MCNTL (NoC)
  reg                                               mcntl__mwc__valid_d1      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__mwc__cntl_d1       ; 
  //reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE ]     mcntl__mwc__type_d1       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__mwc__ptype_d1      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__mwc__data_d1       ; 
  reg                                               mcntl__mwc__pvalid_d1     ; 
  //reg  [`MGR_MGR_ID_RANGE                   ]     mcntl__mwc__mgrId_d1      ; 
  reg                                               mwc__mcntl__ready_e1      ; 


  //-------------------------------------------------------------------------------------------------
  // from RDP (local)
  reg                                               rdp__mwc__valid_d1      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     rdp__mwc__cntl_d1       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     rdp__mwc__ptype_d1      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     rdp__mwc__data_d1       ; 
  reg                                               rdp__mwc__pvalid_d1     ; 
  reg                                               mwc__rdp__ready_e1      ; 


  //--------------------------------------------------
  // to Main Memory Controller
  
  reg                                           mwc__mmc__valid_e1      ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE     ]      mwc__mmc__cntl_e1       ;
  reg                                           mmc__mwc__ready_d1      ;
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE ]      mwc__mmc__channel_e1    ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE    ]      mwc__mmc__bank_e1       ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE    ]      mwc__mmc__page_e1       ;
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE    ]      mwc__mmc__word_e1       ;

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Register inputs and outputs

  //--------------------------------------------------
  // from MCNTL
  
  always @(posedge clk) 
    begin
      mcntl__mwc__valid_d1    <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__valid      ;
      mcntl__mwc__cntl_d1     <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__cntl       ;
      //mcntl__mwc__type_d1   <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__type       ;
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
      rdp__mwc__ptype_d1    <=   ( reset_poweron   ) ? 'd0  : rdp__mwc__ptype      ;
      rdp__mwc__data_d1     <=   ( reset_poweron   ) ? 'd0  : rdp__mwc__data       ;
      rdp__mwc__pvalid_d1   <=   ( reset_poweron   ) ? 'd0  : rdp__mwc__pvalid     ;
      mwc__rdp__ready       <=   ( reset_poweron   ) ? 'd0  : mwc__rdp__ready_e1   ;
    end


  //--------------------------------------------------
  // to Main Memory Controller
  
  always @(posedge clk) 
    begin
      mwc__mmc__valid      <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__valid_e1   ;
      mwc__mmc__cntl       <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__cntl_e1    ;
      mmc__mwc__ready_d1   <=   ( reset_poweron   ) ? 'd0  :  mmc__mwc__ready      ;
      mwc__mmc__channel    <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__channel_e1 ;
      mwc__mmc__bank       <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__bank_e1    ;
      mwc__mmc__page       <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__page_e1    ;
      mwc__mmc__word       <=   ( reset_poweron   ) ? 'd0  :  mwc__mmc__word_e1    ;
    end

  //------------------------------------------------------------------------------------------------------------------------
  // State register 
  reg [`MWC_CNTL_INPUT_ARB_STATE_RANGE ] mwc_cntl_input_arb_state      ; // state flop
  reg [`MWC_CNTL_INPUT_ARB_STATE_RANGE ] mwc_cntl_input_arb_state_next ;

  always @(posedge clk)
    begin
      mwc_cntl_input_arb_state <= ( reset_poweron ) ? `MWC_CNTL_INPUT_ARB_WAIT        :
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
  reg                            storage_desc_processing_enable   ;  
  wire                           storage_desc_processing_complete ;  

  //------------------------------------------------------------------------------------------------------------------------
  // State Transitions
  //
  always @(*)
    begin
      case (mwc_cntl_input_arb_state)  // synopsys parallel_case)
        
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
          mwc_cntl_input_arb_state_next =   (intf_fsm[0].complete ) ? `MWC_CNTL_INPUT_ARB_COMPLETE :  
                                            (intf_fsm[1].complete ) ? `MWC_CNTL_INPUT_ARB_COMPLETE :  
                                                                      `MWC_CNTL_INPUT_ARB_WAIT    ;
  


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
            storage_desc_processing_enable  = intf_fsm[0].storage_desc_processing_enable ;
          end
        
        `MWC_CNTL_INPUT_ARB_MCNTL: 
          begin
            enable_mcntl_fsm                = 1'b1 ;
            storage_desc_processing_enable  = intf_fsm[1].storage_desc_processing_enable ;
          end
        
        default:
          begin
            enable_rdp_fsm                  = 1'b0 ;
            enable_mcntl_fsm                = 1'b0 ;
            storage_desc_processing_enable  = 1'b0 ;
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
        wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     pipe_ptype       ; 
        wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     pipe_mem_data    ; 
        wire                                              pipe_pvalid      ; 

        assign {pipe_cntl, pipe_ptype, pipe_pvalid, pipe_mem_data} = pipe_data ;
        //----------------------------------------------------------------------------------------------------

        wire   pipe_som     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ); 
        wire   pipe_eom     =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM);

        always @(*)
          begin
            mwc__mcntl__ready_e1  = ~almost_full ;
          end

      end
  endgenerate

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Connect inputs from rdp and mcntl to intf_fifos 

  //----------------------------------------------------------------------------------------------------
  // Write data fields
  assign input_intf_fifo[0].write       =  rdp__mwc__valid_d1 ;
  assign input_intf_fifo[0].write_data  = {rdp__mwc__cntl_d1, rdp__mwc__ptype_d1, rdp__mwc__pvalid_d1, rdp__mwc__data_d1};
  always @(*)
    begin
      mwc__rdp__ready_e1    = ~input_intf_fifo[0].almost_full ;
    end

  assign input_intf_fifo[1].write       =  mcntl__mwc__valid_d1 ;
  assign input_intf_fifo[1].write_data  = {mcntl__mwc__cntl_d1, mcntl__mwc__ptype_d1, mcntl__mwc__pvalid_d1, mcntl__mwc__data_d1};
  always @(*)
    begin
      mwc__mcntl__ready_e1  = ~input_intf_fifo[1].almost_full ;
    end

  // end of input fifos
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Extract Descriptor FSM
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // - Take storage descriptor option tuples from the fifo and construct starting address and word locations
  // - Give priority to NoC
  //

  reg                                                  start_valid                      ;  // Need to capture start address from request controller as it assumes a fifo and only pulses the valid
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE        ]      start_channel                    ;  // channel of latest start address from sdp request
  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE          ]      start_address                    ;
  reg   [`MGR_INST_OPTION_ORDER_RANGE           ]      start_accessOrder                ;
  wire  [`MGR_INST_OPTION_ORDER_RANGE           ]      strm_accessOrder                 ;  // same as start_accessOrder but use this name for copied code from sdp_stream_cntl.v
  assign strm_accessOrder = start_accessOrder   ;
  
  reg   [`MGR_NOC_INTERNAL_INTF_NUM_WORDS_RANGE ]      grab_word                        ;  // pulse when data is available. Vector of pulses for each word in data bus
      
  reg   [`MGR_STORAGE_DESC_ADDRESS_RANGE        ]      storage_desc_ptr                 ;  // pointer to local storage descriptor although msb's contain manager ID, so remove

  reg                                                  held_addr_miscompare             ;  // new descriptor is ponting to a line not in the holding register
  reg                                                  flush_from_lower                 ;  // keep track of which state we decided to flush 
      
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
        wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE      ]     pipe_ptype                      ; 
        wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE         ]     pipe_mem_data                   ; 
        wire                                                  pipe_pvalid                     ; 
        wire                                                  pipe_eom                        ;

        reg                                                  contains_storage_ptr             ;  
        reg                                                  contains_data                    ;  
        reg   [`MGR_STORAGE_DESC_ADDRESS_RANGE        ]      storage_desc_ptr                 ;  // pointer to local storage descriptor although msb's contain manager ID, so remove
        reg   [`MGR_STORAGE_DESC_ADDRESS_RANGE        ]      storage_desc_ptr_wire            ;  
        //reg [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE  ]      local_storage_desc_ptr           ;  // remove manager ID msb's
        reg   [`MGR_MGR_ID_RANGE                      ]      storage_desc_ptr_mgr_id          ;  // extract manager ID from descriptor
        reg                                                  storage_desc_processing_enable   ;  
                                                      
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
              `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF: 
                mwc_cntl_extract_desc_state_next =   (contains_storage_ptr ) ? `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_INTF :  
                                                     (contains_data        ) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_DATA              :  
                                                                               `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF   ;
        
        
              `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_INTF : 
                mwc_cntl_extract_desc_state_next =   ( storage_desc_ptr_mgr_id == sys__mgr__mgrId ) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_INTF :  // read the descriptor
                                                                                                      `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_INTF   ;
      
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_INTF : 
                mwc_cntl_extract_desc_state_next =   (storage_desc_processing_complete  ) ? `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_INTF    :  // read the descriptor
                                                                                            `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_INTF  ;
      
      
              `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_INTF : 
                mwc_cntl_extract_desc_state_next =   ( (storage_desc_ptr_mgr_id == sys__mgr__mgrId )) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_INTF         :  // read the descriptor
                                                                                                        `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE                 ;
      
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_INTF : 
                mwc_cntl_extract_desc_state_next =   (storage_desc_processing_complete  ) ? `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE             :  // read the descriptor
                                                                                            `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_INTF  ;
      
              `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE : 
                mwc_cntl_extract_desc_state_next =    `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF;
      
      
      
              //----------------------------------------------------------------------------------------------------
              // Keep data processing in the same FSM for now, but its turining into a lot of states
              
      
              // wait until the sdp request controller has provided the start address
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_DATA : 
                mwc_cntl_extract_desc_state_next =   ( start_valid                                              ) ? `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :  
                                                                                                                    `MWC_CNTL_PTR_DATA_RCV_PROCESS_DATA        ;
      
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER : 
                mwc_cntl_extract_desc_state_next =   ( held_addr_miscompare                                                                           ) ? `MWC_CNTL_PTR_DATA_RCV_FLUSH_1ST_HOLDING_REG                :  
                                                     ( pipe_valid && pipe_eom && (pipe_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_ONE)) ? `MWC_CNTL_PTR_DATA_RCV_COMPLETE                         :  // only one word valid in last cycle
                                                     ( pipe_valid                                                                                     ) ? `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER :  
                                                                                                                                                          `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER ;
      
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER : 
              // we dont get here unless the pipe is valid, so dont bother checking
                mwc_cntl_extract_desc_state_next =   ( held_addr_miscompare   ) ? `MWC_CNTL_PTR_DATA_RCV_FLUSH_1ST_HOLDING_REG            :  
                                                     ( pipe_eom               ) ? `MWC_CNTL_PTR_DATA_RCV_COMPLETE                         :  // only one word valid in last cycle
                                                                                  `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER ;
      
      
              //----------------------------------------------------------------------------------------------------
              // Flush data in holding register(s)
              //
              `MWC_CNTL_PTR_DATA_RCV_FLUSH_1ST_HOLDING_REG : 
                mwc_cntl_extract_desc_state_next =   `MWC_CNTL_PTR_DATA_RCV_FLUSH_2ND_HOLDING_REG ;
      
              
              `MWC_CNTL_PTR_DATA_RCV_FLUSH_2ND_HOLDING_REG : 
                mwc_cntl_extract_desc_state_next =   (flush_from_lower ) ? `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :
                                                                           `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER ;
      
              
              //----------------------------------------------------------------------------------------------------
              // Complete
              //
              // wait for enable to be deasserted
              `MWC_CNTL_PTR_DATA_RCV_COMPLETE : 
                mwc_cntl_extract_desc_state_next =   ( enable || storage_desc_processing_complete        ) ? `MWC_CNTL_PTR_DATA_RCV_COMPLETE:  
                                                                                                             `MWC_CNTL_PTR_DATA_RCV_WAIT        ;
      
              `MWC_CNTL_PTR_DATA_RCV_ERR : 
                mwc_cntl_extract_desc_state_next =   `MWC_CNTL_PTR_DATA_RCV_ERR        ;
      
      
      
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
            contains_storage_ptr            = 'd0  ;
            contains_data                   = 'd0  ;
            storage_desc_ptr_mgr_id         = 'd0  ;
            storage_desc_processing_enable  = 'd0  ;  
            pipe_read                       = 'd0  ;
            complete                        = 'd0  ;  

            case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
              
              `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF: 
                begin
                  contains_storage_ptr = pipe_valid & (((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) | 
                                                       ((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES ) & (pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )));
                                                                                                           
                                                                                             
                  
                  contains_data        = pipe_valid & (((pipe_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_DATA )));
                                                                                                          
                  pipe_read   = ~contains_storage_ptr & ~contains_data ;
                  complete    = 1'b0 ;

                end
      
              `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_INTF : 
                begin
                  storage_desc_ptr_wire     = pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] ;
                  storage_desc_ptr_mgr_id   =  storage_desc_ptr_wire [`MGR_STORAGE_DESC_MGR_ID_FIELD_RANGE  ] ;  // extract manager ID msb's
                end
              
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_INTF : 
                begin
                  storage_desc_processing_enable  = 'd1  ;  
                                                                                                          
                end
              
              `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_INTF : 
                begin
                  storage_desc_ptr_wire     = pipe_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ] ;
                  storage_desc_ptr_mgr_id   =  storage_desc_ptr_wire [`MGR_STORAGE_DESC_MGR_ID_FIELD_RANGE  ] ;  // extract manager ID msb's
                end
              
              `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_INTF : 
                begin
                  storage_desc_processing_enable  = 'd1  ;  
                end
              
              `MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE : 
                begin
                  pipe_read   = 1'b1 ;
                end
      
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER : 
                begin
                  pipe_read   = ~held_addr_miscompare & pipe_valid & pipe_eom & (pipe_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_ONE) ;
                end
              
              `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER : 
                begin
                  pipe_read   = ~held_addr_miscompare & pipe_valid ;
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
                  storage_desc_processing_enable  = 'd0  ;  
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
          end // always @ (*)
      
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
        assign  intf_fsm[intf].pipe_eom      =  input_intf_fifo[intf].pipe_eom      ;
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
  // - generates memory requests and passes starting address and consequtive/jump values to the storage descriptor stream controller
  // - sends the channel/bank/page/line address associated with each request to the main memory controller

  // Use the config output to obtain the start address and access mode
  wire                                            sdpr_cfg_valid       ;
  wire   [`MGR_DRAM_LOCAL_ADDRESS_RANGE       ]   sdpr_cfg_addr        ;
  wire   [`MGR_INST_OPTION_ORDER_RANGE        ]   sdpr_cfg_accessOrder ;
  wire                                            sdpr_complete        ;

  always @(*)
    begin
      case ({enable_rdp_fsm, enable_mcntl_fsm}) // synopsys parallel_case
        2'b10:
          begin
            storage_desc_ptr  =  intf_fsm[0].storage_desc_ptr ;
          end
        2'b01:
          begin
            storage_desc_ptr  =  intf_fsm[1].storage_desc_ptr ;
          end
        default
          begin
            storage_desc_ptr  =  'd0 ;
          end
      endcase
    end

  
  sdp_request_cntl sdp_request_cntl (  

            .xxx__sdp__storage_desc_processing_enable     ( storage_desc_processing_enable             ),
            .sdp__xxx__storage_desc_processing_complete   ( storage_desc_processing_complete           ),
            .xxx__sdp__storage_desc_ptr                   ( storage_desc_ptr                           ),  // pointer to local storage descriptor although msb's contain manager ID, so remove
            //.xxx__sdp__num_lanes                        ( xxx__sdp__num_lanes                        ),
            //.xxx__sdp__txfer_type                       ( xxx__sdp__txfer_type                       ),
            //.xxx__sdp__target                           ( xxx__sdp__target                           ),

            .sdp__xxx__mem_request_valid                  ( mwc__mmc__valid_e1                         ),
            .sdp__xxx__mem_request_cntl                   ( mwc__mmc__cntl_e1                          ),
                                                                                                 
            .xxx__sdp__mem_request_ready                  ( mmc__mwc__ready_d1                         ),
                                                                                                 
            .sdp__xxx__mem_request_channel                ( mwc__mmc__channel_e1                       ),
            .sdp__xxx__mem_request_bank                   ( mwc__mmc__bank_e1                          ),
            .sdp__xxx__mem_request_page                   ( mwc__mmc__page_e1                          ),
            .sdp__xxx__mem_request_word                   ( mwc__mmc__word_e1                          ),

            .sdpr__sdps__cfg_valid                        ( sdpr_cfg_valid                             ),
            .sdpr__sdps__cfg_addr                         ( sdpr_cfg_addr                              ),
            .sdpr__sdps__cfg_accessOrder                  ( sdpr_cfg_accessOrder                       ),
            .sdps__sdpr__cfg_ready                        ( 1'b1                                       ),
            .sdps__sdpr__complete                         ( 1'b1 ),
            .sdpr__sdps__complete                         (                                            ),

            .sdpr__sdps__consJump_valid                   (                                            ),
            .sdpr__sdps__consJump_cntl                    (                                            ),
            .sdpr__sdps__consJump_value                   (                                            ),
            .sdps__sdpr__consJump_ready                   ( 1'b1                                       ),

            //------------------------------
            // General
            //
            .sys__mgr__mgrId                              ( sys__mgr__mgrId ),
            .clk                                          ( clk             ),
            .reset_poweron                                ( reset_poweron   )
                        );
 

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Hold the data in a holding register and fill entries and word mask as data arrives
  // - pass to MMC once a new channel/bank/page/line is seen from the sdp_request control
  // - need to manage how long to hold data FIXME: should we respond to the MMC if it sees a waiting write but needs to read??? (sounds too hard)
  
  // we have a holding register for each channel, we have to specify which channel should be released to the MMC 
  reg    [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]                                 channel_released_first   ;
  reg    [`MGR_DRAM_CHANNEL_ADDRESS_RANGE     ]                                 channel_released_second  ;

  //------------------------------------------------------------------------------------------------------------------------
  // Address for incrementing to index into holding register

  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE        ]                                 inc_address             ;  // address we increment for each jump - FIXME: could use a counter per word??
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 inc_channel             ;  // formed address in access order for incrementing
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE         ]                                 inc_bank                ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE         ]                                 inc_page                ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                                                           
    reg [`MGR_DRAM_LINE_ADDRESS_RANGE         ]                                 inc_line                ; 
  `endif                                                                                                     
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE         ]                                 inc_word                ;

  reg   [`MGR_DRAM_LOCAL_ADDRESS_RANGE        ]                                 inc_address_e1          ;  
  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 inc_channel_e1          ; 
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE         ]                                 inc_bank_e1             ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE         ]                                 inc_page_e1             ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                                                           
    reg [`MGR_DRAM_LINE_ADDRESS_RANGE         ]                                 inc_line_e1             ; 
  `endif                                                                                                     
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE         ]                                 inc_word_e1             ;
  //------------------------------------------------------------------------------------------------------------------------


  reg   [`MGR_DRAM_NUM_CHANNELS_VECTOR_RANGE  ]                                 held_valid                                 ;
  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE         ]                                 held_bank        [`MGR_DRAM_NUM_CHANNELS ] ;
  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE         ]                                 held_page        [`MGR_DRAM_NUM_CHANNELS ] ;
  `ifdef  MGR_DRAM_REQUEST_LT_PAGE                                                                                          
    reg  [`MGR_DRAM_LINE_ADDRESS_RANGE        ]                                 held_line        [`MGR_DRAM_NUM_CHANNELS ] ;  // if a dram access reads less than a page, we need to generate additional memory requests when we transition a line
  `endif                                                                                                                    
  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE         ]                                 held_word        [`MGR_DRAM_NUM_CHANNELS ] ;

  reg   [`MGR_INST_OPTION_ORDER_RANGE         ]                                 held_accessOrder [`MGR_DRAM_NUM_CHANNELS ] ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  held_data        [`MGR_DRAM_NUM_CHANNELS ] ;
  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ]                                 held_mask        [`MGR_DRAM_NUM_CHANNELS ] ;


  //----------------------------------------------------------------------------------------------------
  // extract the state of the selected interface fsm and fifo 
  reg  [`MWC_CNTL_PTR_DATA_RCV_STATE_RANGE        ]     mwc_cntl_extract_desc_state  ; // state flop
  reg                                                   pipe_valid                   ;
  reg  [`MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_RANGE ]     pipe_data                    ;

  always @(*)
    begin
      case ({enable_rdp_fsm, enable_mcntl_fsm}) // synopsys parallel_case
        2'b10:
          begin
            mwc_cntl_extract_desc_state  =  intf_fsm[0].mwc_cntl_extract_desc_state ;
            pipe_valid                   =  input_intf_fifo[0].pipe_valid           ;
            pipe_data                    =  input_intf_fifo[0].pipe_data            ;
          end
        2'b01:
          begin
            mwc_cntl_extract_desc_state  =  intf_fsm[1].mwc_cntl_extract_desc_state ;
            pipe_valid                   =  input_intf_fifo[1].pipe_valid           ;
            pipe_data                    =  input_intf_fifo[1].pipe_data            ;
          end
        default
          begin
            mwc_cntl_extract_desc_state  =  'd0    ;  // set to invalid state if neither input fsm is selected
            pipe_valid                   =  'd0    ;
            pipe_data                    =  'd0    ;
          end
      endcase
    end
  //----------------------------------------------------------------------------------------------------
  

  always @(posedge clk)
    begin
      start_valid         <=  ( reset_poweron                          ) ? 1'b0        :
                              (~enable_rdp_fsm && ~enable_mcntl_fsm    ) ? 1'b0        :
                              ( sdpr_cfg_valid                         ) ? 1'b1        :
                                                                           start_valid ;

      start_channel       <=  ( sdpr_cfg_valid ) ? sdpr_cfg_addr [`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ] :
                                                   start_channel                                       ;

      start_address       <=  ( sdpr_cfg_valid ) ? sdpr_cfg_addr :
                                                   start_address ;

      start_accessOrder   <=  ( sdpr_cfg_valid ) ? sdpr_cfg_accessOrder :
                                                   start_accessOrder    ;


      for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
        begin
          held_mask [chan] <= ( reset_poweron ) ? 64'd0           :
                                                  held_mask [chan];
        end
    end


  // We will initially form a channel/bank/page/line addresses based on the start address from the sdp request controller.
  // An overall address is formed based on the chan/bank/page/line fields and the access order.
  // As we grab each work, we will use this address to index into the holding register.
  // The address will be incremented for each word
  always @(*)
    begin

      case (mwc_cntl_extract_desc_state)

        `MWC_CNTL_PTR_DATA_RCV_PROCESS_DATA :
          begin
            // reorder fields for incrementing
            if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
              begin
                inc_address_e1 =  {start_address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ] , 
                                   start_address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ] , 
                                   start_address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ] , 
                                   start_address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ] , 
                                   2'b00                                              };
              end
            else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
              begin
                inc_address_e1 =  {start_address[`MGR_DRAM_ADDRESS_PAGE_FIELD_RANGE ] , 
                                   start_address[`MGR_DRAM_ADDRESS_BANK_FIELD_RANGE ] , 
                                   start_address[`MGR_DRAM_ADDRESS_WORD_FIELD_RANGE ] , 
                                   start_address[`MGR_DRAM_ADDRESS_CHAN_FIELD_RANGE ] , 
                                   2'b00                                              };
              end
          end

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :
          begin
            // increment if pipe is valid
            //inc_address_e1 =  inc_address + ({`MGR_DRAM_LOCAL_ADDRESS_WIDTH {pipe_valid}} & (`MGR_DRAM_LOCAL_ADDRESS_WIDTH 'd4)) ;
            inc_address_e1 =  (~held_addr_miscompare && pipe_valid )  ? inc_address + 'd4 :
                                                                        inc_address       ;
          end

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER :
          begin
            //inc_address_e1 =  inc_address + (`MGR_DRAM_LOCAL_ADDRESS_WIDTH 'd4) ;
            inc_address_e1 =  (~held_addr_miscompare )  ? inc_address + 'd4 :
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
      if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_WCBP) 
        begin
          inc_channel_e1 =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_CHAN_FIELD_RANGE ]  ;
          inc_bank_e1    =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_BANK_FIELD_RANGE ]  ;
          inc_page_e1    =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_PAGE_FIELD_RANGE ]  ;
          inc_word_e1    =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_WORD_FIELD_RANGE ]  ;
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
            inc_line_e1  =  inc_address_e1[`MGR_DRAM_WCBP_ORDER_LINE_FIELD_RANGE ]  ;
          `endif
        end
      else if (strm_accessOrder == PY_WU_INST_ORDER_TYPE_CWBP) 
        begin
          inc_channel_e1 =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_CHAN_FIELD_RANGE ]  ;
          inc_bank_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_BANK_FIELD_RANGE ]  ;
          inc_page_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_PAGE_FIELD_RANGE ]  ;
          inc_word_e1    =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_WORD_FIELD_RANGE ]  ;
          `ifdef  MGR_DRAM_REQUEST_LT_PAGE
            inc_line_e1  =  inc_address_e1[`MGR_DRAM_CWBP_ORDER_LINE_FIELD_RANGE ]  ;
          `endif
        end
    end // always @ (*)

  // Register the stream address and individual fields
  always @(posedge clk)
    begin
      inc_address     <=  inc_address_e1 ;
      inc_channel     <=  inc_channel_e1 ;
      inc_bank        <=  inc_bank_e1    ;
      inc_page        <=  inc_page_e1    ;
      inc_word        <=  inc_word_e1    ;
      `ifdef  MGR_DRAM_REQUEST_LT_PAGE
        inc_line      <=  inc_line_e1    ;
      `endif
    end 


  always @(posedge clk)
    begin

      case (mwc_cntl_extract_desc_state)

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :
          begin
            flush_from_lower  <=  1'b1 ;
          end

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER :
          begin
            flush_from_lower  <=  1'b0 ;
          end

        default:
          begin
            flush_from_lower  <=  flush_from_lower  ;
          end

      endcase
    end

  always @(posedge clk)
    begin

      case (mwc_cntl_extract_desc_state)

        // FIXME: Code assumes two channels
        `MWC_CNTL_PTR_DATA_RCV_FLUSH_1ST_HOLDING_REG :
          begin
            mwc__mmc__data_valid     <=  held_valid [ channel_released_first  ] ;
            mwc__mmc__data_channel   <=  channel_released_first                 ;
            mwc__mmc__data           <=  held_data  [ channel_released_first  ] ;
            mwc__mmc__data_mask      <=  held_mask  [ channel_released_first  ] ;
          end

        `MWC_CNTL_PTR_DATA_RCV_FLUSH_2ND_HOLDING_REG :
          begin
            mwc__mmc__data_valid     <=  held_valid [ channel_released_second ] ;
            mwc__mmc__data_channel   <=  channel_released_second                ;
            mwc__mmc__data           <=  held_data  [ channel_released_second ] ;
            mwc__mmc__data_mask      <=  held_mask  [ channel_released_second ] ;
          end

        default:
          begin
            mwc__mmc__data_valid  <=  1'b0     ;
          end

      endcase
    end

  // If neither channel holds a valid entry, then set the first released
  always @(posedge clk)
    begin

      case (mwc_cntl_extract_desc_state)

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :
          begin
            channel_released_first   <=  ( ~|held_valid ) ?  inc_channel : channel_released_first  ;
            channel_released_second  <=  ( ~|held_valid ) ? ~inc_channel : channel_released_second ;
          end

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER :
          begin
            channel_released_first   <=  ( ~|held_valid ) ?  inc_channel : channel_released_first  ;
            channel_released_second  <=  ( ~|held_valid ) ? ~inc_channel : channel_released_second ;
          end

        default:
          begin
            channel_released_first   <=  channel_released_first   ;
            channel_released_second  <=  channel_released_second  ;
          end

      endcase
    end
  always @(posedge clk)
    begin

      case (mwc_cntl_extract_desc_state)

        // Remember, neither input fsm is selected when they are in their WAIT state

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER :
          begin
            case (held_addr_miscompare)   // synopsys parallel_case
              1'b0:
                begin
                  held_valid   [inc_channel]              <=  1'b1  ;
                  held_bank    [inc_channel]              <=  (~held_valid [inc_channel]) ? inc_bank    : held_bank    [inc_channel] ;
                  held_page    [inc_channel]              <=  (~held_valid [inc_channel]) ? inc_page    : held_page    [inc_channel] ;
                  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                    held_line  [inc_channel]              <=  (~held_valid [inc_channel]) ? inc_line    : held_line    [inc_channel] ;
                  `endif
                  held_data    [inc_channel][inc_word]    <=  pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE ] ;
                  held_mask    [inc_channel][inc_word]    <=  1'b1             ;
                end
            endcase
          end

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER :
          begin
            case (held_addr_miscompare)   // synopsys parallel_case
              1'b0:
                begin
                  held_valid   [inc_channel]              <=  1'b1  ;
                  held_bank    [inc_channel]              <=  (~held_valid [inc_channel]) ? inc_bank    : held_bank    [inc_channel] ;
                  held_page    [inc_channel]              <=  (~held_valid [inc_channel]) ? inc_page    : held_page    [inc_channel] ;
                  `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                    held_line  [inc_channel]              <=  (~held_valid [inc_channel]) ? inc_line    : held_line    [inc_channel] ;
                  `endif
                  held_data    [inc_channel][inc_word]    <=  pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE ] ;
                  held_mask    [inc_channel][inc_word]    <=  1'b1             ;
                end
            endcase
          end

        `MWC_CNTL_PTR_DATA_RCV_FLUSH_1ST_HOLDING_REG :
          begin
            held_valid [ channel_released_first  ] <=  1'b0  ;
            held_mask  [ channel_released_first  ] <=   'd0  ;
          end
        `MWC_CNTL_PTR_DATA_RCV_FLUSH_2ND_HOLDING_REG :
          begin
            held_valid [ channel_released_second ] <=  1'b0  ;
            held_mask  [ channel_released_second ] <=   'd0  ;
          end

        // Remember, neither input fsm is selected when they are in their WAIT state
        default:
          begin
            for (int chan=0; chan<`MGR_DRAM_NUM_CHANNELS ; chan++)
              begin
                held_valid [chan]  <=  ( reset_poweron ) ? 1'b0 : held_valid [chan]   ;
                held_mask  [chan]  <=  ( reset_poweron ) ?  'd0 : held_mask  [chan]   ;
              end
          end

      endcase
    end

  always @(*)
    begin

      case (mwc_cntl_extract_desc_state)

        `MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER : 
          begin
            held_addr_miscompare   =  |held_valid & ((held_bank[inc_channel] != inc_bank) | 
                                                     (held_page[inc_channel] != inc_page) |                                                
                                                     `ifdef  MGR_DRAM_REQUEST_LT_PAGE
                                                       (held_line  [inc_channel] != inc_line));
                                                     `else
                                                       1'b0 );
                                                     `endif
          end

        default:
          begin
          end

      endcase
    end
//------------------------------------------------------------------------------------------------------------------------------------------------------

endmodule
