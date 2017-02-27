/*********************************************************************************************

    File name   : stack_interface.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    email       : lbbaker@ncsu.edu

    Description : This module is the main interface to the up and down stack bus.
                  - Downstream
                      Decodes downstream packets and directs control packets to local controller and data packets to thestreaming Op module
                  - Upstream
                      FIXME

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "stack_interface.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"

module stack_interface (

            //-------------------------------
            // Stack Bus - Downstream
            //
            `include "pe_stack_bus_downstream_ports.vh"

            //-------------------------------
            // Stack Bus to PE control
            //
            `include "stack_interface_to_pe_cntl_downstream_ports.vh"

            //-------------------------------
            // Stack Bus to Streaming Ops
            //
            `include "stack_interface_to_stOp_downstream_ports.vh"

            clk              ,
            reset_poweron    
 
    );

  input                      clk            ;
  input                      reset_poweron  ;



  //-------------------------------------------------------------------------------------------------
  // Ports
  
  //---------------------------------------
  // interface to Stack Bus - downstream
  //
  `include "pe_stack_bus_downstream_port_declarations.vh"

  //---------------------------------------
  // interface to streaming Ops - downstream
  //
  `include "stack_interface_to_stOp_downstream_port_declarations.vh"

  //---------------------------------------
  // interface to PE control - downstream
  //
  `include "stack_interface_to_pe_cntl_downstream_port_declarations.vh"


  //-------------------------------------------------------------------------------------------------
  // Regs and Wires
  
  //---------------------------------------
  // interface to Stack Bus - downstream
  //
  `include "pe_stack_bus_downstream_instance_wires.vh"

  //---------------------------------------
  // interface to streaming Ops - downstream
  //
  `include "stack_interface_to_stOp_downstream_instance_wires.vh"

  //---------------------------------------
  // interface to PE control - downstream
  //
  `include "stack_interface_to_pe_cntl_downstream_instance_wires.vh"


  //-------------------------------------------------------------------------------------------------
  // Assignments
  
  `include "stack_interface_to_stOp_downstream_connections.vh"

  // OOB carries PE configuration
  assign  sti__cntl__oob_cntl      =  std__pe__oob_cntl    ;
  assign  sti__cntl__oob_valid     =  std__pe__oob_valid   ;
  assign  pe__std__oob_ready       =  cntl__sti__oob_ready ;
  assign  sti__cntl__oob_type      =  std__pe__oob_type    ;
  assign  sti__cntl__oob_data      =  std__pe__oob_data    ;


  //-------------------------------------------------------------------------------------------------

endmodule

