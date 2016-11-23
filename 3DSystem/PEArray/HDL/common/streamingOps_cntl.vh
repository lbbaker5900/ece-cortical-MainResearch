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

//`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB     (`MEM_ACC_CONTROL_MEMORY_ADDRESS_MSB + (`CLOG2(`PE_ARRAY_NUM_OF_PE)))
`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB     `PE_CHIPLET_ADDRESS_MSB
`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_LSB     0
`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_SIZE    (`STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB - `STREAMING_OP_CNTL_CHIPLET_ADDRESS_LSB +1)
`define STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE    `STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB : `STREAMING_OP_CNTL_CHIPLET_ADDRESS_LSB

// Used by CNTL to determine which PE address resides
`define STREAMING_OP_CNTL_PE_DECODE_ADDRESS_MSB    `STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB
`define STREAMING_OP_CNTL_PE_DECODE_ADDRESS_LSB    (`STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB - ((`CLOG2(`PE_ARRAY_NUM_OF_PE))-1))
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
`define STREAMING_OP_CNTL_DATA_WIDTH_MSB           31
`define STREAMING_OP_CNTL_DATA_WIDTH_LSB            0
`define STREAMING_OP_CNTL_DATA_WIDTH_SIZE           (`STREAMING_OP_CNTL_DATA_WIDTH_MSB - `STREAMING_OP_CNTL_DATA_WIDTH_LSB +1)
`define STREAMING_OP_CNTL_DATA_WIDTH_RANGE           `STREAMING_OP_CNTL_DATA_WIDTH_MSB : `STREAMING_OP_CNTL_DATA_WIDTH_LSB

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

// Per lane stream controller - starts each stOp and DMA and makes DMA requests to the "to NoC" Control FSM
`define STREAMING_OP_CNTL_STRM_WAIT                                      18'b00_0000_0000_0000_0001
`define STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE                          18'b00_0000_0000_0000_0010
`define STREAMING_OP_CNTL_STRM_STRM0_REQ_NOC_DMA                         18'b00_0000_0000_0000_0100
`define STREAMING_OP_CNTL_STRM_STRM0_ACK_NOC_DMA                         18'b00_0000_0000_0000_1000
`define STREAMING_OP_CNTL_STRM_STRM1_REQ_NOC_DMA                         18'b00_0000_0000_0001_0000
`define STREAMING_OP_CNTL_STRM_STRM1_ACK_NOC_DMA                         18'b00_0000_0000_0010_0000
`define STREAMING_OP_CNTL_STRM_ENABLE_STOP                               18'b00_0000_0000_0100_0000
`define STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ                           18'b00_0000_0000_1000_0000
`define STREAMING_OP_CNTL_STRM_OP_START                                  18'b00_0000_0001_0000_0000
`define STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0                     18'b00_0000_0010_0000_0000
// FIXME `define STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_STOP         18'b00_0000_0100_0000_0000
`define STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_DMA_READ     18'b00_0000_1000_0000_0000
`define STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1                     18'b00_0001_0000_0000_0000
// FIXME `define STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_STOP         18'b00_0010_0000_0000_0000
`define STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_DMA_READ     18'b00_0100_0000_0000_0000
`define STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_ACK                       18'b00_1000_0000_0000_0000
`define STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC                             18'b01_0000_0000_0000_0000
`define STREAMING_OP_CNTL_STRM_COMPLETE                                  18'b10_0000_0000_0000_0000

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

`define STREAMING_OP_CNTL_STRM_STATE_MSB     17
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

//------------------------------------------------
// STREAMING_OP_CNTL Operations
//------------------------------------------------
/*
`define STREAMING_OP_CNTL_OPERATION_FROM_SIZE                2
`define STREAMING_OP_CNTL_OPERATION_FROM_MSB                 `STREAMING_OP_CNTL_OPERATION_FROM_SIZE-1
`define STREAMING_OP_CNTL_OPERATION_FROM_LSB                 0
`define STREAMING_OP_CNTL_OPERATION_FROM_RANGE               `STREAMING_OP_CNTL_OPERATION_FROM_MSB : `STREAMING_OP_CNTL_OPERATION_FROM_LSB

`define STREAMING_OP_CNTL_OPERATION_TO_SIZE                  2
`define STREAMING_OP_CNTL_OPERATION_TO_MSB                   (`STREAMING_OP_CNTL_OPERATION_TO_LSB + `STREAMING_OP_CNTL_OPERATION_TO_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_TO_LSB                   (`STREAMING_OP_CNTL_OPERATION_FROM_MSB + 1)
`define STREAMING_OP_CNTL_OPERATION_TO_RANGE                 `STREAMING_OP_CNTL_OPERATION_TO_MSB : `STREAMING_OP_CNTL_OPERATION_TO_LSB
*/                                                                        

// stream or single transaction
/* FIXME - not used
`define STREAMING_OP_CNTL_OPERATION_STREAM_FROM_SIZE         1                                                                            
`define STREAMING_OP_CNTL_OPERATION_STREAM_FROM_MSB          (`STREAMING_OP_CNTL_OPERATION_STREAM_FROM_LSB + `STREAMING_OP_CNTL_OPERATION_STREAM_FROM_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_FROM_LSB          (`STREAMING_OP_CNTL_OPERATION_TO_MSB + 1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_FROM_RANGE        `STREAMING_OP_CNTL_OPERATION_STREAM_FROM_MSB : `STREAMING_OP_CNTL_OPERATION_STREAM_FROM_LSB     
                                                             
`define STREAMING_OP_CNTL_OPERATION_STREAM_TO_SIZE           1                                                                                                                                                                           
`define STREAMING_OP_CNTL_OPERATION_STREAM_TO_MSB            (`STREAMING_OP_CNTL_OPERATION_STREAM_TO_LSB + `STREAMING_OP_CNTL_OPERATION_STREAM_TO_SIZE-1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_TO_LSB            (`STREAMING_OP_CNTL_OPERATION_STREAM_FROM_MSB + 1)
`define STREAMING_OP_CNTL_OPERATION_STREAM_TO_RANGE          `STREAMING_OP_CNTL_OPERATION_STREAM_TO_MSB : `STREAMING_OP_CNTL_OPERATION_STREAM_TO_LSB
*/   

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

// SRC and DEST codes
`define STREAMING_OP_CNTL_OPERATION_FROM_NONE                0
`define STREAMING_OP_CNTL_OPERATION_FROM_MEMORY              1
`define STREAMING_OP_CNTL_OPERATION_FROM_EXT                 2  // FIXME : use STD not EXT
`define STREAMING_OP_CNTL_OPERATION_FROM_STD                 2
`define STREAMING_OP_CNTL_OPERATION_FROM_NOC                 3

`define STREAMING_OP_CNTL_OPERATION_TO_NONE                  0
`define STREAMING_OP_CNTL_OPERATION_TO_MEMORY                1
`define STREAMING_OP_CNTL_OPERATION_TO_STD                   2
`define STREAMING_OP_CNTL_OPERATION_TO_NOC                   3
`define STREAMING_OP_CNTL_OPERATION_TO_REG                   4    

// FIXME : get rid of number of streams. Use src and dest to determine number
//                                                                    num    num                                                         
//                                                                    dest   src                                                          strm1   strm0  strm1   strm0
//                                                                   strms  strms                   opcode                                 dest    dest   src     src
`define STREAMING_OP_CNTL_OPERATION_MEM_MEM_BITSUM_TO_MEM            {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_BITSUM            ,   3'd0,   3'd1,  3'd1,   3'd1         } 
`define STREAMING_OP_CNTL_OPERATION_MEM_MEM_BITSUM_TO_REG            {2'd1,  2'd2,   5'd`STREAMING_OP_CNTL_OPERATION_BITSUM            ,   3'd2,   3'd2,  3'd1,   3'd1         } 
`define STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM              {2'd1,  2'd1,   5'd`STREAMING_OP_CNTL_OPERATION_NOP               ,   3'd0,   3'd1,  3'd2,   3'd2         } 
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

`define STREAMING_OP_CNTL_OPERATION_MSB            (`STREAMING_OP_CNTL_OPERATION_SIZE - 1)
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

