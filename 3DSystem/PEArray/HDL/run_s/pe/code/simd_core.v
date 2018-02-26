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
                    output reg                                            simd__smdw__sending                              ,
                    output reg                                            simd__smdw__complete                             ,
                    output reg   [`COMMON_STD_INTF_CNTL_RANGE        ]    simd__smdw__regs_cntl   [`PE_NUM_OF_EXEC_LANES ] ,
                    output reg   [`PE_NUM_OF_EXEC_LANES_RANGE        ]    simd__smdw__regs_valid                           ,
                    output reg   [`PE_EXEC_LANE_WIDTH_RANGE          ]    simd__smdw__regs        [`PE_NUM_OF_EXEC_LANES ] ,
                  
                    output reg   [`PE_EXEC_LANE_WIDTH_RANGE          ]    simd__smdw__common_regs_valid [`PE_NUM_OF_EXEC_LANES ] ,
                    output reg   [`PE_EXEC_LANE_WIDTH_RANGE          ]    simd__smdw__common_regs       [`PE_NUM_OF_EXEC_LANES ] ,
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

  reg                                                        start_special_function                                                  ;  
  reg                                                        special_functions_complete                                              ; 
  reg   [`SIMD_WRAP_OPERATION_VEC_RANGE                 ]    special_function_done                                                   ; 
                                                                                               
  reg                                                        special_op_is_nop                                                       ;  // NOP, send, reset index etc.
  reg   [`SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_RANGE ]    special_op_index                                                        ;  // stop when count is number of stages
  reg   [`SIMD_WRAP_OPERATION_TYPE_RANGE                ]    special_op                                                              ;
  reg   [`SIMD_WRAP_OPERATION_TYPE_RANGE                ]    curr_special_op                                                         ;  // latch special op
                                                                                               
                                                                                               
  reg                                                        cntl__simd__cfg_valid_d1                                                ;
  reg   [`SIMD_CORE_OPERATION_RANGE                     ]    cntl__simd__cfg_operation_d1                                            ; 
  reg   [`SIMD_WRAP_OPERATION_TYPE_RANGE                ]    cntl__simd__cfg_wrap_op_d1        [`SIMD_WRAP_OPERATION_NUM_OF_STAGES ] ;
  reg   [`PE_EXEC_LANE_ID_RANGE                         ]    cntl__simd__cfg_wrap_op_idx_d1                                          ;
  reg                                                        cntl__simd__cfg_wrap_op_inc_d1                                          ;
                                                       
  reg   [`PE_NUM_OF_EXEC_LANES_RANGE                    ]    smdw__simd__regs_valid_d1                                               ;
  reg   [`COMMON_STD_INTF_CNTL_RANGE                    ]    smdw__simd__regs_cntl_d1          [`PE_NUM_OF_EXEC_LANES              ] ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE                      ]    smdw__simd__regs_d1               [`PE_NUM_OF_EXEC_LANES              ] ;


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

  genvar lane ;
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            smdw__simd__regs_valid_d1 [lane]  <= smdw__simd__regs_valid [lane] ;
            smdw__simd__regs_cntl_d1  [lane]  <= smdw__simd__regs_cntl  [lane] ;
            smdw__simd__regs_d1       [lane]  <= smdw__simd__regs       [lane] ;
          end
      end
  endgenerate

  // store regs for processing
  reg   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      input_regs_valid                      ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE        ]      input_regs  [`PE_NUM_OF_EXEC_LANES ]  ;

  reg   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      simd_regs_valid                       ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE        ]      simd_regs   [`PE_NUM_OF_EXEC_LANES ]  ;


  
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
  // Local register for multi-instruction operations
  reg                                                                 reset_common_index                          ;  // which operation will reset save index
  reg                                                                 inc_common_index                            ;  // which operation will increment save index
  reg   [`PE_EXEC_LANE_ID_RANGE                                   ]   common_index                                ;  // which local register to store wrapper result
  reg                                                                 clr_local_regs                              ;  
  reg   [`PE_EXEC_LANE_WIDTH_RANGE                                ]   local_regs        [`PE_NUM_OF_EXEC_LANES ]  ;  // holds result of each stage
  reg   [`PE_EXEC_LANE_WIDTH_RANGE                                ]   local_regs_valid                            ;  // 
  reg                                                                 send_local_regs                             ;  
  reg                                                                 send_null                                   ;  
  reg                                                                 clr_common_regs                             ;  
  reg   [`PE_EXEC_LANE_WIDTH_RANGE                                ]   common_regs       [`PE_NUM_OF_EXEC_LANES ]  ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE                                ]   common_regs_valid                           ;  // holds registers between instructions


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
                                                                      `SIMD_CORE_CNTL_SFU_RUNNING   ;
          
        `SIMD_CORE_CNTL_SFU_COMPLETE: 
          simd_core_cntl_state_next =   (special_op_index[`SIMD_WRAP_OPERATION_NUM_OF_STAGES_COUNT_MSB ] )  ?  `SIMD_CORE_CNTL_WAIT_FOR_SIMD : // processed all stages, even nop is a valid op
                                                                                                               `SIMD_CORE_CNTL_SFU_NEXT      ;
          
        `SIMD_CORE_CNTL_SFU_NEXT: 
          simd_core_cntl_state_next =   `SIMD_CORE_CNTL_SFU_START     ;
          
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

  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            simd__smdw__regs_cntl  [lane] <= `COMMON_STD_INTF_CNTL_SOM_EOM  ;

            simd__smdw__regs_valid [lane]  <= //( simd_core_cntl_state == `SIMD_CORE_CNTL_COMPLETE  )  ?  local_regs_valid[lane] :
                                              ( send_local_regs                                     )  ?  local_regs_valid[lane] :
                                                                                                          1'b0                   ;
                                                                                                                           
            simd__smdw__regs       [lane]  <= //( simd_core_cntl_state == `SIMD_CORE_CNTL_COMPLETE  )  ?  local_regs      [lane] :
                                              ( send_local_regs                                     )  ?  local_regs      [lane] :
                                                                                                          simd__smdw__regs[lane] ;
          end
      end
  endgenerate
 
  always @(posedge clk)
    begin
      simd__smdw__processing  <= (simd_core_cntl_state != `SIMD_CORE_CNTL_WAIT );

      simd__smdw__complete    <= ( reset_poweron                                                             )  ?  1'b0                 : 
                                 (                         (simd_core_cntl_state == `SIMD_CORE_CNTL_COMPLETE))  ?  1'b1                 :
                                 (cntl__simd__cfg_valid && (simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT    ))  ?  1'b0                 :
                                                                                                                   simd__smdw__complete ;

      simd__smdw__sending     <= ( reset_poweron )  ?  1'b0  : (send_local_regs | send_null)   ;
    end

  assign   start_special_function    = (simd_core_cntl_state == `SIMD_CORE_CNTL_SFU_START );

  
  // latch input until cfg is valid
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            input_regs_valid [lane]  <= ( simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT           )  ?  smdw__simd__regs_valid_d1 [lane] :
                                        ( simd_core_cntl_state == `SIMD_CORE_CNTL_SFU_NEXT       )  ?  local_regs_valid          [lane] :
                                        ( simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT_FOR_SIMD  )  ?  local_regs_valid          [lane] :
                                                                                                       input_regs_valid          [lane] ;
                                                                                                                           
            input_regs       [lane]  <= ( simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT           )  ?  smdw__simd__regs_d1       [lane] :
                                        ( simd_core_cntl_state == `SIMD_CORE_CNTL_SFU_NEXT       )  ?  local_regs                [lane] :
                                        ( simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT_FOR_SIMD  )  ?  local_regs                [lane] :
                                                                                                       input_regs                [lane] ;
        
          end
      end
  endgenerate


  //----------------------------------------------------------------------------------------------------
  // Mux result data to global sfu output

  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_nop_local_regs       [`PE_NUM_OF_EXEC_LANES ]  ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_nop_load_local_reg                             ;  // 

  reg    [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_nop_common_regs      [`PE_NUM_OF_EXEC_LANES ]  ;
  reg    [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_nop_load_common_reg                            ;  // 

  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_relu_local_regs       [`PE_NUM_OF_EXEC_LANES ]  ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_relu_load_local_reg                             ;  // 

  wire   [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_relu_common_regs      [`PE_NUM_OF_EXEC_LANES ]  ;
  wire   [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_relu_load_common_reg                            ;  // 

  reg    [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_add_local_regs        [`PE_NUM_OF_EXEC_LANES ]  ;
  reg    [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_add_load_local_reg                              ;  // 

  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_add_common_regs       [`PE_NUM_OF_EXEC_LANES ]  ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_add_load_common_reg                             ;  // 

  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_exp_local_regs        [`PE_NUM_OF_EXEC_LANES ]  ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_exp_load_local_reg                              ;  // 

  wire   [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_exp_common_regs       [`PE_NUM_OF_EXEC_LANES ]  ;
  wire   [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_exp_load_common_reg                             ;  // 

  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_div_local_regs        [`PE_NUM_OF_EXEC_LANES ]  ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_div_load_local_reg                              ;  // 

  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_div_common_regs       [`PE_NUM_OF_EXEC_LANES ]  ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_div_load_common_reg                             ;  // 

  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_cmp_local_regs        [`PE_NUM_OF_EXEC_LANES ]  ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]   sfu_cmp_load_local_reg                              ;  // 

  wire   [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_cmp_common_regs       [`PE_NUM_OF_EXEC_LANES ]  ;
  wire   [`PE_EXEC_LANE_WIDTH_RANGE     ]   sfu_cmp_load_common_reg                             ;  // 

  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            local_regs_valid [lane]  <= (reset_poweron || clr_local_regs                 ) ? 1'b0                     :
                                        //(simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT  ) ? 1'b0                     :
                                        (sfu_nop_load_local_reg  [lane] ||                                         
                                         sfu_add_load_local_reg  [lane] ||                                         
                                         sfu_relu_load_local_reg [lane] ||                                         
                                         sfu_div_load_local_reg  [lane] ||                                         
                                         sfu_cmp_load_local_reg  [lane] ||                                         
                                         sfu_exp_load_local_reg  [lane]                  ) ? 1'b1                     :
                                                                                             local_regs_valid [lane]  ;

            local_regs       [lane]  <= (reset_poweron || clr_local_regs                 ) ? 'd0                     :
                                        //(simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT  ) ? 'd0                     :
                                        (sfu_nop_load_local_reg  [lane] ||                
                                         sfu_add_load_local_reg  [lane] ||                
                                         sfu_relu_load_local_reg [lane] ||                
                                         sfu_div_load_local_reg  [lane] ||                
                                         sfu_cmp_load_local_reg  [lane] ||                
                                         sfu_exp_load_local_reg  [lane]                  ) ? (sfu_nop_local_regs  [lane] | 
                                                                                              sfu_add_local_regs  [lane] | 
                                                                                              sfu_relu_local_regs [lane] | 
                                                                                              sfu_div_local_regs  [lane] | 
                                                                                              sfu_cmp_local_regs  [lane] | 
                                                                                              sfu_exp_local_regs  [lane] ) : 
                                                                                              local_regs          [lane]   ;
          end
      end
  endgenerate

  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            common_regs_valid [lane] <= (reset_poweron || clr_common_regs                ) ?   1'b0                     :
                                        //(simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT  ) ?   1'b0                     :
                                        (sfu_nop_load_common_reg  [lane] ||                                         
                                         sfu_add_load_common_reg  [lane] ||                                         
                                         sfu_relu_load_common_reg [lane] ||                                         
                                         sfu_div_load_common_reg  [lane] ||                                         
                                         sfu_cmp_load_common_reg  [lane] ||                                         
                                         sfu_exp_load_common_reg  [lane]                 ) ? 1'b1                     :
                                                                                            common_regs_valid [lane]  ;

            common_regs       [lane] <= (reset_poweron || clr_common_regs                ) ?`COMMON_IEEE754_FLOAT_ONE  :
                                        //(simd_core_cntl_state == `SIMD_CORE_CNTL_WAIT  ) ?`COMMON_IEEE754_FLOAT_ONE  :
                                        (sfu_nop_load_common_reg  [lane] ||                
                                         sfu_add_load_common_reg  [lane] ||                
                                         sfu_relu_load_common_reg [lane] ||                
                                         sfu_div_load_common_reg  [lane] ||                
                                         sfu_cmp_load_common_reg  [lane] ||                
                                         sfu_exp_load_common_reg  [lane]                 ) ? (sfu_add_common_regs  [lane] | 
                                                                                              sfu_relu_common_regs [lane] | 
                                                                                              sfu_div_common_regs  [lane] | 
                                                                                              sfu_cmp_common_regs  [lane] | 
                                                                                              sfu_exp_common_regs  [lane] )  : 
                                                                                              common_regs          [lane]    ;
          end
      end
  endgenerate


  //----------------------------------------------------------------------------------------------------
  //

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
             special_op_index   <= special_op_index + 'd1   ;
             curr_special_op    <= special_op               ;
           end
  
      endcase 
    end

  always @(*)
    begin
      special_op  = cntl__simd__cfg_wrap_op_d1 [special_op_index[`SIMD_WRAP_SFU_COUNT_RANGE]] ;
    end


  //----------------------------------------------------------------------------------------------------
  // Special Functions
  //
  //

  reg                  sfu_nop_done              ;
  reg                  sfu_add_save_local_done   ;
  reg                  sfu_add_save_common_done  ;
  reg                  sfu_relu_done             ;
  reg                  sfu_div_done              ;
  reg                  sfu_cmp_done              ;
  reg                  sfu_exp_done              ;

  // assign done to function
  genvar sfu ;
  generate
    for (sfu=0; sfu<`SIMD_WRAP_OPERATION_NUM_OF_OPS ; sfu++)
      begin
        always @(*)
          begin
            if (sfu == `SIMD_WRAP_OPERATION_NOP)
              begin
                special_function_done [sfu]  = sfu_nop_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_RELU)
              begin
                special_function_done [sfu]  = sfu_relu_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_SUM_SAVE_LOCAL) 
              begin
                special_function_done [sfu]  = sfu_add_save_local_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_SUM_SAVE_COMMON) 
              begin
                special_function_done [sfu]  = sfu_add_save_common_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_EXP) 
              begin
                special_function_done [sfu]  = sfu_exp_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_DIV) 
              begin
                special_function_done [sfu]  = sfu_div_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_CMP) 
              begin
                special_function_done [sfu]  = sfu_cmp_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_SEND) 
              begin
                special_function_done [sfu]  = sfu_nop_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_CLR_LOCAL_REGS) 
              begin
                special_function_done [sfu]  = sfu_nop_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_CLR_COMMON_REGS) 
              begin
                special_function_done [sfu]  = sfu_nop_done  ;
              end
            else if (sfu == `SIMD_WRAP_OPERATION_CLR_IDX) 
              begin
                special_function_done [sfu]  = sfu_nop_done  ;
              end
            else
              begin
                special_function_done [sfu]  = 1'b0  ;
              end
          end
      end
  endgenerate


  always @(*)
    begin
      reset_common_index  = special_function_done[`SIMD_WRAP_OPERATION_NOP ] & (curr_special_op == `SIMD_WRAP_OPERATION_CLR_IDX );
      inc_common_index    = special_function_done[`SIMD_WRAP_OPERATION_NOP ] & (curr_special_op == `SIMD_WRAP_OPERATION_INC_IDX );
    end

  always @(posedge clk)
    begin
      common_index  <=  ( reset_poweron      )  ?  'd0                :
                        ( reset_common_index )  ?  'd0                :
                        ( inc_common_index   )  ?  common_index + 'd1 :
                                                   common_index       ;                                                   
    end


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // NOP
 
  always @(*)
    begin
      case (special_op)  // synopsys parallel_case
        `SIMD_WRAP_OPERATION_NOP :
          begin
            special_op_is_nop  =  1'b1 ;
          end
        `SIMD_WRAP_OPERATION_SEND :
          begin
            special_op_is_nop  =  1'b1 ;
          end
        `SIMD_WRAP_OPERATION_SEND_NULL :
          begin
            special_op_is_nop  =  1'b1 ;
          end
        `SIMD_WRAP_OPERATION_CLR_LOCAL_REGS :
          begin
            special_op_is_nop  =  1'b1 ;
          end
        `SIMD_WRAP_OPERATION_CLR_COMMON_REGS :
          begin
            special_op_is_nop  =  1'b1 ;
          end
        `SIMD_WRAP_OPERATION_CLR_IDX :
          begin
            special_op_is_nop  =  1'b1 ;
          end
        `SIMD_WRAP_OPERATION_INC_IDX :
          begin
            special_op_is_nop  =  1'b1 ;
          end
        default:
          begin
            special_op_is_nop  =  1'b0 ;
          end
      endcase
    end

  reg [`SIMD_CORE_SFU_NOP_CNTL_STATE_RANGE ]   simd_core_nop_cntl_state      ; // state flop
  reg [`SIMD_CORE_SFU_NOP_CNTL_STATE_RANGE ]   simd_core_nop_cntl_state_next ;

  // State register 
  always @(posedge clk)
    begin
      simd_core_nop_cntl_state <= ( reset_poweron ) ? `SIMD_CORE_SFU_NOP_CNTL_WAIT    :
                                                       simd_core_nop_cntl_state_next  ;
    end
  
 
  always @(*)
    begin
      case (simd_core_nop_cntl_state)  // synopsys parallel_case

        // use special op for first transition, then use curr_special_op
        `SIMD_CORE_SFU_NOP_CNTL_WAIT: 
          simd_core_nop_cntl_state_next =  ( start_special_function  && special_op_is_nop ) ? `SIMD_CORE_SFU_NOP_CNTL_NOP   :  
                                                                                              `SIMD_CORE_SFU_NOP_CNTL_WAIT  ;
  
        // must be a pulse state
        `SIMD_CORE_SFU_NOP_CNTL_NOP: 
          simd_core_nop_cntl_state_next =  `SIMD_CORE_SFU_NOP_CNTL_COMPLETE   ;
  
        // must be a pulse state
        `SIMD_CORE_SFU_NOP_CNTL_COMPLETE: 
          simd_core_nop_cntl_state_next =  `SIMD_CORE_SFU_NOP_CNTL_WAIT       ;
  
        // Latch state on error
        `SIMD_CORE_SFU_NOP_CNTL_ERR:
          simd_core_nop_cntl_state_next = `SIMD_CORE_SFU_NOP_CNTL_ERR ;
  
        default:
          simd_core_nop_cntl_state_next = `SIMD_CORE_SFU_NOP_CNTL_WAIT ;
    
      endcase 
    end // always @ (*)
  

  always @(posedge clk)
    begin
      case (simd_core_nop_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_NOP_CNTL_COMPLETE: 
           begin
             sfu_nop_done        <= 'b1 ;
           end
        default:
           begin
             sfu_nop_done        <= 'b0 ;
           end
      endcase 
    end

  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(*)
          begin
            case (simd_core_nop_cntl_state)  // synopsys parallel_case
              `SIMD_CORE_SFU_NOP_CNTL_NOP: 
                 begin
                   sfu_nop_load_local_reg    [lane]  =  input_regs_valid[lane] ;
                                                                                                                                  
                   sfu_nop_local_regs        [lane]  =  input_regs      [lane] ;
                 end
              default:
                 begin
                   sfu_nop_load_local_reg    [lane]  = 'b0 ;
                                                                                                                                  
                   sfu_nop_local_regs        [lane]  = 'd0 ;
                 end
            endcase 
          end
      end
  endgenerate

  // Clear signals below will override load signal above if NOP is also
  // a clear reg
  always @(*)
    begin
      case (simd_core_nop_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_NOP_CNTL_COMPLETE: 
           begin
             case (curr_special_op)  // synopsys parallel_case
                 `SIMD_WRAP_OPERATION_CLR_COMMON_REGS :
                   begin
                     clr_local_regs    = 'b0 ;
                     send_null         = 'b0 ;
                     send_local_regs   = 'b0 ;
                     clr_common_regs   = 'b1 ;
                   end
                 `SIMD_WRAP_OPERATION_CLR_LOCAL_REGS :
                   begin
                     clr_local_regs    = 'b1 ;
                     send_null         = 'b0 ;
                     send_local_regs   = 'b0 ;
                     clr_common_regs   = 'b0 ;
                   end
                 `SIMD_WRAP_OPERATION_SEND :
                   begin
                     clr_local_regs    = 'b0 ;
                     send_null         = 'b0 ;
                     send_local_regs   = 'b1 ;
                     clr_common_regs   = 'b0 ;
                   end
                 `SIMD_WRAP_OPERATION_SEND_NULL :
                   begin
                     clr_local_regs    = 'b0 ;
                     send_null         = 'b1 ;
                     send_local_regs   = 'b0 ;
                     clr_common_regs   = 'b0 ;
                   end
                 default:
                   begin
                     clr_local_regs    = 'b0 ;
                     send_null         = 'b0 ;
                     send_local_regs   = 'b0 ;
                     clr_common_regs   = 'b0 ;
                   end
             endcase
           end
        default:
           begin
             clr_local_regs    = 'b0 ;
             send_null         = 'b0 ;
             send_local_regs   = 'b0 ;
             clr_common_regs   = 'b0 ;
           end
      endcase 
    end

  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(*)
          begin
            case (simd_core_nop_cntl_state)  // synopsys parallel_case
              `SIMD_CORE_SFU_NOP_CNTL_COMPLETE: 
                 begin
                   sfu_nop_load_common_reg    [lane]  =  'd0 ; //input_regs_valid[lane] ;
                                                                                                                                  
                   sfu_nop_common_regs        [lane]  =  'd0 ; //input_regs      [lane] ;
                 end
              default:
                 begin
                   sfu_nop_load_common_reg    [lane]  = 'b0 ;
                                                                                                                                  
                   sfu_nop_common_regs        [lane]  = 'd0 ;
                 end
            endcase 
          end
      end
  endgenerate

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Relu
 

  
  reg [`SIMD_CORE_SFU_RELU_CNTL_STATE_RANGE ]   simd_core_relu_cntl_state      ; // state flop
  reg [`SIMD_CORE_SFU_RELU_CNTL_STATE_RANGE ]   simd_core_relu_cntl_state_next ;

  // State register 
  always @(posedge clk)
    begin
      simd_core_relu_cntl_state <= ( reset_poweron ) ? `SIMD_CORE_SFU_RELU_CNTL_WAIT    :
                                                        simd_core_relu_cntl_state_next  ;
    end
  
 
  always @(*)
    begin
      case (simd_core_relu_cntl_state)  // synopsys parallel_case

        // use special op for first transition, then use curr_special_op
        `SIMD_CORE_SFU_RELU_CNTL_WAIT: 
          simd_core_relu_cntl_state_next =  ( start_special_function  && (special_op == `SIMD_WRAP_OPERATION_RELU )) ? `SIMD_CORE_SFU_RELU_CNTL_RELU    :  
                                                                                                                       `SIMD_CORE_SFU_RELU_CNTL_WAIT    ;
  
        // must be a pulse state
        `SIMD_CORE_SFU_RELU_CNTL_RELU: 
          simd_core_relu_cntl_state_next =  `SIMD_CORE_SFU_RELU_CNTL_COMPLETE   ;
  
        // must be a pulse state
        `SIMD_CORE_SFU_RELU_CNTL_COMPLETE: 
          simd_core_relu_cntl_state_next =  `SIMD_CORE_SFU_RELU_CNTL_WAIT       ;
  
        // Latch state on error
        `SIMD_CORE_SFU_RELU_CNTL_ERR:
          simd_core_relu_cntl_state_next = `SIMD_CORE_SFU_RELU_CNTL_ERR ;
  
        default:
          simd_core_relu_cntl_state_next = `SIMD_CORE_SFU_RELU_CNTL_WAIT ;
    
      endcase 
    end // always @ (*)
  

  always @(posedge clk)
    begin
      case (simd_core_relu_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_RELU_CNTL_COMPLETE: 
           begin
             sfu_relu_done   <= 'd1 ;
           end
        default:
           begin
             sfu_relu_done   <= 'd0 ;
           end
      endcase 
    end

  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(*)
          begin
            case (simd_core_relu_cntl_state)  // synopsys parallel_case
              `SIMD_CORE_SFU_RELU_CNTL_COMPLETE: 
                 begin
                   sfu_relu_load_local_reg    [lane]  =  input_regs_valid[lane] ;
                                                                                                                                  
                   sfu_relu_local_regs        [lane]  = ( input_regs[lane][`COMMON_IEEE754_SIGN_RANGE]  )  ?  `COMMON_IEEE754_FLOAT_ZERO  :
                                                                                                                input_regs [lane]          ;
                 end
              default:
                 begin
                   sfu_relu_load_local_reg    [lane]  = 'b0 ;
                                                                                                                                  
                   sfu_relu_local_regs        [lane]  = 'd0 ;
                 end
            endcase 
          end
      end
  endgenerate

  // ReLu doesnt write to common reg
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        //always @(*)
        //  begin
            assign sfu_relu_load_common_reg    [lane]  = 'b0 ;
                                                                                                                                  
            assign sfu_relu_common_regs        [lane]  = 'd0 ;
        //  end
      end
  endgenerate



  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Sum
 
  reg [`SIMD_CORE_SFU_ADD_CNTL_STATE_RANGE ] simd_core_add_cntl_state      ; // state flop
  reg [`SIMD_CORE_SFU_ADD_CNTL_STATE_RANGE ] simd_core_add_cntl_state_next ;
  
  reg   [`PE_EXEC_LANE_COUNT_P1_RANGE   ]    add_register_count      ;  // when MSB is one we have cycled thru all regs
  reg   [`PE_EXEC_LANE_COUNT_P1_RANGE   ]    add_register_index      ;  // index thru registers 0-31
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    sfu_add_temp_result ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    adder_output_reg    ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    adder_input [2]       ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE      ]    adder_output        ;

  DW_fp_add  #(
                   .sig_width       ( 23), 
                   .exp_width       ( 8 ), 
                   .ieee_compliance ( 1 )
               )
  DW_fp_add   ( .a     ( adder_input[0]   ), 
                .b     ( adder_input[1]   ), 
                .z     ( adder_output    ), 
                .rnd   ( 3'd4            ),
                .status( ));

  // ADD Controller
  //
  
  // State register 
  always @(posedge clk)
    begin
      simd_core_add_cntl_state <= ( reset_poweron ) ? `SIMD_CORE_SFU_ADD_CNTL_WAIT       :
                                                       simd_core_add_cntl_state_next  ;
    end
  
 
  always @(*)
    begin
      case (simd_core_add_cntl_state)  // synopsys parallel_case

        
        // use special op for first transition, then use curr_special_op
        `SIMD_CORE_SFU_ADD_CNTL_WAIT: 
          simd_core_add_cntl_state_next =  ( start_special_function  && (special_op == `SIMD_WRAP_OPERATION_SUM_SAVE_LOCAL  )) ? `SIMD_CORE_SFU_ADD_CNTL_ACC_ALL  :  
                                           ( start_special_function  && (special_op == `SIMD_WRAP_OPERATION_SUM_SAVE_COMMON )) ? `SIMD_CORE_SFU_ADD_CNTL_ACC_ALL  :  
                                                                                                                                 `SIMD_CORE_SFU_ADD_CNTL_WAIT     ;
  
        `SIMD_CORE_SFU_ADD_CNTL_ACC_ALL: 
          simd_core_add_cntl_state_next =  ( add_register_count[`PE_EXEC_LANE_COUNT_P1_MSB] )   ?   `SIMD_CORE_SFU_ADD_CNTL_ACC_FLUSH  :
                                                                                                    `SIMD_CORE_SFU_ADD_CNTL_ACC_ALL   ;
  
        `SIMD_CORE_SFU_ADD_CNTL_ACC_FLUSH: 
          simd_core_add_cntl_state_next =  `SIMD_CORE_SFU_ADD_CNTL_ACC_COMPLETE       ;
  
        `SIMD_CORE_SFU_ADD_CNTL_ACC_COMPLETE: 
          simd_core_add_cntl_state_next =  `SIMD_CORE_SFU_ADD_CNTL_COMPLETE       ;
  
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
      case (simd_core_add_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_ADD_CNTL_WAIT: 
           begin
             adder_input[0]      <= `COMMON_IEEE754_FLOAT_ZERO ;
             adder_input[1]      <= `COMMON_IEEE754_FLOAT_ZERO ;
           end
  
        `SIMD_CORE_SFU_ADD_CNTL_ACC_ALL: 
           begin
             adder_input[0]      <= (~add_register_count[`PE_EXEC_LANE_COUNT_P1_MSB]) ? input_regs [add_register_index]  :
                                                                                        adder_output                     ; // accumulate pipeline

             adder_input[1]      <= (add_register_index == 0)   ?  `COMMON_IEEE754_FLOAT_ZERO :
                                                                   adder_output_reg           ;
           end

        `SIMD_CORE_SFU_ADD_CNTL_ACC_FLUSH: 
           begin
             adder_input[0]      <= adder_output      ;

             adder_input[1]      <= adder_output_reg  ;
           end
  
        `SIMD_CORE_SFU_ADD_CNTL_ACC_COMPLETE: 
           begin
             adder_input[0]      <= `COMMON_IEEE754_FLOAT_ZERO ;

             adder_input[1]      <= adder_output_reg  ;
           end
  
      endcase 
    end

  always @(posedge clk)
    begin
      case (simd_core_add_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_ADD_CNTL_WAIT: 
           begin
             adder_output_reg    <= 'd0 ;
             sfu_add_temp_result <= 'd0 ;
             add_register_index      <= 'd0 ;
             add_register_count      <= 'd0 ;
           end
  
        `SIMD_CORE_SFU_ADD_CNTL_ACC_ALL: 
           begin
             adder_output_reg    <= adder_output      ;
             sfu_add_temp_result <= adder_output_reg  ;

             add_register_index      <= add_register_index +'d1  ;
             add_register_count      <= add_register_count +'d1  ;
           end
  
        `SIMD_CORE_SFU_ADD_CNTL_ACC_FLUSH: 
           begin
             adder_output_reg    <= adder_output      ;
             sfu_add_temp_result <= adder_output_reg  ;

             add_register_index      <= add_register_index  ;
             add_register_count      <= add_register_count  ;
           end
  
        `SIMD_CORE_SFU_ADD_CNTL_ACC_COMPLETE: 
           begin
             adder_output_reg    <= adder_output_reg  ;
             sfu_add_temp_result <= adder_output_reg  ;

             add_register_index      <= add_register_index  ;
             add_register_count      <= add_register_count  ;
           end
  
        default:
           begin
             adder_output_reg    <= adder_output_reg ;
             sfu_add_temp_result <= adder_output_reg ;

             add_register_index      <= add_register_index  ;
             add_register_count      <= add_register_count  ;
           end
  
      endcase 
    end

  always @(*)
    begin
      case (simd_core_add_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_ADD_CNTL_COMPLETE: 
           begin
             sfu_add_save_local_done     = (curr_special_op == `SIMD_WRAP_OPERATION_SUM_SAVE_LOCAL   );
             sfu_add_save_common_done    = (curr_special_op == `SIMD_WRAP_OPERATION_SUM_SAVE_COMMON  );
           end
        default:
           begin
             sfu_add_save_local_done     = 'd0 ;
             sfu_add_save_common_done    = 'd0 ;
           end
      endcase 
    end


  // ACC doesnt write to local reg
  /*
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        //always @(*)
        //  begin
            assign sfu_add_load_local_reg    [lane]  = 'b0 ;
                                                                                                                                  
            assign sfu_add_local_regs        [lane]  = 'd0 ;
        //  end
      end
  endgenerate
*/

  // Create load signals
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(*)
          begin
            case (simd_core_add_cntl_state)  // synopsys parallel_case
              `SIMD_CORE_SFU_ADD_CNTL_COMPLETE: 
                 begin
                   case (curr_special_op)
                     `SIMD_WRAP_OPERATION_SUM_SAVE_LOCAL :
                       begin
                         if (lane==common_index)
                           begin
                             sfu_add_local_regs     [lane]       =  sfu_add_temp_result ;
                             sfu_add_load_local_reg [lane]       = 1'b1                 ; 
                           end
                         else
                           begin
                             sfu_add_local_regs     [lane]       = 'd0 ;
                             sfu_add_load_local_reg [lane]       = 'b0 ;
                           end
                       end
                     default:
                       begin
                         sfu_add_local_regs     [lane]       = 'd0 ;
                         sfu_add_load_local_reg [lane]       = 'b0 ;
                       end
                   endcase
                 end
              default:
                 begin
                   sfu_add_local_regs     [lane]       = 'd0 ;
                   sfu_add_load_local_reg [lane]       = 'b0 ;
                 end
            endcase 
          end
      end
  endgenerate


  // Create load signals
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(*)
          begin
            case (simd_core_add_cntl_state)  // synopsys parallel_case
              `SIMD_CORE_SFU_ADD_CNTL_COMPLETE: 
                 begin
                   case (curr_special_op)
                     `SIMD_WRAP_OPERATION_SUM_SAVE_COMMON :
                       begin
                         if (lane==common_index)
                           begin
                             sfu_add_common_regs     [lane]       =  sfu_add_temp_result ;
                             sfu_add_load_common_reg [lane]       = 1'b1                 ; 
                           end
                         else
                           begin
                             sfu_add_common_regs     [lane]       = 'd0 ;
                             sfu_add_load_common_reg [lane]       = 'b0 ;
                           end
                       end
                     default:
                       begin
                         sfu_add_common_regs     [lane]       = 'd0 ;
                         sfu_add_load_common_reg [lane]       = 'b0 ;
                       end
                   endcase
                 end
              default:
                 begin
                   sfu_add_common_regs     [lane]       = 'd0 ;
                   sfu_add_load_common_reg [lane]       = 'b0 ;
                 end
            endcase 
          end
      end
  endgenerate




  //----------------------------------------------------------------------------------------------------
  // Exp
 
  reg [`SIMD_CORE_SFU_EXP_CNTL_STATE_RANGE ] simd_core_exp_cntl_state      ; // state flop
  reg [`SIMD_CORE_SFU_EXP_CNTL_STATE_RANGE ] simd_core_exp_cntl_state_next ;
  
  reg   [`PE_EXEC_LANE_COUNT_P1_RANGE   ]    exp_register_count      ;  // when MSB is one we have cycled thru all regs
  reg   [`PE_EXEC_LANE_COUNT_P1_RANGE   ]    exp_register_index      ;  // index thru registers 0-31
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    exp_output_reg          ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    exp_input               ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE      ]    exp_output              ;


  // EXP Controller
  //
  
  // State register 
  always @(posedge clk)
    begin
      simd_core_exp_cntl_state <= ( reset_poweron ) ? `SIMD_CORE_SFU_EXP_CNTL_WAIT       :
                                                       simd_core_exp_cntl_state_next  ;
    end
  
 
  always @(*)
    begin
      case (simd_core_exp_cntl_state)  // synopsys parallel_case

        
        // use special op for first transition, then use curr_special_op
        `SIMD_CORE_SFU_EXP_CNTL_WAIT: 
          simd_core_exp_cntl_state_next =  ( start_special_function  && (special_op == `SIMD_WRAP_OPERATION_EXP )) ? `SIMD_CORE_SFU_EXP_CNTL_SETTLE  :  
                                                                                                                     `SIMD_CORE_SFU_EXP_CNTL_WAIT     ;
  
        `SIMD_CORE_SFU_EXP_CNTL_SETTLE: 
          simd_core_exp_cntl_state_next =  ( exp_register_count ==  `SIMD_WRAP_OPERATION_EXP_MULTICYCLE  )   ?   `SIMD_CORE_SFU_EXP_CNTL_LOAD     :
                                                                                                                 `SIMD_CORE_SFU_EXP_CNTL_SETTLE   ;
  
        `SIMD_CORE_SFU_EXP_CNTL_LOAD: 
          simd_core_exp_cntl_state_next =  `SIMD_CORE_SFU_EXP_CNTL_INC       ;
  
        `SIMD_CORE_SFU_EXP_CNTL_INC: 
          simd_core_exp_cntl_state_next =  ( exp_register_index[`PE_EXEC_LANE_COUNT_P1_MSB] )   ?   `SIMD_CORE_SFU_EXP_CNTL_COMPLETE     :
                                                                                                    `SIMD_CORE_SFU_EXP_CNTL_SETTLE       ;
  
        // must be a pulse state
        `SIMD_CORE_SFU_EXP_CNTL_COMPLETE: 
          simd_core_exp_cntl_state_next =  `SIMD_CORE_SFU_EXP_CNTL_WAIT       ;
  
        // Latch state on error
        `SIMD_CORE_SFU_EXP_CNTL_ERR:
          simd_core_exp_cntl_state_next = `SIMD_CORE_SFU_EXP_CNTL_ERR ;
  
        default:
          simd_core_exp_cntl_state_next = `SIMD_CORE_SFU_EXP_CNTL_WAIT ;
    
      endcase 
    end // always @ (*)
  

  always @(posedge clk)
    begin
      case (simd_core_exp_cntl_state)
        `SIMD_CORE_SFU_EXP_CNTL_WAIT: 
           begin
             exp_input        <= `COMMON_IEEE754_FLOAT_ZERO ;
           end
  
        default:
           begin
             exp_input        <= input_regs [exp_register_index]  ;
           end
      endcase 
    end

  always @(posedge clk)
    begin
      case (simd_core_exp_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_EXP_CNTL_WAIT: 
           begin
             exp_output_reg          <= 'd0 ;
             exp_register_index      <= 'd0 ;
             exp_register_count      <= 'd0 ;
           end
  
        `SIMD_CORE_SFU_EXP_CNTL_SETTLE: 
           begin
             exp_output_reg      <= exp_output      ;

             exp_register_index      <= exp_register_index       ;
             exp_register_count      <= exp_register_count +'d1  ;
           end
  
        `SIMD_CORE_SFU_EXP_CNTL_LOAD: 
           begin
             exp_output_reg      <= exp_output      ;

             exp_register_index      <= exp_register_index + 'd1 ;
             exp_register_count      <= 'd0                      ;
           end
  
        default:
           begin
             exp_output_reg      <= exp_output_reg ;

             exp_register_index      <= exp_register_index  ;
             exp_register_count      <= exp_register_count  ;
           end
  
      endcase 
    end

  always @(*)
    begin
      case (simd_core_exp_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_EXP_CNTL_WAIT: 
           begin
             sfu_exp_done   = 1'b0 ;
           end
        `SIMD_CORE_SFU_EXP_CNTL_COMPLETE: 
           begin
             sfu_exp_done   = 1'b1 ;
           end
        default:
           begin
             sfu_exp_done   = 1'b0 ;
           end
      endcase 
    end

  // Create load signals
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(*)
          begin
            case (simd_core_exp_cntl_state)  // synopsys parallel_case
              `SIMD_CORE_SFU_EXP_CNTL_LOAD: 
                begin
                  if (lane==exp_register_index)
                    begin
                      sfu_exp_local_regs     [lane]       =  exp_output_reg ;
                      sfu_exp_load_local_reg [lane]       = 1'b1            ; 
                    end
                  else
                    begin
                      sfu_exp_local_regs     [lane]       = 'd0 ;
                      sfu_exp_load_local_reg [lane]       = 'b0 ;
                    end
                end
              default:
                begin
                  sfu_exp_local_regs     [lane]       = 'd0 ;
                  sfu_exp_load_local_reg [lane]       = 'b0 ;
                end
            endcase 
          end
      end
  endgenerate

  // EXP doesnt write to common reg
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        //always @(*)
        //  begin
            assign sfu_exp_load_common_reg    [lane]  = 'b0 ;
                                                                                                                                  
            assign sfu_exp_common_regs        [lane]  = 'd0 ;
        //  end
      end
  endgenerate



  DW_fp_exp  #(
                   .sig_width       ( 23), 
                   .exp_width       ( 8 ), 
                   .ieee_compliance ( 1 ),
                   .arch            ( 2 )
               )
  DW_fp_exp   ( .a     ( exp_input  ), 
                .z     ( exp_output ),
                .status( ));



  //----------------------------------------------------------------------------------------------------
  // Compare
 
  reg [`SIMD_CORE_SFU_CMP_CNTL_STATE_RANGE ]    simd_core_cmp_cntl_state      ; // state flop
  reg [`SIMD_CORE_SFU_CMP_CNTL_STATE_RANGE ]    simd_core_cmp_cntl_state_next ;
  
  reg   [`PE_EXEC_LANE_COUNT_P1_RANGE      ]    cmp_register_count      ;  // when MSB is one we have cycled thru all regs
  reg   [`PE_EXEC_LANE_COUNT_P1_RANGE      ]    cmp_register_index      ;  // index thru registers 0-31
  reg   [`PE_EXEC_LANE_WIDTH_RANGE         ]    cmp_input    [2]        ;
  wire  [`SIMD_CORE_SFU_CMP_OUTPUTS_RANGE  ]    cmp_output              ;  //I0 eq I1, I0 lt I1, I0 gt I1
  reg   [`SIMD_CORE_SFU_CMP_OUTPUTS_RANGE  ]    cmp_output_reg          ;  //I0 eq I1, I0 lt I1, I0 gt I1
  reg                                           cmp_result_eq_reg       ; 
  reg                                           cmp_result_lt_reg       ; 
  reg                                           cmp_result_gt_reg       ; 
  reg                                           cmp_initial             ; // initially set common reg to -INF


  // CMP Controller
  //
  
  // State register 
  always @(posedge clk)
    begin
      simd_core_cmp_cntl_state <= ( reset_poweron ) ? `SIMD_CORE_SFU_CMP_CNTL_WAIT       :
                                                       simd_core_cmp_cntl_state_next  ;
    end
  
 
  always @(*)
    begin
      case (simd_core_cmp_cntl_state)  // synopsys parallel_case

        
        // use special op for first transition, then use curr_special_op
        `SIMD_CORE_SFU_CMP_CNTL_WAIT: 
          simd_core_cmp_cntl_state_next =  ( start_special_function  && (special_op == `SIMD_WRAP_OPERATION_CMP )) ? `SIMD_CORE_SFU_CMP_CNTL_SETTLE  :  
                                                                                                                     `SIMD_CORE_SFU_CMP_CNTL_WAIT     ;
  
        `SIMD_CORE_SFU_CMP_CNTL_SETTLE: 
          simd_core_cmp_cntl_state_next =  ( cmp_register_count ==  `SIMD_WRAP_OPERATION_CMP_MULTICYCLE  )   ?   `SIMD_CORE_SFU_CMP_CNTL_LOAD     :
                                                                                                                 `SIMD_CORE_SFU_CMP_CNTL_SETTLE   ;
  
        `SIMD_CORE_SFU_CMP_CNTL_LOAD: 
          simd_core_cmp_cntl_state_next =  `SIMD_CORE_SFU_CMP_CNTL_INC       ;
  
        `SIMD_CORE_SFU_CMP_CNTL_INC: 
          simd_core_cmp_cntl_state_next =  ( cmp_register_index[`PE_EXEC_LANE_COUNT_P1_MSB] )   ?   `SIMD_CORE_SFU_CMP_CNTL_COMPLETE     :
                                                                                                    `SIMD_CORE_SFU_CMP_CNTL_SETTLE       ;
  
        // must be a pulse state
        `SIMD_CORE_SFU_CMP_CNTL_COMPLETE: 
          simd_core_cmp_cntl_state_next =  `SIMD_CORE_SFU_CMP_CNTL_WAIT       ;
  
        // Latch state on error
        `SIMD_CORE_SFU_CMP_CNTL_ERR:
          simd_core_cmp_cntl_state_next = `SIMD_CORE_SFU_CMP_CNTL_ERR ;
  
        default:
          simd_core_cmp_cntl_state_next = `SIMD_CORE_SFU_CMP_CNTL_WAIT ;
    
      endcase 
    end // always @ (*)
  

  always @(posedge clk)
    begin
      case (simd_core_cmp_cntl_state)
        default:
           begin
             cmp_input  [0]      <= input_regs [cmp_register_index]  ;

             cmp_input  [1]      <= ( cmp_initial         )  ?  `COMMON_IEEE754_FLOAT_NEG_INFINITY :
                                                                local_regs [cmp_register_index]    ;
           end
      endcase 
    end

  always @(posedge clk)
    begin
      case (simd_core_cmp_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_CMP_CNTL_WAIT: 
           begin
             cmp_output_reg          <= 'd0 ;
             cmp_register_index      <= 'd0 ;
             cmp_register_count      <= 'd0 ;
           end
  
        `SIMD_CORE_SFU_CMP_CNTL_SETTLE: 
           begin
             cmp_output_reg      <= cmp_output      ;

             cmp_register_index      <= cmp_register_index       ;
             cmp_register_count      <= cmp_register_count +'d1  ;
           end
  
        `SIMD_CORE_SFU_CMP_CNTL_LOAD: 
           begin
             cmp_output_reg      <= cmp_output      ;

             cmp_register_index      <= cmp_register_index + 'd1 ;
             cmp_register_count      <= 'd0                      ;
           end
  
        default:
           begin
             cmp_output_reg      <= cmp_output_reg ;

             cmp_register_index      <= cmp_register_index  ;
             cmp_register_count      <= cmp_register_count  ;
           end
  
      endcase 
    end

  always @(*)
    begin
      case (simd_core_cmp_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_CMP_CNTL_WAIT: 
           begin
             sfu_cmp_done   = 1'b0 ;
           end
        `SIMD_CORE_SFU_CMP_CNTL_COMPLETE: 
           begin
             sfu_cmp_done   = 1'b1 ;
           end
        default:
           begin
             sfu_cmp_done   = 1'b0 ;
           end
      endcase 
    end

  // Create load signals
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(*)
          begin
            case (simd_core_cmp_cntl_state)  // synopsys parallel_case
              `SIMD_CORE_SFU_CMP_CNTL_LOAD: 
                begin
                  if (lane==cmp_register_index)
                    begin
                      sfu_cmp_local_regs     [lane]       =  ( cmp_output_reg [`SIMD_CORE_SFU_CMP_OP_GT  ])  ?  input_regs [cmp_register_index] :
                                                                                                                local_regs [cmp_register_index] ;
                      sfu_cmp_load_local_reg [lane]       = 1'b1            ; 
                    end
                  else
                    begin
                      sfu_cmp_local_regs     [lane]       = 'd0 ;
                      sfu_cmp_load_local_reg [lane]       = 'b0 ;
                    end
                end
              default:
                begin
                  sfu_cmp_local_regs     [lane]       = 'd0 ;
                  sfu_cmp_load_local_reg [lane]       = 'b0 ;
                end
            endcase 
          end
      end
  endgenerate

  // CMP doesnt write to common reg
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        //always @(*)
        //  begin
            assign sfu_cmp_load_common_reg    [lane]  = 'b0 ;
                                                                                                                                  
            assign sfu_cmp_common_regs        [lane]  = 'd0 ;
        //  end
      end
  endgenerate


  DW_fp_cmp  #(
                   .sig_width       ( 23), 
                   .exp_width       ( 8 ), 
                   .ieee_compliance ( 1 )
                  )
  DW_fp_cmp   ( 
                // Inputs
                .a             ( cmp_input [0]                          ), 
                .b             ( cmp_input [1]                          ), 
                .zctr          ( 1'b1                                   ),   // z0 - max, z1 - min
                // Outputs
                .aeqb          ( cmp_output [`SIMD_CORE_SFU_CMP_EQ_BIT] ), 
                .altb          ( cmp_output [`SIMD_CORE_SFU_CMP_LT_BIT] ), 
                .agtb          ( cmp_output [`SIMD_CORE_SFU_CMP_GT_BIT] ), 
                .unordered     (                                        ),   // FIXME
                .z0            (                                        ),   // FIXME 
                .z1            (                                        ),   // FIXME 
                .status0       (                                        ),
                .status1       (                                        ));

  always @(*)
    begin
      cmp_result_eq_reg    =  cmp_output [`SIMD_CORE_SFU_CMP_EQ_BIT]   ; 
      cmp_result_lt_reg    =  cmp_output [`SIMD_CORE_SFU_CMP_LT_BIT]   ; 
      cmp_result_gt_reg    =  cmp_output [`SIMD_CORE_SFU_CMP_GT_BIT]   ; 
    end

  always @(posedge clk)
    begin
      cmp_initial <= ( reset_poweron                                                 )  ?  1'b1        :
                     ( simd_core_cmp_cntl_state ==  `SIMD_CORE_SFU_CMP_CNTL_COMPLETE )  ?  1'b1        :
                     ( send_local_regs                                               )  ?  1'b0        :
                                                                                           cmp_initial ;
    end
  
  //----------------------------------------------------------------------------------------------------
  // Divider
 
 
  reg [`SIMD_CORE_SFU_DIV_CNTL_STATE_RANGE ] simd_core_div_cntl_state      ; // state flop
  reg [`SIMD_CORE_SFU_DIV_CNTL_STATE_RANGE ] simd_core_div_cntl_state_next ;
  
  reg   [`PE_EXEC_LANE_COUNT_P1_RANGE   ]    div_register_count      ;  // when MSB is one we have cycled thru all regs
  reg   [`PE_EXEC_LANE_COUNT_P1_RANGE   ]    div_register_index      ;  // index thru registers 0-31
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    div_output_reg          ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE      ]    div_input   [2]         ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE      ]    div_output              ;
  reg                                        div_start               ;
  wire                                       div_complete            ;


  // DIV Controller
  //
  
  // State register 
  always @(posedge clk)
    begin
      simd_core_div_cntl_state <= ( reset_poweron ) ? `SIMD_CORE_SFU_DIV_CNTL_WAIT    :
                                                       simd_core_div_cntl_state_next  ;
    end
  
 
  always @(*)
    begin
      case (simd_core_div_cntl_state)  // synopsys parallel_case

        
        // use special op for first transition, then use curr_special_op
        `SIMD_CORE_SFU_DIV_CNTL_WAIT: 
          simd_core_div_cntl_state_next =  ( start_special_function  && (special_op == `SIMD_WRAP_OPERATION_DIV   )) ? `SIMD_CORE_SFU_DIV_CNTL_LOAD_INPUTS    :  
                                           ( start_special_function  && (special_op == `SIMD_WRAP_OPERATION_RECIP )) ? `SIMD_CORE_SFU_DIV_CNTL_LOAD_INPUTS    :  
                                                                                                                       `SIMD_CORE_SFU_DIV_CNTL_WAIT     ;
  
        `SIMD_CORE_SFU_DIV_CNTL_LOAD_INPUTS: 
          simd_core_div_cntl_state_next =  `SIMD_CORE_SFU_DIV_CNTL_START ;
  
        `SIMD_CORE_SFU_DIV_CNTL_START: 
          simd_core_div_cntl_state_next =  `SIMD_CORE_SFU_DIV_CNTL_WAIT_DIV_START   ;
  
        `SIMD_CORE_SFU_DIV_CNTL_WAIT_DIV_START: 
          simd_core_div_cntl_state_next =  ( ~div_complete             )   ?   `SIMD_CORE_SFU_DIV_CNTL_SETTLE         :
                                                                               `SIMD_CORE_SFU_DIV_CNTL_WAIT_DIV_START ;
  
        `SIMD_CORE_SFU_DIV_CNTL_SETTLE: 
          simd_core_div_cntl_state_next =  ( div_complete )   ?   `SIMD_CORE_SFU_DIV_CNTL_LOAD     :
                                                                  `SIMD_CORE_SFU_DIV_CNTL_SETTLE   ;
  
        `SIMD_CORE_SFU_DIV_CNTL_LOAD: 
          simd_core_div_cntl_state_next =  `SIMD_CORE_SFU_DIV_CNTL_LOAD_LOCAL       ;  // load div_output_reg
  
        `SIMD_CORE_SFU_DIV_CNTL_LOAD_LOCAL: 
          simd_core_div_cntl_state_next =  `SIMD_CORE_SFU_DIV_CNTL_INC ;  // index add to local_regs and increment index
  
        `SIMD_CORE_SFU_DIV_CNTL_INC: 
          simd_core_div_cntl_state_next =  ( div_register_index[`PE_EXEC_LANE_COUNT_P1_MSB] )   ?   `SIMD_CORE_SFU_DIV_CNTL_COMPLETE     :
                                           ( curr_special_op == `SIMD_WRAP_OPERATION_RECIP  )   ?   `SIMD_CORE_SFU_DIV_CNTL_COMPLETE     :
                                                                                                    `SIMD_CORE_SFU_DIV_CNTL_LOAD_INPUTS     ;
  
        // must be a pulse state
        `SIMD_CORE_SFU_DIV_CNTL_COMPLETE: 
          simd_core_div_cntl_state_next =  `SIMD_CORE_SFU_DIV_CNTL_WAIT       ;
  
        // Latch state on error
        `SIMD_CORE_SFU_DIV_CNTL_ERR:
          simd_core_div_cntl_state_next = `SIMD_CORE_SFU_DIV_CNTL_ERR ;
  
        default:
          simd_core_div_cntl_state_next = `SIMD_CORE_SFU_DIV_CNTL_WAIT ;
    
      endcase 
    end // always @ (*)
  

  always @(*)
    begin
      case (simd_core_div_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_DIV_CNTL_START: 
           begin
             div_start  =   1'b1 ;
           end
  
        default:
           begin
             div_start  =   1'b0 ;
           end
      endcase 
    end

  always @(posedge clk)
    begin
      case (simd_core_div_cntl_state)  // synopsys parallel_case
        /*
        `SIMD_CORE_SFU_DIV_CNTL_WAIT: 
           begin
             div_input [0]        <= input_regs [div_register_index]  ;
             div_input [1]        <= common_regs[0] ;
           end
        */
  
        `SIMD_CORE_SFU_DIV_CNTL_LOAD_INPUTS: 
           begin
             case (curr_special_op)
               `SIMD_WRAP_OPERATION_RECIP:
                 begin                   
                   div_input [0]        <= `COMMON_IEEE754_FLOAT_ONE  ;
                   div_input [1]        <= common_regs[common_index]  ;
                 end                   
               default:
                 begin                   
                   div_input [0]        <= input_regs [div_register_index]  ;
                   div_input [1]        <= common_regs[common_index]        ;
                 end                   
             endcase
           end
  
        default:
           begin
             div_input [0]        <= div_input [0] ;
             div_input [1]        <= div_input [1] ;
           end
      endcase 
    end

  always @(posedge clk)
    begin
      case (simd_core_div_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_DIV_CNTL_WAIT: 
           begin
             div_output_reg          <= 'd0 ;
             div_register_index      <= 'd0 ;
             div_register_count      <= 'd0 ;
           end
  
        `SIMD_CORE_SFU_DIV_CNTL_SETTLE: 
           begin
             div_output_reg      <= div_output      ;

             div_register_index      <= div_register_index       ;
             div_register_count      <= div_register_count +'d1  ;
           end
  
        `SIMD_CORE_SFU_DIV_CNTL_LOAD: 
           begin
             div_output_reg      <= div_output      ;

             div_register_index      <= div_register_index  ;
             div_register_count      <= 'd0                 ;
           end
  
        `SIMD_CORE_SFU_DIV_CNTL_LOAD_LOCAL: 
           begin
             div_output_reg      <= div_output_reg      ;

             div_register_index      <= div_register_index + 'd1 ;
             div_register_count      <= 'd0                      ;
           end
  
        default:
           begin
             div_output_reg      <= div_output_reg ;

             div_register_index      <= div_register_index  ;
             div_register_count      <= div_register_count  ;
           end
  
      endcase 
    end

  always @(*)
    begin
      case (simd_core_div_cntl_state)  // synopsys parallel_case
        `SIMD_CORE_SFU_DIV_CNTL_WAIT: 
           begin
             sfu_div_done   = 1'b0 ;
           end
        `SIMD_CORE_SFU_DIV_CNTL_COMPLETE: 
           begin
             sfu_div_done   = 1'b1 ;
           end
        default:
           begin
             sfu_div_done   = 1'b0 ;
           end
      endcase 
    end

  // Create load signals
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(*)
          begin
            case (simd_core_div_cntl_state)  // synopsys parallel_case
              `SIMD_CORE_SFU_DIV_CNTL_LOAD_LOCAL: 
                begin
                   case (curr_special_op)
                     `SIMD_WRAP_OPERATION_DIV :
                       begin
                         if (lane==div_register_index)
                           begin
                             sfu_div_local_regs     [lane]       =  div_output_reg ;
                             sfu_div_load_local_reg [lane]       = 1'b1            ; 
                           end
                         else
                           begin
                             sfu_div_local_regs     [lane]       = 'd0 ;
                             sfu_div_load_local_reg [lane]       = 'b0 ;
                           end
                       end
                     default:
                       begin
                         sfu_div_local_regs     [lane]       = 'd0 ;
                         sfu_div_load_local_reg [lane]       = 'b0 ;
                       end
                   endcase 
                end
              default:
                begin
                  sfu_div_local_regs     [lane]       = 'd0 ;
                  sfu_div_load_local_reg [lane]       = 'b0 ;
                end
            endcase 
          end
      end
  endgenerate



  // DIV doesnt write to common reg
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(*)
          begin
            case (simd_core_div_cntl_state)  // synopsys parallel_case
              `SIMD_CORE_SFU_DIV_CNTL_LOAD_LOCAL: 
                begin
                   case (curr_special_op)
                     `SIMD_WRAP_OPERATION_RECIP :
                       begin
                         if (lane==common_index)
                           begin
                             sfu_div_common_regs     [lane]       =  div_output_reg ;
                             sfu_div_load_common_reg [lane]       = 1'b1            ; 
                           end
                         else
                           begin
                             sfu_div_common_regs     [lane]       = 'd0 ;
                             sfu_div_load_common_reg [lane]       = 'b0 ;
                           end
                       end
                     default:
                       begin
                         sfu_div_common_regs     [lane]       = 'd0 ;
                         sfu_div_load_common_reg [lane]       = 'b0 ;
                       end
                   endcase 
                end
              default:
                begin
                  sfu_div_common_regs     [lane]       = 'd0 ;
                  sfu_div_load_common_reg [lane]       = 'b0 ;
                end
            endcase 
          end
      end
  endgenerate


  DW_fp_div_seq  #(
                   .sig_width       ( 23), 
                   .exp_width       ( 8 ), 
                   .ieee_compliance ( 1 ),
                   .num_cyc         ( `SIMD_WRAP_OPERATION_DIV_MULTICYCLE ),
                   .rst_mode        ( 1 ),
                   .input_mode      ( 1 ),
                   .output_mode     ( 1 ),
                   .early_start     ( 0 ),
                   .internal_reg    ( 1 )
                   )
  DW_fp_div_seq   ( .a         ( div_input [0]          ), 
                    .b         ( div_input [1]          ), 
                    .rnd       ( 3'b000                 ),
                    .start     ( div_start              ),
                    .z         ( div_output             ),
                    .complete  ( div_complete           ),
                    .status    (                        ),
                    .rst_n     (~reset_poweron          ), 
                    .clk       ( clk                    )
                 );

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Output to streaming Ops

  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES ; lane=lane+1) 
      begin: reg_to_simd_out 
        always @(posedge clk)
          begin
            simd__smdw__common_regs_valid [lane] = common_regs_valid [lane]  ;
            simd__smdw__common_regs       [lane] = common_regs [lane]        ;
          end
      end
  endgenerate

endmodule

