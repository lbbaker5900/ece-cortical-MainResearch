
  always @(posedge clk)
    begin
      
      noc__locl__cp_valid       <= (reset_poweron ) ? 'd0 :   noc__locl__cp_valid_p1  ; 
      noc__locl__cp_cntl        <= (reset_poweron ) ? 'd0 :   noc__locl__cp_cntl_p1   ; 
      noc__locl__cp_data        <= (reset_poweron ) ? 'd0 :   noc__locl__cp_data_p1   ; 

      noc__locl__dp_valid       <= (reset_poweron ) ? 'd0 :   noc__locl__dp_valid_p1  ; 
      noc__locl__dp_cntl        <= (reset_poweron ) ? 'd0 :   noc__locl__dp_cntl_p1   ; 
      noc__locl__dp_data        <= (reset_poweron ) ? 'd0 :   noc__locl__dp_data_p1   ; 


      case(nc_local_inq_cntl_state)

        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0:
          begin
            local_inq_priority_fromNoc  <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE  ]                          ; 
            local_inq_mgr_fromNoc       <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc_p1 ;   

            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId_p1   ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId_p1   ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE0:
          begin
            local_inq_type_fromNoc      <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc_p1  ;   

            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId        ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type_p1      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype_p1     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId        ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type_p1      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype_p1     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0:
          begin
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId        ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype_p1     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId        ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype_p1     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1:
          begin
            local_inq_priority_fromNoc  <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE  ]                          ; 
            local_inq_mgr_fromNoc       <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc_p1 ;   

            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId_p1   ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId_p1   ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE1:
          begin
            local_inq_type_fromNoc      <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc_p1  ;   

            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId        ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type_p1      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype_p1     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId        ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type_p1      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype_p1     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1:
          begin
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId        ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype_p1     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId        ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype_p1     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2:
          begin
            local_inq_priority_fromNoc  <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE  ]                          ; 
            local_inq_mgr_fromNoc       <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc_p1 ;   

            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId_p1   ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId_p1   ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE2:
          begin
            local_inq_type_fromNoc      <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc_p1  ;   

            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId        ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type_p1      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype_p1     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId        ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type_p1      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype_p1     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2:
          begin
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId        ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype_p1     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId        ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype_p1     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3:
          begin
            local_inq_priority_fromNoc  <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE  ]                          ; 
            local_inq_mgr_fromNoc       <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc_p1 ;   

            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId_p1   ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId_p1   ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE3:
          begin
            local_inq_type_fromNoc      <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc_p1  ;   

            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId        ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type_p1      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype_p1     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId        ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type_p1      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype_p1     ; 

          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3:
          begin
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId        ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type      ; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype_p1     ; 

            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId        ; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type      ; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype_p1     ; 

          end
        default:
          begin
            local_inq_type_fromNoc    <= (reset_poweron   ) ? 'd0 : local_inq_type_fromNoc  ;   

            noc__locl__cp_type        <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type      ; 
            noc__locl__cp_ptype       <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype     ; 
            noc__locl__cp_mgrId       <= (reset_poweron ) ? 'd0 :   noc__locl__cp_mgrId     ; 

            noc__locl__dp_type        <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type      ; 
            noc__locl__dp_ptype       <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype     ; 
            noc__locl__dp_mgrId       <= (reset_poweron ) ? 'd0 :   noc__locl__dp_mgrId     ; 

          end

      endcase
    end

  // Mask request from Port with this PE's mask address
  assign port0_localInqReq      = Port_from_NoC_Control[0].destinationReq & |(Port_from_NoC_Control[0].destinationReqAddr & thisMgrBitMask)  ;
  // Grab the priority during the request when the packer header is present at the fifo output
  always @(posedge clk)
    port0_localInqPriority <= (port0_localInqReq) ? Port_from_NoC_Control[0].destinationPriority : port0_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port0_OutqAck   <= port0_localInqReq ;  // feed request directly back to ack
  assign local_port0_OutqReady = ((port0_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP) ? locl__noc__cp_ready_d1 : locl__noc__dp_ready_d1 ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE0         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0) );
  // Mask request from Port with this PE's mask address
  assign port1_localInqReq      = Port_from_NoC_Control[1].destinationReq & |(Port_from_NoC_Control[1].destinationReqAddr & thisMgrBitMask)  ;
  // Grab the priority during the request when the packer header is present at the fifo output
  always @(posedge clk)
    port1_localInqPriority <= (port1_localInqReq) ? Port_from_NoC_Control[1].destinationPriority : port1_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port1_OutqAck   <= port1_localInqReq ;  // feed request directly back to ack
  assign local_port1_OutqReady = ((port1_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP) ? locl__noc__cp_ready_d1 : locl__noc__dp_ready_d1 ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE1         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1) );
  // Mask request from Port with this PE's mask address
  assign port2_localInqReq      = Port_from_NoC_Control[2].destinationReq & |(Port_from_NoC_Control[2].destinationReqAddr & thisMgrBitMask)  ;
  // Grab the priority during the request when the packer header is present at the fifo output
  always @(posedge clk)
    port2_localInqPriority <= (port2_localInqReq) ? Port_from_NoC_Control[2].destinationPriority : port2_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port2_OutqAck   <= port2_localInqReq ;  // feed request directly back to ack
  assign local_port2_OutqReady = ((port2_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP) ? locl__noc__cp_ready_d1 : locl__noc__dp_ready_d1 ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE2         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2) );
  // Mask request from Port with this PE's mask address
  assign port3_localInqReq      = Port_from_NoC_Control[3].destinationReq & |(Port_from_NoC_Control[3].destinationReqAddr & thisMgrBitMask)  ;
  // Grab the priority during the request when the packer header is present at the fifo output
  always @(posedge clk)
    port3_localInqPriority <= (port3_localInqReq) ? Port_from_NoC_Control[3].destinationPriority : port3_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port3_OutqAck   <= port3_localInqReq ;  // feed request directly back to ack
  assign local_port3_OutqReady = ((port3_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP) ? locl__noc__cp_ready_d1 : locl__noc__dp_ready_d1 ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE3         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3) );
  // Mux source packet into the to cntl fifo
  // Remember, the transferred packet includes the NoC header so the local contrller needs to drop the first transaction
  always @(*)
    begin
      noc__locl__cp_valid_p1                                                       = 'd0   ; 
      noc__locl__cp_cntl_p1                                                        = 'd0   ; 
      noc__locl__cp_type_p1                                                        = 'd0   ; 
      noc__locl__cp_ptype_p1                                                       = 'd0   ; 
      noc__locl__cp_data_p1                                                        = 'd0   ; 
      noc__locl__cp_mgrId_p1                                                         = 'd0   ; 

      noc__locl__dp_valid_p1                                                       = 'd0   ; 
      noc__locl__dp_cntl_p1                                                        = 'd0   ; 
      noc__locl__dp_type_p1                                                        = 'd0   ; 
      noc__locl__dp_ptype_p1                                                       = 'd0   ; 
      noc__locl__dp_data_p1                                                        = 'd0   ; 
      noc__locl__dp_mgrId_p1                                                         = 'd0   ; 
      
      local_inq_mgr_fromNoc_p1                                                     = 'd0   ; 
      local_inq_type_fromNoc_p1                                                    = 'd0   ; 
      local_inq_ptype_fromNoc_p1                                                   = 'd0   ; 
      
      case(nc_local_inq_cntl_state)

        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0:
          begin
            local_inq_mgr_fromNoc_p1                                                     = Port_from_NoC_Control[0].mgr_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port0_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[0].cntl_fromNoc                 ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[0].data_fromNoc                                  ; 
            noc__locl__cp_mgrId_p1                                                       = Port_from_NoC_Control[0].mgr_fromNoc                                                                                        ; 

            noc__locl__dp_valid_p1                                                       = (port0_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[0].cntl_fromNoc                 ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[0].data_fromNoc                                 ; 
            noc__locl__dp_mgrId_p1                                                       = Port_from_NoC_Control[0].mgr_fromNoc                                                                                        ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE0:
          begin
            local_inq_type_fromNoc_p1                                                    = Port_from_NoC_Control[0].type_fromNoc   ; 
            local_inq_ptype_fromNoc_p1                                                   = Port_from_NoC_Control[0].ptype_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port0_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[0].cntl_fromNoc                 ; 
            noc__locl__cp_type_p1                                                        = Port_from_NoC_Control[0].type_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[0].data_fromNoc                                  ; 

            noc__locl__dp_valid_p1                                                       = (port0_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[0].cntl_fromNoc                 ; 
            noc__locl__dp_type_p1                                                        = Port_from_NoC_Control[0].type_fromNoc                                                                                        ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[0].data_fromNoc                                 ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0:
          begin
            local_inq_ptype_fromNoc_p1                                                   = Port_from_NoC_Control[0].ptype_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port0_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[0].cntl_fromNoc                 ; 
            noc__locl__cp_ptype_p1                                                       = Port_from_NoC_Control[0].ptype_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[0].data_fromNoc                                  ; 

            noc__locl__dp_valid_p1                                                       = (port0_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[0].cntl_fromNoc                 ; 
            noc__locl__dp_ptype_p1                                                       = Port_from_NoC_Control[0].ptype_fromNoc                                                                                       ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[0].data_fromNoc                                 ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1:
          begin
            local_inq_mgr_fromNoc_p1                                                     = Port_from_NoC_Control[1].mgr_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port1_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[1].cntl_fromNoc                 ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[1].data_fromNoc                                  ; 
            noc__locl__cp_mgrId_p1                                                       = Port_from_NoC_Control[1].mgr_fromNoc                                                                                        ; 

            noc__locl__dp_valid_p1                                                       = (port1_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[1].cntl_fromNoc                 ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[1].data_fromNoc                                 ; 
            noc__locl__dp_mgrId_p1                                                       = Port_from_NoC_Control[1].mgr_fromNoc                                                                                        ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE1:
          begin
            local_inq_type_fromNoc_p1                                                    = Port_from_NoC_Control[1].type_fromNoc   ; 
            local_inq_ptype_fromNoc_p1                                                   = Port_from_NoC_Control[1].ptype_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port1_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[1].cntl_fromNoc                 ; 
            noc__locl__cp_type_p1                                                        = Port_from_NoC_Control[1].type_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[1].data_fromNoc                                  ; 

            noc__locl__dp_valid_p1                                                       = (port1_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[1].cntl_fromNoc                 ; 
            noc__locl__dp_type_p1                                                        = Port_from_NoC_Control[1].type_fromNoc                                                                                        ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[1].data_fromNoc                                 ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1:
          begin
            local_inq_ptype_fromNoc_p1                                                   = Port_from_NoC_Control[1].ptype_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port1_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[1].cntl_fromNoc                 ; 
            noc__locl__cp_ptype_p1                                                       = Port_from_NoC_Control[1].ptype_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[1].data_fromNoc                                  ; 

            noc__locl__dp_valid_p1                                                       = (port1_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[1].cntl_fromNoc                 ; 
            noc__locl__dp_ptype_p1                                                       = Port_from_NoC_Control[1].ptype_fromNoc                                                                                       ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[1].data_fromNoc                                 ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2:
          begin
            local_inq_mgr_fromNoc_p1                                                     = Port_from_NoC_Control[2].mgr_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port2_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[2].cntl_fromNoc                 ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[2].data_fromNoc                                  ; 
            noc__locl__cp_mgrId_p1                                                       = Port_from_NoC_Control[2].mgr_fromNoc                                                                                        ; 

            noc__locl__dp_valid_p1                                                       = (port2_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[2].cntl_fromNoc                 ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[2].data_fromNoc                                 ; 
            noc__locl__dp_mgrId_p1                                                       = Port_from_NoC_Control[2].mgr_fromNoc                                                                                        ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE2:
          begin
            local_inq_type_fromNoc_p1                                                    = Port_from_NoC_Control[2].type_fromNoc   ; 
            local_inq_ptype_fromNoc_p1                                                   = Port_from_NoC_Control[2].ptype_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port2_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[2].cntl_fromNoc                 ; 
            noc__locl__cp_type_p1                                                        = Port_from_NoC_Control[2].type_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[2].data_fromNoc                                  ; 

            noc__locl__dp_valid_p1                                                       = (port2_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[2].cntl_fromNoc                 ; 
            noc__locl__dp_type_p1                                                        = Port_from_NoC_Control[2].type_fromNoc                                                                                        ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[2].data_fromNoc                                 ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2:
          begin
            local_inq_ptype_fromNoc_p1                                                   = Port_from_NoC_Control[2].ptype_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port2_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[2].cntl_fromNoc                 ; 
            noc__locl__cp_ptype_p1                                                       = Port_from_NoC_Control[2].ptype_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[2].data_fromNoc                                  ; 

            noc__locl__dp_valid_p1                                                       = (port2_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[2].cntl_fromNoc                 ; 
            noc__locl__dp_ptype_p1                                                       = Port_from_NoC_Control[2].ptype_fromNoc                                                                                       ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[2].data_fromNoc                                 ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3:
          begin
            local_inq_mgr_fromNoc_p1                                                     = Port_from_NoC_Control[3].mgr_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port3_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[3].cntl_fromNoc                 ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[3].data_fromNoc                                  ; 
            noc__locl__cp_mgrId_p1                                                       = Port_from_NoC_Control[3].mgr_fromNoc                                                                                        ; 

            noc__locl__dp_valid_p1                                                       = (port3_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[3].cntl_fromNoc                 ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[3].data_fromNoc                                 ; 
            noc__locl__dp_mgrId_p1                                                       = Port_from_NoC_Control[3].mgr_fromNoc                                                                                        ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE3:
          begin
            local_inq_type_fromNoc_p1                                                    = Port_from_NoC_Control[3].type_fromNoc   ; 
            local_inq_ptype_fromNoc_p1                                                   = Port_from_NoC_Control[3].ptype_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port3_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[3].cntl_fromNoc                 ; 
            noc__locl__cp_type_p1                                                        = Port_from_NoC_Control[3].type_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[3].data_fromNoc                                  ; 

            noc__locl__dp_valid_p1                                                       = (port3_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[3].cntl_fromNoc                 ; 
            noc__locl__dp_type_p1                                                        = Port_from_NoC_Control[3].type_fromNoc                                                                                        ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[3].data_fromNoc                                 ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3:
          begin
            local_inq_ptype_fromNoc_p1                                                   = Port_from_NoC_Control[3].ptype_fromNoc   ; 

            noc__locl__cp_valid_p1                                                       = (port3_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP )   ; 
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC_Control[3].cntl_fromNoc                 ; 
            noc__locl__cp_ptype_p1                                                       = Port_from_NoC_Control[3].ptype_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1                                                        = Port_from_NoC_Control[3].data_fromNoc                                  ; 

            noc__locl__dp_valid_p1                                                       = (port3_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP )   ; 
            noc__locl__dp_cntl_p1                                                        = Port_from_NoC_Control[3].cntl_fromNoc                 ; 
            noc__locl__dp_ptype_p1                                                       = Port_from_NoC_Control[3].ptype_fromNoc                                                                                       ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC_Control[3].data_fromNoc                                 ; 
          end
        default:
          begin
            local_inq_mgr_fromNoc_p1                                                        = 'd0   ; 
            local_inq_type_fromNoc_p1                                                       = 'd0   ; 
            local_inq_ptype_fromNoc_p1                                                      = 'd0   ; 

            noc__locl__cp_valid_p1                                                       = 'd0   ; 
            noc__locl__cp_cntl_p1                                                        = 'd0   ; 
            noc__locl__cp_type_p1                                                        = 'd0   ; 
            noc__locl__cp_ptype_p1                                                       = 'd0   ; 
            noc__locl__cp_data_p1                                                        = 'd0   ; 

            noc__locl__dp_valid_p1                                                       = 'd0   ; 
            noc__locl__dp_cntl_p1                                                        = 'd0   ; 
            noc__locl__dp_type_p1                                                        = 'd0   ; 
            noc__locl__dp_ptype_p1                                                       = 'd0   ; 
            noc__locl__dp_data_p1                                                        = 'd0   ; 
          end

      endcase
    end
