`ifndef _mrc_cntl_vh
`define _mrc_cntl_vh

/*****************************************************************

    File name   : mrc_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// FIFO's
//------------------------------------------------

`define MRC_CNTL_DESC_FIFO_DEPTH          16
`define MRC_CNTL_DESC_FIFO_THRESHOLD      2

//--------------------------------------------------------
  
//--------------------------------------------------------
// WU Instruction Decode

`define MRC_CNTL_DESC_WAIT               8'b0000_0001

`define MRC_CNTL_DESC_EXTRACT            8'b0000_0010
`define MRC_CNTL_DESC_READ               8'b0000_0100
`define MRC_CNTL_DESC_MEM_OUT_VALID      8'b0000_1000
`define MRC_CNTL_CONS_JUMP_MEM_OUT_VALID 8'b0001_0000
//`define MRC_CNTL_DESC_READ               8'b0010_0000

`define MRC_CNTL_COMPLETE                8'b0100_0000

`define MRC_CNTL_ERR                     8'b1000_0000

`define MRC_CNTL_STATE_WIDTH         8
`define MRC_CNTL_STATE_MSB           `MRC_CNTL_STATE_WIDTH-1
`define MRC_CNTL_STATE_LSB           0
`define MRC_CNTL_STATE_SIZE          (`MRC_CNTL_STATE_MSB - `MRC_CNTL_STATE_LSB +1)
`define MRC_CNTL_STATE_RANGE          `MRC_CNTL_STATE_MSB : `MRC_CNTL_STATE_LSB

//--------------------------------------------------------
// Number of active lanes is 1..32, so need 6 bits
  
`define MRC_CNTL_NUM_LANES_WIDTH               (`CLOG2(`PE_NUM_OF_EXEC_LANES))+1
`define MRC_CNTL_NUM_LANES_MSB           `MRC_CNTL_NUM_LANES_WIDTH-1
`define MRC_CNTL_NUM_LANES_LSB            0
`define MRC_CNTL_NUM_LANES_SIZE           (`MRC_CNTL_NUM_LANES_MSB - `MRC_CNTL_NUM_LANES_LSB +1)
`define MRC_CNTL_NUM_LANES_RANGE           `MRC_CNTL_NUM_LANES_MSB : `MRC_CNTL_NUM_LANES_LSB
//------------------------------------------------------------------------------------------------------------


`endif
