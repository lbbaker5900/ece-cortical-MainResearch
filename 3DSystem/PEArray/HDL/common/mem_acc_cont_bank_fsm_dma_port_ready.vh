
          assign read_ready_strm   = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)  ;
          assign write_ready_strm  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS) ;