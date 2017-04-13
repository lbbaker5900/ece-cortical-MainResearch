
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT:
             nc_local_inq_cntl_state_next = ( port0_localInqReq )  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0  :
                                            ( port1_localInqReq )  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1  :
                                            ( port2_localInqReq )  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2  :
                                            ( port3_localInqReq )  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3  :
                                                                     `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT          ; 
 
            // NoC packets always have more than one transaction so SOP_EOP will not be seen
            // NoCource controller has already read the header to determine the destination mask address, but it will still provide a "fromNoc_valid" signal when it starts transerring tbe entire external NoC packet
            // When sending to the local in-queue, we need to drop the NoC header so waht for the first "fromNoc_valid" and ignore that transaction
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0:
             nc_local_inq_cntl_state_next = (Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP0      :
                                                                                                                                                      `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0  ; 

           // when we transfer a packet between a Port and the In-queue, we will pass the packet to the CNTL block. But we need to strip the external header, this means we need to re-add the SOP indicator 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP0:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0  :
                                             (port1_localInqReq && Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1       :  // EOP so go to the next port
                                             (port2_localInqReq && Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2       :  // EOP so go to the next port
                                             (port3_localInqReq && Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3       :  // EOP so go to the next port
                                             (                     Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP0           ; 

           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0  :
                                             (port1_localInqReq && Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1       :  // EOP so go to the next port
                                             (port2_localInqReq && Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2       :  // EOP so go to the next port
                                             (port3_localInqReq && Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3       :  // EOP so go to the next port
                                             (                     Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0  ; 
 
            // NoC packets always have more than one transaction so SOP_EOP will not be seen
            // NoCource controller has already read the header to determine the destination mask address, but it will still provide a "fromNoc_valid" signal when it starts transerring tbe entire external NoC packet
            // When sending to the local in-queue, we need to drop the NoC header so waht for the first "fromNoc_valid" and ignore that transaction
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1:
             nc_local_inq_cntl_state_next = (Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP1      :
                                                                                                                                                      `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1  ; 

           // when we transfer a packet between a Port and the In-queue, we will pass the packet to the CNTL block. But we need to strip the external header, this means we need to re-add the SOP indicator 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP1:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1  :
                                             (port2_localInqReq && Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2       :  // EOP so go to the next port
                                             (port3_localInqReq && Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3       :  // EOP so go to the next port
                                             (port0_localInqReq && Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0       :  // EOP so go to the next port
                                             (                     Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP1           ; 

           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1  :
                                             (port2_localInqReq && Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2       :  // EOP so go to the next port
                                             (port3_localInqReq && Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3       :  // EOP so go to the next port
                                             (port0_localInqReq && Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0       :  // EOP so go to the next port
                                             (                     Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1  ; 
 
            // NoC packets always have more than one transaction so SOP_EOP will not be seen
            // NoCource controller has already read the header to determine the destination mask address, but it will still provide a "fromNoc_valid" signal when it starts transerring tbe entire external NoC packet
            // When sending to the local in-queue, we need to drop the NoC header so waht for the first "fromNoc_valid" and ignore that transaction
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2:
             nc_local_inq_cntl_state_next = (Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP2      :
                                                                                                                                                      `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2  ; 

           // when we transfer a packet between a Port and the In-queue, we will pass the packet to the CNTL block. But we need to strip the external header, this means we need to re-add the SOP indicator 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP2:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2  :
                                             (port3_localInqReq && Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3       :  // EOP so go to the next port
                                             (port0_localInqReq && Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0       :  // EOP so go to the next port
                                             (port1_localInqReq && Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1       :  // EOP so go to the next port
                                             (                     Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP2           ; 

           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2  :
                                             (port3_localInqReq && Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3       :  // EOP so go to the next port
                                             (port0_localInqReq && Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0       :  // EOP so go to the next port
                                             (port1_localInqReq && Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1       :  // EOP so go to the next port
                                             (                     Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2  ; 
 
            // NoC packets always have more than one transaction so SOP_EOP will not be seen
            // NoCource controller has already read the header to determine the destination mask address, but it will still provide a "fromNoc_valid" signal when it starts transerring tbe entire external NoC packet
            // When sending to the local in-queue, we need to drop the NoC header so waht for the first "fromNoc_valid" and ignore that transaction
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3:
             nc_local_inq_cntl_state_next = (Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP3      :
                                                                                                                                                      `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3  ; 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP3:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3  :
                                             (port0_localInqReq && Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0       :  // EOP so go to the next port
                                             (port1_localInqReq && Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1       :  // EOP so go to the next port
                                             (port2_localInqReq && Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2       :  // EOP so go to the next port
                                             (                     Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                            `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP3           ; 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3  :
                                             (port0_localInqReq && Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0       :  // EOP so go to the next port
                                             (port1_localInqReq && Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1       :  // EOP so go to the next port
                                             (port2_localInqReq && Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2       :  // EOP so go to the next port
                                             (                     Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                            `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3  ; 