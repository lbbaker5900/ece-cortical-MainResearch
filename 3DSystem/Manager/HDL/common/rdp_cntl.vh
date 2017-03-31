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

`define RDP_CNTL_STU_FIFO_DEPTH          32
`define RDP_CNTL_STU_FIFO_THRESHOLD      8

`define RDP_CNTL_WU_FIFO_DEPTH          32
`define RDP_CNTL_WU_FIFO_THRESHOLD      8


//--------------------------------------------------------
// Transfer from Stack bus

`define RDP_CNTL_STU_CNTL_WAIT                            8'b0000_0001
`define RDP_CNTL_STU_CNTL_SOM                             8'b0000_0010
`define RDP_CNTL_STU_CNTL_MOM                             8'b0000_0100
`define RDP_CNTL_STU_CNTL_START                           8'b0000_1000
`define RDP_CNTL_STU_CNTL_OP_RUNNING                      8'b0001_0000
`define RDP_CNTL_STU_CNTL_WAIT_COMPLETE_DEASSERTED        8'b0010_0000
`define RDP_CNTL_STU_CNTL_COMPLETE                        8'b0100_0000
`define RDP_CNTL_STU_CNTL_ERR                             8'b1000_0000

`define RDP_CNTL_STU_CNTL_STATE_WIDTH         8
`define RDP_CNTL_STU_CNTL_STATE_MSB           `RDP_CNTL_STU_CNTL_STATE_WIDTH-1
`define RDP_CNTL_STU_CNTL_STATE_LSB           0
`define RDP_CNTL_STU_CNTL_STATE_SIZE          (`RDP_CNTL_STU_CNTL_STATE_MSB - `RDP_CNTL_STU_CNTL_STATE_LSB +1)
`define RDP_CNTL_STU_CNTL_STATE_RANGE          `RDP_CNTL_STU_CNTL_STATE_MSB : `RDP_CNTL_STU_CNTL_STATE_LSB


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
