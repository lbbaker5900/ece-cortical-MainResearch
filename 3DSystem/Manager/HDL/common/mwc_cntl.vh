`ifndef _mwc_cntl_vh
`define _mwc_cntl_vh

/*****************************************************************

    File name   : mwc_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : July 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// Interfaces
// - from RDP and from MCntl
  
`define MWC_CNTL_NUM_OF_INPUT_INTF                2
                                                 
`define MWC_CNTL_NUM_OF_INPUT_INTF_WIDTH         (`CLOG2(`MWC_CNTL_NUM_OF_INPUT_INTF))
`define MWC_CNTL_NUM_OF_INPUT_INTF_MSB           `MWC_CNTL_NUM_OF_INPUT_INTF_WIDTH-1
`define MWC_CNTL_NUM_OF_INPUT_INTF_LSB            0
`define MWC_CNTL_NUM_OF_INPUT_INTF_RANGE         `MWC_CNTL_NUM_OF_INPUT_INTF_MSB : `MWC_CNTL_NUM_OF_INPUT_INTF_LSB
                                                 
`define MWC_CNTL_NUM_OF_INPUT_INTF_VEC_WIDTH     `MWC_CNTL_NUM_OF_INPUT_INTF
`define MWC_CNTL_NUM_OF_INPUT_INTF_VEC_MSB       `MWC_CNTL_NUM_OF_INPUT_INTF_VEC_WIDTH-1
`define MWC_CNTL_NUM_OF_INPUT_INTF_VEC_LSB        0
`define MWC_CNTL_NUM_OF_INPUT_INTF_VEC_RANGE     `MWC_CNTL_NUM_OF_INPUT_INTF_VEC_MSB : `MWC_CNTL_NUM_OF_INPUT_INTF_VEC_LSB

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FSM's
//------------------------------------------------------------------------------------------------------------
//
//--------------------------------------------------------
// Simple arbiter gives priority to MCntl
// 

`define MWC_CNTL_INPUT_ARB_WAIT                          5'b0_0001

`define MWC_CNTL_INPUT_ARB_RDP                           5'b0_0010
`define MWC_CNTL_INPUT_ARB_MCNTL                         5'b0_0100
`define MWC_CNTL_INPUT_ARB_COMPLETE                      5'b0_1000

`define MWC_CNTL_INPUT_ARB_ERR                           5'b1_0000

`define MWC_CNTL_INPUT_ARB_STATE_WIDTH         5
`define MWC_CNTL_INPUT_ARB_STATE_MSB           `MWC_CNTL_INPUT_ARB_STATE_WIDTH-1
`define MWC_CNTL_INPUT_ARB_STATE_LSB           0
`define MWC_CNTL_INPUT_ARB_STATE_SIZE          (`MWC_CNTL_INPUT_ARB_STATE_MSB - `MWC_CNTL_INPUT_ARB_STATE_LSB +1)
`define MWC_CNTL_INPUT_ARB_STATE_RANGE          `MWC_CNTL_INPUT_ARB_STATE_MSB : `MWC_CNTL_INPUT_ARB_STATE_LSB

//--------------------------------------------------------
// from RDP and MCNTL options extraction
//  - receive the NoC-like packet and extract write descritor pointer and data
// 

`define MWC_CNTL_PTR_DATA_RCV_WAIT                                16'b0000_0000_0000_0001
                                                                  
`define MWC_CNTL_PTR_DATA_RCV_GET_DESC_CYCLE_FROM_INTF            16'b0000_0000_0000_0010
`define MWC_CNTL_PTR_DATA_RCV_CHECK_1ST_DESC_FROM_INTF            16'b0000_0000_0000_0100
`define MWC_CNTL_PTR_DATA_RCV_PROCESS_1ST_DESC_FROM_INTF          16'b0000_0000_0000_1000
`define MWC_CNTL_PTR_DATA_RCV_CHECK_2ND_DESC_FROM_INTF            16'b0000_0000_0001_0000
`define MWC_CNTL_PTR_DATA_RCV_PROCESS_2ND_DESC_FROM_INTF          16'b0000_0000_0010_0000
`define MWC_CNTL_PTR_DATA_RCV_NEXT_INTF_CYCLE                     16'b0000_0000_0100_0000
`define MWC_CNTL_PTR_DATA_RCV_PROCESS_DATA                        16'b0000_0000_1000_0000
`define MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_LOWER    16'b0000_0001_0000_0000
`define MWC_CNTL_PTR_DATA_RCV_FILL_HOLDING_REG_FROM_INTF_UPPER    16'b0000_0010_0000_0000
`define MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_LOWER   16'b0000_0100_0000_0000
`define MWC_CNTL_PTR_DATA_RCV_FLUSH_HOLDING_REG_FROM_INTF_UPPER   16'b0000_1000_0000_0000

`define MWC_CNTL_PTR_DATA_RCV_FLUSH_ALL_HOLDING_REGS              16'b0001_0000_0000_0000

`define MWC_CNTL_PTR_DATA_RCV_DMA                                 16'b0010_0000_0000_0000

`define MWC_CNTL_PTR_DATA_RCV_COMPLETE                            16'b0100_0000_0000_0000
`define MWC_CNTL_PTR_DATA_RCV_ERR                                 16'b1000_0000_0000_0000

`define MWC_CNTL_PTR_DATA_RCV_STATE_WIDTH         16
`define MWC_CNTL_PTR_DATA_RCV_STATE_MSB           `MWC_CNTL_PTR_DATA_RCV_STATE_WIDTH-1
`define MWC_CNTL_PTR_DATA_RCV_STATE_LSB           0
`define MWC_CNTL_PTR_DATA_RCV_STATE_SIZE          (`MWC_CNTL_PTR_DATA_RCV_STATE_MSB - `MWC_CNTL_PTR_DATA_RCV_STATE_LSB +1)
`define MWC_CNTL_PTR_DATA_RCV_STATE_RANGE          `MWC_CNTL_PTR_DATA_RCV_STATE_MSB : `MWC_CNTL_PTR_DATA_RCV_STATE_LSB



//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// Write Cache
//------------------------------------------------------------------------------------------------------------
// Number of cache entries per channel
//
`define MWC_CNTL_CACHE_ENTRIES                         4

`define MWC_CNTL_CACHE_ENTRIES_WIDTH                  (`CLOG2(`MWC_CNTL_CACHE_ENTRIES))
`define MWC_CNTL_CACHE_ENTRIES_MSB                    `MWC_CNTL_CACHE_ENTRIES_WIDTH-1
`define MWC_CNTL_CACHE_ENTRIES_LSB                     0
`define MWC_CNTL_CACHE_ENTRIES_RANGE                  `MWC_CNTL_CACHE_ENTRIES_MSB : `MWC_CNTL_CACHE_ENTRIES_LSB
                                                 
`define MWC_CNTL_CACHE_ENTRY_LINES                     `MWC_CNTL_CACHE_ENTRIES * `MGR_DRAM_NUM_LINES_PER_CLINE              
`define MWC_CNTL_CACHE_ENTRY_LINES_WIDTH                  (`CLOG2(`MWC_CNTL_CACHE_ENTRY_LINES))
`define MWC_CNTL_CACHE_ENTRY_LINES_MSB                    `MWC_CNTL_CACHE_ENTRY_LINES_WIDTH-1
`define MWC_CNTL_CACHE_ENTRY_LINES_LSB                     0
`define MWC_CNTL_CACHE_ENTRY_LINES_RANGE                  `MWC_CNTL_CACHE_ENTRY_LINES_MSB : `MWC_CNTL_CACHE_ENTRY_LINES_LSB

`define MWC_CNTL_CACHE_ENTRIES_PER_CHAN                `MWC_CNTL_CACHE_ENTRIES / `MGR_DRAM_NUM_CHANNELS                       
                                                 
`define MWC_CNTL_CACHE_ENTRIES_PER_CHAN_WIDTH         (`CLOG2(`MWC_CNTL_CACHE_ENTRIES_PER_CHAN))
`define MWC_CNTL_CACHE_ENTRIES_PER_CHAN_MSB           `MWC_CNTL_CACHE_ENTRIES_PER_CHAN_WIDTH-1
`define MWC_CNTL_CACHE_ENTRIES_PER_CHAN_LSB            0
`define MWC_CNTL_CACHE_ENTRIES_PER_CHAN_RANGE         `MWC_CNTL_CACHE_ENTRIES_PER_CHAN_MSB : `MWC_CNTL_CACHE_ENTRIES_PER_CHAN_LSB
                                                 
`define MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_WIDTH     `MWC_CNTL_CACHE_ENTRIES_PER_CHAN
`define MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_MSB       `MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_WIDTH-1
`define MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_LSB        0
`define MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_RANGE     `MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_MSB : `MWC_CNTL_CACHE_ENTRIES_PER_CHAN_VEC_LSB

`define MWC_CNTL_CACHE_ENTRY_WORD_ADDR_WIDTH         (`CLOG2(`MGR_DRAM_NUM_WORDS_PER_CLINE ))
`define MWC_CNTL_CACHE_ENTRY_WORD_ADDR_MSB           `MWC_CNTL_CACHE_ENTRY_WORD_ADDR_WIDTH-1
`define MWC_CNTL_CACHE_ENTRY_WORD_ADDR_LSB            0
`define MWC_CNTL_CACHE_ENTRY_WORD_ADDR_RANGE         `MWC_CNTL_CACHE_ENTRY_WORD_ADDR_MSB : `MWC_CNTL_CACHE_ENTRY_WORD_ADDR_LSB
                                                 
`define MWC_CNTL_CACHE_ENTRY_WORD_VEC_WIDTH         `MGR_DRAM_NUM_WORDS_PER_CLINE
`define MWC_CNTL_CACHE_ENTRY_WORD_VEC_MSB           `MWC_CNTL_CACHE_ENTRY_WORD_VEC_WIDTH-1
`define MWC_CNTL_CACHE_ENTRY_WORD_VEC_LSB            0
`define MWC_CNTL_CACHE_ENTRY_WORD_VEC_RANGE         `MWC_CNTL_CACHE_ENTRY_WORD_VEC_MSB : `MWC_CNTL_CACHE_ENTRY_WORD_VEC_LSB
                                                 

// pointer to fields in line counter that refer to cache/chan
`define MWC_CNTL_CHAN_CLINE_PTR_RANGE                     `MWC_CNTL_CACHE_ENTRY_LINES_MSB : `MWC_CNTL_CACHE_ENTRY_LINES_MSB-(`MGR_DRAM_CHANNEL_ADDRESS_WIDTH -1)
`define MWC_CNTL_CACHE_LINE_PTR_RANGE                     `MWC_CNTL_CACHE_ENTRY_LINES_MSB-`MGR_DRAM_CHANNEL_ADDRESS_WIDTH : `MWC_CNTL_CACHE_ENTRY_LINES_MSB-`MGR_DRAM_CHANNEL_ADDRESS_WIDTH -(`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_WIDTH-1 )
`define MWC_CNTL_CLINE_LINE_PTR_RANGE                     `MWC_CNTL_CACHE_ENTRY_LINES_MSB-`MGR_DRAM_CHANNEL_ADDRESS_WIDTH -(`MWC_CNTL_CACHE_ENTRIES_PER_CHAN_WIDTH ) : 0
                                                 
// index into cacheline when sending to mmc
`define MWC_CNTL_CLINE_LINE0_MSB                    (`MGR_DRAM_NUM_WORDS_PER_LINE+`MWC_CNTL_CLINE_LINE0_LSB-1)
`define MWC_CNTL_CLINE_LINE0_LSB                     0
`define MWC_CNTL_CLINE_LINE0_RANGE                  `MWC_CNTL_CLINE_LINE0_MSB : `MWC_CNTL_CLINE_LINE0_LSB

`define MWC_CNTL_CLINE_LINE1_MSB                    (`MGR_DRAM_NUM_WORDS_PER_LINE+`MWC_CNTL_CLINE_LINE1_LSB-1)
`define MWC_CNTL_CLINE_LINE1_LSB                    (`MWC_CNTL_CLINE_LINE0_MSB+1                             )
`define MWC_CNTL_CLINE_LINE1_RANGE                  `MWC_CNTL_CLINE_LINE1_MSB : `MWC_CNTL_CLINE_LINE1_LSB

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FIFO's
//------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------
//--------------------------------------------------------
// From Mcntl

`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH          256
`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_MSB      (`MWC_CNTL_FROM_MCNTL_FIFO_DEPTH) -1
`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_LSB      0
`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_SIZE     (`MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_MSB - `MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_LSB +1)
`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_RANGE     `MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_MSB : `MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_LSB
`define MWC_CNTL_FROM_MCNTL_FIFO_MSB            ((`CLOG2(`MWC_CNTL_FROM_MCNTL_FIFO_DEPTH)) -1)
`define MWC_CNTL_FROM_MCNTL_FIFO_LSB            0
`define MWC_CNTL_FROM_MCNTL_FIFO_SIZE           (`MWC_CNTL_FROM_MCNTL_FIFO_MSB - `MWC_CNTL_FROM_MCNTL_FIFO_LSB +1)
`define MWC_CNTL_FROM_MCNTL_FIFO_RANGE           `MWC_CNTL_FROM_MCNTL_FIFO_MSB : `MWC_CNTL_FROM_MCNTL_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_WIDTH    `MGR_NOC_CONT_INTERNAL_DATA_WIDTH 
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_MSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_WIDTH-1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_LSB      0
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_LSB

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_WIDTH      1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_MSB      (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_LSB+`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_WIDTH ) -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_LSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_MSB+1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_LSB

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_WIDTH    `MGR_NOC_CONT_NOC_PAYLOAD_TYPE_WIDTH            
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_MSB      (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_LSB+`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_WIDTH ) -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_LSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_MSB+1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_LSB

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_WIDTH    `MGR_NOC_CONT_NOC_PACKET_TYPE_WIDTH            
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_MSB      (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_LSB+`MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_WIDTH ) -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_LSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_MSB+1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_LSB

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH 
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_MSB      (`MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_LSB+`MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_WIDTH ) -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_LSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_MSB+1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_LSB



`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_WIDTH     `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_WIDTH            \
                                                    +`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_WIDTH   \
                                                    +`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_WIDTH    \
                                                    +`MWC_CNTL_FROM_MCNTL_AGGREGATE_PACKET_TYPE_WIDTH     \
                                                    +`MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_WIDTH            

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_MSB            `MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_WIDTH -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_LSB            0
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_SIZE           (`MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_RANGE           `MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MWC_CNTL_FROM_MCNTL_FIFO_ALMOST_FULL_THRESHOLD 16

//--------------------------------------------------------
//--------------------------------------------------------

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FOO_MSB      1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_WIDTH      1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_MSB      (`MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_LSB+`MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_WIDTH      ) -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_LSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_FOO_MSB+1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_LSB





//------------------------------------------------------------------------------------------------------------

`endif
