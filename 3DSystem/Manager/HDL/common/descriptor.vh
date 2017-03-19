`ifndef _descriptor_vh
`define _descriptor_vh

/*****************************************************************

    File name   : descriptor.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// Storage descriptor
//------------------------------------------------

`define DESC_POINTER_WIDTH          17
`define DESC_POINTER_MSB            `DESC_POINTER_WIDTH-1
`define DESC_POINTER_LSB            0
`define DESC_POINTER_SIZE          (`DESC_POINTER_MSB - `DESC_POINTER_LSB +1)
`define DESC_POINTER_RANGE          `DESC_POINTER_MSB : `DESC_POINTER_LSB


`endif
