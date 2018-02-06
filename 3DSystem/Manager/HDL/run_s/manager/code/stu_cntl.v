/*********************************************************************************************

    File name   : stu_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module collects the upstream packets and extracts tag, data
                  Module name = <stuc>

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "wu_fetch.vh"
`include "stu_cntl.vh"




module stu_cntl (

            //-------------------------------
            // Stack Bus - Upstream
            //
            stu__mgr__valid         ,
            stu__mgr__cntl          ,
            mgr__stu__ready         ,
            stu__mgr__type          ,  
            stu__mgr__data          ,
            stu__mgr__oob_data      ,
 
            //-------------------------------
            // Return data processor output
            //
            stuc__rdp__valid         ,
            stuc__rdp__cntl          ,  // used to delineate upstream packet data
            rdp__stuc__ready         ,
            stuc__rdp__tag           ,  // Use this to match with WU and take all the data 
            stuc__rdp__data          ,  // The data may vary so check for cntl=EOD when reading this interface

            //-------------------------------
            // Return Control packet processor output
            //
            stuc__rcp__valid         ,
            stuc__rcp__cntl          ,  // used to delineate upstream packet data
            rcp__stuc__ready         ,
            stuc__rcp__tag           ,  // Use this to match with WU and take all the data 
            stuc__rcp__data          ,  // The data may vary so check for cntl=EOD when reading this interface

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


  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //
  input                                          stu__mgr__valid       ;
  input   [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl        ;
  output                                         mgr__stu__ready       ;
  input   [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type        ;  // Control or Data, Vector or scalar
  input   [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data        ;
  input   [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data    ;
 

  //-------------------------------------------------------------------------------------------------
  // Data Processor Interface
  //
  output                                         stuc__rdp__valid       ;
  output  [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rdp__cntl        ;
  input                                          rdp__stuc__ready       ;
  output  [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rdp__tag         ;  // tag size is the same as sent to PE
  output  [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rdp__data        ;
 
  //-------------------------------------------------------------------------------------------------
  // Control Processor Interface
  //
  output                                         stuc__rcp__valid       ;
  output  [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rcp__cntl        ;
  input                                          rcp__stuc__ready       ;
  output  [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rcp__tag         ;  // tag size is the same as sent to PE
  output  [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rcp__data        ;
 


  //----------------------------------------------------------------------------------------------------
  // Registers/Wires

  //-------------------------------------------------------------------------------------------------
  // Stack Bus - Upstream
  //

  wire                                           stu__mgr__valid       ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl        ;
  reg                                            mgr__stu__ready       ;
  wire    [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type        ;
  wire    [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data        ;
  wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data    ;

  reg                                            stu__mgr__valid_d1    ;
  reg     [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr__cntl_d1     ;
  wire                                           mgr__stu__ready_e1    ;
  reg     [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr__type_d1     ; 
  reg     [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr__data_d1     ;
  reg     [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr__oob_data_d1 ;

  //-------------------------------------------------------------------------------------------------
  // To return data processor
  //
  reg                                            stuc__rdp__valid       ;
  reg     [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rdp__cntl        ;
  wire                                           rdp__stuc__ready       ;
  reg     [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rdp__tag         ;  // tag size is the same as sent to PE
  reg     [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rdp__data        ;
 
  wire                                           stuc__rdp__valid_e1    ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rdp__cntl_e1     ;
  reg                                            rdp__stuc__ready_d1    ;
  wire    [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rdp__tag_e1      ;  // tag size is the same as sent to PE
  wire    [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rdp__data_e1     ;

  //-------------------------------------------------------------------------------------------------
  // To return control packet processor
  //
  reg                                            stuc__rcp__valid       ;
  reg     [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rcp__cntl        ;
  wire                                           rcp__stuc__ready       ;
  reg     [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rcp__tag         ;  // tag size is the same as sent to PE
  reg     [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rcp__data        ;
 
  wire                                           stuc__rcp__valid_e1    ;
  wire    [`COMMON_STD_INTF_CNTL_RANGE    ]      stuc__rcp__cntl_e1     ;
  reg                                            rcp__stuc__ready_d1    ;
  wire    [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      stuc__rcp__tag_e1      ;  // tag size is the same as sent to PE
  wire    [`STACK_UP_INTF_DATA_RANGE      ]      stuc__rcp__data_e1     ;


  //-------------------------------------------------------------------------------------------------
  // To return control packet processor
  reg     [`STACK_DOWN_OOB_INTF_TAG_RANGE ]      response_packet_tag    ;  // extract tag from upstream packet


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registered Inputs and Outputs

  always @(posedge clk)
    begin
      stu__mgr__valid_d1      <= ( reset_poweron   ) ? 'd0  :  stu__mgr__valid        ;
      stu__mgr__cntl_d1       <= ( reset_poweron   ) ? 'd0  :  stu__mgr__cntl         ;
      mgr__stu__ready         <= ( reset_poweron   ) ? 'd0  :  mgr__stu__ready_e1     ;
      stu__mgr__type_d1       <= ( reset_poweron   ) ? 'd0  :  stu__mgr__type         ;
      stu__mgr__data_d1       <= ( reset_poweron   ) ? 'd0  :  stu__mgr__data         ;
      stu__mgr__oob_data_d1   <= ( reset_poweron   ) ? 'd0  :  stu__mgr__oob_data     ;

      stuc__rdp__valid        <= ( reset_poweron   ) ? 'd0  :  stuc__rdp__valid_e1    ;
      stuc__rdp__cntl         <= ( reset_poweron   ) ? 'd0  :  stuc__rdp__cntl_e1     ;
      rdp__stuc__ready_d1     <= ( reset_poweron   ) ? 'd0  :  rdp__stuc__ready       ;
      stuc__rdp__tag          <= ( reset_poweron   ) ? 'd0  :  stuc__rdp__tag_e1      ;
      stuc__rdp__data         <= ( reset_poweron   ) ? 'd0  :  stuc__rdp__data_e1     ;

      stuc__rcp__valid        <= ( reset_poweron   ) ? 'd0  :  stuc__rcp__valid_e1    ;
      stuc__rcp__cntl         <= ( reset_poweron   ) ? 'd0  :  stuc__rcp__cntl_e1     ;
      rcp__stuc__ready_d1     <= ( reset_poweron   ) ? 'd0  :  rcp__stuc__ready       ;
      stuc__rcp__tag          <= ( reset_poweron   ) ? 'd0  :  stuc__rcp__tag_e1      ;
      stuc__rcp__data         <= ( reset_poweron   ) ? 'd0  :  stuc__rcp__data_e1     ;

    end



  //----------------------------------------------------------------------------------------------------
  // Upstream Input FIFO
  //

  // Put in a generate in case we decide to extend to multiple upstream lanes

  genvar gvi;
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_Stu_Fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]         write_cntl       ;
        wire   [`STACK_UP_INTF_TYPE_RANGE       ]         write_type       ;
        //stack_up_type                                     write_type       ;
        wire   [`STACK_UP_INTF_DATA_RANGE       ]         write_data       ;
        wire   [`STACK_UP_INTF_OOB_DATA_RANGE   ]         write_oob_data   ;
                                                                           
        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE     ]         read_cntl        ;
        wire   [`STACK_UP_INTF_TYPE_RANGE       ]         read_type        ;
        //stack_up_type                                     read_type        ;
        wire   [`STACK_UP_INTF_DATA_RANGE       ]         read_data        ;
        wire   [`STACK_UP_INTF_OOB_DATA_RANGE   ]         read_oob_data    ;

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 
 

        // FIXME: Combine FIFO's for synthesis
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`STU_CNTL_RX_FIFO_DEPTH     ), 
                       .GENERIC_FIFO_THRESHOLD  (`STU_CNTL_RX_FIFO_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`STACK_UP_INTF_TYPE_WIDTH+`STACK_UP_INTF_DATA_WIDTH+`STACK_UP_INTF_OOB_DATA_WIDTH )
                        ) gfifo (
                                          // Status
                                         .empty            ( empty                                                ),
                                         .almost_full      ( almost_full                                          ),
                                         .almost_empty     (                                                      ),
                                         .depth            (                                                      ),
                                          // Write                                                               
                                         .write            ( write                                                ),
                                         .write_data       ( {write_cntl, write_type, write_data, write_oob_data} ),
                                          // Read                                               
                                         .read             ( read                                                 ),
                                         .read_data        ( { read_cntl,  read_type,  read_data,  read_oob_data} ),

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
        reg    [`COMMON_STD_INTF_CNTL_RANGE     ]            pipe_cntl         ;
        reg    [`STACK_UP_INTF_TYPE_RANGE       ]            pipe_type       ;
        //stack_up_type                                        pipe_type         ;
        reg    [`STACK_UP_INTF_DATA_RANGE       ]            pipe_data         ;
        reg    [`STACK_UP_INTF_OOB_DATA_RANGE   ]            pipe_oob_data     ;
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
            pipe_cntl       <= ( fifo_pipe_read     ) ? read_cntl        :
                                                        pipe_cntl        ;
            pipe_type       <= ( fifo_pipe_read     ) ? read_type        :
                                                        pipe_type        ;
            pipe_data       <= ( fifo_pipe_read     ) ? read_data        :
                                                        pipe_data        ;
            pipe_oob_data   <= ( fifo_pipe_read     ) ? read_oob_data    :
                                                        pipe_oob_data    ;
          end

      end
  endgenerate

  assign from_Stu_Fifo[0].clear          =   1'b0                      ;
  assign from_Stu_Fifo[0].write          =   stu__mgr__valid_d1        ;
  assign from_Stu_Fifo[0].write_cntl     =   stu__mgr__cntl_d1         ;
  assign from_Stu_Fifo[0].write_type     =   stu__mgr__type_d1         ;
  assign from_Stu_Fifo[0].write_data     =   stu__mgr__data_d1         ;
  assign from_Stu_Fifo[0].write_oob_data =   stu__mgr__oob_data_d1     ;
         
  assign mgr__stu__ready_e1              = ~from_Stu_Fifo[0].almost_full  ;



  //----------------------------------------------------------------------------------------------------
  // Upstream Packet Processing FSM
  //
  reg                                  is_data_cycle               ;

  reg [`STU_CNTL_RX_CNTL_STATE_RANGE ] stu_cntl_rx_cntl_state      ; // state flop
  reg [`STU_CNTL_RX_CNTL_STATE_RANGE ] stu_cntl_rx_cntl_state_next ;
  
  

  // State register 
  always @(posedge clk)
    begin
      stu_cntl_rx_cntl_state <= ( reset_poweron ) ? `STU_CNTL_RX_CNTL_WAIT       :
                                                    stu_cntl_rx_cntl_state_next  ;
    end
  
  // Extract the tag from the oob_data in the first cycle
 
  always @(*)
    begin
      case (stu_cntl_rx_cntl_state)
        
        `STU_CNTL_RX_CNTL_WAIT: 
          stu_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_CONTROL) ) ? `STU_CNTL_RX_CNTL_CONTROL_SOM       :  // start processing control
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_CONTROL) ) ? `STU_CNTL_RX_CNTL_CONTROL_COMPLETE  :  // start processing control
                                         //( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_DATA   ) ) ? `STU_CNTL_RX_CNTL_DATA_SOM          :  // start processing data
                                         //( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_DATA   ) ) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE     :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && ( is_data_cycle                                         ) ) ? `STU_CNTL_RX_CNTL_DATA_SOM          :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && ( is_data_cycle                                         ) ) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE     :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read                                                                                                                             ) ? `STU_CNTL_RX_CNTL_ERR               :  // first cycle must be data or control
                                                                                                                                                                                                      `STU_CNTL_RX_CNTL_WAIT              ;
  

        // May not need all these states, but it may help with debug
        
        `STU_CNTL_RX_CNTL_CONTROL_SOM: // start of message
          stu_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `STU_CNTL_RX_CNTL_CONTROL_MOM          :  // continue processing command
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `STU_CNTL_RX_CNTL_CONTROL_COMPLETE     :  // initiate command
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `STU_CNTL_RX_CNTL_ERR                  :  // error
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `STU_CNTL_RX_CNTL_ERR                  :  // error
                                                                                                                                          `STU_CNTL_RX_CNTL_CONTROL_SOM          ;

        `STU_CNTL_RX_CNTL_CONTROL_MOM: // middle of message
          stu_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `STU_CNTL_RX_CNTL_CONTROL_MOM          :  // continue processing command
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `STU_CNTL_RX_CNTL_CONTROL_COMPLETE     :  // initiate command
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `STU_CNTL_RX_CNTL_ERR                  :  // error
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `STU_CNTL_RX_CNTL_ERR                  :  // error
                                                                                                                                          `STU_CNTL_RX_CNTL_CONTROL_MOM          ;
        `STU_CNTL_RX_CNTL_CONTROL_COMPLETE: 
          stu_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_CONTROL) ) ? `STU_CNTL_RX_CNTL_CONTROL_SOM       :  // start processing control
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_CONTROL) ) ? `STU_CNTL_RX_CNTL_CONTROL_COMPLETE  :  // start processing control
                                         //( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_Stu_Fifo[0].pipe_type != STU_PACKET_TYPE_TAG_ONLY   ) ) ? `STU_CNTL_RX_CNTL_DATA_SOM          :  // start processing data
                                         //( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_Stu_Fifo[0].pipe_type != STU_PACKET_TYPE_TAG_ONLY   ) ) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE     :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && ( is_data_cycle                                       ) ) ? `STU_CNTL_RX_CNTL_DATA_SOM          :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && ( is_data_cycle                                       ) ) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE     :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read                                                                                                                             ) ? `STU_CNTL_RX_CNTL_ERR               :  // first cycle must be data or control
                                                                                                                                                                                                      `STU_CNTL_RX_CNTL_WAIT              ;  // just go back to WAIT
  
        `STU_CNTL_RX_CNTL_DATA_SOM: // start of message
          stu_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `STU_CNTL_RX_CNTL_DATA_MOM      :  // continue processing command
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE :  // initiate command
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `STU_CNTL_RX_CNTL_ERR           :  // error
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `STU_CNTL_RX_CNTL_ERR           :  // error
                                                                                                                                          `STU_CNTL_RX_CNTL_DATA_SOM      ;

        `STU_CNTL_RX_CNTL_DATA_MOM: // middle of message
          stu_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM    )) ? `STU_CNTL_RX_CNTL_DATA_MOM      :  // continue processing command
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM    )) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE :  // initiate command
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? `STU_CNTL_RX_CNTL_ERR           :  // error
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? `STU_CNTL_RX_CNTL_ERR           :  // error
                                                                                                                                          `STU_CNTL_RX_CNTL_DATA_MOM      ;
/*
        `STU_CNTL_RX_CNTL_DATA_COMPLETE: 
          stu_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_Stu_Fifo[0].pipe_type != STU_PACKET_TYPE_TAG_ONLY) ) ? `STU_CNTL_RX_CNTL_DATA_SOM       :  // start processing control
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_Stu_Fifo[0].pipe_type != STU_PACKET_TYPE_TAG_ONLY) ) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE  :  // start processing control
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && (from_Stu_Fifo[0].pipe_type != STU_PACKET_TYPE_TAG_ONLY) ) ? `STU_CNTL_RX_CNTL_DATA_SOM       :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (from_Stu_Fifo[0].pipe_type != STU_PACKET_TYPE_TAG_ONLY) ) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE  :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read                                                                                                                          ) ? `STU_CNTL_RX_CNTL_ERR            :  // first cycle must be data or control
                                                                                                                                                                                                   `STU_CNTL_RX_CNTL_WAIT           ;  // just go back to WAIT
*/

        `STU_CNTL_RX_CNTL_DATA_COMPLETE: 
          stu_cntl_rx_cntl_state_next =  ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && (is_data_cycle             ) ) ? `STU_CNTL_RX_CNTL_DATA_SOM       :  // start processing control
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (is_data_cycle             ) ) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE  :  // start processing control
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    ) && (is_data_cycle             ) ) ? `STU_CNTL_RX_CNTL_DATA_SOM       :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read && (from_Stu_Fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (is_data_cycle             ) ) ? `STU_CNTL_RX_CNTL_DATA_COMPLETE  :  // start processing data
                                         ( from_Stu_Fifo[0].pipe_read                                                                                                  ) ? `STU_CNTL_RX_CNTL_ERR            :  // first cycle must be data or control
                                                                                                                                                                           `STU_CNTL_RX_CNTL_WAIT           ;  // just go back to WAIT

        // Latch state on error
        `STU_CNTL_RX_CNTL_ERR:
          stu_cntl_rx_cntl_state_next = `STU_CNTL_RX_CNTL_ERR ;
  
        default:
          stu_cntl_rx_cntl_state_next = `STU_CNTL_RX_CNTL_WAIT ;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  

  //----------------------------------------------------------------------------------------------------
  // Assignments
  //
  assign stuc__rcp__valid_e1    =   (stu_cntl_rx_cntl_state == `STU_CNTL_RX_CNTL_WAIT            ) & (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_CONTROL) & from_Stu_Fifo[0].pipe_valid & rcp__stuc__ready  |  // data packets to Response data processor
                                    (stu_cntl_rx_cntl_state == `STU_CNTL_RX_CNTL_CONTROL_SOM     ) &                                                           from_Stu_Fifo[0].pipe_valid & rcp__stuc__ready  |
                                    (stu_cntl_rx_cntl_state == `STU_CNTL_RX_CNTL_CONTROL_MOM     ) &                                                           from_Stu_Fifo[0].pipe_valid & rcp__stuc__ready  |
                                    (stu_cntl_rx_cntl_state == `STU_CNTL_RX_CNTL_CONTROL_COMPLETE) &                                                           from_Stu_Fifo[0].pipe_valid & rcp__stuc__ready  ;  // data packets to Response data processor

  assign stuc__rdp__valid_e1    =   //(stu_cntl_rx_cntl_state == `STU_CNTL_RX_CNTL_WAIT          ) & (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_DATA   ) & from_Stu_Fifo[0].pipe_valid & rdp__stuc__ready  |  // data packets to Response data processor
                                    (stu_cntl_rx_cntl_state == `STU_CNTL_RX_CNTL_WAIT            ) & ( is_data_cycle                                       ) & from_Stu_Fifo[0].pipe_valid & rdp__stuc__ready  |  // data packets to Response data processor
                                    (stu_cntl_rx_cntl_state == `STU_CNTL_RX_CNTL_DATA_SOM        ) &                                                           from_Stu_Fifo[0].pipe_valid & rdp__stuc__ready  |
                                    (stu_cntl_rx_cntl_state == `STU_CNTL_RX_CNTL_DATA_MOM        ) &                                                           from_Stu_Fifo[0].pipe_valid & rdp__stuc__ready  |
                                    (stu_cntl_rx_cntl_state == `STU_CNTL_RX_CNTL_DATA_COMPLETE   ) &                                                           from_Stu_Fifo[0].pipe_valid & rdp__stuc__ready  ;  // data packets to Response data processor

  assign from_Stu_Fifo[0].pipe_read   =  stuc__rcp__valid_e1 | stuc__rdp__valid_e1 ;

  always @(*)
    begin
      is_data_cycle      =  (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_TAG_AND_DATA_ONE   )  | 
                            (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_TAG_AND_DATA_TWO   )  | 
                            (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_TAG_AND_DATA_THREE )  | 
                            (from_Stu_Fifo[0].pipe_type == STU_PACKET_TYPE_TAG_AND_DATA_FOUR  )  ;
                                                                                                    
    end

  always @(*)
    begin
      // extract tag from upstream packet
      response_packet_tag = from_Stu_Fifo[0].pipe_oob_data [`STACK_DOWN_OOB_INTF_TAG_RANGE ] ;  
    end

  assign stuc__rdp__tag_e1  = response_packet_tag        ;
  assign stuc__rdp__cntl_e1 = from_Stu_Fifo[0].pipe_cntl ;
  assign stuc__rdp__data_e1 = from_Stu_Fifo[0].pipe_data ;


endmodule





