
  //--------------------------------------------------
  // Outgoing requests to all ports
 
  // Local output queue requests goes to all output ports
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].local_OutqReq          = local_destinationReq & |(local_destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)    ;
 
  // Local output queue requests goes to all output ports
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].local_OutqReq          = local_destinationReq & |(local_destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)    ;
 
  // Local output queue requests goes to all output ports
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].local_OutqReq          = local_destinationReq & |(local_destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)    ;
 
  // Local output queue requests goes to all output ports
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].local_OutqReq          = local_destinationReq & |(local_destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)    ;
 
 
  // Remember, a packet coming in a port can be output the same port as some are not symmetrical
  // Connect Port 0's port requests to all other ports (including its own input port)
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].src0_OutqReq          = Port_from_NoC_Control[0].destinationReq & |(Port_from_NoC_Control[0].destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].src1_OutqReq          = Port_from_NoC_Control[1].destinationReq & |(Port_from_NoC_Control[1].destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].src2_OutqReq          = Port_from_NoC_Control[2].destinationReq & |(Port_from_NoC_Control[2].destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[0].src3_OutqReq          = Port_from_NoC_Control[3].destinationReq & |(Port_from_NoC_Control[3].destinationReqAddr & Port_to_NoC[0].thisPort_destinationMask)   ;
 
  // Remember, a packet coming in a port can be output the same port as some are not symmetrical
  // Connect Port 1's port requests to all other ports (including its own input port)
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].src0_OutqReq          = Port_from_NoC_Control[0].destinationReq & |(Port_from_NoC_Control[0].destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].src1_OutqReq          = Port_from_NoC_Control[1].destinationReq & |(Port_from_NoC_Control[1].destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].src2_OutqReq          = Port_from_NoC_Control[2].destinationReq & |(Port_from_NoC_Control[2].destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[1].src3_OutqReq          = Port_from_NoC_Control[3].destinationReq & |(Port_from_NoC_Control[3].destinationReqAddr & Port_to_NoC[1].thisPort_destinationMask)   ;
 
  // Remember, a packet coming in a port can be output the same port as some are not symmetrical
  // Connect Port 2's port requests to all other ports (including its own input port)
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].src0_OutqReq          = Port_from_NoC_Control[0].destinationReq & |(Port_from_NoC_Control[0].destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].src1_OutqReq          = Port_from_NoC_Control[1].destinationReq & |(Port_from_NoC_Control[1].destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].src2_OutqReq          = Port_from_NoC_Control[2].destinationReq & |(Port_from_NoC_Control[2].destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[2].src3_OutqReq          = Port_from_NoC_Control[3].destinationReq & |(Port_from_NoC_Control[3].destinationReqAddr & Port_to_NoC[2].thisPort_destinationMask)   ;
 
  // Remember, a packet coming in a port can be output the same port as some are not symmetrical
  // Connect Port 3's port requests to all other ports (including its own input port)
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].src0_OutqReq          = Port_from_NoC_Control[0].destinationReq & |(Port_from_NoC_Control[0].destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].src1_OutqReq          = Port_from_NoC_Control[1].destinationReq & |(Port_from_NoC_Control[1].destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].src2_OutqReq          = Port_from_NoC_Control[2].destinationReq & |(Port_from_NoC_Control[2].destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)   ;
  // Use destination mask to determine if this request goes out this port
  assign Port_to_NoC[3].src3_OutqReq          = Port_from_NoC_Control[3].destinationReq & |(Port_from_NoC_Control[3].destinationReqAddr & Port_to_NoC[3].thisPort_destinationMask)   ;
 
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
  assign Port_from_NoC_Control[0].destinationAck[0]     =  local_port0_OutqAck     ;
  assign Port_from_NoC_Control[0].destinationReady[0]   =  local_port0_OutqReady   ;
  // Connect Port 0's "other" ports ack's to bits 1,2,3 of the ack vector
  assign Port_from_NoC_Control[0].destinationAck[1]     =  Port_to_NoC[0].src0_OutqAck     ;
  assign Port_from_NoC_Control[0].destinationReady[1]   =  Port_to_NoC[0].src0_OutqReady   ;
  assign Port_from_NoC_Control[0].destinationAck[2]     =  Port_to_NoC[1].src0_OutqAck     ;
  assign Port_from_NoC_Control[0].destinationReady[2]   =  Port_to_NoC[1].src0_OutqReady   ;
  assign Port_from_NoC_Control[0].destinationAck[3]     =  Port_to_NoC[2].src0_OutqAck     ;
  assign Port_from_NoC_Control[0].destinationReady[3]   =  Port_to_NoC[2].src0_OutqReady   ;
  assign Port_from_NoC_Control[0].destinationAck[4]     =  Port_to_NoC[3].src0_OutqAck     ;
  assign Port_from_NoC_Control[0].destinationReady[4]   =  Port_to_NoC[3].src0_OutqReady   ;
 
  // Connect Port 1's ack from the local input queue to bit 0 of the ack vector
  // The local input queue is the first destination for each ports input controller
  // The other ports are the next 3 destinations for each ports input controller
  assign Port_from_NoC_Control[1].destinationAck[0]     =  local_port1_OutqAck     ;
  assign Port_from_NoC_Control[1].destinationReady[0]   =  local_port1_OutqReady   ;
  // Connect Port 1's "other" ports ack's to bits 1,2,3 of the ack vector
  assign Port_from_NoC_Control[1].destinationAck[1]     =  Port_to_NoC[0].src1_OutqAck     ;
  assign Port_from_NoC_Control[1].destinationReady[1]   =  Port_to_NoC[0].src1_OutqReady   ;
  assign Port_from_NoC_Control[1].destinationAck[2]     =  Port_to_NoC[1].src1_OutqAck     ;
  assign Port_from_NoC_Control[1].destinationReady[2]   =  Port_to_NoC[1].src1_OutqReady   ;
  assign Port_from_NoC_Control[1].destinationAck[3]     =  Port_to_NoC[2].src1_OutqAck     ;
  assign Port_from_NoC_Control[1].destinationReady[3]   =  Port_to_NoC[2].src1_OutqReady   ;
  assign Port_from_NoC_Control[1].destinationAck[4]     =  Port_to_NoC[3].src1_OutqAck     ;
  assign Port_from_NoC_Control[1].destinationReady[4]   =  Port_to_NoC[3].src1_OutqReady   ;
 
  // Connect Port 2's ack from the local input queue to bit 0 of the ack vector
  // The local input queue is the first destination for each ports input controller
  // The other ports are the next 3 destinations for each ports input controller
  assign Port_from_NoC_Control[2].destinationAck[0]     =  local_port2_OutqAck     ;
  assign Port_from_NoC_Control[2].destinationReady[0]   =  local_port2_OutqReady   ;
  // Connect Port 2's "other" ports ack's to bits 1,2,3 of the ack vector
  assign Port_from_NoC_Control[2].destinationAck[1]     =  Port_to_NoC[0].src2_OutqAck     ;
  assign Port_from_NoC_Control[2].destinationReady[1]   =  Port_to_NoC[0].src2_OutqReady   ;
  assign Port_from_NoC_Control[2].destinationAck[2]     =  Port_to_NoC[1].src2_OutqAck     ;
  assign Port_from_NoC_Control[2].destinationReady[2]   =  Port_to_NoC[1].src2_OutqReady   ;
  assign Port_from_NoC_Control[2].destinationAck[3]     =  Port_to_NoC[2].src2_OutqAck     ;
  assign Port_from_NoC_Control[2].destinationReady[3]   =  Port_to_NoC[2].src2_OutqReady   ;
  assign Port_from_NoC_Control[2].destinationAck[4]     =  Port_to_NoC[3].src2_OutqAck     ;
  assign Port_from_NoC_Control[2].destinationReady[4]   =  Port_to_NoC[3].src2_OutqReady   ;
 
  // Connect Port 3's ack from the local input queue to bit 0 of the ack vector
  // The local input queue is the first destination for each ports input controller
  // The other ports are the next 3 destinations for each ports input controller
  assign Port_from_NoC_Control[3].destinationAck[0]     =  local_port3_OutqAck     ;
  assign Port_from_NoC_Control[3].destinationReady[0]   =  local_port3_OutqReady   ;
  // Connect Port 3's "other" ports ack's to bits 1,2,3 of the ack vector
  assign Port_from_NoC_Control[3].destinationAck[1]     =  Port_to_NoC[0].src3_OutqAck     ;
  assign Port_from_NoC_Control[3].destinationReady[1]   =  Port_to_NoC[0].src3_OutqReady   ;
  assign Port_from_NoC_Control[3].destinationAck[2]     =  Port_to_NoC[1].src3_OutqAck     ;
  assign Port_from_NoC_Control[3].destinationReady[2]   =  Port_to_NoC[1].src3_OutqReady   ;
  assign Port_from_NoC_Control[3].destinationAck[3]     =  Port_to_NoC[2].src3_OutqAck     ;
  assign Port_from_NoC_Control[3].destinationReady[3]   =  Port_to_NoC[2].src3_OutqReady   ;
  assign Port_from_NoC_Control[3].destinationAck[4]     =  Port_to_NoC[3].src3_OutqAck     ;
  assign Port_from_NoC_Control[3].destinationReady[4]   =  Port_to_NoC[3].src3_OutqReady   ;
 
  //---------------------------------------------------
  // Flag indicating one or more ports is transferring from a port
  // This is to ensure that if an output port has accepted a request and another output
  // port is finishing a transfer, that the finishing port accepts the port others are waiting for
 
  assign inputPort_acceptedByOutputValid[0] = (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0) | 
                                              (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0) | 
                                              (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0) | 
                                              (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0) | 
                                              (nc_local_inq_cntl_state            == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0    ) ; 
 
  assign inputPort_acceptedByOutputValid[1] = (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1) | 
                                              (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1) | 
                                              (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1) | 
                                              (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1) | 
                                              (nc_local_inq_cntl_state            == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1    ) ; 
 
  assign inputPort_acceptedByOutputValid[2] = (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2) | 
                                              (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2) | 
                                              (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2) | 
                                              (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2) | 
                                              (nc_local_inq_cntl_state            == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2    ) ; 
 
  assign inputPort_acceptedByOutputValid[3] = (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3) | 
                                              (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3) | 
                                              (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3) | 
                                              (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3) | 
                                              (nc_local_inq_cntl_state            == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3    ) ; 
 
  assign inputPort_acceptedByOutput [0] [0] =  (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0) ; 
  assign inputPort_acceptedByOutput [0] [1] =  (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0) ; 
  assign inputPort_acceptedByOutput [0] [2] =  (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0) ; 
  assign inputPort_acceptedByOutput [0] [3] =  (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0) ; 
  assign inputPort_acceptedByOutput [0] [4] =  (nc_local_inq_cntl_state            == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0    ) ; 
 
  assign inputPort_acceptedByOutput [1] [0] =  (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1) ; 
  assign inputPort_acceptedByOutput [1] [1] =  (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1) ; 
  assign inputPort_acceptedByOutput [1] [2] =  (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1) ; 
  assign inputPort_acceptedByOutput [1] [3] =  (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1) ; 
  assign inputPort_acceptedByOutput [1] [4] =  (nc_local_inq_cntl_state            == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1    ) ; 
 
  assign inputPort_acceptedByOutput [2] [0] =  (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2) ; 
  assign inputPort_acceptedByOutput [2] [1] =  (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2) ; 
  assign inputPort_acceptedByOutput [2] [2] =  (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2) ; 
  assign inputPort_acceptedByOutput [2] [3] =  (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2) ; 
  assign inputPort_acceptedByOutput [2] [4] =  (nc_local_inq_cntl_state            == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2    ) ; 
 
  assign inputPort_acceptedByOutput [3] [0] =  (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3) ; 
  assign inputPort_acceptedByOutput [3] [1] =  (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3) ; 
  assign inputPort_acceptedByOutput [3] [2] =  (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3) ; 
  assign inputPort_acceptedByOutput [3] [3] =  (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3) ; 
  assign inputPort_acceptedByOutput [3] [4] =  (nc_local_inq_cntl_state            == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3    ) ; 
 
  assign localPort_acceptedByOutputValid =  (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL) | 
                                            (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL) | 
                                            (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL) | 
                                            (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL) ; 
 
  assign localPort_acceptedByOutput [0]  =  (Port_to_NoC[0].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL) ; 
  assign localPort_acceptedByOutput [1]  =  (Port_to_NoC[1].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL) ; 
  assign localPort_acceptedByOutput [2]  =  (Port_to_NoC[2].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL) ; 
  assign localPort_acceptedByOutput [3]  =  (Port_to_NoC[3].nc_port_toNoc_state == `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL) ; 
 