
        // PE 0, Lane 0                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][0][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [0]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [0]  =   DownstreamStackBusLane[0][0][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [0]  =   DownstreamStackBusLane[0][0][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[0]  =   DownstreamStackBusLane[0][0][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][0][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [0]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [0]  =   DownstreamStackBusLane[0][0][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [0]  =   DownstreamStackBusLane[0][0][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[0]  =   DownstreamStackBusLane[0][0][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 1                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][1][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [1]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [1]  =   DownstreamStackBusLane[0][1][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [1]  =   DownstreamStackBusLane[0][1][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[1]  =   DownstreamStackBusLane[0][1][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][1][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [1]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [1]  =   DownstreamStackBusLane[0][1][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [1]  =   DownstreamStackBusLane[0][1][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[1]  =   DownstreamStackBusLane[0][1][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 2                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][2][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [2]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [2]  =   DownstreamStackBusLane[0][2][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [2]  =   DownstreamStackBusLane[0][2][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[2]  =   DownstreamStackBusLane[0][2][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][2][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [2]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [2]  =   DownstreamStackBusLane[0][2][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [2]  =   DownstreamStackBusLane[0][2][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[2]  =   DownstreamStackBusLane[0][2][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 3                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][3][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [3]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [3]  =   DownstreamStackBusLane[0][3][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [3]  =   DownstreamStackBusLane[0][3][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[3]  =   DownstreamStackBusLane[0][3][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][3][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [3]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [3]  =   DownstreamStackBusLane[0][3][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [3]  =   DownstreamStackBusLane[0][3][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[3]  =   DownstreamStackBusLane[0][3][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 4                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][4][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [4]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [4]  =   DownstreamStackBusLane[0][4][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [4]  =   DownstreamStackBusLane[0][4][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[4]  =   DownstreamStackBusLane[0][4][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][4][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [4]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [4]  =   DownstreamStackBusLane[0][4][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [4]  =   DownstreamStackBusLane[0][4][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[4]  =   DownstreamStackBusLane[0][4][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 5                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][5][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [5]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [5]  =   DownstreamStackBusLane[0][5][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [5]  =   DownstreamStackBusLane[0][5][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[5]  =   DownstreamStackBusLane[0][5][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][5][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [5]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [5]  =   DownstreamStackBusLane[0][5][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [5]  =   DownstreamStackBusLane[0][5][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[5]  =   DownstreamStackBusLane[0][5][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 6                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][6][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [6]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [6]  =   DownstreamStackBusLane[0][6][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [6]  =   DownstreamStackBusLane[0][6][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[6]  =   DownstreamStackBusLane[0][6][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][6][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [6]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [6]  =   DownstreamStackBusLane[0][6][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [6]  =   DownstreamStackBusLane[0][6][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[6]  =   DownstreamStackBusLane[0][6][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 7                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][7][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [7]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [7]  =   DownstreamStackBusLane[0][7][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [7]  =   DownstreamStackBusLane[0][7][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[7]  =   DownstreamStackBusLane[0][7][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][7][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [7]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [7]  =   DownstreamStackBusLane[0][7][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [7]  =   DownstreamStackBusLane[0][7][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[7]  =   DownstreamStackBusLane[0][7][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 8                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][8][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [8]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [8]  =   DownstreamStackBusLane[0][8][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [8]  =   DownstreamStackBusLane[0][8][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[8]  =   DownstreamStackBusLane[0][8][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][8][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [8]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [8]  =   DownstreamStackBusLane[0][8][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [8]  =   DownstreamStackBusLane[0][8][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[8]  =   DownstreamStackBusLane[0][8][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 9                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][9][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [9]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [9]  =   DownstreamStackBusLane[0][9][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [9]  =   DownstreamStackBusLane[0][9][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[9]  =   DownstreamStackBusLane[0][9][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][9][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [9]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [9]  =   DownstreamStackBusLane[0][9][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [9]  =   DownstreamStackBusLane[0][9][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[9]  =   DownstreamStackBusLane[0][9][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 10                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][10][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [10]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [10]  =   DownstreamStackBusLane[0][10][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [10]  =   DownstreamStackBusLane[0][10][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[10]  =   DownstreamStackBusLane[0][10][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][10][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [10]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [10]  =   DownstreamStackBusLane[0][10][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [10]  =   DownstreamStackBusLane[0][10][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[10]  =   DownstreamStackBusLane[0][10][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 11                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][11][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [11]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [11]  =   DownstreamStackBusLane[0][11][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [11]  =   DownstreamStackBusLane[0][11][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[11]  =   DownstreamStackBusLane[0][11][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][11][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [11]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [11]  =   DownstreamStackBusLane[0][11][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [11]  =   DownstreamStackBusLane[0][11][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[11]  =   DownstreamStackBusLane[0][11][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 12                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][12][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [12]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [12]  =   DownstreamStackBusLane[0][12][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [12]  =   DownstreamStackBusLane[0][12][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[12]  =   DownstreamStackBusLane[0][12][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][12][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [12]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [12]  =   DownstreamStackBusLane[0][12][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [12]  =   DownstreamStackBusLane[0][12][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[12]  =   DownstreamStackBusLane[0][12][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 13                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][13][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [13]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [13]  =   DownstreamStackBusLane[0][13][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [13]  =   DownstreamStackBusLane[0][13][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[13]  =   DownstreamStackBusLane[0][13][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][13][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [13]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [13]  =   DownstreamStackBusLane[0][13][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [13]  =   DownstreamStackBusLane[0][13][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[13]  =   DownstreamStackBusLane[0][13][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 14                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][14][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [14]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [14]  =   DownstreamStackBusLane[0][14][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [14]  =   DownstreamStackBusLane[0][14][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[14]  =   DownstreamStackBusLane[0][14][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][14][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [14]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [14]  =   DownstreamStackBusLane[0][14][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [14]  =   DownstreamStackBusLane[0][14][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[14]  =   DownstreamStackBusLane[0][14][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 15                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][15][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [15]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [15]  =   DownstreamStackBusLane[0][15][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [15]  =   DownstreamStackBusLane[0][15][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[15]  =   DownstreamStackBusLane[0][15][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][15][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [15]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [15]  =   DownstreamStackBusLane[0][15][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [15]  =   DownstreamStackBusLane[0][15][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[15]  =   DownstreamStackBusLane[0][15][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 16                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][16][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [16]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [16]  =   DownstreamStackBusLane[0][16][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [16]  =   DownstreamStackBusLane[0][16][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[16]  =   DownstreamStackBusLane[0][16][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][16][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [16]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [16]  =   DownstreamStackBusLane[0][16][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [16]  =   DownstreamStackBusLane[0][16][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[16]  =   DownstreamStackBusLane[0][16][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 17                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][17][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [17]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [17]  =   DownstreamStackBusLane[0][17][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [17]  =   DownstreamStackBusLane[0][17][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[17]  =   DownstreamStackBusLane[0][17][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][17][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [17]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [17]  =   DownstreamStackBusLane[0][17][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [17]  =   DownstreamStackBusLane[0][17][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[17]  =   DownstreamStackBusLane[0][17][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 18                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][18][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [18]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [18]  =   DownstreamStackBusLane[0][18][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [18]  =   DownstreamStackBusLane[0][18][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[18]  =   DownstreamStackBusLane[0][18][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][18][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [18]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [18]  =   DownstreamStackBusLane[0][18][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [18]  =   DownstreamStackBusLane[0][18][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[18]  =   DownstreamStackBusLane[0][18][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 19                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][19][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [19]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [19]  =   DownstreamStackBusLane[0][19][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [19]  =   DownstreamStackBusLane[0][19][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[19]  =   DownstreamStackBusLane[0][19][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][19][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [19]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [19]  =   DownstreamStackBusLane[0][19][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [19]  =   DownstreamStackBusLane[0][19][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[19]  =   DownstreamStackBusLane[0][19][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 20                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][20][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [20]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [20]  =   DownstreamStackBusLane[0][20][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [20]  =   DownstreamStackBusLane[0][20][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[20]  =   DownstreamStackBusLane[0][20][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][20][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [20]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [20]  =   DownstreamStackBusLane[0][20][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [20]  =   DownstreamStackBusLane[0][20][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[20]  =   DownstreamStackBusLane[0][20][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 21                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][21][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [21]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [21]  =   DownstreamStackBusLane[0][21][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [21]  =   DownstreamStackBusLane[0][21][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[21]  =   DownstreamStackBusLane[0][21][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][21][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [21]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [21]  =   DownstreamStackBusLane[0][21][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [21]  =   DownstreamStackBusLane[0][21][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[21]  =   DownstreamStackBusLane[0][21][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 22                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][22][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [22]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [22]  =   DownstreamStackBusLane[0][22][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [22]  =   DownstreamStackBusLane[0][22][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[22]  =   DownstreamStackBusLane[0][22][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][22][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [22]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [22]  =   DownstreamStackBusLane[0][22][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [22]  =   DownstreamStackBusLane[0][22][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[22]  =   DownstreamStackBusLane[0][22][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 23                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][23][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [23]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [23]  =   DownstreamStackBusLane[0][23][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [23]  =   DownstreamStackBusLane[0][23][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[23]  =   DownstreamStackBusLane[0][23][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][23][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [23]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [23]  =   DownstreamStackBusLane[0][23][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [23]  =   DownstreamStackBusLane[0][23][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[23]  =   DownstreamStackBusLane[0][23][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 24                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][24][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [24]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [24]  =   DownstreamStackBusLane[0][24][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [24]  =   DownstreamStackBusLane[0][24][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[24]  =   DownstreamStackBusLane[0][24][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][24][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [24]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [24]  =   DownstreamStackBusLane[0][24][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [24]  =   DownstreamStackBusLane[0][24][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[24]  =   DownstreamStackBusLane[0][24][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 25                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][25][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [25]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [25]  =   DownstreamStackBusLane[0][25][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [25]  =   DownstreamStackBusLane[0][25][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[25]  =   DownstreamStackBusLane[0][25][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][25][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [25]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [25]  =   DownstreamStackBusLane[0][25][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [25]  =   DownstreamStackBusLane[0][25][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[25]  =   DownstreamStackBusLane[0][25][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 26                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][26][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [26]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [26]  =   DownstreamStackBusLane[0][26][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [26]  =   DownstreamStackBusLane[0][26][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[26]  =   DownstreamStackBusLane[0][26][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][26][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [26]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [26]  =   DownstreamStackBusLane[0][26][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [26]  =   DownstreamStackBusLane[0][26][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[26]  =   DownstreamStackBusLane[0][26][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 27                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][27][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [27]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [27]  =   DownstreamStackBusLane[0][27][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [27]  =   DownstreamStackBusLane[0][27][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[27]  =   DownstreamStackBusLane[0][27][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][27][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [27]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [27]  =   DownstreamStackBusLane[0][27][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [27]  =   DownstreamStackBusLane[0][27][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[27]  =   DownstreamStackBusLane[0][27][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 28                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][28][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [28]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [28]  =   DownstreamStackBusLane[0][28][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [28]  =   DownstreamStackBusLane[0][28][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[28]  =   DownstreamStackBusLane[0][28][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][28][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [28]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [28]  =   DownstreamStackBusLane[0][28][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [28]  =   DownstreamStackBusLane[0][28][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[28]  =   DownstreamStackBusLane[0][28][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 29                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][29][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [29]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [29]  =   DownstreamStackBusLane[0][29][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [29]  =   DownstreamStackBusLane[0][29][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[29]  =   DownstreamStackBusLane[0][29][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][29][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [29]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [29]  =   DownstreamStackBusLane[0][29][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [29]  =   DownstreamStackBusLane[0][29][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[29]  =   DownstreamStackBusLane[0][29][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 30                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][30][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [30]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [30]  =   DownstreamStackBusLane[0][30][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [30]  =   DownstreamStackBusLane[0][30][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[30]  =   DownstreamStackBusLane[0][30][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][30][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [30]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [30]  =   DownstreamStackBusLane[0][30][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [30]  =   DownstreamStackBusLane[0][30][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[30]  =   DownstreamStackBusLane[0][30][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 0, Lane 31                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][31][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [31]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [31]  =   DownstreamStackBusLane[0][31][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [31]  =   DownstreamStackBusLane[0][31][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[31]  =   DownstreamStackBusLane[0][31][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[0][31][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [31]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [31]  =   DownstreamStackBusLane[0][31][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [31]  =   DownstreamStackBusLane[0][31][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[31]  =   DownstreamStackBusLane[0][31][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 0                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][0][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [0]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [0]  =   DownstreamStackBusLane[1][0][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [0]  =   DownstreamStackBusLane[1][0][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[0]  =   DownstreamStackBusLane[1][0][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][0][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [0]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [0]  =   DownstreamStackBusLane[1][0][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [0]  =   DownstreamStackBusLane[1][0][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[0]  =   DownstreamStackBusLane[1][0][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 1                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][1][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [1]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [1]  =   DownstreamStackBusLane[1][1][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [1]  =   DownstreamStackBusLane[1][1][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[1]  =   DownstreamStackBusLane[1][1][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][1][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [1]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [1]  =   DownstreamStackBusLane[1][1][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [1]  =   DownstreamStackBusLane[1][1][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[1]  =   DownstreamStackBusLane[1][1][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 2                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][2][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [2]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [2]  =   DownstreamStackBusLane[1][2][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [2]  =   DownstreamStackBusLane[1][2][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[2]  =   DownstreamStackBusLane[1][2][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][2][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [2]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [2]  =   DownstreamStackBusLane[1][2][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [2]  =   DownstreamStackBusLane[1][2][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[2]  =   DownstreamStackBusLane[1][2][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 3                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][3][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [3]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [3]  =   DownstreamStackBusLane[1][3][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [3]  =   DownstreamStackBusLane[1][3][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[3]  =   DownstreamStackBusLane[1][3][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][3][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [3]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [3]  =   DownstreamStackBusLane[1][3][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [3]  =   DownstreamStackBusLane[1][3][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[3]  =   DownstreamStackBusLane[1][3][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 4                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][4][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [4]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [4]  =   DownstreamStackBusLane[1][4][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [4]  =   DownstreamStackBusLane[1][4][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[4]  =   DownstreamStackBusLane[1][4][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][4][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [4]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [4]  =   DownstreamStackBusLane[1][4][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [4]  =   DownstreamStackBusLane[1][4][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[4]  =   DownstreamStackBusLane[1][4][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 5                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][5][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [5]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [5]  =   DownstreamStackBusLane[1][5][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [5]  =   DownstreamStackBusLane[1][5][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[5]  =   DownstreamStackBusLane[1][5][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][5][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [5]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [5]  =   DownstreamStackBusLane[1][5][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [5]  =   DownstreamStackBusLane[1][5][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[5]  =   DownstreamStackBusLane[1][5][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 6                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][6][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [6]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [6]  =   DownstreamStackBusLane[1][6][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [6]  =   DownstreamStackBusLane[1][6][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[6]  =   DownstreamStackBusLane[1][6][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][6][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [6]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [6]  =   DownstreamStackBusLane[1][6][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [6]  =   DownstreamStackBusLane[1][6][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[6]  =   DownstreamStackBusLane[1][6][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 7                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][7][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [7]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [7]  =   DownstreamStackBusLane[1][7][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [7]  =   DownstreamStackBusLane[1][7][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[7]  =   DownstreamStackBusLane[1][7][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][7][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [7]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [7]  =   DownstreamStackBusLane[1][7][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [7]  =   DownstreamStackBusLane[1][7][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[7]  =   DownstreamStackBusLane[1][7][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 8                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][8][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [8]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [8]  =   DownstreamStackBusLane[1][8][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [8]  =   DownstreamStackBusLane[1][8][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[8]  =   DownstreamStackBusLane[1][8][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][8][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [8]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [8]  =   DownstreamStackBusLane[1][8][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [8]  =   DownstreamStackBusLane[1][8][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[8]  =   DownstreamStackBusLane[1][8][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 9                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][9][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [9]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [9]  =   DownstreamStackBusLane[1][9][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [9]  =   DownstreamStackBusLane[1][9][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[9]  =   DownstreamStackBusLane[1][9][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][9][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [9]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [9]  =   DownstreamStackBusLane[1][9][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [9]  =   DownstreamStackBusLane[1][9][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[9]  =   DownstreamStackBusLane[1][9][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 10                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][10][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [10]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [10]  =   DownstreamStackBusLane[1][10][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [10]  =   DownstreamStackBusLane[1][10][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[10]  =   DownstreamStackBusLane[1][10][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][10][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [10]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [10]  =   DownstreamStackBusLane[1][10][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [10]  =   DownstreamStackBusLane[1][10][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[10]  =   DownstreamStackBusLane[1][10][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 11                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][11][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [11]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [11]  =   DownstreamStackBusLane[1][11][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [11]  =   DownstreamStackBusLane[1][11][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[11]  =   DownstreamStackBusLane[1][11][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][11][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [11]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [11]  =   DownstreamStackBusLane[1][11][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [11]  =   DownstreamStackBusLane[1][11][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[11]  =   DownstreamStackBusLane[1][11][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 12                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][12][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [12]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [12]  =   DownstreamStackBusLane[1][12][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [12]  =   DownstreamStackBusLane[1][12][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[12]  =   DownstreamStackBusLane[1][12][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][12][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [12]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [12]  =   DownstreamStackBusLane[1][12][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [12]  =   DownstreamStackBusLane[1][12][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[12]  =   DownstreamStackBusLane[1][12][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 13                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][13][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [13]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [13]  =   DownstreamStackBusLane[1][13][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [13]  =   DownstreamStackBusLane[1][13][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[13]  =   DownstreamStackBusLane[1][13][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][13][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [13]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [13]  =   DownstreamStackBusLane[1][13][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [13]  =   DownstreamStackBusLane[1][13][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[13]  =   DownstreamStackBusLane[1][13][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 14                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][14][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [14]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [14]  =   DownstreamStackBusLane[1][14][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [14]  =   DownstreamStackBusLane[1][14][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[14]  =   DownstreamStackBusLane[1][14][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][14][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [14]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [14]  =   DownstreamStackBusLane[1][14][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [14]  =   DownstreamStackBusLane[1][14][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[14]  =   DownstreamStackBusLane[1][14][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 15                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][15][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [15]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [15]  =   DownstreamStackBusLane[1][15][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [15]  =   DownstreamStackBusLane[1][15][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[15]  =   DownstreamStackBusLane[1][15][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][15][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [15]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [15]  =   DownstreamStackBusLane[1][15][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [15]  =   DownstreamStackBusLane[1][15][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[15]  =   DownstreamStackBusLane[1][15][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 16                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][16][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [16]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [16]  =   DownstreamStackBusLane[1][16][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [16]  =   DownstreamStackBusLane[1][16][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[16]  =   DownstreamStackBusLane[1][16][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][16][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [16]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [16]  =   DownstreamStackBusLane[1][16][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [16]  =   DownstreamStackBusLane[1][16][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[16]  =   DownstreamStackBusLane[1][16][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 17                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][17][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [17]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [17]  =   DownstreamStackBusLane[1][17][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [17]  =   DownstreamStackBusLane[1][17][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[17]  =   DownstreamStackBusLane[1][17][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][17][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [17]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [17]  =   DownstreamStackBusLane[1][17][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [17]  =   DownstreamStackBusLane[1][17][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[17]  =   DownstreamStackBusLane[1][17][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 18                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][18][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [18]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [18]  =   DownstreamStackBusLane[1][18][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [18]  =   DownstreamStackBusLane[1][18][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[18]  =   DownstreamStackBusLane[1][18][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][18][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [18]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [18]  =   DownstreamStackBusLane[1][18][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [18]  =   DownstreamStackBusLane[1][18][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[18]  =   DownstreamStackBusLane[1][18][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 19                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][19][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [19]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [19]  =   DownstreamStackBusLane[1][19][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [19]  =   DownstreamStackBusLane[1][19][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[19]  =   DownstreamStackBusLane[1][19][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][19][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [19]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [19]  =   DownstreamStackBusLane[1][19][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [19]  =   DownstreamStackBusLane[1][19][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[19]  =   DownstreamStackBusLane[1][19][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 20                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][20][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [20]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [20]  =   DownstreamStackBusLane[1][20][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [20]  =   DownstreamStackBusLane[1][20][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[20]  =   DownstreamStackBusLane[1][20][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][20][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [20]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [20]  =   DownstreamStackBusLane[1][20][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [20]  =   DownstreamStackBusLane[1][20][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[20]  =   DownstreamStackBusLane[1][20][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 21                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][21][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [21]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [21]  =   DownstreamStackBusLane[1][21][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [21]  =   DownstreamStackBusLane[1][21][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[21]  =   DownstreamStackBusLane[1][21][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][21][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [21]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [21]  =   DownstreamStackBusLane[1][21][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [21]  =   DownstreamStackBusLane[1][21][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[21]  =   DownstreamStackBusLane[1][21][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 22                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][22][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [22]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [22]  =   DownstreamStackBusLane[1][22][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [22]  =   DownstreamStackBusLane[1][22][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[22]  =   DownstreamStackBusLane[1][22][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][22][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [22]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [22]  =   DownstreamStackBusLane[1][22][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [22]  =   DownstreamStackBusLane[1][22][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[22]  =   DownstreamStackBusLane[1][22][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 23                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][23][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [23]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [23]  =   DownstreamStackBusLane[1][23][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [23]  =   DownstreamStackBusLane[1][23][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[23]  =   DownstreamStackBusLane[1][23][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][23][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [23]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [23]  =   DownstreamStackBusLane[1][23][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [23]  =   DownstreamStackBusLane[1][23][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[23]  =   DownstreamStackBusLane[1][23][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 24                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][24][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [24]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [24]  =   DownstreamStackBusLane[1][24][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [24]  =   DownstreamStackBusLane[1][24][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[24]  =   DownstreamStackBusLane[1][24][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][24][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [24]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [24]  =   DownstreamStackBusLane[1][24][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [24]  =   DownstreamStackBusLane[1][24][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[24]  =   DownstreamStackBusLane[1][24][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 25                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][25][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [25]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [25]  =   DownstreamStackBusLane[1][25][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [25]  =   DownstreamStackBusLane[1][25][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[25]  =   DownstreamStackBusLane[1][25][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][25][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [25]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [25]  =   DownstreamStackBusLane[1][25][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [25]  =   DownstreamStackBusLane[1][25][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[25]  =   DownstreamStackBusLane[1][25][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 26                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][26][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [26]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [26]  =   DownstreamStackBusLane[1][26][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [26]  =   DownstreamStackBusLane[1][26][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[26]  =   DownstreamStackBusLane[1][26][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][26][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [26]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [26]  =   DownstreamStackBusLane[1][26][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [26]  =   DownstreamStackBusLane[1][26][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[26]  =   DownstreamStackBusLane[1][26][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 27                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][27][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [27]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [27]  =   DownstreamStackBusLane[1][27][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [27]  =   DownstreamStackBusLane[1][27][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[27]  =   DownstreamStackBusLane[1][27][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][27][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [27]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [27]  =   DownstreamStackBusLane[1][27][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [27]  =   DownstreamStackBusLane[1][27][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[27]  =   DownstreamStackBusLane[1][27][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 28                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][28][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [28]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [28]  =   DownstreamStackBusLane[1][28][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [28]  =   DownstreamStackBusLane[1][28][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[28]  =   DownstreamStackBusLane[1][28][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][28][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [28]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [28]  =   DownstreamStackBusLane[1][28][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [28]  =   DownstreamStackBusLane[1][28][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[28]  =   DownstreamStackBusLane[1][28][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 29                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][29][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [29]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [29]  =   DownstreamStackBusLane[1][29][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [29]  =   DownstreamStackBusLane[1][29][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[29]  =   DownstreamStackBusLane[1][29][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][29][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [29]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [29]  =   DownstreamStackBusLane[1][29][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [29]  =   DownstreamStackBusLane[1][29][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[29]  =   DownstreamStackBusLane[1][29][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 30                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][30][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [30]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [30]  =   DownstreamStackBusLane[1][30][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [30]  =   DownstreamStackBusLane[1][30][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[30]  =   DownstreamStackBusLane[1][30][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][30][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [30]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [30]  =   DownstreamStackBusLane[1][30][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [30]  =   DownstreamStackBusLane[1][30][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[30]  =   DownstreamStackBusLane[1][30][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 1, Lane 31                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][31][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [31]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [31]  =   DownstreamStackBusLane[1][31][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [31]  =   DownstreamStackBusLane[1][31][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[31]  =   DownstreamStackBusLane[1][31][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[1][31][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [31]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [31]  =   DownstreamStackBusLane[1][31][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [31]  =   DownstreamStackBusLane[1][31][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[31]  =   DownstreamStackBusLane[1][31][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 0                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][0][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [0]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [0]  =   DownstreamStackBusLane[2][0][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [0]  =   DownstreamStackBusLane[2][0][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[0]  =   DownstreamStackBusLane[2][0][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][0][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [0]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [0]  =   DownstreamStackBusLane[2][0][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [0]  =   DownstreamStackBusLane[2][0][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[0]  =   DownstreamStackBusLane[2][0][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 1                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][1][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [1]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [1]  =   DownstreamStackBusLane[2][1][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [1]  =   DownstreamStackBusLane[2][1][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[1]  =   DownstreamStackBusLane[2][1][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][1][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [1]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [1]  =   DownstreamStackBusLane[2][1][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [1]  =   DownstreamStackBusLane[2][1][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[1]  =   DownstreamStackBusLane[2][1][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 2                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][2][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [2]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [2]  =   DownstreamStackBusLane[2][2][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [2]  =   DownstreamStackBusLane[2][2][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[2]  =   DownstreamStackBusLane[2][2][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][2][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [2]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [2]  =   DownstreamStackBusLane[2][2][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [2]  =   DownstreamStackBusLane[2][2][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[2]  =   DownstreamStackBusLane[2][2][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 3                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][3][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [3]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [3]  =   DownstreamStackBusLane[2][3][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [3]  =   DownstreamStackBusLane[2][3][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[3]  =   DownstreamStackBusLane[2][3][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][3][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [3]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [3]  =   DownstreamStackBusLane[2][3][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [3]  =   DownstreamStackBusLane[2][3][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[3]  =   DownstreamStackBusLane[2][3][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 4                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][4][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [4]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [4]  =   DownstreamStackBusLane[2][4][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [4]  =   DownstreamStackBusLane[2][4][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[4]  =   DownstreamStackBusLane[2][4][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][4][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [4]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [4]  =   DownstreamStackBusLane[2][4][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [4]  =   DownstreamStackBusLane[2][4][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[4]  =   DownstreamStackBusLane[2][4][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 5                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][5][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [5]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [5]  =   DownstreamStackBusLane[2][5][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [5]  =   DownstreamStackBusLane[2][5][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[5]  =   DownstreamStackBusLane[2][5][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][5][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [5]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [5]  =   DownstreamStackBusLane[2][5][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [5]  =   DownstreamStackBusLane[2][5][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[5]  =   DownstreamStackBusLane[2][5][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 6                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][6][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [6]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [6]  =   DownstreamStackBusLane[2][6][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [6]  =   DownstreamStackBusLane[2][6][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[6]  =   DownstreamStackBusLane[2][6][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][6][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [6]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [6]  =   DownstreamStackBusLane[2][6][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [6]  =   DownstreamStackBusLane[2][6][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[6]  =   DownstreamStackBusLane[2][6][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 7                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][7][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [7]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [7]  =   DownstreamStackBusLane[2][7][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [7]  =   DownstreamStackBusLane[2][7][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[7]  =   DownstreamStackBusLane[2][7][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][7][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [7]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [7]  =   DownstreamStackBusLane[2][7][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [7]  =   DownstreamStackBusLane[2][7][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[7]  =   DownstreamStackBusLane[2][7][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 8                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][8][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [8]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [8]  =   DownstreamStackBusLane[2][8][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [8]  =   DownstreamStackBusLane[2][8][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[8]  =   DownstreamStackBusLane[2][8][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][8][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [8]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [8]  =   DownstreamStackBusLane[2][8][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [8]  =   DownstreamStackBusLane[2][8][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[8]  =   DownstreamStackBusLane[2][8][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 9                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][9][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [9]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [9]  =   DownstreamStackBusLane[2][9][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [9]  =   DownstreamStackBusLane[2][9][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[9]  =   DownstreamStackBusLane[2][9][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][9][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [9]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [9]  =   DownstreamStackBusLane[2][9][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [9]  =   DownstreamStackBusLane[2][9][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[9]  =   DownstreamStackBusLane[2][9][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 10                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][10][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [10]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [10]  =   DownstreamStackBusLane[2][10][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [10]  =   DownstreamStackBusLane[2][10][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[10]  =   DownstreamStackBusLane[2][10][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][10][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [10]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [10]  =   DownstreamStackBusLane[2][10][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [10]  =   DownstreamStackBusLane[2][10][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[10]  =   DownstreamStackBusLane[2][10][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 11                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][11][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [11]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [11]  =   DownstreamStackBusLane[2][11][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [11]  =   DownstreamStackBusLane[2][11][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[11]  =   DownstreamStackBusLane[2][11][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][11][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [11]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [11]  =   DownstreamStackBusLane[2][11][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [11]  =   DownstreamStackBusLane[2][11][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[11]  =   DownstreamStackBusLane[2][11][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 12                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][12][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [12]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [12]  =   DownstreamStackBusLane[2][12][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [12]  =   DownstreamStackBusLane[2][12][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[12]  =   DownstreamStackBusLane[2][12][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][12][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [12]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [12]  =   DownstreamStackBusLane[2][12][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [12]  =   DownstreamStackBusLane[2][12][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[12]  =   DownstreamStackBusLane[2][12][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 13                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][13][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [13]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [13]  =   DownstreamStackBusLane[2][13][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [13]  =   DownstreamStackBusLane[2][13][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[13]  =   DownstreamStackBusLane[2][13][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][13][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [13]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [13]  =   DownstreamStackBusLane[2][13][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [13]  =   DownstreamStackBusLane[2][13][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[13]  =   DownstreamStackBusLane[2][13][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 14                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][14][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [14]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [14]  =   DownstreamStackBusLane[2][14][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [14]  =   DownstreamStackBusLane[2][14][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[14]  =   DownstreamStackBusLane[2][14][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][14][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [14]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [14]  =   DownstreamStackBusLane[2][14][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [14]  =   DownstreamStackBusLane[2][14][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[14]  =   DownstreamStackBusLane[2][14][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 15                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][15][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [15]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [15]  =   DownstreamStackBusLane[2][15][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [15]  =   DownstreamStackBusLane[2][15][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[15]  =   DownstreamStackBusLane[2][15][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][15][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [15]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [15]  =   DownstreamStackBusLane[2][15][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [15]  =   DownstreamStackBusLane[2][15][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[15]  =   DownstreamStackBusLane[2][15][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 16                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][16][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [16]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [16]  =   DownstreamStackBusLane[2][16][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [16]  =   DownstreamStackBusLane[2][16][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[16]  =   DownstreamStackBusLane[2][16][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][16][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [16]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [16]  =   DownstreamStackBusLane[2][16][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [16]  =   DownstreamStackBusLane[2][16][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[16]  =   DownstreamStackBusLane[2][16][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 17                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][17][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [17]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [17]  =   DownstreamStackBusLane[2][17][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [17]  =   DownstreamStackBusLane[2][17][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[17]  =   DownstreamStackBusLane[2][17][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][17][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [17]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [17]  =   DownstreamStackBusLane[2][17][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [17]  =   DownstreamStackBusLane[2][17][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[17]  =   DownstreamStackBusLane[2][17][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 18                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][18][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [18]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [18]  =   DownstreamStackBusLane[2][18][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [18]  =   DownstreamStackBusLane[2][18][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[18]  =   DownstreamStackBusLane[2][18][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][18][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [18]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [18]  =   DownstreamStackBusLane[2][18][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [18]  =   DownstreamStackBusLane[2][18][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[18]  =   DownstreamStackBusLane[2][18][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 19                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][19][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [19]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [19]  =   DownstreamStackBusLane[2][19][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [19]  =   DownstreamStackBusLane[2][19][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[19]  =   DownstreamStackBusLane[2][19][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][19][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [19]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [19]  =   DownstreamStackBusLane[2][19][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [19]  =   DownstreamStackBusLane[2][19][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[19]  =   DownstreamStackBusLane[2][19][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 20                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][20][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [20]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [20]  =   DownstreamStackBusLane[2][20][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [20]  =   DownstreamStackBusLane[2][20][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[20]  =   DownstreamStackBusLane[2][20][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][20][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [20]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [20]  =   DownstreamStackBusLane[2][20][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [20]  =   DownstreamStackBusLane[2][20][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[20]  =   DownstreamStackBusLane[2][20][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 21                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][21][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [21]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [21]  =   DownstreamStackBusLane[2][21][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [21]  =   DownstreamStackBusLane[2][21][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[21]  =   DownstreamStackBusLane[2][21][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][21][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [21]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [21]  =   DownstreamStackBusLane[2][21][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [21]  =   DownstreamStackBusLane[2][21][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[21]  =   DownstreamStackBusLane[2][21][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 22                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][22][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [22]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [22]  =   DownstreamStackBusLane[2][22][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [22]  =   DownstreamStackBusLane[2][22][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[22]  =   DownstreamStackBusLane[2][22][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][22][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [22]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [22]  =   DownstreamStackBusLane[2][22][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [22]  =   DownstreamStackBusLane[2][22][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[22]  =   DownstreamStackBusLane[2][22][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 23                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][23][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [23]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [23]  =   DownstreamStackBusLane[2][23][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [23]  =   DownstreamStackBusLane[2][23][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[23]  =   DownstreamStackBusLane[2][23][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][23][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [23]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [23]  =   DownstreamStackBusLane[2][23][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [23]  =   DownstreamStackBusLane[2][23][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[23]  =   DownstreamStackBusLane[2][23][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 24                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][24][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [24]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [24]  =   DownstreamStackBusLane[2][24][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [24]  =   DownstreamStackBusLane[2][24][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[24]  =   DownstreamStackBusLane[2][24][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][24][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [24]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [24]  =   DownstreamStackBusLane[2][24][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [24]  =   DownstreamStackBusLane[2][24][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[24]  =   DownstreamStackBusLane[2][24][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 25                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][25][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [25]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [25]  =   DownstreamStackBusLane[2][25][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [25]  =   DownstreamStackBusLane[2][25][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[25]  =   DownstreamStackBusLane[2][25][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][25][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [25]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [25]  =   DownstreamStackBusLane[2][25][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [25]  =   DownstreamStackBusLane[2][25][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[25]  =   DownstreamStackBusLane[2][25][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 26                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][26][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [26]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [26]  =   DownstreamStackBusLane[2][26][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [26]  =   DownstreamStackBusLane[2][26][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[26]  =   DownstreamStackBusLane[2][26][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][26][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [26]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [26]  =   DownstreamStackBusLane[2][26][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [26]  =   DownstreamStackBusLane[2][26][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[26]  =   DownstreamStackBusLane[2][26][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 27                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][27][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [27]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [27]  =   DownstreamStackBusLane[2][27][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [27]  =   DownstreamStackBusLane[2][27][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[27]  =   DownstreamStackBusLane[2][27][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][27][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [27]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [27]  =   DownstreamStackBusLane[2][27][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [27]  =   DownstreamStackBusLane[2][27][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[27]  =   DownstreamStackBusLane[2][27][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 28                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][28][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [28]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [28]  =   DownstreamStackBusLane[2][28][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [28]  =   DownstreamStackBusLane[2][28][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[28]  =   DownstreamStackBusLane[2][28][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][28][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [28]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [28]  =   DownstreamStackBusLane[2][28][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [28]  =   DownstreamStackBusLane[2][28][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[28]  =   DownstreamStackBusLane[2][28][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 29                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][29][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [29]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [29]  =   DownstreamStackBusLane[2][29][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [29]  =   DownstreamStackBusLane[2][29][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[29]  =   DownstreamStackBusLane[2][29][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][29][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [29]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [29]  =   DownstreamStackBusLane[2][29][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [29]  =   DownstreamStackBusLane[2][29][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[29]  =   DownstreamStackBusLane[2][29][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 30                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][30][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [30]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [30]  =   DownstreamStackBusLane[2][30][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [30]  =   DownstreamStackBusLane[2][30][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[30]  =   DownstreamStackBusLane[2][30][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][30][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [30]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [30]  =   DownstreamStackBusLane[2][30][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [30]  =   DownstreamStackBusLane[2][30][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[30]  =   DownstreamStackBusLane[2][30][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 2, Lane 31                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][31][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [31]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [31]  =   DownstreamStackBusLane[2][31][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [31]  =   DownstreamStackBusLane[2][31][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[31]  =   DownstreamStackBusLane[2][31][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[2][31][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [31]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [31]  =   DownstreamStackBusLane[2][31][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [31]  =   DownstreamStackBusLane[2][31][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[31]  =   DownstreamStackBusLane[2][31][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 0                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][0][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [0]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [0]  =   DownstreamStackBusLane[3][0][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [0]  =   DownstreamStackBusLane[3][0][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[0]  =   DownstreamStackBusLane[3][0][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][0][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [0]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [0]  =   DownstreamStackBusLane[3][0][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [0]  =   DownstreamStackBusLane[3][0][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[0]  =   DownstreamStackBusLane[3][0][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 1                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][1][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [1]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [1]  =   DownstreamStackBusLane[3][1][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [1]  =   DownstreamStackBusLane[3][1][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[1]  =   DownstreamStackBusLane[3][1][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][1][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [1]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [1]  =   DownstreamStackBusLane[3][1][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [1]  =   DownstreamStackBusLane[3][1][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[1]  =   DownstreamStackBusLane[3][1][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 2                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][2][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [2]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [2]  =   DownstreamStackBusLane[3][2][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [2]  =   DownstreamStackBusLane[3][2][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[2]  =   DownstreamStackBusLane[3][2][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][2][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [2]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [2]  =   DownstreamStackBusLane[3][2][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [2]  =   DownstreamStackBusLane[3][2][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[2]  =   DownstreamStackBusLane[3][2][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 3                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][3][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [3]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [3]  =   DownstreamStackBusLane[3][3][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [3]  =   DownstreamStackBusLane[3][3][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[3]  =   DownstreamStackBusLane[3][3][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][3][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [3]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [3]  =   DownstreamStackBusLane[3][3][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [3]  =   DownstreamStackBusLane[3][3][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[3]  =   DownstreamStackBusLane[3][3][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 4                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][4][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [4]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [4]  =   DownstreamStackBusLane[3][4][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [4]  =   DownstreamStackBusLane[3][4][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[4]  =   DownstreamStackBusLane[3][4][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][4][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [4]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [4]  =   DownstreamStackBusLane[3][4][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [4]  =   DownstreamStackBusLane[3][4][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[4]  =   DownstreamStackBusLane[3][4][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 5                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][5][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [5]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [5]  =   DownstreamStackBusLane[3][5][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [5]  =   DownstreamStackBusLane[3][5][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[5]  =   DownstreamStackBusLane[3][5][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][5][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [5]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [5]  =   DownstreamStackBusLane[3][5][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [5]  =   DownstreamStackBusLane[3][5][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[5]  =   DownstreamStackBusLane[3][5][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 6                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][6][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [6]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [6]  =   DownstreamStackBusLane[3][6][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [6]  =   DownstreamStackBusLane[3][6][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[6]  =   DownstreamStackBusLane[3][6][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][6][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [6]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [6]  =   DownstreamStackBusLane[3][6][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [6]  =   DownstreamStackBusLane[3][6][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[6]  =   DownstreamStackBusLane[3][6][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 7                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][7][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [7]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [7]  =   DownstreamStackBusLane[3][7][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [7]  =   DownstreamStackBusLane[3][7][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[7]  =   DownstreamStackBusLane[3][7][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][7][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [7]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [7]  =   DownstreamStackBusLane[3][7][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [7]  =   DownstreamStackBusLane[3][7][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[7]  =   DownstreamStackBusLane[3][7][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 8                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][8][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [8]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [8]  =   DownstreamStackBusLane[3][8][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [8]  =   DownstreamStackBusLane[3][8][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[8]  =   DownstreamStackBusLane[3][8][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][8][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [8]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [8]  =   DownstreamStackBusLane[3][8][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [8]  =   DownstreamStackBusLane[3][8][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[8]  =   DownstreamStackBusLane[3][8][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 9                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][9][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [9]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [9]  =   DownstreamStackBusLane[3][9][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [9]  =   DownstreamStackBusLane[3][9][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[9]  =   DownstreamStackBusLane[3][9][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][9][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [9]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [9]  =   DownstreamStackBusLane[3][9][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [9]  =   DownstreamStackBusLane[3][9][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[9]  =   DownstreamStackBusLane[3][9][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 10                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][10][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [10]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [10]  =   DownstreamStackBusLane[3][10][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [10]  =   DownstreamStackBusLane[3][10][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[10]  =   DownstreamStackBusLane[3][10][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][10][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [10]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [10]  =   DownstreamStackBusLane[3][10][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [10]  =   DownstreamStackBusLane[3][10][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[10]  =   DownstreamStackBusLane[3][10][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 11                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][11][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [11]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [11]  =   DownstreamStackBusLane[3][11][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [11]  =   DownstreamStackBusLane[3][11][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[11]  =   DownstreamStackBusLane[3][11][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][11][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [11]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [11]  =   DownstreamStackBusLane[3][11][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [11]  =   DownstreamStackBusLane[3][11][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[11]  =   DownstreamStackBusLane[3][11][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 12                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][12][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [12]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [12]  =   DownstreamStackBusLane[3][12][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [12]  =   DownstreamStackBusLane[3][12][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[12]  =   DownstreamStackBusLane[3][12][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][12][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [12]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [12]  =   DownstreamStackBusLane[3][12][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [12]  =   DownstreamStackBusLane[3][12][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[12]  =   DownstreamStackBusLane[3][12][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 13                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][13][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [13]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [13]  =   DownstreamStackBusLane[3][13][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [13]  =   DownstreamStackBusLane[3][13][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[13]  =   DownstreamStackBusLane[3][13][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][13][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [13]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [13]  =   DownstreamStackBusLane[3][13][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [13]  =   DownstreamStackBusLane[3][13][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[13]  =   DownstreamStackBusLane[3][13][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 14                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][14][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [14]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [14]  =   DownstreamStackBusLane[3][14][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [14]  =   DownstreamStackBusLane[3][14][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[14]  =   DownstreamStackBusLane[3][14][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][14][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [14]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [14]  =   DownstreamStackBusLane[3][14][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [14]  =   DownstreamStackBusLane[3][14][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[14]  =   DownstreamStackBusLane[3][14][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 15                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][15][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [15]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [15]  =   DownstreamStackBusLane[3][15][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [15]  =   DownstreamStackBusLane[3][15][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[15]  =   DownstreamStackBusLane[3][15][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][15][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [15]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [15]  =   DownstreamStackBusLane[3][15][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [15]  =   DownstreamStackBusLane[3][15][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[15]  =   DownstreamStackBusLane[3][15][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 16                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][16][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [16]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [16]  =   DownstreamStackBusLane[3][16][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [16]  =   DownstreamStackBusLane[3][16][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[16]  =   DownstreamStackBusLane[3][16][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][16][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [16]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [16]  =   DownstreamStackBusLane[3][16][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [16]  =   DownstreamStackBusLane[3][16][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[16]  =   DownstreamStackBusLane[3][16][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 17                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][17][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [17]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [17]  =   DownstreamStackBusLane[3][17][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [17]  =   DownstreamStackBusLane[3][17][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[17]  =   DownstreamStackBusLane[3][17][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][17][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [17]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [17]  =   DownstreamStackBusLane[3][17][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [17]  =   DownstreamStackBusLane[3][17][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[17]  =   DownstreamStackBusLane[3][17][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 18                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][18][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [18]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [18]  =   DownstreamStackBusLane[3][18][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [18]  =   DownstreamStackBusLane[3][18][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[18]  =   DownstreamStackBusLane[3][18][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][18][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [18]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [18]  =   DownstreamStackBusLane[3][18][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [18]  =   DownstreamStackBusLane[3][18][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[18]  =   DownstreamStackBusLane[3][18][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 19                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][19][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [19]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [19]  =   DownstreamStackBusLane[3][19][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [19]  =   DownstreamStackBusLane[3][19][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[19]  =   DownstreamStackBusLane[3][19][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][19][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [19]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [19]  =   DownstreamStackBusLane[3][19][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [19]  =   DownstreamStackBusLane[3][19][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[19]  =   DownstreamStackBusLane[3][19][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 20                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][20][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [20]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [20]  =   DownstreamStackBusLane[3][20][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [20]  =   DownstreamStackBusLane[3][20][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[20]  =   DownstreamStackBusLane[3][20][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][20][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [20]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [20]  =   DownstreamStackBusLane[3][20][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [20]  =   DownstreamStackBusLane[3][20][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[20]  =   DownstreamStackBusLane[3][20][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 21                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][21][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [21]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [21]  =   DownstreamStackBusLane[3][21][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [21]  =   DownstreamStackBusLane[3][21][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[21]  =   DownstreamStackBusLane[3][21][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][21][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [21]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [21]  =   DownstreamStackBusLane[3][21][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [21]  =   DownstreamStackBusLane[3][21][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[21]  =   DownstreamStackBusLane[3][21][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 22                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][22][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [22]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [22]  =   DownstreamStackBusLane[3][22][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [22]  =   DownstreamStackBusLane[3][22][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[22]  =   DownstreamStackBusLane[3][22][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][22][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [22]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [22]  =   DownstreamStackBusLane[3][22][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [22]  =   DownstreamStackBusLane[3][22][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[22]  =   DownstreamStackBusLane[3][22][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 23                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][23][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [23]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [23]  =   DownstreamStackBusLane[3][23][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [23]  =   DownstreamStackBusLane[3][23][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[23]  =   DownstreamStackBusLane[3][23][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][23][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [23]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [23]  =   DownstreamStackBusLane[3][23][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [23]  =   DownstreamStackBusLane[3][23][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[23]  =   DownstreamStackBusLane[3][23][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 24                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][24][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [24]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [24]  =   DownstreamStackBusLane[3][24][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [24]  =   DownstreamStackBusLane[3][24][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[24]  =   DownstreamStackBusLane[3][24][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][24][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [24]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [24]  =   DownstreamStackBusLane[3][24][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [24]  =   DownstreamStackBusLane[3][24][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[24]  =   DownstreamStackBusLane[3][24][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 25                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][25][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [25]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [25]  =   DownstreamStackBusLane[3][25][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [25]  =   DownstreamStackBusLane[3][25][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[25]  =   DownstreamStackBusLane[3][25][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][25][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [25]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [25]  =   DownstreamStackBusLane[3][25][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [25]  =   DownstreamStackBusLane[3][25][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[25]  =   DownstreamStackBusLane[3][25][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 26                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][26][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [26]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [26]  =   DownstreamStackBusLane[3][26][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [26]  =   DownstreamStackBusLane[3][26][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[26]  =   DownstreamStackBusLane[3][26][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][26][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [26]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [26]  =   DownstreamStackBusLane[3][26][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [26]  =   DownstreamStackBusLane[3][26][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[26]  =   DownstreamStackBusLane[3][26][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 27                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][27][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [27]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [27]  =   DownstreamStackBusLane[3][27][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [27]  =   DownstreamStackBusLane[3][27][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[27]  =   DownstreamStackBusLane[3][27][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][27][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [27]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [27]  =   DownstreamStackBusLane[3][27][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [27]  =   DownstreamStackBusLane[3][27][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[27]  =   DownstreamStackBusLane[3][27][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 28                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][28][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [28]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [28]  =   DownstreamStackBusLane[3][28][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [28]  =   DownstreamStackBusLane[3][28][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[28]  =   DownstreamStackBusLane[3][28][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][28][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [28]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [28]  =   DownstreamStackBusLane[3][28][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [28]  =   DownstreamStackBusLane[3][28][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[28]  =   DownstreamStackBusLane[3][28][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 29                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][29][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [29]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [29]  =   DownstreamStackBusLane[3][29][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [29]  =   DownstreamStackBusLane[3][29][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[29]  =   DownstreamStackBusLane[3][29][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][29][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [29]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [29]  =   DownstreamStackBusLane[3][29][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [29]  =   DownstreamStackBusLane[3][29][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[29]  =   DownstreamStackBusLane[3][29][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 30                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][30][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [30]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [30]  =   DownstreamStackBusLane[3][30][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [30]  =   DownstreamStackBusLane[3][30][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[30]  =   DownstreamStackBusLane[3][30][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][30][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [30]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [30]  =   DownstreamStackBusLane[3][30][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [30]  =   DownstreamStackBusLane[3][30][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[30]  =   DownstreamStackBusLane[3][30][1].std__pe__lane_strm_data_valid ;
          end
        
        // PE 3, Lane 31                 
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][31][0].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.std__mrc__lane_ready [31]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_cntl_e1 [31]  =   DownstreamStackBusLane[3][31][0].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_data_e1 [31]  =   DownstreamStackBusLane[3][31][0].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[0].mrc_cntl.mrc__std__lane_valid_e1[31]  =   DownstreamStackBusLane[3][31][0].std__pe__lane_strm_data_valid ;
          end
        
        //  - doesnt seem to work if you use cb_test for observed signals 
        assign DownstreamStackBusLane[3][31][1].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.std__mrc__lane_ready [31]    ;
        always @(*)
          begin
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_cntl_e1 [31]  =   DownstreamStackBusLane[3][31][1].std__pe__lane_strm_cntl       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_data_e1 [31]  =   DownstreamStackBusLane[3][31][1].std__pe__lane_strm_data       ;
            system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst[1].mrc_cntl.mrc__std__lane_valid_e1[31]  =   DownstreamStackBusLane[3][31][1].std__pe__lane_strm_data_valid ;
          end
        