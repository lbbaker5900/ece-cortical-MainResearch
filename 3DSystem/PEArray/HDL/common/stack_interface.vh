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

// EOM/SOM codes for cntl signal for the "standard" inter-module interface
`define STACK_DOWN_OOB_INTF_TYPE_SIZE           4
`define STACK_DOWN_OOB_INTF_TYPE_WIDTH          `STACK_DOWN_OOB_INTF_TYPE_SIZE
`define STACK_DOWN_OOB_INTF_TYPE_MSB            `STACK_DOWN_OOB_INTF_TYPE_WIDTH-1
`define STACK_DOWN_OOB_INTF_TYPE_LSB            0
`define STACK_DOWN_OOB_INTF_TYPE_RANGE          `STACK_DOWN_OOB_INTF_TYPE_MSB : `STACK_DOWN_OOB_INTF_TYPE_LSB

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

`define STACK_UP_INTF_LANE_RESULT_WIDTH          16
`define STACK_UP_INTF_LANE_RESULT_MSB            `STACK_UP_INTF_LANE_RESULT_WIDTH-1
`define STACK_UP_INTF_LANE_RESULT_LSB            0
`define STACK_UP_INTF_LANE_RESULT_RANGE          `STACK_UP_INTF_LANE_RESULT_MSB : `STACK_UP_INTF_LANE_RESULT_LSB

// EOM/SOM codes for cntl signal for the "standard" inter-module interface
`define STACK_UP_INTF_TYPE_WIDTH          4
`define STACK_UP_INTF_TYPE_MSB            `STACK_UP_INTF_TYPE_WIDTH-1
`define STACK_UP_INTF_TYPE_LSB            0
`define STACK_UP_INTF_TYPE_RANGE          `STACK_UP_INTF_TYPE_MSB : `STACK_UP_INTF_TYPE_LSB

`define STACK_UP_INTF_TYPE_CNTL_SCALAR            0
`define STACK_UP_INTF_TYPE_CNTL_VECTOR            1
`define STACK_UP_INTF_TYPE_DATA_SCALAR            2
`define STACK_UP_INTF_TYPE_DATA_VECTOR            3



`endif


