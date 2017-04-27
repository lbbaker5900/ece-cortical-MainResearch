/*********************************************************************************************

    File name   : mrc_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2017
    email       : lbbaker@ncsu.edu

    Description :Contains the WU instructions

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
`include "mrc_cntl.vh"
`include "python_typedef.vh"


module mrc_cntl (  

            //-------------------------------
            // From WU Decoder
            // - receiver MR descriptorss
            //
            input   wire                                           wud__mrc__valid                                 ,  // send MR descriptors
            output  reg                                            mrc__wud__ready                                 ,
            input   wire [`COMMON_STD_INTF_CNTL_RANGE    ]         wud__mrc__cntl                                  ,  // descriptor delineator
            input   wire [`MGR_WU_OPT_TYPE_RANGE         ]         wud__mrc__option_type   [`MGR_WU_OPT_PER_INST ] ,  // WU Instruction option fields
            input   wire [`MGR_WU_OPT_VALUE_RANGE        ]         wud__mrc__option_value  [`MGR_WU_OPT_PER_INST ] ,  
            
            //-------------------------------
            // Stack Bus - Downstream arguments
            //
            output  reg                                            mrc__std__lane_valid    [`MGR_NUM_OF_EXEC_LANES_RANGE ],
            output  reg  [`COMMON_STD_INTF_CNTL_RANGE      ]       mrc__std__lane_cntl     [`MGR_NUM_OF_EXEC_LANES_RANGE ],
            input   wire                                           std__mrc__lane_ready    [`MGR_NUM_OF_EXEC_LANES_RANGE ],
            output  reg  [`STACK_DOWN_INTF_STRM_DATA_RANGE ]       mrc__std__lane_data     [`MGR_NUM_OF_EXEC_LANES_RANGE ],

            //-------------------------------
            // General
            //
            input  wire  [`MGR_MGR_ID_RANGE    ]  sys__mgr__mgrId ,

            input  wire                           clk             ,
            input  wire                           reset_poweron  
                        );

    //----------------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------------
    // Registers and Wires
 
    //-------------------------------
    // Stack Bus - Downstream arguments
    //
    reg                                         std__mrc__lane_ready_d1  [`MGR_NUM_OF_EXEC_LANES_RANGE ];
    wire  [`COMMON_STD_INTF_CNTL_RANGE      ]   mrc__std__lane_cntl_e1   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
    wire  [`STACK_DOWN_INTF_STRM_DATA_RANGE ]   mrc__std__lane_data_e1   [`MGR_NUM_OF_EXEC_LANES_RANGE ];
    wire                                        mrc__std__lane_valid_e1  [`MGR_NUM_OF_EXEC_LANES_RANGE ];

    //--------------------------------------------------
    // Memory Read Controller(s)
    
    reg                                         wud__mrc__valid_d1             ;
    reg                                         mrc__wud__ready_e1             ;
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mrc__cntl_d1              ;  
    reg    [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mrc__option_type_d1    [`MGR_WU_OPT_PER_INST ] ;
    reg    [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mrc__option_value_d1   [`MGR_WU_OPT_PER_INST ] ;


    //----------------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------------
    // Register inputs and outputs

    //--------------------------------------------------
    // Stack Bus - Downstream arguments
    //  - we have an output for each execution lane
    
    always @(posedge clk) 
      begin
        for (int lane=0; lane<`MGR_NUM_OF_EXEC_LANES; lane++)
          begin: lane_drive
            mrc__std__lane_valid    [lane]  <=   ( reset_poweron   ) ? 'd0  :  mrc__std__lane_valid_e1 [lane]  ; 
            mrc__std__lane_cntl     [lane]  <=   ( reset_poweron   ) ? 'd0  :  mrc__std__lane_cntl_e1  [lane]  ;
            mrc__std__lane_data     [lane]  <=   ( reset_poweron   ) ? 'd0  :  mrc__std__lane_data_e1  [lane]  ;
            std__mrc__lane_ready_d1 [lane]  <=   ( reset_poweron   ) ? 'd0  :  std__mrc__lane_ready    [lane]  ;
          end


      end
    //--------------------------------------------------
    // from WU Decoder
    
    always @(posedge clk) 
      begin
        wud__mrc__valid_d1        <=   ( reset_poweron   ) ? 'd0  :  wud__mrc__valid        ;
        wud__mrc__cntl_d1         <=   ( reset_poweron   ) ? 'd0  :  wud__mrc__cntl        ;

        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_in
            wud__mrc__option_type_d1  [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mrc__option_type  [opt]  ;
            wud__mrc__option_value_d1 [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mrc__option_value [opt]  ;
          end

        mrc__wud__ready        <=   ( reset_poweron   ) ? 'd0  :  mrc__wud__ready_e1       ;

      end

  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // MR Descriptor FIFO
  //

  // Put in a generate in case we decide to extend to multiple upstream lanes

  genvar gvi;
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Wud_Fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_cntl          ;
        reg    [`MGR_WU_OPT_TYPE_RANGE          ]         write_option_type    [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        reg    [`MGR_WU_OPT_VALUE_RANGE         ]         write_option_value   [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
                                                                           
        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_cntl           ;
        wire   [`MGR_WU_OPT_TYPE_RANGE          ]         read_option_type     [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        wire   [`MGR_WU_OPT_VALUE_RANGE         ]         read_option_value    [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        //wire                                              almost_empty     ; 
        wire                                              read             ; 
        wire                                              write            ; 
 
        // Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`MRC_CNTL_DESC_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`MRC_CNTL_DESC_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_WU_OPT_PER_INST*`MGR_WU_OPT_TYPE_WIDTH+`MGR_WU_OPT_PER_INST*`MGR_WU_OPT_VALUE_WIDTH )
                        ) gfifo (
                                          // Status
                                         .empty            ( empty                                                     ),
                                         .almost_full      ( almost_full                                               ),
                                         //.almost_empty     ( almost_empty                                              ),
                                          // Write                                                                    
                                         .write            ( write                                                     ),
                                         .write_data       ( {write_cntl,  write_option_type[0], write_option_value[0],
                                                                           write_option_type[1], write_option_value[1],
                                                                           write_option_type[2], write_option_value[2]}),
                                          // Read                          
                                         .read             ( read                                                      ),
                                         .read_data        ( { read_cntl,   read_option_type[0],  read_option_value[0],
                                                                            read_option_type[1],  read_option_value[1],
                                                                            read_option_type[2],  read_option_value[2]}),

                                         // General
                                         .clear            ( clear                                                     ),
                                         .reset_poweron    ( reset_poweron                                             ),
                                         .clk              ( clk                                                       )
                                         );

        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_cntl         ;
        reg    [`MGR_WU_OPT_TYPE_RANGE          ]            pipe_option_type  [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        reg    [`MGR_WU_OPT_VALUE_RANGE         ]            pipe_option_value [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
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
            pipe_cntl           <= ( fifo_pipe_read     ) ? read_cntl            :
                                                            pipe_cntl            ;
            pipe_option_type[0] <= ( fifo_pipe_read     ) ? read_option_type[0]  :
                                                            pipe_option_type[0]  ;
            pipe_option_type[1] <= ( fifo_pipe_read     ) ? read_option_type[1]  :
                                                            pipe_option_type[1]  ;
            pipe_option_type[2] <= ( fifo_pipe_read     ) ? read_option_type[2]  :
                                                            pipe_option_type[2]  ;
            pipe_option_value[0] <= ( fifo_pipe_read    ) ? read_option_value[0] :
                                                            pipe_option_value[0] ;
            pipe_option_value[1] <= ( fifo_pipe_read    ) ? read_option_value[1] :
                                                            pipe_option_value[1] ;
            pipe_option_value[2] <= ( fifo_pipe_read    ) ? read_option_value[2] :
                                                            pipe_option_value[2] ;
          end

      end
  endgenerate


  assign from_Wud_Fifo[0].clear   =   1'b0                ;
  assign from_Wud_Fifo[0].write   =   wud__mrc__valid_d1  ;
  always @(*)
    begin
      from_Wud_Fifo[0].write_cntl    =   wud__mrc__cntl_d1   ;
      for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
        begin: option_in
          from_Wud_Fifo[0].write_option_type  [opt]   =   wud__mrc__option_type_d1  [opt]  ;
          from_Wud_Fifo[0].write_option_value [opt]   =   wud__mrc__option_value_d1 [opt]  ;
        end
    end
         
  assign mrc__wud__ready_e1              = ~from_Wud_Fifo[0].almost_full  ;


  //----------------------------------------------------------------------------------------------------
  // Process Descriptor FSM
  //
      
  // State register 
  reg [`MRC_CNTL_DESC_DECODE_STATE_RANGE ] mrc_cntl_desc_dec_state      ; // state flop
  reg [`MRC_CNTL_DESC_DECODE_STATE_RANGE ] mrc_cntl_desc_dec_state_next ;

  always @(posedge clk)
    begin
      mrc_cntl_desc_dec_state <= ( reset_poweron ) ? `MRC_CNTL_DESC_DECODE_WAIT    :
                                                    mrc_cntl_desc_dec_state_next  ;
    end
  
  //--------------------------------------------------
  // Assumptions:
  
  always @(*)
    begin
      case (mrc_cntl_desc_dec_state)
        
        `MRC_CNTL_DESC_DECODE_WAIT: 
          mrc_cntl_desc_dec_state_next =    `MRC_CNTL_DESC_DECODE_WAIT           ;
  
        // May not need all these states, but it will help with debug
        // Latch state on error
        `MRC_CNTL_DESC_DECODE_ERR:
          mrc_cntl_desc_dec_state_next = `MRC_CNTL_DESC_DECODE_ERR ;
  
        default:
          mrc_cntl_desc_dec_state_next = `MRC_CNTL_DESC_DECODE_WAIT ;
    
      endcase // case (mrc_cntl_desc_dec_state)
    end // always @ (*)
  
  //----------------------------------------------------------------------------------------------------
  // Assignments
  //




  assign from_Wud_Fifo[0].pipe_read = from_Wud_Fifo[0].pipe_valid ;  // FIXME


endmodule

