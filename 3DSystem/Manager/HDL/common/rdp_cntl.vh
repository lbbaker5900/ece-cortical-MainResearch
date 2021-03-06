`ifndef _rdp_cntl_vh
`define _rdp_cntl_vh

/*****************************************************************

    File name   : rdp_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// FIFO's
//------------------------------------------------

`define RDP_CNTL_STUC_FIFO_DEPTH          32
`define RDP_CNTL_STUC_FIFO_THRESHOLD      8

`define RDP_CNTL_WU_FIFO_DEPTH          32
`define RDP_CNTL_WU_FIFO_THRESHOLD      8

// Unfortunately it needs to be this bit as in some cases there will be a pointer for each manager and we need to store each pointer
// before we cn create the destination address bit mask
`define RDP_CNTL_MW_PTR_FIFO_DEPTH          70
`define RDP_CNTL_MW_PTR_FIFO_THRESHOLD      4

`define RDP_CNTL_TO_NOC_DEST_ADDR_FIFO_DEPTH          8
`define RDP_CNTL_TO_NOC_DEST_ADDR_FIFO_THRESHOLD      4


//--------------------------------------------------------
// Transfer from Stack bus

`define RDP_CNTL_TAG_DATA_COMBINE_WAIT                          12'b0000_0000_0001
`define RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_PTR               12'b0000_0000_0010
`define RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR                  12'b0000_0000_0100
`define RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR                   12'b0000_0000_1000
`define RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE              12'b0000_0001_0000
`define RDP_CNTL_TAG_DATA_COMBINE_START_BUILD_NOC_PKT           12'b0000_0010_0000
`define RDP_CNTL_TAG_DATA_COMBINE_SEND_BITFIELD                 12'b0000_0100_0000
`define RDP_CNTL_TAG_DATA_COMBINE_SEND_WR_PTRS                  12'b0000_1000_0000
`define RDP_CNTL_TAG_DATA_COMBINE_SEND_DATA                     12'b0001_0000_0000
                                                                       
`define RDP_CNTL_TAG_DATA_COMBINE_COMPLETE                      12'b0010_0000_0000
`define RDP_CNTL_TAG_DATA_COMBINE_REPEAT                        12'b0100_0000_0000

`define RDP_CNTL_TAG_DATA_COMBINE_ERR                           12'b1000_0000_0000

`define RDP_CNTL_TAG_DATA_COMBINE_STATE_WIDTH         12
`define RDP_CNTL_TAG_DATA_COMBINE_STATE_MSB           `RDP_CNTL_TAG_DATA_COMBINE_STATE_WIDTH-1
`define RDP_CNTL_TAG_DATA_COMBINE_STATE_LSB           0
`define RDP_CNTL_TAG_DATA_COMBINE_STATE_SIZE          (`RDP_CNTL_TAG_DATA_COMBINE_STATE_MSB - `RDP_CNTL_TAG_DATA_COMBINE_STATE_LSB +1)
`define RDP_CNTL_TAG_DATA_COMBINE_STATE_RANGE          `RDP_CNTL_TAG_DATA_COMBINE_STATE_MSB : `RDP_CNTL_TAG_DATA_COMBINE_STATE_LSB

//--------------------------------------------------------
// Memory Write Pointer/Data packet generator

`define RDP_CNTL_NOC_PKT_GEN_WAIT                             14'b00_0000_0000_0001
`define RDP_CNTL_NOC_PKT_GEN_SEND_ADDR                        14'b00_0000_0000_0010
`define RDP_CNTL_NOC_PKT_GEN_START_PTR                        14'b00_0000_0000_0100
`define RDP_CNTL_NOC_PKT_GEN_APPEND_PTR                       14'b00_0000_0000_1000
`define RDP_CNTL_NOC_PKT_GEN_TRANSFER_PTRS                    14'b00_0000_0001_0000
`define RDP_CNTL_NOC_PKT_GEN_PAD_NOP                          14'b00_0000_0010_0000

`define RDP_CNTL_NOC_PKT_GEN_START_DATA                       14'b00_0000_0100_0000
`define RDP_CNTL_NOC_PKT_GEN_READ_DATA                        14'b00_0000_1000_0000
`define RDP_CNTL_NOC_PKT_GEN_TRANSFER_DATA                    14'b00_0001_0000_0000
`define RDP_CNTL_NOC_PKT_GEN_LAST_DATA                        14'b00_0010_0000_0000

`define RDP_CNTL_NOC_PKT_GEN_FLUSH_STUC                       14'b00_0100_0000_0000
                                                                       
`define RDP_CNTL_NOC_PKT_GEN_COMPLETE                         14'b00_1000_0000_0000
                                                                       
`define RDP_CNTL_NOC_PKT_GEN_TAG_ERR                          14'b01_0000_0000_0000
`define RDP_CNTL_NOC_PKT_GEN_DATA_ERR                         14'b10_0000_0000_0000

`define RDP_CNTL_NOC_PKT_GEN_STATE_WIDTH         14
`define RDP_CNTL_NOC_PKT_GEN_STATE_MSB           `RDP_CNTL_NOC_PKT_GEN_STATE_WIDTH-1
`define RDP_CNTL_NOC_PKT_GEN_STATE_LSB           0
`define RDP_CNTL_NOC_PKT_GEN_STATE_SIZE          (`RDP_CNTL_NOC_PKT_GEN_STATE_MSB - `RDP_CNTL_NOC_PKT_GEN_STATE_LSB +1)
`define RDP_CNTL_NOC_PKT_GEN_STATE_RANGE          `RDP_CNTL_NOC_PKT_GEN_STATE_MSB : `RDP_CNTL_NOC_PKT_GEN_STATE_LSB


//--------------------------------------------------------
//
`define RDP_CNTL_STU_REGS_PER_CYCLE            ( `STACK_UP_INTF_DATA_WIDTH / `PE_EXEC_LANE_WIDTH )
`define RDP_CNTL_STU_NUM_OF_TRANSFERS          ( `PE_NUM_OF_EXEC_LANES / `RDP_CNTL_STU_REGS_PER_CYCLE )
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_WIDTH    (`CLOG2( `RDP_CNTL_STU_NUM_OF_TRANSFERS ))
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_MSB      `RDP_CNTL_STU_NUM_OF_TRANSFERS_WIDTH-1
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_LSB      0
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_SIZE     (`RDP_CNTL_STU_NUM_OF_TRANSFERS_MSB - `RDP_CNTL_STU_NUM_OF_TRANSFERS_LSB +1)
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_RANGE     `RDP_CNTL_STU_NUM_OF_TRANSFERS_MSB : `RDP_CNTL_STU_NUM_OF_TRANSFERS_LSB

`define RDP_CNTL_STU_NUM_OF_TRANSFERS_M1       `RDP_CNTL_STU_NUM_OF_TRANSFERS-1  // to make comparison easy

//--------------------------------------------------------
// Number of active lanes is 1..32, so need 6 bits
  
`define RDP_CNTL_NUM_LANES_WIDTH               (`CLOG2(`PE_NUM_OF_EXEC_LANES))+1
`define RDP_CNTL_NUM_LANES_MSB           `RDP_CNTL_NUM_LANES_WIDTH-1
`define RDP_CNTL_NUM_LANES_LSB            0
`define RDP_CNTL_NUM_LANES_SIZE           (`RDP_CNTL_NUM_LANES_MSB - `RDP_CNTL_NUM_LANES_LSB +1)
`define RDP_CNTL_NUM_LANES_RANGE           `RDP_CNTL_NUM_LANES_MSB : `RDP_CNTL_NUM_LANES_LSB


//------------------------------------------------------------------------------------------------------------



`endif
