/*********************************************************************************************

    File name   : manager_array.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor Manager array.
                  It instantiates an array of Managers which include a :

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

module manager_array (

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_manager_stack_bus_downstream_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        `include "system_manager_stack_bus_upstream_ports.vh"

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
  // Stack Bus - Downstream
  `include "system_manager_stack_bus_downstream_port_declarations.vh"


  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_manager_stack_bus_upstream_port_declarations.vh"


  //-------------------------------------------------------------------------------------------
  // Regs and wires

  //-------------------------------------------------------------------------------------------
  // NoC
  `include "manager_noc_connection_wires.vh"

  //-------------------------------------------------------------------------------------------
  // General system connectivity
  `include "manager_sys_general_connections.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_manager_stack_bus_downstream_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_manager_stack_bus_upstream_instance_wires.vh"
  
  
 
  genvar gvi;
  generate
    for (gvi=0; gvi<`MGR_ARRAY_NUM_OF_MGR; gvi=gvi+1) 
      begin: mgr_inst

        //-------------------------------------------------------------------------------------------------
        // Stack Bus downstream Interface
        `include "manager_stack_bus_downstream_instance_wires.vh"

        //-------------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        //
        wire                                           stu__mgr__valid       ;
        wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl        ;
        wire                                           mgr__stu__ready       ;
        wire    [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type        ;  // Control or Data, Vector or scalar
        wire    [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data        ;
        wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data    ;
 
        //-------------------------------------------------------------------------------------------------
        // NoC Interface
        `include "manager_noc_instance_wires.vh"

        assign sys__mgr__mgrId = gvi;

        manager manager (
   
                //-------------------------------
                // NoC Interface
                `include "manager_noc_instance_ports.vh"
   
                //-------------------------------
                // Stack Bus downstream Interface
                `include "manager_stack_bus_downstream_instance_ports.vh"
   
                //-------------------------------
                // Stack Bus - Upstream
                .stu__mgr__valid        ( stu__mgr__valid        ),
                .stu__mgr__cntl         ( stu__mgr__cntl         ),
                .mgr__stu__ready        ( mgr__stu__ready        ),
                .stu__mgr__type         ( stu__mgr__type         ),  // Control or Data, Vector or scalar
                .stu__mgr__data         ( stu__mgr__data         ),
                .stu__mgr__oob_data     ( stu__mgr__oob_data     ),
 
                //-------------------------------
                // General control and status  
                .sys__mgr__mgrId              ( sys__mgr__mgrId             ), 
                .mgr__sys__allSynchronized    ( mgr__sys__allSynchronized   ), 
                .sys__mgr__thisSynchronized   ( sys__mgr__thisSynchronized  ), 
                .sys__mgr__ready              ( sys__mgr__ready             ), 
                .sys__mgr__complete           ( sys__mgr__complete          ), 
                //`include "manager_sys_general_instance_ports.vh"
                //
                .clk                          ( clk                         ),
                .reset_poweron                ( reset_powero          n     )
              );
      end
  endgenerate

  //-------------------------------------------------------------------------------------------------
  // Stack Bus Downstream Interface
  `include "system_manager_stack_bus_downstream_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus Upstream Interface
  `include "system_manager_stack_bus_upstream_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Inter Manager NoC Connectivity      
  `include "noc_interMgr_connections.vh"
  `include "noc_interMgr_port_Bitmask_assignments.vh"



endmodule  /*managerArray*/

