/*********************************************************************************************

    File name   : mgr_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

    Description : This will be the module that communicates with the host.
                  It may well be a small CPU or maybe SIMD.
                  For now, it takes the NoC packets and passes them directly to the MWC

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


module mgr_cntl (  

            //-------------------------------------------------------------------------------------------------
            // Configuration
            //
            output  reg  [`MGR_WU_ADDRESS_RANGE    ]     mcntl__wuf__start_addr  ,  // first WU address
            output  reg                                  mcntl__wuf__enable      ,
            output  reg                                  xxx__wuf__stall         ,




            //-------------------------------------------------------------------------------------------------
            // from NoC 
            // - control
            input  wire                                              noc__mcntl__cp_valid      , 
            input  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     noc__mcntl__cp_cntl       , 
            input  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     noc__mcntl__cp_type       , 
            input  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     noc__mcntl__cp_ptype      , 
            input  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     noc__mcntl__cp_data       , 
            input  wire                                              noc__mcntl__cp_pvalid     , 
            input  wire [`MGR_MGR_ID_RANGE                     ]     noc__mcntl__cp_mgrId      , 
            output reg                                               mcntl__noc__cp_ready      , 
            // - data
            input  wire                                              noc__mcntl__dp_valid      , 
            input  wire [`COMMON_STD_INTF_CNTL_RANGE           ]     noc__mcntl__dp_cntl       , 
            input  wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     noc__mcntl__dp_type       , 
            input  wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     noc__mcntl__dp_ptype      , 
            input  wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     noc__mcntl__dp_data       , 
            input  wire                                              noc__mcntl__dp_pvalid     , 
            input  wire [`MGR_MGR_ID_RANGE                     ]     noc__mcntl__dp_mgrId      , 
            output reg                                               mcntl__noc__dp_ready      , 

  
            //-------------------------------------------------------------------------------------------------
            // to MWC
            output reg                                               mcntl__mwc__valid      , 
            output reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__mwc__cntl       , 
            output reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__mwc__type       , 
            output reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__mwc__ptype      , 
            output reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__mwc__data       , 
            output reg                                               mcntl__mwc__pvalid     , 
            output reg  [`MGR_MGR_ID_RANGE                     ]     mcntl__mwc__mgrId      , 
            input  wire                                              mwc__mcntl__ready      , 

  

            //-------------------------------------------------------------------------------------------------
            // General
            //
            output reg                            mcntl__mwc__flush ,  // release any held write data. Likely used at end of a sequence

            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId   ,
                                                                    
            input  wire                           clk               ,
            input  wire                           reset_poweron  
                        );

    //----------------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------------
    // Registers and Wires
 

    //-------------------------------------------------------------------------------------------------
    // from NoC 
    reg                                               noc__mcntl__cp_valid_d1      ; 
    reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     noc__mcntl__cp_cntl_d1       ; 
    reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     noc__mcntl__cp_type_d1       ; 
    reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     noc__mcntl__cp_ptype_d1      ; 
    reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     noc__mcntl__cp_data_d1       ; 
    reg                                               noc__mcntl__cp_pvalid_d1     ; 
    reg  [`MGR_MGR_ID_RANGE                     ]     noc__mcntl__cp_mgrId_d1      ; 
    wire                                              mcntl__noc__cp_ready_e1      ; 

    reg                                               noc__mcntl__dp_valid_d1      ; 
    reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     noc__mcntl__dp_cntl_d1       ; 
    reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     noc__mcntl__dp_type_d1       ; 
    reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     noc__mcntl__dp_ptype_d1      ; 
    reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     noc__mcntl__dp_data_d1       ; 
    reg                                               noc__mcntl__dp_pvalid_d1     ; 
    reg  [`MGR_MGR_ID_RANGE                     ]     noc__mcntl__dp_mgrId_d1      ; 
    reg                                               mcntl__noc__dp_ready_e1      ; 

  
    //-------------------------------------------------------------------------------------------------
    // to MWC
    reg                                               mcntl__mwc__valid_e1      ; 
    reg  [`COMMON_STD_INTF_CNTL_RANGE           ]     mcntl__mwc__cntl_e1       ; 
    reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]     mcntl__mwc__type_e1       ; 
    reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]     mcntl__mwc__ptype_e1      ; 
    reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]     mcntl__mwc__data_e1       ; 
    reg                                               mcntl__mwc__pvalid_e1     ; 
    reg  [`MGR_MGR_ID_RANGE                     ]     mcntl__mwc__mgrId_e1      ; 
    reg                                               mwc__mcntl__ready_d1      ; 

  


    //--------------------------------------------------
    // from NoC
    
    always @(posedge clk) 
      begin
        noc__mcntl__cp_valid_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_valid      ;
        noc__mcntl__cp_cntl_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_cntl       ;
        noc__mcntl__cp_type_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_type       ;
        noc__mcntl__cp_ptype_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_ptype      ;
        noc__mcntl__cp_data_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_data       ;
        noc__mcntl__cp_pvalid_d1   <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_pvalid     ;
        noc__mcntl__cp_mgrId_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__cp_mgrId      ;
        mcntl__noc__cp_ready       <=   ( reset_poweron   ) ? 'd0  : mcntl__noc__cp_ready_e1   ;

        noc__mcntl__dp_valid_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_valid      ;
        noc__mcntl__dp_cntl_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_cntl       ;
        noc__mcntl__dp_type_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_type       ;
        noc__mcntl__dp_ptype_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_ptype      ;
        noc__mcntl__dp_data_d1     <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_data       ;
        noc__mcntl__dp_pvalid_d1   <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_pvalid     ;
        noc__mcntl__dp_mgrId_d1    <=   ( reset_poweron   ) ? 'd0  : noc__mcntl__dp_mgrId      ;
        mcntl__noc__dp_ready       <=   ( reset_poweron   ) ? 'd0  : mcntl__noc__dp_ready_e1   ;
      end

    //--------------------------------------------------
    // to MWC
    
    always @(posedge clk) 
      begin
        mcntl__mwc__valid        <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__valid_e1    ;
        mcntl__mwc__cntl         <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__cntl_e1     ;
        mcntl__mwc__type         <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__type_e1     ;
        mcntl__mwc__ptype        <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__ptype_e1    ;
        mcntl__mwc__data         <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__data_e1     ;
        mcntl__mwc__pvalid       <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__pvalid_e1   ;
        mcntl__mwc__mgrId        <=   ( reset_poweron   ) ? 'd0  : mcntl__mwc__mgrId_e1    ;
        mwc__mcntl__ready_d1     <=   ( reset_poweron   ) ? 'd0  : mwc__mcntl__ready       ;
      end

    //--------------------------------------------------
    // 
    //  FIXME - pass thru
    //
    always @(*)
      begin
        mcntl__mwc__valid_e1     =   noc__mcntl__dp_valid_d1    ;
        mcntl__mwc__cntl_e1      =   noc__mcntl__dp_cntl_d1     ;
        mcntl__mwc__type_e1      =   noc__mcntl__dp_type_d1     ;
        mcntl__mwc__ptype_e1     =   noc__mcntl__dp_ptype_d1    ;
        mcntl__mwc__data_e1      =   noc__mcntl__dp_data_d1     ;
        mcntl__mwc__pvalid_e1    =   noc__mcntl__dp_pvalid_d1   ;
        mcntl__mwc__mgrId_e1     =   noc__mcntl__dp_mgrId_d1    ;
        mcntl__noc__dp_ready_e1  =   mwc__mcntl__ready_d1       ;
      end


    // FIXME
    assign  mcntl__noc__cp_ready_e1   = 1'b1 ;

    //-------------------------------------------------------------------------------------------------
    //-------------------------------------------------------------------------------------------------
    // Configuration
    //  - FIXME temporary assignments
    
    always @(posedge clk)
      begin
        mcntl__wuf__start_addr  <= 24'd0   ;
        mcntl__wuf__enable      <= 1'b1    ;
        xxx__wuf__stall         <= 1'b0    ;
        mcntl__mwc__flush       <= 1'b0    ;
      end

    
    //--------------------------------------------------



endmodule
