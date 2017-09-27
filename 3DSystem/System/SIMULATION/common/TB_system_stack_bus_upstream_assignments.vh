
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign UpstreamStackBus[0].pe__stu__valid                                =   system_inst.manager_array_inst.mgr_inst[0].stu__mgr__valid    ;      
        assign UpstreamStackBus[0].pe__stu__cntl                                 =   system_inst.manager_array_inst.mgr_inst[0].stu__mgr__cntl     ;      
        // manager module stu_cntl now driving ready, so just capture state of ready                                                                                                          
        //assign system_inst.manager_array_inst.mgr_inst[0].mgr__stu__ready        =   1'b1                                                           ;      
        assign UpstreamStackBus[0].stu__pe__ready                                =   system_inst.manager_array_inst.mgr_inst[0].mgr__stu__ready    ;      
        assign UpstreamStackBus[0].pe__stu__type                                 =   system_inst.manager_array_inst.mgr_inst[0].stu__mgr__type     ;      
        assign UpstreamStackBus[0].pe__stu__data                                 =   system_inst.manager_array_inst.mgr_inst[0].stu__mgr__data     ;      
        assign UpstreamStackBus[0].pe__stu__oob_data                             =   system_inst.manager_array_inst.mgr_inst[0].stu__mgr__oob_data ;      
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign UpstreamStackBus[1].pe__stu__valid                                =   system_inst.manager_array_inst.mgr_inst[1].stu__mgr__valid    ;      
        assign UpstreamStackBus[1].pe__stu__cntl                                 =   system_inst.manager_array_inst.mgr_inst[1].stu__mgr__cntl     ;      
        // manager module stu_cntl now driving ready, so just capture state of ready                                                                                                          
        //assign system_inst.manager_array_inst.mgr_inst[1].mgr__stu__ready        =   1'b1                                                           ;      
        assign UpstreamStackBus[1].stu__pe__ready                                =   system_inst.manager_array_inst.mgr_inst[1].mgr__stu__ready    ;      
        assign UpstreamStackBus[1].pe__stu__type                                 =   system_inst.manager_array_inst.mgr_inst[1].stu__mgr__type     ;      
        assign UpstreamStackBus[1].pe__stu__data                                 =   system_inst.manager_array_inst.mgr_inst[1].stu__mgr__data     ;      
        assign UpstreamStackBus[1].pe__stu__oob_data                             =   system_inst.manager_array_inst.mgr_inst[1].stu__mgr__oob_data ;      
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign UpstreamStackBus[2].pe__stu__valid                                =   system_inst.manager_array_inst.mgr_inst[2].stu__mgr__valid    ;      
        assign UpstreamStackBus[2].pe__stu__cntl                                 =   system_inst.manager_array_inst.mgr_inst[2].stu__mgr__cntl     ;      
        // manager module stu_cntl now driving ready, so just capture state of ready                                                                                                          
        //assign system_inst.manager_array_inst.mgr_inst[2].mgr__stu__ready        =   1'b1                                                           ;      
        assign UpstreamStackBus[2].stu__pe__ready                                =   system_inst.manager_array_inst.mgr_inst[2].mgr__stu__ready    ;      
        assign UpstreamStackBus[2].pe__stu__type                                 =   system_inst.manager_array_inst.mgr_inst[2].stu__mgr__type     ;      
        assign UpstreamStackBus[2].pe__stu__data                                 =   system_inst.manager_array_inst.mgr_inst[2].stu__mgr__data     ;      
        assign UpstreamStackBus[2].pe__stu__oob_data                             =   system_inst.manager_array_inst.mgr_inst[2].stu__mgr__oob_data ;      
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign UpstreamStackBus[3].pe__stu__valid                                =   system_inst.manager_array_inst.mgr_inst[3].stu__mgr__valid    ;      
        assign UpstreamStackBus[3].pe__stu__cntl                                 =   system_inst.manager_array_inst.mgr_inst[3].stu__mgr__cntl     ;      
        // manager module stu_cntl now driving ready, so just capture state of ready                                                                                                          
        //assign system_inst.manager_array_inst.mgr_inst[3].mgr__stu__ready        =   1'b1                                                           ;      
        assign UpstreamStackBus[3].stu__pe__ready                                =   system_inst.manager_array_inst.mgr_inst[3].mgr__stu__ready    ;      
        assign UpstreamStackBus[3].pe__stu__type                                 =   system_inst.manager_array_inst.mgr_inst[3].stu__mgr__type     ;      
        assign UpstreamStackBus[3].pe__stu__data                                 =   system_inst.manager_array_inst.mgr_inst[3].stu__mgr__data     ;      
        assign UpstreamStackBus[3].pe__stu__oob_data                             =   system_inst.manager_array_inst.mgr_inst[3].stu__mgr__oob_data ;      
        