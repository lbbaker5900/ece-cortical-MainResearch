`ifndef _dram_access_timer_vh
`define _dram_access_timer_vh

/*****************************************************************

    File name   : dram_access_timer.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


`define DRAM_ACC_NUM_OF_CMDS              5 //7
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

//----------------------------------------------------------------------------------------------------
// Command sequence
//
`define DRAM_ACC_NUM_OF_SEQ_TYPES    16  // include some pad

`define DRAM_ACC_CMD_SEQ_IS_POCR     0
`define DRAM_ACC_CMD_SEQ_IS_POCW     1
`define DRAM_ACC_CMD_SEQ_IS_PCPOCR   2
`define DRAM_ACC_CMD_SEQ_IS_PCPOCW   3
`define DRAM_ACC_CMD_SEQ_IS_CR       4
`define DRAM_ACC_CMD_SEQ_IS_CW       5
`define DRAM_ACC_CMD_SEQ_IS_PR       6
`define DRAM_ACC_CMD_SEQ_IS_PCPR     7  // the stream fsm's will reopen the page, so dont need PCPRPO
`define DRAM_ACC_CMD_SEQ_IS_NOP      8  // make sure this is the last

`define DRAM_ACC_SEQ_TYPE_WIDTH        (`CLOG2(`DRAM_ACC_NUM_OF_SEQ_TYPES))
`define DRAM_ACC_SEQ_TYPE_MSB          `DRAM_ACC_SEQ_TYPE_WIDTH-1
`define DRAM_ACC_SEQ_TYPE_LSB          0
`define DRAM_ACC_SEQ_TYPE_SIZE         (`DRAM_ACC_SEQ_TYPE_MSB - `DRAM_ACC_SEQ_TYPE_LSB +1)
`define DRAM_ACC_SEQ_TYPE_RANGE         `DRAM_ACC_SEQ_TYPE_MSB : `DRAM_ACC_SEQ_TYPE_LSB

`define DRAM_ACC_CMD_SEQ_MAX_LENGTH      4  // last is always NOP
`define DRAM_ACC_CMD_SEQ_COUNT_WIDTH              (`CLOG2(`DRAM_ACC_CMD_SEQ_MAX_LENGTH))
`define DRAM_ACC_CMD_SEQ_COUNT_MSB                `DRAM_ACC_CMD_SEQ_COUNT_WIDTH-1
`define DRAM_ACC_CMD_SEQ_COUNT_LSB                0
`define DRAM_ACC_CMD_SEQ_COUNT_SIZE               (`DRAM_ACC_CMD_SEQ_COUNT_MSB - `DRAM_ACC_CMD_SEQ_COUNT_LSB +1)
`define DRAM_ACC_CMD_SEQ_COUNT_RANGE               `DRAM_ACC_CMD_SEQ_COUNT_MSB : `DRAM_ACC_CMD_SEQ_COUNT_LSB

//----------------------------------------------------------------------------------------------------


`define DRAM_ACC_NUM_CMD_SEQS               9
`define DRAM_ACC_CMD_SEQ_WIDTH              4  
`define DRAM_ACC_CMD_SEQ_MSB                `DRAM_ACC_CMD_SEQ_WIDTH-1
`define DRAM_ACC_CMD_SEQ_LSB                0
`define DRAM_ACC_CMD_SEQ_SIZE               (`DRAM_ACC_CMD_SEQ_MSB - `DRAM_ACC_CMD_SEQ_LSB +1)
`define DRAM_ACC_CMD_SEQ_RANGE               `DRAM_ACC_CMD_SEQ_MSB : `DRAM_ACC_CMD_SEQ_LSB

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
`define DRAM_ACC_DIRAM4_REQMTS_TIMER_PO2CR                  3
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

//--------------------------------------------------------
// Use a simple fsm rather than just regs to flow a sample thru the timer
// 

`define DRAM_ACC_SAMPLE_WAIT                 3'b001
//`define DRAM_ACC_SAMPLE_START                4'b0010
`define DRAM_ACC_SAMPLE_RESET_TABLE          3'b010
`define DRAM_ACC_SAMPLE_COMPLETE             3'b100

`define DRAM_ACC_SAMPLE_STATE_WIDTH         3
`define DRAM_ACC_SAMPLE_STATE_MSB           `DRAM_ACC_SAMPLE_STATE_WIDTH-1
`define DRAM_ACC_SAMPLE_STATE_LSB           0
`define DRAM_ACC_SAMPLE_STATE_SIZE          (`DRAM_ACC_SAMPLE_STATE_MSB - `DRAM_ACC_SAMPLE_STATE_LSB +1)
`define DRAM_ACC_SAMPLE_STATE_RANGE          `DRAM_ACC_SAMPLE_STATE_MSB : `DRAM_ACC_SAMPLE_STATE_LSB

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
