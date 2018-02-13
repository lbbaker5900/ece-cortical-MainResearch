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
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"


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
                          //`include "streamingOps_cntl_stOp_noc_ports.vh"

                          //--------------------------------------------------------
                          // external interface
                          ext_enable        ,
                          ext_ready         ,
                          ext_start         ,
                          ext_complete      ,

                          //--------------------------------------------------------
                          // Result interface to simd regFile
                          `include "streamingOps_cntl_to_simd_regfile_ports.vh"

                          //--------------------------------------------------
                          // SIMD to stOp  (via scntl(
                          reg__sdp__valid  ,
                          reg__sdp__cntl   ,
                          reg__sdp__data   ,
                          sdp__reg__ready  ,

                          reg__scntl__valid  ,
                          reg__scntl__cntl   ,
                          reg__scntl__data   ,
                          scntl__reg__ready  ,

                          //--------------------------------------------------------
                          // Result interface from stOp 
                          `include "streamingOps_cntl_stOp_to_cntl_regfile_ports.vh"

                          //--------------------------------------------------------
                          // register interface
                          `include "pe_simd_ports.vh"

                          //--------------------------------------------------------
                          // System
                          peId              ,
                          clk               ,
                          reset_poweron     
    );


  //----------------------------------------------------------------------------------------------------
  // General
  input                       clk            ;
  input                       reset_poweron  ;
  input [`PE_PE_ID_RANGE   ]  peId           ; 


  //----------------------------------------------------------------------------------------------------
  // interface to PE core
  output      ready             ; // ready to start streaming
  output      complete          ;

  input       sys__pe__allSynchronized  ;  // all PE streams are complete
  output      pe__sys__thisSynchronized ;  // this PE's streams are complete


  //----------------------------------------------------------------------------------------------------
  // NoC interface to stOp
  // includes data to and from all execution lane streaming operation modules
  //`include "streamingOps_cntl_stOp_noc_ports_declaration.vh"


  //----------------------------------------------------------------------------------------------------
  // streaming op and dma function control interface
  `include "streamingOps_cntl_control_ports_declaration.vh"
  

  //----------------------------------------------------------------------------------------------------
  // External interface
  output ext_enable        ;
  input  ext_ready         ;
  output ext_start         ;
  input  ext_complete      ;
  

  //----------------------------------------------------------------------------------------------------
  // interface to memory controller
  output       scntl__memc__request          ;
  input        memc__scntl__granted          ;
  output       scntl__memc__released         ;


  //-------------------------------------------------------------------------------------------------
  // Exec lane Register(s)
  //
  `include "pe_simd_port_declarations.vh"

  //--------------------------------------------------
  // SIMD to stOp  (via scntl(
  output    [`PE_NUM_OF_EXEC_LANES_RANGE      ]      reg__sdp__valid                          ;
  output    [`COMMON_STD_INTF_CNTL_RANGE      ]      reg__sdp__cntl  [`PE_NUM_OF_EXEC_LANES ] ;
  output    [`PE_EXEC_LANE_WIDTH_RANGE        ]      reg__sdp__data  [`PE_NUM_OF_EXEC_LANES ] ;
  input     [`PE_NUM_OF_EXEC_LANES_RANGE      ]      sdp__reg__ready                          ;

  //--------------------------------------------------
  // SIMD to stOp (via scntl( 
  input     [`PE_NUM_OF_EXEC_LANES_RANGE      ]      reg__scntl__valid                          ;
  input     [`COMMON_STD_INTF_CNTL_RANGE      ]      reg__scntl__cntl  [`PE_NUM_OF_EXEC_LANES ] ;
  input     [`PE_EXEC_LANE_WIDTH_RANGE        ]      reg__scntl__data  [`PE_NUM_OF_EXEC_LANES ] ;
  output    [`PE_NUM_OF_EXEC_LANES_RANGE      ]      scntl__reg__ready                          ;

  //-------------------------------------------------------------------------------------------------
  // Result to simd regFile
  //
  `include "streamingOps_cntl_to_simd_regfile_ports_declaration.vh"
  
  //-------------------------------------------------------------------------------------------------
  // Result from stOp to simd regFile
  //
  `include "streamingOps_cntl_stOp_to_cntl_regfile_ports_declaration.vh"
  
  //-------------------------------------------------------------------------------------------
  // Wires and Register
  //

  `include "streamingOps_cntl_simd_wires.vh"
  `include "streamingOps_cntl_simd_assignments.vh"  // convert from multidimensional array
  //--------------------------------------------------
  // SIMD to stOp  (via scntl(
  reg    [`PE_NUM_OF_EXEC_LANES_RANGE      ]      reg__sdp__valid                          ;
  reg    [`COMMON_STD_INTF_CNTL_RANGE      ]      reg__sdp__cntl  [`PE_NUM_OF_EXEC_LANES ] ;
  reg    [`PE_EXEC_LANE_WIDTH_RANGE        ]      reg__sdp__data  [`PE_NUM_OF_EXEC_LANES ] ;
  wire   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      sdp__reg__ready                          ;

  //--------------------------------------------------
  // SIMD to stOp (via scntl( 
  wire   [`PE_NUM_OF_EXEC_LANES_RANGE      ]      reg__scntl__valid                          ;
  wire   [`COMMON_STD_INTF_CNTL_RANGE      ]      reg__scntl__cntl  [`PE_NUM_OF_EXEC_LANES ] ;
  wire   [`PE_EXEC_LANE_WIDTH_RANGE        ]      reg__scntl__data  [`PE_NUM_OF_EXEC_LANES ] ;
  reg    [`PE_NUM_OF_EXEC_LANES_RANGE      ]      scntl__reg__ready                          ;


  reg      pe__sys__thisSynchronized    ;  // this PE's streams are complete
  wire     pe__sys__thisSynchronized_e1 ; 

  wire scntl__memc__request  ;
  wire memc__scntl__granted  ;
  wire scntl__memc__released ;
  wire mem_granted          ;
  reg  mem_request          ;
  wire mem_request_next     ;
  reg  mem_released         ;
  wire mem_released_next    ;

  // NoC interface to stOp
  //`include "streamingOps_cntl_noc_wires.vh"

  // SDP interface to stOp
  `include "streamingOps_cntl_stOp_wires.vh"

  // assign control to dma and stOp from loaded registers
  `include "streamingOps_cntl_control_wires.vh"

  // result between stOp and simd regFile
  `include "streamingOps_cntl_to_simd_regfile_wires.vh"
  `include "streamingOps_cntl_stOp_to_cntl_regfile_wires.vh"


  //----------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------
  // Registered Inputs and Outputs

  always @(posedge clk)
    begin
      pe__sys__thisSynchronized    <= pe__sys__thisSynchronized_e1 ;
    end

  //------------------------------------------------------------
  // Operation related fields
  //
  // Enable
  wire enable ;
  assign enable = rs0[0] ; // FIXME

  wire [`PE_NUM_OF_EXEC_LANES_RANGE] exec_lane_active ;
  assign exec_lane_active = rs1[`PE_NUM_OF_EXEC_LANES_RANGE];

  wire [31:0] operation = rs0[31:1];  // FIXME

  // extract source and destination flags from operation fields
  //
  // to/from memory

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

  assign mem_granted = memc__scntl__granted ;


  

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
                so_cntl_strm_state_next = `STREAMING_OP_CNTL_STRM_ENABLE_STOP        ;

              
              // At this point the source of the streams have been configured.
              // We have set source for stOp. If a NoC DMA was requested, the stOp source was set to NoC
              
              `STREAMING_OP_CNTL_STRM_ENABLE_STOP: 
                so_cntl_strm_state_next = ( both_stOp_streams_ready ) ? `STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ  :
                                                                        `STREAMING_OP_CNTL_STRM_ENABLE_STOP    ;
   
              `STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ: 
                so_cntl_strm_state_next =                             `STREAMING_OP_CNTL_STRM_OP_START         ;
   
              `STREAMING_OP_CNTL_STRM_OP_START: 
                so_cntl_strm_state_next = ( both_dma_streams_complete && both_stOp_streams_complete ) ? `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC         :
                                                                                                        `STREAMING_OP_CNTL_STRM_OP_START              ;
              
   
              `STREAMING_OP_CNTL_STRM_WAIT_FOR_SYNC: 
                so_cntl_strm_state_next = ( sys__pe__allSynchronized                                ) ? `STREAMING_OP_CNTL_STRM_COMPLETE              :
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
                                        
        assign clear_strm1_stOp_enable  =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_WAIT        );
        assign set_strm1_stOp_enable    =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_STOP ) & (num_of_src_streams == 'd2) ; // |
                                        
        assign clear_strm0_read_enable  =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_COMPLETE        );
        assign set_strm0_read_enable    =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ ) & (streams_from_memory >= 'd1) & ( strm0_read_peId == peId) ;  // only enable if local read

                                        
        assign clear_strm1_read_enable  =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_COMPLETE        );
        assign set_strm1_read_enable    =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_READ ) & (streams_from_memory == 'd2) & ( strm1_read_peId == peId) ;  // only enable if local read
                                        
        assign clear_strm0_write_enable =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_COMPLETE         );
        assign set_strm0_write_enable   =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE ) & (streams_to_memory >= 'd1) ;
                                                                                                                                           
        assign clear_strm1_write_enable =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_COMPLETE         );
        assign set_strm1_write_enable   =  (so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE ) & (streams_to_memory == 'd2) ;
        


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
                                                                                                      strm0_stOp_src                                     ;

            strm1_stOp_src  <= ( reset_poweron                                                   ) ? 'b00                                                : 
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE  ) ?  operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_SRC_RANGE   ] :
                                                                                                      strm1_stOp_src                                     ;

   
            strm0_stOp_dest <= ( reset_poweron                                                       ) ? 'b00                                                : 
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE      ) ?  operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ZERO_DEST_RANGE ] :
                                                                                                          strm0_stOp_dest                                    ;
   
            strm1_stOp_dest <= ( reset_poweron                                                       ) ? 'b00                                                : 
                               ( so_cntl_strm_state == `STREAMING_OP_CNTL_STRM_ENABLE_DMA_WRITE      ) ?  operation[`STREAMING_OP_CNTL_OPERATION_STREAM_ONE_DEST_RANGE  ] :
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
   
   


            strm_complete  <= ( reset_poweron         ) ? 1'b0          : 
                              ( clear_strm_complete   ) ? 1'b0          :
                              ( set_strm_complete     ) ? 1'b1          :
                                                          strm_complete ;
          end
   
      end
  endgenerate  // end of stream control fsm(s)


  // assign control to dma and stOp from loaded registers
  `include "streamingOps_cntl_control_assignments.vh"


  //--------------------------------------------------------------------------------------------

  always @(posedge clk)
    begin
      reg__sdp__valid     <=     reg__scntl__valid  ;
      reg__sdp__cntl      <=     reg__scntl__cntl   ;
      reg__sdp__data      <=     reg__scntl__data   ;
      scntl__reg__ready   <=     sdp__reg__ready    ;
    end
   

  //-------------------------------------------------------------------------------------------------
  // Connect result bus from stOp to simd regFile
  //
  `include "streamingOps_cntl_to_simd_regfile_assignments.vh"

endmodule

