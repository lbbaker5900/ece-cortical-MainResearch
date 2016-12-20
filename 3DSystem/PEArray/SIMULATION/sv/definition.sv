package virtual_interface;
`timescale 1ns/10ps
    typedef virtual std_pe_oob_ifc.vSysOob2PeArray_T        vSysOob2PeArray_T       ;
    typedef virtual std_pe_oob_ifc.vPeArray2SysOob_T        vPeArray2SysOob_T       ;
    typedef virtual std_pe_lane_ifc.vSysLane2PeArray_T      vSysLane2PeArray_T      ;
    typedef virtual std_pe_lane_ifc.vPeArray2SysLane_T      vPeArray2SysLane_T      ;
    typedef virtual std_pe_lane_ifc.vPeArrayResult2Sys_T    vPeArrayResult2Sys_T    ;
    typedef virtual std_pe_lane_ifc.vSys2PeArrayResult_T    vSys2PeArrayResult_T    ;
    typedef virtual sti_stOp_lane_ifc.vSti2StOp_T           vSti2StOp_T             ;
    typedef virtual sti_stOp_lane_ifc.vStOp2Sti_T           vStOp2Sti_T             ;
    typedef virtual pe_dma2mem_ifc.vDma2Mem_T               vDma2Mem_T              ;
    // FIXME : add more see MC 
endpackage:virtual_interface
    
