`ifndef _stack_interface_vh
`define _stack_interface_vh


/*****************************************************************

    File name   : stack_interface.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Jan 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/

//------------------------------------------------
// Stack Interface
//------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------
// OOB Downstream interface

`define STACK_DOWN_OOB_INTF_TAG_SIZE           `PE_STD_OOB_TAG_WIDTH   
`define STACK_DOWN_OOB_INTF_TAG_WIDTH          `STACK_DOWN_OOB_INTF_TAG_SIZE
`define STACK_DOWN_OOB_INTF_TAG_MSB            `STACK_DOWN_OOB_INTF_TAG_WIDTH-1
`define STACK_DOWN_OOB_INTF_TAG_LSB            0
`define STACK_DOWN_OOB_INTF_TAG_RANGE          `STACK_DOWN_OOB_INTF_TAG_MSB : `STACK_DOWN_OOB_INTF_TAG_LSB

//---------------------------------------------------------------------------------------------------------------------
// OOB Downstream interface

// EOM/SOM codes for cntl signal for the "standard" inter-module interface
`define STACK_DOWN_OOB_INTF_TYPE_SIZE           4
`define STACK_DOWN_OOB_INTF_TYPE_WIDTH          `STACK_DOWN_OOB_INTF_TYPE_SIZE
`define STACK_DOWN_OOB_INTF_TYPE_MSB            `STACK_DOWN_OOB_INTF_TYPE_WIDTH-1
`define STACK_DOWN_OOB_INTF_TYPE_LSB            0
`define STACK_DOWN_OOB_INTF_TYPE_RANGE          `STACK_DOWN_OOB_INTF_TYPE_MSB : `STACK_DOWN_OOB_INTF_TYPE_LSB

// For now assume OOB commands do not use lane buses to carry PE configuration data
`define STACK_DOWN_OOB_INTF_DATA_SIZE           32
`define STACK_DOWN_OOB_INTF_DATA_WIDTH          `STACK_DOWN_OOB_INTF_DATA_SIZE
`define STACK_DOWN_OOB_INTF_DATA_MSB            `STACK_DOWN_OOB_INTF_DATA_WIDTH-1
`define STACK_DOWN_OOB_INTF_DATA_LSB            0
`define STACK_DOWN_OOB_INTF_DATA_RANGE          `STACK_DOWN_OOB_INTF_DATA_MSB : `STACK_DOWN_OOB_INTF_DATA_LSB

`define STACK_DOWN_OOB_INTF_OPTION_SIZE         8
`define STACK_DOWN_OOB_INTF_VALUE_SIZE          8

`define STACK_DOWN_OOB_INTF_TUPLES_PER_CYCLE  `STACK_DOWN_OOB_INTF_DATA_SIZE/((`STACK_DOWN_OOB_INTF_OPTION_SIZE + `STACK_DOWN_OOB_INTF_VALUE_SIZE))

//---------------------------------------------------------------------------------------------------------------------
// Stack Downstream interface

`define STACK_DOWN_INTF_STRM_DATA_WIDTH          32
`define STACK_DOWN_INTF_STRM_DATA_MSB            `STACK_DOWN_INTF_STRM_DATA_WIDTH-1
`define STACK_DOWN_INTF_STRM_DATA_LSB            0
`define STACK_DOWN_INTF_STRM_DATA_RANGE          `STACK_DOWN_INTF_STRM_DATA_MSB : `STACK_DOWN_INTF_STRM_DATA_LSB

// EOM/SOM codes for cntl signal for the "standard" inter-module interface
`define STACK_DOWN_INTF_TYPE_WIDTH          4
`define STACK_DOWN_INTF_TYPE_MSB            `STACK_DOWN_INTF_TYPE_WIDTH-1
`define STACK_DOWN_INTF_TYPE_LSB            0
`define STACK_DOWN_INTF_TYPE_RANGE          `STACK_DOWN_INTF_TYPE_MSB : `STACK_DOWN_INTF_TYPE_LSB


//---------------------------------------------------------------------------------------------------------------------
// Stack Upstream interface

`define STACK_UP_INTF_DATA_WIDTH                   128
`define STACK_UP_INTF_DATA_MSB                     `STACK_UP_INTF_DATA_WIDTH-1
`define STACK_UP_INTF_DATA_LSB                     0
`define STACK_UP_INTF_DATA_RANGE                   `STACK_UP_INTF_DATA_MSB : `STACK_UP_INTF_DATA_LSB

// EOM/SOM codes for cntl signal for the "standard" inter-module interface
`define STACK_UP_INTF_TYPE_WIDTH                   4
`define STACK_UP_INTF_TYPE_MSB                     `STACK_UP_INTF_TYPE_WIDTH-1
`define STACK_UP_INTF_TYPE_LSB                     0
`define STACK_UP_INTF_TYPE_RANGE                   `STACK_UP_INTF_TYPE_MSB : `STACK_UP_INTF_TYPE_LSB
                                                  
`define STACK_UP_INTF_TYPE_CNTL_SCALAR            0
`define STACK_UP_INTF_TYPE_CNTL_VECTOR            1
`define STACK_UP_INTF_TYPE_DATA_SCALAR            2
`define STACK_UP_INTF_TYPE_DATA_VECTOR            3
                                                  
`define STACK_UP_INTF_OOB_DATA_WIDTH              16
`define STACK_UP_INTF_OOB_DATA_MSB                `STACK_UP_INTF_OOB_DATA_WIDTH-1
`define STACK_UP_INTF_OOB_DATA_LSB                0
`define STACK_UP_INTF_OOB_DATA_RANGE              `STACK_UP_INTF_OOB_DATA_MSB : `STACK_UP_INTF_OOB_DATA_LSB

//---------------------------------------------------------------------------------------------------------------------


`endif


