/*********************************************************************************************

    File name   : system.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor System.
                  It instantiates an array of Managers, an array of PE's and a stack bus module.

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
`include "manager.vh"
`include "manager_array.vh"
`include "noc_interMgr_port_Bitmasks.vh"

`timescale 1ns/10ps

module system (

        //-------------------------------------------------------------------------------------------
        // General
        clk              ,
        reset_poweron    
 
);

  //-------------------------------------------------------------------------------------------
  // Ports

  // General
  input                      clk            ;
  input                      reset_poweron  ;



  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Regs and wires

  //-------------------------------------------------------------------------------------------
  // NoC
  //`include "manager_noc_connection_wires.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  `include "system_manager_sys_general_instance_wires.vh"
  `include "system_pe_sys_general_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_manager_stack_bus_downstream_instance_wires.vh"
  `include "system_pe_stack_bus_downstream_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_manager_stack_bus_upstream_instance_wires.vh"
  `include "system_pe_stack_bus_upstream_instance_wires.vh"
  
  
  //-------------------------------------------------------------------------------------------
  // Array of Managers

  manager_array manager_array (
  
        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_manager_array_sys_general_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_manager_array_stack_bus_downstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        `include "system_manager_array_stack_bus_upstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // General
        .clk             ( clk           ) ,
        .reset_poweron   ( reset_poweron )
        );
 

  //-------------------------------------------------------------------------------------------
  // Array of Managers

  pe_array pe_array (

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_pe_array_sys_general_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_pe_array_stack_bus_downstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        `include "system_pe_array_stack_bus_upstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // General
        .clk             ( clk           ) ,
        .reset_poweron   ( reset_poweron )
 
);

  //-------------------------------------------------------------------------------------------
  // Stack Interface

  stack_bus stack_bus (

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_manager_array_sys_general_instance_ports.vh"
        `include "system_pe_array_sys_general_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_manager_array_stack_bus_downstream_instance_ports.vh"
        `include "system_pe_array_stack_bus_downstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        `include "system_manager_array_stack_bus_upstream_instance_ports.vh"
        `include "system_pe_array_stack_bus_upstream_instance_ports.vh"

        //-------------------------------------------------------------------------------------------
        // General
        .clk             ( clk           ) ,
        .reset_poweron   ( reset_poweron )
 
        );

endmodule 

