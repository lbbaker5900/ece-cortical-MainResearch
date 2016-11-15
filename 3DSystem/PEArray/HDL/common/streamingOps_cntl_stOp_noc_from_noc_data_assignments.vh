
  always @(posedge clk)
    begin
      toStOpReady   <= 'b0;
      case(fromNocDataSelectedLane)
        'd0:
        begin
          toStOpReady <= lane0_toStOp_strm_ready ;
        end
        'd1:
        begin
          toStOpReady <= lane1_toStOp_strm_ready ;
        end
        'd2:
        begin
          toStOpReady <= lane2_toStOp_strm_ready ;
        end
        'd3:
        begin
          toStOpReady <= lane3_toStOp_strm_ready ;
        end
        'd4:
        begin
          toStOpReady <= lane4_toStOp_strm_ready ;
        end
        'd5:
        begin
          toStOpReady <= lane5_toStOp_strm_ready ;
        end
        'd6:
        begin
          toStOpReady <= lane6_toStOp_strm_ready ;
        end
        'd7:
        begin
          toStOpReady <= lane7_toStOp_strm_ready ;
        end
        'd8:
        begin
          toStOpReady <= lane8_toStOp_strm_ready ;
        end
        'd9:
        begin
          toStOpReady <= lane9_toStOp_strm_ready ;
        end
        'd10:
        begin
          toStOpReady <= lane10_toStOp_strm_ready ;
        end
        'd11:
        begin
          toStOpReady <= lane11_toStOp_strm_ready ;
        end
        'd12:
        begin
          toStOpReady <= lane12_toStOp_strm_ready ;
        end
        'd13:
        begin
          toStOpReady <= lane13_toStOp_strm_ready ;
        end
        'd14:
        begin
          toStOpReady <= lane14_toStOp_strm_ready ;
        end
        'd15:
        begin
          toStOpReady <= lane15_toStOp_strm_ready ;
        end
        'd16:
        begin
          toStOpReady <= lane16_toStOp_strm_ready ;
        end
        'd17:
        begin
          toStOpReady <= lane17_toStOp_strm_ready ;
        end
        'd18:
        begin
          toStOpReady <= lane18_toStOp_strm_ready ;
        end
        'd19:
        begin
          toStOpReady <= lane19_toStOp_strm_ready ;
        end
        'd20:
        begin
          toStOpReady <= lane20_toStOp_strm_ready ;
        end
        'd21:
        begin
          toStOpReady <= lane21_toStOp_strm_ready ;
        end
        'd22:
        begin
          toStOpReady <= lane22_toStOp_strm_ready ;
        end
        'd23:
        begin
          toStOpReady <= lane23_toStOp_strm_ready ;
        end
        'd24:
        begin
          toStOpReady <= lane24_toStOp_strm_ready ;
        end
        'd25:
        begin
          toStOpReady <= lane25_toStOp_strm_ready ;
        end
        'd26:
        begin
          toStOpReady <= lane26_toStOp_strm_ready ;
        end
        'd27:
        begin
          toStOpReady <= lane27_toStOp_strm_ready ;
        end
        'd28:
        begin
          toStOpReady <= lane28_toStOp_strm_ready ;
        end
        'd29:
        begin
          toStOpReady <= lane29_toStOp_strm_ready ;
        end
        'd30:
        begin
          toStOpReady <= lane30_toStOp_strm_ready ;
        end
        'd31:
        begin
          toStOpReady <= lane31_toStOp_strm_ready ;
        end
      endcase
    end

  always @(posedge clk)
    begin
          lane0_toStOp_strm_cntl           = 'd0;
          lane0_toStOp_strm_id             = 'd0;
          lane0_toStOp_strm_data           = 'd0;
          lane0_toStOp_strm_fifo_write     = 'd0;
          lane1_toStOp_strm_cntl           = 'd0;
          lane1_toStOp_strm_id             = 'd0;
          lane1_toStOp_strm_data           = 'd0;
          lane1_toStOp_strm_fifo_write     = 'd0;
          lane2_toStOp_strm_cntl           = 'd0;
          lane2_toStOp_strm_id             = 'd0;
          lane2_toStOp_strm_data           = 'd0;
          lane2_toStOp_strm_fifo_write     = 'd0;
          lane3_toStOp_strm_cntl           = 'd0;
          lane3_toStOp_strm_id             = 'd0;
          lane3_toStOp_strm_data           = 'd0;
          lane3_toStOp_strm_fifo_write     = 'd0;
          lane4_toStOp_strm_cntl           = 'd0;
          lane4_toStOp_strm_id             = 'd0;
          lane4_toStOp_strm_data           = 'd0;
          lane4_toStOp_strm_fifo_write     = 'd0;
          lane5_toStOp_strm_cntl           = 'd0;
          lane5_toStOp_strm_id             = 'd0;
          lane5_toStOp_strm_data           = 'd0;
          lane5_toStOp_strm_fifo_write     = 'd0;
          lane6_toStOp_strm_cntl           = 'd0;
          lane6_toStOp_strm_id             = 'd0;
          lane6_toStOp_strm_data           = 'd0;
          lane6_toStOp_strm_fifo_write     = 'd0;
          lane7_toStOp_strm_cntl           = 'd0;
          lane7_toStOp_strm_id             = 'd0;
          lane7_toStOp_strm_data           = 'd0;
          lane7_toStOp_strm_fifo_write     = 'd0;
          lane8_toStOp_strm_cntl           = 'd0;
          lane8_toStOp_strm_id             = 'd0;
          lane8_toStOp_strm_data           = 'd0;
          lane8_toStOp_strm_fifo_write     = 'd0;
          lane9_toStOp_strm_cntl           = 'd0;
          lane9_toStOp_strm_id             = 'd0;
          lane9_toStOp_strm_data           = 'd0;
          lane9_toStOp_strm_fifo_write     = 'd0;
          lane10_toStOp_strm_cntl           = 'd0;
          lane10_toStOp_strm_id             = 'd0;
          lane10_toStOp_strm_data           = 'd0;
          lane10_toStOp_strm_fifo_write     = 'd0;
          lane11_toStOp_strm_cntl           = 'd0;
          lane11_toStOp_strm_id             = 'd0;
          lane11_toStOp_strm_data           = 'd0;
          lane11_toStOp_strm_fifo_write     = 'd0;
          lane12_toStOp_strm_cntl           = 'd0;
          lane12_toStOp_strm_id             = 'd0;
          lane12_toStOp_strm_data           = 'd0;
          lane12_toStOp_strm_fifo_write     = 'd0;
          lane13_toStOp_strm_cntl           = 'd0;
          lane13_toStOp_strm_id             = 'd0;
          lane13_toStOp_strm_data           = 'd0;
          lane13_toStOp_strm_fifo_write     = 'd0;
          lane14_toStOp_strm_cntl           = 'd0;
          lane14_toStOp_strm_id             = 'd0;
          lane14_toStOp_strm_data           = 'd0;
          lane14_toStOp_strm_fifo_write     = 'd0;
          lane15_toStOp_strm_cntl           = 'd0;
          lane15_toStOp_strm_id             = 'd0;
          lane15_toStOp_strm_data           = 'd0;
          lane15_toStOp_strm_fifo_write     = 'd0;
          lane16_toStOp_strm_cntl           = 'd0;
          lane16_toStOp_strm_id             = 'd0;
          lane16_toStOp_strm_data           = 'd0;
          lane16_toStOp_strm_fifo_write     = 'd0;
          lane17_toStOp_strm_cntl           = 'd0;
          lane17_toStOp_strm_id             = 'd0;
          lane17_toStOp_strm_data           = 'd0;
          lane17_toStOp_strm_fifo_write     = 'd0;
          lane18_toStOp_strm_cntl           = 'd0;
          lane18_toStOp_strm_id             = 'd0;
          lane18_toStOp_strm_data           = 'd0;
          lane18_toStOp_strm_fifo_write     = 'd0;
          lane19_toStOp_strm_cntl           = 'd0;
          lane19_toStOp_strm_id             = 'd0;
          lane19_toStOp_strm_data           = 'd0;
          lane19_toStOp_strm_fifo_write     = 'd0;
          lane20_toStOp_strm_cntl           = 'd0;
          lane20_toStOp_strm_id             = 'd0;
          lane20_toStOp_strm_data           = 'd0;
          lane20_toStOp_strm_fifo_write     = 'd0;
          lane21_toStOp_strm_cntl           = 'd0;
          lane21_toStOp_strm_id             = 'd0;
          lane21_toStOp_strm_data           = 'd0;
          lane21_toStOp_strm_fifo_write     = 'd0;
          lane22_toStOp_strm_cntl           = 'd0;
          lane22_toStOp_strm_id             = 'd0;
          lane22_toStOp_strm_data           = 'd0;
          lane22_toStOp_strm_fifo_write     = 'd0;
          lane23_toStOp_strm_cntl           = 'd0;
          lane23_toStOp_strm_id             = 'd0;
          lane23_toStOp_strm_data           = 'd0;
          lane23_toStOp_strm_fifo_write     = 'd0;
          lane24_toStOp_strm_cntl           = 'd0;
          lane24_toStOp_strm_id             = 'd0;
          lane24_toStOp_strm_data           = 'd0;
          lane24_toStOp_strm_fifo_write     = 'd0;
          lane25_toStOp_strm_cntl           = 'd0;
          lane25_toStOp_strm_id             = 'd0;
          lane25_toStOp_strm_data           = 'd0;
          lane25_toStOp_strm_fifo_write     = 'd0;
          lane26_toStOp_strm_cntl           = 'd0;
          lane26_toStOp_strm_id             = 'd0;
          lane26_toStOp_strm_data           = 'd0;
          lane26_toStOp_strm_fifo_write     = 'd0;
          lane27_toStOp_strm_cntl           = 'd0;
          lane27_toStOp_strm_id             = 'd0;
          lane27_toStOp_strm_data           = 'd0;
          lane27_toStOp_strm_fifo_write     = 'd0;
          lane28_toStOp_strm_cntl           = 'd0;
          lane28_toStOp_strm_id             = 'd0;
          lane28_toStOp_strm_data           = 'd0;
          lane28_toStOp_strm_fifo_write     = 'd0;
          lane29_toStOp_strm_cntl           = 'd0;
          lane29_toStOp_strm_id             = 'd0;
          lane29_toStOp_strm_data           = 'd0;
          lane29_toStOp_strm_fifo_write     = 'd0;
          lane30_toStOp_strm_cntl           = 'd0;
          lane30_toStOp_strm_id             = 'd0;
          lane30_toStOp_strm_data           = 'd0;
          lane30_toStOp_strm_fifo_write     = 'd0;
          lane31_toStOp_strm_cntl           = 'd0;
          lane31_toStOp_strm_id             = 'd0;
          lane31_toStOp_strm_data           = 'd0;
          lane31_toStOp_strm_fifo_write     = 'd0;
      case(fromNocDataSelectedLane)
        'd0:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane0_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane0_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane0_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane0_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd1:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane1_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane1_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane1_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane1_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd2:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane2_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane2_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane2_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane2_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd3:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane3_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane3_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane3_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane3_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd4:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane4_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane4_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane4_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane4_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd5:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane5_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane5_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane5_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane5_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd6:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane6_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane6_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane6_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane6_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd7:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane7_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane7_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane7_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane7_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd8:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane8_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane8_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane8_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane8_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd9:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane9_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane9_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane9_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane9_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd10:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane10_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane10_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane10_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane10_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd11:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane11_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane11_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane11_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane11_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd12:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane12_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane12_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane12_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane12_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd13:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane13_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane13_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane13_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane13_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd14:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane14_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane14_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane14_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane14_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd15:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane15_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane15_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane15_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane15_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd16:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane16_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane16_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane16_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane16_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd17:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane17_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane17_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane17_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane17_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd18:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane18_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane18_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane18_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane18_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd19:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane19_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane19_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane19_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane19_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd20:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane20_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane20_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane20_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane20_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd21:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane21_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane21_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane21_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane21_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd22:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane22_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane22_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane22_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane22_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd23:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane23_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane23_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane23_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane23_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd24:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane24_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane24_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane24_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane24_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd25:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane25_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane25_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane25_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane25_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd26:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane26_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane26_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane26_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane26_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd27:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane27_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane27_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane27_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane27_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd28:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane28_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane28_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane28_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane28_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd29:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane29_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane29_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane29_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane29_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd30:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane30_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane30_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane30_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane30_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
        'd31:
        begin
          // there is only one data fifo from the NoC
          // We need to convert from a packet interface to a streaming interface by removing SOP/EOP and adding SOD/EOD
          // For multi-packet tarnsfers, we need to detect the packet type and add SOD and EOD appropriately
          lane31_toStOp_strm_cntl       = ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_SOD  : 
                                           ((fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                           ((fromNocDataPktType    == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD) && (from_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP    )) ?  `STREAMING_OP_CNTL_STRM_CNTL_EOD  : 
                                                                                                                                                                                                 `STREAMING_OP_CNTL_STRM_CNTL_DATA ; 
          lane31_toStOp_strm_id         = from_NoC_data_fifo[0].fifo_read_strmId  ;
          lane31_toStOp_strm_data       = from_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE] ;
          lane31_toStOp_strm_fifo_write = toStOpFifoWrite                         ;
        end
      endcase
    end
