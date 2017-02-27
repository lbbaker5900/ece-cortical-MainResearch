`ifndef _pe_cntl_vh
`define _pe_cntl_vh

/*****************************************************************

    File name   : pe_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Feb 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/

// OOB option size
`define PE_CNTL_OOB_OPTION_WIDTH   8
`define PE_CNTL_OOB_OPTION_MSB     `PE_CNTL_OOB_OPTION_WIDTH-1
`define PE_CNTL_OOB_OPTION_LSB     0
`define PE_CNTL_OOB_OPTION_SIZE    (`PE_CNTL_OOB_OPTION_MSB - `PE_CNTL_OOB_OPTION_LSB +1)
`define PE_CNTL_OOB_OPTION_RANGE    `PE_CNTL_OOB_OPTION_MSB : `PE_CNTL_OOB_OPTION_LSB

`define PE_CNTL_OOB_OPTION_DATA_WIDTH   8
`define PE_CNTL_OOB_OPTION_DATA_MSB     `PE_CNTL_OOB_OPTION_DATA_WIDTH-1
`define PE_CNTL_OOB_OPTION_DATA_LSB     0
`define PE_CNTL_OOB_OPTION_DATA_SIZE    (`PE_CNTL_OOB_OPTION_DATA_MSB - `PE_CNTL_OOB_OPTION_DATA_LSB +1)
`define PE_CNTL_OOB_OPTION_DATA_RANGE    `PE_CNTL_OOB_OPTION_DATA_MSB : `PE_CNTL_OOB_OPTION_DATA_LSB

// OOB option locations

// First option tuple
`define PE_CNTL_OOB_OPTION0_LSB            0
`define PE_CNTL_OOB_OPTION0_MSB            (`PE_CNTL_OOB_OPTION_WIDTH + `PE_CNTL_OOB_OPTION0_LSB) -1
`define PE_CNTL_OOB_OPTION0_SIZE           (`PE_CNTL_OOB_OPTION0_MSB - `PE_CNTL_OOB_OPTION0_LSB) +1
`define PE_CNTL_OOB_OPTION0_RANGE          `PE_CNTL_OOB_OPTION0_MSB : `PE_CNTL_OOB_OPTION0_LSB
                                           
`define PE_CNTL_OOB_OPTION0_DATA_LSB       `PE_CNTL_OOB_OPTION0_MSB +1
`define PE_CNTL_OOB_OPTION0_DATA_MSB       (`PE_CNTL_OOB_OPTION_WIDTH + `PE_CNTL_OOB_OPTION0_DATA_LSB) -1
`define PE_CNTL_OOB_OPTION0_DATA_SIZE      (`PE_CNTL_OOB_OPTION0_DATA_MSB - `PE_CNTL_OOB_OPTION0_DATA_LSB) +1
`define PE_CNTL_OOB_OPTION0_DATA_RANGE      `PE_CNTL_OOB_OPTION0_DATA_MSB : `PE_CNTL_OOB_OPTION0_DATA_LSB
                                           
// Second option tuple                     
`define PE_CNTL_OOB_OPTION1_LSB            `PE_CNTL_OOB_OPTION0_DATA_MSB +1
`define PE_CNTL_OOB_OPTION1_MSB            (`PE_CNTL_OOB_OPTION_WIDTH + `PE_CNTL_OOB_OPTION1_LSB) -1
`define PE_CNTL_OOB_OPTION1_SIZE           (`PE_CNTL_OOB_OPTION1_MSB - `PE_CNTL_OOB_OPTION1_LSB) +1
`define PE_CNTL_OOB_OPTION1_RANGE          `PE_CNTL_OOB_OPTION1_MSB : `PE_CNTL_OOB_OPTION1_LSB
                                           
`define PE_CNTL_OOB_OPTION1_DATA_LSB       `PE_CNTL_OOB_OPTION1_MSB +1
`define PE_CNTL_OOB_OPTION1_DATA_MSB       (`PE_CNTL_OOB_OPTION_WIDTH + `PE_CNTL_OOB_OPTION1_DATA_LSB) -1
`define PE_CNTL_OOB_OPTION1_DATA_SIZE      (`PE_CNTL_OOB_OPTION1_DATA_MSB - `PE_CNTL_OOB_OPTION1_DATA_LSB) +1
`define PE_CNTL_OOB_OPTION1_DATA_RANGE      `PE_CNTL_OOB_OPTION1_DATA_MSB : `PE_CNTL_OOB_OPTION1_DATA_LSB


// PE stOp option memory size
`define PE_CNTL_STOP_OPTION_MEMORY_DEPTH   256
`define PE_CNTL_STOP_OPTION_MEMORY_RANGE    `PE_CNTL_STOP_OPTION_MEMORY_DEPTH-1 : 0



// OOB options
`define PE_CNTL_OOB_OPTION_STOP   0




`endif
