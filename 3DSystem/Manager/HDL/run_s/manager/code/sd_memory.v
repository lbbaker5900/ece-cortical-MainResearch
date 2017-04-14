/*********************************************************************************************

    File name   : sd_memory.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description :Contains the WU instructions

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
`include "sd_memory.vh"


module sd_memory (  
                           valid                       ,
                           sys__mgr__mgrId             ,

                           // from ???
                           xx1__sdm__stor_desc_ptr     ,
                           xx1__sdm__read              ,
                                                 
                           // to WU decode
                           sdm__xx1__valid             ,
                           sdm__xx1__icntl             ,
                           sdm__xx1__dcntl             ,
                           sdm__xx1__op                ,
                           sdm__xx1__option_type       ,
                           sdm__xx1__option_value      ,

                           clk
                        );

    input                                       clk                            ;
    input                                       valid                          ;
    input   [`MGR_MGR_ID_RANGE    ]             sys__mgr__mgrId                ;

    // from WU fetch
    input  [`MGR_WU_ADDRESS_RANGE          ]    xx1__sdm__addr                 ;
    input                                       xx1__sdm__read                 ;

    //----------------------------------------------------------------------------------------------------
    // to decode
    
    output                                      sdm__xx1__valid                ;
    // WU Instruction delineators
    output [`COMMON_STD_INTF_CNTL_RANGE    ]    sdm__xx1__icntl                ;  // instruction delineator
    output [`COMMON_STD_INTF_CNTL_RANGE    ]    sdm__xx1__dcntl                ;  // descriptor delineator
    output [`MGR_INST_TYPE_RANGE           ]    sdm__xx1__op                   ;  // NOP, OP, MR, MW

    // WU Instruction option fields
    output [`MGR_WU_OPT_TYPE_RANGE         ]    sdm__xx1__option_type    [`MGR_WU_OPT_PER_INST ] ;  // 
    output [`MGR_WU_OPT_VALUE_RANGE        ]    sdm__xx1__option_value   [`MGR_WU_OPT_PER_INST ] ;  // 


    //----------------------------------------------------------------------------------------------------
    // Registers and Wires

    reg                                      sdm__xx1__valid                ;
    // Delineators
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    sdm__xx1__icntl               ;  // instruction delineator
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    sdm__xx1__dcntl               ;  // descriptor delineator
    reg  [`MGR_INST_TYPE_RANGE           ]    sdm__xx1__op                  ;  // NOP, OP, MR, MW

    // WU Instruction option fields
    reg  [`MGR_WU_OPT_TYPE_RANGE         ]    sdm__xx1__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]    sdm__xx1__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 


    wire                                      valid_e1                ;
    // Delineators
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    icntl_e1                ;  // instruction delineator
    reg  [`MGR_INST_TYPE_RANGE           ]    op_e1                   ;  // 
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    dcntl_e1                ;  // descriptor delineator

    // WU Instruction option fields
    reg  [`MGR_WU_OPT_TYPE_RANGE         ]    option_type_e1    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]    option_value_e1   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 

    reg  [`MGR_WU_ADDRESS_RANGE          ]    xx1__sdm__addr_d1                ;
    reg                                       xx1__sdm__read_d1                ;

    //----------------------------------------------------------------------------------------------------
    // Register inputs and outputs

    always @(posedge clk) 
      begin
        xx1__sdm__read_d1           <=  xx1__sdm__read   ;
        xx1__sdm__addr_d1           <=  xx1__sdm__addr   ;
      end

    always @(posedge clk) 
      begin
        sdm__xx1__valid             <=  valid_e1         ;

        sdm__xx1__icntl             <=  icntl_e1         ;
        sdm__xx1__dcntl             <=  dcntl_e1         ;
        sdm__xx1__op                <=  op_e1            ;
                                                           
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_out
            sdm__xx1__option_type  [opt]  <=  option_type_e1  [opt]  ;
            sdm__xx1__option_value [opt]  <=  option_value_e1 [opt]  ;
          end
        /*
        sdm__xx1__option_type  [0]  <=  option_type_e1  [0]  ;
        sdm__xx1__option_value [0]  <=  option_value_e1 [0]  ;
        sdm__xx1__option_type  [1]  <=  option_type_e1  [1]  ;
        sdm__xx1__option_value [1]  <=  option_value_e1 [1]  ;
        */
      end

    assign valid_e1 = xx1__sdm__read_d1 ;

    //----------------------------------------------------------------------------------------------------
    // Memories 

    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    icntl                                        [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  // instruction delineator
    reg    [`MGR_INST_TYPE_RANGE           ]    op                                           [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  // 
    // WU Instruction option fields
    reg    [`MGR_WU_OPT_TYPE_RANGE         ]    option_type    [`MGR_WU_OPT_PER_INST_RANGE ] [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  // 
    reg    [`MGR_WU_OPT_VALUE_RANGE        ]    option_value   [`MGR_WU_OPT_PER_INST_RANGE ] [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  // 
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    dcntl                                        [`MGR_LOCAL_STORAGE_DESC_MEMORY_RANGE ] ;  // descriptor delineator

    
    // The memory is updated using the testbench, so everytime we see an option, reload the memory
    always @(posedge valid) 
      begin

        $readmemh($sformatf("./inputFiles/manager_%0d_layer1_icntl_readmem.dat"        , sys__mgr__mgrId) , icntl                );
        $readmemh($sformatf("./inputFiles/manager_%0d_layer1_op_readmem.dat"           , sys__mgr__mgrId) , op                   );
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_mem
            $readmemh($sformatf("./inputFiles/manager_%0d_layer1_optionType%0d_readmem.dat"  , sys__mgr__mgrId, opt) , option_type    [opt]   );
            $readmemh($sformatf("./inputFiles/manager_%0d_layer1_optionValue%0d_readmem.dat" , sys__mgr__mgrId, opt) , option_value   [opt]   );
          end
        $readmemh($sformatf("./inputFiles/manager_%0d_layer1_dcntl_readmem.dat"        , sys__mgr__mgrId) , dcntl                );
      end
    
    //----------------------------------------------------------------------------------------------------
    

    always @(*) 
      begin 
        #0.3   icntl_e1            =  (xx1__sdm__read_d1) ? icntl [xx1__sdm__addr_d1] : 'd0 ;
        #0.3   op_e1               =  (xx1__sdm__read_d1) ? op    [xx1__sdm__addr_d1] : 'd0 ;
                                
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_mem
            #0.3   option_type_e1  [opt] =  (xx1__sdm__read_d1) ? option_type    [opt] [xx1__sdm__addr_d1] : 'd0 ;
            #0.3   option_value_e1 [opt] =  (xx1__sdm__read_d1) ? option_value   [opt] [xx1__sdm__addr_d1] : 'd0 ;
          end
        #0.3   dcntl_e1            =  (xx1__sdm__read_d1) ? dcntl              [xx1__sdm__addr_d1] : 'd0 ;

      end

endmodule

