package virtual_interface;
`timescale 1ns/10ps
    //typedef virtual std_pe_oob_ifc.vSysOob2PeArray_T                             vSysOob2PeArray_T             ;
    //typedef virtual std_pe_oob_ifc.vPeArray2SysOob_T                             vPeArray2SysOob_T             ;
    //typedef virtual std_pe_lane_ifc.vSysLane2PeArray_T                           vSysLane2PeArray_T            ;
    //typedef virtual std_pe_lane_ifc.vPeArray2SysLane_T                           vPeArray2SysLane_T            ;
    //typedef virtual std_pe_lane_ifc.vPeArrayResult2Sys_T                         vPeArrayResult2Sys_T          ;
    //typedef virtual std_pe_lane_ifc.vSys2PeArrayResult_T                         vSys2PeArrayResult_T          ;
    //typedef virtual sti_stOp_lane_ifc.vSti2StOp_T                                vSti2StOp_T                   ;
    //typedef virtual sti_stOp_lane_ifc.vStOp2Sti_T                                vStOp2Sti_T                   ;
    //typedef virtual pe_dma2mem_ifc.vDma2Mem_T                                    vDma2Mem_T                    ;
    //typedef virtual regFileScalar2stOpCntl_ifc.vRegFileScalarDrv2stOpCntl_T      vRegFileScalarDrv2stOpCntl_T  ;
    //typedef virtual regFileScalar2stOpCntl_ifc.vStOpCntlFromRegFileScalar_T      vStOpCntlFromRegFileScalar_T  ;
    //typedef virtual regFileLane2stOpCntl_ifc.vRegFileLaneDrv2stOpCntl_T          vRegFileLaneDrv2stOpCntl_T    ;
    //typedef virtual regFileLane2stOpCntl_ifc.vStOpCntlFromRegFileLane_T          vStOpCntlFromRegFileLane_T    ;
    //typedef virtual loadStore2memCntl_ifc.vLoadStoreDrv2memCntl_T                vLoadStoreDrv2memCntl_T       ;
    //typedef virtual loadStore2memCntl_ifc.vMemCntlFromLoadStore_T                vMemCntlFromLoadStore_T       ;

    // dont use ^&(&%$%%$^%g modports - FIXME do all below
    typedef virtual std_pe_oob_ifc                             vSysOob2PeArray_T             ;
    typedef virtual std_pe_oob_ifc                             vPeArray2SysOob_T             ;
    typedef virtual std_pe_lane_ifc.vSysLane2PeArray_T                           vSysLane2PeArray_T            ;
    typedef virtual std_pe_lane_ifc.vPeArray2SysLane_T                           vPeArray2SysLane_T            ;
    typedef virtual std_pe_lane_ifc.vPeArrayResult2Sys_T                         vPeArrayResult2Sys_T          ;
    typedef virtual std_pe_lane_ifc.vSys2PeArrayResult_T                         vSys2PeArrayResult_T          ;
    typedef virtual sti_stOp_lane_ifc                          vSti2StOp_T                   ;
    typedef virtual sti_stOp_lane_ifc                          vStOp2Sti_T                   ;
    typedef virtual pe_dma2mem_ifc.vDma2Mem_T                                    vDma2Mem_T                    ;
    typedef virtual regFileScalar2stOpCntl_ifc                 vRegFileScalarDrv2stOpCntl_T  ;
    typedef virtual regFileScalar2stOpCntl_ifc                 vStOpCntlFromRegFileScalar_T  ;
    typedef virtual regFileLane2stOpCntl_ifc                   vRegFileLaneDrv2stOpCntl_T    ;
    typedef virtual regFileLane2stOpCntl_ifc                   vStOpCntlFromRegFileLane_T    ;
    typedef virtual loadStore2memCntl_ifc.vLoadStoreDrv2memCntl_T                vLoadStoreDrv2memCntl_T       ;
    typedef virtual loadStore2memCntl_ifc.vMemCntlFromLoadStore_T                vMemCntlFromLoadStore_T       ;
endpackage:virtual_interface
    
