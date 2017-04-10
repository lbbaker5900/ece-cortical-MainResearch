
  // Search for MW storage tuple in option type fields
  assign storagePtr_LocalFifo[0].write    = from_WuDecode_Fifo[0].pipe_read & ((from_WuDecode_Fifo[0].pipe_option_type[0] == PY_WU_INST_OPT_TYPE_MEMORY) | 
                                                                               (from_WuDecode_Fifo[0].pipe_option_type[1] == PY_WU_INST_OPT_TYPE_MEMORY)); // 
  // Extract storage ptr
  assign storagePtr_LocalFifo[0].write_storage_ptr     = (from_WuDecode_Fifo[0].pipe_option_type[0] == PY_WU_INST_OPT_TYPE_MEMORY) ? {from_WuDecode_Fifo[0].pipe_option_value[0], from_WuDecode_Fifo[0].pipe_option_type[1], from_WuDecode_Fifo[0].pipe_option_value[1]} : 
                                                                                                                                     {from_WuDecode_Fifo[0].pipe_option_value[1], from_WuDecode_Fifo[0].pipe_option_type[2], from_WuDecode_Fifo[0].pipe_option_value[2]} ; // 
  // Extract Number of valid lanes
  always @(posedge clk)
    begin
      num_of_valid_lanes   <= ( reset_poweron                                                                                                                                              ) ? 'd0                                       :
                              ( from_WuDecode_Fifo[0].pipe_option_type[0] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES                                                                              ) ? from_WuDecode_Fifo[0].pipe_option_value[0] : 
                              ((from_WuDecode_Fifo[0].pipe_option_type[1] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES) && (from_WuDecode_Fifo[0].pipe_option_type[0] != PY_WU_INST_OPT_TYPE_MEMORY)) ? from_WuDecode_Fifo[0].pipe_option_value[1] : 
                              ((from_WuDecode_Fifo[0].pipe_option_type[2] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES) && (from_WuDecode_Fifo[0].pipe_option_type[1] != PY_WU_INST_OPT_TYPE_MEMORY)) ? from_WuDecode_Fifo[0].pipe_option_value[2] : 
                                                                                                                                                                                               num_of_valid_lanes ; // 
    end