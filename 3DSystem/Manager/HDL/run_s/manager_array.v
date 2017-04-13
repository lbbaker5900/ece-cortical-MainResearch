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
`include "mgr_noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "manager.vh"
`include "manager_array.vh"
`include "noc_interMgr_port_Bitmasks.vh"

`timescale 1ns/10ps

module manager_array (

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_manager_sys_general_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - OOB Downstream
        `include "system_manager_stack_bus_downstream_oob_ports.vh"

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
  // Stack Bus - General
  `include "system_manager_sys_general_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  `include "system_manager_stack_bus_downstream_oob_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_manager_stack_bus_downstream_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_manager_stack_bus_upstream_port_declarations.vh"


  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Regs and wires

  //-------------------------------------------------------------------------------------------
  // NoC
  //`include "manager_noc_connection_wires.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  `include "system_manager_sys_general_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  `include "system_manager_stack_bus_downstream_oob_instance_wires.vh"
  
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
        // General control and status 
        wire [`PE_PE_ID_RANGE                 ]     sys__mgr__mgrId               ; 
        wire                                        mgr__sys__allSynchronized     ; 
        wire                                        sys__mgr__thisSynchronized    ; 
        wire                                        sys__mgr__ready               ; 
        wire                                        sys__mgr__complete            ; 

        //-------------------------------------------------------------------------------------------------
        // Stack Bus OOB downstream Interface
        //  - OOB carries PE configuration  
        wire[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl            ; 
        wire                                        mgr__std__oob_valid           ; 
        wire                                        std__mgr__oob_ready           ; 
        wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type            ; 
        wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data            ; 

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
                // Stack Bus OOB downstream Interface
                //  - OOB carries PE configuration  
                .mgr__std__oob_cntl     ( mgr__std__oob_cntl     ), 
                .mgr__std__oob_valid    ( mgr__std__oob_valid    ), 
                .std__mgr__oob_ready    ( std__mgr__oob_ready    ), 
                .mgr__std__oob_type     ( mgr__std__oob_type     ), 
                .mgr__std__oob_data     ( mgr__std__oob_data     ), 

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
                .reset_poweron                ( reset_poweron               )
              );
      end
  endgenerate

  //-------------------------------------------------------------------------------------------
  // General system connectivity
  `include "manager_sys_general_connections.vh"
  
  //-------------------------------------------------------------------------------------------------
  // Stack Bus OOB Downstream connections
  `include "system_manager_stack_bus_downstream_oob_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus Downstream connections
  `include "system_manager_stack_bus_downstream_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus Upstream connections
  `include "system_manager_stack_bus_upstream_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Inter Manager NoC Connectivity      
  `include "noc_interMgr_connections.vh"
  `include "noc_interMgr_port_Bitmask_assignments.vh"



endmodule  /*managerArray*/

