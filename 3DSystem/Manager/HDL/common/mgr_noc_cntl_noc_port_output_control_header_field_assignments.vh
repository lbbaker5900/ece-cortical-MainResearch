
  //---------------------------------------------------
  // Outgoing Port source data 
 
  // Connect Port {0}'s "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
  // The fields in the bus from the source have been set at the requestor, so simply pass the data from the requestor directly to the output FIFO
 
  // Port0, source0
  assign Port_to_NoC[0].src0_cntl_toNoc    =  Port_from_NoC_Control[0].cntl_fromNoc  ;
  assign Port_to_NoC[0].src0_data_toNoc    = (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[0].data_fromNoc                       ;
  assign Port_to_NoC[0].src0_toNoc_valid   = Port_from_NoC_Control[0].valid_fromNoc ;
 
  // Port0, source1
  assign Port_to_NoC[0].src1_cntl_toNoc    =  Port_from_NoC_Control[1].cntl_fromNoc  ;
  assign Port_to_NoC[0].src1_data_toNoc    = (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[1].data_fromNoc                       ;
  assign Port_to_NoC[0].src1_toNoc_valid   = Port_from_NoC_Control[1].valid_fromNoc ;
 
  // Port0, source2
  assign Port_to_NoC[0].src2_cntl_toNoc    =  Port_from_NoC_Control[2].cntl_fromNoc  ;
  assign Port_to_NoC[0].src2_data_toNoc    = (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[2].data_fromNoc                       ;
  assign Port_to_NoC[0].src2_toNoc_valid   = Port_from_NoC_Control[2].valid_fromNoc ;
 
  // Port0, source3
  assign Port_to_NoC[0].src3_cntl_toNoc    =  Port_from_NoC_Control[3].cntl_fromNoc  ;
  assign Port_to_NoC[0].src3_data_toNoc    = (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[0].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[3].data_fromNoc                       ;
  assign Port_to_NoC[0].src3_toNoc_valid   = Port_from_NoC_Control[3].valid_fromNoc ;
 
 
  // Connect Port {0}'s "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
  // The fields in the bus from the source have been set at the requestor, so simply pass the data from the requestor directly to the output FIFO
 
  // Port1, source0
  assign Port_to_NoC[1].src0_cntl_toNoc    =  Port_from_NoC_Control[0].cntl_fromNoc  ;
  assign Port_to_NoC[1].src0_data_toNoc    = (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[0].data_fromNoc                       ;
  assign Port_to_NoC[1].src0_toNoc_valid   = Port_from_NoC_Control[0].valid_fromNoc ;
 
  // Port1, source1
  assign Port_to_NoC[1].src1_cntl_toNoc    =  Port_from_NoC_Control[1].cntl_fromNoc  ;
  assign Port_to_NoC[1].src1_data_toNoc    = (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[1].data_fromNoc                       ;
  assign Port_to_NoC[1].src1_toNoc_valid   = Port_from_NoC_Control[1].valid_fromNoc ;
 
  // Port1, source2
  assign Port_to_NoC[1].src2_cntl_toNoc    =  Port_from_NoC_Control[2].cntl_fromNoc  ;
  assign Port_to_NoC[1].src2_data_toNoc    = (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[2].data_fromNoc                       ;
  assign Port_to_NoC[1].src2_toNoc_valid   = Port_from_NoC_Control[2].valid_fromNoc ;
 
  // Port1, source3
  assign Port_to_NoC[1].src3_cntl_toNoc    =  Port_from_NoC_Control[3].cntl_fromNoc  ;
  assign Port_to_NoC[1].src3_data_toNoc    = (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[1].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[3].data_fromNoc                       ;
  assign Port_to_NoC[1].src3_toNoc_valid   = Port_from_NoC_Control[3].valid_fromNoc ;
 
 
  // Connect Port {0}'s "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
  // The fields in the bus from the source have been set at the requestor, so simply pass the data from the requestor directly to the output FIFO
 
  // Port2, source0
  assign Port_to_NoC[2].src0_cntl_toNoc    =  Port_from_NoC_Control[0].cntl_fromNoc  ;
  assign Port_to_NoC[2].src0_data_toNoc    = (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[0].data_fromNoc                       ;
  assign Port_to_NoC[2].src0_toNoc_valid   = Port_from_NoC_Control[0].valid_fromNoc ;
 
  // Port2, source1
  assign Port_to_NoC[2].src1_cntl_toNoc    =  Port_from_NoC_Control[1].cntl_fromNoc  ;
  assign Port_to_NoC[2].src1_data_toNoc    = (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[1].data_fromNoc                       ;
  assign Port_to_NoC[2].src1_toNoc_valid   = Port_from_NoC_Control[1].valid_fromNoc ;
 
  // Port2, source2
  assign Port_to_NoC[2].src2_cntl_toNoc    =  Port_from_NoC_Control[2].cntl_fromNoc  ;
  assign Port_to_NoC[2].src2_data_toNoc    = (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[2].data_fromNoc                       ;
  assign Port_to_NoC[2].src2_toNoc_valid   = Port_from_NoC_Control[2].valid_fromNoc ;
 
  // Port2, source3
  assign Port_to_NoC[2].src3_cntl_toNoc    =  Port_from_NoC_Control[3].cntl_fromNoc  ;
  assign Port_to_NoC[2].src3_data_toNoc    = (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[2].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[3].data_fromNoc                       ;
  assign Port_to_NoC[2].src3_toNoc_valid   = Port_from_NoC_Control[3].valid_fromNoc ;
 
 
  // Connect Port {0}'s "other" ports "to Noc" packet data requests to 0,1,2,3 of the output port controller
  // The fields in the bus from the source have been set at the requestor, so simply pass the data from the requestor directly to the output FIFO
 
  // Port3, source0
  assign Port_to_NoC[3].src0_cntl_toNoc    =  Port_from_NoC_Control[0].cntl_fromNoc  ;
  assign Port_to_NoC[3].src0_data_toNoc    = (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[0].data_fromNoc                       ;
  assign Port_to_NoC[3].src0_toNoc_valid   = Port_from_NoC_Control[0].valid_fromNoc ;
 
  // Port3, source1
  assign Port_to_NoC[3].src1_cntl_toNoc    =  Port_from_NoC_Control[1].cntl_fromNoc  ;
  assign Port_to_NoC[3].src1_data_toNoc    = (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[1].data_fromNoc                       ;
  assign Port_to_NoC[3].src1_toNoc_valid   = Port_from_NoC_Control[1].valid_fromNoc ;
 
  // Port3, source2
  assign Port_to_NoC[3].src2_cntl_toNoc    =  Port_from_NoC_Control[2].cntl_fromNoc  ;
  assign Port_to_NoC[3].src2_data_toNoc    = (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[2].data_fromNoc                       ;
  assign Port_to_NoC[3].src2_toNoc_valid   = Port_from_NoC_Control[2].valid_fromNoc ;
 
  // Port3, source3
  assign Port_to_NoC[3].src3_cntl_toNoc    =  Port_from_NoC_Control[3].cntl_fromNoc  ;
  assign Port_to_NoC[3].src3_data_toNoc    = (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM    ) ? {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask)}  :
                                             (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM_EOM) ? {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE], Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE], (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & Port_to_NoC[3].thisPort_destinationMask)}  :
                                                                                                                 Port_from_NoC_Control[3].data_fromNoc                       ;
  assign Port_to_NoC[3].src3_toNoc_valid   = Port_from_NoC_Control[3].valid_fromNoc ;
 
 