`ifndef _mrc_cntl_vh
`define _mrc_cntl_vh

/*****************************************************************

    File name   : mrc_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


  
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FSM's
//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// WU Instruction Decode FSM

`define MRC_CNTL_DESC_WAIT                         12'b0000_0000_0001
                                                 
`define MRC_CNTL_DESC_EXTRACT                      12'b0000_0000_0010
`define MRC_CNTL_DESC_READ                         12'b0000_0000_0100
`define MRC_CNTL_DESC_MEM_OUT_VALID                12'b0000_0000_1000
`define MRC_CNTL_DESC_START_STREAM                 12'b0000_0001_0000
`define MRC_CNTL_DESC_CONS_FIELD                   12'b0000_0010_0000
`define MRC_CNTL_DESC_JUMP_FIELD                   12'b0000_0100_0000
`define MRC_CNTL_DESC_GENERATE_ANOTHER_MEM_REQ     12'b0000_1000_0000
`define MRC_CNTL_DESC_WAIT_STREAM_COMPLETE         12'b0001_0000_0000

`define MRC_CNTL_DESC_COMPLETE                     12'b0100_0000_0000
                                                  
`define MRC_CNTL_DESC_ERR                          12'b1000_0000_0000

`define MRC_CNTL_DESC_STATE_WIDTH         12
`define MRC_CNTL_DESC_STATE_MSB           `MRC_CNTL_DESC_STATE_WIDTH-1
`define MRC_CNTL_DESC_STATE_LSB           0
`define MRC_CNTL_DESC_STATE_SIZE          (`MRC_CNTL_DESC_STATE_MSB - `MRC_CNTL_DESC_STATE_LSB +1)
`define MRC_CNTL_DESC_STATE_RANGE          `MRC_CNTL_DESC_STATE_MSB : `MRC_CNTL_DESC_STATE_LSB

//--------------------------------------------------------
// Stream Data FSM

`define MRC_CNTL_STRM_WAIT                    8'b0000_0001

`define MRC_CNTL_STRM_LOAD_FIRST_CONS_COUNT   8'b0000_0010
`define MRC_CNTL_STRM_LOAD_JUMP_VALUE         8'b0000_0100
`define MRC_CNTL_STRM_COUNT_CONS              8'b0000_1000
`define MRC_CNTL_STRM_JUMP_VALUE_WAIT         8'b0001_0000

`define MRC_CNTL_STRM_COMPLETE                8'b0100_0000

`define MRC_CNTL_STRM_ERR                     8'b1000_0000

`define MRC_CNTL_STRM_STATE_WIDTH         8
`define MRC_CNTL_STRM_STATE_MSB           `MRC_CNTL_STRM_STATE_WIDTH-1
`define MRC_CNTL_STRM_STATE_LSB           0
`define MRC_CNTL_STRM_STATE_SIZE          (`MRC_CNTL_STRM_STATE_MSB - `MRC_CNTL_STRM_STATE_LSB +1)
`define MRC_CNTL_STRM_STATE_RANGE          `MRC_CNTL_STRM_STATE_MSB : `MRC_CNTL_STRM_STATE_LSB

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// end of FSM's
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// Number of active lanes is 1..32, so need 6 bits
  
`define MRC_CNTL_NUM_LANES_WIDTH               (`CLOG2(`PE_NUM_OF_EXEC_LANES))+1
`define MRC_CNTL_NUM_LANES_MSB           `MRC_CNTL_NUM_LANES_WIDTH-1
`define MRC_CNTL_NUM_LANES_LSB            0
`define MRC_CNTL_NUM_LANES_SIZE           (`MRC_CNTL_NUM_LANES_MSB - `MRC_CNTL_NUM_LANES_LSB +1)
`define MRC_CNTL_NUM_LANES_RANGE           `MRC_CNTL_NUM_LANES_MSB : `MRC_CNTL_NUM_LANES_LSB
//------------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FIFO's
//------------------------------------------------------------------------------------------------------------

`define MRC_CNTL_DESC_FIFO_DEPTH          16
`define MRC_CNTL_DESC_FIFO_THRESHOLD      4

//--------------------------------------------------------
//--------------------------------------------------------
// From MMC

`define MRC_CNTL_FROM_MMC_FIFO_DEPTH          64
`define MRC_CNTL_FROM_MMC_FIFO_DEPTH_MSB      (`MRC_CNTL_FROM_MMC_FIFO_DEPTH) -1
`define MRC_CNTL_FROM_MMC_FIFO_DEPTH_LSB      0
`define MRC_CNTL_FROM_MMC_FIFO_DEPTH_SIZE     (`MRC_CNTL_FROM_MMC_FIFO_DEPTH_MSB - `MRC_CNTL_FROM_MMC_FIFO_DEPTH_LSB +1)
`define MRC_CNTL_FROM_MMC_FIFO_DEPTH_RANGE     `MRC_CNTL_FROM_MMC_FIFO_DEPTH_MSB : `MRC_CNTL_FROM_MMC_FIFO_DEPTH_LSB
`define MRC_CNTL_FROM_MMC_FIFO_MSB            ((`CLOG2(`MRC_CNTL_FROM_MMC_FIFO_DEPTH)) -1)
`define MRC_CNTL_FROM_MMC_FIFO_LSB            0
`define MRC_CNTL_FROM_MMC_FIFO_SIZE           (`MRC_CNTL_FROM_MMC_FIFO_MSB - `MRC_CNTL_FROM_MMC_FIFO_LSB +1)
`define MRC_CNTL_FROM_MMC_FIFO_RANGE           `MRC_CNTL_FROM_MMC_FIFO_MSB : `MRC_CNTL_FROM_MMC_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_WIDTH    (`MGR_MMC_TO_MRC_INTF_NUM_WORDS*`MGR_EXEC_LANE_WIDTH)
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_MSB      `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_WIDTH-1
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_LSB      0
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_SIZE     (`MRC_CNTL_FROM_MMC_AGGREGATE_DATA_MSB - `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_LSB +1)
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_RANGE     `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_MSB : `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_LSB

`define MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_MSB      (`MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB+`COMMON_STD_INTF_CNTL_WIDTH) -1
`define MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB      `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_MSB+1
`define MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_SIZE     (`MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_MSB - `MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB +1)
`define MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_RANGE     `MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_MSB : `MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB

`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH \
                                                   +`MRC_CNTL_FROM_MMC_AGGREGATE_DATA_WIDTH

`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_MSB            `MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_WIDTH -1
`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_LSB            0
`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_SIZE           (`MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_MSB - `MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_LSB +1)
`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_RANGE           `MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_MSB : `MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MRC_CNTL_FROM_MMC_FIFO_ALMOST_FULL_THRESHOLD 4


//--------------------------------------------------------
//--------------------------------------------------------
// Desc fsm to From MMC

`define MRC_CNTL_TO_STRM_FIFO_DEPTH         16
`define MRC_CNTL_TO_STRM_FIFO_DEPTH_MSB      (`MRC_CNTL_TO_STRM_FIFO_DEPTH) -1
`define MRC_CNTL_TO_STRM_FIFO_DEPTH_LSB      0
`define MRC_CNTL_TO_STRM_FIFO_DEPTH_SIZE     (`MRC_CNTL_TO_STRM_FIFO_DEPTH_MSB - `MRC_CNTL_TO_STRM_FIFO_DEPTH_LSB +1)
`define MRC_CNTL_TO_STRM_FIFO_DEPTH_RANGE     `MRC_CNTL_TO_STRM_FIFO_DEPTH_MSB : `MRC_CNTL_TO_STRM_FIFO_DEPTH_LSB
`define MRC_CNTL_TO_STRM_FIFO_MSB            ((`CLOG2(`MRC_CNTL_TO_STRM_FIFO_DEPTH)) -1)
`define MRC_CNTL_TO_STRM_FIFO_LSB            0
`define MRC_CNTL_TO_STRM_FIFO_SIZE           (`MRC_CNTL_TO_STRM_FIFO_MSB - `MRC_CNTL_TO_STRM_FIFO_LSB +1)
`define MRC_CNTL_TO_STRM_FIFO_RANGE           `MRC_CNTL_TO_STRM_FIFO_MSB : `MRC_CNTL_TO_STRM_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MRC_CNTL_TO_STRM_AGGREGATE_DATA_WIDTH    `MGR_INST_CONS_JUMP_WIDTH
`define MRC_CNTL_TO_STRM_AGGREGATE_DATA_MSB      `MRC_CNTL_TO_STRM_AGGREGATE_DATA_WIDTH-1
`define MRC_CNTL_TO_STRM_AGGREGATE_DATA_LSB      0
`define MRC_CNTL_TO_STRM_AGGREGATE_DATA_SIZE     (`MRC_CNTL_TO_STRM_AGGREGATE_DATA_MSB - `MRC_CNTL_TO_STRM_AGGREGATE_DATA_LSB +1)
`define MRC_CNTL_TO_STRM_AGGREGATE_DATA_RANGE     `MRC_CNTL_TO_STRM_AGGREGATE_DATA_MSB : `MRC_CNTL_TO_STRM_AGGREGATE_DATA_LSB

`define MRC_CNTL_TO_STRM_AGGREGATE_CNTL_MSB      (`MRC_CNTL_TO_STRM_AGGREGATE_CNTL_LSB+`COMMON_STD_INTF_CNTL_WIDTH) -1
`define MRC_CNTL_TO_STRM_AGGREGATE_CNTL_LSB      `MRC_CNTL_TO_STRM_AGGREGATE_DATA_MSB+1
`define MRC_CNTL_TO_STRM_AGGREGATE_CNTL_SIZE     (`MRC_CNTL_TO_STRM_AGGREGATE_CNTL_MSB - `MRC_CNTL_TO_STRM_AGGREGATE_CNTL_LSB +1)
`define MRC_CNTL_TO_STRM_AGGREGATE_CNTL_RANGE     `MRC_CNTL_TO_STRM_AGGREGATE_CNTL_MSB : `MRC_CNTL_TO_STRM_AGGREGATE_CNTL_LSB

`define MRC_CNTL_TO_STRM_AGGREGATE_FIFO_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH \
                                                   +`MRC_CNTL_TO_STRM_AGGREGATE_DATA_WIDTH

`define MRC_CNTL_TO_STRM_AGGREGATE_FIFO_MSB            `MRC_CNTL_TO_STRM_AGGREGATE_FIFO_WIDTH -1
`define MRC_CNTL_TO_STRM_AGGREGATE_FIFO_LSB            0
`define MRC_CNTL_TO_STRM_AGGREGATE_FIFO_SIZE           (`MRC_CNTL_TO_STRM_AGGREGATE_FIFO_MSB - `MRC_CNTL_TO_STRM_AGGREGATE_FIFO_LSB +1)
`define MRC_CNTL_TO_STRM_AGGREGATE_FIFO_RANGE           `MRC_CNTL_TO_STRM_AGGREGATE_FIFO_MSB : `MRC_CNTL_TO_STRM_AGGREGATE_FIFO_LSB

`define MRC_CNTL_TO_STRM_FIFO_ALMOST_FULL_THRESHOLD 4
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------

`endif
