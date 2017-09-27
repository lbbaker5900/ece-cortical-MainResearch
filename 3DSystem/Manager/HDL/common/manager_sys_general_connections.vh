
  // Send an 'all' synchronized to all Managers's 
  // sys__mgr__thisSyncnronized basically means all the streams in a PE are complete
  // The PE controller will move to a 'final' state once it receives sys__pe__allSynchronized
  wire  mgr__sys__allSynchronized = mgr_inst[0].sys__mgr__thisSynchronized & 
                                   mgr_inst[1].sys__mgr__thisSynchronized & 
                                   mgr_inst[2].sys__mgr__thisSynchronized & 
                                   mgr_inst[3].sys__mgr__thisSynchronized ; 
  assign  mgr0__sys__allSynchronized                 =  mgr_inst[0].mgr__sys__allSynchronized    ;
  assign  mgr_inst[0].sys__mgr__thisSynchronized     =  sys__mgr0__thisSynchronized              ;
  assign  mgr_inst[0].sys__mgr__ready                =  sys__mgr0__ready                         ;
  assign  mgr_inst[0].sys__mgr__complete             =  sys__mgr0__complete                      ;

  assign  mgr1__sys__allSynchronized                 =  mgr_inst[1].mgr__sys__allSynchronized    ;
  assign  mgr_inst[1].sys__mgr__thisSynchronized     =  sys__mgr1__thisSynchronized              ;
  assign  mgr_inst[1].sys__mgr__ready                =  sys__mgr1__ready                         ;
  assign  mgr_inst[1].sys__mgr__complete             =  sys__mgr1__complete                      ;

  assign  mgr2__sys__allSynchronized                 =  mgr_inst[2].mgr__sys__allSynchronized    ;
  assign  mgr_inst[2].sys__mgr__thisSynchronized     =  sys__mgr2__thisSynchronized              ;
  assign  mgr_inst[2].sys__mgr__ready                =  sys__mgr2__ready                         ;
  assign  mgr_inst[2].sys__mgr__complete             =  sys__mgr2__complete                      ;

  assign  mgr3__sys__allSynchronized                 =  mgr_inst[3].mgr__sys__allSynchronized    ;
  assign  mgr_inst[3].sys__mgr__thisSynchronized     =  sys__mgr3__thisSynchronized              ;
  assign  mgr_inst[3].sys__mgr__ready                =  sys__mgr3__ready                         ;
  assign  mgr_inst[3].sys__mgr__complete             =  sys__mgr3__complete                      ;
