/*********************************************************************************************

    File name   : manager.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module is the LBB Cortical Processor Manager.
                  It runs work-units, reads dat from the dram and sends to he PE, takes upstream data from the
                  PE and writes it back to DRAM (locally or thru the NoC.

*********************************************************************************************/
    
`timescale 1ns/10ps

//--------------------------------------------------
// test related defines
`ifdef TESTING
`include "TB_common.vh"
`endif

//--------------------------------------------------
// RTL related defines
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "stack_interface.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"

module manager (

            //-------------------------------
            // Stack Bus - Downstream
            //
            `include "manager_stack_bus_downstream_ports.vh"

            //-------------------------------
            // Stack Bus - Upstream
            //
            mgr__stu__valid         ,
            mgr__stu__cntl          ,
            stu__mgr__ready         ,
            mgr__stu__tymgr          ,  // Control or Data, Vector or scalar
            mgr__stu__data          ,
            mgr__stu__oob_data      ,
 
            //-------------------------------
            // NoC
            //
            //`include "noc_cntl_noc_ports.vh"
            //
 
            // General control and status 
            sys__mgr__mgrId               , 
            sys__mgr__allSynchronized     , 
            mgr__sys__thisSynchronized    , 
            mgr__sys__ready               , 
            mgr__sys__complete            , 

            clk                    ,
            reset_poweron    
 
    );

  input                               clk                ;
  input                               reset_poweron      ;

  // General control and status                                
  input   [`MGR_MGR_ID_RANGE    ]     sys__mgr__mgrId               ;
  output                              sys__mgr__allSynchronized     ;
  input                               mgr__sys__thisSynchronized    ; 
  input                               mgr__sys__ready               ; 
  input                               mgr__sys__complete            ; 

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Downstream

  `include "manager_stack_bus_downstream_port_declarations.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //
  output                                         mgr__stu__valid       ;
  output  [`COMMON_STD_INTF_CNTL_RANGE   ]       mgr__stu__cntl        ;
  input                                          stu__mgr__ready       ;
  output  [`STACK_UP_INTF_TYPE_RANGE     ]       mgr__stu__tymgr        ;  // Control or Data, Vector or scalar
  output  [`STACK_UP_INTF_DATA_RANGE     ]       mgr__stu__data        ;
  output  [`STACK_UP_INTF_OOB_DATA_RANGE ]       mgr__stu__oob_data    ;
 

  //-------------------------------------------------------------------------------------------------
  // Regs and Wires
  
  wire    [`MGR_MGR_ID_RANGE    ]     sys__mgr__mgrId    ;

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //
  wire                                           mgr__stu__valid       ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       mgr__stu__cntl        ;
  wire                                           stu__mgr__ready       ;
  wire    [`STACK_UP_INTF_TYPE_RANGE     ]       mgr__stu__tymgr        ;  // Control or Data, Vector or scalar
  wire    [`STACK_UP_INTF_DATA_RANGE     ]       mgr__stu__data        ;
  wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       mgr__stu__oob_data    ;
 
  //-------------------------------------------------------------------------------------------------
  // NoC
  //
  //`include "noc_cntl_noc_ports_declaration.vh"


endmodule

