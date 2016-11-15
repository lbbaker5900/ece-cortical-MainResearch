
           // Round-robin arbiter granting access to the port in the following order: local - 1 - 2 - 3                                         
           // If control packets arrive on a requestor, the requestor decides to send the control packet but then ahs to wait for its next turn 
           // Note: Ports 1-2-3 refer to the 3 ports accessing this port, not the actual ports 1,2,3                                            
           // Assume each requestor will only transfer a single packet                                                                          
           // The requestor deals with prioritizing its own CP or DP packets                                                                    
           //                                                                                                                                   
           // The request is directed to a particular port by 'ANDing' the ports routing bitmask with the destination bitmask                 
           // If there are multiple ack's, the source will wait until all enables are set before reading its fifo for transfer                 
           // 
           // 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT:
             nc_port_toNoc_state_next = ( local_OutqReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL  :
                                        ( src0_OutqReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0  :
                                        ( src1_OutqReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1  :
                                        ( src2_OutqReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2  :
                                        ( src3_OutqReq )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3  :
                                                               `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL:
             nc_port_toNoc_state_next = (local_toNoc_valid && ((local_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (local_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL  :
                                                             `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL   ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL:
             nc_port_toNoc_state_next = ( src0_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0     :
                                        ( src1_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1     :
                                        ( src2_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2     :
                                        ( src3_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3     :
                                        ( local_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL     :
                                                                                   `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0:
             nc_port_toNoc_state_next = (src0_toNoc_valid && ((src0_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (src0_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT0  :
                                                             `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0   ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT0:
             nc_port_toNoc_state_next = ( src1_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1     :
                                        ( src2_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2     :
                                        ( src3_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3     :
                                        ( local_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL     :
                                        ( src0_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0     :
                                                                                   `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1:
             nc_port_toNoc_state_next = (src1_toNoc_valid && ((src1_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (src1_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT1  :
                                                             `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1   ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT1:
             nc_port_toNoc_state_next = ( src2_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2     :
                                        ( src3_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3     :
                                        ( local_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL     :
                                        ( src0_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0     :
                                        ( src1_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1     :
                                                                                   `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2:
             nc_port_toNoc_state_next = (src2_toNoc_valid && ((src2_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (src2_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT2  :
                                                             `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2   ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT2:
             nc_port_toNoc_state_next = ( src3_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3     :
                                        ( local_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL     :
                                        ( src0_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0     :
                                        ( src1_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1     :
                                        ( src2_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2     :
                                                                                   `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3:
             nc_port_toNoc_state_next = (src3_toNoc_valid && ((src3_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (src3_cntl_toNoc == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT3  :
                                                             `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3   ; 

           `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT3:
             nc_port_toNoc_state_next = ( local_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL     :
                                        ( src0_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0     :
                                        ( src1_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1     :
                                        ( src2_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2     :
                                        ( src3_OutqReq                       )  ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3     :
                                                                                   `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT           ; 