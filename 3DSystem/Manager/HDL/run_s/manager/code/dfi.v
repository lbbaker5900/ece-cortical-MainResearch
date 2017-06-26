/*********************************************************************************************

    File name   : dfi.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Apr 2016
    email       : lbbaker@ncsu.edu

    Description : This module is the top module for DFI. it interface with diram_port_model
                  and sch

    Revision    :
            ID     : 1
            Date   : 13 Apr 2016
            Name   : lbbaker@ncsu.edu
            Description : Not really DFI, only converts SDR to DSDR

*********************************************************************************************/

`timescale 1ns/10ps

`include "mc.vh"
`include "dfi.vh"


module dfi( 
                    dfi__sch__init_done        ,
                                               
                    sch__dfi__addr             ,
                    sch__dfi__bank             ,
                    sch__dfi__cs               ,
                    sch__dfi__cmd0             , 
                    sch__dfi__cmd1             ,
                    sch__dfi__wrdata           ,
                    dfi__sch__rddata           ,
                    dfi__sch__rddata_valid     ,

                    clk_diram_ck               ,
                    dfi__phy__cmd1             , 
                    dfi__phy__cmd0             ,
                    dfi__phy__addr             ,
                    dfi__phy__bank             ,
                    dfi__phy__wrdata           ,

                    clk_diram_cq               ,
                    phy__dfi__rddata_valid     ,
                    phy__dfi__rddata           ,

                    //control module signal
                    clk                        ,
                    clk_diram                  ,
                    clk_diram2x                ,
                    reset                      

                    );
    
parameter DIRAM_WIDTH           = 32 ;
parameter burst_length_dsdr     = 2  ;
parameter PORT_NO               = 5  ;
parameter OCP_WIDTH             = DIRAM_WIDTH * burst_length_dsdr; // interface at dfi is 2x interface at dram. SDR -> DDR

input           clk         ;
input           clk_diram   ; 
input           clk_diram2x ; 
input           reset       ;

output          dfi__sch__init_done   ;

//----------------------------------------------------------------------------------------------
// DFI Interface
//
input                                        sch__dfi__cs       ;
input                                        sch__dfi__cmd1     ;
input                                        sch__dfi__cmd0     ;
input   [`DFI_TOP_DIRAM4_ADDRESS_RANGE   ]   sch__dfi__addr     ; //12 bit page select and 4 bit block select both use this signal exclusively
input   [`DFI_TOP_DIRAM4_BANK_RANGE      ]   sch__dfi__bank     ; // selection of bank

input    [OCP_WIDTH*PORT_NO-1:0]             sch__dfi__wrdata       ; // write ocp bus for 4 ports, 1024    
output   [OCP_WIDTH*PORT_NO-1:0]             dfi__sch__rddata       ; // read ocp bus for 4 ports, 1024    
output                                       dfi__sch__rddata_valid ;    


//----------------------------------------------------------------------------------------------
// Diram4 Interface
//
output                                     clk_diram_ck      ; // diram input clock
output                                     dfi__phy__cmd1    ;
output                                     dfi__phy__cmd0    ;
output  [`DFI_TOP_DIRAM4_ADDRESS_RANGE  ]  dfi__phy__addr    ;
output  [`DFI_TOP_DIRAM4_BANK_RANGE     ]  dfi__phy__bank    ;
output  [DIRAM_WIDTH*PORT_NO-1:0]          dfi__phy__wrdata  ; //data in bus for 4 ports, 128
                                           
input                                      clk_diram_cq             ; // diram output clock
input                                      phy__dfi__rddata_valid   ; //qvld
input   [DIRAM_WIDTH*PORT_NO-1:0]          phy__dfi__rddata         ; //data out bus for 4 ports, 128


wire            clk         ;
wire            clk_diram   ; 
wire            clk_diram2x ; 
wire            reset       ;
wire            init_done   ;

wire                                       sch__dfi__cs      ;
wire                                       sch__dfi__cmd1    ;
wire                                       sch__dfi__cmd0    ;
wire   [`DFI_TOP_DIRAM4_ADDRESS_RANGE   ]  sch__dfi__addr    ; //12 bit page select and 4 bit block select both use this signal exclusively
wire   [`DFI_TOP_DIRAM4_BANK_RANGE      ]  sch__dfi__bank    ; // selection of bank
wire    [OCP_WIDTH*PORT_NO-1:0]            sch__dfi__wrdata       ;    

reg     [OCP_WIDTH*PORT_NO-1:0]            dfi__sch__rddata       ;    
reg                                        dfi__sch__rddata_valid ;    

wire                                       clk_diram_ck      ; // diram input clock
wire                                       dfi__phy__cmd1    ;
wire                                       dfi__phy__cmd0    ;
wire  [`DFI_TOP_DIRAM4_ADDRESS_RANGE ]     dfi__phy__addr    ;
wire  [`DFI_TOP_DIRAM4_BANK_RANGE    ]     dfi__phy__bank    ;
                                          
wire    [DIRAM_WIDTH*PORT_NO-1:0]          dfi__phy__wrdata  ;

wire                                       clk_diram_cq             ; // diram output clock
wire                                       phy__dfi__rddata_valid   ; //qvld
wire    [DIRAM_WIDTH*PORT_NO-1:0]          phy__dfi__rddata         ;



assign init_done = ~reset ;  // FIXME

assign clk_diram_ck = clk;
assign dfi__phy__cs       = sch__dfi__cs      ;
assign dfi__phy__cmd1     = sch__dfi__cmd1    ;
assign dfi__phy__cmd0     = sch__dfi__cmd0    ;
assign dfi__phy__addr     = sch__dfi__addr    ;
assign dfi__phy__bank     = sch__dfi__bank    ;
assign dfi__phy__wrdata   = ( ~clk_diram_ck ) ? sch__dfi__wrdata[OCP_WIDTH*PORT_NO/2-1:0                ] :
                                                sch__dfi__wrdata[OCP_WIDTH*PORT_NO-1:OCP_WIDTH*PORT_NO/2] ;

wire #5 clk_diram_cq_dly = clk_diram_cq;
reg                                        dfi__sch__rddata_valid_e1 ;
reg                                        dfi__sch__rddata_valid_e2 ;
reg     [OCP_WIDTH*PORT_NO-1:0]            dfi__sch__rddata_e1       ;    
reg     [OCP_WIDTH*PORT_NO-1:0]            dfi__sch__rddata_e2       ;    
always @(posedge clk_diram_cq_dly)
  begin
    dfi__sch__rddata_e1[OCP_WIDTH*PORT_NO/2-1:0                ] <=  phy__dfi__rddata           ;
    dfi__sch__rddata_e2                                          <=  dfi__sch__rddata_e1        ;
    dfi__sch__rddata_valid_e2                                    <=  dfi__sch__rddata_valid_e1  ;
  end
always @(negedge clk_diram_cq_dly)
  begin
    dfi__sch__rddata_valid_e1                                    <=  phy__dfi__rddata_valid     ;
    dfi__sch__rddata_e1[OCP_WIDTH*PORT_NO-1:OCP_WIDTH*PORT_NO/2] <=  phy__dfi__rddata           ;
  end

always @(posedge clk)
  begin
    dfi__sch__rddata_valid <= ( reset ) ? 'b0 : dfi__sch__rddata_valid_e2 ;
    dfi__sch__rddata       <= ( reset ) ? 'b0 : dfi__sch__rddata_e2       ;
  end


endmodule
