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
`include "stack_interface.vh"
`include "stack_interface_typedef.vh"
`include "noc_interpe_port_Bitmasks.vh"


///////////////////////////////////////////////////////////////////////////////
// Downstream
///////////////////////////////////////////////////////////////////////////////

// Stack general interface
interface st_gen_ifc(
                           input bit clk   );

    logic                                       sys__pe__allSynchronized  ;
    logic                                       pe__sys__thisSynchronized ;
                                        
    logic                                       pe__sys__ready            ;
    logic                                       pe__sys__complete         ;

endinterface : st_gen_ifc

typedef virtual st_gen_ifc vGenStack_T;


// Out of band interface
interface std_oob_ifc(
                           input bit clk_oob   );

    // Stack Bus - downstream Out-of-band
    // FIXME - right now type is a per lane signal??
    stack_down_oob_type                         std__pe__oob_type        ;  // Control or Data, Vector or scalar
    logic [`STACK_DOWN_OOB_INTF_DATA_RANGE ]    std__pe__oob_data        ;  // e.g. {option type, option data}

    logic                                       std__pe__oob_valid        ;
    logic [`COMMON_STD_INTF_CNTL_RANGE  ]       std__pe__oob_cntl         ;
    logic                                       pe__std__oob_ready        ;
                                        
    logic                                       sys__pe__allSynchronized  ;
    logic                                       pe__sys__thisSynchronized ;
                                        
    logic                                       pe__sys__ready            ;
    logic                                       pe__sys__complete         ;

    clocking cb_test @(posedge clk_oob);

        output       std__pe__oob_valid        ;
        output       std__pe__oob_cntl         ;
        //input        pe__std__oob_ready        ;
        output       std__pe__oob_type         ;
        output       std__pe__oob_data         ;
    
        //output       sys__pe__allSynchronized  ;
        //input        pe__sys__thisSynchronized ;

        //input        pe__sys__ready            ;
        //input        pe__sys__complete         ;

    endclocking : cb_test
 
    clocking cb_dut @(posedge clk_oob);
        input        std__pe__oob_type         ;
                                               
        input        std__pe__oob_valid        ;
        input        std__pe__oob_cntl         ;
        //output       pe__std__oob_ready        ;
        input        std__pe__oob_type         ;
        input        std__pe__oob_data         ;
    
        //input        sys__pe__allSynchronized  ;
        //output       pe__sys__thisSynchronized ;

        //output       pe__sys__ready            ;
        //output       pe__sys__complete         ;

    endclocking : cb_dut
 
    modport TB_PeArray2OobSys (
        clocking    cb_dut   
    );
 
    modport TB_DownstreamStackBusOOB (
        clocking    cb_test  
    );

endinterface : std_oob_ifc

typedef virtual std_oob_ifc vDownstreamStackBusOOB_T;


interface std_lane_ifc(
                           input bit clk_lane   );

    // Stack Bus - downstream
    // FIXME - right now type is a per lane signal??
    logic [`STACK_DOWN_INTF_TYPE_RANGE   ]       std__pe__lane_type              ;  // Control or Data, Vector or scalar

    logic                                        pe__std__lane_strm0_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       std__pe__lane_strm0_cntl        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       std__pe__lane_strm0_data        ;
    logic                                        std__pe__lane_strm0_data_valid  ;
 
    logic                                        pe__std__lane_strm1_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       std__pe__lane_strm1_cntl        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       std__pe__lane_strm1_data        ;
    logic                                        std__pe__lane_strm1_data_valid  ;
 
    clocking cb_test @(posedge clk_lane);
        output       std__pe__lane_type              ;

        //input        pe__std__lane_strm0_ready       ;
        output       std__pe__lane_strm0_cntl        ;
        output       std__pe__lane_strm0_data        ;
        output       std__pe__lane_strm0_data_valid  ;
    
        //input        pe__std__lane_strm1_ready       ;
        output       std__pe__lane_strm1_cntl        ;
        output       std__pe__lane_strm1_data        ;
        output       std__pe__lane_strm1_data_valid  ;
    
    endclocking : cb_test
 
    clocking cb_dut @(posedge clk_lane);
        input        std__pe__lane_type              ;

        //output       pe__std__lane_strm0_ready       ;
        input        std__pe__lane_strm0_cntl        ;
        input        std__pe__lane_strm0_data        ;
        inout        std__pe__lane_strm0_data_valid  ;
    
        //output       pe__std__lane_strm1_ready       ;
        input        std__pe__lane_strm1_cntl        ;
        input        std__pe__lane_strm1_data        ;
        inout        std__pe__lane_strm1_data_valid  ;
    
    endclocking : cb_dut
 
    modport TB_PeArray2SysLane (
        clocking    cb_dut   
    );
 
    modport TB_SysLane2PeArray (
        clocking    cb_test  
    );

endinterface : std_lane_ifc

typedef virtual std_lane_ifc vSysLane2PeArray_T;


interface stu_ifc(
                           input bit clk   );

    // Stack Bus - upstream

    logic                                        pe__stu__valid       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__cntl        ;
    logic                                        stu__pe__ready       ;
    logic [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__type        ;  // Control or Data, Vector or scalar
    logic [`STACK_UP_INTF_DATA_RANGE     ]       pe__stu__data        ;
    logic [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe__stu__oob_data    ;
 
    // cant get &^*&^$# inputs to work
    // modports are complete crap, basically, dont *&%*%^ use them
    clocking cb_pe @(posedge clk);
        //output      stu__pe__ready        ;
        //input        pe__stu__valid       ;
        //input        pe__stu__cntl        ;
        //input        pe__stu__type        ;  // Control or Data, Vector or scalar
        //input        pe__stu__data        ;
        //input        pe__stu__oob_data    ;

    endclocking : cb_pe
 
    clocking cb_mgr @(posedge clk);
        //input         stu__pe__ready       ;
        //output        pe__stu__valid       ;
        //output        pe__stu__cntl        ;
        //output        pe__stu__type        ;  // Control or Data, Vector or scalar
        //output        pe__stu__data        ;
        //output        pe__stu__oob_data    ;

    endclocking : cb_mgr
 
    modport TB_Pe (
        clocking    cb_pe   
    );
 
    modport TB_Mgr (
        clocking    cb_mgr  
    );

endinterface : stu_ifc

typedef virtual stu_ifc vUpstreamStackBus_T;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Internal Probes
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// interface between dma and mem controller

interface pe_dma2mem_ifc (
                           input bit clk   );

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

  // This is a probe, so use only inputs
  clocking cb @(posedge clk);
      input   dma__memc__write_valid         , 
              dma__memc__write_address       ,
              dma__memc__write_data          ,
              dma__memc__read_valid          ,
              dma__memc__read_address        ,
              dma__memc__read_pause          ;

      input   memc__dma__write_ready         ,
              memc__dma__read_data           ,
              memc__dma__read_data_valid     ,
              memc__dma__read_ready          ;

  endclocking : cb

  modport TB_Dma2Mem (
                    clocking cb
  );

endinterface : pe_dma2mem_ifc 

//typedef virtual pe_dma2mem_ifc.TB_Dma2Mem vDma2Mem_T;

typedef virtual pe_dma2mem_ifc vDma2Mem_T;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Regfile interface to streamingOps_cntl

interface regFileScalar2stOpCntl_ifc  (
                           input bit clk   );

    // RegFile Scalars -> stOp Controller
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  rs0       ;
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  rs1       ;
    logic                              ready     ;
    logic                              complete  ;

  clocking cb_in @(posedge clk);
      input        rs0      , 
                   rs1      ;
      output       ready    ;
      output       complete ;

  endclocking : cb_in

  clocking cb_out @(posedge clk);
      output       rs0      , 
                   rs1      ;
      input        ready    ;
      input        complete ;

  endclocking : cb_out

  modport TB_regFileScalarDrv2stOpCntl (
                    clocking cb_out
  );

  modport TB_stOpCntlFromRegFileScalar (
                    clocking cb_in
  );

endinterface : regFileScalar2stOpCntl_ifc

typedef virtual regFileScalar2stOpCntl_ifc     vRegFileScalarDrv2stOpCntl_T ;
typedef virtual stOpCntlFromRegFileScalar_ifc  vStOpCntlFromRegFileScalar_T ;

//typedef virtual regFileScalar2stOpCntl_ifc.TB_regFileScalarDrv2stOpCntl     vRegFileScalarDrv2stOpCntl_T ;
//typedef virtual stOpCntlFromRegFileScalar_ifc.TB_stOpCntlFromRegFileScalar  vStOpCntlFromRegFileScalar_T ;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Regfile interface to streamingOps_cntl

interface regFileLane2stOpCntl_ifc  (
                           input bit clk   );

    // RegFile Lanes -> stOp Controller
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  r128  ;
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  r129  ;
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  r130  ;
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  r131  ;
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  r132  ;
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  r133  ;
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  r134  ;
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  r135  ;

  clocking cb_in @(posedge clk);
      input        r128 , 
                   r129 ,
                   r130 ,
                   r131 ,
                   r132 ,
                   r133 ,
                   r134 ,
                   r135 ;

  endclocking : cb_in

  clocking cb_out @(posedge clk);
      output       r128 , 
                   r129 ,
                   r130 ,
                   r131 ,
                   r132 ,
                   r133 ,
                   r134 ,
                   r135 ;

  endclocking : cb_out

  modport TB_regFileLaneDrv2stOpCntl (
                    clocking cb_out
  );

  modport TB_stOpCntlFromRegFileLane (
                    clocking cb_in
  );

endinterface : regFileLane2stOpCntl_ifc

//typedef virtual regFileLane2stOpCntl_ifc.TB_regFileLaneDrv2stOpCntl     vRegFileLaneDrv2stOpCntl_T ;
//typedef virtual stOpCntlFromRegFileLane_ifc.TB_stOpCntlFromRegFileLane  vStOpCntlFromRegFileLane_T ;

typedef virtual regFileLane2stOpCntl_ifc     vRegFileLaneDrv2stOpCntl_T ;
typedef virtual stOpCntlFromRegFileLane_ifc  vStOpCntlFromRegFileLane_T ;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SIMD Load/Store interface to streamingOps_cntl

interface loadStore2memCntl_ifc  (
                           input bit clk   );

    // Load/Store -> mem Controller
    logic                                         ldst__memc__request          ;
    logic                                         memc__ldst__granted          ;
    logic                                         ldst__memc__released         ;
    // 
    logic                                         ldst__memc__write_valid     ; 
    logic  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__write_address   ;
    logic  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  ldst__memc__write_data      ; 
    logic                                         memc__ldst__write_ready     ;
    logic                                         ldst__memc__read_valid      ; 
    logic  [`MEM_ACC_CONT_MEMORY_ADDRESS_RANGE ]  ldst__memc__read_address    ;
    logic  [`MEM_ACC_CONT_MEMORY_DATA_RANGE    ]  memc__ldst__read_data       ; 
    logic                                         memc__ldst__read_data_valid ; 
    logic                                         memc__ldst__read_ready      ; 
    logic                                         ldst__memc__read_pause      ; 

  clocking cb_in @(posedge clk);
    input    ldst__memc__request         ;
    output   memc__ldst__granted         ;
    input    ldst__memc__released        ;
    // 
    input    ldst__memc__write_valid     ; 
    input    ldst__memc__write_address   ;
    input    ldst__memc__write_data      ; 
    output   memc__ldst__write_ready     ;
    input    ldst__memc__read_valid      ; 
    input    ldst__memc__read_address    ;
    output   memc__ldst__read_data       ; 
    output   memc__ldst__read_data_valid ; 
    output   memc__ldst__read_ready      ; 
    input    ldst__memc__read_pause      ; 

  endclocking : cb_in

  clocking cb_out @(posedge clk);
    output   ldst__memc__request         ;
    input    memc__ldst__granted         ;
    output   ldst__memc__released        ;
    // 
    output   ldst__memc__write_valid     ; 
    output   ldst__memc__write_address   ;
    output   ldst__memc__write_data      ; 
    input    memc__ldst__write_ready     ;
    output   ldst__memc__read_valid      ; 
    output   ldst__memc__read_address    ;
    input    memc__ldst__read_data       ; 
    input    memc__ldst__read_data_valid ; 
    input    memc__ldst__read_ready      ; 
    output   ldst__memc__read_pause      ; 

  endclocking : cb_out

  modport TB_loadStoreDrv2memCntl (
                    clocking cb_out
  );

  modport TB_memCntlFromLoadStore (
                    clocking cb_in
  );

endinterface : loadStore2memCntl_ifc

typedef virtual loadStore2memCntl_ifc     vLoadStoreDrv2memCntl_T  ;
typedef virtual memCntlFromLoadStore_ifc  vMemCntlFromLoadStore_T  ;

//typedef virtual loadStore2memCntl_ifc.TB_loadStoreDrv2memCntl     vLoadStoreDrv2memCntl_T ;
//typedef virtual memCntlFromLoadStore_ifc.TB_memCntlFromLoadStore  vMemCntlFromLoadStore_T ;

