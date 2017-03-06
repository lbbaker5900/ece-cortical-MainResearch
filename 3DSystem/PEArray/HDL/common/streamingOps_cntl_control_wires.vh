
  wire                                         scntl__sdp__lane0_strm0_read_enable         ;
  wire                                         scntl__sdp__lane0_strm0_write_enable        ;
  wire                                         sdp__scntl__lane0_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane0_strm0_write_ready         ;
  wire                                         sdp__scntl__lane0_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane0_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane0_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane0_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane0_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane0_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane0_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane0_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane0_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane0_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane0_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane0_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane0_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane0_strm1_read_enable         ;
  wire                                         scntl__sdp__lane0_strm1_write_enable        ;
  wire                                         sdp__scntl__lane0_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane0_strm1_write_ready         ;
  wire                                         sdp__scntl__lane0_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane0_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane0_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane0_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane0_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane0_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane0_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane0_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane0_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane0_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane0_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane0_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane0_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane1_strm0_read_enable         ;
  wire                                         scntl__sdp__lane1_strm0_write_enable        ;
  wire                                         sdp__scntl__lane1_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane1_strm0_write_ready         ;
  wire                                         sdp__scntl__lane1_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane1_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane1_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane1_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane1_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane1_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane1_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane1_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane1_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane1_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane1_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane1_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane1_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane1_strm1_read_enable         ;
  wire                                         scntl__sdp__lane1_strm1_write_enable        ;
  wire                                         sdp__scntl__lane1_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane1_strm1_write_ready         ;
  wire                                         sdp__scntl__lane1_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane1_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane1_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane1_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane1_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane1_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane1_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane1_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane1_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane1_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane1_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane1_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane1_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane2_strm0_read_enable         ;
  wire                                         scntl__sdp__lane2_strm0_write_enable        ;
  wire                                         sdp__scntl__lane2_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane2_strm0_write_ready         ;
  wire                                         sdp__scntl__lane2_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane2_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane2_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane2_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane2_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane2_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane2_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane2_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane2_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane2_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane2_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane2_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane2_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane2_strm1_read_enable         ;
  wire                                         scntl__sdp__lane2_strm1_write_enable        ;
  wire                                         sdp__scntl__lane2_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane2_strm1_write_ready         ;
  wire                                         sdp__scntl__lane2_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane2_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane2_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane2_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane2_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane2_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane2_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane2_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane2_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane2_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane2_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane2_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane2_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane3_strm0_read_enable         ;
  wire                                         scntl__sdp__lane3_strm0_write_enable        ;
  wire                                         sdp__scntl__lane3_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane3_strm0_write_ready         ;
  wire                                         sdp__scntl__lane3_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane3_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane3_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane3_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane3_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane3_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane3_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane3_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane3_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane3_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane3_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane3_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane3_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane3_strm1_read_enable         ;
  wire                                         scntl__sdp__lane3_strm1_write_enable        ;
  wire                                         sdp__scntl__lane3_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane3_strm1_write_ready         ;
  wire                                         sdp__scntl__lane3_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane3_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane3_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane3_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane3_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane3_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane3_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane3_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane3_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane3_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane3_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane3_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane3_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane4_strm0_read_enable         ;
  wire                                         scntl__sdp__lane4_strm0_write_enable        ;
  wire                                         sdp__scntl__lane4_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane4_strm0_write_ready         ;
  wire                                         sdp__scntl__lane4_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane4_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane4_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane4_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane4_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane4_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane4_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane4_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane4_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane4_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane4_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane4_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane4_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane4_strm1_read_enable         ;
  wire                                         scntl__sdp__lane4_strm1_write_enable        ;
  wire                                         sdp__scntl__lane4_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane4_strm1_write_ready         ;
  wire                                         sdp__scntl__lane4_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane4_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane4_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane4_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane4_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane4_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane4_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane4_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane4_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane4_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane4_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane4_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane4_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane5_strm0_read_enable         ;
  wire                                         scntl__sdp__lane5_strm0_write_enable        ;
  wire                                         sdp__scntl__lane5_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane5_strm0_write_ready         ;
  wire                                         sdp__scntl__lane5_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane5_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane5_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane5_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane5_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane5_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane5_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane5_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane5_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane5_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane5_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane5_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane5_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane5_strm1_read_enable         ;
  wire                                         scntl__sdp__lane5_strm1_write_enable        ;
  wire                                         sdp__scntl__lane5_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane5_strm1_write_ready         ;
  wire                                         sdp__scntl__lane5_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane5_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane5_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane5_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane5_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane5_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane5_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane5_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane5_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane5_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane5_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane5_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane5_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane6_strm0_read_enable         ;
  wire                                         scntl__sdp__lane6_strm0_write_enable        ;
  wire                                         sdp__scntl__lane6_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane6_strm0_write_ready         ;
  wire                                         sdp__scntl__lane6_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane6_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane6_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane6_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane6_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane6_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane6_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane6_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane6_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane6_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane6_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane6_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane6_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane6_strm1_read_enable         ;
  wire                                         scntl__sdp__lane6_strm1_write_enable        ;
  wire                                         sdp__scntl__lane6_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane6_strm1_write_ready         ;
  wire                                         sdp__scntl__lane6_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane6_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane6_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane6_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane6_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane6_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane6_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane6_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane6_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane6_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane6_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane6_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane6_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane7_strm0_read_enable         ;
  wire                                         scntl__sdp__lane7_strm0_write_enable        ;
  wire                                         sdp__scntl__lane7_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane7_strm0_write_ready         ;
  wire                                         sdp__scntl__lane7_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane7_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane7_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane7_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane7_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane7_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane7_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane7_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane7_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane7_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane7_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane7_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane7_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane7_strm1_read_enable         ;
  wire                                         scntl__sdp__lane7_strm1_write_enable        ;
  wire                                         sdp__scntl__lane7_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane7_strm1_write_ready         ;
  wire                                         sdp__scntl__lane7_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane7_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane7_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane7_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane7_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane7_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane7_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane7_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane7_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane7_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane7_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane7_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane7_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane8_strm0_read_enable         ;
  wire                                         scntl__sdp__lane8_strm0_write_enable        ;
  wire                                         sdp__scntl__lane8_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane8_strm0_write_ready         ;
  wire                                         sdp__scntl__lane8_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane8_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane8_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane8_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane8_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane8_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane8_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane8_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane8_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane8_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane8_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane8_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane8_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane8_strm1_read_enable         ;
  wire                                         scntl__sdp__lane8_strm1_write_enable        ;
  wire                                         sdp__scntl__lane8_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane8_strm1_write_ready         ;
  wire                                         sdp__scntl__lane8_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane8_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane8_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane8_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane8_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane8_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane8_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane8_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane8_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane8_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane8_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane8_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane8_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane9_strm0_read_enable         ;
  wire                                         scntl__sdp__lane9_strm0_write_enable        ;
  wire                                         sdp__scntl__lane9_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane9_strm0_write_ready         ;
  wire                                         sdp__scntl__lane9_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane9_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane9_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane9_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane9_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane9_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane9_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane9_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane9_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane9_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane9_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane9_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane9_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane9_strm1_read_enable         ;
  wire                                         scntl__sdp__lane9_strm1_write_enable        ;
  wire                                         sdp__scntl__lane9_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane9_strm1_write_ready         ;
  wire                                         sdp__scntl__lane9_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane9_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane9_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane9_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane9_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane9_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane9_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane9_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane9_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane9_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane9_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane9_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane9_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane10_strm0_read_enable         ;
  wire                                         scntl__sdp__lane10_strm0_write_enable        ;
  wire                                         sdp__scntl__lane10_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane10_strm0_write_ready         ;
  wire                                         sdp__scntl__lane10_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane10_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane10_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane10_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane10_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane10_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane10_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane10_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane10_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane10_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane10_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane10_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane10_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane10_strm1_read_enable         ;
  wire                                         scntl__sdp__lane10_strm1_write_enable        ;
  wire                                         sdp__scntl__lane10_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane10_strm1_write_ready         ;
  wire                                         sdp__scntl__lane10_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane10_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane10_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane10_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane10_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane10_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane10_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane10_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane10_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane10_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane10_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane10_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane10_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane11_strm0_read_enable         ;
  wire                                         scntl__sdp__lane11_strm0_write_enable        ;
  wire                                         sdp__scntl__lane11_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane11_strm0_write_ready         ;
  wire                                         sdp__scntl__lane11_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane11_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane11_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane11_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane11_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane11_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane11_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane11_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane11_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane11_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane11_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane11_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane11_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane11_strm1_read_enable         ;
  wire                                         scntl__sdp__lane11_strm1_write_enable        ;
  wire                                         sdp__scntl__lane11_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane11_strm1_write_ready         ;
  wire                                         sdp__scntl__lane11_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane11_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane11_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane11_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane11_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane11_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane11_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane11_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane11_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane11_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane11_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane11_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane11_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane12_strm0_read_enable         ;
  wire                                         scntl__sdp__lane12_strm0_write_enable        ;
  wire                                         sdp__scntl__lane12_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane12_strm0_write_ready         ;
  wire                                         sdp__scntl__lane12_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane12_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane12_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane12_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane12_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane12_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane12_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane12_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane12_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane12_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane12_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane12_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane12_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane12_strm1_read_enable         ;
  wire                                         scntl__sdp__lane12_strm1_write_enable        ;
  wire                                         sdp__scntl__lane12_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane12_strm1_write_ready         ;
  wire                                         sdp__scntl__lane12_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane12_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane12_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane12_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane12_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane12_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane12_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane12_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane12_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane12_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane12_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane12_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane12_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane13_strm0_read_enable         ;
  wire                                         scntl__sdp__lane13_strm0_write_enable        ;
  wire                                         sdp__scntl__lane13_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane13_strm0_write_ready         ;
  wire                                         sdp__scntl__lane13_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane13_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane13_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane13_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane13_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane13_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane13_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane13_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane13_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane13_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane13_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane13_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane13_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane13_strm1_read_enable         ;
  wire                                         scntl__sdp__lane13_strm1_write_enable        ;
  wire                                         sdp__scntl__lane13_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane13_strm1_write_ready         ;
  wire                                         sdp__scntl__lane13_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane13_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane13_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane13_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane13_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane13_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane13_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane13_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane13_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane13_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane13_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane13_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane13_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane14_strm0_read_enable         ;
  wire                                         scntl__sdp__lane14_strm0_write_enable        ;
  wire                                         sdp__scntl__lane14_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane14_strm0_write_ready         ;
  wire                                         sdp__scntl__lane14_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane14_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane14_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane14_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane14_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane14_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane14_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane14_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane14_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane14_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane14_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane14_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane14_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane14_strm1_read_enable         ;
  wire                                         scntl__sdp__lane14_strm1_write_enable        ;
  wire                                         sdp__scntl__lane14_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane14_strm1_write_ready         ;
  wire                                         sdp__scntl__lane14_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane14_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane14_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane14_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane14_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane14_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane14_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane14_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane14_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane14_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane14_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane14_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane14_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane15_strm0_read_enable         ;
  wire                                         scntl__sdp__lane15_strm0_write_enable        ;
  wire                                         sdp__scntl__lane15_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane15_strm0_write_ready         ;
  wire                                         sdp__scntl__lane15_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane15_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane15_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane15_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane15_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane15_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane15_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane15_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane15_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane15_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane15_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane15_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane15_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane15_strm1_read_enable         ;
  wire                                         scntl__sdp__lane15_strm1_write_enable        ;
  wire                                         sdp__scntl__lane15_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane15_strm1_write_ready         ;
  wire                                         sdp__scntl__lane15_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane15_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane15_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane15_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane15_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane15_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane15_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane15_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane15_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane15_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane15_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane15_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane15_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane16_strm0_read_enable         ;
  wire                                         scntl__sdp__lane16_strm0_write_enable        ;
  wire                                         sdp__scntl__lane16_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane16_strm0_write_ready         ;
  wire                                         sdp__scntl__lane16_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane16_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane16_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane16_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane16_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane16_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane16_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane16_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane16_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane16_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane16_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane16_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane16_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane16_strm1_read_enable         ;
  wire                                         scntl__sdp__lane16_strm1_write_enable        ;
  wire                                         sdp__scntl__lane16_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane16_strm1_write_ready         ;
  wire                                         sdp__scntl__lane16_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane16_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane16_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane16_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane16_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane16_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane16_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane16_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane16_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane16_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane16_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane16_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane16_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane17_strm0_read_enable         ;
  wire                                         scntl__sdp__lane17_strm0_write_enable        ;
  wire                                         sdp__scntl__lane17_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane17_strm0_write_ready         ;
  wire                                         sdp__scntl__lane17_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane17_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane17_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane17_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane17_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane17_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane17_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane17_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane17_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane17_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane17_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane17_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane17_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane17_strm1_read_enable         ;
  wire                                         scntl__sdp__lane17_strm1_write_enable        ;
  wire                                         sdp__scntl__lane17_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane17_strm1_write_ready         ;
  wire                                         sdp__scntl__lane17_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane17_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane17_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane17_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane17_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane17_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane17_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane17_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane17_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane17_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane17_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane17_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane17_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane18_strm0_read_enable         ;
  wire                                         scntl__sdp__lane18_strm0_write_enable        ;
  wire                                         sdp__scntl__lane18_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane18_strm0_write_ready         ;
  wire                                         sdp__scntl__lane18_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane18_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane18_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane18_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane18_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane18_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane18_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane18_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane18_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane18_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane18_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane18_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane18_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane18_strm1_read_enable         ;
  wire                                         scntl__sdp__lane18_strm1_write_enable        ;
  wire                                         sdp__scntl__lane18_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane18_strm1_write_ready         ;
  wire                                         sdp__scntl__lane18_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane18_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane18_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane18_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane18_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane18_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane18_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane18_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane18_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane18_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane18_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane18_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane18_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane19_strm0_read_enable         ;
  wire                                         scntl__sdp__lane19_strm0_write_enable        ;
  wire                                         sdp__scntl__lane19_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane19_strm0_write_ready         ;
  wire                                         sdp__scntl__lane19_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane19_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane19_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane19_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane19_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane19_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane19_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane19_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane19_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane19_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane19_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane19_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane19_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane19_strm1_read_enable         ;
  wire                                         scntl__sdp__lane19_strm1_write_enable        ;
  wire                                         sdp__scntl__lane19_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane19_strm1_write_ready         ;
  wire                                         sdp__scntl__lane19_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane19_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane19_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane19_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane19_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane19_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane19_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane19_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane19_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane19_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane19_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane19_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane19_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane20_strm0_read_enable         ;
  wire                                         scntl__sdp__lane20_strm0_write_enable        ;
  wire                                         sdp__scntl__lane20_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane20_strm0_write_ready         ;
  wire                                         sdp__scntl__lane20_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane20_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane20_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane20_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane20_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane20_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane20_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane20_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane20_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane20_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane20_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane20_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane20_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane20_strm1_read_enable         ;
  wire                                         scntl__sdp__lane20_strm1_write_enable        ;
  wire                                         sdp__scntl__lane20_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane20_strm1_write_ready         ;
  wire                                         sdp__scntl__lane20_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane20_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane20_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane20_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane20_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane20_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane20_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane20_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane20_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane20_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane20_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane20_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane20_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane21_strm0_read_enable         ;
  wire                                         scntl__sdp__lane21_strm0_write_enable        ;
  wire                                         sdp__scntl__lane21_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane21_strm0_write_ready         ;
  wire                                         sdp__scntl__lane21_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane21_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane21_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane21_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane21_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane21_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane21_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane21_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane21_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane21_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane21_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane21_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane21_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane21_strm1_read_enable         ;
  wire                                         scntl__sdp__lane21_strm1_write_enable        ;
  wire                                         sdp__scntl__lane21_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane21_strm1_write_ready         ;
  wire                                         sdp__scntl__lane21_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane21_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane21_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane21_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane21_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane21_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane21_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane21_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane21_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane21_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane21_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane21_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane21_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane22_strm0_read_enable         ;
  wire                                         scntl__sdp__lane22_strm0_write_enable        ;
  wire                                         sdp__scntl__lane22_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane22_strm0_write_ready         ;
  wire                                         sdp__scntl__lane22_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane22_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane22_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane22_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane22_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane22_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane22_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane22_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane22_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane22_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane22_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane22_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane22_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane22_strm1_read_enable         ;
  wire                                         scntl__sdp__lane22_strm1_write_enable        ;
  wire                                         sdp__scntl__lane22_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane22_strm1_write_ready         ;
  wire                                         sdp__scntl__lane22_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane22_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane22_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane22_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane22_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane22_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane22_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane22_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane22_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane22_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane22_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane22_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane22_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane23_strm0_read_enable         ;
  wire                                         scntl__sdp__lane23_strm0_write_enable        ;
  wire                                         sdp__scntl__lane23_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane23_strm0_write_ready         ;
  wire                                         sdp__scntl__lane23_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane23_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane23_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane23_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane23_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane23_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane23_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane23_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane23_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane23_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane23_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane23_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane23_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane23_strm1_read_enable         ;
  wire                                         scntl__sdp__lane23_strm1_write_enable        ;
  wire                                         sdp__scntl__lane23_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane23_strm1_write_ready         ;
  wire                                         sdp__scntl__lane23_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane23_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane23_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane23_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane23_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane23_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane23_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane23_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane23_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane23_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane23_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane23_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane23_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane24_strm0_read_enable         ;
  wire                                         scntl__sdp__lane24_strm0_write_enable        ;
  wire                                         sdp__scntl__lane24_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane24_strm0_write_ready         ;
  wire                                         sdp__scntl__lane24_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane24_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane24_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane24_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane24_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane24_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane24_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane24_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane24_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane24_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane24_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane24_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane24_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane24_strm1_read_enable         ;
  wire                                         scntl__sdp__lane24_strm1_write_enable        ;
  wire                                         sdp__scntl__lane24_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane24_strm1_write_ready         ;
  wire                                         sdp__scntl__lane24_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane24_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane24_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane24_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane24_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane24_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane24_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane24_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane24_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane24_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane24_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane24_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane24_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane25_strm0_read_enable         ;
  wire                                         scntl__sdp__lane25_strm0_write_enable        ;
  wire                                         sdp__scntl__lane25_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane25_strm0_write_ready         ;
  wire                                         sdp__scntl__lane25_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane25_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane25_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane25_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane25_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane25_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane25_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane25_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane25_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane25_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane25_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane25_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane25_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane25_strm1_read_enable         ;
  wire                                         scntl__sdp__lane25_strm1_write_enable        ;
  wire                                         sdp__scntl__lane25_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane25_strm1_write_ready         ;
  wire                                         sdp__scntl__lane25_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane25_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane25_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane25_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane25_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane25_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane25_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane25_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane25_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane25_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane25_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane25_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane25_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane26_strm0_read_enable         ;
  wire                                         scntl__sdp__lane26_strm0_write_enable        ;
  wire                                         sdp__scntl__lane26_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane26_strm0_write_ready         ;
  wire                                         sdp__scntl__lane26_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane26_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane26_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane26_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane26_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane26_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane26_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane26_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane26_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane26_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane26_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane26_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane26_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane26_strm1_read_enable         ;
  wire                                         scntl__sdp__lane26_strm1_write_enable        ;
  wire                                         sdp__scntl__lane26_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane26_strm1_write_ready         ;
  wire                                         sdp__scntl__lane26_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane26_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane26_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane26_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane26_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane26_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane26_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane26_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane26_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane26_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane26_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane26_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane26_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane27_strm0_read_enable         ;
  wire                                         scntl__sdp__lane27_strm0_write_enable        ;
  wire                                         sdp__scntl__lane27_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane27_strm0_write_ready         ;
  wire                                         sdp__scntl__lane27_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane27_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane27_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane27_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane27_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane27_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane27_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane27_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane27_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane27_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane27_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane27_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane27_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane27_strm1_read_enable         ;
  wire                                         scntl__sdp__lane27_strm1_write_enable        ;
  wire                                         sdp__scntl__lane27_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane27_strm1_write_ready         ;
  wire                                         sdp__scntl__lane27_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane27_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane27_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane27_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane27_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane27_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane27_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane27_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane27_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane27_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane27_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane27_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane27_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane28_strm0_read_enable         ;
  wire                                         scntl__sdp__lane28_strm0_write_enable        ;
  wire                                         sdp__scntl__lane28_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane28_strm0_write_ready         ;
  wire                                         sdp__scntl__lane28_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane28_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane28_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane28_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane28_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane28_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane28_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane28_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane28_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane28_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane28_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane28_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane28_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane28_strm1_read_enable         ;
  wire                                         scntl__sdp__lane28_strm1_write_enable        ;
  wire                                         sdp__scntl__lane28_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane28_strm1_write_ready         ;
  wire                                         sdp__scntl__lane28_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane28_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane28_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane28_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane28_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane28_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane28_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane28_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane28_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane28_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane28_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane28_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane28_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane29_strm0_read_enable         ;
  wire                                         scntl__sdp__lane29_strm0_write_enable        ;
  wire                                         sdp__scntl__lane29_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane29_strm0_write_ready         ;
  wire                                         sdp__scntl__lane29_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane29_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane29_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane29_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane29_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane29_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane29_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane29_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane29_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane29_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane29_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane29_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane29_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane29_strm1_read_enable         ;
  wire                                         scntl__sdp__lane29_strm1_write_enable        ;
  wire                                         sdp__scntl__lane29_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane29_strm1_write_ready         ;
  wire                                         sdp__scntl__lane29_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane29_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane29_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane29_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane29_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane29_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane29_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane29_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane29_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane29_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane29_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane29_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane29_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane30_strm0_read_enable         ;
  wire                                         scntl__sdp__lane30_strm0_write_enable        ;
  wire                                         sdp__scntl__lane30_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane30_strm0_write_ready         ;
  wire                                         sdp__scntl__lane30_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane30_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane30_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane30_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane30_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane30_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane30_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane30_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane30_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane30_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane30_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane30_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane30_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane30_strm1_read_enable         ;
  wire                                         scntl__sdp__lane30_strm1_write_enable        ;
  wire                                         sdp__scntl__lane30_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane30_strm1_write_ready         ;
  wire                                         sdp__scntl__lane30_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane30_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane30_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane30_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane30_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane30_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane30_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane30_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane30_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane30_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane30_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane30_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane30_strm1_stOp_destination ;                      
  wire                                         scntl__sdp__lane31_strm0_read_enable         ;
  wire                                         scntl__sdp__lane31_strm0_write_enable        ;
  wire                                         sdp__scntl__lane31_strm0_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane31_strm0_write_ready         ;
  wire                                         sdp__scntl__lane31_strm0_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane31_strm0_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane31_strm0_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane31_strm0_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane31_type0                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane31_num_of_types0             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane31_strm0_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane31_strm0_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane31_type0                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane31_num_of_types0                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane31_stagger0                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__sdp__lane31_strm0_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__sdp__lane31_strm0_stOp_destination ;                      
  wire                                         scntl__sdp__lane31_strm1_read_enable         ;
  wire                                         scntl__sdp__lane31_strm1_write_enable        ;
  wire                                         sdp__scntl__lane31_strm1_read_ready          ;  // from dma
  wire                                         sdp__scntl__lane31_strm1_write_ready         ;
  wire                                         sdp__scntl__lane31_strm1_read_complete       ;  // from dma
  wire                                         sdp__scntl__lane31_strm1_write_complete      ;
  reg    [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane31_strm1_read_start_address  ;  // register because may be assigned from external DMA request
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] scntl__sdp__lane31_strm1_write_start_address ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] scntl__sdp__lane31_type1                     ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] scntl__sdp__lane31_num_of_types1             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane31_strm1_read_start_address             ;
  wire   [`DMA_CONT_STRM_ADDRESS_RANGE       ] lane31_strm1_write_start_address            ;
  wire   [`DMA_CONT_DATA_TYPES_RANGE         ] lane31_type1                                ;
  wire   [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ] lane31_num_of_types1                        ;
  wire   [`PE_MAX_STAGGER_RANGE              ] lane31_stagger1                             ;
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__sdp__lane31_strm1_stOp_source      ;                      
   output [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__sdp__lane31_strm1_stOp_destination ;                      

  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane0_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane0_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane0_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane0_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane1_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane1_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane1_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane1_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane2_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane2_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane2_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane2_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane3_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane3_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane3_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane3_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane4_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane4_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane4_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane4_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane5_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane5_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane5_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane5_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane6_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane6_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane6_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane6_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane7_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane7_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane7_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane7_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane8_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane8_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane8_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane8_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane9_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane9_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane9_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane9_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane10_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane10_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane10_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane10_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane11_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane11_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane11_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane11_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane12_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane12_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane12_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane12_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane13_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane13_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane13_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane13_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane14_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane14_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane14_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane14_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane15_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane15_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane15_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane15_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane16_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane16_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane16_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane16_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane17_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane17_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane17_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane17_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane18_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane18_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane18_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane18_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane19_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane19_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane19_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane19_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane20_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane20_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane20_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane20_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane21_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane21_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane21_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane21_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane22_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane22_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane22_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane22_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane23_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane23_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane23_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane23_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane24_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane24_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane24_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane24_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane25_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane25_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane25_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane25_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane26_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane26_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane26_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane26_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane27_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane27_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane27_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane27_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane28_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane28_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane28_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane28_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane29_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane29_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane29_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane29_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane30_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane30_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane30_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane30_strm1_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane31_strm0_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane31_strm0_write_start_peId  ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane31_strm1_read_start_peId   ;
  wire [`STREAMING_OP_CNTL_PE_ID_RANGE] lane31_strm1_write_start_peId  ;

  // Local DMA request to NoC signals
  // Create a vector of requests
  wire [`PE_NUM_OF_EXEC_LANES_RANGE] NoC_Request_Vector            ;
  wire [`PE_NUM_OF_EXEC_LANES_RANGE] NoC_Request_Strm_Vector       ;
  reg  [`PE_EXEC_LANE_ID_RANGE     ] localDmaRequestLane           ;
  reg                                localDmaRequest               ;

  // External DMA requests to local streams from NoC signals
  wire [`PE_NUM_OF_EXEC_LANES_RANGE] Read_Stream_Available_Vector  ;
  reg  [`PE_NUM_OF_EXEC_LANES_RANGE] Read_Stream_Request_Vector    ;
  reg  [`PE_EXEC_LANE_ID_RANGE     ] localStrmAvailableLane        ;
  reg                                localStrmAvailable            ;

  // Data from StOp to NoC signals
  wire [`PE_NUM_OF_EXEC_LANES_RANGE] toNocDmaPacketAvailableVector ;
  reg                                toNocDmaPacketAvailable       ;
  reg  [`PE_EXEC_LANE_ID_RANGE     ] toNocSelectedLane             ;
