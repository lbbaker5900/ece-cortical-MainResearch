
  // Terminate PE0's 2 unused Ports
  assign pe_inst[0].noc__pe__port2_valid = 'd0 ;
  assign pe_inst[0].noc__pe__port2_cntl  = 'd0 ;
  assign pe_inst[0].noc__pe__port2_data  = 'd0 ;
  assign pe_inst[0].noc__pe__port2_fc    = 'd0 ;
  assign pe_inst[0].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[0].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[0].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[0].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE0 Port0 to PE1 Port2
  assign pe_inst[1].noc__pe__port2_valid = pe_inst[0].pe__noc__port0_valid ;
  assign pe_inst[1].noc__pe__port2_cntl  = pe_inst[0].pe__noc__port0_cntl  ;
  assign pe_inst[1].noc__pe__port2_data  = pe_inst[0].pe__noc__port0_data  ;
  assign pe_inst[0].noc__pe__port0_fc    = pe_inst[1].pe__noc__port2_fc    ;

  // Connecting PE0 Port1 to PE8 Port0
  assign pe_inst[8].noc__pe__port0_valid = pe_inst[0].pe__noc__port1_valid ;
  assign pe_inst[8].noc__pe__port0_cntl  = pe_inst[0].pe__noc__port1_cntl  ;
  assign pe_inst[8].noc__pe__port0_data  = pe_inst[0].pe__noc__port1_data  ;
  assign pe_inst[0].noc__pe__port1_fc    = pe_inst[8].pe__noc__port0_fc    ;

  // Terminate PE1's 1 unused Ports
  assign pe_inst[1].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[1].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[1].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[1].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE1 Port0 to PE2 Port2
  assign pe_inst[2].noc__pe__port2_valid = pe_inst[1].pe__noc__port0_valid ;
  assign pe_inst[2].noc__pe__port2_cntl  = pe_inst[1].pe__noc__port0_cntl  ;
  assign pe_inst[2].noc__pe__port2_data  = pe_inst[1].pe__noc__port0_data  ;
  assign pe_inst[1].noc__pe__port0_fc    = pe_inst[2].pe__noc__port2_fc    ;

  // Connecting PE1 Port1 to PE9 Port0
  assign pe_inst[9].noc__pe__port0_valid = pe_inst[1].pe__noc__port1_valid ;
  assign pe_inst[9].noc__pe__port0_cntl  = pe_inst[1].pe__noc__port1_cntl  ;
  assign pe_inst[9].noc__pe__port0_data  = pe_inst[1].pe__noc__port1_data  ;
  assign pe_inst[1].noc__pe__port1_fc    = pe_inst[9].pe__noc__port0_fc    ;

  // Connecting PE1 Port2 to PE0 Port0
  assign pe_inst[0].noc__pe__port0_valid = pe_inst[1].pe__noc__port2_valid ;
  assign pe_inst[0].noc__pe__port0_cntl  = pe_inst[1].pe__noc__port2_cntl  ;
  assign pe_inst[0].noc__pe__port0_data  = pe_inst[1].pe__noc__port2_data  ;
  assign pe_inst[1].noc__pe__port2_fc    = pe_inst[0].pe__noc__port0_fc    ;

  // Terminate PE2's 1 unused Ports
  assign pe_inst[2].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[2].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[2].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[2].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE2 Port0 to PE3 Port2
  assign pe_inst[3].noc__pe__port2_valid = pe_inst[2].pe__noc__port0_valid ;
  assign pe_inst[3].noc__pe__port2_cntl  = pe_inst[2].pe__noc__port0_cntl  ;
  assign pe_inst[3].noc__pe__port2_data  = pe_inst[2].pe__noc__port0_data  ;
  assign pe_inst[2].noc__pe__port0_fc    = pe_inst[3].pe__noc__port2_fc    ;

  // Connecting PE2 Port1 to PE10 Port0
  assign pe_inst[10].noc__pe__port0_valid = pe_inst[2].pe__noc__port1_valid ;
  assign pe_inst[10].noc__pe__port0_cntl  = pe_inst[2].pe__noc__port1_cntl  ;
  assign pe_inst[10].noc__pe__port0_data  = pe_inst[2].pe__noc__port1_data  ;
  assign pe_inst[2].noc__pe__port1_fc    = pe_inst[10].pe__noc__port0_fc    ;

  // Connecting PE2 Port2 to PE1 Port0
  assign pe_inst[1].noc__pe__port0_valid = pe_inst[2].pe__noc__port2_valid ;
  assign pe_inst[1].noc__pe__port0_cntl  = pe_inst[2].pe__noc__port2_cntl  ;
  assign pe_inst[1].noc__pe__port0_data  = pe_inst[2].pe__noc__port2_data  ;
  assign pe_inst[2].noc__pe__port2_fc    = pe_inst[1].pe__noc__port0_fc    ;

  // Terminate PE3's 1 unused Ports
  assign pe_inst[3].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[3].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[3].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[3].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE3 Port0 to PE4 Port2
  assign pe_inst[4].noc__pe__port2_valid = pe_inst[3].pe__noc__port0_valid ;
  assign pe_inst[4].noc__pe__port2_cntl  = pe_inst[3].pe__noc__port0_cntl  ;
  assign pe_inst[4].noc__pe__port2_data  = pe_inst[3].pe__noc__port0_data  ;
  assign pe_inst[3].noc__pe__port0_fc    = pe_inst[4].pe__noc__port2_fc    ;

  // Connecting PE3 Port1 to PE11 Port0
  assign pe_inst[11].noc__pe__port0_valid = pe_inst[3].pe__noc__port1_valid ;
  assign pe_inst[11].noc__pe__port0_cntl  = pe_inst[3].pe__noc__port1_cntl  ;
  assign pe_inst[11].noc__pe__port0_data  = pe_inst[3].pe__noc__port1_data  ;
  assign pe_inst[3].noc__pe__port1_fc    = pe_inst[11].pe__noc__port0_fc    ;

  // Connecting PE3 Port2 to PE2 Port0
  assign pe_inst[2].noc__pe__port0_valid = pe_inst[3].pe__noc__port2_valid ;
  assign pe_inst[2].noc__pe__port0_cntl  = pe_inst[3].pe__noc__port2_cntl  ;
  assign pe_inst[2].noc__pe__port0_data  = pe_inst[3].pe__noc__port2_data  ;
  assign pe_inst[3].noc__pe__port2_fc    = pe_inst[2].pe__noc__port0_fc    ;

  // Terminate PE4's 1 unused Ports
  assign pe_inst[4].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[4].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[4].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[4].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE4 Port0 to PE5 Port2
  assign pe_inst[5].noc__pe__port2_valid = pe_inst[4].pe__noc__port0_valid ;
  assign pe_inst[5].noc__pe__port2_cntl  = pe_inst[4].pe__noc__port0_cntl  ;
  assign pe_inst[5].noc__pe__port2_data  = pe_inst[4].pe__noc__port0_data  ;
  assign pe_inst[4].noc__pe__port0_fc    = pe_inst[5].pe__noc__port2_fc    ;

  // Connecting PE4 Port1 to PE12 Port0
  assign pe_inst[12].noc__pe__port0_valid = pe_inst[4].pe__noc__port1_valid ;
  assign pe_inst[12].noc__pe__port0_cntl  = pe_inst[4].pe__noc__port1_cntl  ;
  assign pe_inst[12].noc__pe__port0_data  = pe_inst[4].pe__noc__port1_data  ;
  assign pe_inst[4].noc__pe__port1_fc    = pe_inst[12].pe__noc__port0_fc    ;

  // Connecting PE4 Port2 to PE3 Port0
  assign pe_inst[3].noc__pe__port0_valid = pe_inst[4].pe__noc__port2_valid ;
  assign pe_inst[3].noc__pe__port0_cntl  = pe_inst[4].pe__noc__port2_cntl  ;
  assign pe_inst[3].noc__pe__port0_data  = pe_inst[4].pe__noc__port2_data  ;
  assign pe_inst[4].noc__pe__port2_fc    = pe_inst[3].pe__noc__port0_fc    ;

  // Terminate PE5's 1 unused Ports
  assign pe_inst[5].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[5].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[5].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[5].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE5 Port0 to PE6 Port2
  assign pe_inst[6].noc__pe__port2_valid = pe_inst[5].pe__noc__port0_valid ;
  assign pe_inst[6].noc__pe__port2_cntl  = pe_inst[5].pe__noc__port0_cntl  ;
  assign pe_inst[6].noc__pe__port2_data  = pe_inst[5].pe__noc__port0_data  ;
  assign pe_inst[5].noc__pe__port0_fc    = pe_inst[6].pe__noc__port2_fc    ;

  // Connecting PE5 Port1 to PE13 Port0
  assign pe_inst[13].noc__pe__port0_valid = pe_inst[5].pe__noc__port1_valid ;
  assign pe_inst[13].noc__pe__port0_cntl  = pe_inst[5].pe__noc__port1_cntl  ;
  assign pe_inst[13].noc__pe__port0_data  = pe_inst[5].pe__noc__port1_data  ;
  assign pe_inst[5].noc__pe__port1_fc    = pe_inst[13].pe__noc__port0_fc    ;

  // Connecting PE5 Port2 to PE4 Port0
  assign pe_inst[4].noc__pe__port0_valid = pe_inst[5].pe__noc__port2_valid ;
  assign pe_inst[4].noc__pe__port0_cntl  = pe_inst[5].pe__noc__port2_cntl  ;
  assign pe_inst[4].noc__pe__port0_data  = pe_inst[5].pe__noc__port2_data  ;
  assign pe_inst[5].noc__pe__port2_fc    = pe_inst[4].pe__noc__port0_fc    ;

  // Terminate PE6's 1 unused Ports
  assign pe_inst[6].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[6].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[6].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[6].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE6 Port0 to PE7 Port1
  assign pe_inst[7].noc__pe__port1_valid = pe_inst[6].pe__noc__port0_valid ;
  assign pe_inst[7].noc__pe__port1_cntl  = pe_inst[6].pe__noc__port0_cntl  ;
  assign pe_inst[7].noc__pe__port1_data  = pe_inst[6].pe__noc__port0_data  ;
  assign pe_inst[6].noc__pe__port0_fc    = pe_inst[7].pe__noc__port1_fc    ;

  // Connecting PE6 Port1 to PE14 Port0
  assign pe_inst[14].noc__pe__port0_valid = pe_inst[6].pe__noc__port1_valid ;
  assign pe_inst[14].noc__pe__port0_cntl  = pe_inst[6].pe__noc__port1_cntl  ;
  assign pe_inst[14].noc__pe__port0_data  = pe_inst[6].pe__noc__port1_data  ;
  assign pe_inst[6].noc__pe__port1_fc    = pe_inst[14].pe__noc__port0_fc    ;

  // Connecting PE6 Port2 to PE5 Port0
  assign pe_inst[5].noc__pe__port0_valid = pe_inst[6].pe__noc__port2_valid ;
  assign pe_inst[5].noc__pe__port0_cntl  = pe_inst[6].pe__noc__port2_cntl  ;
  assign pe_inst[5].noc__pe__port0_data  = pe_inst[6].pe__noc__port2_data  ;
  assign pe_inst[6].noc__pe__port2_fc    = pe_inst[5].pe__noc__port0_fc    ;

  // Terminate PE7's 2 unused Ports
  assign pe_inst[7].noc__pe__port2_valid = 'd0 ;
  assign pe_inst[7].noc__pe__port2_cntl  = 'd0 ;
  assign pe_inst[7].noc__pe__port2_data  = 'd0 ;
  assign pe_inst[7].noc__pe__port2_fc    = 'd0 ;
  assign pe_inst[7].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[7].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[7].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[7].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE7 Port0 to PE15 Port0
  assign pe_inst[15].noc__pe__port0_valid = pe_inst[7].pe__noc__port0_valid ;
  assign pe_inst[15].noc__pe__port0_cntl  = pe_inst[7].pe__noc__port0_cntl  ;
  assign pe_inst[15].noc__pe__port0_data  = pe_inst[7].pe__noc__port0_data  ;
  assign pe_inst[7].noc__pe__port0_fc    = pe_inst[15].pe__noc__port0_fc    ;

  // Connecting PE7 Port1 to PE6 Port0
  assign pe_inst[6].noc__pe__port0_valid = pe_inst[7].pe__noc__port1_valid ;
  assign pe_inst[6].noc__pe__port0_cntl  = pe_inst[7].pe__noc__port1_cntl  ;
  assign pe_inst[6].noc__pe__port0_data  = pe_inst[7].pe__noc__port1_data  ;
  assign pe_inst[7].noc__pe__port1_fc    = pe_inst[6].pe__noc__port0_fc    ;

  // Terminate PE8's 1 unused Ports
  assign pe_inst[8].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[8].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[8].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[8].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE8 Port0 to PE0 Port1
  assign pe_inst[0].noc__pe__port1_valid = pe_inst[8].pe__noc__port0_valid ;
  assign pe_inst[0].noc__pe__port1_cntl  = pe_inst[8].pe__noc__port0_cntl  ;
  assign pe_inst[0].noc__pe__port1_data  = pe_inst[8].pe__noc__port0_data  ;
  assign pe_inst[8].noc__pe__port0_fc    = pe_inst[0].pe__noc__port1_fc    ;

  // Connecting PE8 Port1 to PE9 Port3
  assign pe_inst[9].noc__pe__port3_valid = pe_inst[8].pe__noc__port1_valid ;
  assign pe_inst[9].noc__pe__port3_cntl  = pe_inst[8].pe__noc__port1_cntl  ;
  assign pe_inst[9].noc__pe__port3_data  = pe_inst[8].pe__noc__port1_data  ;
  assign pe_inst[8].noc__pe__port1_fc    = pe_inst[9].pe__noc__port3_fc    ;

  // Connecting PE8 Port2 to PE16 Port0
  assign pe_inst[16].noc__pe__port0_valid = pe_inst[8].pe__noc__port2_valid ;
  assign pe_inst[16].noc__pe__port0_cntl  = pe_inst[8].pe__noc__port2_cntl  ;
  assign pe_inst[16].noc__pe__port0_data  = pe_inst[8].pe__noc__port2_data  ;
  assign pe_inst[8].noc__pe__port2_fc    = pe_inst[16].pe__noc__port0_fc    ;

  // Connecting PE9 Port0 to PE1 Port1
  assign pe_inst[1].noc__pe__port1_valid = pe_inst[9].pe__noc__port0_valid ;
  assign pe_inst[1].noc__pe__port1_cntl  = pe_inst[9].pe__noc__port0_cntl  ;
  assign pe_inst[1].noc__pe__port1_data  = pe_inst[9].pe__noc__port0_data  ;
  assign pe_inst[9].noc__pe__port0_fc    = pe_inst[1].pe__noc__port1_fc    ;

  // Connecting PE9 Port1 to PE10 Port3
  assign pe_inst[10].noc__pe__port3_valid = pe_inst[9].pe__noc__port1_valid ;
  assign pe_inst[10].noc__pe__port3_cntl  = pe_inst[9].pe__noc__port1_cntl  ;
  assign pe_inst[10].noc__pe__port3_data  = pe_inst[9].pe__noc__port1_data  ;
  assign pe_inst[9].noc__pe__port1_fc    = pe_inst[10].pe__noc__port3_fc    ;

  // Connecting PE9 Port2 to PE17 Port0
  assign pe_inst[17].noc__pe__port0_valid = pe_inst[9].pe__noc__port2_valid ;
  assign pe_inst[17].noc__pe__port0_cntl  = pe_inst[9].pe__noc__port2_cntl  ;
  assign pe_inst[17].noc__pe__port0_data  = pe_inst[9].pe__noc__port2_data  ;
  assign pe_inst[9].noc__pe__port2_fc    = pe_inst[17].pe__noc__port0_fc    ;

  // Connecting PE9 Port3 to PE8 Port1
  assign pe_inst[8].noc__pe__port1_valid = pe_inst[9].pe__noc__port3_valid ;
  assign pe_inst[8].noc__pe__port1_cntl  = pe_inst[9].pe__noc__port3_cntl  ;
  assign pe_inst[8].noc__pe__port1_data  = pe_inst[9].pe__noc__port3_data  ;
  assign pe_inst[9].noc__pe__port3_fc    = pe_inst[8].pe__noc__port1_fc    ;

  // Connecting PE10 Port0 to PE2 Port1
  assign pe_inst[2].noc__pe__port1_valid = pe_inst[10].pe__noc__port0_valid ;
  assign pe_inst[2].noc__pe__port1_cntl  = pe_inst[10].pe__noc__port0_cntl  ;
  assign pe_inst[2].noc__pe__port1_data  = pe_inst[10].pe__noc__port0_data  ;
  assign pe_inst[10].noc__pe__port0_fc    = pe_inst[2].pe__noc__port1_fc    ;

  // Connecting PE10 Port1 to PE11 Port3
  assign pe_inst[11].noc__pe__port3_valid = pe_inst[10].pe__noc__port1_valid ;
  assign pe_inst[11].noc__pe__port3_cntl  = pe_inst[10].pe__noc__port1_cntl  ;
  assign pe_inst[11].noc__pe__port3_data  = pe_inst[10].pe__noc__port1_data  ;
  assign pe_inst[10].noc__pe__port1_fc    = pe_inst[11].pe__noc__port3_fc    ;

  // Connecting PE10 Port2 to PE18 Port0
  assign pe_inst[18].noc__pe__port0_valid = pe_inst[10].pe__noc__port2_valid ;
  assign pe_inst[18].noc__pe__port0_cntl  = pe_inst[10].pe__noc__port2_cntl  ;
  assign pe_inst[18].noc__pe__port0_data  = pe_inst[10].pe__noc__port2_data  ;
  assign pe_inst[10].noc__pe__port2_fc    = pe_inst[18].pe__noc__port0_fc    ;

  // Connecting PE10 Port3 to PE9 Port1
  assign pe_inst[9].noc__pe__port1_valid = pe_inst[10].pe__noc__port3_valid ;
  assign pe_inst[9].noc__pe__port1_cntl  = pe_inst[10].pe__noc__port3_cntl  ;
  assign pe_inst[9].noc__pe__port1_data  = pe_inst[10].pe__noc__port3_data  ;
  assign pe_inst[10].noc__pe__port3_fc    = pe_inst[9].pe__noc__port1_fc    ;

  // Connecting PE11 Port0 to PE3 Port1
  assign pe_inst[3].noc__pe__port1_valid = pe_inst[11].pe__noc__port0_valid ;
  assign pe_inst[3].noc__pe__port1_cntl  = pe_inst[11].pe__noc__port0_cntl  ;
  assign pe_inst[3].noc__pe__port1_data  = pe_inst[11].pe__noc__port0_data  ;
  assign pe_inst[11].noc__pe__port0_fc    = pe_inst[3].pe__noc__port1_fc    ;

  // Connecting PE11 Port1 to PE12 Port3
  assign pe_inst[12].noc__pe__port3_valid = pe_inst[11].pe__noc__port1_valid ;
  assign pe_inst[12].noc__pe__port3_cntl  = pe_inst[11].pe__noc__port1_cntl  ;
  assign pe_inst[12].noc__pe__port3_data  = pe_inst[11].pe__noc__port1_data  ;
  assign pe_inst[11].noc__pe__port1_fc    = pe_inst[12].pe__noc__port3_fc    ;

  // Connecting PE11 Port2 to PE19 Port0
  assign pe_inst[19].noc__pe__port0_valid = pe_inst[11].pe__noc__port2_valid ;
  assign pe_inst[19].noc__pe__port0_cntl  = pe_inst[11].pe__noc__port2_cntl  ;
  assign pe_inst[19].noc__pe__port0_data  = pe_inst[11].pe__noc__port2_data  ;
  assign pe_inst[11].noc__pe__port2_fc    = pe_inst[19].pe__noc__port0_fc    ;

  // Connecting PE11 Port3 to PE10 Port1
  assign pe_inst[10].noc__pe__port1_valid = pe_inst[11].pe__noc__port3_valid ;
  assign pe_inst[10].noc__pe__port1_cntl  = pe_inst[11].pe__noc__port3_cntl  ;
  assign pe_inst[10].noc__pe__port1_data  = pe_inst[11].pe__noc__port3_data  ;
  assign pe_inst[11].noc__pe__port3_fc    = pe_inst[10].pe__noc__port1_fc    ;

  // Connecting PE12 Port0 to PE4 Port1
  assign pe_inst[4].noc__pe__port1_valid = pe_inst[12].pe__noc__port0_valid ;
  assign pe_inst[4].noc__pe__port1_cntl  = pe_inst[12].pe__noc__port0_cntl  ;
  assign pe_inst[4].noc__pe__port1_data  = pe_inst[12].pe__noc__port0_data  ;
  assign pe_inst[12].noc__pe__port0_fc    = pe_inst[4].pe__noc__port1_fc    ;

  // Connecting PE12 Port1 to PE13 Port3
  assign pe_inst[13].noc__pe__port3_valid = pe_inst[12].pe__noc__port1_valid ;
  assign pe_inst[13].noc__pe__port3_cntl  = pe_inst[12].pe__noc__port1_cntl  ;
  assign pe_inst[13].noc__pe__port3_data  = pe_inst[12].pe__noc__port1_data  ;
  assign pe_inst[12].noc__pe__port1_fc    = pe_inst[13].pe__noc__port3_fc    ;

  // Connecting PE12 Port2 to PE20 Port0
  assign pe_inst[20].noc__pe__port0_valid = pe_inst[12].pe__noc__port2_valid ;
  assign pe_inst[20].noc__pe__port0_cntl  = pe_inst[12].pe__noc__port2_cntl  ;
  assign pe_inst[20].noc__pe__port0_data  = pe_inst[12].pe__noc__port2_data  ;
  assign pe_inst[12].noc__pe__port2_fc    = pe_inst[20].pe__noc__port0_fc    ;

  // Connecting PE12 Port3 to PE11 Port1
  assign pe_inst[11].noc__pe__port1_valid = pe_inst[12].pe__noc__port3_valid ;
  assign pe_inst[11].noc__pe__port1_cntl  = pe_inst[12].pe__noc__port3_cntl  ;
  assign pe_inst[11].noc__pe__port1_data  = pe_inst[12].pe__noc__port3_data  ;
  assign pe_inst[12].noc__pe__port3_fc    = pe_inst[11].pe__noc__port1_fc    ;

  // Connecting PE13 Port0 to PE5 Port1
  assign pe_inst[5].noc__pe__port1_valid = pe_inst[13].pe__noc__port0_valid ;
  assign pe_inst[5].noc__pe__port1_cntl  = pe_inst[13].pe__noc__port0_cntl  ;
  assign pe_inst[5].noc__pe__port1_data  = pe_inst[13].pe__noc__port0_data  ;
  assign pe_inst[13].noc__pe__port0_fc    = pe_inst[5].pe__noc__port1_fc    ;

  // Connecting PE13 Port1 to PE14 Port3
  assign pe_inst[14].noc__pe__port3_valid = pe_inst[13].pe__noc__port1_valid ;
  assign pe_inst[14].noc__pe__port3_cntl  = pe_inst[13].pe__noc__port1_cntl  ;
  assign pe_inst[14].noc__pe__port3_data  = pe_inst[13].pe__noc__port1_data  ;
  assign pe_inst[13].noc__pe__port1_fc    = pe_inst[14].pe__noc__port3_fc    ;

  // Connecting PE13 Port2 to PE21 Port0
  assign pe_inst[21].noc__pe__port0_valid = pe_inst[13].pe__noc__port2_valid ;
  assign pe_inst[21].noc__pe__port0_cntl  = pe_inst[13].pe__noc__port2_cntl  ;
  assign pe_inst[21].noc__pe__port0_data  = pe_inst[13].pe__noc__port2_data  ;
  assign pe_inst[13].noc__pe__port2_fc    = pe_inst[21].pe__noc__port0_fc    ;

  // Connecting PE13 Port3 to PE12 Port1
  assign pe_inst[12].noc__pe__port1_valid = pe_inst[13].pe__noc__port3_valid ;
  assign pe_inst[12].noc__pe__port1_cntl  = pe_inst[13].pe__noc__port3_cntl  ;
  assign pe_inst[12].noc__pe__port1_data  = pe_inst[13].pe__noc__port3_data  ;
  assign pe_inst[13].noc__pe__port3_fc    = pe_inst[12].pe__noc__port1_fc    ;

  // Connecting PE14 Port0 to PE6 Port1
  assign pe_inst[6].noc__pe__port1_valid = pe_inst[14].pe__noc__port0_valid ;
  assign pe_inst[6].noc__pe__port1_cntl  = pe_inst[14].pe__noc__port0_cntl  ;
  assign pe_inst[6].noc__pe__port1_data  = pe_inst[14].pe__noc__port0_data  ;
  assign pe_inst[14].noc__pe__port0_fc    = pe_inst[6].pe__noc__port1_fc    ;

  // Connecting PE14 Port1 to PE15 Port2
  assign pe_inst[15].noc__pe__port2_valid = pe_inst[14].pe__noc__port1_valid ;
  assign pe_inst[15].noc__pe__port2_cntl  = pe_inst[14].pe__noc__port1_cntl  ;
  assign pe_inst[15].noc__pe__port2_data  = pe_inst[14].pe__noc__port1_data  ;
  assign pe_inst[14].noc__pe__port1_fc    = pe_inst[15].pe__noc__port2_fc    ;

  // Connecting PE14 Port2 to PE22 Port0
  assign pe_inst[22].noc__pe__port0_valid = pe_inst[14].pe__noc__port2_valid ;
  assign pe_inst[22].noc__pe__port0_cntl  = pe_inst[14].pe__noc__port2_cntl  ;
  assign pe_inst[22].noc__pe__port0_data  = pe_inst[14].pe__noc__port2_data  ;
  assign pe_inst[14].noc__pe__port2_fc    = pe_inst[22].pe__noc__port0_fc    ;

  // Connecting PE14 Port3 to PE13 Port1
  assign pe_inst[13].noc__pe__port1_valid = pe_inst[14].pe__noc__port3_valid ;
  assign pe_inst[13].noc__pe__port1_cntl  = pe_inst[14].pe__noc__port3_cntl  ;
  assign pe_inst[13].noc__pe__port1_data  = pe_inst[14].pe__noc__port3_data  ;
  assign pe_inst[14].noc__pe__port3_fc    = pe_inst[13].pe__noc__port1_fc    ;

  // Terminate PE15's 1 unused Ports
  assign pe_inst[15].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[15].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[15].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[15].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE15 Port0 to PE7 Port0
  assign pe_inst[7].noc__pe__port0_valid = pe_inst[15].pe__noc__port0_valid ;
  assign pe_inst[7].noc__pe__port0_cntl  = pe_inst[15].pe__noc__port0_cntl  ;
  assign pe_inst[7].noc__pe__port0_data  = pe_inst[15].pe__noc__port0_data  ;
  assign pe_inst[15].noc__pe__port0_fc    = pe_inst[7].pe__noc__port0_fc    ;

  // Connecting PE15 Port1 to PE23 Port0
  assign pe_inst[23].noc__pe__port0_valid = pe_inst[15].pe__noc__port1_valid ;
  assign pe_inst[23].noc__pe__port0_cntl  = pe_inst[15].pe__noc__port1_cntl  ;
  assign pe_inst[23].noc__pe__port0_data  = pe_inst[15].pe__noc__port1_data  ;
  assign pe_inst[15].noc__pe__port1_fc    = pe_inst[23].pe__noc__port0_fc    ;

  // Connecting PE15 Port2 to PE14 Port1
  assign pe_inst[14].noc__pe__port1_valid = pe_inst[15].pe__noc__port2_valid ;
  assign pe_inst[14].noc__pe__port1_cntl  = pe_inst[15].pe__noc__port2_cntl  ;
  assign pe_inst[14].noc__pe__port1_data  = pe_inst[15].pe__noc__port2_data  ;
  assign pe_inst[15].noc__pe__port2_fc    = pe_inst[14].pe__noc__port1_fc    ;

  // Terminate PE16's 1 unused Ports
  assign pe_inst[16].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[16].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[16].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[16].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE16 Port0 to PE8 Port2
  assign pe_inst[8].noc__pe__port2_valid = pe_inst[16].pe__noc__port0_valid ;
  assign pe_inst[8].noc__pe__port2_cntl  = pe_inst[16].pe__noc__port0_cntl  ;
  assign pe_inst[8].noc__pe__port2_data  = pe_inst[16].pe__noc__port0_data  ;
  assign pe_inst[16].noc__pe__port0_fc    = pe_inst[8].pe__noc__port2_fc    ;

  // Connecting PE16 Port1 to PE17 Port3
  assign pe_inst[17].noc__pe__port3_valid = pe_inst[16].pe__noc__port1_valid ;
  assign pe_inst[17].noc__pe__port3_cntl  = pe_inst[16].pe__noc__port1_cntl  ;
  assign pe_inst[17].noc__pe__port3_data  = pe_inst[16].pe__noc__port1_data  ;
  assign pe_inst[16].noc__pe__port1_fc    = pe_inst[17].pe__noc__port3_fc    ;

  // Connecting PE16 Port2 to PE24 Port0
  assign pe_inst[24].noc__pe__port0_valid = pe_inst[16].pe__noc__port2_valid ;
  assign pe_inst[24].noc__pe__port0_cntl  = pe_inst[16].pe__noc__port2_cntl  ;
  assign pe_inst[24].noc__pe__port0_data  = pe_inst[16].pe__noc__port2_data  ;
  assign pe_inst[16].noc__pe__port2_fc    = pe_inst[24].pe__noc__port0_fc    ;

  // Connecting PE17 Port0 to PE9 Port2
  assign pe_inst[9].noc__pe__port2_valid = pe_inst[17].pe__noc__port0_valid ;
  assign pe_inst[9].noc__pe__port2_cntl  = pe_inst[17].pe__noc__port0_cntl  ;
  assign pe_inst[9].noc__pe__port2_data  = pe_inst[17].pe__noc__port0_data  ;
  assign pe_inst[17].noc__pe__port0_fc    = pe_inst[9].pe__noc__port2_fc    ;

  // Connecting PE17 Port1 to PE18 Port3
  assign pe_inst[18].noc__pe__port3_valid = pe_inst[17].pe__noc__port1_valid ;
  assign pe_inst[18].noc__pe__port3_cntl  = pe_inst[17].pe__noc__port1_cntl  ;
  assign pe_inst[18].noc__pe__port3_data  = pe_inst[17].pe__noc__port1_data  ;
  assign pe_inst[17].noc__pe__port1_fc    = pe_inst[18].pe__noc__port3_fc    ;

  // Connecting PE17 Port2 to PE25 Port0
  assign pe_inst[25].noc__pe__port0_valid = pe_inst[17].pe__noc__port2_valid ;
  assign pe_inst[25].noc__pe__port0_cntl  = pe_inst[17].pe__noc__port2_cntl  ;
  assign pe_inst[25].noc__pe__port0_data  = pe_inst[17].pe__noc__port2_data  ;
  assign pe_inst[17].noc__pe__port2_fc    = pe_inst[25].pe__noc__port0_fc    ;

  // Connecting PE17 Port3 to PE16 Port1
  assign pe_inst[16].noc__pe__port1_valid = pe_inst[17].pe__noc__port3_valid ;
  assign pe_inst[16].noc__pe__port1_cntl  = pe_inst[17].pe__noc__port3_cntl  ;
  assign pe_inst[16].noc__pe__port1_data  = pe_inst[17].pe__noc__port3_data  ;
  assign pe_inst[17].noc__pe__port3_fc    = pe_inst[16].pe__noc__port1_fc    ;

  // Connecting PE18 Port0 to PE10 Port2
  assign pe_inst[10].noc__pe__port2_valid = pe_inst[18].pe__noc__port0_valid ;
  assign pe_inst[10].noc__pe__port2_cntl  = pe_inst[18].pe__noc__port0_cntl  ;
  assign pe_inst[10].noc__pe__port2_data  = pe_inst[18].pe__noc__port0_data  ;
  assign pe_inst[18].noc__pe__port0_fc    = pe_inst[10].pe__noc__port2_fc    ;

  // Connecting PE18 Port1 to PE19 Port3
  assign pe_inst[19].noc__pe__port3_valid = pe_inst[18].pe__noc__port1_valid ;
  assign pe_inst[19].noc__pe__port3_cntl  = pe_inst[18].pe__noc__port1_cntl  ;
  assign pe_inst[19].noc__pe__port3_data  = pe_inst[18].pe__noc__port1_data  ;
  assign pe_inst[18].noc__pe__port1_fc    = pe_inst[19].pe__noc__port3_fc    ;

  // Connecting PE18 Port2 to PE26 Port0
  assign pe_inst[26].noc__pe__port0_valid = pe_inst[18].pe__noc__port2_valid ;
  assign pe_inst[26].noc__pe__port0_cntl  = pe_inst[18].pe__noc__port2_cntl  ;
  assign pe_inst[26].noc__pe__port0_data  = pe_inst[18].pe__noc__port2_data  ;
  assign pe_inst[18].noc__pe__port2_fc    = pe_inst[26].pe__noc__port0_fc    ;

  // Connecting PE18 Port3 to PE17 Port1
  assign pe_inst[17].noc__pe__port1_valid = pe_inst[18].pe__noc__port3_valid ;
  assign pe_inst[17].noc__pe__port1_cntl  = pe_inst[18].pe__noc__port3_cntl  ;
  assign pe_inst[17].noc__pe__port1_data  = pe_inst[18].pe__noc__port3_data  ;
  assign pe_inst[18].noc__pe__port3_fc    = pe_inst[17].pe__noc__port1_fc    ;

  // Connecting PE19 Port0 to PE11 Port2
  assign pe_inst[11].noc__pe__port2_valid = pe_inst[19].pe__noc__port0_valid ;
  assign pe_inst[11].noc__pe__port2_cntl  = pe_inst[19].pe__noc__port0_cntl  ;
  assign pe_inst[11].noc__pe__port2_data  = pe_inst[19].pe__noc__port0_data  ;
  assign pe_inst[19].noc__pe__port0_fc    = pe_inst[11].pe__noc__port2_fc    ;

  // Connecting PE19 Port1 to PE20 Port3
  assign pe_inst[20].noc__pe__port3_valid = pe_inst[19].pe__noc__port1_valid ;
  assign pe_inst[20].noc__pe__port3_cntl  = pe_inst[19].pe__noc__port1_cntl  ;
  assign pe_inst[20].noc__pe__port3_data  = pe_inst[19].pe__noc__port1_data  ;
  assign pe_inst[19].noc__pe__port1_fc    = pe_inst[20].pe__noc__port3_fc    ;

  // Connecting PE19 Port2 to PE27 Port0
  assign pe_inst[27].noc__pe__port0_valid = pe_inst[19].pe__noc__port2_valid ;
  assign pe_inst[27].noc__pe__port0_cntl  = pe_inst[19].pe__noc__port2_cntl  ;
  assign pe_inst[27].noc__pe__port0_data  = pe_inst[19].pe__noc__port2_data  ;
  assign pe_inst[19].noc__pe__port2_fc    = pe_inst[27].pe__noc__port0_fc    ;

  // Connecting PE19 Port3 to PE18 Port1
  assign pe_inst[18].noc__pe__port1_valid = pe_inst[19].pe__noc__port3_valid ;
  assign pe_inst[18].noc__pe__port1_cntl  = pe_inst[19].pe__noc__port3_cntl  ;
  assign pe_inst[18].noc__pe__port1_data  = pe_inst[19].pe__noc__port3_data  ;
  assign pe_inst[19].noc__pe__port3_fc    = pe_inst[18].pe__noc__port1_fc    ;

  // Connecting PE20 Port0 to PE12 Port2
  assign pe_inst[12].noc__pe__port2_valid = pe_inst[20].pe__noc__port0_valid ;
  assign pe_inst[12].noc__pe__port2_cntl  = pe_inst[20].pe__noc__port0_cntl  ;
  assign pe_inst[12].noc__pe__port2_data  = pe_inst[20].pe__noc__port0_data  ;
  assign pe_inst[20].noc__pe__port0_fc    = pe_inst[12].pe__noc__port2_fc    ;

  // Connecting PE20 Port1 to PE21 Port3
  assign pe_inst[21].noc__pe__port3_valid = pe_inst[20].pe__noc__port1_valid ;
  assign pe_inst[21].noc__pe__port3_cntl  = pe_inst[20].pe__noc__port1_cntl  ;
  assign pe_inst[21].noc__pe__port3_data  = pe_inst[20].pe__noc__port1_data  ;
  assign pe_inst[20].noc__pe__port1_fc    = pe_inst[21].pe__noc__port3_fc    ;

  // Connecting PE20 Port2 to PE28 Port0
  assign pe_inst[28].noc__pe__port0_valid = pe_inst[20].pe__noc__port2_valid ;
  assign pe_inst[28].noc__pe__port0_cntl  = pe_inst[20].pe__noc__port2_cntl  ;
  assign pe_inst[28].noc__pe__port0_data  = pe_inst[20].pe__noc__port2_data  ;
  assign pe_inst[20].noc__pe__port2_fc    = pe_inst[28].pe__noc__port0_fc    ;

  // Connecting PE20 Port3 to PE19 Port1
  assign pe_inst[19].noc__pe__port1_valid = pe_inst[20].pe__noc__port3_valid ;
  assign pe_inst[19].noc__pe__port1_cntl  = pe_inst[20].pe__noc__port3_cntl  ;
  assign pe_inst[19].noc__pe__port1_data  = pe_inst[20].pe__noc__port3_data  ;
  assign pe_inst[20].noc__pe__port3_fc    = pe_inst[19].pe__noc__port1_fc    ;

  // Connecting PE21 Port0 to PE13 Port2
  assign pe_inst[13].noc__pe__port2_valid = pe_inst[21].pe__noc__port0_valid ;
  assign pe_inst[13].noc__pe__port2_cntl  = pe_inst[21].pe__noc__port0_cntl  ;
  assign pe_inst[13].noc__pe__port2_data  = pe_inst[21].pe__noc__port0_data  ;
  assign pe_inst[21].noc__pe__port0_fc    = pe_inst[13].pe__noc__port2_fc    ;

  // Connecting PE21 Port1 to PE22 Port3
  assign pe_inst[22].noc__pe__port3_valid = pe_inst[21].pe__noc__port1_valid ;
  assign pe_inst[22].noc__pe__port3_cntl  = pe_inst[21].pe__noc__port1_cntl  ;
  assign pe_inst[22].noc__pe__port3_data  = pe_inst[21].pe__noc__port1_data  ;
  assign pe_inst[21].noc__pe__port1_fc    = pe_inst[22].pe__noc__port3_fc    ;

  // Connecting PE21 Port2 to PE29 Port0
  assign pe_inst[29].noc__pe__port0_valid = pe_inst[21].pe__noc__port2_valid ;
  assign pe_inst[29].noc__pe__port0_cntl  = pe_inst[21].pe__noc__port2_cntl  ;
  assign pe_inst[29].noc__pe__port0_data  = pe_inst[21].pe__noc__port2_data  ;
  assign pe_inst[21].noc__pe__port2_fc    = pe_inst[29].pe__noc__port0_fc    ;

  // Connecting PE21 Port3 to PE20 Port1
  assign pe_inst[20].noc__pe__port1_valid = pe_inst[21].pe__noc__port3_valid ;
  assign pe_inst[20].noc__pe__port1_cntl  = pe_inst[21].pe__noc__port3_cntl  ;
  assign pe_inst[20].noc__pe__port1_data  = pe_inst[21].pe__noc__port3_data  ;
  assign pe_inst[21].noc__pe__port3_fc    = pe_inst[20].pe__noc__port1_fc    ;

  // Connecting PE22 Port0 to PE14 Port2
  assign pe_inst[14].noc__pe__port2_valid = pe_inst[22].pe__noc__port0_valid ;
  assign pe_inst[14].noc__pe__port2_cntl  = pe_inst[22].pe__noc__port0_cntl  ;
  assign pe_inst[14].noc__pe__port2_data  = pe_inst[22].pe__noc__port0_data  ;
  assign pe_inst[22].noc__pe__port0_fc    = pe_inst[14].pe__noc__port2_fc    ;

  // Connecting PE22 Port1 to PE23 Port2
  assign pe_inst[23].noc__pe__port2_valid = pe_inst[22].pe__noc__port1_valid ;
  assign pe_inst[23].noc__pe__port2_cntl  = pe_inst[22].pe__noc__port1_cntl  ;
  assign pe_inst[23].noc__pe__port2_data  = pe_inst[22].pe__noc__port1_data  ;
  assign pe_inst[22].noc__pe__port1_fc    = pe_inst[23].pe__noc__port2_fc    ;

  // Connecting PE22 Port2 to PE30 Port0
  assign pe_inst[30].noc__pe__port0_valid = pe_inst[22].pe__noc__port2_valid ;
  assign pe_inst[30].noc__pe__port0_cntl  = pe_inst[22].pe__noc__port2_cntl  ;
  assign pe_inst[30].noc__pe__port0_data  = pe_inst[22].pe__noc__port2_data  ;
  assign pe_inst[22].noc__pe__port2_fc    = pe_inst[30].pe__noc__port0_fc    ;

  // Connecting PE22 Port3 to PE21 Port1
  assign pe_inst[21].noc__pe__port1_valid = pe_inst[22].pe__noc__port3_valid ;
  assign pe_inst[21].noc__pe__port1_cntl  = pe_inst[22].pe__noc__port3_cntl  ;
  assign pe_inst[21].noc__pe__port1_data  = pe_inst[22].pe__noc__port3_data  ;
  assign pe_inst[22].noc__pe__port3_fc    = pe_inst[21].pe__noc__port1_fc    ;

  // Terminate PE23's 1 unused Ports
  assign pe_inst[23].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[23].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[23].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[23].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE23 Port0 to PE15 Port1
  assign pe_inst[15].noc__pe__port1_valid = pe_inst[23].pe__noc__port0_valid ;
  assign pe_inst[15].noc__pe__port1_cntl  = pe_inst[23].pe__noc__port0_cntl  ;
  assign pe_inst[15].noc__pe__port1_data  = pe_inst[23].pe__noc__port0_data  ;
  assign pe_inst[23].noc__pe__port0_fc    = pe_inst[15].pe__noc__port1_fc    ;

  // Connecting PE23 Port1 to PE31 Port0
  assign pe_inst[31].noc__pe__port0_valid = pe_inst[23].pe__noc__port1_valid ;
  assign pe_inst[31].noc__pe__port0_cntl  = pe_inst[23].pe__noc__port1_cntl  ;
  assign pe_inst[31].noc__pe__port0_data  = pe_inst[23].pe__noc__port1_data  ;
  assign pe_inst[23].noc__pe__port1_fc    = pe_inst[31].pe__noc__port0_fc    ;

  // Connecting PE23 Port2 to PE22 Port1
  assign pe_inst[22].noc__pe__port1_valid = pe_inst[23].pe__noc__port2_valid ;
  assign pe_inst[22].noc__pe__port1_cntl  = pe_inst[23].pe__noc__port2_cntl  ;
  assign pe_inst[22].noc__pe__port1_data  = pe_inst[23].pe__noc__port2_data  ;
  assign pe_inst[23].noc__pe__port2_fc    = pe_inst[22].pe__noc__port1_fc    ;

  // Terminate PE24's 1 unused Ports
  assign pe_inst[24].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[24].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[24].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[24].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE24 Port0 to PE16 Port2
  assign pe_inst[16].noc__pe__port2_valid = pe_inst[24].pe__noc__port0_valid ;
  assign pe_inst[16].noc__pe__port2_cntl  = pe_inst[24].pe__noc__port0_cntl  ;
  assign pe_inst[16].noc__pe__port2_data  = pe_inst[24].pe__noc__port0_data  ;
  assign pe_inst[24].noc__pe__port0_fc    = pe_inst[16].pe__noc__port2_fc    ;

  // Connecting PE24 Port1 to PE25 Port3
  assign pe_inst[25].noc__pe__port3_valid = pe_inst[24].pe__noc__port1_valid ;
  assign pe_inst[25].noc__pe__port3_cntl  = pe_inst[24].pe__noc__port1_cntl  ;
  assign pe_inst[25].noc__pe__port3_data  = pe_inst[24].pe__noc__port1_data  ;
  assign pe_inst[24].noc__pe__port1_fc    = pe_inst[25].pe__noc__port3_fc    ;

  // Connecting PE24 Port2 to PE32 Port0
  assign pe_inst[32].noc__pe__port0_valid = pe_inst[24].pe__noc__port2_valid ;
  assign pe_inst[32].noc__pe__port0_cntl  = pe_inst[24].pe__noc__port2_cntl  ;
  assign pe_inst[32].noc__pe__port0_data  = pe_inst[24].pe__noc__port2_data  ;
  assign pe_inst[24].noc__pe__port2_fc    = pe_inst[32].pe__noc__port0_fc    ;

  // Connecting PE25 Port0 to PE17 Port2
  assign pe_inst[17].noc__pe__port2_valid = pe_inst[25].pe__noc__port0_valid ;
  assign pe_inst[17].noc__pe__port2_cntl  = pe_inst[25].pe__noc__port0_cntl  ;
  assign pe_inst[17].noc__pe__port2_data  = pe_inst[25].pe__noc__port0_data  ;
  assign pe_inst[25].noc__pe__port0_fc    = pe_inst[17].pe__noc__port2_fc    ;

  // Connecting PE25 Port1 to PE26 Port3
  assign pe_inst[26].noc__pe__port3_valid = pe_inst[25].pe__noc__port1_valid ;
  assign pe_inst[26].noc__pe__port3_cntl  = pe_inst[25].pe__noc__port1_cntl  ;
  assign pe_inst[26].noc__pe__port3_data  = pe_inst[25].pe__noc__port1_data  ;
  assign pe_inst[25].noc__pe__port1_fc    = pe_inst[26].pe__noc__port3_fc    ;

  // Connecting PE25 Port2 to PE33 Port0
  assign pe_inst[33].noc__pe__port0_valid = pe_inst[25].pe__noc__port2_valid ;
  assign pe_inst[33].noc__pe__port0_cntl  = pe_inst[25].pe__noc__port2_cntl  ;
  assign pe_inst[33].noc__pe__port0_data  = pe_inst[25].pe__noc__port2_data  ;
  assign pe_inst[25].noc__pe__port2_fc    = pe_inst[33].pe__noc__port0_fc    ;

  // Connecting PE25 Port3 to PE24 Port1
  assign pe_inst[24].noc__pe__port1_valid = pe_inst[25].pe__noc__port3_valid ;
  assign pe_inst[24].noc__pe__port1_cntl  = pe_inst[25].pe__noc__port3_cntl  ;
  assign pe_inst[24].noc__pe__port1_data  = pe_inst[25].pe__noc__port3_data  ;
  assign pe_inst[25].noc__pe__port3_fc    = pe_inst[24].pe__noc__port1_fc    ;

  // Connecting PE26 Port0 to PE18 Port2
  assign pe_inst[18].noc__pe__port2_valid = pe_inst[26].pe__noc__port0_valid ;
  assign pe_inst[18].noc__pe__port2_cntl  = pe_inst[26].pe__noc__port0_cntl  ;
  assign pe_inst[18].noc__pe__port2_data  = pe_inst[26].pe__noc__port0_data  ;
  assign pe_inst[26].noc__pe__port0_fc    = pe_inst[18].pe__noc__port2_fc    ;

  // Connecting PE26 Port1 to PE27 Port3
  assign pe_inst[27].noc__pe__port3_valid = pe_inst[26].pe__noc__port1_valid ;
  assign pe_inst[27].noc__pe__port3_cntl  = pe_inst[26].pe__noc__port1_cntl  ;
  assign pe_inst[27].noc__pe__port3_data  = pe_inst[26].pe__noc__port1_data  ;
  assign pe_inst[26].noc__pe__port1_fc    = pe_inst[27].pe__noc__port3_fc    ;

  // Connecting PE26 Port2 to PE34 Port0
  assign pe_inst[34].noc__pe__port0_valid = pe_inst[26].pe__noc__port2_valid ;
  assign pe_inst[34].noc__pe__port0_cntl  = pe_inst[26].pe__noc__port2_cntl  ;
  assign pe_inst[34].noc__pe__port0_data  = pe_inst[26].pe__noc__port2_data  ;
  assign pe_inst[26].noc__pe__port2_fc    = pe_inst[34].pe__noc__port0_fc    ;

  // Connecting PE26 Port3 to PE25 Port1
  assign pe_inst[25].noc__pe__port1_valid = pe_inst[26].pe__noc__port3_valid ;
  assign pe_inst[25].noc__pe__port1_cntl  = pe_inst[26].pe__noc__port3_cntl  ;
  assign pe_inst[25].noc__pe__port1_data  = pe_inst[26].pe__noc__port3_data  ;
  assign pe_inst[26].noc__pe__port3_fc    = pe_inst[25].pe__noc__port1_fc    ;

  // Connecting PE27 Port0 to PE19 Port2
  assign pe_inst[19].noc__pe__port2_valid = pe_inst[27].pe__noc__port0_valid ;
  assign pe_inst[19].noc__pe__port2_cntl  = pe_inst[27].pe__noc__port0_cntl  ;
  assign pe_inst[19].noc__pe__port2_data  = pe_inst[27].pe__noc__port0_data  ;
  assign pe_inst[27].noc__pe__port0_fc    = pe_inst[19].pe__noc__port2_fc    ;

  // Connecting PE27 Port1 to PE28 Port3
  assign pe_inst[28].noc__pe__port3_valid = pe_inst[27].pe__noc__port1_valid ;
  assign pe_inst[28].noc__pe__port3_cntl  = pe_inst[27].pe__noc__port1_cntl  ;
  assign pe_inst[28].noc__pe__port3_data  = pe_inst[27].pe__noc__port1_data  ;
  assign pe_inst[27].noc__pe__port1_fc    = pe_inst[28].pe__noc__port3_fc    ;

  // Connecting PE27 Port2 to PE35 Port0
  assign pe_inst[35].noc__pe__port0_valid = pe_inst[27].pe__noc__port2_valid ;
  assign pe_inst[35].noc__pe__port0_cntl  = pe_inst[27].pe__noc__port2_cntl  ;
  assign pe_inst[35].noc__pe__port0_data  = pe_inst[27].pe__noc__port2_data  ;
  assign pe_inst[27].noc__pe__port2_fc    = pe_inst[35].pe__noc__port0_fc    ;

  // Connecting PE27 Port3 to PE26 Port1
  assign pe_inst[26].noc__pe__port1_valid = pe_inst[27].pe__noc__port3_valid ;
  assign pe_inst[26].noc__pe__port1_cntl  = pe_inst[27].pe__noc__port3_cntl  ;
  assign pe_inst[26].noc__pe__port1_data  = pe_inst[27].pe__noc__port3_data  ;
  assign pe_inst[27].noc__pe__port3_fc    = pe_inst[26].pe__noc__port1_fc    ;

  // Connecting PE28 Port0 to PE20 Port2
  assign pe_inst[20].noc__pe__port2_valid = pe_inst[28].pe__noc__port0_valid ;
  assign pe_inst[20].noc__pe__port2_cntl  = pe_inst[28].pe__noc__port0_cntl  ;
  assign pe_inst[20].noc__pe__port2_data  = pe_inst[28].pe__noc__port0_data  ;
  assign pe_inst[28].noc__pe__port0_fc    = pe_inst[20].pe__noc__port2_fc    ;

  // Connecting PE28 Port1 to PE29 Port3
  assign pe_inst[29].noc__pe__port3_valid = pe_inst[28].pe__noc__port1_valid ;
  assign pe_inst[29].noc__pe__port3_cntl  = pe_inst[28].pe__noc__port1_cntl  ;
  assign pe_inst[29].noc__pe__port3_data  = pe_inst[28].pe__noc__port1_data  ;
  assign pe_inst[28].noc__pe__port1_fc    = pe_inst[29].pe__noc__port3_fc    ;

  // Connecting PE28 Port2 to PE36 Port0
  assign pe_inst[36].noc__pe__port0_valid = pe_inst[28].pe__noc__port2_valid ;
  assign pe_inst[36].noc__pe__port0_cntl  = pe_inst[28].pe__noc__port2_cntl  ;
  assign pe_inst[36].noc__pe__port0_data  = pe_inst[28].pe__noc__port2_data  ;
  assign pe_inst[28].noc__pe__port2_fc    = pe_inst[36].pe__noc__port0_fc    ;

  // Connecting PE28 Port3 to PE27 Port1
  assign pe_inst[27].noc__pe__port1_valid = pe_inst[28].pe__noc__port3_valid ;
  assign pe_inst[27].noc__pe__port1_cntl  = pe_inst[28].pe__noc__port3_cntl  ;
  assign pe_inst[27].noc__pe__port1_data  = pe_inst[28].pe__noc__port3_data  ;
  assign pe_inst[28].noc__pe__port3_fc    = pe_inst[27].pe__noc__port1_fc    ;

  // Connecting PE29 Port0 to PE21 Port2
  assign pe_inst[21].noc__pe__port2_valid = pe_inst[29].pe__noc__port0_valid ;
  assign pe_inst[21].noc__pe__port2_cntl  = pe_inst[29].pe__noc__port0_cntl  ;
  assign pe_inst[21].noc__pe__port2_data  = pe_inst[29].pe__noc__port0_data  ;
  assign pe_inst[29].noc__pe__port0_fc    = pe_inst[21].pe__noc__port2_fc    ;

  // Connecting PE29 Port1 to PE30 Port3
  assign pe_inst[30].noc__pe__port3_valid = pe_inst[29].pe__noc__port1_valid ;
  assign pe_inst[30].noc__pe__port3_cntl  = pe_inst[29].pe__noc__port1_cntl  ;
  assign pe_inst[30].noc__pe__port3_data  = pe_inst[29].pe__noc__port1_data  ;
  assign pe_inst[29].noc__pe__port1_fc    = pe_inst[30].pe__noc__port3_fc    ;

  // Connecting PE29 Port2 to PE37 Port0
  assign pe_inst[37].noc__pe__port0_valid = pe_inst[29].pe__noc__port2_valid ;
  assign pe_inst[37].noc__pe__port0_cntl  = pe_inst[29].pe__noc__port2_cntl  ;
  assign pe_inst[37].noc__pe__port0_data  = pe_inst[29].pe__noc__port2_data  ;
  assign pe_inst[29].noc__pe__port2_fc    = pe_inst[37].pe__noc__port0_fc    ;

  // Connecting PE29 Port3 to PE28 Port1
  assign pe_inst[28].noc__pe__port1_valid = pe_inst[29].pe__noc__port3_valid ;
  assign pe_inst[28].noc__pe__port1_cntl  = pe_inst[29].pe__noc__port3_cntl  ;
  assign pe_inst[28].noc__pe__port1_data  = pe_inst[29].pe__noc__port3_data  ;
  assign pe_inst[29].noc__pe__port3_fc    = pe_inst[28].pe__noc__port1_fc    ;

  // Connecting PE30 Port0 to PE22 Port2
  assign pe_inst[22].noc__pe__port2_valid = pe_inst[30].pe__noc__port0_valid ;
  assign pe_inst[22].noc__pe__port2_cntl  = pe_inst[30].pe__noc__port0_cntl  ;
  assign pe_inst[22].noc__pe__port2_data  = pe_inst[30].pe__noc__port0_data  ;
  assign pe_inst[30].noc__pe__port0_fc    = pe_inst[22].pe__noc__port2_fc    ;

  // Connecting PE30 Port1 to PE31 Port2
  assign pe_inst[31].noc__pe__port2_valid = pe_inst[30].pe__noc__port1_valid ;
  assign pe_inst[31].noc__pe__port2_cntl  = pe_inst[30].pe__noc__port1_cntl  ;
  assign pe_inst[31].noc__pe__port2_data  = pe_inst[30].pe__noc__port1_data  ;
  assign pe_inst[30].noc__pe__port1_fc    = pe_inst[31].pe__noc__port2_fc    ;

  // Connecting PE30 Port2 to PE38 Port0
  assign pe_inst[38].noc__pe__port0_valid = pe_inst[30].pe__noc__port2_valid ;
  assign pe_inst[38].noc__pe__port0_cntl  = pe_inst[30].pe__noc__port2_cntl  ;
  assign pe_inst[38].noc__pe__port0_data  = pe_inst[30].pe__noc__port2_data  ;
  assign pe_inst[30].noc__pe__port2_fc    = pe_inst[38].pe__noc__port0_fc    ;

  // Connecting PE30 Port3 to PE29 Port1
  assign pe_inst[29].noc__pe__port1_valid = pe_inst[30].pe__noc__port3_valid ;
  assign pe_inst[29].noc__pe__port1_cntl  = pe_inst[30].pe__noc__port3_cntl  ;
  assign pe_inst[29].noc__pe__port1_data  = pe_inst[30].pe__noc__port3_data  ;
  assign pe_inst[30].noc__pe__port3_fc    = pe_inst[29].pe__noc__port1_fc    ;

  // Terminate PE31's 1 unused Ports
  assign pe_inst[31].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[31].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[31].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[31].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE31 Port0 to PE23 Port1
  assign pe_inst[23].noc__pe__port1_valid = pe_inst[31].pe__noc__port0_valid ;
  assign pe_inst[23].noc__pe__port1_cntl  = pe_inst[31].pe__noc__port0_cntl  ;
  assign pe_inst[23].noc__pe__port1_data  = pe_inst[31].pe__noc__port0_data  ;
  assign pe_inst[31].noc__pe__port0_fc    = pe_inst[23].pe__noc__port1_fc    ;

  // Connecting PE31 Port1 to PE39 Port0
  assign pe_inst[39].noc__pe__port0_valid = pe_inst[31].pe__noc__port1_valid ;
  assign pe_inst[39].noc__pe__port0_cntl  = pe_inst[31].pe__noc__port1_cntl  ;
  assign pe_inst[39].noc__pe__port0_data  = pe_inst[31].pe__noc__port1_data  ;
  assign pe_inst[31].noc__pe__port1_fc    = pe_inst[39].pe__noc__port0_fc    ;

  // Connecting PE31 Port2 to PE30 Port1
  assign pe_inst[30].noc__pe__port1_valid = pe_inst[31].pe__noc__port2_valid ;
  assign pe_inst[30].noc__pe__port1_cntl  = pe_inst[31].pe__noc__port2_cntl  ;
  assign pe_inst[30].noc__pe__port1_data  = pe_inst[31].pe__noc__port2_data  ;
  assign pe_inst[31].noc__pe__port2_fc    = pe_inst[30].pe__noc__port1_fc    ;

  // Terminate PE32's 1 unused Ports
  assign pe_inst[32].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[32].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[32].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[32].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE32 Port0 to PE24 Port2
  assign pe_inst[24].noc__pe__port2_valid = pe_inst[32].pe__noc__port0_valid ;
  assign pe_inst[24].noc__pe__port2_cntl  = pe_inst[32].pe__noc__port0_cntl  ;
  assign pe_inst[24].noc__pe__port2_data  = pe_inst[32].pe__noc__port0_data  ;
  assign pe_inst[32].noc__pe__port0_fc    = pe_inst[24].pe__noc__port2_fc    ;

  // Connecting PE32 Port1 to PE33 Port3
  assign pe_inst[33].noc__pe__port3_valid = pe_inst[32].pe__noc__port1_valid ;
  assign pe_inst[33].noc__pe__port3_cntl  = pe_inst[32].pe__noc__port1_cntl  ;
  assign pe_inst[33].noc__pe__port3_data  = pe_inst[32].pe__noc__port1_data  ;
  assign pe_inst[32].noc__pe__port1_fc    = pe_inst[33].pe__noc__port3_fc    ;

  // Connecting PE32 Port2 to PE40 Port0
  assign pe_inst[40].noc__pe__port0_valid = pe_inst[32].pe__noc__port2_valid ;
  assign pe_inst[40].noc__pe__port0_cntl  = pe_inst[32].pe__noc__port2_cntl  ;
  assign pe_inst[40].noc__pe__port0_data  = pe_inst[32].pe__noc__port2_data  ;
  assign pe_inst[32].noc__pe__port2_fc    = pe_inst[40].pe__noc__port0_fc    ;

  // Connecting PE33 Port0 to PE25 Port2
  assign pe_inst[25].noc__pe__port2_valid = pe_inst[33].pe__noc__port0_valid ;
  assign pe_inst[25].noc__pe__port2_cntl  = pe_inst[33].pe__noc__port0_cntl  ;
  assign pe_inst[25].noc__pe__port2_data  = pe_inst[33].pe__noc__port0_data  ;
  assign pe_inst[33].noc__pe__port0_fc    = pe_inst[25].pe__noc__port2_fc    ;

  // Connecting PE33 Port1 to PE34 Port3
  assign pe_inst[34].noc__pe__port3_valid = pe_inst[33].pe__noc__port1_valid ;
  assign pe_inst[34].noc__pe__port3_cntl  = pe_inst[33].pe__noc__port1_cntl  ;
  assign pe_inst[34].noc__pe__port3_data  = pe_inst[33].pe__noc__port1_data  ;
  assign pe_inst[33].noc__pe__port1_fc    = pe_inst[34].pe__noc__port3_fc    ;

  // Connecting PE33 Port2 to PE41 Port0
  assign pe_inst[41].noc__pe__port0_valid = pe_inst[33].pe__noc__port2_valid ;
  assign pe_inst[41].noc__pe__port0_cntl  = pe_inst[33].pe__noc__port2_cntl  ;
  assign pe_inst[41].noc__pe__port0_data  = pe_inst[33].pe__noc__port2_data  ;
  assign pe_inst[33].noc__pe__port2_fc    = pe_inst[41].pe__noc__port0_fc    ;

  // Connecting PE33 Port3 to PE32 Port1
  assign pe_inst[32].noc__pe__port1_valid = pe_inst[33].pe__noc__port3_valid ;
  assign pe_inst[32].noc__pe__port1_cntl  = pe_inst[33].pe__noc__port3_cntl  ;
  assign pe_inst[32].noc__pe__port1_data  = pe_inst[33].pe__noc__port3_data  ;
  assign pe_inst[33].noc__pe__port3_fc    = pe_inst[32].pe__noc__port1_fc    ;

  // Connecting PE34 Port0 to PE26 Port2
  assign pe_inst[26].noc__pe__port2_valid = pe_inst[34].pe__noc__port0_valid ;
  assign pe_inst[26].noc__pe__port2_cntl  = pe_inst[34].pe__noc__port0_cntl  ;
  assign pe_inst[26].noc__pe__port2_data  = pe_inst[34].pe__noc__port0_data  ;
  assign pe_inst[34].noc__pe__port0_fc    = pe_inst[26].pe__noc__port2_fc    ;

  // Connecting PE34 Port1 to PE35 Port3
  assign pe_inst[35].noc__pe__port3_valid = pe_inst[34].pe__noc__port1_valid ;
  assign pe_inst[35].noc__pe__port3_cntl  = pe_inst[34].pe__noc__port1_cntl  ;
  assign pe_inst[35].noc__pe__port3_data  = pe_inst[34].pe__noc__port1_data  ;
  assign pe_inst[34].noc__pe__port1_fc    = pe_inst[35].pe__noc__port3_fc    ;

  // Connecting PE34 Port2 to PE42 Port0
  assign pe_inst[42].noc__pe__port0_valid = pe_inst[34].pe__noc__port2_valid ;
  assign pe_inst[42].noc__pe__port0_cntl  = pe_inst[34].pe__noc__port2_cntl  ;
  assign pe_inst[42].noc__pe__port0_data  = pe_inst[34].pe__noc__port2_data  ;
  assign pe_inst[34].noc__pe__port2_fc    = pe_inst[42].pe__noc__port0_fc    ;

  // Connecting PE34 Port3 to PE33 Port1
  assign pe_inst[33].noc__pe__port1_valid = pe_inst[34].pe__noc__port3_valid ;
  assign pe_inst[33].noc__pe__port1_cntl  = pe_inst[34].pe__noc__port3_cntl  ;
  assign pe_inst[33].noc__pe__port1_data  = pe_inst[34].pe__noc__port3_data  ;
  assign pe_inst[34].noc__pe__port3_fc    = pe_inst[33].pe__noc__port1_fc    ;

  // Connecting PE35 Port0 to PE27 Port2
  assign pe_inst[27].noc__pe__port2_valid = pe_inst[35].pe__noc__port0_valid ;
  assign pe_inst[27].noc__pe__port2_cntl  = pe_inst[35].pe__noc__port0_cntl  ;
  assign pe_inst[27].noc__pe__port2_data  = pe_inst[35].pe__noc__port0_data  ;
  assign pe_inst[35].noc__pe__port0_fc    = pe_inst[27].pe__noc__port2_fc    ;

  // Connecting PE35 Port1 to PE36 Port3
  assign pe_inst[36].noc__pe__port3_valid = pe_inst[35].pe__noc__port1_valid ;
  assign pe_inst[36].noc__pe__port3_cntl  = pe_inst[35].pe__noc__port1_cntl  ;
  assign pe_inst[36].noc__pe__port3_data  = pe_inst[35].pe__noc__port1_data  ;
  assign pe_inst[35].noc__pe__port1_fc    = pe_inst[36].pe__noc__port3_fc    ;

  // Connecting PE35 Port2 to PE43 Port0
  assign pe_inst[43].noc__pe__port0_valid = pe_inst[35].pe__noc__port2_valid ;
  assign pe_inst[43].noc__pe__port0_cntl  = pe_inst[35].pe__noc__port2_cntl  ;
  assign pe_inst[43].noc__pe__port0_data  = pe_inst[35].pe__noc__port2_data  ;
  assign pe_inst[35].noc__pe__port2_fc    = pe_inst[43].pe__noc__port0_fc    ;

  // Connecting PE35 Port3 to PE34 Port1
  assign pe_inst[34].noc__pe__port1_valid = pe_inst[35].pe__noc__port3_valid ;
  assign pe_inst[34].noc__pe__port1_cntl  = pe_inst[35].pe__noc__port3_cntl  ;
  assign pe_inst[34].noc__pe__port1_data  = pe_inst[35].pe__noc__port3_data  ;
  assign pe_inst[35].noc__pe__port3_fc    = pe_inst[34].pe__noc__port1_fc    ;

  // Connecting PE36 Port0 to PE28 Port2
  assign pe_inst[28].noc__pe__port2_valid = pe_inst[36].pe__noc__port0_valid ;
  assign pe_inst[28].noc__pe__port2_cntl  = pe_inst[36].pe__noc__port0_cntl  ;
  assign pe_inst[28].noc__pe__port2_data  = pe_inst[36].pe__noc__port0_data  ;
  assign pe_inst[36].noc__pe__port0_fc    = pe_inst[28].pe__noc__port2_fc    ;

  // Connecting PE36 Port1 to PE37 Port3
  assign pe_inst[37].noc__pe__port3_valid = pe_inst[36].pe__noc__port1_valid ;
  assign pe_inst[37].noc__pe__port3_cntl  = pe_inst[36].pe__noc__port1_cntl  ;
  assign pe_inst[37].noc__pe__port3_data  = pe_inst[36].pe__noc__port1_data  ;
  assign pe_inst[36].noc__pe__port1_fc    = pe_inst[37].pe__noc__port3_fc    ;

  // Connecting PE36 Port2 to PE44 Port0
  assign pe_inst[44].noc__pe__port0_valid = pe_inst[36].pe__noc__port2_valid ;
  assign pe_inst[44].noc__pe__port0_cntl  = pe_inst[36].pe__noc__port2_cntl  ;
  assign pe_inst[44].noc__pe__port0_data  = pe_inst[36].pe__noc__port2_data  ;
  assign pe_inst[36].noc__pe__port2_fc    = pe_inst[44].pe__noc__port0_fc    ;

  // Connecting PE36 Port3 to PE35 Port1
  assign pe_inst[35].noc__pe__port1_valid = pe_inst[36].pe__noc__port3_valid ;
  assign pe_inst[35].noc__pe__port1_cntl  = pe_inst[36].pe__noc__port3_cntl  ;
  assign pe_inst[35].noc__pe__port1_data  = pe_inst[36].pe__noc__port3_data  ;
  assign pe_inst[36].noc__pe__port3_fc    = pe_inst[35].pe__noc__port1_fc    ;

  // Connecting PE37 Port0 to PE29 Port2
  assign pe_inst[29].noc__pe__port2_valid = pe_inst[37].pe__noc__port0_valid ;
  assign pe_inst[29].noc__pe__port2_cntl  = pe_inst[37].pe__noc__port0_cntl  ;
  assign pe_inst[29].noc__pe__port2_data  = pe_inst[37].pe__noc__port0_data  ;
  assign pe_inst[37].noc__pe__port0_fc    = pe_inst[29].pe__noc__port2_fc    ;

  // Connecting PE37 Port1 to PE38 Port3
  assign pe_inst[38].noc__pe__port3_valid = pe_inst[37].pe__noc__port1_valid ;
  assign pe_inst[38].noc__pe__port3_cntl  = pe_inst[37].pe__noc__port1_cntl  ;
  assign pe_inst[38].noc__pe__port3_data  = pe_inst[37].pe__noc__port1_data  ;
  assign pe_inst[37].noc__pe__port1_fc    = pe_inst[38].pe__noc__port3_fc    ;

  // Connecting PE37 Port2 to PE45 Port0
  assign pe_inst[45].noc__pe__port0_valid = pe_inst[37].pe__noc__port2_valid ;
  assign pe_inst[45].noc__pe__port0_cntl  = pe_inst[37].pe__noc__port2_cntl  ;
  assign pe_inst[45].noc__pe__port0_data  = pe_inst[37].pe__noc__port2_data  ;
  assign pe_inst[37].noc__pe__port2_fc    = pe_inst[45].pe__noc__port0_fc    ;

  // Connecting PE37 Port3 to PE36 Port1
  assign pe_inst[36].noc__pe__port1_valid = pe_inst[37].pe__noc__port3_valid ;
  assign pe_inst[36].noc__pe__port1_cntl  = pe_inst[37].pe__noc__port3_cntl  ;
  assign pe_inst[36].noc__pe__port1_data  = pe_inst[37].pe__noc__port3_data  ;
  assign pe_inst[37].noc__pe__port3_fc    = pe_inst[36].pe__noc__port1_fc    ;

  // Connecting PE38 Port0 to PE30 Port2
  assign pe_inst[30].noc__pe__port2_valid = pe_inst[38].pe__noc__port0_valid ;
  assign pe_inst[30].noc__pe__port2_cntl  = pe_inst[38].pe__noc__port0_cntl  ;
  assign pe_inst[30].noc__pe__port2_data  = pe_inst[38].pe__noc__port0_data  ;
  assign pe_inst[38].noc__pe__port0_fc    = pe_inst[30].pe__noc__port2_fc    ;

  // Connecting PE38 Port1 to PE39 Port2
  assign pe_inst[39].noc__pe__port2_valid = pe_inst[38].pe__noc__port1_valid ;
  assign pe_inst[39].noc__pe__port2_cntl  = pe_inst[38].pe__noc__port1_cntl  ;
  assign pe_inst[39].noc__pe__port2_data  = pe_inst[38].pe__noc__port1_data  ;
  assign pe_inst[38].noc__pe__port1_fc    = pe_inst[39].pe__noc__port2_fc    ;

  // Connecting PE38 Port2 to PE46 Port0
  assign pe_inst[46].noc__pe__port0_valid = pe_inst[38].pe__noc__port2_valid ;
  assign pe_inst[46].noc__pe__port0_cntl  = pe_inst[38].pe__noc__port2_cntl  ;
  assign pe_inst[46].noc__pe__port0_data  = pe_inst[38].pe__noc__port2_data  ;
  assign pe_inst[38].noc__pe__port2_fc    = pe_inst[46].pe__noc__port0_fc    ;

  // Connecting PE38 Port3 to PE37 Port1
  assign pe_inst[37].noc__pe__port1_valid = pe_inst[38].pe__noc__port3_valid ;
  assign pe_inst[37].noc__pe__port1_cntl  = pe_inst[38].pe__noc__port3_cntl  ;
  assign pe_inst[37].noc__pe__port1_data  = pe_inst[38].pe__noc__port3_data  ;
  assign pe_inst[38].noc__pe__port3_fc    = pe_inst[37].pe__noc__port1_fc    ;

  // Terminate PE39's 1 unused Ports
  assign pe_inst[39].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[39].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[39].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[39].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE39 Port0 to PE31 Port1
  assign pe_inst[31].noc__pe__port1_valid = pe_inst[39].pe__noc__port0_valid ;
  assign pe_inst[31].noc__pe__port1_cntl  = pe_inst[39].pe__noc__port0_cntl  ;
  assign pe_inst[31].noc__pe__port1_data  = pe_inst[39].pe__noc__port0_data  ;
  assign pe_inst[39].noc__pe__port0_fc    = pe_inst[31].pe__noc__port1_fc    ;

  // Connecting PE39 Port1 to PE47 Port0
  assign pe_inst[47].noc__pe__port0_valid = pe_inst[39].pe__noc__port1_valid ;
  assign pe_inst[47].noc__pe__port0_cntl  = pe_inst[39].pe__noc__port1_cntl  ;
  assign pe_inst[47].noc__pe__port0_data  = pe_inst[39].pe__noc__port1_data  ;
  assign pe_inst[39].noc__pe__port1_fc    = pe_inst[47].pe__noc__port0_fc    ;

  // Connecting PE39 Port2 to PE38 Port1
  assign pe_inst[38].noc__pe__port1_valid = pe_inst[39].pe__noc__port2_valid ;
  assign pe_inst[38].noc__pe__port1_cntl  = pe_inst[39].pe__noc__port2_cntl  ;
  assign pe_inst[38].noc__pe__port1_data  = pe_inst[39].pe__noc__port2_data  ;
  assign pe_inst[39].noc__pe__port2_fc    = pe_inst[38].pe__noc__port1_fc    ;

  // Terminate PE40's 1 unused Ports
  assign pe_inst[40].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[40].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[40].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[40].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE40 Port0 to PE32 Port2
  assign pe_inst[32].noc__pe__port2_valid = pe_inst[40].pe__noc__port0_valid ;
  assign pe_inst[32].noc__pe__port2_cntl  = pe_inst[40].pe__noc__port0_cntl  ;
  assign pe_inst[32].noc__pe__port2_data  = pe_inst[40].pe__noc__port0_data  ;
  assign pe_inst[40].noc__pe__port0_fc    = pe_inst[32].pe__noc__port2_fc    ;

  // Connecting PE40 Port1 to PE41 Port3
  assign pe_inst[41].noc__pe__port3_valid = pe_inst[40].pe__noc__port1_valid ;
  assign pe_inst[41].noc__pe__port3_cntl  = pe_inst[40].pe__noc__port1_cntl  ;
  assign pe_inst[41].noc__pe__port3_data  = pe_inst[40].pe__noc__port1_data  ;
  assign pe_inst[40].noc__pe__port1_fc    = pe_inst[41].pe__noc__port3_fc    ;

  // Connecting PE40 Port2 to PE48 Port0
  assign pe_inst[48].noc__pe__port0_valid = pe_inst[40].pe__noc__port2_valid ;
  assign pe_inst[48].noc__pe__port0_cntl  = pe_inst[40].pe__noc__port2_cntl  ;
  assign pe_inst[48].noc__pe__port0_data  = pe_inst[40].pe__noc__port2_data  ;
  assign pe_inst[40].noc__pe__port2_fc    = pe_inst[48].pe__noc__port0_fc    ;

  // Connecting PE41 Port0 to PE33 Port2
  assign pe_inst[33].noc__pe__port2_valid = pe_inst[41].pe__noc__port0_valid ;
  assign pe_inst[33].noc__pe__port2_cntl  = pe_inst[41].pe__noc__port0_cntl  ;
  assign pe_inst[33].noc__pe__port2_data  = pe_inst[41].pe__noc__port0_data  ;
  assign pe_inst[41].noc__pe__port0_fc    = pe_inst[33].pe__noc__port2_fc    ;

  // Connecting PE41 Port1 to PE42 Port3
  assign pe_inst[42].noc__pe__port3_valid = pe_inst[41].pe__noc__port1_valid ;
  assign pe_inst[42].noc__pe__port3_cntl  = pe_inst[41].pe__noc__port1_cntl  ;
  assign pe_inst[42].noc__pe__port3_data  = pe_inst[41].pe__noc__port1_data  ;
  assign pe_inst[41].noc__pe__port1_fc    = pe_inst[42].pe__noc__port3_fc    ;

  // Connecting PE41 Port2 to PE49 Port0
  assign pe_inst[49].noc__pe__port0_valid = pe_inst[41].pe__noc__port2_valid ;
  assign pe_inst[49].noc__pe__port0_cntl  = pe_inst[41].pe__noc__port2_cntl  ;
  assign pe_inst[49].noc__pe__port0_data  = pe_inst[41].pe__noc__port2_data  ;
  assign pe_inst[41].noc__pe__port2_fc    = pe_inst[49].pe__noc__port0_fc    ;

  // Connecting PE41 Port3 to PE40 Port1
  assign pe_inst[40].noc__pe__port1_valid = pe_inst[41].pe__noc__port3_valid ;
  assign pe_inst[40].noc__pe__port1_cntl  = pe_inst[41].pe__noc__port3_cntl  ;
  assign pe_inst[40].noc__pe__port1_data  = pe_inst[41].pe__noc__port3_data  ;
  assign pe_inst[41].noc__pe__port3_fc    = pe_inst[40].pe__noc__port1_fc    ;

  // Connecting PE42 Port0 to PE34 Port2
  assign pe_inst[34].noc__pe__port2_valid = pe_inst[42].pe__noc__port0_valid ;
  assign pe_inst[34].noc__pe__port2_cntl  = pe_inst[42].pe__noc__port0_cntl  ;
  assign pe_inst[34].noc__pe__port2_data  = pe_inst[42].pe__noc__port0_data  ;
  assign pe_inst[42].noc__pe__port0_fc    = pe_inst[34].pe__noc__port2_fc    ;

  // Connecting PE42 Port1 to PE43 Port3
  assign pe_inst[43].noc__pe__port3_valid = pe_inst[42].pe__noc__port1_valid ;
  assign pe_inst[43].noc__pe__port3_cntl  = pe_inst[42].pe__noc__port1_cntl  ;
  assign pe_inst[43].noc__pe__port3_data  = pe_inst[42].pe__noc__port1_data  ;
  assign pe_inst[42].noc__pe__port1_fc    = pe_inst[43].pe__noc__port3_fc    ;

  // Connecting PE42 Port2 to PE50 Port0
  assign pe_inst[50].noc__pe__port0_valid = pe_inst[42].pe__noc__port2_valid ;
  assign pe_inst[50].noc__pe__port0_cntl  = pe_inst[42].pe__noc__port2_cntl  ;
  assign pe_inst[50].noc__pe__port0_data  = pe_inst[42].pe__noc__port2_data  ;
  assign pe_inst[42].noc__pe__port2_fc    = pe_inst[50].pe__noc__port0_fc    ;

  // Connecting PE42 Port3 to PE41 Port1
  assign pe_inst[41].noc__pe__port1_valid = pe_inst[42].pe__noc__port3_valid ;
  assign pe_inst[41].noc__pe__port1_cntl  = pe_inst[42].pe__noc__port3_cntl  ;
  assign pe_inst[41].noc__pe__port1_data  = pe_inst[42].pe__noc__port3_data  ;
  assign pe_inst[42].noc__pe__port3_fc    = pe_inst[41].pe__noc__port1_fc    ;

  // Connecting PE43 Port0 to PE35 Port2
  assign pe_inst[35].noc__pe__port2_valid = pe_inst[43].pe__noc__port0_valid ;
  assign pe_inst[35].noc__pe__port2_cntl  = pe_inst[43].pe__noc__port0_cntl  ;
  assign pe_inst[35].noc__pe__port2_data  = pe_inst[43].pe__noc__port0_data  ;
  assign pe_inst[43].noc__pe__port0_fc    = pe_inst[35].pe__noc__port2_fc    ;

  // Connecting PE43 Port1 to PE44 Port3
  assign pe_inst[44].noc__pe__port3_valid = pe_inst[43].pe__noc__port1_valid ;
  assign pe_inst[44].noc__pe__port3_cntl  = pe_inst[43].pe__noc__port1_cntl  ;
  assign pe_inst[44].noc__pe__port3_data  = pe_inst[43].pe__noc__port1_data  ;
  assign pe_inst[43].noc__pe__port1_fc    = pe_inst[44].pe__noc__port3_fc    ;

  // Connecting PE43 Port2 to PE51 Port0
  assign pe_inst[51].noc__pe__port0_valid = pe_inst[43].pe__noc__port2_valid ;
  assign pe_inst[51].noc__pe__port0_cntl  = pe_inst[43].pe__noc__port2_cntl  ;
  assign pe_inst[51].noc__pe__port0_data  = pe_inst[43].pe__noc__port2_data  ;
  assign pe_inst[43].noc__pe__port2_fc    = pe_inst[51].pe__noc__port0_fc    ;

  // Connecting PE43 Port3 to PE42 Port1
  assign pe_inst[42].noc__pe__port1_valid = pe_inst[43].pe__noc__port3_valid ;
  assign pe_inst[42].noc__pe__port1_cntl  = pe_inst[43].pe__noc__port3_cntl  ;
  assign pe_inst[42].noc__pe__port1_data  = pe_inst[43].pe__noc__port3_data  ;
  assign pe_inst[43].noc__pe__port3_fc    = pe_inst[42].pe__noc__port1_fc    ;

  // Connecting PE44 Port0 to PE36 Port2
  assign pe_inst[36].noc__pe__port2_valid = pe_inst[44].pe__noc__port0_valid ;
  assign pe_inst[36].noc__pe__port2_cntl  = pe_inst[44].pe__noc__port0_cntl  ;
  assign pe_inst[36].noc__pe__port2_data  = pe_inst[44].pe__noc__port0_data  ;
  assign pe_inst[44].noc__pe__port0_fc    = pe_inst[36].pe__noc__port2_fc    ;

  // Connecting PE44 Port1 to PE45 Port3
  assign pe_inst[45].noc__pe__port3_valid = pe_inst[44].pe__noc__port1_valid ;
  assign pe_inst[45].noc__pe__port3_cntl  = pe_inst[44].pe__noc__port1_cntl  ;
  assign pe_inst[45].noc__pe__port3_data  = pe_inst[44].pe__noc__port1_data  ;
  assign pe_inst[44].noc__pe__port1_fc    = pe_inst[45].pe__noc__port3_fc    ;

  // Connecting PE44 Port2 to PE52 Port0
  assign pe_inst[52].noc__pe__port0_valid = pe_inst[44].pe__noc__port2_valid ;
  assign pe_inst[52].noc__pe__port0_cntl  = pe_inst[44].pe__noc__port2_cntl  ;
  assign pe_inst[52].noc__pe__port0_data  = pe_inst[44].pe__noc__port2_data  ;
  assign pe_inst[44].noc__pe__port2_fc    = pe_inst[52].pe__noc__port0_fc    ;

  // Connecting PE44 Port3 to PE43 Port1
  assign pe_inst[43].noc__pe__port1_valid = pe_inst[44].pe__noc__port3_valid ;
  assign pe_inst[43].noc__pe__port1_cntl  = pe_inst[44].pe__noc__port3_cntl  ;
  assign pe_inst[43].noc__pe__port1_data  = pe_inst[44].pe__noc__port3_data  ;
  assign pe_inst[44].noc__pe__port3_fc    = pe_inst[43].pe__noc__port1_fc    ;

  // Connecting PE45 Port0 to PE37 Port2
  assign pe_inst[37].noc__pe__port2_valid = pe_inst[45].pe__noc__port0_valid ;
  assign pe_inst[37].noc__pe__port2_cntl  = pe_inst[45].pe__noc__port0_cntl  ;
  assign pe_inst[37].noc__pe__port2_data  = pe_inst[45].pe__noc__port0_data  ;
  assign pe_inst[45].noc__pe__port0_fc    = pe_inst[37].pe__noc__port2_fc    ;

  // Connecting PE45 Port1 to PE46 Port3
  assign pe_inst[46].noc__pe__port3_valid = pe_inst[45].pe__noc__port1_valid ;
  assign pe_inst[46].noc__pe__port3_cntl  = pe_inst[45].pe__noc__port1_cntl  ;
  assign pe_inst[46].noc__pe__port3_data  = pe_inst[45].pe__noc__port1_data  ;
  assign pe_inst[45].noc__pe__port1_fc    = pe_inst[46].pe__noc__port3_fc    ;

  // Connecting PE45 Port2 to PE53 Port0
  assign pe_inst[53].noc__pe__port0_valid = pe_inst[45].pe__noc__port2_valid ;
  assign pe_inst[53].noc__pe__port0_cntl  = pe_inst[45].pe__noc__port2_cntl  ;
  assign pe_inst[53].noc__pe__port0_data  = pe_inst[45].pe__noc__port2_data  ;
  assign pe_inst[45].noc__pe__port2_fc    = pe_inst[53].pe__noc__port0_fc    ;

  // Connecting PE45 Port3 to PE44 Port1
  assign pe_inst[44].noc__pe__port1_valid = pe_inst[45].pe__noc__port3_valid ;
  assign pe_inst[44].noc__pe__port1_cntl  = pe_inst[45].pe__noc__port3_cntl  ;
  assign pe_inst[44].noc__pe__port1_data  = pe_inst[45].pe__noc__port3_data  ;
  assign pe_inst[45].noc__pe__port3_fc    = pe_inst[44].pe__noc__port1_fc    ;

  // Connecting PE46 Port0 to PE38 Port2
  assign pe_inst[38].noc__pe__port2_valid = pe_inst[46].pe__noc__port0_valid ;
  assign pe_inst[38].noc__pe__port2_cntl  = pe_inst[46].pe__noc__port0_cntl  ;
  assign pe_inst[38].noc__pe__port2_data  = pe_inst[46].pe__noc__port0_data  ;
  assign pe_inst[46].noc__pe__port0_fc    = pe_inst[38].pe__noc__port2_fc    ;

  // Connecting PE46 Port1 to PE47 Port2
  assign pe_inst[47].noc__pe__port2_valid = pe_inst[46].pe__noc__port1_valid ;
  assign pe_inst[47].noc__pe__port2_cntl  = pe_inst[46].pe__noc__port1_cntl  ;
  assign pe_inst[47].noc__pe__port2_data  = pe_inst[46].pe__noc__port1_data  ;
  assign pe_inst[46].noc__pe__port1_fc    = pe_inst[47].pe__noc__port2_fc    ;

  // Connecting PE46 Port2 to PE54 Port0
  assign pe_inst[54].noc__pe__port0_valid = pe_inst[46].pe__noc__port2_valid ;
  assign pe_inst[54].noc__pe__port0_cntl  = pe_inst[46].pe__noc__port2_cntl  ;
  assign pe_inst[54].noc__pe__port0_data  = pe_inst[46].pe__noc__port2_data  ;
  assign pe_inst[46].noc__pe__port2_fc    = pe_inst[54].pe__noc__port0_fc    ;

  // Connecting PE46 Port3 to PE45 Port1
  assign pe_inst[45].noc__pe__port1_valid = pe_inst[46].pe__noc__port3_valid ;
  assign pe_inst[45].noc__pe__port1_cntl  = pe_inst[46].pe__noc__port3_cntl  ;
  assign pe_inst[45].noc__pe__port1_data  = pe_inst[46].pe__noc__port3_data  ;
  assign pe_inst[46].noc__pe__port3_fc    = pe_inst[45].pe__noc__port1_fc    ;

  // Terminate PE47's 1 unused Ports
  assign pe_inst[47].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[47].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[47].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[47].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE47 Port0 to PE39 Port1
  assign pe_inst[39].noc__pe__port1_valid = pe_inst[47].pe__noc__port0_valid ;
  assign pe_inst[39].noc__pe__port1_cntl  = pe_inst[47].pe__noc__port0_cntl  ;
  assign pe_inst[39].noc__pe__port1_data  = pe_inst[47].pe__noc__port0_data  ;
  assign pe_inst[47].noc__pe__port0_fc    = pe_inst[39].pe__noc__port1_fc    ;

  // Connecting PE47 Port1 to PE55 Port0
  assign pe_inst[55].noc__pe__port0_valid = pe_inst[47].pe__noc__port1_valid ;
  assign pe_inst[55].noc__pe__port0_cntl  = pe_inst[47].pe__noc__port1_cntl  ;
  assign pe_inst[55].noc__pe__port0_data  = pe_inst[47].pe__noc__port1_data  ;
  assign pe_inst[47].noc__pe__port1_fc    = pe_inst[55].pe__noc__port0_fc    ;

  // Connecting PE47 Port2 to PE46 Port1
  assign pe_inst[46].noc__pe__port1_valid = pe_inst[47].pe__noc__port2_valid ;
  assign pe_inst[46].noc__pe__port1_cntl  = pe_inst[47].pe__noc__port2_cntl  ;
  assign pe_inst[46].noc__pe__port1_data  = pe_inst[47].pe__noc__port2_data  ;
  assign pe_inst[47].noc__pe__port2_fc    = pe_inst[46].pe__noc__port1_fc    ;

  // Terminate PE48's 1 unused Ports
  assign pe_inst[48].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[48].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[48].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[48].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE48 Port0 to PE40 Port2
  assign pe_inst[40].noc__pe__port2_valid = pe_inst[48].pe__noc__port0_valid ;
  assign pe_inst[40].noc__pe__port2_cntl  = pe_inst[48].pe__noc__port0_cntl  ;
  assign pe_inst[40].noc__pe__port2_data  = pe_inst[48].pe__noc__port0_data  ;
  assign pe_inst[48].noc__pe__port0_fc    = pe_inst[40].pe__noc__port2_fc    ;

  // Connecting PE48 Port1 to PE49 Port3
  assign pe_inst[49].noc__pe__port3_valid = pe_inst[48].pe__noc__port1_valid ;
  assign pe_inst[49].noc__pe__port3_cntl  = pe_inst[48].pe__noc__port1_cntl  ;
  assign pe_inst[49].noc__pe__port3_data  = pe_inst[48].pe__noc__port1_data  ;
  assign pe_inst[48].noc__pe__port1_fc    = pe_inst[49].pe__noc__port3_fc    ;

  // Connecting PE48 Port2 to PE56 Port0
  assign pe_inst[56].noc__pe__port0_valid = pe_inst[48].pe__noc__port2_valid ;
  assign pe_inst[56].noc__pe__port0_cntl  = pe_inst[48].pe__noc__port2_cntl  ;
  assign pe_inst[56].noc__pe__port0_data  = pe_inst[48].pe__noc__port2_data  ;
  assign pe_inst[48].noc__pe__port2_fc    = pe_inst[56].pe__noc__port0_fc    ;

  // Connecting PE49 Port0 to PE41 Port2
  assign pe_inst[41].noc__pe__port2_valid = pe_inst[49].pe__noc__port0_valid ;
  assign pe_inst[41].noc__pe__port2_cntl  = pe_inst[49].pe__noc__port0_cntl  ;
  assign pe_inst[41].noc__pe__port2_data  = pe_inst[49].pe__noc__port0_data  ;
  assign pe_inst[49].noc__pe__port0_fc    = pe_inst[41].pe__noc__port2_fc    ;

  // Connecting PE49 Port1 to PE50 Port3
  assign pe_inst[50].noc__pe__port3_valid = pe_inst[49].pe__noc__port1_valid ;
  assign pe_inst[50].noc__pe__port3_cntl  = pe_inst[49].pe__noc__port1_cntl  ;
  assign pe_inst[50].noc__pe__port3_data  = pe_inst[49].pe__noc__port1_data  ;
  assign pe_inst[49].noc__pe__port1_fc    = pe_inst[50].pe__noc__port3_fc    ;

  // Connecting PE49 Port2 to PE57 Port0
  assign pe_inst[57].noc__pe__port0_valid = pe_inst[49].pe__noc__port2_valid ;
  assign pe_inst[57].noc__pe__port0_cntl  = pe_inst[49].pe__noc__port2_cntl  ;
  assign pe_inst[57].noc__pe__port0_data  = pe_inst[49].pe__noc__port2_data  ;
  assign pe_inst[49].noc__pe__port2_fc    = pe_inst[57].pe__noc__port0_fc    ;

  // Connecting PE49 Port3 to PE48 Port1
  assign pe_inst[48].noc__pe__port1_valid = pe_inst[49].pe__noc__port3_valid ;
  assign pe_inst[48].noc__pe__port1_cntl  = pe_inst[49].pe__noc__port3_cntl  ;
  assign pe_inst[48].noc__pe__port1_data  = pe_inst[49].pe__noc__port3_data  ;
  assign pe_inst[49].noc__pe__port3_fc    = pe_inst[48].pe__noc__port1_fc    ;

  // Connecting PE50 Port0 to PE42 Port2
  assign pe_inst[42].noc__pe__port2_valid = pe_inst[50].pe__noc__port0_valid ;
  assign pe_inst[42].noc__pe__port2_cntl  = pe_inst[50].pe__noc__port0_cntl  ;
  assign pe_inst[42].noc__pe__port2_data  = pe_inst[50].pe__noc__port0_data  ;
  assign pe_inst[50].noc__pe__port0_fc    = pe_inst[42].pe__noc__port2_fc    ;

  // Connecting PE50 Port1 to PE51 Port3
  assign pe_inst[51].noc__pe__port3_valid = pe_inst[50].pe__noc__port1_valid ;
  assign pe_inst[51].noc__pe__port3_cntl  = pe_inst[50].pe__noc__port1_cntl  ;
  assign pe_inst[51].noc__pe__port3_data  = pe_inst[50].pe__noc__port1_data  ;
  assign pe_inst[50].noc__pe__port1_fc    = pe_inst[51].pe__noc__port3_fc    ;

  // Connecting PE50 Port2 to PE58 Port0
  assign pe_inst[58].noc__pe__port0_valid = pe_inst[50].pe__noc__port2_valid ;
  assign pe_inst[58].noc__pe__port0_cntl  = pe_inst[50].pe__noc__port2_cntl  ;
  assign pe_inst[58].noc__pe__port0_data  = pe_inst[50].pe__noc__port2_data  ;
  assign pe_inst[50].noc__pe__port2_fc    = pe_inst[58].pe__noc__port0_fc    ;

  // Connecting PE50 Port3 to PE49 Port1
  assign pe_inst[49].noc__pe__port1_valid = pe_inst[50].pe__noc__port3_valid ;
  assign pe_inst[49].noc__pe__port1_cntl  = pe_inst[50].pe__noc__port3_cntl  ;
  assign pe_inst[49].noc__pe__port1_data  = pe_inst[50].pe__noc__port3_data  ;
  assign pe_inst[50].noc__pe__port3_fc    = pe_inst[49].pe__noc__port1_fc    ;

  // Connecting PE51 Port0 to PE43 Port2
  assign pe_inst[43].noc__pe__port2_valid = pe_inst[51].pe__noc__port0_valid ;
  assign pe_inst[43].noc__pe__port2_cntl  = pe_inst[51].pe__noc__port0_cntl  ;
  assign pe_inst[43].noc__pe__port2_data  = pe_inst[51].pe__noc__port0_data  ;
  assign pe_inst[51].noc__pe__port0_fc    = pe_inst[43].pe__noc__port2_fc    ;

  // Connecting PE51 Port1 to PE52 Port3
  assign pe_inst[52].noc__pe__port3_valid = pe_inst[51].pe__noc__port1_valid ;
  assign pe_inst[52].noc__pe__port3_cntl  = pe_inst[51].pe__noc__port1_cntl  ;
  assign pe_inst[52].noc__pe__port3_data  = pe_inst[51].pe__noc__port1_data  ;
  assign pe_inst[51].noc__pe__port1_fc    = pe_inst[52].pe__noc__port3_fc    ;

  // Connecting PE51 Port2 to PE59 Port0
  assign pe_inst[59].noc__pe__port0_valid = pe_inst[51].pe__noc__port2_valid ;
  assign pe_inst[59].noc__pe__port0_cntl  = pe_inst[51].pe__noc__port2_cntl  ;
  assign pe_inst[59].noc__pe__port0_data  = pe_inst[51].pe__noc__port2_data  ;
  assign pe_inst[51].noc__pe__port2_fc    = pe_inst[59].pe__noc__port0_fc    ;

  // Connecting PE51 Port3 to PE50 Port1
  assign pe_inst[50].noc__pe__port1_valid = pe_inst[51].pe__noc__port3_valid ;
  assign pe_inst[50].noc__pe__port1_cntl  = pe_inst[51].pe__noc__port3_cntl  ;
  assign pe_inst[50].noc__pe__port1_data  = pe_inst[51].pe__noc__port3_data  ;
  assign pe_inst[51].noc__pe__port3_fc    = pe_inst[50].pe__noc__port1_fc    ;

  // Connecting PE52 Port0 to PE44 Port2
  assign pe_inst[44].noc__pe__port2_valid = pe_inst[52].pe__noc__port0_valid ;
  assign pe_inst[44].noc__pe__port2_cntl  = pe_inst[52].pe__noc__port0_cntl  ;
  assign pe_inst[44].noc__pe__port2_data  = pe_inst[52].pe__noc__port0_data  ;
  assign pe_inst[52].noc__pe__port0_fc    = pe_inst[44].pe__noc__port2_fc    ;

  // Connecting PE52 Port1 to PE53 Port3
  assign pe_inst[53].noc__pe__port3_valid = pe_inst[52].pe__noc__port1_valid ;
  assign pe_inst[53].noc__pe__port3_cntl  = pe_inst[52].pe__noc__port1_cntl  ;
  assign pe_inst[53].noc__pe__port3_data  = pe_inst[52].pe__noc__port1_data  ;
  assign pe_inst[52].noc__pe__port1_fc    = pe_inst[53].pe__noc__port3_fc    ;

  // Connecting PE52 Port2 to PE60 Port0
  assign pe_inst[60].noc__pe__port0_valid = pe_inst[52].pe__noc__port2_valid ;
  assign pe_inst[60].noc__pe__port0_cntl  = pe_inst[52].pe__noc__port2_cntl  ;
  assign pe_inst[60].noc__pe__port0_data  = pe_inst[52].pe__noc__port2_data  ;
  assign pe_inst[52].noc__pe__port2_fc    = pe_inst[60].pe__noc__port0_fc    ;

  // Connecting PE52 Port3 to PE51 Port1
  assign pe_inst[51].noc__pe__port1_valid = pe_inst[52].pe__noc__port3_valid ;
  assign pe_inst[51].noc__pe__port1_cntl  = pe_inst[52].pe__noc__port3_cntl  ;
  assign pe_inst[51].noc__pe__port1_data  = pe_inst[52].pe__noc__port3_data  ;
  assign pe_inst[52].noc__pe__port3_fc    = pe_inst[51].pe__noc__port1_fc    ;

  // Connecting PE53 Port0 to PE45 Port2
  assign pe_inst[45].noc__pe__port2_valid = pe_inst[53].pe__noc__port0_valid ;
  assign pe_inst[45].noc__pe__port2_cntl  = pe_inst[53].pe__noc__port0_cntl  ;
  assign pe_inst[45].noc__pe__port2_data  = pe_inst[53].pe__noc__port0_data  ;
  assign pe_inst[53].noc__pe__port0_fc    = pe_inst[45].pe__noc__port2_fc    ;

  // Connecting PE53 Port1 to PE54 Port3
  assign pe_inst[54].noc__pe__port3_valid = pe_inst[53].pe__noc__port1_valid ;
  assign pe_inst[54].noc__pe__port3_cntl  = pe_inst[53].pe__noc__port1_cntl  ;
  assign pe_inst[54].noc__pe__port3_data  = pe_inst[53].pe__noc__port1_data  ;
  assign pe_inst[53].noc__pe__port1_fc    = pe_inst[54].pe__noc__port3_fc    ;

  // Connecting PE53 Port2 to PE61 Port0
  assign pe_inst[61].noc__pe__port0_valid = pe_inst[53].pe__noc__port2_valid ;
  assign pe_inst[61].noc__pe__port0_cntl  = pe_inst[53].pe__noc__port2_cntl  ;
  assign pe_inst[61].noc__pe__port0_data  = pe_inst[53].pe__noc__port2_data  ;
  assign pe_inst[53].noc__pe__port2_fc    = pe_inst[61].pe__noc__port0_fc    ;

  // Connecting PE53 Port3 to PE52 Port1
  assign pe_inst[52].noc__pe__port1_valid = pe_inst[53].pe__noc__port3_valid ;
  assign pe_inst[52].noc__pe__port1_cntl  = pe_inst[53].pe__noc__port3_cntl  ;
  assign pe_inst[52].noc__pe__port1_data  = pe_inst[53].pe__noc__port3_data  ;
  assign pe_inst[53].noc__pe__port3_fc    = pe_inst[52].pe__noc__port1_fc    ;

  // Connecting PE54 Port0 to PE46 Port2
  assign pe_inst[46].noc__pe__port2_valid = pe_inst[54].pe__noc__port0_valid ;
  assign pe_inst[46].noc__pe__port2_cntl  = pe_inst[54].pe__noc__port0_cntl  ;
  assign pe_inst[46].noc__pe__port2_data  = pe_inst[54].pe__noc__port0_data  ;
  assign pe_inst[54].noc__pe__port0_fc    = pe_inst[46].pe__noc__port2_fc    ;

  // Connecting PE54 Port1 to PE55 Port2
  assign pe_inst[55].noc__pe__port2_valid = pe_inst[54].pe__noc__port1_valid ;
  assign pe_inst[55].noc__pe__port2_cntl  = pe_inst[54].pe__noc__port1_cntl  ;
  assign pe_inst[55].noc__pe__port2_data  = pe_inst[54].pe__noc__port1_data  ;
  assign pe_inst[54].noc__pe__port1_fc    = pe_inst[55].pe__noc__port2_fc    ;

  // Connecting PE54 Port2 to PE62 Port0
  assign pe_inst[62].noc__pe__port0_valid = pe_inst[54].pe__noc__port2_valid ;
  assign pe_inst[62].noc__pe__port0_cntl  = pe_inst[54].pe__noc__port2_cntl  ;
  assign pe_inst[62].noc__pe__port0_data  = pe_inst[54].pe__noc__port2_data  ;
  assign pe_inst[54].noc__pe__port2_fc    = pe_inst[62].pe__noc__port0_fc    ;

  // Connecting PE54 Port3 to PE53 Port1
  assign pe_inst[53].noc__pe__port1_valid = pe_inst[54].pe__noc__port3_valid ;
  assign pe_inst[53].noc__pe__port1_cntl  = pe_inst[54].pe__noc__port3_cntl  ;
  assign pe_inst[53].noc__pe__port1_data  = pe_inst[54].pe__noc__port3_data  ;
  assign pe_inst[54].noc__pe__port3_fc    = pe_inst[53].pe__noc__port1_fc    ;

  // Terminate PE55's 1 unused Ports
  assign pe_inst[55].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[55].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[55].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[55].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE55 Port0 to PE47 Port1
  assign pe_inst[47].noc__pe__port1_valid = pe_inst[55].pe__noc__port0_valid ;
  assign pe_inst[47].noc__pe__port1_cntl  = pe_inst[55].pe__noc__port0_cntl  ;
  assign pe_inst[47].noc__pe__port1_data  = pe_inst[55].pe__noc__port0_data  ;
  assign pe_inst[55].noc__pe__port0_fc    = pe_inst[47].pe__noc__port1_fc    ;

  // Connecting PE55 Port1 to PE63 Port0
  assign pe_inst[63].noc__pe__port0_valid = pe_inst[55].pe__noc__port1_valid ;
  assign pe_inst[63].noc__pe__port0_cntl  = pe_inst[55].pe__noc__port1_cntl  ;
  assign pe_inst[63].noc__pe__port0_data  = pe_inst[55].pe__noc__port1_data  ;
  assign pe_inst[55].noc__pe__port1_fc    = pe_inst[63].pe__noc__port0_fc    ;

  // Connecting PE55 Port2 to PE54 Port1
  assign pe_inst[54].noc__pe__port1_valid = pe_inst[55].pe__noc__port2_valid ;
  assign pe_inst[54].noc__pe__port1_cntl  = pe_inst[55].pe__noc__port2_cntl  ;
  assign pe_inst[54].noc__pe__port1_data  = pe_inst[55].pe__noc__port2_data  ;
  assign pe_inst[55].noc__pe__port2_fc    = pe_inst[54].pe__noc__port1_fc    ;

  // Terminate PE56's 2 unused Ports
  assign pe_inst[56].noc__pe__port2_valid = 'd0 ;
  assign pe_inst[56].noc__pe__port2_cntl  = 'd0 ;
  assign pe_inst[56].noc__pe__port2_data  = 'd0 ;
  assign pe_inst[56].noc__pe__port2_fc    = 'd0 ;
  assign pe_inst[56].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[56].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[56].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[56].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE56 Port0 to PE48 Port2
  assign pe_inst[48].noc__pe__port2_valid = pe_inst[56].pe__noc__port0_valid ;
  assign pe_inst[48].noc__pe__port2_cntl  = pe_inst[56].pe__noc__port0_cntl  ;
  assign pe_inst[48].noc__pe__port2_data  = pe_inst[56].pe__noc__port0_data  ;
  assign pe_inst[56].noc__pe__port0_fc    = pe_inst[48].pe__noc__port2_fc    ;

  // Connecting PE56 Port1 to PE57 Port2
  assign pe_inst[57].noc__pe__port2_valid = pe_inst[56].pe__noc__port1_valid ;
  assign pe_inst[57].noc__pe__port2_cntl  = pe_inst[56].pe__noc__port1_cntl  ;
  assign pe_inst[57].noc__pe__port2_data  = pe_inst[56].pe__noc__port1_data  ;
  assign pe_inst[56].noc__pe__port1_fc    = pe_inst[57].pe__noc__port2_fc    ;

  // Terminate PE57's 1 unused Ports
  assign pe_inst[57].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[57].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[57].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[57].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE57 Port0 to PE49 Port2
  assign pe_inst[49].noc__pe__port2_valid = pe_inst[57].pe__noc__port0_valid ;
  assign pe_inst[49].noc__pe__port2_cntl  = pe_inst[57].pe__noc__port0_cntl  ;
  assign pe_inst[49].noc__pe__port2_data  = pe_inst[57].pe__noc__port0_data  ;
  assign pe_inst[57].noc__pe__port0_fc    = pe_inst[49].pe__noc__port2_fc    ;

  // Connecting PE57 Port1 to PE58 Port2
  assign pe_inst[58].noc__pe__port2_valid = pe_inst[57].pe__noc__port1_valid ;
  assign pe_inst[58].noc__pe__port2_cntl  = pe_inst[57].pe__noc__port1_cntl  ;
  assign pe_inst[58].noc__pe__port2_data  = pe_inst[57].pe__noc__port1_data  ;
  assign pe_inst[57].noc__pe__port1_fc    = pe_inst[58].pe__noc__port2_fc    ;

  // Connecting PE57 Port2 to PE56 Port1
  assign pe_inst[56].noc__pe__port1_valid = pe_inst[57].pe__noc__port2_valid ;
  assign pe_inst[56].noc__pe__port1_cntl  = pe_inst[57].pe__noc__port2_cntl  ;
  assign pe_inst[56].noc__pe__port1_data  = pe_inst[57].pe__noc__port2_data  ;
  assign pe_inst[57].noc__pe__port2_fc    = pe_inst[56].pe__noc__port1_fc    ;

  // Terminate PE58's 1 unused Ports
  assign pe_inst[58].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[58].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[58].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[58].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE58 Port0 to PE50 Port2
  assign pe_inst[50].noc__pe__port2_valid = pe_inst[58].pe__noc__port0_valid ;
  assign pe_inst[50].noc__pe__port2_cntl  = pe_inst[58].pe__noc__port0_cntl  ;
  assign pe_inst[50].noc__pe__port2_data  = pe_inst[58].pe__noc__port0_data  ;
  assign pe_inst[58].noc__pe__port0_fc    = pe_inst[50].pe__noc__port2_fc    ;

  // Connecting PE58 Port1 to PE59 Port2
  assign pe_inst[59].noc__pe__port2_valid = pe_inst[58].pe__noc__port1_valid ;
  assign pe_inst[59].noc__pe__port2_cntl  = pe_inst[58].pe__noc__port1_cntl  ;
  assign pe_inst[59].noc__pe__port2_data  = pe_inst[58].pe__noc__port1_data  ;
  assign pe_inst[58].noc__pe__port1_fc    = pe_inst[59].pe__noc__port2_fc    ;

  // Connecting PE58 Port2 to PE57 Port1
  assign pe_inst[57].noc__pe__port1_valid = pe_inst[58].pe__noc__port2_valid ;
  assign pe_inst[57].noc__pe__port1_cntl  = pe_inst[58].pe__noc__port2_cntl  ;
  assign pe_inst[57].noc__pe__port1_data  = pe_inst[58].pe__noc__port2_data  ;
  assign pe_inst[58].noc__pe__port2_fc    = pe_inst[57].pe__noc__port1_fc    ;

  // Terminate PE59's 1 unused Ports
  assign pe_inst[59].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[59].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[59].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[59].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE59 Port0 to PE51 Port2
  assign pe_inst[51].noc__pe__port2_valid = pe_inst[59].pe__noc__port0_valid ;
  assign pe_inst[51].noc__pe__port2_cntl  = pe_inst[59].pe__noc__port0_cntl  ;
  assign pe_inst[51].noc__pe__port2_data  = pe_inst[59].pe__noc__port0_data  ;
  assign pe_inst[59].noc__pe__port0_fc    = pe_inst[51].pe__noc__port2_fc    ;

  // Connecting PE59 Port1 to PE60 Port2
  assign pe_inst[60].noc__pe__port2_valid = pe_inst[59].pe__noc__port1_valid ;
  assign pe_inst[60].noc__pe__port2_cntl  = pe_inst[59].pe__noc__port1_cntl  ;
  assign pe_inst[60].noc__pe__port2_data  = pe_inst[59].pe__noc__port1_data  ;
  assign pe_inst[59].noc__pe__port1_fc    = pe_inst[60].pe__noc__port2_fc    ;

  // Connecting PE59 Port2 to PE58 Port1
  assign pe_inst[58].noc__pe__port1_valid = pe_inst[59].pe__noc__port2_valid ;
  assign pe_inst[58].noc__pe__port1_cntl  = pe_inst[59].pe__noc__port2_cntl  ;
  assign pe_inst[58].noc__pe__port1_data  = pe_inst[59].pe__noc__port2_data  ;
  assign pe_inst[59].noc__pe__port2_fc    = pe_inst[58].pe__noc__port1_fc    ;

  // Terminate PE60's 1 unused Ports
  assign pe_inst[60].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[60].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[60].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[60].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE60 Port0 to PE52 Port2
  assign pe_inst[52].noc__pe__port2_valid = pe_inst[60].pe__noc__port0_valid ;
  assign pe_inst[52].noc__pe__port2_cntl  = pe_inst[60].pe__noc__port0_cntl  ;
  assign pe_inst[52].noc__pe__port2_data  = pe_inst[60].pe__noc__port0_data  ;
  assign pe_inst[60].noc__pe__port0_fc    = pe_inst[52].pe__noc__port2_fc    ;

  // Connecting PE60 Port1 to PE61 Port2
  assign pe_inst[61].noc__pe__port2_valid = pe_inst[60].pe__noc__port1_valid ;
  assign pe_inst[61].noc__pe__port2_cntl  = pe_inst[60].pe__noc__port1_cntl  ;
  assign pe_inst[61].noc__pe__port2_data  = pe_inst[60].pe__noc__port1_data  ;
  assign pe_inst[60].noc__pe__port1_fc    = pe_inst[61].pe__noc__port2_fc    ;

  // Connecting PE60 Port2 to PE59 Port1
  assign pe_inst[59].noc__pe__port1_valid = pe_inst[60].pe__noc__port2_valid ;
  assign pe_inst[59].noc__pe__port1_cntl  = pe_inst[60].pe__noc__port2_cntl  ;
  assign pe_inst[59].noc__pe__port1_data  = pe_inst[60].pe__noc__port2_data  ;
  assign pe_inst[60].noc__pe__port2_fc    = pe_inst[59].pe__noc__port1_fc    ;

  // Terminate PE61's 1 unused Ports
  assign pe_inst[61].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[61].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[61].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[61].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE61 Port0 to PE53 Port2
  assign pe_inst[53].noc__pe__port2_valid = pe_inst[61].pe__noc__port0_valid ;
  assign pe_inst[53].noc__pe__port2_cntl  = pe_inst[61].pe__noc__port0_cntl  ;
  assign pe_inst[53].noc__pe__port2_data  = pe_inst[61].pe__noc__port0_data  ;
  assign pe_inst[61].noc__pe__port0_fc    = pe_inst[53].pe__noc__port2_fc    ;

  // Connecting PE61 Port1 to PE62 Port2
  assign pe_inst[62].noc__pe__port2_valid = pe_inst[61].pe__noc__port1_valid ;
  assign pe_inst[62].noc__pe__port2_cntl  = pe_inst[61].pe__noc__port1_cntl  ;
  assign pe_inst[62].noc__pe__port2_data  = pe_inst[61].pe__noc__port1_data  ;
  assign pe_inst[61].noc__pe__port1_fc    = pe_inst[62].pe__noc__port2_fc    ;

  // Connecting PE61 Port2 to PE60 Port1
  assign pe_inst[60].noc__pe__port1_valid = pe_inst[61].pe__noc__port2_valid ;
  assign pe_inst[60].noc__pe__port1_cntl  = pe_inst[61].pe__noc__port2_cntl  ;
  assign pe_inst[60].noc__pe__port1_data  = pe_inst[61].pe__noc__port2_data  ;
  assign pe_inst[61].noc__pe__port2_fc    = pe_inst[60].pe__noc__port1_fc    ;

  // Terminate PE62's 1 unused Ports
  assign pe_inst[62].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[62].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[62].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[62].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE62 Port0 to PE54 Port2
  assign pe_inst[54].noc__pe__port2_valid = pe_inst[62].pe__noc__port0_valid ;
  assign pe_inst[54].noc__pe__port2_cntl  = pe_inst[62].pe__noc__port0_cntl  ;
  assign pe_inst[54].noc__pe__port2_data  = pe_inst[62].pe__noc__port0_data  ;
  assign pe_inst[62].noc__pe__port0_fc    = pe_inst[54].pe__noc__port2_fc    ;

  // Connecting PE62 Port1 to PE63 Port1
  assign pe_inst[63].noc__pe__port1_valid = pe_inst[62].pe__noc__port1_valid ;
  assign pe_inst[63].noc__pe__port1_cntl  = pe_inst[62].pe__noc__port1_cntl  ;
  assign pe_inst[63].noc__pe__port1_data  = pe_inst[62].pe__noc__port1_data  ;
  assign pe_inst[62].noc__pe__port1_fc    = pe_inst[63].pe__noc__port1_fc    ;

  // Connecting PE62 Port2 to PE61 Port1
  assign pe_inst[61].noc__pe__port1_valid = pe_inst[62].pe__noc__port2_valid ;
  assign pe_inst[61].noc__pe__port1_cntl  = pe_inst[62].pe__noc__port2_cntl  ;
  assign pe_inst[61].noc__pe__port1_data  = pe_inst[62].pe__noc__port2_data  ;
  assign pe_inst[62].noc__pe__port2_fc    = pe_inst[61].pe__noc__port1_fc    ;

  // Terminate PE63's 2 unused Ports
  assign pe_inst[63].noc__pe__port2_valid = 'd0 ;
  assign pe_inst[63].noc__pe__port2_cntl  = 'd0 ;
  assign pe_inst[63].noc__pe__port2_data  = 'd0 ;
  assign pe_inst[63].noc__pe__port2_fc    = 'd0 ;
  assign pe_inst[63].noc__pe__port3_valid = 'd0 ;
  assign pe_inst[63].noc__pe__port3_cntl  = 'd0 ;
  assign pe_inst[63].noc__pe__port3_data  = 'd0 ;
  assign pe_inst[63].noc__pe__port3_fc    = 'd0 ;

  // Connecting PE63 Port0 to PE55 Port1
  assign pe_inst[55].noc__pe__port1_valid = pe_inst[63].pe__noc__port0_valid ;
  assign pe_inst[55].noc__pe__port1_cntl  = pe_inst[63].pe__noc__port0_cntl  ;
  assign pe_inst[55].noc__pe__port1_data  = pe_inst[63].pe__noc__port0_data  ;
  assign pe_inst[63].noc__pe__port0_fc    = pe_inst[55].pe__noc__port1_fc    ;

  // Connecting PE63 Port1 to PE62 Port1
  assign pe_inst[62].noc__pe__port1_valid = pe_inst[63].pe__noc__port1_valid ;
  assign pe_inst[62].noc__pe__port1_cntl  = pe_inst[63].pe__noc__port1_cntl  ;
  assign pe_inst[62].noc__pe__port1_data  = pe_inst[63].pe__noc__port1_data  ;
  assign pe_inst[63].noc__pe__port1_fc    = pe_inst[62].pe__noc__port1_fc    ;
