/*********************************************************************************************

    File name   : simd_wrapper.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module takes instantiates the SIMD core and provides conenctions to/from the other PE functions

                  stOp
                    - provides a regFile interface to communicate with the streamingOps
                  Local memory
                    - provides a means to arbittrate for the local memory 

                 Name: simd

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "simd_wrapper.vh"
`include "stack_interface.vh"
`include "noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"




module simd_wrapper (

                          //-------------------------------
                          // PE control configuration to stOp via simd
                          //
                          `include "pe_cntl_simd_ports.vh"

                          //-------------------------------
                          // Configuration output to stOp
                          //
                          `include "pe_simd_ports.vh"

                          //-------------------------------
                          // Additional PE control configuration 
                          cntl__simd__tag_valid    ,
                          cntl__simd__tag          ,
                          simd__cntl__tag_ready    ,

                          //-------------------------------
                          // Result from stOp to regFile (via scntl)
                          scntl__reg__valid        ,
                          scntl__reg__data         ,
                          reg__scntl__ready        ,
                          //`include "simd_wrapper_scntl_to_simd_regfile_ports.vh"

                          //--------------------------------------------------
                          // Register(s) to stack upstream
                          simd__sui__tag           ,
                          simd__sui__regs          ,
                          simd__sui__regs_valid    ,
                          sui__simd__regs_complete ,
                          sui__simd__regs_ready    ,

                          //--------------------------------------------------------
                          // System
                          peId              ,
                          clk               ,
                          reset_poweron     
    );

  input                       clk            ;
  input                       reset_poweron  ;
  input [`PE_PE_ID_RANGE   ]  peId           ; 


  //----------------------------------------------------------------------------------------------------
  // PE control
  input                                              cntl__simd__tag_valid          ;  // tag to simd needs to be a fifo interface as the next stOp may start while the 
  input   [`STACK_DOWN_OOB_INTF_TAG_RANGE]           cntl__simd__tag                ;
  output                                             simd__cntl__tag_ready          ;

  //-------------------------------------------------------------------------------------------
  // Register File interface to stack interface
  //
  output  [`STACK_DOWN_OOB_INTF_TAG_RANGE]           simd__sui__tag                            ;
  output  [`PE_EXEC_LANE_WIDTH_RANGE     ]           simd__sui__regs  [`PE_NUM_OF_EXEC_LANES ] ;
  output  [`PE_NUM_OF_EXEC_LANES_RANGE   ]           simd__sui__regs_valid                     ;
  input                                              sui__simd__regs_complete                  ;
  input                                              sui__simd__regs_ready                     ;
   
  //----------------------------------------------------------------------------------------------------
  // RegFile Outputs to stOp controller

  `include "pe_simd_wrapper_output_port_declarations.vh"

  //----------------------------------------------------------------------------------------------------
  // PE control to stOp via SIMD

  `include "pe_simd_wrapper_input_port_declarations.vh"

  //----------------------------------------------------------------------------------------------------
  // Result from stOp to regFile

  input   [`PE_NUM_OF_EXEC_LANES_RANGE ]      scntl__reg__valid                          ;
  input   [`PE_EXEC_LANE_WIDTH_RANGE   ]      scntl__reg__data  [`PE_NUM_OF_EXEC_LANES ] ;
  output  [`PE_NUM_OF_EXEC_LANES_RANGE ]      reg__scntl__ready                          ;
  //`include "simd_wrapper_scntl_to_simd_regfile_ports_declaration.vh"


  //----------------------------------------------------------------------------------------------------
  // Registers/Wires
  //
  //`include "simd_wrapper_scntl_to_simd_regfile_wires.vh"

  // store in reg before transferring to simd
  reg   [`PE_EXEC_LANE_WIDTH_RANGE     ]  allLanes_results  [`PE_NUM_OF_EXEC_LANES ]      ;
  reg   [`PE_NUM_OF_EXEC_LANES_RANGE   ]  allLanes_valid                                  ;
                                                                                          
  wire  [`STACK_DOWN_OOB_INTF_TAG_RANGE]  simd__sui__tag                                  ;
  wire  [`PE_EXEC_LANE_WIDTH_RANGE     ]  simd__sui__regs   [`PE_NUM_OF_EXEC_LANES ]      ;
  wire  [`PE_NUM_OF_EXEC_LANES_RANGE   ]  simd__sui__regs_valid                           ;
  wire                                    sui__simd__regs_complete                        ;
  reg                                     sui__simd__regs_complete_d1                     ;
  wire                                    sui__simd__regs_ready                           ;
  reg                                     sui__simd__regs_ready_d1                        ;
                                                                                          
  wire                                    cntl__simd__tag_valid                           ;  // tag to simd needs to be a fifo interface as the next stOp may start while the 
  wire  [`STACK_DOWN_OOB_INTF_TAG_RANGE]  cntl__simd__tag                                 ;  // simd is processing the previosu stOp result
  wire                                    simd__cntl__tag_ready                           ;
  reg                                     cntl__simd__tag_valid_d1                        ;
  reg   [`STACK_DOWN_OOB_INTF_TAG_RANGE]  cntl__simd__tag_d1                              ; 

  reg   [`PE_NUM_OF_EXEC_LANES_RANGE   ]  scntl__reg__valid_d1                            ;
  reg   [`PE_EXEC_LANE_WIDTH_RANGE     ]  scntl__reg__data_d1  [`PE_NUM_OF_EXEC_LANES ]   ;
  reg   [`PE_NUM_OF_EXEC_LANES_RANGE   ]  reg__scntl__ready                               ;  // FIXME
  //wire   [`PE_NUM_OF_EXEC_LANES_RANGE   ]  reg__scntl__ready                               ;  // FIXME

  //----------------------------------------------------------------------------------------------------
  // Assignments

  `include "pe_simd_wrapper_assignments.vh"

  assign simd__cntl__tag_ready = 1'b1 ; // FIXME

  //----------------------------------------------------------------------
  // Registered inputs
  always @(posedge clk)
    begin
      sui__simd__regs_complete_d1  <= ( reset_poweron ) ? 'd0 : sui__simd__regs_complete ;
      sui__simd__regs_ready_d1     <= ( reset_poweron ) ? 'd0 : sui__simd__regs_ready    ;

      cntl__simd__tag_valid_d1     <= ( reset_poweron ) ? 'd0 : cntl__simd__tag_valid    ;
      cntl__simd__tag_d1           <= ( reset_poweron ) ? 'd0 : cntl__simd__tag          ;

    end

  genvar gvi;
  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES ; gvi=gvi+1) 
      begin: scntl_input_reg
        always @(posedge clk)
          begin
            scntl__reg__valid_d1 [gvi]  <= ( reset_poweron ) ? 'd0 : scntl__reg__valid [gvi]  ;
            scntl__reg__data_d1  [gvi]  <= ( reset_poweron ) ? 'd0 : scntl__reg__data  [gvi]  ;
          end
      end
  endgenerate

  //----------------------------------------------------------------------
  // Update each lanes regFile with result from streaming operation module 




  //----------------------------------------------------------------------------------------------------
  // Original code

  /*
  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES ; gvi=gvi+1) 
      begin: regFile_load

        always @(posedge clk)
          begin
            allLanes_valid  [gvi]  <=  ( reset_poweron               ) ? 1'd0                    :
                                       ( scntl__reg__valid [gvi]     ) ? 1'b1                    :
                                       ( sui__simd__regs_complete_d1 ) ? 1'b0                    :  // clear when we have transfered regs to stack upstream
                                                                         allLanes_valid[gvi]     ;

            allLanes_results[gvi]  <=  ( reset_poweron           ) ? `PE_EXEC_LANE_WIDTH 'd0 :
                                       ( scntl__reg__valid [gvi] ) ? scntl__reg__data  [gvi] :
                                                                     allLanes_results[gvi]   ;

          end

        assign  simd__sui__regs [gvi]  =  allLanes_results [gvi] ;
      end
  endgenerate
  assign  simd__sui__regs_valid  =  allLanes_valid  ;
  assign  simd__sui__tag         =  cntl__simd__tag ;

  assign  reg__scntl__ready      = {32{1'b1}};
  //`include "simd_wrapper_scntl_to_simd_regfile_assignments.vh"

  */

  // end Original code
  //----------------------------------------------------------------------------------------------------





  //----------------------------------------------------------------------------------------------------
  // Result FIFO
  //
  // We FIFO tags and associated results to allow the SIMD to start operating
  // on one stOp result while the next is being processd
  // This is designed to minimize slack on the stack bus
  //

  // create a vector of the data fifo pipe valid's
  wire [`PE_EXEC_LANE_WIDTH_RANGE      ]  from_stOp_reg_fifo_valids ;
  // create a vector of reads for the FSM
  wire [`PE_EXEC_LANE_WIDTH_RANGE      ]  from_stOp_reg_fifo_reads  ;
  // create a vector of data for the FSM
  wire [`PE_EXEC_LANE_WIDTH_RANGE      ]  from_stOp_reg_fifo_pipe_data [`PE_NUM_OF_EXEC_LANES ]   ;

  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES; gvi=gvi+1) 
      begin: from_StOp_Reg_Fifo

        // Write data
        wire   [`PE_EXEC_LANE_WIDTH_RANGE      ]          write_data       ;
                                                                           
        // Read data                                                       
        wire   [`PE_EXEC_LANE_WIDTH_RANGE      ]          read_data        ;

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`SIMD_WRAP_REG_FROM_SCNTL_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`SIMD_WRAP_REG_FROM_SCNTL_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`PE_EXEC_LANE_WIDTH                      )
                        ) reg_fifo (
                                          // Status
                                         .empty            ( empty                        ),
                                         .almost_full      ( almost_full                  ),
                                          // Write
                                         .write            ( write                        ),
                                         .write_data       ( write_data                   ),
                                          // Read
                                         .read             ( read                         ),
                                         .read_data        ( read_data                    ),

                                         // General
                                         .clear            ( clear                        ),
                                         .reset_poweron    ( reset_poweron                ),
                                         .clk              ( clk                          )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`PE_EXEC_LANE_WIDTH_RANGE       ]            pipe_data         ;
        wire                                                 pipe_read         ;

        assign read           = ~empty          & (~fifo_pipe_valid | fifo_pipe_read) ; // keep the pipe charged
        assign fifo_pipe_read = fifo_pipe_valid & (~pipe_valid      | pipe_read     ) ; 

        // If we are reading the fifo, then this stage will be valid
        // If we are not reading the fifo but the next stage is reading this stage, then this stage will not be valid
        always @(posedge clk)
          begin
            fifo_pipe_valid <= ( reset_poweron      ) ? 'b0               :
                               ( read               ) ? 'b1               :
                               ( fifo_pipe_read     ) ? 'b0               :
                                                         fifo_pipe_valid  ;
          end

        always @(posedge clk)
          begin
            // If we are reading the previous stage, then this stage will be valid
            // otherwise if we are reading this stage this stage will not be valid
            pipe_valid      <= ( reset_poweron      ) ? 'b0              :
                               ( fifo_pipe_read     ) ? 'b1              :
                               ( pipe_read          ) ? 'b0              :
                                                         pipe_valid      ;
        
            // if we are reading, transfer from previous pipe stage. 
            pipe_data       <= ( fifo_pipe_read     ) ? read_data        :
                                                        pipe_data        ;

            // DEBUG reg__scntl_ready [gvi]  <=  ~almost_full                  ;
          end

        assign write                           =   scntl__reg__valid [gvi]   ;
        assign write_data                      =   scntl__reg__data  [gvi]   ;
        assign clear                           =   1'b0                      ;  // just in case

        // The FSM needs a vector of pipe valid signals
        assign from_stOp_reg_fifo_valids    [gvi] = pipe_valid               ; 
        assign from_stOp_reg_fifo_pipe_data [gvi] = pipe_data                ; 

        assign reg__scntl__ready            [gvi] = ~almost_full             ;

        // FSM will drive read for each lane, most likely all together
        assign pipe_read = from_stOp_reg_fifo_reads [gvi]  ;

      end
  endgenerate

         

  //----------------------------------------------------------------------------------------------------
  // Tag FIFO
  //

  // Put in a generate in case we decide to extend to multiple fifo's
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Cntl_Tag_Fifo

        // Write data
        wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]          write_tag       ;
                                                 
        // Read data                              
        wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]          read_tag        ;

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`SIMD_WRAP_TAG_FROM_CNTL_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`SIMD_WRAP_TAG_FROM_CNTL_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`STACK_DOWN_OOB_INTF_TAG_SIZE           )
                        ) reg_fifo (
                                          // Status
                                         .empty            ( empty                        ),
                                         .almost_full      ( almost_full                  ),
                                          // Write
                                         .write            ( write                        ),
                                         .write_data       ( write_tag                    ),
                                          // Read
                                         .read             ( read                         ),
                                         .read_data        ( read_tag                     ),

                                         // General
                                         .clear            ( clear                        ),
                                         .reset_poweron    ( reset_poweron                ),
                                         .clk              ( clk                          )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`STACK_DOWN_OOB_INTF_TAG_RANGE  ]            pipe_tag          ;
        wire                                                 pipe_read         ;

        assign read           = ~empty          & (~fifo_pipe_valid | fifo_pipe_read) ; // keep the pipe charged
        assign fifo_pipe_read = fifo_pipe_valid & (~pipe_valid      | pipe_read     ) ; 

        // If we are reading the fifo, then this stage will be valid
        // If we are not reading the fifo but the next stage is reading this stage, then this stage will not be valid
        always @(posedge clk)
          begin
            fifo_pipe_valid <= ( reset_poweron      ) ? 'b0               :
                               ( read               ) ? 'b1               :
                               ( fifo_pipe_read     ) ? 'b0               :
                                                         fifo_pipe_valid  ;
          end

        always @(posedge clk)
          begin
            // If we are reading the previous stage, then this stage will be valid
            // otherwise if we are reading this stage this stage will not be valid
            pipe_valid      <= ( reset_poweron      ) ? 'b0              :
                               ( fifo_pipe_read     ) ? 'b1              :
                               ( pipe_read          ) ? 'b0              :
                                                         pipe_valid      ;
        
            // if we are reading, transfer from previous pipe stage. 
            pipe_tag        <= ( fifo_pipe_read     ) ?  read_tag        :
                                                         pipe_tag        ;

            // DEBUG simd__cntl__tag_ready <=  ~almost_full                  ;
          end

        assign write                      =   cntl__simd__tag_valid       ;
        assign write_tag                  =   cntl__simd__tag             ;
        assign clear                      =   1'b0                        ;  // just in case

        //
        assign pipe_read = from_stOp_reg_fifo_reads [gvi]  ;

      end
  endgenerate

  

  //----------------------------------------------------------------------------------------------------
  // Upstream  Packet Processing FSM
  //
  // This FSM will be designed to take data from the registers from the stOp and send Upstream packet data to the
  // simd_upstream_intf module to create an upstream packet.
  // Its likely this FSM will take instruction from the SIMD or directly from the pe controller (pe_cntl)
  // For now it immediately takes the stOp result and send it to the simd_upstream_intf  module.
  //
  // Note: We might also want to buffer up more result data before sending
  

  reg [`SIMD_WRAP_UPSTREAM_CNTL_STATE_RANGE ] simd_wrap_upstream_cntl_state      ; // state flop
  reg [`SIMD_WRAP_UPSTREAM_CNTL_STATE_RANGE ] simd_wrap_upstream_cntl_state_next ;
  
  

  // State register 
  always @(posedge clk)
    begin
      simd_wrap_upstream_cntl_state <= ( reset_poweron ) ? `SIMD_WRAP_UPSTREAM_CNTL_WAIT        :
                                                            simd_wrap_upstream_cntl_state_next  ;
    end
  
  // Every cycle of the OOB packet, examine each {option, value} tuple and set local config
  // Once the packet has completed, initiate the command.
  // Note: a) we might choose to start commands such as stOp as soon as the tuple is observed
  //       b) FIXME:There is currentlyno checking to see if a option is repeated or if an option is invalid
  //       c) Make error checking more robust as this is an external interface
  //
  //       FIXME: I am adding what might be redundant states as I suspect coordinating stOp's and SIMD might take a few states
  
  assign tag_and_data_ready =  from_Cntl_Tag_Fifo[0].pipe_valid & (&from_stOp_reg_fifo_valids) ;
 
  always @(*)
    begin
      case (simd_wrap_upstream_cntl_state)

        
        `SIMD_WRAP_UPSTREAM_CNTL_WAIT: 
          simd_wrap_upstream_cntl_state_next =  ( tag_and_data_ready && sui__simd__regs_ready_d1) ? `SIMD_WRAP_UPSTREAM_CNTL_SEND_DATA    :  // start the data transfer to the sui
                                                                                                    `SIMD_WRAP_UPSTREAM_CNTL_WAIT         ;
  

        `SIMD_WRAP_UPSTREAM_CNTL_SEND_DATA: 
          // Assert the valid to the stack upstream interface e.g. pulse
          // The interface to the stack upstream interface isnt a FIFO
          // When the stack interface has sent the data, it will assert complete
          simd_wrap_upstream_cntl_state_next =  `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_COMPLETE          ;


        `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_COMPLETE:
          simd_wrap_upstream_cntl_state_next =   ( sui__simd__regs_complete_d1 ) ? `SIMD_WRAP_UPSTREAM_CNTL_WAIT_COMPLETE_DEASSERTED   : 
                                                                                `SIMD_WRAP_UPSTREAM_CNTL_WAIT_FOR_COMPLETE          ;


        `SIMD_WRAP_UPSTREAM_CNTL_WAIT_COMPLETE_DEASSERTED:
          simd_wrap_upstream_cntl_state_next =   ( ~sui__simd__regs_complete_d1 ) ? `SIMD_WRAP_UPSTREAM_CNTL_WAIT_COMPLETE_DEASSERTED   : 
                                                                                 `SIMD_WRAP_UPSTREAM_CNTL_COMPLETE                   ;

        `SIMD_WRAP_UPSTREAM_CNTL_COMPLETE:
          simd_wrap_upstream_cntl_state_next =   `SIMD_WRAP_UPSTREAM_CNTL_WAIT    ; 

        // Latch state on error
        `SIMD_WRAP_UPSTREAM_CNTL_ERR:
          simd_wrap_upstream_cntl_state_next = `SIMD_WRAP_UPSTREAM_CNTL_ERR ;
  
        default:
          simd_wrap_upstream_cntl_state_next = `SIMD_WRAP_UPSTREAM_CNTL_WAIT ;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //

  // read the FIFO and assert the valid to the stack upstream interface
  assign from_stOp_reg_fifo_reads = {`PE_EXEC_LANE_WIDTH { (simd_wrap_upstream_cntl_state == `SIMD_WRAP_UPSTREAM_CNTL_SEND_DATA) }};

  assign  simd__sui__regs_valid   =  {`PE_EXEC_LANE_WIDTH { (simd_wrap_upstream_cntl_state == `SIMD_WRAP_UPSTREAM_CNTL_SEND_DATA) }};
  assign  simd__sui__tag          =  from_Cntl_Tag_Fifo[0].pipe_tag ;
  assign  simd__sui__regs         =  from_stOp_reg_fifo_pipe_data   ;



  
endmodule

