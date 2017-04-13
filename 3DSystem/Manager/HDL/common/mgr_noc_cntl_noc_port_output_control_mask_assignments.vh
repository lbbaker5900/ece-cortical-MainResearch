
  // Hard-code which nodes can be accessed via this output port
  assign Port_to_NoC[0].thisPort_destinationMask = sys__mgr__port0_destinationMask ; // bitmask indicating which nodes accessed out of this port
  assign Port_to_NoC[1].thisPort_destinationMask = sys__mgr__port1_destinationMask ; // bitmask indicating which nodes accessed out of this port
  assign Port_to_NoC[2].thisPort_destinationMask = sys__mgr__port2_destinationMask ; // bitmask indicating which nodes accessed out of this port
  assign Port_to_NoC[3].thisPort_destinationMask = sys__mgr__port3_destinationMask ; // bitmask indicating which nodes accessed out of this port