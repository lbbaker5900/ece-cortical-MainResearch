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

`define MGR_ARRAY_NUM_OF_MGR_MSB           (`MGR_ARRAY_NUM_OF_MGR -1)
`define MGR_ARRAY_NUM_OF_MGR_LSB            0
`define MGR_ARRAY_NUM_OF_MGR_SIZE           (`MGR_ARRAY_NUM_OF_MGR_MSB - `MGR_ARRAY_NUM_OF_MGR_LSB +1)
`define MGR_ARRAY_NUM_OF_MGR_RANGE           `MGR_ARRAY_NUM_OF_MGR_MSB : `MGR_ARRAY_NUM_OF_MGR_LSB
`define MGR_ARRAY_NUM_OF_MGR_VECTOR        `MGR_ARRAY_NUM_OF_MGR-1 : 0



`define MGR_ARRAY_HOST_ID_WIDTH             ((`CLOG2(`MGR_ARRAY_NUM_OF_MGR))+1)  // extra bit to address host
`define MGR_ARRAY_HOST_ID_MSB               (`MGR_ARRAY_HOST_ID_WIDTH-1)
`define MGR_ARRAY_HOST_ID_LSB               0
`define MGR_ARRAY_HOST_ID_SIZE              (`MGR_ARRAY_HOST_ID_MSB - `MGR_ARRAY_HOST_ID_LSB +1)
`define MGR_ARRAY_HOST_ID_RANGE              `MGR_ARRAY_HOST_ID_MSB : `MGR_ARRAY_HOST_ID_LSB

`define MGR_ARRAY_HOST_ID      `PE_ARRAY_NUM_OF_PE   // host ID is 64 for 8x8 or 4 for 2x2

//---------------------------------------------------------------------------------------------------------------------
// NoC

// The internal NoC is separated into fields so the data is just the data field     
`define MGR_ARRAY_NOC_INTERNAL_DATA_WIDTH         64
`define MGR_ARRAY_NOC_INTERNAL_DATA_MSB          `MGR_ARRAY_NOC_INTERNAL_DATA_WIDTH-1
`define MGR_ARRAY_NOC_INTERNAL_DATA_LSB          0
`define MGR_ARRAY_NOC_INTERNAL_DATA_RANGE        `MGR_ARRAY_NOC_INTERNAL_DATA_MSB : `MGR_ARRAY_NOC_INTERNAL_DATA_LSB

`define MGR_ARRAY_NOC_EXTERNAL_DATA_WIDTH         76
`define MGR_ARRAY_NOC_EXTERNAL_DATA_MSB          `MGR_ARRAY_NOC_EXTERNAL_DATA_WIDTH-1
`define MGR_ARRAY_NOC_EXTERNAL_DATA_LSB          0
`define MGR_ARRAY_NOC_EXTERNAL_DATA_RANGE        `MGR_ARRAY_NOC_EXTERNAL_DATA_MSB : `MGR_ARRAY_NOC_EXTERNAL_DATA_LSB


`endif


