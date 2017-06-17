
//------------------------------------------------
// MEM_ACC_CONT_ARBITER_STATE width
//------------------------------------------------
`define MEM_ACC_CONT_STATE_MSB            8
`define MEM_ACC_CONT_STATE_LSB            0
`define MEM_ACC_CONT_STATE_SIZE           (`MEM_ACC_CONT_STATE_MSB - `MEM_ACC_CONT_STATE_LSB +1)
`define MEM_ACC_CONT_STATE_RANGE           `MEM_ACC_CONT_STATE_MSB : `MEM_ACC_CONT_STATE_LSB

//------------------------------------------------------------------------------------------------
//------------------------------------------------
// MEM_ACC_CONT state machine states
//------------------------------------------------

`define MEM_ACC_CONT_WAIT                    9'd1
`define MEM_ACC_CONT_DMA                     9'd2
`define MEM_ACC_CONT_LDST                    9'd4
`define MEM_ACC_CONT_LDST_READ_ACCESS        9'd8
`define MEM_ACC_CONT_LDST_WRITE_ACCESS       9'd16
`define MEM_ACC_CONT_DMA_STRM_READ_ACCESS    9'd32
`define MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS   9'd64
`define MEM_ACC_CONT_DMA_STRM0_READ_ACCESS   9'd128
`define MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS  9'd256