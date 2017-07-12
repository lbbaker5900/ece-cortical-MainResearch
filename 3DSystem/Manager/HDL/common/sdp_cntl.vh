`ifndef _sdp_cntl_vh
`define _sdp_cntl_vh

/*****************************************************************

    File name   : sdp_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : July 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


  
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FSM's
//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// Storage Descriptor Extract FSM

`define SCP_CNTL_EXTRACT_DESC_WAIT                         5'b0_0001
                                                 
`define SCP_CNTL_EXTRACT_DESC_EXTRACT                      5'b0_0010
`define SCP_CNTL_EXTRACT_DESC_START_PROCESSING             5'b0_0100
`define SCP_CNTL_EXTRACT_DESC_COMPLETE                     5'b0_1000
                                                  
`define SCP_CNTL_EXTRACT_DESC_ERR                          5'b1_0000

`define SCP_CNTL_EXTRACT_DESC_STATE_WIDTH         5
`define SCP_CNTL_EXTRACT_DESC_STATE_MSB           `SCP_CNTL_EXTRACT_DESC_STATE_WIDTH-1
`define SCP_CNTL_EXTRACT_DESC_STATE_LSB           0
`define SCP_CNTL_EXTRACT_DESC_STATE_SIZE          (`SCP_CNTL_EXTRACT_DESC_STATE_MSB - `SCP_CNTL_EXTRACT_DESC_STATE_LSB +1)
`define SCP_CNTL_EXTRACT_DESC_STATE_RANGE          `SCP_CNTL_EXTRACT_DESC_STATE_MSB : `SCP_CNTL_EXTRACT_DESC_STATE_LSB

//--------------------------------------------------------
// Storage Descriptor Process FSM

`define SCP_CNTL_PROC_STORAGE_DESC_WAIT                         16'b0000_0000_0000_0001
                                                 
`define SCP_CNTL_PROC_STORAGE_DESC_EXTRACT                      16'b0000_0000_0000_0010
`define SCP_CNTL_PROC_STORAGE_DESC_READ                         16'b0000_0000_0000_0100
`define SCP_CNTL_PROC_STORAGE_DESC_MEM_OUT_VALID                16'b0000_0000_0000_1000
`define SCP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHA             16'b0000_0000_0001_0000
`define SCP_CNTL_PROC_STORAGE_DESC_GENERATE_REQ_CHB             16'b0000_0000_0010_0000
`define SCP_CNTL_PROC_STORAGE_DESC_CHECK_STRM_FIFO              16'b0000_0000_0100_0000
`define SCP_CNTL_PROC_STORAGE_DESC_CONS_FIELD                   16'b0000_0000_1000_0000
`define SCP_CNTL_PROC_STORAGE_DESC_JUMP_FIELD                   16'b0000_0001_0000_0000
`define SCP_CNTL_PROC_STORAGE_DESC_CALC_NUM_REQS                16'b0000_0010_0000_0000
`define SCP_CNTL_PROC_STORAGE_DESC_INC_PBC                      16'b0000_0100_0000_0000
`define SCP_CNTL_PROC_STORAGE_DESC_WAIT_STREAM_COMPLETE         16'b0000_1000_0000_0000

`define SCP_CNTL_PROC_STORAGE_DESC_COMPLETE                     16'b0100_0000_0000_0000
                                                  
`define SCP_CNTL_PROC_STORAGE_DESC_ERR                          16'b1000_0000_0000_0000

`define SCP_CNTL_PROC_STORAGE_DESC_STATE_WIDTH         16
`define SCP_CNTL_PROC_STORAGE_DESC_STATE_MSB           `SCP_CNTL_PROC_STORAGE_DESC_STATE_WIDTH-1
`define SCP_CNTL_PROC_STORAGE_DESC_STATE_LSB           0
`define SCP_CNTL_PROC_STORAGE_DESC_STATE_SIZE          (`SCP_CNTL_PROC_STORAGE_DESC_STATE_MSB - `SCP_CNTL_PROC_STORAGE_DESC_STATE_LSB +1)
`define SCP_CNTL_PROC_STORAGE_DESC_STATE_RANGE          `SCP_CNTL_PROC_STORAGE_DESC_STATE_MSB : `SCP_CNTL_PROC_STORAGE_DESC_STATE_LSB

//--------------------------------------------------------
// Stream Data FSM

`define SCP_CNTL_STRM_WAIT                    8'b0000_0001

`define SCP_CNTL_STRM_LOAD_FIRST_CONS_COUNT   8'b0000_0010
`define SCP_CNTL_STRM_LOAD_JUMP_VALUE         8'b0000_0100
//`define SCP_CNTL_STRM_CALC_NEXT_START_ADDR    8'b0000_1000
`define SCP_CNTL_STRM_COUNT_CONS              8'b0001_0000

`define SCP_CNTL_STRM_COMPLETE                8'b0100_0000

`define SCP_CNTL_STRM_ERR                     8'b1000_0000

`define SCP_CNTL_STRM_STATE_WIDTH         8
`define SCP_CNTL_STRM_STATE_MSB           `SCP_CNTL_STRM_STATE_WIDTH-1
`define SCP_CNTL_STRM_STATE_LSB           0
`define SCP_CNTL_STRM_STATE_SIZE          (`SCP_CNTL_STRM_STATE_MSB - `SCP_CNTL_STRM_STATE_LSB +1)
`define SCP_CNTL_STRM_STATE_RANGE          `SCP_CNTL_STRM_STATE_MSB : `SCP_CNTL_STRM_STATE_LSB

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// end of FSM's
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// Vector of channels
//  - used to indicate which channel has been opened with the current bank/page
  
`define SCP_CNTL_CHAN_BIT_WIDTH          `MGR_DRAM_NUM_CHANNELS
`define SCP_CNTL_CHAN_BIT_MSB           `SCP_CNTL_CHAN_BIT_WIDTH-1
`define SCP_CNTL_CHAN_BIT_LSB            0
`define SCP_CNTL_CHAN_BIT_SIZE           (`SCP_CNTL_CHAN_BIT_MSB - `SCP_CNTL_CHAN_BIT_LSB +1)
`define SCP_CNTL_CHAN_BIT_RANGE           `SCP_CNTL_CHAN_BIT_MSB : `SCP_CNTL_CHAN_BIT_LSB
//------------------------------------------------------------------------------------------------------------

`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  //--------------------------------------------------------
  // Vector of Lines
  //  - used to indicate which line has been opened with the current chan/bank/page
    
  `define SCP_CNTL_LINE_BIT_WIDTH          `MGR_DRAM_NUM_LINES
  `define SCP_CNTL_LINE_BIT_MSB           `SCP_CNTL_LINE_BIT_WIDTH-1
  `define SCP_CNTL_LINE_BIT_LSB            0
  `define SCP_CNTL_LINE_BIT_SIZE           (`SCP_CNTL_LINE_BIT_MSB - `SCP_CNTL_LINE_BIT_LSB +1)
  `define SCP_CNTL_LINE_BIT_RANGE           `SCP_CNTL_LINE_BIT_MSB : `SCP_CNTL_LINE_BIT_LSB
  //------------------------------------------------------------------------------------------------------------
`endif

//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// When we decrement the consequtive counter, we check for negative, so add bit
`define SCP_CNTL_CONS_COUNTER_WIDTH        `MGR_INST_CONS_JUMP_WIDTH+1
`define SCP_CNTL_CONS_COUNTER_MSB          `SCP_CNTL_CONS_COUNTER_WIDTH-1
`define SCP_CNTL_CONS_COUNTER_LSB          0
`define SCP_CNTL_CONS_COUNTER_SIZE         (`SCP_CNTL_CONS_COUNTER_MSB - `SCP_CNTL_CONS_COUNTER_LSB +1)
`define SCP_CNTL_CONS_COUNTER_RANGE         `SCP_CNTL_CONS_COUNTER_MSB : `SCP_CNTL_CONS_COUNTER_LSB


//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// Number of active lanes is 1..32, so need 6 bits
  
`define SCP_CNTL_NUM_LANES_WIDTH               (`CLOG2(`PE_NUM_OF_EXEC_LANES))+1
`define SCP_CNTL_NUM_LANES_MSB           `SCP_CNTL_NUM_LANES_WIDTH-1
`define SCP_CNTL_NUM_LANES_LSB            0
`define SCP_CNTL_NUM_LANES_SIZE           (`SCP_CNTL_NUM_LANES_MSB - `SCP_CNTL_NUM_LANES_LSB +1)
`define SCP_CNTL_NUM_LANES_RANGE           `SCP_CNTL_NUM_LANES_MSB : `SCP_CNTL_NUM_LANES_LSB
//------------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FIFO's
//------------------------------------------------------------------------------------------------------------

`define SCP_CNTL_DESC_FIFO_DEPTH          16
`define SCP_CNTL_DESC_FIFO_THRESHOLD      4

//--------------------------------------------------------
//--------------------------------------------------------
// From MMC

`define SCP_CNTL_FROM_MMC_FIFO_DEPTH          32
`define SCP_CNTL_FROM_MMC_FIFO_DEPTH_MSB      (`SCP_CNTL_FROM_MMC_FIFO_DEPTH) -1
`define SCP_CNTL_FROM_MMC_FIFO_DEPTH_LSB      0
`define SCP_CNTL_FROM_MMC_FIFO_DEPTH_SIZE     (`SCP_CNTL_FROM_MMC_FIFO_DEPTH_MSB - `SCP_CNTL_FROM_MMC_FIFO_DEPTH_LSB +1)
`define SCP_CNTL_FROM_MMC_FIFO_DEPTH_RANGE     `SCP_CNTL_FROM_MMC_FIFO_DEPTH_MSB : `SCP_CNTL_FROM_MMC_FIFO_DEPTH_LSB
`define SCP_CNTL_FROM_MMC_FIFO_MSB            ((`CLOG2(`SCP_CNTL_FROM_MMC_FIFO_DEPTH)) -1)
`define SCP_CNTL_FROM_MMC_FIFO_LSB            0
`define SCP_CNTL_FROM_MMC_FIFO_SIZE           (`SCP_CNTL_FROM_MMC_FIFO_MSB - `SCP_CNTL_FROM_MMC_FIFO_LSB +1)
`define SCP_CNTL_FROM_MMC_FIFO_RANGE           `SCP_CNTL_FROM_MMC_FIFO_MSB : `SCP_CNTL_FROM_MMC_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define SCP_CNTL_FROM_MMC_AGGREGATE_DATA_WIDTH    (`MGR_MMC_TO_MRC_INTF_NUM_WORDS*`MGR_EXEC_LANE_WIDTH)
`define SCP_CNTL_FROM_MMC_AGGREGATE_DATA_MSB      `SCP_CNTL_FROM_MMC_AGGREGATE_DATA_WIDTH-1
`define SCP_CNTL_FROM_MMC_AGGREGATE_DATA_LSB      0
`define SCP_CNTL_FROM_MMC_AGGREGATE_DATA_SIZE     (`SCP_CNTL_FROM_MMC_AGGREGATE_DATA_MSB - `SCP_CNTL_FROM_MMC_AGGREGATE_DATA_LSB +1)
`define SCP_CNTL_FROM_MMC_AGGREGATE_DATA_RANGE     `SCP_CNTL_FROM_MMC_AGGREGATE_DATA_MSB : `SCP_CNTL_FROM_MMC_AGGREGATE_DATA_LSB

`define SCP_CNTL_FROM_MMC_AGGREGATE_CNTL_MSB      (`SCP_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB+`COMMON_STD_INTF_CNTL_WIDTH) -1
`define SCP_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB      `SCP_CNTL_FROM_MMC_AGGREGATE_DATA_MSB+1
`define SCP_CNTL_FROM_MMC_AGGREGATE_CNTL_SIZE     (`SCP_CNTL_FROM_MMC_AGGREGATE_CNTL_MSB - `SCP_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB +1)
`define SCP_CNTL_FROM_MMC_AGGREGATE_CNTL_RANGE     `SCP_CNTL_FROM_MMC_AGGREGATE_CNTL_MSB : `SCP_CNTL_FROM_MMC_AGGREGATE_CNTL_LSB

`define SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH \
                                                   +`SCP_CNTL_FROM_MMC_AGGREGATE_DATA_WIDTH

`define SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_MSB            `SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_WIDTH -1
`define SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_LSB            0
`define SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_SIZE           (`SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_MSB - `SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_LSB +1)
`define SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_RANGE           `SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_MSB : `SCP_CNTL_FROM_MMC_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define SCP_CNTL_FROM_MMC_FIFO_ALMOST_FULL_THRESHOLD 4


//--------------------------------------------------------
//--------------------------------------------------------
// Desc fsm to From MMC

`define SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH         128
`define SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH_MSB      (`SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH) -1
`define SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH_LSB      0
`define SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH_SIZE     (`SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH_MSB - `SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH_LSB +1)
`define SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH_RANGE     `SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH_MSB : `SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH_LSB
`define SCP_CNTL_CJ_TO_STRM_FIFO_MSB            ((`CLOG2(`SCP_CNTL_CJ_TO_STRM_FIFO_DEPTH)) -1)
`define SCP_CNTL_CJ_TO_STRM_FIFO_LSB            0
`define SCP_CNTL_CJ_TO_STRM_FIFO_SIZE           (`SCP_CNTL_CJ_TO_STRM_FIFO_MSB - `SCP_CNTL_CJ_TO_STRM_FIFO_LSB +1)
`define SCP_CNTL_CJ_TO_STRM_FIFO_RANGE           `SCP_CNTL_CJ_TO_STRM_FIFO_MSB : `SCP_CNTL_CJ_TO_STRM_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_WIDTH    `MGR_INST_CONS_JUMP_WIDTH
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_MSB      `SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_WIDTH-1
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_LSB      0
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_SIZE     (`SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_MSB - `SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_LSB +1)
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_RANGE     `SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_MSB : `SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_LSB

`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_MSB      (`SCP_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_LSB+`COMMON_STD_INTF_CNTL_WIDTH) -1
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_LSB      `SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_MSB+1
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_SIZE     (`SCP_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_MSB - `SCP_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_LSB +1)
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_RANGE     `SCP_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_MSB : `SCP_CNTL_CJ_TO_STRM_AGGREGATE_CNTL_LSB

`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH \
                                                   +`SCP_CNTL_CJ_TO_STRM_AGGREGATE_DATA_WIDTH

`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_MSB            `SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_WIDTH -1
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_LSB            0
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_SIZE           (`SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_MSB - `SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_LSB +1)
`define SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_RANGE           `SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_MSB : `SCP_CNTL_CJ_TO_STRM_AGGREGATE_FIFO_LSB

`define SCP_CNTL_CJ_TO_STRM_FIFO_ALMOST_FULL_THRESHOLD 4

//------------------------------------------------------------------------------------------------------------
// 
`define SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH         64
`define SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH_MSB      (`SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH) -1
`define SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH_LSB      0
`define SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH_SIZE     (`SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH_MSB - `SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH_LSB +1)
`define SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH_RANGE     `SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH_MSB : `SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH_LSB
`define SCP_CNTL_ADDR_TO_STRM_FIFO_MSB            ((`CLOG2(`SCP_CNTL_ADDR_TO_STRM_FIFO_DEPTH)) -1)
`define SCP_CNTL_ADDR_TO_STRM_FIFO_LSB            0
`define SCP_CNTL_ADDR_TO_STRM_FIFO_SIZE           (`SCP_CNTL_ADDR_TO_STRM_FIFO_MSB - `SCP_CNTL_ADDR_TO_STRM_FIFO_LSB +1)
`define SCP_CNTL_ADDR_TO_STRM_FIFO_RANGE           `SCP_CNTL_ADDR_TO_STRM_FIFO_MSB : `SCP_CNTL_ADDR_TO_STRM_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_WIDTH    `MGR_DRAM_LOCAL_ADDRESS_WIDTH 
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_MSB      `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_WIDTH-1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_LSB      0
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_SIZE     (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_MSB - `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_LSB +1)
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_RANGE     `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_MSB : `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_LSB

`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_WIDTH      `MGR_INST_OPTION_ORDER_WIDTH
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_MSB      (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_LSB+`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_WIDTH) -1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_LSB      `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_MSB+1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_SIZE     (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_MSB - `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_LSB +1)
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_RANGE     `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_MSB : `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_LSB

`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_WIDTH      `MGR_INST_OPTION_TGT_WIDTH
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_MSB      (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_LSB+`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_WIDTH) -1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_LSB      `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_MSB+1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_SIZE     (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_MSB - `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_LSB +1)
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_RANGE     `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_MSB : `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_LSB

`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_WIDTH      `MGR_INST_OPTION_TRANSFER_WIDTH
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_MSB      (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_LSB+`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_WIDTH) -1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_LSB      `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_MSB+1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_SIZE     (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_MSB - `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_LSB +1)
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_RANGE     `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_MSB : `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_LSB

`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_WIDTH      `MGR_NUM_LANES_WIDTH
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_MSB      (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_LSB+`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_WIDTH) -1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_LSB      `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_MSB+1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_SIZE     (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_MSB - `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_LSB +1)
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_RANGE     `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_MSB : `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_LSB

`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_WIDTH      `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_NUM_LANES_WIDTH \
                                                      + `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TRANSFER_WIDTH  \
                                                      + `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_TGT_WIDTH       \
                                                      + `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ORDER_WIDTH     \
                                                      + `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_ADDR_WIDTH

`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_MSB            `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_WIDTH -1
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_LSB            0
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_SIZE           (`SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_MSB - `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_LSB +1)
`define SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_RANGE           `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_MSB : `SCP_CNTL_ADDR_TO_STRM_AGGREGATE_FIFO_LSB

`define SCP_CNTL_ADDR_TO_STRM_FIFO_ALMOST_FULL_THRESHOLD 4
//------------------------------------------------------------------------------------------------------------

`endif
