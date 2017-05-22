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


module generic_pipelined_fifo #(parameter GENERIC_FIFO_DEPTH       = 8   ,
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
      pipe_valid      <= ( reset_poweron    ) ? 'b0              :
                         ( fifo_pipe_read   ) ? 'b1              :
                         ( pipe_read        ) ? 'b0              :
                                                 pipe_valid      ;
  
      // if we are reading, transfer from previous pipe stage. 
      pipe_data       <= ( fifo_pipe_read   ) ? read_data    :
                                                pipe_data    ;
    end
    
  
endmodule
