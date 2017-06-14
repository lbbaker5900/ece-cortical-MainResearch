
           `MEM_ACC_CONT_DMA:
             mem_acc_state_next = ( ~cntl_granted                  )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request                )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  : 
                                  (  read_request  && ~read_pause )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   : 
                                  (  write_request0               )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  read_request0 && ~read_pause )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                                                       `MEM_ACC_CONT_DMA                     ; 
           `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted                  )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request                 )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  :
                                  (  write_request0                )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS :
                                  (  read_request  && ~read_pause  )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   :
                                  (  read_request0 && ~read_pause0 )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  :
                                                                        `MEM_ACC_CONT_DMA                    ;
 
           `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted                  )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request                 )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  :
                                  (  write_request0                )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS :
                                  (  read_request  && ~read_pause  )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   :
                                  (  read_request0 && ~read_pause0 )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  :
                                                                        `MEM_ACC_CONT_DMA                    ;
 
           `MEM_ACC_CONT_DMA_STRM_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted                  )  ? `MEM_ACC_CONT_WAIT                  :
                                  (  write_request                 )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS :
                                  (  read_request && ~read_pause   )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS  :
                                                                        `MEM_ACC_CONT_DMA                   ;
 
           `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted                  )  ? `MEM_ACC_CONT_WAIT                  :
                                  (  write_request                 )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS :
                                  (  read_request && ~read_pause   )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS  :
                                                                        `MEM_ACC_CONT_DMA                   ;
 