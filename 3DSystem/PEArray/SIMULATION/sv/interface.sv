/*********************************************************************************************
    File name   : stack_bus_interface.sv
    Author      : Lee Baker
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : Nov 2016
    Email       : lbbaker@ncsu.edu
    
    Description : This file contains:
                    - stack bus downstream
                    - stack bus upstream
*********************************************************************************************/

`timescale 1ns/10ps

`include "common.vh"
`include "streamingOps_cntl.vh"
`include "streamingOps.vh"
`include "dma_cont.vh"
`include "mem_acc_cont.vh"
`include "pe.vh"
`include "pe_array.vh"
`include "noc_interpe_port_Bitmasks.vh"


///////////////////////////////////////////////////////////////////////////////
// Downstream
///////////////////////////////////////////////////////////////////////////////
interface std_pe_lane_ifc(
                           input bit clk   , 
                           input bit reset );

    // Stack Bus - downstream
    logic                                        pe__std__lane_strm0_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       std__pe__lane_strm0_cntl        ;
    logic [`PE_STD_LANE_WIDTH_RANGE      ]       std__pe__lane_strm0_data        ;
    logic [`PE_STD_LANE_WIDTH_RANGE      ]       std__pe__lane_strm0_data_mask   ;
    logic                                        std__pe__lane_strm0_data_valid  ;
 
    logic                                        pe__std__lane_strm1_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       std__pe__lane_strm1_cntl        ;
    logic [`PE_STD_LANE_WIDTH_RANGE      ]       std__pe__lane_strm1_data        ;
    logic [`PE_STD_LANE_WIDTH_RANGE      ]       std__pe__lane_strm1_data_mask   ;
    logic                                        std__pe__lane_strm1_data_valid  ;
 
    // Stack Bus - upstream
    logic                                        stu__pe__lane_strm0_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__lane_strm0_cntl        ;
    logic [`PE_STU_LANE_WIDTH_RANGE      ]       pe__stu__lane_strm0_data        ;
    logic [`PE_STU_LANE_WIDTH_RANGE      ]       pe__stu__lane_strm0_data_mask   ;
    logic                                        pe__stu__lane_strm0_data_valid  ;
 
    logic                                        stu__pe__lane_strm1_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__lane_strm1_cntl        ;
    logic [`PE_STU_LANE_WIDTH_RANGE      ]       pe__stu__lane_strm1_data        ;
    logic [`PE_STU_LANE_WIDTH_RANGE      ]       pe__stu__lane_strm1_data_mask   ;
    logic                                        pe__stu__lane_strm1_data_valid  ;
 
    clocking cb_test @(posedge clk);
        input        pe__std__lane_strm0_ready       ;
        output       std__pe__lane_strm0_cntl        ;
        output       std__pe__lane_strm0_data        ;
        output       std__pe__lane_strm0_data_mask   ;
        output        std__pe__lane_strm0_data_valid  ;
    
        input        pe__std__lane_strm1_ready       ;
        output       std__pe__lane_strm1_cntl        ;
        output       std__pe__lane_strm1_data        ;
        output       std__pe__lane_strm1_data_mask   ;
        output        std__pe__lane_strm1_data_valid  ;
    
        output       stu__pe__lane_strm0_ready       ;
        input        pe__stu__lane_strm0_cntl        ;
        input        pe__stu__lane_strm0_data        ;
        input        pe__stu__lane_strm0_data_mask   ;
        input        pe__stu__lane_strm0_data_valid  ;

        output       stu__pe__lane_strm1_ready       ;
        input        pe__stu__lane_strm1_cntl        ;
        input        pe__stu__lane_strm1_data        ;
        input        pe__stu__lane_strm1_data_mask   ;
        input        pe__stu__lane_strm1_data_valid  ;
    endclocking : cb_test
 
    clocking cb_dut @(posedge clk);
        output       pe__std__lane_strm0_ready       ;
        input        std__pe__lane_strm0_cntl        ;
        input        std__pe__lane_strm0_data        ;
        input        std__pe__lane_strm0_data_mask   ;
        inout        std__pe__lane_strm0_data_valid  ;
    
        output       pe__std__lane_strm1_ready       ;
        input        std__pe__lane_strm1_cntl        ;
        input        std__pe__lane_strm1_data        ;
        input        std__pe__lane_strm1_data_mask   ;
        inout        std__pe__lane_strm1_data_valid  ;
    
        input        stu__pe__lane_strm0_ready       ;
        output       pe__stu__lane_strm0_cntl        ;
        output       pe__stu__lane_strm0_data        ;
        output       pe__stu__lane_strm0_data_mask   ;
        inout        pe__stu__lane_strm0_data_valid  ;

        input        stu__pe__lane_strm1_ready       ;
        output       pe__stu__lane_strm1_cntl        ;
        output       pe__stu__lane_strm1_data        ;
        output       pe__stu__lane_strm1_data_mask   ;
        inout        pe__stu__lane_strm1_data_valid  ;
    endclocking : cb_dut
 
    modport TB_PeArray2Sys (
        clocking    cb_dut  ,
        input       reset 
    );
 
    modport TB_Sys2PeArray (
        clocking    cb_test ,
        output      reset 
    );

//  `include "coverage.svh"

endinterface : std_pe_lane_ifc

typedef virtual std_pe_lane_ifc.TB_Sys2PeArray vSys2PeArray_T;


/////////////////////////////////////////////////////////////////////////
// interface between dma and mem controller
/////////////////////////////////////////////////////////////////////////
interface pe_dma2mem_ifc (
                           input bit clk   , 
                           input bit reset );

  // DMA <-> Memory port 
    logic                                          dma__memc__write_valid     ;
    logic   [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__write_address   ;
    logic   [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  dma__memc__write_data      ;
    logic                                          memc__dma__write_ready     ;
    logic                                          dma__memc__read_valid      ;
    logic   [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  dma__memc__read_address    ;
    logic   [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__dma__read_data       ;
    logic                                          memc__dma__read_data_valid ;
    logic                                          memc__dma__read_ready      ;
    logic                                          dma__memc__read_pause      ;

  clocking cb @(posedge clk);
      input   dma__memc__write_valid         , 
              dma__memc__write_address       ,
              dma__memc__write_data          ,
              dma__memc__read_valid          ,
              dma__memc__read_address        ,
              dma__memc__read_pause          ;

      output  memc__dma__write_ready         ,
              memc__dma__read_data           ,
              memc__dma__read_data_valid     ,
              memc__dma__read_ready          ;

  endclocking : cb

  modport TB_Dma2Mem (
                    clocking cb
  );

endinterface : pe_dma2mem_ifc 

typedef virtual pe_dma2mem_ifc.TB_Dma2Mem vDma2Mem_T;

