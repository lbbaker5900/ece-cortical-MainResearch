`ifndef _mem_acc_cont_vh
`define _mem_acc_cont_vh

/*****************************************************************

    File name   : mem_acc_cont.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

*****************************************************************/

//------------------------------------------------
// MEM_ACC_CONT_BANKS
// Note: used by python script mem_acc_cont.py
// Allocate one bank per execution lane. The assumption is one stream is from Stack bus and the other from the local memory
// So only one DMA request to local memory per execution lane
// 
//------------------------------------------------
`define MEM_ACC_CONT_NUM_OF_MEMORY_BANKS    32
`define MEM_ACC_CONT_NUM_OF_PORTS           32

//------------------------------------------------
// Do we allow each lane to access any bank
`define MEM_ACC_CONT_ALLOW_ACCESS_ANY False 

//------------------------------------------------------------------------------------------------
//------------------------------------------------
// MEM_ACC_CONT_ARBITER state machine states
//------------------------------------------------

`define MEM_ACC_CONT_ARBITER_WAIT           5'b00001
`define MEM_ACC_CONT_ARBITER_LDST_GRANT     5'b00010
`define MEM_ACC_CONT_ARBITER_LDST_RELEASE   5'b00100
`define MEM_ACC_CONT_ARBITER_DMA_GRANT      5'b01000
`define MEM_ACC_CONT_ARBITER_DMA_RELEASE    5'b10000

//------------------------------------------------
// MEM_ACC_CONT_ARBITER_STATE width
//------------------------------------------------
`define MEM_ACC_CONT_ARBITER_STATE_MSB            4
`define MEM_ACC_CONT_ARBITER_STATE_LSB            0
`define MEM_ACC_CONT_ARBITER_STATE_SIZE           (`MEM_ACC_CONT_ARBITER_STATE_MSB - `MEM_ACC_CONT_ARBITER_STATE_LSB +1)
`define MEM_ACC_CONT_ARBITER_STATE_RANGE           `MEM_ACC_CONT_ARBITER_STATE_MSB : `MEM_ACC_CONT_ARBITER_STATE_LSB

//------------------------------------------------------------------------------------------------
// MEM_ACC_CONT state machine states
//------------------------------------------------
`include "../../HDL/common/mem_acc_cont_bank_fsm_state_definitions.vh"
//------------------------------------------------

//------------------------------------------------------------------------------------------------
//------------------------------------------------
// MEM_ACC_CONT_MEMORY
//------------------------------------------------
`define MEM_ACC_CONT_MEMORY_ADDRESS_MSB           `STREAMING_OP_CNTL_CHIPLET_ADDRESS_MSB
`define MEM_ACC_CONT_MEMORY_ADDRESS_LSB            0
`define MEM_ACC_CONT_MEMORY_ADDRESS_SIZE           (`MEM_ACC_CONT_MEMORY_ADDRESS_MSB - `MEM_ACC_CONT_MEMORY_ADDRESS_LSB +1)
`define MEM_ACC_CONT_MEMORY_ADDRESS_RANGE           `MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_LSB

`define MEM_ACC_CONT_MEMORY_DATA_MSB           (`MEM_ACC_CONT_MEMORY_DATA_WIDTH - 1)
`define MEM_ACC_CONT_MEMORY_DATA_LSB            0
`define MEM_ACC_CONT_MEMORY_DATA_SIZE           (`MEM_ACC_CONT_MEMORY_DATA_MSB - `MEM_ACC_CONT_MEMORY_DATA_LSB +1)
`define MEM_ACC_CONT_MEMORY_DATA_RANGE           `MEM_ACC_CONT_MEMORY_DATA_MSB : `MEM_ACC_CONT_MEMORY_DATA_LSB

`define MEM_ACC_CONT_MEMORY_DATA_WIDTH          `PE_MEMORY_DATA_WIDTH
`define MEM_ACC_CONT_MEMORY_BYTE_WIDTH          (`MEM_ACC_CONT_MEMORY_DATA_WIDTH / 8)
`define MEM_ACC_CONT_MEMORY_BYTE_SHIFT          (`MEM_ACC_CONT_MEMORY_BYTE_WIDTH)
//FIXME
//`define MEM_ACC_CONT_BANK_DEPTH                2**(`MEM_ACC_CONT_BANK_WIDTH)
`define MEM_ACC_CONT_BANK_DEPTH                1024
//`define MEM_ACC_CONT_BANK_ADDRESS_MSB           (`MEM_ACC_CONT_MEMORY_ADDRESS_MSB - (`CLOG2(`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS)))
`define MEM_ACC_CONT_BANK_ADDRESS_MSB           9

`define MEM_ACC_CONT_BANK_WIDTH                `MEM_ACC_CONT_BANK_ADDRESS_MSB - `MEM_ACC_CONT_BANK_ADDRESS_LSB +1
`define MEM_ACC_CONT_BANK_ADDRESS_LSB            0
`define MEM_ACC_CONT_BANK_ADDRESS_SIZE           (`MEM_ACC_CONT_BANK_ADDRESS_MSB - `MEM_ACC_CONT_BANK_ADDRESS_LSB +1)
`define MEM_ACC_CONT_BANK_ADDRESS_RANGE           `MEM_ACC_CONT_BANK_ADDRESS_MSB : `MEM_ACC_CONT_BANK_ADDRESS_LSB

`define MEM_ACC_CONT_BANK_DATA_MSB            `MEM_ACC_CONT_MEMORY_DATA_MSB
`define MEM_ACC_CONT_BANK_DATA_LSB            0
`define MEM_ACC_CONT_BANK_DATA_SIZE           (`MEM_ACC_CONT_BANK_DATA_MSB - `MEM_ACC_CONT_BANK_DATA_LSB +1)
`define MEM_ACC_CONT_BANK_DATA_RANGE           `MEM_ACC_CONT_BANK_DATA_MSB : `MEM_ACC_CONT_BANK_DATA_LSB


`endif

