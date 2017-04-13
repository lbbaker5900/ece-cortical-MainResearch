
  always @(posedge clk)
    begin
      
      noc__locl__cp_valid       <= (reset_poweron ) ? 'd0 :   noc__locl__cp_valid_p1  ; 
      noc__locl__cp_cntl        <= (reset_poweron ) ? 'd0 :   noc__locl__cp_cntl_p1   ; 
      noc__locl__cp_type        <= (reset_poweron ) ? 'd0 :   noc__locl__cp_type_p1   ; 
      noc__locl__cp_ptype       <= (reset_poweron ) ? 'd0 :   noc__locl__cp_ptype_p1  ; 
      noc__locl__cp_data        <= (reset_poweron ) ? 'd0 :   noc__locl__cp_data_p1   ; 

      noc__locl__dp_valid       <= (reset_poweron ) ? 'd0 :   noc__locl__dp_valid_p1  ; 
      noc__locl__dp_cntl        <= (reset_poweron ) ? 'd0 :   noc__locl__dp_cntl_p1   ; 
      noc__locl__dp_type        <= (reset_poweron ) ? 'd0 :   noc__locl__dp_type_p1   ; 
      noc__locl__dp_ptype       <= (reset_poweron ) ? 'd0 :   noc__locl__dp_ptype_p1  ; 
      noc__locl__dp_data        <= (reset_poweron ) ? 'd0 :   noc__locl__dp_data_p1   ; 
      
      case(nc_local_inq_cntl_state)

        `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0:
          begin
            noc__locl__cp_mgrId       <= (reset_poweron ) ? 'd0 : Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE       ]                                   ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP0:
          begin
            local_inq_type_fromNoc    <= (reset_poweron ) ? 'd0 : local_inq_type_fromNoc_p1 ;   
            //noc__locl__cp_laneId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; 
            //noc__locl__cp_strmId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; 
            //noc__locl__dp_laneId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; 
            //noc__locl__dp_strmId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1:
          begin
            noc__locl__cp_mgrId       <= (reset_poweron ) ? 'd0 : Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE       ]                                   ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP1:
          begin
            local_inq_type_fromNoc    <= (reset_poweron ) ? 'd0 : local_inq_type_fromNoc_p1 ;   
            //noc__locl__cp_laneId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; 
            //noc__locl__cp_strmId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; 
            //noc__locl__dp_laneId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; 
            //noc__locl__dp_strmId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2:
          begin
            noc__locl__cp_mgrId       <= (reset_poweron ) ? 'd0 : Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE       ]                                   ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP2:
          begin
            local_inq_type_fromNoc    <= (reset_poweron ) ? 'd0 : local_inq_type_fromNoc_p1 ;   
            //noc__locl__cp_laneId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; 
            //noc__locl__cp_strmId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; 
            //noc__locl__dp_laneId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; 
            //noc__locl__dp_strmId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3:
          begin
            noc__locl__cp_mgrId       <= (reset_poweron ) ? 'd0 : Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE       ]                                   ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP3:
          begin
            local_inq_type_fromNoc    <= (reset_poweron ) ? 'd0 : local_inq_type_fromNoc_p1 ;   
            //noc__locl__cp_laneId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; 
            //noc__locl__cp_strmId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; 
            //noc__locl__dp_laneId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE ]                                   ; 
            //noc__locl__dp_strmId      <= (reset_poweron ) ? 'd0 : Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE ]                                   ; 
          end
        default:
          begin
            local_inq_type_fromNoc    <= (reset_poweron   ) ? 'd0 : local_inq_type_fromNoc ;   
          end

      endcase
    end

  // Mask request from Port with this PE's mask address
  assign port0_localInqReq      = Port_from_NoC[0].destinationReq & |(Port_from_NoC[0].destinationReqAddr & thisMgrBitMask)  ;
  always @(posedge clk)
    port0_localInqPriority <= (port0_localInqReq) ? Port_from_NoC[0].destinationPriority : port0_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port0_OutqAck   <= port0_localInqReq ;  // feed request directly back to ack
  assign local_port0_OutqReady = ((port0_localInqPriority == `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP) ? locl__noc__cp_ready : locl__noc__dp_ready ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER0     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP0         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0) );
  // Mask request from Port with this PE's mask address
  assign port1_localInqReq      = Port_from_NoC[1].destinationReq & |(Port_from_NoC[1].destinationReqAddr & thisMgrBitMask)  ;
  always @(posedge clk)
    port1_localInqPriority <= (port1_localInqReq) ? Port_from_NoC[1].destinationPriority : port1_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port1_OutqAck   <= port1_localInqReq ;  // feed request directly back to ack
  assign local_port1_OutqReady = ((port1_localInqPriority == `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP) ? locl__noc__cp_ready : locl__noc__dp_ready ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER1     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP1         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1) );
  // Mask request from Port with this PE's mask address
  assign port2_localInqReq      = Port_from_NoC[2].destinationReq & |(Port_from_NoC[2].destinationReqAddr & thisMgrBitMask)  ;
  always @(posedge clk)
    port2_localInqPriority <= (port2_localInqReq) ? Port_from_NoC[2].destinationPriority : port2_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port2_OutqAck   <= port2_localInqReq ;  // feed request directly back to ack
  assign local_port2_OutqReady = ((port2_localInqPriority == `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP) ? locl__noc__cp_ready : locl__noc__dp_ready ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER2     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP2         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2) );
  // Mask request from Port with this PE's mask address
  assign port3_localInqReq      = Port_from_NoC[3].destinationReq & |(Port_from_NoC[3].destinationReqAddr & thisMgrBitMask)  ;
  always @(posedge clk)
    port3_localInqPriority <= (port3_localInqReq) ? Port_from_NoC[3].destinationPriority : port3_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port3_OutqAck   <= port3_localInqReq ;  // feed request directly back to ack
  assign local_port3_OutqReady = ((port3_localInqPriority == `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP) ? locl__noc__cp_ready : locl__noc__dp_ready ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_DROP_HEADER3     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP3         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3) );
  // Mux source packet into the to cntl fifo
  // Remember, the transferred packet includes the NoC header so the local contrller needs to drop the first transaction
  always @(*)
    begin
      noc__locl__cp_cntl_p1                                                        = 'd0   ; 
      noc__locl__cp_type_p1                                                        = 'd0   ; 
      noc__locl__cp_ptype_p1                                                       = 'd0   ; 
      noc__locl__cp_data_p1                                                        = 'd0   ; 
      noc__locl__cp_valid_p1                                                       = 'd0   ; 

      noc__locl__dp_cntl_p1                                                        = 'd0   ; 
      noc__locl__dp_type_p1                                                        = 'd0   ; 
      noc__locl__dp_ptype_p1                                                       = 'd0   ; 
      noc__locl__dp_data_p1                                                        = 'd0   ; 
      noc__locl__dp_valid_p1                                                       = 'd0   ; 
      
      local_inq_type_fromNoc_p1                                                    = 'd0   ; 
      
      case(nc_local_inq_cntl_state)

        `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP0:
          begin
            local_inq_type_fromNoc_p1                                                       = Port_from_NoC[0].type_fromNoc   ; 
      
            noc__locl__cp_cntl_p1                                                        = (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM) ? `COMMON_STD_INTF_CNTL_SOM_EOM             : 
                                                                                                                                                                     `COMMON_STD_INTF_CNTL_SOM                 ; 
            noc__locl__cp_type_p1                                                        = Port_from_NoC[0].type_fromNoc                                                                                        ; 
            noc__locl__cp_ptype_p1                                                       = Port_from_NoC[0].ptype_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE  ]  = Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_RANGE ]                                   ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE  ]  = Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_RANGE ]                                   ; 
            noc__locl__cp_valid_p1                                                       = (port0_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[0].fromNoc_valid ; 

            noc__locl__dp_cntl_p1                                                        = (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM) ? `COMMON_STD_INTF_CNTL_SOM_EOM             : 
                                                                                                                                                                     `COMMON_STD_INTF_CNTL_SOM                 ; 
            noc__locl__dp_type_p1                                                        = Port_from_NoC[0].type_fromNoc                                                                                        ; 
            noc__locl__dp_ptype_p1                                                       = Port_from_NoC[0].ptype_fromNoc                                                                                       ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; 
            noc__locl__dp_valid_p1                                                       = (port0_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[0].fromNoc_valid ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0:
          begin
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC[0].cntl_fromNoc                                    ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE  ]  = Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_RANGE ]                                   ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE  ]  = Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_RANGE ]                                   ; 
            noc__locl__cp_valid_p1                                                       = (port0_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[0].fromNoc_valid ; 
            noc__locl__cp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer 
            noc__locl__cp_ptype_p1                                                       = local_inq_ptype_fromNoc     ;  // maintain type value through packet transfer 

            noc__locl__dp_cntl_p1                                                        = Port_from_NoC[0].cntl_fromNoc                                    ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC[0].data_fromNoc[`MGR_NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; 
            noc__locl__dp_valid_p1                                                       = (port0_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[0].fromNoc_valid && (Port_from_NoC[0].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[0].fromNoc_valid ; 
            noc__locl__dp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer 
            noc__locl__dp_ptype_p1                                                       = local_inq_ptype_fromNoc     ;  // maintain type value through packet transfer 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP1:
          begin
            local_inq_type_fromNoc_p1                                                       = Port_from_NoC[1].type_fromNoc   ; 
      
            noc__locl__cp_cntl_p1                                                        = (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM) ? `COMMON_STD_INTF_CNTL_SOM_EOM             : 
                                                                                                                                                                     `COMMON_STD_INTF_CNTL_SOM                 ; 
            noc__locl__cp_type_p1                                                        = Port_from_NoC[1].type_fromNoc                                                                                        ; 
            noc__locl__cp_ptype_p1                                                       = Port_from_NoC[1].ptype_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE  ]  = Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_RANGE ]                                   ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE  ]  = Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_RANGE ]                                   ; 
            noc__locl__cp_valid_p1                                                       = (port1_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[1].fromNoc_valid ; 

            noc__locl__dp_cntl_p1                                                        = (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM) ? `COMMON_STD_INTF_CNTL_SOM_EOM             : 
                                                                                                                                                                     `COMMON_STD_INTF_CNTL_SOM                 ; 
            noc__locl__dp_type_p1                                                        = Port_from_NoC[1].type_fromNoc                                                                                        ; 
            noc__locl__dp_ptype_p1                                                       = Port_from_NoC[1].ptype_fromNoc                                                                                       ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; 
            noc__locl__dp_valid_p1                                                       = (port1_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[1].fromNoc_valid ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1:
          begin
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC[1].cntl_fromNoc                                    ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE  ]  = Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_RANGE ]                                   ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE  ]  = Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_RANGE ]                                   ; 
            noc__locl__cp_valid_p1                                                       = (port1_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[1].fromNoc_valid ; 
            noc__locl__cp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer 
            noc__locl__cp_ptype_p1                                                       = local_inq_ptype_fromNoc     ;  // maintain type value through packet transfer 

            noc__locl__dp_cntl_p1                                                        = Port_from_NoC[1].cntl_fromNoc                                    ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC[1].data_fromNoc[`MGR_NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; 
            noc__locl__dp_valid_p1                                                       = (port1_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[1].fromNoc_valid && (Port_from_NoC[1].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[1].fromNoc_valid ; 
            noc__locl__dp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer 
            noc__locl__dp_ptype_p1                                                       = local_inq_ptype_fromNoc     ;  // maintain type value through packet transfer 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP2:
          begin
            local_inq_type_fromNoc_p1                                                       = Port_from_NoC[2].type_fromNoc   ; 
      
            noc__locl__cp_cntl_p1                                                        = (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM) ? `COMMON_STD_INTF_CNTL_SOM_EOM             : 
                                                                                                                                                                     `COMMON_STD_INTF_CNTL_SOM                 ; 
            noc__locl__cp_type_p1                                                        = Port_from_NoC[2].type_fromNoc                                                                                        ; 
            noc__locl__cp_ptype_p1                                                       = Port_from_NoC[2].ptype_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE  ]  = Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_RANGE ]                                   ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE  ]  = Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_RANGE ]                                   ; 
            noc__locl__cp_valid_p1                                                       = (port2_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[2].fromNoc_valid ; 

            noc__locl__dp_cntl_p1                                                        = (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM) ? `COMMON_STD_INTF_CNTL_SOM_EOM             : 
                                                                                                                                                                     `COMMON_STD_INTF_CNTL_SOM                 ; 
            noc__locl__dp_type_p1                                                        = Port_from_NoC[2].type_fromNoc                                                                                        ; 
            noc__locl__dp_ptype_p1                                                       = Port_from_NoC[2].ptype_fromNoc                                                                                       ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; 
            noc__locl__dp_valid_p1                                                       = (port2_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[2].fromNoc_valid ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2:
          begin
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC[2].cntl_fromNoc                                    ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE  ]  = Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_RANGE ]                                   ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE  ]  = Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_RANGE ]                                   ; 
            noc__locl__cp_valid_p1                                                       = (port2_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[2].fromNoc_valid ; 
            noc__locl__cp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer 
            noc__locl__cp_ptype_p1                                                       = local_inq_ptype_fromNoc     ;  // maintain type value through packet transfer 

            noc__locl__dp_cntl_p1                                                        = Port_from_NoC[2].cntl_fromNoc                                    ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC[2].data_fromNoc[`MGR_NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; 
            noc__locl__dp_valid_p1                                                       = (port2_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[2].fromNoc_valid && (Port_from_NoC[2].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[2].fromNoc_valid ; 
            noc__locl__dp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer 
            noc__locl__dp_ptype_p1                                                       = local_inq_ptype_fromNoc     ;  // maintain type value through packet transfer 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_ADD_SOP3:
          begin
            local_inq_type_fromNoc_p1                                                       = Port_from_NoC[3].type_fromNoc   ; 
      
            noc__locl__cp_cntl_p1                                                        = (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM) ? `COMMON_STD_INTF_CNTL_SOM_EOM             : 
                                                                                                                                                                     `COMMON_STD_INTF_CNTL_SOM                 ; 
            noc__locl__cp_type_p1                                                        = Port_from_NoC[3].type_fromNoc                                                                                        ; 
            noc__locl__cp_ptype_p1                                                       = Port_from_NoC[3].ptype_fromNoc                                                                                        ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE  ]  = Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_RANGE ]                                   ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE  ]  = Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_RANGE ]                                   ; 
            noc__locl__cp_valid_p1                                                       = (port3_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[3].fromNoc_valid ; 

            noc__locl__dp_cntl_p1                                                        = (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_EOM) ? `COMMON_STD_INTF_CNTL_SOM_EOM             : 
                                                                                                                                                                     `COMMON_STD_INTF_CNTL_SOM                 ; 
            noc__locl__dp_type_p1                                                        = Port_from_NoC[3].type_fromNoc                                                                                        ; 
            noc__locl__dp_ptype_p1                                                       = Port_from_NoC[3].ptype_fromNoc                                                                                       ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; 
            noc__locl__dp_valid_p1                                                       = (port3_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[3].fromNoc_valid ; 
          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3:
          begin
            noc__locl__cp_cntl_p1                                                        = Port_from_NoC[3].cntl_fromNoc                                    ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE  ]  = Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_RANGE ]                                   ; 
            noc__locl__cp_data_p1[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE  ]  = Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_RANGE ]                                   ; 
            noc__locl__cp_valid_p1                                                       = (port3_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[3].fromNoc_valid ; 
            noc__locl__cp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer 
            noc__locl__cp_ptype_p1                                                       = local_inq_ptype_fromNoc     ;  // maintain type value through packet transfer 

            noc__locl__dp_cntl_p1                                                        = Port_from_NoC[3].cntl_fromNoc                                    ; 
            noc__locl__dp_data_p1                                                        = Port_from_NoC[3].data_fromNoc[`MGR_NOC_CONT_EXT_DATA_TO_INT_DATA_RANGE ]                                   ; 
            noc__locl__dp_valid_p1                                                       = (port3_localInqPriority != `MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP)                                       ? 'd0                           :
                                                                                              (Port_from_NoC[3].fromNoc_valid && (Port_from_NoC[3].cntl_fromNoc == `COMMON_STD_INTF_CNTL_SOM))  ? 'd0                           :  // packets from NoC always more than one transaction
                                                                                                                                                                                                             Port_from_NoC[3].fromNoc_valid ; 
            noc__locl__dp_type_p1                                                        = local_inq_type_fromNoc     ;  // maintain type value through packet transfer 
            noc__locl__dp_ptype_p1                                                       = local_inq_ptype_fromNoc     ;  // maintain type value through packet transfer 
          end
        default:
          begin
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
