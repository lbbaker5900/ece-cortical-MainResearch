
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[0].mgr__std__oob_cntl           =   DownstreamStackBusOOB[0].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[0].mgr__std__oob_valid          =   DownstreamStackBusOOB[0].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[0].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[0].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[0].mgr__std__oob_type           =   DownstreamStackBusOOB[0].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[0].mgr__std__oob_data           =   DownstreamStackBusOOB[0].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[1].mgr__std__oob_cntl           =   DownstreamStackBusOOB[1].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[1].mgr__std__oob_valid          =   DownstreamStackBusOOB[1].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[1].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[1].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[1].mgr__std__oob_type           =   DownstreamStackBusOOB[1].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[1].mgr__std__oob_data           =   DownstreamStackBusOOB[1].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[2].mgr__std__oob_cntl           =   DownstreamStackBusOOB[2].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[2].mgr__std__oob_valid          =   DownstreamStackBusOOB[2].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[2].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[2].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[2].mgr__std__oob_type           =   DownstreamStackBusOOB[2].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[2].mgr__std__oob_data           =   DownstreamStackBusOOB[2].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[3].mgr__std__oob_cntl           =   DownstreamStackBusOOB[3].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[3].mgr__std__oob_valid          =   DownstreamStackBusOOB[3].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[3].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[3].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[3].mgr__std__oob_type           =   DownstreamStackBusOOB[3].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[3].mgr__std__oob_data           =   DownstreamStackBusOOB[3].std__pe__oob_data             ; 