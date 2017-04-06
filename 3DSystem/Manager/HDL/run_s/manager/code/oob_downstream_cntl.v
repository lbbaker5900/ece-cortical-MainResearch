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
    input   [`MGR_EXEC_LANE_ID_RANGE        ]      wud__odc__num_lanes     ;
    input   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__stOp_cmd      ;
    input   [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__simd_cmd      ;
 

    //----------------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------------
    // Registers and Wires

    wire                                        wud__odc__valid         ;
    wire [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__odc__cntl          ;
    reg                                         odc__wud__ready         ;
    wire [`MGR_STD_OOB_TAG_RANGE         ]      wud__odc__tag           ;
    wire [`MGR_EXEC_LANE_ID_RANGE        ]      wud__odc__num_lanes     ;
    wire [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__stOp_cmd      ;
    wire [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__simd_cmd      ;
 
    //--------------------------------------------------
    // WUD to OOB downstream control
    reg                                         wud__odc__valid_d1         ;
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__odc__cntl_d1          ;
    wire                                        odc__wud__ready_e1         ;
    reg  [`MGR_STD_OOB_TAG_RANGE         ]      wud__odc__tag_d1           ;
    reg  [`MGR_EXEC_LANE_ID_RANGE        ]      wud__odc__num_lanes_d1     ;
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
        reg  [`COMMON_STD_INTF_CNTL_RANGE       ]         write cntl          ;
        reg  [`MGR_STD_OOB_TAG_RANGE            ]         write tag           ;
        reg  [`MGR_EXEC_LANE_ID_RANGE           ]         write num_lanes     ;
        reg  [`MGR_WU_OPT_VALUE_RANGE           ]         write stOp_cmd      ;
        reg  [`MGR_WU_OPT_VALUE_RANGE           ]         write simd_cmd      ;
 
        // Read data                                                       
        reg  [`COMMON_STD_INTF_CNTL_RANGE       ]         read cntl           ;
        reg  [`MGR_STD_OOB_TAG_RANGE            ]         read tag            ;
        reg  [`MGR_EXEC_LANE_ID_RANGE           ]         read num_lanes      ;
        reg  [`MGR_WU_OPT_VALUE_RANGE           ]         read stOp_cmd       ;
        reg  [`MGR_WU_OPT_VALUE_RANGE           ]         read simd_cmd       ;
 
        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`WU_DEC_INSTR_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`WU_DEC_INSTR_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_STD_OOB_TAG_WIDTH+`MGR_EXEC_LANE_ID_WIDTH+`MGR_WU_OPT_VALUE_WIDTH+`MGR_WU_OPT_VALUE_WIDTH)
                        ) instr_fifo (
                                          // Status
                                         .empty            ( empty                                                ),
                                         .almost_full      ( almost_full                                          ),
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
        reg     [`COMMON_STD_INTF_CNTL_RANGE       ]         pipe cntl         ;
        reg     [`MGR_STD_OOB_TAG_RANGE            ]         pipe tag          ;
        reg     [`MGR_EXEC_LANE_ID_RANGE           ]         pipe num_lanes    ;
        reg     [`MGR_WU_OPT_VALUE_RANGE           ]         pipe stOp_cmd     ;
        reg     [`MGR_WU_OPT_VALUE_RANGE           ]         pipe simd_cmd     ;
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
         
  assign odc__wud__ready_e1              = ~from_WuMemory_Fifo[0].almost_full  ;


  //----------------------------------------------------------------------------------------------------
  // OOB Downstream packet generator FSM
  //
  genvar decNum;
  generate
    for (decNum=0; decNum<`MGR_WU_OPT_PER_INST; decNum=decNum+1) 
      begin: instr_decode

        reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    stOp_cmd             ; 
        reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    simd_cmd             ; 
        reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    num_lanes                  ; 
        reg                                             contained_stOp_cmd             ;  // the WU option contained a stOp operation pointer
        reg                                             contained_simd_cmd             ;  // the WU option contained a simd operation pointer
        reg                                             contained_num_lanes        ;  // the WU tag for the PE operation(s)

        reg [`WU_DEC_INSTR_DECODE_STATE_RANGE ] wu_dec_instr_dec_state      ; // state flop
        reg [`WU_DEC_INSTR_DECODE_STATE_RANGE ] wu_dec_instr_dec_state_next ;
        
        
      
        // State register 
        always @(posedge clk)
          begin
            wu_dec_instr_dec_state <= ( reset_poweron ) ? `WU_DEC_INSTR_DECODE_WAIT    :
                                                          wu_dec_instr_dec_state_next  ;
          end
        
        // Extract the tag from the oob_data in the first cycle
       
        always @(*)
          begin
            case (wu_dec_instr_dec_state)
              
              `WU_DEC_INSTR_DECODE_WAIT: 
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_OP             :  // Instruction starts with operation descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // Instruction started with 1-cycle OP but instruction still valid
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_WAIT           :  // a one cycle instruction and descriptor???
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_MR             :  // instruction starts with MR 
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_MW             :  // instruction starts with MW
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                               ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                            
                                                                                                                                                                                                                                                                                                   `WU_DEC_INSTR_DECODE_WAIT           ;
        
              // May not need all these states, but it will help with debug
              
              // Descriptor complete but instruction not complete
              `WU_DEC_INSTR_DECODE_INSTR_RUNNING: 
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_OP             :  // Instruction starts with operation descriptor                     
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // Instruction started with 1-cycle OP but instruction still valid
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_MR             :  // a one cycle instruction and descriptor???
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // instruction starts with MR 
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_MW             :  
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // instruction starts with MRW
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                               ) ? `WU_DEC_INSTR_DECODE_ERR            :  
                                                                                                                                                                                                                                                                                                   `WU_DEC_INSTR_DECODE_INSTR_RUNNING  ;  // anything other than above is illegal                            
        
      
              `WU_DEC_INSTR_DECODE_OP: 
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_OP             :  // still in OP descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // finishing OP descriptor but another descriptor is coming
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_EOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_COMPLETE :  // finishing OP descriptor and instruction
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                              ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                     
                                                                                                                                                                                                                                                                                                  `WU_DEC_INSTR_DECODE_OP  ;

              `WU_DEC_INSTR_DECODE_MR: 
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_MR             :  // still in MR descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // finishing MR descriptor but another descriptor is coming
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_EOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_COMPLETE :  // finishing MR descriptor and instruction
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                              ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                     
                                                                                                                                                                                                                                                                                                  `WU_DEC_INSTR_DECODE_MR  ;

              `WU_DEC_INSTR_DECODE_MW: 
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_MW             :  // still in MW descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // finishing MW descriptor but another descriptor is coming
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_EOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_COMPLETE :  // finishing MW descriptor and instruction
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                              ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                     
                                                                                                                                                                                                                                                                                                  `WU_DEC_INSTR_DECODE_MW  ;

              // when instruction complete, intiate all affected modules
              `WU_DEC_INSTR_DECODE_INSTR_COMPLETE: 
                wu_dec_instr_dec_state_next =  ( initiate_instruction ) ? `WU_DEC_INSTR_DECODE_INITIATED_INSTR :  
                                                                                          `WU_DEC_INSTR_DECODE_INSTR_COMPLETE ;
        
              `WU_DEC_INSTR_DECODE_INITIATED_INSTR: 
                wu_dec_instr_dec_state_next =    `WU_DEC_INSTR_DECODE_WAIT           ;
        
              // Latch state on error
              `WU_DEC_INSTR_DECODE_ERR:
                wu_dec_instr_dec_state_next = `WU_DEC_INSTR_DECODE_ERR ;
        
              default:
                wu_dec_instr_dec_state_next = `WU_DEC_INSTR_DECODE_WAIT ;
          
            endcase // case (wu_dec_instr_dec_state)
          end // always @ (*)
  
        //----------------------------------------------------------------------------------------------------
        // Assignments
        //

        // for downstream OOB, we need to set type to STD_PACKET_OOB_OPT_...
        // for instruction decode, use PY_WU_INST_....
        // Only send info to oob driver once we have received: simd_ptr, stOp_ptr and num_lanes
        //  - the simd and stop local commands contain operation, addresses etc.
        //  - this module creates the tag
        always @(posedge clk)
          begin
            contained_stOp_cmd           <=  ( reset_poweron                                                                                            ) ? 1'b0           :
                                         ( wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR                                            ) ? 1'b0           :  // clear when packet and operation complete
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_STOP )) ? 1'b1           :
                                                                                                                                                        contained_stOp_cmd ;
            // pointer to stOp operation control memory
            stOp_cmd           <=  ( reset_poweron                                                                                            ) ?  'd0                                            :
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_STOP )) ? from_WuMemory_Fifo[0].pipe_option_value[decNum] :
                                                                                                                                                        stOp_cmd                                  ;
        
            contained_simd_cmd           <=  ( reset_poweron                                                                                            ) ? 1'b0           :
                                         ( wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR                                            ) ? 1'b0           :  // clear when packet and operation complete
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_SIMDOP )) ? 1'b1           :
                                                                                                                                                        contained_simd_cmd ;
            // pointer to simd operation control memory
            simd_cmd           <=  ( reset_poweron                                                                                            ) ?  'd0                                            :
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_SIMDOP )) ? from_WuMemory_Fifo[0].pipe_option_value[decNum] :
                                                                                                                                                        simd_cmd                                  ;
        
            contained_num_lanes      <=  ( reset_poweron                                                                                            ) ? 1'b0           :
                                         ( wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR                                            ) ? 1'b0           :  // clear when packet and operation complete
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES )) ? 1'b1           :
                                                                                                                                                        contained_num_lanes ;
            // pointer to simd operation control memory
            num_lanes                <=  ( reset_poweron                                                                                            ) ?  'd0                                            :
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES )) ? from_WuMemory_Fifo[0].pipe_option_value[decNum] :
                                                                                                                                                        num_lanes                                  ;
        
          end

      end
  endgenerate


  // ALl decoder FSM's should follow the same path
  assign from_WuMemory_Fifo[0].pipe_read = (((instr_decode[0].wu_dec_instr_dec_state != `WU_DEC_INSTR_DECODE_INSTR_COMPLETE) & 
                                             (instr_decode[1].wu_dec_instr_dec_state != `WU_DEC_INSTR_DECODE_INSTR_COMPLETE) & 
                                             (instr_decode[2].wu_dec_instr_dec_state != `WU_DEC_INSTR_DECODE_INSTR_COMPLETE)) & 
                                            ((instr_decode[0].wu_dec_instr_dec_state != `WU_DEC_INSTR_DECODE_INITIATED_INSTR) & 
                                             (instr_decode[1].wu_dec_instr_dec_state != `WU_DEC_INSTR_DECODE_INITIATED_INSTR) & 
                                             (instr_decode[2].wu_dec_instr_dec_state != `WU_DEC_INSTR_DECODE_INITIATED_INSTR)))& 
                                             from_WuMemory_Fifo[0].pipe_valid ;

  assign initiate_instruction            = (instr_decode[0].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INSTR_COMPLETE) & 
                                           (instr_decode[1].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INSTR_COMPLETE) & 
                                           (instr_decode[2].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INSTR_COMPLETE) ; 

  always @(posedge clk)
    begin
      // If a packet is sent to oob driver, increment tag
      tag                     <=  ( reset_poweron                                                                                                    ) ? 'd0      :
                                  ((instr_decode[0].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR ) & instr_decode[0].contained_simd_cmd ) ? tag+1    :
                                  ((instr_decode[1].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR ) & instr_decode[1].contained_simd_cmd ) ? tag+1    :
                                  ((instr_decode[2].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR ) & instr_decode[2].contained_simd_cmd ) ? tag+1    :
                                                                                                                                                         tag      ;
        
    end

  //----------------------------------------------------------------------------------------------------
  // OOB Downstream control starts when all decoders initiate the instruction
  always @(*)
    begin
        wud__odc__valid_e1       =   ( instr_decode[0].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR ) & instr_decode[0].contained_simd_cmd |
                                     ( instr_decode[1].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR ) & instr_decode[1].contained_simd_cmd |
                                     ( instr_decode[2].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR ) & instr_decode[2].contained_simd_cmd ;

        wud__odc__cntl_e1        =   `COMMON_STD_INTF_CNTL_SOM_EOM ;  // for now, wud__odc packets are single cycle
        wud__odc__tag_e1         =   tag ;
        wud__odc__stOp_cmd_e1    =   ( instr_decode[0].contained_stOp_cmd  ) ? instr_decode[0].stOp_cmd   :
                                     ( instr_decode[1].contained_stOp_cmd  ) ? instr_decode[1].stOp_cmd   :
                                     ( instr_decode[2].contained_stOp_cmd  ) ? instr_decode[2].stOp_cmd   :
                                                                               'd0                        ;
        wud__odc__simd_cmd_e1    =   ( instr_decode[0].contained_simd_cmd  ) ? instr_decode[0].simd_cmd   :
                                     ( instr_decode[1].contained_simd_cmd  ) ? instr_decode[1].simd_cmd   :
                                     ( instr_decode[2].contained_simd_cmd  ) ? instr_decode[2].simd_cmd   :
                                                                               'd0                        ;
        wud__odc__num_lanes_e1   =   ( instr_decode[0].contained_num_lanes ) ? instr_decode[0].num_lanes  :
                                     ( instr_decode[1].contained_num_lanes ) ? instr_decode[1].num_lanes  :
                                     ( instr_decode[2].contained_num_lanes ) ? instr_decode[2].num_lanes  :
                                                                               'd0                        ;
    end

endmodule

