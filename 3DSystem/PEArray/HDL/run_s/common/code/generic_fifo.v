/*********************************************************************************************

    File name   : generic_fifo.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : Generic FIFO (from cortical project define-based fifo)

*********************************************************************************************/
    
// Usage: generic_fifo #(.GENERIC_FIFO_DEPTH      ( 8), 
//                       .GENERIC_FIFO_DATA_WIDTH (32),
//                       .GENERIC_FIFO_THRESHOLD  (32)
//                        ) name_of_fifo( ..... );

`include "common.vh"
`include "pe_array.vh"

`timescale 1ns/10ps


module generic_fifo #(parameter GENERIC_FIFO_DEPTH       = 8   ,
                      parameter GENERIC_FIFO_THRESHOLD   = 32  ,
                      parameter GENERIC_FIFO_DATA_WIDTH  = 4   )
                 (

          //---------------------------------------------------------------
          // General
          input   wire                       clk            ,
          input   wire                       reset_poweron  ,
          input   wire                       clear          ,
          
          
          //---------------------------------------------------------------
          // Input
          input   wire                                      write       , 
          input   wire  [GENERIC_FIFO_DATA_WIDTH-1 :0  ]    write_data  ,
          
          //---------------------------------------------------------------
          // Output
          input   wire                                      read        , 
          output  reg   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]    read_data   ,
          
          //---------------------------------------------------------------
          // Status
          output  wire                                      empty       , 
          output  wire                                      almost_full         

             );

/*
  parameter GENERIC_FIFO_DEPTH            = 8                          ;
  parameter GENERIC_FIFO_DATA_WIDTH       = 32                         ;
  parameter GENERIC_FIFO_THRESHOLD        = 4                          ; 
*/
  // 
  localparam GENERIC_FIFO_ADDR_WIDTH       = $clog2(GENERIC_FIFO_DEPTH) ;



  //--------------------------------------------------------
  // Regs/Wires
  //

  reg  [GENERIC_FIFO_DATA_WIDTH-1 :0  ]       fifo_data     [GENERIC_FIFO_DEPTH-1 :0 ] ;
  reg  [GENERIC_FIFO_ADDR_WIDTH-1 :0  ]       wp                                       ; 
  reg  [GENERIC_FIFO_ADDR_WIDTH-1 :0  ]       rp                                       ; 
  reg  [GENERIC_FIFO_ADDR_WIDTH-1 :0  ]       depth                                    ; 
  //`ifdef TESTING
  reg                                         full                                     ;   // latch the fall condition for debug
  // `endif
  
  always @(posedge clk)
    begin
      wp                 <= ( reset_poweron   ) ? 'd0           : 
                            ( clear           ) ? 'd0           : 
                            ( write           ) ?  wp + 'd1     :
                                                   wp           ;
  
      fifo_data[wp]      <= ( write           ) ? write_data    : 
                                                  fifo_data[wp] ;
  
      rp                 <= ( reset_poweron   ) ? 'd0           : 
                            ( clear           ) ? 'd0           : 
                            ( read            ) ?  rp + 'd1     :
                                                   rp           ;

      depth              <= ( reset_poweron   ) ? 'd0           : 
                            ( clear           ) ? 'd0           : 
                            (  read & ~write  ) ? depth - 'd1   :
                            ( ~read &  write  ) ? depth + 'd1   :
                                                  depth         ;
  
      // latch the exception - FIXME - not a port yet - maybe add port `ifdef TESTING
      full               <= ( reset_poweron || clear        ) ? 1'b0 : 
                            ( depth == GENERIC_FIFO_DEPTH-1 ) ? 1'b1 :
                                                                full ;
  
    end

  //--------------------------------------------------------
  // Registered outputs
  //
  always @(posedge clk)
    begin
      read_data         <= ( read             ) ? fifo_data [rp] : 
                                                  read_data      ;
    end
      
  //--------------------------------------------------------
  // Un-Registered outputs
  //
  assign empty          = (rp == wp)                                             ;
  assign almost_full    = (depth >= (GENERIC_FIFO_DEPTH-GENERIC_FIFO_THRESHOLD)) ;

  //--------------------------------------------------------


endmodule


