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
`include "wu_memory.vh"


module wu_memory (  
            valid                       ,
            sys__mgr__mgrId             ,

            // from WU fetch
            wum__wuf__stall             ,
            wuf__wum__addr              ,
            wuf__wum__read              ,
                                  
            // to WU decode
            wum__wud__valid             ,
            wud__wum__ready             ,
            wum__wud__icntl             ,
            wum__wud__dcntl             ,
            wum__wud__op                ,
            wum__wud__option_type       ,
            wum__wud__option_value      ,

            //-------------------------------
            // General
            //
            clk                               ,
            reset_poweron    
            );

    //----------------------------------------------------------------------------------------------------
    // General
  
    input                                       clk                            ;
    input                                       reset_poweron                  ;

    input                                       valid                          ;
    input   [`MGR_MGR_ID_RANGE    ]             sys__mgr__mgrId                ;

    // from WU fetch
    input  [`MGR_WU_ADDRESS_RANGE          ]    wuf__wum__addr                 ;
    input                                       wuf__wum__read                 ;
    output                                      wum__wuf__stall                ;

    //----------------------------------------------------------------------------------------------------
    // to decode
    
    output                                      wum__wud__valid                ;
    input                                       wud__wum__ready                ;
    // WU Instruction delineators
    output [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl                ;  // instruction delineator
    output [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl                ;  // descriptor delineator
    output [`MGR_INST_TYPE_RANGE           ]    wum__wud__op                   ;  // NOP, OP, MR, MW

    // WU Instruction option fields
    output [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    output [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 


    //----------------------------------------------------------------------------------------------------
    // Registers and Wires

    reg                                      wum__wud__valid                ;
    // Delineators
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl               ;  // instruction delineator
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl               ;  // descriptor delineator
    reg  [`MGR_INST_TYPE_RANGE           ]    wum__wud__op                  ;  // NOP, OP, MR, MW

    // WU Instruction option fields
    reg  [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 

    reg                                       wum__wuf__stall                ;

    wire                                      valid_e1                ;
    // Delineators
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    icntl_e1                ;  // instruction delineator
    reg  [`MGR_INST_TYPE_RANGE           ]    op_e1                   ;  // 
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
        wuf__wum__read_d1           <=  wuf__wum__read   ;
        wuf__wum__addr_d1           <=  wuf__wum__addr   ;
      end

    always @(posedge clk) 
      begin
        wum__wuf__stall        <= ( reset_poweron   ) ? 'd1  :  ~wud__wum__ready   ;  // stall asserted out of reset
      end

    always @(posedge clk) 
      begin
        wum__wud__valid             <=  valid_e1         ;

        wum__wud__icntl             <=  icntl_e1         ;
        wum__wud__dcntl             <=  dcntl_e1         ;
        wum__wud__op                <=  op_e1            ;
                                                           
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_out
            wum__wud__option_type  [opt]  <=  option_type_e1  [opt]  ;
            wum__wud__option_value [opt]  <=  option_value_e1 [opt]  ;
          end
        /*
        wum__wud__option_type  [0]  <=  option_type_e1  [0]  ;
        wum__wud__option_value [0]  <=  option_value_e1 [0]  ;
        wum__wud__option_type  [1]  <=  option_type_e1  [1]  ;
        wum__wud__option_value [1]  <=  option_value_e1 [1]  ;
        */
      end

    wire    memory_read                      ;
    assign  memory_read = wuf__wum__read_d1  ;

    reg     memory_valid                     ;
    always @(posedge clk) 
      begin
        memory_valid           <=  memory_read   ;
      end
    assign valid_e1 = memory_valid ;

    //----------------------------------------------------------------------------------------------------
    // Memories 

  genvar gvi;
  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: instruction_mem

        generic_1port_memory #(.GENERIC_MEM_DEPTH          (`MGR_INSTRUCTION_MEMORY_DEPTH              ),
                               .GENERIC_MEM_REGISTERED_OUT (0                                          ),
                               .GENERIC_MEM_DATA_WIDTH     (`MGR_INSTRUCTION_MEMORY_AGGREGATE_MEM_WIDTH)
                        ) gmemory ( 
                        
                        //---------------------------------------------------------------
                        // Initialize
                        //
                        `ifndef SYNTHESIS
                           .memFile ($sformatf("./inputFiles/manager_%0d_layer1_instruction_readmem.dat", sys__mgr__mgrId)),
                        `endif

                        //
                        //---------------------------------------------------------------
                        // Port 
                        .portA_address       ( wuf__wum__addr_d1),
                        .portA_write_data    ( {`MGR_INSTRUCTION_MEMORY_AGGREGATE_MEM_WIDTH {1'b0}} ),
                        .portA_read_data     ( {option_value_e1[2], option_type_e1[2], option_value_e1[1], option_type_e1[1], option_value_e1[0], option_type_e1[0], op_e1, dcntl_e1, icntl_e1} ),
                        .portA_enable        ( wuf__wum__read_d1                ), 
                        .portA_write         ( 1'b0                             ),
                        
                        //---------------------------------------------------------------
                        // General
                        .reset_poweron       ( reset_poweron             ),
                        .clk                 ( clk                       )
                        ) ;
  // Note: parameters must be fixed, so have to load directly
  //defparam gmemory.GENERIC_MEM_INIT_FILE   =    $sformatf("./inputFiles/manager_%0d_layer1_storageDescriptor_readmem.dat", sys__mgr__mgrId);

        `ifndef SYNTHESIS
/*
        string entry  ;
        string memFile  ;
        int memFileDesc ;
        bit [`MGR_INSTRUCTION_ADDRESS_RANGE              ]  memory_address ;
        bit [`MGR_INSTRUCTION_MEMORY_AGGREGATE_MEM_RANGE ]  memory_data    ;

        initial
          begin
            @(negedge reset_poweron);
            //$readmemh($sformatf("./inputFiles/manager_%0d_layer1_instruction_readmem.dat", sys__mgr__mgrId), gmemory.mem);
           
            memFile = $sformatf("./inputFiles/manager_%0d_layer1_instruction_readmem.dat", sys__mgr__mgrId);
            memFileDesc = $fopen (memFile, "r");
            if (memFileDesc == 0)
              begin
                $display("ERROR:LEE:readmem file error : %s ", memFile);
                $finish;
              end
            while (!$feof(memFileDesc)) 
              begin 
                void'($fgets(entry, memFileDesc)); 
                void'($sscanf(entry, "@%x %x", memory_address, memory_data));
                //$display("ERROR:LEE:readmem file contents : %s  : Addr:%h, Data:%h", memFile, memory_address, memory_data);
                gmemory.mem[memory_address] = memory_data ;
              end
           $fclose(memFileDesc);

          end
*/

        `endif
      end
  endgenerate

/*
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    icntl                                        [`MGR_INSTRUCTION_MEMORY_RANGE ] ;  // instruction delineator
    reg    [`MGR_INST_TYPE_RANGE           ]    op                                           [`MGR_INSTRUCTION_MEMORY_RANGE ] ;  // 
    // WU Instruction option fields
    reg    [`MGR_WU_OPT_TYPE_RANGE         ]    option_type    [`MGR_WU_OPT_PER_INST_RANGE ] [`MGR_INSTRUCTION_MEMORY_RANGE ] ;  // 
    reg    [`MGR_WU_OPT_VALUE_RANGE        ]    option_value   [`MGR_WU_OPT_PER_INST_RANGE ] [`MGR_INSTRUCTION_MEMORY_RANGE ] ;  // 
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    dcntl                                        [`MGR_INSTRUCTION_MEMORY_RANGE ] ;  // descriptor delineator

    
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
        #0.3   icntl_e1            =  (memory_read) ? icntl [wuf__wum__addr_d1] : 'd0 ;
        #0.3   op_e1               =  (memory_read) ? op    [wuf__wum__addr_d1] : 'd0 ;
                                
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_mem
            #0.3   option_type_e1  [opt] =  (memory_read) ? option_type    [opt] [wuf__wum__addr_d1] : 'd0 ;
            #0.3   option_value_e1 [opt] =  (memory_read) ? option_value   [opt] [wuf__wum__addr_d1] : 'd0 ;
          end
        #0.3   dcntl_e1            =  (memory_read) ? dcntl              [wuf__wum__addr_d1] : 'd0 ;

      end
*/

endmodule

