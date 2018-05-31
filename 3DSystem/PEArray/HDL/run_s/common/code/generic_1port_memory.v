/*********************************************************************************************

    File name   : generic_1port_memory.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : May 2017
    email       : lbbaker@ncsu.edu

    Description : Generic Memory (from cortical project define-based fifo)

                  Memory can be registered (piped) or not registerd (non-piped)
  
                          ______        ______        ______        ______        ______        ______
                    _____|      |______|      |______|      |______|      |______|      |______|      
                                       ^             ^             ^
                                     sample        sample        sample
                                     enable     non-piped data  piped data         
                                 _____________  
            MEA     ____________|             |_______________________________________________________
                                       ^
                                    enable
                                 _____________
           Address  ------------|_____________|-------------------------------------------------------
                                        
                                          ___________
  Non-piped Data    -------------------<<|___________|>>---------------------------
                                       ^       
                                  non-pipe data 
                                     output
                                                        ___________
      Piped Data    ---------------------------------<<|___________|>---------------------------
                                                     ^            
                                                 pipe data 
                                                  output

*********************************************************************************************/
    
// Usage: generic_1port_memory #(.GENERIC_MEM_DEPTH          ( 8), 
//                               .GENERIC_MEM_REGISTERED_OUT ( 1),
//                               .GENERIC_MEM_DATA_WIDTH     (32)
//                              ) name_of_memory( ..... );
//        `undef GENERIC_MEM_REGISTERED_OUT

`include "common.vh"

`timescale 1ns/10ps


module generic_1port_memory  
                            #(parameter GENERIC_MEM_DEPTH           = 1024   ,
                              parameter GENERIC_MEM_REGISTERED_OUT  = 0      ,
                              parameter GENERIC_MEM_DATA_WIDTH      = 32     ,
                              parameter GENERIC_MEM_INIT_FILE       = ""     )
                         (

                          //---------------------------------------------------------------
                          // Initialize
                          // - cant pass as a parameter
                          `ifndef SYNTHESIS
                            memFile,
                          `endif                                                

                          //---------------------------------------------------------------
                          // Port A 
                          portA_address        ,
                          portA_write_data     ,
                          portA_read_data      ,
                          portA_enable         , 
                          portA_write          , // ~read
                          
                          //---------------------------------------------------------------
                          // General
                          reset_poweron        ,
                          clk            
                          );

  //--------------------------------------------------------
  // Forces synthesis not to elaborate during first read
  // synopsys template

  //--------------------------------------------------------
  // Define whether the actual memory model is used
 
  `ifdef TB_USES_ACTUAL_MEMORIES
    `define GENERIC_MEM_USES_COMPILER_MEMORY_MODEL
  `endif
  `ifdef SYNTHESIS
    `define GENERIC_MEM_USES_COMPILER_MEMORY_MODEL
  `endif

  // 
  localparam GENERIC_MEM_ADDR_WIDTH       = $clog2(GENERIC_MEM_DEPTH) ;
  localparam GENERIC_NUM_OF_PORTS         = 1 ;  // for generic_memories.vh

  `ifndef SYNTHESIS
    input string memFile;
  `endif                                                

  input   wire                       clk            ;
  input   wire                       reset_poweron  ;  // used only to intialize memory

  input   wire  [GENERIC_MEM_ADDR_WIDTH-1 :0  ]     portA_address     ;
  input   wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portA_write_data  ;
  output  wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portA_read_data   ;
  input   wire                                      portA_enable      ; 
  input   wire                                      portA_write       ; 


  `ifdef GENERIC_MEM_USES_COMPILER_MEMORY_MODEL
    wire   [GENERIC_MEM_DATA_WIDTH-1 :0  ]    int_portA_read_data ;
  `else
    reg    [GENERIC_MEM_DATA_WIDTH-1 :0  ]    reg_portA_read_data ;
    if (GENERIC_MEM_REGISTERED_OUT == 1)
      begin : mem_reg
        reg    [GENERIC_MEM_DATA_WIDTH-1 :0  ]    mem_reg_portA_read_data ;
      end
  `endif

  //--------------------------------------------------------
  // Regs/Wires
  //
  //
  wire portA_read = ~portA_write  ;

  `ifdef GENERIC_MEM_USES_COMPILER_MEMORY_MODEL
    // this file has all memories selected using parameters
    //
    // synthesis doesnt know which parameter might be used as both 1 and 2-port
    // include the generic_memories file
    wire  [GENERIC_MEM_ADDR_WIDTH-1 :0  ]     portB_address     ;
    wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portB_write_data  ;
    wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portB_read_data   ;
    wire                                      portB_enable      ; 
    wire                                      portB_write       ; 

    `include "generic_memories.vh"

  `else

    // Associative memory
    bit  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     mem     [bit[GENERIC_MEM_ADDR_WIDTH-1:0]] = '{default: 'X};

    string entry  ;
    int fileDesc ;
    bit [GENERIC_MEM_ADDR_WIDTH-1 :0 ]  memory_address ;
    bit [GENERIC_MEM_DATA_WIDTH-1 :0 ]  memory_data    ;

    // Need to accomodate loading during simulation
    // e.g. pe_cntl.v creates event
    event loadMemory ;
    always
      begin
        @(loadMemory)
          loadInitFile;
      end

    // load at trailing edge of reset
    initial
      begin
        @(negedge reset_poweron);
        -> loadMemory ;
      end

    task  loadInitFile;
      if (memFile != "")
        begin
          fileDesc = $fopen (memFile, "r");
          if (fileDesc == 0)
            begin
              $display("ERROR:generic_1port_memory:LEE:readmem file error : %s ", memFile);
              $finish;
            end
          `ifdef GENERIC_MEM_USES_COMPILER_MEMORY_MODEL
            //dw_mem.genblk1.mem1p.loadmem(memFile);
          `else
          while (!$feof(fileDesc)) 
            begin 
              void'($fgets(entry, fileDesc)); 
              void'($sscanf(entry, "@%x %x", memory_address, memory_data));
              //$display("ERROR:LEE:readmem file contents : %s  : Addr:%h, Data:%h", memFile, memory_address, memory_data);
              mem[memory_address] = memory_data ;
            end
          `endif
         $fclose(fileDesc);
        end
     endtask



  `endif

  `ifndef GENERIC_MEM_USES_COMPILER_MEMORY_MODEL
    //--------------------------------------------------------
    // Registered/UnRegistered outputs
    //
    if (GENERIC_MEM_REGISTERED_OUT == 0)  // Not registered
     begin
      always @(posedge clk)
        begin
          reg_portA_read_data   <= ( portA_enable  ) ? mem [portA_address] : 
                                                       reg_portA_read_data ;
        end
     end
    else  // registered
     begin
      always @(posedge clk)
        begin
          mem_reg.mem_reg_portA_read_data <= ( portA_enable ) ? mem [portA_address] : 
                                                                mem_reg.mem_reg_portA_read_data ;
          reg_portA_read_data    <= mem_reg.mem_reg_portA_read_data ;
        end
     end

    always @(posedge clk)
      begin
        if (portA_enable && portA_write)
          //mem [portA_address] <= portA_write_data ;
          mem [portA_address] = portA_write_data ;
      end
  `endif

  `ifndef GENERIC_MEM_USES_COMPILER_MEMORY_MODEL
    assign portA_read_data = reg_portA_read_data  ;
  `else
    assign portA_read_data = int_portA_read_data  ;
  `endif
  //--------------------------------------------------------


endmodule


