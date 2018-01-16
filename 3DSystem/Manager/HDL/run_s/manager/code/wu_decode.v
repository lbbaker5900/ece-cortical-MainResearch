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
`include "python_typedef.vh"


module wu_decode (  

            //-------------------------------
            // from WU Memory
            input   wire                                      wum__wud__valid               ,
            output  reg                                       wud__wum__ready               ,
            // Delineators
            input   wire [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl               ,  // instruction delineator
            input   wire [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl               ,  // descriptor delineator
            input   wire [`MGR_INST_TYPE_RANGE           ]    wum__wud__op                  ,  // NOP, OP, MR, MW
                  
            // WU Instruction option fields
            input   wire [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type    [`MGR_WU_OPT_PER_INST_RANGE ] ,  // 
            input   wire [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value   [`MGR_WU_OPT_PER_INST_RANGE ] ,  // 


            //-------------------------------
            // Stack Down OOB driver
            //
            output  reg                                         wud__odc__valid         ,
            output  reg  [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__odc__cntl          ,
            input   wire                                        odc__wud__ready         ,
            output  reg  [`MGR_STD_OOB_TAG_RANGE         ]      wud__odc__tag           ,
            output  reg  [`WU_DEC_NUM_LANES_RANGE        ]      wud__odc__num_lanes     ,  // 0-32 so need 6 bits
            output  reg  [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__stOp_cmd      ,
            output  reg  [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__simd_cmd      ,

            //-------------------------------
            // Main control
            // - send sync and data descriptors
            output  reg                                       wud__mcntl__valid                ,
            input   wire                                      mcntl__wud__ready                ,
            output  reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mcntl__dcntl                ,  // descriptor delineator
            output  reg  [`MGR_STD_OOB_TAG_RANGE         ]    wud__mcntl__tag                  ,  // decoder generates tag for Return data proc and Downstream OOB
            output  reg  [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mcntl__option_type    [`MGR_WU_OPT_PER_INST ] ,  // WU Instruction option fields
            output  reg  [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mcntl__option_value   [`MGR_WU_OPT_PER_INST ] ,  


            //-------------------------------
            // Return Data Processor
            // - send write descriptor
            output  reg                                       wud__rdp__valid                ,
            input   wire                                      rdp__wud__ready                ,
            output  reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__rdp__dcntl                ,  // descriptor delineator
            output  reg  [`MGR_STD_OOB_TAG_RANGE         ]    wud__rdp__tag                  ,  // decoder generates tag for Return data proc and Downstream OOB
            output  reg  [`MGR_WU_OPT_TYPE_RANGE         ]    wud__rdp__option_type    [`MGR_WU_OPT_PER_INST ] ,  // WU Instruction option fields
            output  reg  [`MGR_WU_OPT_VALUE_RANGE        ]    wud__rdp__option_value   [`MGR_WU_OPT_PER_INST ] ,  


            //-------------------------------
            // Read memory Controllers
            // - arg and arg1 to stack bus
            // - send MR descriptorss

            output  reg                                      wud__mrc0__valid                ,  // send MR descriptors
            input   wire                                     mrc0__wud__ready                ,
            output  reg [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mrc0__cntl                 ,  // descriptor delineator
            output  reg [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mrc0__option_type    [`MGR_WU_OPT_PER_INST ] ,  // WU Instruction option fields
            output  reg [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mrc0__option_value   [`MGR_WU_OPT_PER_INST ] ,  
            output  reg [`MGR_STD_OOB_TAG_RANGE         ]    wud__mrc0__tag                  ,  // mmc needs to service tag requests before tag+1
            
            output  reg                                      wud__mrc1__valid                ,
            output  reg [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mrc1__cntl                 ,  // descriptor delineator
            input   wire                                     mrc1__wud__ready                ,
            output  reg [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mrc1__option_type    [`MGR_WU_OPT_PER_INST ] ,  // WU Instruction option fields
            output  reg [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mrc1__option_value   [`MGR_WU_OPT_PER_INST ] ,  
            output  reg [`MGR_STD_OOB_TAG_RANGE         ]    wud__mrc1__tag                  ,  // mmc needs to service tag requests before tag+1

            
            //-------------------------------
            // General
            //
            input  wire  [`MGR_MGR_ID_RANGE             ]    sys__mgr__mgrId ,
            //output reg   [`MGR_STD_OOB_TAG_RANGE        ]    wud__sys__tag   ,  // provide the  initial tag value to other modules

            input  wire                                      clk             ,
            input  wire                                      reset_poweron  
                        );


    //----------------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------------
    // Registers and Wires

 
    //--------------------------------------------------
    // from WUM
    reg                                       wum__wud__valid_d1                ;
    wire                                      wud__wum__ready_e1                ;
    // Delineators                            
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__icntl_d1                ;  // instruction delineator
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wum__wud__dcntl_d1                ;  // descriptor delineator
    reg  [`MGR_INST_TYPE_RANGE           ]    wum__wud__op_d1                   ;  // 

    // WU Instruction option fields
    reg  [`MGR_WU_OPT_TYPE_RANGE         ]    wum__wud__option_type_d1    [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]    wum__wud__option_value_d1   [`MGR_WU_OPT_PER_INST_RANGE ] ;  // 


    //--------------------------------------------------
    // WUD to Main Controller
    wire                                      wud__mcntl__valid_e1                                  ;
    reg                                       mcntl__wud__ready_d1                                  ;
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mcntl__dcntl_e1                                  ;  // descriptor delineator
    reg  [`MGR_STD_OOB_TAG_RANGE         ]    wud__mcntl__tag_e1                                    ;  // decoder generates tag for Return data proc and Downstream OOB
    reg  [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mcntl__option_type_e1    [`MGR_WU_OPT_PER_INST ] ;  // WU Instruction option fields
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mcntl__option_value_e1   [`MGR_WU_OPT_PER_INST ] ;  

    //--------------------------------------------------
    // WUD to OOB downstream control
    reg                                         wud__odc__valid_e1         ;
    reg  [`COMMON_STD_INTF_CNTL_RANGE    ]      wud__odc__cntl_e1          ;
    reg                                         odc__wud__ready_d1         ;
    reg  [`MGR_STD_OOB_TAG_RANGE         ]      wud__odc__tag_e1           ;
    reg  [`WU_DEC_NUM_LANES_RANGE        ]      wud__odc__num_lanes_e1     ;  // 0-32 so need 6 bits
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__stOp_cmd_e1      ;
    reg  [`MGR_WU_OPT_VALUE_RANGE        ]      wud__odc__simd_cmd_e1      ;
 
    reg  [`PE_CNTL_OOB_OPTION_RANGE      ]      tag                        ; 

    wire                                        initiate_instruction       ;
 
    //--------------------------------------------------
    // Memory Read Controller(s)
    
    wire                                        wud__mrc0__valid_e1             ;
    reg                                         mrc0__wud__ready_d1             ;
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mrc0__cntl_e1              ;  
    reg    [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mrc0__option_type_e1    [`MGR_WU_OPT_PER_INST ] ;
    reg    [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mrc0__option_value_e1   [`MGR_WU_OPT_PER_INST ] ;

    wire                                        wud__mrc1__valid_e1             ;
    reg                                         mrc1__wud__ready_d1             ;
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__mrc1__cntl_e1              ;  
    reg    [`MGR_WU_OPT_TYPE_RANGE         ]    wud__mrc1__option_type_e1    [`MGR_WU_OPT_PER_INST ] ;
    reg    [`MGR_WU_OPT_VALUE_RANGE        ]    wud__mrc1__option_value_e1   [`MGR_WU_OPT_PER_INST ] ;

    //--------------------------------------------------
    // Return Data Processor
    
    wire                                        wud__rdp__valid_e1             ;
    reg                                         rdp__wud__ready_d1             ;
    reg    [`COMMON_STD_INTF_CNTL_RANGE    ]    wud__rdp__dcntl_e1             ;  
    reg    [`MGR_STD_OOB_TAG_RANGE         ]    wud__rdp__tag_e1               ;
    reg    [`MGR_STD_OOB_TAG_RANGE         ]    wud__mrc0__tag_e1              ;
    reg    [`MGR_STD_OOB_TAG_RANGE         ]    wud__mrc1__tag_e1              ;
    reg    [`MGR_WU_OPT_TYPE_RANGE         ]    wud__rdp__option_type_e1    [`MGR_WU_OPT_PER_INST ] ;
    reg    [`MGR_WU_OPT_VALUE_RANGE        ]    wud__rdp__option_value_e1   [`MGR_WU_OPT_PER_INST ] ;

    //--------------------------------------------------
    // Decode which modules will receive descriptor information
    reg                                         send_info_to_oob_downstream    ;  // flag at beginning of received descriptor
    reg                                         send_info_to_return_proc       ;
    reg                                         send_info_to_main_cntl         ;
    //reg                                       send_info_to_mem_write         ;
    reg                                         send_info_to_arg0_mem_cntl     ;
    reg                                         send_info_to_arg1_mem_cntl     ;
    reg                                         sending_to_oob_downstream      ;  // latched flag held until EOD
    reg                                         sending_to_return_proc         ;
    reg                                         sending_to_main_cntl           ;
    //reg                                       sending_to_mem_write           ;
    reg                                         sending_to_arg0_mem_cntl       ;
    reg                                         sending_to_arg1_mem_cntl       ;


    //----------------------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------------------
    // Register inputs and outputs


    //--------------------------------------------------
    // WU Memory
    
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


    //--------------------------------------------------
    // Main Controller
    
    always @(posedge clk) 
      begin
        mcntl__wud__ready_d1     <=   ( reset_poweron   ) ? 'd0  :  mcntl__wud__ready           ;
        wud__mcntl__valid        <=   ( reset_poweron   ) ? 'd0  :  wud__mcntl__valid_e1        ;
        wud__mcntl__dcntl        <=   ( reset_poweron   ) ? 'd0  :  wud__mcntl__dcntl_e1        ;
        wud__mcntl__tag          <=   ( reset_poweron   ) ? 'd0  :  wud__mcntl__tag_e1          ;
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_in
            wud__mcntl__option_type  [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mcntl__option_type_e1  [opt]  ;
            wud__mcntl__option_value [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mcntl__option_value_e1 [opt]  ;
          end
      end


    //--------------------------------------------------
    // WUD to OOB downstream control

    always @(posedge clk) 
      begin
        wud__odc__valid       <=   ( reset_poweron   ) ? 'd0  :  wud__odc__valid_e1      ;
        wud__odc__cntl        <=   ( reset_poweron   ) ? 'd0  :  wud__odc__cntl_e1       ;
        odc__wud__ready_d1    <=   ( reset_poweron   ) ? 'd0  :  odc__wud__ready         ;
        wud__odc__tag         <=   ( reset_poweron   ) ? 'd0  :  tag                     ;
        wud__odc__num_lanes   <=   ( reset_poweron   ) ? 'd0  :  wud__odc__num_lanes_e1  ;
        wud__odc__stOp_cmd    <=   ( reset_poweron   ) ? 'd0  :  wud__odc__stOp_cmd_e1   ;
        wud__odc__simd_cmd    <=   ( reset_poweron   ) ? 'd0  :  wud__odc__simd_cmd_e1   ;
                                                           
      end


    //--------------------------------------------------
    // Read Memory Controllers
    
    always @(posedge clk) 
      begin
        // MRC0
        wud__mrc0__valid        <=   ( reset_poweron   ) ? 'd0  :  wud__mrc0__valid_e1       ;
        wud__mrc0__cntl         <=   ( reset_poweron   ) ? 'd0  :  wud__mrc0__cntl_e1        ;

        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_in
            wud__mrc0__option_type  [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mrc0__option_type_e1  [opt]  ;
            wud__mrc0__option_value [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mrc0__option_value_e1 [opt]  ;
          end

        wud__mrc0__tag         <=   ( reset_poweron   ) ? 'd0  :  wud__mrc0__tag_e1         ;

        mrc0__wud__ready_d1     <=   ( reset_poweron   ) ? 'd0  :  mrc0__wud__ready       ;

        // MRC1
        wud__mrc1__valid        <=   ( reset_poweron   ) ? 'd0  :  wud__mrc1__valid_e1    ;
        wud__mrc1__cntl         <=   ( reset_poweron   ) ? 'd0  :  wud__mrc1__cntl_e1     ;

        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_in
            wud__mrc1__option_type  [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mrc1__option_type_e1  [opt]  ;
            wud__mrc1__option_value [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__mrc1__option_value_e1 [opt]  ;
          end

        wud__mrc1__tag         <=   ( reset_poweron   ) ? 'd0  :  wud__mrc1__tag_e1         ;

        mrc1__wud__ready_d1     <=   ( reset_poweron   ) ? 'd0  :  mrc1__wud__ready       ;
      end


    //--------------------------------------------------
    // Return Data Processor
    
    always @(posedge clk) 
      begin
        rdp__wud__ready_d1     <=   ( reset_poweron   ) ? 'd0  :  rdp__wud__ready           ;
        wud__rdp__valid        <=   ( reset_poweron   ) ? 'd0  :  wud__rdp__valid_e1        ;
        wud__rdp__dcntl        <=   ( reset_poweron   ) ? 'd0  :  wud__rdp__dcntl_e1        ;
        wud__rdp__tag          <=   ( reset_poweron   ) ? 'd0  :  wud__rdp__tag_e1          ;
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: option_in
            wud__rdp__option_type  [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__rdp__option_type_e1  [opt]  ;
            wud__rdp__option_value [opt]  <=  ( reset_poweron   ) ? 'd0  :    wud__rdp__option_value_e1 [opt]  ;
          end
      end



  //----------------------------------------------------------------------------------------------------
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
                        ) gfifo (
                                          // Status
                                         .empty            ( empty                                                ),
                                         .almost_full      ( almost_full                                          ),
                                         .almost_empty     (                                                      ),
                                         .depth            (                                                      ),
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

        reg                                                  pipe_option_type_extd  ;
        reg                                                  pipe_inst_som          ;
        reg                                                  pipe_inst_mom          ;
        reg                                                  pipe_inst_eom          ;
        reg                                                  pipe_desc_som          ;
        reg                                                  pipe_desc_mom          ;
        reg                                                  pipe_desc_eom          ;


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

            pipe_inst_som        <=  ( fifo_pipe_read    ) ? ((read_icntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (read_icntl == `COMMON_STD_INTF_CNTL_SOM)) : pipe_inst_som ; 
            pipe_inst_eom        <=  ( fifo_pipe_read    ) ? ((read_icntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (read_icntl == `COMMON_STD_INTF_CNTL_EOM)) : pipe_inst_eom ;
            pipe_inst_mom        <=  ( fifo_pipe_read    ) ? (                                                (read_icntl == `COMMON_STD_INTF_CNTL_MOM)) : pipe_inst_mom ; 

            pipe_desc_som        <=  ( fifo_pipe_read    ) ? ((read_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (read_dcntl == `COMMON_STD_INTF_CNTL_SOM)) : pipe_desc_som ; 
            pipe_desc_eom        <=  ( fifo_pipe_read    ) ? ((read_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) | (read_dcntl == `COMMON_STD_INTF_CNTL_EOM)) : pipe_desc_eom ;
            pipe_desc_mom        <=  ( fifo_pipe_read    ) ? (                                                (read_dcntl == `COMMON_STD_INTF_CNTL_MOM)) : pipe_desc_mom ; 

            // extended tuples always occur in option_type[0]
            pipe_option_type_extd <=  ( fifo_pipe_read   ) ? ((read_option_type[0] == PY_WU_INST_OPT_TYPE_CFG_SYNC) | (read_option_type[0] == PY_WU_INST_OPT_TYPE_CFG_DATA) | (read_option_type[0] == PY_WU_INST_OPT_TYPE_MEMORY)) : pipe_option_type_extd ;
          end

      end
  endgenerate


  assign from_WuMemory_Fifo[0].clear   =   1'b0                ;
  assign from_WuMemory_Fifo[0].write   =   wum__wud__valid_d1  ;
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
  genvar decNum;
  generate
    for (decNum=0; decNum<`MGR_WU_OPT_PER_INST; decNum=decNum+1) 
      begin: instr_decode

        reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    stOp_cmd                       ; 
        reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    simd_cmd                       ; 
        reg  [`PE_CNTL_OOB_OPTION_RANGE            ]    num_lanes                      ; 
        reg                                             contained_stOp_cmd             ;  // the WU option contained a stOp operation pointer
        reg                                             contained_simd_cmd             ;  // the WU option contained a simd operation pointer
        reg                                             contained_num_lanes            ;  // the WU tag for the PE operation(s)
        reg                                             contained_cfg_sync             ;
        reg                                             contained_cfg_data             ;
        //--------------------------------------------------
        // Decode which modules will receive descriptor information
        reg                                             send_info_to_oob_downstream    ;
        reg                                             send_info_to_return_proc       ;
        reg                                             send_info_to_main_cntl         ;
        //reg                                           send_info_to_mem_write         ;
        reg                                             send_info_to_arg0_mem_cntl     ;
        reg                                             send_info_to_arg1_mem_cntl     ;


        reg [`WU_DEC_INSTR_DECODE_STATE_RANGE ] wu_dec_instr_dec_state      ; // state flop
        reg [`WU_DEC_INSTR_DECODE_STATE_RANGE ] wu_dec_instr_dec_state_next ;
        
        
      
        // State register 
        always @(posedge clk)
          begin
            wu_dec_instr_dec_state <= ( reset_poweron ) ? `WU_DEC_INSTR_DECODE_WAIT    :
                                                          wu_dec_instr_dec_state_next  ;
          end
        
        //--------------------------------------------------
        // Assumptions:
        //  - destination blocks can absorb entire transaction if they are ready e.g. we wont flow control during the transfer but once all destinations are ready
        //    the transfer(s) will run to completion
       
        always @(*)
          begin
            case (wu_dec_instr_dec_state)  // synopsys parallel_case
              
              // Note: the pipe will not be read unless all affected destination modules are ready
              `WU_DEC_INSTR_DECODE_WAIT: 
                begin
//                    ({1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0, {`MGR_INST_TYPE_WIDTH {`MGR_INST_DESC_TYPE_ }}}) :
//                      begin
//                      end
                  case ({{from_WuMemory_Fifo[0].pipe_read}, {from_WuMemory_Fifo[0].pipe_inst_som, from_WuMemory_Fifo[0].pipe_inst_mom, from_WuMemory_Fifo[0].pipe_inst_eom}, {from_WuMemory_Fifo[0].pipe_desc_som, from_WuMemory_Fifo[0].pipe_desc_mom, from_WuMemory_Fifo[0].pipe_desc_eom}, {from_WuMemory_Fifo[0].pipe_op}})  // synopsys parallel_case full_case
                    //---------------------------------------------------------------------------
                    // OP
                    ({{1'b1}, {3'b100}, {3'b100}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_OP }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_OP ;
                      end
                    ({{1'b1}, {3'b100}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_OP }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    ({{1'b1}, {3'b101}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_OP }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_WAIT ;
                      end
                    //---------------------------------------------------------------------------
                    // MR
                    ({{1'b1}, {3'b100}, {3'b100}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MR }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_MR ;
                      end
                    ({{1'b1}, {3'b100}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MR }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    //---------------------------------------------------------------------------
                    // MW
                    ({{1'b1}, {3'b100}, {3'b100}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MW }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_MW ;
                      end
                    ({{1'b1}, {3'b100}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MW }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    //---------------------------------------------------------------------------
                    // CFG 
                    ({{1'b1}, {3'b100}, {3'b100}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_CFG }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_CFG ;
                      end
                    ({{1'b1}, {3'b100}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_CFG }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    ({{1'b1}, {3'b101}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_CFG }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_WAIT ;
                      end
                    default:
                      wu_dec_instr_dec_state_next =  wu_dec_instr_dec_state ;
                  endcase
                end
/*
                wu_dec_instr_dec_state_next =  
                                               `ifdef TB_MGR_PAUSES_WUD
                                                 ( tb_pause ) ? `WU_DEC_INSTR_DECODE_WAIT   :
                                               `endif
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_OP             :  // Instruction starts with operation descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // Instruction started with 1-cycle OP but instruction still valid
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_WAIT           :  // a one cycle instruction and descriptor???
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_MR             :  // instruction starts with MR 
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_MW             :  // instruction starts with MW
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                               ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                            
                                                                                                                                                                                                                                                                                                   `WU_DEC_INSTR_DECODE_WAIT           ;

*/
        
              // May not need all these states, but it will help with debug
              
              // Descriptor complete but instruction not complete
              `WU_DEC_INSTR_DECODE_INSTR_RUNNING: 
                begin
                  case ({{from_WuMemory_Fifo[0].pipe_read}, {from_WuMemory_Fifo[0].pipe_inst_som, from_WuMemory_Fifo[0].pipe_inst_mom, from_WuMemory_Fifo[0].pipe_inst_eom}, {from_WuMemory_Fifo[0].pipe_desc_som, from_WuMemory_Fifo[0].pipe_desc_mom, from_WuMemory_Fifo[0].pipe_desc_eom}, {from_WuMemory_Fifo[0].pipe_op}})  // synopsys parallel_case full_case
                    //---------------------------------------------------------------------------
                    // OP
                    ({{1'b1}, {3'b010}, {3'b100}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_OP }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_OP ;
                      end
                    ({{1'b1}, {3'b010}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_OP }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    ({{1'b1}, {3'b001}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_OP }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_COMPLETE ;
                      end
                    //---------------------------------------------------------------------------
                    // MR
                    ({{1'b1}, {3'b010}, {3'b100}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MR }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_MR ;
                      end
                    ({{1'b1}, {3'b010}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MR }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    //---------------------------------------------------------------------------
                    // MW
                    ({{1'b1}, {3'b010}, {3'b100}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MW }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_MW ;
                      end
                    ({{1'b1}, {3'b010}, {3'b101}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MW }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    default:
                      wu_dec_instr_dec_state_next =  wu_dec_instr_dec_state ;
                  endcase
                end
/*
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_OP             :  // Instruction starts with operation descriptor                     
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // Instruction started with 1-cycle OP but instruction still valid
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_COMPLETE :  // Instruction finish with 1-cycle OP 
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_MR             :  // a one cycle instruction and descriptor???
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // instruction starts with MR 
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_MW             :  
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // instruction starts with MRW
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                               ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                             
                                                                                                                                                                                                                                                                                                   `WU_DEC_INSTR_DECODE_INSTR_RUNNING  ;
*/
      
              `WU_DEC_INSTR_DECODE_OP: 
                begin
                  case ({{from_WuMemory_Fifo[0].pipe_read}, {from_WuMemory_Fifo[0].pipe_inst_som, from_WuMemory_Fifo[0].pipe_inst_mom, from_WuMemory_Fifo[0].pipe_inst_eom}, {from_WuMemory_Fifo[0].pipe_desc_som, from_WuMemory_Fifo[0].pipe_desc_mom, from_WuMemory_Fifo[0].pipe_desc_eom}, {from_WuMemory_Fifo[0].pipe_op}})  // synopsys parallel_case full_case
                    ({{1'b1}, {3'b010}, {3'b010}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_OP }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_OP ;
                      end
                    ({{1'b1}, {3'b010}, {3'b001}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_OP }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    ({{1'b1}, {3'b001}, {3'b001}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_OP }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_COMPLETE ;
                      end
                    default:
                      wu_dec_instr_dec_state_next =  wu_dec_instr_dec_state ;
                  endcase
                end
/*
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_OP             :  // still in OP descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // finishing OP descriptor but another descriptor is coming
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_EOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_OP ) ) ? `WU_DEC_INSTR_DECODE_INSTR_COMPLETE :  // finishing OP descriptor and instruction
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                              ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                     
                                                                                                                                                                                                                                                                                                  `WU_DEC_INSTR_DECODE_OP  ;
*/

              `WU_DEC_INSTR_DECODE_MR: 
                begin
                  case ({{from_WuMemory_Fifo[0].pipe_read}, {from_WuMemory_Fifo[0].pipe_inst_som, from_WuMemory_Fifo[0].pipe_inst_mom, from_WuMemory_Fifo[0].pipe_inst_eom}, {from_WuMemory_Fifo[0].pipe_desc_som, from_WuMemory_Fifo[0].pipe_desc_mom, from_WuMemory_Fifo[0].pipe_desc_eom}, {from_WuMemory_Fifo[0].pipe_op}})  // synopsys parallel_case full_case
                    ({{1'b1}, {3'b010}, {3'b010}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MR }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_MR ;
                      end
                    ({{1'b1}, {3'b010}, {3'b001}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MR }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    ({{1'b1}, {3'b001}, {3'b001}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MR }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_COMPLETE ;
                      end
                    default:
                      wu_dec_instr_dec_state_next =  wu_dec_instr_dec_state ;
                  endcase
                end
/*
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_MR             :  // still in MR descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // finishing MR descriptor but another descriptor is coming
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_EOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MR ) ) ? `WU_DEC_INSTR_DECODE_INSTR_COMPLETE :  // finishing MR descriptor and instruction
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                              ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                     
                                                                                                                                                                                                                                                                                                  `WU_DEC_INSTR_DECODE_MR  ;
*/

              `WU_DEC_INSTR_DECODE_MW: 
                begin
                  case ({{from_WuMemory_Fifo[0].pipe_read}, {from_WuMemory_Fifo[0].pipe_inst_som, from_WuMemory_Fifo[0].pipe_inst_mom, from_WuMemory_Fifo[0].pipe_inst_eom}, {from_WuMemory_Fifo[0].pipe_desc_som, from_WuMemory_Fifo[0].pipe_desc_mom, from_WuMemory_Fifo[0].pipe_desc_eom}, {from_WuMemory_Fifo[0].pipe_op}})  // synopsys parallel_case full_case
                    ({{1'b1}, {3'b010}, {3'b010}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MW }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_MW ;
                      end
                    ({{1'b1}, {3'b010}, {3'b001}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MW }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    ({{1'b1}, {3'b001}, {3'b001}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_MW }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_COMPLETE ;
                      end
                    default:
                      wu_dec_instr_dec_state_next =  wu_dec_instr_dec_state ;
                  endcase
                end
/*
                wu_dec_instr_dec_state_next =  ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_MOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_MW             :  // still in MW descriptor
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_MOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_RUNNING  :  // finishing MW descriptor but another descriptor is coming
                                               ( from_WuMemory_Fifo[0].pipe_read && (from_WuMemory_Fifo[0].pipe_icntl == `COMMON_STD_INTF_CNTL_EOM   ) && (from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && (from_WuMemory_Fifo[0].pipe_op   == `MGR_INST_DESC_TYPE_MW ) ) ? `WU_DEC_INSTR_DECODE_INSTR_COMPLETE :  // finishing MW descriptor and instruction
                                               ( from_WuMemory_Fifo[0].pipe_read                                                                                                                                                                                                              ) ? `WU_DEC_INSTR_DECODE_ERR            :  // anything other than above is illegal                     
                                                                                                                                                                                                                                                                                                  `WU_DEC_INSTR_DECODE_MW  ;
*/

              `WU_DEC_INSTR_DECODE_CFG: 
                begin
                  case ({{from_WuMemory_Fifo[0].pipe_read}, {from_WuMemory_Fifo[0].pipe_inst_som, from_WuMemory_Fifo[0].pipe_inst_mom, from_WuMemory_Fifo[0].pipe_inst_eom}, {from_WuMemory_Fifo[0].pipe_desc_som, from_WuMemory_Fifo[0].pipe_desc_mom, from_WuMemory_Fifo[0].pipe_desc_eom}, {from_WuMemory_Fifo[0].pipe_op}})  // synopsys parallel_case full_case
                    ({{1'b1}, {3'b010}, {3'b010}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_CFG }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_CFG ;
                      end
                    ({{1'b1}, {3'b010}, {3'b001}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_CFG }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_RUNNING ;
                      end
                    ({{1'b1}, {3'b001}, {3'b001}, {`MGR_INST_TYPE_WIDTH 'd`MGR_INST_DESC_TYPE_CFG }}) :
                      begin
                        wu_dec_instr_dec_state_next =  `WU_DEC_INSTR_DECODE_INSTR_COMPLETE ;
                      end
                    default:
                      wu_dec_instr_dec_state_next =  wu_dec_instr_dec_state ;
                  endcase
                end

              // when instruction complete and all decoder are in their COMPLETE state, initiate all affected modules
              `WU_DEC_INSTR_DECODE_INSTR_COMPLETE: 
                wu_dec_instr_dec_state_next =  ( initiate_instruction ) ? `WU_DEC_INSTR_DECODE_INITIATED_INSTR :  
                                                                          `WU_DEC_INSTR_DECODE_INSTR_COMPLETE  ;
        
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
        //  Note: When checking option for MW, be careful of extended tuples
        //  e.g. we have tuples 0..2, the option field of tuple 2 may be the 2nd byte of a Write pointer from tuple 1
        //
        //  Extended tuple types, such as storage descriptor pointer are always aligned to least significant option, so if option[0] is an extd tuple type then ignore other option lanes

        always @(posedge clk)
          begin
            contained_stOp_cmd       <=  ( reset_poweron                                                                                                     ) ? 1'b0               :
                                         ( wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR                                                    ) ? 1'b0               :  // clear when packet and operation complete
                                         ( (decNum != 0) && (from_WuMemory_Fifo[0].pipe_option_type_extd                                                    )) ? contained_stOp_cmd :  // option type not valid if option[0] is an extended tuple
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_STOP )) ? 1'b1               :
                                                                                                                                                                 contained_stOp_cmd ;
            // pointer to stOp operation control memory
            stOp_cmd                 <=  ( reset_poweron                                                                                                     ) ?  'd0                                            :
                                         ( (decNum != 0) && (from_WuMemory_Fifo[0].pipe_option_type_extd                                                    )) ? stOp_cmd                                        :  // option type not valid if option[0] is an extended tuple
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_STOP )) ? from_WuMemory_Fifo[0].pipe_option_value[decNum] :
                                                                                                                                                                 stOp_cmd                                        ;
        
            contained_simd_cmd       <=  ( reset_poweron                                                                                                       ) ? 1'b0               :
                                         ( wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR                                                      ) ? 1'b0               :  // clear when packet and operation complete
                                         ( (decNum != 0) && (from_WuMemory_Fifo[0].pipe_option_type_extd                                                       )) ? contained_simd_cmd :  // option type not valid if option[0] is an extended tuple
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_SIMDOP )) ? 1'b1               :
                                                                                                                                                                   contained_simd_cmd ;
            // pointer to simd operation control memory
            simd_cmd                 <=  ( reset_poweron                                                                                                       ) ?  'd0                                            :
                                         ( (decNum != 0) && (from_WuMemory_Fifo[0].pipe_option_type_extd                                                      )) ? simd_cmd                                        :  // option type not valid if option[0] is an extended tuple
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_SIMDOP )) ? from_WuMemory_Fifo[0].pipe_option_value[decNum] :
                                                                                                                                                                   simd_cmd                                        ;
        
            contained_num_lanes      <=  ( reset_poweron                                                                                                             ) ? 1'b0                :
                                         ( wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR                                                            ) ? 1'b0                :  // clear when packet and operation complete
                                         ( (decNum != 0) && (from_WuMemory_Fifo[0].pipe_option_type_extd                                                            )) ? contained_num_lanes :  // option type not valid if option[0] is an extended tuple
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES )) ? 1'b1                :
                                                                                                                                                                         contained_num_lanes ;
            // pointer to simd operation control memory
            num_lanes                <=  ( reset_poweron                                                                                                             ) ?  'd0                                            :
                                         ( (decNum != 0) && (from_WuMemory_Fifo[0].pipe_option_type_extd                                                            )) ? num_lanes                                       :  // option type not valid if option[0] is an extended tuple
                                         ( from_WuMemory_Fifo[0].pipe_valid  && (from_WuMemory_Fifo[0].pipe_option_type[decNum] == PY_WU_INST_OPT_TYPE_NUM_OF_LANES )) ? from_WuMemory_Fifo[0].pipe_option_value[decNum] :
                                                                                                                                                                         num_lanes                                       ;
        
          end

       // These signals direct the instruction info to specific modules
       // Remember the pipe_op field is valid for the entire intruction transfer from WU memory
        always @(*)
          begin
            // Determine which modules the instruction impacts
            // Assumption is everything we need to determine affected modules is in 1st cycle of descriptor
            send_info_to_main_cntl         =  from_WuMemory_Fifo[0].pipe_valid  & ((from_WuMemory_Fifo[0].pipe_op                   == `MGR_INST_DESC_TYPE_CFG          )) ;

            send_info_to_oob_downstream    =  from_WuMemory_Fifo[0].pipe_valid  & ((from_WuMemory_Fifo[0].pipe_op                   == `MGR_INST_DESC_TYPE_OP           )) ;
                                                                                                                                                                        
            send_info_to_return_proc       =  from_WuMemory_Fifo[0].pipe_valid  & ((from_WuMemory_Fifo[0].pipe_op                   == `MGR_INST_DESC_TYPE_MW           ) &
                                                                                   (from_WuMemory_Fifo[0].pipe_option_type [decNum] == PY_WU_INST_OPT_TYPE_SRC          ) &
                                                                                   (from_WuMemory_Fifo[0].pipe_option_value[decNum] == PY_WU_INST_SRC_TYPE_STACK_UP     )) ;
           
            send_info_to_arg0_mem_cntl     =  from_WuMemory_Fifo[0].pipe_valid  & ((from_WuMemory_Fifo[0].pipe_op                   == `MGR_INST_DESC_TYPE_MR           ) &
                                                                                   (from_WuMemory_Fifo[0].pipe_option_type [decNum] == PY_WU_INST_OPT_TYPE_TGT          ) &
                                                                                   (from_WuMemory_Fifo[0].pipe_option_value[decNum] == PY_WU_INST_TGT_TYPE_STACK_DN_ARG0)) ;
           
            send_info_to_arg1_mem_cntl     =  from_WuMemory_Fifo[0].pipe_valid  & ((from_WuMemory_Fifo[0].pipe_op                   == `MGR_INST_DESC_TYPE_MR           ) &
                                                                                   (from_WuMemory_Fifo[0].pipe_option_type [decNum] == PY_WU_INST_OPT_TYPE_TGT          ) &
                                                                                   (from_WuMemory_Fifo[0].pipe_option_value[decNum] == PY_WU_INST_TGT_TYPE_STACK_DN_ARG1)) ;
          end

      end
  endgenerate


  // All decoder FSM's should follow the same path
  // We read the FIFO unless the instruction is complete and we are starting to process OR
  // the destination modules that require info from the instruction are not ready
  // logic is : dont read if ......
  assign from_WuMemory_Fifo[0].pipe_read = ( ~(
                                              (instr_decode[0].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INSTR_COMPLETE ) | 
                                              (instr_decode[1].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INSTR_COMPLETE ) | 
                                              (instr_decode[2].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INSTR_COMPLETE ) | 
                                              (instr_decode[0].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR) | 
                                              (instr_decode[1].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR) | 
                                              (instr_decode[2].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR) | 
                                              send_info_to_main_cntl        & ~mcntl__wud__ready_d1                            |   
                                              send_info_to_oob_downstream   & ~odc__wud__ready_d1                              |   
                                              send_info_to_return_proc      & ~rdp__wud__ready_d1                              |   
                                              send_info_to_arg0_mem_cntl    & ~mrc0__wud__ready_d1                             |   
                                              send_info_to_arg1_mem_cntl    & ~mrc1__wud__ready_d1                             |   
                                              ~from_WuMemory_Fifo[0].pipe_valid                                                 )
                                           ) ;

  assign initiate_instruction            = (instr_decode[0].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INSTR_COMPLETE) & 
                                           (instr_decode[1].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INSTR_COMPLETE) & 
                                           (instr_decode[2].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INSTR_COMPLETE) ; 

  always @(posedge clk)
    begin
      // If a packet is sent to oob driver, increment tag
      tag                     <=  ( reset_poweron                                                                                                         ) ? `WU_DEC_INITIAL_TAG  :  // start with a number that is easy to see in simulation
                                  ((instr_decode[0].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR ) & instr_decode[0].contained_simd_cmd ) ? tag+1    :
                                  ((instr_decode[1].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR ) & instr_decode[1].contained_simd_cmd ) ? tag+1    :
                                  ((instr_decode[2].wu_dec_instr_dec_state == `WU_DEC_INSTR_DECODE_INITIATED_INSTR ) & instr_decode[2].contained_simd_cmd ) ? tag+1    :
                                                                                                                                                              tag      ;
        
    end

  //----------------------------------------------------------------------------------------------------
  // OOB Downstream control starts when all decoders initiate the instruction
  //  - 1-cycle transfer, so send at end of instruction
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

  //----------------------------------------------------------------------------------------------------
  // Determine which modules the instruction impacts
  // Assumption is everything we need to determine affected modules is in 1st cycle of descriptor
  //
  always @(*)
    begin

      send_info_to_main_cntl       =  ( instr_decode[0].send_info_to_main_cntl       ) | 
                                      ( instr_decode[1].send_info_to_main_cntl       ) | 
                                      ( instr_decode[2].send_info_to_main_cntl       ) ; 
                                                                                         
      send_info_to_oob_downstream  =  ( instr_decode[0].send_info_to_oob_downstream  ) | 
                                      ( instr_decode[1].send_info_to_oob_downstream  ) | 
                                      ( instr_decode[2].send_info_to_oob_downstream  ) ; 
                                                                                         
      send_info_to_return_proc     =  ( instr_decode[0].send_info_to_return_proc     ) | 
                                      ( instr_decode[1].send_info_to_return_proc     ) | 
                                      ( instr_decode[2].send_info_to_return_proc     ) ; 
                                                                                         
      send_info_to_arg0_mem_cntl   =  ( instr_decode[0].send_info_to_arg0_mem_cntl   ) | 
                                      ( instr_decode[1].send_info_to_arg0_mem_cntl   ) | 
                                      ( instr_decode[2].send_info_to_arg0_mem_cntl   ) ; 
                                                                                     
      send_info_to_arg1_mem_cntl   =  ( instr_decode[0].send_info_to_arg1_mem_cntl   ) | 
                                      ( instr_decode[1].send_info_to_arg1_mem_cntl   ) | 
                                      ( instr_decode[2].send_info_to_arg1_mem_cntl   ) ; 
    end

  always @(posedge clk)
    begin

      // if SOM_EOM, then dont assert sending and valid will condition on
      // send_info.. only
      sending_to_main_cntl       <=  ( reset_poweron                                                                                           ) ? 1'b0                      :
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ( send_info_to_main_cntl                                             && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b1                      :
                                                                                                                                                   sending_to_main_cntl      ;

      sending_to_oob_downstream  <=  ( reset_poweron                                                                                           ) ? 1'b0                      :
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ( send_info_to_oob_downstream                                        && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b1                      :
                                                                                                                                                   sending_to_oob_downstream ;
                                      
      sending_to_return_proc     <=  ( reset_poweron                                                                                           ) ? 1'b0                      :
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ( send_info_to_return_proc                                           && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b1                      :
                                                                                                                                                   sending_to_return_proc    ;
                                      
      sending_to_arg0_mem_cntl   <=  ( reset_poweron                                                                                           ) ? 1'b0                      :
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ( send_info_to_arg0_mem_cntl                                         && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b1                      :
                                                                                                                                                   sending_to_arg0_mem_cntl  ;
                                      
      sending_to_arg1_mem_cntl   <=  ( reset_poweron                                                                                           ) ? 1'b0                      :
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_EOM    ) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ((from_WuMemory_Fifo[0].pipe_dcntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b0                      :                                  
                                     ( send_info_to_arg1_mem_cntl                                         && from_WuMemory_Fifo[0].pipe_read   ) ? 1'b1                      :
                                                                                                                                                   sending_to_arg1_mem_cntl  ;
                                      
    end

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Extract descriptors from the instruction and send to affected blocks
  // FIXME: Beware that right now we assume the affected blocks are
  // highlighted during the first cycle of the descriptor. If thats not the case, we will have to adjust the SOD/EOD
 
  // Drive to return Data processor conditioned on the send_info and sending flags
  // Note: Used assign for valid because during debug we set valid = 0 and that doest work if you use a procedure because I assume not event actually occurs to stimulate the assign.

  //----------------------------------------------------------------------------------------------------
  // To Main Controller
  // 
 
  assign wud__mcntl__valid_e1        =   (send_info_to_main_cntl | sending_to_main_cntl) & from_WuMemory_Fifo[0].pipe_read  ;
  always @(*)
    begin
        wud__mcntl__dcntl_e1        =   from_WuMemory_Fifo[0].pipe_dcntl  ;
        wud__mcntl__tag_e1          =   tag ;
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: rdc_option_out
            wud__mcntl__option_type_e1  [opt]  =  from_WuMemory_Fifo[0].pipe_option_type  [opt]  ;
            wud__mcntl__option_value_e1 [opt]  =  from_WuMemory_Fifo[0].pipe_option_value [opt]  ;
          end
    end

  //----------------------------------------------------------------------------------------------------
  // To RDP
  // Drive to return Data processor conditioned on the send_info and sending flags
  // Note: Used assign for valid because during debug we set valid = 0 and that doest work if you use a procedure because I assume not event actually occurs to stimulate the assign.
 
  assign wud__rdp__valid_e1        =   (send_info_to_return_proc | sending_to_return_proc) & from_WuMemory_Fifo[0].pipe_read  ;
  always @(*)
    begin
        wud__rdp__dcntl_e1        =   from_WuMemory_Fifo[0].pipe_dcntl  ;
        wud__rdp__tag_e1          =   tag ;
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: rdc_option_out
            wud__rdp__option_type_e1  [opt]  =  from_WuMemory_Fifo[0].pipe_option_type  [opt]  ;
            wud__rdp__option_value_e1 [opt]  =  from_WuMemory_Fifo[0].pipe_option_value [opt]  ;
          end
    end

  //----------------------------------------------------------------------------------------------------
  // To MRCs
 
  assign wud__mrc0__valid_e1      =  (send_info_to_arg0_mem_cntl | sending_to_arg0_mem_cntl) & from_WuMemory_Fifo[0].pipe_read ;
  assign wud__mrc1__valid_e1      =  (send_info_to_arg1_mem_cntl | sending_to_arg1_mem_cntl) & from_WuMemory_Fifo[0].pipe_read ;
  always @(*)
    begin
        wud__mrc0__cntl_e1              =  from_WuMemory_Fifo[0].pipe_dcntl  ;
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: mrc0_option_out
            wud__mrc0__option_type_e1 [opt]      =  from_WuMemory_Fifo[0].pipe_option_type  [opt]  ;
            wud__mrc0__option_value_e1[opt]      =  from_WuMemory_Fifo[0].pipe_option_value [opt]  ;
          end
        wud__mrc0__tag_e1         =   tag ;
    
        wud__mrc1__cntl_e1              =  from_WuMemory_Fifo[0].pipe_dcntl  ;
        for (int opt=0; opt<`MGR_WU_OPT_PER_INST; opt++)
          begin: mrc1_option_out
            wud__mrc1__option_type_e1 [opt]      =  from_WuMemory_Fifo[0].pipe_option_type  [opt]  ;
            wud__mrc1__option_value_e1[opt]      =  from_WuMemory_Fifo[0].pipe_option_value [opt]  ;
          end
        wud__mrc1__tag_e1         =   tag ;
    end


endmodule

