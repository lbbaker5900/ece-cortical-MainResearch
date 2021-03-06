/*********************************************************************************************

    File name   : pe_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Feb 2017
    email       : lbbaker@ncsu.edu

    Description : This module converts OOB information and/or lane control data to local control for simd and stOp.
                  The oob_data is organized as {option, data} tuples and the data hold 2 tuples per cycle

                  For simd and stOp configuration, the OOB packet from the manager indexes memories in this module to control the stOp and simd.
                  The assumtion is the configurations for the operations can be stored locally and have been preloaded and we simply send a pointer to the operation in this local memory.
                  Note: we currently assume we only need PE specific data and things like number of operands and addresses are common.

*********************************************************************************************/
    
`timescale 1ns/10ps
`ifndef SYNTHESIS
  `include "TB_common.vh"
`endif
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "pe_cntl.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "python_typedef.vh"


module pe_cntl (

            //-------------------------------
            // Stack Bus interface
            //
            sys__pe__peId                                 ,
            
            // OOB Downstream carries PE configuration 
            sti__cntl__oob_cntl                           ,
            sti__cntl__oob_valid                          ,
            cntl__sti__oob_ready                          ,
            sti__cntl__oob_type                           ,
            sti__cntl__oob_data                           ,
            
            //-------------------------------
            // Configuration output
            //

            cntl__simd__tag_valid                         ,
            cntl__simd__tag                               ,
            cntl__simd__tag_optionPtr                     ,
            cntl__simd__tag_num_lanes                     ,
            simd__cntl__tag_ready                         ,

            `include "pe_cntl_simd_ports.vh"
            stOp_complete                                 ,

            //-------------------------------
            // General
            //
            clk              ,
            reset_poweron    
 
    );

  //----------------------------------------------------------------------------------------------------
  // General

  input                                           clk                          ;
  input                                           reset_poweron                ;

  input [`PE_PE_ID_RANGE                 ]        sys__pe__peId                ;

  //----------------------------------------------------------------------------------------------------
  // Stack down OOB

  input  [`COMMON_STD_INTF_CNTL_RANGE     ]        sti__cntl__oob_cntl            ;
  input                                            sti__cntl__oob_valid           ;
  output                                           cntl__sti__oob_ready           ;
  input  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]        sti__cntl__oob_type            ;
  input  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]        sti__cntl__oob_data            ;
                                                
  output                                           cntl__simd__tag_valid          ;  // tag to simd needs to be a fifo interface as the next stOp may start while the 
  output [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]        cntl__simd__tag                ;  // simd is processing the previosu stOp result
  output [`PE_CNTL_OOB_OPTION_RANGE       ]        cntl__simd__tag_optionPtr      ;  // SIMD operation PC
  output [`PE_NUM_LANES_RANGE             ]        cntl__simd__tag_num_lanes      ;  // number of active lanes associated with this tag
  input                                            simd__cntl__tag_ready          ;

  input                                            stOp_complete                  ;  // dont allow another OOB command until we are complete

  //----------------------------------------------------------------------------------------------------
  // Outputs to controller

  `include "pe_cntl_simd_port_declarations.vh"

  reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    cntl__simd__optionPtr      ; 
  //----------------------------------------------------------------------------------------------------
  // Configuration output

  wire   [`STREAMING_OP_CNTL_OPERATION_RANGE ]    stOp_operation             ;  

  reg    [`STACK_DOWN_OOB_INTF_TAG_RANGE     ]    tag                        ;  // tag from OOB packet

  wire   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress0             ;  
  wire   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress0        ;  
  wire   [`PE_DATA_TYPES_RANGE               ]    src_data_type0             ;
  wire   [`PE_DATA_TYPES_RANGE               ]    dest_data_type0            ;

  wire   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress1             ;  
  wire   [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress1        ;  
  wire   [`PE_DATA_TYPES_RANGE               ]    src_data_type1             ;
  wire   [`PE_DATA_TYPES_RANGE               ]    dest_data_type1            ;

  wire   [`PE_MAX_NUM_OF_TYPES_RANGE         ]    numberOfOperands           ;

  reg    [`PE_NUM_OF_EXEC_LANES_RANGE        ]    execLanesActive            ;
  reg    [`PE_NUM_LANES_RANGE                ]    numberOfActiveLanes        ;  // between 0-32, so 6 bits


  //----------------------------------------------------------------------------------------------------
  // Registers/Wires

  reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    stOp_optionPtr             ; 
  reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    simd_optionPtr             ; 
  reg                                             start_stOp_operation       ;  // when a completed packet has been received and it contained a stOp operation
  reg                                             start_simd_operation       ;  // when a completed packet has been received and it contained a simd operation
  reg                                             stop_stOp_operation        ;  // wait for complete to be asserted, then deassert rs0[0] and wait for complete to be deasserted
  reg                                             stop_simd_operation        ;  
  reg                                             contained_stOp             ;  // the OOB packet indicated a operation should be initiated
  reg                                             contained_simd             ;  // the OOB packet indicated a operation should be initiated
  wire                                            oob_packet_starting        ;  // when a packet is first received

  wire                                            cntl__simd__tag_valid      ;  // tag to simd needs to be a fifo interface as the next stOp may start while the 
  wire  [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]        cntl__simd__tag            ;  // simd is processing the previosu stOp result
  wire  [`PE_NUM_LANES_RANGE             ]        cntl__simd__tag_num_lanes  ;  // number of active lanes associated with this tag
  wire                                            simd__cntl__tag_ready      ;
  reg                                             simd__cntl__tag_ready_d1   ;

// Outputs will default as wires allowing them to be driven by the testbench
`ifdef SYNTHESIS
  `undef TB_DRIVES_SIMD_REGFILE_INPUTS
`endif
`ifndef TB_DRIVES_SIMD_REGFILE_INPUTS
  `include "pe_cntl_simd_instance_wires.vh"
`endif

  reg   [`COMMON_STD_INTF_CNTL_RANGE     ]        sti__cntl__oob_cntl_d1         ;
  reg                                             sti__cntl__oob_valid_d1        ;
  reg                                             cntl__sti__oob_ready           ;
  wire                                            cntl__sti__oob_ready_e1        ;
  reg   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]        sti__cntl__oob_type_d1         ;
  reg   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]        sti__cntl__oob_data_d1         ;

  //----------------------------------------------------------------------------------------------------
  // Registered Inputs and Outputs

  always @(posedge clk)
    begin
      sti__cntl__oob_cntl_d1    <= ( reset_poweron   ) ? 'd0  :  sti__cntl__oob_cntl        ;
      sti__cntl__oob_valid_d1   <= ( reset_poweron   ) ? 'd0  :  sti__cntl__oob_valid       ;
      cntl__sti__oob_ready      <= ( reset_poweron   ) ? 'd0  :  cntl__sti__oob_ready_e1    ;
      sti__cntl__oob_type_d1    <= ( reset_poweron   ) ? 'd0  :  sti__cntl__oob_type        ;
      sti__cntl__oob_data_d1    <= ( reset_poweron   ) ? 'd0  :  sti__cntl__oob_data        ;

      simd__cntl__tag_ready_d1  <= ( reset_poweron   ) ? 'd0  :  simd__cntl__tag_ready      ;
    end



  //----------------------------------------------------------------------------------------------------
  // Connections from control memory to all simd lane control
  //
  // Originally the control for the stOp was going to come from the simd registers, so we have maintain the register naming for the stOp although these should probably change.
  //
`ifdef SYNTHESIS
  `undef TB_DRIVES_SIMD_REGFILE_INPUTS
`endif
`ifndef TB_DRIVES_SIMD_REGFILE_INPUTS
  genvar pe, lane;
  generate
      always @(posedge clk)
        begin
          // FIXME: Could be wire and multicycle
          cntl__simd__rs0[0]                   <= ( reset_poweron ) ? 'd0 : cntl__simd__rs0_e1[0]             ;
          cntl__simd__rs0[31:1]                <= ( reset_poweron ) ? 'd0 : cntl__simd__rs0_e1[31:1]          ;  // `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM ;
          cntl__simd__rs1                      <= ( reset_poweron ) ? 'd0 : cntl__simd__rs1_e1                ;
        end
      for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane=lane+1)
          begin

              wire  [`PE_CHIPLET_LANE_ADDR_BITS_RANGE ]     lane_from_genvar;
              assign lane_from_genvar                     = lane                  ;

              // From the manager, we use a common address for all lanes, so index into the lane memory
              // FIXME: Could be wire and multicycle
              always @(posedge clk)
                begin
                  cntl__simd__lane_r130[lane]          <= ( reset_poweron ) ? 'd0 : {cntl__simd__lane_r130_e1[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  cntl__simd__lane_r130_e1[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
                  cntl__simd__lane_r134[lane]          <= ( reset_poweron ) ? 'd0 : {cntl__simd__lane_r134_e1[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  cntl__simd__lane_r134_e1[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
                  cntl__simd__lane_r132[lane][19:16]   <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r132_e1[19:16]   ;  // type (bit, nibble, byte, word)
                                                                                              
                  cntl__simd__lane_r131[lane]          <= ( reset_poweron ) ? 'd0 : {cntl__simd__lane_r131_e1[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  cntl__simd__lane_r131_e1[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
                  cntl__simd__lane_r135[lane]          <= ( reset_poweron ) ? 'd0 : {cntl__simd__lane_r135_e1[`PE_CHIPLET_ADDR_BITS_RANGE ], lane_from_genvar,  cntl__simd__lane_r135_e1[`PE_CHIPLET_LANE_ADDRESS_RANGE ]} ;
                  cntl__simd__lane_r133[lane][19:16]   <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r133_e1[19:16]   ;  // type (bit, nibble, byte, word)
                                                                                              
                  cntl__simd__lane_r133[lane][15: 0]   <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r133_e1[15: 0]   ;
                  cntl__simd__lane_r132[lane][15: 0]   <= ( reset_poweron ) ? 'd0 : cntl__simd__lane_r132_e1[15: 0]   ;  // num of types - for dma
                                                                                              
                end
          end
  endgenerate
`endif

`ifndef TB_DRIVES_SIMD_REGFILE_INPUTS
  always @(posedge clk)
    begin
      cntl__simd__lane_r130_e1          <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( start_stOp_operation ) ? sourceAddress0                                      : cntl__simd__lane_r130_e1          ;
      cntl__simd__lane_r134_e1          <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( start_stOp_operation ) ? destinationAddress0                                 : cntl__simd__lane_r134_e1          ;
      cntl__simd__lane_r132_e1[19:16]   <= (reset_poweron ) ? 4'd0                    : ( start_stOp_operation ) ? src_data_type0                                      : cntl__simd__lane_r132_e1[19:16]   ;  // type (bit, nibble, byte, word)
                                                                                                                                                                                                         
      cntl__simd__lane_r131_e1          <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( start_stOp_operation ) ? sourceAddress1                                      : cntl__simd__lane_r131_e1          ;
      cntl__simd__lane_r135_e1          <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( start_stOp_operation ) ? destinationAddress1                                 : cntl__simd__lane_r135_e1          ;
      cntl__simd__lane_r133_e1[19:16]   <= (reset_poweron ) ? 4'd0                    : ( start_stOp_operation ) ? src_data_type1                                      : cntl__simd__lane_r133_e1[19:16]   ;  // type (bit, nibble, byte, word)
                                                                                                                                                                                                         
      cntl__simd__lane_r133_e1[15: 0]   <= (reset_poweron ) ? 16'd0                   : ( start_stOp_operation ) ? numberOfOperands                                    : cntl__simd__lane_r133_e1[15: 0]   ;
      cntl__simd__lane_r132_e1[15: 0]   <= (reset_poweron ) ? 16'd0                   : ( start_stOp_operation ) ? numberOfOperands                                    : cntl__simd__lane_r132_e1[15: 0]   ;  // num of types - for dma
                                                                                                                                                                                                         
      cntl__simd__rs0_e1[0]             <= (reset_poweron ) ? 1'b0                    : ( start_stOp_operation ) ? 1'b1             : ( stop_stOp_operation ) ? 1'b0   : cntl__simd__rs0_e1[0]             ;
      cntl__simd__rs0_e1[31:1]          <= (reset_poweron ) ? 31'd0                   : ( start_stOp_operation ) ? stOp_operation                                      : cntl__simd__rs0_e1[31:1]          ;  // `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM ;
      cntl__simd__rs1_e1                <= (reset_poweron ) ? `PE_EXEC_LANE_WIDTH 'd0 : ( start_stOp_operation ) ? execLanesActive                                     : cntl__simd__rs1_e1                ;  // FIXME: Need to use numLanes from OOB packet
    end
`endif

  //----------------------------------------------------------------------------------------------------
  // Downstream OOB FIFO
  //

  //------------------------------------------
  // Assume the STU can flow control, so we will start to send the data by placing n-bit wide transactions in a FIFO then sending the output to the
  // stack bus 
  //
  // From SIMD register FIFO
  //
  // Put in a generate in case we decide to extend to multiple downstream lanes

  genvar gvi;
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Sti_OOB_Fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_cntl       ;
        wire   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]         write_type       ;
        wire   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]         write_data       ;
        reg                                               write            ; 
                                                                           
        // Read data                                                       
        wire                                              pipe_valid       ; 
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         pipe_cntl        ;
        wire   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]         pipe_type        ;
        wire   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]         pipe_data        ;
        wire                                              pipe_read        ; 

        // Control
        wire                                              almost_full      ; 
        wire                                              clear            ; 

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`PE_CNTL_OOB_RX_FIFO_DEPTH     ), 
                                .GENERIC_FIFO_THRESHOLD  (`PE_CNTL_OOB_RX_FIFO_THRESHOLD ),
                                .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`STACK_DOWN_OOB_INTF_TYPE_WIDTH+`STACK_DOWN_OOB_INTF_DATA_WIDTH )
                        ) gpfifo (
                                 // Status
                                .almost_full      ( almost_full           ),
                                 // Write                                 
                                .write            ( write                 ),
                                .write_data       ( {write_cntl, write_type, write_data} ),
                                 // Read                                  
                                .pipe_valid       ( pipe_valid                 ),
                                .pipe_data        ( { pipe_cntl,  pipe_type,  pipe_data} ),
                                .pipe_read        ( pipe_read                  ),

                                // General
                                .clear            ( clear                 ),
                                .reset_poweron    ( reset_poweron         ),
                                .clk              ( clk                   )
                                );

        wire  pipe_som  = (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM) || (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)  ;
        wire  pipe_mom  = (pipe_cntl == `COMMON_STD_INTF_CNTL_MOM)                              ;
        wire  pipe_eom  = (pipe_cntl == `COMMON_STD_INTF_CNTL_EOM) || (pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)  ;
      end
  endgenerate

  assign from_Sti_OOB_Fifo[0].clear      =   1'b0                         ;
  assign from_Sti_OOB_Fifo[0].write      =   sti__cntl__oob_valid_d1      ;
  assign from_Sti_OOB_Fifo[0].write_cntl =   sti__cntl__oob_cntl_d1       ;
  assign from_Sti_OOB_Fifo[0].write_type =   sti__cntl__oob_type_d1       ;
  assign from_Sti_OOB_Fifo[0].write_data =   sti__cntl__oob_data_d1       ;
         
  assign cntl__sti__oob_ready_e1         = ~from_Sti_OOB_Fifo[0].almost_full ;




  //----------------------------------------------------------------------------------------------------
  // Downstream OOB Packet Processing FSM
  //

  wire                                    local_stOp_cntl_fifo_ready      ;

  reg [`PE_CNTL_OOB_RX_CNTL_STATE_RANGE ] pe_cntl_oob_rx_cntl_state      ; // state flop
  reg [`PE_CNTL_OOB_RX_CNTL_STATE_RANGE ] pe_cntl_oob_rx_cntl_state_next ;
  
  

  // State register 
  always @(posedge clk)
    begin
      pe_cntl_oob_rx_cntl_state <= ( reset_poweron ) ? `PE_CNTL_OOB_RX_CNTL_WAIT       :
                                                       pe_cntl_oob_rx_cntl_state_next  ;
    end
  
  // Every cycle of the OOB packet, examine each {option, value} tuple and set local config
  // Once the packet has completed, initiate the command.
  // Note: a) we might choose to start commands such as stOp as soon as the tuple is observed
  //       b) FIXME:There is currentlyno checking to see if a option is repeated or if an option is invalid
  //       c) Make error checking more robust as this is an external interface
  //
  //       FIXME: I am adding what might be redundant states as I suspect coordinating stOp's and SIMD might take a few states
 
  always @(*)
    begin
      case (pe_cntl_oob_rx_cntl_state)

        
        `PE_CNTL_OOB_RX_CNTL_WAIT: 
          pe_cntl_oob_rx_cntl_state_next =  ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `PE_CNTL_OOB_RX_CNTL_SOM          :  // start processing command
                                            ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `PE_CNTL_OOB_RX_CNTL_START_CMD    :  // initiate command
                                            ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `PE_CNTL_OOB_RX_CNTL_ERR          :  // error
                                            ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `PE_CNTL_OOB_RX_CNTL_ERR          :  // error
                                                                                                                                                      `PE_CNTL_OOB_RX_CNTL_WAIT         ;
  

        `PE_CNTL_OOB_RX_CNTL_SOM: // start of message
          pe_cntl_oob_rx_cntl_state_next =  ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `PE_CNTL_OOB_RX_CNTL_MOM          :  // continue processing command
                                            ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `PE_CNTL_OOB_RX_CNTL_START_CMD    :  // initiate command
                                            ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `PE_CNTL_OOB_RX_CNTL_ERR          :  // error
                                            ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `PE_CNTL_OOB_RX_CNTL_ERR          :  // error
                                                                                                                                                      `PE_CNTL_OOB_RX_CNTL_SOM          ;

        `PE_CNTL_OOB_RX_CNTL_MOM: // middle of message
          pe_cntl_oob_rx_cntl_state_next =  ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `PE_CNTL_OOB_RX_CNTL_MOM          :  // continue processing command
                                            ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `PE_CNTL_OOB_RX_CNTL_START_CMD    :  // initiate command
                                            ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `PE_CNTL_OOB_RX_CNTL_ERR          :  // error
                                            ( from_Sti_OOB_Fifo[0].pipe_valid && (from_Sti_OOB_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `PE_CNTL_OOB_RX_CNTL_ERR          :  // error
                                                                                                                                                      `PE_CNTL_OOB_RX_CNTL_SOM          ;


        // Transition directly to wait complete so this will create a pulse and the option tuple has been latched
        // This state generates a pulse, so beware of adding conditions
        `PE_CNTL_OOB_RX_CNTL_START_CMD:
          pe_cntl_oob_rx_cntl_state_next =   `PE_CNTL_OOB_RX_CNTL_COMPLETE ;  // 
          //pe_cntl_oob_rx_cntl_state_next =   `PE_CNTL_OOB_RX_CNTL_OP_RUNNING ;  // 
/*
        // make sure the operations have started to allow for some time for simd and/or stOp to get started
        `PE_CNTL_OOB_RX_CNTL_OP_RUNNING:
          pe_cntl_oob_rx_cntl_state_next =   ( stOp_complete            ) ? `PE_CNTL_OOB_RX_CNTL_WAIT_COMPLETE_DEASSERTED  :  // 
                                                                            `PE_CNTL_OOB_RX_CNTL_OP_RUNNING     ;  // 

        `PE_CNTL_OOB_RX_CNTL_WAIT_COMPLETE_DEASSERTED:
          pe_cntl_oob_rx_cntl_state_next =   ( stOp_complete            ) ? `PE_CNTL_OOB_RX_CNTL_WAIT_COMPLETE_DEASSERTED         :  // 
                                                                            `PE_CNTL_OOB_RX_CNTL_COMPLETE    ;  // 
*/
        `PE_CNTL_OOB_RX_CNTL_COMPLETE:
          pe_cntl_oob_rx_cntl_state_next =   ( simd__cntl__tag_ready_d1 && local_stOp_cntl_fifo_ready      ) ? `PE_CNTL_OOB_RX_CNTL_WAIT        :  // 
                                                                                                               `PE_CNTL_OOB_RX_CNTL_COMPLETE    ;  // if the simd isnt ready for the tag, dont perform the next operation

        // Latch state on error
        `PE_CNTL_OOB_RX_CNTL_ERR:
          pe_cntl_oob_rx_cntl_state_next = `PE_CNTL_OOB_RX_CNTL_ERR ;
  
        default:
          pe_cntl_oob_rx_cntl_state_next = `PE_CNTL_OOB_RX_CNTL_WAIT ;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //
 
  assign from_Sti_OOB_Fifo[0].pipe_read = (pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_WAIT) & from_Sti_OOB_Fifo[0].pipe_valid |
                                          (pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_SOM ) & from_Sti_OOB_Fifo[0].pipe_valid |
                                          (pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_MOM ) & from_Sti_OOB_Fifo[0].pipe_valid ;

/*
  assign stOp_option_memory[0].enable_memory = (pe_cntl_oob_rx_cntl_state != `PE_CNTL_OOB_RX_CNTL_WAIT) ;

  always @(*)
    begin
  
      start_stOp_operation    = (pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_START_CMD               ) & contained_stOp ;
      stop_stOp_operation     = (pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_WAIT_COMPLETE_DEASSERTED) & contained_stOp ;
      start_simd_operation    = (pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_START_CMD               ) & contained_simd ;
      stop_simd_operation     = (pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_WAIT_COMPLETE_DEASSERTED) & contained_simd ;

    end
*/
  // examine {option, value} tuples and set local fields
  always @(posedge clk)
    begin
      contained_stOp           <=  ( reset_poweron                                                                                                               ) ? 1'b0           :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_RANGE] == STD_PACKET_OOB_OPT_STOP_CMD)) ? 1'b1           :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_RANGE] == STD_PACKET_OOB_OPT_STOP_CMD)) ? 1'b1           :
                                   ((pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_COMPLETE                                                                 )) ? 1'b0           :  // clear when packet and operation complete
                                                                                                                                                                     contained_stOp ;

      contained_simd           <=  ( reset_poweron                                                                                                               ) ? 1'b0           :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_RANGE] == PY_WU_INST_OPT_TYPE_SIMDOP)) ? 1'b1           :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_RANGE] == PY_WU_INST_OPT_TYPE_SIMDOP)) ? 1'b1           :
                                   ((pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_COMPLETE                                                                 )) ? 1'b0           :  // clear when packet and operation complete
                                                                                                                                                                     contained_simd ;



      // pointer to stOp operation control memory
      stOp_optionPtr           <=  ( reset_poweron                                                                                                               ) ?  'd0                                                            :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_RANGE] == STD_PACKET_OOB_OPT_STOP_CMD)) ? from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_DATA_RANGE] :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_RANGE] == STD_PACKET_OOB_OPT_STOP_CMD)) ? from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_DATA_RANGE] :
                                                                                                                                                                     stOp_optionPtr                                                  ;

      // FIXME
      simd_optionPtr           <=  ( reset_poweron                                                                                                               ) ?  'd0                                                            :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_RANGE] == PY_WU_INST_OPT_TYPE_SIMDOP)) ? from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_DATA_RANGE] :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_RANGE] == PY_WU_INST_OPT_TYPE_SIMDOP)) ? from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_DATA_RANGE] :
                                                                                                                                                                     simd_optionPtr                                                  ;


      tag                      <=  ( reset_poweron                                                                                                               ) ?  'd0                                                            :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_RANGE] ==  STD_PACKET_OOB_OPT_TAG )) ? from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_DATA_RANGE] :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_RANGE] ==  STD_PACKET_OOB_OPT_TAG )) ? from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_DATA_RANGE] :
                                                                                                                                                                     tag                                                             ;

      // if we dont get a number of active lanes, assume all are active, set all active at begining of oob packet
      numberOfActiveLanes      <=  ( reset_poweron                                                                                                                     ) ?  'd `PE_NUM_OF_EXEC_LANES                                       : 
                                   ( oob_packet_starting                                                                                                               ) ?  'd `PE_NUM_OF_EXEC_LANES                                       :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_RANGE] == STD_PACKET_OOB_OPT_NUM_LANES  )) ? from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION0_DATA_RANGE] :
                                   ( from_Sti_OOB_Fifo[0].pipe_valid  && (from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_RANGE] == STD_PACKET_OOB_OPT_NUM_LANES  )) ? from_Sti_OOB_Fifo[0].pipe_data[`PE_CNTL_OOB_OPTION1_DATA_RANGE] :
                                                                                                                                                                           numberOfActiveLanes                                             ;


    end


  //----------------------------------------------------------------------------------------------------
  // stOp Tag/operation FIFO to simd_wrapper
  //

  wire transfer_operations       =  (pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_START_CMD) & simd__cntl__tag_ready_d1 & local_stOp_cntl_fifo_ready  ; // & (stOp_operation[`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE ] == `STREAMING_OP_CNTL_OPERATION_FP_MAC ) ;  // FIXME : may need to handle tags in simd

  assign oob_packet_starting     = (pe_cntl_oob_rx_cntl_state == `PE_CNTL_OOB_RX_CNTL_WAIT) & (pe_cntl_oob_rx_cntl_state_next != `PE_CNTL_OOB_RX_CNTL_WAIT) ;  // transitioning out of WAIT

  assign cntl__simd__tag            =  tag                 ;
  assign cntl__simd__tag_num_lanes  =  numberOfActiveLanes ;  // number of active lanes associated with this tag

  // send the tag as soon as we start the operations 
  //   - only send tags whose operations are FPMAC
  //   - this assumes we only use FPMAC operations that send a result to a reg in the simd

  assign cntl__simd__tag_valid   = transfer_operations  ;

  assign cntl__simd__tag_optionPtr  =  simd_optionPtr                 ;


  //----------------------------------------------------------------------------------------------------
  // stOp Tag/operation FIFO to local stOp FSM
  //

  reg   [`PE_EXEC_LANES_VEC_RANGE        ]          pipe_tag_lane_valid ;  // bitmask of active lanes for this operation

  // Put in a generate in case we decide to extend to multiple fifo's
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Cntl_Tag_Fifo

        // Write data
        wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]          write_tag           ;
        wire   [`PE_CNTL_OOB_OPTION_RANGE       ]          write_tag_optionPtr ; 
        wire   [`PE_NUM_LANES_RANGE             ]          write_tag_num_lanes ;  // number of active lanes associated with this tag
                                                 
        // Read data                              
        wire                                               pipe_valid          ; 
        wire                                               pipe_read           ; 
        wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]          pipe_tag            ;
        wire   [`PE_CNTL_OOB_OPTION_RANGE       ]          pipe_tag_optionPtr  ; 
        wire   [`PE_NUM_LANES_RANGE             ]          pipe_tag_num_lanes  ;  // number of active lanes associated with this tag

        // Control
        wire                                               clear               ; 
        wire                                               almost_full         ; 
        wire                                               write               ; 

        // FIXME: Combine FIFO's for synthesis
        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH (`PE_CNTL_TAG_FROM_CNTL_FIFO_DEPTH                 ), 
                       .GENERIC_FIFO_THRESHOLD       (`PE_CNTL_TAG_FROM_CNTL_FIFO_ALMOST_FULL_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH      (`PE_CNTL_TAG_FROM_CNTL_AGGREGATE_FIFO_WIDTH       )
                        ) gpfifo (
                                          // Status
                                         .almost_full      ( almost_full                      ),
                                          // Write                                            
                                         .write            ( write                            ),
                                         .write_data       ( {write_tag_optionPtr, write_tag_num_lanes, write_tag} ),
                                          // Read                                          
                                         .pipe_valid       ( pipe_valid                       ),
                                         .pipe_read        ( pipe_read                        ),
                                         .pipe_data        ( {pipe_tag_optionPtr, pipe_tag_num_lanes, pipe_tag}   ),
                                                                                              
                                         // General                                           
                                         .clear            ( clear                            ),
                                         .reset_poweron    ( reset_poweron                    ),
                                         .clk              ( clk                              )
                                         );

        assign write                      =   transfer_operations            ;
        assign write_tag                  =   tag                            ;
        assign write_tag_optionPtr        =   stOp_optionPtr                 ;
        assign write_tag_num_lanes        =   numberOfActiveLanes            ;
        assign clear                      =   1'b0                           ;  // just in case

        //assign pipe_read = pipe_valid ;
      end
  endgenerate

  assign local_stOp_cntl_fifo_ready   =  ~from_Cntl_Tag_Fifo[0].almost_full ;

  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES ; lane++)
      begin
        always @(*)
          begin
            pipe_tag_lane_valid [lane]  =  ((lane+1) <= from_Cntl_Tag_Fifo[0].pipe_tag_num_lanes) ;
          end
      end
  endgenerate


  //----------------------------------------------------------------------------------------------------
  // stOp control FSM
  //

  reg [`PE_CNTL_STOP_CNTL_STATE_RANGE ] pe_cntl_stOp_cntl_state      ; // state flop
  reg [`PE_CNTL_STOP_CNTL_STATE_RANGE ] pe_cntl_stOp_cntl_state_next ;
  
  

  // State register 
  always @(posedge clk)
    begin
      pe_cntl_stOp_cntl_state <= ( reset_poweron ) ? `PE_CNTL_STOP_CNTL_WAIT       :
                                                       pe_cntl_stOp_cntl_state_next  ;
    end
  
  // Every cycle of the OOB packet, examine each {option, value} tuple and set local config
  // Once the packet has completed, initiate the command.
  // Note: a) we might choose to start commands such as stOp as soon as the tuple is observed
  //       b) FIXME:There is currentlyno checking to see if a option is repeated or if an option is invalid
  //       c) Make error checking more robust as this is an external interface
  //
  //       FIXME: I am adding what might be redundant states as I suspect coordinating stOp's and SIMD might take a few states
 
  always @(*)
    begin
      case (pe_cntl_stOp_cntl_state)

        
        `PE_CNTL_STOP_CNTL_WAIT: 
          pe_cntl_stOp_cntl_state_next =  ( from_Cntl_Tag_Fifo[0].pipe_valid ) ? `PE_CNTL_STOP_CNTL_READ_STOP_MEMORY :  
                                                                                 `PE_CNTL_STOP_CNTL_WAIT         ;
  


        `PE_CNTL_STOP_CNTL_READ_STOP_MEMORY:
          pe_cntl_stOp_cntl_state_next =   `PE_CNTL_STOP_CNTL_START_CMD ;  // initiate command

        // Transition directly to wait complete so this will create a pulse and the option tuple has been latched
        // This state generates a pulse, so beware of adding conditions
        `PE_CNTL_STOP_CNTL_START_CMD:
          pe_cntl_stOp_cntl_state_next =   `PE_CNTL_STOP_CNTL_OP_RUNNING ;  // 

        // make sure the operations have started to allow for some time for simd and/or stOp to get started
        `PE_CNTL_STOP_CNTL_OP_RUNNING:
          pe_cntl_stOp_cntl_state_next =   ( stOp_complete            ) ? `PE_CNTL_STOP_CNTL_WAIT_COMPLETE_DEASSERTED  :  // 
                                                                            `PE_CNTL_STOP_CNTL_OP_RUNNING     ;  // 

        `PE_CNTL_STOP_CNTL_WAIT_COMPLETE_DEASSERTED:
          pe_cntl_stOp_cntl_state_next =   ( stOp_complete            ) ? `PE_CNTL_STOP_CNTL_WAIT_COMPLETE_DEASSERTED         :  // 
                                                                            `PE_CNTL_STOP_CNTL_COMPLETE    ;  // 

        `PE_CNTL_STOP_CNTL_COMPLETE:
          pe_cntl_stOp_cntl_state_next =                                    `PE_CNTL_STOP_CNTL_WAIT    ;  

        // Latch state on error
        `PE_CNTL_STOP_CNTL_ERR:
          pe_cntl_stOp_cntl_state_next = `PE_CNTL_STOP_CNTL_ERR ;
  
        default:
          pe_cntl_stOp_cntl_state_next = `PE_CNTL_STOP_CNTL_WAIT ;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //
  

  assign   from_Cntl_Tag_Fifo[0].pipe_read =  (pe_cntl_stOp_cntl_state == `PE_CNTL_STOP_CNTL_COMPLETE);
  always @(*)
    begin
  
      start_stOp_operation    = (pe_cntl_stOp_cntl_state == `PE_CNTL_STOP_CNTL_START_CMD               )  ;
      stop_stOp_operation     = (pe_cntl_stOp_cntl_state == `PE_CNTL_STOP_CNTL_WAIT_COMPLETE_DEASSERTED)  ;
      start_simd_operation    = (pe_cntl_stOp_cntl_state == `PE_CNTL_STOP_CNTL_START_CMD               )  ;
      stop_simd_operation     = (pe_cntl_stOp_cntl_state == `PE_CNTL_STOP_CNTL_WAIT_COMPLETE_DEASSERTED)  ;

    end

  // activate lanes. Number of lanes start from '0'
  always @(*)
    begin
      case(from_Cntl_Tag_Fifo[0].pipe_tag_num_lanes)
        `include "pe_cntl_lane_enable_assignments.vh"
        default:
          begin
            execLanesActive  = 'd0     ;
          end
      endcase
    end


  //----------------------------------------------------------------------------------------------------
  // StreamingOp configuration memory
  //
  //  - stOp fields are accessed by a pointer provided in the OOB {option,value} tuple
  //
  
  generate
    for (gvi=0; gvi<1 ; gvi=gvi+1) 
      begin: stOp_option_memory
  
        wire enable_memory ;

        generic_1port_memory #(.GENERIC_MEM_DEPTH          (`PE_CNTL_STOP_OPTION_MEMORY_DEPTH           ),
                               .GENERIC_MEM_REGISTERED_OUT (0                                           ),
                               .GENERIC_MEM_DATA_WIDTH     (`PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_WIDTH )
                        ) gmemory ( 
                        
                        //---------------------------------------------------------------
                        // Initialize
                        //
                        `ifndef SYNTHESIS
                           .memFile (""),
                        `endif

                        //---------------------------------------------------------------
                        // Port 
                        .portA_address       ( from_Cntl_Tag_Fifo[0].pipe_tag_optionPtr       ),
                        .portA_write_data    ( {`PE_CNTL_STOP_OPTION_AGGREGATE_MEMORY_WIDTH {1'b0}} ),
                        .portA_read_data     ( { stOp_operation       ,                                                     
                                                 sourceAddress0       ,
                                                 destinationAddress0  ,
                                                 src_data_type0       ,
                                                 dest_data_type0      ,
                                                 sourceAddress1       ,
                                                 destinationAddress1  ,
                                                 src_data_type1       ,
                                                 dest_data_type1      ,
                                                 numberOfOperands     }),
                        .portA_enable        ( enable_memory                    ),
                        .portA_write         ( 1'b0                             ),
                        
                        //---------------------------------------------------------------
                        // General
                        .reset_poweron       ( reset_poweron             ),
                        .clk                 ( clk                       )
                        ) ;
  // Note: parameters must be fixed, so have to load directly
  //defparam gmemory.GENERIC_MEM_INIT_FILE   =    $sformatf("./inputFiles/manager_%0d_layer1_storageDescriptor_readmem.dat", sys__mgr__mgrId);
        `ifndef SYNTHESIS

          always
            begin
              @(posedge enable_memory)
                //$readmemh($sformatf("./inputFiles/pe%0d_pe_cntl_stOp_memory.dat", sys__pe__peId), gmemory.mem);
                ->gmemory.loadMemory;
            end

        `endif
      end
  endgenerate

  assign stOp_option_memory[0].enable_memory = (pe_cntl_stOp_cntl_state != `PE_CNTL_STOP_CNTL_WAIT) ;

/*
  pe_cntl_stOp_rom pe_cntl_stOp_rom (  
                                     .valid                 ( oob_packet_starting  ),  // used by readmem. If we are receiving a WU, update control memory
                                     .optionPtr             ( stOp_optionPtr       ),
                                                                                  
                                     .stOp_operation        ( stOp_operation       ),
                                                                                  
                                     .sourceAddress0        ( sourceAddress0       ),
                                     .destinationAddress0   ( destinationAddress0  ),
                                     .src_data_type0        ( src_data_type0       ),
                                     .dest_data_type0       ( dest_data_type0      ),
                                                                                  
                                     .sourceAddress1        ( sourceAddress1       ),
                                     .destinationAddress1   ( destinationAddress1  ),
                                     .src_data_type1        ( src_data_type1       ),
                                     .dest_data_type1       ( dest_data_type1      ),
                                                                                  
                                     .numberOfOperands      ( numberOfOperands     ),
                                
                                     .sys__pe__peId         ( sys__pe__peId        ),
                                     .clk
                                  );
*/


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  //
 
endmodule


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------

`ifndef SYNTHESIS

//----------------------------------------------------------------------------------------------------
// PE control memory
//
// Contains the configuration for the SIMD and streamingOp. The OOB packet from the
// manager indexes this memories to control the stOp and simd.
//
// The OOB packet from the manager contains PE specific information in the form of a pointer into these memories The pointer is extracted from the
// {option, value} tuples in the oob data.
// Note: we currently assume we only need PE specific data and things like number of operands and addresses are common.
// 
module pe_cntl_stOp_rom (  
                           valid                       ,
                           optionPtr                   ,

                           stOp_operation              ,
                                                 
                           sourceAddress0              ,
                           destinationAddress0         ,
                           src_data_type0              ,
                           dest_data_type0             ,
                                                 
                           sourceAddress1              ,
                           destinationAddress1         ,
                           src_data_type1              ,
                           dest_data_type1             ,
                                                 
                           numberOfOperands            ,

                           sys__pe__peId               ,

                           clk
                        );

    input                                           clk                        ;
    input                                           valid                      ;
    input  [`PE_PE_ID_RANGE                    ]    sys__pe__peId              ;

    input  [`PE_CNTL_OOB_OPTION_RANGE          ]    optionPtr                  ; 
    
    output [`STREAMING_OP_CNTL_OPERATION_RANGE ]    stOp_operation             ;  

    output [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress0             ;  
    output [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress0        ;  
    output [`PE_DATA_TYPES_RANGE               ]    src_data_type0             ;
    output [`PE_DATA_TYPES_RANGE               ]    dest_data_type0            ;

    output [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress1             ;  
    output [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress1        ;  
    output [`PE_DATA_TYPES_RANGE               ]    src_data_type1             ;
    output [`PE_DATA_TYPES_RANGE               ]    dest_data_type1            ;

    output [`PE_MAX_NUM_OF_TYPES_RANGE         ]    numberOfOperands           ;

    
    reg [`STREAMING_OP_CNTL_OPERATION_RANGE ]    stOp_cntl_memory_stOp_operation          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  

    reg [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    stOp_cntl_memory_sourceAddress0          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  
    reg [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    stOp_cntl_memory_destinationAddress0     [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  
    reg [`PE_DATA_TYPES_RANGE               ]    stOp_cntl_memory_src_data_type0          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;
    reg [`PE_DATA_TYPES_RANGE               ]    stOp_cntl_memory_dest_data_type0         [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;

    reg [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    stOp_cntl_memory_sourceAddress1          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  
    reg [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    stOp_cntl_memory_destinationAddress1     [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;  
    reg [`PE_DATA_TYPES_RANGE               ]    stOp_cntl_memory_src_data_type1          [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;
    reg [`PE_DATA_TYPES_RANGE               ]    stOp_cntl_memory_dest_data_type1         [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;

    reg [`PE_MAX_NUM_OF_TYPES_RANGE         ]    stOp_cntl_memory_numberOfOperands        [`PE_CNTL_STOP_OPTION_MEMORY_RANGE ]      ;
    
    // The memory is updated using the testbench, so everytime we see an option, reload the memory
    always @(posedge valid) 
      begin
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_stOp_operation.dat"      , sys__pe__peId) ,   stOp_cntl_memory_stOp_operation      );

        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress0.dat"      , sys__pe__peId) ,   stOp_cntl_memory_sourceAddress0      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress0.dat" , sys__pe__peId) ,   stOp_cntl_memory_destinationAddress0 );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type0.dat"      , sys__pe__peId) ,   stOp_cntl_memory_src_data_type0      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type0.dat"     , sys__pe__peId) ,   stOp_cntl_memory_dest_data_type0     );

        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_sourceAddress1.dat"      , sys__pe__peId) ,   stOp_cntl_memory_sourceAddress1      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_destinationAddress1.dat" , sys__pe__peId) ,   stOp_cntl_memory_destinationAddress1 );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_src_data_type1.dat"      , sys__pe__peId) ,   stOp_cntl_memory_src_data_type1      );
        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_dest_data_type1.dat"     , sys__pe__peId) ,   stOp_cntl_memory_dest_data_type1     );

        $readmemh($sformatf("./inputFiles/pe%0d_stOp_cntl_memory_numberOfOperands.dat"    , sys__pe__peId) ,   stOp_cntl_memory_numberOfOperands    );
      end
    
    
    // 
    reg    [`STREAMING_OP_CNTL_OPERATION_RANGE ]    stOp_operation             ;  

    reg    [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress0             ;  
    reg    [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress0        ;  
    reg    [`PE_DATA_TYPES_RANGE               ]    src_data_type0             ;
    reg    [`PE_DATA_TYPES_RANGE               ]    dest_data_type0            ;

    reg    [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    sourceAddress1             ;  
    reg    [`PE_ARRAY_CHIPLET_ADDRESS_RANGE    ]    destinationAddress1        ;  
    reg    [`PE_DATA_TYPES_RANGE               ]    src_data_type1             ;
    reg    [`PE_DATA_TYPES_RANGE               ]    dest_data_type1            ;

    reg    [`PE_MAX_NUM_OF_TYPES_RANGE         ]    numberOfOperands           ;

    always @(*) 
      begin 
        #0.3  stOp_operation       =  stOp_cntl_memory_stOp_operation       [optionPtr] ;

        #0.3  sourceAddress0       =  stOp_cntl_memory_sourceAddress0       [optionPtr] ;
        #0.3  destinationAddress0  =  stOp_cntl_memory_destinationAddress0  [optionPtr] ;
        #0.3  src_data_type0       =  stOp_cntl_memory_src_data_type0       [optionPtr] ;
        #0.3  dest_data_type0      =  stOp_cntl_memory_dest_data_type0      [optionPtr] ;

        #0.3  sourceAddress1       =  stOp_cntl_memory_sourceAddress1       [optionPtr] ;
        #0.3  destinationAddress1  =  stOp_cntl_memory_destinationAddress1  [optionPtr] ;
        #0.3  src_data_type1       =  stOp_cntl_memory_src_data_type1       [optionPtr] ;
        #0.3  dest_data_type1      =  stOp_cntl_memory_dest_data_type1      [optionPtr] ;

        #0.3  numberOfOperands     =  stOp_cntl_memory_numberOfOperands     [optionPtr] ;
      end

endmodule

`endif
