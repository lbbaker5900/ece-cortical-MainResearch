/*********************************************************************************************

    File name   : dma_cont.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2015
    email       : lbbaker@ncsu.edu

    Description : This module performs memory reads and transfers the data to the streaming operation function.
                  The starting address of memory reads comes from registers inside the PE core.
                  The dma controller first gets access to the memory, and once granted starts performing
                  from the start address provided by the pe core registers.
                  The dma stops once the number of bits has been completed.
                  We use bit because some most dma data are vectors of states or weights or inputs and these can be boolean
                  values.

                  The DMA engine will provide 1 or 2 streams to the streaming op function.
                  The DMA will be streaming mainly from memory to streaming operation and in this case there will be one
                  or two arguments with a result scalar/vector written back to memory.
                  If we are streaming from memory, the start addresses are pointers to the argument vectors and the result address
                  is a pointer to the result. 
                  The "to" memory streaming will likely be data from the external interface being streamed directly into local memory
                  or the result of an external streaming operation being written to memory.

                  FIXME: There isnt currently a case for two streaming interfaces "to" memory but we'll leave two there for now.

                  FIXME: We will cut memory into two equal banks and let the FSM decide where
                  if stream0 address and stream1 address are in different banks. If in the same bank, then
                  will need to mux access to same bank.

*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "stack_interface.vh"
`include "streamingOps_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"

module dma_cont (
 
            // Control Interface
            strm0_read_enable             ,  // activate the read stream
            strm0_read_ready              ,  // read stream ready   
            strm0_read_complete           ,  // read stream complete
            strm0_read_start_address      ,  // "Stream" start address
                                          
            strm0_write_enable            ,  // activate the write stream
            strm0_write_ready             ,  // write stream ready   
            strm0_write_complete          ,  // write stream complete
            strm0_write_start_address     ,  // "result" start address
                                          
            strm1_read_enable             ,
            strm1_read_ready              ,
            strm1_read_complete           ,
            strm1_read_start_address      ,  
                                          
            strm1_write_enable            ,
            strm1_write_ready             ,
            strm1_write_complete          ,
            strm1_write_start_address     ,  // "result" start address
                                          
            type0                         ,
            type1                         ,
            num_of_types0                 ,
            num_of_types1                 ,
                                          
            operation                     ,

            // Note: the memory interface IS NOT a FIFO interface
            // So transactions are only valid when ready is asserted from the
            // memc
            //
            // Memory access 0
            dma__memc__write_valid0       ,
            dma__memc__write_address0     ,
            dma__memc__write_data0        ,
            memc__dma__write_ready0       ,  // from memory controller

            dma__memc__read_valid0        ,
            dma__memc__read_address0      ,
            memc__dma__read_data0         ,
            memc__dma__read_data_valid0   ,
            memc__dma__read_ready0        ,  // from memory controller
            dma__memc__read_pause0        ,  // to memory controller  

            // Memory access 1     
            dma__memc__write_valid1       ,
            dma__memc__write_address1     ,
            dma__memc__write_data1        ,
            memc__dma__write_ready1       ,

            dma__memc__read_valid1        ,
            dma__memc__read_address1      ,
            memc__dma__read_data1         ,
            memc__dma__read_data_valid1   ,
            memc__dma__read_ready1        ,
            dma__memc__read_pause1        ,

            // Streaming Operation Interface
            // to stOp - FIFO interface (transactions are always accepted on
            // valid, deassert valid asap)
            //
            // to stOp
            //   - matched with memc__dma
            dma__stOp__strm0_data_valid  , 
            dma__stOp__strm0_cntl        , // sop,eop etc.
            dma__stOp__strm0_data        , 
            dma__stOp__strm0_data_mask   , 
            stOp__dma__strm0_ready       ,

            dma__stOp__strm1_data_valid  , 
            dma__stOp__strm1_cntl        , // sop,eop etc.
            dma__stOp__strm1_data        , 
            dma__stOp__strm1_data_mask   , 
            stOp__dma__strm1_ready       ,

            // from stOp
            //   - matched with dma__memc
            stOp__dma__strm0_data_valid  , 
            stOp__dma__strm0_cntl        , 
            stOp__dma__strm0_data        , 
            stOp__dma__strm0_data_mask   , 
            dma__stOp__strm0_ready       ,

            stOp__dma__strm1_data_valid  , 
            stOp__dma__strm1_cntl        , 
            stOp__dma__strm1_data        , 
            stOp__dma__strm1_data_mask   , 
            dma__stOp__strm1_ready       ,

            clk                          ,
            reset_poweron    
    );

  input         clk            ;
  input         reset_poweron  ;
   
  // Control Interface
  //
  // indicators to main streaming controller
  input                                         strm0_read_enable            ;
  input                                         strm1_read_enable            ;
  input                                         strm0_write_enable           ;
  input                                         strm1_write_enable           ;
  output                                        strm0_read_ready             ;
  output                                        strm1_read_ready             ;
  output                                        strm0_write_ready            ;
  output                                        strm1_write_ready            ;
  output                                        strm0_read_complete          ;
  output                                        strm1_read_complete          ;
  output                                        strm0_write_complete         ;
  output                                        strm1_write_complete         ;
                                                                             
  input  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  strm0_read_start_address     ;  // streaming op arg0
  input  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  strm1_read_start_address     ;  // streaming op arg1
  input  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  strm0_write_start_address    ;  // streaming op result start address
  input  [`DMA_CONT_STRM_ADDRESS_RANGE       ]  strm1_write_start_address    ;  // streaming op result start address
  input  [`DMA_CONT_DATA_TYPES_RANGE         ]  type0                        ;
  input  [`DMA_CONT_DATA_TYPES_RANGE         ]  type1                        ;
  input  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ]  num_of_types0                ;
  input  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE   ]  num_of_types1                ;
                                                                             
  input  [`STREAMING_OP_CNTL_OPERATION_RANGE ]  operation                    ;

  output                                        dma__memc__write_valid0      ;
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address0    ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data0       ; 
  input                                         memc__dma__write_ready0      ;
  output                                        dma__memc__read_valid0       ;
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address0     ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data0        ; 
  input                                         memc__dma__read_data_valid0  ;
  input                                         memc__dma__read_ready0       ;
  output                                        dma__memc__read_pause0       ;

  output                                        dma__memc__write_valid1      ;
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address1    ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data1       ; 
  input                                         memc__dma__write_ready1      ;
  output                                        dma__memc__read_valid1       ;
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address1     ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data1        ; 
  input                                         memc__dma__read_data_valid1  ;
  input                                         memc__dma__read_ready1       ;
  output                                        dma__memc__read_pause1       ;

  // interface to streaming operation unit

  input                                         stOp__dma__strm0_ready       ;
  output [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm0_cntl        ; 
  output [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data        ; 
  output [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data_mask   ; 
  output                                        dma__stOp__strm0_data_valid  ; 
  input                                         stOp__dma__strm1_ready       ;
  output [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm1_cntl        ; 
  output [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data        ; 
  output [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data_mask   ; 
  output                                        dma__stOp__strm1_data_valid  ; 

  output                                        dma__stOp__strm0_ready       ;
  input [`DMA_CONT_STRM_CNTL_RANGE     ]        stOp__dma__strm0_cntl        ; 
  input [`STREAMING_OP_DATA_RANGE      ]        stOp__dma__strm0_data        ; 
  input [`STREAMING_OP_DATA_RANGE      ]        stOp__dma__strm0_data_mask   ; 
  input                                         stOp__dma__strm0_data_valid  ; 
  output                                        dma__stOp__strm1_ready       ;
  input [`DMA_CONT_STRM_CNTL_RANGE     ]        stOp__dma__strm1_cntl        ; 
  input [`STREAMING_OP_DATA_RANGE      ]        stOp__dma__strm1_data        ; 
  input [`STREAMING_OP_DATA_RANGE      ]        stOp__dma__strm1_data_mask   ; 
  input                                         stOp__dma__strm1_data_valid  ; 



  //-------------------------------------------------------------------------------------------
  // Wires and Register
  //
  //------------------------------------------------------------
  // Operation related fields
  //
  // extract source and destination flags from operation fields
  //
  // to/from memory
  /*
  wire source_is_memory         = ( operation[`STREAMING_OP_CNTL_OPERATION_FROM_RANGE               ] == `STREAMING_OP_CNTL_OPERATION_FROM_MEMORY );
  wire destination_is_memory    = ( operation[`STREAMING_OP_CNTL_OPERATION_TO_RANGE                 ] == `STREAMING_OP_CNTL_OPERATION_TO_MEMORY   );
  wire [`STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_RANGE ] num_of_src_streams  =   operation[`STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_RANGE  ] ;  // 0, 1 or 2
  wire [`STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_RANGE] num_of_dest_streams =   operation[`STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_RANGE ] ;  // 0, 1 or 2

  // extract actual operation from opCode
  wire  [`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE ]  opcode       ; // BSUM or NOP or ??
  assign opcode = operation[`STREAMING_OP_CNTL_OPERATION_OPCODE_RANGE];
  // number of streams to/from memory
  wire [`STREAMING_OP_CNTL_OPERATION_NUM_OF_SRC_STREAMS_RANGE ] streams_from_memory ;  // 0, 1 or 2
  wire [`STREAMING_OP_CNTL_OPERATION_NUM_OF_DEST_STREAMS_RANGE] streams_to_memory   ;

  assign streams_from_memory         =   ( source_is_memory      ) ? num_of_src_streams : 
                                                                     2'd0  ;
  assign streams_to_memory           =   ( destination_is_memory ) ? num_of_dest_streams : 
                                                                     2'd0  ;
  */

  //------------------------------------------------------------
  //
  // State register 
  //

  wire dma__memc__read_valid0     ;
  wire dma__memc__write_valid0    ;  // valid only accepted by memory controller if pause is deasserted
  wire dma__memc__read_pause0     ;  // read requests ignored

  wire strm_complete0             ;

  wire strm_first_read0           ;
  wire strm_last_read0            ;
  wire strm0_read_enable          ;

  wire strm0_write_enable         ;

  wire dma__memc__read_valid1     ;
  wire dma__memc__write_valid1    ;
  wire dma__memc__read_pause1     ;

  wire strm_complete1             ;

  wire strm_first_read1           ;
  wire strm_last_read1            ;
  wire strm1_read_enable          ;

  wire strm1_write_enable         ;

  // indicators to main streaming controller
  wire strm0_read_complete        ;
  wire strm0_read_ready           ;

  wire strm0_write_complete       ;
  wire strm0_write_ready          ;

  wire strm1_read_complete        ;
  wire strm1_read_ready           ;

  wire strm1_write_complete       ;
  wire strm1_write_ready          ;


  // We use the number of types to create a count of the number of memory
  // words we need to read. This value is type_count_init
  // We also determine how many types are contained in the last read
  // e.g. In the case of 32 bit wide memory, if we want 64 bytes, then we need to read
  // 16 words, if we need 65 bytes we read 17 words and only need one byte in
  // the last access.
  wire [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]  num_of_types0            ;
  wire [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]  num_of_types1            ;

  // Input FIFO from stOp
  wire                                        strm0_from_stOp_fifo_empty           ; 
  wire                                        strm0_from_stOp_fifo_almost_full     ; 
  wire [`STREAMING_OP_DATA_RANGE      ]       strm0_from_stOp_fifo_read_data       ; 
  wire [`DMA_CONT_STRM_CNTL_RANGE     ]       strm0_from_stOp_fifo_read_cntl       ; 

  wire                                        strm1_from_stOp_fifo_empty           ; 
  wire                                        strm1_from_stOp_fifo_almost_full     ; 
  wire [`STREAMING_OP_DATA_RANGE      ]       strm1_from_stOp_fifo_read_data       ; 
  wire [`DMA_CONT_STRM_CNTL_RANGE     ]       strm1_from_stOp_fifo_read_cntl       ; 


  //---------------------------------------------------------------------------
  //---------------------------------------------------------------------------
  // Stream(s)
  // The stream logic manages the addresses to/from memory.
  // Two streams for two arguments to streaming operation function.
  // If the operation is streaming from memory, this logic sets up the initial
  // pointer and then increments the read address until the correct number of
  // types have been read. 
  // If the stream is to memory, again, the initial write pointer is set and then 
  // incremented until the correct number of "types" have been written to memory.
  //
  // This logic does not control arbitration between the arguments being read
  // from memory and the result being written back. The datapath associated
  // with the result are refered to as the "result"
  //
  // Options
  // a) Streaming from Memory with result to memory
  //     - one or two streams
  //     - read address and number of types configured from cntl
  //     - continue reads until we have hit the number of types
  //     - for writing, the result address is configured from cntl
  //     - Writes continue to until EOP received from stOp
  //
  // b) Streaming from Memory with result to register
  //     - one or two streams
  //     - read address and number of types configured from cntl
  //     - no write to memory
  //
  // c) Streaming to Memory
  //     - one stream
  //     - write address configured from cntl
  //     - writes continue until EOP
  //     - no reading from memory
  //

  //---------------------------------------------------------------------------
  // Read Stream(s)
  //
  genvar gvi;
  generate
    for (gvi=0; gvi<2; gvi=gvi+1) 
      begin: read_strm

        wire                                        enable                    ;

        wire                                        ready                     ; // memc ready to accept read request from the stream
        reg  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  address                   ;
        wire [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  address_next              ; 
        reg                                         valid                     ; // read request valid, goto next request only if memc is ready
        wire                                        valid_next                ; // Valid kept asserted until we have completed number of types
        wire                                        to_stOp_valid             ;
                                                                                   
        wire [`DMA_CONT_STRM_ADDRESS_RANGE]         start_address             ; 
        reg  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]    type_read_count           ;  // dont need a count for write as it uses EOP from the FIFO
        reg                                         complete                  ;
        wire                                        complete_next             ;
        reg                                         completed_last_read       ;  // the last transaction contains a partially used word
        wire                                        completed_last_read_next  ; 
        wire [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]    type_count_init           ;
        wire [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]    types_in_last_data        ;
        reg                                         first_read_d1             ;  // the last transaction 
        wire                                        first_read_next           ; 
        wire                                        first_read                ; 
        reg                                         last_read                 ;  // the last transaction 
        wire                                        last_read_next            ; 

        assign address_next  =  ( ~enable              )  ? start_address : 
                                (  valid && ready      )  ? address + 1   : 
                                                            address       ;
                                                                                                                
        assign valid_next    =  enable &  ((~complete_next & ~complete) | (~completed_last_read_next & ~completed_last_read));
   
        // outputs 
        always @(posedge clk)
          begin
            address     <= ( reset_poweron ) ? 'd0  : address_next  ;
            valid       <= ( reset_poweron ) ? 'd0  : valid_next    ;
          end
        always @(posedge clk)
          begin
            // Keep track of number of transactions for each stream. 

            type_read_count       <=  (  reset_poweron                  ) ? 'd0                   : 
                                      ( ~enable                         ) ? type_count_init       :
                                      (  valid  && ready   && ~complete ) ? type_read_count-1     :
                                                                            type_read_count       ;

            complete              <= ( reset_poweron       ) ? 1'b0                      :
                                     (~enable              ) ? 1'b0                      :
                                     ( complete            ) ? 1'b1                      :
                                                               complete_next             ;
                                                                                         
            completed_last_read   <= ( reset_poweron       ) ? 'd0                       : 
                                     (~enable              ) ? 1'b0                      :
                                     ( completed_last_read ) ? 1'b1                      :
                                                               completed_last_read_next  ;
            first_read_d1         <= ( reset_poweron       ) ? 1'b1                      : 
                                     (~enable              ) ? 1'b1                      :
                                     ( ~first_read         ) ? 1'b0                      :
                                                               first_read_next           ;
            last_read             <= ( reset_poweron       ) ? 'd0                       : 
                                     (~enable              ) ? 1'b0                      :
                                     ( last_read           ) ? 1'b1                      :
                                                               last_read_next            ;

          end

          assign complete_next            = ( enable ) & (ready  & valid  & (type_read_count == 'd1)) |  (type_read_count == 'd0) ;
          // extend the number of reads or writes by one if there is residue in the last read/write
          assign completed_last_read_next = ( enable ) & (((complete & valid & ready ) & (types_in_last_data != 'd0)) | (types_in_last_data == 'd0)) ;
          assign first_read_next          = ( enable ) & ~to_stOp_valid    ;  // FIFO interface so as soon as valid to stOp is asserted thats the first transaction
          assign first_read               = first_read_d1 & first_read_next;
          assign last_read_next           = ( enable ) & (~(~complete_next | ~completed_last_read_next)) ;


      end
  endgenerate

  // Stream 0
  assign read_strm[0].enable                   = strm0_read_enable                    ;
  assign read_strm[0].ready                    = memc__dma__read_ready0               ;
  assign read_strm[0].start_address            = strm0_read_start_address             ;
  assign read_strm[0].type_count_init          = strm_type_info[0].type_count_init    ;
  assign read_strm[0].types_in_last_data       = strm_type_info[0].types_in_last_data ;
  assign read_strm[0].to_stOp_valid            = dma__stOp__strm0_data_valid          ;
  assign strm0_read_complete                   = read_strm[0].complete                ;

  assign strm_first_read0                      = read_strm[0].first_read              ;
  assign strm_last_read0                       = read_strm[0].last_read               ;

  // Stream 1
  assign read_strm[1].enable                   = strm1_read_enable                    ;
  assign read_strm[1].ready                    = memc__dma__read_ready1               ;
  assign read_strm[1].start_address            = strm1_read_start_address             ;
  assign read_strm[1].type_count_init          = strm_type_info[1].type_count_init    ;
  assign read_strm[1].types_in_last_data       = strm_type_info[1].types_in_last_data ;
  assign read_strm[1].to_stOp_valid            = dma__stOp__strm1_data_valid          ;
  assign strm1_read_complete                   = read_strm[1].complete                ;

  assign strm_first_read1                      = read_strm[1].first_read              ;
  assign strm_last_read1                       = read_strm[1].last_read               ;
                                               

  //---------------------------------------------------------------------------
  // Write Stream(s)
  //
  generate
    for (gvi=0; gvi<2; gvi=gvi+1) 
      begin: write_strm

        wire                                        enable                    ;

                                                                         
        wire                                        ready                     ; // memc ready to accept write request from the stream
        reg  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  address                   ;
        wire [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  address_next              ; 
        wire                                        data_available            ; 
        wire                                        valid                     ; 
        wire                                        valid_next                ; 
                                                                                   
        wire [`DMA_CONT_STRM_ADDRESS_RANGE]         start_address             ;
        reg                                         complete                  ;
        wire                                        complete_next             ;
        reg                                         completed_last_write      ;  // the last transaction contains a partially used word
        wire                                        completed_last_write_next ;   // FIXME - just use EOP to complete??
        reg                                         last_write                ;  // the last transaction 
        wire                                        last_write_next           ;   // FIXME - just use EOP to complete??
        wire [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]    types_in_last_data        ;
        wire                                        last_write_transaction    ; // use EOP from stOp to indicate last write

                                                                                                                
        assign address_next  =  ( ~enable              )  ? start_address : 
                                (  valid && ready      )  ? address + 1   : 
                                                            address       ;
   
        // when writing, we always write if there is data available in the FIFO and memc is ready (we always write complete words so ignore mask)
        // So set valid and only transition to next data when erady has been asserted
        //assign valid_next    =   enable & data_available ;
        assign valid=   enable & data_available ;
   
        // outputs 
        always @(posedge clk)
          begin
            address    <= ( reset_poweron ) ? 'd0  : address_next ;
//            valid      <= ( reset_poweron ) ? 'b0  : valid_next & ~complete_next   ;
          end
        always @(posedge clk)
          begin
            // Keep track of number of transactions for each stream. 

            complete              <= ( reset_poweron       ) ? 1'd0           :
                                     (~enable              ) ? 1'b0           :
                                     ( complete            ) ? 1'b1           :
                                                               complete_next  ;
                                                                                         
            completed_last_write  <= ( reset_poweron       ) ? 'd0                       : 
                                     (~enable              ) ? 1'b1                      :
                                     ( completed_last_write) ? 1'b1                      :
                                                               completed_last_write_next ;
            last_write            <= ( reset_poweron       ) ? 'd0                       : 
                                     (~enable              ) ? 1'b1                      :
                                     ( last_write          ) ? 1'b1                      :
                                                               last_write_next           ;

          end

         // writes always complete on an EOP 
          assign complete_next  = ready & last_write_transaction ;  // last write transaction is EOP

          // extend the number of reads or writes by one if there is residue in the last read/write
          assign completed_last_write_next = ( enable ) & (((complete & valid & ready ) & (types_in_last_data != 'd0)) | (types_in_last_data == 'd0)) ;
          assign last_write_next           = ( enable ) & (~(~complete_next | ~completed_last_write_next)) ;

      end
  endgenerate

  // Stream 0
  assign write_strm[0].enable                  =  strm0_write_enable ;
  assign write_strm[0].ready                   = memc__dma__write_ready0              ;
  assign write_strm[0].start_address           = strm0_write_start_address            ;
  assign write_strm[0].data_available          = ~strm0_from_stOp_fifo_empty          ;
  assign write_strm[0].types_in_last_data      = strm_type_info[0].types_in_last_data ;
  assign write_strm[0].last_write_transaction  = ~strm0_from_stOp_fifo_empty & 
                                                ((strm0_from_stOp_fifo_read_cntl ==  `DMA_CONT_STRM_CNTL_EOP) | (strm0_from_stOp_fifo_read_cntl ==  `DMA_CONT_STRM_CNTL_SOP_EOP))  ;
  assign strm0_write_complete                  = write_strm[0].complete               ;

  // Stream 1
  assign write_strm[1].enable                  =  strm1_write_enable ;
  assign write_strm[1].ready                   = memc__dma__write_ready1              ;
  assign write_strm[1].start_address           = strm1_write_start_address            ;
  assign write_strm[1].data_available          = ~strm1_from_stOp_fifo_empty          ;
  assign write_strm[1].types_in_last_data      = strm_type_info[1].types_in_last_data ;
  assign write_strm[1].last_write_transaction  = ~strm1_from_stOp_fifo_empty & 
                                                ((strm1_from_stOp_fifo_read_cntl ==  `DMA_CONT_STRM_CNTL_EOP) | (strm1_from_stOp_fifo_read_cntl ==  `DMA_CONT_STRM_CNTL_SOP_EOP))  ;
  assign strm1_write_complete                  = write_strm[1].complete               ;

  // FIXME: add interrupt if last transaction and fifo not empty
  //

  //-------------------------------------------------------------------------------------------
  // Aggregate Stream signals
  //   - performed externally if we split into dma_read_cont and dma_write_cont with each 
  //     controlling a single stream
  //
  assign strm_complete0                        = (~strm0_read_enable | read_strm[0].complete) & (~strm0_write_enable | write_strm[0].complete) ;

  assign strm_complete1                        = (~strm1_read_enable | read_strm[1].complete) & (~strm1_write_enable | write_strm[1].complete) ;

  wire   strm_complete                         = strm_complete0 & strm_complete1      ;
                                       
  //-------------------------------------------------------------------------------------------

  //-------------------------------------------------------------------------------------------
  // MEMC Interface
  //
  // If operation is streaming from memory, then result will be "writing" etc.
  //
  // memc read interface
  // Stream 0
  assign dma__memc__read_valid0     = read_strm[0].valid   ;
  assign dma__memc__read_address0   = read_strm[0].address ;

  // Stream 1
  assign dma__memc__read_valid1     = read_strm[1].valid   ;
  assign dma__memc__read_address1   = read_strm[1].address ;

  // memc Write interface
  // Stream 0
  assign dma__memc__write_valid0    = write_strm[0].valid             ;
  assign dma__memc__write_address0  = write_strm[0].address           ;
  assign dma__memc__write_data0     = strm0_from_stOp_fifo_read_data  ;

  // Stream 1
  assign dma__memc__write_address1  = write_strm[1].address           ;
  assign dma__memc__write_valid1    = write_strm[1].valid             ;
  assign dma__memc__write_data1     = strm1_from_stOp_fifo_read_data  ;
   
  //
  //-------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------
  // DMA  Main Control FSM
  //



  //-------------------------------------------------------------------------------------------------
  // internal signals

  // type information
  generate
    for (gvi=0; gvi<2; gvi=gvi+1) 
      begin: strm_type_info

        wire [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]  num_of_types             ;
        wire [`DMA_CONT_DATA_TYPES_RANGE       ]  typee                    ;
        reg  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]  type_count_init          ;
        reg  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]  types_in_last_data       ;
        reg  [`DMA_CONT_MAX_NUM_OF_TYPES_RANGE ]  types_in_last_data_next  ;

        always @(*)
          casex (typee)
            `DMA_CONT_DATA_TYPE_BIT       : type_count_init  = (num_of_types >> `DMA_CONT_BIT_ADDRESS_SHIFT    ) ;
            `DMA_CONT_DATA_TYPE_NIBBLE    : type_count_init  = (num_of_types >> `DMA_CONT_NIBBLE_ADDRESS_SHIFT ) ;
            `DMA_CONT_DATA_TYPE_BYTE      : type_count_init  = (num_of_types >> `DMA_CONT_BYTE_ADDRESS_SHIFT   ) ;
            `DMA_CONT_DATA_TYPE_SWORD     : type_count_init  = (num_of_types >> `DMA_CONT_SWORD_ADDRESS_SHIFT  ) ;
            `DMA_CONT_DATA_TYPE_WORD      : type_count_init  = (num_of_types >> `DMA_CONT_WORD_ADDRESS_SHIFT   ) ;
            default                       : type_count_init  = (num_of_types >> `DMA_CONT_WORD_ADDRESS_SHIFT   ) ;
          endcase // always @
   
        always @(*)
          casex (typee)
            `DMA_CONT_DATA_TYPE_BIT       : types_in_last_data_next  = num_of_types[`DMA_CONT_BIT_ADDRESS_SHIFT     -1 :0];
            `DMA_CONT_DATA_TYPE_NIBBLE    : types_in_last_data_next  = num_of_types[`DMA_CONT_NIBBLE_ADDRESS_SHIFT  -1 :0];
            `DMA_CONT_DATA_TYPE_BYTE      : types_in_last_data_next  = num_of_types[`DMA_CONT_BYTE_ADDRESS_SHIFT    -1 :0];
            `DMA_CONT_DATA_TYPE_SWORD     : types_in_last_data_next  = num_of_types[`DMA_CONT_SWORD_ADDRESS_SHIFT   -1 :0];
            `DMA_CONT_DATA_TYPE_WORD      : types_in_last_data_next  =                                               'd0 ;
            default                       : types_in_last_data_next  =                                               'd0 ;
          endcase // always @
   
        // FIXME: need to multicycle path
        // Is there a better way to create mask bits
        //   - Use "for" loop??
        //   FIXME - assumed 32 bit bus
        reg [`DMA_CONT_MEMORY_DATA_RANGE] mask;
        
        always @(*)
          casex (typee)
            `DMA_CONT_DATA_TYPE_BIT       : 
              begin
                casex (types_in_last_data)
                  1  : mask = {{31{1'b0}}, { 1{1'b1}}};
                  1  : mask = {{31{1'b0}}, { 1{1'b1}}};
                  2  : mask = {{30{1'b0}}, { 2{1'b1}}};
                  3  : mask = {{29{1'b0}}, { 3{1'b1}}};
                  4  : mask = {{28{1'b0}}, { 4{1'b1}}};
                  5  : mask = {{27{1'b0}}, { 5{1'b1}}};
                  6  : mask = {{26{1'b0}}, { 6{1'b1}}};
                  7  : mask = {{25{1'b0}}, { 7{1'b1}}};
                  8  : mask = {{24{1'b0}}, { 8{1'b1}}};
                  9  : mask = {{23{1'b0}}, { 9{1'b1}}};
                  10 : mask = {{22{1'b0}}, {10{1'b1}}};
                  11 : mask = {{21{1'b0}}, {11{1'b1}}};
                  12 : mask = {{20{1'b0}}, {12{1'b1}}};
                  13 : mask = {{19{1'b0}}, {13{1'b1}}};
                  14 : mask = {{18{1'b0}}, {14{1'b1}}};
                  15 : mask = {{17{1'b0}}, {15{1'b1}}};
                  16 : mask = {{16{1'b0}}, {16{1'b1}}};
                  17 : mask = {{15{1'b0}}, {17{1'b1}}};
                  18 : mask = {{14{1'b0}}, {18{1'b1}}};
                  19 : mask = {{13{1'b0}}, {19{1'b1}}};
                  20 : mask = {{12{1'b0}}, {20{1'b1}}};
                  21 : mask = {{11{1'b0}}, {21{1'b1}}};
                  22 : mask = {{10{1'b0}}, {22{1'b1}}};
                  23 : mask = {{ 9{1'b0}}, {23{1'b1}}};
                  24 : mask = {{ 8{1'b0}}, {24{1'b1}}};
                  25 : mask = {{ 7{1'b0}}, {25{1'b1}}};
                  26 : mask = {{ 6{1'b0}}, {26{1'b1}}};
                  27 : mask = {{ 5{1'b0}}, {27{1'b1}}};
                  28 : mask = {{ 4{1'b0}}, {28{1'b1}}};
                  29 : mask = {{ 3{1'b0}}, {29{1'b1}}};
                  30 : mask = {{ 2{1'b0}}, {30{1'b1}}};
                  31 : mask = {{ 1{1'b0}}, {31{1'b1}}};
                  default : mask = {32{1'b1}};
                endcase
              end
            `DMA_CONT_DATA_TYPE_NIBBLE       : 
              begin
                casex (types_in_last_data)
                  1  : mask = {{28{1'b0}}, { 4{1'b1}}};
                  2  : mask = {{24{1'b0}}, { 8{1'b1}}};
                  3  : mask = {{20{1'b0}}, {12{1'b1}}};
                  4  : mask = {{16{1'b0}}, {16{1'b1}}};
                  5  : mask = {{12{1'b0}}, {20{1'b1}}};
                  6  : mask = {{ 8{1'b0}}, {24{1'b1}}};
                  7  : mask = {{ 4{1'b0}}, {28{1'b1}}};
                  default : mask = {32{1'b1}};
                endcase
              end
            `DMA_CONT_DATA_TYPE_BYTE       : 
              begin
                casex (types_in_last_data)
                  1  : mask = {{24{1'b0}}, { 8{1'b1}}};
                  2  : mask = {{16{1'b0}}, {16{1'b1}}};
                  3  : mask = {{ 8{1'b0}}, {24{1'b1}}};
                  default : mask = {32{1'b1}};
                endcase
              end
            `DMA_CONT_DATA_TYPE_SWORD       : 
              begin
                casex (types_in_last_data)
                  1  : mask = {{16{1'b0}}, {16{1'b1}}};
                  default : mask = {32{1'b1}};
                endcase
              end
              default : mask = {32{1'b1}};
          endcase // always @
   
   
        always @(posedge clk)
          begin
            types_in_last_data   <= ( reset_poweron ) ? 'd0  : types_in_last_data_next  ;
          end
   
      end
  endgenerate

  assign strm_type_info[0].typee        = type0;
  assign strm_type_info[0].num_of_types = num_of_types0;

  assign strm_type_info[1].typee        = type1;
  assign strm_type_info[1].num_of_types = num_of_types1;

  //-------------------------------------------------------------------------------------------------
  // output equations
  //


  // Stream 0
  wire   stOp__dma__strm0_ready       ;
  assign dma__memc__read_pause0   =  ~stOp__dma__strm0_ready  ;

  assign strm0_read_ready  = strm0_read_enable ;  // FIXME
  assign strm0_write_ready = strm0_write_enable;

  // Stream 1
  wire   stOp__dma__strm1_ready       ;
  assign dma__memc__read_pause1   =  ~stOp__dma__strm1_ready  ;

  assign strm1_read_ready  = strm1_read_enable ;
  assign strm1_write_ready = strm1_write_enable;


  //-------------------------------------------------------------------------------------------------
  //Streaming Op interface(s)
  //
  // to stOp
  //  - matched with read DMA
  //  - assume two paths for now
  //
  //

  //-----------------------
  // Stream 0
  reg  [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm0_cntl           ; 
  reg  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data           ; 
  reg  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm0_data_mask      ; 
  reg                                         dma__stOp__strm0_data_valid     ; 

  always @(posedge clk)
    begin
      dma__stOp__strm0_cntl        <= ( reset_poweron                       ) ? 'd0                           : 
                                      ( strm_first_read0 && strm_last_read0 ) ? 'd`DMA_CONT_STRM_CNTL_SOP_EOP :
                                      ( strm_first_read0                    ) ? 'd`DMA_CONT_STRM_CNTL_SOP     :
                                      ( strm_last_read0                     ) ? 'd`DMA_CONT_STRM_CNTL_EOP     :
                                                                                'd0                           ; 

      dma__stOp__strm0_data        <= ( reset_poweron      ) ? 'd0  : memc__dma__read_data0 ; 

      dma__stOp__strm0_data_mask   <= ( reset_poweron      ) ? 'd0                          : 
                                      ( strm_last_read0    ) ?  strm_type_info[0].mask      :
                                                                32'hFFFF_FFFF               ; 

      dma__stOp__strm0_data_valid  <= ( reset_poweron      ) ? 'd0                          : 
                                                                memc__dma__read_data_valid0 ; 
    end

  //-----------------------
  // Stream 1
  reg  [`DMA_CONT_STRM_CNTL_RANGE     ]       dma__stOp__strm1_cntl           ; 
  reg  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data           ; 
  reg  [`STREAMING_OP_DATA_RANGE      ]       dma__stOp__strm1_data_mask      ; 
  reg                                         dma__stOp__strm1_data_valid     ; 

  always @(posedge clk)
    begin
      dma__stOp__strm1_cntl        <= ( reset_poweron                       ) ? 'd0                           : 
                                      ( strm_first_read1 && strm_last_read1 ) ? 'd`DMA_CONT_STRM_CNTL_SOP_EOP :
                                      ( strm_first_read1                    ) ? 'd`DMA_CONT_STRM_CNTL_SOP     :
                                      ( strm_last_read1                     ) ? 'd`DMA_CONT_STRM_CNTL_EOP     :
                                                                                'd0                           ; 

      dma__stOp__strm1_data        <= ( reset_poweron      ) ? 'd0                          :
                                                                memc__dma__read_data1       ; 

      dma__stOp__strm1_data_mask   <= ( reset_poweron      ) ? 'd0                          : 
                                      ( strm_last_read1    ) ?  strm_type_info[1].mask      :
                                                                32'hFFFF_FFFF               ; 

      dma__stOp__strm1_data_valid  <= ( reset_poweron      ) ? 'd0                          : 
                                                                memc__dma__read_data_valid1 ; 
      
    end

  //-----------------------
  // from stOp
  //  - matched with write DMA
  //  - assume two paths for now
  
  generate
    for (gvi=0; gvi<2; gvi=gvi+1) 
      begin: from_stOp_fifo
        `STREAMING_OP_INPUT_FIFO
      end
  endgenerate

  //-----------------------
  // Stream 0
  assign  from_stOp_fifo[0].clear              = ~strm0_write_enable                ;  // FIFO is from stOp to memory, so clear using write enable
  assign  strm0_from_stOp_fifo_empty           = from_stOp_fifo[0].fifo_empty       ; 
  assign  strm0_from_stOp_fifo_almost_full     = from_stOp_fifo[0].fifo_almost_full ; 
  assign  from_stOp_fifo[0].fifo_read          = ~strm0_from_stOp_fifo_empty & memc__dma__write_ready0;  // FIFO feeds write stream 0 into memory controller
  assign  strm0_from_stOp_fifo_read_data       = from_stOp_fifo[0].fifo_read_data   ; 
  assign  strm0_from_stOp_fifo_read_cntl       = from_stOp_fifo[0].fifo_read_cntl   ; 
  assign  from_stOp_fifo[0].data               = stOp__dma__strm0_data              ;
  assign  from_stOp_fifo[0].cntl               = stOp__dma__strm0_cntl              ;
  assign  from_stOp_fifo[0].fifo_write         = stOp__dma__strm0_data_valid        ;
                                              
  //-----------------------
  // Stream 1
  assign  from_stOp_fifo[1].clear              = ~strm1_write_enable                ;
  assign  strm1_from_stOp_fifo_empty           = from_stOp_fifo[1].fifo_empty       ; 
  assign  strm1_from_stOp_fifo_almost_full     = from_stOp_fifo[1].fifo_almost_full ; 
  assign  from_stOp_fifo[1].fifo_read          = ~strm1_from_stOp_fifo_empty & memc__dma__write_ready1;  // FIFO feeds write stream 0 into memory controller
  assign  strm1_from_stOp_fifo_read_data       = from_stOp_fifo[1].fifo_read_data   ; 
  assign  strm1_from_stOp_fifo_read_cntl       = from_stOp_fifo[1].fifo_read_cntl   ; 
  assign  from_stOp_fifo[1].data               = stOp__dma__strm1_data              ;
  assign  from_stOp_fifo[1].cntl               = stOp__dma__strm1_cntl              ;
  assign  from_stOp_fifo[1].fifo_write         = stOp__dma__strm1_data_valid        ;

  // Flow control to stOp interface
  assign    dma__stOp__strm0_ready   =  ~strm0_from_stOp_fifo_almost_full ;
  assign    dma__stOp__strm1_ready   =  ~strm1_from_stOp_fifo_almost_full ;

  //-------------------------------------------------------------------------------------------------

endmodule

