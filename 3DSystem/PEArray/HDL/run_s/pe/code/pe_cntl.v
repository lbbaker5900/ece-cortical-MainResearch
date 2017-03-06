/*********************************************************************************************

    File name   : pe_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Feb 2017
    email       : lbbaker@ncsu.edu

    Description : This module converts OOB information and/or lane control data to local control for simd and stOp.
                  The oob_data is organized as {option, data} tuples and the data hold 2 tuples per cycle

                  For simd and stOp configuration, the OOB packet from the manager indexes memories in this module to control the stOp and simd.
                  The assumtion is the configurations for the operations can be stored locally and have been preloaded and we simply send a pointer to the operation in this local memory.
                  Note: we currently assume we only need PE specific data and things like number of operands and addresses are common.

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "stack_interface.vh"
`include "pe_cntl.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"

module pe_cntl (

            //-------------------------------
            // Stack Bus interface
            //
            sys__pe__peId                                 ,
            
            // OOB Downstream carries PE configuration 
            sti__cntl__oob_cntl                           ,
            sti__cntl__oob_valid                          ,
            cntl__sti__oob_ready                          ,
            sti__cntl__oob_type                           ,
            sti__cntl__oob_data                           ,
            
            //-------------------------------
            // Configuration output
            //
            `include "pe_simd_ports.vh"
            stOp_complete                                 ,

            //-------------------------------
            // General
            //
            clk              ,
            reset_poweron    
 
    );

  //----------------------------------------------------------------------------------------------------
  // General

  input                                           clk                          ;
  input                                           reset_poweron                ;

  input [`PE_PE_ID_RANGE                 ]        sys__pe__peId                ;

  //----------------------------------------------------------------------------------------------------
  // Stack down OOB

  input [`COMMON_STD_INTF_CNTL_RANGE     ]        sti__cntl__oob_cntl            ;
  input                                           sti__cntl__oob_valid           ;
  output                                          cntl__sti__oob_ready           ;
  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]        sti__cntl__oob_type            ;
  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]        sti__cntl__oob_data            ;
                                                
  input                                           stOp_complete                  ;  // dont allow another OOB command until we are complete

  //----------------------------------------------------------------------------------------------------
  // Outputs to controller

  `include "pe_cntl_simd_port_declarations.vh"

  //----------------------------------------------------------------------------------------------------
  // Configuration output

  wire   [`STREAMING_OP_CNTL_OPERATION_RANGE ]    stOp_operation             ;  

  wire   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress0             ;  
  wire   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress0        ;  
  wire   [`PE_DATA_TYPES_RANGE               ]    src_data_type0             ;
  wire   [`PE_DATA_TYPES_RANGE               ]    dest_data_type0            ;

  wire   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress1             ;  
  wire   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress1        ;  
  wire   [`PE_DATA_TYPES_RANGE               ]    src_data_type1             ;
  wire   [`PE_DATA_TYPES_RANGE               ]    dest_data_type1            ;

  wire   [`PE_MAX_NUM_OF_TYPES_RANGE         ]    numberOfOperands           ;



  //----------------------------------------------------------------------------------------------------
  // Registers/Wires

  reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    stOp_optionPtr             ; 
  reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    simd_optionPtr             ; 
  reg                                             command_valid              ;  // when a command has been received
  reg                                             stOp_complete_d1           ;  // we will create a pulse off the rising edge
  wire                                            stOp_completed             ;  // a pulse indicating a command has been run and completed
  wire                                            stOp_complete_deasserted   ;  // we deassert rs0[0] and wait for complete to deassert before starting next command
  reg                                             sti__cntl__oob_valid_d1    ;  // we will create a pulse off the rising edge

  `include "pe_cntl_simd_instance_wires.vh"

  //----------------------------------------------------------------------------------------------------
  // Connections from control memory to all simd lane control
  //
  // Originally the control for the stOp was going to come from the simd registers, so we have maintain the register naming for the stOp although these should probably change.
  //
  genvar pe, lane;
  generate
      for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane=lane+1)
          begin
              wire  [`PE_CHIPLET_LANE_ADDR_BITS_RANGE ]     lane_from_genvar;
              assign lane_from_genvar                     = lane                  ;

              // From the manager, we use a common address for all lanes, so index into the lane memory
              assign simd__cntl__lane_r130[lane]          = {simd__cntl__lane_r130_e1[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  simd__cntl__lane_r130_e1[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
              assign simd__cntl__lane_r134[lane]          = {simd__cntl__lane_r134_e1[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  simd__cntl__lane_r134_e1[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
              assign simd__cntl__lane_r132[lane][19:16]   = simd__cntl__lane_r132_e1[19:16]   ;  // type (bit, nibble, byte, word)
                                                                                              
              assign simd__cntl__lane_r131[lane]          = {simd__cntl__lane_r131_e1[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  simd__cntl__lane_r131_e1[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
              assign simd__cntl__lane_r135[lane]          = {simd__cntl__lane_r135_e1[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  simd__cntl__lane_r135_e1[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
              assign simd__cntl__lane_r133[lane][19:16]   = simd__cntl__lane_r133_e1[19:16]   ;  // type (bit, nibble, byte, word)
                                                                                              
              assign simd__cntl__lane_r133[lane][15: 0]   = simd__cntl__lane_r133_e1[15: 0]   ;
              assign simd__cntl__lane_r132[lane][15: 0]   = simd__cntl__lane_r132_e1[15: 0]   ;  // num of types - for dma
                                                                                              
              assign simd__cntl__rs0[0]                   = simd__cntl__rs0_e1[0]             ;
              assign simd__cntl__rs0[31:1]                = simd__cntl__rs0_e1[31:1]          ;  // `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM ;
              assign simd__cntl__rs1                      = simd__cntl__rs1_e1                ;
          end
  endgenerate

  always @(posedge clk)
    begin
      simd__cntl__lane_r130_e1          <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( sti__cntl__oob_valid_d1 ) ? sourceAddress0                                      : simd__cntl__lane_r130_e1          ;
      simd__cntl__lane_r134_e1          <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( sti__cntl__oob_valid_d1 ) ? destinationAddress0                                 : simd__cntl__lane_r134_e1          ;
      simd__cntl__lane_r132_e1[19:16]   <= (reset_poweron ) ? 4'd0                    : ( sti__cntl__oob_valid_d1 ) ? src_data_type0                                      : simd__cntl__lane_r132_e1[19:16]   ;  // type (bit, nibble, byte, word)
                                                                                                                                                                                                            
      simd__cntl__lane_r131_e1          <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( sti__cntl__oob_valid_d1 ) ? sourceAddress1                                      : simd__cntl__lane_r131_e1          ;
      simd__cntl__lane_r135_e1          <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( sti__cntl__oob_valid_d1 ) ? destinationAddress1                                 : simd__cntl__lane_r135_e1          ;
      simd__cntl__lane_r133_e1[19:16]   <= (reset_poweron ) ? 4'd0                    : ( sti__cntl__oob_valid_d1 ) ? src_data_type1                                      : simd__cntl__lane_r133_e1[19:16]   ;  // type (bit, nibble, byte, word)
                                                                                                                                                                                                            
      simd__cntl__lane_r133_e1[15: 0]   <= (reset_poweron ) ? 16'd0                   : ( sti__cntl__oob_valid_d1 ) ? numberOfOperands                                    : simd__cntl__lane_r133_e1[15: 0]   ;
      simd__cntl__lane_r132_e1[15: 0]   <= (reset_poweron ) ? 16'd0                   : ( sti__cntl__oob_valid_d1 ) ? numberOfOperands                                    : simd__cntl__lane_r132_e1[15: 0]   ;  // num of types - for dma
                                                                                                                                                                                                            
      simd__cntl__rs0_e1[0]             <= (reset_poweron ) ? 1'b0                    : ( sti__cntl__oob_valid_d1 ) ? 1'b1                  : ( stOp_completed ) ? 1'b0   : simd__cntl__rs0_e1[0]             ;
      simd__cntl__rs0_e1[31:1]          <= (reset_poweron ) ? 31'd0                   : ( sti__cntl__oob_valid_d1 ) ? stOp_operation                                      : simd__cntl__rs0_e1[31:1]          ;  // `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM ;
      simd__cntl__rs1_e1                <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( sti__cntl__oob_valid_d1 ) ? {32{1'b1}}                                          : simd__cntl__rs1_e1                ;
    end
  //----------------------------------------------------------------------------------------------------
  // StreamingOp configuration memory
  //
  //  - stOp fields are accessed by a pointer provided in the OOB {option,value} tuple
  //
  
  pe_cntl_stOp_rom pe_cntl_stOp_rom (  
                                     .valid                 ( sti__cntl__oob_valid ),  // used by readmem. If we are receiving a WU, update control memory
                                     .optionPtr             ( stOp_optionPtr       ),
                                                                                  
                                     .stOp_operation        ( stOp_operation       ),
                                                                                  
                                     .sourceAddress0        ( sourceAddress0       ),
                                     .destinationAddress0   ( destinationAddress0  ),
                                     .src_data_type0        ( src_data_type0       ),
                                     .dest_data_type0       ( dest_data_type0      ),
                                                                                  
                                     .sourceAddress1        ( sourceAddress1       ),
                                     .destinationAddress1   ( destinationAddress1  ),
                                     .src_data_type1        ( src_data_type1       ),
                                     .dest_data_type1       ( dest_data_type1      ),
                                                                                  
                                     .numberOfOperands      ( numberOfOperands     ),
                                
                                     .sys__pe__peId         ( sys__pe__peId        ),
                                     .clk
                                  );

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //
  // examine {option, value} tuples and set local fields
  always @(posedge clk)
    begin
      // pointer to stOp operation control memory
      stOp_optionPtr           <=  ( reset_poweron                                                                                         ) ?  'd0                         :
                                   ( sti__cntl__oob_valid  && (sti__cntl__oob_data[`PE_CNTL_OOB_OPTION0_RANGE] == `PE_CNTL_OOB_OPTION_STOP)) ? sti__cntl__oob_data[`PE_CNTL_OOB_OPTION0_DATA_RANGE] :
                                   ( sti__cntl__oob_valid  && (sti__cntl__oob_data[`PE_CNTL_OOB_OPTION1_RANGE] == `PE_CNTL_OOB_OPTION_STOP)) ? sti__cntl__oob_data[`PE_CNTL_OOB_OPTION1_DATA_RANGE] :
                                                                                                                                               stOp_optionPtr                                       ;
      command_valid            <=  ( reset_poweron                 ) ? 1'd0            :
                                   ( sti__cntl__oob_valid          ) ? 1'b1            :
                                   ( stOp_complete_deasserted      ) ? 1'b0            :  // the stOp_cntl is readt once it deasserts complete after we deassert rs[0] (enable)
                                                                       command_valid   ;
      stOp_complete_d1         <=  stOp_complete               ;
      sti__cntl__oob_valid_d1  <=  sti__cntl__oob_valid        ;
    end

  assign cntl__sti__oob_ready           = ~command_valid                   ;  // we are ready when there isnt a valid command:w
  assign stOp_completed                 = stOp_complete & ~stOp_complete_d1;
  assign stOp_complete_deasserted       = ~stOp_complete & stOp_complete_d1;

endmodule


//----------------------------------------------------------------------------------------------------
// PE control memory
//
// Contains the configuration for the SIMD and streamingOp. The OOB packet from the
// manager indexes this memories to control the stOp and simd.
//
// The OOB packet from the manager contains PE specific information in the form of a pointer into these memories The pointer is extracted from the
// {option, value} tuples in the oob data.
// Note: we currently assume we only need PE specific data and things like number of operands and addresses are common.
// 
module pe_cntl_stOp_rom (  
                           valid                       ,
                           optionPtr                   ,

                           stOp_operation              ,
                                                 
                           sourceAddress0              ,
                           destinationAddress0         ,
                           src_data_type0              ,
                           dest_data_type0             ,
                                                 
                           sourceAddress1              ,
                           destinationAddress1         ,
                           src_data_type1              ,
                           dest_data_type1             ,
                                                 
                           numberOfOperands            ,

                           sys__pe__peId               ,

                           clk
                        );

    input                                           clk                        ;
    input                                           valid                      ;
    input  [`PE_PE_ID_RANGE                    ]    sys__pe__peId              ;

    input  [`PE_CNTL_OOB_OPTION_RANGE          ]    optionPtr                  ; 
    
    output [`STREAMING_OP_CNTL_OPERATION_RANGE ]    stOp_operation             ;  

    output [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress0             ;  
    output [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress0        ;  
    output [`PE_DATA_TYPES_RANGE               ]    src_data_type0             ;
    output [`PE_DATA_TYPES_RANGE               ]    dest_data_type0            ;

    output [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress1             ;  
    output [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress1        ;  
    output [`PE_DATA_TYPES_RANGE               ]    src_data_type1             ;
    output [`PE_DATA_TYPES_RANGE               ]    dest_data_type1            ;

    output [`PE_MAX_NUM_OF_TYPES_RANGE         ]    numberOfOperands           ;

    
    reg [`STREAMING_OP_CNTL_OPERATION_RANGE ]    stOp_cntl_memory_stOp_operation          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  

    reg [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    stOp_cntl_memory_sourceAddress0          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  
    reg [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    stOp_cntl_memory_destinationAddress0     [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  
    reg [`PE_DATA_TYPES_RANGE               ]    stOp_cntl_memory_src_data_type0          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;
    reg [`PE_DATA_TYPES_RANGE               ]    stOp_cntl_memory_dest_data_type0         [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;

    reg [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    stOp_cntl_memory_sourceAddress1          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  
    reg [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    stOp_cntl_memory_destinationAddress1     [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  
    reg [`PE_DATA_TYPES_RANGE               ]    stOp_cntl_memory_src_data_type1          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;
    reg [`PE_DATA_TYPES_RANGE               ]    stOp_cntl_memory_dest_data_type1         [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;

    reg [`PE_MAX_NUM_OF_TYPES_RANGE         ]    stOp_cntl_memory_numberOfOperands        [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;
    
    // The memory is updated using the testbench, so everytime we see an option, reload the memory
    always @(posedge valid) 
      begin
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_stOp_operation.dat"      , sys__pe__peId) ,   stOp_cntl_memory_stOp_operation      );

        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress0.dat"      , sys__pe__peId) ,   stOp_cntl_memory_sourceAddress0      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress0.dat" , sys__pe__peId) ,   stOp_cntl_memory_destinationAddress0 );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type0.dat"      , sys__pe__peId) ,   stOp_cntl_memory_src_data_type0      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type0.dat"     , sys__pe__peId) ,   stOp_cntl_memory_dest_data_type0     );

        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress1.dat"      , sys__pe__peId) ,   stOp_cntl_memory_sourceAddress1      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress1.dat" , sys__pe__peId) ,   stOp_cntl_memory_destinationAddress1 );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type1.dat"      , sys__pe__peId) ,   stOp_cntl_memory_src_data_type1      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type1.dat"     , sys__pe__peId) ,   stOp_cntl_memory_dest_data_type1     );

        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_numberOfOperands.dat"    , sys__pe__peId) ,   stOp_cntl_memory_numberOfOperands    );
      end
    
    
    // 
    reg    [`STREAMING_OP_CNTL_OPERATION_RANGE ]    stOp_operation             ;  

    reg    [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress0             ;  
    reg    [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress0        ;  
    reg    [`PE_DATA_TYPES_RANGE               ]    src_data_type0             ;
    reg    [`PE_DATA_TYPES_RANGE               ]    dest_data_type0            ;

    reg    [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress1             ;  
    reg    [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress1        ;  
    reg    [`PE_DATA_TYPES_RANGE               ]    src_data_type1             ;
    reg    [`PE_DATA_TYPES_RANGE               ]    dest_data_type1            ;

    reg    [`PE_MAX_NUM_OF_TYPES_RANGE         ]    numberOfOperands           ;

    always @(*) 
      begin 
        #0.3  stOp_operation       =  stOp_cntl_memory_stOp_operation       [optionPtr] ;

        #0.3  sourceAddress0       =  stOp_cntl_memory_sourceAddress0       [optionPtr] ;
        #0.3  destinationAddress0  =  stOp_cntl_memory_destinationAddress0  [optionPtr] ;
        #0.3  src_data_type0       =  stOp_cntl_memory_src_data_type0       [optionPtr] ;
        #0.3  dest_data_type0      =  stOp_cntl_memory_dest_data_type0      [optionPtr] ;

        #0.3  sourceAddress1       =  stOp_cntl_memory_sourceAddress1       [optionPtr] ;
        #0.3  destinationAddress1  =  stOp_cntl_memory_destinationAddress1  [optionPtr] ;
        #0.3  src_data_type1       =  stOp_cntl_memory_src_data_type1       [optionPtr] ;
        #0.3  dest_data_type1      =  stOp_cntl_memory_dest_data_type1      [optionPtr] ;

        #0.3  numberOfOperands     =  stOp_cntl_memory_numberOfOperands     [optionPtr] ;
      end

endmodule

