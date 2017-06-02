
/*********************************************************************************************

    File name   : generic_memories.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : May 2017
    email       : lbbaker@ncsu.edu

    Description : Generic Memories used in this design.
                  This file is included in the generic_memory module.

*********************************************************************************************/

// Add delay to make sim pass
// FIXME ????
wire  [GENERIC_MEM_ADDR_WIDTH-1 :0  ]     portA_address_dly         ;
wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portA_write_data_dly      ;
wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     int_portA_read_data_dly   ;
wire                                      portA_enable_dly          ; 
wire                                      portA_write_dly           ; 

wire  [GENERIC_MEM_ADDR_WIDTH-1 :0  ]     portB_address_dly         ;
wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portB_write_data_dly      ;
wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     int_portB_read_data_dly   ;
wire                                      portB_enable_dly          ; 
wire                                      portB_write_dly           ; 

assign #0.5     portA_address_dly     =  portA_address              ;
assign #0.5     portA_write_data_dly  =  portA_write_data           ;
assign #0.5     int_portA_read_data   =  int_portA_read_data_dly    ;
assign #0.5     portA_enable_dly      =  portA_enable               ; 
assign #0.5     portA_write_dly       =  portA_write                ; 
                                                                    
assign #0.5     portB_address_dly     =  portB_address              ;
assign #0.5     portB_write_data_dly  =  portB_write_data           ;
assign #0.5     int_portB_read_data   =  int_portB_read_data_dly    ;
assign #0.5     portB_enable_dly      =  portB_enable               ; 
assign #0.5     portB_write_dly       =  portB_write                ; 


genvar gvi;


//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//  Generic Pipelined FIFO(s)
//
//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 128) && (GENERIC_MEM_DATA_WIDTH == 12) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p128x12cm4sw0bk1ltlc1  mem2p128x12( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 40) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p64x40cm4sw0bk1ltlc1 mem2p64x40( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
  generate
    if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 2050) && (GENERIC_MEM_REGISTERED_OUT == 0))
      begin
        for (gvi=0; gvi<15; gvi=gvi+1) 
          begin: mem2p64x2050
            sasslnpky2p64x128cm4sw0bk1ltlc1 mem2p64x128( 
                           // Port A
                           .CLKA        ( clk                                   ),
                           .WEA         ( portA_write_dly                       ),
                           .MEA         ( portA_enable_dly                      ),
                           .ADRA        ( portA_address_dly                     ),
                           .DA          ( portA_write_data_dly    [(gvi+1)*128-1:gvi*128] ),
                           .QA          ( int_portA_read_data_dly [(gvi+1)*128-1:gvi*128] ),
                        
                           // Port B
                           .CLKB        ( clk                                   ),
                           .WEB         ( portB_write_dly                       ),
                           .MEB         ( portB_enable_dly                      ),
                           .ADRB        ( portB_address_dly                     ),
                           .DB          ( portB_write_data_dly    [(gvi+1)*128-1:gvi*128] ),
                           .QB          ( int_portB_read_data_dly [(gvi+1)*128-1:gvi*128] ),
                        
                           .TEST1A      ( 1'b0 ),
                           .RMEA        ( 1'b0 ),
                           .RMA         ( 4'd0 ),
                           .TEST1B      ( 1'b0 ),
                           .RMEB        ( 1'b0 ),
                           .RMB         ( 4'd0 ));
          end
        sasslnpky2p64x130cm4sw0bk1ltlc1 mem2p64x130( 
                       // Port A
                       .CLKA        ( clk                                   ),
                       .WEA         ( portA_write_dly                       ),
                       .MEA         ( portA_enable_dly                      ),
                       .ADRA        ( portA_address_dly                     ),
                       .DA          ( portA_write_data_dly    [2050-1:15*128] ),
                       .QA          ( int_portA_read_data_dly [2050-1:15*128] ),
                    
                       // Port B
                       .CLKB        ( clk                            ),
                       .WEB         ( portB_write_dly                ),
                       .MEB         ( portB_enable_dly               ),
                       .ADRB        ( portB_address_dly              ),
                       .DB          ( portB_write_data_dly    [2050-1:15*128] ),
                       .QB          ( int_portB_read_data_dly [2050-1:15*128] ),
                    
                       .TEST1A      ( 1'b0 ),
                       .RMEA        ( 1'b0 ),
                       .RMA         ( 4'd0 ),
                       .TEST1B      ( 1'b0 ),
                       .RMEB        ( 1'b0 ),
                       .RMB         ( 4'd0 ));


      end
  endgenerate

/*
if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 350) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p16x117cm4sw0bk1ltlc1 mem2p16x117_0( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly    [116:0]  ),
                   .QA          ( int_portA_read_data_dly [116:0]  ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly    [116:0]  ),
                   .QB          ( int_portB_read_data_dly [116:0]  ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
    sasslnpky2p16x117cm4sw0bk1ltlc1 mem2p16x117_1( 
                   // Port A
                   .CLKA        ( clk                               ),
                   .WEA         ( portA_write_dly                   ),
                   .MEA         ( portA_enable_dly                  ),
                   .ADRA        ( portA_address_dly                 ),
                   .DA          ( portA_write_data_dly    [233:117] ),
                   .QA          ( int_portA_read_data_dly [233:117] ),
                
                   // Port B
                   .CLKB        ( clk                               ),
                   .WEB         ( portB_write_dly                   ),
                   .MEB         ( portB_enable_dly                  ),
                   .ADRB        ( portB_address_dly                 ),
                   .DB          ( portB_write_data_dly    [233:117] ),
                   .QB          ( int_portB_read_data_dly [233:117] ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
    sasslnpky2p16x116cm4sw0bk1ltlc1 mem2p16x116_0( 
                   // Port A
                   .CLKA        ( clk                               ),
                   .WEA         ( portA_write_dly                   ),
                   .MEA         ( portA_enable_dly                  ),
                   .ADRA        ( portA_address_dly                 ),
                   .DA          ( portA_write_data_dly    [349:234] ),
                   .QA          ( int_portA_read_data_dly [349:234] ),
                
                   // Port B
                   .CLKB        ( clk                               ),
                   .WEB         ( portB_write_dly                   ),
                   .MEB         ( portB_enable_dly                  ),
                   .ADRB        ( portB_address_dly                 ),
                   .DB          ( portB_write_data_dly    [349:234] ),
                   .QB          ( int_portB_read_data_dly [349:234] ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

*/

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//  Generic FIFOs
//
//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 256) && (GENERIC_MEM_DATA_WIDTH == 8) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p256x8cm4sw0bk1ltlc1 mem2p256x8( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
/*
if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 353) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p16x118cm4sw0bk1ltlc1 mem2p16x118_0( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly    [117:0]  ),
                   .QA          ( int_portA_read_data_dly [117:0]  ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly    [117:0]  ),
                   .QB          ( int_portB_read_data_dly [117:0]  ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
    sasslnpky2p16x118cm4sw0bk1ltlc1 mem2p16x118_1( 
                   // Port A
                   .CLKA        ( clk                               ),
                   .WEA         ( portA_write_dly                   ),
                   .MEA         ( portA_enable_dly                  ),
                   .ADRA        ( portA_address_dly                 ),
                   .DA          ( portA_write_data_dly    [235:118] ),
                   .QA          ( int_portA_read_data_dly [235:118] ),
                
                   // Port B
                   .CLKB        ( clk                               ),
                   .WEB         ( portB_write_dly                   ),
                   .MEB         ( portB_enable_dly                  ),
                   .ADRB        ( portB_address_dly                 ),
                   .DB          ( portB_write_data_dly    [235:118] ),
                   .QB          ( int_portB_read_data_dly [235:118] ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
    sasslnpky2p16x117cm4sw0bk1ltlc1 mem2p16x117_0( 
                   // Port A
                   .CLKA        ( clk                               ),
                   .WEA         ( portA_write_dly                   ),
                   .MEA         ( portA_enable_dly                  ),
                   .ADRA        ( portA_address_dly                 ),
                   .DA          ( portA_write_data_dly    [352:236] ),
                   .QA          ( int_portA_read_data_dly [352:236] ),
                
                   // Port B
                   .CLKB        ( clk                               ),
                   .WEB         ( portB_write_dly                   ),
                   .MEB         ( portB_enable_dly                  ),
                   .ADRB        ( portB_address_dly                 ),
                   .DB          ( portB_write_data_dly    [352:236] ),
                   .QB          ( int_portB_read_data_dly [352:236] ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end
*/
//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 32) && (GENERIC_MEM_DATA_WIDTH == 138) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p32x138cm4sw0bk1ltlc1 mem2p32x138( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 32) && (GENERIC_MEM_DATA_WIDTH == 58) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p32x58cm4sw0bk1ltlc1 mem2p32x58( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 72) && (GENERIC_MEM_DATA_WIDTH == 18) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p72x18cm4sw0bk1ltlc1 mem2p72x18( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 32) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p16x32cm4sw0bk1ltlc1 mem2p16x32( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 2048) && (GENERIC_MEM_DATA_WIDTH == 75) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p2048x75cm4sw0bk1ltlc1 mem2p2048x75( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 256) && (GENERIC_MEM_DATA_WIDTH == 75) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p256x75cm4sw0bk1ltlc1 mem2p256x75( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 76) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p64x76cm4sw0bk1ltlc1 mem2p64x76( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 50) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p16x50cm4sw0bk1ltlc1 mem2p16x50( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//  Generic Memories
//
//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 1024) && (GENERIC_MEM_DATA_WIDTH == 50) && (GENERIC_MEM_REGISTERED_OUT == 0))
  begin
    sasslnpky2p1024x50cm4sw0bk1ltlc1 mem2p1024x50( 
                   // Port A
                   .CLKA        ( clk                              ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly             ),
                   .QA          ( int_portA_read_data_dly          ),
                
                   // Port B
                   .CLKB        ( clk                              ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly             ),
                   .QB          ( int_portB_read_data_dly          ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
  generate
    if ((GENERIC_MEM_DEPTH == 16384) && (GENERIC_MEM_DATA_WIDTH == 12) && (GENERIC_MEM_REGISTERED_OUT == 0))
      begin
        wire  [2:0 ]                              portA_addrDecode                = portA_address_dly [13:11] ;
        wire  [2:0 ]                              portB_addrDecode                = portB_address_dly [13:11] ;

        for (gvi=0; gvi<8; gvi=gvi+1) 
          begin: mem2p16384x12
            wire           local_portA_enable_dly  = portA_enable_dly & (portA_addrDecode == gvi) ;
            wire           local_portB_enable_dly  = portB_enable_dly & (portB_addrDecode == gvi) ;
            wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     local_int_portA_read_data_dly   ;
            wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     local_int_portB_read_data_dly   ;
          
            sasslnpky2p2048x12cm4sw0bk1ltlc1 mem2p2048x12( 
                           // Port A
                           .CLKA        ( clk                              ),
                           .WEA         ( portA_write_dly                  ),
                           .MEA         ( local_portA_enable_dly           ),
                           .ADRA        ( portA_address_dly [10:0]         ),
                           .DA          ( portA_write_data_dly             ),
                           .QA          ( local_int_portA_read_data_dly    ),
                        
                           // Port B
                           .CLKB        ( clk                              ),
                           .WEB         ( portB_write_dly                  ),
                           .MEB         ( local_portB_enable_dly           ),
                           .ADRB        ( portB_address_dly [10:0]         ),
                           .DB          ( portB_write_data_dly             ),
                           .QB          ( local_int_portB_read_data_dly    ),
                        
                           .TEST1A      ( 1'b0 ),
                           .RMEA        ( 1'b0 ),
                           .RMA         ( 4'd0 ),
                           .TEST1B      ( 1'b0 ),
                           .RMEB        ( 1'b0 ),
                           .RMB         ( 4'd0 ));
          end

        // Mux read data
        reg   [GENERIC_MEM_DATA_WIDTH-1 :0  ]     muxed_int_portA_read_data_dly                               ;
        reg   [GENERIC_MEM_DATA_WIDTH-1 :0  ]     muxed_int_portB_read_data_dly                               ;
      
        always @(*)
          begin
            case (portA_addrDecode)
              0:
                 muxed_int_portA_read_data_dly = mem2p16384x12[0].local_int_portA_read_data_dly  ;
              1:                                                
                 muxed_int_portA_read_data_dly = mem2p16384x12[1].local_int_portA_read_data_dly  ;
              2:                                                
                 muxed_int_portA_read_data_dly = mem2p16384x12[2].local_int_portA_read_data_dly  ;
              3:                                                
                 muxed_int_portA_read_data_dly = mem2p16384x12[3].local_int_portA_read_data_dly  ;
              4:                                                
                 muxed_int_portA_read_data_dly = mem2p16384x12[4].local_int_portA_read_data_dly  ;
              5:                                                
                 muxed_int_portA_read_data_dly = mem2p16384x12[5].local_int_portA_read_data_dly  ;
              6:                                                
                 muxed_int_portA_read_data_dly = mem2p16384x12[6].local_int_portA_read_data_dly  ;
              7:                                                
                 muxed_int_portA_read_data_dly = mem2p16384x12[7].local_int_portA_read_data_dly  ;
            endcase
          end

        assign int_portA_read_data_dly = muxed_int_portA_read_data_dly   ;
        assign int_portB_read_data_dly = muxed_int_portB_read_data_dly   ;

      end
  endgenerate

//------------------------------------------------------------------------------------------------------------------------
//
/*
if ((GENERIC_MEM_DEPTH == 512) && (GENERIC_MEM_DATA_WIDTH == 320) && (GENERIC_MEM_REGISTERED_OUT == 1))
  begin
    sasslnpky2p512x160cm4sw0bk1ltlc1 mem2p512x160_0( 
                   // Port A
                   .CLKA        ( clk                          ),
                   .WEA         ( portA_write_dly                  ),
                   .MEA         ( portA_enable_dly                 ),
                   .ADRA        ( portA_address_dly                ),
                   .DA          ( portA_write_data_dly    [159:0]  ),
                   .QA          ( int_portA_read_data_dly [159:0]  ),
                
                   // Port B
                   .CLKB        ( clk                          ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly    [159:0]  ),
                   .QB          ( int_portB_read_data_dly [159:0]  ),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
    sasslnpky2p512x160cm4sw0bk1ltlc1 mem2p512x160_1( 
                   // Port A
                   .CLKA        ( clk                           ),
                   .WEA         ( portA_write_dly                   ),
                   .MEA         ( portA_enable_dly                  ),
                   .ADRA        ( portA_address_dly                 ),
                   .DA          ( portA_write_data_dly    [319:160] ),
                   .QA          ( int_portA_read_data_dly [319:160]),
                
                   // Port B
                   .CLKB        ( clk                          ),
                   .WEB         ( portB_write_dly                  ),
                   .MEB         ( portB_enable_dly                 ),
                   .ADRB        ( portB_address_dly                ),
                   .DB          ( portB_write_data_dly    [319:160]),
                   .QB          ( int_portB_read_data_dly [319:160]),
                
                   .TEST1A      ( 1'b0 ),
                   .RMEA        ( 1'b0 ),
                   .RMA         ( 4'd0 ),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b0 ),
                   .RMB         ( 4'd0 ));
  end
*/

