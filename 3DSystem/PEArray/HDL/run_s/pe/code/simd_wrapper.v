/*********************************************************************************************

    File name   : simd_wrapper.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module takes instantiates the SIMD core and provides conenctions to/from the other PE functions

                  stOp
                    - provides a regFile interface to communicate with the streamingOps
                  Local memory
                    - provides a means to arbittrate for the local memory 

                 Name: simd

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "pe_cntl.vh"
`include "simd_core.vh"
`include "simd_wrapper.vh"
`include "stack_interface.vh"
`include "noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"




module simd_wrapper (

                          //-------------------------------
                          // PE control configuration to stOp via simd
                          //
                          // Common (Scalar) Register(s)                
                          // Common (Scalar) Register(s)                
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__rs0   ,
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__rs1   ,
                                                                                
                          // Lane Register(s)                                  
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__lane_r128  [`PE_NUM_OF_EXEC_LANES ] ,
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__lane_r129  [`PE_NUM_OF_EXEC_LANES ] ,
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__lane_r130  [`PE_NUM_OF_EXEC_LANES ] ,
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__lane_r131  [`PE_NUM_OF_EXEC_LANES ] ,
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__lane_r132  [`PE_NUM_OF_EXEC_LANES ] ,
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__lane_r133  [`PE_NUM_OF_EXEC_LANES ] ,
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__lane_r134  [`PE_NUM_OF_EXEC_LANES ] ,
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      cntl__simd__lane_r135  [`PE_NUM_OF_EXEC_LANES ] ,
                          //`include "pe_cntl_simd_ports.vh"
                          //`include "pe_simd_wrapper_input_port_declarations.vh"

                          //-------------------------------
                          // Configuration output to stOp
                          //
                          // Lane Registers                 
                          // Common (Scalar) Register(s)                
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__rs0   ,
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__rs1   ,
                                                                               
                          // Lane Register(s)                                  
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__lane_r128  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__lane_r129  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__lane_r130  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__lane_r131  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__lane_r132  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__lane_r133  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__lane_r134  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__scntl__lane_r135  [`PE_NUM_OF_EXEC_LANES ] ,
                          //`include "pe_simd_ports.vh"
                          //`include "pe_simd_wrapper_output_port_declarations.vh"

                          //-------------------------------
                          // Additional PE control configuration 
                          input  wire                                            cntl__simd__tag_valid          ,  // tag to simd needs to be a fifo interface as the next stOp may start while the 
                          input  wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE   ]      cntl__simd__tag                ,
                          input  wire   [`PE_CNTL_OOB_OPTION_RANGE        ]      cntl__simd__tag_optionPtr      , 
                          input  wire   [`PE_NUM_LANES_RANGE              ]      cntl__simd__tag_num_lanes      ,  // number of active lanes associated with this tag
                          output reg                                             simd__cntl__tag_ready          ,

                          //-------------------------------
                          // Result from stOp to regFile (via scntl)
                          input  wire   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      scntl__reg__valid                          ,
                          input  wire   [`COMMON_STD_INTF_CNTL_RANGE      ]      scntl__reg__cntl  [`PE_NUM_OF_EXEC_LANES ] ,
                          input  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      scntl__reg__data  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg    [`PE_NUM_OF_EXEC_LANES_RANGE      ]      reg__scntl__ready                          ,
                          //`include "simd_wrapper_scntl_to_simd_regfile_ports_declaration.vh"
                          //`include "simd_wrapper_scntl_to_simd_regfile_ports.vh"

                          //--------------------------------------------------
                          // SIMD to stOp 
                          output reg   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      reg__scntl__valid                          ,
                          output reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      reg__scntl__cntl  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg   [`PE_EXEC_LANE_WIDTH_RANGE        ]      reg__scntl__data  [`PE_NUM_OF_EXEC_LANES ] ,
                          input  wire  [`PE_NUM_OF_EXEC_LANES_RANGE      ]      scntl__reg__ready                          ,

                          //--------------------------------------------------
                          // Register(s) to stack upstream
                          output reg   [`STACK_DOWN_OOB_INTF_TAG_RANGE   ]      simd__sui__tag                                 ,
                          output reg   [`PE_NUM_LANES_RANGE              ]      simd__sui__tag_num_lanes                       ,  // number of active lanes associated with this tag
                          output reg   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      simd__sui__regs_valid                          ,
                          output reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      simd__sui__regs_cntl  [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg   [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd__sui__regs       [`PE_NUM_OF_EXEC_LANES ] ,
                          output reg                                            simd__sui__send                                ,
                          input  reg                                            sui__simd__regs_complete                       ,
                          input  reg                                            sui__simd__regs_ready                          ,
                                                                                 
                                                                                 
                          //-------------------------------                      
                          // LD/ST Interface                                     
                          output wire                                            ldst__memc__request         ,
                          input  wire                                            memc__ldst__granted         ,
                          output wire                                            ldst__memc__released        ,
                          //                                                                                 
                          output wire                                            ldst__memc__write_valid     ,  // Valid must remain active for entire DMA
                          output wire [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]      ldst__memc__write_address   ,
                          output wire [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]      ldst__memc__write_data      ,
                          input  wire                                            memc__ldst__write_ready     ,  // output wire flow control to ldst
                          output wire                                            ldst__memc__read_valid      ,
                          output wire [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]      ldst__memc__read_address    ,
                          input  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]      memc__ldst__read_data       ,
                          input  wire                                            memc__ldst__read_data_valid ,  // Valid must remain active for entire DMA, only accepted when ready is asserted
                          input  wire                                            memc__ldst__read_ready      ,  // output wire flow control to ldst, valid only "valid" when ready is asserted
                          output wire                                            ldst__memc__read_pause      ,  // pipeline flow control from ldst, dont send any more requests
                                                                                 
                          //--------------------------------------------------------------------------------------------------------
                          // System                                              
                          input  wire   [`PE_PE_ID_RANGE                  ]      peId                        , 
                          input  wire                                            clk                         ,
                          input  wire                                            reset_poweron               
    );



  
  //----------------------------------------------------------------------------------------------------
  // Registers/Wires
  //
  //`include "simd_wrapper_scntl_to_simd_regfile_wires.vh"

  // store in reg before transferring to simd
  reg   [`PE_EXEC_LANE_WIDTH_RANGE     ]  allLanes_results  [`PE_NUM_OF_EXEC_LANES ]      ;
  reg   [`PE_NUM_OF_EXEC_LANES_RANGE   ]  allLanes_valid                                  ;
                                                                                          
  wire                                    return_data_to_upstream                         ;
  wire                                    end_of_data                                     ;
  wire                                    tag_and_data_ready                              ;

  wire  [`STACK_DOWN_OOB_INTF_TAG_RANGE]  simd__sui__tag_e1                                  ;
  reg   [`PE_NUM_LANES_RANGE           ]  simd__sui__tag_num_lanes_e1                        ;  // number of active lanes associated with this tag
  wire  [`PE_NUM_OF_EXEC_LANES_RANGE   ]  simd__sui__regs_valid_e1                           ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE   ]  simd__sui__regs_cntl_e1   [`PE_NUM_OF_EXEC_LANES ] ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE     ]  simd__sui__regs_e1        [`PE_NUM_OF_EXEC_LANES ] ;
  wire                                    simd__sui__send_e1                                 ;

  reg                                     sui__simd__regs_complete_d1                     ;
  reg                                     sui__simd__regs_ready_d1                        ;
                                                                                          
  reg                                     cntl__simd__tag_valid_d1                        ;
  reg   [`STACK_DOWN_OOB_INTF_TAG_RANGE]  cntl__simd__tag_d1                              ; 
  reg   [`PE_CNTL_OOB_OPTION_RANGE     ]  cntl__simd__tag_optionPtr_d1                    ; 
  reg   [`PE_NUM_LANES_RANGE           ]  cntl__simd__tag_num_lanes_d1                    ;  

  reg   [`PE_NUM_OF_EXEC_LANES_RANGE   ]  scntl__reg__valid_d1                            ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE   ]  scntl__reg__cntl_d1  [`PE_NUM_OF_EXEC_LANES ]   ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE     ]  scntl__reg__data_d1  [`PE_NUM_OF_EXEC_LANES ]   ;

  reg   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      reg__scntl__valid_e1                          ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE      ]      reg__scntl__cntl_e1  [`PE_NUM_OF_EXEC_LANES ] ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE        ]      reg__scntl__data_e1  [`PE_NUM_OF_EXEC_LANES ] ;
  reg   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      scntl__reg__ready_d1                          ;


  wire  [`PE_NUM_OF_EXEC_LANES_RANGE   ]  smdw__simd__regs_valid                          ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE     ]  smdw__simd__regs      [`PE_NUM_OF_EXEC_LANES ]  ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE   ]  smdw__simd__regs_cntl [`PE_NUM_OF_EXEC_LANES ]  ;

  wire                                    simd__smdw__processing                          ;
  wire                                    simd__smdw__sending                             ;
  wire                                    simd__smdw__complete                            ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE     ]  simd__smdw__regs      [`PE_NUM_OF_EXEC_LANES ]  ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE   ]  simd__smdw__regs_cntl [`PE_NUM_OF_EXEC_LANES ]  ;

  // output of option pointer table
  reg                                                simd_enable                                                         ;
  reg   [`SIMD_CORE_OPERATION_RANGE              ]   simd_operation                                                      ;
  reg   [`SIMD_WRAP_OPERATION_TYPE_RANGE         ]   simd_wrapper_op               [`SIMD_WRAP_OPERATION_NUM_OF_STAGES ] ;
  reg   [`PE_EXEC_LANE_ID_RANGE                  ]   simd_wrapper_op_idx                                                 ;
  reg                                                simd_wrapper_op_inc                                                 ;

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //
  genvar lane;
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES ; lane=lane+1) 
      begin: reg_to_simd_out 
        always @(posedge clk)
          begin
            reg__scntl__valid    [lane]  <= ( reset_poweron ) ? 'd0 : reg__scntl__valid_e1 [lane]  ;
            reg__scntl__cntl     [lane]  <= ( reset_poweron ) ? 'd0 : reg__scntl__cntl_e1  [lane]  ;
            reg__scntl__data     [lane]  <= ( reset_poweron ) ? 'd0 : reg__scntl__data_e1  [lane]  ;
            scntl__reg__ready_d1 [lane]  <= ( reset_poweron ) ? 'd0 : scntl__reg__ready    [lane]  ;
          end
      end
  endgenerate

  genvar gvi;
  generate
    always @(posedge clk)
      begin
        simd__scntl__rs0  <= ( reset_poweron ) ? 'd0 : cntl__simd__rs0 ;
        simd__scntl__rs1  <= ( reset_poweron ) ? 'd0 : cntl__simd__rs1 ;
      end
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES ; gvi=gvi+1) 
      begin: scntl_output_regFile
        always @(posedge clk)
          begin
            simd__scntl__lane_r128 [gvi]  <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r128 [gvi]  ;
            simd__scntl__lane_r129 [gvi]  <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r129 [gvi]  ;
            simd__scntl__lane_r130 [gvi]  <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r130 [gvi]  ;
            simd__scntl__lane_r131 [gvi]  <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r131 [gvi]  ;
            simd__scntl__lane_r132 [gvi]  <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r132 [gvi]  ;
            simd__scntl__lane_r133 [gvi]  <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r133 [gvi]  ;
            simd__scntl__lane_r134 [gvi]  <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r134 [gvi]  ;
            simd__scntl__lane_r135 [gvi]  <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r135 [gvi]  ;
          end
      end
  endgenerate

  assign  simd__sui__send_e1  =  simd__smdw__sending  ;
  generate
    always @(posedge clk)
      begin
        simd__sui__tag               <= ( reset_poweron ) ? 'd0 : simd__sui__tag_e1            ;
        simd__sui__tag_num_lanes     <= ( reset_poweron ) ? 'd0 : simd__sui__tag_num_lanes_e1  ;
        simd__sui__regs_valid        <= ( reset_poweron ) ? 'd0 : simd__sui__regs_valid_e1     ;
        simd__sui__send              <= ( reset_poweron ) ? 'd0 : simd__sui__send_e1           ;
      end
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES ; gvi=gvi+1) 
      begin: sui_output_regFile
        always @(posedge clk)
          begin
            simd__sui__regs_cntl [gvi]  <= ( reset_poweron ) ? 'd0 :  simd__sui__regs_cntl_e1 [gvi];
            simd__sui__regs      [gvi]  <= ( reset_poweron ) ? 'd0 :  simd__sui__regs_e1      [gvi];
          end
      end
  endgenerate

  //----------------------------------------------------------------------
  // Registered inputs
  always @(posedge clk)
    begin
      sui__simd__regs_complete_d1       <= ( reset_poweron ) ? 'd0 : sui__simd__regs_complete   ;
      sui__simd__regs_ready_d1          <= ( reset_poweron ) ? 'd0 : sui__simd__regs_ready      ;
                                                                                               
      cntl__simd__tag_valid_d1          <= ( reset_poweron ) ? 'd0 : cntl__simd__tag_valid      ;
      cntl__simd__tag_d1                <= ( reset_poweron ) ? 'd0 : cntl__simd__tag            ;
      cntl__simd__tag_optionPtr_d1      <= ( reset_poweron ) ? 'd0 : cntl__simd__tag_optionPtr  ;
      cntl__simd__tag_num_lanes_d1      <= ( reset_poweron ) ? 'd0 : cntl__simd__tag_num_lanes  ;

    end

  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES ; gvi=gvi+1) 
      begin: scntl_input_reg
        always @(posedge clk)
          begin
            scntl__reg__valid_d1 [gvi]  <= ( reset_poweron ) ? 'd0 : scntl__reg__valid [gvi]  ;
            scntl__reg__cntl_d1  [gvi]  <= ( reset_poweron ) ? 'd0 : scntl__reg__cntl  [gvi]  ;
            scntl__reg__data_d1  [gvi]  <= ( reset_poweron ) ? 'd0 : scntl__reg__data  [gvi]  ;
          end
      end
  endgenerate

  //----------------------------------------------------------------------
  // Update each lanes regFile with result from streaming operation module 


  //----------------------------------------------------------------------------------------------------
  // Result FIFO
  //
  // We FIFO tags and associated results to allow the SIMD to start operating
  // on one stOp result while the next is being processd
  // This is designed to minimize slack on the stack bus
  //

  // create a vector of the data fifo pipe valid's
  wire [`PE_EXEC_LANE_WIDTH_RANGE      ]  from_stOp_reg_fifo_valids ;
  // create a vector of reads for the FSM
  wire [`PE_EXEC_LANE_WIDTH_RANGE      ]  from_stOp_reg_fifo_reads  ;
  // create a vector of cntl/data for the FSM
  wire [`COMMON_STD_INTF_CNTL_RANGE    ]  from_stOp_reg_fifo_pipe_cntl [`PE_NUM_OF_EXEC_LANES ]   ;
  wire [`PE_EXEC_LANE_WIDTH_RANGE      ]  from_stOp_reg_fifo_pipe_data [`PE_NUM_OF_EXEC_LANES ]   ;
  wire [`PE_EXEC_LANE_WIDTH_RANGE      ]  from_stOp_reg_fifo_pipe_eom                             ;

  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES; gvi=gvi+1) 
      begin: from_StOp_Reg_Fifo

        // Write data
        wire   [`COMMON_STD_INTF_CNTL_RANGE    ]          write_cntl       ;
        wire   [`PE_EXEC_LANE_WIDTH_RANGE      ]          write_data       ;
                                                                           
        // Read data                                                       
        wire                                              pipe_valid       ; 
        wire   [`COMMON_STD_INTF_CNTL_RANGE    ]          pipe_cntl        ;
        wire   [`PE_EXEC_LANE_WIDTH_RANGE      ]          pipe_data        ;

        // Control
        wire                                              clear            ; 
        wire                                              almost_full      ; 
        wire                                              pipe_read        ; 
        wire                                              write            ; 

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`SIMD_WRAP_REG_FROM_SCNTL_FIFO_DEPTH               ), 
                                 .GENERIC_FIFO_THRESHOLD  (`SIMD_WRAP_REG_FROM_SCNTL_FIFO_THRESHOLD           ),
                                 .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`PE_EXEC_LANE_WIDTH    )
                                  ) gpfifo (
                                          // Status
                                         .almost_full      ( almost_full                  ),
                                          // Write
                                         .write            ( write                        ),
                                         .write_data       ( {write_cntl, write_data}     ),
                                          // Read
                                         .pipe_valid       ( pipe_valid                   ),
                                         .pipe_read        ( pipe_read                    ),
                                         .pipe_data        ( {pipe_cntl, pipe_data}       ),

                                         // General
                                         .clear            ( clear                        ),
                                         .reset_poweron    ( reset_poweron                ),
                                         .clk              ( clk                          )
                                         );

        assign write                           =   scntl__reg__valid [gvi]   ;
        assign write_cntl                      =   scntl__reg__cntl  [gvi]   ;
        assign write_data                      =   scntl__reg__data  [gvi]   ;
        assign clear                           =   1'b0                      ;  // just in case

        // The FSM needs a vector of pipe valid signals
        assign from_stOp_reg_fifo_valids    [gvi] = pipe_valid               ; 
        assign from_stOp_reg_fifo_pipe_cntl [gvi] = pipe_cntl                ; 
        assign from_stOp_reg_fifo_pipe_data [gvi] = pipe_data                ; 

        assign reg__scntl__ready            [gvi] = ~almost_full             ;

        // FSM will drive read for each lane, most likely all together
        assign pipe_read = from_stOp_reg_fifo_reads [gvi]  ;


        assign from_stOp_reg_fifo_pipe_eom [gvi] =  (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM);
      end
  endgenerate

         

  //----------------------------------------------------------------------------------------------------
  // Tag FIFO
  //

  reg   [`PE_EXEC_LANES_VEC_RANGE        ]          pipe_tag_lane_valid ;  // bitmask of active lanes for this operation
  //reg    [`PE_EXEC_LANES_VEC_RANGE        ]      lane_valid  ;

  // Put in a generate in case we decide to extend to multiple fifo's
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Cntl_Tag_Fifo

        // Write data
        wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]          write_tag           ;
        wire   [`PE_CNTL_OOB_OPTION_RANGE       ]          write_tag_optionPtr ; 
        wire   [`PE_NUM_LANES_RANGE             ]          write_tag_num_lanes ;  // number of active lanes associated with this tag
                                                 
        // Read data                              
        wire                                               pipe_valid          ; 
        wire                                               pipe_read           ; 
        wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]          pipe_tag            ;
        wire   [`PE_CNTL_OOB_OPTION_RANGE       ]          pipe_tag_optionPtr  ; 
        wire   [`PE_NUM_LANES_RANGE             ]          pipe_tag_num_lanes  ;  // number of active lanes associated with this tag

        // Control
        wire                                               clear               ; 
        wire                                               almost_full         ; 
        wire                                               write               ; 

        // FIXME: Combine FIFO's for synthesis
        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH (`SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH                 ), 
                       .GENERIC_FIFO_THRESHOLD       (`SIMD_WRAP_TAG_FROM_CNTL_FIFO_ALMOST_FULL_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH      (`SIMD_WRAP_TAG_FROM_CNTL_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                          // Status
                                         .almost_full      ( almost_full                      ),
                                          // Write                                            
                                         .write            ( write                            ),
                                         .write_data       ( {write_tag_optionPtr, write_tag_num_lanes, write_tag} ),
                                          // Read                                          
                                         .pipe_valid       ( pipe_valid                       ),
                                         .pipe_read        ( pipe_read                        ),
                                         .pipe_data        ( {pipe_tag_optionPtr, pipe_tag_num_lanes, pipe_tag}   ),
                                                                                              
                                         // General                                           
                                         .clear            ( clear                            ),
                                         .reset_poweron    ( reset_poweron                    ),
                                         .clk              ( clk                              )
                                         );

        always @(posedge clk)
          begin
            simd__cntl__tag_ready <=  ~almost_full                  ;
          end

        assign write                      =   cntl__simd__tag_valid_d1       ;
        assign write_tag                  =   cntl__simd__tag_d1             ;
        assign write_tag_optionPtr        =   cntl__simd__tag_optionPtr_d1   ;
        assign write_tag_num_lanes        =   cntl__simd__tag_num_lanes_d1   ;
        assign clear                      =   1'b0                           ;  // just in case

        //
        //assign pipe_read = from_stOp_reg_fifo_reads [gvi]  ;
        assign pipe_read = return_data_to_upstream & end_of_data ;
      end
  endgenerate

  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES ; lane++)
      begin
        always @(*)
          begin
            pipe_tag_lane_valid [lane]  =  ((lane+1) <= from_Cntl_Tag_Fifo[0].pipe_tag_num_lanes) ;
          end
      end
  endgenerate

  

  //----------------------------------------------------------------------------------------------------
  // Upstream  Packet Processing FSM
  //
  // This FSM will be designed to take data from the registers from the stOp and send Upstream packet data to the
  // simd_upstream_intf module to create an upstream packet.
  // Its likely this FSM will take instruction from the SIMD or directly from the pe controller (pe_cntl)
  // For now it immediately takes the stOp result and send it to the simd_upstream_intf  module.
  //
  // Note: We might also want to buffer up more result data before sending
  //
  
  reg   [`SIMD_WRAP_UPSTREAM_CNTL_STATE_RANGE ] simd_wrap_upstream_cntl_state      ; // state flop
  reg   [`SIMD_WRAP_UPSTREAM_CNTL_STATE_RANGE ] simd_wrap_upstream_cntl_state_next ;
  
  

  // State register 
  always @(posedge clk)
    begin
      simd_wrap_upstream_cntl_state <= ( reset_poweron ) ? `SIMD_WRAP_UPSTREAM_CNTL_WAIT        :
                                                            simd_wrap_upstream_cntl_state_next  ;
    end
  
  // Every cycle of the OOB packet, examine each {option, value} tuple and set local config
  // Once the packet has completed, initiate the command.
  // Note: a) we might choose to start commands such as stOp as soon as the tuple is observed
  //       b) FIXME:There is currentlyno checking to see if a option is repeated or if an option is invalid
  //       c) Make error checking more robust as this is an external interface
  //
  //       FIXME: I am adding what might be redundant states as I suspect coordinating stOp's and SIMD might take a few states
  
  //assign tag_and_data_ready =  from_Cntl_Tag_Fifo[0].pipe_valid & (&(from_stOp_reg_fifo_valids | ~simd__scntl__rs1) ) ; //|(~simd__scntl__rs1))) ;
  //LEE
  assign   tag_and_data_ready  =  from_Cntl_Tag_Fifo[0].pipe_valid & (&(from_stOp_reg_fifo_valids | ~pipe_tag_lane_valid ) ) ; // only start once all stOp lanes active in the operation have returned data

  assign   end_of_data         =  (&((from_stOp_reg_fifo_valids & from_stOp_reg_fifo_pipe_eom) | ~pipe_tag_lane_valid ) ) ; // if stOp is sending multiple regs, as in MULT op then packetize all
 
  always @(*)
    begin
      case (simd_wrap_upstream_cntl_state)  // synopsys parallel_case

        
        `SIMD_WRAP_UPSTREAM_CNTL_WAIT: 
          simd_wrap_upstream_cntl_state_next =  ( tag_and_data_ready && sui__simd__regs_ready_d1) ? `SIMD_WRAP_UPSTREAM_CNTL_CHECK_SIMD_ENABLE :  // check simd option memory
                                                                                                    `SIMD_WRAP_UPSTREAM_CNTL_WAIT              ;
  
        // check simd enable bit in simd operation memory
        `SIMD_WRAP_UPSTREAM_CNTL_CHECK_SIMD_ENABLE: 
          simd_wrap_upstream_cntl_state_next =  //( ~simd_enable ) ? `SIMD_WRAP_UPSTREAM_CNTL_SENT_DATA     :  // start the data transfer to the sui with data from stOp
                                                                   `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_START ;  // SIMD will provide data
          
        `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_START: 
          simd_wrap_upstream_cntl_state_next =  (simd__smdw__processing ) ? `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_COMPLETE    : 
                                                                            `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_START       ;  // start the data transfer to the sui with data from simd
          
        `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_COMPLETE: 
          simd_wrap_upstream_cntl_state_next =  (simd__smdw__sending  ) ? `SIMD_WRAP_UPSTREAM_CNTL_SENT_DATA              : 
                                                (simd__smdw__complete ) ? `SIMD_WRAP_UPSTREAM_CNTL_COMPLETE               : 
                                                                          `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_COMPLETE ;  // start the data transfer to the sui with data from simd
          
        `SIMD_WRAP_UPSTREAM_CNTL_SENT_DATA: 
          
          // Assert a valid pulse to the SIMD core but dont read fifo until SIMD asserts comlete
          simd_wrap_upstream_cntl_state_next =  `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_COMPLETE          ;


        `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_COMPLETE:
          simd_wrap_upstream_cntl_state_next =   ( sui__simd__regs_complete_d1 ) ? `SIMD_WRAP_UPSTREAM_CNTL_WAIT_COMPLETE_DEASSERTED   : 
                                                                                   `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_COMPLETE          ;


        `SIMD_WRAP_UPSTREAM_CNTL_WAIT_COMPLETE_DEASSERTED:
          simd_wrap_upstream_cntl_state_next =   ( ~sui__simd__regs_complete_d1 ) ? `SIMD_WRAP_UPSTREAM_CNTL_WAIT_COMPLETE_DEASSERTED   : 
                                                                                    `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_COMPLETE     ;

        `SIMD_WRAP_UPSTREAM_CNTL_COMPLETE:
          simd_wrap_upstream_cntl_state_next =   `SIMD_WRAP_UPSTREAM_CNTL_WAIT    ; 

        // Latch state on error
        `SIMD_WRAP_UPSTREAM_CNTL_ERR:
          simd_wrap_upstream_cntl_state_next = `SIMD_WRAP_UPSTREAM_CNTL_ERR ;
  
        default:
          simd_wrap_upstream_cntl_state_next = `SIMD_WRAP_UPSTREAM_CNTL_WAIT ;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //

  
  wire    smdw__simd__cfg_valid  = (simd_wrap_upstream_cntl_state == `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_SIMD_START    ) ;


  // read the FIFO and assert the valid to the stack upstream interface
  assign   return_data_to_upstream               = (simd_wrap_upstream_cntl_state == `SIMD_WRAP_UPSTREAM_CNTL_SENT_DATA) ;
  //assign from_stOp_reg_fifo_reads = {`PE_NUM_OF_EXEC_LANES { return_data_to_upstream }} & from_stOp_reg_fifo_valids ;  // only read the lanes that were active
  assign from_stOp_reg_fifo_reads = {`PE_NUM_OF_EXEC_LANES { return_data_to_upstream }} & pipe_tag_lane_valid ;  // only read the lanes that were active


  assign  simd__sui__tag_e1             =  from_Cntl_Tag_Fifo[0].pipe_tag ;
  assign  simd__sui__tag_num_lanes_e1   =  from_Cntl_Tag_Fifo[0].pipe_tag_num_lanes ;

/*
  assign  simd__sui__regs_valid_e1      =  {`PE_NUM_OF_EXEC_LANES { return_data }} & simd__scntl__rs1 ;

  assign  simd__sui__regs_cntl_e1       =  //(~simd_enable ) ? from_stOp_reg_fifo_pipe_cntl   :
                                                             simd__smdw__regs_cntl          ;
                                                             

  assign  simd__sui__regs_e1            =  //(~simd_enable ) ? from_stOp_reg_fifo_pipe_data   :
                                                             simd__smdw__regs               ;
                                                             
*/
  assign  smdw__simd__regs_cntl         =  from_stOp_reg_fifo_pipe_cntl   ;
  assign  smdw__simd__regs              =  from_stOp_reg_fifo_pipe_data   ;
  assign  smdw__simd__regs_valid        =  pipe_tag_lane_valid            ;
  //assign  smdw__simd__regs_valid        =  from_stOp_reg_fifo_valids & {`PE_NUM_OF_EXEC_LANES { (simd_wrap_upstream_cntl_state == `SIMD_WRAP_UPSTREAM_CNTL_CHECK_SIMD_ENABLE) & simd_enable }} & simd__scntl__rs1 ; // pulse valid to simd


  //-------------------------------------------------------------------------------------------------
  // SIMD core
  // 
  //
  wire   [`PE_EXEC_LANE_WIDTH_RANGE          ]    simd__smdw__common_regs_valid [`PE_NUM_OF_EXEC_LANES ] ;
  wire   [`PE_EXEC_LANE_WIDTH_RANGE          ]    simd__smdw__common_regs       [`PE_NUM_OF_EXEC_LANES ] ;
  
  simd_core simd_core (

            .cntl__simd__cfg_valid           ( smdw__simd__cfg_valid          ),  // load PC
            .cntl__simd__cfg_operation       ( simd_operation                 ),  // operation PC for simd
            .cntl__simd__cfg_wrap_op_idx     ( simd_wrapper_op_idx            ),
            .cntl__simd__cfg_wrap_op_inc     ( simd_wrapper_op_inc            ),
            .cntl__simd__cfg_wrap_op         ( simd_wrapper_op                ),  // operations before SIMD
                                                                              
            //.smdw__simd__regs_valid        ( smdw__simd__regs_valid         ),  // start SIMD
            //.smdw__simd__regs_cntl         ( smdw__simd__regs_cntl          ),        
            //.smdw__simd__regs              ( smdw__simd__regs               ),        
                                                                              
            .smdw__simd__regs_cntl           ( smdw__simd__regs_cntl          ),  // start SIMD
            .smdw__simd__regs_valid          ( smdw__simd__regs_valid         ),        
            .smdw__simd__regs                ( smdw__simd__regs               ),        
                                                                              
            .simd__smdw__processing          ( simd__smdw__processing         ),  // SIMD complete
            .simd__smdw__complete            ( simd__smdw__complete           ),  // SIMD complete
            .simd__smdw__sending             ( simd__smdw__sending            ),  
            .simd__smdw__regs_cntl           ( simd__sui__regs_cntl_e1        ),        
            .simd__smdw__regs_valid          ( simd__sui__regs_valid_e1       ),        
            .simd__smdw__regs                ( simd__sui__regs_e1             ),        
                                                                             
            .simd__smdw__common_regs_valid   ( simd__smdw__common_regs_valid  ),        
            .simd__smdw__common_regs         ( simd__smdw__common_regs        ),        
                                                                              
             //---------------------------                                    
             // LD/ST Interface                                              
            .ldst__memc__request             ( ldst__memc__request            ),
            .memc__ldst__granted             ( memc__ldst__granted            ),
            .ldst__memc__released            ( ldst__memc__released           ),
             // Access                                                        
            .ldst__memc__write_valid         ( ldst__memc__write_valid        ),
            .ldst__memc__write_address       ( ldst__memc__write_address      ),
            .ldst__memc__write_data          ( ldst__memc__write_data         ),
            .memc__ldst__write_ready         ( memc__ldst__write_ready        ),  // output flow control to ldst
            .ldst__memc__read_valid          ( ldst__memc__read_valid         ),
            .ldst__memc__read_address        ( ldst__memc__read_address       ),
            .memc__ldst__read_data           ( memc__ldst__read_data          ),
            .memc__ldst__read_data_valid     ( memc__ldst__read_data_valid    ),
            .memc__ldst__read_ready          ( memc__ldst__read_ready         ),  // output flow control to ldst
            .ldst__memc__read_pause          ( ldst__memc__read_pause         ),  // pipeline flow control from ldst, dont send any more requests

            //-------------------------------
            // General
            //
            .peId                         ( peId                   ),
            .clk                          ( clk                    ),
            .reset_poweron                ( reset_poweron          )
                          
  );

  //----------------------------------------------------------------------------------------------------
  // SIMD configuration memory
  //
  //  - 
  //

  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: simd_option_memory

        wire  [`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_RANGE ]   read_data ;
  
        generic_1port_memory #(.GENERIC_MEM_DEPTH          (`SIMD_WRAP_SIMD_OPTION_MEMORY_DEPTH           ),
                               .GENERIC_MEM_REGISTERED_OUT (0                                             ),
                               .GENERIC_MEM_DATA_WIDTH     (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_WIDTH )
                        ) gmemory ( 
                        
                        //---------------------------------------------------------------
                        // Initialize
                        //
                        `ifndef SYNTHESIS
                           .memFile (""),
                        `endif

                        //---------------------------------------------------------------
                        // Port 
                        .portA_address       ( from_Cntl_Tag_Fifo[0].pipe_tag_optionPtr               ),
                        .portA_write_data    ( {`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_MEMORY_WIDTH {1'b0}} ),
                        .portA_read_data     ( read_data                                              ),
                        .portA_enable        ( 1'b1                                                   ),
                        .portA_write         ( 1'b0                                                   ),
                        
                        //---------------------------------------------------------------
                        // General
                        .reset_poweron       ( reset_poweron             ),
                        .clk                 ( clk                       )
                        ) ;
      end
  endgenerate

  always @(*)
    begin
      simd_enable          =  simd_option_memory[0].read_data [`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_ENABLE_SIMD_RANGE ];
      simd_operation       =  simd_option_memory[0].read_data [`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_OP_RANGE          ];
      simd_wrapper_op_idx  =  simd_option_memory[0].read_data [`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_RANGE  ];
      simd_wrapper_op_inc  =  simd_option_memory[0].read_data [`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INC_RANGE    ];
    end

  // extract stage operations
  generate
    for (gvi=0; gvi<`SIMD_WRAP_OPERATION_NUM_OF_STAGES; gvi++)
      begin
        always @(*)
          begin
            //simd_wrapper_op       _valid  [gvi]  =  simd_option_memory[0].read_data [((`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_LSB) + gvi) : (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_VALID_LSB+gvi ) ] ;        
            simd_wrapper_op               [gvi]  =  simd_option_memory[0].read_data [((`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_LSB +(`SIMD_WRAP_OPERATION_TYPE_WIDTH -1)) + (gvi*`SIMD_WRAP_OPERATION_TYPE_WIDTH )) : (`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_STAGES_TYPE_LSB +gvi*`SIMD_WRAP_OPERATION_TYPE_WIDTH ) ] ;
          end
      end          
  endgenerate
  

  //----------------------------------------------------------------------------------------------------
  // Output to streaming Op
  //
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES ; lane=lane+1) 
      begin: reg_to_simd_out_e1 
        always @(posedge clk)
          begin
            reg__scntl__cntl_e1     [lane]  <=  `COMMON_STD_INTF_CNTL_SOM_EOM         ;
            reg__scntl__valid_e1    [lane]  <=  simd__smdw__common_regs_valid [lane]  ;
            reg__scntl__data_e1     [lane]  <=  simd__smdw__common_regs       [lane]  ;
          end
      end
  endgenerate
endmodule

