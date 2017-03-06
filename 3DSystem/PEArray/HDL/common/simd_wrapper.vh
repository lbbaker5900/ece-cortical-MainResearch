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




`endif

