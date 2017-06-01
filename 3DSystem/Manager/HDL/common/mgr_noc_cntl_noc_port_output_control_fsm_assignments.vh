
        // Note: Each output port interfaces to 3 other ports which are referred to as sources 1-3. These numbers do not correlate to
        // the 4 actual ports and are dependent on instance number
        // e.g. port 1 connects to 0,2,3 which correspond to numbers 1,2,3 in this logic

        // wrap the decoded request right back to the source. A packet will not be transferred until all outputs assert ready
  always @(posedge clk)
          local_OutqAck  <= local_OutqReq ;
  always @(posedge clk)
          src0_OutqAck   <= src0_OutqReq  ;
  always @(posedge clk)
          src1_OutqAck   <= src1_OutqReq  ;
  always @(posedge clk)
          src2_OutqAck   <= src2_OutqReq  ;
  always @(posedge clk)
          src3_OutqAck   <= src3_OutqReq  ;

  always @(*)
    begin
      case(nc_port_toNoc_state)

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL:
        begin
          local_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL:
        begin
          local_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL:
        begin
          local_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT0:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT1:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT2:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
          src3_OutqReady   = 1'b0  ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
        end

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT3:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = ~almost_full ; // only enable source if fifo is available ;
        end

        default:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

      endcase
    end

  // Mux the acknowledged source onto the output fifo inputs
  always @(*)
    begin
      case(nc_port_toNoc_state)

        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_LOCAL:
          begin
            write = local_toNoc_valid ;
            write_cntl  = local_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (local_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL:
          begin
            write = local_toNoc_valid ;
            write_cntl  = local_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL:
          begin
            write = local_toNoc_valid ;
            write_cntl  = local_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (local_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT0:
          begin
            write = src0_toNoc_valid ;
            write_cntl  = src0_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (src0_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (src0_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                             src0_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src0_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0:
          begin
            write = src0_toNoc_valid ;
            write_cntl  = src0_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = src0_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src0_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT0:
          begin
            write = src0_toNoc_valid ;
            write_cntl  = src0_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (src0_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (src0_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                             src0_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src0_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT1:
          begin
            write = src1_toNoc_valid ;
            write_cntl  = src1_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (src1_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (src1_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                             src1_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src1_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1:
          begin
            write = src1_toNoc_valid ;
            write_cntl  = src1_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = src1_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src1_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT1:
          begin
            write = src1_toNoc_valid ;
            write_cntl  = src1_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (src1_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (src1_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                             src1_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src1_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT2:
          begin
            write = src2_toNoc_valid ;
            write_cntl  = src2_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (src2_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (src2_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                             src2_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src2_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2:
          begin
            write = src2_toNoc_valid ;
            write_cntl  = src2_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = src2_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src2_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT2:
          begin
            write = src2_toNoc_valid ;
            write_cntl  = src2_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (src2_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (src2_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                             src2_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src2_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT_START_PORT3:
          begin
            write = src3_toNoc_valid ;
            write_cntl  = src3_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (src3_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (src3_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                             src3_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src3_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3:
          begin
            write = src3_toNoc_valid ;
            write_cntl  = src3_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = src3_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src3_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT3:
          begin
            write = src3_toNoc_valid ;
            write_cntl  = src3_cntl_toNoc  ;
            // mask of destination bits not associated with this port
            write_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] = (src3_cntl_toNoc == `COMMON_STD_INTF_CNTL_SOM) ? (src3_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE] & thisPort_destinationMask) :
                                                                                                                             src3_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]                             ;
            write_data[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE            ] = src3_data_toNoc[`MGR_NOC_CONT_EXTERNAL_NON_ADDRESS_RANGE];
          end
        default:
          begin
            write = 'd0 ;
            write_cntl  = 'd0 ;
            write_data  = 'd0 ;
          end

      endcase
    end
