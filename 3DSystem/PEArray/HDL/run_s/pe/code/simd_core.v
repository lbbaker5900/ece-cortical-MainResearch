/*********************************************************************************************

    File name   : simd_wrapper.v
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
                    input  wire                                           cntl__simd__cfg_valid                            ,
                    input  wire  [`SIMD_CORE_OPERATION_RANGE         ]    cntl__simd__cfg_operation                        , 
                                                                                                                       
                    input  wire  [`PE_NUM_OF_EXEC_LANES_RANGE        ]    smdw__simd__regs_valid                           ,
                    input  wire  [`COMMON_STD_INTF_CNTL_RANGE        ]    smdw__simd__regs_cntl   [`PE_NUM_OF_EXEC_LANES ] ,
                    input  wire  [`PE_EXEC_LANE_WIDTH_RANGE          ]    smdw__simd__regs        [`PE_NUM_OF_EXEC_LANES ] ,

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

  wire                                    start_special_function                                            ;  // must be a pulse
  reg   [`PE_EXEC_LANE_WIDTH_RANGE   ]    special_function_value                                            ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE   ]    special_function_out        [`SIMD_CORE_OPERATION_PC_NUM_OF_OPS ] ;
  wire  [`SIMD_CORE_SFU_CMP_RANGE    ]    special_function_cmp_flag                                         ;  // eq, lt, gt
  reg                                     load_sfu_value                                                    ;


  reg                                            cntl__simd__cfg_valid_d1      ;
  reg   [`SIMD_CORE_OPERATION_RANGE         ]    cntl__simd__cfg_operation_d1  ; 
  always @(posedge clk)
    begin
      cntl__simd__cfg_valid_d1      <= (reset_poweron) ? 1'b0 : cntl__simd__cfg_valid      ;
      cntl__simd__cfg_operation_d1  <=                          cntl__simd__cfg_operation  ;
    end


  // store regs for processing
  reg   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      input_regs_valid                     ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE        ]      input_regs  [`PE_NUM_OF_EXEC_LANES ] ;
  reg                                            simd_output_valid                    ;

  always @(posedge clk)
    begin
      input_regs_valid  <= ( reset_poweron )  ?  1'b0  : simd_output_valid ;
    end
  genvar lane;
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            input_regs[lane]  <= ( smdw__simd__regs_valid[lane] ) ?  smdw__simd__regs[lane]  :
                                                                     input_regs[lane]        ;
        
          end
      end
  endgenerate


  always @(posedge clk)
    begin
      simd_output_valid     <= |smdw__simd__regs_valid  ;// regs_valid is a vector
      simd__smdw__complete  <= ( reset_poweron )  ?  1'b0  : simd_output_valid ;
    end


  // use generate for flexibility (and cntl assignment)
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            simd__smdw__regs_cntl [lane] <= `COMMON_STD_INTF_CNTL_SOM_EOM  ;
            simd__smdw__regs      [lane] <= ( load_sfu_value ) ? special_function_value :  // FIXME
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
      case (simd_core_cntl_state)

        
        `SIMD_CORE_CNTL_WAIT: 
          simd_core_cntl_state_next =  ( cntl__simd__cfg_valid ) ? `SIMD_CORE_CNTL_PREPARE_OP :  
                                                                   `SIMD_CORE_CNTL_WAIT       ;
  
        // check simd enable bit in simd operation memory
        `SIMD_CORE_CNTL_PREPARE_OP: 
          simd_core_cntl_state_next =  (cntl__simd__cfg_operation [`SIMD_CORE_OPERATION_PC_RANGE ] != `SIMD_CORE_OPERATION_PC_NOP ) ?  `SIMD_CORE_CNTL_SFU              :
                                                                                                                                       `SIMD_CORE_CNTL_WAIT_FOR_SIMD    ;
          
        `SIMD_CORE_CNTL_WAIT_FOR_SIMD: 
          simd_core_cntl_state_next =  `SIMD_CORE_CNTL_SEND_DATA        ;
          
        `SIMD_CORE_CNTL_SFU: 
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
  assign   start_special_function = (simd_core_cntl_state == `SIMD_CORE_CNTL_SEND_DATA );

  assign   load_sfu_value         = (simd_core_cntl_state == `SIMD_CORE_CNTL_SFU);
  
  //----------------------------------------------------------------------------------------------------
  // Special Functions
  //
  //

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
  // Comparator
 
  DW_fp_cmp  #(
                   .sig_width       ( 23), 
                   .exp_width       ( 8 ), 
                   .ieee_compliance ( 1 )
               )
  DW_fp_cmp   ( 
                // Inputs
                .a             ( input_regs[0]        ), 
                .b             ( input_regs[1]        ), 
                .zctr          ( 1'b1                 ),  
                // Outputs
                .aeqb          ( special_function_cmp_flag[`SIMD_CORE_SFU_CMP_OP_EQ]   ), 
                .altb          ( special_function_cmp_flag[`SIMD_CORE_SFU_CMP_OP_LT]   ), 
                .agtb          ( special_function_cmp_flag[`SIMD_CORE_SFU_CMP_OP_GT]   ), 
                .unordered     ( ),   // FIXME
                .z0            ( ),   // FIXME 
                .z1            ( ),   // FIXME 
                .status0       ( ),
                .status1       ( ));

  //----------------------------------------------------------------------------------------------------
  // MAC
 
  DW_fp_mac  #(
                   .sig_width       ( 23), 
                   .exp_width       ( 8 ), 
                   .ieee_compliance ( 1 )
               )
  DW_fp_mac   ( .a     ( input_regs[0]  ), 
                .b     ( input_regs[1]  ), 
                .c     ( input_regs[2]  ), 
                .rnd   ( 3'b000         ),
                .z     ( special_function_out [0] ), 
                .status( ));


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
                    .start     ( start_special_function ),
                    .z         ( special_function_out [2] ), 
                    .complete  (                        ),
                    .status    (                        ),
                    .rst_n     (~reset_poweron          ), 
                    .clk       ( clk                    )
                 );



endmodule

