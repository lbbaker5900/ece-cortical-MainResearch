//---------------------------------------------------------------------------
// Copyright 2016 Tezzaron Semiconductor
//    All Rights Reserved
//    This file includes the confidential information of Tezzaron Semiconductor.
//    The receiver of this confidential information shall not disclose it
//    to any third party and shall protect its confidentiality.
//---------------------------------------------------------------------------
//   Warranty:
//   Use all material in this file at your own risk. 
//   Tezzaron Semiconductor makes no claims about any material
//   contained in this file.
//---------------------------------------------------------------------------
// Rev 0.91
//---------------------------------------------------------------------------
localparam C_CLK_DLY_IN       = 175ps;     // clock delay for sampling DDR inputs
localparam C_CLK_DLY_OUT      = 175ps;     // clock delay for DRAM output
localparam TRN_STRT_CLKS      = 128;       // Training measurements start after clocks
localparam MAXIMUM_CLK_PERIOD = 5000ps;    // Maximum value of clk_time_period
localparam MAXIMUM_NET_SKEW   = 1000ps;    // Maximum difference between longest and shortest net delay

// Important to ensure that simulation starts with correct INIT value
// for proper clocking of both channels. Change this only if you MUST need.
`ifdef INVERT_CHNL_CLK
localparam INIT_PORT_CLK = 1;
`else
localparam INIT_PORT_CLK = 0;
`endif

typedef enum {diram4_cs_n = 0,
              diram4_cmd[0:1],
              diram4_addr[0:11],
              diram4_baddr[0:4],
              diram4_d[0:31]} INP_NET;

//==============================================================================
//                                  THE END
//==============================================================================
