/***********************************************************************************************************************************************

    File name   : mgr_noc_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

    Description : This module interfaces to the streaming controller.
                  Initially the NoC has a single interface to the stOp_cntl and takes packets one-by-one. This may not make best use 
                  as a packet can be directed out any one of the four NoC ports.
                  FIXME: maybe provide interfaces for each exec lane via the stOp_cntl

             We use a consistent method for directing a packet to a destination port. The source waits for all destinations to be ready 
             before sending and all destinations grab the transfer simultaneously.
               a) The source asserts Req along with the address bit field
               b) The destinations 'AND' the address with their bitfield mask.
               c) Each destination asserts their Ack immediately whether they are ready or not forming an Ack vector
               d) When each destination is ready, the source latches the Ack vector.
             The transfer starts and stalls whenever the Ready vector does not equal the Ack vector

                          ______        ______        ______        ______        ______        ______        ______        ______        ____
                    _____|      |______|      |______|      |______|      |______|      |______|      |______|      |______|      |______|    
                               ______________       _______________                                   
            Req     __________|               ......               |___________________________________________________________________________
                    
                               __________           _______________
           Address  ----------|__________bit address_______________|---------------------------------------------------------------------------
                    
                               __________             _____________
            Ack     ----------|__________ AckBitField _____________|--------------------------------------------------------------------------- 
      
                                                      ___________      __________ ___        ______________      __________
            Ready   ---------------------------------|___________ready __________|__not ready__|___________ready __________|-------------------
                    
                                        _____________               _______________________________________________________
       Latched Ack  -------------------|_____________AckBitField_d1 _______________________________________________________|-------------------
                    
                                                                   ^             ^             X             ^             ^
                                                                 Start    Each cycle continues if destinationReady == AckBitField_d1

***********************************************************************************************************************************************/
    

`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "stack_interface.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "mgr_noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "dma_cont.vh"
`include "streamingOps.vh"
`include "temp.vh"


module mgr_noc_cntl (

                  // Aggregate Control-path (cp) to NoC 
                  locl__noc__cp_valid      , 
                  locl__noc__cp_cntl       , 
                  noc__locl__cp_ready      , 
                  locl__noc__cp_type       ,  // packet type : Descriptor based memory write data
                  locl__noc__cp_ptype      ,  // payload type : tuples, data
                  locl__noc__cp_desttype   ,  // destination type, bitfield, mcast group
                  locl__noc__cp_pvalid     ,  // payload valid 0=32, 1=64
                  locl__noc__cp_data       , 
                  //locl__noc__cp_laneId     , 
                  //locl__noc__cp_strmId     , 
                  // Aggregate datapath (cp) from NoC 
                  noc__locl__cp_valid      , 
                  noc__locl__cp_cntl       , 
                  locl__noc__cp_ready      , 
                  noc__locl__cp_type       , 
                  noc__locl__cp_ptype      , 
                  noc__locl__cp_data       , 
                  noc__locl__cp_mgrId      ,   // source Manager ID
                  //noc__locl__cp_laneId     , 
                  //noc__locl__cp_strmId     , 
                
                  // Aggregate Datapath (dp) to NoC 
                  locl__noc__dp_valid      , 
                  locl__noc__dp_cntl       , 
                  noc__locl__dp_ready      , 
                  locl__noc__dp_type       ,  // packet type : Descriptor based memory write data
                  locl__noc__dp_ptype      ,  // payload type : tuples, data
                  locl__noc__dp_desttype   ,  // destination type, bitfield, mcast group
                  locl__noc__dp_pvalid     ,  // payload valid 0=32, 1=64
                  locl__noc__dp_data       , 

                  // Aggregate datapath (dp) from NoC 
                  noc__locl__dp_valid      , 
                  noc__locl__dp_cntl       , 
                  locl__noc__dp_ready      , 
                  noc__locl__dp_type       , 
                  noc__locl__dp_ptype      , 
                  noc__locl__dp_data       , 
                  noc__locl__dp_mgrId      ,   // source Manager ID
                  //noc__locl__dp_laneId     , 
                  //noc__locl__dp_strmId     , 

                  // NoC Ports
                 `include "manager_noc_cntl_noc_ports.vh"

                  sys__mgr__mgrId   ,
                  clk               ,
                  reset_poweron     

    );

  input                       clk             ;
  input                       reset_poweron   ;
  input [`MGR_MGR_ID_RANGE ]  sys__mgr__mgrId ; 

  // Information between CNTL and NOC is a packet interface not a stream interface.
  // This means that every packet is delineated with SOP and EOP.
  // With a stream interface, the entire stream is delineated with SOD and EOD
  // For information to NoC, the cntl will need to add SOP/EOP to the stream from stOp to delineate all packets
  // For information from NoC, for a multi-packet transfer such as a DMA, to generate the stream to stOp, the cntl will detect 
  // the first data packet type of DMA_DATA_SOD and add SOD to the first transaction. The cntl then transfers while setting
  // cntl=data until the last packet type of DMA_DATA_EOD and adds cntl=EOD to the last transaction.
  //
  // Aggregate Control-path (cp) to NoC 
  input                                             locl__noc__cp_valid      ; 
  input  [`COMMON_STD_INTF_CNTL_RANGE             ] locl__noc__cp_cntl       ; 
  output                                            noc__locl__cp_ready      ; 
  input  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] locl__noc__cp_type       ; 
  input  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] locl__noc__cp_ptype      ; 
  input  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ] locl__noc__cp_desttype   ; 
  input                                             locl__noc__cp_pvalid     ; 
  input  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] locl__noc__cp_data       ; 
  //input  [`PE_EXEC_LANE_ID_RANGE                  ] locl__noc__cp_laneId     ; 
  //input                                             locl__noc__cp_strmId     ; 
  
  // Aggregate Data-path (dp) to NoC 
  input                                             locl__noc__dp_valid      ; 
  input  [`COMMON_STD_INTF_CNTL_RANGE             ] locl__noc__dp_cntl       ; 
  output                                            noc__locl__dp_ready      ; 
  input  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] locl__noc__dp_type       ; 
  input  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] locl__noc__dp_ptype      ; 
  input  [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ] locl__noc__dp_desttype   ; 
  input                                             locl__noc__dp_pvalid     ; 
  input  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] locl__noc__dp_data       ; 
  //input  [`PE_EXEC_LANE_ID_RANGE                  ] locl__noc__dp_laneId     ; 
  //input                                             locl__noc__dp_strmId     ; 
 
  // Aggregate Control-path (cp) from NoC 
  output                                            noc__locl__cp_valid      ; 
  output [`COMMON_STD_INTF_CNTL_RANGE             ] noc__locl__cp_cntl       ; 
  input                                             locl__noc__cp_ready      ; 
  output [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] noc__locl__cp_type       ; 
  output [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] noc__locl__cp_ptype      ; 
  output [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] noc__locl__cp_data       ; 
  output [`MGR_MGR_ID_RANGE                       ] noc__locl__cp_mgrId      ; 
  //output [`PE_EXEC_LANE_ID_RANGE                  ] noc__locl__cp_laneId     ; 
  //output                                            noc__locl__cp_strmId     ; 

  // Aggregate Data-path (dp) from NoC 
  output                                            noc__locl__dp_valid      ; 
  output [`COMMON_STD_INTF_CNTL_RANGE             ] noc__locl__dp_cntl       ; 
  input                                             locl__noc__dp_ready      ; 
  output [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] noc__locl__dp_type       ; 
  output [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] noc__locl__dp_ptype      ; 
  output [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] noc__locl__dp_data       ; 
  output [`MGR_MGR_ID_RANGE                       ] noc__locl__dp_mgrId      ; 
  //output [`PE_EXEC_LANE_ID_RANGE                  ] noc__locl__dp_laneId     ; 
  //output                                            noc__locl__dp_strmId     ; 


  `include "mgr_noc_cntl_noc_ports_declaration.vh"

   
  //-------------------------------------------------------------------------------------------
  // Wires and Register
  //

  reg                                               noc__locl__cp_ready      ; 
  reg                                               noc__locl__dp_ready      ; 

  `include "mgr_noc_cntl_noc_ports_wires.vh"

  reg [`MGR_MGR_ID_BITMASK_RANGE              ]   thisMgrBitMask           ;  // bit field used to mask off bits associated with this manager

  reg                                             noc__locl__cp_valid      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]   noc__locl__cp_cntl       ; 

  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]   noc__locl__cp_type       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]   noc__locl__cp_ptype      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]   noc__locl__cp_data       ; 
  reg  [`MGR_MGR_ID_RANGE                     ]   noc__locl__cp_mgrId      ; 
                                                 
  reg                                             noc__locl__cp_valid_p1   ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]   noc__locl__cp_cntl_p1    ; 

  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]   noc__locl__cp_type_p1    ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]   noc__locl__cp_ptype_p1   ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]   noc__locl__cp_data_p1    ; 
  reg  [`MGR_MGR_ID_RANGE                     ]   noc__locl__cp_mgrId_p1   ; 
  reg                                             locl__noc__cp_ready_d1   ; 
                                                 
                                                 
  reg                                             noc__locl__dp_valid      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]   noc__locl__dp_cntl       ; 
                                                 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]   noc__locl__dp_type       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]   noc__locl__dp_ptype      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]   noc__locl__dp_data       ; 
  reg  [`MGR_MGR_ID_RANGE                     ]   noc__locl__dp_mgrId      ; 
                                                 
  reg                                             noc__locl__dp_valid_p1   ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE           ]   noc__locl__dp_cntl_p1    ; 
                                                 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE   ]   noc__locl__dp_type_p1    ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE  ]   noc__locl__dp_ptype_p1   ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE     ]   noc__locl__dp_data_p1    ; 
  reg  [`MGR_MGR_ID_RANGE                     ]   noc__locl__dp_mgrId_p1   ; 
  reg                                             locl__noc__dp_ready_d1   ; 
  
  reg                                               locl__noc__cp_valid_d1      ; 
  reg    [`COMMON_STD_INTF_CNTL_RANGE          ]    locl__noc__cp_cntl_d1       ; 
  wire                                              noc__locl__cp_ready_p1      ; 
  reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    locl__noc__cp_type_d1       ; 
  reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    locl__noc__cp_ptype_d1      ; 
  reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    locl__noc__cp_desttype_d1   ; 
  reg                                               locl__noc__cp_pvalid_d1     ; 
  reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    locl__noc__cp_data_d1       ; 
                                                   
  // Aggregate Data-path (dp) to NoC               
  reg                                               locl__noc__dp_valid_d1      ; 
  reg    [`COMMON_STD_INTF_CNTL_RANGE          ]    locl__noc__dp_cntl_d1       ; 
  wire                                              noc__locl__dp_ready_p1      ; 
  reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    locl__noc__dp_type_d1       ; 
  reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    locl__noc__dp_ptype_d1      ; 
  reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    locl__noc__dp_desttype_d1   ; 
  reg                                               locl__noc__dp_pvalid_d1     ; 
  reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    locl__noc__dp_data_d1       ; 
  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registered Inputs and Outputs
  
  always @(posedge clk)
    begin
      locl__noc__cp_valid_d1       <= ( reset_poweron   ) ? 'd0  :  locl__noc__cp_valid       ;
      locl__noc__cp_cntl_d1        <= ( reset_poweron   ) ? 'd0  :  locl__noc__cp_cntl        ;
      noc__locl__cp_ready          <= ( reset_poweron   ) ? 'd0  :  noc__locl__cp_ready_p1    ;
      locl__noc__cp_type_d1        <= ( reset_poweron   ) ? 'd0  :  locl__noc__cp_type        ;
      locl__noc__cp_ptype_d1       <= ( reset_poweron   ) ? 'd0  :  locl__noc__cp_ptype       ;
      locl__noc__cp_desttype_d1    <= ( reset_poweron   ) ? 'd0  :  locl__noc__cp_desttype    ;
      locl__noc__cp_pvalid_d1      <= ( reset_poweron   ) ? 'd0  :  locl__noc__cp_pvalid      ;
      locl__noc__cp_data_d1        <= ( reset_poweron   ) ? 'd0  :  locl__noc__cp_data        ;
                                                                    
      locl__noc__dp_valid_d1       <= ( reset_poweron   ) ? 'd0  :  locl__noc__dp_valid       ;
      locl__noc__dp_cntl_d1        <= ( reset_poweron   ) ? 'd0  :  locl__noc__dp_cntl        ;
      noc__locl__dp_ready          <= ( reset_poweron   ) ? 'd0  :  noc__locl__dp_ready_p1    ;
      locl__noc__dp_type_d1        <= ( reset_poweron   ) ? 'd0  :  locl__noc__dp_type        ;
      locl__noc__dp_ptype_d1       <= ( reset_poweron   ) ? 'd0  :  locl__noc__dp_ptype       ;
      locl__noc__dp_desttype_d1    <= ( reset_poweron   ) ? 'd0  :  locl__noc__dp_desttype    ;
      locl__noc__dp_pvalid_d1      <= ( reset_poweron   ) ? 'd0  :  locl__noc__dp_pvalid      ;
      locl__noc__dp_data_d1        <= ( reset_poweron   ) ? 'd0  :  locl__noc__dp_data        ;

      noc__locl__cp_valid          <= ( reset_poweron   ) ? 'd0  :  noc__locl__cp_valid_p1    ;
      noc__locl__cp_cntl           <= ( reset_poweron   ) ? 'd0  :  noc__locl__cp_cntl_p1     ;
      locl__noc__cp_ready_d1       <= ( reset_poweron   ) ? 'd0  :  noc__locl__cp_ready       ;
      noc__locl__cp_type           <= ( reset_poweron   ) ? 'd0  :  noc__locl__cp_type_p1     ;
      noc__locl__cp_ptype          <= ( reset_poweron   ) ? 'd0  :  noc__locl__cp_ptype_p1    ;
      noc__locl__cp_data           <= ( reset_poweron   ) ? 'd0  :  noc__locl__cp_data_p1     ;
                                                                    
      noc__locl__dp_valid          <= ( reset_poweron   ) ? 'd0  :  noc__locl__dp_valid_p1    ;
      noc__locl__dp_cntl           <= ( reset_poweron   ) ? 'd0  :  noc__locl__dp_cntl_p1     ;
      locl__noc__dp_ready_d1       <= ( reset_poweron   ) ? 'd0  :  locl__noc__dp_ready       ;
      noc__locl__dp_type           <= ( reset_poweron   ) ? 'd0  :  noc__locl__dp_type_p1     ;
      noc__locl__dp_ptype          <= ( reset_poweron   ) ? 'd0  :  noc__locl__dp_ptype_p1    ;
      noc__locl__dp_data           <= ( reset_poweron   ) ? 'd0  :  noc__locl__dp_data_p1     ;
    end

  //-------------------------------------------------------------------------------------------
  // General use assignments
  //

  `include "mgr_noc_cntl_create_thisMgr_bitmask_address.vh"
  `include "mgr_noc_cntl_noc_general_assignments.vh"


  //------------------------------------------------------------
  // Control and Data to NoC FIFO(s)
  //

  genvar gvi;
  generate
    for (gvi=0; gvi<2; gvi=gvi+1) 
      begin: from_local_fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE          ]    write_cntl       ;
        reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    write_type       ; 
        reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    write_ptype      ; 
        reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    write_desttype   ; 
        reg                                               write_pvalid     ; 
        reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    write_data       ; 

        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE          ]    read_cntl        ;
        wire   [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]    read_type        ; 
        wire   [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]    read_ptype       ; 
        wire   [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]    read_desttype    ; 
        wire                                              read_pvalid      ; 
        wire   [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]    read_data        ; 

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        wire                                              write            ; 
 

        // Combine FIFO bits
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_DEPTH                 ), 
                       .GENERIC_FIFO_THRESHOLD  (`MGR_NOC_CONT_TO_INTF_DATA_FIFO_ALMOST_FULL_THRESHOLD ),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_NOC_CONT_NOC_PACKET_TYPE_WIDTH+`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_WIDTH+`MGR_NOC_CONT_NOC_DEST_TYPE_WIDTH+1+`MGR_NOC_CONT_INTERNAL_DATA_WIDTH)
                        ) fromLocal_fifo (
                                          // Status
                                         .empty            ( empty                                     ),
                                         .almost_full      ( almost_full                               ),
                                          // Write                                                     
                                         .write            ( write                                     ),
                                         .write_data       ( {write_cntl, write_type, write_ptype, write_desttype, write_pvalid, write_data}),
                                          // Read                                                
                                         .read             ( read                                      ),
                                         .read_data        ( { read_cntl,  read_type,  read_ptype,  read_desttype,  read_pvalid,  read_data}),

                                         // General
                                         .clear            ( clear                                     ),
                                         .reset_poweron    ( reset_poweron                             ),
                                         .clk              ( clk                                       )
                                         );
        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE          ]       pipe_cntl         ;
        reg    [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE  ]       pipe_type         ; 
        reg    [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE ]       pipe_ptype        ; 
        reg    [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE    ]       pipe_desttype     ; 
        reg                                                  pipe_pvalid       ; 
        reg    [`MGR_NOC_CONT_INTERNAL_DATA_RANGE    ]       pipe_data         ; 

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
            pipe_type           <= ( fifo_pipe_read     ) ? read_type            :
                                                            pipe_type            ;
            pipe_ptype          <= ( fifo_pipe_read     ) ? read_ptype           :
                                                            pipe_ptype           ;
            pipe_desttype       <= ( fifo_pipe_read     ) ? read_desttype        :
                                                            pipe_desttype        ;
            pipe_pvalid         <= ( fifo_pipe_read     ) ? read_pvalid          :
                                                            pipe_pvalid          ;
            pipe_data           <= ( fifo_pipe_read     ) ? read_data            :
                                                            pipe_data            ;
          end

        reg    [`MGR_NOC_CONT_TO_INTF_DATA_FIFO_PKT_CNT_RANGE ]    pkt_count       ;
        always @(posedge clk)
          begin
            pkt_count  <=  ( reset_poweron || clear                                                                                                ) ? 'd0             :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_EOM    )) && (~pipe_read                                              )) ? pkt_count + 'd1 :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_EOM    )) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? pkt_count       :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_EOM    )) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? pkt_count       :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) && (~pipe_read                                              )) ? pkt_count + 'd1 :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? pkt_count       :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? pkt_count       :
                           ((~write                                                 ) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? pkt_count - 'd1 :
                           ((~write                                                 ) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? pkt_count - 'd1 :
                                                                                                                                                       pkt_count       ;
          end

        assign clear   =   1'b0                ;

      end
  endgenerate

  //--------------------------------------------------
  // Control
  assign from_local_fifo[0].write         =   locl__noc__cp_valid_d1  ;
  always @(*)
    begin
      from_local_fifo[0].write_cntl       =   locl__noc__cp_cntl_d1     ;
      from_local_fifo[0].write_type       =   locl__noc__cp_type_d1     ;
      from_local_fifo[0].write_ptype      =   locl__noc__cp_ptype_d1    ;
      from_local_fifo[0].write_desttype   =   locl__noc__cp_desttype_d1 ;
      from_local_fifo[0].write_pvalid     =   locl__noc__cp_pvalid_d1   ;
      from_local_fifo[0].write_data       =   locl__noc__cp_data_d1     ;
    end
         
  assign noc__locl__cp_ready_p1              = ~from_local_fifo[0].almost_full  ;

  //--------------------------------------------------
  // Data
  assign from_local_fifo[1].write         =   locl__noc__dp_valid_d1  ;
  always @(*)
    begin
      from_local_fifo[1].write_cntl       =   locl__noc__dp_cntl_d1     ;
      from_local_fifo[1].write_type       =   locl__noc__dp_type_d1     ;
      from_local_fifo[1].write_ptype      =   locl__noc__dp_ptype_d1    ;
      from_local_fifo[1].write_desttype   =   locl__noc__dp_desttype_d1 ;
      from_local_fifo[1].write_pvalid     =   locl__noc__dp_pvalid_d1   ;
      from_local_fifo[1].write_data       =   locl__noc__dp_data_d1     ;
    end
         
  assign noc__locl__dp_ready_p1              = ~from_local_fifo[1].almost_full  ;

  //--------------------------------------------------------------------------



  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  //  ******** TRAFFIC OUT OF THE NODE ********
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  // Local output Control
  //

  //--------------------------------------------------------------------------------------------
  //  wires
  
  // from local FIFO flags for FSM
  wire from_local_cp_fifo_som           = (from_local_fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM) | (from_local_fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) ;
  wire from_local_cp_fifo_eom           = (from_local_fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM) | (from_local_fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) ;
  wire from_local_cp_fifo_mom           = (from_local_fifo[0].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM) ;
  wire from_local_cp_fifo_pkt_available = (from_local_fifo[0].pkt_count > 0) ;

  wire from_local_dp_fifo_som           = (from_local_fifo[1].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM) | (from_local_fifo[1].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) ;
  wire from_local_dp_fifo_eom           = (from_local_fifo[1].pipe_cntl == `COMMON_STD_INTF_CNTL_EOM) | (from_local_fifo[1].pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) ;
  wire from_local_dp_fifo_mom           = (from_local_fifo[1].pipe_cntl == `COMMON_STD_INTF_CNTL_MOM) ;
  wire from_local_dp_fifo_pkt_available = (from_local_fifo[1].pkt_count > 0) ;

  wire                                       local_toNoc_valid           ;  // when valid, destination port(s) must write local output data to their output fifo's
  reg  [`MGR_NOC_CONT_NOC_PORT_CNTL_RANGE ]  local_cntl_toNoc            ;  // local output cntl to destination port to be sent directly to network
  reg  [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  local_data_toNoc            ;  // local output data to destination port to be sent directly to network
                                                                         
  wire                                       local_destinationReq        ; // Destination accepts the request and this fsm doesnt know who
  wire [`MGR_MGR_ID_BITMASK_RANGE         ]  local_destinationCpReqAddr  ; // bitmask address from header of packet
  wire [`MGR_MGR_ID_BITMASK_RANGE         ]  local_destinationDpReqAddr  ; // bitmask address from header of packet
  wire [`MGR_MGR_ID_BITMASK_RANGE         ]  local_destinationReqAddr    ; // destination address of selected either Control or Data packet
  reg  [`MGR_MGR_ID_BITMASK_RANGE         ]  local_destinationReqAddr_d1 ; // Keep a registered version for transfer

  // all destinations 'AND' with their bitmask and 'ack' if it matches
  // Input controller waits until all ACK vector matches READY vector (e.g. all destinations are ready)
                                                      
  // The Port input controller must provide the priority of the packet
  // to allow appropriate directing of the packet. Right now only local
  // distinguishes between CP and DP.
  // The priority of the packet does not affect destination arbitration but simply the transfer.
  //reg                        destinationHpReq    ;  // output hi-priority request to CP local InQ fsm
  //reg                        destinationLpReq    ;  // output lo-priority request to CP local InQ fsm
  //
  // All possible destinations may ack the request if its a multicast.
  // The Port input controller must wait for all relavant enables to be asserted before starting transfer (reading fifo)
  wire  [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ]  local_destinationReady    ;  // Start reading input fifo, destination handles directing the information
  wire                                                  local_destinationReady_d1 ;  // Destination ready gated with ack vector
  wire  [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ]  local_destinationAck      ;  // input from CP local InQ fsm
  reg   [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ]  local_destinationAck_d1   ;  // Register the acking destinations so we can keep track of each destinations ready signal
 
  //
  // wires to make fsm easier to read
  wire  local_allDestinationsInitiallyReady  = ( local_destinationAck    == (local_destinationReady & local_destinationAck   ) );  // Used for the first ack and ready are asserted
  wire  local_allDestinationsStillReady      = ( local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1) );  // Used after the intial ack and ready
                                                                                                                                   // We stored which destination(s) and make sure all ready's are asserted when transferring when destination is ready
                                                                                                                                   //
  wire  from_local_fifo_pkt_available        = ( from_local_cp_fifo_pkt_available | from_local_dp_fifo_pkt_available           );  // either control or data packet is available
  wire  readingLocalOutputFifo               = ( from_local_fifo[0].pipe_read     | from_local_fifo[1].pipe_read               );  // we only read from one at a time

  //--------------------------------------------------------------------------------------------
  // Local Port outputing to NoC FSM
  //

  reg [`MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_RANGE] nc_local_outq_cntl_state;          // state flop
  reg [`MGR_NOC_CONT_LOCAL_OUTQ_CNTL_STATE_RANGE] nc_local_outq_cntl_state_next;
  
  
  // State register 
  always @(posedge clk)
    begin
      nc_local_outq_cntl_state <= (reset_poweron ) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT :
                                                   nc_local_outq_cntl_state_next        ;
    end
  
  always @(*)
    begin
      case (nc_local_outq_cntl_state)
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT: 
          nc_local_outq_cntl_state_next = (( from_local_cp_fifo_pkt_available ) && ~from_local_cp_fifo_som )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_ERROR       :  // DEBUG: Check for SOM to make sure we havent got out of sync
                                          (( from_local_dp_fifo_pkt_available ) && ~from_local_dp_fifo_som )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_ERROR       :  // 
                                          (  from_local_cp_fifo_pkt_available                              )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ :  // only request transmission when we have a packets worth
                                          (  from_local_dp_fifo_pkt_available                              )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ :
                                                                                                                `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT        ;
  
        //----------------------------------------------------------------------------------------------------
        // from Control FIFO
        //
        // Put the destination bitfield out there to be accepted by one of the output ports
        // The output port has to acknowledge even if it isnt ready but the outq controller will only transfer once the destination is ready.
        // Note: Request set if "next" state is PORT_REQ
        // Note: The destination keeps the Ack asserted until the request is deasserted. The request is asserted all the time the next state is PORT_REQ.
        // When we see the first ready, we send the header and move to tuples
        
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ:
          nc_local_outq_cntl_state_next = ( ~|local_destinationAck                ) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ     :
                                          ( local_allDestinationsInitiallyReady   ) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_TUPLE   :  // output port has acked and all ports ready, so send header and next is tuple(s)
                                                                                      `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ     ;
/*
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_TUPLE ;
*/

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_TUPLE:
          nc_local_outq_cntl_state_next = ( readingLocalOutputFifo & (from_local_fifo[0].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_DATA) &&  from_local_cp_fifo_eom )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_COMPLETE    :
                                          ( readingLocalOutputFifo & (from_local_fifo[0].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_DATA) && ~from_local_cp_fifo_eom )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_DATA   :
                                                                                                                                                                                             `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_TUPLE  ;

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_DATA:
          nc_local_outq_cntl_state_next = ( readingLocalOutputFifo & from_local_cp_fifo_eom )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_COMPLETE   :
                                                                                                 `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_DATA  ;

  
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_COMPLETE:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT ;
  
        //----------------------------------------------------------------------------------------------------
        // from Data FIFO
        //
        // Put the destination bitfield out there to be accepted by one of the output ports
        // The output port has to acknowledge even if it isnt ready but the outq controller will only transfer once the destination is ready.
        // Note: Request set if "next" state is PORT_REQ
        // Note: The destination keeps the Ack asserted until the request is deasserted. The request is asserted all the time the next state is PORT_REQ.
        // When we see the first ready, we send the header and move to tuples
        
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ:
          nc_local_outq_cntl_state_next = ( ~|local_destinationAck                                                 ) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ     :
                                          ( local_destinationAck == (local_destinationReady & local_destinationAck)) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_TUPLE   :  // all output ports have acked and all the ports are ready, so send header and next is tuple(s)
                                                                                                                       `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ     ;
/*
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_TUPLE ;
*/

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_TUPLE:
          nc_local_outq_cntl_state_next = ( readingLocalOutputFifo & (from_local_fifo[1].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_DATA) &&  from_local_dp_fifo_eom )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_COMPLETE    :
                                          ( readingLocalOutputFifo & (from_local_fifo[1].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_DATA) && ~from_local_dp_fifo_eom )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_DATA   :
                                                                                                                                                                                             `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_TUPLE  ;

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_DATA:
          nc_local_outq_cntl_state_next = ( readingLocalOutputFifo & from_local_dp_fifo_eom           )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_COMPLETE   :
                                                                                                           `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_DATA  ;

  
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_COMPLETE:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT ;
  
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_ERROR:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_ERROR ;
  
        default:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  
  //-------------------------------------------------------------------------------------------------
  // Internal signals
  
  //`include "noc_cntl_noc_local_outq_control_assignments.vh"

  assign  local_destinationCpReqAddr  = from_local_fifo[0].pipe_data[`MGR_NOC_CONT_INTERNAL_HEADER_DESTINATION_ADDR_RANGE ];
  assign  local_destinationDpReqAddr  = from_local_fifo[1].pipe_data[`MGR_NOC_CONT_INTERNAL_HEADER_DESTINATION_ADDR_RANGE ];

  // send the address mask from the local packet to NoC output ports during state==PORT_REQ
  assign local_destinationReqAddr      = ( from_local_cp_fifo_pkt_available && (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT )) ? local_destinationCpReqAddr :  // we are going to service a control packet
                                                                                                                                                    local_destinationDpReqAddr ;                    

  // keep request asserted until the destination acks and is ready for the first transfer
  // e.g. keep asserted while next_state == REQ
  assign local_destinationReq          = (( from_local_fifo_pkt_available       && (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT        )) |
                                          (~local_allDestinationsInitiallyReady && (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ )) |
                                          (~local_allDestinationsInitiallyReady && (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ )) );
                                                                                                    

  always @(posedge clk)
    begin
  
      local_destinationReqAddr_d1   <= (reset_poweron                                                                                         ) ? 'd0                          :
                                       ( from_local_cp_fifo_pkt_available && (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT )) ? local_destinationCpReqAddr   :
                                       ( from_local_dp_fifo_pkt_available && (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT )) ? local_destinationDpReqAddr   :
                                                                                                                                                  local_destinationReqAddr_d1  ;

      // the ack from each destination is only active the cycle after the request is deasserted, so latch who acked so we can flow
      // control the transfer using the destinationReady vector
      local_destinationAck_d1 <= (reset_poweron                                                        )  ? 'd0                     :
                                 (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ)  ? local_destinationAck    :
                                 (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ)  ? local_destinationAck    :
                                                                                                            local_destinationAck_d1 ;

      //local_destinationReady_d1 <= ~reset_poweron & (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1)) ;

    end

  assign local_destinationReady_d1 = (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1)) ;


  assign from_local_fifo[0].pipe_read  = ((nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ      ) &     // read head of packet to determine destination bitmask
                                           local_allDestinationsInitiallyReady                                          )|
                                         (((nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_TUPLE  )|
                                           (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_DATA   )) &  
                                            local_allDestinationsStillReady                                             ) ;

  assign from_local_fifo[1].pipe_read  = ((nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ      ) &     // read head of packet to determine destination bitmask
                                           local_allDestinationsInitiallyReady                                          )|
                                         (((nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_TUPLE  )|
                                           (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_DATA   )) &  
                                            local_allDestinationsStillReady                                             ) ;


  assign local_toNoc_valid    = from_local_fifo[0].pipe_read | from_local_fifo[1].pipe_read ;
                                   

  always @(*)
    begin
      case (nc_local_outq_cntl_state)

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ:
          begin
            local_cntl_toNoc                                                              = from_local_fifo[0].pipe_cntl                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE       ] = from_local_fifo[0].pipe_data                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE               ] = 'd`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP  ; 
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE  ] = from_local_fifo[0].pipe_type                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE              ] = sys__mgr__mgrId                              ;
          end
/*
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER:
          begin
            local_cntl_toNoc                                                              = from_local_fifo[0].pipe_cntl                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE       ] = from_local_fifo[0].pipe_data                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE               ] = 'd`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP  ; 
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE  ] = from_local_fifo[0].pipe_type                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE              ] = sys__mgr__mgrId                              ;
          end
*/
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_TUPLE:
          begin
            // at the transition from TUPLE to DATA state, the pipe contains data
            if (from_local_fifo[0].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_DATA)
              begin
                local_cntl_toNoc                                                              = from_local_fifo[0].pipe_cntl                                                       ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE              ] = from_local_fifo[0].pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE      ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE              ] = from_local_fifo[0].pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE      ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_VALID_RANGE      ] = from_local_fifo[0].pipe_pvalid                                                     ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAD0_RANGE               ] = 'd0                                                                                ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_TYPE_RANGE       ] = from_local_fifo[0].pipe_ptype                                                      ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAD1_RANGE               ] = 'd0                                                                                ;
              end
            else
              begin
                local_cntl_toNoc                                                              = from_local_fifo[0].pipe_cntl                                                       ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE         ] = from_local_fifo[0].pipe_data [`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE           ] = from_local_fifo[0].pipe_data [`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE         ] = from_local_fifo[0].pipe_data [`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE           ] = from_local_fifo[0].pipe_data [`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE     ] = from_local_fifo[0].pipe_pvalid                                                     ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAD0_RANGE              ] = 'd0                                                                                ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE      ] = from_local_fifo[0].pipe_ptype                                                      ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE       ] = from_local_fifo[0].pipe_type                                                       ;
              end
          end

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_DATA:
          begin
            local_cntl_toNoc                                                              = from_local_fifo[0].pipe_cntl                                                       ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE              ] = from_local_fifo[0].pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE      ] ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE              ] = from_local_fifo[0].pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE      ] ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_VALID_RANGE      ] = from_local_fifo[0].pipe_pvalid                                                     ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAD0_RANGE               ] = 'd0                                                                                ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_TYPE_RANGE       ] = from_local_fifo[0].pipe_ptype                                                      ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAD1_RANGE               ] = 'd0                                                                                ;
          end
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ:
          begin
            local_cntl_toNoc                                                              = from_local_fifo[1].pipe_cntl                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE       ] = from_local_fifo[1].pipe_data                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE               ] = 'd`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP  ; 
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE  ] = from_local_fifo[1].pipe_type                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE              ] = sys__mgr__mgrId                              ;
          end
/*
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER:
          begin
            local_cntl_toNoc                                                              = from_local_fifo[1].pipe_cntl                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE       ] = from_local_fifo[1].pipe_data                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE               ] = 'd`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP  ; 
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_TYPE_RANGE  ] = from_local_fifo[1].pipe_type                 ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE              ] = sys__mgr__mgrId                              ;
          end
*/

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_TUPLE:
          begin
            // at the transition from TUPLE to DATA state, the pipe contains data
            if (from_local_fifo[1].pipe_ptype == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_DATA)
              begin
                local_cntl_toNoc                                                              = from_local_fifo[1].pipe_cntl                                                       ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE              ] = from_local_fifo[1].pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE      ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE              ] = from_local_fifo[1].pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE      ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_VALID_RANGE      ] = from_local_fifo[1].pipe_pvalid                                                     ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAD0_RANGE               ] = 'd0                                                                                ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_TYPE_RANGE       ] = from_local_fifo[1].pipe_ptype                                                      ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAD1_RANGE               ] = 'd0                                                                                ;
              end
            else
              begin
                local_cntl_toNoc                                                              = from_local_fifo[1].pipe_cntl                                                       ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE         ] = from_local_fifo[1].pipe_data [`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE           ] = from_local_fifo[1].pipe_data [`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE         ] = from_local_fifo[1].pipe_data [`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE           ] = from_local_fifo[1].pipe_data [`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ] ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE     ] = from_local_fifo[1].pipe_pvalid                                                     ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAD0_RANGE              ] = 'd0                                                                                ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE      ] = from_local_fifo[1].pipe_ptype                                                      ;
                local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE       ] = from_local_fifo[1].pipe_type                                                       ;
              end
          end
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_DATA:
          begin
            local_cntl_toNoc                                                              = from_local_fifo[1].pipe_cntl                                                       ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE              ] = from_local_fifo[1].pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE      ] ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE              ] = from_local_fifo[1].pipe_data [`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE      ] ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_VALID_RANGE      ] = from_local_fifo[1].pipe_pvalid                                                     ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAD0_RANGE               ] = 'd0                                                                                ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAYLOAD_TYPE_RANGE       ] = from_local_fifo[1].pipe_ptype                                                      ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PAD1_RANGE               ] = 'd0                                                                                ;
          end


  
        default:
          begin
            local_cntl_toNoc = 'd0;
            local_data_toNoc = 'd0;
          end
    
      endcase 
    end 
  
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  // Port Output Control
  //
  // Takes requests from:
  //     Port Input Controller (4)
  //     Local CP queue
  //     Local DP queue
  //
  // Arbitration: RR
  //

  generate
    for (gvi=0; gvi<`MGR_NOC_CONT_NOC_NUM_OF_PORTS; gvi=gvi+1) 
      begin: Port_to_NoC

        //--------------------------------------------------------------------------------------------
        // Port to NoC FIFO
        `NoC_Port_fifo

        assign clear = 0;  // FIXME

    
        //--------------------------------------------------------------------------------------------
        // Port Control to NoC FSM
        //
        // Each source (local, port0..3) provide an OutqReq and OutqReqAddr and receive an OutqAck and OutqReady
        `include "noc_cntl_noc_port_output_control_wires.vh"

        // Once a source has been Ack'ed, the Outqready to that source is based on the output FIFO almost_full

        reg [`MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_RANGE] nc_port_toNoc_state;          // state flop
        reg [`MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_RANGE] nc_port_toNoc_state_next;
  
        // State register 
        always @(posedge clk)
          begin
            nc_port_toNoc_state <= (reset_poweron ) ? `MGR_NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT :
                                                            nc_port_toNoc_state_next ;
          end
    
        always @(*)
          begin
            case (nc_port_toNoc_state)
        
              `include "mgr_noc_cntl_noc_port_output_control_fsm_state_transitions.vh"

            endcase // 
          end // always @ (*)
    
        //-------------------------------------------------------------------------------------------------
        // Internal signals
    
        always @(posedge clk)
          begin
        
          end

        `include "mgr_noc_cntl_noc_port_output_control_fsm_assignments.vh"

      end
  endgenerate

  `include "mgr_noc_cntl_noc_port_output_control_mask_assignments.vh"          // which destinations nodes does this support. Based on input from top level
  `include "mgr_noc_cntl_noc_port_output_control_request_assignments.vh"           // set {local, src0..3}_OutqReq based on ReqAddr  from each of those requestors
                                                                               // send the OutqAck and OutqReady to the requestors (local, port0..3)
  `include "mgr_noc_cntl_noc_port_output_control_header_field_assignments.vh"  // Format of packet defined at source, just pass the packet over but deassert the ports in the address bitfield not accessible via this output port
  `include "mgr_noc_cntl_noc_port_output_control_transfer_assignments.vh"      // Connect output of FIFO to external NoC ports

  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  //  ******** END OF TRAFFIC OUT OF THE NODE ********
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------


  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  //  ******** TRAFFIC INTO THE NODE ********
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  //
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  // Local Input Control
  //

  reg                                             local_inq_priority_fromNoc     ; 
  reg                                             local_inq_priority_fromNoc_p1  ; 
  reg  [`MGR_MGR_ID_RANGE                      ]  local_inq_mgr_fromNoc          ;  
  reg  [`MGR_MGR_ID_RANGE                      ]  local_inq_mgr_fromNoc_p1       ; 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  local_inq_type_fromNoc         ;  // latch as we need type to know whether to add EOD at end of current apcket transfer
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  local_inq_type_fromNoc_p1      ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE   ]  local_inq_ptype_fromNoc        ;  // latch as we need type to know whether to add EOD at end of current apcket transfer
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE   ]  local_inq_ptype_fromNoc_p1     ; 


  //--------------------------------------------------------------------------------------------
  // Local Input FSM
  //
  reg [`MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_RANGE] nc_local_inq_cntl_state      ;  // state flop
  reg [`MGR_NOC_CONT_LOCAL_INQ_CNTL_STATE_RANGE] nc_local_inq_cntl_state_next ;
  

  // State register 
  always @(posedge clk)
    begin
      nc_local_inq_cntl_state <= (reset_poweron ) ? `MGR_NOC_CONT_LOCAL_INQ_CNTL_WAIT :
                                                     nc_local_inq_cntl_state_next    ;
    end
  
  always @(*)
    begin

      case (nc_local_inq_cntl_state)

        `include "mgr_noc_cntl_noc_local_inq_control_fsm_state_transitions.vh"

      endcase // case(nc_local_inq_cntl_state)

    end

  `include "mgr_noc_cntl_noc_local_inq_control_assignments.vh"

  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  // Port Input Control
  //

  //--------------------------------------------------
  // FIFO's
  
  generate
    for (gvi=0; gvi<`MGR_NOC_CONT_NOC_NUM_OF_PORTS; gvi=gvi+1) 
      begin: Port_from_NoC_fifo

        // Write data
        reg    [`COMMON_STD_INTF_CNTL_RANGE          ]    write_cntl       ;
        reg    [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE    ]    write_data       ; 

        // Read data                                                       
        wire   [`COMMON_STD_INTF_CNTL_RANGE          ]    read_cntl        ;
        wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE    ]    read_data        ; 

        // Control
        wire                                              clear            ; 
        wire                                              empty            ; 
        wire                                              almost_full      ; 
        wire                                              read             ; 
        reg                                               write            ; 
 

        // Combine FIFO bits
        generic_fifo #(.GENERIC_FIFO_DEPTH      (`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_DEPTH), 
                       .GENERIC_FIFO_THRESHOLD  (`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_ALMOST_FULL_THRESHOLD),
                       .GENERIC_FIFO_DATA_WIDTH (`COMMON_STD_INTF_CNTL_WIDTH+`MGR_NOC_CONT_NOC_PORT_DATA_WIDTH)
                        ) fromLocal_fifo (
                                          // Status
                                         .empty            ( empty                      ),
                                         .almost_full      ( almost_full                ),
                                          // Write                                      
                                         .write            ( write                      ),
                                         .write_data       ( {write_cntl,    write_data}),
                                          // Read                                                
                                         .read             ( read                       ),
                                         .read_data        ( { read_cntl,     read_data}),

                                         // General
                                         .clear            ( clear                      ),
                                         .reset_poweron    ( reset_poweron              ),
                                         .clk              ( clk                        )
                                         );
        // Note: First stage of pipeline is inside FIFO
        // fifo output stage
        reg                                                  fifo_pipe_valid   ;
        wire                                                 fifo_pipe_read    ;
        // pipe stage
        reg                                                  pipe_valid        ;
        reg    [`COMMON_STD_INTF_CNTL_RANGE          ]       pipe_cntl         ;
        reg    [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE    ]       pipe_data         ; 

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
            pipe_data           <= ( fifo_pipe_read     ) ? read_data            :
                                                            pipe_data            ;
          end

        reg    [`MGR_NOC_CONT_FROM_EXT_NOC_CNTL_FIFO_PKT_CNT_RANGE ]    pkt_count       ;
        always @(posedge clk)
          begin
            pkt_count  <=  ( reset_poweron || clear                                                                                                ) ? 'd0             :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_EOM    )) && (~pipe_read                                              )) ? pkt_count + 'd1 :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_EOM    )) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? pkt_count       :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_EOM    )) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? pkt_count       :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) && (~pipe_read                                              )) ? pkt_count + 'd1 :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? pkt_count       :
                           (( write && (write_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? pkt_count       :
                           ((~write                                                 ) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM    )) ? pkt_count - 'd1 :
                           ((~write                                                 ) && ( pipe_read && pipe_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)) ? pkt_count - 'd1 :
                                                                                                                                                       pkt_count       ;
          end

        assign clear   =   1'b0                ;

      end
  endgenerate



  //--------------------------------------------------
  // Control
  

  wire [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ] InPortRequestVector    ;

  generate
    for (gvi=0; gvi<`MGR_NOC_CONT_NOC_NUM_OF_PORTS; gvi=gvi+1) 
      begin: Port_from_NoC_Control

        //--------------------------------------------------------------------------------------------
        // Port Control from NoC FIFO
        `NoC_Port_fifo

        assign clear = 0;  // FIXME

        //--------------------------------------------------------------------------------------------
        wire                              destinationReq       ; // request to all destinations, one (or more) will accept.
        wire [`MGR_MGR_ID_BITMASK_RANGE ] destinationReqAddr   ; // bitmask address from header of packet
        wire                              destinationPriority  ; // local input queue needs this to direct packet

        // all destinations 'AND' with their bitmask and 'ack' if it matches
        // Input controller waits until all acked bits have been enabled (e.g. all destinations are ready)
                                                            
        // The Port  input controller must provide the priority of the packet
        // to allow appropriate directing of the packet. Right now only local
        // distinguishes between CP and DP.
        // The priority of the packet does not affect destination arbitration but simply the transfer.
        //reg                        destinationHpReq    ;  // output hi-priority request to CP local InQ fsm
        //reg                        destinationLpReq    ;  // output lo-priority request to CP local InQ fsm
        //
        // All possible destinations may ack the request if its a multicast.
        // The Port input controller must wait for all relavant enables to be asserted before starting transfer (reading fifo)
        // This vector needs bits for the local inq and port 0-3 outputs e.g. "number of destinations" for a packet is 5
        wire [`MGR_NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE ]  destinationReady    ;  // Start reading input fifo, destination handles directing the information
        wire [`MGR_NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE ]  destinationAck      ;  // input from local InQ fsm
        reg  [`MGR_NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE ]  destinationAck_d1   ;  // Register the acking destinations so we can keep track of each destinations ready signal
        //reg                                                     destinationReady_d1 ;  // Destination ready gated with ack vector
        
        // wires to make fsm easier to read
        wire  allDestinationsInitiallyReady  = ( destinationAck    == (destinationReady & destinationAck   ) );  // Used for the first ack and ready are asserted
        wire  allDestinationsStillReady      = ( destinationAck_d1 == (destinationReady & destinationAck_d1) );  // Used after the intial ack and ready

        // the following are to NoC packet bus from the input controller
        wire                                            fromNoc_valid    ;  // when valid, the destination port(s) must write to their output fifo's
        wire [`MGR_MGR_ID_RANGE                      ]  mgr_fromNoc      ;  // grap during header cycle
        reg  [`MGR_MGR_ID_RANGE                      ]  mgr_fromNoc_d1   ;  // grap during header cycle
        wire [`MGR_NOC_CONT_NOC_PORT_CNTL_RANGE      ]  cntl_fromNoc     ;  // 
        reg  [`MGR_NOC_CONT_NOC_PORT_CNTL_RANGE      ]  cntl_fromNoc_d1  ;  // latch for entire transaction
        wire                                            priority_fromNoc ;  // valid only during header cycle of external NoC packet       
        wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  type_fromNoc     ;  // valid only during 2nd cycle or tuple cycle of external NoC packet (assume valid only during 1st tuple cycle)
        reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  type_fromNoc_d1  ;  // latch for entire transaction
        wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE   ]  ptype_fromNoc    ;  // payload type valid during tuple and data cycles
        wire [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE      ]  data_fromNoc     ;  //

        wire                                            fromNoc_som      ;
        wire                                            fromNoc_mom      ;
        wire                                            fromNoc_eom      ;

        //--------------------------------------------------------------------------------------------
        // Port Control from NoC FSM
        //

        reg [`MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_RANGE] nc_port_fromNoc_state;          // state flop
        reg [`MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_RANGE] nc_port_fromNoc_state_next;
  
        
        // State register 
        always @(posedge clk)
          begin
            nc_port_fromNoc_state <= (reset_poweron ) ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT :
                                                         nc_port_fromNoc_state_next        ;
          end
    
        always @(*)
          begin
            case (nc_port_fromNoc_state)
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT: 
                nc_port_fromNoc_state_next = ( ~fifo_empty && (fifo_eop_count > 0) )  ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ :
                                                                                        `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT            ;
    

              // we have to identify the destination PE from the incoming pe mask address
              // put it out there to be accepted by an output port(s) and/or local input queue
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ:
                nc_port_fromNoc_state_next = ( ~|destinationAck               ) ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ  :  // no destination has acked yet
                                             ( allDestinationsInitiallyReady  ) ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER  :  // output port has acked and all destinations ready
                                                                                  `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ  ;
            
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER:
                nc_port_fromNoc_state_next = `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET ;
            
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET:
                nc_port_fromNoc_state_next = ( fifo_read_data_valid && fromNoc_eom)  ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_COMPLETE        :
                                                                                       `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET ;
            
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_COMPLETE:
                nc_port_fromNoc_state_next = `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT ;
    
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_ERROR:
                nc_port_fromNoc_state_next = `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_ERROR ;
    
              default:
                nc_port_fromNoc_state_next = `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT;
          
            endcase // case(so_cntl_state)
          end // always @ (*)
    
        //-------------------------------------------------------------------------------------------------
        // Internal signals

        assign  fromNoc_som  = (fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM) || (fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)  ;
        assign  fromNoc_mom  = (fifo_read_cntl == `COMMON_STD_INTF_CNTL_MOM)                                                       ;
        assign  fromNoc_eom  = (fifo_read_cntl == `COMMON_STD_INTF_CNTL_EOM) || (fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)  ;

        assign fifo_read  = ( (fifo_eop_count > 0)      & (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT           ))|  // read head of packet to determine destination bitmask
                            //( allDestinationsStillReady & (nc_port_fromNoc_state_next == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER))|  // send header of control packet
                            //( allDestinationsStillReady & (nc_port_fromNoc_state_next == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET)) ; // send balance of control packet
                            (                             (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER))|  // send header of control packet
                            ( ~fromNoc_eom              & (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET)) ; // send balance of control packet
                              
        assign destinationReq  = //((fifo_eop_count > 0) & (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT           ))|  // read head of packet to determine destination bitmask
                                 (                       (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ)) ; // destination bitmask set, now request outport

        // valid only during destinationReq	
        assign destinationReqAddr   = fifo_read_data[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE ] ;
        assign destinationPriority  = fifo_read_data[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE         ] ;
   
        assign fromNoc_valid    = ((nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER) |
                                   (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET)) ;  

        assign cntl_fromNoc     = fifo_read_cntl ;  // 
        assign data_fromNoc     = fifo_read_data ;  //
        assign mgr_fromNoc      = fifo_read_data[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE         ] ;  // valid only during header cycle of NoC packet       
        assign priority_fromNoc = fifo_read_data[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE          ] ;  // valid only during header cycle of NoC packet       
        assign type_fromNoc     = fifo_read_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE  ] ;  // valid only during 1st tuple cycle of NoC packet       
        assign ptype_fromNoc    = fifo_read_data[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE ] ;  // valid during tuple and data cycles of NoC packet       
                                                                                   

   
        always @(posedge clk)
          begin
        
            // the ack from each destinatio  is only active the cycle after the request is deasserted, so latch who acked so we can flow
            // control the transfer using the destinationReady vector
            destinationAck_d1 <= (reset_poweron                                                              )  ? 'd0               :
                                 (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ )  ? destinationAck    :
                                                                                                                  destinationAck_d1 ;

            //destinationReady_d1 <= (reset_poweron       )  ? 'd0               :
            //                                             ((destinationAck_d1 == (destinationReady & destinationAck_d1)) & (nc_port_fromNoc_state_next == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET)) ; // send balance of control packet

          end

      end
  endgenerate

  `include "mgr_noc_cntl_port_input_control_assignments.vh"

  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  //  ******** END OF TRAFFIC INTO THE NODE ********
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------


endmodule

