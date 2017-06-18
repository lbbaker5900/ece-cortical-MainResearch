
  // pe__sys__thisSyncnronized basically means all the streams in the PE are complete
  // The PE controller will move to a 'final' state once it receives sys__pe__allSynchronized
  assign pe__sys__thisSynchronized = ((strm_control[0].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[0].lane_enable) & 
                                     ((strm_control[1].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[1].lane_enable) &  
                                     ((strm_control[2].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[2].lane_enable) &  
                                     ((strm_control[3].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[3].lane_enable) &  
                                     ((strm_control[4].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[4].lane_enable) &  
                                     ((strm_control[5].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[5].lane_enable) &  
                                     ((strm_control[6].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[6].lane_enable) &  
                                     ((strm_control[7].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[7].lane_enable) &  
                                     ((strm_control[8].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[8].lane_enable) &  
                                     ((strm_control[9].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[9].lane_enable) &  
                                     ((strm_control[10].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[10].lane_enable) &  
                                     ((strm_control[11].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[11].lane_enable) &  
                                     ((strm_control[12].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[12].lane_enable) &  
                                     ((strm_control[13].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[13].lane_enable) &  
                                     ((strm_control[14].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[14].lane_enable) &  
                                     ((strm_control[15].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[15].lane_enable) &  
                                     ((strm_control[16].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[16].lane_enable) &  
                                     ((strm_control[17].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[17].lane_enable) &  
                                     ((strm_control[18].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[18].lane_enable) &  
                                     ((strm_control[19].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[19].lane_enable) &  
                                     ((strm_control[20].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[20].lane_enable) &  
                                     ((strm_control[21].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[21].lane_enable) &  
                                     ((strm_control[22].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[22].lane_enable) &  
                                     ((strm_control[23].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[23].lane_enable) &  
                                     ((strm_control[24].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[24].lane_enable) &  
                                     ((strm_control[25].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[25].lane_enable) &  
                                     ((strm_control[26].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[26].lane_enable) &  
                                     ((strm_control[27].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[27].lane_enable) &  
                                     ((strm_control[28].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[28].lane_enable) &  
                                     ((strm_control[29].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[29].lane_enable) &  
                                     ((strm_control[30].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[30].lane_enable) &  
                                     ((strm_control[31].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[31].lane_enable) ; 

  assign scntl__sdp__lane0_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane0_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane0_strm0_stOp_enable    = strm_control[0].strm0_stOp_enable     ; 
  assign strm_control[0].strm0_stOp_ready      = sdp__scntl__lane0_strm0_stOp_ready     ; 
  assign strm_control[0].strm0_stOp_complete   = sdp__scntl__lane0_strm0_stOp_complete  ; 
  assign scntl__sdp__lane0_strm1_stOp_enable    = strm_control[0].strm1_stOp_enable     ; 
  assign strm_control[0].strm1_stOp_ready      = sdp__scntl__lane0_strm1_stOp_ready     ; 
  assign strm_control[0].strm1_stOp_complete   = sdp__scntl__lane0_strm1_stOp_complete  ; 
  assign scntl__sdp__lane1_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane1_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane1_strm0_stOp_enable    = strm_control[1].strm0_stOp_enable     ; 
  assign strm_control[1].strm0_stOp_ready      = sdp__scntl__lane1_strm0_stOp_ready     ; 
  assign strm_control[1].strm0_stOp_complete   = sdp__scntl__lane1_strm0_stOp_complete  ; 
  assign scntl__sdp__lane1_strm1_stOp_enable    = strm_control[1].strm1_stOp_enable     ; 
  assign strm_control[1].strm1_stOp_ready      = sdp__scntl__lane1_strm1_stOp_ready     ; 
  assign strm_control[1].strm1_stOp_complete   = sdp__scntl__lane1_strm1_stOp_complete  ; 
  assign scntl__sdp__lane2_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane2_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane2_strm0_stOp_enable    = strm_control[2].strm0_stOp_enable     ; 
  assign strm_control[2].strm0_stOp_ready      = sdp__scntl__lane2_strm0_stOp_ready     ; 
  assign strm_control[2].strm0_stOp_complete   = sdp__scntl__lane2_strm0_stOp_complete  ; 
  assign scntl__sdp__lane2_strm1_stOp_enable    = strm_control[2].strm1_stOp_enable     ; 
  assign strm_control[2].strm1_stOp_ready      = sdp__scntl__lane2_strm1_stOp_ready     ; 
  assign strm_control[2].strm1_stOp_complete   = sdp__scntl__lane2_strm1_stOp_complete  ; 
  assign scntl__sdp__lane3_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane3_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane3_strm0_stOp_enable    = strm_control[3].strm0_stOp_enable     ; 
  assign strm_control[3].strm0_stOp_ready      = sdp__scntl__lane3_strm0_stOp_ready     ; 
  assign strm_control[3].strm0_stOp_complete   = sdp__scntl__lane3_strm0_stOp_complete  ; 
  assign scntl__sdp__lane3_strm1_stOp_enable    = strm_control[3].strm1_stOp_enable     ; 
  assign strm_control[3].strm1_stOp_ready      = sdp__scntl__lane3_strm1_stOp_ready     ; 
  assign strm_control[3].strm1_stOp_complete   = sdp__scntl__lane3_strm1_stOp_complete  ; 
  assign scntl__sdp__lane4_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane4_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane4_strm0_stOp_enable    = strm_control[4].strm0_stOp_enable     ; 
  assign strm_control[4].strm0_stOp_ready      = sdp__scntl__lane4_strm0_stOp_ready     ; 
  assign strm_control[4].strm0_stOp_complete   = sdp__scntl__lane4_strm0_stOp_complete  ; 
  assign scntl__sdp__lane4_strm1_stOp_enable    = strm_control[4].strm1_stOp_enable     ; 
  assign strm_control[4].strm1_stOp_ready      = sdp__scntl__lane4_strm1_stOp_ready     ; 
  assign strm_control[4].strm1_stOp_complete   = sdp__scntl__lane4_strm1_stOp_complete  ; 
  assign scntl__sdp__lane5_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane5_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane5_strm0_stOp_enable    = strm_control[5].strm0_stOp_enable     ; 
  assign strm_control[5].strm0_stOp_ready      = sdp__scntl__lane5_strm0_stOp_ready     ; 
  assign strm_control[5].strm0_stOp_complete   = sdp__scntl__lane5_strm0_stOp_complete  ; 
  assign scntl__sdp__lane5_strm1_stOp_enable    = strm_control[5].strm1_stOp_enable     ; 
  assign strm_control[5].strm1_stOp_ready      = sdp__scntl__lane5_strm1_stOp_ready     ; 
  assign strm_control[5].strm1_stOp_complete   = sdp__scntl__lane5_strm1_stOp_complete  ; 
  assign scntl__sdp__lane6_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane6_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane6_strm0_stOp_enable    = strm_control[6].strm0_stOp_enable     ; 
  assign strm_control[6].strm0_stOp_ready      = sdp__scntl__lane6_strm0_stOp_ready     ; 
  assign strm_control[6].strm0_stOp_complete   = sdp__scntl__lane6_strm0_stOp_complete  ; 
  assign scntl__sdp__lane6_strm1_stOp_enable    = strm_control[6].strm1_stOp_enable     ; 
  assign strm_control[6].strm1_stOp_ready      = sdp__scntl__lane6_strm1_stOp_ready     ; 
  assign strm_control[6].strm1_stOp_complete   = sdp__scntl__lane6_strm1_stOp_complete  ; 
  assign scntl__sdp__lane7_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane7_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane7_strm0_stOp_enable    = strm_control[7].strm0_stOp_enable     ; 
  assign strm_control[7].strm0_stOp_ready      = sdp__scntl__lane7_strm0_stOp_ready     ; 
  assign strm_control[7].strm0_stOp_complete   = sdp__scntl__lane7_strm0_stOp_complete  ; 
  assign scntl__sdp__lane7_strm1_stOp_enable    = strm_control[7].strm1_stOp_enable     ; 
  assign strm_control[7].strm1_stOp_ready      = sdp__scntl__lane7_strm1_stOp_ready     ; 
  assign strm_control[7].strm1_stOp_complete   = sdp__scntl__lane7_strm1_stOp_complete  ; 
  assign scntl__sdp__lane8_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane8_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane8_strm0_stOp_enable    = strm_control[8].strm0_stOp_enable     ; 
  assign strm_control[8].strm0_stOp_ready      = sdp__scntl__lane8_strm0_stOp_ready     ; 
  assign strm_control[8].strm0_stOp_complete   = sdp__scntl__lane8_strm0_stOp_complete  ; 
  assign scntl__sdp__lane8_strm1_stOp_enable    = strm_control[8].strm1_stOp_enable     ; 
  assign strm_control[8].strm1_stOp_ready      = sdp__scntl__lane8_strm1_stOp_ready     ; 
  assign strm_control[8].strm1_stOp_complete   = sdp__scntl__lane8_strm1_stOp_complete  ; 
  assign scntl__sdp__lane9_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane9_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane9_strm0_stOp_enable    = strm_control[9].strm0_stOp_enable     ; 
  assign strm_control[9].strm0_stOp_ready      = sdp__scntl__lane9_strm0_stOp_ready     ; 
  assign strm_control[9].strm0_stOp_complete   = sdp__scntl__lane9_strm0_stOp_complete  ; 
  assign scntl__sdp__lane9_strm1_stOp_enable    = strm_control[9].strm1_stOp_enable     ; 
  assign strm_control[9].strm1_stOp_ready      = sdp__scntl__lane9_strm1_stOp_ready     ; 
  assign strm_control[9].strm1_stOp_complete   = sdp__scntl__lane9_strm1_stOp_complete  ; 
  assign scntl__sdp__lane10_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane10_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane10_strm0_stOp_enable    = strm_control[10].strm0_stOp_enable     ; 
  assign strm_control[10].strm0_stOp_ready      = sdp__scntl__lane10_strm0_stOp_ready     ; 
  assign strm_control[10].strm0_stOp_complete   = sdp__scntl__lane10_strm0_stOp_complete  ; 
  assign scntl__sdp__lane10_strm1_stOp_enable    = strm_control[10].strm1_stOp_enable     ; 
  assign strm_control[10].strm1_stOp_ready      = sdp__scntl__lane10_strm1_stOp_ready     ; 
  assign strm_control[10].strm1_stOp_complete   = sdp__scntl__lane10_strm1_stOp_complete  ; 
  assign scntl__sdp__lane11_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane11_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane11_strm0_stOp_enable    = strm_control[11].strm0_stOp_enable     ; 
  assign strm_control[11].strm0_stOp_ready      = sdp__scntl__lane11_strm0_stOp_ready     ; 
  assign strm_control[11].strm0_stOp_complete   = sdp__scntl__lane11_strm0_stOp_complete  ; 
  assign scntl__sdp__lane11_strm1_stOp_enable    = strm_control[11].strm1_stOp_enable     ; 
  assign strm_control[11].strm1_stOp_ready      = sdp__scntl__lane11_strm1_stOp_ready     ; 
  assign strm_control[11].strm1_stOp_complete   = sdp__scntl__lane11_strm1_stOp_complete  ; 
  assign scntl__sdp__lane12_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane12_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane12_strm0_stOp_enable    = strm_control[12].strm0_stOp_enable     ; 
  assign strm_control[12].strm0_stOp_ready      = sdp__scntl__lane12_strm0_stOp_ready     ; 
  assign strm_control[12].strm0_stOp_complete   = sdp__scntl__lane12_strm0_stOp_complete  ; 
  assign scntl__sdp__lane12_strm1_stOp_enable    = strm_control[12].strm1_stOp_enable     ; 
  assign strm_control[12].strm1_stOp_ready      = sdp__scntl__lane12_strm1_stOp_ready     ; 
  assign strm_control[12].strm1_stOp_complete   = sdp__scntl__lane12_strm1_stOp_complete  ; 
  assign scntl__sdp__lane13_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane13_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane13_strm0_stOp_enable    = strm_control[13].strm0_stOp_enable     ; 
  assign strm_control[13].strm0_stOp_ready      = sdp__scntl__lane13_strm0_stOp_ready     ; 
  assign strm_control[13].strm0_stOp_complete   = sdp__scntl__lane13_strm0_stOp_complete  ; 
  assign scntl__sdp__lane13_strm1_stOp_enable    = strm_control[13].strm1_stOp_enable     ; 
  assign strm_control[13].strm1_stOp_ready      = sdp__scntl__lane13_strm1_stOp_ready     ; 
  assign strm_control[13].strm1_stOp_complete   = sdp__scntl__lane13_strm1_stOp_complete  ; 
  assign scntl__sdp__lane14_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane14_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane14_strm0_stOp_enable    = strm_control[14].strm0_stOp_enable     ; 
  assign strm_control[14].strm0_stOp_ready      = sdp__scntl__lane14_strm0_stOp_ready     ; 
  assign strm_control[14].strm0_stOp_complete   = sdp__scntl__lane14_strm0_stOp_complete  ; 
  assign scntl__sdp__lane14_strm1_stOp_enable    = strm_control[14].strm1_stOp_enable     ; 
  assign strm_control[14].strm1_stOp_ready      = sdp__scntl__lane14_strm1_stOp_ready     ; 
  assign strm_control[14].strm1_stOp_complete   = sdp__scntl__lane14_strm1_stOp_complete  ; 
  assign scntl__sdp__lane15_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane15_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane15_strm0_stOp_enable    = strm_control[15].strm0_stOp_enable     ; 
  assign strm_control[15].strm0_stOp_ready      = sdp__scntl__lane15_strm0_stOp_ready     ; 
  assign strm_control[15].strm0_stOp_complete   = sdp__scntl__lane15_strm0_stOp_complete  ; 
  assign scntl__sdp__lane15_strm1_stOp_enable    = strm_control[15].strm1_stOp_enable     ; 
  assign strm_control[15].strm1_stOp_ready      = sdp__scntl__lane15_strm1_stOp_ready     ; 
  assign strm_control[15].strm1_stOp_complete   = sdp__scntl__lane15_strm1_stOp_complete  ; 
  assign scntl__sdp__lane16_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane16_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane16_strm0_stOp_enable    = strm_control[16].strm0_stOp_enable     ; 
  assign strm_control[16].strm0_stOp_ready      = sdp__scntl__lane16_strm0_stOp_ready     ; 
  assign strm_control[16].strm0_stOp_complete   = sdp__scntl__lane16_strm0_stOp_complete  ; 
  assign scntl__sdp__lane16_strm1_stOp_enable    = strm_control[16].strm1_stOp_enable     ; 
  assign strm_control[16].strm1_stOp_ready      = sdp__scntl__lane16_strm1_stOp_ready     ; 
  assign strm_control[16].strm1_stOp_complete   = sdp__scntl__lane16_strm1_stOp_complete  ; 
  assign scntl__sdp__lane17_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane17_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane17_strm0_stOp_enable    = strm_control[17].strm0_stOp_enable     ; 
  assign strm_control[17].strm0_stOp_ready      = sdp__scntl__lane17_strm0_stOp_ready     ; 
  assign strm_control[17].strm0_stOp_complete   = sdp__scntl__lane17_strm0_stOp_complete  ; 
  assign scntl__sdp__lane17_strm1_stOp_enable    = strm_control[17].strm1_stOp_enable     ; 
  assign strm_control[17].strm1_stOp_ready      = sdp__scntl__lane17_strm1_stOp_ready     ; 
  assign strm_control[17].strm1_stOp_complete   = sdp__scntl__lane17_strm1_stOp_complete  ; 
  assign scntl__sdp__lane18_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane18_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane18_strm0_stOp_enable    = strm_control[18].strm0_stOp_enable     ; 
  assign strm_control[18].strm0_stOp_ready      = sdp__scntl__lane18_strm0_stOp_ready     ; 
  assign strm_control[18].strm0_stOp_complete   = sdp__scntl__lane18_strm0_stOp_complete  ; 
  assign scntl__sdp__lane18_strm1_stOp_enable    = strm_control[18].strm1_stOp_enable     ; 
  assign strm_control[18].strm1_stOp_ready      = sdp__scntl__lane18_strm1_stOp_ready     ; 
  assign strm_control[18].strm1_stOp_complete   = sdp__scntl__lane18_strm1_stOp_complete  ; 
  assign scntl__sdp__lane19_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane19_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane19_strm0_stOp_enable    = strm_control[19].strm0_stOp_enable     ; 
  assign strm_control[19].strm0_stOp_ready      = sdp__scntl__lane19_strm0_stOp_ready     ; 
  assign strm_control[19].strm0_stOp_complete   = sdp__scntl__lane19_strm0_stOp_complete  ; 
  assign scntl__sdp__lane19_strm1_stOp_enable    = strm_control[19].strm1_stOp_enable     ; 
  assign strm_control[19].strm1_stOp_ready      = sdp__scntl__lane19_strm1_stOp_ready     ; 
  assign strm_control[19].strm1_stOp_complete   = sdp__scntl__lane19_strm1_stOp_complete  ; 
  assign scntl__sdp__lane20_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane20_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane20_strm0_stOp_enable    = strm_control[20].strm0_stOp_enable     ; 
  assign strm_control[20].strm0_stOp_ready      = sdp__scntl__lane20_strm0_stOp_ready     ; 
  assign strm_control[20].strm0_stOp_complete   = sdp__scntl__lane20_strm0_stOp_complete  ; 
  assign scntl__sdp__lane20_strm1_stOp_enable    = strm_control[20].strm1_stOp_enable     ; 
  assign strm_control[20].strm1_stOp_ready      = sdp__scntl__lane20_strm1_stOp_ready     ; 
  assign strm_control[20].strm1_stOp_complete   = sdp__scntl__lane20_strm1_stOp_complete  ; 
  assign scntl__sdp__lane21_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane21_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane21_strm0_stOp_enable    = strm_control[21].strm0_stOp_enable     ; 
  assign strm_control[21].strm0_stOp_ready      = sdp__scntl__lane21_strm0_stOp_ready     ; 
  assign strm_control[21].strm0_stOp_complete   = sdp__scntl__lane21_strm0_stOp_complete  ; 
  assign scntl__sdp__lane21_strm1_stOp_enable    = strm_control[21].strm1_stOp_enable     ; 
  assign strm_control[21].strm1_stOp_ready      = sdp__scntl__lane21_strm1_stOp_ready     ; 
  assign strm_control[21].strm1_stOp_complete   = sdp__scntl__lane21_strm1_stOp_complete  ; 
  assign scntl__sdp__lane22_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane22_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane22_strm0_stOp_enable    = strm_control[22].strm0_stOp_enable     ; 
  assign strm_control[22].strm0_stOp_ready      = sdp__scntl__lane22_strm0_stOp_ready     ; 
  assign strm_control[22].strm0_stOp_complete   = sdp__scntl__lane22_strm0_stOp_complete  ; 
  assign scntl__sdp__lane22_strm1_stOp_enable    = strm_control[22].strm1_stOp_enable     ; 
  assign strm_control[22].strm1_stOp_ready      = sdp__scntl__lane22_strm1_stOp_ready     ; 
  assign strm_control[22].strm1_stOp_complete   = sdp__scntl__lane22_strm1_stOp_complete  ; 
  assign scntl__sdp__lane23_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane23_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane23_strm0_stOp_enable    = strm_control[23].strm0_stOp_enable     ; 
  assign strm_control[23].strm0_stOp_ready      = sdp__scntl__lane23_strm0_stOp_ready     ; 
  assign strm_control[23].strm0_stOp_complete   = sdp__scntl__lane23_strm0_stOp_complete  ; 
  assign scntl__sdp__lane23_strm1_stOp_enable    = strm_control[23].strm1_stOp_enable     ; 
  assign strm_control[23].strm1_stOp_ready      = sdp__scntl__lane23_strm1_stOp_ready     ; 
  assign strm_control[23].strm1_stOp_complete   = sdp__scntl__lane23_strm1_stOp_complete  ; 
  assign scntl__sdp__lane24_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane24_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane24_strm0_stOp_enable    = strm_control[24].strm0_stOp_enable     ; 
  assign strm_control[24].strm0_stOp_ready      = sdp__scntl__lane24_strm0_stOp_ready     ; 
  assign strm_control[24].strm0_stOp_complete   = sdp__scntl__lane24_strm0_stOp_complete  ; 
  assign scntl__sdp__lane24_strm1_stOp_enable    = strm_control[24].strm1_stOp_enable     ; 
  assign strm_control[24].strm1_stOp_ready      = sdp__scntl__lane24_strm1_stOp_ready     ; 
  assign strm_control[24].strm1_stOp_complete   = sdp__scntl__lane24_strm1_stOp_complete  ; 
  assign scntl__sdp__lane25_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane25_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane25_strm0_stOp_enable    = strm_control[25].strm0_stOp_enable     ; 
  assign strm_control[25].strm0_stOp_ready      = sdp__scntl__lane25_strm0_stOp_ready     ; 
  assign strm_control[25].strm0_stOp_complete   = sdp__scntl__lane25_strm0_stOp_complete  ; 
  assign scntl__sdp__lane25_strm1_stOp_enable    = strm_control[25].strm1_stOp_enable     ; 
  assign strm_control[25].strm1_stOp_ready      = sdp__scntl__lane25_strm1_stOp_ready     ; 
  assign strm_control[25].strm1_stOp_complete   = sdp__scntl__lane25_strm1_stOp_complete  ; 
  assign scntl__sdp__lane26_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane26_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane26_strm0_stOp_enable    = strm_control[26].strm0_stOp_enable     ; 
  assign strm_control[26].strm0_stOp_ready      = sdp__scntl__lane26_strm0_stOp_ready     ; 
  assign strm_control[26].strm0_stOp_complete   = sdp__scntl__lane26_strm0_stOp_complete  ; 
  assign scntl__sdp__lane26_strm1_stOp_enable    = strm_control[26].strm1_stOp_enable     ; 
  assign strm_control[26].strm1_stOp_ready      = sdp__scntl__lane26_strm1_stOp_ready     ; 
  assign strm_control[26].strm1_stOp_complete   = sdp__scntl__lane26_strm1_stOp_complete  ; 
  assign scntl__sdp__lane27_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane27_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane27_strm0_stOp_enable    = strm_control[27].strm0_stOp_enable     ; 
  assign strm_control[27].strm0_stOp_ready      = sdp__scntl__lane27_strm0_stOp_ready     ; 
  assign strm_control[27].strm0_stOp_complete   = sdp__scntl__lane27_strm0_stOp_complete  ; 
  assign scntl__sdp__lane27_strm1_stOp_enable    = strm_control[27].strm1_stOp_enable     ; 
  assign strm_control[27].strm1_stOp_ready      = sdp__scntl__lane27_strm1_stOp_ready     ; 
  assign strm_control[27].strm1_stOp_complete   = sdp__scntl__lane27_strm1_stOp_complete  ; 
  assign scntl__sdp__lane28_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane28_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane28_strm0_stOp_enable    = strm_control[28].strm0_stOp_enable     ; 
  assign strm_control[28].strm0_stOp_ready      = sdp__scntl__lane28_strm0_stOp_ready     ; 
  assign strm_control[28].strm0_stOp_complete   = sdp__scntl__lane28_strm0_stOp_complete  ; 
  assign scntl__sdp__lane28_strm1_stOp_enable    = strm_control[28].strm1_stOp_enable     ; 
  assign strm_control[28].strm1_stOp_ready      = sdp__scntl__lane28_strm1_stOp_ready     ; 
  assign strm_control[28].strm1_stOp_complete   = sdp__scntl__lane28_strm1_stOp_complete  ; 
  assign scntl__sdp__lane29_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane29_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane29_strm0_stOp_enable    = strm_control[29].strm0_stOp_enable     ; 
  assign strm_control[29].strm0_stOp_ready      = sdp__scntl__lane29_strm0_stOp_ready     ; 
  assign strm_control[29].strm0_stOp_complete   = sdp__scntl__lane29_strm0_stOp_complete  ; 
  assign scntl__sdp__lane29_strm1_stOp_enable    = strm_control[29].strm1_stOp_enable     ; 
  assign strm_control[29].strm1_stOp_ready      = sdp__scntl__lane29_strm1_stOp_ready     ; 
  assign strm_control[29].strm1_stOp_complete   = sdp__scntl__lane29_strm1_stOp_complete  ; 
  assign scntl__sdp__lane30_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane30_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane30_strm0_stOp_enable    = strm_control[30].strm0_stOp_enable     ; 
  assign strm_control[30].strm0_stOp_ready      = sdp__scntl__lane30_strm0_stOp_ready     ; 
  assign strm_control[30].strm0_stOp_complete   = sdp__scntl__lane30_strm0_stOp_complete  ; 
  assign scntl__sdp__lane30_strm1_stOp_enable    = strm_control[30].strm1_stOp_enable     ; 
  assign strm_control[30].strm1_stOp_ready      = sdp__scntl__lane30_strm1_stOp_ready     ; 
  assign strm_control[30].strm1_stOp_complete   = sdp__scntl__lane30_strm1_stOp_complete  ; 
  assign scntl__sdp__lane31_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane31_dma_operation  = rs0[31:1]                                      ; 
  assign scntl__sdp__lane31_strm0_stOp_enable    = strm_control[31].strm0_stOp_enable     ; 
  assign strm_control[31].strm0_stOp_ready      = sdp__scntl__lane31_strm0_stOp_ready     ; 
  assign strm_control[31].strm0_stOp_complete   = sdp__scntl__lane31_strm0_stOp_complete  ; 
  assign scntl__sdp__lane31_strm1_stOp_enable    = strm_control[31].strm1_stOp_enable     ; 
  assign strm_control[31].strm1_stOp_ready      = sdp__scntl__lane31_strm1_stOp_ready     ; 
  assign strm_control[31].strm1_stOp_complete   = sdp__scntl__lane31_strm1_stOp_complete  ; 

  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane0_strm0_read_enable         = strm_control[0].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane0_strm0_write_enable        = strm_control[0].strm0_write_enable        ;  // FIXME
  assign strm_control[0].strm0_read_ready           = sdp__scntl__lane0_strm0_read_ready         ;  // FIXME
  assign strm_control[0].strm0_write_ready          = sdp__scntl__lane0_strm0_write_ready        ;  // FIXME
  assign strm_control[0].strm0_read_complete        = sdp__scntl__lane0_strm0_read_complete      ;  // FIXME
  assign strm_control[0].strm0_write_complete       = sdp__scntl__lane0_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane0_strm1_read_enable         = strm_control[0].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane0_strm1_write_enable        = strm_control[0].strm1_write_enable        ;  // FIXME
  assign strm_control[0].strm1_read_ready           = sdp__scntl__lane0_strm1_read_ready         ;  // FIXME
  assign strm_control[0].strm1_write_ready          = sdp__scntl__lane0_strm1_write_ready        ;  // FIXME
  assign strm_control[0].strm1_read_complete        = sdp__scntl__lane0_strm1_read_complete      ;  // FIXME
  assign strm_control[0].strm1_write_complete       = sdp__scntl__lane0_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane0_strm0_read_start_address  = lane0_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane0_strm1_read_start_address  = lane0_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane0_strm0_write_start_address = lane0_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane0_strm1_write_start_address = lane0_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane0_type0                     = lane0_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane0_type1                     = lane0_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane0_num_of_types0             = lane0_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane0_num_of_types1             = lane0_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane0_strm0_read_start_address             = lane0_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane0_strm1_read_start_address             = lane0_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane0_strm0_write_start_address            = lane0_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane0_strm1_write_start_address            = lane0_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane0_type0                                = lane0_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane0_type1                                = lane0_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane0_num_of_types0                        = lane0_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane0_num_of_types1                        = lane0_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane0_stagger0                             = lane0_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane0_stagger1                             = lane0_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane1_strm0_read_enable         = strm_control[1].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane1_strm0_write_enable        = strm_control[1].strm0_write_enable        ;  // FIXME
  assign strm_control[1].strm0_read_ready           = sdp__scntl__lane1_strm0_read_ready         ;  // FIXME
  assign strm_control[1].strm0_write_ready          = sdp__scntl__lane1_strm0_write_ready        ;  // FIXME
  assign strm_control[1].strm0_read_complete        = sdp__scntl__lane1_strm0_read_complete      ;  // FIXME
  assign strm_control[1].strm0_write_complete       = sdp__scntl__lane1_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane1_strm1_read_enable         = strm_control[1].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane1_strm1_write_enable        = strm_control[1].strm1_write_enable        ;  // FIXME
  assign strm_control[1].strm1_read_ready           = sdp__scntl__lane1_strm1_read_ready         ;  // FIXME
  assign strm_control[1].strm1_write_ready          = sdp__scntl__lane1_strm1_write_ready        ;  // FIXME
  assign strm_control[1].strm1_read_complete        = sdp__scntl__lane1_strm1_read_complete      ;  // FIXME
  assign strm_control[1].strm1_write_complete       = sdp__scntl__lane1_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane1_strm0_read_start_address  = lane1_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane1_strm1_read_start_address  = lane1_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane1_strm0_write_start_address = lane1_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane1_strm1_write_start_address = lane1_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane1_type0                     = lane1_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane1_type1                     = lane1_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane1_num_of_types0             = lane1_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane1_num_of_types1             = lane1_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane1_strm0_read_start_address             = lane1_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane1_strm1_read_start_address             = lane1_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane1_strm0_write_start_address            = lane1_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane1_strm1_write_start_address            = lane1_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane1_type0                                = lane1_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane1_type1                                = lane1_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane1_num_of_types0                        = lane1_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane1_num_of_types1                        = lane1_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane1_stagger0                             = lane1_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane1_stagger1                             = lane1_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane2_strm0_read_enable         = strm_control[2].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane2_strm0_write_enable        = strm_control[2].strm0_write_enable        ;  // FIXME
  assign strm_control[2].strm0_read_ready           = sdp__scntl__lane2_strm0_read_ready         ;  // FIXME
  assign strm_control[2].strm0_write_ready          = sdp__scntl__lane2_strm0_write_ready        ;  // FIXME
  assign strm_control[2].strm0_read_complete        = sdp__scntl__lane2_strm0_read_complete      ;  // FIXME
  assign strm_control[2].strm0_write_complete       = sdp__scntl__lane2_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane2_strm1_read_enable         = strm_control[2].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane2_strm1_write_enable        = strm_control[2].strm1_write_enable        ;  // FIXME
  assign strm_control[2].strm1_read_ready           = sdp__scntl__lane2_strm1_read_ready         ;  // FIXME
  assign strm_control[2].strm1_write_ready          = sdp__scntl__lane2_strm1_write_ready        ;  // FIXME
  assign strm_control[2].strm1_read_complete        = sdp__scntl__lane2_strm1_read_complete      ;  // FIXME
  assign strm_control[2].strm1_write_complete       = sdp__scntl__lane2_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane2_strm0_read_start_address  = lane2_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane2_strm1_read_start_address  = lane2_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane2_strm0_write_start_address = lane2_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane2_strm1_write_start_address = lane2_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane2_type0                     = lane2_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane2_type1                     = lane2_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane2_num_of_types0             = lane2_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane2_num_of_types1             = lane2_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane2_strm0_read_start_address             = lane2_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane2_strm1_read_start_address             = lane2_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane2_strm0_write_start_address            = lane2_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane2_strm1_write_start_address            = lane2_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane2_type0                                = lane2_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane2_type1                                = lane2_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane2_num_of_types0                        = lane2_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane2_num_of_types1                        = lane2_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane2_stagger0                             = lane2_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane2_stagger1                             = lane2_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane3_strm0_read_enable         = strm_control[3].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane3_strm0_write_enable        = strm_control[3].strm0_write_enable        ;  // FIXME
  assign strm_control[3].strm0_read_ready           = sdp__scntl__lane3_strm0_read_ready         ;  // FIXME
  assign strm_control[3].strm0_write_ready          = sdp__scntl__lane3_strm0_write_ready        ;  // FIXME
  assign strm_control[3].strm0_read_complete        = sdp__scntl__lane3_strm0_read_complete      ;  // FIXME
  assign strm_control[3].strm0_write_complete       = sdp__scntl__lane3_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane3_strm1_read_enable         = strm_control[3].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane3_strm1_write_enable        = strm_control[3].strm1_write_enable        ;  // FIXME
  assign strm_control[3].strm1_read_ready           = sdp__scntl__lane3_strm1_read_ready         ;  // FIXME
  assign strm_control[3].strm1_write_ready          = sdp__scntl__lane3_strm1_write_ready        ;  // FIXME
  assign strm_control[3].strm1_read_complete        = sdp__scntl__lane3_strm1_read_complete      ;  // FIXME
  assign strm_control[3].strm1_write_complete       = sdp__scntl__lane3_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane3_strm0_read_start_address  = lane3_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane3_strm1_read_start_address  = lane3_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane3_strm0_write_start_address = lane3_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane3_strm1_write_start_address = lane3_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane3_type0                     = lane3_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane3_type1                     = lane3_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane3_num_of_types0             = lane3_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane3_num_of_types1             = lane3_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane3_strm0_read_start_address             = lane3_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane3_strm1_read_start_address             = lane3_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane3_strm0_write_start_address            = lane3_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane3_strm1_write_start_address            = lane3_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane3_type0                                = lane3_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane3_type1                                = lane3_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane3_num_of_types0                        = lane3_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane3_num_of_types1                        = lane3_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane3_stagger0                             = lane3_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane3_stagger1                             = lane3_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane4_strm0_read_enable         = strm_control[4].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane4_strm0_write_enable        = strm_control[4].strm0_write_enable        ;  // FIXME
  assign strm_control[4].strm0_read_ready           = sdp__scntl__lane4_strm0_read_ready         ;  // FIXME
  assign strm_control[4].strm0_write_ready          = sdp__scntl__lane4_strm0_write_ready        ;  // FIXME
  assign strm_control[4].strm0_read_complete        = sdp__scntl__lane4_strm0_read_complete      ;  // FIXME
  assign strm_control[4].strm0_write_complete       = sdp__scntl__lane4_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane4_strm1_read_enable         = strm_control[4].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane4_strm1_write_enable        = strm_control[4].strm1_write_enable        ;  // FIXME
  assign strm_control[4].strm1_read_ready           = sdp__scntl__lane4_strm1_read_ready         ;  // FIXME
  assign strm_control[4].strm1_write_ready          = sdp__scntl__lane4_strm1_write_ready        ;  // FIXME
  assign strm_control[4].strm1_read_complete        = sdp__scntl__lane4_strm1_read_complete      ;  // FIXME
  assign strm_control[4].strm1_write_complete       = sdp__scntl__lane4_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane4_strm0_read_start_address  = lane4_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane4_strm1_read_start_address  = lane4_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane4_strm0_write_start_address = lane4_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane4_strm1_write_start_address = lane4_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane4_type0                     = lane4_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane4_type1                     = lane4_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane4_num_of_types0             = lane4_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane4_num_of_types1             = lane4_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane4_strm0_read_start_address             = lane4_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane4_strm1_read_start_address             = lane4_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane4_strm0_write_start_address            = lane4_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane4_strm1_write_start_address            = lane4_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane4_type0                                = lane4_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane4_type1                                = lane4_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane4_num_of_types0                        = lane4_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane4_num_of_types1                        = lane4_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane4_stagger0                             = lane4_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane4_stagger1                             = lane4_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane5_strm0_read_enable         = strm_control[5].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane5_strm0_write_enable        = strm_control[5].strm0_write_enable        ;  // FIXME
  assign strm_control[5].strm0_read_ready           = sdp__scntl__lane5_strm0_read_ready         ;  // FIXME
  assign strm_control[5].strm0_write_ready          = sdp__scntl__lane5_strm0_write_ready        ;  // FIXME
  assign strm_control[5].strm0_read_complete        = sdp__scntl__lane5_strm0_read_complete      ;  // FIXME
  assign strm_control[5].strm0_write_complete       = sdp__scntl__lane5_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane5_strm1_read_enable         = strm_control[5].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane5_strm1_write_enable        = strm_control[5].strm1_write_enable        ;  // FIXME
  assign strm_control[5].strm1_read_ready           = sdp__scntl__lane5_strm1_read_ready         ;  // FIXME
  assign strm_control[5].strm1_write_ready          = sdp__scntl__lane5_strm1_write_ready        ;  // FIXME
  assign strm_control[5].strm1_read_complete        = sdp__scntl__lane5_strm1_read_complete      ;  // FIXME
  assign strm_control[5].strm1_write_complete       = sdp__scntl__lane5_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane5_strm0_read_start_address  = lane5_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane5_strm1_read_start_address  = lane5_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane5_strm0_write_start_address = lane5_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane5_strm1_write_start_address = lane5_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane5_type0                     = lane5_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane5_type1                     = lane5_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane5_num_of_types0             = lane5_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane5_num_of_types1             = lane5_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane5_strm0_read_start_address             = lane5_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane5_strm1_read_start_address             = lane5_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane5_strm0_write_start_address            = lane5_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane5_strm1_write_start_address            = lane5_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane5_type0                                = lane5_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane5_type1                                = lane5_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane5_num_of_types0                        = lane5_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane5_num_of_types1                        = lane5_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane5_stagger0                             = lane5_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane5_stagger1                             = lane5_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane6_strm0_read_enable         = strm_control[6].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane6_strm0_write_enable        = strm_control[6].strm0_write_enable        ;  // FIXME
  assign strm_control[6].strm0_read_ready           = sdp__scntl__lane6_strm0_read_ready         ;  // FIXME
  assign strm_control[6].strm0_write_ready          = sdp__scntl__lane6_strm0_write_ready        ;  // FIXME
  assign strm_control[6].strm0_read_complete        = sdp__scntl__lane6_strm0_read_complete      ;  // FIXME
  assign strm_control[6].strm0_write_complete       = sdp__scntl__lane6_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane6_strm1_read_enable         = strm_control[6].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane6_strm1_write_enable        = strm_control[6].strm1_write_enable        ;  // FIXME
  assign strm_control[6].strm1_read_ready           = sdp__scntl__lane6_strm1_read_ready         ;  // FIXME
  assign strm_control[6].strm1_write_ready          = sdp__scntl__lane6_strm1_write_ready        ;  // FIXME
  assign strm_control[6].strm1_read_complete        = sdp__scntl__lane6_strm1_read_complete      ;  // FIXME
  assign strm_control[6].strm1_write_complete       = sdp__scntl__lane6_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane6_strm0_read_start_address  = lane6_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane6_strm1_read_start_address  = lane6_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane6_strm0_write_start_address = lane6_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane6_strm1_write_start_address = lane6_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane6_type0                     = lane6_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane6_type1                     = lane6_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane6_num_of_types0             = lane6_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane6_num_of_types1             = lane6_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane6_strm0_read_start_address             = lane6_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane6_strm1_read_start_address             = lane6_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane6_strm0_write_start_address            = lane6_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane6_strm1_write_start_address            = lane6_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane6_type0                                = lane6_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane6_type1                                = lane6_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane6_num_of_types0                        = lane6_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane6_num_of_types1                        = lane6_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane6_stagger0                             = lane6_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane6_stagger1                             = lane6_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane7_strm0_read_enable         = strm_control[7].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane7_strm0_write_enable        = strm_control[7].strm0_write_enable        ;  // FIXME
  assign strm_control[7].strm0_read_ready           = sdp__scntl__lane7_strm0_read_ready         ;  // FIXME
  assign strm_control[7].strm0_write_ready          = sdp__scntl__lane7_strm0_write_ready        ;  // FIXME
  assign strm_control[7].strm0_read_complete        = sdp__scntl__lane7_strm0_read_complete      ;  // FIXME
  assign strm_control[7].strm0_write_complete       = sdp__scntl__lane7_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane7_strm1_read_enable         = strm_control[7].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane7_strm1_write_enable        = strm_control[7].strm1_write_enable        ;  // FIXME
  assign strm_control[7].strm1_read_ready           = sdp__scntl__lane7_strm1_read_ready         ;  // FIXME
  assign strm_control[7].strm1_write_ready          = sdp__scntl__lane7_strm1_write_ready        ;  // FIXME
  assign strm_control[7].strm1_read_complete        = sdp__scntl__lane7_strm1_read_complete      ;  // FIXME
  assign strm_control[7].strm1_write_complete       = sdp__scntl__lane7_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane7_strm0_read_start_address  = lane7_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane7_strm1_read_start_address  = lane7_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane7_strm0_write_start_address = lane7_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane7_strm1_write_start_address = lane7_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane7_type0                     = lane7_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane7_type1                     = lane7_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane7_num_of_types0             = lane7_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane7_num_of_types1             = lane7_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane7_strm0_read_start_address             = lane7_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane7_strm1_read_start_address             = lane7_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane7_strm0_write_start_address            = lane7_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane7_strm1_write_start_address            = lane7_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane7_type0                                = lane7_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane7_type1                                = lane7_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane7_num_of_types0                        = lane7_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane7_num_of_types1                        = lane7_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane7_stagger0                             = lane7_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane7_stagger1                             = lane7_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane8_strm0_read_enable         = strm_control[8].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane8_strm0_write_enable        = strm_control[8].strm0_write_enable        ;  // FIXME
  assign strm_control[8].strm0_read_ready           = sdp__scntl__lane8_strm0_read_ready         ;  // FIXME
  assign strm_control[8].strm0_write_ready          = sdp__scntl__lane8_strm0_write_ready        ;  // FIXME
  assign strm_control[8].strm0_read_complete        = sdp__scntl__lane8_strm0_read_complete      ;  // FIXME
  assign strm_control[8].strm0_write_complete       = sdp__scntl__lane8_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane8_strm1_read_enable         = strm_control[8].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane8_strm1_write_enable        = strm_control[8].strm1_write_enable        ;  // FIXME
  assign strm_control[8].strm1_read_ready           = sdp__scntl__lane8_strm1_read_ready         ;  // FIXME
  assign strm_control[8].strm1_write_ready          = sdp__scntl__lane8_strm1_write_ready        ;  // FIXME
  assign strm_control[8].strm1_read_complete        = sdp__scntl__lane8_strm1_read_complete      ;  // FIXME
  assign strm_control[8].strm1_write_complete       = sdp__scntl__lane8_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane8_strm0_read_start_address  = lane8_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane8_strm1_read_start_address  = lane8_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane8_strm0_write_start_address = lane8_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane8_strm1_write_start_address = lane8_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane8_type0                     = lane8_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane8_type1                     = lane8_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane8_num_of_types0             = lane8_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane8_num_of_types1             = lane8_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane8_strm0_read_start_address             = lane8_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane8_strm1_read_start_address             = lane8_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane8_strm0_write_start_address            = lane8_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane8_strm1_write_start_address            = lane8_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane8_type0                                = lane8_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane8_type1                                = lane8_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane8_num_of_types0                        = lane8_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane8_num_of_types1                        = lane8_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane8_stagger0                             = lane8_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane8_stagger1                             = lane8_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane9_strm0_read_enable         = strm_control[9].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane9_strm0_write_enable        = strm_control[9].strm0_write_enable        ;  // FIXME
  assign strm_control[9].strm0_read_ready           = sdp__scntl__lane9_strm0_read_ready         ;  // FIXME
  assign strm_control[9].strm0_write_ready          = sdp__scntl__lane9_strm0_write_ready        ;  // FIXME
  assign strm_control[9].strm0_read_complete        = sdp__scntl__lane9_strm0_read_complete      ;  // FIXME
  assign strm_control[9].strm0_write_complete       = sdp__scntl__lane9_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane9_strm1_read_enable         = strm_control[9].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane9_strm1_write_enable        = strm_control[9].strm1_write_enable        ;  // FIXME
  assign strm_control[9].strm1_read_ready           = sdp__scntl__lane9_strm1_read_ready         ;  // FIXME
  assign strm_control[9].strm1_write_ready          = sdp__scntl__lane9_strm1_write_ready        ;  // FIXME
  assign strm_control[9].strm1_read_complete        = sdp__scntl__lane9_strm1_read_complete      ;  // FIXME
  assign strm_control[9].strm1_write_complete       = sdp__scntl__lane9_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane9_strm0_read_start_address  = lane9_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane9_strm1_read_start_address  = lane9_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane9_strm0_write_start_address = lane9_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane9_strm1_write_start_address = lane9_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane9_type0                     = lane9_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane9_type1                     = lane9_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane9_num_of_types0             = lane9_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane9_num_of_types1             = lane9_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane9_strm0_read_start_address             = lane9_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane9_strm1_read_start_address             = lane9_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane9_strm0_write_start_address            = lane9_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane9_strm1_write_start_address            = lane9_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane9_type0                                = lane9_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane9_type1                                = lane9_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane9_num_of_types0                        = lane9_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane9_num_of_types1                        = lane9_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane9_stagger0                             = lane9_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane9_stagger1                             = lane9_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane10_strm0_read_enable         = strm_control[10].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane10_strm0_write_enable        = strm_control[10].strm0_write_enable        ;  // FIXME
  assign strm_control[10].strm0_read_ready           = sdp__scntl__lane10_strm0_read_ready         ;  // FIXME
  assign strm_control[10].strm0_write_ready          = sdp__scntl__lane10_strm0_write_ready        ;  // FIXME
  assign strm_control[10].strm0_read_complete        = sdp__scntl__lane10_strm0_read_complete      ;  // FIXME
  assign strm_control[10].strm0_write_complete       = sdp__scntl__lane10_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane10_strm1_read_enable         = strm_control[10].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane10_strm1_write_enable        = strm_control[10].strm1_write_enable        ;  // FIXME
  assign strm_control[10].strm1_read_ready           = sdp__scntl__lane10_strm1_read_ready         ;  // FIXME
  assign strm_control[10].strm1_write_ready          = sdp__scntl__lane10_strm1_write_ready        ;  // FIXME
  assign strm_control[10].strm1_read_complete        = sdp__scntl__lane10_strm1_read_complete      ;  // FIXME
  assign strm_control[10].strm1_write_complete       = sdp__scntl__lane10_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane10_strm0_read_start_address  = lane10_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane10_strm1_read_start_address  = lane10_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane10_strm0_write_start_address = lane10_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane10_strm1_write_start_address = lane10_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane10_type0                     = lane10_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane10_type1                     = lane10_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane10_num_of_types0             = lane10_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane10_num_of_types1             = lane10_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane10_strm0_read_start_address             = lane10_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane10_strm1_read_start_address             = lane10_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane10_strm0_write_start_address            = lane10_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane10_strm1_write_start_address            = lane10_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane10_type0                                = lane10_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane10_type1                                = lane10_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane10_num_of_types0                        = lane10_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane10_num_of_types1                        = lane10_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane10_stagger0                             = lane10_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane10_stagger1                             = lane10_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane11_strm0_read_enable         = strm_control[11].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane11_strm0_write_enable        = strm_control[11].strm0_write_enable        ;  // FIXME
  assign strm_control[11].strm0_read_ready           = sdp__scntl__lane11_strm0_read_ready         ;  // FIXME
  assign strm_control[11].strm0_write_ready          = sdp__scntl__lane11_strm0_write_ready        ;  // FIXME
  assign strm_control[11].strm0_read_complete        = sdp__scntl__lane11_strm0_read_complete      ;  // FIXME
  assign strm_control[11].strm0_write_complete       = sdp__scntl__lane11_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane11_strm1_read_enable         = strm_control[11].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane11_strm1_write_enable        = strm_control[11].strm1_write_enable        ;  // FIXME
  assign strm_control[11].strm1_read_ready           = sdp__scntl__lane11_strm1_read_ready         ;  // FIXME
  assign strm_control[11].strm1_write_ready          = sdp__scntl__lane11_strm1_write_ready        ;  // FIXME
  assign strm_control[11].strm1_read_complete        = sdp__scntl__lane11_strm1_read_complete      ;  // FIXME
  assign strm_control[11].strm1_write_complete       = sdp__scntl__lane11_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane11_strm0_read_start_address  = lane11_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane11_strm1_read_start_address  = lane11_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane11_strm0_write_start_address = lane11_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane11_strm1_write_start_address = lane11_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane11_type0                     = lane11_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane11_type1                     = lane11_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane11_num_of_types0             = lane11_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane11_num_of_types1             = lane11_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane11_strm0_read_start_address             = lane11_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane11_strm1_read_start_address             = lane11_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane11_strm0_write_start_address            = lane11_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane11_strm1_write_start_address            = lane11_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane11_type0                                = lane11_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane11_type1                                = lane11_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane11_num_of_types0                        = lane11_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane11_num_of_types1                        = lane11_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane11_stagger0                             = lane11_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane11_stagger1                             = lane11_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane12_strm0_read_enable         = strm_control[12].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane12_strm0_write_enable        = strm_control[12].strm0_write_enable        ;  // FIXME
  assign strm_control[12].strm0_read_ready           = sdp__scntl__lane12_strm0_read_ready         ;  // FIXME
  assign strm_control[12].strm0_write_ready          = sdp__scntl__lane12_strm0_write_ready        ;  // FIXME
  assign strm_control[12].strm0_read_complete        = sdp__scntl__lane12_strm0_read_complete      ;  // FIXME
  assign strm_control[12].strm0_write_complete       = sdp__scntl__lane12_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane12_strm1_read_enable         = strm_control[12].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane12_strm1_write_enable        = strm_control[12].strm1_write_enable        ;  // FIXME
  assign strm_control[12].strm1_read_ready           = sdp__scntl__lane12_strm1_read_ready         ;  // FIXME
  assign strm_control[12].strm1_write_ready          = sdp__scntl__lane12_strm1_write_ready        ;  // FIXME
  assign strm_control[12].strm1_read_complete        = sdp__scntl__lane12_strm1_read_complete      ;  // FIXME
  assign strm_control[12].strm1_write_complete       = sdp__scntl__lane12_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane12_strm0_read_start_address  = lane12_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane12_strm1_read_start_address  = lane12_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane12_strm0_write_start_address = lane12_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane12_strm1_write_start_address = lane12_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane12_type0                     = lane12_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane12_type1                     = lane12_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane12_num_of_types0             = lane12_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane12_num_of_types1             = lane12_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane12_strm0_read_start_address             = lane12_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane12_strm1_read_start_address             = lane12_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane12_strm0_write_start_address            = lane12_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane12_strm1_write_start_address            = lane12_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane12_type0                                = lane12_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane12_type1                                = lane12_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane12_num_of_types0                        = lane12_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane12_num_of_types1                        = lane12_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane12_stagger0                             = lane12_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane12_stagger1                             = lane12_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane13_strm0_read_enable         = strm_control[13].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane13_strm0_write_enable        = strm_control[13].strm0_write_enable        ;  // FIXME
  assign strm_control[13].strm0_read_ready           = sdp__scntl__lane13_strm0_read_ready         ;  // FIXME
  assign strm_control[13].strm0_write_ready          = sdp__scntl__lane13_strm0_write_ready        ;  // FIXME
  assign strm_control[13].strm0_read_complete        = sdp__scntl__lane13_strm0_read_complete      ;  // FIXME
  assign strm_control[13].strm0_write_complete       = sdp__scntl__lane13_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane13_strm1_read_enable         = strm_control[13].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane13_strm1_write_enable        = strm_control[13].strm1_write_enable        ;  // FIXME
  assign strm_control[13].strm1_read_ready           = sdp__scntl__lane13_strm1_read_ready         ;  // FIXME
  assign strm_control[13].strm1_write_ready          = sdp__scntl__lane13_strm1_write_ready        ;  // FIXME
  assign strm_control[13].strm1_read_complete        = sdp__scntl__lane13_strm1_read_complete      ;  // FIXME
  assign strm_control[13].strm1_write_complete       = sdp__scntl__lane13_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane13_strm0_read_start_address  = lane13_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane13_strm1_read_start_address  = lane13_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane13_strm0_write_start_address = lane13_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane13_strm1_write_start_address = lane13_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane13_type0                     = lane13_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane13_type1                     = lane13_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane13_num_of_types0             = lane13_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane13_num_of_types1             = lane13_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane13_strm0_read_start_address             = lane13_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane13_strm1_read_start_address             = lane13_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane13_strm0_write_start_address            = lane13_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane13_strm1_write_start_address            = lane13_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane13_type0                                = lane13_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane13_type1                                = lane13_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane13_num_of_types0                        = lane13_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane13_num_of_types1                        = lane13_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane13_stagger0                             = lane13_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane13_stagger1                             = lane13_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane14_strm0_read_enable         = strm_control[14].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane14_strm0_write_enable        = strm_control[14].strm0_write_enable        ;  // FIXME
  assign strm_control[14].strm0_read_ready           = sdp__scntl__lane14_strm0_read_ready         ;  // FIXME
  assign strm_control[14].strm0_write_ready          = sdp__scntl__lane14_strm0_write_ready        ;  // FIXME
  assign strm_control[14].strm0_read_complete        = sdp__scntl__lane14_strm0_read_complete      ;  // FIXME
  assign strm_control[14].strm0_write_complete       = sdp__scntl__lane14_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane14_strm1_read_enable         = strm_control[14].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane14_strm1_write_enable        = strm_control[14].strm1_write_enable        ;  // FIXME
  assign strm_control[14].strm1_read_ready           = sdp__scntl__lane14_strm1_read_ready         ;  // FIXME
  assign strm_control[14].strm1_write_ready          = sdp__scntl__lane14_strm1_write_ready        ;  // FIXME
  assign strm_control[14].strm1_read_complete        = sdp__scntl__lane14_strm1_read_complete      ;  // FIXME
  assign strm_control[14].strm1_write_complete       = sdp__scntl__lane14_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane14_strm0_read_start_address  = lane14_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane14_strm1_read_start_address  = lane14_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane14_strm0_write_start_address = lane14_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane14_strm1_write_start_address = lane14_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane14_type0                     = lane14_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane14_type1                     = lane14_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane14_num_of_types0             = lane14_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane14_num_of_types1             = lane14_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane14_strm0_read_start_address             = lane14_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane14_strm1_read_start_address             = lane14_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane14_strm0_write_start_address            = lane14_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane14_strm1_write_start_address            = lane14_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane14_type0                                = lane14_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane14_type1                                = lane14_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane14_num_of_types0                        = lane14_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane14_num_of_types1                        = lane14_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane14_stagger0                             = lane14_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane14_stagger1                             = lane14_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane15_strm0_read_enable         = strm_control[15].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane15_strm0_write_enable        = strm_control[15].strm0_write_enable        ;  // FIXME
  assign strm_control[15].strm0_read_ready           = sdp__scntl__lane15_strm0_read_ready         ;  // FIXME
  assign strm_control[15].strm0_write_ready          = sdp__scntl__lane15_strm0_write_ready        ;  // FIXME
  assign strm_control[15].strm0_read_complete        = sdp__scntl__lane15_strm0_read_complete      ;  // FIXME
  assign strm_control[15].strm0_write_complete       = sdp__scntl__lane15_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane15_strm1_read_enable         = strm_control[15].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane15_strm1_write_enable        = strm_control[15].strm1_write_enable        ;  // FIXME
  assign strm_control[15].strm1_read_ready           = sdp__scntl__lane15_strm1_read_ready         ;  // FIXME
  assign strm_control[15].strm1_write_ready          = sdp__scntl__lane15_strm1_write_ready        ;  // FIXME
  assign strm_control[15].strm1_read_complete        = sdp__scntl__lane15_strm1_read_complete      ;  // FIXME
  assign strm_control[15].strm1_write_complete       = sdp__scntl__lane15_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane15_strm0_read_start_address  = lane15_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane15_strm1_read_start_address  = lane15_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane15_strm0_write_start_address = lane15_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane15_strm1_write_start_address = lane15_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane15_type0                     = lane15_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane15_type1                     = lane15_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane15_num_of_types0             = lane15_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane15_num_of_types1             = lane15_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane15_strm0_read_start_address             = lane15_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane15_strm1_read_start_address             = lane15_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane15_strm0_write_start_address            = lane15_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane15_strm1_write_start_address            = lane15_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane15_type0                                = lane15_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane15_type1                                = lane15_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane15_num_of_types0                        = lane15_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane15_num_of_types1                        = lane15_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane15_stagger0                             = lane15_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane15_stagger1                             = lane15_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane16_strm0_read_enable         = strm_control[16].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane16_strm0_write_enable        = strm_control[16].strm0_write_enable        ;  // FIXME
  assign strm_control[16].strm0_read_ready           = sdp__scntl__lane16_strm0_read_ready         ;  // FIXME
  assign strm_control[16].strm0_write_ready          = sdp__scntl__lane16_strm0_write_ready        ;  // FIXME
  assign strm_control[16].strm0_read_complete        = sdp__scntl__lane16_strm0_read_complete      ;  // FIXME
  assign strm_control[16].strm0_write_complete       = sdp__scntl__lane16_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane16_strm1_read_enable         = strm_control[16].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane16_strm1_write_enable        = strm_control[16].strm1_write_enable        ;  // FIXME
  assign strm_control[16].strm1_read_ready           = sdp__scntl__lane16_strm1_read_ready         ;  // FIXME
  assign strm_control[16].strm1_write_ready          = sdp__scntl__lane16_strm1_write_ready        ;  // FIXME
  assign strm_control[16].strm1_read_complete        = sdp__scntl__lane16_strm1_read_complete      ;  // FIXME
  assign strm_control[16].strm1_write_complete       = sdp__scntl__lane16_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane16_strm0_read_start_address  = lane16_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane16_strm1_read_start_address  = lane16_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane16_strm0_write_start_address = lane16_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane16_strm1_write_start_address = lane16_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane16_type0                     = lane16_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane16_type1                     = lane16_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane16_num_of_types0             = lane16_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane16_num_of_types1             = lane16_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane16_strm0_read_start_address             = lane16_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane16_strm1_read_start_address             = lane16_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane16_strm0_write_start_address            = lane16_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane16_strm1_write_start_address            = lane16_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane16_type0                                = lane16_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane16_type1                                = lane16_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane16_num_of_types0                        = lane16_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane16_num_of_types1                        = lane16_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane16_stagger0                             = lane16_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane16_stagger1                             = lane16_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane17_strm0_read_enable         = strm_control[17].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane17_strm0_write_enable        = strm_control[17].strm0_write_enable        ;  // FIXME
  assign strm_control[17].strm0_read_ready           = sdp__scntl__lane17_strm0_read_ready         ;  // FIXME
  assign strm_control[17].strm0_write_ready          = sdp__scntl__lane17_strm0_write_ready        ;  // FIXME
  assign strm_control[17].strm0_read_complete        = sdp__scntl__lane17_strm0_read_complete      ;  // FIXME
  assign strm_control[17].strm0_write_complete       = sdp__scntl__lane17_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane17_strm1_read_enable         = strm_control[17].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane17_strm1_write_enable        = strm_control[17].strm1_write_enable        ;  // FIXME
  assign strm_control[17].strm1_read_ready           = sdp__scntl__lane17_strm1_read_ready         ;  // FIXME
  assign strm_control[17].strm1_write_ready          = sdp__scntl__lane17_strm1_write_ready        ;  // FIXME
  assign strm_control[17].strm1_read_complete        = sdp__scntl__lane17_strm1_read_complete      ;  // FIXME
  assign strm_control[17].strm1_write_complete       = sdp__scntl__lane17_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane17_strm0_read_start_address  = lane17_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane17_strm1_read_start_address  = lane17_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane17_strm0_write_start_address = lane17_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane17_strm1_write_start_address = lane17_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane17_type0                     = lane17_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane17_type1                     = lane17_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane17_num_of_types0             = lane17_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane17_num_of_types1             = lane17_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane17_strm0_read_start_address             = lane17_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane17_strm1_read_start_address             = lane17_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane17_strm0_write_start_address            = lane17_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane17_strm1_write_start_address            = lane17_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane17_type0                                = lane17_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane17_type1                                = lane17_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane17_num_of_types0                        = lane17_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane17_num_of_types1                        = lane17_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane17_stagger0                             = lane17_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane17_stagger1                             = lane17_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane18_strm0_read_enable         = strm_control[18].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane18_strm0_write_enable        = strm_control[18].strm0_write_enable        ;  // FIXME
  assign strm_control[18].strm0_read_ready           = sdp__scntl__lane18_strm0_read_ready         ;  // FIXME
  assign strm_control[18].strm0_write_ready          = sdp__scntl__lane18_strm0_write_ready        ;  // FIXME
  assign strm_control[18].strm0_read_complete        = sdp__scntl__lane18_strm0_read_complete      ;  // FIXME
  assign strm_control[18].strm0_write_complete       = sdp__scntl__lane18_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane18_strm1_read_enable         = strm_control[18].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane18_strm1_write_enable        = strm_control[18].strm1_write_enable        ;  // FIXME
  assign strm_control[18].strm1_read_ready           = sdp__scntl__lane18_strm1_read_ready         ;  // FIXME
  assign strm_control[18].strm1_write_ready          = sdp__scntl__lane18_strm1_write_ready        ;  // FIXME
  assign strm_control[18].strm1_read_complete        = sdp__scntl__lane18_strm1_read_complete      ;  // FIXME
  assign strm_control[18].strm1_write_complete       = sdp__scntl__lane18_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane18_strm0_read_start_address  = lane18_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane18_strm1_read_start_address  = lane18_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane18_strm0_write_start_address = lane18_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane18_strm1_write_start_address = lane18_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane18_type0                     = lane18_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane18_type1                     = lane18_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane18_num_of_types0             = lane18_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane18_num_of_types1             = lane18_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane18_strm0_read_start_address             = lane18_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane18_strm1_read_start_address             = lane18_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane18_strm0_write_start_address            = lane18_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane18_strm1_write_start_address            = lane18_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane18_type0                                = lane18_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane18_type1                                = lane18_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane18_num_of_types0                        = lane18_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane18_num_of_types1                        = lane18_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane18_stagger0                             = lane18_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane18_stagger1                             = lane18_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane19_strm0_read_enable         = strm_control[19].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane19_strm0_write_enable        = strm_control[19].strm0_write_enable        ;  // FIXME
  assign strm_control[19].strm0_read_ready           = sdp__scntl__lane19_strm0_read_ready         ;  // FIXME
  assign strm_control[19].strm0_write_ready          = sdp__scntl__lane19_strm0_write_ready        ;  // FIXME
  assign strm_control[19].strm0_read_complete        = sdp__scntl__lane19_strm0_read_complete      ;  // FIXME
  assign strm_control[19].strm0_write_complete       = sdp__scntl__lane19_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane19_strm1_read_enable         = strm_control[19].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane19_strm1_write_enable        = strm_control[19].strm1_write_enable        ;  // FIXME
  assign strm_control[19].strm1_read_ready           = sdp__scntl__lane19_strm1_read_ready         ;  // FIXME
  assign strm_control[19].strm1_write_ready          = sdp__scntl__lane19_strm1_write_ready        ;  // FIXME
  assign strm_control[19].strm1_read_complete        = sdp__scntl__lane19_strm1_read_complete      ;  // FIXME
  assign strm_control[19].strm1_write_complete       = sdp__scntl__lane19_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane19_strm0_read_start_address  = lane19_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane19_strm1_read_start_address  = lane19_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane19_strm0_write_start_address = lane19_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane19_strm1_write_start_address = lane19_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane19_type0                     = lane19_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane19_type1                     = lane19_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane19_num_of_types0             = lane19_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane19_num_of_types1             = lane19_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane19_strm0_read_start_address             = lane19_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane19_strm1_read_start_address             = lane19_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane19_strm0_write_start_address            = lane19_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane19_strm1_write_start_address            = lane19_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane19_type0                                = lane19_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane19_type1                                = lane19_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane19_num_of_types0                        = lane19_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane19_num_of_types1                        = lane19_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane19_stagger0                             = lane19_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane19_stagger1                             = lane19_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane20_strm0_read_enable         = strm_control[20].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane20_strm0_write_enable        = strm_control[20].strm0_write_enable        ;  // FIXME
  assign strm_control[20].strm0_read_ready           = sdp__scntl__lane20_strm0_read_ready         ;  // FIXME
  assign strm_control[20].strm0_write_ready          = sdp__scntl__lane20_strm0_write_ready        ;  // FIXME
  assign strm_control[20].strm0_read_complete        = sdp__scntl__lane20_strm0_read_complete      ;  // FIXME
  assign strm_control[20].strm0_write_complete       = sdp__scntl__lane20_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane20_strm1_read_enable         = strm_control[20].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane20_strm1_write_enable        = strm_control[20].strm1_write_enable        ;  // FIXME
  assign strm_control[20].strm1_read_ready           = sdp__scntl__lane20_strm1_read_ready         ;  // FIXME
  assign strm_control[20].strm1_write_ready          = sdp__scntl__lane20_strm1_write_ready        ;  // FIXME
  assign strm_control[20].strm1_read_complete        = sdp__scntl__lane20_strm1_read_complete      ;  // FIXME
  assign strm_control[20].strm1_write_complete       = sdp__scntl__lane20_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane20_strm0_read_start_address  = lane20_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane20_strm1_read_start_address  = lane20_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane20_strm0_write_start_address = lane20_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane20_strm1_write_start_address = lane20_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane20_type0                     = lane20_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane20_type1                     = lane20_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane20_num_of_types0             = lane20_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane20_num_of_types1             = lane20_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane20_strm0_read_start_address             = lane20_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane20_strm1_read_start_address             = lane20_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane20_strm0_write_start_address            = lane20_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane20_strm1_write_start_address            = lane20_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane20_type0                                = lane20_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane20_type1                                = lane20_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane20_num_of_types0                        = lane20_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane20_num_of_types1                        = lane20_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane20_stagger0                             = lane20_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane20_stagger1                             = lane20_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane21_strm0_read_enable         = strm_control[21].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane21_strm0_write_enable        = strm_control[21].strm0_write_enable        ;  // FIXME
  assign strm_control[21].strm0_read_ready           = sdp__scntl__lane21_strm0_read_ready         ;  // FIXME
  assign strm_control[21].strm0_write_ready          = sdp__scntl__lane21_strm0_write_ready        ;  // FIXME
  assign strm_control[21].strm0_read_complete        = sdp__scntl__lane21_strm0_read_complete      ;  // FIXME
  assign strm_control[21].strm0_write_complete       = sdp__scntl__lane21_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane21_strm1_read_enable         = strm_control[21].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane21_strm1_write_enable        = strm_control[21].strm1_write_enable        ;  // FIXME
  assign strm_control[21].strm1_read_ready           = sdp__scntl__lane21_strm1_read_ready         ;  // FIXME
  assign strm_control[21].strm1_write_ready          = sdp__scntl__lane21_strm1_write_ready        ;  // FIXME
  assign strm_control[21].strm1_read_complete        = sdp__scntl__lane21_strm1_read_complete      ;  // FIXME
  assign strm_control[21].strm1_write_complete       = sdp__scntl__lane21_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane21_strm0_read_start_address  = lane21_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane21_strm1_read_start_address  = lane21_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane21_strm0_write_start_address = lane21_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane21_strm1_write_start_address = lane21_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane21_type0                     = lane21_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane21_type1                     = lane21_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane21_num_of_types0             = lane21_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane21_num_of_types1             = lane21_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane21_strm0_read_start_address             = lane21_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane21_strm1_read_start_address             = lane21_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane21_strm0_write_start_address            = lane21_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane21_strm1_write_start_address            = lane21_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane21_type0                                = lane21_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane21_type1                                = lane21_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane21_num_of_types0                        = lane21_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane21_num_of_types1                        = lane21_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane21_stagger0                             = lane21_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane21_stagger1                             = lane21_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane22_strm0_read_enable         = strm_control[22].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane22_strm0_write_enable        = strm_control[22].strm0_write_enable        ;  // FIXME
  assign strm_control[22].strm0_read_ready           = sdp__scntl__lane22_strm0_read_ready         ;  // FIXME
  assign strm_control[22].strm0_write_ready          = sdp__scntl__lane22_strm0_write_ready        ;  // FIXME
  assign strm_control[22].strm0_read_complete        = sdp__scntl__lane22_strm0_read_complete      ;  // FIXME
  assign strm_control[22].strm0_write_complete       = sdp__scntl__lane22_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane22_strm1_read_enable         = strm_control[22].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane22_strm1_write_enable        = strm_control[22].strm1_write_enable        ;  // FIXME
  assign strm_control[22].strm1_read_ready           = sdp__scntl__lane22_strm1_read_ready         ;  // FIXME
  assign strm_control[22].strm1_write_ready          = sdp__scntl__lane22_strm1_write_ready        ;  // FIXME
  assign strm_control[22].strm1_read_complete        = sdp__scntl__lane22_strm1_read_complete      ;  // FIXME
  assign strm_control[22].strm1_write_complete       = sdp__scntl__lane22_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane22_strm0_read_start_address  = lane22_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane22_strm1_read_start_address  = lane22_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane22_strm0_write_start_address = lane22_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane22_strm1_write_start_address = lane22_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane22_type0                     = lane22_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane22_type1                     = lane22_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane22_num_of_types0             = lane22_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane22_num_of_types1             = lane22_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane22_strm0_read_start_address             = lane22_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane22_strm1_read_start_address             = lane22_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane22_strm0_write_start_address            = lane22_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane22_strm1_write_start_address            = lane22_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane22_type0                                = lane22_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane22_type1                                = lane22_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane22_num_of_types0                        = lane22_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane22_num_of_types1                        = lane22_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane22_stagger0                             = lane22_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane22_stagger1                             = lane22_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane23_strm0_read_enable         = strm_control[23].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane23_strm0_write_enable        = strm_control[23].strm0_write_enable        ;  // FIXME
  assign strm_control[23].strm0_read_ready           = sdp__scntl__lane23_strm0_read_ready         ;  // FIXME
  assign strm_control[23].strm0_write_ready          = sdp__scntl__lane23_strm0_write_ready        ;  // FIXME
  assign strm_control[23].strm0_read_complete        = sdp__scntl__lane23_strm0_read_complete      ;  // FIXME
  assign strm_control[23].strm0_write_complete       = sdp__scntl__lane23_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane23_strm1_read_enable         = strm_control[23].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane23_strm1_write_enable        = strm_control[23].strm1_write_enable        ;  // FIXME
  assign strm_control[23].strm1_read_ready           = sdp__scntl__lane23_strm1_read_ready         ;  // FIXME
  assign strm_control[23].strm1_write_ready          = sdp__scntl__lane23_strm1_write_ready        ;  // FIXME
  assign strm_control[23].strm1_read_complete        = sdp__scntl__lane23_strm1_read_complete      ;  // FIXME
  assign strm_control[23].strm1_write_complete       = sdp__scntl__lane23_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane23_strm0_read_start_address  = lane23_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane23_strm1_read_start_address  = lane23_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane23_strm0_write_start_address = lane23_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane23_strm1_write_start_address = lane23_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane23_type0                     = lane23_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane23_type1                     = lane23_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane23_num_of_types0             = lane23_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane23_num_of_types1             = lane23_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane23_strm0_read_start_address             = lane23_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane23_strm1_read_start_address             = lane23_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane23_strm0_write_start_address            = lane23_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane23_strm1_write_start_address            = lane23_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane23_type0                                = lane23_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane23_type1                                = lane23_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane23_num_of_types0                        = lane23_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane23_num_of_types1                        = lane23_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane23_stagger0                             = lane23_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane23_stagger1                             = lane23_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane24_strm0_read_enable         = strm_control[24].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane24_strm0_write_enable        = strm_control[24].strm0_write_enable        ;  // FIXME
  assign strm_control[24].strm0_read_ready           = sdp__scntl__lane24_strm0_read_ready         ;  // FIXME
  assign strm_control[24].strm0_write_ready          = sdp__scntl__lane24_strm0_write_ready        ;  // FIXME
  assign strm_control[24].strm0_read_complete        = sdp__scntl__lane24_strm0_read_complete      ;  // FIXME
  assign strm_control[24].strm0_write_complete       = sdp__scntl__lane24_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane24_strm1_read_enable         = strm_control[24].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane24_strm1_write_enable        = strm_control[24].strm1_write_enable        ;  // FIXME
  assign strm_control[24].strm1_read_ready           = sdp__scntl__lane24_strm1_read_ready         ;  // FIXME
  assign strm_control[24].strm1_write_ready          = sdp__scntl__lane24_strm1_write_ready        ;  // FIXME
  assign strm_control[24].strm1_read_complete        = sdp__scntl__lane24_strm1_read_complete      ;  // FIXME
  assign strm_control[24].strm1_write_complete       = sdp__scntl__lane24_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane24_strm0_read_start_address  = lane24_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane24_strm1_read_start_address  = lane24_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane24_strm0_write_start_address = lane24_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane24_strm1_write_start_address = lane24_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane24_type0                     = lane24_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane24_type1                     = lane24_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane24_num_of_types0             = lane24_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane24_num_of_types1             = lane24_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane24_strm0_read_start_address             = lane24_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane24_strm1_read_start_address             = lane24_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane24_strm0_write_start_address            = lane24_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane24_strm1_write_start_address            = lane24_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane24_type0                                = lane24_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane24_type1                                = lane24_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane24_num_of_types0                        = lane24_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane24_num_of_types1                        = lane24_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane24_stagger0                             = lane24_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane24_stagger1                             = lane24_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane25_strm0_read_enable         = strm_control[25].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane25_strm0_write_enable        = strm_control[25].strm0_write_enable        ;  // FIXME
  assign strm_control[25].strm0_read_ready           = sdp__scntl__lane25_strm0_read_ready         ;  // FIXME
  assign strm_control[25].strm0_write_ready          = sdp__scntl__lane25_strm0_write_ready        ;  // FIXME
  assign strm_control[25].strm0_read_complete        = sdp__scntl__lane25_strm0_read_complete      ;  // FIXME
  assign strm_control[25].strm0_write_complete       = sdp__scntl__lane25_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane25_strm1_read_enable         = strm_control[25].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane25_strm1_write_enable        = strm_control[25].strm1_write_enable        ;  // FIXME
  assign strm_control[25].strm1_read_ready           = sdp__scntl__lane25_strm1_read_ready         ;  // FIXME
  assign strm_control[25].strm1_write_ready          = sdp__scntl__lane25_strm1_write_ready        ;  // FIXME
  assign strm_control[25].strm1_read_complete        = sdp__scntl__lane25_strm1_read_complete      ;  // FIXME
  assign strm_control[25].strm1_write_complete       = sdp__scntl__lane25_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane25_strm0_read_start_address  = lane25_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane25_strm1_read_start_address  = lane25_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane25_strm0_write_start_address = lane25_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane25_strm1_write_start_address = lane25_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane25_type0                     = lane25_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane25_type1                     = lane25_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane25_num_of_types0             = lane25_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane25_num_of_types1             = lane25_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane25_strm0_read_start_address             = lane25_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane25_strm1_read_start_address             = lane25_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane25_strm0_write_start_address            = lane25_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane25_strm1_write_start_address            = lane25_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane25_type0                                = lane25_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane25_type1                                = lane25_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane25_num_of_types0                        = lane25_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane25_num_of_types1                        = lane25_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane25_stagger0                             = lane25_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane25_stagger1                             = lane25_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane26_strm0_read_enable         = strm_control[26].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane26_strm0_write_enable        = strm_control[26].strm0_write_enable        ;  // FIXME
  assign strm_control[26].strm0_read_ready           = sdp__scntl__lane26_strm0_read_ready         ;  // FIXME
  assign strm_control[26].strm0_write_ready          = sdp__scntl__lane26_strm0_write_ready        ;  // FIXME
  assign strm_control[26].strm0_read_complete        = sdp__scntl__lane26_strm0_read_complete      ;  // FIXME
  assign strm_control[26].strm0_write_complete       = sdp__scntl__lane26_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane26_strm1_read_enable         = strm_control[26].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane26_strm1_write_enable        = strm_control[26].strm1_write_enable        ;  // FIXME
  assign strm_control[26].strm1_read_ready           = sdp__scntl__lane26_strm1_read_ready         ;  // FIXME
  assign strm_control[26].strm1_write_ready          = sdp__scntl__lane26_strm1_write_ready        ;  // FIXME
  assign strm_control[26].strm1_read_complete        = sdp__scntl__lane26_strm1_read_complete      ;  // FIXME
  assign strm_control[26].strm1_write_complete       = sdp__scntl__lane26_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane26_strm0_read_start_address  = lane26_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane26_strm1_read_start_address  = lane26_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane26_strm0_write_start_address = lane26_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane26_strm1_write_start_address = lane26_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane26_type0                     = lane26_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane26_type1                     = lane26_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane26_num_of_types0             = lane26_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane26_num_of_types1             = lane26_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane26_strm0_read_start_address             = lane26_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane26_strm1_read_start_address             = lane26_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane26_strm0_write_start_address            = lane26_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane26_strm1_write_start_address            = lane26_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane26_type0                                = lane26_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane26_type1                                = lane26_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane26_num_of_types0                        = lane26_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane26_num_of_types1                        = lane26_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane26_stagger0                             = lane26_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane26_stagger1                             = lane26_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane27_strm0_read_enable         = strm_control[27].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane27_strm0_write_enable        = strm_control[27].strm0_write_enable        ;  // FIXME
  assign strm_control[27].strm0_read_ready           = sdp__scntl__lane27_strm0_read_ready         ;  // FIXME
  assign strm_control[27].strm0_write_ready          = sdp__scntl__lane27_strm0_write_ready        ;  // FIXME
  assign strm_control[27].strm0_read_complete        = sdp__scntl__lane27_strm0_read_complete      ;  // FIXME
  assign strm_control[27].strm0_write_complete       = sdp__scntl__lane27_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane27_strm1_read_enable         = strm_control[27].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane27_strm1_write_enable        = strm_control[27].strm1_write_enable        ;  // FIXME
  assign strm_control[27].strm1_read_ready           = sdp__scntl__lane27_strm1_read_ready         ;  // FIXME
  assign strm_control[27].strm1_write_ready          = sdp__scntl__lane27_strm1_write_ready        ;  // FIXME
  assign strm_control[27].strm1_read_complete        = sdp__scntl__lane27_strm1_read_complete      ;  // FIXME
  assign strm_control[27].strm1_write_complete       = sdp__scntl__lane27_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane27_strm0_read_start_address  = lane27_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane27_strm1_read_start_address  = lane27_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane27_strm0_write_start_address = lane27_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane27_strm1_write_start_address = lane27_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane27_type0                     = lane27_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane27_type1                     = lane27_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane27_num_of_types0             = lane27_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane27_num_of_types1             = lane27_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane27_strm0_read_start_address             = lane27_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane27_strm1_read_start_address             = lane27_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane27_strm0_write_start_address            = lane27_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane27_strm1_write_start_address            = lane27_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane27_type0                                = lane27_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane27_type1                                = lane27_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane27_num_of_types0                        = lane27_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane27_num_of_types1                        = lane27_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane27_stagger0                             = lane27_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane27_stagger1                             = lane27_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane28_strm0_read_enable         = strm_control[28].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane28_strm0_write_enable        = strm_control[28].strm0_write_enable        ;  // FIXME
  assign strm_control[28].strm0_read_ready           = sdp__scntl__lane28_strm0_read_ready         ;  // FIXME
  assign strm_control[28].strm0_write_ready          = sdp__scntl__lane28_strm0_write_ready        ;  // FIXME
  assign strm_control[28].strm0_read_complete        = sdp__scntl__lane28_strm0_read_complete      ;  // FIXME
  assign strm_control[28].strm0_write_complete       = sdp__scntl__lane28_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane28_strm1_read_enable         = strm_control[28].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane28_strm1_write_enable        = strm_control[28].strm1_write_enable        ;  // FIXME
  assign strm_control[28].strm1_read_ready           = sdp__scntl__lane28_strm1_read_ready         ;  // FIXME
  assign strm_control[28].strm1_write_ready          = sdp__scntl__lane28_strm1_write_ready        ;  // FIXME
  assign strm_control[28].strm1_read_complete        = sdp__scntl__lane28_strm1_read_complete      ;  // FIXME
  assign strm_control[28].strm1_write_complete       = sdp__scntl__lane28_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane28_strm0_read_start_address  = lane28_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane28_strm1_read_start_address  = lane28_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane28_strm0_write_start_address = lane28_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane28_strm1_write_start_address = lane28_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane28_type0                     = lane28_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane28_type1                     = lane28_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane28_num_of_types0             = lane28_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane28_num_of_types1             = lane28_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane28_strm0_read_start_address             = lane28_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane28_strm1_read_start_address             = lane28_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane28_strm0_write_start_address            = lane28_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane28_strm1_write_start_address            = lane28_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane28_type0                                = lane28_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane28_type1                                = lane28_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane28_num_of_types0                        = lane28_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane28_num_of_types1                        = lane28_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane28_stagger0                             = lane28_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane28_stagger1                             = lane28_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane29_strm0_read_enable         = strm_control[29].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane29_strm0_write_enable        = strm_control[29].strm0_write_enable        ;  // FIXME
  assign strm_control[29].strm0_read_ready           = sdp__scntl__lane29_strm0_read_ready         ;  // FIXME
  assign strm_control[29].strm0_write_ready          = sdp__scntl__lane29_strm0_write_ready        ;  // FIXME
  assign strm_control[29].strm0_read_complete        = sdp__scntl__lane29_strm0_read_complete      ;  // FIXME
  assign strm_control[29].strm0_write_complete       = sdp__scntl__lane29_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane29_strm1_read_enable         = strm_control[29].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane29_strm1_write_enable        = strm_control[29].strm1_write_enable        ;  // FIXME
  assign strm_control[29].strm1_read_ready           = sdp__scntl__lane29_strm1_read_ready         ;  // FIXME
  assign strm_control[29].strm1_write_ready          = sdp__scntl__lane29_strm1_write_ready        ;  // FIXME
  assign strm_control[29].strm1_read_complete        = sdp__scntl__lane29_strm1_read_complete      ;  // FIXME
  assign strm_control[29].strm1_write_complete       = sdp__scntl__lane29_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane29_strm0_read_start_address  = lane29_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane29_strm1_read_start_address  = lane29_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane29_strm0_write_start_address = lane29_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane29_strm1_write_start_address = lane29_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane29_type0                     = lane29_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane29_type1                     = lane29_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane29_num_of_types0             = lane29_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane29_num_of_types1             = lane29_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane29_strm0_read_start_address             = lane29_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane29_strm1_read_start_address             = lane29_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane29_strm0_write_start_address            = lane29_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane29_strm1_write_start_address            = lane29_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane29_type0                                = lane29_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane29_type1                                = lane29_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane29_num_of_types0                        = lane29_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane29_num_of_types1                        = lane29_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane29_stagger0                             = lane29_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane29_stagger1                             = lane29_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane30_strm0_read_enable         = strm_control[30].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane30_strm0_write_enable        = strm_control[30].strm0_write_enable        ;  // FIXME
  assign strm_control[30].strm0_read_ready           = sdp__scntl__lane30_strm0_read_ready         ;  // FIXME
  assign strm_control[30].strm0_write_ready          = sdp__scntl__lane30_strm0_write_ready        ;  // FIXME
  assign strm_control[30].strm0_read_complete        = sdp__scntl__lane30_strm0_read_complete      ;  // FIXME
  assign strm_control[30].strm0_write_complete       = sdp__scntl__lane30_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane30_strm1_read_enable         = strm_control[30].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane30_strm1_write_enable        = strm_control[30].strm1_write_enable        ;  // FIXME
  assign strm_control[30].strm1_read_ready           = sdp__scntl__lane30_strm1_read_ready         ;  // FIXME
  assign strm_control[30].strm1_write_ready          = sdp__scntl__lane30_strm1_write_ready        ;  // FIXME
  assign strm_control[30].strm1_read_complete        = sdp__scntl__lane30_strm1_read_complete      ;  // FIXME
  assign strm_control[30].strm1_write_complete       = sdp__scntl__lane30_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane30_strm0_read_start_address  = lane30_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane30_strm1_read_start_address  = lane30_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane30_strm0_write_start_address = lane30_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane30_strm1_write_start_address = lane30_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane30_type0                     = lane30_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane30_type1                     = lane30_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane30_num_of_types0             = lane30_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane30_num_of_types1             = lane30_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane30_strm0_read_start_address             = lane30_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane30_strm1_read_start_address             = lane30_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane30_strm0_write_start_address            = lane30_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane30_strm1_write_start_address            = lane30_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane30_type0                                = lane30_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane30_type1                                = lane30_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane30_num_of_types0                        = lane30_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane30_num_of_types1                        = lane30_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane30_stagger0                             = lane30_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane30_stagger1                             = lane30_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane31_strm0_read_enable         = strm_control[31].strm0_read_enable         ;  // FIXME
  assign scntl__sdp__lane31_strm0_write_enable        = strm_control[31].strm0_write_enable        ;  // FIXME
  assign strm_control[31].strm0_read_ready           = sdp__scntl__lane31_strm0_read_ready         ;  // FIXME
  assign strm_control[31].strm0_write_ready          = sdp__scntl__lane31_strm0_write_ready        ;  // FIXME
  assign strm_control[31].strm0_read_complete        = sdp__scntl__lane31_strm0_read_complete      ;  // FIXME
  assign strm_control[31].strm0_write_complete       = sdp__scntl__lane31_strm0_write_complete     ;  // FIXME
  // Connect lane operation information to stream fsm 
  assign scntl__sdp__lane31_strm1_read_enable         = strm_control[31].strm1_read_enable         ;  // FIXME
  assign scntl__sdp__lane31_strm1_write_enable        = strm_control[31].strm1_write_enable        ;  // FIXME
  assign strm_control[31].strm1_read_ready           = sdp__scntl__lane31_strm1_read_ready         ;  // FIXME
  assign strm_control[31].strm1_write_ready          = sdp__scntl__lane31_strm1_write_ready        ;  // FIXME
  assign strm_control[31].strm1_read_complete        = sdp__scntl__lane31_strm1_read_complete      ;  // FIXME
  assign strm_control[31].strm1_write_complete       = sdp__scntl__lane31_strm1_write_complete     ;  // FIXME
  always @(*)
    begin
      scntl__sdp__lane31_strm0_read_start_address  = lane31_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane31_strm1_read_start_address  = lane31_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
    end
  assign scntl__sdp__lane31_strm0_write_start_address = lane31_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane31_strm1_write_start_address = lane31_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign scntl__sdp__lane31_type0                     = lane31_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane31_type1                     = lane31_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign scntl__sdp__lane31_num_of_types0             = lane31_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign scntl__sdp__lane31_num_of_types1             = lane31_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane31_strm0_read_start_address             = lane31_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane31_strm1_read_start_address             = lane31_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane31_strm0_write_start_address            = lane31_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane31_strm1_write_start_address            = lane31_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;
  assign lane31_type0                                = lane31_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane31_type1                                = lane31_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;
  assign lane31_num_of_types0                        = lane31_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane31_num_of_types1                        = lane31_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;
  assign lane31_stagger0                             = lane31_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;
  assign lane31_stagger1                             = lane31_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;

  assign strm_control[0].strm0_type         =  lane0_type0         ; 
  assign strm_control[0].strm0_num_of_types =  lane0_num_of_types0 ; 
  assign strm_control[0].strm0_stagger      =  lane0_stagger0      ; 
  assign strm_control[0].strm1_type         =  lane0_type1         ; 
  assign strm_control[0].strm1_num_of_types =  lane0_num_of_types1 ; 
  assign strm_control[0].strm1_stagger      =  lane0_stagger1      ; 
  assign strm_control[1].strm0_type         =  lane1_type0         ; 
  assign strm_control[1].strm0_num_of_types =  lane1_num_of_types0 ; 
  assign strm_control[1].strm0_stagger      =  lane1_stagger0      ; 
  assign strm_control[1].strm1_type         =  lane1_type1         ; 
  assign strm_control[1].strm1_num_of_types =  lane1_num_of_types1 ; 
  assign strm_control[1].strm1_stagger      =  lane1_stagger1      ; 
  assign strm_control[2].strm0_type         =  lane2_type0         ; 
  assign strm_control[2].strm0_num_of_types =  lane2_num_of_types0 ; 
  assign strm_control[2].strm0_stagger      =  lane2_stagger0      ; 
  assign strm_control[2].strm1_type         =  lane2_type1         ; 
  assign strm_control[2].strm1_num_of_types =  lane2_num_of_types1 ; 
  assign strm_control[2].strm1_stagger      =  lane2_stagger1      ; 
  assign strm_control[3].strm0_type         =  lane3_type0         ; 
  assign strm_control[3].strm0_num_of_types =  lane3_num_of_types0 ; 
  assign strm_control[3].strm0_stagger      =  lane3_stagger0      ; 
  assign strm_control[3].strm1_type         =  lane3_type1         ; 
  assign strm_control[3].strm1_num_of_types =  lane3_num_of_types1 ; 
  assign strm_control[3].strm1_stagger      =  lane3_stagger1      ; 
  assign strm_control[4].strm0_type         =  lane4_type0         ; 
  assign strm_control[4].strm0_num_of_types =  lane4_num_of_types0 ; 
  assign strm_control[4].strm0_stagger      =  lane4_stagger0      ; 
  assign strm_control[4].strm1_type         =  lane4_type1         ; 
  assign strm_control[4].strm1_num_of_types =  lane4_num_of_types1 ; 
  assign strm_control[4].strm1_stagger      =  lane4_stagger1      ; 
  assign strm_control[5].strm0_type         =  lane5_type0         ; 
  assign strm_control[5].strm0_num_of_types =  lane5_num_of_types0 ; 
  assign strm_control[5].strm0_stagger      =  lane5_stagger0      ; 
  assign strm_control[5].strm1_type         =  lane5_type1         ; 
  assign strm_control[5].strm1_num_of_types =  lane5_num_of_types1 ; 
  assign strm_control[5].strm1_stagger      =  lane5_stagger1      ; 
  assign strm_control[6].strm0_type         =  lane6_type0         ; 
  assign strm_control[6].strm0_num_of_types =  lane6_num_of_types0 ; 
  assign strm_control[6].strm0_stagger      =  lane6_stagger0      ; 
  assign strm_control[6].strm1_type         =  lane6_type1         ; 
  assign strm_control[6].strm1_num_of_types =  lane6_num_of_types1 ; 
  assign strm_control[6].strm1_stagger      =  lane6_stagger1      ; 
  assign strm_control[7].strm0_type         =  lane7_type0         ; 
  assign strm_control[7].strm0_num_of_types =  lane7_num_of_types0 ; 
  assign strm_control[7].strm0_stagger      =  lane7_stagger0      ; 
  assign strm_control[7].strm1_type         =  lane7_type1         ; 
  assign strm_control[7].strm1_num_of_types =  lane7_num_of_types1 ; 
  assign strm_control[7].strm1_stagger      =  lane7_stagger1      ; 
  assign strm_control[8].strm0_type         =  lane8_type0         ; 
  assign strm_control[8].strm0_num_of_types =  lane8_num_of_types0 ; 
  assign strm_control[8].strm0_stagger      =  lane8_stagger0      ; 
  assign strm_control[8].strm1_type         =  lane8_type1         ; 
  assign strm_control[8].strm1_num_of_types =  lane8_num_of_types1 ; 
  assign strm_control[8].strm1_stagger      =  lane8_stagger1      ; 
  assign strm_control[9].strm0_type         =  lane9_type0         ; 
  assign strm_control[9].strm0_num_of_types =  lane9_num_of_types0 ; 
  assign strm_control[9].strm0_stagger      =  lane9_stagger0      ; 
  assign strm_control[9].strm1_type         =  lane9_type1         ; 
  assign strm_control[9].strm1_num_of_types =  lane9_num_of_types1 ; 
  assign strm_control[9].strm1_stagger      =  lane9_stagger1      ; 
  assign strm_control[10].strm0_type         =  lane10_type0         ; 
  assign strm_control[10].strm0_num_of_types =  lane10_num_of_types0 ; 
  assign strm_control[10].strm0_stagger      =  lane10_stagger0      ; 
  assign strm_control[10].strm1_type         =  lane10_type1         ; 
  assign strm_control[10].strm1_num_of_types =  lane10_num_of_types1 ; 
  assign strm_control[10].strm1_stagger      =  lane10_stagger1      ; 
  assign strm_control[11].strm0_type         =  lane11_type0         ; 
  assign strm_control[11].strm0_num_of_types =  lane11_num_of_types0 ; 
  assign strm_control[11].strm0_stagger      =  lane11_stagger0      ; 
  assign strm_control[11].strm1_type         =  lane11_type1         ; 
  assign strm_control[11].strm1_num_of_types =  lane11_num_of_types1 ; 
  assign strm_control[11].strm1_stagger      =  lane11_stagger1      ; 
  assign strm_control[12].strm0_type         =  lane12_type0         ; 
  assign strm_control[12].strm0_num_of_types =  lane12_num_of_types0 ; 
  assign strm_control[12].strm0_stagger      =  lane12_stagger0      ; 
  assign strm_control[12].strm1_type         =  lane12_type1         ; 
  assign strm_control[12].strm1_num_of_types =  lane12_num_of_types1 ; 
  assign strm_control[12].strm1_stagger      =  lane12_stagger1      ; 
  assign strm_control[13].strm0_type         =  lane13_type0         ; 
  assign strm_control[13].strm0_num_of_types =  lane13_num_of_types0 ; 
  assign strm_control[13].strm0_stagger      =  lane13_stagger0      ; 
  assign strm_control[13].strm1_type         =  lane13_type1         ; 
  assign strm_control[13].strm1_num_of_types =  lane13_num_of_types1 ; 
  assign strm_control[13].strm1_stagger      =  lane13_stagger1      ; 
  assign strm_control[14].strm0_type         =  lane14_type0         ; 
  assign strm_control[14].strm0_num_of_types =  lane14_num_of_types0 ; 
  assign strm_control[14].strm0_stagger      =  lane14_stagger0      ; 
  assign strm_control[14].strm1_type         =  lane14_type1         ; 
  assign strm_control[14].strm1_num_of_types =  lane14_num_of_types1 ; 
  assign strm_control[14].strm1_stagger      =  lane14_stagger1      ; 
  assign strm_control[15].strm0_type         =  lane15_type0         ; 
  assign strm_control[15].strm0_num_of_types =  lane15_num_of_types0 ; 
  assign strm_control[15].strm0_stagger      =  lane15_stagger0      ; 
  assign strm_control[15].strm1_type         =  lane15_type1         ; 
  assign strm_control[15].strm1_num_of_types =  lane15_num_of_types1 ; 
  assign strm_control[15].strm1_stagger      =  lane15_stagger1      ; 
  assign strm_control[16].strm0_type         =  lane16_type0         ; 
  assign strm_control[16].strm0_num_of_types =  lane16_num_of_types0 ; 
  assign strm_control[16].strm0_stagger      =  lane16_stagger0      ; 
  assign strm_control[16].strm1_type         =  lane16_type1         ; 
  assign strm_control[16].strm1_num_of_types =  lane16_num_of_types1 ; 
  assign strm_control[16].strm1_stagger      =  lane16_stagger1      ; 
  assign strm_control[17].strm0_type         =  lane17_type0         ; 
  assign strm_control[17].strm0_num_of_types =  lane17_num_of_types0 ; 
  assign strm_control[17].strm0_stagger      =  lane17_stagger0      ; 
  assign strm_control[17].strm1_type         =  lane17_type1         ; 
  assign strm_control[17].strm1_num_of_types =  lane17_num_of_types1 ; 
  assign strm_control[17].strm1_stagger      =  lane17_stagger1      ; 
  assign strm_control[18].strm0_type         =  lane18_type0         ; 
  assign strm_control[18].strm0_num_of_types =  lane18_num_of_types0 ; 
  assign strm_control[18].strm0_stagger      =  lane18_stagger0      ; 
  assign strm_control[18].strm1_type         =  lane18_type1         ; 
  assign strm_control[18].strm1_num_of_types =  lane18_num_of_types1 ; 
  assign strm_control[18].strm1_stagger      =  lane18_stagger1      ; 
  assign strm_control[19].strm0_type         =  lane19_type0         ; 
  assign strm_control[19].strm0_num_of_types =  lane19_num_of_types0 ; 
  assign strm_control[19].strm0_stagger      =  lane19_stagger0      ; 
  assign strm_control[19].strm1_type         =  lane19_type1         ; 
  assign strm_control[19].strm1_num_of_types =  lane19_num_of_types1 ; 
  assign strm_control[19].strm1_stagger      =  lane19_stagger1      ; 
  assign strm_control[20].strm0_type         =  lane20_type0         ; 
  assign strm_control[20].strm0_num_of_types =  lane20_num_of_types0 ; 
  assign strm_control[20].strm0_stagger      =  lane20_stagger0      ; 
  assign strm_control[20].strm1_type         =  lane20_type1         ; 
  assign strm_control[20].strm1_num_of_types =  lane20_num_of_types1 ; 
  assign strm_control[20].strm1_stagger      =  lane20_stagger1      ; 
  assign strm_control[21].strm0_type         =  lane21_type0         ; 
  assign strm_control[21].strm0_num_of_types =  lane21_num_of_types0 ; 
  assign strm_control[21].strm0_stagger      =  lane21_stagger0      ; 
  assign strm_control[21].strm1_type         =  lane21_type1         ; 
  assign strm_control[21].strm1_num_of_types =  lane21_num_of_types1 ; 
  assign strm_control[21].strm1_stagger      =  lane21_stagger1      ; 
  assign strm_control[22].strm0_type         =  lane22_type0         ; 
  assign strm_control[22].strm0_num_of_types =  lane22_num_of_types0 ; 
  assign strm_control[22].strm0_stagger      =  lane22_stagger0      ; 
  assign strm_control[22].strm1_type         =  lane22_type1         ; 
  assign strm_control[22].strm1_num_of_types =  lane22_num_of_types1 ; 
  assign strm_control[22].strm1_stagger      =  lane22_stagger1      ; 
  assign strm_control[23].strm0_type         =  lane23_type0         ; 
  assign strm_control[23].strm0_num_of_types =  lane23_num_of_types0 ; 
  assign strm_control[23].strm0_stagger      =  lane23_stagger0      ; 
  assign strm_control[23].strm1_type         =  lane23_type1         ; 
  assign strm_control[23].strm1_num_of_types =  lane23_num_of_types1 ; 
  assign strm_control[23].strm1_stagger      =  lane23_stagger1      ; 
  assign strm_control[24].strm0_type         =  lane24_type0         ; 
  assign strm_control[24].strm0_num_of_types =  lane24_num_of_types0 ; 
  assign strm_control[24].strm0_stagger      =  lane24_stagger0      ; 
  assign strm_control[24].strm1_type         =  lane24_type1         ; 
  assign strm_control[24].strm1_num_of_types =  lane24_num_of_types1 ; 
  assign strm_control[24].strm1_stagger      =  lane24_stagger1      ; 
  assign strm_control[25].strm0_type         =  lane25_type0         ; 
  assign strm_control[25].strm0_num_of_types =  lane25_num_of_types0 ; 
  assign strm_control[25].strm0_stagger      =  lane25_stagger0      ; 
  assign strm_control[25].strm1_type         =  lane25_type1         ; 
  assign strm_control[25].strm1_num_of_types =  lane25_num_of_types1 ; 
  assign strm_control[25].strm1_stagger      =  lane25_stagger1      ; 
  assign strm_control[26].strm0_type         =  lane26_type0         ; 
  assign strm_control[26].strm0_num_of_types =  lane26_num_of_types0 ; 
  assign strm_control[26].strm0_stagger      =  lane26_stagger0      ; 
  assign strm_control[26].strm1_type         =  lane26_type1         ; 
  assign strm_control[26].strm1_num_of_types =  lane26_num_of_types1 ; 
  assign strm_control[26].strm1_stagger      =  lane26_stagger1      ; 
  assign strm_control[27].strm0_type         =  lane27_type0         ; 
  assign strm_control[27].strm0_num_of_types =  lane27_num_of_types0 ; 
  assign strm_control[27].strm0_stagger      =  lane27_stagger0      ; 
  assign strm_control[27].strm1_type         =  lane27_type1         ; 
  assign strm_control[27].strm1_num_of_types =  lane27_num_of_types1 ; 
  assign strm_control[27].strm1_stagger      =  lane27_stagger1      ; 
  assign strm_control[28].strm0_type         =  lane28_type0         ; 
  assign strm_control[28].strm0_num_of_types =  lane28_num_of_types0 ; 
  assign strm_control[28].strm0_stagger      =  lane28_stagger0      ; 
  assign strm_control[28].strm1_type         =  lane28_type1         ; 
  assign strm_control[28].strm1_num_of_types =  lane28_num_of_types1 ; 
  assign strm_control[28].strm1_stagger      =  lane28_stagger1      ; 
  assign strm_control[29].strm0_type         =  lane29_type0         ; 
  assign strm_control[29].strm0_num_of_types =  lane29_num_of_types0 ; 
  assign strm_control[29].strm0_stagger      =  lane29_stagger0      ; 
  assign strm_control[29].strm1_type         =  lane29_type1         ; 
  assign strm_control[29].strm1_num_of_types =  lane29_num_of_types1 ; 
  assign strm_control[29].strm1_stagger      =  lane29_stagger1      ; 
  assign strm_control[30].strm0_type         =  lane30_type0         ; 
  assign strm_control[30].strm0_num_of_types =  lane30_num_of_types0 ; 
  assign strm_control[30].strm0_stagger      =  lane30_stagger0      ; 
  assign strm_control[30].strm1_type         =  lane30_type1         ; 
  assign strm_control[30].strm1_num_of_types =  lane30_num_of_types1 ; 
  assign strm_control[30].strm1_stagger      =  lane30_stagger1      ; 
  assign strm_control[31].strm0_type         =  lane31_type0         ; 
  assign strm_control[31].strm0_num_of_types =  lane31_num_of_types0 ; 
  assign strm_control[31].strm0_stagger      =  lane31_stagger0      ; 
  assign strm_control[31].strm1_type         =  lane31_type1         ; 
  assign strm_control[31].strm1_num_of_types =  lane31_num_of_types1 ; 
  assign strm_control[31].strm1_stagger      =  lane31_stagger1      ; 
  assign strms_completed = 
               (strm_control[0].strm_complete | ~exec_lane_active[0]) & 
               (strm_control[1].strm_complete | ~exec_lane_active[1]) & 
               (strm_control[2].strm_complete | ~exec_lane_active[2]) & 
               (strm_control[3].strm_complete | ~exec_lane_active[3]) & 
               (strm_control[4].strm_complete | ~exec_lane_active[4]) & 
               (strm_control[5].strm_complete | ~exec_lane_active[5]) & 
               (strm_control[6].strm_complete | ~exec_lane_active[6]) & 
               (strm_control[7].strm_complete | ~exec_lane_active[7]) & 
               (strm_control[8].strm_complete | ~exec_lane_active[8]) & 
               (strm_control[9].strm_complete | ~exec_lane_active[9]) & 
               (strm_control[10].strm_complete | ~exec_lane_active[10]) & 
               (strm_control[11].strm_complete | ~exec_lane_active[11]) & 
               (strm_control[12].strm_complete | ~exec_lane_active[12]) & 
               (strm_control[13].strm_complete | ~exec_lane_active[13]) & 
               (strm_control[14].strm_complete | ~exec_lane_active[14]) & 
               (strm_control[15].strm_complete | ~exec_lane_active[15]) & 
               (strm_control[16].strm_complete | ~exec_lane_active[16]) & 
               (strm_control[17].strm_complete | ~exec_lane_active[17]) & 
               (strm_control[18].strm_complete | ~exec_lane_active[18]) & 
               (strm_control[19].strm_complete | ~exec_lane_active[19]) & 
               (strm_control[20].strm_complete | ~exec_lane_active[20]) & 
               (strm_control[21].strm_complete | ~exec_lane_active[21]) & 
               (strm_control[22].strm_complete | ~exec_lane_active[22]) & 
               (strm_control[23].strm_complete | ~exec_lane_active[23]) & 
               (strm_control[24].strm_complete | ~exec_lane_active[24]) & 
               (strm_control[25].strm_complete | ~exec_lane_active[25]) & 
               (strm_control[26].strm_complete | ~exec_lane_active[26]) & 
               (strm_control[27].strm_complete | ~exec_lane_active[27]) & 
               (strm_control[28].strm_complete | ~exec_lane_active[28]) & 
               (strm_control[29].strm_complete | ~exec_lane_active[29]) & 
               (strm_control[30].strm_complete | ~exec_lane_active[30]) & 
               (strm_control[31].strm_complete | ~exec_lane_active[31]) ; 

  assign  lane0_strm0_read_start_peId  = lane0_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane0_strm1_read_start_peId  = lane0_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane0_strm0_write_start_peId = lane0_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane0_strm1_write_start_peId = lane0_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane1_strm0_read_start_peId  = lane1_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane1_strm1_read_start_peId  = lane1_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane1_strm0_write_start_peId = lane1_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane1_strm1_write_start_peId = lane1_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane2_strm0_read_start_peId  = lane2_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane2_strm1_read_start_peId  = lane2_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane2_strm0_write_start_peId = lane2_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane2_strm1_write_start_peId = lane2_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane3_strm0_read_start_peId  = lane3_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane3_strm1_read_start_peId  = lane3_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane3_strm0_write_start_peId = lane3_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane3_strm1_write_start_peId = lane3_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane4_strm0_read_start_peId  = lane4_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane4_strm1_read_start_peId  = lane4_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane4_strm0_write_start_peId = lane4_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane4_strm1_write_start_peId = lane4_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane5_strm0_read_start_peId  = lane5_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane5_strm1_read_start_peId  = lane5_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane5_strm0_write_start_peId = lane5_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane5_strm1_write_start_peId = lane5_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane6_strm0_read_start_peId  = lane6_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane6_strm1_read_start_peId  = lane6_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane6_strm0_write_start_peId = lane6_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane6_strm1_write_start_peId = lane6_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane7_strm0_read_start_peId  = lane7_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane7_strm1_read_start_peId  = lane7_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane7_strm0_write_start_peId = lane7_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane7_strm1_write_start_peId = lane7_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane8_strm0_read_start_peId  = lane8_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane8_strm1_read_start_peId  = lane8_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane8_strm0_write_start_peId = lane8_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane8_strm1_write_start_peId = lane8_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane9_strm0_read_start_peId  = lane9_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane9_strm1_read_start_peId  = lane9_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane9_strm0_write_start_peId = lane9_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane9_strm1_write_start_peId = lane9_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane10_strm0_read_start_peId  = lane10_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane10_strm1_read_start_peId  = lane10_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane10_strm0_write_start_peId = lane10_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane10_strm1_write_start_peId = lane10_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane11_strm0_read_start_peId  = lane11_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane11_strm1_read_start_peId  = lane11_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane11_strm0_write_start_peId = lane11_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane11_strm1_write_start_peId = lane11_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane12_strm0_read_start_peId  = lane12_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane12_strm1_read_start_peId  = lane12_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane12_strm0_write_start_peId = lane12_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane12_strm1_write_start_peId = lane12_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane13_strm0_read_start_peId  = lane13_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane13_strm1_read_start_peId  = lane13_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane13_strm0_write_start_peId = lane13_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane13_strm1_write_start_peId = lane13_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane14_strm0_read_start_peId  = lane14_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane14_strm1_read_start_peId  = lane14_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane14_strm0_write_start_peId = lane14_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane14_strm1_write_start_peId = lane14_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane15_strm0_read_start_peId  = lane15_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane15_strm1_read_start_peId  = lane15_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane15_strm0_write_start_peId = lane15_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane15_strm1_write_start_peId = lane15_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane16_strm0_read_start_peId  = lane16_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane16_strm1_read_start_peId  = lane16_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane16_strm0_write_start_peId = lane16_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane16_strm1_write_start_peId = lane16_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane17_strm0_read_start_peId  = lane17_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane17_strm1_read_start_peId  = lane17_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane17_strm0_write_start_peId = lane17_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane17_strm1_write_start_peId = lane17_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane18_strm0_read_start_peId  = lane18_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane18_strm1_read_start_peId  = lane18_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane18_strm0_write_start_peId = lane18_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane18_strm1_write_start_peId = lane18_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane19_strm0_read_start_peId  = lane19_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane19_strm1_read_start_peId  = lane19_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane19_strm0_write_start_peId = lane19_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane19_strm1_write_start_peId = lane19_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane20_strm0_read_start_peId  = lane20_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane20_strm1_read_start_peId  = lane20_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane20_strm0_write_start_peId = lane20_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane20_strm1_write_start_peId = lane20_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane21_strm0_read_start_peId  = lane21_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane21_strm1_read_start_peId  = lane21_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane21_strm0_write_start_peId = lane21_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane21_strm1_write_start_peId = lane21_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane22_strm0_read_start_peId  = lane22_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane22_strm1_read_start_peId  = lane22_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane22_strm0_write_start_peId = lane22_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane22_strm1_write_start_peId = lane22_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane23_strm0_read_start_peId  = lane23_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane23_strm1_read_start_peId  = lane23_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane23_strm0_write_start_peId = lane23_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane23_strm1_write_start_peId = lane23_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane24_strm0_read_start_peId  = lane24_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane24_strm1_read_start_peId  = lane24_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane24_strm0_write_start_peId = lane24_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane24_strm1_write_start_peId = lane24_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane25_strm0_read_start_peId  = lane25_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane25_strm1_read_start_peId  = lane25_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane25_strm0_write_start_peId = lane25_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane25_strm1_write_start_peId = lane25_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane26_strm0_read_start_peId  = lane26_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane26_strm1_read_start_peId  = lane26_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane26_strm0_write_start_peId = lane26_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane26_strm1_write_start_peId = lane26_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane27_strm0_read_start_peId  = lane27_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane27_strm1_read_start_peId  = lane27_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane27_strm0_write_start_peId = lane27_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane27_strm1_write_start_peId = lane27_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane28_strm0_read_start_peId  = lane28_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane28_strm1_read_start_peId  = lane28_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane28_strm0_write_start_peId = lane28_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane28_strm1_write_start_peId = lane28_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane29_strm0_read_start_peId  = lane29_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane29_strm1_read_start_peId  = lane29_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane29_strm0_write_start_peId = lane29_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane29_strm1_write_start_peId = lane29_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane30_strm0_read_start_peId  = lane30_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane30_strm1_read_start_peId  = lane30_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane30_strm0_write_start_peId = lane30_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane30_strm1_write_start_peId = lane30_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane31_strm0_read_start_peId  = lane31_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane31_strm1_read_start_peId  = lane31_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane31_strm0_write_start_peId = lane31_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;
  assign  lane31_strm1_write_start_peId = lane31_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;

  assign strm_control[0].lane_enable  =  exec_lane_active[0]  ; 
  assign strm_control[1].lane_enable  =  exec_lane_active[1]  ; 
  assign strm_control[2].lane_enable  =  exec_lane_active[2]  ; 
  assign strm_control[3].lane_enable  =  exec_lane_active[3]  ; 
  assign strm_control[4].lane_enable  =  exec_lane_active[4]  ; 
  assign strm_control[5].lane_enable  =  exec_lane_active[5]  ; 
  assign strm_control[6].lane_enable  =  exec_lane_active[6]  ; 
  assign strm_control[7].lane_enable  =  exec_lane_active[7]  ; 
  assign strm_control[8].lane_enable  =  exec_lane_active[8]  ; 
  assign strm_control[9].lane_enable  =  exec_lane_active[9]  ; 
  assign strm_control[10].lane_enable  =  exec_lane_active[10]  ; 
  assign strm_control[11].lane_enable  =  exec_lane_active[11]  ; 
  assign strm_control[12].lane_enable  =  exec_lane_active[12]  ; 
  assign strm_control[13].lane_enable  =  exec_lane_active[13]  ; 
  assign strm_control[14].lane_enable  =  exec_lane_active[14]  ; 
  assign strm_control[15].lane_enable  =  exec_lane_active[15]  ; 
  assign strm_control[16].lane_enable  =  exec_lane_active[16]  ; 
  assign strm_control[17].lane_enable  =  exec_lane_active[17]  ; 
  assign strm_control[18].lane_enable  =  exec_lane_active[18]  ; 
  assign strm_control[19].lane_enable  =  exec_lane_active[19]  ; 
  assign strm_control[20].lane_enable  =  exec_lane_active[20]  ; 
  assign strm_control[21].lane_enable  =  exec_lane_active[21]  ; 
  assign strm_control[22].lane_enable  =  exec_lane_active[22]  ; 
  assign strm_control[23].lane_enable  =  exec_lane_active[23]  ; 
  assign strm_control[24].lane_enable  =  exec_lane_active[24]  ; 
  assign strm_control[25].lane_enable  =  exec_lane_active[25]  ; 
  assign strm_control[26].lane_enable  =  exec_lane_active[26]  ; 
  assign strm_control[27].lane_enable  =  exec_lane_active[27]  ; 
  assign strm_control[28].lane_enable  =  exec_lane_active[28]  ; 
  assign strm_control[29].lane_enable  =  exec_lane_active[29]  ; 
  assign strm_control[30].lane_enable  =  exec_lane_active[30]  ; 
  assign strm_control[31].lane_enable  =  exec_lane_active[31]  ; 

  assign strm_control[0].strm0_read_peId  =  lane0_strm0_read_start_peId  ; 
  assign strm_control[0].strm0_write_peId =  lane0_strm0_write_start_peId ; 
  assign strm_control[0].strm1_read_peId  =  lane0_strm1_read_start_peId  ; 
  assign strm_control[0].strm1_write_peId =  lane0_strm1_write_start_peId ; 
  assign strm_control[1].strm0_read_peId  =  lane1_strm0_read_start_peId  ; 
  assign strm_control[1].strm0_write_peId =  lane1_strm0_write_start_peId ; 
  assign strm_control[1].strm1_read_peId  =  lane1_strm1_read_start_peId  ; 
  assign strm_control[1].strm1_write_peId =  lane1_strm1_write_start_peId ; 
  assign strm_control[2].strm0_read_peId  =  lane2_strm0_read_start_peId  ; 
  assign strm_control[2].strm0_write_peId =  lane2_strm0_write_start_peId ; 
  assign strm_control[2].strm1_read_peId  =  lane2_strm1_read_start_peId  ; 
  assign strm_control[2].strm1_write_peId =  lane2_strm1_write_start_peId ; 
  assign strm_control[3].strm0_read_peId  =  lane3_strm0_read_start_peId  ; 
  assign strm_control[3].strm0_write_peId =  lane3_strm0_write_start_peId ; 
  assign strm_control[3].strm1_read_peId  =  lane3_strm1_read_start_peId  ; 
  assign strm_control[3].strm1_write_peId =  lane3_strm1_write_start_peId ; 
  assign strm_control[4].strm0_read_peId  =  lane4_strm0_read_start_peId  ; 
  assign strm_control[4].strm0_write_peId =  lane4_strm0_write_start_peId ; 
  assign strm_control[4].strm1_read_peId  =  lane4_strm1_read_start_peId  ; 
  assign strm_control[4].strm1_write_peId =  lane4_strm1_write_start_peId ; 
  assign strm_control[5].strm0_read_peId  =  lane5_strm0_read_start_peId  ; 
  assign strm_control[5].strm0_write_peId =  lane5_strm0_write_start_peId ; 
  assign strm_control[5].strm1_read_peId  =  lane5_strm1_read_start_peId  ; 
  assign strm_control[5].strm1_write_peId =  lane5_strm1_write_start_peId ; 
  assign strm_control[6].strm0_read_peId  =  lane6_strm0_read_start_peId  ; 
  assign strm_control[6].strm0_write_peId =  lane6_strm0_write_start_peId ; 
  assign strm_control[6].strm1_read_peId  =  lane6_strm1_read_start_peId  ; 
  assign strm_control[6].strm1_write_peId =  lane6_strm1_write_start_peId ; 
  assign strm_control[7].strm0_read_peId  =  lane7_strm0_read_start_peId  ; 
  assign strm_control[7].strm0_write_peId =  lane7_strm0_write_start_peId ; 
  assign strm_control[7].strm1_read_peId  =  lane7_strm1_read_start_peId  ; 
  assign strm_control[7].strm1_write_peId =  lane7_strm1_write_start_peId ; 
  assign strm_control[8].strm0_read_peId  =  lane8_strm0_read_start_peId  ; 
  assign strm_control[8].strm0_write_peId =  lane8_strm0_write_start_peId ; 
  assign strm_control[8].strm1_read_peId  =  lane8_strm1_read_start_peId  ; 
  assign strm_control[8].strm1_write_peId =  lane8_strm1_write_start_peId ; 
  assign strm_control[9].strm0_read_peId  =  lane9_strm0_read_start_peId  ; 
  assign strm_control[9].strm0_write_peId =  lane9_strm0_write_start_peId ; 
  assign strm_control[9].strm1_read_peId  =  lane9_strm1_read_start_peId  ; 
  assign strm_control[9].strm1_write_peId =  lane9_strm1_write_start_peId ; 
  assign strm_control[10].strm0_read_peId  =  lane10_strm0_read_start_peId  ; 
  assign strm_control[10].strm0_write_peId =  lane10_strm0_write_start_peId ; 
  assign strm_control[10].strm1_read_peId  =  lane10_strm1_read_start_peId  ; 
  assign strm_control[10].strm1_write_peId =  lane10_strm1_write_start_peId ; 
  assign strm_control[11].strm0_read_peId  =  lane11_strm0_read_start_peId  ; 
  assign strm_control[11].strm0_write_peId =  lane11_strm0_write_start_peId ; 
  assign strm_control[11].strm1_read_peId  =  lane11_strm1_read_start_peId  ; 
  assign strm_control[11].strm1_write_peId =  lane11_strm1_write_start_peId ; 
  assign strm_control[12].strm0_read_peId  =  lane12_strm0_read_start_peId  ; 
  assign strm_control[12].strm0_write_peId =  lane12_strm0_write_start_peId ; 
  assign strm_control[12].strm1_read_peId  =  lane12_strm1_read_start_peId  ; 
  assign strm_control[12].strm1_write_peId =  lane12_strm1_write_start_peId ; 
  assign strm_control[13].strm0_read_peId  =  lane13_strm0_read_start_peId  ; 
  assign strm_control[13].strm0_write_peId =  lane13_strm0_write_start_peId ; 
  assign strm_control[13].strm1_read_peId  =  lane13_strm1_read_start_peId  ; 
  assign strm_control[13].strm1_write_peId =  lane13_strm1_write_start_peId ; 
  assign strm_control[14].strm0_read_peId  =  lane14_strm0_read_start_peId  ; 
  assign strm_control[14].strm0_write_peId =  lane14_strm0_write_start_peId ; 
  assign strm_control[14].strm1_read_peId  =  lane14_strm1_read_start_peId  ; 
  assign strm_control[14].strm1_write_peId =  lane14_strm1_write_start_peId ; 
  assign strm_control[15].strm0_read_peId  =  lane15_strm0_read_start_peId  ; 
  assign strm_control[15].strm0_write_peId =  lane15_strm0_write_start_peId ; 
  assign strm_control[15].strm1_read_peId  =  lane15_strm1_read_start_peId  ; 
  assign strm_control[15].strm1_write_peId =  lane15_strm1_write_start_peId ; 
  assign strm_control[16].strm0_read_peId  =  lane16_strm0_read_start_peId  ; 
  assign strm_control[16].strm0_write_peId =  lane16_strm0_write_start_peId ; 
  assign strm_control[16].strm1_read_peId  =  lane16_strm1_read_start_peId  ; 
  assign strm_control[16].strm1_write_peId =  lane16_strm1_write_start_peId ; 
  assign strm_control[17].strm0_read_peId  =  lane17_strm0_read_start_peId  ; 
  assign strm_control[17].strm0_write_peId =  lane17_strm0_write_start_peId ; 
  assign strm_control[17].strm1_read_peId  =  lane17_strm1_read_start_peId  ; 
  assign strm_control[17].strm1_write_peId =  lane17_strm1_write_start_peId ; 
  assign strm_control[18].strm0_read_peId  =  lane18_strm0_read_start_peId  ; 
  assign strm_control[18].strm0_write_peId =  lane18_strm0_write_start_peId ; 
  assign strm_control[18].strm1_read_peId  =  lane18_strm1_read_start_peId  ; 
  assign strm_control[18].strm1_write_peId =  lane18_strm1_write_start_peId ; 
  assign strm_control[19].strm0_read_peId  =  lane19_strm0_read_start_peId  ; 
  assign strm_control[19].strm0_write_peId =  lane19_strm0_write_start_peId ; 
  assign strm_control[19].strm1_read_peId  =  lane19_strm1_read_start_peId  ; 
  assign strm_control[19].strm1_write_peId =  lane19_strm1_write_start_peId ; 
  assign strm_control[20].strm0_read_peId  =  lane20_strm0_read_start_peId  ; 
  assign strm_control[20].strm0_write_peId =  lane20_strm0_write_start_peId ; 
  assign strm_control[20].strm1_read_peId  =  lane20_strm1_read_start_peId  ; 
  assign strm_control[20].strm1_write_peId =  lane20_strm1_write_start_peId ; 
  assign strm_control[21].strm0_read_peId  =  lane21_strm0_read_start_peId  ; 
  assign strm_control[21].strm0_write_peId =  lane21_strm0_write_start_peId ; 
  assign strm_control[21].strm1_read_peId  =  lane21_strm1_read_start_peId  ; 
  assign strm_control[21].strm1_write_peId =  lane21_strm1_write_start_peId ; 
  assign strm_control[22].strm0_read_peId  =  lane22_strm0_read_start_peId  ; 
  assign strm_control[22].strm0_write_peId =  lane22_strm0_write_start_peId ; 
  assign strm_control[22].strm1_read_peId  =  lane22_strm1_read_start_peId  ; 
  assign strm_control[22].strm1_write_peId =  lane22_strm1_write_start_peId ; 
  assign strm_control[23].strm0_read_peId  =  lane23_strm0_read_start_peId  ; 
  assign strm_control[23].strm0_write_peId =  lane23_strm0_write_start_peId ; 
  assign strm_control[23].strm1_read_peId  =  lane23_strm1_read_start_peId  ; 
  assign strm_control[23].strm1_write_peId =  lane23_strm1_write_start_peId ; 
  assign strm_control[24].strm0_read_peId  =  lane24_strm0_read_start_peId  ; 
  assign strm_control[24].strm0_write_peId =  lane24_strm0_write_start_peId ; 
  assign strm_control[24].strm1_read_peId  =  lane24_strm1_read_start_peId  ; 
  assign strm_control[24].strm1_write_peId =  lane24_strm1_write_start_peId ; 
  assign strm_control[25].strm0_read_peId  =  lane25_strm0_read_start_peId  ; 
  assign strm_control[25].strm0_write_peId =  lane25_strm0_write_start_peId ; 
  assign strm_control[25].strm1_read_peId  =  lane25_strm1_read_start_peId  ; 
  assign strm_control[25].strm1_write_peId =  lane25_strm1_write_start_peId ; 
  assign strm_control[26].strm0_read_peId  =  lane26_strm0_read_start_peId  ; 
  assign strm_control[26].strm0_write_peId =  lane26_strm0_write_start_peId ; 
  assign strm_control[26].strm1_read_peId  =  lane26_strm1_read_start_peId  ; 
  assign strm_control[26].strm1_write_peId =  lane26_strm1_write_start_peId ; 
  assign strm_control[27].strm0_read_peId  =  lane27_strm0_read_start_peId  ; 
  assign strm_control[27].strm0_write_peId =  lane27_strm0_write_start_peId ; 
  assign strm_control[27].strm1_read_peId  =  lane27_strm1_read_start_peId  ; 
  assign strm_control[27].strm1_write_peId =  lane27_strm1_write_start_peId ; 
  assign strm_control[28].strm0_read_peId  =  lane28_strm0_read_start_peId  ; 
  assign strm_control[28].strm0_write_peId =  lane28_strm0_write_start_peId ; 
  assign strm_control[28].strm1_read_peId  =  lane28_strm1_read_start_peId  ; 
  assign strm_control[28].strm1_write_peId =  lane28_strm1_write_start_peId ; 
  assign strm_control[29].strm0_read_peId  =  lane29_strm0_read_start_peId  ; 
  assign strm_control[29].strm0_write_peId =  lane29_strm0_write_start_peId ; 
  assign strm_control[29].strm1_read_peId  =  lane29_strm1_read_start_peId  ; 
  assign strm_control[29].strm1_write_peId =  lane29_strm1_write_start_peId ; 
  assign strm_control[30].strm0_read_peId  =  lane30_strm0_read_start_peId  ; 
  assign strm_control[30].strm0_write_peId =  lane30_strm0_write_start_peId ; 
  assign strm_control[30].strm1_read_peId  =  lane30_strm1_read_start_peId  ; 
  assign strm_control[30].strm1_write_peId =  lane30_strm1_write_start_peId ; 
  assign strm_control[31].strm0_read_peId  =  lane31_strm0_read_start_peId  ; 
  assign strm_control[31].strm0_write_peId =  lane31_strm0_write_start_peId ; 
  assign strm_control[31].strm1_read_peId  =  lane31_strm1_read_start_peId  ; 
  assign strm_control[31].strm1_write_peId =  lane31_strm1_write_start_peId ; 

  assign scntl__sdp__lane0_strm0_stOp_source      = strm_control[0].strm0_stOp_src  ;
  assign scntl__sdp__lane0_strm0_stOp_destination = strm_control[0].strm0_stOp_dest ;
  assign scntl__sdp__lane0_strm1_stOp_source      = strm_control[0].strm1_stOp_src  ;
  assign scntl__sdp__lane0_strm1_stOp_destination = strm_control[0].strm1_stOp_dest ;
  assign scntl__sdp__lane1_strm0_stOp_source      = strm_control[1].strm0_stOp_src  ;
  assign scntl__sdp__lane1_strm0_stOp_destination = strm_control[1].strm0_stOp_dest ;
  assign scntl__sdp__lane1_strm1_stOp_source      = strm_control[1].strm1_stOp_src  ;
  assign scntl__sdp__lane1_strm1_stOp_destination = strm_control[1].strm1_stOp_dest ;
  assign scntl__sdp__lane2_strm0_stOp_source      = strm_control[2].strm0_stOp_src  ;
  assign scntl__sdp__lane2_strm0_stOp_destination = strm_control[2].strm0_stOp_dest ;
  assign scntl__sdp__lane2_strm1_stOp_source      = strm_control[2].strm1_stOp_src  ;
  assign scntl__sdp__lane2_strm1_stOp_destination = strm_control[2].strm1_stOp_dest ;
  assign scntl__sdp__lane3_strm0_stOp_source      = strm_control[3].strm0_stOp_src  ;
  assign scntl__sdp__lane3_strm0_stOp_destination = strm_control[3].strm0_stOp_dest ;
  assign scntl__sdp__lane3_strm1_stOp_source      = strm_control[3].strm1_stOp_src  ;
  assign scntl__sdp__lane3_strm1_stOp_destination = strm_control[3].strm1_stOp_dest ;
  assign scntl__sdp__lane4_strm0_stOp_source      = strm_control[4].strm0_stOp_src  ;
  assign scntl__sdp__lane4_strm0_stOp_destination = strm_control[4].strm0_stOp_dest ;
  assign scntl__sdp__lane4_strm1_stOp_source      = strm_control[4].strm1_stOp_src  ;
  assign scntl__sdp__lane4_strm1_stOp_destination = strm_control[4].strm1_stOp_dest ;
  assign scntl__sdp__lane5_strm0_stOp_source      = strm_control[5].strm0_stOp_src  ;
  assign scntl__sdp__lane5_strm0_stOp_destination = strm_control[5].strm0_stOp_dest ;
  assign scntl__sdp__lane5_strm1_stOp_source      = strm_control[5].strm1_stOp_src  ;
  assign scntl__sdp__lane5_strm1_stOp_destination = strm_control[5].strm1_stOp_dest ;
  assign scntl__sdp__lane6_strm0_stOp_source      = strm_control[6].strm0_stOp_src  ;
  assign scntl__sdp__lane6_strm0_stOp_destination = strm_control[6].strm0_stOp_dest ;
  assign scntl__sdp__lane6_strm1_stOp_source      = strm_control[6].strm1_stOp_src  ;
  assign scntl__sdp__lane6_strm1_stOp_destination = strm_control[6].strm1_stOp_dest ;
  assign scntl__sdp__lane7_strm0_stOp_source      = strm_control[7].strm0_stOp_src  ;
  assign scntl__sdp__lane7_strm0_stOp_destination = strm_control[7].strm0_stOp_dest ;
  assign scntl__sdp__lane7_strm1_stOp_source      = strm_control[7].strm1_stOp_src  ;
  assign scntl__sdp__lane7_strm1_stOp_destination = strm_control[7].strm1_stOp_dest ;
  assign scntl__sdp__lane8_strm0_stOp_source      = strm_control[8].strm0_stOp_src  ;
  assign scntl__sdp__lane8_strm0_stOp_destination = strm_control[8].strm0_stOp_dest ;
  assign scntl__sdp__lane8_strm1_stOp_source      = strm_control[8].strm1_stOp_src  ;
  assign scntl__sdp__lane8_strm1_stOp_destination = strm_control[8].strm1_stOp_dest ;
  assign scntl__sdp__lane9_strm0_stOp_source      = strm_control[9].strm0_stOp_src  ;
  assign scntl__sdp__lane9_strm0_stOp_destination = strm_control[9].strm0_stOp_dest ;
  assign scntl__sdp__lane9_strm1_stOp_source      = strm_control[9].strm1_stOp_src  ;
  assign scntl__sdp__lane9_strm1_stOp_destination = strm_control[9].strm1_stOp_dest ;
  assign scntl__sdp__lane10_strm0_stOp_source      = strm_control[10].strm0_stOp_src  ;
  assign scntl__sdp__lane10_strm0_stOp_destination = strm_control[10].strm0_stOp_dest ;
  assign scntl__sdp__lane10_strm1_stOp_source      = strm_control[10].strm1_stOp_src  ;
  assign scntl__sdp__lane10_strm1_stOp_destination = strm_control[10].strm1_stOp_dest ;
  assign scntl__sdp__lane11_strm0_stOp_source      = strm_control[11].strm0_stOp_src  ;
  assign scntl__sdp__lane11_strm0_stOp_destination = strm_control[11].strm0_stOp_dest ;
  assign scntl__sdp__lane11_strm1_stOp_source      = strm_control[11].strm1_stOp_src  ;
  assign scntl__sdp__lane11_strm1_stOp_destination = strm_control[11].strm1_stOp_dest ;
  assign scntl__sdp__lane12_strm0_stOp_source      = strm_control[12].strm0_stOp_src  ;
  assign scntl__sdp__lane12_strm0_stOp_destination = strm_control[12].strm0_stOp_dest ;
  assign scntl__sdp__lane12_strm1_stOp_source      = strm_control[12].strm1_stOp_src  ;
  assign scntl__sdp__lane12_strm1_stOp_destination = strm_control[12].strm1_stOp_dest ;
  assign scntl__sdp__lane13_strm0_stOp_source      = strm_control[13].strm0_stOp_src  ;
  assign scntl__sdp__lane13_strm0_stOp_destination = strm_control[13].strm0_stOp_dest ;
  assign scntl__sdp__lane13_strm1_stOp_source      = strm_control[13].strm1_stOp_src  ;
  assign scntl__sdp__lane13_strm1_stOp_destination = strm_control[13].strm1_stOp_dest ;
  assign scntl__sdp__lane14_strm0_stOp_source      = strm_control[14].strm0_stOp_src  ;
  assign scntl__sdp__lane14_strm0_stOp_destination = strm_control[14].strm0_stOp_dest ;
  assign scntl__sdp__lane14_strm1_stOp_source      = strm_control[14].strm1_stOp_src  ;
  assign scntl__sdp__lane14_strm1_stOp_destination = strm_control[14].strm1_stOp_dest ;
  assign scntl__sdp__lane15_strm0_stOp_source      = strm_control[15].strm0_stOp_src  ;
  assign scntl__sdp__lane15_strm0_stOp_destination = strm_control[15].strm0_stOp_dest ;
  assign scntl__sdp__lane15_strm1_stOp_source      = strm_control[15].strm1_stOp_src  ;
  assign scntl__sdp__lane15_strm1_stOp_destination = strm_control[15].strm1_stOp_dest ;
  assign scntl__sdp__lane16_strm0_stOp_source      = strm_control[16].strm0_stOp_src  ;
  assign scntl__sdp__lane16_strm0_stOp_destination = strm_control[16].strm0_stOp_dest ;
  assign scntl__sdp__lane16_strm1_stOp_source      = strm_control[16].strm1_stOp_src  ;
  assign scntl__sdp__lane16_strm1_stOp_destination = strm_control[16].strm1_stOp_dest ;
  assign scntl__sdp__lane17_strm0_stOp_source      = strm_control[17].strm0_stOp_src  ;
  assign scntl__sdp__lane17_strm0_stOp_destination = strm_control[17].strm0_stOp_dest ;
  assign scntl__sdp__lane17_strm1_stOp_source      = strm_control[17].strm1_stOp_src  ;
  assign scntl__sdp__lane17_strm1_stOp_destination = strm_control[17].strm1_stOp_dest ;
  assign scntl__sdp__lane18_strm0_stOp_source      = strm_control[18].strm0_stOp_src  ;
  assign scntl__sdp__lane18_strm0_stOp_destination = strm_control[18].strm0_stOp_dest ;
  assign scntl__sdp__lane18_strm1_stOp_source      = strm_control[18].strm1_stOp_src  ;
  assign scntl__sdp__lane18_strm1_stOp_destination = strm_control[18].strm1_stOp_dest ;
  assign scntl__sdp__lane19_strm0_stOp_source      = strm_control[19].strm0_stOp_src  ;
  assign scntl__sdp__lane19_strm0_stOp_destination = strm_control[19].strm0_stOp_dest ;
  assign scntl__sdp__lane19_strm1_stOp_source      = strm_control[19].strm1_stOp_src  ;
  assign scntl__sdp__lane19_strm1_stOp_destination = strm_control[19].strm1_stOp_dest ;
  assign scntl__sdp__lane20_strm0_stOp_source      = strm_control[20].strm0_stOp_src  ;
  assign scntl__sdp__lane20_strm0_stOp_destination = strm_control[20].strm0_stOp_dest ;
  assign scntl__sdp__lane20_strm1_stOp_source      = strm_control[20].strm1_stOp_src  ;
  assign scntl__sdp__lane20_strm1_stOp_destination = strm_control[20].strm1_stOp_dest ;
  assign scntl__sdp__lane21_strm0_stOp_source      = strm_control[21].strm0_stOp_src  ;
  assign scntl__sdp__lane21_strm0_stOp_destination = strm_control[21].strm0_stOp_dest ;
  assign scntl__sdp__lane21_strm1_stOp_source      = strm_control[21].strm1_stOp_src  ;
  assign scntl__sdp__lane21_strm1_stOp_destination = strm_control[21].strm1_stOp_dest ;
  assign scntl__sdp__lane22_strm0_stOp_source      = strm_control[22].strm0_stOp_src  ;
  assign scntl__sdp__lane22_strm0_stOp_destination = strm_control[22].strm0_stOp_dest ;
  assign scntl__sdp__lane22_strm1_stOp_source      = strm_control[22].strm1_stOp_src  ;
  assign scntl__sdp__lane22_strm1_stOp_destination = strm_control[22].strm1_stOp_dest ;
  assign scntl__sdp__lane23_strm0_stOp_source      = strm_control[23].strm0_stOp_src  ;
  assign scntl__sdp__lane23_strm0_stOp_destination = strm_control[23].strm0_stOp_dest ;
  assign scntl__sdp__lane23_strm1_stOp_source      = strm_control[23].strm1_stOp_src  ;
  assign scntl__sdp__lane23_strm1_stOp_destination = strm_control[23].strm1_stOp_dest ;
  assign scntl__sdp__lane24_strm0_stOp_source      = strm_control[24].strm0_stOp_src  ;
  assign scntl__sdp__lane24_strm0_stOp_destination = strm_control[24].strm0_stOp_dest ;
  assign scntl__sdp__lane24_strm1_stOp_source      = strm_control[24].strm1_stOp_src  ;
  assign scntl__sdp__lane24_strm1_stOp_destination = strm_control[24].strm1_stOp_dest ;
  assign scntl__sdp__lane25_strm0_stOp_source      = strm_control[25].strm0_stOp_src  ;
  assign scntl__sdp__lane25_strm0_stOp_destination = strm_control[25].strm0_stOp_dest ;
  assign scntl__sdp__lane25_strm1_stOp_source      = strm_control[25].strm1_stOp_src  ;
  assign scntl__sdp__lane25_strm1_stOp_destination = strm_control[25].strm1_stOp_dest ;
  assign scntl__sdp__lane26_strm0_stOp_source      = strm_control[26].strm0_stOp_src  ;
  assign scntl__sdp__lane26_strm0_stOp_destination = strm_control[26].strm0_stOp_dest ;
  assign scntl__sdp__lane26_strm1_stOp_source      = strm_control[26].strm1_stOp_src  ;
  assign scntl__sdp__lane26_strm1_stOp_destination = strm_control[26].strm1_stOp_dest ;
  assign scntl__sdp__lane27_strm0_stOp_source      = strm_control[27].strm0_stOp_src  ;
  assign scntl__sdp__lane27_strm0_stOp_destination = strm_control[27].strm0_stOp_dest ;
  assign scntl__sdp__lane27_strm1_stOp_source      = strm_control[27].strm1_stOp_src  ;
  assign scntl__sdp__lane27_strm1_stOp_destination = strm_control[27].strm1_stOp_dest ;
  assign scntl__sdp__lane28_strm0_stOp_source      = strm_control[28].strm0_stOp_src  ;
  assign scntl__sdp__lane28_strm0_stOp_destination = strm_control[28].strm0_stOp_dest ;
  assign scntl__sdp__lane28_strm1_stOp_source      = strm_control[28].strm1_stOp_src  ;
  assign scntl__sdp__lane28_strm1_stOp_destination = strm_control[28].strm1_stOp_dest ;
  assign scntl__sdp__lane29_strm0_stOp_source      = strm_control[29].strm0_stOp_src  ;
  assign scntl__sdp__lane29_strm0_stOp_destination = strm_control[29].strm0_stOp_dest ;
  assign scntl__sdp__lane29_strm1_stOp_source      = strm_control[29].strm1_stOp_src  ;
  assign scntl__sdp__lane29_strm1_stOp_destination = strm_control[29].strm1_stOp_dest ;
  assign scntl__sdp__lane30_strm0_stOp_source      = strm_control[30].strm0_stOp_src  ;
  assign scntl__sdp__lane30_strm0_stOp_destination = strm_control[30].strm0_stOp_dest ;
  assign scntl__sdp__lane30_strm1_stOp_source      = strm_control[30].strm1_stOp_src  ;
  assign scntl__sdp__lane30_strm1_stOp_destination = strm_control[30].strm1_stOp_dest ;
  assign scntl__sdp__lane31_strm0_stOp_source      = strm_control[31].strm0_stOp_src  ;
  assign scntl__sdp__lane31_strm0_stOp_destination = strm_control[31].strm0_stOp_dest ;
  assign scntl__sdp__lane31_strm1_stOp_source      = strm_control[31].strm1_stOp_src  ;
  assign scntl__sdp__lane31_strm1_stOp_destination = strm_control[31].strm1_stOp_dest ;
