
  // Send an 'all' synchronized to all Managers's 
  // sys__mgr__thisSyncnronized basically means all the streams in a PE are complete
  // The PE controller will move to a 'final' state once it receives sys__pe__allSynchronized
  wire  mgr__sys__allSynchronized = mgr_inst[0].sys__mgr__thisSynchronized & 
                                   mgr_inst[1].sys__mgr__thisSynchronized & 
                                   mgr_inst[2].sys__mgr__thisSynchronized & 
                                   mgr_inst[3].sys__mgr__thisSynchronized & 
                                   mgr_inst[4].sys__mgr__thisSynchronized & 
                                   mgr_inst[5].sys__mgr__thisSynchronized & 
                                   mgr_inst[6].sys__mgr__thisSynchronized & 
                                   mgr_inst[7].sys__mgr__thisSynchronized & 
                                   mgr_inst[8].sys__mgr__thisSynchronized & 
                                   mgr_inst[9].sys__mgr__thisSynchronized & 
                                   mgr_inst[10].sys__mgr__thisSynchronized & 
                                   mgr_inst[11].sys__mgr__thisSynchronized & 
                                   mgr_inst[12].sys__mgr__thisSynchronized & 
                                   mgr_inst[13].sys__mgr__thisSynchronized & 
                                   mgr_inst[14].sys__mgr__thisSynchronized & 
                                   mgr_inst[15].sys__mgr__thisSynchronized & 
                                   mgr_inst[16].sys__mgr__thisSynchronized & 
                                   mgr_inst[17].sys__mgr__thisSynchronized & 
                                   mgr_inst[18].sys__mgr__thisSynchronized & 
                                   mgr_inst[19].sys__mgr__thisSynchronized & 
                                   mgr_inst[20].sys__mgr__thisSynchronized & 
                                   mgr_inst[21].sys__mgr__thisSynchronized & 
                                   mgr_inst[22].sys__mgr__thisSynchronized & 
                                   mgr_inst[23].sys__mgr__thisSynchronized & 
                                   mgr_inst[24].sys__mgr__thisSynchronized & 
                                   mgr_inst[25].sys__mgr__thisSynchronized & 
                                   mgr_inst[26].sys__mgr__thisSynchronized & 
                                   mgr_inst[27].sys__mgr__thisSynchronized & 
                                   mgr_inst[28].sys__mgr__thisSynchronized & 
                                   mgr_inst[29].sys__mgr__thisSynchronized & 
                                   mgr_inst[30].sys__mgr__thisSynchronized & 
                                   mgr_inst[31].sys__mgr__thisSynchronized & 
                                   mgr_inst[32].sys__mgr__thisSynchronized & 
                                   mgr_inst[33].sys__mgr__thisSynchronized & 
                                   mgr_inst[34].sys__mgr__thisSynchronized & 
                                   mgr_inst[35].sys__mgr__thisSynchronized & 
                                   mgr_inst[36].sys__mgr__thisSynchronized & 
                                   mgr_inst[37].sys__mgr__thisSynchronized & 
                                   mgr_inst[38].sys__mgr__thisSynchronized & 
                                   mgr_inst[39].sys__mgr__thisSynchronized & 
                                   mgr_inst[40].sys__mgr__thisSynchronized & 
                                   mgr_inst[41].sys__mgr__thisSynchronized & 
                                   mgr_inst[42].sys__mgr__thisSynchronized & 
                                   mgr_inst[43].sys__mgr__thisSynchronized & 
                                   mgr_inst[44].sys__mgr__thisSynchronized & 
                                   mgr_inst[45].sys__mgr__thisSynchronized & 
                                   mgr_inst[46].sys__mgr__thisSynchronized & 
                                   mgr_inst[47].sys__mgr__thisSynchronized & 
                                   mgr_inst[48].sys__mgr__thisSynchronized & 
                                   mgr_inst[49].sys__mgr__thisSynchronized & 
                                   mgr_inst[50].sys__mgr__thisSynchronized & 
                                   mgr_inst[51].sys__mgr__thisSynchronized & 
                                   mgr_inst[52].sys__mgr__thisSynchronized & 
                                   mgr_inst[53].sys__mgr__thisSynchronized & 
                                   mgr_inst[54].sys__mgr__thisSynchronized & 
                                   mgr_inst[55].sys__mgr__thisSynchronized & 
                                   mgr_inst[56].sys__mgr__thisSynchronized & 
                                   mgr_inst[57].sys__mgr__thisSynchronized & 
                                   mgr_inst[58].sys__mgr__thisSynchronized & 
                                   mgr_inst[59].sys__mgr__thisSynchronized & 
                                   mgr_inst[60].sys__mgr__thisSynchronized & 
                                   mgr_inst[61].sys__mgr__thisSynchronized & 
                                   mgr_inst[62].sys__mgr__thisSynchronized & 
                                   mgr_inst[63].sys__mgr__thisSynchronized ; 
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

  assign  mgr4__sys__allSynchronized                 =  mgr_inst[4].mgr__sys__allSynchronized    ;
  assign  mgr_inst[4].sys__mgr__thisSynchronized     =  sys__mgr4__thisSynchronized              ;
  assign  mgr_inst[4].sys__mgr__ready                =  sys__mgr4__ready                         ;
  assign  mgr_inst[4].sys__mgr__complete             =  sys__mgr4__complete                      ;

  assign  mgr5__sys__allSynchronized                 =  mgr_inst[5].mgr__sys__allSynchronized    ;
  assign  mgr_inst[5].sys__mgr__thisSynchronized     =  sys__mgr5__thisSynchronized              ;
  assign  mgr_inst[5].sys__mgr__ready                =  sys__mgr5__ready                         ;
  assign  mgr_inst[5].sys__mgr__complete             =  sys__mgr5__complete                      ;

  assign  mgr6__sys__allSynchronized                 =  mgr_inst[6].mgr__sys__allSynchronized    ;
  assign  mgr_inst[6].sys__mgr__thisSynchronized     =  sys__mgr6__thisSynchronized              ;
  assign  mgr_inst[6].sys__mgr__ready                =  sys__mgr6__ready                         ;
  assign  mgr_inst[6].sys__mgr__complete             =  sys__mgr6__complete                      ;

  assign  mgr7__sys__allSynchronized                 =  mgr_inst[7].mgr__sys__allSynchronized    ;
  assign  mgr_inst[7].sys__mgr__thisSynchronized     =  sys__mgr7__thisSynchronized              ;
  assign  mgr_inst[7].sys__mgr__ready                =  sys__mgr7__ready                         ;
  assign  mgr_inst[7].sys__mgr__complete             =  sys__mgr7__complete                      ;

  assign  mgr8__sys__allSynchronized                 =  mgr_inst[8].mgr__sys__allSynchronized    ;
  assign  mgr_inst[8].sys__mgr__thisSynchronized     =  sys__mgr8__thisSynchronized              ;
  assign  mgr_inst[8].sys__mgr__ready                =  sys__mgr8__ready                         ;
  assign  mgr_inst[8].sys__mgr__complete             =  sys__mgr8__complete                      ;

  assign  mgr9__sys__allSynchronized                 =  mgr_inst[9].mgr__sys__allSynchronized    ;
  assign  mgr_inst[9].sys__mgr__thisSynchronized     =  sys__mgr9__thisSynchronized              ;
  assign  mgr_inst[9].sys__mgr__ready                =  sys__mgr9__ready                         ;
  assign  mgr_inst[9].sys__mgr__complete             =  sys__mgr9__complete                      ;

  assign  mgr10__sys__allSynchronized                 =  mgr_inst[10].mgr__sys__allSynchronized    ;
  assign  mgr_inst[10].sys__mgr__thisSynchronized     =  sys__mgr10__thisSynchronized              ;
  assign  mgr_inst[10].sys__mgr__ready                =  sys__mgr10__ready                         ;
  assign  mgr_inst[10].sys__mgr__complete             =  sys__mgr10__complete                      ;

  assign  mgr11__sys__allSynchronized                 =  mgr_inst[11].mgr__sys__allSynchronized    ;
  assign  mgr_inst[11].sys__mgr__thisSynchronized     =  sys__mgr11__thisSynchronized              ;
  assign  mgr_inst[11].sys__mgr__ready                =  sys__mgr11__ready                         ;
  assign  mgr_inst[11].sys__mgr__complete             =  sys__mgr11__complete                      ;

  assign  mgr12__sys__allSynchronized                 =  mgr_inst[12].mgr__sys__allSynchronized    ;
  assign  mgr_inst[12].sys__mgr__thisSynchronized     =  sys__mgr12__thisSynchronized              ;
  assign  mgr_inst[12].sys__mgr__ready                =  sys__mgr12__ready                         ;
  assign  mgr_inst[12].sys__mgr__complete             =  sys__mgr12__complete                      ;

  assign  mgr13__sys__allSynchronized                 =  mgr_inst[13].mgr__sys__allSynchronized    ;
  assign  mgr_inst[13].sys__mgr__thisSynchronized     =  sys__mgr13__thisSynchronized              ;
  assign  mgr_inst[13].sys__mgr__ready                =  sys__mgr13__ready                         ;
  assign  mgr_inst[13].sys__mgr__complete             =  sys__mgr13__complete                      ;

  assign  mgr14__sys__allSynchronized                 =  mgr_inst[14].mgr__sys__allSynchronized    ;
  assign  mgr_inst[14].sys__mgr__thisSynchronized     =  sys__mgr14__thisSynchronized              ;
  assign  mgr_inst[14].sys__mgr__ready                =  sys__mgr14__ready                         ;
  assign  mgr_inst[14].sys__mgr__complete             =  sys__mgr14__complete                      ;

  assign  mgr15__sys__allSynchronized                 =  mgr_inst[15].mgr__sys__allSynchronized    ;
  assign  mgr_inst[15].sys__mgr__thisSynchronized     =  sys__mgr15__thisSynchronized              ;
  assign  mgr_inst[15].sys__mgr__ready                =  sys__mgr15__ready                         ;
  assign  mgr_inst[15].sys__mgr__complete             =  sys__mgr15__complete                      ;

  assign  mgr16__sys__allSynchronized                 =  mgr_inst[16].mgr__sys__allSynchronized    ;
  assign  mgr_inst[16].sys__mgr__thisSynchronized     =  sys__mgr16__thisSynchronized              ;
  assign  mgr_inst[16].sys__mgr__ready                =  sys__mgr16__ready                         ;
  assign  mgr_inst[16].sys__mgr__complete             =  sys__mgr16__complete                      ;

  assign  mgr17__sys__allSynchronized                 =  mgr_inst[17].mgr__sys__allSynchronized    ;
  assign  mgr_inst[17].sys__mgr__thisSynchronized     =  sys__mgr17__thisSynchronized              ;
  assign  mgr_inst[17].sys__mgr__ready                =  sys__mgr17__ready                         ;
  assign  mgr_inst[17].sys__mgr__complete             =  sys__mgr17__complete                      ;

  assign  mgr18__sys__allSynchronized                 =  mgr_inst[18].mgr__sys__allSynchronized    ;
  assign  mgr_inst[18].sys__mgr__thisSynchronized     =  sys__mgr18__thisSynchronized              ;
  assign  mgr_inst[18].sys__mgr__ready                =  sys__mgr18__ready                         ;
  assign  mgr_inst[18].sys__mgr__complete             =  sys__mgr18__complete                      ;

  assign  mgr19__sys__allSynchronized                 =  mgr_inst[19].mgr__sys__allSynchronized    ;
  assign  mgr_inst[19].sys__mgr__thisSynchronized     =  sys__mgr19__thisSynchronized              ;
  assign  mgr_inst[19].sys__mgr__ready                =  sys__mgr19__ready                         ;
  assign  mgr_inst[19].sys__mgr__complete             =  sys__mgr19__complete                      ;

  assign  mgr20__sys__allSynchronized                 =  mgr_inst[20].mgr__sys__allSynchronized    ;
  assign  mgr_inst[20].sys__mgr__thisSynchronized     =  sys__mgr20__thisSynchronized              ;
  assign  mgr_inst[20].sys__mgr__ready                =  sys__mgr20__ready                         ;
  assign  mgr_inst[20].sys__mgr__complete             =  sys__mgr20__complete                      ;

  assign  mgr21__sys__allSynchronized                 =  mgr_inst[21].mgr__sys__allSynchronized    ;
  assign  mgr_inst[21].sys__mgr__thisSynchronized     =  sys__mgr21__thisSynchronized              ;
  assign  mgr_inst[21].sys__mgr__ready                =  sys__mgr21__ready                         ;
  assign  mgr_inst[21].sys__mgr__complete             =  sys__mgr21__complete                      ;

  assign  mgr22__sys__allSynchronized                 =  mgr_inst[22].mgr__sys__allSynchronized    ;
  assign  mgr_inst[22].sys__mgr__thisSynchronized     =  sys__mgr22__thisSynchronized              ;
  assign  mgr_inst[22].sys__mgr__ready                =  sys__mgr22__ready                         ;
  assign  mgr_inst[22].sys__mgr__complete             =  sys__mgr22__complete                      ;

  assign  mgr23__sys__allSynchronized                 =  mgr_inst[23].mgr__sys__allSynchronized    ;
  assign  mgr_inst[23].sys__mgr__thisSynchronized     =  sys__mgr23__thisSynchronized              ;
  assign  mgr_inst[23].sys__mgr__ready                =  sys__mgr23__ready                         ;
  assign  mgr_inst[23].sys__mgr__complete             =  sys__mgr23__complete                      ;

  assign  mgr24__sys__allSynchronized                 =  mgr_inst[24].mgr__sys__allSynchronized    ;
  assign  mgr_inst[24].sys__mgr__thisSynchronized     =  sys__mgr24__thisSynchronized              ;
  assign  mgr_inst[24].sys__mgr__ready                =  sys__mgr24__ready                         ;
  assign  mgr_inst[24].sys__mgr__complete             =  sys__mgr24__complete                      ;

  assign  mgr25__sys__allSynchronized                 =  mgr_inst[25].mgr__sys__allSynchronized    ;
  assign  mgr_inst[25].sys__mgr__thisSynchronized     =  sys__mgr25__thisSynchronized              ;
  assign  mgr_inst[25].sys__mgr__ready                =  sys__mgr25__ready                         ;
  assign  mgr_inst[25].sys__mgr__complete             =  sys__mgr25__complete                      ;

  assign  mgr26__sys__allSynchronized                 =  mgr_inst[26].mgr__sys__allSynchronized    ;
  assign  mgr_inst[26].sys__mgr__thisSynchronized     =  sys__mgr26__thisSynchronized              ;
  assign  mgr_inst[26].sys__mgr__ready                =  sys__mgr26__ready                         ;
  assign  mgr_inst[26].sys__mgr__complete             =  sys__mgr26__complete                      ;

  assign  mgr27__sys__allSynchronized                 =  mgr_inst[27].mgr__sys__allSynchronized    ;
  assign  mgr_inst[27].sys__mgr__thisSynchronized     =  sys__mgr27__thisSynchronized              ;
  assign  mgr_inst[27].sys__mgr__ready                =  sys__mgr27__ready                         ;
  assign  mgr_inst[27].sys__mgr__complete             =  sys__mgr27__complete                      ;

  assign  mgr28__sys__allSynchronized                 =  mgr_inst[28].mgr__sys__allSynchronized    ;
  assign  mgr_inst[28].sys__mgr__thisSynchronized     =  sys__mgr28__thisSynchronized              ;
  assign  mgr_inst[28].sys__mgr__ready                =  sys__mgr28__ready                         ;
  assign  mgr_inst[28].sys__mgr__complete             =  sys__mgr28__complete                      ;

  assign  mgr29__sys__allSynchronized                 =  mgr_inst[29].mgr__sys__allSynchronized    ;
  assign  mgr_inst[29].sys__mgr__thisSynchronized     =  sys__mgr29__thisSynchronized              ;
  assign  mgr_inst[29].sys__mgr__ready                =  sys__mgr29__ready                         ;
  assign  mgr_inst[29].sys__mgr__complete             =  sys__mgr29__complete                      ;

  assign  mgr30__sys__allSynchronized                 =  mgr_inst[30].mgr__sys__allSynchronized    ;
  assign  mgr_inst[30].sys__mgr__thisSynchronized     =  sys__mgr30__thisSynchronized              ;
  assign  mgr_inst[30].sys__mgr__ready                =  sys__mgr30__ready                         ;
  assign  mgr_inst[30].sys__mgr__complete             =  sys__mgr30__complete                      ;

  assign  mgr31__sys__allSynchronized                 =  mgr_inst[31].mgr__sys__allSynchronized    ;
  assign  mgr_inst[31].sys__mgr__thisSynchronized     =  sys__mgr31__thisSynchronized              ;
  assign  mgr_inst[31].sys__mgr__ready                =  sys__mgr31__ready                         ;
  assign  mgr_inst[31].sys__mgr__complete             =  sys__mgr31__complete                      ;

  assign  mgr32__sys__allSynchronized                 =  mgr_inst[32].mgr__sys__allSynchronized    ;
  assign  mgr_inst[32].sys__mgr__thisSynchronized     =  sys__mgr32__thisSynchronized              ;
  assign  mgr_inst[32].sys__mgr__ready                =  sys__mgr32__ready                         ;
  assign  mgr_inst[32].sys__mgr__complete             =  sys__mgr32__complete                      ;

  assign  mgr33__sys__allSynchronized                 =  mgr_inst[33].mgr__sys__allSynchronized    ;
  assign  mgr_inst[33].sys__mgr__thisSynchronized     =  sys__mgr33__thisSynchronized              ;
  assign  mgr_inst[33].sys__mgr__ready                =  sys__mgr33__ready                         ;
  assign  mgr_inst[33].sys__mgr__complete             =  sys__mgr33__complete                      ;

  assign  mgr34__sys__allSynchronized                 =  mgr_inst[34].mgr__sys__allSynchronized    ;
  assign  mgr_inst[34].sys__mgr__thisSynchronized     =  sys__mgr34__thisSynchronized              ;
  assign  mgr_inst[34].sys__mgr__ready                =  sys__mgr34__ready                         ;
  assign  mgr_inst[34].sys__mgr__complete             =  sys__mgr34__complete                      ;

  assign  mgr35__sys__allSynchronized                 =  mgr_inst[35].mgr__sys__allSynchronized    ;
  assign  mgr_inst[35].sys__mgr__thisSynchronized     =  sys__mgr35__thisSynchronized              ;
  assign  mgr_inst[35].sys__mgr__ready                =  sys__mgr35__ready                         ;
  assign  mgr_inst[35].sys__mgr__complete             =  sys__mgr35__complete                      ;

  assign  mgr36__sys__allSynchronized                 =  mgr_inst[36].mgr__sys__allSynchronized    ;
  assign  mgr_inst[36].sys__mgr__thisSynchronized     =  sys__mgr36__thisSynchronized              ;
  assign  mgr_inst[36].sys__mgr__ready                =  sys__mgr36__ready                         ;
  assign  mgr_inst[36].sys__mgr__complete             =  sys__mgr36__complete                      ;

  assign  mgr37__sys__allSynchronized                 =  mgr_inst[37].mgr__sys__allSynchronized    ;
  assign  mgr_inst[37].sys__mgr__thisSynchronized     =  sys__mgr37__thisSynchronized              ;
  assign  mgr_inst[37].sys__mgr__ready                =  sys__mgr37__ready                         ;
  assign  mgr_inst[37].sys__mgr__complete             =  sys__mgr37__complete                      ;

  assign  mgr38__sys__allSynchronized                 =  mgr_inst[38].mgr__sys__allSynchronized    ;
  assign  mgr_inst[38].sys__mgr__thisSynchronized     =  sys__mgr38__thisSynchronized              ;
  assign  mgr_inst[38].sys__mgr__ready                =  sys__mgr38__ready                         ;
  assign  mgr_inst[38].sys__mgr__complete             =  sys__mgr38__complete                      ;

  assign  mgr39__sys__allSynchronized                 =  mgr_inst[39].mgr__sys__allSynchronized    ;
  assign  mgr_inst[39].sys__mgr__thisSynchronized     =  sys__mgr39__thisSynchronized              ;
  assign  mgr_inst[39].sys__mgr__ready                =  sys__mgr39__ready                         ;
  assign  mgr_inst[39].sys__mgr__complete             =  sys__mgr39__complete                      ;

  assign  mgr40__sys__allSynchronized                 =  mgr_inst[40].mgr__sys__allSynchronized    ;
  assign  mgr_inst[40].sys__mgr__thisSynchronized     =  sys__mgr40__thisSynchronized              ;
  assign  mgr_inst[40].sys__mgr__ready                =  sys__mgr40__ready                         ;
  assign  mgr_inst[40].sys__mgr__complete             =  sys__mgr40__complete                      ;

  assign  mgr41__sys__allSynchronized                 =  mgr_inst[41].mgr__sys__allSynchronized    ;
  assign  mgr_inst[41].sys__mgr__thisSynchronized     =  sys__mgr41__thisSynchronized              ;
  assign  mgr_inst[41].sys__mgr__ready                =  sys__mgr41__ready                         ;
  assign  mgr_inst[41].sys__mgr__complete             =  sys__mgr41__complete                      ;

  assign  mgr42__sys__allSynchronized                 =  mgr_inst[42].mgr__sys__allSynchronized    ;
  assign  mgr_inst[42].sys__mgr__thisSynchronized     =  sys__mgr42__thisSynchronized              ;
  assign  mgr_inst[42].sys__mgr__ready                =  sys__mgr42__ready                         ;
  assign  mgr_inst[42].sys__mgr__complete             =  sys__mgr42__complete                      ;

  assign  mgr43__sys__allSynchronized                 =  mgr_inst[43].mgr__sys__allSynchronized    ;
  assign  mgr_inst[43].sys__mgr__thisSynchronized     =  sys__mgr43__thisSynchronized              ;
  assign  mgr_inst[43].sys__mgr__ready                =  sys__mgr43__ready                         ;
  assign  mgr_inst[43].sys__mgr__complete             =  sys__mgr43__complete                      ;

  assign  mgr44__sys__allSynchronized                 =  mgr_inst[44].mgr__sys__allSynchronized    ;
  assign  mgr_inst[44].sys__mgr__thisSynchronized     =  sys__mgr44__thisSynchronized              ;
  assign  mgr_inst[44].sys__mgr__ready                =  sys__mgr44__ready                         ;
  assign  mgr_inst[44].sys__mgr__complete             =  sys__mgr44__complete                      ;

  assign  mgr45__sys__allSynchronized                 =  mgr_inst[45].mgr__sys__allSynchronized    ;
  assign  mgr_inst[45].sys__mgr__thisSynchronized     =  sys__mgr45__thisSynchronized              ;
  assign  mgr_inst[45].sys__mgr__ready                =  sys__mgr45__ready                         ;
  assign  mgr_inst[45].sys__mgr__complete             =  sys__mgr45__complete                      ;

  assign  mgr46__sys__allSynchronized                 =  mgr_inst[46].mgr__sys__allSynchronized    ;
  assign  mgr_inst[46].sys__mgr__thisSynchronized     =  sys__mgr46__thisSynchronized              ;
  assign  mgr_inst[46].sys__mgr__ready                =  sys__mgr46__ready                         ;
  assign  mgr_inst[46].sys__mgr__complete             =  sys__mgr46__complete                      ;

  assign  mgr47__sys__allSynchronized                 =  mgr_inst[47].mgr__sys__allSynchronized    ;
  assign  mgr_inst[47].sys__mgr__thisSynchronized     =  sys__mgr47__thisSynchronized              ;
  assign  mgr_inst[47].sys__mgr__ready                =  sys__mgr47__ready                         ;
  assign  mgr_inst[47].sys__mgr__complete             =  sys__mgr47__complete                      ;

  assign  mgr48__sys__allSynchronized                 =  mgr_inst[48].mgr__sys__allSynchronized    ;
  assign  mgr_inst[48].sys__mgr__thisSynchronized     =  sys__mgr48__thisSynchronized              ;
  assign  mgr_inst[48].sys__mgr__ready                =  sys__mgr48__ready                         ;
  assign  mgr_inst[48].sys__mgr__complete             =  sys__mgr48__complete                      ;

  assign  mgr49__sys__allSynchronized                 =  mgr_inst[49].mgr__sys__allSynchronized    ;
  assign  mgr_inst[49].sys__mgr__thisSynchronized     =  sys__mgr49__thisSynchronized              ;
  assign  mgr_inst[49].sys__mgr__ready                =  sys__mgr49__ready                         ;
  assign  mgr_inst[49].sys__mgr__complete             =  sys__mgr49__complete                      ;

  assign  mgr50__sys__allSynchronized                 =  mgr_inst[50].mgr__sys__allSynchronized    ;
  assign  mgr_inst[50].sys__mgr__thisSynchronized     =  sys__mgr50__thisSynchronized              ;
  assign  mgr_inst[50].sys__mgr__ready                =  sys__mgr50__ready                         ;
  assign  mgr_inst[50].sys__mgr__complete             =  sys__mgr50__complete                      ;

  assign  mgr51__sys__allSynchronized                 =  mgr_inst[51].mgr__sys__allSynchronized    ;
  assign  mgr_inst[51].sys__mgr__thisSynchronized     =  sys__mgr51__thisSynchronized              ;
  assign  mgr_inst[51].sys__mgr__ready                =  sys__mgr51__ready                         ;
  assign  mgr_inst[51].sys__mgr__complete             =  sys__mgr51__complete                      ;

  assign  mgr52__sys__allSynchronized                 =  mgr_inst[52].mgr__sys__allSynchronized    ;
  assign  mgr_inst[52].sys__mgr__thisSynchronized     =  sys__mgr52__thisSynchronized              ;
  assign  mgr_inst[52].sys__mgr__ready                =  sys__mgr52__ready                         ;
  assign  mgr_inst[52].sys__mgr__complete             =  sys__mgr52__complete                      ;

  assign  mgr53__sys__allSynchronized                 =  mgr_inst[53].mgr__sys__allSynchronized    ;
  assign  mgr_inst[53].sys__mgr__thisSynchronized     =  sys__mgr53__thisSynchronized              ;
  assign  mgr_inst[53].sys__mgr__ready                =  sys__mgr53__ready                         ;
  assign  mgr_inst[53].sys__mgr__complete             =  sys__mgr53__complete                      ;

  assign  mgr54__sys__allSynchronized                 =  mgr_inst[54].mgr__sys__allSynchronized    ;
  assign  mgr_inst[54].sys__mgr__thisSynchronized     =  sys__mgr54__thisSynchronized              ;
  assign  mgr_inst[54].sys__mgr__ready                =  sys__mgr54__ready                         ;
  assign  mgr_inst[54].sys__mgr__complete             =  sys__mgr54__complete                      ;

  assign  mgr55__sys__allSynchronized                 =  mgr_inst[55].mgr__sys__allSynchronized    ;
  assign  mgr_inst[55].sys__mgr__thisSynchronized     =  sys__mgr55__thisSynchronized              ;
  assign  mgr_inst[55].sys__mgr__ready                =  sys__mgr55__ready                         ;
  assign  mgr_inst[55].sys__mgr__complete             =  sys__mgr55__complete                      ;

  assign  mgr56__sys__allSynchronized                 =  mgr_inst[56].mgr__sys__allSynchronized    ;
  assign  mgr_inst[56].sys__mgr__thisSynchronized     =  sys__mgr56__thisSynchronized              ;
  assign  mgr_inst[56].sys__mgr__ready                =  sys__mgr56__ready                         ;
  assign  mgr_inst[56].sys__mgr__complete             =  sys__mgr56__complete                      ;

  assign  mgr57__sys__allSynchronized                 =  mgr_inst[57].mgr__sys__allSynchronized    ;
  assign  mgr_inst[57].sys__mgr__thisSynchronized     =  sys__mgr57__thisSynchronized              ;
  assign  mgr_inst[57].sys__mgr__ready                =  sys__mgr57__ready                         ;
  assign  mgr_inst[57].sys__mgr__complete             =  sys__mgr57__complete                      ;

  assign  mgr58__sys__allSynchronized                 =  mgr_inst[58].mgr__sys__allSynchronized    ;
  assign  mgr_inst[58].sys__mgr__thisSynchronized     =  sys__mgr58__thisSynchronized              ;
  assign  mgr_inst[58].sys__mgr__ready                =  sys__mgr58__ready                         ;
  assign  mgr_inst[58].sys__mgr__complete             =  sys__mgr58__complete                      ;

  assign  mgr59__sys__allSynchronized                 =  mgr_inst[59].mgr__sys__allSynchronized    ;
  assign  mgr_inst[59].sys__mgr__thisSynchronized     =  sys__mgr59__thisSynchronized              ;
  assign  mgr_inst[59].sys__mgr__ready                =  sys__mgr59__ready                         ;
  assign  mgr_inst[59].sys__mgr__complete             =  sys__mgr59__complete                      ;

  assign  mgr60__sys__allSynchronized                 =  mgr_inst[60].mgr__sys__allSynchronized    ;
  assign  mgr_inst[60].sys__mgr__thisSynchronized     =  sys__mgr60__thisSynchronized              ;
  assign  mgr_inst[60].sys__mgr__ready                =  sys__mgr60__ready                         ;
  assign  mgr_inst[60].sys__mgr__complete             =  sys__mgr60__complete                      ;

  assign  mgr61__sys__allSynchronized                 =  mgr_inst[61].mgr__sys__allSynchronized    ;
  assign  mgr_inst[61].sys__mgr__thisSynchronized     =  sys__mgr61__thisSynchronized              ;
  assign  mgr_inst[61].sys__mgr__ready                =  sys__mgr61__ready                         ;
  assign  mgr_inst[61].sys__mgr__complete             =  sys__mgr61__complete                      ;

  assign  mgr62__sys__allSynchronized                 =  mgr_inst[62].mgr__sys__allSynchronized    ;
  assign  mgr_inst[62].sys__mgr__thisSynchronized     =  sys__mgr62__thisSynchronized              ;
  assign  mgr_inst[62].sys__mgr__ready                =  sys__mgr62__ready                         ;
  assign  mgr_inst[62].sys__mgr__complete             =  sys__mgr62__complete                      ;

  assign  mgr63__sys__allSynchronized                 =  mgr_inst[63].mgr__sys__allSynchronized    ;
  assign  mgr_inst[63].sys__mgr__thisSynchronized     =  sys__mgr63__thisSynchronized              ;
  assign  mgr_inst[63].sys__mgr__ready                =  sys__mgr63__ready                         ;
  assign  mgr_inst[63].sys__mgr__complete             =  sys__mgr63__complete                      ;
