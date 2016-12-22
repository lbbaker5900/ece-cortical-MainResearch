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

// Out of band interface
interface std_pe_oob_ifc(
                           input bit clk_oob   , 
                           input bit reset_poweron );

    // Stack Bus - downstream Out-of-band
    // FIXME - right now type is a per lane signal??
    logic [`STACK_DOWN_INTF_TYPE_RANGE   ]       std__pe__oob_type        ;  // Control or Data, Vector or scalar

    logic                                        std__pe__oob_valid        ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       std__pe__oob_cntl         ;
    logic                                        pe__std__oob_ready        ;

    logic                                        sys__pe__allSynchronized  ;
    logic                                        pe__sys__thisSynchronized ;

    logic [`PE_PE_ID_RANGE               ]       sys__pe__peId             ;
    logic                                        pe__sys__ready            ;
    logic                                        pe__sys__complete         ;

    clocking cb_test @(posedge clk_oob);

        output       std__pe__oob_valid        ;
        output       std__pe__oob_cntl         ;
        input        pe__std__oob_ready        ;
        output       std__pe__oob_type         ;
    
        output       sys__pe__allSynchronized  ;
        input        pe__sys__thisSynchronized ;

        output       sys__pe__peId             ;
        input        pe__sys__ready            ;
        input        pe__sys__complete         ;

    endclocking : cb_test
 
    clocking cb_dut @(posedge clk_oob);
        input        std__pe__oob_type         ;
                                               
        input        std__pe__oob_valid        ;
        input        std__pe__oob_cntl         ;
        output       pe__std__oob_ready        ;
        input        std__pe__oob_type         ;
    
        input        sys__pe__allSynchronized  ;
        output       pe__sys__thisSynchronized ;

        input        sys__pe__peId             ;
        output       pe__sys__ready            ;
        output       pe__sys__complete         ;

    endclocking : cb_dut
 
    modport TB_PeArray2OobSys (
        clocking    cb_dut  ,
        input       reset_poweron 
    );
 
    modport TB_SysOob2PeArray (
        clocking    cb_test ,
        output      reset_poweron 
    );

endinterface : std_pe_oob_ifc

typedef virtual std_pe_oob_ifc.TB_SysOob2PeArray vSysOob2PeArray_T;
typedef virtual std_pe_oob_ifc.TB_PeArray2SysOob vPeArray2SysOob_T;


interface std_pe_lane_ifc(
                           input bit clk_lane   );

    // Stack Bus - downstream
    // FIXME - right now type is a per lane signal??
    logic [`STACK_DOWN_INTF_TYPE_RANGE   ]       std__pe__lane_type              ;  // Control or Data, Vector or scalar

    logic                                        pe__std__lane_strm0_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       std__pe__lane_strm0_cntl        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       std__pe__lane_strm0_data        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       std__pe__lane_strm0_data_mask   ;
    logic                                        std__pe__lane_strm0_data_valid  ;
 
    logic                                        pe__std__lane_strm1_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       std__pe__lane_strm1_cntl        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       std__pe__lane_strm1_data        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       std__pe__lane_strm1_data_mask   ;
    logic                                        std__pe__lane_strm1_data_valid  ;
 
    clocking cb_test @(posedge clk_lane);
        output       std__pe__lane_type              ;

        input        pe__std__lane_strm0_ready       ;
        output       std__pe__lane_strm0_cntl        ;
        output       std__pe__lane_strm0_data        ;
        output       std__pe__lane_strm0_data_mask   ;
        output       std__pe__lane_strm0_data_valid  ;
    
        input        pe__std__lane_strm1_ready       ;
        output       std__pe__lane_strm1_cntl        ;
        output       std__pe__lane_strm1_data        ;
        output       std__pe__lane_strm1_data_mask   ;
        output       std__pe__lane_strm1_data_valid  ;
    
    endclocking : cb_test
 
    clocking cb_dut @(posedge clk_lane);
        input        std__pe__lane_type              ;

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
    
    endclocking : cb_dut
 
    modport TB_PeArray2SysLane (
        clocking    cb_dut   
    );
 
    modport TB_SysLane2PeArray (
        clocking    cb_test  
    );

endinterface : std_pe_lane_ifc

typedef virtual std_pe_lane_ifc.TB_SysLane2PeArray vSysLane2PeArray_T;
typedef virtual std_pe_lane_ifc.TB_PeArray2SysLane vPeArray2SysLane_T;


interface stu_pe_lane_ifc(
                           input bit clk_lane   );

    // Stack Bus - upstream

    logic [`STACK_UP_INTF_TYPE_RANGE     ]       pe__stu__lane_type              ;  // Control or Data, Vector or scalar

    logic                                        stu__pe__lane_result_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       pe__stu__lane_result_cntl        ;
    logic [`PE_STU_LANE_RESULT_RANGE     ]       pe__stu__lane_result_data        ;
    logic [`PE_STU_LANE_RESULT_RANGE     ]       pe__stu__lane_result_data_mask   ;
    logic                                        pe__stu__lane_result_data_valid  ;
 
    clocking cb_test @(posedge clk_lane);
        output       pe__stu__lane_type               ;

        output       stu__pe__lane_result_ready       ;
        input        pe__stu__lane_result_cntl        ;
        input        pe__stu__lane_result_data        ;
        input        pe__stu__lane_result_data_mask   ;
        input        pe__stu__lane_result_data_valid  ;

    endclocking : cb_test
 
    clocking cb_dut @(posedge clk_lane);
        input        pe__stu__lane_type               ;

        input        stu__pe__lane_result_ready       ;
        output       pe__stu__lane_result_cntl        ;
        output       pe__stu__lane_result_data        ;
        output       pe__stu__lane_result_data_mask   ;
        inout        pe__stu__lane_result_data_valid  ;

    endclocking : cb_dut
 
    modport TB_PeArrayResult2Sys (
        clocking    cb_dut   
    );
 
    modport TB_Sys2PeArrayResult (
        clocking    cb_test  
    );

endinterface : stu_pe_lane_ifc

typedef virtual stu_pe_lane_ifc.TB_Sys2PeArrayResult vSys2PeArrayResult_T;
typedef virtual stu_pe_lane_ifc.TB_PeArrayResult2Sys vPeArrayResult2Sys_T;


interface sti_stOp_lane_ifc(
                           input bit clk   );

    // Stack Bus - downstream
    // FIXME - right now type is a stOpr lane signal??
    logic [`STACK_DOWN_INTF_TYPE_RANGE   ]       sti__stOp__lane_type              ;  // Control or Data, Vector or scalar

    logic                                        stOp__sti__lane_strm0_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       sti__stOp__lane_strm0_cntl        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       sti__stOp__lane_strm0_data        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       sti__stOp__lane_strm0_data_mask   ;
    logic                                        sti__stOp__lane_strm0_data_valid  ;
 
    logic                                        stOp__sti__lane_strm1_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       sti__stOp__lane_strm1_cntl        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       sti__stOp__lane_strm1_data        ;
    logic [`PE_STD_LANE_DATA_RANGE       ]       sti__stOp__lane_strm1_data_mask   ;
    logic                                        sti__stOp__lane_strm1_data_valid  ;
 
    // Stack Bus - upstream
    logic                                        stu__stOp__lane_strm0_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       stOp__stu__lane_strm0_cntl        ;
    logic [`PE_STU_LANE_RESULT_RANGE     ]       stOp__stu__lane_strm0_data        ;
    logic [`PE_STU_LANE_RESULT_RANGE     ]       stOp__stu__lane_strm0_data_mask   ;
    logic                                        stOp__stu__lane_strm0_data_valid  ;
 
    logic                                        stu__stOp__lane_strm1_ready       ;
    logic [`COMMON_STD_INTF_CNTL_RANGE   ]       stOp__stu__lane_strm1_cntl        ;
    logic [`PE_STU_LANE_RESULT_RANGE     ]       stOp__stu__lane_strm1_data        ;
    logic [`PE_STU_LANE_RESULT_RANGE     ]       stOp__stu__lane_strm1_data_mask   ;
    logic                                        stOp__stu__lane_strm1_data_valid  ;
 
    clocking cb_dut @(posedge clk);
        output       sti__stOp__lane_type              ;

        input        stOp__sti__lane_strm0_ready       ;
        output       sti__stOp__lane_strm0_cntl        ;
        output       sti__stOp__lane_strm0_data        ;
        output       sti__stOp__lane_strm0_data_mask   ;
        output       sti__stOp__lane_strm0_data_valid  ;
    
        input        stOp__sti__lane_strm1_ready       ;
        output       sti__stOp__lane_strm1_cntl        ;
        output       sti__stOp__lane_strm1_data        ;
        output       sti__stOp__lane_strm1_data_mask   ;
        output       sti__stOp__lane_strm1_data_valid  ;
    
        output       stu__stOp__lane_strm0_ready       ;
        input        stOp__stu__lane_strm0_cntl        ;
        input        stOp__stu__lane_strm0_data        ;
        input        stOp__stu__lane_strm0_data_mask   ;
        input        stOp__stu__lane_strm0_data_valid  ;

        output       stu__stOp__lane_strm1_ready       ;
        input        stOp__stu__lane_strm1_cntl        ;
        input        stOp__stu__lane_strm1_data        ;
        input        stOp__stu__lane_strm1_data_mask   ;
        input        stOp__stu__lane_strm1_data_valid  ;
    endclocking : cb_dut
 
    clocking cb_test @(posedge clk);
        input        sti__stOp__lane_type              ;

        output       stOp__sti__lane_strm0_ready       ;
        input        sti__stOp__lane_strm0_cntl        ;
        input        sti__stOp__lane_strm0_data        ;
        input        sti__stOp__lane_strm0_data_mask   ;
        inout        sti__stOp__lane_strm0_data_valid  ;
    
        output       stOp__sti__lane_strm1_ready       ;
        input        sti__stOp__lane_strm1_cntl        ;
        input        sti__stOp__lane_strm1_data        ;
        input        sti__stOp__lane_strm1_data_mask   ;
        inout        sti__stOp__lane_strm1_data_valid  ;
    
        input        stu__stOp__lane_strm0_ready       ;
        output       stOp__stu__lane_strm0_cntl        ;
        output       stOp__stu__lane_strm0_data        ;
        output       stOp__stu__lane_strm0_data_mask   ;
        inout        stOp__stu__lane_strm0_data_valid  ;

        input        stu__stOp__lane_strm1_ready       ;
        output       stOp__stu__lane_strm1_cntl        ;
        output       stOp__stu__lane_strm1_data        ;
        output       stOp__stu__lane_strm1_data_mask   ;
        inout        stOp__stu__lane_strm1_data_valid  ;
    endclocking : cb_test
 
    modport TB_StOp2Sti (
        clocking    cb_test   
    );
 
    modport TB_Sti2StOp (
        clocking    cb_dut  
    );

endinterface : sti_stOp_lane_ifc

typedef virtual sti_stOp_lane_ifc.TB_Sti2StOp vSti2StOp_T;
typedef virtual sti_stOp_lane_ifc.TB_StOp2Sti vStOp2Sti_T;


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

typedef virtual pe_dma2mem_ifc.TB_Dma2Mem vDma2Mem_T;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Regfile interface to streamingOps_cntl

interface regFileScalar2stOpCntl_ifc  (
                           input bit clk   );

    // RegFile Scalars -> stOp Controller
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  rs0  ;
    logic [`PE_EXEC_LANE_WIDTH_RANGE]  rs1  ;

  clocking cb_in @(posedge clk);
      input        rs0 , 
                   rs1 ;

  endclocking : cb_in

  clocking cb_out @(posedge clk);
      output       rs0 , 
                   rs1 ;

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

typedef virtual regFileLane2stOpCntl_ifc.TB_regFileLaneDrv2stOpCntl     vRegFileLaneDrv2stOpCntl_T ;
typedef virtual stOpCntlFromRegFileLane_ifc.TB_stOpCntlFromRegFileLane  vStOpCntlFromRegFileLane_T ;


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

