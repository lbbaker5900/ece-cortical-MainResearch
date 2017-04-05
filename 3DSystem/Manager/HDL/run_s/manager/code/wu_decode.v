/*********************************************************************************************

    File name   : wu_decode.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
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


module wu_decode (  

            //-------------------------------
            // from WU Memory
            wum__wud__valid             ,
            wud__wum__ready             ,
            wum__wud__icntl             ,
            wum__wud__dcntl             ,
            wum__wud__op                ,
            wum__wud__option_type       ,
            wum__wud__option_value      ,

            //-------------------------------
            // Stack Down OOB driver
            //
            wuc__odc__valid             ,
            wuc__odc__cntl              ,  // used to delineate OOB control tuples
            odc__wuc__ready             ,
            wuc__odc__tag               ,
            wuc__odc__num_lanes         ,
            wuc__odc__stOp_cmd          ,
            wuc__odc__simd_cmd          ,

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


    //----------------------------------------------------------------------------------------------------
    // from memory
    
    input                                      wum__wud__valid                ;
    output                                     wud__wum__ready                ;
    // WU Instruction delineators
    input [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl                ;  // instruction delineator
    input [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl                ;  // descriptor delineator
    input [`MGR_INST_TYPE_RANGE           ]    wum__wud__op                   ;  // NOP, OP, MR, MW

    // WU Instruction option fields
    input [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST ] ;  // 
    input [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST ] ;  // 


    //-------------------------------------------------------------------------------------------------
    // Stack Down OOB driver
    //
    output                                         wuc__odc__valid         ;
    output  [`COMMON_STD_INTF_CNTL_RANGE    ]      wuc__odc__cntl          ;
    input                                          odc__wuc__ready         ;
    output  [`MGR_WU_OPT_VALUE_RANGE        ]      wuc__odc__tag           ;
    output  [`MGR_WU_OPT_VALUE_RANGE        ]      wuc__odc__num_lanes     ;
    output  [`MGR_WU_OPT_VALUE_RANGE        ]      wuc__odc__stOp_cmd      ;
    output  [`MGR_WU_OPT_VALUE_RANGE        ]      wuc__odc__simd_cmd      ;
 
    //----------------------------------------------------------------------------------------------------
    // Registers and Wires

    wire                                      wum__wud__valid               ;
    reg                                       wud__wum__ready               ;
    // Delineators
    wire [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl               ;  // instruction delineator
    wire [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl               ;  // descriptor delineator
    wire [`MGR_INST_TYPE_RANGE           ]    wum__wud__op                  ;  // NOP, OP, MR, MW

    // WU Instruction option fields
    wire [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    wire [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 


    reg                                       wum__wud__valid_d1                ;
    wire                                      wud__wum__ready_e1                ;
    // Delineators                            
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl_d1                ;  // instruction delineator
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl_d1                ;  // descriptor delineator
    reg  [`MGR_INST_TYPE_RANGE           ]    wum__wud__op_d1                   ;  // 

    // WU Instruction option fields
    reg  [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type_d1    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value_d1   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 


    //----------------------------------------------------------------------------------------------------
    // Register inputs and outputs


    always @(posedge clk) 
      begin
        wum__wud__valid_d1             <=   ( reset_poweron   ) ? 'd0  :    wum__wud__valid    ;
        wud__wum__ready                <=   ( reset_poweron   ) ? 'd0  :    wud__wum__ready_e1 ;
        wum__wud__icntl_d1             <=   ( reset_poweron   ) ? 'd0  :    wum__wud__icntl    ;
        wum__wud__dcntl_d1             <=   ( reset_poweron   ) ? 'd0  :    wum__wud__dcntl    ;
        wum__wud__op_d1                <=   ( reset_poweron   ) ? 'd0  :    wum__wud__op       ;
                                                           
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_in
            wum__wud__option_type_d1  [opt]  <=  ( reset_poweron   ) ? 'd0  :    wum__wud__option_type  [opt]  ;
            wum__wud__option_value_d1 [opt]  <=  ( reset_poweron   ) ? 'd0  :    wum__wud__option_value [opt]  ;
          end
      end


  //----------------------------------------------------------------------------------------------------
  // WU Instruction FIFO
  //

  // Put in a generate in case we decide to extend to multiple upstream lanes

  genvar gvi;
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_WuMemory_Fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_icntl         ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_dcntl         ;
        reg    [`MGR_INST_TYPE_RANGE            ]         write_op            ;
        reg    [`MGR_WU_OPT_TYPE_RANGE          ]         write_option_type    [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        reg    [`MGR_WU_OPT_VALUE_RANGE         ]         write_option_value   [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
                                                                           
        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_icntl          ;
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_dcntl          ;
        wire   [`MGR_INST_TYPE_RANGE            ]         read_op             ;
        wire   [`MGR_WU_OPT_TYPE_RANGE          ]         read_option_type     [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 
        wire   [`MGR_WU_OPT_VALUE_RANGE         ]         read_option_value    [`MGR_WU_OPT_PER_INST_RANGE ]  ;  // 

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`WU_DEC_INSTR_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`WU_DEC_INSTR_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`COMMON_STD_INTF_CNTL_WIDTH+`MGR_INST_TYPE_WIDTH+`MGR_WU_OPT_PER_INST*`MGR_WU_OPT_TYPE_WIDTH+`MGR_WU_OPT_PER_INST*`MGR_WU_OPT_VALUE_WIDTH )
                        ) instr_fifo (
                                          // Status
                                         .empty            ( empty                                                ),
                                         .almost_full      ( almost_full                                          ),
                                          // Write                                                               
                                         .write            ( write                                                ),
                                         .write_data       ( {write_icntl, write_dcntl, write_op, write_option_type[0], write_option_value[0],
                                                                                                  write_option_type[1], write_option_value[1],
                                                                                                  write_option_type[2], write_option_value[2]}),
                                          // Read                                                
                                         .read             ( read                                  ),
                                         .read_data        ( { read_icntl,  read_dcntl,  read_op,  read_option_type[0],  read_option_value[0],
                                                                                                   read_option_type[1],  read_option_value[1],
                                                                                                   read_option_type[2],  read_option_value[2]}),

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
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_icntl        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_dcntl        ;
        reg    [`MGR_INST_TYPE_RANGE            ]            pipe_op           ;
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
            pipe_icntl          <= ( fifo_pipe_read     ) ? read_icntl           :
                                                            pipe_icntl           ;
            pipe_dcntl          <= ( fifo_pipe_read     ) ? read_dcntl           :
                                                            pipe_dcntl           ;
            pipe_op             <= ( fifo_pipe_read     ) ? read_op              :
                                                            pipe_op              ;
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


  assign from_WuMemory_Fifo[0].clear   =   1'b0                ;
  assign from_WuMemory_Fifo[0].write   =   wum__wud__valid_d1  ;
  assign from_WuMemory_Fifo[0].pipe_read   =   from_WuMemory_Fifo[0].pipe_valid ;

  always @(*)
    begin
      from_WuMemory_Fifo[0].write_icntl    =   wum__wud__icntl_d1   ;
      from_WuMemory_Fifo[0].write_dcntl    =   wum__wud__dcntl_d1   ;
      from_WuMemory_Fifo[0].write_op       =   wum__wud__op_d1      ;
      for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
        begin: option_in
          from_WuMemory_Fifo[0].write_option_type  [opt]   =   wum__wud__option_type_d1  [opt]  ;
          from_WuMemory_Fifo[0].write_option_value [opt]   =   wum__wud__option_value_d1 [opt]  ;
        end
    end
         
  assign wud__wum__ready_e1              = ~from_WuMemory_Fifo[0].almost_full  ;


  //----------------------------------------------------------------------------------------------------
  // WU Instruction Decode FSM
  //

  generate
    for (gvi=0; gvi<`MGR_WU_OPT_PER_INST; gvi=gvi+1) 
      begin: instr_decode

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
                                                                                                                                                                                                                                                                                                  `WU_DEC_INSTR_DECODE_INSTR_RUNNING  ;

              `WU_DEC_INSTR_DECODE_MR: 
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_MR             :  // still in MR descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // finishing MR descriptor but another descriptor is coming
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_EOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_COMPLETE :  // finishing MR descriptor and instruction
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                              ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                     
                                                                                                                                                                                                                                                                                                  `WU_DEC_INSTR_DECODE_INSTR_RUNNING  ;

              `WU_DEC_INSTR_DECODE_MW: 
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_MW             :  // still in MW descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // finishing MW descriptor but another descriptor is coming
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_EOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_COMPLETE :  // finishing MW descriptor and instruction
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                              ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                     
                                                                                                                                                                                                                                                                                                  `WU_DEC_INSTR_DECODE_INSTR_RUNNING  ;

              `WU_DEC_INSTR_DECODE_INSTR_COMPLETE: 
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_OP             :  // Instruction starts with operation descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // Instruction started with 1-cycle OP but instruction still valid
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_WAIT           :  // a one cycle instruction and descriptor???
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_MR             :  // instruction starts with MR 
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_MW             :  // instruction starts with MW 
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                               ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal
                                                                                                                                                                                                                                                                                                   `WU_DEC_INSTR_DECODE_WAIT           ;
        
      
              // Latch state on error
              `WU_DEC_INSTR_DECODE_ERR:
                wu_dec_instr_dec_state_next = `WU_DEC_INSTR_DECODE_ERR ;
        
              default:
                wu_dec_instr_dec_state_next = `WU_DEC_INSTR_DECODE_WAIT ;
          
            endcase // case (wu_dec_instr_dec_state)
          end // always @ (*)
  

      end
  endgenerate


endmodule

