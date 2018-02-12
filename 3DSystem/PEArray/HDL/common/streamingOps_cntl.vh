`ifndef _streamingOps_cntl_vh
`define _streamingOps_cntl_vh

/*****************************************************************

    File name   : streamingOps_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// PE_ARRAY
//------------------------------------------------

`define STREAMING_OP_CNTL_PE_ID_MSB     `PE_PE_ID_MSB
`define STREAMING_OP_CNTL_PE_ID_LSB     0
`define STREAMING_OP_CNTL_PE_ID_SIZE    (`STREAMING_OP_CNTL_PE_ID_MSB - `STREAMING_OP_CNTL_PE_ID_LSB +1)
`define STREAMING_OP_CNTL_PE_ID_RANGE    `STREAMING_OP_CNTL_PE_ID_MSB : `STREAMING_OP_CNTL_PE_ID_LSB

`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_WIDTH   `PE_CHIPLET_ADDRESS_WIDTH
`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB     `STREAMING_OP_CNTL_CHIPLET_ADDRESS_WIDTH-1
`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_LSB     0
`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_SIZE    (`STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB - `STREAMING_OP_CNTL_CHIPLET_ADDRESS_LSB +1)
`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE    `STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB : `STREAMING_OP_CNTL_CHIPLET_ADDRESS_LSB

// Used by CNTL to determine which PE address resides
`define STREAMING_OP_CNTL_PE_DECODE_ADDRESS_MSB    `PE_ARRAY_CHIPLET_ADDRESS_MSB
`define STREAMING_OP_CNTL_PE_DECODE_ADDRESS_LSB    (`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_MSB    - ((`CLOG2(`PE_ARRAY_NUM_OF_PE))-1))
`define STREAMING_OP_CNTL_PE_DECODE_ADDRESS_SIZE   (`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_MSB - `STREAMING_OP_CNTL_PE_DECODE_ADDRESS_LSB +1)
`define STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE   `STREAMING_OP_CNTL_PE_DECODE_ADDRESS_MSB : `STREAMING_OP_CNTL_PE_DECODE_ADDRESS_LSB

`define STREAMING_OP_CNTL_EXEC_LANE_ID_MSB     `PE_EXEC_LANE_ID_MSB
`define STREAMING_OP_CNTL_EXEC_LANE_ID_LSB     0
`define STREAMING_OP_CNTL_EXEC_LANE_ID_SIZE    (`STREAMING_OP_CNTL_EXEC_LANE_ID_MSB - `STREAMING_OP_CNTL_EXEC_LANE_ID_LSB +1)
`define STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE    `STREAMING_OP_CNTL_EXEC_LANE_ID_MSB : `STREAMING_OP_CNTL_EXEC_LANE_ID_LSB

//------------------------------------------------
// PE_SIMD_INTERFACE
//------------------------------------------------


//------------------------------------------------
// STREAMING_OP DATA and CNTL width
//------------------------------------------------
`define STREAMING_OP_CNTL_DATA_WIDTH              `PE_STD_LANE_DATA_WIDTH
`define STREAMING_OP_CNTL_DATA_MSB                `STREAMING_OP_CNTL_DATA_WIDTH-1
`define STREAMING_OP_CNTL_DATA_LSB                 0
`define STREAMING_OP_CNTL_DATA_RANGE                `STREAMING_OP_CNTL_DATA_MSB : `STREAMING_OP_CNTL_DATA_LSB
`define STREAMING_OP_CNTL_DATA_SIZE                (`STREAMING_OP_CNTL_DATA_MSB - `STREAMING_OP_CNTL_DATA_LSB +1)

`define STREAMING_OP_CNTL_STRM_CNTL_MSB            1
`define STREAMING_OP_CNTL_STRM_CNTL_LSB            0
`define STREAMING_OP_CNTL_STRM_CNTL_SIZE           (`STREAMING_OP_CNTL_STRM_CNTL_MSB - `STREAMING_OP_CNTL_STRM_CNTL_LSB +1)
`define STREAMING_OP_CNTL_STRM_CNTL_RANGE           `STREAMING_OP_CNTL_STRM_CNTL_MSB : `STREAMING_OP_CNTL_STRM_CNTL_LSB

`define STREAMING_OP_CNTL_STRM_CNTL_SOP            1
`define STREAMING_OP_CNTL_STRM_CNTL_DATA           0
`define STREAMING_OP_CNTL_STRM_CNTL_EOP            2
`define STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP        3

`define STREAMING_OP_CNTL_STRM_CNTL_SOD            1
`define STREAMING_OP_CNTL_STRM_CNTL_EOD            2
`define STREAMING_OP_CNTL_STRM_CNTL_SOD_EOD        3

`define STREAMING_OP_CNTL_TYPE_MSB            `NOC_CONT_NOC_PACKET_TYPE_MSB
`define STREAMING_OP_CNTL_TYPE_LSB            0
`define STREAMING_OP_CNTL_TYPE_SIZE           (`STREAMING_OP_CNTL_TYPE_MSB - `STREAMING_OP_CNTL_TYPE_LSB +1)
`define STREAMING_OP_CNTL_TYPE_RANGE           `STREAMING_OP_CNTL_TYPE_MSB : `STREAMING_OP_CNTL_TYPE_LSB

`define STREAMING_OP_CNTL_TYPE_STATUS            `NOC_CONT_TYPE_STATUS       
`define STREAMING_OP_CNTL_TYPE_WRITE_REQUEST     `NOC_CONT_TYPE_WRITE_REQUEST
`define STREAMING_OP_CNTL_TYPE_DMA_REQUEST       `NOC_CONT_TYPE_DMA_REQUEST  
`define STREAMING_OP_CNTL_TYPE_READ_REQUEST      `NOC_CONT_TYPE_READ_REQUEST 
`define STREAMING_OP_CNTL_TYPE_READ_RESPONCE     `NOC_CONT_TYPE_READ_RESPONCE
`define STREAMING_OP_CNTL_TYPE_DMA_DATA          `NOC_CONT_TYPE_DMA_DATA     
`define STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD      `NOC_CONT_TYPE_DMA_DATA_SOD  
`define STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD      `NOC_CONT_TYPE_DMA_DATA_EOD  

//------------------------------------------------
// STREAMING_OP_CNTL MEM REQUEST state machine states
//------------------------------------------------

// Main controller - Controls Memory access request
`define STREAMING_OP_CNTL_WAIT                     6'b00_0001
`define STREAMING_OP_CNTL_MEM_REQ                  6'b00_0010
`define STREAMING_OP_CNTL_MEM_GRANTED              6'b00_0100
`define STREAMING_OP_CNTL_OP_INIT                  6'b00_1000
`define STREAMING_OP_CNTL_RELEASE_MEM              6'b01_0000
`define STREAMING_OP_CNTL_COMPLETE                 6'b10_0000

// "to NoC" Control FSM
`define STREAMING_OP_CNTL_TONOC_CONT_WAIT            5'b0_0001
`define STREAMING_OP_CNTL_TONOC_CONT_REQ             5'b0_0010
`define STREAMING_OP_CNTL_TONOC_CONT_SEND_1ST_CYCLE  5'b0_0100
`define STREAMING_OP_CNTL_TONOC_CONT_SEND_2ND_CYCLE  5'b0_1000
`define STREAMING_OP_CNTL_TONOC_CONT_COMPLETE        5'b1_0000

// "from NoC" Control FSM
`define STREAMING_OP_CNTL_FROMNOC_CONT_WAIT                 6'b00_0001
`define STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1  6'b00_0010
`define STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE2  6'b00_0100
`define STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ              6'b00_1000
`define STREAMING_OP_CNTL_FROMNOC_CONT_DMA_ACK              6'b01_0000
`define STREAMING_OP_CNTL_FROMNOC_CONT_ERROR                6'b10_0000

// "to NoC" Data FSM
`define STREAMING_OP_CNTL_TONOC_DATA_WAIT               6'b00_0001
`define STREAMING_OP_CNTL_TONOC_DATA_ENABLE_READ        6'b00_0010
`define STREAMING_OP_CNTL_TONOC_DATA_TX_PKT             6'b00_0100
`define STREAMING_OP_CNTL_TONOC_DATA_SEND_1ST_CYCLE     6'b00_1000
`define STREAMING_OP_CNTL_TONOC_DATA_SEND_OTHER_CYCLES  6'b01_0000
`define STREAMING_OP_CNTL_TONOC_DATA_COMPLETE           6'b10_0000

// "from NoC (to stOp)" Data FSM
`define STREAMING_OP_CNTL_FROMNOC_DATA_WAIT             5'b0_0001
`define STREAMING_OP_CNTL_FROMNOC_DATA_ENABLE_READ      5'b0_0010
`define STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT       5'b0_0100
`define STREAMING_OP_CNTL_FROMNOC_DATA_READ             5'b0_1000
`define STREAMING_OP_CNTL_FROMNOC_DATA_COMPLETE         5'b1_0000


//------------------------------------------------
// STREAMING_OP_CNTL_STATE width
//------------------------------------------------
`define STREAMING_OP_CNTL_STATE_MSB           5
`define STREAMING_OP_CNTL_STATE_LSB           0
`define STREAMING_OP_CNTL_STATE_SIZE          (`STREAMING_OP_CNTL_STATE_MSB - `STREAMING_OP_CNTL_STATE_LSB +1)
`define STREAMING_OP_CNTL_STATE_RANGE          `STREAMING_OP_CNTL_STATE_MSB : `STREAMING_OP_CNTL_STATE_LSB

// Per lane stream controller - starts each stOp and DMA and makes DMA requests to the "to NoC" Control FSM
`define STREAMING_OP_CNTL_STRM_WAIT                                      7'b000_0001
`define STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE                          7'b000_0010
`define STREAMING_OP_CNTL_STRM_ENABLE_STOP                               7'b000_0100
`define STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ                           7'b000_1000
`define STREAMING_OP_CNTL_STRM_OP_START                                  7'b001_0000
`define STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC                             7'b010_0000
`define STREAMING_OP_CNTL_STRM_COMPLETE                                  7'b100_0000

`define STREAMING_OP_CNTL_STRM_STATE_MSB     7
`define STREAMING_OP_CNTL_STRM_STATE_LSB      0
`define STREAMING_OP_CNTL_STRM_STATE_SIZE     (`STREAMING_OP_CNTL_STRM_STATE_MSB - `STREAMING_OP_CNTL_STRM_STATE_LSB +1)
`define STREAMING_OP_CNTL_STRM_STATE_RANGE     `STREAMING_OP_CNTL_STRM_STATE_MSB : `STREAMING_OP_CNTL_STRM_STATE_LSB

`define STREAMING_OP_CNTL_TONOC_CONT_STATE_MSB      4
`define STREAMING_OP_CNTL_TONOC_CONT_STATE_LSB      0
`define STREAMING_OP_CNTL_TONOC_CONT_STATE_SIZE     (`STREAMING_OP_CNTL_TONOC_CONT_STATE_MSB - `STREAMING_OP_CNTL_TONOC_CONT_STATE_LSB +1)
`define STREAMING_OP_CNTL_TONOC_CONT_STATE_RANGE     `STREAMING_OP_CNTL_TONOC_CONT_STATE_MSB : `STREAMING_OP_CNTL_TONOC_CONT_STATE_LSB

`define STREAMING_OP_CNTL_FROMNOC_CONT_STATE_MSB      5
`define STREAMING_OP_CNTL_FROMNOC_CONT_STATE_LSB      0
`define STREAMING_OP_CNTL_FROMNOC_CONT_STATE_SIZE     (`STREAMING_OP_CNTL_FROMNOC_CONT_STATE_MSB - `STREAMING_OP_CNTL_FROMNOC_CONT_STATE_LSB +1)
`define STREAMING_OP_CNTL_FROMNOC_CONT_STATE_RANGE     `STREAMING_OP_CNTL_FROMNOC_CONT_STATE_MSB : `STREAMING_OP_CNTL_FROMNOC_CONT_STATE_LSB

`define STREAMING_OP_CNTL_TONOC_DATA_STATE_MSB      5
`define STREAMING_OP_CNTL_TONOC_DATA_STATE_LSB      0
`define STREAMING_OP_CNTL_TONOC_DATA_STATE_SIZE     (`STREAMING_OP_CNTL_TONOC_DATA_STATE_MSB - `STREAMING_OP_CNTL_TONOC_DATA_STATE_LSB +1)
`define STREAMING_OP_CNTL_TONOC_DATA_STATE_RANGE     `STREAMING_OP_CNTL_TONOC_DATA_STATE_MSB : `STREAMING_OP_CNTL_TONOC_DATA_STATE_LSB

`define STREAMING_OP_CNTL_FROMNOC_DATA_STATE_MSB      4
`define STREAMING_OP_CNTL_FROMNOC_DATA_STATE_LSB      0
`define STREAMING_OP_CNTL_FROMNOC_DATA_STATE_SIZE     (`STREAMING_OP_CNTL_FROMNOC_DATA_STATE_MSB - `STREAMING_OP_CNTL_FROMNOC_DATA_STATE_LSB +1)
`define STREAMING_OP_CNTL_FROMNOC_DATA_STATE_RANGE     `STREAMING_OP_CNTL_FROMNOC_DATA_STATE_MSB : `STREAMING_OP_CNTL_FROMNOC_DATA_STATE_LSB

`define STREAMING_OP_CNTL_NOC_DATA_TRANSACTION_COUNT_MSB      5
`define STREAMING_OP_CNTL_NOC_DATA_TRANSACTION_COUNT_LSB      0
`define STREAMING_OP_CNTL_NOC_DATA_TRANSACTION_COUNT_SIZE     (`STREAMING_OP_CNTL_NOC_DATA_TRANSACTION_COUNT_MSB - `STREAMING_OP_CNTL_NOC_DATA_TRANSACTION_COUNT_LSB +1)
`define STREAMING_OP_CNTL_NOC_DATA_TRANSACTION_COUNT_RANGE     `STREAMING_OP_CNTL_NOC_DATA_TRANSACTION_COUNT_MSB : `STREAMING_OP_CNTL_NOC_DATA_TRANSACTION_COUNT_LSB


`define STREAMING_OP_CNTL_OPERATION_STREAM_SRC_SIZE     3                                                                            
`define STREAMING_OP_CNTL_OPERATION_STREAM_SRC_MSB      (`STREAMING_OP_CNTL_OPERATION_STREAM_SRC_LSB + `STREAMING_OP_CNTL_OPERATION_STREAM_SRC_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_SRC_LSB      0
`define STREAMING_OP_CNTL_OPERATION_STREAM_SRC_RANGE    `STREAMING_OP_CNTL_OPERATION_STREAM_SRC_MSB : `STREAMING_OP_CNTL_OPERATION_STREAM_SRC_LSB     

`define STREAMING_OP_CNTL_OPERATION_STREAM_DEST_SIZE     3                                                                            
`define STREAMING_OP_CNTL_OPERATION_STREAM_DEST_MSB      (`STREAMING_OP_CNTL_OPERATION_STREAM_DEST_LSB + `STREAMING_OP_CNTL_OPERATION_STREAM_DEST_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_DEST_LSB      0
`define STREAMING_OP_CNTL_OPERATION_STREAM_DEST_RANGE    `STREAMING_OP_CNTL_OPERATION_STREAM_DEST_MSB : `STREAMING_OP_CNTL_OPERATION_STREAM_DEST_LSB     
                                                             
                                                             
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
// Start of operations struct - must match pe_stOp_operation in / TB_streamingOps_cntl.vh
//----------------------------------------------------------------------------------------------------
//------------------------------------------------
// STREAMING_OP_CNTL Operations
//------------------------------------------------

`define STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_SIZE     3                                                                            
`define STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_MSB      (`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_LSB + `STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_LSB      0
`define STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE    `STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_MSB : `STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_LSB     
                                                             
`define STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_SIZE      3                                                                                                                                                                           
`define STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_MSB       (`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_LSB + `STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_LSB       (`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_MSB + 1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE     `STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_MSB : `STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_LSB

`define STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_SIZE     3                                                                            
`define STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_MSB      (`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_LSB + `STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_LSB      (`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_MSB + 1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE    `STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_MSB : `STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_LSB     
                                                             
`define STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_SIZE      3                                                                                                                                                                           
`define STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_MSB       (`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_LSB + `STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_LSB       (`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_MSB + 1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE     `STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_MSB : `STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_LSB

`define STREAMING_OP_CNTL_OPERATION_OPCODE_SIZE              5                                                                                                                                                                           
`define STREAMING_OP_CNTL_OPERATION_OPCODE_MSB               (`STREAMING_OP_CNTL_OPERATION_OPCODE_LSB + `STREAMING_OP_CNTL_OPERATION_OPCODE_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_OPCODE_LSB               (`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_MSB + 1)
`define STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE             `STREAMING_OP_CNTL_OPERATION_OPCODE_MSB : `STREAMING_OP_CNTL_OPERATION_OPCODE_LSB     
`define STREAMING_OP_CNTL_OPERATION_BITSUM                   0
`define STREAMING_OP_CNTL_OPERATION_BYTESUM                  1
`define STREAMING_OP_CNTL_OPERATION_FP_MAC                   2
`define STREAMING_OP_CNTL_OPERATION_FP_MAX                   3
`define STREAMING_OP_CNTL_OPERATION_FP_FIRST_GT              4
`define STREAMING_OP_CNTL_OPERATION_FP_MAX_N                 5
`define STREAMING_OP_CNTL_OPERATION_FP_MAX_N_THR             6
`define STREAMING_OP_CNTL_OPERATION_FP_MAX_ALL_THR           7
`define STREAMING_OP_CNTL_OPERATION_FP_MULT                  8
//`define STREAMING_OP_CNTL_OPERATION_NOP_MEM_TO_MEM          16
//`define STREAMING_OP_CNTL_OPERATION_NOP_MEM_TO_NOC          17
`define STREAMING_OP_CNTL_OPERATION_NOP                     31

`define STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_SIZE           2                                                                                                                                                                           
`define STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_MSB            (`STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_LSB + `STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_LSB            (`STREAMING_OP_CNTL_OPERATION_OPCODE_MSB + 1)
`define STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_RANGE          `STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_MSB : `STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_LSB     

`define STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_SIZE           2                                                                                                                                                                           
`define STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_MSB            (`STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_LSB + `STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_LSB            (`STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_MSB + 1)
`define STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_RANGE          `STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_MSB : `STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_LSB     

//----------------------------------------------------------------------------------------------------
// End of operations struct - must match pe_stOp_operation in TB_streamingOps_cntl.vh
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//
// SRC and DEST codes
`define STREAMING_OP_CNTL_OPERATION_FROM_NONE                0
`define STREAMING_OP_CNTL_OPERATION_FROM_MEMORY              1
`define STREAMING_OP_CNTL_OPERATION_FROM_EXT                 2  // FIXME : use STD not EXT
`define STREAMING_OP_CNTL_OPERATION_FROM_STD                 2
`define STREAMING_OP_CNTL_OPERATION_FROM_NOC                 3
`define STREAMING_OP_CNTL_OPERATION_FROM_REG                 4  // SIMD
`define STREAMING_OP_CNTL_OPERATION_FROM_SIMD                4  // SIMD

`define STREAMING_OP_CNTL_OPERATION_TO_NONE                  0
`define STREAMING_OP_CNTL_OPERATION_TO_MEMORY                1
`define STREAMING_OP_CNTL_OPERATION_TO_STD                   2
`define STREAMING_OP_CNTL_OPERATION_TO_NOC                   3
`define STREAMING_OP_CNTL_OPERATION_TO_REG                   4  // SIMD
`define STREAMING_OP_CNTL_OPERATION_TO_SIMD                  4  // SIMD

// FIXME : get rid of number of streams. Use src and dest to determine number
// FIXME: make sure we track order of struct in TB_streamingOps_cntl.vh
//                                                                    num    num                                                         
//                                                                    dest   src                                                          strm1   strm0  strm1   strm0
//                                                                   strms  strms                   opcode                                 dest    dest   src     src
`define STREAMING_OP_CNTL_OPERATION_MEM_MEM_BITSUM_TO_MEM            {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_BITSUM            ,   3'd0,   3'd1,  3'd1,   3'd1         } 
`define STREAMING_OP_CNTL_OPERATION_MEM_MEM_BITSUM_TO_REG            {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_BITSUM            ,   3'd2,   3'd2,  3'd1,   3'd1         } 
`define STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM              {2'd1,  2'd1,   5'd`STREAMING_OP_CNTL_OPERATION_NOP               ,   3'd0,   3'd1,  3'd0,   3'd2         } 
`define STREAMING_OP_CNTL_OPERATION_STD_STD_NOP_TO_MEM               {2'd2,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_NOP               ,   3'd1,   3'd1,  3'd2,   3'd2         } 
`define STREAMING_OP_CNTL_OPERATION_MEM_MEM_FP_MAC_TO_MEM            {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAC            ,   3'd0,   3'd1,  3'd1,   3'd1         } 
`define STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM            {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAC            ,   3'd0,   3'd1,  3'd2,   3'd2         } 
`define STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM            {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAC            ,   3'd0,   3'd1,  3'd2,   3'd1         } 
`define STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAX_TO_MEM            {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAX            ,   3'd0,   3'd1,  3'd2,   3'd2         } 
`define STREAMING_OP_CNTL_OPERATION_MEM_MEM_FP_FIRST_GT_TO_MEM       {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_FIRST_GT       ,   3'd0,   3'd1,  3'd1,   3'd1         }  // find first element to exceed a threshold and return index. Input is ptr to array and ptr to threshold
`define STREAMING_OP_CNTL_OPERATION_MEM_NONE_NOP_TO_MEM              {2'd1,  2'd1,   5'd`STREAMING_OP_CNTL_OPERATION_NOP               ,   3'd0,   3'd1,  3'd0,   3'd1         }  // Doesnt assume uCode knows if memory is local or not

/*
TBD
`define STREAMING_OP_CNTL_OPERATION_FP_MAX_N_FROM_MEM_TO_MEM         {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAX_N          ,   3'd0,   3'd1,  3'd1,   3'd1         }  // find highest N elements. Input is ptr to array and ptr to int N
`define STREAMING_OP_CNTL_OPERATION_FP_MAX_N_THR_FROM_MEM_TO_MEM     {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAX_N_THR      ,   3'd0,   3'd1,  3'd1,   3'd1         }  // find highest N elements. Input is ptr to array and ptr to struct containing int N and float Thr
`define STREAMING_OP_CNTL_OPERATION_FP_MAX_ALL_THR_FROM_MEM_TO_MEM   {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAX_ALL_THR    ,   3'd0,   3'd1,  3'd1,   3'd1         }  // find all elements that exceed a threshold. Input is ptr to array and ptr to struct containing int N and float Thr
*/

/*

`define STREAMING_OP_CNTL_OPERATION_FP_MAC_FROM_EXT_TO_MEM           {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAC            ,   3'd0,   3'd1,  3'd2,   3'd2         } 
`define STREAMING_OP_CNTL_OPERATION_FP_MAC_FROM_STD_TO_MEM           {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAC            ,   3'd0,   3'd1,  3'd2,   3'd2         } 


`define STREAMING_OP_CNTL_OPERATION_NOP_FROM_ONE_STD_TO_MEM          {2'd1,  2'd1,   5'd`STREAMING_OP_CNTL_OPERATION_NOP               ,   3'd0,   3'd1,  3'd2,   3'd2         } 

`define STREAMING_OP_CNTL_OPERATION_FP_MAC_FROM_STD_MEM_TO_MEM       {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_FP_MAC            ,   3'd0,   3'd1,  3'd2,   3'd2         } 
                                                                                                                                                                               
`define STREAMING_OP_CNTL_OPERATION_NOP_FROM_MEM_TO_MEM              {2'd1,  2'd1,   5'd`STREAMING_OP_CNTL_OPERATION_NOP               ,   3'd0,   3'd1,  3'd0,   3'd1         }  // Doesnt assume uCode knows if memory is local or not
                                                                                                                                                                                  // Controller determines if address is local or an NoC request is required
//`define STREAMING_OP_CNTL_OPERATION_NOP_FROM_MEM_TO_NOC              {2'd1,  2'd1,  5'd`STREAMING_OP_CNTL_OPERATION_NOP              ,   3'd3,   3'd3,  3'd0,   3'd1         }  // This command is specific to DMA requests from other PE's
                                                                                                                                                                                  // This command will be constructed within the cntl module when seeing dma requests from the NoC
                                                                                                                                                                               
`define STREAMING_OP_CNTL_OPERATION_NOP_FROM_ONE_EXT_TO_MEM          {2'd1,  2'd1,  5'd`STREAMING_OP_CNTL_OPERATION_NOP                ,   3'd0,   3'd1,  3'd2,   3'd2         } 
`define STREAMING_OP_CNTL_OPERATION_NOP_FROM_TWO_EXT_TO_MEM          {2'd2,  2'd2,  5'd`STREAMING_OP_CNTL_OPERATION_NOP                ,   3'd1,   3'd1,  3'd2,   3'd2         } 
*/

//------------------------------------------------
// STREAMING_OP_CNTL variable widths
//------------------------------------------------

`define STREAMING_OP_CNTL_OPERATION_SIZE            ( \
                                                     `STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_SIZE + \
                                                     `STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_SIZE  + \
                                                     `STREAMING_OP_CNTL_OPERATION_OPCODE_SIZE              + \
                                                     `STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_SIZE     + \
                                                     `STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_SIZE    + \
                                                     `STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_SIZE      + \
                                                     `STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_SIZE       \
                                                    )

`define STREAMING_OP_CNTL_OPERATION_WIDTH          `STREAMING_OP_CNTL_OPERATION_SIZE
`define STREAMING_OP_CNTL_OPERATION_MSB            `STREAMING_OP_CNTL_OPERATION_WIDTH-1
`define STREAMING_OP_CNTL_OPERATION_LSB            0
`define STREAMING_OP_CNTL_OPERATION_RANGE           `STREAMING_OP_CNTL_OPERATION_MSB : `STREAMING_OP_CNTL_OPERATION_LSB

//------------------------------------------------
// STREAMING_OP_CNTL_SOURCE 
//------------------------------------------------
`define STREAMING_OP_CNTL_SOURCE_MSB            2
`define STREAMING_OP_CNTL_SOURCE_LSB            0
`define STREAMING_OP_CNTL_SOURCE_SIZE           (`STREAMING_OP_CNTL_SOURCE_MSB - `STREAMING_OP_CNTL_SOURCE_LSB +1)
`define STREAMING_OP_CNTL_SOURCE_RANGE           `STREAMING_OP_CNTL_SOURCE_MSB : `STREAMING_OP_CNTL_SOURCE_LSB

`define STREAMING_OP_CNTL_SOURCE_DMA            0
`define STREAMING_OP_CNTL_SOURCE_EXTERNAL       1

//------------------------------------------------------------------------------------------------
//------------------------------------------------
// FIFO's
//------------------------------------------------

//------------------------------------------------
// STREAMING_OP FIFO
//------------------------------------------------

// FIXME: May need to be deeper. Currently enuff for 1.5X DMA packet
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH          32
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_MSB      (`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH) -1
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_LSB      0
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_SIZE     (`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_MSB - `STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_LSB +1)
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_RANGE     `STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_MSB : `STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_LSB
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_MSB            ((`CLOG2(`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH)) -1)
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_LSB            0
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_SIZE           (`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_MSB - `STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_LSB +1)
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE           `STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_MSB : `STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_LSB

`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_MSB     2
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_LSB     0
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_SIZE    (`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_MSB - `STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_LSB +1)
`define STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_RANGE    `STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_MSB : `STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_LSB

// FIXME: May need to be deeper. Currently enuff for 1.5X DMA packet
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH          32
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_MSB      (`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH) -1
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_LSB      0
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_SIZE     (`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_MSB - `STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_LSB +1)
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_RANGE     `STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_MSB : `STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_LSB
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_MSB            ((`CLOG2(`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH)) -1)
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_LSB            0
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_SIZE           (`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_MSB - `STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_LSB +1)
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_RANGE           `STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_MSB : `STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_LSB

`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_MSB     2
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_LSB     0
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_SIZE    (`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_MSB - `STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_LSB +1)
`define STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_RANGE    `STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_MSB : `STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_LSB


//------------------------------------------------
// to NoC Control FIFO
//------------------------------------------------

`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH          16
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_MSB      (`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH) -1
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_LSB      0
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_SIZE     (`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_MSB - `STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_LSB +1)
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE     `STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_MSB : `STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_LSB
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_MSB            ((`CLOG2(`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH)) -1)
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_LSB            0
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_SIZE           (`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_MSB - `STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_LSB +1)
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE           `STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_MSB : `STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_LSB

`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_MSB     2
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_LSB     0
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_SIZE    (`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_MSB - `STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_LSB +1)
`define STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_RANGE    `STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_MSB : `STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_LSB

//------------------------------------------------
// from NoC Control FIFO
//------------------------------------------------

`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH          32
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_MSB      (`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH) -1
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_LSB      0
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_SIZE     (`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_MSB - `STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_LSB +1)
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE     `STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_MSB : `STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_LSB
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_MSB            ((`CLOG2(`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH)) -1)
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_LSB            0
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_SIZE           (`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_MSB - `STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_LSB +1)
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_RANGE           `STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_MSB : `STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_LSB

`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_MSB     2
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_LSB     0
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_SIZE    (`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_MSB - `STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_LSB +1)
`define STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_RANGE    `STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_MSB : `STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_LSB

//------------------------------------------------
// NOC interface protocol
//------------------------------------------------
`define STREAMING_OP_CNTL_NOC_PROTOCOL_CNTL_SOP      `NOC_CONT_NOC_PROTOCOL_CNTL_SOP            
`define STREAMING_OP_CNTL_NOC_PROTOCOL_CNTL_DATA     `NOC_CONT_NOC_PROTOCOL_CNTL_DATA           
`define STREAMING_OP_CNTL_NOC_PROTOCOL_CNTL_EOP      `NOC_CONT_NOC_PROTOCOL_CNTL_EOP            
`define STREAMING_OP_CNTL_NOC_PROTOCOL_CNTL_SOP_EOP  `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP        
                                            
`define STREAMING_OP_CNTL_NOC_PROTOCOL_CNTL_SOD      `NOC_CONT_NOC_PROTOCOL_CNTL_SOD            
`define STREAMING_OP_CNTL_NOC_PROTOCOL_CNTL_EOD      `NOC_CONT_NOC_PROTOCOL_CNTL_EOD            
`define STREAMING_OP_CNTL_NOC_PROTOCOL_CNTL_SOD_EOD  `NOC_CONT_NOC_PROTOCOL_CNTL_SOD_EOD        



//--------------------------------------------------------------------------------------------------
//------------------------------------------------
// FIFO's
//------------------------------------------------

//--------------------------------------------------------
// to stOp from NoC

// Note: Additional "fifo contains eop" flag
//       Needed for the last piece of data that doesnt fill an entire DMA packet
//       Assumes no more than one eop in the fifo as this DMA will complete before another is started

// Uses:
//      inside cntl - to stOp

`define NoC_to_StOp_FIFO \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_cntl      [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_RANGE] ; \
        reg                                              fifo_strmId    [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_RANGE] ;\
        reg  [`STREAMING_OP_CNTL_DATA_RANGE      ]       fifo_data      [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_RANGE] ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_read_cntl       ; \
        reg                                              fifo_read_strmId     ; \
        reg  [`STREAMING_OP_CNTL_DATA_RANGE      ]       fifo_read_data       ; \
        reg                                              fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       cntl                 ; \
        wire                                             strmId               ; \
        wire [`STREAMING_OP_CNTL_DATA_RANGE      ]       data                 ; \
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]      <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
            fifo_read_data_valid    <= ( reset_poweron                   ) ? 'd0        : \
                                       ( clear                           ) ? 'd0        : \
                                                                              fifo_read ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
        always @(posedge clk)\
          begin\
            fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
            fifo_read_strmId    <= (fifo_read) ? fifo_strmId [fifo_rp] : fifo_read_strmId ;\
            fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
          end\


`define NoC_to_StOp_FIFO_wRealMemory \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_read_cntl       ; \
        wire                                             fifo_read_strmId     ; \
        wire [`STREAMING_OP_CNTL_DATA_RANGE      ]       fifo_read_data       ; \
        reg                                              fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       cntl                 ; \
        wire                                             strmId               ; \
        wire [`STREAMING_OP_CNTL_DATA_RANGE      ]       data                 ; \
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
\
            fifo_read_data_valid    <= ( reset_poweron                   ) ? 'd0        : \
                                       ( clear                           ) ? 'd0        : \
                                                                              fifo_read ;\
   \
            //fifo_empty              <= ( reset_poweron                   ) ? 'd1                  : \
            //                           ( clear                           ) ? 'd1                  : \
            //                                                                 (fifo_rp == fifo_wp) ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\



//--------------------------------------------------------
// to NoC from stOp

// Note: Additional "fifo contains eop" flag
//       Needed for the last piece of data that doesnt fill an entire DMA packet
//       Assumes no more than one eop in the fifo as this DMA will complete before another is started

// Uses:
//      inside cntl - from stOp

`define StOp_to_NoC_FIFO \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_cntl      [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_RANGE] ; \
        reg                                              fifo_strmId    [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_RANGE] ;\
        reg  [`STREAMING_OP_CNTL_DATA_RANGE      ]       fifo_data      [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_RANGE] ; \
        reg  [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_read_cntl       ; \
        reg                                              fifo_read_strmId     ; \
        reg  [`STREAMING_OP_CNTL_DATA_RANGE      ]       fifo_read_data       ; \
        reg                                              fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       cntl                 ; \
        wire                                             strmId               ; \
        wire [`STREAMING_OP_CNTL_DATA_RANGE      ]       data                 ; \
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]      <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
\
            fifo_read_data_valid    <= ( reset_poweron                   ) ? 'd0        : \
                                       ( clear                           ) ? 'd0        : \
                                                                              fifo_read ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH-6)    ;\
        always @(posedge clk)\
          begin\
            fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
            fifo_read_strmId    <= (fifo_read) ? fifo_strmId [fifo_rp] : fifo_read_strmId ;\
            fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
          end\


//--------------------------------------------------------
// Streaming Op Control from NoC FIFO
// Uses:
//      inside cntl - control from noc

`define Control_from_NoC_FIFO \
\
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_cntl   [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_type   [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_data   [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_PE_ID_RANGE          ]        fifo_peId   [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_laneId [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg                                                    fifo_strmId [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_read_cntl   ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_read_type   ;\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_read_data   ;\
        wire [`STREAMING_OP_CNTL_PE_ID_RANGE          ]        fifo_read_peId   ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_read_laneId ;\
        wire                                                   fifo_read_strmId ;\
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        cntl             ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        typee            ;// type cannot be used in SV\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        data             ;\
        wire [`PE_PE_ID_RANGE                         ]        peId             ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        laneId           ;\
        wire                                                   strmId           ;\
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_type[fifo_wp]      <= ( fifo_write       ) ? typee              : \
                                                              fifo_type[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_peId[fifo_wp]      <= ( fifo_write       ) ? peId               : \
                                                              fifo_peId[fifo_wp] ;\
   \
            fifo_laneId[fifo_wp]    <= ( fifo_write       ) ? laneId               : \
                                                              fifo_laneId[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]    <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
          assign fifo_read_cntl      = fifo_cntl [fifo_rp] ;\
          assign fifo_read_type      = fifo_type [fifo_rp] ;\
          assign fifo_read_data      = fifo_data [fifo_rp] ;\
          assign fifo_read_peId      = fifo_peId [fifo_rp] ;\
          assign fifo_read_laneId    = fifo_laneId [fifo_rp] ;\
          assign fifo_read_strmId    = fifo_strmId [fifo_rp] ;\


//--------------------------------------------------------
// NoC Data to Control FIFO
// Uses:
//      inside cntl - data from noc

`define Data_from_NoC_FIFO \
\
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_cntl   [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_type   [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_laneId [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg                                                    fifo_strmId [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_data   [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_read_cntl   ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_read_type   ;\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_read_data   ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_read_laneId ;\
        wire                                                   fifo_read_strmId ;\
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        cntl             ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        typee            ;// type cannot be used in SV\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        data             ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        laneId           ;\
        wire                                                   strmId           ;\
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_type[fifo_wp]      <= ( fifo_write       ) ? typee              : \
                                                              fifo_type[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_laneId[fifo_wp]      <= ( fifo_write       ) ? laneId               : \
                                                              fifo_laneId[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]      <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
          assign fifo_read_cntl      = fifo_cntl [fifo_rp] ;\
          assign fifo_read_type      = fifo_type [fifo_rp] ;\
          assign fifo_read_data      = fifo_data [fifo_rp] ;\
          assign fifo_read_laneId    = fifo_laneId [fifo_rp] ;\
          assign fifo_read_strmId    = fifo_strmId [fifo_rp] ;\



//------------------------------------------------------------------------------------------------------------
`endif
