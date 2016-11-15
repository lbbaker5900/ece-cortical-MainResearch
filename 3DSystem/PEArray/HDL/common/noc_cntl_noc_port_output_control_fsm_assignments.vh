
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

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL:
        begin
          local_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL:
        begin
          local_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT0:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT1:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = 1'b0  ;
        end

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
          src3_OutqReady   = 1'b0  ;
        end

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT2:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
          src3_OutqReady   = 1'b0  ;
        end

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
        end

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT3:
        begin
          local_OutqReady   = 1'b0  ;
          src0_OutqReady   = 1'b0  ;
          src1_OutqReady   = 1'b0  ;
          src2_OutqReady   = 1'b0  ;
          src3_OutqReady   = ~fifo_almost_full ; // only enable source if fifo is available ;
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

        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_LOCAL:
          begin
            fifo_write = local_toNoc_valid ;
            cntl  = local_cntl_toNoc  ;
            data  = local_data_toNoc  ;
          end
        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_LOCAL:
          begin
            fifo_write = local_toNoc_valid ;
            cntl  = local_cntl_toNoc  ;
            data  = local_data_toNoc  ;
          end
        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT0:
          begin
            fifo_write = src0_toNoc_valid ;
            cntl  = src0_cntl_toNoc  ;
            data  = src0_data_toNoc  ;
          end
        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT0:
          begin
            fifo_write = src0_toNoc_valid ;
            cntl  = src0_cntl_toNoc  ;
            data  = src0_data_toNoc  ;
          end
        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT1:
          begin
            fifo_write = src1_toNoc_valid ;
            cntl  = src1_cntl_toNoc  ;
            data  = src1_data_toNoc  ;
          end
        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT1:
          begin
            fifo_write = src1_toNoc_valid ;
            cntl  = src1_cntl_toNoc  ;
            data  = src1_data_toNoc  ;
          end
        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT2:
          begin
            fifo_write = src2_toNoc_valid ;
            cntl  = src2_cntl_toNoc  ;
            data  = src2_data_toNoc  ;
          end
        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT2:
          begin
            fifo_write = src2_toNoc_valid ;
            cntl  = src2_cntl_toNoc  ;
            data  = src2_data_toNoc  ;
          end
        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_TRANSFER_PORT3:
          begin
            fifo_write = src3_toNoc_valid ;
            cntl  = src3_cntl_toNoc  ;
            data  = src3_data_toNoc  ;
          end
        `NOC_CONT_NOC_PORT_OUTPUT_CNTL_ACK_PORT3:
          begin
            fifo_write = src3_toNoc_valid ;
            cntl  = src3_cntl_toNoc  ;
            data  = src3_data_toNoc  ;
          end
        default:
          begin
            fifo_write = 'd0 ;
            cntl  = 'd0 ;
            data  = 'd0 ;
          end

      endcase
    end
