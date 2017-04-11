
  // Extract storage ptr - wr_ptrs can only exist in first two tuples because they are extended tuples
  assign wud_fifo_contains_wr_ptr =   from_WuDecode_Fifo[0].pipe_valid & 
                                    ((from_WuDecode_Fifo[0].pipe_option_type[0] == PY_WU_INST_OPT_TYPE_MEMORY) | 
                                     (from_WuDecode_Fifo[0].pipe_option_type[1] == PY_WU_INST_OPT_TYPE_MEMORY)); // 
  always @(posedge clk)
    begin
      write_storage_ptr_tmp    <= (from_WuDecode_Fifo[0].pipe_read  && (from_WuDecode_Fifo[0].pipe_option_type[0] == PY_WU_INST_OPT_TYPE_MEMORY)) ? {from_WuDecode_Fifo[0].pipe_option_value[0], from_WuDecode_Fifo[0].pipe_option_type[1], from_WuDecode_Fifo[0].pipe_option_value[1]} : 
                                  (from_WuDecode_Fifo[0].pipe_read  && (from_WuDecode_Fifo[0].pipe_option_type[1] == PY_WU_INST_OPT_TYPE_MEMORY)) ? {from_WuDecode_Fifo[0].pipe_option_value[1], from_WuDecode_Fifo[0].pipe_option_type[2], from_WuDecode_Fifo[0].pipe_option_value[2]} : 
                                                                                                                                                     write_storage_ptr_tmp ; 
    end
  // Extract Number of valid lanes
  always @(posedge clk)
    begin
      num_of_valid_lanes   <= ( reset_poweron                                                                                                                                                                                    ) ? 'd0                                       :
                              (from_WuDecode_Fifo[0].pipe_read  && ( from_WuDecode_Fifo[0].pipe_option_type[0] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES)                                                                              ) ? from_WuDecode_Fifo[0].pipe_option_value[0] : 
                              (from_WuDecode_Fifo[0].pipe_read  && ((from_WuDecode_Fifo[0].pipe_option_type[1] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES) && (from_WuDecode_Fifo[0].pipe_option_type[0] != PY_WU_INST_OPT_TYPE_MEMORY))) ? from_WuDecode_Fifo[0].pipe_option_value[1] : 
                              (from_WuDecode_Fifo[0].pipe_read  && ((from_WuDecode_Fifo[0].pipe_option_type[2] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES) && (from_WuDecode_Fifo[0].pipe_option_type[1] != PY_WU_INST_OPT_TYPE_MEMORY))) ? from_WuDecode_Fifo[0].pipe_option_value[2] : 
                                                                                                                                                                                                                                     num_of_valid_lanes ; // 
    end