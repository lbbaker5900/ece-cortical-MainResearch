
  // lane0 from NoC 
  assign sdp__cntl__lane0_strm_ready             = stOp_lane[0].stOp__noc__strm_ready  ;
  assign stOp_lane[0].noc__stOp__strm_cntl       = cntl__sdp__lane0_strm_cntl          ;
  assign stOp_lane[0].noc__stOp__strm_id         = cntl__sdp__lane0_strm_id            ;
  assign stOp_lane[0].noc__stOp__strm_data       = cntl__sdp__lane0_strm_data          ;
  assign stOp_lane[0].noc__stOp__strm_data_valid = cntl__sdp__lane0_strm_data_valid    ;
  // lane0 to NoC 
  assign stOp_lane[0].noc__stOp__strm_ready       = cntl__sdp__lane0_strm_ready               ;
  assign sdp__cntl__lane0_strm_cntl               = stOp_lane[0].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane0_strm_id                 = stOp_lane[0].stOp__noc__strm_id           ;
  assign sdp__cntl__lane0_strm_data               = stOp_lane[0].stOp__noc__strm_data         ;
  assign sdp__cntl__lane0_strm_data_valid         = stOp_lane[0].stOp__noc__strm_data_valid   ;
  // lane1 from NoC 
  assign sdp__cntl__lane1_strm_ready             = stOp_lane[1].stOp__noc__strm_ready  ;
  assign stOp_lane[1].noc__stOp__strm_cntl       = cntl__sdp__lane1_strm_cntl          ;
  assign stOp_lane[1].noc__stOp__strm_id         = cntl__sdp__lane1_strm_id            ;
  assign stOp_lane[1].noc__stOp__strm_data       = cntl__sdp__lane1_strm_data          ;
  assign stOp_lane[1].noc__stOp__strm_data_valid = cntl__sdp__lane1_strm_data_valid    ;
  // lane1 to NoC 
  assign stOp_lane[1].noc__stOp__strm_ready       = cntl__sdp__lane1_strm_ready               ;
  assign sdp__cntl__lane1_strm_cntl               = stOp_lane[1].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane1_strm_id                 = stOp_lane[1].stOp__noc__strm_id           ;
  assign sdp__cntl__lane1_strm_data               = stOp_lane[1].stOp__noc__strm_data         ;
  assign sdp__cntl__lane1_strm_data_valid         = stOp_lane[1].stOp__noc__strm_data_valid   ;
  // lane2 from NoC 
  assign sdp__cntl__lane2_strm_ready             = stOp_lane[2].stOp__noc__strm_ready  ;
  assign stOp_lane[2].noc__stOp__strm_cntl       = cntl__sdp__lane2_strm_cntl          ;
  assign stOp_lane[2].noc__stOp__strm_id         = cntl__sdp__lane2_strm_id            ;
  assign stOp_lane[2].noc__stOp__strm_data       = cntl__sdp__lane2_strm_data          ;
  assign stOp_lane[2].noc__stOp__strm_data_valid = cntl__sdp__lane2_strm_data_valid    ;
  // lane2 to NoC 
  assign stOp_lane[2].noc__stOp__strm_ready       = cntl__sdp__lane2_strm_ready               ;
  assign sdp__cntl__lane2_strm_cntl               = stOp_lane[2].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane2_strm_id                 = stOp_lane[2].stOp__noc__strm_id           ;
  assign sdp__cntl__lane2_strm_data               = stOp_lane[2].stOp__noc__strm_data         ;
  assign sdp__cntl__lane2_strm_data_valid         = stOp_lane[2].stOp__noc__strm_data_valid   ;
  // lane3 from NoC 
  assign sdp__cntl__lane3_strm_ready             = stOp_lane[3].stOp__noc__strm_ready  ;
  assign stOp_lane[3].noc__stOp__strm_cntl       = cntl__sdp__lane3_strm_cntl          ;
  assign stOp_lane[3].noc__stOp__strm_id         = cntl__sdp__lane3_strm_id            ;
  assign stOp_lane[3].noc__stOp__strm_data       = cntl__sdp__lane3_strm_data          ;
  assign stOp_lane[3].noc__stOp__strm_data_valid = cntl__sdp__lane3_strm_data_valid    ;
  // lane3 to NoC 
  assign stOp_lane[3].noc__stOp__strm_ready       = cntl__sdp__lane3_strm_ready               ;
  assign sdp__cntl__lane3_strm_cntl               = stOp_lane[3].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane3_strm_id                 = stOp_lane[3].stOp__noc__strm_id           ;
  assign sdp__cntl__lane3_strm_data               = stOp_lane[3].stOp__noc__strm_data         ;
  assign sdp__cntl__lane3_strm_data_valid         = stOp_lane[3].stOp__noc__strm_data_valid   ;
  // lane4 from NoC 
  assign sdp__cntl__lane4_strm_ready             = stOp_lane[4].stOp__noc__strm_ready  ;
  assign stOp_lane[4].noc__stOp__strm_cntl       = cntl__sdp__lane4_strm_cntl          ;
  assign stOp_lane[4].noc__stOp__strm_id         = cntl__sdp__lane4_strm_id            ;
  assign stOp_lane[4].noc__stOp__strm_data       = cntl__sdp__lane4_strm_data          ;
  assign stOp_lane[4].noc__stOp__strm_data_valid = cntl__sdp__lane4_strm_data_valid    ;
  // lane4 to NoC 
  assign stOp_lane[4].noc__stOp__strm_ready       = cntl__sdp__lane4_strm_ready               ;
  assign sdp__cntl__lane4_strm_cntl               = stOp_lane[4].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane4_strm_id                 = stOp_lane[4].stOp__noc__strm_id           ;
  assign sdp__cntl__lane4_strm_data               = stOp_lane[4].stOp__noc__strm_data         ;
  assign sdp__cntl__lane4_strm_data_valid         = stOp_lane[4].stOp__noc__strm_data_valid   ;
  // lane5 from NoC 
  assign sdp__cntl__lane5_strm_ready             = stOp_lane[5].stOp__noc__strm_ready  ;
  assign stOp_lane[5].noc__stOp__strm_cntl       = cntl__sdp__lane5_strm_cntl          ;
  assign stOp_lane[5].noc__stOp__strm_id         = cntl__sdp__lane5_strm_id            ;
  assign stOp_lane[5].noc__stOp__strm_data       = cntl__sdp__lane5_strm_data          ;
  assign stOp_lane[5].noc__stOp__strm_data_valid = cntl__sdp__lane5_strm_data_valid    ;
  // lane5 to NoC 
  assign stOp_lane[5].noc__stOp__strm_ready       = cntl__sdp__lane5_strm_ready               ;
  assign sdp__cntl__lane5_strm_cntl               = stOp_lane[5].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane5_strm_id                 = stOp_lane[5].stOp__noc__strm_id           ;
  assign sdp__cntl__lane5_strm_data               = stOp_lane[5].stOp__noc__strm_data         ;
  assign sdp__cntl__lane5_strm_data_valid         = stOp_lane[5].stOp__noc__strm_data_valid   ;
  // lane6 from NoC 
  assign sdp__cntl__lane6_strm_ready             = stOp_lane[6].stOp__noc__strm_ready  ;
  assign stOp_lane[6].noc__stOp__strm_cntl       = cntl__sdp__lane6_strm_cntl          ;
  assign stOp_lane[6].noc__stOp__strm_id         = cntl__sdp__lane6_strm_id            ;
  assign stOp_lane[6].noc__stOp__strm_data       = cntl__sdp__lane6_strm_data          ;
  assign stOp_lane[6].noc__stOp__strm_data_valid = cntl__sdp__lane6_strm_data_valid    ;
  // lane6 to NoC 
  assign stOp_lane[6].noc__stOp__strm_ready       = cntl__sdp__lane6_strm_ready               ;
  assign sdp__cntl__lane6_strm_cntl               = stOp_lane[6].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane6_strm_id                 = stOp_lane[6].stOp__noc__strm_id           ;
  assign sdp__cntl__lane6_strm_data               = stOp_lane[6].stOp__noc__strm_data         ;
  assign sdp__cntl__lane6_strm_data_valid         = stOp_lane[6].stOp__noc__strm_data_valid   ;
  // lane7 from NoC 
  assign sdp__cntl__lane7_strm_ready             = stOp_lane[7].stOp__noc__strm_ready  ;
  assign stOp_lane[7].noc__stOp__strm_cntl       = cntl__sdp__lane7_strm_cntl          ;
  assign stOp_lane[7].noc__stOp__strm_id         = cntl__sdp__lane7_strm_id            ;
  assign stOp_lane[7].noc__stOp__strm_data       = cntl__sdp__lane7_strm_data          ;
  assign stOp_lane[7].noc__stOp__strm_data_valid = cntl__sdp__lane7_strm_data_valid    ;
  // lane7 to NoC 
  assign stOp_lane[7].noc__stOp__strm_ready       = cntl__sdp__lane7_strm_ready               ;
  assign sdp__cntl__lane7_strm_cntl               = stOp_lane[7].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane7_strm_id                 = stOp_lane[7].stOp__noc__strm_id           ;
  assign sdp__cntl__lane7_strm_data               = stOp_lane[7].stOp__noc__strm_data         ;
  assign sdp__cntl__lane7_strm_data_valid         = stOp_lane[7].stOp__noc__strm_data_valid   ;
  // lane8 from NoC 
  assign sdp__cntl__lane8_strm_ready             = stOp_lane[8].stOp__noc__strm_ready  ;
  assign stOp_lane[8].noc__stOp__strm_cntl       = cntl__sdp__lane8_strm_cntl          ;
  assign stOp_lane[8].noc__stOp__strm_id         = cntl__sdp__lane8_strm_id            ;
  assign stOp_lane[8].noc__stOp__strm_data       = cntl__sdp__lane8_strm_data          ;
  assign stOp_lane[8].noc__stOp__strm_data_valid = cntl__sdp__lane8_strm_data_valid    ;
  // lane8 to NoC 
  assign stOp_lane[8].noc__stOp__strm_ready       = cntl__sdp__lane8_strm_ready               ;
  assign sdp__cntl__lane8_strm_cntl               = stOp_lane[8].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane8_strm_id                 = stOp_lane[8].stOp__noc__strm_id           ;
  assign sdp__cntl__lane8_strm_data               = stOp_lane[8].stOp__noc__strm_data         ;
  assign sdp__cntl__lane8_strm_data_valid         = stOp_lane[8].stOp__noc__strm_data_valid   ;
  // lane9 from NoC 
  assign sdp__cntl__lane9_strm_ready             = stOp_lane[9].stOp__noc__strm_ready  ;
  assign stOp_lane[9].noc__stOp__strm_cntl       = cntl__sdp__lane9_strm_cntl          ;
  assign stOp_lane[9].noc__stOp__strm_id         = cntl__sdp__lane9_strm_id            ;
  assign stOp_lane[9].noc__stOp__strm_data       = cntl__sdp__lane9_strm_data          ;
  assign stOp_lane[9].noc__stOp__strm_data_valid = cntl__sdp__lane9_strm_data_valid    ;
  // lane9 to NoC 
  assign stOp_lane[9].noc__stOp__strm_ready       = cntl__sdp__lane9_strm_ready               ;
  assign sdp__cntl__lane9_strm_cntl               = stOp_lane[9].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane9_strm_id                 = stOp_lane[9].stOp__noc__strm_id           ;
  assign sdp__cntl__lane9_strm_data               = stOp_lane[9].stOp__noc__strm_data         ;
  assign sdp__cntl__lane9_strm_data_valid         = stOp_lane[9].stOp__noc__strm_data_valid   ;
  // lane10 from NoC 
  assign sdp__cntl__lane10_strm_ready             = stOp_lane[10].stOp__noc__strm_ready  ;
  assign stOp_lane[10].noc__stOp__strm_cntl       = cntl__sdp__lane10_strm_cntl          ;
  assign stOp_lane[10].noc__stOp__strm_id         = cntl__sdp__lane10_strm_id            ;
  assign stOp_lane[10].noc__stOp__strm_data       = cntl__sdp__lane10_strm_data          ;
  assign stOp_lane[10].noc__stOp__strm_data_valid = cntl__sdp__lane10_strm_data_valid    ;
  // lane10 to NoC 
  assign stOp_lane[10].noc__stOp__strm_ready       = cntl__sdp__lane10_strm_ready               ;
  assign sdp__cntl__lane10_strm_cntl               = stOp_lane[10].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane10_strm_id                 = stOp_lane[10].stOp__noc__strm_id           ;
  assign sdp__cntl__lane10_strm_data               = stOp_lane[10].stOp__noc__strm_data         ;
  assign sdp__cntl__lane10_strm_data_valid         = stOp_lane[10].stOp__noc__strm_data_valid   ;
  // lane11 from NoC 
  assign sdp__cntl__lane11_strm_ready             = stOp_lane[11].stOp__noc__strm_ready  ;
  assign stOp_lane[11].noc__stOp__strm_cntl       = cntl__sdp__lane11_strm_cntl          ;
  assign stOp_lane[11].noc__stOp__strm_id         = cntl__sdp__lane11_strm_id            ;
  assign stOp_lane[11].noc__stOp__strm_data       = cntl__sdp__lane11_strm_data          ;
  assign stOp_lane[11].noc__stOp__strm_data_valid = cntl__sdp__lane11_strm_data_valid    ;
  // lane11 to NoC 
  assign stOp_lane[11].noc__stOp__strm_ready       = cntl__sdp__lane11_strm_ready               ;
  assign sdp__cntl__lane11_strm_cntl               = stOp_lane[11].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane11_strm_id                 = stOp_lane[11].stOp__noc__strm_id           ;
  assign sdp__cntl__lane11_strm_data               = stOp_lane[11].stOp__noc__strm_data         ;
  assign sdp__cntl__lane11_strm_data_valid         = stOp_lane[11].stOp__noc__strm_data_valid   ;
  // lane12 from NoC 
  assign sdp__cntl__lane12_strm_ready             = stOp_lane[12].stOp__noc__strm_ready  ;
  assign stOp_lane[12].noc__stOp__strm_cntl       = cntl__sdp__lane12_strm_cntl          ;
  assign stOp_lane[12].noc__stOp__strm_id         = cntl__sdp__lane12_strm_id            ;
  assign stOp_lane[12].noc__stOp__strm_data       = cntl__sdp__lane12_strm_data          ;
  assign stOp_lane[12].noc__stOp__strm_data_valid = cntl__sdp__lane12_strm_data_valid    ;
  // lane12 to NoC 
  assign stOp_lane[12].noc__stOp__strm_ready       = cntl__sdp__lane12_strm_ready               ;
  assign sdp__cntl__lane12_strm_cntl               = stOp_lane[12].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane12_strm_id                 = stOp_lane[12].stOp__noc__strm_id           ;
  assign sdp__cntl__lane12_strm_data               = stOp_lane[12].stOp__noc__strm_data         ;
  assign sdp__cntl__lane12_strm_data_valid         = stOp_lane[12].stOp__noc__strm_data_valid   ;
  // lane13 from NoC 
  assign sdp__cntl__lane13_strm_ready             = stOp_lane[13].stOp__noc__strm_ready  ;
  assign stOp_lane[13].noc__stOp__strm_cntl       = cntl__sdp__lane13_strm_cntl          ;
  assign stOp_lane[13].noc__stOp__strm_id         = cntl__sdp__lane13_strm_id            ;
  assign stOp_lane[13].noc__stOp__strm_data       = cntl__sdp__lane13_strm_data          ;
  assign stOp_lane[13].noc__stOp__strm_data_valid = cntl__sdp__lane13_strm_data_valid    ;
  // lane13 to NoC 
  assign stOp_lane[13].noc__stOp__strm_ready       = cntl__sdp__lane13_strm_ready               ;
  assign sdp__cntl__lane13_strm_cntl               = stOp_lane[13].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane13_strm_id                 = stOp_lane[13].stOp__noc__strm_id           ;
  assign sdp__cntl__lane13_strm_data               = stOp_lane[13].stOp__noc__strm_data         ;
  assign sdp__cntl__lane13_strm_data_valid         = stOp_lane[13].stOp__noc__strm_data_valid   ;
  // lane14 from NoC 
  assign sdp__cntl__lane14_strm_ready             = stOp_lane[14].stOp__noc__strm_ready  ;
  assign stOp_lane[14].noc__stOp__strm_cntl       = cntl__sdp__lane14_strm_cntl          ;
  assign stOp_lane[14].noc__stOp__strm_id         = cntl__sdp__lane14_strm_id            ;
  assign stOp_lane[14].noc__stOp__strm_data       = cntl__sdp__lane14_strm_data          ;
  assign stOp_lane[14].noc__stOp__strm_data_valid = cntl__sdp__lane14_strm_data_valid    ;
  // lane14 to NoC 
  assign stOp_lane[14].noc__stOp__strm_ready       = cntl__sdp__lane14_strm_ready               ;
  assign sdp__cntl__lane14_strm_cntl               = stOp_lane[14].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane14_strm_id                 = stOp_lane[14].stOp__noc__strm_id           ;
  assign sdp__cntl__lane14_strm_data               = stOp_lane[14].stOp__noc__strm_data         ;
  assign sdp__cntl__lane14_strm_data_valid         = stOp_lane[14].stOp__noc__strm_data_valid   ;
  // lane15 from NoC 
  assign sdp__cntl__lane15_strm_ready             = stOp_lane[15].stOp__noc__strm_ready  ;
  assign stOp_lane[15].noc__stOp__strm_cntl       = cntl__sdp__lane15_strm_cntl          ;
  assign stOp_lane[15].noc__stOp__strm_id         = cntl__sdp__lane15_strm_id            ;
  assign stOp_lane[15].noc__stOp__strm_data       = cntl__sdp__lane15_strm_data          ;
  assign stOp_lane[15].noc__stOp__strm_data_valid = cntl__sdp__lane15_strm_data_valid    ;
  // lane15 to NoC 
  assign stOp_lane[15].noc__stOp__strm_ready       = cntl__sdp__lane15_strm_ready               ;
  assign sdp__cntl__lane15_strm_cntl               = stOp_lane[15].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane15_strm_id                 = stOp_lane[15].stOp__noc__strm_id           ;
  assign sdp__cntl__lane15_strm_data               = stOp_lane[15].stOp__noc__strm_data         ;
  assign sdp__cntl__lane15_strm_data_valid         = stOp_lane[15].stOp__noc__strm_data_valid   ;
  // lane16 from NoC 
  assign sdp__cntl__lane16_strm_ready             = stOp_lane[16].stOp__noc__strm_ready  ;
  assign stOp_lane[16].noc__stOp__strm_cntl       = cntl__sdp__lane16_strm_cntl          ;
  assign stOp_lane[16].noc__stOp__strm_id         = cntl__sdp__lane16_strm_id            ;
  assign stOp_lane[16].noc__stOp__strm_data       = cntl__sdp__lane16_strm_data          ;
  assign stOp_lane[16].noc__stOp__strm_data_valid = cntl__sdp__lane16_strm_data_valid    ;
  // lane16 to NoC 
  assign stOp_lane[16].noc__stOp__strm_ready       = cntl__sdp__lane16_strm_ready               ;
  assign sdp__cntl__lane16_strm_cntl               = stOp_lane[16].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane16_strm_id                 = stOp_lane[16].stOp__noc__strm_id           ;
  assign sdp__cntl__lane16_strm_data               = stOp_lane[16].stOp__noc__strm_data         ;
  assign sdp__cntl__lane16_strm_data_valid         = stOp_lane[16].stOp__noc__strm_data_valid   ;
  // lane17 from NoC 
  assign sdp__cntl__lane17_strm_ready             = stOp_lane[17].stOp__noc__strm_ready  ;
  assign stOp_lane[17].noc__stOp__strm_cntl       = cntl__sdp__lane17_strm_cntl          ;
  assign stOp_lane[17].noc__stOp__strm_id         = cntl__sdp__lane17_strm_id            ;
  assign stOp_lane[17].noc__stOp__strm_data       = cntl__sdp__lane17_strm_data          ;
  assign stOp_lane[17].noc__stOp__strm_data_valid = cntl__sdp__lane17_strm_data_valid    ;
  // lane17 to NoC 
  assign stOp_lane[17].noc__stOp__strm_ready       = cntl__sdp__lane17_strm_ready               ;
  assign sdp__cntl__lane17_strm_cntl               = stOp_lane[17].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane17_strm_id                 = stOp_lane[17].stOp__noc__strm_id           ;
  assign sdp__cntl__lane17_strm_data               = stOp_lane[17].stOp__noc__strm_data         ;
  assign sdp__cntl__lane17_strm_data_valid         = stOp_lane[17].stOp__noc__strm_data_valid   ;
  // lane18 from NoC 
  assign sdp__cntl__lane18_strm_ready             = stOp_lane[18].stOp__noc__strm_ready  ;
  assign stOp_lane[18].noc__stOp__strm_cntl       = cntl__sdp__lane18_strm_cntl          ;
  assign stOp_lane[18].noc__stOp__strm_id         = cntl__sdp__lane18_strm_id            ;
  assign stOp_lane[18].noc__stOp__strm_data       = cntl__sdp__lane18_strm_data          ;
  assign stOp_lane[18].noc__stOp__strm_data_valid = cntl__sdp__lane18_strm_data_valid    ;
  // lane18 to NoC 
  assign stOp_lane[18].noc__stOp__strm_ready       = cntl__sdp__lane18_strm_ready               ;
  assign sdp__cntl__lane18_strm_cntl               = stOp_lane[18].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane18_strm_id                 = stOp_lane[18].stOp__noc__strm_id           ;
  assign sdp__cntl__lane18_strm_data               = stOp_lane[18].stOp__noc__strm_data         ;
  assign sdp__cntl__lane18_strm_data_valid         = stOp_lane[18].stOp__noc__strm_data_valid   ;
  // lane19 from NoC 
  assign sdp__cntl__lane19_strm_ready             = stOp_lane[19].stOp__noc__strm_ready  ;
  assign stOp_lane[19].noc__stOp__strm_cntl       = cntl__sdp__lane19_strm_cntl          ;
  assign stOp_lane[19].noc__stOp__strm_id         = cntl__sdp__lane19_strm_id            ;
  assign stOp_lane[19].noc__stOp__strm_data       = cntl__sdp__lane19_strm_data          ;
  assign stOp_lane[19].noc__stOp__strm_data_valid = cntl__sdp__lane19_strm_data_valid    ;
  // lane19 to NoC 
  assign stOp_lane[19].noc__stOp__strm_ready       = cntl__sdp__lane19_strm_ready               ;
  assign sdp__cntl__lane19_strm_cntl               = stOp_lane[19].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane19_strm_id                 = stOp_lane[19].stOp__noc__strm_id           ;
  assign sdp__cntl__lane19_strm_data               = stOp_lane[19].stOp__noc__strm_data         ;
  assign sdp__cntl__lane19_strm_data_valid         = stOp_lane[19].stOp__noc__strm_data_valid   ;
  // lane20 from NoC 
  assign sdp__cntl__lane20_strm_ready             = stOp_lane[20].stOp__noc__strm_ready  ;
  assign stOp_lane[20].noc__stOp__strm_cntl       = cntl__sdp__lane20_strm_cntl          ;
  assign stOp_lane[20].noc__stOp__strm_id         = cntl__sdp__lane20_strm_id            ;
  assign stOp_lane[20].noc__stOp__strm_data       = cntl__sdp__lane20_strm_data          ;
  assign stOp_lane[20].noc__stOp__strm_data_valid = cntl__sdp__lane20_strm_data_valid    ;
  // lane20 to NoC 
  assign stOp_lane[20].noc__stOp__strm_ready       = cntl__sdp__lane20_strm_ready               ;
  assign sdp__cntl__lane20_strm_cntl               = stOp_lane[20].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane20_strm_id                 = stOp_lane[20].stOp__noc__strm_id           ;
  assign sdp__cntl__lane20_strm_data               = stOp_lane[20].stOp__noc__strm_data         ;
  assign sdp__cntl__lane20_strm_data_valid         = stOp_lane[20].stOp__noc__strm_data_valid   ;
  // lane21 from NoC 
  assign sdp__cntl__lane21_strm_ready             = stOp_lane[21].stOp__noc__strm_ready  ;
  assign stOp_lane[21].noc__stOp__strm_cntl       = cntl__sdp__lane21_strm_cntl          ;
  assign stOp_lane[21].noc__stOp__strm_id         = cntl__sdp__lane21_strm_id            ;
  assign stOp_lane[21].noc__stOp__strm_data       = cntl__sdp__lane21_strm_data          ;
  assign stOp_lane[21].noc__stOp__strm_data_valid = cntl__sdp__lane21_strm_data_valid    ;
  // lane21 to NoC 
  assign stOp_lane[21].noc__stOp__strm_ready       = cntl__sdp__lane21_strm_ready               ;
  assign sdp__cntl__lane21_strm_cntl               = stOp_lane[21].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane21_strm_id                 = stOp_lane[21].stOp__noc__strm_id           ;
  assign sdp__cntl__lane21_strm_data               = stOp_lane[21].stOp__noc__strm_data         ;
  assign sdp__cntl__lane21_strm_data_valid         = stOp_lane[21].stOp__noc__strm_data_valid   ;
  // lane22 from NoC 
  assign sdp__cntl__lane22_strm_ready             = stOp_lane[22].stOp__noc__strm_ready  ;
  assign stOp_lane[22].noc__stOp__strm_cntl       = cntl__sdp__lane22_strm_cntl          ;
  assign stOp_lane[22].noc__stOp__strm_id         = cntl__sdp__lane22_strm_id            ;
  assign stOp_lane[22].noc__stOp__strm_data       = cntl__sdp__lane22_strm_data          ;
  assign stOp_lane[22].noc__stOp__strm_data_valid = cntl__sdp__lane22_strm_data_valid    ;
  // lane22 to NoC 
  assign stOp_lane[22].noc__stOp__strm_ready       = cntl__sdp__lane22_strm_ready               ;
  assign sdp__cntl__lane22_strm_cntl               = stOp_lane[22].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane22_strm_id                 = stOp_lane[22].stOp__noc__strm_id           ;
  assign sdp__cntl__lane22_strm_data               = stOp_lane[22].stOp__noc__strm_data         ;
  assign sdp__cntl__lane22_strm_data_valid         = stOp_lane[22].stOp__noc__strm_data_valid   ;
  // lane23 from NoC 
  assign sdp__cntl__lane23_strm_ready             = stOp_lane[23].stOp__noc__strm_ready  ;
  assign stOp_lane[23].noc__stOp__strm_cntl       = cntl__sdp__lane23_strm_cntl          ;
  assign stOp_lane[23].noc__stOp__strm_id         = cntl__sdp__lane23_strm_id            ;
  assign stOp_lane[23].noc__stOp__strm_data       = cntl__sdp__lane23_strm_data          ;
  assign stOp_lane[23].noc__stOp__strm_data_valid = cntl__sdp__lane23_strm_data_valid    ;
  // lane23 to NoC 
  assign stOp_lane[23].noc__stOp__strm_ready       = cntl__sdp__lane23_strm_ready               ;
  assign sdp__cntl__lane23_strm_cntl               = stOp_lane[23].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane23_strm_id                 = stOp_lane[23].stOp__noc__strm_id           ;
  assign sdp__cntl__lane23_strm_data               = stOp_lane[23].stOp__noc__strm_data         ;
  assign sdp__cntl__lane23_strm_data_valid         = stOp_lane[23].stOp__noc__strm_data_valid   ;
  // lane24 from NoC 
  assign sdp__cntl__lane24_strm_ready             = stOp_lane[24].stOp__noc__strm_ready  ;
  assign stOp_lane[24].noc__stOp__strm_cntl       = cntl__sdp__lane24_strm_cntl          ;
  assign stOp_lane[24].noc__stOp__strm_id         = cntl__sdp__lane24_strm_id            ;
  assign stOp_lane[24].noc__stOp__strm_data       = cntl__sdp__lane24_strm_data          ;
  assign stOp_lane[24].noc__stOp__strm_data_valid = cntl__sdp__lane24_strm_data_valid    ;
  // lane24 to NoC 
  assign stOp_lane[24].noc__stOp__strm_ready       = cntl__sdp__lane24_strm_ready               ;
  assign sdp__cntl__lane24_strm_cntl               = stOp_lane[24].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane24_strm_id                 = stOp_lane[24].stOp__noc__strm_id           ;
  assign sdp__cntl__lane24_strm_data               = stOp_lane[24].stOp__noc__strm_data         ;
  assign sdp__cntl__lane24_strm_data_valid         = stOp_lane[24].stOp__noc__strm_data_valid   ;
  // lane25 from NoC 
  assign sdp__cntl__lane25_strm_ready             = stOp_lane[25].stOp__noc__strm_ready  ;
  assign stOp_lane[25].noc__stOp__strm_cntl       = cntl__sdp__lane25_strm_cntl          ;
  assign stOp_lane[25].noc__stOp__strm_id         = cntl__sdp__lane25_strm_id            ;
  assign stOp_lane[25].noc__stOp__strm_data       = cntl__sdp__lane25_strm_data          ;
  assign stOp_lane[25].noc__stOp__strm_data_valid = cntl__sdp__lane25_strm_data_valid    ;
  // lane25 to NoC 
  assign stOp_lane[25].noc__stOp__strm_ready       = cntl__sdp__lane25_strm_ready               ;
  assign sdp__cntl__lane25_strm_cntl               = stOp_lane[25].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane25_strm_id                 = stOp_lane[25].stOp__noc__strm_id           ;
  assign sdp__cntl__lane25_strm_data               = stOp_lane[25].stOp__noc__strm_data         ;
  assign sdp__cntl__lane25_strm_data_valid         = stOp_lane[25].stOp__noc__strm_data_valid   ;
  // lane26 from NoC 
  assign sdp__cntl__lane26_strm_ready             = stOp_lane[26].stOp__noc__strm_ready  ;
  assign stOp_lane[26].noc__stOp__strm_cntl       = cntl__sdp__lane26_strm_cntl          ;
  assign stOp_lane[26].noc__stOp__strm_id         = cntl__sdp__lane26_strm_id            ;
  assign stOp_lane[26].noc__stOp__strm_data       = cntl__sdp__lane26_strm_data          ;
  assign stOp_lane[26].noc__stOp__strm_data_valid = cntl__sdp__lane26_strm_data_valid    ;
  // lane26 to NoC 
  assign stOp_lane[26].noc__stOp__strm_ready       = cntl__sdp__lane26_strm_ready               ;
  assign sdp__cntl__lane26_strm_cntl               = stOp_lane[26].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane26_strm_id                 = stOp_lane[26].stOp__noc__strm_id           ;
  assign sdp__cntl__lane26_strm_data               = stOp_lane[26].stOp__noc__strm_data         ;
  assign sdp__cntl__lane26_strm_data_valid         = stOp_lane[26].stOp__noc__strm_data_valid   ;
  // lane27 from NoC 
  assign sdp__cntl__lane27_strm_ready             = stOp_lane[27].stOp__noc__strm_ready  ;
  assign stOp_lane[27].noc__stOp__strm_cntl       = cntl__sdp__lane27_strm_cntl          ;
  assign stOp_lane[27].noc__stOp__strm_id         = cntl__sdp__lane27_strm_id            ;
  assign stOp_lane[27].noc__stOp__strm_data       = cntl__sdp__lane27_strm_data          ;
  assign stOp_lane[27].noc__stOp__strm_data_valid = cntl__sdp__lane27_strm_data_valid    ;
  // lane27 to NoC 
  assign stOp_lane[27].noc__stOp__strm_ready       = cntl__sdp__lane27_strm_ready               ;
  assign sdp__cntl__lane27_strm_cntl               = stOp_lane[27].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane27_strm_id                 = stOp_lane[27].stOp__noc__strm_id           ;
  assign sdp__cntl__lane27_strm_data               = stOp_lane[27].stOp__noc__strm_data         ;
  assign sdp__cntl__lane27_strm_data_valid         = stOp_lane[27].stOp__noc__strm_data_valid   ;
  // lane28 from NoC 
  assign sdp__cntl__lane28_strm_ready             = stOp_lane[28].stOp__noc__strm_ready  ;
  assign stOp_lane[28].noc__stOp__strm_cntl       = cntl__sdp__lane28_strm_cntl          ;
  assign stOp_lane[28].noc__stOp__strm_id         = cntl__sdp__lane28_strm_id            ;
  assign stOp_lane[28].noc__stOp__strm_data       = cntl__sdp__lane28_strm_data          ;
  assign stOp_lane[28].noc__stOp__strm_data_valid = cntl__sdp__lane28_strm_data_valid    ;
  // lane28 to NoC 
  assign stOp_lane[28].noc__stOp__strm_ready       = cntl__sdp__lane28_strm_ready               ;
  assign sdp__cntl__lane28_strm_cntl               = stOp_lane[28].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane28_strm_id                 = stOp_lane[28].stOp__noc__strm_id           ;
  assign sdp__cntl__lane28_strm_data               = stOp_lane[28].stOp__noc__strm_data         ;
  assign sdp__cntl__lane28_strm_data_valid         = stOp_lane[28].stOp__noc__strm_data_valid   ;
  // lane29 from NoC 
  assign sdp__cntl__lane29_strm_ready             = stOp_lane[29].stOp__noc__strm_ready  ;
  assign stOp_lane[29].noc__stOp__strm_cntl       = cntl__sdp__lane29_strm_cntl          ;
  assign stOp_lane[29].noc__stOp__strm_id         = cntl__sdp__lane29_strm_id            ;
  assign stOp_lane[29].noc__stOp__strm_data       = cntl__sdp__lane29_strm_data          ;
  assign stOp_lane[29].noc__stOp__strm_data_valid = cntl__sdp__lane29_strm_data_valid    ;
  // lane29 to NoC 
  assign stOp_lane[29].noc__stOp__strm_ready       = cntl__sdp__lane29_strm_ready               ;
  assign sdp__cntl__lane29_strm_cntl               = stOp_lane[29].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane29_strm_id                 = stOp_lane[29].stOp__noc__strm_id           ;
  assign sdp__cntl__lane29_strm_data               = stOp_lane[29].stOp__noc__strm_data         ;
  assign sdp__cntl__lane29_strm_data_valid         = stOp_lane[29].stOp__noc__strm_data_valid   ;
  // lane30 from NoC 
  assign sdp__cntl__lane30_strm_ready             = stOp_lane[30].stOp__noc__strm_ready  ;
  assign stOp_lane[30].noc__stOp__strm_cntl       = cntl__sdp__lane30_strm_cntl          ;
  assign stOp_lane[30].noc__stOp__strm_id         = cntl__sdp__lane30_strm_id            ;
  assign stOp_lane[30].noc__stOp__strm_data       = cntl__sdp__lane30_strm_data          ;
  assign stOp_lane[30].noc__stOp__strm_data_valid = cntl__sdp__lane30_strm_data_valid    ;
  // lane30 to NoC 
  assign stOp_lane[30].noc__stOp__strm_ready       = cntl__sdp__lane30_strm_ready               ;
  assign sdp__cntl__lane30_strm_cntl               = stOp_lane[30].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane30_strm_id                 = stOp_lane[30].stOp__noc__strm_id           ;
  assign sdp__cntl__lane30_strm_data               = stOp_lane[30].stOp__noc__strm_data         ;
  assign sdp__cntl__lane30_strm_data_valid         = stOp_lane[30].stOp__noc__strm_data_valid   ;
  // lane31 from NoC 
  assign sdp__cntl__lane31_strm_ready             = stOp_lane[31].stOp__noc__strm_ready  ;
  assign stOp_lane[31].noc__stOp__strm_cntl       = cntl__sdp__lane31_strm_cntl          ;
  assign stOp_lane[31].noc__stOp__strm_id         = cntl__sdp__lane31_strm_id            ;
  assign stOp_lane[31].noc__stOp__strm_data       = cntl__sdp__lane31_strm_data          ;
  assign stOp_lane[31].noc__stOp__strm_data_valid = cntl__sdp__lane31_strm_data_valid    ;
  // lane31 to NoC 
  assign stOp_lane[31].noc__stOp__strm_ready       = cntl__sdp__lane31_strm_ready               ;
  assign sdp__cntl__lane31_strm_cntl               = stOp_lane[31].stOp__noc__strm_cntl         ;
  assign sdp__cntl__lane31_strm_id                 = stOp_lane[31].stOp__noc__strm_id           ;
  assign sdp__cntl__lane31_strm_data               = stOp_lane[31].stOp__noc__strm_data         ;
  assign sdp__cntl__lane31_strm_data_valid         = stOp_lane[31].stOp__noc__strm_data_valid   ;