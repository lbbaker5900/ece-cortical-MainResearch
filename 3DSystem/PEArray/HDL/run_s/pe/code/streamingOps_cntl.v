/*********************************************************************************************

    File name   : streamingOps_cntl.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

    Description : This module takes requests from the PE core and configures the operation and
                  requests access to the DMA engine.

                  DMA's
                  The address from each exec lane is examined and determined whether the source or destination addresses are local or within another PE.
                  Two DMA modes:
                   a) Solicited DMA - destination is always local, source local or global
                        When the source is not local, the CNTL sets up the write address and enables the local DMA engine. The local DMA write is ready.
                        The CNTL then sends a DMA request to the other PE providing the address and number of types.
                        Initial implementation will be the read portion of the DMA stream will not be used and only one of the two streams are used.
                        FIXME: option to have both streams be independent along with read and write also independent.
                        FIXME: Need to consider deadlock case where all exec lanes requires a solicited DMA and source PE also has assigned all DMA engines
                        Note: The PE must "wait" to get an all clear from all PE's before declaring "complete". Therefore, a sync_status must be recieved from all PE's in the
                        PE group (rs1) before declaring complete.

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "stack_interface.vh"
`include "noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"

`ifdef SYNTHESIS
  `define STREAMINGOPS_CNTL_INCLUDE_REAL_MEMORY
`endif

`ifndef SYNTHESIS
  `ifdef STREAMINGOPS_CNTL_INCLUDE_REAL_MEMORY
    `include "sasslnpky2p32x35cm4sw0bk1ltlc1_fast_func.v"
    `include "std_cells.v"
  `endif
`endif

// FIXME':
// Features to be added:
// a) Exceptions
//   i) if write address isnt in this PE
//   ii) if two streams from the same lane are "external" addresses (we only
//       have one "from NoC" bus from  cntl to sdp
//       Note: we could simply use one for two streams as we can only accept
//       one strean from the NoC anyway. We will then need to encode the
//       stream ID in the datapath to the sdp
//
//
//


module streamingOps_cntl (

                          //--------------------------------------------------------
                          // PE core interface
                          ready             , // ready to start streaming
                          complete          ,

                          sys__pe__allSynchronized  ,  // all PE streams are complete
                          pe__sys__thisSynchronized ,  // this PE's streams are complete
                          
                          //--------------------------------------------------------
                          // Memory Access Interface
                          scntl__memc__request      ,
                          memc__scntl__granted      ,
                          scntl__memc__released     ,

                          // streaming op and dma function interface
                          `include "streamingOps_cntl_control_ports.vh"

                          //--------------------------------------------------------
                          // NoC interface to stOp
                          //
                          // Information between CNTL and NOC is a packet interface not a stream interface.
                          // This means that every packet is delineated with SOP and EOP.
                          // With a stream interface, the entire stream is delineated with SOD and EOD
                          // For information to NoC, the cntl will need to add SOP/EOP to the stream from stOp to delineate all packets
                          // For information from NoC, for a multi-packet transfer such as a DMA, to generate the stream to stOp, the cntl will detect 
                          // the first data packet type of DMA_DATA_SOD and add SOD to the first transaction. The cntl then transfers while setting
                          // cntl=data until the last packet type of DMA_DATA_EOD and adds cntl=EOD to the last transaction.
                          //
                          `include "streamingOps_cntl_stOp_noc_ports.vh"

                          //--------------------------------------------------------
                          // external interface
                          ext_enable        ,
                          ext_ready         ,
                          ext_start         ,
                          ext_complete      ,

                          //--------------------------------------------------------
                          // register interface
                          `include "pe_simd_ports.vh"

                          //--------------------------------------------------------
                          // System
                          peId              ,
                          clk               ,
                          reset_poweron     
    );

  input                       clk            ;
  input                       reset_poweron  ;
  input [`PE_PE_ID_RANGE   ]  peId           ; 

  // interface to PE core
  output      ready             ; // ready to start streaming
  output      complete          ;

  input       sys__pe__allSynchronized  ;  // all PE streams are complete
  output      pe__sys__thisSynchronized ;  // this PE's streams are complete

  // NoC interface to stOp
  // includes data to and from all execution lane streaming operation modules
  `include "streamingOps_cntl_stOp_noc_ports_declaration.vh"

  // streaming op and dma function control interface
  `include "streamingOps_cntl_control_ports_declaration.vh"
  
  // External interface
  output ext_enable        ;
  input  ext_ready         ;
  output ext_start         ;
  input  ext_complete      ;
  
  // interface to memory controller
  output       scntl__memc__request          ;
  input        memc__scntl__granted          ;
  output       scntl__memc__released         ;


  //-------------------------------------------------------------------------------------------------
  // Exec lane Register(s)
  //
  `include "pe_simd_port_declarations.vh"
  
  //-------------------------------------------------------------------------------------------
  // Wires and Register
  //

  `include "streamingOps_cntl_simd_wires.vh"
  `include "streamingOps_cntl_simd_assignments.vh"  // convert from multidimensional array

  wire scntl__memc__request  ;
  wire memc__scntl__granted  ;
  wire scntl__memc__released ;
  wire mem_granted          ;
  reg  mem_request          ;
  wire mem_request_next     ;
  reg  mem_released         ;
  wire mem_released_next    ;

  // NoC interface to stOp
  `include "streamingOps_cntl_noc_wires.vh"

  // SDP interface to stOp
  `include "streamingOps_cntl_stOp_wires.vh"

  // assign control to dma and stOp from loaded registers
  `include "streamingOps_cntl_control_wires.vh"

  //------------------------------------------------------------
  // Operation related fields
  //
  // Enable
  wire enable ;
  assign enable = rs0[0] ; // FIXME

  wire [`PE_NUM_OF_EXEC_LANES_RANGE] exec_lanes_active ;
  assign exec_lane_active = rs1[`PE_NUM_OF_EXEC_LANES_RANGE];

  wire [31:0] operation = rs0[31:1];  // FIXME

  // extract source and destination flags from operation fields
  //
  // to/from memory
  /*
  wire source_is_memory         = ( operation[`STREAMING_OP_CNTL_OPERATION_FROM_RANGE               ] == `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY );
  wire destination_is_memory    = ( operation[`STREAMING_OP_CNTL_OPERATION_TO_RANGE                 ] == `STREAMING_OP_CNTL_OPERATION_TO_MEMORY   );
*/

  wire [`STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_RANGE ] num_of_src_streams  =   operation[`STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_RANGE  ] ;  // 0, 1 or 2
  wire [`STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_RANGE] num_of_dest_streams =   operation[`STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_RANGE ] ;  // 0, 1 or 2

  // extract actual operation from opCode
  wire  [`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE ]  opcode       ; // BSUM or NOP or ??
  assign opcode = operation[`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE];

  // number of streams to/from memory
  wire [`STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_RANGE ] streams_from_memory ;  // 0, 1 or 2
  wire [`STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_RANGE] streams_to_memory   ;

  wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE    ] strm0_source        ;
  wire [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE     ] strm1_source        ;

  // Currently DMA to/from other PE's are supported only by NOP's - FIXME
  wire is_nop = (operation[`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE] == `STREAMING_OP_CNTL_OPERATION_NOP);

  assign streams_from_memory         = ((operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE ] == `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY) && 
                                        (operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE  ] == `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY))    ? 'd2 :
                                       (operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE ] == `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY  )    ? 'd1 :
                                       (operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE  ] == `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY  )    ? 'd1 :
                                                                                                                                                           'd0 ;

  assign streams_to_memory           = ((operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ] == `STREAMING_OP_CNTL_OPERATION_TO_MEMORY) && 
                                        (operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ] == `STREAMING_OP_CNTL_OPERATION_TO_MEMORY))     ? 'd2 :
                                       (operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ] == `STREAMING_OP_CNTL_OPERATION_TO_MEMORY  )     ? 'd1 :
                                       (operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ] == `STREAMING_OP_CNTL_OPERATION_TO_MEMORY  )     ? 'd1 :
                                                                                                                                                           'd0 ;

/*
  assign streams_from_memory         =   ( source_is_memory      ) ? num_of_src_streams : 
                                                                     2'd0  ;
  assign streams_to_memory           =   ( destination_is_memory ) ? num_of_dest_streams : 
                                                                     2'd0  ;
*/

  assign mem_granted = memc__scntl__granted ;


  reg [`STREAMING_OP_CNTL_FROMNOC_CONT_STATE_RANGE] so_fromNoc_cntl_state;          // state flop
  reg [`STREAMING_OP_CNTL_FROMNOC_CONT_STATE_RANGE] so_fromNoc_cntl_state_next;
  
  // local NoC Control request FSM signals
  reg NocControlLocalAck          ;
  reg NocControlLocalRequestWait  ;
  wire cntl_to_noc_1st_cycle      ;

  // external NoC request FSM signals
  reg NocControlExternalAck          ;
  reg NocControlExternalReq          ;
  reg NocControlExternalRequestWait  ;
  reg  [`PE_PE_ID_RANGE                      ]  NocControlExternalDmaPeId                  ;
  reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE]  NocControlExternalDmaLaneId                ;
  reg                                           NocControlExternalDmaStrmId                ;
  reg  [`DMA_CONT_STRM_ADDRESS_RANGE]           NocControlExternalDma_read_start_address   ; 

  // from stOp to NoC Control FSM signals
  reg FromStOpControlRequestWait  ;

  //-------------------------------------------------------------------------------------------
  // Memory Request FSM
  //
  // Once memory has been acquired, each of the individual stream FSM's are
  // enable
  //
  
  reg  ready             ;
  wire set_ready         ;
  wire clear_ready       ;
  reg  complete          ;
  wire set_complete      ;
  wire clear_complete    ;
  wire strms_completed   ;  // FIXME: need to replace with streams completed and sync from PE's

  wire clear_op          ;  // used to clear any operation related logic (such as fifo's)

  reg  strm_enable          ;  // used to indicate to the stream controllers that memory has been granted and they can start controlling their DMA/stOp's
  wire set_strm_enable      ;
  wire clear_strm_enable    ;
 
  reg [`STREAMING_OP_CNTL_STATE_RANGE] so_cntl_state;          // state flop
  reg [`STREAMING_OP_CNTL_STATE_RANGE] so_cntl_state_next;
  
  // State register 
  always @(posedge clk)
    begin
      so_cntl_state <= (reset_poweron ) ? `STREAMING_OP_CNTL_WAIT
                                        : so_cntl_state_next      ;
    end


  always @(*)
    begin
      case (so_cntl_state)
        `STREAMING_OP_CNTL_WAIT: 
          so_cntl_state_next = ( enable )  ? `STREAMING_OP_CNTL_MEM_REQ     :
                                             `STREAMING_OP_CNTL_WAIT        ;

        `STREAMING_OP_CNTL_MEM_REQ:
          so_cntl_state_next = (~enable      ) ? `STREAMING_OP_CNTL_RELEASE_MEM  :
                               ( mem_granted ) ? `STREAMING_OP_CNTL_MEM_GRANTED  :
                                                 `STREAMING_OP_CNTL_MEM_REQ      ;

        `STREAMING_OP_CNTL_MEM_GRANTED:
          so_cntl_state_next = ( ~enable     ) ? `STREAMING_OP_CNTL_RELEASE_MEM :
                                                 `STREAMING_OP_CNTL_OP_INIT     ;

        `STREAMING_OP_CNTL_OP_INIT:
          so_cntl_state_next = ( ~enable || strms_completed ) ? `STREAMING_OP_CNTL_RELEASE_MEM :
                                                                `STREAMING_OP_CNTL_OP_INIT     ;

        `STREAMING_OP_CNTL_RELEASE_MEM:
          so_cntl_state_next = (~mem_granted ) ? `STREAMING_OP_CNTL_COMPLETE    :
                                                 `STREAMING_OP_CNTL_RELEASE_MEM ; 

        `STREAMING_OP_CNTL_COMPLETE:
          so_cntl_state_next = ( enable ) ? `STREAMING_OP_CNTL_COMPLETE     :
                                            `STREAMING_OP_CNTL_WAIT         ;
        
        default:
          so_cntl_state_next = `STREAMING_OP_CNTL_WAIT;
    
      endcase // case(so_cntl_state)
    end // always @ (*)

  //-------------------------------------------------------------------------------------------------
  // internal signals

  assign clear_op         =  (so_cntl_state == `STREAMING_OP_CNTL_WAIT ) ;


  //-------------------------------------------------------------------------------------------------
  // output equations

  assign scntl__memc__request  = mem_request          ;
  assign scntl__memc__released = mem_released         ;

  assign mem_request_next  =  ((so_cntl_state == `STREAMING_OP_CNTL_WAIT                ) & enable ) ||
                               (so_cntl_state == `STREAMING_OP_CNTL_MEM_REQ             )            ||
                               (so_cntl_state == `STREAMING_OP_CNTL_MEM_GRANTED         )            ||
                               (so_cntl_state == `STREAMING_OP_CNTL_OP_INIT             )            ;

  assign mem_released_next =   (so_cntl_state == `STREAMING_OP_CNTL_WAIT        ) ||
                               (so_cntl_state == `STREAMING_OP_CNTL_MEM_REQ     ) ||
                               (so_cntl_state == `STREAMING_OP_CNTL_RELEASE_MEM ) ||
                               (so_cntl_state == `STREAMING_OP_CNTL_COMPLETE    ) ;

  assign clear_strm_enable    =  (so_cntl_state == `STREAMING_OP_CNTL_WAIT        );
  assign set_strm_enable      =  (so_cntl_state == `STREAMING_OP_CNTL_OP_INIT    );
  
  assign clear_ready         =  (so_cntl_state == `STREAMING_OP_CNTL_WAIT        );
  assign set_ready           =  (so_cntl_state == `STREAMING_OP_CNTL_OP_INIT     );
  
  assign clear_complete    =  (so_cntl_state == `STREAMING_OP_CNTL_WAIT        );
  assign set_complete      =  (so_cntl_state == `STREAMING_OP_CNTL_COMPLETE    );


  always @(posedge clk)
    begin
      mem_request    <= ( reset_poweron ) ? 'd0  : mem_request_next  ;
      mem_released   <= ( reset_poweron ) ? 'd1  : mem_released_next ;

      ready          <= ( reset_poweron    ) ? 1'b0       : 
                        ( clear_ready      ) ? 1'b0       :
                        ( set_ready        ) ? 1'b1       :
                                               ready      ;

      strm_enable     <= ( reset_poweron    ) ? 1'b0       : 
                        ( clear_strm_enable ) ? 1'b0       :
                        ( set_strm_enable   ) ? 1'b1       :
                                               strm_enable ;

      complete       <= ( reset_poweron    ) ? 1'b0       : 
                        ( clear_complete   ) ? 1'b0       :
                        ( set_complete     ) ? 1'b1       :
                                               complete   ;
    end
   
  //-------------------------------------------------------------------------------------------
  // Stream Control FSM
  //
  genvar gvi;
  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES; gvi=gvi+1) 
      begin: strm_control

        reg [`STREAMING_OP_CNTL_STRM_STATE_RANGE] so_cntl_strm_state;          // state flop
        reg [`STREAMING_OP_CNTL_STRM_STATE_RANGE] so_cntl_strm_state_next;
        
        wire lane_enable ;

        reg  strm_complete          ;
        wire set_strm_complete      ;
        wire clear_strm_complete    ;

        reg  NocLocalDmaRequest       ;  // if we see the read address isnt local, request a NoC DMA
        reg  NocLocalDmaRequestStrm   ;  // either stream can request a DMA
        reg  localDmaReqNocAck        ;

        reg  externalDmaReqStrmReq    ;  // the lanes available stream has been selected for an external DMA request
        reg  externalDmaReqStrmAck    ;  // ack that the stream is available and will start streaming to the NoC
        reg  externalDmaReqStrm       ;  // Stream assigned to the external DMA request

        reg  strm0_read_enable        ;  // DMA enables
        wire set_strm0_read_enable    ;
        wire clear_strm0_read_enable  ;
        reg  strm1_read_enable        ;
        wire set_strm1_read_enable    ;
        wire clear_strm1_read_enable  ;

        reg  strm0_write_enable       ;
        wire set_strm0_write_enable   ;
        wire clear_strm0_write_enable ;
        reg  strm1_write_enable       ;
        wire set_strm1_write_enable   ;
        wire clear_strm1_write_enable ;

        wire strm0_read_ready         ;  // DMA ready
        wire strm1_read_ready         ;
        wire strm0_write_ready        ;
        wire strm1_write_ready        ;

        wire strm0_read_complete      ;  // DMA complete
        wire strm1_read_complete      ;
        wire strm0_write_complete     ;
        wire strm1_write_complete     ;

        reg  strm0_stOp_enable        ;
        wire set_strm0_stOp_enable    ;
        wire clear_strm0_stOp_enable  ;
        reg  strm1_stOp_enable        ;
        wire set_strm1_stOp_enable    ;
        wire clear_strm1_stOp_enable  ;

        wire strm0_stOp_ready         ;  // streaming Op ready
        wire strm1_stOp_ready         ;

        wire strm0_stOp_complete      ;  // streaming Op complete
        wire strm1_stOp_complete      ;

        wire strm_transferToNoc_complete ;  // monitor fifo from stOp and wait for EOP

        wire   [`PE_DATA_TYPES_RANGE         ] strm0_type           ;
        wire   [`PE_MAX_NUM_OF_TYPES_RANGE   ] strm0_num_of_types   ;
        wire   [`PE_MAX_STAGGER_RANGE        ] strm0_stagger        ;
        wire   [`PE_DATA_TYPES_RANGE         ] strm1_type           ;
        wire   [`PE_MAX_NUM_OF_TYPES_RANGE   ] strm1_num_of_types   ;
        wire   [`PE_MAX_STAGGER_RANGE        ] strm1_stagger        ;

        wire [`PE_PE_ID_RANGE ]  strm0_read_peId   ;
        wire [`PE_PE_ID_RANGE ]  strm1_read_peId   ;
        wire [`PE_PE_ID_RANGE ]  strm0_write_peId  ;
        wire [`PE_PE_ID_RANGE ]  strm1_write_peId  ;

        wire strm0_read_local  = (strm0_read_peId  == peId)           ;
        wire strm1_read_local  = (strm1_read_peId  == peId)           ;
        wire strm0_write_local = (strm0_write_peId == peId)           ;
        wire strm1_write_local = (strm1_write_peId == peId)           ;

        reg [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ] strm0_stOp_src  ;
        reg [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ] strm1_stOp_src  ;
        reg [`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ] strm0_stOp_dest ;
        reg [`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ] strm1_stOp_dest ;
   
        wire both_dma_streams_complete = ((strm0_read_enable  & strm0_read_complete ) | ~strm0_read_enable ) 
                                       & ((strm1_read_enable  & strm1_read_complete ) | ~strm1_read_enable )
                                       & ((strm0_write_enable & strm0_write_complete) | ~strm0_write_enable) 
                                       & ((strm1_write_enable & strm1_write_complete) | ~strm1_write_enable) ;

        wire both_stOp_streams_complete = ((strm0_stOp_enable  & strm0_stOp_complete ) | ~strm0_stOp_enable ) 
                                        & ((strm1_stOp_enable  & strm1_stOp_complete ) | ~strm1_stOp_enable );

        wire both_stOp_streams_ready = ((strm0_stOp_enable  & strm0_stOp_ready ) | ~strm0_stOp_enable ) 
                                     & ((strm1_stOp_enable  & strm1_stOp_ready ) | ~strm1_stOp_enable );

        wire set_strm0_assignedToExternalDma   ;
        wire clear_strm0_assignedToExternalDma ;
        reg  strm0_assignedToExternalDma       ;
        reg  [`PE_PE_ID_RANGE                      ]  strm0_ExternalDmaPeId                  ;
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE]  strm0_ExternalDmaLaneId                ;
        reg                                           strm0_ExternalDmaStrmId                ;
        reg  [`DMA_CONT_STRM_ADDRESS_RANGE]           strm0_ExternalDma_read_start_address   ; 

        wire set_strm1_assignedToExternalDma   ;
        wire clear_strm1_assignedToExternalDma ;
        reg  strm1_assignedToExternalDma       ;
        reg  [`PE_PE_ID_RANGE                      ]  strm1_ExternalDmaPeId                  ;
        reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE]  strm1_ExternalDmaLaneId                ;
        reg                                           strm1_ExternalDmaStrmId                ;
        reg  [`DMA_CONT_STRM_ADDRESS_RANGE]           strm1_ExternalDma_read_start_address   ; 

        wire ReadyForStreamExternalRequests;

        always @(posedge clk)
          begin
            so_cntl_strm_state <= (reset_poweron ) ? `STREAMING_OP_CNTL_STRM_WAIT :
                                                      so_cntl_strm_state_next     ;
          end
   
        always @(*)
          begin
            case (so_cntl_strm_state)
              `STREAMING_OP_CNTL_STRM_WAIT: 
                so_cntl_strm_state_next = ( strm_enable && lane_enable ) ? `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE :  // main controller indicates memory has been granted
                                                                           `STREAMING_OP_CNTL_STRM_WAIT             ;

              // enable dma write - use number of dest streams - assumes all writes are local
              `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE:   
                so_cntl_strm_state_next = ( (streams_from_memory >= 'd1) && (strm0_read_peId != peId) ) ? `STREAMING_OP_CNTL_STRM_STRM0_REQ_NOC_DMA  :
                                          ( (streams_from_memory == 'd2) && (strm1_read_peId != peId) ) ? `STREAMING_OP_CNTL_STRM_STRM1_REQ_NOC_DMA  :
                                                                                                          `STREAMING_OP_CNTL_STRM_ENABLE_STOP        ;

              // set NocReq and wait for acknowledge from NoC controller
              `STREAMING_OP_CNTL_STRM_STRM0_REQ_NOC_DMA:
                so_cntl_strm_state_next = ( ~localDmaReqNocAck      ) ? `STREAMING_OP_CNTL_STRM_STRM0_REQ_NOC_DMA  :
                                                                        `STREAMING_OP_CNTL_STRM_STRM0_ACK_NOC_DMA  ;
              // wait for ack to be deasserted
              `STREAMING_OP_CNTL_STRM_STRM0_ACK_NOC_DMA:
                so_cntl_strm_state_next = ( localDmaReqNocAck                                         ) ? `STREAMING_OP_CNTL_STRM_STRM0_ACK_NOC_DMA  :
                                          ( (streams_from_memory == 'd2) && (strm1_read_peId != peId) ) ? `STREAMING_OP_CNTL_STRM_STRM1_REQ_NOC_DMA  :  // FIXME: this may be an exception if we only support one external stream
                                                                                                          `STREAMING_OP_CNTL_STRM_ENABLE_STOP        ;
              
              // set NocReq and wait for acknowledge from NoC controller
              `STREAMING_OP_CNTL_STRM_STRM1_REQ_NOC_DMA:
                so_cntl_strm_state_next = ( ~localDmaReqNocAck      ) ? `STREAMING_OP_CNTL_STRM_STRM1_REQ_NOC_DMA  :
                                                                        `STREAMING_OP_CNTL_STRM_STRM1_ACK_NOC_DMA  ;
              // wait for ack to be deasserted
              `STREAMING_OP_CNTL_STRM_STRM1_ACK_NOC_DMA: 
                so_cntl_strm_state_next = (  localDmaReqNocAck      ) ? `STREAMING_OP_CNTL_STRM_STRM1_ACK_NOC_DMA  :
                                                                        `STREAMING_OP_CNTL_STRM_ENABLE_STOP        ;
              
              
              // At this point the source of the streams have been configured.
              // We have set source for stOp. If a NoC DMA was requested, the stOp source was set to NoC
              
              `STREAMING_OP_CNTL_STRM_ENABLE_STOP: 
                so_cntl_strm_state_next = ( both_stOp_streams_ready ) ? `STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ  :
                                                                        `STREAMING_OP_CNTL_STRM_ENABLE_STOP    ;
   
              `STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ: 
                so_cntl_strm_state_next =                             `STREAMING_OP_CNTL_STRM_OP_START         ;
   
              `STREAMING_OP_CNTL_STRM_OP_START: 
                so_cntl_strm_state_next = ( externalDmaReqStrmReq     && ~strm0_read_enable         ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0 :
                                          ( externalDmaReqStrmReq     && ~strm1_read_enable         ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1 :
                                          ( both_dma_streams_complete && both_stOp_streams_complete ) ? `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC         :
                                                                                                        `STREAMING_OP_CNTL_STRM_OP_START              ;
              
              `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0: 
//                so_cntl_strm_state_next =  ( ~externalDmaReqStrmReq ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_STOP     :
                so_cntl_strm_state_next =  ( ~externalDmaReqStrmReq ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_DMA_READ     :  // only enable dma read for external dma request
                                                                        `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0                 ;
/*
              `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_STOP: 
                so_cntl_strm_state_next = ( strm0_stOp_ready ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_DMA_READ  :
                                                                 `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_STOP      ;
*/
   
              `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_DMA_READ: 
                so_cntl_strm_state_next = ( strm0_read_ready ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_ACK                      :
                                                                 `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_DMA_READ    ;
   
/*
              `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1: 
                so_cntl_strm_state_next =  ( ~externalDmaReqStrmReq ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_STOP :
                                                                        `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1             ;
*/

              `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1: 
//                so_cntl_strm_state_next =  ( ~externalDmaReqStrmReq ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_STOP     :
                so_cntl_strm_state_next =  ( ~externalDmaReqStrmReq ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_DMA_READ     :  // only enable dma read for external dma request
                                                                        `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1                 ;

/*
              `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_STOP: 
                so_cntl_strm_state_next = ( strm1_stOp_ready ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_DMA_READ  :
                                                                 `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_STOP      ;
*/
   
              `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_DMA_READ: 
                so_cntl_strm_state_next = ( strm1_read_ready ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_ACK                      :
                                                                 `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_DMA_READ    ;

              `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_ACK: 
                so_cntl_strm_state_next = `STREAMING_OP_CNTL_STRM_OP_START  ;
   
              `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC: 
                so_cntl_strm_state_next = ( externalDmaReqStrmReq     && ~strm0_read_enable         ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0 :
                                          ( externalDmaReqStrmReq     && ~strm1_read_enable         ) ? `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1 :
                                          ( sys__pe__allSynchronized                                ) ? `STREAMING_OP_CNTL_STRM_COMPLETE              :
                                                                                                        `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC         ;
   
              `STREAMING_OP_CNTL_STRM_COMPLETE:
                so_cntl_strm_state_next = ( strm_enable ) ? `STREAMING_OP_CNTL_STRM_COMPLETE     :
                                                            `STREAMING_OP_CNTL_STRM_WAIT         ;
              
              default:
                so_cntl_strm_state_next = `STREAMING_OP_CNTL_STRM_WAIT;
          
            endcase // case(so_cntl_strm_state)
          end // always @ (*)
   
        //-------------------------------------------------------------------------------------------------
        // output equations
   
        assign ReadyForStreamExternalRequests  =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_OP_START      ) |
                                                  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC ) ;
        
        assign clear_strm_complete    =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT        );
        assign set_strm_complete      =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_COMPLETE    );
        
        assign clear_strm0_stOp_enable  =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT        );
        assign set_strm0_stOp_enable    =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_STOP ) & (num_of_src_streams >= 'd1) ; // |
//                                           (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_STOP ) ;  // enable if we are processign an external dma request
                                        
        assign clear_strm1_stOp_enable  =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT        );
        assign set_strm1_stOp_enable    =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_STOP ) & (num_of_src_streams == 'd2) ; // |
//                                           (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_STOP ) ;  // enable if we are processign an external dma request
                                        
        assign clear_strm0_read_enable  =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_COMPLETE        );
        assign set_strm0_read_enable    =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ ) & (streams_from_memory >= 'd1) & ( strm0_read_peId == peId) |  // only enable if local read
                                           (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0_ENABLE_DMA_READ ) ;  // enable if we are processign an external dma request

                                        
        assign clear_strm1_read_enable  =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_COMPLETE        );
        assign set_strm1_read_enable    =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ ) & (streams_from_memory == 'd2) & ( strm1_read_peId == peId) |  // only enable if local read
                                           (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1_ENABLE_DMA_READ ) ;  // enable if we are processign an external dma request
                                        
        assign clear_strm0_write_enable =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_COMPLETE         );
        assign set_strm0_write_enable   =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE ) & (streams_to_memory >= 'd1) ;
                                                                                                                                           
        assign clear_strm1_write_enable =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_COMPLETE         );
        assign set_strm1_write_enable   =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE ) & (streams_to_memory == 'd2) ;
        
        assign set_strm0_assignedToExternalDma    =  (so_cntl_strm_state_next == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0) ;
        assign clear_strm0_assignedToExternalDma  =  strm_transferToNoc_complete                                                ; // clear once we know the entire packet has been sent to NoC

        assign set_strm1_assignedToExternalDma    =  (so_cntl_strm_state_next == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1) ;
        assign clear_strm1_assignedToExternalDma  =  strm_transferToNoc_complete                                                ; 

        assign strm_transferToNoc_complete = from_stOp_fifo[gvi].fifo_read_data_valid & ((from_stOp_fifo[gvi].fifo_read_cntl == `STREAMING_OP_CNTL_STRM_CNTL_EOP) | (from_stOp_fifo[gvi].fifo_read_cntl == `STREAMING_OP_CNTL_STRM_CNTL_SOP_EOP)) ;  // only one stream is assigned to DMA at a time, so dont need a signal for both streams

        // Calculate number of "words" requested for external dma request
        // FIXME: maybe do this once and send value to dma_cont
        reg  [`PE_MAX_NUM_OF_TYPES_RANGE ]  strm0_word_count          ;
        reg  [`PE_MAX_NUM_OF_TYPES_RANGE ]  strm1_word_count          ;

        always @(*)
          casex (strm0_type)
            `PE_DATA_TYPE_BIT       : strm0_word_count  = (strm0_num_of_types >> `PE_BIT_ADDRESS_SHIFT    ) ;
            `PE_DATA_TYPE_NIBBLE    : strm0_word_count  = (strm0_num_of_types >> `PE_NIBBLE_ADDRESS_SHIFT ) ;
            `PE_DATA_TYPE_BYTE      : strm0_word_count  = (strm0_num_of_types >> `PE_BYTE_ADDRESS_SHIFT   ) ;
            `PE_DATA_TYPE_SWORD     : strm0_word_count  = (strm0_num_of_types >> `PE_SWORD_ADDRESS_SHIFT  ) ;
            `PE_DATA_TYPE_WORD      : strm0_word_count  = (strm0_num_of_types >> `PE_WORD_ADDRESS_SHIFT   ) ;
            default                 : strm0_word_count  = (strm0_num_of_types >> `PE_WORD_ADDRESS_SHIFT   ) ;
          endcase // always @
   
        always @(*)
          casex (strm1_type)
            `PE_DATA_TYPE_BIT       : strm1_word_count  = (strm1_num_of_types >> `PE_BIT_ADDRESS_SHIFT    ) ;
            `PE_DATA_TYPE_NIBBLE    : strm1_word_count  = (strm1_num_of_types >> `PE_NIBBLE_ADDRESS_SHIFT ) ;
            `PE_DATA_TYPE_BYTE      : strm1_word_count  = (strm1_num_of_types >> `PE_BYTE_ADDRESS_SHIFT   ) ;
            `PE_DATA_TYPE_SWORD     : strm1_word_count  = (strm1_num_of_types >> `PE_SWORD_ADDRESS_SHIFT  ) ;
            `PE_DATA_TYPE_WORD      : strm1_word_count  = (strm1_num_of_types >> `PE_WORD_ADDRESS_SHIFT   ) ;
            default                 : strm1_word_count  = (strm1_num_of_types >> `PE_WORD_ADDRESS_SHIFT   ) ;
          endcase // always @
   

        always @(posedge clk)
          begin
            // initially set the sc from the operation unless the address isnt local, in which case we see a NoC DMA request is occuring so
            // set source to NoC
            strm0_stOp_src  <= ( reset_poweron                                                   ) ? 'b00                                                : 
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE  ) ?  operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_SRC_RANGE  ] :
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_STRM0_REQ_NOC_DMA ) ? `STREAMING_OP_CNTL_OPERATION_FROM_NOC               :
                                                                                                      strm0_stOp_src                                     ;

            strm1_stOp_src  <= ( reset_poweron                                                   ) ? 'b00                                                : 
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE  ) ?  operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ] :
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_STRM1_REQ_NOC_DMA ) ? `STREAMING_OP_CNTL_OPERATION_FROM_NOC               :
                                                                                                      strm1_stOp_src                                     ;

   
            strm0_stOp_dest <= ( reset_poweron                                                       ) ? 'b00                                                : 
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE      ) ?  operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ] :
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0 ) ? `STREAMING_OP_CNTL_OPERATION_TO_NOC                 :
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1 ) ? 'b00                                                :
                                                                                                          strm0_stOp_dest                                    ;
   
            strm1_stOp_dest <= ( reset_poweron                                                       ) ? 'b00                                                : 
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE      ) ?  operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ] :
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1 ) ? `STREAMING_OP_CNTL_OPERATION_TO_NOC                 :
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0 ) ? 'b00                                                :
                                                                                                          strm1_stOp_dest                                    ;
   
   
            strm0_read_enable  <= ( reset_poweron           ) ? 'b0                : 
                                  ( set_strm0_read_enable   ) ? 'b1                :
                                  ( clear_strm0_read_enable ) ? 'b0                :
                                                                 strm0_read_enable ;
            strm1_read_enable  <= ( reset_poweron           ) ? 'b0                : 
                                  ( set_strm1_read_enable   ) ? 'b1                :
                                  ( clear_strm1_read_enable ) ? 'b0                :
                                                                 strm1_read_enable ;
   
            strm0_write_enable <= ( reset_poweron            ) ? 'b0                 : 
                                  ( set_strm0_write_enable   ) ? 'b1                 :
                                  ( clear_strm0_write_enable ) ? 'b0                 :
                                                                  strm0_write_enable ;
            strm1_write_enable <= ( reset_poweron            ) ? 'b0                 : 
                                  ( set_strm1_write_enable   ) ? 'b1                 :
                                  ( clear_strm1_write_enable ) ? 'b0                 :
                                                                  strm1_write_enable ;
   
            strm0_stOp_enable  <= ( reset_poweron           ) ? 'b0                : 
                                  ( set_strm0_stOp_enable   ) ? 'b1                :
                                  ( clear_strm0_stOp_enable ) ? 'b0                :
                                                                 strm0_stOp_enable ;
            strm1_stOp_enable  <= ( reset_poweron           ) ? 'b0                : 
                                  ( set_strm1_stOp_enable   ) ? 'b1                :
                                  ( clear_strm1_stOp_enable ) ? 'b0                :
                                                                 strm1_stOp_enable ;
   
            NocLocalDmaRequest      <= ( reset_poweron         ) ? 'b0            : 
                                                              (( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_STRM0_REQ_NOC_DMA ) |
                                                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_STRM1_REQ_NOC_DMA )) ;
   
            NocLocalDmaRequestStrm  <= ( reset_poweron         ) ? 'b0            : 
                                                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_STRM1_REQ_NOC_DMA ) ;  // indicate whether strm0 or 1 is requesting a DMA
   
            externalDmaReqStrmAck   <= ( reset_poweron         ) ? 'b0            : 
                                                                  (( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0 ) | 
                                                                   ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1 )) ;
   
            externalDmaReqStrm      <= ( reset_poweron                                                       ) ? 'b0                 : 
                                       ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0 ) ? 'b0                 : // indicate whether strm0 or 1 is assigned to the external dma request
                                       ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1 ) ? 'b1                 :
                                                                                                                  externalDmaReqStrm ;  
   
            // If this stream is being used by an external DMA request, latch the requestors values
            strm0_ExternalDmaPeId                 <= (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0  ) ? NocControlExternalDmaPeId                :
                                                                                                                               strm0_ExternalDmaPeId                    ;
            strm0_ExternalDmaLaneId               <= (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0  ) ? NocControlExternalDmaLaneId              :
                                                                                                                               strm0_ExternalDmaLaneId                  ;
            strm0_ExternalDmaStrmId               <= (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0  ) ? NocControlExternalDmaStrmId              :
                                                                                                                               strm0_ExternalDmaStrmId                  ;
            strm0_ExternalDma_read_start_address  <= (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM0  ) ? NocControlExternalDma_read_start_address :
                                                                                                                               strm0_ExternalDma_read_start_address     ;
            strm1_ExternalDmaPeId                 <= (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1  ) ? NocControlExternalDmaPeId                :
                                                                                                                               strm1_ExternalDmaPeId                    ;
            strm1_ExternalDmaLaneId               <= (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1  ) ? NocControlExternalDmaLaneId              :
                                                                                                                               strm1_ExternalDmaLaneId                  ;
            strm1_ExternalDmaStrmId               <= (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1  ) ? NocControlExternalDmaStrmId              :
                                                                                                                               strm1_ExternalDmaStrmId                  ;
            strm1_ExternalDma_read_start_address  <= (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_PROCESS_EXT_REQ_STRM1  ) ? NocControlExternalDma_read_start_address :
                                                                                                                               strm1_ExternalDma_read_start_address     ;

            strm0_assignedToExternalDma  <= ( reset_poweron                     ) ? 'b0                          : 
                                            ( set_strm0_assignedToExternalDma   ) ? 'b1                          :
                                            ( clear_strm0_assignedToExternalDma ) ? 'b0                          :
                                                                                     strm0_assignedToExternalDma ;

            strm1_assignedToExternalDma  <= ( reset_poweron                     ) ? 'b0                          : 
                                            ( set_strm1_assignedToExternalDma   ) ? 'b1                          :
                                            ( clear_strm1_assignedToExternalDma ) ? 'b0                          :
                                                                                     strm1_assignedToExternalDma ;


            strm_complete  <= ( reset_poweron         ) ? 1'b0          : 
                              ( clear_strm_complete   ) ? 1'b0          :
                              ( set_strm_complete     ) ? 1'b1          :
                                                          strm_complete ;
          end
   
      end
  endgenerate  // end of stream control fsm(s)


  // assign control to dma and stOp from loaded registers
  `include "streamingOps_cntl_control_assignments.vh"


  //-------------------------------------------------------------------------------------------------
  // NoC Interface(s)
  // 
  // to NoC Control
  // - determine if a DMA request includes another PE
  // - if it includes an non-local address, set up local DMA write engine and send request
  //
  // from NoC Data
  // - direct DMA responses from NoC to appropriate lane/strm DMA engine FIFO (to_stOp_fifo[n]) based on laneId/strmId in response
  //  
  //  from NoC Control
  //  - take DMA requests from NoC and allocate the highest currently available stream
  //  - create a mapping of local lane/strm to PE/Lane/Stream
  //
  //  to NoC Data
  //  - take data packets from streaming Op FIFO (from_stOp_fifo[n])
  //  - look in mapping table {lane,strm} -> {PE,lane,strm}
  //  - send data packet to NoC

  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  // to NoC Control FSM
  
  reg [`STREAMING_OP_CNTL_TONOC_CONT_STATE_RANGE] so_toNoc_cntl_state;          // state flop
  reg [`STREAMING_OP_CNTL_TONOC_CONT_STATE_RANGE] so_toNoc_cntl_state_next;
  
  // State register 
  always @(posedge clk)
    begin
      so_toNoc_cntl_state <= (reset_poweron ) ? `STREAMING_OP_CNTL_TONOC_CONT_WAIT :
                                                 so_toNoc_cntl_state_next          ;
    end

  always @(*)
    begin
      case (so_toNoc_cntl_state)
        `STREAMING_OP_CNTL_TONOC_CONT_WAIT: 
          so_toNoc_cntl_state_next = ( localDmaRequest )  ? `STREAMING_OP_CNTL_TONOC_CONT_REQ     :
                                                       `STREAMING_OP_CNTL_TONOC_CONT_WAIT        ;

        `STREAMING_OP_CNTL_TONOC_CONT_REQ:
          so_toNoc_cntl_state_next = ( ~noc__scntl__cp_ready ) ? `STREAMING_OP_CNTL_TONOC_CONT_REQ            :  // to NoC is a FIFO interface, so will only not be ready if almost full
                                                                `STREAMING_OP_CNTL_TONOC_CONT_SEND_1ST_CYCLE ;

        `STREAMING_OP_CNTL_TONOC_CONT_SEND_1ST_CYCLE:
          so_toNoc_cntl_state_next = ( ~noc__scntl__cp_ready ) ? `STREAMING_OP_CNTL_TONOC_CONT_SEND_1ST_CYCLE :  // to NoC is a FIFO interface, so will only not be ready if almost full
                                                                `STREAMING_OP_CNTL_TONOC_CONT_SEND_2ND_CYCLE ;

        `STREAMING_OP_CNTL_TONOC_CONT_SEND_2ND_CYCLE:
          so_toNoc_cntl_state_next = ( ~noc__scntl__cp_ready ) ? `STREAMING_OP_CNTL_TONOC_CONT_SEND_2ND_CYCLE :  // wait for request to deassert
                                                                `STREAMING_OP_CNTL_TONOC_CONT_COMPLETE       ;

        `STREAMING_OP_CNTL_TONOC_CONT_COMPLETE:
          so_toNoc_cntl_state_next = ( ~localDmaRequest     ) ? `STREAMING_OP_CNTL_TONOC_CONT_WAIT     :  // wait for request to deassert
                                                                `STREAMING_OP_CNTL_TONOC_CONT_COMPLETE ;

        default:
          so_toNoc_cntl_state_next = `STREAMING_OP_CNTL_TONOC_CONT_WAIT;
    
      endcase // case(so_cntl_state)
    end // always @ (*)

    //------------------------------------
    // to NoC Control signalling
    //
    always @(posedge clk)
      begin
        scntl__noc__cp_cntl       <= ( reset_poweron     ) ? 'd0 : scntl__noc__cp_cntl_p1    ;
        scntl__noc__cp_type       <= ( reset_poweron     ) ? 'd0 : scntl__noc__cp_type_p1    ;
        scntl__noc__cp_data       <= ( reset_poweron     ) ? 'd0 : scntl__noc__cp_data_p1    ;
        scntl__noc__cp_laneId     <= ( reset_poweron     ) ? 'd0 : scntl__noc__cp_laneId_p1  ;
        scntl__noc__cp_strmId     <= ( reset_poweron     ) ? 'd0 : scntl__noc__cp_strmId_p1  ;
      end
   
    // 

    //------------------------------------
    // Internal signals
    always @(posedge clk)
      begin
   
        NocControlLocalAck          <= ( reset_poweron     ) ? 1'b0                                                                 : 
                                                         (so_toNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_CONT_SEND_2ND_CYCLE) ;

        NocControlLocalRequestWait  <= ( reset_poweron     ) ? 1'b1                                                            : 
                                                         ~(so_toNoc_cntl_state_next == `STREAMING_OP_CNTL_TONOC_CONT_WAIT) ;

//        scntl__noc__cp_valid    <= (so_toNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_CONT_REQ           ) & (so_toNoc_cntl_state_next == `STREAMING_OP_CNTL_TONOC_CONT_SEND_1ST_CYCLE) | 
//                                  (so_toNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_CONT_SEND_1ST_CYCLE) & (so_toNoc_cntl_state_next == `STREAMING_OP_CNTL_TONOC_CONT_SEND_2ND_CYCLE) ; 
        scntl__noc__cp_valid    <= (noc__scntl__cp_ready & (so_toNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_CONT_SEND_1ST_CYCLE)) |
                                  (noc__scntl__cp_ready & (so_toNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_CONT_SEND_2ND_CYCLE)) ;

      end

    assign cntl_to_noc_1st_cycle = (so_toNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_CONT_SEND_1ST_CYCLE);


  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  // from NoC Control FSM
  
  // State register 
  always @(posedge clk)
    begin
      so_fromNoc_cntl_state <= (reset_poweron ) ? `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT :
                                                   so_fromNoc_cntl_state_next          ;
    end

  always @(*)
    begin
      case (so_fromNoc_cntl_state)
        `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT: 
          so_fromNoc_cntl_state_next = ( ~from_NoC_control_fifo[0].fifo_empty && (from_NoC_control_fifo[0].fifo_read_type == `STREAMING_OP_CNTL_TYPE_DMA_REQUEST ))  ? `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1 :
                                                                                                                                                             `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT                ;

        `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1:
          so_fromNoc_cntl_state_next = ( ~from_NoC_control_fifo[0].fifo_empty && (from_NoC_control_fifo[0].fifo_read_cntl != `STREAMING_OP_CNTL_STRM_CNTL_EOP)) ? `STREAMING_OP_CNTL_FROMNOC_CONT_ERROR               :
                                       ( ~from_NoC_control_fifo[0].fifo_empty                                                                       ) ? `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE2 :  
                                                                                                                                                        `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1 ;

         // The DMA info has been loaded to local registers, now request
         // a stream
        `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE2:
          so_fromNoc_cntl_state_next =  ( localStrmAvailable ) ? `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ             :
                                                                 `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE2 ;  

        `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ:
          so_fromNoc_cntl_state_next =  ( NocControlExternalAck ) ? `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_ACK          :
                                                                    `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ          ;
        `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_ACK:
          so_fromNoc_cntl_state_next =  ( ~NocControlExternalAck ) ? `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT            :
                                                                     `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_ACK         ;

        `STREAMING_OP_CNTL_FROMNOC_CONT_ERROR:
          so_fromNoc_cntl_state_next = `STREAMING_OP_CNTL_FROMNOC_CONT_ERROR ;

        default:
          so_fromNoc_cntl_state_next = `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT;
    
      endcase // case(so_cntl_state)
    end // always @ (*)

    //-------------------------------------------------------------------------------------------------
    // Internal signals

  always @(posedge clk)
    begin
 
      // Indicate that the request info is available so we can now select an available stream
      NocControlExternalRequestWait  <= ( reset_poweron     ) ? 1'b1                                                            : 
                                                               ~(so_fromNoc_cntl_state_next == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE2) ;

      NocControlExternalReq          <= (localStrmAvailable & (so_fromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE2)) |
                                                              (so_fromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ             )  ;


      NocControlExternalDmaPeId                <= ((so_fromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT) & (so_fromNoc_cntl_state_next == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1)) ? from_NoC_control_fifo[0].fifo_read_peId                                                       : NocControlExternalDmaPeId                ;
      NocControlExternalDmaLaneId              <= ((so_fromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT) & (so_fromNoc_cntl_state_next == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1)) ? from_NoC_control_fifo[0].fifo_read_laneId                                                     : NocControlExternalDmaLaneId              ;
      NocControlExternalDmaStrmId              <= ((so_fromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT) & (so_fromNoc_cntl_state_next == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1)) ? from_NoC_control_fifo[0].fifo_read_strmId                                                     : NocControlExternalDmaStrmId              ;
      NocControlExternalDma_read_start_address <= ((so_fromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT) & (so_fromNoc_cntl_state_next == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1)) ? from_NoC_control_fifo[0].fifo_read_data[`NOC_CONT_INTERNAL_DMA_REQ_1ST_CYCLE_ADDRESS_RANGE]   : NocControlExternalDma_read_start_address ;

    end

   
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  // to NoC Data FSM
  //
  // The data available in each "from stOp" fifo is based on 
  // i) sufficient data to fill a full-size DMA data packet
  // ii) an EOP is in the FIFO. Note: Need to accomodate multiple EOP's as the
  // dma stream may be used for further external dma requests.
  //
  // FIXME: Do we need to fairly read. Right now, if a higher order lane has
  // enuff for a pakt or an eop, it sends.
  // e.g. at the end of a pkt, higher order lanes will send a full-size then
  // the balance of a packet if there is an eop
  
  reg [`STREAMING_OP_CNTL_STRM_CNTL_RANGE                  ] toNoc_dp_fifo_cntl                ; 
  reg                                                        toNoc_dp_fifo_dma_pkt_available   ;
  wire                                                       toNoc_dp_fifo_read                ;
  reg                                                        toNoc_dp_fifo_data_valid          ;
  reg [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_RANGE           ] toNoc_dp_fifo_depth               ;
  reg [`STREAMING_OP_CNTL_STOP_TO_NOC_FIFO_EOP_COUNT_RANGE ] toNoc_dp_fifo_eop_count           ;
  reg                                                        toNoc_dp_first_packet             ;  // the NoC delineates packets using SOP and EOP, the Input queues needs to know the start and end packet to set the internal SOD and EOD
  wire                                                       toNoc_dp_first_packet_p1          ; 
  reg                                                        toNoc_dp_last_packet              ;  // if the fifo has less than a full dma packets worth of data then it will be the last packet
                                                                                                  // so set the packet type to DMA_DATA_EOD
  wire                                                       toNoc_dp_first_transaction_in_pkt ;
  wire                                                       toNoc_dp_last_transaction_in_pkt  ;
                                                                                    
  wire [`STREAMING_OP_CNTL_TYPE_RANGE             ] toNoc_dp_type                   ;

  reg [`STREAMING_OP_CNTL_NOC_DATA_TRANSACTION_COUNT_RANGE]  toNocDataTransactionCount    ;
  wire                                                       incToNocDataTransactionCount ;
  wire                                                       clrToNocDataTransactionCount ;

  //-------------------------------------------------------------------------------------------------
  // State register 
  //
  reg [`STREAMING_OP_CNTL_TONOC_DATA_STATE_RANGE] so_DataToNoc_cntl_state;          // state flop
  reg [`STREAMING_OP_CNTL_TONOC_DATA_STATE_RANGE] so_DataToNoc_cntl_state_next;
  
  always @(posedge clk)
    begin
      so_DataToNoc_cntl_state <= (reset_poweron ) ? `STREAMING_OP_CNTL_TONOC_DATA_WAIT :
                                                    so_DataToNoc_cntl_state_next       ;
    end

  always @(*)
    begin
      case (so_DataToNoc_cntl_state)
        `STREAMING_OP_CNTL_TONOC_DATA_WAIT: 
          so_DataToNoc_cntl_state_next = ( toNocDmaPacketAvailable && noc__scntl__dp_ready )  ? `STREAMING_OP_CNTL_TONOC_DATA_ENABLE_READ :
                                                                                               `STREAMING_OP_CNTL_TONOC_DATA_WAIT        ;
        // Data now stable at output of FIFO, check type
        `STREAMING_OP_CNTL_TONOC_DATA_ENABLE_READ: 
          so_DataToNoc_cntl_state_next = ( ~noc__scntl__dp_ready )  ? `STREAMING_OP_CNTL_TONOC_DATA_ENABLE_READ :
                                                                     `STREAMING_OP_CNTL_TONOC_DATA_TX_PKT      ;  // FIXME : are all transfers DMA?

        `STREAMING_OP_CNTL_TONOC_DATA_TX_PKT:
          so_DataToNoc_cntl_state_next = ( ~noc__scntl__dp_ready ) ? `STREAMING_OP_CNTL_TONOC_DATA_TX_PKT         :  // to NoC is a FIFO interface, so will only not be ready if almost full
                                         (( toNocDataTransactionCount == (`NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT) ) || 
                                          ((toNoc_dp_fifo_cntl == `DMA_CONT_STRM_CNTL_EOP) || (toNoc_dp_fifo_cntl == `DMA_CONT_STRM_CNTL_SOP_EOP))) ? `STREAMING_OP_CNTL_TONOC_DATA_COMPLETE          :  // wait until we have tramsmitted a full-size packet or EOP
                                                                    `STREAMING_OP_CNTL_TONOC_DATA_SEND_1ST_CYCLE ;

        `STREAMING_OP_CNTL_TONOC_DATA_SEND_1ST_CYCLE:
          so_DataToNoc_cntl_state_next = ( ~noc__scntl__dp_ready ) ? `STREAMING_OP_CNTL_TONOC_DATA_SEND_1ST_CYCLE    :  // to NoC is a FIFO interface, so will only not be ready if almost full
                                         (( toNocDataTransactionCount == (`NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT) ) || 
                                          ((toNoc_dp_fifo_cntl == `DMA_CONT_STRM_CNTL_EOP) || (toNoc_dp_fifo_cntl == `DMA_CONT_STRM_CNTL_SOP_EOP))) ? `STREAMING_OP_CNTL_TONOC_DATA_COMPLETE          :  // wait until we have tramsmitted a full-size packet or EOP
                                                                    `STREAMING_OP_CNTL_TONOC_DATA_SEND_OTHER_CYCLES ;

        `STREAMING_OP_CNTL_TONOC_DATA_SEND_OTHER_CYCLES:
          so_DataToNoc_cntl_state_next = (( toNocDataTransactionCount == (`NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT) ) ||                                                                                     // always transfer last transaction even if the noc isnt ready
                                          ((toNoc_dp_fifo_cntl == `DMA_CONT_STRM_CNTL_EOP) || (toNoc_dp_fifo_cntl == `DMA_CONT_STRM_CNTL_SOP_EOP))) ? `STREAMING_OP_CNTL_TONOC_DATA_COMPLETE          :  // wait until we have tramsmitted a full-size packet or EOP
                                         ( ~noc__scntl__dp_ready                                                                                   ) ? `STREAMING_OP_CNTL_TONOC_DATA_SEND_OTHER_CYCLES :  // to NoC is a FIFO interface, so will only not be ready if almost full
                                                                                                                                                      `STREAMING_OP_CNTL_TONOC_DATA_SEND_OTHER_CYCLES ;

        `STREAMING_OP_CNTL_TONOC_DATA_COMPLETE:
          so_DataToNoc_cntl_state_next =  `STREAMING_OP_CNTL_TONOC_DATA_WAIT   ;

        default:
          so_DataToNoc_cntl_state_next = `STREAMING_OP_CNTL_TONOC_DATA_WAIT;
    
      endcase // case(so_cntl_state)
    end // always @ (*)


    //-------------------------------------------------------------------------------------------------
    // Internal signals

    always @(posedge clk)
      begin
   
        FromStOpControlRequestWait <= ( reset_poweron     ) ? 1'b1                                                            : 
                                                         ~(so_DataToNoc_cntl_state_next == `STREAMING_OP_CNTL_TONOC_DATA_WAIT) ;

        toNocDataTransactionCount <= ( reset_poweron                  ) ? 'd0                             : 
                                       ( clrToNocDataTransactionCount ) ? 'd0                             : 
                                       ( incToNocDataTransactionCount ) ? toNocDataTransactionCount + 'd1 : 
                                                                          toNocDataTransactionCount       ;

        scntl__noc__dp_valid           <= toNoc_dp_fifo_data_valid   ;

        // if we are starting a new dma packet, we have an EOP in the fifo and there are less than a dma data packets worth of data, 
        // this will be the last packet in the dma transfer
        toNoc_dp_last_packet  <= ( reset_poweron                                                             ) ? 1'b0                 :
                                 ( so_DataToNoc_cntl_state_next == `STREAMING_OP_CNTL_TONOC_DATA_ENABLE_READ ) ? 1'b0                 :  // clear before determining if its the last packet in a stream
                                 ((so_DataToNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_DATA_ENABLE_READ) && 
                                  (toNoc_dp_fifo_depth     <= `NOC_CONT_INTERNAL_DMA_WORDS_PER_PKT          ) &&
                                  (toNoc_dp_fifo_eop_count >  0                                             )) ? 1'b1                 :
                                                                                                                 toNoc_dp_last_packet ; 

        toNoc_dp_first_packet  <= ( reset_poweron                                                                                ) ? 1'b0                  :
                                  ( so_DataToNoc_cntl_state_next == `STREAMING_OP_CNTL_TONOC_DATA_ENABLE_READ                    ) ? 1'b0                  :  // clear before determining if its the first packet in a stream
                                  ((so_DataToNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_DATA_TX_PKT) && toNoc_dp_first_packet_p1 ) ? 1'b1                  :
                                                                                                                                     toNoc_dp_first_packet ; 
  
      end

    assign clrToNocDataTransactionCount   =  (so_DataToNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_DATA_WAIT) ;

    assign incToNocDataTransactionCount   = toNoc_dp_fifo_read ;

    assign toNoc_dp_fifo_read   = (so_DataToNoc_cntl_state_next != `STREAMING_OP_CNTL_TONOC_DATA_COMPLETE                            ) &   // if we are going to the complete state, we have a packets worth of data
                                  (((noc__scntl__dp_ready) & (so_DataToNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_DATA_ENABLE_READ      )) | 
                                   ((noc__scntl__dp_ready) & (so_DataToNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_DATA_TX_PKT           )) | 
                                   ((noc__scntl__dp_ready) & (so_DataToNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_DATA_SEND_1ST_CYCLE   )) | 
                                   ((noc__scntl__dp_ready) & (so_DataToNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_DATA_SEND_OTHER_CYCLES))) ; 

    // For first packet in a dma transfer, set type to DMA_DATA_SOD, for the last packet, set type to DMA_DATA_EOD
    assign toNoc_dp_type        = (toNoc_dp_last_packet                             ) ?  `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD : 
                                  (toNoc_dp_first_packet || toNoc_dp_first_packet_p1) ?  `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD :
                                                                                         `STREAMING_OP_CNTL_TYPE_DMA_DATA     ;

    assign toNoc_dp_first_packet_p1  = ( reset_poweron     ) ? 1'b0                                                                : 
                                                               ((so_DataToNoc_cntl_state == `STREAMING_OP_CNTL_TONOC_DATA_TX_PKT) & 
                                                                (toNoc_dp_fifo_cntl == `DMA_CONT_STRM_CNTL_SOP                  )) ;

    assign toNoc_dp_first_transaction_in_pkt = (so_DataToNoc_cntl_state      == `STREAMING_OP_CNTL_TONOC_DATA_TX_PKT  );
    assign toNoc_dp_last_transaction_in_pkt  = (so_DataToNoc_cntl_state_next == `STREAMING_OP_CNTL_TONOC_DATA_COMPLETE);



  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------
  // from NoC Data FSM
  //
  // Extract data from the "from NoC data" FIFO and direct toward the appropriate "to_stOp" FIFO.
  // FIXME: Currently support "DMA DATA" types.
  
  reg  [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]               fromNocDataSelectedLane ;
  reg                                                           fromNocDataSelectedStrm ;
  reg                                                           toStOpReady             ;  // ready from selected lane

  wire                                                          fromNocDataAvailable  ;
  wire                                                          fromNocDataFifoRead   ;
  wire                                                          fromNocDataFifoReadValid   ;
  wire                                                          toStOpFifoWrite       ;
  wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE      ]               fromNocDataPktCntl    ;
  wire [`STREAMING_OP_CNTL_TYPE_RANGE           ]               fromNocDataPktType_p1 ;
  reg  [`STREAMING_OP_CNTL_TYPE_RANGE           ]               fromNocDataPktType    ;  // save packet type so we can add EOD on last transaction
  wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ]               fromNocDataPktLaneId  ;
  wire                                                          fromNocDataPktStrmId  ;
  wire [`NOC_CONT_INTERNAL_DATA_RANGE           ]               fromNocDataPktData    ;


  //-------------------------------------------------------------------------------------------------
  // State register 
  //
  reg [`STREAMING_OP_CNTL_FROMNOC_DATA_STATE_RANGE] so_DataFromNoc_cntl_state;          // state flop
  reg [`STREAMING_OP_CNTL_FROMNOC_DATA_STATE_RANGE] so_DataFromNoc_cntl_state_next;
  
  always @(posedge clk)
    begin
      so_DataFromNoc_cntl_state <= (reset_poweron ) ? `STREAMING_OP_CNTL_FROMNOC_DATA_WAIT :
                                                    so_DataFromNoc_cntl_state_next       ;
    end

  always @(*)
    begin
      case (so_DataFromNoc_cntl_state)

        `STREAMING_OP_CNTL_FROMNOC_DATA_WAIT: 
          so_DataFromNoc_cntl_state_next = (  fromNocDataAvailable && toStOpReady          )      ? `STREAMING_OP_CNTL_FROMNOC_DATA_ENABLE_READ :
                                                                                                    `STREAMING_OP_CNTL_FROMNOC_DATA_WAIT       ;

        // Data now stable at output of FIFO, check type
        `STREAMING_OP_CNTL_FROMNOC_DATA_ENABLE_READ: 
          so_DataFromNoc_cntl_state_next =   (fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA    )  ? `STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT :
                                             (fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_SOD)  ? `STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT :
                                             (fromNocDataPktType_p1 == `STREAMING_OP_CNTL_TYPE_DMA_DATA_EOD)  ? `STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT :
                                                                                                                `STREAMING_OP_CNTL_FROMNOC_DATA_COMPLETE   ;  // FIXME : other types?

        `STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT:
          so_DataFromNoc_cntl_state_next = ( ~fromNocDataAvailable ) ? `STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT :    // FIXME: error condition, once data has started to arrive there is no reason for it not to complete 
                                           (((fromNocDataPktCntl == `DMA_CONT_STRM_CNTL_EOP) || (fromNocDataPktCntl == `DMA_CONT_STRM_CNTL_SOP_EOP)) &&
                                             fromNocDataFifoReadValid)                                                                                   ? `STREAMING_OP_CNTL_FROMNOC_DATA_COMPLETE          :  // wait until we have tramsmitted a full-size packet or EOP
                                                                       `STREAMING_OP_CNTL_FROMNOC_DATA_READ       ;

        `STREAMING_OP_CNTL_FROMNOC_DATA_READ:
          so_DataFromNoc_cntl_state_next = ( ~fromNocDataAvailable                                                                                 )     ? `STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT     : 
                                           (((fromNocDataPktCntl == `DMA_CONT_STRM_CNTL_EOP) || (fromNocDataPktCntl == `DMA_CONT_STRM_CNTL_SOP_EOP)) &&
                                             fromNocDataFifoReadValid)                                                                                   ? `STREAMING_OP_CNTL_FROMNOC_DATA_COMPLETE          :  // wait until we have tramsmitted a full-size packet or EOP
                                                                                                                                                           `STREAMING_OP_CNTL_FROMNOC_DATA_READ ;

        `STREAMING_OP_CNTL_FROMNOC_DATA_COMPLETE:
          so_DataFromNoc_cntl_state_next =  `STREAMING_OP_CNTL_FROMNOC_DATA_WAIT   ;

        default:
          so_DataFromNoc_cntl_state_next = `STREAMING_OP_CNTL_FROMNOC_DATA_WAIT;
    
      endcase // case(so_cntl_state)
    end // always @ (*)

    assign fromNocDataFifoReadValid = fromNocDataFifoRead;  // FIXME for real memory

    //-------------------------------------------------------------------------------------------------
    // Internal signals

    always @(posedge clk)
      begin
   
/*  FIXME for real memory
        fromNocDataFifoReadValid    <= ( reset_poweron                  ) ? 'd0                  : // data appears after clock 
                                                                            fromNocDataFifoRead  ;

        fromNocDataSelectedLane <= ( reset_poweron                                                          )    ? 'd0                      : 
                                   ( so_DataFromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT )   ?  fromNocDataPktLaneId    : 
                                                                                                                    fromNocDataSelectedLane ;
        fromNocDataSelectedStrm <= ( reset_poweron                                                          )    ? 'd0                      : 
                                   ( so_DataFromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT )   ?  fromNocDataPktStrmId    : 
                                                                                                                    fromNocDataSelectedStrm ;
*/

        fromNocDataSelectedLane <= ( reset_poweron                                                                 )    ? 'd0                      : 
                                   (( so_DataFromNoc_cntl_state      == `STREAMING_OP_CNTL_FROMNOC_DATA_WAIT       ) &&
                                    ( so_DataFromNoc_cntl_state_next == `STREAMING_OP_CNTL_FROMNOC_DATA_ENABLE_READ ))   ?  fromNocDataPktLaneId    : 
                                                                                                                           fromNocDataSelectedLane ;

        fromNocDataSelectedStrm <= ( reset_poweron                                                                 )    ? 'd0                      : 
                                   (( so_DataFromNoc_cntl_state      == `STREAMING_OP_CNTL_FROMNOC_DATA_WAIT       ) &&
                                    ( so_DataFromNoc_cntl_state_next == `STREAMING_OP_CNTL_FROMNOC_DATA_ENABLE_READ ))   ?  fromNocDataPktStrmId    : 
                                                                                                                           fromNocDataSelectedStrm ;

      end

    assign fromNocDataFifoRead  = //(fromNocDataAvailable & toStOpReady & (so_DataFromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_DATA_WAIT        )) |  // FIXME for real memory
                                  (fromNocDataAvailable & toStOpReady & (so_DataFromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_DATA_RX_DMA_PKT  )) | 
                                  (fromNocDataAvailable & toStOpReady & (so_DataFromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_DATA_READ        )) ; 

    //assign toStOpFifoWrite      = fromNocDataFifoReadValid  ;  // out of "from NoC" fifo into "to stOp" fifo - FIXME for real memory
    assign toStOpFifoWrite      = fromNocDataFifoRead  ;  // out of "from NoC" fifo into "to stOp" fifo


  //------------------------------------------------------------------------------------------------
  //
  // FIFO's to/from Streaming Op
  //
  // FIFO to stOp has enough space to contain a DMA packet to ensure we dont
  // block NoC interface
  // To stOp FIFO's
  //
  `include "streamingOps_cntl_stOp_noc_to_stOp_fifo_wires.vh"
  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES; gvi=gvi+1) 
      begin: to_stOp_fifo
`ifdef STREAMINGOPS_CNTL_INCLUDE_REAL_MEMORY
        `NoC_to_StOp_FIFO_wRealMemory

        wire                                                   fifo_write_delayed ;
        wire                                                   fifo_read_delayed  ;
        wire [`STREAMING_OP_CNTL_STRM_CNTL_RANGE ]             cntl_delayed       ; 
        wire                                                   strmId_delayed     ;
        wire [`STREAMING_OP_CNTL_DATA_RANGE      ]             data_delayed       ; 
        wire [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_wp_delayed    ; 
        wire [`STREAMING_OP_CNTL_NOC_TO_STOP_FIFO_RANGE]       fifo_rp_delayed    ; 
  `ifndef SYNTHESIS
        assign #0.5 fifo_write_delayed = fifo_write;
        assign #0.5 fifo_read_delayed  = fifo_read ;
        assign #0.5 cntl_delayed       = cntl      ; 
        assign #0.5 strmId_delayed     = strmId    ;
        //assign #0.5 data_delayed       = $shortrealtobits($bitstoshortreal(data) + 1.0)    ;
        assign #0.5 data_delayed       = data      ;
        assign #0.5 fifo_wp_delayed    = fifo_wp   ;
        assign #0.5 fifo_rp_delayed    = fifo_rp   ;
  `else
        assign fifo_write_delayed = fifo_write;
        assign fifo_read_delayed  = fifo_read ;
        assign cntl_delayed       = cntl      ; 
        assign strmId_delayed     = strmId    ;
        assign data_delayed       = data      ;
        assign fifo_wp_delayed    = fifo_wp   ;
        assign fifo_rp_delayed    = fifo_rp   ;
  `endif

        sasslnpky2p32x35cm4sw0bk1ltlc1 mem2p32x35( 
                       // FIFO input 
                       .CLKA        ( clk                  ),
                       .WEA         ( fifo_write_delayed           ),
                       .MEA         ( fifo_write_delayed           ),
                       .ADRA        ( fifo_wp_delayed              ),
                       .DA          ( {cntl_delayed, strmId_delayed, data_delayed} ),
                       .QA          (                      ),
                       // FIFO output
                       .CLKB        ( clk                                                ),
                       .WEB         ( 1'b0                                               ),
                       .MEB         ( 1'b1                                               ),  // FIXME
                       .ADRB        ( fifo_rp_delayed                                            ),
                       .DB          ( 35'd0                                              ),
                       .QB          ( {fifo_read_cntl, fifo_read_strmId, fifo_read_data} ),
                    
                       .TEST1A      ( 1'b0 ),
                       .RMEA        ( 1'b0 ),
                       .RMA         ( 4'd0 ),
                       .TEST1B      ( 1'b0 ),
                       .RMEB        ( 1'b0 ),
                       .RMB         ( 4'd0 ));
      
`else
        `NoC_to_StOp_FIFO
`endif
      end
  endgenerate
  `include "streamingOps_cntl_stOp_noc_to_stOp_fifo_assignments.vh"
  `include "streamingOps_cntl_stOp_noc_from_noc_data_assignments.vh"

  //------------------------------------------
  // FIFO from stOp has enough space to contain a DMA packet to ensure we have
  // enough data to complete a DMA packet before we start sending to the "to" NoC FIFO
  // From stOp FIFO's
  //
  //
  `include "streamingOps_cntl_stOp_noc_from_stOp_fifo_wires.vh"
  generate
    for (gvi=0; gvi<`PE_NUM_OF_EXEC_LANES; gvi=gvi+1) 
      begin: from_stOp_fifo
        `StOp_to_NoC_FIFO
      end
  endgenerate
  `include "streamingOps_cntl_stOp_noc_from_stOp_fifo_assignments.vh"



  //------------------------------------------------------------------------------------------------
  //
  // FIFO's to/from NoC
  //
  //------------------------------------------------------------------------------
  // FIFO from NoC has enough space to contain a DMA packet before it is
  // transferred to the appropriate exec lane stream fifo
  
  //------------------------------------
  // from NoC Control FIFO
  //
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_NoC_control_fifo
        `Control_from_NoC_FIFO
      end
  endgenerate

  assign from_NoC_control_fifo[0].cntl       = noc__scntl__cp_cntl        ;
  assign from_NoC_control_fifo[0].typee      = noc__scntl__cp_type        ;  // type cannot be used in SV
  assign from_NoC_control_fifo[0].data       = noc__scntl__cp_data        ;
  assign from_NoC_control_fifo[0].peId       = noc__scntl__cp_peId        ;
  assign from_NoC_control_fifo[0].laneId     = noc__scntl__cp_laneId      ;
  assign from_NoC_control_fifo[0].strmId     = noc__scntl__cp_strmId      ;
  assign from_NoC_control_fifo[0].fifo_write = noc__scntl__cp_valid       ;
  always @(posedge clk)
    scntl__noc__cp_ready             <= ~from_NoC_control_fifo[0].fifo_almost_full ;

  assign from_NoC_control_fifo[0].clear      = 1'b0;

  assign from_NoC_control_fifo[0].fifo_read  = (so_fromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_CONT_WAIT               ) & (so_fromNoc_cntl_state_next == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1) | 
                                               (so_fromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE1) & (so_fromNoc_cntl_state_next == `STREAMING_OP_CNTL_FROMNOC_CONT_DMA_REQ_READ_CYCLE2) ; 
  //assign from_NoC_control_fifo[0].fifo_read  = ~from_NoC_control_fifo[0].fifo_empty;

  //------------------------------------
  // from NoC Data FIFO
  generate
    for (gvi=0; gvi<1; gvi=gvi+1) 
      begin: from_NoC_data_fifo
        `Data_from_NoC_FIFO
      end
  endgenerate

  assign from_NoC_data_fifo[0].cntl       = noc__scntl__dp_cntl        ;
  assign from_NoC_data_fifo[0].typee      = noc__scntl__dp_type        ;
  assign from_NoC_data_fifo[0].laneId     = noc__scntl__dp_laneId      ;
  assign from_NoC_data_fifo[0].strmId     = noc__scntl__dp_strmId      ;
  assign from_NoC_data_fifo[0].data       = noc__scntl__dp_data        ;
  assign from_NoC_data_fifo[0].fifo_write = noc__scntl__dp_valid       ;
  always @(posedge clk)
    scntl__noc__dp_ready             <= ~from_NoC_data_fifo[0].fifo_almost_full ;

  assign from_NoC_data_fifo[0].clear     = 1'b0                                    ;
  assign from_NoC_data_fifo[0].fifo_read = fromNocDataFifoRead                     ;
  assign fromNocDataAvailable            = ~from_NoC_data_fifo[0].fifo_empty       ;
  assign fromNocDataPktCntl              =  from_NoC_data_fifo[0].fifo_read_cntl   ;
  assign fromNocDataPktType_p1           =  from_NoC_data_fifo[0].fifo_read_type   ;
  always @(posedge clk)
    begin
      fromNocDataPktType       <= (reset_poweron                                                            ) ? 'd0                     : 
                                  (so_DataFromNoc_cntl_state == `STREAMING_OP_CNTL_FROMNOC_DATA_ENABLE_READ ) ? fromNocDataPktType_p1   :
                                                                                                                fromNocDataPktType      ;      
    end
  assign fromNocDataPktLaneId            =  from_NoC_data_fifo[0].fifo_read_laneId ;
  assign fromNocDataPktStrmId            =  from_NoC_data_fifo[0].fifo_read_strmId ;
  assign fromNocDataPktData              =  from_NoC_data_fifo[0].fifo_read_data   ;


endmodule

