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

//--------------------------------------------------
// RTL related defines
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "pe_cntl.vh"
`include "stack_interface.vh"
//`include "noc_cntl.vh"
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
            // Stack Bus - General
            //
            sys__pe__peId                   , 
            sys__pe__allSynchronized        , 
            pe__sys__thisSynchronized       , 
            pe__sys__ready                  , 
            pe__sys__complete               , 

            //-------------------------------
            // Stack Bus - OOB Downstream
            //   - OOB controls how the lanes are interpreted
            std__pe__oob_cntl                           ,
            std__pe__oob_valid                          ,
            pe__std__oob_ready                          ,
            std__pe__oob_type                           ,
            std__pe__oob_data                           ,
            //`include "pe_stack_bus_downstream_oob_ports.vh"

            //-------------------------------
            // Stack Bus - Downstream
            //
            `include "pe_stack_bus_downstream_ports.vh"

            //-------------------------------
            // Stack Bus - Upstream
            //
            pe__stu__valid         ,
            pe__stu__cntl          ,
            stu__pe__ready         ,
            pe__stu__type          ,  // Control or Data, Vector or scalar
            pe__stu__data          ,
            pe__stu__oob_data      ,
 
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
  // Stack Bus - General

  // General control and status                                                
  input [`PE_PE_ID_RANGE                 ]      sys__pe__peId                ; 
  input                                         sys__pe__allSynchronized     ; 
  output                                        pe__sys__thisSynchronized    ; 
  output                                        pe__sys__ready               ; 
  output                                        pe__sys__complete            ; 

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  //   - OOB carries PE configuration  
  input [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl            ;
  input                                         std__pe__oob_valid           ;
  output                                        pe__std__oob_ready           ;
  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type            ;
  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data            ;
  //`include "pe_stack_bus_downstream_oob_port_declarations.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Downstream

  `include "pe_stack_bus_downstream_port_declarations.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //
  output                                         pe__stu__valid       ;
  output  [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl        ;
  input                                          stu__pe__ready       ;
  output  [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type        ;  // Control or Data, Vector or scalar
  output  [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data        ;
  output  [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data    ;
 

  //-------------------------------------------------------------------------------------------------
  // Regs and Wires
  
  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //
  wire                                           pe__stu__valid       ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl        ;
  wire                                           stu__pe__ready       ;
  wire    [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type        ;  // Control or Data, Vector or scalar
  wire    [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data        ;
  wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data    ;
 
  //-------------------------------------------------------------------------------------------------
  // NoC
  //
  //`include "noc_cntl_noc_ports_declaration.vh"

  //-------------------------------------------------------------------------------------------------
  // Streaming Operations Control

  //wire [`STREAMING_OP_CNTL_OPERATION_RANGE]  scntl__stOp__operation ;
  //wire [`STREAMING_OP_CNTL_OPERATION_RANGE]  scntl__dma__operation  ;

  //-------------------------------------------------------------------------------------------------
  // Result from stOp to simd (via scntl)

  `include "pe_stOp_to_cntl_regfile_connection_wires.vh"
  `include "pe_scntl_to_simd_regfile_connection_wires.vh"


  //-------------------------------------------------------------------------------------------------
  `include "pe_dma_memc_connection_wires.vh"
  //`include "pe_std_to_stOp_connection_wires.vh"

  //`include "pe_noc_to_peArray_connection_wires.vh"

  //`include "pe_cntl_noc_connection_wires.vh"
  //`include "pe_cntl_to_stOp_connection_wires.vh"

  `include "pe_stOp_control_to_stOp_wires.vh"

  //---------------------------------------
  // Stack Interface Downstream to Streaming Op
  //
  `include "stack_interface_to_stOp_downstream_instance_wires.vh"

  //---------------------------------------
  // Stack Interface Downstream to PE control
  //
  // OOB carries PE configuration                                           
  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      sti__cntl__oob_cntl            ;
  wire                                        sti__cntl__oob_valid           ;
  wire                                        cntl__sti__oob_ready           ;
  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      sti__cntl__oob_type            ;
  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      sti__cntl__oob_data            ;
  //`include "stack_interface_to_pe_cntl_downstream_instance_wires.vh"

  //---------------------------------------
  // PE Control
  // 
  // FIXME: Made reg's to fix check design, but can gbe wires with multicycle path
  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs0  ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__rs1  ;

  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r128  [`PE_NUM_OF_EXEC_LANES ];
  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r129  [`PE_NUM_OF_EXEC_LANES ];
  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r130  [`PE_NUM_OF_EXEC_LANES ];
  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r131  [`PE_NUM_OF_EXEC_LANES ];
  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r132  [`PE_NUM_OF_EXEC_LANES ];
  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r133  [`PE_NUM_OF_EXEC_LANES ];
  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r134  [`PE_NUM_OF_EXEC_LANES ];
  wire  [`PE_EXEC_LANE_WIDTH_RANGE]  cntl__simd__lane_r135  [`PE_NUM_OF_EXEC_LANES ];
  //`include "pe_cntl_simd_instance_wires.vh"

  wire                                    cntl__simd__tag_valid      ;
  wire  [`STACK_DOWN_OOB_INTF_TAG_RANGE]  cntl__simd__tag            ;
  wire  [`PE_NUM_LANES_RANGE           ]  cntl__simd__tag_num_lanes  ; 
  wire                                    simd__cntl__tag_ready      ;

  //---------------------------------------
  // SIMD
  // 
  `include "pe_simd_instance_wires.vh"
  wire  [`STACK_DOWN_OOB_INTF_TAG_RANGE]  simd__sui__tag            ;
  wire  [`PE_NUM_LANES_RANGE           ]  simd__sui__tag_num_lanes  ;  

  wire [`PE_PE_ID_RANGE     ]     peId = sys__pe__peId   ;



  wire                                           sui__sti__valid      ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE   ]        sui__sti__cntl       ;
  wire                                           sti__sui__ready      ;
  wire   [`STACK_UP_INTF_TYPE_RANGE     ]        sui__sti__type       ;  // Control or Data, Vector or scalar
  wire   [`STACK_UP_INTF_DATA_RANGE     ]        sui__sti__data       ;
  wire   [`STACK_UP_INTF_OOB_DATA_RANGE ]        sui__sti__oob_data   ;

  stack_interface stack_interface (

                        //---------------------------------------
                        // OOB Downstream Stack bus
                        //
                        `include "pe_stack_bus_downstream_oob_instance_ports.vh"

                        //---------------------------------------
                        // Downstream Stack bus
                        //
                        `include "pe_stack_bus_downstream_instance_ports.vh"

                        //-------------------------------
                        // Stack Bus - Upstream
                        //
                        .pe__stu__valid        ( pe__stu__valid        ),
                        .pe__stu__cntl         ( pe__stu__cntl         ),
                        .stu__pe__ready        ( stu__pe__ready        ),
                        .pe__stu__type         ( pe__stu__type         ),  // Control or Data, Vector or scalar
                        .pe__stu__data         ( pe__stu__data         ),
                        .pe__stu__oob_data     ( pe__stu__oob_data     ),
 
                        //--------------------------------------------------
                        // Stack Upstream from simd
                        .sui__sti__valid       ( sui__sti__valid       ), 
                        .sui__sti__cntl        ( sui__sti__cntl        ), 
                        .sti__sui__ready       ( sti__sui__ready       ), 
                                                                   
                        .sui__sti__type        ( sui__sti__type        ), 
                        .sui__sti__data        ( sui__sti__data        ), 
                        .sui__sti__oob_data    ( sui__sti__oob_data    ), 

                        //---------------------------------------
                        // Downstream Stack OOB to PE control
                        //   - OOB carries PE configuration                                               
                        .sti__cntl__oob_cntl                  ( sti__cntl__oob_cntl               ),      
                        .sti__cntl__oob_valid                 ( sti__cntl__oob_valid              ),      
                        .cntl__sti__oob_ready                 ( cntl__sti__oob_ready              ),      
                        .sti__cntl__oob_type                  ( sti__cntl__oob_type               ),      
                        .sti__cntl__oob_data                  ( sti__cntl__oob_data               ),      
                        //`include "stack_interface_to_pe_cntl_downstream_instance_ports.vh"

                        //---------------------------------------
                        // Downstream Stack to Streaming Op
                        //
                        `include "stack_interface_to_stOp_downstream_instance_ports.vh"


                       .clk                          ( clk                         ),
                       .reset_poweron                ( reset_poweron               )
  );


  //-------------------------------------------------------------------------------------------------
  // PE Control
  // 
  wire  [`PE_CNTL_OOB_OPTION_RANGE            ]    cntl__simd__tag_optionPtr      ; 

  pe_cntl pe_cntl (

            //-------------------------------
            // Stack Bus interface
            //
            
            .sys__pe__peId                        ( sys__pe__peId                     ),
            // OOB Downstream carries PE configuration 
            .sti__cntl__oob_cntl                  ( sti__cntl__oob_cntl               ),      
            .sti__cntl__oob_valid                 ( sti__cntl__oob_valid              ),      
            .cntl__sti__oob_ready                 ( cntl__sti__oob_ready              ),      
            .sti__cntl__oob_type                  ( sti__cntl__oob_type               ),      
            .sti__cntl__oob_data                  ( sti__cntl__oob_data               ),      
            
            //-------------------------------
            // Configuration output
            `include "pe_cntl_simd_instance_ports.vh"
            .stOp_complete                        ( pe__sys__complete                 ),
            .cntl__simd__tag_valid                ( cntl__simd__tag_valid             ),
            .cntl__simd__tag                      ( cntl__simd__tag                   ),
            .cntl__simd__tag_optionPtr            ( cntl__simd__tag_optionPtr         ),  // operation PC for simd
            .cntl__simd__tag_num_lanes            ( cntl__simd__tag_num_lanes         ),
            .simd__cntl__tag_ready                ( simd__cntl__tag_ready             ),

            //-------------------------------
            // General
            //
            .clk                                  ( clk                               ),
            .reset_poweron                        ( reset_poweron                     )
  );


  //-------------------------------------------------------------------------------------------------
  // SIMD Registers to Stack Up 
  // 
  wire  [`COMMON_STD_INTF_CNTL_RANGE   ]  simd__sui__regs_cntl  [`PE_NUM_OF_EXEC_LANES ] ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE     ]  simd__sui__regs       [`PE_NUM_OF_EXEC_LANES ] ;
  wire  [`PE_NUM_OF_EXEC_LANES_RANGE   ]  simd__sui__regs_valid                          ;
  wire                                    sui__simd__regs_complete                       ;
  wire                                    sui__simd__regs_ready                          ;

  simd_upstream_intf simd_upstream_intf (

                  //--------------------------------------------------
                  // Stack Upstream interface
                  .sui__sti__valid       ( sui__sti__valid       ), 
                  .sui__sti__cntl        ( sui__sti__cntl        ), 
                  .sti__sui__ready       ( sti__sui__ready       ), 
                                                             
                  .sui__sti__type        ( sui__sti__type        ), 
                  .sui__sti__data        ( sui__sti__data        ), 
                  .sui__sti__oob_data    ( sui__sti__oob_data    ), 

                  //--------------------------------------------------
                  // Register(s) from simd
                  .simd__sui__regs_valid    ( simd__sui__regs_valid    ),
                  .simd__sui__regs_cntl     ( simd__sui__regs_cntl     ),
                  .simd__sui__regs          ( simd__sui__regs          ),
                  .sui__simd__regs_complete ( sui__simd__regs_complete ),
                  .sui__simd__regs_ready    ( sui__simd__regs_ready    ),

                  //--------------------------------------------------
                  // Additional control from simd
                  .simd__sui__tag           ( simd__sui__tag           ),
                  .simd__sui__tag_num_lanes ( simd__sui__tag_num_lanes ),

                  //--------------------------------------------------
                  // General
                  .peId                  ( sys__pe__peId         ),
                  .clk                   ( clk                   ),
                  .reset_poweron         ( reset_poweron         )
  );

  //-------------------------------------------------------------------------------------------------
  // SIMD Wrapper
  // 
  
  // Convert from individual register interfaces to a register array prior to
  // driving into the simd wrapper
  `include "simd_wrapper_scntl_to_simd_regfile_instance_assignments.vh"

  wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__write_address   ;
  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  ldst__memc__write_data      ; 
  wire  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__read_address    ;
  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__ldst__read_data       ; 

  simd_wrapper simd_wrapper (

            //-------------------------------
            // SIMD regFile control to stOp
            `include "pe_simd_instance_ports.vh"

            //-------------------------------
            // PE control to stOp via simd
            `include "pe_cntl_simd_instance_ports.vh"

            //-------------------------------
            // Additional PE control
            .cntl__simd__tag_valid     ( cntl__simd__tag_valid     ),
            .cntl__simd__tag           ( cntl__simd__tag           ),
            .cntl__simd__tag_optionPtr ( cntl__simd__tag_optionPtr ),  // operation PC for simd
            .cntl__simd__tag_num_lanes ( cntl__simd__tag_num_lanes ),
            .simd__cntl__tag_ready     ( simd__cntl__tag_ready     ),

            //-------------------------------
            // Result from stOp to regFile
            .scntl__reg__valid         ( scntl__reg__valid         ),
            .scntl__reg__cntl          ( scntl__reg__cntl          ),
            .scntl__reg__data          ( scntl__reg__data          ),
            .reg__scntl__ready         ( reg__scntl__ready         ),
            //`include "simd_wrapper_scntl_to_simd_regfile_instance_ports.vh"

            //--------------------------------------------------
            // Additional control to stack upstream 
            .simd__sui__tag            ( simd__sui__tag            ),
            .simd__sui__tag_num_lanes  ( simd__sui__tag_num_lanes  ),

            //-------------------------------------------------------------------------------------------------
            // SIMD Registers to Stack Up 
            // 
            .simd__sui__regs_valid        ( simd__sui__regs_valid    ),
            .simd__sui__regs_cntl         ( simd__sui__regs_cntl     ),
            .simd__sui__regs              ( simd__sui__regs          ),
            .sui__simd__regs_complete     ( sui__simd__regs_complete ),
            .sui__simd__regs_ready        ( sui__simd__regs_ready    ),

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
            // General
            //
            .peId                         ( sys__pe__peId          ),
            .clk                          ( clk                    ),
            .reset_poweron                ( reset_poweron          )
                          
  );


  //-------------------------------------------------------------------------------------------------
  // Controller
  // 
  streamingOps_cntl streamingOps_cntl (

                          //------------------------------------------------------------
                          // PE core interface
                          .ready             ( pe__sys__ready     ), // ready to start streaming
                          .complete          ( pe__sys__complete  ),  // FIXME
                          
                          //------------------------------------------------------------
                          // General system signals
                          .sys__pe__allSynchronized  (sys__pe__allSynchronized ),  // all PE streams are complete
                          .pe__sys__thisSynchronized (pe__sys__thisSynchronized),  // this PE's streams are complete
                          
                          //------------------------------------------------------------
                          // stOp NoC Interface(s)
                          // connections to datapath made via mem_acc_control python script
                          //`include "streamingOps_cntl_stOp_instance_ports.vh"
                          //`include "streamingOps_cntl_noc_instance_ports.vh"
                          
                          //------------------------------------------------------------
                          // connections to datapath made via mem_acc_control python script
                          `include "streamingOps_cntl_control_instance_ports.vh"
                          
                          //------------------------------------------------------------
                           // Memory Access Interface                                      
                          .scntl__memc__request      ( scntl__memc__request             ),
                          .memc__scntl__granted      ( memc__scntl__granted             ),
                          .scntl__memc__released     ( scntl__memc__released            ),

                          //------------------------------------------------------------
                          // external interface
                          .ext_enable        (  ),
                          .ext_ready         ( 1'b1 ),  // FIXME
                          .ext_start         (  ),
                          .ext_complete      ( 1'b1 ),  // FIXME

                          //------------------------------------------------------------
                           // Result to simd regFile 
                          `include "streamingOps_cntl_to_simd_regfile_instance_ports.vh"

                          //------------------------------------------------------------
                           // Result from stOp to simd regFile
                          `include "streamingOps_cntl_stOp_to_cntl_regfile_instance_ports.vh"

                          //------------------------------------------------------------
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
   
        wire                                         scntl__memc__request           ;
        wire                                         memc__scntl__granted           ;
        wire                                         scntl__memc__released          ;
      
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
      
        wire                                         scntl__dma__strm0_read_enable         ;
        wire                                         scntl__dma__strm0_write_enable        ;
        wire                                         dma__scntl__strm0_read_complete       ;
        wire                                         dma__scntl__strm0_write_complete      ;
        wire  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  scntl__dma__strm0_read_start_address  ;  // streaming op arg0
        wire  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  scntl__dma__strm0_write_start_address ;  // streaiming op result start address
        wire  [`DMA_CONT_DATA_TYPES_RANGE         ]  scntl__dma__type0         ;
        wire  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ]  scntl__dma__num_of_types0 ;

        `ifndef DMA_CONT_ONLY_ONE_PORT 
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
 
          wire                                         scntl__dma__strm1_read_enable         ;
          wire                                         scntl__dma__strm1_write_enable        ;
          wire                                         dma__scntl__strm1_read_complete       ;
          wire                                         dma__scntl__strm1_write_complete      ;
          wire  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  scntl__dma__strm1_read_start_address  ;  // streaming op arg1
          wire  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  scntl__dma__strm1_write_start_address ;  // streaiming op result start address
          wire  [`DMA_CONT_DATA_TYPES_RANGE         ]  scntl__dma__type1         ;
          wire  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ]  scntl__dma__num_of_types1 ;
        `endif
   
        wire                                         reg__stOp__ready         ;
        wire                                         stOp__reg__valid         ;
        wire   [`STREAMING_OP_RESULT_RANGE        ]  stOp__reg__data          ;
        wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  stOp__reg__cntl          ; 

        wire  [`STREAMING_OP_CNTL_OPERATION_RANGE ]  scntl__dma__operation     ;

        wire                                                          stOp__scntl__complete          ;
        wire                                                          scntl__stOp__strm0_enable      ;
        wire                                                          scntl__stOp__strm1_enable      ;
        wire                                                          stOp__scntl__strm0_ready       ;
        wire                                                          stOp__scntl__strm1_ready       ;
        wire                                                          stOp__scntl__strm0_complete    ;
        wire                                                          stOp__scntl__strm1_complete    ;
        wire  [`STREAMING_OP_CNTL_OPERATION_RANGE ]                   scntl__stOp__operation         ;
        wire  [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ]  scntl__stOp__strm0_source      ;
        wire  [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ]  scntl__stOp__strm1_source      ;
        wire  [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ]  scntl__stOp__strm0_destination ;
        wire  [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ]  scntl__stOp__strm1_destination ;


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
                                 .scntl__stOp__operation          ( scntl__stOp__operation          ),

                                 // Stream 0
                                 .scntl__stOp__strm0_enable       ( scntl__stOp__strm0_enable       ),
                                 .stOp__scntl__strm0_ready        ( stOp__scntl__strm0_ready        ),
                                 .stOp__scntl__strm0_complete     ( stOp__scntl__strm0_complete     ),
                                 .scntl__stOp__strm0_source       ( scntl__stOp__strm0_source       ),
                                 .scntl__stOp__strm0_destination  ( scntl__stOp__strm0_destination  ),

                                 // Stream 1
                                 .scntl__stOp__strm1_enable       ( scntl__stOp__strm1_enable       ),
                                 .stOp__scntl__strm1_ready        ( stOp__scntl__strm1_ready        ),
                                 .stOp__scntl__strm1_complete     ( stOp__scntl__strm1_complete     ),
                                 .scntl__stOp__strm1_source       ( scntl__stOp__strm1_source       ),
                                 .scntl__stOp__strm1_destination  ( scntl__stOp__strm1_destination  ),

                                 //--------------------------------------------------------------------------------
                                 // DMA Control

                                 .scntl__dma__operation                 ( scntl__dma__operation                 ),

                                 // Stream 0

                                 .scntl__dma__type0                     ( scntl__dma__type0                     ),
                                 .scntl__dma__num_of_types0             ( scntl__dma__num_of_types0             ),

                                 // dma read
                                 .scntl__dma__strm0_read_enable         ( scntl__dma__strm0_read_enable         ),
                                 .dma__scntl__strm0_read_ready          ( dma__scntl__strm0_read_ready          ),
                                 .dma__scntl__strm0_read_complete       ( dma__scntl__strm0_read_complete       ),
                                 .scntl__dma__strm0_read_start_address  ( scntl__dma__strm0_read_start_address  ),
                                 // dma write
                                 .scntl__dma__strm0_write_enable        ( scntl__dma__strm0_write_enable        ),
                                 .dma__scntl__strm0_write_ready         ( dma__scntl__strm0_write_ready         ),
                                 .dma__scntl__strm0_write_complete      ( dma__scntl__strm0_write_complete      ),
                                 .scntl__dma__strm0_write_start_address ( scntl__dma__strm0_write_start_address ),

                                 `ifndef DMA_CONT_ONLY_ONE_PORT 
                                   // Stream 1
                                
                                   .scntl__dma__type1                     ( scntl__dma__type1                     ),
                                   .scntl__dma__num_of_types1             ( scntl__dma__num_of_types1             ),
                                
                                   // dma read
                                   .scntl__dma__strm1_read_enable         ( scntl__dma__strm1_read_enable         ),
                                   .dma__scntl__strm1_read_ready          ( dma__scntl__strm1_read_ready          ),
                                   .dma__scntl__strm1_read_complete       ( dma__scntl__strm1_read_complete       ),
                                   .scntl__dma__strm1_read_start_address  ( scntl__dma__strm1_read_start_address  ),
                                   // dma write
                                   .scntl__dma__strm1_write_enable        ( scntl__dma__strm1_write_enable        ),
                                   .dma__scntl__strm1_write_ready         ( dma__scntl__strm1_write_ready         ),
                                   .dma__scntl__strm1_write_complete      ( dma__scntl__strm1_write_complete      ),
                                   .scntl__dma__strm1_write_start_address ( scntl__dma__strm1_write_start_address ),
                                 `endif
                                                                
                                                                                                  
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

                                 `ifndef DMA_CONT_ONLY_ONE_PORT 
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
                                 `endif
                                                                                                  
                                 //--------------------------------------------------------------------------------
                                 // Result interface           
                                 .reg__stOp__ready               ( reg__stOp__ready               ),
                                 .stOp__reg__valid               ( stOp__reg__valid               ),
                                 .stOp__reg__data                ( stOp__reg__data                ),
                                 .stOp__reg__cntl                ( stOp__reg__cntl                ),

                                                                                                       
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

  //`include "streamingOps_cntl_stOp_noc_connections.vh"

  // Stack Interface Downstream to Streaming Op
  `include "pe_stack_interface_to_stOp_connections.vh"




  //-------------------------------------------------------------------------------------------------
  // Memory Controller


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
            .scntl__memc__request            ( scntl__memc__request           ), 
            .memc__scntl__granted            ( memc__scntl__granted           ),
            .scntl__memc__released           ( scntl__memc__released          ),

            `include "mem_acc_cont_instance_ports.vh"
            //`include "mem_acc_cont_unused_streams.vh"

            .clk                         ( clk             ),
            .reset_poweron               ( reset_poweron   )

    );




endmodule

