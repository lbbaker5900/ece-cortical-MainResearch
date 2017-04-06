`ifndef _wu_decode_vh
`define _wu_decode_vh

/*****************************************************************

    File name   : wu_decode.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// FIFO's
//------------------------------------------------

`define WU_DEC_INSTR_FIFO_DEPTH          16
`define WU_DEC_INSTR_FIFO_THRESHOLD      2

//--------------------------------------------------------
  
//--------------------------------------------------------
// WU Instruction Decode

`define WU_DEC_INSTR_DECODE_WAIT                8'b0000_0001

`define WU_DEC_INSTR_DECODE_OP                  8'b0000_0010
`define WU_DEC_INSTR_DECODE_MR                  8'b0000_0100
`define WU_DEC_INSTR_DECODE_MW                  8'b0000_1000
`define WU_DEC_INSTR_DECODE_INSTR_RUNNING       8'b0001_0000

`define WU_DEC_INSTR_DECODE_INSTR_COMPLETE      8'b0010_0000
`define WU_DEC_INSTR_DECODE_INITIATED_INSTR      8'b0100_0000

`define WU_DEC_INSTR_DECODE_ERR                 8'b1000_0000

`define WU_DEC_INSTR_DECODE_STATE_WIDTH         8
`define WU_DEC_INSTR_DECODE_STATE_MSB           `WU_DEC_INSTR_DECODE_STATE_WIDTH-1
`define WU_DEC_INSTR_DECODE_STATE_LSB           0
`define WU_DEC_INSTR_DECODE_STATE_SIZE          (`WU_DEC_INSTR_DECODE_STATE_MSB - `WU_DEC_INSTR_DECODE_STATE_LSB +1)
`define WU_DEC_INSTR_DECODE_STATE_RANGE          `WU_DEC_INSTR_DECODE_STATE_MSB : `WU_DEC_INSTR_DECODE_STATE_LSB

//------------------------------------------------------------------------------------------------------------


`endif
