/*****************************************************************

    File name   : dfi.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2016
    email       : lbbaker@ncsu.edu

*****************************************************************/


//---------------------------------------------------------------------------------------------------------------------
// DiRAM related


`define DFI_TOP_DIRAM4_ADDRESS_WIDTH        12
`define DFI_TOP_DIRAM4_ADDRESS_MSB          `DFI_TOP_DIRAM4_ADDRESS_WIDTH-1
`define DFI_TOP_DIRAM4_ADDRESS_LSB          0
`define DFI_TOP_DIRAM4_ADDRESS_RANGE        `DFI_TOP_DIRAM4_ADDRESS_MSB : `DFI_TOP_DIRAM4_ADDRESS_LSB

`define DFI_TOP_DIRAM4_BANK_WIDTH           5
`define DFI_TOP_DIRAM4_BANK_MSB             `DFI_TOP_DIRAM4_BANK_WIDTH-1
`define DFI_TOP_DIRAM4_BANK_LSB             0
`define DFI_TOP_DIRAM4_BANK_RANGE           `DFI_TOP_DIRAM4_BANK_MSB : `DFI_TOP_DIRAM4_BANK_LSB

`define DFI_TOP_DIRAM4_DATA_WIDTH           32
`define DFI_TOP_DIRAM4_DATA_MSB             `DFI_TOP_DIRAM4_DATA_WIDTH-1
`define DFI_TOP_DIRAM4_DATA_LSB             0
`define DFI_TOP_DIRAM4_DATA_RANGE           `DFI_TOP_DIRAM4_DATA_MSB : `DFI_TOP_DIRAM4_DATA_LSB

