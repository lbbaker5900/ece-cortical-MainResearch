
  // Terminate Mgr0's 2 unused Ports
  assign mgr_inst[0].noc__mgr__port2_valid = 'd0 ;
  assign mgr_inst[0].noc__mgr__port2_cntl  = 'd0 ;
  assign mgr_inst[0].noc__mgr__port2_data  = 'd0 ;
  assign mgr_inst[0].noc__mgr__port2_fc    = 'd0 ;
  assign mgr_inst[0].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[0].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[0].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[0].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr0 Port0 to Mgr1 Port2
  assign mgr_inst[1].noc__mgr__port2_valid = mgr_inst[0].mgr__noc__port0_valid ;
  assign mgr_inst[1].noc__mgr__port2_cntl  = mgr_inst[0].mgr__noc__port0_cntl  ;
  assign mgr_inst[1].noc__mgr__port2_data  = mgr_inst[0].mgr__noc__port0_data  ;
  assign mgr_inst[0].noc__mgr__port0_fc    = mgr_inst[1].mgr__noc__port2_fc    ;

  // Connecting Mgr0 Port1 to Mgr8 Port0
  assign mgr_inst[8].noc__mgr__port0_valid = mgr_inst[0].mgr__noc__port1_valid ;
  assign mgr_inst[8].noc__mgr__port0_cntl  = mgr_inst[0].mgr__noc__port1_cntl  ;
  assign mgr_inst[8].noc__mgr__port0_data  = mgr_inst[0].mgr__noc__port1_data  ;
  assign mgr_inst[0].noc__mgr__port1_fc    = mgr_inst[8].mgr__noc__port0_fc    ;

  // Terminate Mgr1's 1 unused Ports
  assign mgr_inst[1].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[1].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[1].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[1].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr1 Port0 to Mgr2 Port2
  assign mgr_inst[2].noc__mgr__port2_valid = mgr_inst[1].mgr__noc__port0_valid ;
  assign mgr_inst[2].noc__mgr__port2_cntl  = mgr_inst[1].mgr__noc__port0_cntl  ;
  assign mgr_inst[2].noc__mgr__port2_data  = mgr_inst[1].mgr__noc__port0_data  ;
  assign mgr_inst[1].noc__mgr__port0_fc    = mgr_inst[2].mgr__noc__port2_fc    ;

  // Connecting Mgr1 Port1 to Mgr9 Port0
  assign mgr_inst[9].noc__mgr__port0_valid = mgr_inst[1].mgr__noc__port1_valid ;
  assign mgr_inst[9].noc__mgr__port0_cntl  = mgr_inst[1].mgr__noc__port1_cntl  ;
  assign mgr_inst[9].noc__mgr__port0_data  = mgr_inst[1].mgr__noc__port1_data  ;
  assign mgr_inst[1].noc__mgr__port1_fc    = mgr_inst[9].mgr__noc__port0_fc    ;

  // Connecting Mgr1 Port2 to Mgr0 Port0
  assign mgr_inst[0].noc__mgr__port0_valid = mgr_inst[1].mgr__noc__port2_valid ;
  assign mgr_inst[0].noc__mgr__port0_cntl  = mgr_inst[1].mgr__noc__port2_cntl  ;
  assign mgr_inst[0].noc__mgr__port0_data  = mgr_inst[1].mgr__noc__port2_data  ;
  assign mgr_inst[1].noc__mgr__port2_fc    = mgr_inst[0].mgr__noc__port0_fc    ;

  // Terminate Mgr2's 1 unused Ports
  assign mgr_inst[2].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[2].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[2].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[2].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr2 Port0 to Mgr3 Port2
  assign mgr_inst[3].noc__mgr__port2_valid = mgr_inst[2].mgr__noc__port0_valid ;
  assign mgr_inst[3].noc__mgr__port2_cntl  = mgr_inst[2].mgr__noc__port0_cntl  ;
  assign mgr_inst[3].noc__mgr__port2_data  = mgr_inst[2].mgr__noc__port0_data  ;
  assign mgr_inst[2].noc__mgr__port0_fc    = mgr_inst[3].mgr__noc__port2_fc    ;

  // Connecting Mgr2 Port1 to Mgr10 Port0
  assign mgr_inst[10].noc__mgr__port0_valid = mgr_inst[2].mgr__noc__port1_valid ;
  assign mgr_inst[10].noc__mgr__port0_cntl  = mgr_inst[2].mgr__noc__port1_cntl  ;
  assign mgr_inst[10].noc__mgr__port0_data  = mgr_inst[2].mgr__noc__port1_data  ;
  assign mgr_inst[2].noc__mgr__port1_fc    = mgr_inst[10].mgr__noc__port0_fc    ;

  // Connecting Mgr2 Port2 to Mgr1 Port0
  assign mgr_inst[1].noc__mgr__port0_valid = mgr_inst[2].mgr__noc__port2_valid ;
  assign mgr_inst[1].noc__mgr__port0_cntl  = mgr_inst[2].mgr__noc__port2_cntl  ;
  assign mgr_inst[1].noc__mgr__port0_data  = mgr_inst[2].mgr__noc__port2_data  ;
  assign mgr_inst[2].noc__mgr__port2_fc    = mgr_inst[1].mgr__noc__port0_fc    ;

  // Terminate Mgr3's 1 unused Ports
  assign mgr_inst[3].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[3].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[3].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[3].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr3 Port0 to Mgr4 Port2
  assign mgr_inst[4].noc__mgr__port2_valid = mgr_inst[3].mgr__noc__port0_valid ;
  assign mgr_inst[4].noc__mgr__port2_cntl  = mgr_inst[3].mgr__noc__port0_cntl  ;
  assign mgr_inst[4].noc__mgr__port2_data  = mgr_inst[3].mgr__noc__port0_data  ;
  assign mgr_inst[3].noc__mgr__port0_fc    = mgr_inst[4].mgr__noc__port2_fc    ;

  // Connecting Mgr3 Port1 to Mgr11 Port0
  assign mgr_inst[11].noc__mgr__port0_valid = mgr_inst[3].mgr__noc__port1_valid ;
  assign mgr_inst[11].noc__mgr__port0_cntl  = mgr_inst[3].mgr__noc__port1_cntl  ;
  assign mgr_inst[11].noc__mgr__port0_data  = mgr_inst[3].mgr__noc__port1_data  ;
  assign mgr_inst[3].noc__mgr__port1_fc    = mgr_inst[11].mgr__noc__port0_fc    ;

  // Connecting Mgr3 Port2 to Mgr2 Port0
  assign mgr_inst[2].noc__mgr__port0_valid = mgr_inst[3].mgr__noc__port2_valid ;
  assign mgr_inst[2].noc__mgr__port0_cntl  = mgr_inst[3].mgr__noc__port2_cntl  ;
  assign mgr_inst[2].noc__mgr__port0_data  = mgr_inst[3].mgr__noc__port2_data  ;
  assign mgr_inst[3].noc__mgr__port2_fc    = mgr_inst[2].mgr__noc__port0_fc    ;

  // Terminate Mgr4's 1 unused Ports
  assign mgr_inst[4].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[4].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[4].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[4].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr4 Port0 to Mgr5 Port2
  assign mgr_inst[5].noc__mgr__port2_valid = mgr_inst[4].mgr__noc__port0_valid ;
  assign mgr_inst[5].noc__mgr__port2_cntl  = mgr_inst[4].mgr__noc__port0_cntl  ;
  assign mgr_inst[5].noc__mgr__port2_data  = mgr_inst[4].mgr__noc__port0_data  ;
  assign mgr_inst[4].noc__mgr__port0_fc    = mgr_inst[5].mgr__noc__port2_fc    ;

  // Connecting Mgr4 Port1 to Mgr12 Port0
  assign mgr_inst[12].noc__mgr__port0_valid = mgr_inst[4].mgr__noc__port1_valid ;
  assign mgr_inst[12].noc__mgr__port0_cntl  = mgr_inst[4].mgr__noc__port1_cntl  ;
  assign mgr_inst[12].noc__mgr__port0_data  = mgr_inst[4].mgr__noc__port1_data  ;
  assign mgr_inst[4].noc__mgr__port1_fc    = mgr_inst[12].mgr__noc__port0_fc    ;

  // Connecting Mgr4 Port2 to Mgr3 Port0
  assign mgr_inst[3].noc__mgr__port0_valid = mgr_inst[4].mgr__noc__port2_valid ;
  assign mgr_inst[3].noc__mgr__port0_cntl  = mgr_inst[4].mgr__noc__port2_cntl  ;
  assign mgr_inst[3].noc__mgr__port0_data  = mgr_inst[4].mgr__noc__port2_data  ;
  assign mgr_inst[4].noc__mgr__port2_fc    = mgr_inst[3].mgr__noc__port0_fc    ;

  // Terminate Mgr5's 1 unused Ports
  assign mgr_inst[5].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[5].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[5].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[5].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr5 Port0 to Mgr6 Port2
  assign mgr_inst[6].noc__mgr__port2_valid = mgr_inst[5].mgr__noc__port0_valid ;
  assign mgr_inst[6].noc__mgr__port2_cntl  = mgr_inst[5].mgr__noc__port0_cntl  ;
  assign mgr_inst[6].noc__mgr__port2_data  = mgr_inst[5].mgr__noc__port0_data  ;
  assign mgr_inst[5].noc__mgr__port0_fc    = mgr_inst[6].mgr__noc__port2_fc    ;

  // Connecting Mgr5 Port1 to Mgr13 Port0
  assign mgr_inst[13].noc__mgr__port0_valid = mgr_inst[5].mgr__noc__port1_valid ;
  assign mgr_inst[13].noc__mgr__port0_cntl  = mgr_inst[5].mgr__noc__port1_cntl  ;
  assign mgr_inst[13].noc__mgr__port0_data  = mgr_inst[5].mgr__noc__port1_data  ;
  assign mgr_inst[5].noc__mgr__port1_fc    = mgr_inst[13].mgr__noc__port0_fc    ;

  // Connecting Mgr5 Port2 to Mgr4 Port0
  assign mgr_inst[4].noc__mgr__port0_valid = mgr_inst[5].mgr__noc__port2_valid ;
  assign mgr_inst[4].noc__mgr__port0_cntl  = mgr_inst[5].mgr__noc__port2_cntl  ;
  assign mgr_inst[4].noc__mgr__port0_data  = mgr_inst[5].mgr__noc__port2_data  ;
  assign mgr_inst[5].noc__mgr__port2_fc    = mgr_inst[4].mgr__noc__port0_fc    ;

  // Terminate Mgr6's 1 unused Ports
  assign mgr_inst[6].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[6].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[6].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[6].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr6 Port0 to Mgr7 Port1
  assign mgr_inst[7].noc__mgr__port1_valid = mgr_inst[6].mgr__noc__port0_valid ;
  assign mgr_inst[7].noc__mgr__port1_cntl  = mgr_inst[6].mgr__noc__port0_cntl  ;
  assign mgr_inst[7].noc__mgr__port1_data  = mgr_inst[6].mgr__noc__port0_data  ;
  assign mgr_inst[6].noc__mgr__port0_fc    = mgr_inst[7].mgr__noc__port1_fc    ;

  // Connecting Mgr6 Port1 to Mgr14 Port0
  assign mgr_inst[14].noc__mgr__port0_valid = mgr_inst[6].mgr__noc__port1_valid ;
  assign mgr_inst[14].noc__mgr__port0_cntl  = mgr_inst[6].mgr__noc__port1_cntl  ;
  assign mgr_inst[14].noc__mgr__port0_data  = mgr_inst[6].mgr__noc__port1_data  ;
  assign mgr_inst[6].noc__mgr__port1_fc    = mgr_inst[14].mgr__noc__port0_fc    ;

  // Connecting Mgr6 Port2 to Mgr5 Port0
  assign mgr_inst[5].noc__mgr__port0_valid = mgr_inst[6].mgr__noc__port2_valid ;
  assign mgr_inst[5].noc__mgr__port0_cntl  = mgr_inst[6].mgr__noc__port2_cntl  ;
  assign mgr_inst[5].noc__mgr__port0_data  = mgr_inst[6].mgr__noc__port2_data  ;
  assign mgr_inst[6].noc__mgr__port2_fc    = mgr_inst[5].mgr__noc__port0_fc    ;

  // Terminate Mgr7's 2 unused Ports
  assign mgr_inst[7].noc__mgr__port2_valid = 'd0 ;
  assign mgr_inst[7].noc__mgr__port2_cntl  = 'd0 ;
  assign mgr_inst[7].noc__mgr__port2_data  = 'd0 ;
  assign mgr_inst[7].noc__mgr__port2_fc    = 'd0 ;
  assign mgr_inst[7].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[7].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[7].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[7].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr7 Port0 to Mgr15 Port0
  assign mgr_inst[15].noc__mgr__port0_valid = mgr_inst[7].mgr__noc__port0_valid ;
  assign mgr_inst[15].noc__mgr__port0_cntl  = mgr_inst[7].mgr__noc__port0_cntl  ;
  assign mgr_inst[15].noc__mgr__port0_data  = mgr_inst[7].mgr__noc__port0_data  ;
  assign mgr_inst[7].noc__mgr__port0_fc    = mgr_inst[15].mgr__noc__port0_fc    ;

  // Connecting Mgr7 Port1 to Mgr6 Port0
  assign mgr_inst[6].noc__mgr__port0_valid = mgr_inst[7].mgr__noc__port1_valid ;
  assign mgr_inst[6].noc__mgr__port0_cntl  = mgr_inst[7].mgr__noc__port1_cntl  ;
  assign mgr_inst[6].noc__mgr__port0_data  = mgr_inst[7].mgr__noc__port1_data  ;
  assign mgr_inst[7].noc__mgr__port1_fc    = mgr_inst[6].mgr__noc__port0_fc    ;

  // Terminate Mgr8's 1 unused Ports
  assign mgr_inst[8].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[8].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[8].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[8].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr8 Port0 to Mgr0 Port1
  assign mgr_inst[0].noc__mgr__port1_valid = mgr_inst[8].mgr__noc__port0_valid ;
  assign mgr_inst[0].noc__mgr__port1_cntl  = mgr_inst[8].mgr__noc__port0_cntl  ;
  assign mgr_inst[0].noc__mgr__port1_data  = mgr_inst[8].mgr__noc__port0_data  ;
  assign mgr_inst[8].noc__mgr__port0_fc    = mgr_inst[0].mgr__noc__port1_fc    ;

  // Connecting Mgr8 Port1 to Mgr9 Port3
  assign mgr_inst[9].noc__mgr__port3_valid = mgr_inst[8].mgr__noc__port1_valid ;
  assign mgr_inst[9].noc__mgr__port3_cntl  = mgr_inst[8].mgr__noc__port1_cntl  ;
  assign mgr_inst[9].noc__mgr__port3_data  = mgr_inst[8].mgr__noc__port1_data  ;
  assign mgr_inst[8].noc__mgr__port1_fc    = mgr_inst[9].mgr__noc__port3_fc    ;

  // Connecting Mgr8 Port2 to Mgr16 Port0
  assign mgr_inst[16].noc__mgr__port0_valid = mgr_inst[8].mgr__noc__port2_valid ;
  assign mgr_inst[16].noc__mgr__port0_cntl  = mgr_inst[8].mgr__noc__port2_cntl  ;
  assign mgr_inst[16].noc__mgr__port0_data  = mgr_inst[8].mgr__noc__port2_data  ;
  assign mgr_inst[8].noc__mgr__port2_fc    = mgr_inst[16].mgr__noc__port0_fc    ;

  // Connecting Mgr9 Port0 to Mgr1 Port1
  assign mgr_inst[1].noc__mgr__port1_valid = mgr_inst[9].mgr__noc__port0_valid ;
  assign mgr_inst[1].noc__mgr__port1_cntl  = mgr_inst[9].mgr__noc__port0_cntl  ;
  assign mgr_inst[1].noc__mgr__port1_data  = mgr_inst[9].mgr__noc__port0_data  ;
  assign mgr_inst[9].noc__mgr__port0_fc    = mgr_inst[1].mgr__noc__port1_fc    ;

  // Connecting Mgr9 Port1 to Mgr10 Port3
  assign mgr_inst[10].noc__mgr__port3_valid = mgr_inst[9].mgr__noc__port1_valid ;
  assign mgr_inst[10].noc__mgr__port3_cntl  = mgr_inst[9].mgr__noc__port1_cntl  ;
  assign mgr_inst[10].noc__mgr__port3_data  = mgr_inst[9].mgr__noc__port1_data  ;
  assign mgr_inst[9].noc__mgr__port1_fc    = mgr_inst[10].mgr__noc__port3_fc    ;

  // Connecting Mgr9 Port2 to Mgr17 Port0
  assign mgr_inst[17].noc__mgr__port0_valid = mgr_inst[9].mgr__noc__port2_valid ;
  assign mgr_inst[17].noc__mgr__port0_cntl  = mgr_inst[9].mgr__noc__port2_cntl  ;
  assign mgr_inst[17].noc__mgr__port0_data  = mgr_inst[9].mgr__noc__port2_data  ;
  assign mgr_inst[9].noc__mgr__port2_fc    = mgr_inst[17].mgr__noc__port0_fc    ;

  // Connecting Mgr9 Port3 to Mgr8 Port1
  assign mgr_inst[8].noc__mgr__port1_valid = mgr_inst[9].mgr__noc__port3_valid ;
  assign mgr_inst[8].noc__mgr__port1_cntl  = mgr_inst[9].mgr__noc__port3_cntl  ;
  assign mgr_inst[8].noc__mgr__port1_data  = mgr_inst[9].mgr__noc__port3_data  ;
  assign mgr_inst[9].noc__mgr__port3_fc    = mgr_inst[8].mgr__noc__port1_fc    ;

  // Connecting Mgr10 Port0 to Mgr2 Port1
  assign mgr_inst[2].noc__mgr__port1_valid = mgr_inst[10].mgr__noc__port0_valid ;
  assign mgr_inst[2].noc__mgr__port1_cntl  = mgr_inst[10].mgr__noc__port0_cntl  ;
  assign mgr_inst[2].noc__mgr__port1_data  = mgr_inst[10].mgr__noc__port0_data  ;
  assign mgr_inst[10].noc__mgr__port0_fc    = mgr_inst[2].mgr__noc__port1_fc    ;

  // Connecting Mgr10 Port1 to Mgr11 Port3
  assign mgr_inst[11].noc__mgr__port3_valid = mgr_inst[10].mgr__noc__port1_valid ;
  assign mgr_inst[11].noc__mgr__port3_cntl  = mgr_inst[10].mgr__noc__port1_cntl  ;
  assign mgr_inst[11].noc__mgr__port3_data  = mgr_inst[10].mgr__noc__port1_data  ;
  assign mgr_inst[10].noc__mgr__port1_fc    = mgr_inst[11].mgr__noc__port3_fc    ;

  // Connecting Mgr10 Port2 to Mgr18 Port0
  assign mgr_inst[18].noc__mgr__port0_valid = mgr_inst[10].mgr__noc__port2_valid ;
  assign mgr_inst[18].noc__mgr__port0_cntl  = mgr_inst[10].mgr__noc__port2_cntl  ;
  assign mgr_inst[18].noc__mgr__port0_data  = mgr_inst[10].mgr__noc__port2_data  ;
  assign mgr_inst[10].noc__mgr__port2_fc    = mgr_inst[18].mgr__noc__port0_fc    ;

  // Connecting Mgr10 Port3 to Mgr9 Port1
  assign mgr_inst[9].noc__mgr__port1_valid = mgr_inst[10].mgr__noc__port3_valid ;
  assign mgr_inst[9].noc__mgr__port1_cntl  = mgr_inst[10].mgr__noc__port3_cntl  ;
  assign mgr_inst[9].noc__mgr__port1_data  = mgr_inst[10].mgr__noc__port3_data  ;
  assign mgr_inst[10].noc__mgr__port3_fc    = mgr_inst[9].mgr__noc__port1_fc    ;

  // Connecting Mgr11 Port0 to Mgr3 Port1
  assign mgr_inst[3].noc__mgr__port1_valid = mgr_inst[11].mgr__noc__port0_valid ;
  assign mgr_inst[3].noc__mgr__port1_cntl  = mgr_inst[11].mgr__noc__port0_cntl  ;
  assign mgr_inst[3].noc__mgr__port1_data  = mgr_inst[11].mgr__noc__port0_data  ;
  assign mgr_inst[11].noc__mgr__port0_fc    = mgr_inst[3].mgr__noc__port1_fc    ;

  // Connecting Mgr11 Port1 to Mgr12 Port3
  assign mgr_inst[12].noc__mgr__port3_valid = mgr_inst[11].mgr__noc__port1_valid ;
  assign mgr_inst[12].noc__mgr__port3_cntl  = mgr_inst[11].mgr__noc__port1_cntl  ;
  assign mgr_inst[12].noc__mgr__port3_data  = mgr_inst[11].mgr__noc__port1_data  ;
  assign mgr_inst[11].noc__mgr__port1_fc    = mgr_inst[12].mgr__noc__port3_fc    ;

  // Connecting Mgr11 Port2 to Mgr19 Port0
  assign mgr_inst[19].noc__mgr__port0_valid = mgr_inst[11].mgr__noc__port2_valid ;
  assign mgr_inst[19].noc__mgr__port0_cntl  = mgr_inst[11].mgr__noc__port2_cntl  ;
  assign mgr_inst[19].noc__mgr__port0_data  = mgr_inst[11].mgr__noc__port2_data  ;
  assign mgr_inst[11].noc__mgr__port2_fc    = mgr_inst[19].mgr__noc__port0_fc    ;

  // Connecting Mgr11 Port3 to Mgr10 Port1
  assign mgr_inst[10].noc__mgr__port1_valid = mgr_inst[11].mgr__noc__port3_valid ;
  assign mgr_inst[10].noc__mgr__port1_cntl  = mgr_inst[11].mgr__noc__port3_cntl  ;
  assign mgr_inst[10].noc__mgr__port1_data  = mgr_inst[11].mgr__noc__port3_data  ;
  assign mgr_inst[11].noc__mgr__port3_fc    = mgr_inst[10].mgr__noc__port1_fc    ;

  // Connecting Mgr12 Port0 to Mgr4 Port1
  assign mgr_inst[4].noc__mgr__port1_valid = mgr_inst[12].mgr__noc__port0_valid ;
  assign mgr_inst[4].noc__mgr__port1_cntl  = mgr_inst[12].mgr__noc__port0_cntl  ;
  assign mgr_inst[4].noc__mgr__port1_data  = mgr_inst[12].mgr__noc__port0_data  ;
  assign mgr_inst[12].noc__mgr__port0_fc    = mgr_inst[4].mgr__noc__port1_fc    ;

  // Connecting Mgr12 Port1 to Mgr13 Port3
  assign mgr_inst[13].noc__mgr__port3_valid = mgr_inst[12].mgr__noc__port1_valid ;
  assign mgr_inst[13].noc__mgr__port3_cntl  = mgr_inst[12].mgr__noc__port1_cntl  ;
  assign mgr_inst[13].noc__mgr__port3_data  = mgr_inst[12].mgr__noc__port1_data  ;
  assign mgr_inst[12].noc__mgr__port1_fc    = mgr_inst[13].mgr__noc__port3_fc    ;

  // Connecting Mgr12 Port2 to Mgr20 Port0
  assign mgr_inst[20].noc__mgr__port0_valid = mgr_inst[12].mgr__noc__port2_valid ;
  assign mgr_inst[20].noc__mgr__port0_cntl  = mgr_inst[12].mgr__noc__port2_cntl  ;
  assign mgr_inst[20].noc__mgr__port0_data  = mgr_inst[12].mgr__noc__port2_data  ;
  assign mgr_inst[12].noc__mgr__port2_fc    = mgr_inst[20].mgr__noc__port0_fc    ;

  // Connecting Mgr12 Port3 to Mgr11 Port1
  assign mgr_inst[11].noc__mgr__port1_valid = mgr_inst[12].mgr__noc__port3_valid ;
  assign mgr_inst[11].noc__mgr__port1_cntl  = mgr_inst[12].mgr__noc__port3_cntl  ;
  assign mgr_inst[11].noc__mgr__port1_data  = mgr_inst[12].mgr__noc__port3_data  ;
  assign mgr_inst[12].noc__mgr__port3_fc    = mgr_inst[11].mgr__noc__port1_fc    ;

  // Connecting Mgr13 Port0 to Mgr5 Port1
  assign mgr_inst[5].noc__mgr__port1_valid = mgr_inst[13].mgr__noc__port0_valid ;
  assign mgr_inst[5].noc__mgr__port1_cntl  = mgr_inst[13].mgr__noc__port0_cntl  ;
  assign mgr_inst[5].noc__mgr__port1_data  = mgr_inst[13].mgr__noc__port0_data  ;
  assign mgr_inst[13].noc__mgr__port0_fc    = mgr_inst[5].mgr__noc__port1_fc    ;

  // Connecting Mgr13 Port1 to Mgr14 Port3
  assign mgr_inst[14].noc__mgr__port3_valid = mgr_inst[13].mgr__noc__port1_valid ;
  assign mgr_inst[14].noc__mgr__port3_cntl  = mgr_inst[13].mgr__noc__port1_cntl  ;
  assign mgr_inst[14].noc__mgr__port3_data  = mgr_inst[13].mgr__noc__port1_data  ;
  assign mgr_inst[13].noc__mgr__port1_fc    = mgr_inst[14].mgr__noc__port3_fc    ;

  // Connecting Mgr13 Port2 to Mgr21 Port0
  assign mgr_inst[21].noc__mgr__port0_valid = mgr_inst[13].mgr__noc__port2_valid ;
  assign mgr_inst[21].noc__mgr__port0_cntl  = mgr_inst[13].mgr__noc__port2_cntl  ;
  assign mgr_inst[21].noc__mgr__port0_data  = mgr_inst[13].mgr__noc__port2_data  ;
  assign mgr_inst[13].noc__mgr__port2_fc    = mgr_inst[21].mgr__noc__port0_fc    ;

  // Connecting Mgr13 Port3 to Mgr12 Port1
  assign mgr_inst[12].noc__mgr__port1_valid = mgr_inst[13].mgr__noc__port3_valid ;
  assign mgr_inst[12].noc__mgr__port1_cntl  = mgr_inst[13].mgr__noc__port3_cntl  ;
  assign mgr_inst[12].noc__mgr__port1_data  = mgr_inst[13].mgr__noc__port3_data  ;
  assign mgr_inst[13].noc__mgr__port3_fc    = mgr_inst[12].mgr__noc__port1_fc    ;

  // Connecting Mgr14 Port0 to Mgr6 Port1
  assign mgr_inst[6].noc__mgr__port1_valid = mgr_inst[14].mgr__noc__port0_valid ;
  assign mgr_inst[6].noc__mgr__port1_cntl  = mgr_inst[14].mgr__noc__port0_cntl  ;
  assign mgr_inst[6].noc__mgr__port1_data  = mgr_inst[14].mgr__noc__port0_data  ;
  assign mgr_inst[14].noc__mgr__port0_fc    = mgr_inst[6].mgr__noc__port1_fc    ;

  // Connecting Mgr14 Port1 to Mgr15 Port2
  assign mgr_inst[15].noc__mgr__port2_valid = mgr_inst[14].mgr__noc__port1_valid ;
  assign mgr_inst[15].noc__mgr__port2_cntl  = mgr_inst[14].mgr__noc__port1_cntl  ;
  assign mgr_inst[15].noc__mgr__port2_data  = mgr_inst[14].mgr__noc__port1_data  ;
  assign mgr_inst[14].noc__mgr__port1_fc    = mgr_inst[15].mgr__noc__port2_fc    ;

  // Connecting Mgr14 Port2 to Mgr22 Port0
  assign mgr_inst[22].noc__mgr__port0_valid = mgr_inst[14].mgr__noc__port2_valid ;
  assign mgr_inst[22].noc__mgr__port0_cntl  = mgr_inst[14].mgr__noc__port2_cntl  ;
  assign mgr_inst[22].noc__mgr__port0_data  = mgr_inst[14].mgr__noc__port2_data  ;
  assign mgr_inst[14].noc__mgr__port2_fc    = mgr_inst[22].mgr__noc__port0_fc    ;

  // Connecting Mgr14 Port3 to Mgr13 Port1
  assign mgr_inst[13].noc__mgr__port1_valid = mgr_inst[14].mgr__noc__port3_valid ;
  assign mgr_inst[13].noc__mgr__port1_cntl  = mgr_inst[14].mgr__noc__port3_cntl  ;
  assign mgr_inst[13].noc__mgr__port1_data  = mgr_inst[14].mgr__noc__port3_data  ;
  assign mgr_inst[14].noc__mgr__port3_fc    = mgr_inst[13].mgr__noc__port1_fc    ;

  // Terminate Mgr15's 1 unused Ports
  assign mgr_inst[15].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[15].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[15].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[15].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr15 Port0 to Mgr7 Port0
  assign mgr_inst[7].noc__mgr__port0_valid = mgr_inst[15].mgr__noc__port0_valid ;
  assign mgr_inst[7].noc__mgr__port0_cntl  = mgr_inst[15].mgr__noc__port0_cntl  ;
  assign mgr_inst[7].noc__mgr__port0_data  = mgr_inst[15].mgr__noc__port0_data  ;
  assign mgr_inst[15].noc__mgr__port0_fc    = mgr_inst[7].mgr__noc__port0_fc    ;

  // Connecting Mgr15 Port1 to Mgr23 Port0
  assign mgr_inst[23].noc__mgr__port0_valid = mgr_inst[15].mgr__noc__port1_valid ;
  assign mgr_inst[23].noc__mgr__port0_cntl  = mgr_inst[15].mgr__noc__port1_cntl  ;
  assign mgr_inst[23].noc__mgr__port0_data  = mgr_inst[15].mgr__noc__port1_data  ;
  assign mgr_inst[15].noc__mgr__port1_fc    = mgr_inst[23].mgr__noc__port0_fc    ;

  // Connecting Mgr15 Port2 to Mgr14 Port1
  assign mgr_inst[14].noc__mgr__port1_valid = mgr_inst[15].mgr__noc__port2_valid ;
  assign mgr_inst[14].noc__mgr__port1_cntl  = mgr_inst[15].mgr__noc__port2_cntl  ;
  assign mgr_inst[14].noc__mgr__port1_data  = mgr_inst[15].mgr__noc__port2_data  ;
  assign mgr_inst[15].noc__mgr__port2_fc    = mgr_inst[14].mgr__noc__port1_fc    ;

  // Terminate Mgr16's 1 unused Ports
  assign mgr_inst[16].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[16].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[16].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[16].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr16 Port0 to Mgr8 Port2
  assign mgr_inst[8].noc__mgr__port2_valid = mgr_inst[16].mgr__noc__port0_valid ;
  assign mgr_inst[8].noc__mgr__port2_cntl  = mgr_inst[16].mgr__noc__port0_cntl  ;
  assign mgr_inst[8].noc__mgr__port2_data  = mgr_inst[16].mgr__noc__port0_data  ;
  assign mgr_inst[16].noc__mgr__port0_fc    = mgr_inst[8].mgr__noc__port2_fc    ;

  // Connecting Mgr16 Port1 to Mgr17 Port3
  assign mgr_inst[17].noc__mgr__port3_valid = mgr_inst[16].mgr__noc__port1_valid ;
  assign mgr_inst[17].noc__mgr__port3_cntl  = mgr_inst[16].mgr__noc__port1_cntl  ;
  assign mgr_inst[17].noc__mgr__port3_data  = mgr_inst[16].mgr__noc__port1_data  ;
  assign mgr_inst[16].noc__mgr__port1_fc    = mgr_inst[17].mgr__noc__port3_fc    ;

  // Connecting Mgr16 Port2 to Mgr24 Port0
  assign mgr_inst[24].noc__mgr__port0_valid = mgr_inst[16].mgr__noc__port2_valid ;
  assign mgr_inst[24].noc__mgr__port0_cntl  = mgr_inst[16].mgr__noc__port2_cntl  ;
  assign mgr_inst[24].noc__mgr__port0_data  = mgr_inst[16].mgr__noc__port2_data  ;
  assign mgr_inst[16].noc__mgr__port2_fc    = mgr_inst[24].mgr__noc__port0_fc    ;

  // Connecting Mgr17 Port0 to Mgr9 Port2
  assign mgr_inst[9].noc__mgr__port2_valid = mgr_inst[17].mgr__noc__port0_valid ;
  assign mgr_inst[9].noc__mgr__port2_cntl  = mgr_inst[17].mgr__noc__port0_cntl  ;
  assign mgr_inst[9].noc__mgr__port2_data  = mgr_inst[17].mgr__noc__port0_data  ;
  assign mgr_inst[17].noc__mgr__port0_fc    = mgr_inst[9].mgr__noc__port2_fc    ;

  // Connecting Mgr17 Port1 to Mgr18 Port3
  assign mgr_inst[18].noc__mgr__port3_valid = mgr_inst[17].mgr__noc__port1_valid ;
  assign mgr_inst[18].noc__mgr__port3_cntl  = mgr_inst[17].mgr__noc__port1_cntl  ;
  assign mgr_inst[18].noc__mgr__port3_data  = mgr_inst[17].mgr__noc__port1_data  ;
  assign mgr_inst[17].noc__mgr__port1_fc    = mgr_inst[18].mgr__noc__port3_fc    ;

  // Connecting Mgr17 Port2 to Mgr25 Port0
  assign mgr_inst[25].noc__mgr__port0_valid = mgr_inst[17].mgr__noc__port2_valid ;
  assign mgr_inst[25].noc__mgr__port0_cntl  = mgr_inst[17].mgr__noc__port2_cntl  ;
  assign mgr_inst[25].noc__mgr__port0_data  = mgr_inst[17].mgr__noc__port2_data  ;
  assign mgr_inst[17].noc__mgr__port2_fc    = mgr_inst[25].mgr__noc__port0_fc    ;

  // Connecting Mgr17 Port3 to Mgr16 Port1
  assign mgr_inst[16].noc__mgr__port1_valid = mgr_inst[17].mgr__noc__port3_valid ;
  assign mgr_inst[16].noc__mgr__port1_cntl  = mgr_inst[17].mgr__noc__port3_cntl  ;
  assign mgr_inst[16].noc__mgr__port1_data  = mgr_inst[17].mgr__noc__port3_data  ;
  assign mgr_inst[17].noc__mgr__port3_fc    = mgr_inst[16].mgr__noc__port1_fc    ;

  // Connecting Mgr18 Port0 to Mgr10 Port2
  assign mgr_inst[10].noc__mgr__port2_valid = mgr_inst[18].mgr__noc__port0_valid ;
  assign mgr_inst[10].noc__mgr__port2_cntl  = mgr_inst[18].mgr__noc__port0_cntl  ;
  assign mgr_inst[10].noc__mgr__port2_data  = mgr_inst[18].mgr__noc__port0_data  ;
  assign mgr_inst[18].noc__mgr__port0_fc    = mgr_inst[10].mgr__noc__port2_fc    ;

  // Connecting Mgr18 Port1 to Mgr19 Port3
  assign mgr_inst[19].noc__mgr__port3_valid = mgr_inst[18].mgr__noc__port1_valid ;
  assign mgr_inst[19].noc__mgr__port3_cntl  = mgr_inst[18].mgr__noc__port1_cntl  ;
  assign mgr_inst[19].noc__mgr__port3_data  = mgr_inst[18].mgr__noc__port1_data  ;
  assign mgr_inst[18].noc__mgr__port1_fc    = mgr_inst[19].mgr__noc__port3_fc    ;

  // Connecting Mgr18 Port2 to Mgr26 Port0
  assign mgr_inst[26].noc__mgr__port0_valid = mgr_inst[18].mgr__noc__port2_valid ;
  assign mgr_inst[26].noc__mgr__port0_cntl  = mgr_inst[18].mgr__noc__port2_cntl  ;
  assign mgr_inst[26].noc__mgr__port0_data  = mgr_inst[18].mgr__noc__port2_data  ;
  assign mgr_inst[18].noc__mgr__port2_fc    = mgr_inst[26].mgr__noc__port0_fc    ;

  // Connecting Mgr18 Port3 to Mgr17 Port1
  assign mgr_inst[17].noc__mgr__port1_valid = mgr_inst[18].mgr__noc__port3_valid ;
  assign mgr_inst[17].noc__mgr__port1_cntl  = mgr_inst[18].mgr__noc__port3_cntl  ;
  assign mgr_inst[17].noc__mgr__port1_data  = mgr_inst[18].mgr__noc__port3_data  ;
  assign mgr_inst[18].noc__mgr__port3_fc    = mgr_inst[17].mgr__noc__port1_fc    ;

  // Connecting Mgr19 Port0 to Mgr11 Port2
  assign mgr_inst[11].noc__mgr__port2_valid = mgr_inst[19].mgr__noc__port0_valid ;
  assign mgr_inst[11].noc__mgr__port2_cntl  = mgr_inst[19].mgr__noc__port0_cntl  ;
  assign mgr_inst[11].noc__mgr__port2_data  = mgr_inst[19].mgr__noc__port0_data  ;
  assign mgr_inst[19].noc__mgr__port0_fc    = mgr_inst[11].mgr__noc__port2_fc    ;

  // Connecting Mgr19 Port1 to Mgr20 Port3
  assign mgr_inst[20].noc__mgr__port3_valid = mgr_inst[19].mgr__noc__port1_valid ;
  assign mgr_inst[20].noc__mgr__port3_cntl  = mgr_inst[19].mgr__noc__port1_cntl  ;
  assign mgr_inst[20].noc__mgr__port3_data  = mgr_inst[19].mgr__noc__port1_data  ;
  assign mgr_inst[19].noc__mgr__port1_fc    = mgr_inst[20].mgr__noc__port3_fc    ;

  // Connecting Mgr19 Port2 to Mgr27 Port0
  assign mgr_inst[27].noc__mgr__port0_valid = mgr_inst[19].mgr__noc__port2_valid ;
  assign mgr_inst[27].noc__mgr__port0_cntl  = mgr_inst[19].mgr__noc__port2_cntl  ;
  assign mgr_inst[27].noc__mgr__port0_data  = mgr_inst[19].mgr__noc__port2_data  ;
  assign mgr_inst[19].noc__mgr__port2_fc    = mgr_inst[27].mgr__noc__port0_fc    ;

  // Connecting Mgr19 Port3 to Mgr18 Port1
  assign mgr_inst[18].noc__mgr__port1_valid = mgr_inst[19].mgr__noc__port3_valid ;
  assign mgr_inst[18].noc__mgr__port1_cntl  = mgr_inst[19].mgr__noc__port3_cntl  ;
  assign mgr_inst[18].noc__mgr__port1_data  = mgr_inst[19].mgr__noc__port3_data  ;
  assign mgr_inst[19].noc__mgr__port3_fc    = mgr_inst[18].mgr__noc__port1_fc    ;

  // Connecting Mgr20 Port0 to Mgr12 Port2
  assign mgr_inst[12].noc__mgr__port2_valid = mgr_inst[20].mgr__noc__port0_valid ;
  assign mgr_inst[12].noc__mgr__port2_cntl  = mgr_inst[20].mgr__noc__port0_cntl  ;
  assign mgr_inst[12].noc__mgr__port2_data  = mgr_inst[20].mgr__noc__port0_data  ;
  assign mgr_inst[20].noc__mgr__port0_fc    = mgr_inst[12].mgr__noc__port2_fc    ;

  // Connecting Mgr20 Port1 to Mgr21 Port3
  assign mgr_inst[21].noc__mgr__port3_valid = mgr_inst[20].mgr__noc__port1_valid ;
  assign mgr_inst[21].noc__mgr__port3_cntl  = mgr_inst[20].mgr__noc__port1_cntl  ;
  assign mgr_inst[21].noc__mgr__port3_data  = mgr_inst[20].mgr__noc__port1_data  ;
  assign mgr_inst[20].noc__mgr__port1_fc    = mgr_inst[21].mgr__noc__port3_fc    ;

  // Connecting Mgr20 Port2 to Mgr28 Port0
  assign mgr_inst[28].noc__mgr__port0_valid = mgr_inst[20].mgr__noc__port2_valid ;
  assign mgr_inst[28].noc__mgr__port0_cntl  = mgr_inst[20].mgr__noc__port2_cntl  ;
  assign mgr_inst[28].noc__mgr__port0_data  = mgr_inst[20].mgr__noc__port2_data  ;
  assign mgr_inst[20].noc__mgr__port2_fc    = mgr_inst[28].mgr__noc__port0_fc    ;

  // Connecting Mgr20 Port3 to Mgr19 Port1
  assign mgr_inst[19].noc__mgr__port1_valid = mgr_inst[20].mgr__noc__port3_valid ;
  assign mgr_inst[19].noc__mgr__port1_cntl  = mgr_inst[20].mgr__noc__port3_cntl  ;
  assign mgr_inst[19].noc__mgr__port1_data  = mgr_inst[20].mgr__noc__port3_data  ;
  assign mgr_inst[20].noc__mgr__port3_fc    = mgr_inst[19].mgr__noc__port1_fc    ;

  // Connecting Mgr21 Port0 to Mgr13 Port2
  assign mgr_inst[13].noc__mgr__port2_valid = mgr_inst[21].mgr__noc__port0_valid ;
  assign mgr_inst[13].noc__mgr__port2_cntl  = mgr_inst[21].mgr__noc__port0_cntl  ;
  assign mgr_inst[13].noc__mgr__port2_data  = mgr_inst[21].mgr__noc__port0_data  ;
  assign mgr_inst[21].noc__mgr__port0_fc    = mgr_inst[13].mgr__noc__port2_fc    ;

  // Connecting Mgr21 Port1 to Mgr22 Port3
  assign mgr_inst[22].noc__mgr__port3_valid = mgr_inst[21].mgr__noc__port1_valid ;
  assign mgr_inst[22].noc__mgr__port3_cntl  = mgr_inst[21].mgr__noc__port1_cntl  ;
  assign mgr_inst[22].noc__mgr__port3_data  = mgr_inst[21].mgr__noc__port1_data  ;
  assign mgr_inst[21].noc__mgr__port1_fc    = mgr_inst[22].mgr__noc__port3_fc    ;

  // Connecting Mgr21 Port2 to Mgr29 Port0
  assign mgr_inst[29].noc__mgr__port0_valid = mgr_inst[21].mgr__noc__port2_valid ;
  assign mgr_inst[29].noc__mgr__port0_cntl  = mgr_inst[21].mgr__noc__port2_cntl  ;
  assign mgr_inst[29].noc__mgr__port0_data  = mgr_inst[21].mgr__noc__port2_data  ;
  assign mgr_inst[21].noc__mgr__port2_fc    = mgr_inst[29].mgr__noc__port0_fc    ;

  // Connecting Mgr21 Port3 to Mgr20 Port1
  assign mgr_inst[20].noc__mgr__port1_valid = mgr_inst[21].mgr__noc__port3_valid ;
  assign mgr_inst[20].noc__mgr__port1_cntl  = mgr_inst[21].mgr__noc__port3_cntl  ;
  assign mgr_inst[20].noc__mgr__port1_data  = mgr_inst[21].mgr__noc__port3_data  ;
  assign mgr_inst[21].noc__mgr__port3_fc    = mgr_inst[20].mgr__noc__port1_fc    ;

  // Connecting Mgr22 Port0 to Mgr14 Port2
  assign mgr_inst[14].noc__mgr__port2_valid = mgr_inst[22].mgr__noc__port0_valid ;
  assign mgr_inst[14].noc__mgr__port2_cntl  = mgr_inst[22].mgr__noc__port0_cntl  ;
  assign mgr_inst[14].noc__mgr__port2_data  = mgr_inst[22].mgr__noc__port0_data  ;
  assign mgr_inst[22].noc__mgr__port0_fc    = mgr_inst[14].mgr__noc__port2_fc    ;

  // Connecting Mgr22 Port1 to Mgr23 Port2
  assign mgr_inst[23].noc__mgr__port2_valid = mgr_inst[22].mgr__noc__port1_valid ;
  assign mgr_inst[23].noc__mgr__port2_cntl  = mgr_inst[22].mgr__noc__port1_cntl  ;
  assign mgr_inst[23].noc__mgr__port2_data  = mgr_inst[22].mgr__noc__port1_data  ;
  assign mgr_inst[22].noc__mgr__port1_fc    = mgr_inst[23].mgr__noc__port2_fc    ;

  // Connecting Mgr22 Port2 to Mgr30 Port0
  assign mgr_inst[30].noc__mgr__port0_valid = mgr_inst[22].mgr__noc__port2_valid ;
  assign mgr_inst[30].noc__mgr__port0_cntl  = mgr_inst[22].mgr__noc__port2_cntl  ;
  assign mgr_inst[30].noc__mgr__port0_data  = mgr_inst[22].mgr__noc__port2_data  ;
  assign mgr_inst[22].noc__mgr__port2_fc    = mgr_inst[30].mgr__noc__port0_fc    ;

  // Connecting Mgr22 Port3 to Mgr21 Port1
  assign mgr_inst[21].noc__mgr__port1_valid = mgr_inst[22].mgr__noc__port3_valid ;
  assign mgr_inst[21].noc__mgr__port1_cntl  = mgr_inst[22].mgr__noc__port3_cntl  ;
  assign mgr_inst[21].noc__mgr__port1_data  = mgr_inst[22].mgr__noc__port3_data  ;
  assign mgr_inst[22].noc__mgr__port3_fc    = mgr_inst[21].mgr__noc__port1_fc    ;

  // Terminate Mgr23's 1 unused Ports
  assign mgr_inst[23].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[23].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[23].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[23].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr23 Port0 to Mgr15 Port1
  assign mgr_inst[15].noc__mgr__port1_valid = mgr_inst[23].mgr__noc__port0_valid ;
  assign mgr_inst[15].noc__mgr__port1_cntl  = mgr_inst[23].mgr__noc__port0_cntl  ;
  assign mgr_inst[15].noc__mgr__port1_data  = mgr_inst[23].mgr__noc__port0_data  ;
  assign mgr_inst[23].noc__mgr__port0_fc    = mgr_inst[15].mgr__noc__port1_fc    ;

  // Connecting Mgr23 Port1 to Mgr31 Port0
  assign mgr_inst[31].noc__mgr__port0_valid = mgr_inst[23].mgr__noc__port1_valid ;
  assign mgr_inst[31].noc__mgr__port0_cntl  = mgr_inst[23].mgr__noc__port1_cntl  ;
  assign mgr_inst[31].noc__mgr__port0_data  = mgr_inst[23].mgr__noc__port1_data  ;
  assign mgr_inst[23].noc__mgr__port1_fc    = mgr_inst[31].mgr__noc__port0_fc    ;

  // Connecting Mgr23 Port2 to Mgr22 Port1
  assign mgr_inst[22].noc__mgr__port1_valid = mgr_inst[23].mgr__noc__port2_valid ;
  assign mgr_inst[22].noc__mgr__port1_cntl  = mgr_inst[23].mgr__noc__port2_cntl  ;
  assign mgr_inst[22].noc__mgr__port1_data  = mgr_inst[23].mgr__noc__port2_data  ;
  assign mgr_inst[23].noc__mgr__port2_fc    = mgr_inst[22].mgr__noc__port1_fc    ;

  // Terminate Mgr24's 1 unused Ports
  assign mgr_inst[24].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[24].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[24].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[24].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr24 Port0 to Mgr16 Port2
  assign mgr_inst[16].noc__mgr__port2_valid = mgr_inst[24].mgr__noc__port0_valid ;
  assign mgr_inst[16].noc__mgr__port2_cntl  = mgr_inst[24].mgr__noc__port0_cntl  ;
  assign mgr_inst[16].noc__mgr__port2_data  = mgr_inst[24].mgr__noc__port0_data  ;
  assign mgr_inst[24].noc__mgr__port0_fc    = mgr_inst[16].mgr__noc__port2_fc    ;

  // Connecting Mgr24 Port1 to Mgr25 Port3
  assign mgr_inst[25].noc__mgr__port3_valid = mgr_inst[24].mgr__noc__port1_valid ;
  assign mgr_inst[25].noc__mgr__port3_cntl  = mgr_inst[24].mgr__noc__port1_cntl  ;
  assign mgr_inst[25].noc__mgr__port3_data  = mgr_inst[24].mgr__noc__port1_data  ;
  assign mgr_inst[24].noc__mgr__port1_fc    = mgr_inst[25].mgr__noc__port3_fc    ;

  // Connecting Mgr24 Port2 to Mgr32 Port0
  assign mgr_inst[32].noc__mgr__port0_valid = mgr_inst[24].mgr__noc__port2_valid ;
  assign mgr_inst[32].noc__mgr__port0_cntl  = mgr_inst[24].mgr__noc__port2_cntl  ;
  assign mgr_inst[32].noc__mgr__port0_data  = mgr_inst[24].mgr__noc__port2_data  ;
  assign mgr_inst[24].noc__mgr__port2_fc    = mgr_inst[32].mgr__noc__port0_fc    ;

  // Connecting Mgr25 Port0 to Mgr17 Port2
  assign mgr_inst[17].noc__mgr__port2_valid = mgr_inst[25].mgr__noc__port0_valid ;
  assign mgr_inst[17].noc__mgr__port2_cntl  = mgr_inst[25].mgr__noc__port0_cntl  ;
  assign mgr_inst[17].noc__mgr__port2_data  = mgr_inst[25].mgr__noc__port0_data  ;
  assign mgr_inst[25].noc__mgr__port0_fc    = mgr_inst[17].mgr__noc__port2_fc    ;

  // Connecting Mgr25 Port1 to Mgr26 Port3
  assign mgr_inst[26].noc__mgr__port3_valid = mgr_inst[25].mgr__noc__port1_valid ;
  assign mgr_inst[26].noc__mgr__port3_cntl  = mgr_inst[25].mgr__noc__port1_cntl  ;
  assign mgr_inst[26].noc__mgr__port3_data  = mgr_inst[25].mgr__noc__port1_data  ;
  assign mgr_inst[25].noc__mgr__port1_fc    = mgr_inst[26].mgr__noc__port3_fc    ;

  // Connecting Mgr25 Port2 to Mgr33 Port0
  assign mgr_inst[33].noc__mgr__port0_valid = mgr_inst[25].mgr__noc__port2_valid ;
  assign mgr_inst[33].noc__mgr__port0_cntl  = mgr_inst[25].mgr__noc__port2_cntl  ;
  assign mgr_inst[33].noc__mgr__port0_data  = mgr_inst[25].mgr__noc__port2_data  ;
  assign mgr_inst[25].noc__mgr__port2_fc    = mgr_inst[33].mgr__noc__port0_fc    ;

  // Connecting Mgr25 Port3 to Mgr24 Port1
  assign mgr_inst[24].noc__mgr__port1_valid = mgr_inst[25].mgr__noc__port3_valid ;
  assign mgr_inst[24].noc__mgr__port1_cntl  = mgr_inst[25].mgr__noc__port3_cntl  ;
  assign mgr_inst[24].noc__mgr__port1_data  = mgr_inst[25].mgr__noc__port3_data  ;
  assign mgr_inst[25].noc__mgr__port3_fc    = mgr_inst[24].mgr__noc__port1_fc    ;

  // Connecting Mgr26 Port0 to Mgr18 Port2
  assign mgr_inst[18].noc__mgr__port2_valid = mgr_inst[26].mgr__noc__port0_valid ;
  assign mgr_inst[18].noc__mgr__port2_cntl  = mgr_inst[26].mgr__noc__port0_cntl  ;
  assign mgr_inst[18].noc__mgr__port2_data  = mgr_inst[26].mgr__noc__port0_data  ;
  assign mgr_inst[26].noc__mgr__port0_fc    = mgr_inst[18].mgr__noc__port2_fc    ;

  // Connecting Mgr26 Port1 to Mgr27 Port3
  assign mgr_inst[27].noc__mgr__port3_valid = mgr_inst[26].mgr__noc__port1_valid ;
  assign mgr_inst[27].noc__mgr__port3_cntl  = mgr_inst[26].mgr__noc__port1_cntl  ;
  assign mgr_inst[27].noc__mgr__port3_data  = mgr_inst[26].mgr__noc__port1_data  ;
  assign mgr_inst[26].noc__mgr__port1_fc    = mgr_inst[27].mgr__noc__port3_fc    ;

  // Connecting Mgr26 Port2 to Mgr34 Port0
  assign mgr_inst[34].noc__mgr__port0_valid = mgr_inst[26].mgr__noc__port2_valid ;
  assign mgr_inst[34].noc__mgr__port0_cntl  = mgr_inst[26].mgr__noc__port2_cntl  ;
  assign mgr_inst[34].noc__mgr__port0_data  = mgr_inst[26].mgr__noc__port2_data  ;
  assign mgr_inst[26].noc__mgr__port2_fc    = mgr_inst[34].mgr__noc__port0_fc    ;

  // Connecting Mgr26 Port3 to Mgr25 Port1
  assign mgr_inst[25].noc__mgr__port1_valid = mgr_inst[26].mgr__noc__port3_valid ;
  assign mgr_inst[25].noc__mgr__port1_cntl  = mgr_inst[26].mgr__noc__port3_cntl  ;
  assign mgr_inst[25].noc__mgr__port1_data  = mgr_inst[26].mgr__noc__port3_data  ;
  assign mgr_inst[26].noc__mgr__port3_fc    = mgr_inst[25].mgr__noc__port1_fc    ;

  // Connecting Mgr27 Port0 to Mgr19 Port2
  assign mgr_inst[19].noc__mgr__port2_valid = mgr_inst[27].mgr__noc__port0_valid ;
  assign mgr_inst[19].noc__mgr__port2_cntl  = mgr_inst[27].mgr__noc__port0_cntl  ;
  assign mgr_inst[19].noc__mgr__port2_data  = mgr_inst[27].mgr__noc__port0_data  ;
  assign mgr_inst[27].noc__mgr__port0_fc    = mgr_inst[19].mgr__noc__port2_fc    ;

  // Connecting Mgr27 Port1 to Mgr28 Port3
  assign mgr_inst[28].noc__mgr__port3_valid = mgr_inst[27].mgr__noc__port1_valid ;
  assign mgr_inst[28].noc__mgr__port3_cntl  = mgr_inst[27].mgr__noc__port1_cntl  ;
  assign mgr_inst[28].noc__mgr__port3_data  = mgr_inst[27].mgr__noc__port1_data  ;
  assign mgr_inst[27].noc__mgr__port1_fc    = mgr_inst[28].mgr__noc__port3_fc    ;

  // Connecting Mgr27 Port2 to Mgr35 Port0
  assign mgr_inst[35].noc__mgr__port0_valid = mgr_inst[27].mgr__noc__port2_valid ;
  assign mgr_inst[35].noc__mgr__port0_cntl  = mgr_inst[27].mgr__noc__port2_cntl  ;
  assign mgr_inst[35].noc__mgr__port0_data  = mgr_inst[27].mgr__noc__port2_data  ;
  assign mgr_inst[27].noc__mgr__port2_fc    = mgr_inst[35].mgr__noc__port0_fc    ;

  // Connecting Mgr27 Port3 to Mgr26 Port1
  assign mgr_inst[26].noc__mgr__port1_valid = mgr_inst[27].mgr__noc__port3_valid ;
  assign mgr_inst[26].noc__mgr__port1_cntl  = mgr_inst[27].mgr__noc__port3_cntl  ;
  assign mgr_inst[26].noc__mgr__port1_data  = mgr_inst[27].mgr__noc__port3_data  ;
  assign mgr_inst[27].noc__mgr__port3_fc    = mgr_inst[26].mgr__noc__port1_fc    ;

  // Connecting Mgr28 Port0 to Mgr20 Port2
  assign mgr_inst[20].noc__mgr__port2_valid = mgr_inst[28].mgr__noc__port0_valid ;
  assign mgr_inst[20].noc__mgr__port2_cntl  = mgr_inst[28].mgr__noc__port0_cntl  ;
  assign mgr_inst[20].noc__mgr__port2_data  = mgr_inst[28].mgr__noc__port0_data  ;
  assign mgr_inst[28].noc__mgr__port0_fc    = mgr_inst[20].mgr__noc__port2_fc    ;

  // Connecting Mgr28 Port1 to Mgr29 Port3
  assign mgr_inst[29].noc__mgr__port3_valid = mgr_inst[28].mgr__noc__port1_valid ;
  assign mgr_inst[29].noc__mgr__port3_cntl  = mgr_inst[28].mgr__noc__port1_cntl  ;
  assign mgr_inst[29].noc__mgr__port3_data  = mgr_inst[28].mgr__noc__port1_data  ;
  assign mgr_inst[28].noc__mgr__port1_fc    = mgr_inst[29].mgr__noc__port3_fc    ;

  // Connecting Mgr28 Port2 to Mgr36 Port0
  assign mgr_inst[36].noc__mgr__port0_valid = mgr_inst[28].mgr__noc__port2_valid ;
  assign mgr_inst[36].noc__mgr__port0_cntl  = mgr_inst[28].mgr__noc__port2_cntl  ;
  assign mgr_inst[36].noc__mgr__port0_data  = mgr_inst[28].mgr__noc__port2_data  ;
  assign mgr_inst[28].noc__mgr__port2_fc    = mgr_inst[36].mgr__noc__port0_fc    ;

  // Connecting Mgr28 Port3 to Mgr27 Port1
  assign mgr_inst[27].noc__mgr__port1_valid = mgr_inst[28].mgr__noc__port3_valid ;
  assign mgr_inst[27].noc__mgr__port1_cntl  = mgr_inst[28].mgr__noc__port3_cntl  ;
  assign mgr_inst[27].noc__mgr__port1_data  = mgr_inst[28].mgr__noc__port3_data  ;
  assign mgr_inst[28].noc__mgr__port3_fc    = mgr_inst[27].mgr__noc__port1_fc    ;

  // Connecting Mgr29 Port0 to Mgr21 Port2
  assign mgr_inst[21].noc__mgr__port2_valid = mgr_inst[29].mgr__noc__port0_valid ;
  assign mgr_inst[21].noc__mgr__port2_cntl  = mgr_inst[29].mgr__noc__port0_cntl  ;
  assign mgr_inst[21].noc__mgr__port2_data  = mgr_inst[29].mgr__noc__port0_data  ;
  assign mgr_inst[29].noc__mgr__port0_fc    = mgr_inst[21].mgr__noc__port2_fc    ;

  // Connecting Mgr29 Port1 to Mgr30 Port3
  assign mgr_inst[30].noc__mgr__port3_valid = mgr_inst[29].mgr__noc__port1_valid ;
  assign mgr_inst[30].noc__mgr__port3_cntl  = mgr_inst[29].mgr__noc__port1_cntl  ;
  assign mgr_inst[30].noc__mgr__port3_data  = mgr_inst[29].mgr__noc__port1_data  ;
  assign mgr_inst[29].noc__mgr__port1_fc    = mgr_inst[30].mgr__noc__port3_fc    ;

  // Connecting Mgr29 Port2 to Mgr37 Port0
  assign mgr_inst[37].noc__mgr__port0_valid = mgr_inst[29].mgr__noc__port2_valid ;
  assign mgr_inst[37].noc__mgr__port0_cntl  = mgr_inst[29].mgr__noc__port2_cntl  ;
  assign mgr_inst[37].noc__mgr__port0_data  = mgr_inst[29].mgr__noc__port2_data  ;
  assign mgr_inst[29].noc__mgr__port2_fc    = mgr_inst[37].mgr__noc__port0_fc    ;

  // Connecting Mgr29 Port3 to Mgr28 Port1
  assign mgr_inst[28].noc__mgr__port1_valid = mgr_inst[29].mgr__noc__port3_valid ;
  assign mgr_inst[28].noc__mgr__port1_cntl  = mgr_inst[29].mgr__noc__port3_cntl  ;
  assign mgr_inst[28].noc__mgr__port1_data  = mgr_inst[29].mgr__noc__port3_data  ;
  assign mgr_inst[29].noc__mgr__port3_fc    = mgr_inst[28].mgr__noc__port1_fc    ;

  // Connecting Mgr30 Port0 to Mgr22 Port2
  assign mgr_inst[22].noc__mgr__port2_valid = mgr_inst[30].mgr__noc__port0_valid ;
  assign mgr_inst[22].noc__mgr__port2_cntl  = mgr_inst[30].mgr__noc__port0_cntl  ;
  assign mgr_inst[22].noc__mgr__port2_data  = mgr_inst[30].mgr__noc__port0_data  ;
  assign mgr_inst[30].noc__mgr__port0_fc    = mgr_inst[22].mgr__noc__port2_fc    ;

  // Connecting Mgr30 Port1 to Mgr31 Port2
  assign mgr_inst[31].noc__mgr__port2_valid = mgr_inst[30].mgr__noc__port1_valid ;
  assign mgr_inst[31].noc__mgr__port2_cntl  = mgr_inst[30].mgr__noc__port1_cntl  ;
  assign mgr_inst[31].noc__mgr__port2_data  = mgr_inst[30].mgr__noc__port1_data  ;
  assign mgr_inst[30].noc__mgr__port1_fc    = mgr_inst[31].mgr__noc__port2_fc    ;

  // Connecting Mgr30 Port2 to Mgr38 Port0
  assign mgr_inst[38].noc__mgr__port0_valid = mgr_inst[30].mgr__noc__port2_valid ;
  assign mgr_inst[38].noc__mgr__port0_cntl  = mgr_inst[30].mgr__noc__port2_cntl  ;
  assign mgr_inst[38].noc__mgr__port0_data  = mgr_inst[30].mgr__noc__port2_data  ;
  assign mgr_inst[30].noc__mgr__port2_fc    = mgr_inst[38].mgr__noc__port0_fc    ;

  // Connecting Mgr30 Port3 to Mgr29 Port1
  assign mgr_inst[29].noc__mgr__port1_valid = mgr_inst[30].mgr__noc__port3_valid ;
  assign mgr_inst[29].noc__mgr__port1_cntl  = mgr_inst[30].mgr__noc__port3_cntl  ;
  assign mgr_inst[29].noc__mgr__port1_data  = mgr_inst[30].mgr__noc__port3_data  ;
  assign mgr_inst[30].noc__mgr__port3_fc    = mgr_inst[29].mgr__noc__port1_fc    ;

  // Terminate Mgr31's 1 unused Ports
  assign mgr_inst[31].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[31].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[31].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[31].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr31 Port0 to Mgr23 Port1
  assign mgr_inst[23].noc__mgr__port1_valid = mgr_inst[31].mgr__noc__port0_valid ;
  assign mgr_inst[23].noc__mgr__port1_cntl  = mgr_inst[31].mgr__noc__port0_cntl  ;
  assign mgr_inst[23].noc__mgr__port1_data  = mgr_inst[31].mgr__noc__port0_data  ;
  assign mgr_inst[31].noc__mgr__port0_fc    = mgr_inst[23].mgr__noc__port1_fc    ;

  // Connecting Mgr31 Port1 to Mgr39 Port0
  assign mgr_inst[39].noc__mgr__port0_valid = mgr_inst[31].mgr__noc__port1_valid ;
  assign mgr_inst[39].noc__mgr__port0_cntl  = mgr_inst[31].mgr__noc__port1_cntl  ;
  assign mgr_inst[39].noc__mgr__port0_data  = mgr_inst[31].mgr__noc__port1_data  ;
  assign mgr_inst[31].noc__mgr__port1_fc    = mgr_inst[39].mgr__noc__port0_fc    ;

  // Connecting Mgr31 Port2 to Mgr30 Port1
  assign mgr_inst[30].noc__mgr__port1_valid = mgr_inst[31].mgr__noc__port2_valid ;
  assign mgr_inst[30].noc__mgr__port1_cntl  = mgr_inst[31].mgr__noc__port2_cntl  ;
  assign mgr_inst[30].noc__mgr__port1_data  = mgr_inst[31].mgr__noc__port2_data  ;
  assign mgr_inst[31].noc__mgr__port2_fc    = mgr_inst[30].mgr__noc__port1_fc    ;

  // Terminate Mgr32's 1 unused Ports
  assign mgr_inst[32].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[32].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[32].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[32].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr32 Port0 to Mgr24 Port2
  assign mgr_inst[24].noc__mgr__port2_valid = mgr_inst[32].mgr__noc__port0_valid ;
  assign mgr_inst[24].noc__mgr__port2_cntl  = mgr_inst[32].mgr__noc__port0_cntl  ;
  assign mgr_inst[24].noc__mgr__port2_data  = mgr_inst[32].mgr__noc__port0_data  ;
  assign mgr_inst[32].noc__mgr__port0_fc    = mgr_inst[24].mgr__noc__port2_fc    ;

  // Connecting Mgr32 Port1 to Mgr33 Port3
  assign mgr_inst[33].noc__mgr__port3_valid = mgr_inst[32].mgr__noc__port1_valid ;
  assign mgr_inst[33].noc__mgr__port3_cntl  = mgr_inst[32].mgr__noc__port1_cntl  ;
  assign mgr_inst[33].noc__mgr__port3_data  = mgr_inst[32].mgr__noc__port1_data  ;
  assign mgr_inst[32].noc__mgr__port1_fc    = mgr_inst[33].mgr__noc__port3_fc    ;

  // Connecting Mgr32 Port2 to Mgr40 Port0
  assign mgr_inst[40].noc__mgr__port0_valid = mgr_inst[32].mgr__noc__port2_valid ;
  assign mgr_inst[40].noc__mgr__port0_cntl  = mgr_inst[32].mgr__noc__port2_cntl  ;
  assign mgr_inst[40].noc__mgr__port0_data  = mgr_inst[32].mgr__noc__port2_data  ;
  assign mgr_inst[32].noc__mgr__port2_fc    = mgr_inst[40].mgr__noc__port0_fc    ;

  // Connecting Mgr33 Port0 to Mgr25 Port2
  assign mgr_inst[25].noc__mgr__port2_valid = mgr_inst[33].mgr__noc__port0_valid ;
  assign mgr_inst[25].noc__mgr__port2_cntl  = mgr_inst[33].mgr__noc__port0_cntl  ;
  assign mgr_inst[25].noc__mgr__port2_data  = mgr_inst[33].mgr__noc__port0_data  ;
  assign mgr_inst[33].noc__mgr__port0_fc    = mgr_inst[25].mgr__noc__port2_fc    ;

  // Connecting Mgr33 Port1 to Mgr34 Port3
  assign mgr_inst[34].noc__mgr__port3_valid = mgr_inst[33].mgr__noc__port1_valid ;
  assign mgr_inst[34].noc__mgr__port3_cntl  = mgr_inst[33].mgr__noc__port1_cntl  ;
  assign mgr_inst[34].noc__mgr__port3_data  = mgr_inst[33].mgr__noc__port1_data  ;
  assign mgr_inst[33].noc__mgr__port1_fc    = mgr_inst[34].mgr__noc__port3_fc    ;

  // Connecting Mgr33 Port2 to Mgr41 Port0
  assign mgr_inst[41].noc__mgr__port0_valid = mgr_inst[33].mgr__noc__port2_valid ;
  assign mgr_inst[41].noc__mgr__port0_cntl  = mgr_inst[33].mgr__noc__port2_cntl  ;
  assign mgr_inst[41].noc__mgr__port0_data  = mgr_inst[33].mgr__noc__port2_data  ;
  assign mgr_inst[33].noc__mgr__port2_fc    = mgr_inst[41].mgr__noc__port0_fc    ;

  // Connecting Mgr33 Port3 to Mgr32 Port1
  assign mgr_inst[32].noc__mgr__port1_valid = mgr_inst[33].mgr__noc__port3_valid ;
  assign mgr_inst[32].noc__mgr__port1_cntl  = mgr_inst[33].mgr__noc__port3_cntl  ;
  assign mgr_inst[32].noc__mgr__port1_data  = mgr_inst[33].mgr__noc__port3_data  ;
  assign mgr_inst[33].noc__mgr__port3_fc    = mgr_inst[32].mgr__noc__port1_fc    ;

  // Connecting Mgr34 Port0 to Mgr26 Port2
  assign mgr_inst[26].noc__mgr__port2_valid = mgr_inst[34].mgr__noc__port0_valid ;
  assign mgr_inst[26].noc__mgr__port2_cntl  = mgr_inst[34].mgr__noc__port0_cntl  ;
  assign mgr_inst[26].noc__mgr__port2_data  = mgr_inst[34].mgr__noc__port0_data  ;
  assign mgr_inst[34].noc__mgr__port0_fc    = mgr_inst[26].mgr__noc__port2_fc    ;

  // Connecting Mgr34 Port1 to Mgr35 Port3
  assign mgr_inst[35].noc__mgr__port3_valid = mgr_inst[34].mgr__noc__port1_valid ;
  assign mgr_inst[35].noc__mgr__port3_cntl  = mgr_inst[34].mgr__noc__port1_cntl  ;
  assign mgr_inst[35].noc__mgr__port3_data  = mgr_inst[34].mgr__noc__port1_data  ;
  assign mgr_inst[34].noc__mgr__port1_fc    = mgr_inst[35].mgr__noc__port3_fc    ;

  // Connecting Mgr34 Port2 to Mgr42 Port0
  assign mgr_inst[42].noc__mgr__port0_valid = mgr_inst[34].mgr__noc__port2_valid ;
  assign mgr_inst[42].noc__mgr__port0_cntl  = mgr_inst[34].mgr__noc__port2_cntl  ;
  assign mgr_inst[42].noc__mgr__port0_data  = mgr_inst[34].mgr__noc__port2_data  ;
  assign mgr_inst[34].noc__mgr__port2_fc    = mgr_inst[42].mgr__noc__port0_fc    ;

  // Connecting Mgr34 Port3 to Mgr33 Port1
  assign mgr_inst[33].noc__mgr__port1_valid = mgr_inst[34].mgr__noc__port3_valid ;
  assign mgr_inst[33].noc__mgr__port1_cntl  = mgr_inst[34].mgr__noc__port3_cntl  ;
  assign mgr_inst[33].noc__mgr__port1_data  = mgr_inst[34].mgr__noc__port3_data  ;
  assign mgr_inst[34].noc__mgr__port3_fc    = mgr_inst[33].mgr__noc__port1_fc    ;

  // Connecting Mgr35 Port0 to Mgr27 Port2
  assign mgr_inst[27].noc__mgr__port2_valid = mgr_inst[35].mgr__noc__port0_valid ;
  assign mgr_inst[27].noc__mgr__port2_cntl  = mgr_inst[35].mgr__noc__port0_cntl  ;
  assign mgr_inst[27].noc__mgr__port2_data  = mgr_inst[35].mgr__noc__port0_data  ;
  assign mgr_inst[35].noc__mgr__port0_fc    = mgr_inst[27].mgr__noc__port2_fc    ;

  // Connecting Mgr35 Port1 to Mgr36 Port3
  assign mgr_inst[36].noc__mgr__port3_valid = mgr_inst[35].mgr__noc__port1_valid ;
  assign mgr_inst[36].noc__mgr__port3_cntl  = mgr_inst[35].mgr__noc__port1_cntl  ;
  assign mgr_inst[36].noc__mgr__port3_data  = mgr_inst[35].mgr__noc__port1_data  ;
  assign mgr_inst[35].noc__mgr__port1_fc    = mgr_inst[36].mgr__noc__port3_fc    ;

  // Connecting Mgr35 Port2 to Mgr43 Port0
  assign mgr_inst[43].noc__mgr__port0_valid = mgr_inst[35].mgr__noc__port2_valid ;
  assign mgr_inst[43].noc__mgr__port0_cntl  = mgr_inst[35].mgr__noc__port2_cntl  ;
  assign mgr_inst[43].noc__mgr__port0_data  = mgr_inst[35].mgr__noc__port2_data  ;
  assign mgr_inst[35].noc__mgr__port2_fc    = mgr_inst[43].mgr__noc__port0_fc    ;

  // Connecting Mgr35 Port3 to Mgr34 Port1
  assign mgr_inst[34].noc__mgr__port1_valid = mgr_inst[35].mgr__noc__port3_valid ;
  assign mgr_inst[34].noc__mgr__port1_cntl  = mgr_inst[35].mgr__noc__port3_cntl  ;
  assign mgr_inst[34].noc__mgr__port1_data  = mgr_inst[35].mgr__noc__port3_data  ;
  assign mgr_inst[35].noc__mgr__port3_fc    = mgr_inst[34].mgr__noc__port1_fc    ;

  // Connecting Mgr36 Port0 to Mgr28 Port2
  assign mgr_inst[28].noc__mgr__port2_valid = mgr_inst[36].mgr__noc__port0_valid ;
  assign mgr_inst[28].noc__mgr__port2_cntl  = mgr_inst[36].mgr__noc__port0_cntl  ;
  assign mgr_inst[28].noc__mgr__port2_data  = mgr_inst[36].mgr__noc__port0_data  ;
  assign mgr_inst[36].noc__mgr__port0_fc    = mgr_inst[28].mgr__noc__port2_fc    ;

  // Connecting Mgr36 Port1 to Mgr37 Port3
  assign mgr_inst[37].noc__mgr__port3_valid = mgr_inst[36].mgr__noc__port1_valid ;
  assign mgr_inst[37].noc__mgr__port3_cntl  = mgr_inst[36].mgr__noc__port1_cntl  ;
  assign mgr_inst[37].noc__mgr__port3_data  = mgr_inst[36].mgr__noc__port1_data  ;
  assign mgr_inst[36].noc__mgr__port1_fc    = mgr_inst[37].mgr__noc__port3_fc    ;

  // Connecting Mgr36 Port2 to Mgr44 Port0
  assign mgr_inst[44].noc__mgr__port0_valid = mgr_inst[36].mgr__noc__port2_valid ;
  assign mgr_inst[44].noc__mgr__port0_cntl  = mgr_inst[36].mgr__noc__port2_cntl  ;
  assign mgr_inst[44].noc__mgr__port0_data  = mgr_inst[36].mgr__noc__port2_data  ;
  assign mgr_inst[36].noc__mgr__port2_fc    = mgr_inst[44].mgr__noc__port0_fc    ;

  // Connecting Mgr36 Port3 to Mgr35 Port1
  assign mgr_inst[35].noc__mgr__port1_valid = mgr_inst[36].mgr__noc__port3_valid ;
  assign mgr_inst[35].noc__mgr__port1_cntl  = mgr_inst[36].mgr__noc__port3_cntl  ;
  assign mgr_inst[35].noc__mgr__port1_data  = mgr_inst[36].mgr__noc__port3_data  ;
  assign mgr_inst[36].noc__mgr__port3_fc    = mgr_inst[35].mgr__noc__port1_fc    ;

  // Connecting Mgr37 Port0 to Mgr29 Port2
  assign mgr_inst[29].noc__mgr__port2_valid = mgr_inst[37].mgr__noc__port0_valid ;
  assign mgr_inst[29].noc__mgr__port2_cntl  = mgr_inst[37].mgr__noc__port0_cntl  ;
  assign mgr_inst[29].noc__mgr__port2_data  = mgr_inst[37].mgr__noc__port0_data  ;
  assign mgr_inst[37].noc__mgr__port0_fc    = mgr_inst[29].mgr__noc__port2_fc    ;

  // Connecting Mgr37 Port1 to Mgr38 Port3
  assign mgr_inst[38].noc__mgr__port3_valid = mgr_inst[37].mgr__noc__port1_valid ;
  assign mgr_inst[38].noc__mgr__port3_cntl  = mgr_inst[37].mgr__noc__port1_cntl  ;
  assign mgr_inst[38].noc__mgr__port3_data  = mgr_inst[37].mgr__noc__port1_data  ;
  assign mgr_inst[37].noc__mgr__port1_fc    = mgr_inst[38].mgr__noc__port3_fc    ;

  // Connecting Mgr37 Port2 to Mgr45 Port0
  assign mgr_inst[45].noc__mgr__port0_valid = mgr_inst[37].mgr__noc__port2_valid ;
  assign mgr_inst[45].noc__mgr__port0_cntl  = mgr_inst[37].mgr__noc__port2_cntl  ;
  assign mgr_inst[45].noc__mgr__port0_data  = mgr_inst[37].mgr__noc__port2_data  ;
  assign mgr_inst[37].noc__mgr__port2_fc    = mgr_inst[45].mgr__noc__port0_fc    ;

  // Connecting Mgr37 Port3 to Mgr36 Port1
  assign mgr_inst[36].noc__mgr__port1_valid = mgr_inst[37].mgr__noc__port3_valid ;
  assign mgr_inst[36].noc__mgr__port1_cntl  = mgr_inst[37].mgr__noc__port3_cntl  ;
  assign mgr_inst[36].noc__mgr__port1_data  = mgr_inst[37].mgr__noc__port3_data  ;
  assign mgr_inst[37].noc__mgr__port3_fc    = mgr_inst[36].mgr__noc__port1_fc    ;

  // Connecting Mgr38 Port0 to Mgr30 Port2
  assign mgr_inst[30].noc__mgr__port2_valid = mgr_inst[38].mgr__noc__port0_valid ;
  assign mgr_inst[30].noc__mgr__port2_cntl  = mgr_inst[38].mgr__noc__port0_cntl  ;
  assign mgr_inst[30].noc__mgr__port2_data  = mgr_inst[38].mgr__noc__port0_data  ;
  assign mgr_inst[38].noc__mgr__port0_fc    = mgr_inst[30].mgr__noc__port2_fc    ;

  // Connecting Mgr38 Port1 to Mgr39 Port2
  assign mgr_inst[39].noc__mgr__port2_valid = mgr_inst[38].mgr__noc__port1_valid ;
  assign mgr_inst[39].noc__mgr__port2_cntl  = mgr_inst[38].mgr__noc__port1_cntl  ;
  assign mgr_inst[39].noc__mgr__port2_data  = mgr_inst[38].mgr__noc__port1_data  ;
  assign mgr_inst[38].noc__mgr__port1_fc    = mgr_inst[39].mgr__noc__port2_fc    ;

  // Connecting Mgr38 Port2 to Mgr46 Port0
  assign mgr_inst[46].noc__mgr__port0_valid = mgr_inst[38].mgr__noc__port2_valid ;
  assign mgr_inst[46].noc__mgr__port0_cntl  = mgr_inst[38].mgr__noc__port2_cntl  ;
  assign mgr_inst[46].noc__mgr__port0_data  = mgr_inst[38].mgr__noc__port2_data  ;
  assign mgr_inst[38].noc__mgr__port2_fc    = mgr_inst[46].mgr__noc__port0_fc    ;

  // Connecting Mgr38 Port3 to Mgr37 Port1
  assign mgr_inst[37].noc__mgr__port1_valid = mgr_inst[38].mgr__noc__port3_valid ;
  assign mgr_inst[37].noc__mgr__port1_cntl  = mgr_inst[38].mgr__noc__port3_cntl  ;
  assign mgr_inst[37].noc__mgr__port1_data  = mgr_inst[38].mgr__noc__port3_data  ;
  assign mgr_inst[38].noc__mgr__port3_fc    = mgr_inst[37].mgr__noc__port1_fc    ;

  // Terminate Mgr39's 1 unused Ports
  assign mgr_inst[39].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[39].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[39].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[39].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr39 Port0 to Mgr31 Port1
  assign mgr_inst[31].noc__mgr__port1_valid = mgr_inst[39].mgr__noc__port0_valid ;
  assign mgr_inst[31].noc__mgr__port1_cntl  = mgr_inst[39].mgr__noc__port0_cntl  ;
  assign mgr_inst[31].noc__mgr__port1_data  = mgr_inst[39].mgr__noc__port0_data  ;
  assign mgr_inst[39].noc__mgr__port0_fc    = mgr_inst[31].mgr__noc__port1_fc    ;

  // Connecting Mgr39 Port1 to Mgr47 Port0
  assign mgr_inst[47].noc__mgr__port0_valid = mgr_inst[39].mgr__noc__port1_valid ;
  assign mgr_inst[47].noc__mgr__port0_cntl  = mgr_inst[39].mgr__noc__port1_cntl  ;
  assign mgr_inst[47].noc__mgr__port0_data  = mgr_inst[39].mgr__noc__port1_data  ;
  assign mgr_inst[39].noc__mgr__port1_fc    = mgr_inst[47].mgr__noc__port0_fc    ;

  // Connecting Mgr39 Port2 to Mgr38 Port1
  assign mgr_inst[38].noc__mgr__port1_valid = mgr_inst[39].mgr__noc__port2_valid ;
  assign mgr_inst[38].noc__mgr__port1_cntl  = mgr_inst[39].mgr__noc__port2_cntl  ;
  assign mgr_inst[38].noc__mgr__port1_data  = mgr_inst[39].mgr__noc__port2_data  ;
  assign mgr_inst[39].noc__mgr__port2_fc    = mgr_inst[38].mgr__noc__port1_fc    ;

  // Terminate Mgr40's 1 unused Ports
  assign mgr_inst[40].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[40].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[40].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[40].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr40 Port0 to Mgr32 Port2
  assign mgr_inst[32].noc__mgr__port2_valid = mgr_inst[40].mgr__noc__port0_valid ;
  assign mgr_inst[32].noc__mgr__port2_cntl  = mgr_inst[40].mgr__noc__port0_cntl  ;
  assign mgr_inst[32].noc__mgr__port2_data  = mgr_inst[40].mgr__noc__port0_data  ;
  assign mgr_inst[40].noc__mgr__port0_fc    = mgr_inst[32].mgr__noc__port2_fc    ;

  // Connecting Mgr40 Port1 to Mgr41 Port3
  assign mgr_inst[41].noc__mgr__port3_valid = mgr_inst[40].mgr__noc__port1_valid ;
  assign mgr_inst[41].noc__mgr__port3_cntl  = mgr_inst[40].mgr__noc__port1_cntl  ;
  assign mgr_inst[41].noc__mgr__port3_data  = mgr_inst[40].mgr__noc__port1_data  ;
  assign mgr_inst[40].noc__mgr__port1_fc    = mgr_inst[41].mgr__noc__port3_fc    ;

  // Connecting Mgr40 Port2 to Mgr48 Port0
  assign mgr_inst[48].noc__mgr__port0_valid = mgr_inst[40].mgr__noc__port2_valid ;
  assign mgr_inst[48].noc__mgr__port0_cntl  = mgr_inst[40].mgr__noc__port2_cntl  ;
  assign mgr_inst[48].noc__mgr__port0_data  = mgr_inst[40].mgr__noc__port2_data  ;
  assign mgr_inst[40].noc__mgr__port2_fc    = mgr_inst[48].mgr__noc__port0_fc    ;

  // Connecting Mgr41 Port0 to Mgr33 Port2
  assign mgr_inst[33].noc__mgr__port2_valid = mgr_inst[41].mgr__noc__port0_valid ;
  assign mgr_inst[33].noc__mgr__port2_cntl  = mgr_inst[41].mgr__noc__port0_cntl  ;
  assign mgr_inst[33].noc__mgr__port2_data  = mgr_inst[41].mgr__noc__port0_data  ;
  assign mgr_inst[41].noc__mgr__port0_fc    = mgr_inst[33].mgr__noc__port2_fc    ;

  // Connecting Mgr41 Port1 to Mgr42 Port3
  assign mgr_inst[42].noc__mgr__port3_valid = mgr_inst[41].mgr__noc__port1_valid ;
  assign mgr_inst[42].noc__mgr__port3_cntl  = mgr_inst[41].mgr__noc__port1_cntl  ;
  assign mgr_inst[42].noc__mgr__port3_data  = mgr_inst[41].mgr__noc__port1_data  ;
  assign mgr_inst[41].noc__mgr__port1_fc    = mgr_inst[42].mgr__noc__port3_fc    ;

  // Connecting Mgr41 Port2 to Mgr49 Port0
  assign mgr_inst[49].noc__mgr__port0_valid = mgr_inst[41].mgr__noc__port2_valid ;
  assign mgr_inst[49].noc__mgr__port0_cntl  = mgr_inst[41].mgr__noc__port2_cntl  ;
  assign mgr_inst[49].noc__mgr__port0_data  = mgr_inst[41].mgr__noc__port2_data  ;
  assign mgr_inst[41].noc__mgr__port2_fc    = mgr_inst[49].mgr__noc__port0_fc    ;

  // Connecting Mgr41 Port3 to Mgr40 Port1
  assign mgr_inst[40].noc__mgr__port1_valid = mgr_inst[41].mgr__noc__port3_valid ;
  assign mgr_inst[40].noc__mgr__port1_cntl  = mgr_inst[41].mgr__noc__port3_cntl  ;
  assign mgr_inst[40].noc__mgr__port1_data  = mgr_inst[41].mgr__noc__port3_data  ;
  assign mgr_inst[41].noc__mgr__port3_fc    = mgr_inst[40].mgr__noc__port1_fc    ;

  // Connecting Mgr42 Port0 to Mgr34 Port2
  assign mgr_inst[34].noc__mgr__port2_valid = mgr_inst[42].mgr__noc__port0_valid ;
  assign mgr_inst[34].noc__mgr__port2_cntl  = mgr_inst[42].mgr__noc__port0_cntl  ;
  assign mgr_inst[34].noc__mgr__port2_data  = mgr_inst[42].mgr__noc__port0_data  ;
  assign mgr_inst[42].noc__mgr__port0_fc    = mgr_inst[34].mgr__noc__port2_fc    ;

  // Connecting Mgr42 Port1 to Mgr43 Port3
  assign mgr_inst[43].noc__mgr__port3_valid = mgr_inst[42].mgr__noc__port1_valid ;
  assign mgr_inst[43].noc__mgr__port3_cntl  = mgr_inst[42].mgr__noc__port1_cntl  ;
  assign mgr_inst[43].noc__mgr__port3_data  = mgr_inst[42].mgr__noc__port1_data  ;
  assign mgr_inst[42].noc__mgr__port1_fc    = mgr_inst[43].mgr__noc__port3_fc    ;

  // Connecting Mgr42 Port2 to Mgr50 Port0
  assign mgr_inst[50].noc__mgr__port0_valid = mgr_inst[42].mgr__noc__port2_valid ;
  assign mgr_inst[50].noc__mgr__port0_cntl  = mgr_inst[42].mgr__noc__port2_cntl  ;
  assign mgr_inst[50].noc__mgr__port0_data  = mgr_inst[42].mgr__noc__port2_data  ;
  assign mgr_inst[42].noc__mgr__port2_fc    = mgr_inst[50].mgr__noc__port0_fc    ;

  // Connecting Mgr42 Port3 to Mgr41 Port1
  assign mgr_inst[41].noc__mgr__port1_valid = mgr_inst[42].mgr__noc__port3_valid ;
  assign mgr_inst[41].noc__mgr__port1_cntl  = mgr_inst[42].mgr__noc__port3_cntl  ;
  assign mgr_inst[41].noc__mgr__port1_data  = mgr_inst[42].mgr__noc__port3_data  ;
  assign mgr_inst[42].noc__mgr__port3_fc    = mgr_inst[41].mgr__noc__port1_fc    ;

  // Connecting Mgr43 Port0 to Mgr35 Port2
  assign mgr_inst[35].noc__mgr__port2_valid = mgr_inst[43].mgr__noc__port0_valid ;
  assign mgr_inst[35].noc__mgr__port2_cntl  = mgr_inst[43].mgr__noc__port0_cntl  ;
  assign mgr_inst[35].noc__mgr__port2_data  = mgr_inst[43].mgr__noc__port0_data  ;
  assign mgr_inst[43].noc__mgr__port0_fc    = mgr_inst[35].mgr__noc__port2_fc    ;

  // Connecting Mgr43 Port1 to Mgr44 Port3
  assign mgr_inst[44].noc__mgr__port3_valid = mgr_inst[43].mgr__noc__port1_valid ;
  assign mgr_inst[44].noc__mgr__port3_cntl  = mgr_inst[43].mgr__noc__port1_cntl  ;
  assign mgr_inst[44].noc__mgr__port3_data  = mgr_inst[43].mgr__noc__port1_data  ;
  assign mgr_inst[43].noc__mgr__port1_fc    = mgr_inst[44].mgr__noc__port3_fc    ;

  // Connecting Mgr43 Port2 to Mgr51 Port0
  assign mgr_inst[51].noc__mgr__port0_valid = mgr_inst[43].mgr__noc__port2_valid ;
  assign mgr_inst[51].noc__mgr__port0_cntl  = mgr_inst[43].mgr__noc__port2_cntl  ;
  assign mgr_inst[51].noc__mgr__port0_data  = mgr_inst[43].mgr__noc__port2_data  ;
  assign mgr_inst[43].noc__mgr__port2_fc    = mgr_inst[51].mgr__noc__port0_fc    ;

  // Connecting Mgr43 Port3 to Mgr42 Port1
  assign mgr_inst[42].noc__mgr__port1_valid = mgr_inst[43].mgr__noc__port3_valid ;
  assign mgr_inst[42].noc__mgr__port1_cntl  = mgr_inst[43].mgr__noc__port3_cntl  ;
  assign mgr_inst[42].noc__mgr__port1_data  = mgr_inst[43].mgr__noc__port3_data  ;
  assign mgr_inst[43].noc__mgr__port3_fc    = mgr_inst[42].mgr__noc__port1_fc    ;

  // Connecting Mgr44 Port0 to Mgr36 Port2
  assign mgr_inst[36].noc__mgr__port2_valid = mgr_inst[44].mgr__noc__port0_valid ;
  assign mgr_inst[36].noc__mgr__port2_cntl  = mgr_inst[44].mgr__noc__port0_cntl  ;
  assign mgr_inst[36].noc__mgr__port2_data  = mgr_inst[44].mgr__noc__port0_data  ;
  assign mgr_inst[44].noc__mgr__port0_fc    = mgr_inst[36].mgr__noc__port2_fc    ;

  // Connecting Mgr44 Port1 to Mgr45 Port3
  assign mgr_inst[45].noc__mgr__port3_valid = mgr_inst[44].mgr__noc__port1_valid ;
  assign mgr_inst[45].noc__mgr__port3_cntl  = mgr_inst[44].mgr__noc__port1_cntl  ;
  assign mgr_inst[45].noc__mgr__port3_data  = mgr_inst[44].mgr__noc__port1_data  ;
  assign mgr_inst[44].noc__mgr__port1_fc    = mgr_inst[45].mgr__noc__port3_fc    ;

  // Connecting Mgr44 Port2 to Mgr52 Port0
  assign mgr_inst[52].noc__mgr__port0_valid = mgr_inst[44].mgr__noc__port2_valid ;
  assign mgr_inst[52].noc__mgr__port0_cntl  = mgr_inst[44].mgr__noc__port2_cntl  ;
  assign mgr_inst[52].noc__mgr__port0_data  = mgr_inst[44].mgr__noc__port2_data  ;
  assign mgr_inst[44].noc__mgr__port2_fc    = mgr_inst[52].mgr__noc__port0_fc    ;

  // Connecting Mgr44 Port3 to Mgr43 Port1
  assign mgr_inst[43].noc__mgr__port1_valid = mgr_inst[44].mgr__noc__port3_valid ;
  assign mgr_inst[43].noc__mgr__port1_cntl  = mgr_inst[44].mgr__noc__port3_cntl  ;
  assign mgr_inst[43].noc__mgr__port1_data  = mgr_inst[44].mgr__noc__port3_data  ;
  assign mgr_inst[44].noc__mgr__port3_fc    = mgr_inst[43].mgr__noc__port1_fc    ;

  // Connecting Mgr45 Port0 to Mgr37 Port2
  assign mgr_inst[37].noc__mgr__port2_valid = mgr_inst[45].mgr__noc__port0_valid ;
  assign mgr_inst[37].noc__mgr__port2_cntl  = mgr_inst[45].mgr__noc__port0_cntl  ;
  assign mgr_inst[37].noc__mgr__port2_data  = mgr_inst[45].mgr__noc__port0_data  ;
  assign mgr_inst[45].noc__mgr__port0_fc    = mgr_inst[37].mgr__noc__port2_fc    ;

  // Connecting Mgr45 Port1 to Mgr46 Port3
  assign mgr_inst[46].noc__mgr__port3_valid = mgr_inst[45].mgr__noc__port1_valid ;
  assign mgr_inst[46].noc__mgr__port3_cntl  = mgr_inst[45].mgr__noc__port1_cntl  ;
  assign mgr_inst[46].noc__mgr__port3_data  = mgr_inst[45].mgr__noc__port1_data  ;
  assign mgr_inst[45].noc__mgr__port1_fc    = mgr_inst[46].mgr__noc__port3_fc    ;

  // Connecting Mgr45 Port2 to Mgr53 Port0
  assign mgr_inst[53].noc__mgr__port0_valid = mgr_inst[45].mgr__noc__port2_valid ;
  assign mgr_inst[53].noc__mgr__port0_cntl  = mgr_inst[45].mgr__noc__port2_cntl  ;
  assign mgr_inst[53].noc__mgr__port0_data  = mgr_inst[45].mgr__noc__port2_data  ;
  assign mgr_inst[45].noc__mgr__port2_fc    = mgr_inst[53].mgr__noc__port0_fc    ;

  // Connecting Mgr45 Port3 to Mgr44 Port1
  assign mgr_inst[44].noc__mgr__port1_valid = mgr_inst[45].mgr__noc__port3_valid ;
  assign mgr_inst[44].noc__mgr__port1_cntl  = mgr_inst[45].mgr__noc__port3_cntl  ;
  assign mgr_inst[44].noc__mgr__port1_data  = mgr_inst[45].mgr__noc__port3_data  ;
  assign mgr_inst[45].noc__mgr__port3_fc    = mgr_inst[44].mgr__noc__port1_fc    ;

  // Connecting Mgr46 Port0 to Mgr38 Port2
  assign mgr_inst[38].noc__mgr__port2_valid = mgr_inst[46].mgr__noc__port0_valid ;
  assign mgr_inst[38].noc__mgr__port2_cntl  = mgr_inst[46].mgr__noc__port0_cntl  ;
  assign mgr_inst[38].noc__mgr__port2_data  = mgr_inst[46].mgr__noc__port0_data  ;
  assign mgr_inst[46].noc__mgr__port0_fc    = mgr_inst[38].mgr__noc__port2_fc    ;

  // Connecting Mgr46 Port1 to Mgr47 Port2
  assign mgr_inst[47].noc__mgr__port2_valid = mgr_inst[46].mgr__noc__port1_valid ;
  assign mgr_inst[47].noc__mgr__port2_cntl  = mgr_inst[46].mgr__noc__port1_cntl  ;
  assign mgr_inst[47].noc__mgr__port2_data  = mgr_inst[46].mgr__noc__port1_data  ;
  assign mgr_inst[46].noc__mgr__port1_fc    = mgr_inst[47].mgr__noc__port2_fc    ;

  // Connecting Mgr46 Port2 to Mgr54 Port0
  assign mgr_inst[54].noc__mgr__port0_valid = mgr_inst[46].mgr__noc__port2_valid ;
  assign mgr_inst[54].noc__mgr__port0_cntl  = mgr_inst[46].mgr__noc__port2_cntl  ;
  assign mgr_inst[54].noc__mgr__port0_data  = mgr_inst[46].mgr__noc__port2_data  ;
  assign mgr_inst[46].noc__mgr__port2_fc    = mgr_inst[54].mgr__noc__port0_fc    ;

  // Connecting Mgr46 Port3 to Mgr45 Port1
  assign mgr_inst[45].noc__mgr__port1_valid = mgr_inst[46].mgr__noc__port3_valid ;
  assign mgr_inst[45].noc__mgr__port1_cntl  = mgr_inst[46].mgr__noc__port3_cntl  ;
  assign mgr_inst[45].noc__mgr__port1_data  = mgr_inst[46].mgr__noc__port3_data  ;
  assign mgr_inst[46].noc__mgr__port3_fc    = mgr_inst[45].mgr__noc__port1_fc    ;

  // Terminate Mgr47's 1 unused Ports
  assign mgr_inst[47].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[47].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[47].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[47].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr47 Port0 to Mgr39 Port1
  assign mgr_inst[39].noc__mgr__port1_valid = mgr_inst[47].mgr__noc__port0_valid ;
  assign mgr_inst[39].noc__mgr__port1_cntl  = mgr_inst[47].mgr__noc__port0_cntl  ;
  assign mgr_inst[39].noc__mgr__port1_data  = mgr_inst[47].mgr__noc__port0_data  ;
  assign mgr_inst[47].noc__mgr__port0_fc    = mgr_inst[39].mgr__noc__port1_fc    ;

  // Connecting Mgr47 Port1 to Mgr55 Port0
  assign mgr_inst[55].noc__mgr__port0_valid = mgr_inst[47].mgr__noc__port1_valid ;
  assign mgr_inst[55].noc__mgr__port0_cntl  = mgr_inst[47].mgr__noc__port1_cntl  ;
  assign mgr_inst[55].noc__mgr__port0_data  = mgr_inst[47].mgr__noc__port1_data  ;
  assign mgr_inst[47].noc__mgr__port1_fc    = mgr_inst[55].mgr__noc__port0_fc    ;

  // Connecting Mgr47 Port2 to Mgr46 Port1
  assign mgr_inst[46].noc__mgr__port1_valid = mgr_inst[47].mgr__noc__port2_valid ;
  assign mgr_inst[46].noc__mgr__port1_cntl  = mgr_inst[47].mgr__noc__port2_cntl  ;
  assign mgr_inst[46].noc__mgr__port1_data  = mgr_inst[47].mgr__noc__port2_data  ;
  assign mgr_inst[47].noc__mgr__port2_fc    = mgr_inst[46].mgr__noc__port1_fc    ;

  // Terminate Mgr48's 1 unused Ports
  assign mgr_inst[48].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[48].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[48].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[48].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr48 Port0 to Mgr40 Port2
  assign mgr_inst[40].noc__mgr__port2_valid = mgr_inst[48].mgr__noc__port0_valid ;
  assign mgr_inst[40].noc__mgr__port2_cntl  = mgr_inst[48].mgr__noc__port0_cntl  ;
  assign mgr_inst[40].noc__mgr__port2_data  = mgr_inst[48].mgr__noc__port0_data  ;
  assign mgr_inst[48].noc__mgr__port0_fc    = mgr_inst[40].mgr__noc__port2_fc    ;

  // Connecting Mgr48 Port1 to Mgr49 Port3
  assign mgr_inst[49].noc__mgr__port3_valid = mgr_inst[48].mgr__noc__port1_valid ;
  assign mgr_inst[49].noc__mgr__port3_cntl  = mgr_inst[48].mgr__noc__port1_cntl  ;
  assign mgr_inst[49].noc__mgr__port3_data  = mgr_inst[48].mgr__noc__port1_data  ;
  assign mgr_inst[48].noc__mgr__port1_fc    = mgr_inst[49].mgr__noc__port3_fc    ;

  // Connecting Mgr48 Port2 to Mgr56 Port0
  assign mgr_inst[56].noc__mgr__port0_valid = mgr_inst[48].mgr__noc__port2_valid ;
  assign mgr_inst[56].noc__mgr__port0_cntl  = mgr_inst[48].mgr__noc__port2_cntl  ;
  assign mgr_inst[56].noc__mgr__port0_data  = mgr_inst[48].mgr__noc__port2_data  ;
  assign mgr_inst[48].noc__mgr__port2_fc    = mgr_inst[56].mgr__noc__port0_fc    ;

  // Connecting Mgr49 Port0 to Mgr41 Port2
  assign mgr_inst[41].noc__mgr__port2_valid = mgr_inst[49].mgr__noc__port0_valid ;
  assign mgr_inst[41].noc__mgr__port2_cntl  = mgr_inst[49].mgr__noc__port0_cntl  ;
  assign mgr_inst[41].noc__mgr__port2_data  = mgr_inst[49].mgr__noc__port0_data  ;
  assign mgr_inst[49].noc__mgr__port0_fc    = mgr_inst[41].mgr__noc__port2_fc    ;

  // Connecting Mgr49 Port1 to Mgr50 Port3
  assign mgr_inst[50].noc__mgr__port3_valid = mgr_inst[49].mgr__noc__port1_valid ;
  assign mgr_inst[50].noc__mgr__port3_cntl  = mgr_inst[49].mgr__noc__port1_cntl  ;
  assign mgr_inst[50].noc__mgr__port3_data  = mgr_inst[49].mgr__noc__port1_data  ;
  assign mgr_inst[49].noc__mgr__port1_fc    = mgr_inst[50].mgr__noc__port3_fc    ;

  // Connecting Mgr49 Port2 to Mgr57 Port0
  assign mgr_inst[57].noc__mgr__port0_valid = mgr_inst[49].mgr__noc__port2_valid ;
  assign mgr_inst[57].noc__mgr__port0_cntl  = mgr_inst[49].mgr__noc__port2_cntl  ;
  assign mgr_inst[57].noc__mgr__port0_data  = mgr_inst[49].mgr__noc__port2_data  ;
  assign mgr_inst[49].noc__mgr__port2_fc    = mgr_inst[57].mgr__noc__port0_fc    ;

  // Connecting Mgr49 Port3 to Mgr48 Port1
  assign mgr_inst[48].noc__mgr__port1_valid = mgr_inst[49].mgr__noc__port3_valid ;
  assign mgr_inst[48].noc__mgr__port1_cntl  = mgr_inst[49].mgr__noc__port3_cntl  ;
  assign mgr_inst[48].noc__mgr__port1_data  = mgr_inst[49].mgr__noc__port3_data  ;
  assign mgr_inst[49].noc__mgr__port3_fc    = mgr_inst[48].mgr__noc__port1_fc    ;

  // Connecting Mgr50 Port0 to Mgr42 Port2
  assign mgr_inst[42].noc__mgr__port2_valid = mgr_inst[50].mgr__noc__port0_valid ;
  assign mgr_inst[42].noc__mgr__port2_cntl  = mgr_inst[50].mgr__noc__port0_cntl  ;
  assign mgr_inst[42].noc__mgr__port2_data  = mgr_inst[50].mgr__noc__port0_data  ;
  assign mgr_inst[50].noc__mgr__port0_fc    = mgr_inst[42].mgr__noc__port2_fc    ;

  // Connecting Mgr50 Port1 to Mgr51 Port3
  assign mgr_inst[51].noc__mgr__port3_valid = mgr_inst[50].mgr__noc__port1_valid ;
  assign mgr_inst[51].noc__mgr__port3_cntl  = mgr_inst[50].mgr__noc__port1_cntl  ;
  assign mgr_inst[51].noc__mgr__port3_data  = mgr_inst[50].mgr__noc__port1_data  ;
  assign mgr_inst[50].noc__mgr__port1_fc    = mgr_inst[51].mgr__noc__port3_fc    ;

  // Connecting Mgr50 Port2 to Mgr58 Port0
  assign mgr_inst[58].noc__mgr__port0_valid = mgr_inst[50].mgr__noc__port2_valid ;
  assign mgr_inst[58].noc__mgr__port0_cntl  = mgr_inst[50].mgr__noc__port2_cntl  ;
  assign mgr_inst[58].noc__mgr__port0_data  = mgr_inst[50].mgr__noc__port2_data  ;
  assign mgr_inst[50].noc__mgr__port2_fc    = mgr_inst[58].mgr__noc__port0_fc    ;

  // Connecting Mgr50 Port3 to Mgr49 Port1
  assign mgr_inst[49].noc__mgr__port1_valid = mgr_inst[50].mgr__noc__port3_valid ;
  assign mgr_inst[49].noc__mgr__port1_cntl  = mgr_inst[50].mgr__noc__port3_cntl  ;
  assign mgr_inst[49].noc__mgr__port1_data  = mgr_inst[50].mgr__noc__port3_data  ;
  assign mgr_inst[50].noc__mgr__port3_fc    = mgr_inst[49].mgr__noc__port1_fc    ;

  // Connecting Mgr51 Port0 to Mgr43 Port2
  assign mgr_inst[43].noc__mgr__port2_valid = mgr_inst[51].mgr__noc__port0_valid ;
  assign mgr_inst[43].noc__mgr__port2_cntl  = mgr_inst[51].mgr__noc__port0_cntl  ;
  assign mgr_inst[43].noc__mgr__port2_data  = mgr_inst[51].mgr__noc__port0_data  ;
  assign mgr_inst[51].noc__mgr__port0_fc    = mgr_inst[43].mgr__noc__port2_fc    ;

  // Connecting Mgr51 Port1 to Mgr52 Port3
  assign mgr_inst[52].noc__mgr__port3_valid = mgr_inst[51].mgr__noc__port1_valid ;
  assign mgr_inst[52].noc__mgr__port3_cntl  = mgr_inst[51].mgr__noc__port1_cntl  ;
  assign mgr_inst[52].noc__mgr__port3_data  = mgr_inst[51].mgr__noc__port1_data  ;
  assign mgr_inst[51].noc__mgr__port1_fc    = mgr_inst[52].mgr__noc__port3_fc    ;

  // Connecting Mgr51 Port2 to Mgr59 Port0
  assign mgr_inst[59].noc__mgr__port0_valid = mgr_inst[51].mgr__noc__port2_valid ;
  assign mgr_inst[59].noc__mgr__port0_cntl  = mgr_inst[51].mgr__noc__port2_cntl  ;
  assign mgr_inst[59].noc__mgr__port0_data  = mgr_inst[51].mgr__noc__port2_data  ;
  assign mgr_inst[51].noc__mgr__port2_fc    = mgr_inst[59].mgr__noc__port0_fc    ;

  // Connecting Mgr51 Port3 to Mgr50 Port1
  assign mgr_inst[50].noc__mgr__port1_valid = mgr_inst[51].mgr__noc__port3_valid ;
  assign mgr_inst[50].noc__mgr__port1_cntl  = mgr_inst[51].mgr__noc__port3_cntl  ;
  assign mgr_inst[50].noc__mgr__port1_data  = mgr_inst[51].mgr__noc__port3_data  ;
  assign mgr_inst[51].noc__mgr__port3_fc    = mgr_inst[50].mgr__noc__port1_fc    ;

  // Connecting Mgr52 Port0 to Mgr44 Port2
  assign mgr_inst[44].noc__mgr__port2_valid = mgr_inst[52].mgr__noc__port0_valid ;
  assign mgr_inst[44].noc__mgr__port2_cntl  = mgr_inst[52].mgr__noc__port0_cntl  ;
  assign mgr_inst[44].noc__mgr__port2_data  = mgr_inst[52].mgr__noc__port0_data  ;
  assign mgr_inst[52].noc__mgr__port0_fc    = mgr_inst[44].mgr__noc__port2_fc    ;

  // Connecting Mgr52 Port1 to Mgr53 Port3
  assign mgr_inst[53].noc__mgr__port3_valid = mgr_inst[52].mgr__noc__port1_valid ;
  assign mgr_inst[53].noc__mgr__port3_cntl  = mgr_inst[52].mgr__noc__port1_cntl  ;
  assign mgr_inst[53].noc__mgr__port3_data  = mgr_inst[52].mgr__noc__port1_data  ;
  assign mgr_inst[52].noc__mgr__port1_fc    = mgr_inst[53].mgr__noc__port3_fc    ;

  // Connecting Mgr52 Port2 to Mgr60 Port0
  assign mgr_inst[60].noc__mgr__port0_valid = mgr_inst[52].mgr__noc__port2_valid ;
  assign mgr_inst[60].noc__mgr__port0_cntl  = mgr_inst[52].mgr__noc__port2_cntl  ;
  assign mgr_inst[60].noc__mgr__port0_data  = mgr_inst[52].mgr__noc__port2_data  ;
  assign mgr_inst[52].noc__mgr__port2_fc    = mgr_inst[60].mgr__noc__port0_fc    ;

  // Connecting Mgr52 Port3 to Mgr51 Port1
  assign mgr_inst[51].noc__mgr__port1_valid = mgr_inst[52].mgr__noc__port3_valid ;
  assign mgr_inst[51].noc__mgr__port1_cntl  = mgr_inst[52].mgr__noc__port3_cntl  ;
  assign mgr_inst[51].noc__mgr__port1_data  = mgr_inst[52].mgr__noc__port3_data  ;
  assign mgr_inst[52].noc__mgr__port3_fc    = mgr_inst[51].mgr__noc__port1_fc    ;

  // Connecting Mgr53 Port0 to Mgr45 Port2
  assign mgr_inst[45].noc__mgr__port2_valid = mgr_inst[53].mgr__noc__port0_valid ;
  assign mgr_inst[45].noc__mgr__port2_cntl  = mgr_inst[53].mgr__noc__port0_cntl  ;
  assign mgr_inst[45].noc__mgr__port2_data  = mgr_inst[53].mgr__noc__port0_data  ;
  assign mgr_inst[53].noc__mgr__port0_fc    = mgr_inst[45].mgr__noc__port2_fc    ;

  // Connecting Mgr53 Port1 to Mgr54 Port3
  assign mgr_inst[54].noc__mgr__port3_valid = mgr_inst[53].mgr__noc__port1_valid ;
  assign mgr_inst[54].noc__mgr__port3_cntl  = mgr_inst[53].mgr__noc__port1_cntl  ;
  assign mgr_inst[54].noc__mgr__port3_data  = mgr_inst[53].mgr__noc__port1_data  ;
  assign mgr_inst[53].noc__mgr__port1_fc    = mgr_inst[54].mgr__noc__port3_fc    ;

  // Connecting Mgr53 Port2 to Mgr61 Port0
  assign mgr_inst[61].noc__mgr__port0_valid = mgr_inst[53].mgr__noc__port2_valid ;
  assign mgr_inst[61].noc__mgr__port0_cntl  = mgr_inst[53].mgr__noc__port2_cntl  ;
  assign mgr_inst[61].noc__mgr__port0_data  = mgr_inst[53].mgr__noc__port2_data  ;
  assign mgr_inst[53].noc__mgr__port2_fc    = mgr_inst[61].mgr__noc__port0_fc    ;

  // Connecting Mgr53 Port3 to Mgr52 Port1
  assign mgr_inst[52].noc__mgr__port1_valid = mgr_inst[53].mgr__noc__port3_valid ;
  assign mgr_inst[52].noc__mgr__port1_cntl  = mgr_inst[53].mgr__noc__port3_cntl  ;
  assign mgr_inst[52].noc__mgr__port1_data  = mgr_inst[53].mgr__noc__port3_data  ;
  assign mgr_inst[53].noc__mgr__port3_fc    = mgr_inst[52].mgr__noc__port1_fc    ;

  // Connecting Mgr54 Port0 to Mgr46 Port2
  assign mgr_inst[46].noc__mgr__port2_valid = mgr_inst[54].mgr__noc__port0_valid ;
  assign mgr_inst[46].noc__mgr__port2_cntl  = mgr_inst[54].mgr__noc__port0_cntl  ;
  assign mgr_inst[46].noc__mgr__port2_data  = mgr_inst[54].mgr__noc__port0_data  ;
  assign mgr_inst[54].noc__mgr__port0_fc    = mgr_inst[46].mgr__noc__port2_fc    ;

  // Connecting Mgr54 Port1 to Mgr55 Port2
  assign mgr_inst[55].noc__mgr__port2_valid = mgr_inst[54].mgr__noc__port1_valid ;
  assign mgr_inst[55].noc__mgr__port2_cntl  = mgr_inst[54].mgr__noc__port1_cntl  ;
  assign mgr_inst[55].noc__mgr__port2_data  = mgr_inst[54].mgr__noc__port1_data  ;
  assign mgr_inst[54].noc__mgr__port1_fc    = mgr_inst[55].mgr__noc__port2_fc    ;

  // Connecting Mgr54 Port2 to Mgr62 Port0
  assign mgr_inst[62].noc__mgr__port0_valid = mgr_inst[54].mgr__noc__port2_valid ;
  assign mgr_inst[62].noc__mgr__port0_cntl  = mgr_inst[54].mgr__noc__port2_cntl  ;
  assign mgr_inst[62].noc__mgr__port0_data  = mgr_inst[54].mgr__noc__port2_data  ;
  assign mgr_inst[54].noc__mgr__port2_fc    = mgr_inst[62].mgr__noc__port0_fc    ;

  // Connecting Mgr54 Port3 to Mgr53 Port1
  assign mgr_inst[53].noc__mgr__port1_valid = mgr_inst[54].mgr__noc__port3_valid ;
  assign mgr_inst[53].noc__mgr__port1_cntl  = mgr_inst[54].mgr__noc__port3_cntl  ;
  assign mgr_inst[53].noc__mgr__port1_data  = mgr_inst[54].mgr__noc__port3_data  ;
  assign mgr_inst[54].noc__mgr__port3_fc    = mgr_inst[53].mgr__noc__port1_fc    ;

  // Terminate Mgr55's 1 unused Ports
  assign mgr_inst[55].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[55].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[55].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[55].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr55 Port0 to Mgr47 Port1
  assign mgr_inst[47].noc__mgr__port1_valid = mgr_inst[55].mgr__noc__port0_valid ;
  assign mgr_inst[47].noc__mgr__port1_cntl  = mgr_inst[55].mgr__noc__port0_cntl  ;
  assign mgr_inst[47].noc__mgr__port1_data  = mgr_inst[55].mgr__noc__port0_data  ;
  assign mgr_inst[55].noc__mgr__port0_fc    = mgr_inst[47].mgr__noc__port1_fc    ;

  // Connecting Mgr55 Port1 to Mgr63 Port0
  assign mgr_inst[63].noc__mgr__port0_valid = mgr_inst[55].mgr__noc__port1_valid ;
  assign mgr_inst[63].noc__mgr__port0_cntl  = mgr_inst[55].mgr__noc__port1_cntl  ;
  assign mgr_inst[63].noc__mgr__port0_data  = mgr_inst[55].mgr__noc__port1_data  ;
  assign mgr_inst[55].noc__mgr__port1_fc    = mgr_inst[63].mgr__noc__port0_fc    ;

  // Connecting Mgr55 Port2 to Mgr54 Port1
  assign mgr_inst[54].noc__mgr__port1_valid = mgr_inst[55].mgr__noc__port2_valid ;
  assign mgr_inst[54].noc__mgr__port1_cntl  = mgr_inst[55].mgr__noc__port2_cntl  ;
  assign mgr_inst[54].noc__mgr__port1_data  = mgr_inst[55].mgr__noc__port2_data  ;
  assign mgr_inst[55].noc__mgr__port2_fc    = mgr_inst[54].mgr__noc__port1_fc    ;

  // Terminate Mgr56's 2 unused Ports
  assign mgr_inst[56].noc__mgr__port2_valid = 'd0 ;
  assign mgr_inst[56].noc__mgr__port2_cntl  = 'd0 ;
  assign mgr_inst[56].noc__mgr__port2_data  = 'd0 ;
  assign mgr_inst[56].noc__mgr__port2_fc    = 'd0 ;
  assign mgr_inst[56].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[56].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[56].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[56].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr56 Port0 to Mgr48 Port2
  assign mgr_inst[48].noc__mgr__port2_valid = mgr_inst[56].mgr__noc__port0_valid ;
  assign mgr_inst[48].noc__mgr__port2_cntl  = mgr_inst[56].mgr__noc__port0_cntl  ;
  assign mgr_inst[48].noc__mgr__port2_data  = mgr_inst[56].mgr__noc__port0_data  ;
  assign mgr_inst[56].noc__mgr__port0_fc    = mgr_inst[48].mgr__noc__port2_fc    ;

  // Connecting Mgr56 Port1 to Mgr57 Port2
  assign mgr_inst[57].noc__mgr__port2_valid = mgr_inst[56].mgr__noc__port1_valid ;
  assign mgr_inst[57].noc__mgr__port2_cntl  = mgr_inst[56].mgr__noc__port1_cntl  ;
  assign mgr_inst[57].noc__mgr__port2_data  = mgr_inst[56].mgr__noc__port1_data  ;
  assign mgr_inst[56].noc__mgr__port1_fc    = mgr_inst[57].mgr__noc__port2_fc    ;

  // Terminate Mgr57's 1 unused Ports
  assign mgr_inst[57].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[57].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[57].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[57].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr57 Port0 to Mgr49 Port2
  assign mgr_inst[49].noc__mgr__port2_valid = mgr_inst[57].mgr__noc__port0_valid ;
  assign mgr_inst[49].noc__mgr__port2_cntl  = mgr_inst[57].mgr__noc__port0_cntl  ;
  assign mgr_inst[49].noc__mgr__port2_data  = mgr_inst[57].mgr__noc__port0_data  ;
  assign mgr_inst[57].noc__mgr__port0_fc    = mgr_inst[49].mgr__noc__port2_fc    ;

  // Connecting Mgr57 Port1 to Mgr58 Port2
  assign mgr_inst[58].noc__mgr__port2_valid = mgr_inst[57].mgr__noc__port1_valid ;
  assign mgr_inst[58].noc__mgr__port2_cntl  = mgr_inst[57].mgr__noc__port1_cntl  ;
  assign mgr_inst[58].noc__mgr__port2_data  = mgr_inst[57].mgr__noc__port1_data  ;
  assign mgr_inst[57].noc__mgr__port1_fc    = mgr_inst[58].mgr__noc__port2_fc    ;

  // Connecting Mgr57 Port2 to Mgr56 Port1
  assign mgr_inst[56].noc__mgr__port1_valid = mgr_inst[57].mgr__noc__port2_valid ;
  assign mgr_inst[56].noc__mgr__port1_cntl  = mgr_inst[57].mgr__noc__port2_cntl  ;
  assign mgr_inst[56].noc__mgr__port1_data  = mgr_inst[57].mgr__noc__port2_data  ;
  assign mgr_inst[57].noc__mgr__port2_fc    = mgr_inst[56].mgr__noc__port1_fc    ;

  // Terminate Mgr58's 1 unused Ports
  assign mgr_inst[58].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[58].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[58].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[58].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr58 Port0 to Mgr50 Port2
  assign mgr_inst[50].noc__mgr__port2_valid = mgr_inst[58].mgr__noc__port0_valid ;
  assign mgr_inst[50].noc__mgr__port2_cntl  = mgr_inst[58].mgr__noc__port0_cntl  ;
  assign mgr_inst[50].noc__mgr__port2_data  = mgr_inst[58].mgr__noc__port0_data  ;
  assign mgr_inst[58].noc__mgr__port0_fc    = mgr_inst[50].mgr__noc__port2_fc    ;

  // Connecting Mgr58 Port1 to Mgr59 Port2
  assign mgr_inst[59].noc__mgr__port2_valid = mgr_inst[58].mgr__noc__port1_valid ;
  assign mgr_inst[59].noc__mgr__port2_cntl  = mgr_inst[58].mgr__noc__port1_cntl  ;
  assign mgr_inst[59].noc__mgr__port2_data  = mgr_inst[58].mgr__noc__port1_data  ;
  assign mgr_inst[58].noc__mgr__port1_fc    = mgr_inst[59].mgr__noc__port2_fc    ;

  // Connecting Mgr58 Port2 to Mgr57 Port1
  assign mgr_inst[57].noc__mgr__port1_valid = mgr_inst[58].mgr__noc__port2_valid ;
  assign mgr_inst[57].noc__mgr__port1_cntl  = mgr_inst[58].mgr__noc__port2_cntl  ;
  assign mgr_inst[57].noc__mgr__port1_data  = mgr_inst[58].mgr__noc__port2_data  ;
  assign mgr_inst[58].noc__mgr__port2_fc    = mgr_inst[57].mgr__noc__port1_fc    ;

  // Terminate Mgr59's 1 unused Ports
  assign mgr_inst[59].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[59].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[59].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[59].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr59 Port0 to Mgr51 Port2
  assign mgr_inst[51].noc__mgr__port2_valid = mgr_inst[59].mgr__noc__port0_valid ;
  assign mgr_inst[51].noc__mgr__port2_cntl  = mgr_inst[59].mgr__noc__port0_cntl  ;
  assign mgr_inst[51].noc__mgr__port2_data  = mgr_inst[59].mgr__noc__port0_data  ;
  assign mgr_inst[59].noc__mgr__port0_fc    = mgr_inst[51].mgr__noc__port2_fc    ;

  // Connecting Mgr59 Port1 to Mgr60 Port2
  assign mgr_inst[60].noc__mgr__port2_valid = mgr_inst[59].mgr__noc__port1_valid ;
  assign mgr_inst[60].noc__mgr__port2_cntl  = mgr_inst[59].mgr__noc__port1_cntl  ;
  assign mgr_inst[60].noc__mgr__port2_data  = mgr_inst[59].mgr__noc__port1_data  ;
  assign mgr_inst[59].noc__mgr__port1_fc    = mgr_inst[60].mgr__noc__port2_fc    ;

  // Connecting Mgr59 Port2 to Mgr58 Port1
  assign mgr_inst[58].noc__mgr__port1_valid = mgr_inst[59].mgr__noc__port2_valid ;
  assign mgr_inst[58].noc__mgr__port1_cntl  = mgr_inst[59].mgr__noc__port2_cntl  ;
  assign mgr_inst[58].noc__mgr__port1_data  = mgr_inst[59].mgr__noc__port2_data  ;
  assign mgr_inst[59].noc__mgr__port2_fc    = mgr_inst[58].mgr__noc__port1_fc    ;

  // Terminate Mgr60's 1 unused Ports
  assign mgr_inst[60].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[60].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[60].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[60].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr60 Port0 to Mgr52 Port2
  assign mgr_inst[52].noc__mgr__port2_valid = mgr_inst[60].mgr__noc__port0_valid ;
  assign mgr_inst[52].noc__mgr__port2_cntl  = mgr_inst[60].mgr__noc__port0_cntl  ;
  assign mgr_inst[52].noc__mgr__port2_data  = mgr_inst[60].mgr__noc__port0_data  ;
  assign mgr_inst[60].noc__mgr__port0_fc    = mgr_inst[52].mgr__noc__port2_fc    ;

  // Connecting Mgr60 Port1 to Mgr61 Port2
  assign mgr_inst[61].noc__mgr__port2_valid = mgr_inst[60].mgr__noc__port1_valid ;
  assign mgr_inst[61].noc__mgr__port2_cntl  = mgr_inst[60].mgr__noc__port1_cntl  ;
  assign mgr_inst[61].noc__mgr__port2_data  = mgr_inst[60].mgr__noc__port1_data  ;
  assign mgr_inst[60].noc__mgr__port1_fc    = mgr_inst[61].mgr__noc__port2_fc    ;

  // Connecting Mgr60 Port2 to Mgr59 Port1
  assign mgr_inst[59].noc__mgr__port1_valid = mgr_inst[60].mgr__noc__port2_valid ;
  assign mgr_inst[59].noc__mgr__port1_cntl  = mgr_inst[60].mgr__noc__port2_cntl  ;
  assign mgr_inst[59].noc__mgr__port1_data  = mgr_inst[60].mgr__noc__port2_data  ;
  assign mgr_inst[60].noc__mgr__port2_fc    = mgr_inst[59].mgr__noc__port1_fc    ;

  // Terminate Mgr61's 1 unused Ports
  assign mgr_inst[61].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[61].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[61].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[61].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr61 Port0 to Mgr53 Port2
  assign mgr_inst[53].noc__mgr__port2_valid = mgr_inst[61].mgr__noc__port0_valid ;
  assign mgr_inst[53].noc__mgr__port2_cntl  = mgr_inst[61].mgr__noc__port0_cntl  ;
  assign mgr_inst[53].noc__mgr__port2_data  = mgr_inst[61].mgr__noc__port0_data  ;
  assign mgr_inst[61].noc__mgr__port0_fc    = mgr_inst[53].mgr__noc__port2_fc    ;

  // Connecting Mgr61 Port1 to Mgr62 Port2
  assign mgr_inst[62].noc__mgr__port2_valid = mgr_inst[61].mgr__noc__port1_valid ;
  assign mgr_inst[62].noc__mgr__port2_cntl  = mgr_inst[61].mgr__noc__port1_cntl  ;
  assign mgr_inst[62].noc__mgr__port2_data  = mgr_inst[61].mgr__noc__port1_data  ;
  assign mgr_inst[61].noc__mgr__port1_fc    = mgr_inst[62].mgr__noc__port2_fc    ;

  // Connecting Mgr61 Port2 to Mgr60 Port1
  assign mgr_inst[60].noc__mgr__port1_valid = mgr_inst[61].mgr__noc__port2_valid ;
  assign mgr_inst[60].noc__mgr__port1_cntl  = mgr_inst[61].mgr__noc__port2_cntl  ;
  assign mgr_inst[60].noc__mgr__port1_data  = mgr_inst[61].mgr__noc__port2_data  ;
  assign mgr_inst[61].noc__mgr__port2_fc    = mgr_inst[60].mgr__noc__port1_fc    ;

  // Terminate Mgr62's 1 unused Ports
  assign mgr_inst[62].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[62].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[62].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[62].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr62 Port0 to Mgr54 Port2
  assign mgr_inst[54].noc__mgr__port2_valid = mgr_inst[62].mgr__noc__port0_valid ;
  assign mgr_inst[54].noc__mgr__port2_cntl  = mgr_inst[62].mgr__noc__port0_cntl  ;
  assign mgr_inst[54].noc__mgr__port2_data  = mgr_inst[62].mgr__noc__port0_data  ;
  assign mgr_inst[62].noc__mgr__port0_fc    = mgr_inst[54].mgr__noc__port2_fc    ;

  // Connecting Mgr62 Port1 to Mgr63 Port1
  assign mgr_inst[63].noc__mgr__port1_valid = mgr_inst[62].mgr__noc__port1_valid ;
  assign mgr_inst[63].noc__mgr__port1_cntl  = mgr_inst[62].mgr__noc__port1_cntl  ;
  assign mgr_inst[63].noc__mgr__port1_data  = mgr_inst[62].mgr__noc__port1_data  ;
  assign mgr_inst[62].noc__mgr__port1_fc    = mgr_inst[63].mgr__noc__port1_fc    ;

  // Connecting Mgr62 Port2 to Mgr61 Port1
  assign mgr_inst[61].noc__mgr__port1_valid = mgr_inst[62].mgr__noc__port2_valid ;
  assign mgr_inst[61].noc__mgr__port1_cntl  = mgr_inst[62].mgr__noc__port2_cntl  ;
  assign mgr_inst[61].noc__mgr__port1_data  = mgr_inst[62].mgr__noc__port2_data  ;
  assign mgr_inst[62].noc__mgr__port2_fc    = mgr_inst[61].mgr__noc__port1_fc    ;

  // Terminate Mgr63's 2 unused Ports
  assign mgr_inst[63].noc__mgr__port2_valid = 'd0 ;
  assign mgr_inst[63].noc__mgr__port2_cntl  = 'd0 ;
  assign mgr_inst[63].noc__mgr__port2_data  = 'd0 ;
  assign mgr_inst[63].noc__mgr__port2_fc    = 'd0 ;
  assign mgr_inst[63].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[63].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[63].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[63].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr63 Port0 to Mgr55 Port1
  assign mgr_inst[55].noc__mgr__port1_valid = mgr_inst[63].mgr__noc__port0_valid ;
  assign mgr_inst[55].noc__mgr__port1_cntl  = mgr_inst[63].mgr__noc__port0_cntl  ;
  assign mgr_inst[55].noc__mgr__port1_data  = mgr_inst[63].mgr__noc__port0_data  ;
  assign mgr_inst[63].noc__mgr__port0_fc    = mgr_inst[55].mgr__noc__port1_fc    ;

  // Connecting Mgr63 Port1 to Mgr62 Port1
  assign mgr_inst[62].noc__mgr__port1_valid = mgr_inst[63].mgr__noc__port1_valid ;
  assign mgr_inst[62].noc__mgr__port1_cntl  = mgr_inst[63].mgr__noc__port1_cntl  ;
  assign mgr_inst[62].noc__mgr__port1_data  = mgr_inst[63].mgr__noc__port1_data  ;
  assign mgr_inst[63].noc__mgr__port1_fc    = mgr_inst[62].mgr__noc__port1_fc    ;
