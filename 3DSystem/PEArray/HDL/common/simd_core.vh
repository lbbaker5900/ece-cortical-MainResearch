`ifndef _simd_core_vh
`define _simd_core_vh

/*****************************************************************

    File name   : simd_core.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

*****************************************************************/



//------------------------------------------------
// SIMD variable widths
//------------------------------------------------

`define SIMD_CORE_INSTRUCTION_MEMORY_DEPTH    1024

`define SIMD_CORE_PROGRAM_COUNTER_SIZE   (`CLOG2(`SIMD_CORE_INSTRUCTION_MEMORY_DEPTH ))

`define SIMD_CORE_PROGRAM_COUNTER_WIDTH          `SIMD_CORE_PROGRAM_COUNTER_SIZE
`define SIMD_CORE_PROGRAM_COUNTER_MSB            `SIMD_CORE_PROGRAM_COUNTER_WIDTH-1
`define SIMD_CORE_PROGRAM_COUNTER_LSB            0
`define SIMD_CORE_PROGRAM_COUNTER_RANGE           `SIMD_CORE_PROGRAM_COUNTER_MSB : `SIMD_CORE_PROGRAM_COUNTER_LSB


`define SIMD_CORE_ACTIVATION_FUNCTION_WIDTH          `SIMD_CORE_ACTIVATION_FUNCTION_SIZE
`define SIMD_CORE_ACTIVATION_FUNCTION_MSB            `SIMD_CORE_ACTIVATION_FUNCTION_WIDTH-1
`define SIMD_CORE_ACTIVATION_FUNCTION_LSB            0
`define SIMD_CORE_ACTIVATION_FUNCTION_RANGE           `SIMD_CORE_ACTIVATION_FUNCTION_MSB : `SIMD_CORE_ACTIVATION_FUNCTION_LSB


// Track python_typedef
`define SIMD_CORE_ACTIVATION_FUNCTION_NOP                     0
`define SIMD_CORE_ACTIVATION_FUNCTION_RELU                    1

//------------------------------------------------------------------------------------------------------------

`define SIMD_CORE_OPERATION_PC_SIZE                    `SIMD_CORE_PROGRAM_COUNTER_WIDTH                                                                                                                                                                             
`define SIMD_CORE_OPERATION_PC_MSB                    (`SIMD_CORE_OPERATION_PC_LSB + `SIMD_CORE_OPERATION_PC_SIZE-1)
`define SIMD_CORE_OPERATION_PC_LSB                    0
`define SIMD_CORE_OPERATION_PC_RANGE                  `SIMD_CORE_OPERATION_PC_MSB : `SIMD_CORE_OPERATION_PC_LSB

`define SIMD_CORE_OPERATION_ACTIVATION_FUNCTION_SIZE     2                                                                            
`define SIMD_CORE_OPERATION_ACTIVATION_FUNCTION_MSB      (`SIMD_CORE_OPERATION_ACTIVATION_FUNCTION_LSB + `SIMD_CORE_OPERATION_ACTIVATION_FUNCTION_SIZE-1)
`define SIMD_CORE_OPERATION_ACTIVATION_FUNCTION_LSB      (`SIMD_CORE_OPERATION_PC_MSB+ 1)
`define SIMD_CORE_OPERATION_ACTIVATION_FUNCTION_RANGE    `SIMD_CORE_OPERATION_ACTIVATION_FUNCTION_MSB : `SIMD_CORE_OPERATION_ACTIVATION_FUNCTION_LSB     
                                                             

//------------------------------------------------------------------------------------------------------------
//
`define SIMD_CORE_OPERATION_PC_NUM_OF_OPS              5

`define SIMD_CORE_OPERATION_PC_NOP                     0
`define SIMD_CORE_OPERATION_PC_CMP                     100
`define SIMD_CORE_OPERATION_PC_MAC                     200
`define SIMD_CORE_OPERATION_PC_EXP                     300
`define SIMD_CORE_OPERATION_PC_DIV                     400

//                                                act  
//                                                fn                pc             
`define SIMD_CORE_OPERATION_NOP                  {2'd0,  10'd`SIMD_CORE_OPERATION_PC_NOP  }
`define SIMD_CORE_OPERATION_POOLING              {2'd0,  10'd`SIMD_CORE_OPERATION_PC_POOL }
//------------------------------------------------------------------------------------------------------------

`define SIMD_CORE_OPERATION_SIZE            ( `SIMD_CORE_OPERATION_ACTIVATION_FUNCTION_SIZE + \
                                              `SIMD_CORE_OPERATION_PC_SIZE                    \
                                            )

`define SIMD_CORE_OPERATION_WIDTH          `SIMD_CORE_OPERATION_SIZE
`define SIMD_CORE_OPERATION_MSB            `SIMD_CORE_OPERATION_WIDTH-1
`define SIMD_CORE_OPERATION_LSB            0
`define SIMD_CORE_OPERATION_RANGE           `SIMD_CORE_OPERATION_MSB : `SIMD_CORE_OPERATION_LSB


//------------------------------------------------------------------------------------------------------------
// Special Function specific
//
// CMP
//
`define SIMD_CORE_SFU_CMP_WIDTH          3
`define SIMD_CORE_SFU_CMP_MSB            `SIMD_CORE_SFU_CMP_WIDTH-1
`define SIMD_CORE_SFU_CMP_LSB            0
`define SIMD_CORE_SFU_CMP_RANGE           `SIMD_CORE_SFU_CMP_MSB : `SIMD_CORE_SFU_CMP_LSB

`define SIMD_CORE_SFU_CMP_OP_EQ            0
`define SIMD_CORE_SFU_CMP_OP_LT            1
`define SIMD_CORE_SFU_CMP_OP_GT            2

//------------------------------------------------------------------------------------------------------------
// FSM
//
//--------------------------------------------------------
// Debug: do something just to stop EXP and DIV functions from being removed

`define SIMD_CORE_CNTL_WAIT                            14'b00_0000_0000_0001
`define SIMD_CORE_CNTL_PREPARE_OP                      14'b00_0000_0000_0010

`define SIMD_CORE_CNTL_SFU_START                       14'b00_0000_0000_0100
`define SIMD_CORE_CNTL_SFU_RUNNING                     14'b00_0000_0000_1000
`define SIMD_CORE_CNTL_SFU_COMPLETE                    14'b00_0000_0001_0000
`define SIMD_CORE_CNTL_SFU_NEXT                        14'b00_0000_0010_0000
`define SIMD_CORE_CNTL_WAIT_FOR_SIMD                   14'b00_0000_0100_0000
`define SIMD_CORE_CNTL_SEND_DATA                       14'b00_0000_1000_0000
`define SIMD_CORE_CNTL_WAIT_FOR_COMPLETE               14'b00_0001_0000_0000
`define SIMD_CORE_CNTL_WAIT_COMPLETE_DEASSERTED        14'b00_0010_0000_0000
                                                           
`define SIMD_CORE_CNTL_COMPLETE                        14'b01_0000_0000_0000

`define SIMD_CORE_CNTL_ERR                             14'b10_0000_0000_0000

`define SIMD_CORE_CNTL_STATE_WIDTH                     14
`define SIMD_CORE_CNTL_STATE_MSB                       `SIMD_CORE_CNTL_STATE_WIDTH-1
`define SIMD_CORE_CNTL_STATE_LSB                       0
`define SIMD_CORE_CNTL_STATE_SIZE                      (`SIMD_CORE_CNTL_STATE_MSB - `SIMD_CORE_CNTL_STATE_LSB +1)
`define SIMD_CORE_CNTL_STATE_RANGE                      `SIMD_CORE_CNTL_STATE_MSB : `SIMD_CORE_CNTL_STATE_LSB



//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
//Special function controllers
//
//------------------------------------------------------------------------------------------------------------
// NOP
`define SIMD_CORE_SFU_NOP_CNTL_WAIT                            4'b0001
`define SIMD_CORE_SFU_NOP_CNTL_NOP                             4'b0010

`define SIMD_CORE_SFU_NOP_CNTL_COMPLETE                        4'b0100
`define SIMD_CORE_SFU_NOP_CNTL_ERR                             4'b1000

`define SIMD_CORE_SFU_NOP_CNTL_STATE_WIDTH                     4
`define SIMD_CORE_SFU_NOP_CNTL_STATE_MSB                       `SIMD_CORE_SFU_NOP_CNTL_STATE_WIDTH-1
`define SIMD_CORE_SFU_NOP_CNTL_STATE_LSB                       0
`define SIMD_CORE_SFU_NOP_CNTL_STATE_SIZE                      (`SIMD_CORE_SFU_NOP_CNTL_STATE_MSB - `SIMD_CORE_SFU_NOP_CNTL_STATE_LSB +1)
`define SIMD_CORE_SFU_NOP_CNTL_STATE_RANGE                      `SIMD_CORE_SFU_NOP_CNTL_STATE_MSB : `SIMD_CORE_SFU_NOP_CNTL_STATE_LSB

//------------------------------------------------------------------------------------------------------------
// ReLu
`define SIMD_CORE_SFU_RELU_CNTL_WAIT                            4'b0001
`define SIMD_CORE_SFU_RELU_CNTL_RELU                            4'b0010

`define SIMD_CORE_SFU_RELU_CNTL_COMPLETE                        4'b0100
`define SIMD_CORE_SFU_RELU_CNTL_ERR                             4'b1000

`define SIMD_CORE_SFU_RELU_CNTL_STATE_WIDTH                     4
`define SIMD_CORE_SFU_RELU_CNTL_STATE_MSB                       `SIMD_CORE_SFU_RELU_CNTL_STATE_WIDTH-1
`define SIMD_CORE_SFU_RELU_CNTL_STATE_LSB                       0
`define SIMD_CORE_SFU_RELU_CNTL_STATE_SIZE                      (`SIMD_CORE_SFU_RELU_CNTL_STATE_MSB - `SIMD_CORE_SFU_RELU_CNTL_STATE_LSB +1)
`define SIMD_CORE_SFU_RELU_CNTL_STATE_RANGE                      `SIMD_CORE_SFU_RELU_CNTL_STATE_MSB : `SIMD_CORE_SFU_RELU_CNTL_STATE_LSB

//------------------------------------------------------------------------------------------------------------
// Add
`define SIMD_CORE_SFU_ADD_CNTL_WAIT                            9'b0_0000_0001
`define SIMD_CORE_SFU_ADD_CNTL_ACC_ALL                         9'b0_0000_0010
`define SIMD_CORE_SFU_ADD_CNTL_ACC_FLUSH                       9'b0_0000_0100
`define SIMD_CORE_SFU_ADD_CNTL_ACC_COMPLETE                    9'b0_0000_1000

`define SIMD_CORE_SFU_ADD_CNTL_COMPLETE                        9'b0_1000_0000
`define SIMD_CORE_SFU_ADD_CNTL_ERR                             9'b1_0000_0000

`define SIMD_CORE_SFU_ADD_CNTL_STATE_WIDTH                     9
`define SIMD_CORE_SFU_ADD_CNTL_STATE_MSB                       `SIMD_CORE_SFU_ADD_CNTL_STATE_WIDTH-1
`define SIMD_CORE_SFU_ADD_CNTL_STATE_LSB                       0
`define SIMD_CORE_SFU_ADD_CNTL_STATE_SIZE                      (`SIMD_CORE_SFU_ADD_CNTL_STATE_MSB - `SIMD_CORE_SFU_ADD_CNTL_STATE_LSB +1)
`define SIMD_CORE_SFU_ADD_CNTL_STATE_RANGE                      `SIMD_CORE_SFU_ADD_CNTL_STATE_MSB : `SIMD_CORE_SFU_ADD_CNTL_STATE_LSB


//------------------------------------------------------------------------------------------------------------
// Exp
`define SIMD_CORE_SFU_EXP_CNTL_WAIT                            9'b0_0000_0001
`define SIMD_CORE_SFU_EXP_CNTL_SETTLE                          9'b0_0000_0010
`define SIMD_CORE_SFU_EXP_CNTL_LOAD                            9'b0_0000_0100
`define SIMD_CORE_SFU_EXP_CNTL_INC                             9'b0_0000_1000

`define SIMD_CORE_SFU_EXP_CNTL_COMPLETE                        9'b0_1000_0000
`define SIMD_CORE_SFU_EXP_CNTL_ERR                             9'b1_0000_0000

`define SIMD_CORE_SFU_EXP_CNTL_STATE_WIDTH                     9
`define SIMD_CORE_SFU_EXP_CNTL_STATE_MSB                       `SIMD_CORE_SFU_EXP_CNTL_STATE_WIDTH-1
`define SIMD_CORE_SFU_EXP_CNTL_STATE_LSB                       0
`define SIMD_CORE_SFU_EXP_CNTL_STATE_SIZE                      (`SIMD_CORE_SFU_EXP_CNTL_STATE_MSB - `SIMD_CORE_SFU_EXP_CNTL_STATE_LSB +1)
`define SIMD_CORE_SFU_EXP_CNTL_STATE_RANGE                      `SIMD_CORE_SFU_EXP_CNTL_STATE_MSB : `SIMD_CORE_SFU_EXP_CNTL_STATE_LSB


//------------------------------------------------------------------------------------------------------------
// Exp
`define SIMD_CORE_SFU_DIV_CNTL_WAIT                            10'b00_0000_0001
`define SIMD_CORE_SFU_DIV_CNTL_START                           10'b00_0000_0010
`define SIMD_CORE_SFU_DIV_CNTL_WAIT_DIV_START                  10'b00_0000_0100
`define SIMD_CORE_SFU_DIV_CNTL_SETTLE                          10'b00_0000_1000
`define SIMD_CORE_SFU_DIV_CNTL_LOAD                            10'b00_0001_0000
`define SIMD_CORE_SFU_DIV_CNTL_LOAD_LOCAL                      10'b00_0010_0000
`define SIMD_CORE_SFU_DIV_CNTL_INC                             10'b00_0100_0000
`define SIMD_CORE_SFU_DIV_CNTL_LOAD_INPUTS                     10'b00_1000_0000

`define SIMD_CORE_SFU_DIV_CNTL_COMPLETE                        10'b01_0000_0000
`define SIMD_CORE_SFU_DIV_CNTL_ERR                             10'b10_0000_0000

`define SIMD_CORE_SFU_DIV_CNTL_STATE_WIDTH                     10
`define SIMD_CORE_SFU_DIV_CNTL_STATE_MSB                       `SIMD_CORE_SFU_DIV_CNTL_STATE_WIDTH-1
`define SIMD_CORE_SFU_DIV_CNTL_STATE_LSB                       0
`define SIMD_CORE_SFU_DIV_CNTL_STATE_SIZE                      (`SIMD_CORE_SFU_DIV_CNTL_STATE_MSB - `SIMD_CORE_SFU_DIV_CNTL_STATE_LSB +1)
`define SIMD_CORE_SFU_DIV_CNTL_STATE_RANGE                      `SIMD_CORE_SFU_DIV_CNTL_STATE_MSB : `SIMD_CORE_SFU_DIV_CNTL_STATE_LSB



//------------------------------------------------------------------------------------------------------------
`endif
