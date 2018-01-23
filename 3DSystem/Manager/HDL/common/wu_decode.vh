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

`define WU_DEC_INSTR_DECODE_WAIT                10'b00_0000_0001

`define WU_DEC_INSTR_DECODE_OP                  10'b00_0000_0010
`define WU_DEC_INSTR_DECODE_MR                  10'b00_0000_0100
`define WU_DEC_INSTR_DECODE_MW                  10'b00_0000_1000
`define WU_DEC_INSTR_DECODE_CFG                 10'b00_0001_0000
`define WU_DEC_INSTR_DECODE_STAT                10'b00_0010_0000
`define WU_DEC_INSTR_DECODE_INSTR_RUNNING       10'b00_0100_0000

`define WU_DEC_INSTR_DECODE_INSTR_COMPLETE      10'b00_1000_0000
`define WU_DEC_INSTR_DECODE_INITIATED_INSTR     10'b01_0000_0000

`define WU_DEC_INSTR_DECODE_ERR                 10'b10_0000_0000

`define WU_DEC_INSTR_DECODE_STATE_WIDTH         10
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


//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// Functions
//------------------------------------------------------------------------------------------------------------

function isExtdTuple (input [`MGR_WU_OPT_VALUE_RANGE] option_type);
  
            isExtdTuple = ((option_type == PY_WU_INST_OPT_TYPE_CFG_SYNC) | (option_type == PY_WU_INST_OPT_TYPE_CFG_DATA) | (option_type == PY_WU_INST_OPT_TYPE_MEMORY)) ;

endfunction                  

function isCfgSync (input [`MGR_WU_OPT_VALUE_RANGE] option_type);
  
            isCfgSync = (option_type == PY_WU_INST_OPT_TYPE_CFG_SYNC);

endfunction                  

function isCfgData (input [`MGR_WU_OPT_VALUE_RANGE] option_type);
  
            isCfgData = (option_type == PY_WU_INST_OPT_TYPE_CFG_DATA);

endfunction                  

function isMemDescPtr (input [`MGR_WU_OPT_VALUE_RANGE] option_type);
  
            isMemDescPtr = (option_type == PY_WU_INST_OPT_TYPE_MEMORY);

endfunction                  

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------



`endif
