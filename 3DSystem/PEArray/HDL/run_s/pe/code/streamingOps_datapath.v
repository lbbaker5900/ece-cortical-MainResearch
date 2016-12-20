/*********************************************************************************************

    File name   : streamingOps_datapath.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor processing engine.
                  It instantiates the DMA engine and the Streaming processor.
                  This module i  turn will be instantiated once for every execution lane.

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "pe_array.vh"
`include "pe.vh"

module streamingOps_datapath (
            clk              ,
            reset_poweron    ,

            //---------------------------------------------------------------
            // Main Streaming Interface(s)
           
            //-------------------------------
            // NoC interface (via stop_cntl)

            // to NoC
            stOp__noc__strm_ready       ,
            noc__stOp__strm_cntl        , 
            noc__stOp__strm_id          , 
            noc__stOp__strm_data        , 
            noc__stOp__strm_data_valid  , 
            // from NoC
            noc__stOp__strm_ready       ,
            stOp__noc__strm_cntl        , 
            stOp__noc__strm_id          , 
            stOp__noc__strm_data        , 
            stOp__noc__strm_data_valid  , 

            //-------------------------------
            // Downstream from Stack Interface
            stOp__sti__strm0_ready       ,
            sti__stOp__strm0_cntl        , 
            sti__stOp__strm0_data        , 
            sti__stOp__strm0_data_mask   , 
            sti__stOp__strm0_data_valid  , 

            stOp__sti__strm1_ready       ,
            sti__stOp__strm1_cntl        , 
            sti__stOp__strm1_data        , 
            sti__stOp__strm1_data_valid  , 
            sti__stOp__strm1_data_mask   ,

            // to ext
            //  - placeholder for stack upstream bus

            //-------------------------------
            // Result interface
            reg__stOp__ready             ,
            stOp__reg__valid             ,
            stOp__reg__data              , 

            //---------------------------------------------------------------
            // Memory Interface

            // Note: the memory interface IS NOT a FIFO interface
            // So transactions are only valid when ready is asserted from the
            // memc

            // Memory access 0
            dma__memc__write_valid0       ,
            dma__memc__write_address0     ,
            dma__memc__write_data0        ,
            memc__dma__write_ready0       ,  // from memory controller

            dma__memc__read_valid0        ,
            dma__memc__read_address0      ,
            memc__dma__read_data0         ,
            memc__dma__read_data_valid0   ,
            memc__dma__read_ready0        ,  // from memory controller
            dma__memc__read_pause0        ,  // to memory controller  

            // Memory access 1     
            dma__memc__write_valid1       ,
            dma__memc__write_address1     ,
            dma__memc__write_data1        ,
            memc__dma__write_ready1       ,

            dma__memc__read_valid1        ,
            dma__memc__read_address1      ,
            memc__dma__read_data1         ,
            memc__dma__read_data_valid1   ,
            memc__dma__read_ready1        ,
            dma__memc__read_pause1        ,

            
            //---------------------------------------------------------------
            // stOp Control

            //-----------------------------
            // stOp Control
            
            cntl__stOp__operation         ,

            cntl__stOp__strm0_enable      ,
            stOp__cntl__strm0_ready       ,
            stOp__cntl__strm0_complete    ,
            cntl__stOp__strm0_source      ,
            cntl__stOp__strm0_destination ,

            cntl__stOp__strm1_enable      ,
            stOp__cntl__strm1_ready       ,
            stOp__cntl__strm1_complete    ,
            cntl__stOp__strm1_source      ,
            cntl__stOp__strm1_destination ,
           
            // stream control/status

            //-----------------------------
            // DMA Control
            
            cntl__dma__operation                 ,

            //--------------
            // Stream 0
            cntl__dma__type0                     ,
            cntl__dma__num_of_types0             ,

            // dma read
            cntl__dma__strm0_read_enable         ,  // activate the read stream
            dma__cntl__strm0_read_ready          ,  
            dma__cntl__strm0_read_complete       ,  
            cntl__dma__strm0_read_start_address  ,  // "Operand" start address

            // dma write
            cntl__dma__strm0_write_enable        ,  // activate the write stream
            dma__cntl__strm0_write_ready         , 
            dma__cntl__strm0_write_complete      , 
            cntl__dma__strm0_write_start_address ,  // "result" start address

            //--------------
            // Stream 0
            cntl__dma__type1                     ,
            cntl__dma__num_of_types1             ,

            // dma read
            cntl__dma__strm1_read_enable         ,
            dma__cntl__strm1_read_ready          ,
            dma__cntl__strm1_read_complete       ,
            cntl__dma__strm1_read_start_address  ,  

            // dma write
            cntl__dma__strm1_write_enable        ,
            dma__cntl__strm1_write_ready         ,
            dma__cntl__strm1_write_complete      ,
            cntl__dma__strm1_write_start_address    // "result" start address


    );

  input         clk            ;
  input         reset_poweron  ;
   
  //-------------------------------------------------------------------------------------------------
  // Result interface
  input                                        reg__stOp__ready             ;
  output                                       stOp__reg__valid             ;
  output [`STREAMING_OP_RESULT_RANGE   ]       stOp__reg__data              ; 


  //-------------------------------------------------------------------------------------------------
  // Interface to Controller 
  input [`STREAMING_OP_CNTL_OPERATION_RANGE]                       cntl__stOp__operation                ;
                                                                                                        
  input                                                            cntl__stOp__strm0_enable             ;
  input                                                            cntl__stOp__strm1_enable             ;
  output                                                           stOp__cntl__strm0_ready              ;
  output                                                           stOp__cntl__strm1_ready              ;
  output                                                           stOp__cntl__strm0_complete           ;
  output                                                           stOp__cntl__strm1_complete           ;
  input  [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]    cntl__stOp__strm0_source             ;
  input  [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]    cntl__stOp__strm1_source             ;
  input  [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]    cntl__stOp__strm0_destination        ;
  input  [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]    cntl__stOp__strm1_destination        ;

  input [`STREAMING_OP_CNTL_OPERATION_RANGE]                       cntl__dma__operation                 ;
                                                                   
  input                                                            cntl__dma__strm0_read_enable         ;
  input                                                            cntl__dma__strm1_read_enable         ;
  input                                                            cntl__dma__strm0_write_enable        ;
  input                                                            cntl__dma__strm1_write_enable        ;
  output                                                           dma__cntl__strm0_read_ready          ;
  output                                                           dma__cntl__strm1_read_ready          ;
  output                                                           dma__cntl__strm0_read_complete       ;
  output                                                           dma__cntl__strm1_read_complete       ;
  output                                                           dma__cntl__strm0_write_ready         ;
  output                                                           dma__cntl__strm1_write_ready         ;
  output                                                           dma__cntl__strm0_write_complete      ;
  output                                                           dma__cntl__strm1_write_complete      ;
                                                                   
  input [`DMA_CONT_STRM_ADDRESS_RANGE]                             cntl__dma__strm0_read_start_address  ;  // streaming op arg0
  input [`DMA_CONT_STRM_ADDRESS_RANGE]                             cntl__dma__strm1_read_start_address  ;  // streaming op arg1
  input [`DMA_CONT_STRM_ADDRESS_RANGE]                             cntl__dma__strm0_write_start_address ;  // streaiming op result start address
  input [`DMA_CONT_STRM_ADDRESS_RANGE]                             cntl__dma__strm1_write_start_address ;  // streaiming op result start address
  input [`DMA_CONT_DATA_TYPES_RANGE ]                              cntl__dma__type0                     ;
  input [`DMA_CONT_DATA_TYPES_RANGE ]                              cntl__dma__type1                     ;
  input [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]                        cntl__dma__num_of_types0             ;
  input [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]                        cntl__dma__num_of_types1             ;

  //-------------------------------------------------------------------------------------------------
  // Interface to NoC (via cntl)
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

  //-------------------------------------------------------------------------------------------------
  // Interface to Downstream Stack bus
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

  //-------------------------------------------------------------------------------------------------
  // Interface to memory controller

  output                                        dma__memc__write_valid0      ;
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address0    ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data0       ; 
  input                                         memc__dma__write_ready0      ;
  output                                        dma__memc__read_valid0       ;
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address0     ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data0        ; 
  input                                         memc__dma__read_data_valid0  ;
  input                                         memc__dma__read_ready0       ;
  output                                        dma__memc__read_pause0       ;

  output                                        dma__memc__write_valid1      ;
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address1    ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data1       ; 
  input                                         memc__dma__write_ready1      ;
  output                                        dma__memc__read_valid1       ;
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address1     ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data1        ; 
  input                                         memc__dma__read_data_valid1  ;
  input                                         memc__dma__read_ready1       ;
  output                                        dma__memc__read_pause1       ;

  //-------------------------------------------------------------------------------------------------
  // Controller wires

  wire [`STREAMING_OP_CNTL_OPERATION_RANGE                  ]    cntl__dma__operation          ;
  wire [`STREAMING_OP_CNTL_OPERATION_RANGE                  ]    cntl__stOp__operation         ;
  wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]    cntl__stOp__strm0_source      ;
  wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]    cntl__stOp__strm1_source      ;
  wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]    cntl__stOp__strm0_destination ;
  wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]    cntl__stOp__strm1_destination ;



  //-------------------------------------------------------------------------------------------------
  // DMA Engine

  wire                                         stOp__dma__strm0_ready       ;
  wire  [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm0_cntl        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data_mask   ; 
  wire                                         dma__stOp__strm0_data_valid  ; 
  wire                                         stOp__dma__strm1_ready       ;
  wire  [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm1_cntl        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data        ; 
  wire  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data_mask   ; 
  wire                                         dma__stOp__strm1_data_valid  ; 

  // FIXME: Only need one streaming bus from stOp
  wire                                         dma__stOp__strm0_ready       ;
  wire [`DMA_CONT_STRM_CNTL_RANGE     ]        stOp__dma__strm0_cntl        ; 
  wire [`STREAMING_OP_DATA_RANGE      ]        stOp__dma__strm0_data        ; 
  wire [`STREAMING_OP_DATA_RANGE      ]        stOp__dma__strm0_data_mask   ; 
  wire                                         stOp__dma__strm0_data_valid  ; 
  wire                                         dma__stOp__strm1_ready       ;
  wire [`DMA_CONT_STRM_CNTL_RANGE     ]        stOp__dma__strm1_cntl        ; 
  wire [`STREAMING_OP_DATA_RANGE      ]        stOp__dma__strm1_data        ; 
  wire [`STREAMING_OP_DATA_RANGE      ]        stOp__dma__strm1_data_mask   ; 
  wire                                         stOp__dma__strm1_data_valid  ; 

  wire  [`STREAMING_OP_RESULT_RANGE   ]        stOp_result           ; 

  streamingOps streamingOps (
                           .clk               ( clk             ),
                           .reset_poweron     ( reset_poweron   ),
                           
                           // Controller interface
                           .operation               ( cntl__stOp__operation         ),
                           .strm0_enable            ( cntl__stOp__strm0_enable      ),
                           .strm1_enable            ( cntl__stOp__strm1_enable      ),
                           .strm0_ready             ( stOp__cntl__strm0_ready       ),
                           .strm1_ready             ( stOp__cntl__strm1_ready       ),
                           .strm0_complete          ( stOp__cntl__strm0_complete    ),
                           .strm1_complete          ( stOp__cntl__strm1_complete    ),
                           .strm0_source            ( cntl__stOp__strm0_source      ),
                           .strm0_destination       ( cntl__stOp__strm0_destination ),
                           .strm1_source            ( cntl__stOp__strm1_source      ),
                           .strm1_destination       ( cntl__stOp__strm1_destination ),
                            
                            // Result interface
                           .reg__stOp__ready             ( reg__stOp__ready            ),
                           .stOp__reg__valid             ( stOp__reg__valid            ),
                           .stOp__reg__data              ( stOp__reg__data             ),

                            // DMA interface
                           .stOp__dma__strm0_ready       ( stOp__dma__strm0_ready      ),
                           .dma__stOp__strm0_cntl        ( dma__stOp__strm0_cntl       ), 
                           .dma__stOp__strm0_data        ( dma__stOp__strm0_data       ), 
                           .dma__stOp__strm0_data_mask   ( dma__stOp__strm0_data_mask  ), 
                           .dma__stOp__strm0_data_valid  ( dma__stOp__strm0_data_valid ), 
                           .stOp__dma__strm1_ready       ( stOp__dma__strm1_ready      ),
                           .dma__stOp__strm1_cntl        ( dma__stOp__strm1_cntl       ), 
                           .dma__stOp__strm1_data        ( dma__stOp__strm1_data       ), 
                           .dma__stOp__strm1_data_mask   ( dma__stOp__strm1_data_mask  ), 
                           .dma__stOp__strm1_data_valid  ( dma__stOp__strm1_data_valid ), 
                            
                           .dma__stOp__strm0_ready       ( dma__stOp__strm0_ready      ),  // FIXME
                           .stOp__dma__strm0_cntl        ( stOp__dma__strm0_cntl       ), 
                           .stOp__dma__strm0_data        ( stOp__dma__strm0_data       ), 
                           .stOp__dma__strm0_data_mask   ( stOp__dma__strm0_data_mask  ), 
                           .stOp__dma__strm0_data_valid  ( stOp__dma__strm0_data_valid ), 
                           .dma__stOp__strm1_ready       ( dma__stOp__strm1_ready      ),  // FIXME
                           .stOp__dma__strm1_cntl        ( stOp__dma__strm1_cntl       ), 
                           .stOp__dma__strm1_data        ( stOp__dma__strm1_data       ), 
                           .stOp__dma__strm1_data_mask   ( stOp__dma__strm1_data_mask  ), 
                           .stOp__dma__strm1_data_valid  ( stOp__dma__strm1_data_valid ), 
                                                             
                            // NoC interface
                            // from NoC
                           .stOp__noc__strm_ready       ( stOp__noc__strm_ready      ),
                           .noc__stOp__strm_cntl        ( noc__stOp__strm_cntl       ), 
                           .noc__stOp__strm_id          ( noc__stOp__strm_id         ), 
                           .noc__stOp__strm_data        ( noc__stOp__strm_data       ), 
                           .noc__stOp__strm_data_valid  ( noc__stOp__strm_data_valid ), 
                            // to NoC
                           .noc__stOp__strm_ready       ( noc__stOp__strm_ready      ),
                           .stOp__noc__strm_cntl        ( stOp__noc__strm_cntl       ), 
                           .stOp__noc__strm_id          ( stOp__noc__strm_id         ), 
                           .stOp__noc__strm_data        ( stOp__noc__strm_data       ), 
                           .stOp__noc__strm_data_valid  ( stOp__noc__strm_data_valid ), 

                            // Downstream Stack Bus
                           .stOp__sti__strm0_ready       ( stOp__sti__strm0_ready      ),
                           .sti__stOp__strm0_cntl        ( sti__stOp__strm0_cntl       ), 
                           .sti__stOp__strm0_data        ( sti__stOp__strm0_data       ), 
                           .sti__stOp__strm0_data_valid  ( sti__stOp__strm0_data_valid ), 
                           .sti__stOp__strm0_data_mask   ( sti__stOp__strm0_data_mask  ), 
                           .stOp__sti__strm1_ready       ( stOp__sti__strm1_ready      ),
                           .sti__stOp__strm1_cntl        ( sti__stOp__strm1_cntl       ), 
                           .sti__stOp__strm1_data        ( sti__stOp__strm1_data       ), 
                           .sti__stOp__strm1_data_valid  ( sti__stOp__strm1_data_valid ), 
                           .sti__stOp__strm1_data_mask   ( sti__stOp__strm1_data_mask  )
  );

  //-------------------------------------------------------------------------------------------------
  // DMA Engine

  wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address0   ;
  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data0      ; 
  wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address0    ;
  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data0       ; 
  wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address1   ;
  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data1      ; 
  wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address1    ;
  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data1       ; 

  dma_cont dma_cont (
             
             // Control Interface
            .type0                       ( cntl__dma__type0                     ),
            .num_of_types0               ( cntl__dma__num_of_types0             ),

            .strm0_read_enable           ( cntl__dma__strm0_read_enable         ),
            .strm0_read_ready            ( dma__cntl__strm0_read_ready          ),
            .strm0_read_complete         ( dma__cntl__strm0_read_complete       ),
            .strm0_read_start_address    ( cntl__dma__strm0_read_start_address  ),

            .strm0_write_enable          ( cntl__dma__strm0_write_enable        ),
            .strm0_write_ready           ( dma__cntl__strm0_write_ready         ),
            .strm0_write_complete        ( dma__cntl__strm0_write_complete      ),
            .strm0_write_start_address   ( cntl__dma__strm0_write_start_address ),

            .num_of_types1               ( cntl__dma__num_of_types1             ),
            .type1                       ( cntl__dma__type1                     ),

            .strm1_read_enable           ( cntl__dma__strm1_read_enable         ),
            .strm1_read_ready            ( dma__cntl__strm1_read_ready          ),
            .strm1_read_complete         ( dma__cntl__strm1_read_complete       ),
            .strm1_read_start_address    ( cntl__dma__strm1_read_start_address  ),

            .strm1_write_enable          ( cntl__dma__strm1_write_enable        ),
            .strm1_write_ready           ( dma__cntl__strm1_write_ready         ),
            .strm1_write_complete        ( dma__cntl__strm1_write_complete      ),
            .strm1_write_start_address   ( cntl__dma__strm1_write_start_address ),

            .operation                   ( cntl__dma__operation                 ),
                                                                                
             // Memory Access Interface        

             // Memory access 0                                                 
            .dma__memc__write_valid0     ( dma__memc__write_valid0              ),
            .dma__memc__write_address0   ( dma__memc__write_address0            ),
            .dma__memc__write_data0      ( dma__memc__write_data0               ),
            .memc__dma__write_ready0     ( memc__dma__write_ready0              ),

            .dma__memc__read_valid0      ( dma__memc__read_valid0               ),
            .dma__memc__read_address0    ( dma__memc__read_address0             ),
            .memc__dma__read_data0       ( memc__dma__read_data0                ),
            .memc__dma__read_data_valid0 ( memc__dma__read_data_valid0          ),
            .memc__dma__read_ready0      ( memc__dma__read_ready0               ),
            .dma__memc__read_pause0      ( dma__memc__read_pause0               ),

             // Memory access 1                                                 
            .dma__memc__write_valid1     ( dma__memc__write_valid1              ),
            .dma__memc__write_address1   ( dma__memc__write_address1            ),
            .dma__memc__write_data1      ( dma__memc__write_data1               ),
            .memc__dma__write_ready1     ( memc__dma__write_ready1              ),

            .dma__memc__read_valid1      ( dma__memc__read_valid1               ),
            .dma__memc__read_address1    ( dma__memc__read_address1             ),
            .memc__dma__read_data1       ( memc__dma__read_data1                ),
            .memc__dma__read_data_valid1 ( memc__dma__read_data_valid1          ),
            .memc__dma__read_ready1      ( memc__dma__read_ready1               ),
            .dma__memc__read_pause1      ( dma__memc__read_pause1               ),
                                                                                
             // Streaming Operation Interface                                   
            .stOp__dma__strm0_ready      ( stOp__dma__strm0_ready               ),  // FIXME
            .dma__stOp__strm0_cntl       ( dma__stOp__strm0_cntl                ), 
            .dma__stOp__strm0_data       ( dma__stOp__strm0_data                ), 
            .dma__stOp__strm0_data_mask  ( dma__stOp__strm0_data_mask           ), 
            .dma__stOp__strm0_data_valid ( dma__stOp__strm0_data_valid          ), 

            .dma__stOp__strm0_ready       ( dma__stOp__strm0_ready              ),
            .stOp__dma__strm0_cntl        ( stOp__dma__strm0_cntl               ), 
            .stOp__dma__strm0_data        ( stOp__dma__strm0_data               ), 
            .stOp__dma__strm0_data_mask   ( stOp__dma__strm0_data_mask          ), 
            .stOp__dma__strm0_data_valid  ( stOp__dma__strm0_data_valid         ), 

            .stOp__dma__strm1_ready      ( stOp__dma__strm1_ready               ),  // FIXME
            .dma__stOp__strm1_cntl       ( dma__stOp__strm1_cntl                ), 
            .dma__stOp__strm1_data       ( dma__stOp__strm1_data                ), 
            .dma__stOp__strm1_data_mask  ( dma__stOp__strm1_data_mask           ), 
            .dma__stOp__strm1_data_valid ( dma__stOp__strm1_data_valid          ), 
                                                                                
            .dma__stOp__strm1_ready       ( dma__stOp__strm1_ready              ),
            .stOp__dma__strm1_cntl        ( stOp__dma__strm1_cntl               ), 
            .stOp__dma__strm1_data        ( stOp__dma__strm1_data               ), 
            .stOp__dma__strm1_data_mask   ( stOp__dma__strm1_data_mask          ), 
            .stOp__dma__strm1_data_valid  ( stOp__dma__strm1_data_valid         ), 
                                                             
            .clk                          ( clk                                 ),
            .reset_poweron                ( reset_poweron                       )
    );


endmodule

