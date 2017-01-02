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
// OOB Downstream interface

// EOM/SOM codes for cntl signal for the "standard" inter-module interface
`define STACK_OOB_DOWN_INTF_TYPE_WIDTH          4
`define STACK_OOB_DOWN_INTF_TYPE_MSB            `STACK_OOB_DOWN_INTF_TYPE_WIDTH-1
`define STACK_OOB_DOWN_INTF_TYPE_LSB            0
`define STACK_OOB_DOWN_INTF_TYPE_RANGE          `STACK_OOB_DOWN_INTF_TYPE_MSB : `STACK_OOB_DOWN_INTF_TYPE_LSB

`define STACK_OOB_DOWN_INTF_TYPE_CNTL_SCALAR            0
`define STACK_OOB_DOWN_INTF_TYPE_CNTL_VECTOR            1
`define STACK_OOB_DOWN_INTF_TYPE_DATA_SCALAR            2
`define STACK_OOB_DOWN_INTF_TYPE_DATA_VECTOR            3

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

`define STACK_DOWN_INTF_TYPE_CNTL_SCALAR            0
`define STACK_DOWN_INTF_TYPE_CNTL_VECTOR            1
`define STACK_DOWN_INTF_TYPE_DATA_SCALAR            2
`define STACK_DOWN_INTF_TYPE_DATA_VECTOR            3

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

//---------------------------------------------------------------------------------------------------------------------
// Memory

`define PE_ARRAY_CHIPLET_ADDRESS_WIDTH   24
`define PE_ARRAY_CHIPLET_ADDRESS_MSB     `PE_ARRAY_CHIPLET_ADDRESS_WIDTH-1
`define PE_ARRAY_CHIPLET_ADDRESS_LSB     0
`define PE_ARRAY_CHIPLET_ADDRESS_SIZE    (`PE_ARRAY_CHIPLET_ADDRESS_MSB - `PE_ARRAY_CHIPLET_ADDRESS_LSB +1)
`define PE_ARRAY_CHIPLET_ADDRESS_RANGE    `PE_ARRAY_CHIPLET_ADDRESS_MSB : `PE_ARRAY_CHIPLET_ADDRESS_LSB



`endif


