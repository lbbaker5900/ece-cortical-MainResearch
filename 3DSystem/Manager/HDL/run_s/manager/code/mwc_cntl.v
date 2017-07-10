/*********************************************************************************************

    File name   : mwc_cntl.v
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
`include "mgr_noc_cntl.vh"
`include "mrc_cntl.vh"
`include "mwc_cntl.vh"
`include "python_typedef.vh"


module mwc_cntl (  

            //-------------------------------
            // from NoC 
            input  wire                                              noc__mwc__dp_valid      , 
            input  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     noc__mwc__dp_cntl       , 
            output reg                                               mwc__noc__dp_ready      , 
            input  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     noc__mwc__dp_type       , 
            input  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     noc__mwc__dp_ptype      , 
            input  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     noc__mwc__dp_data       , 
            input  wire                                              noc__mwc__dp_pvalid     , 
            input  wire [`MGR_MGR_ID_RANGE                     ]     noc__mwc__dp_mgrId      , 

            //-------------------------------
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
      mwc__noc__dp_ready  <= 1'b1 ;
    end



endmodule
