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
        //`include "system_pe_sys_general_ports.vh"
        // - General control and status                                                  
        sys__pe__allSynchronized    ,
        pe__sys__thisSynchronized   ,
        pe__sys__ready              ,
        pe__sys__complete           ,

        //-------------------------------------------------------------------------------------------
        // Stack Bus - OOB Downstream
        //`include "system_pe_stack_bus_downstream_ports.vh"
        pe__std__lane_strm_ready                   , 
        std__pe__lane_strm_cntl                    ,
        std__pe__lane_strm_data                    ,
        std__pe__lane_strm_data_valid              ,


        //-------------------------------------------------------------------------------------------
        // Stack Bus - Downstream
        //`include "system_pe_stack_bus_downstream_oob_ports.vh"
        // - OOB controls the PE                         
        // - For now assume OOB is separate to lanes     
        std__pe__oob_cntl                           ,
        std__pe__oob_valid                          ,
        pe__std__oob_ready                          ,
        std__pe__oob_type                           ,
        std__pe__oob_data                           ,


        //-------------------------------------------------------------------------------------------
        // Stack Bus - Upstream
        //`include "system_pe_stack_bus_upstream_ports.vh"
        pe__stu__valid          ,
        pe__stu__cntl           ,
        stu__pe__ready          ,
        pe__stu__type           ,
        pe__stu__data           ,
        pe__stu__oob_data       ,


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
  //`include "system_pe_sys_general_port_declarations.vh"
  input                                         sys__pe__allSynchronized    [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  output                                        pe__sys__thisSynchronized   [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  output                                        pe__sys__ready              [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  output                                        pe__sys__complete           [`PE_ARRAY_NUM_OF_PE_RANGE ] ;


  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  //`include "system_pe_stack_bus_downstream_oob_port_declarations.vh"
  // - OOB controls how the lanes are interpreted                                  
  input [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl          [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  input                                         std__pe__oob_valid         [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  output                                        pe__std__oob_ready         [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type          [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data          [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;


  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  //`include "system_pe_stack_bus_downstream_port_declarations.vh"
  output                                           pe__std__lane_strm_ready       [`PE_ARRAY_NUM_OF_PE_RANGE ]  [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;
  input [`COMMON_STD_INTF_CNTL_RANGE       ]       std__pe__lane_strm_cntl        [`PE_ARRAY_NUM_OF_PE_RANGE ]  [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;
  input [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       std__pe__lane_strm_data        [`PE_ARRAY_NUM_OF_PE_RANGE ]  [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;
  input                                            std__pe__lane_strm_data_valid  [`PE_ARRAY_NUM_OF_PE_RANGE ]  [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;




  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //`include "system_pe_stack_bus_upstream_port_declarations.vh"
  output                                         pe__stu__valid          [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  output  [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl           [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  input                                          stu__pe__ready          [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  output  [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type           [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  output  [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data           [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  output  [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data       [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;



  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // Regs and wires

  //-------------------------------------------------------------------------------------------
  // Stack Bus - General
  //`include "system_pe_sys_general_instance_wires.vh"
  // General control and status                                                
  wire                                        sys__pe__allSynchronized     [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  wire                                        pe__sys__thisSynchronized    [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  wire                                        pe__sys__ready               [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  wire                                        pe__sys__complete            [`PE_ARRAY_NUM_OF_PE_RANGE ] ;
  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - OOB Downstream
  //`include "system_pe_stack_bus_downstream_oob_instance_wires.vh"
  // OOB controls how the lanes are interpreted                                
  wire [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl          [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire                                         std__pe__oob_valid         [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire                                         pe__std__oob_ready         [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type          [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;
  wire [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data          [`PE_ARRAY_NUM_OF_PE_RANGE ]    ;

  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Downstream
  //`include "system_pe_stack_bus_downstream_instance_wires.vh"
  wire                                             pe__std__lane_strm_ready       [`PE_ARRAY_NUM_OF_PE_RANGE ]  [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;
  wire  [`COMMON_STD_INTF_CNTL_RANGE       ]       std__pe__lane_strm_cntl        [`PE_ARRAY_NUM_OF_PE_RANGE ]  [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;
  wire  [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       std__pe__lane_strm_data        [`PE_ARRAY_NUM_OF_PE_RANGE ]  [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;
  wire                                             std__pe__lane_strm_data_valid  [`PE_ARRAY_NUM_OF_PE_RANGE ]  [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;

  
  //-------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //`include "system_pe_stack_bus_upstream_instance_wires.vh"
  wire                                           pe__stu__valid          [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl           [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  wire                                           stu__pe__ready          [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  wire    [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type           [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  wire    [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data           [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;
  wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data       [`PE_ARRAY_NUM_OF_PE_RANGE ]  ;

  
  
 
  genvar gvi;
  generate
    for (gvi=0; gvi<`PE_ARRAY_NUM_OF_PE; gvi=gvi+1) 
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
        //   - OOB carries PE configuration                                           
        wire [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl            ;
        wire                                         std__pe__oob_valid           ;
        wire                                         pe__std__oob_ready           ;
        wire [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type            ;
        wire [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data            ;

        //-------------------------------------------------------------------------------------------------
        // Stack Bus downstream Interface
        //`include "pe_stack_bus_downstream_instance_wires.vh"
        wire                                             pe__std__lane_strm_ready       [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;
        wire  [`COMMON_STD_INTF_CNTL_RANGE       ]       std__pe__lane_strm_cntl        [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;
        wire  [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       std__pe__lane_strm_data        [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;
        wire                                             std__pe__lane_strm_data_valid  [`PE_NUM_OF_EXEC_LANES_RANGE ]   [`PE_NUM_OF_STREAMS_RANGE ] ;

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


        assign sys__pe__peId = gvi;

        pe pe (
   
                //-------------------------------
                // Stack Bus General control and status     
                .sys__pe__peId                      ( sys__pe__peId                   ),
                .sys__pe__allSynchronized           ( sys__pe__allSynchronized        ),
                .pe__sys__thisSynchronized          ( pe__sys__thisSynchronized       ),
                .pe__sys__ready                     ( pe__sys__ready                  ),
                .pe__sys__complete                  ( pe__sys__complete               ),
   
                //-------------------------------
                // Stack Bus OOB downstream Interface
                //   - OOB carries PE configuration                                         
                .std__pe__oob_cntl                  ( std__pe__oob_cntl               ),
                .std__pe__oob_valid                 ( std__pe__oob_valid              ),
                .pe__std__oob_ready                 ( pe__std__oob_ready              ),
                .std__pe__oob_type                  ( std__pe__oob_type               ),
                .std__pe__oob_data                  ( std__pe__oob_data               ),
   
                //-------------------------------
                // Stack Bus downstream Interface
                //`include "pe_stack_bus_downstream_instance_ports.vh"
                .pe__std__lane_strm_ready         ( pe__std__lane_strm_ready      ),      
                .std__pe__lane_strm_cntl          ( std__pe__lane_strm_cntl       ),      
                .std__pe__lane_strm_data          ( std__pe__lane_strm_data       ),      
                .std__pe__lane_strm_data_valid    ( std__pe__lane_strm_data_valid ),      
   
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
  //`include "system_pe_stack_bus_downstream_oob_instance_connections.vh"
  generate
  for (genvar pe=0; pe<`PE_ARRAY_NUM_OF_PE; pe++)
    begin
      assign   pe_inst[pe].sys__pe__allSynchronized        =  sys__pe__allSynchronized                     [pe]  ;
      assign   pe__sys__thisSynchronized             [pe]  =  pe_inst[pe].pe__sys__thisSynchronized              ;
      assign   pe__sys__ready                        [pe]  =  pe_inst[pe].pe__sys__ready                         ;
      assign   pe__sys__complete                     [pe]  =  pe_inst[pe].pe__sys__complete                      ;
      assign   pe_inst[pe].std__pe__oob_cntl               =  std__pe__oob_cntl                            [pe]  ;
      assign   pe_inst[pe].std__pe__oob_valid              =  std__pe__oob_valid                           [pe]  ;
      assign   pe__std__oob_ready                    [pe]  =  pe_inst[pe].pe__std__oob_ready                     ;
      assign   pe_inst[pe].std__pe__oob_type               =  std__pe__oob_type                            [pe]  ;
      assign   pe_inst[pe].std__pe__oob_data               =  std__pe__oob_data                            [pe]  ;
    end
  endgenerate

  //-------------------------------------------------------------------------------------------------
  // Stack Bus Downstream Interface
  //`include "system_pe_stack_bus_downstream_instance_connections.vh"
  generate
  for (genvar pe=0; pe<`PE_ARRAY_NUM_OF_PE; pe++)
    begin
      assign   pe__std__lane_strm_ready                   [pe]  =  pe_inst[pe].pe__std__lane_strm_ready         ;
      assign   pe_inst[pe].std__pe__lane_strm_cntl              =  std__pe__lane_strm_cntl                [pe]  ;
      assign   pe_inst[pe].std__pe__lane_strm_data              =  std__pe__lane_strm_data                [pe]  ;
      assign   pe_inst[pe].std__pe__lane_strm_data_valid        =  std__pe__lane_strm_data_valid          [pe]  ;
    end
  endgenerate


  //-------------------------------------------------------------------------------------------------
  // Stack Bus Upstream Interface
  //`include "system_pe_stack_bus_upstream_instance_connections.vh"
  generate
  for (genvar pe=0; pe<`PE_ARRAY_NUM_OF_PE; pe++)
    begin
      assign   pe__stu__valid               [pe] =  pe_inst[pe].pe__stu__valid          ;
      assign   pe__stu__cntl                [pe] =  pe_inst[pe].pe__stu__cntl           ;
      assign   pe_inst[pe].stu__pe__ready        =  stu__pe__ready                 [pe] ;
      assign   pe__stu__type                [pe] =  pe_inst[pe].pe__stu__type           ;
      assign   pe__stu__data                [pe] =  pe_inst[pe].pe__stu__data           ;
      assign   pe__stu__oob_data            [pe] =  pe_inst[pe].pe__stu__oob_data       ;
    end
  endgenerate




endmodule  /*peArray*/

