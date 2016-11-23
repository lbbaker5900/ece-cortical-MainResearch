/*****************************************************************

    File name   : pe.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// Stack Bus stream
//------------------------------------------------

`define PE_STD_LANE_WIDTH_MSB           31
`define PE_STD_LANE_WIDTH_LSB            0
`define PE_STD_LANE_WIDTH_SIZE           (`PE_STD_LANE_WIDTH_MSB - `PE_STD_LANE_WIDTH_LSB +1)
`define PE_STD_LANE_WIDTH_RANGE           `PE_STD_LANE_WIDTH_MSB : `PE_STD_LANE_WIDTH_LSB

`define PE_STU_LANE_WIDTH_MSB           31
`define PE_STU_LANE_WIDTH_LSB            0
`define PE_STU_LANE_WIDTH_SIZE           (`PE_STU_LANE_WIDTH_MSB - `PE_STU_LANE_WIDTH_LSB +1)
`define PE_STU_LANE_WIDTH_RANGE           `PE_STU_LANE_WIDTH_MSB : `PE_STU_LANE_WIDTH_LSB

//------------------------------------------------
// PE Stack bus streams
//------------------------------------------------

`define PE_NUM_OF_STREAMS               2
`define PE_NUM_OF_STREAMS_MSB           (`PE_NUM_OF_STREAMS -1)
`define PE_NUM_OF_STREAMS_LSB            0
`define PE_NUM_OF_STREAMS_SIZE           (`PE_NUM_OF_STREAMS_MSB - `PE_NUM_OF_STREAMS_LSB +1)
`define PE_NUM_OF_STREAMS_RANGE           `PE_NUM_OF_STREAMS_MSB : `PE_NUM_OF_STREAMS_LSB

//------------------------------------------------
// PE Execution Lane 
//------------------------------------------------

`define PE_NUM_OF_EXEC_LANES         32
`define PE_NUM_OF_EXEC_LANES_MSB           (`PE_NUM_OF_EXEC_LANES -1)
`define PE_NUM_OF_EXEC_LANES_LSB            0
`define PE_NUM_OF_EXEC_LANES_SIZE           (`PE_NUM_OF_EXEC_LANES_MSB - `PE_NUM_OF_EXEC_LANES_LSB +1)
`define PE_NUM_OF_EXEC_LANES_RANGE           `PE_NUM_OF_EXEC_LANES_MSB : `PE_NUM_OF_EXEC_LANES_LSB

`define PE_EXEC_LANE_ID_MSB               ((`CLOG2(`PE_NUM_OF_EXEC_LANES))-1)
`define PE_EXEC_LANE_ID_LSB               0
`define PE_EXEC_LANE_ID_SIZE              (`PE_EXEC_LANE_ID_MSB - `PE_EXEC_LANE_ID_LSB +1)
`define PE_EXEC_LANE_ID_RANGE              `PE_EXEC_LANE_ID_MSB : `PE_EXEC_LANE_ID_LSB

`define PE_EXEC_LANE_WIDTH_MSB           31
`define PE_EXEC_LANE_WIDTH_LSB            0
`define PE_EXEC_LANE_WIDTH_SIZE           (`PE_EXEC_LANE_WIDTH_MSB - `PE_EXEC_LANE_WIDTH_LSB +1)
`define PE_EXEC_LANE_WIDTH_RANGE           `PE_EXEC_LANE_WIDTH_MSB : `PE_EXEC_LANE_WIDTH_LSB

`define PE_CHIPLET_ADDRESS_MSB     23
`define PE_CHIPLET_ADDRESS_LSB     0
`define PE_CHIPLET_ADDRESS_SIZE    (`PE_CHIPLET_ADDRESS_MSB - `PE_CHIPLET_ADDRESS_LSB +1)
`define PE_CHIPLET_ADDRESS_RANGE    `PE_CHIPLET_ADDRESS_MSB : `PE_CHIPLET_ADDRESS_LSB

// Used to determine which PE address resides
`define PE_PE_DECODE_ADDRESS_MSB    `PE_CHIPLET_ADDRESS_MSB
`define PE_PE_DECODE_ADDRESS_LSB    (`PE_CHIPLET_ADDRESS_MSB - ((`CLOG2(`PE_ARRAY_NUM_OF_PE))-1))
`define PE_PE_DECODE_ADDRESS_SIZE   (`PE_PE_DECODE_ADDRESS_MSB - `PE_PE_DECODE_ADDRESS_LSB +1)
`define PE_PE_DECODE_ADDRESS_RANGE   `PE_PE_DECODE_ADDRESS_MSB : `PE_PE_DECODE_ADDRESS_LSB

`define PE_PE_ID_MSB               ((`CLOG2(`PE_ARRAY_NUM_OF_PE))-1)
`define PE_PE_ID_LSB               0
`define PE_PE_ID_SIZE              (`PE_PE_ID_MSB - `PE_PE_ID_LSB +1)
`define PE_PE_ID_RANGE              `PE_PE_ID_MSB : `PE_PE_ID_LSB

`define PE_PE_ID_BITMASK_MSB               (`PE_ARRAY_NUM_OF_PE-1)
`define PE_PE_ID_BITMASK_LSB               0
`define PE_PE_ID_BITMASK_SIZE              (`PE_PE_ID_BITMASK_MSB - `PE_PE_ID_BITMASK_LSB +1)
`define PE_PE_ID_BITMASK_RANGE              `PE_PE_ID_BITMASK_MSB : `PE_PE_ID_BITMASK_LSB

`define PE_DATA_TYPES_MSB            3
`define PE_DATA_TYPES_LSB            0
`define PE_DATA_TYPES_SIZE           (`PE_DATA_TYPES_MSB - `PE_DATA_TYPES_LSB +1)
`define PE_DATA_TYPES_RANGE           `PE_DATA_TYPES_MSB : `PE_DATA_TYPES_LSB
// Set maximum numver of elements in a vector  - FIXME
`define PE_MAX_NUM_OF_TYPES        2**16
`define PE_MAX_NUM_OF_TYPES_SIZE   (`CLOG2(`PE_MAX_NUM_OF_TYPES))
`define PE_MAX_NUM_OF_TYPES_RANGE  (`CLOG2(`PE_MAX_NUM_OF_TYPES))-1 : 0
`define PE_MAX_STAGGER             2**8
`define PE_MAX_STAGGER_SIZE        (`CLOG2(`PE_MAX_STAGGER))
`define PE_MAX_STAGGER_RANGE       (`CLOG2(`PE_MAX_STAGGER))-1 : 0

`define PE_DATA_TYPE_BIT            'd0
`define PE_DATA_TYPE_NIBBLE         'd1
`define PE_DATA_TYPE_BYTE           'd2
`define PE_DATA_TYPE_SWORD          'd3
`define PE_DATA_TYPE_WORD           'd4

`define PE_MEMORY_DATA_WIDTH               32
`define PE_BIT_TYPES_PER_MEMORY_WORD      `PE_MEMORY_DATA_WIDTH
`define PE_NIBBLE_TYPES_PER_MEMORY_WORD   `PE_MEMORY_DATA_WIDTH/4
`define PE_BYTE_TYPES_PER_MEMORY_WORD     `PE_MEMORY_DATA_WIDTH/8
`define PE_SWORD_TYPES_PER_MEMORY_WORD    `PE_MEMORY_DATA_WIDTH/16
`define PE_WORD_TYPES_PER_MEMORY_WORD     `PE_MEMORY_DATA_WIDTH/32

`define PE_BIT_ADDRESS_SHIFT      (`CLOG2(`PE_BIT_TYPES_PER_MEMORY_WORD   ))
`define PE_NIBBLE_ADDRESS_SHIFT   (`CLOG2(`PE_NIBBLE_TYPES_PER_MEMORY_WORD))   
`define PE_BYTE_ADDRESS_SHIFT     (`CLOG2(`PE_BYTE_TYPES_PER_MEMORY_WORD  ))     
`define PE_SWORD_ADDRESS_SHIFT    (`CLOG2(`PE_SWORD_TYPES_PER_MEMORY_WORD ))    
`define PE_WORD_ADDRESS_SHIFT     (`CLOG2(`PE_WORD_TYPES_PER_MEMORY_WORD  ))    

`define PE_NOC_INTERNAL_DATA_WIDTH         40
`define PE_NOC_INTERNAL_DATA_MSB          `PE_NOC_INTERNAL_DATA_WIDTH-1
`define PE_NOC_INTERNAL_DATA_LSB          0
`define PE_NOC_INTERNAL_DATA_RANGE        `PE_NOC_INTERNAL_DATA_MSB : `PE_NOC_INTERNAL_DATA_LSB

