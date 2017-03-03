
  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__rs0  ;
  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__rs1  ;

  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r128  [`PE_NUM_OF_EXEC_LANES ];
  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r129  [`PE_NUM_OF_EXEC_LANES ];
  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r130  [`PE_NUM_OF_EXEC_LANES ];
  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r131  [`PE_NUM_OF_EXEC_LANES ];
  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r132  [`PE_NUM_OF_EXEC_LANES ];
  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r133  [`PE_NUM_OF_EXEC_LANES ];
  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r134  [`PE_NUM_OF_EXEC_LANES ];
  wire [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r135  [`PE_NUM_OF_EXEC_LANES ];

  // create 16 sets of regs to latch the output of the configuration memory
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__rs0_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__rs1_e1  ;

  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r128_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r129_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r130_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r131_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r132_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r133_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r134_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  simd__cntl__lane_r135_e1  ;
