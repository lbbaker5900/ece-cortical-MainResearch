/*********************************************************************************************

    File name   : oob_downstream_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : Takes SIMD and StOp instruction options and constructs and senda an OOB downdtream packet
                  to the PE.

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "pe_cntl.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "wu_memory.vh"
`include "wu_decode.vh"
`include "oob_downstream_cntl.vh"
`include "python_typedef.vh"


module oob_downstream_cntl (  

            //-------------------------------
            // from WU decoder
            //
            wud__odc__valid             ,
            wud__odc__cntl              ,  
            odc__wud__ready             ,
            wud__odc__tag               ,
            wud__odc__num_lanes         ,
            wud__odc__stOp_cmd          ,
            wud__odc__simd_cmd          ,

            //-------------------------------
            // Stack Bus - OOB Downstream
            //
            // OOB controls how the lanes are interpreted
            mgr__std__oob_cntl          , 
            mgr__std__oob_valid         , 
            std__mgr__oob_ready         , 
            mgr__std__oob_type          , 
            mgr__std__oob_data          , 

            //-------------------------------
            // General
            //
            sys__mgr__mgrId             ,
            clk                         ,
            reset_poweron    
                        );

    //----------------------------------------------------------------------------------------------------
    // General
    
    input                                     clk                          ;
    input                                     reset_poweron                ;
    input   [`MGR_MGR_ID_RANGE    ]           sys__mgr__mgrId              ;


    //-------------------------------------------------------------------------------------------------
    // Stack Bus - OOB Downstream
    
    // OOB carries PE configuration    
    output[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl            ; 
    output                                        mgr__std__oob_valid           ; 
    input                                         std__mgr__oob_ready           ; 
    output[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type            ; 
    output[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data            ; 

    //-------------------------------------------------------------------------------------------------
    // WU Decoder
    //
    input                                          wud__odc__valid         ;
    input   [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__odc__cntl          ;
    output                                         odc__wud__ready         ;
    input   [`MGR_STD_OOB_TAG_RANGE         ]      wud__odc__tag           ;
    input   [`MGR_NUM_LANES_RANGE           ]      wud__odc__num_lanes     ;
    input   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__stOp_cmd      ;
    input   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__simd_cmd      ;
 

    //----------------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------------
    // Registers and Wires

    wire                                        wud__odc__valid         ;
    wire [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__odc__cntl          ;
    reg                                         odc__wud__ready         ;
    wire [`MGR_STD_OOB_TAG_RANGE         ]      wud__odc__tag           ;
    wire [`MGR_NUM_LANES_RANGE           ]      wud__odc__num_lanes     ;
    wire [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__stOp_cmd      ;
    wire [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__simd_cmd      ;
 
    //--------------------------------------------------
    // WUD to OOB downstream control
    reg                                         wud__odc__valid_d1         ;
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__odc__cntl_d1          ;
    wire                                        odc__wud__ready_e1         ;
    reg  [`MGR_STD_OOB_TAG_RANGE         ]      wud__odc__tag_d1           ;
    reg  [`MGR_NUM_LANES_RANGE           ]      wud__odc__num_lanes_d1     ;
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__stOp_cmd_d1      ;
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__simd_cmd_d1      ;
 
    //-------------------------------------------------------------------------------------------------
    // Stack Bus - OOB Downstream
    
    // OOB carries PE configuration    
    reg   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl            ; 
    reg                                           mgr__std__oob_valid           ; 
    wire                                          std__mgr__oob_ready           ; 
    reg   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type            ; 
    reg   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data            ; 

    wire  [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl_e1         ; 
    wire                                          mgr__std__oob_valid_e1        ; 
    reg                                           std__mgr__oob_ready_d1        ; 
    wire  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type_e1         ; 
    wire  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data_e1         ; 



    //----------------------------------------------------------------------------------------------------
    // Register inputs and outputs


    always @(posedge clk) 
      begin
        wud__odc__valid_d1       <=   ( reset_poweron   ) ? 'd0  :  wud__odc__valid      ;
        wud__odc__cntl_d1        <=   ( reset_poweron   ) ? 'd0  :  wud__odc__cntl       ;
        odc__wud__ready          <=   ( reset_poweron   ) ? 'd0  :  odc__wud__ready_e1   ;
        wud__odc__tag_d1         <=   ( reset_poweron   ) ? 'd0  :  wud__odc__tag        ;
        wud__odc__num_lanes_d1   <=   ( reset_poweron   ) ? 'd0  :  wud__odc__num_lanes  ;
        wud__odc__stOp_cmd_d1    <=   ( reset_poweron   ) ? 'd0  :  wud__odc__stOp_cmd   ;
        wud__odc__simd_cmd_d1    <=   ( reset_poweron   ) ? 'd0  :  wud__odc__simd_cmd   ;
                                                           
      end

    always @(posedge clk) 
      begin
        mgr__std__oob_cntl       <=   ( reset_poweron   ) ? 'd0  :  mgr__std__oob_cntl_e1    ;
        mgr__std__oob_valid      <=   ( reset_poweron   ) ? 'd0  :  mgr__std__oob_valid_e1   ;
        std__mgr__oob_ready_d1   <=   ( reset_poweron   ) ? 'd0  :  std__mgr__oob_ready      ;
        mgr__std__oob_type       <=   ( reset_poweron   ) ? 'd0  :  mgr__std__oob_type_e1    ;
        mgr__std__oob_data       <=   ( reset_poweron   ) ? 'd0  :  mgr__std__oob_data_e1    ;
                                                           
      end

  //----------------------------------------------------------------------------------------------------
  // WU Decoder FIFO
  //

  // Put in a generate in case we decide to extend to multiple upstream lanes

  genvar gvi;
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_WuDecoder_Fifo

        // Write data
        reg  [`COMMON_STD_INTF_CNTL_RANGE       ]         write_cntl          ;
        reg  [`MGR_STD_OOB_TAG_RANGE            ]         write_tag           ;
        reg  [`MGR_NUM_LANES_RANGE              ]         write_num_lanes     ;
        reg  [`MGR_WU_OPT_VALUE_RANGE           ]         write_stOp_cmd      ;
        reg  [`MGR_WU_OPT_VALUE_RANGE           ]         write_simd_cmd      ;
 
        // Read data                                                       
        reg  [`COMMON_STD_INTF_CNTL_RANGE       ]         read_cntl           ;
        reg  [`MGR_STD_OOB_TAG_RANGE            ]         read_tag            ;
        reg  [`MGR_NUM_LANES_RANGE              ]         read_num_lanes      ;
        reg  [`MGR_WU_OPT_VALUE_RANGE           ]         read_stOp_cmd       ;
        reg  [`MGR_WU_OPT_VALUE_RANGE           ]         read_simd_cmd       ;
 
        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`OOB_DOWN_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`OOB_DOWN_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_STD_OOB_TAG_WIDTH+`MGR_NUM_LANES_WIDTH+`MGR_WU_OPT_VALUE_WIDTH+`MGR_WU_OPT_VALUE_WIDTH)
                        ) gfifo (
                                          // Status
                                         .empty            ( empty                                                ),
                                         .almost_full      ( almost_full                                          ),
                                         .almost_empty     (                                                      ),
                                         .depth            (                                                      ),
                                          // Write                                                               
                                         .write            ( write                                                ),
                                         .write_data       ({write_cntl, write_tag, write_num_lanes, write_stOp_cmd, write_simd_cmd}),
                                          // Read                                                
                                         .read             ( read                                  ),
                                         . read_data       ({ read_cntl,  read_tag,  read_num_lanes,  read_stOp_cmd,  read_simd_cmd}),

                                         // General
                                         .clear            ( clear                                                ),
                                         .reset_poweron    ( reset_poweron                                        ),
                                         .clk              ( clk                                                  )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
 
        reg                                                  pipe_valid        ;
        reg     [`COMMON_STD_INTF_CNTL_RANGE       ]         pipe_cntl         ;
        reg     [`MGR_STD_OOB_TAG_RANGE            ]         pipe_tag          ;
        reg     [`MGR_NUM_LANES_RANGE              ]         pipe_num_lanes    ;
        reg     [`MGR_WU_OPT_VALUE_RANGE           ]         pipe_stOp_cmd     ;
        reg     [`MGR_WU_OPT_VALUE_RANGE           ]         pipe_simd_cmd     ;
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
            pipe_cntl          <= ( fifo_pipe_read    ) ? read_cntl          :
                                                          pipe_cntl          ;
            pipe_tag          <= ( fifo_pipe_read     ) ? read_tag           :
                                                          pipe_tag           ;
            pipe_num_lanes    <= ( fifo_pipe_read     ) ? read_num_lanes     :
                                                          pipe_num_lanes     ;
            pipe_stOp_cmd     <= ( fifo_pipe_read     ) ? read_stOp_cmd      :
                                                          pipe_stOp_cmd      ;
            pipe_simd_cmd     <= ( fifo_pipe_read     ) ? read_simd_cmd      :
                                                          pipe_simd_cmd      ;
          end

      end
  endgenerate


  assign from_WuDecoder_Fifo[0].clear   =   1'b0                ;
  assign from_WuDecoder_Fifo[0].write   =   wud__odc__valid_d1  ;
  always @(*)
    begin
      from_WuDecoder_Fifo[0].write_cntl        =   wud__odc__cntl_d1        ;
      from_WuDecoder_Fifo[0].write_tag         =   wud__odc__tag_d1         ;
      from_WuDecoder_Fifo[0].write_num_lanes   =   wud__odc__num_lanes_d1   ;
      from_WuDecoder_Fifo[0].write_stOp_cmd    =   wud__odc__stOp_cmd_d1    ;
      from_WuDecoder_Fifo[0].write_simd_cmd    =   wud__odc__simd_cmd_d1    ;
    end
         
  assign odc__wud__ready_e1              = ~from_WuDecoder_Fifo[0].almost_full  ;


  //----------------------------------------------------------------------------------------------------
  // OOB Downstream packet generator FSM
  //

  /*
  reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    stOp_cmd             ; 
  reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    simd_cmd             ; 
  reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    num_lanes                  ; 
  reg                                             contained_stOp_cmd             ;  // the WU option contained a stOp operation pointer
  reg                                             contained_simd_cmd             ;  // the WU option contained a simd operation pointer
  reg                                             contained_num_lanes        ;  // the WU tag for the PE operation(s)
  */

  reg [`OOB_DOWNSTREAM_CNTL_STATE_RANGE ] oob_down_cntl_state      ; // state flop
  reg [`OOB_DOWNSTREAM_CNTL_STATE_RANGE ] oob_down_cntl_state_next ;
  
  
  
  // State register 
  always @(posedge clk)
    begin
      oob_down_cntl_state <= ( reset_poweron ) ? `OOB_DOWNSTREAM_CNTL_WAIT    :
                                                    oob_down_cntl_state_next  ;
    end
  
  // Extract the tag from the oob_data in the first cycle
  
  always @(*)
    begin
      case (oob_down_cntl_state)
        
        `OOB_DOWNSTREAM_CNTL_WAIT: 
          oob_down_cntl_state_next =  ( from_WuDecoder_Fifo[0].pipe_valid && (from_WuDecoder_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && std__mgr__oob_ready_d1) ? `OOB_DOWNSTREAM_CNTL_START_PKT :  // Dont read FIFO until packet is sent
                                      ( from_WuDecoder_Fifo[0].pipe_valid                                                                        && std__mgr__oob_ready_d1) ? `OOB_DOWNSTREAM_CNTL_ERR       :  // for now expecting 1-cycle commands from the decoder
                                                                                                                                                                              `OOB_DOWNSTREAM_CNTL_WAIT      ;
  
        `OOB_DOWNSTREAM_CNTL_START_PKT: 
          oob_down_cntl_state_next =   `OOB_DOWNSTREAM_CNTL_2ND_CYCLE      ;
  
        `OOB_DOWNSTREAM_CNTL_2ND_CYCLE: 
          oob_down_cntl_state_next =   `OOB_DOWNSTREAM_CNTL_WAIT      ;
  
        // Latch state on error
        `OOB_DOWNSTREAM_CNTL_ERR:
          oob_down_cntl_state_next = `OOB_DOWNSTREAM_CNTL_ERR ;
  
        default:
          oob_down_cntl_state_next = `OOB_DOWNSTREAM_CNTL_WAIT ;
    
      endcase // case (oob_down_cntl_state)
    end // always @ (*)
  

  assign from_WuDecoder_Fifo[0].pipe_read = (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_2ND_CYCLE) ;  // pipe must be valid if we got to this state

  assign mgr__std__oob_valid_e1 = (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_START_PKT) |
                                  (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_2ND_CYCLE) ;

  assign mgr__std__oob_cntl_e1 = (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_START_PKT) ? `COMMON_STD_INTF_CNTL_SOM :
                                 (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_2ND_CYCLE) ? `COMMON_STD_INTF_CNTL_EOM :
                                                                                           `COMMON_STD_INTF_CNTL_MOM ;  // default

  assign mgr__std__oob_type_e1 = (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_START_PKT) ?  STD_PACKET_OOB_TYPE_PE_OP_CMD  :
                                 (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_2ND_CYCLE) ?  STD_PACKET_OOB_TYPE_PE_OP_CMD  :
                                                                                            STD_PACKET_OOB_TYPE_NA         ;

  assign mgr__std__oob_data_e1 [`STACK_DOWN_OOB_INTF_OPTION0_RANGE] = (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_START_PKT) ?  STD_PACKET_OOB_OPT_STOP_CMD      :
                                                                      (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_2ND_CYCLE) ?  STD_PACKET_OOB_OPT_TAG           :
                                                                                                                                 STD_PACKET_OOB_OPT_NOP           ;

  assign mgr__std__oob_data_e1 [`STACK_DOWN_OOB_INTF_VALUE0_RANGE]  = (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_START_PKT) ?  from_WuDecoder_Fifo[0].pipe_stOp_cmd  :
                                                                      (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_2ND_CYCLE) ?  from_WuDecoder_Fifo[0].pipe_tag       :
                                                                                                                                 'd0                                   ;

  assign mgr__std__oob_data_e1 [`STACK_DOWN_OOB_INTF_OPTION1_RANGE] = (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_START_PKT) ?  STD_PACKET_OOB_OPT_SIMD_RELU_CMD :
                                                                      (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_2ND_CYCLE) ?  STD_PACKET_OOB_OPT_NUM_LANES     :
                                                                                                                                 STD_PACKET_OOB_OPT_NOP           ;

  assign mgr__std__oob_data_e1 [`STACK_DOWN_OOB_INTF_VALUE1_RANGE]  = (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_START_PKT) ?  from_WuDecoder_Fifo[0].pipe_simd_cmd  :
                                                                      (oob_down_cntl_state == `OOB_DOWNSTREAM_CNTL_2ND_CYCLE) ?  from_WuDecoder_Fifo[0].pipe_num_lanes :
                                                                                                                                 'd0                                   ;


endmodule

