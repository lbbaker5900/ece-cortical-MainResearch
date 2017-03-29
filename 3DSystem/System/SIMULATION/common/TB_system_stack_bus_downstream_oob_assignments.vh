
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
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[4].mgr__std__oob_cntl           =   DownstreamStackBusOOB[4].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[4].mgr__std__oob_valid          =   DownstreamStackBusOOB[4].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[4].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[4].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[4].mgr__std__oob_type           =   DownstreamStackBusOOB[4].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[4].mgr__std__oob_data           =   DownstreamStackBusOOB[4].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[5].mgr__std__oob_cntl           =   DownstreamStackBusOOB[5].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[5].mgr__std__oob_valid          =   DownstreamStackBusOOB[5].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[5].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[5].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[5].mgr__std__oob_type           =   DownstreamStackBusOOB[5].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[5].mgr__std__oob_data           =   DownstreamStackBusOOB[5].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[6].mgr__std__oob_cntl           =   DownstreamStackBusOOB[6].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[6].mgr__std__oob_valid          =   DownstreamStackBusOOB[6].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[6].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[6].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[6].mgr__std__oob_type           =   DownstreamStackBusOOB[6].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[6].mgr__std__oob_data           =   DownstreamStackBusOOB[6].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[7].mgr__std__oob_cntl           =   DownstreamStackBusOOB[7].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[7].mgr__std__oob_valid          =   DownstreamStackBusOOB[7].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[7].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[7].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[7].mgr__std__oob_type           =   DownstreamStackBusOOB[7].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[7].mgr__std__oob_data           =   DownstreamStackBusOOB[7].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[8].mgr__std__oob_cntl           =   DownstreamStackBusOOB[8].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[8].mgr__std__oob_valid          =   DownstreamStackBusOOB[8].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[8].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[8].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[8].mgr__std__oob_type           =   DownstreamStackBusOOB[8].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[8].mgr__std__oob_data           =   DownstreamStackBusOOB[8].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[9].mgr__std__oob_cntl           =   DownstreamStackBusOOB[9].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[9].mgr__std__oob_valid          =   DownstreamStackBusOOB[9].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[9].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[9].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[9].mgr__std__oob_type           =   DownstreamStackBusOOB[9].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[9].mgr__std__oob_data           =   DownstreamStackBusOOB[9].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[10].mgr__std__oob_cntl           =   DownstreamStackBusOOB[10].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[10].mgr__std__oob_valid          =   DownstreamStackBusOOB[10].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[10].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[10].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[10].mgr__std__oob_type           =   DownstreamStackBusOOB[10].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[10].mgr__std__oob_data           =   DownstreamStackBusOOB[10].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[11].mgr__std__oob_cntl           =   DownstreamStackBusOOB[11].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[11].mgr__std__oob_valid          =   DownstreamStackBusOOB[11].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[11].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[11].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[11].mgr__std__oob_type           =   DownstreamStackBusOOB[11].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[11].mgr__std__oob_data           =   DownstreamStackBusOOB[11].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[12].mgr__std__oob_cntl           =   DownstreamStackBusOOB[12].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[12].mgr__std__oob_valid          =   DownstreamStackBusOOB[12].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[12].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[12].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[12].mgr__std__oob_type           =   DownstreamStackBusOOB[12].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[12].mgr__std__oob_data           =   DownstreamStackBusOOB[12].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[13].mgr__std__oob_cntl           =   DownstreamStackBusOOB[13].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[13].mgr__std__oob_valid          =   DownstreamStackBusOOB[13].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[13].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[13].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[13].mgr__std__oob_type           =   DownstreamStackBusOOB[13].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[13].mgr__std__oob_data           =   DownstreamStackBusOOB[13].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[14].mgr__std__oob_cntl           =   DownstreamStackBusOOB[14].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[14].mgr__std__oob_valid          =   DownstreamStackBusOOB[14].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[14].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[14].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[14].mgr__std__oob_type           =   DownstreamStackBusOOB[14].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[14].mgr__std__oob_data           =   DownstreamStackBusOOB[14].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[15].mgr__std__oob_cntl           =   DownstreamStackBusOOB[15].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[15].mgr__std__oob_valid          =   DownstreamStackBusOOB[15].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[15].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[15].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[15].mgr__std__oob_type           =   DownstreamStackBusOOB[15].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[15].mgr__std__oob_data           =   DownstreamStackBusOOB[15].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[16].mgr__std__oob_cntl           =   DownstreamStackBusOOB[16].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[16].mgr__std__oob_valid          =   DownstreamStackBusOOB[16].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[16].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[16].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[16].mgr__std__oob_type           =   DownstreamStackBusOOB[16].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[16].mgr__std__oob_data           =   DownstreamStackBusOOB[16].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[17].mgr__std__oob_cntl           =   DownstreamStackBusOOB[17].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[17].mgr__std__oob_valid          =   DownstreamStackBusOOB[17].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[17].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[17].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[17].mgr__std__oob_type           =   DownstreamStackBusOOB[17].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[17].mgr__std__oob_data           =   DownstreamStackBusOOB[17].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[18].mgr__std__oob_cntl           =   DownstreamStackBusOOB[18].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[18].mgr__std__oob_valid          =   DownstreamStackBusOOB[18].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[18].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[18].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[18].mgr__std__oob_type           =   DownstreamStackBusOOB[18].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[18].mgr__std__oob_data           =   DownstreamStackBusOOB[18].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[19].mgr__std__oob_cntl           =   DownstreamStackBusOOB[19].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[19].mgr__std__oob_valid          =   DownstreamStackBusOOB[19].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[19].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[19].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[19].mgr__std__oob_type           =   DownstreamStackBusOOB[19].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[19].mgr__std__oob_data           =   DownstreamStackBusOOB[19].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[20].mgr__std__oob_cntl           =   DownstreamStackBusOOB[20].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[20].mgr__std__oob_valid          =   DownstreamStackBusOOB[20].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[20].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[20].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[20].mgr__std__oob_type           =   DownstreamStackBusOOB[20].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[20].mgr__std__oob_data           =   DownstreamStackBusOOB[20].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[21].mgr__std__oob_cntl           =   DownstreamStackBusOOB[21].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[21].mgr__std__oob_valid          =   DownstreamStackBusOOB[21].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[21].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[21].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[21].mgr__std__oob_type           =   DownstreamStackBusOOB[21].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[21].mgr__std__oob_data           =   DownstreamStackBusOOB[21].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[22].mgr__std__oob_cntl           =   DownstreamStackBusOOB[22].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[22].mgr__std__oob_valid          =   DownstreamStackBusOOB[22].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[22].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[22].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[22].mgr__std__oob_type           =   DownstreamStackBusOOB[22].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[22].mgr__std__oob_data           =   DownstreamStackBusOOB[22].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[23].mgr__std__oob_cntl           =   DownstreamStackBusOOB[23].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[23].mgr__std__oob_valid          =   DownstreamStackBusOOB[23].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[23].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[23].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[23].mgr__std__oob_type           =   DownstreamStackBusOOB[23].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[23].mgr__std__oob_data           =   DownstreamStackBusOOB[23].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[24].mgr__std__oob_cntl           =   DownstreamStackBusOOB[24].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[24].mgr__std__oob_valid          =   DownstreamStackBusOOB[24].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[24].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[24].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[24].mgr__std__oob_type           =   DownstreamStackBusOOB[24].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[24].mgr__std__oob_data           =   DownstreamStackBusOOB[24].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[25].mgr__std__oob_cntl           =   DownstreamStackBusOOB[25].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[25].mgr__std__oob_valid          =   DownstreamStackBusOOB[25].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[25].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[25].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[25].mgr__std__oob_type           =   DownstreamStackBusOOB[25].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[25].mgr__std__oob_data           =   DownstreamStackBusOOB[25].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[26].mgr__std__oob_cntl           =   DownstreamStackBusOOB[26].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[26].mgr__std__oob_valid          =   DownstreamStackBusOOB[26].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[26].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[26].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[26].mgr__std__oob_type           =   DownstreamStackBusOOB[26].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[26].mgr__std__oob_data           =   DownstreamStackBusOOB[26].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[27].mgr__std__oob_cntl           =   DownstreamStackBusOOB[27].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[27].mgr__std__oob_valid          =   DownstreamStackBusOOB[27].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[27].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[27].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[27].mgr__std__oob_type           =   DownstreamStackBusOOB[27].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[27].mgr__std__oob_data           =   DownstreamStackBusOOB[27].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[28].mgr__std__oob_cntl           =   DownstreamStackBusOOB[28].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[28].mgr__std__oob_valid          =   DownstreamStackBusOOB[28].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[28].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[28].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[28].mgr__std__oob_type           =   DownstreamStackBusOOB[28].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[28].mgr__std__oob_data           =   DownstreamStackBusOOB[28].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[29].mgr__std__oob_cntl           =   DownstreamStackBusOOB[29].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[29].mgr__std__oob_valid          =   DownstreamStackBusOOB[29].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[29].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[29].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[29].mgr__std__oob_type           =   DownstreamStackBusOOB[29].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[29].mgr__std__oob_data           =   DownstreamStackBusOOB[29].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[30].mgr__std__oob_cntl           =   DownstreamStackBusOOB[30].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[30].mgr__std__oob_valid          =   DownstreamStackBusOOB[30].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[30].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[30].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[30].mgr__std__oob_type           =   DownstreamStackBusOOB[30].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[30].mgr__std__oob_data           =   DownstreamStackBusOOB[30].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[31].mgr__std__oob_cntl           =   DownstreamStackBusOOB[31].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[31].mgr__std__oob_valid          =   DownstreamStackBusOOB[31].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[31].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[31].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[31].mgr__std__oob_type           =   DownstreamStackBusOOB[31].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[31].mgr__std__oob_data           =   DownstreamStackBusOOB[31].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[32].mgr__std__oob_cntl           =   DownstreamStackBusOOB[32].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[32].mgr__std__oob_valid          =   DownstreamStackBusOOB[32].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[32].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[32].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[32].mgr__std__oob_type           =   DownstreamStackBusOOB[32].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[32].mgr__std__oob_data           =   DownstreamStackBusOOB[32].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[33].mgr__std__oob_cntl           =   DownstreamStackBusOOB[33].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[33].mgr__std__oob_valid          =   DownstreamStackBusOOB[33].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[33].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[33].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[33].mgr__std__oob_type           =   DownstreamStackBusOOB[33].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[33].mgr__std__oob_data           =   DownstreamStackBusOOB[33].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[34].mgr__std__oob_cntl           =   DownstreamStackBusOOB[34].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[34].mgr__std__oob_valid          =   DownstreamStackBusOOB[34].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[34].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[34].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[34].mgr__std__oob_type           =   DownstreamStackBusOOB[34].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[34].mgr__std__oob_data           =   DownstreamStackBusOOB[34].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[35].mgr__std__oob_cntl           =   DownstreamStackBusOOB[35].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[35].mgr__std__oob_valid          =   DownstreamStackBusOOB[35].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[35].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[35].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[35].mgr__std__oob_type           =   DownstreamStackBusOOB[35].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[35].mgr__std__oob_data           =   DownstreamStackBusOOB[35].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[36].mgr__std__oob_cntl           =   DownstreamStackBusOOB[36].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[36].mgr__std__oob_valid          =   DownstreamStackBusOOB[36].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[36].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[36].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[36].mgr__std__oob_type           =   DownstreamStackBusOOB[36].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[36].mgr__std__oob_data           =   DownstreamStackBusOOB[36].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[37].mgr__std__oob_cntl           =   DownstreamStackBusOOB[37].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[37].mgr__std__oob_valid          =   DownstreamStackBusOOB[37].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[37].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[37].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[37].mgr__std__oob_type           =   DownstreamStackBusOOB[37].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[37].mgr__std__oob_data           =   DownstreamStackBusOOB[37].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[38].mgr__std__oob_cntl           =   DownstreamStackBusOOB[38].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[38].mgr__std__oob_valid          =   DownstreamStackBusOOB[38].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[38].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[38].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[38].mgr__std__oob_type           =   DownstreamStackBusOOB[38].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[38].mgr__std__oob_data           =   DownstreamStackBusOOB[38].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[39].mgr__std__oob_cntl           =   DownstreamStackBusOOB[39].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[39].mgr__std__oob_valid          =   DownstreamStackBusOOB[39].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[39].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[39].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[39].mgr__std__oob_type           =   DownstreamStackBusOOB[39].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[39].mgr__std__oob_data           =   DownstreamStackBusOOB[39].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[40].mgr__std__oob_cntl           =   DownstreamStackBusOOB[40].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[40].mgr__std__oob_valid          =   DownstreamStackBusOOB[40].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[40].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[40].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[40].mgr__std__oob_type           =   DownstreamStackBusOOB[40].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[40].mgr__std__oob_data           =   DownstreamStackBusOOB[40].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[41].mgr__std__oob_cntl           =   DownstreamStackBusOOB[41].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[41].mgr__std__oob_valid          =   DownstreamStackBusOOB[41].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[41].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[41].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[41].mgr__std__oob_type           =   DownstreamStackBusOOB[41].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[41].mgr__std__oob_data           =   DownstreamStackBusOOB[41].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[42].mgr__std__oob_cntl           =   DownstreamStackBusOOB[42].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[42].mgr__std__oob_valid          =   DownstreamStackBusOOB[42].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[42].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[42].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[42].mgr__std__oob_type           =   DownstreamStackBusOOB[42].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[42].mgr__std__oob_data           =   DownstreamStackBusOOB[42].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[43].mgr__std__oob_cntl           =   DownstreamStackBusOOB[43].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[43].mgr__std__oob_valid          =   DownstreamStackBusOOB[43].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[43].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[43].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[43].mgr__std__oob_type           =   DownstreamStackBusOOB[43].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[43].mgr__std__oob_data           =   DownstreamStackBusOOB[43].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[44].mgr__std__oob_cntl           =   DownstreamStackBusOOB[44].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[44].mgr__std__oob_valid          =   DownstreamStackBusOOB[44].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[44].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[44].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[44].mgr__std__oob_type           =   DownstreamStackBusOOB[44].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[44].mgr__std__oob_data           =   DownstreamStackBusOOB[44].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[45].mgr__std__oob_cntl           =   DownstreamStackBusOOB[45].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[45].mgr__std__oob_valid          =   DownstreamStackBusOOB[45].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[45].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[45].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[45].mgr__std__oob_type           =   DownstreamStackBusOOB[45].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[45].mgr__std__oob_data           =   DownstreamStackBusOOB[45].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[46].mgr__std__oob_cntl           =   DownstreamStackBusOOB[46].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[46].mgr__std__oob_valid          =   DownstreamStackBusOOB[46].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[46].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[46].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[46].mgr__std__oob_type           =   DownstreamStackBusOOB[46].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[46].mgr__std__oob_data           =   DownstreamStackBusOOB[46].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[47].mgr__std__oob_cntl           =   DownstreamStackBusOOB[47].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[47].mgr__std__oob_valid          =   DownstreamStackBusOOB[47].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[47].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[47].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[47].mgr__std__oob_type           =   DownstreamStackBusOOB[47].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[47].mgr__std__oob_data           =   DownstreamStackBusOOB[47].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[48].mgr__std__oob_cntl           =   DownstreamStackBusOOB[48].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[48].mgr__std__oob_valid          =   DownstreamStackBusOOB[48].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[48].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[48].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[48].mgr__std__oob_type           =   DownstreamStackBusOOB[48].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[48].mgr__std__oob_data           =   DownstreamStackBusOOB[48].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[49].mgr__std__oob_cntl           =   DownstreamStackBusOOB[49].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[49].mgr__std__oob_valid          =   DownstreamStackBusOOB[49].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[49].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[49].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[49].mgr__std__oob_type           =   DownstreamStackBusOOB[49].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[49].mgr__std__oob_data           =   DownstreamStackBusOOB[49].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[50].mgr__std__oob_cntl           =   DownstreamStackBusOOB[50].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[50].mgr__std__oob_valid          =   DownstreamStackBusOOB[50].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[50].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[50].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[50].mgr__std__oob_type           =   DownstreamStackBusOOB[50].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[50].mgr__std__oob_data           =   DownstreamStackBusOOB[50].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[51].mgr__std__oob_cntl           =   DownstreamStackBusOOB[51].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[51].mgr__std__oob_valid          =   DownstreamStackBusOOB[51].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[51].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[51].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[51].mgr__std__oob_type           =   DownstreamStackBusOOB[51].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[51].mgr__std__oob_data           =   DownstreamStackBusOOB[51].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[52].mgr__std__oob_cntl           =   DownstreamStackBusOOB[52].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[52].mgr__std__oob_valid          =   DownstreamStackBusOOB[52].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[52].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[52].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[52].mgr__std__oob_type           =   DownstreamStackBusOOB[52].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[52].mgr__std__oob_data           =   DownstreamStackBusOOB[52].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[53].mgr__std__oob_cntl           =   DownstreamStackBusOOB[53].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[53].mgr__std__oob_valid          =   DownstreamStackBusOOB[53].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[53].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[53].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[53].mgr__std__oob_type           =   DownstreamStackBusOOB[53].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[53].mgr__std__oob_data           =   DownstreamStackBusOOB[53].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[54].mgr__std__oob_cntl           =   DownstreamStackBusOOB[54].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[54].mgr__std__oob_valid          =   DownstreamStackBusOOB[54].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[54].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[54].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[54].mgr__std__oob_type           =   DownstreamStackBusOOB[54].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[54].mgr__std__oob_data           =   DownstreamStackBusOOB[54].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[55].mgr__std__oob_cntl           =   DownstreamStackBusOOB[55].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[55].mgr__std__oob_valid          =   DownstreamStackBusOOB[55].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[55].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[55].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[55].mgr__std__oob_type           =   DownstreamStackBusOOB[55].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[55].mgr__std__oob_data           =   DownstreamStackBusOOB[55].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[56].mgr__std__oob_cntl           =   DownstreamStackBusOOB[56].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[56].mgr__std__oob_valid          =   DownstreamStackBusOOB[56].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[56].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[56].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[56].mgr__std__oob_type           =   DownstreamStackBusOOB[56].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[56].mgr__std__oob_data           =   DownstreamStackBusOOB[56].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[57].mgr__std__oob_cntl           =   DownstreamStackBusOOB[57].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[57].mgr__std__oob_valid          =   DownstreamStackBusOOB[57].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[57].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[57].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[57].mgr__std__oob_type           =   DownstreamStackBusOOB[57].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[57].mgr__std__oob_data           =   DownstreamStackBusOOB[57].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[58].mgr__std__oob_cntl           =   DownstreamStackBusOOB[58].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[58].mgr__std__oob_valid          =   DownstreamStackBusOOB[58].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[58].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[58].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[58].mgr__std__oob_type           =   DownstreamStackBusOOB[58].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[58].mgr__std__oob_data           =   DownstreamStackBusOOB[58].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[59].mgr__std__oob_cntl           =   DownstreamStackBusOOB[59].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[59].mgr__std__oob_valid          =   DownstreamStackBusOOB[59].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[59].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[59].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[59].mgr__std__oob_type           =   DownstreamStackBusOOB[59].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[59].mgr__std__oob_data           =   DownstreamStackBusOOB[59].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[60].mgr__std__oob_cntl           =   DownstreamStackBusOOB[60].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[60].mgr__std__oob_valid          =   DownstreamStackBusOOB[60].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[60].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[60].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[60].mgr__std__oob_type           =   DownstreamStackBusOOB[60].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[60].mgr__std__oob_data           =   DownstreamStackBusOOB[60].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[61].mgr__std__oob_cntl           =   DownstreamStackBusOOB[61].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[61].mgr__std__oob_valid          =   DownstreamStackBusOOB[61].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[61].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[61].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[61].mgr__std__oob_type           =   DownstreamStackBusOOB[61].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[61].mgr__std__oob_data           =   DownstreamStackBusOOB[61].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[62].mgr__std__oob_cntl           =   DownstreamStackBusOOB[62].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[62].mgr__std__oob_valid          =   DownstreamStackBusOOB[62].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[62].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[62].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[62].mgr__std__oob_type           =   DownstreamStackBusOOB[62].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[62].mgr__std__oob_data           =   DownstreamStackBusOOB[62].std__pe__oob_data             ; 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
  assign system_inst.manager_array_inst.mgr_inst[63].mgr__std__oob_cntl           =   DownstreamStackBusOOB[63].std__pe__oob_cntl             ; 
  assign system_inst.manager_array_inst.mgr_inst[63].mgr__std__oob_valid          =   DownstreamStackBusOOB[63].std__pe__oob_valid            ; 
  assign DownstreamStackBusOOB[63].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[63].std__mgr__oob_ready ; 
  assign system_inst.manager_array_inst.mgr_inst[63].mgr__std__oob_type           =   DownstreamStackBusOOB[63].std__pe__oob_type             ; 
  assign system_inst.manager_array_inst.mgr_inst[63].mgr__std__oob_data           =   DownstreamStackBusOOB[63].std__pe__oob_data             ; 