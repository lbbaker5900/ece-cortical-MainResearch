/*********************************************************************************************

    File name   : pe_array.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor PEE array.
                  It instantiates an array of PE's which include a :
                     - SIMD core
                     - DMA engine
                     - Inter-PE interface
                     - Streaming processor
                     - Streaming Processor Control
                     - Memory module 

*********************************************************************************************/
    


`include "common.vh"
`include "stack_interface.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"

`timescale 1ns/10ps

module pe_array (

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_stack_bus_downstream_ports.vh"

        clk              ,
        reset_poweron    
 
);

  //-------------------------------------------------------------------------------------------
  // Ports

  // General
  input                      clk            ;
  input                      reset_poweron  ;

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_stack_bus_downstream_port_declarations.vh"



  //-------------------------------------------------------------------------------------------
  // Regs and wires

  //-------------------------------------------------------------------------------------------
  // General system connectivity
  `include "sys_general_connections.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_stack_bus_downstream_instance_wires.vh"
  //
  //
 
  genvar gvi;
  generate
    for (gvi=0; gvi<`PE_ARRAY_NUM_OF_PE; gvi=gvi+1) 
    //for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: pe_inst

        // Stack Bus downstream Interface
        `include "pe_stack_bus_downstream_instance_wires.vh"

        // interface to PE core - FIXME
        wire        ready             ; // ready to start streaming
        wire        complete          ;

        // NoC Interface
        `include "pe_noc_instance_wires.vh"

        assign sys__pe__peId = gvi;

        pe pe (
   
                      // NoC Interface
                      `include "pe_noc_instance_ports.vh"
   
                      // Stack Bus downstream Interface
                      `include "pe_stack_bus_downstream_instance_ports.vh"
   
                      // Stack Bus upstream Interface
                      // FIXME : TBD
                      // `include "pe_stu_instance_ports.vh"
   
   
                     //.peId              ( peId              ),
                     .clk               ( clk               ),
                     .reset_poweron     ( reset_poweron     )
              );
      end
  endgenerate

  // Stack Bus downstream Interface
  `include "system_stack_bus_downstream_instance_connections.vh"

  // Inter PE NoC Connectivity      
  `include "pe_noc_interpe_connections.vh"
  `include "noc_interpe_port_Bitmask_assignments.vh"



endmodule  /*peArray*/

