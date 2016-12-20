
   // Aggregate Control-path (cp) to NoC 
   input                                             noc__cntl__cp_ready      ; 
   output [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] cntl__noc__cp_cntl       ; 
   output [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__cp_type       ; 
   output [`PE_NOC_INTERNAL_DATA_RANGE             ] cntl__noc__cp_data       ; 
   output [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__cp_laneId     ; 
   output                                            cntl__noc__cp_strmId     ; 
   output                                            cntl__noc__cp_valid      ; 
   // Aggregate Data-path (cp) from NoC 
   output                                            cntl__noc__cp_ready      ; 
   input  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__cntl__cp_cntl       ; 
   input  [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__cntl__cp_type       ; 
   input  [`PE_NOC_INTERNAL_DATA_RANGE             ] noc__cntl__cp_data       ; 
   input  [`PE_PE_ID_RANGE                         ] noc__cntl__cp_peId       ; 
   input  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__cntl__cp_laneId     ; 
   input                                             noc__cntl__cp_strmId     ; 
   input                                             noc__cntl__cp_valid      ; 

   // Aggregate Data-path (dp) to NoC 
   input                                             noc__cntl__dp_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE       ] cntl__noc__dp_cntl       ; 
   output [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__dp_type       ; 
   output [`PE_PE_ID_RANGE                         ] cntl__noc__dp_peId       ; 
   output [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__dp_laneId     ; 
   output                                            cntl__noc__dp_strmId     ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE            ] cntl__noc__dp_data       ; 
   output                                            cntl__noc__dp_valid      ; 
   // Aggregate Data-path (dp) from NoC 
   output                                            cntl__noc__dp_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE       ] noc__cntl__dp_cntl       ; 
   input  [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__cntl__dp_type       ; 
   input  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__cntl__dp_laneId     ; 
   input                                             noc__cntl__dp_strmId     ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE            ] noc__cntl__dp_data       ; 
   input                                             noc__cntl__dp_valid      ; 

   // lane0 from NoC 
   input                                            sdp__cntl__lane0_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane0_strm_cntl       ; 
   output                                           cntl__sdp__lane0_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane0_strm_data       ; 
   output                                           cntl__sdp__lane0_strm_data_valid ; 
   // lane0 to NoC 
   output                                           cntl__sdp__lane0_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane0_strm_cntl       ; 
   input                                            sdp__cntl__lane0_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane0_strm_data       ; 
   input                                            sdp__cntl__lane0_strm_data_valid ; 
   // lane1 from NoC 
   input                                            sdp__cntl__lane1_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane1_strm_cntl       ; 
   output                                           cntl__sdp__lane1_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane1_strm_data       ; 
   output                                           cntl__sdp__lane1_strm_data_valid ; 
   // lane1 to NoC 
   output                                           cntl__sdp__lane1_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane1_strm_cntl       ; 
   input                                            sdp__cntl__lane1_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane1_strm_data       ; 
   input                                            sdp__cntl__lane1_strm_data_valid ; 
   // lane2 from NoC 
   input                                            sdp__cntl__lane2_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane2_strm_cntl       ; 
   output                                           cntl__sdp__lane2_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane2_strm_data       ; 
   output                                           cntl__sdp__lane2_strm_data_valid ; 
   // lane2 to NoC 
   output                                           cntl__sdp__lane2_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane2_strm_cntl       ; 
   input                                            sdp__cntl__lane2_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane2_strm_data       ; 
   input                                            sdp__cntl__lane2_strm_data_valid ; 
   // lane3 from NoC 
   input                                            sdp__cntl__lane3_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane3_strm_cntl       ; 
   output                                           cntl__sdp__lane3_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane3_strm_data       ; 
   output                                           cntl__sdp__lane3_strm_data_valid ; 
   // lane3 to NoC 
   output                                           cntl__sdp__lane3_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane3_strm_cntl       ; 
   input                                            sdp__cntl__lane3_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane3_strm_data       ; 
   input                                            sdp__cntl__lane3_strm_data_valid ; 
   // lane4 from NoC 
   input                                            sdp__cntl__lane4_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane4_strm_cntl       ; 
   output                                           cntl__sdp__lane4_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane4_strm_data       ; 
   output                                           cntl__sdp__lane4_strm_data_valid ; 
   // lane4 to NoC 
   output                                           cntl__sdp__lane4_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane4_strm_cntl       ; 
   input                                            sdp__cntl__lane4_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane4_strm_data       ; 
   input                                            sdp__cntl__lane4_strm_data_valid ; 
   // lane5 from NoC 
   input                                            sdp__cntl__lane5_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane5_strm_cntl       ; 
   output                                           cntl__sdp__lane5_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane5_strm_data       ; 
   output                                           cntl__sdp__lane5_strm_data_valid ; 
   // lane5 to NoC 
   output                                           cntl__sdp__lane5_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane5_strm_cntl       ; 
   input                                            sdp__cntl__lane5_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane5_strm_data       ; 
   input                                            sdp__cntl__lane5_strm_data_valid ; 
   // lane6 from NoC 
   input                                            sdp__cntl__lane6_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane6_strm_cntl       ; 
   output                                           cntl__sdp__lane6_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane6_strm_data       ; 
   output                                           cntl__sdp__lane6_strm_data_valid ; 
   // lane6 to NoC 
   output                                           cntl__sdp__lane6_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane6_strm_cntl       ; 
   input                                            sdp__cntl__lane6_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane6_strm_data       ; 
   input                                            sdp__cntl__lane6_strm_data_valid ; 
   // lane7 from NoC 
   input                                            sdp__cntl__lane7_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane7_strm_cntl       ; 
   output                                           cntl__sdp__lane7_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane7_strm_data       ; 
   output                                           cntl__sdp__lane7_strm_data_valid ; 
   // lane7 to NoC 
   output                                           cntl__sdp__lane7_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane7_strm_cntl       ; 
   input                                            sdp__cntl__lane7_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane7_strm_data       ; 
   input                                            sdp__cntl__lane7_strm_data_valid ; 
   // lane8 from NoC 
   input                                            sdp__cntl__lane8_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane8_strm_cntl       ; 
   output                                           cntl__sdp__lane8_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane8_strm_data       ; 
   output                                           cntl__sdp__lane8_strm_data_valid ; 
   // lane8 to NoC 
   output                                           cntl__sdp__lane8_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane8_strm_cntl       ; 
   input                                            sdp__cntl__lane8_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane8_strm_data       ; 
   input                                            sdp__cntl__lane8_strm_data_valid ; 
   // lane9 from NoC 
   input                                            sdp__cntl__lane9_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane9_strm_cntl       ; 
   output                                           cntl__sdp__lane9_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane9_strm_data       ; 
   output                                           cntl__sdp__lane9_strm_data_valid ; 
   // lane9 to NoC 
   output                                           cntl__sdp__lane9_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane9_strm_cntl       ; 
   input                                            sdp__cntl__lane9_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane9_strm_data       ; 
   input                                            sdp__cntl__lane9_strm_data_valid ; 
   // lane10 from NoC 
   input                                            sdp__cntl__lane10_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane10_strm_cntl       ; 
   output                                           cntl__sdp__lane10_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane10_strm_data       ; 
   output                                           cntl__sdp__lane10_strm_data_valid ; 
   // lane10 to NoC 
   output                                           cntl__sdp__lane10_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane10_strm_cntl       ; 
   input                                            sdp__cntl__lane10_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane10_strm_data       ; 
   input                                            sdp__cntl__lane10_strm_data_valid ; 
   // lane11 from NoC 
   input                                            sdp__cntl__lane11_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane11_strm_cntl       ; 
   output                                           cntl__sdp__lane11_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane11_strm_data       ; 
   output                                           cntl__sdp__lane11_strm_data_valid ; 
   // lane11 to NoC 
   output                                           cntl__sdp__lane11_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane11_strm_cntl       ; 
   input                                            sdp__cntl__lane11_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane11_strm_data       ; 
   input                                            sdp__cntl__lane11_strm_data_valid ; 
   // lane12 from NoC 
   input                                            sdp__cntl__lane12_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane12_strm_cntl       ; 
   output                                           cntl__sdp__lane12_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane12_strm_data       ; 
   output                                           cntl__sdp__lane12_strm_data_valid ; 
   // lane12 to NoC 
   output                                           cntl__sdp__lane12_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane12_strm_cntl       ; 
   input                                            sdp__cntl__lane12_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane12_strm_data       ; 
   input                                            sdp__cntl__lane12_strm_data_valid ; 
   // lane13 from NoC 
   input                                            sdp__cntl__lane13_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane13_strm_cntl       ; 
   output                                           cntl__sdp__lane13_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane13_strm_data       ; 
   output                                           cntl__sdp__lane13_strm_data_valid ; 
   // lane13 to NoC 
   output                                           cntl__sdp__lane13_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane13_strm_cntl       ; 
   input                                            sdp__cntl__lane13_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane13_strm_data       ; 
   input                                            sdp__cntl__lane13_strm_data_valid ; 
   // lane14 from NoC 
   input                                            sdp__cntl__lane14_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane14_strm_cntl       ; 
   output                                           cntl__sdp__lane14_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane14_strm_data       ; 
   output                                           cntl__sdp__lane14_strm_data_valid ; 
   // lane14 to NoC 
   output                                           cntl__sdp__lane14_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane14_strm_cntl       ; 
   input                                            sdp__cntl__lane14_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane14_strm_data       ; 
   input                                            sdp__cntl__lane14_strm_data_valid ; 
   // lane15 from NoC 
   input                                            sdp__cntl__lane15_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane15_strm_cntl       ; 
   output                                           cntl__sdp__lane15_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane15_strm_data       ; 
   output                                           cntl__sdp__lane15_strm_data_valid ; 
   // lane15 to NoC 
   output                                           cntl__sdp__lane15_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane15_strm_cntl       ; 
   input                                            sdp__cntl__lane15_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane15_strm_data       ; 
   input                                            sdp__cntl__lane15_strm_data_valid ; 
   // lane16 from NoC 
   input                                            sdp__cntl__lane16_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane16_strm_cntl       ; 
   output                                           cntl__sdp__lane16_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane16_strm_data       ; 
   output                                           cntl__sdp__lane16_strm_data_valid ; 
   // lane16 to NoC 
   output                                           cntl__sdp__lane16_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane16_strm_cntl       ; 
   input                                            sdp__cntl__lane16_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane16_strm_data       ; 
   input                                            sdp__cntl__lane16_strm_data_valid ; 
   // lane17 from NoC 
   input                                            sdp__cntl__lane17_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane17_strm_cntl       ; 
   output                                           cntl__sdp__lane17_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane17_strm_data       ; 
   output                                           cntl__sdp__lane17_strm_data_valid ; 
   // lane17 to NoC 
   output                                           cntl__sdp__lane17_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane17_strm_cntl       ; 
   input                                            sdp__cntl__lane17_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane17_strm_data       ; 
   input                                            sdp__cntl__lane17_strm_data_valid ; 
   // lane18 from NoC 
   input                                            sdp__cntl__lane18_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane18_strm_cntl       ; 
   output                                           cntl__sdp__lane18_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane18_strm_data       ; 
   output                                           cntl__sdp__lane18_strm_data_valid ; 
   // lane18 to NoC 
   output                                           cntl__sdp__lane18_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane18_strm_cntl       ; 
   input                                            sdp__cntl__lane18_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane18_strm_data       ; 
   input                                            sdp__cntl__lane18_strm_data_valid ; 
   // lane19 from NoC 
   input                                            sdp__cntl__lane19_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane19_strm_cntl       ; 
   output                                           cntl__sdp__lane19_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane19_strm_data       ; 
   output                                           cntl__sdp__lane19_strm_data_valid ; 
   // lane19 to NoC 
   output                                           cntl__sdp__lane19_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane19_strm_cntl       ; 
   input                                            sdp__cntl__lane19_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane19_strm_data       ; 
   input                                            sdp__cntl__lane19_strm_data_valid ; 
   // lane20 from NoC 
   input                                            sdp__cntl__lane20_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane20_strm_cntl       ; 
   output                                           cntl__sdp__lane20_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane20_strm_data       ; 
   output                                           cntl__sdp__lane20_strm_data_valid ; 
   // lane20 to NoC 
   output                                           cntl__sdp__lane20_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane20_strm_cntl       ; 
   input                                            sdp__cntl__lane20_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane20_strm_data       ; 
   input                                            sdp__cntl__lane20_strm_data_valid ; 
   // lane21 from NoC 
   input                                            sdp__cntl__lane21_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane21_strm_cntl       ; 
   output                                           cntl__sdp__lane21_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane21_strm_data       ; 
   output                                           cntl__sdp__lane21_strm_data_valid ; 
   // lane21 to NoC 
   output                                           cntl__sdp__lane21_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane21_strm_cntl       ; 
   input                                            sdp__cntl__lane21_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane21_strm_data       ; 
   input                                            sdp__cntl__lane21_strm_data_valid ; 
   // lane22 from NoC 
   input                                            sdp__cntl__lane22_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane22_strm_cntl       ; 
   output                                           cntl__sdp__lane22_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane22_strm_data       ; 
   output                                           cntl__sdp__lane22_strm_data_valid ; 
   // lane22 to NoC 
   output                                           cntl__sdp__lane22_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane22_strm_cntl       ; 
   input                                            sdp__cntl__lane22_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane22_strm_data       ; 
   input                                            sdp__cntl__lane22_strm_data_valid ; 
   // lane23 from NoC 
   input                                            sdp__cntl__lane23_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane23_strm_cntl       ; 
   output                                           cntl__sdp__lane23_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane23_strm_data       ; 
   output                                           cntl__sdp__lane23_strm_data_valid ; 
   // lane23 to NoC 
   output                                           cntl__sdp__lane23_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane23_strm_cntl       ; 
   input                                            sdp__cntl__lane23_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane23_strm_data       ; 
   input                                            sdp__cntl__lane23_strm_data_valid ; 
   // lane24 from NoC 
   input                                            sdp__cntl__lane24_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane24_strm_cntl       ; 
   output                                           cntl__sdp__lane24_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane24_strm_data       ; 
   output                                           cntl__sdp__lane24_strm_data_valid ; 
   // lane24 to NoC 
   output                                           cntl__sdp__lane24_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane24_strm_cntl       ; 
   input                                            sdp__cntl__lane24_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane24_strm_data       ; 
   input                                            sdp__cntl__lane24_strm_data_valid ; 
   // lane25 from NoC 
   input                                            sdp__cntl__lane25_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane25_strm_cntl       ; 
   output                                           cntl__sdp__lane25_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane25_strm_data       ; 
   output                                           cntl__sdp__lane25_strm_data_valid ; 
   // lane25 to NoC 
   output                                           cntl__sdp__lane25_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane25_strm_cntl       ; 
   input                                            sdp__cntl__lane25_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane25_strm_data       ; 
   input                                            sdp__cntl__lane25_strm_data_valid ; 
   // lane26 from NoC 
   input                                            sdp__cntl__lane26_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane26_strm_cntl       ; 
   output                                           cntl__sdp__lane26_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane26_strm_data       ; 
   output                                           cntl__sdp__lane26_strm_data_valid ; 
   // lane26 to NoC 
   output                                           cntl__sdp__lane26_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane26_strm_cntl       ; 
   input                                            sdp__cntl__lane26_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane26_strm_data       ; 
   input                                            sdp__cntl__lane26_strm_data_valid ; 
   // lane27 from NoC 
   input                                            sdp__cntl__lane27_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane27_strm_cntl       ; 
   output                                           cntl__sdp__lane27_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane27_strm_data       ; 
   output                                           cntl__sdp__lane27_strm_data_valid ; 
   // lane27 to NoC 
   output                                           cntl__sdp__lane27_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane27_strm_cntl       ; 
   input                                            sdp__cntl__lane27_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane27_strm_data       ; 
   input                                            sdp__cntl__lane27_strm_data_valid ; 
   // lane28 from NoC 
   input                                            sdp__cntl__lane28_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane28_strm_cntl       ; 
   output                                           cntl__sdp__lane28_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane28_strm_data       ; 
   output                                           cntl__sdp__lane28_strm_data_valid ; 
   // lane28 to NoC 
   output                                           cntl__sdp__lane28_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane28_strm_cntl       ; 
   input                                            sdp__cntl__lane28_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane28_strm_data       ; 
   input                                            sdp__cntl__lane28_strm_data_valid ; 
   // lane29 from NoC 
   input                                            sdp__cntl__lane29_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane29_strm_cntl       ; 
   output                                           cntl__sdp__lane29_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane29_strm_data       ; 
   output                                           cntl__sdp__lane29_strm_data_valid ; 
   // lane29 to NoC 
   output                                           cntl__sdp__lane29_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane29_strm_cntl       ; 
   input                                            sdp__cntl__lane29_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane29_strm_data       ; 
   input                                            sdp__cntl__lane29_strm_data_valid ; 
   // lane30 from NoC 
   input                                            sdp__cntl__lane30_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane30_strm_cntl       ; 
   output                                           cntl__sdp__lane30_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane30_strm_data       ; 
   output                                           cntl__sdp__lane30_strm_data_valid ; 
   // lane30 to NoC 
   output                                           cntl__sdp__lane30_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane30_strm_cntl       ; 
   input                                            sdp__cntl__lane30_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane30_strm_data       ; 
   input                                            sdp__cntl__lane30_strm_data_valid ; 
   // lane31 from NoC 
   input                                            sdp__cntl__lane31_strm_ready      ; 
   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane31_strm_cntl       ; 
   output                                           cntl__sdp__lane31_strm_id         ; 
   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane31_strm_data       ; 
   output                                           cntl__sdp__lane31_strm_data_valid ; 
   // lane31 to NoC 
   output                                           cntl__sdp__lane31_strm_ready      ; 
   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane31_strm_cntl       ; 
   input                                            sdp__cntl__lane31_strm_id         ; 
   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane31_strm_data       ; 
   input                                            sdp__cntl__lane31_strm_data_valid ; 
