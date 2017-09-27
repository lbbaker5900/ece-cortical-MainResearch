
  // General control and status                                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.   
  assign system_inst.manager_array_inst.mgr_inst[0].mgr__sys__allSynchronized   =  GenStackBus[0].sys__pe__allSynchronized                                ; 
  assign GenStackBus[0].pe__sys__thisSynchronized                               =  system_inst.manager_array_inst.mgr_inst[0].sys__mgr__thisSynchronized  ; 
  assign GenStackBus[0].pe__sys__ready                                          =  system_inst.manager_array_inst.mgr_inst[0].sys__mgr__ready             ; 
  assign GenStackBus[0].pe__sys__complete                                       =  system_inst.manager_array_inst.mgr_inst[0].sys__mgr__complete          ; 

  // General control and status                                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.   
  assign system_inst.manager_array_inst.mgr_inst[1].mgr__sys__allSynchronized   =  GenStackBus[1].sys__pe__allSynchronized                                ; 
  assign GenStackBus[1].pe__sys__thisSynchronized                               =  system_inst.manager_array_inst.mgr_inst[1].sys__mgr__thisSynchronized  ; 
  assign GenStackBus[1].pe__sys__ready                                          =  system_inst.manager_array_inst.mgr_inst[1].sys__mgr__ready             ; 
  assign GenStackBus[1].pe__sys__complete                                       =  system_inst.manager_array_inst.mgr_inst[1].sys__mgr__complete          ; 

  // General control and status                                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.   
  assign system_inst.manager_array_inst.mgr_inst[2].mgr__sys__allSynchronized   =  GenStackBus[2].sys__pe__allSynchronized                                ; 
  assign GenStackBus[2].pe__sys__thisSynchronized                               =  system_inst.manager_array_inst.mgr_inst[2].sys__mgr__thisSynchronized  ; 
  assign GenStackBus[2].pe__sys__ready                                          =  system_inst.manager_array_inst.mgr_inst[2].sys__mgr__ready             ; 
  assign GenStackBus[2].pe__sys__complete                                       =  system_inst.manager_array_inst.mgr_inst[2].sys__mgr__complete          ; 

  // General control and status                                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.   
  assign system_inst.manager_array_inst.mgr_inst[3].mgr__sys__allSynchronized   =  GenStackBus[3].sys__pe__allSynchronized                                ; 
  assign GenStackBus[3].pe__sys__thisSynchronized                               =  system_inst.manager_array_inst.mgr_inst[3].sys__mgr__thisSynchronized  ; 
  assign GenStackBus[3].pe__sys__ready                                          =  system_inst.manager_array_inst.mgr_inst[3].sys__mgr__ready             ; 
  assign GenStackBus[3].pe__sys__complete                                       =  system_inst.manager_array_inst.mgr_inst[3].sys__mgr__complete          ; 
