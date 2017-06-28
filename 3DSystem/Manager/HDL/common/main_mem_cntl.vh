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

`define MMC_CNTL_CMD_GEN_WAIT                        8'b0000_0001
`define MMC_CNTL_CMD_GEN_OPEN_PAGE_MATCH             8'b0000_0010
`define MMC_CNTL_CMD_GEN_OPEN_PAGE_MISMATCH          8'b0000_0100
`define MMC_CNTL_CMD_GEN_PAGE_CLOSE                  8'b0000_1000
`define MMC_CNTL_CMD_GEN_PAGE_OPEN                   8'b0001_0000
`define MMC_CNTL_CMD_GEN_LINE_READ                   8'b0010_0000
`define MMC_CNTL_CMD_GEN_LINE_WRITE                  8'b0100_0000
//`define MMC_CNTL_CMD_GEN_COMPLETE                    8'b000_1000_0000
`define MMC_CNTL_CMD_GEN_ERR                         8'b1000_0000



`define MMC_CNTL_CMD_GEN_STATE_WIDTH         8
`define MMC_CNTL_CMD_GEN_STATE_MSB           `MMC_CNTL_CMD_GEN_STATE_WIDTH-1
`define MMC_CNTL_CMD_GEN_STATE_LSB           0
`define MMC_CNTL_CMD_GEN_STATE_SIZE          (`MMC_CNTL_CMD_GEN_STATE_MSB - `MMC_CNTL_CMD_GEN_STATE_LSB +1)
`define MMC_CNTL_CMD_GEN_STATE_RANGE          `MMC_CNTL_CMD_GEN_STATE_MSB : `MMC_CNTL_CMD_GEN_STATE_LSB

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

`define MMC_CNTL_STRM_SEL_WAIT                            5'b0_0001
`define MMC_CNTL_STRM_SEL_STRM0                           5'b0_0010
`define MMC_CNTL_STRM_SEL_STRM1                           5'b0_0100

`define MMC_CNTL_STRM_SEL_ERR                             5'b1_0000

`define MMC_CNTL_STRM_SEL_STATE_WIDTH         5
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

`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH    `COMMON_STD_INTF_CNTL_WIDTH               \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_WORD_WIDTH   \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_PAGE_WIDTH   \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_BANK_WIDTH   \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_CHAN_WIDTH 

`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_MSB            `MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_REQUEST_AGGREGATE_FIFO_MSB - `MMC_CNTL_REQUEST_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_RANGE           `MMC_CNTL_REQUEST_AGGREGATE_FIFO_MSB : `MMC_CNTL_REQUEST_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_REQUEST_FIFO_ALMOST_FULL_THRESHOLD 4



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


`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_FIFO_WIDTH    `MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_PAGE_WIDTH   \
                                                       +`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_BANK_WIDTH   \
                                                       +`MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_CMD_WIDTH 

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


`ifdef  MGR_DRAM_REQUEST_LT_PAGE
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_WIDTH    `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CACHELINE_WIDTH   \
                                                          +`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_WIDTH        \
                                                          +`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_WIDTH 
`else
  `define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_FIFO_WIDTH    `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_BANK_WIDTH        \
                                                          +`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_WIDTH 
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
