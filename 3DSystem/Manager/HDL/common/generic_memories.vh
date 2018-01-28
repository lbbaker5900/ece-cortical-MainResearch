
/*********************************************************************************************

    File name   : generic_memories.vh
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : May 2017
    email       : lbbaker@ncsu.edu

    Description : Generic Memories used in this design.
                  This file is included in the generic_memory module.
                  The specific memory instance(s) are selected using the parameters
                  Contains all memory types including 1/2 port and register files


*********************************************************************************************/

localparam T65NM = `TECHNOLOGY_65NM_NODE;
localparam T28NM = `TECHNOLOGY_28NM_NODE;


// Add delay to make sim pass
// FIXME ????
wire  [GENERIC_MEM_ADDR_WIDTH-1 :0  ]     portA_address_dly         ;
wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portA_write_data_dly      ;
wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     int_portA_read_data_dly   ;
wire                                      portA_enable_dly          ; 
wire                                      portA_write_dly           ; 

//if (GENERIC_NUM_OF_PORTS == 2)
//  begin
    wire  [GENERIC_MEM_ADDR_WIDTH-1 :0  ]     portB_address_dly         ;
    wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     portB_write_data_dly      ;
    wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     int_portB_read_data_dly   ;
    wire                                      portB_enable_dly          ; 
    wire                                      portB_write_dly           ; 
//  end

assign #0.5     portA_address_dly     =  portA_address              ;
assign #0.5     portA_write_data_dly  =  portA_write_data           ;
assign #0.5     int_portA_read_data   =  int_portA_read_data_dly    ;
assign #0.5     portA_enable_dly      =  portA_enable               ; 
assign #0.5     portA_write_dly       =  portA_write                ; 
                                                                    
//if (GENERIC_NUM_OF_PORTS == 2)
//  begin
    assign #0.5     portB_address_dly     =  portB_address              ;
    assign #0.5     portB_write_data_dly  =  portB_write_data           ;
    assign #0.5     int_portB_read_data   =  int_portB_read_data_dly    ;
    assign #0.5     portB_enable_dly      =  portB_enable               ; 
    assign #0.5     portB_write_dly       =  portB_write                ; 
//  end


genvar gvi;


//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//  Generic Pipelined FIFO(s)
//
//------------------------------------------------------------------------------------------------------------------------
//
if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 70) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p64x70cm1sw0         mem2prf64x70(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 256) && (GENERIC_MEM_DATA_WIDTH == 70) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p256x70cm2sw0         mem2prf256x70(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 25) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p64x25cm2sw0         mem2prf64x25(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 24) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p64x24cm2sw0         mem2prf64x24(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 20) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p64x20cm2sw0         mem2prf64x20(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 18) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p64x18cm2sw0         mem2prf64x18(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 32) && (GENERIC_MEM_DATA_WIDTH == 25) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p32x25cm1sw0         mem2prf32x25(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 21) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x21    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg21                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg21_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x21 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg21_e1  =  reg8x21 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg21   <= ( portB_enable_dly ) ? oreg21_e1 :
                                           oreg21    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg21  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 20) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x20    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg20                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg20_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x20 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg20_e1  =  reg8x20 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg20   <= ( portB_enable_dly ) ? oreg20_e1 :
                                           oreg20    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg20  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 8) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x8    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg8                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg8_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x8 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg8_e1  =  reg8x8 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg8   <= ( portB_enable_dly ) ? oreg8_e1 :
                                           oreg8    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg8  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 9) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x9    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg9                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg9_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x9 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg9_e1  =  reg8x9 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg9   <= ( portB_enable_dly ) ? oreg9_e1 :
                                           oreg9    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg9  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 10) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x10    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg10                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg10_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x10 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg10_e1  =  reg8x10 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg10   <= ( portB_enable_dly ) ? oreg10_e1 :
                                           oreg10    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg10  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 14) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x14    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg14                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg14_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x14 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg14_e1  =  reg8x14 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg14   <= ( portB_enable_dly ) ? oreg14_e1 :
                                           oreg14    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg14  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 22) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x22    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg22                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg22_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x22 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg22_e1  =  reg8x22 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg22   <= ( portB_enable_dly ) ? oreg22_e1 :
                                           oreg22    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg22  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 7) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x7    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg7                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg7_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x7 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg7_e1  =  reg8x7 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg7   <= ( portB_enable_dly ) ? oreg7_e1 :
                                           oreg7    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg7  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 58) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x58    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg58                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg58_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x58 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg58_e1  =  reg8x58 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg58   <= ( portB_enable_dly ) ? oreg58_e1 :
                                           oreg58    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg58  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 77) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x77    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg77                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg77_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x77 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg77_e1  =  reg8x77 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg77   <= ( portB_enable_dly ) ? oreg77_e1 :
                                           oreg77    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg77  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 32) && (GENERIC_MEM_DATA_WIDTH == 7) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg32x7    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg7                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg7_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg32x7 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg7_e1  =  reg32x7 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg7   <= ( portB_enable_dly ) ? oreg7_e1 :
                                           oreg7    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg7  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 10) && (GENERIC_MEM_DATA_WIDTH == 32) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg10x32    [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg32                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg32_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg10x32 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg32_e1  =  reg10x32 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg32   <= ( portB_enable_dly ) ? oreg32_e1 :
                                           oreg32    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg32  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 27) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x27     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg27                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg27_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x27 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg27_e1  =  reg8x27 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg27   <= ( portB_enable_dly ) ? oreg27_e1 :
                                           oreg27    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg27  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 29) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x29     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg29                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg29_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x29 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg29_e1  =  reg8x29 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg29   <= ( portB_enable_dly ) ? oreg29_e1 :
                                           oreg29    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg29  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 31) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x31     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg31                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg31_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x31 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg31_e1  =  reg8x31 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg31   <= ( portB_enable_dly ) ? oreg31_e1 :
                                           oreg31    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg31  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 33) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x33     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg33                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg33_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x33 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg33_e1  =  reg8x33 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg33   <= ( portB_enable_dly ) ? oreg33_e1 :
                                           oreg33    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg33  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 32) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x32     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg32                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg32_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x32 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg32_e1  =  reg8x32 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg32   <= ( portB_enable_dly ) ? oreg32_e1 :
                                           oreg32    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg32  ;
    
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 150) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
/*
    asdrlnpky2p8x150cm1sw0         mem2prf8x150(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011  ), 
                   .RMEB        ( 1'b1     ));
*/
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x150     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg150                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg150_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x150 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg150_e1  =  reg8x150 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg150   <= ( portB_enable_dly ) ? oreg150_e1 :
                                            oreg150    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg150  ;
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 128) && (GENERIC_MEM_DATA_WIDTH == 18) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    
    asdrlnpky2p128x18cm2sw0         mem2prf128x18(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011  ), 
                   .RMEB        ( 1'b1     ));
  end
//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 128) && (GENERIC_MEM_DATA_WIDTH == 21) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    
    asdrlnpky2p128x21cm2sw0         mem2prf128x21(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011  ), 
                   .RMEB        ( 1'b1     ));
  end
//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 128) && (GENERIC_MEM_DATA_WIDTH == 12) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    if (T65NM == 1)
      begin
    
        asdrlnpky2p128x12cm1sw0         mem2prf128x12(
                       // Output
                       .QB          ( int_portB_read_data_dly               ),
                       // Read Port
                       .CLKB        ( clk                                   ),
                       .MEB         ( portB_enable_dly                      ),
                       .ADRB        ( portB_address_dly                     ),
                       // Write Port
                       .CLKA        ( clk                                   ),
                       .WEA         ( portA_write_dly                       ),
                       .MEA         ( portA_enable_dly                      ),
                       .ADRA        ( portA_address_dly                     ),
                       .DA          ( portA_write_data_dly                  ),
                       // Test
                       .TEST1A      ( 1'b0     ), 
                       .WMENA       ( 1'b0     ), // FIXME
                       .TEST1B      ( 1'b0     ), 
                       .RMB         ( 4'b0011  ), 
                       .RMEB        ( 1'b1     ));
      end

    else if (T28NM == 1)
      begin
        arm_regf_28nm_2p128x12mw4 mem2prf128x12(

                                   // Port A
                                  .CLKA          ( clk                     ),
                                  .CENA          (~portA_enable_dly        ),
                                  .WENA          (~portA_write_dly         ),
                                  .AA            ( portA_address_dly       ),
                                  .DA            ( portA_write_data_dly    ),
                                  .QA            ( int_portB_read_data_dly ),
                                                
                                   // Port B
                                  .CLKB          ( clk                     ),
                                  .CENB          (~portA_enable_dly        ),
                                  .WENB          (~portA_write_dly         ),
                                  .AB            ( portA_address_dly       ),
                                  .DB            ( portA_write_data_dly    ),
                                  .QB            ( int_portB_read_data_dly ),

                                  // Test/Configuration
                                  // Outputs 
                                  .CENYA         (  ),
                                  .WENYA         (  ),
                                  .AYA           (  ),
                                  .SOA           (  ),
                                  .CENYB         (  ),
                                  .WENYB         (  ),
                                  .AYB           (  ),
                                  .SOB           (  ),
                                  // Inputs 
                                  .EMAA          ( 3'b000             ),
                                  .EMAWA         ( 2'b00              ),
                                  .TENA          ( 1'b0               ),
                                  .TCENA         ( 1'b0               ),
                                  .TWENA         ( 1'b0               ),
                                  .TAA           ( 7'd0 ),  // same width as Address
                                  .TDA           ( 12'd0 ),  // same width as data
                                  .SIA           ( 2'b00              ),
                                  .SEA           ( 1'b0               ),

                                  .EMAB          ( 3'b000             ),
                                  .EMAWB         ( 2'b00              ),
                                  .TENB          ( 1'b0               ),
                                  .TCENB         ( 1'b0               ),
                                  .TWENB         ( 1'b0               ),
                                  .TAB           ( 7'd0 ),  // same width as Address
                                  .TDB           ( 12'd0 ),  // same width as data
                                  .SIB           ( 2'b00              ),
                                  .SEB           ( 1'b0               ),

                                  .RET1N         ( 1'b0               ),
                                  .DFTRAMBYP     ( 1'b0               ),
                                  .COLLDISN      ( 1'b0               )
          );
   
      end

  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 34) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg16x34     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg34                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg34_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg16x34 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg34_e1  =  reg16x34 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg34   <= ( portB_enable_dly ) ? oreg34_e1 :
                                           oreg34    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg34  ;
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 10) && (GENERIC_MEM_DATA_WIDTH == 34) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg10x34     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg34                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg34_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg10x34 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg34_e1  =  reg10x34 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg34   <= ( portB_enable_dly ) ? oreg34_e1 :
                                           oreg34    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg34  ;
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 34) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x34     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg34                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg34_e1                              ;

    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x34 [portA_address_dly] <= portA_write_data_dly ;
      end

    assign   oreg34_e1  =  reg8x34 [portB_address_dly] ;

    always @(posedge clk)
      begin
        oreg34   <= ( portB_enable_dly ) ? oreg34_e1 :
                                           oreg34    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg34  ;
    
  end

//------------------------------------------------------------------------------------------------------------------------
//
// Use regFile for wide/shallow FIFO's
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 2114) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x2114     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg2114                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg2114_e1                              ;
   
    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x2114 [portA_address_dly] <= portA_write_data_dly ;
      end
   
    assign   oreg2114_e1  =  reg8x2114 [portB_address_dly] ;
   
    always @(posedge clk)
      begin
        oreg2114   <= ( portB_enable_dly ) ? oreg2114_e1 :
                                             oreg2114    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg2114  ;

  end
//------------------------------------------------------------------------------------------------------------------------
//
// Use regFile for wide/shallow FIFO's
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 2050) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     reg8x2050     [GENERIC_MEM_DEPTH-1 :0 ] ;
    reg  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg2050                                 ;
    wire [GENERIC_MEM_DATA_WIDTH-1 :0  ]     oreg2050_e1                              ;
   
    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          reg8x2050 [portA_address_dly] <= portA_write_data_dly ;
      end
   
    assign   oreg2050_e1  =  reg8x2050 [portB_address_dly] ;
   
    always @(posedge clk)
      begin
        oreg2050   <= ( portB_enable_dly ) ? oreg2050_e1 :
                                             oreg2050    ;  // dw memory datasheet specifies previous data is maintained with ME=0
      end
    assign int_portB_read_data_dly  = oreg2050  ;

  end
//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 46) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    
    asdrlnpky2p64x46cm1sw0         mem2prf64x46(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011  ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 40) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    if (T65NM == 1)
      begin
    
        asdrlnpky2p64x40cm1sw0         mem2prf64x40(
                       // Output
                       .QB          ( int_portB_read_data_dly               ),
                       // Read Port
                       .CLKB        ( clk                                   ),
                       .MEB         ( portB_enable_dly                      ),
                       .ADRB        ( portB_address_dly                     ),
                       // Write Port
                       .CLKA        ( clk                                   ),
                       .WEA         ( portA_write_dly                       ),
                       .MEA         ( portA_enable_dly                      ),
                       .ADRA        ( portA_address_dly                     ),
                       .DA          ( portA_write_data_dly                  ),
                       // Test
                       .TEST1A      ( 1'b0     ), 
                       .WMENA       ( 1'b0     ), // FIXME
                       .TEST1B      ( 1'b0     ), 
                       .RMB         ( 4'b0011  ), 
                       .RMEB        ( 1'b1     ));
      end

    else if (T28NM == 1)
      begin
    
        arm_regf_28nm_2p64x40mw0         mem2prf64x40(
                       // Output
                       .QB          ( int_portB_read_data_dly               ),
                       // Read Port
                       .CLKB        ( clk                                   ),
                       .MEB         ( portB_enable_dly                      ),
                       .ADRB        ( portB_address_dly                     ),
                       // Write Port
                       .CLKA        ( clk                                   ),
                       .WEA         ( portA_write_dly                       ),
                       .MEA         ( portA_enable_dly                      ),
                       .ADRA        ( portA_address_dly                     ),
                       .DA          ( portA_write_data_dly                  ),
                       // Test
                       .TEST1A      ( 1'b0     ), 
                       .WMENA       ( 1'b0     ), // FIXME
                       .TEST1B      ( 1'b0     ), 
                       .RMB         ( 4'b0011  ), 
                       .RMEB        ( 1'b1     ));

      end

  end

//------------------------------------------------------------------------------------------------------------------------
//
// Use regFile for wide/shallow FIFO's
else if ((GENERIC_MEM_DEPTH == 32) && (GENERIC_MEM_DATA_WIDTH == 2050) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    for (gvi=0; gvi<8; gvi=gvi+1) 
      begin: mem2p32x2050
        asdrlnpky2p32x256cm1sw0         mem2prf32x256(
                       // Output
                       .QB          ( int_portB_read_data_dly [(gvi+1)*256-1:gvi*256] ),
                       // Read Port
                       .CLKB        ( clk                                   ),
                       .MEB         ( portB_enable_dly                      ),
                       .ADRB        ( portB_address_dly                     ),
                       // Write Port
                       .CLKA        ( clk                                   ),
                       .WEA         ( portA_write_dly                       ),
                       .MEA         ( portA_enable_dly                      ),
                       .ADRA        ( portA_address_dly                     ),
                       .DA          ( portA_write_data_dly  [(gvi+1)*256-1:gvi*256] ),
                       // Test
                       .TEST1A      ( 1'b0     ), 
                       .WMENA       ( 1'b0     ), // FIXME
                       .TEST1B      ( 1'b0     ), 
                       .RMB         ( 4'b0011  ), 
                       .RMEB        ( 1'b1     ));
      end

    reg [1:0] mem2p32x2_topBits  [ 31:0 ] ; 
    always @(posedge clk)
      begin
        if (portA_enable_dly && portA_write_dly)
          mem2p32x2_topBits [portA_address_dly] <= portA_write_data_dly [2049:2048] ;
      end
    assign int_portB_read_data_dly [2049:2048] = mem2p32x2_topBits [portB_address_dly] ;


  end


//------------------------------------------------------------------------------------------------------------------------
//
// Use regFile for wide/shallow FIFO's
else if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 2050) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    if (T65NM == 1)
      begin
    
        for (gvi=0; gvi<8; gvi=gvi+1) 
          begin: mem2p64x2050
            asdrlnpky2p64x256cm1sw0         mem2prf64x256(
                           // Output
                           .QB          ( int_portB_read_data_dly [(gvi+1)*256-1:gvi*256] ),
                           // Read Port
                           .CLKB        ( clk                                   ),
                           .MEB         ( portB_enable_dly                      ),
                           .ADRB        ( portB_address_dly                     ),
                           // Write Port
                           .CLKA        ( clk                                   ),
                           .WEA         ( portA_write_dly                       ),
                           .MEA         ( portA_enable_dly                      ),
                           .ADRA        ( portA_address_dly                     ),
                           .DA          ( portA_write_data_dly  [(gvi+1)*256-1:gvi*256] ),
                           // Test
                           .TEST1A      ( 1'b0     ), 
                           .WMENA       ( 1'b0     ), // FIXME
                           .TEST1B      ( 1'b0     ), 
                           .RMB         ( 4'b0011  ), 
                           .RMEB        ( 1'b1     ));
          end
  
        reg [1:0] mem2p64x2_topBits  [ 31:0 ] ; 
        always @(posedge clk)
          begin
            if (portA_enable_dly && portA_write_dly)
              mem2p64x2_topBits [portA_address_dly] <= portA_write_data_dly [2049:2048] ;
          end
        assign int_portB_read_data_dly [2049:2048] = mem2p64x2_topBits [portB_address_dly] ;
  
      end

    else if (T28NM == 1)
      begin

        for (gvi=0; gvi<8; gvi=gvi+1) 
          begin: mem2p64x2050
            arm_regf_28nm_2p64x256mw0       mem2prf64x256(
                           // Output
                           .QB          ( int_portB_read_data_dly [(gvi+1)*256-1:gvi*256] ),
                           // Read Port
                           .CLKB        ( clk                                   ),
                           .MEB         ( portB_enable_dly                      ),
                           .ADRB        ( portB_address_dly                     ),
                           // Write Port
                           .CLKA        ( clk                                   ),
                           .WEA         ( portA_write_dly                       ),
                           .MEA         ( portA_enable_dly                      ),
                           .ADRA        ( portA_address_dly                     ),
                           .DA          ( portA_write_data_dly  [(gvi+1)*256-1:gvi*256] ),
                           // Test
                           .TEST1A      ( 1'b0     ), 
                           .WMENA       ( 1'b0     ), // FIXME
                           .TEST1B      ( 1'b0     ), 
                           .RMB         ( 4'b0011  ), 
                           .RMEB        ( 1'b1     ));
          end
  
        reg [1:0] mem2p64x2_topBits  [ 31:0 ] ; 
        always @(posedge clk)
          begin
            if (portA_enable_dly && portA_write_dly)
              mem2p64x2_topBits [portA_address_dly] <= portA_write_data_dly [2049:2048] ;
          end
        assign int_portB_read_data_dly [2049:2048] = mem2p64x2_topBits [portB_address_dly] ;
  
      end

  end


//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//  Generic FIFOs
//
//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 38) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p16x38cm1sw0         mem2prf16x38(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 256) && (GENERIC_MEM_DATA_WIDTH == 8) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
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
                   .RMEA        ( 1'b1 ),
                   .RMA         ( 4'b0011),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b1 ),
                   .RMB         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 57) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p16x57cm1sw0         mem2prf16x57(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 58) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p16x58cm1sw0         mem2prf16x58(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 32) && (GENERIC_MEM_DATA_WIDTH == 150) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p32x150cm1sw0         mem2prf32x150(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 32) && (GENERIC_MEM_DATA_WIDTH == 138) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p32x138cm1sw0         mem2prf32x138(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 32) && (GENERIC_MEM_DATA_WIDTH == 57) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p32x57cm1sw0         mem2prf32x57(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 32) && (GENERIC_MEM_DATA_WIDTH == 58) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p32x58cm1sw0         mem2prf32x58(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8) && (GENERIC_MEM_DATA_WIDTH == 82) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p8x82cm1sw0         mem2prf8x82(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 70) && (GENERIC_MEM_DATA_WIDTH == 15) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p70x15cm1sw0         mem2prf70x15(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 70) && (GENERIC_MEM_DATA_WIDTH == 18) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p70x18cm1sw0         mem2prf70x18(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 70) && (GENERIC_MEM_DATA_WIDTH == 19) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p70x19cm1sw0         mem2prf70x19(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 70) && (GENERIC_MEM_DATA_WIDTH == 21) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p70x21cm1sw0         mem2prf70x21(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 32) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p16x32cm1sw0         mem2prf16x32(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 2048) && (GENERIC_MEM_DATA_WIDTH == 75) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
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
                   .RMEA        ( 1'b1 ),
                   .RMA         ( 4'b0011),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b1 ),
                   .RMB         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 256) && (GENERIC_MEM_DATA_WIDTH == 75) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p256x75cm2sw0         mem2prf256x75(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 64) && (GENERIC_MEM_DATA_WIDTH == 76) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    asdrlnpky2p64x76cm1sw0         mem2prf64x76(
                   // Output
                   .QB          ( int_portB_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portB_enable_dly                      ),
                   .ADRB        ( portB_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 16) && (GENERIC_MEM_DATA_WIDTH == 50) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem

    if (T65NM == 1)
      begin
    
        asdrlnpky2p16x50cm1sw0         mem2prf16x50(
                       // Output
                       .QB          ( int_portB_read_data_dly               ),
                       // Read Port
                       .CLKB        ( clk                                   ),
                       .MEB         ( portB_enable_dly                      ),
                       .ADRB        ( portB_address_dly                     ),
                       // Write Port
                       .CLKA        ( clk                                   ),
                       .WEA         ( portA_write_dly                       ),
                       .MEA         ( portA_enable_dly                      ),
                       .ADRA        ( portA_address_dly                     ),
                       .DA          ( portA_write_data_dly                  ),
                       // Test
                       .TEST1A      ( 1'b0     ), 
                       .WMENA       ( 1'b0     ), // FIXME
                       .TEST1B      ( 1'b0     ), 
                       .RMB         ( 4'b0011    ), 
                       .RMEB        ( 1'b1     ));
      end

    else if (T28NM == 1)
      begin


        arm_regf_28nm_2p16x50mw4       mem2prf16x50(
                       // Output
                       .QB          ( int_portB_read_data_dly               ),
                       // Read Port
                       .CLKB        ( clk                                   ),
                       .MEB         ( portB_enable_dly                      ),
                       .ADRB        ( portB_address_dly                     ),
                       // Write Port
                       .CLKA        ( clk                                   ),
                       .WEA         ( portA_write_dly                       ),
                       .MEA         ( portA_enable_dly                      ),
                       .ADRA        ( portA_address_dly                     ),
                       .DA          ( portA_write_data_dly                  ),
                       // Test
                       .TEST1A      ( 1'b0     ), 
                       .WMENA       ( 1'b0     ), // FIXME
                       .TEST1B      ( 1'b0     ), 
                       .RMB         ( 4'b0011    ), 
                       .RMEB        ( 1'b1     ));

      end
  end

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//  Generic Memories
//
//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 256) && (GENERIC_MEM_DATA_WIDTH == 32) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p256x32cm4sw0ltlc1 mem1p256x32( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 256) && (GENERIC_MEM_DATA_WIDTH == 32) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    sasslnpky2p256x32cm4sw0bk1ltlc1 mem2p256x32( 
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
                   .RMEA        ( 1'b1 ),
                   .RMA         ( 4'b0011),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b1 ),
                   .RMB         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 1024) && (GENERIC_MEM_DATA_WIDTH == 32) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
    sasslnpky2p1024x32cm4sw0bk1ltlc1 mem2p1024x32( 
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
                   .RMEA        ( 1'b1 ),
                   .RMA         ( 4'b0011),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b1 ),
                   .RMB         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 256) && (GENERIC_MEM_DATA_WIDTH == 149) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    // If a 1-port memory uses the regFile, we need to connect the read potA
    // signals to the regFile read port (portB)
    asdrlnpky2p256x149cm1sw0         mem2prf256x149(
                   // Output
                   .QB          ( int_portA_read_data_dly               ),
                   // Read Port
                   .CLKB        ( clk                                   ),
                   .MEB         ( portA_enable_dly                      ),
                   .ADRB        ( portA_address_dly                     ),
                   // Write Port
                   .CLKA        ( clk                                   ),
                   .WEA         ( portA_write_dly                       ),
                   .MEA         ( portA_enable_dly                      ),
                   .ADRA        ( portA_address_dly                     ),
                   .DA          ( portA_write_data_dly                  ),
                   // Test
                   .TEST1A      ( 1'b0     ), 
                   .WMENA       ( 1'b0     ), // FIXME
                   .TEST1B      ( 1'b0     ), 
                   .RMB         ( 4'b0011    ), 
                   .RMEB        ( 1'b1     ));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 256) && (GENERIC_MEM_DATA_WIDTH == 13) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p256x13cm4sw0ltlc1 mem1p256x13( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 1024) && (GENERIC_MEM_DATA_WIDTH == 12) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p1024x12cm8sw0ltlc1 mem1p1024x12( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 1024) && (GENERIC_MEM_DATA_WIDTH == 21) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p1024x21cm8sw0ltlc1 mem1p1024x21( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 1024) && (GENERIC_MEM_DATA_WIDTH == 42) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p1024x42cm4sw0ltlc1 mem1p1024x42( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 1024) && (GENERIC_MEM_DATA_WIDTH == 46) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p1024x46cm4sw0ltlc1 mem1p1024x46( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 1024) && (GENERIC_MEM_DATA_WIDTH == 57) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p1024x57cm4sw0ltlc1 mem1p1024x57( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 1024) && (GENERIC_MEM_DATA_WIDTH == 50) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p1024x50cm4sw0ltlc1 mem1p1024x50( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 1024) && (GENERIC_MEM_DATA_WIDTH == 50) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
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
                   .RMEA        ( 1'b1 ),
                   .RMA         ( 4'b0011),
                   .TEST1B      ( 1'b0 ),
                   .RMEB        ( 1'b1 ),
                   .RMB         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 2048) && (GENERIC_MEM_DATA_WIDTH == 46) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p2048x46cm8sw0ltlc1 mem1p2048x46( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 2048) && (GENERIC_MEM_DATA_WIDTH == 44) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p2048x44cm8sw0ltlc1 mem1p2048x44( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 4096) && (GENERIC_MEM_DATA_WIDTH == 57) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    if (T65NM == 1)
      begin
    
        sasslnpky1p4096x57cm8sw0ltlc1 mem1p4096x57( 
                       // Port A
                       .CLK        ( clk                              ),
                       .WE         ( portA_write_dly                  ),
                       .ME         ( portA_enable_dly                 ),
                       .ADR        ( portA_address_dly                ),
                       .D          ( portA_write_data_dly             ),
                       .Q          ( int_portA_read_data_dly          ),
                    
                    
                       .TEST1      ( 1'b0 ),
                       .RME        ( 1'b1 ),
                       .RM         ( 4'b0011));
      end

    else if (T28NM == 1)
      begin

        arm_sram_28nm_1p4096x57mw8 mem1p4096x57(

                                   // Port
                                  .CLK          ( clk                     ),
                                  .CEN          (~portA_enable_dly        ),
                                  .WEN          (~portA_write_dly         ),
                                  .A            ( portA_address_dly       ),
                                  .D            ( portA_write_data_dly    ),
                                  .Q            ( int_portB_read_data_dly ),
                                                

                                  // Test/Configuration
                                  // Outputs 
                                  .CENY         (  ),
                                  .WENY         (  ),
                                  .AY           (  ),
                                  .SO           (  ),
                                  // Inputs 
                                  .EMA          ( 3'b000             ),
                                  .EMAW         ( 2'b00              ),
                                  .EMAS         ( 1'b0               ),
                                  .TEN          ( 1'b0               ),
                                  .TCEN         ( 1'b0               ),
                                  .TWEN         ( 1'b0               ),
                                  .TA           ( 12'd0 ),  // same width as Address
                                  .TD           ( 57'd0 ),  // same width as data
                                  .SI           ( 2'b00              ),
                                  .SE           ( 1'b0               ),

                                  .RET1N         ( 1'b0               ),
                                  .DFTRAMBYP     ( 1'b0               )
          );

      end
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 4096) && (GENERIC_MEM_DATA_WIDTH == 21) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p4096x21cm16sw0ltlc1 mem1p4096x21( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8192) && (GENERIC_MEM_DATA_WIDTH == 52) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p8192x52cm16sw0ltlc1 mem1p8192x52( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 8192) && (GENERIC_MEM_DATA_WIDTH == 57) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    sasslnpky1p8192x57cm16sw0ltlc1 mem1p8192x57( 
                   // Port A
                   .CLK        ( clk                              ),
                   .WE         ( portA_write_dly                  ),
                   .ME         ( portA_enable_dly                 ),
                   .ADR        ( portA_address_dly                ),
                   .D          ( portA_write_data_dly             ),
                   .Q          ( int_portA_read_data_dly          ),
                
                
                   .TEST1      ( 1'b0 ),
                   .RME        ( 1'b1 ),
                   .RM         ( 4'b0011));
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 16384) && (GENERIC_MEM_DATA_WIDTH == 12) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    if (T65NM == 1)
      begin
    
        sasslnpky1p16384x12cm16sw0ltlc1 mem1p16384x12( 
                       // Port A
                       .CLK        ( clk                              ),
                       .WE         ( portA_write_dly                  ),
                       .ME         ( portA_enable_dly                 ),
                       .ADR        ( portA_address_dly                ),
                       .D          ( portA_write_data_dly             ),
                       .Q          ( int_portA_read_data_dly          ),
                    
                    
                       .TEST1      ( 1'b0 ),
                       .RME        ( 1'b1 ),
                       .RM         ( 4'b0011));
      end
    else if (T28NM == 1)
      begin
        //wire int_TA = 
        arm_sram_28nm_1p16384x12mw32 mem1p16384x12(

                                   // Port
                                  .CLK          ( clk                     ),
                                  .CEN          (~portA_enable_dly        ),
                                  .WEN          (~portA_write_dly         ),
                                  .A            ( portA_address_dly       ),
                                  .D            ( portA_write_data_dly    ),
                                  .Q            ( int_portB_read_data_dly ),
                                                

                                  // Test/Configuration
                                  // Outputs 
                                  .CENY         (  ),
                                  .WENY         (  ),
                                  .AY           (  ),
                                  .SO           (  ),
                                  // Inputs 
                                  .EMA          ( 3'b000             ),
                                  .EMAW         ( 2'b00              ),
                                  .EMAS         ( 1'b0               ),
                                  .TEN          ( 1'b0               ),
                                  .TCEN         ( 1'b0               ),
                                  .TWEN         ( 1'b0               ),
                                  .TA           ( 14'd0 ),  // same width as Address
                                  .TD           ( 12'd0 ),  // same width as data
                                  .SI           ( 2'b00              ),
                                  .SE           ( 1'b0               ),

                                  .RET1N         ( 1'b0               ),
                                  .DFTRAMBYP     ( 1'b0               )
          );
   
      end
  end

//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 16384) && (GENERIC_MEM_DATA_WIDTH == 12) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 2))
  begin : dw_mem
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
                       .RMEA        ( 1'b1 ),
                       .RMA         ( 4'b0011),
                       .TEST1B      ( 1'b0 ),
                       .RMEB        ( 1'b1 ),
                       .RMB         ( 4'b0011));
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

    always @(*)
      begin
        case (portB_addrDecode)
          0:
             muxed_int_portB_read_data_dly = mem2p16384x12[0].local_int_portB_read_data_dly  ;
          1:                                                
             muxed_int_portB_read_data_dly = mem2p16384x12[1].local_int_portB_read_data_dly  ;
          2:                                                
             muxed_int_portB_read_data_dly = mem2p16384x12[2].local_int_portB_read_data_dly  ;
          3:                                                
             muxed_int_portB_read_data_dly = mem2p16384x12[3].local_int_portB_read_data_dly  ;
          4:                                                
             muxed_int_portB_read_data_dly = mem2p16384x12[4].local_int_portB_read_data_dly  ;
          5:                                                
             muxed_int_portB_read_data_dly = mem2p16384x12[5].local_int_portB_read_data_dly  ;
          6:                                                
             muxed_int_portB_read_data_dly = mem2p16384x12[6].local_int_portB_read_data_dly  ;
          7:                                                
             muxed_int_portB_read_data_dly = mem2p16384x12[7].local_int_portB_read_data_dly  ;
        endcase
      end

    assign int_portA_read_data_dly = muxed_int_portA_read_data_dly   ;
    assign int_portB_read_data_dly = muxed_int_portB_read_data_dly   ;

  end


//------------------------------------------------------------------------------------------------------------------------
//
else if ((GENERIC_MEM_DEPTH == 65536) && (GENERIC_MEM_DATA_WIDTH == 18) && (GENERIC_MEM_REGISTERED_OUT == 0) && (GENERIC_NUM_OF_PORTS == 1))
  begin : dw_mem
    wire  [1:0 ]                              portA_addrDecode                = portA_address_dly [15:14] ;

    for (gvi=0; gvi<4; gvi=gvi+1) 
      begin: mem1p16384x18
        wire           local_portA_enable_dly  = portA_enable_dly & (portA_addrDecode == gvi) ;
        wire  [GENERIC_MEM_DATA_WIDTH-1 :0  ]     local_int_portA_read_data_dly   ;
      
        sasslnpky1p16384x18cm16sw0ltlc1 mem1p16384x18( 
                       // Port A
                       .CLK        ( clk                              ),
                       .WE         ( portA_write_dly                  ),
                       .ME         ( local_portA_enable_dly           ),
                       .ADR        ( portA_address_dly [13:0]         ),
                       .D          ( portA_write_data_dly             ),
                       .Q          ( local_int_portA_read_data_dly    ),
                    
                    
                       .TEST1      ( 1'b0 ),
                       .RME        ( 1'b1 ),
                       .RM         ( 4'b0011));

      end

    // Mux read data
    reg   [GENERIC_MEM_DATA_WIDTH-1 :0  ]     muxed_int_portA_read_data_dly                               ;
  
    always @(*)
      begin
        case (portA_addrDecode)
          0:
             muxed_int_portA_read_data_dly = mem1p16384x18[0].local_int_portA_read_data_dly  ;
          1:                                                
             muxed_int_portA_read_data_dly = mem1p16384x18[1].local_int_portA_read_data_dly  ;
          2:                                                
             muxed_int_portA_read_data_dly = mem1p16384x18[2].local_int_portA_read_data_dly  ;
          3:                                                
             muxed_int_portA_read_data_dly = mem1p16384x18[3].local_int_portA_read_data_dly  ;
        endcase
      end

    assign int_portA_read_data_dly = muxed_int_portA_read_data_dly   ;

  end

