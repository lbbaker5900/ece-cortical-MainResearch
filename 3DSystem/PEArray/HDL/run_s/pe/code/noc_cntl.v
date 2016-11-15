/*********************************************************************************************

    File name   : noc_cntl.v
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
`include "noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "dma_cont.vh"
`include "streamingOps.vh"


module noc_cntl (

                  // Aggregate Control-path (cp) to NoC 
                  noc__cntl__cp_ready      , 
                  cntl__noc__cp_cntl       , 
                  cntl__noc__cp_type       , 
                  cntl__noc__cp_data       , 
                  cntl__noc__cp_laneId     , 
                  cntl__noc__cp_strmId     , 
                  cntl__noc__cp_valid      , 
                  // Aggregate datapath (cp) from NoC 
                  cntl__noc__cp_ready      , 
                  noc__cntl__cp_cntl       , 
                  noc__cntl__cp_type       , 
                  noc__cntl__cp_data       , 
                  noc__cntl__cp_peId       , 
                  noc__cntl__cp_laneId     , 
                  noc__cntl__cp_strmId     , 
                  noc__cntl__cp_valid      , 
                
                  // Aggregate Datapath (dp) to NoC 
                  noc__cntl__dp_ready      , 
                  cntl__noc__dp_cntl       , 
                  cntl__noc__dp_type       , 
                  cntl__noc__dp_peId       , 
                  cntl__noc__dp_laneId     , 
                  cntl__noc__dp_strmId     , 
                  cntl__noc__dp_data       , 
                  cntl__noc__dp_valid      , 
                  // Aggregate datapath (dp) from NoC 
                  cntl__noc__dp_ready      , 
                  noc__cntl__dp_cntl       , 
                  noc__cntl__dp_type       , 
                  noc__cntl__dp_laneId     , 
                  noc__cntl__dp_strmId     , 
                  noc__cntl__dp_data       , 
                  noc__cntl__dp_valid      , 

                  // NoC Ports
                 `include "noc_cntl_noc_ports.vh"

                  peId              ,
                  clk               ,
                  reset_poweron     

    );

  input                       clk            ;
  input                       reset_poweron  ;
  input [`PE_PE_ID_RANGE   ]  peId           ; 

  // Information between CNTL and NOC is a packet interface not a stream interface.
  // This means that every packet is delineated with SOP and EOP.
  // With a stream interface, the entire stream is delineated with SOD and EOD
  // For information to NoC, the cntl will need to add SOP/EOP to the stream from stOp to delineate all packets
  // For information from NoC, for a multi-packet transfer such as a DMA, to generate the stream to stOp, the cntl will detect 
  // the first data packet type of DMA_DATA_SOD and add SOD to the first transaction. The cntl then transfers while setting
  // cntl=data until the last packet type of DMA_DATA_EOD and adds cntl=EOD to the last transaction.
  //
  output                                            noc__cntl__cp_ready      ; 
  input  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] cntl__noc__cp_cntl       ; 
  input  [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__cp_type       ; 
  input  [`NOC_CONT_INTERNAL_DATA_RANGE           ] cntl__noc__cp_data       ; 
  input  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__cp_laneId     ; 
  input                                             cntl__noc__cp_strmId     ; 
  input                                             cntl__noc__cp_valid      ; 
  // Aggregate Data-path (cp) from NoC 
  input                                             cntl__noc__cp_ready      ; 
  output [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__cntl__cp_cntl       ; 
  output [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__cntl__cp_type       ; 
  output [`NOC_CONT_INTERNAL_DATA_RANGE           ] noc__cntl__cp_data       ; 
  output [`PE_PE_ID_RANGE                         ] noc__cntl__cp_peId       ; 
  output [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__cntl__cp_laneId     ; 
  output                                            noc__cntl__cp_strmId     ; 
  output                                            noc__cntl__cp_valid      ; 

  // Aggregate Data-path (dp) to NoC 
  output                                            noc__cntl__dp_ready      ; 
  input  [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] cntl__noc__dp_cntl       ; 
  input  [`STREAMING_OP_CNTL_TYPE_RANGE           ] cntl__noc__dp_type       ; 
  input  [`PE_PE_ID_RANGE                         ] cntl__noc__dp_peId       ; 
  input  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] cntl__noc__dp_laneId     ; 
  input                                             cntl__noc__dp_strmId     ; 
  input  [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE     ] cntl__noc__dp_data       ; 
  input                                             cntl__noc__dp_valid      ; 
  // Aggregate Data-path (dp) from NoC 
  input                                             cntl__noc__dp_ready      ; 
  output [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ] noc__cntl__dp_cntl       ; 
  output [`STREAMING_OP_CNTL_TYPE_RANGE           ] noc__cntl__dp_type       ; 
  output [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__cntl__dp_laneId     ; 
  output                                            noc__cntl__dp_strmId     ; 
  output [`STREAMING_OP_CNTL_DATA_WIDTH_RANGE     ] noc__cntl__dp_data       ; 
  output                                            noc__cntl__dp_valid      ; 

  `include "noc_cntl_noc_ports_declaration.vh"

   
  //-------------------------------------------------------------------------------------------
  // Wires and Register
  //

  reg                                               noc__cntl__cp_ready      ; 
  reg                                               noc__cntl__dp_ready      ; 

  `include "noc_cntl_noc_ports_wires.vh"
  `include "noc_cntl_noc_wires.vh"

  //-------------------------------------------------------------------------------------------
  // General use assignments
  //

  `include "noc_cntl_noc_general_assignments.vh"

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

  assign to_NoC_control_fifo[0].clear      = 1'b0                  ;
  assign to_NoC_control_fifo[0].cntl       = cntl__noc__cp_cntl    ;
  assign to_NoC_control_fifo[0].type       = cntl__noc__cp_type    ;
  assign to_NoC_control_fifo[0].laneId     = cntl__noc__cp_laneId  ;
  assign to_NoC_control_fifo[0].strmId     = cntl__noc__cp_strmId  ;
  assign to_NoC_control_fifo[0].data       = cntl__noc__cp_data    ;
  assign to_NoC_control_fifo[0].fifo_write = cntl__noc__cp_valid   ;
  always @(posedge clk)
    noc__cntl__cp_ready  <= ~to_NoC_control_fifo[0].fifo_almost_full ;

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
  assign to_NoC_data_fifo[0].cntl         = cntl__noc__dp_cntl       ; 
  assign to_NoC_data_fifo[0].type         = cntl__noc__dp_type       ; 
  assign to_NoC_data_fifo[0].peId         = cntl__noc__dp_peId       ; 
  assign to_NoC_data_fifo[0].laneId       = cntl__noc__dp_laneId     ; 
  assign to_NoC_data_fifo[0].strmId       = cntl__noc__dp_strmId     ; 
  assign to_NoC_data_fifo[0].data         = cntl__noc__dp_data       ; 
  assign to_NoC_data_fifo[0].fifo_write   = cntl__noc__dp_valid      ;
  always @(posedge clk)
    noc__cntl__dp_ready                   <= ~to_NoC_data_fifo[0].fifo_almost_full ;

  assign to_NoC_data_fifo[0].fifo_write   =   cntl__noc__dp_valid    ; 

  //------------------------------------------------------------
  // FIXME - Debug - Loop requests back 
  //
  //
`ifdef DEBUG_NOC_LOOPBACK
  reg noc__cntl__cp_valid_d1 ;
  always @(posedge clk)
    noc__cntl__cp_valid_d1  <=  to_NoC_control_fifo[0].fifo_read            ; 

  assign to_NoC_control_fifo[0].fifo_read  = cntl__noc__cp_ready & ~to_NoC_control_fifo[0].fifo_empty    ;
  assign  noc__cntl__cp_cntl   =  to_NoC_control_fifo[0].fifo_read_cntl       ; 
  assign  noc__cntl__cp_type   =  to_NoC_control_fifo[0].fifo_read_type       ; 
  assign  noc__cntl__cp_data   =  to_NoC_control_fifo[0].fifo_read_data       ; 
  assign  noc__cntl__cp_peId   =  peId                                        ; 
  assign  noc__cntl__cp_laneId =  to_NoC_control_fifo[0].fifo_read_laneId     ; 
  assign  noc__cntl__cp_strmId =  to_NoC_control_fifo[0].fifo_read_strmId     ; 
  assign  noc__cntl__cp_valid  =  noc__cntl__cp_valid_d1                      ; 


  // FIXME - Debug - Loop Data back 
  assign to_NoC_data_fifo[0].fifo_read =  cntl__noc__dp_ready & ~to_NoC_data_fifo[0].fifo_empty  ; 
  assign  noc__cntl__dp_cntl           =  to_NoC_data_fifo[0].fifo_read_cntl   ; 
  assign  noc__cntl__dp_type           =  to_NoC_data_fifo[0].fifo_read_type   ; 
  assign  noc__cntl__dp_laneId         =  to_NoC_data_fifo[0].fifo_read_laneId ;
  assign  noc__cntl__dp_strmId         =  to_NoC_data_fifo[0].fifo_read_strmId ; 
  assign  noc__cntl__dp_data           =  to_NoC_data_fifo[0].fifo_read_data   ;
  assign  noc__cntl__dp_valid          =  to_NoC_data_fifo[0].fifo_read_data_valid        ; 

`else


  //------------------------------------------------------------
  // FIXME 
  // DEBUG : loop back until we have completed debug
  // Read controlled by Local outq controller
  /*
  assign  noc__cntl__cp_cntl   =  to_NoC_control_fifo[0].fifo_read_cntl       ; 
  assign  noc__cntl__cp_type   =  to_NoC_control_fifo[0].fifo_read_type       ; 
  assign  noc__cntl__cp_data   =  to_NoC_control_fifo[0].fifo_read_data       ; 
  assign  noc__cntl__cp_peId   =  peId                                        ; 
  assign  noc__cntl__cp_laneId =  to_NoC_control_fifo[0].fifo_read_laneId     ; 
  assign  noc__cntl__cp_strmId =  to_NoC_control_fifo[0].fifo_read_strmId     ; 
  assign  noc__cntl__cp_valid  =  to_NoC_control_fifo[0].fifo_read_data_valid ; 

  assign  noc__cntl__dp_cntl    =  to_NoC_data_fifo[0].fifo_read_cntl          ; 
  assign  noc__cntl__dp_type    =  to_NoC_data_fifo[0].fifo_read_type          ; 
  assign  noc__cntl__dp_laneId  =  to_NoC_data_fifo[0].fifo_read_laneId        ;
  assign  noc__cntl__dp_strmId  =  to_NoC_data_fifo[0].fifo_read_strmId        ; 
  assign  noc__cntl__dp_data    =  to_NoC_data_fifo[0].fifo_read_data          ;
  assign  noc__cntl__dp_valid   =  to_NoC_data_fifo[0].fifo_read_data_valid    ; 
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
  
  `include "noc_cntl_noc_local_outq_control_wires.vh"

  wire                                        local_toNoc_valid    ;  // when valid, destination port(s) must write local output data to their output fifo's
  wire [`NOC_CONT_NOC_PORT_CNTL_RANGE      ]  local_cntl_toNoc     ;  // local output cntl to destination port to be sent directly to butterfly network
  reg  [`NOC_CONT_NOC_PORT_DATA_RANGE      ]  local_data_toNoc     ;  // local output data to destination port to be sent directly to butterfly network

  wire [`PE_PE_ID_RANGE           ]  local_destinationPeId    ;  // destination peId from dma request address
  wire [`PE_CHIPLET_ADDRESS_RANGE ]  local_dmaRequestAddress  ;  // full chiplet address from dma request at output of cp output queue

  wire                           local_destinationReq        ; // Destination accepts the request and this fsm doesnt know who
  reg [`PE_PE_ID_BITMASK_RANGE ] local_destinationReqAddr    ; // bitmask address from header of packet
  reg [`PE_PE_ID_BITMASK_RANGE ] local_destinationReqAddr_d1 ; // Keep a registered version for transfer

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
  wire  [`NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ]  local_destinationReady    ;  // Start reading input fifo, destination handles directing the information
  wire                                              local_destinationReady_d1 ;  // Destination ready gated with ack vector
  wire  [`NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ]  local_destinationAck      ;  // input from CP local InQ fsm
  reg   [`NOC_CONT_NOC_NUM_OF_PORTS_VECTOR_RANGE ]  local_destinationAck_d1   ;  // Register the acking destinations so we can keep track of each destinations ready signal
  //--------------------------------------------------------------------------------------------
  // Port Control from NoC FSM
  //

  reg [`NOC_CONT_LOCAL_OUTQ_CNTL_STATE_RANGE] nc_local_outq_cntl_state;          // state flop
  reg [`NOC_CONT_LOCAL_OUTQ_CNTL_STATE_RANGE] nc_local_outq_cntl_state_next;
  
  
  // State register 
  always @(posedge clk)
    begin
      nc_local_outq_cntl_state <= (reset_poweron ) ? `NOC_CONT_LOCAL_OUTQ_CNTL_WAIT :
                                                   nc_local_outq_cntl_state_next        ;
    end
  
  always @(*)
    begin
      case (nc_local_outq_cntl_state)
        `NOC_CONT_LOCAL_OUTQ_CNTL_WAIT: 
          nc_local_outq_cntl_state_next = ( to_NoC_control_fifo[0].fifo_eop_count > 0 )  ? `NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ :  // only request transmission when we have a packets worth
                                          ( to_NoC_data_fifo[0].fifo_eop_count > 0    )  ? `NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ :
                                                                                           `NOC_CONT_LOCAL_OUTQ_CNTL_WAIT         ;
  
        // read head of fifo
        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ:
          nc_local_outq_cntl_state_next = ( (to_NoC_control_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) || (to_NoC_control_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP))  ? `NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ  :
                                                                                                                                                                                                             `NOC_CONT_LOCAL_OUTQ_CNTL_ERROR        ;  // put addressed peId bitmask as the destination
        // we have to identify the destination PE from the address, create a destination bitMask and put it out there to be accepted by one of
        // the output ports.
        // The output port has to acknowledge even if it isnt erady but the outq controller will only transfer if the destination is erady.
        // Note: Request set if "next" state is PORT_REQ
        // Note: The destination keeps the Ack asserted until the request is deasserted. The request is asserted all the time the next state is PORT_REQ.
        
        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ:
          nc_local_outq_cntl_state_next = ( ~|local_destinationAck                                                  ) ? `NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ     :
                                          ( local_destinationAck == (local_destinationReady & local_destinationAck) ) ? `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER  :  // output port has acked and all ports ready
                                                                                                                        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ     ;

        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER:
          nc_local_outq_cntl_state_next = `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2 ;

        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2:
          nc_local_outq_cntl_state_next = ( ((to_NoC_control_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (to_NoC_control_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3  :
                                                                                                                                                                                                             `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2  ;

        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3:
          nc_local_outq_cntl_state_next = `NOC_CONT_LOCAL_OUTQ_CNTL_CP_COMPLETE ;

  
        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_COMPLETE:
          nc_local_outq_cntl_state_next = `NOC_CONT_LOCAL_OUTQ_CNTL_WAIT ;
  
        // read head of fifo
        `NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ:
          nc_local_outq_cntl_state_next = ( (to_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) || (to_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP))  ? `NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ  :
                                                                                                                                                                                                             `NOC_CONT_LOCAL_OUTQ_CNTL_ERROR        ;  // put addressed peId bitmask as the destination
        // we have to identify the destination PE from the address, create
        // a destination bitMask and put it out there to be accepted by one of
        // the output ports
        `NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ:
          nc_local_outq_cntl_state_next = ( ~|local_destinationAck                                                 ) ? `NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ     :
                                          ( local_destinationAck == (local_destinationReady & local_destinationAck)) ? `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER  :  // output port has acked and all ports ready
                                                                                                                       `NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ     ;

        `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER:
          nc_local_outq_cntl_state_next = ((to_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP) && (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1))) ? `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3  :  // if there is only one piece of data
                                          (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1)) ? `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2  :  // if there is only one piece of data
                                                                                                                         `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER ;

        `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2:
          nc_local_outq_cntl_state_next = ( ((to_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (to_NoC_data_fifo[0].fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3  :
                                                                                                                                                                                                       `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2  ;

        `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3:
          nc_local_outq_cntl_state_next = `NOC_CONT_LOCAL_OUTQ_CNTL_DP_COMPLETE ;

  
        `NOC_CONT_LOCAL_OUTQ_CNTL_DP_COMPLETE:
          nc_local_outq_cntl_state_next = `NOC_CONT_LOCAL_OUTQ_CNTL_WAIT ;
  
        `NOC_CONT_LOCAL_OUTQ_CNTL_ERROR:
          nc_local_outq_cntl_state_next = `NOC_CONT_LOCAL_OUTQ_CNTL_ERROR ;
  
        default:
          nc_local_outq_cntl_state_next = `NOC_CONT_LOCAL_OUTQ_CNTL_WAIT;
    
      endcase // case(so_cntl_state)
    end // always @ (*)
  
  //-------------------------------------------------------------------------------------------------
  // Internal signals
  
  always @(posedge clk)
    begin
  
      local_destinationReqAddr_d1   <= (reset_poweron                                                      ) ? 'd0                          :
                                       (nc_local_outq_cntl_state == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ ) ? local_destinationReqAddr     :
                                       (nc_local_outq_cntl_state == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ ) ? local_destinationReqAddr     :
                                                                                                               local_destinationReqAddr_d1  ;

      // the ack from each destination is only active the cycle after the request is deasserted, so latch who acked so we can flow
      // control the transfer using the destinationReady vector
      local_destinationAck_d1 <= (reset_poweron                                                    )  ? 'd0               :
                                 (nc_local_outq_cntl_state == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ)  ? local_destinationAck    :
                                 (nc_local_outq_cntl_state == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ)  ? local_destinationAck    :
                                                                                                        local_destinationAck_d1 ;

      //local_destinationReady_d1 <= ~reset_poweron & (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1)) ;

    end

  assign local_destinationReady_d1 = (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1)) ;

  // extract destination peId from the dma address
  assign local_dmaRequestAddress = to_NoC_control_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE] ;
  assign local_destinationPeId   = (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ ) ? local_dmaRequestAddress[`PE_PE_DECODE_ADDRESS_RANGE]  :
                                   (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ ) ? to_NoC_data_fifo[0].fifo_read_peId                    :
                                                                                                               'd0                                                   ;

  `include "noc_cntl_noc_local_outq_control_assignments.vh"

  assign to_NoC_control_fifo[0].fifo_read  = (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_FIFO_READ   ) | // read head of packet to determine destination bitmask
                                             (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2 ) ; // send balance of control packet. Dont bother with ready because fifo can always take cp once it says ready

  assign to_NoC_data_fifo[0].fifo_read     = (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_FIFO_READ   ) | // read head of packet to determine destination bitmask
                                            ((nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2 ) & (local_destinationAck_d1 == (local_destinationReady & local_destinationAck_d1))); // send balance of data packet

  assign local_destinationReq              = (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ ) | // destination bitmask set, now request outport
                                             (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ ) ; // destination bitmask set, now request outport

  assign local_toNoc_valid    = ((nc_local_outq_cntl_state      == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_PORT_REQ   ) & ( local_destinationAck == (local_destinationReady & local_destinationAck) )) |
                                ((nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER) & local_destinationReady_d1) | // first construct header and send when destination first says ready
                                ((nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2) & local_destinationReady_d1) | // if data is read, then send it. Flow control affects read
                                ((nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3) ) |
                                ((nc_local_outq_cntl_state      == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_PORT_REQ   ) & ( local_destinationAck == (local_destinationReady & local_destinationAck) )) |
                                ((nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER) & local_destinationReady_d1) | // first construct header and send when destination first says ready
                                ((nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2) & local_destinationReady_d1) |  // if data is read, then send it. Flow control affects read
                                ((nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3) ) ;
                                   
  assign local_cntl_toNoc     = (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER) ?  `NOC_CONT_NOC_PROTOCOL_CNTL_SOP   :
                                (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2) ?  `NOC_CONT_NOC_PROTOCOL_CNTL_DATA  : 
                                (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER) ?  `NOC_CONT_NOC_PROTOCOL_CNTL_SOP   :
                                (nc_local_outq_cntl_state_next == `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2) ?  `NOC_CONT_NOC_PROTOCOL_CNTL_DATA  : 
                                                                                                               `NOC_CONT_NOC_PROTOCOL_CNTL_EOP   ;
  always @(*)
    begin
      case (nc_local_outq_cntl_state_next)

        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_HEADER:
          begin
            local_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE         ] = 'd`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_CP  ; 
            local_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE        ] = peId                                        ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE ] = local_destinationReqAddr_d1                 ;
          end

        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE2:
          begin
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_ADDRESS_RANGE  ] = to_NoC_control_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE ];
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STAGGER_RANGE  ] = to_NoC_control_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_STAGGER_RANGE ];
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_RANGE     ] = to_NoC_control_fifo[0].fifo_read_type                                                     ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_LANE_ID_RANGE  ] = to_NoC_control_fifo[0].fifo_read_laneId                                                   ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_STRM_ID_RANGE  ] = to_NoC_control_fifo[0].fifo_read_strmId                                                   ;
          end

        `NOC_CONT_LOCAL_OUTQ_CNTL_CP_SEND_CYCLE3:
          begin
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_NUM_OF_WORDS_RANGE  ] = to_NoC_control_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_NUM_OF_WORDS_RANGE ];
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_REQ_3RD_CYCLE_PAYLOAD_TYPE_RANGE  ] = to_NoC_control_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_REQ_2ND_CYCLE_PAYLOAD_TYPE_RANGE ];
          end

        `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_HEADER:
          begin
            local_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE         ] = 'd`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_DP  ; 
            local_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_SOURCE_PE_RANGE        ] = peId                                        ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE ] = local_destinationReqAddr_d1                 ;
          end

        `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE2:
          begin
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_DATA_RANGE     ] = to_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_DATA_RANGE ] ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_RANGE     ] = to_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_RANGE ] ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_RANGE     ] = to_NoC_data_fifo[0].fifo_read_type                                                    ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_RANGE  ] = to_NoC_data_fifo[0].fifo_read_laneId                                                  ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_RANGE  ] = to_NoC_data_fifo[0].fifo_read_strmId                                                  ;
          end

        `NOC_CONT_LOCAL_OUTQ_CNTL_DP_SEND_CYCLE3:
          begin
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE     ] = to_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_ALL_CYCLE_DATA_RANGE ] ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_4OR8_RANGE     ] = to_NoC_data_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_DATA_1ST_CYCLE_4OR8_RANGE ] ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_TYPE_RANGE     ] = to_NoC_data_fifo[0].fifo_read_type                                                    ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_LANE_ID_RANGE  ] = to_NoC_data_fifo[0].fifo_read_laneId                                                  ;
            local_data_toNoc[`NOC_CONT_EXTERNAL_DMA_DATA_2ND_CYCLE_STRM_ID_RANGE  ] = to_NoC_data_fifo[0].fifo_read_strmId                                                  ;
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
    for (gvi=0; gvi<`NOC_CONT_NOC_NUM_OF_PORTS; gvi=gvi+1) 
      begin: Port_to_NoC

        //--------------------------------------------------------------------------------------------
        // Port to NoC FIFO
        `NoC_Port_fifo

        assign clear = 0;  // FIXME

    
        //--------------------------------------------------------------------------------------------
        // Port Control to NoC FSM
        //

        `include "noc_cntl_noc_port_output_control_wires.vh"

        reg [`NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_RANGE] nc_port_toNoc_state;          // state flop
        reg [`NOC_CONT_NOC_PORT_OUTPUT_CNTL_STATE_RANGE] nc_port_toNoc_state_next;
  
        // State register 
        always @(posedge clk)
          begin
            nc_port_toNoc_state <= (reset_poweron ) ? `NOC_CONT_NOC_PORT_OUTPUT_CNTL_WAIT :
                                                            nc_port_toNoc_state_next ;
          end
    
        always @(*)
          begin
            case (nc_port_toNoc_state)
        
              `include "noc_cntl_noc_port_output_control_fsm_state_transitions.vh"

            endcase // 
          end // always @ (*)
    
        //-------------------------------------------------------------------------------------------------
        // Internal signals
    
        always @(posedge clk)
          begin
        
          end

        `include "noc_cntl_noc_port_output_control_fsm_assignments.vh"

      end
  endgenerate

  `include "noc_cntl_noc_port_output_control_assignments.vh"

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

  `include "noc_cntl_noc_local_inq_control_wires.vh"


  //--------------------------------------------------------------------------------------------
  // Local Input FSM
  //
  reg [`NOC_CONT_LOCAL_INQ_CNTL_STATE_RANGE] nc_local_inq_cntl_state      ;  // state flop
  reg [`NOC_CONT_LOCAL_INQ_CNTL_STATE_RANGE] nc_local_inq_cntl_state_next ;
  

  // State register 
  always @(posedge clk)
    begin
      nc_local_inq_cntl_state <= (reset_poweron ) ? `NOC_CONT_LOCAL_INQ_CNTL_WAIT :
                                                     nc_local_inq_cntl_state_next    ;
    end
  
  always @(*)
    begin

      case (nc_local_inq_cntl_state)

        `include "noc_cntl_noc_local_inq_control_fsm_state_transitions.vh"

      endcase // case(nc_local_inq_cntl_state)

    end

  `include "noc_cntl_noc_local_inq_control_assignments.vh"

  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  // Port Input Control
  //
  `include "noc_cntl_port_input_control_wires.vh"

  generate
    for (gvi=0; gvi<`NOC_CONT_NOC_NUM_OF_PORTS; gvi=gvi+1) 
      begin: Port_from_NoC

        //--------------------------------------------------------------------------------------------
        // Port Control from NoC FIFO
        `NoC_Port_fifo

        assign clear = 0;  // FIXME

        //--------------------------------------------------------------------------------------------
        wire                            destinationReq       ; // request to all destinations, one (or more) will accept.
        wire [`PE_PE_ID_BITMASK_RANGE ] destinationReqAddr   ; // bitmask address from header of packet
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
        wire [`NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE ]  destinationReady    ;  // Start reading input fifo, destination handles directing the information
        wire [`NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE ]  destinationAck      ;  // input from local InQ fsm
        reg  [`NOC_CONT_NOC_NUM_OF_PKT_DEST_VECTOR_RANGE ]  destinationAck_d1   ;  // Register the acking destinations so we can keep track of each destinations ready signal
        reg                                                 destinationReady_d1 ;  // Destination ready gated with ack vector

        // the following are to NoC packet bus from the input controller
        wire                                        fromNoc_valid    ;  // when valid, the destination port(s) must write to their output fifo's
        wire [`NOC_CONT_NOC_PORT_CNTL_RANGE      ]  cntl_fromNoc     ;  // 
        wire [`NOC_CONT_NOC_PORT_DATA_RANGE      ]  data_fromNoc     ;  //
        wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  type_fromNoc     ;  // valid only during 2nd cycle of external NoC packet       
        //--------------------------------------------------------------------------------------------
        // Port Control from NoC FSM
        //

        reg [`NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_RANGE] nc_port_fromNoc_state;          // state flop
        reg [`NOC_CONT_NOC_PORT_INPUT_CNTL_STATE_RANGE] nc_port_fromNoc_state_next;
  
        
        // State register 
        always @(posedge clk)
          begin
            nc_port_fromNoc_state <= (reset_poweron ) ? `NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT :
                                                         nc_port_fromNoc_state_next        ;
          end
    
        always @(*)
          begin
            case (nc_port_fromNoc_state)
              `NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT: 
                nc_port_fromNoc_state_next = ( ~fifo_empty && (fifo_eop_count > 0) )  ? `NOC_CONT_NOC_PORT_INPUT_CNTL_FIFO_READ :
                                                                                        `NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT      ;
    
              // read head of fifo
              `NOC_CONT_NOC_PORT_INPUT_CNTL_FIFO_READ:
                nc_port_fromNoc_state_next = ( (fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP) || (fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP))  ? `NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ  :  // put addressed peId bitmask as the destination
                                                                                                                                                                  `NOC_CONT_NOC_PORT_INPUT_CNTL_ERROR            ;
              // we have to identify the destination PE from the incoming pe mask address
              // put it out there to be accepted by an output port(s) and/or local input queue
              `NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ:
                nc_port_fromNoc_state_next = ( ~|destinationAck                                         ) ? `NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ  :  // no destination has acked yet
                                                ( destinationAck == (destinationReady & destinationAck) ) ? `NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER  :  // output port has acked and all destinations ready
                                                                                                            `NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ  ;
            
              `NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER:
                nc_port_fromNoc_state_next = `NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET ;
            
              `NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET:
                nc_port_fromNoc_state_next = ( fifo_read_data_valid && ((fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_EOP) || (fifo_read_cntl == `NOC_CONT_NOC_PROTOCOL_CNTL_SOP_EOP)))  ? `NOC_CONT_NOC_PORT_INPUT_CNTL_COMPLETE        :
                                                                                                                                                                                 `NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET ;
            
              `NOC_CONT_NOC_PORT_INPUT_CNTL_COMPLETE:
                nc_port_fromNoc_state_next = `NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT ;
    
              `NOC_CONT_NOC_PORT_INPUT_CNTL_ERROR:
                nc_port_fromNoc_state_next = `NOC_CONT_NOC_PORT_INPUT_CNTL_ERROR ;
    
              default:
                nc_port_fromNoc_state_next = `NOC_CONT_NOC_PORT_INPUT_CNTL_WAIT;
          
            endcase // case(so_cntl_state)
          end // always @ (*)
    
        //-------------------------------------------------------------------------------------------------
        // Internal signals
    
        assign fifo_read  = (nc_port_fromNoc_state_next == `NOC_CONT_NOC_PORT_INPUT_CNTL_FIFO_READ      ) | // read head of packet to determine destination bitmask
                            ((destinationAck_d1 == (destinationReady & destinationAck_d1)) & (nc_port_fromNoc_state_next == `NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET)) ; // send balance of control packet
   
        assign destinationReq       = (nc_port_fromNoc_state_next == `NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ ) ; // destination bitmask set, now request outport
        assign destinationReqAddr   = fifo_read_data[`NOC_CONT_EXTERNAL_1ST_CYCLE_DESTINATION_ADDR_RANGE ] ;
        assign destinationPriority  = fifo_read_data[`NOC_CONT_EXTERNAL_1ST_CYCLE_PRIORITY_RANGE         ] ;
   
        assign fromNoc_valid    = (nc_port_fromNoc_state == `NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_HEADER) |  destinationReady_d1 ;// header was read to provide address to destinations, now transter
//                                 (nc_port_fromNoc_state == `NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET) ; // transfer rest of packet until EOP
        assign cntl_fromNoc     = fifo_read_cntl ;  // 
        assign data_fromNoc     = fifo_read_data ;  //
        assign type_fromNoc     = fifo_read_data[`NOC_CONT_EXTERNAL_DMA_REQ_2ND_CYCLE_TYPE_RANGE ];  // valid only during 2nd cycle of external NoC packet       
   
        always @(posedge clk)
          begin
        
            // the ack from each destinatio  is only active the cycle after the request is deasserted, so latch who acked so we can flow
            // control the transfer using the destinationReady vector
            destinationAck_d1 <= (reset_poweron                                                         )  ? 'd0               :
                                 (nc_port_fromNoc_state == `NOC_CONT_NOC_PORT_INPUT_CNTL_DESTINATION_REQ)  ? destinationAck    :
                                                                                                             destinationAck_d1 ;

            destinationReady_d1 <= (reset_poweron       )  ? 'd0               :
                                                         ((destinationAck_d1 == (destinationReady & destinationAck_d1)) & (nc_port_fromNoc_state_next == `NOC_CONT_NOC_PORT_INPUT_CNTL_TRANSFER_PACKET)) ; // send balance of control packet

          end

      end
  endgenerate

  `include "noc_cntl_port_input_control_assignments.vh"

  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  //  ******** END OF TRAFFIC INTO THE NODE ********
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------

`endif

endmodule

