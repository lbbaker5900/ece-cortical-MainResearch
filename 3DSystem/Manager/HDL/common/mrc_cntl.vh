`ifndef _mrc_cntl_vh
`define _mrc_cntl_vh

/*****************************************************************

    File name   : mrc_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


  
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FSM's
//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// Storage Descriptor Extract FSM

`define MRC_CNTL_EXTRACT_DESC_WAIT                         5'b0_0001
                                                 
`define MRC_CNTL_EXTRACT_DESC_EXTRACT                      5'b0_0010
`define MRC_CNTL_EXTRACT_DESC_START_PROCESSING             5'b0_0100
`define MRC_CNTL_EXTRACT_DESC_COMPLETE                     5'b0_1000
                                                  
`define MRC_CNTL_EXTRACT_DESC_ERR                          5'b1_0000

`define MRC_CNTL_EXTRACT_DESC_STATE_WIDTH         5
`define MRC_CNTL_EXTRACT_DESC_STATE_MSB           `MRC_CNTL_EXTRACT_DESC_STATE_WIDTH-1
`define MRC_CNTL_EXTRACT_DESC_STATE_LSB           0
`define MRC_CNTL_EXTRACT_DESC_STATE_SIZE          (`MRC_CNTL_EXTRACT_DESC_STATE_MSB - `MRC_CNTL_EXTRACT_DESC_STATE_LSB +1)
`define MRC_CNTL_EXTRACT_DESC_STATE_RANGE          `MRC_CNTL_EXTRACT_DESC_STATE_MSB : `MRC_CNTL_EXTRACT_DESC_STATE_LSB

//--------------------------------------------------------
// Storage Descriptor Process FSM

`define MRC_CNTL_PROC_STORAGE_DESC_WAIT                         16'b0000_0000_0000_0001
                                                 
`define MRC_CNTL_PROC_STORAGE_DESC_EXTRACT                      16'b0000_0000_0000_0010
`define MRC_CNTL_PROC_STORAGE_DESC_READ                         16'b0000_0000_0000_0100
`define MRC_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID                16'b0000_0000_0000_1000
`define MRC_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA             16'b0000_0000_0001_0000
`define MRC_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHB             16'b0000_0000_0010_0000
`define MRC_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO              16'b0000_0000_0100_0000
`define MRC_CNTL_PROC_STORAGE_DESC_CONS_FIELD                   16'b0000_0000_1000_0000
`define MRC_CNTL_PROC_STORAGE_DESC_JUMP_FIELD                   16'b0000_0001_0000_0000
`define MRC_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS                16'b0000_0010_0000_0000
`define MRC_CNTL_PROC_STORAGE_DESC_INC_PBC                      16'b0000_0100_0000_0000
`define MRC_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE         16'b0000_1000_0000_0000

`define MRC_CNTL_PROC_STORAGE_DESC_COMPLETE                     16'b0100_0000_0000_0000
                                                  
`define MRC_CNTL_PROC_STORAGE_DESC_ERR                          16'b1000_0000_0000_0000

`define MRC_CNTL_PROC_STORAGE_DESC_STATE_WIDTH         16
`define MRC_CNTL_PROC_STORAGE_DESC_STATE_MSB           `MRC_CNTL_PROC_STORAGE_DESC_STATE_WIDTH-1
`define MRC_CNTL_PROC_STORAGE_DESC_STATE_LSB           0
`define MRC_CNTL_PROC_STORAGE_DESC_STATE_SIZE          (`MRC_CNTL_PROC_STORAGE_DESC_STATE_MSB - `MRC_CNTL_PROC_STORAGE_DESC_STATE_LSB +1)
`define MRC_CNTL_PROC_STORAGE_DESC_STATE_RANGE          `MRC_CNTL_PROC_STORAGE_DESC_STATE_MSB : `MRC_CNTL_PROC_STORAGE_DESC_STATE_LSB

//--------------------------------------------------------
// Stream Data FSM

`define MRC_CNTL_STRM_WAIT                    8'b0000_0001

`define MRC_CNTL_STRM_LOAD_FIRST_CONS_COUNT   8'b0000_0010
`define MRC_CNTL_STRM_LOAD_JUMP_VALUE         8'b0000_0100
//`define MRC_CNTL_STRM_CALC_NEXT_START_ADDR    8'b0000_1000
`define MRC_CNTL_STRM_COUNT_CONS              8'b0001_0000

`define MRC_CNTL_STRM_COMPLETE                8'b0100_0000

`define MRC_CNTL_STRM_ERR                     8'b1000_0000

`define MRC_CNTL_STRM_STATE_WIDTH         8
`define MRC_CNTL_STRM_STATE_MSB           `MRC_CNTL_STRM_STATE_WIDTH-1
`define MRC_CNTL_STRM_STATE_LSB           0
`define MRC_CNTL_STRM_STATE_SIZE          (`MRC_CNTL_STRM_STATE_MSB - `MRC_CNTL_STRM_STATE_LSB +1)
`define MRC_CNTL_STRM_STATE_RANGE          `MRC_CNTL_STRM_STATE_MSB : `MRC_CNTL_STRM_STATE_LSB

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// end of FSM's
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// Vector of channels
//  - used to indicate which channel has been opened with the current bank/page
  
`define MRC_CNTL_CHAN_BIT_WIDTH          `MGR_DRAM_NUM_CHANNELS
`define MRC_CNTL_CHAN_BIT_MSB           `MRC_CNTL_CHAN_BIT_WIDTH-1
`define MRC_CNTL_CHAN_BIT_LSB            0
`define MRC_CNTL_CHAN_BIT_SIZE           (`MRC_CNTL_CHAN_BIT_MSB - `MRC_CNTL_CHAN_BIT_LSB +1)
`define MRC_CNTL_CHAN_BIT_RANGE           `MRC_CNTL_CHAN_BIT_MSB : `MRC_CNTL_CHAN_BIT_LSB
//------------------------------------------------------------------------------------------------------------

`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  //--------------------------------------------------------
  // Vector of Lines
  //  - used to indicate which line has been opened with the current chan/bank/page
    
  `define MRC_CNTL_LINE_BIT_WIDTH          `MGR_DRAM_NUM_LINES
  `define MRC_CNTL_LINE_BIT_MSB           `MRC_CNTL_LINE_BIT_WIDTH-1
  `define MRC_CNTL_LINE_BIT_LSB            0
  `define MRC_CNTL_LINE_BIT_SIZE           (`MRC_CNTL_LINE_BIT_MSB - `MRC_CNTL_LINE_BIT_LSB +1)
  `define MRC_CNTL_LINE_BIT_RANGE           `MRC_CNTL_LINE_BIT_MSB : `MRC_CNTL_LINE_BIT_LSB
  //------------------------------------------------------------------------------------------------------------
`endif

//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// When we decrement the consequtive counter, we check for negative, so add bit
`define MRC_CNTL_CONS_COUNTER_WIDTH        `MGR_INST_CONS_JUMP_WIDTH+1
`define MRC_CNTL_CONS_COUNTER_MSB          `MRC_CNTL_CONS_COUNTER_WIDTH-1
`define MRC_CNTL_CONS_COUNTER_LSB          0
`define MRC_CNTL_CONS_COUNTER_SIZE         (`MRC_CNTL_CONS_COUNTER_MSB - `MRC_CNTL_CONS_COUNTER_LSB +1)
`define MRC_CNTL_CONS_COUNTER_RANGE         `MRC_CNTL_CONS_COUNTER_MSB : `MRC_CNTL_CONS_COUNTER_LSB


//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// Number of active lanes is 1..32, so need 6 bits
  
`define MRC_CNTL_NUM_LANES_WIDTH               (`CLOG2(`PE_NUM_OF_EXEC_LANES))+1
`define MRC_CNTL_NUM_LANES_MSB           `MRC_CNTL_NUM_LANES_WIDTH-1
`define MRC_CNTL_NUM_LANES_LSB            0
`define MRC_CNTL_NUM_LANES_SIZE           (`MRC_CNTL_NUM_LANES_MSB - `MRC_CNTL_NUM_LANES_LSB +1)
`define MRC_CNTL_NUM_LANES_RANGE           `MRC_CNTL_NUM_LANES_MSB : `MRC_CNTL_NUM_LANES_LSB
//------------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FIFO's
//------------------------------------------------------------------------------------------------------------

`define MRC_CNTL_DESC_FIFO_DEPTH          16
`define MRC_CNTL_DESC_FIFO_THRESHOLD      4

//--------------------------------------------------------
//--------------------------------------------------------
// From MMC

`define MRC_CNTL_FROM_MMC_FIFO_DEPTH          32
`define MRC_CNTL_FROM_MMC_FIFO_DEPTH_MSB      (`MRC_CNTL_FROM_MMC_FIFO_DEPTH) -1
`define MRC_CNTL_FROM_MMC_FIFO_DEPTH_LSB      0
`define MRC_CNTL_FROM_MMC_FIFO_DEPTH_SIZE     (`MRC_CNTL_FROM_MMC_FIFO_DEPTH_MSB - `MRC_CNTL_FROM_MMC_FIFO_DEPTH_LSB +1)
`define MRC_CNTL_FROM_MMC_FIFO_DEPTH_RANGE     `MRC_CNTL_FROM_MMC_FIFO_DEPTH_MSB : `MRC_CNTL_FROM_MMC_FIFO_DEPTH_LSB
`define MRC_CNTL_FROM_MMC_FIFO_MSB            ((`CLOG2(`MRC_CNTL_FROM_MMC_FIFO_DEPTH)) -1)
`define MRC_CNTL_FROM_MMC_FIFO_LSB            0
`define MRC_CNTL_FROM_MMC_FIFO_SIZE           (`MRC_CNTL_FROM_MMC_FIFO_MSB - `MRC_CNTL_FROM_MMC_FIFO_LSB +1)
`define MRC_CNTL_FROM_MMC_FIFO_RANGE           `MRC_CNTL_FROM_MMC_FIFO_MSB : `MRC_CNTL_FROM_MMC_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_WIDTH    (`MGR_MMC_TO_MRC_INTF_NUM_WORDS*`MGR_EXEC_LANE_WIDTH)
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_MSB      `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_WIDTH-1
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_LSB      0
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_SIZE     (`MRC_CNTL_FROM_MMC_AGGREGATE_DATA_MSB - `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_LSB +1)
`define MRC_CNTL_FROM_MMC_AGGREGATE_DATA_RANGE     `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_MSB : `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_LSB

`define MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_MSB      (`MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB+`COMMON_STD_INTF_CNTL_WIDTH) -1
`define MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB      `MRC_CNTL_FROM_MMC_AGGREGATE_DATA_MSB+1
`define MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_SIZE     (`MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_MSB - `MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB +1)
`define MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_RANGE     `MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_MSB : `MRC_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB

`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH \
                                                   +`MRC_CNTL_FROM_MMC_AGGREGATE_DATA_WIDTH

`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_MSB            `MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_WIDTH -1
`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_LSB            0
`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_SIZE           (`MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_MSB - `MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_LSB +1)
`define MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_RANGE           `MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_MSB : `MRC_CNTL_FROM_MMC_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MRC_CNTL_FROM_MMC_FIFO_ALMOST_FULL_THRESHOLD 4


//--------------------------------------------------------
//--------------------------------------------------------
// Desc fsm to From MMC

`define MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH         128
`define MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH_MSB      (`MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH) -1
`define MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH_LSB      0
`define MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH_SIZE     (`MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH_MSB - `MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH_LSB +1)
`define MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH_RANGE     `MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH_MSB : `MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH_LSB
`define MRC_CNTL_CJ_TO_STRM_FIFO_MSB            ((`CLOG2(`MRC_CNTL_CJ_TO_STRM_FIFO_DEPTH)) -1)
`define MRC_CNTL_CJ_TO_STRM_FIFO_LSB            0
`define MRC_CNTL_CJ_TO_STRM_FIFO_SIZE           (`MRC_CNTL_CJ_TO_STRM_FIFO_MSB - `MRC_CNTL_CJ_TO_STRM_FIFO_LSB +1)
`define MRC_CNTL_CJ_TO_STRM_FIFO_RANGE           `MRC_CNTL_CJ_TO_STRM_FIFO_MSB : `MRC_CNTL_CJ_TO_STRM_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_WIDTH    `MGR_INST_CONS_JUMP_WIDTH
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_MSB      `MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_WIDTH-1
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_LSB      0
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_SIZE     (`MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_MSB - `MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_LSB +1)
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_RANGE     `MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_MSB : `MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_LSB

`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_MSB      (`MRC_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_LSB+`COMMON_STD_INTF_CNTL_WIDTH) -1
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_LSB      `MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_MSB+1
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_SIZE     (`MRC_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_MSB - `MRC_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_LSB +1)
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_RANGE     `MRC_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_MSB : `MRC_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_LSB

`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH \
                                                   +`MRC_CNTL_CJ_TO_STRM_AGGREGATE_DATA_WIDTH

`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_MSB            `MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_WIDTH -1
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_LSB            0
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_SIZE           (`MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_MSB - `MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_LSB +1)
`define MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_RANGE           `MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_MSB : `MRC_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_LSB

`define MRC_CNTL_CJ_TO_STRM_FIFO_ALMOST_FULL_THRESHOLD 4

//------------------------------------------------------------------------------------------------------------
// 
`define MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH         64
`define MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH_MSB      (`MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH) -1
`define MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH_LSB      0
`define MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH_SIZE     (`MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH_MSB - `MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH_LSB +1)
`define MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH_RANGE     `MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH_MSB : `MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH_LSB
`define MRC_CNTL_ADDR_TO_STRM_FIFO_MSB            ((`CLOG2(`MRC_CNTL_ADDR_TO_STRM_FIFO_DEPTH)) -1)
`define MRC_CNTL_ADDR_TO_STRM_FIFO_LSB            0
`define MRC_CNTL_ADDR_TO_STRM_FIFO_SIZE           (`MRC_CNTL_ADDR_TO_STRM_FIFO_MSB - `MRC_CNTL_ADDR_TO_STRM_FIFO_LSB +1)
`define MRC_CNTL_ADDR_TO_STRM_FIFO_RANGE           `MRC_CNTL_ADDR_TO_STRM_FIFO_MSB : `MRC_CNTL_ADDR_TO_STRM_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_WIDTH    `MGR_DRAM_LOCAL_ADDRESS_WIDTH 
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_MSB      `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_WIDTH-1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_LSB      0
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_SIZE     (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_MSB - `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_LSB +1)
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_RANGE     `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_MSB : `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_LSB

`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_WIDTH      `MGR_INST_OPTION_ORDER_WIDTH
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_MSB      (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_LSB+`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_WIDTH) -1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_LSB      `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_MSB+1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_SIZE     (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_MSB - `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_LSB +1)
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_RANGE     `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_MSB : `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_LSB

`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_WIDTH      `MGR_INST_OPTION_TGT_WIDTH
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_MSB      (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_LSB+`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_WIDTH) -1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_LSB      `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_MSB+1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_SIZE     (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_MSB - `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_LSB +1)
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_RANGE     `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_MSB : `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_LSB

`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_WIDTH      `MGR_INST_OPTION_TRANSFER_WIDTH
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_MSB      (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_LSB+`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_WIDTH) -1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_LSB      `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_MSB+1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_SIZE     (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_MSB - `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_LSB +1)
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_RANGE     `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_MSB : `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_LSB

`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_WIDTH      `MGR_NUM_LANES_WIDTH
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_MSB      (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_LSB+`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_WIDTH) -1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_LSB      `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_MSB+1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_SIZE     (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_MSB - `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_LSB +1)
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_RANGE     `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_MSB : `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_LSB

`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_WIDTH      `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_WIDTH \
                                                      + `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_WIDTH  \
                                                      + `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_WIDTH       \
                                                      + `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_WIDTH     \
                                                      + `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_WIDTH

`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_MSB            `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_WIDTH -1
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_LSB            0
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_SIZE           (`MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_MSB - `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_LSB +1)
`define MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_RANGE           `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_MSB : `MRC_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_LSB

`define MRC_CNTL_ADDR_TO_STRM_FIFO_ALMOST_FULL_THRESHOLD 4
//------------------------------------------------------------------------------------------------------------

`endif
