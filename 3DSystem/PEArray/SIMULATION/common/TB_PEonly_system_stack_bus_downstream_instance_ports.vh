
  // General control and status                                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .sys__pe0__allSynchronized    ( SysOob2PeArray[0].cb_test.sys__pe__allSynchronized   ), 
        .pe0__sys__thisSynchronized   ( SysOob2PeArray[0].pe__sys__thisSynchronized          ), 
        .pe0__sys__ready              ( SysOob2PeArray[0].pe__sys__ready                     ), 
        .pe0__sys__complete           ( SysOob2PeArray[0].pe__sys__complete                  ), 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .std__pe0__oob_cntl           ( SysOob2PeArray[0].cb_test.std__pe__oob_cntl          ), 
        .std__pe0__oob_valid          ( SysOob2PeArray[0].cb_test.std__pe__oob_valid         ), 
        .pe0__std__oob_ready          ( SysOob2PeArray[0].pe__std__oob_ready                 ), 
        .std__pe0__oob_type           ( SysOob2PeArray[0].cb_test.std__pe__oob_type          ), 
        .std__pe0__oob_data           ( SysOob2PeArray[0].cb_test.std__pe__oob_data          ), 
        // PE 0, Lane 0                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane0_strm0_ready         ( SysLane2PeArray[0][0].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane0_strm0_cntl          ( SysLane2PeArray[0][0].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane0_strm0_data          ( SysLane2PeArray[0][0].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane0_strm0_data_valid    ( SysLane2PeArray[0][0].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane0_strm1_ready         ( SysLane2PeArray[0][0].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane0_strm1_cntl          ( SysLane2PeArray[0][0].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane0_strm1_data          ( SysLane2PeArray[0][0].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane0_strm1_data_valid    ( SysLane2PeArray[0][0].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 1                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane1_strm0_ready         ( SysLane2PeArray[0][1].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane1_strm0_cntl          ( SysLane2PeArray[0][1].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane1_strm0_data          ( SysLane2PeArray[0][1].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane1_strm0_data_valid    ( SysLane2PeArray[0][1].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane1_strm1_ready         ( SysLane2PeArray[0][1].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane1_strm1_cntl          ( SysLane2PeArray[0][1].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane1_strm1_data          ( SysLane2PeArray[0][1].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane1_strm1_data_valid    ( SysLane2PeArray[0][1].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 2                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane2_strm0_ready         ( SysLane2PeArray[0][2].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane2_strm0_cntl          ( SysLane2PeArray[0][2].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane2_strm0_data          ( SysLane2PeArray[0][2].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane2_strm0_data_valid    ( SysLane2PeArray[0][2].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane2_strm1_ready         ( SysLane2PeArray[0][2].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane2_strm1_cntl          ( SysLane2PeArray[0][2].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane2_strm1_data          ( SysLane2PeArray[0][2].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane2_strm1_data_valid    ( SysLane2PeArray[0][2].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 3                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane3_strm0_ready         ( SysLane2PeArray[0][3].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane3_strm0_cntl          ( SysLane2PeArray[0][3].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane3_strm0_data          ( SysLane2PeArray[0][3].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane3_strm0_data_valid    ( SysLane2PeArray[0][3].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane3_strm1_ready         ( SysLane2PeArray[0][3].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane3_strm1_cntl          ( SysLane2PeArray[0][3].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane3_strm1_data          ( SysLane2PeArray[0][3].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane3_strm1_data_valid    ( SysLane2PeArray[0][3].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 4                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane4_strm0_ready         ( SysLane2PeArray[0][4].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane4_strm0_cntl          ( SysLane2PeArray[0][4].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane4_strm0_data          ( SysLane2PeArray[0][4].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane4_strm0_data_valid    ( SysLane2PeArray[0][4].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane4_strm1_ready         ( SysLane2PeArray[0][4].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane4_strm1_cntl          ( SysLane2PeArray[0][4].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane4_strm1_data          ( SysLane2PeArray[0][4].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane4_strm1_data_valid    ( SysLane2PeArray[0][4].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 5                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane5_strm0_ready         ( SysLane2PeArray[0][5].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane5_strm0_cntl          ( SysLane2PeArray[0][5].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane5_strm0_data          ( SysLane2PeArray[0][5].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane5_strm0_data_valid    ( SysLane2PeArray[0][5].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane5_strm1_ready         ( SysLane2PeArray[0][5].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane5_strm1_cntl          ( SysLane2PeArray[0][5].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane5_strm1_data          ( SysLane2PeArray[0][5].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane5_strm1_data_valid    ( SysLane2PeArray[0][5].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 6                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane6_strm0_ready         ( SysLane2PeArray[0][6].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane6_strm0_cntl          ( SysLane2PeArray[0][6].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane6_strm0_data          ( SysLane2PeArray[0][6].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane6_strm0_data_valid    ( SysLane2PeArray[0][6].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane6_strm1_ready         ( SysLane2PeArray[0][6].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane6_strm1_cntl          ( SysLane2PeArray[0][6].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane6_strm1_data          ( SysLane2PeArray[0][6].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane6_strm1_data_valid    ( SysLane2PeArray[0][6].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 7                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane7_strm0_ready         ( SysLane2PeArray[0][7].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane7_strm0_cntl          ( SysLane2PeArray[0][7].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane7_strm0_data          ( SysLane2PeArray[0][7].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane7_strm0_data_valid    ( SysLane2PeArray[0][7].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane7_strm1_ready         ( SysLane2PeArray[0][7].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane7_strm1_cntl          ( SysLane2PeArray[0][7].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane7_strm1_data          ( SysLane2PeArray[0][7].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane7_strm1_data_valid    ( SysLane2PeArray[0][7].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 8                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane8_strm0_ready         ( SysLane2PeArray[0][8].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane8_strm0_cntl          ( SysLane2PeArray[0][8].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane8_strm0_data          ( SysLane2PeArray[0][8].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane8_strm0_data_valid    ( SysLane2PeArray[0][8].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane8_strm1_ready         ( SysLane2PeArray[0][8].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane8_strm1_cntl          ( SysLane2PeArray[0][8].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane8_strm1_data          ( SysLane2PeArray[0][8].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane8_strm1_data_valid    ( SysLane2PeArray[0][8].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 9                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane9_strm0_ready         ( SysLane2PeArray[0][9].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane9_strm0_cntl          ( SysLane2PeArray[0][9].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane9_strm0_data          ( SysLane2PeArray[0][9].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane9_strm0_data_valid    ( SysLane2PeArray[0][9].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane9_strm1_ready         ( SysLane2PeArray[0][9].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane9_strm1_cntl          ( SysLane2PeArray[0][9].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane9_strm1_data          ( SysLane2PeArray[0][9].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane9_strm1_data_valid    ( SysLane2PeArray[0][9].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 10                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane10_strm0_ready         ( SysLane2PeArray[0][10].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane10_strm0_cntl          ( SysLane2PeArray[0][10].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane10_strm0_data          ( SysLane2PeArray[0][10].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane10_strm0_data_valid    ( SysLane2PeArray[0][10].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane10_strm1_ready         ( SysLane2PeArray[0][10].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane10_strm1_cntl          ( SysLane2PeArray[0][10].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane10_strm1_data          ( SysLane2PeArray[0][10].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane10_strm1_data_valid    ( SysLane2PeArray[0][10].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 11                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane11_strm0_ready         ( SysLane2PeArray[0][11].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane11_strm0_cntl          ( SysLane2PeArray[0][11].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane11_strm0_data          ( SysLane2PeArray[0][11].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane11_strm0_data_valid    ( SysLane2PeArray[0][11].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane11_strm1_ready         ( SysLane2PeArray[0][11].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane11_strm1_cntl          ( SysLane2PeArray[0][11].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane11_strm1_data          ( SysLane2PeArray[0][11].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane11_strm1_data_valid    ( SysLane2PeArray[0][11].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 12                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane12_strm0_ready         ( SysLane2PeArray[0][12].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane12_strm0_cntl          ( SysLane2PeArray[0][12].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane12_strm0_data          ( SysLane2PeArray[0][12].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane12_strm0_data_valid    ( SysLane2PeArray[0][12].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane12_strm1_ready         ( SysLane2PeArray[0][12].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane12_strm1_cntl          ( SysLane2PeArray[0][12].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane12_strm1_data          ( SysLane2PeArray[0][12].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane12_strm1_data_valid    ( SysLane2PeArray[0][12].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 13                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane13_strm0_ready         ( SysLane2PeArray[0][13].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane13_strm0_cntl          ( SysLane2PeArray[0][13].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane13_strm0_data          ( SysLane2PeArray[0][13].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane13_strm0_data_valid    ( SysLane2PeArray[0][13].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane13_strm1_ready         ( SysLane2PeArray[0][13].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane13_strm1_cntl          ( SysLane2PeArray[0][13].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane13_strm1_data          ( SysLane2PeArray[0][13].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane13_strm1_data_valid    ( SysLane2PeArray[0][13].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 14                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane14_strm0_ready         ( SysLane2PeArray[0][14].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane14_strm0_cntl          ( SysLane2PeArray[0][14].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane14_strm0_data          ( SysLane2PeArray[0][14].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane14_strm0_data_valid    ( SysLane2PeArray[0][14].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane14_strm1_ready         ( SysLane2PeArray[0][14].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane14_strm1_cntl          ( SysLane2PeArray[0][14].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane14_strm1_data          ( SysLane2PeArray[0][14].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane14_strm1_data_valid    ( SysLane2PeArray[0][14].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 15                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane15_strm0_ready         ( SysLane2PeArray[0][15].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane15_strm0_cntl          ( SysLane2PeArray[0][15].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane15_strm0_data          ( SysLane2PeArray[0][15].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane15_strm0_data_valid    ( SysLane2PeArray[0][15].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane15_strm1_ready         ( SysLane2PeArray[0][15].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane15_strm1_cntl          ( SysLane2PeArray[0][15].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane15_strm1_data          ( SysLane2PeArray[0][15].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane15_strm1_data_valid    ( SysLane2PeArray[0][15].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 16                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane16_strm0_ready         ( SysLane2PeArray[0][16].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane16_strm0_cntl          ( SysLane2PeArray[0][16].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane16_strm0_data          ( SysLane2PeArray[0][16].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane16_strm0_data_valid    ( SysLane2PeArray[0][16].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane16_strm1_ready         ( SysLane2PeArray[0][16].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane16_strm1_cntl          ( SysLane2PeArray[0][16].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane16_strm1_data          ( SysLane2PeArray[0][16].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane16_strm1_data_valid    ( SysLane2PeArray[0][16].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 17                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane17_strm0_ready         ( SysLane2PeArray[0][17].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane17_strm0_cntl          ( SysLane2PeArray[0][17].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane17_strm0_data          ( SysLane2PeArray[0][17].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane17_strm0_data_valid    ( SysLane2PeArray[0][17].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane17_strm1_ready         ( SysLane2PeArray[0][17].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane17_strm1_cntl          ( SysLane2PeArray[0][17].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane17_strm1_data          ( SysLane2PeArray[0][17].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane17_strm1_data_valid    ( SysLane2PeArray[0][17].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 18                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane18_strm0_ready         ( SysLane2PeArray[0][18].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane18_strm0_cntl          ( SysLane2PeArray[0][18].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane18_strm0_data          ( SysLane2PeArray[0][18].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane18_strm0_data_valid    ( SysLane2PeArray[0][18].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane18_strm1_ready         ( SysLane2PeArray[0][18].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane18_strm1_cntl          ( SysLane2PeArray[0][18].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane18_strm1_data          ( SysLane2PeArray[0][18].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane18_strm1_data_valid    ( SysLane2PeArray[0][18].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 19                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane19_strm0_ready         ( SysLane2PeArray[0][19].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane19_strm0_cntl          ( SysLane2PeArray[0][19].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane19_strm0_data          ( SysLane2PeArray[0][19].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane19_strm0_data_valid    ( SysLane2PeArray[0][19].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane19_strm1_ready         ( SysLane2PeArray[0][19].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane19_strm1_cntl          ( SysLane2PeArray[0][19].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane19_strm1_data          ( SysLane2PeArray[0][19].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane19_strm1_data_valid    ( SysLane2PeArray[0][19].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 20                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane20_strm0_ready         ( SysLane2PeArray[0][20].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane20_strm0_cntl          ( SysLane2PeArray[0][20].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane20_strm0_data          ( SysLane2PeArray[0][20].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane20_strm0_data_valid    ( SysLane2PeArray[0][20].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane20_strm1_ready         ( SysLane2PeArray[0][20].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane20_strm1_cntl          ( SysLane2PeArray[0][20].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane20_strm1_data          ( SysLane2PeArray[0][20].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane20_strm1_data_valid    ( SysLane2PeArray[0][20].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 21                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane21_strm0_ready         ( SysLane2PeArray[0][21].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane21_strm0_cntl          ( SysLane2PeArray[0][21].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane21_strm0_data          ( SysLane2PeArray[0][21].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane21_strm0_data_valid    ( SysLane2PeArray[0][21].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane21_strm1_ready         ( SysLane2PeArray[0][21].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane21_strm1_cntl          ( SysLane2PeArray[0][21].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane21_strm1_data          ( SysLane2PeArray[0][21].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane21_strm1_data_valid    ( SysLane2PeArray[0][21].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 22                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane22_strm0_ready         ( SysLane2PeArray[0][22].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane22_strm0_cntl          ( SysLane2PeArray[0][22].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane22_strm0_data          ( SysLane2PeArray[0][22].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane22_strm0_data_valid    ( SysLane2PeArray[0][22].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane22_strm1_ready         ( SysLane2PeArray[0][22].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane22_strm1_cntl          ( SysLane2PeArray[0][22].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane22_strm1_data          ( SysLane2PeArray[0][22].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane22_strm1_data_valid    ( SysLane2PeArray[0][22].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 23                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane23_strm0_ready         ( SysLane2PeArray[0][23].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane23_strm0_cntl          ( SysLane2PeArray[0][23].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane23_strm0_data          ( SysLane2PeArray[0][23].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane23_strm0_data_valid    ( SysLane2PeArray[0][23].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane23_strm1_ready         ( SysLane2PeArray[0][23].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane23_strm1_cntl          ( SysLane2PeArray[0][23].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane23_strm1_data          ( SysLane2PeArray[0][23].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane23_strm1_data_valid    ( SysLane2PeArray[0][23].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 24                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane24_strm0_ready         ( SysLane2PeArray[0][24].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane24_strm0_cntl          ( SysLane2PeArray[0][24].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane24_strm0_data          ( SysLane2PeArray[0][24].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane24_strm0_data_valid    ( SysLane2PeArray[0][24].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane24_strm1_ready         ( SysLane2PeArray[0][24].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane24_strm1_cntl          ( SysLane2PeArray[0][24].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane24_strm1_data          ( SysLane2PeArray[0][24].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane24_strm1_data_valid    ( SysLane2PeArray[0][24].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 25                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane25_strm0_ready         ( SysLane2PeArray[0][25].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane25_strm0_cntl          ( SysLane2PeArray[0][25].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane25_strm0_data          ( SysLane2PeArray[0][25].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane25_strm0_data_valid    ( SysLane2PeArray[0][25].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane25_strm1_ready         ( SysLane2PeArray[0][25].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane25_strm1_cntl          ( SysLane2PeArray[0][25].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane25_strm1_data          ( SysLane2PeArray[0][25].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane25_strm1_data_valid    ( SysLane2PeArray[0][25].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 26                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane26_strm0_ready         ( SysLane2PeArray[0][26].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane26_strm0_cntl          ( SysLane2PeArray[0][26].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane26_strm0_data          ( SysLane2PeArray[0][26].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane26_strm0_data_valid    ( SysLane2PeArray[0][26].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane26_strm1_ready         ( SysLane2PeArray[0][26].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane26_strm1_cntl          ( SysLane2PeArray[0][26].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane26_strm1_data          ( SysLane2PeArray[0][26].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane26_strm1_data_valid    ( SysLane2PeArray[0][26].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 27                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane27_strm0_ready         ( SysLane2PeArray[0][27].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane27_strm0_cntl          ( SysLane2PeArray[0][27].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane27_strm0_data          ( SysLane2PeArray[0][27].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane27_strm0_data_valid    ( SysLane2PeArray[0][27].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane27_strm1_ready         ( SysLane2PeArray[0][27].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane27_strm1_cntl          ( SysLane2PeArray[0][27].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane27_strm1_data          ( SysLane2PeArray[0][27].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane27_strm1_data_valid    ( SysLane2PeArray[0][27].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 28                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane28_strm0_ready         ( SysLane2PeArray[0][28].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane28_strm0_cntl          ( SysLane2PeArray[0][28].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane28_strm0_data          ( SysLane2PeArray[0][28].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane28_strm0_data_valid    ( SysLane2PeArray[0][28].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane28_strm1_ready         ( SysLane2PeArray[0][28].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane28_strm1_cntl          ( SysLane2PeArray[0][28].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane28_strm1_data          ( SysLane2PeArray[0][28].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane28_strm1_data_valid    ( SysLane2PeArray[0][28].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 29                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane29_strm0_ready         ( SysLane2PeArray[0][29].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane29_strm0_cntl          ( SysLane2PeArray[0][29].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane29_strm0_data          ( SysLane2PeArray[0][29].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane29_strm0_data_valid    ( SysLane2PeArray[0][29].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane29_strm1_ready         ( SysLane2PeArray[0][29].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane29_strm1_cntl          ( SysLane2PeArray[0][29].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane29_strm1_data          ( SysLane2PeArray[0][29].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane29_strm1_data_valid    ( SysLane2PeArray[0][29].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 30                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane30_strm0_ready         ( SysLane2PeArray[0][30].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane30_strm0_cntl          ( SysLane2PeArray[0][30].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane30_strm0_data          ( SysLane2PeArray[0][30].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane30_strm0_data_valid    ( SysLane2PeArray[0][30].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane30_strm1_ready         ( SysLane2PeArray[0][30].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane30_strm1_cntl          ( SysLane2PeArray[0][30].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane30_strm1_data          ( SysLane2PeArray[0][30].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane30_strm1_data_valid    ( SysLane2PeArray[0][30].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 0, Lane 31                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane31_strm0_ready         ( SysLane2PeArray[0][31].pe__std__lane_strm0_ready              ),      
        .std__pe0__lane31_strm0_cntl          ( SysLane2PeArray[0][31].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe0__lane31_strm0_data          ( SysLane2PeArray[0][31].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe0__lane31_strm0_data_valid    ( SysLane2PeArray[0][31].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__std__lane31_strm1_ready         ( SysLane2PeArray[0][31].pe__std__lane_strm1_ready              ),      
        .std__pe0__lane31_strm1_cntl          ( SysLane2PeArray[0][31].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe0__lane31_strm1_data          ( SysLane2PeArray[0][31].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe0__lane31_strm1_data_valid    ( SysLane2PeArray[0][31].cb_test.std__pe__lane_strm1_data_valid ),      
        
  // General control and status                                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .sys__pe1__allSynchronized    ( SysOob2PeArray[1].cb_test.sys__pe__allSynchronized   ), 
        .pe1__sys__thisSynchronized   ( SysOob2PeArray[1].pe__sys__thisSynchronized          ), 
        .pe1__sys__ready              ( SysOob2PeArray[1].pe__sys__ready                     ), 
        .pe1__sys__complete           ( SysOob2PeArray[1].pe__sys__complete                  ), 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .std__pe1__oob_cntl           ( SysOob2PeArray[1].cb_test.std__pe__oob_cntl          ), 
        .std__pe1__oob_valid          ( SysOob2PeArray[1].cb_test.std__pe__oob_valid         ), 
        .pe1__std__oob_ready          ( SysOob2PeArray[1].pe__std__oob_ready                 ), 
        .std__pe1__oob_type           ( SysOob2PeArray[1].cb_test.std__pe__oob_type          ), 
        .std__pe1__oob_data           ( SysOob2PeArray[1].cb_test.std__pe__oob_data          ), 
        // PE 1, Lane 0                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane0_strm0_ready         ( SysLane2PeArray[1][0].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane0_strm0_cntl          ( SysLane2PeArray[1][0].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane0_strm0_data          ( SysLane2PeArray[1][0].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane0_strm0_data_valid    ( SysLane2PeArray[1][0].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane0_strm1_ready         ( SysLane2PeArray[1][0].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane0_strm1_cntl          ( SysLane2PeArray[1][0].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane0_strm1_data          ( SysLane2PeArray[1][0].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane0_strm1_data_valid    ( SysLane2PeArray[1][0].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 1                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane1_strm0_ready         ( SysLane2PeArray[1][1].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane1_strm0_cntl          ( SysLane2PeArray[1][1].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane1_strm0_data          ( SysLane2PeArray[1][1].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane1_strm0_data_valid    ( SysLane2PeArray[1][1].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane1_strm1_ready         ( SysLane2PeArray[1][1].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane1_strm1_cntl          ( SysLane2PeArray[1][1].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane1_strm1_data          ( SysLane2PeArray[1][1].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane1_strm1_data_valid    ( SysLane2PeArray[1][1].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 2                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane2_strm0_ready         ( SysLane2PeArray[1][2].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane2_strm0_cntl          ( SysLane2PeArray[1][2].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane2_strm0_data          ( SysLane2PeArray[1][2].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane2_strm0_data_valid    ( SysLane2PeArray[1][2].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane2_strm1_ready         ( SysLane2PeArray[1][2].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane2_strm1_cntl          ( SysLane2PeArray[1][2].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane2_strm1_data          ( SysLane2PeArray[1][2].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane2_strm1_data_valid    ( SysLane2PeArray[1][2].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 3                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane3_strm0_ready         ( SysLane2PeArray[1][3].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane3_strm0_cntl          ( SysLane2PeArray[1][3].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane3_strm0_data          ( SysLane2PeArray[1][3].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane3_strm0_data_valid    ( SysLane2PeArray[1][3].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane3_strm1_ready         ( SysLane2PeArray[1][3].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane3_strm1_cntl          ( SysLane2PeArray[1][3].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane3_strm1_data          ( SysLane2PeArray[1][3].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane3_strm1_data_valid    ( SysLane2PeArray[1][3].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 4                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane4_strm0_ready         ( SysLane2PeArray[1][4].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane4_strm0_cntl          ( SysLane2PeArray[1][4].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane4_strm0_data          ( SysLane2PeArray[1][4].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane4_strm0_data_valid    ( SysLane2PeArray[1][4].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane4_strm1_ready         ( SysLane2PeArray[1][4].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane4_strm1_cntl          ( SysLane2PeArray[1][4].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane4_strm1_data          ( SysLane2PeArray[1][4].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane4_strm1_data_valid    ( SysLane2PeArray[1][4].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 5                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane5_strm0_ready         ( SysLane2PeArray[1][5].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane5_strm0_cntl          ( SysLane2PeArray[1][5].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane5_strm0_data          ( SysLane2PeArray[1][5].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane5_strm0_data_valid    ( SysLane2PeArray[1][5].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane5_strm1_ready         ( SysLane2PeArray[1][5].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane5_strm1_cntl          ( SysLane2PeArray[1][5].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane5_strm1_data          ( SysLane2PeArray[1][5].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane5_strm1_data_valid    ( SysLane2PeArray[1][5].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 6                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane6_strm0_ready         ( SysLane2PeArray[1][6].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane6_strm0_cntl          ( SysLane2PeArray[1][6].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane6_strm0_data          ( SysLane2PeArray[1][6].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane6_strm0_data_valid    ( SysLane2PeArray[1][6].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane6_strm1_ready         ( SysLane2PeArray[1][6].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane6_strm1_cntl          ( SysLane2PeArray[1][6].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane6_strm1_data          ( SysLane2PeArray[1][6].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane6_strm1_data_valid    ( SysLane2PeArray[1][6].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 7                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane7_strm0_ready         ( SysLane2PeArray[1][7].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane7_strm0_cntl          ( SysLane2PeArray[1][7].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane7_strm0_data          ( SysLane2PeArray[1][7].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane7_strm0_data_valid    ( SysLane2PeArray[1][7].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane7_strm1_ready         ( SysLane2PeArray[1][7].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane7_strm1_cntl          ( SysLane2PeArray[1][7].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane7_strm1_data          ( SysLane2PeArray[1][7].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane7_strm1_data_valid    ( SysLane2PeArray[1][7].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 8                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane8_strm0_ready         ( SysLane2PeArray[1][8].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane8_strm0_cntl          ( SysLane2PeArray[1][8].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane8_strm0_data          ( SysLane2PeArray[1][8].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane8_strm0_data_valid    ( SysLane2PeArray[1][8].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane8_strm1_ready         ( SysLane2PeArray[1][8].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane8_strm1_cntl          ( SysLane2PeArray[1][8].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane8_strm1_data          ( SysLane2PeArray[1][8].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane8_strm1_data_valid    ( SysLane2PeArray[1][8].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 9                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane9_strm0_ready         ( SysLane2PeArray[1][9].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane9_strm0_cntl          ( SysLane2PeArray[1][9].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane9_strm0_data          ( SysLane2PeArray[1][9].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane9_strm0_data_valid    ( SysLane2PeArray[1][9].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane9_strm1_ready         ( SysLane2PeArray[1][9].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane9_strm1_cntl          ( SysLane2PeArray[1][9].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane9_strm1_data          ( SysLane2PeArray[1][9].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane9_strm1_data_valid    ( SysLane2PeArray[1][9].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 10                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane10_strm0_ready         ( SysLane2PeArray[1][10].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane10_strm0_cntl          ( SysLane2PeArray[1][10].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane10_strm0_data          ( SysLane2PeArray[1][10].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane10_strm0_data_valid    ( SysLane2PeArray[1][10].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane10_strm1_ready         ( SysLane2PeArray[1][10].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane10_strm1_cntl          ( SysLane2PeArray[1][10].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane10_strm1_data          ( SysLane2PeArray[1][10].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane10_strm1_data_valid    ( SysLane2PeArray[1][10].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 11                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane11_strm0_ready         ( SysLane2PeArray[1][11].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane11_strm0_cntl          ( SysLane2PeArray[1][11].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane11_strm0_data          ( SysLane2PeArray[1][11].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane11_strm0_data_valid    ( SysLane2PeArray[1][11].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane11_strm1_ready         ( SysLane2PeArray[1][11].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane11_strm1_cntl          ( SysLane2PeArray[1][11].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane11_strm1_data          ( SysLane2PeArray[1][11].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane11_strm1_data_valid    ( SysLane2PeArray[1][11].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 12                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane12_strm0_ready         ( SysLane2PeArray[1][12].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane12_strm0_cntl          ( SysLane2PeArray[1][12].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane12_strm0_data          ( SysLane2PeArray[1][12].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane12_strm0_data_valid    ( SysLane2PeArray[1][12].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane12_strm1_ready         ( SysLane2PeArray[1][12].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane12_strm1_cntl          ( SysLane2PeArray[1][12].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane12_strm1_data          ( SysLane2PeArray[1][12].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane12_strm1_data_valid    ( SysLane2PeArray[1][12].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 13                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane13_strm0_ready         ( SysLane2PeArray[1][13].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane13_strm0_cntl          ( SysLane2PeArray[1][13].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane13_strm0_data          ( SysLane2PeArray[1][13].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane13_strm0_data_valid    ( SysLane2PeArray[1][13].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane13_strm1_ready         ( SysLane2PeArray[1][13].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane13_strm1_cntl          ( SysLane2PeArray[1][13].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane13_strm1_data          ( SysLane2PeArray[1][13].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane13_strm1_data_valid    ( SysLane2PeArray[1][13].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 14                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane14_strm0_ready         ( SysLane2PeArray[1][14].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane14_strm0_cntl          ( SysLane2PeArray[1][14].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane14_strm0_data          ( SysLane2PeArray[1][14].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane14_strm0_data_valid    ( SysLane2PeArray[1][14].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane14_strm1_ready         ( SysLane2PeArray[1][14].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane14_strm1_cntl          ( SysLane2PeArray[1][14].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane14_strm1_data          ( SysLane2PeArray[1][14].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane14_strm1_data_valid    ( SysLane2PeArray[1][14].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 15                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane15_strm0_ready         ( SysLane2PeArray[1][15].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane15_strm0_cntl          ( SysLane2PeArray[1][15].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane15_strm0_data          ( SysLane2PeArray[1][15].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane15_strm0_data_valid    ( SysLane2PeArray[1][15].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane15_strm1_ready         ( SysLane2PeArray[1][15].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane15_strm1_cntl          ( SysLane2PeArray[1][15].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane15_strm1_data          ( SysLane2PeArray[1][15].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane15_strm1_data_valid    ( SysLane2PeArray[1][15].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 16                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane16_strm0_ready         ( SysLane2PeArray[1][16].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane16_strm0_cntl          ( SysLane2PeArray[1][16].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane16_strm0_data          ( SysLane2PeArray[1][16].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane16_strm0_data_valid    ( SysLane2PeArray[1][16].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane16_strm1_ready         ( SysLane2PeArray[1][16].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane16_strm1_cntl          ( SysLane2PeArray[1][16].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane16_strm1_data          ( SysLane2PeArray[1][16].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane16_strm1_data_valid    ( SysLane2PeArray[1][16].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 17                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane17_strm0_ready         ( SysLane2PeArray[1][17].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane17_strm0_cntl          ( SysLane2PeArray[1][17].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane17_strm0_data          ( SysLane2PeArray[1][17].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane17_strm0_data_valid    ( SysLane2PeArray[1][17].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane17_strm1_ready         ( SysLane2PeArray[1][17].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane17_strm1_cntl          ( SysLane2PeArray[1][17].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane17_strm1_data          ( SysLane2PeArray[1][17].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane17_strm1_data_valid    ( SysLane2PeArray[1][17].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 18                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane18_strm0_ready         ( SysLane2PeArray[1][18].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane18_strm0_cntl          ( SysLane2PeArray[1][18].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane18_strm0_data          ( SysLane2PeArray[1][18].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane18_strm0_data_valid    ( SysLane2PeArray[1][18].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane18_strm1_ready         ( SysLane2PeArray[1][18].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane18_strm1_cntl          ( SysLane2PeArray[1][18].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane18_strm1_data          ( SysLane2PeArray[1][18].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane18_strm1_data_valid    ( SysLane2PeArray[1][18].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 19                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane19_strm0_ready         ( SysLane2PeArray[1][19].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane19_strm0_cntl          ( SysLane2PeArray[1][19].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane19_strm0_data          ( SysLane2PeArray[1][19].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane19_strm0_data_valid    ( SysLane2PeArray[1][19].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane19_strm1_ready         ( SysLane2PeArray[1][19].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane19_strm1_cntl          ( SysLane2PeArray[1][19].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane19_strm1_data          ( SysLane2PeArray[1][19].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane19_strm1_data_valid    ( SysLane2PeArray[1][19].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 20                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane20_strm0_ready         ( SysLane2PeArray[1][20].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane20_strm0_cntl          ( SysLane2PeArray[1][20].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane20_strm0_data          ( SysLane2PeArray[1][20].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane20_strm0_data_valid    ( SysLane2PeArray[1][20].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane20_strm1_ready         ( SysLane2PeArray[1][20].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane20_strm1_cntl          ( SysLane2PeArray[1][20].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane20_strm1_data          ( SysLane2PeArray[1][20].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane20_strm1_data_valid    ( SysLane2PeArray[1][20].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 21                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane21_strm0_ready         ( SysLane2PeArray[1][21].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane21_strm0_cntl          ( SysLane2PeArray[1][21].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane21_strm0_data          ( SysLane2PeArray[1][21].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane21_strm0_data_valid    ( SysLane2PeArray[1][21].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane21_strm1_ready         ( SysLane2PeArray[1][21].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane21_strm1_cntl          ( SysLane2PeArray[1][21].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane21_strm1_data          ( SysLane2PeArray[1][21].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane21_strm1_data_valid    ( SysLane2PeArray[1][21].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 22                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane22_strm0_ready         ( SysLane2PeArray[1][22].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane22_strm0_cntl          ( SysLane2PeArray[1][22].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane22_strm0_data          ( SysLane2PeArray[1][22].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane22_strm0_data_valid    ( SysLane2PeArray[1][22].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane22_strm1_ready         ( SysLane2PeArray[1][22].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane22_strm1_cntl          ( SysLane2PeArray[1][22].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane22_strm1_data          ( SysLane2PeArray[1][22].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane22_strm1_data_valid    ( SysLane2PeArray[1][22].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 23                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane23_strm0_ready         ( SysLane2PeArray[1][23].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane23_strm0_cntl          ( SysLane2PeArray[1][23].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane23_strm0_data          ( SysLane2PeArray[1][23].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane23_strm0_data_valid    ( SysLane2PeArray[1][23].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane23_strm1_ready         ( SysLane2PeArray[1][23].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane23_strm1_cntl          ( SysLane2PeArray[1][23].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane23_strm1_data          ( SysLane2PeArray[1][23].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane23_strm1_data_valid    ( SysLane2PeArray[1][23].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 24                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane24_strm0_ready         ( SysLane2PeArray[1][24].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane24_strm0_cntl          ( SysLane2PeArray[1][24].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane24_strm0_data          ( SysLane2PeArray[1][24].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane24_strm0_data_valid    ( SysLane2PeArray[1][24].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane24_strm1_ready         ( SysLane2PeArray[1][24].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane24_strm1_cntl          ( SysLane2PeArray[1][24].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane24_strm1_data          ( SysLane2PeArray[1][24].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane24_strm1_data_valid    ( SysLane2PeArray[1][24].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 25                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane25_strm0_ready         ( SysLane2PeArray[1][25].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane25_strm0_cntl          ( SysLane2PeArray[1][25].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane25_strm0_data          ( SysLane2PeArray[1][25].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane25_strm0_data_valid    ( SysLane2PeArray[1][25].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane25_strm1_ready         ( SysLane2PeArray[1][25].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane25_strm1_cntl          ( SysLane2PeArray[1][25].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane25_strm1_data          ( SysLane2PeArray[1][25].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane25_strm1_data_valid    ( SysLane2PeArray[1][25].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 26                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane26_strm0_ready         ( SysLane2PeArray[1][26].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane26_strm0_cntl          ( SysLane2PeArray[1][26].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane26_strm0_data          ( SysLane2PeArray[1][26].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane26_strm0_data_valid    ( SysLane2PeArray[1][26].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane26_strm1_ready         ( SysLane2PeArray[1][26].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane26_strm1_cntl          ( SysLane2PeArray[1][26].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane26_strm1_data          ( SysLane2PeArray[1][26].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane26_strm1_data_valid    ( SysLane2PeArray[1][26].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 27                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane27_strm0_ready         ( SysLane2PeArray[1][27].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane27_strm0_cntl          ( SysLane2PeArray[1][27].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane27_strm0_data          ( SysLane2PeArray[1][27].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane27_strm0_data_valid    ( SysLane2PeArray[1][27].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane27_strm1_ready         ( SysLane2PeArray[1][27].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane27_strm1_cntl          ( SysLane2PeArray[1][27].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane27_strm1_data          ( SysLane2PeArray[1][27].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane27_strm1_data_valid    ( SysLane2PeArray[1][27].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 28                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane28_strm0_ready         ( SysLane2PeArray[1][28].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane28_strm0_cntl          ( SysLane2PeArray[1][28].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane28_strm0_data          ( SysLane2PeArray[1][28].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane28_strm0_data_valid    ( SysLane2PeArray[1][28].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane28_strm1_ready         ( SysLane2PeArray[1][28].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane28_strm1_cntl          ( SysLane2PeArray[1][28].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane28_strm1_data          ( SysLane2PeArray[1][28].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane28_strm1_data_valid    ( SysLane2PeArray[1][28].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 29                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane29_strm0_ready         ( SysLane2PeArray[1][29].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane29_strm0_cntl          ( SysLane2PeArray[1][29].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane29_strm0_data          ( SysLane2PeArray[1][29].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane29_strm0_data_valid    ( SysLane2PeArray[1][29].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane29_strm1_ready         ( SysLane2PeArray[1][29].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane29_strm1_cntl          ( SysLane2PeArray[1][29].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane29_strm1_data          ( SysLane2PeArray[1][29].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane29_strm1_data_valid    ( SysLane2PeArray[1][29].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 30                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane30_strm0_ready         ( SysLane2PeArray[1][30].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane30_strm0_cntl          ( SysLane2PeArray[1][30].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane30_strm0_data          ( SysLane2PeArray[1][30].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane30_strm0_data_valid    ( SysLane2PeArray[1][30].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane30_strm1_ready         ( SysLane2PeArray[1][30].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane30_strm1_cntl          ( SysLane2PeArray[1][30].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane30_strm1_data          ( SysLane2PeArray[1][30].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane30_strm1_data_valid    ( SysLane2PeArray[1][30].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 1, Lane 31                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane31_strm0_ready         ( SysLane2PeArray[1][31].pe__std__lane_strm0_ready              ),      
        .std__pe1__lane31_strm0_cntl          ( SysLane2PeArray[1][31].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe1__lane31_strm0_data          ( SysLane2PeArray[1][31].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe1__lane31_strm0_data_valid    ( SysLane2PeArray[1][31].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__std__lane31_strm1_ready         ( SysLane2PeArray[1][31].pe__std__lane_strm1_ready              ),      
        .std__pe1__lane31_strm1_cntl          ( SysLane2PeArray[1][31].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe1__lane31_strm1_data          ( SysLane2PeArray[1][31].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe1__lane31_strm1_data_valid    ( SysLane2PeArray[1][31].cb_test.std__pe__lane_strm1_data_valid ),      
        
  // General control and status                                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .sys__pe2__allSynchronized    ( SysOob2PeArray[2].cb_test.sys__pe__allSynchronized   ), 
        .pe2__sys__thisSynchronized   ( SysOob2PeArray[2].pe__sys__thisSynchronized          ), 
        .pe2__sys__ready              ( SysOob2PeArray[2].pe__sys__ready                     ), 
        .pe2__sys__complete           ( SysOob2PeArray[2].pe__sys__complete                  ), 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .std__pe2__oob_cntl           ( SysOob2PeArray[2].cb_test.std__pe__oob_cntl          ), 
        .std__pe2__oob_valid          ( SysOob2PeArray[2].cb_test.std__pe__oob_valid         ), 
        .pe2__std__oob_ready          ( SysOob2PeArray[2].pe__std__oob_ready                 ), 
        .std__pe2__oob_type           ( SysOob2PeArray[2].cb_test.std__pe__oob_type          ), 
        .std__pe2__oob_data           ( SysOob2PeArray[2].cb_test.std__pe__oob_data          ), 
        // PE 2, Lane 0                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane0_strm0_ready         ( SysLane2PeArray[2][0].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane0_strm0_cntl          ( SysLane2PeArray[2][0].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane0_strm0_data          ( SysLane2PeArray[2][0].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane0_strm0_data_valid    ( SysLane2PeArray[2][0].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane0_strm1_ready         ( SysLane2PeArray[2][0].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane0_strm1_cntl          ( SysLane2PeArray[2][0].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane0_strm1_data          ( SysLane2PeArray[2][0].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane0_strm1_data_valid    ( SysLane2PeArray[2][0].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 1                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane1_strm0_ready         ( SysLane2PeArray[2][1].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane1_strm0_cntl          ( SysLane2PeArray[2][1].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane1_strm0_data          ( SysLane2PeArray[2][1].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane1_strm0_data_valid    ( SysLane2PeArray[2][1].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane1_strm1_ready         ( SysLane2PeArray[2][1].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane1_strm1_cntl          ( SysLane2PeArray[2][1].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane1_strm1_data          ( SysLane2PeArray[2][1].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane1_strm1_data_valid    ( SysLane2PeArray[2][1].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 2                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane2_strm0_ready         ( SysLane2PeArray[2][2].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane2_strm0_cntl          ( SysLane2PeArray[2][2].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane2_strm0_data          ( SysLane2PeArray[2][2].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane2_strm0_data_valid    ( SysLane2PeArray[2][2].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane2_strm1_ready         ( SysLane2PeArray[2][2].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane2_strm1_cntl          ( SysLane2PeArray[2][2].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane2_strm1_data          ( SysLane2PeArray[2][2].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane2_strm1_data_valid    ( SysLane2PeArray[2][2].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 3                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane3_strm0_ready         ( SysLane2PeArray[2][3].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane3_strm0_cntl          ( SysLane2PeArray[2][3].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane3_strm0_data          ( SysLane2PeArray[2][3].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane3_strm0_data_valid    ( SysLane2PeArray[2][3].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane3_strm1_ready         ( SysLane2PeArray[2][3].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane3_strm1_cntl          ( SysLane2PeArray[2][3].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane3_strm1_data          ( SysLane2PeArray[2][3].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane3_strm1_data_valid    ( SysLane2PeArray[2][3].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 4                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane4_strm0_ready         ( SysLane2PeArray[2][4].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane4_strm0_cntl          ( SysLane2PeArray[2][4].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane4_strm0_data          ( SysLane2PeArray[2][4].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane4_strm0_data_valid    ( SysLane2PeArray[2][4].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane4_strm1_ready         ( SysLane2PeArray[2][4].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane4_strm1_cntl          ( SysLane2PeArray[2][4].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane4_strm1_data          ( SysLane2PeArray[2][4].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane4_strm1_data_valid    ( SysLane2PeArray[2][4].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 5                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane5_strm0_ready         ( SysLane2PeArray[2][5].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane5_strm0_cntl          ( SysLane2PeArray[2][5].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane5_strm0_data          ( SysLane2PeArray[2][5].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane5_strm0_data_valid    ( SysLane2PeArray[2][5].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane5_strm1_ready         ( SysLane2PeArray[2][5].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane5_strm1_cntl          ( SysLane2PeArray[2][5].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane5_strm1_data          ( SysLane2PeArray[2][5].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane5_strm1_data_valid    ( SysLane2PeArray[2][5].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 6                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane6_strm0_ready         ( SysLane2PeArray[2][6].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane6_strm0_cntl          ( SysLane2PeArray[2][6].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane6_strm0_data          ( SysLane2PeArray[2][6].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane6_strm0_data_valid    ( SysLane2PeArray[2][6].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane6_strm1_ready         ( SysLane2PeArray[2][6].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane6_strm1_cntl          ( SysLane2PeArray[2][6].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane6_strm1_data          ( SysLane2PeArray[2][6].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane6_strm1_data_valid    ( SysLane2PeArray[2][6].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 7                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane7_strm0_ready         ( SysLane2PeArray[2][7].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane7_strm0_cntl          ( SysLane2PeArray[2][7].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane7_strm0_data          ( SysLane2PeArray[2][7].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane7_strm0_data_valid    ( SysLane2PeArray[2][7].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane7_strm1_ready         ( SysLane2PeArray[2][7].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane7_strm1_cntl          ( SysLane2PeArray[2][7].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane7_strm1_data          ( SysLane2PeArray[2][7].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane7_strm1_data_valid    ( SysLane2PeArray[2][7].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 8                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane8_strm0_ready         ( SysLane2PeArray[2][8].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane8_strm0_cntl          ( SysLane2PeArray[2][8].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane8_strm0_data          ( SysLane2PeArray[2][8].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane8_strm0_data_valid    ( SysLane2PeArray[2][8].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane8_strm1_ready         ( SysLane2PeArray[2][8].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane8_strm1_cntl          ( SysLane2PeArray[2][8].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane8_strm1_data          ( SysLane2PeArray[2][8].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane8_strm1_data_valid    ( SysLane2PeArray[2][8].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 9                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane9_strm0_ready         ( SysLane2PeArray[2][9].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane9_strm0_cntl          ( SysLane2PeArray[2][9].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane9_strm0_data          ( SysLane2PeArray[2][9].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane9_strm0_data_valid    ( SysLane2PeArray[2][9].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane9_strm1_ready         ( SysLane2PeArray[2][9].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane9_strm1_cntl          ( SysLane2PeArray[2][9].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane9_strm1_data          ( SysLane2PeArray[2][9].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane9_strm1_data_valid    ( SysLane2PeArray[2][9].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 10                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane10_strm0_ready         ( SysLane2PeArray[2][10].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane10_strm0_cntl          ( SysLane2PeArray[2][10].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane10_strm0_data          ( SysLane2PeArray[2][10].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane10_strm0_data_valid    ( SysLane2PeArray[2][10].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane10_strm1_ready         ( SysLane2PeArray[2][10].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane10_strm1_cntl          ( SysLane2PeArray[2][10].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane10_strm1_data          ( SysLane2PeArray[2][10].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane10_strm1_data_valid    ( SysLane2PeArray[2][10].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 11                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane11_strm0_ready         ( SysLane2PeArray[2][11].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane11_strm0_cntl          ( SysLane2PeArray[2][11].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane11_strm0_data          ( SysLane2PeArray[2][11].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane11_strm0_data_valid    ( SysLane2PeArray[2][11].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane11_strm1_ready         ( SysLane2PeArray[2][11].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane11_strm1_cntl          ( SysLane2PeArray[2][11].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane11_strm1_data          ( SysLane2PeArray[2][11].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane11_strm1_data_valid    ( SysLane2PeArray[2][11].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 12                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane12_strm0_ready         ( SysLane2PeArray[2][12].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane12_strm0_cntl          ( SysLane2PeArray[2][12].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane12_strm0_data          ( SysLane2PeArray[2][12].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane12_strm0_data_valid    ( SysLane2PeArray[2][12].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane12_strm1_ready         ( SysLane2PeArray[2][12].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane12_strm1_cntl          ( SysLane2PeArray[2][12].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane12_strm1_data          ( SysLane2PeArray[2][12].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane12_strm1_data_valid    ( SysLane2PeArray[2][12].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 13                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane13_strm0_ready         ( SysLane2PeArray[2][13].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane13_strm0_cntl          ( SysLane2PeArray[2][13].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane13_strm0_data          ( SysLane2PeArray[2][13].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane13_strm0_data_valid    ( SysLane2PeArray[2][13].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane13_strm1_ready         ( SysLane2PeArray[2][13].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane13_strm1_cntl          ( SysLane2PeArray[2][13].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane13_strm1_data          ( SysLane2PeArray[2][13].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane13_strm1_data_valid    ( SysLane2PeArray[2][13].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 14                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane14_strm0_ready         ( SysLane2PeArray[2][14].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane14_strm0_cntl          ( SysLane2PeArray[2][14].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane14_strm0_data          ( SysLane2PeArray[2][14].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane14_strm0_data_valid    ( SysLane2PeArray[2][14].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane14_strm1_ready         ( SysLane2PeArray[2][14].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane14_strm1_cntl          ( SysLane2PeArray[2][14].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane14_strm1_data          ( SysLane2PeArray[2][14].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane14_strm1_data_valid    ( SysLane2PeArray[2][14].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 15                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane15_strm0_ready         ( SysLane2PeArray[2][15].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane15_strm0_cntl          ( SysLane2PeArray[2][15].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane15_strm0_data          ( SysLane2PeArray[2][15].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane15_strm0_data_valid    ( SysLane2PeArray[2][15].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane15_strm1_ready         ( SysLane2PeArray[2][15].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane15_strm1_cntl          ( SysLane2PeArray[2][15].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane15_strm1_data          ( SysLane2PeArray[2][15].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane15_strm1_data_valid    ( SysLane2PeArray[2][15].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 16                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane16_strm0_ready         ( SysLane2PeArray[2][16].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane16_strm0_cntl          ( SysLane2PeArray[2][16].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane16_strm0_data          ( SysLane2PeArray[2][16].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane16_strm0_data_valid    ( SysLane2PeArray[2][16].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane16_strm1_ready         ( SysLane2PeArray[2][16].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane16_strm1_cntl          ( SysLane2PeArray[2][16].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane16_strm1_data          ( SysLane2PeArray[2][16].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane16_strm1_data_valid    ( SysLane2PeArray[2][16].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 17                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane17_strm0_ready         ( SysLane2PeArray[2][17].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane17_strm0_cntl          ( SysLane2PeArray[2][17].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane17_strm0_data          ( SysLane2PeArray[2][17].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane17_strm0_data_valid    ( SysLane2PeArray[2][17].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane17_strm1_ready         ( SysLane2PeArray[2][17].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane17_strm1_cntl          ( SysLane2PeArray[2][17].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane17_strm1_data          ( SysLane2PeArray[2][17].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane17_strm1_data_valid    ( SysLane2PeArray[2][17].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 18                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane18_strm0_ready         ( SysLane2PeArray[2][18].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane18_strm0_cntl          ( SysLane2PeArray[2][18].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane18_strm0_data          ( SysLane2PeArray[2][18].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane18_strm0_data_valid    ( SysLane2PeArray[2][18].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane18_strm1_ready         ( SysLane2PeArray[2][18].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane18_strm1_cntl          ( SysLane2PeArray[2][18].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane18_strm1_data          ( SysLane2PeArray[2][18].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane18_strm1_data_valid    ( SysLane2PeArray[2][18].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 19                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane19_strm0_ready         ( SysLane2PeArray[2][19].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane19_strm0_cntl          ( SysLane2PeArray[2][19].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane19_strm0_data          ( SysLane2PeArray[2][19].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane19_strm0_data_valid    ( SysLane2PeArray[2][19].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane19_strm1_ready         ( SysLane2PeArray[2][19].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane19_strm1_cntl          ( SysLane2PeArray[2][19].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane19_strm1_data          ( SysLane2PeArray[2][19].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane19_strm1_data_valid    ( SysLane2PeArray[2][19].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 20                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane20_strm0_ready         ( SysLane2PeArray[2][20].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane20_strm0_cntl          ( SysLane2PeArray[2][20].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane20_strm0_data          ( SysLane2PeArray[2][20].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane20_strm0_data_valid    ( SysLane2PeArray[2][20].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane20_strm1_ready         ( SysLane2PeArray[2][20].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane20_strm1_cntl          ( SysLane2PeArray[2][20].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane20_strm1_data          ( SysLane2PeArray[2][20].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane20_strm1_data_valid    ( SysLane2PeArray[2][20].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 21                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane21_strm0_ready         ( SysLane2PeArray[2][21].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane21_strm0_cntl          ( SysLane2PeArray[2][21].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane21_strm0_data          ( SysLane2PeArray[2][21].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane21_strm0_data_valid    ( SysLane2PeArray[2][21].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane21_strm1_ready         ( SysLane2PeArray[2][21].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane21_strm1_cntl          ( SysLane2PeArray[2][21].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane21_strm1_data          ( SysLane2PeArray[2][21].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane21_strm1_data_valid    ( SysLane2PeArray[2][21].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 22                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane22_strm0_ready         ( SysLane2PeArray[2][22].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane22_strm0_cntl          ( SysLane2PeArray[2][22].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane22_strm0_data          ( SysLane2PeArray[2][22].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane22_strm0_data_valid    ( SysLane2PeArray[2][22].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane22_strm1_ready         ( SysLane2PeArray[2][22].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane22_strm1_cntl          ( SysLane2PeArray[2][22].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane22_strm1_data          ( SysLane2PeArray[2][22].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane22_strm1_data_valid    ( SysLane2PeArray[2][22].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 23                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane23_strm0_ready         ( SysLane2PeArray[2][23].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane23_strm0_cntl          ( SysLane2PeArray[2][23].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane23_strm0_data          ( SysLane2PeArray[2][23].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane23_strm0_data_valid    ( SysLane2PeArray[2][23].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane23_strm1_ready         ( SysLane2PeArray[2][23].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane23_strm1_cntl          ( SysLane2PeArray[2][23].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane23_strm1_data          ( SysLane2PeArray[2][23].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane23_strm1_data_valid    ( SysLane2PeArray[2][23].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 24                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane24_strm0_ready         ( SysLane2PeArray[2][24].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane24_strm0_cntl          ( SysLane2PeArray[2][24].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane24_strm0_data          ( SysLane2PeArray[2][24].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane24_strm0_data_valid    ( SysLane2PeArray[2][24].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane24_strm1_ready         ( SysLane2PeArray[2][24].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane24_strm1_cntl          ( SysLane2PeArray[2][24].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane24_strm1_data          ( SysLane2PeArray[2][24].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane24_strm1_data_valid    ( SysLane2PeArray[2][24].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 25                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane25_strm0_ready         ( SysLane2PeArray[2][25].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane25_strm0_cntl          ( SysLane2PeArray[2][25].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane25_strm0_data          ( SysLane2PeArray[2][25].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane25_strm0_data_valid    ( SysLane2PeArray[2][25].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane25_strm1_ready         ( SysLane2PeArray[2][25].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane25_strm1_cntl          ( SysLane2PeArray[2][25].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane25_strm1_data          ( SysLane2PeArray[2][25].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane25_strm1_data_valid    ( SysLane2PeArray[2][25].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 26                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane26_strm0_ready         ( SysLane2PeArray[2][26].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane26_strm0_cntl          ( SysLane2PeArray[2][26].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane26_strm0_data          ( SysLane2PeArray[2][26].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane26_strm0_data_valid    ( SysLane2PeArray[2][26].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane26_strm1_ready         ( SysLane2PeArray[2][26].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane26_strm1_cntl          ( SysLane2PeArray[2][26].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane26_strm1_data          ( SysLane2PeArray[2][26].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane26_strm1_data_valid    ( SysLane2PeArray[2][26].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 27                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane27_strm0_ready         ( SysLane2PeArray[2][27].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane27_strm0_cntl          ( SysLane2PeArray[2][27].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane27_strm0_data          ( SysLane2PeArray[2][27].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane27_strm0_data_valid    ( SysLane2PeArray[2][27].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane27_strm1_ready         ( SysLane2PeArray[2][27].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane27_strm1_cntl          ( SysLane2PeArray[2][27].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane27_strm1_data          ( SysLane2PeArray[2][27].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane27_strm1_data_valid    ( SysLane2PeArray[2][27].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 28                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane28_strm0_ready         ( SysLane2PeArray[2][28].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane28_strm0_cntl          ( SysLane2PeArray[2][28].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane28_strm0_data          ( SysLane2PeArray[2][28].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane28_strm0_data_valid    ( SysLane2PeArray[2][28].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane28_strm1_ready         ( SysLane2PeArray[2][28].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane28_strm1_cntl          ( SysLane2PeArray[2][28].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane28_strm1_data          ( SysLane2PeArray[2][28].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane28_strm1_data_valid    ( SysLane2PeArray[2][28].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 29                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane29_strm0_ready         ( SysLane2PeArray[2][29].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane29_strm0_cntl          ( SysLane2PeArray[2][29].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane29_strm0_data          ( SysLane2PeArray[2][29].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane29_strm0_data_valid    ( SysLane2PeArray[2][29].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane29_strm1_ready         ( SysLane2PeArray[2][29].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane29_strm1_cntl          ( SysLane2PeArray[2][29].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane29_strm1_data          ( SysLane2PeArray[2][29].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane29_strm1_data_valid    ( SysLane2PeArray[2][29].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 30                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane30_strm0_ready         ( SysLane2PeArray[2][30].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane30_strm0_cntl          ( SysLane2PeArray[2][30].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane30_strm0_data          ( SysLane2PeArray[2][30].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane30_strm0_data_valid    ( SysLane2PeArray[2][30].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane30_strm1_ready         ( SysLane2PeArray[2][30].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane30_strm1_cntl          ( SysLane2PeArray[2][30].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane30_strm1_data          ( SysLane2PeArray[2][30].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane30_strm1_data_valid    ( SysLane2PeArray[2][30].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 2, Lane 31                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane31_strm0_ready         ( SysLane2PeArray[2][31].pe__std__lane_strm0_ready              ),      
        .std__pe2__lane31_strm0_cntl          ( SysLane2PeArray[2][31].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe2__lane31_strm0_data          ( SysLane2PeArray[2][31].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe2__lane31_strm0_data_valid    ( SysLane2PeArray[2][31].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__std__lane31_strm1_ready         ( SysLane2PeArray[2][31].pe__std__lane_strm1_ready              ),      
        .std__pe2__lane31_strm1_cntl          ( SysLane2PeArray[2][31].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe2__lane31_strm1_data          ( SysLane2PeArray[2][31].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe2__lane31_strm1_data_valid    ( SysLane2PeArray[2][31].cb_test.std__pe__lane_strm1_data_valid ),      
        
  // General control and status                                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .sys__pe3__allSynchronized    ( SysOob2PeArray[3].cb_test.sys__pe__allSynchronized   ), 
        .pe3__sys__thisSynchronized   ( SysOob2PeArray[3].pe__sys__thisSynchronized          ), 
        .pe3__sys__ready              ( SysOob2PeArray[3].pe__sys__ready                     ), 
        .pe3__sys__complete           ( SysOob2PeArray[3].pe__sys__complete                  ), 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .std__pe3__oob_cntl           ( SysOob2PeArray[3].cb_test.std__pe__oob_cntl          ), 
        .std__pe3__oob_valid          ( SysOob2PeArray[3].cb_test.std__pe__oob_valid         ), 
        .pe3__std__oob_ready          ( SysOob2PeArray[3].pe__std__oob_ready                 ), 
        .std__pe3__oob_type           ( SysOob2PeArray[3].cb_test.std__pe__oob_type          ), 
        .std__pe3__oob_data           ( SysOob2PeArray[3].cb_test.std__pe__oob_data          ), 
        // PE 3, Lane 0                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane0_strm0_ready         ( SysLane2PeArray[3][0].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane0_strm0_cntl          ( SysLane2PeArray[3][0].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane0_strm0_data          ( SysLane2PeArray[3][0].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane0_strm0_data_valid    ( SysLane2PeArray[3][0].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane0_strm1_ready         ( SysLane2PeArray[3][0].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane0_strm1_cntl          ( SysLane2PeArray[3][0].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane0_strm1_data          ( SysLane2PeArray[3][0].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane0_strm1_data_valid    ( SysLane2PeArray[3][0].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 1                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane1_strm0_ready         ( SysLane2PeArray[3][1].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane1_strm0_cntl          ( SysLane2PeArray[3][1].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane1_strm0_data          ( SysLane2PeArray[3][1].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane1_strm0_data_valid    ( SysLane2PeArray[3][1].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane1_strm1_ready         ( SysLane2PeArray[3][1].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane1_strm1_cntl          ( SysLane2PeArray[3][1].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane1_strm1_data          ( SysLane2PeArray[3][1].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane1_strm1_data_valid    ( SysLane2PeArray[3][1].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 2                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane2_strm0_ready         ( SysLane2PeArray[3][2].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane2_strm0_cntl          ( SysLane2PeArray[3][2].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane2_strm0_data          ( SysLane2PeArray[3][2].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane2_strm0_data_valid    ( SysLane2PeArray[3][2].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane2_strm1_ready         ( SysLane2PeArray[3][2].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane2_strm1_cntl          ( SysLane2PeArray[3][2].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane2_strm1_data          ( SysLane2PeArray[3][2].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane2_strm1_data_valid    ( SysLane2PeArray[3][2].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 3                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane3_strm0_ready         ( SysLane2PeArray[3][3].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane3_strm0_cntl          ( SysLane2PeArray[3][3].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane3_strm0_data          ( SysLane2PeArray[3][3].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane3_strm0_data_valid    ( SysLane2PeArray[3][3].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane3_strm1_ready         ( SysLane2PeArray[3][3].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane3_strm1_cntl          ( SysLane2PeArray[3][3].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane3_strm1_data          ( SysLane2PeArray[3][3].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane3_strm1_data_valid    ( SysLane2PeArray[3][3].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 4                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane4_strm0_ready         ( SysLane2PeArray[3][4].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane4_strm0_cntl          ( SysLane2PeArray[3][4].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane4_strm0_data          ( SysLane2PeArray[3][4].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane4_strm0_data_valid    ( SysLane2PeArray[3][4].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane4_strm1_ready         ( SysLane2PeArray[3][4].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane4_strm1_cntl          ( SysLane2PeArray[3][4].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane4_strm1_data          ( SysLane2PeArray[3][4].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane4_strm1_data_valid    ( SysLane2PeArray[3][4].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 5                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane5_strm0_ready         ( SysLane2PeArray[3][5].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane5_strm0_cntl          ( SysLane2PeArray[3][5].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane5_strm0_data          ( SysLane2PeArray[3][5].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane5_strm0_data_valid    ( SysLane2PeArray[3][5].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane5_strm1_ready         ( SysLane2PeArray[3][5].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane5_strm1_cntl          ( SysLane2PeArray[3][5].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane5_strm1_data          ( SysLane2PeArray[3][5].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane5_strm1_data_valid    ( SysLane2PeArray[3][5].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 6                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane6_strm0_ready         ( SysLane2PeArray[3][6].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane6_strm0_cntl          ( SysLane2PeArray[3][6].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane6_strm0_data          ( SysLane2PeArray[3][6].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane6_strm0_data_valid    ( SysLane2PeArray[3][6].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane6_strm1_ready         ( SysLane2PeArray[3][6].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane6_strm1_cntl          ( SysLane2PeArray[3][6].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane6_strm1_data          ( SysLane2PeArray[3][6].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane6_strm1_data_valid    ( SysLane2PeArray[3][6].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 7                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane7_strm0_ready         ( SysLane2PeArray[3][7].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane7_strm0_cntl          ( SysLane2PeArray[3][7].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane7_strm0_data          ( SysLane2PeArray[3][7].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane7_strm0_data_valid    ( SysLane2PeArray[3][7].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane7_strm1_ready         ( SysLane2PeArray[3][7].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane7_strm1_cntl          ( SysLane2PeArray[3][7].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane7_strm1_data          ( SysLane2PeArray[3][7].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane7_strm1_data_valid    ( SysLane2PeArray[3][7].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 8                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane8_strm0_ready         ( SysLane2PeArray[3][8].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane8_strm0_cntl          ( SysLane2PeArray[3][8].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane8_strm0_data          ( SysLane2PeArray[3][8].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane8_strm0_data_valid    ( SysLane2PeArray[3][8].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane8_strm1_ready         ( SysLane2PeArray[3][8].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane8_strm1_cntl          ( SysLane2PeArray[3][8].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane8_strm1_data          ( SysLane2PeArray[3][8].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane8_strm1_data_valid    ( SysLane2PeArray[3][8].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 9                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane9_strm0_ready         ( SysLane2PeArray[3][9].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane9_strm0_cntl          ( SysLane2PeArray[3][9].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane9_strm0_data          ( SysLane2PeArray[3][9].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane9_strm0_data_valid    ( SysLane2PeArray[3][9].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane9_strm1_ready         ( SysLane2PeArray[3][9].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane9_strm1_cntl          ( SysLane2PeArray[3][9].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane9_strm1_data          ( SysLane2PeArray[3][9].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane9_strm1_data_valid    ( SysLane2PeArray[3][9].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 10                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane10_strm0_ready         ( SysLane2PeArray[3][10].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane10_strm0_cntl          ( SysLane2PeArray[3][10].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane10_strm0_data          ( SysLane2PeArray[3][10].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane10_strm0_data_valid    ( SysLane2PeArray[3][10].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane10_strm1_ready         ( SysLane2PeArray[3][10].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane10_strm1_cntl          ( SysLane2PeArray[3][10].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane10_strm1_data          ( SysLane2PeArray[3][10].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane10_strm1_data_valid    ( SysLane2PeArray[3][10].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 11                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane11_strm0_ready         ( SysLane2PeArray[3][11].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane11_strm0_cntl          ( SysLane2PeArray[3][11].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane11_strm0_data          ( SysLane2PeArray[3][11].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane11_strm0_data_valid    ( SysLane2PeArray[3][11].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane11_strm1_ready         ( SysLane2PeArray[3][11].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane11_strm1_cntl          ( SysLane2PeArray[3][11].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane11_strm1_data          ( SysLane2PeArray[3][11].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane11_strm1_data_valid    ( SysLane2PeArray[3][11].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 12                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane12_strm0_ready         ( SysLane2PeArray[3][12].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane12_strm0_cntl          ( SysLane2PeArray[3][12].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane12_strm0_data          ( SysLane2PeArray[3][12].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane12_strm0_data_valid    ( SysLane2PeArray[3][12].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane12_strm1_ready         ( SysLane2PeArray[3][12].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane12_strm1_cntl          ( SysLane2PeArray[3][12].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane12_strm1_data          ( SysLane2PeArray[3][12].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane12_strm1_data_valid    ( SysLane2PeArray[3][12].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 13                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane13_strm0_ready         ( SysLane2PeArray[3][13].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane13_strm0_cntl          ( SysLane2PeArray[3][13].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane13_strm0_data          ( SysLane2PeArray[3][13].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane13_strm0_data_valid    ( SysLane2PeArray[3][13].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane13_strm1_ready         ( SysLane2PeArray[3][13].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane13_strm1_cntl          ( SysLane2PeArray[3][13].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane13_strm1_data          ( SysLane2PeArray[3][13].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane13_strm1_data_valid    ( SysLane2PeArray[3][13].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 14                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane14_strm0_ready         ( SysLane2PeArray[3][14].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane14_strm0_cntl          ( SysLane2PeArray[3][14].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane14_strm0_data          ( SysLane2PeArray[3][14].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane14_strm0_data_valid    ( SysLane2PeArray[3][14].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane14_strm1_ready         ( SysLane2PeArray[3][14].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane14_strm1_cntl          ( SysLane2PeArray[3][14].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane14_strm1_data          ( SysLane2PeArray[3][14].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane14_strm1_data_valid    ( SysLane2PeArray[3][14].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 15                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane15_strm0_ready         ( SysLane2PeArray[3][15].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane15_strm0_cntl          ( SysLane2PeArray[3][15].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane15_strm0_data          ( SysLane2PeArray[3][15].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane15_strm0_data_valid    ( SysLane2PeArray[3][15].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane15_strm1_ready         ( SysLane2PeArray[3][15].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane15_strm1_cntl          ( SysLane2PeArray[3][15].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane15_strm1_data          ( SysLane2PeArray[3][15].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane15_strm1_data_valid    ( SysLane2PeArray[3][15].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 16                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane16_strm0_ready         ( SysLane2PeArray[3][16].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane16_strm0_cntl          ( SysLane2PeArray[3][16].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane16_strm0_data          ( SysLane2PeArray[3][16].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane16_strm0_data_valid    ( SysLane2PeArray[3][16].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane16_strm1_ready         ( SysLane2PeArray[3][16].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane16_strm1_cntl          ( SysLane2PeArray[3][16].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane16_strm1_data          ( SysLane2PeArray[3][16].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane16_strm1_data_valid    ( SysLane2PeArray[3][16].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 17                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane17_strm0_ready         ( SysLane2PeArray[3][17].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane17_strm0_cntl          ( SysLane2PeArray[3][17].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane17_strm0_data          ( SysLane2PeArray[3][17].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane17_strm0_data_valid    ( SysLane2PeArray[3][17].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane17_strm1_ready         ( SysLane2PeArray[3][17].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane17_strm1_cntl          ( SysLane2PeArray[3][17].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane17_strm1_data          ( SysLane2PeArray[3][17].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane17_strm1_data_valid    ( SysLane2PeArray[3][17].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 18                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane18_strm0_ready         ( SysLane2PeArray[3][18].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane18_strm0_cntl          ( SysLane2PeArray[3][18].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane18_strm0_data          ( SysLane2PeArray[3][18].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane18_strm0_data_valid    ( SysLane2PeArray[3][18].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane18_strm1_ready         ( SysLane2PeArray[3][18].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane18_strm1_cntl          ( SysLane2PeArray[3][18].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane18_strm1_data          ( SysLane2PeArray[3][18].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane18_strm1_data_valid    ( SysLane2PeArray[3][18].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 19                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane19_strm0_ready         ( SysLane2PeArray[3][19].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane19_strm0_cntl          ( SysLane2PeArray[3][19].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane19_strm0_data          ( SysLane2PeArray[3][19].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane19_strm0_data_valid    ( SysLane2PeArray[3][19].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane19_strm1_ready         ( SysLane2PeArray[3][19].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane19_strm1_cntl          ( SysLane2PeArray[3][19].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane19_strm1_data          ( SysLane2PeArray[3][19].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane19_strm1_data_valid    ( SysLane2PeArray[3][19].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 20                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane20_strm0_ready         ( SysLane2PeArray[3][20].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane20_strm0_cntl          ( SysLane2PeArray[3][20].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane20_strm0_data          ( SysLane2PeArray[3][20].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane20_strm0_data_valid    ( SysLane2PeArray[3][20].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane20_strm1_ready         ( SysLane2PeArray[3][20].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane20_strm1_cntl          ( SysLane2PeArray[3][20].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane20_strm1_data          ( SysLane2PeArray[3][20].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane20_strm1_data_valid    ( SysLane2PeArray[3][20].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 21                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane21_strm0_ready         ( SysLane2PeArray[3][21].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane21_strm0_cntl          ( SysLane2PeArray[3][21].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane21_strm0_data          ( SysLane2PeArray[3][21].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane21_strm0_data_valid    ( SysLane2PeArray[3][21].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane21_strm1_ready         ( SysLane2PeArray[3][21].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane21_strm1_cntl          ( SysLane2PeArray[3][21].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane21_strm1_data          ( SysLane2PeArray[3][21].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane21_strm1_data_valid    ( SysLane2PeArray[3][21].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 22                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane22_strm0_ready         ( SysLane2PeArray[3][22].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane22_strm0_cntl          ( SysLane2PeArray[3][22].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane22_strm0_data          ( SysLane2PeArray[3][22].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane22_strm0_data_valid    ( SysLane2PeArray[3][22].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane22_strm1_ready         ( SysLane2PeArray[3][22].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane22_strm1_cntl          ( SysLane2PeArray[3][22].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane22_strm1_data          ( SysLane2PeArray[3][22].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane22_strm1_data_valid    ( SysLane2PeArray[3][22].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 23                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane23_strm0_ready         ( SysLane2PeArray[3][23].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane23_strm0_cntl          ( SysLane2PeArray[3][23].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane23_strm0_data          ( SysLane2PeArray[3][23].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane23_strm0_data_valid    ( SysLane2PeArray[3][23].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane23_strm1_ready         ( SysLane2PeArray[3][23].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane23_strm1_cntl          ( SysLane2PeArray[3][23].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane23_strm1_data          ( SysLane2PeArray[3][23].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane23_strm1_data_valid    ( SysLane2PeArray[3][23].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 24                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane24_strm0_ready         ( SysLane2PeArray[3][24].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane24_strm0_cntl          ( SysLane2PeArray[3][24].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane24_strm0_data          ( SysLane2PeArray[3][24].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane24_strm0_data_valid    ( SysLane2PeArray[3][24].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane24_strm1_ready         ( SysLane2PeArray[3][24].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane24_strm1_cntl          ( SysLane2PeArray[3][24].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane24_strm1_data          ( SysLane2PeArray[3][24].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane24_strm1_data_valid    ( SysLane2PeArray[3][24].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 25                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane25_strm0_ready         ( SysLane2PeArray[3][25].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane25_strm0_cntl          ( SysLane2PeArray[3][25].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane25_strm0_data          ( SysLane2PeArray[3][25].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane25_strm0_data_valid    ( SysLane2PeArray[3][25].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane25_strm1_ready         ( SysLane2PeArray[3][25].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane25_strm1_cntl          ( SysLane2PeArray[3][25].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane25_strm1_data          ( SysLane2PeArray[3][25].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane25_strm1_data_valid    ( SysLane2PeArray[3][25].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 26                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane26_strm0_ready         ( SysLane2PeArray[3][26].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane26_strm0_cntl          ( SysLane2PeArray[3][26].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane26_strm0_data          ( SysLane2PeArray[3][26].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane26_strm0_data_valid    ( SysLane2PeArray[3][26].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane26_strm1_ready         ( SysLane2PeArray[3][26].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane26_strm1_cntl          ( SysLane2PeArray[3][26].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane26_strm1_data          ( SysLane2PeArray[3][26].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane26_strm1_data_valid    ( SysLane2PeArray[3][26].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 27                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane27_strm0_ready         ( SysLane2PeArray[3][27].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane27_strm0_cntl          ( SysLane2PeArray[3][27].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane27_strm0_data          ( SysLane2PeArray[3][27].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane27_strm0_data_valid    ( SysLane2PeArray[3][27].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane27_strm1_ready         ( SysLane2PeArray[3][27].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane27_strm1_cntl          ( SysLane2PeArray[3][27].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane27_strm1_data          ( SysLane2PeArray[3][27].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane27_strm1_data_valid    ( SysLane2PeArray[3][27].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 28                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane28_strm0_ready         ( SysLane2PeArray[3][28].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane28_strm0_cntl          ( SysLane2PeArray[3][28].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane28_strm0_data          ( SysLane2PeArray[3][28].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane28_strm0_data_valid    ( SysLane2PeArray[3][28].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane28_strm1_ready         ( SysLane2PeArray[3][28].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane28_strm1_cntl          ( SysLane2PeArray[3][28].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane28_strm1_data          ( SysLane2PeArray[3][28].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane28_strm1_data_valid    ( SysLane2PeArray[3][28].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 29                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane29_strm0_ready         ( SysLane2PeArray[3][29].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane29_strm0_cntl          ( SysLane2PeArray[3][29].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane29_strm0_data          ( SysLane2PeArray[3][29].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane29_strm0_data_valid    ( SysLane2PeArray[3][29].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane29_strm1_ready         ( SysLane2PeArray[3][29].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane29_strm1_cntl          ( SysLane2PeArray[3][29].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane29_strm1_data          ( SysLane2PeArray[3][29].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane29_strm1_data_valid    ( SysLane2PeArray[3][29].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 30                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane30_strm0_ready         ( SysLane2PeArray[3][30].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane30_strm0_cntl          ( SysLane2PeArray[3][30].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane30_strm0_data          ( SysLane2PeArray[3][30].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane30_strm0_data_valid    ( SysLane2PeArray[3][30].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane30_strm1_ready         ( SysLane2PeArray[3][30].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane30_strm1_cntl          ( SysLane2PeArray[3][30].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane30_strm1_data          ( SysLane2PeArray[3][30].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane30_strm1_data_valid    ( SysLane2PeArray[3][30].cb_test.std__pe__lane_strm1_data_valid ),      
        
        // PE 3, Lane 31                 
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane31_strm0_ready         ( SysLane2PeArray[3][31].pe__std__lane_strm0_ready              ),      
        .std__pe3__lane31_strm0_cntl          ( SysLane2PeArray[3][31].cb_test.std__pe__lane_strm0_cntl       ),      
        .std__pe3__lane31_strm0_data          ( SysLane2PeArray[3][31].cb_test.std__pe__lane_strm0_data       ),      
        .std__pe3__lane31_strm0_data_valid    ( SysLane2PeArray[3][31].cb_test.std__pe__lane_strm0_data_valid ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__std__lane31_strm1_ready         ( SysLane2PeArray[3][31].pe__std__lane_strm1_ready              ),      
        .std__pe3__lane31_strm1_cntl          ( SysLane2PeArray[3][31].cb_test.std__pe__lane_strm1_cntl       ),      
        .std__pe3__lane31_strm1_data          ( SysLane2PeArray[3][31].cb_test.std__pe__lane_strm1_data       ),      
        .std__pe3__lane31_strm1_data_valid    ( SysLane2PeArray[3][31].cb_test.std__pe__lane_strm1_data_valid ),      
        