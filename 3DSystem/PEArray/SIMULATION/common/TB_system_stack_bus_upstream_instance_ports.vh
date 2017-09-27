
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe0__stu__valid        ( UpstreamStackBus[0].pe__stu__valid             ),      
        .pe0__stu__cntl         ( UpstreamStackBus[0].pe__stu__cntl              ),      
        .stu__pe0__ready        ( 1'b1                                            ),      
        //.stu__pe0__ready        ( UpstreamStackBus[0].stu__pe__ready     ),      
        .pe0__stu__type         ( UpstreamStackBus[0].pe__stu__type              ),      
        .pe0__stu__data         ( UpstreamStackBus[0].pe__stu__data              ),      
        .pe0__stu__oob_data     ( UpstreamStackBus[0].pe__stu__oob_data          ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe1__stu__valid        ( UpstreamStackBus[1].pe__stu__valid             ),      
        .pe1__stu__cntl         ( UpstreamStackBus[1].pe__stu__cntl              ),      
        .stu__pe1__ready        ( 1'b1                                            ),      
        //.stu__pe1__ready        ( UpstreamStackBus[1].stu__pe__ready     ),      
        .pe1__stu__type         ( UpstreamStackBus[1].pe__stu__type              ),      
        .pe1__stu__data         ( UpstreamStackBus[1].pe__stu__data              ),      
        .pe1__stu__oob_data     ( UpstreamStackBus[1].pe__stu__oob_data          ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe2__stu__valid        ( UpstreamStackBus[2].pe__stu__valid             ),      
        .pe2__stu__cntl         ( UpstreamStackBus[2].pe__stu__cntl              ),      
        .stu__pe2__ready        ( 1'b1                                            ),      
        //.stu__pe2__ready        ( UpstreamStackBus[2].stu__pe__ready     ),      
        .pe2__stu__type         ( UpstreamStackBus[2].pe__stu__type              ),      
        .pe2__stu__data         ( UpstreamStackBus[2].pe__stu__data              ),      
        .pe2__stu__oob_data     ( UpstreamStackBus[2].pe__stu__oob_data          ),      
        
        //  - doesnt seem to work if you use cb_test for observed signals                                                       
        .pe3__stu__valid        ( UpstreamStackBus[3].pe__stu__valid             ),      
        .pe3__stu__cntl         ( UpstreamStackBus[3].pe__stu__cntl              ),      
        .stu__pe3__ready        ( 1'b1                                            ),      
        //.stu__pe3__ready        ( UpstreamStackBus[3].stu__pe__ready     ),      
        .pe3__stu__type         ( UpstreamStackBus[3].pe__stu__type              ),      
        .pe3__stu__data         ( UpstreamStackBus[3].pe__stu__data              ),      
        .pe3__stu__oob_data     ( UpstreamStackBus[3].pe__stu__oob_data          ),      
        