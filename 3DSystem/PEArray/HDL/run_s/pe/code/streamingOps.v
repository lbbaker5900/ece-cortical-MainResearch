/*********************************************************************************************

    File name   : streamingOps.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

    Description : This module takes streaming data from the external interface or DMA and performs one of a set of
                  operations.
                  The result can be:
                  a) a single value
                     - option to write value to memory 
                  b) a vector of values
                     - in this case, the vector is written back to local memory

*********************************************************************************************/
    

`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "streamingOps_cntl.vh"
`include "dma_cont.vh"
`include "streamingOps.vh"

// Josh's FP
//`include "/home/lbbaker/Cortical/StreamingOps/PE/HDL/josh/fp/fp_mac/fp_mac_32.v"
//`include "/home/lbbaker/Cortical/StreamingOps/PE/HDL/josh/fp/fp_compare/fp_compare_32.v"

// synopsys translate_off
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_cmp.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_cmp_DG.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_mult.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_mac.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_dp2.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_ifp_conv.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_ifp_fp_conv.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_ifp_mult.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_ifp_addsub.v"

//synopsys translate_on

module streamingOps (
                          clk               ,
                          reset_poweron     ,

                          // Controller interface
                          operation               , // from register interface
                          strm0_enable            , 
                          strm0_source            , 
                          strm0_destination       , 
                          strm0_ready             , 
                          strm0_complete          , 
                          strm1_enable            , 
                          strm1_source            , 
                          strm1_destination       , 
                          strm1_ready             , 
                          strm1_complete          , 
 

                          // Result interface
                          reg__stOp__ready             ,
                          stOp__reg__valid             ,
                          stOp__reg__data              , 

                          // DMA interface
                          stOp__dma__strm0_ready       ,
                          dma__stOp__strm0_cntl        , 
                          dma__stOp__strm0_data        , 
                          dma__stOp__strm0_data_valid  , 
                          dma__stOp__strm0_data_mask   , 
                          stOp__dma__strm1_ready       ,
                          dma__stOp__strm1_cntl        , 
                          dma__stOp__strm1_data        , 
                          dma__stOp__strm1_data_valid  , 
                          dma__stOp__strm1_data_mask   , 

                          dma__stOp__strm0_ready       ,
                          stOp__dma__strm0_cntl        , 
                          stOp__dma__strm0_data        , 
                          stOp__dma__strm0_data_mask   , 
                          stOp__dma__strm0_data_valid  , 
                          dma__stOp__strm1_ready       ,
                          stOp__dma__strm1_cntl        , 
                          stOp__dma__strm1_data        , 
                          stOp__dma__strm1_data_mask   , 
                          stOp__dma__strm1_data_valid  , 

                          // NoC interface (via stop_cntl)
                          // from NoC
                          stOp__noc__strm_ready        ,
                          noc__stOp__strm_cntl         , 
                          noc__stOp__strm_id           , 
                          noc__stOp__strm_data         , 
                          noc__stOp__strm_data_valid   , 
                          // to NoC
                          noc__stOp__strm_ready        ,
                          stOp__noc__strm_cntl         , 
                          stOp__noc__strm_id           , 
                          stOp__noc__strm_data         , 
                          stOp__noc__strm_data_valid   , 

                          // Downstream Stack interface
                          stOp__sti__strm0_ready        ,
                          sti__stOp__strm0_cntl         , 
                          sti__stOp__strm0_data         , 
                          sti__stOp__strm0_data_mask    , 
                          sti__stOp__strm0_data_valid   , 
                          stOp__sti__strm1_ready        ,
                          sti__stOp__strm1_cntl         , 
                          sti__stOp__strm1_data         , 
                          sti__stOp__strm1_data_valid   , 
                          sti__stOp__strm1_data_mask   

    );

  input         clk            ;
  input         reset_poweron  ;


  // interface to PE core
  input       strm0_enable      ;
  input       strm1_enable      ;
  output      strm0_ready       ;
  output      strm1_ready       ;
  output      strm0_complete    ;
  output      strm1_complete    ;
  input [`STREAMING_OP_CNTL_OPERATION_RANGE                  ]        operation         ;
  input [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]        strm0_source      ; 
  input [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]        strm1_source      ; 
  input [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]        strm0_destination ; 
  input [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]        strm1_destination ; 

  // Result interface
  input                                        reg__stOp__ready          ;
  output                                       stOp__reg__valid         ;
  output [`STREAMING_OP_RESULT_RANGE   ]       stOp__reg__data                ; 

  // DMA interface
  output                                       stOp__dma__strm0_ready       ;
  input [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm0_cntl        ; 
  input [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data        ; 
  input [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data_mask   ; 
  input                                        dma__stOp__strm0_data_valid  ; 
  output                                       stOp__dma__strm1_ready       ;
  input [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm1_cntl        ; 
  input [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data        ; 
  input [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data_mask   ; 
  input                                        dma__stOp__strm1_data_valid  ; 

  input                                        dma__stOp__strm0_ready       ;
  output [`DMA_CONT_STRM_CNTL_RANGE     ]      stOp__dma__strm0_cntl        ; 
  output [`STREAMING_OP_DATA_RANGE      ]      stOp__dma__strm0_data        ; 
  output [`STREAMING_OP_DATA_RANGE      ]      stOp__dma__strm0_data_mask   ; 
  output                                       stOp__dma__strm0_data_valid  ; 
  input                                        dma__stOp__strm1_ready       ;
  output [`DMA_CONT_STRM_CNTL_RANGE     ]      stOp__dma__strm1_cntl        ; 
  output [`STREAMING_OP_DATA_RANGE      ]      stOp__dma__strm1_data        ; 
  output [`STREAMING_OP_DATA_RANGE      ]      stOp__dma__strm1_data_mask   ; 
  output                                       stOp__dma__strm1_data_valid  ; 

  // NoC interface
  // from NoC
  output                                       stOp__noc__strm_ready       ;
  input [`DMA_CONT_STRM_CNTL_RANGE     ]       noc__stOp__strm_cntl        ; 
  input                                        noc__stOp__strm_id          ; 
  input [`STREAMING_OP_DATA_RANGE      ]       noc__stOp__strm_data        ; 
  input                                        noc__stOp__strm_data_valid  ; 
  // to NoC
  input                                        noc__stOp__strm_ready       ;
  output[`DMA_CONT_STRM_CNTL_RANGE     ]       stOp__noc__strm_cntl        ; 
  output                                       stOp__noc__strm_id          ; 
  output[`STREAMING_OP_DATA_RANGE      ]       stOp__noc__strm_data        ; 
  output                                       stOp__noc__strm_data_valid  ; 

  // Downstream Stack interface
  output                                       stOp__sti__strm0_ready       ;
  input [`DMA_CONT_STRM_CNTL_RANGE     ]       sti__stOp__strm0_cntl        ; 
  input [`STREAMING_OP_DATA_RANGE      ]       sti__stOp__strm0_data        ; 
  input [`STREAMING_OP_DATA_RANGE      ]       sti__stOp__strm0_data_mask   ; 
  input                                        sti__stOp__strm0_data_valid  ; 
  output                                       stOp__sti__strm1_ready       ;
  input [`DMA_CONT_STRM_CNTL_RANGE     ]       sti__stOp__strm1_cntl        ; 
  input [`STREAMING_OP_DATA_RANGE      ]       sti__stOp__strm1_data        ; 
  input [`STREAMING_OP_DATA_RANGE      ]       sti__stOp__strm1_data_mask   ; 
  input                                        sti__stOp__strm1_data_valid  ; 


  //-------------------------------------------------------------------------------------------
  // Wires and Register
  //

  wire  [`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE ]  opcode       ; // extract opcode
  assign opcode = operation[`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE];

  //------------------------------------------------------------
  // Operation related fields
  //
  //------------------------------------------------------------

  wire    strm0_enable         ; 
  wire    strm1_enable         ; // some times only one stream, but keep twom enabkes for now 

  // DMA interface
  wire                                         dma__stOp__strm0_ready       ;
  reg    [`DMA_CONT_STRM_CNTL_RANGE     ]      stOp__dma__strm0_cntl        ; 
  reg    [`STREAMING_OP_DATA_RANGE      ]      stOp__dma__strm0_data        ; 
  reg    [`STREAMING_OP_DATA_RANGE      ]      stOp__dma__strm0_data_mask   ; 
  reg                                          stOp__dma__strm0_data_valid  ; 
  wire                                         dma__stOp__strm1_ready       ;
  reg    [`DMA_CONT_STRM_CNTL_RANGE     ]      stOp__dma__strm1_cntl        ; 
  reg    [`STREAMING_OP_DATA_RANGE      ]      stOp__dma__strm1_data        ; 
  reg    [`STREAMING_OP_DATA_RANGE      ]      stOp__dma__strm1_data_mask   ; 
  reg                                          stOp__dma__strm1_data_valid  ; 

  reg                                          stOp__dma__strm0_ready       ;
  wire  [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm0_cntl        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data_mask   ; 
  wire                                         dma__stOp__strm0_data_valid  ; 
  reg                                          stOp__dma__strm1_ready       ;
  wire  [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm1_cntl        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data_mask   ; 
  wire                                         dma__stOp__strm1_data_valid  ; 
  // NoC interface
  wire                                         noc__stOp__strm_ready       ;
  reg    [`DMA_CONT_STRM_CNTL_RANGE     ]      stOp__noc__strm_cntl        ; 
  reg                                          stOp__noc__strm_id          ; 
  reg    [`STREAMING_OP_DATA_RANGE      ]      stOp__noc__strm_data        ; 
  reg    [`STREAMING_OP_DATA_RANGE      ]      stOp__noc__strm_data_mask   ; 
  reg                                          stOp__noc__strm_data_valid  ; 

  reg                                          stOp__noc__strm_ready       ;
  wire  [`DMA_CONT_STRM_CNTL_RANGE     ]       noc__stOp__strm_cntl        ; 
  wire                                         noc__stOp__strm_id          ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       noc__stOp__strm_data        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       noc__stOp__strm_data_mask   ; 
  wire                                         noc__stOp__strm_data_valid  ; 
  // Downstream Stack interface
  reg                                          stOp__sti__strm0_ready       ;
  wire  [`DMA_CONT_STRM_CNTL_RANGE     ]       sti__stOp__strm0_cntl        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       sti__stOp__strm0_data        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       sti__stOp__strm0_data_mask   ; 
  wire                                         sti__stOp__strm0_data_valid  ; 
  reg                                          stOp__sti__strm1_ready       ;
  wire  [`DMA_CONT_STRM_CNTL_RANGE     ]       sti__stOp__strm1_cntl        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       sti__stOp__strm1_data        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       sti__stOp__strm1_data_mask   ; 
  wire                                         sti__stOp__strm1_data_valid  ; 

  // Input FIFO
  reg                                         strm0_fifo_read     ;    
  reg                                         strm1_fifo_read     ;    
  reg                                         strm0_output_valid  ;    
  reg                                         strm1_output_valid  ;    

  reg  [`DMA_CONT_STRM_CNTL_RANGE     ]       strm0_cntl        ; 
  reg  [`STREAMING_OP_DATA_RANGE      ]       strm0_data        ; 
  reg  [`STREAMING_OP_DATA_RANGE      ]       strm0_data_mask   ; 
  reg                                         strm0_data_valid  ; 
  reg  [`DMA_CONT_STRM_CNTL_RANGE     ]       strm1_cntl        ; 
  reg  [`STREAMING_OP_DATA_RANGE      ]       strm1_data        ; 
  reg  [`STREAMING_OP_DATA_RANGE      ]       strm1_data_mask   ; 
  reg                                         strm1_data_valid  ; 
  wire                                        strm0_fifo_empty           ; 
  wire [`STREAMING_OP_DATA_RANGE      ]       strm0_fifo_read_data       ; 
  wire [`DMA_CONT_STRM_CNTL_RANGE     ]       strm0_fifo_read_cntl       ; 
  wire                                        strm1_fifo_empty           ; 
  wire [`STREAMING_OP_DATA_RANGE      ]       strm1_fifo_read_data       ; 
  wire [`DMA_CONT_STRM_CNTL_RANGE     ]       strm1_fifo_read_cntl       ; 
  wire                                        strm_fifo_data_available   ;
  wire                                        strm0_fifo_data_available   ;
  wire                                        strm1_fifo_data_available   ;
  wire                                        strm_fifo_empty            ;

  //-----------------------------------------------
  // operation reg's
  reg [`STREAMING_OP_BSUM_RANGE] bsum                ;
  reg                            bsum_complete       ;
  reg                            bsum_enable         ;
  reg                            bsum_result_valid   ;

  // FP MAC
  reg [`STREAMING_OP_FP_RANGE]   fp_mac               ;
  reg                            fp_mac_enable        ;
  reg                            fp_mac_complete      ;
  reg                            fp_mac_result_valid  ;

  // FP Compare
  reg [`STREAMING_OP_INDEX_RANGE] fp_cmp                     ;
  reg                             fp_cmp_enable              ;
  reg                             fp_cmp_min                 ;  // find min in the vector
  reg                             fp_cmp_max                 ;  // find max in the vector
  reg                             fp_cmp_first_gt_threshold  ;  // find first element to exceed a threshold
  reg                             fp_cmp_complete            ;
  reg                             fp_cmp_result_valid        ;
  reg [`STREAMING_OP_STATE_RANGE] so_cmp_state               ;  // state flop
  reg [`STREAMING_OP_STATE_RANGE] so_cmp_state_next          ;
  
  // Result interface
  wire                                      reg__stOp__ready       ;
  reg                                       stOp__reg__valid       ;
  reg [`STREAMING_OP_RESULT_RANGE   ]       stOp__reg__data        ; 
  reg [`STREAMING_OP_RESULT_RANGE   ]       stOp_result          ; // mux the streaming op output to the result
  reg                                       stOp_result_valid    ;
  reg                                       strm0_stOp_complete          ; // let the streaming operation tell us when it is complete
  reg                                       strm1_stOp_complete          ; // let the streaming operation tell us when it is complete
                                                                     // Means selected streaming operation complete

  reg     strm0_ready          ;  // Stream ready 
  reg     strm1_ready          ;  
  reg     strm0_complete       ;  // Stream complete thru fifo and output processing
  reg     strm1_complete       ;  

  reg     strm0_src_complete       ;  // seen EOP at output of input fifo
  reg     strm1_src_complete       ;  
  wire    strm0_src_complete_next  ;  // seen EOP at output of input fifo
  wire    strm1_src_complete_next  ;  

  //-------------------------------------------------------------------------------------------------
  // Operation Data-Flow
  //

  // Operations need to know when the last transaction is at the output of the
  // FIFO
  assign  strm0_src_complete_next          =   ~strm0_fifo_empty & ((strm0_fifo_read_cntl == `DMA_CONT_STRM_CNTL_EOP) | (strm0_fifo_read_cntl == `DMA_CONT_STRM_CNTL_SOP_EOP)) ;
  assign  strm1_src_complete_next          =   ~strm1_fifo_empty & ((strm1_fifo_read_cntl == `DMA_CONT_STRM_CNTL_EOP) | (strm1_fifo_read_cntl == `DMA_CONT_STRM_CNTL_SOP_EOP)) ;

  always @(*)
    begin
    // Output
    stOp__reg__data              =   'd0                       ;
    stOp__reg__valid             =   'b0                       ;
    // to Memory (via dma)
    stOp__dma__strm0_data        =    32'hFFFF_FFFF            ;
    stOp__dma__strm0_cntl        =   'd0                       ;
    stOp__dma__strm0_data_valid  =   'b0                       ;
    stOp__dma__strm1_data        =    32'hFFFF_FFFF            ;
    stOp__dma__strm1_cntl        =   'd0                       ;
    stOp__dma__strm1_data_valid  =   'b0                       ;
    // FIFO control
    strm0_fifo_read              =   'd0                       ;
    strm1_fifo_read              =   'd0                       ;
    strm0_stOp_complete          =   'd0                       ;
    strm1_stOp_complete          =   'd0                       ;
 
    // stOp control
    bsum_enable                  =   'b0                       ;
    fp_mac_enable                =   'b0                       ;
    fp_cmp_min                   =   'b0                       ;
    fp_cmp_max                   =   'b0                       ;
    fp_cmp_first_gt_threshold    =   'b0                       ;
    fp_cmp_enable                =   'b0                       ;
    casex (operation)
      `STREAMING_OP_CNTL_OPERATION_MEM_MEM_BITSUM_TO_MEM   :
        begin
          // Output
          stOp__dma__strm0_data        =   bsum                       ;
          stOp__dma__strm0_cntl        =  `DMA_CONT_STRM_CNTL_SOP_EOP ; // only one result
          stOp__dma__strm0_data_valid  =   bsum_result_valid          ;

          // FIFO control
          strm0_fifo_read              =   strm0_enable & strm_fifo_data_available ;
          strm1_fifo_read              =   strm1_enable & strm_fifo_data_available ;
          strm0_stOp_complete          =   bsum_complete & strm0_fifo_empty ;
          strm1_stOp_complete          =   bsum_complete & strm1_fifo_empty ;
    
          // stOp control
          bsum_enable                  =  1'b1 ;
        end
      `STREAMING_OP_CNTL_OPERATION_MEM_MEM_BITSUM_TO_REG    :
        begin
          // Output
          stOp__reg__data              =   bsum                       ;
          stOp__reg__valid             =   bsum_result_valid          ;

          // FIFO control
          strm0_fifo_read              =   strm0_enable & strm_fifo_data_available ;
          strm1_fifo_read              =   strm1_enable & strm_fifo_data_available ;
          strm0_stOp_complete          =   bsum_complete & strm0_fifo_empty  ;
          strm1_stOp_complete          =   bsum_complete & strm1_fifo_empty  ;
    
          // stOp control
          bsum_enable                  =   'b1 ;
        end
      `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM  :
        begin
          // Output
          stOp__dma__strm0_data        =   strm0_fifo_read_data       ;
          stOp__dma__strm0_data_mask   =   32'hFFFF_FFFF              ;
          stOp__dma__strm0_cntl        =   strm0_fifo_read_cntl       ; // only one result
          stOp__dma__strm0_data_valid  =   strm0_enable & strm0_fifo_data_available & dma__stOp__strm0_ready;  // same as fifo read but cant use fifo read as this would be f/b in a mux

          // FIFO control
          strm0_fifo_read              =   strm0_enable & strm0_fifo_data_available & dma__stOp__strm0_ready;
          strm0_stOp_complete          =   strm0_src_complete & strm0_fifo_empty  ;
    
          // stOp control
        end
      `STREAMING_OP_CNTL_OPERATION_STD_STD_NOP_TO_MEM     :
        begin
          // Output
          stOp__dma__strm0_data        =   strm0_fifo_read_data       ;
          stOp__dma__strm0_data_mask   =   32'hFFFF_FFFF              ;
          stOp__dma__strm0_cntl        =   strm0_fifo_read_cntl       ; // only one result
          stOp__dma__strm0_data_valid  =   strm0_enable & strm0_fifo_data_available & dma__stOp__strm0_ready;  // same as fifo read but cant use fifo read as this would be f/b in a mux
          stOp__dma__strm1_data        =   strm1_fifo_read_data       ;
          stOp__dma__strm1_data_mask   =   32'hFFFF_FFFF              ;
          stOp__dma__strm1_cntl        =   strm1_fifo_read_cntl       ; // only one result
          stOp__dma__strm1_data_valid  =   strm1_enable & strm1_fifo_data_available & dma__stOp__strm1_ready;

          // FIFO control
          strm0_fifo_read              =   strm0_enable & strm0_fifo_data_available & dma__stOp__strm0_ready;
          strm1_fifo_read              =   strm1_enable & strm1_fifo_data_available & dma__stOp__strm1_ready;
          strm0_stOp_complete          =   strm0_src_complete & strm0_fifo_empty  ;
          strm1_stOp_complete          =   strm1_src_complete & strm1_fifo_empty  ;
    
          // stOp control
        end
      `STREAMING_OP_CNTL_OPERATION_MEM_MEM_FP_MAC_TO_MEM     :
        begin
          // Output
          stOp__dma__strm0_data        =   fp_mac                     ;
          stOp__dma__strm0_cntl        =  `DMA_CONT_STRM_CNTL_SOP_EOP ; // only one result
          stOp__dma__strm0_data_valid  =   fp_mac_result_valid ;

          // FIFO control
          strm0_fifo_read              =   strm0_enable & strm_fifo_data_available ;
          strm1_fifo_read              =   strm1_enable & strm_fifo_data_available ;
          strm0_stOp_complete          =   fp_mac_complete      ;
          strm1_stOp_complete          =   fp_mac_complete      ;
    
          // stOp control
          fp_mac_enable                =   'b1                       ;
        end
      `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM     :
        begin
          // Output
          stOp__dma__strm0_data        =   fp_mac                     ;
          stOp__dma__strm0_cntl        =  `DMA_CONT_STRM_CNTL_SOP_EOP ; // only one result
          stOp__dma__strm0_data_valid  =   fp_mac_result_valid ;

          // FIFO control
          strm0_fifo_read              =   strm0_enable & strm_fifo_data_available ;
          strm1_fifo_read              =   strm1_enable & strm_fifo_data_available ;
          strm0_stOp_complete          =   fp_mac_complete      ;
          strm1_stOp_complete          =   fp_mac_complete      ;
    
          // stOp control
          fp_mac_enable                =   'b1                       ;
        end
      `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM     :
        begin
          // Output
          stOp__dma__strm0_data        =   fp_mac                     ;
          stOp__dma__strm0_cntl        =  `DMA_CONT_STRM_CNTL_SOP_EOP ; // only one result
          stOp__dma__strm0_data_valid  =   fp_mac_result_valid ;

          // FIFO control
          strm0_fifo_read              =   strm0_enable & strm_fifo_data_available ;
          strm1_fifo_read              =   strm1_enable & strm_fifo_data_available ;
          strm0_stOp_complete          =   fp_mac_complete      ;
          strm1_stOp_complete          =   fp_mac_complete      ;
    
          // stOp control
          fp_mac_enable                =   'b1                       ;
        end
      `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAX_TO_MEM     :
        begin
          // Output
          stOp__dma__strm0_data        =   fp_cmp                     ;
          stOp__dma__strm0_cntl        =  `DMA_CONT_STRM_CNTL_SOP_EOP ; // only one result
          stOp__dma__strm0_data_valid  =   fp_cmp_result_valid  ;

          // FIFO control
          strm0_fifo_read              =   strm0_enable & ~strm0_fifo_empty & (so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MAX ) ;
          strm0_stOp_complete          =   fp_cmp_complete   ;
          strm1_stOp_complete          =   fp_cmp_complete   ;
    
          // stOp control
          fp_cmp_max                   =   'b1                       ;
          fp_cmp_enable                =   'b1                       ;
        end
      `STREAMING_OP_CNTL_OPERATION_MEM_MEM_FP_FIRST_GT_TO_MEM     :
        begin
          // Output
          stOp__dma__strm0_data        =   fp_cmp                     ;
          stOp__dma__strm0_cntl        =  `DMA_CONT_STRM_CNTL_SOP_EOP ; // only one result
          stOp__dma__strm0_data_valid  =   fp_cmp_result_valid  ;

          // FIFO control
          strm0_fifo_read              =   strm0_enable & ~strm0_fifo_empty & (so_cmp_state == `STREAMING_OP_FP_CMP_STATE_FINDING_FIRST_GT  ) ;
          strm1_fifo_read              =   strm1_enable & ~strm1_fifo_empty & (so_cmp_state == `STREAMING_OP_FP_CMP_STATE_LOADING_THRESHOLD ) ;
          strm0_stOp_complete          =   fp_cmp_complete  & strm0_fifo_empty ;
          strm1_stOp_complete          =   fp_cmp_complete  & strm1_fifo_empty ;
    
          // stOp control
          fp_cmp_first_gt_threshold    =   'b1                       ;
          fp_cmp_enable                =   'b1                       ;
        end
      `STREAMING_OP_CNTL_OPERATION_MEM_NONE_NOP_TO_MEM     :
        begin
          // Output
          stOp__dma__strm0_data        =   strm0_fifo_read_data       ;
          stOp__dma__strm0_data_mask   =   32'hFFFF_FFFF              ;
          stOp__dma__strm0_cntl        =   strm0_fifo_read_cntl       ; // only one result
          stOp__dma__strm0_data_valid  =   strm0_enable & strm0_fifo_data_available & dma__stOp__strm0_ready;  // same as fifo read but cant use fifo read as this would be f/b in a mux

          // FIFO control
          strm0_fifo_read              =   strm0_enable & strm0_fifo_data_available & dma__stOp__strm0_ready;
          strm0_stOp_complete          =   strm0_src_complete & strm0_fifo_empty ;
    
          // stOp control
        end

      default                       : 
        begin
          // Output
          stOp__dma__strm0_data        =    32'hFFFF_FFFF            ;
          stOp__dma__strm0_cntl        =   'd0                       ;
          stOp__dma__strm0_data_valid  =   'b0                       ;
          stOp__dma__strm1_data        =    32'hFFFF_FFFF            ;
          stOp__dma__strm1_cntl        =   'd0                       ;
          stOp__dma__strm1_data_valid  =   'b0                       ;

          // FIFO control
          strm0_fifo_read              =   'd0                       ;
          strm1_fifo_read              =   'd0                       ;
          strm0_stOp_complete          =   'd0                       ;
          strm1_stOp_complete          =   'd0                       ;

          // stOp control
          bsum_enable                  =   'b0                       ;
          fp_mac_enable                =   'b0                       ;
          fp_cmp_max                   =   'b0                       ;
          fp_cmp_enable                =   'b0                       ;
        end
    endcase // always @
    end

  always @(posedge clk)
    begin
      // latch when we see EOP on output of input fifo
      strm0_src_complete  <= ( ~strm0_enable           ) ? 'd0                       :
                             (  strm0_src_complete     ) ? 'd1                       :
                                                            strm0_src_complete_next  ;
      strm1_src_complete  <= ( ~strm1_enable           ) ? 'd0                       :
                             (  strm1_src_complete     ) ? 'd1                       :
                                                            strm1_src_complete_next  ;
    end


  //-------------------------------------------------------------------------------------------------
  // Internal equations
  //
  //
  
  
  //-------------------------------------------------------------------------------------------------
  // output equations
  //
   
  always @(posedge clk)
    begin
      strm0_ready    <= ( reset_poweron    ) ? 1'b0         : 
                                               strm0_enable ;  // FIXME

      strm1_ready    <= ( reset_poweron    ) ? 1'b0         : 
                                               strm1_enable ;  // FIXME

      strm0_complete <= ( reset_poweron    ) ? 1'b0                : 
                                               strm0_stOp_complete ;

      strm1_complete <= ( reset_poweron    ) ? 1'b0                : 
                                               strm1_stOp_complete ;

    end
   
  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------
  // Input FIFO
  //
  // Mux input data
  //------------------------------
  // Stream 0
  always @(*)
    begin
      stOp__sti__strm0_ready  = 'd0                          ; 
      casex (strm0_source)  // the strm0_source override the FROM in the operation
        `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY       : 
          begin
            strm0_cntl              =  dma__stOp__strm0_cntl       ; 
            strm0_data              =  dma__stOp__strm0_data       ; 
            strm0_data_valid        =  dma__stOp__strm0_data_valid ; 
          end
        
        `STREAMING_OP_CNTL_OPERATION_FROM_EXT : 
          begin
            strm0_cntl              =  sti__stOp__strm0_cntl       ; 
            strm0_data              =  sti__stOp__strm0_data       ; 
            strm0_data_valid        =  sti__stOp__strm0_data_valid ; 
            stOp__sti__strm0_ready  = ~fifo[0].fifo_almost_full    ; 
          end
        `STREAMING_OP_CNTL_OPERATION_FROM_NOC       : 
          begin
            strm0_cntl             =  noc__stOp__strm_cntl       ; 
            strm0_data             =  noc__stOp__strm_data       ; 
            strm0_data_valid       =  noc__stOp__strm_data_valid & ~noc__stOp__strm_id ; // from NoC can be strm0 or 1
          end
        default                       : 
          begin
            strm0_cntl              =  dma__stOp__strm0_cntl       ; 
            strm0_data              =  dma__stOp__strm0_data       ; 
            strm0_data_valid        =  dma__stOp__strm0_data_valid ; 
          end
      endcase // always @
    end
  //------------------------------
  // Stream 1
  always @(*)
    begin
      stOp__sti__strm1_ready  = 'd0                          ; 
      casex (strm1_source)  // the strm1_source override the FROM in the operation
        `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY       : 
          begin
            strm1_cntl              =  dma__stOp__strm1_cntl       ; 
            strm1_data              =  dma__stOp__strm1_data       ; 
            strm1_data_valid        =  dma__stOp__strm1_data_valid ; 
          end
        `STREAMING_OP_CNTL_OPERATION_FROM_EXT : 
          begin
            strm1_cntl              =  sti__stOp__strm1_cntl       ; 
            strm1_data              =  sti__stOp__strm1_data       ; 
            strm1_data_valid        =  sti__stOp__strm1_data_valid ; 
            stOp__sti__strm1_ready  = ~fifo[1].fifo_almost_full    ; 
          end
        `STREAMING_OP_CNTL_OPERATION_FROM_NOC       : 
          begin
            strm1_cntl             =  noc__stOp__strm_cntl       ; 
            strm1_data             =  noc__stOp__strm_data       ; 
            strm1_data_valid       =  noc__stOp__strm_data_valid & noc__stOp__strm_id ; // from NoC can be strm0 or 1
          end
        default                       : 
          begin
            strm1_cntl              =  dma__stOp__strm1_cntl       ; 
            strm1_data              =  dma__stOp__strm1_data       ; 
            strm1_data_valid        =  dma__stOp__strm1_data_valid ; 
          end
      endcase // always @
    end

  // Stream 0
  always @(*)
    casex (strm0_destination)  // the strm0_source override the FROM in the operation
// FIXME: using FROM not TO when looking at destination???
      `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY       : 
        begin
          stOp__dma__strm0_ready  =  ~fifo[0].fifo_almost_full ;
        end
      `STREAMING_OP_CNTL_OPERATION_FROM_EXT : 
        begin
          stOp__dma__strm0_ready  = 1'b0                  ;
        end
      `STREAMING_OP_CNTL_OPERATION_FROM_NOC       : 
        begin
          stOp__dma__strm0_ready = noc__stOp__strm_ready ;
        end
      default                       : 
        begin
          stOp__dma__strm0_ready  = 1'b0                  ;
        end
    endcase // always @

  // Stream 1
  always @(*)
    casex (strm1_destination)  // the strm1_source override the FROM in the operation
      `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY       : 
        begin
          stOp__dma__strm1_ready  =  ~fifo[1].fifo_almost_full ;
        end
      `STREAMING_OP_CNTL_OPERATION_FROM_EXT : 
        begin
          stOp__dma__strm1_ready  = 1'b0                  ;
        end
      `STREAMING_OP_CNTL_OPERATION_FROM_NOC       : 
        begin
          stOp__dma__strm1_ready = noc__stOp__strm_ready ;
        end
      default                       : 
        begin
          stOp__dma__strm1_ready  = 1'b0                  ;
        end
    endcase // always @

  always @(*)
    begin
          stOp__noc__strm_ready  = (stOp__noc__strm_id) ? ~fifo[1].fifo_almost_full   : ~fifo[0].fifo_almost_full   ; 
    end

  // we dont fifo the data mask, so capture mask so it can be used when data
  // is pulled from the fifo
  // WARNING: assumes last value read before last value of next stream arives
  always @(posedge clk)
    casex (strm0_source)
      `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY       : 
        begin
          strm0_data_mask   <=  (reset_poweron                                   ) ? 32'd0                      :
                                (dma__stOp__strm0_cntl == `DMA_CONT_STRM_CNTL_EOP) ? dma__stOp__strm0_data_mask :
                                                                                     strm0_data_mask            ;
        end
      `STREAMING_OP_CNTL_OPERATION_FROM_EXT : 
        begin
          strm0_data_mask   <=  (reset_poweron                                   ) ? 32'd0                      :
                                (sti__stOp__strm0_cntl == `DMA_CONT_STRM_CNTL_EOP) ? sti__stOp__strm0_data_mask :
                                                                                     strm0_data_mask            ;
        end
      default                       : 
        begin
          strm0_data_mask   <=  (reset_poweron                            ) ? 32'd0               :
                                (dma__stOp__strm0_cntl == `DMA_CONT_STRM_CNTL_EOP) ? dma__stOp__strm0_data_mask :
                                                                              strm0_data_mask     ;
        end
    endcase // always @

  always @(posedge clk)
    casex (strm1_source)
      `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY       : 
        begin
          strm1_data_mask   <=  (reset_poweron                                   ) ? 32'd0                      :
                                (dma__stOp__strm0_cntl == `DMA_CONT_STRM_CNTL_EOP) ? dma__stOp__strm1_data_mask :
                                                                                     strm1_data_mask            ;
        end
      `STREAMING_OP_CNTL_OPERATION_FROM_EXT : 
        begin
          strm1_data_mask   <=  (reset_poweron                                   ) ? 32'd0                      :
                                (sti__stOp__strm0_cntl == `DMA_CONT_STRM_CNTL_EOP) ? sti__stOp__strm1_data_mask :
                                                                                     strm1_data_mask            ;
        end
      default                       : 
        begin
          strm1_data_mask   <=  (reset_poweron                            ) ? 32'd0               :
                                (dma__stOp__strm0_cntl == `DMA_CONT_STRM_CNTL_EOP) ? dma__stOp__strm1_data_mask :
                                                                              strm1_data_mask     ;
        end
    endcase // always @

  //------------------------------
  // NoC related Signalling
  // 
  // DMA Read Stream
  // The DMA read typically goes to the stOp. But if the memory address of the source happens to be another PE's memory, then the
  // local read stream is available.
  // In which case, another PE may be using this PE's local memory as its source, in which case the DMA read may be used as the source and
  // therefore the dma read stream must be sent to the NoC.
  //
  // stream is spare or the stream comes from another PE, the DMA read stream may be used by
  // another PE as an external DMA. If the destination is NoC, then direct the DMA read stream to the NoC.
  //
  //Also, if a write path is available, it might be used as a
  // Assumption: Only one read stream per lane is allocated for external DMA
  //  i) this means if any one read stream destination is NoC, transfer it
  //  directly to the NoC interface
  //
  //
  always @(posedge clk)
    begin
      //------------------------------
      // Stream 0
      if (strm0_destination == `STREAMING_OP_CNTL_OPERATION_TO_NOC)
        begin
          stOp__noc__strm_cntl        <=  dma__stOp__strm0_cntl        ; 
          stOp__noc__strm_id          <=  1'b0                         ; 
          stOp__noc__strm_data        <=  dma__stOp__strm0_data        ; 
          stOp__noc__strm_data_valid  <=  dma__stOp__strm0_data_valid  ; 
        end
      //------------------------------
      // Stream 1
      else if (strm1_destination == `STREAMING_OP_CNTL_OPERATION_TO_NOC)
        begin
          stOp__noc__strm_cntl        <=  dma__stOp__strm1_cntl        ; 
          stOp__noc__strm_id          <=  1'b1                         ; 
          stOp__noc__strm_data        <=  dma__stOp__strm1_data        ; 
          stOp__noc__strm_data_valid  <=  dma__stOp__strm1_data_valid  ; 
        end
      else 
        begin
          stOp__noc__strm_data        <=   32'hFFFF_FFFF               ;
          stOp__noc__strm_cntl        <=  'd0                          ;
          stOp__noc__strm_id          <=  'd0                          ;
          stOp__noc__strm_data_valid  <=  'b0                          ;
        end
    end
  //
  //------------------------------------------------------------

  // FIFO's
  //
  genvar gvi;
  generate
    for (gvi=0; gvi<2; gvi=gvi+1) 
      begin: fifo
        `STREAMING_OP_INPUT_FIFO
      end
  endgenerate
  
   
  assign     fifo[0].clear              = ~strm0_enable            ;
  assign     strm0_fifo_empty           = fifo[0].fifo_empty       ; 
  assign     fifo[0].fifo_read          = strm0_fifo_read          ; 
  assign     strm0_fifo_read_data       = fifo[0].fifo_read_data   ; 
  assign     strm0_fifo_read_cntl       = fifo[0].fifo_read_cntl   ; 
  assign     fifo[0].data               = strm0_data               ;
  assign     fifo[0].cntl               = strm0_cntl               ;
  assign     fifo[0].fifo_write         = strm0_data_valid         ;  // with FIFO inputs, dont condition write with ready
  assign     strm0_fifo_data_available  = ~strm0_fifo_empty        ;
                                                                      // we need source to stop within two cycles
  assign     fifo[1].clear              = ~strm1_enable            ;
  assign     strm1_fifo_empty           = fifo[1].fifo_empty       ; 
  assign     fifo[1].fifo_read          = strm1_fifo_read          ; 
  assign     strm1_fifo_read_data       = fifo[1].fifo_read_data   ; 
  assign     strm1_fifo_read_cntl       = fifo[1].fifo_read_cntl   ; 
  assign     fifo[1].data               =  strm1_data              ;
  assign     fifo[1].cntl               =  strm1_cntl              ;
  assign     fifo[1].fifo_write         =  strm1_data_valid        ;
  assign     strm1_fifo_data_available  = ~strm1_fifo_empty        ;

  assign     strm_fifo_data_available   = ~strm1_fifo_empty & ~strm0_fifo_empty ;
  assign     strm_fifo_empty            =  strm1_fifo_empty &  strm0_fifo_empty ;

  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Result Control
  //-----------------------------------------------
  // Result/Output Control State register 
  /* FIXME

  reg [`STREAMING_OP_RESULT_STATE_RANGE] so_result_state;          // state flop
  reg [`STREAMING_OP_RESULT_STATE_RANGE] so_result_state_next;
  
  always @(posedge clk)
    begin
      so_result_state <= (reset_poweron ) ? `STREAMING_OP_RESULT_WAIT
                                          : so_result_state_next      ;
    end


  //-------------------------------------------------------------------------------------------
  // Result Control  FSM
  //
  // This FSM controls the streaming operation and when data is sent to the DMA engine.
  // It controls how data is read from the input FIFO.
  // The data is read and provided to the streaming op. If the DMA engine is
  // not ready, this will pause reading from the input FIFO and pause the
  // streaming operation.
  // The data sent to the DMA can be either the result of a streaming Operation on data from
  // the DMA or external interface.
  // It is expected that the DMA engine will give priority to data from the
  // streaming op module because the data may be from the external interface
  // and we do not want to flow control the high bandwidth broadcast bus.
  // The DMA engine controls where the data is sent to in memory, this module
  // provides the data to the DMA engine and the DMA keeps writing until all
  // this module indicates complete..
  //
  always @(*)
    begin
      case (so_result_state)
        `STREAMING_OP_RESULT_WAIT: 
          so_result_state_next = ( ready ) ? `STREAMING_OP_RESULT_ENABLE :
                                             `STREAMING_OP_RESULT_WAIT   ;

        `STREAMING_OP_RESULT_ENABLE: 
          so_result_state_next = ( ready ) ? `STREAMING_OP_RESULT_ENABLE :
                                             `STREAMING_OP_RESULT_WAIT   ;

        
        default:
          so_result_state_next = `STREAMING_OP_RESULT_WAIT;
    
      endcase // case(so_result_state)
    end // always @ (*)

  //-------------------------------------------------------------------------------------------------
  // FSM output equations
  //

  //
  //-------------------------------------------------------------------------------------------------
  // Result output
  //

  end FIXME */

  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------
  // Operations
  //

  //-----------------------------------------------
  // BSUM
  //
  // FIXME: Need to add BSUM sum(arg2) also as an output
  // e.g. output = {sum(a.b), sum(b)} 
  // Used for normalization in the SIMD
  
  reg                                    bsum_s0_valid, bsum_s1_valid, bsum_s2_valid, bsum_s3_valid, bsum_s4_valid ;
  reg [`STREAMING_OP_DATA_RANGE      ]   band       ; 
  reg                                    bsum_and_valid ;
  reg [1:0] bsum_s0_0, bsum_s0_1,  bsum_s0_2,  bsum_s0_3,  bsum_s0_4,  bsum_s0_5,  bsum_s0_6,  bsum_s0_7;
  reg [1:0] bsum_s0_8, bsum_s0_9, bsum_s0_10, bsum_s0_11, bsum_s0_12, bsum_s0_13, bsum_s0_14, bsum_s0_15;
  reg [2:0] bsum_s1_0, bsum_s1_1,  bsum_s1_2,  bsum_s1_3,  bsum_s1_4,  bsum_s1_5,  bsum_s1_6,  bsum_s1_7;
  reg [3:0] bsum_s2_0, bsum_s2_1,  bsum_s2_2,  bsum_s2_3;
  reg [4:0] bsum_s3_0, bsum_s3_1;
  reg [5:0] bsum_s4 ;

  // indicate complete when there is no more source data (e.g. src is complete
  // and fifo is empty) and the pipeline contains no valid data
  wire   bsum_almost_complete  = (strm0_src_complete & strm0_enable & strm1_src_complete & strm1_enable) & (~bsum_and_valid &  ~bsum_s1_valid & ~bsum_s2_valid & ~bsum_s3_valid &  bsum_s4_valid );

  always @(posedge clk)
    begin

      band            <= ( (~strm0_enable & ~strm1_enable) || ~bsum_enable            ) ? 'd0                                                                                                                                                                                                      :
                         ( strm0_fifo_read  && strm1_fifo_read ) ? (strm0_fifo_read_data & (strm0_data_mask | {32{(strm0_fifo_read_cntl!=`DMA_CONT_STRM_CNTL_EOP)}})) & (strm1_fifo_read_data  & (strm1_data_mask | {32{(strm1_fifo_read_cntl!=`DMA_CONT_STRM_CNTL_EOP)}})) :
                                                                   'd0                                                                                                                                                                                                      ;
      bsum_and_valid  <= ( (~strm0_enable & ~strm1_enable) || ~bsum_enable            ) ? 'd0                                   :
                                                                   ( strm0_fifo_read  & strm1_fifo_read );

      // reduce stage 0
      bsum_s0_valid  <=  ( (~strm0_enable & ~strm1_enable)     ) ? 'd0              :
                                            bsum_and_valid   ;
      bsum_s0_0      <= band[1 ] + band[0 ];
      bsum_s0_1      <= band[3 ] + band[2 ];
      bsum_s0_2      <= band[5 ] + band[4 ];
      bsum_s0_3      <= band[7 ] + band[6 ];
      bsum_s0_4      <= band[9 ] + band[8 ];
      bsum_s0_5      <= band[11] + band[10];
      bsum_s0_6      <= band[13] + band[12];
      bsum_s0_7      <= band[15] + band[14];
      bsum_s0_8      <= band[17] + band[16];
      bsum_s0_9      <= band[19] + band[18];
      bsum_s0_10     <= band[21] + band[20];
      bsum_s0_11     <= band[23] + band[22];
      bsum_s0_12     <= band[25] + band[24];
      bsum_s0_13     <= band[27] + band[26];
      bsum_s0_14     <= band[29] + band[28];
      bsum_s0_15     <= band[31] + band[30];
      // reduce stage 1
      bsum_s1_valid  <= ( (~strm0_enable & ~strm1_enable)    ) ? 'd0             :
                                          bsum_s0_valid   ;
      bsum_s1_0      <= bsum_s0_1  + bsum_s0_0 ;
      bsum_s1_1      <= bsum_s0_3  + bsum_s0_2 ;
      bsum_s1_2      <= bsum_s0_5  + bsum_s0_4 ;
      bsum_s1_3      <= bsum_s0_7  + bsum_s0_6 ;
      bsum_s1_4      <= bsum_s0_9  + bsum_s0_8 ;
      bsum_s1_5      <= bsum_s0_11 + bsum_s0_10;
      bsum_s1_6      <= bsum_s0_13 + bsum_s0_12;
      bsum_s1_7      <= bsum_s0_15 + bsum_s0_14;
      // reduce stage 2
      bsum_s2_valid  <= (~strm0_enable && ~strm1_enable) ? 'd0             :
                                                            bsum_s1_valid  ;
      bsum_s2_0      <= bsum_s1_1  + bsum_s1_0 ;
      bsum_s2_1      <= bsum_s1_3  + bsum_s1_2 ;
      bsum_s2_2      <= bsum_s1_5  + bsum_s1_4 ;
      bsum_s2_3      <= bsum_s1_7  + bsum_s1_6 ;
      // reduce stage 3
      bsum_s3_valid  <= (~strm0_enable && ~strm1_enable) ? 'd0             :
                                                            bsum_s2_valid  ;
      bsum_s3_0      <= bsum_s2_1  + bsum_s2_0 ;
      bsum_s3_1      <= bsum_s2_3  + bsum_s2_2 ;
      // reduce stage 4
      bsum_s4_valid  <= ( ~strm0_enable && ~strm1_enable) ? 'd0             :
                                                             bsum_s3_valid  ;
      bsum_s4        <= bsum_s3_1  + bsum_s3_0 ;

      bsum           <= (~strm0_enable && ~strm1_enable) ? 'd0             : 
                                                            bsum + bsum_s4 ;

      bsum_complete  <= (~strm0_enable && ~strm1_enable) ? 1'b0           :
                        ( bsum_almost_complete         ) ? 1'b1           :  // when the bsum operation input has completed, flush the pipe then wait
                                                           bsum_complete  ;

      bsum_result_valid  <= ( (~strm0_enable & ~strm1_enable) ) ? 'd0                     :
                                                                     bsum_almost_complete ;

    end

  //-----------------------------------------------
  // Floating Point MAC
  //
  // Note: Currently using DW FP_MAC to improve accuracy rather than
  // a MULT/ADD combo which will incur accuracy degradation because of
  // rounding ??
  //
  // 32-bit
  parameter sig_width = 23;
  parameter exp_width = 8;
  parameter ieee_compliance = 1;

  reg  [sig_width+exp_width : 0] fp_mac_a           ;
  reg  [sig_width+exp_width : 0] fp_mac_b           ;
  reg  [sig_width+exp_width : 0] fp_mac_c           ;
  reg  [2 : 0]                   fp_mac_rnd         ;
  reg  [sig_width+exp_width : 0] fp_mac_z_s0        ;   // pipelines to improve timing
  reg  [sig_width+exp_width : 0] fp_mac_z_s1        ; 
  reg  [sig_width+exp_width : 0] fp_mac_z_s2        ; 
  wire [sig_width+exp_width : 0] fp_mac_z_next      ;
  reg                            fp_mac_input_valid,  fp_mac_z_s0_valid,  fp_mac_z_s1_valid,  fp_mac_z_s2_valid; 
  reg                               fp_mac_fb_valid, fp_mac_fb_s0_valid, fp_mac_fb_s1_valid, fp_mac_fb_s2_valid; 
  reg  [sig_width+exp_width : 0] fp_mac_flush_s0    ;   // start flushing pipeline into holding registers once MAC has completed
  reg  [sig_width+exp_width : 0] fp_mac_flush_s1    ;   // start flushing pipeline into holding registers once MAC has completed
  reg  [sig_width+exp_width : 0] fp_mac_flush_s2    ;   // start flushing pipeline into holding registers once MAC has completed
  reg                            fp_mac_flush_s0_valid, fp_mac_flush_s1_valid, fp_mac_flush_s2_valid; 
  reg                            fp_mac_start_flush, fp_mac_start_flush_s0, fp_mac_start_flush_s1, fp_mac_start_flush_s2;
  wire                           fp_mac_first_flush_complete  ;
  reg                            fp_mac_first_flush_complete_d1  ;
  reg                            fp_mac_done_first_flush_summation,   fp_mac_done_first_flush_summation_d1  ;
  reg                            fp_mac_done_second_flush_summation,  fp_mac_done_second_flush_summation_d1 ;
// FIXME : keep for more stages  reg                            fp_mac_done_third_flush_summation,  fp_mac_done_third_flush_summation_d1 ;

  reg  [7 : 0]                   fp_mac_status_s0   ;
  reg  [7 : 0]                   fp_mac_status_s1   ;
  reg  [7 : 0]                   fp_mac_status_s2   ;
  reg  [7 : 0]                   fp_mac_status      ;
  wire [7 : 0]                   fp_mac_status_next ;

//
// For more pipeline stages, change first to second etc.
  wire   fp_mac_almost_complete  = fp_mac_done_second_flush_summation_d1 & fp_mac_fb_s2_valid ;  // 2nd flush summation is done using fb valid
// FIXME : keep for more stages wire   fp_mac_almost_complete  = src_complete & fp_mac_done_third_flush_summation_d1 & fp_mac_fb_s2_valid ;  // 

  always @(posedge clk)
    begin
      fp_mac_input_valid  <= ( (~strm0_enable & ~strm1_enable) || ~fp_mac_enable ) ? 'd0                                    :
                                                              ( strm0_fifo_read  & strm1_fifo_read ) ;
      fp_mac_fb_valid  <= ( (~strm0_enable & ~strm1_enable)          || ~fp_mac_enable                                                                ) ? 'b0   :
                          ( fp_mac_z_s2_valid && ~fp_mac_start_flush                                                           ) ? 'b1   :  // need to let feedback flush the pipe
                          ( fp_mac_fb_s2_valid && ~fp_mac_start_flush                                                          ) ? 'b1   :  // need to let feedback flush the pipe
                          ( fp_mac_first_flush_complete        & ~fp_mac_first_flush_complete_d1                               ) ? 'b1   :  // validate flush summations using feedback valid
                          ( fp_mac_done_first_flush_summation  & ~fp_mac_done_first_flush_summation_d1                         ) ? 'b1   :  // 2nd flush summation validated using fb valid
                          ( fp_mac_done_second_flush_summation & ~fp_mac_done_second_flush_summation_d1                        ) ? 'b1   :  // 2nd flush summation validated using fb valid
// FIXME: keep for more stages                          ( fp_mac_done_third_flush_summation  & ~fp_mac_done_third_flush_summation_d1                         ) ? 'b1   :
                                                                                                                                   'b0   ;  // 2nd flush summation validated using fb valid
      // We will keep track of valid pipeline entries by tracking valid inputs from the FIFO or valid inputs from the feedback.
      // We need to allow the pipeline to continue rotating even if there are no valid entries in the FIFO. Could do this with one valid signal but having separate makes things a bit clearer.

      // MAC input stage
      fp_mac_a           <= ( (~strm0_enable & ~strm1_enable) || ~fp_mac_enable   ) ? 'd0                   :
                            ( strm0_fifo_read              ) ?  strm0_fifo_read_data :
                            ( fp_mac_first_flush_complete  ) ? `COMMON_IEEE754_FLOAT_ONE  :
                                                               `COMMON_IEEE754_FLOAT_ZERO ;
      fp_mac_b           <= ( (~strm0_enable & ~strm1_enable) || ~fp_mac_enable                                                                      ) ? 'd0                        :
                            ( strm1_fifo_read                                                                                 ) ? strm1_fifo_read_data       :  // Normal mac
                            ( fp_mac_first_flush_complete        && ~fp_mac_done_first_flush_summation  && fp_mac_fb_s2_valid ) ? fp_mac_z_s2                :  // 1st flush summation is z_s2 and flush_s0
                            ( fp_mac_done_first_flush_summation  && ~fp_mac_done_second_flush_summation && fp_mac_fb_s2_valid ) ? fp_mac_z_s2                :  // 2nd flush summation is z_s2 and flush_s1
                            ( fp_mac_done_second_flush_summation &&                                        fp_mac_fb_s2_valid ) ? fp_mac_z_s2                :  // 3rd flush summation is z_s2 and flush_s2
// FIXME : keep for more stages                            ( fp_mac_done_second_flush_summation && ~fp_mac_done_third_flush_summation  && fp_mac_fb_s2_valid ) ? fp_mac_z_s2                :  // 3rd flush summation is z_s2 and flush_s2
                                                                                                                                  `COMMON_IEEE754_FLOAT_ZERO ;

      fp_mac_c           <= ( fp_mac_z_s2_valid                                                                                  ) ? fp_mac_z_s2                :  // Normal mac
                            ( fp_mac_fb_s2_valid                 && ~fp_mac_first_flush_complete                                 ) ? fp_mac_z_s2                :  // normal mac
                            ( fp_mac_first_flush_complete        && ~fp_mac_done_first_flush_summation  && fp_mac_flush_s0_valid ) ? fp_mac_flush_s0            :  // 1st flush summation is z_s2 and flush_s0
                            ( fp_mac_done_first_flush_summation  && ~fp_mac_done_second_flush_summation && fp_mac_flush_s1_valid ) ? fp_mac_flush_s1            :  // 2nd flush summation is z_s2 and flush_s1
                            ( fp_mac_done_second_flush_summation &&                                        fp_mac_flush_s2_valid ) ? fp_mac_flush_s2            :  // 3rd flush summation is z_s2 and flush_s2
// FIXME : keep for more stages                            ( fp_mac_done_second_flush_summation && ~fp_mac_done_third_flush_summation  && fp_mac_fb_s2_valid ) ? fp_mac_flush_s2            :  // 3rd flush summation is z_s2 and flush_s2
                                                                                                                                  `COMMON_IEEE754_FLOAT_ZERO ;  // we arent clearing pipeline stages so ensure feedback is zero

      // Flush Status:
      // When performing the final summation of values in the pipeline, we will multiplex the pipeline values onto the inputs of the MAC
      // We will set input a=1 and put each pipeline value onto b and c. Initially we will put two values onto b and c then use the fb_valid
      // to indicate the accumulated output can be used to sum to the remaining pipeline values
      // We have flushed the potentially 4 values in the pipeline into fp_mac_flush{0..2} and fp_mac_z_s2 
      // The state of each of these fluahed values is declared in fp_mac_flush_{0..2}_valid and fp_mac_fb_s2_valid 
      //
      //
      //-----------------------------------------------------------------------------------------------
      //Pipeline
      //
      // MAC output stage 0
      fp_mac_z_s0        <=                                     fp_mac_z_next        ;
      fp_mac_status_s0   <=                                     fp_mac_status_next   ;

      fp_mac_z_s0_valid  <= ( (~strm0_enable & ~strm1_enable)                                                         ) ? 'b0                 :
                                                                                                   fp_mac_input_valid ;
      fp_mac_fb_s0_valid <= ( (~strm0_enable & ~strm1_enable)                     ) ? 'd0                   :
                                                                fp_mac_fb_valid      ;

      // MAC output stage 1                                                         
      fp_mac_z_s1        <=                                     fp_mac_z_s0          ;
      fp_mac_status_s1   <=                                     fp_mac_status_s0     ;
      fp_mac_z_s1_valid  <= ( (~strm0_enable & ~strm1_enable)                     ) ? 'd0                   :
                                                                fp_mac_z_s0_valid    ;
      fp_mac_fb_s1_valid <= ( (~strm0_enable & ~strm1_enable)                     ) ? 'd0                   :
                                                                fp_mac_fb_s0_valid   ;
      // MAC output stage 2                                                        
      fp_mac_z_s2        <=                                     fp_mac_z_s1          ;
      fp_mac_status_s2   <=                                     fp_mac_status_s1     ;
      fp_mac_z_s2_valid  <= ( (~strm0_enable & ~strm1_enable)                     ) ? 'd0                   :
                                                                fp_mac_z_s1_valid    ;
      fp_mac_fb_s2_valid <= ( (~strm0_enable & ~strm1_enable)                     ) ? 'd0                   :
                                                                fp_mac_fb_s1_valid   ;
      // MAC output stage 3                                                        
      fp_mac             <=                                     fp_mac_z_s2          ;
      fp_mac_status      <=                                     fp_mac_status_s2     ;
      fp_mac_complete    <= ( (~strm0_enable & ~strm1_enable)                     ) ? 1'b0                  :
                            ( fp_mac_almost_complete       ) ? 1'b1                  :  // when the fp_mac operation input has completed, flush the pipe then wait
                                                                fp_mac_complete      ;
      fp_mac_start_flush  <= ( (~strm0_enable & ~strm1_enable)                 ) ? 1'b0                  :
                                                            (strm0_src_complete & strm0_enable & strm1_src_complete & strm1_enable);
      //-------------------------------------------------------------------------------------------
      // Flush the pipeline - when we are done, we latch the flushed values
      // and their valid state
      //
      // MAC Flush stage 0                                                        
      fp_mac_start_flush_s0  <= ( (~strm0_enable & ~strm1_enable)                 ) ? 1'b0                  :
                                                               fp_mac_start_flush ;
      fp_mac_flush_s0        <= ( fp_mac_first_flush_complete ) ? fp_mac_flush_s0 :  // latch when flush complete
                                ( fp_mac_start_flush && fp_mac_z_s2_valid      ) ?  fp_mac_z_s2          :
                                ( fp_mac_start_flush && fp_mac_fb_s2_valid     ) ?  fp_mac_z_s2          :
                                                                                    `COMMON_IEEE754_FLOAT_ZERO      ;
      fp_mac_flush_s0_valid  <= ( fp_mac_first_flush_complete ) ? fp_mac_flush_s0_valid :  // latch when flush complete
                                                                 ( fp_mac_start_flush && fp_mac_z_s2_valid  ) || ( fp_mac_start_flush && fp_mac_fb_s2_valid ) ;

      // MAC Flush stage 1                                                        
      fp_mac_start_flush_s1  <= ( (~strm0_enable & ~strm1_enable)                 ) ? 1'b0                  :
                                                               fp_mac_start_flush_s0 ;

      fp_mac_flush_s1        <= ( fp_mac_first_flush_complete ) ? fp_mac_flush_s1            :  // latch when flush complete
                                ( fp_mac_flush_s0_valid       ) ? fp_mac_flush_s0            :
                                                                  `COMMON_IEEE754_FLOAT_ZERO ;

      fp_mac_flush_s1_valid  <= ( (~strm0_enable & ~strm1_enable)                    ) ? 'd0                   :
                                ( fp_mac_first_flush_complete ) ? fp_mac_flush_s1_valid :  // latch when flush complete
                                                                  fp_mac_flush_s0_valid ;
      // MAC Flush stage 2                                                        
      fp_mac_start_flush_s2  <= ( (~strm0_enable & ~strm1_enable)                 ) ? 1'b0                  :
                                                               fp_mac_start_flush_s1 ;

      fp_mac_flush_s2        <= ( fp_mac_first_flush_complete ) ? fp_mac_flush_s2             :  // latch when flush complete
                                ( fp_mac_flush_s1_valid       ) ? fp_mac_flush_s1             :
                                                                  `COMMON_IEEE754_FLOAT_ZERO  ;

      fp_mac_flush_s2_valid  <= ( (~strm0_enable & ~strm1_enable)                    ) ? 'd0                   :
                                ( fp_mac_first_flush_complete ) ? fp_mac_flush_s2_valid :  // latch when flush complete
                                                                  fp_mac_flush_s1_valid ;

      fp_mac_done_first_flush_summation     <= ( (~strm0_enable & ~strm1_enable)                           ) ? 'd0                                                        :
                                               ( fp_mac_done_first_flush_summation  ) ? 'b1                                                        :
                                                                                        (fp_mac_fb_s1_valid &  fp_mac_first_flush_complete)        ;
      // Use this to create a pulse to track the second valid flushed summation thru the pipeline
      fp_mac_done_first_flush_summation_d1  <= ( (~strm0_enable & ~strm1_enable)                           ) ? 'd0                                                        :
                                                                                        fp_mac_done_first_flush_summation                          ;
                                                                                                                                                   
      fp_mac_done_second_flush_summation    <= ( (~strm0_enable & ~strm1_enable)                           ) ? 'd0                                                        :
                                               ( fp_mac_done_second_flush_summation ) ? 'b1                                                        :
                                                                                        (fp_mac_fb_s1_valid &  fp_mac_done_first_flush_summation)  ;
      // Use this to create a pulse to track the third valid flushed summation thru the pipeline
      fp_mac_done_second_flush_summation_d1 <= ( (~strm0_enable & ~strm1_enable)                           ) ? 'd0                                                        :
                                                                                         fp_mac_done_second_flush_summation                        ;
                                                                                                                                                   
/* FIXME : Keep for more stages
      fp_mac_done_third_flush_summation     <= ( (~strm0_enable & ~strm1_enable)                           ) ? 'd0                                                        :
                                               ( fp_mac_done_third_flush_summation  ) ? 'b1                                                        :
                                                                                        (fp_mac_fb_s1_valid &  fp_mac_done_second_flush_summation) ;
      fp_mac_done_third_flush_summation_d1  <= ( (~strm0_enable & ~strm1_enable)                           ) ? 'd0                                                        :
                                                                                         fp_mac_done_third_flush_summation                         ;
*/

      // When we have flushed all pipeline stages, use this to create a pulse
      // to track first valid flushed summation thru the pipeline
      fp_mac_first_flush_complete_d1  <= ( (~strm0_enable & ~strm1_enable)       ) ? 'd0                         :
                                                              fp_mac_first_flush_complete ;

      fp_mac_result_valid  <= ( (~strm0_enable & ~strm1_enable) ) ? 'd0                     :
                                                                     fp_mac_almost_complete ;

      fp_mac_rnd      <= 3'b000  ; // FIXME
    end

  // At this point we have flushed the potentially 4 values in the pipeline into
  // fp_mac_flush{0..2} and fp_mac_z_s2 
  // The state of each of these fluahed values is declared in fp_mac_flush_{0..2}_valid and fp_mac_fb_s2_valid 
  assign  fp_mac_first_flush_complete = fp_mac_start_flush_s2 ;  // create a pulse for first flush complete

`ifdef JOSHS_FP
    fp_mac   fp_mac_inst   ( 
                  .a_in     ( fp_mac_a             ), 
                  .b_in     ( fp_mac_b             ), 
                  .c_in     ( fp_mac_c             ), 
                  .reset    ( ~(~strm0_enable & ~strm1_enable)            ), 
                  .result   ( fp_mac_z_next        ));
    assign fp_mac_status_next = 'd0;
`else
// FIXME
    // `ifndef SYNTHESIS  
    // Instance of DW_fp_fp_mac
    DW_fp_mac  #(sig_width, 
                 exp_width, 
                 ieee_compliance)
    DW_fp_mac   ( .a     ( fp_mac_a             ), 
                  .b     ( fp_mac_b             ), 
                  .c     ( fp_mac_c             ), 
                  .rnd   ( fp_mac_rnd           ), 
                  .z     ( fp_mac_z_next        ), 
                  .status( fp_mac_status_next   ));
  //`else
    // FIXME
    //assign fp_mac_z_next      = 'd0;
    //assign fp_mac_status_next = 'd0;
  //`endif
`endif


  //-----------------------------------------------
  // Floating Point Compare
  //
  // Mode a) Find maximum (or minimum) and return index
  //      b) Find first element to exceed a reference and return index
  //
  reg  [`STREAMING_OP_FP_RANGE   ] fp_cmp_curr                     ;
  wire [`STREAMING_OP_FP_RANGE   ] fp_cmp_curr_next                ;
  reg  [`STREAMING_OP_INDEX_RANGE] fp_cmp_curr_index               ;  // current "winner"
  wire [`STREAMING_OP_INDEX_RANGE] fp_cmp_curr_index_next          ;

  reg  [sig_width+exp_width : 0] fp_cmp_a           ;
  reg  [sig_width+exp_width : 0] fp_cmp_b           ;
  wire                           fp_cmp_aeqb_next, fp_cmp_altb_next, fp_cmp_agtb_next ;
  reg                            fp_cmp_aeqb     , fp_cmp_altb     , fp_cmp_agtb      ;
  reg                            fp_cmp_aeqb_s0  , fp_cmp_altb_s0  , fp_cmp_agtb_s0   ;
  reg                            fp_cmp_aeqb_s1  , fp_cmp_altb_s1  , fp_cmp_agtb_s1   ;
  reg                            fp_cmp_aeqb_s2  , fp_cmp_altb_s2  , fp_cmp_agtb_s2   ;

  reg                            fp_cmp_input_a_valid, fp_cmp_input_b_valid, fp_cmp_s0_valid, fp_cmp_s1_valid, fp_cmp_s2_valid ;
  reg                            fp_cmp_found_first      ;  // use to "latch" the state of an operation
  wire                           set_fp_cmp_found_first  ;  // for example, with "first gt, we latch the first index to exceed a threshold
                                                            // but allow flushing of the fifo(s)
  reg  [7 : 0]                   fp_cmp_status0_s0, fp_cmp_status0_s1, fp_cmp_status0_s2   ;
  reg  [7 : 0]                   fp_cmp_status1_s0, fp_cmp_status1_s1, fp_cmp_status1_s2   ;

  reg  [7 : 0]                   fp_cmp_status0      ;
  wire [7 : 0]                   fp_cmp_status0_next ;
  reg  [7 : 0]                   fp_cmp_status1      ;
  wire [7 : 0]                   fp_cmp_status1_next ;

  wire   fp_cmp_almost_complete  = ((fp_cmp_max & strm0_src_complete) | (fp_cmp_first_gt_threshold & (strm0_src_complete & strm0_enable & strm1_src_complete & strm1_enable))) &  // max uses one stream, first_gt uses two
                                   (~fp_cmp_input_a_valid & ~fp_cmp_input_b_valid & ~fp_cmp_s0_valid  & ~fp_cmp_s1_valid  & fp_cmp_s2_valid ) ;  // finished with stream complete and last transaction at end of pipeline

  always @(posedge clk)
    begin
      fp_cmp_input_a_valid  <= ( (~strm0_enable & ~strm1_enable) || ~fp_cmp_enable ) ? 'd0                 :
                                                                ( strm0_fifo_read ) ;

      fp_cmp_input_b_valid  <= ( (~strm0_enable & ~strm1_enable) || ~fp_cmp_enable ) ? 'd0                 :
                                                                ( strm1_fifo_read ) ;

      // CMP input stage
      fp_cmp_a           <= ( (~strm0_enable & ~strm1_enable) || ~fp_cmp_enable   ) ? 'd0                   :
                            ( strm0_fifo_read              ) ?  strm0_fifo_read_data :
                                                               'd0                   ;
      fp_cmp_b           <= ( (~strm0_enable & ~strm1_enable) || ~fp_cmp_enable   ) ? 'd0                   :
                            ( strm1_fifo_read              ) ?  strm1_fifo_read_data :  // some cmp operations, like "first gt" load a threshold from the b-stream
                            ( fp_cmp_max || fp_cmp_min     ) ?  fp_cmp_curr_next     : 
                                                                fp_cmp_b             ;
      // MAC output stage 0
      fp_cmp_aeqb_s0     <=                                     fp_cmp_aeqb_next     ;
      fp_cmp_altb_s0     <=                                     fp_cmp_altb_next     ;
      fp_cmp_agtb_s0     <=                                     fp_cmp_agtb_next     ;
      fp_cmp_status0_s0  <=                                     fp_cmp_status0_next  ;
      fp_cmp_status1_s0  <=                                     fp_cmp_status1_next  ;
      fp_cmp_s0_valid    <= ( (~strm0_enable & ~strm1_enable)                     ) ? 'b0                   :
                                                                fp_cmp_input_a_valid ;
      // MAC output stage 1                                                         
      fp_cmp_aeqb_s1     <=                                     fp_cmp_aeqb_s0       ;
      fp_cmp_altb_s1     <=                                     fp_cmp_altb_s0       ;
      fp_cmp_agtb_s1     <=                                     fp_cmp_agtb_s0       ;
      fp_cmp_status0_s1  <=                                     fp_cmp_status0_s0    ;
      fp_cmp_status1_s1  <=                                     fp_cmp_status1_s0    ;
      fp_cmp_s1_valid    <= ( (~strm0_enable & ~strm1_enable)                     ) ? 'b0                   :
                                                                fp_cmp_s0_valid      ;

      // MAC output stage 2                                                         
      fp_cmp_aeqb_s2     <=                                     fp_cmp_aeqb_s1       ;
      fp_cmp_altb_s2     <=                                     fp_cmp_altb_s1       ;
      fp_cmp_agtb_s2     <=                                     fp_cmp_agtb_s1       ;
      fp_cmp_status0_s2  <=                                     fp_cmp_status0_s1    ;
      fp_cmp_status1_s2  <=                                     fp_cmp_status1_s1    ;
      fp_cmp_s2_valid    <= ( (~strm0_enable & ~strm1_enable)                     ) ? 'b0                   :
                                                                fp_cmp_s1_valid      ;

      // MAC output stage 3                                                         
      fp_cmp_aeqb        <=                                     fp_cmp_aeqb_s2       ;
      fp_cmp_altb        <=                                     fp_cmp_altb_s2       ;
      fp_cmp_agtb        <=                                     fp_cmp_agtb_s2       ;
      fp_cmp_status0     <=                                     fp_cmp_status0_s2    ;
      fp_cmp_status1     <=                                     fp_cmp_status1_s2    ;
      fp_cmp_complete    <= ( ~strm0_enable & ~strm1_enable ) ? 'b0                  :
                            ( fp_cmp_almost_complete        ) ? 'b1                  :
                                                                fp_cmp_complete      ;

      fp_cmp             <=                                     fp_cmp_curr_index    ;

    end


`ifdef JOSHS_FP
    fp_compare fp_compare_inst   ( 
                  // Inputs
                  .a_in             ( fp_cmp_a             ), 
                  .b_in             ( fp_cmp_b             ), 
                  // Outputs
                  .A_eq_B          ( fp_cmp_aeqb_next     ), 
                  .A_lt_B          ( fp_cmp_altb_next     ), 
                  .A_gt_B          ( fp_cmp_agtb_next     ),
                  .A_lt_eq_B       (                      ),
                  .A_gt_eq_B       (                      ));


  assign  fp_cmp_status0_next = 'd0;
  assign  fp_cmp_status1_next = 'd0;

`else
// FIXME
//`ifndef SYNTHESIS  
    // Instance of DW_fp_fp_cmp
    // FIXME - DG version causes synthesis issues (three-state issues ???)
    //DW_fp_cmp_DG  #(sig_width, 
    DW_fp_cmp  #(sig_width, 
                    exp_width, 
                    ieee_compliance)
    DW_fp_cmp   ( 
                  // Inputs
                  .a             ( fp_cmp_a             ), 
                  .b             ( fp_cmp_b             ), 
                  .zctr          ( 1'b1                 ),   // z0 - max, z1 - min
//                  .DG_ctrl       ( 1'b1                 ),   // 1 - normal, 0 - datapath gating
                  // Outputs
                  .aeqb          ( fp_cmp_aeqb_next     ), 
                  .altb          ( fp_cmp_altb_next     ), 
                  .agtb          ( fp_cmp_agtb_next     ), 
                  .unordered     (                      ),   // FIXME
                  .z0            (                      ),   // FIXME 
                  .z1            (                      ),   // FIXME 
                  .status0       ( fp_cmp_status0_next  ),
                  .status1       ( fp_cmp_status1_next  ));
//`endif
`endif
  //-----------------------------------------------
  // FP Compare Control State register 

  always @(posedge clk)
    begin
      so_cmp_state <= (reset_poweron ) ? `STREAMING_OP_FP_CMP_STATE_WAIT
                                        : so_cmp_state_next      ;
    end

  //-------------------------------------------------------------------------------------------
  // FP Compare Control  FSM
  //
  always @(*)
    begin
      case (so_cmp_state)
        `STREAMING_OP_FP_CMP_STATE_WAIT: 
          so_cmp_state_next = ( fp_cmp_enable &&  fp_cmp_min                ) ? `STREAMING_OP_FP_CMP_STATE_COMPARING_MIN     :
                              ( fp_cmp_enable &&  fp_cmp_max                ) ? `STREAMING_OP_FP_CMP_STATE_COMPARING_MAX     :
                              ( fp_cmp_enable &&  fp_cmp_first_gt_threshold ) ? `STREAMING_OP_FP_CMP_STATE_LOADING_THRESHOLD :
                                                                                `STREAMING_OP_FP_CMP_STATE_WAIT              ;

        `STREAMING_OP_FP_CMP_STATE_COMPARING_MIN: 
          so_cmp_state_next = ( fp_cmp_complete ) ? `STREAMING_OP_FP_CMP_STATE_COMPLETE       :
                                                    `STREAMING_OP_FP_CMP_STATE_COMPARING_MIN  ;

        `STREAMING_OP_FP_CMP_STATE_COMPARING_MAX: 
          so_cmp_state_next = ( fp_cmp_complete ) ? `STREAMING_OP_FP_CMP_STATE_COMPLETE       :
                                                    `STREAMING_OP_FP_CMP_STATE_COMPARING_MAX  ;

        `STREAMING_OP_FP_CMP_STATE_LOADING_THRESHOLD: 
          so_cmp_state_next = ( strm1_fifo_read ) ? `STREAMING_OP_FP_CMP_STATE_FINDING_FIRST_GT   :
                                                    `STREAMING_OP_FP_CMP_STATE_LOADING_THRESHOLD  ;

        `STREAMING_OP_FP_CMP_STATE_FINDING_FIRST_GT: 
          so_cmp_state_next = ( fp_cmp_complete ) ? `STREAMING_OP_FP_CMP_STATE_COMPLETE       :
                                                    `STREAMING_OP_FP_CMP_STATE_FINDING_FIRST_GT  ;

        `STREAMING_OP_FP_CMP_STATE_COMPLETE:
          so_cmp_state_next = ( fp_cmp_enable ) ? `STREAMING_OP_FP_CMP_STATE_COMPLETE     :
                                                  `STREAMING_OP_FP_CMP_STATE_WAIT         ;
        
        default:
          so_cmp_state_next = `STREAMING_OP_FP_CMP_STATE_WAIT;
    
      endcase // case(so_cmp_state)
    end // always @ (*)

  //-------------------------------------------------------------------------------------------------
  // Internal equations
  //
  //
  //
  reg  [`STREAMING_OP_INDEX_RANGE] fp_cmp_index_count              ;  // count number of comparisons
  wire [`STREAMING_OP_INDEX_RANGE] fp_cmp_index_count_next         ; 

  wire  fp_cmp_choose_curr   = 1'b1 ; // FIXME - choose a based on equal - use input RV

  
  //-------------------------------------------------------------------------------------------------
  // output equations
  //
  assign fp_cmp_index_count_next  =  ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MIN    ) && fp_cmp_input_a_valid) ? fp_cmp_index_count + 'd1 :
                                     ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MAX    ) && fp_cmp_input_a_valid) ? fp_cmp_index_count + 'd1 :
                                     ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_FINDING_FIRST_GT ) && fp_cmp_input_a_valid) ? fp_cmp_index_count + 'd1 :
                                                                                                                                fp_cmp_index_count       ;
  // FIXME: Not using piped stages (yet)
  // b - current max, a - next element
  assign fp_cmp_curr_next        =  ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MAX    ) && fp_cmp_input_a_valid && fp_cmp_agtb_next                        ) ? fp_cmp_a           :
                                    ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MAX    ) && fp_cmp_input_a_valid && fp_cmp_aeqb_next && ~fp_cmp_choose_curr ) ? fp_cmp_a           :
                                    ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MIN    ) && fp_cmp_input_a_valid && fp_cmp_altb_next                        ) ? fp_cmp_a           :
                                    ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MIN    ) && fp_cmp_input_a_valid && fp_cmp_aeqb_next && ~fp_cmp_choose_curr ) ? fp_cmp_a           :
                                    ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_FINDING_FIRST_GT ) && fp_cmp_input_a_valid && fp_cmp_agtb_next && ~fp_cmp_found_first ) ? fp_cmp_a           :
                                                                                                                                                                         fp_cmp_curr        ;

  assign fp_cmp_curr_index_next  =  ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MAX    ) && fp_cmp_input_a_valid && fp_cmp_agtb_next                        ) ? fp_cmp_index_count :
                                    ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MAX    ) && fp_cmp_input_a_valid && fp_cmp_aeqb_next && ~fp_cmp_choose_curr ) ? fp_cmp_index_count :
                                    ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MIN    ) && fp_cmp_input_a_valid && fp_cmp_altb_next                        ) ? fp_cmp_index_count :
                                    ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_COMPARING_MIN    ) && fp_cmp_input_a_valid && fp_cmp_aeqb_next && ~fp_cmp_choose_curr ) ? fp_cmp_index_count :
                                    ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_FINDING_FIRST_GT ) && fp_cmp_input_a_valid && fp_cmp_agtb_next && ~fp_cmp_found_first ) ? fp_cmp_index_count :
                                                                                                                                                                         fp_cmp_curr_index  ;

  assign set_fp_cmp_found_first   =  ((so_cmp_state == `STREAMING_OP_FP_CMP_STATE_FINDING_FIRST_GT ) && fp_cmp_input_a_valid && fp_cmp_agtb_next && ~fp_cmp_found_first );

  always @(posedge clk)
    begin
      fp_cmp_index_count  <= ( reset_poweron    ) ? 'd0                      : 
                             ( (~strm0_enable & ~strm1_enable)         ) ? 'd0                      :
                                                     fp_cmp_index_count_next ;

      fp_cmp_curr         <= ( reset_poweron            ) ? 'd0                             : 
                             ( (~strm0_enable & ~strm1_enable) &&  fp_cmp_max  ) ? `COMMON_IEEE754_FLOAT_ZERO      :
                             ( (~strm0_enable & ~strm1_enable) && ~fp_cmp_max  ) ? `COMMON_IEEE754_FLOAT_INFINITY  :
                                                            fp_cmp_curr_next                ;

      fp_cmp_curr_index   <= ( reset_poweron            ) ? 'd0                             : 
                             ( (~strm0_enable & ~strm1_enable)                 ) ? `COMMON_INT_MAX                 :
                                                            fp_cmp_curr_index_next          ;

      fp_cmp_found_first  <= ( reset_poweron          ) ? 'd0                 : 
                             ( (~strm0_enable & ~strm1_enable)               ) ? 'd0                 :
                             ( set_fp_cmp_found_first ) ? 'd1                 :
                                                           fp_cmp_found_first ;


      fp_cmp_result_valid  <= ( (~strm0_enable & ~strm1_enable) ) ? 'd0                     :
                                                                     fp_cmp_almost_complete ;
    end
  //-------------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------
   
endmodule

