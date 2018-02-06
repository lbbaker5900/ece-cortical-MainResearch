/*********************************************************************************************

    File name   : simd_upstream_intf.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module interfaces the simd register r128 to the upstream bus.
                  The start of transmission can be controlled via the pe control or the simd.

                 Name: sui

*********************************************************************************************/
    

`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "simd_upstream_intf.vh"


module simd_upstream_intf (

                  //--------------------------------------------------
                  // Stack Upstream interface
                  sui__sti__valid       , 
                  sui__sti__cntl        , 
                  sti__sui__ready       , 
                                        
                  sui__sti__type        , 
                  sui__sti__data        , 
                  sui__sti__oob_data    , 

                  //--------------------------------------------------
                  // Register(s) from simd
                  simd__sui__tag           ,
                  simd__sui__tag_num_lanes ,
                  simd__sui__regs_valid    ,
                  simd__sui__regs_cntl     ,
                  simd__sui__regs          ,
                  simd__sui__send          ,
                  sui__simd__regs_complete ,
                  sui__simd__regs_ready    ,

                  //--------------------------------------------------
                  // General
                  peId                  ,
                  clk                   ,
                  reset_poweron         

    );

  //-------------------------------------------------------------------------------------------
  // General

  input                       clk            ;
  input                       reset_poweron  ;
  input [`PE_PE_ID_RANGE   ]  peId           ; 

  //-------------------------------------------------------------------------------------------
  // Information between SIMD and STI is delineated with SOP and EOP.
  //
  output                                            sui__sti__valid            ;
  output [`COMMON_STD_INTF_CNTL_RANGE   ]           sui__sti__cntl             ;
  input                                             sti__sui__ready            ;
  output [`STACK_UP_INTF_TYPE_RANGE     ]           sui__sti__type             ;  // Control or Data, Vector or scalar
  output [`STACK_UP_INTF_DATA_RANGE     ]           sui__sti__data             ;
  output [`STACK_UP_INTF_OOB_DATA_RANGE ]           sui__sti__oob_data         ;

 
  //-------------------------------------------------------------------------------------------
  // Register File interface
  //
  input  [`STACK_DOWN_OOB_INTF_TAG_RANGE]           simd__sui__tag                                 ;
  input  [`PE_NUM_LANES_RANGE           ]           simd__sui__tag_num_lanes                       ;  // number of active lanes associated with this tag
  input  [`PE_NUM_OF_EXEC_LANES_RANGE   ]           simd__sui__regs_valid                          ;
  input  [`COMMON_STD_INTF_CNTL_RANGE   ]           simd__sui__regs_cntl  [`PE_NUM_OF_EXEC_LANES ] ;
  input  [`PE_EXEC_LANE_WIDTH_RANGE     ]           simd__sui__regs       [`PE_NUM_OF_EXEC_LANES ] ;
  input                                             simd__sui__send                                ;
  output                                            sui__simd__regs_complete                       ;
  output                                            sui__simd__regs_ready                          ;
   
  //-------------------------------------------------------------------------------------------
  // Wires and Register
  //

  wire                                              sui__sti__valid            ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE   ]           sui__sti__cntl             ;
  wire                                              sti__sui__ready            ;
  wire   [`STACK_UP_INTF_TYPE_RANGE     ]           sui__sti__type             ;
  wire   [`STACK_UP_INTF_DATA_RANGE     ]           sui__sti__data             ;
  wire   [`STACK_UP_INTF_OOB_DATA_RANGE ]           sui__sti__oob_data         ;

  wire   [`STACK_DOWN_OOB_INTF_TAG_RANGE]           simd__sui__tag                                 ;
  wire   [`PE_NUM_LANES_RANGE           ]           simd__sui__tag_num_lanes                       ; 
  wire   [`PE_NUM_OF_EXEC_LANES_RANGE   ]           simd__sui__regs_valid                          ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE   ]           simd__sui__regs_cntl  [`PE_NUM_OF_EXEC_LANES ] ;
  wire   [`PE_EXEC_LANE_WIDTH_RANGE     ]           simd__sui__regs       [`PE_NUM_OF_EXEC_LANES ] ;
  reg                                               sui__simd__regs_complete                       ;
  reg                                               sui__simd__regs_ready                          ;


  //-------------------------------------------------------------------------------------------
  // General use assignments
  //  - all inputs must be registered
  //
  reg    [`STACK_DOWN_OOB_INTF_TAG_RANGE]           simd__sui__tag_d1                                 ;
  reg    [`PE_NUM_LANES_RANGE           ]           simd__sui__tag_num_lanes_d1                       ; 
  reg    [`PE_NUM_OF_EXEC_LANES_RANGE   ]           simd__sui__regs_valid_d1                          ;
  reg    [`COMMON_STD_INTF_CNTL_RANGE   ]           simd__sui__regs_cntl_d1  [`PE_NUM_OF_EXEC_LANES ] ;
  reg    [`PE_EXEC_LANE_WIDTH_RANGE     ]           simd__sui__regs_d1       [`PE_NUM_OF_EXEC_LANES ] ;
  reg                                               simd__sui__send_d1                                ;

  reg    [`STACK_DOWN_OOB_INTF_TAG_RANGE]           send_tag                                 ;
  reg    [`PE_NUM_LANES_RANGE           ]           send_tag_num_lanes                       ; 
  reg    [`PE_NUM_OF_EXEC_LANES_RANGE   ]           send_regs_valid                          ;
  reg    [`COMMON_STD_INTF_CNTL_RANGE   ]           send_regs_cntl  [`PE_NUM_OF_EXEC_LANES ] ;
  reg    [`PE_EXEC_LANE_WIDTH_RANGE     ]           send_regs       [`PE_NUM_OF_EXEC_LANES ] ;
  reg                                               send                                     ;
  genvar gvi;
  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES ; gvi=gvi+1) 
      begin: regFile_load
        always @(posedge clk)
          begin
            simd__sui__regs_valid_d1 [gvi]  <=  simd__sui__regs_valid [gvi]  ;
            simd__sui__regs_cntl_d1  [gvi]  <=  simd__sui__regs_cntl  [gvi]  ;
            simd__sui__regs_d1       [gvi]  <=  simd__sui__regs       [gvi]  ;

            send_regs_valid [gvi]  <=  ( simd__sui__send_d1 ) ?  simd__sui__regs_valid_d1 [gvi] : send_regs_valid [gvi] ;
            send_regs_cntl  [gvi]  <=  ( simd__sui__send_d1 ) ?  simd__sui__regs_cntl_d1  [gvi] : send_regs_cntl  [gvi] ;
            send_regs       [gvi]  <=  ( simd__sui__send_d1 ) ?  simd__sui__regs_d1       [gvi] : send_regs       [gvi] ;
          end
      end
  endgenerate

  always @(posedge clk)
    begin
      simd__sui__send_d1            <=  simd__sui__send           ;
      simd__sui__tag_d1             <=  simd__sui__tag            ;
      simd__sui__tag_num_lanes_d1   <=  simd__sui__tag_num_lanes  ;

      send                          <=  simd__sui__send_d1                                                           ;
      send_tag                      <=  ( simd__sui__send_d1 ) ?   simd__sui__tag_d1           : send_tag            ;
      send_tag_num_lanes            <=  ( simd__sui__send_d1 ) ?   simd__sui__tag_num_lanes_d1 : send_tag_num_lanes  ;
    end

  reg                                              sti__sui__ready_d1            ;
  always @(posedge clk)
    begin
      sti__sui__ready_d1         <=  ( reset_poweron ) ? 'd0 : sti__sui__ready   ;
    end


  reg   [`PE_NUM_OF_EXEC_LANES_RANGE  ]   reg_enable           ;  // create a vector of enables
  genvar lane;
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES ; lane++)
      begin
        always @(posedge clk)
          begin
            reg_enable [lane] <= lane < send_tag_num_lanes  ;
          end
      end
  endgenerate

  //------------------------------------------
  // Assume the STU can flow control, so we will start to send the data by placing n-bit wide transactions in a FIFO then sending the output to the
  // stack bus 
  //
  // From SIMD register FIFO
  //
  // Put in a generate in case we decide to extend to multiple upstream lanes

  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: to_Stu_Fifo

        // Write data
        reg  [`STACK_UP_INTF_DATA_LANE_VALID_RANGE ]      write_data_lane_valid        ;  // use to set number of valid data words
  
        reg    [`COMMON_STD_INTF_CNTL_RANGE   ]           write_cntl       ;
        stack_up_type                                     write_type       ;
        //wire   [`STACK_UP_INTF_TYPE_RANGE     ]           write_type       ;
        reg    [`STACK_UP_INTF_DATA_RANGE     ]           write_data       ;  // because assigned in proc
        reg    [`STACK_UP_INTF_OOB_DATA_RANGE ]           write_oob_data   ;

        // Read data
        wire                                              pipe_valid       ; 
        wire   [`COMMON_STD_INTF_CNTL_RANGE   ]           pipe_cntl        ;
        wire   [`STACK_UP_INTF_TYPE_RANGE     ]           pipe_type        ;
        wire   [`STACK_UP_INTF_DATA_RANGE     ]           pipe_data        ;
        wire   [`STACK_UP_INTF_OOB_DATA_RANGE ]           pipe_oob_data    ;
        wire                                              pipe_read        ; 

        // Control
        wire                                              clear            ; 
        wire                                              almost_full      ; 
        wire                                              write            ; 

        generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      (`SIMD_TO_STI_FIFO_DEPTH     ), 
                                 .GENERIC_FIFO_THRESHOLD  (`SIMD_TO_STI_FIFO_THRESHOLD ),
                                 .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`STACK_UP_INTF_TYPE_WIDTH+`STACK_UP_INTF_DATA_WIDTH+`STACK_UP_INTF_OOB_DATA_WIDTH )
                        ) gpfifo (
                                          // Status
                                         .almost_full      ( almost_full                                          ),
                                          // Write
                                         .write            ( write                                                ),
                                         .write_data       ( {write_cntl, write_type, write_data, write_oob_data} ),
                                          // Read
                                         .pipe_valid       ( pipe_valid                                           ),
                                         .pipe_read        ( pipe_read                                            ),
                                         .pipe_data        ( { pipe_cntl,  pipe_type,  pipe_data,  pipe_oob_data} ),

                                         // General
                                         .clear            ( clear                                                ),
                                         .reset_poweron    ( reset_poweron                                        ),
                                         .clk              ( clk                                                  )
                                         );

        assign pipe_read = sti__sui__ready_d1 & pipe_valid ; // read if stack interface is ready

      end
  endgenerate

  assign to_Stu_Fifo[0].clear      = 1'b0                         ;
  assign sui__sti__valid           = to_Stu_Fifo[0].pipe_read     ;
  assign sui__sti__cntl            = to_Stu_Fifo[0].pipe_cntl     ;
  assign sui__sti__type            = to_Stu_Fifo[0].pipe_type     ;
  assign sui__sti__data            = to_Stu_Fifo[0].pipe_data     ;
  assign sui__sti__oob_data        = to_Stu_Fifo[0].pipe_oob_data ;


  //----------------------------------------------------------------------------------------------------
  // Controller fsm for transfers between the array of registers from the simd and the fifo to the stack up interface
  
  reg [`SIMD_TO_STI_CNTL_STATE_RANGE ] simd_to_sti_cntl_state     ; // state flop
  reg [`SIMD_TO_STI_CNTL_STATE_RANGE ] simd_to_sti_cntl_state_next;
  
  // we will transfer (stack up data width divided by exec lane reg width) cycles
  reg  [`SIMD_TO_STI_NUM_OF_TRANSFERS_RANGE  ]   sui2stiTransferCount   ;  // counter for number of transfers between registers and sti fifo


  // State register 
  always @(posedge clk)
    begin
      simd_to_sti_cntl_state <= ( reset_poweron ) ? `SIMD_TO_STI_CNTL_WAIT       :
                                                    simd_to_sti_cntl_state_next  ;
    end
  
  // FIXME: Does this need to be based on number of active lanes?
  //wire sendUpstreamPkt = |simd__sui__regs_valid_d1 ; // assume all regs must be ready at the same time
  wire sendUpstreamPkt = send  ; // may need to send dummy return packet

  always @(*)
    begin
      case (simd_to_sti_cntl_state)

        // If all registers are loaded, start transfer
        // for the two transactions we generate from one system transction
        // We wont stall the transfer once we have started.
        
        `SIMD_TO_STI_CNTL_WAIT: 
          simd_to_sti_cntl_state_next =  ( sendUpstreamPkt && ~to_Stu_Fifo[0].almost_full )  ? `SIMD_TO_STI_CNTL_MOM    :  // start transfer
                                                                                               `SIMD_TO_STI_CNTL_WAIT   ;
  

        `SIMD_TO_STI_CNTL_MOM: // MOM ~ middle of message
          simd_to_sti_cntl_state_next = ( sui2stiTransferCount == (`SIMD_TO_STI_NUM_OF_TRANSFERS-2) )  ? `SIMD_TO_STI_CNTL_EOM :  // need to transition to EOM one cycle before the end
                                                                                                         `SIMD_TO_STI_CNTL_MOM ;

        `SIMD_TO_STI_CNTL_EOM: 
          simd_to_sti_cntl_state_next = ( ~to_Stu_Fifo[0].almost_full          ) ? `SIMD_TO_STI_CNTL_COMPLETE :  
                                                                                   `SIMD_TO_STI_CNTL_EOM      ;
  
        `SIMD_TO_STI_CNTL_COMPLETE:
          simd_to_sti_cntl_state_next =  ( ~sendUpstreamPkt )  ? `SIMD_TO_STI_CNTL_WAIT         :  // wait for reg valid to be deasserted by simd_wrapper
                                                              `SIMD_TO_STI_CNTL_COMPLETE     ;

        `SIMD_TO_STI_CNTL_ERROR:
          simd_to_sti_cntl_state_next = `SIMD_TO_STI_CNTL_ERROR ;
  
        default:
          simd_to_sti_cntl_state_next = `SIMD_TO_STI_CNTL_WAIT ;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  
  //-------------------------------------------------------------------------------------------------
  // fsm signals
  always @(posedge clk)
    begin
  
      sui2stiTransferCount   <= ( reset_poweron                                                                                         )  ? 'd0                     :
                                ((simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_WAIT ) && sendUpstreamPkt && ~to_Stu_Fifo[0].almost_full  )  ? sui2stiTransferCount+1  :
                                ((simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_WAIT )                    && ~to_Stu_Fifo[0].almost_full  )  ? 'd0                     :
                                ((simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_MOM  )                    && ~to_Stu_Fifo[0].almost_full  )  ? sui2stiTransferCount+1  :
                                ((simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_EOM  )                    && ~to_Stu_Fifo[0].almost_full  )  ? 'd0                     :
                                                                                                                                             sui2stiTransferCount    ;

      sui__simd__regs_complete  <= ((simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_EOM       ) && ~to_Stu_Fifo[0].almost_full ) | 
                                   ( simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_COMPLETE  )                                  ;  // clear reg valid in simd once we have completed transfer

      sui__simd__regs_ready     <= (simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_WAIT );

    end


  assign to_Stu_Fifo[0].write  = ((simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_WAIT ) && sendUpstreamPkt && ~to_Stu_Fifo[0].almost_full ) |
                                 ((simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_MOM  )                    && ~to_Stu_Fifo[0].almost_full ) |
                                 ((simd_to_sti_cntl_state == `SIMD_TO_STI_CNTL_EOM  )                    && ~to_Stu_Fifo[0].almost_full ) ;

  // mux registers to fifo inputs
  always @(*)
    begin
      to_Stu_Fifo[0].write_cntl   <= (sui2stiTransferCount == 0                               ) ? `COMMON_STD_INTF_CNTL_SOM   :
                                     (sui2stiTransferCount == `SIMD_TO_STI_NUM_OF_TRANSFERS-1 ) ? `COMMON_STD_INTF_CNTL_EOM   :
                                                                                                  `COMMON_STD_INTF_CNTL_MOM   ;
/*
      to_Stu_Fifo[0].write_type   <= (sui2stiTransferCount == 0                               ) ?  STU_PACKET_TYPE_DATA       :
                                                                                                   STU_PACKET_TYPE_NA         ;
*/

      to_Stu_Fifo[0].write_oob_data   <= send_tag   ;

      case  (sui2stiTransferCount )  // synopsys parallel_case
        `include "simd_upstream_intf_register_mux.vh"
      endcase 

    end // always @ (*)

endmodule

