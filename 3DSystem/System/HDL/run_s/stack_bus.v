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
        //`include "system_manager_sys_general_ports.vh"
        mgr__sys__allSynchronized      ,
        sys__mgr__thisSynchronized     ,
        sys__mgr__ready                ,
        sys__mgr__complete             ,
        //`include "system_pe_sys_general_ports.vh"
        sys__pe__allSynchronized      ,
        pe__sys__thisSynchronized     ,
        pe__sys__ready                ,
        pe__sys__complete             ,

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        //`include "system_manager_stack_bus_downstream_oob_ports.vh"
        mgr__std__oob_cntl             ,
        mgr__std__oob_valid            ,
        std__mgr__oob_ready            ,
        mgr__std__oob_type             ,
        mgr__std__oob_data             ,

        //`include "system_pe_stack_bus_downstream_oob_ports.vh"
        std__pe__oob_cntl              ,
        std__pe__oob_valid             ,
        pe__std__oob_ready             ,
        std__pe__oob_type              ,
        std__pe__oob_data              ,

        //`include "system_manager_stack_bus_downstream_ports.vh"
        std__mgr__lane_strm_ready         ,
        mgr__std__lane_strm_cntl          ,
        mgr__std__lane_strm_data          ,
        mgr__std__lane_strm_data_valid    ,

        //`include "system_pe_stack_bus_downstream_ports.vh"
        pe__std__lane_strm_ready          ,
        std__pe__lane_strm_cntl           ,
        std__pe__lane_strm_data           ,
        std__pe__lane_strm_data_valid     ,

        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        //`include "system_manager_stack_bus_upstream_ports.vh"
        stu__mgr__valid           ,
        stu__mgr__cntl            ,
        mgr__stu__ready           ,
        stu__mgr__type            ,
        stu__mgr__data            ,
        stu__mgr__oob_data        ,

        //`include "system_pe_stack_bus_upstream_ports.vh"
        pe__stu__valid            ,
        pe__stu__cntl             ,
        stu__pe__ready            ,
        pe__stu__type             ,
        pe__stu__data             ,
        pe__stu__oob_data         ,


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
  //`include "system_sys_general_port_declarations.vh"
  // - General control and status                                                   
  input                                         mgr__sys__allSynchronized   [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  output                                        sys__mgr__thisSynchronized  [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  output                                        sys__mgr__ready             [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  output                                        sys__mgr__complete          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;

  output                                        sys__pe__allSynchronized    [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  input                                         pe__sys__thisSynchronized   [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  input                                         pe__sys__ready              [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  input                                         pe__sys__complete           [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;


  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  //`include "system_stack_bus_downstream_oob_port_declarations.vh"
  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl     [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;
  input                                           mgr__std__oob_valid    [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;
  output                                          std__mgr__oob_ready    [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type     [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data     [`MGR_ARRAY_NUM_OF_MGR_RANGE ]        ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl      [`PE_ARRAY_NUM_OF_PE_RANGE ]        ;
  output                                          std__pe__oob_valid     [`PE_ARRAY_NUM_OF_PE_RANGE ]        ;
  input                                           pe__std__oob_ready     [`PE_ARRAY_NUM_OF_PE_RANGE ]        ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type      [`PE_ARRAY_NUM_OF_PE_RANGE ]        ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data      [`PE_ARRAY_NUM_OF_PE_RANGE ]        ;

  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  //`include "system_stack_bus_downstream_port_declarations.vh"
  output                                            std__mgr__lane_strm_ready       [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
  input   [`COMMON_STD_INTF_CNTL_RANGE      ]       mgr__std__lane_strm_cntl        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
  input   [`STACK_DOWN_INTF_STRM_DATA_RANGE ]       mgr__std__lane_strm_data        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
  input                                             mgr__std__lane_strm_data_valid  [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;

  input                                             pe__std__lane_strm_ready       [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
  output  [`COMMON_STD_INTF_CNTL_RANGE      ]       std__pe__lane_strm_cntl        [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
  output  [`STACK_DOWN_INTF_STRM_DATA_RANGE ]       std__pe__lane_strm_data        [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;
  output                                            std__pe__lane_strm_data_valid  [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ] ;



  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //`include "system_stack_bus_upstream_port_declarations.vh"
  output                                         stu__mgr__valid     [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
  output  [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl      [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
  input                                          mgr__stu__ready     [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
  output  [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type      [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
  output  [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data      [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
  output  [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data  [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
                                                                                                     
  input                                          pe__stu__valid      [`PE_ARRAY_NUM_OF_PE_RANGE   ]     ;
  input   [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl       [`PE_ARRAY_NUM_OF_PE_RANGE   ]     ;
  output                                         stu__pe__ready      [`PE_ARRAY_NUM_OF_PE_RANGE   ]     ;
  input   [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type       [`PE_ARRAY_NUM_OF_PE_RANGE   ]     ;
  input   [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data       [`PE_ARRAY_NUM_OF_PE_RANGE   ]     ;
  input   [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data   [`PE_ARRAY_NUM_OF_PE_RANGE   ]     ;




  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Regs and wires


  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  //`include "system_manager_sys_general_instance_wires.vh"
  // General control and status                                                 
  wire                                        mgr__sys__allSynchronized   [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire                                        sys__mgr__thisSynchronized  [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire                                        sys__mgr__ready             [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;
  wire                                        sys__mgr__complete          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]   ;

  //`include "system_pe_sys_general_instance_wires.vh"
  // General control and status                                                
  wire                                        sys__pe__allSynchronized    [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  wire                                        pe__sys__thisSynchronized   [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  wire                                        pe__sys__ready              [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  wire                                        pe__sys__complete           [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  //`include "system_manager_stack_bus_downstream_oob_instance_wires.vh"
  // OOB controls how the lanes are interpreted                                
  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl       [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
  wire                                        mgr__std__oob_valid      [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
  wire                                        std__mgr__oob_ready      [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type       [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;
  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data       [`MGR_ARRAY_NUM_OF_MGR_RANGE ]      ;

  //`include "system_pe_stack_bus_downstream_oob_instance_wires.vh"
  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl          [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire                                        std__pe__oob_valid         [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire                                        pe__std__oob_ready         [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type          [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data          [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;

  //`include "system_manager_stack_bus_downstream_instance_wires.vh"
  wire                                        std__mgr__lane_strm_ready       [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]   mgr__std__lane_strm_cntl        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]   mgr__std__lane_strm_data        [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire                                        mgr__std__lane_strm_data_valid  [`MGR_ARRAY_NUM_OF_MGR_RANGE ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;

  //`include "system_pe_stack_bus_downstream_instance_wires.vh"
  wire                                        pe__std__lane_strm_ready        [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]   std__pe__lane_strm_cntl         [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]   std__pe__lane_strm_data         [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;
  wire                                        std__pe__lane_strm_data_valid   [`PE_ARRAY_NUM_OF_PE_RANGE   ] [`PE_NUM_OF_EXEC_LANES_RANGE ] [`PE_NUM_OF_STREAMS_RANGE ]  ;

  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //`include "system_manager_stack_bus_upstream_instance_wires.vh"
  wire                                           stu__mgr__valid         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire                                           mgr__stu__ready         [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data          [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;
  wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data      [`MGR_ARRAY_NUM_OF_MGR_RANGE ]  ;

  //`include "system_pe_stack_bus_upstream_instance_wires.vh"
  wire                                           pe__stu__valid          [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl           [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire                                           stu__pe__ready          [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire    [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type           [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire    [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data           [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;
  wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data       [`PE_ARRAY_NUM_OF_PE_RANGE   ]  ;

  
  //-------------------------------------------------------------------------------------------



  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Connections

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  //`include "system_general_instance_connections.vh"
  // General control and status                                       
  generate
    for (genvar inst=0; inst<`PE_ARRAY_NUM_OF_PE; inst=inst+1) 
      begin
        assign    sys__pe__allSynchronized   [inst]  =    mgr__sys__allSynchronized [inst]   ;
        assign    sys__mgr__thisSynchronized [inst]  =    pe__sys__thisSynchronized [inst]   ;
        assign    sys__mgr__ready            [inst]  =    pe__sys__ready            [inst]   ;
        assign    sys__mgr__complete         [inst]  =    pe__sys__complete         [inst]   ;
      end
  endgenerate

  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  //`include "system_stack_bus_downstream_oob_instance_connections.vh"
  // OOB controls how the lanes are interpreted                                  
  generate
    for (genvar inst=0; inst<`PE_ARRAY_NUM_OF_PE; inst=inst+1) 
      begin
        assign    std__pe__oob_cntl    [inst] =    mgr__std__oob_cntl   [inst]          ;
        assign    std__pe__oob_valid   [inst] =    mgr__std__oob_valid  [inst]          ;
        assign    std__mgr__oob_ready  [inst] =    pe__std__oob_ready   [inst]          ;
        assign    std__pe__oob_type    [inst] =    mgr__std__oob_type   [inst]          ;
        assign    std__pe__oob_data    [inst] =    mgr__std__oob_data   [inst]          ;
      end
  endgenerate
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  //`include "system_stack_bus_downstream_instance_connections.vh"
  generate
    for (genvar inst=0; inst<`PE_ARRAY_NUM_OF_PE; inst=inst+1) 
      begin
          for (genvar lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane=lane+1) 
            begin
              for (genvar strm=0; strm<`PE_NUM_OF_STREAMS; strm=strm+1) 
                begin
                  assign    std__mgr__lane_strm_ready     [inst] [lane] [strm]  =    pe__std__lane_strm_ready       [inst] [lane] [strm] ;
                  assign    std__pe__lane_strm_cntl       [inst] [lane] [strm]  =    mgr__std__lane_strm_cntl       [inst] [lane] [strm] ;
                  assign    std__pe__lane_strm_data       [inst] [lane] [strm]  =    mgr__std__lane_strm_data       [inst] [lane] [strm] ;
                  assign    std__pe__lane_strm_data_valid [inst] [lane] [strm]  =    mgr__std__lane_strm_data_valid [inst] [lane] [strm] ;
                end
            end
      end
  endgenerate
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //`include "system_stack_bus_upstream_instance_connections.vh"
  generate
    for (genvar inst=0; inst<`PE_ARRAY_NUM_OF_PE; inst=inst+1) 
      begin
        assign    stu__mgr__valid    [inst]    =    pe__stu__valid    [inst]       ;
        assign    stu__mgr__cntl     [inst]    =    pe__stu__cntl     [inst]       ;
        assign    stu__pe__ready     [inst]    =    mgr__stu__ready   [inst]       ;
        assign    stu__mgr__type     [inst]    =    pe__stu__type     [inst]       ;
        assign    stu__mgr__data     [inst]    =    pe__stu__data     [inst]       ;
        assign    stu__mgr__oob_data [inst]    =    pe__stu__oob_data [inst]       ;
      end
  endgenerate

  

  //-------------------------------------------------------------------------------------------




endmodule  

