/*********************************************************************************************

    File name   : mmc_final_queue.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

    Description : Based on Generic pipelined FIFO 

                  The main memory control final queue needs to peek into the fifo 

*********************************************************************************************/
    
// Usage: mmc_final_queue #(.GENERIC_FIFO_DEPTH      ( 8), 
//                          .GENERIC_FIFO_DATA_WIDTH (32),
//                          .GENERIC_FIFO_THRESHOLD  (32)
//                           ) name_of_fifo( ..... );

`include "common.vh"

`timescale 1ns/10ps


module mmc_final_queue #(parameter GENERIC_FIFO_DEPTH       = 8   ,
                         parameter GENERIC_FIFO_THRESHOLD   = 32  ,
                         parameter GENERIC_FIFO_DATA_WIDTH  = 4   ,
                         localparam GENERIC_FIFO_ADDR_WIDTH = $clog2(GENERIC_FIFO_DEPTH))
                 (

          //---------------------------------------------------------------
          // General
          input   wire                       clk            ,
          input   wire                       reset_poweron  ,
          input   wire                       clear          ,
          
          //---------------------------------------------------------------
          // Input
          input   wire                                      write        , 
          input   wire  [GENERIC_FIFO_DATA_WIDTH-1 :0  ]    write_data   ,
          
          //---------------------------------------------------------------
          // Output
          input   wire                                      pipe_read             , 
          output  reg                                       pipe_valid            ,
          output  reg                                       pipe_peek_valid       ,
          output  reg                                       pipe_peek_twoIn_valid ,
          output  reg   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]    pipe_peek_data        ,
          output  reg   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]    pipe_peek_twoIn_data  ,
          output  reg   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]    pipe_data             ,
          
          //---------------------------------------------------------------
          // Status
          output  wire                                      almost_full  

             );

  parameter GENERIC_PEEK_DEPTH = 3 ;

  //--------------------------------------------------------
  // FIFO
  //
  wire                                         empty            ; 
  wire                                         read             ; 
  wire   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]      read_data        ;

  generic_fifo #(.GENERIC_FIFO_DEPTH      (GENERIC_FIFO_DEPTH      ),
                 .GENERIC_FIFO_THRESHOLD  (GENERIC_FIFO_THRESHOLD  ),
                 .GENERIC_FIFO_DATA_WIDTH (GENERIC_FIFO_DATA_WIDTH )
                  ) gfifo (
                           // Status
                          .empty            ( empty                 ),
                          .almost_full      ( almost_full           ),
                          .almost_empty     (                       ),
                          .depth            (                       ),
                           // Write                                 
                          .write            ( write                 ),
                          .write_data       ( write_data            ),
                           // Read                                  
                          .read             ( read                  ),
                          .read_data        ( read_data             ),

                          // General
                          .clear            ( clear                 ),
                          .reset_poweron    ( reset_poweron         ),
                          .clk              ( clk                   )
                          );
/*
  always @(posedge clk)
    begin
      geTwo <= ( reset_poweron                    ) ? 1'b0  :
               ( clear                            ) ? 1'b0  :
               (  read & ~write && (depth == 'd2) ) ? 1'b0  :
               ( ~read &  write && (depth == 'd1) ) ? 1'b1  :
                                                      geTwo ;
    end
*/
  
  //--------------------------------------------------------
  // Output pipeline
  //

  // Note: First stage of pipeline is inside FIFO
  // fifo output stage
  reg                                         fifo_pipe_valid   ;
  wire                                        fifo_pipe_read    ;
  // pipe stage is defined in port declaration

  // Isolate the pipe_read from the memory control to avoid long delays from output control from fsm's etc. to memory/ME
  // employ a double buffer to allow the valid to be registered backward
  reg   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]      pipe_b1_data        ;
  reg   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]      pipe_b0_data        ;
  reg                                         pipe_b1_valid       ;
  reg                                         pipe_b0_valid       ;
  reg                                         pipe_b1_available   ;
  reg                                         pipe_b0_available   ;
  reg                                         pipe_buffer_read    ;
  reg                                         buffer_write_select ;  // toggle between writing to buffers
  reg                                         buffer_read_select  ;  // toggle between reading from buffers

  // fifo output stage
  // Note: First stage of pipeline is inside FIFO
  // fifo data is available after the read
  always @(posedge clk)
    begin
      fifo_pipe_valid <= ( reset_poweron      ) ? 'b0               :
                         ( read               ) ? 'b1               :
                         ( fifo_pipe_read     ) ? 'b0               :
                                                   fifo_pipe_valid  ;
    end

  assign read           = ~empty          & (~fifo_pipe_valid | fifo_pipe_read) ; // keep the pipe charged
  assign fifo_pipe_read = fifo_pipe_valid & ((pipe_b0_available & (buffer_write_select == 1'b0)) | (pipe_b1_available & (buffer_write_select == 1'b1))) ;


  always @(posedge clk)
    begin
      buffer_write_select <= ( reset_poweron       ) ? 'b0                  :
                             ( fifo_pipe_read      ) ? ~buffer_write_select :
                                                        buffer_write_select ;

      buffer_read_select <=  ( reset_poweron       ) ? 'b0                  :
                             ( pipe_buffer_read    ) ? ~buffer_read_select  :
                                                        buffer_read_select  ;

      pipe_b0_valid      <=  ( reset_poweron                                    ) ? 1'b0           :
                             ( fifo_pipe_read   && (buffer_write_select == 1'b0)) ? 1'b1           :
                             ( pipe_buffer_read && (buffer_read_select  == 1'b0)) ? 1'b0           :
                                                                                    pipe_b0_valid  ;

      pipe_b1_valid      <=  ( reset_poweron                                    ) ? 1'b0           :
                             ( fifo_pipe_read   && (buffer_write_select == 1'b1)) ? 1'b1           :
                             ( pipe_buffer_read && (buffer_read_select  == 1'b1)) ? 1'b0           :
                                                                                    pipe_b1_valid  ;

      pipe_b0_available  <=  ( reset_poweron                                    ) ? 1'b0           :
                             ( pipe_buffer_read && (buffer_read_select  == 1'b0)) ? 1'b1           :
                                                                                    ~pipe_b0_valid ;

      pipe_b1_available  <=  ( reset_poweron                                    ) ? 1'b0           :
                             ( pipe_buffer_read && (buffer_read_select  == 1'b1)) ? 1'b1           :
                                                                                    ~pipe_b1_valid ;

      pipe_b0_data       <=  ( reset_poweron                                  ) ?  'd0           :
                             ( fifo_pipe_read && (buffer_write_select == 1'b0)) ? read_data      :
                                                                                  pipe_b0_data   ;

      pipe_b1_data       <=  ( reset_poweron                                  ) ?  'd0           :
                             ( fifo_pipe_read && (buffer_write_select == 1'b1)) ? read_data      :
                                                                                  pipe_b1_data   ;
    end

  reg   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]    int_pipe_data       [GENERIC_PEEK_DEPTH] ;
  reg   [GENERIC_PEEK_DEPTH-1 :0       ]    int_pipe_valid                           ;
  reg   [GENERIC_PEEK_DEPTH-1 :0       ]    int_pipe_read                            ;

  assign pipe_buffer_read = ((pipe_b0_valid & (buffer_read_select == 1'b0)) | (pipe_b1_valid & (buffer_read_select == 1'b1))) & (~int_pipe_valid [0] | int_pipe_read [0] ) ; 

  genvar gvi ;
  generate
    for (gvi=0; gvi<GENERIC_PEEK_DEPTH-1; gvi++)
      begin
        always @(*)
          begin
            int_pipe_read [gvi] = int_pipe_valid [gvi] & (~int_pipe_valid [gvi+1] | int_pipe_read [gvi+1]) ;
          end
      end
  endgenerate

  always @(*)
    begin
      int_pipe_read [GENERIC_PEEK_DEPTH-1] = pipe_read ;
    end

  generate
    for (gvi=0; gvi<GENERIC_PEEK_DEPTH; gvi++)
      begin
        always @(posedge clk)
          begin
          if (gvi == 0)
            begin
              int_pipe_valid [gvi]  <= ( reset_poweron       ) ? 'b0                  :
                                       ( pipe_buffer_read    ) ? 'b1                  :
                                       ( int_pipe_read [gvi] ) ? 'b0                  :
                                                                 int_pipe_valid [gvi] ;
              
              int_pipe_data [gvi]   <= ( pipe_buffer_read && (buffer_read_select == 1'b0)) ? pipe_b0_data        :
                                       ( pipe_buffer_read && (buffer_read_select == 1'b1)) ? pipe_b1_data        :
                                                                                             int_pipe_data [gvi] ;
            end
          else
            begin
              int_pipe_valid [gvi]  <= ( reset_poweron         ) ? 'b0                   :
                                       ( int_pipe_read [gvi-1] ) ? 'b1                   :
                                       ( int_pipe_read [gvi]   ) ? 'b0                   :
                                                                    int_pipe_valid [gvi] ;
              
              int_pipe_data  [gvi]  <= ( reset_poweron         ) ? 'd0                   :
                                       ( int_pipe_read [gvi-1] ) ? int_pipe_data [gvi-1] :
                                                                   int_pipe_data [gvi]   ;
            end
          end
    end
  endgenerate

  always @(*)
    begin
      pipe_valid            = int_pipe_valid [GENERIC_PEEK_DEPTH-1] ;
      pipe_data             = int_pipe_data  [GENERIC_PEEK_DEPTH-1] ;
      pipe_peek_valid       = int_pipe_valid [GENERIC_PEEK_DEPTH-2] ;
      pipe_peek_data        = int_pipe_data  [GENERIC_PEEK_DEPTH-2] ;
      pipe_peek_twoIn_valid = int_pipe_valid [GENERIC_PEEK_DEPTH-3] ;
      pipe_peek_twoIn_data  = int_pipe_data  [GENERIC_PEEK_DEPTH-3] ;
    end
    
  
endmodule
