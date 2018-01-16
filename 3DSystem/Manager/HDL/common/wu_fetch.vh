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


`define WUF_CNTL_STATE_WIDTH         6
`define WUF_CNTL_STATE_MSB           `WUF_CNTL_STATE_WIDTH-1
`define WUF_CNTL_STATE_LSB           0
`define WUF_CNTL_STATE_SIZE          (`WUF_CNTL_STATE_MSB - `WUF_CNTL_STATE_LSB +1)
`define WUF_CNTL_STATE_RANGE          `WUF_CNTL_STATE_MSB : `WUF_CNTL_STATE_LSB

`define WUF_CNTL_WAIT                6'b00_0001

`define WUF_CNTL_START               6'b00_0010
`define WUF_CNTL_INC_PC              6'b00_0100
`define WUF_CNTL_STALL               6'b00_1000
`define WUF_CNTL_SYS_STALL           6'b01_0000

`define WUF_CNTL_ERR                 6'b10_0000
  
//------------------------------------------------------------------------------------------------------------
// DEBUG

`define WUF_DEBUG_MAX_PC            'h55

// end DEBUG
//------------------------------------------------------------------------------------------------------------




`endif
