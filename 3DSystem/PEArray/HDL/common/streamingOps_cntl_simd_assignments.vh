
  always @(posedge clk)
    begin
      rs0  <= (reset_poweron) ? 'd0 : simd__scntl__rs0 ;
      rs1  <= (reset_poweron) ? 'd0 : simd__scntl__rs1 ;
    end

// Lane 0                 
  always @(posedge clk)
    begin
      lane0_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [0] ;
      lane0_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [0] ;
      lane0_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [0] ;
      lane0_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [0] ;
      lane0_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [0] ;
      lane0_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [0] ;
      lane0_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [0] ;
      lane0_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [0] ;
    end

// Lane 1                 
  always @(posedge clk)
    begin
      lane1_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [1] ;
      lane1_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [1] ;
      lane1_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [1] ;
      lane1_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [1] ;
      lane1_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [1] ;
      lane1_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [1] ;
      lane1_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [1] ;
      lane1_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [1] ;
    end

// Lane 2                 
  always @(posedge clk)
    begin
      lane2_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [2] ;
      lane2_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [2] ;
      lane2_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [2] ;
      lane2_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [2] ;
      lane2_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [2] ;
      lane2_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [2] ;
      lane2_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [2] ;
      lane2_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [2] ;
    end

// Lane 3                 
  always @(posedge clk)
    begin
      lane3_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [3] ;
      lane3_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [3] ;
      lane3_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [3] ;
      lane3_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [3] ;
      lane3_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [3] ;
      lane3_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [3] ;
      lane3_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [3] ;
      lane3_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [3] ;
    end

// Lane 4                 
  always @(posedge clk)
    begin
      lane4_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [4] ;
      lane4_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [4] ;
      lane4_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [4] ;
      lane4_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [4] ;
      lane4_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [4] ;
      lane4_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [4] ;
      lane4_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [4] ;
      lane4_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [4] ;
    end

// Lane 5                 
  always @(posedge clk)
    begin
      lane5_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [5] ;
      lane5_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [5] ;
      lane5_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [5] ;
      lane5_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [5] ;
      lane5_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [5] ;
      lane5_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [5] ;
      lane5_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [5] ;
      lane5_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [5] ;
    end

// Lane 6                 
  always @(posedge clk)
    begin
      lane6_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [6] ;
      lane6_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [6] ;
      lane6_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [6] ;
      lane6_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [6] ;
      lane6_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [6] ;
      lane6_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [6] ;
      lane6_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [6] ;
      lane6_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [6] ;
    end

// Lane 7                 
  always @(posedge clk)
    begin
      lane7_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [7] ;
      lane7_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [7] ;
      lane7_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [7] ;
      lane7_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [7] ;
      lane7_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [7] ;
      lane7_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [7] ;
      lane7_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [7] ;
      lane7_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [7] ;
    end

// Lane 8                 
  always @(posedge clk)
    begin
      lane8_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [8] ;
      lane8_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [8] ;
      lane8_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [8] ;
      lane8_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [8] ;
      lane8_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [8] ;
      lane8_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [8] ;
      lane8_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [8] ;
      lane8_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [8] ;
    end

// Lane 9                 
  always @(posedge clk)
    begin
      lane9_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [9] ;
      lane9_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [9] ;
      lane9_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [9] ;
      lane9_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [9] ;
      lane9_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [9] ;
      lane9_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [9] ;
      lane9_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [9] ;
      lane9_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [9] ;
    end

// Lane 10                 
  always @(posedge clk)
    begin
      lane10_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [10] ;
      lane10_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [10] ;
      lane10_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [10] ;
      lane10_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [10] ;
      lane10_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [10] ;
      lane10_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [10] ;
      lane10_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [10] ;
      lane10_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [10] ;
    end

// Lane 11                 
  always @(posedge clk)
    begin
      lane11_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [11] ;
      lane11_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [11] ;
      lane11_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [11] ;
      lane11_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [11] ;
      lane11_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [11] ;
      lane11_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [11] ;
      lane11_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [11] ;
      lane11_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [11] ;
    end

// Lane 12                 
  always @(posedge clk)
    begin
      lane12_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [12] ;
      lane12_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [12] ;
      lane12_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [12] ;
      lane12_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [12] ;
      lane12_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [12] ;
      lane12_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [12] ;
      lane12_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [12] ;
      lane12_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [12] ;
    end

// Lane 13                 
  always @(posedge clk)
    begin
      lane13_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [13] ;
      lane13_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [13] ;
      lane13_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [13] ;
      lane13_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [13] ;
      lane13_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [13] ;
      lane13_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [13] ;
      lane13_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [13] ;
      lane13_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [13] ;
    end

// Lane 14                 
  always @(posedge clk)
    begin
      lane14_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [14] ;
      lane14_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [14] ;
      lane14_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [14] ;
      lane14_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [14] ;
      lane14_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [14] ;
      lane14_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [14] ;
      lane14_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [14] ;
      lane14_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [14] ;
    end

// Lane 15                 
  always @(posedge clk)
    begin
      lane15_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [15] ;
      lane15_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [15] ;
      lane15_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [15] ;
      lane15_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [15] ;
      lane15_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [15] ;
      lane15_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [15] ;
      lane15_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [15] ;
      lane15_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [15] ;
    end

// Lane 16                 
  always @(posedge clk)
    begin
      lane16_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [16] ;
      lane16_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [16] ;
      lane16_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [16] ;
      lane16_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [16] ;
      lane16_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [16] ;
      lane16_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [16] ;
      lane16_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [16] ;
      lane16_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [16] ;
    end

// Lane 17                 
  always @(posedge clk)
    begin
      lane17_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [17] ;
      lane17_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [17] ;
      lane17_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [17] ;
      lane17_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [17] ;
      lane17_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [17] ;
      lane17_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [17] ;
      lane17_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [17] ;
      lane17_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [17] ;
    end

// Lane 18                 
  always @(posedge clk)
    begin
      lane18_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [18] ;
      lane18_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [18] ;
      lane18_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [18] ;
      lane18_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [18] ;
      lane18_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [18] ;
      lane18_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [18] ;
      lane18_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [18] ;
      lane18_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [18] ;
    end

// Lane 19                 
  always @(posedge clk)
    begin
      lane19_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [19] ;
      lane19_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [19] ;
      lane19_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [19] ;
      lane19_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [19] ;
      lane19_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [19] ;
      lane19_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [19] ;
      lane19_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [19] ;
      lane19_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [19] ;
    end

// Lane 20                 
  always @(posedge clk)
    begin
      lane20_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [20] ;
      lane20_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [20] ;
      lane20_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [20] ;
      lane20_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [20] ;
      lane20_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [20] ;
      lane20_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [20] ;
      lane20_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [20] ;
      lane20_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [20] ;
    end

// Lane 21                 
  always @(posedge clk)
    begin
      lane21_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [21] ;
      lane21_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [21] ;
      lane21_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [21] ;
      lane21_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [21] ;
      lane21_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [21] ;
      lane21_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [21] ;
      lane21_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [21] ;
      lane21_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [21] ;
    end

// Lane 22                 
  always @(posedge clk)
    begin
      lane22_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [22] ;
      lane22_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [22] ;
      lane22_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [22] ;
      lane22_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [22] ;
      lane22_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [22] ;
      lane22_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [22] ;
      lane22_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [22] ;
      lane22_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [22] ;
    end

// Lane 23                 
  always @(posedge clk)
    begin
      lane23_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [23] ;
      lane23_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [23] ;
      lane23_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [23] ;
      lane23_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [23] ;
      lane23_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [23] ;
      lane23_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [23] ;
      lane23_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [23] ;
      lane23_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [23] ;
    end

// Lane 24                 
  always @(posedge clk)
    begin
      lane24_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [24] ;
      lane24_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [24] ;
      lane24_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [24] ;
      lane24_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [24] ;
      lane24_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [24] ;
      lane24_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [24] ;
      lane24_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [24] ;
      lane24_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [24] ;
    end

// Lane 25                 
  always @(posedge clk)
    begin
      lane25_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [25] ;
      lane25_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [25] ;
      lane25_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [25] ;
      lane25_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [25] ;
      lane25_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [25] ;
      lane25_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [25] ;
      lane25_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [25] ;
      lane25_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [25] ;
    end

// Lane 26                 
  always @(posedge clk)
    begin
      lane26_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [26] ;
      lane26_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [26] ;
      lane26_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [26] ;
      lane26_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [26] ;
      lane26_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [26] ;
      lane26_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [26] ;
      lane26_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [26] ;
      lane26_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [26] ;
    end

// Lane 27                 
  always @(posedge clk)
    begin
      lane27_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [27] ;
      lane27_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [27] ;
      lane27_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [27] ;
      lane27_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [27] ;
      lane27_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [27] ;
      lane27_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [27] ;
      lane27_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [27] ;
      lane27_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [27] ;
    end

// Lane 28                 
  always @(posedge clk)
    begin
      lane28_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [28] ;
      lane28_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [28] ;
      lane28_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [28] ;
      lane28_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [28] ;
      lane28_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [28] ;
      lane28_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [28] ;
      lane28_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [28] ;
      lane28_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [28] ;
    end

// Lane 29                 
  always @(posedge clk)
    begin
      lane29_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [29] ;
      lane29_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [29] ;
      lane29_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [29] ;
      lane29_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [29] ;
      lane29_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [29] ;
      lane29_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [29] ;
      lane29_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [29] ;
      lane29_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [29] ;
    end

// Lane 30                 
  always @(posedge clk)
    begin
      lane30_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [30] ;
      lane30_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [30] ;
      lane30_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [30] ;
      lane30_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [30] ;
      lane30_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [30] ;
      lane30_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [30] ;
      lane30_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [30] ;
      lane30_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [30] ;
    end

// Lane 31                 
  always @(posedge clk)
    begin
      lane31_r128  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r128 [31] ;
      lane31_r129  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r129 [31] ;
      lane31_r130  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r130 [31] ;
      lane31_r131  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r131 [31] ;
      lane31_r132  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r132 [31] ;
      lane31_r133  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r133 [31] ;
      lane31_r134  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r134 [31] ;
      lane31_r135  <=  (reset_poweron) ? 'd0 : simd__scntl__lane_r135 [31] ;
    end
