
        begin
          forever
            begin
              // Observe NoC packets sent from manager 0
              @(vLocalToNoC[0].cb_p);
              if ((vLocalToNoC[0].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [0] = new();
                  noc_sent_packet_complete[0] = 0;    
                  while(~noc_sent_packet_complete[0])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 0);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[0].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[0].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [0].timeTag              = $time;
                          local_noc_pkt_sent [0].header_destination_address  = vLocalToNoC[0].locl__noc__dp_data     ;
                          local_noc_pkt_sent [0].header_source               = 0                                     ;
                          local_noc_pkt_sent [0].header_address_type         = vLocalToNoC[0].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [0].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[0].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[0].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [0] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [0] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [0] = vLocalToNoC[0].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [0] = vLocalToNoC[0].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [0].payload_tuple_type.push_back      (payload_tuple_type      [0])    ;
                              local_noc_pkt_sent [0].payload_tuple_extd_value.push_back(payload_tuple_extd_value[0])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[0].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [0] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [0] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [0] = vLocalToNoC[0].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [0] = vLocalToNoC[0].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [0].payload_tuple_type.push_back      (payload_tuple_type      [0])    ;
                                  local_noc_pkt_sent [0].payload_tuple_extd_value.push_back(payload_tuple_extd_value[0])    ;
                                end
                            end
                          else if (vLocalToNoC[0].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [0] = vLocalToNoC[0].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [0].payload_data.push_back (payload_data      [0])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[0].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [0] = vLocalToNoC[0].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [0].payload_data.push_back (payload_data      [0])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[0].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[0].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [0].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 0, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [0]);
                                  local_noc_pkt_sent [0].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[0] = 1;    
                        end
                      @(vLocalToNoC[0].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 1
              @(vLocalToNoC[1].cb_p);
              if ((vLocalToNoC[1].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [1] = new();
                  noc_sent_packet_complete[1] = 0;    
                  while(~noc_sent_packet_complete[1])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 1);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[1].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[1].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [1].timeTag              = $time;
                          local_noc_pkt_sent [1].header_destination_address  = vLocalToNoC[1].locl__noc__dp_data     ;
                          local_noc_pkt_sent [1].header_source               = 1                                     ;
                          local_noc_pkt_sent [1].header_address_type         = vLocalToNoC[1].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [1].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[1].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[1].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [1] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [1] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [1] = vLocalToNoC[1].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [1] = vLocalToNoC[1].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [1].payload_tuple_type.push_back      (payload_tuple_type      [1])    ;
                              local_noc_pkt_sent [1].payload_tuple_extd_value.push_back(payload_tuple_extd_value[1])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[1].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [1] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [1] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [1] = vLocalToNoC[1].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [1] = vLocalToNoC[1].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [1].payload_tuple_type.push_back      (payload_tuple_type      [1])    ;
                                  local_noc_pkt_sent [1].payload_tuple_extd_value.push_back(payload_tuple_extd_value[1])    ;
                                end
                            end
                          else if (vLocalToNoC[1].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [1] = vLocalToNoC[1].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [1].payload_data.push_back (payload_data      [1])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[1].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [1] = vLocalToNoC[1].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [1].payload_data.push_back (payload_data      [1])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[1].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[1].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [1].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 1, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [1]);
                                  local_noc_pkt_sent [1].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[1] = 1;    
                        end
                      @(vLocalToNoC[1].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 2
              @(vLocalToNoC[2].cb_p);
              if ((vLocalToNoC[2].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [2] = new();
                  noc_sent_packet_complete[2] = 0;    
                  while(~noc_sent_packet_complete[2])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 2);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[2].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[2].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [2].timeTag              = $time;
                          local_noc_pkt_sent [2].header_destination_address  = vLocalToNoC[2].locl__noc__dp_data     ;
                          local_noc_pkt_sent [2].header_source               = 2                                     ;
                          local_noc_pkt_sent [2].header_address_type         = vLocalToNoC[2].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [2].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[2].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[2].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [2] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [2] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [2] = vLocalToNoC[2].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [2] = vLocalToNoC[2].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [2].payload_tuple_type.push_back      (payload_tuple_type      [2])    ;
                              local_noc_pkt_sent [2].payload_tuple_extd_value.push_back(payload_tuple_extd_value[2])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[2].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [2] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [2] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [2] = vLocalToNoC[2].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [2] = vLocalToNoC[2].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [2].payload_tuple_type.push_back      (payload_tuple_type      [2])    ;
                                  local_noc_pkt_sent [2].payload_tuple_extd_value.push_back(payload_tuple_extd_value[2])    ;
                                end
                            end
                          else if (vLocalToNoC[2].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [2] = vLocalToNoC[2].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [2].payload_data.push_back (payload_data      [2])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[2].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [2] = vLocalToNoC[2].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [2].payload_data.push_back (payload_data      [2])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[2].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[2].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [2].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 2, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [2]);
                                  local_noc_pkt_sent [2].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[2] = 1;    
                        end
                      @(vLocalToNoC[2].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 3
              @(vLocalToNoC[3].cb_p);
              if ((vLocalToNoC[3].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [3] = new();
                  noc_sent_packet_complete[3] = 0;    
                  while(~noc_sent_packet_complete[3])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 3);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[3].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[3].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [3].timeTag              = $time;
                          local_noc_pkt_sent [3].header_destination_address  = vLocalToNoC[3].locl__noc__dp_data     ;
                          local_noc_pkt_sent [3].header_source               = 3                                     ;
                          local_noc_pkt_sent [3].header_address_type         = vLocalToNoC[3].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [3].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[3].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[3].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [3] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [3] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [3] = vLocalToNoC[3].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [3] = vLocalToNoC[3].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [3].payload_tuple_type.push_back      (payload_tuple_type      [3])    ;
                              local_noc_pkt_sent [3].payload_tuple_extd_value.push_back(payload_tuple_extd_value[3])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[3].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [3] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [3] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [3] = vLocalToNoC[3].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [3] = vLocalToNoC[3].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [3].payload_tuple_type.push_back      (payload_tuple_type      [3])    ;
                                  local_noc_pkt_sent [3].payload_tuple_extd_value.push_back(payload_tuple_extd_value[3])    ;
                                end
                            end
                          else if (vLocalToNoC[3].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [3] = vLocalToNoC[3].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [3].payload_data.push_back (payload_data      [3])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[3].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [3] = vLocalToNoC[3].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [3].payload_data.push_back (payload_data      [3])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[3].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[3].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [3].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 3, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [3]);
                                  local_noc_pkt_sent [3].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[3] = 1;    
                        end
                      @(vLocalToNoC[3].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 4
              @(vLocalToNoC[4].cb_p);
              if ((vLocalToNoC[4].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [4] = new();
                  noc_sent_packet_complete[4] = 0;    
                  while(~noc_sent_packet_complete[4])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 4);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[4].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[4].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [4].timeTag              = $time;
                          local_noc_pkt_sent [4].header_destination_address  = vLocalToNoC[4].locl__noc__dp_data     ;
                          local_noc_pkt_sent [4].header_source               = 4                                     ;
                          local_noc_pkt_sent [4].header_address_type         = vLocalToNoC[4].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [4].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[4].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[4].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [4] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [4] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [4] = vLocalToNoC[4].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [4] = vLocalToNoC[4].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [4].payload_tuple_type.push_back      (payload_tuple_type      [4])    ;
                              local_noc_pkt_sent [4].payload_tuple_extd_value.push_back(payload_tuple_extd_value[4])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[4].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [4] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [4] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [4] = vLocalToNoC[4].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [4] = vLocalToNoC[4].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [4].payload_tuple_type.push_back      (payload_tuple_type      [4])    ;
                                  local_noc_pkt_sent [4].payload_tuple_extd_value.push_back(payload_tuple_extd_value[4])    ;
                                end
                            end
                          else if (vLocalToNoC[4].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [4] = vLocalToNoC[4].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [4].payload_data.push_back (payload_data      [4])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[4].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [4] = vLocalToNoC[4].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [4].payload_data.push_back (payload_data      [4])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[4].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[4].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [4].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 4, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [4]);
                                  local_noc_pkt_sent [4].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[4] = 1;    
                        end
                      @(vLocalToNoC[4].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 5
              @(vLocalToNoC[5].cb_p);
              if ((vLocalToNoC[5].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [5] = new();
                  noc_sent_packet_complete[5] = 0;    
                  while(~noc_sent_packet_complete[5])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 5);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[5].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[5].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [5].timeTag              = $time;
                          local_noc_pkt_sent [5].header_destination_address  = vLocalToNoC[5].locl__noc__dp_data     ;
                          local_noc_pkt_sent [5].header_source               = 5                                     ;
                          local_noc_pkt_sent [5].header_address_type         = vLocalToNoC[5].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [5].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[5].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[5].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [5] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [5] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [5] = vLocalToNoC[5].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [5] = vLocalToNoC[5].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [5].payload_tuple_type.push_back      (payload_tuple_type      [5])    ;
                              local_noc_pkt_sent [5].payload_tuple_extd_value.push_back(payload_tuple_extd_value[5])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[5].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [5] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [5] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [5] = vLocalToNoC[5].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [5] = vLocalToNoC[5].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [5].payload_tuple_type.push_back      (payload_tuple_type      [5])    ;
                                  local_noc_pkt_sent [5].payload_tuple_extd_value.push_back(payload_tuple_extd_value[5])    ;
                                end
                            end
                          else if (vLocalToNoC[5].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [5] = vLocalToNoC[5].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [5].payload_data.push_back (payload_data      [5])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[5].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [5] = vLocalToNoC[5].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [5].payload_data.push_back (payload_data      [5])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[5].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[5].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [5].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 5, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [5]);
                                  local_noc_pkt_sent [5].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[5] = 1;    
                        end
                      @(vLocalToNoC[5].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 6
              @(vLocalToNoC[6].cb_p);
              if ((vLocalToNoC[6].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [6] = new();
                  noc_sent_packet_complete[6] = 0;    
                  while(~noc_sent_packet_complete[6])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 6);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[6].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[6].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [6].timeTag              = $time;
                          local_noc_pkt_sent [6].header_destination_address  = vLocalToNoC[6].locl__noc__dp_data     ;
                          local_noc_pkt_sent [6].header_source               = 6                                     ;
                          local_noc_pkt_sent [6].header_address_type         = vLocalToNoC[6].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [6].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[6].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[6].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [6] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [6] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [6] = vLocalToNoC[6].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [6] = vLocalToNoC[6].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [6].payload_tuple_type.push_back      (payload_tuple_type      [6])    ;
                              local_noc_pkt_sent [6].payload_tuple_extd_value.push_back(payload_tuple_extd_value[6])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[6].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [6] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [6] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [6] = vLocalToNoC[6].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [6] = vLocalToNoC[6].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [6].payload_tuple_type.push_back      (payload_tuple_type      [6])    ;
                                  local_noc_pkt_sent [6].payload_tuple_extd_value.push_back(payload_tuple_extd_value[6])    ;
                                end
                            end
                          else if (vLocalToNoC[6].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [6] = vLocalToNoC[6].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [6].payload_data.push_back (payload_data      [6])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[6].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [6] = vLocalToNoC[6].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [6].payload_data.push_back (payload_data      [6])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[6].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[6].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [6].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 6, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [6]);
                                  local_noc_pkt_sent [6].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[6] = 1;    
                        end
                      @(vLocalToNoC[6].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 7
              @(vLocalToNoC[7].cb_p);
              if ((vLocalToNoC[7].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [7] = new();
                  noc_sent_packet_complete[7] = 0;    
                  while(~noc_sent_packet_complete[7])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 7);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[7].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[7].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [7].timeTag              = $time;
                          local_noc_pkt_sent [7].header_destination_address  = vLocalToNoC[7].locl__noc__dp_data     ;
                          local_noc_pkt_sent [7].header_source               = 7                                     ;
                          local_noc_pkt_sent [7].header_address_type         = vLocalToNoC[7].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [7].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[7].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[7].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [7] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [7] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [7] = vLocalToNoC[7].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [7] = vLocalToNoC[7].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [7].payload_tuple_type.push_back      (payload_tuple_type      [7])    ;
                              local_noc_pkt_sent [7].payload_tuple_extd_value.push_back(payload_tuple_extd_value[7])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[7].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [7] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [7] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [7] = vLocalToNoC[7].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [7] = vLocalToNoC[7].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [7].payload_tuple_type.push_back      (payload_tuple_type      [7])    ;
                                  local_noc_pkt_sent [7].payload_tuple_extd_value.push_back(payload_tuple_extd_value[7])    ;
                                end
                            end
                          else if (vLocalToNoC[7].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [7] = vLocalToNoC[7].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [7].payload_data.push_back (payload_data      [7])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[7].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [7] = vLocalToNoC[7].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [7].payload_data.push_back (payload_data      [7])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[7].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[7].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [7].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 7, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [7]);
                                  local_noc_pkt_sent [7].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[7] = 1;    
                        end
                      @(vLocalToNoC[7].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 8
              @(vLocalToNoC[8].cb_p);
              if ((vLocalToNoC[8].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [8] = new();
                  noc_sent_packet_complete[8] = 0;    
                  while(~noc_sent_packet_complete[8])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 8);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[8].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[8].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [8].timeTag              = $time;
                          local_noc_pkt_sent [8].header_destination_address  = vLocalToNoC[8].locl__noc__dp_data     ;
                          local_noc_pkt_sent [8].header_source               = 8                                     ;
                          local_noc_pkt_sent [8].header_address_type         = vLocalToNoC[8].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [8].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[8].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[8].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [8] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [8] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [8] = vLocalToNoC[8].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [8] = vLocalToNoC[8].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [8].payload_tuple_type.push_back      (payload_tuple_type      [8])    ;
                              local_noc_pkt_sent [8].payload_tuple_extd_value.push_back(payload_tuple_extd_value[8])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[8].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [8] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [8] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [8] = vLocalToNoC[8].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [8] = vLocalToNoC[8].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [8].payload_tuple_type.push_back      (payload_tuple_type      [8])    ;
                                  local_noc_pkt_sent [8].payload_tuple_extd_value.push_back(payload_tuple_extd_value[8])    ;
                                end
                            end
                          else if (vLocalToNoC[8].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [8] = vLocalToNoC[8].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [8].payload_data.push_back (payload_data      [8])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[8].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [8] = vLocalToNoC[8].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [8].payload_data.push_back (payload_data      [8])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[8].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[8].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [8].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 8, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [8]);
                                  local_noc_pkt_sent [8].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[8] = 1;    
                        end
                      @(vLocalToNoC[8].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 9
              @(vLocalToNoC[9].cb_p);
              if ((vLocalToNoC[9].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [9] = new();
                  noc_sent_packet_complete[9] = 0;    
                  while(~noc_sent_packet_complete[9])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 9);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[9].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[9].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [9].timeTag              = $time;
                          local_noc_pkt_sent [9].header_destination_address  = vLocalToNoC[9].locl__noc__dp_data     ;
                          local_noc_pkt_sent [9].header_source               = 9                                     ;
                          local_noc_pkt_sent [9].header_address_type         = vLocalToNoC[9].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [9].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[9].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[9].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [9] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [9] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [9] = vLocalToNoC[9].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [9] = vLocalToNoC[9].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [9].payload_tuple_type.push_back      (payload_tuple_type      [9])    ;
                              local_noc_pkt_sent [9].payload_tuple_extd_value.push_back(payload_tuple_extd_value[9])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[9].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [9] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [9] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [9] = vLocalToNoC[9].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [9] = vLocalToNoC[9].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [9].payload_tuple_type.push_back      (payload_tuple_type      [9])    ;
                                  local_noc_pkt_sent [9].payload_tuple_extd_value.push_back(payload_tuple_extd_value[9])    ;
                                end
                            end
                          else if (vLocalToNoC[9].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [9] = vLocalToNoC[9].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [9].payload_data.push_back (payload_data      [9])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[9].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [9] = vLocalToNoC[9].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [9].payload_data.push_back (payload_data      [9])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[9].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[9].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [9].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 9, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [9]);
                                  local_noc_pkt_sent [9].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[9] = 1;    
                        end
                      @(vLocalToNoC[9].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 10
              @(vLocalToNoC[10].cb_p);
              if ((vLocalToNoC[10].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [10] = new();
                  noc_sent_packet_complete[10] = 0;    
                  while(~noc_sent_packet_complete[10])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 10);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[10].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[10].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [10].timeTag              = $time;
                          local_noc_pkt_sent [10].header_destination_address  = vLocalToNoC[10].locl__noc__dp_data     ;
                          local_noc_pkt_sent [10].header_source               = 10                                     ;
                          local_noc_pkt_sent [10].header_address_type         = vLocalToNoC[10].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [10].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[10].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[10].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [10] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [10] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [10] = vLocalToNoC[10].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [10] = vLocalToNoC[10].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [10].payload_tuple_type.push_back      (payload_tuple_type      [10])    ;
                              local_noc_pkt_sent [10].payload_tuple_extd_value.push_back(payload_tuple_extd_value[10])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[10].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [10] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [10] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [10] = vLocalToNoC[10].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [10] = vLocalToNoC[10].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [10].payload_tuple_type.push_back      (payload_tuple_type      [10])    ;
                                  local_noc_pkt_sent [10].payload_tuple_extd_value.push_back(payload_tuple_extd_value[10])    ;
                                end
                            end
                          else if (vLocalToNoC[10].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [10] = vLocalToNoC[10].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [10].payload_data.push_back (payload_data      [10])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[10].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [10] = vLocalToNoC[10].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [10].payload_data.push_back (payload_data      [10])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[10].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[10].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [10].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 10, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [10]);
                                  local_noc_pkt_sent [10].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[10] = 1;    
                        end
                      @(vLocalToNoC[10].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 11
              @(vLocalToNoC[11].cb_p);
              if ((vLocalToNoC[11].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [11] = new();
                  noc_sent_packet_complete[11] = 0;    
                  while(~noc_sent_packet_complete[11])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 11);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[11].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[11].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [11].timeTag              = $time;
                          local_noc_pkt_sent [11].header_destination_address  = vLocalToNoC[11].locl__noc__dp_data     ;
                          local_noc_pkt_sent [11].header_source               = 11                                     ;
                          local_noc_pkt_sent [11].header_address_type         = vLocalToNoC[11].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [11].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[11].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[11].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [11] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [11] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [11] = vLocalToNoC[11].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [11] = vLocalToNoC[11].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [11].payload_tuple_type.push_back      (payload_tuple_type      [11])    ;
                              local_noc_pkt_sent [11].payload_tuple_extd_value.push_back(payload_tuple_extd_value[11])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[11].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [11] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [11] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [11] = vLocalToNoC[11].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [11] = vLocalToNoC[11].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [11].payload_tuple_type.push_back      (payload_tuple_type      [11])    ;
                                  local_noc_pkt_sent [11].payload_tuple_extd_value.push_back(payload_tuple_extd_value[11])    ;
                                end
                            end
                          else if (vLocalToNoC[11].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [11] = vLocalToNoC[11].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [11].payload_data.push_back (payload_data      [11])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[11].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [11] = vLocalToNoC[11].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [11].payload_data.push_back (payload_data      [11])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[11].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[11].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [11].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 11, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [11]);
                                  local_noc_pkt_sent [11].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[11] = 1;    
                        end
                      @(vLocalToNoC[11].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 12
              @(vLocalToNoC[12].cb_p);
              if ((vLocalToNoC[12].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [12] = new();
                  noc_sent_packet_complete[12] = 0;    
                  while(~noc_sent_packet_complete[12])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 12);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[12].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[12].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [12].timeTag              = $time;
                          local_noc_pkt_sent [12].header_destination_address  = vLocalToNoC[12].locl__noc__dp_data     ;
                          local_noc_pkt_sent [12].header_source               = 12                                     ;
                          local_noc_pkt_sent [12].header_address_type         = vLocalToNoC[12].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [12].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[12].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[12].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [12] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [12] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [12] = vLocalToNoC[12].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [12] = vLocalToNoC[12].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [12].payload_tuple_type.push_back      (payload_tuple_type      [12])    ;
                              local_noc_pkt_sent [12].payload_tuple_extd_value.push_back(payload_tuple_extd_value[12])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[12].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [12] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [12] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [12] = vLocalToNoC[12].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [12] = vLocalToNoC[12].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [12].payload_tuple_type.push_back      (payload_tuple_type      [12])    ;
                                  local_noc_pkt_sent [12].payload_tuple_extd_value.push_back(payload_tuple_extd_value[12])    ;
                                end
                            end
                          else if (vLocalToNoC[12].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [12] = vLocalToNoC[12].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [12].payload_data.push_back (payload_data      [12])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[12].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [12] = vLocalToNoC[12].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [12].payload_data.push_back (payload_data      [12])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[12].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[12].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [12].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 12, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [12]);
                                  local_noc_pkt_sent [12].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[12] = 1;    
                        end
                      @(vLocalToNoC[12].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 13
              @(vLocalToNoC[13].cb_p);
              if ((vLocalToNoC[13].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [13] = new();
                  noc_sent_packet_complete[13] = 0;    
                  while(~noc_sent_packet_complete[13])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 13);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[13].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[13].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [13].timeTag              = $time;
                          local_noc_pkt_sent [13].header_destination_address  = vLocalToNoC[13].locl__noc__dp_data     ;
                          local_noc_pkt_sent [13].header_source               = 13                                     ;
                          local_noc_pkt_sent [13].header_address_type         = vLocalToNoC[13].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [13].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[13].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[13].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [13] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [13] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [13] = vLocalToNoC[13].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [13] = vLocalToNoC[13].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [13].payload_tuple_type.push_back      (payload_tuple_type      [13])    ;
                              local_noc_pkt_sent [13].payload_tuple_extd_value.push_back(payload_tuple_extd_value[13])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[13].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [13] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [13] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [13] = vLocalToNoC[13].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [13] = vLocalToNoC[13].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [13].payload_tuple_type.push_back      (payload_tuple_type      [13])    ;
                                  local_noc_pkt_sent [13].payload_tuple_extd_value.push_back(payload_tuple_extd_value[13])    ;
                                end
                            end
                          else if (vLocalToNoC[13].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [13] = vLocalToNoC[13].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [13].payload_data.push_back (payload_data      [13])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[13].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [13] = vLocalToNoC[13].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [13].payload_data.push_back (payload_data      [13])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[13].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[13].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [13].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 13, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [13]);
                                  local_noc_pkt_sent [13].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[13] = 1;    
                        end
                      @(vLocalToNoC[13].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 14
              @(vLocalToNoC[14].cb_p);
              if ((vLocalToNoC[14].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [14] = new();
                  noc_sent_packet_complete[14] = 0;    
                  while(~noc_sent_packet_complete[14])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 14);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[14].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[14].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [14].timeTag              = $time;
                          local_noc_pkt_sent [14].header_destination_address  = vLocalToNoC[14].locl__noc__dp_data     ;
                          local_noc_pkt_sent [14].header_source               = 14                                     ;
                          local_noc_pkt_sent [14].header_address_type         = vLocalToNoC[14].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [14].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[14].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[14].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [14] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [14] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [14] = vLocalToNoC[14].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [14] = vLocalToNoC[14].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [14].payload_tuple_type.push_back      (payload_tuple_type      [14])    ;
                              local_noc_pkt_sent [14].payload_tuple_extd_value.push_back(payload_tuple_extd_value[14])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[14].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [14] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [14] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [14] = vLocalToNoC[14].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [14] = vLocalToNoC[14].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [14].payload_tuple_type.push_back      (payload_tuple_type      [14])    ;
                                  local_noc_pkt_sent [14].payload_tuple_extd_value.push_back(payload_tuple_extd_value[14])    ;
                                end
                            end
                          else if (vLocalToNoC[14].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [14] = vLocalToNoC[14].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [14].payload_data.push_back (payload_data      [14])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[14].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [14] = vLocalToNoC[14].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [14].payload_data.push_back (payload_data      [14])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[14].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[14].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [14].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 14, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [14]);
                                  local_noc_pkt_sent [14].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[14] = 1;    
                        end
                      @(vLocalToNoC[14].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 15
              @(vLocalToNoC[15].cb_p);
              if ((vLocalToNoC[15].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [15] = new();
                  noc_sent_packet_complete[15] = 0;    
                  while(~noc_sent_packet_complete[15])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 15);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[15].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[15].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [15].timeTag              = $time;
                          local_noc_pkt_sent [15].header_destination_address  = vLocalToNoC[15].locl__noc__dp_data     ;
                          local_noc_pkt_sent [15].header_source               = 15                                     ;
                          local_noc_pkt_sent [15].header_address_type         = vLocalToNoC[15].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [15].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[15].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[15].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [15] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [15] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [15] = vLocalToNoC[15].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [15] = vLocalToNoC[15].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [15].payload_tuple_type.push_back      (payload_tuple_type      [15])    ;
                              local_noc_pkt_sent [15].payload_tuple_extd_value.push_back(payload_tuple_extd_value[15])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[15].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [15] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [15] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [15] = vLocalToNoC[15].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [15] = vLocalToNoC[15].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [15].payload_tuple_type.push_back      (payload_tuple_type      [15])    ;
                                  local_noc_pkt_sent [15].payload_tuple_extd_value.push_back(payload_tuple_extd_value[15])    ;
                                end
                            end
                          else if (vLocalToNoC[15].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [15] = vLocalToNoC[15].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [15].payload_data.push_back (payload_data      [15])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[15].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [15] = vLocalToNoC[15].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [15].payload_data.push_back (payload_data      [15])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[15].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[15].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [15].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 15, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [15]);
                                  local_noc_pkt_sent [15].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[15] = 1;    
                        end
                      @(vLocalToNoC[15].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 16
              @(vLocalToNoC[16].cb_p);
              if ((vLocalToNoC[16].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [16] = new();
                  noc_sent_packet_complete[16] = 0;    
                  while(~noc_sent_packet_complete[16])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 16);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[16].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[16].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [16].timeTag              = $time;
                          local_noc_pkt_sent [16].header_destination_address  = vLocalToNoC[16].locl__noc__dp_data     ;
                          local_noc_pkt_sent [16].header_source               = 16                                     ;
                          local_noc_pkt_sent [16].header_address_type         = vLocalToNoC[16].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [16].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[16].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[16].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [16] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [16] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [16] = vLocalToNoC[16].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [16] = vLocalToNoC[16].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [16].payload_tuple_type.push_back      (payload_tuple_type      [16])    ;
                              local_noc_pkt_sent [16].payload_tuple_extd_value.push_back(payload_tuple_extd_value[16])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[16].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [16] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [16] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [16] = vLocalToNoC[16].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [16] = vLocalToNoC[16].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [16].payload_tuple_type.push_back      (payload_tuple_type      [16])    ;
                                  local_noc_pkt_sent [16].payload_tuple_extd_value.push_back(payload_tuple_extd_value[16])    ;
                                end
                            end
                          else if (vLocalToNoC[16].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [16] = vLocalToNoC[16].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [16].payload_data.push_back (payload_data      [16])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[16].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [16] = vLocalToNoC[16].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [16].payload_data.push_back (payload_data      [16])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[16].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[16].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [16].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 16, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [16]);
                                  local_noc_pkt_sent [16].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[16] = 1;    
                        end
                      @(vLocalToNoC[16].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 17
              @(vLocalToNoC[17].cb_p);
              if ((vLocalToNoC[17].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [17] = new();
                  noc_sent_packet_complete[17] = 0;    
                  while(~noc_sent_packet_complete[17])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 17);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[17].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[17].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [17].timeTag              = $time;
                          local_noc_pkt_sent [17].header_destination_address  = vLocalToNoC[17].locl__noc__dp_data     ;
                          local_noc_pkt_sent [17].header_source               = 17                                     ;
                          local_noc_pkt_sent [17].header_address_type         = vLocalToNoC[17].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [17].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[17].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[17].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [17] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [17] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [17] = vLocalToNoC[17].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [17] = vLocalToNoC[17].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [17].payload_tuple_type.push_back      (payload_tuple_type      [17])    ;
                              local_noc_pkt_sent [17].payload_tuple_extd_value.push_back(payload_tuple_extd_value[17])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[17].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [17] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [17] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [17] = vLocalToNoC[17].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [17] = vLocalToNoC[17].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [17].payload_tuple_type.push_back      (payload_tuple_type      [17])    ;
                                  local_noc_pkt_sent [17].payload_tuple_extd_value.push_back(payload_tuple_extd_value[17])    ;
                                end
                            end
                          else if (vLocalToNoC[17].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [17] = vLocalToNoC[17].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [17].payload_data.push_back (payload_data      [17])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[17].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [17] = vLocalToNoC[17].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [17].payload_data.push_back (payload_data      [17])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[17].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[17].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [17].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 17, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [17]);
                                  local_noc_pkt_sent [17].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[17] = 1;    
                        end
                      @(vLocalToNoC[17].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 18
              @(vLocalToNoC[18].cb_p);
              if ((vLocalToNoC[18].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [18] = new();
                  noc_sent_packet_complete[18] = 0;    
                  while(~noc_sent_packet_complete[18])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 18);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[18].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[18].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [18].timeTag              = $time;
                          local_noc_pkt_sent [18].header_destination_address  = vLocalToNoC[18].locl__noc__dp_data     ;
                          local_noc_pkt_sent [18].header_source               = 18                                     ;
                          local_noc_pkt_sent [18].header_address_type         = vLocalToNoC[18].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [18].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[18].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[18].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [18] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [18] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [18] = vLocalToNoC[18].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [18] = vLocalToNoC[18].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [18].payload_tuple_type.push_back      (payload_tuple_type      [18])    ;
                              local_noc_pkt_sent [18].payload_tuple_extd_value.push_back(payload_tuple_extd_value[18])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[18].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [18] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [18] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [18] = vLocalToNoC[18].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [18] = vLocalToNoC[18].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [18].payload_tuple_type.push_back      (payload_tuple_type      [18])    ;
                                  local_noc_pkt_sent [18].payload_tuple_extd_value.push_back(payload_tuple_extd_value[18])    ;
                                end
                            end
                          else if (vLocalToNoC[18].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [18] = vLocalToNoC[18].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [18].payload_data.push_back (payload_data      [18])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[18].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [18] = vLocalToNoC[18].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [18].payload_data.push_back (payload_data      [18])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[18].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[18].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [18].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 18, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [18]);
                                  local_noc_pkt_sent [18].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[18] = 1;    
                        end
                      @(vLocalToNoC[18].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 19
              @(vLocalToNoC[19].cb_p);
              if ((vLocalToNoC[19].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [19] = new();
                  noc_sent_packet_complete[19] = 0;    
                  while(~noc_sent_packet_complete[19])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 19);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[19].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[19].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [19].timeTag              = $time;
                          local_noc_pkt_sent [19].header_destination_address  = vLocalToNoC[19].locl__noc__dp_data     ;
                          local_noc_pkt_sent [19].header_source               = 19                                     ;
                          local_noc_pkt_sent [19].header_address_type         = vLocalToNoC[19].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [19].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[19].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[19].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [19] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [19] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [19] = vLocalToNoC[19].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [19] = vLocalToNoC[19].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [19].payload_tuple_type.push_back      (payload_tuple_type      [19])    ;
                              local_noc_pkt_sent [19].payload_tuple_extd_value.push_back(payload_tuple_extd_value[19])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[19].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [19] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [19] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [19] = vLocalToNoC[19].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [19] = vLocalToNoC[19].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [19].payload_tuple_type.push_back      (payload_tuple_type      [19])    ;
                                  local_noc_pkt_sent [19].payload_tuple_extd_value.push_back(payload_tuple_extd_value[19])    ;
                                end
                            end
                          else if (vLocalToNoC[19].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [19] = vLocalToNoC[19].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [19].payload_data.push_back (payload_data      [19])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[19].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [19] = vLocalToNoC[19].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [19].payload_data.push_back (payload_data      [19])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[19].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[19].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [19].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 19, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [19]);
                                  local_noc_pkt_sent [19].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[19] = 1;    
                        end
                      @(vLocalToNoC[19].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 20
              @(vLocalToNoC[20].cb_p);
              if ((vLocalToNoC[20].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [20] = new();
                  noc_sent_packet_complete[20] = 0;    
                  while(~noc_sent_packet_complete[20])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 20);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[20].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[20].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [20].timeTag              = $time;
                          local_noc_pkt_sent [20].header_destination_address  = vLocalToNoC[20].locl__noc__dp_data     ;
                          local_noc_pkt_sent [20].header_source               = 20                                     ;
                          local_noc_pkt_sent [20].header_address_type         = vLocalToNoC[20].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [20].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[20].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[20].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [20] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [20] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [20] = vLocalToNoC[20].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [20] = vLocalToNoC[20].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [20].payload_tuple_type.push_back      (payload_tuple_type      [20])    ;
                              local_noc_pkt_sent [20].payload_tuple_extd_value.push_back(payload_tuple_extd_value[20])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[20].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [20] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [20] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [20] = vLocalToNoC[20].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [20] = vLocalToNoC[20].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [20].payload_tuple_type.push_back      (payload_tuple_type      [20])    ;
                                  local_noc_pkt_sent [20].payload_tuple_extd_value.push_back(payload_tuple_extd_value[20])    ;
                                end
                            end
                          else if (vLocalToNoC[20].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [20] = vLocalToNoC[20].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [20].payload_data.push_back (payload_data      [20])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[20].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [20] = vLocalToNoC[20].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [20].payload_data.push_back (payload_data      [20])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[20].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[20].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [20].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 20, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [20]);
                                  local_noc_pkt_sent [20].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[20] = 1;    
                        end
                      @(vLocalToNoC[20].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 21
              @(vLocalToNoC[21].cb_p);
              if ((vLocalToNoC[21].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [21] = new();
                  noc_sent_packet_complete[21] = 0;    
                  while(~noc_sent_packet_complete[21])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 21);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[21].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[21].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [21].timeTag              = $time;
                          local_noc_pkt_sent [21].header_destination_address  = vLocalToNoC[21].locl__noc__dp_data     ;
                          local_noc_pkt_sent [21].header_source               = 21                                     ;
                          local_noc_pkt_sent [21].header_address_type         = vLocalToNoC[21].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [21].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[21].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[21].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [21] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [21] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [21] = vLocalToNoC[21].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [21] = vLocalToNoC[21].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [21].payload_tuple_type.push_back      (payload_tuple_type      [21])    ;
                              local_noc_pkt_sent [21].payload_tuple_extd_value.push_back(payload_tuple_extd_value[21])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[21].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [21] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [21] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [21] = vLocalToNoC[21].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [21] = vLocalToNoC[21].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [21].payload_tuple_type.push_back      (payload_tuple_type      [21])    ;
                                  local_noc_pkt_sent [21].payload_tuple_extd_value.push_back(payload_tuple_extd_value[21])    ;
                                end
                            end
                          else if (vLocalToNoC[21].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [21] = vLocalToNoC[21].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [21].payload_data.push_back (payload_data      [21])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[21].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [21] = vLocalToNoC[21].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [21].payload_data.push_back (payload_data      [21])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[21].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[21].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [21].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 21, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [21]);
                                  local_noc_pkt_sent [21].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[21] = 1;    
                        end
                      @(vLocalToNoC[21].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 22
              @(vLocalToNoC[22].cb_p);
              if ((vLocalToNoC[22].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [22] = new();
                  noc_sent_packet_complete[22] = 0;    
                  while(~noc_sent_packet_complete[22])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 22);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[22].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[22].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [22].timeTag              = $time;
                          local_noc_pkt_sent [22].header_destination_address  = vLocalToNoC[22].locl__noc__dp_data     ;
                          local_noc_pkt_sent [22].header_source               = 22                                     ;
                          local_noc_pkt_sent [22].header_address_type         = vLocalToNoC[22].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [22].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[22].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[22].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [22] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [22] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [22] = vLocalToNoC[22].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [22] = vLocalToNoC[22].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [22].payload_tuple_type.push_back      (payload_tuple_type      [22])    ;
                              local_noc_pkt_sent [22].payload_tuple_extd_value.push_back(payload_tuple_extd_value[22])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[22].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [22] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [22] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [22] = vLocalToNoC[22].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [22] = vLocalToNoC[22].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [22].payload_tuple_type.push_back      (payload_tuple_type      [22])    ;
                                  local_noc_pkt_sent [22].payload_tuple_extd_value.push_back(payload_tuple_extd_value[22])    ;
                                end
                            end
                          else if (vLocalToNoC[22].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [22] = vLocalToNoC[22].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [22].payload_data.push_back (payload_data      [22])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[22].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [22] = vLocalToNoC[22].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [22].payload_data.push_back (payload_data      [22])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[22].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[22].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [22].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 22, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [22]);
                                  local_noc_pkt_sent [22].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[22] = 1;    
                        end
                      @(vLocalToNoC[22].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 23
              @(vLocalToNoC[23].cb_p);
              if ((vLocalToNoC[23].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [23] = new();
                  noc_sent_packet_complete[23] = 0;    
                  while(~noc_sent_packet_complete[23])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 23);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[23].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[23].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [23].timeTag              = $time;
                          local_noc_pkt_sent [23].header_destination_address  = vLocalToNoC[23].locl__noc__dp_data     ;
                          local_noc_pkt_sent [23].header_source               = 23                                     ;
                          local_noc_pkt_sent [23].header_address_type         = vLocalToNoC[23].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [23].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[23].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[23].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [23] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [23] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [23] = vLocalToNoC[23].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [23] = vLocalToNoC[23].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [23].payload_tuple_type.push_back      (payload_tuple_type      [23])    ;
                              local_noc_pkt_sent [23].payload_tuple_extd_value.push_back(payload_tuple_extd_value[23])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[23].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [23] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [23] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [23] = vLocalToNoC[23].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [23] = vLocalToNoC[23].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [23].payload_tuple_type.push_back      (payload_tuple_type      [23])    ;
                                  local_noc_pkt_sent [23].payload_tuple_extd_value.push_back(payload_tuple_extd_value[23])    ;
                                end
                            end
                          else if (vLocalToNoC[23].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [23] = vLocalToNoC[23].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [23].payload_data.push_back (payload_data      [23])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[23].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [23] = vLocalToNoC[23].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [23].payload_data.push_back (payload_data      [23])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[23].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[23].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [23].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 23, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [23]);
                                  local_noc_pkt_sent [23].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[23] = 1;    
                        end
                      @(vLocalToNoC[23].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 24
              @(vLocalToNoC[24].cb_p);
              if ((vLocalToNoC[24].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [24] = new();
                  noc_sent_packet_complete[24] = 0;    
                  while(~noc_sent_packet_complete[24])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 24);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[24].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[24].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [24].timeTag              = $time;
                          local_noc_pkt_sent [24].header_destination_address  = vLocalToNoC[24].locl__noc__dp_data     ;
                          local_noc_pkt_sent [24].header_source               = 24                                     ;
                          local_noc_pkt_sent [24].header_address_type         = vLocalToNoC[24].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [24].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[24].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[24].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [24] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [24] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [24] = vLocalToNoC[24].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [24] = vLocalToNoC[24].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [24].payload_tuple_type.push_back      (payload_tuple_type      [24])    ;
                              local_noc_pkt_sent [24].payload_tuple_extd_value.push_back(payload_tuple_extd_value[24])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[24].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [24] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [24] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [24] = vLocalToNoC[24].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [24] = vLocalToNoC[24].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [24].payload_tuple_type.push_back      (payload_tuple_type      [24])    ;
                                  local_noc_pkt_sent [24].payload_tuple_extd_value.push_back(payload_tuple_extd_value[24])    ;
                                end
                            end
                          else if (vLocalToNoC[24].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [24] = vLocalToNoC[24].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [24].payload_data.push_back (payload_data      [24])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[24].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [24] = vLocalToNoC[24].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [24].payload_data.push_back (payload_data      [24])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[24].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[24].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [24].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 24, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [24]);
                                  local_noc_pkt_sent [24].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[24] = 1;    
                        end
                      @(vLocalToNoC[24].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 25
              @(vLocalToNoC[25].cb_p);
              if ((vLocalToNoC[25].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [25] = new();
                  noc_sent_packet_complete[25] = 0;    
                  while(~noc_sent_packet_complete[25])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 25);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[25].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[25].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [25].timeTag              = $time;
                          local_noc_pkt_sent [25].header_destination_address  = vLocalToNoC[25].locl__noc__dp_data     ;
                          local_noc_pkt_sent [25].header_source               = 25                                     ;
                          local_noc_pkt_sent [25].header_address_type         = vLocalToNoC[25].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [25].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[25].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[25].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [25] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [25] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [25] = vLocalToNoC[25].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [25] = vLocalToNoC[25].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [25].payload_tuple_type.push_back      (payload_tuple_type      [25])    ;
                              local_noc_pkt_sent [25].payload_tuple_extd_value.push_back(payload_tuple_extd_value[25])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[25].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [25] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [25] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [25] = vLocalToNoC[25].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [25] = vLocalToNoC[25].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [25].payload_tuple_type.push_back      (payload_tuple_type      [25])    ;
                                  local_noc_pkt_sent [25].payload_tuple_extd_value.push_back(payload_tuple_extd_value[25])    ;
                                end
                            end
                          else if (vLocalToNoC[25].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [25] = vLocalToNoC[25].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [25].payload_data.push_back (payload_data      [25])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[25].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [25] = vLocalToNoC[25].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [25].payload_data.push_back (payload_data      [25])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[25].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[25].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [25].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 25, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [25]);
                                  local_noc_pkt_sent [25].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[25] = 1;    
                        end
                      @(vLocalToNoC[25].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 26
              @(vLocalToNoC[26].cb_p);
              if ((vLocalToNoC[26].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [26] = new();
                  noc_sent_packet_complete[26] = 0;    
                  while(~noc_sent_packet_complete[26])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 26);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[26].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[26].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [26].timeTag              = $time;
                          local_noc_pkt_sent [26].header_destination_address  = vLocalToNoC[26].locl__noc__dp_data     ;
                          local_noc_pkt_sent [26].header_source               = 26                                     ;
                          local_noc_pkt_sent [26].header_address_type         = vLocalToNoC[26].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [26].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[26].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[26].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [26] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [26] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [26] = vLocalToNoC[26].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [26] = vLocalToNoC[26].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [26].payload_tuple_type.push_back      (payload_tuple_type      [26])    ;
                              local_noc_pkt_sent [26].payload_tuple_extd_value.push_back(payload_tuple_extd_value[26])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[26].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [26] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [26] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [26] = vLocalToNoC[26].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [26] = vLocalToNoC[26].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [26].payload_tuple_type.push_back      (payload_tuple_type      [26])    ;
                                  local_noc_pkt_sent [26].payload_tuple_extd_value.push_back(payload_tuple_extd_value[26])    ;
                                end
                            end
                          else if (vLocalToNoC[26].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [26] = vLocalToNoC[26].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [26].payload_data.push_back (payload_data      [26])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[26].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [26] = vLocalToNoC[26].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [26].payload_data.push_back (payload_data      [26])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[26].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[26].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [26].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 26, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [26]);
                                  local_noc_pkt_sent [26].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[26] = 1;    
                        end
                      @(vLocalToNoC[26].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 27
              @(vLocalToNoC[27].cb_p);
              if ((vLocalToNoC[27].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [27] = new();
                  noc_sent_packet_complete[27] = 0;    
                  while(~noc_sent_packet_complete[27])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 27);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[27].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[27].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [27].timeTag              = $time;
                          local_noc_pkt_sent [27].header_destination_address  = vLocalToNoC[27].locl__noc__dp_data     ;
                          local_noc_pkt_sent [27].header_source               = 27                                     ;
                          local_noc_pkt_sent [27].header_address_type         = vLocalToNoC[27].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [27].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[27].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[27].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [27] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [27] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [27] = vLocalToNoC[27].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [27] = vLocalToNoC[27].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [27].payload_tuple_type.push_back      (payload_tuple_type      [27])    ;
                              local_noc_pkt_sent [27].payload_tuple_extd_value.push_back(payload_tuple_extd_value[27])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[27].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [27] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [27] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [27] = vLocalToNoC[27].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [27] = vLocalToNoC[27].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [27].payload_tuple_type.push_back      (payload_tuple_type      [27])    ;
                                  local_noc_pkt_sent [27].payload_tuple_extd_value.push_back(payload_tuple_extd_value[27])    ;
                                end
                            end
                          else if (vLocalToNoC[27].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [27] = vLocalToNoC[27].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [27].payload_data.push_back (payload_data      [27])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[27].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [27] = vLocalToNoC[27].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [27].payload_data.push_back (payload_data      [27])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[27].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[27].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [27].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 27, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [27]);
                                  local_noc_pkt_sent [27].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[27] = 1;    
                        end
                      @(vLocalToNoC[27].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 28
              @(vLocalToNoC[28].cb_p);
              if ((vLocalToNoC[28].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [28] = new();
                  noc_sent_packet_complete[28] = 0;    
                  while(~noc_sent_packet_complete[28])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 28);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[28].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[28].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [28].timeTag              = $time;
                          local_noc_pkt_sent [28].header_destination_address  = vLocalToNoC[28].locl__noc__dp_data     ;
                          local_noc_pkt_sent [28].header_source               = 28                                     ;
                          local_noc_pkt_sent [28].header_address_type         = vLocalToNoC[28].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [28].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[28].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[28].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [28] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [28] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [28] = vLocalToNoC[28].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [28] = vLocalToNoC[28].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [28].payload_tuple_type.push_back      (payload_tuple_type      [28])    ;
                              local_noc_pkt_sent [28].payload_tuple_extd_value.push_back(payload_tuple_extd_value[28])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[28].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [28] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [28] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [28] = vLocalToNoC[28].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [28] = vLocalToNoC[28].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [28].payload_tuple_type.push_back      (payload_tuple_type      [28])    ;
                                  local_noc_pkt_sent [28].payload_tuple_extd_value.push_back(payload_tuple_extd_value[28])    ;
                                end
                            end
                          else if (vLocalToNoC[28].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [28] = vLocalToNoC[28].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [28].payload_data.push_back (payload_data      [28])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[28].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [28] = vLocalToNoC[28].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [28].payload_data.push_back (payload_data      [28])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[28].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[28].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [28].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 28, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [28]);
                                  local_noc_pkt_sent [28].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[28] = 1;    
                        end
                      @(vLocalToNoC[28].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 29
              @(vLocalToNoC[29].cb_p);
              if ((vLocalToNoC[29].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [29] = new();
                  noc_sent_packet_complete[29] = 0;    
                  while(~noc_sent_packet_complete[29])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 29);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[29].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[29].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [29].timeTag              = $time;
                          local_noc_pkt_sent [29].header_destination_address  = vLocalToNoC[29].locl__noc__dp_data     ;
                          local_noc_pkt_sent [29].header_source               = 29                                     ;
                          local_noc_pkt_sent [29].header_address_type         = vLocalToNoC[29].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [29].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[29].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[29].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [29] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [29] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [29] = vLocalToNoC[29].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [29] = vLocalToNoC[29].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [29].payload_tuple_type.push_back      (payload_tuple_type      [29])    ;
                              local_noc_pkt_sent [29].payload_tuple_extd_value.push_back(payload_tuple_extd_value[29])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[29].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [29] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [29] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [29] = vLocalToNoC[29].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [29] = vLocalToNoC[29].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [29].payload_tuple_type.push_back      (payload_tuple_type      [29])    ;
                                  local_noc_pkt_sent [29].payload_tuple_extd_value.push_back(payload_tuple_extd_value[29])    ;
                                end
                            end
                          else if (vLocalToNoC[29].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [29] = vLocalToNoC[29].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [29].payload_data.push_back (payload_data      [29])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[29].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [29] = vLocalToNoC[29].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [29].payload_data.push_back (payload_data      [29])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[29].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[29].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [29].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 29, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [29]);
                                  local_noc_pkt_sent [29].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[29] = 1;    
                        end
                      @(vLocalToNoC[29].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 30
              @(vLocalToNoC[30].cb_p);
              if ((vLocalToNoC[30].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [30] = new();
                  noc_sent_packet_complete[30] = 0;    
                  while(~noc_sent_packet_complete[30])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 30);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[30].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[30].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [30].timeTag              = $time;
                          local_noc_pkt_sent [30].header_destination_address  = vLocalToNoC[30].locl__noc__dp_data     ;
                          local_noc_pkt_sent [30].header_source               = 30                                     ;
                          local_noc_pkt_sent [30].header_address_type         = vLocalToNoC[30].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [30].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[30].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[30].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [30] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [30] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [30] = vLocalToNoC[30].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [30] = vLocalToNoC[30].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [30].payload_tuple_type.push_back      (payload_tuple_type      [30])    ;
                              local_noc_pkt_sent [30].payload_tuple_extd_value.push_back(payload_tuple_extd_value[30])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[30].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [30] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [30] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [30] = vLocalToNoC[30].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [30] = vLocalToNoC[30].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [30].payload_tuple_type.push_back      (payload_tuple_type      [30])    ;
                                  local_noc_pkt_sent [30].payload_tuple_extd_value.push_back(payload_tuple_extd_value[30])    ;
                                end
                            end
                          else if (vLocalToNoC[30].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [30] = vLocalToNoC[30].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [30].payload_data.push_back (payload_data      [30])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[30].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [30] = vLocalToNoC[30].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [30].payload_data.push_back (payload_data      [30])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[30].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[30].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [30].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 30, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [30]);
                                  local_noc_pkt_sent [30].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[30] = 1;    
                        end
                      @(vLocalToNoC[30].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 31
              @(vLocalToNoC[31].cb_p);
              if ((vLocalToNoC[31].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [31] = new();
                  noc_sent_packet_complete[31] = 0;    
                  while(~noc_sent_packet_complete[31])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 31);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[31].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[31].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [31].timeTag              = $time;
                          local_noc_pkt_sent [31].header_destination_address  = vLocalToNoC[31].locl__noc__dp_data     ;
                          local_noc_pkt_sent [31].header_source               = 31                                     ;
                          local_noc_pkt_sent [31].header_address_type         = vLocalToNoC[31].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [31].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[31].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[31].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [31] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [31] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [31] = vLocalToNoC[31].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [31] = vLocalToNoC[31].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [31].payload_tuple_type.push_back      (payload_tuple_type      [31])    ;
                              local_noc_pkt_sent [31].payload_tuple_extd_value.push_back(payload_tuple_extd_value[31])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[31].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [31] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [31] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [31] = vLocalToNoC[31].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [31] = vLocalToNoC[31].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [31].payload_tuple_type.push_back      (payload_tuple_type      [31])    ;
                                  local_noc_pkt_sent [31].payload_tuple_extd_value.push_back(payload_tuple_extd_value[31])    ;
                                end
                            end
                          else if (vLocalToNoC[31].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [31] = vLocalToNoC[31].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [31].payload_data.push_back (payload_data      [31])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[31].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [31] = vLocalToNoC[31].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [31].payload_data.push_back (payload_data      [31])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[31].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[31].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [31].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 31, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [31]);
                                  local_noc_pkt_sent [31].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[31] = 1;    
                        end
                      @(vLocalToNoC[31].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 32
              @(vLocalToNoC[32].cb_p);
              if ((vLocalToNoC[32].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [32] = new();
                  noc_sent_packet_complete[32] = 0;    
                  while(~noc_sent_packet_complete[32])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 32);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[32].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[32].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [32].timeTag              = $time;
                          local_noc_pkt_sent [32].header_destination_address  = vLocalToNoC[32].locl__noc__dp_data     ;
                          local_noc_pkt_sent [32].header_source               = 32                                     ;
                          local_noc_pkt_sent [32].header_address_type         = vLocalToNoC[32].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [32].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[32].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[32].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [32] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [32] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [32] = vLocalToNoC[32].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [32] = vLocalToNoC[32].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [32].payload_tuple_type.push_back      (payload_tuple_type      [32])    ;
                              local_noc_pkt_sent [32].payload_tuple_extd_value.push_back(payload_tuple_extd_value[32])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[32].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [32] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [32] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [32] = vLocalToNoC[32].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [32] = vLocalToNoC[32].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [32].payload_tuple_type.push_back      (payload_tuple_type      [32])    ;
                                  local_noc_pkt_sent [32].payload_tuple_extd_value.push_back(payload_tuple_extd_value[32])    ;
                                end
                            end
                          else if (vLocalToNoC[32].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [32] = vLocalToNoC[32].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [32].payload_data.push_back (payload_data      [32])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[32].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [32] = vLocalToNoC[32].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [32].payload_data.push_back (payload_data      [32])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[32].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[32].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [32].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 32, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [32]);
                                  local_noc_pkt_sent [32].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[32] = 1;    
                        end
                      @(vLocalToNoC[32].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 33
              @(vLocalToNoC[33].cb_p);
              if ((vLocalToNoC[33].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [33] = new();
                  noc_sent_packet_complete[33] = 0;    
                  while(~noc_sent_packet_complete[33])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 33);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[33].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[33].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [33].timeTag              = $time;
                          local_noc_pkt_sent [33].header_destination_address  = vLocalToNoC[33].locl__noc__dp_data     ;
                          local_noc_pkt_sent [33].header_source               = 33                                     ;
                          local_noc_pkt_sent [33].header_address_type         = vLocalToNoC[33].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [33].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[33].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[33].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [33] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [33] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [33] = vLocalToNoC[33].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [33] = vLocalToNoC[33].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [33].payload_tuple_type.push_back      (payload_tuple_type      [33])    ;
                              local_noc_pkt_sent [33].payload_tuple_extd_value.push_back(payload_tuple_extd_value[33])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[33].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [33] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [33] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [33] = vLocalToNoC[33].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [33] = vLocalToNoC[33].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [33].payload_tuple_type.push_back      (payload_tuple_type      [33])    ;
                                  local_noc_pkt_sent [33].payload_tuple_extd_value.push_back(payload_tuple_extd_value[33])    ;
                                end
                            end
                          else if (vLocalToNoC[33].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [33] = vLocalToNoC[33].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [33].payload_data.push_back (payload_data      [33])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[33].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [33] = vLocalToNoC[33].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [33].payload_data.push_back (payload_data      [33])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[33].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[33].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [33].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 33, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [33]);
                                  local_noc_pkt_sent [33].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[33] = 1;    
                        end
                      @(vLocalToNoC[33].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 34
              @(vLocalToNoC[34].cb_p);
              if ((vLocalToNoC[34].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [34] = new();
                  noc_sent_packet_complete[34] = 0;    
                  while(~noc_sent_packet_complete[34])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 34);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[34].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[34].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [34].timeTag              = $time;
                          local_noc_pkt_sent [34].header_destination_address  = vLocalToNoC[34].locl__noc__dp_data     ;
                          local_noc_pkt_sent [34].header_source               = 34                                     ;
                          local_noc_pkt_sent [34].header_address_type         = vLocalToNoC[34].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [34].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[34].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[34].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [34] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [34] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [34] = vLocalToNoC[34].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [34] = vLocalToNoC[34].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [34].payload_tuple_type.push_back      (payload_tuple_type      [34])    ;
                              local_noc_pkt_sent [34].payload_tuple_extd_value.push_back(payload_tuple_extd_value[34])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[34].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [34] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [34] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [34] = vLocalToNoC[34].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [34] = vLocalToNoC[34].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [34].payload_tuple_type.push_back      (payload_tuple_type      [34])    ;
                                  local_noc_pkt_sent [34].payload_tuple_extd_value.push_back(payload_tuple_extd_value[34])    ;
                                end
                            end
                          else if (vLocalToNoC[34].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [34] = vLocalToNoC[34].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [34].payload_data.push_back (payload_data      [34])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[34].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [34] = vLocalToNoC[34].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [34].payload_data.push_back (payload_data      [34])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[34].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[34].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [34].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 34, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [34]);
                                  local_noc_pkt_sent [34].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[34] = 1;    
                        end
                      @(vLocalToNoC[34].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 35
              @(vLocalToNoC[35].cb_p);
              if ((vLocalToNoC[35].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [35] = new();
                  noc_sent_packet_complete[35] = 0;    
                  while(~noc_sent_packet_complete[35])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 35);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[35].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[35].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [35].timeTag              = $time;
                          local_noc_pkt_sent [35].header_destination_address  = vLocalToNoC[35].locl__noc__dp_data     ;
                          local_noc_pkt_sent [35].header_source               = 35                                     ;
                          local_noc_pkt_sent [35].header_address_type         = vLocalToNoC[35].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [35].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[35].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[35].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [35] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [35] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [35] = vLocalToNoC[35].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [35] = vLocalToNoC[35].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [35].payload_tuple_type.push_back      (payload_tuple_type      [35])    ;
                              local_noc_pkt_sent [35].payload_tuple_extd_value.push_back(payload_tuple_extd_value[35])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[35].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [35] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [35] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [35] = vLocalToNoC[35].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [35] = vLocalToNoC[35].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [35].payload_tuple_type.push_back      (payload_tuple_type      [35])    ;
                                  local_noc_pkt_sent [35].payload_tuple_extd_value.push_back(payload_tuple_extd_value[35])    ;
                                end
                            end
                          else if (vLocalToNoC[35].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [35] = vLocalToNoC[35].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [35].payload_data.push_back (payload_data      [35])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[35].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [35] = vLocalToNoC[35].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [35].payload_data.push_back (payload_data      [35])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[35].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[35].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [35].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 35, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [35]);
                                  local_noc_pkt_sent [35].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[35] = 1;    
                        end
                      @(vLocalToNoC[35].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 36
              @(vLocalToNoC[36].cb_p);
              if ((vLocalToNoC[36].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [36] = new();
                  noc_sent_packet_complete[36] = 0;    
                  while(~noc_sent_packet_complete[36])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 36);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[36].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[36].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [36].timeTag              = $time;
                          local_noc_pkt_sent [36].header_destination_address  = vLocalToNoC[36].locl__noc__dp_data     ;
                          local_noc_pkt_sent [36].header_source               = 36                                     ;
                          local_noc_pkt_sent [36].header_address_type         = vLocalToNoC[36].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [36].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[36].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[36].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [36] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [36] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [36] = vLocalToNoC[36].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [36] = vLocalToNoC[36].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [36].payload_tuple_type.push_back      (payload_tuple_type      [36])    ;
                              local_noc_pkt_sent [36].payload_tuple_extd_value.push_back(payload_tuple_extd_value[36])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[36].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [36] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [36] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [36] = vLocalToNoC[36].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [36] = vLocalToNoC[36].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [36].payload_tuple_type.push_back      (payload_tuple_type      [36])    ;
                                  local_noc_pkt_sent [36].payload_tuple_extd_value.push_back(payload_tuple_extd_value[36])    ;
                                end
                            end
                          else if (vLocalToNoC[36].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [36] = vLocalToNoC[36].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [36].payload_data.push_back (payload_data      [36])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[36].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [36] = vLocalToNoC[36].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [36].payload_data.push_back (payload_data      [36])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[36].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[36].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [36].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 36, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [36]);
                                  local_noc_pkt_sent [36].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[36] = 1;    
                        end
                      @(vLocalToNoC[36].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 37
              @(vLocalToNoC[37].cb_p);
              if ((vLocalToNoC[37].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [37] = new();
                  noc_sent_packet_complete[37] = 0;    
                  while(~noc_sent_packet_complete[37])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 37);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[37].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[37].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [37].timeTag              = $time;
                          local_noc_pkt_sent [37].header_destination_address  = vLocalToNoC[37].locl__noc__dp_data     ;
                          local_noc_pkt_sent [37].header_source               = 37                                     ;
                          local_noc_pkt_sent [37].header_address_type         = vLocalToNoC[37].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [37].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[37].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[37].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [37] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [37] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [37] = vLocalToNoC[37].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [37] = vLocalToNoC[37].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [37].payload_tuple_type.push_back      (payload_tuple_type      [37])    ;
                              local_noc_pkt_sent [37].payload_tuple_extd_value.push_back(payload_tuple_extd_value[37])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[37].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [37] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [37] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [37] = vLocalToNoC[37].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [37] = vLocalToNoC[37].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [37].payload_tuple_type.push_back      (payload_tuple_type      [37])    ;
                                  local_noc_pkt_sent [37].payload_tuple_extd_value.push_back(payload_tuple_extd_value[37])    ;
                                end
                            end
                          else if (vLocalToNoC[37].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [37] = vLocalToNoC[37].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [37].payload_data.push_back (payload_data      [37])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[37].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [37] = vLocalToNoC[37].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [37].payload_data.push_back (payload_data      [37])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[37].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[37].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [37].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 37, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [37]);
                                  local_noc_pkt_sent [37].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[37] = 1;    
                        end
                      @(vLocalToNoC[37].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 38
              @(vLocalToNoC[38].cb_p);
              if ((vLocalToNoC[38].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [38] = new();
                  noc_sent_packet_complete[38] = 0;    
                  while(~noc_sent_packet_complete[38])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 38);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[38].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[38].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [38].timeTag              = $time;
                          local_noc_pkt_sent [38].header_destination_address  = vLocalToNoC[38].locl__noc__dp_data     ;
                          local_noc_pkt_sent [38].header_source               = 38                                     ;
                          local_noc_pkt_sent [38].header_address_type         = vLocalToNoC[38].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [38].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[38].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[38].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [38] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [38] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [38] = vLocalToNoC[38].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [38] = vLocalToNoC[38].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [38].payload_tuple_type.push_back      (payload_tuple_type      [38])    ;
                              local_noc_pkt_sent [38].payload_tuple_extd_value.push_back(payload_tuple_extd_value[38])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[38].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [38] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [38] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [38] = vLocalToNoC[38].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [38] = vLocalToNoC[38].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [38].payload_tuple_type.push_back      (payload_tuple_type      [38])    ;
                                  local_noc_pkt_sent [38].payload_tuple_extd_value.push_back(payload_tuple_extd_value[38])    ;
                                end
                            end
                          else if (vLocalToNoC[38].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [38] = vLocalToNoC[38].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [38].payload_data.push_back (payload_data      [38])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[38].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [38] = vLocalToNoC[38].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [38].payload_data.push_back (payload_data      [38])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[38].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[38].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [38].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 38, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [38]);
                                  local_noc_pkt_sent [38].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[38] = 1;    
                        end
                      @(vLocalToNoC[38].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 39
              @(vLocalToNoC[39].cb_p);
              if ((vLocalToNoC[39].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [39] = new();
                  noc_sent_packet_complete[39] = 0;    
                  while(~noc_sent_packet_complete[39])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 39);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[39].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[39].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [39].timeTag              = $time;
                          local_noc_pkt_sent [39].header_destination_address  = vLocalToNoC[39].locl__noc__dp_data     ;
                          local_noc_pkt_sent [39].header_source               = 39                                     ;
                          local_noc_pkt_sent [39].header_address_type         = vLocalToNoC[39].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [39].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[39].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[39].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [39] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [39] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [39] = vLocalToNoC[39].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [39] = vLocalToNoC[39].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [39].payload_tuple_type.push_back      (payload_tuple_type      [39])    ;
                              local_noc_pkt_sent [39].payload_tuple_extd_value.push_back(payload_tuple_extd_value[39])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[39].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [39] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [39] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [39] = vLocalToNoC[39].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [39] = vLocalToNoC[39].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [39].payload_tuple_type.push_back      (payload_tuple_type      [39])    ;
                                  local_noc_pkt_sent [39].payload_tuple_extd_value.push_back(payload_tuple_extd_value[39])    ;
                                end
                            end
                          else if (vLocalToNoC[39].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [39] = vLocalToNoC[39].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [39].payload_data.push_back (payload_data      [39])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[39].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [39] = vLocalToNoC[39].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [39].payload_data.push_back (payload_data      [39])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[39].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[39].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [39].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 39, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [39]);
                                  local_noc_pkt_sent [39].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[39] = 1;    
                        end
                      @(vLocalToNoC[39].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 40
              @(vLocalToNoC[40].cb_p);
              if ((vLocalToNoC[40].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [40] = new();
                  noc_sent_packet_complete[40] = 0;    
                  while(~noc_sent_packet_complete[40])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 40);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[40].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[40].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [40].timeTag              = $time;
                          local_noc_pkt_sent [40].header_destination_address  = vLocalToNoC[40].locl__noc__dp_data     ;
                          local_noc_pkt_sent [40].header_source               = 40                                     ;
                          local_noc_pkt_sent [40].header_address_type         = vLocalToNoC[40].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [40].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[40].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[40].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [40] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [40] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [40] = vLocalToNoC[40].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [40] = vLocalToNoC[40].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [40].payload_tuple_type.push_back      (payload_tuple_type      [40])    ;
                              local_noc_pkt_sent [40].payload_tuple_extd_value.push_back(payload_tuple_extd_value[40])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[40].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [40] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [40] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [40] = vLocalToNoC[40].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [40] = vLocalToNoC[40].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [40].payload_tuple_type.push_back      (payload_tuple_type      [40])    ;
                                  local_noc_pkt_sent [40].payload_tuple_extd_value.push_back(payload_tuple_extd_value[40])    ;
                                end
                            end
                          else if (vLocalToNoC[40].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [40] = vLocalToNoC[40].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [40].payload_data.push_back (payload_data      [40])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[40].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [40] = vLocalToNoC[40].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [40].payload_data.push_back (payload_data      [40])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[40].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[40].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [40].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 40, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [40]);
                                  local_noc_pkt_sent [40].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[40] = 1;    
                        end
                      @(vLocalToNoC[40].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 41
              @(vLocalToNoC[41].cb_p);
              if ((vLocalToNoC[41].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [41] = new();
                  noc_sent_packet_complete[41] = 0;    
                  while(~noc_sent_packet_complete[41])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 41);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[41].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[41].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [41].timeTag              = $time;
                          local_noc_pkt_sent [41].header_destination_address  = vLocalToNoC[41].locl__noc__dp_data     ;
                          local_noc_pkt_sent [41].header_source               = 41                                     ;
                          local_noc_pkt_sent [41].header_address_type         = vLocalToNoC[41].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [41].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[41].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[41].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [41] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [41] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [41] = vLocalToNoC[41].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [41] = vLocalToNoC[41].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [41].payload_tuple_type.push_back      (payload_tuple_type      [41])    ;
                              local_noc_pkt_sent [41].payload_tuple_extd_value.push_back(payload_tuple_extd_value[41])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[41].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [41] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [41] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [41] = vLocalToNoC[41].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [41] = vLocalToNoC[41].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [41].payload_tuple_type.push_back      (payload_tuple_type      [41])    ;
                                  local_noc_pkt_sent [41].payload_tuple_extd_value.push_back(payload_tuple_extd_value[41])    ;
                                end
                            end
                          else if (vLocalToNoC[41].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [41] = vLocalToNoC[41].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [41].payload_data.push_back (payload_data      [41])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[41].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [41] = vLocalToNoC[41].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [41].payload_data.push_back (payload_data      [41])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[41].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[41].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [41].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 41, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [41]);
                                  local_noc_pkt_sent [41].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[41] = 1;    
                        end
                      @(vLocalToNoC[41].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 42
              @(vLocalToNoC[42].cb_p);
              if ((vLocalToNoC[42].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [42] = new();
                  noc_sent_packet_complete[42] = 0;    
                  while(~noc_sent_packet_complete[42])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 42);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[42].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[42].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [42].timeTag              = $time;
                          local_noc_pkt_sent [42].header_destination_address  = vLocalToNoC[42].locl__noc__dp_data     ;
                          local_noc_pkt_sent [42].header_source               = 42                                     ;
                          local_noc_pkt_sent [42].header_address_type         = vLocalToNoC[42].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [42].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[42].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[42].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [42] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [42] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [42] = vLocalToNoC[42].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [42] = vLocalToNoC[42].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [42].payload_tuple_type.push_back      (payload_tuple_type      [42])    ;
                              local_noc_pkt_sent [42].payload_tuple_extd_value.push_back(payload_tuple_extd_value[42])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[42].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [42] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [42] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [42] = vLocalToNoC[42].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [42] = vLocalToNoC[42].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [42].payload_tuple_type.push_back      (payload_tuple_type      [42])    ;
                                  local_noc_pkt_sent [42].payload_tuple_extd_value.push_back(payload_tuple_extd_value[42])    ;
                                end
                            end
                          else if (vLocalToNoC[42].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [42] = vLocalToNoC[42].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [42].payload_data.push_back (payload_data      [42])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[42].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [42] = vLocalToNoC[42].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [42].payload_data.push_back (payload_data      [42])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[42].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[42].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [42].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 42, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [42]);
                                  local_noc_pkt_sent [42].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[42] = 1;    
                        end
                      @(vLocalToNoC[42].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 43
              @(vLocalToNoC[43].cb_p);
              if ((vLocalToNoC[43].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [43] = new();
                  noc_sent_packet_complete[43] = 0;    
                  while(~noc_sent_packet_complete[43])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 43);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[43].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[43].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [43].timeTag              = $time;
                          local_noc_pkt_sent [43].header_destination_address  = vLocalToNoC[43].locl__noc__dp_data     ;
                          local_noc_pkt_sent [43].header_source               = 43                                     ;
                          local_noc_pkt_sent [43].header_address_type         = vLocalToNoC[43].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [43].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[43].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[43].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [43] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [43] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [43] = vLocalToNoC[43].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [43] = vLocalToNoC[43].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [43].payload_tuple_type.push_back      (payload_tuple_type      [43])    ;
                              local_noc_pkt_sent [43].payload_tuple_extd_value.push_back(payload_tuple_extd_value[43])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[43].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [43] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [43] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [43] = vLocalToNoC[43].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [43] = vLocalToNoC[43].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [43].payload_tuple_type.push_back      (payload_tuple_type      [43])    ;
                                  local_noc_pkt_sent [43].payload_tuple_extd_value.push_back(payload_tuple_extd_value[43])    ;
                                end
                            end
                          else if (vLocalToNoC[43].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [43] = vLocalToNoC[43].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [43].payload_data.push_back (payload_data      [43])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[43].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [43] = vLocalToNoC[43].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [43].payload_data.push_back (payload_data      [43])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[43].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[43].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [43].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 43, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [43]);
                                  local_noc_pkt_sent [43].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[43] = 1;    
                        end
                      @(vLocalToNoC[43].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 44
              @(vLocalToNoC[44].cb_p);
              if ((vLocalToNoC[44].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [44] = new();
                  noc_sent_packet_complete[44] = 0;    
                  while(~noc_sent_packet_complete[44])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 44);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[44].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[44].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [44].timeTag              = $time;
                          local_noc_pkt_sent [44].header_destination_address  = vLocalToNoC[44].locl__noc__dp_data     ;
                          local_noc_pkt_sent [44].header_source               = 44                                     ;
                          local_noc_pkt_sent [44].header_address_type         = vLocalToNoC[44].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [44].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[44].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[44].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [44] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [44] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [44] = vLocalToNoC[44].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [44] = vLocalToNoC[44].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [44].payload_tuple_type.push_back      (payload_tuple_type      [44])    ;
                              local_noc_pkt_sent [44].payload_tuple_extd_value.push_back(payload_tuple_extd_value[44])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[44].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [44] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [44] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [44] = vLocalToNoC[44].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [44] = vLocalToNoC[44].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [44].payload_tuple_type.push_back      (payload_tuple_type      [44])    ;
                                  local_noc_pkt_sent [44].payload_tuple_extd_value.push_back(payload_tuple_extd_value[44])    ;
                                end
                            end
                          else if (vLocalToNoC[44].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [44] = vLocalToNoC[44].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [44].payload_data.push_back (payload_data      [44])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[44].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [44] = vLocalToNoC[44].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [44].payload_data.push_back (payload_data      [44])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[44].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[44].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [44].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 44, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [44]);
                                  local_noc_pkt_sent [44].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[44] = 1;    
                        end
                      @(vLocalToNoC[44].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 45
              @(vLocalToNoC[45].cb_p);
              if ((vLocalToNoC[45].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [45] = new();
                  noc_sent_packet_complete[45] = 0;    
                  while(~noc_sent_packet_complete[45])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 45);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[45].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[45].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [45].timeTag              = $time;
                          local_noc_pkt_sent [45].header_destination_address  = vLocalToNoC[45].locl__noc__dp_data     ;
                          local_noc_pkt_sent [45].header_source               = 45                                     ;
                          local_noc_pkt_sent [45].header_address_type         = vLocalToNoC[45].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [45].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[45].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[45].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [45] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [45] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [45] = vLocalToNoC[45].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [45] = vLocalToNoC[45].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [45].payload_tuple_type.push_back      (payload_tuple_type      [45])    ;
                              local_noc_pkt_sent [45].payload_tuple_extd_value.push_back(payload_tuple_extd_value[45])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[45].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [45] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [45] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [45] = vLocalToNoC[45].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [45] = vLocalToNoC[45].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [45].payload_tuple_type.push_back      (payload_tuple_type      [45])    ;
                                  local_noc_pkt_sent [45].payload_tuple_extd_value.push_back(payload_tuple_extd_value[45])    ;
                                end
                            end
                          else if (vLocalToNoC[45].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [45] = vLocalToNoC[45].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [45].payload_data.push_back (payload_data      [45])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[45].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [45] = vLocalToNoC[45].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [45].payload_data.push_back (payload_data      [45])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[45].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[45].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [45].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 45, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [45]);
                                  local_noc_pkt_sent [45].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[45] = 1;    
                        end
                      @(vLocalToNoC[45].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 46
              @(vLocalToNoC[46].cb_p);
              if ((vLocalToNoC[46].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [46] = new();
                  noc_sent_packet_complete[46] = 0;    
                  while(~noc_sent_packet_complete[46])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 46);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[46].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[46].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [46].timeTag              = $time;
                          local_noc_pkt_sent [46].header_destination_address  = vLocalToNoC[46].locl__noc__dp_data     ;
                          local_noc_pkt_sent [46].header_source               = 46                                     ;
                          local_noc_pkt_sent [46].header_address_type         = vLocalToNoC[46].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [46].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[46].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[46].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [46] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [46] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [46] = vLocalToNoC[46].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [46] = vLocalToNoC[46].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [46].payload_tuple_type.push_back      (payload_tuple_type      [46])    ;
                              local_noc_pkt_sent [46].payload_tuple_extd_value.push_back(payload_tuple_extd_value[46])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[46].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [46] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [46] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [46] = vLocalToNoC[46].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [46] = vLocalToNoC[46].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [46].payload_tuple_type.push_back      (payload_tuple_type      [46])    ;
                                  local_noc_pkt_sent [46].payload_tuple_extd_value.push_back(payload_tuple_extd_value[46])    ;
                                end
                            end
                          else if (vLocalToNoC[46].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [46] = vLocalToNoC[46].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [46].payload_data.push_back (payload_data      [46])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[46].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [46] = vLocalToNoC[46].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [46].payload_data.push_back (payload_data      [46])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[46].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[46].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [46].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 46, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [46]);
                                  local_noc_pkt_sent [46].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[46] = 1;    
                        end
                      @(vLocalToNoC[46].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 47
              @(vLocalToNoC[47].cb_p);
              if ((vLocalToNoC[47].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [47] = new();
                  noc_sent_packet_complete[47] = 0;    
                  while(~noc_sent_packet_complete[47])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 47);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[47].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[47].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [47].timeTag              = $time;
                          local_noc_pkt_sent [47].header_destination_address  = vLocalToNoC[47].locl__noc__dp_data     ;
                          local_noc_pkt_sent [47].header_source               = 47                                     ;
                          local_noc_pkt_sent [47].header_address_type         = vLocalToNoC[47].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [47].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[47].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[47].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [47] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [47] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [47] = vLocalToNoC[47].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [47] = vLocalToNoC[47].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [47].payload_tuple_type.push_back      (payload_tuple_type      [47])    ;
                              local_noc_pkt_sent [47].payload_tuple_extd_value.push_back(payload_tuple_extd_value[47])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[47].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [47] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [47] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [47] = vLocalToNoC[47].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [47] = vLocalToNoC[47].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [47].payload_tuple_type.push_back      (payload_tuple_type      [47])    ;
                                  local_noc_pkt_sent [47].payload_tuple_extd_value.push_back(payload_tuple_extd_value[47])    ;
                                end
                            end
                          else if (vLocalToNoC[47].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [47] = vLocalToNoC[47].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [47].payload_data.push_back (payload_data      [47])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[47].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [47] = vLocalToNoC[47].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [47].payload_data.push_back (payload_data      [47])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[47].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[47].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [47].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 47, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [47]);
                                  local_noc_pkt_sent [47].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[47] = 1;    
                        end
                      @(vLocalToNoC[47].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 48
              @(vLocalToNoC[48].cb_p);
              if ((vLocalToNoC[48].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [48] = new();
                  noc_sent_packet_complete[48] = 0;    
                  while(~noc_sent_packet_complete[48])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 48);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[48].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[48].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [48].timeTag              = $time;
                          local_noc_pkt_sent [48].header_destination_address  = vLocalToNoC[48].locl__noc__dp_data     ;
                          local_noc_pkt_sent [48].header_source               = 48                                     ;
                          local_noc_pkt_sent [48].header_address_type         = vLocalToNoC[48].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [48].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[48].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[48].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [48] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [48] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [48] = vLocalToNoC[48].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [48] = vLocalToNoC[48].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [48].payload_tuple_type.push_back      (payload_tuple_type      [48])    ;
                              local_noc_pkt_sent [48].payload_tuple_extd_value.push_back(payload_tuple_extd_value[48])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[48].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [48] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [48] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [48] = vLocalToNoC[48].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [48] = vLocalToNoC[48].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [48].payload_tuple_type.push_back      (payload_tuple_type      [48])    ;
                                  local_noc_pkt_sent [48].payload_tuple_extd_value.push_back(payload_tuple_extd_value[48])    ;
                                end
                            end
                          else if (vLocalToNoC[48].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [48] = vLocalToNoC[48].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [48].payload_data.push_back (payload_data      [48])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[48].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [48] = vLocalToNoC[48].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [48].payload_data.push_back (payload_data      [48])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[48].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[48].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [48].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 48, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [48]);
                                  local_noc_pkt_sent [48].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[48] = 1;    
                        end
                      @(vLocalToNoC[48].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 49
              @(vLocalToNoC[49].cb_p);
              if ((vLocalToNoC[49].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [49] = new();
                  noc_sent_packet_complete[49] = 0;    
                  while(~noc_sent_packet_complete[49])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 49);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[49].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[49].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [49].timeTag              = $time;
                          local_noc_pkt_sent [49].header_destination_address  = vLocalToNoC[49].locl__noc__dp_data     ;
                          local_noc_pkt_sent [49].header_source               = 49                                     ;
                          local_noc_pkt_sent [49].header_address_type         = vLocalToNoC[49].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [49].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[49].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[49].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [49] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [49] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [49] = vLocalToNoC[49].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [49] = vLocalToNoC[49].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [49].payload_tuple_type.push_back      (payload_tuple_type      [49])    ;
                              local_noc_pkt_sent [49].payload_tuple_extd_value.push_back(payload_tuple_extd_value[49])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[49].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [49] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [49] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [49] = vLocalToNoC[49].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [49] = vLocalToNoC[49].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [49].payload_tuple_type.push_back      (payload_tuple_type      [49])    ;
                                  local_noc_pkt_sent [49].payload_tuple_extd_value.push_back(payload_tuple_extd_value[49])    ;
                                end
                            end
                          else if (vLocalToNoC[49].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [49] = vLocalToNoC[49].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [49].payload_data.push_back (payload_data      [49])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[49].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [49] = vLocalToNoC[49].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [49].payload_data.push_back (payload_data      [49])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[49].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[49].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [49].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 49, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [49]);
                                  local_noc_pkt_sent [49].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[49] = 1;    
                        end
                      @(vLocalToNoC[49].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 50
              @(vLocalToNoC[50].cb_p);
              if ((vLocalToNoC[50].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [50] = new();
                  noc_sent_packet_complete[50] = 0;    
                  while(~noc_sent_packet_complete[50])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 50);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[50].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[50].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [50].timeTag              = $time;
                          local_noc_pkt_sent [50].header_destination_address  = vLocalToNoC[50].locl__noc__dp_data     ;
                          local_noc_pkt_sent [50].header_source               = 50                                     ;
                          local_noc_pkt_sent [50].header_address_type         = vLocalToNoC[50].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [50].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[50].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[50].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [50] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [50] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [50] = vLocalToNoC[50].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [50] = vLocalToNoC[50].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [50].payload_tuple_type.push_back      (payload_tuple_type      [50])    ;
                              local_noc_pkt_sent [50].payload_tuple_extd_value.push_back(payload_tuple_extd_value[50])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[50].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [50] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [50] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [50] = vLocalToNoC[50].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [50] = vLocalToNoC[50].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [50].payload_tuple_type.push_back      (payload_tuple_type      [50])    ;
                                  local_noc_pkt_sent [50].payload_tuple_extd_value.push_back(payload_tuple_extd_value[50])    ;
                                end
                            end
                          else if (vLocalToNoC[50].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [50] = vLocalToNoC[50].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [50].payload_data.push_back (payload_data      [50])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[50].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [50] = vLocalToNoC[50].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [50].payload_data.push_back (payload_data      [50])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[50].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[50].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [50].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 50, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [50]);
                                  local_noc_pkt_sent [50].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[50] = 1;    
                        end
                      @(vLocalToNoC[50].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 51
              @(vLocalToNoC[51].cb_p);
              if ((vLocalToNoC[51].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [51] = new();
                  noc_sent_packet_complete[51] = 0;    
                  while(~noc_sent_packet_complete[51])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 51);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[51].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[51].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [51].timeTag              = $time;
                          local_noc_pkt_sent [51].header_destination_address  = vLocalToNoC[51].locl__noc__dp_data     ;
                          local_noc_pkt_sent [51].header_source               = 51                                     ;
                          local_noc_pkt_sent [51].header_address_type         = vLocalToNoC[51].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [51].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[51].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[51].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [51] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [51] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [51] = vLocalToNoC[51].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [51] = vLocalToNoC[51].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [51].payload_tuple_type.push_back      (payload_tuple_type      [51])    ;
                              local_noc_pkt_sent [51].payload_tuple_extd_value.push_back(payload_tuple_extd_value[51])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[51].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [51] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [51] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [51] = vLocalToNoC[51].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [51] = vLocalToNoC[51].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [51].payload_tuple_type.push_back      (payload_tuple_type      [51])    ;
                                  local_noc_pkt_sent [51].payload_tuple_extd_value.push_back(payload_tuple_extd_value[51])    ;
                                end
                            end
                          else if (vLocalToNoC[51].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [51] = vLocalToNoC[51].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [51].payload_data.push_back (payload_data      [51])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[51].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [51] = vLocalToNoC[51].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [51].payload_data.push_back (payload_data      [51])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[51].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[51].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [51].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 51, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [51]);
                                  local_noc_pkt_sent [51].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[51] = 1;    
                        end
                      @(vLocalToNoC[51].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 52
              @(vLocalToNoC[52].cb_p);
              if ((vLocalToNoC[52].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [52] = new();
                  noc_sent_packet_complete[52] = 0;    
                  while(~noc_sent_packet_complete[52])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 52);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[52].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[52].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [52].timeTag              = $time;
                          local_noc_pkt_sent [52].header_destination_address  = vLocalToNoC[52].locl__noc__dp_data     ;
                          local_noc_pkt_sent [52].header_source               = 52                                     ;
                          local_noc_pkt_sent [52].header_address_type         = vLocalToNoC[52].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [52].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[52].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[52].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [52] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [52] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [52] = vLocalToNoC[52].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [52] = vLocalToNoC[52].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [52].payload_tuple_type.push_back      (payload_tuple_type      [52])    ;
                              local_noc_pkt_sent [52].payload_tuple_extd_value.push_back(payload_tuple_extd_value[52])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[52].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [52] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [52] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [52] = vLocalToNoC[52].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [52] = vLocalToNoC[52].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [52].payload_tuple_type.push_back      (payload_tuple_type      [52])    ;
                                  local_noc_pkt_sent [52].payload_tuple_extd_value.push_back(payload_tuple_extd_value[52])    ;
                                end
                            end
                          else if (vLocalToNoC[52].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [52] = vLocalToNoC[52].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [52].payload_data.push_back (payload_data      [52])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[52].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [52] = vLocalToNoC[52].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [52].payload_data.push_back (payload_data      [52])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[52].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[52].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [52].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 52, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [52]);
                                  local_noc_pkt_sent [52].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[52] = 1;    
                        end
                      @(vLocalToNoC[52].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 53
              @(vLocalToNoC[53].cb_p);
              if ((vLocalToNoC[53].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [53] = new();
                  noc_sent_packet_complete[53] = 0;    
                  while(~noc_sent_packet_complete[53])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 53);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[53].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[53].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [53].timeTag              = $time;
                          local_noc_pkt_sent [53].header_destination_address  = vLocalToNoC[53].locl__noc__dp_data     ;
                          local_noc_pkt_sent [53].header_source               = 53                                     ;
                          local_noc_pkt_sent [53].header_address_type         = vLocalToNoC[53].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [53].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[53].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[53].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [53] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [53] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [53] = vLocalToNoC[53].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [53] = vLocalToNoC[53].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [53].payload_tuple_type.push_back      (payload_tuple_type      [53])    ;
                              local_noc_pkt_sent [53].payload_tuple_extd_value.push_back(payload_tuple_extd_value[53])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[53].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [53] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [53] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [53] = vLocalToNoC[53].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [53] = vLocalToNoC[53].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [53].payload_tuple_type.push_back      (payload_tuple_type      [53])    ;
                                  local_noc_pkt_sent [53].payload_tuple_extd_value.push_back(payload_tuple_extd_value[53])    ;
                                end
                            end
                          else if (vLocalToNoC[53].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [53] = vLocalToNoC[53].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [53].payload_data.push_back (payload_data      [53])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[53].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [53] = vLocalToNoC[53].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [53].payload_data.push_back (payload_data      [53])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[53].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[53].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [53].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 53, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [53]);
                                  local_noc_pkt_sent [53].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[53] = 1;    
                        end
                      @(vLocalToNoC[53].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 54
              @(vLocalToNoC[54].cb_p);
              if ((vLocalToNoC[54].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [54] = new();
                  noc_sent_packet_complete[54] = 0;    
                  while(~noc_sent_packet_complete[54])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 54);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[54].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[54].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [54].timeTag              = $time;
                          local_noc_pkt_sent [54].header_destination_address  = vLocalToNoC[54].locl__noc__dp_data     ;
                          local_noc_pkt_sent [54].header_source               = 54                                     ;
                          local_noc_pkt_sent [54].header_address_type         = vLocalToNoC[54].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [54].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[54].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[54].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [54] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [54] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [54] = vLocalToNoC[54].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [54] = vLocalToNoC[54].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [54].payload_tuple_type.push_back      (payload_tuple_type      [54])    ;
                              local_noc_pkt_sent [54].payload_tuple_extd_value.push_back(payload_tuple_extd_value[54])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[54].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [54] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [54] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [54] = vLocalToNoC[54].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [54] = vLocalToNoC[54].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [54].payload_tuple_type.push_back      (payload_tuple_type      [54])    ;
                                  local_noc_pkt_sent [54].payload_tuple_extd_value.push_back(payload_tuple_extd_value[54])    ;
                                end
                            end
                          else if (vLocalToNoC[54].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [54] = vLocalToNoC[54].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [54].payload_data.push_back (payload_data      [54])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[54].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [54] = vLocalToNoC[54].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [54].payload_data.push_back (payload_data      [54])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[54].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[54].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [54].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 54, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [54]);
                                  local_noc_pkt_sent [54].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[54] = 1;    
                        end
                      @(vLocalToNoC[54].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 55
              @(vLocalToNoC[55].cb_p);
              if ((vLocalToNoC[55].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [55] = new();
                  noc_sent_packet_complete[55] = 0;    
                  while(~noc_sent_packet_complete[55])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 55);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[55].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[55].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [55].timeTag              = $time;
                          local_noc_pkt_sent [55].header_destination_address  = vLocalToNoC[55].locl__noc__dp_data     ;
                          local_noc_pkt_sent [55].header_source               = 55                                     ;
                          local_noc_pkt_sent [55].header_address_type         = vLocalToNoC[55].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [55].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[55].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[55].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [55] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [55] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [55] = vLocalToNoC[55].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [55] = vLocalToNoC[55].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [55].payload_tuple_type.push_back      (payload_tuple_type      [55])    ;
                              local_noc_pkt_sent [55].payload_tuple_extd_value.push_back(payload_tuple_extd_value[55])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[55].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [55] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [55] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [55] = vLocalToNoC[55].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [55] = vLocalToNoC[55].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [55].payload_tuple_type.push_back      (payload_tuple_type      [55])    ;
                                  local_noc_pkt_sent [55].payload_tuple_extd_value.push_back(payload_tuple_extd_value[55])    ;
                                end
                            end
                          else if (vLocalToNoC[55].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [55] = vLocalToNoC[55].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [55].payload_data.push_back (payload_data      [55])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[55].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [55] = vLocalToNoC[55].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [55].payload_data.push_back (payload_data      [55])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[55].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[55].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [55].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 55, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [55]);
                                  local_noc_pkt_sent [55].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[55] = 1;    
                        end
                      @(vLocalToNoC[55].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 56
              @(vLocalToNoC[56].cb_p);
              if ((vLocalToNoC[56].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [56] = new();
                  noc_sent_packet_complete[56] = 0;    
                  while(~noc_sent_packet_complete[56])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 56);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[56].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[56].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [56].timeTag              = $time;
                          local_noc_pkt_sent [56].header_destination_address  = vLocalToNoC[56].locl__noc__dp_data     ;
                          local_noc_pkt_sent [56].header_source               = 56                                     ;
                          local_noc_pkt_sent [56].header_address_type         = vLocalToNoC[56].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [56].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[56].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[56].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [56] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [56] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [56] = vLocalToNoC[56].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [56] = vLocalToNoC[56].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [56].payload_tuple_type.push_back      (payload_tuple_type      [56])    ;
                              local_noc_pkt_sent [56].payload_tuple_extd_value.push_back(payload_tuple_extd_value[56])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[56].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [56] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [56] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [56] = vLocalToNoC[56].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [56] = vLocalToNoC[56].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [56].payload_tuple_type.push_back      (payload_tuple_type      [56])    ;
                                  local_noc_pkt_sent [56].payload_tuple_extd_value.push_back(payload_tuple_extd_value[56])    ;
                                end
                            end
                          else if (vLocalToNoC[56].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [56] = vLocalToNoC[56].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [56].payload_data.push_back (payload_data      [56])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[56].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [56] = vLocalToNoC[56].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [56].payload_data.push_back (payload_data      [56])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[56].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[56].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [56].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 56, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [56]);
                                  local_noc_pkt_sent [56].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[56] = 1;    
                        end
                      @(vLocalToNoC[56].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 57
              @(vLocalToNoC[57].cb_p);
              if ((vLocalToNoC[57].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [57] = new();
                  noc_sent_packet_complete[57] = 0;    
                  while(~noc_sent_packet_complete[57])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 57);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[57].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[57].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [57].timeTag              = $time;
                          local_noc_pkt_sent [57].header_destination_address  = vLocalToNoC[57].locl__noc__dp_data     ;
                          local_noc_pkt_sent [57].header_source               = 57                                     ;
                          local_noc_pkt_sent [57].header_address_type         = vLocalToNoC[57].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [57].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[57].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[57].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [57] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [57] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [57] = vLocalToNoC[57].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [57] = vLocalToNoC[57].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [57].payload_tuple_type.push_back      (payload_tuple_type      [57])    ;
                              local_noc_pkt_sent [57].payload_tuple_extd_value.push_back(payload_tuple_extd_value[57])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[57].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [57] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [57] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [57] = vLocalToNoC[57].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [57] = vLocalToNoC[57].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [57].payload_tuple_type.push_back      (payload_tuple_type      [57])    ;
                                  local_noc_pkt_sent [57].payload_tuple_extd_value.push_back(payload_tuple_extd_value[57])    ;
                                end
                            end
                          else if (vLocalToNoC[57].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [57] = vLocalToNoC[57].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [57].payload_data.push_back (payload_data      [57])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[57].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [57] = vLocalToNoC[57].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [57].payload_data.push_back (payload_data      [57])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[57].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[57].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [57].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 57, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [57]);
                                  local_noc_pkt_sent [57].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[57] = 1;    
                        end
                      @(vLocalToNoC[57].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 58
              @(vLocalToNoC[58].cb_p);
              if ((vLocalToNoC[58].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [58] = new();
                  noc_sent_packet_complete[58] = 0;    
                  while(~noc_sent_packet_complete[58])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 58);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[58].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[58].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [58].timeTag              = $time;
                          local_noc_pkt_sent [58].header_destination_address  = vLocalToNoC[58].locl__noc__dp_data     ;
                          local_noc_pkt_sent [58].header_source               = 58                                     ;
                          local_noc_pkt_sent [58].header_address_type         = vLocalToNoC[58].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [58].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[58].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[58].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [58] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [58] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [58] = vLocalToNoC[58].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [58] = vLocalToNoC[58].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [58].payload_tuple_type.push_back      (payload_tuple_type      [58])    ;
                              local_noc_pkt_sent [58].payload_tuple_extd_value.push_back(payload_tuple_extd_value[58])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[58].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [58] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [58] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [58] = vLocalToNoC[58].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [58] = vLocalToNoC[58].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [58].payload_tuple_type.push_back      (payload_tuple_type      [58])    ;
                                  local_noc_pkt_sent [58].payload_tuple_extd_value.push_back(payload_tuple_extd_value[58])    ;
                                end
                            end
                          else if (vLocalToNoC[58].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [58] = vLocalToNoC[58].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [58].payload_data.push_back (payload_data      [58])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[58].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [58] = vLocalToNoC[58].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [58].payload_data.push_back (payload_data      [58])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[58].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[58].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [58].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 58, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [58]);
                                  local_noc_pkt_sent [58].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[58] = 1;    
                        end
                      @(vLocalToNoC[58].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 59
              @(vLocalToNoC[59].cb_p);
              if ((vLocalToNoC[59].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [59] = new();
                  noc_sent_packet_complete[59] = 0;    
                  while(~noc_sent_packet_complete[59])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 59);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[59].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[59].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [59].timeTag              = $time;
                          local_noc_pkt_sent [59].header_destination_address  = vLocalToNoC[59].locl__noc__dp_data     ;
                          local_noc_pkt_sent [59].header_source               = 59                                     ;
                          local_noc_pkt_sent [59].header_address_type         = vLocalToNoC[59].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [59].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[59].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[59].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [59] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [59] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [59] = vLocalToNoC[59].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [59] = vLocalToNoC[59].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [59].payload_tuple_type.push_back      (payload_tuple_type      [59])    ;
                              local_noc_pkt_sent [59].payload_tuple_extd_value.push_back(payload_tuple_extd_value[59])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[59].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [59] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [59] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [59] = vLocalToNoC[59].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [59] = vLocalToNoC[59].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [59].payload_tuple_type.push_back      (payload_tuple_type      [59])    ;
                                  local_noc_pkt_sent [59].payload_tuple_extd_value.push_back(payload_tuple_extd_value[59])    ;
                                end
                            end
                          else if (vLocalToNoC[59].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [59] = vLocalToNoC[59].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [59].payload_data.push_back (payload_data      [59])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[59].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [59] = vLocalToNoC[59].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [59].payload_data.push_back (payload_data      [59])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[59].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[59].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [59].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 59, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [59]);
                                  local_noc_pkt_sent [59].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[59] = 1;    
                        end
                      @(vLocalToNoC[59].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 60
              @(vLocalToNoC[60].cb_p);
              if ((vLocalToNoC[60].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [60] = new();
                  noc_sent_packet_complete[60] = 0;    
                  while(~noc_sent_packet_complete[60])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 60);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[60].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[60].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [60].timeTag              = $time;
                          local_noc_pkt_sent [60].header_destination_address  = vLocalToNoC[60].locl__noc__dp_data     ;
                          local_noc_pkt_sent [60].header_source               = 60                                     ;
                          local_noc_pkt_sent [60].header_address_type         = vLocalToNoC[60].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [60].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[60].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[60].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [60] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [60] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [60] = vLocalToNoC[60].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [60] = vLocalToNoC[60].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [60].payload_tuple_type.push_back      (payload_tuple_type      [60])    ;
                              local_noc_pkt_sent [60].payload_tuple_extd_value.push_back(payload_tuple_extd_value[60])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[60].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [60] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [60] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [60] = vLocalToNoC[60].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [60] = vLocalToNoC[60].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [60].payload_tuple_type.push_back      (payload_tuple_type      [60])    ;
                                  local_noc_pkt_sent [60].payload_tuple_extd_value.push_back(payload_tuple_extd_value[60])    ;
                                end
                            end
                          else if (vLocalToNoC[60].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [60] = vLocalToNoC[60].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [60].payload_data.push_back (payload_data      [60])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[60].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [60] = vLocalToNoC[60].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [60].payload_data.push_back (payload_data      [60])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[60].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[60].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [60].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 60, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [60]);
                                  local_noc_pkt_sent [60].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[60] = 1;    
                        end
                      @(vLocalToNoC[60].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 61
              @(vLocalToNoC[61].cb_p);
              if ((vLocalToNoC[61].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [61] = new();
                  noc_sent_packet_complete[61] = 0;    
                  while(~noc_sent_packet_complete[61])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 61);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[61].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[61].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [61].timeTag              = $time;
                          local_noc_pkt_sent [61].header_destination_address  = vLocalToNoC[61].locl__noc__dp_data     ;
                          local_noc_pkt_sent [61].header_source               = 61                                     ;
                          local_noc_pkt_sent [61].header_address_type         = vLocalToNoC[61].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [61].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[61].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[61].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [61] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [61] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [61] = vLocalToNoC[61].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [61] = vLocalToNoC[61].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [61].payload_tuple_type.push_back      (payload_tuple_type      [61])    ;
                              local_noc_pkt_sent [61].payload_tuple_extd_value.push_back(payload_tuple_extd_value[61])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[61].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [61] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [61] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [61] = vLocalToNoC[61].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [61] = vLocalToNoC[61].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [61].payload_tuple_type.push_back      (payload_tuple_type      [61])    ;
                                  local_noc_pkt_sent [61].payload_tuple_extd_value.push_back(payload_tuple_extd_value[61])    ;
                                end
                            end
                          else if (vLocalToNoC[61].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [61] = vLocalToNoC[61].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [61].payload_data.push_back (payload_data      [61])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[61].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [61] = vLocalToNoC[61].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [61].payload_data.push_back (payload_data      [61])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[61].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[61].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [61].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 61, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [61]);
                                  local_noc_pkt_sent [61].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[61] = 1;    
                        end
                      @(vLocalToNoC[61].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 62
              @(vLocalToNoC[62].cb_p);
              if ((vLocalToNoC[62].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [62] = new();
                  noc_sent_packet_complete[62] = 0;    
                  while(~noc_sent_packet_complete[62])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 62);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[62].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[62].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [62].timeTag              = $time;
                          local_noc_pkt_sent [62].header_destination_address  = vLocalToNoC[62].locl__noc__dp_data     ;
                          local_noc_pkt_sent [62].header_source               = 62                                     ;
                          local_noc_pkt_sent [62].header_address_type         = vLocalToNoC[62].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [62].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[62].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[62].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [62] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [62] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [62] = vLocalToNoC[62].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [62] = vLocalToNoC[62].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [62].payload_tuple_type.push_back      (payload_tuple_type      [62])    ;
                              local_noc_pkt_sent [62].payload_tuple_extd_value.push_back(payload_tuple_extd_value[62])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[62].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [62] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [62] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [62] = vLocalToNoC[62].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [62] = vLocalToNoC[62].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [62].payload_tuple_type.push_back      (payload_tuple_type      [62])    ;
                                  local_noc_pkt_sent [62].payload_tuple_extd_value.push_back(payload_tuple_extd_value[62])    ;
                                end
                            end
                          else if (vLocalToNoC[62].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [62] = vLocalToNoC[62].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [62].payload_data.push_back (payload_data      [62])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[62].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [62] = vLocalToNoC[62].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [62].payload_data.push_back (payload_data      [62])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[62].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[62].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [62].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 62, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [62]);
                                  local_noc_pkt_sent [62].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[62] = 1;    
                        end
                      @(vLocalToNoC[62].cb_p);
                    end  // while
                end
            end
        end
    
        begin
          forever
            begin
              // Observe NoC packets sent from manager 63
              @(vLocalToNoC[63].cb_p);
              if ((vLocalToNoC[63].locl__noc__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_sent [63] = new();
                  noc_sent_packet_complete[63] = 0;    
                  while(~noc_sent_packet_complete[63])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 63);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalToNoC[63].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[63].locl__noc__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_sent [63].timeTag              = $time;
                          local_noc_pkt_sent [63].header_destination_address  = vLocalToNoC[63].locl__noc__dp_data     ;
                          local_noc_pkt_sent [63].header_source               = 63                                     ;
                          local_noc_pkt_sent [63].header_address_type         = vLocalToNoC[63].locl__noc__dp_desttype ;
                          local_noc_pkt_sent [63].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalToNoC[63].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[63].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [63] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [63] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [63] = vLocalToNoC[63].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [63] = vLocalToNoC[63].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_sent [63].payload_tuple_type.push_back      (payload_tuple_type      [63])    ;
                              local_noc_pkt_sent [63].payload_tuple_extd_value.push_back(payload_tuple_extd_value[63])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[63].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [63] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [63] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [63] = vLocalToNoC[63].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [63] = vLocalToNoC[63].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_sent [63].payload_tuple_type.push_back      (payload_tuple_type      [63])    ;
                                  local_noc_pkt_sent [63].payload_tuple_extd_value.push_back(payload_tuple_extd_value[63])    ;
                                end
                            end
                          else if (vLocalToNoC[63].locl__noc__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [63] = vLocalToNoC[63].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_sent [63].payload_data.push_back (payload_data      [63])    ;
                              // check if both tuples are valid
                              if (vLocalToNoC[63].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [63] = vLocalToNoC[63].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_sent [63].payload_data.push_back (payload_data      [63])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalToNoC[63].locl__noc__dp_valid == 1'b1) && (vLocalToNoC[63].locl__noc__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now determine all destination and place packet in their mailbox
                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) 
                            begin
                              if (local_noc_pkt_sent [63].header_destination_address[dm] == 1'b1)
                                begin
                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {%0d} to {%0d}", $time, `__FILE__, `__LINE__, 63, dm);
                                  mgr2noc_p [dm].put(local_noc_pkt_sent [63]);
                                  local_noc_pkt_sent [63].displayPacket;
                                end
                            end
                          noc_sent_packet_complete[63] = 1;    
                        end
                      @(vLocalToNoC[63].cb_p);
                    end  // while
                end
            end
        end
    