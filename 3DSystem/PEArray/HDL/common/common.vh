`ifndef _common_vh_
`define _common_vh_


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

//------------------------------------------------------------------------------------------------------------
`endif
