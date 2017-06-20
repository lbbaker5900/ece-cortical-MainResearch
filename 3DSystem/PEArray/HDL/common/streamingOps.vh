`ifndef _streamingOps_vh
`define _streamingOps_vh

/*****************************************************************

    File name   : streamingOps.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

*****************************************************************/



//------------------------------------------------
// STREAMING_OP Overall Control FSM states
//------------------------------------------------

`define STREAMING_OP_WAIT           7'b0000001
`define STREAMING_OP_CLEAR_OP       7'b0000010
`define STREAMING_OP_INTERNAL_OP    7'b0000100
`define STREAMING_OP_EXTERNAL_OP    7'b0001000
`define STREAMING_OP_INT_OP_START   7'b0010000
`define STREAMING_OP_EXT_OP_START   7'b0100000
`define STREAMING_OP_COMPLETE       7'b1000000


//------------------------------------------------
// STREAMING_OP Overall Controll FSM state width
//------------------------------------------------
`define STREAMING_OP_STATE_MSB            6
`define STREAMING_OP_STATE_LSB            0
`define STREAMING_OP_STATE_SIZE           (`STREAMING_OP_STATE_MSB - `STREAMING_OP_STATE_LSB +1)
`define STREAMING_OP_STATE_RANGE           `STREAMING_OP_STATE_MSB : `STREAMING_OP_STATE_LSB


//------------------------------------------------
// STREAMING_OP_DATA_WIDTH width
//------------------------------------------------
`define STREAMING_OP_DATA_WIDTH               `STREAMING_OP_CNTL_DATA_WIDTH
`define STREAMING_OP_DATA_MSB                 `STREAMING_OP_CNTL_DATA_WIDTH-1
`define STREAMING_OP_DATA_LSB                  0
`define STREAMING_OP_DATA_SIZE                 (`STREAMING_OP_DATA_MSB - `STREAMING_OP_DATA_LSB +1)
`define STREAMING_OP_DATA_RANGE                 `STREAMING_OP_DATA_MSB : `STREAMING_OP_DATA_LSB

//------------------------------------------------
// STREAMING_OP FIFO
//------------------------------------------------

`define STREAMING_OP_INPUT_FIFO_DEPTH          10
`define STREAMING_OP_INPUT_FIFO_DEPTH_MSB      (`STREAMING_OP_INPUT_FIFO_DEPTH) -1
`define STREAMING_OP_INPUT_FIFO_DEPTH_LSB      0
`define STREAMING_OP_INPUT_FIFO_DEPTH_SIZE     (`STREAMING_OP_INPUT_FIFO_DEPTH_MSB - `STREAMING_OP_INPUT_FIFO_DEPTH_LSB +1)
`define STREAMING_OP_INPUT_FIFO_DEPTH_RANGE     `STREAMING_OP_INPUT_FIFO_DEPTH_MSB : `STREAMING_OP_INPUT_FIFO_DEPTH_LSB
`define STREAMING_OP_INPUT_FIFO_MSB            ((`CLOG2(`STREAMING_OP_INPUT_FIFO_DEPTH)) -1)
`define STREAMING_OP_INPUT_FIFO_LSB            0
`define STREAMING_OP_INPUT_FIFO_SIZE           (`STREAMING_OP_INPUT_FIFO_MSB - `STREAMING_OP_INPUT_FIFO_LSB +1)
`define STREAMING_OP_INPUT_FIFO_RANGE           `STREAMING_OP_INPUT_FIFO_MSB : `STREAMING_OP_INPUT_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_WIDTH    `STREAMING_OP_DATA_WIDTH 
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_MSB      `STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_WIDTH-1
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_LSB      0
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_SIZE     (`STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_MSB - `STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_LSB +1)
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_RANGE     `STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_MSB : `STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_LSB

`define STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_WIDTH      `COMMON_STD_INTF_CNTL_WIDTH
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_MSB      (`STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_LSB+`STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_WIDTH) -1
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_LSB      `STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_MSB+1
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_SIZE     (`STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_MSB - `STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_LSB +1)
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_RANGE     `STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_MSB : `STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_LSB

`define STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_WIDTH     `STREAMING_OP_INPUT_FIFO_AGGREGATE_CNTL_WIDTH  \
                                                        +`STREAMING_OP_INPUT_FIFO_AGGREGATE_DATA_WIDTH

`define STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_MSB            `STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_WIDTH -1
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_LSB            0
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_SIZE           (`STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_MSB - `STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_LSB +1)
`define STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_RANGE           `STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_MSB : `STREAMING_OP_INPUT_FIFO_AGGREGATE_FIFO_LSB

// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define STREAMING_OP_INPUT_FIFO_FIFO_ALMOST_FULL_THRESHOLD 6
//------------------------------------------------
// STREAMING_OP Output
//------------------------------------------------
`define STREAMING_OP_RESULT_WIDTH        `STREAMING_OP_CNTL_DATA_WIDTH
`define STREAMING_OP_RESULT_MSB           `STREAMING_OP_RESULT_WIDTH-1
`define STREAMING_OP_RESULT_LSB            0
`define STREAMING_OP_RESULT_SIZE           (`STREAMING_OP_RESULT_MSB - `STREAMING_OP_RESULT_LSB +1)
`define STREAMING_OP_RESULT_RANGE           `STREAMING_OP_RESULT_MSB : `STREAMING_OP_RESULT_LSB

//------------------------------------------------
// STREAMING_OP variable widths
//------------------------------------------------

`define STREAMING_OP_BSUM_MSB           15
`define STREAMING_OP_BSUM_LSB            0
`define STREAMING_OP_BSUM_SIZE           (`STREAMING_OP_BSUM_MSB - `STREAMING_OP_BSUM_LSB +1)
`define STREAMING_OP_BSUM_RANGE           `STREAMING_OP_BSUM_MSB : `STREAMING_OP_BSUM_LSB

`define STREAMING_OP_FP_MSB           31
`define STREAMING_OP_FP_LSB            0
`define STREAMING_OP_FP_SIZE           (`STREAMING_OP_FP_MSB - `STREAMING_OP_FP_LSB +1)
`define STREAMING_OP_FP_RANGE           `STREAMING_OP_FP_MSB : `STREAMING_OP_FP_LSB

`define STREAMING_OP_INDEX_MSB           19
`define STREAMING_OP_INDEX_LSB            0
`define STREAMING_OP_INDEX_SIZE           (`STREAMING_OP_INDEX_MSB - `STREAMING_OP_INDEX_LSB +1)
`define STREAMING_OP_INDEX_RANGE           `STREAMING_OP_INDEX_MSB : `STREAMING_OP_INDEX_LSB


//------------------------------------------------
// STREAMING_OP Result FSM states
//------------------------------------------------

`define STREAMING_OP_RESULT_WAIT           6'b000001
`define STREAMING_OP_RESULT_ENABLE         6'b000010


//------------------------------------------------
// STREAMING_OP Result FSM state width
//------------------------------------------------
`define STREAMING_OP_RESULT_STATE_MSB            5
`define STREAMING_OP_RESULT_STATE_LSB            0
`define STREAMING_OP_RESULT_STATE_SIZE           (`STREAMING_OP_RESULT_STATE_MSB - `STREAMING_OP_RESULT_STATE_LSB +1)
`define STREAMING_OP_RESULT_STATE_RANGE           `STREAMING_OP_RESULT_STATE_MSB : `STREAMING_OP_RESULT_STATE_LSB

//------------------------------------------------
// STREAMING_OP Operation Decode
//------------------------------------------------
`define STREAMING_OP_OPERATION_TO_DMA            `STREAMING_OP_CNTL_OPERATION_TO_MEMORY
`define STREAMING_OP_OPERATION_TO_REG            `STREAMING_OP_CNTL_OPERATION_TO_REG   
`define STREAMING_OP_OPERATION_FROM_DMA          `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY
`define STREAMING_OP_OPERATION_FROM_EXT          `STREAMING_OP_CNTL_OPERATION_FROM_EXT   

`define STREAMING_OP_TO_MSB            0
`define STREAMING_OP_TO_LSB            0
`define STREAMING_OP_TO_SIZE           (`STREAMING_OP_TO_MSB - `STREAMING_OP_TO_LSB +1)
`define STREAMING_OP_TO_RANGE           `STREAMING_OP_TO_MSB : `STREAMING_OP_TO_LSB
`define STREAMING_OP_FROM_MSB            0
`define STREAMING_OP_FROM_LSB            0
`define STREAMING_OP_FROM_SIZE           (`STREAMING_OP_FROM_MSB - `STREAMING_OP_FROM_LSB +1)
`define STREAMING_OP_FROM_RANGE           `STREAMING_OP_FROM_MSB : `STREAMING_OP_FROM_LSB


//------------------------------------------------
// STREAMING_OP Streaming Op specific control FSM's
//------------------------------------------------

//------------------------------------------------
// STREAMING_OP_FP_CMP Compare Control FSM states
//------------------------------------------------

`define STREAMING_OP_FP_CMP_STATE_WAIT                6'b000001
`define STREAMING_OP_FP_CMP_STATE_COMPARING_MIN       6'b000010
`define STREAMING_OP_FP_CMP_STATE_COMPARING_MAX       6'b000100
`define STREAMING_OP_FP_CMP_STATE_LOADING_THRESHOLD   6'b001000
`define STREAMING_OP_FP_CMP_STATE_FINDING_FIRST_GT    6'b010000
`define STREAMING_OP_FP_CMP_STATE_COMPLETE            6'b100000


//------------------------------------------------
// STREAMING_OP_FP_CMP Compare Control FSM state width
//------------------------------------------------
`define STREAMING_OP_FP_CMP_STATE_STATE_MSB            5
`define STREAMING_OP_FP_CMP_STATE_STATE_LSB            0
`define STREAMING_OP_FP_CMP_STATE_STATE_SIZE           (`STREAMING_OP_FP_CMP_STATE_STATE_MSB - `STREAMING_OP_FP_CMP_STATE_STATE_LSB +1)
`define STREAMING_OP_FP_CMP_STATE_STATE_RANGE           `STREAMING_OP_FP_CMP_STATE_STATE_MSB : `STREAMING_OP_FP_CMP_STATE_STATE_LSB



//--------------------------------------------------------------------------------------------------
//------------------------------------------------

//------------------------------------------------------------------------------------------------------------
`endif
