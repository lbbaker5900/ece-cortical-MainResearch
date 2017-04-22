
  assign InPortRequestVector[0]       = Port_from_NoC_Control[0].destinationReq ;
  assign InPortRequestVector[1]       = Port_from_NoC_Control[1].destinationReq ;
  assign InPortRequestVector[2]       = Port_from_NoC_Control[2].destinationReq ;
  assign InPortRequestVector[3]       = Port_from_NoC_Control[3].destinationReq ;

  // Port inputs from NoC
  // NoC port 0
  assign    mgr__noc__port0_fc      = Port_from_NoC_Control[0].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC_Control[0].cntl        = noc__mgr__port0_cntl               ;
      Port_from_NoC_Control[0].data        = noc__mgr__port0_data               ;
      Port_from_NoC_Control[0].fifo_write  = noc__mgr__port0_valid              ;
    end 

  // NoC port 1
  assign    mgr__noc__port1_fc      = Port_from_NoC_Control[1].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC_Control[1].cntl        = noc__mgr__port1_cntl               ;
      Port_from_NoC_Control[1].data        = noc__mgr__port1_data               ;
      Port_from_NoC_Control[1].fifo_write  = noc__mgr__port1_valid              ;
    end 

  // NoC port 2
  assign    mgr__noc__port2_fc      = Port_from_NoC_Control[2].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC_Control[2].cntl        = noc__mgr__port2_cntl               ;
      Port_from_NoC_Control[2].data        = noc__mgr__port2_data               ;
      Port_from_NoC_Control[2].fifo_write  = noc__mgr__port2_valid              ;
    end 

  // NoC port 3
  assign    mgr__noc__port3_fc      = Port_from_NoC_Control[3].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC_Control[3].cntl        = noc__mgr__port3_cntl               ;
      Port_from_NoC_Control[3].data        = noc__mgr__port3_data               ;
      Port_from_NoC_Control[3].fifo_write  = noc__mgr__port3_valid              ;
    end 


  // Port inputs from NoC
  // NoC port 0
  // FIXME
  //assign    mgr__noc__port0_fc      = Port_from_NoC_Control[0].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC_fifo[0].write_cntl    = noc__mgr__port0_cntl               ;
      Port_from_NoC_fifo[0].write_data    = noc__mgr__port0_data               ;
      Port_from_NoC_fifo[0].write         = noc__mgr__port0_valid              ;
    end 
  // FIXME
  assign Port_from_NoC_fifo[0].pipe_read  =  Port_from_NoC_fifo[0].pipe_valid   ;

  // NoC port 1
  // FIXME
  //assign    mgr__noc__port1_fc      = Port_from_NoC_Control[1].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC_fifo[1].write_cntl    = noc__mgr__port1_cntl               ;
      Port_from_NoC_fifo[1].write_data    = noc__mgr__port1_data               ;
      Port_from_NoC_fifo[1].write         = noc__mgr__port1_valid              ;
    end 
  // FIXME
  assign Port_from_NoC_fifo[1].pipe_read  =  Port_from_NoC_fifo[1].pipe_valid   ;

  // NoC port 2
  // FIXME
  //assign    mgr__noc__port2_fc      = Port_from_NoC_Control[2].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC_fifo[2].write_cntl    = noc__mgr__port2_cntl               ;
      Port_from_NoC_fifo[2].write_data    = noc__mgr__port2_data               ;
      Port_from_NoC_fifo[2].write         = noc__mgr__port2_valid              ;
    end 
  // FIXME
  assign Port_from_NoC_fifo[2].pipe_read  =  Port_from_NoC_fifo[2].pipe_valid   ;

  // NoC port 3
  // FIXME
  //assign    mgr__noc__port3_fc      = Port_from_NoC_Control[3].fifo_almost_full ;
  always @(*)
    begin 
      Port_from_NoC_fifo[3].write_cntl    = noc__mgr__port3_cntl               ;
      Port_from_NoC_fifo[3].write_data    = noc__mgr__port3_data               ;
      Port_from_NoC_fifo[3].write         = noc__mgr__port3_valid              ;
    end 
  // FIXME
  assign Port_from_NoC_fifo[3].pipe_read  =  Port_from_NoC_fifo[3].pipe_valid   ;

