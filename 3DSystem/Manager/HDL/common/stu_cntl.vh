`ifndef _stu_cntl_vh
`define _stu_cntl_vh

/*****************************************************************

    File name   : stu_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// FIFO's
//------------------------------------------------

`define STU_CNTL_RX_FIFO_DEPTH          32
`define STU_CNTL_RX_FIFO_THRESHOLD      8


//--------------------------------------------------------
// Transfer from Stack bus

`define STU_CNTL_RX_CNTL_WAIT                         8'b0000_0001

`define STU_CNTL_RX_CNTL_CONTROL_SOM                  8'b0000_0010
`define STU_CNTL_RX_CNTL_CONTROL_MOM                  8'b0000_0100
`define STU_CNTL_RX_CNTL_CONTROL_COMPLETE             8'b0000_1000

`define STU_CNTL_RX_CNTL_DATA_SOM                     8'b0001_0000
`define STU_CNTL_RX_CNTL_DATA_MOM                     8'b0010_0000
`define STU_CNTL_RX_CNTL_DATA_COMPLETE                8'b0100_0000

`define STU_CNTL_RX_CNTL_ERR                          8'b1000_0000

`define STU_CNTL_RX_CNTL_STATE_WIDTH         8
`define STU_CNTL_RX_CNTL_STATE_MSB           `STU_CNTL_RX_CNTL_STATE_WIDTH-1
`define STU_CNTL_RX_CNTL_STATE_LSB           0
`define STU_CNTL_RX_CNTL_STATE_SIZE          (`STU_CNTL_RX_CNTL_STATE_MSB - `STU_CNTL_RX_CNTL_STATE_LSB +1)
`define STU_CNTL_RX_CNTL_STATE_RANGE          `STU_CNTL_RX_CNTL_STATE_MSB : `STU_CNTL_RX_CNTL_STATE_LSB


  
//------------------------------------------------------------------------------------------------------------



`endif
