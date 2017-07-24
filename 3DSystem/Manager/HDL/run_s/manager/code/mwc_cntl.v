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
            output  reg                                                                           mwc__mmc__valid                           ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE          ]                                 mwc__mmc__cntl                            ,
            input   wire                                                                          mmc__mwc__ready                           ,
                                                               
            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE      ]                                 mwc__mmc__channel                         ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE         ]                                 mwc__mmc__bank                            ,
            output  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE         ]                                 mwc__mmc__page                            ,
            output  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE         ]                                 mwc__mmc__word                            ,
            output  reg   [`MGR_MMC_TO_MRC_INTF_NUM_WORDS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  mwc__mmc__data  [`MGR_DRAM_NUM_CHANNELS ] ,
                                                                                                                    

            //-------------------------------------------------------------------------------------------------
            // General
            //
            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input  wire                           clk             ,
            input  wire                           reset_poweron  
                        );

    //----------------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------------
    // Registers and Wires
 
    //-------------------------------------------------------------------------------------------------
    // from MCNTL (NoC)
    reg                                               mcntl__mwc__valid_d1      ; 
    reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__mwc__cntl_d1       ; 
    //reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__mwc__type_d1       ; 
    reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__mwc__ptype_d1      ; 
    reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__mwc__data_d1       ; 
    reg                                               mcntl__mwc__pvalid_d1     ; 
    //reg  [`MGR_MGR_ID_RANGE                     ]     mcntl__mwc__mgrId_d1      ; 
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

//`define MGR_STORAGE_DESC_MGR_ID_FIELD_RANGE    `MGR_STORAGE_DESC_MGR_ID_FIELD_MSB : `MGR_STORAGE_DESC_MGR_ID_FIELD_LSB

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // from MCNTL (NoC) FIFO
  // 

  genvar gvi;
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Mcntl_fifo


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
        // Write data fields
        assign write       =  mcntl__mwc__valid_d1 ;
        assign write_data  = {mcntl__mwc__cntl_d1, mcntl__mwc__ptype_d1, mcntl__mwc__pvalid_d1, mcntl__mwc__data_d1};

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


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // from Result Data processor (local) FIFO
  // 

  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Rdp_fifo


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
        // Write data fields
        assign write       =  rdp__mwc__valid_d1 ;
        assign write_data  = {rdp__mwc__cntl_d1, rdp__mwc__ptype_d1, rdp__mwc__pvalid_d1, rdp__mwc__data_d1};

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
            mwc__rdp__ready_e1    = ~almost_full ;
          end

      end
  endgenerate


  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Extract Descriptor FSM
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // - Take storage descriptor option tuples from the fifo and construct starting address and word locations
  // - Give priority to NoC
  //

  // State register 
  reg [`MWC_CNTL_PTR_DATA_RCV_STATE_RANGE ] mwc_cntl_extract_desc_state      ; // state flop
  reg [`MWC_CNTL_PTR_DATA_RCV_STATE_RANGE ] mwc_cntl_extract_desc_state_next ;

  always @(posedge clk)
    begin
      mwc_cntl_extract_desc_state <= ( reset_poweron ) ? `MWC_CNTL_PTR_DATA_RCV_WAIT        :
                                                          mwc_cntl_extract_desc_state_next  ;
    end
  
  reg                                                 contains_storage_ptr    ;  
  reg                                                 contains_data           ;  
  reg   [`MGR_STORAGE_DESC_ADDRESS_RANGE       ]      storage_desc_ptr        ;  // pointer to local storage descriptor although msb's contain manager ID, so remove
  //reg   [`MGR_LOCAL_STORAGE_DESC_ADDRESS_RANGE ]      local_storage_desc_ptr  ;  // remove manager ID msb's
  reg   [`MGR_MGR_ID_RANGE                     ]      storage_desc_ptr_mgr_id ;  // extract manager ID from descriptor
  reg                                                 storage_desc_processing_enable   ;  
  wire                                                storage_desc_processing_complete ;  

  //------------------------------------------------------------------------------------------------------------------------
  // State Transitions
  //
  always @(*)
    begin
      case (mwc_cntl_extract_desc_state)  // synopsys parallel_case)
        
        `MWC_CNTL_PTR_DATA_RCV_WAIT: 
          mwc_cntl_extract_desc_state_next =   ( from_Mcntl_fifo[0].pipe_valid ) ? `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_MCNTL:  
                                               ( from_Rdp_fifo[0].pipe_valid   ) ? `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_RDP:  
                                                                                   `MWC_CNTL_PTR_DATA_RCV_WAIT        ;

        //------------------------------------------------------------------------------------------------------------------------------------------------------
        // RDP
        //
        // Keep reading until we see descriptor cycle
        `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_RDP: 
          mwc_cntl_extract_desc_state_next =   (contains_storage_ptr ) ? `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_RDP :  
                                               (contains_data        ) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_RDP_DATA              :  
                                                                         `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_RDP   ;
  
  
        `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_RDP : 
          mwc_cntl_extract_desc_state_next =   ( storage_desc_ptr_mgr_id == sys__mgr__mgrId ) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_RDP :  // read the descriptor
                                                                                                `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_RDP   ;

        `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_RDP : 
          mwc_cntl_extract_desc_state_next =   (storage_desc_processing_complete  ) ? `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_RDP    :  // read the descriptor
                                                                                      `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_RDP  ;


        `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_RDP : 
          mwc_cntl_extract_desc_state_next =   ( (storage_desc_ptr_mgr_id == sys__mgr__mgrId )) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_RDP         :  // read the descriptor
                                                                                                  `MWC_CNTL_PTR_DATA_RCV_NEXT_RDP_CYCLE                 ;

        `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_RDP : 
          mwc_cntl_extract_desc_state_next =   (storage_desc_processing_complete  ) ? `MWC_CNTL_PTR_DATA_RCV_NEXT_RDP_CYCLE             :  // read the descriptor
                                                                                      `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_RDP  ;

        `MWC_CNTL_PTR_DATA_RCV_NEXT_RDP_CYCLE : 
          mwc_cntl_extract_desc_state_next =    `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_RDP;

        `MWC_CNTL_PTR_DATA_RCV_PROCESS_RDP_DATA : 
          mwc_cntl_extract_desc_state_next =   ( from_Rdp_fifo[0].pipe_valid && from_Rdp_fifo[0].pipe_eom ) ? `MWC_CNTL_PTR_DATA_RCV_WAIT:  
                                               ( from_Rdp_fifo[0].pipe_valid                              ) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_RDP_DATA:  
                                                                                                              `MWC_CNTL_PTR_DATA_RCV_PROCESS_RDP_DATA        ;


        //------------------------------------------------------------------------------------------------------------------------------------------------------
        // MCntl
        //
        // Keep reading until we see descriptor cycle
        `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_MCNTL: 
          mwc_cntl_extract_desc_state_next =   (contains_storage_ptr ) ? `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_MCNTL :  
                                               (contains_data        ) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_MCNTL_DATA              :  
                                                                         `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_MCNTL   ;
  
        `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_MCNTL : 
          mwc_cntl_extract_desc_state_next =   ( storage_desc_ptr_mgr_id == sys__mgr__mgrId ) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_MCNTL :  // read the descriptor
                                                                                                `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_MCNTL   ;

        `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_MCNTL : 
          mwc_cntl_extract_desc_state_next =   (storage_desc_processing_complete  ) ? `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_MCNTL    :  // read the descriptor
                                                                                      `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_MCNTL  ;


        `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_MCNTL : 
          mwc_cntl_extract_desc_state_next =   ( (storage_desc_ptr_mgr_id == sys__mgr__mgrId )) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_MCNTL         :  // read the descriptor
                                                                                                  `MWC_CNTL_PTR_DATA_RCV_NEXT_MCNTL_CYCLE                 ;

        `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_MCNTL : 
          mwc_cntl_extract_desc_state_next =   (storage_desc_processing_complete  ) ? `MWC_CNTL_PTR_DATA_RCV_NEXT_MCNTL_CYCLE             :  // read the descriptor
                                                                                      `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_MCNTL  ;

        `MWC_CNTL_PTR_DATA_RCV_NEXT_MCNTL_CYCLE : 
          mwc_cntl_extract_desc_state_next =    `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_MCNTL;

        `MWC_CNTL_PTR_DATA_RCV_PROCESS_MCNTL_DATA : 
          mwc_cntl_extract_desc_state_next =   ( from_Mcntl_fifo[0].pipe_valid && from_Mcntl_fifo[0].pipe_eom ) ? `MWC_CNTL_PTR_DATA_RCV_WAIT:  
                                               ( from_Mcntl_fifo[0].pipe_valid                              ) ? `MWC_CNTL_PTR_DATA_RCV_PROCESS_MCNTL_DATA:  
                                                                                                              `MWC_CNTL_PTR_DATA_RCV_PROCESS_MCNTL_DATA        ;



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
                                                                                                    
      storage_desc_ptr_mgr_id =  storage_desc_ptr [`MGR_STORAGE_DESC_MGR_ID_FIELD_RANGE  ] ;  // extract manager ID msb's

    end

  always @(*)
    begin
      case (mwc_cntl_extract_desc_state)  // synopsys parallel_case
        
        `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_RDP: 
          begin
            contains_storage_ptr = from_Rdp_fifo[0].pipe_valid & (((from_Rdp_fifo  [0].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_TUPLES ) & (from_Rdp_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) | 
                                                                  ((from_Rdp_fifo  [0].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_TUPLES ) & (from_Rdp_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )));
                                                                                                     
                                                                                       
            
            contains_data        = from_Rdp_fifo[0].pipe_valid & (((from_Rdp_fifo  [0].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_DATA )));
                                                                                                    
            from_Rdp_fifo[0].pipe_read   = ~contains_storage_ptr & ~contains_data ;
          end

        `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_RDP : 
          begin
            storage_desc_ptr     = from_Rdp_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] ;
                                                                                                    
          end
        
        `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_RDP : 
          begin
            storage_desc_ptr     = from_Rdp_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] ;
            storage_desc_processing_enable  = 'd1  ;  
                                                                                                    
          end
        
        `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_RDP : 
          begin
            storage_desc_ptr     = from_Rdp_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ] ;
                                                                                                    
          end
        
        `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_RDP : 
          begin
            storage_desc_ptr     = from_Rdp_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ] ;
            storage_desc_processing_enable  = 'd1  ;  
                                                                                                    
          end
        
        `MWC_CNTL_PTR_DATA_RCV_NEXT_RDP_CYCLE : 
          begin
            from_Rdp_fifo[0].pipe_read   = 1'b1 ;
          end

        `MWC_CNTL_PTR_DATA_RCV_PROCESS_RDP_DATA : 
          begin
            from_Rdp_fifo[0].pipe_read   = from_Rdp_fifo[0].pipe_valid ;
          end
        
        
        `MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_MCNTL: 
          begin
            contains_storage_ptr = from_Mcntl_fifo[0].pipe_valid & (((from_Mcntl_fifo  [0].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_TUPLES ) & (from_Mcntl_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )) | 
                                                                  ((from_Mcntl_fifo  [0].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_TUPLES ) & (from_Mcntl_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE ] == PY_WU_INST_OPT_TYPE_MEMORY )));
                                                                                                     
                                                                                       
            
            contains_data        = from_Mcntl_fifo[0].pipe_valid & (((from_Mcntl_fifo  [0].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_DATA )));
                                                                                                    
            from_Mcntl_fifo[0].pipe_read   = ~contains_storage_ptr & ~contains_data ;
          end

        `MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_MCNTL : 
          begin
            storage_desc_ptr     = from_Mcntl_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] ;
                                                                                                    
          end
        
        `MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_MCNTL : 
          begin
            storage_desc_ptr     = from_Mcntl_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] ;
            storage_desc_processing_enable  = 'd1  ;  
                                                                                                    
          end
        
        `MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_MCNTL : 
          begin
            storage_desc_ptr     = from_Mcntl_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ] ;
                                                                                                    
          end
        
        `MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_MCNTL : 
          begin
            storage_desc_ptr     = from_Mcntl_fifo  [0].pipe_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ] ;
            storage_desc_processing_enable  = 'd1  ;  
                                                                                                    
          end
        
        `MWC_CNTL_PTR_DATA_RCV_NEXT_MCNTL_CYCLE : 
          begin
            from_Mcntl_fifo[0].pipe_read   = 1'b1 ;
          end

        `MWC_CNTL_PTR_DATA_RCV_PROCESS_MCNTL_DATA : 
          begin
            from_Mcntl_fifo[0].pipe_read   = from_Mcntl_fifo[0].pipe_valid ;
          end
        
        default:
          begin
            contains_storage_ptr            = 'd0  ;
            storage_desc_ptr_mgr_id         = 'd0  ;
            storage_desc_processing_enable  = 'd0  ;  
            from_Rdp_fifo[0].pipe_read         = 'd0  ;
            from_Mcntl_fifo[0].pipe_read       = 'd0  ;
          end


      endcase // case (mrc_cntl_extract_desc_state)
    end // always @ (*)

  //----------------------------------------------------------------------------------------------------
  // Registered Decodes
  //
  //
  // end of State Decodes
  //------------------------------------------------------------------------------------------------------------------------



  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Storage Descriptor Memory Request Generator
  // - Contains the storage descriptor and consequtive/jump memory
  // - generates memory requests and passes starting address and consequtive/jump values to the storage descriptor stream controller
  // - sends the channel/bank/page/line address associated with each request to the main memory controller

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

            .sdpr__sdps__cfg_valid                        (                                            ),
            .sdpr__sdps__cfg_addr                         (                                            ),
            .sdpr__sdps__cfg_accessOrder                  (                                            ),
            .sdps__sdpr__cfg_ready                        ( 1'b1                                       ),
            .sdps__sdpr__complete                         ( 1'b1                                       ),
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
 


endmodule
