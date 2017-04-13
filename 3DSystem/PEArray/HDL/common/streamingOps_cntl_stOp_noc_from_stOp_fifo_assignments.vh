
  // lane0, stream to NoC 
  assign     from_stOp_fifo[0].clear                               =  clear_op                             ;
  assign     lane0_fromStOp_strm_fifo_empty             =  from_stOp_fifo[0].fifo_empty                  ;
  assign     lane0_fromStOp_strm_fifo_depth             =  from_stOp_fifo[0].fifo_depth                  ;
  assign     lane0_fromStOp_strm_ready                  = ~from_stOp_fifo[0].fifo_almost_full            ;
  assign     lane0_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[0].fifo_eop_count              ;
  assign     from_stOp_fifo[0].fifo_read                           =  lane0_fromStOp_strm_fifo_read      ;
  assign     lane0_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[0].fifo_read_cntl              ;
  assign     lane0_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[0].fifo_read_data_valid        ;
  assign     lane0_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[0].fifo_read_strmId            ;
  assign     lane0_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[0].fifo_read_data              ;
  assign     from_stOp_fifo[0].cntl                                =  lane0_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[0].strmId                              =  lane0_fromStOp_strm_id             ;
  assign     from_stOp_fifo[0].data                                =  lane0_fromStOp_strm_data           ;
  assign     from_stOp_fifo[0].fifo_write                          =  lane0_fromStOp_strm_data_valid     ;
  assign     lane0_fromStOp_strm_fifo_data_available    = ~lane0_fromStOp_strm_fifo_empty     ;
  assign     lane0_fromStOp_strm_fifo_dma_pkt_available = (lane0_fromStOp_strm_fifo_eop_count > 0) | lane0_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane1, stream to NoC 
  assign     from_stOp_fifo[1].clear                               =  clear_op                             ;
  assign     lane1_fromStOp_strm_fifo_empty             =  from_stOp_fifo[1].fifo_empty                  ;
  assign     lane1_fromStOp_strm_fifo_depth             =  from_stOp_fifo[1].fifo_depth                  ;
  assign     lane1_fromStOp_strm_ready                  = ~from_stOp_fifo[1].fifo_almost_full            ;
  assign     lane1_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[1].fifo_eop_count              ;
  assign     from_stOp_fifo[1].fifo_read                           =  lane1_fromStOp_strm_fifo_read      ;
  assign     lane1_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[1].fifo_read_cntl              ;
  assign     lane1_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[1].fifo_read_data_valid        ;
  assign     lane1_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[1].fifo_read_strmId            ;
  assign     lane1_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[1].fifo_read_data              ;
  assign     from_stOp_fifo[1].cntl                                =  lane1_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[1].strmId                              =  lane1_fromStOp_strm_id             ;
  assign     from_stOp_fifo[1].data                                =  lane1_fromStOp_strm_data           ;
  assign     from_stOp_fifo[1].fifo_write                          =  lane1_fromStOp_strm_data_valid     ;
  assign     lane1_fromStOp_strm_fifo_data_available    = ~lane1_fromStOp_strm_fifo_empty     ;
  assign     lane1_fromStOp_strm_fifo_dma_pkt_available = (lane1_fromStOp_strm_fifo_eop_count > 0) | lane1_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane2, stream to NoC 
  assign     from_stOp_fifo[2].clear                               =  clear_op                             ;
  assign     lane2_fromStOp_strm_fifo_empty             =  from_stOp_fifo[2].fifo_empty                  ;
  assign     lane2_fromStOp_strm_fifo_depth             =  from_stOp_fifo[2].fifo_depth                  ;
  assign     lane2_fromStOp_strm_ready                  = ~from_stOp_fifo[2].fifo_almost_full            ;
  assign     lane2_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[2].fifo_eop_count              ;
  assign     from_stOp_fifo[2].fifo_read                           =  lane2_fromStOp_strm_fifo_read      ;
  assign     lane2_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[2].fifo_read_cntl              ;
  assign     lane2_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[2].fifo_read_data_valid        ;
  assign     lane2_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[2].fifo_read_strmId            ;
  assign     lane2_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[2].fifo_read_data              ;
  assign     from_stOp_fifo[2].cntl                                =  lane2_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[2].strmId                              =  lane2_fromStOp_strm_id             ;
  assign     from_stOp_fifo[2].data                                =  lane2_fromStOp_strm_data           ;
  assign     from_stOp_fifo[2].fifo_write                          =  lane2_fromStOp_strm_data_valid     ;
  assign     lane2_fromStOp_strm_fifo_data_available    = ~lane2_fromStOp_strm_fifo_empty     ;
  assign     lane2_fromStOp_strm_fifo_dma_pkt_available = (lane2_fromStOp_strm_fifo_eop_count > 0) | lane2_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane3, stream to NoC 
  assign     from_stOp_fifo[3].clear                               =  clear_op                             ;
  assign     lane3_fromStOp_strm_fifo_empty             =  from_stOp_fifo[3].fifo_empty                  ;
  assign     lane3_fromStOp_strm_fifo_depth             =  from_stOp_fifo[3].fifo_depth                  ;
  assign     lane3_fromStOp_strm_ready                  = ~from_stOp_fifo[3].fifo_almost_full            ;
  assign     lane3_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[3].fifo_eop_count              ;
  assign     from_stOp_fifo[3].fifo_read                           =  lane3_fromStOp_strm_fifo_read      ;
  assign     lane3_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[3].fifo_read_cntl              ;
  assign     lane3_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[3].fifo_read_data_valid        ;
  assign     lane3_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[3].fifo_read_strmId            ;
  assign     lane3_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[3].fifo_read_data              ;
  assign     from_stOp_fifo[3].cntl                                =  lane3_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[3].strmId                              =  lane3_fromStOp_strm_id             ;
  assign     from_stOp_fifo[3].data                                =  lane3_fromStOp_strm_data           ;
  assign     from_stOp_fifo[3].fifo_write                          =  lane3_fromStOp_strm_data_valid     ;
  assign     lane3_fromStOp_strm_fifo_data_available    = ~lane3_fromStOp_strm_fifo_empty     ;
  assign     lane3_fromStOp_strm_fifo_dma_pkt_available = (lane3_fromStOp_strm_fifo_eop_count > 0) | lane3_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane4, stream to NoC 
  assign     from_stOp_fifo[4].clear                               =  clear_op                             ;
  assign     lane4_fromStOp_strm_fifo_empty             =  from_stOp_fifo[4].fifo_empty                  ;
  assign     lane4_fromStOp_strm_fifo_depth             =  from_stOp_fifo[4].fifo_depth                  ;
  assign     lane4_fromStOp_strm_ready                  = ~from_stOp_fifo[4].fifo_almost_full            ;
  assign     lane4_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[4].fifo_eop_count              ;
  assign     from_stOp_fifo[4].fifo_read                           =  lane4_fromStOp_strm_fifo_read      ;
  assign     lane4_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[4].fifo_read_cntl              ;
  assign     lane4_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[4].fifo_read_data_valid        ;
  assign     lane4_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[4].fifo_read_strmId            ;
  assign     lane4_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[4].fifo_read_data              ;
  assign     from_stOp_fifo[4].cntl                                =  lane4_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[4].strmId                              =  lane4_fromStOp_strm_id             ;
  assign     from_stOp_fifo[4].data                                =  lane4_fromStOp_strm_data           ;
  assign     from_stOp_fifo[4].fifo_write                          =  lane4_fromStOp_strm_data_valid     ;
  assign     lane4_fromStOp_strm_fifo_data_available    = ~lane4_fromStOp_strm_fifo_empty     ;
  assign     lane4_fromStOp_strm_fifo_dma_pkt_available = (lane4_fromStOp_strm_fifo_eop_count > 0) | lane4_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane5, stream to NoC 
  assign     from_stOp_fifo[5].clear                               =  clear_op                             ;
  assign     lane5_fromStOp_strm_fifo_empty             =  from_stOp_fifo[5].fifo_empty                  ;
  assign     lane5_fromStOp_strm_fifo_depth             =  from_stOp_fifo[5].fifo_depth                  ;
  assign     lane5_fromStOp_strm_ready                  = ~from_stOp_fifo[5].fifo_almost_full            ;
  assign     lane5_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[5].fifo_eop_count              ;
  assign     from_stOp_fifo[5].fifo_read                           =  lane5_fromStOp_strm_fifo_read      ;
  assign     lane5_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[5].fifo_read_cntl              ;
  assign     lane5_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[5].fifo_read_data_valid        ;
  assign     lane5_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[5].fifo_read_strmId            ;
  assign     lane5_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[5].fifo_read_data              ;
  assign     from_stOp_fifo[5].cntl                                =  lane5_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[5].strmId                              =  lane5_fromStOp_strm_id             ;
  assign     from_stOp_fifo[5].data                                =  lane5_fromStOp_strm_data           ;
  assign     from_stOp_fifo[5].fifo_write                          =  lane5_fromStOp_strm_data_valid     ;
  assign     lane5_fromStOp_strm_fifo_data_available    = ~lane5_fromStOp_strm_fifo_empty     ;
  assign     lane5_fromStOp_strm_fifo_dma_pkt_available = (lane5_fromStOp_strm_fifo_eop_count > 0) | lane5_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane6, stream to NoC 
  assign     from_stOp_fifo[6].clear                               =  clear_op                             ;
  assign     lane6_fromStOp_strm_fifo_empty             =  from_stOp_fifo[6].fifo_empty                  ;
  assign     lane6_fromStOp_strm_fifo_depth             =  from_stOp_fifo[6].fifo_depth                  ;
  assign     lane6_fromStOp_strm_ready                  = ~from_stOp_fifo[6].fifo_almost_full            ;
  assign     lane6_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[6].fifo_eop_count              ;
  assign     from_stOp_fifo[6].fifo_read                           =  lane6_fromStOp_strm_fifo_read      ;
  assign     lane6_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[6].fifo_read_cntl              ;
  assign     lane6_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[6].fifo_read_data_valid        ;
  assign     lane6_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[6].fifo_read_strmId            ;
  assign     lane6_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[6].fifo_read_data              ;
  assign     from_stOp_fifo[6].cntl                                =  lane6_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[6].strmId                              =  lane6_fromStOp_strm_id             ;
  assign     from_stOp_fifo[6].data                                =  lane6_fromStOp_strm_data           ;
  assign     from_stOp_fifo[6].fifo_write                          =  lane6_fromStOp_strm_data_valid     ;
  assign     lane6_fromStOp_strm_fifo_data_available    = ~lane6_fromStOp_strm_fifo_empty     ;
  assign     lane6_fromStOp_strm_fifo_dma_pkt_available = (lane6_fromStOp_strm_fifo_eop_count > 0) | lane6_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane7, stream to NoC 
  assign     from_stOp_fifo[7].clear                               =  clear_op                             ;
  assign     lane7_fromStOp_strm_fifo_empty             =  from_stOp_fifo[7].fifo_empty                  ;
  assign     lane7_fromStOp_strm_fifo_depth             =  from_stOp_fifo[7].fifo_depth                  ;
  assign     lane7_fromStOp_strm_ready                  = ~from_stOp_fifo[7].fifo_almost_full            ;
  assign     lane7_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[7].fifo_eop_count              ;
  assign     from_stOp_fifo[7].fifo_read                           =  lane7_fromStOp_strm_fifo_read      ;
  assign     lane7_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[7].fifo_read_cntl              ;
  assign     lane7_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[7].fifo_read_data_valid        ;
  assign     lane7_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[7].fifo_read_strmId            ;
  assign     lane7_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[7].fifo_read_data              ;
  assign     from_stOp_fifo[7].cntl                                =  lane7_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[7].strmId                              =  lane7_fromStOp_strm_id             ;
  assign     from_stOp_fifo[7].data                                =  lane7_fromStOp_strm_data           ;
  assign     from_stOp_fifo[7].fifo_write                          =  lane7_fromStOp_strm_data_valid     ;
  assign     lane7_fromStOp_strm_fifo_data_available    = ~lane7_fromStOp_strm_fifo_empty     ;
  assign     lane7_fromStOp_strm_fifo_dma_pkt_available = (lane7_fromStOp_strm_fifo_eop_count > 0) | lane7_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane8, stream to NoC 
  assign     from_stOp_fifo[8].clear                               =  clear_op                             ;
  assign     lane8_fromStOp_strm_fifo_empty             =  from_stOp_fifo[8].fifo_empty                  ;
  assign     lane8_fromStOp_strm_fifo_depth             =  from_stOp_fifo[8].fifo_depth                  ;
  assign     lane8_fromStOp_strm_ready                  = ~from_stOp_fifo[8].fifo_almost_full            ;
  assign     lane8_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[8].fifo_eop_count              ;
  assign     from_stOp_fifo[8].fifo_read                           =  lane8_fromStOp_strm_fifo_read      ;
  assign     lane8_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[8].fifo_read_cntl              ;
  assign     lane8_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[8].fifo_read_data_valid        ;
  assign     lane8_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[8].fifo_read_strmId            ;
  assign     lane8_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[8].fifo_read_data              ;
  assign     from_stOp_fifo[8].cntl                                =  lane8_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[8].strmId                              =  lane8_fromStOp_strm_id             ;
  assign     from_stOp_fifo[8].data                                =  lane8_fromStOp_strm_data           ;
  assign     from_stOp_fifo[8].fifo_write                          =  lane8_fromStOp_strm_data_valid     ;
  assign     lane8_fromStOp_strm_fifo_data_available    = ~lane8_fromStOp_strm_fifo_empty     ;
  assign     lane8_fromStOp_strm_fifo_dma_pkt_available = (lane8_fromStOp_strm_fifo_eop_count > 0) | lane8_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane9, stream to NoC 
  assign     from_stOp_fifo[9].clear                               =  clear_op                             ;
  assign     lane9_fromStOp_strm_fifo_empty             =  from_stOp_fifo[9].fifo_empty                  ;
  assign     lane9_fromStOp_strm_fifo_depth             =  from_stOp_fifo[9].fifo_depth                  ;
  assign     lane9_fromStOp_strm_ready                  = ~from_stOp_fifo[9].fifo_almost_full            ;
  assign     lane9_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[9].fifo_eop_count              ;
  assign     from_stOp_fifo[9].fifo_read                           =  lane9_fromStOp_strm_fifo_read      ;
  assign     lane9_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[9].fifo_read_cntl              ;
  assign     lane9_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[9].fifo_read_data_valid        ;
  assign     lane9_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[9].fifo_read_strmId            ;
  assign     lane9_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[9].fifo_read_data              ;
  assign     from_stOp_fifo[9].cntl                                =  lane9_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[9].strmId                              =  lane9_fromStOp_strm_id             ;
  assign     from_stOp_fifo[9].data                                =  lane9_fromStOp_strm_data           ;
  assign     from_stOp_fifo[9].fifo_write                          =  lane9_fromStOp_strm_data_valid     ;
  assign     lane9_fromStOp_strm_fifo_data_available    = ~lane9_fromStOp_strm_fifo_empty     ;
  assign     lane9_fromStOp_strm_fifo_dma_pkt_available = (lane9_fromStOp_strm_fifo_eop_count > 0) | lane9_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane10, stream to NoC 
  assign     from_stOp_fifo[10].clear                               =  clear_op                             ;
  assign     lane10_fromStOp_strm_fifo_empty             =  from_stOp_fifo[10].fifo_empty                  ;
  assign     lane10_fromStOp_strm_fifo_depth             =  from_stOp_fifo[10].fifo_depth                  ;
  assign     lane10_fromStOp_strm_ready                  = ~from_stOp_fifo[10].fifo_almost_full            ;
  assign     lane10_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[10].fifo_eop_count              ;
  assign     from_stOp_fifo[10].fifo_read                           =  lane10_fromStOp_strm_fifo_read      ;
  assign     lane10_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[10].fifo_read_cntl              ;
  assign     lane10_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[10].fifo_read_data_valid        ;
  assign     lane10_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[10].fifo_read_strmId            ;
  assign     lane10_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[10].fifo_read_data              ;
  assign     from_stOp_fifo[10].cntl                                =  lane10_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[10].strmId                              =  lane10_fromStOp_strm_id             ;
  assign     from_stOp_fifo[10].data                                =  lane10_fromStOp_strm_data           ;
  assign     from_stOp_fifo[10].fifo_write                          =  lane10_fromStOp_strm_data_valid     ;
  assign     lane10_fromStOp_strm_fifo_data_available    = ~lane10_fromStOp_strm_fifo_empty     ;
  assign     lane10_fromStOp_strm_fifo_dma_pkt_available = (lane10_fromStOp_strm_fifo_eop_count > 0) | lane10_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane11, stream to NoC 
  assign     from_stOp_fifo[11].clear                               =  clear_op                             ;
  assign     lane11_fromStOp_strm_fifo_empty             =  from_stOp_fifo[11].fifo_empty                  ;
  assign     lane11_fromStOp_strm_fifo_depth             =  from_stOp_fifo[11].fifo_depth                  ;
  assign     lane11_fromStOp_strm_ready                  = ~from_stOp_fifo[11].fifo_almost_full            ;
  assign     lane11_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[11].fifo_eop_count              ;
  assign     from_stOp_fifo[11].fifo_read                           =  lane11_fromStOp_strm_fifo_read      ;
  assign     lane11_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[11].fifo_read_cntl              ;
  assign     lane11_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[11].fifo_read_data_valid        ;
  assign     lane11_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[11].fifo_read_strmId            ;
  assign     lane11_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[11].fifo_read_data              ;
  assign     from_stOp_fifo[11].cntl                                =  lane11_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[11].strmId                              =  lane11_fromStOp_strm_id             ;
  assign     from_stOp_fifo[11].data                                =  lane11_fromStOp_strm_data           ;
  assign     from_stOp_fifo[11].fifo_write                          =  lane11_fromStOp_strm_data_valid     ;
  assign     lane11_fromStOp_strm_fifo_data_available    = ~lane11_fromStOp_strm_fifo_empty     ;
  assign     lane11_fromStOp_strm_fifo_dma_pkt_available = (lane11_fromStOp_strm_fifo_eop_count > 0) | lane11_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane12, stream to NoC 
  assign     from_stOp_fifo[12].clear                               =  clear_op                             ;
  assign     lane12_fromStOp_strm_fifo_empty             =  from_stOp_fifo[12].fifo_empty                  ;
  assign     lane12_fromStOp_strm_fifo_depth             =  from_stOp_fifo[12].fifo_depth                  ;
  assign     lane12_fromStOp_strm_ready                  = ~from_stOp_fifo[12].fifo_almost_full            ;
  assign     lane12_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[12].fifo_eop_count              ;
  assign     from_stOp_fifo[12].fifo_read                           =  lane12_fromStOp_strm_fifo_read      ;
  assign     lane12_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[12].fifo_read_cntl              ;
  assign     lane12_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[12].fifo_read_data_valid        ;
  assign     lane12_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[12].fifo_read_strmId            ;
  assign     lane12_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[12].fifo_read_data              ;
  assign     from_stOp_fifo[12].cntl                                =  lane12_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[12].strmId                              =  lane12_fromStOp_strm_id             ;
  assign     from_stOp_fifo[12].data                                =  lane12_fromStOp_strm_data           ;
  assign     from_stOp_fifo[12].fifo_write                          =  lane12_fromStOp_strm_data_valid     ;
  assign     lane12_fromStOp_strm_fifo_data_available    = ~lane12_fromStOp_strm_fifo_empty     ;
  assign     lane12_fromStOp_strm_fifo_dma_pkt_available = (lane12_fromStOp_strm_fifo_eop_count > 0) | lane12_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane13, stream to NoC 
  assign     from_stOp_fifo[13].clear                               =  clear_op                             ;
  assign     lane13_fromStOp_strm_fifo_empty             =  from_stOp_fifo[13].fifo_empty                  ;
  assign     lane13_fromStOp_strm_fifo_depth             =  from_stOp_fifo[13].fifo_depth                  ;
  assign     lane13_fromStOp_strm_ready                  = ~from_stOp_fifo[13].fifo_almost_full            ;
  assign     lane13_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[13].fifo_eop_count              ;
  assign     from_stOp_fifo[13].fifo_read                           =  lane13_fromStOp_strm_fifo_read      ;
  assign     lane13_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[13].fifo_read_cntl              ;
  assign     lane13_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[13].fifo_read_data_valid        ;
  assign     lane13_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[13].fifo_read_strmId            ;
  assign     lane13_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[13].fifo_read_data              ;
  assign     from_stOp_fifo[13].cntl                                =  lane13_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[13].strmId                              =  lane13_fromStOp_strm_id             ;
  assign     from_stOp_fifo[13].data                                =  lane13_fromStOp_strm_data           ;
  assign     from_stOp_fifo[13].fifo_write                          =  lane13_fromStOp_strm_data_valid     ;
  assign     lane13_fromStOp_strm_fifo_data_available    = ~lane13_fromStOp_strm_fifo_empty     ;
  assign     lane13_fromStOp_strm_fifo_dma_pkt_available = (lane13_fromStOp_strm_fifo_eop_count > 0) | lane13_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane14, stream to NoC 
  assign     from_stOp_fifo[14].clear                               =  clear_op                             ;
  assign     lane14_fromStOp_strm_fifo_empty             =  from_stOp_fifo[14].fifo_empty                  ;
  assign     lane14_fromStOp_strm_fifo_depth             =  from_stOp_fifo[14].fifo_depth                  ;
  assign     lane14_fromStOp_strm_ready                  = ~from_stOp_fifo[14].fifo_almost_full            ;
  assign     lane14_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[14].fifo_eop_count              ;
  assign     from_stOp_fifo[14].fifo_read                           =  lane14_fromStOp_strm_fifo_read      ;
  assign     lane14_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[14].fifo_read_cntl              ;
  assign     lane14_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[14].fifo_read_data_valid        ;
  assign     lane14_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[14].fifo_read_strmId            ;
  assign     lane14_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[14].fifo_read_data              ;
  assign     from_stOp_fifo[14].cntl                                =  lane14_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[14].strmId                              =  lane14_fromStOp_strm_id             ;
  assign     from_stOp_fifo[14].data                                =  lane14_fromStOp_strm_data           ;
  assign     from_stOp_fifo[14].fifo_write                          =  lane14_fromStOp_strm_data_valid     ;
  assign     lane14_fromStOp_strm_fifo_data_available    = ~lane14_fromStOp_strm_fifo_empty     ;
  assign     lane14_fromStOp_strm_fifo_dma_pkt_available = (lane14_fromStOp_strm_fifo_eop_count > 0) | lane14_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane15, stream to NoC 
  assign     from_stOp_fifo[15].clear                               =  clear_op                             ;
  assign     lane15_fromStOp_strm_fifo_empty             =  from_stOp_fifo[15].fifo_empty                  ;
  assign     lane15_fromStOp_strm_fifo_depth             =  from_stOp_fifo[15].fifo_depth                  ;
  assign     lane15_fromStOp_strm_ready                  = ~from_stOp_fifo[15].fifo_almost_full            ;
  assign     lane15_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[15].fifo_eop_count              ;
  assign     from_stOp_fifo[15].fifo_read                           =  lane15_fromStOp_strm_fifo_read      ;
  assign     lane15_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[15].fifo_read_cntl              ;
  assign     lane15_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[15].fifo_read_data_valid        ;
  assign     lane15_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[15].fifo_read_strmId            ;
  assign     lane15_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[15].fifo_read_data              ;
  assign     from_stOp_fifo[15].cntl                                =  lane15_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[15].strmId                              =  lane15_fromStOp_strm_id             ;
  assign     from_stOp_fifo[15].data                                =  lane15_fromStOp_strm_data           ;
  assign     from_stOp_fifo[15].fifo_write                          =  lane15_fromStOp_strm_data_valid     ;
  assign     lane15_fromStOp_strm_fifo_data_available    = ~lane15_fromStOp_strm_fifo_empty     ;
  assign     lane15_fromStOp_strm_fifo_dma_pkt_available = (lane15_fromStOp_strm_fifo_eop_count > 0) | lane15_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane16, stream to NoC 
  assign     from_stOp_fifo[16].clear                               =  clear_op                             ;
  assign     lane16_fromStOp_strm_fifo_empty             =  from_stOp_fifo[16].fifo_empty                  ;
  assign     lane16_fromStOp_strm_fifo_depth             =  from_stOp_fifo[16].fifo_depth                  ;
  assign     lane16_fromStOp_strm_ready                  = ~from_stOp_fifo[16].fifo_almost_full            ;
  assign     lane16_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[16].fifo_eop_count              ;
  assign     from_stOp_fifo[16].fifo_read                           =  lane16_fromStOp_strm_fifo_read      ;
  assign     lane16_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[16].fifo_read_cntl              ;
  assign     lane16_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[16].fifo_read_data_valid        ;
  assign     lane16_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[16].fifo_read_strmId            ;
  assign     lane16_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[16].fifo_read_data              ;
  assign     from_stOp_fifo[16].cntl                                =  lane16_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[16].strmId                              =  lane16_fromStOp_strm_id             ;
  assign     from_stOp_fifo[16].data                                =  lane16_fromStOp_strm_data           ;
  assign     from_stOp_fifo[16].fifo_write                          =  lane16_fromStOp_strm_data_valid     ;
  assign     lane16_fromStOp_strm_fifo_data_available    = ~lane16_fromStOp_strm_fifo_empty     ;
  assign     lane16_fromStOp_strm_fifo_dma_pkt_available = (lane16_fromStOp_strm_fifo_eop_count > 0) | lane16_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane17, stream to NoC 
  assign     from_stOp_fifo[17].clear                               =  clear_op                             ;
  assign     lane17_fromStOp_strm_fifo_empty             =  from_stOp_fifo[17].fifo_empty                  ;
  assign     lane17_fromStOp_strm_fifo_depth             =  from_stOp_fifo[17].fifo_depth                  ;
  assign     lane17_fromStOp_strm_ready                  = ~from_stOp_fifo[17].fifo_almost_full            ;
  assign     lane17_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[17].fifo_eop_count              ;
  assign     from_stOp_fifo[17].fifo_read                           =  lane17_fromStOp_strm_fifo_read      ;
  assign     lane17_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[17].fifo_read_cntl              ;
  assign     lane17_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[17].fifo_read_data_valid        ;
  assign     lane17_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[17].fifo_read_strmId            ;
  assign     lane17_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[17].fifo_read_data              ;
  assign     from_stOp_fifo[17].cntl                                =  lane17_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[17].strmId                              =  lane17_fromStOp_strm_id             ;
  assign     from_stOp_fifo[17].data                                =  lane17_fromStOp_strm_data           ;
  assign     from_stOp_fifo[17].fifo_write                          =  lane17_fromStOp_strm_data_valid     ;
  assign     lane17_fromStOp_strm_fifo_data_available    = ~lane17_fromStOp_strm_fifo_empty     ;
  assign     lane17_fromStOp_strm_fifo_dma_pkt_available = (lane17_fromStOp_strm_fifo_eop_count > 0) | lane17_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane18, stream to NoC 
  assign     from_stOp_fifo[18].clear                               =  clear_op                             ;
  assign     lane18_fromStOp_strm_fifo_empty             =  from_stOp_fifo[18].fifo_empty                  ;
  assign     lane18_fromStOp_strm_fifo_depth             =  from_stOp_fifo[18].fifo_depth                  ;
  assign     lane18_fromStOp_strm_ready                  = ~from_stOp_fifo[18].fifo_almost_full            ;
  assign     lane18_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[18].fifo_eop_count              ;
  assign     from_stOp_fifo[18].fifo_read                           =  lane18_fromStOp_strm_fifo_read      ;
  assign     lane18_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[18].fifo_read_cntl              ;
  assign     lane18_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[18].fifo_read_data_valid        ;
  assign     lane18_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[18].fifo_read_strmId            ;
  assign     lane18_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[18].fifo_read_data              ;
  assign     from_stOp_fifo[18].cntl                                =  lane18_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[18].strmId                              =  lane18_fromStOp_strm_id             ;
  assign     from_stOp_fifo[18].data                                =  lane18_fromStOp_strm_data           ;
  assign     from_stOp_fifo[18].fifo_write                          =  lane18_fromStOp_strm_data_valid     ;
  assign     lane18_fromStOp_strm_fifo_data_available    = ~lane18_fromStOp_strm_fifo_empty     ;
  assign     lane18_fromStOp_strm_fifo_dma_pkt_available = (lane18_fromStOp_strm_fifo_eop_count > 0) | lane18_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane19, stream to NoC 
  assign     from_stOp_fifo[19].clear                               =  clear_op                             ;
  assign     lane19_fromStOp_strm_fifo_empty             =  from_stOp_fifo[19].fifo_empty                  ;
  assign     lane19_fromStOp_strm_fifo_depth             =  from_stOp_fifo[19].fifo_depth                  ;
  assign     lane19_fromStOp_strm_ready                  = ~from_stOp_fifo[19].fifo_almost_full            ;
  assign     lane19_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[19].fifo_eop_count              ;
  assign     from_stOp_fifo[19].fifo_read                           =  lane19_fromStOp_strm_fifo_read      ;
  assign     lane19_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[19].fifo_read_cntl              ;
  assign     lane19_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[19].fifo_read_data_valid        ;
  assign     lane19_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[19].fifo_read_strmId            ;
  assign     lane19_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[19].fifo_read_data              ;
  assign     from_stOp_fifo[19].cntl                                =  lane19_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[19].strmId                              =  lane19_fromStOp_strm_id             ;
  assign     from_stOp_fifo[19].data                                =  lane19_fromStOp_strm_data           ;
  assign     from_stOp_fifo[19].fifo_write                          =  lane19_fromStOp_strm_data_valid     ;
  assign     lane19_fromStOp_strm_fifo_data_available    = ~lane19_fromStOp_strm_fifo_empty     ;
  assign     lane19_fromStOp_strm_fifo_dma_pkt_available = (lane19_fromStOp_strm_fifo_eop_count > 0) | lane19_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane20, stream to NoC 
  assign     from_stOp_fifo[20].clear                               =  clear_op                             ;
  assign     lane20_fromStOp_strm_fifo_empty             =  from_stOp_fifo[20].fifo_empty                  ;
  assign     lane20_fromStOp_strm_fifo_depth             =  from_stOp_fifo[20].fifo_depth                  ;
  assign     lane20_fromStOp_strm_ready                  = ~from_stOp_fifo[20].fifo_almost_full            ;
  assign     lane20_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[20].fifo_eop_count              ;
  assign     from_stOp_fifo[20].fifo_read                           =  lane20_fromStOp_strm_fifo_read      ;
  assign     lane20_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[20].fifo_read_cntl              ;
  assign     lane20_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[20].fifo_read_data_valid        ;
  assign     lane20_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[20].fifo_read_strmId            ;
  assign     lane20_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[20].fifo_read_data              ;
  assign     from_stOp_fifo[20].cntl                                =  lane20_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[20].strmId                              =  lane20_fromStOp_strm_id             ;
  assign     from_stOp_fifo[20].data                                =  lane20_fromStOp_strm_data           ;
  assign     from_stOp_fifo[20].fifo_write                          =  lane20_fromStOp_strm_data_valid     ;
  assign     lane20_fromStOp_strm_fifo_data_available    = ~lane20_fromStOp_strm_fifo_empty     ;
  assign     lane20_fromStOp_strm_fifo_dma_pkt_available = (lane20_fromStOp_strm_fifo_eop_count > 0) | lane20_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane21, stream to NoC 
  assign     from_stOp_fifo[21].clear                               =  clear_op                             ;
  assign     lane21_fromStOp_strm_fifo_empty             =  from_stOp_fifo[21].fifo_empty                  ;
  assign     lane21_fromStOp_strm_fifo_depth             =  from_stOp_fifo[21].fifo_depth                  ;
  assign     lane21_fromStOp_strm_ready                  = ~from_stOp_fifo[21].fifo_almost_full            ;
  assign     lane21_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[21].fifo_eop_count              ;
  assign     from_stOp_fifo[21].fifo_read                           =  lane21_fromStOp_strm_fifo_read      ;
  assign     lane21_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[21].fifo_read_cntl              ;
  assign     lane21_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[21].fifo_read_data_valid        ;
  assign     lane21_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[21].fifo_read_strmId            ;
  assign     lane21_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[21].fifo_read_data              ;
  assign     from_stOp_fifo[21].cntl                                =  lane21_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[21].strmId                              =  lane21_fromStOp_strm_id             ;
  assign     from_stOp_fifo[21].data                                =  lane21_fromStOp_strm_data           ;
  assign     from_stOp_fifo[21].fifo_write                          =  lane21_fromStOp_strm_data_valid     ;
  assign     lane21_fromStOp_strm_fifo_data_available    = ~lane21_fromStOp_strm_fifo_empty     ;
  assign     lane21_fromStOp_strm_fifo_dma_pkt_available = (lane21_fromStOp_strm_fifo_eop_count > 0) | lane21_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane22, stream to NoC 
  assign     from_stOp_fifo[22].clear                               =  clear_op                             ;
  assign     lane22_fromStOp_strm_fifo_empty             =  from_stOp_fifo[22].fifo_empty                  ;
  assign     lane22_fromStOp_strm_fifo_depth             =  from_stOp_fifo[22].fifo_depth                  ;
  assign     lane22_fromStOp_strm_ready                  = ~from_stOp_fifo[22].fifo_almost_full            ;
  assign     lane22_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[22].fifo_eop_count              ;
  assign     from_stOp_fifo[22].fifo_read                           =  lane22_fromStOp_strm_fifo_read      ;
  assign     lane22_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[22].fifo_read_cntl              ;
  assign     lane22_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[22].fifo_read_data_valid        ;
  assign     lane22_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[22].fifo_read_strmId            ;
  assign     lane22_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[22].fifo_read_data              ;
  assign     from_stOp_fifo[22].cntl                                =  lane22_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[22].strmId                              =  lane22_fromStOp_strm_id             ;
  assign     from_stOp_fifo[22].data                                =  lane22_fromStOp_strm_data           ;
  assign     from_stOp_fifo[22].fifo_write                          =  lane22_fromStOp_strm_data_valid     ;
  assign     lane22_fromStOp_strm_fifo_data_available    = ~lane22_fromStOp_strm_fifo_empty     ;
  assign     lane22_fromStOp_strm_fifo_dma_pkt_available = (lane22_fromStOp_strm_fifo_eop_count > 0) | lane22_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane23, stream to NoC 
  assign     from_stOp_fifo[23].clear                               =  clear_op                             ;
  assign     lane23_fromStOp_strm_fifo_empty             =  from_stOp_fifo[23].fifo_empty                  ;
  assign     lane23_fromStOp_strm_fifo_depth             =  from_stOp_fifo[23].fifo_depth                  ;
  assign     lane23_fromStOp_strm_ready                  = ~from_stOp_fifo[23].fifo_almost_full            ;
  assign     lane23_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[23].fifo_eop_count              ;
  assign     from_stOp_fifo[23].fifo_read                           =  lane23_fromStOp_strm_fifo_read      ;
  assign     lane23_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[23].fifo_read_cntl              ;
  assign     lane23_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[23].fifo_read_data_valid        ;
  assign     lane23_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[23].fifo_read_strmId            ;
  assign     lane23_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[23].fifo_read_data              ;
  assign     from_stOp_fifo[23].cntl                                =  lane23_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[23].strmId                              =  lane23_fromStOp_strm_id             ;
  assign     from_stOp_fifo[23].data                                =  lane23_fromStOp_strm_data           ;
  assign     from_stOp_fifo[23].fifo_write                          =  lane23_fromStOp_strm_data_valid     ;
  assign     lane23_fromStOp_strm_fifo_data_available    = ~lane23_fromStOp_strm_fifo_empty     ;
  assign     lane23_fromStOp_strm_fifo_dma_pkt_available = (lane23_fromStOp_strm_fifo_eop_count > 0) | lane23_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane24, stream to NoC 
  assign     from_stOp_fifo[24].clear                               =  clear_op                             ;
  assign     lane24_fromStOp_strm_fifo_empty             =  from_stOp_fifo[24].fifo_empty                  ;
  assign     lane24_fromStOp_strm_fifo_depth             =  from_stOp_fifo[24].fifo_depth                  ;
  assign     lane24_fromStOp_strm_ready                  = ~from_stOp_fifo[24].fifo_almost_full            ;
  assign     lane24_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[24].fifo_eop_count              ;
  assign     from_stOp_fifo[24].fifo_read                           =  lane24_fromStOp_strm_fifo_read      ;
  assign     lane24_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[24].fifo_read_cntl              ;
  assign     lane24_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[24].fifo_read_data_valid        ;
  assign     lane24_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[24].fifo_read_strmId            ;
  assign     lane24_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[24].fifo_read_data              ;
  assign     from_stOp_fifo[24].cntl                                =  lane24_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[24].strmId                              =  lane24_fromStOp_strm_id             ;
  assign     from_stOp_fifo[24].data                                =  lane24_fromStOp_strm_data           ;
  assign     from_stOp_fifo[24].fifo_write                          =  lane24_fromStOp_strm_data_valid     ;
  assign     lane24_fromStOp_strm_fifo_data_available    = ~lane24_fromStOp_strm_fifo_empty     ;
  assign     lane24_fromStOp_strm_fifo_dma_pkt_available = (lane24_fromStOp_strm_fifo_eop_count > 0) | lane24_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane25, stream to NoC 
  assign     from_stOp_fifo[25].clear                               =  clear_op                             ;
  assign     lane25_fromStOp_strm_fifo_empty             =  from_stOp_fifo[25].fifo_empty                  ;
  assign     lane25_fromStOp_strm_fifo_depth             =  from_stOp_fifo[25].fifo_depth                  ;
  assign     lane25_fromStOp_strm_ready                  = ~from_stOp_fifo[25].fifo_almost_full            ;
  assign     lane25_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[25].fifo_eop_count              ;
  assign     from_stOp_fifo[25].fifo_read                           =  lane25_fromStOp_strm_fifo_read      ;
  assign     lane25_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[25].fifo_read_cntl              ;
  assign     lane25_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[25].fifo_read_data_valid        ;
  assign     lane25_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[25].fifo_read_strmId            ;
  assign     lane25_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[25].fifo_read_data              ;
  assign     from_stOp_fifo[25].cntl                                =  lane25_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[25].strmId                              =  lane25_fromStOp_strm_id             ;
  assign     from_stOp_fifo[25].data                                =  lane25_fromStOp_strm_data           ;
  assign     from_stOp_fifo[25].fifo_write                          =  lane25_fromStOp_strm_data_valid     ;
  assign     lane25_fromStOp_strm_fifo_data_available    = ~lane25_fromStOp_strm_fifo_empty     ;
  assign     lane25_fromStOp_strm_fifo_dma_pkt_available = (lane25_fromStOp_strm_fifo_eop_count > 0) | lane25_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane26, stream to NoC 
  assign     from_stOp_fifo[26].clear                               =  clear_op                             ;
  assign     lane26_fromStOp_strm_fifo_empty             =  from_stOp_fifo[26].fifo_empty                  ;
  assign     lane26_fromStOp_strm_fifo_depth             =  from_stOp_fifo[26].fifo_depth                  ;
  assign     lane26_fromStOp_strm_ready                  = ~from_stOp_fifo[26].fifo_almost_full            ;
  assign     lane26_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[26].fifo_eop_count              ;
  assign     from_stOp_fifo[26].fifo_read                           =  lane26_fromStOp_strm_fifo_read      ;
  assign     lane26_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[26].fifo_read_cntl              ;
  assign     lane26_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[26].fifo_read_data_valid        ;
  assign     lane26_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[26].fifo_read_strmId            ;
  assign     lane26_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[26].fifo_read_data              ;
  assign     from_stOp_fifo[26].cntl                                =  lane26_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[26].strmId                              =  lane26_fromStOp_strm_id             ;
  assign     from_stOp_fifo[26].data                                =  lane26_fromStOp_strm_data           ;
  assign     from_stOp_fifo[26].fifo_write                          =  lane26_fromStOp_strm_data_valid     ;
  assign     lane26_fromStOp_strm_fifo_data_available    = ~lane26_fromStOp_strm_fifo_empty     ;
  assign     lane26_fromStOp_strm_fifo_dma_pkt_available = (lane26_fromStOp_strm_fifo_eop_count > 0) | lane26_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane27, stream to NoC 
  assign     from_stOp_fifo[27].clear                               =  clear_op                             ;
  assign     lane27_fromStOp_strm_fifo_empty             =  from_stOp_fifo[27].fifo_empty                  ;
  assign     lane27_fromStOp_strm_fifo_depth             =  from_stOp_fifo[27].fifo_depth                  ;
  assign     lane27_fromStOp_strm_ready                  = ~from_stOp_fifo[27].fifo_almost_full            ;
  assign     lane27_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[27].fifo_eop_count              ;
  assign     from_stOp_fifo[27].fifo_read                           =  lane27_fromStOp_strm_fifo_read      ;
  assign     lane27_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[27].fifo_read_cntl              ;
  assign     lane27_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[27].fifo_read_data_valid        ;
  assign     lane27_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[27].fifo_read_strmId            ;
  assign     lane27_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[27].fifo_read_data              ;
  assign     from_stOp_fifo[27].cntl                                =  lane27_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[27].strmId                              =  lane27_fromStOp_strm_id             ;
  assign     from_stOp_fifo[27].data                                =  lane27_fromStOp_strm_data           ;
  assign     from_stOp_fifo[27].fifo_write                          =  lane27_fromStOp_strm_data_valid     ;
  assign     lane27_fromStOp_strm_fifo_data_available    = ~lane27_fromStOp_strm_fifo_empty     ;
  assign     lane27_fromStOp_strm_fifo_dma_pkt_available = (lane27_fromStOp_strm_fifo_eop_count > 0) | lane27_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane28, stream to NoC 
  assign     from_stOp_fifo[28].clear                               =  clear_op                             ;
  assign     lane28_fromStOp_strm_fifo_empty             =  from_stOp_fifo[28].fifo_empty                  ;
  assign     lane28_fromStOp_strm_fifo_depth             =  from_stOp_fifo[28].fifo_depth                  ;
  assign     lane28_fromStOp_strm_ready                  = ~from_stOp_fifo[28].fifo_almost_full            ;
  assign     lane28_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[28].fifo_eop_count              ;
  assign     from_stOp_fifo[28].fifo_read                           =  lane28_fromStOp_strm_fifo_read      ;
  assign     lane28_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[28].fifo_read_cntl              ;
  assign     lane28_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[28].fifo_read_data_valid        ;
  assign     lane28_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[28].fifo_read_strmId            ;
  assign     lane28_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[28].fifo_read_data              ;
  assign     from_stOp_fifo[28].cntl                                =  lane28_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[28].strmId                              =  lane28_fromStOp_strm_id             ;
  assign     from_stOp_fifo[28].data                                =  lane28_fromStOp_strm_data           ;
  assign     from_stOp_fifo[28].fifo_write                          =  lane28_fromStOp_strm_data_valid     ;
  assign     lane28_fromStOp_strm_fifo_data_available    = ~lane28_fromStOp_strm_fifo_empty     ;
  assign     lane28_fromStOp_strm_fifo_dma_pkt_available = (lane28_fromStOp_strm_fifo_eop_count > 0) | lane28_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane29, stream to NoC 
  assign     from_stOp_fifo[29].clear                               =  clear_op                             ;
  assign     lane29_fromStOp_strm_fifo_empty             =  from_stOp_fifo[29].fifo_empty                  ;
  assign     lane29_fromStOp_strm_fifo_depth             =  from_stOp_fifo[29].fifo_depth                  ;
  assign     lane29_fromStOp_strm_ready                  = ~from_stOp_fifo[29].fifo_almost_full            ;
  assign     lane29_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[29].fifo_eop_count              ;
  assign     from_stOp_fifo[29].fifo_read                           =  lane29_fromStOp_strm_fifo_read      ;
  assign     lane29_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[29].fifo_read_cntl              ;
  assign     lane29_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[29].fifo_read_data_valid        ;
  assign     lane29_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[29].fifo_read_strmId            ;
  assign     lane29_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[29].fifo_read_data              ;
  assign     from_stOp_fifo[29].cntl                                =  lane29_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[29].strmId                              =  lane29_fromStOp_strm_id             ;
  assign     from_stOp_fifo[29].data                                =  lane29_fromStOp_strm_data           ;
  assign     from_stOp_fifo[29].fifo_write                          =  lane29_fromStOp_strm_data_valid     ;
  assign     lane29_fromStOp_strm_fifo_data_available    = ~lane29_fromStOp_strm_fifo_empty     ;
  assign     lane29_fromStOp_strm_fifo_dma_pkt_available = (lane29_fromStOp_strm_fifo_eop_count > 0) | lane29_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane30, stream to NoC 
  assign     from_stOp_fifo[30].clear                               =  clear_op                             ;
  assign     lane30_fromStOp_strm_fifo_empty             =  from_stOp_fifo[30].fifo_empty                  ;
  assign     lane30_fromStOp_strm_fifo_depth             =  from_stOp_fifo[30].fifo_depth                  ;
  assign     lane30_fromStOp_strm_ready                  = ~from_stOp_fifo[30].fifo_almost_full            ;
  assign     lane30_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[30].fifo_eop_count              ;
  assign     from_stOp_fifo[30].fifo_read                           =  lane30_fromStOp_strm_fifo_read      ;
  assign     lane30_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[30].fifo_read_cntl              ;
  assign     lane30_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[30].fifo_read_data_valid        ;
  assign     lane30_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[30].fifo_read_strmId            ;
  assign     lane30_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[30].fifo_read_data              ;
  assign     from_stOp_fifo[30].cntl                                =  lane30_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[30].strmId                              =  lane30_fromStOp_strm_id             ;
  assign     from_stOp_fifo[30].data                                =  lane30_fromStOp_strm_data           ;
  assign     from_stOp_fifo[30].fifo_write                          =  lane30_fromStOp_strm_data_valid     ;
  assign     lane30_fromStOp_strm_fifo_data_available    = ~lane30_fromStOp_strm_fifo_empty     ;
  assign     lane30_fromStOp_strm_fifo_dma_pkt_available = (lane30_fromStOp_strm_fifo_eop_count > 0) | lane30_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet
  // lane31, stream to NoC 
  assign     from_stOp_fifo[31].clear                               =  clear_op                             ;
  assign     lane31_fromStOp_strm_fifo_empty             =  from_stOp_fifo[31].fifo_empty                  ;
  assign     lane31_fromStOp_strm_fifo_depth             =  from_stOp_fifo[31].fifo_depth                  ;
  assign     lane31_fromStOp_strm_ready                  = ~from_stOp_fifo[31].fifo_almost_full            ;
  assign     lane31_fromStOp_strm_fifo_eop_count         =  from_stOp_fifo[31].fifo_eop_count              ;
  assign     from_stOp_fifo[31].fifo_read                           =  lane31_fromStOp_strm_fifo_read      ;
  assign     lane31_fromStOp_strm_fifo_read_cntl         =  from_stOp_fifo[31].fifo_read_cntl              ;
  assign     lane31_fromStOp_strm_fifo_read_data_valid   =  from_stOp_fifo[31].fifo_read_data_valid        ;
  assign     lane31_fromStOp_strm_fifo_read_id           =  from_stOp_fifo[31].fifo_read_strmId            ;
  assign     lane31_fromStOp_strm_fifo_read_data         =  from_stOp_fifo[31].fifo_read_data              ;
  assign     from_stOp_fifo[31].cntl                                =  lane31_fromStOp_strm_cntl           ;
  assign     from_stOp_fifo[31].strmId                              =  lane31_fromStOp_strm_id             ;
  assign     from_stOp_fifo[31].data                                =  lane31_fromStOp_strm_data           ;
  assign     from_stOp_fifo[31].fifo_write                          =  lane31_fromStOp_strm_data_valid     ;
  assign     lane31_fromStOp_strm_fifo_data_available    = ~lane31_fromStOp_strm_fifo_empty     ;
  assign     lane31_fromStOp_strm_fifo_dma_pkt_available = (lane31_fromStOp_strm_fifo_eop_count > 0) | lane31_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet// Vector of available stOp data to be sent to NoC

  assign toNocDmaPacketAvailableVector[0] = lane0_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[1] = lane1_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[2] = lane2_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[3] = lane3_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[4] = lane4_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[5] = lane5_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[6] = lane6_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[7] = lane7_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[8] = lane8_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[9] = lane9_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[10] = lane10_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[11] = lane11_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[12] = lane12_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[13] = lane13_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[14] = lane14_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[15] = lane15_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[16] = lane16_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[17] = lane17_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[18] = lane18_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[19] = lane19_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[20] = lane20_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[21] = lane21_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[22] = lane22_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[23] = lane23_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[24] = lane24_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[25] = lane25_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[26] = lane26_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[27] = lane27_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[28] = lane28_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[29] = lane29_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[30] = lane30_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC
  assign toNocDmaPacketAvailableVector[31] = lane31_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC

  // lane0 stream to NoC 
  assign     cntl__sdp__lane0_strm_ready  = lane0_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane0_fromStOp_strm_cntl        <= sdp__cntl__lane0_strm_cntl      ;
      lane0_fromStOp_strm_id          <= sdp__cntl__lane0_strm_id        ;
      lane0_fromStOp_strm_data        <= sdp__cntl__lane0_strm_data      ;
      lane0_fromStOp_strm_data_valid  <= sdp__cntl__lane0_strm_data_valid;
    end 
  // lane1 stream to NoC 
  assign     cntl__sdp__lane1_strm_ready  = lane1_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane1_fromStOp_strm_cntl        <= sdp__cntl__lane1_strm_cntl      ;
      lane1_fromStOp_strm_id          <= sdp__cntl__lane1_strm_id        ;
      lane1_fromStOp_strm_data        <= sdp__cntl__lane1_strm_data      ;
      lane1_fromStOp_strm_data_valid  <= sdp__cntl__lane1_strm_data_valid;
    end 
  // lane2 stream to NoC 
  assign     cntl__sdp__lane2_strm_ready  = lane2_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane2_fromStOp_strm_cntl        <= sdp__cntl__lane2_strm_cntl      ;
      lane2_fromStOp_strm_id          <= sdp__cntl__lane2_strm_id        ;
      lane2_fromStOp_strm_data        <= sdp__cntl__lane2_strm_data      ;
      lane2_fromStOp_strm_data_valid  <= sdp__cntl__lane2_strm_data_valid;
    end 
  // lane3 stream to NoC 
  assign     cntl__sdp__lane3_strm_ready  = lane3_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane3_fromStOp_strm_cntl        <= sdp__cntl__lane3_strm_cntl      ;
      lane3_fromStOp_strm_id          <= sdp__cntl__lane3_strm_id        ;
      lane3_fromStOp_strm_data        <= sdp__cntl__lane3_strm_data      ;
      lane3_fromStOp_strm_data_valid  <= sdp__cntl__lane3_strm_data_valid;
    end 
  // lane4 stream to NoC 
  assign     cntl__sdp__lane4_strm_ready  = lane4_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane4_fromStOp_strm_cntl        <= sdp__cntl__lane4_strm_cntl      ;
      lane4_fromStOp_strm_id          <= sdp__cntl__lane4_strm_id        ;
      lane4_fromStOp_strm_data        <= sdp__cntl__lane4_strm_data      ;
      lane4_fromStOp_strm_data_valid  <= sdp__cntl__lane4_strm_data_valid;
    end 
  // lane5 stream to NoC 
  assign     cntl__sdp__lane5_strm_ready  = lane5_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane5_fromStOp_strm_cntl        <= sdp__cntl__lane5_strm_cntl      ;
      lane5_fromStOp_strm_id          <= sdp__cntl__lane5_strm_id        ;
      lane5_fromStOp_strm_data        <= sdp__cntl__lane5_strm_data      ;
      lane5_fromStOp_strm_data_valid  <= sdp__cntl__lane5_strm_data_valid;
    end 
  // lane6 stream to NoC 
  assign     cntl__sdp__lane6_strm_ready  = lane6_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane6_fromStOp_strm_cntl        <= sdp__cntl__lane6_strm_cntl      ;
      lane6_fromStOp_strm_id          <= sdp__cntl__lane6_strm_id        ;
      lane6_fromStOp_strm_data        <= sdp__cntl__lane6_strm_data      ;
      lane6_fromStOp_strm_data_valid  <= sdp__cntl__lane6_strm_data_valid;
    end 
  // lane7 stream to NoC 
  assign     cntl__sdp__lane7_strm_ready  = lane7_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane7_fromStOp_strm_cntl        <= sdp__cntl__lane7_strm_cntl      ;
      lane7_fromStOp_strm_id          <= sdp__cntl__lane7_strm_id        ;
      lane7_fromStOp_strm_data        <= sdp__cntl__lane7_strm_data      ;
      lane7_fromStOp_strm_data_valid  <= sdp__cntl__lane7_strm_data_valid;
    end 
  // lane8 stream to NoC 
  assign     cntl__sdp__lane8_strm_ready  = lane8_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane8_fromStOp_strm_cntl        <= sdp__cntl__lane8_strm_cntl      ;
      lane8_fromStOp_strm_id          <= sdp__cntl__lane8_strm_id        ;
      lane8_fromStOp_strm_data        <= sdp__cntl__lane8_strm_data      ;
      lane8_fromStOp_strm_data_valid  <= sdp__cntl__lane8_strm_data_valid;
    end 
  // lane9 stream to NoC 
  assign     cntl__sdp__lane9_strm_ready  = lane9_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane9_fromStOp_strm_cntl        <= sdp__cntl__lane9_strm_cntl      ;
      lane9_fromStOp_strm_id          <= sdp__cntl__lane9_strm_id        ;
      lane9_fromStOp_strm_data        <= sdp__cntl__lane9_strm_data      ;
      lane9_fromStOp_strm_data_valid  <= sdp__cntl__lane9_strm_data_valid;
    end 
  // lane10 stream to NoC 
  assign     cntl__sdp__lane10_strm_ready  = lane10_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane10_fromStOp_strm_cntl        <= sdp__cntl__lane10_strm_cntl      ;
      lane10_fromStOp_strm_id          <= sdp__cntl__lane10_strm_id        ;
      lane10_fromStOp_strm_data        <= sdp__cntl__lane10_strm_data      ;
      lane10_fromStOp_strm_data_valid  <= sdp__cntl__lane10_strm_data_valid;
    end 
  // lane11 stream to NoC 
  assign     cntl__sdp__lane11_strm_ready  = lane11_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane11_fromStOp_strm_cntl        <= sdp__cntl__lane11_strm_cntl      ;
      lane11_fromStOp_strm_id          <= sdp__cntl__lane11_strm_id        ;
      lane11_fromStOp_strm_data        <= sdp__cntl__lane11_strm_data      ;
      lane11_fromStOp_strm_data_valid  <= sdp__cntl__lane11_strm_data_valid;
    end 
  // lane12 stream to NoC 
  assign     cntl__sdp__lane12_strm_ready  = lane12_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane12_fromStOp_strm_cntl        <= sdp__cntl__lane12_strm_cntl      ;
      lane12_fromStOp_strm_id          <= sdp__cntl__lane12_strm_id        ;
      lane12_fromStOp_strm_data        <= sdp__cntl__lane12_strm_data      ;
      lane12_fromStOp_strm_data_valid  <= sdp__cntl__lane12_strm_data_valid;
    end 
  // lane13 stream to NoC 
  assign     cntl__sdp__lane13_strm_ready  = lane13_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane13_fromStOp_strm_cntl        <= sdp__cntl__lane13_strm_cntl      ;
      lane13_fromStOp_strm_id          <= sdp__cntl__lane13_strm_id        ;
      lane13_fromStOp_strm_data        <= sdp__cntl__lane13_strm_data      ;
      lane13_fromStOp_strm_data_valid  <= sdp__cntl__lane13_strm_data_valid;
    end 
  // lane14 stream to NoC 
  assign     cntl__sdp__lane14_strm_ready  = lane14_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane14_fromStOp_strm_cntl        <= sdp__cntl__lane14_strm_cntl      ;
      lane14_fromStOp_strm_id          <= sdp__cntl__lane14_strm_id        ;
      lane14_fromStOp_strm_data        <= sdp__cntl__lane14_strm_data      ;
      lane14_fromStOp_strm_data_valid  <= sdp__cntl__lane14_strm_data_valid;
    end 
  // lane15 stream to NoC 
  assign     cntl__sdp__lane15_strm_ready  = lane15_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane15_fromStOp_strm_cntl        <= sdp__cntl__lane15_strm_cntl      ;
      lane15_fromStOp_strm_id          <= sdp__cntl__lane15_strm_id        ;
      lane15_fromStOp_strm_data        <= sdp__cntl__lane15_strm_data      ;
      lane15_fromStOp_strm_data_valid  <= sdp__cntl__lane15_strm_data_valid;
    end 
  // lane16 stream to NoC 
  assign     cntl__sdp__lane16_strm_ready  = lane16_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane16_fromStOp_strm_cntl        <= sdp__cntl__lane16_strm_cntl      ;
      lane16_fromStOp_strm_id          <= sdp__cntl__lane16_strm_id        ;
      lane16_fromStOp_strm_data        <= sdp__cntl__lane16_strm_data      ;
      lane16_fromStOp_strm_data_valid  <= sdp__cntl__lane16_strm_data_valid;
    end 
  // lane17 stream to NoC 
  assign     cntl__sdp__lane17_strm_ready  = lane17_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane17_fromStOp_strm_cntl        <= sdp__cntl__lane17_strm_cntl      ;
      lane17_fromStOp_strm_id          <= sdp__cntl__lane17_strm_id        ;
      lane17_fromStOp_strm_data        <= sdp__cntl__lane17_strm_data      ;
      lane17_fromStOp_strm_data_valid  <= sdp__cntl__lane17_strm_data_valid;
    end 
  // lane18 stream to NoC 
  assign     cntl__sdp__lane18_strm_ready  = lane18_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane18_fromStOp_strm_cntl        <= sdp__cntl__lane18_strm_cntl      ;
      lane18_fromStOp_strm_id          <= sdp__cntl__lane18_strm_id        ;
      lane18_fromStOp_strm_data        <= sdp__cntl__lane18_strm_data      ;
      lane18_fromStOp_strm_data_valid  <= sdp__cntl__lane18_strm_data_valid;
    end 
  // lane19 stream to NoC 
  assign     cntl__sdp__lane19_strm_ready  = lane19_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane19_fromStOp_strm_cntl        <= sdp__cntl__lane19_strm_cntl      ;
      lane19_fromStOp_strm_id          <= sdp__cntl__lane19_strm_id        ;
      lane19_fromStOp_strm_data        <= sdp__cntl__lane19_strm_data      ;
      lane19_fromStOp_strm_data_valid  <= sdp__cntl__lane19_strm_data_valid;
    end 
  // lane20 stream to NoC 
  assign     cntl__sdp__lane20_strm_ready  = lane20_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane20_fromStOp_strm_cntl        <= sdp__cntl__lane20_strm_cntl      ;
      lane20_fromStOp_strm_id          <= sdp__cntl__lane20_strm_id        ;
      lane20_fromStOp_strm_data        <= sdp__cntl__lane20_strm_data      ;
      lane20_fromStOp_strm_data_valid  <= sdp__cntl__lane20_strm_data_valid;
    end 
  // lane21 stream to NoC 
  assign     cntl__sdp__lane21_strm_ready  = lane21_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane21_fromStOp_strm_cntl        <= sdp__cntl__lane21_strm_cntl      ;
      lane21_fromStOp_strm_id          <= sdp__cntl__lane21_strm_id        ;
      lane21_fromStOp_strm_data        <= sdp__cntl__lane21_strm_data      ;
      lane21_fromStOp_strm_data_valid  <= sdp__cntl__lane21_strm_data_valid;
    end 
  // lane22 stream to NoC 
  assign     cntl__sdp__lane22_strm_ready  = lane22_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane22_fromStOp_strm_cntl        <= sdp__cntl__lane22_strm_cntl      ;
      lane22_fromStOp_strm_id          <= sdp__cntl__lane22_strm_id        ;
      lane22_fromStOp_strm_data        <= sdp__cntl__lane22_strm_data      ;
      lane22_fromStOp_strm_data_valid  <= sdp__cntl__lane22_strm_data_valid;
    end 
  // lane23 stream to NoC 
  assign     cntl__sdp__lane23_strm_ready  = lane23_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane23_fromStOp_strm_cntl        <= sdp__cntl__lane23_strm_cntl      ;
      lane23_fromStOp_strm_id          <= sdp__cntl__lane23_strm_id        ;
      lane23_fromStOp_strm_data        <= sdp__cntl__lane23_strm_data      ;
      lane23_fromStOp_strm_data_valid  <= sdp__cntl__lane23_strm_data_valid;
    end 
  // lane24 stream to NoC 
  assign     cntl__sdp__lane24_strm_ready  = lane24_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane24_fromStOp_strm_cntl        <= sdp__cntl__lane24_strm_cntl      ;
      lane24_fromStOp_strm_id          <= sdp__cntl__lane24_strm_id        ;
      lane24_fromStOp_strm_data        <= sdp__cntl__lane24_strm_data      ;
      lane24_fromStOp_strm_data_valid  <= sdp__cntl__lane24_strm_data_valid;
    end 
  // lane25 stream to NoC 
  assign     cntl__sdp__lane25_strm_ready  = lane25_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane25_fromStOp_strm_cntl        <= sdp__cntl__lane25_strm_cntl      ;
      lane25_fromStOp_strm_id          <= sdp__cntl__lane25_strm_id        ;
      lane25_fromStOp_strm_data        <= sdp__cntl__lane25_strm_data      ;
      lane25_fromStOp_strm_data_valid  <= sdp__cntl__lane25_strm_data_valid;
    end 
  // lane26 stream to NoC 
  assign     cntl__sdp__lane26_strm_ready  = lane26_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane26_fromStOp_strm_cntl        <= sdp__cntl__lane26_strm_cntl      ;
      lane26_fromStOp_strm_id          <= sdp__cntl__lane26_strm_id        ;
      lane26_fromStOp_strm_data        <= sdp__cntl__lane26_strm_data      ;
      lane26_fromStOp_strm_data_valid  <= sdp__cntl__lane26_strm_data_valid;
    end 
  // lane27 stream to NoC 
  assign     cntl__sdp__lane27_strm_ready  = lane27_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane27_fromStOp_strm_cntl        <= sdp__cntl__lane27_strm_cntl      ;
      lane27_fromStOp_strm_id          <= sdp__cntl__lane27_strm_id        ;
      lane27_fromStOp_strm_data        <= sdp__cntl__lane27_strm_data      ;
      lane27_fromStOp_strm_data_valid  <= sdp__cntl__lane27_strm_data_valid;
    end 
  // lane28 stream to NoC 
  assign     cntl__sdp__lane28_strm_ready  = lane28_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane28_fromStOp_strm_cntl        <= sdp__cntl__lane28_strm_cntl      ;
      lane28_fromStOp_strm_id          <= sdp__cntl__lane28_strm_id        ;
      lane28_fromStOp_strm_data        <= sdp__cntl__lane28_strm_data      ;
      lane28_fromStOp_strm_data_valid  <= sdp__cntl__lane28_strm_data_valid;
    end 
  // lane29 stream to NoC 
  assign     cntl__sdp__lane29_strm_ready  = lane29_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane29_fromStOp_strm_cntl        <= sdp__cntl__lane29_strm_cntl      ;
      lane29_fromStOp_strm_id          <= sdp__cntl__lane29_strm_id        ;
      lane29_fromStOp_strm_data        <= sdp__cntl__lane29_strm_data      ;
      lane29_fromStOp_strm_data_valid  <= sdp__cntl__lane29_strm_data_valid;
    end 
  // lane30 stream to NoC 
  assign     cntl__sdp__lane30_strm_ready  = lane30_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane30_fromStOp_strm_cntl        <= sdp__cntl__lane30_strm_cntl      ;
      lane30_fromStOp_strm_id          <= sdp__cntl__lane30_strm_id        ;
      lane30_fromStOp_strm_data        <= sdp__cntl__lane30_strm_data      ;
      lane30_fromStOp_strm_data_valid  <= sdp__cntl__lane30_strm_data_valid;
    end 
  // lane31 stream to NoC 
  assign     cntl__sdp__lane31_strm_ready  = lane31_fromStOp_strm_ready                ; 
  always @(posedge clk) 
    begin 
      lane31_fromStOp_strm_cntl        <= sdp__cntl__lane31_strm_cntl      ;
      lane31_fromStOp_strm_id          <= sdp__cntl__lane31_strm_id        ;
      lane31_fromStOp_strm_data        <= sdp__cntl__lane31_strm_data      ;
      lane31_fromStOp_strm_data_valid  <= sdp__cntl__lane31_strm_data_valid;
    end 

  // Take data from the first lane that has a packet available
  // FIXME: need to make this fair
  always @(posedge clk)
    begin
      if (~FromStOpControlRequestWait)
        begin
          casez(toNocDmaPacketAvailableVector)
            32'b1???????????????????????????????:
            begin
              toNocSelectedLane  <= 'd31;
            end
            32'b01??????????????????????????????:
            begin
              toNocSelectedLane  <= 'd30;
            end
            32'b001?????????????????????????????:
            begin
              toNocSelectedLane  <= 'd29;
            end
            32'b0001????????????????????????????:
            begin
              toNocSelectedLane  <= 'd28;
            end
            32'b00001???????????????????????????:
            begin
              toNocSelectedLane  <= 'd27;
            end
            32'b000001??????????????????????????:
            begin
              toNocSelectedLane  <= 'd26;
            end
            32'b0000001?????????????????????????:
            begin
              toNocSelectedLane  <= 'd25;
            end
            32'b00000001????????????????????????:
            begin
              toNocSelectedLane  <= 'd24;
            end
            32'b000000001???????????????????????:
            begin
              toNocSelectedLane  <= 'd23;
            end
            32'b0000000001??????????????????????:
            begin
              toNocSelectedLane  <= 'd22;
            end
            32'b00000000001?????????????????????:
            begin
              toNocSelectedLane  <= 'd21;
            end
            32'b000000000001????????????????????:
            begin
              toNocSelectedLane  <= 'd20;
            end
            32'b0000000000001???????????????????:
            begin
              toNocSelectedLane  <= 'd19;
            end
            32'b00000000000001??????????????????:
            begin
              toNocSelectedLane  <= 'd18;
            end
            32'b000000000000001?????????????????:
            begin
              toNocSelectedLane  <= 'd17;
            end
            32'b0000000000000001????????????????:
            begin
              toNocSelectedLane  <= 'd16;
            end
            32'b00000000000000001???????????????:
            begin
              toNocSelectedLane  <= 'd15;
            end
            32'b000000000000000001??????????????:
            begin
              toNocSelectedLane  <= 'd14;
            end
            32'b0000000000000000001?????????????:
            begin
              toNocSelectedLane  <= 'd13;
            end
            32'b00000000000000000001????????????:
            begin
              toNocSelectedLane  <= 'd12;
            end
            32'b000000000000000000001???????????:
            begin
              toNocSelectedLane  <= 'd11;
            end
            32'b0000000000000000000001??????????:
            begin
              toNocSelectedLane  <= 'd10;
            end
            32'b00000000000000000000001?????????:
            begin
              toNocSelectedLane  <= 'd9;
            end
            32'b000000000000000000000001????????:
            begin
              toNocSelectedLane  <= 'd8;
            end
            32'b0000000000000000000000001???????:
            begin
              toNocSelectedLane  <= 'd7;
            end
            32'b00000000000000000000000001??????:
            begin
              toNocSelectedLane  <= 'd6;
            end
            32'b000000000000000000000000001?????:
            begin
              toNocSelectedLane  <= 'd5;
            end
            32'b0000000000000000000000000001????:
            begin
              toNocSelectedLane  <= 'd4;
            end
            32'b00000000000000000000000000001???:
            begin
              toNocSelectedLane  <= 'd3;
            end
            32'b000000000000000000000000000001??:
            begin
              toNocSelectedLane  <= 'd2;
            end
            32'b0000000000000000000000000000001?:
            begin
              toNocSelectedLane  <= 'd1;
            end
            32'b00000000000000000000000000000001:
            begin
              toNocSelectedLane  <= 'd0;
            end
            default:
            begin
              toNocSelectedLane  <= 'd0;
            end
          endcase
        end
      end

  always @(*)
    begin
      toNocDmaPacketAvailable   = 'b0;
      case(toNocSelectedLane)
        'd0:
        begin
          toNocDmaPacketAvailable = lane0_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd1:
        begin
          toNocDmaPacketAvailable = lane1_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd2:
        begin
          toNocDmaPacketAvailable = lane2_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd3:
        begin
          toNocDmaPacketAvailable = lane3_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd4:
        begin
          toNocDmaPacketAvailable = lane4_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd5:
        begin
          toNocDmaPacketAvailable = lane5_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd6:
        begin
          toNocDmaPacketAvailable = lane6_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd7:
        begin
          toNocDmaPacketAvailable = lane7_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd8:
        begin
          toNocDmaPacketAvailable = lane8_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd9:
        begin
          toNocDmaPacketAvailable = lane9_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd10:
        begin
          toNocDmaPacketAvailable = lane10_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd11:
        begin
          toNocDmaPacketAvailable = lane11_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd12:
        begin
          toNocDmaPacketAvailable = lane12_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd13:
        begin
          toNocDmaPacketAvailable = lane13_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd14:
        begin
          toNocDmaPacketAvailable = lane14_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd15:
        begin
          toNocDmaPacketAvailable = lane15_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd16:
        begin
          toNocDmaPacketAvailable = lane16_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd17:
        begin
          toNocDmaPacketAvailable = lane17_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd18:
        begin
          toNocDmaPacketAvailable = lane18_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd19:
        begin
          toNocDmaPacketAvailable = lane19_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd20:
        begin
          toNocDmaPacketAvailable = lane20_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd21:
        begin
          toNocDmaPacketAvailable = lane21_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd22:
        begin
          toNocDmaPacketAvailable = lane22_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd23:
        begin
          toNocDmaPacketAvailable = lane23_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd24:
        begin
          toNocDmaPacketAvailable = lane24_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd25:
        begin
          toNocDmaPacketAvailable = lane25_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd26:
        begin
          toNocDmaPacketAvailable = lane26_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd27:
        begin
          toNocDmaPacketAvailable = lane27_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd28:
        begin
          toNocDmaPacketAvailable = lane28_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd29:
        begin
          toNocDmaPacketAvailable = lane29_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd30:
        begin
          toNocDmaPacketAvailable = lane30_fromStOp_strm_fifo_dma_pkt_available;
        end
        'd31:
        begin
          toNocDmaPacketAvailable = lane31_fromStOp_strm_fifo_dma_pkt_available;
        end
      endcase
    end

  always @(posedge clk)
    begin
      case(toNocSelectedLane)
        'd0:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd1:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd2:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd3:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd4:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd5:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd6:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd7:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd8:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd9:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd10:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd11:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd12:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd13:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd14:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd15:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd16:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd17:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd18:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd19:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd20:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd21:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd22:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd23:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd24:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd25:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd26:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd27:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd28:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd29:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd30:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
        'd31:
        begin
          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; 
          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; 
          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; 
          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; 
          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; 
          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; 
        end
      endcase
    end

  always @(*)
    begin
      lane0_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane1_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane2_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane3_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane4_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane5_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane6_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane7_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane8_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane9_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane10_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane11_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane12_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane13_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane14_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane15_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane16_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane17_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane18_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane19_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane20_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane21_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane22_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane23_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane24_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane25_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane26_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane27_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane28_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane29_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane30_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      lane31_fromStOp_strm_fifo_read = 1'b0      ; 
      toNoc_dp_fifo_cntl              = 1'b0      ; 
      toNoc_dp_fifo_data_valid        = 1'b0      ; 
      toNoc_dp_fifo_depth              = 'd0      ; 
      toNoc_dp_fifo_eop_count          = 'd0      ; 
      toNoc_dp_fifo_dma_pkt_available = 1'b0      ; 
      case(toNocSelectedLane)
        'd0:
        begin
          toNoc_dp_fifo_cntl              = lane0_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane0_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane0_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane0_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane0_fromStOp_strm_fifo_dma_pkt_available ; 
          lane0_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd1:
        begin
          toNoc_dp_fifo_cntl              = lane1_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane1_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane1_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane1_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane1_fromStOp_strm_fifo_dma_pkt_available ; 
          lane1_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd2:
        begin
          toNoc_dp_fifo_cntl              = lane2_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane2_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane2_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane2_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane2_fromStOp_strm_fifo_dma_pkt_available ; 
          lane2_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd3:
        begin
          toNoc_dp_fifo_cntl              = lane3_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane3_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane3_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane3_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane3_fromStOp_strm_fifo_dma_pkt_available ; 
          lane3_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd4:
        begin
          toNoc_dp_fifo_cntl              = lane4_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane4_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane4_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane4_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane4_fromStOp_strm_fifo_dma_pkt_available ; 
          lane4_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd5:
        begin
          toNoc_dp_fifo_cntl              = lane5_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane5_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane5_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane5_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane5_fromStOp_strm_fifo_dma_pkt_available ; 
          lane5_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd6:
        begin
          toNoc_dp_fifo_cntl              = lane6_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane6_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane6_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane6_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane6_fromStOp_strm_fifo_dma_pkt_available ; 
          lane6_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd7:
        begin
          toNoc_dp_fifo_cntl              = lane7_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane7_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane7_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane7_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane7_fromStOp_strm_fifo_dma_pkt_available ; 
          lane7_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd8:
        begin
          toNoc_dp_fifo_cntl              = lane8_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane8_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane8_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane8_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane8_fromStOp_strm_fifo_dma_pkt_available ; 
          lane8_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd9:
        begin
          toNoc_dp_fifo_cntl              = lane9_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane9_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane9_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane9_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane9_fromStOp_strm_fifo_dma_pkt_available ; 
          lane9_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd10:
        begin
          toNoc_dp_fifo_cntl              = lane10_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane10_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane10_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane10_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane10_fromStOp_strm_fifo_dma_pkt_available ; 
          lane10_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd11:
        begin
          toNoc_dp_fifo_cntl              = lane11_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane11_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane11_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane11_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane11_fromStOp_strm_fifo_dma_pkt_available ; 
          lane11_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd12:
        begin
          toNoc_dp_fifo_cntl              = lane12_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane12_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane12_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane12_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane12_fromStOp_strm_fifo_dma_pkt_available ; 
          lane12_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd13:
        begin
          toNoc_dp_fifo_cntl              = lane13_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane13_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane13_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane13_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane13_fromStOp_strm_fifo_dma_pkt_available ; 
          lane13_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd14:
        begin
          toNoc_dp_fifo_cntl              = lane14_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane14_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane14_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane14_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane14_fromStOp_strm_fifo_dma_pkt_available ; 
          lane14_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd15:
        begin
          toNoc_dp_fifo_cntl              = lane15_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane15_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane15_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane15_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane15_fromStOp_strm_fifo_dma_pkt_available ; 
          lane15_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd16:
        begin
          toNoc_dp_fifo_cntl              = lane16_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane16_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane16_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane16_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane16_fromStOp_strm_fifo_dma_pkt_available ; 
          lane16_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd17:
        begin
          toNoc_dp_fifo_cntl              = lane17_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane17_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane17_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane17_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane17_fromStOp_strm_fifo_dma_pkt_available ; 
          lane17_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd18:
        begin
          toNoc_dp_fifo_cntl              = lane18_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane18_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane18_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane18_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane18_fromStOp_strm_fifo_dma_pkt_available ; 
          lane18_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd19:
        begin
          toNoc_dp_fifo_cntl              = lane19_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane19_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane19_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane19_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane19_fromStOp_strm_fifo_dma_pkt_available ; 
          lane19_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd20:
        begin
          toNoc_dp_fifo_cntl              = lane20_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane20_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane20_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane20_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane20_fromStOp_strm_fifo_dma_pkt_available ; 
          lane20_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd21:
        begin
          toNoc_dp_fifo_cntl              = lane21_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane21_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane21_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane21_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane21_fromStOp_strm_fifo_dma_pkt_available ; 
          lane21_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd22:
        begin
          toNoc_dp_fifo_cntl              = lane22_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane22_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane22_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane22_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane22_fromStOp_strm_fifo_dma_pkt_available ; 
          lane22_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd23:
        begin
          toNoc_dp_fifo_cntl              = lane23_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane23_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane23_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane23_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane23_fromStOp_strm_fifo_dma_pkt_available ; 
          lane23_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd24:
        begin
          toNoc_dp_fifo_cntl              = lane24_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane24_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane24_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane24_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane24_fromStOp_strm_fifo_dma_pkt_available ; 
          lane24_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd25:
        begin
          toNoc_dp_fifo_cntl              = lane25_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane25_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane25_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane25_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane25_fromStOp_strm_fifo_dma_pkt_available ; 
          lane25_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd26:
        begin
          toNoc_dp_fifo_cntl              = lane26_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane26_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane26_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane26_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane26_fromStOp_strm_fifo_dma_pkt_available ; 
          lane26_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd27:
        begin
          toNoc_dp_fifo_cntl              = lane27_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane27_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane27_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane27_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane27_fromStOp_strm_fifo_dma_pkt_available ; 
          lane27_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd28:
        begin
          toNoc_dp_fifo_cntl              = lane28_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane28_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane28_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane28_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane28_fromStOp_strm_fifo_dma_pkt_available ; 
          lane28_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd29:
        begin
          toNoc_dp_fifo_cntl              = lane29_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane29_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane29_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane29_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane29_fromStOp_strm_fifo_dma_pkt_available ; 
          lane29_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd30:
        begin
          toNoc_dp_fifo_cntl              = lane30_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane30_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane30_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane30_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane30_fromStOp_strm_fifo_dma_pkt_available ; 
          lane30_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
        'd31:
        begin
          toNoc_dp_fifo_cntl              = lane31_fromStOp_strm_fifo_read_cntl         ; 
          toNoc_dp_fifo_data_valid        = lane31_fromStOp_strm_fifo_read_data_valid   ; 
          toNoc_dp_fifo_depth             = lane31_fromStOp_strm_fifo_depth             ; 
          toNoc_dp_fifo_eop_count         = lane31_fromStOp_strm_fifo_eop_count         ; 
          toNoc_dp_fifo_dma_pkt_available = lane31_fromStOp_strm_fifo_dma_pkt_available ; 
          lane31_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; 
        end
      endcase
    end

  always @(*)
    begin
      case(toNocSelectedLane)
        'd0:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane0_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane0_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane0_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane0_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane0_fromStOp_strm_id) ? strm_control[0].strm1_ExternalDmaPeId   : strm_control[0].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane0_fromStOp_strm_id) ? strm_control[0].strm1_ExternalDmaLaneId : strm_control[0].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane0_fromStOp_strm_id) ? strm_control[0].strm1_ExternalDmaStrmId : strm_control[0].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane0_fromStOp_strm_fifo_read_data ; 
        end
        'd1:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane1_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane1_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane1_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane1_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane1_fromStOp_strm_id) ? strm_control[1].strm1_ExternalDmaPeId   : strm_control[1].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane1_fromStOp_strm_id) ? strm_control[1].strm1_ExternalDmaLaneId : strm_control[1].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane1_fromStOp_strm_id) ? strm_control[1].strm1_ExternalDmaStrmId : strm_control[1].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane1_fromStOp_strm_fifo_read_data ; 
        end
        'd2:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane2_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane2_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane2_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane2_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane2_fromStOp_strm_id) ? strm_control[2].strm1_ExternalDmaPeId   : strm_control[2].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane2_fromStOp_strm_id) ? strm_control[2].strm1_ExternalDmaLaneId : strm_control[2].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane2_fromStOp_strm_id) ? strm_control[2].strm1_ExternalDmaStrmId : strm_control[2].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane2_fromStOp_strm_fifo_read_data ; 
        end
        'd3:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane3_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane3_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane3_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane3_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane3_fromStOp_strm_id) ? strm_control[3].strm1_ExternalDmaPeId   : strm_control[3].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane3_fromStOp_strm_id) ? strm_control[3].strm1_ExternalDmaLaneId : strm_control[3].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane3_fromStOp_strm_id) ? strm_control[3].strm1_ExternalDmaStrmId : strm_control[3].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane3_fromStOp_strm_fifo_read_data ; 
        end
        'd4:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane4_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane4_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane4_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane4_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane4_fromStOp_strm_id) ? strm_control[4].strm1_ExternalDmaPeId   : strm_control[4].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane4_fromStOp_strm_id) ? strm_control[4].strm1_ExternalDmaLaneId : strm_control[4].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane4_fromStOp_strm_id) ? strm_control[4].strm1_ExternalDmaStrmId : strm_control[4].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane4_fromStOp_strm_fifo_read_data ; 
        end
        'd5:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane5_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane5_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane5_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane5_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane5_fromStOp_strm_id) ? strm_control[5].strm1_ExternalDmaPeId   : strm_control[5].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane5_fromStOp_strm_id) ? strm_control[5].strm1_ExternalDmaLaneId : strm_control[5].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane5_fromStOp_strm_id) ? strm_control[5].strm1_ExternalDmaStrmId : strm_control[5].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane5_fromStOp_strm_fifo_read_data ; 
        end
        'd6:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane6_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane6_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane6_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane6_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane6_fromStOp_strm_id) ? strm_control[6].strm1_ExternalDmaPeId   : strm_control[6].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane6_fromStOp_strm_id) ? strm_control[6].strm1_ExternalDmaLaneId : strm_control[6].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane6_fromStOp_strm_id) ? strm_control[6].strm1_ExternalDmaStrmId : strm_control[6].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane6_fromStOp_strm_fifo_read_data ; 
        end
        'd7:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane7_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane7_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane7_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane7_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane7_fromStOp_strm_id) ? strm_control[7].strm1_ExternalDmaPeId   : strm_control[7].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane7_fromStOp_strm_id) ? strm_control[7].strm1_ExternalDmaLaneId : strm_control[7].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane7_fromStOp_strm_id) ? strm_control[7].strm1_ExternalDmaStrmId : strm_control[7].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane7_fromStOp_strm_fifo_read_data ; 
        end
        'd8:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane8_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane8_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane8_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane8_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane8_fromStOp_strm_id) ? strm_control[8].strm1_ExternalDmaPeId   : strm_control[8].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane8_fromStOp_strm_id) ? strm_control[8].strm1_ExternalDmaLaneId : strm_control[8].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane8_fromStOp_strm_id) ? strm_control[8].strm1_ExternalDmaStrmId : strm_control[8].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane8_fromStOp_strm_fifo_read_data ; 
        end
        'd9:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane9_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane9_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane9_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane9_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane9_fromStOp_strm_id) ? strm_control[9].strm1_ExternalDmaPeId   : strm_control[9].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane9_fromStOp_strm_id) ? strm_control[9].strm1_ExternalDmaLaneId : strm_control[9].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane9_fromStOp_strm_id) ? strm_control[9].strm1_ExternalDmaStrmId : strm_control[9].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane9_fromStOp_strm_fifo_read_data ; 
        end
        'd10:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane10_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane10_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane10_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane10_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane10_fromStOp_strm_id) ? strm_control[10].strm1_ExternalDmaPeId   : strm_control[10].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane10_fromStOp_strm_id) ? strm_control[10].strm1_ExternalDmaLaneId : strm_control[10].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane10_fromStOp_strm_id) ? strm_control[10].strm1_ExternalDmaStrmId : strm_control[10].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane10_fromStOp_strm_fifo_read_data ; 
        end
        'd11:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane11_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane11_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane11_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane11_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane11_fromStOp_strm_id) ? strm_control[11].strm1_ExternalDmaPeId   : strm_control[11].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane11_fromStOp_strm_id) ? strm_control[11].strm1_ExternalDmaLaneId : strm_control[11].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane11_fromStOp_strm_id) ? strm_control[11].strm1_ExternalDmaStrmId : strm_control[11].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane11_fromStOp_strm_fifo_read_data ; 
        end
        'd12:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane12_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane12_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane12_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane12_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane12_fromStOp_strm_id) ? strm_control[12].strm1_ExternalDmaPeId   : strm_control[12].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane12_fromStOp_strm_id) ? strm_control[12].strm1_ExternalDmaLaneId : strm_control[12].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane12_fromStOp_strm_id) ? strm_control[12].strm1_ExternalDmaStrmId : strm_control[12].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane12_fromStOp_strm_fifo_read_data ; 
        end
        'd13:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane13_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane13_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane13_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane13_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane13_fromStOp_strm_id) ? strm_control[13].strm1_ExternalDmaPeId   : strm_control[13].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane13_fromStOp_strm_id) ? strm_control[13].strm1_ExternalDmaLaneId : strm_control[13].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane13_fromStOp_strm_id) ? strm_control[13].strm1_ExternalDmaStrmId : strm_control[13].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane13_fromStOp_strm_fifo_read_data ; 
        end
        'd14:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane14_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane14_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane14_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane14_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane14_fromStOp_strm_id) ? strm_control[14].strm1_ExternalDmaPeId   : strm_control[14].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane14_fromStOp_strm_id) ? strm_control[14].strm1_ExternalDmaLaneId : strm_control[14].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane14_fromStOp_strm_id) ? strm_control[14].strm1_ExternalDmaStrmId : strm_control[14].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane14_fromStOp_strm_fifo_read_data ; 
        end
        'd15:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane15_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane15_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane15_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane15_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane15_fromStOp_strm_id) ? strm_control[15].strm1_ExternalDmaPeId   : strm_control[15].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane15_fromStOp_strm_id) ? strm_control[15].strm1_ExternalDmaLaneId : strm_control[15].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane15_fromStOp_strm_id) ? strm_control[15].strm1_ExternalDmaStrmId : strm_control[15].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane15_fromStOp_strm_fifo_read_data ; 
        end
        'd16:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane16_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane16_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane16_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane16_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane16_fromStOp_strm_id) ? strm_control[16].strm1_ExternalDmaPeId   : strm_control[16].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane16_fromStOp_strm_id) ? strm_control[16].strm1_ExternalDmaLaneId : strm_control[16].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane16_fromStOp_strm_id) ? strm_control[16].strm1_ExternalDmaStrmId : strm_control[16].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane16_fromStOp_strm_fifo_read_data ; 
        end
        'd17:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane17_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane17_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane17_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane17_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane17_fromStOp_strm_id) ? strm_control[17].strm1_ExternalDmaPeId   : strm_control[17].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane17_fromStOp_strm_id) ? strm_control[17].strm1_ExternalDmaLaneId : strm_control[17].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane17_fromStOp_strm_id) ? strm_control[17].strm1_ExternalDmaStrmId : strm_control[17].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane17_fromStOp_strm_fifo_read_data ; 
        end
        'd18:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane18_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane18_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane18_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane18_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane18_fromStOp_strm_id) ? strm_control[18].strm1_ExternalDmaPeId   : strm_control[18].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane18_fromStOp_strm_id) ? strm_control[18].strm1_ExternalDmaLaneId : strm_control[18].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane18_fromStOp_strm_id) ? strm_control[18].strm1_ExternalDmaStrmId : strm_control[18].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane18_fromStOp_strm_fifo_read_data ; 
        end
        'd19:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane19_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane19_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane19_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane19_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane19_fromStOp_strm_id) ? strm_control[19].strm1_ExternalDmaPeId   : strm_control[19].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane19_fromStOp_strm_id) ? strm_control[19].strm1_ExternalDmaLaneId : strm_control[19].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane19_fromStOp_strm_id) ? strm_control[19].strm1_ExternalDmaStrmId : strm_control[19].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane19_fromStOp_strm_fifo_read_data ; 
        end
        'd20:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane20_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane20_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane20_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane20_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane20_fromStOp_strm_id) ? strm_control[20].strm1_ExternalDmaPeId   : strm_control[20].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane20_fromStOp_strm_id) ? strm_control[20].strm1_ExternalDmaLaneId : strm_control[20].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane20_fromStOp_strm_id) ? strm_control[20].strm1_ExternalDmaStrmId : strm_control[20].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane20_fromStOp_strm_fifo_read_data ; 
        end
        'd21:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane21_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane21_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane21_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane21_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane21_fromStOp_strm_id) ? strm_control[21].strm1_ExternalDmaPeId   : strm_control[21].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane21_fromStOp_strm_id) ? strm_control[21].strm1_ExternalDmaLaneId : strm_control[21].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane21_fromStOp_strm_id) ? strm_control[21].strm1_ExternalDmaStrmId : strm_control[21].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane21_fromStOp_strm_fifo_read_data ; 
        end
        'd22:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane22_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane22_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane22_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane22_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane22_fromStOp_strm_id) ? strm_control[22].strm1_ExternalDmaPeId   : strm_control[22].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane22_fromStOp_strm_id) ? strm_control[22].strm1_ExternalDmaLaneId : strm_control[22].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane22_fromStOp_strm_id) ? strm_control[22].strm1_ExternalDmaStrmId : strm_control[22].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane22_fromStOp_strm_fifo_read_data ; 
        end
        'd23:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane23_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane23_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane23_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane23_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane23_fromStOp_strm_id) ? strm_control[23].strm1_ExternalDmaPeId   : strm_control[23].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane23_fromStOp_strm_id) ? strm_control[23].strm1_ExternalDmaLaneId : strm_control[23].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane23_fromStOp_strm_id) ? strm_control[23].strm1_ExternalDmaStrmId : strm_control[23].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane23_fromStOp_strm_fifo_read_data ; 
        end
        'd24:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane24_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane24_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane24_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane24_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane24_fromStOp_strm_id) ? strm_control[24].strm1_ExternalDmaPeId   : strm_control[24].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane24_fromStOp_strm_id) ? strm_control[24].strm1_ExternalDmaLaneId : strm_control[24].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane24_fromStOp_strm_id) ? strm_control[24].strm1_ExternalDmaStrmId : strm_control[24].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane24_fromStOp_strm_fifo_read_data ; 
        end
        'd25:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane25_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane25_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane25_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane25_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane25_fromStOp_strm_id) ? strm_control[25].strm1_ExternalDmaPeId   : strm_control[25].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane25_fromStOp_strm_id) ? strm_control[25].strm1_ExternalDmaLaneId : strm_control[25].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane25_fromStOp_strm_id) ? strm_control[25].strm1_ExternalDmaStrmId : strm_control[25].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane25_fromStOp_strm_fifo_read_data ; 
        end
        'd26:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane26_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane26_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane26_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane26_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane26_fromStOp_strm_id) ? strm_control[26].strm1_ExternalDmaPeId   : strm_control[26].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane26_fromStOp_strm_id) ? strm_control[26].strm1_ExternalDmaLaneId : strm_control[26].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane26_fromStOp_strm_id) ? strm_control[26].strm1_ExternalDmaStrmId : strm_control[26].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane26_fromStOp_strm_fifo_read_data ; 
        end
        'd27:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane27_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane27_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane27_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane27_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane27_fromStOp_strm_id) ? strm_control[27].strm1_ExternalDmaPeId   : strm_control[27].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane27_fromStOp_strm_id) ? strm_control[27].strm1_ExternalDmaLaneId : strm_control[27].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane27_fromStOp_strm_id) ? strm_control[27].strm1_ExternalDmaStrmId : strm_control[27].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane27_fromStOp_strm_fifo_read_data ; 
        end
        'd28:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane28_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane28_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane28_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane28_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane28_fromStOp_strm_id) ? strm_control[28].strm1_ExternalDmaPeId   : strm_control[28].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane28_fromStOp_strm_id) ? strm_control[28].strm1_ExternalDmaLaneId : strm_control[28].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane28_fromStOp_strm_id) ? strm_control[28].strm1_ExternalDmaStrmId : strm_control[28].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane28_fromStOp_strm_fifo_read_data ; 
        end
        'd29:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane29_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane29_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane29_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane29_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane29_fromStOp_strm_id) ? strm_control[29].strm1_ExternalDmaPeId   : strm_control[29].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane29_fromStOp_strm_id) ? strm_control[29].strm1_ExternalDmaLaneId : strm_control[29].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane29_fromStOp_strm_id) ? strm_control[29].strm1_ExternalDmaStrmId : strm_control[29].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane29_fromStOp_strm_fifo_read_data ; 
        end
        'd30:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane30_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane30_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane30_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane30_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane30_fromStOp_strm_id) ? strm_control[30].strm1_ExternalDmaPeId   : strm_control[30].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane30_fromStOp_strm_id) ? strm_control[30].strm1_ExternalDmaLaneId : strm_control[30].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane30_fromStOp_strm_id) ? strm_control[30].strm1_ExternalDmaStrmId : strm_control[30].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane30_fromStOp_strm_fifo_read_data ; 
        end
        'd31:
        begin
          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane31_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM_EOM) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane31_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_SOM    ) : // delineate using SOP/EOP for NoC
                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane31_fromStOp_strm_fifo_read_cntl | `COMMON_STD_INTF_CNTL_EOM    ) : 
                                                                                                                lane31_fromStOp_strm_fifo_read_cntl                                        ; 
          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; 
          // We need to use the info from the requesting PE that was captured in the stream controller
          scntl__noc__dp_peId_p1   = (lane31_fromStOp_strm_id) ? strm_control[31].strm1_ExternalDmaPeId   : strm_control[31].strm0_ExternalDmaPeId   ; // requesting PE          
          scntl__noc__dp_laneId_p1 = (lane31_fromStOp_strm_id) ? strm_control[31].strm1_ExternalDmaLaneId : strm_control[31].strm0_ExternalDmaLaneId ; // lane in requesting PE  
          scntl__noc__dp_strmId_p1 = (lane31_fromStOp_strm_id) ? strm_control[31].strm1_ExternalDmaStrmId : strm_control[31].strm0_ExternalDmaStrmId ; // stream in requesting PE
          scntl__noc__dp_data_p1   = lane31_fromStOp_strm_fifo_read_data ; 
        end
      endcase
    end
