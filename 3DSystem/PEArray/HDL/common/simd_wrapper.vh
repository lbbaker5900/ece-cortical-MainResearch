`ifndef _simd_wrapper_vh
`define _simd_wrapper_vh

/*****************************************************************

    File name   : simd_wrapper.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// PE_ARRAY
//------------------------------------------------

`define SIMD_WRAP_PE_ID_MSB                  `PE_PE_ID_MSB
`define SIMD_WRAP_PE_ID_LSB                  0
`define SIMD_WRAP_PE_ID_SIZE                 (`SIMD_WRAP_PE_ID_MSB - `SIMD_WRAP_PE_ID_LSB +1)
`define SIMD_WRAP_PE_ID_RANGE                 `SIMD_WRAP_PE_ID_MSB : `SIMD_WRAP_PE_ID_LSB

`define SIMD_WRAP_CHIPLET_ADDRESS_WIDTH      `PE_CHIPLET_ADDRESS_WIDTH
`define SIMD_WRAP_CHIPLET_ADDRESS_MSB        `SIMD_WRAP_CHIPLET_ADDRESS_WIDTH-1
`define SIMD_WRAP_CHIPLET_ADDRESS_LSB        0
`define SIMD_WRAP_CHIPLET_ADDRESS_SIZE       (`SIMD_WRAP_CHIPLET_ADDRESS_MSB - `SIMD_WRAP_CHIPLET_ADDRESS_LSB +1)
`define SIMD_WRAP_CHIPLET_ADDRESS_RANGE       `SIMD_WRAP_CHIPLET_ADDRESS_MSB : `SIMD_WRAP_CHIPLET_ADDRESS_LSB



//--------------------------------------------------------
// SIMD wrapper operations

`define SIMD_WRAP_OPERATION_NUM_OF_OPS              16

`define SIMD_WRAP_OPERATION_VEC_WIDTH     `SIMD_WRAP_OPERATION_NUM_OF_OPS 
`define SIMD_WRAP_OPERATION_VEC_MSB       `SIMD_WRAP_OPERATION_VEC_WIDTH-1
`define SIMD_WRAP_OPERATION_VEC_LSB        0
`define SIMD_WRAP_OPERATION_VEC_RANGE     `SIMD_WRAP_OPERATION_VEC_MSB : `SIMD_WRAP_OPERATION_VEC_LSB


`define SIMD_WRAP_OPERATION_WIDTH                  (`CLOG2(`SIMD_WRAP_OPERATION_NUM_OF_OPS  ))
`define SIMD_WRAP_OPERATION_NOP                     0
`define SIMD_WRAP_OPERATION_RELU                    1
`define SIMD_WRAP_OPERATION_SUM_SAVE_LOCAL          2  // sum all and save to indexed local reg
`define SIMD_WRAP_OPERATION_SUM_SAVE_COMMON         3  // sum all and save to common 
`define SIMD_WRAP_OPERATION_EXP                     4
`define SIMD_WRAP_OPERATION_DIV                     5  // divide each with common reg
`define SIMD_WRAP_OPERATION_RECIP                   6  // reciprocal of common back to common
`define SIMD_WRAP_OPERATION_CMP                     7  // compare with local reg
`define SIMD_WRAP_OPERATION_SEND                    8  // send output regs to upstream
`define SIMD_WRAP_OPERATION_SEND_NULL               9  // send null response with tag
`define SIMD_WRAP_OPERATION_CLR_LOCAL_REGS         10  // clear output regs
`define SIMD_WRAP_OPERATION_CLR_COMMON_REGS        11  // clear common regs
`define SIMD_WRAP_OPERATION_CLR_IDX                12  // clear index
`define SIMD_WRAP_OPERATION_INC_IDX                13  // increment index

`define SIMD_WRAP_OPERATION_TYPE_WIDTH            (`SIMD_WRAP_OPERATION_WIDTH) 
`define SIMD_WRAP_OPERATION_TYPE_MSB              `SIMD_WRAP_OPERATION_TYPE_WIDTH-1
`define SIMD_WRAP_OPERATION_TYPE_LSB              0
`define SIMD_WRAP_OPERATION_TYPE_SIZE             (`SIMD_WRAP_OPERATION_TYPE_MSB - `SIMD_WRAP_OPERATION_TYPE_LSB +1)
`define SIMD_WRAP_OPERATION_TYPE_RANGE            `SIMD_WRAP_OPERATION_TYPE_MSB : `SIMD_WRAP_OPERATION_TYPE_LSB

`define SIMD_WRAP_OPERATION_NUM_OF_STAGES          4

`define SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_WIDTH    ((`CLOG2(`SIMD_WRAP_OPERATION_NUM_OF_STAGES))+1)
`define SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_MSB      `SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_WIDTH-1
`define SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_LSB      0
`define SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_SIZE     (`SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_MSB - `SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_LSB +1)
`define SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_RANGE    `SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_MSB : `SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_LSB

`define SIMD_WRAP_SFU_COUNT_WIDTH                     (`CLOG2(`SIMD_WRAP_OPERATION_NUM_OF_STAGES ))
`define SIMD_WRAP_SFU_COUNT_MSB                       `SIMD_WRAP_SFU_COUNT_WIDTH-1
`define SIMD_WRAP_SFU_COUNT_LSB                       0
`define SIMD_WRAP_SFU_COUNT_SIZE                      (`SIMD_WRAP_SFU_COUNT_MSB - `SIMD_WRAP_SFU_COUNT_LSB +1)
`define SIMD_WRAP_SFU_COUNT_RANGE                      `SIMD_WRAP_SFU_COUNT_MSB : `SIMD_WRAP_SFU_COUNT_LSB


`define SIMD_WRAP_OPERATION_STAGES_TYPE_WIDTH            (`SIMD_WRAP_OPERATION_NUM_OF_STAGES*`SIMD_WRAP_OPERATION_WIDTH)
`define SIMD_WRAP_OPERATION_STAGES_TYPE_MSB              `SIMD_WRAP_OPERATION_STAGES_TYPE_WIDTH-1
`define SIMD_WRAP_OPERATION_STAGES_TYPE_LSB              0
`define SIMD_WRAP_OPERATION_STAGES_TYPE_SIZE             (`SIMD_WRAP_OPERATION_STAGES_TYPE_MSB - `SIMD_WRAP_OPERATION_STAGES_TYPE_LSB +1)
`define SIMD_WRAP_OPERATION_STAGES_TYPE_RANGE            `SIMD_WRAP_OPERATION_STAGES_TYPE_MSB : `SIMD_WRAP_OPERATION_STAGES_TYPE_LSB
/*
`define SIMD_WRAP_OPERATION_STAGES_VALID_WIDTH          `SIMD_WRAP_OPERATION_NUM_OF_STAGES            
`define SIMD_WRAP_OPERATION_STAGES_VALID_MSB              `SIMD_WRAP_OPERATION_STAGES_VALID_WIDTH-1
`define SIMD_WRAP_OPERATION_STAGES_VALID_LSB              0
`define SIMD_WRAP_OPERATION_STAGES_VALID_SIZE             (`SIMD_WRAP_OPERATION_STAGES_VALID_MSB - `SIMD_WRAP_OPERATION_STAGES_VALID_LSB +1)
`define SIMD_WRAP_OPERATION_STAGES_VALID_RANGE            `SIMD_WRAP_OPERATION_STAGES_VALID_MSB : `SIMD_WRAP_OPERATION_STAGES_VALID_LSB
*/

//--------------------------------------------------------
// SIMD wrapper operations multicycle
`define SIMD_WRAP_OPERATION_EXP_MULTICYCLE              8   // match with synthesys
`define SIMD_WRAP_OPERATION_DIV_MULTICYCLE              16  // divide adds registers
`define SIMD_WRAP_OPERATION_CMP_MULTICYCLE              8   // match with synthesys

//--------------------------------------------------------
// Transfer from System interface to bank interface

`define SIMD_WRAP_UPSTREAM_CNTL_WAIT                            12'b0000_0000_0001
`define SIMD_WRAP_UPSTREAM_CNTL_CHECK_SIMD_ENABLE               12'b0000_0000_0010
`define SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_START             12'b0000_0000_0100
`define SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_COMPLETE          12'b0000_0000_1000
`define SIMD_WRAP_UPSTREAM_CNTL_SENT_DATA                       12'b0000_0001_0000
`define SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_COMPLETE               12'b0000_0010_0000
`define SIMD_WRAP_UPSTREAM_CNTL_WAIT_COMPLETE_DEASSERTED        12'b0000_0100_0000

`define SIMD_WRAP_UPSTREAM_CNTL_COMPLETE                        12'b0100_0000_0000
`define SIMD_WRAP_UPSTREAM_CNTL_ERR                             12'b1000_0000_0000

`define SIMD_WRAP_UPSTREAM_CNTL_STATE_WIDTH                     12
`define SIMD_WRAP_UPSTREAM_CNTL_STATE_MSB                       `SIMD_WRAP_UPSTREAM_CNTL_STATE_WIDTH-1
`define SIMD_WRAP_UPSTREAM_CNTL_STATE_LSB                       0
`define SIMD_WRAP_UPSTREAM_CNTL_STATE_SIZE                      (`SIMD_WRAP_UPSTREAM_CNTL_STATE_MSB - `SIMD_WRAP_UPSTREAM_CNTL_STATE_LSB +1)
`define SIMD_WRAP_UPSTREAM_CNTL_STATE_RANGE                      `SIMD_WRAP_UPSTREAM_CNTL_STATE_MSB : `SIMD_WRAP_UPSTREAM_CNTL_STATE_LSB


//------------------------------------------------------------------------------------------------------------


//------------------------------------------------
// FIFO's
//------------------------------------------------

`define SIMD_WRAP_REG_FROM_SCNTL_FIFO_DEPTH          16
`define SIMD_WRAP_REG_FROM_SCNTL_FIFO_THRESHOLD      12


//`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH           8
//`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_THRESHOLD       4


//--------------------------------------------------------
// From PE_CNTL

`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH          8
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH_MSB      (`SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH) -1
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH_LSB      0
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH_SIZE     (`SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH_MSB - `SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH_LSB +1)
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH_RANGE     `SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH_MSB : `SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH_LSB
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_MSB            ((`CLOG2(`SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH)) -1)
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_LSB            0
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_SIZE           (`SIMD_WRAP_TAG_FROM_CNTL_FIFO_MSB - `SIMD_WRAP_TAG_FROM_CNTL_FIFO_LSB +1)
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_RANGE           `SIMD_WRAP_TAG_FROM_CNTL_FIFO_MSB : `SIMD_WRAP_TAG_FROM_CNTL_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_WIDTH    `STACK_DOWN_OOB_INTF_TAG_SIZE 
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_MSB      `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_WIDTH-1
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_LSB      0
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_SIZE     (`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_MSB - `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_LSB +1)
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_RANGE     `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_MSB : `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_LSB

`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_WIDTH    `PE_NUM_LANES_WIDTH   
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_MSB      (`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_LSB+`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_WIDTH ) -1
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_LSB      `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_MSB+1
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_SIZE     (`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_MSB - `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_LSB +1)
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_RANGE     `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_MSB : `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_LSB

`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_WIDTH    `PE_CNTL_OOB_OPTION_DATA_WIDTH 
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_MSB      (`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_LSB+`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_WIDTH ) -1
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_LSB      `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_MSB+1
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_SIZE     (`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_MSB - `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_LSB +1)
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_RANGE     `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_MSB : `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_LSB

`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_WIDTH     `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_TAG_WIDTH        \
                                                        +`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_WIDTH  \
                                                        +`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_WIDTH 

`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_MSB            `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_WIDTH -1
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_LSB            0
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_SIZE           (`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_MSB - `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_LSB +1)
`define SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_RANGE           `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_MSB : `SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_ALMOST_FULL_THRESHOLD 4


//------------------------------------------------
// MEMORY
//------------------------------------------------

// PE SIMD option memory size
`define SIMD_WRAP_SIMD_OPTION_MEMORY_DEPTH   256
`define SIMD_WRAP_SIMD_OPTION_MEMORY_RANGE    `SIMD_WRAP_SIMD_OPTION_MEMORY_DEPTH-1 : 0
`define SIMD_WRAP_SIMD_PTR_MEMORY_RANGE       `SIMD_WRAP_SIMD_OPTION_MEMORY_DEPTH-1 : 0

`define SIMD_WRAP_SIMD_OPTION_MEMORY_ADDR_MSB            ((`CLOG2(`SIMD_WRAP_SIMD_OPTION_MEMORY_DEPTH)) -1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_ADDR_LSB            0
`define SIMD_WRAP_SIMD_OPTION_MEMORY_ADDR_SIZE           (`SIMD_WRAP_SIMD_OPTION_MEMORY_ADDR_MSB - `SIMD_WRAP_SIMD_OPTION_MEMORY_ADDR_LSB +1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_ADDR_RANGE           `SIMD_WRAP_SIMD_OPTION_MEMORY_ADDR_MSB : `SIMD_WRAP_SIMD_OPTION_MEMORY_ADDR_LSB

`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_WIDTH    (`SIMD_CORE_OPERATION_WIDTH  )
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_MSB      (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_WIDTH-1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_LSB      0
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_SIZE     (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_MSB - `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_LSB +1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_RANGE     `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_MSB : `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_LSB

`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_WIDTH    1
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_MSB      (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_LSB+`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_WIDTH)-1
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_LSB      (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_MSB+1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_SIZE     (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_MSB - `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_LSB +1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_RANGE     `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_MSB : `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_LSB
/*
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_WIDTH      `SIMD_WRAP_OPERATION_STAGES_VALID_WIDTH   
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_MSB        (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_LSB+`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_WIDTH)-1
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_LSB        (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_MSB+1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_SIZE       (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_MSB - `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_LSB +1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_RANGE       `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_MSB : `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_LSB
*/

`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_WIDTH            `SIMD_WRAP_OPERATION_STAGES_TYPE_WIDTH   
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_MSB              (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_LSB+`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_WIDTH)-1
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_LSB              (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_MSB+1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_SIZE             (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_MSB - `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_LSB +1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_RANGE             `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_MSB : `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_LSB

// save in reg pointed to by current index and increment
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_WIDTH            1
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_MSB              (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_LSB+`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_WIDTH)-1
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_LSB              (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_MSB+1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_SIZE             (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_MSB - `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_LSB +1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_RANGE             `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_MSB : `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_LSB

// save to local reg pinted to by index (increment index after save)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_WIDTH            `PE_EXEC_LANE_ID_WIDTH 
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_MSB              (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_LSB+`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_WIDTH)-1
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_LSB              (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_MSB+1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_SIZE             (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_MSB - `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_LSB +1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_RANGE             `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_MSB : `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_LSB

`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_WIDTH  `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_WIDTH      \
                                                     +`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_WIDTH    \
                                                     +`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_WIDTH    \
                                                     +`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_WIDTH       \
                                                     +`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_WIDTH     

`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_MSB            `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_WIDTH -1
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_LSB            0
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_SIZE           (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_MSB - `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_LSB +1)
`define SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_RANGE           `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_MSB : `SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_LSB





`endif

