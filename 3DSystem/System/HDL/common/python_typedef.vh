

typedef enum logic [1 :0] { 
                        NOP =  0, 
                         OP =  1, 
                         MR =  2, 
                         MW =  3 
                           } python_desc_type ; 


typedef enum logic [2 :0] { 
                        NOP =  0, 
                        SRC =  1, 
                        TGT =  2, 
                      TXFER =  3, 
                   NUM_OF_LANES =  4, 
                       stOp =  5, 
                     simdOp =  6, 
                     MEMORY =  7 
                           } python_option_type ; 


typedef enum logic [1 :0] { 
                        NOP =  0, 
                   STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM =  1, 
                   STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM =  2, 
                   STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM =  3 
                           } python_stOp_type ; 


typedef enum logic [0 :0] { 
                        NOP =  0, 
                       ReLu =  1 
                           } python_simd_type ; 


typedef enum logic [1 :0] { 
                   STACK_DN_ARG0 =  0, 
                   STACK_DN_ARG1 =  1, 
                   STACK_UP =  2, 
                        NOP =  3 
                           } python_target_type ; 


typedef enum logic [1 :0] { 
                      BCAST =  0, 
                     VECTOR =  1, 
                        NOP =  2 
                           } python_transfer_type ; 


typedef enum logic [1 :0] { 
                       cwbp =  0, 
                       wcbp =  1, 
                        NOP =  2 
                           } python_order_type ; 

