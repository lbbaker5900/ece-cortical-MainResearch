`ifndef _pe_cntl_vh
`define _pe_cntl_vh

/*****************************************************************

    File name   : pe_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Feb 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/

// OOB option size
`define PE_CNTL_OOB_OPTION_WIDTH   8
`define PE_CNTL_OOB_OPTION_MSB     `PE_CNTL_OOB_OPTION_WIDTH-1
`define PE_CNTL_OOB_OPTION_LSB     0
`define PE_CNTL_OOB_OPTION_SIZE    (`PE_CNTL_OOB_OPTION_MSB - `PE_CNTL_OOB_OPTION_LSB +1)
`define PE_CNTL_OOB_OPTION_RANGE    `PE_CNTL_OOB_OPTION_MSB : `PE_CNTL_OOB_OPTION_LSB

`define PE_CNTL_OOB_OPTION_DATA_WIDTH   8
`define PE_CNTL_OOB_OPTION_DATA_MSB     `PE_CNTL_OOB_OPTION_DATA_WIDTH-1
`define PE_CNTL_OOB_OPTION_DATA_LSB     0
`define PE_CNTL_OOB_OPTION_DATA_SIZE    (`PE_CNTL_OOB_OPTION_DATA_MSB - `PE_CNTL_OOB_OPTION_DATA_LSB +1)
`define PE_CNTL_OOB_OPTION_DATA_RANGE    `PE_CNTL_OOB_OPTION_DATA_MSB : `PE_CNTL_OOB_OPTION_DATA_LSB

// OOB option locations

// First option tuple
`define PE_CNTL_OOB_OPTION0_LSB            0
`define PE_CNTL_OOB_OPTION0_MSB            (`PE_CNTL_OOB_OPTION_WIDTH + `PE_CNTL_OOB_OPTION0_LSB) -1
`define PE_CNTL_OOB_OPTION0_SIZE           (`PE_CNTL_OOB_OPTION0_MSB - `PE_CNTL_OOB_OPTION0_LSB) +1
`define PE_CNTL_OOB_OPTION0_RANGE          `PE_CNTL_OOB_OPTION0_MSB : `PE_CNTL_OOB_OPTION0_LSB
                                           
`define PE_CNTL_OOB_OPTION0_DATA_LSB       `PE_CNTL_OOB_OPTION0_MSB +1
`define PE_CNTL_OOB_OPTION0_DATA_MSB       (`PE_CNTL_OOB_OPTION_DATA_WIDTH + `PE_CNTL_OOB_OPTION0_DATA_LSB) -1
`define PE_CNTL_OOB_OPTION0_DATA_SIZE      (`PE_CNTL_OOB_OPTION0_DATA_MSB - `PE_CNTL_OOB_OPTION0_DATA_LSB) +1
`define PE_CNTL_OOB_OPTION0_DATA_RANGE      `PE_CNTL_OOB_OPTION0_DATA_MSB : `PE_CNTL_OOB_OPTION0_DATA_LSB
                                           
// Second option tuple                     
`define PE_CNTL_OOB_OPTION1_LSB            `PE_CNTL_OOB_OPTION0_DATA_MSB +1
`define PE_CNTL_OOB_OPTION1_MSB            (`PE_CNTL_OOB_OPTION_WIDTH + `PE_CNTL_OOB_OPTION1_LSB) -1
`define PE_CNTL_OOB_OPTION1_SIZE           (`PE_CNTL_OOB_OPTION1_MSB - `PE_CNTL_OOB_OPTION1_LSB) +1
`define PE_CNTL_OOB_OPTION1_RANGE          `PE_CNTL_OOB_OPTION1_MSB : `PE_CNTL_OOB_OPTION1_LSB
                                           
`define PE_CNTL_OOB_OPTION1_DATA_LSB       `PE_CNTL_OOB_OPTION1_MSB +1
`define PE_CNTL_OOB_OPTION1_DATA_MSB       (`PE_CNTL_OOB_OPTION_DATA_WIDTH + `PE_CNTL_OOB_OPTION1_DATA_LSB) -1
`define PE_CNTL_OOB_OPTION1_DATA_SIZE      (`PE_CNTL_OOB_OPTION1_DATA_MSB - `PE_CNTL_OOB_OPTION1_DATA_LSB) +1
`define PE_CNTL_OOB_OPTION1_DATA_RANGE      `PE_CNTL_OOB_OPTION1_DATA_MSB : `PE_CNTL_OOB_OPTION1_DATA_LSB


//------------------------------------------------
// MEMORY
//------------------------------------------------

// PE stOp option memory size
`define PE_CNTL_STOP_OPTION_MEMORY_DEPTH   256
`define PE_CNTL_STOP_OPTION_MEMORY_RANGE    `PE_CNTL_STOP_OPTION_MEMORY_DEPTH-1 : 0
`define PE_CNTL_STOP_PTR_MEMORY_RANGE       `PE_CNTL_STOP_OPTION_MEMORY_DEPTH-1 : 0

`define PE_CNTL_STOP_OPTION_MEMORY_ADDR_MSB            ((`CLOG2(`PE_CNTL_STOP_OPTION_MEMORY_DEPTH)) -1)
`define PE_CNTL_STOP_OPTION_MEMORY_ADDR_LSB            0
`define PE_CNTL_STOP_OPTION_MEMORY_ADDR_SIZE           (`PE_CNTL_STOP_OPTION_MEMORY_ADDR_MSB - `PE_CNTL_STOP_OPTION_MEMORY_ADDR_LSB +1)
`define PE_CNTL_STOP_OPTION_MEMORY_ADDR_RANGE           `PE_CNTL_STOP_OPTION_MEMORY_ADDR_MSB : `PE_CNTL_STOP_OPTION_MEMORY_ADDR_LSB

`define PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_WIDTH \
                                    `STREAMING_OP_CNTL_OPERATION_WIDTH   \
                                  + `PE_ARRAY_CHIPLET_ADDRESS_WIDTH      \
                                  + `PE_ARRAY_CHIPLET_ADDRESS_WIDTH      \
                                  + `PE_DATA_TYPES_WIDTH                 \
                                  + `PE_DATA_TYPES_WIDTH                 \
                                  + `PE_ARRAY_CHIPLET_ADDRESS_WIDTH      \
                                  + `PE_ARRAY_CHIPLET_ADDRESS_WIDTH      \
                                  + `PE_DATA_TYPES_WIDTH                 \
                                  + `PE_DATA_TYPES_WIDTH                 \
                                  + `PE_MAX_NUM_OF_TYPES_WIDTH           \
               

`define PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_MSB            `PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_WIDTH -1
`define PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_LSB            0
`define PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_SIZE           (`PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_MSB - `PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_LSB +1)
`define PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_RANGE           `PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_MSB : `PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_LSB

// PE stOp option memory size
`define PE_CNTL_SIMD_OPTION_MEMORY_DEPTH   256
`define PE_CNTL_SIMD_OPTION_MEMORY_RANGE    `PE_CNTL_SIMD_OPTION_MEMORY_DEPTH-1 : 0
`define PE_CNTL_SIMD_PTR_MEMORY_RANGE       `PE_CNTL_SIMD_OPTION_MEMORY_DEPTH-1 : 0



//------------------------------------------------
// FSMs
//------------------------------------------------

//--------------------------------------------------------

`define PE_CNTL_OOB_RX_CNTL_WAIT                            8'b0000_0001
`define PE_CNTL_OOB_RX_CNTL_SOM                             8'b0000_0010
`define PE_CNTL_OOB_RX_CNTL_MOM                             8'b0000_0100
`define PE_CNTL_OOB_RX_CNTL_START_CMD                       8'b0000_1000
//`define PE_CNTL_OOB_RX_CNTL_OP_RUNNING                      8'b0001_0000
//`define PE_CNTL_OOB_RX_CNTL_WAIT_COMPLETE_DEASSERTED        8'b0010_0000
`define PE_CNTL_OOB_RX_CNTL_COMPLETE                        8'b0100_0000
`define PE_CNTL_OOB_RX_CNTL_ERR                             8'b1000_0000

`define PE_CNTL_OOB_RX_CNTL_STATE_WIDTH         8
`define PE_CNTL_OOB_RX_CNTL_STATE_MSB           `PE_CNTL_OOB_RX_CNTL_STATE_WIDTH-1
`define PE_CNTL_OOB_RX_CNTL_STATE_LSB           0
`define PE_CNTL_OOB_RX_CNTL_STATE_SIZE          (`PE_CNTL_OOB_RX_CNTL_STATE_MSB - `PE_CNTL_OOB_RX_CNTL_STATE_LSB +1)
`define PE_CNTL_OOB_RX_CNTL_STATE_RANGE          `PE_CNTL_OOB_RX_CNTL_STATE_MSB : `PE_CNTL_OOB_RX_CNTL_STATE_LSB


`define PE_CNTL_OOB_RX_REGS_PER_CYCLE            ( `STACK_UP_INTF_DATA_WIDTH / `PE_EXEC_LANE_WIDTH )
`define PE_CNTL_OOB_RX_NUM_OF_TRANSFERS          ( `PE_NUM_OF_EXEC_LANES / `PE_CNTL_OOB_RX_REGS_PER_CYCLE )
`define PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_WIDTH    (`CLOG2( `PE_CNTL_OOB_RX_NUM_OF_TRANSFERS ))
`define PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_MSB      `PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_WIDTH-1
`define PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_LSB      0
`define PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_SIZE     (`PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_MSB - `PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_LSB +1)
`define PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_RANGE     `PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_MSB : `PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_LSB

`define PE_CNTL_OOB_RX_NUM_OF_TRANSFERS_M1       `PE_CNTL_OOB_RX_NUM_OF_TRANSFERS-1  // to make comparison easy

//--------------------------------------------------------

`define PE_CNTL_STOP_CNTL_WAIT                            8'b0000_0001
`define PE_CNTL_STOP_CNTL_READ_STOP_MEMORY                8'b0000_0010
`define PE_CNTL_STOP_CNTL_START_CMD                       8'b0000_0100
`define PE_CNTL_STOP_CNTL_OP_RUNNING                      8'b0000_1000
`define PE_CNTL_STOP_CNTL_WAIT_COMPLETE_DEASSERTED        8'b0001_0000
`define PE_CNTL_STOP_CNTL_COMPLETE                        8'b0100_0000
`define PE_CNTL_STOP_CNTL_ERR                             8'b1000_0000

`define PE_CNTL_STOP_CNTL_STATE_WIDTH         8
`define PE_CNTL_STOP_CNTL_STATE_MSB           `PE_CNTL_STOP_CNTL_STATE_WIDTH-1
`define PE_CNTL_STOP_CNTL_STATE_LSB           0
`define PE_CNTL_STOP_CNTL_STATE_SIZE          (`PE_CNTL_STOP_CNTL_STATE_MSB - `PE_CNTL_STOP_CNTL_STATE_LSB +1)
`define PE_CNTL_STOP_CNTL_STATE_RANGE          `PE_CNTL_STOP_CNTL_STATE_MSB : `PE_CNTL_STOP_CNTL_STATE_LSB

  
//------------------------------------------------
// FIFO's
//------------------------------------------------

`define PE_CNTL_OOB_RX_FIFO_DEPTH          16
`define PE_CNTL_OOB_RX_FIFO_THRESHOLD      8


//--------------------------------------------------------
// From PE_CNTL
// - internal to pe_cntl.
// - need to pipeline commands to SIMD

`define PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH          8
`define PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH_MSB      (`PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH) -1
`define PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH_LSB      0
`define PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH_SIZE     (`PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH_MSB - `PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH_LSB +1)
`define PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH_RANGE     `PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH_MSB : `PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH_LSB
`define PE_CNTL_TAG_FROM_CNTL_FIFO_MSB            ((`CLOG2(`PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH)) -1)
`define PE_CNTL_TAG_FROM_CNTL_FIFO_LSB            0
`define PE_CNTL_TAG_FROM_CNTL_FIFO_SIZE           (`PE_CNTL_TAG_FROM_CNTL_FIFO_MSB - `PE_CNTL_TAG_FROM_CNTL_FIFO_LSB +1)
`define PE_CNTL_TAG_FROM_CNTL_FIFO_RANGE           `PE_CNTL_TAG_FROM_CNTL_FIFO_MSB : `PE_CNTL_TAG_FROM_CNTL_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_WIDTH    `STACK_DOWN_OOB_INTF_TAG_SIZE 
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_MSB      `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_WIDTH-1
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_LSB      0
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_SIZE     (`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_MSB - `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_LSB +1)
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_RANGE     `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_MSB : `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_LSB

`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_WIDTH    `PE_NUM_LANES_WIDTH   
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_MSB      (`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_LSB+`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_WIDTH ) -1
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_LSB      `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_MSB+1
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_SIZE     (`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_MSB - `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_LSB +1)
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_RANGE     `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_MSB : `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_LSB

`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_WIDTH    `PE_CNTL_OOB_OPTION_DATA_WIDTH 
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_MSB      (`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_LSB+`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_WIDTH ) -1
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_LSB      `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_MSB+1
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_SIZE     (`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_MSB - `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_LSB +1)
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_RANGE     `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_MSB : `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_LSB

`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_WIDTH     `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_TAG_WIDTH        \
                                                        +`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_NUM_LANES_WIDTH  \
                                                        +`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_OPTION_PTR_WIDTH 

`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_MSB            `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_WIDTH -1
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_LSB            0
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_SIZE           (`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_MSB - `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_LSB +1)
`define PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_RANGE           `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_MSB : `PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define PE_CNTL_TAG_FROM_CNTL_FIFO_ALMOST_FULL_THRESHOLD 4


//------------------------------------------------------------------------------------------------------------



`endif
