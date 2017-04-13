
  assign InPortRequestVector[0]       = Port_from_NoC[0].destinationReq ;
  assign InPortRequestVector[1]       = Port_from_NoC[1].destinationReq ;
  assign InPortRequestVector[2]       = Port_from_NoC[2].destinationReq ;
  assign InPortRequestVector[3]       = Port_from_NoC[3].destinationReq ;

  // Port inputs from NoC
  // NoC port 0
  assign    mgr__noc__port0_fc      = Port_from_NoC[0].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC[0].cntl        = noc__mgr__port0_cntl               ;
      Port_from_NoC[0].data        = noc__mgr__port0_data               ;
      Port_from_NoC[0].fifo_write  = noc__mgr__port0_valid              ;
    end 

  // NoC port 1
  assign    mgr__noc__port1_fc      = Port_from_NoC[1].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC[1].cntl        = noc__mgr__port1_cntl               ;
      Port_from_NoC[1].data        = noc__mgr__port1_data               ;
      Port_from_NoC[1].fifo_write  = noc__mgr__port1_valid              ;
    end 

  // NoC port 2
  assign    mgr__noc__port2_fc      = Port_from_NoC[2].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC[2].cntl        = noc__mgr__port2_cntl               ;
      Port_from_NoC[2].data        = noc__mgr__port2_data               ;
      Port_from_NoC[2].fifo_write  = noc__mgr__port2_valid              ;
    end 

  // NoC port 3
  assign    mgr__noc__port3_fc      = Port_from_NoC[3].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC[3].cntl        = noc__mgr__port3_cntl               ;
      Port_from_NoC[3].data        = noc__mgr__port3_data               ;
      Port_from_NoC[3].fifo_write  = noc__mgr__port3_valid              ;
    end 

