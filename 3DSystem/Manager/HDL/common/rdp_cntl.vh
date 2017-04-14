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

`define RDP_CNTL_TO_NOC_DEST_ADDR_FIFO_DEPTH          4
`define RDP_CNTL_TO_NOC_DEST_ADDR_FIFO_THRESHOLD      2


//--------------------------------------------------------
// Transfer from Stack bus

`define RDP_CNTL_TAG_DATA_COMBINE_WAIT                          12'b0000_0000_0001
`define RDP_CNTL_TAG_DATA_COMBINE_PREPARE_FOR_PTR               12'b0000_0000_0010
`define RDP_CNTL_TAG_DATA_COMBINE_FIRST_WR_PTR                  12'b0000_0000_0100
`define RDP_CNTL_TAG_DATA_COMBINE_HOLD_WR_PTR                   12'b0000_0000_1000
//`define RDP_CNTL_TAG_DATA_COMBINE_WAIT_FOR_WR_PTR               12'b0000_0001_0000
`define RDP_CNTL_TAG_DATA_COMBINE_WR_PTRS_COMPLETE              12'b0000_0010_0000
`define RDP_CNTL_TAG_DATA_COMBINE_BUILD_NOC_PKT                 12'b0000_0100_0000
`define RDP_CNTL_TAG_DATA_COMBINE_SEND_BITFIELD                 12'b0000_1000_0000
`define RDP_CNTL_TAG_DATA_COMBINE_SEND_WR_PTRS                  12'b0001_0000_0000
`define RDP_CNTL_TAG_DATA_COMBINE_SEND_DATA                     12'b0010_0000_0000
                                                                        
`define RDP_CNTL_TAG_DATA_COMBINE_COMPLETE                      12'b0100_0000_0000
                                                                        
`define RDP_CNTL_TAG_DATA_COMBINE_ERR                           12'b1000_0000_0000

`define RDP_CNTL_TAG_DATA_COMBINE_STATE_WIDTH         12
`define RDP_CNTL_TAG_DATA_COMBINE_STATE_MSB           `RDP_CNTL_TAG_DATA_COMBINE_STATE_WIDTH-1
`define RDP_CNTL_TAG_DATA_COMBINE_STATE_LSB           0
`define RDP_CNTL_TAG_DATA_COMBINE_STATE_SIZE          (`RDP_CNTL_TAG_DATA_COMBINE_STATE_MSB - `RDP_CNTL_TAG_DATA_COMBINE_STATE_LSB +1)
`define RDP_CNTL_TAG_DATA_COMBINE_STATE_RANGE          `RDP_CNTL_TAG_DATA_COMBINE_STATE_MSB : `RDP_CNTL_TAG_DATA_COMBINE_STATE_LSB


`define RDP_CNTL_STU_REGS_PER_CYCLE            ( `STACK_UP_INTF_DATA_WIDTH / `PE_EXEC_LANE_WIDTH )
`define RDP_CNTL_STU_NUM_OF_TRANSFERS          ( `PE_NUM_OF_EXEC_LANES / `RDP_CNTL_STU_REGS_PER_CYCLE )
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_WIDTH    (`CLOG2( `RDP_CNTL_STU_NUM_OF_TRANSFERS ))
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_MSB      `RDP_CNTL_STU_NUM_OF_TRANSFERS_WIDTH-1
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_LSB      0
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_SIZE     (`RDP_CNTL_STU_NUM_OF_TRANSFERS_MSB - `RDP_CNTL_STU_NUM_OF_TRANSFERS_LSB +1)
`define RDP_CNTL_STU_NUM_OF_TRANSFERS_RANGE     `RDP_CNTL_STU_NUM_OF_TRANSFERS_MSB : `RDP_CNTL_STU_NUM_OF_TRANSFERS_LSB

`define RDP_CNTL_STU_NUM_OF_TRANSFERS_M1       `RDP_CNTL_STU_NUM_OF_TRANSFERS-1  // to make comparison easy

  
//------------------------------------------------------------------------------------------------------------



`endif
