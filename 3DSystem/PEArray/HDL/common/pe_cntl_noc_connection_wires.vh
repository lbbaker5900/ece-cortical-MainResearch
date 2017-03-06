
   // Aggregate Control-Path (cp) to NoC 
   wire                                            noc__scntl__cp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] scntl__noc__cp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__cp_type       ; 
   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] scntl__noc__cp_data       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__cp_laneId     ; 
   wire                                            scntl__noc__cp_strmId     ; 
   wire                                            scntl__noc__cp_valid      ; 
   // Aggregate Data-Path (cp) from NoC 
   wire                                            scntl__noc__cp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__cp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__cp_type       ; 
   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] noc__scntl__cp_data       ; 
   wire [`PE_PE_ID_RANGE                         ] noc__scntl__cp_peId       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__cp_laneId     ; 
   wire                                            noc__scntl__cp_strmId     ; 
   wire                                            noc__scntl__cp_valid      ; 

   // Aggregate Data-Path (dp) to NoC 
   wire                                            noc__scntl__dp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] scntl__noc__dp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] scntl__noc__dp_type       ; 
   wire [`PE_PE_ID_RANGE                         ] scntl__noc__dp_peId       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] scntl__noc__dp_laneId     ; 
   wire                                            scntl__noc__dp_strmId     ; 
   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] scntl__noc__dp_data       ; 
   wire                                            scntl__noc__dp_valid      ; 
   // Aggregate Data-Path (dp) from NoC 
   wire                                            scntl__noc__dp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__scntl__dp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__scntl__dp_type       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__scntl__dp_laneId     ; 
   wire                                            noc__scntl__dp_strmId     ; 
   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] noc__scntl__dp_data       ; 
   wire                                            noc__scntl__dp_valid      ; 
