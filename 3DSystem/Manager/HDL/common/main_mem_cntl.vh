`ifndef _main_mem_cntl_vh
`define _main_mem_cntl_vh

/*****************************************************************

    File name   : main_mem_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


  
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FSM's
//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------

//--------------------------------------------------------
// DRAM Command generation FSM
//  - take memory requests and determine how many commands associated with each request
//  - If read with nothing open, generate PO-CR
//  - If read with mismatched open page, generate PC-PO-CR
//  - read to open page, generate CR
//  etc.
// 

`define MMC_CNTL_CMD_GEN_WAIT                        9'b0_0000_0001
`define MMC_CNTL_CMD_GEN_DECODE_SEQUENCE             9'b0_0000_0010
`define MMC_CNTL_CMD_GEN_PC                          9'b0_0000_0100
`define MMC_CNTL_CMD_GEN_PO                          9'b0_0000_1000
//`define MMC_CNTL_CMD_GEN_POCR                        9'b0_0000_1000  // may be better to write in both commands simultaneously
//`define MMC_CNTL_CMD_GEN_POCW                        9'b0_0001_0000
`define MMC_CNTL_CMD_GEN_CR                          9'b0_0010_0000
`define MMC_CNTL_CMD_GEN_CW                          9'b0_0100_0000
`define MMC_CNTL_CMD_GEN_PR                          9'b0_1000_0000
`define MMC_CNTL_CMD_GEN_ERR                         9'b1_0000_0000


`define MMC_CNTL_CMD_GEN_STATE_WIDTH         8
`define MMC_CNTL_CMD_GEN_STATE_MSB           `MMC_CNTL_CMD_GEN_STATE_WIDTH-1
`define MMC_CNTL_CMD_GEN_STATE_LSB           0
`define MMC_CNTL_CMD_GEN_STATE_SIZE          (`MMC_CNTL_CMD_GEN_STATE_MSB - `MMC_CNTL_CMD_GEN_STATE_LSB +1)
`define MMC_CNTL_CMD_GEN_STATE_RANGE          `MMC_CNTL_CMD_GEN_STATE_MSB : `MMC_CNTL_CMD_GEN_STATE_LSB

`define MMC_CNTL_CMD_GEN_TAG_WIDTH         6  // FIXME  - can be shorter  ??
`define MMC_CNTL_CMD_GEN_TAG_MSB           `MMC_CNTL_CMD_GEN_TAG_WIDTH-1
`define MMC_CNTL_CMD_GEN_TAG_LSB           0
`define MMC_CNTL_CMD_GEN_TAG_SIZE          (`MMC_CNTL_CMD_GEN_TAG_MSB - `MMC_CNTL_CMD_GEN_TAG_LSB +1)
`define MMC_CNTL_CMD_GEN_TAG_RANGE          `MMC_CNTL_CMD_GEN_TAG_MSB : `MMC_CNTL_CMD_GEN_TAG_LSB

//--------------------------------------------------------
// Command Sequence Validate FSM
//  - ensures the commands in the command sequence fifos can_go
// 

`define MMC_CNTL_CMD_CHECK_WAIT                            8'b0000_0001
`define MMC_CNTL_CMD_CHECK_PAGE_CMD                        8'b0000_0010
`define MMC_CNTL_CMD_CHECK_CACHE_CMD                       8'b0000_0100
                                                               
`define MMC_CNTL_CMD_CHECK_ERR                             8'b1000_0000

`define MMC_CNTL_CMD_CHECK_STATE_WIDTH         8
`define MMC_CNTL_CMD_CHECK_STATE_MSB           `MMC_CNTL_CMD_CHECK_STATE_WIDTH-1
`define MMC_CNTL_CMD_CHECK_STATE_LSB           0
`define MMC_CNTL_CMD_CHECK_STATE_SIZE          (`MMC_CNTL_CMD_CHECK_STATE_MSB - `MMC_CNTL_CMD_CHECK_STATE_LSB +1)
`define MMC_CNTL_CMD_CHECK_STATE_RANGE          `MMC_CNTL_CMD_CHECK_STATE_MSB : `MMC_CNTL_CMD_CHECK_STATE_LSB

//--------------------------------------------------------
// DFI sequence FSM
//  - read page and rw commands from command fifo's and make sure we follow the DDR protocol for DiRAM4
// 

`define MMC_CNTL_DFI_SEQ_WAIT                            12'b0000_0000_0001
`define MMC_CNTL_DFI_SEQ_PAGE_CMD                        12'b0000_0000_0010
`define MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA           12'b0000_0000_0100
`define MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD                    12'b0000_0000_1000
`define MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA       12'b0000_0001_0000
`define MMC_CNTL_DFI_SEQ_RD_CMD                          12'b0000_0010_0000
`define MMC_CNTL_DFI_SEQ_WR_CMD                          12'b0000_0100_0000
`define MMC_CNTL_DFI_SEQ_NOP_RW_CMD                      12'b0000_1000_0000

`define MMC_CNTL_DFI_SEQ_ERR                             12'b1000_0000_0000

`define MMC_CNTL_DFI_SEQ_STATE_WIDTH         12
`define MMC_CNTL_DFI_SEQ_STATE_MSB           `MMC_CNTL_DFI_SEQ_STATE_WIDTH-1
`define MMC_CNTL_DFI_SEQ_STATE_LSB           0
`define MMC_CNTL_DFI_SEQ_STATE_SIZE          (`MMC_CNTL_DFI_SEQ_STATE_MSB - `MMC_CNTL_DFI_SEQ_STATE_LSB +1)
`define MMC_CNTL_DFI_SEQ_STATE_RANGE          `MMC_CNTL_DFI_SEQ_STATE_MSB : `MMC_CNTL_DFI_SEQ_STATE_LSB

//--------------------------------------------------------
// Stream select FSM
//  - select which stream should gain access to the channel
// 

`define MMC_CNTL_STRM_SEL_WAIT                            8'b0000_0001
`define MMC_CNTL_STRM_SEL_STRM0                           8'b0000_0010
`define MMC_CNTL_STRM_SEL_STRM1                           8'b0000_0100
`define MMC_CNTL_STRM_SEL_STRM01                          8'b0000_1000
`define MMC_CNTL_STRM_SEL_STRM10                          8'b0001_0000
`define MMC_CNTL_STRM_SEL_SEND0_NEXT                      8'b0010_0000
`define MMC_CNTL_STRM_SEL_SEND1_NEXT                      8'b0100_0000
                                                               
`define MMC_CNTL_STRM_SEL_ERR                             8'b1000_0000

`define MMC_CNTL_STRM_SEL_STATE_WIDTH         8
`define MMC_CNTL_STRM_SEL_STATE_MSB           `MMC_CNTL_STRM_SEL_STATE_WIDTH-1
`define MMC_CNTL_STRM_SEL_STATE_LSB           0
`define MMC_CNTL_STRM_SEL_STATE_SIZE          (`MMC_CNTL_STRM_SEL_STATE_MSB - `MMC_CNTL_STRM_SEL_STATE_LSB +1)
`define MMC_CNTL_STRM_SEL_STATE_RANGE          `MMC_CNTL_STRM_SEL_STATE_MSB : `MMC_CNTL_STRM_SEL_STATE_LSB

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// end of FSM's
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------



//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FIFO's
//------------------------------------------------------------------------------------------------------------


//--------------------------------------------------------
//--------------------------------------------------------
// From MRC

`define MMC_CNTL_REQUEST_FIFO_DEPTH          8
`define MMC_CNTL_REQUEST_FIFO_DEPTH_MSB      (`MMC_CNTL_REQUEST_FIFO_DEPTH) -1
`define MMC_CNTL_REQUEST_FIFO_DEPTH_LSB      0
`define MMC_CNTL_REQUEST_FIFO_DEPTH_SIZE     (`MMC_CNTL_REQUEST_FIFO_DEPTH_MSB - `MMC_CNTL_REQUEST_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_REQUEST_FIFO_DEPTH_RANGE     `MMC_CNTL_REQUEST_FIFO_DEPTH_MSB : `MMC_CNTL_REQUEST_FIFO_DEPTH_LSB
`define MMC_CNTL_REQUEST_FIFO_MSB            ((`CLOG2(`MMC_CNTL_REQUEST_FIFO_DEPTH)) -1)
`define MMC_CNTL_REQUEST_FIFO_LSB            0
`define MMC_CNTL_REQUEST_FIFO_SIZE           (`MMC_CNTL_REQUEST_FIFO_MSB - `MMC_CNTL_REQUEST_FIFO_LSB +1)
`define MMC_CNTL_REQUEST_FIFO_RANGE           `MMC_CNTL_REQUEST_FIFO_MSB : `MMC_CNTL_REQUEST_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MMC_CNTL_REQUEST_AGGREGATE_WORD_WIDTH                       `MGR_DRAM_WORD_ADDRESS_WIDTH
`define MMC_CNTL_REQUEST_AGGREGATE_WORD_LSB                         2  // account for byte address
`define MMC_CNTL_REQUEST_AGGREGATE_WORD_MSB                         `MMC_CNTL_REQUEST_AGGREGATE_WORD_LSB+`MMC_CNTL_REQUEST_AGGREGATE_WORD_WIDTH-1
`define MMC_CNTL_REQUEST_AGGREGATE_WORD_SIZE                        (`MMC_CNTL_REQUEST_AGGREGATE_WORD_MSB - `MMC_CNTL_REQUEST_AGGREGATE_WORD_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_WORD_RANGE                        `MMC_CNTL_REQUEST_AGGREGATE_WORD_MSB : `MMC_CNTL_REQUEST_AGGREGATE_WORD_LSB

`define MMC_CNTL_REQUEST_AGGREGATE_PAGE_WIDTH                       `MGR_DRAM_PAGE_ADDRESS_WIDTH
`define MMC_CNTL_REQUEST_AGGREGATE_PAGE_LSB                         `MMC_CNTL_REQUEST_AGGREGATE_WORD_MSB+1
`define MMC_CNTL_REQUEST_AGGREGATE_PAGE_MSB                         `MMC_CNTL_REQUEST_AGGREGATE_PAGE_LSB+`MMC_CNTL_REQUEST_AGGREGATE_PAGE_WIDTH-1
`define MMC_CNTL_REQUEST_AGGREGATE_PAGE_SIZE                        (`MMC_CNTL_REQUEST_AGGREGATE_PAGE_MSB - `MMC_CNTL_REQUEST_AGGREGATE_PAGE_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_PAGE_RANGE                        `MMC_CNTL_REQUEST_AGGREGATE_PAGE_MSB : `MMC_CNTL_REQUEST_AGGREGATE_PAGE_LSB

`define MMC_CNTL_REQUEST_AGGREGATE_BANK_WIDTH                       `MGR_DRAM_BANK_ADDRESS_WIDTH
`define MMC_CNTL_REQUEST_AGGREGATE_BANK_LSB                         `MMC_CNTL_REQUEST_AGGREGATE_PAGE_MSB+1
`define MMC_CNTL_REQUEST_AGGREGATE_BANK_MSB                         `MMC_CNTL_REQUEST_AGGREGATE_BANK_LSB+`MMC_CNTL_REQUEST_AGGREGATE_BANK_WIDTH-1
`define MMC_CNTL_REQUEST_AGGREGATE_BANK_SIZE                        (`MMC_CNTL_REQUEST_AGGREGATE_BANK_MSB - `MMC_CNTL_REQUEST_AGGREGATE_BANK_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_BANK_RANGE                        `MMC_CNTL_REQUEST_AGGREGATE_BANK_MSB : `MMC_CNTL_REQUEST_AGGREGATE_BANK_LSB

`define MMC_CNTL_REQUEST_AGGREGATE_CHAN_WIDTH                       `MGR_DRAM_CHANNEL_ADDRESS_WIDTH
`define MMC_CNTL_REQUEST_AGGREGATE_CHAN_LSB                         `MMC_CNTL_REQUEST_AGGREGATE_BANK_MSB+1
`define MMC_CNTL_REQUEST_AGGREGATE_CHAN_MSB                         `MMC_CNTL_REQUEST_AGGREGATE_CHAN_LSB+`MMC_CNTL_REQUEST_AGGREGATE_CHAN_WIDTH-1
`define MMC_CNTL_REQUEST_AGGREGATE_CHAN_SIZE                        (`MMC_CNTL_REQUEST_AGGREGATE_CHAN_MSB - `MMC_CNTL_REQUEST_AGGREGATE_CHAN_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_CHAN_RANGE                        `MMC_CNTL_REQUEST_AGGREGATE_CHAN_MSB : `MMC_CNTL_REQUEST_AGGREGATE_CHAN_LSB

`define MMC_CNTL_REQUEST_AGGREGATE_IS_READ_WIDTH                       1
`define MMC_CNTL_REQUEST_AGGREGATE_IS_READ_LSB                         `MMC_CNTL_REQUEST_AGGREGATE_CHAN_MSB+1
`define MMC_CNTL_REQUEST_AGGREGATE_IS_READ_MSB                         `MMC_CNTL_REQUEST_AGGREGATE_IS_READ_LSB+`MMC_CNTL_REQUEST_AGGREGATE_IS_READ_WIDTH-1
`define MMC_CNTL_REQUEST_AGGREGATE_IS_READ_SIZE                        (`MMC_CNTL_REQUEST_AGGREGATE_IS_READ_MSB - `MMC_CNTL_REQUEST_AGGREGATE_IS_READ_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_IS_READ_RANGE                        `MMC_CNTL_REQUEST_AGGREGATE_IS_READ_MSB : `MMC_CNTL_REQUEST_AGGREGATE_IS_READ_LSB

`define MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_WIDTH                       1
`define MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_LSB                         `MMC_CNTL_REQUEST_AGGREGATE_IS_READ_MSB+1
`define MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_MSB                         `MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_LSB+`MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_WIDTH-1
`define MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_SIZE                        (`MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_MSB - `MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_RANGE                        `MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_MSB : `MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_LSB

`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH    `COMMON_STD_INTF_CNTL_WIDTH                  \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_WORD_WIDTH      \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_PAGE_WIDTH      \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_BANK_WIDTH      \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_CHAN_WIDTH      \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_IS_READ_WIDTH   \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_WIDTH 

`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_MSB            `MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_REQUEST_AGGREGATE_FIFO_MSB - `MMC_CNTL_REQUEST_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_RANGE           `MMC_CNTL_REQUEST_AGGREGATE_FIFO_MSB : `MMC_CNTL_REQUEST_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_REQUEST_FIFO_ALMOST_FULL_THRESHOLD 4


//--------------------------------------------------------
// From Command page sequence FSM

`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH          8
`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH_MSB      (`MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH) -1
`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH_LSB      0
`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH_SIZE     (`MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH_MSB - `MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH_RANGE     `MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH_MSB : `MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH_LSB
`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_MSB            ((`CLOG2(`MMC_CNTL_PAGE_CMD_SEQ_FIFO_DEPTH)) -1)
`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_LSB            0
`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_SIZE           (`MMC_CNTL_PAGE_CMD_SEQ_FIFO_MSB - `MMC_CNTL_PAGE_CMD_SEQ_FIFO_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_RANGE           `MMC_CNTL_PAGE_CMD_SEQ_FIFO_MSB : `MMC_CNTL_PAGE_CMD_SEQ_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_WIDTH                       `MGR_DRAM_PAGE_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_LSB                         0
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_LSB+`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_MSB - `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_MSB : `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_WIDTH                       `MGR_DRAM_BANK_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_LSB+`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_MSB - `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_MSB : `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_WIDTH                       `DRAM_ACC_NUM_OF_CMDS_WIDTH 
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_LSB+`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_MSB - `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_MSB : `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_WIDTH                       `MMC_CNTL_CMD_GEN_TAG_WIDTH 
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_LSB+`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_MSB - `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_MSB : `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_WIDTH                       `MGR_STREAM_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_IS_READ_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_LSB+`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_MSB - `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_MSB : `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_LSB


`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_WIDTH     `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_PAGE_WIDTH      \
                                                      +`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_BANK_WIDTH      \
                                                      +`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_DRAM_CMD_WIDTH  \
                                                      +`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_TAG_WIDTH       \
                                                      +`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_STRM_WIDTH 

`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_MSB            `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_MSB - `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_RANGE           `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_MSB : `MMC_CNTL_PAGE_CMD_SEQ_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_PAGE_CMD_SEQ_FIFO_ALMOST_FULL_THRESHOLD 4




//--------------------------------------------------------
// From Command cache sequence FSM

`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH          8
`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH_MSB      (`MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH) -1
`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH_LSB      0
`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH_SIZE     (`MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH_MSB - `MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH_RANGE     `MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH_MSB : `MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH_LSB
`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_MSB            ((`CLOG2(`MMC_CNTL_CACHE_CMD_SEQ_FIFO_DEPTH)) -1)
`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_LSB            0
`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_SIZE           (`MMC_CNTL_CACHE_CMD_SEQ_FIFO_MSB - `MMC_CNTL_CACHE_CMD_SEQ_FIFO_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_RANGE           `MMC_CNTL_CACHE_CMD_SEQ_FIFO_MSB : `MMC_CNTL_CACHE_CMD_SEQ_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_WIDTH                       `MGR_DRAM_LINE_ADDRESS_WIDTH 
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_LSB                         0
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_MSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_LSB+`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_WIDTH-1
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_SIZE                        (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_LSB +1)
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_RANGE                        `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_LSB
`else
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_MSB                       -1
`endif

`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_WIDTH                       `MGR_DRAM_PAGE_ADDRESS_WIDTH
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_LSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_MSB+1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_MSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_LSB+`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_WIDTH-1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_SIZE                        (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_RANGE                        `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_LSB

`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_WIDTH                       `MGR_DRAM_BANK_ADDRESS_WIDTH
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_LSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_MSB+1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_MSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_LSB+`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_WIDTH-1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_SIZE                        (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_RANGE                        `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_LSB

`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_WIDTH                       `DRAM_ACC_NUM_OF_CMDS_WIDTH 
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_LSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_MSB+1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_MSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_LSB+`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_WIDTH-1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_SIZE                        (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_RANGE                        `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_LSB

`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_WIDTH                       `MMC_CNTL_CMD_GEN_TAG_WIDTH
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_LSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_MSB+1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_MSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_LSB+`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_WIDTH-1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_SIZE                        (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_RANGE                        `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_LSB

`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_WIDTH                       `MGR_STREAM_ADDRESS_WIDTH
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_LSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_IS_READ_MSB+1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_MSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_LSB+`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_RANGE                        `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_LSB


`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_WIDTH     `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_WIDTH \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_WIDTH      \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_WIDTH      \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_WIDTH  \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_WIDTH       \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_WIDTH 
`else
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_WIDTH     `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_WIDTH      \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_WIDTH      \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_WIDTH  \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_WIDTH       \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_WIDTH 
`endif

`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_MSB            `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_RANGE           `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_CACHE_CMD_SEQ_FIFO_ALMOST_FULL_THRESHOLD 4




//--------------------------------------------------------
//--------------------------------------------------------
//Final Page Command FIFO

`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_WIDTH         2
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_MSB           `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_WIDTH-1
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_LSB           0
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_SIZE          (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_MSB - `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_LSB +1)
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_RANGE          `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_MSB : `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_LSB

`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_NOP        0
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PO         1
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PC         2
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_TYPE_PR         3


`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH          8
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH_MSB      (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH) -1
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH_LSB      0
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH_SIZE     (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH_MSB - `MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH_RANGE     `MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH_MSB : `MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH_LSB
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_MSB            ((`CLOG2(`MMC_CNTL_PAGE_CMD_FINAL_FIFO_DEPTH)) -1)
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_LSB            0
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_SIZE           (`MMC_CNTL_PAGE_CMD_FINAL_FIFO_MSB - `MMC_CNTL_PAGE_CMD_FINAL_FIFO_LSB +1)
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_RANGE           `MMC_CNTL_PAGE_CMD_FINAL_FIFO_MSB : `MMC_CNTL_PAGE_CMD_FINAL_FIFO_LSB


`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_WIDTH                       `MGR_DRAM_PAGE_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_LSB                         0
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_MSB                         `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_LSB+`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_WIDTH-1
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_SIZE                        (`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_MSB - `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_LSB +1)
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_RANGE                        `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_MSB : `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_LSB

`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_WIDTH                       `MGR_DRAM_BANK_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_LSB                         `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_MSB+1
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_MSB                         `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_LSB+`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_WIDTH-1
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_SIZE                        (`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_MSB - `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_LSB +1)
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_RANGE                        `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_MSB : `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_LSB

`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_WIDTH                       `MMC_CNTL_PAGE_CMD_FINAL_FIFO_CMD_WIDTH 
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_LSB                         `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_MSB+1
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_MSB                         `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_LSB+`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_WIDTH-1
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_SIZE                        (`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_MSB - `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_LSB +1)
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_RANGE                        `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_MSB : `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_LSB

`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_WIDTH                       `MGR_STREAM_ADDRESS_WIDTH 
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_LSB                         `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_MSB+1
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_MSB                         `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_LSB+`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_MSB - `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_RANGE                        `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_MSB : `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_LSB


`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_WIDTH    `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_WIDTH   \
                                                       +`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_WIDTH   \
                                                       +`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_WIDTH    \
                                                       +`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_WIDTH   

`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_MSB            `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_MSB - `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_RANGE           `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_MSB : `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_PAGE_CMD_FINAL_FIFO_ALMOST_FULL_THRESHOLD 4


//--------------------------------------------------------
//--------------------------------------------------------
//Final Cache Command FIFO

`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_WIDTH         2
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_MSB           `MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_WIDTH-1
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_LSB           0
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_SIZE          (`MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_MSB - `MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_LSB +1)
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_RANGE          `MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_MSB : `MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_LSB

`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_NOP        0
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CR         1
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_TYPE_CW         2


`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH          8
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH_MSB      (`MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH) -1
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH_LSB      0
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH_SIZE     (`MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH_MSB - `MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH_RANGE     `MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH_MSB : `MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH_LSB
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_MSB            ((`CLOG2(`MMC_CNTL_CACHE_CMD_FINAL_FIFO_DEPTH)) -1)
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_LSB            0
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_SIZE           (`MMC_CNTL_CACHE_CMD_FINAL_FIFO_MSB - `MMC_CNTL_CACHE_CMD_FINAL_FIFO_LSB +1)
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_RANGE           `MMC_CNTL_CACHE_CMD_FINAL_FIFO_MSB : `MMC_CNTL_CACHE_CMD_FINAL_FIFO_LSB


`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_WIDTH                       `MGR_DRAM_LINE_ADDRESS_WIDTH 
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_LSB                         0
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_MSB                         `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_LSB+`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_WIDTH-1
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_SIZE                        (`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_MSB - `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_LSB +1)
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_RANGE                        `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_MSB : `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_LSB
`else
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_MSB                       -1
`endif

`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_WIDTH                       `MGR_DRAM_BANK_ADDRESS_WIDTH
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_LSB                         `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_MSB+1
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_MSB                         `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_LSB+`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_WIDTH-1
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_SIZE                        (`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_MSB - `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_LSB +1)
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_RANGE                        `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_MSB : `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_LSB

`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_WIDTH                       `MMC_CNTL_CACHE_CMD_FINAL_FIFO_CMD_WIDTH
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_LSB                         `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_MSB+1
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_MSB                         `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_LSB+`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_WIDTH-1
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_SIZE                        (`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_MSB - `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_LSB +1)
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_RANGE                        `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_MSB : `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_LSB

`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_WIDTH                       `MGR_STREAM_ADDRESS_WIDTH 
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_LSB                         `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_MSB+1
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_MSB                         `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_LSB+`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_MSB - `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_RANGE                        `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_MSB : `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_LSB


`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_WIDTH    `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_WIDTH   \
                                                          +`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_WIDTH        \
                                                          +`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_WIDTH         \
                                                          +`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_WIDTH 
`else
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_WIDTH    `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_WIDTH        \
                                                          +`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_WIDTH         \
                                                          +`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_WIDTH 
`endif

`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_MSB            `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_MSB - `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_RANGE           `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_MSB : `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_CACHE_CMD_FINAL_FIFO_ALMOST_FULL_THRESHOLD 4




//------------------------------------------------------------------------------------------------------------

`endif
