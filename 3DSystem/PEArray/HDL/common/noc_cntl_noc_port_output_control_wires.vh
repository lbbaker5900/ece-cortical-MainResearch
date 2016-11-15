
  wire [`PE_PE_ID_BITMASK_RANGE ] thisPort_destinationMask  ; // bitmask indicating which nodes accessed out of this port

  wire                            local_OutqReq             ;  // request from local putput queue controller
  wire [`PE_PE_ID_BITMASK_RANGE ] local_OutqReqAddr         ;  // bitmask address of requestor
  reg                             local_OutqAck             ;
  reg                             local_OutqReady           ;
  // These 3 sources are the 3 sources not the 3 actual ports
  // e.g. if this instance is port 2, 1=port0, 2=port1, 3=port3 etc.
  wire                            src0_OutqReq             ;  // request from source (port) 0
  wire [`PE_PE_ID_BITMASK_RANGE ] src0_OutqReqAddr         ;  // bitmask address of requestor
  reg                             src0_OutqAck             ;  // ack back to source (port) input controller
  reg                             src0_OutqReady           ;
  // This is the packet bus from the 3 possible sources that will be muxed into the output fifo when the source has been acknowledged
  // The local packet bus is common but the 3 sources vary based on "this" port id
  wire                                        src0_toNoc_valid    ;  // data from source is valid
  wire [`NOC_CONT_NOC_PORT_CNTL_RANGE      ]  src0_cntl_toNoc     ;
  wire [`NOC_CONT_NOC_PORT_DATA_RANGE      ]  src0_data_toNoc     ;
  // These 3 sources are the 3 sources not the 3 actual ports
  // e.g. if this instance is port 2, 1=port0, 2=port1, 3=port3 etc.
  wire                            src1_OutqReq             ;  // request from source (port) 1
  wire [`PE_PE_ID_BITMASK_RANGE ] src1_OutqReqAddr         ;  // bitmask address of requestor
  reg                             src1_OutqAck             ;  // ack back to source (port) input controller
  reg                             src1_OutqReady           ;
  // This is the packet bus from the 3 possible sources that will be muxed into the output fifo when the source has been acknowledged
  // The local packet bus is common but the 3 sources vary based on "this" port id
  wire                                        src1_toNoc_valid    ;  // data from source is valid
  wire [`NOC_CONT_NOC_PORT_CNTL_RANGE      ]  src1_cntl_toNoc     ;
  wire [`NOC_CONT_NOC_PORT_DATA_RANGE      ]  src1_data_toNoc     ;
  // These 3 sources are the 3 sources not the 3 actual ports
  // e.g. if this instance is port 2, 1=port0, 2=port1, 3=port3 etc.
  wire                            src2_OutqReq             ;  // request from source (port) 2
  wire [`PE_PE_ID_BITMASK_RANGE ] src2_OutqReqAddr         ;  // bitmask address of requestor
  reg                             src2_OutqAck             ;  // ack back to source (port) input controller
  reg                             src2_OutqReady           ;
  // This is the packet bus from the 3 possible sources that will be muxed into the output fifo when the source has been acknowledged
  // The local packet bus is common but the 3 sources vary based on "this" port id
  wire                                        src2_toNoc_valid    ;  // data from source is valid
  wire [`NOC_CONT_NOC_PORT_CNTL_RANGE      ]  src2_cntl_toNoc     ;
  wire [`NOC_CONT_NOC_PORT_DATA_RANGE      ]  src2_data_toNoc     ;
  // These 3 sources are the 3 sources not the 3 actual ports
  // e.g. if this instance is port 2, 1=port0, 2=port1, 3=port3 etc.
  wire                            src3_OutqReq             ;  // request from source (port) 3
  wire [`PE_PE_ID_BITMASK_RANGE ] src3_OutqReqAddr         ;  // bitmask address of requestor
  reg                             src3_OutqAck             ;  // ack back to source (port) input controller
  reg                             src3_OutqReady           ;
  // This is the packet bus from the 3 possible sources that will be muxed into the output fifo when the source has been acknowledged
  // The local packet bus is common but the 3 sources vary based on "this" port id
  wire                                        src3_toNoc_valid    ;  // data from source is valid
  wire [`NOC_CONT_NOC_PORT_CNTL_RANGE      ]  src3_cntl_toNoc     ;
  wire [`NOC_CONT_NOC_PORT_DATA_RANGE      ]  src3_data_toNoc     ;