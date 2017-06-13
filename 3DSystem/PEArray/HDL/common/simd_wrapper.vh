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




//------------------------------------------------
// FIFO's
//------------------------------------------------

`define SIMD_WRAP_REG_FROM_SCNTL_FIFO_DEPTH          8
`define SIMD_WRAP_REG_FROM_SCNTL_FIFO_THRESHOLD      4


`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH           8
`define SIMD_WRAP_TAG_FROM_CNTL_FIFO_THRESHOLD       4


//--------------------------------------------------------
// Transfer from System interface to bank interface

`define SIMD_WRAP_UPSTREAM_CNTL_WAIT                            6'b00_0001
`define SIMD_WRAP_UPSTREAM_CNTL_SEND_DATA                       6'b00_0010
`define SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_COMPLETE               6'b00_0100
`define SIMD_WRAP_UPSTREAM_CNTL_WAIT_COMPLETE_DEASSERTED        6'b00_1000
`define SIMD_WRAP_UPSTREAM_CNTL_COMPLETE                        6'b01_0000
`define SIMD_WRAP_UPSTREAM_CNTL_ERR                             6'b10_0000

`define SIMD_WRAP_UPSTREAM_CNTL_STATE_WIDTH                     6
`define SIMD_WRAP_UPSTREAM_CNTL_STATE_MSB                       `SIMD_WRAP_UPSTREAM_CNTL_STATE_WIDTH-1
`define SIMD_WRAP_UPSTREAM_CNTL_STATE_LSB                       0
`define SIMD_WRAP_UPSTREAM_CNTL_STATE_SIZE                      (`SIMD_WRAP_UPSTREAM_CNTL_STATE_MSB - `SIMD_WRAP_UPSTREAM_CNTL_STATE_LSB +1)
`define SIMD_WRAP_UPSTREAM_CNTL_STATE_RANGE                      `SIMD_WRAP_UPSTREAM_CNTL_STATE_MSB : `SIMD_WRAP_UPSTREAM_CNTL_STATE_LSB


//------------------------------------------------------------------------------------------------------------



`endif

