/*********************************************************************************************

    File name   : simd_core.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

    Description : This module contains the SIMD unit


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


`ifndef SYNTHESIS
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_cmp.v"
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_mac.v"
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_exp.v"
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_div.v"
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_div_seq.v"

  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_flt2i.v"
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_i2flt.v"
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_sub.v"
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_add.v"
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_exp2.v"

  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_addsub.v"
  `include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_exp2.v"
`endif


module simd_core (
                    //----------------------------------------------------------------------------------------------------
                    // Control
                    input  wire                                           cntl__simd__cfg_valid                                                ,
                    input  wire  [`SIMD_CORE_OPERATION_RANGE         ]    cntl__simd__cfg_operation                                            , 
                    input  wire  [`SIMD_WRAP_OPERATION_TYPE_RANGE    ]    cntl__simd__cfg_wrap_op        [`SIMD_WRAP_OPERATION_NUM_OF_STAGES ] ,
                    input  wire  [`PE_EXEC_LANE_ID_RANGE             ]    cntl__simd__cfg_wrap_op_idx                                          ,
                    input  wire                                           cntl__simd__cfg_wrap_op_inc                                          ,
                                                                                                                       
                    input  wire  [`PE_NUM_OF_EXEC_LANES_RANGE        ]    smdw__simd__regs_valid                           ,
                    input  wire  [`COMMON_STD_INTF_CNTL_RANGE        ]    smdw__simd__regs_cntl   [`PE_NUM_OF_EXEC_LANES ] ,
                    input  wire  [`PE_EXEC_LANE_WIDTH_RANGE          ]    smdw__simd__regs        [`PE_NUM_OF_EXEC_LANES ] ,

                    output reg                                            simd__smdw__processing                           ,
                    output reg                                            simd__smdw__complete                             ,
                    output reg   [`COMMON_STD_INTF_CNTL_RANGE        ]    simd__smdw__regs_cntl   [`PE_NUM_OF_EXEC_LANES ] ,
                    output reg   [`PE_EXEC_LANE_WIDTH_RANGE          ]    simd__smdw__regs        [`PE_NUM_OF_EXEC_LANES ] ,
                  
                    //----------------------------------------------------------------------------------------------------
                    // interface to LD/ST unit                                         
                    output reg                                            ldst__memc__request          ,
                    input  wire                                           memc__ldst__granted          ,
                    output reg                                            ldst__memc__released         ,
                    //                                                   
                    output reg                                            ldst__memc__write_valid     , 
                    output reg   [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]    ldst__memc__write_address   ,
                    output reg   [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]    ldst__memc__write_data      , 
                    input  wire                                           memc__ldst__write_ready     ,
                    output reg                                            ldst__memc__read_valid      , 
                    output reg   [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]    ldst__memc__read_address    ,
                    input  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]    memc__ldst__read_data       , 
                    input  wire                                           memc__ldst__read_data_valid , 
                    input  wire                                           memc__ldst__read_ready      , 
                    output reg                                            ldst__memc__read_pause      , 
                  
                    //----------------------------------------------------------------------------------------------------
                    // System
                    input  wire   [`PE_PE_ID_RANGE                   ]    peId                        , 
                    input  wire                                           clk                         ,
                    input  wire                                           reset_poweron               
                  
    );

  //----------------------------------------------------------------------------------------------------
  // Registers/Wires
  //

  reg                                            enable_special_function                                           ;  
  reg                                            special_functions_complete                                        ; 
  reg   [`SIMD_WRAP_OPERATION_VEC_RANGE     ]    special_function_done                                             ; 

  reg   [`SIMD_WRAP_SFU_COUNT_RANGE         ]    special_op_index                                                        ;
  reg   [`SIMD_WRAP_OPERATION_TYPE_RANGE    ]    special_op                                                              ;


  reg   [`PE_EXEC_LANE_WIDTH_RANGE          ]    special_function_value                                            ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE          ]    special_function_out        [`SIMD_CORE_OPERATION_PC_NUM_OF_OPS ] ;
  wire  [`SIMD_CORE_SFU_CMP_RANGE           ]    special_function_cmp_flag                                         ;  // eq, lt, gt
  reg                                            load_sfu_value                                                    ;

  reg                                            cntl__simd__cfg_valid_d1                                                ;
  reg   [`SIMD_CORE_OPERATION_RANGE         ]    cntl__simd__cfg_operation_d1                                            ; 
  reg   [`SIMD_WRAP_OPERATION_TYPE_RANGE    ]    cntl__simd__cfg_wrap_op_d1        [`SIMD_WRAP_OPERATION_NUM_OF_STAGES ] ;
  reg   [`PE_EXEC_LANE_ID_RANGE             ]    cntl__simd__cfg_wrap_op_idx_d1                                          ;
  reg                                            cntl__simd__cfg_wrap_op_inc_d1                                          ;


  always @(posedge clk)
    begin
      cntl__simd__cfg_valid_d1         <= (reset_poweron) ? 1'b0 : cntl__simd__cfg_valid        ;
      cntl__simd__cfg_operation_d1     <=                          cntl__simd__cfg_operation    ;
      cntl__simd__cfg_wrap_op_idx_d1   <=                          cntl__simd__cfg_wrap_op_idx  ;
      cntl__simd__cfg_wrap_op_inc_d1   <=                          cntl__simd__cfg_wrap_op_inc  ;
    end


  genvar gvi;
  generate
    for (gvi=0; gvi<`SIMD_WRAP_OPERATION_NUM_OF_STAGES; gvi++)
      begin
        always @(*)
          begin
            cntl__simd__cfg_wrap_op_d1 [gvi]  <=  cntl__simd__cfg_wrap_op [gvi];
          end
      end          
  endgenerate


  // store regs for processing
  reg   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      input_regs_valid                      ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE        ]      input_regs  [`PE_NUM_OF_EXEC_LANES ]  ;
  reg                                            simd_output_valid                     ;
  reg   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      output_regs_valid                     ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE        ]      output_regs  [`PE_NUM_OF_EXEC_LANES ] ;


  // use generate for flexibility (and cntl assignment)
  genvar lane;
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            simd__smdw__regs_cntl [lane] <= `COMMON_STD_INTF_CNTL_SOM_EOM  ;
            simd__smdw__regs      [lane] <= //( load_sfu_value ) ? special_function_value :  // FIXME
                                                                 input_regs [lane]      ;
          end
      end
  endgenerate
 
  
  always @(posedge clk)
    begin
      ldst__memc__request         <= 'd0 ;
      ldst__memc__released        <= 'd1 ;
      
      ldst__memc__write_valid     <= 'd0 ; 
      ldst__memc__write_address   <= 'd0 ;
      ldst__memc__write_data      <= 'd0 ; 
      ldst__memc__read_valid      <= 'd0 ; 
      ldst__memc__read_address    <= 'd0 ;
      ldst__memc__read_pause      <= 'd0 ; 
    end

  reg   [`SIMD_WRAP_SIMD_OPTION_MEMORY_AGGREGATE_SAVE_INDEX_RANGE ]   local_index ;  // which local register to store wrapper result

  //----------------------------------------------------------------------------------------------------
  //
  // SIMD Controller
  //
  

  reg [`SIMD_CORE_CNTL_STATE_RANGE ] simd_core_cntl_state      ; // state flop
  reg [`SIMD_CORE_CNTL_STATE_RANGE ] simd_core_cntl_state_next ;
  
  

  // State register 
  always @(posedge clk)
    begin
      simd_core_cntl_state <= ( reset_poweron ) ? `SIMD_CORE_CNTL_WAIT       :
                                                  simd_core_cntl_state_next  ;
    end
  
 
  always @(*)
    begin
      case (simd_core_cntl_state)  // synopsys parallel_case

        
        `SIMD_CORE_CNTL_WAIT: 
          simd_core_cntl_state_next =  ( cntl__simd__cfg_valid ) ? `SIMD_CORE_CNTL_PREPARE_OP :  
                                                                   `SIMD_CORE_CNTL_WAIT       ;
  
        // check simd enable bit in simd operation memory
        `SIMD_CORE_CNTL_PREPARE_OP: 
          simd_core_cntl_state_next =  //(cntl__simd__cfg_operation [`SIMD_CORE_OPERATION_PC_RANGE ] != `SIMD_CORE_OPERATION_PC_NOP ) ?  `SIMD_CORE_CNTL_SFU              :
                                                                                                                                       `SIMD_CORE_CNTL_SFU_START    ;
          
        `SIMD_CORE_CNTL_SFU_START: 
          simd_core_cntl_state_next =  `SIMD_CORE_CNTL_SFU_RUNNING        ;
          
        `SIMD_CORE_CNTL_SFU_RUNNING: 
          simd_core_cntl_state_next =  (special_functions_complete) ? `SIMD_CORE_CNTL_SFU_COMPLETE  :
                                                                     `SIMD_CORE_CNTL_SFU_RUNNING        ;
          
        `SIMD_CORE_CNTL_SFU_COMPLETE: 
          simd_core_cntl_state_next =   (special_op == `SIMD_WRAP_OPERATION_NOP)  ?  `SIMD_CORE_CNTL_WAIT_FOR_SIMD :
                                                                                     `SIMD_CORE_CNTL_SFU_START     ;
          
        `SIMD_CORE_CNTL_WAIT_FOR_SIMD: 
          simd_core_cntl_state_next =  `SIMD_CORE_CNTL_SEND_DATA        ;
          
        `SIMD_CORE_CNTL_SEND_DATA: 
          simd_core_cntl_state_next =  `SIMD_CORE_CNTL_WAIT_FOR_COMPLETE   ;

        `SIMD_CORE_CNTL_WAIT_FOR_COMPLETE:
          simd_core_cntl_state_next =   `SIMD_CORE_CNTL_WAIT_COMPLETE_DEASSERTED  ;


        `SIMD_CORE_CNTL_WAIT_COMPLETE_DEASSERTED:
          simd_core_cntl_state_next =   `SIMD_CORE_CNTL_COMPLETE  ;

        `SIMD_CORE_CNTL_COMPLETE:
          simd_core_cntl_state_next =   `SIMD_CORE_CNTL_WAIT    ; 

        // Latch state on error
        `SIMD_CORE_CNTL_ERR:
          simd_core_cntl_state_next = `SIMD_CORE_CNTL_ERR ;
  
        default:
          simd_core_cntl_state_next = `SIMD_CORE_CNTL_WAIT ;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //
  always @(posedge clk)
    begin
      simd_output_valid       <= (simd_core_cntl_state == `SIMD_CORE_CNTL_COMPLETE );

      simd__smdw__processing  <= (simd_core_cntl_state != `SIMD_CORE_CNTL_WAIT );

      simd__smdw__complete    <= ( reset_poweron )  ?  1'b0  : simd_output_valid ;
    end

  assign   enable_special_function = (simd_core_cntl_state == `SIMD_CORE_CNTL_SFU_START );

  assign   load_sfu_value         = (simd_core_cntl_state == `SIMD_CORE_CNTL_SFU_RUNNING);
  
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            input_regs_valid [lane]  <= ( simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT  ) ?  1'b0 :
                                        ( smdw__simd__regs_valid[lane]                  ) ?  1'b1 :
                                                                                             input_regs_valid[lane]  ;

            input_regs       [lane]  <= ( smdw__simd__regs_valid[lane] ) ?  smdw__simd__regs[lane]  :
                                                                            input_regs[lane]        ;
        
          end
      end
  endgenerate

  always @(posedge clk)
    begin
      special_functions_complete       <= |special_function_done ;  // only the selected SFU will assert done
    end

  always @(posedge clk)
    begin
      case (simd_core_cntl_state)
        `SIMD_CORE_CNTL_WAIT: 
           begin
             special_op_index   <= 'd0 ;
           end
        `SIMD_CORE_CNTL_SFU_START: 
           begin
             special_op_index   <= special_op_index + 'd1 ;
           end
  
      endcase 
    end

  always @(*)
    begin
      special_op  = cntl__simd__cfg_wrap_op_d1 [special_op_index] ;
    end


  //----------------------------------------------------------------------------------------------------
  // Special Functions
  //
  //

  reg                  sfu_add_done      ;
  reg                  sfu_relu_done     ;
  reg                  sfu_div_done      ;

  // assign done to function
  genvar sfu ;
  generate
    for (sfu=0; sfu<`SIMD_WRAP_OPERATION_NUM_OF_OPS ; sfu++)
      begin
        always @(posedge clk)
          begin
            if ((sfu >= `SIMD_WRAP_OPERATION_SUM_SAVE) && (sfu <= `SIMD_WRAP_OPERATION_SUM_SEND))
              begin
                special_function_done [sfu]  <= sfu_add_done  ;
              end
            else
              begin
                special_function_done [sfu]  <= 1'b0  ;
              end
          end
      end
  endgenerate

  always @(*)
    begin
      case (cntl__simd__cfg_operation [`SIMD_CORE_OPERATION_PC_RANGE ])
        `SIMD_CORE_OPERATION_PC_MAC :
          begin
            special_function_value  = special_function_out [0];
          end
        `SIMD_CORE_OPERATION_PC_EXP :
          begin
            special_function_value  = special_function_out [1];
          end
        `SIMD_CORE_OPERATION_PC_DIV :
          begin
            special_function_value  = special_function_out [2];
          end
        default :
          begin
            special_function_value  = 'd0 ;
          end
      endcase 
    end


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Sum
 
  wire  [`PE_EXEC_LANE_WIDTH_RANGE      ]    adder_output       ;

  DW_fp_add  #(
                   .sig_width       ( 23), 
                   .exp_width       ( 8 ), 
                   .ieee_compliance ( 1 )
               )
  DW_fp_add   ( .a     ( input_regs[0]  ), 
                .b     ( input_regs[0]  ), 
                .z     ( adder_output   ), 
                .rnd   ( 3'd4           ),
                .status( ));

  // ADD Controller
  //
  
  reg [`SIMD_CORE_SFU_ADD_CNTL_STATE_RANGE ] simd_core_add_cntl_state      ; // state flop
  reg [`SIMD_CORE_SFU_ADD_CNTL_STATE_RANGE ] simd_core_add_cntl_state_next ;
  
  
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    register_index     ;  // which local register to store wrapper result
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    temp_result        ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    adder_output_reg   ;

  // State register 
  always @(posedge clk)
    begin
      simd_core_add_cntl_state <= ( reset_poweron ) ? `SIMD_CORE_SFU_ADD_CNTL_WAIT       :
                                                       simd_core_add_cntl_state_next  ;
    end
  
 
  always @(*)
    begin
      case (simd_core_add_cntl_state)  // synopsys parallel_case

        
        `SIMD_CORE_SFU_ADD_CNTL_WAIT: 
          simd_core_add_cntl_state_next =  ( enable_special_function ) ? `SIMD_CORE_SFU_ADD_CNTL_COMPLETE :  
                                                                         `SIMD_CORE_SFU_ADD_CNTL_WAIT     ;
  
        // must be a pulse state
        `SIMD_CORE_SFU_ADD_CNTL_COMPLETE: 
          simd_core_add_cntl_state_next =  `SIMD_CORE_SFU_ADD_CNTL_WAIT       ;
  
        // Latch state on error
        `SIMD_CORE_SFU_ADD_CNTL_ERR:
          simd_core_add_cntl_state_next = `SIMD_CORE_SFU_ADD_CNTL_ERR ;
  
        default:
          simd_core_add_cntl_state_next = `SIMD_CORE_SFU_ADD_CNTL_WAIT ;
    
      endcase 
    end // always @ (*)
  

  always @(posedge clk)
    begin
      case (simd_core_add_cntl_state)
        `SIMD_CORE_SFU_ADD_CNTL_WAIT: 
           begin
             adder_output_reg   <= 'd0 ;
           end
  
      endcase 
    end

  always @(posedge clk)
    begin
      case (simd_core_add_cntl_state)
        `SIMD_CORE_SFU_ADD_CNTL_WAIT: 
           begin
             sfu_add_done   <= 'd0 ;
           end
        `SIMD_CORE_SFU_ADD_CNTL_COMPLETE: 
           begin
             sfu_add_done   <= 'd1 ;
           end
        default:
           begin
             sfu_add_done   <= 'd0 ;
           end
      endcase 
    end




  //----------------------------------------------------------------------------------------------------
  // Exp
 
  DW_fp_exp  #(
                   .sig_width       ( 23), 
                   .exp_width       ( 8 ), 
                   .ieee_compliance ( 1 ),
                   .arch            ( 2 )
               )
  DW_fp_exp   ( .a     ( input_regs[0]  ), 
                .z     ( special_function_out [1] ), 
                .status( ));


  //----------------------------------------------------------------------------------------------------
  // Divider
 
  

  DW_fp_div_seq  #(
                   .sig_width       ( 23), 
                   .exp_width       ( 8 ), 
                   .ieee_compliance ( 1 ),
                   .num_cyc         ( 16),
                   .rst_mode        ( 0 ),
                   .input_mode      ( 1 ),
                   .output_mode     ( 1 ),
                   .early_start     ( 0 ),
                   .internal_reg    ( 1 )
                   )
  DW_fp_div_seq   ( .a         ( input_regs[0]          ), 
                    .b         ( input_regs[1]          ), 
                    .rnd       ( 3'b000                 ),
                    .start     ( enable_special_function ),
                    .z         ( special_function_out [2] ), 
                    .complete  (                        ),
                    .status    (                        ),
                    .rst_n     (~reset_poweron          ), 
                    .clk       ( clk                    )
                 );



endmodule

