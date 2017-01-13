`ifndef _pe_array_vh
`define _pe_array_vh


/*****************************************************************

    File name   : pe_array.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

*****************************************************************/

//------------------------------------------------
// PE Array
//------------------------------------------------

`define PE_ARRAY_NUM_OF_PE                 64

//---------------------------------------------------------------------------------------------------------------------
// Standard interface

// EOM/SOM codes for cntl signal for the "standard" inter-module interface
`define COMMON_STD_INTF_CNTL_WIDTH          2
`define COMMON_STD_INTF_CNTL_MSB            `COMMON_STD_INTF_CNTL_WIDTH-1
`define COMMON_STD_INTF_CNTL_LSB            0
`define COMMON_STD_INTF_CNTL_RANGE          `COMMON_STD_INTF_CNTL_MSB : `COMMON_STD_INTF_CNTL_LSB

`define COMMON_STD_INTF_CNTL_SOM            1
`define COMMON_STD_INTF_CNTL_MOM            0
`define COMMON_STD_INTF_CNTL_EOM            2
`define COMMON_STD_INTF_CNTL_SOM_EOM        3


//---------------------------------------------------------------------------------------------------------------------
// Memory

`define PE_ARRAY_CHIPLET_ADDRESS_WIDTH   24
`define PE_ARRAY_CHIPLET_ADDRESS_MSB     `PE_ARRAY_CHIPLET_ADDRESS_WIDTH-1
`define PE_ARRAY_CHIPLET_ADDRESS_LSB     0
`define PE_ARRAY_CHIPLET_ADDRESS_SIZE    (`PE_ARRAY_CHIPLET_ADDRESS_MSB - `PE_ARRAY_CHIPLET_ADDRESS_LSB +1)
`define PE_ARRAY_CHIPLET_ADDRESS_RANGE    `PE_ARRAY_CHIPLET_ADDRESS_MSB : `PE_ARRAY_CHIPLET_ADDRESS_LSB



`endif


