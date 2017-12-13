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

            //-------------------------------
            // Controller Interface
            input  wire                                      scntl__memc__request          ,  // all exec lane cntl ports need to access together
            output reg                                       memc__scntl__granted          ,
            input  wire                                      scntl__memc__released         ,

            // DMA Interface
            input  wire                                        dma__memc__write_valid      [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],
            input  wire [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address    [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],
            input  wire [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data       [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],
            output reg                                         memc__dma__write_ready      [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],
            input  wire                                        dma__memc__read_valid       [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],
            input  wire [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address     [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],
            output reg  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data        [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],
            output reg                                         memc__dma__read_data_valid  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],
            output reg                                         memc__dma__read_ready       [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],
            input  wire                                        dma__memc__read_pause       [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ],

            //-------------------------------
            // LD/ST Interface
            input  wire                                        ldst__memc__request         ,
            output reg                                         memc__ldst__granted         ,
            input  wire                                        ldst__memc__released        ,
            // 
            input  wire                                        ldst__memc__write_valid     ,  // Valid must remain active for entire DMA                                        
            input  wire [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__write_address   ,
            input  wire [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  ldst__memc__write_data      ,                                                                                    
            output reg                                         memc__ldst__write_ready     ,  // output flow control to ldst
            input  wire                                        ldst__memc__read_valid      ,                                                                                    
            input  wire [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__read_address    ,
            output reg [`MEM_ACC_CONT_MEMORY_DATA_RANGE     ]  memc__ldst__read_data       ,                                                                                    
            output reg                                         memc__ldst__read_data_valid ,  // Valid must remain active for entire DMA, only accepted when ready is asserted  
            output reg                                         memc__ldst__read_ready      ,  // output flow control to ldst, valid only "valid" when ready is asserted         
            input  wire                                        ldst__memc__read_pause      ,  // pipeline flow control from ldst, dont send any more requests                   
                                        
            input  wire        clk            ,
            input  wire        reset_poweron
    );



  //-------------------------------------------------------------------------------------------
  // Wires and Register
  //

  wire     cntl_request          ;
  reg      cntl_granted          ;
  wire     cntl_granted_next     ;
  reg      cntl_released         ;
           
  wire     ldst_request          ;
  reg      ldst_granted          ;
  wire     ldst_granted_next     ;
  reg      ldst_released         ;


  // Read datapath and flags telling us which bank(s) the two dma addresses are accessing
  // e.g. uses the MSB(s) to determine which bank is accessed by the stream
  //----------------------------------------------------------------------------------------------------

  reg [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst_write_address ;
  reg [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst_read_address  ;

  reg [`MEM_ACC_CONT_BANK_ADDRESS_RANGE   ]  ldst_write_bank_address ;
  reg [`MEM_ACC_CONT_BANK_ADDRESS_RANGE   ]  ldst_read_bank_address  ;

  always @(posedge clk)
    begin
      ldst_write_address  <=  ldst__memc__write_address   ;
      ldst_read_address   <=  ldst__memc__read_address    ;
    end

  always @(*)
    begin
      ldst_write_bank_address  <=  ldst_write_address [`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-4]  ;
      ldst_read_bank_address   <=  ldst_read_address  [`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-4]  ;
    end

  reg  ldst_write_addr_to_bank      [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ] ; 
  reg  ldst_read_addr_to_bank       [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ] ; 
  reg  ldst_write_request_to_bank   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ] ; 
  reg  ldst_write_access_to_bank    [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ] ; 
  reg  ldst_read_request_to_bank    [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ] ; 
  reg  ldst_read_access_to_bank     [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ] ; 

  reg   dma__memc__read_pause_d1    [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ];

  reg  dma_write_addr_to_bank  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;
  reg  dma_read_addr_to_bank   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;

  reg  write_request_to_bank   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;
  reg  write_access_to_bank    [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;
  reg  read_request_to_bank    [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;
  reg  read_access_to_bank     [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;

  `ifndef MEM_ACC_CONT_ALLOW_ACCESS_ANY 
    // Only port 0 can access other banks
    // e.g. indexing is, bank s, port p wants to access bank d
    //   dma_write_addr_to_bank  [s][p][d]
    //
    //   write_request_to_bank [s][p][d] - write request from bank interface s, port p to memory bank d
    // 
    //
    reg  dma_write_addr_other_to_bank  [1][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    reg  dma_read_addr_other_to_bank   [1][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    
    // - these signals decode whether this banks dma channel is making a request
    reg  write_request_other_to_bank   [1][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    reg  write_access_other_to_bank    [1][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    reg  read_request_other_to_bank    [1][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    reg  read_access_other_to_bank     [1][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
  `else
    reg  dma_write_addr_other_to_bank  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    reg  dma_read_addr_other_to_bank   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    
    // - these signals decode whether this banks dma channel is making a request
    reg  write_request_other_to_bank   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    reg  write_access_other_to_bank    [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    reg  read_request_other_to_bank    [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
    reg  read_access_other_to_bank     [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ][`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
  `endif

  //----------------------------------------------------------------------------------------------------
  // What bank is the LDST accessing
  genvar bank;
  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
      begin
        always @(posedge clk)
          begin
            ldst_write_addr_to_bank     [bank]  =  (ldst__memc__write_address[`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-4] == bank)  ;
            ldst_read_addr_to_bank      [bank]  =  (ldst__memc__read_address [`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-4] == bank)  ;
            ldst_write_request_to_bank  [bank]  =  ldst_write_addr_to_bank    [bank] & ldst__memc__write_valid   ;                                         
            ldst_write_access_to_bank   [bank]  =  ldst_write_request_to_bank [bank] & memc__ldst__write_ready   ;  // request and ready to accept request 
            ldst_read_request_to_bank   [bank]  =  ldst_read_addr_to_bank     [bank] & ldst__memc__read_valid    ;                                         
            ldst_read_access_to_bank    [bank]  =  ldst_read_request_to_bank  [bank] & memc__ldst__read_ready    ;                                         
          end
      end
  endgenerate

  //----------------------------------------------------------------------------------------------------
  // 
  genvar port;
  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
      begin
        for (port=0; port<`MEM_ACC_CONT_BANK_NUM_OF_PORTS ; port++)
          begin
            always @(posedge clk)
              begin
                dma__memc__read_pause_d1  [bank][port]  <= dma__memc__read_pause [bank][port] ;   
              end
          end
      end
  endgenerate

  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
        begin
          for (port=0; port<`MEM_ACC_CONT_BANK_NUM_OF_PORTS ; port++)
            begin
              always @(*)
                begin
                  dma_write_addr_to_bank [bank] [port]  =  (dma__memc__write_address [bank] [port] [`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-4] == bank)  ;
                  dma_read_addr_to_bank  [bank] [port]  =  (dma__memc__read_address  [bank] [port] [`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-4] == bank)  ;
                  write_request_to_bank  [bank] [port]  =  dma_write_addr_to_bank    [bank] [port] & dma__memc__write_valid [bank] [port]   ;                                         
                  write_access_to_bank   [bank] [port]  =  write_request_to_bank     [bank] [port] & memc__dma__write_ready [bank] [port]   ;  // request and ready to accept request 
                  read_request_to_bank   [bank] [port]  =  dma_read_addr_to_bank     [bank] [port] & dma__memc__read_valid  [bank] [port]   ;                                         
                  read_access_to_bank    [bank] [port]  =  read_request_to_bank      [bank] [port] & memc__dma__read_ready  [bank] [port]   ;                                         
                end
            end
        end
  endgenerate

  genvar src;
  generate
    `ifdef MEM_ACC_CONT_ALLOW_ACCESS_ANY 
      for (src=0; src<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; src++)
    `else
      // only port 0 can access all banks
      for (src=0; src<1 ; src++)
    `endif
        begin
          for (port=0; port<`MEM_ACC_CONT_BANK_NUM_OF_PORTS ; port++)
            begin
              for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
                begin
                  always @(*)
                    begin
                      dma_write_addr_other_to_bank [src] [port] [bank]  =  (dma__memc__write_address [src] [port] [`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-4] == bank)  ;
                      dma_read_addr_other_to_bank  [src] [port] [bank]  =  (dma__memc__read_address  [src] [port] [`MEM_ACC_CONT_MEMORY_ADDRESS_MSB : `MEM_ACC_CONT_MEMORY_ADDRESS_MSB-4] == bank)  ;
                      write_request_other_to_bank  [src] [port] [bank]  =  dma_write_addr_other_to_bank    [src] [port] [bank] & dma__memc__write_valid [src] [port]   ;                                         
                      write_access_other_to_bank   [src] [port] [bank]  =  write_request_other_to_bank     [src] [port] [bank] & memc__dma__write_ready [src] [port]   ;  // request and ready to accept request 
                      read_request_other_to_bank   [src] [port] [bank]  =  dma_read_addr_other_to_bank     [src] [port] [bank] & dma__memc__read_valid  [src] [port]   ;                                         
                      read_access_other_to_bank    [src] [port] [bank]  =  read_request_other_to_bank      [src] [port] [bank] & memc__dma__read_ready  [src] [port]   ;                                         
                    end
                end
            end
        end
  endgenerate

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

  assign cntl_request          = scntl__memc__request   ;
  assign ldst_request          = ldst__memc__request    ;
  always @(posedge clk)
    begin
      memc__scntl__granted  <= cntl_granted           ;
      memc__ldst__granted   <= ldst_granted           ;

      cntl_released         <= scntl__memc__released  ;
      ldst_released         <= ldst__memc__released   ;
    end

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

  // generate vectors of the fsm contents so we can OR/AND
  reg  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE ]    ldst_read_ready        ;
  reg  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE ]    ldst_write_ready       ;

  reg  [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE   ]    read_ready_strm_this   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ] ;
  reg  [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE   ]    write_ready_strm_this  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ] ;

  `ifndef MEM_ACC_CONT_ALLOW_ACCESS_ANY 
    reg  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE ]    read_ready_strm_other  [1][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;
    reg  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE ]    write_ready_strm_other [1][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;
  `else
    reg  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE ]    read_ready_strm_other  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;
    reg  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE ]    write_ready_strm_other [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ][`MEM_ACC_CONT_BANK_NUM_OF_PORTS ] ;
  `endif
  
  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS; bank=bank+1) 
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

        // DMA port accesses
        wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_pause_this         ;  // which port from this banks interface is requesting
        wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_request_this       ;
        wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_access_this        ;
        wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  write_request_this      ;
        wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  write_access_this       ;
        wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_ready_strm_this    ;  // ignore all requests until we deassert ready
        wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  write_ready_strm_this   ;  // ignore all requests until we deassert ready
                          
        `ifndef MEM_ACC_CONT_ALLOW_ACCESS_ANY 
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_pause_other        [1];  // which port from another banks interface is requesting. Default is only bank 0's interfaces can access other banks
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_request_other      [1];
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_access_other       [1];
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  write_request_other     [1];
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  write_access_other      [1];
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_ready_strm_other   [1];  // ignore all requests until we deassert ready
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  write_ready_strm_other  [1];  // ignore all requests until we deassert ready
        `else                                      
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_pause_other        [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ]; // which port from another banks interface is requesting.
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_request_other      [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_access_other       [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  write_request_other     [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  write_access_other      [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  read_ready_strm_other   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];  // ignore all requests until we deassert ready
          wire [`MEM_ACC_CONT_BANK_NUM_OF_PORTS_VECTOR_RANGE ]  write_ready_strm_other  [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ];  // ignore all requests until we deassert ready
        `endif
        //`include "mem_acc_cont_bank_fsm_dma_access_wires.vh"


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
                                  ( ldst_granted   ) ? `MEM_ACC_CONT_LDST :
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
   
           //`include "mem_acc_cont_bank_fsm_state_transitions.vh"

           `MEM_ACC_CONT_DMA:
             mem_acc_state_next = ( ~cntl_granted                                        )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request_this [0]                              )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  : 
                                  (  read_request_this [0]  && ~read_pause_this [0]      )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   : 
                                  (  write_request_other[0][0]                           )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS : 
                                  (  read_request_other [0][0] && ~read_pause_this [0]   )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  : 
                                                                                              `MEM_ACC_CONT_DMA                     ; 
           `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted                                        )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request_this [0]                              )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  :
                                  (  write_request_other[0][0]                           )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS :
                                  (  read_request_this [0]  && ~read_pause_this [0]      )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   :
                                  (  read_request_other[0][0] && ~read_pause_other[0][0] )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  :
                                                                                              `MEM_ACC_CONT_DMA                    ;
 
           `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS:
             mem_acc_state_next = ( ~cntl_granted                                        )  ? `MEM_ACC_CONT_WAIT                   :
                                  (  write_request_this [0]                              )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  :
                                  (  write_request_other[0]                              )  ? `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS :
                                  (  read_request_this [0]  && ~read_pause_this [0]      )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   :
                                  (  read_request_other[0][0] && ~read_pause_other[0][0] )  ? `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  :
                                                                                              `MEM_ACC_CONT_DMA                    ;
 
           `MEM_ACC_CONT_DMA_STRM_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted                                      )  ? `MEM_ACC_CONT_WAIT                  :
                                  (  write_request_this [0]                            )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS :
                                  (  read_request_this [0] && ~read_pause_this [0]     )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS  :
                                                                                            `MEM_ACC_CONT_DMA                   ;
 
           `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS:
             mem_acc_state_next = ( ~cntl_granted                                   )  ? `MEM_ACC_CONT_WAIT                  :
                                  (  write_request_this [0]                         )  ? `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS :
                                  (  read_request_this [0] && ~read_pause_this [0]  )  ? `MEM_ACC_CONT_DMA_STRM_READ_ACCESS  :
                                                                                         `MEM_ACC_CONT_DMA                   ;
 
   
   
           default:
             mem_acc_state_next = `MEM_ACC_CONT_WAIT;
           
           endcase // case(mem_acc_state)

          end // always @ (*)

          // port ready when transitioning to the state
          assign ldst_read_ready    = ldst_read_request  & ( mem_acc_state == `MEM_ACC_CONT_LDST) ;
          assign ldst_write_ready   = ldst_write_request & ( mem_acc_state == `MEM_ACC_CONT_LDST) ;

          assign read_ready_strm_this   [0]      = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS)   ;
          assign write_ready_strm_this  [0]      = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS)  ;
          assign read_ready_strm_other  [0] [0]  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS)  ;  // FIXME
          assign write_ready_strm_other [0] [0]  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS) ;
          //`include "mem_acc_cont_bank_fsm_dma_port_ready.vh"

      end
  endgenerate

  // generate vectors of the fsm contents so we can OR/AND
  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
      begin
         always @(*)
           begin
             ldst_read_ready      [bank] = bank_fsm[bank].ldst_read_ready       ;
             ldst_write_ready     [bank] = bank_fsm[bank].ldst_write_ready      ;
           end
      end
  endgenerate

  // generate vectors of the fsm contents so we can OR/AND
  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
      begin
        for (port=0; port<`MEM_ACC_CONT_BANK_NUM_OF_PORTS ; port++)
          begin
            always @(*)
              begin
                read_ready_strm_this [bank] [port] = bank_fsm[bank].read_ready_strm_this  [port]  ;
                write_ready_strm_this[bank] [port] = bank_fsm[bank].write_ready_strm_this [port]  ;
              end
          end
      end
  endgenerate

  // generate vectors of the fsm contents so we can OR/AND
  generate
    `ifdef MEM_ACC_CONT_ALLOW_ACCESS_ANY 
      for (src=0; src<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; src++)
    `else
      // only port 0 can access all banks
      for (src=0; src<1 ; src++)
    `endif
        begin
          for (port=0; port<`MEM_ACC_CONT_BANK_NUM_OF_PORTS ; port++)
            begin
              for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
                begin
                  always @(*)
                    begin
                      read_ready_strm_other   [src] [port] [bank]  =  bank_fsm[bank].read_ready_strm_other   [src] [port];
                      write_ready_strm_other  [src] [port] [bank]  =  bank_fsm[bank].write_ready_strm_other  [src] [port];
                    end
                end
            end
        end
  endgenerate

  always @(posedge clk)
    begin
      memc__ldst__read_ready  <=  |ldst_read_ready  ;
      memc__ldst__write_ready <=  |ldst_write_ready ;
    end

  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
      begin
        for (port=0; port<`MEM_ACC_CONT_BANK_NUM_OF_PORTS ; port++)
          begin
             always @(posedge clk)
               begin
                 if (bank == 0)
                   begin
                     memc__dma__write_ready [bank] [port] <= write_ready_strm_this [bank] [port] | write_ready_strm_other [bank] [port] ;
                     memc__dma__read_ready  [bank] [port] <= read_ready_strm_this  [bank] [port] | read_ready_strm_other  [bank] [port] ;
                   end
                 else
                   begin
                     memc__dma__write_ready [bank] [port] <= write_ready_strm_this [bank] [port] ;
                     memc__dma__read_ready  [bank] [port] <= read_ready_strm_this  [bank] [port] ;
                   end
               end
          end
      end
  endgenerate

  // Pass signals to/from the FSM's in the generate function
  //
  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS; bank=bank+1) 
      begin: bank_fsm_connections_this
        for (port=0; port<`MEM_ACC_CONT_BANK_NUM_OF_PORTS ; port++)
          begin
            // Bank bank
            assign bank_fsm[bank].ldst_read_request        = ldst_read_request_to_bank  [bank] ;
            assign bank_fsm[bank].ldst_read_access         = ldst_read_access_to_bank   [bank] ;
            
            assign bank_fsm[bank].ldst_write_request       = ldst_write_request_to_bank [bank] ;
            assign bank_fsm[bank].ldst_write_access        = ldst_write_access_to_bank  [bank] ;
            //
            // this banks dma channel
            assign bank_fsm[bank].read_pause_this    [port]   = dma__memc__read_pause_d1 [bank] [port] ;  // FIXME
           
            assign bank_fsm[bank].read_request_this  [port]   = read_request_to_bank  [bank] [port];
            assign bank_fsm[bank].read_access_this   [port]   = read_access_to_bank   [bank] [port];
            assign bank_fsm[bank].write_request_this [port]   = write_request_to_bank [bank] [port];
            assign bank_fsm[bank].write_access_this  [port]   = write_access_to_bank  [bank] [port];
          end
      end
  endgenerate

  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS; bank=bank+1) 
      begin: bank_fsm_connections_other
        `ifdef MEM_ACC_CONT_ALLOW_ACCESS_ANY 
          for (src=0; src<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; src++)
        `else
          // Default only src 0 can access all banks
          for (src=0; src<1 ; src++)
        `endif
            begin
              for (port=0; port<`MEM_ACC_CONT_BANK_NUM_OF_PORTS ; port++)
                begin
                  // dma channel 0
                  assign bank_fsm[bank].read_pause_other    [src][port]   = dma__memc__read_pause_d1 [src] [port] ;
                  assign bank_fsm[bank].read_request_other  [src][port]   = read_request_other_to_bank     [src] [port] [bank] ;
                  assign bank_fsm[bank].read_access_other   [src][port]   = read_access_other_to_bank      [src] [port] [bank] ;
                  assign bank_fsm[bank].write_request_other [src][port]   = write_request_other_to_bank    [src] [port] [bank] ;
                  assign bank_fsm[bank].write_access_other  [src][port]   = write_access_other_to_bank     [src] [port] [bank] ;
                end
            end
      end
  endgenerate
  //`include "mem_acc_cont_bank_fsm_connections.vh"
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
  // Instantiate 1 banks
  //
  // Signalling passed to and from the banks based on the read and write FSM
  // state.
  // We still maintain the strm0 and strm1 nomenclature but in the case of banked
  // accesses the strm0 and strm1 access occur simultaneously
  //
  // generate vectors of the memory data so we can or
  reg   [`MEM_ACC_CONT_MEMORY_DATA_RANGE                  ]  read_data            [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ] ; 
  reg   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE   ]  read_data_ldst_valid                                      ;
  reg   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE   ]  read_data_strm_valid                                      ;

  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS; bank=bank+1) 
      begin: bank_mem

        // Bank addr/data/control
        localparam MEM_ACC_CONT_BANK_NUM_OF_PORTS = `MEM_ACC_CONT_BANK_NUM_OF_PORTS ;

        //wire  [`MEM_ACC_CONT_BANK_ADDRESS_RANGE ]  read_address                ;
        wire  [`MEM_ACC_CONT_BANK_ADDRESS_RANGE ]  address                     ;  // cant seem to use if localparam with wires???
        wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE  ]  read_data                   ; 
        wire                                       read_data_ldst_valid_next   ;
        reg                                        read_data_ldst_valid        ;

        wire                                      read_data_strm_valid_next  ;  
        reg                                       read_data_strm_valid       ;  
        //`include "mem_acc_cont_bank_mem_dma_declarations.vh"
         
        //wire  [`MEM_ACC_CONT_BANK_ADDRESS_RANGE ]  write_address      ;
        wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE  ]  write_data         ; 
        wire                                       write_enable       ; 

        wire  [`MEM_ACC_CONT_STATE_RANGE        ]  mem_acc_state_next ;    
     
       assign read_data_ldst_valid_next   = ( mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS    );
       assign read_data_strm_valid_next  = ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS  ) | 
                                           ( mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS ) ;
       // outputs 
       always @(posedge clk)
         begin
           read_data_ldst_valid   <= ( reset_poweron ) ? 'b0  : read_data_ldst_valid_next   ;
           read_data_strm_valid   <= ( reset_poweron ) ? 'b0  : read_data_strm_valid_next  ;
         end
        //`include "mem_acc_cont_bank_mem_assignments.vh"

            generic_1port_memory #(.GENERIC_MEM_DEPTH          (`MEM_ACC_CONT_BANK_DEPTH        ),
                                   .GENERIC_MEM_REGISTERED_OUT (0                               ),
                                   .GENERIC_MEM_DATA_WIDTH     (`MEM_ACC_CONT_MEMORY_DATA_WIDTH )
                            ) gmemory ( 
                            
                            //---------------------------------------------------------------
                            // Initialize
                            //
                            `ifndef SYNTHESIS
                               .memFile ("" ),
                            `endif

                            //---------------------------------------------------------------
                            // Port A
                            .portA_address       ( address         ),
                            .portA_write_data    ( write_data      ),
                            .portA_read_data     ( read_data       ),
                            .portA_enable        ( 1'b1            ),
                            .portA_write         ( write_enable    ),
                            
                            //---------------------------------------------------------------
                            // General
                            .reset_poweron       ( reset_poweron   ),
                            .clk                 ( clk             )
                            ) ;

      end
  endgenerate

  // generate vectors of the read data
  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
      begin: rd_data
         always @(*)
           begin
             read_data_ldst_valid [bank] = bank_mem[bank].read_data_ldst_valid  ;
             read_data_strm_valid [bank] = bank_mem[bank].read_data_strm_valid  ;
             read_data            [bank] = bank_mem[bank].read_data             ;
           end

      end
  endgenerate
/*
  generate
    for (bank=0; bank < `MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
      begin : data_or
        reg  [`MEM_ACC_CONT_MEMORY_DATA_RANGE   ]  read_data_ored   ;
        always @(*)
          begin
            read_data_ored = 'd0 ;
            for (int bank=0; bank<`MEM_ACC_CONT_NUM_OF_PORTS ; bank++)
              read_data_ored = read_data_ored | read_data [bank] ;
            read_data            [bank] = bank_mem[bank].read_data             ;
          end
      end
  endgenerate
*/

  always @(posedge clk)
    begin
      memc__ldst__read_data_valid   <=  read_data_ldst_valid [ldst_read_bank_address];
      memc__ldst__read_data         <=  read_data            [ldst_read_bank_address];
    end

  generate
    for (bank=0; bank < `MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ; bank++)
      begin
        for (port=0; port<`MEM_ACC_CONT_BANK_NUM_OF_PORTS ; port++)
          begin
             always @(posedge clk)
               begin
                 if (port == 0)
                   begin
                     memc__dma__read_data_valid [bank][port] <= read_data_strm_valid [bank];
                     memc__dma__read_data       [bank][port] <= read_data            [bank];
                   end                                                                     
                 else                                                                      
                   begin                                                                   
                     memc__dma__read_data_valid [bank][port] <= read_data_strm_valid [bank];
                     memc__dma__read_data       [bank][port] <= read_data            [bank];
                   end
               end
          end
      end
  endgenerate

  // Register all signals to/from local memory
  // - we dont care about latency
  // - timing of sram isnt great, regFile is much better
  reg   [`MEM_ACC_CONT_BANK_ADDRESS_RANGE               ]  local_mem_address          [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ]  ;
  reg   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE ]  local_mem_write_enable                                           ;
  reg   [`MEM_ACC_CONT_MEMORY_DATA_RANGE                ]  local_mem_write_data       [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ]  ;
  //reg   [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS_VECTOR_RANGE ]  local_mem_read_data_valid                                        ;
  //reg   [`MEM_ACC_CONT_MEMORY_DATA_RANGE                ]  local_mem_read_data        [`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS ]  ;

  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS; bank=bank+1) 
      begin: mem_wr_regs
        always @(posedge clk)
          begin
      
            local_mem_address          [bank]  <=  {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_READ_ACCESS   )}} & dma__memc__read_address  [bank][0] [`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                                   {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_READ_ACCESS  )}} & dma__memc__read_address  [0]   [0] [`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                                   {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_LDST_READ_ACCESS       )}} & ldst__memc__read_address           [`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                                   {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_address [bank][0] [`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                                   {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_address [0]   [0] [`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                                   {`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_address          [`MEM_ACC_CONT_BANK_ADDRESS_RANGE] |
                                                   {{`MEM_ACC_CONT_BANK_ADDRESS_WIDTH {{1'b0}}}} ;
                                           
            local_mem_write_data       [bank]  <=   
                                                   {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  )}} & dma__memc__write_data [bank][0] [`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                                   {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS )}} & dma__memc__write_data [0]   [0] [`MEM_ACC_CONT_BANK_DATA_RANGE] |
                                                   {`MEM_ACC_CONT_MEMORY_DATA_WIDTH {( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      )}} & ldst__memc__write_data          [`MEM_ACC_CONT_BANK_DATA_RANGE] ;
                                           
            local_mem_write_enable     [bank] <=   
                                                   ( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM_WRITE_ACCESS  ) & dma__memc__write_valid [bank][0] |
                                                   ( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_DMA_STRM0_WRITE_ACCESS ) & dma__memc__write_valid [0]   [0] |
                                                   ( bank_fsm[bank].mem_acc_state_next == `MEM_ACC_CONT_LDST_WRITE_ACCESS      ) & ldst__memc__write_valid          ;

            //local_mem_read_data        [bank]  <=   bank_mem[bank].read_data             ;
            //local_mem_read_data_valid  [bank]  <=   bank_mem[bank].read_data_strm_valid  ;
           
          end
      end
  endgenerate
  generate
    for (bank=0; bank<`MEM_ACC_CONT_NUM_OF_MEMORY_BANKS; bank=bank+1) 
      begin: mem_connections
        assign bank_mem[bank].mem_acc_state_next = bank_fsm[bank].mem_acc_state_next ;
      
        assign bank_mem[bank].address       =  local_mem_address      [bank] ;
        assign bank_mem[bank].write_data    =  local_mem_write_data   [bank] ;
        assign bank_mem[bank].write_enable  =  local_mem_write_enable [bank] ;

      end
  endgenerate
  //`include "mem_acc_cont_bank_mem_connections.vh"
  

  
endmodule

