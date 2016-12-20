
   // Aggregate Control-Path (cp) to NoC 
   wire                                            noc__cntl__cp_ready      ; 
   reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] cntl__noc__cp_cntl       ; 
   reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__cp_type       ; 
   reg  [`PE_NOC_INTERNAL_DATA_RANGE             ] cntl__noc__cp_data       ; 
   reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__cp_laneId     ; 
   reg                                             cntl__noc__cp_strmId     ; 
   reg                                             cntl__noc__cp_valid      ; 
   reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] cntl__noc__cp_cntl_p1    ; 
   reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__cp_type_p1    ; 
   reg  [`PE_NOC_INTERNAL_DATA_RANGE             ] cntl__noc__cp_data_p1    ; 
   reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__cp_laneId_p1  ; 
   reg                                             cntl__noc__cp_strmId_p1  ; 
   // Aggregate Control-Path (cp) from NoC 
   reg                                             cntl__noc__cp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__cntl__cp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__cntl__cp_type       ; 
   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] noc__cntl__cp_data       ; 
   wire [`PE_PE_ID_RANGE                         ] noc__cntl__cp_peId       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__cntl__cp_laneId     ; 
   wire                                            noc__cntl__cp_strmId     ; 
   wire                                            noc__cntl__cp_valid      ; 

   // Aggregate Data-Path (dp) to NoC 
   wire                                            noc__cntl__dp_ready      ; 
   reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] cntl__noc__dp_cntl       ; 
   reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__dp_type       ; 
   reg  [`PE_PE_ID_RANGE                         ] cntl__noc__dp_peId       ; 
   reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__dp_laneId     ; 
   reg                                             cntl__noc__dp_strmId     ; 
   reg  [`STREAMING_OP_CNTL_DATA_RANGE           ] cntl__noc__dp_data       ; 
   reg                                             cntl__noc__dp_valid      ; 
   reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] cntl__noc__dp_cntl_p1    ; 
   reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__dp_type_p1    ; 
   reg  [`PE_PE_ID_RANGE                         ] cntl__noc__dp_peId_p1    ; 
   reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__dp_laneId_p1  ; 
   reg                                             cntl__noc__dp_strmId_p1  ; 
   reg  [`PE_NOC_INTERNAL_DATA_RANGE             ] cntl__noc__dp_data_p1    ; 
   // Aggregate Data-Path (dp) from NoC 
   reg                                             cntl__noc__dp_ready      ; 
   wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__cntl__dp_cntl       ; 
   wire [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__cntl__dp_type       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__cntl__dp_laneId     ; 
   wire                                            noc__cntl__dp_strmId     ; 
   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] noc__cntl__dp_data       ; 
   wire                                            noc__cntl__dp_valid      ; 
