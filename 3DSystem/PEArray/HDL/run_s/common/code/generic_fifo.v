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


module generic_fifo (
                  // Write
                  empty             ,
                  almost_full       ,
                  write             ,
                  write_data        ,
                  // Read
                  read              ,
                  read_data         ,

                  // General
                  clk               ,
                  clear             ,
                  reset_poweron     
             );


  parameter GENERIC_FIFO_DEPTH            = 8                          ;
  parameter GENERIC_FIFO_DATA_WIDTH       = 32                         ;
  parameter GENERIC_FIFO_THRESHOLD        = 4                          ; 

  // 
  parameter GENERIC_FIFO_ADDR_WIDTH       = $clog2(GENERIC_FIFO_DEPTH) ;

  input                       clk            ;
  input                       reset_poweron  ;
  input                       clear          ;
  

  //----------------------------------------------------------------------------------------------------
  // Input
  input                                        write                           ; 
  input  [GENERIC_FIFO_DATA_WIDTH-1 :0  ]      write_data                      ;

  //----------------------------------------------------------------------------------------------------
  // Output
  input                                        read                            ; 
  output [GENERIC_FIFO_DATA_WIDTH-1 :0  ]      read_data                       ;

  //----------------------------------------------------------------------------------------------------
  // Status
  output                                       empty                           ; 
  output                                       almost_full                     ; 


  //--------------------------------------------------------
  // Regs/Wires
  //

  reg  [GENERIC_FIFO_DATA_WIDTH-1 :0  ]       fifo_data     [GENERIC_FIFO_DEPTH-1 :0 ] ;
  reg  [GENERIC_FIFO_ADDR_WIDTH-1 :0  ]       wp                                       ; 
  reg  [GENERIC_FIFO_ADDR_WIDTH-1 :0  ]       rp                                       ; 
  reg  [GENERIC_FIFO_ADDR_WIDTH-1 :0  ]       depth                                    ; 
  wire                                        empty                                    ; 
  wire                                        almost_full                              ; 
  wire                                        read                                     ; 
  reg  [GENERIC_FIFO_DATA_WIDTH-1 :0  ]       read_data                                ;
  wire [GENERIC_FIFO_DATA_WIDTH-1 :0  ]       write_data                               ;
  wire                                        write                                    ; 
  
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