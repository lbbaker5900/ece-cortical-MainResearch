`ifndef _noc_cntl_vh
`define _noc_cntl_vh


/*****************************************************************

    File name   : noc_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Aug 2015
    email       : lbbaker@ncsu.edu

*****************************************************************/

`define NOC_CONT_EXTERNAL_DATA_WIDTH         `PE_NOC_EXTERNAL_DATA_WIDTH
`define NOC_CONT_EXTERNAL_DATA_MSB           `NOC_CONT_EXTERNAL_DATA_WIDTH-1
`define NOC_CONT_EXTERNAL_DATA_LSB           0
`define NOC_CONT_EXTERNAL_DATA_RANGE         `NOC_CONT_EXTERNAL_DATA_MSB : `NOC_CONT_EXTERNAL_DATA_LSB

`define NOC_CONT_INTERNAL_DATA_WIDTH         `PE_NOC_INTERNAL_DATA_WIDTH
`define NOC_CONT_INTERNAL_DATA_MSB           `NOC_CONT_INTERNAL_DATA_WIDTH-1
`define NOC_CONT_INTERNAL_DATA_LSB           0
`define NOC_CONT_INTERNAL_DATA_RANGE         `NOC_CONT_INTERNAL_DATA_MSB : `NOC_CONT_INTERNAL_DATA_LSB

`define NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE         `PE_EXEC_LANE_WIDTH_RANGE

//---------------------------------------------------------------------------------------------------------------------
// NoC (external) Ports Information

`define NOC_CONT_NOC_NUM_OF_PORTS          4

`define NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE       `NOC_CONT_NOC_NUM_OF_PORTS-1 : 0
`define NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE    `NOC_CONT_NOC_NUM_OF_PORTS : 0    // destinations are local plus ports 0-3

`define NOC_CONT_NOC_NUM_OF_PORTS_MSB     (`CLOG2(`NOC_CONT_NOC_NUM_OF_PORTS))
`define NOC_CONT_NOC_NUM_OF_PORTS_LSB     0
`define NOC_CONT_NOC_NUM_OF_PORTS_SIZE    (`NOC_CONT_NOC_NUM_OF_PORTS_MSB - `NOC_CONT_NOC_NUM_OF_PORTS_LSB +1)
`define NOC_CONT_NOC_NUM_OF_PORTS_RANGE    `NOC_CONT_NOC_NUM_OF_PORTS_MSB : `NOC_CONT_NOC_NUM_OF_PORTS_LSB

// Port signalling
`define NOC_CONT_NOC_PORT_CNTL_WIDTH               `COMMON_STD_INTF_CNTL_WIDTH
`define NOC_CONT_NOC_PORT_CNTL_MSB                 `NOC_CONT_NOC_PORT_CNTL_WIDTH-1
`define NOC_CONT_NOC_PORT_CNTL_LSB                 0
`define NOC_CONT_NOC_PORT_CNTL_RANGE               `NOC_CONT_NOC_PORT_CNTL_MSB : `NOC_CONT_NOC_PORT_CNTL_LSB

`define NOC_CONT_NOC_PORT_DATA_WIDTH               `NOC_CONT_EXTERNAL_DATA_WIDTH         
`define NOC_CONT_NOC_PORT_DATA_MSB                 `NOC_CONT_NOC_PORT_DATA_WIDTH-1
`define NOC_CONT_NOC_PORT_DATA_LSB                 0
`define NOC_CONT_NOC_PORT_DATA_RANGE               `NOC_CONT_NOC_PORT_DATA_MSB : `NOC_CONT_NOC_PORT_DATA_LSB



//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------
// FSM(s) 

// Local Input Queue Controller
`include "noc_cntl_noc_local_inq_control_fsm_state_definitions.vh"

// Local Output Queue Controller
`define NOC_CONT_LOCAL_OUTQ_CNTL_WAIT                    15'b000_0000_0000_0001
`define NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ            15'b000_0000_0000_0010
`define NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ             15'b000_0000_0000_0100
`define NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER          15'b000_0000_0000_1000
`define NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2          15'b000_0000_0001_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3          15'b000_0000_0010_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_CP_COMPLETE             15'b000_0000_0100_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ            15'b000_0000_1000_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ             15'b000_0001_0000_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER          15'b000_0010_0000_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2          15'b000_0100_0000_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3          15'b000_1000_0000_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_DP_COMPLETE             15'b001_0000_0000_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_COMPLETE                15'b010_0000_0000_0000
`define NOC_CONT_LOCAL_OUTQ_CNTL_ERROR                   15'b100_0000_0000_0000

`define NOC_CONT_LOCAL_OUTQ_CNTL_STATE_MSB          14
`define NOC_CONT_LOCAL_OUTQ_CNTL_STATE_LSB           0
`define NOC_CONT_LOCAL_OUTQ_CNTL_STATE_SIZE          (`NOC_CONT_LOCAL_OUTQ_CNTL_STATE_MSB - `NOC_CONT_LOCAL_OUTQ_CNTL_STATE_LSB +1)
`define NOC_CONT_LOCAL_OUTQ_CNTL_STATE_RANGE          `NOC_CONT_LOCAL_OUTQ_CNTL_STATE_MSB : `NOC_CONT_LOCAL_OUTQ_CNTL_STATE_LSB


// Port Output Controller
`include "noc_cntl_noc_port_output_control_fsm_state_definitions.vh"


// Port Input Controller
`define NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT                     7'b000_0001
`define NOC_CONT_NOC_PORT_INPUT_CNTL_FIFO_READ                7'b000_0010
`define NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ          7'b000_0100
`define NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER          7'b000_1000
`define NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET          7'b001_0000
`define NOC_CONT_NOC_PORT_INPUT_CNTL_COMPLETE                 7'b010_0000
`define NOC_CONT_NOC_PORT_INPUT_CNTL_ERROR                    7'b100_0000

`define NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_MSB           6
`define NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_LSB           0
`define NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_SIZE          (`NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_MSB - `NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_LSB +1)
`define NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_RANGE          `NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_MSB : `NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_LSB


// end of FSM(s)
//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------
// Packet Types

`define NOC_CONT_TYPE_STATUS            0
`define NOC_CONT_TYPE_WRITE_REQUEST     1
`define NOC_CONT_TYPE_DMA_REQUEST       2
`define NOC_CONT_TYPE_READ_REQUEST      3
`define NOC_CONT_TYPE_READ_RESPONCE     4
`define NOC_CONT_TYPE_DMA_DATA          5
`define NOC_CONT_TYPE_DMA_DATA_SOD      6
`define NOC_CONT_TYPE_DMA_DATA_EOD      7

// Destination address types

`define NOC_CONT_DESTINATION_ADDR_TYPE_BITMASK           0
`define NOC_CONT_DESTINATION_ADDR_TYPE_MCAST_GROUP       1
`define NOC_CONT_DESTINATION_ADDR_TYPE_UNICAST           2

//---------------------------------------------------------------------------------------------------------------------
// First Cycle of all NoC packets are the same (external fields)

// 1st Transaction on external bus
`define NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_SIZE                1
`define NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_MSB                 `NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_SIZE-1
`define NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_LSB                 0
`define NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE               `NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_MSB : `NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_LSB

`define NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_SIZE                1
`define NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_MSB                 (`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_LSB + `NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_SIZE-1)
`define NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_LSB                 (`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_MSB + 1)
`define NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE               `NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_MSB : `NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_LSB
`define NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP              0
`define NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP              1

`define NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_SIZE                 32
`define NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_MSB                   (`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_LSB + `NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_SIZE-1)
`define NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_LSB                   (`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_MSB + 1)
`define NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE                 `NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_MSB : `NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_LSB

`define NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_SIZE                  2
`define NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_MSB                   (`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_LSB + `NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_SIZE-1)
`define NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_LSB                   (`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_MSB + 1)
`define NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE                 `NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_MSB : `NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_LSB

`define NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_SIZE                  6
`define NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_MSB                   (`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_LSB + `NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_SIZE-1)
`define NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_LSB                   (`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_MSB + 1)
`define NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE                 `NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_MSB : `NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_LSB


//---------------------------------------------------------------------------------------------------------------------
// DMA Request (external fields)

// Fields
`define NOC_CONT_NOC_PACKET_TYPE_MSB            3
`define NOC_CONT_NOC_PACKET_TYPE_LSB            0
`define NOC_CONT_NOC_PACKET_TYPE_SIZE           (`NOC_CONT_NOC_PACKET_TYPE_MSB - `NOC_CONT_NOC_PACKET_TYPE_LSB +1)
`define NOC_CONT_NOC_PACKET_TYPE_RANGE           `NOC_CONT_NOC_PACKET_TYPE_MSB : `NOC_CONT_NOC_PACKET_TYPE_LSB

`define NOC_CONT_EXTERNAL_DMA_WORDS_PER_PKT                16

// 2nd Transaction on external bus
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_SIZE                1
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB                 `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_SIZE-1
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_LSB                 0
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE               `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB : `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_LSB

`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_SIZE                  8
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_MSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_LSB + `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_LSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_RANGE                 `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_MSB : `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_LSB

`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_SIZE                 24
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_MSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_LSB + `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_LSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_RANGE                 `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_MSB : `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_LSB

`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_SIZE                  1
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_MSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_LSB + `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_LSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE                 `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_MSB : `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_LSB

`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_SIZE                  4
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_MSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_LSB + `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_LSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE                 `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_MSB : `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_LSB

`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_SIZE                  4
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_MSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_LSB + `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_LSB                   (`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_RANGE                 `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_MSB : `NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_LSB

// 3rd Transaction on external bus
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_SIZE                18
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_MSB                 `NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_SIZE-1
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_LSB                 0
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_RANGE               `NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_MSB : `NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_LSB

`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_SIZE             20
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_MSB              (`NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_LSB + `NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_LSB              (`NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_RANGE            `NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_MSB : `NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_LSB

`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_SIZE             4
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_MSB              (`NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_LSB + `NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_LSB              (`NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_RANGE            `NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_MSB : `NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_LSB

//---------------------------------------------------------------------------------------------------------------------
// DMA Request (internal fields)

`define NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT                16

// First Transaction on internal bus
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_SIZE                8
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_MSB                 `NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_SIZE-1
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_LSB                 0
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE               `NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_MSB : `NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_LSB

`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_SIZE                  8
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_MSB                   (`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_LSB + `NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_SIZE-1)
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_LSB                   (`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_MSB + 1)
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE                 `NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_MSB : `NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_LSB

`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_SIZE                 24
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_MSB                   (`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_LSB + `NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_SIZE-1)
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_LSB                   (`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_MSB + 1)
`define NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE                 `NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_MSB : `NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_LSB

// Second Transaction on internal bus
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_SIZE                16
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB                 `NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_SIZE-1
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_LSB                 0
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE               `NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB : `NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_LSB

`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_SIZE             20
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_MSB              (`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_LSB + `NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_SIZE-1)
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_LSB              (`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB + 1)
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE            `NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_MSB : `NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_LSB

`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_SIZE             4
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_MSB              (`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_LSB + `NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_SIZE-1)
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_LSB              (`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_MSB + 1)
`define NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE            `NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_MSB : `NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_LSB


//---------------------------------------------------------------------------------------------------------------------
// DMA Data (external fields)

// First transactions on internal bus
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_SIZE                32
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_MSB                 `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_SIZE-1
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_LSB                 0
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_RANGE               `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_MSB : `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_LSB

`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_SIZE                  1
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_MSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_LSB + `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_LSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_RANGE                 `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_MSB : `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_LSB

`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_SIZE                  1
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_MSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_LSB + `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_LSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_RANGE                 `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_MSB : `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_LSB

`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_SIZE                  4
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_MSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_LSB + `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_LSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_RANGE                 `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_MSB : `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_LSB

`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_SIZE                  4
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_MSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_LSB + `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_LSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_RANGE                 `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_MSB : `NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_LSB

// All other transactions on internal bus
`define NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_SIZE                32
`define NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB                 `NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_SIZE-1
`define NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_LSB                 0
`define NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE               `NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB : `NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_LSB

`define NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_SIZE                  10
`define NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_MSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB + `NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_SIZE-1)
`define NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB                   (`NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB + 1)
`define NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_RANGE                 `NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_MSB : `NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB


//---------------------------------------------------------------------------------------------------------------------
// DMA Data (internal fields)

// First transactions on internal bus
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_SIZE                32
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_MSB                 `NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_SIZE-1
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_LSB                 0
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_RANGE               `NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_MSB : `NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_LSB

`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_SIZE                  1
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_MSB                   (`NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_LSB + `NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_SIZE-1)
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_LSB                   (`NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_MSB + 1)
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_RANGE                 `NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_MSB : `NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_LSB

`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_SIZE                  7
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_MSB                   (`NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_LSB + `NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_SIZE-1)
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_LSB                   (`NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_MSB + 1)
`define NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_RANGE                 `NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_MSB : `NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_LSB

// All other transactions on internal bus
`define NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_SIZE                32
`define NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB                 `NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_SIZE-1
`define NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_LSB                 0
`define NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE               `NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB : `NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_LSB

`define NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_SIZE                  8
`define NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_MSB                   (`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB + `NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_SIZE-1)
`define NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB                   (`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB + 1)
`define NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_RANGE                 `NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_MSB : `NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB


// end of Packet Types
//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------

//------------------------------------------------
// Internal to NoC Interface data FIFO
//------------------------------------------------

`define NOC_CONT_TO_INTF_DATA_FIFO_DEPTH          32
`define NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_MSB      (`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH) -1
`define NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_LSB      0
`define NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_SIZE     (`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_MSB - `NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_LSB +1)
`define NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE     `NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_MSB : `NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_LSB
`define NOC_CONT_TO_INTF_DATA_FIFO_MSB            ((`CLOG2(`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH)) -1)
`define NOC_CONT_TO_INTF_DATA_FIFO_LSB            0
`define NOC_CONT_TO_INTF_DATA_FIFO_SIZE           (`NOC_CONT_TO_INTF_DATA_FIFO_MSB - `NOC_CONT_TO_INTF_DATA_FIFO_LSB +1)
`define NOC_CONT_TO_INTF_DATA_FIFO_RANGE           `NOC_CONT_TO_INTF_DATA_FIFO_MSB : `NOC_CONT_TO_INTF_DATA_FIFO_LSB

// Count number of packets in internal datapath FIFO
`define NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_MSB     2
`define NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_LSB     0
`define NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_SIZE    (`NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_MSB - `NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_LSB +1)
`define NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_RANGE    `NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_MSB : `NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_LSB

//------------------------------------------------
// External from NoC Interface Control FIFO
//------------------------------------------------

`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH          64
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_MSB      (`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH) -1
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_LSB      0
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_SIZE     (`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_MSB - `NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_LSB +1)
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_RANGE     `NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_MSB : `NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_LSB
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_MSB            ((`CLOG2(`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH)) -1)
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_LSB            0
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_SIZE           (`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_MSB - `NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_LSB +1)
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE           `NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_MSB : `NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_LSB

// Threshold below full when we assert almost full
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_ALMOST_FULL_THRESHOLD  6

// Count number of packets in internal datapath FIFO
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_MSB     8
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_LSB     0
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_SIZE    (`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_MSB - `NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_LSB +1)
`define NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_RANGE    `NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_MSB : `NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_LSB


//--------------------------------------------------------------------------------------------------
//------------------------------------------------
// FIFO's
//------------------------------------------------

//--------------------------------------------------------
// Streaming Op Control to NoC FIFO

// Note: Additional "fifo contains eop" flag
//       Needed for the last piece of data that doesnt fill an entire DMA packet
//       Assumes no more than one eop in the fifo as this DMA will complete before another is started

// Uses:
//      inside noc - control from cntl

`define Control_to_NoC_FIFO \
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
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_read_cntl   ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_read_type   ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_read_data   ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_read_laneId ;\
        reg                                                    fifo_read_strmId ;\
        reg                                                    fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        cntl             ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        type             ;\
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
            fifo_type[fifo_wp]      <= ( fifo_write       ) ? type               : \
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
                                       ((((fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (          cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (          cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) & fifo_write )  ? fifo_eop_count + 'd1 : \
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
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
\
          always @(posedge clk)\
            begin\
              fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
              fifo_read_type      <= (fifo_read) ? fifo_type [fifo_rp]   : fifo_read_type   ;\
              fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
              fifo_read_laneId    <= (fifo_read) ? fifo_laneId [fifo_rp] : fifo_read_laneId ;\
              fifo_read_strmId    <= (fifo_read) ? fifo_strmId [fifo_rp] : fifo_read_strmId ;\
            end\
      

//--------------------------------------------------------
// NoC controller to NoC Interface Data
// Uses:
//      inside noc - data from cntl

`define NoC_to_NoC_data_intf \
\
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_cntl   [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_type   [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_data   [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_PE_ID_RANGE          ]        fifo_peId   [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_laneId [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg                                                    fifo_strmId [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`NOC_CONT_TO_INTF_DATA_FIFO_RANGE]       fifo_wp              ; \
        reg  [`NOC_CONT_TO_INTF_DATA_FIFO_RANGE]       fifo_rp              ; \
        reg  [`NOC_CONT_TO_INTF_DATA_FIFO_RANGE]       fifo_depth           ; \
        reg  [`NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_read_cntl   ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_read_type   ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_read_data   ;\
        reg  [`STREAMING_OP_CNTL_PE_ID_RANGE          ]        fifo_read_peId   ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_read_laneId ;\
        reg                                                    fifo_read_strmId ;\
        reg                                                    fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        cntl             ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        type             ;\
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
            fifo_type[fifo_wp]      <= ( fifo_write       ) ? type               : \
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
                                       ((((fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (          cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (          cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) & fifo_write )  ? fifo_eop_count + 'd1 : \
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
          assign fifo_almost_full    = (fifo_depth >= 'd`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
\
          always @(posedge clk)\
            begin\
              fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
              fifo_read_type      <= (fifo_read) ? fifo_type [fifo_rp]   : fifo_read_type   ;\
              fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
              fifo_read_peId      <= (fifo_read) ? fifo_peId [fifo_rp]   : fifo_read_peId   ;\
              fifo_read_laneId    <= (fifo_read) ? fifo_laneId [fifo_rp] : fifo_read_laneId ;\
              fifo_read_strmId    <= (fifo_read) ? fifo_strmId [fifo_rp] : fifo_read_strmId ;\
            end\


//--------------------------------------------------------
// NoC FIFO's

`define NoC_Port_fifo \
\
        reg  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]                   fifo_cntl      [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_RANGE] ; \
        reg  [`NOC_CONT_NOC_PORT_DATA_RANGE]                    fifo_data      [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_RANGE] ; \
        reg  [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE]           fifo_wp              ; \
        reg  [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE]           fifo_rp              ; \
        reg  [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE]           fifo_depth           ; \
        reg  [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_RANGE] fifo_eop_count       ; \
        wire                                                    fifo_empty           ; \
        wire                                                    fifo_almost_full     ; \
        wire                                                    fifo_read            ; \
        reg  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]                   fifo_read_cntl       ; \
        reg  [`NOC_CONT_NOC_PORT_DATA_RANGE]                    fifo_read_data       ; \
        reg                                                     fifo_read_data_valid ; \
        reg  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]                   cntl                 ; \
        reg  [`NOC_CONT_NOC_PORT_DATA_RANGE]                    data                 ; \
        reg                                                     fifo_write           ; \
        wire                                                    clear                ; \
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
                                       ((((fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (          cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (fifo_read_cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`COMMON_STD_INTF_CNTL_EOM) | (          cntl ==  'd`COMMON_STD_INTF_CNTL_SOM_EOM)) & fifo_write )  ? fifo_eop_count + 'd1 : \
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
          assign fifo_almost_full    = (fifo_depth >= 'd`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH-`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_ALMOST_FULL_THRESHOLD)    ;\
        always @(posedge clk)\
          begin\
            fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
            fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
          end\

//------------------------------------------------------------------------------------------------------------
`endif
