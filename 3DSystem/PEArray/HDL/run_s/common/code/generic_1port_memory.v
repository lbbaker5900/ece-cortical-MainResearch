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


module generic_1port_memory #(parameter GENERIC_MEM_DEPTH           = 1024   ,
                              parameter GENERIC_MEM_REGISTERED_OUT  = 0      ,
                              parameter GENERIC_MEM_DATA_WIDTH      = 32     ,
                              parameter GENERIC_MEM_INIT_FILE       = ""     )
                         (
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

  // 
  localparam GENERIC_MEM_ADDR_WIDTH       = $clog2(GENERIC_MEM_DEPTH) ;
  localparam GENERIC_NUM_OF_PORTS         = 1 ;  // for generic_memories.vh

  input   wire                       clk            ;
  input   wire                       reset_poweron  ;  // used only to intialize memory

  input   wire  [GENERIC_MEM_ADDR_WIDTH-1 :0  ]     portA_address     ;
  input   wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portA_write_data  ;
  output  wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portA_read_data   ;
  input   wire                                      portA_enable      ; 
  input   wire                                      portA_write       ; 


  `ifndef SYNTHESIS
    reg    [GENERIC_MEM_DATA_WIDTH-1 :0  ]    reg_portA_read_data ;
  `else
    wire   [GENERIC_MEM_DATA_WIDTH-1 :0  ]    int_portA_read_data ;
  `endif

  //--------------------------------------------------------
  // Regs/Wires
  //
  //
  wire portA_read = ~portA_write  ;

  `ifdef SYNTHESIS
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
// FIXME: why did I have to do this?????  why didnt the if PARAMETER work?
        reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     mem     [1023 :0 ] ;
    // Not synthesis
    if (GENERIC_MEM_ADDR_WIDTH >= 10)
      begin
        reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     mem     [1023 :0 ] ;
      end
    else
      begin
        reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     mem     [GENERIC_MEM_DEPTH-1 :0 ] ;
      end


    initial
      begin
        @(negedge reset_poweron)
          if (GENERIC_MEM_INIT_FILE != "")
            begin
              $readmemh( GENERIC_MEM_INIT_FILE, mem);
            end
      end
  `endif

  `ifndef SYNTHESIS
    //--------------------------------------------------------
    // Registered outputs ??
    //
    reg   portA_enable_d1      ; 
    always @(posedge clk)
      begin
        portA_enable_d1  <=   portA_enable  ; 
      end

    if (GENERIC_MEM_REGISTERED_OUT == 0)
     begin
      always @(posedge clk)
        begin
          reg_portA_read_data   <= ( portA_enable  ) ? mem [portA_address] : 
                                                       reg_portA_read_data ;
        end
     end
    else  // Not registers
     begin
      always @(posedge clk)
        begin
          reg_portA_read_data   <= ( portA_enable_d1 ) ? mem [portA_address] : 
                                                         reg_portA_read_data ;
        end
      /*
      always @(*)
        begin
          reg_portA_read_data = mem [portA_address] ;
          reg_portB_read_data = mem [portB_address] ;
        end
      */
     end

    always @(posedge clk)
      begin
        if (portA_enable && portA_write)
          mem [portA_address] <= portA_write_data ;
      end
  `endif

  `ifndef SYNTHESIS
    assign portA_read_data = reg_portA_read_data  ;
  `else
    assign portA_read_data = int_portA_read_data  ;
  `endif
  //--------------------------------------------------------


endmodule


