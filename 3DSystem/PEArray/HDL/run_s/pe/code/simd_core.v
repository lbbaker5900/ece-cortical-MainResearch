/*********************************************************************************************

    File name   : simd_wrapper.v
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : June 2017
    email       : lbbaker@ncsu.edu

    Description : This module contains the SIMD unit


*********************************************************************************************/
    
`timescale 1ns/10ps
`include "common.vh"
`include "pe_array.vh"
`include "pe.vh"
`include "simd_core.vh"
`include "simd_wrapper.vh"
`include "stack_interface.vh"
`include "noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"


module simd_core (

                          //-------------------------------
                          // LD/ST Interface
                          ldst__memc__request         ,
                          memc__ldst__granted         ,
                          ldst__memc__released        ,
                       
                          ldst__memc__write_valid     ,  // Valid must remain active for entire DMA
                          ldst__memc__write_address   ,
                          ldst__memc__write_data      ,
                          memc__ldst__write_ready     ,  // output flow control to ldst
                          ldst__memc__read_valid      ,
                          ldst__memc__read_address    ,
                          memc__ldst__read_data       ,
                          memc__ldst__read_data_valid ,  // Valid must remain active for entire DMA, only accepted when ready is asserted
                          memc__ldst__read_ready      ,  // output flow control to ldst, valid only "valid" when ready is asserted
                          ldst__memc__read_pause      ,  // pipeline flow control from ldst, dont send any more requests

                          //--------------------------------------------------------
                          // System
                          peId              ,
                          clk               ,
                          reset_poweron     
    );

  input                       clk            ;
  input                       reset_poweron  ;
  input [`PE_PE_ID_RANGE   ]  peId           ; 


  //----------------------------------------------------------------------------------------------------
  // interface to LD/ST unit                                         
  output                                        ldst__memc__request          ;
  input                                         memc__ldst__granted          ;
  output                                        ldst__memc__released         ;
  // 
  output                                        ldst__memc__write_valid     ; 
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__write_address   ;
  output [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  ldst__memc__write_data      ; 
  input                                         memc__ldst__write_ready     ;
  output                                        ldst__memc__read_valid      ; 
  output [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__read_address    ;
  input  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__ldst__read_data       ; 
  input                                         memc__ldst__read_data_valid ; 
  input                                         memc__ldst__read_ready      ; 
  output                                        ldst__memc__read_pause      ; 


  
endmodule

