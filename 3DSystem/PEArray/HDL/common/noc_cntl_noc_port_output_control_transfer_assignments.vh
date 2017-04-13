
  // Port outputs to NoC
  // NoC port 0
  assign pe__noc__port0_cntl  = Port_to_NoC[0].fifo_read_cntl;
  assign pe__noc__port0_data  = Port_to_NoC[0].fifo_read_data;
  assign Port_to_NoC[0].fifo_read = ~Port_to_NoC[0].fifo_empty & ~noc__pe__port0_fc ;
  always @(posedge clk)
      pe__noc__port0_valid  <= Port_to_NoC[0].fifo_read ;

  // NoC port 1
  assign pe__noc__port1_cntl  = Port_to_NoC[1].fifo_read_cntl;
  assign pe__noc__port1_data  = Port_to_NoC[1].fifo_read_data;
  assign Port_to_NoC[1].fifo_read = ~Port_to_NoC[1].fifo_empty & ~noc__pe__port1_fc ;
  always @(posedge clk)
      pe__noc__port1_valid  <= Port_to_NoC[1].fifo_read ;

  // NoC port 2
  assign pe__noc__port2_cntl  = Port_to_NoC[2].fifo_read_cntl;
  assign pe__noc__port2_data  = Port_to_NoC[2].fifo_read_data;
  assign Port_to_NoC[2].fifo_read = ~Port_to_NoC[2].fifo_empty & ~noc__pe__port2_fc ;
  always @(posedge clk)
      pe__noc__port2_valid  <= Port_to_NoC[2].fifo_read ;

  // NoC port 3
  assign pe__noc__port3_cntl  = Port_to_NoC[3].fifo_read_cntl;
  assign pe__noc__port3_data  = Port_to_NoC[3].fifo_read_data;
  assign Port_to_NoC[3].fifo_read = ~Port_to_NoC[3].fifo_empty & ~noc__pe__port3_fc ;
  always @(posedge clk)
      pe__noc__port3_valid  <= Port_to_NoC[3].fifo_read ;

