/*********************************************************************************************

    File name   : stack_bus.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module is the stack bus connectivity between the LBB Cortical Processor Manager array
                  and the LBB Cortical processr PE array.
                  It is connectivity only.

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

module stack_bus (

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_manager_sys_general_ports.vh"
        `include "system_pe_sys_general_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_manager_stack_bus_downstream_oob_ports.vh"
        `include "system_pe_stack_bus_downstream_oob_ports.vh"

        `include "system_manager_stack_bus_downstream_ports.vh"
        `include "system_pe_stack_bus_downstream_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        `include "system_manager_stack_bus_upstream_ports.vh"
        `include "system_pe_stack_bus_upstream_ports.vh"

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
  // Stack Bus - General
  `include "system_sys_general_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  `include "system_stack_bus_downstream_oob_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  `include "system_stack_bus_downstream_oob_port_declarations.vh"


  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_stack_bus_downstream_port_declarations.vh"


  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_stack_bus_upstream_port_declarations.vh"



  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Regs and wires


  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  `include "system_manager_sys_general_instance_wires.vh"
  `include "system_pe_sys_general_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_manager_stack_bus_downstream_oob_instance_wires.vh"
  `include "system_pe_stack_bus_downstream_oob_instance_wires.vh"

  `include "system_manager_stack_bus_downstream_instance_wires.vh"
  `include "system_pe_stack_bus_downstream_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_manager_stack_bus_upstream_instance_wires.vh"
  `include "system_pe_stack_bus_upstream_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------



  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Connections

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  `include "system_general_instance_connections.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  `include "system_stack_bus_downstream_oob_instance_connections.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_stack_bus_downstream_instance_connections.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_stack_bus_upstream_instance_connections.vh"
  

  //-------------------------------------------------------------------------------------------




endmodule  

