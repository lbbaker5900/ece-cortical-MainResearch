/*********************************************************************************************

    File name   : generic_pipelined_fifo.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : Generic pipelined FIFO 

                  Takes care of prereading the memory and outputing valid signal along with data

*********************************************************************************************/
    
// Usage: generic_pipelined_fifo #(.GENERIC_FIFO_DEPTH      ( 8), 
//                       .GENERIC_FIFO_DATA_WIDTH (32),
//                       .GENERIC_FIFO_THRESHOLD  (32)
//                        ) name_of_fifo( ..... );

`include "common.vh"

`timescale 1ns/10ps


module generic_pipelined_fifo 
                              #(parameter GENERIC_FIFO_DEPTH       = 8   ,
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
          output  reg                                       pipe_valid   ,
          input   wire                                      pipe_read    , 
          output  reg   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]    pipe_data    ,
          
          //---------------------------------------------------------------
          // Status
          output  wire                                      almost_full  

             );

  //--------------------------------------------------------
  // Forces synthesis not to elaborate during first read
  // synopsys template

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


  assign pipe_buffer_read = ((pipe_b0_valid & (buffer_read_select == 1'b0)) | (pipe_b1_valid & (buffer_read_select == 1'b1))) & (~pipe_valid | pipe_read ) ; 

  // If we are reading the fifo, then this stage will be valid
  // If we are not reading the fifo but the next stage is reading this stage, then this stage will not be valid
  always @(posedge clk)
    begin
      // If we are reading the previous stage, then this stage will be valid
      // otherwise if we are reading this stage this stage will not be valid
      pipe_valid      <= ( reset_poweron    ) ? 'b0              :
                         ( pipe_buffer_read ) ? 'b1              :
                         ( pipe_read        ) ? 'b0              :
                                                 pipe_valid      ;
  
      // if we are reading, transfer from previous pipe stage. 
      pipe_data       <= ( pipe_buffer_read && (buffer_read_select == 1'b0)) ? pipe_b0_data  :
                         ( pipe_buffer_read && (buffer_read_select == 1'b1)) ? pipe_b1_data  :
                                                                               pipe_data    ;
    end
    
  
endmodule
