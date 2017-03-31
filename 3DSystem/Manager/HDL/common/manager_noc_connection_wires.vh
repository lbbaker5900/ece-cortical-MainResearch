
   // Control-Path (cp) to NoC 
   wire                                            noc__rdp__cp_ready      ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ] rdp__noc__cp_cntl       ; 
   wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] rdp__noc__cp_type       ; 
   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] rdp__noc__cp_data       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] rdp__noc__cp_laneId     ; 
   wire                                            rdp__noc__cp_strmId     ; 
   wire                                            rdp__noc__cp_valid      ; 

   // Data-Path (dp) to NoC 
   wire                                            noc__rdp__dp_ready      ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ] rdp__noc__dp_cntl       ; 
   wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] rdp__noc__dp_type       ; 
   wire [`PE_PE_ID_RANGE                         ] rdp__noc__dp_peId       ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] rdp__noc__dp_laneId     ; 
   wire                                            rdp__noc__dp_strmId     ; 
   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] rdp__noc__dp_data       ; 
   wire                                            rdp__noc__dp_valid      ; 

   // Data-Path (cp) from NoC 
   wire                                            mcntl__noc__cp_ready    ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ] noc__mcntl__cp_cntl     ; 
   wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] noc__mcntl__cp_type     ; 
   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] noc__mcntl__cp_data     ; 
   wire [`PE_PE_ID_RANGE                         ] noc__mcntl__cp_peId     ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__mcntl__cp_laneId   ; 
   wire                                            noc__mcntl__cp_strmId   ; 
   wire                                            noc__mcntl__cp_valid    ; 

   // Data-Path (dp) from NoC 
   wire                                            mcntl__noc__dp_ready    ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ] noc__mcntl__dp_cntl     ; 
   wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE         ] noc__mcntl__dp_type     ; 
   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__mcntl__dp_laneId   ; 
   wire                                            noc__mcntl__dp_strmId   ; 
   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] noc__mcntl__dp_data     ; 
   wire                                            noc__mcntl__dp_valid    ; 
