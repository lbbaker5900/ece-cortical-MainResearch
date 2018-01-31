`ifndef _common_vh_
`define _common_vh_

//------------------------------------------------
// Synthesis/Technology
//------------------------------------------------

`define TECHNOLOGY_28NM_NODE  0
`define TECHNOLOGY_65NM_NODE  1


//------------------------------------------------------------------------------------------------------------
`define CLOG2(x) \
  (x <=  1)          ?  0  : \
  (x <=  2)          ?  1  : \
  (x <=  4)          ?  2  : \
  (x <=  8)          ?  3  : \
  (x <= 16)          ?  4  : \
  (x <= 32)          ?  5  : \
  (x <= 64)          ?  6  : \
  (x <= 128)         ?  7  : \
  (x <= 256)         ?  8  : \
  (x <= 512)         ?  9  : \
  (x <= 1024)        ? 10  : \
  (x <= 2048)        ? 11  : \
  (x <= 4096)        ? 12  : \
  (x <= 8192)        ? 13  : \
  (x <= 16384)       ? 14  : \
  (x <= 32768)       ? 15  : \
  (x <= 65536)       ? 16  : \
  (x <= 131072)      ? 17  : \
  (x <= 262144)      ? 18  : \
  (x <= 524288)      ? 19  : \
  (x <= 1048576)     ? 20  : \
  -1

//---------------------------------------------------------------------------------------------------------------------
// Standard interface

// EOM/SOM codes for cntl signal for the "standard" inter-module interface
`define COMMON_STD_INTF_CNTL_WIDTH          2
`define COMMON_STD_INTF_CNTL_MSB            `COMMON_STD_INTF_CNTL_WIDTH-1
`define COMMON_STD_INTF_CNTL_LSB            0
`define COMMON_STD_INTF_CNTL_RANGE          `COMMON_STD_INTF_CNTL_MSB : `COMMON_STD_INTF_CNTL_LSB

`define COMMON_STD_INTF_CNTL_SOM            1
`define COMMON_STD_INTF_CNTL_MOM            0
`define COMMON_STD_INTF_CNTL_EOM            2
`define COMMON_STD_INTF_CNTL_SOM_EOM        3

//------------------------------------------------------------------------------------------------------------
// FIFO's

// Threshold below full when we assert almost full
`define COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT  4
`define COMMON_STREAMING_OP_INPUT_FIFO_ALMOST_FULL_THRESHOLD 4


//------------------------------------------------------------------------------------------------------------
`define COMMON_IEEE754_FLOAT_ONE       32'h3F80_0000
`define COMMON_IEEE754_FLOAT_ZERO      32'h0000_0000
`define COMMON_IEEE754_FLOAT_INFINITY  32'h7F80_0000
`define COMMON_INT_MAX                 32'hFFFF_FFFF

`define COMMON_IEEE754_FRACTION_WIDTH          23
`define COMMON_IEEE754_FRACTION_MSB            (`COMMON_IEEE754_FRACTION_LSB+`COMMON_IEEE754_FRACTION_WIDTH-1)
`define COMMON_IEEE754_FRACTION_LSB            0
`define COMMON_IEEE754_FRACTION_RANGE          `COMMON_IEEE754_FRACTION_MSB : `COMMON_IEEE754_FRACTION_LSB

`define COMMON_IEEE754_EXPONENT_WIDTH          8
`define COMMON_IEEE754_EXPONENT_MSB            (`COMMON_IEEE754_FRACTION_LSB+`COMMON_IEEE754_EXPONENT_WIDTH-1)
`define COMMON_IEEE754_EXPONENT_LSB            (`COMMON_IEEE754_FRACTION_MSB+1)
`define COMMON_IEEE754_EXPONENT_RANGE          `COMMON_IEEE754_EXPONENT_MSB : `COMMON_IEEE754_EXPONENT_LSB

`define COMMON_IEEE754_SIGN_WIDTH          1
`define COMMON_IEEE754_SIGN_MSB            (`COMMON_IEEE754_SIGN_LSB+`COMMON_IEEE754_SIGN_WIDTH-1)
`define COMMON_IEEE754_SIGN_LSB            (`COMMON_IEEE754_EXPONENT_MSB+1)
`define COMMON_IEEE754_SIGN_RANGE          `COMMON_IEEE754_SIGN_MSB : `COMMON_IEEE754_SIGN_LSB

//------------------------------------------------------------------------------------------------------------
// ASCII
`define COMMON_ASCII_SPACE         'h20
`define COMMON_ASCII_CR            'h0D
`define COMMON_ASCII_LF            'h0A
`define COMMON_ASCII_COMMA         'h2C
`define COMMON_ASCII_POUND         'h23
`define COMMON_ASCII_COLON         'h3A
`define COMMON_ASCII_SEMICOLON     'h3B
`define COMMON_ASCII_SLASH         'h2F
`define COMMON_ASCII_HIPHON        'h2D

//------------------------------------------------------------------------------------------------------------
`endif
