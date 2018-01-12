`ifndef _wu_decode_vh
`define _wu_decode_vh

/*****************************************************************

    File name   : wu_decode.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


`define WU_DEC_INITIAL_TAG          `MGR_INITIAL_TAG 

//------------------------------------------------
// FIFO's
//------------------------------------------------

`define WU_DEC_INSTR_FIFO_DEPTH          16
`define WU_DEC_INSTR_FIFO_THRESHOLD      8

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

//--------------------------------------------------------
// Number of active lanes is 1..32, so need 6 bits
  
`define WU_DEC_NUM_LANES_WIDTH               (`CLOG2(`PE_NUM_OF_EXEC_LANES))+1
`define WU_DEC_NUM_LANES_MSB           `WU_DEC_NUM_LANES_WIDTH-1
`define WU_DEC_NUM_LANES_LSB            0
`define WU_DEC_NUM_LANES_SIZE           (`WU_DEC_NUM_LANES_MSB - `WU_DEC_NUM_LANES_LSB +1)
`define WU_DEC_NUM_LANES_RANGE           `WU_DEC_NUM_LANES_MSB : `WU_DEC_NUM_LANES_LSB
//------------------------------------------------------------------------------------------------------------


`endif
