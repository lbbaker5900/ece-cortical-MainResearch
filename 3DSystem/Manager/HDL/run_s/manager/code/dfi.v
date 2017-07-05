/*********************************************************************************************

    File name   : dfi.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

    Description : This module is the top module for DFI. it interface with diram_port_model
                  and mmc

    Revision    :
            ID     : 1
            Date   : 13 Apr 2016
            Name   : lbbaker@ncsu.edu
            Description : Not really DFI, crude concersion of SDR to/from DSDR

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
            output  reg                                            dfi__mmc__init_done                                                               ,
            output  reg   [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      dfi__mmc__data       [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ]  ,
            output  reg                                            dfi__mmc__valid      [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire                                           mmc__dfi__cs         [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire                                           mmc__dfi__cmd0       [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire                                           mmc__dfi__cmd1       [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire  [ `MGR_EXEC_LANE_WIDTH_RANGE      ]      mmc__dfi__data       [`MGR_DRAM_NUM_CHANNELS ] [`MGR_MMC_TO_MRC_INTF_NUM_WORDS ]  ,
            input   wire  [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]      mmc__dfi__bank       [`MGR_DRAM_NUM_CHANNELS ]                                    ,
            input   wire  [ `MGR_DRAM_PHY_ADDRESS_RANGE     ]      mmc__dfi__addr       [`MGR_DRAM_NUM_CHANNELS ]                                    ,

  
            //--------------------------------------------------------------------------------
            // DFI Interface to DRAM
            //
            output   reg   clk_diram_ck                                        ,
            output   reg   dfi__phy__cs                                        , 
            output   reg   dfi__phy__cmd1                                      , 
            output   reg   dfi__phy__cmd0                                      ,
            output   reg   [ `MGR_DRAM_INTF_RANGE            ]  dfi__phy__data ,
            output   reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__bank ,
            output   reg   [ `MGR_DRAM_PHY_ADDRESS_RANGE     ]  dfi__phy__addr ,

            //--------------------------------------------------------------------------------
            // DFI Interface from DRAM
            //
            input   wire  clk_diram_cq                                         ,
            input   wire  phy__dfi__valid                                      ,
            input   wire  [ `MGR_DRAM_INTF_RANGE            ]   phy__dfi__data ,

            //--------------------------------------------------------------------------------
            // Clocks for SDR/DDR
            input  wire  clk_diram                  ,
            input  wire  clk_diram2x                ,

            //-------------------------------
            // General
            //

            input   wire                           clk             ,
            input   wire                           reset_poweron  

                    );
    

  reg  init_done    ;
  reg  init_done_d1 ;

  always @(posedge clk)
    begin
      init_done   <=   ~reset_poweron ;  // FIXME
    end

  always @(posedge clk)
    begin
      dfi__mmc__init_done     <=  init_done ;
      init_done_d1            <=  init_done ;
    end
         
  assign   clk_diram_ck       = clk               ;

  //----------------------------------------------------------------------------------------------------
  // Wires and registers
  reg                                        dfi__phy__cs_e1     ; 
  reg                                        dfi__phy__cmd1_e1   ; 
  reg                                        dfi__phy__cmd0_e1   ;
  reg   [ `MGR_DRAM_INTF_RANGE            ]  dfi__phy__data_e1   ;
  reg   [ `MGR_DRAM_BANK_ADDRESS_RANGE    ]  dfi__phy__bank_e1   ;
  reg   [ `MGR_DRAM_PHY_ADDRESS_RANGE     ]  dfi__phy__addr_e1   ;

  //----------------------------------------------------------------------------------------------------
  // Control page and cache clock phases
  reg dram_cmd_mode ;
  reg dram_chan_mode;

  always@(posedge clk_diram2x)
  begin
    if(reset_poweron || !init_done_d1)
       dram_chan_mode <= 1'b1;
    else
       dram_chan_mode <= ~dram_chan_mode; 
  end
  always@(posedge clk_diram)
  begin
    if(reset_poweron || !init_done_d1)
       dram_cmd_mode <= 1'b1;
    else
       dram_cmd_mode <= ~dram_cmd_mode; 
  end
  
  genvar word ;
  generate
    for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS; word=word+1) 
      begin: write_data
        always @(posedge clk_diram2x)
          begin
            // FIXME : 32
            dfi__phy__data_e1 [(word+1)*32-1 : word*32]  <= ( ~clk_diram_ck ) ? mmc__dfi__data [0][word] :
                                                                                mmc__dfi__data [1][word] ;

            dfi__phy__data    [(word+1)*32-1 : word*32]  <= dfi__phy__data_e1 ;
          end
      end
  endgenerate

  always @(posedge clk_diram2x)
    begin
      case (dram_chan_mode)  // synopsys parallel_case
        1'b1 :
          begin
            dfi__phy__cs_e1       <=   mmc__dfi__cs   [0] ;
            dfi__phy__cmd1_e1     <=   mmc__dfi__cmd1 [0] ;
            dfi__phy__cmd0_e1     <=   mmc__dfi__cmd0 [0] ;
            dfi__phy__bank_e1     <=   mmc__dfi__bank [0] ;
            dfi__phy__addr_e1     <=   mmc__dfi__addr [0] ;
          end
         
        1'b0 :
          begin
            dfi__phy__cs_e1       <=   mmc__dfi__cs   [1] ;
            dfi__phy__cmd1_e1     <=   mmc__dfi__cmd1 [1] ;
            dfi__phy__cmd0_e1     <=   mmc__dfi__cmd0 [1] ;
            dfi__phy__bank_e1     <=   mmc__dfi__bank [1] ;
            dfi__phy__addr_e1     <=   mmc__dfi__addr [1] ;
          end

      endcase

    end
  always @(posedge clk_diram2x)
    begin
      dfi__phy__cs      <=  dfi__phy__cs_e1   ;
      dfi__phy__cmd1    <=  dfi__phy__cmd1_e1 ;
      dfi__phy__cmd0    <=  dfi__phy__cmd0_e1 ;
      dfi__phy__bank    <=  dfi__phy__bank_e1 ;
      dfi__phy__addr    <=  dfi__phy__addr_e1 ;
    end

wire #0.05 clk_diram2x_dly = clk_diram2x;

reg                                    dfi__mmc__valid_e1 ;
reg     [`MGR_DRAM_INTF_RANGE ]        dfi__mmc__data_e1  ;    
reg                                    dfi__mmc__valid_e2 ;
reg     [`MGR_DRAM_INTF_RANGE ]        dfi__mmc__data_e2  ;    
reg                                    dfi__mmc__valid_e3 [`MGR_DRAM_NUM_CHANNELS ] ;
reg     [`MGR_DRAM_INTF_RANGE ]        dfi__mmc__data_e3  [`MGR_DRAM_NUM_CHANNELS ] ;    

always @(posedge clk_diram2x_dly)
  begin
    dfi__mmc__data_e1   <=  phy__dfi__data      ;
    dfi__mmc__valid_e1  <=  phy__dfi__valid     ;
  end
always @(negedge clk_diram2x)
  begin
    dfi__mmc__data_e2   <=  dfi__mmc__data_e1   ;
    dfi__mmc__valid_e2  <=  dfi__mmc__valid_e1  ;
  end

  always @(posedge clk_diram2x)
    begin
      dfi__mmc__valid_e3 [0]  <= (~clk_diram ) ? dfi__mmc__valid_e2     :
                                                 dfi__mmc__valid_e3 [0] ;
      dfi__mmc__valid_e3 [1]  <= ( clk_diram ) ? dfi__mmc__valid_e2     :
                                                 dfi__mmc__valid_e3 [1] ;

      dfi__mmc__data_e3  [0]  <= (~clk_diram ) ? dfi__mmc__data_e2      :
                                                 dfi__mmc__data_e3  [0] ;
      dfi__mmc__data_e3  [1]  <= ( clk_diram ) ? dfi__mmc__data_e2      :
                                                 dfi__mmc__data_e3  [1] ;
    end

  generate
    for (word=0; word<`MGR_MMC_TO_MRC_INTF_NUM_WORDS; word=word+1) 
      begin: return_data
        always @(posedge clk)
          begin
            // FIXME : 32
            dfi__mmc__data [0][word] <= dfi__mmc__data_e3 [0][(word+1)*32-1 : word*32] ;
            dfi__mmc__data [1][word] <= dfi__mmc__data_e3 [1][(word+1)*32-1 : word*32] ;
          end
      end
  endgenerate


endmodule
