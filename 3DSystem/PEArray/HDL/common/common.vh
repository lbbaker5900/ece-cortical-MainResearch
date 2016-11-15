

//------------------------------------------------------------------------------------------------------------
`define CLOG2(x) \
  (x <=  1)          ?  0  : \
  (x <=  2)          ?  1  : \
  (x <=  4)          ?  2  : \
  (x <=  8)          ?  3  : \
  (x <= 16)          ?  4  : \
  (x <= 32)          ?  5  : \
  (x <= 64)          ?  6  : \
  (x <= 128)         ?  7  : \
  (x <= 256)         ?  8  : \
  (x <= 512)         ?  9  : \
  (x <= 1024)        ? 10  : \
  (x <= 2048)        ? 11  : \
  (x <= 4096)        ? 12  : \
  (x <= 8192)        ? 13  : \
  (x <= 16384)       ? 14  : \
  (x <= 32768)       ? 15  : \
  (x <= 65536)       ? 16  : \
  (x <= 131072)      ? 17  : \
  (x <= 262144)      ? 18  : \
  (x <= 524288)      ? 19  : \
  (x <= 1048576)     ? 20  : \
  -1

//------------------------------------------------------------------------------------------------------------
// FIFO's

// Threshold below full when we assert almost full
`define COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT  6
`define COMMON_STREAMING_OP_INPUT_FIFO_ALMOST_FULL_THRESHOLD 2

//--------------------------------------------------------
// Streaming Op input and DMA input from stOp

// Uses:
//      inside stOp - shared between from dma and cntl(noc) 
//      inside dma  - from stOp

`define STREAMING_OP_INPUT_FIFO \
        reg  [`STREAMING_OP_DATA_WIDTH_RANGE]       fifo_data      [`STREAMING_OP_INPUT_FIFO_DEPTH_RANGE] ; \
        reg  [`DMA_CONT_STRM_CNTL_RANGE     ]       fifo_cntl      [`STREAMING_OP_INPUT_FIFO_DEPTH_RANGE] ; \
        reg  [`STREAMING_OP_INPUT_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_INPUT_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_INPUT_FIFO_RANGE]       fifo_depth           ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        wire [`STREAMING_OP_DATA_WIDTH_RANGE]       fifo_read_data       ; \
        wire [`DMA_CONT_STRM_CNTL_RANGE     ]       fifo_read_cntl       ; \
        wire [`STREAMING_OP_DATA_WIDTH_RANGE]       data                 ; \
        wire [`DMA_CONT_STRM_CNTL_RANGE     ]       cntl                 ; \
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_INPUT_FIFO_DEPTH-`COMMON_STREAMING_OP_INPUT_FIFO_ALMOST_FULL_THRESHOLD)    ;\
          assign fifo_read_data      = fifo_data [fifo_rp] ;\
          assign fifo_read_cntl      = fifo_cntl [fifo_rp] ;\

//--------------------------------------------------------
// to stOp from NoC

// Note: Additional "fifo contains eop" flag
//       Needed for the last piece of data that doesnt fill an entire DMA packet
//       Assumes no more than one eop in the fifo as this DMA will complete before another is started

// Uses:
//      inside cntl - to stOp

`define NoC_to_StOp_FIFO \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_cntl      [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_RANGE] ; \
        reg                                              fifo_strmId    [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_RANGE] ;\
        reg  [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE]       fifo_data      [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH_RANGE] ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_read_cntl       ; \
        reg                                              fifo_read_strmId     ; \
        reg  [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE]       fifo_read_data       ; \
        reg                                              fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       cntl                 ; \
        wire                                             strmId               ; \
        wire [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE]       data                 ; \
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]      <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
            fifo_read_data_valid    <= ( reset_poweron                   ) ? 'd0        : \
                                       ( clear                           ) ? 'd0        : \
                                                                              fifo_read ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
        always @(posedge clk)\
          begin\
            fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
            fifo_read_strmId    <= (fifo_read) ? fifo_strmId [fifo_rp] : fifo_read_strmId ;\
            fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
          end\


`define NoC_to_StOp_FIFO_wRealMemory \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_read_cntl       ; \
        wire                                             fifo_read_strmId     ; \
        wire [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE]       fifo_read_data       ; \
        reg                                              fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       cntl                 ; \
        wire                                             strmId               ; \
        wire [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE]       data                 ; \
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
\
            fifo_read_data_valid    <= ( reset_poweron                   ) ? 'd0        : \
                                       ( clear                           ) ? 'd0        : \
                                                                              fifo_read ;\
   \
            //fifo_empty              <= ( reset_poweron                   ) ? 'd1                  : \
            //                           ( clear                           ) ? 'd1                  : \
            //                                                                 (fifo_rp == fifo_wp) ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\



//--------------------------------------------------------
// to NoC from stOp

// Note: Additional "fifo contains eop" flag
//       Needed for the last piece of data that doesnt fill an entire DMA packet
//       Assumes no more than one eop in the fifo as this DMA will complete before another is started

// Uses:
//      inside cntl - from stOp

`define StOp_to_NoC_FIFO \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_cntl      [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_RANGE] ; \
        reg                                              fifo_strmId    [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_RANGE] ;\
        reg  [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE]       fifo_data      [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH_RANGE] ; \
        reg  [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       fifo_read_cntl       ; \
        reg                                              fifo_read_strmId     ; \
        reg  [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE]       fifo_read_data       ; \
        reg                                              fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]       cntl                 ; \
        wire                                             strmId               ; \
        wire [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE]       data                 ; \
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]      <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
\
            fifo_read_data_valid    <= ( reset_poweron                   ) ? 'd0        : \
                                       ( clear                           ) ? 'd0        : \
                                                                              fifo_read ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_DEPTH-6)    ;\
        always @(posedge clk)\
          begin\
            fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
            fifo_read_strmId    <= (fifo_read) ? fifo_strmId [fifo_rp] : fifo_read_strmId ;\
            fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
          end\



//--------------------------------------------------------
// Streaming Op Control to NoC FIFO

// Note: Additional "fifo contains eop" flag
//       Needed for the last piece of data that doesnt fill an entire DMA packet
//       Assumes no more than one eop in the fifo as this DMA will complete before another is started

// Uses:
//      inside noc - control from cntl

`define Control_to_NoC_FIFO \
\
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_cntl   [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_type   [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_laneId [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg                                                    fifo_strmId [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_data   [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_read_cntl   ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_read_type   ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_read_data   ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_read_laneId ;\
        reg                                                    fifo_read_strmId ;\
        reg                                                    fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        cntl             ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        type             ;\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        data             ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        laneId           ;\
        wire                                                   strmId           ;\
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_type[fifo_wp]      <= ( fifo_write       ) ? type               : \
                                                              fifo_type[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_laneId[fifo_wp]      <= ( fifo_write       ) ? laneId               : \
                                                              fifo_laneId[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]      <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
            fifo_read_data_valid    <= ( reset_poweron                   ) ? 'd0        : \
                                       ( clear                           ) ? 'd0        : \
                                                                              fifo_read ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
\
          always @(posedge clk)\
            begin\
              fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
              fifo_read_type      <= (fifo_read) ? fifo_type [fifo_rp]   : fifo_read_type   ;\
              fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
              fifo_read_laneId    <= (fifo_read) ? fifo_laneId [fifo_rp] : fifo_read_laneId ;\
              fifo_read_strmId    <= (fifo_read) ? fifo_strmId [fifo_rp] : fifo_read_strmId ;\
            end\
      

//--------------------------------------------------------
// Streaming Op Control from NoC FIFO
// Uses:
//      inside cntl - control from noc

`define Control_from_NoC_FIFO \
\
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_cntl   [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_type   [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_data   [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_PE_ID_RANGE          ]        fifo_peId   [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_laneId [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg                                                    fifo_strmId [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_read_cntl   ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_read_type   ;\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_read_data   ;\
        wire [`STREAMING_OP_CNTL_PE_ID_RANGE          ]        fifo_read_peId   ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_read_laneId ;\
        wire                                                   fifo_read_strmId ;\
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        cntl             ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        type             ;\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        data             ;\
        wire [`PE_PE_ID_RANGE                         ]        peId             ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        laneId           ;\
        wire                                                   strmId           ;\
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_type[fifo_wp]      <= ( fifo_write       ) ? type               : \
                                                              fifo_type[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_peId[fifo_wp]      <= ( fifo_write       ) ? peId               : \
                                                              fifo_peId[fifo_wp] ;\
   \
            fifo_laneId[fifo_wp]    <= ( fifo_write       ) ? laneId               : \
                                                              fifo_laneId[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]    <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_CONT_FROM_NOC_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
          assign fifo_read_cntl      = fifo_cntl [fifo_rp] ;\
          assign fifo_read_type      = fifo_type [fifo_rp] ;\
          assign fifo_read_data      = fifo_data [fifo_rp] ;\
          assign fifo_read_peId      = fifo_peId [fifo_rp] ;\
          assign fifo_read_laneId    = fifo_laneId [fifo_rp] ;\
          assign fifo_read_strmId    = fifo_strmId [fifo_rp] ;\


//--------------------------------------------------------
// NoC controller to NoC Interface Data
// Uses:
//      inside noc - data from cntl

`define NoC_to_NoC_data_intf \
\
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_cntl   [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_type   [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_data   [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_PE_ID_RANGE          ]        fifo_peId   [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_laneId [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg                                                    fifo_strmId [`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH_RANGE]    ;\
        reg  [`NOC_CONT_TO_INTF_DATA_FIFO_RANGE]       fifo_wp              ; \
        reg  [`NOC_CONT_TO_INTF_DATA_FIFO_RANGE]       fifo_rp              ; \
        reg  [`NOC_CONT_TO_INTF_DATA_FIFO_RANGE]       fifo_depth           ; \
        reg  [`NOC_CONT_TO_INTF_DATA_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_read_cntl   ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_read_type   ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_read_data   ;\
        reg  [`STREAMING_OP_CNTL_PE_ID_RANGE          ]        fifo_read_peId   ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_read_laneId ;\
        reg                                                    fifo_read_strmId ;\
        reg                                                    fifo_read_data_valid ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        cntl             ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        type             ;\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        data             ;\
        wire [`PE_PE_ID_RANGE                         ]        peId             ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        laneId           ;\
        wire                                                   strmId           ;\
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_type[fifo_wp]      <= ( fifo_write       ) ? type               : \
                                                              fifo_type[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_peId[fifo_wp]      <= ( fifo_write       ) ? peId               : \
                                                              fifo_peId[fifo_wp] ;\
   \
            fifo_laneId[fifo_wp]    <= ( fifo_write       ) ? laneId               : \
                                                              fifo_laneId[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]    <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
            fifo_read_data_valid    <= ( reset_poweron                   ) ? 'd0        : \
                                       ( clear                           ) ? 'd0        : \
                                                                              fifo_read ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`NOC_CONT_TO_INTF_DATA_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
\
          always @(posedge clk)\
            begin\
              fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
              fifo_read_type      <= (fifo_read) ? fifo_type [fifo_rp]   : fifo_read_type   ;\
              fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
              fifo_read_peId      <= (fifo_read) ? fifo_peId [fifo_rp]   : fifo_read_peId   ;\
              fifo_read_laneId    <= (fifo_read) ? fifo_laneId [fifo_rp] : fifo_read_laneId ;\
              fifo_read_strmId    <= (fifo_read) ? fifo_strmId [fifo_rp] : fifo_read_strmId ;\
            end\


//--------------------------------------------------------
// NoC Data to Control FIFO
// Uses:
//      inside cntl - data from noc

`define Data_from_NoC_FIFO \
\
        reg  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_cntl   [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_type   [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_laneId [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg                                                    fifo_strmId [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_data   [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH_RANGE]    ;\
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE]       fifo_wp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE]       fifo_rp              ; \
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_RANGE]       fifo_depth           ; \
        reg  [`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_EOP_COUNT_RANGE] fifo_eop_count   ; \
        wire                                        fifo_empty           ; \
        wire                                        fifo_almost_full     ; \
        wire                                        fifo_read            ; \
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        fifo_read_cntl   ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        fifo_read_type   ;\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        fifo_read_data   ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        fifo_read_laneId ;\
        wire                                                   fifo_read_strmId ;\
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]        cntl             ;\
        wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]        type             ;\
        wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]        data             ;\
        wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]        laneId           ;\
        wire                                                   strmId           ;\
        wire                                        fifo_write           ; \
        wire                                        clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_type[fifo_wp]      <= ( fifo_write       ) ? type               : \
                                                              fifo_type[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_laneId[fifo_wp]      <= ( fifo_write       ) ? laneId               : \
                                                              fifo_laneId[fifo_wp] ;\
   \
            fifo_strmId[fifo_wp]      <= ( fifo_write       ) ? strmId               : \
                                                              fifo_strmId[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read ) &&                       \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (fifo_read_cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) && fifo_read )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_EOP) | (          cntl ==  'd`STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`STREAMING_OP_CNTL_CONT_TO_NOC_FIFO_DEPTH-`COMMON_FIFO_ALMOST_FULL_THRESHOLD_DEFAULT)    ;\
          assign fifo_read_cntl      = fifo_cntl [fifo_rp] ;\
          assign fifo_read_type      = fifo_type [fifo_rp] ;\
          assign fifo_read_data      = fifo_data [fifo_rp] ;\
          assign fifo_read_laneId    = fifo_laneId [fifo_rp] ;\
          assign fifo_read_strmId    = fifo_strmId [fifo_rp] ;\


//--------------------------------------------------------
// NoC FIFO's

`define NoC_Port_fifo \
\
        reg  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]                   fifo_cntl      [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_RANGE] ; \
        reg  [`NOC_CONT_NOC_PORT_DATA_RANGE]                    fifo_data      [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH_RANGE] ; \
        reg  [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE]           fifo_wp              ; \
        reg  [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE]           fifo_rp              ; \
        reg  [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_RANGE]           fifo_depth           ; \
        reg  [`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_EOP_COUNT_RANGE] fifo_eop_count       ; \
        wire                                                    fifo_empty           ; \
        wire                                                    fifo_almost_full     ; \
        wire                                                    fifo_read            ; \
        reg  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]                   fifo_read_cntl       ; \
        reg  [`NOC_CONT_NOC_PORT_DATA_RANGE]                    fifo_read_data       ; \
        reg                                                     fifo_read_data_valid ; \
        reg  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]                   cntl                 ; \
        reg  [`NOC_CONT_NOC_PORT_DATA_RANGE]                    data                 ; \
        reg                                                     fifo_write           ; \
        wire                                                    clear                ; \
   \
        always @(posedge clk)\
          begin\
            fifo_wp                 <= ( reset_poweron   ) ? 'd0            : \
                                       ( clear           ) ? 'd0            : \
                                       ( fifo_write      ) ? fifo_wp + 'd1  :\
                                                             fifo_wp        ;\
   \
            fifo_cntl[fifo_wp]      <= ( fifo_write       ) ? cntl               : \
                                                              fifo_cntl[fifo_wp] ;\
   \
            fifo_data[fifo_wp]      <= ( fifo_write       ) ? data               : \
                                                              fifo_data[fifo_wp] ;\
   \
            fifo_rp                 <= ( reset_poweron    ) ? 'd0           : \
                                       ( clear            ) ? 'd0           : \
                                       ( fifo_read        ) ? fifo_rp + 'd1 :\
                                                              fifo_rp       ;\
\
            fifo_eop_count          <= ( reset_poweron                                                                                                                       )  ? 'd0                  : \
                                       ( clear                                                                                                                               )  ? 'd0                  : \
                                       ((((fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) && fifo_read_data_valid ) &&                       \
                                       (((          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) & fifo_write )) ? fifo_eop_count       : \
                                       (((fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (fifo_read_cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) && fifo_read_data_valid )  ? fifo_eop_count - 'd1 : \
                                       (((          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_EOP) | (          cntl ==  'd`NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)) & fifo_write )  ? fifo_eop_count + 'd1 : \
                                                                                                                                                                                  fifo_eop_count       ; \
\
            fifo_depth              <= ( reset_poweron                   ) ? 'd0              : \
                                       ( clear                           ) ? 'd0              : \
                                       (  fifo_read & ~fifo_write        ) ? fifo_depth - 'd1 :\
                                       ( ~fifo_read &  fifo_write        ) ? fifo_depth + 'd1 :\
                                                                             fifo_depth       ;\
   \
            fifo_read_data_valid    <= ( reset_poweron                   ) ? 'd0        : \
                                       ( clear                           ) ? 'd0        : \
                                                                              fifo_read ;\
   \
          end\
\
          assign fifo_empty          = (fifo_rp == fifo_wp)    ;\
          assign fifo_almost_full    = (fifo_depth >= 'd`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH-`NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_ALMOST_FULL_THRESHOLD)    ;\
        always @(posedge clk)\
          begin\
            fifo_read_cntl      <= (fifo_read) ? fifo_cntl [fifo_rp]   : fifo_read_cntl   ;\
            fifo_read_data      <= (fifo_read) ? fifo_data [fifo_rp]   : fifo_read_data   ;\
          end\


//------------------------------------------------------------------------------------------------------------
`define COMMON_IEEE754_FLOAT_ONE       32'h3F80_0000
`define COMMON_IEEE754_FLOAT_ZERO      32'h0000_0000
`define COMMON_IEEE754_FLOAT_INFINITY  32'h7F80_0000
`define COMMON_INT_MAX                 32'hFFFF_FFFF


