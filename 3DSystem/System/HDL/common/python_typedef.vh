

typedef enum logic [1 :0] { 
                   PY_WU_INST_DESC_TYPE_NOP      =  0, 
                   PY_WU_INST_DESC_TYPE_OP       =  1, 
                   PY_WU_INST_DESC_TYPE_MR       =  2, 
                   PY_WU_INST_DESC_TYPE_MW       =  3 
                           } python_desc_type ; 


typedef enum logic [2 :0] { 
                   PY_WU_INST_OPT_TYPE_NOP      =  0, 
                   PY_WU_INST_OPT_TYPE_SRC      =  1, 
                   PY_WU_INST_OPT_TYPE_TGT      =  2, 
                   PY_WU_INST_OPT_TYPE_TXFER    =  3, 
                   PY_WU_INST_OPT_TYPE_NUM_OF_LANES =  4, 
                   PY_WU_INST_OPT_TYPE_STOP     =  5, 
                   PY_WU_INST_OPT_TYPE_SIMDOP   =  6, 
                   PY_WU_INST_OPT_TYPE_MEMORY   =  7 
                           } python_option_type ; 


typedef enum logic [1 :0] { 
                   PY_WU_INST_STOP_CMD_NOP      =  0, 
                   PY_WU_INST_STOP_CMD_STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM =  1, 
                   PY_WU_INST_STOP_CMD_STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM =  2, 
                   PY_WU_INST_STOP_CMD_STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM =  3 
                           } python_stOp_type ; 


typedef enum logic [0 :0] { 
                   PY_WU_INST_SIMD_CMD_NOP      =  0, 
                   PY_WU_INST_SIMD_CMD_RELU     =  1 
                           } python_simd_type ; 


typedef enum logic [1 :0] { 
                   PY_WU_INST_TGT_TYPE_STACK_DN_ARG0 =  0, 
                   PY_WU_INST_TGT_TYPE_STACK_DN_ARG1 =  1, 
                   PY_WU_INST_TGT_TYPE_STACK_UP =  2, 
                   PY_WU_INST_TGT_TYPE_NOP      =  3 
                           } python_target_type ; 


typedef enum logic [1 :0] { 
                   PY_WU_INST_TXFER_TYPE_BCAST    =  0, 
                   PY_WU_INST_TXFER_TYPE_VECTOR   =  1, 
                   PY_WU_INST_TXFER_TYPE_NOP      =  2 
                           } python_transfer_type ; 


typedef enum logic [1 :0] { 
                   PY_WU_INST_ORDER_TYPE_CWBP     =  0, 
                   PY_WU_INST_ORDER_TYPE_WCBP     =  1, 
                   PY_WU_INST_ORDER_TYPE_NOP      =  2 
                           } python_order_type ; 

