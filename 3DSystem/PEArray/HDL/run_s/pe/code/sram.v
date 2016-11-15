
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "streamingOps_cntl.vh"
`include "mem_acc_cont.vh"

`timescale 1ns/10ps

module sram (clock, WE, WriteAddress, ReadAddress, WriteBus, ReadBus);

input  clock;
input  WE; 
input  [`MEM_ACC_CONT_BANK_ADDRESS_RANGE ] WriteAddress  ;
input  [`MEM_ACC_CONT_BANK_ADDRESS_RANGE ] ReadAddress   ;
input  [`MEM_ACC_CONT_BANK_DATA_RANGE    ] WriteBus      ;
output [`MEM_ACC_CONT_BANK_DATA_RANGE    ] ReadBus       ;

reg [`MEM_ACC_CONT_BANK_DATA_RANGE    ] Register [0:4095]; 
reg [`MEM_ACC_CONT_BANK_DATA_RANGE    ] ReadBus;

initial 
  begin
    $readmemh("../../SIMULATION/run_s/ram_contents.txt", Register);
  end

// provide one write enable line per register
reg [4095:0] WElines;
integer i;

// Write '1' into write enable line for selected register
// Note the 0.3 ns delay - THIS IS THE INPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*)
#0.3 WElines = (WE << WriteAddress);

always@(posedge clock)
  begin
    for (i=0; i<=4095; i=i+1)
      if (WElines[i]) Register[i] <= WriteBus;
  end

// Note the 0.3 ns delay - this is the OUTPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*) 
  begin 
    #0.3 ReadBus  =  Register[ReadAddress];
  end
endmodule
