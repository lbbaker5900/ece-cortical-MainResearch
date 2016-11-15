


`include "common.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

`timescale 1ns/10ps

module test_fixture;

    // set parameters for signal width and clock period
    // 32-bit
    parameter sig_width = 23;
    parameter exp_width = 8;
    // 64-bit
    //parameter sig_width = 52;
    //parameter exp_width = 11;
    parameter ieee_compliance = 0;
    
    parameter CLKPERIOD = 4;
    
    reg clk=0;
    reg reset_poweron=1;
    reg pe_sim_finished = 0;

    reg [sig_width+exp_width : 0] inst_a;
    reg [sig_width+exp_width : 0] inst_b;
    reg [2 : 0] inst_rnd;
    reg inst_op;
    wire [sig_width+exp_width : 0] z_inst;
    wire [7 : 0] status_inst;
    
    integer i, file, r;
    integer loop ;
    
    //real type could store 64bits float point number
    //shortreal type could store 32bits float point number
    //real memory [0:7], result;
    shortreal memory [0:7], result;

    initial
    begin

        file=$fopen("data.dat","r");
        i=0;
        while(!$feof(file))
          begin
              r=$fscanf(file, "%f", memory[i]);
              i=i+1;
          end
        $fclose(file);
 
        $display("Memory[%d]=%f", 0, memory[0]);
        $display("Memory[%d]=%f", 1, memory[1]);
        #(CLKPERIOD+2)
        //System function $realtobits translate real type into 64 bits binary according to IEEE 754 Standard
        //System function $shortrealtobits translate real type into 32 bits binary according to IEEE 754 Standard
        inst_a=$shortrealtobits(memory[0]);
        inst_b=$shortrealtobits(memory[1]);
        inst_op=1'b0;
        inst_rnd=3'b000;
 
        #(CLKPERIOD/2)
        //System function $bitstoreal translate 64 bits binary into float point number according to IEEE 754 Standard
        //System function $bitstoshortreal translate 64 bits binary into float point number according to IEEE 754 Standard
        result=$bitstoshortreal(z_inst);
        $monitor($time, "result = %f", result);
 
        #(CLKPERIOD/2)
            inst_op=1'b1;
 
        #(CLKPERIOD/2)
            result=$bitstoshortreal(z_inst);
            //$display("result=%f", result);
 
        wait(pe_sim_finished)
        #(CLKPERIOD*3)    $finish;

    end
    
    always #(CLKPERIOD/2) clk = ~clk;


  //-------------------------------------------------------------------------------------------
  // General system connectivity
  `include "test_stack_downstream_wires.vh"


        pe_array pe_array_inst (
   
                      // Downstream Stack bus Interface
                      `include "system_stack_bus_downstream_instance_ports.vh"
   
                     .clk               ( clk             ),
                     .reset_poweron     ( reset_poweron     )
              );


  //-------------------------------------------------------------------------------------------------
  // Exec lane Register(s)
  //

  `include "test_variables.vh"
/*
  reg [31:0] strm0 [0:4095];
  reg [31:0] strm1 [0:4095];
  reg [31:0] strm0_tmp ;
  reg [31:0] strm1_tmp ;
*/

  int numOfTypes;
  int numOfExtWords;
  int numOfResidueTypes;
  int maxType;


`ifdef BSUM
  `include "test_bsum.v"
`elsif FP_MAC
  `include "test_std_fpmac_to_mem.v"
`elsif FP_MAX
  `include "test_fp_max.v"
`elsif MEM2MEM
  `include "test_mem_to_mem.v"
`elsif MEM2NOC
  `include "test_mem_to_noc.v"
`elsif NOC2MEM
  `include "test_noc_to_mem.v"
`elsif SIMD_NOC2MEM
  `include "test_simd_test_noc_to_mem.v"
`elsif SIMD_LAYER0_HINPUT_CREATION
  `include "test_simd_layer0_Hinput_dma.v"
`endif

endmodule  /*test_fixture*/

