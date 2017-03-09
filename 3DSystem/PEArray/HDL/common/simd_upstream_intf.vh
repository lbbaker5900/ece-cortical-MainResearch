`ifndef _simd_upstream_intf_vh
`define _simd_upstream_intf_vh

/*****************************************************************


    File name   : simd_upstream_intf.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/

//------------------------------------------------
// FIFO's
//------------------------------------------------

`define SIMD_TO_STI_FIFO_DEPTH          4
`define SIMD_TO_STI_FIFO_THRESHOLD      2


//--------------------------------------------------------
// Transfer from System interface to bank interface

`define SIMD_TO_STI_CNTL_WAIT                  6'b00_0001
`define SIMD_TO_STI_CNTL_MOM                   6'b00_0010
`define SIMD_TO_STI_CNTL_EOM                   6'b00_0100
`define SIMD_TO_STI_CNTL_COMPLETE              6'b00_1000
`define SIMD_TO_STI_CNTL_ERROR                 6'b00_0000

`define SIMD_TO_STI_CNTL_STATE_WIDTH         6
`define SIMD_TO_STI_CNTL_STATE_MSB           `SIMD_TO_STI_CNTL_STATE_WIDTH-1
`define SIMD_TO_STI_CNTL_STATE_LSB           0
`define SIMD_TO_STI_CNTL_STATE_SIZE          (`SIMD_TO_STI_CNTL_STATE_MSB - `SIMD_TO_STI_CNTL_STATE_LSB +1)
`define SIMD_TO_STI_CNTL_STATE_RANGE          `SIMD_TO_STI_CNTL_STATE_MSB : `SIMD_TO_STI_CNTL_STATE_LSB


`define SIMD_TO_STI_REGS_PER_CYCLE            ( `STACK_UP_INTF_DATA_WIDTH / `PE_EXEC_LANE_WIDTH )
`define SIMD_TO_STI_NUM_OF_TRANSFERS          ( `PE_NUM_OF_EXEC_LANES / `SIMD_TO_STI_REGS_PER_CYCLE )
`define SIMD_TO_STI_NUM_OF_TRANSFERS_WIDTH    (`CLOG2( `SIMD_TO_STI_NUM_OF_TRANSFERS ))
`define SIMD_TO_STI_NUM_OF_TRANSFERS_MSB      `SIMD_TO_STI_NUM_OF_TRANSFERS_WIDTH-1
`define SIMD_TO_STI_NUM_OF_TRANSFERS_LSB      0
`define SIMD_TO_STI_NUM_OF_TRANSFERS_SIZE     (`SIMD_TO_STI_NUM_OF_TRANSFERS_MSB - `SIMD_TO_STI_NUM_OF_TRANSFERS_LSB +1)
`define SIMD_TO_STI_NUM_OF_TRANSFERS_RANGE     `SIMD_TO_STI_NUM_OF_TRANSFERS_MSB : `SIMD_TO_STI_NUM_OF_TRANSFERS_LSB

`define SIMD_TO_STI_NUM_OF_TRANSFERS_M1       `SIMD_TO_STI_NUM_OF_TRANSFERS-1  // to make comparison easy

  
//------------------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------------
`endif

