/*********************************************************************************************

    File name   : wu_fetch.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module reads the WU memory
                  The initial wu_addr is from the system

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "pe_cntl.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "wu_fetch.vh"


module wu_fetch (

            //-------------------------------
            // WU Memory
            //
            wuf__wum__read                             ,
            wuf__wum__addr                             ,
            
            //-------------------------------
            // Configuration
            sys__wuf__start_addr                       ,
            
            //-------------------------------
            //
            xxx__wuf__stall                            ,

            //-------------------------------
            // General
            //
            clk              ,
            reset_poweron    
 
    );

  //----------------------------------------------------------------------------------------------------
  // General

  input                                     clk                          ;
  input                                     reset_poweron                ;

  //----------------------------------------------------------------------------------------------------
  // Control

  input  [`MGR_WU_ADDRESS_RANGE    ]        sys__wuf__start_addr           ;  // first WU address
  input                                     sys__wuf__enable               ;  // start fetching
  input                                     xxx__wuf__stall                ;

  //----------------------------------------------------------------------------------------------------
  // WU Memory

  output [`MGR_WU_ADDRESS_RANGE    ]        wuf__wum__addr                 ;
  output                                    wuf__wum__read                 ;


  //----------------------------------------------------------------------------------------------------
  // Registers/Wires

  reg  [`MGR_WU_ADDRESS_RANGE    ]          sys__wuf__start_addr           ;  // first WU address

  //----------------------------------------------------------------------------------------------------
  // Registered Inputs and Outputs

  always @(posedge clk)
    begin
      sys__wuf__start_addr_d1   <= ( reset_poweron   ) ? 'd0  :  sys__wuf__start_addr    ;
      wuf__wum__addr            <= ( reset_poweron   ) ? 'd0  :  wuf__wum__addr_e1       ;
      wuf__wum__read            <= ( reset_poweron   ) ? 'd0  :  wuf__wum__read_e1       ;

    end




endmodule





//----------------------------------------------------------------------------------------------------
// WU Memory
//
// Contains the WU instructions

module wu_fetch_memory (  
                           valid                       ,

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

                           sys__mgr__mgrId               ,

                           clk
                        );

    input                                       clk                            ;
    input                                       valid                          ;

    // from WU fetch
    input  [`MGR_WU_ADDRESS_RANGE          ]    wuf__wum__addr                 ;
    input                                       wuf__wum__read                 ;

    
    output [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl                ;  // instruction delineator
    output [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl                ;  // descriptor delineator

    // WU Instruction option fields
    output [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    output [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 

    



    
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl                                        [`MGR_STORAGE_DESC_MEMORY_RANGE ] ;  // instruction delineator
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl                                        [`MGR_STORAGE_DESC_MEMORY_RANGE ] ;  // descriptor delineator

    // WU Instruction option fields
    reg    [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] [`MGR_STORAGE_DESC_MEMORY_RANGE ] ;  // 
    reg    [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] [`MGR_STORAGE_DESC_MEMORY_RANGE ] ;  // 


    
    // The memory is updated using the testbench, so everytime we see an option, reload the memory
    always @(posedge valid) 
      begin
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_stOp_operation.dat"      , sys__mgr__mgrId) ,   stOp_cntl_memory_stOp_operation      );

        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress0.dat"      , sys__mgr__mgrId) ,   stOp_cntl_memory_sourceAddress0      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress0.dat" , sys__mgr__mgrId) ,   stOp_cntl_memory_destinationAddress0 );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type0.dat"      , sys__mgr__mgrId) ,   stOp_cntl_memory_src_data_type0      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type0.dat"     , sys__mgr__mgrId) ,   stOp_cntl_memory_dest_data_type0     );

        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress1.dat"      , sys__mgr__mgrId) ,   stOp_cntl_memory_sourceAddress1      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress1.dat" , sys__mgr__mgrId) ,   stOp_cntl_memory_destinationAddress1 );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type1.dat"      , sys__mgr__mgrId) ,   stOp_cntl_memory_src_data_type1      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type1.dat"     , sys__mgr__mgrId) ,   stOp_cntl_memory_dest_data_type1     );

        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_numberOfOperands.dat"    , sys__mgr__mgrId) ,   stOp_cntl_memory_numberOfOperands    );
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

