#! /usr/bin/env python

if __name__ == "__main__":

  import sys
  import os
  import math
  import random
  import re

  # extract number of pe's
  FoundPe = False
  searchFile = open("../HDL/common/pe_array.vh", "r")
  for line in searchFile:
    if FoundPe == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_ARRAY_NUM_OF_PE" in data[1]:
        numOfPe = int(data[2])
        FoundPe = True
  searchFile.close()

  # Now extract number of noc ports
  FoundPorts = False
  searchFile = open("../HDL/common/noc_cntl.vh", "r")
  for line in searchFile:
    if FoundPorts == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "NOC_CONT_NOC_NUM_OF_PORTS" in data[1]:
        numOfPorts = int(data[2])
        FoundPorts = True
  searchFile.close()

  f = open('../HDL/common/noc_cntl_noc_ports.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n            // NoC port {0}'.format(port)
    pLine = pLine + '\n            pe__noc__port{0}_valid            ,'.format(port)
    pLine = pLine + '\n            pe__noc__port{0}_cntl             ,'.format(port)
    pLine = pLine + '\n            pe__noc__port{0}_data             ,'.format(port)
    pLine = pLine + '\n            noc__pe__port{0}_fc               ,'.format(port)
    pLine = pLine + '\n            noc__pe__port{0}_valid            ,'.format(port)
    pLine = pLine + '\n            noc__pe__port{0}_cntl             ,'.format(port)
    pLine = pLine + '\n            noc__pe__port{0}_data             ,'.format(port)
    pLine = pLine + '\n            pe__noc__port{0}_fc               ,'.format(port)
    pLine = pLine + '\n            sys__pe__port{0}_destinationMask  ,'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/noc_cntl_noc_ports_declaration.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  output                                   pe__noc__port{0}_valid           ;'.format(port)
    pLine = pLine + '\n  output [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  pe__noc__port{0}_cntl            ;'.format(port)
    pLine = pLine + '\n  output [`NOC_CONT_NOC_PORT_DATA_RANGE ]  pe__noc__port{0}_data            ;'.format(port)
    pLine = pLine + '\n  input                                    noc__pe__port{0}_fc              ;'.format(port)
    pLine = pLine + '\n  input                                    noc__pe__port{0}_valid           ;'.format(port)
    pLine = pLine + '\n  input  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  noc__pe__port{0}_cntl            ;'.format(port)
    pLine = pLine + '\n  input  [`NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__pe__port{0}_data            ;'.format(port)
    pLine = pLine + '\n  output                                   pe__noc__port{0}_fc              ;'.format(port)
    pLine = pLine + '\n  input  [`PE_PE_ID_BITMASK_RANGE       ]  sys__pe__port{0}_destinationMask ;'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/noc_cntl_noc_ports_wires.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  reg                                      pe__noc__port{0}_valid           ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  pe__noc__port{0}_cntl            ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_DATA_RANGE ]  pe__noc__port{0}_data            ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__pe__port{0}_fc              ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__pe__port{0}_valid           ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  noc__pe__port{0}_cntl            ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__pe__port{0}_data            ;'.format(port)
    pLine = pLine + '\n  wire                                     pe__noc__port{0}_fc              ;'.format(port)
    pLine = pLine + '\n  wire   [`PE_PE_ID_BITMASK_RANGE       ]  sys__pe__port{0}_destinationMask ;'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe__noc_to_peArray_connection_wires.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  wire                                     pe__noc__port{0}_valid ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  pe__noc__port{0}_cntl  ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_DATA_RANGE ]  pe__noc__port{0}_data  ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__pe__port{0}_fc    ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__pe__port{0}_valid ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  noc__pe__port{0}_cntl  ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__pe__port{0}_data  ;'.format(port)
    pLine = pLine + '\n  wire                                     pe__noc__port{0}_fc    ;'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/noc_cntl_noc_ports_instance_ports.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_valid           ( pe__noc__port{0}_valid           ),'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_cntl            ( pe__noc__port{0}_cntl            ),'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_data            ( pe__noc__port{0}_data            ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_fc              ( noc__pe__port{0}_fc              ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_valid           ( noc__pe__port{0}_valid           ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_cntl            ( noc__pe__port{0}_cntl            ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_data            ( noc__pe__port{0}_data            ),'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_fc              ( pe__noc__port{0}_fc              ),'.format(port)
    pLine = pLine + '\n  .sys__pe__port{0}_destinationMask ( sys__pe__port{0}_destinationMask ),'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  f = open('../HDL/common/noc_cntl_noc_wires.vh', 'w')

  pLine = ""
  pLine = pLine + '\n   reg [`PE_PE_ID_BITMASK_RANGE      ] thisPeBitMask       ; '

  f.write(pLine)
  f.close()

  f = open('../HDL/common/noc_cntl_noc_general_assignments.vh', 'w')
  pLine = ""

  # Convert peId to a bit field
  pLine = pLine + '\n'
  #pLine = pLine + '\nDEBUG NUMOFPE= {0}'.format(numOfPe)
  numOfPeIdBits = int(math.log(numOfPe,2))
  pLine = pLine + '\n  // Convert the peId to a bit mask'
  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      case(peId)'
  for pe in range (0, numOfPe):
    pLine = pLine + '\n      {2}\'d{0} :'.format(pe,numOfPe,numOfPeIdBits)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          thisPeBitMask = {1}\'b'.format(pe,numOfPe)
    for bit in range (0, numOfPe-1-pe):
      pLine = pLine + '0'
    pLine = pLine + '1'
    for bit in range (numOfPe-pe, numOfPe):
      pLine = pLine + '0'
    pLine = pLine + '  ; '
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      default:'
  pLine = pLine + '\n        begin'
  pLine = pLine + '\n          thisPeBitMask = \'d0 ; '
  pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'
  
  for port in range (0, numOfPorts):
    pLine = pLine + '\n    wire  port{0}_localInqReq          ; // Request from an input port after being gated with local bitMask'.format(port)
    pLine = pLine + '\n    reg   port{0}_localInqPriority     ; // Indicate whether packet is Control or Data'.format(port)
    pLine = pLine + '\n    reg   port{0}_localInqAck          ; // accept request from input port'.format(port)
    pLine = pLine + '\n    reg   port{0}_localInqEnable       ; // Indicate when input q is able to take data'.format(port)
  pLine = pLine + '\n'

  pLine = pLine + '\n    //------------------------------------------------'
  pLine = pLine + '\n    //wire                            local_OutqReq     ;'
  pLine = pLine + '\n    //wire [`PE_PE_ID_BITMASK_RANGE ] local_OutqReqAddr ; // bitmask address from header of packet'
  pLine = pLine + '\n    //reg                             local_OutqAck     ;'
  pLine = pLine + '\n    //reg                             local_OutqEnable  ;'
  for port in range (1, numOfPorts):
    pLine = pLine + '\n    //wire                            port{0}_OutqReq     ;'.format(port)
    pLine = pLine + '\n    //wire [`PE_PE_ID_BITMASK_RANGE ] port{0}_OutqReqAddr ; // bitmask address from header of packet'.format(port)
    pLine = pLine + '\n    //reg                             port{0}_OutqAck     ;'.format(port)
    pLine = pLine + '\n    //reg                             port{0}_OutqEnable  ;'.format(port)
  
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  reg  local_port{0}_OutqAck   ;  // the local input queue is actually an output for the port input controllers'.format(port)
    pLine = pLine + '\n  wire local_port{0}_OutqReady ;  // so ck the request from the port input controller'.format(port)

  f.write(pLine)
  f.close()

  f = open('../HDL/common/noc_cntl_port_input_control_wires.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  wire [`NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ] InPortRequestVector    ;'

  f.write(pLine)
  f.close()


  f = open('../HDL/common/noc_cntl_port_input_control_assignments.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  assign InPortRequestVector[{0}]       = Port_from_NoC[{0}].destinationReq ;'.format(port)
  pLine = pLine + '\n'

  # Port input controller fifo inputs from NoC
  pLine = pLine + '\n  // Port inputs from NoC'.format(port)
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  assign    pe__noc__port{0}_fc      = Port_from_NoC[{0}].fifo_almost_full ;'.format(port)
    pLine = pLine + '\n  always @(*)'
    pLine = pLine + '\n    begin '
    pLine = pLine + '\n      Port_from_NoC[{0}].cntl        = noc__pe__port{0}_cntl               ;'.format(port)
    pLine = pLine + '\n      Port_from_NoC[{0}].data        = noc__pe__port{0}_data               ;'.format(port)
    pLine = pLine + '\n      Port_from_NoC[{0}].fifo_write  = noc__pe__port{0}_valid              ;'.format(port)
    pLine = pLine + '\n    end '
    pLine = pLine + '\n'        
  pLine = pLine + '\n'
  f.write(pLine)
  f.close()


  f = open('../HDL/common/noc_cntl_noc_local_inq_control_wires.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  reg  [`NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  local_inq_type_fromNoc     ;  // latch as we need type to know whether to add EOD at end of current apcket transfer'
  pLine = pLine + '\n  reg  [`NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  local_inq_type_fromNoc_p1  ; '

  f.write(pLine)
  f.close()


  #-------------------------------
  # Local In-Q controller fsm
  # - takes requests from 4 ports (is only HP or LP from the ports)
  # - once selected, the ports input is diercted toward the Cp or Dp port from noc -> cntl (no fifo in-between)

  f = open('../HDL/common/noc_cntl_noc_local_inq_control_fsm_state_definitions.vh', 'w')
  pLine = ""

  numOfLocalInputQueueFsmStateBits = numOfPorts*3+1
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n// NOC_CONT_LOCAL_INQ_CNTL_LOCAL_INPUT_QUEUE_CONTROL_STATE width'
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n`define NOC_CONT_LOCAL_INQ_CNTL_STATE_MSB            {0}'.format(numOfLocalInputQueueFsmStateBits-1)
  pLine = pLine + '\n`define NOC_CONT_LOCAL_INQ_CNTL_STATE_LSB            0'
  pLine = pLine + '\n`define NOC_CONT_LOCAL_INQ_CNTL_STATE_SIZE           (`NOC_CONT_LOCAL_INQ_CNTL_STATE_MSB - `NOC_CONT_LOCAL_INQ_CNTL_STATE_LSB +1)'
  pLine = pLine + '\n`define NOC_CONT_LOCAL_INQ_CNTL_STATE_RANGE           `NOC_CONT_LOCAL_INQ_CNTL_STATE_MSB : `NOC_CONT_LOCAL_INQ_CNTL_STATE_LSB'
  pLine = pLine + '\n'
  pLine = pLine + '\n//------------------------------------------------------------------------------------------------'
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n// NOC_CONT_LOCAL_INQ_CNTL state machine states'
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n'
  pLine = pLine + '\n`define NOC_CONT_LOCAL_INQ_CNTL_WAIT        {0}\'d1'.format(numOfLocalInputQueueFsmStateBits)
  port = 0
  bit = 1
  for port in range (0, numOfPorts):
    pLine = pLine + '\n`define NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{0}            {1}\'d{2}'.format(port,numOfLocalInputQueueFsmStateBits,pow(2,bit))
    pLine = pLine + '\n`define NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP{0}                {1}\'d{2}'.format(port,numOfLocalInputQueueFsmStateBits,pow(2,bit+1))
    pLine = pLine + '\n`define NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}       {1}\'d{2}'.format(port,numOfLocalInputQueueFsmStateBits,pow(2,bit+2))
    bit = bit+3


  f.write(pLine)
  f.close()


  f = open('../HDL/common/noc_cntl_noc_local_inq_control_fsm_state_transitions.vh', 'w')
  pLine = ""

  pLine = pLine + '\n           `NOC_CONT_LOCAL_INQ_CNTL_WAIT:'
  pLine = pLine + '\n             nc_local_inq_cntl_state_next = ( port0_localInqReq )  ? `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0  :'
  for port in range (1, numOfPorts):
    pLine = pLine + '\n                                            ( port{0}_localInqReq )  ? `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{0}  :'.format(port)
  pLine = pLine + '\n                                                                     `NOC_CONT_LOCAL_INQ_CNTL_WAIT          ; '


  for port in range (0, numOfPorts):

    pLine = pLine + '\n '
    pLine = pLine + '\n            // NoC packets always have more than one transaction so SOP_EOP will not be seen' 
    pLine = pLine + '\n            // NoCource controller has already read the header to determine the destination mask address, but it will still provide a "fromNoc_valid" signal when it starts transerring tbe entire external NoC packet'
    pLine = pLine + '\n            // When sending to the local in-queue, we need to drop the NoC header so waht for the first "fromNoc_valid" and ignore that transaction'
    pLine = pLine + '\n           `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{0}:'.format(port)
    pLine = pLine + '\n             nc_local_inq_cntl_state_next = (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP))  ? `NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP{0}  :'.format(port)
    pLine = pLine + '\n                                                                                                                                                           `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{0}       ; '.format(port)

    if port != (numOfPorts-1):
      pLine = pLine + '\n' 
      pLine = pLine + '\n           // when we transfer a packet between a Port and the In-queue, we will pass the packet to the CNTL block. But we need to strip the external header, this means we need to re-add the SOP indicator ' 
      pLine = pLine + '\n           `NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP{0}:'.format(port)
      pLine = pLine + '\n             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc != `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))    ? `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}  :'.format(port)
      for nextPort in range (port+1, numOfPorts):
        pLine = pLine + '\n                                             (port{1}_localInqReq && Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))    ? `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{1}  :  // EOP so go to the next port'.format(port,nextPort)
      for nextPort in range (0, port):
        pLine = pLine + '\n                                             (port{1}_localInqReq && Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))    ? `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{1}  :  // EOP so go to the next port'.format(port,nextPort)
      pLine = pLine + '\n                                             (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))                         ? `NOC_CONT_LOCAL_INQ_CNTL_WAIT  :  // EOP so go to the next port'.format(port)
      pLine = pLine + '\n                                                                                                                                                                                       `NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP{0}        ; '.format(port)
    else:
      pLine = pLine + '\n           `NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP{0}:'.format(port)
      pLine = pLine + '\n             nc_local_inq_cntl_state_next =    (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc != `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))                         ? `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}  :'.format(port)
      for nextPort in range (0, numOfPorts-1):
        pLine = pLine + '\n                                             (port{1}_localInqReq && Port_from_NoC[{0}].fromNoc_valid && ((Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP)))  ? `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{1}  :  // EOP so go to the next port'.format(port,nextPort)
      pLine = pLine + '\n                                             (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))                           ? `NOC_CONT_LOCAL_INQ_CNTL_WAIT  :  // EOP so go to the next port'.format(port,nextPort)
      pLine = pLine + '\n                                                                                                                                                                                         `NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP{0}        ; '.format(port)

    if port != (numOfPorts-1):
      pLine = pLine + '\n' 
      pLine = pLine + '\n           `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}:'.format(port)
      pLine = pLine + '\n             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc != `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))    ? `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}  :'.format(port)
      for nextPort in range (port+1, numOfPorts):
        pLine = pLine + '\n                                             (port{1}_localInqReq && Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))    ? `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{1}  :  // EOP so go to the next port'.format(port,nextPort)
      for nextPort in range (0, port):
        pLine = pLine + '\n                                             (port{1}_localInqReq && Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))    ? `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{1}  :  // EOP so go to the next port'.format(port,nextPort)
      pLine = pLine + '\n                                             (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))                         ? `NOC_CONT_LOCAL_INQ_CNTL_WAIT  :  // EOP so go to the next port'.format(port)
      pLine = pLine + '\n                                                                                                                                                                                       `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}        ; '.format(port)
    else:
      pLine = pLine + '\n           `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}:'.format(port)
      pLine = pLine + '\n             nc_local_inq_cntl_state_next =    (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc != `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))                         ? `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}  :'.format(port)
      for nextPort in range (0, numOfPorts-1):
        pLine = pLine + '\n                                             (port{1}_localInqReq && Port_from_NoC[{0}].fromNoc_valid && ((Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP)))  ? `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{1}  :  // EOP so go to the next port'.format(port,nextPort)
      pLine = pLine + '\n                                             (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP))                           ? `NOC_CONT_LOCAL_INQ_CNTL_WAIT  :  // EOP so go to the next port'.format(port,nextPort)
      pLine = pLine + '\n                                                                                                                                                                                         `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}        ; '.format(port)


  f.write(pLine)
  f.close()


  f = open('../HDL/common/noc_cntl_noc_local_inq_control_assignments.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__cp_cntl       ; '
  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__cp_type       ; '
  pLine = pLine + '\n  reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ] noc__scntl__cp_data       ; '
  pLine = pLine + '\n  reg  [`PE_PE_ID_RANGE                         ] noc__scntl__cp_peId       ; '
  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__cp_laneId     ; '
  pLine = pLine + '\n  reg                                             noc__scntl__cp_strmId     ; '
  pLine = pLine + '\n  reg                                             noc__scntl__cp_valid      ; '
  pLine = pLine + '\n'

  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__dp_cntl       ; '
  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__dp_type       ; '
  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__dp_laneId     ; '
  pLine = pLine + '\n  reg                                             noc__scntl__dp_strmId     ; '
  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_DATA_RANGE           ] noc__scntl__dp_data       ; '
  pLine = pLine + '\n  reg                                             noc__scntl__dp_valid      ; '
  pLine = pLine + '\n'
  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__cp_cntl_p1       ; '
  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__cp_type_p1       ; '
  pLine = pLine + '\n  reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ] noc__scntl__cp_data_p1       ; '
  pLine = pLine + '\n  reg                                             noc__scntl__cp_valid_p1      ; '
  pLine = pLine + '\n'

  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__dp_cntl_p1       ; '
  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__dp_type_p1       ; '
  pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_DATA_RANGE           ] noc__scntl__dp_data_p1       ; '
  pLine = pLine + '\n  reg                                             noc__scntl__dp_valid_p1      ; '
  pLine = pLine + '\n'

  pLine = pLine + '\n  always @(posedge clk)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      '
  pLine = pLine + '\n      noc__scntl__cp_cntl        <= (reset_poweron ) ? \'d0 :   noc__scntl__cp_cntl_p1   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__cp_type        <= (reset_poweron ) ? \'d0 :   noc__scntl__cp_type_p1   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__cp_data        <= (reset_poweron ) ? \'d0 :   noc__scntl__cp_data_p1   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__cp_valid       <= (reset_poweron ) ? \'d0 :   noc__scntl__cp_valid_p1  ; '.format(port)
  pLine = pLine + '\n'                                                                    
  pLine = pLine + '\n      noc__scntl__dp_cntl        <= (reset_poweron ) ? \'d0 :   noc__scntl__dp_cntl_p1   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__dp_type        <= (reset_poweron ) ? \'d0 :   noc__scntl__dp_type_p1   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__dp_data        <= (reset_poweron ) ? \'d0 :   noc__scntl__dp_data_p1   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__dp_valid       <= (reset_poweron ) ? \'d0 :   noc__scntl__dp_valid_p1  ; '.format(port)
  pLine = pLine + '\n      '
  pLine = pLine + '\n      case(nc_local_inq_cntl_state)'
  pLine = pLine + '\n'
  for port in range (0, numOfPorts):
    # READ
    pLine = pLine + '\n        `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{0}:'.format(port)
    pLine = pLine + '\n          begin'
    pLine = pLine + '\n            noc__scntl__cp_peId        <= (reset_poweron ) ? \'d0 : Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE       ]                                   ; '.format(port)
    pLine = pLine + '\n          end'
    pLine = pLine + '\n        `NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP{0}:'.format(port)
    pLine = pLine + '\n          begin'
    pLine = pLine + '\n            local_inq_type_fromNoc    <= (reset_poweron ) ? \'d0 : local_inq_type_fromNoc_p1 ;   '
    pLine = pLine + '\n            noc__scntl__cp_laneId      <= (reset_poweron ) ? \'d0 : Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n            noc__scntl__cp_strmId      <= (reset_poweron ) ? \'d0 : Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n            noc__scntl__dp_laneId      <= (reset_poweron ) ? \'d0 : Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n            noc__scntl__dp_strmId      <= (reset_poweron ) ? \'d0 : Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n          end'
  pLine = pLine + '\n        default:'
  pLine = pLine + '\n          begin'
  pLine = pLine + '\n            local_inq_type_fromNoc    <= (reset_poweron   ) ? \'d0 : local_inq_type_fromNoc ;   '
  pLine = pLine + '\n          end'
  pLine = pLine + '\n'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'
    
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // Mask request from Port with this PE\'s mask address'
    pLine = pLine + '\n  assign port{0}_localInqReq      = Port_from_NoC[{0}].destinationReq & |(Port_from_NoC[{0}].destinationReqAddr & thisPeBitMask)  ;'.format(port)
    pLine = pLine + '\n  always @(posedge clk)'
    pLine = pLine + '\n    port{0}_localInqPriority <= (port{0}_localInqReq) ? Port_from_NoC[{0}].destinationPriority : port{0}_localInqPriority ;'.format(port)
    pLine = pLine + '\n  '
    pLine = pLine + '\n  // Ack and ready back to source ports'
    pLine = pLine + '\n  always @(posedge clk)'
    pLine = pLine + '\n    local_port{0}_OutqAck   <= port{0}_localInqReq ;  // feed request directly back to ack'.format(port)
    pLine = pLine + '\n  assign local_port{0}_OutqReady = ((port{0}_localInqPriority == `NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP) ? scntl__noc__cp_ready : scntl__noc__dp_ready ) &  // we will transfer the packet directly to the cntl block'.format(port)
    pLine = pLine + '\n                                   ((nc_local_inq_cntl_state == `NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER{0}     ) | // only assert ready to source if currently selected for transfer'.format(port)
    pLine = pLine + '\n                                    (nc_local_inq_cntl_state == `NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP{0}         ) | '.format(port)
    pLine = pLine + '\n                                    (nc_local_inq_cntl_state == `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}) );'.format(port)

  pLine = pLine + '\n  // Mux source packet into the to cntl fifo'
  pLine = pLine + '\n  // Remember, the transferred packet includes the NoC header so the local contrller needs to drop the first transaction'
  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      noc__scntl__cp_cntl_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__cp_type_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__cp_data_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__cp_valid_p1                                                       = \'d0   ; '.format(port)
  pLine = pLine + '\n'     
  pLine = pLine + '\n      noc__scntl__dp_cntl_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__dp_type_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__dp_data_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n      noc__scntl__dp_valid_p1                                                       = \'d0   ; '.format(port)
  pLine = pLine + '\n      '
  pLine = pLine + '\n      local_inq_type_fromNoc_p1                                                       = \'d0   ; '.format(port)
  pLine = pLine + '\n      '
  pLine = pLine + '\n      case(nc_local_inq_cntl_state)'
  pLine = pLine + '\n'
  for port in range (0, numOfPorts):
    # READ
    pLine = pLine + '\n        `NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP{0}:'.format(port)
    pLine = pLine + '\n          begin'
    pLine = pLine + '\n            local_inq_type_fromNoc_p1                                                       = Port_from_NoC[{0}].type_fromNoc   ; '.format(port)
    pLine = pLine + '\n      '
    pLine = pLine + '\n            noc__scntl__cp_cntl_p1                                                        = (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) ? `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP             : '.format(port)
    pLine = pLine + '\n                                                                                                                                                                     `NOC_CONT_NOC_PROTOCOL_CNTL_SOP                 ; '.format(port)
    pLine = pLine + '\n            noc__scntl__cp_type_p1                                                        = Port_from_NoC[{0}].type_fromNoc                                                                                        ; '.format(port)
    pLine = pLine + '\n            noc__scntl__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE  ]  = Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n            noc__scntl__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE  ]  = Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n            noc__scntl__cp_valid_p1                                                       = (port{0}_localInqPriority != `NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? \'d0                           :'.format(port)
    pLine = pLine + '\n                                                                                              (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP))  ? \'d0                           :  // packets from NoC always more than one transaction'.format(port)
    pLine = pLine + '\n                                                                                                                                                                                                             Port_from_NoC[{0}].fromNoc_valid ; '.format(port)
    pLine = pLine + '\n'           
    pLine = pLine + '\n            noc__scntl__dp_cntl_p1                                                        = (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) ? `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP             : '.format(port)
    pLine = pLine + '\n                                                                                                                                                                     `NOC_CONT_NOC_PROTOCOL_CNTL_SOP                 ; '.format(port)
    pLine = pLine + '\n            noc__scntl__dp_type_p1                                                        = Port_from_NoC[{0}].type_fromNoc                                                                                        ; '.format(port)
    pLine = pLine + '\n            noc__scntl__dp_data_p1                                                        = Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n            noc__scntl__dp_valid_p1                                                       = (port{0}_localInqPriority != `NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? \'d0                           :'.format(port)
    pLine = pLine + '\n                                                                                              (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP))  ? \'d0                           :  // packets from NoC always more than one transaction'.format(port)
    pLine = pLine + '\n                                                                                                                                                                                                             Port_from_NoC[{0}].fromNoc_valid ; '.format(port)
    pLine = pLine + '\n          end'
    pLine = pLine + '\n        `NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD{0}:'.format(port)
    pLine = pLine + '\n          begin'
    pLine = pLine + '\n            noc__scntl__cp_cntl_p1                                                        = Port_from_NoC[{0}].cntl_fromNoc                                    ; '.format(port)
    pLine = pLine + '\n            noc__scntl__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE  ]  = Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n            noc__scntl__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE  ]  = Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n            noc__scntl__cp_valid_p1                                                       = (port{0}_localInqPriority != `NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? \'d0                           :'.format(port)
    pLine = pLine + '\n                                                                                              (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP))  ? \'d0                           :  // packets from NoC always more than one transaction'.format(port)
    pLine = pLine + '\n                                                                                                                                                                                                             Port_from_NoC[{0}].fromNoc_valid ; '.format(port)
    pLine = pLine + '\n            noc__scntl__cp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer '.format(port)
    pLine = pLine + '\n'           
    pLine = pLine + '\n            noc__scntl__dp_cntl_p1                                                        = Port_from_NoC[{0}].cntl_fromNoc                                    ; '.format(port)
    pLine = pLine + '\n            noc__scntl__dp_data_p1                                                        = Port_from_NoC[{0}].data_fromNoc[`NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; '.format(port)
    pLine = pLine + '\n            noc__scntl__dp_valid_p1                                                       = (port{0}_localInqPriority != `NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? \'d0                           :'.format(port)
    pLine = pLine + '\n                                                                                              (Port_from_NoC[{0}].fromNoc_valid && (Port_from_NoC[{0}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP))  ? \'d0                           :  // packets from NoC always more than one transaction'.format(port)
    pLine = pLine + '\n                                                                                                                                                                                                             Port_from_NoC[{0}].fromNoc_valid ; '.format(port)
    pLine = pLine + '\n            noc__scntl__dp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer '.format(port)
    pLine = pLine + '\n          end'
  pLine = pLine + '\n        default:'
  pLine = pLine + '\n          begin'
  pLine = pLine + '\n            local_inq_type_fromNoc_p1                                                       = \'d0   ; '.format(port)
  pLine = pLine + '\n'
  pLine = pLine + '\n            noc__scntl__cp_cntl_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n            noc__scntl__cp_type_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n            noc__scntl__cp_data_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n            noc__scntl__cp_valid_p1                                                       = \'d0   ; '.format(port)
  pLine = pLine + '\n'           
  pLine = pLine + '\n            noc__scntl__dp_cntl_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n            noc__scntl__dp_type_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n            noc__scntl__dp_data_p1                                                        = \'d0   ; '.format(port)
  pLine = pLine + '\n            noc__scntl__dp_valid_p1                                                       = \'d0   ; '.format(port)
  pLine = pLine + '\n          end'
  pLine = pLine + '\n'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/noc_cntl_noc_local_outq_control_wires.vh', 'w')
  pLine = ""

  f.write(pLine)
  f.close()


  f = open('../HDL/common/noc_cntl_noc_local_outq_control_assignments.vh', 'w')
  pLine = ""

  # Convert address to a bit field
  pLine = pLine + '\n'
  numOfPeIdBits = int(math.log(numOfPe,2))
  pLine = pLine + '\n  // Convert the dma request address to a bit mask'
  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      case(local_destinationPeId)'
  for pe in range (0, numOfPe):
    pLine = pLine + '\n      {2}\'d{0} :'.format(pe,numOfPe,numOfPeIdBits)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          local_destinationReqAddr = {1}\'b'.format(pe,numOfPe)
    for bit in range (0, numOfPe-1-pe):
      pLine = pLine + '0'
    pLine = pLine + '1'
    for bit in range (numOfPe-pe, numOfPe):
      pLine = pLine + '0'
    pLine = pLine + '  ; '
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      default:'
  pLine = pLine + '\n        begin'
  pLine = pLine + '\n          local_destinationReqAddr = \'d0 ; '
  pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  #--------------------------------------------------------------------------------------------
  #--------------------------------------------------------------------------------------------
  #  ******** TRAFFIC OUT OF THE NODE ********
  #--------------------------------------------------------------------------------------------
  #--------------------------------------------------------------------------------------------

  #-------------------------------
  # Port output controller fsm
  # - takes requests from Local CP, local DP and other 3 ports (is only HP or LP from the ports)
  # - transfer is fifo -> fifo

  f = open('../HDL/common/noc_cntl_noc_port_output_control_wires.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  wire [`PE_PE_ID_BITMASK_RANGE ] thisPort_destinationMask  ; // bitmask indicating which nodes accessed out of this port'
  pLine = pLine + '\n'
  pLine = pLine + '\n  wire                            local_OutqReq             ;  // request from local putput queue controller'
  pLine = pLine + '\n  wire [`PE_PE_ID_BITMASK_RANGE ] local_OutqReqAddr         ;  // bitmask address of requestor'
  pLine = pLine + '\n  reg                             local_OutqAck             ;'
  pLine = pLine + '\n  reg                             local_OutqReady           ;'
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // These 3 sources are the 3 sources not the 3 actual ports'
    pLine = pLine + '\n  // e.g. if this instance is port 2, 1=port0, 2=port1, 3=port3 etc.'
    pLine = pLine + '\n  wire                            src{0}_OutqReq             ;  // request from source (port) {0}'.format(port)
    pLine = pLine + '\n  wire [`PE_PE_ID_BITMASK_RANGE ] src{0}_OutqReqAddr         ;  // bitmask address of requestor'.format(port)
    pLine = pLine + '\n  reg                             src{0}_OutqAck             ;  // ack back to source (port) input controller'.format(port)
    pLine = pLine + '\n  reg                             src{0}_OutqReady           ;'.format(port)
    pLine = pLine + '\n  // This is the packet bus from the 3 possible sources that will be muxed into the output fifo when the source has been acknowledged'
    pLine = pLine + '\n  // The local packet bus is common but the 3 sources vary based on \"this\" port id'
    pLine = pLine + '\n  wire                                        src{0}_toNoc_valid    ;  // data from source is valid'.format(port)
    pLine = pLine + '\n  wire [`NOC_CONT_NOC_PORT_CNTL_RANGE      ]  src{0}_cntl_toNoc     ;'.format(port)
    pLine = pLine + '\n  wire [`NOC_CONT_NOC_PORT_DATA_RANGE      ]  src{0}_data_toNoc     ;'.format(port)


  f.write(pLine)
  f.close()

  f = open('../HDL/common/noc_cntl_noc_port_output_control_fsm_state_definitions.vh', 'w')
  pLine = ""

  # 2 states for loca, 2 states for each port and 1 wait state
  numOfPortOutputQueueFsmStateBits = 2+numOfPorts*2+1
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n// NOC_CONT_NOC_PORT_OUTPUT_CNTL_LOCAL_INPUT_QUEUE_CONTROL_STATE width'
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n`define NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_MSB            {0}'.format(numOfPortOutputQueueFsmStateBits-1)
  pLine = pLine + '\n`define NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_LSB            0'
  pLine = pLine + '\n`define NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_SIZE           (`NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_MSB - `NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_LSB +1)'
  pLine = pLine + '\n`define NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_RANGE           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_MSB : `NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_LSB'
  pLine = pLine + '\n'
  pLine = pLine + '\n//------------------------------------------------------------------------------------------------'
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n// NOC_CONT_NOC_PORT_OUTPUT_CNTL state machine states'
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n'
  pLine = pLine + '\n`define NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT        {0}\'d1'.format(numOfPortOutputQueueFsmStateBits)
  port = 0
  bit = 1
  pLine = pLine + '\n`define NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL  {1}\'d{2}'.format(port,numOfPortOutputQueueFsmStateBits,pow(2,bit))
  pLine = pLine + '\n`define NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL   {1}\'d{2}'.format(port,numOfPortOutputQueueFsmStateBits,pow(2,bit+1))
  bit=bit+2
  for port in range (0, numOfPorts):
    pLine = pLine + '\n`define NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}  {1}\'d{2}'.format(port,numOfPortOutputQueueFsmStateBits,pow(2,bit))
    pLine = pLine + '\n`define NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT{0}   {1}\'d{2}'.format(port,numOfPortOutputQueueFsmStateBits,pow(2,bit+1))
    bit = bit+2


  f.write(pLine)
  f.close()


  f = open('../HDL/common/noc_cntl_noc_port_output_control_fsm_state_transitions.vh', 'w')
  pLine = ""
 
  pLine = pLine + '\n           // Round-robin arbiter granting access to the port in the following order: local - 1 - 2 - 3                                         ' 
  pLine = pLine + '\n           // If control packets arrive on a requestor, the requestor decides to send the control packet but then ahs to wait for its next turn '
  pLine = pLine + '\n           // Note: Ports 1-2-3 refer to the 3 ports accessing this port, not the actual ports 1,2,3                                            '       
  pLine = pLine + '\n           // Assume each requestor will only transfer a single packet                                                                          '
  pLine = pLine + '\n           // The requestor deals with prioritizing its own CP or DP packets                                                                    '
  pLine = pLine + '\n           //                                                                                                                                   '
  pLine = pLine + '\n           // The request is directed to a particular port by \'ANDing\' the ports routing bitmask with the destination bitmask                 '
  pLine = pLine + '\n           // If there are multiple ack\'s, the source will wait until all enables are set before reading its fifo for transfer                 '
  pLine = pLine + '\n           // '
  pLine = pLine + '\n           // '
  
  # WAIT
  pLine = pLine + '\n'
  pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT:'
  pLine = pLine + '\n             nc_port_toNoc_state_next = ( local_OutqReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL  :'
  for port in range (0, numOfPorts):
    pLine = pLine + '\n                                        ( src{0}_OutqReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}  :'.format(port,)
  pLine = pLine + '\n                                                               `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; '


  for port in range (0, numOfPorts+1):

    # READ 
    pLine = pLine + '\n' 
    if port == 0:
      pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL:'.format(port)
    else:
      pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}:'.format(port-1)

    if port == 0:
      pLine = pLine + '\n             nc_port_toNoc_state_next = (local_toNoc_valid && ((local_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (local_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL  :'.format(port-1,numOfPorts)
    else:
      pLine = pLine + '\n             nc_port_toNoc_state_next = (src{0}_toNoc_valid && ((src{0}_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (src{0}_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT{0}  :'.format(port-1, port-2)

    if port == 0:
      pLine = pLine + '\n                                                             `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL   ; '.format(port-1)
    else:
      pLine = pLine + '\n                                                             `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}   ; '.format(port-1)

    # ACK 
    if port != (numOfPorts):
      pLine = pLine + '\n' 
      if port == 0:
        pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL:'.format(port)
        pLine = pLine + '\n             nc_port_toNoc_state_next = ( src0_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0     :'.format(port, numOfPorts)
      else:
        pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT{0}:'.format(port-1)
        pLine = pLine + '\n             nc_port_toNoc_state_next = ( src{0}_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}     :'.format(port, port-1)

      for nextPort in range (port+2, numOfPorts+1):
        pLine = pLine + '\n                                        ( src{0}_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}     :'.format(nextPort-1, nextPort-2)
      for nextPort in range (0, port+1):
        if nextPort == 0:
          pLine = pLine + '\n                                        ( local_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL     :'.format(nextPort-1, nextPort-2)
        else:
          pLine = pLine + '\n                                        ( src{0}_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}     :'.format(nextPort-1, nextPort-2)


      pLine = pLine + '\n                                                                                   `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; '
    else:
      pLine = pLine + '\n' 
      if port == 0:
        pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL:'.format(port)
      else:                                                                 
        pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT{0}:'.format(port-1)
      pLine = pLine + '\n             nc_port_toNoc_state_next = ( local_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL     :'.format(port-1, numOfPorts)
      for port in range (1, numOfPorts+1):
        pLine = pLine + '\n                                        ( src{0}_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}     :'.format(port-1, port-2)
      pLine = pLine + '\n                                                                                   `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; '

  # Crude attempt at having both HP and LP requests
  # WAIT
  #  pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT:'
  #  pLine = pLine + '\n             nc_port_toNoc_state_next = ( local_OutqReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_HP_LOCAL  :'
  #  for port in range (1, numOfPorts):
  #    pLine = pLine + '\n                                        ( src{0}_OutqReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_HP_PORT{0}  :'.format(port,)
  #  for port in range (0, numOfPorts):
  #    if port == 0:
  #      pLine = pLine + '\n                                        ( local_OutqLpReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_LP_LOCAL  :'.format(port,numOfPorts-1)
  #    else:
  #      pLine = pLine + '\n                                        ( src{0}_OutqLpReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_LP_PORT{0}  :'.format(port, port-1)
  #  pLine = pLine + '\n                                                               `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; '
  #
  #
  #  for port in range (0, numOfPorts):
  #
  #    # READ HP
  #    pLine = pLine + '\n' 
  #    if port == 0:
  #      pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_HP_LOCAL:'.format(port)
  #    else:
  #      pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_HP_PORT{0}:'.format(port)
  #
  #    if port == 0:
  #      pLine = pLine + '\n             nc_port_toNoc_state_next = ( local_OutqHpReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_HP_LOCAL  :'.format(port,numOfPorts-1)
  #    else:
  #      pLine = pLine + '\n             nc_port_toNoc_state_next = ( src{0}_OutqHpReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_HP_PORT{0}  :'.format(port, port-1)
  #
  #    if port == 0:
  #      pLine = pLine + '\n                                                               `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_HP_LOCAL   ; '.format(port)
  #    else:
  #      pLine = pLine + '\n                                                               `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_HP_PORT{0}   ; '.format(port)
  #
  #    # ACK 
  #    if port != (numOfPorts-1):
  #      pLine = pLine + '\n' 
  #      if port == 0:
  #        pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_HP_LOCAL:'.format(port)
  #        pLine = pLine + '\n             nc_port_toNoc_state_next = ( Port1_OutqHpReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1     :'.format(port+1, numOfPorts-1)
  #      else:
  #        pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_HP_PORT{0}:'.format(port)
  #        pLine = pLine + '\n             nc_port_toNoc_state_next = ( src{0}_OutqHpReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}     :'.format(port+1, port)
  #
  #      for nextPort in range (port+2, numOfPorts):
  #        pLine = pLine + '\n                                        ( src{0}_OutqHpReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}     :'.format(nextPort, nextPort-1)
  #      for nextPort in range (0, port+1):
  #        if nextPort == 0:
  #          pLine = pLine + '\n                                        ( local_OutqHpReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL     :'.format(nextPort, nextPort-1)
  #        else:
  #          pLine = pLine + '\n                                        ( src{0}_OutqHpReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}     :'.format(nextPort, nextPort-1)
  #
  #      for nextPort in range (0, numOfPorts):
  #        if nextPort == 0:
  #          pLine = pLine + '\n                                        ( local_OutqLpReq && (lastLpOutq == \'d3))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_LP_LOCAL  :'.format(nextPort, nextPort-1)
  #        else:
  #          pLine = pLine + '\n                                        ( src{0}_OutqLpReq && (lastLpOutq == \'d{1}))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_LP_PORT{0}  :'.format(nextPort, nextPort-1)
  #
  #      pLine = pLine + '\n                                                                                     `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; '
  #    else:
  #      pLine = pLine + '\n' 
  #      if port == 0:
  #        pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_HP_LOCAL:'.format(port)
  #      else:                                                                 
  #        pLine = pLine + '\n           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_HP_PORT{0}:'.format(port)
  #      pLine = pLine + '\n             nc_port_toNoc_state_next = ( local_OutqHpReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL     :'.format(port, numOfPorts-1)
  #      for port in range (1, numOfPorts):
  #        pLine = pLine + '\n                                        ( src{0}_OutqHpReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}     :'.format(port, port-1)
  #      for nextPort in range (0, numOfPorts):
  #        if nextPort == 0:
  #          pLine = pLine + '\n                                        ( local_OutqLpReq && (lastLpOutq == \'d3))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_LP_LOCAL  :'.format(nextPort, nextPort-1)
  #        else:
  #          pLine = pLine + '\n                                        ( src{0}_OutqLpReq && (lastLpOutq == \'d{1}))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_READ_LP_PORT{0}  :'.format(nextPort, nextPort-1)
  #      pLine = pLine + '\n                                                                                     `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; '
  #
  f.write(pLine)
  f.close()


  f = open('../HDL/common/noc_cntl_noc_port_output_control_fsm_assignments.vh', 'w')
  pLine = ""

  # Note: Each output port interfaces to the local output queue(s) and 3 other ports. These numbers do not correlate to
  # the 4 actual ports and are dependent on instance number
  # e.g. port 1 connects to local, 0, 2, 3 which correspond to numbers 0,1,2 in this logic
  # The actual connections will be made elsewhere.
  pLine = pLine + '\n        // Note: Each output port interfaces to 3 other ports which are referred to as sources 1-3. These numbers do not correlate to'
  pLine = pLine + '\n        // the 4 actual ports and are dependent on instance number'
  pLine = pLine + '\n        // e.g. port 1 connects to 0,2,3 which correspond to numbers 1,2,3 in this logic'
  pLine = pLine + '\n'
  pLine = pLine + '\n        // wrap the decoded request right back to the source. A packet will not be transferred until all outputs assert ready'
  pLine = pLine + '\n  always @(posedge clk)'
  pLine = pLine + '\n          local_OutqAck  <= local_OutqReq ;'.format(port)
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  always @(posedge clk)'
    pLine = pLine + '\n          src{0}_OutqAck   <= src{0}_OutqReq  ;'.format(port)
  pLine = pLine + '\n'
  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      case(nc_port_toNoc_state)'
  pLine = pLine + '\n'
  for port in range (0, numOfPorts+1):
    # READ
    if port == 0:
      pLine = pLine + '\n        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL:'.format(port-1)
    else:
      pLine = pLine + '\n        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}:'.format(port-1)
    pLine = pLine + '\n        begin'
    for nextPort in range (0, port):
      if nextPort == 0:
        pLine = pLine + '\n          local_OutqReady   = 1\'b0  ;'.format(nextPort)
      else:
        pLine = pLine + '\n          src{0}_OutqReady   = 1\'b0  ;'.format(nextPort-1)
    if port == 0:
      pLine = pLine + '\n          local_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;'.format(port)
    else:
      pLine = pLine + '\n          src{0}_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;'.format(port-1)
    for nextPort in range (port+1, numOfPorts+1):
      pLine = pLine + '\n          src{0}_OutqReady   = 1\'b0  ;'.format(nextPort-1)
    pLine = pLine + '\n        end'
    pLine = pLine + '\n'
    # ACK
    if port == 0:
      pLine = pLine + '\n        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL:'.format(port)
    else:
      pLine = pLine + '\n        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT{0}:'.format(port-1)
    pLine = pLine + '\n        begin'
    for nextPort in range (0, port):
      if nextPort == 0:
        pLine = pLine + '\n          local_OutqReady   = 1\'b0  ;'.format(nextPort)
      else:
        pLine = pLine + '\n          src{0}_OutqReady   = 1\'b0  ;'.format(nextPort-1)
    if port == 0:
      pLine = pLine + '\n          local_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;'.format(port)
    else:
      pLine = pLine + '\n          src{0}_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;'.format(port-1)
    for nextPort in range (port+1, numOfPorts+1):
      pLine = pLine + '\n          src{0}_OutqReady   = 1\'b0  ;'.format(nextPort-1)
    pLine = pLine + '\n        end'
    pLine = pLine + '\n'
  # DEFAULT
  pLine = pLine + '\n        default:'
  pLine = pLine + '\n        begin'
  for port in range (0, numOfPorts+1):
    if port == 0:
      pLine = pLine + '\n          local_OutqReady   = 1\'b0  ;'.format(port)
    else:
      pLine = pLine + '\n          src{0}_OutqReady   = 1\'b0  ;'.format(port-1)
  pLine = pLine + '\n        end'
  pLine = pLine + '\n'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'

  pLine = pLine + '\n  // Mux the acknowledged source onto the output fifo inputs'
  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      case(nc_port_toNoc_state)'
  pLine = pLine + '\n'
  for port in range (0, numOfPorts+1):
    # READ
    if port == 0:
      pLine = pLine + '\n        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL:'.format(port)
      pLine = pLine + '\n          begin'
      pLine = pLine + '\n            fifo_write = local_toNoc_valid ;'
      pLine = pLine + '\n            cntl  = local_cntl_toNoc  ;'
      pLine = pLine + '\n            data  = local_data_toNoc  ;'
      pLine = pLine + '\n          end'
    else:
      pLine = pLine + '\n        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT{0}:'.format(port-1)
      pLine = pLine + '\n          begin'
      pLine = pLine + '\n            fifo_write = src{0}_toNoc_valid ;'.format(port-1)
      pLine = pLine + '\n            cntl  = src{0}_cntl_toNoc  ;'.format(port-1)
      pLine = pLine + '\n            data  = src{0}_data_toNoc  ;'.format(port-1)
      pLine = pLine + '\n          end'
    # ACK
    if port == 0:
      pLine = pLine + '\n        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL:'.format(port)
      pLine = pLine + '\n          begin'
      pLine = pLine + '\n            fifo_write = local_toNoc_valid ;'
      pLine = pLine + '\n            cntl  = local_cntl_toNoc  ;'
      pLine = pLine + '\n            data  = local_data_toNoc  ;'
      pLine = pLine + '\n          end'
    else:
      pLine = pLine + '\n        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT{0}:'.format(port-1)
      pLine = pLine + '\n          begin'
      pLine = pLine + '\n            fifo_write = src{0}_toNoc_valid ;'.format(port-1)
      pLine = pLine + '\n            cntl  = src{0}_cntl_toNoc  ;'.format(port-1)
      pLine = pLine + '\n            data  = src{0}_data_toNoc  ;'.format(port-1)
      pLine = pLine + '\n          end'
  pLine = pLine + '\n        default:'
  pLine = pLine + '\n          begin'
  pLine = pLine + '\n            fifo_write = \'d0 ;'.format(port-1)
  pLine = pLine + '\n            cntl  = \'d0 ;'.format(port-1)
  pLine = pLine + '\n            data  = \'d0 ;'.format(port-1)
  pLine = pLine + '\n          end'
  pLine = pLine + '\n'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()



  f = open('../HDL/common/noc_cntl_noc_port_output_control_assignments.vh', 'w')
  pLine = ""

  # Got from butterly simulations
  pLine = pLine + '\n  // Hard-code which nodes can be accessed via this output port'
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  assign Port_to_NoC[{0}].thisPort_destinationMask = sys__pe__port{0}_destinationMask ; // bitmask indicating which nodes accessed out of this port'.format(port)

  pLine = pLine + '\n  //--------------------------------------------------'
  pLine = pLine + '\n  // Outgoing requests to all ports'
  pLine = pLine + '\n '
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // Local output queue requests goes to all output ports'
    pLine = pLine + '\n  // Use destination mask to determine if this request goes out this port'
    pLine = pLine + '\n  assign Port_to_NoC[{0}].local_OutqReq          = local_destinationReq & |(local_destinationReqAddr & Port_to_NoC[{0}].thisPort_destinationMask)    ;'.format(port)
    pLine = pLine + '\n  assign Port_to_NoC[{0}].local_OutqReqAddr      = local_destinationReqAddr ;'.format(port)
    pLine = pLine + '\n '
  pLine = pLine + '\n '
  for port in range (0, numOfPorts):
    otherPort = 1
    pLine = pLine + '\n  // Remember, a packet coming in a port can be output the same port as some are not symmetrical'.format(port)
    pLine = pLine + '\n  // Connect Port {0}\'s port requests to all other ports (including its own input port)'.format(port)
    for otherPort in range (0, numOfPorts):
      pLine = pLine + '\n  // Use destination mask to determine if this request goes out this port'
      pLine = pLine + '\n  assign Port_to_NoC[{0}].src{1}_OutqReq          = Port_from_NoC[{1}].destinationReq & |(Port_from_NoC[{1}].destinationReqAddr & Port_to_NoC[{0}].thisPort_destinationMask)   ;'.format(port,otherPort)
      pLine = pLine + '\n  assign Port_to_NoC[{0}].src{1}_OutqReqAddr      = Port_from_NoC[{1}].destinationReqAddr ;'.format(port,otherPort)
    pLine = pLine + '\n '

  pLine = pLine + '\n  //---------------------------------------------------'
  pLine = pLine + '\n  // Outgoing Port acknowledge back to requesting ports'
  pLine = pLine + '\n '
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // Local output queue requests goes to all output ports'
    pLine = pLine + '\n  assign local_destinationAck[{0}]    =  Port_to_NoC[{0}].local_OutqAck    ;'.format(port)
    pLine = pLine + '\n  assign local_destinationReady[{0}]  =  Port_to_NoC[{0}].local_OutqReady  ;'.format(port)
    pLine = pLine + '\n '
  pLine = pLine + '\n '
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // Connect Port {0}\'s ack from the local input queue to bit 0 of the ack vector'.format(port)
    pLine = pLine + '\n  // The local input queue is the first destination for each ports input controller'.format(port)
    pLine = pLine + '\n  // The other ports are the next 3 destinations for each ports input controller'.format(port)
    pLine = pLine + '\n  assign Port_from_NoC[{0}].destinationAck[0]     =  local_port{0}_OutqAck     ;'.format(port)
    pLine = pLine + '\n  assign Port_from_NoC[{0}].destinationReady[0]   =  local_port{0}_OutqReady   ;'.format(port)
    pLine = pLine + '\n  // Connect Port {0}\'s "other" ports ack\'s to bits 1,2,3 of the ack vector'.format(port)
    for otherPort in range (0, numOfPorts):
      pLine = pLine + '\n  assign Port_from_NoC[{0}].destinationAck[{2}]     =  Port_to_NoC[{1}].src{0}_OutqAck     ;'.format(port,otherPort,otherPort+1)
      pLine = pLine + '\n  assign Port_from_NoC[{0}].destinationReady[{2}]   =  Port_to_NoC[{1}].src{0}_OutqReady   ;'.format(port,otherPort,otherPort+1)
    pLine = pLine + '\n '

  pLine = pLine + '\n  //---------------------------------------------------'
  pLine = pLine + '\n  // Outgoing Port source data '
  pLine = pLine + '\n '
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // Connect Port {0}\'s "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller'.format(port)
    pLine = pLine + '\n '
    for otherPort in range (0, numOfPorts):
      pLine = pLine + '\n  // Port{0}, source{1}'.format(port,otherPort)
      pLine = pLine + '\n  assign Port_to_NoC[{0}].src{1}_cntl_toNoc          = Port_from_NoC[{1}].cntl_fromNoc  ;'.format(port,otherPort)
      pLine = pLine + '\n  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can bereached from this port'
      pLine = pLine + '\n  // destination bit field is in the header, so condition on sop'
      pLine = pLine + '\n  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone'
      pLine = pLine + '\n  assign Port_to_NoC[{0}].src{1}_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[{1}].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;'.format(port,otherPort)
      pLine = pLine + '\n  assign Port_to_NoC[{0}].src{1}_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[{1}].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;'.format(port,otherPort)
      pLine = pLine + '\n  assign Port_to_NoC[{0}].src{1}_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[{1}].cntl_fromNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) ? (Port_from_NoC[{1}].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[{0}].thisPort_destinationMask) :'.format(port,otherPort)
      pLine = pLine + '\n                                                                                                                                                                          Port_from_NoC[{1}].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;'.format(port,otherPort)
      pLine = pLine + '\n  assign Port_to_NoC[{0}].src{1}_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[{1}].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;'.format(port,otherPort)
      pLine = pLine + '\n  assign Port_to_NoC[{0}].src{1}_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[{1}].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;'.format(port,otherPort)
      pLine = pLine + '\n  assign Port_to_NoC[{0}].src{1}_toNoc_valid                                                          = Port_from_NoC[{1}].fromNoc_valid ;'.format(port,otherPort)
      pLine = pLine + '\n '
    pLine = pLine + '\n '


  # Port output controller fifo outputs to NoC
  pLine = pLine + '\n  // Port outputs to NoC'.format(port)
  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  assign pe__noc__port{0}_cntl  = Port_to_NoC[{0}].fifo_read_cntl;'.format(port)
    pLine = pLine + '\n  assign pe__noc__port{0}_data  = Port_to_NoC[{0}].fifo_read_data;'.format(port)
    pLine = pLine + '\n  assign Port_to_NoC[{0}].fifo_read = ~Port_to_NoC[{0}].fifo_empty & ~noc__pe__port{0}_fc ;'.format(port)
    pLine = pLine + '\n  always @(posedge clk)'
    pLine = pLine + '\n      pe__noc__port{0}_valid  <= Port_to_NoC[{0}].fifo_read ;'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  # FIXME: Need to create a vector of Acks for each requestor
  # e.g. port2 sends out a single request that goes to the local input queue and ports 0, 1 and 3
  # All 4 destinations need to respond immediately telling the source a destination has accepted the request
  # In the case of multicast, more than one may accept the request. All destinations must assert ack in parallel simultaneously.
  # Only when all destinations have asserted their enable will the source start transferring the packet.
  # The destination will monitor the cntl bits for the EOP indication and deassert ack and enable when EOP is passing


  f.write(pLine)
  f.close()



  #---------------------------------------------------------------------------------------------------------
  # PE NoC Wires/connections
  
  f = open('../HDL/common/pe_noc_instance_wires.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  wire                                     pe__noc__port{0}_valid ;'.format(port)
    pLine = pLine + '\n  wire  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]   pe__noc__port{0}_cntl  ;'.format(port)
    pLine = pLine + '\n  wire  [`NOC_CONT_NOC_PORT_DATA_RANGE ]   pe__noc__port{0}_data  ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__pe__port{0}_fc    ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__pe__port{0}_valid ;'.format(port)
    pLine = pLine + '\n  wire  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]   noc__pe__port{0}_cntl  ;'.format(port)
    pLine = pLine + '\n  wire  [`NOC_CONT_NOC_PORT_DATA_RANGE ]   noc__pe__port{0}_data  ;'.format(port)
    pLine = pLine + '\n  wire                                     pe__noc__port{0}_fc    ;'.format(port)
    pLine = pLine + '\n  wire  [`PE_PE_ID_BITMASK_RANGE       ]   sys__pe__port{0}_destinationMask ;'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)                
  f.close()                     

  # Inter-PE connections performed by createPeConnections.py
  #f = open('../HDL/common/pe_noc_interpe_connections.vh', 'w')
  #pLine = ""

  #for pe in range (0, numOfPe):
  #  pLine = pLine + '\n  // PE {1}'.format(port,pe)
  #  for port in range (0, numOfPorts):
  #    pLine = pLine + '\n  // DEBUG - loopback port {0} of PE{1} to itself'.format(port,pe)
  #    pLine = pLine + '\n  // NoC port {0}'.format(port)
  #    pLine = pLine + '\n  assign pe_inst[{1}].noc__pe__port{0}_valid = pe_inst[{1}].pe__noc__port{0}_valid ;'.format(port,pe)
  #    pLine = pLine + '\n  assign pe_inst[{1}].noc__pe__port{0}_cntl  = pe_inst[{1}].pe__noc__port{0}_cntl  ;'.format(port,pe)
  #    pLine = pLine + '\n  assign pe_inst[{1}].noc__pe__port{0}_data  = pe_inst[{1}].pe__noc__port{0}_data  ;'.format(port,pe)
  #    pLine = pLine + '\n  assign pe_inst[{1}].noc__pe__port{0}_fc    = pe_inst[{1}].pe__noc__port{0}_fc   ;'.format(port,pe)
  #    pLine = pLine + '\n'        

  #f.write(pLine)                
  #f.close()                     

  
  f = open('../HDL/common/pe_noc_instance_ports.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_valid           ( pe__noc__port{0}_valid           ),'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_cntl            ( pe__noc__port{0}_cntl            ),'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_data            ( pe__noc__port{0}_data            ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_fc              ( noc__pe__port{0}_fc              ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_valid           ( noc__pe__port{0}_valid           ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_cntl            ( noc__pe__port{0}_cntl            ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_data            ( noc__pe__port{0}_data            ),'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_fc              ( pe__noc__port{0}_fc              ),'.format(port)
    pLine = pLine + '\n  .sys__pe__port{0}_destinationMask ( sys__pe__port{0}_destinationMask ),'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  
#! /usr/bin/env python

if __name__ == "__main__":

  import sys
  import os
  import math
  import random
  import re

  # extract number of pe's
  FoundPe = False
  FoundLane = False
  searchFile = open("../HDL/common/pe_array.vh", "r")
  for line in searchFile:
    if FoundPe == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_PE" in data[1]:
        numOfPe = int(data[2])
        FoundPe = True
  searchFile.close()


  # Now extract number of banks and dma ports from the mem_acc_cont.vh file
  FoundBanks = False
  FoundDmas = False
  searchFile = open("../HDL/common/mem_acc_cont.vh", "r")
  for line in searchFile:
    if FoundBanks == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "MEM_ACC_CONT_NUM_OF_MEMORY_BANKS" in data[1]:
        numOfBanks = int(data[2])
        FoundBanks = True
    if FoundDmas == False:
      data = re.split(r'\s{1,}', line)
      if "MEM_ACC_CONT_NUM_OF_PORTS" in data[1]:
        numOfMemPorts = int(data[2])
        FoundDmas = True
  searchFile.close()

  FoundLanes = False
  searchFile = open("../HDL/common/pe.vh", "r")
  for line in searchFile:
    if FoundLanes == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_EXEC_LANES" in data[1]:
        numOfExecLanes = int(data[2])
        FoundLanes = True
  searchFile.close()

  #numOfExecLanes = 16
  #numOfMemPorts = 32
  #numOfBanks = 64

  f = open('../HDL/common/mem_acc_cont_memory_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n`ifdef SYNTHESIS'
  for bank in range (0, numOfBanks):
    pLine = pLine + '\n            // Memory port {0}'.format(bank)
    pLine = pLine + '\n            memc__sram__read_address{0} ,'.format(bank)
    pLine = pLine + '\n            sram__memc__read_data{0} ,'.format(bank)
    pLine = pLine + '\n            memc__sram__write_address{0} ,'.format(bank)
    pLine = pLine + '\n            memc__sram__write_enable{0} ,'.format(bank)
    pLine = pLine + '\n            memc__sram__write_data{0} ,'.format(bank)
    pLine = pLine + '\n'        
  pLine = pLine + '\n`endif'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/mem_acc_cont_dma_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n'
  for bank in range (0, numOfMemPorts):
    pLine = pLine + '\n            // DMA port {0}'.format(bank)
    pLine = pLine + '\n            dma__memc__write_valid{0} ,'.format(bank)
    pLine = pLine + '\n            dma__memc__write_address{0} ,'.format(bank)
    pLine = pLine + '\n            dma__memc__write_data{0} ,'.format(bank)
    pLine = pLine + '\n            memc__dma__write_ready{0} ,'.format(bank)
    pLine = pLine + '\n            dma__memc__read_valid{0} ,'.format(bank)
    pLine = pLine + '\n            dma__memc__read_address{0} ,'.format(bank)
    pLine = pLine + '\n            memc__dma__read_data{0} ,'.format(bank)
    pLine = pLine + '\n            memc__dma__read_data_valid{0} ,'.format(bank)
    pLine = pLine + '\n            memc__dma__read_ready{0} ,'.format(bank)
    pLine = pLine + '\n            dma__memc__read_pause{0} ,'.format(bank)
    pLine = pLine + '\n'        

  f.write(pLine)
  f.close()

  f = open('../HDL/common/mem_acc_cont_memory_ports_declaration.vh', 'w')
  pLine = ""

  pLine = pLine + '\n`ifdef SYNTHESIS'
  for bank in range (0, numOfBanks):
    pLine = pLine + '\n            // Memory port {0}'.format(bank)
    pLine = pLine + '\n  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__read_address{0}  ;'.format(bank)
    pLine = pLine + '\n  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  sram__memc__read_data{0}     ;'.format(bank)
    pLine = pLine + '\n  output [`MEM_ACC_CONT_BANK_ADDRESS_RANGE  ]  memc__sram__write_address{0} ;'.format(bank)
    pLine = pLine + '\n  output                                       memc__sram__write_enable{0}  ;'.format(bank)
    pLine = pLine + '\n  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  memc__sram__write_data{0}    ;'.format(bank)
    pLine = pLine + '\n'        
  pLine = pLine + '\n`endif'

  f.write(pLine)
  f.close()


  f = open('../HDL/common/mem_acc_cont_dma_ports_declaration.vh', 'w')
  pLine = ""

  pLine = pLine + '\n\n\n\n'
  for dma in range (0, numOfMemPorts):       
    pLine = pLine + '\n  // DMA port {0}'.format(dma)
    pLine = pLine + '\n  input                                         dma__memc__write_valid{0} ;'.format(dma)
    pLine = pLine + '\n  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address{0} ;'.format(dma)
    pLine = pLine + '\n  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data{0} ;'.format(dma)
    pLine = pLine + '\n  output                                        memc__dma__write_ready{0} ;'.format(dma)
    pLine = pLine + '\n  input                                         dma__memc__read_valid{0} ;'.format(dma)
    pLine = pLine + '\n  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address{0} ;'.format(dma)
    pLine = pLine + '\n  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data{0} ;'.format(dma)
    pLine = pLine + '\n  output                                        memc__dma__read_data_valid{0} ;'.format(dma)
    pLine = pLine + '\n  output                                        memc__dma__read_ready{0} ;'.format(dma)
    pLine = pLine + '\n  input                                         dma__memc__read_pause{0} ;'.format(dma)
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  f = open('../HDL/common/mem_acc_cont_wires.vh', 'w')
  pLine = ""

  for dma in range (0, numOfMemPorts):
    # Read datapath
    pLine = pLine + '\n  // DMA port {0} Read datapath signals'.format(dma)
    pLine = pLine + '\n  wire [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data{0}       ; '.format(dma)
    pLine = pLine + '\n  wire                                        memc__dma__read_data_valid{0} ; '.format(dma)
    pLine = pLine + '\n'

  pLine = pLine + '\n'


  # calculate how many bits to determine the bank
  bankMsb = math.log(numOfBanks,2)

  # What bank is the LDST accessing
  pLine = pLine + '\n  // What bank is the LDST accessing'
  for bank in range (0, numOfBanks):
   pLine = pLine + '\n  // Bank{0}'.format(bank)
   pLine = pLine + '\n  wire ldst_write_addr_to_bank{0}      =  (ldst__memc__write_address[`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-{2}] == {1}\'d{0})  ;'.format(bank,int(bankMsb),int(bankMsb-1))
   pLine = pLine + '\n  wire ldst_read_addr_to_bank{0}       =  (ldst__memc__read_address[`MEM_ACC_CONT_MEMORY_ADDRESS_MSB  : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-{2}] == {1}\'d{0})  ;'.format(bank,int(bankMsb),int(bankMsb-1))
   #pLine = pLine + '\n  wire ldst_write_addr_to_bank{0}      =  (ldst__memc__write_address[`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB] == 1\'d{0})  ;'.format(bank)
   #pLine = pLine + '\n  wire ldst_read_addr_to_bank{0}       =  (ldst__memc__read_address[`MEM_ACC_CONT_MEMORY_ADDRESS_MSB  : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB] == 1\'d{0})  ;'.format(bank)
   pLine = pLine + '\n  wire ldst_write_request_to_bank{0}   =  ldst_write_addr_to_bank{0}    & ldst__memc__write_valid   ;                                         '.format(bank)
   pLine = pLine + '\n  wire ldst_write_access_to_bank{0}    =  ldst_write_request_to_bank{0} & memc__ldst__write_ready   ;  // request and ready to accept request '.format(bank)
   pLine = pLine + '\n  wire ldst_read_request_to_bank{0}    =  ldst_read_addr_to_bank{0}      & ldst__memc__read_valid   ;                                         '.format(bank) 
   pLine = pLine + '\n  wire ldst_read_access_to_bank{0}     =  ldst_read_request_to_bank{0}   & memc__ldst__read_ready   ;                                         '.format(bank)
  pLine = pLine + '\n'

  # What banks are the DMA's accessing
  pLine = pLine + '\n  // What banks are the DMA\'s accessing'
  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n  // DMA {0}'.format(dma)
    pLine = pLine + '\n  wire read_pause{0}     =  dma__memc__read_pause{0}   ;  '.format(dma,bank)
    for bank in range (0, numOfBanks):
      pLine = pLine + '\n  // DMA {0}, bank{1}'.format(dma,bank)
      pLine = pLine + '\n  wire dma_write_addr{0}_to_bank{1}      =  (dma__memc__write_address{0}[`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-{3}] == {2}\'d{1})  ;'.format(dma,bank,int(bankMsb),int(bankMsb-1))
      pLine = pLine + '\n  wire dma_read_addr{0}_to_bank{1}       =  (dma__memc__read_address{0}[`MEM_ACC_CONT_MEMORY_ADDRESS_MSB  : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-{3}] == {2}\'d{1})  ;'.format(dma,bank,int(bankMsb),int(bankMsb-1))
      pLine = pLine + '\n  // Signals indicating whether a request is being made and if the request is accepted'
      pLine = pLine + '\n  wire write_request{0}_to_bank{1}   =  dma_write_addr{0}_to_bank{1}  & dma__memc__write_valid{0}  ;                                         '.format(dma,bank)
      pLine = pLine + '\n  wire write_access{0}_to_bank{1}    =  write_request{0}_to_bank{1}   & memc__dma__write_ready{0}  ;  // request and ready to accept request '.format(dma,bank)
      pLine = pLine + '\n  wire read_request{0}_to_bank{1}    =  dma_read_addr{0}_to_bank{1}   & dma__memc__read_valid{0}   ;                                         '.format(dma,bank) 
      pLine = pLine + '\n  wire read_access{0}_to_bank{1}     =  read_request{0}_to_bank{1}    & memc__dma__read_ready{0}   ;                                         '.format(dma,bank)


  f.write(pLine)
  f.close()

  # inside bank_fsm generate
  # DMA accesses
  f = open('../HDL/common/mem_acc_cont_bank_fsm_dma_access_wires.vh', 'w')
  pLine = ""
  pLine = pLine + '\n  // DMA accesses'.format(dma)
  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n        wire read_pause{0}        ;'.format(dma)
    pLine = pLine + '\n        wire read_request{0}      ;'.format(dma)
    pLine = pLine + '\n        wire read_access{0}       ;'.format(dma)
    pLine = pLine + '\n        wire write_request{0}     ;'.format(dma)
    pLine = pLine + '\n        wire write_access{0}      ;'.format(dma)
    pLine = pLine + '\n        wire read_ready_strm{0}   ;  // ignore all requests until we deassert ready'.format(dma)
    pLine = pLine + '\n        wire write_ready_strm{0}  ;  // ignore all requests until we deassert ready'.format(dma)

  f.write(pLine)
  f.close()

  f = open('../HDL/common/mem_acc_cont_bank_fsm_state_definitions.vh', 'w')
  pLine = ""

  numOfBankFsmStateBits = numOfMemPorts*2+5
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n// MEM_ACC_CONT_ARBITER_STATE width'
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n`define MEM_ACC_CONT_STATE_MSB            {0}'.format(numOfBankFsmStateBits-1)
  pLine = pLine + '\n`define MEM_ACC_CONT_STATE_LSB            0'
  pLine = pLine + '\n`define MEM_ACC_CONT_STATE_SIZE           (`MEM_ACC_CONT_STATE_MSB - `MEM_ACC_CONT_STATE_LSB +1)'
  pLine = pLine + '\n`define MEM_ACC_CONT_STATE_RANGE           `MEM_ACC_CONT_STATE_MSB : `MEM_ACC_CONT_STATE_LSB'
  pLine = pLine + '\n'
  pLine = pLine + '\n//------------------------------------------------------------------------------------------------'
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n// MEM_ACC_CONT state machine states'
  pLine = pLine + '\n//------------------------------------------------'
  pLine = pLine + '\n'
  pLine = pLine + '\n`define MEM_ACC_CONT_WAIT                    {0}\'d1'.format(numOfBankFsmStateBits)
  pLine = pLine + '\n`define MEM_ACC_CONT_DMA                     {0}\'d2'.format(numOfBankFsmStateBits)
  pLine = pLine + '\n`define MEM_ACC_CONT_LDST                    {0}\'d4'.format(numOfBankFsmStateBits)
  pLine = pLine + '\n`define MEM_ACC_CONT_LDST_READ_ACCESS        {0}\'d8'.format(numOfBankFsmStateBits)
  pLine = pLine + '\n`define MEM_ACC_CONT_LDST_WRITE_ACCESS       {0}\'d16'.format(numOfBankFsmStateBits)
  dma = 0
  bit = 5
  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n`define MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS   {1}\'d{2}'.format(dma,numOfBankFsmStateBits,pow(2,bit))
    pLine = pLine + '\n`define MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS  {1}\'d{2}'.format(dma,numOfBankFsmStateBits,pow(2,bit+1))
    bit = bit+2


  f.write(pLine)
  f.close()

  f = open('../HDL/common/mem_acc_cont_bank_fsm_state_transitions.vh', 'w')
  pLine = ""
  pLine = pLine + '\n           `MEM_ACC_CONT_DMA:'
  pLine = pLine + '\n             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :'
  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n                                  (  write_request{0}  )  ? `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS : '.format(dma)
  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n                                  (  read_request{0} && ~read_pause{0}   )  ? `MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS  : '.format(dma)
  pLine = pLine + '\n                                                          `MEM_ACC_CONT_DMA                    ; '

  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n           `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS:'.format(dma)
    pLine = pLine + '\n             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :'

    for nextDma in range (dma+1, numOfMemPorts):
      pLine = pLine + '\n                                  (  write_request{0}  )  ? `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS : '.format(nextDma)
    for nextDma in range (0, dma+1):
      pLine = pLine + '\n                                  (  write_request{0}  )  ? `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS : '.format(nextDma)
    for nextDma in range (dma+1, numOfMemPorts):
      pLine = pLine + '\n                                  (  read_request{0} && ~read_pause{0}   )  ? `MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS  : '.format(nextDma)
    for nextDma in range (0, dma+1):
      pLine = pLine + '\n                                  (  read_request{0} && ~read_pause{0}   )  ? `MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS  : '.format(nextDma)

    pLine = pLine + '\n                                                          `MEM_ACC_CONT_DMA                    ; '

  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n           `MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS:'.format(dma)
    pLine = pLine + '\n             mem_acc_state_next = ( ~cntl_granted     )  ? `MEM_ACC_CONT_WAIT                   :'

    for nextDma in range (dma+1, numOfMemPorts):
      pLine = pLine + '\n                                  (  write_request{0}  )  ? `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS : '.format(nextDma)
    for nextDma in range (0, dma+1):
      pLine = pLine + '\n                                  (  write_request{0}  )  ? `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS : '.format(nextDma)
    for nextDma in range (dma+1, numOfMemPorts):
      pLine = pLine + '\n                                  (  read_request{0} && ~read_pause{0}   )  ? `MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS  : '.format(nextDma)
    for nextDma in range (0, dma+1):
      pLine = pLine + '\n                                  (  read_request{0} && ~read_pause{0}   )  ? `MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS  : '.format(nextDma)

    pLine = pLine + '\n                                                          `MEM_ACC_CONT_DMA                    ; '

  f.write(pLine)
  f.close()

  f = open('../HDL/common/mem_acc_cont_bank_fsm_dma_port_ready.vh', 'w')
  pLine = ""

  # port ready when transitioning to the state
  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n          assign read_ready_strm{0}   = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS)  ;'.format(dma)
    pLine = pLine + '\n          assign write_ready_strm{0}  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS) ;'.format(dma)

  f.write(pLine)
  f.close()


  # right after bank_fsm generate
  f = open('../HDL/common/mem_acc_cont_bank_fsm_connections.vh', 'w')
  pLine = ""

  # Pass signals to/from the FSM's in the generate function
  pLine = pLine + '\n  '
  pLine = pLine + '\n  // Pass signals to/from the FSM\'s in the generate function'.format(dma)
  for bank in range (0, numOfBanks):
    pLine = pLine + '\n  // Bank {0}'.format(bank)
    pLine = pLine + '\n  assign bank_fsm[{0}].ldst_read_request        = ldst_read_request_to_bank{0}   ;'.format(bank)
    pLine = pLine + '\n  assign bank_fsm[{0}].ldst_read_access         = ldst_read_access_to_bank{0}    ;'.format(bank)
    pLine = pLine + '\n  '
    pLine = pLine + '\n  assign bank_fsm[{0}].ldst_write_request       = ldst_write_request_to_bank{0}  ;'.format(bank)
    pLine = pLine + '\n  assign bank_fsm[{0}].ldst_write_access        = ldst_write_access_to_bank{0}   ;'.format(bank)
    pLine = pLine + '\n  //'
    for dma in range (0, numOfMemPorts):
       pLine = pLine + '\n  assign bank_fsm[{0}].read_pause{1}              = read_pause{1}                    ;'.format(bank,dma)
       pLine = pLine + '\n  assign bank_fsm[{0}].read_request{1}            = read_request{1}_to_bank{0}       ;'.format(bank,dma)
       pLine = pLine + '\n  assign bank_fsm[{0}].read_access{1}             = read_access{1}_to_bank{0}        ;'.format(bank,dma)
       pLine = pLine + '\n  assign bank_fsm[{0}].write_request{1}            = write_request{1}_to_bank{0}     ;'.format(bank,dma)
       pLine = pLine + '\n  assign bank_fsm[{0}].write_access{1}             = write_access{1}_to_bank{0}      ;'.format(bank,dma)
       pLine = pLine + '\n  '

  # each dma port will get a ready from one of the bank fsm's
  pLine = pLine + '\n  assign memc__ldst__read_ready = bank_fsm[0].ldst_read_ready'
  for bank in range (1, numOfBanks):
    pLine = pLine + '\n                                 | bank_fsm[{0}].ldst_read_ready'.format(bank)
  pLine = pLine + '\n                                 ;'
  pLine = pLine + '\n  assign memc__ldst__write_ready = bank_fsm[0].ldst_write_ready'
  for bank in range (1, numOfBanks):
    pLine = pLine + '\n                                  | bank_fsm[{0}].ldst_write_ready'.format(bank)
  pLine = pLine + '\n                                  ;'
  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n  assign memc__dma__write_ready{0} = bank_fsm[0].write_ready_strm{0}'.format(dma,bank)
    for bank in range (1, numOfBanks):
      pLine = pLine + '\n                                  | bank_fsm[{1}].write_ready_strm{0}'.format(dma,bank)
    pLine = pLine + '\n                                  ;'
  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n  assign memc__dma__read_ready{0} = bank_fsm[0].read_ready_strm{0} '.format(dma,bank)
    for bank in range (1, numOfBanks):
      pLine = pLine + '\n                                  | bank_fsm[{1}].read_ready_strm{0} '.format(dma,bank)
    pLine = pLine + '\n                                  ;'
  #  pLine = pLine + '\n   assign memc__ldst__write_ready    = bank_fsm[0].ldst_write_ready  | bank_fsm[1].ldst_write_ready   ;         
  #   pLine = pLine + '\n   assign memc__dma__read_ready0     = bank_fsm[0].read_ready_strm0  | bank_fsm[1].read_ready_strm0   ;         
  #    pLine = pLine + '\n   assign memc__dma__write_ready0    = bank_fsm[0].write_ready_strm0 | bank_fsm[1].write_ready_strm0  ;         

  f.write(pLine)
  f.close()


  f = open('../HDL/common/mem_acc_cont_bank_mem_dma_declarations.vh', 'w')
  pLine = ""

  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n        wire                                      read_data_strm{0}_valid_next  ;  '.format(dma)
    pLine = pLine + '\n        reg                                       read_data_strm{0}_valid       ;  '.format(dma)
    pLine = pLine + '\n        wire                                      dma_read_addr{0}_to_bank        ;  '.format(dma)
    pLine = pLine + '\n        wire                                      dma_write_addr{0}_to_bank       ;  '.format(dma)

  f.write(pLine)
  f.close()


  f = open('../HDL/common/mem_acc_cont_bank_mem_assignments.vh', 'w')
  pLine = ""

  pLine = pLine + '\n       assign read_data_ldst_valid_next   = ( mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS    );'

  pLine = pLine + '\n       assign read_address  = (( dma_read_addr0_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS    )) ? dma__memc__read_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :'
  for dma in range (1, numOfMemPorts):
     pLine = pLine + '\n                              (( dma_read_addr{0}_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS    )) ? dma__memc__read_address{0}[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :'.format(dma)
  pLine = pLine + '\n                                                                                                                                 ldst__memc__read_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] ;'
                                                                                                                          
  for dma in range (0, numOfMemPorts):
     pLine = pLine + '\n       assign read_data_strm{0}_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM{0}_READ_ACCESS    );'.format(dma)

  pLine = pLine + '\n       assign write_address =      (( dma_write_addr0_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS    )) ? dma__memc__write_address0[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :'
  for dma in range (1, numOfMemPorts):
     pLine = pLine + '\n                                   (( dma_write_addr{0}_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS    )) ? dma__memc__write_address{0}[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] :'.format(dma)
  pLine = pLine + '\n                                                                                                                                        ldst__memc__write_address[`MEM_ACC_CONT_BANK_ADDRESS_RANGE] ;'
                                                                                                                          
  pLine = pLine + '\n       assign write_data    =      (( dma_write_addr0_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS    )) ? dma__memc__write_data0[`MEM_ACC_CONT_BANK_DATA_RANGE] :'
  for dma in range (1, numOfMemPorts):
     pLine = pLine + '\n                                   (( dma_write_addr{0}_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS    )) ? dma__memc__write_data{0}[`MEM_ACC_CONT_BANK_DATA_RANGE] :'.format(dma)
  pLine = pLine + '\n                                                                                                                                        ldst__memc__write_data[`MEM_ACC_CONT_BANK_DATA_RANGE] ;'
                                                                                                                          
  pLine = pLine + '\n       assign write_enable  =      (( dma_write_addr0_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS    )) ? dma__memc__write_valid0 :'
  for dma in range (1, numOfMemPorts):
     pLine = pLine + '\n                                   (( dma_write_addr{0}_to_bank ) && ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM{0}_WRITE_ACCESS    )) ? dma__memc__write_valid{0} :'.format(dma)
  pLine = pLine + '\n                                                                                                                                        ldst__memc__write_valid ;'
                                                                                                                          

  pLine = pLine + '\n       // outputs '
  pLine = pLine + '\n       always @(posedge clk)'
  pLine = pLine + '\n         begin'
  pLine = pLine + '\n           read_data              <= ( reset_poweron ) ? \'b0  : read_data_next              ;'
  pLine = pLine + '\n           read_data_ldst_valid   <= ( reset_poweron ) ? \'b0  : read_data_ldst_valid_next   ;'
  for dma in range (0, numOfMemPorts):
    pLine = pLine + '\n           read_data_strm{0}_valid  <= ( reset_poweron ) ? \'b0  : read_data_strm{0}_valid_next  ;'.format(dma)
  pLine = pLine + '\n         end'

  f.write(pLine)
  f.close()


  f = open('../HDL/common/mem_acc_cont_bank_mem_connections.vh', 'w')
  pLine = ""

  for bank in range (0, numOfBanks):
    pLine = pLine + '\n  assign bank_mem[{0}].mem_acc_state_next = bank_fsm[{0}].mem_acc_state_next ;'.format(bank)
  pLine = pLine + '\n'


  pLine = pLine + '\n  assign memc__ldst__read_data        = ( ldst_read_addr_to_bank0 )  ?  bank_mem[0].read_data             : '
  for bank in range (1, numOfBanks-1):
    pLine = pLine + '\n                                        ( ldst_read_addr_to_bank{0} )  ?  bank_mem[{0}].read_data             : '.format(bank,dma)
  pLine = pLine + '\n                                                                        bank_mem[{0}].read_data             ;'.format(numOfBanks-1)

  pLine = pLine + '\n  assign memc__ldst__read_data_valid  = ( ldst_read_addr_to_bank0 && (bank_fsm[0].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[0].read_data_ldst_valid : '
  for bank in range (1, numOfBanks):
    pLine = pLine + '\n                                        ( ldst_read_addr_to_bank{0} && (bank_fsm[{0}].mem_acc_state == `MEM_ACC_CONT_LDST_READ_ACCESS))  ?  bank_mem[{0}].read_data_ldst_valid :'.format(bank)
  pLine = pLine + '\n                                                                                                                                        1\'b0                             ;'


  
  for dma in range (0, numOfMemPorts):
    bank=0
    pLine = pLine + '\n  assign memc__dma__read_data{1}        = ( dma_read_addr{1}_to_bank{0} )  ?  bank_mem[{0}].read_data             : '.format(bank,dma)
    for bank in range (1, numOfBanks-1):
      pLine = pLine + '\n                                        ( dma_read_addr{1}_to_bank{0} )  ?  bank_mem[{0}].read_data             : '.format(bank,dma)
    pLine = pLine + '\n                                                                        bank_mem[{0}].read_data             ;'.format(numOfBanks-1)
 
  for dma in range (0, numOfMemPorts):
    bank=0
    pLine = pLine + '\n  assign memc__dma__read_data_valid{1}  = ( dma_read_addr{1}_to_bank0 && (bank_fsm[{0}].mem_acc_state == `MEM_ACC_CONT_DMA_STRM{1}_READ_ACCESS))  ?  bank_mem[{0}].read_data_strm{1}_valid : '.format(bank,dma)
    for bank in range (1, numOfBanks):
      pLine = pLine + '\n                                        ( dma_read_addr{1}_to_bank{0} && (bank_fsm[{0}].mem_acc_state == `MEM_ACC_CONT_DMA_STRM{1}_READ_ACCESS))  ?  bank_mem[{0}].read_data_strm{1}_valid :'.format(bank,dma)
    pLine = pLine + '\n                                                                                                                                             1\'b0                              ;'
    
 
  for bank in range (0, numOfBanks):
    for dma in range (0, numOfMemPorts):
     pLine = pLine + '\n  assign bank_mem[{0}].dma_read_addr{1}_to_bank  = dma_read_addr{1}_to_bank{0}  ;'.format(bank,dma)
     pLine = pLine + '\n  assign bank_mem[{0}].dma_write_addr{1}_to_bank = dma_write_addr{1}_to_bank{0} ;'.format(bank,dma)
  

  f.write(pLine)
  f.close()

  f = open('../HDL/common/mem_acc_cont_bank_mem_sram_connections.vh', 'w')
  pLine = ""

  pLine = pLine + '\n`ifdef SYNTHESIS'
  for bank in range (0, numOfBanks):
    pLine = pLine + '\n  // Memory port {0}'.format(bank)
    pLine = pLine + '\n  assign memc__sram__read_address{0}  = bank_mem[{0}].read_address  ;'.format(bank)
    pLine = pLine + '\n  assign bank_mem[{0}].read_data_next = sram__memc__read_data{0}    ;'.format(bank)
    pLine = pLine + '\n  assign memc__sram__write_address{0} = bank_mem[{0}].write_address ;'.format(bank)
    pLine = pLine + '\n  assign memc__sram__write_enable{0}  = bank_mem[{0}].write_enable  ;'.format(bank)
    pLine = pLine + '\n  assign memc__sram__write_data{0}    = bank_mem[{0}].write_data    ;'.format(bank)
    pLine = pLine + '\n'        
  pLine = pLine + '\n`endif'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/mem_acc_cont_instance_ports.vh', 'w')
  pLine = ""

  numOfMemPortsPerExecLane = numOfMemPorts/numOfExecLanes

  for lane in range (0, numOfExecLanes):
    for dma in range (0, numOfMemPortsPerExecLane):
      dmaPort = lane*numOfMemPortsPerExecLane+dma
      pLine = pLine + '\n                // Memory Port {0}                 '.format(dma)
      pLine = pLine + '\n                .dma__memc__write_valid{2}       ( dma__memc__lane{0}_write_valid{1}     ),'.format(lane,dma,dmaPort)
      pLine = pLine + '\n                .dma__memc__write_address{2}     ( dma__memc__lane{0}_write_address{1}   ),'.format(lane,dma,dmaPort)
      pLine = pLine + '\n                .dma__memc__write_data{2}        ( dma__memc__lane{0}_write_data{1}      ),'.format(lane,dma,dmaPort)
      pLine = pLine + '\n                .memc__dma__write_ready{2}       ( memc__dma__lane{0}_write_ready{1}     ),'.format(lane,dma,dmaPort)
      pLine = pLine + '\n                .dma__memc__read_valid{2}        ( dma__memc__lane{0}_read_valid{1}      ),'.format(lane,dma,dmaPort)
      pLine = pLine + '\n                .dma__memc__read_address{2}      ( dma__memc__lane{0}_read_address{1}    ),'.format(lane,dma,dmaPort)
      pLine = pLine + '\n                .memc__dma__read_data{2}         ( memc__dma__lane{0}_read_data{1}       ),'.format(lane,dma,dmaPort)
      pLine = pLine + '\n                .memc__dma__read_data_valid{2}   ( memc__dma__lane{0}_read_data_valid{1} ),'.format(lane,dma,dmaPort)
      pLine = pLine + '\n                .memc__dma__read_ready{2}        ( memc__dma__lane{0}_read_ready{1}      ),'.format(lane,dma,dmaPort)
      pLine = pLine + '\n                .dma__memc__read_pause{2}        ( dma__memc__lane{0}_read_pause{1}      ),'.format(lane,dma,dmaPort)

  f.write(pLine)
  f.close()

  f = open('../HDL/common/mem_acc_cont_unused_streams.vh', 'w')
  pLine = ""

  for dma in range (2, numOfMemPorts):
    pLine = pLine + '\n                // Stream {0}                 '.format(dma)
    pLine = pLine + '\n                .dma__memc__write_valid{0}       ( 1\'d0  ),'.format(dma)
    pLine = pLine + '\n                .dma__memc__write_address{0}     (17\'d0  ),'.format(dma)
    pLine = pLine + '\n                .dma__memc__write_data{0}        (32\'d0  ),'.format(dma)
    pLine = pLine + '\n                .memc__dma__write_ready{0}       (  ),'.format(dma)
    pLine = pLine + '\n                .dma__memc__read_valid{0}        ( 1\'d0  ),'.format(dma)
    pLine = pLine + '\n                .dma__memc__read_address{0}      (17\'d0  ),'.format(dma)
    pLine = pLine + '\n                .memc__dma__read_data{0}         (  ),'.format(dma)
    pLine = pLine + '\n                .memc__dma__read_data_valid{0}   (  ),'.format(dma)
    pLine = pLine + '\n                .memc__dma__read_ready{0}        (  ),'.format(dma)
    pLine = pLine + '\n                .dma__memc__read_pause{0}        ( 1\'d0  ),'.format(dma)

  f.write(pLine)
  f.close()

  # Generate datapath instance connections
  # e.g. we will instantiate datapaths based on number of DMA ports, one for each pair of ports

  f = open('../HDL/common/pe_stOp_control_to_stOp_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  wire   [`STREAMING_OP_CNTL_OPERATION_RANGE ] scntl__sdp__lane{0}_stOp_operation ;'.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  wire   [`STREAMING_OP_CNTL_OPERATION_RANGE ] scntl__sdp__lane{0}_dma_operation ;'.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  wire                                                  scntl__sdp__lane{0}_strm{1}_read_enable         ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                                  scntl__sdp__lane{0}_strm{1}_write_enable        ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                                  sdp__scntl__lane{0}_strm{1}_read_ready          ;  // from dma'.format(lane,strm)
      pLine = pLine + '\n  wire                                                  sdp__scntl__lane{0}_strm{1}_write_ready         ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                                  sdp__scntl__lane{0}_strm{1}_read_complete       ;  // from dma'.format(lane,strm)
      pLine = pLine + '\n  wire                                                  sdp__scntl__lane{0}_strm{1}_write_complete      ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_STRM_ADDRESS_RANGE            ]     scntl__sdp__lane{0}_strm{1}_read_start_address  ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_STRM_ADDRESS_RANGE            ]     scntl__sdp__lane{0}_strm{1}_write_start_address ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_DATA_TYPES_RANGE              ]     scntl__sdp__lane{0}_type{1}                     ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE        ]     scntl__sdp__lane{0}_num_of_types{1}             ;'.format(lane,strm)
      if strm == 0:
         pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane{0}_strm{1}_stOp_source      ;                      '.format(lane,strm)
         pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane{0}_strm{1}_stOp_destination ;                      '.format(lane,strm)
      else:
         pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane{0}_strm{1}_stOp_source      ;                      '.format(lane,strm)
         pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane{0}_strm{1}_stOp_destination ;                      '.format(lane,strm)

  pLine = pLine + '\n'


  f.write(pLine)
  f.close()


  f = open('../HDL/common/pe_stOp_to_cntl_regfile_connection_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  wire                                    reg__sdp__lane{0}_ready    ;'.format(lane)
    pLine = pLine + '\n  wire                                    sdp__reg__lane{0}_valid    ;'.format(lane)
    pLine = pLine + '\n  wire   [`STREAMING_OP_RESULT_RANGE   ]  sdp__reg__lane{0}_data     ;'.format(lane)
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_scntl_to_simd_regfile_connection_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  wire                                    reg__scntl__lane{0}_ready    ;'.format(lane)
    pLine = pLine + '\n  wire                                    scntl__reg__lane{0}_valid    ;'.format(lane)
    pLine = pLine + '\n  wire   [`STREAMING_OP_RESULT_RANGE   ]  scntl__reg__lane{0}_data     ;'.format(lane)
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_dma_memc_connection_wires.vh', 'w')
  pLine = ""

  for strm in range (0, 2):
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n  wire                                          dma__memc__lane{0}_write_valid{1}           ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__lane{0}_write_address{1}         ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__lane{0}_write_data{1}            ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                          memc__dma__lane{0}_write_ready{1}           ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                          dma__memc__lane{0}_read_valid{1}            ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__lane{0}_read_address{1}          ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                          dma__memc__lane{0}_read_pause{1}            ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__lane{0}_read_data{1}             ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                          memc__dma__lane{0}_read_data_valid{1}       ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                          memc__dma__lane{0}_read_ready{1}            ;'.format(lane,strm)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()


  f = open('../HDL/common/pe_std_to_stOp_connection_wires.vh', 'w')
  pLine = ""

  for strm in range (0, 2):
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n  // Lane {0}, Stream {1}'.format(lane,strm)
      pLine = pLine + '\n  wire                                         sdp__std__lane{0}_strm{1}_ready         ;'.format(lane,strm)
      pLine = pLine + '\n  wire  [`DMA_CONT_STRM_CNTL_RANGE     ]       std__sdp__lane{0}_strm{1}_cntl          ;'.format(lane,strm)
      pLine = pLine + '\n  wire  [`STREAMING_OP_DATA_RANGE      ]       std__sdp__lane{0}_strm{1}_data          ;'.format(lane,strm)
      #pLine = pLine + '\n  wire  [`STREAMING_OP_DATA_RANGE      ]       std__sdp__lane{0}_strm{1}_data_mask     ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                         std__sdp__lane{0}_strm{1}_data_valid    ;'.format(lane,strm)
    pLine = pLine + '\n'


    #pLine = pLine + '\n  assign        = stOp_lane[{0}].;'.format(lane)
    #pLine = pLine + '\n  assign stOp_lane[{0}].=     ;'.format(lane)

  f.write(pLine)
  f.close()


  f = open('../HDL/common/pe_stOp_control_to_stOp_connections.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign stOp_lane[{0}].scntl__stOp__operation    = scntl__sdp__lane{0}_stOp_operation   ;'.format(lane)
    for strm in range (0, 2):
      pLine = pLine + '\n  assign stOp_lane[{0}].scntl__stOp__strm{1}_source       = scntl__sdp__lane{0}_strm{1}_stOp_source      ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].scntl__stOp__strm{1}_destination  = scntl__sdp__lane{0}_strm{1}_stOp_destination ;'.format(lane,strm)
    for strm in range (0, 2):
      pLine = pLine + '\n  assign stOp_lane[{0}].scntl__stOp__strm{1}_enable       = scntl__sdp__lane{0}_strm{1}_stOp_enable      ;'.format(lane,strm)
      pLine = pLine + '\n  assign sdp__scntl__lane{0}_strm{1}_stOp_ready           = stOp_lane[{0}].stOp__scntl__strm{1}_ready    ;'.format(lane,strm)
      pLine = pLine + '\n  assign sdp__scntl__lane{0}_strm{1}_stOp_complete        = stOp_lane[{0}].stOp__scntl__strm{1}_complete ;'.format(lane,strm)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_stOp_control_to_dma_connections.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign stOp_lane[{0}].scntl__dma__operation    = scntl__sdp__lane{0}_dma_operation ;'.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  assign stOp_lane[{0}].scntl__dma__strm{1}_read_enable         = scntl__sdp__lane{0}_strm{1}_read_enable            ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].scntl__dma__strm{1}_write_enable        = scntl__sdp__lane{0}_strm{1}_write_enable           ;'.format(lane,strm)
      pLine = pLine + '\n  assign sdp__scntl__lane{0}_strm{1}_read_ready                 = stOp_lane[{0}].dma__scntl__strm{1}_read_ready      ;'.format(lane,strm)
      pLine = pLine + '\n  assign sdp__scntl__lane{0}_strm{1}_write_ready                = stOp_lane[{0}].dma__scntl__strm{1}_write_ready     ;'.format(lane,strm)
      pLine = pLine + '\n  assign sdp__scntl__lane{0}_strm{1}_read_complete              = stOp_lane[{0}].dma__scntl__strm{1}_read_complete   ;'.format(lane,strm)
      pLine = pLine + '\n  assign sdp__scntl__lane{0}_strm{1}_write_complete             = stOp_lane[{0}].dma__scntl__strm{1}_write_complete  ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].scntl__dma__strm{1}_read_start_address  = scntl__sdp__lane{0}_strm{1}_read_start_address     ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].scntl__dma__strm{1}_write_start_address = scntl__sdp__lane{0}_strm{1}_write_start_address    ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].scntl__dma__type{1}                     = scntl__sdp__lane{0}_type{1}                        ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].scntl__dma__num_of_types{1}             = scntl__sdp__lane{0}_num_of_types{1}                ;'.format(lane,strm)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_stOp_to_cntl_regfile_connections.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign stOp_lane[{0}].reg__stOp__ready = reg__sdp__lane{0}_ready          ;'.format(lane)
    pLine = pLine + '\n  assign sdp__reg__lane{0}_valid         = stOp_lane[{0}].stOp__reg__valid  ;'.format(lane)
    pLine = pLine + '\n  assign sdp__reg__lane{0}_data          = stOp_lane[{0}].stOp__reg__data   ;'.format(lane)
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()


  f = open('../HDL/common/pe_dma_to_memc_connections.vh', 'w')
  pLine = ""

  for strm in range (0, 2):
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n  assign  dma__memc__lane{0}_write_valid{1}            = stOp_lane[{0}].dma__memc__write_valid{1}    ;'.format(lane,strm)
      pLine = pLine + '\n  assign  dma__memc__lane{0}_write_address{1}          = stOp_lane[{0}].dma__memc__write_address{1}  ;'.format(lane,strm)
      pLine = pLine + '\n  assign  dma__memc__lane{0}_write_data{1}             = stOp_lane[{0}].dma__memc__write_data{1}     ;'.format(lane,strm)
      pLine = pLine + '\n  assign  dma__memc__lane{0}_read_valid{1}             = stOp_lane[{0}].dma__memc__read_valid{1}     ;'.format(lane,strm)
      pLine = pLine + '\n  assign  dma__memc__lane{0}_read_address{1}           = stOp_lane[{0}].dma__memc__read_address{1}   ;'.format(lane,strm)
      pLine = pLine + '\n  assign  dma__memc__lane{0}_read_pause{1}             = stOp_lane[{0}].dma__memc__read_pause{1}     ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].memc__dma__write_ready{1}      = memc__dma__lane{0}_write_ready{1}           ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].memc__dma__read_data{1}        = memc__dma__lane{0}_read_data{1}             ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].memc__dma__read_data_valid{1}  = memc__dma__lane{0}_read_data_valid{1}       ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].memc__dma__read_ready{1}       = memc__dma__lane{0}_read_ready{1}            ;'.format(lane,strm)
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_stack_interface_to_stOp_connections.vh', 'w')
  pLine = ""

  for strm in range (0, 2):
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n  // Lane {0}, Stream {1}'.format(lane,strm)
      pLine = pLine + '\n  assign stOp__sti__lane{0}_strm{1}_ready             =  stOp_lane[{0}].stOp__sti__strm{1}_ready  ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].sti__stOp__strm{1}_cntl       =  sti__stOp__lane{0}_strm{1}_cntl          ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].sti__stOp__strm{1}_data       =  sti__stOp__lane{0}_strm{1}_data          ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].sti__stOp__strm{1}_data_mask  =  sti__stOp__lane{0}_strm{1}_data_mask     ;'.format(lane,strm)
      pLine = pLine + '\n  assign stOp_lane[{0}].sti__stOp__strm{1}_data_valid =  sti__stOp__lane{0}_strm{1}_data_valid    ;'.format(lane,strm)
    pLine = pLine + '\n'


    #pLine = pLine + '\n  assign        = stOp_lane[{0}].;'.format(lane)
    #pLine = pLine + '\n  assign stOp_lane[{0}].=     ;'.format(lane)

  f.write(pLine)
  f.close()


  f = open('../HDL/common/streamingOps_cntl_control_ports.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n      scntl__sdp__lane{0}_stOp_operation, '.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n      scntl__sdp__lane{0}_dma_operation, '.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n      scntl__sdp__lane{0}_strm{1}_read_enable          ,  // enable the stream read mode       '.format(lane,strm)  
      pLine = pLine + '\n      scntl__sdp__lane{0}_strm{1}_write_enable         ,  // enable the stream write mode      '.format(lane,strm)  
      pLine = pLine + '\n      sdp__scntl__lane{0}_strm{1}_read_ready           ,  // stream read mode ready            '.format(lane,strm)  
      pLine = pLine + '\n      sdp__scntl__lane{0}_strm{1}_write_ready          ,  // stream write mode ready           '.format(lane,strm)  
      pLine = pLine + '\n      sdp__scntl__lane{0}_strm{1}_read_complete        ,  // stream read mode complete         '.format(lane,strm)  
      pLine = pLine + '\n      sdp__scntl__lane{0}_strm{1}_write_complete       ,  // stream write mode complete        '.format(lane,strm)  
      pLine = pLine + '\n      scntl__sdp__lane{0}_strm{1}_read_start_address   ,  // streaming op arg{1}               '.format(lane,strm)  
      pLine = pLine + '\n      scntl__sdp__lane{0}_strm{1}_write_start_address  ,  // streaming op result start address '.format(lane,strm)
      pLine = pLine + '\n      scntl__sdp__lane{0}_type{1}                      ,                                       '.format(lane,strm)
      pLine = pLine + '\n      scntl__sdp__lane{0}_num_of_types{1}              ,                                       '.format(lane,strm)
      pLine = pLine + '\n      scntl__sdp__lane{0}_strm{1}_stOp_source          ,                                       '.format(lane,strm)
      pLine = pLine + '\n      scntl__sdp__lane{0}_strm{1}_stOp_destination     ,                                       '.format(lane,strm)
      pLine = pLine + '\n      scntl__sdp__lane{0}_strm{1}_stOp_enable          ,                                       '.format(lane,strm)
      pLine = pLine + '\n      sdp__scntl__lane{0}_strm{1}_stOp_ready           ,                                       '.format(lane,strm)
      pLine = pLine + '\n      sdp__scntl__lane{0}_strm{1}_stOp_complete        ,                                       '.format(lane,strm)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_control_ports_declaration.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_RANGE ]    scntl__sdp__lane{0}_stOp_operation ; '.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_RANGE ]    scntl__sdp__lane{0}_dma_operation ; '.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n   output                                       scntl__sdp__lane{0}_strm{1}_read_enable          ;                                       '.format(lane,strm)  
      pLine = pLine + '\n   output                                       scntl__sdp__lane{0}_strm{1}_write_enable         ;                                       '.format(lane,strm)  
      pLine = pLine + '\n   input                                        sdp__scntl__lane{0}_strm{1}_read_ready           ;                                       '.format(lane,strm)  
      pLine = pLine + '\n   input                                        sdp__scntl__lane{0}_strm{1}_write_ready          ;                                       '.format(lane,strm)  
      pLine = pLine + '\n   input                                        sdp__scntl__lane{0}_strm{1}_read_complete        ;                                       '.format(lane,strm)  
      pLine = pLine + '\n   input                                        sdp__scntl__lane{0}_strm{1}_write_complete       ;                                       '.format(lane,strm)  
      pLine = pLine + '\n   output [`DMA_CONT_STRM_ADDRESS_RANGE]        scntl__sdp__lane{0}_strm{1}_read_start_address   ;  // streaming op arg{1}               '.format(lane,strm)  
      pLine = pLine + '\n   output [`DMA_CONT_STRM_ADDRESS_RANGE]        scntl__sdp__lane{0}_strm{1}_write_start_address  ;  // streaming op result start address '.format(lane,strm)
      pLine = pLine + '\n   output [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]   scntl__sdp__lane{0}_num_of_types{1}              ;                                       '.format(lane,strm)
      pLine = pLine + '\n   output [`DMA_CONT_DATA_TYPES_RANGE ]         scntl__sdp__lane{0}_type{1}                      ;                                       '.format(lane,strm)
      pLine = pLine + '\n   output                                       scntl__sdp__lane{0}_strm{1}_stOp_enable          ;                                       '.format(lane,strm)  
      pLine = pLine + '\n   input                                        sdp__scntl__lane{0}_strm{1}_stOp_ready           ;                                       '.format(lane,strm)  
      pLine = pLine + '\n   input                                        sdp__scntl__lane{0}_strm{1}_stOp_complete        ;                                       '.format(lane,strm)  
      if strm == 0:
         pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane{0}_strm{1}_stOp_source      ;                      '.format(lane,strm)
         pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane{0}_strm{1}_stOp_destination ;                      '.format(lane,strm)
      else:
         pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane{0}_strm{1}_stOp_source      ;                      '.format(lane,strm)
         pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane{0}_strm{1}_stOp_destination ;                      '.format(lane,strm)

  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_control_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  wire                                         scntl__sdp__lane{0}_strm{1}_read_enable         ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                         scntl__sdp__lane{0}_strm{1}_write_enable        ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                         sdp__scntl__lane{0}_strm{1}_read_ready          ;  // from dma'.format(lane,strm)
      pLine = pLine + '\n  wire                                         sdp__scntl__lane{0}_strm{1}_write_ready         ;'.format(lane,strm)
      pLine = pLine + '\n  wire                                         sdp__scntl__lane{0}_strm{1}_read_complete       ;  // from dma'.format(lane,strm)
      pLine = pLine + '\n  wire                                         sdp__scntl__lane{0}_strm{1}_write_complete      ;'.format(lane,strm)
      pLine = pLine + '\n  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane{0}_strm{1}_read_start_address  ;  // register because may be assigned from external DMA request'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane{0}_strm{1}_write_start_address ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane{0}_type{1}                     ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane{0}_num_of_types{1}             ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane{0}_strm{1}_read_start_address             ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane{0}_strm{1}_write_start_address            ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane{0}_type{1}                                ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane{0}_num_of_types{1}                        ;'.format(lane,strm)
      pLine = pLine + '\n  wire   [`PE_MAX_STAGGER_RANGE              ] lane{0}_stagger{1}                             ;'.format(lane,strm)
      if strm == 0:
         pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane{0}_strm{1}_stOp_source      ;                      '.format(lane,strm)
         pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane{0}_strm{1}_stOp_destination ;                      '.format(lane,strm)
      else:
         pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane{0}_strm{1}_stOp_source      ;                      '.format(lane,strm)
         pLine = pLine + '\n   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane{0}_strm{1}_stOp_destination ;                      '.format(lane,strm)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane{0}_strm{1}_read_start_peId   ;'.format(lane,strm)
      pLine = pLine + '\n  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane{0}_strm{1}_write_start_peId  ;'.format(lane,strm)
  pLine = pLine + '\n'
  # Create a vector of requests
  pLine = pLine + '\n  // Local DMA request to NoC signals'
  pLine = pLine + '\n  // Create a vector of requests'
  pLine = pLine + '\n  wire [`PE_NUM_OF_EXEC_LANES_RANGE] NoC_Request_Vector            ;'
  pLine = pLine + '\n  wire [`PE_NUM_OF_EXEC_LANES_RANGE] NoC_Request_Strm_Vector       ;'
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_ID_RANGE     ] localDmaRequestLane           ;'
  pLine = pLine + '\n  reg                                localDmaRequest               ;'
  pLine = pLine + '\n'                                                                  
  pLine = pLine + '\n  // External DMA requests to local streams from NoC signals'      
  pLine = pLine + '\n  wire [`PE_NUM_OF_EXEC_LANES_RANGE] Read_Stream_Available_Vector  ;'
  pLine = pLine + '\n  reg  [`PE_NUM_OF_EXEC_LANES_RANGE] Read_Stream_Request_Vector    ;'
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_ID_RANGE     ] localStrmAvailableLane        ;'
  pLine = pLine + '\n  reg                                localStrmAvailable            ;'
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Data from StOp to NoC signals'
  pLine = pLine + '\n  wire [`PE_NUM_OF_EXEC_LANES_RANGE] toNocDmaPacketAvailableVector ;'
  pLine = pLine + '\n  reg                                toNocDmaPacketAvailable       ;'
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_ID_RANGE     ] toNocSelectedLane             ;'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_control_assignments.vh', 'w')
  pLine = ""

  # Generate a signal indicating all lanes streams are done
  pLine = pLine + '\n  // pe__sys__thisSyncnronized basically means all the streams in the PE are complete'
  pLine = pLine + '\n  // The PE controller will move to a \'final\' state once it receives sys__pe__allSynchronized'
  pLine = pLine + '\n  assign pe__sys__thisSynchronized = ((strm_control[0].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[0].lane_enable) & '.format(lane)
  for lane in range (1, (numOfExecLanes)-1):
    pLine = pLine + '\n                                     ((strm_control[{0}].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[{0}].lane_enable) &  '.format(lane)
  pLine = pLine + '\n                                     ((strm_control[{0}].so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC) | ~strm_control[{0}].lane_enable) ; '.format(numOfExecLanes-1)
  pLine = pLine + '\n'

  offset = 0
  for lane in range (0, numOfExecLanes):
    offset = lane + 16
    pLine = pLine + '\n  assign cntl__sdp__lane{0}_dma_operation = rs0[31:1]                                      ; '.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    offset = lane + 16
    pLine = pLine + '\n  assign scntl__sdp__lane{0}_stOp_operation = rs0[31:1]                                      ; '.format(lane)
    for strm in range (0, 2):
      pLine = pLine + '\n  assign scntl__sdp__lane{0}_strm{1}_stOp_enable    = strm_control[{0}].strm{1}_stOp_enable     ; '.format(lane,strm)
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_stOp_ready      = sdp__scntl__lane{0}_strm{1}_stOp_ready     ; '.format(lane,strm)
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_stOp_complete   = sdp__scntl__lane{0}_strm{1}_stOp_complete  ; '.format(lane,strm)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  // Connect lane operation information to stream fsm '
      pLine = pLine + '\n  assign scntl__sdp__lane{0}_strm{1}_read_enable         = strm_control[{0}].strm{1}_read_enable         ;  // FIXME'.format(lane,strm)
      pLine = pLine + '\n  assign scntl__sdp__lane{0}_strm{1}_write_enable        = strm_control[{0}].strm{1}_write_enable        ;  // FIXME'.format(lane,strm)
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_read_ready           = sdp__scntl__lane{0}_strm{1}_read_ready         ;  // FIXME'.format(lane,strm)
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_write_ready          = sdp__scntl__lane{0}_strm{1}_write_ready        ;  // FIXME'.format(lane,strm)
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_read_complete        = sdp__scntl__lane{0}_strm{1}_read_complete      ;  // FIXME'.format(lane,strm)
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_write_complete       = sdp__scntl__lane{0}_strm{1}_write_complete     ;  // FIXME'.format(lane,strm)
    pLine = pLine + '\n  always @(*)'
    pLine = pLine + '\n    begin'
    pLine = pLine + '\n      scntl__sdp__lane{0}_strm0_read_start_address  = (strm_control[{0}].strm0_assignedToExternalDma) ? strm_control[{0}].strm0_ExternalDma_read_start_address  :'.format(lane,strm)
    pLine = pLine + '\n                                                                                                       lane{0}_r130[`DMA_CONT_STRM_ADDRESS_RANGE]              ;'.format(lane,strm)
    pLine = pLine + '\n      scntl__sdp__lane{0}_strm1_read_start_address  = (strm_control[{0}].strm1_assignedToExternalDma) ? strm_control[{0}].strm1_ExternalDma_read_start_address  :'.format(lane,strm)
    pLine = pLine + '\n                                                                                                       lane{0}_r131[`DMA_CONT_STRM_ADDRESS_RANGE]              ;'.format(lane,strm)
    pLine = pLine + '\n    end'
    pLine = pLine + '\n  assign scntl__sdp__lane{0}_strm0_write_start_address = lane{0}_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;'.format(lane,strm)
    pLine = pLine + '\n  assign scntl__sdp__lane{0}_strm1_write_start_address = lane{0}_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;'.format(lane,strm)
    pLine = pLine + '\n  assign scntl__sdp__lane{0}_type0                     = lane{0}_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;'.format(lane,strm)
    pLine = pLine + '\n  assign scntl__sdp__lane{0}_type1                     = lane{0}_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;'.format(lane,strm)
    pLine = pLine + '\n  assign scntl__sdp__lane{0}_num_of_types0             = lane{0}_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;'.format(lane,strm)
    pLine = pLine + '\n  assign scntl__sdp__lane{0}_num_of_types1             = lane{0}_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_strm0_read_start_address             = lane{0}_r130[`DMA_CONT_STRM_ADDRESS_RANGE]  ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_strm1_read_start_address             = lane{0}_r131[`DMA_CONT_STRM_ADDRESS_RANGE]  ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_strm0_write_start_address            = lane{0}_r134[`DMA_CONT_STRM_ADDRESS_RANGE]  ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_strm1_write_start_address            = lane{0}_r135[`DMA_CONT_STRM_ADDRESS_RANGE]  ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_type0                                = lane{0}_r132[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_type1                                = lane{0}_r133[`DMA_CONT_DATA_TYPES_MSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE : `DMA_CONT_DATA_TYPES_LSB+`DMA_CONT_MAX_NUM_OF_TYPES_SIZE] ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_num_of_types0                        = lane{0}_r132[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_num_of_types1                        = lane{0}_r133[`DMA_CONT_MAX_NUM_OF_TYPES_RANGE]                                                                                    ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_stagger0                             = lane{0}_r132[`PE_MAX_STAGGER_RANGE]                                                                                    ;'.format(lane,strm)
    pLine = pLine + '\n  assign lane{0}_stagger1                             = lane{0}_r133[`PE_MAX_STAGGER_RANGE]                                                                                    ;'.format(lane,strm)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_type         =  lane{0}_type{1}         ; '.format(lane,strm)
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_num_of_types =  lane{0}_num_of_types{1} ; '.format(lane,strm)
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_stagger      =  lane{0}_stagger{1}      ; '.format(lane,strm)

  pLine = pLine + '\n  assign strms_completed = '
  for lane in range (0, numOfExecLanes):
    if lane < ((numOfExecLanes)-1):
      pLine = pLine + '\n               (strm_control[{0}].strm_complete | ~rs1[{0}]) & '.format(lane)
    else:
      pLine = pLine + '\n               (strm_control[{0}].strm_complete | ~rs1[{0}]) ; '.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign  lane{0}_strm0_read_start_peId  = lane{0}_r130[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;'.format(lane)
    pLine = pLine + '\n  assign  lane{0}_strm1_read_start_peId  = lane{0}_r131[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;'.format(lane)
    pLine = pLine + '\n  assign  lane{0}_strm0_write_start_peId = lane{0}_r134[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;'.format(lane)
    pLine = pLine + '\n  assign  lane{0}_strm1_write_start_peId = lane{0}_r135[`STREAMING_OP_CNTL_PE_DECODE_ADDRESS_RANGE]  ;'.format(lane)
  pLine = pLine + '\n'

  # lane control fsm
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign strm_control[{0}].lane_enable  =  rs1[{0}]  ; '.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_read_peId  =  lane{0}_strm{1}_read_start_peId  ; '.format(lane,strm)
      pLine = pLine + '\n  assign strm_control[{0}].strm{1}_write_peId =  lane{0}_strm{1}_write_start_peId ; '.format(lane,strm)
  pLine = pLine + '\n'
  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  assign scntl__sdp__lane{0}_strm{1}_stOp_source      = strm_control[{0}].strm{1}_stOp_src  ;'.format(lane,strm)
      pLine = pLine + '\n  assign scntl__sdp__lane{0}_strm{1}_stOp_destination = strm_control[{0}].strm{1}_stOp_dest ;'.format(lane,strm)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign NoC_Request_Vector[{0}]       = strm_control[{0}].NocLocalDmaRequest     ;'.format(lane,strm)
    pLine = pLine + '\n  assign NoC_Request_Strm_Vector[{0}]  = strm_control[{0}].NocLocalDmaRequestStrm ;'.format(lane,strm)
  pLine = pLine + '\n'

  pLine = pLine + '// Vector of available read streams for external DMA\'s\n'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign Read_Stream_Available_Vector[{0}]       = (strm_control[{0}].lane_enable & strm_control[{0}].ReadyForStreamExternalRequests & (~strm_control[{0}].strm0_read_enable | ~strm_control[{0}].strm1_read_enable)) & // if either stream isnt enabled its available to be assigned to an external DMA'.format(lane,strm)
    pLine = pLine + '\n                                                   (~strm_control[{0}].strm0_assignedToExternalDma & ~strm_control[{0}].strm1_assignedToExternalDma) ; // only allow one stream to be assigned per lane to an external DMA'.format(lane,strm)
  pLine = pLine + '\n'

  #--------------------------------------------------
  # to NoC Control

  # Take the first Stream controller DMA request and pass request to NoC Control FSM
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Take the first Stream controller DMA request and pass request to NoC Control FSM'
  pLine = pLine + '\n  // Latch in a register in case a higher order lane makes a request after a lower order stream'
  pLine = pLine + '\n  // Latcheit and ack are pass thru, so dont latch. request/ack specified in the mux below'
  pLine = pLine + '\n  always @(posedge clk)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      if (~NocControlLocalRequestWait)'
  pLine = pLine + '\n        begin'
  pLine = pLine + '\n          casez(NoC_Request_Vector)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n            {0}\'b'.format(numOfExecLanes)
    for bit in range (0, lane):
      pLine = pLine + '0'
    pLine = pLine + '1'
    for bit in range (lane+1, numOfExecLanes):
      pLine = pLine + '?'
    pLine = pLine + ':'
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              localDmaRequestLane <= \'d{0};'.format(numOfExecLanes-lane-1)
    pLine = pLine + '\n            end'
  pLine = pLine + '\n            default:'
  pLine = pLine + '\n            begin'
  pLine = pLine + '\n              localDmaRequestLane <= \'d0;'
  pLine = pLine + '\n            end'
  pLine = pLine + '\n          endcase'
  pLine = pLine + '\n        end'
  pLine = pLine + '\n      end'
  pLine = pLine + '\n'

  # Take the Acknowledge from the  NoC Control FSM and pass back to requesting stream controller
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Take the Acknowledge from the "to" NoC Control FSM and pass back to requesting stream controller'
  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n      strm_control[{0}].localDmaReqNocAck = 1\'b0;'.format(lane)
  pLine = pLine + '\n        localDmaRequest                     = \'b0;'
  pLine = pLine + '\n      case(localDmaRequestLane)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n        \'d{0}:'.format(lane)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          strm_control[{0}].localDmaReqNocAck   = NocControlLocalAck                   ;'.format(lane)
    pLine = pLine + '\n          localDmaRequest                       = strm_control[{0}].NocLocalDmaRequest ;'.format(lane)
    pLine = pLine + '\n'
    pLine = pLine + '            // Pass local DMA request to NoC \n'
    pLine = pLine + '\n          if (cntl_to_noc_1st_cycle)  '
    pLine = pLine + '\n            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_SOP;'.format(lane)
    pLine = pLine + '\n          else  '
    pLine = pLine + '\n            scntl__noc__cp_cntl_p1                                                        = `STREAMING_OP_CNTL_STRM_CNTL_EOP;'.format(lane)
    pLine = pLine + '\n          scntl__noc__cp_type_p1                                                          = `STREAMING_OP_CNTL_TYPE_DMA_REQUEST;'.format(lane)
    pLine = pLine + '\n          if (cntl_to_noc_1st_cycle)  '
    pLine = pLine + '\n            begin  '
    pLine = pLine + '\n              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]    = (strm_control[{0}].NocLocalDmaRequestStrm) ? lane{0}_r131[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE] : lane{0}_r130[`STREAMING_OP_CNTL_CHIPLET_ADDRESS_RANGE]; '.format(lane)
    pLine = pLine + '\n              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE]    = (strm_control[{0}].NocLocalDmaRequestStrm) ? lane{0}_stagger1                 : lane{0}_stagger0                 ; '.format(lane)
    pLine = pLine + '\n              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_PAD_RANGE    ]    = \'d0                                                                                                             ; '.format(lane)
    pLine = pLine + '\n            end  '
    pLine = pLine + '\n          else  '
    pLine = pLine + '\n            begin  '
    # FIXME: proper numBytes and stagger
    pLine = pLine + '\n              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE] = (strm_control[{0}].NocLocalDmaRequestStrm) ? strm_control[{0}].strm1_word_count : strm_control[{0}].strm0_word_count ; '.format(lane)
    pLine = pLine + '\n              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE] = (strm_control[{0}].NocLocalDmaRequestStrm) ? lane{0}_type1                      : lane{0}_type0                      ; '.format(lane)
    pLine = pLine + '\n              scntl__noc__cp_data_p1[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAD_RANGE         ]    = \'d0                                                                                                              ; '.format(lane)
    pLine = pLine + '\n            end  '
    pLine = pLine + '\n          scntl__noc__cp_laneId_p1                                                        = localDmaRequestLane;'.format(lane)
    pLine = pLine + '\n          scntl__noc__cp_strmId_p1                                                        = strm_control[{0}].NocLocalDmaRequestStrm;'.format(lane)
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'

  #----------------------------------------------------------------------------------------------------
  # from NoC Control

  # Take the first Stream thats available and set to next DMA request that arrives from the NoC
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Take the first Stream thats available and provide to next DMA request that arrives from the NoC'
  pLine = pLine + '\n  // Latch in a register in case a higher order lane becomes available'
  pLine = pLine + '\n  always @(posedge clk)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      if (reset_poweron)'
  pLine = pLine + '\n        begin'
  pLine = pLine + '\n          localStrmAvailableLane <= \'d{0};'.format(numOfExecLanes-lane-1)
  pLine = pLine + '\n          localStrmAvailable     <= \'b0;'.format(numOfExecLanes-lane-1)
  pLine = pLine + '\n        end'
  pLine = pLine + '\n      else if (~NocControlExternalRequestWait)'
  pLine = pLine + '\n        begin'
  pLine = pLine + '\n          casez(Read_Stream_Available_Vector)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n            {0}\'b'.format(numOfExecLanes)
    for bit in range (0, lane):
      pLine = pLine + '0'
    pLine = pLine + '1'
    for bit in range (lane+1, numOfExecLanes):
      pLine = pLine + '?'
    pLine = pLine + ':'
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              localStrmAvailableLane <= \'d{0};'.format(numOfExecLanes-lane-1)
    pLine = pLine + '\n              localStrmAvailable     <= \'b1;'.format(numOfExecLanes-lane-1)
    pLine = pLine + '\n            end'
  pLine = pLine + '\n            default:'
  pLine = pLine + '\n            begin'
  pLine = pLine + '\n              localStrmAvailableLane <= \'d0;'
  pLine = pLine + '\n              localStrmAvailable     <= \'b0;'.format(numOfExecLanes-lane-1)
  pLine = pLine + '\n            end'
  pLine = pLine + '\n          endcase'
  pLine = pLine + '\n        end'
  pLine = pLine + '\n      end'
  pLine = pLine + '\n'

  # Take the Acknowledge from the Stream controller and pass to the external DMA request FSM
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Take the Acknowledge from the Stream controller and pass to the external DMA request FSM'
  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n      strm_control[{0}].externalDmaReqStrmReq = 1\'b0;'.format(lane)
  pLine = pLine + '\n      NocControlExternalAck                   = 1\'b0;'
  pLine = pLine + '\n      case(localStrmAvailableLane)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n        \'d{0}:'.format(lane)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          strm_control[{0}].externalDmaReqStrmReq     = NocControlExternalReq                    ;'.format(lane)
    pLine = pLine + '\n          NocControlExternalAck                       = strm_control[{0}].externalDmaReqStrmAck  ;'.format(lane)
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()


  f = open('../HDL/common/streamingOps_cntl_control_instance_ports.vh', 'w')
  pLine = ""

  for lane in range (0,  numOfExecLanes):
    pLine = pLine + '\n      .scntl__sdp__lane{0}_stOp_operation         ( scntl__sdp__lane{0}_stOp_operation       ), '.format(lane)
  pLine = pLine + '\n'                                                                                          
                                                                                                                
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n      .scntl__sdp__lane{0}_dma_operation          ( scntl__sdp__lane{0}_dma_operation        ), '.format(lane)
  pLine = pLine + '\n'                                                                                          
                                                                                                                
  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n      .scntl__sdp__lane{0}_strm{1}_read_enable           ( scntl__sdp__lane{0}_strm{1}_read_enable         ), '.format(lane,strm)
      pLine = pLine + '\n      .scntl__sdp__lane{0}_strm{1}_write_enable          ( scntl__sdp__lane{0}_strm{1}_write_enable        ), '.format(lane,strm)
      pLine = pLine + '\n      .sdp__scntl__lane{0}_strm{1}_read_ready            ( sdp__scntl__lane{0}_strm{1}_read_ready          ), '.format(lane,strm)
      pLine = pLine + '\n      .sdp__scntl__lane{0}_strm{1}_write_ready           ( sdp__scntl__lane{0}_strm{1}_write_ready         ), '.format(lane,strm)
      pLine = pLine + '\n      .sdp__scntl__lane{0}_strm{1}_read_complete         ( sdp__scntl__lane{0}_strm{1}_read_complete       ), '.format(lane,strm)
      pLine = pLine + '\n      .sdp__scntl__lane{0}_strm{1}_write_complete        ( sdp__scntl__lane{0}_strm{1}_write_complete      ), '.format(lane,strm)
      pLine = pLine + '\n      .scntl__sdp__lane{0}_strm{1}_read_start_address    ( scntl__sdp__lane{0}_strm{1}_read_start_address  ), '.format(lane,strm)
      pLine = pLine + '\n      .scntl__sdp__lane{0}_strm{1}_write_start_address   ( scntl__sdp__lane{0}_strm{1}_write_start_address ), '.format(lane,strm)
      pLine = pLine + '\n      .scntl__sdp__lane{0}_type{1}                       ( scntl__sdp__lane{0}_type{1}                     ), '.format(lane,strm)
      pLine = pLine + '\n      .scntl__sdp__lane{0}_num_of_types{1}               ( scntl__sdp__lane{0}_num_of_types{1}             ), '.format(lane,strm)
      pLine = pLine + '\n      .scntl__sdp__lane{0}_strm{1}_stOp_source           ( scntl__sdp__lane{0}_strm{1}_stOp_source         ), '.format(lane,strm)
      pLine = pLine + '\n      .scntl__sdp__lane{0}_strm{1}_stOp_destination      ( scntl__sdp__lane{0}_strm{1}_stOp_destination    ), '.format(lane,strm)
      pLine = pLine + '\n      .scntl__sdp__lane{0}_strm{1}_stOp_enable           ( scntl__sdp__lane{0}_strm{1}_stOp_enable         ), '.format(lane,strm)
      pLine = pLine + '\n      .sdp__scntl__lane{0}_strm{1}_stOp_ready            ( sdp__scntl__lane{0}_strm{1}_stOp_ready          ), '.format(lane,strm)
      pLine = pLine + '\n      .sdp__scntl__lane{0}_strm{1}_stOp_complete         ( sdp__scntl__lane{0}_strm{1}_stOp_complete       ), '.format(lane,strm)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()



  #-------------------------------------------------------------------------------------------------------------------------------------
  # Result interface to simd regFile

  #--------------------------------------------------
  # scntl to simd

  f = open('../HDL/common/streamingOps_cntl_stOp_to_cntl_regfile_ports.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n    reg__sdp__lane{0}_ready    ,'.format(lane)
    pLine = pLine + '\n    sdp__reg__lane{0}_valid    ,'.format(lane)
    pLine = pLine + '\n    sdp__reg__lane{0}_data     ,'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_stOp_to_cntl_regfile_ports_declaration.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  output                                   reg__sdp__lane{0}_ready    ;'.format(lane)
    pLine = pLine + '\n  input                                    sdp__reg__lane{0}_valid    ;'.format(lane)
    pLine = pLine + '\n  input   [`STREAMING_OP_RESULT_RANGE   ]  sdp__reg__lane{0}_data     ;'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_stOp_to_cntl_regfile_instance_ports.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n    .reg__sdp__lane{0}_ready    ( reg__sdp__lane{0}_ready  ),'.format(lane)
    pLine = pLine + '\n    .sdp__reg__lane{0}_valid    ( sdp__reg__lane{0}_valid  ),'.format(lane)
    pLine = pLine + '\n    .sdp__reg__lane{0}_data     ( sdp__reg__lane{0}_data   ),'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_stOp_to_cntl_regfile_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  wire                                   reg__sdp__lane{0}_ready    ;'.format(lane)
    pLine = pLine + '\n  wire                                   sdp__reg__lane{0}_valid    ;'.format(lane)
    pLine = pLine + '\n  wire  [`STREAMING_OP_RESULT_RANGE   ]  sdp__reg__lane{0}_data     ;'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  #--------------------------------------------------
  # stOp to scntl

  f = open('../HDL/common/streamingOps_cntl_to_simd_regfile_ports.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n    reg__scntl__lane{0}_ready    ,'.format(lane)
    pLine = pLine + '\n    scntl__reg__lane{0}_valid    ,'.format(lane)
    pLine = pLine + '\n    scntl__reg__lane{0}_data     ,'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_to_simd_regfile_ports_declaration.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  input                                    reg__scntl__lane{0}_ready    ;'.format(lane)
    pLine = pLine + '\n  output                                   scntl__reg__lane{0}_valid    ;'.format(lane)
    pLine = pLine + '\n  output  [`STREAMING_OP_RESULT_RANGE   ]  scntl__reg__lane{0}_data     ;'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_to_simd_regfile_instance_ports.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n    .reg__scntl__lane{0}_ready   ( reg__scntl__lane{0}_ready  ) ,'.format(lane)
    pLine = pLine + '\n    .scntl__reg__lane{0}_valid   ( scntl__reg__lane{0}_valid  ) ,'.format(lane)
    pLine = pLine + '\n    .scntl__reg__lane{0}_data    ( scntl__reg__lane{0}_data   ) ,'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_to_simd_regfile_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  wire                                    reg__scntl__lane{0}_ready    ;'.format(lane)
    pLine = pLine + '\n  wire                                    scntl__reg__lane{0}_valid    ;'.format(lane)
    pLine = pLine + '\n  wire   [`STREAMING_OP_RESULT_RANGE   ]  scntl__reg__lane{0}_data     ;'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_to_simd_regfile_assignments.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n    assign reg__sdp__lane{0}_ready    =  reg__scntl__lane{0}_ready  ;'.format(lane)
    pLine = pLine + '\n    assign scntl__reg__lane{0}_valid  =  sdp__reg__lane{0}_valid    ;'.format(lane)
    pLine = pLine + '\n    assign scntl__reg__lane{0}_data   =  sdp__reg__lane{0}_data     ;'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()



  #-------------------------------------------------------------------------------------------------------------------------------------
  # NoC

  f = open('../HDL/common/streamingOps_cntl_stOp_noc_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n      // Aggregate Control-path (cp) to NoC '.format(lane)
  pLine = pLine + '\n      noc__scntl__cp_ready      , '.format(lane)
  pLine = pLine + '\n      scntl__noc__cp_cntl       , '.format(lane)
  pLine = pLine + '\n      scntl__noc__cp_type       , '.format(lane)
  pLine = pLine + '\n      scntl__noc__cp_data       , '.format(lane)
  pLine = pLine + '\n      scntl__noc__cp_laneId     , '.format(lane)
  pLine = pLine + '\n      scntl__noc__cp_strmId     , '.format(lane)
  pLine = pLine + '\n      scntl__noc__cp_valid      , '.format(lane)
  pLine = pLine + '\n      // Aggregate Datapath (cp) from NoC '.format(lane)
  pLine = pLine + '\n      scntl__noc__cp_ready      , '.format(lane)
  pLine = pLine + '\n      noc__scntl__cp_cntl       , '.format(lane)
  pLine = pLine + '\n      noc__scntl__cp_type       , '.format(lane)
  pLine = pLine + '\n      noc__scntl__cp_data       , '.format(lane)
  pLine = pLine + '\n      noc__scntl__cp_peId       , '.format(lane)
  pLine = pLine + '\n      noc__scntl__cp_laneId     , '.format(lane)
  pLine = pLine + '\n      noc__scntl__cp_strmId     , '.format(lane)
  pLine = pLine + '\n      noc__scntl__cp_valid      , '.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n      // Aggregate Datapath (dp) to NoC '.format(lane)
  pLine = pLine + '\n      noc__scntl__dp_ready      , '.format(lane)
  pLine = pLine + '\n      scntl__noc__dp_cntl       , '.format(lane)
  pLine = pLine + '\n      scntl__noc__dp_type       , '.format(lane)
  pLine = pLine + '\n      scntl__noc__dp_peId       , '.format(lane)
  pLine = pLine + '\n      scntl__noc__dp_laneId     , '.format(lane)
  pLine = pLine + '\n      scntl__noc__dp_strmId     , '.format(lane)
  pLine = pLine + '\n      scntl__noc__dp_data       , '.format(lane)
  pLine = pLine + '\n      scntl__noc__dp_valid      , '.format(lane)
  pLine = pLine + '\n      // Aggregate Datapath (dp) from NoC '.format(lane)
  pLine = pLine + '\n      scntl__noc__dp_ready      , '.format(lane)
  pLine = pLine + '\n      noc__scntl__dp_cntl       , '.format(lane)
  pLine = pLine + '\n      noc__scntl__dp_type       , '.format(lane)
  pLine = pLine + '\n      noc__scntl__dp_laneId     , '.format(lane)
  pLine = pLine + '\n      noc__scntl__dp_strmId     , '.format(lane)
  pLine = pLine + '\n      noc__scntl__dp_data       , '.format(lane)
  pLine = pLine + '\n      noc__scntl__dp_valid      , '.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n      // Only one lane from each DMA can feed NoC'.format(lane)
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n      // lane{0} from NoC '.format(lane)
    pLine = pLine + '\n      sdp__cntl__lane{0}_strm_ready      , '.format(lane)
    pLine = pLine + '\n      cntl__sdp__lane{0}_strm_cntl       , '.format(lane)
    pLine = pLine + '\n      cntl__sdp__lane{0}_strm_id         , '.format(lane)
    pLine = pLine + '\n      cntl__sdp__lane{0}_strm_data       , '.format(lane)
    pLine = pLine + '\n      cntl__sdp__lane{0}_strm_data_valid , '.format(lane)
    pLine = pLine + '\n      // lane{0} to NoC '.format(lane)
    pLine = pLine + '\n      cntl__sdp__lane{0}_strm_ready      , '.format(lane)
    pLine = pLine + '\n      sdp__cntl__lane{0}_strm_cntl       , '.format(lane)
    pLine = pLine + '\n      sdp__cntl__lane{0}_strm_id         , '.format(lane)
    pLine = pLine + '\n      sdp__cntl__lane{0}_strm_data       , '.format(lane)
    pLine = pLine + '\n      sdp__cntl__lane{0}_strm_data_valid , '.format(lane)
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_stOp_noc_ports_declaration.vh', 'w')
  pLine = ""

  pLine = pLine + '\n   // Aggregate Control-path (cp) to NoC '.format(lane)
  pLine = pLine + '\n   input                                             noc__scntl__cp_ready      ; '.format(lane)
  pLine = pLine + '\n   output [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] scntl__noc__cp_cntl       ; '.format(lane)
  pLine = pLine + '\n   output [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__cp_type       ; '.format(lane)
  pLine = pLine + '\n   output [`PE_NOC_INTERNAL_DATA_RANGE             ] scntl__noc__cp_data       ; '.format(lane)
  pLine = pLine + '\n   output [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__cp_laneId     ; '.format(lane)
  pLine = pLine + '\n   output                                            scntl__noc__cp_strmId     ; '.format(lane)
  pLine = pLine + '\n   output                                            scntl__noc__cp_valid      ; '.format(lane)
  pLine = pLine + '\n   // Aggregate Data-path (cp) from NoC '.format(lane)
  pLine = pLine + '\n   output                                            scntl__noc__cp_ready      ; '.format(lane)
  pLine = pLine + '\n   input  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__cp_cntl       ; '.format(lane)
  pLine = pLine + '\n   input  [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__cp_type       ; '.format(lane)
  pLine = pLine + '\n   input  [`PE_NOC_INTERNAL_DATA_RANGE             ] noc__scntl__cp_data       ; '.format(lane)
  pLine = pLine + '\n   input  [`PE_PE_ID_RANGE                         ] noc__scntl__cp_peId       ; '.format(lane)
  pLine = pLine + '\n   input  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__cp_laneId     ; '.format(lane)
  pLine = pLine + '\n   input                                             noc__scntl__cp_strmId     ; '.format(lane)
  pLine = pLine + '\n   input                                             noc__scntl__cp_valid      ; '.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n   // Aggregate Data-path (dp) to NoC '.format(lane)
  pLine = pLine + '\n   input                                             noc__scntl__dp_ready      ; '.format(lane)
  pLine = pLine + '\n   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE       ] scntl__noc__dp_cntl       ; '.format(lane)
  pLine = pLine + '\n   output [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__dp_type       ; '.format(lane)
  pLine = pLine + '\n   output [`PE_PE_ID_RANGE                         ] scntl__noc__dp_peId       ; '.format(lane)
  pLine = pLine + '\n   output [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__dp_laneId     ; '.format(lane)
  pLine = pLine + '\n   output                                            scntl__noc__dp_strmId     ; '.format(lane)
  pLine = pLine + '\n   output[`STREAMING_OP_CNTL_DATA_RANGE            ] scntl__noc__dp_data       ; '.format(lane)
  pLine = pLine + '\n   output                                            scntl__noc__dp_valid      ; '.format(lane)
  pLine = pLine + '\n   // Aggregate Data-path (dp) from NoC '.format(lane)
  pLine = pLine + '\n   output                                            scntl__noc__dp_ready      ; '.format(lane)
  pLine = pLine + '\n   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE       ] noc__scntl__dp_cntl       ; '.format(lane)
  pLine = pLine + '\n   input  [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__dp_type       ; '.format(lane)
  pLine = pLine + '\n   input  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__dp_laneId     ; '.format(lane)
  pLine = pLine + '\n   input                                             noc__scntl__dp_strmId     ; '.format(lane)
  pLine = pLine + '\n   input [`STREAMING_OP_CNTL_DATA_RANGE            ] noc__scntl__dp_data       ; '.format(lane)
  pLine = pLine + '\n   input                                             noc__scntl__dp_valid      ; '.format(lane)
  pLine = pLine + '\n'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n   // lane{0} from NoC '.format(lane)
    pLine = pLine + '\n   input                                            sdp__cntl__lane{0}_strm_ready      ; '.format(lane)
    pLine = pLine + '\n   output[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane{0}_strm_cntl       ; '.format(lane)
    pLine = pLine + '\n   output                                           cntl__sdp__lane{0}_strm_id         ; '.format(lane)
    pLine = pLine + '\n   output[`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane{0}_strm_data       ; '.format(lane)
    pLine = pLine + '\n   output                                           cntl__sdp__lane{0}_strm_data_valid ; '.format(lane)
    pLine = pLine + '\n   // lane{0} to NoC '.format(lane)
    pLine = pLine + '\n   output                                           cntl__sdp__lane{0}_strm_ready      ; '.format(lane)
    pLine = pLine + '\n   input [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane{0}_strm_cntl       ; '.format(lane)
    pLine = pLine + '\n   input                                            sdp__cntl__lane{0}_strm_id         ; '.format(lane)
    pLine = pLine + '\n   input [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane{0}_strm_data       ; '.format(lane)
    pLine = pLine + '\n   input                                            sdp__cntl__lane{0}_strm_data_valid ; '.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_stOp_wires.vh', 'w')
  pLine = ""

  pLine = pLine + '\n   // Aggregate Control-Path (cp) to NoC '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__cp_ready      ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] scntl__noc__cp_cntl       ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__cp_type       ; '.format(lane)
  pLine = pLine + '\n   reg  [`PE_NOC_INTERNAL_DATA_RANGE             ] scntl__noc__cp_data       ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__cp_laneId     ; '.format(lane)
  pLine = pLine + '\n   reg                                             scntl__noc__cp_strmId     ; '.format(lane)
  pLine = pLine + '\n   reg                                             scntl__noc__cp_valid      ; '.format(lane)
  # We have a big mux at the output so add a register stage
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] scntl__noc__cp_cntl_p1    ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__cp_type_p1    ; '.format(lane)
  pLine = pLine + '\n   reg  [`PE_NOC_INTERNAL_DATA_RANGE             ] scntl__noc__cp_data_p1    ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__cp_laneId_p1  ; '.format(lane)
  pLine = pLine + '\n   reg                                             scntl__noc__cp_strmId_p1  ; '.format(lane)
  pLine = pLine + '\n   // Aggregate Control-Path (cp) from NoC '.format(lane)
  pLine = pLine + '\n   reg                                             scntl__noc__cp_ready      ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__cp_cntl       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__cp_type       ; '.format(lane)
  pLine = pLine + '\n   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] noc__scntl__cp_data       ; '.format(lane)
  pLine = pLine + '\n   wire [`PE_PE_ID_RANGE                         ] noc__scntl__cp_peId       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__cp_laneId     ; '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__cp_strmId     ; '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__cp_valid      ; '.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n   // Aggregate Data-Path (dp) to NoC '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__dp_ready      ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] scntl__noc__dp_cntl       ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__dp_type       ; '.format(lane)
  pLine = pLine + '\n   reg  [`PE_PE_ID_RANGE                         ] scntl__noc__dp_peId       ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__dp_laneId     ; '.format(lane)
  pLine = pLine + '\n   reg                                             scntl__noc__dp_strmId     ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_DATA_RANGE           ] scntl__noc__dp_data       ; '.format(lane)
  pLine = pLine + '\n   reg                                             scntl__noc__dp_valid      ; '.format(lane)
  # We have a big mux at the output so add a register stage
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] scntl__noc__dp_cntl_p1    ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__dp_type_p1    ; '.format(lane)
  pLine = pLine + '\n   reg  [`PE_PE_ID_RANGE                         ] scntl__noc__dp_peId_p1    ; '.format(lane)
  pLine = pLine + '\n   reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__dp_laneId_p1  ; '.format(lane)
  pLine = pLine + '\n   reg                                             scntl__noc__dp_strmId_p1  ; '.format(lane)
  pLine = pLine + '\n   reg  [`PE_NOC_INTERNAL_DATA_RANGE             ] scntl__noc__dp_data_p1    ; '.format(lane)
  pLine = pLine + '\n   // Aggregate Data-Path (dp) from NoC '.format(lane)
  pLine = pLine + '\n   reg                                             scntl__noc__dp_ready      ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__dp_cntl       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__dp_type       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__dp_laneId     ; '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__dp_strmId     ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] noc__scntl__dp_data       ; '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__dp_valid      ; '.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  f = open('../HDL/common/streamingOps_cntl_noc_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n   // lane{0} from NoC '.format(lane)
    pLine = pLine + '\n   wire                                            sdp__cntl__lane{0}_strm_ready      ; '.format(lane)
    pLine = pLine + '\n   reg[`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]        cntl__sdp__lane{0}_strm_cntl       ; '.format(lane)
    pLine = pLine + '\n   reg                                             cntl__sdp__lane{0}_strm_id         ; '.format(lane)
    pLine = pLine + '\n   reg[`STREAMING_OP_CNTL_DATA_RANGE      ]        cntl__sdp__lane{0}_strm_data       ; '.format(lane)
    pLine = pLine + '\n   reg                                             cntl__sdp__lane{0}_strm_data_valid ; '.format(lane)
    pLine = pLine + '\n   // lane{0} to NoC '.format(lane)
    pLine = pLine + '\n   wire                                            cntl__sdp__lane{0}_strm_ready      ; '.format(lane)
    pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane{0}_strm_cntl       ; '.format(lane)
    pLine = pLine + '\n   wire                                            sdp__cntl__lane{0}_strm_id         ; '.format(lane)
    pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane{0}_strm_data       ; '.format(lane)
    pLine = pLine + '\n   wire                                            sdp__cntl__lane{0}_strm_data_valid ; '.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_noc_instance_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n       // Aggregate Control-Path (cp) to NoC '.format(lane)
  pLine = pLine + '\n      .noc__scntl__cp_ready          ( noc__scntl__cp_ready         ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__cp_cntl           ( scntl__noc__cp_cntl          ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__cp_type           ( scntl__noc__cp_type          ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__cp_data           ( scntl__noc__cp_data          ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__cp_laneId         ( scntl__noc__cp_laneId        ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__cp_strmId         ( scntl__noc__cp_strmId        ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__cp_valid          ( scntl__noc__cp_valid         ), '.format(lane)
  pLine = pLine + '\n       // Aggregate Data-Path (cp) from NoC '.format(lane)
  pLine = pLine + '\n      .scntl__noc__cp_ready          ( scntl__noc__cp_ready         ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__cp_cntl           ( noc__scntl__cp_cntl          ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__cp_type           ( noc__scntl__cp_type          ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__cp_data           ( noc__scntl__cp_data          ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__cp_peId           ( noc__scntl__cp_peId          ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__cp_laneId         ( noc__scntl__cp_laneId        ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__cp_strmId         ( noc__scntl__cp_strmId        ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__cp_valid          ( noc__scntl__cp_valid         ), '.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n       // Aggregate Data-Path (dp) to NoC '.format(lane)
  pLine = pLine + '\n      .noc__scntl__dp_ready          ( noc__scntl__dp_ready         ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__dp_cntl           ( scntl__noc__dp_cntl          ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__dp_type           ( scntl__noc__dp_type          ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__dp_peId           ( scntl__noc__dp_peId          ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__dp_laneId         ( scntl__noc__dp_laneId        ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__dp_strmId         ( scntl__noc__dp_strmId        ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__dp_data           ( scntl__noc__dp_data          ), '.format(lane)
  pLine = pLine + '\n      .scntl__noc__dp_valid          ( scntl__noc__dp_valid         ), '.format(lane)
  pLine = pLine + '\n       // Aggregate Data-Path (dp) from NoC '.format(lane)
  pLine = pLine + '\n      .scntl__noc__dp_ready          ( scntl__noc__dp_ready         ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__dp_cntl           ( noc__scntl__dp_cntl          ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__dp_type           ( noc__scntl__dp_type          ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__dp_laneId         ( noc__scntl__dp_laneId        ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__dp_strmId         ( noc__scntl__dp_strmId        ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__dp_data           ( noc__scntl__dp_data          ), '.format(lane)
  pLine = pLine + '\n      .noc__scntl__dp_valid          ( noc__scntl__dp_valid         ), '.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  f = open('../HDL/common/streamingOps_cntl_stOp_instance_ports.vh', 'w')
  pLine = ""

  for lane in range (0,  numOfExecLanes):
    pLine = pLine + '\n       // lane{0} NoC to stOp '.format(lane)
    pLine = pLine + '\n      .sdp__cntl__lane{0}_strm_ready          ( sdp__cntl__lane{0}_strm_ready         ), '.format(lane)
    pLine = pLine + '\n      .cntl__sdp__lane{0}_strm_cntl           ( cntl__sdp__lane{0}_strm_cntl          ), '.format(lane)
    pLine = pLine + '\n      .cntl__sdp__lane{0}_strm_id             ( cntl__sdp__lane{0}_strm_id            ), '.format(lane)
    pLine = pLine + '\n      .cntl__sdp__lane{0}_strm_data           ( cntl__sdp__lane{0}_strm_data          ), '.format(lane)
    pLine = pLine + '\n      .cntl__sdp__lane{0}_strm_data_valid     ( cntl__sdp__lane{0}_strm_data_valid    ), '.format(lane)
    pLine = pLine + '\n       // lane{0} stOp to NoC '.format(lane)
    pLine = pLine + '\n      .cntl__sdp__lane{0}_strm_ready          ( cntl__sdp__lane{0}_strm_ready         ), '.format(lane)
    pLine = pLine + '\n      .sdp__cntl__lane{0}_strm_cntl           ( sdp__cntl__lane{0}_strm_cntl          ), '.format(lane)
    pLine = pLine + '\n      .sdp__cntl__lane{0}_strm_id             ( sdp__cntl__lane{0}_strm_id            ), '.format(lane)
    pLine = pLine + '\n      .sdp__cntl__lane{0}_strm_data           ( sdp__cntl__lane{0}_strm_data          ), '.format(lane)
    pLine = pLine + '\n      .sdp__cntl__lane{0}_strm_data_valid     ( sdp__cntl__lane{0}_strm_data_valid    ), '.format(lane)
  pLine = pLine + '\n'                                                                                          

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_cntl_noc_connection_wires.vh', 'w')
  pLine = ""

  pLine = pLine + '\n   // Aggregate Control-Path (cp) to NoC '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__cp_ready      ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] scntl__noc__cp_cntl       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__cp_type       ; '.format(lane)
  pLine = pLine + '\n   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] scntl__noc__cp_data       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__cp_laneId     ; '.format(lane)
  pLine = pLine + '\n   wire                                            scntl__noc__cp_strmId     ; '.format(lane)
  pLine = pLine + '\n   wire                                            scntl__noc__cp_valid      ; '.format(lane)
  pLine = pLine + '\n   // Aggregate Data-Path (cp) from NoC '.format(lane)
  pLine = pLine + '\n   wire                                            scntl__noc__cp_ready      ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__cp_cntl       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__cp_type       ; '.format(lane)
  pLine = pLine + '\n   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] noc__scntl__cp_data       ; '.format(lane)
  pLine = pLine + '\n   wire [`PE_PE_ID_RANGE                         ] noc__scntl__cp_peId       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__cp_laneId     ; '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__cp_strmId     ; '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__cp_valid      ; '.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n   // Aggregate Data-Path (dp) to NoC '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__dp_ready      ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] scntl__noc__dp_cntl       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__dp_type       ; '.format(lane)
  pLine = pLine + '\n   wire [`PE_PE_ID_RANGE                         ] scntl__noc__dp_peId       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__dp_laneId     ; '.format(lane)
  pLine = pLine + '\n   wire                                            scntl__noc__dp_strmId     ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] scntl__noc__dp_data       ; '.format(lane)
  pLine = pLine + '\n   wire                                            scntl__noc__dp_valid      ; '.format(lane)
  pLine = pLine + '\n   // Aggregate Data-Path (dp) from NoC '.format(lane)
  pLine = pLine + '\n   wire                                            scntl__noc__dp_ready      ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__dp_cntl       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__dp_type       ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__dp_laneId     ; '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__dp_strmId     ; '.format(lane)
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] noc__scntl__dp_data       ; '.format(lane)
  pLine = pLine + '\n   wire                                            noc__scntl__dp_valid      ; '.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()



  f = open('../HDL/common/pe_cntl_to_stOp_connection_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n   // lane{0} from NoC '.format(lane)
    pLine = pLine + '\n   wire                                            sdp__cntl__lane{0}_strm_ready      ; '.format(lane)
    pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      cntl__sdp__lane{0}_strm_cntl       ; '.format(lane)
    pLine = pLine + '\n   wire                                            cntl__sdp__lane{0}_strm_id         ; '.format(lane)
    pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_DATA_RANGE      ]      cntl__sdp__lane{0}_strm_data       ; '.format(lane)
    pLine = pLine + '\n   wire                                            cntl__sdp__lane{0}_strm_data_valid ; '.format(lane)
    pLine = pLine + '\n   // lane{0} to NoC '.format(lane)
    pLine = pLine + '\n   wire                                            cntl__sdp__lane{0}_strm_ready      ; '.format(lane)
    pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]      sdp__cntl__lane{0}_strm_cntl       ; '.format(lane)
    pLine = pLine + '\n   wire                                            sdp__cntl__lane{0}_strm_id         ; '.format(lane)
    pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_DATA_RANGE      ]      sdp__cntl__lane{0}_strm_data       ; '.format(lane)
    pLine = pLine + '\n   wire                                            sdp__cntl__lane{0}_strm_data_valid ; '.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()



  f = open('../HDL/common/streamingOps_cntl_stOp_noc_connections.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // lane{0} from NoC '.format(lane)
    pLine = pLine + '\n  assign sdp__cntl__lane{0}_strm_ready             = stOp_lane[{0}].stOp__noc__strm_ready  ;'.format(lane,strm)
    pLine = pLine + '\n  assign stOp_lane[{0}].noc__stOp__strm_cntl       = cntl__sdp__lane{0}_strm_cntl          ;'.format(lane,strm)
    pLine = pLine + '\n  assign stOp_lane[{0}].noc__stOp__strm_id         = cntl__sdp__lane{0}_strm_id            ;'.format(lane,strm)
    pLine = pLine + '\n  assign stOp_lane[{0}].noc__stOp__strm_data       = cntl__sdp__lane{0}_strm_data          ;'.format(lane,strm)
    pLine = pLine + '\n  assign stOp_lane[{0}].noc__stOp__strm_data_valid = cntl__sdp__lane{0}_strm_data_valid    ;'.format(lane,strm)
    pLine = pLine + '\n  // lane{0} to NoC '.format(lane,strm)
    pLine = pLine + '\n  assign stOp_lane[{0}].noc__stOp__strm_ready       = cntl__sdp__lane{0}_strm_ready               ;'.format(lane,strm)
    pLine = pLine + '\n  assign sdp__cntl__lane{0}_strm_cntl               = stOp_lane[{0}].stOp__noc__strm_cntl         ;'.format(lane,strm)
    pLine = pLine + '\n  assign sdp__cntl__lane{0}_strm_id                 = stOp_lane[{0}].stOp__noc__strm_id           ;'.format(lane,strm)
    pLine = pLine + '\n  assign sdp__cntl__lane{0}_strm_data               = stOp_lane[{0}].stOp__noc__strm_data         ;'.format(lane,strm)
    pLine = pLine + '\n  assign sdp__cntl__lane{0}_strm_data_valid         = stOp_lane[{0}].stOp__noc__strm_data_valid   ;'.format(lane,strm)

  f.write(pLine)
  f.close()


  f = open('../HDL/common/streamingOps_cntl_stOp_noc_from_stOp_fifo_wires.vh', 'w')
  pLine = ""
  numOfStrms = 2
  fifo = "from_stOp_fifo"
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // lane{0} to NoC '.format(lane)
    id = lane * numOfStrms + strm
    pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE                  ] lane{1}_fromStOp_strm_cntl                   ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  reg                                                         lane{1}_fromStOp_strm_id                     ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_DATA_RANGE                       ] lane{1}_fromStOp_strm_data                   ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  reg                                                         lane{1}_fromStOp_strm_data_valid             ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire                                                        lane{1}_fromStOp_strm_ready                  ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  reg                                                         lane{1}_fromStOp_strm_fifo_read              ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire                                                        lane{1}_fromStOp_strm_fifo_empty             ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_RANGE ] lane{1}_fromStOp_strm_fifo_eop_count         ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE                  ] lane{1}_fromStOp_strm_fifo_read_cntl         ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire                                                        lane{1}_fromStOp_strm_fifo_read_data_valid   ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_RANGE]            lane{1}_fromStOp_strm_fifo_depth             ;'.format(fifo,lane,strm,id)
    pLine = pLine + '\n  wire                                                        lane{1}_fromStOp_strm_fifo_read_id           ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire [`STREAMING_OP_CNTL_DATA_RANGE                       ] lane{1}_fromStOp_strm_fifo_read_data         ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire                                                        lane{1}_fromStOp_strm_fifo_dma_pkt_available ;'.format(fifo,lane,strm,id)
    pLine = pLine + '\n  wire                                                        lane{1}_fromStOp_strm_fifo_data_available    ;'.format(fifo,lane,strm,id)

  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_stOp_noc_from_stOp_fifo_assignments.vh', 'w')
  pLine = ""
  fifo = "from_stOp_fifo"
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // lane{0}, stream to NoC '.format(lane)
    pLine = pLine + '\n  assign     {0}[{1}].clear                               =  clear_op                             ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_fifo_empty             =  {0}[{1}].fifo_empty                  ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_fifo_depth             =  {0}[{1}].fifo_depth                  ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_ready                  = ~{0}[{1}].fifo_almost_full            ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_fifo_eop_count         =  {0}[{1}].fifo_eop_count              ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     {0}[{1}].fifo_read                           =  lane{1}_fromStOp_strm_fifo_read      ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_fifo_read_cntl         =  {0}[{1}].fifo_read_cntl              ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_fifo_read_data_valid   =  {0}[{1}].fifo_read_data_valid        ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_fifo_read_id           =  {0}[{1}].fifo_read_strmId            ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_fifo_read_data         =  {0}[{1}].fifo_read_data              ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     {0}[{1}].cntl                                =  lane{1}_fromStOp_strm_cntl           ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     {0}[{1}].strmId                              =  lane{1}_fromStOp_strm_id             ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     {0}[{1}].data                                =  lane{1}_fromStOp_strm_data           ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     {0}[{1}].fifo_write                          =  lane{1}_fromStOp_strm_data_valid     ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_fifo_data_available    = ~lane{1}_fromStOp_strm_fifo_empty     ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     lane{1}_fromStOp_strm_fifo_dma_pkt_available = (lane{1}_fromStOp_strm_fifo_eop_count > 0) | lane{1}_fromStOp_strm_fifo_depth >= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT     ; // start sending packet if an EOP is observed or there is enuff data for a full-sized DMA packet'.format(fifo,lane)

  # data from stOp to NoC
  pLine = pLine + '// Vector of available stOp data to be sent to NoC\n'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign toNocDmaPacketAvailableVector[{0}] = lane{0}_fromStOp_strm_fifo_dma_pkt_available ; // vector of which lanes have a DMA apcket available to be sent to the NoC'.format(lane,strm)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // lane{0} stream to NoC '.format(lane)
    pLine = pLine + '\n  assign     cntl__sdp__lane{1}_strm_ready  = lane{1}_fromStOp_strm_ready                ; '.format(fifo,lane) 
    pLine = pLine + '\n  always @(posedge clk) '
    pLine = pLine + '\n    begin '
    pLine = pLine + '\n      lane{1}_fromStOp_strm_cntl        <= sdp__cntl__lane{1}_strm_cntl      ;'.format(fifo,lane)
    pLine = pLine + '\n      lane{1}_fromStOp_strm_id          <= sdp__cntl__lane{1}_strm_id        ;'.format(fifo,lane)
    pLine = pLine + '\n      lane{1}_fromStOp_strm_data        <= sdp__cntl__lane{1}_strm_data      ;'.format(fifo,lane)
    pLine = pLine + '\n      lane{1}_fromStOp_strm_data_valid  <= sdp__cntl__lane{1}_strm_data_valid;'.format(fifo,lane)
    pLine = pLine + '\n    end '

  # from StOp to NoC Datapath control
  # Take the first lane that has a pkt available
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Take data from the first lane that has a packet available'
  pLine = pLine + '\n  // FIXME: need to make this fair'
  pLine = pLine + '\n  always @(posedge clk)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      if (~FromStOpControlRequestWait)'
  pLine = pLine + '\n        begin'
  pLine = pLine + '\n          casez(toNocDmaPacketAvailableVector)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n            {0}\'b'.format(numOfExecLanes)
    for bit in range (0, lane):
      pLine = pLine + '0'
    pLine = pLine + '1'
    for bit in range (lane+1, numOfExecLanes):
      pLine = pLine + '?'
    pLine = pLine + ':'
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              toNocSelectedLane  <= \'d{0};'.format(numOfExecLanes-lane-1)
    pLine = pLine + '\n            end'
  pLine = pLine + '\n            default:'
  pLine = pLine + '\n            begin'
  pLine = pLine + '\n              toNocSelectedLane  <= \'d{0};'.format(numOfExecLanes-lane-1)
  pLine = pLine + '\n            end'
  pLine = pLine + '\n          endcase'
  pLine = pLine + '\n        end'
  pLine = pLine + '\n      end'
  pLine = pLine + '\n'

  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      toNocDmaPacketAvailable   = \'b0;'
  pLine = pLine + '\n      case(toNocSelectedLane)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n        \'d{0}:'.format(lane)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          toNocDmaPacketAvailable = lane{0}_fromStOp_strm_fifo_dma_pkt_available;'.format(lane)
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'

  pLine = pLine + '\n  always @(posedge clk)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      case(toNocSelectedLane)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n        \'d{0}:'.format(lane)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          scntl__noc__dp_cntl   <= scntl__noc__dp_cntl_p1    ; '.format(lane)
    pLine = pLine + '\n          scntl__noc__dp_type   <= scntl__noc__dp_type_p1    ; '.format(lane)
    pLine = pLine + '\n          scntl__noc__dp_peId   <= scntl__noc__dp_peId_p1    ; '.format(lane)
    pLine = pLine + '\n          scntl__noc__dp_laneId <= scntl__noc__dp_laneId_p1  ; '.format(lane)
    pLine = pLine + '\n          scntl__noc__dp_strmId <= scntl__noc__dp_strmId_p1  ; '.format(lane)
    pLine = pLine + '\n          scntl__noc__dp_data   <= scntl__noc__dp_data_p1    ; '.format(lane)
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'

  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n      lane{0}_fromStOp_strm_fifo_read = 1\'b0      ; '.format(lane)
    pLine = pLine + '\n      toNoc_dp_fifo_cntl              = 1\'b0      ; '.format(lane)
    pLine = pLine + '\n      toNoc_dp_fifo_data_valid        = 1\'b0      ; '.format(lane)
    pLine = pLine + '\n      toNoc_dp_fifo_depth              = \'d0      ; '.format(lane)
    pLine = pLine + '\n      toNoc_dp_fifo_eop_count          = \'d0      ; '.format(lane)
    pLine = pLine + '\n      toNoc_dp_fifo_dma_pkt_available = 1\'b0      ; '.format(lane)
  pLine = pLine + '\n      case(toNocSelectedLane)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n        \'d{0}:'.format(lane)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          toNoc_dp_fifo_cntl              = lane{0}_fromStOp_strm_fifo_read_cntl         ; '.format(lane)
    pLine = pLine + '\n          toNoc_dp_fifo_data_valid        = lane{0}_fromStOp_strm_fifo_read_data_valid   ; '.format(lane)
    pLine = pLine + '\n          toNoc_dp_fifo_depth             = lane{0}_fromStOp_strm_fifo_depth             ; '.format(lane)
    pLine = pLine + '\n          toNoc_dp_fifo_eop_count         = lane{0}_fromStOp_strm_fifo_eop_count         ; '.format(lane)
    pLine = pLine + '\n          toNoc_dp_fifo_dma_pkt_available = lane{0}_fromStOp_strm_fifo_dma_pkt_available ; '.format(lane)
    pLine = pLine + '\n          lane{0}_fromStOp_strm_fifo_read = toNoc_dp_fifo_read                           ; '.format(lane)
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'
  pLine = pLine + '\n  always @(*)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      case(toNocSelectedLane)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n        \'d{0}:'.format(lane)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          scntl__noc__dp_cntl_p1   = (toNoc_dp_first_transaction_in_pkt && toNoc_dp_last_transaction_in_pkt ) ? (lane{0}_fromStOp_strm_fifo_read_cntl | `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP) : // delineate using SOP/EOP for NoC'.format(lane)
    pLine = pLine + '\n                                    (toNoc_dp_first_transaction_in_pkt                                     ) ? (lane{0}_fromStOp_strm_fifo_read_cntl | `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    ) : // delineate using SOP/EOP for NoC'.format(lane)
    pLine = pLine + '\n                                    (toNoc_dp_last_transaction_in_pkt                                      ) ? (lane{0}_fromStOp_strm_fifo_read_cntl | `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    ) : '.format(lane)
    pLine = pLine + '\n                                                                                                                lane{0}_fromStOp_strm_fifo_read_cntl                                        ; '.format(lane)
    pLine = pLine + '\n          scntl__noc__dp_type_p1   = toNoc_dp_type                        ; '.format(lane)
    pLine = pLine + '\n          // We need to use the info from the requesting PE that was captured in the stream controller'
    pLine = pLine + '\n          scntl__noc__dp_peId_p1   = (lane{0}_fromStOp_strm_id) ? strm_control[{0}].strm1_ExternalDmaPeId   : strm_control[{0}].strm0_ExternalDmaPeId   ; // requesting PE          '.format(lane)
    pLine = pLine + '\n          scntl__noc__dp_laneId_p1 = (lane{0}_fromStOp_strm_id) ? strm_control[{0}].strm1_ExternalDmaLaneId : strm_control[{0}].strm0_ExternalDmaLaneId ; // lane in requesting PE  '.format(lane)
    pLine = pLine + '\n          scntl__noc__dp_strmId_p1 = (lane{0}_fromStOp_strm_id) ? strm_control[{0}].strm1_ExternalDmaStrmId : strm_control[{0}].strm0_ExternalDmaStrmId ; // stream in requesting PE'.format(lane)
    pLine = pLine + '\n          scntl__noc__dp_data_p1   = lane{0}_fromStOp_strm_fifo_read_data ; '.format(lane)
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  f = open('../HDL/common/streamingOps_cntl_stOp_noc_to_stOp_fifo_wires.vh', 'w')
  pLine = ""
  numOfStrms = 2
  fifo = "to_stOp_fifo"
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // lane{0} to NoC '.format(lane)
    id = lane * numOfStrms + strm
    pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE                  ] lane{1}_toStOp_strm_cntl                 ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  reg                                                         lane{1}_toStOp_strm_id                   ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  reg  [`STREAMING_OP_CNTL_DATA_RANGE                       ] lane{1}_toStOp_strm_data                 ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  reg                                                         lane{1}_toStOp_strm_fifo_write           ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire                                                        lane{1}_toStOp_strm_ready                ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire                                                        lane{1}_toStOp_strm_fifo_read            ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  reg                                                         lane{1}_toStOp_strm_fifo_read_valid      ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire                                                        lane{1}_toStOp_strm_fifo_empty           ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_RANGE ] lane{1}_toStOp_strm_fifo_eop_count       ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE                  ] lane{1}_toStOp_strm_fifo_read_cntl       ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire                                                        lane{1}_toStOp_strm_fifo_read_id         ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire [`STREAMING_OP_CNTL_DATA_RANGE                       ] lane{1}_toStOp_strm_fifo_read_data       ;'.format(fifo,lane,strm,id) 
    pLine = pLine + '\n  wire                                                        lane{1}_toStOp_strm_fifo_data_available  ;'.format(fifo,lane,strm,id)

  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_stOp_noc_to_stOp_fifo_assignments.vh', 'w')
  pLine = ""
  fifo = "to_stOp_fifo"
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // lane{0}, stream to NoC '.format(lane)
    pLine = pLine + '\n  assign     {0}[{1}].clear                           =  clear_op                           ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     lane{1}_toStOp_strm_fifo_empty           =  {0}[{1}].fifo_empty                ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_toStOp_strm_ready                = ~{0}[{1}].fifo_almost_full          ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_toStOp_strm_fifo_eop_count       =  {0}[{1}].fifo_eop_count            ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     {0}[{1}].fifo_read                       =  lane{1}_toStOp_strm_fifo_read      ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_toStOp_strm_fifo_read_cntl       =  {0}[{1}].fifo_read_cntl            ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_toStOp_strm_fifo_read_id         =  {0}[{1}].fifo_read_strmId          ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     lane{1}_toStOp_strm_fifo_read_data       =  {0}[{1}].fifo_read_data            ;'.format(fifo,lane) 
    pLine = pLine + '\n  assign     {0}[{1}].cntl                            =  lane{1}_toStOp_strm_cntl           ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     {0}[{1}].strmId                          =  lane{1}_toStOp_strm_id             ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     {0}[{1}].data                            =  lane{1}_toStOp_strm_data           ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     {0}[{1}].fifo_write                      =  lane{1}_toStOp_strm_fifo_write     ;'.format(fifo,lane)
    pLine = pLine + '\n  assign     lane{1}_toStOp_strm_fifo_data_available  = ~lane{1}_toStOp_strm_fifo_empty     ;'.format(fifo,lane)
    pLine = pLine + '\n  always @(posedge clk) '
    pLine = pLine + '\n    begin '
    pLine = pLine + '\n      lane{1}_toStOp_strm_fifo_read_valid             <=  lane{1}_toStOp_strm_fifo_read     ;  // real memory is pipelined'.format(fifo,lane)
    pLine = pLine + '\n    end '

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // lane{0} stream to NoC '.format(lane)
    pLine = pLine + '\n  assign     lane{1}_toStOp_strm_fifo_read         = sdp__cntl__lane{1}_strm_ready & lane{1}_toStOp_strm_fifo_data_available  ; // FIXME'.format(fifo,lane) 
    pLine = pLine + '\n  always @(posedge clk) '
    pLine = pLine + '\n    begin '
    pLine = pLine + '\n      cntl__sdp__lane{1}_strm_cntl        <=  lane{1}_toStOp_strm_fifo_read_cntl       ;'.format(fifo,lane)
    pLine = pLine + '\n      cntl__sdp__lane{1}_strm_id          <=  lane{1}_toStOp_strm_fifo_read_id         ;'.format(fifo,lane)
    pLine = pLine + '\n      cntl__sdp__lane{1}_strm_data        <=  lane{1}_toStOp_strm_fifo_read_data       ;'.format(fifo,lane)
    # Changes for real memory
    pLine = pLine + '\n      //cntl__sdp__lane{1}_strm_data_valid  <=  lane{1}_toStOp_strm_fifo_read            ;'.format(fifo,lane)
    pLine = pLine + '\n      cntl__sdp__lane{1}_strm_data_valid  <=  lane{1}_toStOp_strm_fifo_read_valid      ;'.format(fifo,lane)
    pLine = pLine + '\n    end '

  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_stOp_noc_from_noc_data_assignments.vh', 'w')
  pLine = ""
  fifo = "to_stOp_fifo"

  pLine = pLine + '\n  always @(posedge clk)'
  pLine = pLine + '\n    begin'
  pLine = pLine + '\n      toStOpReady   <= \'b0;'
  pLine = pLine + '\n      case(fromNocDataSelectedLane)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n        \'d{0}:'.format(lane)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          toStOpReady <= lane{1}_toStOp_strm_ready ;'.format(fifo,lane)
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'

  pLine = pLine + '\n  always @(posedge clk)'
  pLine = pLine + '\n    begin'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n          lane{1}_toStOp_strm_cntl           = \'d0;'.format(fifo,lane)
    pLine = pLine + '\n          lane{1}_toStOp_strm_id             = \'d0;'.format(fifo,lane)
    pLine = pLine + '\n          lane{1}_toStOp_strm_data           = \'d0;'.format(fifo,lane)
    pLine = pLine + '\n          lane{1}_toStOp_strm_fifo_write     = \'d0;'.format(fifo,lane)
  pLine = pLine + '\n      case(fromNocDataSelectedLane)'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n        \'d{0}:'.format(lane)
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          // there is only one data fifo from the NoC'
    pLine = pLine + '\n          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD'
    pLine = pLine + '\n          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately'
    pLine = pLine + '\n          lane{1}_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : '.format(fifo,lane)
    pLine = pLine + '\n                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : '.format(fifo,lane)
    pLine = pLine + '\n                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : '.format(fifo,lane)
    pLine = pLine + '\n                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; '.format(fifo,lane)
    pLine = pLine + '\n          lane{1}_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;'.format(fifo,lane)
    pLine = pLine + '\n          lane{1}_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;'.format(fifo,lane)
    pLine = pLine + '\n          lane{1}_toStOp_strm_fifo_write = toStOpFifoWrite                         ;'.format(fifo,lane)
    pLine = pLine + '\n        end'
  pLine = pLine + '\n      endcase'
  pLine = pLine + '\n    end'
  pLine = pLine + '\n'


  f.write(pLine)

  #-------------------------------------------------------------------------------------------------------------------------------------
  # PE_CNTL Interface

  f = open('../HDL/common/pe_cntl_simd_port_declarations.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  // Common (Scalar) Register(s)                        '
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs0   ;'.format(lane)
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs1   ;'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Lane Register(s)                                                                 '
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r128  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r129  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r130  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r131  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r132  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r133  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r134  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output[`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r135  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n'  
 
  f.write(pLine)  
  f.close()

  f = open('../HDL/common/pe_cntl_simd_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n    // Common (Scalar) Register(s)                '
  pLine = pLine + '\n            cntl__simd__rs0                  ,'.format(lane)
  pLine = pLine + '\n            cntl__simd__rs1                  ,'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n    // Lane Registers                 '.format(lane)
  pLine = pLine + '\n            cntl__simd__lane_r128                  ,'.format(lane)
  pLine = pLine + '\n            cntl__simd__lane_r129                  ,'.format(lane)
  pLine = pLine + '\n            cntl__simd__lane_r130                  ,'.format(lane)
  pLine = pLine + '\n            cntl__simd__lane_r131                  ,'.format(lane)
  pLine = pLine + '\n            cntl__simd__lane_r132                  ,'.format(lane)
  pLine = pLine + '\n            cntl__simd__lane_r133                  ,'.format(lane)
  pLine = pLine + '\n            cntl__simd__lane_r134                  ,'.format(lane)
  pLine = pLine + '\n            cntl__simd__lane_r135                  ,'.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_cntl_simd_instance_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n            // Common (Scalar) Register(s)                '
  pLine = pLine + '\n            .cntl__simd__rs0         ( cntl__simd__rs0        ),'.format(lane)
  pLine = pLine + '\n            .cntl__simd__rs1         ( cntl__simd__rs1        ),'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Lane {0}             '.format(lane)
  pLine = pLine + '\n            .cntl__simd__lane_r128   ( cntl__simd__lane_r128  ),'.format(lane)
  pLine = pLine + '\n            .cntl__simd__lane_r129   ( cntl__simd__lane_r129  ),'.format(lane)
  pLine = pLine + '\n            .cntl__simd__lane_r130   ( cntl__simd__lane_r130  ),'.format(lane)
  pLine = pLine + '\n            .cntl__simd__lane_r131   ( cntl__simd__lane_r131  ),'.format(lane)
  pLine = pLine + '\n            .cntl__simd__lane_r132   ( cntl__simd__lane_r132  ),'.format(lane)
  pLine = pLine + '\n            .cntl__simd__lane_r133   ( cntl__simd__lane_r133  ),'.format(lane)
  pLine = pLine + '\n            .cntl__simd__lane_r134   ( cntl__simd__lane_r134  ),'.format(lane)
  pLine = pLine + '\n            .cntl__simd__lane_r135   ( cntl__simd__lane_r135  ),'.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_cntl_simd_instance_wires.vh', 'w')
  pLine = ""
  # always create 16 sets of wires for the testbench
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs0  ;'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs1  ;'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r128  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r129  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r130  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r131  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r132  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r133  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r134  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r135  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()


  #-------------------------------------------------------------------------------------------------------------------------------------
  # SIMD Wrapper

  f = open('../HDL/common/pe_simd_wrapper_output_port_declarations.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  // Common (Scalar) Register(s)                '
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs0   ;'.format(lane)
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs1   ;'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Lane Register(s)                '
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r128  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r129  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r130  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r131  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r132  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r133  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r134  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  output [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r135  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n'  
 
  f.write(pLine)  
  f.close()

  f = open('../HDL/common/pe_simd_wrapper_input_port_declarations.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  // Common (Scalar) Register(s)                '
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs0   ;'.format(lane)
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs1   ;'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Lane Register(s)                '
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r128  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r129  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r130  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r131  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r132  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r133  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r134  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r135  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n'  
 
  f.write(pLine)  
  f.close()

  f = open('../HDL/common/pe_simd_wrapper_assignments.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  // Common (Scalar) Register(s)                '
  pLine = pLine + '\n  assign   simd__scntl__rs0  = cntl__simd__rs0 ;'.format(lane)
  pLine = pLine + '\n  assign   simd__scntl__rs1  = cntl__simd__rs1 ;'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Lane Register(s)                '
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n// Lane {0}                 '.format(lane)
    pLine = pLine + '\n  assign  simd__scntl__lane_r128  [{0}]   =   cntl__simd__lane_r128  [{0}]  ;'.format(lane)
    pLine = pLine + '\n  assign  simd__scntl__lane_r129  [{0}]   =   cntl__simd__lane_r129  [{0}]  ;'.format(lane)
    pLine = pLine + '\n  assign  simd__scntl__lane_r130  [{0}]   =   cntl__simd__lane_r130  [{0}]  ;'.format(lane)
    pLine = pLine + '\n  assign  simd__scntl__lane_r131  [{0}]   =   cntl__simd__lane_r131  [{0}]  ;'.format(lane)
    pLine = pLine + '\n  assign  simd__scntl__lane_r132  [{0}]   =   cntl__simd__lane_r132  [{0}]  ;'.format(lane)
    pLine = pLine + '\n  assign  simd__scntl__lane_r133  [{0}]   =   cntl__simd__lane_r133  [{0}]  ;'.format(lane)
    pLine = pLine + '\n  assign  simd__scntl__lane_r134  [{0}]   =   cntl__simd__lane_r134  [{0}]  ;'.format(lane)
    pLine = pLine + '\n  assign  simd__scntl__lane_r135  [{0}]   =   cntl__simd__lane_r135  [{0}]  ;'.format(lane)
    pLine = pLine + '\n'  
  pLine = pLine + '\n'  
 
  f.write(pLine)  
  f.close()

  #--------------------------------------------------
  # Result from stOp to regFile

  f = open('../HDL/common/simd_wrapper_scntl_to_simd_regfile_ports.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n    reg__scntl__lane{0}_ready    ,'.format(lane)
    pLine = pLine + '\n    scntl__reg__lane{0}_valid    ,'.format(lane)
    pLine = pLine + '\n    scntl__reg__lane{0}_data     ,'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/simd_wrapper_scntl_to_simd_regfile_ports_declaration.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  output                                    reg__scntl__lane{0}_ready    ;'.format(lane)
    pLine = pLine + '\n  input                                     scntl__reg__lane{0}_valid    ;'.format(lane)
    pLine = pLine + '\n  input    [`STREAMING_OP_RESULT_RANGE   ]  scntl__reg__lane{0}_data     ;'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/simd_wrapper_scntl_to_simd_regfile_instance_ports.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n    .reg__scntl__lane{0}_ready   ( reg__scntl__lane{0}_ready  ) ,'.format(lane)
    pLine = pLine + '\n    .scntl__reg__lane{0}_valid   ( scntl__reg__lane{0}_valid  ) ,'.format(lane)
    pLine = pLine + '\n    .scntl__reg__lane{0}_data    ( scntl__reg__lane{0}_data   ) ,'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/simd_wrapper_scntl_to_simd_regfile_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  wire                                    reg__scntl__lane{0}_ready    ;'.format(lane)
    pLine = pLine + '\n  wire                                    scntl__reg__lane{0}_valid    ;'.format(lane)
    pLine = pLine + '\n  wire   [`STREAMING_OP_RESULT_RANGE   ]  scntl__reg__lane{0}_data     ;'.format(lane)
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/simd_wrapper_scntl_to_simd_regfile_assignments.vh', 'w')

  pLine = ""
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign regFile_load[{0}].lane_result_valid  = scntl__reg__lane{0}_valid  ;'.format(lane)
    pLine = pLine + '\n  assign regFile_load[{0}].lane_result        = scntl__reg__lane{0}_data   ;'.format(lane)
  pLine = pLine + '\n'

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  assign reg__scntl__lane{0}_ready  = 1\'b1          ;'.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  #-------------------------------------------------------------------------------------------------------------------------------------
  # SIMD Interface

  f = open('../HDL/common/pe_simd_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n    // Common (Scalar) Register(s)                '
  pLine = pLine + '\n            simd__scntl__rs0                  ,'.format(lane)
  pLine = pLine + '\n            simd__scntl__rs1                  ,'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n    // Lane Registers                 '.format(lane)
  pLine = pLine + '\n            simd__scntl__lane_r128                  ,'.format(lane)
  pLine = pLine + '\n            simd__scntl__lane_r129                  ,'.format(lane)
  pLine = pLine + '\n            simd__scntl__lane_r130                  ,'.format(lane)
  pLine = pLine + '\n            simd__scntl__lane_r131                  ,'.format(lane)
  pLine = pLine + '\n            simd__scntl__lane_r132                  ,'.format(lane)
  pLine = pLine + '\n            simd__scntl__lane_r133                  ,'.format(lane)
  pLine = pLine + '\n            simd__scntl__lane_r134                  ,'.format(lane)
  pLine = pLine + '\n            simd__scntl__lane_r135                  ,'.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_simd_port_declarations.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  // Common (Scalar) Register(s)                '
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs0   ;'.format(lane)
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs1   ;'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n  // Lane Register(s)                '
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r128  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r129  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r130  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r131  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r132  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r133  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r134  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n  input [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r135  [`PE_NUM_OF_EXEC_LANES ] ;'.format(lane)
  pLine = pLine + '\n'  
 
  f.write(pLine)  
  f.close()

  f = open('../HDL/common/pe_simd_instance_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n            // Common (Scalar) Register(s)                '
  pLine = pLine + '\n            .simd__scntl__rs0         ( simd__scntl__rs0        ),'.format(lane)
  pLine = pLine + '\n            .simd__scntl__rs1         ( simd__scntl__rs1        ),'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Lane {0}             '.format(lane)
  pLine = pLine + '\n            .simd__scntl__lane_r128   ( simd__scntl__lane_r128  ),'.format(lane)
  pLine = pLine + '\n            .simd__scntl__lane_r129   ( simd__scntl__lane_r129  ),'.format(lane)
  pLine = pLine + '\n            .simd__scntl__lane_r130   ( simd__scntl__lane_r130  ),'.format(lane)
  pLine = pLine + '\n            .simd__scntl__lane_r131   ( simd__scntl__lane_r131  ),'.format(lane)
  pLine = pLine + '\n            .simd__scntl__lane_r132   ( simd__scntl__lane_r132  ),'.format(lane)
  pLine = pLine + '\n            .simd__scntl__lane_r133   ( simd__scntl__lane_r133  ),'.format(lane)
  pLine = pLine + '\n            .simd__scntl__lane_r134   ( simd__scntl__lane_r134  ),'.format(lane)
  pLine = pLine + '\n            .simd__scntl__lane_r135   ( simd__scntl__lane_r135  ),'.format(lane)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  #-------------------------------------------------------------------------------------------------------------------------------------
  # Test SIMD defines and assignments

  f = open('../HDL/common/pe_simd_instance_wires.vh', 'w')
  pLine = ""
  # always create 16 sets of wires for the testbench
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs0  ;'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs1  ;'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r128  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r129  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r130  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r131  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r132  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r133  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r134  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r135  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_simd_wires.vh', 'w')
  pLine = ""
  # always create 16 sets of wires for the testbench
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs0  ;'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs1  ;'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r128  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r129  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r130  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r131  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r132  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r133  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r134  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r135  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n'

  pLine = ""
  # always create 16 sets of wires for the testbench
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  rs0  ;'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  rs1  ;'.format(lane)
  pLine = pLine + '\n'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n// Lane {0}                 '.format(lane)
    pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  lane{0}_r128  ;'.format(lane)
    pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  lane{0}_r129  ;'.format(lane)
    pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  lane{0}_r130  ;'.format(lane)
    pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  lane{0}_r131  ;'.format(lane)
    pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  lane{0}_r132  ;'.format(lane)
    pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  lane{0}_r133  ;'.format(lane)
    pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  lane{0}_r134  ;'.format(lane)
    pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  lane{0}_r135  ;'.format(lane)
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/streamingOps_cntl_simd_assignments.vh', 'w')
  pLine = ""
  # always create 16 sets of wires for the testbench
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs0  ;'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__rs1  ;'.format(lane)
  pLine = pLine + '\n'
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r128  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r129  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r130  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r131  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r132  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r133  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r134  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__scntl__lane_r135  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n'

  pLine = ""
  # always create 16 sets of wires for the testbench
  pLine = pLine + '\n  assign   rs0  = simd__scntl__rs0 ;'.format(lane)
  pLine = pLine + '\n  assign   rs1  = simd__scntl__rs1 ;'.format(lane)
  pLine = pLine + '\n'
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n// Lane {0}                 '.format(lane)
    pLine = pLine + '\n  assign   lane{0}_r128  =  simd__scntl__lane_r128 [{0}] ;'.format(lane)
    pLine = pLine + '\n  assign   lane{0}_r129  =  simd__scntl__lane_r129 [{0}] ;'.format(lane)
    pLine = pLine + '\n  assign   lane{0}_r130  =  simd__scntl__lane_r130 [{0}] ;'.format(lane)
    pLine = pLine + '\n  assign   lane{0}_r131  =  simd__scntl__lane_r131 [{0}] ;'.format(lane)
    pLine = pLine + '\n  assign   lane{0}_r132  =  simd__scntl__lane_r132 [{0}] ;'.format(lane)
    pLine = pLine + '\n  assign   lane{0}_r133  =  simd__scntl__lane_r133 [{0}] ;'.format(lane)
    pLine = pLine + '\n  assign   lane{0}_r134  =  simd__scntl__lane_r134 [{0}] ;'.format(lane)
    pLine = pLine + '\n  assign   lane{0}_r135  =  simd__scntl__lane_r135 [{0}] ;'.format(lane)
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()
#! /usr/bin/env python

if __name__ == "__main__":

  import sys
  import os
  import math
  import random
  import re

  # Now extract number of banks and dma ports from the mem_acc_cont.vh file
  FoundBanks = False
  FoundDmas = False
  searchFile = open("../HDL/common/mem_acc_cont.vh", "r")
  for line in searchFile:
    if FoundBanks == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "MEM_ACC_CONT_NUM_OF_MEMORY_BANKS" in data[1]:
        numOfBanks = int(data[2])
        FoundBanks = True
    if FoundDmas == False:
      data = re.split(r'\s{1,}', line)
      if "MEM_ACC_CONT_NUM_OF_DMA_PORTS" in data[1]:
        numOfMemPorts = int(data[2])
        FoundDmas = True
  searchFile.close()

  FoundLanes = False
  searchFile = open("../HDL/common/pe.vh", "r")
  for line in searchFile:
    if FoundLanes == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_EXEC_LANES" in data[1]:
        numOfExecLanes = int(data[2])
        FoundLanes = True
  searchFile.close()

  #numOfExecLanes = 16
  #numOfMemPorts = 32
  #numOfBanks = 64

#! /usr/bin/env python

if __name__ == "__main__":

  import sys
  import os
  import math
  import random
  import re

  # extract number of pe's
  FoundPe = False
  searchFile = open("../HDL/common/pe_array.vh", "r")
  for line in searchFile:
    if FoundPe == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_PE" in data[1]:
        numOfPe = int(data[2])
        FoundPe = True
  searchFile.close()


  f = open('../HDL/common/noc_interpe_port_Bitmask_assignments.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for port in range (0, numOfPorts):
      pLine = pLine + '\n    // PE{0}, Port{1} next hop mask                 '.format(pe,port)
      pLine = pLine + '\n    assign pe_inst[{0}].sys__pe__port{1}_destinationMask    = `NOC_CONT_PE{0}_PORT{1}_DESTINATION_PE_BITMASK ;'.format(pe,port)

  f.write(pLine)
  f.close()

  # Number of actual ports Per PE (all may not be used)
  portsPerPe = 4

  f = open('../HDL/common/pe_noc_interpe_connections.vh', 'w')
  pLine = ""

  # extract number of pe's
  FoundNewPe = False
  FoundPort = False
  searchFile = open("../scripts/nocConfig.txt", "r")
  for line in searchFile:
    if "Number of PEs in X direction" in line:
      data = re.split(r'\s{1,}', line)
      arrayX = int(data[7])
      #print arrayX
    elif "Number of PEs in Y direction" in line:
      data = re.split(r'\s{1,}', line)
      arrayY = int(data[7])
      #print arrayY

    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "PE" in data[0]:
      if len(data) == 4 : 
        foundNewPe = True
        for i in range (0, len(data)):
          data[i] = re.sub('[\[\]]', '', data[i])
        srcPe = int(data[1])*arrayX + int(data[2])
        #print 'Generate connections for PE {0} '.format(srcPe)
    if re.search(r"Number of Ports", line) :
      numOfUtilizedPorts = portsPerPe-int(data[4])
      if numOfUtilizedPorts != 0 :
        pLine = pLine + '\n  // Terminate PE{0}\'s {1} unused Ports'.format(srcPe,numOfUtilizedPorts )
        for uP in range (int(data[4]), portsPerPe):
          pLine = pLine + '\n  assign pe_inst[{0}].noc__pe__port{1}_valid = \'d0 ;'.format(srcPe,uP)
          pLine = pLine + '\n  assign pe_inst[{0}].noc__pe__port{1}_cntl  = \'d0 ;'.format(srcPe,uP)
          pLine = pLine + '\n  assign pe_inst[{0}].noc__pe__port{1}_data  = \'d0 ;'.format(srcPe,uP)
          pLine = pLine + '\n  assign pe_inst[{0}].noc__pe__port{1}_fc    = \'d0 ;'.format(srcPe,uP)
        pLine = pLine + '\n'        
    if re.search(r"Port . Connected to Node", line) :
      #print line
      srcPort  = int(data[1])
      destPe   = int(data[6])*arrayX + int(data[7])
      destPort = int(data[8])
      
      pLine = pLine + '\n  // Connecting PE{0} Port{1} to PE{2} Port{3}'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n  assign pe_inst[{2}].noc__pe__port{3}_valid = pe_inst[{0}].pe__noc__port{1}_valid ;'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n  assign pe_inst[{2}].noc__pe__port{3}_cntl  = pe_inst[{0}].pe__noc__port{1}_cntl  ;'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n  assign pe_inst[{2}].noc__pe__port{3}_data  = pe_inst[{0}].pe__noc__port{1}_data  ;'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n  assign pe_inst[{0}].noc__pe__port{1}_fc    = pe_inst[{2}].pe__noc__port{3}_fc    ;'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n'        


  f.write(pLine)
  f.close()

  searchFile.close()

  # Generate stack bus connections

  f = open('../HDL/common/system_stack_bus_downstream_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n            // General control and status                  ,'.format(pe) 
    pLine = pLine + '\n            //sys__pe{0}__peId                               ,'.format(pe) 
    pLine = pLine + '\n            sys__pe{0}__allSynchronized                    ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__sys__thisSynchronized                   ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__sys__ready                              ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__sys__complete                           ,'.format(pe) 
    #
    pLine = pLine + '\n            // OOB controls the PE                         ,'.format(pe) 
    pLine = pLine + '\n            // For now assume OOB is separate to lanes     ,'.format(pe) 
    pLine = pLine + '\n            std__pe{0}__oob_cntl                           ,'.format(pe) 
    pLine = pLine + '\n            std__pe{0}__oob_valid                          ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__std__oob_ready                          ,'.format(pe) 
    pLine = pLine + '\n            std__pe{0}__oob_type                           ,'.format(pe) 
    pLine = pLine + '\n            std__pe{0}__oob_data                           ,'.format(pe) 
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n            pe{0}__std__lane{1}_strm{2}_ready       ,'.format(pe,lane,strm)
        pLine = pLine + '\n            std__pe{0}__lane{1}_strm{2}_cntl        ,'.format(pe,lane,strm) 
        pLine = pLine + '\n            std__pe{0}__lane{1}_strm{2}_data        ,'.format(pe,lane,strm) 
        #pLine = pLine + '\n            std__pe{0}__lane{1}_strm{2}_data_mask   ,'.format(pe,lane,strm) 
        pLine = pLine + '\n            std__pe{0}__lane{1}_strm{2}_data_valid  ,'.format(pe,lane,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_stack_bus_downstream_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                  '.format(pe) 
    pLine = pLine + '\n  //input [`PE_PE_ID_RANGE                 ]      sys__pe{0}__peId                ;'.format(pe) 
    pLine = pLine + '\n  input                                         sys__pe{0}__allSynchronized     ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__sys__thisSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__sys__ready               ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__sys__complete            ;'.format(pe) 
    #                                                                                                              
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                  '.format(pe) 
    pLine = pLine + '\n  input [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe{0}__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  input                                         std__pe{0}__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__std__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe{0}__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe{0}__oob_data            ;'.format(pe) 
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  output                                          pe{0}__std__lane{1}_strm{2}_ready       ;'.format(pe,lane,strm)
        pLine = pLine + '\n  input [`COMMON_STD_INTF_CNTL_RANGE      ]       std__pe{0}__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  input [`STACK_DOWN_INTF_STRM_DATA_RANGE ]       std__pe{0}__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        #pLine = pLine + '\n  input [`STACK_DOWN_INTF_STRM_DATA_RANGE ]       std__pe{0}__lane{1}_strm{2}_data_mask   ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  input                                           std__pe{0}__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_stack_bus_downstream_instance_wires.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                '.format(pe) 
    pLine = pLine + '\n  //wire[`PE_PE_ID_RANGE                 ]      sys__pe{0}__peId                ;'.format(pe) 
    pLine = pLine + '\n  wire                                        sys__pe{0}__allSynchronized     ;'.format(pe) 
    pLine = pLine + '\n  wire                                        pe{0}__sys__thisSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  wire                                        pe{0}__sys__ready               ;'.format(pe) 
    pLine = pLine + '\n  wire                                        pe{0}__sys__complete            ;'.format(pe) 
    #                                                                                                            
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                '.format(pe) 
    pLine = pLine + '\n  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe{0}__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  wire                                        std__pe{0}__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  wire                                        pe{0}__std__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe{0}__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe{0}__oob_data            ;'.format(pe) 
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  wire                                        pe{0}__std__lane{1}_strm{2}_ready       ;'.format(pe,lane,strm)
        pLine = pLine + '\n  wire [`COMMON_STD_INTF_CNTL_RANGE       ]   std__pe{0}__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]   std__pe{0}__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        #pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]   std__pe{0}__lane{1}_strm{2}_data_mask   ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  wire                                        std__pe{0}__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'
     
  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_stack_bus_downstream_instance_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n               // General control and status                                                       '.format(pe,lane,strm) 
    pLine = pLine + '\n               //.sys__pe{0}__peId                      ( sys__pe{0}__peId                   ),      '.format(pe,lane,strm)
    pLine = pLine + '\n               .sys__pe{0}__allSynchronized           ( sys__pe{0}__allSynchronized        ),      '.format(pe,lane,strm)
    pLine = pLine + '\n               .pe{0}__sys__thisSynchronized          ( pe{0}__sys__thisSynchronized       ),      '.format(pe,lane,strm)
    pLine = pLine + '\n               .pe{0}__sys__ready                     ( pe{0}__sys__ready                  ),      '.format(pe,lane,strm)
    pLine = pLine + '\n               .pe{0}__sys__complete                  ( pe{0}__sys__complete               ),      '.format(pe,lane,strm)
    #                                                                                                                                      
    pLine = pLine + '\n               // OOB controls how the lanes are interpreted                                       '.format(pe,lane,strm) 
    pLine = pLine + '\n               .std__pe{0}__oob_cntl                  ( std__pe{0}__oob_cntl               ),      '.format(pe,lane,strm)
    pLine = pLine + '\n               .std__pe{0}__oob_valid                 ( std__pe{0}__oob_valid              ),      '.format(pe,lane,strm)
    pLine = pLine + '\n               .pe{0}__std__oob_ready                 ( pe{0}__std__oob_ready              ),      '.format(pe,lane,strm)
    pLine = pLine + '\n               .std__pe{0}__oob_type                  ( std__pe{0}__oob_type               ),      '.format(pe,lane,strm)
    pLine = pLine + '\n               .std__pe{0}__oob_data                  ( std__pe{0}__oob_data               ),      '.format(pe,lane,strm)
    #
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n               // PE {0}, Lane {1}                 '.format(pe,lane)
      for strm in range (0, 2):
        pLine = pLine + '\n               .pe{0}__std__lane{1}_strm{2}_ready         ( pe{0}__std__lane{1}_strm{2}_ready      ),      '.format(pe,lane,strm)
        pLine = pLine + '\n               .std__pe{0}__lane{1}_strm{2}_cntl          ( std__pe{0}__lane{1}_strm{2}_cntl       ),      '.format(pe,lane,strm)
        pLine = pLine + '\n               .std__pe{0}__lane{1}_strm{2}_data          ( std__pe{0}__lane{1}_strm{2}_data       ),      '.format(pe,lane,strm)
        pLine = pLine + '\n               .std__pe{0}__lane{1}_strm{2}_data_valid    ( std__pe{0}__lane{1}_strm{2}_data_valid ),      '.format(pe,lane,strm)
        #pLine = pLine + '\n               .std__pe{0}__lane{1}_strm{2}_data_mask     ( std__pe{0}__lane{1}_strm{2}_data_mask  ),      '.format(pe,lane,strm)
        pLine = pLine + '\n'
                                             
  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_stack_bus_downstream_instance_connections.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #
    #pLine = pLine + '\n  assign   pe_inst[{0}].sys__pe__peId               =  sys__pe{0}__peId                           ;'.format(pe) 
    pLine = pLine + '\n  assign   pe_inst[{0}].sys__pe__allSynchronized    =  sys__pe{0}__allSynchronized                ;'.format(pe) 
    pLine = pLine + '\n  assign   pe{0}__sys__thisSynchronized             =  pe_inst[{0}].pe__sys__thisSynchronized     ;'.format(pe)
    pLine = pLine + '\n  assign   pe{0}__sys__ready                        =  pe_inst[{0}].pe__sys__ready                ;'.format(pe)
    pLine = pLine + '\n  assign   pe{0}__sys__complete                     =  pe_inst[{0}].pe__sys__complete             ;'.format(pe)
    #
    pLine = pLine + '\n  assign   pe_inst[{0}].std__pe__oob_cntl           =  std__pe{0}__oob_cntl                       ;'.format(pe) 
    pLine = pLine + '\n  assign   pe_inst[{0}].std__pe__oob_valid          =  std__pe{0}__oob_valid                      ;'.format(pe) 
    pLine = pLine + '\n  assign   pe{0}__std__oob_ready                    =  pe_inst[{0}].pe__std__oob_ready            ;'.format(pe)
    pLine = pLine + '\n  assign   pe_inst[{0}].std__pe__oob_type           =  std__pe{0}__oob_type                       ;'.format(pe) 
    pLine = pLine + '\n  assign   pe_inst[{0}].std__pe__oob_data           =  std__pe{0}__oob_data                       ;'.format(pe) 
    #
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  assign   pe{0}__std__lane{1}_strm{2}_ready                 =  pe_inst[{0}].pe__std__lane{1}_strm{2}_ready  ;'.format(pe,lane,strm)
        pLine = pLine + '\n  assign   pe_inst[{0}].std__pe__lane{1}_strm{2}_cntl        =  std__pe{0}__lane{1}_strm{2}_cntl             ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  assign   pe_inst[{0}].std__pe__lane{1}_strm{2}_data        =  std__pe{0}__lane{1}_strm{2}_data             ;'.format(pe,lane,strm) 
        #pLine = pLine + '\n  assign   pe_inst[{0}].std__pe__lane{1}_strm{2}_data_mask   =  std__pe{0}__lane{1}_strm{2}_data_mask        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  assign   pe_inst[{0}].std__pe__lane{1}_strm{2}_data_valid  =  std__pe{0}__lane{1}_strm{2}_data_valid       ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  #    pLine = pLine + '\n  assign pe_inst[{1}].noc__pe__port{0}_valid = pe_inst[{1}].pe__noc__port{0}_valid ;'.format(port,pe)

  f = open('../HDL/common/sys_general_connections.vh', 'w')
  pLine = ""
  pLine = pLine + '\n  // Send an \'all\' synchronized to all PE\'s '
  pLine = pLine + '\n  // pe__sys__thisSyncnronized basically means all the streams in a PE are complete'
  pLine = pLine + '\n  // The PE controller will move to a \'final\' state once it receives sys__pe__allSynchronized'
  pLine = pLine + '\n  wire  sys__pe__allSynchronized = pe_inst[0].pe__sys__thisSynchronized & '  
  for pe in range (1, numOfPe-1):
    pLine = pLine + '\n                                   pe_inst[{0}].pe__sys__thisSynchronized & '.format(pe)
  pLine = pLine + '\n                                   pe_inst[{0}].pe__sys__thisSynchronized ; '.format(numOfPe-1)

  f.write(pLine)
  f.close()

  # Generate pe datapath stack bus connections

  f = open('../HDL/common/pe_stack_bus_downstream_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n            // General control and status               ,' 
  pLine = pLine + '\n            sys__pe__peId                               ,' 
  pLine = pLine + '\n            sys__pe__allSynchronized                    ,' 
  pLine = pLine + '\n            pe__sys__thisSynchronized                   ,' 
  pLine = pLine + '\n            pe__sys__ready                              ,' 
  pLine = pLine + '\n            pe__sys__complete                           ,' 
  #
  pLine = pLine + '\n            // OOB controls how the lanes are interpreted  ,'.format(lane,pe,strm) 
  pLine = pLine + '\n            std__pe__oob_cntl                           ,'.format(lane,pe,strm) 
  pLine = pLine + '\n            std__pe__oob_valid                          ,'.format(lane,pe,strm) 
  pLine = pLine + '\n            pe__std__oob_ready                          ,'.format(lane,pe,strm) 
  pLine = pLine + '\n            std__pe__oob_type                           ,'.format(lane,pe,strm) 
  pLine = pLine + '\n            std__pe__oob_data                           ,'.format(lane,pe,strm) 
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n            // Lane operand bus                 '.format(lane)
    pLine = pLine + '\n            pe__std__lane{0}_strm0_ready       ,'.format(lane)
    pLine = pLine + '\n            std__pe__lane{0}_strm0_cntl        ,'.format(lane) 
    pLine = pLine + '\n            std__pe__lane{0}_strm0_data        ,'.format(lane) 
    #pLine = pLine + '\n            std__pe__lane{0}_strm0_data_mask   ,'.format(lane) 
    pLine = pLine + '\n            std__pe__lane{0}_strm0_data_valid  ,'.format(lane) 
    pLine = pLine + '\n            pe__std__lane{0}_strm1_ready       ,'.format(lane)
    pLine = pLine + '\n            std__pe__lane{0}_strm1_cntl        ,'.format(lane) 
    pLine = pLine + '\n            std__pe__lane{0}_strm1_data        ,'.format(lane) 
    pLine = pLine + '\n            std__pe__lane{0}_strm1_data_valid  ,'.format(lane) 
    #pLine = pLine + '\n            std__pe__lane{0}_strm1_data_mask   ,'.format(lane)
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_stack_bus_downstream_port_declarations.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  // General control and status                                               ' 
  pLine = pLine + '\n  input [`PE_PE_ID_RANGE                 ]      sys__pe__peId                ;' 
  pLine = pLine + '\n  input                                         sys__pe__allSynchronized     ;' 
  pLine = pLine + '\n  output                                        pe__sys__thisSynchronized    ;' 
  pLine = pLine + '\n  output                                        pe__sys__ready               ;' 
  pLine = pLine + '\n  output                                        pe__sys__complete            ;' 
  #
  pLine = pLine + '\n  // OOB carries PE configuration                                           '.format(lane,pe,strm) 
  pLine = pLine + '\n  input [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl            ;'.format(lane,pe,strm) 
  pLine = pLine + '\n  input                                         std__pe__oob_valid           ;'.format(lane,pe,strm) 
  pLine = pLine + '\n  output                                        pe__std__oob_ready           ;'.format(lane,pe,strm) 
  pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type            ;'.format(lane,pe,strm) 
  pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data            ;'.format(lane,pe,strm) 
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // Lane operand bus                 '.format(lane)
    pLine = pLine + '\n  output                                           pe__std__lane{0}_strm0_ready       ;'.format(lane)
    pLine = pLine + '\n  input [`COMMON_STD_INTF_CNTL_RANGE       ]       std__pe__lane{0}_strm0_cntl        ;'.format(lane) 
    pLine = pLine + '\n  input [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       std__pe__lane{0}_strm0_data        ;'.format(lane) 
    #pLine = pLine + '\n  input [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       std__pe__lane{0}_strm0_data_mask   ;'.format(lane) 
    pLine = pLine + '\n  input                                            std__pe__lane{0}_strm0_data_valid  ;'.format(lane) 
    pLine = pLine + '\n  output                                           pe__std__lane{0}_strm1_ready       ;'.format(lane)
    pLine = pLine + '\n  input [`COMMON_STD_INTF_CNTL_RANGE       ]       std__pe__lane{0}_strm1_cntl        ;'.format(lane) 
    pLine = pLine + '\n  input [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       std__pe__lane{0}_strm1_data        ;'.format(lane) 
    #pLine = pLine + '\n  input [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       std__pe__lane{0}_strm1_data_mask   ;'.format(lane) 
    pLine = pLine + '\n  input                                            std__pe__lane{0}_strm1_data_valid  ;'.format(lane) 
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_stack_bus_downstream_instance_wires.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  // General control and status                                             ' 
  pLine = pLine + '\n  wire [`PE_PE_ID_RANGE                 ]     sys__pe__peId                ;' 
  pLine = pLine + '\n  wire                                        sys__pe__allSynchronized     ;' 
  pLine = pLine + '\n  wire                                        pe__sys__thisSynchronized    ;' 
  pLine = pLine + '\n  wire                                        pe__sys__ready               ;' 
  pLine = pLine + '\n  wire                                        pe__sys__complete            ;' 
  #
  pLine = pLine + '\n  // OOB carries PE configuration                                           '
  pLine = pLine + '\n  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl            ;' 
  pLine = pLine + '\n  wire                                        std__pe__oob_valid           ;' 
  pLine = pLine + '\n  wire                                        pe__std__oob_ready           ;' 
  pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type            ;' 
  pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data            ;' 
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // Lane operand bus                 '.format(lane)
    pLine = pLine + '\n  wire                                           pe__std__lane{0}_strm0_ready       ;'.format(lane)
    pLine = pLine + '\n  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      std__pe__lane{0}_strm0_cntl        ;'.format(lane) 
    pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      std__pe__lane{0}_strm0_data        ;'.format(lane) 
    #pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      std__pe__lane{0}_strm0_data_mask   ;'.format(lane) 
    pLine = pLine + '\n  wire                                           std__pe__lane{0}_strm0_data_valid  ;'.format(lane) 
    pLine = pLine + '\n  wire                                           pe__std__lane{0}_strm1_ready       ;'.format(lane)
    pLine = pLine + '\n  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      std__pe__lane{0}_strm1_cntl        ;'.format(lane) 
    pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      std__pe__lane{0}_strm1_data        ;'.format(lane) 
    #pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      std__pe__lane{0}_strm1_data_mask   ;'.format(lane) 
    pLine = pLine + '\n  wire                                           std__pe__lane{0}_strm1_data_valid  ;'.format(lane) 

  f.write(pLine)
  f.close()

  f = open('../HDL/common/pe_stack_bus_downstream_instance_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n               // General control and status                                                 '
  pLine = pLine + '\n               .sys__pe__peId                      ( sys__pe__peId                   ),      '
  pLine = pLine + '\n               .sys__pe__allSynchronized           ( sys__pe__allSynchronized        ),      '
  pLine = pLine + '\n               .pe__sys__thisSynchronized          ( pe__sys__thisSynchronized       ),      '
  pLine = pLine + '\n               .pe__sys__ready                     ( pe__sys__ready                  ),      '
  pLine = pLine + '\n               .pe__sys__complete                  ( pe__sys__complete               ),      '

  pLine = pLine + '\n               // OOB carries PE configuration                                               '
  pLine = pLine + '\n               .std__pe__oob_cntl                  ( std__pe__oob_cntl               ),      '
  pLine = pLine + '\n               .std__pe__oob_valid                 ( std__pe__oob_valid              ),      '
  pLine = pLine + '\n               .pe__std__oob_ready                 ( pe__std__oob_ready              ),      '
  pLine = pLine + '\n               .std__pe__oob_type                  ( std__pe__oob_type               ),      '
  pLine = pLine + '\n               .std__pe__oob_data                  ( std__pe__oob_data               ),      '
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n               // Lane {0}                 '.format(lane)
    for strm in range (0, 2):
      pLine = pLine + '\n               .pe__std__lane{0}_strm{1}_ready         ( pe__std__lane{0}_strm{1}_ready      ),      '.format(lane,strm)
      pLine = pLine + '\n               .std__pe__lane{0}_strm{1}_cntl          ( std__pe__lane{0}_strm{1}_cntl       ),      '.format(lane,strm)
      pLine = pLine + '\n               .std__pe__lane{0}_strm{1}_data          ( std__pe__lane{0}_strm{1}_data       ),      '.format(lane,strm)
      pLine = pLine + '\n               .std__pe__lane{0}_strm{1}_data_valid    ( std__pe__lane{0}_strm{1}_data_valid ),      '.format(lane,strm)
      #pLine = pLine + '\n               .std__pe__lane{0}_strm{1}_data_mask     ( std__pe__lane{0}_strm{1}_data_mask  ),      '.format(lane,strm)
                                             
  f.write(pLine)
  f.close()



  f = open('../HDL/common/stack_interface_to_pe_cntl_downstream_ports.vh', 'w')
  pLine = ""
  #
  pLine = pLine + '\n            // OOB carry general PE control for both streaming Ops and SIMD controls how the lanes are interpreted'.format(lane,pe,strm) 
  pLine = pLine + '\n            sti__cntl__oob_cntl                           ,'.format(lane,pe,strm) 
  pLine = pLine + '\n            sti__cntl__oob_valid                          ,'.format(lane,pe,strm) 
  pLine = pLine + '\n            cntl__sti__oob_ready                          ,'.format(lane,pe,strm) 
  pLine = pLine + '\n            sti__cntl__oob_type                           ,'.format(lane,pe,strm) 
  pLine = pLine + '\n            sti__cntl__oob_data                           ,'.format(lane,pe,strm) 

  f.write(pLine)
  f.close()


  f = open('../HDL/common/stack_interface_to_pe_cntl_downstream_port_declarations.vh', 'w')
  pLine = ""
  #
  pLine = pLine + '\n  // OOB carries PE configuration                                           '.format(lane,pe,strm) 
  pLine = pLine + '\n  input [`COMMON_STD_INTF_CNTL_RANGE     ]      sti__cntl__oob_cntl            ;'.format(lane,pe,strm) 
  pLine = pLine + '\n  input                                         sti__cntl__oob_valid           ;'.format(lane,pe,strm) 
  pLine = pLine + '\n  output                                        cntl__sti__oob_ready           ;'.format(lane,pe,strm) 
  pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      sti__cntl__oob_type            ;'.format(lane,pe,strm) 
  pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      sti__cntl__oob_data            ;'.format(lane,pe,strm) 


  f.write(pLine)
  f.close()



  f = open('../HDL/common/stack_interface_to_pe_cntl_downstream_instance_ports.vh', 'w')
  pLine = ""
  #
  pLine = pLine + '\n               // OOB carries PE configuration                                               '
  pLine = pLine + '\n               .sti__cntl__oob_cntl                  ( sti__cntl__oob_cntl               ),      '
  pLine = pLine + '\n               .sti__cntl__oob_valid                 ( sti__cntl__oob_valid              ),      '
  pLine = pLine + '\n               .cntl__sti__oob_ready                 ( cntl__sti__oob_ready              ),      '
  pLine = pLine + '\n               .sti__cntl__oob_type                  ( sti__cntl__oob_type               ),      '
  pLine = pLine + '\n               .sti__cntl__oob_data                  ( sti__cntl__oob_data               ),      '

  f.write(pLine)
  f.close()



  f = open('../HDL/common/stack_interface_to_pe_cntl_downstream_instance_wires.vh', 'w')
  pLine = ""
  #
  pLine = pLine + '\n  // OOB carries PE configuration                                           '
  pLine = pLine + '\n  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      sti__cntl__oob_cntl            ;' 
  pLine = pLine + '\n  wire                                        sti__cntl__oob_valid           ;' 
  pLine = pLine + '\n  wire                                        cntl__sti__oob_ready           ;' 
  pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      sti__cntl__oob_type            ;' 
  pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      sti__cntl__oob_data            ;' 


  f.write(pLine)
  f.close()


  f = open('../HDL/common/pe_cntl_simd_instance_wires.vh', 'w')
  pLine = ""
  # always create 16 sets of wires for the testbench
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs0  ;'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs1  ;'.format(lane)
  pLine = pLine + '\n'                                               
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r128  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r129  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r130  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r131  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r132  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r133  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r134  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n  wire [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r135  [`PE_NUM_OF_EXEC_LANES ];'.format(lane)
  pLine = pLine + '\n'

  # always create 16 sets of regs to latch the output of the configuration memory
  pLine = pLine + '\n  // create 16 sets of regs to latch the output of the configuration memory'
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs0_e1  ;'.format(lane)
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs1_e1  ;'.format(lane)
  pLine = pLine + '\n'                                               
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r128_e1  ;'.format(lane)
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r129_e1  ;'.format(lane)
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r130_e1  ;'.format(lane)
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r131_e1  ;'.format(lane)
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r132_e1  ;'.format(lane)
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r133_e1  ;'.format(lane)
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r134_e1  ;'.format(lane)
  pLine = pLine + '\n  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r135_e1  ;'.format(lane)
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()




  f = open('../HDL/common/stack_interface_to_stOp_downstream_ports.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n            stOp__sti__lane{0}_strm{1}_ready       ,'.format(lane,strm)
      pLine = pLine + '\n            sti__stOp__lane{0}_strm{1}_cntl        ,'.format(lane,strm) 
      pLine = pLine + '\n            sti__stOp__lane{0}_strm{1}_data        ,'.format(lane,strm) 
      pLine = pLine + '\n            sti__stOp__lane{0}_strm{1}_data_mask   ,'.format(lane,strm) 
      pLine = pLine + '\n            sti__stOp__lane{0}_strm{1}_data_valid  ,'.format(lane,strm) 
      pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/stack_interface_to_stOp_downstream_port_declarations.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  input                                             stOp__sti__lane{0}_strm{1}_ready       ;'.format(lane,strm)
      pLine = pLine + '\n  output [`COMMON_STD_INTF_CNTL_RANGE       ]       sti__stOp__lane{0}_strm{1}_cntl        ;'.format(lane,strm) 
      pLine = pLine + '\n  output [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       sti__stOp__lane{0}_strm{1}_data        ;'.format(lane,strm) 
      pLine = pLine + '\n  output [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       sti__stOp__lane{0}_strm{1}_data_mask   ;'.format(lane,strm) 
      pLine = pLine + '\n  output                                            sti__stOp__lane{0}_strm{1}_data_valid  ;'.format(lane,strm) 
      pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/stack_interface_to_stOp_downstream_instance_ports.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n               // Lane {0}                 '.format(lane)
    for strm in range (0, 2):
      pLine = pLine + '\n               .stOp__sti__lane{0}_strm{1}_ready      ( stOp__sti__lane{0}_strm{1}_ready      ),      '.format(lane,strm)
      pLine = pLine + '\n               .sti__stOp__lane{0}_strm{1}_cntl       ( sti__stOp__lane{0}_strm{1}_cntl       ),      '.format(lane,strm)
      pLine = pLine + '\n               .sti__stOp__lane{0}_strm{1}_data       ( sti__stOp__lane{0}_strm{1}_data       ),      '.format(lane,strm)
      pLine = pLine + '\n               .sti__stOp__lane{0}_strm{1}_data_mask  ( sti__stOp__lane{0}_strm{1}_data_mask  ),      '.format(lane,strm)
      pLine = pLine + '\n               .sti__stOp__lane{0}_strm{1}_data_valid ( sti__stOp__lane{0}_strm{1}_data_valid ),      '.format(lane,strm)
                                             
  f.write(pLine)
  f.close()

  f = open('../HDL/common/stack_interface_to_stOp_downstream_instance_wires.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  wire                                            stOp__sti__lane{0}_strm{1}_ready       ;'.format(lane,strm)
      pLine = pLine + '\n  wire [`COMMON_STD_INTF_CNTL_RANGE       ]       sti__stOp__lane{0}_strm{1}_cntl        ;'.format(lane,strm) 
      pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       sti__stOp__lane{0}_strm{1}_data        ;'.format(lane,strm) 
      pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       sti__stOp__lane{0}_strm{1}_data_mask   ;'.format(lane,strm) 
      pLine = pLine + '\n  wire                                            sti__stOp__lane{0}_strm{1}_data_valid  ;'.format(lane,strm) 
      pLine = pLine + '\n'
      
  f.write(pLine)
  f.close()


  f = open('../HDL/common/stack_interface_to_stOp_downstream_connections.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      pLine = pLine + '\n  assign    pe__std__lane{0}_strm{1}_ready         =  stOp__sti__lane{0}_strm{1}_ready   ;'.format(lane,strm)
      pLine = pLine + '\n  assign    sti__stOp__lane{0}_strm{1}_cntl        =  std__pe__lane{0}_strm{1}_cntl      ;'.format(lane,strm) 
      pLine = pLine + '\n  assign    sti__stOp__lane{0}_strm{1}_data        =  std__pe__lane{0}_strm{1}_data      ;'.format(lane,strm) 
      #pLine = pLine + '\n  assign    sti__stOp__lane{0}_strm{1}_data_mask   =  std__pe__lane{0}_strm{1}_data_mask ;'.format(lane,strm) 
      #FIXME : right now oob and lane buses are separate
      pLine = pLine + '\n  assign    sti__stOp__lane{0}_strm{1}_data_valid  =  std__pe__lane{0}_strm{1}_data_valid & ~std__pe__oob_valid   ; // not for stOp if OOB valid'.format(lane,strm) 
      pLine = pLine + '\n'

  f.write(pLine)
  f.close()
