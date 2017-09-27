
        begin
          forever
            begin
              // Observe NoC packets received by manager 0
              @(vLocalFromNoC[0].cb_p);
              if ((vLocalFromNoC[0].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [0] = new();
                  noc_rcvd_packet_complete[0] = 0;    
                  while(~noc_rcvd_packet_complete[0])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 0);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[0].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[0].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [0].timeTag                     = $time;
                          local_noc_pkt_rcvd [0].header_destination_address  = vLocalFromNoC[0].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [0].header_source               = vLocalFromNoC[0].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [0].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[0].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[0].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [0] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [0] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [0] = vLocalFromNoC[0].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [0] = vLocalFromNoC[0].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [0].payload_tuple_type.push_back      (payload_tuple_type      [0])    ;
                              local_noc_pkt_rcvd [0].payload_tuple_extd_value.push_back(payload_tuple_extd_value[0])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[0].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [0] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [0] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [0] = vLocalFromNoC[0].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [0] = vLocalFromNoC[0].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [0].payload_tuple_type.push_back      (payload_tuple_type      [0])    ;
                                  local_noc_pkt_rcvd [0].payload_tuple_extd_value.push_back(payload_tuple_extd_value[0])    ;
                                end
                            end
                          else if (vLocalFromNoC[0].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [0] = vLocalFromNoC[0].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [0].payload_data.push_back (payload_data      [0])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[0].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [0] = vLocalFromNoC[0].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [0].payload_data.push_back (payload_data      [0])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[0].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[0].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 0, local_noc_pkt_rcvd [0].header_source);
                          noc2mgr_p [0].put(local_noc_pkt_rcvd [0]);
                          local_noc_pkt_rcvd [0].displayPacket;
                          noc_rcvd_packet_complete[0] = 1;    
                        end
                      @(vLocalFromNoC[0].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 1
              @(vLocalFromNoC[1].cb_p);
              if ((vLocalFromNoC[1].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [1] = new();
                  noc_rcvd_packet_complete[1] = 0;    
                  while(~noc_rcvd_packet_complete[1])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 1);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[1].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[1].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [1].timeTag                     = $time;
                          local_noc_pkt_rcvd [1].header_destination_address  = vLocalFromNoC[1].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [1].header_source               = vLocalFromNoC[1].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [1].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[1].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[1].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [1] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [1] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [1] = vLocalFromNoC[1].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [1] = vLocalFromNoC[1].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [1].payload_tuple_type.push_back      (payload_tuple_type      [1])    ;
                              local_noc_pkt_rcvd [1].payload_tuple_extd_value.push_back(payload_tuple_extd_value[1])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[1].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [1] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [1] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [1] = vLocalFromNoC[1].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [1] = vLocalFromNoC[1].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [1].payload_tuple_type.push_back      (payload_tuple_type      [1])    ;
                                  local_noc_pkt_rcvd [1].payload_tuple_extd_value.push_back(payload_tuple_extd_value[1])    ;
                                end
                            end
                          else if (vLocalFromNoC[1].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [1] = vLocalFromNoC[1].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [1].payload_data.push_back (payload_data      [1])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[1].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [1] = vLocalFromNoC[1].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [1].payload_data.push_back (payload_data      [1])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[1].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[1].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 1, local_noc_pkt_rcvd [1].header_source);
                          noc2mgr_p [1].put(local_noc_pkt_rcvd [1]);
                          local_noc_pkt_rcvd [1].displayPacket;
                          noc_rcvd_packet_complete[1] = 1;    
                        end
                      @(vLocalFromNoC[1].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 2
              @(vLocalFromNoC[2].cb_p);
              if ((vLocalFromNoC[2].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [2] = new();
                  noc_rcvd_packet_complete[2] = 0;    
                  while(~noc_rcvd_packet_complete[2])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 2);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[2].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[2].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [2].timeTag                     = $time;
                          local_noc_pkt_rcvd [2].header_destination_address  = vLocalFromNoC[2].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [2].header_source               = vLocalFromNoC[2].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [2].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[2].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[2].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [2] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [2] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [2] = vLocalFromNoC[2].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [2] = vLocalFromNoC[2].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [2].payload_tuple_type.push_back      (payload_tuple_type      [2])    ;
                              local_noc_pkt_rcvd [2].payload_tuple_extd_value.push_back(payload_tuple_extd_value[2])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[2].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [2] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [2] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [2] = vLocalFromNoC[2].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [2] = vLocalFromNoC[2].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [2].payload_tuple_type.push_back      (payload_tuple_type      [2])    ;
                                  local_noc_pkt_rcvd [2].payload_tuple_extd_value.push_back(payload_tuple_extd_value[2])    ;
                                end
                            end
                          else if (vLocalFromNoC[2].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [2] = vLocalFromNoC[2].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [2].payload_data.push_back (payload_data      [2])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[2].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [2] = vLocalFromNoC[2].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [2].payload_data.push_back (payload_data      [2])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[2].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[2].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 2, local_noc_pkt_rcvd [2].header_source);
                          noc2mgr_p [2].put(local_noc_pkt_rcvd [2]);
                          local_noc_pkt_rcvd [2].displayPacket;
                          noc_rcvd_packet_complete[2] = 1;    
                        end
                      @(vLocalFromNoC[2].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 3
              @(vLocalFromNoC[3].cb_p);
              if ((vLocalFromNoC[3].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [3] = new();
                  noc_rcvd_packet_complete[3] = 0;    
                  while(~noc_rcvd_packet_complete[3])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 3);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[3].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[3].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [3].timeTag                     = $time;
                          local_noc_pkt_rcvd [3].header_destination_address  = vLocalFromNoC[3].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [3].header_source               = vLocalFromNoC[3].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [3].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[3].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[3].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [3] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [3] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [3] = vLocalFromNoC[3].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [3] = vLocalFromNoC[3].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [3].payload_tuple_type.push_back      (payload_tuple_type      [3])    ;
                              local_noc_pkt_rcvd [3].payload_tuple_extd_value.push_back(payload_tuple_extd_value[3])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[3].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [3] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [3] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [3] = vLocalFromNoC[3].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [3] = vLocalFromNoC[3].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [3].payload_tuple_type.push_back      (payload_tuple_type      [3])    ;
                                  local_noc_pkt_rcvd [3].payload_tuple_extd_value.push_back(payload_tuple_extd_value[3])    ;
                                end
                            end
                          else if (vLocalFromNoC[3].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [3] = vLocalFromNoC[3].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [3].payload_data.push_back (payload_data      [3])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[3].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [3] = vLocalFromNoC[3].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [3].payload_data.push_back (payload_data      [3])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[3].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[3].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 3, local_noc_pkt_rcvd [3].header_source);
                          noc2mgr_p [3].put(local_noc_pkt_rcvd [3]);
                          local_noc_pkt_rcvd [3].displayPacket;
                          noc_rcvd_packet_complete[3] = 1;    
                        end
                      @(vLocalFromNoC[3].cb_p);
                    end  // while
                end
            end // forever
        end
    