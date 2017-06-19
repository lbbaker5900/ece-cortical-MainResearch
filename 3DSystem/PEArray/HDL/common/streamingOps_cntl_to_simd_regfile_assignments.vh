
    always @(posedge clk)
      begin
       reg__sdp__lane0_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane0_ready  ;
       scntl__reg__lane0_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane0_valid    ;
       scntl__reg__lane0_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane0_cntl     ;
       scntl__reg__lane0_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane0_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane1_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane1_ready  ;
       scntl__reg__lane1_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane1_valid    ;
       scntl__reg__lane1_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane1_cntl     ;
       scntl__reg__lane1_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane1_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane2_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane2_ready  ;
       scntl__reg__lane2_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane2_valid    ;
       scntl__reg__lane2_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane2_cntl     ;
       scntl__reg__lane2_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane2_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane3_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane3_ready  ;
       scntl__reg__lane3_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane3_valid    ;
       scntl__reg__lane3_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane3_cntl     ;
       scntl__reg__lane3_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane3_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane4_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane4_ready  ;
       scntl__reg__lane4_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane4_valid    ;
       scntl__reg__lane4_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane4_cntl     ;
       scntl__reg__lane4_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane4_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane5_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane5_ready  ;
       scntl__reg__lane5_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane5_valid    ;
       scntl__reg__lane5_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane5_cntl     ;
       scntl__reg__lane5_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane5_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane6_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane6_ready  ;
       scntl__reg__lane6_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane6_valid    ;
       scntl__reg__lane6_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane6_cntl     ;
       scntl__reg__lane6_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane6_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane7_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane7_ready  ;
       scntl__reg__lane7_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane7_valid    ;
       scntl__reg__lane7_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane7_cntl     ;
       scntl__reg__lane7_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane7_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane8_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane8_ready  ;
       scntl__reg__lane8_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane8_valid    ;
       scntl__reg__lane8_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane8_cntl     ;
       scntl__reg__lane8_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane8_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane9_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane9_ready  ;
       scntl__reg__lane9_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane9_valid    ;
       scntl__reg__lane9_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane9_cntl     ;
       scntl__reg__lane9_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane9_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane10_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane10_ready  ;
       scntl__reg__lane10_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane10_valid    ;
       scntl__reg__lane10_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane10_cntl     ;
       scntl__reg__lane10_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane10_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane11_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane11_ready  ;
       scntl__reg__lane11_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane11_valid    ;
       scntl__reg__lane11_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane11_cntl     ;
       scntl__reg__lane11_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane11_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane12_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane12_ready  ;
       scntl__reg__lane12_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane12_valid    ;
       scntl__reg__lane12_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane12_cntl     ;
       scntl__reg__lane12_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane12_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane13_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane13_ready  ;
       scntl__reg__lane13_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane13_valid    ;
       scntl__reg__lane13_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane13_cntl     ;
       scntl__reg__lane13_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane13_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane14_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane14_ready  ;
       scntl__reg__lane14_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane14_valid    ;
       scntl__reg__lane14_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane14_cntl     ;
       scntl__reg__lane14_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane14_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane15_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane15_ready  ;
       scntl__reg__lane15_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane15_valid    ;
       scntl__reg__lane15_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane15_cntl     ;
       scntl__reg__lane15_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane15_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane16_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane16_ready  ;
       scntl__reg__lane16_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane16_valid    ;
       scntl__reg__lane16_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane16_cntl     ;
       scntl__reg__lane16_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane16_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane17_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane17_ready  ;
       scntl__reg__lane17_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane17_valid    ;
       scntl__reg__lane17_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane17_cntl     ;
       scntl__reg__lane17_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane17_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane18_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane18_ready  ;
       scntl__reg__lane18_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane18_valid    ;
       scntl__reg__lane18_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane18_cntl     ;
       scntl__reg__lane18_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane18_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane19_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane19_ready  ;
       scntl__reg__lane19_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane19_valid    ;
       scntl__reg__lane19_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane19_cntl     ;
       scntl__reg__lane19_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane19_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane20_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane20_ready  ;
       scntl__reg__lane20_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane20_valid    ;
       scntl__reg__lane20_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane20_cntl     ;
       scntl__reg__lane20_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane20_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane21_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane21_ready  ;
       scntl__reg__lane21_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane21_valid    ;
       scntl__reg__lane21_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane21_cntl     ;
       scntl__reg__lane21_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane21_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane22_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane22_ready  ;
       scntl__reg__lane22_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane22_valid    ;
       scntl__reg__lane22_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane22_cntl     ;
       scntl__reg__lane22_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane22_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane23_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane23_ready  ;
       scntl__reg__lane23_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane23_valid    ;
       scntl__reg__lane23_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane23_cntl     ;
       scntl__reg__lane23_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane23_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane24_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane24_ready  ;
       scntl__reg__lane24_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane24_valid    ;
       scntl__reg__lane24_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane24_cntl     ;
       scntl__reg__lane24_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane24_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane25_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane25_ready  ;
       scntl__reg__lane25_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane25_valid    ;
       scntl__reg__lane25_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane25_cntl     ;
       scntl__reg__lane25_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane25_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane26_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane26_ready  ;
       scntl__reg__lane26_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane26_valid    ;
       scntl__reg__lane26_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane26_cntl     ;
       scntl__reg__lane26_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane26_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane27_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane27_ready  ;
       scntl__reg__lane27_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane27_valid    ;
       scntl__reg__lane27_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane27_cntl     ;
       scntl__reg__lane27_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane27_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane28_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane28_ready  ;
       scntl__reg__lane28_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane28_valid    ;
       scntl__reg__lane28_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane28_cntl     ;
       scntl__reg__lane28_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane28_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane29_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane29_ready  ;
       scntl__reg__lane29_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane29_valid    ;
       scntl__reg__lane29_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane29_cntl     ;
       scntl__reg__lane29_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane29_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane30_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane30_ready  ;
       scntl__reg__lane30_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane30_valid    ;
       scntl__reg__lane30_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane30_cntl     ;
       scntl__reg__lane30_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane30_data     ;
      end

    always @(posedge clk)
      begin
       reg__sdp__lane31_ready    <= ( reset_poweron ) ? 'd0 :  reg__scntl__lane31_ready  ;
       scntl__reg__lane31_valid  <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane31_valid    ;
       scntl__reg__lane31_cntl   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane31_cntl     ;
       scntl__reg__lane31_data   <= ( reset_poweron ) ? 'd0 :  sdp__reg__lane31_data     ;
      end

