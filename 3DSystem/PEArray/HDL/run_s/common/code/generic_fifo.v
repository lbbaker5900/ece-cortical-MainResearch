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

`timescale 1ns/10ps


module generic_fifo #(parameter GENERIC_FIFO_DEPTH       = 8   ,
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
          input   wire                                      read         , 
          output  reg   [GENERIC_FIFO_DATA_WIDTH-1 :0  ]    read_data    ,
          
          //---------------------------------------------------------------
          // Status
          output  wire                                      empty        , 
          output  reg                                       almost_full  ,        
          output  reg                                       almost_empty ,
          output  reg   [GENERIC_FIFO_ADDR_WIDTH -1 :0  ]   depth         

             );


  //--------------------------------------------------------
  // Regs/Wires
  //

  wire [GENERIC_FIFO_DATA_WIDTH-1 :0  ]       int_read_data     ;
  reg  [GENERIC_FIFO_ADDR_WIDTH-1 :0  ]       wp                ; 
  reg  [GENERIC_FIFO_ADDR_WIDTH-1 :0  ]       rp                ; 

  /*
  reg                                         full              ;   // latch the full condition for debug
  */
  
    generic_2port_memory #(.GENERIC_MEM_DEPTH          (GENERIC_FIFO_DEPTH     ),
                           .GENERIC_MEM_REGISTERED_OUT (0                      ),
                           .GENERIC_MEM_DATA_WIDTH     (GENERIC_FIFO_DATA_WIDTH)
                    ) fifo_data_mem ( 
                    //---------------------------------------------------------------
                    // Port A 
                    .portA_address       ( wp          ),
                    .portA_write_data    ( write_data  ),
                    .portA_read_data     (             ),
                    .portA_enable        ( 1'b1        ), 
                    .portA_write         ( write       ),
                    
                    //---------------------------------------------------------------
                    // Port B 
                    .portB_address       ( rp                               ),
                    .portB_write_data    ( {GENERIC_FIFO_DATA_WIDTH {1'b0}} ),
                    .portB_read_data     ( int_read_data                    ),
                    .portB_enable        ( read                             ), 
                    .portB_write         ( 1'b0                             ),
                    
                    //---------------------------------------------------------------
                    // General
                    .reset_poweron       ( reset_poweron             ),
                    .clk                 ( clk                       )
                    ) ;

  always @(posedge clk)
    begin
      wp                 <= ( reset_poweron   ) ? 'd0           : 
                            ( clear           ) ? 'd0           : 
                            ( write           ) ?  wp + 'd1     :
                                                   wp           ;
  
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
      /*
      full               <= ( reset_poweron || clear        ) ? 1'b0 : 
                            ( depth == GENERIC_FIFO_DEPTH-1 ) ? 1'b1 :
                                                                full ;
      */

    end

    always @(*)
      begin
        read_data         =  int_read_data  ;
      end
      
  //--------------------------------------------------------
  // Keep track of almost full and empty
  //
  assign empty          = (rp == wp)                                             ;
  always @(posedge clk)
    begin
      almost_full   <= ( reset_poweron                                                           ) ? 1'b0        : 
                       ((depth == (GENERIC_FIFO_DEPTH-GENERIC_FIFO_THRESHOLD)) &&  write && ~read) ? 1'b1        :
                       ((depth == (GENERIC_FIFO_DEPTH-GENERIC_FIFO_THRESHOLD)) && ~write &&  read) ? 1'b0        :
                                                                                                     almost_full ;
      almost_empty  <= ( reset_poweron                                        ) ? 1'b1         : 
                       ((depth == (GENERIC_FIFO_THRESHOLD)) &&  write && ~read) ? 1'b0         :
                       ((depth == (GENERIC_FIFO_THRESHOLD)) && ~write &&  read) ? 1'b1         :
                                                                                  almost_empty ;
  
    end

  //--------------------------------------------------------


endmodule


