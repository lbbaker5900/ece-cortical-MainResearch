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

`define MMC_CNTL_REQUEST_AGGREGATE_CHAN_WIDTH                       `MGR_DRAM_CHAN_ADDRESS_WIDTH
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




//------------------------------------------------------------------------------------------------------------

`endif
