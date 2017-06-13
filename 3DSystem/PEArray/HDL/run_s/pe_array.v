/*********************************************************************************************

    File name   : pe_array.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor PE array.
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
//`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
//`include "noc_interpe_port_Bitmasks.vh"

`timescale 1ns/10ps

module pe_array (

        //-------------------------------------------------------------------------------------------
        // Stack Bus - General
        `include "system_pe_sys_general_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - OOB Downstream
        `include "system_pe_stack_bus_downstream_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        `include "system_pe_stack_bus_downstream_oob_ports.vh"

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
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
  `include "system_pe_sys_general_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  `include "system_pe_stack_bus_downstream_oob_port_declarations.vh"

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_pe_stack_bus_downstream_port_declarations.vh"


  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_pe_stack_bus_upstream_port_declarations.vh"


  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Regs and wires

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  `include "system_pe_sys_general_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  `include "system_pe_stack_bus_downstream_oob_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  `include "system_pe_stack_bus_downstream_instance_wires.vh"
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  `include "system_pe_stack_bus_upstream_instance_wires.vh"
  
  
 
  genvar gvi;
  generate
    for (gvi=0; gvi<`PE_ARRAY_NUM_OF_PE; gvi=gvi+1) 
    //for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: pe_inst

        //-------------------------------------------------------------------------------------------------
        // General control and status 
        wire [`PE_PE_ID_RANGE                 ]     sys__pe__peId                ; 
        wire                                        sys__pe__allSynchronized     ; 
        wire                                        pe__sys__thisSynchronized    ; 
        wire                                        pe__sys__ready               ; 
        wire                                        pe__sys__complete            ; 

        //-------------------------------------------------------------------------------------------------
        // Stack Bus OOB downstream Interface
        `include "pe_stack_bus_downstream_oob_instance_wires.vh"

        //-------------------------------------------------------------------------------------------------
        // Stack Bus downstream Interface
        `include "pe_stack_bus_downstream_instance_wires.vh"

        //-------------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        //
        wire                                           pe__stu__valid       ;
        wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl        ;
        wire                                           stu__pe__ready       ;
        wire    [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type        ;  // Control or Data, Vector or scalar
        wire    [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data        ;
        wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data    ;
 
        //-------------------------------------------------------------------------------------------------
        // interface to PE core - FIXME
        wire        ready             ; // ready to start streaming
        wire        complete          ;

        //-------------------------------------------------------------------------------------------------
        // NoC Interface
        //`include "pe_noc_instance_wires.vh"

        assign sys__pe__peId = gvi;

        pe pe (
   
                //-------------------------------
                // NoC Interface
                //`include "pe_noc_instance_ports.vh"
   
                //-------------------------------
                // Stack Bus General control and status     
                .sys__pe__peId                      ( sys__pe__peId                   ),
                .sys__pe__allSynchronized           ( sys__pe__allSynchronized        ),
                .pe__sys__thisSynchronized          ( pe__sys__thisSynchronized       ),
                .pe__sys__ready                     ( pe__sys__ready                  ),
                .pe__sys__complete                  ( pe__sys__complete               ),
                //`include "pe_sys_general_instance_ports.vh"
   
                //-------------------------------
                // Stack Bus OOB downstream Interface
                `include "pe_stack_bus_downstream_oob_instance_ports.vh"
   
                //-------------------------------
                // Stack Bus downstream Interface
                `include "pe_stack_bus_downstream_instance_ports.vh"
   
                //-------------------------------
                // Stack Bus - Upstream
                .pe__stu__valid        ( pe__stu__valid        ),
                .pe__stu__cntl         ( pe__stu__cntl         ),
                .stu__pe__ready        ( stu__pe__ready        ),
                .pe__stu__type         ( pe__stu__type         ),  // Control or Data, Vector or scalar
                .pe__stu__data         ( pe__stu__data         ),
                .pe__stu__oob_data     ( pe__stu__oob_data     ),
 
                //-------------------------------
                // General
                .clk               ( clk               ),
                .reset_poweron     ( reset_poweron     )
              );
      end
  endgenerate

  //-------------------------------------------------------------------------------------------------
  // Stack Bus OOB Downstream Interface
  `include "system_pe_stack_bus_downstream_oob_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus Downstream Interface
  `include "system_pe_stack_bus_downstream_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus Upstream Interface
  `include "system_pe_stack_bus_upstream_instance_connections.vh"

  //-------------------------------------------------------------------------------------------------
  // Inter PE NoC Connectivity      
  //`include "pe_noc_interpe_connections.vh"
  //`include "noc_interpe_port_Bitmask_assignments.vh"



endmodule  /*peArray*/

