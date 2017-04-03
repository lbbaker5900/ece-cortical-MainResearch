`ifndef _manager_vh
`define _manager_vh

/*****************************************************************

    File name   : manager.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/

//------------------------------------------------
// System
//------------------------------------------------
`define MGR_MGR_ID_MSB               ((`CLOG2(`MGR_ARRAY_NUM_OF_MGR))-1)
`define MGR_MGR_ID_LSB               0
`define MGR_MGR_ID_SIZE              (`MGR_MGR_ID_MSB - `MGR_MGR_ID_LSB +1)
`define MGR_MGR_ID_RANGE              `MGR_MGR_ID_MSB : `MGR_MGR_ID_LSB

`define MGR_MGR_ID_BITMASK_MSB               (`MGR_ARRAY_NUM_OF_MGR-1)
`define MGR_MGR_ID_BITMASK_LSB               0
`define MGR_MGR_ID_BITMASK_SIZE              (`MGR_MGR_ID_BITMASK_MSB - `MGR_MGR_ID_BITMASK_LSB +1)
`define MGR_MGR_ID_BITMASK_RANGE              `MGR_MGR_ID_BITMASK_MSB : `MGR_MGR_ID_BITMASK_LSB
//------------------------------------------------
// Stack Bus stream
//------------------------------------------------

// we will carry a tag to track result (to possibly support multiple operations before first result is returned)
`define MGR_STD_OOB_TAG_WIDTH          `PE_STD_OOB_TAG_WIDTH
`define MGR_STD_OOB_TAG_MSB            `MGR_STD_OOB_TAG_WIDTH-1
`define MGR_STD_OOB_TAG_LSB            0
`define MGR_STD_OOB_TAG_RANGE          `MGR_STD_OOB_TAG_MSB : `MGR_STD_OOB_TAG_LSB

`define MGR_STD_LANE_DATA_WIDTH          `STACK_DOWN_INTF_STRM_DATA_WIDTH 
`define MGR_STD_LANE_DATA_MSB            `MGR_STD_LANE_DATA_WIDTH-1
`define MGR_STD_LANE_DATA_LSB            0
`define MGR_STD_LANE_DATA_RANGE          `MGR_STD_LANE_DATA_MSB : `MGR_STD_LANE_DATA_LSB

`define MGR_STU_DATA_WIDTH          `STACK_UP_INTF_DATA_WIDTH 
`define MGR_STU_DATA_MSB            `MGR_STU_DATA_WIDTH-1
`define MGR_STU_DATA_LSB            0
`define MGR_STU_DATA_RANGE          `MGR_STU_DATA_MSB : `MGR_STU_DATA_LSB



//------------------------------------------------
// MGR Stack bus streams
//------------------------------------------------

`define MGR_NUM_OF_STREAMS               `PE_NUM_OF_STREAMS 
`define MGR_NUM_OF_STREAMS_MSB           (`MGR_NUM_OF_STREAMS -1)
`define MGR_NUM_OF_STREAMS_LSB            0
`define MGR_NUM_OF_STREAMS_SIZE           (`MGR_NUM_OF_STREAMS_MSB - `MGR_NUM_OF_STREAMS_LSB +1)
`define MGR_NUM_OF_STREAMS_RANGE           `MGR_NUM_OF_STREAMS_MSB : `MGR_NUM_OF_STREAMS_LSB

//------------------------------------------------
// MGR Execution Lane 
//------------------------------------------------

`define MGR_NUM_OF_EXEC_LANES               `PE_NUM_OF_EXEC_LANES
`define MGR_NUM_OF_EXEC_LANES_MSB           (`MGR_NUM_OF_EXEC_LANES -1)
`define MGR_NUM_OF_EXEC_LANES_LSB            0
`define MGR_NUM_OF_EXEC_LANES_SIZE           (`MGR_NUM_OF_EXEC_LANES_MSB - `MGR_NUM_OF_EXEC_LANES_LSB +1)
`define MGR_NUM_OF_EXEC_LANES_RANGE           `MGR_NUM_OF_EXEC_LANES_MSB : `MGR_NUM_OF_EXEC_LANES_LSB

`define MGR_EXEC_LANE_WIDTH               `PE_EXEC_LANE_WIDTH
`define MGR_EXEC_LANE_WIDTH_MSB           `MGR_EXEC_LANE_WIDTH-1
`define MGR_EXEC_LANE_WIDTH_LSB            0
`define MGR_EXEC_LANE_WIDTH_SIZE           (`MGR_EXEC_LANE_WIDTH_MSB - `MGR_EXEC_LANE_WIDTH_LSB +1)
`define MGR_EXEC_LANE_WIDTH_RANGE           `MGR_EXEC_LANE_WIDTH_MSB : `MGR_EXEC_LANE_WIDTH_LSB

//---------------------------------------------------------------------------------------------------------------------
// Memory

//---------------------------------------------------------------------------------------------------------------------
// WU Memory

// FIXME
`define MGR_WU_ADDRESS_WIDTH                       24
`define MGR_WU_ADDRESS_MSB                         `MGR_WU_ADDRESS_WIDTH-1
`define MGR_WU_ADDRESS_LSB                         0
`define MGR_WU_ADDRESS_SIZE                        (`MGR_WU_ADDRESS_MSB - `MGR_WU_ADDRESS_LSB +1)
`define MGR_WU_ADDRESS_RANGE                        `MGR_WU_ADDRESS_MSB : `MGR_WU_ADDRESS_LSB


//---------------------------------------------------------------------------------------------------------------------
// WU Instruction

`define MGR_WU_OPT_PER_INST                       3
`define MGR_WU_OPT_PER_INST_WIDTH                 `MGR_WU_OPT_PER_INST   
`define MGR_WU_OPT_PER_INST_MSB                   `MGR_WU_OPT_PER_INST_WIDTH-1
`define MGR_WU_OPT_PER_INST_LSB                   0
`define MGR_WU_OPT_PER_INST_SIZE                  (`MGR_WU_OPT_PER_INST_MSB - `MGR_WU_OPT_PER_INST_LSB +1)
`define MGR_WU_OPT_PER_INST_RANGE                  `MGR_WU_OPT_PER_INST_MSB : `MGR_WU_OPT_PER_INST_LSB


`define MGR_WU_OPT_TYPE_WIDTH                 8
`define MGR_WU_OPT_TYPE_MSB                   `MGR_WU_OPT_TYPE_WIDTH-1
`define MGR_WU_OPT_TYPE_LSB                   0
`define MGR_WU_OPT_TYPE_SIZE                  (`MGR_WU_OPT_TYPE_MSB - `MGR_WU_OPT_TYPE_LSB +1)
`define MGR_WU_OPT_TYPE_RANGE                  `MGR_WU_OPT_TYPE_MSB : `MGR_WU_OPT_TYPE_LSB


`define MGR_WU_OPT_VALUE_WIDTH                 8
`define MGR_WU_OPT_VALUE_MSB                   `MGR_WU_OPT_VALUE_WIDTH-1
`define MGR_WU_OPT_VALUE_LSB                   0
`define MGR_WU_OPT_VALUE_SIZE                  (`MGR_WU_OPT_VALUE_MSB - `MGR_WU_OPT_VALUE_LSB +1)
`define MGR_WU_OPT_VALUE_RANGE                  `MGR_WU_OPT_VALUE_MSB : `MGR_WU_OPT_VALUE_LSB


`define MGR_WU_EXTD_OPT_VALUE_WIDTH                 `MGR_WU_OPT_VALUE_WIDTH  *3
`define MGR_WU_EXTD_OPT_VALUE_MSB                   `MGR_WU_EXTD_OPT_VALUE_WIDTH-1
`define MGR_WU_EXTD_OPT_VALUE_LSB                   0
`define MGR_WU_EXTD_OPT_VALUE_SIZE                  (`MGR_WU_EXTD_OPT_VALUE_MSB - `MGR_WU_EXTD_OPT_VALUE_LSB +1)
`define MGR_WU_EXTD_OPT_VALUE_RANGE                  `MGR_WU_EXTD_OPT_VALUE_MSB : `MGR_WU_EXTD_OPT_VALUE_LSB


// Instruction fields
`define MGR_INST_TYPE_WIDTH               5
`define MGR_INST_TYPE_MSB           `MGR_INST_TYPE_WIDTH-1
`define MGR_INST_TYPE_LSB            0
`define MGR_INST_TYPE_SIZE           (`MGR_INST_TYPE_MSB - `MGR_INST_TYPE_LSB +1)
`define MGR_INST_TYPE_RANGE           `MGR_INST_TYPE_MSB : `MGR_INST_TYPE_LSB

//---------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------
// Storage Descriptor Memory

// FIXME - need to check depth equirements (for sim, keep small)
`define MGR_STORAGE_DESC_MEMORY_DEPTH   1024
`define MGR_STORAGE_DESC_MEMORY_MSB     `MGR_STORAGE_DESC_MEMORY_DEPTH-1
`define MGR_STORAGE_DESC_MEMORY_LSB     0
`define MGR_STORAGE_DESC_MEMORY_SIZE    (`MGR_STORAGE_DESC_MEMORY_MSB - `MGR_STORAGE_DESC_MEMORY_LSB +1)
`define MGR_STORAGE_DESC_MEMORY_RANGE    `MGR_STORAGE_DESC_MEMORY_MSB : `MGR_STORAGE_DESC_MEMORY_LSB


`define MGR_STORAGE_DESC_ADDRESS_WIDTH   (`CLOG2(`MGR_STORAGE_DESC_MEMORY_DEPTH )) 
`define MGR_STORAGE_DESC_ADDRESS_MSB     `MGR_STORAGE_DESC_ADDRESS_WIDTH-1
`define MGR_STORAGE_DESC_ADDRESS_LSB     0
`define MGR_STORAGE_DESC_ADDRESS_SIZE    (`MGR_STORAGE_DESC_ADDRESS_MSB - `MGR_STORAGE_DESC_ADDRESS_LSB +1)
`define MGR_STORAGE_DESC_ADDRESS_RANGE    `MGR_STORAGE_DESC_ADDRESS_MSB : `MGR_STORAGE_DESC_ADDRESS_LSB


//---------------------------------------------------------------------------------------------------------------------
// DRAM Memory

`define MGR_DRAM_NUM_CHANNELS                       2
`define MGR_DRAM_NUM_BANKS                          32
`define MGR_DRAM_NUM_PAGES                          4096
`define MGR_DRAM_PAGE_SIZE                          4096
`define MGR_DRAM_NUM_WORDS                          `MGR_DRAM_PAGE_SIZE/`MGR_EXEC_LANE_WIDTH

`define MGR_DRAM_CHANNEL_ADDRESS_WIDTH                       (`CLOG2(`MGR_DRAM_NUM_CHANNELS ))
`define MGR_DRAM_CHANNEL_ADDRESS_MSB                         `MGR_DRAM_CHANNEL_ADDRESS_WIDTH-1
`define MGR_DRAM_CHANNEL_ADDRESS_LSB                         0
`define MGR_DRAM_CHANNEL_ADDRESS_SIZE                        (`MGR_DRAM_CHANNEL_ADDRESS_MSB - `MGR_DRAM_CHANNEL_ADDRESS_LSB +1)
`define MGR_DRAM_CHANNEL_ADDRESS_RANGE                        `MGR_DRAM_CHANNEL_ADDRESS_MSB : `MGR_DRAM_CHANNEL_ADDRESS_LSB

`define MGR_DRAM_BANK_ADDRESS_WIDTH                       (`CLOG2(`MGR_DRAM_NUM_BANKS ))
`define MGR_DRAM_BANK_ADDRESS_MSB                         `MGR_DRAM_BANK_ADDRESS_WIDTH-1
`define MGR_DRAM_BANK_ADDRESS_LSB                         0
`define MGR_DRAM_BANK_ADDRESS_SIZE                        (`MGR_DRAM_BANK_ADDRESS_MSB - `MGR_DRAM_BANK_ADDRESS_LSB +1)
`define MGR_DRAM_BANK_ADDRESS_RANGE                        `MGR_DRAM_BANK_ADDRESS_MSB : `MGR_DRAM_BANK_ADDRESS_LSB

`define MGR_DRAM_PAGE_ADDRESS_WIDTH                      (`CLOG2(`MGR_DRAM_NUM_PAGES ))
`define MGR_DRAM_PAGE_ADDRESS_MSB                         `MGR_DRAM_PAGE_ADDRESS_WIDTH-1
`define MGR_DRAM_PAGE_ADDRESS_LSB                         0
`define MGR_DRAM_PAGE_ADDRESS_SIZE                        (`MGR_DRAM_PAGE_ADDRESS_MSB - `MGR_DRAM_PAGE_ADDRESS_LSB +1)
`define MGR_DRAM_PAGE_ADDRESS_RANGE                        `MGR_DRAM_PAGE_ADDRESS_MSB : `MGR_DRAM_PAGE_ADDRESS_LSB

`define MGR_DRAM_WORD_ADDRESS_WIDTH                       (`CLOG2(`MGR_DRAM_NUM_WORDS ))
`define MGR_DRAM_WORD_ADDRESS_MSB                         `MGR_DRAM_WORD_ADDRESS_WIDTH-1
`define MGR_DRAM_WORD_ADDRESS_LSB                         0
`define MGR_DRAM_WORD_ADDRESS_SIZE                        (`MGR_DRAM_WORD_ADDRESS_MSB - `MGR_DRAM_WORD_ADDRESS_LSB +1)
`define MGR_DRAM_WORD_ADDRESS_RANGE                        `MGR_DRAM_WORD_ADDRESS_MSB : `MGR_DRAM_WORD_ADDRESS_LSB



//---------------------------------------------------------------------------------------------------------------------



`endif
