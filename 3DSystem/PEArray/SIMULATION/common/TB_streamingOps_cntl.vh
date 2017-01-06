`ifndef _TB_streamingOps_cntl_vh
`define _TB_streamingOps_cntl_vh

/*********************************************************************************************

    File name   : TB_streamingOps_cntl.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Dec 2016
    email       : lbbaker@ncsu.edu

    Description : System verilog testbench help related to streamingOps_cntl.v

*********************************************************************************************/
    

// FIXME: make sure we track streamingOps_cntl.vh

//------------------------------------------------
// Commands to streamingOps_cntl via regFile
//------------------------------------------------


typedef enum logic [`PE_DATA_TYPES_RANGE ] {
                                            PE_DATA_TYPE_BIT           = 0,
                                            PE_DATA_TYPE_NIBBLE        = 1,
                                            PE_DATA_TYPE_BYTE          = 2,
                                            PE_DATA_TYPE_SWORD         = 3,
                                            PE_DATA_TYPE_WORD          = 4,
                                            PE_DATA_TYPE_NA            = {`PE_DATA_TYPES_SIZE{1'b1}}
                                          } PE_DATA_TYPE ;

typedef enum logic [`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE ] {
                                                                  PE_STOP_IS_BITSUM         = `STREAMING_OP_CNTL_OPERATION_BITSUM               ,
                                                                  PE_STOP_IS_BYTESUM        = `STREAMING_OP_CNTL_OPERATION_BYTESUM              ,
                                                                  PE_STOP_IS_FP_MAC         = `STREAMING_OP_CNTL_OPERATION_FP_MAC               ,
                                                                  PE_STOP_IS_FP_MAX         = `STREAMING_OP_CNTL_OPERATION_FP_MAX               ,
                                                                  PE_STOP_IS_FP_FIRST_GT    = `STREAMING_OP_CNTL_OPERATION_FP_FIRST_GT          ,
                                                                  PE_STOP_IS_FP_MAX_N       = `STREAMING_OP_CNTL_OPERATION_FP_MAX_N             ,
                                                                  PE_STOP_IS_FP_MAX_N_THR   = `STREAMING_OP_CNTL_OPERATION_FP_MAX_N_THR         ,
                                                                  PE_STOP_IS_FP_MAX_ALL_THR = `STREAMING_OP_CNTL_OPERATION_FP_MAX_ALL_THR       ,
                                                                  PE_STOP_IS_NOP            = `STREAMING_OP_CNTL_OPERATION_NOP                  
                                                                } PE_STOP_OPCODE ;

typedef enum logic [`STREAMING_OP_CNTL_OPERATION_STREAM_SRC_RANGE  ] {
                                                                       PE_STOP_SRC_IS_NA     = `STREAMING_OP_CNTL_OPERATION_FROM_NONE       ,
                                                                       PE_STOP_SRC_IS_MEMORY = `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY     ,
                                                                       PE_STOP_SRC_IS_STD    = `STREAMING_OP_CNTL_OPERATION_FROM_STD        ,
                                                                       PE_STOP_SRC_IS_NOC    = `STREAMING_OP_CNTL_OPERATION_FROM_NOC        
                                                                     } PE_STOP_SRC ;


typedef enum logic [`STREAMING_OP_CNTL_OPERATION_STREAM_DEST_RANGE ] {
                                                                       PE_STOP_DEST_IS_NA     = `STREAMING_OP_CNTL_OPERATION_TO_NONE       ,
                                                                       PE_STOP_DEST_IS_MEMORY = `STREAMING_OP_CNTL_OPERATION_TO_MEMORY     ,
                                                                       PE_STOP_DEST_IS_STD    = `STREAMING_OP_CNTL_OPERATION_TO_STD        ,
                                                                       PE_STOP_DEST_IS_NOC    = `STREAMING_OP_CNTL_OPERATION_TO_NOC        
                                                                     } PE_STOP_DEST ;




typedef struct packed  {
                         logic [`STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_RANGE ]  numberOfDestStreams ;
                         logic [`STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_RANGE  ]  numberOfSrcStreams  ;
                         PE_STOP_OPCODE                                                   opcode              ;
                         PE_STOP_DEST                                                     stream1_destination ;
                         PE_STOP_DEST                                                     stream0_destination ;
                         PE_STOP_SRC                                                      stream1_source      ;
                         PE_STOP_SRC                                                      stream0_source      ;
                       } pe_stOp_operation ; 





`endif

