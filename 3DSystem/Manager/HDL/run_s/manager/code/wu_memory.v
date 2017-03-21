/*********************************************************************************************

    File name   : wu_memory.v
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
`include "wu_fetch.vh"


module wu_memory (  
                           valid                       ,

                           // from WU fetch
                           wuf__wum__addr              ,
                           wuf__wum__read              ,
                                                 
                           // to WU decode
                           wum__wud__valid             ,
                           wum__wud__icntl             ,
                           wum__wud__dcntl             ,
                           wum__wud__option_type       ,
                           wum__wud__option_value      ,

                           clk
                        );

    input                                       clk                            ;
    input                                       valid                          ;

    // from WU fetch
    input  [`MGR_WU_ADDRESS_RANGE          ]    wuf__wum__addr                 ;
    input                                       wuf__wum__read                 ;

    //----------------------------------------------------------------------------------------------------
    // to decode
    
    output                                      wum__wud__valid                ;
    // WU Instruction delineators
    output [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl                ;  // instruction delineator
    output [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl                ;  // descriptor delineator

    // WU Instruction option fields
    output [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST ] ;  // 
    output [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST ] ;  // 


    //----------------------------------------------------------------------------------------------------
    // Registers and Wires

    reg                                      wum__wud__valid                ;
    // Delineators
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl                ;  // instruction delineator
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl                ;  // descriptor delineator

    // WU Instruction option fields
    reg  [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 


    wire                                      valid_e1                ;
    // Delineators
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    icntl_e1                ;  // instruction delineator
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    dcntl_e1                ;  // descriptor delineator

    // WU Instruction option fields
    reg  [`MGR_WU_OPT_TYPE_RANGE         ]    option_type_e1    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]    option_value_e1   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 

    reg  [`MGR_WU_ADDRESS_RANGE          ]    wuf__wum__addr_d1                ;
    reg                                       wuf__wum__read_d1                ;

    //----------------------------------------------------------------------------------------------------
    // Register inputs and outputs

    always @(posedge clk) 
      begin
        wuf__wum__read_d1             <=  wuf__wum__read   ;
        wuf__wum__addr_d1             <=  wuf__wum__addr   ;
      end

    always @(posedge clk) 
      begin
        wum__wud__valid             <=  valid_e1             ;

        wum__wud__icntl             <=  icntl_e1             ;
        wum__wud__dcntl             <=  dcntl_e1             ;
                                                           
        wum__wud__option_type  [0]  <=  option_type_e1  [0]  ;
        wum__wud__option_value [0]  <=  option_value_e1 [0]  ;
        wum__wud__option_type  [1]  <=  option_type_e1  [1]  ;
        wum__wud__option_value [1]  <=  option_value_e1 [1]  ;
      end

    assign valid_e1 = wuf__wum__read_d1 ;

    //----------------------------------------------------------------------------------------------------
    // Memories 

    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    icntl                                        [`MGR_STORAGE_DESC_MEMORY_RANGE ] ;  // instruction delineator
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    dcntl                                        [`MGR_STORAGE_DESC_MEMORY_RANGE ] ;  // descriptor delineator

    // WU Instruction option fields
    reg    [`MGR_WU_OPT_TYPE_RANGE         ]    option_type    [`MGR_WU_OPT_PER_INST_RANGE ] [`MGR_STORAGE_DESC_MEMORY_RANGE ] ;  // 
    reg    [`MGR_WU_OPT_VALUE_RANGE        ]    option_value   [`MGR_WU_OPT_PER_INST_RANGE ] [`MGR_STORAGE_DESC_MEMORY_RANGE ] ;  // 

    
    // The memory is updated using the testbench, so everytime we see an option, reload the memory
    always @(posedge valid) 
      begin

        $readmemh($sformatf("./inputFiles/mgr%0d_icntl.dat"        , sys__mgr__mgrId) , icntl                );
        $readmemh($sformatf("./inputFiles/mgr%0d_dcntl.dat"        , sys__mgr__mgrId) , dcntl                );
        $readmemh($sformatf("./inputFiles/mgr%0d_optionType0.dat"  , sys__mgr__mgrId) , option_type    [0]   );
        $readmemh($sformatf("./inputFiles/mgr%0d_optionValue0.dat" , sys__mgr__mgrId) , option_value   [0]   );
        $readmemh($sformatf("./inputFiles/mgr%0d_optionType1.dat"  , sys__mgr__mgrId) , option_type    [1]   );
        $readmemh($sformatf("./inputFiles/mgr%0d_optionValue1.dat" , sys__mgr__mgrId) , option_value   [1]   );

      end
    
    //----------------------------------------------------------------------------------------------------
    

    always @(*) 
      begin 
        #0.3   icntl_e1            =  (wuf__wum__read_d1) ? icntl              [wuf__wum__addr_d1] : 'd0 ;
        #0.3   dcntl_e1            =  (wuf__wum__read_d1) ? dcntl              [wuf__wum__addr_d1] : 'd0 ;
                                
        #0.3   option_type_e1  [0] =  (wuf__wum__read_d1) ? option_type    [0] [wuf__wum__addr_d1] : 'd0 ;
        #0.3   option_value_e1 [0] =  (wuf__wum__read_d1) ? option_value   [0] [wuf__wum__addr_d1] : 'd0 ;
        #0.3   option_type_e1  [1] =  (wuf__wum__read_d1) ? option_type    [1] [wuf__wum__addr_d1] : 'd0 ;
        #0.3   option_value_e1 [1] =  (wuf__wum__read_d1) ? option_value   [1] [wuf__wum__addr_d1] : 'd0 ;

      end

endmodule

