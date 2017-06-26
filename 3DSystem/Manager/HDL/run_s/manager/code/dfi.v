/*********************************************************************************************

    File name   : dfi.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

    Description : This module is the top module for DFI. it interface with diram_port_model
                  and sch

    Revision    :
            ID     : 1
            Date   : 13 Apr 2016
            Name   : lbbaker@ncsu.edu
            Description : Not really DFI, only converts SDR to DSDR

      Note: leveraged from https://github.ncsu.edu/ECE-Memory-Controller-IS/ece-diram4-memory-controller/blob/master/HDL/run_s/dfi

*********************************************************************************************/

`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "main_mem_cntl.vh"
`include "dfi.vh"


module dfi( 
            //--------------------------------------------------------------------------------
            // DFI Interface from MMC
            // - provide per channel signals
            // - DFI will handle SDR->DDR conversion
            //
            output  wire                                           dfi__mmc__init_done                                                               ,
            output  wire  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      dfi__mmc__chan_data  [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ]  ,
            output  wire                                           dfi__mmc__valid      [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire                                           mmc__dfi__cs         [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire                                           mmc__dfi__cmd0       [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire                                           mmc__dfi__cmd1       [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__dfi__data       [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ]  ,
            input   wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mmc__dfi__bank       [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire  [ `MGR_DRAM_ADDRESS_RANGE         ]      mmc__dfi__addr       [`MGR_DRAM_NUM_CHANNELS ]                                    ,

  
            //--------------------------------------------------------------------------------
            // DFI Interface to DRAM
            //
            output   wire  clk_diram_ck                                        ,
            output   wire  dfi__phy__cmd1                                      , 
            output   wire  dfi__phy__cmd0                                      ,
            output   wire  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]  dfi__phy__data ,
            output   wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__addr ,
            output   wire  [ `MGR_DRAM_ADDRESS_RANGE         ]  dfi__phy__bank ,

            input   wire  clk_diram_cq             ,
            input   wire  phy__dfi__data_valid     ,
            input   wire  phy__dfi__data           ,

            // Clocks for SDR/DDR
            input  wire  clk_diram                  ,
            input  wire  clk_diram2x                ,

            //-------------------------------
            // General
            //
            input   wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input   wire                           clk             ,
            input   wire                           reset_poweron  

                    );
    
parameter DIRAM_WIDTH           = 32 ;
parameter burst_length_dsdr     = 2  ;
parameter PORT_NO               = 5  ;
parameter OCP_WIDTH             = DIRAM_WIDTH * burst_length_dsdr; // interface at dfi is 2x interface at dram. SDR -> DDR

wire            init_done   ;

wire                                       mmc__dfi__cs      ;
wire                                       mmc__dfi__cmd1    ;
wire                                       mmc__dfi__cmd0    ;
wire   [`DFI_TOP_DIRAM4_ADDRESS_RANGE   ]  mmc__dfi__addr    ; //12 bit page select and 4 bit block select both use this signal exclusively
wire   [`DFI_TOP_DIRAM4_BANK_RANGE      ]  mmc__dfi__bank    ; // selection of bank
wire    [OCP_WIDTH*PORT_NO-1:0]            mmc__dfi__wrdata       ;    

reg     [OCP_WIDTH*PORT_NO-1:0]            dfi__mmc__rddata       ;    
reg                                        dfi__mmc__rddata_valid ;    

wire                                       clk_diram_ck      ; // diram input clock
wire                                       dfi__phy__cmd1    ;
wire                                       dfi__phy__cmd0    ;
wire  [`DFI_TOP_DIRAM4_ADDRESS_RANGE ]     dfi__phy__addr    ;
wire  [`DFI_TOP_DIRAM4_BANK_RANGE    ]     dfi__phy__bank    ;
                                          
wire    [DIRAM_WIDTH*PORT_NO-1:0]          dfi__phy__wrdata  ;

wire                                       clk_diram_cq             ; // diram output clock
wire                                       phy__dfi__rddata_valid   ; //qvld
wire    [DIRAM_WIDTH*PORT_NO-1:0]          phy__dfi__rddata         ;



assign   init_done = ~reset_poweron ;  // FIXME
         
assign   clk_diram_ck       = clk               ;
assign   dfi__phy__cs       = mmc__dfi__cs      ;
assign   dfi__phy__cmd1     = mmc__dfi__cmd1    ;
assign   dfi__phy__cmd0     = mmc__dfi__cmd0    ;
assign   dfi__phy__addr     = mmc__dfi__addr    ;
assign   dfi__phy__bank     = mmc__dfi__bank    ;

assign   dfi__phy__data     = ( ~clk_diram_ck ) ? mmc__dfi__data[OCP_WIDTH*PORT_NO/2-1:0                ] :
                                                  mmc__dfi__data[OCP_WIDTH*PORT_NO-1:OCP_WIDTH*PORT_NO/2] ;

wire #5 clk_diram_cq_dly = clk_diram_cq;
reg                                        dfi__mmc__rddata_valid_e1 ;
reg                                        dfi__mmc__rddata_valid_e2 ;
reg     [OCP_WIDTH*PORT_NO-1:0]            dfi__mmc__rddata_e1       ;    
reg     [OCP_WIDTH*PORT_NO-1:0]            dfi__mmc__rddata_e2       ;    
always @(posedge clk_diram_cq_dly)
  begin
    dfi__mmc__data_e1[OCP_WIDTH*PORT_NO/2-1:0           ] <=  phy__dfi__data      ;
    dfi__mmc__data_e2                                     <=  dfi__mmc__data_e1   ;
    dfi__mmc__valid_e2                                    <=  dfi__mmc__valid_e1  ;
  end
always @(negedge clk_diram_cq_dly)
  begin
    dfi__mmc__data_valid_e1                                    <=  phy__dfi__data_valid     ;
    dfi__mmc__data_e1[OCP_WIDTH*PORT_NO-1:OCP_WIDTH*PORT_NO/2] <=  phy__dfi__data           ;
  end

always @(posedge clk)
  begin
    dfi__mmc__data_valid <= ( reset_poweron ) ? 'b0 : dfi__mmc__data_valid_e2 ;
    dfi__mmc__data       <= ( reset_poweron ) ? 'b0 : dfi__mmc__data_e2       ;
  end


endmodule
