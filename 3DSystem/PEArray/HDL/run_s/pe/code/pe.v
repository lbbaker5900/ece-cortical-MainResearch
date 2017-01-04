/*********************************************************************************************

    File name   : pe.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor processing engine.
                  It instantiates the SIMD core, DMA engine, Inter-PE interface, Streaming processor, Streaming Processor Control and the 
                  Memory Access module which contains the per execution lane local memory.

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"

module pe (

            // PE core interface
            //ready             , // ready to start streaming. Goes active when outside interfaces can start streaming
            //complete          ,

            // General system signals
            //sys__pe__allSynchronized  ,  // all PE streams are complete
            //pe__sys__thisSynchronized ,  // this PE's streams are complete
                          
             //-------------------------------
            // Stack Bus - Downstream
            //
            `include "pe_stack_bus_downstream_ports.vh"

            //-------------------------------
            // NoC
            //
            `include "noc_cntl_noc_ports.vh"
            //
 
            //peId             ,
            clk              ,
            reset_poweron    
 
    );

  input                      clk            ;
  input                      reset_poweron  ;
  //input [`PE_PE_ID_RANGE   ] sys__pe__peId  ; 

  //input                      sys__pe__allSynchronized  ;  // all PE streams are complete
  //output                     pe__sys__thisSynchronized ;  // this PE's streams are complete
   
  // interface to PE core
  //output      ready             ; // ready to start streaming
  //output      complete          ;


  //-------------------------------------------------------------------------------------------------
  // interface to External Interface

  //-------------------------------------------------------------------------------------------------
  // interface to External Interface
  `include "pe_stack_bus_downstream_port_declarations.vh"


  //-------------------------------------------------------------------------------------------------
  // NoC
  //
  `include "noc_cntl_noc_ports_declaration.vh"

  //-------------------------------------------------------------------------------------------------
  // Streaming Operations Control

  wire [`STREAMING_OP_CNTL_OPERATION_RANGE]  cntl__stOp__operation ;
  wire [`STREAMING_OP_CNTL_OPERATION_RANGE]  cntl__dma__operation  ;

  `include "pe_stOp_to_cntl_regfile_connection_wires.vh"
  `include "pe_dma_memc_connection_wires.vh"
  `include "pe_std_to_stOp_connection_wires.vh"

  `include "pe__noc_to_peArray_connection_wires.vh"

  `include "pe_cntl_noc_connection_wires.vh"
  `include "pe_cntl_to_stOp_connection_wires.vh"

  `include "pe_stOp_control_to_stOp_wires.vh"

  //---------------------------------------
  // Stack Interface Downstream to Streaming Op
  //
  `include "stack_interface_to_stOp_downstream_instance_wires.vh"

  //---------------------------------------
  // SIMD
  // 
  `include "pe_simd_instance_wires.vh"

  wire [`PE_PE_ID_RANGE     ]     peId = sys__pe__peId   ;



  stack_interface stack_interface (

                        //---------------------------------------
                        // Downstream Stack bus
                        //
                        `include "pe_stack_bus_downstream_instance_ports.vh"

                        //---------------------------------------
                        // Downstream Stack to Streaming Op
                        //
                        `include "stack_interface_to_stOp_downstream_instance_ports.vh"


                       .clk                          ( clk                         ),
                       .reset_poweron                ( reset_poweron               )
  );




  //-------------------------------------------------------------------------------------------------
  // NoC Interface
  // 
  noc_cntl noc_cntl (

                        // Aggregate Control-Path (cp) to NoC 
                       .noc__cntl__cp_ready          ( noc__cntl__cp_ready         ), 
                       .cntl__noc__cp_cntl           ( cntl__noc__cp_cntl          ), 
                       .cntl__noc__cp_type           ( cntl__noc__cp_type          ), 
                       .cntl__noc__cp_data           ( cntl__noc__cp_data          ), 
                       .cntl__noc__cp_laneId         ( cntl__noc__cp_laneId        ), 
                       .cntl__noc__cp_strmId         ( cntl__noc__cp_strmId        ), 
                       .cntl__noc__cp_valid          ( cntl__noc__cp_valid         ), 
                        // Aggregate Data-Path (cp) from NoC 
                       .cntl__noc__cp_ready          ( cntl__noc__cp_ready         ), 
                       .noc__cntl__cp_cntl           ( noc__cntl__cp_cntl          ), 
                       .noc__cntl__cp_type           ( noc__cntl__cp_type          ), 
                       .noc__cntl__cp_data           ( noc__cntl__cp_data          ), 
                       .noc__cntl__cp_peId           ( noc__cntl__cp_peId          ), 
                       .noc__cntl__cp_laneId         ( noc__cntl__cp_laneId        ), 
                       .noc__cntl__cp_strmId         ( noc__cntl__cp_strmId        ), 
                       .noc__cntl__cp_valid          ( noc__cntl__cp_valid         ), 
                       
                        // Aggregate Data-Path (dp) to NoC 
                       .noc__cntl__dp_ready          ( noc__cntl__dp_ready         ), 
                       .cntl__noc__dp_type           ( cntl__noc__dp_type          ), 
                       .cntl__noc__dp_cntl           ( cntl__noc__dp_cntl          ), 
                       .cntl__noc__dp_peId           ( cntl__noc__dp_peId          ), 
                       .cntl__noc__dp_laneId         ( cntl__noc__dp_laneId        ), 
                       .cntl__noc__dp_strmId         ( cntl__noc__dp_strmId        ), 
                       .cntl__noc__dp_data           ( cntl__noc__dp_data          ), 
                       .cntl__noc__dp_valid          ( cntl__noc__dp_valid         ), 
                        // Aggregate Data-Path (dp) from NoC 
                       .cntl__noc__dp_ready          ( cntl__noc__dp_ready         ), 
                       .noc__cntl__dp_cntl           ( noc__cntl__dp_cntl          ), 
                       .noc__cntl__dp_type           ( noc__cntl__dp_type          ), 
                       .noc__cntl__dp_laneId         ( noc__cntl__dp_laneId        ), 
                       .noc__cntl__dp_strmId         ( noc__cntl__dp_strmId        ), 
                       .noc__cntl__dp_data           ( noc__cntl__dp_data          ), 
                       .noc__cntl__dp_valid          ( noc__cntl__dp_valid         ), 

                        // Connections to external NoC
                        `include "noc_cntl_noc_ports_instance_ports.vh"

                       .peId                         ( peId                        ),
                       .clk                          ( clk                         ),
                       .reset_poweron                ( reset_poweron               )
                          
  );

  //-------------------------------------------------------------------------------------------------
  // Controller
  // 
  streamingOps_cntl streamingOps_cntl (

                          // PE core interface
                          .ready             ( pe__sys__ready     ), // ready to start streaming
                          .complete          ( pe__sys__complete  ),  // FIXME
                          
                          // General system signals
                          .sys__pe__allSynchronized  (sys__pe__allSynchronized ),  // all PE streams are complete
                          .pe__sys__thisSynchronized (pe__sys__thisSynchronized),  // this PE's streams are complete
                          
                          // stOp NoC Interface(s)
                          // connections to datapath made via mem_acc_control python script
                          `include "streamingOps_cntl_stOp_instance_ports.vh"
                          `include "streamingOps_cntl_noc_instance_ports.vh"
                          
                          // connections to datapath made via mem_acc_control python script
                          `include "streamingOps_cntl_control_instance_ports.vh"
                          
                           // Memory Access Interface                                      
                          .cntl__memc__request      ( cntl__memc__request             ),
                          .memc__cntl__granted      ( memc__cntl__granted             ),
                          .cntl__memc__released     ( cntl__memc__released            ),

                          // external interface
                          .ext_enable        (  ),
                          .ext_ready         ( 1'b1 ),  // FIXME
                          .ext_start         (  ),
                          .ext_complete      ( 1'b1 ),  // FIXME

                           // SIMD Register interface
                          `include "pe_simd_instance_ports.vh"

                          .peId              ( peId          ),
                          .clk               ( clk           ),
                          .reset_poweron     ( reset_poweron )
                          
  );


  //-------------------------------------------------------------------------------------------------
  // Instantiate streaming operation module and dma module for each execution
  // lane

  genvar gvi;
  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES ; gvi=gvi+1) 
      begin: stOp_lane

        //-------------------------------------------------------------------------------------------------
        // DMA Engine
   
        wire                                         cntl__memc__request           ;
        wire                                         memc__cntl__granted           ;
        wire                                         cntl__memc__released          ;
      
        wire                                         dma__memc__write_valid0      ;
        wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address0    ;
        wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data0       ; 
        wire                                         memc__dma__write_ready0      ;
        wire                                         dma__memc__read_valid0       ;
        wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address0     ;
        wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data0        ; 
        wire                                         memc__dma__read_data_valid0  ;
        wire                                         memc__dma__read_ready0       ;
        wire                                         dma__memc__read_pause0       ;
      
        wire                                         dma__memc__write_valid1      ;
        wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address1    ;
        wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data1       ; 
        wire                                         memc__dma__write_ready1      ;
        wire                                         dma__memc__read_valid1       ;
        wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address1     ;
        wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data1        ; 
        wire                                         memc__dma__read_data_valid1  ;
        wire                                         memc__dma__read_ready1       ;
        wire                                         dma__memc__read_pause1       ;
 
        wire                                         cntl__dma__strm0_read_enable         ;
        wire                                         cntl__dma__strm1_read_enable         ;
        wire                                         cntl__dma__strm0_write_enable        ;
        wire                                         cntl__dma__strm1_write_enable        ;
        wire                                         dma__cntl__strm0_read_complete       ;
        wire                                         dma__cntl__strm1_read_complete       ;
        wire                                         dma__cntl__strm0_write_complete      ;
        wire                                         dma__cntl__strm1_write_complete      ;
        wire  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  cntl__dma__strm0_read_start_address  ;  // streaming op arg0
        wire  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  cntl__dma__strm1_read_start_address  ;  // streaming op arg1
        wire  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  cntl__dma__strm0_write_start_address ;  // streaiming op result start address
        wire  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  cntl__dma__strm1_write_start_address ;  // streaiming op result start address
        wire  [`DMA_CONT_DATA_TYPES_RANGE         ]  cntl__dma__type0         ;
        wire  [`DMA_CONT_DATA_TYPES_RANGE         ]  cntl__dma__type1         ;
        wire  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ]  cntl__dma__num_of_types0 ;
        wire  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ]  cntl__dma__num_of_types1 ;
   
        wire                                         reg__stOp__ready         ;
        wire                                         stOp__reg__valid         ;
        wire   [`STREAMING_OP_RESULT_RANGE        ]  stOp__reg__data          ;
        wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  stOp__reg__cntl          ; 

        wire  [`STREAMING_OP_CNTL_OPERATION_RANGE ]  cntl__dma__operation     ;

        wire                                                          stOp__cntl__complete          ;
        wire                                                          cntl__stOp__strm0_enable      ;
        wire                                                          cntl__stOp__strm1_enable      ;
        wire                                                          stOp__cntl__strm0_ready       ;
        wire                                                          stOp__cntl__strm1_ready       ;
        wire                                                          stOp__cntl__strm0_complete    ;
        wire                                                          stOp__cntl__strm1_complete    ;
        wire  [`STREAMING_OP_CNTL_OPERATION_RANGE ]                   cntl__stOp__operation         ;
        wire  [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  cntl__stOp__strm0_source      ;
        wire  [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  cntl__stOp__strm1_source      ;
        wire  [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  cntl__stOp__strm0_destination ;
        wire  [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  cntl__stOp__strm1_destination ;

        wire                                         stOp__noc__strm_ready       ;
        wire  [`DMA_CONT_STRM_CNTL_RANGE          ]  noc__stOp__strm_cntl        ; 
        wire                                         noc__stOp__strm_id          ; 
        wire  [`STREAMING_OP_DATA_RANGE           ]  noc__stOp__strm_data        ; 
        wire                                         noc__stOp__strm_data_valid  ; 

        wire                                         noc__stOp__strm_ready       ;
        wire  [`DMA_CONT_STRM_CNTL_RANGE          ]  stOp__noc__strm_cntl        ; 
        wire                                         stOp__noc__strm_id          ; 
        wire  [`STREAMING_OP_DATA_RANGE           ]  stOp__noc__strm_data        ; 
        wire                                         stOp__noc__strm_data_valid  ; 

        wire                                         stOp__sti__strm0_ready       ;
        wire  [`DMA_CONT_STRM_CNTL_RANGE          ]  sti__stOp__strm0_cntl        ; 
        wire  [`STREAMING_OP_DATA_RANGE           ]  sti__stOp__strm0_data        ; 
        wire  [`STREAMING_OP_DATA_RANGE           ]  sti__stOp__strm0_data_mask   ; 
        wire                                         sti__stOp__strm0_data_valid  ; 
        wire                                         stOp__sti__strm1_ready       ;
        wire  [`DMA_CONT_STRM_CNTL_RANGE          ]  sti__stOp__strm1_cntl        ; 
        wire  [`STREAMING_OP_DATA_RANGE           ]  sti__stOp__strm1_data        ; 
        wire  [`STREAMING_OP_DATA_RANGE           ]  sti__stOp__strm1_data_mask   ; 
        wire                                         sti__stOp__strm1_data_valid  ; 

        streamingOps_datapath streamingOps_datapath (

                                 .clk                            ( clk                            ),
                                 .reset_poweron                  ( reset_poweron                  ),
                                                                                                
                                 //--------------------------------------------------------------------------------
                                 // stOp Control
                                 //
                                 .cntl__stOp__operation          ( cntl__stOp__operation          ),

                                 // Stream 0
                                 .cntl__stOp__strm0_enable       ( cntl__stOp__strm0_enable       ),
                                 .stOp__cntl__strm0_ready        ( stOp__cntl__strm0_ready        ),
                                 .stOp__cntl__strm0_complete     ( stOp__cntl__strm0_complete     ),
                                 .cntl__stOp__strm0_source       ( cntl__stOp__strm0_source       ),
                                 .cntl__stOp__strm0_destination  ( cntl__stOp__strm0_destination  ),

                                 // Stream 1
                                 .cntl__stOp__strm1_enable       ( cntl__stOp__strm1_enable       ),
                                 .stOp__cntl__strm1_ready        ( stOp__cntl__strm1_ready        ),
                                 .stOp__cntl__strm1_complete     ( stOp__cntl__strm1_complete     ),
                                 .cntl__stOp__strm1_source       ( cntl__stOp__strm1_source       ),
                                 .cntl__stOp__strm1_destination  ( cntl__stOp__strm1_destination  ),

                                 //--------------------------------------------------------------------------------
                                 // DMA Control

                                 .cntl__dma__operation                 ( cntl__dma__operation                 ),

                                 // Stream 0

                                 .cntl__dma__type0                     ( cntl__dma__type0                     ),
                                 .cntl__dma__num_of_types0             ( cntl__dma__num_of_types0             ),

                                 // dma read
                                 .cntl__dma__strm0_read_enable         ( cntl__dma__strm0_read_enable         ),
                                 .dma__cntl__strm0_read_ready          ( dma__cntl__strm0_read_ready          ),
                                 .dma__cntl__strm0_read_complete       ( dma__cntl__strm0_read_complete       ),
                                 .cntl__dma__strm0_read_start_address  ( cntl__dma__strm0_read_start_address  ),
                                 // dma write
                                 .cntl__dma__strm0_write_enable        ( cntl__dma__strm0_write_enable        ),
                                 .dma__cntl__strm0_write_ready         ( dma__cntl__strm0_write_ready         ),
                                 .dma__cntl__strm0_write_complete      ( dma__cntl__strm0_write_complete      ),
                                 .cntl__dma__strm0_write_start_address ( cntl__dma__strm0_write_start_address ),

                                 // Stream 1

                                 .cntl__dma__type1                     ( cntl__dma__type1                     ),
                                 .cntl__dma__num_of_types1             ( cntl__dma__num_of_types1             ),

                                 // dma read
                                 .cntl__dma__strm1_read_enable         ( cntl__dma__strm1_read_enable         ),
                                 .dma__cntl__strm1_read_ready          ( dma__cntl__strm1_read_ready          ),
                                 .dma__cntl__strm1_read_complete       ( dma__cntl__strm1_read_complete       ),
                                 .cntl__dma__strm1_read_start_address  ( cntl__dma__strm1_read_start_address  ),
                                 // dma write
                                 .cntl__dma__strm1_write_enable        ( cntl__dma__strm1_write_enable        ),
                                 .dma__cntl__strm1_write_ready         ( dma__cntl__strm1_write_ready         ),
                                 .dma__cntl__strm1_write_complete      ( dma__cntl__strm1_write_complete      ),
                                 .cntl__dma__strm1_write_start_address ( cntl__dma__strm1_write_start_address ),
                                                                
                                                                                                  
                                 //--------------------------------------------------------------------------------
                                 // Main Datapath Interfaces
                                 
                                 //--------------------------------------------------------------------------------
                                 // Memory Interface

                                 // Memory 0                                              
                                 .dma__memc__write_valid0        ( dma__memc__write_valid0        ),
                                 .dma__memc__write_address0      ( dma__memc__write_address0      ),
                                 .dma__memc__write_data0         ( dma__memc__write_data0         ),
                                 .memc__dma__write_ready0        ( memc__dma__write_ready0        ),

                                 .dma__memc__read_valid0         ( dma__memc__read_valid0         ),
                                 .dma__memc__read_address0       ( dma__memc__read_address0       ),
                                 .memc__dma__read_data0          ( memc__dma__read_data0          ),
                                 .memc__dma__read_data_valid0    ( memc__dma__read_data_valid0    ),
                                 .memc__dma__read_ready0         ( memc__dma__read_ready0         ),
                                 .dma__memc__read_pause0         ( dma__memc__read_pause0         ),

                                 // Memory 1                                              
                                 .dma__memc__write_valid1        ( dma__memc__write_valid1        ),
                                 .dma__memc__write_address1      ( dma__memc__write_address1      ),
                                 .dma__memc__write_data1         ( dma__memc__write_data1         ),
                                 .memc__dma__write_ready1        ( memc__dma__write_ready1        ),

                                 .dma__memc__read_valid1         ( dma__memc__read_valid1         ),
                                 .dma__memc__read_address1       ( dma__memc__read_address1       ),
                                 .memc__dma__read_data1          ( memc__dma__read_data1          ),
                                 .memc__dma__read_data_valid1    ( memc__dma__read_data_valid1    ),
                                 .memc__dma__read_ready1         ( memc__dma__read_ready1         ),
                                 .dma__memc__read_pause1         ( dma__memc__read_pause1         ),
                                                                                                  
                                 //--------------------------------------------------------------------------------
                                 // Result interface           
                                 .reg__stOp__ready               ( reg__stOp__ready               ),
                                 .stOp__reg__valid               ( stOp__reg__valid               ),
                                 .stOp__reg__data                ( stOp__reg__data                ),
                                 .stOp__reg__cntl                ( stOp__reg__cntl                ),

                                 //--------------------------------------------------------------------------------
                                 // NoC interface

                                 // from NoC
                                 .stOp__noc__strm_ready         ( stOp__noc__strm_ready           ),
                                 .noc__stOp__strm_cntl          ( noc__stOp__strm_cntl            ), 
                                 .noc__stOp__strm_id            ( noc__stOp__strm_id              ), 
                                 .noc__stOp__strm_data          ( noc__stOp__strm_data            ), 
                                 .noc__stOp__strm_data_valid    ( noc__stOp__strm_data_valid      ), 
                                                                                                  
                                  // to NoC                                                       
                                 .noc__stOp__strm_ready         ( noc__stOp__strm_ready           ),
                                 .stOp__noc__strm_cntl          ( stOp__noc__strm_cntl            ), 
                                 .stOp__noc__strm_id            ( stOp__noc__strm_id              ), 
                                 .stOp__noc__strm_data          ( stOp__noc__strm_data            ), 
                                 .stOp__noc__strm_data_valid    ( stOp__noc__strm_data_valid      ), 
                                                                                                       
                                 //--------------------------------------------------------------------------------
                                 // External interface - Stack bus

                                 .sti__stOp__strm0_cntl          ( sti__stOp__strm0_cntl          ), 
                                 .sti__stOp__strm0_data          ( sti__stOp__strm0_data          ), 
                                 .sti__stOp__strm0_data_valid    ( sti__stOp__strm0_data_valid    ), 
                                 .sti__stOp__strm0_data_mask     ( sti__stOp__strm0_data_mask     ), 
                                 .stOp__sti__strm0_ready         ( stOp__sti__strm0_ready         ),

                                 .sti__stOp__strm1_cntl          ( sti__stOp__strm1_cntl          ), 
                                 .sti__stOp__strm1_data          ( sti__stOp__strm1_data          ), 
                                 .sti__stOp__strm1_data_valid    ( sti__stOp__strm1_data_valid    ), 
                                 .sti__stOp__strm1_data_mask     ( sti__stOp__strm1_data_mask     ),
                                 .stOp__sti__strm1_ready         ( stOp__sti__strm1_ready         )
        );
            
      end
  endgenerate

  //---------------------------------------
  // PE Control to modules
  //
  `include "pe_stOp_control_to_stOp_connections.vh"
  `include "pe_stOp_control_to_dma_connections.vh"

  // Regfile signals from stOp
  `include "pe_stOp_to_cntl_regfile_connections.vh"

  //---------------------------------------
  // Inter-module connections
  //

  `include "pe_dma_to_memc_connections.vh"

  `include "streamingOps_cntl_stOp_noc_connections.vh"

  // Stack Interface Downstream to Streaming Op
  `include "pe_stack_interface_to_stOp_connections.vh"




  //-------------------------------------------------------------------------------------------------
  // Memory Controller

  wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__write_address   ;
  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  ldst__memc__write_data      ; 
  wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__read_address    ;
  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__ldst__read_data       ; 

  mem_acc_cont mem_acc_cont (
                                        
             //-------------------------------
             // LD/ST Interface
            .ldst__memc__request           ( ldst__memc__request          ),
            .memc__ldst__granted           ( memc__ldst__granted          ),
            .ldst__memc__released          ( ldst__memc__released         ),
             // Access
            .ldst__memc__write_valid       ( ldst__memc__write_valid      ),
            .ldst__memc__write_address     ( ldst__memc__write_address    ),
            .ldst__memc__write_data        ( ldst__memc__write_data       ),
            .memc__ldst__write_ready       ( memc__ldst__write_ready      ),  // output flow control to ldst
            .ldst__memc__read_valid        ( ldst__memc__read_valid       ),
            .ldst__memc__read_address      ( ldst__memc__read_address     ),
            .memc__ldst__read_data         ( memc__ldst__read_data        ),
            .memc__ldst__read_data_valid   ( memc__ldst__read_data_valid  ),
            .memc__ldst__read_ready        ( memc__ldst__read_ready       ),  // output flow control to ldst
            .ldst__memc__read_pause        ( ldst__memc__read_pause       ),  // pipeline flow control from ldst, dont send any more requests

            //-------------------------------
            // DMA Interface
            .cntl__memc__request            ( cntl__memc__request           ), 
            .memc__cntl__granted            ( memc__cntl__granted           ),
            .cntl__memc__released           ( cntl__memc__released          ),

            `include "mem_acc_cont_instance_ports.vh"
            //`include "mem_acc_cont_unused_streams.vh"

            .clk                         ( clk             ),
            .reset_poweron               ( reset_poweron   )

    );


endmodule

