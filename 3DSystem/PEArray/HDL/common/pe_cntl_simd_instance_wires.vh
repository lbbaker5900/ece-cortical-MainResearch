
  // FIXME: Made reg's to fix check design, but can gbe wires with multicycle path
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs0  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs1  ;

  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r128  [`PE_NUM_OF_EXEC_LANES ];
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r129  [`PE_NUM_OF_EXEC_LANES ];
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r130  [`PE_NUM_OF_EXEC_LANES ];
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r131  [`PE_NUM_OF_EXEC_LANES ];
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r132  [`PE_NUM_OF_EXEC_LANES ];
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r133  [`PE_NUM_OF_EXEC_LANES ];
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r134  [`PE_NUM_OF_EXEC_LANES ];
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r135  [`PE_NUM_OF_EXEC_LANES ];

  // create 16 sets of regs to latch the output of the configuration memory
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs0_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs1_e1  ;

  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r128_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r129_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r130_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r131_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r132_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r133_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r134_e1  ;
  reg  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r135_e1  ;
