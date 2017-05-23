
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




//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//  Generic Pipelined FIFO(s)
//
//------------------------------------------------------------------------------------------------------------------------
//
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
    sasslnpky2p32x138cm16sw0bk1ltlc1 mem2p32x138( 
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
    sasslnpky2p32x58cm16sw0bk1ltlc1 mem2p32x58( 
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
    sasslnpky2p72x18cm16sw0bk1ltlc1 mem2p72x18( 
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

