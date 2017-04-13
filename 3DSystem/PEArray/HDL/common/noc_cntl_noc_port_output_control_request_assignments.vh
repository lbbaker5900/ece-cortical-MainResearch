
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
 