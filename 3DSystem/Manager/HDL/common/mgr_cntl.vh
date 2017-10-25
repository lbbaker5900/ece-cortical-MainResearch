`ifndef _mgr_cntl_vh
`define _mgr_cntl_vh

/*****************************************************************

    File name   : mgr_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : July 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FSM's
//------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------
// Simple FSM simply to check MgrID from NoC
// - avoids having manager ID removed for SV

`define MGR_CNTL_MAIN_WAIT            5'b0_0001
                                                 
`define MGR_CNTL_MAIN_RCV             5'b0_0010

`define MGR_CNTL_MAIN_COMPLETE        5'b0_1000
                                                  
`define MGR_CNTL_MAIN_ERR             5'b1_0000

`define MGR_CNTL_MAIN_STATE_WIDTH         5
`define MGR_CNTL_MAIN_STATE_MSB           `MGR_CNTL_MAIN_STATE_WIDTH-1
`define MGR_CNTL_MAIN_STATE_LSB           0
`define MGR_CNTL_MAIN_STATE_SIZE          (`MGR_CNTL_MAIN_STATE_MSB - `MGR_CNTL_MAIN_STATE_LSB +1)
`define MGR_CNTL_MAIN_STATE_RANGE          `MGR_CNTL_MAIN_STATE_MSB : `MGR_CNTL_MAIN_STATE_LSB

//------------------------------------------------------------------------------------------------------------

`endif
