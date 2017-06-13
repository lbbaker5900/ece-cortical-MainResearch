
       assign read_data_ldst_valid_next   = ( mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS    );
       assign read_data_strm_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS    );
       // outputs 
       always @(posedge clk)
         begin
           read_data_ldst_valid   <= ( reset_poweron ) ? 'b0  : read_data_ldst_valid_next   ;
           read_data_strm_valid  <= ( reset_poweron ) ? 'b0  : read_data_strm_valid_next  ;
         end