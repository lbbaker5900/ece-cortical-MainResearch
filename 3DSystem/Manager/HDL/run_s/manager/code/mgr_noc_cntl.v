/*********************************************************************************************

    File name   : mgr_noc_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

    Description : This module interfaces to the streaming controller.
                  Initially the NoC has a single interface to the stOp_cntl and takes packets one-by-one. This may not make best use 
                  as a packet can be directed out any one of the four NoC ports.
                  FIXME: maybe provide interfaces for each exec lane via the stOp_cntl

*********************************************************************************************/
    

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
  `include "mgr_noc_cntl_noc_wires.vh"

  reg                                             noc__locl__cp_valid      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE             ] noc__locl__cp_cntl       ; 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] noc__locl__cp_type       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] noc__locl__cp_ptype      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] noc__locl__cp_data       ; 
  reg  [`MGR_MGR_ID_RANGE                       ] noc__locl__cp_mgrId      ; 
  //reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__locl__cp_laneId     ; 
  //reg                                             noc__locl__cp_strmId     ; 
  
  reg                                             noc__locl__cp_valid_p1   ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE             ] noc__locl__cp_cntl_p1    ; 
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] noc__locl__cp_type_p1    ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] noc__locl__cp_ptype_p1   ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] noc__locl__cp_data_p1    ; 


  reg                                             noc__locl__dp_valid      ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE             ] noc__locl__dp_cntl       ; 
                                            
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] noc__locl__dp_type       ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] noc__locl__dp_ptype      ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] noc__locl__dp_data       ; 
  //reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__locl__dp_laneId     ; 
  //reg                                             noc__locl__dp_strmId     ; 
  
  reg                                             noc__locl__dp_valid_p1   ; 
  reg  [`COMMON_STD_INTF_CNTL_RANGE             ] noc__locl__dp_cntl_p1    ; 
                                            
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ] noc__locl__dp_type_p1    ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ] noc__locl__dp_ptype_p1   ; 
  reg  [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ] noc__locl__dp_data_p1    ; 
  
  //-------------------------------------------------------------------------------------------
  // General use assignments
  //

  `include "mgr_noc_cntl_noc_general_assignments.vh"

  //------------------------------------------
  // FIFO to NoC has enough space to contain a DMA packet before it is
  // transferred to the NoC
  //
  // Control to NoC FIFO
  //
  genvar gvi;
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: to_NoC_control_fifo
        `Control_to_NoC_FIFO
      end
  endgenerate

  assign to_NoC_control_fifo[0].clear      = 1'b0                   ;
  assign to_NoC_control_fifo[0].cntl       = locl__noc__cp_cntl     ;
  assign to_NoC_control_fifo[0].type       = locl__noc__cp_type     ;
  assign to_NoC_control_fifo[0].ptype      = locl__noc__cp_ptype    ;
  assign to_NoC_control_fifo[0].desttype   = locl__noc__cp_desttype ;
  assign to_NoC_control_fifo[0].pvalid     = locl__noc__cp_pvalid   ;
  assign to_NoC_control_fifo[0].data       = locl__noc__cp_data     ;
  //assign to_NoC_control_fifo[0].laneId     = locl__noc__cp_laneId   ;

  assign to_NoC_control_fifo[0].fifo_write = locl__noc__cp_valid    ;

  always @(posedge clk)
    noc__locl__cp_ready  <= ~to_NoC_control_fifo[0].fifo_almost_full ;

  //------------------------------------------------------------
  // Data to NoC FIFO
  //
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: to_NoC_data_fifo
        `NoC_to_NoC_data_intf
      end
  endgenerate

  assign to_NoC_data_fifo[0].clear        = 1'b0                     ; 
  assign to_NoC_data_fifo[0].cntl         = locl__noc__dp_cntl       ; 
  assign to_NoC_data_fifo[0].type         = locl__noc__dp_type       ; 
  assign to_NoC_data_fifo[0].ptype        = locl__noc__dp_ptype      ;
  assign to_NoC_data_fifo[0].desttype     = locl__noc__dp_desttype   ;
  assign to_NoC_data_fifo[0].pvalid       = locl__noc__dp_pvalid     ;
  assign to_NoC_data_fifo[0].data         = locl__noc__dp_data       ; 

  //assign to_NoC_data_fifo[0].mgrId        = locl__noc__dp_mgrId      ; 
  //assign to_NoC_data_fifo[0].laneId       = locl__noc__dp_laneId     ; 
  //assign to_NoC_data_fifo[0].strmId       = locl__noc__dp_strmId     ; 

  assign to_NoC_data_fifo[0].fifo_write   = locl__noc__dp_valid      ;
  always @(posedge clk)
    noc__locl__dp_ready                   <= ~to_NoC_data_fifo[0].fifo_almost_full ;

  assign to_NoC_data_fifo[0].fifo_write   =   locl__noc__dp_valid    ; 

  //--------------------------------------------------------------------------
  //----------------------------- START OF DEBUG -----------------------------
  //------------------------------------------------------------
  // FIXME - Debug - Loop requests back 
  //
  //
`ifdef DEBUG_NOC_LOOPBACK
  reg noc__locl__cp_valid_d1 ;
  always @(posedge clk)
    noc__locl__cp_valid_d1  <=  to_NoC_control_fifo[0].fifo_read            ; 

  assign to_NoC_control_fifo[0].fifo_read  = locl__noc__cp_ready & ~to_NoC_control_fifo[0].fifo_empty    ;
  assign  noc__locl__cp_cntl    =  to_NoC_control_fifo[0].fifo_read_cntl       ; 
  assign  noc__locl__cp_type    =  to_NoC_control_fifo[0].fifo_read_type       ; 
  assign  noc__locl__cp_data    =  to_NoC_control_fifo[0].fifo_read_data       ; 
  assign  noc__locl__cp_mgrId   =  sys__mgr__mgrId                             ; 
  assign  noc__locl__cp_laneId  =  to_NoC_control_fifo[0].fifo_read_laneId     ; 
  assign  noc__locl__cp_strmId  =  to_NoC_control_fifo[0].fifo_read_strmId     ; 
  assign  noc__locl__cp_valid   =  noc__locl__cp_valid_d1                      ; 


  // FIXME - Debug - Loop Data back 
  assign to_NoC_data_fifo[0].fifo_read =  locl__noc__dp_ready & ~to_NoC_data_fifo[0].fifo_empty  ; 
  assign  noc__locl__dp_cntl           =  to_NoC_data_fifo[0].fifo_read_cntl   ; 
  assign  noc__locl__dp_type           =  to_NoC_data_fifo[0].fifo_read_type   ; 
  assign  noc__locl__dp_laneId         =  to_NoC_data_fifo[0].fifo_read_laneId ;
  assign  noc__locl__dp_strmId         =  to_NoC_data_fifo[0].fifo_read_strmId ; 
  assign  noc__locl__dp_data           =  to_NoC_data_fifo[0].fifo_read_data   ;
  assign  noc__locl__dp_valid          =  to_NoC_data_fifo[0].fifo_read_data_valid        ; 

  //------------------------------ END OF DEBUG ------------------------------
  //--------------------------------------------------------------------------
  //
`else


  //------------------------------------------------------------
  // FIXME 
  // DEBUG : loop back until we have completed debug
  // Read controlled by Local outq controller
  /*
  assign  noc__locl__cp_cntl   =  to_NoC_control_fifo[0].fifo_read_cntl       ; 
  assign  noc__locl__cp_type   =  to_NoC_control_fifo[0].fifo_read_type       ; 
  assign  noc__locl__cp_data   =  to_NoC_control_fifo[0].fifo_read_data       ; 
  assign  noc__locl__cp_mgrId   =  sys__mgr__mgrId                                        ; 
  assign  noc__locl__cp_laneId =  to_NoC_control_fifo[0].fifo_read_laneId     ; 
  assign  noc__locl__cp_strmId =  to_NoC_control_fifo[0].fifo_read_strmId     ; 
  assign  noc__locl__cp_valid  =  to_NoC_control_fifo[0].fifo_read_data_valid ; 

  assign  noc__locl__dp_cntl    =  to_NoC_data_fifo[0].fifo_read_cntl          ; 
  assign  noc__locl__dp_type    =  to_NoC_data_fifo[0].fifo_read_type          ; 
  assign  noc__locl__dp_laneId  =  to_NoC_data_fifo[0].fifo_read_laneId        ;
  assign  noc__locl__dp_strmId  =  to_NoC_data_fifo[0].fifo_read_strmId        ; 
  assign  noc__locl__dp_data    =  to_NoC_data_fifo[0].fifo_read_data          ;
  assign  noc__locl__dp_valid   =  to_NoC_data_fifo[0].fifo_read_data_valid    ; 
*/

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
  

  wire                                        local_toNoc_valid    ;  // when valid, destination port(s) must write local output data to their output fifo's
  wire [`MGR_NOC_CONT_NOC_PORT_CNTL_RANGE      ]  local_cntl_toNoc     ;  // local output cntl to destination port to be sent directly to butterfly network
  reg  [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE      ]  local_data_toNoc     ;  // local output data to destination port to be sent directly to butterfly network

  wire [`MGR_MGR_ID_RANGE                 ]  local_destinationPeId    ;  // destination mgrId from dma request address
  wire [`PE_ARRAY_CHIPLET_ADDRESS_RANGE   ]  local_dmaRequestAddress  ;  // full chiplet address from dma request at output of cp output queue

  wire                             local_destinationReq        ; // Destination accepts the request and this fsm doesnt know who
  reg [`MGR_MGR_ID_BITMASK_RANGE ] local_destinationReqAddr    ; // bitmask address from header of packet
  reg [`MGR_MGR_ID_BITMASK_RANGE ] local_destinationReqAddr_d1 ; // Keep a registered version for transfer

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
  wire                                              local_destinationReady_d1 ;  // Destination ready gated with ack vector
  wire  [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ]  local_destinationAck      ;  // input from CP local InQ fsm
  reg   [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ]  local_destinationAck_d1   ;  // Register the acking destinations so we can keep track of each destinations ready signal
  //--------------------------------------------------------------------------------------------
  // Port Control from NoC FSM
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
          nc_local_outq_cntl_state_next = ( to_NoC_control_fifo[0].fifo_eop_count > 0 )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ :  // only request transmission when we have a packets worth
                                          ( to_NoC_data_fifo[0].fifo_eop_count > 0    )  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ :
                                                                                           `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT         ;
  
        // read head of fifo
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ:
          nc_local_outq_cntl_state_next = ( (to_NoC_control_fifo[0].fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM) || (to_NoC_control_fifo[0].fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM))  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ  :
                                                                                                                                                                                                             `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_ERROR        ;  // put addressed mgrId bitmask as the destination
        // we have to identify the destination PE from the address, create a destination bitMask and put it out there to be accepted by one of
        // the output ports.
        // The output port has to acknowledge even if it isnt erady but the outq controller will only transfer if the destination is erady.
        // Note: Request set if "next" state is PORT_REQ
        // Note: The destination keeps the Ack asserted until the request is deasserted. The request is asserted all the time the next state is PORT_REQ.
        
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ:
          nc_local_outq_cntl_state_next = ( ~|local_destinationAck                                                  ) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ     :
                                          ( local_destinationAck == (local_destinationReady & local_destinationAck) ) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER  :  // output port has acked and all ports ready
                                                                                                                        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ     ;

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2 ;

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2:
          nc_local_outq_cntl_state_next = ( ((to_NoC_control_fifo[0].fifo_read_cntl == `COMMON_STD_INTF_CNTL_EOM) || (to_NoC_control_fifo[0].fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)))  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3  :
                                                                                                                                                                                                             `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2  ;

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_COMPLETE ;

  
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_COMPLETE:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_WAIT ;
  
        // read head of fifo
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ:
          nc_local_outq_cntl_state_next = ( (to_NoC_data_fifo[0].fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM) || (to_NoC_data_fifo[0].fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM))  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ  :
                                                                                                                                                                                                             `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_ERROR        ;  // put addressed mgrId bitmask as the destination
        // we have to identify the destination PE from the address, create
        // a destination bitMask and put it out there to be accepted by one of
        // the output ports
        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ:
          nc_local_outq_cntl_state_next = ( ~|local_destinationAck                                                 ) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ     :
                                          ( local_destinationAck == (local_destinationReady & local_destinationAck)) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER  :  // output port has acked and all ports ready
                                                                                                                       `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ     ;

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER:
          nc_local_outq_cntl_state_next = ((to_NoC_data_fifo[0].fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM) && (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1))) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3  :  // if there is only one piece of data
                                          (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1)) ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2  :  // if there is only one piece of data
                                                                                                                         `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER ;

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2:
          nc_local_outq_cntl_state_next = ( ((to_NoC_data_fifo[0].fifo_read_cntl == `COMMON_STD_INTF_CNTL_EOM) || (to_NoC_data_fifo[0].fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)))  ? `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3  :
                                                                                                                                                                                                       `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2  ;

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3:
          nc_local_outq_cntl_state_next = `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_COMPLETE ;

  
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
  
  always @(posedge clk)
    begin
  
      local_destinationReqAddr_d1   <= (reset_poweron                                                      ) ? 'd0                          :
                                       (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ ) ? local_destinationReqAddr     :
                                       (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ ) ? local_destinationReqAddr     :
                                                                                                               local_destinationReqAddr_d1  ;

      // the ack from each destination is only active the cycle after the request is deasserted, so latch who acked so we can flow
      // control the transfer using the destinationReady vector
      local_destinationAck_d1 <= (reset_poweron                                                    )  ? 'd0               :
                                 (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ)  ? local_destinationAck    :
                                 (nc_local_outq_cntl_state == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ)  ? local_destinationAck    :
                                                                                                        local_destinationAck_d1 ;

      //local_destinationReady_d1 <= ~reset_poweron & (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1)) ;

    end

  assign local_destinationReady_d1 = (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1)) ;

  // extract destination mgrId from the dma address
  assign local_dmaRequestAddress = to_NoC_control_fifo[0].fifo_read_data[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE] ;
  assign local_destinationPeId   = (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ ) ? local_dmaRequestAddress[`PE_PE_DECODE_ADDRESS_RANGE]  :
                                   (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ ) ? to_NoC_data_fifo[0].fifo_read_mgrId                    :
                                                                                                               'd0                                                   ;

  `include "noc_cntl_noc_local_outq_control_assignments.vh"

  assign to_NoC_control_fifo[0].fifo_read  = (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ   ) | // read head of packet to determine destination bitmask
                                             (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2 ) ; // send balance of control packet. Dont bother with ready because fifo can always take cp once it says ready

  assign to_NoC_data_fifo[0].fifo_read     = (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ   ) | // read head of packet to determine destination bitmask
                                            ((nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2 ) & (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1))); // send balance of data packet

  assign local_destinationReq              = (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ ) | // destination bitmask set, now request outport
                                             (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ ) ; // destination bitmask set, now request outport

  assign local_toNoc_valid    = ((nc_local_outq_cntl_state      == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ   ) & ( local_destinationAck == (local_destinationReady & local_destinationAck) )) |
                                ((nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER) & local_destinationReady_d1) | // first construct header and send when destination first says ready
                                ((nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2) & local_destinationReady_d1) | // if data is read, then send it. Flow control affects read
                                ((nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3) ) |
                                ((nc_local_outq_cntl_state      == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ   ) & ( local_destinationAck == (local_destinationReady & local_destinationAck) )) |
                                ((nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER) & local_destinationReady_d1) | // first construct header and send when destination first says ready
                                ((nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2) & local_destinationReady_d1) |  // if data is read, then send it. Flow control affects read
                                ((nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3) ) ;
                                   
  assign local_cntl_toNoc     = (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER) ?  `COMMON_STD_INTF_CNTL_SOM   :
                                (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2) ?  `COMMON_STD_INTF_CNTL_MOM  : 
                                (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER) ?  `COMMON_STD_INTF_CNTL_SOM   :
                                (nc_local_outq_cntl_state_next == `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2) ?  `COMMON_STD_INTF_CNTL_MOM  : 
                                                                                                               `COMMON_STD_INTF_CNTL_EOM   ;
  always @(*)
    begin
      case (nc_local_outq_cntl_state_next)

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER:
          begin
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE         ] = 'd`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP  ; 
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE        ] = sys__mgr__mgrId                                        ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE ] = local_destinationReqAddr_d1                 ;
          end

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2:
          begin
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_RANGE  ] = to_NoC_control_fifo[0].fifo_read_data[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE ];
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_RANGE  ] = to_NoC_control_fifo[0].fifo_read_data[`MGR_NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE ];
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_RANGE     ] = to_NoC_control_fifo[0].fifo_read_type                                                     ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE  ] = to_NoC_control_fifo[0].fifo_read_laneId                                                   ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE  ] = to_NoC_control_fifo[0].fifo_read_strmId                                                   ;
          end

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3:
          begin
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_RANGE  ] = to_NoC_control_fifo[0].fifo_read_data[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE ];
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_RANGE  ] = to_NoC_control_fifo[0].fifo_read_data[`MGR_NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE ];
          end

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER:
          begin
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE         ] = 'd`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP  ; 
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE        ] = sys__mgr__mgrId                                        ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE ] = local_destinationReqAddr_d1                 ;
          end

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2:
          begin
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_RANGE     ] = to_NoC_data_fifo[0].fifo_read_data[`MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_RANGE ] ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_RANGE     ] = to_NoC_data_fifo[0].fifo_read_data[`MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_RANGE ] ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_RANGE     ] = to_NoC_data_fifo[0].fifo_read_type                                                    ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_RANGE  ] = to_NoC_data_fifo[0].fifo_read_laneId                                                  ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_RANGE  ] = to_NoC_data_fifo[0].fifo_read_strmId                                                  ;
          end

        `MGR_NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3:
          begin
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE     ] = to_NoC_data_fifo[0].fifo_read_data[`MGR_NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE ] ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_RANGE     ] = to_NoC_data_fifo[0].fifo_read_data[`MGR_NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_RANGE ] ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_RANGE     ] = to_NoC_data_fifo[0].fifo_read_type                                                    ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_RANGE  ] = to_NoC_data_fifo[0].fifo_read_laneId                                                  ;
            local_data_toNoc[`MGR_NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_RANGE  ] = to_NoC_data_fifo[0].fifo_read_strmId                                                  ;
          end

  
        default:
          local_data_toNoc = 'd0;
    
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

        `include "noc_cntl_noc_port_output_control_wires.vh"

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

  `include "mgr_noc_cntl_noc_port_output_control_mask_assignments.vh"
  `include "noc_cntl_noc_port_output_control_request_assignments.vh"
  `include "mgr_noc_cntl_noc_port_output_control_header_field_assignments.vh"  // different header format 
  `include "mgr_noc_cntl_noc_port_output_control_transfer_assignments.vh"

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

  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  local_inq_type_fromNoc     ;  // latch as we need type to know whether to add EOD at end of current apcket transfer
  reg  [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  local_inq_type_fromNoc_p1  ; 
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE   ]  local_inq_ptype_fromNoc    ;  // latch as we need type to know whether to add EOD at end of current apcket transfer
  reg  [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE   ]  local_inq_ptype_fromNoc_p1 ; 


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
  wire [`MGR_NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ] InPortRequestVector    ;

  generate
    for (gvi=0; gvi<`MGR_NOC_CONT_NOC_NUM_OF_PORTS; gvi=gvi+1) 
      begin: Port_from_NoC

        //--------------------------------------------------------------------------------------------
        // Port Control from NoC FIFO
        `NoC_Port_fifo

        assign clear = 0;  // FIXME

        //--------------------------------------------------------------------------------------------
        wire                            destinationReq       ; // request to all destinations, one (or more) will accept.
        wire [`MGR_MGR_ID_BITMASK_RANGE ] destinationReqAddr   ; // bitmask address from header of packet
        wire                            destinationPriority  ; // local input queue needs this to direct packet
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
        // This vector needs bits for the local inq and port 0-3 outputs
        wire [`MGR_NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE ]  destinationReady    ;  // Start reading input fifo, destination handles directing the information
        wire [`MGR_NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE ]  destinationAck      ;  // input from local InQ fsm
        reg  [`MGR_NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE ]  destinationAck_d1   ;  // Register the acking destinations so we can keep track of each destinations ready signal
        reg                                                 destinationReady_d1 ;  // Destination ready gated with ack vector

        // the following are to NoC packet bus from the input controller
        wire                                        fromNoc_valid    ;  // when valid, the destination port(s) must write to their output fifo's
        wire [`MGR_NOC_CONT_NOC_PORT_CNTL_RANGE      ]  cntl_fromNoc     ;  // 
        wire [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE      ]  data_fromNoc     ;  //
        wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  type_fromNoc     ;  // valid only during 2nd cycle of external NoC packet       
        wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE   ]  ptype_fromNoc    ;  // valid only during 2nd cycle of external NoC packet       
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
                nc_port_fromNoc_state_next = ( ~fifo_empty && (fifo_eop_count > 0) )  ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_FIFO_READ :
                                                                                        `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT      ;
    
              // read head of fifo
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_FIFO_READ:
                nc_port_fromNoc_state_next = ( (fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM) || (fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM))  ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ  :  // put addressed mgrId bitmask as the destination
                                                                                                                                                                  `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_ERROR            ;
              // we have to identify the destination PE from the incoming pe mask address
              // put it out there to be accepted by an output port(s) and/or local input queue
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ:
                nc_port_fromNoc_state_next = ( ~|destinationAck                                         ) ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ  :  // no destination has acked yet
                                                ( destinationAck == (destinationReady & destinationAck) ) ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER  :  // output port has acked and all destinations ready
                                                                                                            `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ  ;
            
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER:
                nc_port_fromNoc_state_next = `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET ;
            
              `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET:
                nc_port_fromNoc_state_next = ( fifo_read_data_valid && ((fifo_read_cntl == `COMMON_STD_INTF_CNTL_EOM) || (fifo_read_cntl == `COMMON_STD_INTF_CNTL_SOM_EOM)))  ? `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_COMPLETE        :
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
    
        assign fifo_read  = (nc_port_fromNoc_state_next == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_FIFO_READ      ) | // read head of packet to determine destination bitmask
                            ((destinationAck_d1 == (destinationReady & destinationAck_d1)) & (nc_port_fromNoc_state_next == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET)) ; // send balance of control packet
   
        assign destinationReq       = (nc_port_fromNoc_state_next == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ ) ; // destination bitmask set, now request outport
        assign destinationReqAddr   = fifo_read_data[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE ] ;
        assign destinationPriority  = fifo_read_data[`MGR_NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE         ] ;
   
        assign fromNoc_valid    = (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER) |  destinationReady_d1 ;// header was read to provide address to destinations, now transter
//                                 (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET) ; // transfer rest of packet until EOP
        assign cntl_fromNoc     = fifo_read_cntl ;  // 
        assign data_fromNoc     = fifo_read_data ;  //
        assign type_fromNoc     = fifo_read_data[`MGR_NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_RANGE ];  // valid only during 2nd cycle of external NoC packet       
   
        always @(posedge clk)
          begin
        
            // the ack from each destinatio  is only active the cycle after the request is deasserted, so latch who acked so we can flow
            // control the transfer using the destinationReady vector
            destinationAck_d1 <= (reset_poweron                                                         )  ? 'd0               :
                                 (nc_port_fromNoc_state == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ)  ? destinationAck    :
                                                                                                             destinationAck_d1 ;

            destinationReady_d1 <= (reset_poweron       )  ? 'd0               :
                                                         ((destinationAck_d1 == (destinationReady & destinationAck_d1)) & (nc_port_fromNoc_state_next == `MGR_NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET)) ; // send balance of control packet

          end

      end
  endgenerate

  `include "mgr_noc_cntl_port_input_control_assignments.vh"

  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  //  ******** END OF TRAFFIC INTO THE NODE ********
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------

`endif

endmodule

