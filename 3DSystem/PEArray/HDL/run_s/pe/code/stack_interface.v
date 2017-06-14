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
            // Stack Bus - OOB Downstream
            //
            `include "pe_stack_bus_downstream_oob_ports.vh"

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

            //-------------------------------
            // Stack Bus - Upstream
            //
            pe__stu__valid         ,
            pe__stu__cntl          ,
            stu__pe__ready         ,
            pe__stu__type          ,  // Control or Data, Vector or scalar
            pe__stu__data          ,
            pe__stu__oob_data      ,
 
            //--------------------------------------------------
            // Stack Upstream interface from simd
            sui__sti__valid        , 
            sui__sti__cntl         , 
            sti__sui__ready        , 
                                   
            sui__sti__type         , 
            sui__sti__data         , 
            sui__sti__oob_data     , 
                                   
            clk                    ,
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
  // OOB interface to Stack Bus - downstream
  //
  `include "pe_stack_bus_downstream_oob_port_declarations.vh"

  //---------------------------------------
  // interface to streaming Ops - downstream
  //
  `include "stack_interface_to_stOp_downstream_port_declarations.vh"

  //---------------------------------------
  // interface to PE control - downstream
  //
  `include "stack_interface_to_pe_cntl_downstream_port_declarations.vh"

  //-------------------------------
  // Stack Bus - Upstream
  //
  output                                         pe__stu__valid       ;
  output  [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl        ;
  input                                          stu__pe__ready       ;
  output  [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type        ;  // Control or Data, Vector or scalar
  output  [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data        ;
  output  [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data    ;
 
  //-------------------------------------------------------------------------------------------
  // Information between SIMD and STI is delineated with SOP and EOP.
  //
  input                                             sui__sti__valid            ;
  input  [`COMMON_STD_INTF_CNTL_RANGE   ]           sui__sti__cntl             ;
  output                                            sti__sui__ready            ;
  input  [`STACK_UP_INTF_TYPE_RANGE     ]           sui__sti__type             ;  // Control or Data, Vector or scalar
  input  [`STACK_UP_INTF_DATA_RANGE     ]           sui__sti__data             ;
  input  [`STACK_UP_INTF_OOB_DATA_RANGE ]           sui__sti__oob_data         ;

  //-------------------------------------------------------------------------------------------------
  // Regs and Wires
  
  //---------------------------------------
  // interface to Stack Bus - OOB downstream
  //
  `include "pe_stack_bus_downstream_oob_instance_wires.vh"

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

  //-------------------------------
  // Stack Bus - Upstream
  //
  reg                                            pe__stu__valid       ;
  reg     [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl        ;
  wire                                           stu__pe__ready       ;
  reg     [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type        ;  // Control or Data, Vector or scalar
  reg     [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data        ;
  reg     [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data    ;
 
  wire                                           sui__sti__valid      ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE   ]        sui__sti__cntl       ;
  reg                                            sti__sui__ready      ;
  wire   [`STACK_UP_INTF_TYPE_RANGE     ]        sui__sti__type       ;  // Control or Data, Vector or scalar
  wire   [`STACK_UP_INTF_DATA_RANGE     ]        sui__sti__data       ;
  wire   [`STACK_UP_INTF_OOB_DATA_RANGE ]        sui__sti__oob_data   ;


  //-------------------------------------------------------------------------------------------------
  // Assignments
  
  //-------------------------------
  // Downstream 
  `include "stack_interface_to_stOp_downstream_connections.vh"

  //-------------------------------
  // Downstream OOB carries PE configuration
  assign  sti__cntl__oob_cntl      =  std__pe__oob_cntl    ;
  assign  sti__cntl__oob_valid     =  std__pe__oob_valid   ;
  assign  pe__std__oob_ready       =  cntl__sti__oob_ready ;
  assign  sti__cntl__oob_type      =  std__pe__oob_type    ;
  assign  sti__cntl__oob_data      =  std__pe__oob_data    ;

  //-------------------------------
  // Stack Bus - Upstream
  always @(posedge clk)
    begin
      pe__stu__valid       <=  sui__sti__valid     ;
      pe__stu__cntl        <=  sui__sti__cntl      ;
      sti__sui__ready      <=  stu__pe__ready      ;
      pe__stu__type        <=  sui__sti__type      ;  // Control or Data, Vector or scalar
      pe__stu__data        <=  sui__sti__data      ;
      pe__stu__oob_data    <=  sui__sti__oob_data  ;
    
    end

  //-------------------------------------------------------------------------------------------------

endmodule

