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
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"

module manager (

            //-------------------------------
            // NoC
            //
            `include "manager_noc_cntl_noc_ports.vh"
 
            //-------------------------------
            // Stack Bus - Downstream
            //
            `include "manager_stack_bus_downstream_ports.vh"

            //-------------------------------
            // Stack Bus - Upstream
            //
            stu__mgr__valid         ,
            stu__mgr__cntl          ,
            mgr__stu__ready         ,
            stu__mgr__type          ,  // Control or Data, Vector or scalar
            stu__mgr__data          ,
            stu__mgr__oob_data      ,
 
            //-------------------------------
            // General control and status 
            sys__mgr__mgrId               , 
            mgr__sys__allSynchronized     , 
            sys__mgr__thisSynchronized    , 
            sys__mgr__ready               , 
            sys__mgr__complete            , 

            clk                    ,
            reset_poweron    
 
    );

  input                               clk                ;
  input                               reset_poweron      ;

  // General control and status                                
  input   [`MGR_MGR_ID_RANGE    ]     sys__mgr__mgrId               ;
  output                              mgr__sys__allSynchronized     ;
  input                               sys__mgr__thisSynchronized    ; 
  input                               sys__mgr__ready               ; 
  input                               sys__mgr__complete            ; 

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Downstream

  `include "manager_stack_bus_downstream_port_declarations.vh"

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //
  output                                         stu__mgr__valid       ;
  output  [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl        ;
  input                                          mgr__stu__ready       ;
  output  [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type        ;  // Control or Data, Vector or scalar
  output  [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data        ;
  output  [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data    ;
 

  //-------------------------------------------------------------------------------------------------
  // Regs and Wires
  
  wire    [`MGR_MGR_ID_RANGE    ]     sys__mgr__mgrId    ;

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
  // NoC
  //
  `include "manager_noc_cntl_noc_ports_declaration.vh"

  `include "noc_to_mgrArray_connection_wires.vh"

  `include "manager_noc_connection_wires.vh"

  wire  [`MGR_WU_ADDRESS_RANGE    ]     wuf__wum__addr          ;
  wire  [`MGR_WU_ADDRESS_RANGE    ]     mcntl__wuf__start_addr  ;  // first WU address

  wu_fetch wu_fetch (
  
          //-------------------------------
          // To WU memory
          .wuf__wum__read          ( wuf__wum__read           ),
          .wuf__wum__addr          ( wuf__wum__addr           ),
 
          //-------------------------------
          // Control
          .mcntl__wuf__enable      ( mcntl__wuf__enable       ),
          .mcntl__wuf__start_addr  ( mcntl__wuf__start_addr   ),

          //-------------------------------
          // 
          .xxx__wuf__stall         ( xxx__wuf__stall          ),
 
          //-------------------------------
          // General
          .sys__mgr__mgrId         ( sys__mgr__mgrId          ),

          .clk                     ( clk                      ),
          .reset_poweron           ( reset_poweron            )
        );


  wire  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl                ;  // instruction delineator
  wire  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl                ;  // descriptor delineator
  // WU Instruction option fields
  wire  [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST ] ;  // 
  wire  [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST ] ;  // 

  wu_memory wu_memory (
  
          .valid                   ( wuf__wum__read           ),  // used to initiate readmemh

          //-------------------------------
          // From WU fetch 
          .wuf__wum__read          ( wuf__wum__read           ),
          .wuf__wum__addr          ( wuf__wum__addr           ),
 
          //-------------------------------
          // To WU decode
          .wum__wud__valid         ( wum__wud__valid          ),
          .wum__wud__icntl         ( wum__wud__icntl          ),
          .wum__wud__dcntl         ( wum__wud__dcntl          ),
          .wum__wud__option_type   ( wum__wud__option_type    ),
          .wum__wud__option_value  ( wum__wud__option_value   ),

          //-------------------------------
          // General
          .sys__mgr__mgrId         ( sys__mgr__mgrId          ),

          .clk                     ( clk               )
        );

  //-------------------------------------------------------------------------------------------------
  // NoC Interface
  // 
  noc_cntl noc_cntl (

                        // Aggregate Control-Path (cp) to NoC 
                       .noc__scntl__cp_ready          ( noc__mcntl__cp_ready         ), 
                       .scntl__noc__cp_cntl           ( mcntl__noc__cp_cntl          ), 
                       .scntl__noc__cp_type           ( mcntl__noc__cp_type          ), 
                       .scntl__noc__cp_data           ( mcntl__noc__cp_data          ), 
                       .scntl__noc__cp_laneId         ( mcntl__noc__cp_laneId        ), 
                       .scntl__noc__cp_strmId         ( mcntl__noc__cp_strmId        ), 
                       .scntl__noc__cp_valid          ( mcntl__noc__cp_valid         ), 
                        // Aggregate Data-Path (cp) from NoC 
                       .scntl__noc__cp_ready          ( mcntl__noc__cp_ready         ), 
                       .noc__scntl__cp_cntl           ( noc__mcntl__cp_cntl          ), 
                       .noc__scntl__cp_type           ( noc__mcntl__cp_type          ), 
                       .noc__scntl__cp_data           ( noc__mcntl__cp_data          ), 
                       .noc__scntl__cp_peId           ( noc__mcntl__cp_peId          ), 
                       .noc__scntl__cp_laneId         ( noc__mcntl__cp_laneId        ), 
                       .noc__scntl__cp_strmId         ( noc__mcntl__cp_strmId        ), 
                       .noc__scntl__cp_valid          ( noc__mcntl__cp_valid         ), 
                       
                        // Aggregate Data-Path (dp) to NoC 
                       .noc__scntl__dp_ready          ( noc__mcntl__dp_ready         ), 
                       .scntl__noc__dp_type           ( mcntl__noc__dp_type          ), 
                       .scntl__noc__dp_cntl           ( mcntl__noc__dp_cntl          ), 
                       .scntl__noc__dp_peId           ( mcntl__noc__dp_peId          ), 
                       .scntl__noc__dp_laneId         ( mcntl__noc__dp_laneId        ), 
                       .scntl__noc__dp_strmId         ( mcntl__noc__dp_strmId        ), 
                       .scntl__noc__dp_data           ( mcntl__noc__dp_data          ), 
                       .scntl__noc__dp_valid          ( mcntl__noc__dp_valid         ), 
                        // Aggregate Data-Path (dp) from NoC 
                       .scntl__noc__dp_ready          ( mcntl__noc__dp_ready         ), 
                       .noc__scntl__dp_cntl           ( noc__mcntl__dp_cntl          ), 
                       .noc__scntl__dp_type           ( noc__mcntl__dp_type          ), 
                       .noc__scntl__dp_laneId         ( noc__mcntl__dp_laneId        ), 
                       .noc__scntl__dp_strmId         ( noc__mcntl__dp_strmId        ), 
                       .noc__scntl__dp_data           ( noc__mcntl__dp_data          ), 
                       .noc__scntl__dp_valid          ( noc__mcntl__dp_valid         ), 

                        // Connections to external NoC
                        `include "manager_noc_cntl_noc_ports_instance_ports.vh"

                       .peId                         ( sys__mgr__mgrId             ),
                       .clk                          ( clk                         ),
                       .reset_poweron                ( reset_poweron               )
                          
  );
endmodule
