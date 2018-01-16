package virtual_interface;
`timescale 1ns/10ps
    // dont use ^&(&%$%%$^%g modports - FIXME do all below
    typedef virtual st_gen_ifc                              vGenStackBus_T                ;
    typedef virtual std_oob_ifc                             vDownstreamStackBusOOB_T      ;
    typedef virtual std_oob_ifc                             vPeArray2SysOob_T             ;
    typedef virtual std_lane_ifc                            vDownstreamStackBusLane_T     ;
    typedef virtual std_lane_ifc                            vPeArray2SysLane_T            ;
    typedef virtual stu_ifc                                 vUpstreamStackBus_T           ;

    typedef virtual locl_from_noc_ifc                       vLocalFromNoC_T               ;
    typedef virtual locl_to_noc_ifc                         vLocalToNoC_T                 ;
    typedef virtual ext_from_noc_ifc                        vExtFromNoC_T                 ;
    typedef virtual ext_to_noc_ifc                          vExtToNoC_T                   ;

    typedef virtual wud_to_oob_ifc                          vWudToOob_T                   ;
    typedef virtual wud_to_mrc_ifc                          vWudToMrc_T                   ;
    typedef virtual descriptor_ifc                          vDesc_T                       ;

    typedef virtual mrc_to_std_ifc                          vMrcToStd_T                   ;

    typedef virtual diram_ifc                               vDiRam_T                      ;
    typedef virtual diram_cfg_ifc                           vDiRamCfg_T                   ;
    typedef virtual int_diram_ifc                           vIntDiRam_T                   ;  // poke inside DiRam


    typedef virtual pe_dma2mem_ifc                             vDma2Mem_T                    ;
    typedef virtual regFileScalar2stOpCntl_ifc                 vRegFileScalarDrv2stOpCntl_T  ;
    typedef virtual regFileScalar2stOpCntl_ifc                 vStOpCntlFromRegFileScalar_T  ;
    typedef virtual regFileLane2stOpCntl_ifc                   vRegFileLaneDrv2stOpCntl_T    ;
    typedef virtual regFileLane2stOpCntl_ifc                   vStOpCntlFromRegFileLane_T    ;
    typedef virtual loadStore2memCntl_ifc                      vLoadStoreDrv2memCntl_T       ;
    typedef virtual loadStore2memCntl_ifc                      vMemCntlFromLoadStore_T       ;
endpackage:virtual_interface
    
