/*********************************************************************************************

    File name   : pe_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Feb 2017
    email       : lbbaker@ncsu.edu

    Description : This module converts OOB information to local control
                  The oob_data is organized as {option, data} tuples and the data hold 2 tuples per cycle

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

  `include "pe_simd_instance_wires.vh"

  //----------------------------------------------------------------------------------------------------
  // Connections from control memory to all simd lane control
  //
  genvar pe, lane;
  generate
      for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane=lane+1)
          begin
              wire  [`PE_CHIPLET_LANE_ADDR_BITS_RANGE ]     lane_from_genvar;
              assign lane_from_genvar                     = lane                  ;

              // From the manager, we use a common address for all lanes, so index into the lane memory
              assign simd__cntl__lane_r130[lane]          = {sourceAddress0     [`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  sourceAddress0     [`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
              assign simd__cntl__lane_r134[lane]          = {destinationAddress0[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  destinationAddress0[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
              assign simd__cntl__lane_r132[lane][19:16]   = src_data_type0        ;  // type (bit, nibble, byte, word)

              assign simd__cntl__lane_r131[lane]          = {sourceAddress1     [`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  sourceAddress1     [`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
              assign simd__cntl__lane_r135[lane]          = {destinationAddress1[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  destinationAddress1[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
              assign simd__cntl__lane_r133[lane][19:16]   = src_data_type1        ;  // type (bit, nibble, byte, word)

              assign simd__cntl__lane_r133[lane][15: 0]   = numberOfOperands      ;
              assign simd__cntl__lane_r132[lane][15: 0]   = numberOfOperands      ;  // num of types - for dma

              assign simd__cntl__rs0[0]                   = 1'b1                  ;
              assign simd__cntl__rs0[31:1]                = stOp_operation        ;  // `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM ;
              assign simd__cntl__rs1                      = {32{1'b1}}            ;
          end
  endgenerate

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
      stOp_optionPtr    <=  ( reset_poweron                                                                                         ) ?  'd0                         :
                            ( sti__cntl__oob_valid  && (sti__cntl__oob_data[`PE_CNTL_OOB_OPTION0_RANGE] == `PE_CNTL_OOB_OPTION_STOP)) ? sti__cntl__oob_data[`PE_CNTL_OOB_OPTION0_DATA_RANGE] :
                            ( sti__cntl__oob_valid  && (sti__cntl__oob_data[`PE_CNTL_OOB_OPTION1_RANGE] == `PE_CNTL_OOB_OPTION_STOP)) ? sti__cntl__oob_data[`PE_CNTL_OOB_OPTION1_DATA_RANGE] :
                                                                                                                                        stOp_optionPtr                                       ;
      command_valid     <=  ( reset_poweron                 ) ? 1'd0            :
                            ( sti__cntl__oob_valid          ) ? 1'b1            :
                            ( stOp_completed                ) ? 1'b0            :
                                                                command_valid   ;
      stOp_complete_d1  <=  stOp_complete   ;
    end

  assign cntl__sti__oob_ready           = ~command_valid  ;
  assign stOp_completed                 = ~stOp_complete & stOp_complete_d1;

endmodule


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

