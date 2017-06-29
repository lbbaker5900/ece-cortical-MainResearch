`ifndef _dram_access_timer_vh
`define _dram_access_timer_vh

/*****************************************************************

    File name   : dram_access_timer.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


`define DRAM_ACC_NUM_OF_CMDS              5
`define DRAM_ACC_NUM_OF_CMDS_WIDTH        3   // need to account for 5
`define DRAM_ACC_NUM_OF_CMDS_MSB          `DRAM_ACC_NUM_OF_CMDS_WIDTH-1
`define DRAM_ACC_NUM_OF_CMDS_LSB          0
`define DRAM_ACC_NUM_OF_CMDS_SIZE         (`DRAM_ACC_NUM_OF_CMDS_MSB - `DRAM_ACC_NUM_OF_CMDS_LSB +1)
`define DRAM_ACC_NUM_OF_CMDS_RANGE         `DRAM_ACC_NUM_OF_CMDS_MSB : `DRAM_ACC_NUM_OF_CMDS_LSB
`define DRAM_ACC_NUM_OF_CMDS_VECTOR        `DRAM_ACC_NUM_OF_CMDS-1 : 0
  
`define DRAM_ACC_CMD_IS_PO       0
`define DRAM_ACC_CMD_IS_PC       1
`define DRAM_ACC_CMD_IS_CR       2
`define DRAM_ACC_CMD_IS_CW       3
`define DRAM_ACC_CMD_IS_PR       4
`define DRAM_ACC_CMD_IS_NOP      5
`define DRAM_ACC_CMD_IS_ADJ      6


`define DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES              6  // commands plus adjacent bank
`define DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_WIDTH        `DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES
`define DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_MSB          `DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_WIDTH-1
`define DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_LSB          0
`define DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_SIZE         (`DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_MSB - `DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_LSB +1)
`define DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_RANGE         `DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_MSB : `DRAM_ACC_NUM_OF_PAGE_DEPENDENCIES_LSB
  
`define DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES              5 // need to account for commands only
`define DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_WIDTH        `DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES
`define DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_MSB          `DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_WIDTH-1
`define DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_LSB          0
`define DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_SIZE         (`DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_MSB - `DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_LSB +1)
`define DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_RANGE         `DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_MSB : `DRAM_ACC_NUM_OF_CACHE_DEPENDENCIES_LSB
  
`define DRAM_ACC_TIMER_WIDTH              5  
`define DRAM_ACC_TIMER_MSB                `DRAM_ACC_TIMER_WIDTH-1
`define DRAM_ACC_TIMER_LSB                0
`define DRAM_ACC_TIMER_SIZE               (`DRAM_ACC_TIMER_MSB - `DRAM_ACC_TIMER_LSB +1)
`define DRAM_ACC_TIMER_RANGE               `DRAM_ACC_TIMER_MSB : `DRAM_ACC_TIMER_LSB
  
//------------------------------------------------------------------------------------------------------------------
// DiRAM4 Requirements

// PO
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2PO                 19
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2PC                  9
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2CR                  9
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2CW                  3
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2PR                  0
// PC
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2PO                 10
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2PC                  0
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2CR                  0
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2CW                  0
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PC2PR                 10
// CR
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2PO                 13
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2PC                  3
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2CR                  2
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2CW                  2
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CR2PR                  0
// CW
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2PO                 15
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2PC                  5
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2CR                  2
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2CW                  2
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_CW2PR                  0
// PR
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2PO                 19
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2PC                 19
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2CR                  0
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2CW                  0
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PR2PR                 19

`define DRAM_ACC_DIRAM4_REQMTS_TIMER_INTER_BANK            19

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FSM's
//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// end of FSM's
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------



//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FIFO's
//------------------------------------------------------------------------------------------------------------





//------------------------------------------------------------------------------------------------------------

`endif
