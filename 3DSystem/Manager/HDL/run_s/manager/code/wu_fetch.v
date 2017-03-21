/*********************************************************************************************

    File name   : wu_fetch.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Mar 2017
    email       : lbbaker@ncsu.edu

    Description : This module reads the WU memory
                  The initial wu_addr is from the system

*********************************************************************************************/
    
`timescale 1ns/10ps

`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "manager_array.vh"
`include "manager.vh"
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "pe_cntl.vh"
`include "noc_cntl.vh"
`include "mem_acc_cont.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "wu_fetch.vh"


module wu_fetch (

            //-------------------------------
            // WU Memory
            //
            wuf__wum__read                             ,
            wuf__wum__addr                             ,
            
            //-------------------------------
            // Configuration
            mcntl__wuf__enable                           ,
            mcntl__wuf__start_addr                       ,
            
            //-------------------------------
            //
            xxx__wuf__stall                            ,

            //-------------------------------
            // General
            //
            clk              ,
            reset_poweron    
 
    );

  //----------------------------------------------------------------------------------------------------
  // General

  input                                     clk                          ;
  input                                     reset_poweron                ;

  //----------------------------------------------------------------------------------------------------
  // Control

  input                                     mcntl__wuf__enable             ;  // start fetching
  input  [`MGR_WU_ADDRESS_RANGE    ]        mcntl__wuf__start_addr         ;  // first WU address
  input                                     xxx__wuf__stall                ;

  //----------------------------------------------------------------------------------------------------
  // WU Memory

  output [`MGR_WU_ADDRESS_RANGE    ]        wuf__wum__addr                 ;
  output                                    wuf__wum__read                 ;


  //----------------------------------------------------------------------------------------------------
  // Registers/Wires

  reg                                       mcntl__wuf__enable_d1          ;  // first WU address
  reg  [`MGR_WU_ADDRESS_RANGE    ]          mcntl__wuf__start_addr_d1      ;  // first WU address

  reg  [`MGR_WU_ADDRESS_RANGE    ]          wuf__wum__addr                 ;
  reg                                       wuf__wum__read                 ;

  wire [`MGR_WU_ADDRESS_RANGE    ]          wuf__wum__addr_e1              ;
  wire                                      wuf__wum__read_e1              ;

  //----------------------------------------------------------------------------------------------------
  // Registered Inputs and Outputs

  always @(posedge clk)
    begin
      mcntl__wuf__enable_d1     <= ( reset_poweron   ) ? 'd0  :  mcntl__wuf__enable      ;
      mcntl__wuf__start_addr_d1 <= ( reset_poweron   ) ? 'd0  :  mcntl__wuf__start_addr  ;
      wuf__wum__addr            <= ( reset_poweron   ) ? 'd0  :  wuf__wum__addr_e1       ;
      wuf__wum__read            <= ( reset_poweron   ) ? 'd0  :  wuf__wum__read_e1       ;

    end



endmodule



