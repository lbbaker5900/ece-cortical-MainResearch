/*****************************************************************

    File name   : dma_cont.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

*****************************************************************/


//------------------------------------------------
// DMA_CONT state machine states
//------------------------------------------------

`define DMA_CONT_WAIT                       4'b0001
`define DMA_CONT_STREAMING_INIT             4'b0010
`define DMA_CONT_STREAMING                  4'b0100
`define DMA_CONT_COMPLETE                   4'b1000


//------------------------------------------------
// DMA_CONT_STATE width
//------------------------------------------------
`define DMA_CONT_STATE_MSB            3
`define DMA_CONT_STATE_LSB            0
`define DMA_CONT_STATE_SIZE           (`DMA_CONT_STATE_MSB - `DMA_CONT_STATE_LSB +1)
`define DMA_CONT_STATE_RANGE           `DMA_CONT_STATE_MSB : `DMA_CONT_STATE_LSB

//------------------------------------------------
// DMA_CONT_MEMORY
//------------------------------------------------
`define DMA_CONT_MEMORY_DATA_MSB           `MEM_ACC_CONT_MEMORY_DATA_MSB
`define DMA_CONT_MEMORY_DATA_LSB            0
`define DMA_CONT_MEMORY_DATA_SIZE           (`DMA_CONT_MEMORY_DATA_MSB - `DMA_CONT_MEMORY_DATA_LSB +1)
`define DMA_CONT_MEMORY_DATA_RANGE           `DMA_CONT_MEMORY_DATA_MSB : `DMA_CONT_MEMORY_DATA_LSB
`define DMA_CONT_MEMORY_DATA_WIDTH         `MEM_ACC_CONT_MEMORY_DATA_MSB + 1

//`define DMA_CONT_STRM_ADDRESS_MSB    (`MEM_ACC_CONT_MEMORY_ADDRESS_MSB + (`CLOG2(`MEM_ACC_CONT_MEMORY_BYTE_WIDTH)))
// streams must start on word boundary - FIXME?
`define DMA_CONT_STRM_ADDRESS_MSB    `MEM_ACC_CONT_MEMORY_ADDRESS_MSB
`define DMA_CONT_STRM_ADDRESS_LSB    `MEM_ACC_CONT_MEMORY_ADDRESS_LSB       
`define DMA_CONT_STRM_ADDRESS_RANGE  `DMA_CONT_STRM_ADDRESS_MSB : `DMA_CONT_STRM_ADDRESS_LSB

//------------------------------------------------
// DMA_CONT DATA TYPES
//------------------------------------------------
`define DMA_CONT_DATA_TYPES_MSB            `PE_DATA_TYPES_MSB
`define DMA_CONT_DATA_TYPES_LSB            `PE_DATA_TYPES_LSB
`define DMA_CONT_DATA_TYPES_SIZE           (`DMA_CONT_DATA_TYPES_MSB - `DMA_CONT_DATA_TYPES_LSB +1)
`define DMA_CONT_DATA_TYPES_RANGE           `DMA_CONT_DATA_TYPES_MSB : `DMA_CONT_DATA_TYPES_LSB
// Set maximum numver of elements in a vector  - FIXME
`define DMA_CONT_MAX_NUM_OF_TYPES        `PE_MAX_NUM_OF_TYPES
`define DMA_CONT_MAX_NUM_OF_TYPES_SIZE   (`CLOG2(`DMA_CONT_MAX_NUM_OF_TYPES))
`define DMA_CONT_MAX_NUM_OF_TYPES_RANGE  (`CLOG2(`DMA_CONT_MAX_NUM_OF_TYPES))-1 : 0

`define DMA_CONT_DATA_TYPE_BIT            `PE_DATA_TYPE_BIT   
`define DMA_CONT_DATA_TYPE_NIBBLE         `PE_DATA_TYPE_NIBBLE
`define DMA_CONT_DATA_TYPE_BYTE           `PE_DATA_TYPE_BYTE  
`define DMA_CONT_DATA_TYPE_SWORD          `PE_DATA_TYPE_SWORD 
`define DMA_CONT_DATA_TYPE_WORD           `PE_DATA_TYPE_WORD  

`define DMA_CONT_BIT_TYPES_PER_MEMORY_WORD      `MEM_ACC_CONT_MEMORY_DATA_WIDTH
`define DMA_CONT_NIBBLE_TYPES_PER_MEMORY_WORD   `MEM_ACC_CONT_MEMORY_DATA_WIDTH/4
`define DMA_CONT_BYTE_TYPES_PER_MEMORY_WORD     `MEM_ACC_CONT_MEMORY_DATA_WIDTH/8
`define DMA_CONT_SWORD_TYPES_PER_MEMORY_WORD    `MEM_ACC_CONT_MEMORY_DATA_WIDTH/16
`define DMA_CONT_WORD_TYPES_PER_MEMORY_WORD     `MEM_ACC_CONT_MEMORY_DATA_WIDTH/32

`define DMA_CONT_MAX_TYPES_IN_LAST_MSB          (`CLOG2(`DMA_CONT_BIT_TYPES_PER_MEMORY_WORD))
`define DMA_CONT_MAX_TYPES_IN_LAST_LSB                  0
`define DMA_CONT_MAX_TYPES_IN_LAST_SIZE                 (`DMA_CONT_MAX_TYPES_IN_LAST_MSB - `DMA_CONT_MAX_TYPES_IN_LAST_LSB +1)
`define DMA_CONT_MAX_TYPES_IN_LAST_RANGE                 `DMA_CONT_MAX_TYPES_IN_LAST_MSB : `DMA_CONT_MAX_TYPES_IN_LAST_LSB

`define DMA_CONT_BIT_ADDRESS_SHIFT      (`CLOG2(`DMA_CONT_BIT_TYPES_PER_MEMORY_WORD   ))
`define DMA_CONT_NIBBLE_ADDRESS_SHIFT   (`CLOG2(`DMA_CONT_NIBBLE_TYPES_PER_MEMORY_WORD))   
`define DMA_CONT_BYTE_ADDRESS_SHIFT     (`CLOG2(`DMA_CONT_BYTE_TYPES_PER_MEMORY_WORD  ))     
`define DMA_CONT_SWORD_ADDRESS_SHIFT    (`CLOG2(`DMA_CONT_SWORD_TYPES_PER_MEMORY_WORD ))    
`define DMA_CONT_WORD_ADDRESS_SHIFT     (`CLOG2(`DMA_CONT_WORD_TYPES_PER_MEMORY_WORD  ))    

//------------------------------------------------
// DMA_CONT_STREAM_STATUS
//------------------------------------------------
`define DMA_CONT_STRM_CNTL_MSB            `STREAMING_OP_CNTL_STRM_CNTL_MSB
`define DMA_CONT_STRM_CNTL_LSB            0
`define DMA_CONT_STRM_CNTL_SIZE           (`DMA_CONT_STRM_CNTL_MSB - `DMA_CONT_STRM_CNTL_LSB +1)
`define DMA_CONT_STRM_CNTL_RANGE           `DMA_CONT_STRM_CNTL_MSB : `DMA_CONT_STRM_CNTL_LSB

`define DMA_CONT_STRM_CNTL_SOP            `STREAMING_OP_CNTL_STRM_CNTL_SOP    
`define DMA_CONT_STRM_CNTL_DATA           `STREAMING_OP_CNTL_STRM_CNTL_DATA   
`define DMA_CONT_STRM_CNTL_EOP            `STREAMING_OP_CNTL_STRM_CNTL_EOP    
`define DMA_CONT_STRM_CNTL_SOP_EOP        `STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP
//------------------------------------------------
// DMA_CONT_STREAMS
//------------------------------------------------
`define DMA_CONT_NUM_OF_STREAMS        1
`define DMA_CONT_ONLY_ONE_PORT 


//------------------------------------------------
// DMA_CONT_DATA_WIDTH width
//------------------------------------------------
`define DMA_CONT_DATA_WIDTH_MSB           31
`define DMA_CONT_DATA_WIDTH_LSB            0
`define DMA_CONT_DATA_WIDTH_SIZE           (`DMA_CONT_DATA_WIDTH_MSB - `DMA_CONT_DATA_WIDTH_LSB +1)
`define DMA_CONT_DATA_WIDTH_RANGE           `DMA_CONT_DATA_WIDTH_MSB : `DMA_CONT_DATA_WIDTH_LSB

//------------------------------------------------
// DMA_CONT FIFO
//------------------------------------------------

//`define DMA_CONT_INPUT_FIFO_DEPTH          4
//`define DMA_CONT_INPUT_FIFO_DEPTH_MSB      (`DMA_CONT_INPUT_FIFO_DEPTH) -1
//`define DMA_CONT_INPUT_FIFO_DEPTH_LSB      0
//`define DMA_CONT_INPUT_FIFO_DEPTH_SIZE     (`DMA_CONT_INPUT_FIFO_DEPTH_MSB - `DMA_CONT_INPUT_FIFO_DEPTH_LSB +1)
//`define DMA_CONT_INPUT_FIFO_DEPTH_RANGE     `DMA_CONT_INPUT_FIFO_DEPTH_MSB : `DMA_CONT_INPUT_FIFO_DEPTH_LSB
//`define DMA_CONT_INPUT_FIFO_MSB            ((`CLOG2(`DMA_CONT_INPUT_FIFO_DEPTH)) -1)
//`define DMA_CONT_INPUT_FIFO_LSB            0
//`define DMA_CONT_INPUT_FIFO_SIZE           (`DMA_CONT_INPUT_FIFO_MSB - `DMA_CONT_INPUT_FIFO_LSB +1)
//`define DMA_CONT_INPUT_FIFO_RANGE           `DMA_CONT_INPUT_FIFO_MSB : `DMA_CONT_INPUT_FIFO_LSB


`define DMA_CONT_INPUT_FIFO_DEPTH          8
`define DMA_CONT_INPUT_FIFO_DEPTH_MSB      (`DMA_CONT_INPUT_FIFO_DEPTH) -1
`define DMA_CONT_INPUT_FIFO_DEPTH_LSB      0
`define DMA_CONT_INPUT_FIFO_DEPTH_SIZE     (`DMA_CONT_INPUT_FIFO_DEPTH_MSB - `DMA_CONT_INPUT_FIFO_DEPTH_LSB +1)
`define DMA_CONT_INPUT_FIFO_DEPTH_RANGE     `DMA_CONT_INPUT_FIFO_DEPTH_MSB : `DMA_CONT_INPUT_FIFO_DEPTH_LSB
`define DMA_CONT_INPUT_FIFO_MSB            ((`CLOG2(`DMA_CONT_INPUT_FIFO_DEPTH)) -1)
`define DMA_CONT_INPUT_FIFO_LSB            0
`define DMA_CONT_INPUT_FIFO_SIZE           (`DMA_CONT_INPUT_FIFO_MSB - `DMA_CONT_INPUT_FIFO_LSB +1)
`define DMA_CONT_INPUT_FIFO_RANGE           `DMA_CONT_INPUT_FIFO_MSB : `DMA_CONT_INPUT_FIFO_LSB

// For AGGREGATE_FIFO implemented as single memory, define field ranges
`define DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_WIDTH    `STREAMING_OP_DATA_WIDTH 
`define DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_MSB      `DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_WIDTH-1
`define DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_LSB      0
`define DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_SIZE     (`DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_MSB - `DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_LSB +1)
`define DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_RANGE     `DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_MSB : `DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_LSB

`define DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_WIDTH      `COMMON_STD_INTF_CNTL_WIDTH
`define DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_MSB      (`DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_LSB+`DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_WIDTH) -1
`define DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_LSB      `DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_MSB+1
`define DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_SIZE     (`DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_MSB - `DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_LSB +1)
`define DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_RANGE     `DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_MSB : `DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_LSB

`define DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_WIDTH     `DMA_CONT_INPUT_FIFO_AGGREGATE_CNTL_WIDTH  \
                                                        +`DMA_CONT_INPUT_FIFO_AGGREGATE_DATA_WIDTH

`define DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_MSB            `DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_WIDTH -1
`define DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_LSB            0
`define DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_SIZE           (`DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_MSB - `DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_LSB +1)
`define DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_RANGE           `DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_MSB : `DMA_CONT_INPUT_FIFO_AGGREGATE_FIFO_LSB

// Threshold below full when we assert almost full
// assert almost full when there are only this many entries available in the fifo
`define DMA_CONT_INPUT_FIFO_FIFO_ALMOST_FULL_THRESHOLD 4

//--------------------------------------------------------------------------------------------------
//------------------------------------------------
// FIFO's
//------------------------------------------------

//--------------------------------------------------------
// Streaming Op input and DMA input from stOp

// Uses:
//      inside stOp - shared between from dma and cntl(noc) 
//      inside dma  - from stOp

`define STREAMING_OP_INPUT_FIFO \
        reg  [`STREAMING_OP_DATA_RANGE      ]       fifo_data      [`STREAMING_OP_INPUT_FIFO_DEPTH_RANGE] ; \
        reg  [`DMA_CONT_STRM_CNTL_RANGE     ]       fifo_cntl      [`STREAMING_OP_INPUT_FIFO_DEPTH_RANGE] ; \
        reg  [`STREAMING_OP_INPUT_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_INPUT_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_INPUT_FIFO_RANGE]       fifo_depth           ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        wire [`STREAMING_OP_DATA_RANGE      ]       fifo_read_data       ; \
        wire [`DMA_CONT_STRM_CNTL_RANGE     ]       fifo_read_cntl       ; \
        wire [`STREAMING_OP_DATA_RANGE      ]       data                 ; \
        wire [`DMA_CONT_STRM_CNTL_RANGE     ]       cntl                 ; \
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
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
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
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_INPUT_FIFO_DEPTH-`COMMON_STREAMING_OP_INPUT_FIFO_ALMOST_FULL_THRESHOLD)    ;\
          assign fifo_read_data      = fifo_data [fifo_rp] ;\
          assign fifo_read_cntl      = fifo_cntl [fifo_rp] ;\

//------------------------------------------------------------------------------------------------------------
