
  // Hard-code which nodes can be accessed via this output port
  assign Port_to_NoC[0].thisPort_destinationMask = sys__pe__port0_destinationMask ; // bitmask indicating which nodes accessed out of this port
  assign Port_to_NoC[1].thisPort_destinationMask = sys__pe__port1_destinationMask ; // bitmask indicating which nodes accessed out of this port
  assign Port_to_NoC[2].thisPort_destinationMask = sys__pe__port2_destinationMask ; // bitmask indicating which nodes accessed out of this port
  assign Port_to_NoC[3].thisPort_destinationMask = sys__pe__port3_destinationMask ; // bitmask indicating which nodes accessed out of this port
  //--------------------------------------------------
  // Outgoing requests to all ports
 
  // Local output queue requests goes to all output ports
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].local_OutqReq          = local_destinationReq & |(local_destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)    ;
  assign Port_to_NoC[0].local_OutqReqAddr      = local_destinationReqAddr ;
 
  // Local output queue requests goes to all output ports
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].local_OutqReq          = local_destinationReq & |(local_destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)    ;
  assign Port_to_NoC[1].local_OutqReqAddr      = local_destinationReqAddr ;
 
  // Local output queue requests goes to all output ports
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].local_OutqReq          = local_destinationReq & |(local_destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)    ;
  assign Port_to_NoC[2].local_OutqReqAddr      = local_destinationReqAddr ;
 
  // Local output queue requests goes to all output ports
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].local_OutqReq          = local_destinationReq & |(local_destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)    ;
  assign Port_to_NoC[3].local_OutqReqAddr      = local_destinationReqAddr ;
 
 
  // Remember, a packet coming in a port can be output the same port as some are not symmetrical
  // Connect Port 0's port requests to all other ports (including its own input port)
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].src0_OutqReq          = Port_from_NoC[0].destinationReq & |(Port_from_NoC[0].destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)   ;
  assign Port_to_NoC[0].src0_OutqReqAddr      = Port_from_NoC[0].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].src1_OutqReq          = Port_from_NoC[1].destinationReq & |(Port_from_NoC[1].destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)   ;
  assign Port_to_NoC[0].src1_OutqReqAddr      = Port_from_NoC[1].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].src2_OutqReq          = Port_from_NoC[2].destinationReq & |(Port_from_NoC[2].destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)   ;
  assign Port_to_NoC[0].src2_OutqReqAddr      = Port_from_NoC[2].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].src3_OutqReq          = Port_from_NoC[3].destinationReq & |(Port_from_NoC[3].destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)   ;
  assign Port_to_NoC[0].src3_OutqReqAddr      = Port_from_NoC[3].destinationReqAddr ;
 
  // Remember, a packet coming in a port can be output the same port as some are not symmetrical
  // Connect Port 1's port requests to all other ports (including its own input port)
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].src0_OutqReq          = Port_from_NoC[0].destinationReq & |(Port_from_NoC[0].destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)   ;
  assign Port_to_NoC[1].src0_OutqReqAddr      = Port_from_NoC[0].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].src1_OutqReq          = Port_from_NoC[1].destinationReq & |(Port_from_NoC[1].destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)   ;
  assign Port_to_NoC[1].src1_OutqReqAddr      = Port_from_NoC[1].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].src2_OutqReq          = Port_from_NoC[2].destinationReq & |(Port_from_NoC[2].destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)   ;
  assign Port_to_NoC[1].src2_OutqReqAddr      = Port_from_NoC[2].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].src3_OutqReq          = Port_from_NoC[3].destinationReq & |(Port_from_NoC[3].destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)   ;
  assign Port_to_NoC[1].src3_OutqReqAddr      = Port_from_NoC[3].destinationReqAddr ;
 
  // Remember, a packet coming in a port can be output the same port as some are not symmetrical
  // Connect Port 2's port requests to all other ports (including its own input port)
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].src0_OutqReq          = Port_from_NoC[0].destinationReq & |(Port_from_NoC[0].destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)   ;
  assign Port_to_NoC[2].src0_OutqReqAddr      = Port_from_NoC[0].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].src1_OutqReq          = Port_from_NoC[1].destinationReq & |(Port_from_NoC[1].destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)   ;
  assign Port_to_NoC[2].src1_OutqReqAddr      = Port_from_NoC[1].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].src2_OutqReq          = Port_from_NoC[2].destinationReq & |(Port_from_NoC[2].destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)   ;
  assign Port_to_NoC[2].src2_OutqReqAddr      = Port_from_NoC[2].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].src3_OutqReq          = Port_from_NoC[3].destinationReq & |(Port_from_NoC[3].destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)   ;
  assign Port_to_NoC[2].src3_OutqReqAddr      = Port_from_NoC[3].destinationReqAddr ;
 
  // Remember, a packet coming in a port can be output the same port as some are not symmetrical
  // Connect Port 3's port requests to all other ports (including its own input port)
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].src0_OutqReq          = Port_from_NoC[0].destinationReq & |(Port_from_NoC[0].destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)   ;
  assign Port_to_NoC[3].src0_OutqReqAddr      = Port_from_NoC[0].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].src1_OutqReq          = Port_from_NoC[1].destinationReq & |(Port_from_NoC[1].destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)   ;
  assign Port_to_NoC[3].src1_OutqReqAddr      = Port_from_NoC[1].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].src2_OutqReq          = Port_from_NoC[2].destinationReq & |(Port_from_NoC[2].destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)   ;
  assign Port_to_NoC[3].src2_OutqReqAddr      = Port_from_NoC[2].destinationReqAddr ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].src3_OutqReq          = Port_from_NoC[3].destinationReq & |(Port_from_NoC[3].destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)   ;
  assign Port_to_NoC[3].src3_OutqReqAddr      = Port_from_NoC[3].destinationReqAddr ;
 
  //---------------------------------------------------
  // Outgoing Port acknowledge back to requesting ports
 
  // Local output queue requests goes to all output ports
  assign local_destinationAck[0]    =  Port_to_NoC[0].local_OutqAck    ;
  assign local_destinationReady[0]  =  Port_to_NoC[0].local_OutqReady  ;
 
  // Local output queue requests goes to all output ports
  assign local_destinationAck[1]    =  Port_to_NoC[1].local_OutqAck    ;
  assign local_destinationReady[1]  =  Port_to_NoC[1].local_OutqReady  ;
 
  // Local output queue requests goes to all output ports
  assign local_destinationAck[2]    =  Port_to_NoC[2].local_OutqAck    ;
  assign local_destinationReady[2]  =  Port_to_NoC[2].local_OutqReady  ;
 
  // Local output queue requests goes to all output ports
  assign local_destinationAck[3]    =  Port_to_NoC[3].local_OutqAck    ;
  assign local_destinationReady[3]  =  Port_to_NoC[3].local_OutqReady  ;
 
 
  // Connect Port 0's ack from the local input queue to bit 0 of the ack vector
  // The local input queue is the first destination for each ports input controller
  // The other ports are the next 3 destinations for each ports input controller
  assign Port_from_NoC[0].destinationAck[0]     =  local_port0_OutqAck     ;
  assign Port_from_NoC[0].destinationReady[0]   =  local_port0_OutqReady   ;
  // Connect Port 0's "other" ports ack's to bits 1,2,3 of the ack vector
  assign Port_from_NoC[0].destinationAck[1]     =  Port_to_NoC[0].src0_OutqAck     ;
  assign Port_from_NoC[0].destinationReady[1]   =  Port_to_NoC[0].src0_OutqReady   ;
  assign Port_from_NoC[0].destinationAck[2]     =  Port_to_NoC[1].src0_OutqAck     ;
  assign Port_from_NoC[0].destinationReady[2]   =  Port_to_NoC[1].src0_OutqReady   ;
  assign Port_from_NoC[0].destinationAck[3]     =  Port_to_NoC[2].src0_OutqAck     ;
  assign Port_from_NoC[0].destinationReady[3]   =  Port_to_NoC[2].src0_OutqReady   ;
  assign Port_from_NoC[0].destinationAck[4]     =  Port_to_NoC[3].src0_OutqAck     ;
  assign Port_from_NoC[0].destinationReady[4]   =  Port_to_NoC[3].src0_OutqReady   ;
 
  // Connect Port 1's ack from the local input queue to bit 0 of the ack vector
  // The local input queue is the first destination for each ports input controller
  // The other ports are the next 3 destinations for each ports input controller
  assign Port_from_NoC[1].destinationAck[0]     =  local_port1_OutqAck     ;
  assign Port_from_NoC[1].destinationReady[0]   =  local_port1_OutqReady   ;
  // Connect Port 1's "other" ports ack's to bits 1,2,3 of the ack vector
  assign Port_from_NoC[1].destinationAck[1]     =  Port_to_NoC[0].src1_OutqAck     ;
  assign Port_from_NoC[1].destinationReady[1]   =  Port_to_NoC[0].src1_OutqReady   ;
  assign Port_from_NoC[1].destinationAck[2]     =  Port_to_NoC[1].src1_OutqAck     ;
  assign Port_from_NoC[1].destinationReady[2]   =  Port_to_NoC[1].src1_OutqReady   ;
  assign Port_from_NoC[1].destinationAck[3]     =  Port_to_NoC[2].src1_OutqAck     ;
  assign Port_from_NoC[1].destinationReady[3]   =  Port_to_NoC[2].src1_OutqReady   ;
  assign Port_from_NoC[1].destinationAck[4]     =  Port_to_NoC[3].src1_OutqAck     ;
  assign Port_from_NoC[1].destinationReady[4]   =  Port_to_NoC[3].src1_OutqReady   ;
 
  // Connect Port 2's ack from the local input queue to bit 0 of the ack vector
  // The local input queue is the first destination for each ports input controller
  // The other ports are the next 3 destinations for each ports input controller
  assign Port_from_NoC[2].destinationAck[0]     =  local_port2_OutqAck     ;
  assign Port_from_NoC[2].destinationReady[0]   =  local_port2_OutqReady   ;
  // Connect Port 2's "other" ports ack's to bits 1,2,3 of the ack vector
  assign Port_from_NoC[2].destinationAck[1]     =  Port_to_NoC[0].src2_OutqAck     ;
  assign Port_from_NoC[2].destinationReady[1]   =  Port_to_NoC[0].src2_OutqReady   ;
  assign Port_from_NoC[2].destinationAck[2]     =  Port_to_NoC[1].src2_OutqAck     ;
  assign Port_from_NoC[2].destinationReady[2]   =  Port_to_NoC[1].src2_OutqReady   ;
  assign Port_from_NoC[2].destinationAck[3]     =  Port_to_NoC[2].src2_OutqAck     ;
  assign Port_from_NoC[2].destinationReady[3]   =  Port_to_NoC[2].src2_OutqReady   ;
  assign Port_from_NoC[2].destinationAck[4]     =  Port_to_NoC[3].src2_OutqAck     ;
  assign Port_from_NoC[2].destinationReady[4]   =  Port_to_NoC[3].src2_OutqReady   ;
 
  // Connect Port 3's ack from the local input queue to bit 0 of the ack vector
  // The local input queue is the first destination for each ports input controller
  // The other ports are the next 3 destinations for each ports input controller
  assign Port_from_NoC[3].destinationAck[0]     =  local_port3_OutqAck     ;
  assign Port_from_NoC[3].destinationReady[0]   =  local_port3_OutqReady   ;
  // Connect Port 3's "other" ports ack's to bits 1,2,3 of the ack vector
  assign Port_from_NoC[3].destinationAck[1]     =  Port_to_NoC[0].src3_OutqAck     ;
  assign Port_from_NoC[3].destinationReady[1]   =  Port_to_NoC[0].src3_OutqReady   ;
  assign Port_from_NoC[3].destinationAck[2]     =  Port_to_NoC[1].src3_OutqAck     ;
  assign Port_from_NoC[3].destinationReady[2]   =  Port_to_NoC[1].src3_OutqReady   ;
  assign Port_from_NoC[3].destinationAck[3]     =  Port_to_NoC[2].src3_OutqAck     ;
  assign Port_from_NoC[3].destinationReady[3]   =  Port_to_NoC[2].src3_OutqReady   ;
  assign Port_from_NoC[3].destinationAck[4]     =  Port_to_NoC[3].src3_OutqAck     ;
  assign Port_from_NoC[3].destinationReady[4]   =  Port_to_NoC[3].src3_OutqReady   ;
 
  //---------------------------------------------------
  // Outgoing Port source data 
 
  // Connect Port 0's "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
 
  // Port0, source0
  assign Port_to_NoC[0].src0_cntl_toNoc          = Port_from_NoC[0].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[0].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[0].src0_toNoc_valid                                                          = Port_from_NoC[0].fromNoc_valid ;
 
  // Port0, source1
  assign Port_to_NoC[0].src1_cntl_toNoc          = Port_from_NoC[1].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[1].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[0].src1_toNoc_valid                                                          = Port_from_NoC[1].fromNoc_valid ;
 
  // Port0, source2
  assign Port_to_NoC[0].src2_cntl_toNoc          = Port_from_NoC[2].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[2].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[0].src2_toNoc_valid                                                          = Port_from_NoC[2].fromNoc_valid ;
 
  // Port0, source3
  assign Port_to_NoC[0].src3_cntl_toNoc          = Port_from_NoC[3].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[3].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[0].src3_toNoc_valid                                                          = Port_from_NoC[3].fromNoc_valid ;
 
 
  // Connect Port 1's "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
 
  // Port1, source0
  assign Port_to_NoC[1].src0_cntl_toNoc          = Port_from_NoC[0].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[0].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[1].src0_toNoc_valid                                                          = Port_from_NoC[0].fromNoc_valid ;
 
  // Port1, source1
  assign Port_to_NoC[1].src1_cntl_toNoc          = Port_from_NoC[1].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[1].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[1].src1_toNoc_valid                                                          = Port_from_NoC[1].fromNoc_valid ;
 
  // Port1, source2
  assign Port_to_NoC[1].src2_cntl_toNoc          = Port_from_NoC[2].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[2].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[1].src2_toNoc_valid                                                          = Port_from_NoC[2].fromNoc_valid ;
 
  // Port1, source3
  assign Port_to_NoC[1].src3_cntl_toNoc          = Port_from_NoC[3].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[3].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[1].src3_toNoc_valid                                                          = Port_from_NoC[3].fromNoc_valid ;
 
 
  // Connect Port 2's "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
 
  // Port2, source0
  assign Port_to_NoC[2].src0_cntl_toNoc          = Port_from_NoC[0].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[0].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[2].src0_toNoc_valid                                                          = Port_from_NoC[0].fromNoc_valid ;
 
  // Port2, source1
  assign Port_to_NoC[2].src1_cntl_toNoc          = Port_from_NoC[1].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[1].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[2].src1_toNoc_valid                                                          = Port_from_NoC[1].fromNoc_valid ;
 
  // Port2, source2
  assign Port_to_NoC[2].src2_cntl_toNoc          = Port_from_NoC[2].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[2].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[2].src2_toNoc_valid                                                          = Port_from_NoC[2].fromNoc_valid ;
 
  // Port2, source3
  assign Port_to_NoC[2].src3_cntl_toNoc          = Port_from_NoC[3].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[3].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[2].src3_toNoc_valid                                                          = Port_from_NoC[3].fromNoc_valid ;
 
 
  // Connect Port 3's "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
 
  // Port3, source0
  assign Port_to_NoC[3].src0_cntl_toNoc          = Port_from_NoC[0].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[0].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[3].src0_toNoc_valid                                                          = Port_from_NoC[0].fromNoc_valid ;
 
  // Port3, source1
  assign Port_to_NoC[3].src1_cntl_toNoc          = Port_from_NoC[1].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[1].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[3].src1_toNoc_valid                                                          = Port_from_NoC[1].fromNoc_valid ;
 
  // Port3, source2
  assign Port_to_NoC[3].src2_cntl_toNoc          = Port_from_NoC[2].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[2].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[3].src2_toNoc_valid                                                          = Port_from_NoC[2].fromNoc_valid ;
 
  // Port3, source3
  assign Port_to_NoC[3].src3_cntl_toNoc          = Port_from_NoC[3].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[3].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[3].src3_toNoc_valid                                                          = Port_from_NoC[3].fromNoc_valid ;
 
 
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

