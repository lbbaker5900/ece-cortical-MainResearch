
   // Aggregate Control-Path (cp) to NoC 
   wire                                            noc__cntl__cp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] cntl__noc__cp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__cp_type       ; 
   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] cntl__noc__cp_data       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__cp_laneId     ; 
   wire                                            cntl__noc__cp_strmId     ; 
   wire                                            cntl__noc__cp_valid      ; 
   // Aggregate Data-Path (cp) from NoC 
   wire                                            cntl__noc__cp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__cntl__cp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__cntl__cp_type       ; 
   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] noc__cntl__cp_data       ; 
   wire [`PE_PE_ID_RANGE                         ] noc__cntl__cp_peId       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__cntl__cp_laneId     ; 
   wire                                            noc__cntl__cp_strmId     ; 
   wire                                            noc__cntl__cp_valid      ; 

   // Aggregate Data-Path (dp) to NoC 
   wire                                            noc__cntl__dp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] cntl__noc__dp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__dp_type       ; 
   wire [`PE_PE_ID_RANGE                         ] cntl__noc__dp_peId       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__dp_laneId     ; 
   wire                                            cntl__noc__dp_strmId     ; 
   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] cntl__noc__dp_data       ; 
   wire                                            cntl__noc__dp_valid      ; 
   // Aggregate Data-Path (dp) from NoC 
   wire                                            cntl__noc__dp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__cntl__dp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__cntl__dp_type       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__cntl__dp_laneId     ; 
   wire                                            noc__cntl__dp_strmId     ; 
   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] noc__cntl__dp_data       ; 
   wire                                            noc__cntl__dp_valid      ; 
