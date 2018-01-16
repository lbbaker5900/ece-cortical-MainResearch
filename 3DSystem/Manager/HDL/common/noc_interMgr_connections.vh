
  // Terminate Mgr0's 2 unused Ports
  /*
  assign mgr_inst[0].noc__mgr__port2_valid = 'd0 ;
  assign mgr_inst[0].noc__mgr__port2_cntl  = 'd0 ;
  assign mgr_inst[0].noc__mgr__port2_data  = 'd0 ;
  assign mgr_inst[0].noc__mgr__port2_fc    = 'd0 ;
  */

  assign mgr_inst[0].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[0].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[0].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[0].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr0 Port0 to Mgr1 Port1
  assign mgr_inst[1].noc__mgr__port1_valid = mgr_inst[0].mgr__noc__port0_valid ;
  assign mgr_inst[1].noc__mgr__port1_cntl  = mgr_inst[0].mgr__noc__port0_cntl  ;
  assign mgr_inst[1].noc__mgr__port1_data  = mgr_inst[0].mgr__noc__port0_data  ;
  assign mgr_inst[0].noc__mgr__port0_fc    = mgr_inst[1].mgr__noc__port1_fc    ;

  // Connecting Mgr0 Port1 to Mgr2 Port0
  assign mgr_inst[2].noc__mgr__port0_valid = mgr_inst[0].mgr__noc__port1_valid ;
  assign mgr_inst[2].noc__mgr__port0_cntl  = mgr_inst[0].mgr__noc__port1_cntl  ;
  assign mgr_inst[2].noc__mgr__port0_data  = mgr_inst[0].mgr__noc__port1_data  ;
  assign mgr_inst[0].noc__mgr__port1_fc    = mgr_inst[2].mgr__noc__port0_fc    ;

  // Terminate Mgr1's 2 unused Ports
  assign mgr_inst[1].noc__mgr__port2_valid = 'd0 ;
  assign mgr_inst[1].noc__mgr__port2_cntl  = 'd0 ;
  assign mgr_inst[1].noc__mgr__port2_data  = 'd0 ;
  assign mgr_inst[1].noc__mgr__port2_fc    = 'd0 ;
  assign mgr_inst[1].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[1].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[1].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[1].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr1 Port0 to Mgr3 Port0
  assign mgr_inst[3].noc__mgr__port0_valid = mgr_inst[1].mgr__noc__port0_valid ;
  assign mgr_inst[3].noc__mgr__port0_cntl  = mgr_inst[1].mgr__noc__port0_cntl  ;
  assign mgr_inst[3].noc__mgr__port0_data  = mgr_inst[1].mgr__noc__port0_data  ;
  assign mgr_inst[1].noc__mgr__port0_fc    = mgr_inst[3].mgr__noc__port0_fc    ;

  // Connecting Mgr1 Port1 to Mgr0 Port0
  assign mgr_inst[0].noc__mgr__port0_valid = mgr_inst[1].mgr__noc__port1_valid ;
  assign mgr_inst[0].noc__mgr__port0_cntl  = mgr_inst[1].mgr__noc__port1_cntl  ;
  assign mgr_inst[0].noc__mgr__port0_data  = mgr_inst[1].mgr__noc__port1_data  ;
  assign mgr_inst[1].noc__mgr__port1_fc    = mgr_inst[0].mgr__noc__port0_fc    ;

  // Terminate Mgr2's 2 unused Ports
  assign mgr_inst[2].noc__mgr__port2_valid = 'd0 ;
  assign mgr_inst[2].noc__mgr__port2_cntl  = 'd0 ;
  assign mgr_inst[2].noc__mgr__port2_data  = 'd0 ;
  assign mgr_inst[2].noc__mgr__port2_fc    = 'd0 ;
  assign mgr_inst[2].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[2].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[2].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[2].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr2 Port0 to Mgr0 Port1
  assign mgr_inst[0].noc__mgr__port1_valid = mgr_inst[2].mgr__noc__port0_valid ;
  assign mgr_inst[0].noc__mgr__port1_cntl  = mgr_inst[2].mgr__noc__port0_cntl  ;
  assign mgr_inst[0].noc__mgr__port1_data  = mgr_inst[2].mgr__noc__port0_data  ;
  assign mgr_inst[2].noc__mgr__port0_fc    = mgr_inst[0].mgr__noc__port1_fc    ;

  // Connecting Mgr2 Port1 to Mgr3 Port1
  assign mgr_inst[3].noc__mgr__port1_valid = mgr_inst[2].mgr__noc__port1_valid ;
  assign mgr_inst[3].noc__mgr__port1_cntl  = mgr_inst[2].mgr__noc__port1_cntl  ;
  assign mgr_inst[3].noc__mgr__port1_data  = mgr_inst[2].mgr__noc__port1_data  ;
  assign mgr_inst[2].noc__mgr__port1_fc    = mgr_inst[3].mgr__noc__port1_fc    ;

  // Terminate Mgr3's 2 unused Ports
  assign mgr_inst[3].noc__mgr__port2_valid = 'd0 ;
  assign mgr_inst[3].noc__mgr__port2_cntl  = 'd0 ;
  assign mgr_inst[3].noc__mgr__port2_data  = 'd0 ;
  assign mgr_inst[3].noc__mgr__port2_fc    = 'd0 ;
  assign mgr_inst[3].noc__mgr__port3_valid = 'd0 ;
  assign mgr_inst[3].noc__mgr__port3_cntl  = 'd0 ;
  assign mgr_inst[3].noc__mgr__port3_data  = 'd0 ;
  assign mgr_inst[3].noc__mgr__port3_fc    = 'd0 ;

  // Connecting Mgr3 Port0 to Mgr1 Port0
  assign mgr_inst[1].noc__mgr__port0_valid = mgr_inst[3].mgr__noc__port0_valid ;
  assign mgr_inst[1].noc__mgr__port0_cntl  = mgr_inst[3].mgr__noc__port0_cntl  ;
  assign mgr_inst[1].noc__mgr__port0_data  = mgr_inst[3].mgr__noc__port0_data  ;
  assign mgr_inst[3].noc__mgr__port0_fc    = mgr_inst[1].mgr__noc__port0_fc    ;

  // Connecting Mgr3 Port1 to Mgr2 Port1
  assign mgr_inst[2].noc__mgr__port1_valid = mgr_inst[3].mgr__noc__port1_valid ;
  assign mgr_inst[2].noc__mgr__port1_cntl  = mgr_inst[3].mgr__noc__port1_cntl  ;
  assign mgr_inst[2].noc__mgr__port1_data  = mgr_inst[3].mgr__noc__port1_data  ;
  assign mgr_inst[3].noc__mgr__port1_fc    = mgr_inst[2].mgr__noc__port1_fc    ;
