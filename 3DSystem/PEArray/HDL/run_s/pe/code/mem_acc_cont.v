/*********************************************************************************************

    File name   : mem_acc_cont.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 1015
    email       : lbbaker@ncsu.edu

    Description : This module takes requests from the DMA engine and the LD/ST unit and grants continous
                  access. If the DMA engine has been granted access and the LD/ST issues a request, the 
                  grant to the DMA engine is deasserted but the control cannot be passed until the DMA
                  engine releases the memory.

                  The memory is arranged as two Banks. The controller allows bank conflicts but will flag a conflict
                  error interrupt for debug purposes.
                  FIXME: Should we consider common memory controller with 32 banks for the 16 exec lanes.
                         Is the nature of NN's such that each exec lane will always be operating on its own
                         vectors?
                         

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "streamingOps_cntl.vh"
`include "mem_acc_cont.vh"

// FIXME':
// Features to be added:
// a) Exceptions
//   i) if two or more streams read to the same bank
//   ii) if two or more streams write to the same bank
//
//
//

module mem_acc_cont (
            clk                         ,
            reset_poweron               ,
                                        
            `ifdef SYNTHESIS
            // if synthesis, bring sram ports to top
            //`include "mem_acc_cont_memory_ports.vh"
            `endif

            //-------------------------------
            // Controller Interface
            scntl__memc__request                 ,
            memc__scntl__granted                 ,
            scntl__memc__released                ,

            // DMA Interface
            `include "mem_acc_cont_dma_ports.vh"


            //-------------------------------
            // LD/ST Interface
            ldst__memc__request         ,
            memc__ldst__granted         ,
            ldst__memc__released        ,

            ldst__memc__write_valid     ,  // Valid must remain active for entire DMA
            ldst__memc__write_address   ,
            ldst__memc__write_data      ,
            memc__ldst__write_ready     ,  // output flow control to ldst
            ldst__memc__read_valid      ,
            ldst__memc__read_address    ,
            memc__ldst__read_data       ,
            memc__ldst__read_data_valid ,  // Valid must remain active for entire DMA, only accepted when ready is asserted
            memc__ldst__read_ready      ,  // output flow control to ldst, valid only "valid" when ready is asserted
            ldst__memc__read_pause        // pipeline flow control from ldst, dont send any more requests
                                        
    );

  input         clk            ;
  input         reset_poweron  ;
   
                                                                     
  // interface to COntroller
  input                                         scntl__memc__request          ;  // all exec lane cntl ports need to access together
  output                                        memc__scntl__granted          ;
  input                                         scntl__memc__released         ;

  `ifdef SYNTHESIS
  // if synthesis, bring sram ports to top
  //`include "mem_acc_cont_memory_ports_declaration.vh"
  `endif

  `include "mem_acc_cont_dma_ports_declaration.vh"
                                                                     
  // interface to LD/ST unit                                         
  input                                         ldst__memc__request          ;
  output                                        memc__ldst__granted          ;
  input                                         ldst__memc__released         ;
  // 
  input                                         ldst__memc__write_valid     ; 
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__write_address   ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  ldst__memc__write_data      ; 
  output                                        memc__ldst__write_ready     ;
  input                                         ldst__memc__read_valid      ; 
  input  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__read_address    ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__ldst__read_data       ; 
  output                                        memc__ldst__read_data_valid ; 
  output                                        memc__ldst__read_ready      ; 
  input                                         ldst__memc__read_pause      ; 



  //-------------------------------------------------------------------------------------------
  // Wires and Register
  //

  wire scntl__memc__request   ;
  wire cntl_request          ;
  reg  cntl_granted          ;
  wire cntl_granted_next     ;
  wire memc__scntl__granted   ;
  wire scntl__memc__released  ;
  wire cntl_released         ;

  wire ldst__memc__request  ;
  wire ldst_request         ;
  reg  ldst_granted         ;
  wire ldst_granted_next    ;
  wire memc__ldst__granted  ;
  wire ldst__memc__released ;
  wire ldst_released        ;


  // Read datapath and flags telling us which bank(s) the two dma addresses are accessing
  // e.g. uses the MSB(s) to determine which bank is accessed by the stream
  `include "mem_acc_cont_wires.vh"
//
  //-------------------------------------------------------------------------------------------
  // Request/Grant FSM
  //
  // Provide access to memory to DMA engine or LD/ST unit.
  // It is assumed that LD/ST requests and DMA requests are mutually
  // exclusive, so do we need an arbiter - FIXME?
  // priority given to the DMA engine.
  // If a DMA request does occur when a LD/ST is granted, the arbiter
  // immediately requests the LD/ST engine release the memory.
  //
  // Note: Assume the request is an 'AND' of all the DMA's requests
  reg  [`MEM_ACC_CONT_ARBITER_STATE_RANGE] mem_acc_arbiter_state;          // state flop
  reg  [`MEM_ACC_CONT_ARBITER_STATE_RANGE] mem_acc_arbiter_state_next;

  assign cntl_request         = scntl__memc__request   ;
  assign ldst_request        = ldst__memc__request  ;
  assign memc__scntl__granted  = cntl_granted          ;
  assign memc__ldst__granted = ldst_granted         ;
  assign cntl_released        = scntl__memc__released  ;
  assign ldst_released       = ldst__memc__released ;

  // State register 
  always @(posedge clk)
    begin
      mem_acc_arbiter_state <= ( reset_poweron ) ? `MEM_ACC_CONT_ARBITER_WAIT : mem_acc_arbiter_state_next ;
    end

  
  // next state equations
  always @(*)
    begin
     case (mem_acc_arbiter_state)
       
     `MEM_ACC_CONT_ARBITER_WAIT: 
       mem_acc_arbiter_state_next = (  cntl_request  ) ? `MEM_ACC_CONT_ARBITER_DMA_GRANT   :
                                                         `MEM_ACC_CONT_ARBITER_LDST_GRANT  ;  // default to granted LD/ST

     `MEM_ACC_CONT_ARBITER_LDST_GRANT:
       mem_acc_arbiter_state_next = (~ldst_request &&  cntl_request ) ? `MEM_ACC_CONT_ARBITER_DMA_GRANT    : 
                                    ( ldst_request &&  cntl_request ) ? `MEM_ACC_CONT_ARBITER_LDST_RELEASE :
                                    (~ldst_request && ~cntl_request ) ? `MEM_ACC_CONT_ARBITER_LDST_GRANT   :
                                                                        `MEM_ACC_CONT_ARBITER_LDST_GRANT   ;

     `MEM_ACC_CONT_ARBITER_LDST_RELEASE:
       mem_acc_arbiter_state_next = ( ldst_released &&  cntl_request ) ? `MEM_ACC_CONT_ARBITER_DMA_GRANT    :
                                    ( ldst_released                  ) ? `MEM_ACC_CONT_ARBITER_WAIT         :
                                                                         `MEM_ACC_CONT_ARBITER_LDST_RELEASE ; 

     `MEM_ACC_CONT_ARBITER_DMA_GRANT:
       mem_acc_arbiter_state_next = ( ldst_request && ~cntl_request ) ? `MEM_ACC_CONT_ARBITER_LDST_GRANT :
                                    (                 ~cntl_request ) ? `MEM_ACC_CONT_ARBITER_LDST_GRANT :
                                                                        `MEM_ACC_CONT_ARBITER_DMA_GRANT  ;

     `MEM_ACC_CONT_ARBITER_DMA_RELEASE:
       mem_acc_arbiter_state_next = ( ldst_request &&  cntl_released ) ? `MEM_ACC_CONT_ARBITER_LDST_GRANT  :
                                    (                  cntl_released ) ? `MEM_ACC_CONT_ARBITER_WAIT        :
                                                                         `MEM_ACC_CONT_ARBITER_DMA_RELEASE ; 

     default:
       mem_acc_arbiter_state_next = `MEM_ACC_CONT_ARBITER_WAIT;
     
     endcase // case(mem_acc_arbiter_state)
       
    end // always @ (*)

  //-------------------------------------------------------------------------------------------------
  // output equations
  //
  assign cntl_granted_next       =  (mem_acc_arbiter_state == `MEM_ACC_CONT_ARBITER_DMA_GRANT  );
  assign ldst_granted_next       =  (mem_acc_arbiter_state == `MEM_ACC_CONT_ARBITER_LDST_GRANT );
  
  always @(posedge clk)
    begin
      cntl_granted       <= ( reset_poweron ) ? 'd0  : cntl_granted_next      ;
      ldst_granted       <= ( reset_poweron ) ? 'd0  : ldst_granted_next      ;
    end
   

  //-------------------------------------------------------------------------------------------
  // Memory Access and Bank Control FSM
  
  //--------------------------------------------------------------------
  // internal signals
  //
  //--------------------------------------------------------------------
  //
  // We have an FSM for each bank. 
  //
  // Each FSM operates independently. FIXME - need to add arbitration between
  // simultaneous requests such as cell status updates in HTM.
  // Will provide priority to writes to avoid flow controlling pipe.
  // Assumptions :
  //   a) writes are small percentage of reads. e.g. with write back of
  //   a convolved value although this will ccur at the end of reads and with
  //   HTM cell status where we stream many states buy exec lane is only
  //   loking for a subset of the streamed cell states.
  //

  
  genvar gvi;
  generate
    for (gvi=0; gvi<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS; gvi=gvi+1) 
//    for (gvi=0; gvi<`NUM_OF_MEMORY_BANKS; gvi=gvi+1) 
      begin: bank_fsm  // 0 - bank0, 1 - bank1, 2 - etc.

        reg  [`MEM_ACC_CONT_STATE_RANGE] mem_acc_state;          // state flop
        reg  [`MEM_ACC_CONT_STATE_RANGE] mem_acc_state_next;

        // LD/ST access
        wire ldst_read_request        ;
        wire ldst_read_access         ;
        wire ldst_write_request       ;
        wire ldst_write_access        ;

        wire ldst_read_ready          ;  // ignore all requests until we deassert ready
        wire ldst_write_ready         ;  // ignore all requests until we deassert ready

        // DMA accesses
        `include "mem_acc_cont_bank_fsm_dma_access_wires.vh"


        // State register 
        always @(posedge clk)
          begin
            mem_acc_state <= ( reset_poweron ) ? `MEM_ACC_CONT_WAIT : mem_acc_state_next ;
          end

        // next state equations
        // If in BANKED state, then access can occur simultaneously.
        // If streams are accessing the same bank, then we perform the stream0
        // access first and the stream1 access second.
        //
        // We assume that the streaming will outweigh the setup so we dont
        // worry about how quickly the access is initiated after the access
        // request
        //
        always @(*)
          begin
           case (mem_acc_state)
             
           `MEM_ACC_CONT_WAIT:
             mem_acc_state_next = ( cntl_granted   ) ? `MEM_ACC_CONT_DMA  :
                                  ( ldst_granted  ) ? `MEM_ACC_CONT_LDST :
                                                      `MEM_ACC_CONT_WAIT ; 
           `MEM_ACC_CONT_LDST:
             mem_acc_state_next = ( ~ldst_granted        )  ? `MEM_ACC_CONT_WAIT              :
                                  (  ldst_write_request  )  ? `MEM_ACC_CONT_LDST_WRITE_ACCESS : 
                                  (  ldst_read_request   )  ? `MEM_ACC_CONT_LDST_READ_ACCESS  : 
                                                              `MEM_ACC_CONT_LDST              ; 

           `MEM_ACC_CONT_LDST_WRITE_ACCESS:
             mem_acc_state_next = ( ~ldst_granted        )  ? `MEM_ACC_CONT_WAIT              :
                                  (  ldst_write_request  )  ? `MEM_ACC_CONT_LDST_WRITE_ACCESS : 
                                  (  ldst_read_request   )  ? `MEM_ACC_CONT_LDST_READ_ACCESS  : 
                                                              `MEM_ACC_CONT_LDST              ; 

           `MEM_ACC_CONT_LDST_READ_ACCESS:
             mem_acc_state_next = ( ~ldst_granted        )  ? `MEM_ACC_CONT_WAIT              :
                                  (  ldst_write_request  )  ? `MEM_ACC_CONT_LDST_WRITE_ACCESS : 
                                  (  ldst_read_request   )  ? `MEM_ACC_CONT_LDST_READ_ACCESS  : 
                                                              `MEM_ACC_CONT_LDST              ; 
   
           `include "mem_acc_cont_bank_fsm_state_transitions.vh"

   
   
           default:
             mem_acc_state_next = `MEM_ACC_CONT_WAIT;
           
           endcase // case(mem_acc_state)

          end // always @ (*)

          // port ready when transitioning to the state
          assign ldst_read_ready    = ( mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS)       ;
          assign ldst_write_ready   = ( mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS)      ;
          `include "mem_acc_cont_bank_fsm_dma_port_ready.vh"

      end
  endgenerate

  // Pass signals to/from the FSM's in the generate function
  //
  `include "mem_acc_cont_bank_fsm_connections.vh"
////
  //-------------------------------------------------------------------------------------------------
  // output equations
  //
   
  //
  //
  //-------------------------------------------------------------------------------------------------
  // Instantiations
  //
  //----------------------------------------------------------------------
  // Memory
  //
  // Instantiate 2 banks
  //
  // Signalling passed to and from the banks based on the read and write FSM
  // state.
  // We still maintain the strm0 and strm1 nomenclature but in the case of banked
  // accesses the strm0 and strm1 access occur simultaneously
  //
  //genvar gvi;
  generate
    for (gvi=0; gvi<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS; gvi=gvi+1) 
      begin: bank_mem

        // Bank addr/data/control
        wire  [`MEM_ACC_CONT_BANK_ADDRESS_RANGE ]  read_address                ;
        wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE  ]  read_data                   ; 
        wire                                       read_data_ldst_valid_next   ;
        reg                                        read_data_ldst_valid        ;

        `include "mem_acc_cont_bank_mem_dma_declarations.vh"
         
        wire  [`MEM_ACC_CONT_BANK_ADDRESS_RANGE ]  write_address      ;
        wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE  ]  write_data         ; 
        wire                                       write_enable       ; 

        wire  [`MEM_ACC_CONT_STATE_RANGE        ]  mem_acc_state_next ;    
     
        `include "mem_acc_cont_bank_mem_assignments.vh"


        generic_2port_memory #(.GENERIC_MEM_DEPTH          (`MEM_ACC_CONT_BANK_DEPTH        ),
                               .GENERIC_MEM_REGISTERED_OUT (0                               ),
                               .GENERIC_MEM_DATA_WIDTH     (`MEM_ACC_CONT_MEMORY_DATA_WIDTH )
                        ) gmemory ( 
                        
                        //---------------------------------------------------------------
                        // Port A
                        .portA_address       ( write_address   ),
                        .portA_write_data    ( write_data      ),
                        .portA_read_data     (                 ),
                        .portA_enable        ( 1'b1            ),
                        .portA_write         ( write_enable    ),
                        
                        //---------------------------------------------------------------
                        // Port B
                        .portB_address       ( read_address    ),
                        .portB_write_data    ( {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {1'b0}} ),
                        .portB_read_data     ( read_data       ),
                        .portB_enable        ( 1'b1            ),
                        .portB_write         ( 1'b0            ),
                        
                        //---------------------------------------------------------------
                        // General
                        .reset_poweron       ( reset_poweron   ),
                        .clk                 ( clk             )
                        ) ;

/*
`ifndef SYNTHESIS
        sram mem (
                     .clock         ( clk                ),
   
                     .WE            ( write_enable       ),
                     .WriteAddress  ( write_address      ),
                     .WriteBus      ( write_data         ),
                     .ReadAddress   ( read_address       ),
                     .ReadBus       ( read_data_next     ));
`endif
*/

      end
  endgenerate

  `include "mem_acc_cont_bank_mem_connections.vh"
  
`ifdef SYNTHESIS
  // if synthesis, bring sram ports to top
  //`include "mem_acc_cont_bank_mem_sram_connections.vh"
`endif

  
endmodule

