`ifndef _wu_fetch_vh
`define _wu_fetch_vh

/*****************************************************************

    File name   : wu_fetch.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//--------------------------------------------------------


`define WUF_CNTL_STATE_WIDTH         5
`define WUF_CNTL_STATE_MSB           `WUF_CNTL_STATE_WIDTH-1
`define WUF_CNTL_STATE_LSB           0
`define WUF_CNTL_STATE_SIZE          (`WUF_CNTL_STATE_MSB - `WUF_CNTL_STATE_LSB +1)
`define WUF_CNTL_STATE_RANGE          `WUF_CNTL_STATE_MSB : `WUF_CNTL_STATE_LSB

`define WUF_CNTL_WAIT                5'b0_0001

`define WUF_CNTL_START               5'b0_0010
`define WUF_CNTL_INC_PC              5'b0_0100
`define WUF_CNTL_STALL               5'b0_1000

`define WUF_CNTL_ERR                 5'b1_0000
  
//------------------------------------------------------------------------------------------------------------
// DEBUG

`define WUF_DEBUG_MAX_PC            'h55

// end DEBUG
//------------------------------------------------------------------------------------------------------------




`endif
