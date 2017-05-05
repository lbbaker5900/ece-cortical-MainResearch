
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
                          noc_rcvd_packet_complete[3] = 1;    
                        end
                      @(vLocalFromNoC[3].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 4
              @(vLocalFromNoC[4].cb_p);
              if ((vLocalFromNoC[4].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [4] = new();
                  noc_rcvd_packet_complete[4] = 0;    
                  while(~noc_rcvd_packet_complete[4])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 4);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[4].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[4].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [4].timeTag                     = $time;
                          local_noc_pkt_rcvd [4].header_destination_address  = vLocalFromNoC[4].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [4].header_source               = vLocalFromNoC[4].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [4].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[4].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[4].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [4] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [4] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [4] = vLocalFromNoC[4].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [4] = vLocalFromNoC[4].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [4].payload_tuple_type.push_back      (payload_tuple_type      [4])    ;
                              local_noc_pkt_rcvd [4].payload_tuple_extd_value.push_back(payload_tuple_extd_value[4])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[4].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [4] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [4] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [4] = vLocalFromNoC[4].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [4] = vLocalFromNoC[4].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [4].payload_tuple_type.push_back      (payload_tuple_type      [4])    ;
                                  local_noc_pkt_rcvd [4].payload_tuple_extd_value.push_back(payload_tuple_extd_value[4])    ;
                                end
                            end
                          else if (vLocalFromNoC[4].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [4] = vLocalFromNoC[4].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [4].payload_data.push_back (payload_data      [4])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[4].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [4] = vLocalFromNoC[4].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [4].payload_data.push_back (payload_data      [4])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[4].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[4].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 4, local_noc_pkt_rcvd [4].header_source);
                          noc2mgr_p [4].put(local_noc_pkt_rcvd [4]);
                          noc_rcvd_packet_complete[4] = 1;    
                        end
                      @(vLocalFromNoC[4].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 5
              @(vLocalFromNoC[5].cb_p);
              if ((vLocalFromNoC[5].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [5] = new();
                  noc_rcvd_packet_complete[5] = 0;    
                  while(~noc_rcvd_packet_complete[5])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 5);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[5].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[5].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [5].timeTag                     = $time;
                          local_noc_pkt_rcvd [5].header_destination_address  = vLocalFromNoC[5].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [5].header_source               = vLocalFromNoC[5].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [5].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[5].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[5].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [5] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [5] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [5] = vLocalFromNoC[5].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [5] = vLocalFromNoC[5].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [5].payload_tuple_type.push_back      (payload_tuple_type      [5])    ;
                              local_noc_pkt_rcvd [5].payload_tuple_extd_value.push_back(payload_tuple_extd_value[5])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[5].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [5] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [5] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [5] = vLocalFromNoC[5].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [5] = vLocalFromNoC[5].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [5].payload_tuple_type.push_back      (payload_tuple_type      [5])    ;
                                  local_noc_pkt_rcvd [5].payload_tuple_extd_value.push_back(payload_tuple_extd_value[5])    ;
                                end
                            end
                          else if (vLocalFromNoC[5].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [5] = vLocalFromNoC[5].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [5].payload_data.push_back (payload_data      [5])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[5].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [5] = vLocalFromNoC[5].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [5].payload_data.push_back (payload_data      [5])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[5].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[5].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 5, local_noc_pkt_rcvd [5].header_source);
                          noc2mgr_p [5].put(local_noc_pkt_rcvd [5]);
                          noc_rcvd_packet_complete[5] = 1;    
                        end
                      @(vLocalFromNoC[5].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 6
              @(vLocalFromNoC[6].cb_p);
              if ((vLocalFromNoC[6].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [6] = new();
                  noc_rcvd_packet_complete[6] = 0;    
                  while(~noc_rcvd_packet_complete[6])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 6);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[6].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[6].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [6].timeTag                     = $time;
                          local_noc_pkt_rcvd [6].header_destination_address  = vLocalFromNoC[6].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [6].header_source               = vLocalFromNoC[6].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [6].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[6].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[6].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [6] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [6] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [6] = vLocalFromNoC[6].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [6] = vLocalFromNoC[6].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [6].payload_tuple_type.push_back      (payload_tuple_type      [6])    ;
                              local_noc_pkt_rcvd [6].payload_tuple_extd_value.push_back(payload_tuple_extd_value[6])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[6].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [6] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [6] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [6] = vLocalFromNoC[6].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [6] = vLocalFromNoC[6].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [6].payload_tuple_type.push_back      (payload_tuple_type      [6])    ;
                                  local_noc_pkt_rcvd [6].payload_tuple_extd_value.push_back(payload_tuple_extd_value[6])    ;
                                end
                            end
                          else if (vLocalFromNoC[6].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [6] = vLocalFromNoC[6].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [6].payload_data.push_back (payload_data      [6])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[6].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [6] = vLocalFromNoC[6].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [6].payload_data.push_back (payload_data      [6])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[6].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[6].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 6, local_noc_pkt_rcvd [6].header_source);
                          noc2mgr_p [6].put(local_noc_pkt_rcvd [6]);
                          noc_rcvd_packet_complete[6] = 1;    
                        end
                      @(vLocalFromNoC[6].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 7
              @(vLocalFromNoC[7].cb_p);
              if ((vLocalFromNoC[7].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [7] = new();
                  noc_rcvd_packet_complete[7] = 0;    
                  while(~noc_rcvd_packet_complete[7])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 7);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[7].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[7].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [7].timeTag                     = $time;
                          local_noc_pkt_rcvd [7].header_destination_address  = vLocalFromNoC[7].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [7].header_source               = vLocalFromNoC[7].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [7].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[7].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[7].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [7] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [7] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [7] = vLocalFromNoC[7].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [7] = vLocalFromNoC[7].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [7].payload_tuple_type.push_back      (payload_tuple_type      [7])    ;
                              local_noc_pkt_rcvd [7].payload_tuple_extd_value.push_back(payload_tuple_extd_value[7])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[7].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [7] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [7] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [7] = vLocalFromNoC[7].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [7] = vLocalFromNoC[7].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [7].payload_tuple_type.push_back      (payload_tuple_type      [7])    ;
                                  local_noc_pkt_rcvd [7].payload_tuple_extd_value.push_back(payload_tuple_extd_value[7])    ;
                                end
                            end
                          else if (vLocalFromNoC[7].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [7] = vLocalFromNoC[7].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [7].payload_data.push_back (payload_data      [7])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[7].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [7] = vLocalFromNoC[7].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [7].payload_data.push_back (payload_data      [7])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[7].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[7].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 7, local_noc_pkt_rcvd [7].header_source);
                          noc2mgr_p [7].put(local_noc_pkt_rcvd [7]);
                          noc_rcvd_packet_complete[7] = 1;    
                        end
                      @(vLocalFromNoC[7].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 8
              @(vLocalFromNoC[8].cb_p);
              if ((vLocalFromNoC[8].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [8] = new();
                  noc_rcvd_packet_complete[8] = 0;    
                  while(~noc_rcvd_packet_complete[8])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 8);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[8].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[8].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [8].timeTag                     = $time;
                          local_noc_pkt_rcvd [8].header_destination_address  = vLocalFromNoC[8].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [8].header_source               = vLocalFromNoC[8].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [8].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[8].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[8].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [8] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [8] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [8] = vLocalFromNoC[8].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [8] = vLocalFromNoC[8].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [8].payload_tuple_type.push_back      (payload_tuple_type      [8])    ;
                              local_noc_pkt_rcvd [8].payload_tuple_extd_value.push_back(payload_tuple_extd_value[8])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[8].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [8] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [8] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [8] = vLocalFromNoC[8].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [8] = vLocalFromNoC[8].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [8].payload_tuple_type.push_back      (payload_tuple_type      [8])    ;
                                  local_noc_pkt_rcvd [8].payload_tuple_extd_value.push_back(payload_tuple_extd_value[8])    ;
                                end
                            end
                          else if (vLocalFromNoC[8].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [8] = vLocalFromNoC[8].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [8].payload_data.push_back (payload_data      [8])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[8].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [8] = vLocalFromNoC[8].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [8].payload_data.push_back (payload_data      [8])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[8].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[8].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 8, local_noc_pkt_rcvd [8].header_source);
                          noc2mgr_p [8].put(local_noc_pkt_rcvd [8]);
                          noc_rcvd_packet_complete[8] = 1;    
                        end
                      @(vLocalFromNoC[8].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 9
              @(vLocalFromNoC[9].cb_p);
              if ((vLocalFromNoC[9].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [9] = new();
                  noc_rcvd_packet_complete[9] = 0;    
                  while(~noc_rcvd_packet_complete[9])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 9);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[9].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[9].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [9].timeTag                     = $time;
                          local_noc_pkt_rcvd [9].header_destination_address  = vLocalFromNoC[9].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [9].header_source               = vLocalFromNoC[9].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [9].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[9].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[9].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [9] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [9] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [9] = vLocalFromNoC[9].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [9] = vLocalFromNoC[9].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [9].payload_tuple_type.push_back      (payload_tuple_type      [9])    ;
                              local_noc_pkt_rcvd [9].payload_tuple_extd_value.push_back(payload_tuple_extd_value[9])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[9].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [9] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [9] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [9] = vLocalFromNoC[9].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [9] = vLocalFromNoC[9].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [9].payload_tuple_type.push_back      (payload_tuple_type      [9])    ;
                                  local_noc_pkt_rcvd [9].payload_tuple_extd_value.push_back(payload_tuple_extd_value[9])    ;
                                end
                            end
                          else if (vLocalFromNoC[9].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [9] = vLocalFromNoC[9].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [9].payload_data.push_back (payload_data      [9])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[9].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [9] = vLocalFromNoC[9].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [9].payload_data.push_back (payload_data      [9])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[9].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[9].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 9, local_noc_pkt_rcvd [9].header_source);
                          noc2mgr_p [9].put(local_noc_pkt_rcvd [9]);
                          noc_rcvd_packet_complete[9] = 1;    
                        end
                      @(vLocalFromNoC[9].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 10
              @(vLocalFromNoC[10].cb_p);
              if ((vLocalFromNoC[10].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [10] = new();
                  noc_rcvd_packet_complete[10] = 0;    
                  while(~noc_rcvd_packet_complete[10])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 10);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[10].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[10].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [10].timeTag                     = $time;
                          local_noc_pkt_rcvd [10].header_destination_address  = vLocalFromNoC[10].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [10].header_source               = vLocalFromNoC[10].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [10].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[10].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[10].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [10] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [10] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [10] = vLocalFromNoC[10].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [10] = vLocalFromNoC[10].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [10].payload_tuple_type.push_back      (payload_tuple_type      [10])    ;
                              local_noc_pkt_rcvd [10].payload_tuple_extd_value.push_back(payload_tuple_extd_value[10])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[10].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [10] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [10] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [10] = vLocalFromNoC[10].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [10] = vLocalFromNoC[10].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [10].payload_tuple_type.push_back      (payload_tuple_type      [10])    ;
                                  local_noc_pkt_rcvd [10].payload_tuple_extd_value.push_back(payload_tuple_extd_value[10])    ;
                                end
                            end
                          else if (vLocalFromNoC[10].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [10] = vLocalFromNoC[10].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [10].payload_data.push_back (payload_data      [10])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[10].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [10] = vLocalFromNoC[10].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [10].payload_data.push_back (payload_data      [10])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[10].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[10].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 10, local_noc_pkt_rcvd [10].header_source);
                          noc2mgr_p [10].put(local_noc_pkt_rcvd [10]);
                          noc_rcvd_packet_complete[10] = 1;    
                        end
                      @(vLocalFromNoC[10].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 11
              @(vLocalFromNoC[11].cb_p);
              if ((vLocalFromNoC[11].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [11] = new();
                  noc_rcvd_packet_complete[11] = 0;    
                  while(~noc_rcvd_packet_complete[11])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 11);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[11].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[11].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [11].timeTag                     = $time;
                          local_noc_pkt_rcvd [11].header_destination_address  = vLocalFromNoC[11].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [11].header_source               = vLocalFromNoC[11].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [11].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[11].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[11].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [11] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [11] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [11] = vLocalFromNoC[11].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [11] = vLocalFromNoC[11].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [11].payload_tuple_type.push_back      (payload_tuple_type      [11])    ;
                              local_noc_pkt_rcvd [11].payload_tuple_extd_value.push_back(payload_tuple_extd_value[11])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[11].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [11] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [11] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [11] = vLocalFromNoC[11].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [11] = vLocalFromNoC[11].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [11].payload_tuple_type.push_back      (payload_tuple_type      [11])    ;
                                  local_noc_pkt_rcvd [11].payload_tuple_extd_value.push_back(payload_tuple_extd_value[11])    ;
                                end
                            end
                          else if (vLocalFromNoC[11].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [11] = vLocalFromNoC[11].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [11].payload_data.push_back (payload_data      [11])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[11].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [11] = vLocalFromNoC[11].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [11].payload_data.push_back (payload_data      [11])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[11].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[11].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 11, local_noc_pkt_rcvd [11].header_source);
                          noc2mgr_p [11].put(local_noc_pkt_rcvd [11]);
                          noc_rcvd_packet_complete[11] = 1;    
                        end
                      @(vLocalFromNoC[11].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 12
              @(vLocalFromNoC[12].cb_p);
              if ((vLocalFromNoC[12].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [12] = new();
                  noc_rcvd_packet_complete[12] = 0;    
                  while(~noc_rcvd_packet_complete[12])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 12);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[12].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[12].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [12].timeTag                     = $time;
                          local_noc_pkt_rcvd [12].header_destination_address  = vLocalFromNoC[12].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [12].header_source               = vLocalFromNoC[12].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [12].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[12].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[12].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [12] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [12] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [12] = vLocalFromNoC[12].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [12] = vLocalFromNoC[12].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [12].payload_tuple_type.push_back      (payload_tuple_type      [12])    ;
                              local_noc_pkt_rcvd [12].payload_tuple_extd_value.push_back(payload_tuple_extd_value[12])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[12].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [12] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [12] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [12] = vLocalFromNoC[12].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [12] = vLocalFromNoC[12].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [12].payload_tuple_type.push_back      (payload_tuple_type      [12])    ;
                                  local_noc_pkt_rcvd [12].payload_tuple_extd_value.push_back(payload_tuple_extd_value[12])    ;
                                end
                            end
                          else if (vLocalFromNoC[12].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [12] = vLocalFromNoC[12].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [12].payload_data.push_back (payload_data      [12])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[12].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [12] = vLocalFromNoC[12].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [12].payload_data.push_back (payload_data      [12])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[12].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[12].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 12, local_noc_pkt_rcvd [12].header_source);
                          noc2mgr_p [12].put(local_noc_pkt_rcvd [12]);
                          noc_rcvd_packet_complete[12] = 1;    
                        end
                      @(vLocalFromNoC[12].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 13
              @(vLocalFromNoC[13].cb_p);
              if ((vLocalFromNoC[13].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [13] = new();
                  noc_rcvd_packet_complete[13] = 0;    
                  while(~noc_rcvd_packet_complete[13])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 13);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[13].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[13].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [13].timeTag                     = $time;
                          local_noc_pkt_rcvd [13].header_destination_address  = vLocalFromNoC[13].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [13].header_source               = vLocalFromNoC[13].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [13].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[13].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[13].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [13] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [13] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [13] = vLocalFromNoC[13].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [13] = vLocalFromNoC[13].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [13].payload_tuple_type.push_back      (payload_tuple_type      [13])    ;
                              local_noc_pkt_rcvd [13].payload_tuple_extd_value.push_back(payload_tuple_extd_value[13])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[13].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [13] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [13] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [13] = vLocalFromNoC[13].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [13] = vLocalFromNoC[13].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [13].payload_tuple_type.push_back      (payload_tuple_type      [13])    ;
                                  local_noc_pkt_rcvd [13].payload_tuple_extd_value.push_back(payload_tuple_extd_value[13])    ;
                                end
                            end
                          else if (vLocalFromNoC[13].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [13] = vLocalFromNoC[13].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [13].payload_data.push_back (payload_data      [13])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[13].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [13] = vLocalFromNoC[13].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [13].payload_data.push_back (payload_data      [13])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[13].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[13].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 13, local_noc_pkt_rcvd [13].header_source);
                          noc2mgr_p [13].put(local_noc_pkt_rcvd [13]);
                          noc_rcvd_packet_complete[13] = 1;    
                        end
                      @(vLocalFromNoC[13].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 14
              @(vLocalFromNoC[14].cb_p);
              if ((vLocalFromNoC[14].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [14] = new();
                  noc_rcvd_packet_complete[14] = 0;    
                  while(~noc_rcvd_packet_complete[14])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 14);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[14].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[14].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [14].timeTag                     = $time;
                          local_noc_pkt_rcvd [14].header_destination_address  = vLocalFromNoC[14].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [14].header_source               = vLocalFromNoC[14].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [14].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[14].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[14].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [14] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [14] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [14] = vLocalFromNoC[14].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [14] = vLocalFromNoC[14].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [14].payload_tuple_type.push_back      (payload_tuple_type      [14])    ;
                              local_noc_pkt_rcvd [14].payload_tuple_extd_value.push_back(payload_tuple_extd_value[14])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[14].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [14] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [14] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [14] = vLocalFromNoC[14].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [14] = vLocalFromNoC[14].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [14].payload_tuple_type.push_back      (payload_tuple_type      [14])    ;
                                  local_noc_pkt_rcvd [14].payload_tuple_extd_value.push_back(payload_tuple_extd_value[14])    ;
                                end
                            end
                          else if (vLocalFromNoC[14].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [14] = vLocalFromNoC[14].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [14].payload_data.push_back (payload_data      [14])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[14].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [14] = vLocalFromNoC[14].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [14].payload_data.push_back (payload_data      [14])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[14].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[14].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 14, local_noc_pkt_rcvd [14].header_source);
                          noc2mgr_p [14].put(local_noc_pkt_rcvd [14]);
                          noc_rcvd_packet_complete[14] = 1;    
                        end
                      @(vLocalFromNoC[14].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 15
              @(vLocalFromNoC[15].cb_p);
              if ((vLocalFromNoC[15].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [15] = new();
                  noc_rcvd_packet_complete[15] = 0;    
                  while(~noc_rcvd_packet_complete[15])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 15);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[15].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[15].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [15].timeTag                     = $time;
                          local_noc_pkt_rcvd [15].header_destination_address  = vLocalFromNoC[15].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [15].header_source               = vLocalFromNoC[15].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [15].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[15].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[15].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [15] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [15] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [15] = vLocalFromNoC[15].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [15] = vLocalFromNoC[15].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [15].payload_tuple_type.push_back      (payload_tuple_type      [15])    ;
                              local_noc_pkt_rcvd [15].payload_tuple_extd_value.push_back(payload_tuple_extd_value[15])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[15].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [15] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [15] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [15] = vLocalFromNoC[15].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [15] = vLocalFromNoC[15].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [15].payload_tuple_type.push_back      (payload_tuple_type      [15])    ;
                                  local_noc_pkt_rcvd [15].payload_tuple_extd_value.push_back(payload_tuple_extd_value[15])    ;
                                end
                            end
                          else if (vLocalFromNoC[15].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [15] = vLocalFromNoC[15].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [15].payload_data.push_back (payload_data      [15])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[15].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [15] = vLocalFromNoC[15].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [15].payload_data.push_back (payload_data      [15])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[15].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[15].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 15, local_noc_pkt_rcvd [15].header_source);
                          noc2mgr_p [15].put(local_noc_pkt_rcvd [15]);
                          noc_rcvd_packet_complete[15] = 1;    
                        end
                      @(vLocalFromNoC[15].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 16
              @(vLocalFromNoC[16].cb_p);
              if ((vLocalFromNoC[16].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [16] = new();
                  noc_rcvd_packet_complete[16] = 0;    
                  while(~noc_rcvd_packet_complete[16])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 16);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[16].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[16].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [16].timeTag                     = $time;
                          local_noc_pkt_rcvd [16].header_destination_address  = vLocalFromNoC[16].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [16].header_source               = vLocalFromNoC[16].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [16].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[16].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[16].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [16] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [16] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [16] = vLocalFromNoC[16].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [16] = vLocalFromNoC[16].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [16].payload_tuple_type.push_back      (payload_tuple_type      [16])    ;
                              local_noc_pkt_rcvd [16].payload_tuple_extd_value.push_back(payload_tuple_extd_value[16])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[16].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [16] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [16] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [16] = vLocalFromNoC[16].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [16] = vLocalFromNoC[16].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [16].payload_tuple_type.push_back      (payload_tuple_type      [16])    ;
                                  local_noc_pkt_rcvd [16].payload_tuple_extd_value.push_back(payload_tuple_extd_value[16])    ;
                                end
                            end
                          else if (vLocalFromNoC[16].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [16] = vLocalFromNoC[16].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [16].payload_data.push_back (payload_data      [16])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[16].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [16] = vLocalFromNoC[16].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [16].payload_data.push_back (payload_data      [16])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[16].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[16].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 16, local_noc_pkt_rcvd [16].header_source);
                          noc2mgr_p [16].put(local_noc_pkt_rcvd [16]);
                          noc_rcvd_packet_complete[16] = 1;    
                        end
                      @(vLocalFromNoC[16].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 17
              @(vLocalFromNoC[17].cb_p);
              if ((vLocalFromNoC[17].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [17] = new();
                  noc_rcvd_packet_complete[17] = 0;    
                  while(~noc_rcvd_packet_complete[17])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 17);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[17].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[17].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [17].timeTag                     = $time;
                          local_noc_pkt_rcvd [17].header_destination_address  = vLocalFromNoC[17].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [17].header_source               = vLocalFromNoC[17].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [17].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[17].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[17].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [17] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [17] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [17] = vLocalFromNoC[17].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [17] = vLocalFromNoC[17].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [17].payload_tuple_type.push_back      (payload_tuple_type      [17])    ;
                              local_noc_pkt_rcvd [17].payload_tuple_extd_value.push_back(payload_tuple_extd_value[17])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[17].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [17] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [17] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [17] = vLocalFromNoC[17].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [17] = vLocalFromNoC[17].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [17].payload_tuple_type.push_back      (payload_tuple_type      [17])    ;
                                  local_noc_pkt_rcvd [17].payload_tuple_extd_value.push_back(payload_tuple_extd_value[17])    ;
                                end
                            end
                          else if (vLocalFromNoC[17].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [17] = vLocalFromNoC[17].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [17].payload_data.push_back (payload_data      [17])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[17].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [17] = vLocalFromNoC[17].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [17].payload_data.push_back (payload_data      [17])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[17].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[17].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 17, local_noc_pkt_rcvd [17].header_source);
                          noc2mgr_p [17].put(local_noc_pkt_rcvd [17]);
                          noc_rcvd_packet_complete[17] = 1;    
                        end
                      @(vLocalFromNoC[17].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 18
              @(vLocalFromNoC[18].cb_p);
              if ((vLocalFromNoC[18].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [18] = new();
                  noc_rcvd_packet_complete[18] = 0;    
                  while(~noc_rcvd_packet_complete[18])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 18);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[18].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[18].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [18].timeTag                     = $time;
                          local_noc_pkt_rcvd [18].header_destination_address  = vLocalFromNoC[18].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [18].header_source               = vLocalFromNoC[18].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [18].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[18].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[18].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [18] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [18] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [18] = vLocalFromNoC[18].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [18] = vLocalFromNoC[18].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [18].payload_tuple_type.push_back      (payload_tuple_type      [18])    ;
                              local_noc_pkt_rcvd [18].payload_tuple_extd_value.push_back(payload_tuple_extd_value[18])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[18].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [18] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [18] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [18] = vLocalFromNoC[18].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [18] = vLocalFromNoC[18].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [18].payload_tuple_type.push_back      (payload_tuple_type      [18])    ;
                                  local_noc_pkt_rcvd [18].payload_tuple_extd_value.push_back(payload_tuple_extd_value[18])    ;
                                end
                            end
                          else if (vLocalFromNoC[18].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [18] = vLocalFromNoC[18].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [18].payload_data.push_back (payload_data      [18])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[18].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [18] = vLocalFromNoC[18].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [18].payload_data.push_back (payload_data      [18])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[18].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[18].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 18, local_noc_pkt_rcvd [18].header_source);
                          noc2mgr_p [18].put(local_noc_pkt_rcvd [18]);
                          noc_rcvd_packet_complete[18] = 1;    
                        end
                      @(vLocalFromNoC[18].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 19
              @(vLocalFromNoC[19].cb_p);
              if ((vLocalFromNoC[19].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [19] = new();
                  noc_rcvd_packet_complete[19] = 0;    
                  while(~noc_rcvd_packet_complete[19])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 19);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[19].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[19].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [19].timeTag                     = $time;
                          local_noc_pkt_rcvd [19].header_destination_address  = vLocalFromNoC[19].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [19].header_source               = vLocalFromNoC[19].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [19].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[19].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[19].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [19] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [19] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [19] = vLocalFromNoC[19].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [19] = vLocalFromNoC[19].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [19].payload_tuple_type.push_back      (payload_tuple_type      [19])    ;
                              local_noc_pkt_rcvd [19].payload_tuple_extd_value.push_back(payload_tuple_extd_value[19])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[19].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [19] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [19] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [19] = vLocalFromNoC[19].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [19] = vLocalFromNoC[19].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [19].payload_tuple_type.push_back      (payload_tuple_type      [19])    ;
                                  local_noc_pkt_rcvd [19].payload_tuple_extd_value.push_back(payload_tuple_extd_value[19])    ;
                                end
                            end
                          else if (vLocalFromNoC[19].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [19] = vLocalFromNoC[19].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [19].payload_data.push_back (payload_data      [19])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[19].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [19] = vLocalFromNoC[19].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [19].payload_data.push_back (payload_data      [19])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[19].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[19].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 19, local_noc_pkt_rcvd [19].header_source);
                          noc2mgr_p [19].put(local_noc_pkt_rcvd [19]);
                          noc_rcvd_packet_complete[19] = 1;    
                        end
                      @(vLocalFromNoC[19].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 20
              @(vLocalFromNoC[20].cb_p);
              if ((vLocalFromNoC[20].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [20] = new();
                  noc_rcvd_packet_complete[20] = 0;    
                  while(~noc_rcvd_packet_complete[20])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 20);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[20].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[20].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [20].timeTag                     = $time;
                          local_noc_pkt_rcvd [20].header_destination_address  = vLocalFromNoC[20].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [20].header_source               = vLocalFromNoC[20].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [20].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[20].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[20].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [20] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [20] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [20] = vLocalFromNoC[20].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [20] = vLocalFromNoC[20].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [20].payload_tuple_type.push_back      (payload_tuple_type      [20])    ;
                              local_noc_pkt_rcvd [20].payload_tuple_extd_value.push_back(payload_tuple_extd_value[20])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[20].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [20] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [20] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [20] = vLocalFromNoC[20].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [20] = vLocalFromNoC[20].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [20].payload_tuple_type.push_back      (payload_tuple_type      [20])    ;
                                  local_noc_pkt_rcvd [20].payload_tuple_extd_value.push_back(payload_tuple_extd_value[20])    ;
                                end
                            end
                          else if (vLocalFromNoC[20].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [20] = vLocalFromNoC[20].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [20].payload_data.push_back (payload_data      [20])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[20].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [20] = vLocalFromNoC[20].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [20].payload_data.push_back (payload_data      [20])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[20].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[20].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 20, local_noc_pkt_rcvd [20].header_source);
                          noc2mgr_p [20].put(local_noc_pkt_rcvd [20]);
                          noc_rcvd_packet_complete[20] = 1;    
                        end
                      @(vLocalFromNoC[20].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 21
              @(vLocalFromNoC[21].cb_p);
              if ((vLocalFromNoC[21].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [21] = new();
                  noc_rcvd_packet_complete[21] = 0;    
                  while(~noc_rcvd_packet_complete[21])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 21);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[21].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[21].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [21].timeTag                     = $time;
                          local_noc_pkt_rcvd [21].header_destination_address  = vLocalFromNoC[21].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [21].header_source               = vLocalFromNoC[21].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [21].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[21].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[21].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [21] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [21] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [21] = vLocalFromNoC[21].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [21] = vLocalFromNoC[21].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [21].payload_tuple_type.push_back      (payload_tuple_type      [21])    ;
                              local_noc_pkt_rcvd [21].payload_tuple_extd_value.push_back(payload_tuple_extd_value[21])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[21].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [21] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [21] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [21] = vLocalFromNoC[21].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [21] = vLocalFromNoC[21].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [21].payload_tuple_type.push_back      (payload_tuple_type      [21])    ;
                                  local_noc_pkt_rcvd [21].payload_tuple_extd_value.push_back(payload_tuple_extd_value[21])    ;
                                end
                            end
                          else if (vLocalFromNoC[21].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [21] = vLocalFromNoC[21].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [21].payload_data.push_back (payload_data      [21])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[21].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [21] = vLocalFromNoC[21].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [21].payload_data.push_back (payload_data      [21])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[21].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[21].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 21, local_noc_pkt_rcvd [21].header_source);
                          noc2mgr_p [21].put(local_noc_pkt_rcvd [21]);
                          noc_rcvd_packet_complete[21] = 1;    
                        end
                      @(vLocalFromNoC[21].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 22
              @(vLocalFromNoC[22].cb_p);
              if ((vLocalFromNoC[22].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [22] = new();
                  noc_rcvd_packet_complete[22] = 0;    
                  while(~noc_rcvd_packet_complete[22])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 22);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[22].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[22].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [22].timeTag                     = $time;
                          local_noc_pkt_rcvd [22].header_destination_address  = vLocalFromNoC[22].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [22].header_source               = vLocalFromNoC[22].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [22].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[22].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[22].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [22] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [22] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [22] = vLocalFromNoC[22].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [22] = vLocalFromNoC[22].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [22].payload_tuple_type.push_back      (payload_tuple_type      [22])    ;
                              local_noc_pkt_rcvd [22].payload_tuple_extd_value.push_back(payload_tuple_extd_value[22])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[22].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [22] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [22] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [22] = vLocalFromNoC[22].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [22] = vLocalFromNoC[22].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [22].payload_tuple_type.push_back      (payload_tuple_type      [22])    ;
                                  local_noc_pkt_rcvd [22].payload_tuple_extd_value.push_back(payload_tuple_extd_value[22])    ;
                                end
                            end
                          else if (vLocalFromNoC[22].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [22] = vLocalFromNoC[22].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [22].payload_data.push_back (payload_data      [22])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[22].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [22] = vLocalFromNoC[22].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [22].payload_data.push_back (payload_data      [22])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[22].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[22].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 22, local_noc_pkt_rcvd [22].header_source);
                          noc2mgr_p [22].put(local_noc_pkt_rcvd [22]);
                          noc_rcvd_packet_complete[22] = 1;    
                        end
                      @(vLocalFromNoC[22].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 23
              @(vLocalFromNoC[23].cb_p);
              if ((vLocalFromNoC[23].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [23] = new();
                  noc_rcvd_packet_complete[23] = 0;    
                  while(~noc_rcvd_packet_complete[23])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 23);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[23].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[23].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [23].timeTag                     = $time;
                          local_noc_pkt_rcvd [23].header_destination_address  = vLocalFromNoC[23].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [23].header_source               = vLocalFromNoC[23].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [23].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[23].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[23].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [23] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [23] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [23] = vLocalFromNoC[23].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [23] = vLocalFromNoC[23].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [23].payload_tuple_type.push_back      (payload_tuple_type      [23])    ;
                              local_noc_pkt_rcvd [23].payload_tuple_extd_value.push_back(payload_tuple_extd_value[23])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[23].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [23] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [23] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [23] = vLocalFromNoC[23].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [23] = vLocalFromNoC[23].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [23].payload_tuple_type.push_back      (payload_tuple_type      [23])    ;
                                  local_noc_pkt_rcvd [23].payload_tuple_extd_value.push_back(payload_tuple_extd_value[23])    ;
                                end
                            end
                          else if (vLocalFromNoC[23].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [23] = vLocalFromNoC[23].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [23].payload_data.push_back (payload_data      [23])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[23].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [23] = vLocalFromNoC[23].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [23].payload_data.push_back (payload_data      [23])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[23].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[23].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 23, local_noc_pkt_rcvd [23].header_source);
                          noc2mgr_p [23].put(local_noc_pkt_rcvd [23]);
                          noc_rcvd_packet_complete[23] = 1;    
                        end
                      @(vLocalFromNoC[23].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 24
              @(vLocalFromNoC[24].cb_p);
              if ((vLocalFromNoC[24].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [24] = new();
                  noc_rcvd_packet_complete[24] = 0;    
                  while(~noc_rcvd_packet_complete[24])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 24);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[24].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[24].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [24].timeTag                     = $time;
                          local_noc_pkt_rcvd [24].header_destination_address  = vLocalFromNoC[24].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [24].header_source               = vLocalFromNoC[24].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [24].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[24].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[24].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [24] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [24] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [24] = vLocalFromNoC[24].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [24] = vLocalFromNoC[24].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [24].payload_tuple_type.push_back      (payload_tuple_type      [24])    ;
                              local_noc_pkt_rcvd [24].payload_tuple_extd_value.push_back(payload_tuple_extd_value[24])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[24].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [24] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [24] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [24] = vLocalFromNoC[24].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [24] = vLocalFromNoC[24].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [24].payload_tuple_type.push_back      (payload_tuple_type      [24])    ;
                                  local_noc_pkt_rcvd [24].payload_tuple_extd_value.push_back(payload_tuple_extd_value[24])    ;
                                end
                            end
                          else if (vLocalFromNoC[24].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [24] = vLocalFromNoC[24].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [24].payload_data.push_back (payload_data      [24])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[24].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [24] = vLocalFromNoC[24].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [24].payload_data.push_back (payload_data      [24])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[24].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[24].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 24, local_noc_pkt_rcvd [24].header_source);
                          noc2mgr_p [24].put(local_noc_pkt_rcvd [24]);
                          noc_rcvd_packet_complete[24] = 1;    
                        end
                      @(vLocalFromNoC[24].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 25
              @(vLocalFromNoC[25].cb_p);
              if ((vLocalFromNoC[25].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [25] = new();
                  noc_rcvd_packet_complete[25] = 0;    
                  while(~noc_rcvd_packet_complete[25])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 25);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[25].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[25].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [25].timeTag                     = $time;
                          local_noc_pkt_rcvd [25].header_destination_address  = vLocalFromNoC[25].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [25].header_source               = vLocalFromNoC[25].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [25].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[25].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[25].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [25] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [25] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [25] = vLocalFromNoC[25].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [25] = vLocalFromNoC[25].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [25].payload_tuple_type.push_back      (payload_tuple_type      [25])    ;
                              local_noc_pkt_rcvd [25].payload_tuple_extd_value.push_back(payload_tuple_extd_value[25])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[25].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [25] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [25] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [25] = vLocalFromNoC[25].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [25] = vLocalFromNoC[25].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [25].payload_tuple_type.push_back      (payload_tuple_type      [25])    ;
                                  local_noc_pkt_rcvd [25].payload_tuple_extd_value.push_back(payload_tuple_extd_value[25])    ;
                                end
                            end
                          else if (vLocalFromNoC[25].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [25] = vLocalFromNoC[25].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [25].payload_data.push_back (payload_data      [25])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[25].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [25] = vLocalFromNoC[25].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [25].payload_data.push_back (payload_data      [25])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[25].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[25].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 25, local_noc_pkt_rcvd [25].header_source);
                          noc2mgr_p [25].put(local_noc_pkt_rcvd [25]);
                          noc_rcvd_packet_complete[25] = 1;    
                        end
                      @(vLocalFromNoC[25].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 26
              @(vLocalFromNoC[26].cb_p);
              if ((vLocalFromNoC[26].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [26] = new();
                  noc_rcvd_packet_complete[26] = 0;    
                  while(~noc_rcvd_packet_complete[26])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 26);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[26].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[26].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [26].timeTag                     = $time;
                          local_noc_pkt_rcvd [26].header_destination_address  = vLocalFromNoC[26].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [26].header_source               = vLocalFromNoC[26].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [26].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[26].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[26].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [26] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [26] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [26] = vLocalFromNoC[26].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [26] = vLocalFromNoC[26].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [26].payload_tuple_type.push_back      (payload_tuple_type      [26])    ;
                              local_noc_pkt_rcvd [26].payload_tuple_extd_value.push_back(payload_tuple_extd_value[26])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[26].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [26] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [26] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [26] = vLocalFromNoC[26].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [26] = vLocalFromNoC[26].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [26].payload_tuple_type.push_back      (payload_tuple_type      [26])    ;
                                  local_noc_pkt_rcvd [26].payload_tuple_extd_value.push_back(payload_tuple_extd_value[26])    ;
                                end
                            end
                          else if (vLocalFromNoC[26].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [26] = vLocalFromNoC[26].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [26].payload_data.push_back (payload_data      [26])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[26].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [26] = vLocalFromNoC[26].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [26].payload_data.push_back (payload_data      [26])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[26].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[26].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 26, local_noc_pkt_rcvd [26].header_source);
                          noc2mgr_p [26].put(local_noc_pkt_rcvd [26]);
                          noc_rcvd_packet_complete[26] = 1;    
                        end
                      @(vLocalFromNoC[26].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 27
              @(vLocalFromNoC[27].cb_p);
              if ((vLocalFromNoC[27].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [27] = new();
                  noc_rcvd_packet_complete[27] = 0;    
                  while(~noc_rcvd_packet_complete[27])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 27);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[27].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[27].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [27].timeTag                     = $time;
                          local_noc_pkt_rcvd [27].header_destination_address  = vLocalFromNoC[27].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [27].header_source               = vLocalFromNoC[27].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [27].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[27].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[27].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [27] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [27] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [27] = vLocalFromNoC[27].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [27] = vLocalFromNoC[27].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [27].payload_tuple_type.push_back      (payload_tuple_type      [27])    ;
                              local_noc_pkt_rcvd [27].payload_tuple_extd_value.push_back(payload_tuple_extd_value[27])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[27].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [27] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [27] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [27] = vLocalFromNoC[27].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [27] = vLocalFromNoC[27].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [27].payload_tuple_type.push_back      (payload_tuple_type      [27])    ;
                                  local_noc_pkt_rcvd [27].payload_tuple_extd_value.push_back(payload_tuple_extd_value[27])    ;
                                end
                            end
                          else if (vLocalFromNoC[27].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [27] = vLocalFromNoC[27].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [27].payload_data.push_back (payload_data      [27])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[27].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [27] = vLocalFromNoC[27].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [27].payload_data.push_back (payload_data      [27])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[27].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[27].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 27, local_noc_pkt_rcvd [27].header_source);
                          noc2mgr_p [27].put(local_noc_pkt_rcvd [27]);
                          noc_rcvd_packet_complete[27] = 1;    
                        end
                      @(vLocalFromNoC[27].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 28
              @(vLocalFromNoC[28].cb_p);
              if ((vLocalFromNoC[28].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [28] = new();
                  noc_rcvd_packet_complete[28] = 0;    
                  while(~noc_rcvd_packet_complete[28])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 28);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[28].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[28].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [28].timeTag                     = $time;
                          local_noc_pkt_rcvd [28].header_destination_address  = vLocalFromNoC[28].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [28].header_source               = vLocalFromNoC[28].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [28].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[28].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[28].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [28] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [28] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [28] = vLocalFromNoC[28].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [28] = vLocalFromNoC[28].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [28].payload_tuple_type.push_back      (payload_tuple_type      [28])    ;
                              local_noc_pkt_rcvd [28].payload_tuple_extd_value.push_back(payload_tuple_extd_value[28])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[28].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [28] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [28] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [28] = vLocalFromNoC[28].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [28] = vLocalFromNoC[28].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [28].payload_tuple_type.push_back      (payload_tuple_type      [28])    ;
                                  local_noc_pkt_rcvd [28].payload_tuple_extd_value.push_back(payload_tuple_extd_value[28])    ;
                                end
                            end
                          else if (vLocalFromNoC[28].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [28] = vLocalFromNoC[28].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [28].payload_data.push_back (payload_data      [28])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[28].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [28] = vLocalFromNoC[28].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [28].payload_data.push_back (payload_data      [28])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[28].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[28].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 28, local_noc_pkt_rcvd [28].header_source);
                          noc2mgr_p [28].put(local_noc_pkt_rcvd [28]);
                          noc_rcvd_packet_complete[28] = 1;    
                        end
                      @(vLocalFromNoC[28].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 29
              @(vLocalFromNoC[29].cb_p);
              if ((vLocalFromNoC[29].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [29] = new();
                  noc_rcvd_packet_complete[29] = 0;    
                  while(~noc_rcvd_packet_complete[29])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 29);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[29].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[29].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [29].timeTag                     = $time;
                          local_noc_pkt_rcvd [29].header_destination_address  = vLocalFromNoC[29].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [29].header_source               = vLocalFromNoC[29].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [29].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[29].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[29].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [29] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [29] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [29] = vLocalFromNoC[29].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [29] = vLocalFromNoC[29].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [29].payload_tuple_type.push_back      (payload_tuple_type      [29])    ;
                              local_noc_pkt_rcvd [29].payload_tuple_extd_value.push_back(payload_tuple_extd_value[29])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[29].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [29] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [29] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [29] = vLocalFromNoC[29].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [29] = vLocalFromNoC[29].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [29].payload_tuple_type.push_back      (payload_tuple_type      [29])    ;
                                  local_noc_pkt_rcvd [29].payload_tuple_extd_value.push_back(payload_tuple_extd_value[29])    ;
                                end
                            end
                          else if (vLocalFromNoC[29].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [29] = vLocalFromNoC[29].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [29].payload_data.push_back (payload_data      [29])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[29].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [29] = vLocalFromNoC[29].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [29].payload_data.push_back (payload_data      [29])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[29].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[29].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 29, local_noc_pkt_rcvd [29].header_source);
                          noc2mgr_p [29].put(local_noc_pkt_rcvd [29]);
                          noc_rcvd_packet_complete[29] = 1;    
                        end
                      @(vLocalFromNoC[29].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 30
              @(vLocalFromNoC[30].cb_p);
              if ((vLocalFromNoC[30].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [30] = new();
                  noc_rcvd_packet_complete[30] = 0;    
                  while(~noc_rcvd_packet_complete[30])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 30);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[30].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[30].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [30].timeTag                     = $time;
                          local_noc_pkt_rcvd [30].header_destination_address  = vLocalFromNoC[30].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [30].header_source               = vLocalFromNoC[30].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [30].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[30].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[30].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [30] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [30] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [30] = vLocalFromNoC[30].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [30] = vLocalFromNoC[30].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [30].payload_tuple_type.push_back      (payload_tuple_type      [30])    ;
                              local_noc_pkt_rcvd [30].payload_tuple_extd_value.push_back(payload_tuple_extd_value[30])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[30].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [30] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [30] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [30] = vLocalFromNoC[30].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [30] = vLocalFromNoC[30].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [30].payload_tuple_type.push_back      (payload_tuple_type      [30])    ;
                                  local_noc_pkt_rcvd [30].payload_tuple_extd_value.push_back(payload_tuple_extd_value[30])    ;
                                end
                            end
                          else if (vLocalFromNoC[30].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [30] = vLocalFromNoC[30].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [30].payload_data.push_back (payload_data      [30])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[30].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [30] = vLocalFromNoC[30].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [30].payload_data.push_back (payload_data      [30])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[30].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[30].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 30, local_noc_pkt_rcvd [30].header_source);
                          noc2mgr_p [30].put(local_noc_pkt_rcvd [30]);
                          noc_rcvd_packet_complete[30] = 1;    
                        end
                      @(vLocalFromNoC[30].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 31
              @(vLocalFromNoC[31].cb_p);
              if ((vLocalFromNoC[31].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [31] = new();
                  noc_rcvd_packet_complete[31] = 0;    
                  while(~noc_rcvd_packet_complete[31])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 31);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[31].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[31].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [31].timeTag                     = $time;
                          local_noc_pkt_rcvd [31].header_destination_address  = vLocalFromNoC[31].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [31].header_source               = vLocalFromNoC[31].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [31].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[31].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[31].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [31] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [31] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [31] = vLocalFromNoC[31].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [31] = vLocalFromNoC[31].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [31].payload_tuple_type.push_back      (payload_tuple_type      [31])    ;
                              local_noc_pkt_rcvd [31].payload_tuple_extd_value.push_back(payload_tuple_extd_value[31])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[31].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [31] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [31] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [31] = vLocalFromNoC[31].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [31] = vLocalFromNoC[31].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [31].payload_tuple_type.push_back      (payload_tuple_type      [31])    ;
                                  local_noc_pkt_rcvd [31].payload_tuple_extd_value.push_back(payload_tuple_extd_value[31])    ;
                                end
                            end
                          else if (vLocalFromNoC[31].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [31] = vLocalFromNoC[31].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [31].payload_data.push_back (payload_data      [31])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[31].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [31] = vLocalFromNoC[31].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [31].payload_data.push_back (payload_data      [31])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[31].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[31].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 31, local_noc_pkt_rcvd [31].header_source);
                          noc2mgr_p [31].put(local_noc_pkt_rcvd [31]);
                          noc_rcvd_packet_complete[31] = 1;    
                        end
                      @(vLocalFromNoC[31].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 32
              @(vLocalFromNoC[32].cb_p);
              if ((vLocalFromNoC[32].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [32] = new();
                  noc_rcvd_packet_complete[32] = 0;    
                  while(~noc_rcvd_packet_complete[32])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 32);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[32].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[32].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [32].timeTag                     = $time;
                          local_noc_pkt_rcvd [32].header_destination_address  = vLocalFromNoC[32].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [32].header_source               = vLocalFromNoC[32].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [32].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[32].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[32].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [32] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [32] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [32] = vLocalFromNoC[32].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [32] = vLocalFromNoC[32].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [32].payload_tuple_type.push_back      (payload_tuple_type      [32])    ;
                              local_noc_pkt_rcvd [32].payload_tuple_extd_value.push_back(payload_tuple_extd_value[32])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[32].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [32] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [32] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [32] = vLocalFromNoC[32].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [32] = vLocalFromNoC[32].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [32].payload_tuple_type.push_back      (payload_tuple_type      [32])    ;
                                  local_noc_pkt_rcvd [32].payload_tuple_extd_value.push_back(payload_tuple_extd_value[32])    ;
                                end
                            end
                          else if (vLocalFromNoC[32].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [32] = vLocalFromNoC[32].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [32].payload_data.push_back (payload_data      [32])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[32].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [32] = vLocalFromNoC[32].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [32].payload_data.push_back (payload_data      [32])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[32].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[32].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 32, local_noc_pkt_rcvd [32].header_source);
                          noc2mgr_p [32].put(local_noc_pkt_rcvd [32]);
                          noc_rcvd_packet_complete[32] = 1;    
                        end
                      @(vLocalFromNoC[32].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 33
              @(vLocalFromNoC[33].cb_p);
              if ((vLocalFromNoC[33].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [33] = new();
                  noc_rcvd_packet_complete[33] = 0;    
                  while(~noc_rcvd_packet_complete[33])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 33);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[33].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[33].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [33].timeTag                     = $time;
                          local_noc_pkt_rcvd [33].header_destination_address  = vLocalFromNoC[33].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [33].header_source               = vLocalFromNoC[33].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [33].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[33].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[33].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [33] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [33] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [33] = vLocalFromNoC[33].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [33] = vLocalFromNoC[33].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [33].payload_tuple_type.push_back      (payload_tuple_type      [33])    ;
                              local_noc_pkt_rcvd [33].payload_tuple_extd_value.push_back(payload_tuple_extd_value[33])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[33].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [33] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [33] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [33] = vLocalFromNoC[33].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [33] = vLocalFromNoC[33].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [33].payload_tuple_type.push_back      (payload_tuple_type      [33])    ;
                                  local_noc_pkt_rcvd [33].payload_tuple_extd_value.push_back(payload_tuple_extd_value[33])    ;
                                end
                            end
                          else if (vLocalFromNoC[33].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [33] = vLocalFromNoC[33].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [33].payload_data.push_back (payload_data      [33])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[33].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [33] = vLocalFromNoC[33].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [33].payload_data.push_back (payload_data      [33])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[33].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[33].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 33, local_noc_pkt_rcvd [33].header_source);
                          noc2mgr_p [33].put(local_noc_pkt_rcvd [33]);
                          noc_rcvd_packet_complete[33] = 1;    
                        end
                      @(vLocalFromNoC[33].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 34
              @(vLocalFromNoC[34].cb_p);
              if ((vLocalFromNoC[34].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [34] = new();
                  noc_rcvd_packet_complete[34] = 0;    
                  while(~noc_rcvd_packet_complete[34])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 34);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[34].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[34].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [34].timeTag                     = $time;
                          local_noc_pkt_rcvd [34].header_destination_address  = vLocalFromNoC[34].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [34].header_source               = vLocalFromNoC[34].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [34].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[34].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[34].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [34] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [34] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [34] = vLocalFromNoC[34].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [34] = vLocalFromNoC[34].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [34].payload_tuple_type.push_back      (payload_tuple_type      [34])    ;
                              local_noc_pkt_rcvd [34].payload_tuple_extd_value.push_back(payload_tuple_extd_value[34])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[34].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [34] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [34] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [34] = vLocalFromNoC[34].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [34] = vLocalFromNoC[34].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [34].payload_tuple_type.push_back      (payload_tuple_type      [34])    ;
                                  local_noc_pkt_rcvd [34].payload_tuple_extd_value.push_back(payload_tuple_extd_value[34])    ;
                                end
                            end
                          else if (vLocalFromNoC[34].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [34] = vLocalFromNoC[34].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [34].payload_data.push_back (payload_data      [34])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[34].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [34] = vLocalFromNoC[34].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [34].payload_data.push_back (payload_data      [34])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[34].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[34].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 34, local_noc_pkt_rcvd [34].header_source);
                          noc2mgr_p [34].put(local_noc_pkt_rcvd [34]);
                          noc_rcvd_packet_complete[34] = 1;    
                        end
                      @(vLocalFromNoC[34].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 35
              @(vLocalFromNoC[35].cb_p);
              if ((vLocalFromNoC[35].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [35] = new();
                  noc_rcvd_packet_complete[35] = 0;    
                  while(~noc_rcvd_packet_complete[35])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 35);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[35].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[35].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [35].timeTag                     = $time;
                          local_noc_pkt_rcvd [35].header_destination_address  = vLocalFromNoC[35].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [35].header_source               = vLocalFromNoC[35].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [35].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[35].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[35].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [35] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [35] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [35] = vLocalFromNoC[35].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [35] = vLocalFromNoC[35].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [35].payload_tuple_type.push_back      (payload_tuple_type      [35])    ;
                              local_noc_pkt_rcvd [35].payload_tuple_extd_value.push_back(payload_tuple_extd_value[35])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[35].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [35] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [35] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [35] = vLocalFromNoC[35].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [35] = vLocalFromNoC[35].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [35].payload_tuple_type.push_back      (payload_tuple_type      [35])    ;
                                  local_noc_pkt_rcvd [35].payload_tuple_extd_value.push_back(payload_tuple_extd_value[35])    ;
                                end
                            end
                          else if (vLocalFromNoC[35].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [35] = vLocalFromNoC[35].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [35].payload_data.push_back (payload_data      [35])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[35].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [35] = vLocalFromNoC[35].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [35].payload_data.push_back (payload_data      [35])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[35].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[35].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 35, local_noc_pkt_rcvd [35].header_source);
                          noc2mgr_p [35].put(local_noc_pkt_rcvd [35]);
                          noc_rcvd_packet_complete[35] = 1;    
                        end
                      @(vLocalFromNoC[35].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 36
              @(vLocalFromNoC[36].cb_p);
              if ((vLocalFromNoC[36].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [36] = new();
                  noc_rcvd_packet_complete[36] = 0;    
                  while(~noc_rcvd_packet_complete[36])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 36);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[36].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[36].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [36].timeTag                     = $time;
                          local_noc_pkt_rcvd [36].header_destination_address  = vLocalFromNoC[36].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [36].header_source               = vLocalFromNoC[36].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [36].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[36].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[36].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [36] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [36] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [36] = vLocalFromNoC[36].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [36] = vLocalFromNoC[36].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [36].payload_tuple_type.push_back      (payload_tuple_type      [36])    ;
                              local_noc_pkt_rcvd [36].payload_tuple_extd_value.push_back(payload_tuple_extd_value[36])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[36].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [36] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [36] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [36] = vLocalFromNoC[36].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [36] = vLocalFromNoC[36].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [36].payload_tuple_type.push_back      (payload_tuple_type      [36])    ;
                                  local_noc_pkt_rcvd [36].payload_tuple_extd_value.push_back(payload_tuple_extd_value[36])    ;
                                end
                            end
                          else if (vLocalFromNoC[36].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [36] = vLocalFromNoC[36].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [36].payload_data.push_back (payload_data      [36])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[36].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [36] = vLocalFromNoC[36].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [36].payload_data.push_back (payload_data      [36])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[36].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[36].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 36, local_noc_pkt_rcvd [36].header_source);
                          noc2mgr_p [36].put(local_noc_pkt_rcvd [36]);
                          noc_rcvd_packet_complete[36] = 1;    
                        end
                      @(vLocalFromNoC[36].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 37
              @(vLocalFromNoC[37].cb_p);
              if ((vLocalFromNoC[37].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [37] = new();
                  noc_rcvd_packet_complete[37] = 0;    
                  while(~noc_rcvd_packet_complete[37])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 37);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[37].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[37].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [37].timeTag                     = $time;
                          local_noc_pkt_rcvd [37].header_destination_address  = vLocalFromNoC[37].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [37].header_source               = vLocalFromNoC[37].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [37].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[37].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[37].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [37] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [37] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [37] = vLocalFromNoC[37].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [37] = vLocalFromNoC[37].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [37].payload_tuple_type.push_back      (payload_tuple_type      [37])    ;
                              local_noc_pkt_rcvd [37].payload_tuple_extd_value.push_back(payload_tuple_extd_value[37])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[37].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [37] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [37] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [37] = vLocalFromNoC[37].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [37] = vLocalFromNoC[37].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [37].payload_tuple_type.push_back      (payload_tuple_type      [37])    ;
                                  local_noc_pkt_rcvd [37].payload_tuple_extd_value.push_back(payload_tuple_extd_value[37])    ;
                                end
                            end
                          else if (vLocalFromNoC[37].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [37] = vLocalFromNoC[37].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [37].payload_data.push_back (payload_data      [37])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[37].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [37] = vLocalFromNoC[37].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [37].payload_data.push_back (payload_data      [37])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[37].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[37].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 37, local_noc_pkt_rcvd [37].header_source);
                          noc2mgr_p [37].put(local_noc_pkt_rcvd [37]);
                          noc_rcvd_packet_complete[37] = 1;    
                        end
                      @(vLocalFromNoC[37].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 38
              @(vLocalFromNoC[38].cb_p);
              if ((vLocalFromNoC[38].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [38] = new();
                  noc_rcvd_packet_complete[38] = 0;    
                  while(~noc_rcvd_packet_complete[38])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 38);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[38].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[38].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [38].timeTag                     = $time;
                          local_noc_pkt_rcvd [38].header_destination_address  = vLocalFromNoC[38].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [38].header_source               = vLocalFromNoC[38].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [38].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[38].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[38].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [38] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [38] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [38] = vLocalFromNoC[38].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [38] = vLocalFromNoC[38].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [38].payload_tuple_type.push_back      (payload_tuple_type      [38])    ;
                              local_noc_pkt_rcvd [38].payload_tuple_extd_value.push_back(payload_tuple_extd_value[38])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[38].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [38] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [38] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [38] = vLocalFromNoC[38].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [38] = vLocalFromNoC[38].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [38].payload_tuple_type.push_back      (payload_tuple_type      [38])    ;
                                  local_noc_pkt_rcvd [38].payload_tuple_extd_value.push_back(payload_tuple_extd_value[38])    ;
                                end
                            end
                          else if (vLocalFromNoC[38].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [38] = vLocalFromNoC[38].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [38].payload_data.push_back (payload_data      [38])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[38].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [38] = vLocalFromNoC[38].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [38].payload_data.push_back (payload_data      [38])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[38].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[38].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 38, local_noc_pkt_rcvd [38].header_source);
                          noc2mgr_p [38].put(local_noc_pkt_rcvd [38]);
                          noc_rcvd_packet_complete[38] = 1;    
                        end
                      @(vLocalFromNoC[38].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 39
              @(vLocalFromNoC[39].cb_p);
              if ((vLocalFromNoC[39].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [39] = new();
                  noc_rcvd_packet_complete[39] = 0;    
                  while(~noc_rcvd_packet_complete[39])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 39);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[39].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[39].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [39].timeTag                     = $time;
                          local_noc_pkt_rcvd [39].header_destination_address  = vLocalFromNoC[39].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [39].header_source               = vLocalFromNoC[39].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [39].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[39].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[39].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [39] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [39] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [39] = vLocalFromNoC[39].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [39] = vLocalFromNoC[39].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [39].payload_tuple_type.push_back      (payload_tuple_type      [39])    ;
                              local_noc_pkt_rcvd [39].payload_tuple_extd_value.push_back(payload_tuple_extd_value[39])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[39].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [39] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [39] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [39] = vLocalFromNoC[39].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [39] = vLocalFromNoC[39].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [39].payload_tuple_type.push_back      (payload_tuple_type      [39])    ;
                                  local_noc_pkt_rcvd [39].payload_tuple_extd_value.push_back(payload_tuple_extd_value[39])    ;
                                end
                            end
                          else if (vLocalFromNoC[39].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [39] = vLocalFromNoC[39].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [39].payload_data.push_back (payload_data      [39])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[39].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [39] = vLocalFromNoC[39].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [39].payload_data.push_back (payload_data      [39])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[39].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[39].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 39, local_noc_pkt_rcvd [39].header_source);
                          noc2mgr_p [39].put(local_noc_pkt_rcvd [39]);
                          noc_rcvd_packet_complete[39] = 1;    
                        end
                      @(vLocalFromNoC[39].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 40
              @(vLocalFromNoC[40].cb_p);
              if ((vLocalFromNoC[40].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [40] = new();
                  noc_rcvd_packet_complete[40] = 0;    
                  while(~noc_rcvd_packet_complete[40])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 40);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[40].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[40].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [40].timeTag                     = $time;
                          local_noc_pkt_rcvd [40].header_destination_address  = vLocalFromNoC[40].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [40].header_source               = vLocalFromNoC[40].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [40].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[40].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[40].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [40] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [40] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [40] = vLocalFromNoC[40].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [40] = vLocalFromNoC[40].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [40].payload_tuple_type.push_back      (payload_tuple_type      [40])    ;
                              local_noc_pkt_rcvd [40].payload_tuple_extd_value.push_back(payload_tuple_extd_value[40])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[40].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [40] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [40] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [40] = vLocalFromNoC[40].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [40] = vLocalFromNoC[40].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [40].payload_tuple_type.push_back      (payload_tuple_type      [40])    ;
                                  local_noc_pkt_rcvd [40].payload_tuple_extd_value.push_back(payload_tuple_extd_value[40])    ;
                                end
                            end
                          else if (vLocalFromNoC[40].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [40] = vLocalFromNoC[40].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [40].payload_data.push_back (payload_data      [40])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[40].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [40] = vLocalFromNoC[40].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [40].payload_data.push_back (payload_data      [40])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[40].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[40].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 40, local_noc_pkt_rcvd [40].header_source);
                          noc2mgr_p [40].put(local_noc_pkt_rcvd [40]);
                          noc_rcvd_packet_complete[40] = 1;    
                        end
                      @(vLocalFromNoC[40].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 41
              @(vLocalFromNoC[41].cb_p);
              if ((vLocalFromNoC[41].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [41] = new();
                  noc_rcvd_packet_complete[41] = 0;    
                  while(~noc_rcvd_packet_complete[41])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 41);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[41].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[41].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [41].timeTag                     = $time;
                          local_noc_pkt_rcvd [41].header_destination_address  = vLocalFromNoC[41].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [41].header_source               = vLocalFromNoC[41].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [41].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[41].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[41].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [41] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [41] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [41] = vLocalFromNoC[41].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [41] = vLocalFromNoC[41].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [41].payload_tuple_type.push_back      (payload_tuple_type      [41])    ;
                              local_noc_pkt_rcvd [41].payload_tuple_extd_value.push_back(payload_tuple_extd_value[41])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[41].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [41] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [41] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [41] = vLocalFromNoC[41].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [41] = vLocalFromNoC[41].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [41].payload_tuple_type.push_back      (payload_tuple_type      [41])    ;
                                  local_noc_pkt_rcvd [41].payload_tuple_extd_value.push_back(payload_tuple_extd_value[41])    ;
                                end
                            end
                          else if (vLocalFromNoC[41].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [41] = vLocalFromNoC[41].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [41].payload_data.push_back (payload_data      [41])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[41].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [41] = vLocalFromNoC[41].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [41].payload_data.push_back (payload_data      [41])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[41].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[41].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 41, local_noc_pkt_rcvd [41].header_source);
                          noc2mgr_p [41].put(local_noc_pkt_rcvd [41]);
                          noc_rcvd_packet_complete[41] = 1;    
                        end
                      @(vLocalFromNoC[41].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 42
              @(vLocalFromNoC[42].cb_p);
              if ((vLocalFromNoC[42].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [42] = new();
                  noc_rcvd_packet_complete[42] = 0;    
                  while(~noc_rcvd_packet_complete[42])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 42);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[42].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[42].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [42].timeTag                     = $time;
                          local_noc_pkt_rcvd [42].header_destination_address  = vLocalFromNoC[42].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [42].header_source               = vLocalFromNoC[42].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [42].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[42].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[42].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [42] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [42] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [42] = vLocalFromNoC[42].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [42] = vLocalFromNoC[42].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [42].payload_tuple_type.push_back      (payload_tuple_type      [42])    ;
                              local_noc_pkt_rcvd [42].payload_tuple_extd_value.push_back(payload_tuple_extd_value[42])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[42].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [42] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [42] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [42] = vLocalFromNoC[42].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [42] = vLocalFromNoC[42].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [42].payload_tuple_type.push_back      (payload_tuple_type      [42])    ;
                                  local_noc_pkt_rcvd [42].payload_tuple_extd_value.push_back(payload_tuple_extd_value[42])    ;
                                end
                            end
                          else if (vLocalFromNoC[42].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [42] = vLocalFromNoC[42].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [42].payload_data.push_back (payload_data      [42])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[42].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [42] = vLocalFromNoC[42].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [42].payload_data.push_back (payload_data      [42])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[42].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[42].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 42, local_noc_pkt_rcvd [42].header_source);
                          noc2mgr_p [42].put(local_noc_pkt_rcvd [42]);
                          noc_rcvd_packet_complete[42] = 1;    
                        end
                      @(vLocalFromNoC[42].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 43
              @(vLocalFromNoC[43].cb_p);
              if ((vLocalFromNoC[43].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [43] = new();
                  noc_rcvd_packet_complete[43] = 0;    
                  while(~noc_rcvd_packet_complete[43])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 43);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[43].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[43].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [43].timeTag                     = $time;
                          local_noc_pkt_rcvd [43].header_destination_address  = vLocalFromNoC[43].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [43].header_source               = vLocalFromNoC[43].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [43].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[43].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[43].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [43] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [43] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [43] = vLocalFromNoC[43].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [43] = vLocalFromNoC[43].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [43].payload_tuple_type.push_back      (payload_tuple_type      [43])    ;
                              local_noc_pkt_rcvd [43].payload_tuple_extd_value.push_back(payload_tuple_extd_value[43])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[43].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [43] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [43] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [43] = vLocalFromNoC[43].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [43] = vLocalFromNoC[43].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [43].payload_tuple_type.push_back      (payload_tuple_type      [43])    ;
                                  local_noc_pkt_rcvd [43].payload_tuple_extd_value.push_back(payload_tuple_extd_value[43])    ;
                                end
                            end
                          else if (vLocalFromNoC[43].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [43] = vLocalFromNoC[43].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [43].payload_data.push_back (payload_data      [43])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[43].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [43] = vLocalFromNoC[43].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [43].payload_data.push_back (payload_data      [43])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[43].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[43].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 43, local_noc_pkt_rcvd [43].header_source);
                          noc2mgr_p [43].put(local_noc_pkt_rcvd [43]);
                          noc_rcvd_packet_complete[43] = 1;    
                        end
                      @(vLocalFromNoC[43].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 44
              @(vLocalFromNoC[44].cb_p);
              if ((vLocalFromNoC[44].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [44] = new();
                  noc_rcvd_packet_complete[44] = 0;    
                  while(~noc_rcvd_packet_complete[44])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 44);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[44].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[44].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [44].timeTag                     = $time;
                          local_noc_pkt_rcvd [44].header_destination_address  = vLocalFromNoC[44].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [44].header_source               = vLocalFromNoC[44].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [44].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[44].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[44].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [44] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [44] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [44] = vLocalFromNoC[44].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [44] = vLocalFromNoC[44].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [44].payload_tuple_type.push_back      (payload_tuple_type      [44])    ;
                              local_noc_pkt_rcvd [44].payload_tuple_extd_value.push_back(payload_tuple_extd_value[44])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[44].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [44] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [44] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [44] = vLocalFromNoC[44].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [44] = vLocalFromNoC[44].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [44].payload_tuple_type.push_back      (payload_tuple_type      [44])    ;
                                  local_noc_pkt_rcvd [44].payload_tuple_extd_value.push_back(payload_tuple_extd_value[44])    ;
                                end
                            end
                          else if (vLocalFromNoC[44].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [44] = vLocalFromNoC[44].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [44].payload_data.push_back (payload_data      [44])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[44].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [44] = vLocalFromNoC[44].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [44].payload_data.push_back (payload_data      [44])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[44].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[44].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 44, local_noc_pkt_rcvd [44].header_source);
                          noc2mgr_p [44].put(local_noc_pkt_rcvd [44]);
                          noc_rcvd_packet_complete[44] = 1;    
                        end
                      @(vLocalFromNoC[44].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 45
              @(vLocalFromNoC[45].cb_p);
              if ((vLocalFromNoC[45].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [45] = new();
                  noc_rcvd_packet_complete[45] = 0;    
                  while(~noc_rcvd_packet_complete[45])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 45);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[45].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[45].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [45].timeTag                     = $time;
                          local_noc_pkt_rcvd [45].header_destination_address  = vLocalFromNoC[45].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [45].header_source               = vLocalFromNoC[45].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [45].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[45].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[45].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [45] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [45] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [45] = vLocalFromNoC[45].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [45] = vLocalFromNoC[45].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [45].payload_tuple_type.push_back      (payload_tuple_type      [45])    ;
                              local_noc_pkt_rcvd [45].payload_tuple_extd_value.push_back(payload_tuple_extd_value[45])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[45].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [45] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [45] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [45] = vLocalFromNoC[45].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [45] = vLocalFromNoC[45].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [45].payload_tuple_type.push_back      (payload_tuple_type      [45])    ;
                                  local_noc_pkt_rcvd [45].payload_tuple_extd_value.push_back(payload_tuple_extd_value[45])    ;
                                end
                            end
                          else if (vLocalFromNoC[45].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [45] = vLocalFromNoC[45].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [45].payload_data.push_back (payload_data      [45])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[45].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [45] = vLocalFromNoC[45].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [45].payload_data.push_back (payload_data      [45])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[45].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[45].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 45, local_noc_pkt_rcvd [45].header_source);
                          noc2mgr_p [45].put(local_noc_pkt_rcvd [45]);
                          noc_rcvd_packet_complete[45] = 1;    
                        end
                      @(vLocalFromNoC[45].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 46
              @(vLocalFromNoC[46].cb_p);
              if ((vLocalFromNoC[46].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [46] = new();
                  noc_rcvd_packet_complete[46] = 0;    
                  while(~noc_rcvd_packet_complete[46])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 46);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[46].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[46].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [46].timeTag                     = $time;
                          local_noc_pkt_rcvd [46].header_destination_address  = vLocalFromNoC[46].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [46].header_source               = vLocalFromNoC[46].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [46].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[46].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[46].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [46] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [46] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [46] = vLocalFromNoC[46].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [46] = vLocalFromNoC[46].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [46].payload_tuple_type.push_back      (payload_tuple_type      [46])    ;
                              local_noc_pkt_rcvd [46].payload_tuple_extd_value.push_back(payload_tuple_extd_value[46])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[46].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [46] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [46] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [46] = vLocalFromNoC[46].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [46] = vLocalFromNoC[46].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [46].payload_tuple_type.push_back      (payload_tuple_type      [46])    ;
                                  local_noc_pkt_rcvd [46].payload_tuple_extd_value.push_back(payload_tuple_extd_value[46])    ;
                                end
                            end
                          else if (vLocalFromNoC[46].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [46] = vLocalFromNoC[46].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [46].payload_data.push_back (payload_data      [46])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[46].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [46] = vLocalFromNoC[46].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [46].payload_data.push_back (payload_data      [46])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[46].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[46].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 46, local_noc_pkt_rcvd [46].header_source);
                          noc2mgr_p [46].put(local_noc_pkt_rcvd [46]);
                          noc_rcvd_packet_complete[46] = 1;    
                        end
                      @(vLocalFromNoC[46].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 47
              @(vLocalFromNoC[47].cb_p);
              if ((vLocalFromNoC[47].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [47] = new();
                  noc_rcvd_packet_complete[47] = 0;    
                  while(~noc_rcvd_packet_complete[47])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 47);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[47].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[47].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [47].timeTag                     = $time;
                          local_noc_pkt_rcvd [47].header_destination_address  = vLocalFromNoC[47].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [47].header_source               = vLocalFromNoC[47].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [47].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[47].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[47].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [47] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [47] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [47] = vLocalFromNoC[47].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [47] = vLocalFromNoC[47].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [47].payload_tuple_type.push_back      (payload_tuple_type      [47])    ;
                              local_noc_pkt_rcvd [47].payload_tuple_extd_value.push_back(payload_tuple_extd_value[47])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[47].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [47] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [47] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [47] = vLocalFromNoC[47].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [47] = vLocalFromNoC[47].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [47].payload_tuple_type.push_back      (payload_tuple_type      [47])    ;
                                  local_noc_pkt_rcvd [47].payload_tuple_extd_value.push_back(payload_tuple_extd_value[47])    ;
                                end
                            end
                          else if (vLocalFromNoC[47].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [47] = vLocalFromNoC[47].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [47].payload_data.push_back (payload_data      [47])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[47].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [47] = vLocalFromNoC[47].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [47].payload_data.push_back (payload_data      [47])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[47].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[47].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 47, local_noc_pkt_rcvd [47].header_source);
                          noc2mgr_p [47].put(local_noc_pkt_rcvd [47]);
                          noc_rcvd_packet_complete[47] = 1;    
                        end
                      @(vLocalFromNoC[47].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 48
              @(vLocalFromNoC[48].cb_p);
              if ((vLocalFromNoC[48].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [48] = new();
                  noc_rcvd_packet_complete[48] = 0;    
                  while(~noc_rcvd_packet_complete[48])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 48);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[48].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[48].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [48].timeTag                     = $time;
                          local_noc_pkt_rcvd [48].header_destination_address  = vLocalFromNoC[48].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [48].header_source               = vLocalFromNoC[48].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [48].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[48].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[48].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [48] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [48] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [48] = vLocalFromNoC[48].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [48] = vLocalFromNoC[48].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [48].payload_tuple_type.push_back      (payload_tuple_type      [48])    ;
                              local_noc_pkt_rcvd [48].payload_tuple_extd_value.push_back(payload_tuple_extd_value[48])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[48].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [48] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [48] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [48] = vLocalFromNoC[48].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [48] = vLocalFromNoC[48].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [48].payload_tuple_type.push_back      (payload_tuple_type      [48])    ;
                                  local_noc_pkt_rcvd [48].payload_tuple_extd_value.push_back(payload_tuple_extd_value[48])    ;
                                end
                            end
                          else if (vLocalFromNoC[48].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [48] = vLocalFromNoC[48].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [48].payload_data.push_back (payload_data      [48])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[48].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [48] = vLocalFromNoC[48].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [48].payload_data.push_back (payload_data      [48])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[48].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[48].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 48, local_noc_pkt_rcvd [48].header_source);
                          noc2mgr_p [48].put(local_noc_pkt_rcvd [48]);
                          noc_rcvd_packet_complete[48] = 1;    
                        end
                      @(vLocalFromNoC[48].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 49
              @(vLocalFromNoC[49].cb_p);
              if ((vLocalFromNoC[49].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [49] = new();
                  noc_rcvd_packet_complete[49] = 0;    
                  while(~noc_rcvd_packet_complete[49])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 49);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[49].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[49].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [49].timeTag                     = $time;
                          local_noc_pkt_rcvd [49].header_destination_address  = vLocalFromNoC[49].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [49].header_source               = vLocalFromNoC[49].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [49].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[49].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[49].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [49] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [49] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [49] = vLocalFromNoC[49].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [49] = vLocalFromNoC[49].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [49].payload_tuple_type.push_back      (payload_tuple_type      [49])    ;
                              local_noc_pkt_rcvd [49].payload_tuple_extd_value.push_back(payload_tuple_extd_value[49])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[49].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [49] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [49] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [49] = vLocalFromNoC[49].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [49] = vLocalFromNoC[49].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [49].payload_tuple_type.push_back      (payload_tuple_type      [49])    ;
                                  local_noc_pkt_rcvd [49].payload_tuple_extd_value.push_back(payload_tuple_extd_value[49])    ;
                                end
                            end
                          else if (vLocalFromNoC[49].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [49] = vLocalFromNoC[49].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [49].payload_data.push_back (payload_data      [49])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[49].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [49] = vLocalFromNoC[49].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [49].payload_data.push_back (payload_data      [49])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[49].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[49].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 49, local_noc_pkt_rcvd [49].header_source);
                          noc2mgr_p [49].put(local_noc_pkt_rcvd [49]);
                          noc_rcvd_packet_complete[49] = 1;    
                        end
                      @(vLocalFromNoC[49].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 50
              @(vLocalFromNoC[50].cb_p);
              if ((vLocalFromNoC[50].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [50] = new();
                  noc_rcvd_packet_complete[50] = 0;    
                  while(~noc_rcvd_packet_complete[50])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 50);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[50].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[50].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [50].timeTag                     = $time;
                          local_noc_pkt_rcvd [50].header_destination_address  = vLocalFromNoC[50].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [50].header_source               = vLocalFromNoC[50].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [50].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[50].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[50].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [50] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [50] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [50] = vLocalFromNoC[50].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [50] = vLocalFromNoC[50].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [50].payload_tuple_type.push_back      (payload_tuple_type      [50])    ;
                              local_noc_pkt_rcvd [50].payload_tuple_extd_value.push_back(payload_tuple_extd_value[50])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[50].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [50] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [50] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [50] = vLocalFromNoC[50].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [50] = vLocalFromNoC[50].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [50].payload_tuple_type.push_back      (payload_tuple_type      [50])    ;
                                  local_noc_pkt_rcvd [50].payload_tuple_extd_value.push_back(payload_tuple_extd_value[50])    ;
                                end
                            end
                          else if (vLocalFromNoC[50].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [50] = vLocalFromNoC[50].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [50].payload_data.push_back (payload_data      [50])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[50].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [50] = vLocalFromNoC[50].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [50].payload_data.push_back (payload_data      [50])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[50].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[50].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 50, local_noc_pkt_rcvd [50].header_source);
                          noc2mgr_p [50].put(local_noc_pkt_rcvd [50]);
                          noc_rcvd_packet_complete[50] = 1;    
                        end
                      @(vLocalFromNoC[50].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 51
              @(vLocalFromNoC[51].cb_p);
              if ((vLocalFromNoC[51].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [51] = new();
                  noc_rcvd_packet_complete[51] = 0;    
                  while(~noc_rcvd_packet_complete[51])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 51);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[51].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[51].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [51].timeTag                     = $time;
                          local_noc_pkt_rcvd [51].header_destination_address  = vLocalFromNoC[51].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [51].header_source               = vLocalFromNoC[51].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [51].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[51].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[51].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [51] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [51] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [51] = vLocalFromNoC[51].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [51] = vLocalFromNoC[51].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [51].payload_tuple_type.push_back      (payload_tuple_type      [51])    ;
                              local_noc_pkt_rcvd [51].payload_tuple_extd_value.push_back(payload_tuple_extd_value[51])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[51].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [51] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [51] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [51] = vLocalFromNoC[51].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [51] = vLocalFromNoC[51].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [51].payload_tuple_type.push_back      (payload_tuple_type      [51])    ;
                                  local_noc_pkt_rcvd [51].payload_tuple_extd_value.push_back(payload_tuple_extd_value[51])    ;
                                end
                            end
                          else if (vLocalFromNoC[51].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [51] = vLocalFromNoC[51].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [51].payload_data.push_back (payload_data      [51])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[51].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [51] = vLocalFromNoC[51].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [51].payload_data.push_back (payload_data      [51])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[51].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[51].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 51, local_noc_pkt_rcvd [51].header_source);
                          noc2mgr_p [51].put(local_noc_pkt_rcvd [51]);
                          noc_rcvd_packet_complete[51] = 1;    
                        end
                      @(vLocalFromNoC[51].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 52
              @(vLocalFromNoC[52].cb_p);
              if ((vLocalFromNoC[52].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [52] = new();
                  noc_rcvd_packet_complete[52] = 0;    
                  while(~noc_rcvd_packet_complete[52])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 52);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[52].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[52].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [52].timeTag                     = $time;
                          local_noc_pkt_rcvd [52].header_destination_address  = vLocalFromNoC[52].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [52].header_source               = vLocalFromNoC[52].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [52].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[52].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[52].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [52] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [52] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [52] = vLocalFromNoC[52].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [52] = vLocalFromNoC[52].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [52].payload_tuple_type.push_back      (payload_tuple_type      [52])    ;
                              local_noc_pkt_rcvd [52].payload_tuple_extd_value.push_back(payload_tuple_extd_value[52])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[52].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [52] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [52] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [52] = vLocalFromNoC[52].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [52] = vLocalFromNoC[52].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [52].payload_tuple_type.push_back      (payload_tuple_type      [52])    ;
                                  local_noc_pkt_rcvd [52].payload_tuple_extd_value.push_back(payload_tuple_extd_value[52])    ;
                                end
                            end
                          else if (vLocalFromNoC[52].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [52] = vLocalFromNoC[52].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [52].payload_data.push_back (payload_data      [52])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[52].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [52] = vLocalFromNoC[52].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [52].payload_data.push_back (payload_data      [52])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[52].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[52].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 52, local_noc_pkt_rcvd [52].header_source);
                          noc2mgr_p [52].put(local_noc_pkt_rcvd [52]);
                          noc_rcvd_packet_complete[52] = 1;    
                        end
                      @(vLocalFromNoC[52].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 53
              @(vLocalFromNoC[53].cb_p);
              if ((vLocalFromNoC[53].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [53] = new();
                  noc_rcvd_packet_complete[53] = 0;    
                  while(~noc_rcvd_packet_complete[53])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 53);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[53].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[53].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [53].timeTag                     = $time;
                          local_noc_pkt_rcvd [53].header_destination_address  = vLocalFromNoC[53].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [53].header_source               = vLocalFromNoC[53].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [53].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[53].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[53].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [53] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [53] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [53] = vLocalFromNoC[53].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [53] = vLocalFromNoC[53].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [53].payload_tuple_type.push_back      (payload_tuple_type      [53])    ;
                              local_noc_pkt_rcvd [53].payload_tuple_extd_value.push_back(payload_tuple_extd_value[53])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[53].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [53] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [53] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [53] = vLocalFromNoC[53].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [53] = vLocalFromNoC[53].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [53].payload_tuple_type.push_back      (payload_tuple_type      [53])    ;
                                  local_noc_pkt_rcvd [53].payload_tuple_extd_value.push_back(payload_tuple_extd_value[53])    ;
                                end
                            end
                          else if (vLocalFromNoC[53].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [53] = vLocalFromNoC[53].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [53].payload_data.push_back (payload_data      [53])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[53].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [53] = vLocalFromNoC[53].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [53].payload_data.push_back (payload_data      [53])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[53].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[53].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 53, local_noc_pkt_rcvd [53].header_source);
                          noc2mgr_p [53].put(local_noc_pkt_rcvd [53]);
                          noc_rcvd_packet_complete[53] = 1;    
                        end
                      @(vLocalFromNoC[53].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 54
              @(vLocalFromNoC[54].cb_p);
              if ((vLocalFromNoC[54].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [54] = new();
                  noc_rcvd_packet_complete[54] = 0;    
                  while(~noc_rcvd_packet_complete[54])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 54);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[54].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[54].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [54].timeTag                     = $time;
                          local_noc_pkt_rcvd [54].header_destination_address  = vLocalFromNoC[54].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [54].header_source               = vLocalFromNoC[54].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [54].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[54].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[54].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [54] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [54] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [54] = vLocalFromNoC[54].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [54] = vLocalFromNoC[54].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [54].payload_tuple_type.push_back      (payload_tuple_type      [54])    ;
                              local_noc_pkt_rcvd [54].payload_tuple_extd_value.push_back(payload_tuple_extd_value[54])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[54].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [54] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [54] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [54] = vLocalFromNoC[54].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [54] = vLocalFromNoC[54].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [54].payload_tuple_type.push_back      (payload_tuple_type      [54])    ;
                                  local_noc_pkt_rcvd [54].payload_tuple_extd_value.push_back(payload_tuple_extd_value[54])    ;
                                end
                            end
                          else if (vLocalFromNoC[54].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [54] = vLocalFromNoC[54].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [54].payload_data.push_back (payload_data      [54])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[54].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [54] = vLocalFromNoC[54].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [54].payload_data.push_back (payload_data      [54])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[54].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[54].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 54, local_noc_pkt_rcvd [54].header_source);
                          noc2mgr_p [54].put(local_noc_pkt_rcvd [54]);
                          noc_rcvd_packet_complete[54] = 1;    
                        end
                      @(vLocalFromNoC[54].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 55
              @(vLocalFromNoC[55].cb_p);
              if ((vLocalFromNoC[55].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [55] = new();
                  noc_rcvd_packet_complete[55] = 0;    
                  while(~noc_rcvd_packet_complete[55])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 55);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[55].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[55].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [55].timeTag                     = $time;
                          local_noc_pkt_rcvd [55].header_destination_address  = vLocalFromNoC[55].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [55].header_source               = vLocalFromNoC[55].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [55].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[55].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[55].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [55] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [55] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [55] = vLocalFromNoC[55].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [55] = vLocalFromNoC[55].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [55].payload_tuple_type.push_back      (payload_tuple_type      [55])    ;
                              local_noc_pkt_rcvd [55].payload_tuple_extd_value.push_back(payload_tuple_extd_value[55])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[55].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [55] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [55] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [55] = vLocalFromNoC[55].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [55] = vLocalFromNoC[55].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [55].payload_tuple_type.push_back      (payload_tuple_type      [55])    ;
                                  local_noc_pkt_rcvd [55].payload_tuple_extd_value.push_back(payload_tuple_extd_value[55])    ;
                                end
                            end
                          else if (vLocalFromNoC[55].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [55] = vLocalFromNoC[55].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [55].payload_data.push_back (payload_data      [55])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[55].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [55] = vLocalFromNoC[55].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [55].payload_data.push_back (payload_data      [55])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[55].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[55].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 55, local_noc_pkt_rcvd [55].header_source);
                          noc2mgr_p [55].put(local_noc_pkt_rcvd [55]);
                          noc_rcvd_packet_complete[55] = 1;    
                        end
                      @(vLocalFromNoC[55].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 56
              @(vLocalFromNoC[56].cb_p);
              if ((vLocalFromNoC[56].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [56] = new();
                  noc_rcvd_packet_complete[56] = 0;    
                  while(~noc_rcvd_packet_complete[56])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 56);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[56].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[56].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [56].timeTag                     = $time;
                          local_noc_pkt_rcvd [56].header_destination_address  = vLocalFromNoC[56].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [56].header_source               = vLocalFromNoC[56].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [56].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[56].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[56].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [56] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [56] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [56] = vLocalFromNoC[56].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [56] = vLocalFromNoC[56].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [56].payload_tuple_type.push_back      (payload_tuple_type      [56])    ;
                              local_noc_pkt_rcvd [56].payload_tuple_extd_value.push_back(payload_tuple_extd_value[56])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[56].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [56] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [56] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [56] = vLocalFromNoC[56].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [56] = vLocalFromNoC[56].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [56].payload_tuple_type.push_back      (payload_tuple_type      [56])    ;
                                  local_noc_pkt_rcvd [56].payload_tuple_extd_value.push_back(payload_tuple_extd_value[56])    ;
                                end
                            end
                          else if (vLocalFromNoC[56].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [56] = vLocalFromNoC[56].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [56].payload_data.push_back (payload_data      [56])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[56].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [56] = vLocalFromNoC[56].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [56].payload_data.push_back (payload_data      [56])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[56].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[56].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 56, local_noc_pkt_rcvd [56].header_source);
                          noc2mgr_p [56].put(local_noc_pkt_rcvd [56]);
                          noc_rcvd_packet_complete[56] = 1;    
                        end
                      @(vLocalFromNoC[56].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 57
              @(vLocalFromNoC[57].cb_p);
              if ((vLocalFromNoC[57].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [57] = new();
                  noc_rcvd_packet_complete[57] = 0;    
                  while(~noc_rcvd_packet_complete[57])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 57);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[57].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[57].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [57].timeTag                     = $time;
                          local_noc_pkt_rcvd [57].header_destination_address  = vLocalFromNoC[57].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [57].header_source               = vLocalFromNoC[57].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [57].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[57].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[57].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [57] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [57] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [57] = vLocalFromNoC[57].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [57] = vLocalFromNoC[57].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [57].payload_tuple_type.push_back      (payload_tuple_type      [57])    ;
                              local_noc_pkt_rcvd [57].payload_tuple_extd_value.push_back(payload_tuple_extd_value[57])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[57].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [57] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [57] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [57] = vLocalFromNoC[57].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [57] = vLocalFromNoC[57].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [57].payload_tuple_type.push_back      (payload_tuple_type      [57])    ;
                                  local_noc_pkt_rcvd [57].payload_tuple_extd_value.push_back(payload_tuple_extd_value[57])    ;
                                end
                            end
                          else if (vLocalFromNoC[57].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [57] = vLocalFromNoC[57].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [57].payload_data.push_back (payload_data      [57])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[57].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [57] = vLocalFromNoC[57].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [57].payload_data.push_back (payload_data      [57])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[57].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[57].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 57, local_noc_pkt_rcvd [57].header_source);
                          noc2mgr_p [57].put(local_noc_pkt_rcvd [57]);
                          noc_rcvd_packet_complete[57] = 1;    
                        end
                      @(vLocalFromNoC[57].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 58
              @(vLocalFromNoC[58].cb_p);
              if ((vLocalFromNoC[58].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [58] = new();
                  noc_rcvd_packet_complete[58] = 0;    
                  while(~noc_rcvd_packet_complete[58])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 58);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[58].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[58].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [58].timeTag                     = $time;
                          local_noc_pkt_rcvd [58].header_destination_address  = vLocalFromNoC[58].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [58].header_source               = vLocalFromNoC[58].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [58].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[58].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[58].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [58] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [58] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [58] = vLocalFromNoC[58].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [58] = vLocalFromNoC[58].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [58].payload_tuple_type.push_back      (payload_tuple_type      [58])    ;
                              local_noc_pkt_rcvd [58].payload_tuple_extd_value.push_back(payload_tuple_extd_value[58])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[58].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [58] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [58] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [58] = vLocalFromNoC[58].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [58] = vLocalFromNoC[58].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [58].payload_tuple_type.push_back      (payload_tuple_type      [58])    ;
                                  local_noc_pkt_rcvd [58].payload_tuple_extd_value.push_back(payload_tuple_extd_value[58])    ;
                                end
                            end
                          else if (vLocalFromNoC[58].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [58] = vLocalFromNoC[58].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [58].payload_data.push_back (payload_data      [58])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[58].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [58] = vLocalFromNoC[58].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [58].payload_data.push_back (payload_data      [58])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[58].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[58].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 58, local_noc_pkt_rcvd [58].header_source);
                          noc2mgr_p [58].put(local_noc_pkt_rcvd [58]);
                          noc_rcvd_packet_complete[58] = 1;    
                        end
                      @(vLocalFromNoC[58].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 59
              @(vLocalFromNoC[59].cb_p);
              if ((vLocalFromNoC[59].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [59] = new();
                  noc_rcvd_packet_complete[59] = 0;    
                  while(~noc_rcvd_packet_complete[59])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 59);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[59].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[59].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [59].timeTag                     = $time;
                          local_noc_pkt_rcvd [59].header_destination_address  = vLocalFromNoC[59].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [59].header_source               = vLocalFromNoC[59].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [59].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[59].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[59].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [59] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [59] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [59] = vLocalFromNoC[59].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [59] = vLocalFromNoC[59].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [59].payload_tuple_type.push_back      (payload_tuple_type      [59])    ;
                              local_noc_pkt_rcvd [59].payload_tuple_extd_value.push_back(payload_tuple_extd_value[59])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[59].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [59] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [59] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [59] = vLocalFromNoC[59].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [59] = vLocalFromNoC[59].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [59].payload_tuple_type.push_back      (payload_tuple_type      [59])    ;
                                  local_noc_pkt_rcvd [59].payload_tuple_extd_value.push_back(payload_tuple_extd_value[59])    ;
                                end
                            end
                          else if (vLocalFromNoC[59].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [59] = vLocalFromNoC[59].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [59].payload_data.push_back (payload_data      [59])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[59].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [59] = vLocalFromNoC[59].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [59].payload_data.push_back (payload_data      [59])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[59].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[59].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 59, local_noc_pkt_rcvd [59].header_source);
                          noc2mgr_p [59].put(local_noc_pkt_rcvd [59]);
                          noc_rcvd_packet_complete[59] = 1;    
                        end
                      @(vLocalFromNoC[59].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 60
              @(vLocalFromNoC[60].cb_p);
              if ((vLocalFromNoC[60].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [60] = new();
                  noc_rcvd_packet_complete[60] = 0;    
                  while(~noc_rcvd_packet_complete[60])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 60);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[60].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[60].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [60].timeTag                     = $time;
                          local_noc_pkt_rcvd [60].header_destination_address  = vLocalFromNoC[60].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [60].header_source               = vLocalFromNoC[60].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [60].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[60].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[60].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [60] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [60] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [60] = vLocalFromNoC[60].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [60] = vLocalFromNoC[60].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [60].payload_tuple_type.push_back      (payload_tuple_type      [60])    ;
                              local_noc_pkt_rcvd [60].payload_tuple_extd_value.push_back(payload_tuple_extd_value[60])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[60].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [60] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [60] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [60] = vLocalFromNoC[60].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [60] = vLocalFromNoC[60].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [60].payload_tuple_type.push_back      (payload_tuple_type      [60])    ;
                                  local_noc_pkt_rcvd [60].payload_tuple_extd_value.push_back(payload_tuple_extd_value[60])    ;
                                end
                            end
                          else if (vLocalFromNoC[60].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [60] = vLocalFromNoC[60].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [60].payload_data.push_back (payload_data      [60])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[60].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [60] = vLocalFromNoC[60].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [60].payload_data.push_back (payload_data      [60])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[60].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[60].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 60, local_noc_pkt_rcvd [60].header_source);
                          noc2mgr_p [60].put(local_noc_pkt_rcvd [60]);
                          noc_rcvd_packet_complete[60] = 1;    
                        end
                      @(vLocalFromNoC[60].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 61
              @(vLocalFromNoC[61].cb_p);
              if ((vLocalFromNoC[61].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [61] = new();
                  noc_rcvd_packet_complete[61] = 0;    
                  while(~noc_rcvd_packet_complete[61])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 61);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[61].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[61].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [61].timeTag                     = $time;
                          local_noc_pkt_rcvd [61].header_destination_address  = vLocalFromNoC[61].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [61].header_source               = vLocalFromNoC[61].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [61].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[61].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[61].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [61] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [61] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [61] = vLocalFromNoC[61].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [61] = vLocalFromNoC[61].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [61].payload_tuple_type.push_back      (payload_tuple_type      [61])    ;
                              local_noc_pkt_rcvd [61].payload_tuple_extd_value.push_back(payload_tuple_extd_value[61])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[61].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [61] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [61] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [61] = vLocalFromNoC[61].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [61] = vLocalFromNoC[61].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [61].payload_tuple_type.push_back      (payload_tuple_type      [61])    ;
                                  local_noc_pkt_rcvd [61].payload_tuple_extd_value.push_back(payload_tuple_extd_value[61])    ;
                                end
                            end
                          else if (vLocalFromNoC[61].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [61] = vLocalFromNoC[61].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [61].payload_data.push_back (payload_data      [61])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[61].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [61] = vLocalFromNoC[61].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [61].payload_data.push_back (payload_data      [61])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[61].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[61].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 61, local_noc_pkt_rcvd [61].header_source);
                          noc2mgr_p [61].put(local_noc_pkt_rcvd [61]);
                          noc_rcvd_packet_complete[61] = 1;    
                        end
                      @(vLocalFromNoC[61].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 62
              @(vLocalFromNoC[62].cb_p);
              if ((vLocalFromNoC[62].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [62] = new();
                  noc_rcvd_packet_complete[62] = 0;    
                  while(~noc_rcvd_packet_complete[62])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 62);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[62].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[62].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [62].timeTag                     = $time;
                          local_noc_pkt_rcvd [62].header_destination_address  = vLocalFromNoC[62].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [62].header_source               = vLocalFromNoC[62].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [62].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[62].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[62].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [62] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [62] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [62] = vLocalFromNoC[62].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [62] = vLocalFromNoC[62].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [62].payload_tuple_type.push_back      (payload_tuple_type      [62])    ;
                              local_noc_pkt_rcvd [62].payload_tuple_extd_value.push_back(payload_tuple_extd_value[62])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[62].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [62] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [62] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [62] = vLocalFromNoC[62].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [62] = vLocalFromNoC[62].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [62].payload_tuple_type.push_back      (payload_tuple_type      [62])    ;
                                  local_noc_pkt_rcvd [62].payload_tuple_extd_value.push_back(payload_tuple_extd_value[62])    ;
                                end
                            end
                          else if (vLocalFromNoC[62].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [62] = vLocalFromNoC[62].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [62].payload_data.push_back (payload_data      [62])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[62].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [62] = vLocalFromNoC[62].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [62].payload_data.push_back (payload_data      [62])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[62].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[62].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 62, local_noc_pkt_rcvd [62].header_source);
                          noc2mgr_p [62].put(local_noc_pkt_rcvd [62]);
                          noc_rcvd_packet_complete[62] = 1;    
                        end
                      @(vLocalFromNoC[62].cb_p);
                    end  // while
                end
            end // forever
        end
    
        begin
          forever
            begin
              // Observe NoC packets received by manager 63
              @(vLocalFromNoC[63].cb_p);
              if ((vLocalFromNoC[63].noc__locl__dp_valid == 1'b1))
                begin
                  // Start of packet observed, create new noc packet object and start to fill the fields
                  local_noc_pkt_rcvd [63] = new();
                  noc_rcvd_packet_complete[63] = 0;    
                  while(~noc_rcvd_packet_complete[63])     
                    begin
                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {%0d}", $time, `__FILE__, `__LINE__, 63);
                      //------------------------------
                      // Examine the header 
                      if ((vLocalFromNoC[63].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[63].noc__locl__dp_cntl == 2'b01))  // start-of-packet
                        begin
                          local_noc_pkt_rcvd [63].timeTag                     = $time;
                          local_noc_pkt_rcvd [63].header_destination_address  = vLocalFromNoC[63].noc__locl__dp_data     ;
                          local_noc_pkt_rcvd [63].header_source               = vLocalFromNoC[63].noc__locl__dp_mgrId    ;
                          local_noc_pkt_rcvd [63].header_priority             = 1'b1                                   ;  // _dp is hi-priority
                        end
                      //------------------------------
                      // Examine the payload 
                      else 
                        begin
                          if ((vLocalFromNoC[63].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[63].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple 
                            begin
                              // Grab first tuple
                              //payload_tuple_type       [63] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                              //payload_tuple_extd_value [63] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                              payload_tuple_type       [63] = vLocalFromNoC[63].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;
                              payload_tuple_extd_value [63] = vLocalFromNoC[63].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;
                              local_noc_pkt_rcvd [63].payload_tuple_type.push_back      (payload_tuple_type      [63])    ;
                              local_noc_pkt_rcvd [63].payload_tuple_extd_value.push_back(payload_tuple_extd_value[63])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[63].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second tuple
                                  //payload_tuple_type       [63] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;
                                  //payload_tuple_extd_value [63] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;
                                  payload_tuple_type       [63] = vLocalFromNoC[63].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;
                                  payload_tuple_extd_value [63] = vLocalFromNoC[63].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;
                                  local_noc_pkt_rcvd [63].payload_tuple_type.push_back      (payload_tuple_type      [63])    ;
                                  local_noc_pkt_rcvd [63].payload_tuple_extd_value.push_back(payload_tuple_extd_value[63])    ;
                                end
                            end
                          else if (vLocalFromNoC[63].noc__locl__dp_valid == 1'b1) // payload is data 
                            begin
                              // Grab first data word
                              payload_data    [63] = vLocalFromNoC[63].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;
                              local_noc_pkt_rcvd [63].payload_data.push_back (payload_data      [63])    ;
                              // check if both tuples are valid
                              if (vLocalFromNoC[63].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple 
                                begin
                                  // Grab second data word
                                  payload_data    [63] = vLocalFromNoC[63].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;
                                  local_noc_pkt_rcvd [63].payload_data.push_back (payload_data      [63])    ;
                                end
                            end
                        end
                      //------------------------------
                      // Check if this is the end of the packet
                      if ((vLocalFromNoC[63].noc__locl__dp_valid == 1'b1) && (vLocalFromNoC[63].noc__locl__dp_cntl == 2'b10)) // end of packet
                        begin
                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet
                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {%0d} from {%0d}", $time, `__FILE__, `__LINE__, 63, local_noc_pkt_rcvd [63].header_source);
                          noc2mgr_p [63].put(local_noc_pkt_rcvd [63]);
                          noc_rcvd_packet_complete[63] = 1;    
                        end
                      @(vLocalFromNoC[63].cb_p);
                    end  // while
                end
            end // forever
        end
    