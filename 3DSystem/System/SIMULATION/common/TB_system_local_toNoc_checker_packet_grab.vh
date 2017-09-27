
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
    