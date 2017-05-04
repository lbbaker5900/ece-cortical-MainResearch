
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT:
           // Request from port<n> has been masked with this managers mask
           // SOurce will start transmitting as soon as all destinations are ready
             nc_local_inq_cntl_state_next = ( port0_localInqReq )  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0  :
                                            ( port1_localInqReq )  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1  :
                                            ( port2_localInqReq )  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2  :
                                            ( port3_localInqReq )  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3  :
                                                                     `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT          ; 
 
            // NoC packets always have more than one transaction so SOP_EOP will not be seen
            // NoC source controller has already read the header to determine the destination mask address, but it will still provide a "valid_fromNoc" signal when it starts transerring tbe entire external NoC packet
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0:
             nc_local_inq_cntl_state_next = (Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE0      :
                                                                                                                                                      `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0  ; 

           // when we transfer a packet between a Port and the In-queue, we will pass the packet to the CNTL block. 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE0:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0  :
                                             (port1_localInqReq && Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1       :  // EOP so go to the next port
                                             (port2_localInqReq && Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2       :  // EOP so go to the next port
                                             (port3_localInqReq && Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3       :  // EOP so go to the next port
                                             (                     Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE0           ; 

           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0  :
                                             (port1_localInqReq && Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1       :  // EOP so go to the next port
                                             (port2_localInqReq && Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2       :  // EOP so go to the next port
                                             (port3_localInqReq && Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3       :  // EOP so go to the next port
                                             (                     Port_from_NoC_Control[0].valid_fromNoc && (Port_from_NoC_Control[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0  ; 
 
            // NoC packets always have more than one transaction so SOP_EOP will not be seen
            // NoC source controller has already read the header to determine the destination mask address, but it will still provide a "valid_fromNoc" signal when it starts transerring tbe entire external NoC packet
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1:
             nc_local_inq_cntl_state_next = (Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE1      :
                                                                                                                                                      `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1  ; 

           // when we transfer a packet between a Port and the In-queue, we will pass the packet to the CNTL block. 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE1:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1  :
                                             (port2_localInqReq && Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2       :  // EOP so go to the next port
                                             (port3_localInqReq && Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3       :  // EOP so go to the next port
                                             (port0_localInqReq && Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0       :  // EOP so go to the next port
                                             (                     Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE1           ; 

           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1  :
                                             (port2_localInqReq && Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2       :  // EOP so go to the next port
                                             (port3_localInqReq && Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3       :  // EOP so go to the next port
                                             (port0_localInqReq && Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0       :  // EOP so go to the next port
                                             (                     Port_from_NoC_Control[1].valid_fromNoc && (Port_from_NoC_Control[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1  ; 
 
            // NoC packets always have more than one transaction so SOP_EOP will not be seen
            // NoC source controller has already read the header to determine the destination mask address, but it will still provide a "valid_fromNoc" signal when it starts transerring tbe entire external NoC packet
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2:
             nc_local_inq_cntl_state_next = (Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE2      :
                                                                                                                                                      `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2  ; 

           // when we transfer a packet between a Port and the In-queue, we will pass the packet to the CNTL block. 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE2:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2  :
                                             (port3_localInqReq && Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3       :  // EOP so go to the next port
                                             (port0_localInqReq && Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0       :  // EOP so go to the next port
                                             (port1_localInqReq && Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1       :  // EOP so go to the next port
                                             (                     Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE2           ; 

           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2  :
                                             (port3_localInqReq && Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3       :  // EOP so go to the next port
                                             (port0_localInqReq && Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0       :  // EOP so go to the next port
                                             (port1_localInqReq && Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1       :  // EOP so go to the next port
                                             (                     Port_from_NoC_Control[2].valid_fromNoc && (Port_from_NoC_Control[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))    ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                              `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2  ; 
 
            // NoC packets always have more than one transaction so SOP_EOP will not be seen
            // NoC source controller has already read the header to determine the destination mask address, but it will still provide a "valid_fromNoc" signal when it starts transerring tbe entire external NoC packet
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3:
             nc_local_inq_cntl_state_next = (Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE3      :
                                                                                                                                                      `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3  ; 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE3:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3  :
                                             (port0_localInqReq && Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0       :  // EOP so go to the next port
                                             (port1_localInqReq && Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1       :  // EOP so go to the next port
                                             (port2_localInqReq && Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2       :  // EOP so go to the next port
                                             (                     Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                            `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE3           ; 
           `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3:
             nc_local_inq_cntl_state_next =  (                     Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc != `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3  :
                                             (port0_localInqReq && Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0       :  // EOP so go to the next port
                                             (port1_localInqReq && Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1       :  // EOP so go to the next port
                                             (port2_localInqReq && Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2       :  // EOP so go to the next port
                                             (                     Port_from_NoC_Control[3].valid_fromNoc && (Port_from_NoC_Control[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM))  ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT               :  // EOP so go to the next port
                                                                                                                                                                            `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3  ; 