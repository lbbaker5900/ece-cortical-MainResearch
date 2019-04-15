
  // Terminate Mgr0's 2 unused Ports
  //assign mgr_inst[0].noc__mgr__port_valid [2] = 'd0 ;
  //assign mgr_inst[0].noc__mgr__port_cntl  [2] = 'd0 ;
  //assign mgr_inst[0].noc__mgr__port_data  [2] = 'd0 ;
  //assign mgr_inst[0].noc__mgr__port_fc    [2] = 'd0 ;
  assign mgr_inst[0].noc__mgr__port_valid [3] = 'd0 ;
  assign mgr_inst[0].noc__mgr__port_cntl  [3] = 'd0 ;
  assign mgr_inst[0].noc__mgr__port_data  [3] = 'd0 ;
  assign mgr_inst[0].noc__mgr__port_fc    [3] = 'd0 ;

  // Connecting Mgr0 Port0 to Mgr1 Port1
  assign mgr_inst[1].noc__mgr__port_valid [1] = mgr_inst[0].mgr__noc__port_valid [0] ;
  assign mgr_inst[1].noc__mgr__port_cntl  [1] = mgr_inst[0].mgr__noc__port_cntl  [0] ;
  assign mgr_inst[1].noc__mgr__port_data  [1] = mgr_inst[0].mgr__noc__port_data  [0] ;
  assign mgr_inst[0].noc__mgr__port_fc    [0] = mgr_inst[1].mgr__noc__port_fc    [1] ;

  // Connecting Mgr0 Port1 to Mgr2 Port0
  assign mgr_inst[2].noc__mgr__port_valid [0] = mgr_inst[0].mgr__noc__port_valid [1] ;
  assign mgr_inst[2].noc__mgr__port_cntl  [0] = mgr_inst[0].mgr__noc__port_cntl  [1] ;
  assign mgr_inst[2].noc__mgr__port_data  [0] = mgr_inst[0].mgr__noc__port_data  [1] ;
  assign mgr_inst[0].noc__mgr__port_fc    [1] = mgr_inst[2].mgr__noc__port_fc    [0] ;

  // Terminate Mgr1's 2 unused Ports
  assign mgr_inst[1].noc__mgr__port_valid [2] = 'd0 ;
  assign mgr_inst[1].noc__mgr__port_cntl  [2] = 'd0 ;
  assign mgr_inst[1].noc__mgr__port_data  [2] = 'd0 ;
  assign mgr_inst[1].noc__mgr__port_fc    [2] = 'd0 ;
  assign mgr_inst[1].noc__mgr__port_valid [3] = 'd0 ;
  assign mgr_inst[1].noc__mgr__port_cntl  [3] = 'd0 ;
  assign mgr_inst[1].noc__mgr__port_data  [3] = 'd0 ;
  assign mgr_inst[1].noc__mgr__port_fc    [3] = 'd0 ;

  // Connecting Mgr1 Port0 to Mgr3 Port0
  assign mgr_inst[3].noc__mgr__port_valid [0] = mgr_inst[1].mgr__noc__port_valid [0] ;
  assign mgr_inst[3].noc__mgr__port_cntl  [0] = mgr_inst[1].mgr__noc__port_cntl  [0] ;
  assign mgr_inst[3].noc__mgr__port_data  [0] = mgr_inst[1].mgr__noc__port_data  [0] ;
  assign mgr_inst[1].noc__mgr__port_fc    [0] = mgr_inst[3].mgr__noc__port_fc    [0] ;

  // Connecting Mgr1 Port1 to Mgr0 Port0
  assign mgr_inst[0].noc__mgr__port_valid [0] = mgr_inst[1].mgr__noc__port_valid [1] ;
  assign mgr_inst[0].noc__mgr__port_cntl  [0] = mgr_inst[1].mgr__noc__port_cntl  [1] ;
  assign mgr_inst[0].noc__mgr__port_data  [0] = mgr_inst[1].mgr__noc__port_data  [1] ;
  assign mgr_inst[1].noc__mgr__port_fc    [1] = mgr_inst[0].mgr__noc__port_fc    [0] ;

  // Terminate Mgr2's 2 unused Ports
  assign mgr_inst[2].noc__mgr__port_valid [2] = 'd0 ;
  assign mgr_inst[2].noc__mgr__port_cntl  [2] = 'd0 ;
  assign mgr_inst[2].noc__mgr__port_data  [2] = 'd0 ;
  assign mgr_inst[2].noc__mgr__port_fc    [2] = 'd0 ;
  assign mgr_inst[2].noc__mgr__port_valid [3] = 'd0 ;
  assign mgr_inst[2].noc__mgr__port_cntl  [3] = 'd0 ;
  assign mgr_inst[2].noc__mgr__port_data  [3] = 'd0 ;
  assign mgr_inst[2].noc__mgr__port_fc    [3] = 'd0 ;

  // Connecting Mgr2 Port0 to Mgr0 Port1
  assign mgr_inst[0].noc__mgr__port_valid [1] = mgr_inst[2].mgr__noc__port_valid [0] ;
  assign mgr_inst[0].noc__mgr__port_cntl  [1] = mgr_inst[2].mgr__noc__port_cntl  [0] ;
  assign mgr_inst[0].noc__mgr__port_data  [1] = mgr_inst[2].mgr__noc__port_data  [0] ;
  assign mgr_inst[2].noc__mgr__port_fc    [0] = mgr_inst[0].mgr__noc__port_fc    [1] ;

  // Connecting Mgr2 Port1 to Mgr3 Port1
  assign mgr_inst[3].noc__mgr__port_valid [1] = mgr_inst[2].mgr__noc__port_valid [1] ;
  assign mgr_inst[3].noc__mgr__port_cntl  [1] = mgr_inst[2].mgr__noc__port_cntl  [1] ;
  assign mgr_inst[3].noc__mgr__port_data  [1] = mgr_inst[2].mgr__noc__port_data  [1] ;
  assign mgr_inst[2].noc__mgr__port_fc    [1] = mgr_inst[3].mgr__noc__port_fc    [1] ;

  // Terminate Mgr3's 2 unused Ports
  assign mgr_inst[3].noc__mgr__port_valid [2] = 'd0 ;
  assign mgr_inst[3].noc__mgr__port_cntl  [2] = 'd0 ;
  assign mgr_inst[3].noc__mgr__port_data  [2] = 'd0 ;
  assign mgr_inst[3].noc__mgr__port_fc    [2] = 'd0 ;
  assign mgr_inst[3].noc__mgr__port_valid [3] = 'd0 ;
  assign mgr_inst[3].noc__mgr__port_cntl  [3] = 'd0 ;
  assign mgr_inst[3].noc__mgr__port_data  [3] = 'd0 ;
  assign mgr_inst[3].noc__mgr__port_fc    [3] = 'd0 ;

  // Connecting Mgr3 Port0 to Mgr1 Port0
  assign mgr_inst[1].noc__mgr__port_valid [0] = mgr_inst[3].mgr__noc__port_valid [0] ;
  assign mgr_inst[1].noc__mgr__port_cntl  [0] = mgr_inst[3].mgr__noc__port_cntl  [0] ;
  assign mgr_inst[1].noc__mgr__port_data  [0] = mgr_inst[3].mgr__noc__port_data  [0] ;
  assign mgr_inst[3].noc__mgr__port_fc    [0] = mgr_inst[1].mgr__noc__port_fc    [0] ;

  // Connecting Mgr3 Port1 to Mgr2 Port1
  assign mgr_inst[2].noc__mgr__port_valid [1] = mgr_inst[3].mgr__noc__port_valid [1] ;
  assign mgr_inst[2].noc__mgr__port_cntl  [1] = mgr_inst[3].mgr__noc__port_cntl  [1] ;
  assign mgr_inst[2].noc__mgr__port_data  [1] = mgr_inst[3].mgr__noc__port_data  [1] ;
  assign mgr_inst[3].noc__mgr__port_fc    [1] = mgr_inst[2].mgr__noc__port_fc    [1] ;
