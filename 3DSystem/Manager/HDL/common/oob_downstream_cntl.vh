`ifndef _oob_downstream_cntl_vh
`define _oob_downstream_cntl_vh

/*****************************************************************

    File name   : oob_downstream_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// FIFO's
//------------------------------------------------

`define OOB_DOWN_FIFO_DEPTH          16
`define OOB_DOWN_FIFO_THRESHOLD      2

//--------------------------------------------------------
  
//--------------------------------------------------------
// WU Instruction Decode

`define OOB_DOWNSTREAM_CNTL_WAIT                5'b0_0001

`define OOB_DOWNSTREAM_CNTL_START_PKT                5'b0_0010
`define OOB_DOWNSTREAM_CNTL_2ND_CYCLE                5'b0_0100
`define OOB_DOWNSTREAM_CNTL_INITIATED_INSTR     5'b0_1000

`define OOB_DOWNSTREAM_CNTL_ERR                 5'b1_0000

`define OOB_DOWNSTREAM_CNTL_STATE_WIDTH         5
`define OOB_DOWNSTREAM_CNTL_STATE_MSB           `OOB_DOWNSTREAM_CNTL_STATE_WIDTH-1
`define OOB_DOWNSTREAM_CNTL_STATE_LSB           0
`define OOB_DOWNSTREAM_CNTL_STATE_SIZE          (`OOB_DOWNSTREAM_CNTL_STATE_MSB - `OOB_DOWNSTREAM_CNTL_STATE_LSB +1)
`define OOB_DOWNSTREAM_CNTL_STATE_RANGE          `OOB_DOWNSTREAM_CNTL_STATE_MSB : `OOB_DOWNSTREAM_CNTL_STATE_LSB

//------------------------------------------------------------------------------------------------------------


`endif
