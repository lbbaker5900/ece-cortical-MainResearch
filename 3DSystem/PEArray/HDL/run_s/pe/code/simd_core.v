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
`include "pe_cntl.vh"
`include "simd_core.vh"
`include "simd_wrapper.vh"
`include "stack_interface.vh"
`include "noc_cntl.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"


module simd_core (
                    //----------------------------------------------------------------------------------------------------
                    // Control
                    input  wire                                           cntl__simd__valid            ,
                    input  wire   [`PE_CNTL_OOB_OPTION_RANGE         ]    cntl__simd__pc               , 

                    input  wire                                           cntl__simd__start            ,
                    input  wire  [`COMMON_STD_INTF_CNTL_RANGE        ]    smdw__simd__regs_cntl   [`PE_NUM_OF_EXEC_LANES ] ,
                    input  wire  [`PE_EXEC_LANE_WIDTH_RANGE          ]    smdw__simd__regs        [`PE_NUM_OF_EXEC_LANES ] ,

                    output reg                                            simd__smdw__complete         ,
                    output reg   [`COMMON_STD_INTF_CNTL_RANGE        ]    simd__smdw__regs_cntl   [`PE_NUM_OF_EXEC_LANES ] ,
                    output reg   [`PE_EXEC_LANE_WIDTH_RANGE          ]    simd__smdw__regs        [`PE_NUM_OF_EXEC_LANES ] ,
                  
                    //----------------------------------------------------------------------------------------------------
                    // interface to LD/ST unit                                         
                    output reg                                            ldst__memc__request          ,
                    input  wire                                           memc__ldst__granted          ,
                    output reg                                            ldst__memc__released         ,
                    //                                                   
                    output reg                                            ldst__memc__write_valid     , 
                    output reg   [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]    ldst__memc__write_address   ,
                    output reg   [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]    ldst__memc__write_data      , 
                    input  wire                                           memc__ldst__write_ready     ,
                    output reg                                            ldst__memc__read_valid      , 
                    output reg   [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]    ldst__memc__read_address    ,
                    input  wire  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]    memc__ldst__read_data       , 
                    input  wire                                           memc__ldst__read_data_valid , 
                    input  wire                                           memc__ldst__read_ready      , 
                    output reg                                            ldst__memc__read_pause      , 
                  
                    //----------------------------------------------------------------------------------------------------
                    // System
                    input  wire   [`PE_PE_ID_RANGE                   ]    peId                        , 
                    input  wire                                           clk                         ,
                    input  wire                                           reset_poweron               
                  
/*
                          //-------------------------------
                          // Control
                          cntl__simd__start           ,
                          cntl__simd__pc              ,
                          simd__cntl__complete        ,

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
*/
    );

  //----------------------------------------------------------------------------------------------------
  // Registers/Wires
  //

  always @(posedge clk)
    begin
      simd__smdw__complete  <= ( reset_poweron )  ?  1'b0  : cntl__simd__start     ;
    end

  always @(posedge clk)
    begin
      simd__smdw__regs_cntl  <= smdw__simd__regs_cntl   ;
      simd__smdw__regs       <= smdw__simd__regs        ;
    end
  /*
  genvar lane;
  generate
    for (lane=0; lane<`PE_NUM_OF_EXEC_LANES; lane++)
      begin
        always @(posedge clk)
          begin
            simd__smdw__regs_cntl [lane] <= smdw__simd__regs_cntl [lane]  ;
            simd__smdw__regs      [lane] <= smdw__simd__regs      [lane]  ;
          end
      end
  endgenerate
  */
  
  always @(posedge clk)
    begin
      ldst__memc__request         <= 'd0 ;
      ldst__memc__released        <= 'd1 ;
      
      ldst__memc__write_valid     <= 'd0 ; 
      ldst__memc__write_address   <= 'd0 ;
      ldst__memc__write_data      <= 'd0 ; 
      ldst__memc__read_valid      <= 'd0 ; 
      ldst__memc__read_address    <= 'd0 ;
      ldst__memc__read_pause      <= 'd0 ; 
    end

endmodule

