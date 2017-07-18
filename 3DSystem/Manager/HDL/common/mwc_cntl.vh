`ifndef _mwc_cntl_vh
`define _mwc_cntl_vh

/*****************************************************************

    File name   : mwc_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : July 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/


  
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FSM's
//------------------------------------------------------------------------------------------------------------
//
//--------------------------------------------------------
// from RDP and MCNTL options extraction
//  - receive the NoC-like packet and extract write descritor pointer and data
// 

`define MWC_CNTL_PTR_DATA_RCV_WAIT                        8'b0000_0001
`define MWC_CNTL_PTR_DATA_RCV_EXTRACT_DESC_PTR            8'b0000_0010
`define MWC_CNTL_PTR_DATA_RCV_EXTRACT_DATA                8'b0000_0100

`define MWC_CNTL_PTR_DATA_RCV_ERR                         8'b1000_0000

`define MWC_CNTL_PTR_DATA_RCV_STATE_WIDTH         8
`define MWC_CNTL_PTR_DATA_RCV_STATE_MSB           `MWC_CNTL_PTR_DATA_RCV_STATE_WIDTH-1
`define MWC_CNTL_PTR_DATA_RCV_STATE_LSB           0
`define MWC_CNTL_PTR_DATA_RCV_STATE_SIZE          (`MWC_CNTL_PTR_DATA_RCV_STATE_MSB - `MWC_CNTL_PTR_DATA_RCV_STATE_LSB +1)
`define MWC_CNTL_PTR_DATA_RCV_STATE_RANGE          `MWC_CNTL_PTR_DATA_RCV_STATE_MSB : `MWC_CNTL_PTR_DATA_RCV_STATE_LSB
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
// FIFO's
//------------------------------------------------------------------------------------------------------------


//--------------------------------------------------------
//--------------------------------------------------------
// From Mcntl

`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH          16
`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_MSB      (`MWC_CNTL_FROM_MCNTL_FIFO_DEPTH) -1
`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_LSB      0
`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_SIZE     (`MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_MSB - `MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_LSB +1)
`define MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_RANGE     `MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_MSB : `MWC_CNTL_FROM_MCNTL_FIFO_DEPTH_LSB
`define MWC_CNTL_FROM_MCNTL_FIFO_MSB            ((`CLOG2(`MWC_CNTL_FROM_MCNTL_FIFO_DEPTH)) -1)
`define MWC_CNTL_FROM_MCNTL_FIFO_LSB            0
`define MWC_CNTL_FROM_MCNTL_FIFO_SIZE           (`MWC_CNTL_FROM_MCNTL_FIFO_MSB - `MWC_CNTL_FROM_MCNTL_FIFO_LSB +1)
`define MWC_CNTL_FROM_MCNTL_FIFO_RANGE           `MWC_CNTL_FROM_MCNTL_FIFO_MSB : `MWC_CNTL_FROM_MCNTL_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_WIDTH    `MGR_NOC_CONT_INTERNAL_DATA_WIDTH 
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_MSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_WIDTH-1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_LSB      0
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_LSB

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_WIDTH      1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_MSB      (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_LSB+`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_WIDTH ) -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_LSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_MSB+1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_LSB

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_WIDTH    `MGR_NOC_CONT_NOC_PAYLOAD_TYPE_WIDTH            
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_MSB      (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_LSB+`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_WIDTH ) -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_LSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_MSB+1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_LSB

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_WIDTH     `COMMON_STD_INTF_CNTL_WIDTH 
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_MSB      (`MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_LSB+`MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_WIDTH ) -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_LSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_TYPE_MSB+1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_LSB



`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_WIDTH     `MWC_CNTL_FROM_MCNTL_AGGREGATE_DATA_WIDTH            \
                                                    +`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_VALID_WIDTH   \
                                                    +`MWC_CNTL_FROM_MCNTL_AGGREGATE_PAYLOAD_TYPE_WIDTH    \
                                                    +`MWC_CNTL_FROM_MCNTL_AGGREGATE_CNTL_WIDTH            

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_MSB            `MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_WIDTH -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_LSB            0
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_SIZE           (`MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_RANGE           `MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_FIFO_LSB


// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define MWC_CNTL_FROM_MCNTL_FIFO_ALMOST_FULL_THRESHOLD 4

//--------------------------------------------------------
//--------------------------------------------------------

`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FOO_MSB      1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_WIDTH      1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_MSB      (`MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_LSB+`MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_WIDTH      ) -1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_LSB      `MWC_CNTL_FROM_MCNTL_AGGREGATE_FOO_MSB+1
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_SIZE     (`MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_MSB - `MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_LSB +1)
`define MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_RANGE     `MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_MSB : `MWC_CNTL_FROM_MCNTL_AGGREGATE_FUZZ_LSB





//------------------------------------------------------------------------------------------------------------

`endif