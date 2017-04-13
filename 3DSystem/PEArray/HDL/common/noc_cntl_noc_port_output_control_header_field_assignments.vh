
  //---------------------------------------------------
  // Outgoing Port source data 
 
  // Connect Port 0's "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
 
  // Port0, source0
  assign Port_to_NoC[0].src0_cntl_toNoc          = Port_from_NoC[0].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[0].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[0].src0_toNoc_valid                                                          = Port_from_NoC[0].fromNoc_valid ;
 
  // Port0, source1
  assign Port_to_NoC[0].src1_cntl_toNoc          = Port_from_NoC[1].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[0].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[0].src1_toNoc_valid                                                          = Port_from_NoC[1].fromNoc_valid ;
 
  // Port0, source2
  assign Port_to_NoC[0].src2_cntl_toNoc          = Port_from_NoC[2].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[0].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[0].src2_toNoc_valid                                                          = Port_from_NoC[2].fromNoc_valid ;
 
  // Port0, source3
  assign Port_to_NoC[0].src3_cntl_toNoc          = Port_from_NoC[3].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[0].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[0].src3_toNoc_valid                                                          = Port_from_NoC[3].fromNoc_valid ;
 
 
  // Connect Port 1's "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
 
  // Port1, source0
  assign Port_to_NoC[1].src0_cntl_toNoc          = Port_from_NoC[0].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[1].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[1].src0_toNoc_valid                                                          = Port_from_NoC[0].fromNoc_valid ;
 
  // Port1, source1
  assign Port_to_NoC[1].src1_cntl_toNoc          = Port_from_NoC[1].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[1].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[1].src1_toNoc_valid                                                          = Port_from_NoC[1].fromNoc_valid ;
 
  // Port1, source2
  assign Port_to_NoC[1].src2_cntl_toNoc          = Port_from_NoC[2].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[1].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[1].src2_toNoc_valid                                                          = Port_from_NoC[2].fromNoc_valid ;
 
  // Port1, source3
  assign Port_to_NoC[1].src3_cntl_toNoc          = Port_from_NoC[3].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[1].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[1].src3_toNoc_valid                                                          = Port_from_NoC[3].fromNoc_valid ;
 
 
  // Connect Port 2's "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
 
  // Port2, source0
  assign Port_to_NoC[2].src0_cntl_toNoc          = Port_from_NoC[0].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[2].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[2].src0_toNoc_valid                                                          = Port_from_NoC[0].fromNoc_valid ;
 
  // Port2, source1
  assign Port_to_NoC[2].src1_cntl_toNoc          = Port_from_NoC[1].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[2].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[2].src1_toNoc_valid                                                          = Port_from_NoC[1].fromNoc_valid ;
 
  // Port2, source2
  assign Port_to_NoC[2].src2_cntl_toNoc          = Port_from_NoC[2].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[2].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[2].src2_toNoc_valid                                                          = Port_from_NoC[2].fromNoc_valid ;
 
  // Port2, source3
  assign Port_to_NoC[2].src3_cntl_toNoc          = Port_from_NoC[3].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[2].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[2].src3_toNoc_valid                                                          = Port_from_NoC[3].fromNoc_valid ;
 
 
  // Connect Port 3's "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
 
  // Port3, source0
  assign Port_to_NoC[3].src0_cntl_toNoc          = Port_from_NoC[0].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[3].src0_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[0].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[3].src0_toNoc_valid                                                          = Port_from_NoC[0].fromNoc_valid ;
 
  // Port3, source1
  assign Port_to_NoC[3].src1_cntl_toNoc          = Port_from_NoC[1].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[3].src1_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[1].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[3].src1_toNoc_valid                                                          = Port_from_NoC[1].fromNoc_valid ;
 
  // Port3, source2
  assign Port_to_NoC[3].src2_cntl_toNoc          = Port_from_NoC[2].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[3].src2_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[2].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[3].src2_toNoc_valid                                                          = Port_from_NoC[2].fromNoc_valid ;
 
  // Port3, source3
  assign Port_to_NoC[3].src3_cntl_toNoc          = Port_from_NoC[3].cntl_fromNoc  ;
  // remember to gate the destinationMaskAddr with the ports mask address - e.g. bits can only be set if a PE can be reached from this port
  // destination bit field is in the header, so condition on sop
  // We are changing the addr field in the header, so change that conditioned on SOP then leave all cycles alone
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE                  ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PAD_RANGE]                                              ;
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE             ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE]                                              ;
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE     ] = (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM) ? (Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask) :
                                                                                                                                                                          Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE]                                              ;
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_TYPE_RANGE]                                              ;
  assign Port_to_NoC[3].src3_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE            ] = Port_from_NoC[3].data_fromNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE]                                              ;
  assign Port_to_NoC[3].src3_toNoc_valid                                                          = Port_from_NoC[3].fromNoc_valid ;
 
 