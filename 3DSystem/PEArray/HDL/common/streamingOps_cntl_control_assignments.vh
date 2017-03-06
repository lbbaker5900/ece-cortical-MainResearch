
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

  assign cntl__sdp__lane0_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane1_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane2_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane3_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane4_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane5_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane6_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane7_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane8_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane9_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane10_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane11_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane12_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane13_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane14_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane15_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane16_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane17_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane18_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane19_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane20_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane21_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane22_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane23_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane24_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane25_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane26_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane27_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane28_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane29_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane30_dma_operation = rs0[31:1]                                      ; 
  assign cntl__sdp__lane31_dma_operation = rs0[31:1]                                      ; 

  assign scntl__sdp__lane0_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane0_strm0_stOp_enable    = strm_control[0].strm0_stOp_enable     ; 
  assign strm_control[0].strm0_stOp_ready      = sdp__scntl__lane0_strm0_stOp_ready     ; 
  assign strm_control[0].strm0_stOp_complete   = sdp__scntl__lane0_strm0_stOp_complete  ; 
  assign scntl__sdp__lane0_strm1_stOp_enable    = strm_control[0].strm1_stOp_enable     ; 
  assign strm_control[0].strm1_stOp_ready      = sdp__scntl__lane0_strm1_stOp_ready     ; 
  assign strm_control[0].strm1_stOp_complete   = sdp__scntl__lane0_strm1_stOp_complete  ; 
  assign scntl__sdp__lane1_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane1_strm0_stOp_enable    = strm_control[1].strm0_stOp_enable     ; 
  assign strm_control[1].strm0_stOp_ready      = sdp__scntl__lane1_strm0_stOp_ready     ; 
  assign strm_control[1].strm0_stOp_complete   = sdp__scntl__lane1_strm0_stOp_complete  ; 
  assign scntl__sdp__lane1_strm1_stOp_enable    = strm_control[1].strm1_stOp_enable     ; 
  assign strm_control[1].strm1_stOp_ready      = sdp__scntl__lane1_strm1_stOp_ready     ; 
  assign strm_control[1].strm1_stOp_complete   = sdp__scntl__lane1_strm1_stOp_complete  ; 
  assign scntl__sdp__lane2_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane2_strm0_stOp_enable    = strm_control[2].strm0_stOp_enable     ; 
  assign strm_control[2].strm0_stOp_ready      = sdp__scntl__lane2_strm0_stOp_ready     ; 
  assign strm_control[2].strm0_stOp_complete   = sdp__scntl__lane2_strm0_stOp_complete  ; 
  assign scntl__sdp__lane2_strm1_stOp_enable    = strm_control[2].strm1_stOp_enable     ; 
  assign strm_control[2].strm1_stOp_ready      = sdp__scntl__lane2_strm1_stOp_ready     ; 
  assign strm_control[2].strm1_stOp_complete   = sdp__scntl__lane2_strm1_stOp_complete  ; 
  assign scntl__sdp__lane3_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane3_strm0_stOp_enable    = strm_control[3].strm0_stOp_enable     ; 
  assign strm_control[3].strm0_stOp_ready      = sdp__scntl__lane3_strm0_stOp_ready     ; 
  assign strm_control[3].strm0_stOp_complete   = sdp__scntl__lane3_strm0_stOp_complete  ; 
  assign scntl__sdp__lane3_strm1_stOp_enable    = strm_control[3].strm1_stOp_enable     ; 
  assign strm_control[3].strm1_stOp_ready      = sdp__scntl__lane3_strm1_stOp_ready     ; 
  assign strm_control[3].strm1_stOp_complete   = sdp__scntl__lane3_strm1_stOp_complete  ; 
  assign scntl__sdp__lane4_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane4_strm0_stOp_enable    = strm_control[4].strm0_stOp_enable     ; 
  assign strm_control[4].strm0_stOp_ready      = sdp__scntl__lane4_strm0_stOp_ready     ; 
  assign strm_control[4].strm0_stOp_complete   = sdp__scntl__lane4_strm0_stOp_complete  ; 
  assign scntl__sdp__lane4_strm1_stOp_enable    = strm_control[4].strm1_stOp_enable     ; 
  assign strm_control[4].strm1_stOp_ready      = sdp__scntl__lane4_strm1_stOp_ready     ; 
  assign strm_control[4].strm1_stOp_complete   = sdp__scntl__lane4_strm1_stOp_complete  ; 
  assign scntl__sdp__lane5_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane5_strm0_stOp_enable    = strm_control[5].strm0_stOp_enable     ; 
  assign strm_control[5].strm0_stOp_ready      = sdp__scntl__lane5_strm0_stOp_ready     ; 
  assign strm_control[5].strm0_stOp_complete   = sdp__scntl__lane5_strm0_stOp_complete  ; 
  assign scntl__sdp__lane5_strm1_stOp_enable    = strm_control[5].strm1_stOp_enable     ; 
  assign strm_control[5].strm1_stOp_ready      = sdp__scntl__lane5_strm1_stOp_ready     ; 
  assign strm_control[5].strm1_stOp_complete   = sdp__scntl__lane5_strm1_stOp_complete  ; 
  assign scntl__sdp__lane6_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane6_strm0_stOp_enable    = strm_control[6].strm0_stOp_enable     ; 
  assign strm_control[6].strm0_stOp_ready      = sdp__scntl__lane6_strm0_stOp_ready     ; 
  assign strm_control[6].strm0_stOp_complete   = sdp__scntl__lane6_strm0_stOp_complete  ; 
  assign scntl__sdp__lane6_strm1_stOp_enable    = strm_control[6].strm1_stOp_enable     ; 
  assign strm_control[6].strm1_stOp_ready      = sdp__scntl__lane6_strm1_stOp_ready     ; 
  assign strm_control[6].strm1_stOp_complete   = sdp__scntl__lane6_strm1_stOp_complete  ; 
  assign scntl__sdp__lane7_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane7_strm0_stOp_enable    = strm_control[7].strm0_stOp_enable     ; 
  assign strm_control[7].strm0_stOp_ready      = sdp__scntl__lane7_strm0_stOp_ready     ; 
  assign strm_control[7].strm0_stOp_complete   = sdp__scntl__lane7_strm0_stOp_complete  ; 
  assign scntl__sdp__lane7_strm1_stOp_enable    = strm_control[7].strm1_stOp_enable     ; 
  assign strm_control[7].strm1_stOp_ready      = sdp__scntl__lane7_strm1_stOp_ready     ; 
  assign strm_control[7].strm1_stOp_complete   = sdp__scntl__lane7_strm1_stOp_complete  ; 
  assign scntl__sdp__lane8_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane8_strm0_stOp_enable    = strm_control[8].strm0_stOp_enable     ; 
  assign strm_control[8].strm0_stOp_ready      = sdp__scntl__lane8_strm0_stOp_ready     ; 
  assign strm_control[8].strm0_stOp_complete   = sdp__scntl__lane8_strm0_stOp_complete  ; 
  assign scntl__sdp__lane8_strm1_stOp_enable    = strm_control[8].strm1_stOp_enable     ; 
  assign strm_control[8].strm1_stOp_ready      = sdp__scntl__lane8_strm1_stOp_ready     ; 
  assign strm_control[8].strm1_stOp_complete   = sdp__scntl__lane8_strm1_stOp_complete  ; 
  assign scntl__sdp__lane9_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane9_strm0_stOp_enable    = strm_control[9].strm0_stOp_enable     ; 
  assign strm_control[9].strm0_stOp_ready      = sdp__scntl__lane9_strm0_stOp_ready     ; 
  assign strm_control[9].strm0_stOp_complete   = sdp__scntl__lane9_strm0_stOp_complete  ; 
  assign scntl__sdp__lane9_strm1_stOp_enable    = strm_control[9].strm1_stOp_enable     ; 
  assign strm_control[9].strm1_stOp_ready      = sdp__scntl__lane9_strm1_stOp_ready     ; 
  assign strm_control[9].strm1_stOp_complete   = sdp__scntl__lane9_strm1_stOp_complete  ; 
  assign scntl__sdp__lane10_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane10_strm0_stOp_enable    = strm_control[10].strm0_stOp_enable     ; 
  assign strm_control[10].strm0_stOp_ready      = sdp__scntl__lane10_strm0_stOp_ready     ; 
  assign strm_control[10].strm0_stOp_complete   = sdp__scntl__lane10_strm0_stOp_complete  ; 
  assign scntl__sdp__lane10_strm1_stOp_enable    = strm_control[10].strm1_stOp_enable     ; 
  assign strm_control[10].strm1_stOp_ready      = sdp__scntl__lane10_strm1_stOp_ready     ; 
  assign strm_control[10].strm1_stOp_complete   = sdp__scntl__lane10_strm1_stOp_complete  ; 
  assign scntl__sdp__lane11_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane11_strm0_stOp_enable    = strm_control[11].strm0_stOp_enable     ; 
  assign strm_control[11].strm0_stOp_ready      = sdp__scntl__lane11_strm0_stOp_ready     ; 
  assign strm_control[11].strm0_stOp_complete   = sdp__scntl__lane11_strm0_stOp_complete  ; 
  assign scntl__sdp__lane11_strm1_stOp_enable    = strm_control[11].strm1_stOp_enable     ; 
  assign strm_control[11].strm1_stOp_ready      = sdp__scntl__lane11_strm1_stOp_ready     ; 
  assign strm_control[11].strm1_stOp_complete   = sdp__scntl__lane11_strm1_stOp_complete  ; 
  assign scntl__sdp__lane12_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane12_strm0_stOp_enable    = strm_control[12].strm0_stOp_enable     ; 
  assign strm_control[12].strm0_stOp_ready      = sdp__scntl__lane12_strm0_stOp_ready     ; 
  assign strm_control[12].strm0_stOp_complete   = sdp__scntl__lane12_strm0_stOp_complete  ; 
  assign scntl__sdp__lane12_strm1_stOp_enable    = strm_control[12].strm1_stOp_enable     ; 
  assign strm_control[12].strm1_stOp_ready      = sdp__scntl__lane12_strm1_stOp_ready     ; 
  assign strm_control[12].strm1_stOp_complete   = sdp__scntl__lane12_strm1_stOp_complete  ; 
  assign scntl__sdp__lane13_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane13_strm0_stOp_enable    = strm_control[13].strm0_stOp_enable     ; 
  assign strm_control[13].strm0_stOp_ready      = sdp__scntl__lane13_strm0_stOp_ready     ; 
  assign strm_control[13].strm0_stOp_complete   = sdp__scntl__lane13_strm0_stOp_complete  ; 
  assign scntl__sdp__lane13_strm1_stOp_enable    = strm_control[13].strm1_stOp_enable     ; 
  assign strm_control[13].strm1_stOp_ready      = sdp__scntl__lane13_strm1_stOp_ready     ; 
  assign strm_control[13].strm1_stOp_complete   = sdp__scntl__lane13_strm1_stOp_complete  ; 
  assign scntl__sdp__lane14_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane14_strm0_stOp_enable    = strm_control[14].strm0_stOp_enable     ; 
  assign strm_control[14].strm0_stOp_ready      = sdp__scntl__lane14_strm0_stOp_ready     ; 
  assign strm_control[14].strm0_stOp_complete   = sdp__scntl__lane14_strm0_stOp_complete  ; 
  assign scntl__sdp__lane14_strm1_stOp_enable    = strm_control[14].strm1_stOp_enable     ; 
  assign strm_control[14].strm1_stOp_ready      = sdp__scntl__lane14_strm1_stOp_ready     ; 
  assign strm_control[14].strm1_stOp_complete   = sdp__scntl__lane14_strm1_stOp_complete  ; 
  assign scntl__sdp__lane15_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane15_strm0_stOp_enable    = strm_control[15].strm0_stOp_enable     ; 
  assign strm_control[15].strm0_stOp_ready      = sdp__scntl__lane15_strm0_stOp_ready     ; 
  assign strm_control[15].strm0_stOp_complete   = sdp__scntl__lane15_strm0_stOp_complete  ; 
  assign scntl__sdp__lane15_strm1_stOp_enable    = strm_control[15].strm1_stOp_enable     ; 
  assign strm_control[15].strm1_stOp_ready      = sdp__scntl__lane15_strm1_stOp_ready     ; 
  assign strm_control[15].strm1_stOp_complete   = sdp__scntl__lane15_strm1_stOp_complete  ; 
  assign scntl__sdp__lane16_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane16_strm0_stOp_enable    = strm_control[16].strm0_stOp_enable     ; 
  assign strm_control[16].strm0_stOp_ready      = sdp__scntl__lane16_strm0_stOp_ready     ; 
  assign strm_control[16].strm0_stOp_complete   = sdp__scntl__lane16_strm0_stOp_complete  ; 
  assign scntl__sdp__lane16_strm1_stOp_enable    = strm_control[16].strm1_stOp_enable     ; 
  assign strm_control[16].strm1_stOp_ready      = sdp__scntl__lane16_strm1_stOp_ready     ; 
  assign strm_control[16].strm1_stOp_complete   = sdp__scntl__lane16_strm1_stOp_complete  ; 
  assign scntl__sdp__lane17_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane17_strm0_stOp_enable    = strm_control[17].strm0_stOp_enable     ; 
  assign strm_control[17].strm0_stOp_ready      = sdp__scntl__lane17_strm0_stOp_ready     ; 
  assign strm_control[17].strm0_stOp_complete   = sdp__scntl__lane17_strm0_stOp_complete  ; 
  assign scntl__sdp__lane17_strm1_stOp_enable    = strm_control[17].strm1_stOp_enable     ; 
  assign strm_control[17].strm1_stOp_ready      = sdp__scntl__lane17_strm1_stOp_ready     ; 
  assign strm_control[17].strm1_stOp_complete   = sdp__scntl__lane17_strm1_stOp_complete  ; 
  assign scntl__sdp__lane18_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane18_strm0_stOp_enable    = strm_control[18].strm0_stOp_enable     ; 
  assign strm_control[18].strm0_stOp_ready      = sdp__scntl__lane18_strm0_stOp_ready     ; 
  assign strm_control[18].strm0_stOp_complete   = sdp__scntl__lane18_strm0_stOp_complete  ; 
  assign scntl__sdp__lane18_strm1_stOp_enable    = strm_control[18].strm1_stOp_enable     ; 
  assign strm_control[18].strm1_stOp_ready      = sdp__scntl__lane18_strm1_stOp_ready     ; 
  assign strm_control[18].strm1_stOp_complete   = sdp__scntl__lane18_strm1_stOp_complete  ; 
  assign scntl__sdp__lane19_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane19_strm0_stOp_enable    = strm_control[19].strm0_stOp_enable     ; 
  assign strm_control[19].strm0_stOp_ready      = sdp__scntl__lane19_strm0_stOp_ready     ; 
  assign strm_control[19].strm0_stOp_complete   = sdp__scntl__lane19_strm0_stOp_complete  ; 
  assign scntl__sdp__lane19_strm1_stOp_enable    = strm_control[19].strm1_stOp_enable     ; 
  assign strm_control[19].strm1_stOp_ready      = sdp__scntl__lane19_strm1_stOp_ready     ; 
  assign strm_control[19].strm1_stOp_complete   = sdp__scntl__lane19_strm1_stOp_complete  ; 
  assign scntl__sdp__lane20_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane20_strm0_stOp_enable    = strm_control[20].strm0_stOp_enable     ; 
  assign strm_control[20].strm0_stOp_ready      = sdp__scntl__lane20_strm0_stOp_ready     ; 
  assign strm_control[20].strm0_stOp_complete   = sdp__scntl__lane20_strm0_stOp_complete  ; 
  assign scntl__sdp__lane20_strm1_stOp_enable    = strm_control[20].strm1_stOp_enable     ; 
  assign strm_control[20].strm1_stOp_ready      = sdp__scntl__lane20_strm1_stOp_ready     ; 
  assign strm_control[20].strm1_stOp_complete   = sdp__scntl__lane20_strm1_stOp_complete  ; 
  assign scntl__sdp__lane21_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane21_strm0_stOp_enable    = strm_control[21].strm0_stOp_enable     ; 
  assign strm_control[21].strm0_stOp_ready      = sdp__scntl__lane21_strm0_stOp_ready     ; 
  assign strm_control[21].strm0_stOp_complete   = sdp__scntl__lane21_strm0_stOp_complete  ; 
  assign scntl__sdp__lane21_strm1_stOp_enable    = strm_control[21].strm1_stOp_enable     ; 
  assign strm_control[21].strm1_stOp_ready      = sdp__scntl__lane21_strm1_stOp_ready     ; 
  assign strm_control[21].strm1_stOp_complete   = sdp__scntl__lane21_strm1_stOp_complete  ; 
  assign scntl__sdp__lane22_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane22_strm0_stOp_enable    = strm_control[22].strm0_stOp_enable     ; 
  assign strm_control[22].strm0_stOp_ready      = sdp__scntl__lane22_strm0_stOp_ready     ; 
  assign strm_control[22].strm0_stOp_complete   = sdp__scntl__lane22_strm0_stOp_complete  ; 
  assign scntl__sdp__lane22_strm1_stOp_enable    = strm_control[22].strm1_stOp_enable     ; 
  assign strm_control[22].strm1_stOp_ready      = sdp__scntl__lane22_strm1_stOp_ready     ; 
  assign strm_control[22].strm1_stOp_complete   = sdp__scntl__lane22_strm1_stOp_complete  ; 
  assign scntl__sdp__lane23_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane23_strm0_stOp_enable    = strm_control[23].strm0_stOp_enable     ; 
  assign strm_control[23].strm0_stOp_ready      = sdp__scntl__lane23_strm0_stOp_ready     ; 
  assign strm_control[23].strm0_stOp_complete   = sdp__scntl__lane23_strm0_stOp_complete  ; 
  assign scntl__sdp__lane23_strm1_stOp_enable    = strm_control[23].strm1_stOp_enable     ; 
  assign strm_control[23].strm1_stOp_ready      = sdp__scntl__lane23_strm1_stOp_ready     ; 
  assign strm_control[23].strm1_stOp_complete   = sdp__scntl__lane23_strm1_stOp_complete  ; 
  assign scntl__sdp__lane24_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane24_strm0_stOp_enable    = strm_control[24].strm0_stOp_enable     ; 
  assign strm_control[24].strm0_stOp_ready      = sdp__scntl__lane24_strm0_stOp_ready     ; 
  assign strm_control[24].strm0_stOp_complete   = sdp__scntl__lane24_strm0_stOp_complete  ; 
  assign scntl__sdp__lane24_strm1_stOp_enable    = strm_control[24].strm1_stOp_enable     ; 
  assign strm_control[24].strm1_stOp_ready      = sdp__scntl__lane24_strm1_stOp_ready     ; 
  assign strm_control[24].strm1_stOp_complete   = sdp__scntl__lane24_strm1_stOp_complete  ; 
  assign scntl__sdp__lane25_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane25_strm0_stOp_enable    = strm_control[25].strm0_stOp_enable     ; 
  assign strm_control[25].strm0_stOp_ready      = sdp__scntl__lane25_strm0_stOp_ready     ; 
  assign strm_control[25].strm0_stOp_complete   = sdp__scntl__lane25_strm0_stOp_complete  ; 
  assign scntl__sdp__lane25_strm1_stOp_enable    = strm_control[25].strm1_stOp_enable     ; 
  assign strm_control[25].strm1_stOp_ready      = sdp__scntl__lane25_strm1_stOp_ready     ; 
  assign strm_control[25].strm1_stOp_complete   = sdp__scntl__lane25_strm1_stOp_complete  ; 
  assign scntl__sdp__lane26_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane26_strm0_stOp_enable    = strm_control[26].strm0_stOp_enable     ; 
  assign strm_control[26].strm0_stOp_ready      = sdp__scntl__lane26_strm0_stOp_ready     ; 
  assign strm_control[26].strm0_stOp_complete   = sdp__scntl__lane26_strm0_stOp_complete  ; 
  assign scntl__sdp__lane26_strm1_stOp_enable    = strm_control[26].strm1_stOp_enable     ; 
  assign strm_control[26].strm1_stOp_ready      = sdp__scntl__lane26_strm1_stOp_ready     ; 
  assign strm_control[26].strm1_stOp_complete   = sdp__scntl__lane26_strm1_stOp_complete  ; 
  assign scntl__sdp__lane27_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane27_strm0_stOp_enable    = strm_control[27].strm0_stOp_enable     ; 
  assign strm_control[27].strm0_stOp_ready      = sdp__scntl__lane27_strm0_stOp_ready     ; 
  assign strm_control[27].strm0_stOp_complete   = sdp__scntl__lane27_strm0_stOp_complete  ; 
  assign scntl__sdp__lane27_strm1_stOp_enable    = strm_control[27].strm1_stOp_enable     ; 
  assign strm_control[27].strm1_stOp_ready      = sdp__scntl__lane27_strm1_stOp_ready     ; 
  assign strm_control[27].strm1_stOp_complete   = sdp__scntl__lane27_strm1_stOp_complete  ; 
  assign scntl__sdp__lane28_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane28_strm0_stOp_enable    = strm_control[28].strm0_stOp_enable     ; 
  assign strm_control[28].strm0_stOp_ready      = sdp__scntl__lane28_strm0_stOp_ready     ; 
  assign strm_control[28].strm0_stOp_complete   = sdp__scntl__lane28_strm0_stOp_complete  ; 
  assign scntl__sdp__lane28_strm1_stOp_enable    = strm_control[28].strm1_stOp_enable     ; 
  assign strm_control[28].strm1_stOp_ready      = sdp__scntl__lane28_strm1_stOp_ready     ; 
  assign strm_control[28].strm1_stOp_complete   = sdp__scntl__lane28_strm1_stOp_complete  ; 
  assign scntl__sdp__lane29_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane29_strm0_stOp_enable    = strm_control[29].strm0_stOp_enable     ; 
  assign strm_control[29].strm0_stOp_ready      = sdp__scntl__lane29_strm0_stOp_ready     ; 
  assign strm_control[29].strm0_stOp_complete   = sdp__scntl__lane29_strm0_stOp_complete  ; 
  assign scntl__sdp__lane29_strm1_stOp_enable    = strm_control[29].strm1_stOp_enable     ; 
  assign strm_control[29].strm1_stOp_ready      = sdp__scntl__lane29_strm1_stOp_ready     ; 
  assign strm_control[29].strm1_stOp_complete   = sdp__scntl__lane29_strm1_stOp_complete  ; 
  assign scntl__sdp__lane30_stOp_operation = rs0[31:1]                                      ; 
  assign scntl__sdp__lane30_strm0_stOp_enable    = strm_control[30].strm0_stOp_enable     ; 
  assign strm_control[30].strm0_stOp_ready      = sdp__scntl__lane30_strm0_stOp_ready     ; 
  assign strm_control[30].strm0_stOp_complete   = sdp__scntl__lane30_strm0_stOp_complete  ; 
  assign scntl__sdp__lane30_strm1_stOp_enable    = strm_control[30].strm1_stOp_enable     ; 
  assign strm_control[30].strm1_stOp_ready      = sdp__scntl__lane30_strm1_stOp_ready     ; 
  assign strm_control[30].strm1_stOp_complete   = sdp__scntl__lane30_strm1_stOp_complete  ; 
  assign scntl__sdp__lane31_stOp_operation = rs0[31:1]                                      ; 
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
      scntl__sdp__lane0_strm0_read_start_address  = (strm_control[0].strm0_assignedToExternalDma) ? strm_control[0].strm0_ExternalDma_read_start_address  :
                                                                                                       lane0_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane0_strm1_read_start_address  = (strm_control[0].strm1_assignedToExternalDma) ? strm_control[0].strm1_ExternalDma_read_start_address  :
                                                                                                       lane0_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane1_strm0_read_start_address  = (strm_control[1].strm0_assignedToExternalDma) ? strm_control[1].strm0_ExternalDma_read_start_address  :
                                                                                                       lane1_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane1_strm1_read_start_address  = (strm_control[1].strm1_assignedToExternalDma) ? strm_control[1].strm1_ExternalDma_read_start_address  :
                                                                                                       lane1_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane2_strm0_read_start_address  = (strm_control[2].strm0_assignedToExternalDma) ? strm_control[2].strm0_ExternalDma_read_start_address  :
                                                                                                       lane2_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane2_strm1_read_start_address  = (strm_control[2].strm1_assignedToExternalDma) ? strm_control[2].strm1_ExternalDma_read_start_address  :
                                                                                                       lane2_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane3_strm0_read_start_address  = (strm_control[3].strm0_assignedToExternalDma) ? strm_control[3].strm0_ExternalDma_read_start_address  :
                                                                                                       lane3_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane3_strm1_read_start_address  = (strm_control[3].strm1_assignedToExternalDma) ? strm_control[3].strm1_ExternalDma_read_start_address  :
                                                                                                       lane3_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane4_strm0_read_start_address  = (strm_control[4].strm0_assignedToExternalDma) ? strm_control[4].strm0_ExternalDma_read_start_address  :
                                                                                                       lane4_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane4_strm1_read_start_address  = (strm_control[4].strm1_assignedToExternalDma) ? strm_control[4].strm1_ExternalDma_read_start_address  :
                                                                                                       lane4_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane5_strm0_read_start_address  = (strm_control[5].strm0_assignedToExternalDma) ? strm_control[5].strm0_ExternalDma_read_start_address  :
                                                                                                       lane5_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane5_strm1_read_start_address  = (strm_control[5].strm1_assignedToExternalDma) ? strm_control[5].strm1_ExternalDma_read_start_address  :
                                                                                                       lane5_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane6_strm0_read_start_address  = (strm_control[6].strm0_assignedToExternalDma) ? strm_control[6].strm0_ExternalDma_read_start_address  :
                                                                                                       lane6_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane6_strm1_read_start_address  = (strm_control[6].strm1_assignedToExternalDma) ? strm_control[6].strm1_ExternalDma_read_start_address  :
                                                                                                       lane6_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane7_strm0_read_start_address  = (strm_control[7].strm0_assignedToExternalDma) ? strm_control[7].strm0_ExternalDma_read_start_address  :
                                                                                                       lane7_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane7_strm1_read_start_address  = (strm_control[7].strm1_assignedToExternalDma) ? strm_control[7].strm1_ExternalDma_read_start_address  :
                                                                                                       lane7_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane8_strm0_read_start_address  = (strm_control[8].strm0_assignedToExternalDma) ? strm_control[8].strm0_ExternalDma_read_start_address  :
                                                                                                       lane8_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane8_strm1_read_start_address  = (strm_control[8].strm1_assignedToExternalDma) ? strm_control[8].strm1_ExternalDma_read_start_address  :
                                                                                                       lane8_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane9_strm0_read_start_address  = (strm_control[9].strm0_assignedToExternalDma) ? strm_control[9].strm0_ExternalDma_read_start_address  :
                                                                                                       lane9_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane9_strm1_read_start_address  = (strm_control[9].strm1_assignedToExternalDma) ? strm_control[9].strm1_ExternalDma_read_start_address  :
                                                                                                       lane9_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane10_strm0_read_start_address  = (strm_control[10].strm0_assignedToExternalDma) ? strm_control[10].strm0_ExternalDma_read_start_address  :
                                                                                                       lane10_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane10_strm1_read_start_address  = (strm_control[10].strm1_assignedToExternalDma) ? strm_control[10].strm1_ExternalDma_read_start_address  :
                                                                                                       lane10_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane11_strm0_read_start_address  = (strm_control[11].strm0_assignedToExternalDma) ? strm_control[11].strm0_ExternalDma_read_start_address  :
                                                                                                       lane11_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane11_strm1_read_start_address  = (strm_control[11].strm1_assignedToExternalDma) ? strm_control[11].strm1_ExternalDma_read_start_address  :
                                                                                                       lane11_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane12_strm0_read_start_address  = (strm_control[12].strm0_assignedToExternalDma) ? strm_control[12].strm0_ExternalDma_read_start_address  :
                                                                                                       lane12_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane12_strm1_read_start_address  = (strm_control[12].strm1_assignedToExternalDma) ? strm_control[12].strm1_ExternalDma_read_start_address  :
                                                                                                       lane12_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane13_strm0_read_start_address  = (strm_control[13].strm0_assignedToExternalDma) ? strm_control[13].strm0_ExternalDma_read_start_address  :
                                                                                                       lane13_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane13_strm1_read_start_address  = (strm_control[13].strm1_assignedToExternalDma) ? strm_control[13].strm1_ExternalDma_read_start_address  :
                                                                                                       lane13_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane14_strm0_read_start_address  = (strm_control[14].strm0_assignedToExternalDma) ? strm_control[14].strm0_ExternalDma_read_start_address  :
                                                                                                       lane14_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane14_strm1_read_start_address  = (strm_control[14].strm1_assignedToExternalDma) ? strm_control[14].strm1_ExternalDma_read_start_address  :
                                                                                                       lane14_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane15_strm0_read_start_address  = (strm_control[15].strm0_assignedToExternalDma) ? strm_control[15].strm0_ExternalDma_read_start_address  :
                                                                                                       lane15_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane15_strm1_read_start_address  = (strm_control[15].strm1_assignedToExternalDma) ? strm_control[15].strm1_ExternalDma_read_start_address  :
                                                                                                       lane15_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane16_strm0_read_start_address  = (strm_control[16].strm0_assignedToExternalDma) ? strm_control[16].strm0_ExternalDma_read_start_address  :
                                                                                                       lane16_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane16_strm1_read_start_address  = (strm_control[16].strm1_assignedToExternalDma) ? strm_control[16].strm1_ExternalDma_read_start_address  :
                                                                                                       lane16_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane17_strm0_read_start_address  = (strm_control[17].strm0_assignedToExternalDma) ? strm_control[17].strm0_ExternalDma_read_start_address  :
                                                                                                       lane17_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane17_strm1_read_start_address  = (strm_control[17].strm1_assignedToExternalDma) ? strm_control[17].strm1_ExternalDma_read_start_address  :
                                                                                                       lane17_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane18_strm0_read_start_address  = (strm_control[18].strm0_assignedToExternalDma) ? strm_control[18].strm0_ExternalDma_read_start_address  :
                                                                                                       lane18_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane18_strm1_read_start_address  = (strm_control[18].strm1_assignedToExternalDma) ? strm_control[18].strm1_ExternalDma_read_start_address  :
                                                                                                       lane18_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane19_strm0_read_start_address  = (strm_control[19].strm0_assignedToExternalDma) ? strm_control[19].strm0_ExternalDma_read_start_address  :
                                                                                                       lane19_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane19_strm1_read_start_address  = (strm_control[19].strm1_assignedToExternalDma) ? strm_control[19].strm1_ExternalDma_read_start_address  :
                                                                                                       lane19_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane20_strm0_read_start_address  = (strm_control[20].strm0_assignedToExternalDma) ? strm_control[20].strm0_ExternalDma_read_start_address  :
                                                                                                       lane20_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane20_strm1_read_start_address  = (strm_control[20].strm1_assignedToExternalDma) ? strm_control[20].strm1_ExternalDma_read_start_address  :
                                                                                                       lane20_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane21_strm0_read_start_address  = (strm_control[21].strm0_assignedToExternalDma) ? strm_control[21].strm0_ExternalDma_read_start_address  :
                                                                                                       lane21_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane21_strm1_read_start_address  = (strm_control[21].strm1_assignedToExternalDma) ? strm_control[21].strm1_ExternalDma_read_start_address  :
                                                                                                       lane21_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane22_strm0_read_start_address  = (strm_control[22].strm0_assignedToExternalDma) ? strm_control[22].strm0_ExternalDma_read_start_address  :
                                                                                                       lane22_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane22_strm1_read_start_address  = (strm_control[22].strm1_assignedToExternalDma) ? strm_control[22].strm1_ExternalDma_read_start_address  :
                                                                                                       lane22_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane23_strm0_read_start_address  = (strm_control[23].strm0_assignedToExternalDma) ? strm_control[23].strm0_ExternalDma_read_start_address  :
                                                                                                       lane23_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane23_strm1_read_start_address  = (strm_control[23].strm1_assignedToExternalDma) ? strm_control[23].strm1_ExternalDma_read_start_address  :
                                                                                                       lane23_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane24_strm0_read_start_address  = (strm_control[24].strm0_assignedToExternalDma) ? strm_control[24].strm0_ExternalDma_read_start_address  :
                                                                                                       lane24_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane24_strm1_read_start_address  = (strm_control[24].strm1_assignedToExternalDma) ? strm_control[24].strm1_ExternalDma_read_start_address  :
                                                                                                       lane24_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane25_strm0_read_start_address  = (strm_control[25].strm0_assignedToExternalDma) ? strm_control[25].strm0_ExternalDma_read_start_address  :
                                                                                                       lane25_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane25_strm1_read_start_address  = (strm_control[25].strm1_assignedToExternalDma) ? strm_control[25].strm1_ExternalDma_read_start_address  :
                                                                                                       lane25_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane26_strm0_read_start_address  = (strm_control[26].strm0_assignedToExternalDma) ? strm_control[26].strm0_ExternalDma_read_start_address  :
                                                                                                       lane26_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane26_strm1_read_start_address  = (strm_control[26].strm1_assignedToExternalDma) ? strm_control[26].strm1_ExternalDma_read_start_address  :
                                                                                                       lane26_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane27_strm0_read_start_address  = (strm_control[27].strm0_assignedToExternalDma) ? strm_control[27].strm0_ExternalDma_read_start_address  :
                                                                                                       lane27_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane27_strm1_read_start_address  = (strm_control[27].strm1_assignedToExternalDma) ? strm_control[27].strm1_ExternalDma_read_start_address  :
                                                                                                       lane27_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane28_strm0_read_start_address  = (strm_control[28].strm0_assignedToExternalDma) ? strm_control[28].strm0_ExternalDma_read_start_address  :
                                                                                                       lane28_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane28_strm1_read_start_address  = (strm_control[28].strm1_assignedToExternalDma) ? strm_control[28].strm1_ExternalDma_read_start_address  :
                                                                                                       lane28_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane29_strm0_read_start_address  = (strm_control[29].strm0_assignedToExternalDma) ? strm_control[29].strm0_ExternalDma_read_start_address  :
                                                                                                       lane29_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane29_strm1_read_start_address  = (strm_control[29].strm1_assignedToExternalDma) ? strm_control[29].strm1_ExternalDma_read_start_address  :
                                                                                                       lane29_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane30_strm0_read_start_address  = (strm_control[30].strm0_assignedToExternalDma) ? strm_control[30].strm0_ExternalDma_read_start_address  :
                                                                                                       lane30_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane30_strm1_read_start_address  = (strm_control[30].strm1_assignedToExternalDma) ? strm_control[30].strm1_ExternalDma_read_start_address  :
                                                                                                       lane30_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
      scntl__sdp__lane31_strm0_read_start_address  = (strm_control[31].strm0_assignedToExternalDma) ? strm_control[31].strm0_ExternalDma_read_start_address  :
                                                                                                       lane31_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
      scntl__sdp__lane31_strm1_read_start_address  = (strm_control[31].strm1_assignedToExternalDma) ? strm_control[31].strm1_ExternalDma_read_start_address  :
                                                                                                       lane31_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;
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
               (strm_control[0].strm_complete | ~rs1[0]) & 
               (strm_control[1].strm_complete | ~rs1[1]) & 
               (strm_control[2].strm_complete | ~rs1[2]) & 
               (strm_control[3].strm_complete | ~rs1[3]) & 
               (strm_control[4].strm_complete | ~rs1[4]) & 
               (strm_control[5].strm_complete | ~rs1[5]) & 
               (strm_control[6].strm_complete | ~rs1[6]) & 
               (strm_control[7].strm_complete | ~rs1[7]) & 
               (strm_control[8].strm_complete | ~rs1[8]) & 
               (strm_control[9].strm_complete | ~rs1[9]) & 
               (strm_control[10].strm_complete | ~rs1[10]) & 
               (strm_control[11].strm_complete | ~rs1[11]) & 
               (strm_control[12].strm_complete | ~rs1[12]) & 
               (strm_control[13].strm_complete | ~rs1[13]) & 
               (strm_control[14].strm_complete | ~rs1[14]) & 
               (strm_control[15].strm_complete | ~rs1[15]) & 
               (strm_control[16].strm_complete | ~rs1[16]) & 
               (strm_control[17].strm_complete | ~rs1[17]) & 
               (strm_control[18].strm_complete | ~rs1[18]) & 
               (strm_control[19].strm_complete | ~rs1[19]) & 
               (strm_control[20].strm_complete | ~rs1[20]) & 
               (strm_control[21].strm_complete | ~rs1[21]) & 
               (strm_control[22].strm_complete | ~rs1[22]) & 
               (strm_control[23].strm_complete | ~rs1[23]) & 
               (strm_control[24].strm_complete | ~rs1[24]) & 
               (strm_control[25].strm_complete | ~rs1[25]) & 
               (strm_control[26].strm_complete | ~rs1[26]) & 
               (strm_control[27].strm_complete | ~rs1[27]) & 
               (strm_control[28].strm_complete | ~rs1[28]) & 
               (strm_control[29].strm_complete | ~rs1[29]) & 
               (strm_control[30].strm_complete | ~rs1[30]) & 
               (strm_control[31].strm_complete | ~rs1[31]) ; 

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

  assign strm_control[0].lane_enable  =  rs1[0]  ; 
  assign strm_control[1].lane_enable  =  rs1[1]  ; 
  assign strm_control[2].lane_enable  =  rs1[2]  ; 
  assign strm_control[3].lane_enable  =  rs1[3]  ; 
  assign strm_control[4].lane_enable  =  rs1[4]  ; 
  assign strm_control[5].lane_enable  =  rs1[5]  ; 
  assign strm_control[6].lane_enable  =  rs1[6]  ; 
  assign strm_control[7].lane_enable  =  rs1[7]  ; 
  assign strm_control[8].lane_enable  =  rs1[8]  ; 
  assign strm_control[9].lane_enable  =  rs1[9]  ; 
  assign strm_control[10].lane_enable  =  rs1[10]  ; 
  assign strm_control[11].lane_enable  =  rs1[11]  ; 
  assign strm_control[12].lane_enable  =  rs1[12]  ; 
  assign strm_control[13].lane_enable  =  rs1[13]  ; 
  assign strm_control[14].lane_enable  =  rs1[14]  ; 
  assign strm_control[15].lane_enable  =  rs1[15]  ; 
  assign strm_control[16].lane_enable  =  rs1[16]  ; 
  assign strm_control[17].lane_enable  =  rs1[17]  ; 
  assign strm_control[18].lane_enable  =  rs1[18]  ; 
  assign strm_control[19].lane_enable  =  rs1[19]  ; 
  assign strm_control[20].lane_enable  =  rs1[20]  ; 
  assign strm_control[21].lane_enable  =  rs1[21]  ; 
  assign strm_control[22].lane_enable  =  rs1[22]  ; 
  assign strm_control[23].lane_enable  =  rs1[23]  ; 
  assign strm_control[24].lane_enable  =  rs1[24]  ; 
  assign strm_control[25].lane_enable  =  rs1[25]  ; 
  assign strm_control[26].lane_enable  =  rs1[26]  ; 
  assign strm_control[27].lane_enable  =  rs1[27]  ; 
  assign strm_control[28].lane_enable  =  rs1[28]  ; 
  assign strm_control[29].lane_enable  =  rs1[29]  ; 
  assign strm_control[30].lane_enable  =  rs1[30]  ; 
  assign strm_control[31].lane_enable  =  rs1[31]  ; 

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

  assign NoC_Request_Vector[0]       = strm_control[0].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[0]  = strm_control[0].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[1]       = strm_control[1].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[1]  = strm_control[1].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[2]       = strm_control[2].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[2]  = strm_control[2].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[3]       = strm_control[3].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[3]  = strm_control[3].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[4]       = strm_control[4].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[4]  = strm_control[4].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[5]       = strm_control[5].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[5]  = strm_control[5].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[6]       = strm_control[6].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[6]  = strm_control[6].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[7]       = strm_control[7].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[7]  = strm_control[7].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[8]       = strm_control[8].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[8]  = strm_control[8].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[9]       = strm_control[9].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[9]  = strm_control[9].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[10]       = strm_control[10].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[10]  = strm_control[10].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[11]       = strm_control[11].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[11]  = strm_control[11].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[12]       = strm_control[12].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[12]  = strm_control[12].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[13]       = strm_control[13].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[13]  = strm_control[13].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[14]       = strm_control[14].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[14]  = strm_control[14].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[15]       = strm_control[15].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[15]  = strm_control[15].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[16]       = strm_control[16].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[16]  = strm_control[16].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[17]       = strm_control[17].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[17]  = strm_control[17].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[18]       = strm_control[18].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[18]  = strm_control[18].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[19]       = strm_control[19].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[19]  = strm_control[19].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[20]       = strm_control[20].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[20]  = strm_control[20].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[21]       = strm_control[21].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[21]  = strm_control[21].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[22]       = strm_control[22].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[22]  = strm_control[22].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[23]       = strm_control[23].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[23]  = strm_control[23].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[24]       = strm_control[24].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[24]  = strm_control[24].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[25]       = strm_control[25].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[25]  = strm_control[25].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[26]       = strm_control[26].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[26]  = strm_control[26].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[27]       = strm_control[27].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[27]  = strm_control[27].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[28]       = strm_control[28].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[28]  = strm_control[28].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[29]       = strm_control[29].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[29]  = strm_control[29].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[30]       = strm_control[30].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[30]  = strm_control[30].NocLocalDmaRequestStrm ;
  assign NoC_Request_Vector[31]       = strm_control[31].NocLocalDmaRequest     ;
  assign NoC_Request_Strm_Vector[31]  = strm_control[31].NocLocalDmaRequestStrm ;
// Vector of available read streams for external DMA's

  assign Read_Stream_Available_Vector[0]       = (strm_control[0].lane_enable & strm_control[0].ReadyForStreamExternalRequests & (~strm_control[0].strm0_read_enable | ~strm_control[0].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[0].strm0_assignedToExternalDma & ~strm_control[0].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[1]       = (strm_control[1].lane_enable & strm_control[1].ReadyForStreamExternalRequests & (~strm_control[1].strm0_read_enable | ~strm_control[1].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[1].strm0_assignedToExternalDma & ~strm_control[1].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[2]       = (strm_control[2].lane_enable & strm_control[2].ReadyForStreamExternalRequests & (~strm_control[2].strm0_read_enable | ~strm_control[2].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[2].strm0_assignedToExternalDma & ~strm_control[2].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[3]       = (strm_control[3].lane_enable & strm_control[3].ReadyForStreamExternalRequests & (~strm_control[3].strm0_read_enable | ~strm_control[3].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[3].strm0_assignedToExternalDma & ~strm_control[3].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[4]       = (strm_control[4].lane_enable & strm_control[4].ReadyForStreamExternalRequests & (~strm_control[4].strm0_read_enable | ~strm_control[4].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[4].strm0_assignedToExternalDma & ~strm_control[4].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[5]       = (strm_control[5].lane_enable & strm_control[5].ReadyForStreamExternalRequests & (~strm_control[5].strm0_read_enable | ~strm_control[5].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[5].strm0_assignedToExternalDma & ~strm_control[5].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[6]       = (strm_control[6].lane_enable & strm_control[6].ReadyForStreamExternalRequests & (~strm_control[6].strm0_read_enable | ~strm_control[6].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[6].strm0_assignedToExternalDma & ~strm_control[6].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[7]       = (strm_control[7].lane_enable & strm_control[7].ReadyForStreamExternalRequests & (~strm_control[7].strm0_read_enable | ~strm_control[7].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[7].strm0_assignedToExternalDma & ~strm_control[7].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[8]       = (strm_control[8].lane_enable & strm_control[8].ReadyForStreamExternalRequests & (~strm_control[8].strm0_read_enable | ~strm_control[8].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[8].strm0_assignedToExternalDma & ~strm_control[8].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[9]       = (strm_control[9].lane_enable & strm_control[9].ReadyForStreamExternalRequests & (~strm_control[9].strm0_read_enable | ~strm_control[9].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[9].strm0_assignedToExternalDma & ~strm_control[9].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[10]       = (strm_control[10].lane_enable & strm_control[10].ReadyForStreamExternalRequests & (~strm_control[10].strm0_read_enable | ~strm_control[10].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[10].strm0_assignedToExternalDma & ~strm_control[10].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[11]       = (strm_control[11].lane_enable & strm_control[11].ReadyForStreamExternalRequests & (~strm_control[11].strm0_read_enable | ~strm_control[11].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[11].strm0_assignedToExternalDma & ~strm_control[11].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[12]       = (strm_control[12].lane_enable & strm_control[12].ReadyForStreamExternalRequests & (~strm_control[12].strm0_read_enable | ~strm_control[12].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[12].strm0_assignedToExternalDma & ~strm_control[12].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[13]       = (strm_control[13].lane_enable & strm_control[13].ReadyForStreamExternalRequests & (~strm_control[13].strm0_read_enable | ~strm_control[13].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[13].strm0_assignedToExternalDma & ~strm_control[13].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[14]       = (strm_control[14].lane_enable & strm_control[14].ReadyForStreamExternalRequests & (~strm_control[14].strm0_read_enable | ~strm_control[14].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[14].strm0_assignedToExternalDma & ~strm_control[14].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[15]       = (strm_control[15].lane_enable & strm_control[15].ReadyForStreamExternalRequests & (~strm_control[15].strm0_read_enable | ~strm_control[15].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[15].strm0_assignedToExternalDma & ~strm_control[15].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[16]       = (strm_control[16].lane_enable & strm_control[16].ReadyForStreamExternalRequests & (~strm_control[16].strm0_read_enable | ~strm_control[16].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[16].strm0_assignedToExternalDma & ~strm_control[16].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[17]       = (strm_control[17].lane_enable & strm_control[17].ReadyForStreamExternalRequests & (~strm_control[17].strm0_read_enable | ~strm_control[17].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[17].strm0_assignedToExternalDma & ~strm_control[17].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[18]       = (strm_control[18].lane_enable & strm_control[18].ReadyForStreamExternalRequests & (~strm_control[18].strm0_read_enable | ~strm_control[18].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[18].strm0_assignedToExternalDma & ~strm_control[18].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[19]       = (strm_control[19].lane_enable & strm_control[19].ReadyForStreamExternalRequests & (~strm_control[19].strm0_read_enable | ~strm_control[19].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[19].strm0_assignedToExternalDma & ~strm_control[19].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[20]       = (strm_control[20].lane_enable & strm_control[20].ReadyForStreamExternalRequests & (~strm_control[20].strm0_read_enable | ~strm_control[20].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[20].strm0_assignedToExternalDma & ~strm_control[20].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[21]       = (strm_control[21].lane_enable & strm_control[21].ReadyForStreamExternalRequests & (~strm_control[21].strm0_read_enable | ~strm_control[21].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[21].strm0_assignedToExternalDma & ~strm_control[21].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[22]       = (strm_control[22].lane_enable & strm_control[22].ReadyForStreamExternalRequests & (~strm_control[22].strm0_read_enable | ~strm_control[22].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[22].strm0_assignedToExternalDma & ~strm_control[22].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[23]       = (strm_control[23].lane_enable & strm_control[23].ReadyForStreamExternalRequests & (~strm_control[23].strm0_read_enable | ~strm_control[23].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[23].strm0_assignedToExternalDma & ~strm_control[23].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[24]       = (strm_control[24].lane_enable & strm_control[24].ReadyForStreamExternalRequests & (~strm_control[24].strm0_read_enable | ~strm_control[24].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[24].strm0_assignedToExternalDma & ~strm_control[24].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[25]       = (strm_control[25].lane_enable & strm_control[25].ReadyForStreamExternalRequests & (~strm_control[25].strm0_read_enable | ~strm_control[25].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[25].strm0_assignedToExternalDma & ~strm_control[25].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[26]       = (strm_control[26].lane_enable & strm_control[26].ReadyForStreamExternalRequests & (~strm_control[26].strm0_read_enable | ~strm_control[26].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[26].strm0_assignedToExternalDma & ~strm_control[26].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[27]       = (strm_control[27].lane_enable & strm_control[27].ReadyForStreamExternalRequests & (~strm_control[27].strm0_read_enable | ~strm_control[27].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[27].strm0_assignedToExternalDma & ~strm_control[27].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[28]       = (strm_control[28].lane_enable & strm_control[28].ReadyForStreamExternalRequests & (~strm_control[28].strm0_read_enable | ~strm_control[28].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[28].strm0_assignedToExternalDma & ~strm_control[28].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[29]       = (strm_control[29].lane_enable & strm_control[29].ReadyForStreamExternalRequests & (~strm_control[29].strm0_read_enable | ~strm_control[29].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[29].strm0_assignedToExternalDma & ~strm_control[29].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[30]       = (strm_control[30].lane_enable & strm_control[30].ReadyForStreamExternalRequests & (~strm_control[30].strm0_read_enable | ~strm_control[30].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[30].strm0_assignedToExternalDma & ~strm_control[30].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA
  assign Read_Stream_Available_Vector[31]       = (strm_control[31].lane_enable & strm_control[31].ReadyForStreamExternalRequests & (~strm_control[31].strm0_read_enable | ~strm_control[31].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA
                                                   (~strm_control[31].strm0_assignedToExternalDma & ~strm_control[31].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA


  // Take the first Stream controller DMA request and pass request to NoC Control FSM
  // Latch in a register in case a higher order lane makes a request after a lower order stream
  // Latcheit and ack are pass thru, so dont latch. request/ack specified in the mux below
  always @(posedge clk)
    begin
      if (~NocControlLocalRequestWait)
        begin
          casez(NoC_Request_Vector)
            32'b1???????????????????????????????:
            begin
              localDmaRequestLane <= 'd31;
            end
            32'b01??????????????????????????????:
            begin
              localDmaRequestLane <= 'd30;
            end
            32'b001?????????????????????????????:
            begin
              localDmaRequestLane <= 'd29;
            end
            32'b0001????????????????????????????:
            begin
              localDmaRequestLane <= 'd28;
            end
            32'b00001???????????????????????????:
            begin
              localDmaRequestLane <= 'd27;
            end
            32'b000001??????????????????????????:
            begin
              localDmaRequestLane <= 'd26;
            end
            32'b0000001?????????????????????????:
            begin
              localDmaRequestLane <= 'd25;
            end
            32'b00000001????????????????????????:
            begin
              localDmaRequestLane <= 'd24;
            end
            32'b000000001???????????????????????:
            begin
              localDmaRequestLane <= 'd23;
            end
            32'b0000000001??????????????????????:
            begin
              localDmaRequestLane <= 'd22;
            end
            32'b00000000001?????????????????????:
            begin
              localDmaRequestLane <= 'd21;
            end
            32'b000000000001????????????????????:
            begin
              localDmaRequestLane <= 'd20;
            end
            32'b0000000000001???????????????????:
            begin
              localDmaRequestLane <= 'd19;
            end
            32'b00000000000001??????????????????:
            begin
              localDmaRequestLane <= 'd18;
            end
            32'b000000000000001?????????????????:
            begin
              localDmaRequestLane <= 'd17;
            end
            32'b0000000000000001????????????????:
            begin
              localDmaRequestLane <= 'd16;
            end
            32'b00000000000000001???????????????:
            begin
              localDmaRequestLane <= 'd15;
            end
            32'b000000000000000001??????????????:
            begin
              localDmaRequestLane <= 'd14;
            end
            32'b0000000000000000001?????????????:
            begin
              localDmaRequestLane <= 'd13;
            end
            32'b00000000000000000001????????????:
            begin
              localDmaRequestLane <= 'd12;
            end
            32'b000000000000000000001???????????:
            begin
              localDmaRequestLane <= 'd11;
            end
            32'b0000000000000000000001??????????:
            begin
              localDmaRequestLane <= 'd10;
            end
            32'b00000000000000000000001?????????:
            begin
              localDmaRequestLane <= 'd9;
            end
            32'b000000000000000000000001????????:
            begin
              localDmaRequestLane <= 'd8;
            end
            32'b0000000000000000000000001???????:
            begin
              localDmaRequestLane <= 'd7;
            end
            32'b00000000000000000000000001??????:
            begin
              localDmaRequestLane <= 'd6;
            end
            32'b000000000000000000000000001?????:
            begin
              localDmaRequestLane <= 'd5;
            end
            32'b0000000000000000000000000001????:
            begin
              localDmaRequestLane <= 'd4;
            end
            32'b00000000000000000000000000001???:
            begin
              localDmaRequestLane <= 'd3;
            end
            32'b000000000000000000000000000001??:
            begin
              localDmaRequestLane <= 'd2;
            end
            32'b0000000000000000000000000000001?:
            begin
              localDmaRequestLane <= 'd1;
            end
            32'b00000000000000000000000000000001:
            begin
              localDmaRequestLane <= 'd0;
            end
            default:
            begin
              localDmaRequestLane <= 'd0;
            end
          endcase
        end
      end


  // Take the Acknowledge from the "to" NoC Control FSM and pass back to requesting stream controller
  always @(*)
    begin
      strm_control[0].localDmaReqNocAck = 1'b0;
      strm_control[1].localDmaReqNocAck = 1'b0;
      strm_control[2].localDmaReqNocAck = 1'b0;
      strm_control[3].localDmaReqNocAck = 1'b0;
      strm_control[4].localDmaReqNocAck = 1'b0;
      strm_control[5].localDmaReqNocAck = 1'b0;
      strm_control[6].localDmaReqNocAck = 1'b0;
      strm_control[7].localDmaReqNocAck = 1'b0;
      strm_control[8].localDmaReqNocAck = 1'b0;
      strm_control[9].localDmaReqNocAck = 1'b0;
      strm_control[10].localDmaReqNocAck = 1'b0;
      strm_control[11].localDmaReqNocAck = 1'b0;
      strm_control[12].localDmaReqNocAck = 1'b0;
      strm_control[13].localDmaReqNocAck = 1'b0;
      strm_control[14].localDmaReqNocAck = 1'b0;
      strm_control[15].localDmaReqNocAck = 1'b0;
      strm_control[16].localDmaReqNocAck = 1'b0;
      strm_control[17].localDmaReqNocAck = 1'b0;
      strm_control[18].localDmaReqNocAck = 1'b0;
      strm_control[19].localDmaReqNocAck = 1'b0;
      strm_control[20].localDmaReqNocAck = 1'b0;
      strm_control[21].localDmaReqNocAck = 1'b0;
      strm_control[22].localDmaReqNocAck = 1'b0;
      strm_control[23].localDmaReqNocAck = 1'b0;
      strm_control[24].localDmaReqNocAck = 1'b0;
      strm_control[25].localDmaReqNocAck = 1'b0;
      strm_control[26].localDmaReqNocAck = 1'b0;
      strm_control[27].localDmaReqNocAck = 1'b0;
      strm_control[28].localDmaReqNocAck = 1'b0;
      strm_control[29].localDmaReqNocAck = 1'b0;
      strm_control[30].localDmaReqNocAck = 1'b0;
      strm_control[31].localDmaReqNocAck = 1'b0;
        localDmaRequest                     = 'b0;
      case(localDmaRequestLane)
        'd0:
        begin
          strm_control[0].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[0].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[0].NocLocalDmaRequestStrm) ? lane0_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane0_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[0].NocLocalDmaRequestStrm) ? lane0_stagger1                 : lane0_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[0].NocLocalDmaRequestStrm) ? strm_control[0].strm1_word_count : strm_control[0].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[0].NocLocalDmaRequestStrm) ? lane0_type1                      : lane0_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[0].NocLocalDmaRequestStrm;
        end
        'd1:
        begin
          strm_control[1].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[1].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[1].NocLocalDmaRequestStrm) ? lane1_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane1_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[1].NocLocalDmaRequestStrm) ? lane1_stagger1                 : lane1_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[1].NocLocalDmaRequestStrm) ? strm_control[1].strm1_word_count : strm_control[1].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[1].NocLocalDmaRequestStrm) ? lane1_type1                      : lane1_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[1].NocLocalDmaRequestStrm;
        end
        'd2:
        begin
          strm_control[2].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[2].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[2].NocLocalDmaRequestStrm) ? lane2_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane2_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[2].NocLocalDmaRequestStrm) ? lane2_stagger1                 : lane2_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[2].NocLocalDmaRequestStrm) ? strm_control[2].strm1_word_count : strm_control[2].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[2].NocLocalDmaRequestStrm) ? lane2_type1                      : lane2_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[2].NocLocalDmaRequestStrm;
        end
        'd3:
        begin
          strm_control[3].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[3].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[3].NocLocalDmaRequestStrm) ? lane3_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane3_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[3].NocLocalDmaRequestStrm) ? lane3_stagger1                 : lane3_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[3].NocLocalDmaRequestStrm) ? strm_control[3].strm1_word_count : strm_control[3].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[3].NocLocalDmaRequestStrm) ? lane3_type1                      : lane3_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[3].NocLocalDmaRequestStrm;
        end
        'd4:
        begin
          strm_control[4].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[4].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[4].NocLocalDmaRequestStrm) ? lane4_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane4_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[4].NocLocalDmaRequestStrm) ? lane4_stagger1                 : lane4_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[4].NocLocalDmaRequestStrm) ? strm_control[4].strm1_word_count : strm_control[4].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[4].NocLocalDmaRequestStrm) ? lane4_type1                      : lane4_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[4].NocLocalDmaRequestStrm;
        end
        'd5:
        begin
          strm_control[5].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[5].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[5].NocLocalDmaRequestStrm) ? lane5_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane5_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[5].NocLocalDmaRequestStrm) ? lane5_stagger1                 : lane5_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[5].NocLocalDmaRequestStrm) ? strm_control[5].strm1_word_count : strm_control[5].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[5].NocLocalDmaRequestStrm) ? lane5_type1                      : lane5_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[5].NocLocalDmaRequestStrm;
        end
        'd6:
        begin
          strm_control[6].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[6].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[6].NocLocalDmaRequestStrm) ? lane6_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane6_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[6].NocLocalDmaRequestStrm) ? lane6_stagger1                 : lane6_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[6].NocLocalDmaRequestStrm) ? strm_control[6].strm1_word_count : strm_control[6].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[6].NocLocalDmaRequestStrm) ? lane6_type1                      : lane6_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[6].NocLocalDmaRequestStrm;
        end
        'd7:
        begin
          strm_control[7].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[7].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[7].NocLocalDmaRequestStrm) ? lane7_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane7_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[7].NocLocalDmaRequestStrm) ? lane7_stagger1                 : lane7_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[7].NocLocalDmaRequestStrm) ? strm_control[7].strm1_word_count : strm_control[7].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[7].NocLocalDmaRequestStrm) ? lane7_type1                      : lane7_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[7].NocLocalDmaRequestStrm;
        end
        'd8:
        begin
          strm_control[8].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[8].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[8].NocLocalDmaRequestStrm) ? lane8_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane8_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[8].NocLocalDmaRequestStrm) ? lane8_stagger1                 : lane8_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[8].NocLocalDmaRequestStrm) ? strm_control[8].strm1_word_count : strm_control[8].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[8].NocLocalDmaRequestStrm) ? lane8_type1                      : lane8_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[8].NocLocalDmaRequestStrm;
        end
        'd9:
        begin
          strm_control[9].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[9].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[9].NocLocalDmaRequestStrm) ? lane9_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane9_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[9].NocLocalDmaRequestStrm) ? lane9_stagger1                 : lane9_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[9].NocLocalDmaRequestStrm) ? strm_control[9].strm1_word_count : strm_control[9].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[9].NocLocalDmaRequestStrm) ? lane9_type1                      : lane9_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[9].NocLocalDmaRequestStrm;
        end
        'd10:
        begin
          strm_control[10].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[10].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[10].NocLocalDmaRequestStrm) ? lane10_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane10_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[10].NocLocalDmaRequestStrm) ? lane10_stagger1                 : lane10_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[10].NocLocalDmaRequestStrm) ? strm_control[10].strm1_word_count : strm_control[10].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[10].NocLocalDmaRequestStrm) ? lane10_type1                      : lane10_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[10].NocLocalDmaRequestStrm;
        end
        'd11:
        begin
          strm_control[11].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[11].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[11].NocLocalDmaRequestStrm) ? lane11_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane11_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[11].NocLocalDmaRequestStrm) ? lane11_stagger1                 : lane11_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[11].NocLocalDmaRequestStrm) ? strm_control[11].strm1_word_count : strm_control[11].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[11].NocLocalDmaRequestStrm) ? lane11_type1                      : lane11_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[11].NocLocalDmaRequestStrm;
        end
        'd12:
        begin
          strm_control[12].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[12].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[12].NocLocalDmaRequestStrm) ? lane12_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane12_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[12].NocLocalDmaRequestStrm) ? lane12_stagger1                 : lane12_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[12].NocLocalDmaRequestStrm) ? strm_control[12].strm1_word_count : strm_control[12].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[12].NocLocalDmaRequestStrm) ? lane12_type1                      : lane12_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[12].NocLocalDmaRequestStrm;
        end
        'd13:
        begin
          strm_control[13].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[13].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[13].NocLocalDmaRequestStrm) ? lane13_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane13_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[13].NocLocalDmaRequestStrm) ? lane13_stagger1                 : lane13_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[13].NocLocalDmaRequestStrm) ? strm_control[13].strm1_word_count : strm_control[13].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[13].NocLocalDmaRequestStrm) ? lane13_type1                      : lane13_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[13].NocLocalDmaRequestStrm;
        end
        'd14:
        begin
          strm_control[14].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[14].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[14].NocLocalDmaRequestStrm) ? lane14_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane14_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[14].NocLocalDmaRequestStrm) ? lane14_stagger1                 : lane14_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[14].NocLocalDmaRequestStrm) ? strm_control[14].strm1_word_count : strm_control[14].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[14].NocLocalDmaRequestStrm) ? lane14_type1                      : lane14_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[14].NocLocalDmaRequestStrm;
        end
        'd15:
        begin
          strm_control[15].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[15].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[15].NocLocalDmaRequestStrm) ? lane15_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane15_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[15].NocLocalDmaRequestStrm) ? lane15_stagger1                 : lane15_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[15].NocLocalDmaRequestStrm) ? strm_control[15].strm1_word_count : strm_control[15].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[15].NocLocalDmaRequestStrm) ? lane15_type1                      : lane15_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[15].NocLocalDmaRequestStrm;
        end
        'd16:
        begin
          strm_control[16].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[16].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[16].NocLocalDmaRequestStrm) ? lane16_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane16_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[16].NocLocalDmaRequestStrm) ? lane16_stagger1                 : lane16_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[16].NocLocalDmaRequestStrm) ? strm_control[16].strm1_word_count : strm_control[16].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[16].NocLocalDmaRequestStrm) ? lane16_type1                      : lane16_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[16].NocLocalDmaRequestStrm;
        end
        'd17:
        begin
          strm_control[17].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[17].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[17].NocLocalDmaRequestStrm) ? lane17_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane17_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[17].NocLocalDmaRequestStrm) ? lane17_stagger1                 : lane17_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[17].NocLocalDmaRequestStrm) ? strm_control[17].strm1_word_count : strm_control[17].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[17].NocLocalDmaRequestStrm) ? lane17_type1                      : lane17_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[17].NocLocalDmaRequestStrm;
        end
        'd18:
        begin
          strm_control[18].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[18].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[18].NocLocalDmaRequestStrm) ? lane18_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane18_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[18].NocLocalDmaRequestStrm) ? lane18_stagger1                 : lane18_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[18].NocLocalDmaRequestStrm) ? strm_control[18].strm1_word_count : strm_control[18].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[18].NocLocalDmaRequestStrm) ? lane18_type1                      : lane18_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[18].NocLocalDmaRequestStrm;
        end
        'd19:
        begin
          strm_control[19].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[19].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[19].NocLocalDmaRequestStrm) ? lane19_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane19_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[19].NocLocalDmaRequestStrm) ? lane19_stagger1                 : lane19_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[19].NocLocalDmaRequestStrm) ? strm_control[19].strm1_word_count : strm_control[19].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[19].NocLocalDmaRequestStrm) ? lane19_type1                      : lane19_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[19].NocLocalDmaRequestStrm;
        end
        'd20:
        begin
          strm_control[20].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[20].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[20].NocLocalDmaRequestStrm) ? lane20_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane20_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[20].NocLocalDmaRequestStrm) ? lane20_stagger1                 : lane20_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[20].NocLocalDmaRequestStrm) ? strm_control[20].strm1_word_count : strm_control[20].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[20].NocLocalDmaRequestStrm) ? lane20_type1                      : lane20_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[20].NocLocalDmaRequestStrm;
        end
        'd21:
        begin
          strm_control[21].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[21].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[21].NocLocalDmaRequestStrm) ? lane21_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane21_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[21].NocLocalDmaRequestStrm) ? lane21_stagger1                 : lane21_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[21].NocLocalDmaRequestStrm) ? strm_control[21].strm1_word_count : strm_control[21].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[21].NocLocalDmaRequestStrm) ? lane21_type1                      : lane21_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[21].NocLocalDmaRequestStrm;
        end
        'd22:
        begin
          strm_control[22].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[22].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[22].NocLocalDmaRequestStrm) ? lane22_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane22_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[22].NocLocalDmaRequestStrm) ? lane22_stagger1                 : lane22_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[22].NocLocalDmaRequestStrm) ? strm_control[22].strm1_word_count : strm_control[22].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[22].NocLocalDmaRequestStrm) ? lane22_type1                      : lane22_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[22].NocLocalDmaRequestStrm;
        end
        'd23:
        begin
          strm_control[23].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[23].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[23].NocLocalDmaRequestStrm) ? lane23_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane23_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[23].NocLocalDmaRequestStrm) ? lane23_stagger1                 : lane23_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[23].NocLocalDmaRequestStrm) ? strm_control[23].strm1_word_count : strm_control[23].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[23].NocLocalDmaRequestStrm) ? lane23_type1                      : lane23_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[23].NocLocalDmaRequestStrm;
        end
        'd24:
        begin
          strm_control[24].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[24].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[24].NocLocalDmaRequestStrm) ? lane24_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane24_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[24].NocLocalDmaRequestStrm) ? lane24_stagger1                 : lane24_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[24].NocLocalDmaRequestStrm) ? strm_control[24].strm1_word_count : strm_control[24].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[24].NocLocalDmaRequestStrm) ? lane24_type1                      : lane24_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[24].NocLocalDmaRequestStrm;
        end
        'd25:
        begin
          strm_control[25].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[25].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[25].NocLocalDmaRequestStrm) ? lane25_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane25_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[25].NocLocalDmaRequestStrm) ? lane25_stagger1                 : lane25_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[25].NocLocalDmaRequestStrm) ? strm_control[25].strm1_word_count : strm_control[25].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[25].NocLocalDmaRequestStrm) ? lane25_type1                      : lane25_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[25].NocLocalDmaRequestStrm;
        end
        'd26:
        begin
          strm_control[26].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[26].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[26].NocLocalDmaRequestStrm) ? lane26_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane26_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[26].NocLocalDmaRequestStrm) ? lane26_stagger1                 : lane26_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[26].NocLocalDmaRequestStrm) ? strm_control[26].strm1_word_count : strm_control[26].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[26].NocLocalDmaRequestStrm) ? lane26_type1                      : lane26_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[26].NocLocalDmaRequestStrm;
        end
        'd27:
        begin
          strm_control[27].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[27].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[27].NocLocalDmaRequestStrm) ? lane27_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane27_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[27].NocLocalDmaRequestStrm) ? lane27_stagger1                 : lane27_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[27].NocLocalDmaRequestStrm) ? strm_control[27].strm1_word_count : strm_control[27].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[27].NocLocalDmaRequestStrm) ? lane27_type1                      : lane27_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[27].NocLocalDmaRequestStrm;
        end
        'd28:
        begin
          strm_control[28].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[28].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[28].NocLocalDmaRequestStrm) ? lane28_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane28_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[28].NocLocalDmaRequestStrm) ? lane28_stagger1                 : lane28_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[28].NocLocalDmaRequestStrm) ? strm_control[28].strm1_word_count : strm_control[28].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[28].NocLocalDmaRequestStrm) ? lane28_type1                      : lane28_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[28].NocLocalDmaRequestStrm;
        end
        'd29:
        begin
          strm_control[29].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[29].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[29].NocLocalDmaRequestStrm) ? lane29_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane29_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[29].NocLocalDmaRequestStrm) ? lane29_stagger1                 : lane29_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[29].NocLocalDmaRequestStrm) ? strm_control[29].strm1_word_count : strm_control[29].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[29].NocLocalDmaRequestStrm) ? lane29_type1                      : lane29_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[29].NocLocalDmaRequestStrm;
        end
        'd30:
        begin
          strm_control[30].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[30].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[30].NocLocalDmaRequestStrm) ? lane30_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane30_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[30].NocLocalDmaRequestStrm) ? lane30_stagger1                 : lane30_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[30].NocLocalDmaRequestStrm) ? strm_control[30].strm1_word_count : strm_control[30].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[30].NocLocalDmaRequestStrm) ? lane30_type1                      : lane30_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[30].NocLocalDmaRequestStrm;
        end
        'd31:
        begin
          strm_control[31].localDmaReqNocAck   = NocControlLocalAck                   ;
          localDmaRequest                       = strm_control[31].NocLocalDmaRequest ;
            // Pass local DMA request to NoC 

          if (cntl_to_noc_1st_cycle)  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;
          else  
            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;
          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;
          if (cntl_to_noc_1st_cycle)  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[31].NocLocalDmaRequestStrm) ? lane31_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane31_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[31].NocLocalDmaRequestStrm) ? lane31_stagger1                 : lane31_stagger0                 ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = 'd0                                                                                                             ; 
            end  
          else  
            begin  
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[31].NocLocalDmaRequestStrm) ? strm_control[31].strm1_word_count : strm_control[31].strm0_word_count ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[31].NocLocalDmaRequestStrm) ? lane31_type1                      : lane31_type0                      ; 
              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = 'd0                                                                                                              ; 
            end  
          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;
          scntl__noc__cp_strmId_p1                                                        = strm_control[31].NocLocalDmaRequestStrm;
        end
      endcase
    end


  // Take the first Stream thats available and provide to next DMA request that arrives from the NoC
  // Latch in a register in case a higher order lane becomes available
  always @(posedge clk)
    begin
      if (reset_poweron)
        begin
          localStrmAvailableLane <= 'd0;
          localStrmAvailable     <= 'b0;
        end
      else if (~NocControlExternalRequestWait)
        begin
          casez(Read_Stream_Available_Vector)
            32'b1???????????????????????????????:
            begin
              localStrmAvailableLane <= 'd31;
              localStrmAvailable     <= 'b1;
            end
            32'b01??????????????????????????????:
            begin
              localStrmAvailableLane <= 'd30;
              localStrmAvailable     <= 'b1;
            end
            32'b001?????????????????????????????:
            begin
              localStrmAvailableLane <= 'd29;
              localStrmAvailable     <= 'b1;
            end
            32'b0001????????????????????????????:
            begin
              localStrmAvailableLane <= 'd28;
              localStrmAvailable     <= 'b1;
            end
            32'b00001???????????????????????????:
            begin
              localStrmAvailableLane <= 'd27;
              localStrmAvailable     <= 'b1;
            end
            32'b000001??????????????????????????:
            begin
              localStrmAvailableLane <= 'd26;
              localStrmAvailable     <= 'b1;
            end
            32'b0000001?????????????????????????:
            begin
              localStrmAvailableLane <= 'd25;
              localStrmAvailable     <= 'b1;
            end
            32'b00000001????????????????????????:
            begin
              localStrmAvailableLane <= 'd24;
              localStrmAvailable     <= 'b1;
            end
            32'b000000001???????????????????????:
            begin
              localStrmAvailableLane <= 'd23;
              localStrmAvailable     <= 'b1;
            end
            32'b0000000001??????????????????????:
            begin
              localStrmAvailableLane <= 'd22;
              localStrmAvailable     <= 'b1;
            end
            32'b00000000001?????????????????????:
            begin
              localStrmAvailableLane <= 'd21;
              localStrmAvailable     <= 'b1;
            end
            32'b000000000001????????????????????:
            begin
              localStrmAvailableLane <= 'd20;
              localStrmAvailable     <= 'b1;
            end
            32'b0000000000001???????????????????:
            begin
              localStrmAvailableLane <= 'd19;
              localStrmAvailable     <= 'b1;
            end
            32'b00000000000001??????????????????:
            begin
              localStrmAvailableLane <= 'd18;
              localStrmAvailable     <= 'b1;
            end
            32'b000000000000001?????????????????:
            begin
              localStrmAvailableLane <= 'd17;
              localStrmAvailable     <= 'b1;
            end
            32'b0000000000000001????????????????:
            begin
              localStrmAvailableLane <= 'd16;
              localStrmAvailable     <= 'b1;
            end
            32'b00000000000000001???????????????:
            begin
              localStrmAvailableLane <= 'd15;
              localStrmAvailable     <= 'b1;
            end
            32'b000000000000000001??????????????:
            begin
              localStrmAvailableLane <= 'd14;
              localStrmAvailable     <= 'b1;
            end
            32'b0000000000000000001?????????????:
            begin
              localStrmAvailableLane <= 'd13;
              localStrmAvailable     <= 'b1;
            end
            32'b00000000000000000001????????????:
            begin
              localStrmAvailableLane <= 'd12;
              localStrmAvailable     <= 'b1;
            end
            32'b000000000000000000001???????????:
            begin
              localStrmAvailableLane <= 'd11;
              localStrmAvailable     <= 'b1;
            end
            32'b0000000000000000000001??????????:
            begin
              localStrmAvailableLane <= 'd10;
              localStrmAvailable     <= 'b1;
            end
            32'b00000000000000000000001?????????:
            begin
              localStrmAvailableLane <= 'd9;
              localStrmAvailable     <= 'b1;
            end
            32'b000000000000000000000001????????:
            begin
              localStrmAvailableLane <= 'd8;
              localStrmAvailable     <= 'b1;
            end
            32'b0000000000000000000000001???????:
            begin
              localStrmAvailableLane <= 'd7;
              localStrmAvailable     <= 'b1;
            end
            32'b00000000000000000000000001??????:
            begin
              localStrmAvailableLane <= 'd6;
              localStrmAvailable     <= 'b1;
            end
            32'b000000000000000000000000001?????:
            begin
              localStrmAvailableLane <= 'd5;
              localStrmAvailable     <= 'b1;
            end
            32'b0000000000000000000000000001????:
            begin
              localStrmAvailableLane <= 'd4;
              localStrmAvailable     <= 'b1;
            end
            32'b00000000000000000000000000001???:
            begin
              localStrmAvailableLane <= 'd3;
              localStrmAvailable     <= 'b1;
            end
            32'b000000000000000000000000000001??:
            begin
              localStrmAvailableLane <= 'd2;
              localStrmAvailable     <= 'b1;
            end
            32'b0000000000000000000000000000001?:
            begin
              localStrmAvailableLane <= 'd1;
              localStrmAvailable     <= 'b1;
            end
            32'b00000000000000000000000000000001:
            begin
              localStrmAvailableLane <= 'd0;
              localStrmAvailable     <= 'b1;
            end
            default:
            begin
              localStrmAvailableLane <= 'd0;
              localStrmAvailable     <= 'b0;
            end
          endcase
        end
      end


  // Take the Acknowledge from the Stream controller and pass to the external DMA request FSM
  always @(*)
    begin
      strm_control[0].externalDmaReqStrmReq = 1'b0;
      strm_control[1].externalDmaReqStrmReq = 1'b0;
      strm_control[2].externalDmaReqStrmReq = 1'b0;
      strm_control[3].externalDmaReqStrmReq = 1'b0;
      strm_control[4].externalDmaReqStrmReq = 1'b0;
      strm_control[5].externalDmaReqStrmReq = 1'b0;
      strm_control[6].externalDmaReqStrmReq = 1'b0;
      strm_control[7].externalDmaReqStrmReq = 1'b0;
      strm_control[8].externalDmaReqStrmReq = 1'b0;
      strm_control[9].externalDmaReqStrmReq = 1'b0;
      strm_control[10].externalDmaReqStrmReq = 1'b0;
      strm_control[11].externalDmaReqStrmReq = 1'b0;
      strm_control[12].externalDmaReqStrmReq = 1'b0;
      strm_control[13].externalDmaReqStrmReq = 1'b0;
      strm_control[14].externalDmaReqStrmReq = 1'b0;
      strm_control[15].externalDmaReqStrmReq = 1'b0;
      strm_control[16].externalDmaReqStrmReq = 1'b0;
      strm_control[17].externalDmaReqStrmReq = 1'b0;
      strm_control[18].externalDmaReqStrmReq = 1'b0;
      strm_control[19].externalDmaReqStrmReq = 1'b0;
      strm_control[20].externalDmaReqStrmReq = 1'b0;
      strm_control[21].externalDmaReqStrmReq = 1'b0;
      strm_control[22].externalDmaReqStrmReq = 1'b0;
      strm_control[23].externalDmaReqStrmReq = 1'b0;
      strm_control[24].externalDmaReqStrmReq = 1'b0;
      strm_control[25].externalDmaReqStrmReq = 1'b0;
      strm_control[26].externalDmaReqStrmReq = 1'b0;
      strm_control[27].externalDmaReqStrmReq = 1'b0;
      strm_control[28].externalDmaReqStrmReq = 1'b0;
      strm_control[29].externalDmaReqStrmReq = 1'b0;
      strm_control[30].externalDmaReqStrmReq = 1'b0;
      strm_control[31].externalDmaReqStrmReq = 1'b0;
      NocControlExternalAck                   = 1'b0;
      case(localStrmAvailableLane)
        'd0:
        begin
          strm_control[0].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[0].externalDmaReqStrmAck  ;
        end
        'd1:
        begin
          strm_control[1].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[1].externalDmaReqStrmAck  ;
        end
        'd2:
        begin
          strm_control[2].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[2].externalDmaReqStrmAck  ;
        end
        'd3:
        begin
          strm_control[3].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[3].externalDmaReqStrmAck  ;
        end
        'd4:
        begin
          strm_control[4].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[4].externalDmaReqStrmAck  ;
        end
        'd5:
        begin
          strm_control[5].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[5].externalDmaReqStrmAck  ;
        end
        'd6:
        begin
          strm_control[6].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[6].externalDmaReqStrmAck  ;
        end
        'd7:
        begin
          strm_control[7].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[7].externalDmaReqStrmAck  ;
        end
        'd8:
        begin
          strm_control[8].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[8].externalDmaReqStrmAck  ;
        end
        'd9:
        begin
          strm_control[9].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[9].externalDmaReqStrmAck  ;
        end
        'd10:
        begin
          strm_control[10].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[10].externalDmaReqStrmAck  ;
        end
        'd11:
        begin
          strm_control[11].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[11].externalDmaReqStrmAck  ;
        end
        'd12:
        begin
          strm_control[12].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[12].externalDmaReqStrmAck  ;
        end
        'd13:
        begin
          strm_control[13].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[13].externalDmaReqStrmAck  ;
        end
        'd14:
        begin
          strm_control[14].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[14].externalDmaReqStrmAck  ;
        end
        'd15:
        begin
          strm_control[15].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[15].externalDmaReqStrmAck  ;
        end
        'd16:
        begin
          strm_control[16].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[16].externalDmaReqStrmAck  ;
        end
        'd17:
        begin
          strm_control[17].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[17].externalDmaReqStrmAck  ;
        end
        'd18:
        begin
          strm_control[18].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[18].externalDmaReqStrmAck  ;
        end
        'd19:
        begin
          strm_control[19].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[19].externalDmaReqStrmAck  ;
        end
        'd20:
        begin
          strm_control[20].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[20].externalDmaReqStrmAck  ;
        end
        'd21:
        begin
          strm_control[21].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[21].externalDmaReqStrmAck  ;
        end
        'd22:
        begin
          strm_control[22].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[22].externalDmaReqStrmAck  ;
        end
        'd23:
        begin
          strm_control[23].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[23].externalDmaReqStrmAck  ;
        end
        'd24:
        begin
          strm_control[24].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[24].externalDmaReqStrmAck  ;
        end
        'd25:
        begin
          strm_control[25].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[25].externalDmaReqStrmAck  ;
        end
        'd26:
        begin
          strm_control[26].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[26].externalDmaReqStrmAck  ;
        end
        'd27:
        begin
          strm_control[27].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[27].externalDmaReqStrmAck  ;
        end
        'd28:
        begin
          strm_control[28].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[28].externalDmaReqStrmAck  ;
        end
        'd29:
        begin
          strm_control[29].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[29].externalDmaReqStrmAck  ;
        end
        'd30:
        begin
          strm_control[30].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[30].externalDmaReqStrmAck  ;
        end
        'd31:
        begin
          strm_control[31].externalDmaReqStrmReq     = NocControlExternalReq                    ;
          NocControlExternalAck                       = strm_control[31].externalDmaReqStrmAck  ;
        end
      endcase
    end
