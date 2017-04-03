`ifndef _wu_cntl_vh
`define _wu_cntl_vh

/*****************************************************************

    File name   : wu_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// FIFO's
//------------------------------------------------


//--------------------------------------------------------
  
`define WU_CNTL_TYPE_WIDTH             4  // FIXME ??
`define WU_CNTL_TYPE_MSB               `WU_CNTL_TYPE_WIDTH-1
`define WU_CNTL_TYPE_LSB               0
`define WU_CNTL_TYPE_SIZE              (`WU_CNTL_TYPE_MSB - `WU_CNTL_TYPE_LSB +1)
`define WU_CNTL_TYPE_RANGE              `WU_CNTL_TYPE_MSB : `WU_CNTL_TYPE_LSB

`define WU_CNTL_MEMORY_PTR_WIDTH         8  // FIXME ??
`define WU_CNTL_MEMORY_PTR_MSB           `WU_CNTL_MEMORY_PTR_WIDTH-1
`define WU_CNTL_MEMORY_PTR_LSB           0
`define WU_CNTL_MEMORY_PTR_SIZE          (`WU_CNTL_MEMORY_PTR_MSB - `WU_CNTL_MEMORY_PTR_LSB +1)
`define WU_CNTL_MEMORY_PTR_RANGE          `WU_CNTL_MEMORY_PTR_MSB : `WU_CNTL_MEMORY_PTR_LSB

`define WU_CNTL_NUM_WORDS_WIDTH          (`CLOG2(`PE_NUM_OF_EXEC_LANES))
`define WU_CNTL_NUM_WORDS_MSB            `WU_CNTL_NUM_WORDS_WIDTH-1
`define WU_CNTL_NUM_WORDS_LSB            0
`define WU_CNTL_NUM_WORDS_SIZE           (`WU_CNTL_NUM_WORDS_MSB - `WU_CNTL_NUM_WORDS_LSB +1)
`define WU_CNTL_NUM_WORDS_RANGE           `WU_CNTL_NUM_WORDS_MSB : `WU_CNTL_NUM_WORDS_LSB

//------------------------------------------------------------------------------------------------------------
PE_NUM_OF_EXEC_LANES               


