`ifndef _wu_memory_vh
`define _wu_memory_vh

/*****************************************************************

    File name   : wu_memory.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//--------------------------------------------------------
  
//------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------
// DEBUG

`ifdef TB_LIMIT_MAX_INST
  `define WUM_DEBUG_MAX_INSTRUCTIONS       8
`else
  `define WUM_DEBUG_MAX_INSTRUCTIONS       512
`endif

`define WUM_MAX_INST_WIDTH         (`CLOG2(`WUM_DEBUG_MAX_INSTRUCTIONS+1))  // make sure we round up so max is valid
`define WUM_MAX_INST_MSB           `WUM_MAX_INST_WIDTH-1
`define WUM_MAX_INST_LSB           0
`define WUM_MAX_INST_SIZE          (`WUM_MAX_INST_MSB - `WUM_MAX_INST_LSB +1)
`define WUM_MAX_INST_RANGE          `WUM_MAX_INST_MSB : `WUM_MAX_INST_LSB

// end DEBUG
//------------------------------------------------------------------------------------------------------------

`endif
