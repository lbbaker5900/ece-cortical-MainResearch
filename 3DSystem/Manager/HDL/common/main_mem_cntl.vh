`ifndef _main_mem_cntl_vh
`define _main_mem_cntl_vh

/*****************************************************************

    File name   : main_mem_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


`define MMC_CNTL_INITIAL_TAG          `MGR_INITIAL_TAG 

  
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// Interfaces
// - streams from mrc(s)
// - write data from mwc
  
//  Reads from mrc
`define MMC_CNTL_NUM_OF_READ_INTF                    `MGR_NUM_OF_STREAMS
                                                     
`define MMC_CNTL_NUM_OF_READ_INTF_WIDTH             (`CLOG2(`MMC_CNTL_NUM_OF_READ_INTF))
`define MMC_CNTL_NUM_OF_READ_INTF_MSB               `MMC_CNTL_NUM_OF_READ_INTF_WIDTH-1
`define MMC_CNTL_NUM_OF_READ_INTF_LSB                0
`define MMC_CNTL_NUM_OF_READ_INTF_RANGE             `MMC_CNTL_NUM_OF_READ_INTF_MSB : `MMC_CNTL_NUM_OF_READ_INTF_LSB
                                                     
`define MMC_CNTL_NUM_OF_READ_INTF_VEC_WIDTH         `MMC_CNTL_NUM_OF_READ_INTF
`define MMC_CNTL_NUM_OF_READ_INTF_VEC_MSB           `MMC_CNTL_NUM_OF_READ_INTF_VEC_WIDTH-1
`define MMC_CNTL_NUM_OF_READ_INTF_VEC_LSB            0
`define MMC_CNTL_NUM_OF_READ_INTF_VEC_RANGE         `MMC_CNTL_NUM_OF_READ_INTF_VEC_MSB : `MMC_CNTL_NUM_OF_READ_INTF_VEC_LSB

//  Write from mwc
`define MMC_CNTL_NUM_OF_WRITE_INTF                    1
                                                     
`define MMC_CNTL_NUM_OF_WRITE_INTF_WIDTH             (`CLOG2(`MMC_CNTL_NUM_OF_WRITE_INTF))
`define MMC_CNTL_NUM_OF_WRITE_INTF_MSB               `MMC_CNTL_NUM_OF_WRITE_INTF_WIDTH-1
`define MMC_CNTL_NUM_OF_WRITE_INTF_LSB                0
`define MMC_CNTL_NUM_OF_WRITE_INTF_RANGE             `MMC_CNTL_NUM_OF_WRITE_INTF_MSB : `MMC_CNTL_NUM_OF_WRITE_INTF_LSB
                                                     
`define MMC_CNTL_NUM_OF_WRITE_INTF_VEC_WIDTH         `MMC_CNTL_NUM_OF_WRITE_INTF
`define MMC_CNTL_NUM_OF_WRITE_INTF_VEC_MSB           `MMC_CNTL_NUM_OF_WRITE_INTF_VEC_WIDTH-1
`define MMC_CNTL_NUM_OF_WRITE_INTF_VEC_LSB            0
`define MMC_CNTL_NUM_OF_WRITE_INTF_VEC_RANGE         `MMC_CNTL_NUM_OF_WRITE_INTF_VEC_MSB : `MMC_CNTL_NUM_OF_WRITE_INTF_VEC_LSB

//  Reads from mrc
`define MMC_CNTL_NUM_OF_INTF                    `MMC_CNTL_NUM_OF_READ_INTF + `MMC_CNTL_NUM_OF_WRITE_INTF                    
                                                     
`define MMC_CNTL_NUM_OF_INTF_WIDTH             (`CLOG2(`MMC_CNTL_NUM_OF_INTF))
`define MMC_CNTL_NUM_OF_INTF_MSB               `MMC_CNTL_NUM_OF_INTF_WIDTH-1
`define MMC_CNTL_NUM_OF_INTF_LSB                0
`define MMC_CNTL_NUM_OF_INTF_RANGE             `MMC_CNTL_NUM_OF_INTF_MSB : `MMC_CNTL_NUM_OF_INTF_LSB
                                                     
`define MMC_CNTL_NUM_OF_INTF_VEC_WIDTH         `MMC_CNTL_NUM_OF_INTF
`define MMC_CNTL_NUM_OF_INTF_VEC_MSB           `MMC_CNTL_NUM_OF_INTF_VEC_WIDTH-1
`define MMC_CNTL_NUM_OF_INTF_VEC_LSB            0
`define MMC_CNTL_NUM_OF_INTF_VEC_RANGE         `MMC_CNTL_NUM_OF_INTF_VEC_MSB : `MMC_CNTL_NUM_OF_INTF_VEC_LSB

//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FSM's
//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------

//--------------------------------------------------------
// Operation Tag FSM
//  - 
// 

`define MMC_CNTL_OP_TAG_WAIT                 4'b0001
`define MMC_CNTL_OP_TAG_PAUSE                4'b0010
`define MMC_CNTL_OP_TAG_INC                  4'b0100
`define MMC_CNTL_OP_TAG_ERR                  4'b1000
                                                           

`define MMC_CNTL_OP_TAG_STATE_WIDTH         4
`define MMC_CNTL_OP_TAG_STATE_MSB           `MMC_CNTL_OP_TAG_STATE_WIDTH-1
`define MMC_CNTL_OP_TAG_STATE_LSB           0
`define MMC_CNTL_OP_TAG_STATE_SIZE          (`MMC_CNTL_OP_TAG_STATE_MSB - `MMC_CNTL_OP_TAG_STATE_LSB +1)
`define MMC_CNTL_OP_TAG_STATE_RANGE          `MMC_CNTL_OP_TAG_STATE_MSB : `MMC_CNTL_OP_TAG_STATE_LSB

// pause before changing tag
`define MMC_CNTL_OP_TAG_PAUSE_WIDTH         6
`define MMC_CNTL_OP_TAG_PAUSE_MSB           `MMC_CNTL_OP_TAG_PAUSE_WIDTH-1
`define MMC_CNTL_OP_TAG_PAUSE_LSB           0
`define MMC_CNTL_OP_TAG_PAUSE_SIZE          (`MMC_CNTL_OP_TAG_PAUSE_MSB - `MMC_CNTL_OP_TAG_PAUSE_LSB +1)
`define MMC_CNTL_OP_TAG_PAUSE_RANGE          `MMC_CNTL_OP_TAG_PAUSE_MSB : `MMC_CNTL_OP_TAG_PAUSE_LSB

`define MMC_CNTL_OP_TAG_PAUSE_VALUE        32

//--------------------------------------------------------
// DRAM Command generation FSM
//  - take memory requests and determine how many commands associated with each request
//  - If read with nothing open, generate PO-CR
//  - If read with mismatched open page, generate PC-PO-CR
//  - read to open page, generate CR
//  etc.
// 

`define MMC_CNTL_CMD_GEN_STATE_WIDTH         11
`define MMC_CNTL_CMD_GEN_STATE_MSB           `MMC_CNTL_CMD_GEN_STATE_WIDTH-1
`define MMC_CNTL_CMD_GEN_STATE_LSB           0
`define MMC_CNTL_CMD_GEN_STATE_SIZE          (`MMC_CNTL_CMD_GEN_STATE_MSB - `MMC_CNTL_CMD_GEN_STATE_LSB +1)
`define MMC_CNTL_CMD_GEN_STATE_RANGE          `MMC_CNTL_CMD_GEN_STATE_MSB : `MMC_CNTL_CMD_GEN_STATE_LSB

`define MMC_CNTL_CMD_GEN_TAG_WIDTH         6  // FIXME  - can be shorter  ??
`define MMC_CNTL_CMD_GEN_TAG_MSB           `MMC_CNTL_CMD_GEN_TAG_WIDTH-1
`define MMC_CNTL_CMD_GEN_TAG_LSB           0
`define MMC_CNTL_CMD_GEN_TAG_SIZE          (`MMC_CNTL_CMD_GEN_TAG_MSB - `MMC_CNTL_CMD_GEN_TAG_LSB +1)
`define MMC_CNTL_CMD_GEN_TAG_RANGE          `MMC_CNTL_CMD_GEN_TAG_MSB : `MMC_CNTL_CMD_GEN_TAG_LSB

`define MMC_CNTL_CMD_GEN_WAIT                        11'b000_0000_0001
`define MMC_CNTL_CMD_GEN_DECODE_SEQUENCE             11'b000_0000_0010
`define MMC_CNTL_CMD_GEN_POCR                        11'b000_0000_0100
`define MMC_CNTL_CMD_GEN_POCW                        11'b000_0000_1000
`define MMC_CNTL_CMD_GEN_CR                          11'b000_0001_0000
`define MMC_CNTL_CMD_GEN_CW                          11'b000_0010_0000
`define MMC_CNTL_CMD_GEN_PCPOCR                      11'b000_0100_0000
`define MMC_CNTL_CMD_GEN_PCPOCW                      11'b000_1000_0000
`define MMC_CNTL_CMD_GEN_PCPR                        11'b001_0000_0000
`define MMC_CNTL_CMD_GEN_PR                          11'b010_0000_0000

`define MMC_CNTL_CMD_GEN_ERR                         11'b100_0000_0000

typedef enum reg [`MMC_CNTL_CMD_GEN_STATE_RANGE ] {
           MMC_CNTL_CMD_GEN_WAIT                  =  11'b000_0000_0001,
           MMC_CNTL_CMD_GEN_DECODE_SEQUENCE       =  11'b000_0000_0010,
           MMC_CNTL_CMD_GEN_POCR                  =  11'b000_0000_0100,
           MMC_CNTL_CMD_GEN_POCW                  =  11'b000_0000_1000,
           MMC_CNTL_CMD_GEN_CR                    =  11'b000_0001_0000,
           MMC_CNTL_CMD_GEN_CW                    =  11'b000_0010_0000,
           MMC_CNTL_CMD_GEN_PCPOCR                =  11'b000_0100_0000,
           MMC_CNTL_CMD_GEN_PCPOCW                =  11'b000_1000_0000,
           MMC_CNTL_CMD_GEN_PCPR                  =  11'b001_0000_0000,
           MMC_CNTL_CMD_GEN_PR                    =  11'b010_0000_0000,
           MMC_CNTL_CMD_GEN_ERR                   =  11'b100_0000_0000}  mmc_cntl_cmd_gen_fsm_enum;


//--------------------------------------------------------
// Command Sequence Validate FSM
//  - ensures the commands in the command sequence fifos can_go
// 

`define MMC_CNTL_CMD_CHECK_WAIT                 8'b0000_0001
`define MMC_CNTL_CMD_CHECK_PAGE_INIT            8'b0000_0010
`define MMC_CNTL_CMD_CHECK_PC                   8'b0000_0100
`define MMC_CNTL_CMD_CHECK_PO                   8'b0000_1000
`define MMC_CNTL_CMD_CHECK_PAGE_WAIT            8'b0001_0000
`define MMC_CNTL_CMD_CHECK_CACHE_INIT           8'b0010_0000
`define MMC_CNTL_CMD_CHECK_CACHE                8'b0100_0000
`define MMC_CNTL_CMD_CHECK_CACHE_WAIT           8'b1000_0000
                                                           

`define MMC_CNTL_CMD_CHECK_STATE_WIDTH         8
`define MMC_CNTL_CMD_CHECK_STATE_MSB           `MMC_CNTL_CMD_CHECK_STATE_WIDTH-1
`define MMC_CNTL_CMD_CHECK_STATE_LSB           0
`define MMC_CNTL_CMD_CHECK_STATE_SIZE          (`MMC_CNTL_CMD_CHECK_STATE_MSB - `MMC_CNTL_CMD_CHECK_STATE_LSB +1)
`define MMC_CNTL_CMD_CHECK_STATE_RANGE          `MMC_CNTL_CMD_CHECK_STATE_MSB : `MMC_CNTL_CMD_CHECK_STATE_LSB

// we need to keep track of CRs/CWs and POs in the sequence FIFOs prior to inserting a PC
`define MMC_CNTL_CMD_GEN_OP_COUNT_WIDTH         2
`define MMC_CNTL_CMD_GEN_OP_COUNT_MSB           `MMC_CNTL_CMD_GEN_OP_COUNT_WIDTH-1
`define MMC_CNTL_CMD_GEN_OP_COUNT_LSB           0
`define MMC_CNTL_CMD_GEN_OP_COUNT_SIZE          (`MMC_CNTL_CMD_GEN_OP_COUNT_MSB - `MMC_CNTL_CMD_GEN_OP_COUNT_LSB +1)
`define MMC_CNTL_CMD_GEN_OP_COUNT_RANGE          `MMC_CNTL_CMD_GEN_OP_COUNT_MSB : `MMC_CNTL_CMD_GEN_OP_COUNT_LSB

//--------------------------------------------------------
// DFI sequence FSM
//  - read page and rw commands from command fifo's and make sure we follow the DDR protocol for DiRAM4
// 

`define MMC_CNTL_DFI_SEQ_STATE_WIDTH         12
`define MMC_CNTL_DFI_SEQ_STATE_MSB           `MMC_CNTL_DFI_SEQ_STATE_WIDTH-1
`define MMC_CNTL_DFI_SEQ_STATE_LSB           0
`define MMC_CNTL_DFI_SEQ_STATE_SIZE          (`MMC_CNTL_DFI_SEQ_STATE_MSB - `MMC_CNTL_DFI_SEQ_STATE_LSB +1)
`define MMC_CNTL_DFI_SEQ_STATE_RANGE          `MMC_CNTL_DFI_SEQ_STATE_MSB : `MMC_CNTL_DFI_SEQ_STATE_LSB

`define MMC_CNTL_DFI_SEQ_WAIT                                  12'b0000_0000_0001
`define MMC_CNTL_DFI_SEQ_PAGE_CMD                              12'b0000_0000_0010
`define MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA                 12'b0000_0000_0100
`define MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD                          12'b0000_0000_1000
`define MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA             12'b0000_0001_0000
`define MMC_CNTL_DFI_SEQ_NOHEAD_NOP_PAGE_CMD                   12'b0000_0010_0000
`define MMC_CNTL_DFI_SEQ_NOHEAD_NOP_PAGE_CMD_WITH_WR_DATA      12'b0000_0100_0000
`define MMC_CNTL_DFI_SEQ_RD_CMD                                12'b0000_1000_0000
`define MMC_CNTL_DFI_SEQ_WR_CMD                                12'b0001_0000_0000
`define MMC_CNTL_DFI_SEQ_NOP_RW_CMD                            12'b0010_0000_0000
`define MMC_CNTL_DFI_SEQ_NOHEAD_NOP_RW_CMD                     12'b0100_0000_0000
                                                              
`define MMC_CNTL_DFI_SEQ_ERR                                   12'b1000_0000_0000

typedef enum reg [`MMC_CNTL_DFI_SEQ_STATE_RANGE ] {
         MMC_CNTL_DFI_SEQ_WAIT                                  = 12'b0000_0000_0001,
         MMC_CNTL_DFI_SEQ_PAGE_CMD                              = 12'b0000_0000_0010,
         MMC_CNTL_DFI_SEQ_PAGE_CMD_WITH_WR_DATA                 = 12'b0000_0000_0100,
         MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD                          = 12'b0000_0000_1000,
         MMC_CNTL_DFI_SEQ_NOP_PAGE_CMD_WITH_WR_DATA             = 12'b0000_0001_0000,
         MMC_CNTL_DFI_SEQ_NOHEAD_NOP_PAGE_CMD                   = 12'b0000_0010_0000,
         MMC_CNTL_DFI_SEQ_NOHEAD_NOP_PAGE_CMD_WITH_WR_DATA      = 12'b0000_0100_0000,
         MMC_CNTL_DFI_SEQ_RD_CMD                                = 12'b0000_1000_0000,
         MMC_CNTL_DFI_SEQ_WR_CMD                                = 12'b0001_0000_0000,
         MMC_CNTL_DFI_SEQ_NOP_RW_CMD                            = 12'b0010_0000_0000,
         MMC_CNTL_DFI_SEQ_NOHEAD_NOP_RW_CMD                     = 12'b0100_0000_0000,
         MMC_CNTL_DFI_SEQ_ERR                                   = 12'b1000_0000_0000}  mmc_cntl_dfi_seq_fsm_enum;

//--------------------------------------------------------
// Stream select FSM
//  - select which stream should gain access to the channel
// 

`define MMC_CNTL_STRM_SEL_WAIT                            6'b00_0001
`define MMC_CNTL_STRM_SEL_STRM0                           6'b00_0010
`define MMC_CNTL_STRM_SEL_STRM1                           6'b00_0100
`define MMC_CNTL_STRM_SEL_WRITE_INTF0                     6'b00_1000
`define MMC_CNTL_STRM_SEL_PAUSE1                          6'b01_0000
`define MMC_CNTL_STRM_SEL_PAUSE2                          6'b10_0000

`define MMC_CNTL_STRM_SEL_STATE_WIDTH         6
`define MMC_CNTL_STRM_SEL_STATE_MSB           `MMC_CNTL_STRM_SEL_STATE_WIDTH-1
`define MMC_CNTL_STRM_SEL_STATE_LSB           0
`define MMC_CNTL_STRM_SEL_STATE_SIZE          (`MMC_CNTL_STRM_SEL_STATE_MSB - `MMC_CNTL_STRM_SEL_STATE_LSB +1)
`define MMC_CNTL_STRM_SEL_STATE_RANGE          `MMC_CNTL_STRM_SEL_STATE_MSB : `MMC_CNTL_STRM_SEL_STATE_LSB

//--------------------------------------------------------
// Readpath FSL
//  - combine the channel return data with the requesting stream
// 

`define MMC_CNTL_RDP_WAIT                            4'b0001
`define MMC_CNTL_RDP_STRM0                           4'b0010
`define MMC_CNTL_RDP_STRM1                           4'b0100
                                                        
`define MMC_CNTL_RDP_ERR                             4'b1000

`define MMC_CNTL_RDP_STATE_WIDTH         4
`define MMC_CNTL_RDP_STATE_MSB           `MMC_CNTL_RDP_STATE_WIDTH-1
`define MMC_CNTL_RDP_STATE_LSB           0
`define MMC_CNTL_RDP_STATE_SIZE          (`MMC_CNTL_RDP_STATE_MSB - `MMC_CNTL_RDP_STATE_LSB +1)
`define MMC_CNTL_RDP_STATE_RANGE          `MMC_CNTL_RDP_STATE_MSB : `MMC_CNTL_RDP_STATE_LSB

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

`define MMC_CNTL_REQUEST_AGGREGATE_TAG_WIDTH                       `MGR_STD_OOB_TAG_WIDTH     
`define MMC_CNTL_REQUEST_AGGREGATE_TAG_LSB                         `MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_MSB+1
`define MMC_CNTL_REQUEST_AGGREGATE_TAG_MSB                         `MMC_CNTL_REQUEST_AGGREGATE_TAG_LSB+`MMC_CNTL_REQUEST_AGGREGATE_TAG_WIDTH-1
`define MMC_CNTL_REQUEST_AGGREGATE_TAG_SIZE                        (`MMC_CNTL_REQUEST_AGGREGATE_TAG_MSB - `MMC_CNTL_REQUEST_AGGREGATE_TAG_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_TAG_RANGE                        `MMC_CNTL_REQUEST_AGGREGATE_TAG_MSB : `MMC_CNTL_REQUEST_AGGREGATE_TAG_LSB

`define MMC_CNTL_REQUEST_AGGREGATE_CNTL_WIDTH                       `COMMON_STD_INTF_CNTL_WIDTH 
`define MMC_CNTL_REQUEST_AGGREGATE_CNTL_LSB                         `MMC_CNTL_REQUEST_AGGREGATE_TAG_MSB+1
`define MMC_CNTL_REQUEST_AGGREGATE_CNTL_MSB                         `MMC_CNTL_REQUEST_AGGREGATE_CNTL_LSB+`MMC_CNTL_REQUEST_AGGREGATE_CNTL_WIDTH-1
`define MMC_CNTL_REQUEST_AGGREGATE_CNTL_SIZE                        (`MMC_CNTL_REQUEST_AGGREGATE_CNTL_MSB - `MMC_CNTL_REQUEST_AGGREGATE_CNTL_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_CNTL_RANGE                        `MMC_CNTL_REQUEST_AGGREGATE_CNTL_MSB : `MMC_CNTL_REQUEST_AGGREGATE_CNTL_LSB

`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH     `MMC_CNTL_REQUEST_AGGREGATE_WORD_WIDTH      \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_PAGE_WIDTH      \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_BANK_WIDTH      \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_CHAN_WIDTH      \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_IS_READ_WIDTH   \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_IS_WRITE_WIDTH  \
                                                 +`MMC_CNTL_REQUEST_AGGREGATE_TAG_WIDTH       \
                                                 +`COMMON_STD_INTF_CNTL_WIDTH                  
                                                 
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_MSB            `MMC_CNTL_REQUEST_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_REQUEST_AGGREGATE_FIFO_MSB - `MMC_CNTL_REQUEST_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_REQUEST_AGGREGATE_FIFO_RANGE           `MMC_CNTL_REQUEST_AGGREGATE_FIFO_MSB : `MMC_CNTL_REQUEST_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_REQUEST_FIFO_ALMOST_FULL_THRESHOLD 4


//--------------------------------------------------------
// FIFO for holding PO commands from the sequence FSM

`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH          8
`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH_MSB      (`MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH) -1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH_LSB      0
`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH_SIZE     (`MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH_RANGE     `MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH_LSB
`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_MSB            ((`CLOG2(`MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_DEPTH)) -1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_LSB            0
`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_SIZE           (`MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_RANGE           `MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_WIDTH                       `MGR_DRAM_PAGE_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_LSB                         0
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_WIDTH                       `MGR_DRAM_BANK_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_WIDTH                       `DRAM_ACC_NUM_OF_CMDS_WIDTH 
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_LSB

// carry which sequence the dram command is associated with
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_WIDTH                       `DRAM_ACC_SEQ_TYPE_WIDTH  
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_WIDTH                       `MMC_CNTL_CMD_GEN_TAG_WIDTH 
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_WIDTH                       `MMC_CNTL_NUM_OF_INTF_WIDTH  
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_LSB


`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_WIDTH     `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_PAGE_WIDTH      \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_BANK_WIDTH      \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_DRAM_CMD_WIDTH  \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_SEQ_TYPE_WIDTH  \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_TAG_WIDTH       \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_STRM_WIDTH 

`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_MSB            `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_RANGE           `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PO_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_PAGE_CMD_SEQ_PO_FIFO_ALMOST_FULL_THRESHOLD 4


//--------------------------------------------------------
// FIFO for holding PC commands from the sequence FSM

`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH          8
`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH_MSB      (`MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH) -1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH_LSB      0
`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH_SIZE     (`MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH_RANGE     `MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH_LSB
`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_MSB            ((`CLOG2(`MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_DEPTH)) -1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_LSB            0
`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_SIZE           (`MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_RANGE           `MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_WIDTH                       `MGR_DRAM_PAGE_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_LSB                         0
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_WIDTH                       `MGR_DRAM_BANK_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_WIDTH                       `DRAM_ACC_NUM_OF_CMDS_WIDTH 
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_LSB

// carry which sequence the dram command is associated with
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_WIDTH                       `DRAM_ACC_SEQ_TYPE_WIDTH  
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_WIDTH                       `MMC_CNTL_CMD_GEN_TAG_WIDTH 
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_WIDTH                       `MMC_CNTL_NUM_OF_INTF_WIDTH  
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_LSB

`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_WIDTH                       `MMC_CNTL_CMD_GEN_OP_COUNT_WIDTH 
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_LSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_MSB+1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_MSB                         `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_LSB+`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_WIDTH-1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_SIZE                        (`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_RANGE                        `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_LSB



`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_WIDTH     `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_PAGE_WIDTH      \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_BANK_WIDTH      \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_DRAM_CMD_WIDTH  \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_SEQ_TYPE_WIDTH  \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_TAG_WIDTH       \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_STRM_WIDTH      \
                                                         +`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_CCI_WIDTH 

`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_MSB            `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_MSB - `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_RANGE           `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_MSB : `MMC_CNTL_PAGE_CMD_SEQ_PC_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_PAGE_CMD_SEQ_PC_FIFO_ALMOST_FULL_THRESHOLD 4




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
`ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
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

// carry which sequence the dram command is associated with
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_WIDTH                       `DRAM_ACC_SEQ_TYPE_WIDTH  
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_LSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_MSB+1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_MSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_LSB+`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_WIDTH-1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_SIZE                        (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_RANGE                        `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_LSB

`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_WIDTH                       `MMC_CNTL_CMD_GEN_TAG_WIDTH
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_LSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_MSB+1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_MSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_LSB+`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_WIDTH-1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_SIZE                        (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_RANGE                        `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_LSB

`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_WIDTH                       `MMC_CNTL_NUM_OF_INTF_WIDTH 
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_LSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_MSB+1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_MSB                         `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_LSB+`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_MSB - `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_RANGE                        `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_MSB : `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_LSB


`ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_WIDTH     `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_CACHELINE_WIDTH \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_WIDTH      \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_WIDTH      \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_WIDTH  \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_WIDTH  \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_TAG_WIDTH       \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_STRM_WIDTH 
`else
  `define MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_FIFO_WIDTH     `MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_PAGE_WIDTH      \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_BANK_WIDTH      \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_DRAM_CMD_WIDTH  \
                                                         +`MMC_CNTL_CACHE_CMD_SEQ_AGGREGATE_SEQ_TYPE_WIDTH  \
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
// PO command fifo
// - stores PO associated with PCPOCR sequence to allow other PC's to proceed

`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH          32
`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH_MSB      (`MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH) -1
`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH_LSB      0
`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH_SIZE     (`MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH_MSB - `MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH_RANGE     `MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH_MSB : `MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH_LSB
`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_MSB            ((`CLOG2(`MMC_CNTL_PAGE_PO_LAYBY_FIFO_DEPTH)) -1)
`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_LSB            0
`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_SIZE           (`MMC_CNTL_PAGE_PO_LAYBY_FIFO_MSB - `MMC_CNTL_PAGE_PO_LAYBY_FIFO_LSB +1)
`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_RANGE           `MMC_CNTL_PAGE_PO_LAYBY_FIFO_MSB : `MMC_CNTL_PAGE_PO_LAYBY_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_WIDTH                       `MGR_DRAM_PAGE_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_LSB                         0
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_MSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_LSB+`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_WIDTH-1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_SIZE                        (`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_MSB - `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_LSB +1)
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_RANGE                        `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_MSB : `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_LSB

`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_WIDTH                       `MGR_DRAM_BANK_ADDRESS_WIDTH
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_LSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_MSB+1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_MSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_LSB+`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_WIDTH-1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_SIZE                        (`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_MSB - `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_LSB +1)
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_RANGE                        `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_MSB : `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_LSB

`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_WIDTH                       `DRAM_ACC_NUM_OF_CMDS_WIDTH 
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_LSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_MSB+1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_MSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_LSB+`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_WIDTH-1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_SIZE                        (`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_MSB - `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_LSB +1)
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_RANGE                        `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_MSB : `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_LSB

// carry which sequence the dram command is associated with
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_WIDTH                       `DRAM_ACC_SEQ_TYPE_WIDTH  
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_LSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_MSB+1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_MSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_LSB+`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_WIDTH-1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_SIZE                        (`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_MSB - `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_LSB +1)
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_RANGE                        `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_MSB : `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_LSB

`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_WIDTH                       `MMC_CNTL_CMD_GEN_TAG_WIDTH 
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_LSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_MSB+1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_MSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_LSB+`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_WIDTH-1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_SIZE                        (`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_MSB - `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_LSB +1)
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_RANGE                        `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_MSB : `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_LSB

`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_WIDTH                       `MMC_CNTL_NUM_OF_INTF_WIDTH  
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_LSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_IS_READ_MSB+1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_MSB                         `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_LSB+`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_MSB - `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_RANGE                        `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_MSB : `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_LSB


`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_WIDTH     `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_PAGE_WIDTH      \
                                                      +`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_BANK_WIDTH      \
                                                      +`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_DRAM_CMD_WIDTH  \
                                                      +`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_SEQ_TYPE_WIDTH  \
                                                      +`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_TAG_WIDTH       \
                                                      +`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_STRM_WIDTH 

`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_MSB            `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_MSB - `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_RANGE           `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_MSB : `MMC_CNTL_PAGE_PO_LAYBY_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_PAGE_PO_LAYBY_FIFO_ALMOST_FULL_THRESHOLD 4




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

`define MMC_CNTL_PAGE_CMD_FINAL_AGGREGATE_STRM_WIDTH                       `MMC_CNTL_NUM_OF_INTF_WIDTH
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


`ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
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

`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_WIDTH                       `MMC_CNTL_NUM_OF_INTF_WIDTH
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_LSB                         `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_CMD_MSB+1
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_MSB                         `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_LSB+`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_MSB - `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_RANGE                        `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_MSB : `MMC_CNTL_CACHE_CMD_FINAL_AGGREGATE_STRM_LSB


`ifdef  MGR_DRAM_REQUEST_LINE_LT_CACHELINE
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



//--------------------------------------------------------
//--------------------------------------------------------
// ReadPath FIFOs

//--------------------------------------------------------
// From DFI

// FIXME: Its possible to have 32 outstanding requests, need to think about this fifo and the fifo in the mrc_cntl
//`define MRC_CNTL_FROM_MMC_FIFO_DEPTH          32
//`define MMC_CNTL_FROM_DFI_FIFO_DEPTH          8
`define MMC_CNTL_FROM_DFI_FIFO_DEPTH          32
`define MMC_CNTL_FROM_DFI_FIFO_DEPTH_MSB      (`MMC_CNTL_FROM_DFI_FIFO_DEPTH) -1
`define MMC_CNTL_FROM_DFI_FIFO_DEPTH_LSB      0
`define MMC_CNTL_FROM_DFI_FIFO_DEPTH_SIZE     (`MMC_CNTL_FROM_DFI_FIFO_DEPTH_MSB - `MMC_CNTL_FROM_DFI_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_FROM_DFI_FIFO_DEPTH_RANGE     `MMC_CNTL_FROM_DFI_FIFO_DEPTH_MSB : `MMC_CNTL_FROM_DFI_FIFO_DEPTH_LSB
`define MMC_CNTL_FROM_DFI_FIFO_MSB            ((`CLOG2(`MMC_CNTL_FROM_DFI_FIFO_DEPTH)) -1)
`define MMC_CNTL_FROM_DFI_FIFO_LSB            0
`define MMC_CNTL_FROM_DFI_FIFO_SIZE           (`MMC_CNTL_FROM_DFI_FIFO_MSB - `MMC_CNTL_FROM_DFI_FIFO_LSB +1)
`define MMC_CNTL_FROM_DFI_FIFO_RANGE           `MMC_CNTL_FROM_DFI_FIFO_MSB : `MMC_CNTL_FROM_DFI_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MMC_CNTL_FROM_DFI_AGGREGATE_DATA_WIDTH    (`MGR_MMC_TO_MRC_INTF_NUM_WORDS*`MGR_EXEC_LANE_WIDTH)
`define MMC_CNTL_FROM_DFI_AGGREGATE_DATA_MSB      `MMC_CNTL_FROM_DFI_AGGREGATE_DATA_WIDTH-1
`define MMC_CNTL_FROM_DFI_AGGREGATE_DATA_LSB      0
`define MMC_CNTL_FROM_DFI_AGGREGATE_DATA_SIZE     (`MMC_CNTL_FROM_DFI_AGGREGATE_DATA_MSB - `MMC_CNTL_FROM_DFI_AGGREGATE_DATA_LSB +1)
`define MMC_CNTL_FROM_DFI_AGGREGATE_DATA_RANGE     `MMC_CNTL_FROM_DFI_AGGREGATE_DATA_MSB : `MMC_CNTL_FROM_DFI_AGGREGATE_DATA_LSB

`define MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_MSB      (`MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_LSB+`COMMON_STD_INTF_CNTL_WIDTH) -1
`define MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_LSB      `MMC_CNTL_FROM_DFI_AGGREGATE_DATA_MSB+1
`define MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_SIZE     (`MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_MSB - `MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_LSB +1)
`define MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_RANGE     `MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_MSB : `MMC_CNTL_FROM_DFI_AGGREGATE_CNTL_LSB

`define MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH \
                                                   +`MMC_CNTL_FROM_DFI_AGGREGATE_DATA_WIDTH

`define MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_MSB            `MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_MSB - `MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_RANGE           `MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_MSB : `MMC_CNTL_FROM_DFI_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_FROM_DFI_FIFO_ALMOST_FULL_THRESHOLD 4


//--------------------------------------------------------
// Strm/Tag FIFO


`define MMC_CNTL_READPATH_TAG_FIFO_DEPTH          `MMC_CNTL_FROM_DFI_FIFO_DEPTH 
`define MMC_CNTL_READPATH_TAG_FIFO_DEPTH_MSB      (`MMC_CNTL_READPATH_TAG_FIFO_DEPTH) -1
`define MMC_CNTL_READPATH_TAG_FIFO_DEPTH_LSB      0
`define MMC_CNTL_READPATH_TAG_FIFO_DEPTH_SIZE     (`MMC_CNTL_READPATH_TAG_FIFO_DEPTH_MSB - `MMC_CNTL_READPATH_TAG_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_READPATH_TAG_FIFO_DEPTH_RANGE     `MMC_CNTL_READPATH_TAG_FIFO_DEPTH_MSB : `MMC_CNTL_READPATH_TAG_FIFO_DEPTH_LSB
`define MMC_CNTL_READPATH_TAG_FIFO_MSB            ((`CLOG2(`MMC_CNTL_READPATH_TAG_FIFO_DEPTH)) -1)
`define MMC_CNTL_READPATH_TAG_FIFO_LSB            0
`define MMC_CNTL_READPATH_TAG_FIFO_SIZE           (`MMC_CNTL_READPATH_TAG_FIFO_MSB - `MMC_CNTL_READPATH_TAG_FIFO_LSB +1)
`define MMC_CNTL_READPATH_TAG_FIFO_RANGE           `MMC_CNTL_READPATH_TAG_FIFO_MSB : `MMC_CNTL_READPATH_TAG_FIFO_LSB


`define MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_WIDTH                       `MMC_CNTL_CMD_GEN_TAG_WIDTH
`define MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_LSB                         0
`define MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_MSB                         `MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_LSB+`MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_WIDTH-1
`define MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_SIZE                        (`MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_MSB - `MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_LSB +1)
`define MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_RANGE                        `MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_MSB : `MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_LSB

`define MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_WIDTH                       `MMC_CNTL_NUM_OF_READ_INTF_WIDTH  
`define MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_LSB                         `MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_MSB+1
`define MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_MSB                         `MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_LSB+`MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_WIDTH-1
`define MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_SIZE                        (`MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_MSB - `MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_LSB +1)
`define MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_RANGE                        `MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_MSB : `MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_LSB


`define MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_WIDTH    `MMC_CNTL_READPATH_TAG_AGGREGATE_TAG_WIDTH    \
                                                     +`MMC_CNTL_READPATH_TAG_AGGREGATE_STRM_WIDTH   

`define MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_MSB            `MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_MSB - `MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_RANGE           `MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_MSB : `MMC_CNTL_READPATH_TAG_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_READPATH_TAG_FIFO_ALMOST_FULL_THRESHOLD 4


//--------------------------------------------------------
//--------------------------------------------------------
// From MWC

`define MMC_CNTL_FROM_MWC_FIFO_DEPTH          8
`define MMC_CNTL_FROM_MWC_FIFO_DEPTH_MSB      (`MMC_CNTL_FROM_MWC_FIFO_DEPTH) -1
`define MMC_CNTL_FROM_MWC_FIFO_DEPTH_LSB      0
`define MMC_CNTL_FROM_MWC_FIFO_DEPTH_SIZE     (`MMC_CNTL_FROM_MWC_FIFO_DEPTH_MSB - `MMC_CNTL_FROM_MWC_FIFO_DEPTH_LSB +1)
`define MMC_CNTL_FROM_MWC_FIFO_DEPTH_RANGE     `MMC_CNTL_FROM_MWC_FIFO_DEPTH_MSB : `MMC_CNTL_FROM_MWC_FIFO_DEPTH_LSB
`define MMC_CNTL_FROM_MWC_FIFO_MSB            ((`CLOG2(`MMC_CNTL_FROM_MWC_FIFO_DEPTH)) -1)
`define MMC_CNTL_FROM_MWC_FIFO_LSB            0
`define MMC_CNTL_FROM_MWC_FIFO_SIZE           (`MMC_CNTL_FROM_MWC_FIFO_MSB - `MMC_CNTL_FROM_MWC_FIFO_LSB +1)
`define MMC_CNTL_FROM_MWC_FIFO_RANGE           `MMC_CNTL_FROM_MWC_FIFO_MSB : `MMC_CNTL_FROM_MWC_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MMC_CNTL_FROM_MWC_AGGREGATE_DATA_WIDTH    (`MGR_MMC_TO_MRC_INTF_NUM_WORDS*`MGR_EXEC_LANE_WIDTH)
`define MMC_CNTL_FROM_MWC_AGGREGATE_DATA_MSB      `MMC_CNTL_FROM_MWC_AGGREGATE_DATA_WIDTH-1
`define MMC_CNTL_FROM_MWC_AGGREGATE_DATA_LSB      0
`define MMC_CNTL_FROM_MWC_AGGREGATE_DATA_SIZE     (`MMC_CNTL_FROM_MWC_AGGREGATE_DATA_MSB - `MMC_CNTL_FROM_MWC_AGGREGATE_DATA_LSB +1)
`define MMC_CNTL_FROM_MWC_AGGREGATE_DATA_RANGE     `MMC_CNTL_FROM_MWC_AGGREGATE_DATA_MSB : `MMC_CNTL_FROM_MWC_AGGREGATE_DATA_LSB

`define MMC_CNTL_FROM_MWC_AGGREGATE_MASK_WIDTH    `MGR_MMC_TO_MRC_INTF_NUM_WORDS          
`define MMC_CNTL_FROM_MWC_AGGREGATE_MASK_MSB      (`MMC_CNTL_FROM_MWC_AGGREGATE_MASK_LSB+`MMC_CNTL_FROM_MWC_AGGREGATE_MASK_WIDTH) -1
`define MMC_CNTL_FROM_MWC_AGGREGATE_MASK_LSB      `MMC_CNTL_FROM_MWC_AGGREGATE_DATA_MSB+1
`define MMC_CNTL_FROM_MWC_AGGREGATE_MASK_SIZE     (`MMC_CNTL_FROM_MWC_AGGREGATE_MASK_MSB - `MMC_CNTL_FROM_MWC_AGGREGATE_MASK_LSB +1)
`define MMC_CNTL_FROM_MWC_AGGREGATE_MASK_RANGE     `MMC_CNTL_FROM_MWC_AGGREGATE_MASK_MSB : `MMC_CNTL_FROM_MWC_AGGREGATE_MASK_LSB

`define MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_WIDTH    `COMMON_STD_INTF_CNTL_WIDTH
`define MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_MSB      (`MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_LSB+`MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_WIDTH) -1
`define MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_LSB      `MMC_CNTL_FROM_MWC_AGGREGATE_MASK_MSB+1
`define MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_SIZE     (`MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_MSB - `MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_LSB +1)
`define MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_RANGE     `MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_MSB : `MMC_CNTL_FROM_MWC_AGGREGATE_CNTL_LSB

`define MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH              \
                                                   +`MMC_CNTL_FROM_MWC_AGGREGATE_MASK_WIDTH \
                                                   +`MMC_CNTL_FROM_MWC_AGGREGATE_DATA_WIDTH

`define MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_MSB            `MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_WIDTH -1
`define MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_LSB            0
`define MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_SIZE           (`MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_MSB - `MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_LSB +1)
`define MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_RANGE           `MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_MSB : `MMC_CNTL_FROM_MWC_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MMC_CNTL_FROM_MWC_FIFO_ALMOST_FULL_THRESHOLD 4



//------------------------------------------------------------------------------------------------------------

`endif
