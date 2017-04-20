
    wire  port0_localInqReq          ; // Request from an input port after being gated with local bitMask
    reg   port0_localInqPriority     ; // Indicate whether packet is Control or Data
    reg   port0_localInqAck          ; // accept request from input port
    reg   port0_localInqEnable       ; // Indicate when input q is able to take data
    wire  port1_localInqReq          ; // Request from an input port after being gated with local bitMask
    reg   port1_localInqPriority     ; // Indicate whether packet is Control or Data
    reg   port1_localInqAck          ; // accept request from input port
    reg   port1_localInqEnable       ; // Indicate when input q is able to take data
    wire  port2_localInqReq          ; // Request from an input port after being gated with local bitMask
    reg   port2_localInqPriority     ; // Indicate whether packet is Control or Data
    reg   port2_localInqAck          ; // accept request from input port
    reg   port2_localInqEnable       ; // Indicate when input q is able to take data
    wire  port3_localInqReq          ; // Request from an input port after being gated with local bitMask
    reg   port3_localInqPriority     ; // Indicate whether packet is Control or Data
    reg   port3_localInqAck          ; // accept request from input port
    reg   port3_localInqEnable       ; // Indicate when input q is able to take data

  reg  local_port0_OutqAck   ;  // the local input queue is actually an output for the port input controllers
  wire local_port0_OutqReady ;  // so ck the request from the port input controller
  reg  local_port1_OutqAck   ;  // the local input queue is actually an output for the port input controllers
  wire local_port1_OutqReady ;  // so ck the request from the port input controller
  reg  local_port2_OutqAck   ;  // the local input queue is actually an output for the port input controllers
  wire local_port2_OutqReady ;  // so ck the request from the port input controller
  reg  local_port3_OutqAck   ;  // the local input queue is actually an output for the port input controllers
  wire local_port3_OutqReady ;  // so ck the request from the port input controller