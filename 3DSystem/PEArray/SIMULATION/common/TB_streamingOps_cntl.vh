`ifndef _TB_streamingOps_cntl_vh
`define _TB_streamingOps_cntl_vh

/*********************************************************************************************

    File name   : TB_streamingOps_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Dec 2016
    email       : lbbaker@ncsu.edu

    Description : System verilog testbench help related to streamingOps_cntl.v

*********************************************************************************************/
    

//------------------------------------------------
// Commands to streamingOps_cntl via regFile
//------------------------------------------------

typedef enum logic [`PE_DATA_TYPES_RANGE ] {
                                            PE_DATA_TYPE_BIT           = 0,
                                            PE_DATA_TYPE_NIBBLE        = 1,
                                            PE_DATA_TYPE_BYTE          = 2,
                                            PE_DATA_TYPE_SWORD         = 3,
                                            PE_DATA_TYPE_WORD          = 4
                                          } PE_DATA_TYPE ;


`endif
