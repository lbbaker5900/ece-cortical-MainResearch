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
`include "mgr_cntl.vh"
`include "python_typedef.vh"


module mwc_cntl (  

            //-------------------------------------------------------------------------------------------------
            // from NoC 
            input  wire                                              mcntl__mwc__valid      , 
            input  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__mwc__cntl       , 
            output reg                                               mwc__mcntl__ready      , 
            input  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__mwc__type       , 
            input  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__mwc__ptype      , 
            input  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__mwc__data       , 
            input  wire                                              mcntl__mwc__pvalid     , 
            input  wire [`MGR_MGR_ID_RANGE                     ]     mcntl__mwc__mgrId      , 

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
            output  reg                                                                         mwc__mmc__valid                           ,
            output  reg   [`COMMON_STD_INTF_CNTL_RANGE        ]                                 mwc__mmc__cntl                            ,
            input   wire                                                                        mmc__mwc__ready                           ,

            output  reg   [`MGR_DRAM_CHANNEL_ADDRESS_RANGE    ]                                 mwc__mmc__channel                         ,
            output  reg   [`MGR_DRAM_BANK_ADDRESS_RANGE       ]                                 mwc__mmc__bank                            ,
            output  reg   [`MGR_DRAM_PAGE_ADDRESS_RANGE       ]                                 mwc__mmc__page                            ,
            output  reg   [`MGR_DRAM_WORD_ADDRESS_RANGE       ]                                 mwc__mmc__word                            ,
            output  reg   [`MGR_MMC_TO_MRC_WORD_ADDRESS_RANGE ] [ `MGR_EXEC_LANE_WIDTH_RANGE ]  mwc__mmc__data  [`MGR_DRAM_NUM_CHANNELS ] ,
                                                                                                                    

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

  // FIXME
  always @(posedge clk)
    begin
      mwc__mcntl__ready  <= 1'b1 ;
      mwc__rdp__ready    <= 1'b1 ;
    end

//`define MGR_STORAGE_DESC_MGR_ID_FIELD_RANGE    `MGR_STORAGE_DESC_MGR_ID_FIELD_MSB : `MGR_STORAGE_DESC_MGR_ID_FIELD_LSB


endmodule
