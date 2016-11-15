
  // lane0, stream to NoC 
  assign     to_stOp_fifo[0].clear                           =  clear_op                           ;
  assign     lane0_toStOp_strm_fifo_empty           =  to_stOp_fifo[0].fifo_empty                ;
  assign     lane0_toStOp_strm_ready                = ~to_stOp_fifo[0].fifo_almost_full          ;
  assign     lane0_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[0].fifo_eop_count            ;
  assign     to_stOp_fifo[0].fifo_read                       =  lane0_toStOp_strm_fifo_read      ;
  assign     lane0_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[0].fifo_read_cntl            ;
  assign     lane0_toStOp_strm_fifo_read_id         =  to_stOp_fifo[0].fifo_read_strmId          ;
  assign     lane0_toStOp_strm_fifo_read_data       =  to_stOp_fifo[0].fifo_read_data            ;
  assign     to_stOp_fifo[0].cntl                            =  lane0_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[0].strmId                          =  lane0_toStOp_strm_id             ;
  assign     to_stOp_fifo[0].data                            =  lane0_toStOp_strm_data           ;
  assign     to_stOp_fifo[0].fifo_write                      =  lane0_toStOp_strm_fifo_write     ;
  assign     lane0_toStOp_strm_fifo_data_available  = ~lane0_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane0_toStOp_strm_fifo_read_valid             <=  lane0_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane1, stream to NoC 
  assign     to_stOp_fifo[1].clear                           =  clear_op                           ;
  assign     lane1_toStOp_strm_fifo_empty           =  to_stOp_fifo[1].fifo_empty                ;
  assign     lane1_toStOp_strm_ready                = ~to_stOp_fifo[1].fifo_almost_full          ;
  assign     lane1_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[1].fifo_eop_count            ;
  assign     to_stOp_fifo[1].fifo_read                       =  lane1_toStOp_strm_fifo_read      ;
  assign     lane1_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[1].fifo_read_cntl            ;
  assign     lane1_toStOp_strm_fifo_read_id         =  to_stOp_fifo[1].fifo_read_strmId          ;
  assign     lane1_toStOp_strm_fifo_read_data       =  to_stOp_fifo[1].fifo_read_data            ;
  assign     to_stOp_fifo[1].cntl                            =  lane1_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[1].strmId                          =  lane1_toStOp_strm_id             ;
  assign     to_stOp_fifo[1].data                            =  lane1_toStOp_strm_data           ;
  assign     to_stOp_fifo[1].fifo_write                      =  lane1_toStOp_strm_fifo_write     ;
  assign     lane1_toStOp_strm_fifo_data_available  = ~lane1_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane1_toStOp_strm_fifo_read_valid             <=  lane1_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane2, stream to NoC 
  assign     to_stOp_fifo[2].clear                           =  clear_op                           ;
  assign     lane2_toStOp_strm_fifo_empty           =  to_stOp_fifo[2].fifo_empty                ;
  assign     lane2_toStOp_strm_ready                = ~to_stOp_fifo[2].fifo_almost_full          ;
  assign     lane2_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[2].fifo_eop_count            ;
  assign     to_stOp_fifo[2].fifo_read                       =  lane2_toStOp_strm_fifo_read      ;
  assign     lane2_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[2].fifo_read_cntl            ;
  assign     lane2_toStOp_strm_fifo_read_id         =  to_stOp_fifo[2].fifo_read_strmId          ;
  assign     lane2_toStOp_strm_fifo_read_data       =  to_stOp_fifo[2].fifo_read_data            ;
  assign     to_stOp_fifo[2].cntl                            =  lane2_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[2].strmId                          =  lane2_toStOp_strm_id             ;
  assign     to_stOp_fifo[2].data                            =  lane2_toStOp_strm_data           ;
  assign     to_stOp_fifo[2].fifo_write                      =  lane2_toStOp_strm_fifo_write     ;
  assign     lane2_toStOp_strm_fifo_data_available  = ~lane2_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane2_toStOp_strm_fifo_read_valid             <=  lane2_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane3, stream to NoC 
  assign     to_stOp_fifo[3].clear                           =  clear_op                           ;
  assign     lane3_toStOp_strm_fifo_empty           =  to_stOp_fifo[3].fifo_empty                ;
  assign     lane3_toStOp_strm_ready                = ~to_stOp_fifo[3].fifo_almost_full          ;
  assign     lane3_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[3].fifo_eop_count            ;
  assign     to_stOp_fifo[3].fifo_read                       =  lane3_toStOp_strm_fifo_read      ;
  assign     lane3_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[3].fifo_read_cntl            ;
  assign     lane3_toStOp_strm_fifo_read_id         =  to_stOp_fifo[3].fifo_read_strmId          ;
  assign     lane3_toStOp_strm_fifo_read_data       =  to_stOp_fifo[3].fifo_read_data            ;
  assign     to_stOp_fifo[3].cntl                            =  lane3_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[3].strmId                          =  lane3_toStOp_strm_id             ;
  assign     to_stOp_fifo[3].data                            =  lane3_toStOp_strm_data           ;
  assign     to_stOp_fifo[3].fifo_write                      =  lane3_toStOp_strm_fifo_write     ;
  assign     lane3_toStOp_strm_fifo_data_available  = ~lane3_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane3_toStOp_strm_fifo_read_valid             <=  lane3_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane4, stream to NoC 
  assign     to_stOp_fifo[4].clear                           =  clear_op                           ;
  assign     lane4_toStOp_strm_fifo_empty           =  to_stOp_fifo[4].fifo_empty                ;
  assign     lane4_toStOp_strm_ready                = ~to_stOp_fifo[4].fifo_almost_full          ;
  assign     lane4_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[4].fifo_eop_count            ;
  assign     to_stOp_fifo[4].fifo_read                       =  lane4_toStOp_strm_fifo_read      ;
  assign     lane4_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[4].fifo_read_cntl            ;
  assign     lane4_toStOp_strm_fifo_read_id         =  to_stOp_fifo[4].fifo_read_strmId          ;
  assign     lane4_toStOp_strm_fifo_read_data       =  to_stOp_fifo[4].fifo_read_data            ;
  assign     to_stOp_fifo[4].cntl                            =  lane4_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[4].strmId                          =  lane4_toStOp_strm_id             ;
  assign     to_stOp_fifo[4].data                            =  lane4_toStOp_strm_data           ;
  assign     to_stOp_fifo[4].fifo_write                      =  lane4_toStOp_strm_fifo_write     ;
  assign     lane4_toStOp_strm_fifo_data_available  = ~lane4_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane4_toStOp_strm_fifo_read_valid             <=  lane4_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane5, stream to NoC 
  assign     to_stOp_fifo[5].clear                           =  clear_op                           ;
  assign     lane5_toStOp_strm_fifo_empty           =  to_stOp_fifo[5].fifo_empty                ;
  assign     lane5_toStOp_strm_ready                = ~to_stOp_fifo[5].fifo_almost_full          ;
  assign     lane5_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[5].fifo_eop_count            ;
  assign     to_stOp_fifo[5].fifo_read                       =  lane5_toStOp_strm_fifo_read      ;
  assign     lane5_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[5].fifo_read_cntl            ;
  assign     lane5_toStOp_strm_fifo_read_id         =  to_stOp_fifo[5].fifo_read_strmId          ;
  assign     lane5_toStOp_strm_fifo_read_data       =  to_stOp_fifo[5].fifo_read_data            ;
  assign     to_stOp_fifo[5].cntl                            =  lane5_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[5].strmId                          =  lane5_toStOp_strm_id             ;
  assign     to_stOp_fifo[5].data                            =  lane5_toStOp_strm_data           ;
  assign     to_stOp_fifo[5].fifo_write                      =  lane5_toStOp_strm_fifo_write     ;
  assign     lane5_toStOp_strm_fifo_data_available  = ~lane5_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane5_toStOp_strm_fifo_read_valid             <=  lane5_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane6, stream to NoC 
  assign     to_stOp_fifo[6].clear                           =  clear_op                           ;
  assign     lane6_toStOp_strm_fifo_empty           =  to_stOp_fifo[6].fifo_empty                ;
  assign     lane6_toStOp_strm_ready                = ~to_stOp_fifo[6].fifo_almost_full          ;
  assign     lane6_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[6].fifo_eop_count            ;
  assign     to_stOp_fifo[6].fifo_read                       =  lane6_toStOp_strm_fifo_read      ;
  assign     lane6_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[6].fifo_read_cntl            ;
  assign     lane6_toStOp_strm_fifo_read_id         =  to_stOp_fifo[6].fifo_read_strmId          ;
  assign     lane6_toStOp_strm_fifo_read_data       =  to_stOp_fifo[6].fifo_read_data            ;
  assign     to_stOp_fifo[6].cntl                            =  lane6_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[6].strmId                          =  lane6_toStOp_strm_id             ;
  assign     to_stOp_fifo[6].data                            =  lane6_toStOp_strm_data           ;
  assign     to_stOp_fifo[6].fifo_write                      =  lane6_toStOp_strm_fifo_write     ;
  assign     lane6_toStOp_strm_fifo_data_available  = ~lane6_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane6_toStOp_strm_fifo_read_valid             <=  lane6_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane7, stream to NoC 
  assign     to_stOp_fifo[7].clear                           =  clear_op                           ;
  assign     lane7_toStOp_strm_fifo_empty           =  to_stOp_fifo[7].fifo_empty                ;
  assign     lane7_toStOp_strm_ready                = ~to_stOp_fifo[7].fifo_almost_full          ;
  assign     lane7_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[7].fifo_eop_count            ;
  assign     to_stOp_fifo[7].fifo_read                       =  lane7_toStOp_strm_fifo_read      ;
  assign     lane7_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[7].fifo_read_cntl            ;
  assign     lane7_toStOp_strm_fifo_read_id         =  to_stOp_fifo[7].fifo_read_strmId          ;
  assign     lane7_toStOp_strm_fifo_read_data       =  to_stOp_fifo[7].fifo_read_data            ;
  assign     to_stOp_fifo[7].cntl                            =  lane7_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[7].strmId                          =  lane7_toStOp_strm_id             ;
  assign     to_stOp_fifo[7].data                            =  lane7_toStOp_strm_data           ;
  assign     to_stOp_fifo[7].fifo_write                      =  lane7_toStOp_strm_fifo_write     ;
  assign     lane7_toStOp_strm_fifo_data_available  = ~lane7_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane7_toStOp_strm_fifo_read_valid             <=  lane7_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane8, stream to NoC 
  assign     to_stOp_fifo[8].clear                           =  clear_op                           ;
  assign     lane8_toStOp_strm_fifo_empty           =  to_stOp_fifo[8].fifo_empty                ;
  assign     lane8_toStOp_strm_ready                = ~to_stOp_fifo[8].fifo_almost_full          ;
  assign     lane8_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[8].fifo_eop_count            ;
  assign     to_stOp_fifo[8].fifo_read                       =  lane8_toStOp_strm_fifo_read      ;
  assign     lane8_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[8].fifo_read_cntl            ;
  assign     lane8_toStOp_strm_fifo_read_id         =  to_stOp_fifo[8].fifo_read_strmId          ;
  assign     lane8_toStOp_strm_fifo_read_data       =  to_stOp_fifo[8].fifo_read_data            ;
  assign     to_stOp_fifo[8].cntl                            =  lane8_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[8].strmId                          =  lane8_toStOp_strm_id             ;
  assign     to_stOp_fifo[8].data                            =  lane8_toStOp_strm_data           ;
  assign     to_stOp_fifo[8].fifo_write                      =  lane8_toStOp_strm_fifo_write     ;
  assign     lane8_toStOp_strm_fifo_data_available  = ~lane8_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane8_toStOp_strm_fifo_read_valid             <=  lane8_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane9, stream to NoC 
  assign     to_stOp_fifo[9].clear                           =  clear_op                           ;
  assign     lane9_toStOp_strm_fifo_empty           =  to_stOp_fifo[9].fifo_empty                ;
  assign     lane9_toStOp_strm_ready                = ~to_stOp_fifo[9].fifo_almost_full          ;
  assign     lane9_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[9].fifo_eop_count            ;
  assign     to_stOp_fifo[9].fifo_read                       =  lane9_toStOp_strm_fifo_read      ;
  assign     lane9_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[9].fifo_read_cntl            ;
  assign     lane9_toStOp_strm_fifo_read_id         =  to_stOp_fifo[9].fifo_read_strmId          ;
  assign     lane9_toStOp_strm_fifo_read_data       =  to_stOp_fifo[9].fifo_read_data            ;
  assign     to_stOp_fifo[9].cntl                            =  lane9_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[9].strmId                          =  lane9_toStOp_strm_id             ;
  assign     to_stOp_fifo[9].data                            =  lane9_toStOp_strm_data           ;
  assign     to_stOp_fifo[9].fifo_write                      =  lane9_toStOp_strm_fifo_write     ;
  assign     lane9_toStOp_strm_fifo_data_available  = ~lane9_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane9_toStOp_strm_fifo_read_valid             <=  lane9_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane10, stream to NoC 
  assign     to_stOp_fifo[10].clear                           =  clear_op                           ;
  assign     lane10_toStOp_strm_fifo_empty           =  to_stOp_fifo[10].fifo_empty                ;
  assign     lane10_toStOp_strm_ready                = ~to_stOp_fifo[10].fifo_almost_full          ;
  assign     lane10_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[10].fifo_eop_count            ;
  assign     to_stOp_fifo[10].fifo_read                       =  lane10_toStOp_strm_fifo_read      ;
  assign     lane10_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[10].fifo_read_cntl            ;
  assign     lane10_toStOp_strm_fifo_read_id         =  to_stOp_fifo[10].fifo_read_strmId          ;
  assign     lane10_toStOp_strm_fifo_read_data       =  to_stOp_fifo[10].fifo_read_data            ;
  assign     to_stOp_fifo[10].cntl                            =  lane10_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[10].strmId                          =  lane10_toStOp_strm_id             ;
  assign     to_stOp_fifo[10].data                            =  lane10_toStOp_strm_data           ;
  assign     to_stOp_fifo[10].fifo_write                      =  lane10_toStOp_strm_fifo_write     ;
  assign     lane10_toStOp_strm_fifo_data_available  = ~lane10_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane10_toStOp_strm_fifo_read_valid             <=  lane10_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane11, stream to NoC 
  assign     to_stOp_fifo[11].clear                           =  clear_op                           ;
  assign     lane11_toStOp_strm_fifo_empty           =  to_stOp_fifo[11].fifo_empty                ;
  assign     lane11_toStOp_strm_ready                = ~to_stOp_fifo[11].fifo_almost_full          ;
  assign     lane11_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[11].fifo_eop_count            ;
  assign     to_stOp_fifo[11].fifo_read                       =  lane11_toStOp_strm_fifo_read      ;
  assign     lane11_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[11].fifo_read_cntl            ;
  assign     lane11_toStOp_strm_fifo_read_id         =  to_stOp_fifo[11].fifo_read_strmId          ;
  assign     lane11_toStOp_strm_fifo_read_data       =  to_stOp_fifo[11].fifo_read_data            ;
  assign     to_stOp_fifo[11].cntl                            =  lane11_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[11].strmId                          =  lane11_toStOp_strm_id             ;
  assign     to_stOp_fifo[11].data                            =  lane11_toStOp_strm_data           ;
  assign     to_stOp_fifo[11].fifo_write                      =  lane11_toStOp_strm_fifo_write     ;
  assign     lane11_toStOp_strm_fifo_data_available  = ~lane11_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane11_toStOp_strm_fifo_read_valid             <=  lane11_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane12, stream to NoC 
  assign     to_stOp_fifo[12].clear                           =  clear_op                           ;
  assign     lane12_toStOp_strm_fifo_empty           =  to_stOp_fifo[12].fifo_empty                ;
  assign     lane12_toStOp_strm_ready                = ~to_stOp_fifo[12].fifo_almost_full          ;
  assign     lane12_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[12].fifo_eop_count            ;
  assign     to_stOp_fifo[12].fifo_read                       =  lane12_toStOp_strm_fifo_read      ;
  assign     lane12_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[12].fifo_read_cntl            ;
  assign     lane12_toStOp_strm_fifo_read_id         =  to_stOp_fifo[12].fifo_read_strmId          ;
  assign     lane12_toStOp_strm_fifo_read_data       =  to_stOp_fifo[12].fifo_read_data            ;
  assign     to_stOp_fifo[12].cntl                            =  lane12_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[12].strmId                          =  lane12_toStOp_strm_id             ;
  assign     to_stOp_fifo[12].data                            =  lane12_toStOp_strm_data           ;
  assign     to_stOp_fifo[12].fifo_write                      =  lane12_toStOp_strm_fifo_write     ;
  assign     lane12_toStOp_strm_fifo_data_available  = ~lane12_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane12_toStOp_strm_fifo_read_valid             <=  lane12_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane13, stream to NoC 
  assign     to_stOp_fifo[13].clear                           =  clear_op                           ;
  assign     lane13_toStOp_strm_fifo_empty           =  to_stOp_fifo[13].fifo_empty                ;
  assign     lane13_toStOp_strm_ready                = ~to_stOp_fifo[13].fifo_almost_full          ;
  assign     lane13_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[13].fifo_eop_count            ;
  assign     to_stOp_fifo[13].fifo_read                       =  lane13_toStOp_strm_fifo_read      ;
  assign     lane13_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[13].fifo_read_cntl            ;
  assign     lane13_toStOp_strm_fifo_read_id         =  to_stOp_fifo[13].fifo_read_strmId          ;
  assign     lane13_toStOp_strm_fifo_read_data       =  to_stOp_fifo[13].fifo_read_data            ;
  assign     to_stOp_fifo[13].cntl                            =  lane13_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[13].strmId                          =  lane13_toStOp_strm_id             ;
  assign     to_stOp_fifo[13].data                            =  lane13_toStOp_strm_data           ;
  assign     to_stOp_fifo[13].fifo_write                      =  lane13_toStOp_strm_fifo_write     ;
  assign     lane13_toStOp_strm_fifo_data_available  = ~lane13_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane13_toStOp_strm_fifo_read_valid             <=  lane13_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane14, stream to NoC 
  assign     to_stOp_fifo[14].clear                           =  clear_op                           ;
  assign     lane14_toStOp_strm_fifo_empty           =  to_stOp_fifo[14].fifo_empty                ;
  assign     lane14_toStOp_strm_ready                = ~to_stOp_fifo[14].fifo_almost_full          ;
  assign     lane14_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[14].fifo_eop_count            ;
  assign     to_stOp_fifo[14].fifo_read                       =  lane14_toStOp_strm_fifo_read      ;
  assign     lane14_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[14].fifo_read_cntl            ;
  assign     lane14_toStOp_strm_fifo_read_id         =  to_stOp_fifo[14].fifo_read_strmId          ;
  assign     lane14_toStOp_strm_fifo_read_data       =  to_stOp_fifo[14].fifo_read_data            ;
  assign     to_stOp_fifo[14].cntl                            =  lane14_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[14].strmId                          =  lane14_toStOp_strm_id             ;
  assign     to_stOp_fifo[14].data                            =  lane14_toStOp_strm_data           ;
  assign     to_stOp_fifo[14].fifo_write                      =  lane14_toStOp_strm_fifo_write     ;
  assign     lane14_toStOp_strm_fifo_data_available  = ~lane14_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane14_toStOp_strm_fifo_read_valid             <=  lane14_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane15, stream to NoC 
  assign     to_stOp_fifo[15].clear                           =  clear_op                           ;
  assign     lane15_toStOp_strm_fifo_empty           =  to_stOp_fifo[15].fifo_empty                ;
  assign     lane15_toStOp_strm_ready                = ~to_stOp_fifo[15].fifo_almost_full          ;
  assign     lane15_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[15].fifo_eop_count            ;
  assign     to_stOp_fifo[15].fifo_read                       =  lane15_toStOp_strm_fifo_read      ;
  assign     lane15_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[15].fifo_read_cntl            ;
  assign     lane15_toStOp_strm_fifo_read_id         =  to_stOp_fifo[15].fifo_read_strmId          ;
  assign     lane15_toStOp_strm_fifo_read_data       =  to_stOp_fifo[15].fifo_read_data            ;
  assign     to_stOp_fifo[15].cntl                            =  lane15_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[15].strmId                          =  lane15_toStOp_strm_id             ;
  assign     to_stOp_fifo[15].data                            =  lane15_toStOp_strm_data           ;
  assign     to_stOp_fifo[15].fifo_write                      =  lane15_toStOp_strm_fifo_write     ;
  assign     lane15_toStOp_strm_fifo_data_available  = ~lane15_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane15_toStOp_strm_fifo_read_valid             <=  lane15_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane16, stream to NoC 
  assign     to_stOp_fifo[16].clear                           =  clear_op                           ;
  assign     lane16_toStOp_strm_fifo_empty           =  to_stOp_fifo[16].fifo_empty                ;
  assign     lane16_toStOp_strm_ready                = ~to_stOp_fifo[16].fifo_almost_full          ;
  assign     lane16_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[16].fifo_eop_count            ;
  assign     to_stOp_fifo[16].fifo_read                       =  lane16_toStOp_strm_fifo_read      ;
  assign     lane16_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[16].fifo_read_cntl            ;
  assign     lane16_toStOp_strm_fifo_read_id         =  to_stOp_fifo[16].fifo_read_strmId          ;
  assign     lane16_toStOp_strm_fifo_read_data       =  to_stOp_fifo[16].fifo_read_data            ;
  assign     to_stOp_fifo[16].cntl                            =  lane16_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[16].strmId                          =  lane16_toStOp_strm_id             ;
  assign     to_stOp_fifo[16].data                            =  lane16_toStOp_strm_data           ;
  assign     to_stOp_fifo[16].fifo_write                      =  lane16_toStOp_strm_fifo_write     ;
  assign     lane16_toStOp_strm_fifo_data_available  = ~lane16_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane16_toStOp_strm_fifo_read_valid             <=  lane16_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane17, stream to NoC 
  assign     to_stOp_fifo[17].clear                           =  clear_op                           ;
  assign     lane17_toStOp_strm_fifo_empty           =  to_stOp_fifo[17].fifo_empty                ;
  assign     lane17_toStOp_strm_ready                = ~to_stOp_fifo[17].fifo_almost_full          ;
  assign     lane17_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[17].fifo_eop_count            ;
  assign     to_stOp_fifo[17].fifo_read                       =  lane17_toStOp_strm_fifo_read      ;
  assign     lane17_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[17].fifo_read_cntl            ;
  assign     lane17_toStOp_strm_fifo_read_id         =  to_stOp_fifo[17].fifo_read_strmId          ;
  assign     lane17_toStOp_strm_fifo_read_data       =  to_stOp_fifo[17].fifo_read_data            ;
  assign     to_stOp_fifo[17].cntl                            =  lane17_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[17].strmId                          =  lane17_toStOp_strm_id             ;
  assign     to_stOp_fifo[17].data                            =  lane17_toStOp_strm_data           ;
  assign     to_stOp_fifo[17].fifo_write                      =  lane17_toStOp_strm_fifo_write     ;
  assign     lane17_toStOp_strm_fifo_data_available  = ~lane17_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane17_toStOp_strm_fifo_read_valid             <=  lane17_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane18, stream to NoC 
  assign     to_stOp_fifo[18].clear                           =  clear_op                           ;
  assign     lane18_toStOp_strm_fifo_empty           =  to_stOp_fifo[18].fifo_empty                ;
  assign     lane18_toStOp_strm_ready                = ~to_stOp_fifo[18].fifo_almost_full          ;
  assign     lane18_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[18].fifo_eop_count            ;
  assign     to_stOp_fifo[18].fifo_read                       =  lane18_toStOp_strm_fifo_read      ;
  assign     lane18_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[18].fifo_read_cntl            ;
  assign     lane18_toStOp_strm_fifo_read_id         =  to_stOp_fifo[18].fifo_read_strmId          ;
  assign     lane18_toStOp_strm_fifo_read_data       =  to_stOp_fifo[18].fifo_read_data            ;
  assign     to_stOp_fifo[18].cntl                            =  lane18_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[18].strmId                          =  lane18_toStOp_strm_id             ;
  assign     to_stOp_fifo[18].data                            =  lane18_toStOp_strm_data           ;
  assign     to_stOp_fifo[18].fifo_write                      =  lane18_toStOp_strm_fifo_write     ;
  assign     lane18_toStOp_strm_fifo_data_available  = ~lane18_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane18_toStOp_strm_fifo_read_valid             <=  lane18_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane19, stream to NoC 
  assign     to_stOp_fifo[19].clear                           =  clear_op                           ;
  assign     lane19_toStOp_strm_fifo_empty           =  to_stOp_fifo[19].fifo_empty                ;
  assign     lane19_toStOp_strm_ready                = ~to_stOp_fifo[19].fifo_almost_full          ;
  assign     lane19_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[19].fifo_eop_count            ;
  assign     to_stOp_fifo[19].fifo_read                       =  lane19_toStOp_strm_fifo_read      ;
  assign     lane19_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[19].fifo_read_cntl            ;
  assign     lane19_toStOp_strm_fifo_read_id         =  to_stOp_fifo[19].fifo_read_strmId          ;
  assign     lane19_toStOp_strm_fifo_read_data       =  to_stOp_fifo[19].fifo_read_data            ;
  assign     to_stOp_fifo[19].cntl                            =  lane19_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[19].strmId                          =  lane19_toStOp_strm_id             ;
  assign     to_stOp_fifo[19].data                            =  lane19_toStOp_strm_data           ;
  assign     to_stOp_fifo[19].fifo_write                      =  lane19_toStOp_strm_fifo_write     ;
  assign     lane19_toStOp_strm_fifo_data_available  = ~lane19_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane19_toStOp_strm_fifo_read_valid             <=  lane19_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane20, stream to NoC 
  assign     to_stOp_fifo[20].clear                           =  clear_op                           ;
  assign     lane20_toStOp_strm_fifo_empty           =  to_stOp_fifo[20].fifo_empty                ;
  assign     lane20_toStOp_strm_ready                = ~to_stOp_fifo[20].fifo_almost_full          ;
  assign     lane20_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[20].fifo_eop_count            ;
  assign     to_stOp_fifo[20].fifo_read                       =  lane20_toStOp_strm_fifo_read      ;
  assign     lane20_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[20].fifo_read_cntl            ;
  assign     lane20_toStOp_strm_fifo_read_id         =  to_stOp_fifo[20].fifo_read_strmId          ;
  assign     lane20_toStOp_strm_fifo_read_data       =  to_stOp_fifo[20].fifo_read_data            ;
  assign     to_stOp_fifo[20].cntl                            =  lane20_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[20].strmId                          =  lane20_toStOp_strm_id             ;
  assign     to_stOp_fifo[20].data                            =  lane20_toStOp_strm_data           ;
  assign     to_stOp_fifo[20].fifo_write                      =  lane20_toStOp_strm_fifo_write     ;
  assign     lane20_toStOp_strm_fifo_data_available  = ~lane20_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane20_toStOp_strm_fifo_read_valid             <=  lane20_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane21, stream to NoC 
  assign     to_stOp_fifo[21].clear                           =  clear_op                           ;
  assign     lane21_toStOp_strm_fifo_empty           =  to_stOp_fifo[21].fifo_empty                ;
  assign     lane21_toStOp_strm_ready                = ~to_stOp_fifo[21].fifo_almost_full          ;
  assign     lane21_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[21].fifo_eop_count            ;
  assign     to_stOp_fifo[21].fifo_read                       =  lane21_toStOp_strm_fifo_read      ;
  assign     lane21_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[21].fifo_read_cntl            ;
  assign     lane21_toStOp_strm_fifo_read_id         =  to_stOp_fifo[21].fifo_read_strmId          ;
  assign     lane21_toStOp_strm_fifo_read_data       =  to_stOp_fifo[21].fifo_read_data            ;
  assign     to_stOp_fifo[21].cntl                            =  lane21_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[21].strmId                          =  lane21_toStOp_strm_id             ;
  assign     to_stOp_fifo[21].data                            =  lane21_toStOp_strm_data           ;
  assign     to_stOp_fifo[21].fifo_write                      =  lane21_toStOp_strm_fifo_write     ;
  assign     lane21_toStOp_strm_fifo_data_available  = ~lane21_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane21_toStOp_strm_fifo_read_valid             <=  lane21_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane22, stream to NoC 
  assign     to_stOp_fifo[22].clear                           =  clear_op                           ;
  assign     lane22_toStOp_strm_fifo_empty           =  to_stOp_fifo[22].fifo_empty                ;
  assign     lane22_toStOp_strm_ready                = ~to_stOp_fifo[22].fifo_almost_full          ;
  assign     lane22_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[22].fifo_eop_count            ;
  assign     to_stOp_fifo[22].fifo_read                       =  lane22_toStOp_strm_fifo_read      ;
  assign     lane22_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[22].fifo_read_cntl            ;
  assign     lane22_toStOp_strm_fifo_read_id         =  to_stOp_fifo[22].fifo_read_strmId          ;
  assign     lane22_toStOp_strm_fifo_read_data       =  to_stOp_fifo[22].fifo_read_data            ;
  assign     to_stOp_fifo[22].cntl                            =  lane22_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[22].strmId                          =  lane22_toStOp_strm_id             ;
  assign     to_stOp_fifo[22].data                            =  lane22_toStOp_strm_data           ;
  assign     to_stOp_fifo[22].fifo_write                      =  lane22_toStOp_strm_fifo_write     ;
  assign     lane22_toStOp_strm_fifo_data_available  = ~lane22_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane22_toStOp_strm_fifo_read_valid             <=  lane22_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane23, stream to NoC 
  assign     to_stOp_fifo[23].clear                           =  clear_op                           ;
  assign     lane23_toStOp_strm_fifo_empty           =  to_stOp_fifo[23].fifo_empty                ;
  assign     lane23_toStOp_strm_ready                = ~to_stOp_fifo[23].fifo_almost_full          ;
  assign     lane23_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[23].fifo_eop_count            ;
  assign     to_stOp_fifo[23].fifo_read                       =  lane23_toStOp_strm_fifo_read      ;
  assign     lane23_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[23].fifo_read_cntl            ;
  assign     lane23_toStOp_strm_fifo_read_id         =  to_stOp_fifo[23].fifo_read_strmId          ;
  assign     lane23_toStOp_strm_fifo_read_data       =  to_stOp_fifo[23].fifo_read_data            ;
  assign     to_stOp_fifo[23].cntl                            =  lane23_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[23].strmId                          =  lane23_toStOp_strm_id             ;
  assign     to_stOp_fifo[23].data                            =  lane23_toStOp_strm_data           ;
  assign     to_stOp_fifo[23].fifo_write                      =  lane23_toStOp_strm_fifo_write     ;
  assign     lane23_toStOp_strm_fifo_data_available  = ~lane23_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane23_toStOp_strm_fifo_read_valid             <=  lane23_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane24, stream to NoC 
  assign     to_stOp_fifo[24].clear                           =  clear_op                           ;
  assign     lane24_toStOp_strm_fifo_empty           =  to_stOp_fifo[24].fifo_empty                ;
  assign     lane24_toStOp_strm_ready                = ~to_stOp_fifo[24].fifo_almost_full          ;
  assign     lane24_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[24].fifo_eop_count            ;
  assign     to_stOp_fifo[24].fifo_read                       =  lane24_toStOp_strm_fifo_read      ;
  assign     lane24_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[24].fifo_read_cntl            ;
  assign     lane24_toStOp_strm_fifo_read_id         =  to_stOp_fifo[24].fifo_read_strmId          ;
  assign     lane24_toStOp_strm_fifo_read_data       =  to_stOp_fifo[24].fifo_read_data            ;
  assign     to_stOp_fifo[24].cntl                            =  lane24_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[24].strmId                          =  lane24_toStOp_strm_id             ;
  assign     to_stOp_fifo[24].data                            =  lane24_toStOp_strm_data           ;
  assign     to_stOp_fifo[24].fifo_write                      =  lane24_toStOp_strm_fifo_write     ;
  assign     lane24_toStOp_strm_fifo_data_available  = ~lane24_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane24_toStOp_strm_fifo_read_valid             <=  lane24_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane25, stream to NoC 
  assign     to_stOp_fifo[25].clear                           =  clear_op                           ;
  assign     lane25_toStOp_strm_fifo_empty           =  to_stOp_fifo[25].fifo_empty                ;
  assign     lane25_toStOp_strm_ready                = ~to_stOp_fifo[25].fifo_almost_full          ;
  assign     lane25_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[25].fifo_eop_count            ;
  assign     to_stOp_fifo[25].fifo_read                       =  lane25_toStOp_strm_fifo_read      ;
  assign     lane25_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[25].fifo_read_cntl            ;
  assign     lane25_toStOp_strm_fifo_read_id         =  to_stOp_fifo[25].fifo_read_strmId          ;
  assign     lane25_toStOp_strm_fifo_read_data       =  to_stOp_fifo[25].fifo_read_data            ;
  assign     to_stOp_fifo[25].cntl                            =  lane25_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[25].strmId                          =  lane25_toStOp_strm_id             ;
  assign     to_stOp_fifo[25].data                            =  lane25_toStOp_strm_data           ;
  assign     to_stOp_fifo[25].fifo_write                      =  lane25_toStOp_strm_fifo_write     ;
  assign     lane25_toStOp_strm_fifo_data_available  = ~lane25_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane25_toStOp_strm_fifo_read_valid             <=  lane25_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane26, stream to NoC 
  assign     to_stOp_fifo[26].clear                           =  clear_op                           ;
  assign     lane26_toStOp_strm_fifo_empty           =  to_stOp_fifo[26].fifo_empty                ;
  assign     lane26_toStOp_strm_ready                = ~to_stOp_fifo[26].fifo_almost_full          ;
  assign     lane26_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[26].fifo_eop_count            ;
  assign     to_stOp_fifo[26].fifo_read                       =  lane26_toStOp_strm_fifo_read      ;
  assign     lane26_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[26].fifo_read_cntl            ;
  assign     lane26_toStOp_strm_fifo_read_id         =  to_stOp_fifo[26].fifo_read_strmId          ;
  assign     lane26_toStOp_strm_fifo_read_data       =  to_stOp_fifo[26].fifo_read_data            ;
  assign     to_stOp_fifo[26].cntl                            =  lane26_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[26].strmId                          =  lane26_toStOp_strm_id             ;
  assign     to_stOp_fifo[26].data                            =  lane26_toStOp_strm_data           ;
  assign     to_stOp_fifo[26].fifo_write                      =  lane26_toStOp_strm_fifo_write     ;
  assign     lane26_toStOp_strm_fifo_data_available  = ~lane26_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane26_toStOp_strm_fifo_read_valid             <=  lane26_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane27, stream to NoC 
  assign     to_stOp_fifo[27].clear                           =  clear_op                           ;
  assign     lane27_toStOp_strm_fifo_empty           =  to_stOp_fifo[27].fifo_empty                ;
  assign     lane27_toStOp_strm_ready                = ~to_stOp_fifo[27].fifo_almost_full          ;
  assign     lane27_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[27].fifo_eop_count            ;
  assign     to_stOp_fifo[27].fifo_read                       =  lane27_toStOp_strm_fifo_read      ;
  assign     lane27_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[27].fifo_read_cntl            ;
  assign     lane27_toStOp_strm_fifo_read_id         =  to_stOp_fifo[27].fifo_read_strmId          ;
  assign     lane27_toStOp_strm_fifo_read_data       =  to_stOp_fifo[27].fifo_read_data            ;
  assign     to_stOp_fifo[27].cntl                            =  lane27_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[27].strmId                          =  lane27_toStOp_strm_id             ;
  assign     to_stOp_fifo[27].data                            =  lane27_toStOp_strm_data           ;
  assign     to_stOp_fifo[27].fifo_write                      =  lane27_toStOp_strm_fifo_write     ;
  assign     lane27_toStOp_strm_fifo_data_available  = ~lane27_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane27_toStOp_strm_fifo_read_valid             <=  lane27_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane28, stream to NoC 
  assign     to_stOp_fifo[28].clear                           =  clear_op                           ;
  assign     lane28_toStOp_strm_fifo_empty           =  to_stOp_fifo[28].fifo_empty                ;
  assign     lane28_toStOp_strm_ready                = ~to_stOp_fifo[28].fifo_almost_full          ;
  assign     lane28_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[28].fifo_eop_count            ;
  assign     to_stOp_fifo[28].fifo_read                       =  lane28_toStOp_strm_fifo_read      ;
  assign     lane28_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[28].fifo_read_cntl            ;
  assign     lane28_toStOp_strm_fifo_read_id         =  to_stOp_fifo[28].fifo_read_strmId          ;
  assign     lane28_toStOp_strm_fifo_read_data       =  to_stOp_fifo[28].fifo_read_data            ;
  assign     to_stOp_fifo[28].cntl                            =  lane28_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[28].strmId                          =  lane28_toStOp_strm_id             ;
  assign     to_stOp_fifo[28].data                            =  lane28_toStOp_strm_data           ;
  assign     to_stOp_fifo[28].fifo_write                      =  lane28_toStOp_strm_fifo_write     ;
  assign     lane28_toStOp_strm_fifo_data_available  = ~lane28_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane28_toStOp_strm_fifo_read_valid             <=  lane28_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane29, stream to NoC 
  assign     to_stOp_fifo[29].clear                           =  clear_op                           ;
  assign     lane29_toStOp_strm_fifo_empty           =  to_stOp_fifo[29].fifo_empty                ;
  assign     lane29_toStOp_strm_ready                = ~to_stOp_fifo[29].fifo_almost_full          ;
  assign     lane29_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[29].fifo_eop_count            ;
  assign     to_stOp_fifo[29].fifo_read                       =  lane29_toStOp_strm_fifo_read      ;
  assign     lane29_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[29].fifo_read_cntl            ;
  assign     lane29_toStOp_strm_fifo_read_id         =  to_stOp_fifo[29].fifo_read_strmId          ;
  assign     lane29_toStOp_strm_fifo_read_data       =  to_stOp_fifo[29].fifo_read_data            ;
  assign     to_stOp_fifo[29].cntl                            =  lane29_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[29].strmId                          =  lane29_toStOp_strm_id             ;
  assign     to_stOp_fifo[29].data                            =  lane29_toStOp_strm_data           ;
  assign     to_stOp_fifo[29].fifo_write                      =  lane29_toStOp_strm_fifo_write     ;
  assign     lane29_toStOp_strm_fifo_data_available  = ~lane29_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane29_toStOp_strm_fifo_read_valid             <=  lane29_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane30, stream to NoC 
  assign     to_stOp_fifo[30].clear                           =  clear_op                           ;
  assign     lane30_toStOp_strm_fifo_empty           =  to_stOp_fifo[30].fifo_empty                ;
  assign     lane30_toStOp_strm_ready                = ~to_stOp_fifo[30].fifo_almost_full          ;
  assign     lane30_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[30].fifo_eop_count            ;
  assign     to_stOp_fifo[30].fifo_read                       =  lane30_toStOp_strm_fifo_read      ;
  assign     lane30_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[30].fifo_read_cntl            ;
  assign     lane30_toStOp_strm_fifo_read_id         =  to_stOp_fifo[30].fifo_read_strmId          ;
  assign     lane30_toStOp_strm_fifo_read_data       =  to_stOp_fifo[30].fifo_read_data            ;
  assign     to_stOp_fifo[30].cntl                            =  lane30_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[30].strmId                          =  lane30_toStOp_strm_id             ;
  assign     to_stOp_fifo[30].data                            =  lane30_toStOp_strm_data           ;
  assign     to_stOp_fifo[30].fifo_write                      =  lane30_toStOp_strm_fifo_write     ;
  assign     lane30_toStOp_strm_fifo_data_available  = ~lane30_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane30_toStOp_strm_fifo_read_valid             <=  lane30_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane31, stream to NoC 
  assign     to_stOp_fifo[31].clear                           =  clear_op                           ;
  assign     lane31_toStOp_strm_fifo_empty           =  to_stOp_fifo[31].fifo_empty                ;
  assign     lane31_toStOp_strm_ready                = ~to_stOp_fifo[31].fifo_almost_full          ;
  assign     lane31_toStOp_strm_fifo_eop_count       =  to_stOp_fifo[31].fifo_eop_count            ;
  assign     to_stOp_fifo[31].fifo_read                       =  lane31_toStOp_strm_fifo_read      ;
  assign     lane31_toStOp_strm_fifo_read_cntl       =  to_stOp_fifo[31].fifo_read_cntl            ;
  assign     lane31_toStOp_strm_fifo_read_id         =  to_stOp_fifo[31].fifo_read_strmId          ;
  assign     lane31_toStOp_strm_fifo_read_data       =  to_stOp_fifo[31].fifo_read_data            ;
  assign     to_stOp_fifo[31].cntl                            =  lane31_toStOp_strm_cntl           ;
  assign     to_stOp_fifo[31].strmId                          =  lane31_toStOp_strm_id             ;
  assign     to_stOp_fifo[31].data                            =  lane31_toStOp_strm_data           ;
  assign     to_stOp_fifo[31].fifo_write                      =  lane31_toStOp_strm_fifo_write     ;
  assign     lane31_toStOp_strm_fifo_data_available  = ~lane31_toStOp_strm_fifo_empty     ;
  always @(posedge clk) 
    begin 
      lane31_toStOp_strm_fifo_read_valid             <=  lane31_toStOp_strm_fifo_read     ;  // real memory is pipelined
    end 
  // lane0 stream to NoC 
  assign     lane0_toStOp_strm_fifo_read         = sdp__cntl__lane0_strm_ready & lane0_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane0_strm_cntl        <=  lane0_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane0_strm_id          <=  lane0_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane0_strm_data        <=  lane0_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane0_strm_data_valid  <=  lane0_toStOp_strm_fifo_read            ;
      cntl__sdp__lane0_strm_data_valid  <=  lane0_toStOp_strm_fifo_read_valid      ;
    end 
  // lane1 stream to NoC 
  assign     lane1_toStOp_strm_fifo_read         = sdp__cntl__lane1_strm_ready & lane1_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane1_strm_cntl        <=  lane1_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane1_strm_id          <=  lane1_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane1_strm_data        <=  lane1_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane1_strm_data_valid  <=  lane1_toStOp_strm_fifo_read            ;
      cntl__sdp__lane1_strm_data_valid  <=  lane1_toStOp_strm_fifo_read_valid      ;
    end 
  // lane2 stream to NoC 
  assign     lane2_toStOp_strm_fifo_read         = sdp__cntl__lane2_strm_ready & lane2_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane2_strm_cntl        <=  lane2_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane2_strm_id          <=  lane2_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane2_strm_data        <=  lane2_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane2_strm_data_valid  <=  lane2_toStOp_strm_fifo_read            ;
      cntl__sdp__lane2_strm_data_valid  <=  lane2_toStOp_strm_fifo_read_valid      ;
    end 
  // lane3 stream to NoC 
  assign     lane3_toStOp_strm_fifo_read         = sdp__cntl__lane3_strm_ready & lane3_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane3_strm_cntl        <=  lane3_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane3_strm_id          <=  lane3_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane3_strm_data        <=  lane3_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane3_strm_data_valid  <=  lane3_toStOp_strm_fifo_read            ;
      cntl__sdp__lane3_strm_data_valid  <=  lane3_toStOp_strm_fifo_read_valid      ;
    end 
  // lane4 stream to NoC 
  assign     lane4_toStOp_strm_fifo_read         = sdp__cntl__lane4_strm_ready & lane4_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane4_strm_cntl        <=  lane4_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane4_strm_id          <=  lane4_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane4_strm_data        <=  lane4_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane4_strm_data_valid  <=  lane4_toStOp_strm_fifo_read            ;
      cntl__sdp__lane4_strm_data_valid  <=  lane4_toStOp_strm_fifo_read_valid      ;
    end 
  // lane5 stream to NoC 
  assign     lane5_toStOp_strm_fifo_read         = sdp__cntl__lane5_strm_ready & lane5_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane5_strm_cntl        <=  lane5_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane5_strm_id          <=  lane5_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane5_strm_data        <=  lane5_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane5_strm_data_valid  <=  lane5_toStOp_strm_fifo_read            ;
      cntl__sdp__lane5_strm_data_valid  <=  lane5_toStOp_strm_fifo_read_valid      ;
    end 
  // lane6 stream to NoC 
  assign     lane6_toStOp_strm_fifo_read         = sdp__cntl__lane6_strm_ready & lane6_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane6_strm_cntl        <=  lane6_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane6_strm_id          <=  lane6_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane6_strm_data        <=  lane6_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane6_strm_data_valid  <=  lane6_toStOp_strm_fifo_read            ;
      cntl__sdp__lane6_strm_data_valid  <=  lane6_toStOp_strm_fifo_read_valid      ;
    end 
  // lane7 stream to NoC 
  assign     lane7_toStOp_strm_fifo_read         = sdp__cntl__lane7_strm_ready & lane7_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane7_strm_cntl        <=  lane7_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane7_strm_id          <=  lane7_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane7_strm_data        <=  lane7_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane7_strm_data_valid  <=  lane7_toStOp_strm_fifo_read            ;
      cntl__sdp__lane7_strm_data_valid  <=  lane7_toStOp_strm_fifo_read_valid      ;
    end 
  // lane8 stream to NoC 
  assign     lane8_toStOp_strm_fifo_read         = sdp__cntl__lane8_strm_ready & lane8_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane8_strm_cntl        <=  lane8_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane8_strm_id          <=  lane8_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane8_strm_data        <=  lane8_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane8_strm_data_valid  <=  lane8_toStOp_strm_fifo_read            ;
      cntl__sdp__lane8_strm_data_valid  <=  lane8_toStOp_strm_fifo_read_valid      ;
    end 
  // lane9 stream to NoC 
  assign     lane9_toStOp_strm_fifo_read         = sdp__cntl__lane9_strm_ready & lane9_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane9_strm_cntl        <=  lane9_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane9_strm_id          <=  lane9_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane9_strm_data        <=  lane9_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane9_strm_data_valid  <=  lane9_toStOp_strm_fifo_read            ;
      cntl__sdp__lane9_strm_data_valid  <=  lane9_toStOp_strm_fifo_read_valid      ;
    end 
  // lane10 stream to NoC 
  assign     lane10_toStOp_strm_fifo_read         = sdp__cntl__lane10_strm_ready & lane10_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane10_strm_cntl        <=  lane10_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane10_strm_id          <=  lane10_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane10_strm_data        <=  lane10_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane10_strm_data_valid  <=  lane10_toStOp_strm_fifo_read            ;
      cntl__sdp__lane10_strm_data_valid  <=  lane10_toStOp_strm_fifo_read_valid      ;
    end 
  // lane11 stream to NoC 
  assign     lane11_toStOp_strm_fifo_read         = sdp__cntl__lane11_strm_ready & lane11_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane11_strm_cntl        <=  lane11_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane11_strm_id          <=  lane11_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane11_strm_data        <=  lane11_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane11_strm_data_valid  <=  lane11_toStOp_strm_fifo_read            ;
      cntl__sdp__lane11_strm_data_valid  <=  lane11_toStOp_strm_fifo_read_valid      ;
    end 
  // lane12 stream to NoC 
  assign     lane12_toStOp_strm_fifo_read         = sdp__cntl__lane12_strm_ready & lane12_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane12_strm_cntl        <=  lane12_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane12_strm_id          <=  lane12_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane12_strm_data        <=  lane12_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane12_strm_data_valid  <=  lane12_toStOp_strm_fifo_read            ;
      cntl__sdp__lane12_strm_data_valid  <=  lane12_toStOp_strm_fifo_read_valid      ;
    end 
  // lane13 stream to NoC 
  assign     lane13_toStOp_strm_fifo_read         = sdp__cntl__lane13_strm_ready & lane13_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane13_strm_cntl        <=  lane13_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane13_strm_id          <=  lane13_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane13_strm_data        <=  lane13_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane13_strm_data_valid  <=  lane13_toStOp_strm_fifo_read            ;
      cntl__sdp__lane13_strm_data_valid  <=  lane13_toStOp_strm_fifo_read_valid      ;
    end 
  // lane14 stream to NoC 
  assign     lane14_toStOp_strm_fifo_read         = sdp__cntl__lane14_strm_ready & lane14_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane14_strm_cntl        <=  lane14_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane14_strm_id          <=  lane14_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane14_strm_data        <=  lane14_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane14_strm_data_valid  <=  lane14_toStOp_strm_fifo_read            ;
      cntl__sdp__lane14_strm_data_valid  <=  lane14_toStOp_strm_fifo_read_valid      ;
    end 
  // lane15 stream to NoC 
  assign     lane15_toStOp_strm_fifo_read         = sdp__cntl__lane15_strm_ready & lane15_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane15_strm_cntl        <=  lane15_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane15_strm_id          <=  lane15_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane15_strm_data        <=  lane15_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane15_strm_data_valid  <=  lane15_toStOp_strm_fifo_read            ;
      cntl__sdp__lane15_strm_data_valid  <=  lane15_toStOp_strm_fifo_read_valid      ;
    end 
  // lane16 stream to NoC 
  assign     lane16_toStOp_strm_fifo_read         = sdp__cntl__lane16_strm_ready & lane16_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane16_strm_cntl        <=  lane16_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane16_strm_id          <=  lane16_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane16_strm_data        <=  lane16_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane16_strm_data_valid  <=  lane16_toStOp_strm_fifo_read            ;
      cntl__sdp__lane16_strm_data_valid  <=  lane16_toStOp_strm_fifo_read_valid      ;
    end 
  // lane17 stream to NoC 
  assign     lane17_toStOp_strm_fifo_read         = sdp__cntl__lane17_strm_ready & lane17_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane17_strm_cntl        <=  lane17_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane17_strm_id          <=  lane17_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane17_strm_data        <=  lane17_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane17_strm_data_valid  <=  lane17_toStOp_strm_fifo_read            ;
      cntl__sdp__lane17_strm_data_valid  <=  lane17_toStOp_strm_fifo_read_valid      ;
    end 
  // lane18 stream to NoC 
  assign     lane18_toStOp_strm_fifo_read         = sdp__cntl__lane18_strm_ready & lane18_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane18_strm_cntl        <=  lane18_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane18_strm_id          <=  lane18_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane18_strm_data        <=  lane18_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane18_strm_data_valid  <=  lane18_toStOp_strm_fifo_read            ;
      cntl__sdp__lane18_strm_data_valid  <=  lane18_toStOp_strm_fifo_read_valid      ;
    end 
  // lane19 stream to NoC 
  assign     lane19_toStOp_strm_fifo_read         = sdp__cntl__lane19_strm_ready & lane19_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane19_strm_cntl        <=  lane19_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane19_strm_id          <=  lane19_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane19_strm_data        <=  lane19_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane19_strm_data_valid  <=  lane19_toStOp_strm_fifo_read            ;
      cntl__sdp__lane19_strm_data_valid  <=  lane19_toStOp_strm_fifo_read_valid      ;
    end 
  // lane20 stream to NoC 
  assign     lane20_toStOp_strm_fifo_read         = sdp__cntl__lane20_strm_ready & lane20_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane20_strm_cntl        <=  lane20_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane20_strm_id          <=  lane20_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane20_strm_data        <=  lane20_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane20_strm_data_valid  <=  lane20_toStOp_strm_fifo_read            ;
      cntl__sdp__lane20_strm_data_valid  <=  lane20_toStOp_strm_fifo_read_valid      ;
    end 
  // lane21 stream to NoC 
  assign     lane21_toStOp_strm_fifo_read         = sdp__cntl__lane21_strm_ready & lane21_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane21_strm_cntl        <=  lane21_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane21_strm_id          <=  lane21_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane21_strm_data        <=  lane21_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane21_strm_data_valid  <=  lane21_toStOp_strm_fifo_read            ;
      cntl__sdp__lane21_strm_data_valid  <=  lane21_toStOp_strm_fifo_read_valid      ;
    end 
  // lane22 stream to NoC 
  assign     lane22_toStOp_strm_fifo_read         = sdp__cntl__lane22_strm_ready & lane22_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane22_strm_cntl        <=  lane22_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane22_strm_id          <=  lane22_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane22_strm_data        <=  lane22_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane22_strm_data_valid  <=  lane22_toStOp_strm_fifo_read            ;
      cntl__sdp__lane22_strm_data_valid  <=  lane22_toStOp_strm_fifo_read_valid      ;
    end 
  // lane23 stream to NoC 
  assign     lane23_toStOp_strm_fifo_read         = sdp__cntl__lane23_strm_ready & lane23_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane23_strm_cntl        <=  lane23_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane23_strm_id          <=  lane23_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane23_strm_data        <=  lane23_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane23_strm_data_valid  <=  lane23_toStOp_strm_fifo_read            ;
      cntl__sdp__lane23_strm_data_valid  <=  lane23_toStOp_strm_fifo_read_valid      ;
    end 
  // lane24 stream to NoC 
  assign     lane24_toStOp_strm_fifo_read         = sdp__cntl__lane24_strm_ready & lane24_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane24_strm_cntl        <=  lane24_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane24_strm_id          <=  lane24_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane24_strm_data        <=  lane24_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane24_strm_data_valid  <=  lane24_toStOp_strm_fifo_read            ;
      cntl__sdp__lane24_strm_data_valid  <=  lane24_toStOp_strm_fifo_read_valid      ;
    end 
  // lane25 stream to NoC 
  assign     lane25_toStOp_strm_fifo_read         = sdp__cntl__lane25_strm_ready & lane25_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane25_strm_cntl        <=  lane25_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane25_strm_id          <=  lane25_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane25_strm_data        <=  lane25_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane25_strm_data_valid  <=  lane25_toStOp_strm_fifo_read            ;
      cntl__sdp__lane25_strm_data_valid  <=  lane25_toStOp_strm_fifo_read_valid      ;
    end 
  // lane26 stream to NoC 
  assign     lane26_toStOp_strm_fifo_read         = sdp__cntl__lane26_strm_ready & lane26_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane26_strm_cntl        <=  lane26_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane26_strm_id          <=  lane26_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane26_strm_data        <=  lane26_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane26_strm_data_valid  <=  lane26_toStOp_strm_fifo_read            ;
      cntl__sdp__lane26_strm_data_valid  <=  lane26_toStOp_strm_fifo_read_valid      ;
    end 
  // lane27 stream to NoC 
  assign     lane27_toStOp_strm_fifo_read         = sdp__cntl__lane27_strm_ready & lane27_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane27_strm_cntl        <=  lane27_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane27_strm_id          <=  lane27_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane27_strm_data        <=  lane27_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane27_strm_data_valid  <=  lane27_toStOp_strm_fifo_read            ;
      cntl__sdp__lane27_strm_data_valid  <=  lane27_toStOp_strm_fifo_read_valid      ;
    end 
  // lane28 stream to NoC 
  assign     lane28_toStOp_strm_fifo_read         = sdp__cntl__lane28_strm_ready & lane28_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane28_strm_cntl        <=  lane28_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane28_strm_id          <=  lane28_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane28_strm_data        <=  lane28_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane28_strm_data_valid  <=  lane28_toStOp_strm_fifo_read            ;
      cntl__sdp__lane28_strm_data_valid  <=  lane28_toStOp_strm_fifo_read_valid      ;
    end 
  // lane29 stream to NoC 
  assign     lane29_toStOp_strm_fifo_read         = sdp__cntl__lane29_strm_ready & lane29_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane29_strm_cntl        <=  lane29_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane29_strm_id          <=  lane29_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane29_strm_data        <=  lane29_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane29_strm_data_valid  <=  lane29_toStOp_strm_fifo_read            ;
      cntl__sdp__lane29_strm_data_valid  <=  lane29_toStOp_strm_fifo_read_valid      ;
    end 
  // lane30 stream to NoC 
  assign     lane30_toStOp_strm_fifo_read         = sdp__cntl__lane30_strm_ready & lane30_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane30_strm_cntl        <=  lane30_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane30_strm_id          <=  lane30_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane30_strm_data        <=  lane30_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane30_strm_data_valid  <=  lane30_toStOp_strm_fifo_read            ;
      cntl__sdp__lane30_strm_data_valid  <=  lane30_toStOp_strm_fifo_read_valid      ;
    end 
  // lane31 stream to NoC 
  assign     lane31_toStOp_strm_fifo_read         = sdp__cntl__lane31_strm_ready & lane31_toStOp_strm_fifo_data_available  ; // FIXME
  always @(posedge clk) 
    begin 
      cntl__sdp__lane31_strm_cntl        <=  lane31_toStOp_strm_fifo_read_cntl       ;
      cntl__sdp__lane31_strm_id          <=  lane31_toStOp_strm_fifo_read_id         ;
      cntl__sdp__lane31_strm_data        <=  lane31_toStOp_strm_fifo_read_data       ;
      //cntl__sdp__lane31_strm_data_valid  <=  lane31_toStOp_strm_fifo_read            ;
      cntl__sdp__lane31_strm_data_valid  <=  lane31_toStOp_strm_fifo_read_valid      ;
    end 