
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .std__pe0__oob_cntl           ( DownstreamStackBusOOB[0].cb_test.std__pe__oob_cntl          ), 
        .std__pe0__oob_valid          ( DownstreamStackBusOOB[0].cb_test.std__pe__oob_valid         ), 
        .pe0__std__oob_ready          ( DownstreamStackBusOOB[0].pe__std__oob_ready                 ), 
        .std__pe0__oob_type           ( DownstreamStackBusOOB[0].cb_test.std__pe__oob_type          ), 
        .std__pe0__oob_data           ( DownstreamStackBusOOB[0].cb_test.std__pe__oob_data          ), 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .std__pe1__oob_cntl           ( DownstreamStackBusOOB[1].cb_test.std__pe__oob_cntl          ), 
        .std__pe1__oob_valid          ( DownstreamStackBusOOB[1].cb_test.std__pe__oob_valid         ), 
        .pe1__std__oob_ready          ( DownstreamStackBusOOB[1].pe__std__oob_ready                 ), 
        .std__pe1__oob_type           ( DownstreamStackBusOOB[1].cb_test.std__pe__oob_type          ), 
        .std__pe1__oob_data           ( DownstreamStackBusOOB[1].cb_test.std__pe__oob_data          ), 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .std__pe2__oob_cntl           ( DownstreamStackBusOOB[2].cb_test.std__pe__oob_cntl          ), 
        .std__pe2__oob_valid          ( DownstreamStackBusOOB[2].cb_test.std__pe__oob_valid         ), 
        .pe2__std__oob_ready          ( DownstreamStackBusOOB[2].pe__std__oob_ready                 ), 
        .std__pe2__oob_type           ( DownstreamStackBusOOB[2].cb_test.std__pe__oob_type          ), 
        .std__pe2__oob_data           ( DownstreamStackBusOOB[2].cb_test.std__pe__oob_data          ), 
  // OOB controls how the lanes are interpreted                                                     
  //  - doesnt seem to work if you use cb_test for observed signals                                 
  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         
        .std__pe3__oob_cntl           ( DownstreamStackBusOOB[3].cb_test.std__pe__oob_cntl          ), 
        .std__pe3__oob_valid          ( DownstreamStackBusOOB[3].cb_test.std__pe__oob_valid         ), 
        .pe3__std__oob_ready          ( DownstreamStackBusOOB[3].pe__std__oob_ready                 ), 
        .std__pe3__oob_type           ( DownstreamStackBusOOB[3].cb_test.std__pe__oob_type          ), 
        .std__pe3__oob_data           ( DownstreamStackBusOOB[3].cb_test.std__pe__oob_data          ), 