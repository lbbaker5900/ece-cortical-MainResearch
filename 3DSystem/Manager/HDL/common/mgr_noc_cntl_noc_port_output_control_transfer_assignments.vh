
  // Port outputs to NoC
  // NoC port 0
  assign mgr__noc__port0_cntl  = Port_to_NoC[0].read_cntl;
  assign mgr__noc__port0_data  = Port_to_NoC[0].read_data;
  assign Port_to_NoC[0].read = ~Port_to_NoC[0].empty & ~noc__mgr__port0_fc ;
  always @(posedge clk)
      mgr__noc__port0_valid  <= Port_to_NoC[0].read ;

  // NoC port 1
  assign mgr__noc__port1_cntl  = Port_to_NoC[1].read_cntl;
  assign mgr__noc__port1_data  = Port_to_NoC[1].read_data;
  assign Port_to_NoC[1].read = ~Port_to_NoC[1].empty & ~noc__mgr__port1_fc ;
  always @(posedge clk)
      mgr__noc__port1_valid  <= Port_to_NoC[1].read ;

  // NoC port 2
  assign mgr__noc__port2_cntl  = Port_to_NoC[2].read_cntl;
  assign mgr__noc__port2_data  = Port_to_NoC[2].read_data;
  assign Port_to_NoC[2].read = ~Port_to_NoC[2].empty & ~noc__mgr__port2_fc ;
  always @(posedge clk)
      mgr__noc__port2_valid  <= Port_to_NoC[2].read ;

  // NoC port 3
  assign mgr__noc__port3_cntl  = Port_to_NoC[3].read_cntl;
  assign mgr__noc__port3_data  = Port_to_NoC[3].read_data;
  assign Port_to_NoC[3].read = ~Port_to_NoC[3].empty & ~noc__mgr__port3_fc ;
  always @(posedge clk)
      mgr__noc__port3_valid  <= Port_to_NoC[3].read ;

