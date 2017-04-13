`ifndef _mgr_noc_cntl_vh
`define _mgr_noc_cntl_vh


/*****************************************************************

    File name   : mgr_noc_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Aug 2015
    email       : lbbaker@ncsu.edu

*****************************************************************/

`define MGR_NOC_CONT_EXTERNAL_DATA_WIDTH         `MGR_NOC_EXTERNAL_DATA_WIDTH
`define MGR_NOC_CONT_EXTERNAL_DATA_MSB           `MGR_NOC_CONT_EXTERNAL_DATA_WIDTH-1
`define MGR_NOC_CONT_EXTERNAL_DATA_LSB           0
`define MGR_NOC_CONT_EXTERNAL_DATA_RANGE         `MGR_NOC_CONT_EXTERNAL_DATA_MSB : `MGR_NOC_CONT_EXTERNAL_DATA_LSB

`define MGR_NOC_CONT_INTERNAL_DATA_WIDTH         `MGR_NOC_INTERNAL_DATA_WIDTH
`define MGR_NOC_CONT_INTERNAL_DATA_MSB           `MGR_NOC_CONT_INTERNAL_DATA_WIDTH-1
`define MGR_NOC_CONT_INTERNAL_DATA_LSB           0
`define MGR_NOC_CONT_INTERNAL_DATA_RANGE         `MGR_NOC_CONT_INTERNAL_DATA_MSB : `MGR_NOC_CONT_INTERNAL_DATA_LSB

`define MGR_NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE         `PE_EXEC_LANE_WIDTH_RANGE

//---------------------------------------------------------------------------------------------------------------------
// NoC (external) Ports Information

`define MGR_NOC_CONT_NOC_NUM_OF_PORTS          4

`define MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE       `MGR_NOC_CONT_NOC_NUM_OF_PORTS-1 : 0
`define MGR_NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE    `MGR_NOC_CONT_NOC_NUM_OF_PORTS : 0    // destinations are local plus ports 0-3

`define MGR_NOC_CONT_NOC_NUM_OF_PORTS_MSB     (`CLOG2(`MGR_NOC_CONT_NOC_NUM_OF_PORTS))
`define MGR_NOC_CONT_NOC_NUM_OF_PORTS_LSB     0
`define MGR_NOC_CONT_NOC_NUM_OF_PORTS_SIZE    (`MGR_NOC_CONT_NOC_NUM_OF_PORTS_MSB - `MGR_NOC_CONT_NOC_NUM_OF_PORTS_LSB +1)
`define MGR_NOC_CONT_NOC_NUM_OF_PORTS_RANGE    `MGR_NOC_CONT_NOC_NUM_OF_PORTS_MSB : `MGR_NOC_CONT_NOC_NUM_OF_PORTS_LSB


// Port signalling
`define MGR_NOC_CONT_NOC_PORT_CNTL_WIDTH               `COMMON_STD_INTF_CNTL_WIDTH
`define MGR_NOC_CONT_NOC_PORT_CNTL_MSB                 `MGR_NOC_CONT_NOC_PORT_CNTL_WIDTH-1
`define MGR_NOC_CONT_NOC_PORT_CNTL_LSB                 0
`define MGR_NOC_CONT_NOC_PORT_CNTL_RANGE               `MGR_NOC_CONT_NOC_PORT_CNTL_MSB : `MGR_NOC_CONT_NOC_PORT_CNTL_LSB

`define MGR_NOC_CONT_NOC_PORT_DATA_WIDTH               `MGR_NOC_CONT_EXTERNAL_DATA_WIDTH         
`define MGR_NOC_CONT_NOC_PORT_DATA_MSB                 `MGR_NOC_CONT_NOC_PORT_DATA_WIDTH-1
`define MGR_NOC_CONT_NOC_PORT_DATA_LSB                 0
`define MGR_NOC_CONT_NOC_PORT_DATA_RANGE               `MGR_NOC_CONT_NOC_PORT_DATA_MSB : `MGR_NOC_CONT_NOC_PORT_DATA_LSB



//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------
// FSM(s) 

// Local Input Queue Controller
`include "mgr_noc_cntl_noc_local_inq_control_fsm_state_definitions.vh"

// Local Output Queue Controller
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT                    15'b000_0000_0000_0001
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ            15'b000_0000_0000_0010
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ             15'b000_0000_0000_0100
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER          15'b000_0000_0000_1000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2          15'b000_0000_0001_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3          15'b000_0000_0010_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_COMPLETE             15'b000_0000_0100_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ            15'b000_0000_1000_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ             15'b000_0001_0000_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER          15'b000_0010_0000_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2          15'b000_0100_0000_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3          15'b000_1000_0000_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_COMPLETE             15'b001_0000_0000_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_COMPLETE                15'b010_0000_0000_0000
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_ERROR                   15'b100_0000_0000_0000

`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_MSB          14
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_LSB           0
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_SIZE          (`MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_MSB - `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_LSB +1)
`define MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_RANGE          `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_MSB : `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_LSB


// Port Output Controller
`include "mgr_noc_cntl_noc_port_output_control_fsm_state_definitions.vh"


// Port Input Controller
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT                     7'b000_0001
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_FIFO_READ                7'b000_0010
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ          7'b000_0100
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER          7'b000_1000
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET          7'b001_0000
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_COMPLETE                 7'b010_0000
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_ERROR                    7'b100_0000

`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_MSB           6
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_LSB           0
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_SIZE          (`MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_MSB - `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_LSB +1)
`define MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_RANGE          `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_MSB : `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_LSB


// end of FSM(s)
//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------
// Packet Types

`define MGR_NOC_CONT_NOC_PACKET_TYPE_WIDTH          4
`define MGR_NOC_CONT_NOC_PACKET_TYPE_MSB            `MGR_NOC_CONT_NOC_PACKET_TYPE_WIDTH-1
`define MGR_NOC_CONT_NOC_PACKET_TYPE_LSB            0
`define MGR_NOC_CONT_NOC_PACKET_TYPE_SIZE           (`MGR_NOC_CONT_NOC_PACKET_TYPE_MSB - `MGR_NOC_CONT_NOC_PACKET_TYPE_LSB +1)
`define MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE           `MGR_NOC_CONT_NOC_PACKET_TYPE_MSB : `MGR_NOC_CONT_NOC_PACKET_TYPE_LSB

`define MGR_NOC_CONT_TYPE_NOP               0
`define MGR_NOC_CONT_TYPE_WRITE_REQUEST     1
`define MGR_NOC_CONT_TYPE_DMA_REQUEST       2
`define MGR_NOC_CONT_TYPE_READ_REQUEST      3
`define MGR_NOC_CONT_TYPE_READ_RESPONCE     4
`define MGR_NOC_CONT_TYPE_DMA_DATA          5
`define MGR_NOC_CONT_TYPE_DMA_DATA_SOD      6
`define MGR_NOC_CONT_TYPE_DMA_DATA_EOD      7
`define MGR_NOC_CONT_TYPE_DESC_WRITE_DATA   8
`define MGR_NOC_CONT_TYPE_STATUS            9

//---------------------------------------------------------------------------------------------------------------------
// Payload/Cycle Types

`define MGR_NOC_CONT_NOC_PAYLOAD_TYPE_WIDTH          3
`define MGR_NOC_CONT_NOC_PAYLOAD_TYPE_MSB            `MGR_NOC_CONT_NOC_PAYLOAD_TYPE_WIDTH-1
`define MGR_NOC_CONT_NOC_PAYLOAD_TYPE_LSB            0
`define MGR_NOC_CONT_NOC_PAYLOAD_TYPE_SIZE           (`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_MSB - `MGR_NOC_CONT_NOC_PAYLOAD_TYPE_LSB +1)
`define MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE           `MGR_NOC_CONT_NOC_PAYLOAD_TYPE_MSB : `MGR_NOC_CONT_NOC_PAYLOAD_TYPE_LSB

`define MGR_NOC_CONT_TYPE_NOP               0
`define MGR_NOC_CONT_TYPE_WRITE_REQUEST     1
`define MGR_NOC_CONT_TYPE_DMA_REQUEST       2
`define MGR_NOC_CONT_TYPE_READ_REQUEST      3
`define MGR_NOC_CONT_TYPE_READ_RESPONCE     4
`define MGR_NOC_CONT_TYPE_DMA_DATA          5
`define MGR_NOC_CONT_TYPE_DMA_DATA_SOD      6
`define MGR_NOC_CONT_TYPE_DMA_DATA_EOD      7
`define MGR_NOC_CONT_TYPE_DESC_WRITE_DATA   8
`define MGR_NOC_CONT_TYPE_STATUS            9

//---------------------------------------------------------------------------------------------------------------------
// Destination address types

`define MGR_NOC_CONT_NOC_DEST_TYPE_WIDTH          2
`define MGR_NOC_CONT_NOC_DEST_TYPE_MSB            `MGR_NOC_CONT_NOC_DEST_TYPE_WIDTH-1
`define MGR_NOC_CONT_NOC_DEST_TYPE_LSB            0
`define MGR_NOC_CONT_NOC_DEST_TYPE_SIZE           (`MGR_NOC_CONT_NOC_DEST_TYPE_MSB - `MGR_NOC_CONT_NOC_DEST_TYPE_LSB +1)
`define MGR_NOC_CONT_NOC_DEST_TYPE_RANGE           `MGR_NOC_CONT_NOC_DEST_TYPE_MSB : `MGR_NOC_CONT_NOC_DEST_TYPE_LSB

`define MGR_NOC_CONT_DESTINATION_ADDR_TYPE_BITMASK           0
`define MGR_NOC_CONT_DESTINATION_ADDR_TYPE_MCAST_GROUP       1
`define MGR_NOC_CONT_DESTINATION_ADDR_TYPE_UNICAST           2

//---------------------------------------------------------------------------------------------------------------------
// First Cycle of all NoC packets are the same (external fields)

// 1st Transaction on external bus
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_SIZE                 64
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_MSB                   (`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_LSB + `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_LSB                   0
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE                 `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_MSB : `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_LSB

`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_SIZE                1
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_MSB                 (`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_LSB + `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_LSB                 (`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE               `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_MSB : `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_LSB
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP              0
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP              1

`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_SIZE                  2
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_MSB                   (`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_LSB + `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_LSB                   (`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE                 `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_MSB : `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_LSB

`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_SIZE                  6
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_MSB                   (`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_LSB + `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_LSB                   (`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE                 `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_MSB : `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_LSB


//---------------------------------------------------------------------------------------------------------------------
// DMA Request (external fields)

// Fields

`define MGR_NOC_CONT_EXTERNAL_DMA_WORDS_PER_PKT                16

// 2nd Transaction on external bus
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_SIZE                1
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB                 `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_SIZE-1
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_LSB                 0
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE               `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_SIZE                  8
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_SIZE                 24
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_SIZE                  1
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_SIZE                  4
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_SIZE                  4
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_LSB

// 3rd Transaction on external bus
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_SIZE                18
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_MSB                 `MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_SIZE-1
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_LSB                 0
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_RANGE               `MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_SIZE             20
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_MSB              (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_LSB              (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAD_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_RANGE            `MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_SIZE             4
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_MSB              (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_LSB              (`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_RANGE            `MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_LSB

//---------------------------------------------------------------------------------------------------------------------
// DMA Request (internal fields)

`define MGR_NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT                16

// First Transaction on internal bus
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_SIZE                8
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_MSB                 `MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_SIZE-1
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_LSB                 0
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE               `MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_MSB : `MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_LSB

`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_SIZE                  8
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_MSB                   (`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_LSB + `MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_SIZE-1)
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_LSB                   (`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_MSB + 1)
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE                 `MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_MSB : `MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_LSB

`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_SIZE                 24
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_MSB                   (`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_LSB + `MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_SIZE-1)
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_LSB                   (`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_MSB + 1)
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE                 `MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_MSB : `MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_LSB

// Second Transaction on internal bus
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_SIZE                16
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB                 `MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_SIZE-1
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_LSB                 0
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE               `MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB : `MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_LSB

`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_SIZE             20
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_MSB              (`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_LSB + `MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_SIZE-1)
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_LSB              (`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_MSB + 1)
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE            `MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_MSB : `MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_LSB

`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_SIZE             4
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_MSB              (`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_LSB + `MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_SIZE-1)
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_LSB              (`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_MSB + 1)
`define MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE            `MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_MSB : `MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_LSB


//---------------------------------------------------------------------------------------------------------------------
// DMA Data (external fields)

// First transactions on internal bus
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_SIZE                32
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_MSB                 `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_SIZE-1
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_LSB                 0
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_RANGE               `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_SIZE                  1
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_SIZE                  1
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_SIZE                  4
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_SIZE                  4
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_LSB

// All other transactions on internal bus
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_SIZE                32
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB                 `MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_SIZE-1
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_LSB                 0
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE               `MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_LSB

`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_SIZE                  10
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_MSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB + `MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_SIZE-1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB                   (`MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB + 1)
`define MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_RANGE                 `MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_MSB : `MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB


//---------------------------------------------------------------------------------------------------------------------
// DMA Data (internal fields)

// First transactions on internal bus
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_SIZE                32
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_MSB                 `MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_SIZE-1
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_LSB                 0
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_RANGE               `MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_MSB : `MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_LSB

`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_SIZE                  1
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_MSB                   (`MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_LSB + `MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_SIZE-1)
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_LSB                   (`MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_MSB + 1)
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_RANGE                 `MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_MSB : `MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_LSB

`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_SIZE                  7
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_MSB                   (`MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_LSB + `MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_SIZE-1)
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_LSB                   (`MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_MSB + 1)
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_RANGE                 `MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_MSB : `MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_PAD_LSB

// All other transactions on internal bus
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_SIZE                32
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB                 `MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_SIZE-1
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_LSB                 0
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE               `MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB : `MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_LSB

`define MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_SIZE                  8
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_MSB                   (`MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB + `MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_SIZE-1)
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB                   (`MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_MSB + 1)
`define MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_RANGE                 `MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_MSB : `MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_PAD_LSB


// end of Packet Types
//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------

//------------------------------------------------
// to NoC Control FIFO
//------------------------------------------------


//------------------------------------------------
// Internal to NoC Interface Control FIFO
//------------------------------------------------

`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH          16
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_MSB      (`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH) -1
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_LSB      0
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_SIZE     (`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_MSB - `MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_LSB +1)
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_RANGE     `MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_MSB : `MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_LSB
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_MSB            ((`CLOG2(`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH)) -1)
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_LSB            0
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_SIZE           (`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_MSB - `MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_LSB +1)
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_RANGE           `MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_MSB : `MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_LSB

// Count number of packets in internal datapath FIFO
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_EOP_COUNT_MSB     2
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_EOP_COUNT_LSB     0
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_EOP_COUNT_SIZE    (`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_EOP_COUNT_MSB - `MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_EOP_COUNT_LSB +1)
`define MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_EOP_COUNT_RANGE    `MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_EOP_COUNT_MSB : `MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_EOP_COUNT_LSB

//------------------------------------------------
// Internal to NoC Interface data FIFO
//------------------------------------------------

`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH          32
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_MSB      (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH) -1
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_LSB      0
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_SIZE     (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_MSB - `MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_LSB +1)
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE     `MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_MSB : `MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_LSB
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_MSB            ((`CLOG2(`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH)) -1)
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_LSB            0
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_SIZE           (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_MSB - `MGR_NOC_CONT_TO_INTF_DATA_FIFO_LSB +1)
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_RANGE           `MGR_NOC_CONT_TO_INTF_DATA_FIFO_MSB : `MGR_NOC_CONT_TO_INTF_DATA_FIFO_LSB

// Count number of packets in internal datapath FIFO
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_MSB     2
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_LSB     0
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_SIZE    (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_MSB - `MGR_NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_LSB +1)
`define MGR_NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_RANGE    `MGR_NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_MSB : `MGR_NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_LSB

//------------------------------------------------
// External from NoC Interface Control FIFO
//------------------------------------------------

`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH          64
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_MSB      (`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH) -1
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_LSB      0
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_SIZE     (`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_MSB - `MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_LSB +1)
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_RANGE     `MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_MSB : `MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_LSB
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_MSB            ((`CLOG2(`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH)) -1)
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_LSB            0
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_SIZE           (`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_MSB - `MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_LSB +1)
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE           `MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_MSB : `MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_LSB

// Threshold below full when we assert almost full
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_ALMOST_FULL_THRESHOLD  6

// Count number of packets in internal datapath FIFO
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_MSB     8
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_LSB     0
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_SIZE    (`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_MSB - `MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_LSB +1)
`define MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_RANGE    `MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_MSB : `MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_LSB






//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//------------------------------------------------
// include files generated by peArray.py that we dont want to repeat in managerArray.py but need to modify defines from noc_cntl.vh

`define NOC_CONT_NOC_PORT_DATA_WIDTH               `MGR_NOC_CONT_NOC_PORT_DATA_WIDTH  
`define NOC_CONT_NOC_PORT_DATA_MSB                 `NOC_CONT_NOC_PORT_DATA_WIDTH-1
`define NOC_CONT_NOC_PORT_DATA_LSB                 0
`define NOC_CONT_NOC_PORT_DATA_RANGE               `NOC_CONT_NOC_PORT_DATA_MSB : `NOC_CONT_NOC_PORT_DATA_LSB


//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------


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
        reg  [`COMMON_STD_INTF_CNTL_RANGE                       ] fifo_cntl       [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_RANGE]    ;\
        reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE               ] fifo_type       [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_RANGE]    ;\
        reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE              ] fifo_ptype      [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_RANGE]    ;\
        reg  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE                 ] fifo_desttype   [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_RANGE]    ;\
        reg                                                       fifo_pvalid     [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_RANGE]    ;\
        reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE                 ] fifo_data       [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_RANGE]    ;\
        reg  [`PE_EXEC_LANE_ID_RANGE                            ] fifo_laneId     [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_RANGE]    ;\
        reg                                                       fifo_strmId     [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH_RANGE]    ;\
        reg  [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_RANGE          ] fifo_wp              ; \
        reg  [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_RANGE          ] fifo_rp              ; \
        reg  [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_RANGE          ] fifo_depth           ; \
        reg  [`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_EOP_COUNT_RANGE] fifo_eop_count       ; \
        wire                                                      fifo_empty           ; \
        wire                                                      fifo_almost_full     ; \
        wire                                                      fifo_read            ; \
        reg  [`COMMON_STD_INTF_CNTL_RANGE                       ] fifo_read_cntl       ;\
        reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE               ] fifo_read_type       ;\
        reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE              ] fifo_read_ptype      ;\
        reg  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE                 ] fifo_read_desttype   ;\
        reg                                                       fifo_read_pvalid     ;\
        reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE                 ] fifo_read_data       ;\
        reg  [`PE_EXEC_LANE_ID_RANGE                            ] fifo_read_laneId     ;\
        reg                                                       fifo_read_strmId     ;\
        reg                                                       fifo_read_data_valid ; \
        wire [`COMMON_STD_INTF_CNTL_RANGE                       ] cntl                 ;\
        wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE               ] type                 ;\
        wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE              ] ptype                ;\
        wire [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE                 ] desttype             ;\
        wire                                                      pvalid               ;\
        wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE                 ] data                 ;\
        wire [`PE_EXEC_LANE_ID_RANGE                            ] laneId               ;\
        wire                                                      strmId               ;\
        wire                                                      fifo_write           ; \
        wire                                                      clear                ; \
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
            fifo_ptype[fifo_wp]      <= ( fifo_write       ) ? ptype               : \
                                                              fifo_ptype[fifo_wp] ;\
   \
            fifo_desttype[fifo_wp]      <= ( fifo_write       ) ? desttype               : \
                                                              fifo_desttype[fifo_wp] ;\
   \
            fifo_pvalid[fifo_wp]      <= ( fifo_write       ) ? pvalid               : \
                                                              fifo_pvalid[fifo_wp] ;\
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
          assign fifo_almost_full    = (fifo_depth >= 'd`MGR_NOC_CONT_TO_INTF_CONTROL_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
\
          always @(posedge clk)\
            begin\
              fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
              fifo_read_type      <= (fifo_read) ? fifo_type [fifo_rp]   : fifo_read_type   ;\
              fifo_read_ptype      <= (fifo_read) ? fifo_ptype [fifo_rp]   : fifo_read_ptype   ;\
              fifo_read_desttype      <= (fifo_read) ? fifo_desttype [fifo_rp]   : fifo_read_desttype   ;\
              fifo_read_pvalid    <= (fifo_read) ? fifo_pvalid [fifo_rp] : fifo_read_pvalid ;\
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
        reg  [`COMMON_STD_INTF_CNTL_RANGE                    ]  fifo_cntl       [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE            ]  fifo_type       [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE           ]  fifo_ptype      [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE              ]  fifo_desttype   [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg                                                     fifo_pvalid     [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE              ]  fifo_data       [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
\
        reg  [`MGR_MGR_ID_RANGE                              ]  fifo_mgrId      [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`PE_EXEC_LANE_ID_RANGE                         ]  fifo_laneId     [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg                                                     fifo_strmId     [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
\
        reg  [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_RANGE          ]  fifo_wp              ; \
        reg  [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_RANGE          ]  fifo_rp              ; \
        reg  [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_RANGE          ]  fifo_depth           ; \
        reg  [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_RANGE]  fifo_eop_count       ; \
        wire                                                    fifo_empty           ; \
        wire                                                    fifo_almost_full     ; \
        wire                                                    fifo_read            ; \
        reg  [`COMMON_STD_INTF_CNTL_RANGE                    ]  fifo_read_cntl       ;\
        reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE            ]  fifo_read_type       ;\
        reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE           ]  fifo_read_ptype      ;\
        reg  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE              ]  fifo_read_desttype   ;\
        reg                                                     fifo_read_pvalid     ;\
        reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE              ]  fifo_read_data       ;\
\
        reg  [`MGR_MGR_ID_RANGE                              ]  fifo_read_mgrId      ;\
        reg  [`PE_EXEC_LANE_ID_RANGE                         ]  fifo_read_laneId     ;\
        reg                                                     fifo_read_strmId     ;\
\
        reg                                                     fifo_read_data_valid ; \
        wire [`COMMON_STD_INTF_CNTL_RANGE                    ]  cntl                 ;\
        wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE            ]  type                 ;\
        wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE           ]  ptype                ;\
        wire [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE              ]  desttype             ;\
        wire                                                    pvalid               ;\
        wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE              ]  data                 ;\
\
        wire [`PE_PE_ID_RANGE                                ]  mgrId                ;\
        wire [`PE_EXEC_LANE_ID_RANGE                         ]  laneId               ;\
        wire                                                    strmId               ;\
\
        wire                                                    fifo_write           ; \
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
            fifo_type[fifo_wp]      <= ( fifo_write       ) ? type               : \
                                                              fifo_type[fifo_wp] ;\
   \
            fifo_ptype[fifo_wp]      <= ( fifo_write       ) ? ptype               : \
                                                              fifo_ptype[fifo_wp] ;\
   \
            fifo_desttype[fifo_wp]      <= ( fifo_write       ) ? desttype               : \
                                                              fifo_desttype[fifo_wp] ;\
   \
            fifo_pvalid[fifo_wp]    <= ( fifo_write       ) ? pvalid               : \
                                                              fifo_pvalid[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_mgrId[fifo_wp]     <= ( fifo_write       ) ? mgrId               : \
                                                              fifo_mgrId[fifo_wp] ;\
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
          assign fifo_almost_full    = (fifo_depth >= 'd`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
\
          always @(posedge clk)\
            begin\
              fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
              fifo_read_type      <= (fifo_read) ? fifo_type [fifo_rp]   : fifo_read_type   ;\
              fifo_read_ptype      <= (fifo_read) ? fifo_ptype [fifo_rp]   : fifo_read_ptype   ;\
              fifo_read_desttype      <= (fifo_read) ? fifo_desttype [fifo_rp]   : fifo_read_desttype   ;\
              fifo_read_pvalid    <= (fifo_read) ? fifo_pvalid [fifo_rp] : fifo_read_pvalid ;\
              fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
\
              fifo_read_mgrId     <= (fifo_read) ? fifo_mgrId[fifo_rp]   : fifo_read_mgrId  ;\
              fifo_read_laneId    <= (fifo_read) ? fifo_laneId [fifo_rp] : fifo_read_laneId ;\
              fifo_read_strmId    <= (fifo_read) ? fifo_strmId [fifo_rp] : fifo_read_strmId ;\
            end\


//--------------------------------------------------------
// NoC FIFO's

`define NoC_Port_fifo \
\
        reg  [`MGR_NOC_CONT_NOC_PORT_CNTL_RANGE ]                   fifo_cntl      [`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_RANGE] ; \
        reg  [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE]                    fifo_data      [`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_RANGE] ; \
        reg  [`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE]           fifo_wp              ; \
        reg  [`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE]           fifo_rp              ; \
        reg  [`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE]           fifo_depth           ; \
        reg  [`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_RANGE] fifo_eop_count       ; \
        wire                                                        fifo_empty           ; \
        wire                                                        fifo_almost_full     ; \
        wire                                                        fifo_read            ; \
        reg  [`MGR_NOC_CONT_NOC_PORT_CNTL_RANGE ]                   fifo_read_cntl       ; \
        reg  [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE]                    fifo_read_data       ; \
        reg                                                         fifo_read_data_valid ; \
        reg  [`MGR_NOC_CONT_NOC_PORT_CNTL_RANGE ]                   cntl                 ; \
        reg  [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE]                    data                 ; \
        reg                                                         fifo_write           ; \
        wire                                                        clear                ; \
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
          assign fifo_almost_full    = (fifo_depth >= 'd`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH-`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_ALMOST_FULL_THRESHOLD)    ;\
        always @(posedge clk)\
          begin\
            fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
            fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
          end\

//----------------------------------------------------------------------------------------------------
//
`endif

