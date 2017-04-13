`ifndef _manager_array_vh
`define _manager_array_vh


/*****************************************************************

    File name   : manager_array.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/

//------------------------------------------------
// Manager Array
//------------------------------------------------

`define MGR_ARRAY_NUM_OF_MGR                 `PE_ARRAY_NUM_OF_PE 


//---------------------------------------------------------------------------------------------------------------------
// NoC

`define MGR_ARRAY_NOC_INTERNAL_DATA_WIDTH         74
`define MGR_ARRAY_NOC_INTERNAL_DATA_MSB          `MGR_ARRAY_NOC_INTERNAL_DATA_WIDTH-1
`define MGR_ARRAY_NOC_INTERNAL_DATA_LSB          0
`define MGR_ARRAY_NOC_INTERNAL_DATA_RANGE        `MGR_ARRAY_NOC_INTERNAL_DATA_MSB : `MGR_ARRAY_NOC_INTERNAL_DATA_LSB

`define MGR_ARRAY_NOC_EXTERNAL_DATA_WIDTH         73
`define MGR_ARRAY_NOC_EXTERNAL_DATA_MSB          `MGR_ARRAY_NOC_EXTERNAL_DATA_WIDTH-1
`define MGR_ARRAY_NOC_EXTERNAL_DATA_LSB          0
`define MGR_ARRAY_NOC_EXTERNAL_DATA_RANGE        `MGR_ARRAY_NOC_EXTERNAL_DATA_MSB : `MGR_ARRAY_NOC_EXTERNAL_DATA_LSB


`endif


