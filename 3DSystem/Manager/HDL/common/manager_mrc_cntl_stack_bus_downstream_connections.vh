
      //------------------------------------------------------------------------------------------------------------------------
      // Lane 0                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [0] =   std__mgr__lane0_strm0_ready                 ;   
      assign mgr__std__lane0_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [0]; 
      assign mgr__std__lane0_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [0]; 
      assign mgr__std__lane0_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [0]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [0] =   std__mgr__lane0_strm1_ready                 ;   
      assign mgr__std__lane0_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [0]; 
      assign mgr__std__lane0_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [0]; 
      assign mgr__std__lane0_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [0]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 1                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [1] =   std__mgr__lane1_strm0_ready                 ;   
      assign mgr__std__lane1_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [1]; 
      assign mgr__std__lane1_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [1]; 
      assign mgr__std__lane1_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [1]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [1] =   std__mgr__lane1_strm1_ready                 ;   
      assign mgr__std__lane1_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [1]; 
      assign mgr__std__lane1_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [1]; 
      assign mgr__std__lane1_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [1]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 2                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [2] =   std__mgr__lane2_strm0_ready                 ;   
      assign mgr__std__lane2_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [2]; 
      assign mgr__std__lane2_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [2]; 
      assign mgr__std__lane2_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [2]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [2] =   std__mgr__lane2_strm1_ready                 ;   
      assign mgr__std__lane2_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [2]; 
      assign mgr__std__lane2_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [2]; 
      assign mgr__std__lane2_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [2]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 3                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [3] =   std__mgr__lane3_strm0_ready                 ;   
      assign mgr__std__lane3_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [3]; 
      assign mgr__std__lane3_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [3]; 
      assign mgr__std__lane3_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [3]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [3] =   std__mgr__lane3_strm1_ready                 ;   
      assign mgr__std__lane3_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [3]; 
      assign mgr__std__lane3_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [3]; 
      assign mgr__std__lane3_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [3]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 4                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [4] =   std__mgr__lane4_strm0_ready                 ;   
      assign mgr__std__lane4_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [4]; 
      assign mgr__std__lane4_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [4]; 
      assign mgr__std__lane4_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [4]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [4] =   std__mgr__lane4_strm1_ready                 ;   
      assign mgr__std__lane4_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [4]; 
      assign mgr__std__lane4_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [4]; 
      assign mgr__std__lane4_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [4]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 5                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [5] =   std__mgr__lane5_strm0_ready                 ;   
      assign mgr__std__lane5_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [5]; 
      assign mgr__std__lane5_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [5]; 
      assign mgr__std__lane5_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [5]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [5] =   std__mgr__lane5_strm1_ready                 ;   
      assign mgr__std__lane5_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [5]; 
      assign mgr__std__lane5_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [5]; 
      assign mgr__std__lane5_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [5]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 6                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [6] =   std__mgr__lane6_strm0_ready                 ;   
      assign mgr__std__lane6_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [6]; 
      assign mgr__std__lane6_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [6]; 
      assign mgr__std__lane6_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [6]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [6] =   std__mgr__lane6_strm1_ready                 ;   
      assign mgr__std__lane6_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [6]; 
      assign mgr__std__lane6_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [6]; 
      assign mgr__std__lane6_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [6]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 7                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [7] =   std__mgr__lane7_strm0_ready                 ;   
      assign mgr__std__lane7_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [7]; 
      assign mgr__std__lane7_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [7]; 
      assign mgr__std__lane7_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [7]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [7] =   std__mgr__lane7_strm1_ready                 ;   
      assign mgr__std__lane7_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [7]; 
      assign mgr__std__lane7_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [7]; 
      assign mgr__std__lane7_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [7]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 8                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [8] =   std__mgr__lane8_strm0_ready                 ;   
      assign mgr__std__lane8_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [8]; 
      assign mgr__std__lane8_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [8]; 
      assign mgr__std__lane8_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [8]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [8] =   std__mgr__lane8_strm1_ready                 ;   
      assign mgr__std__lane8_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [8]; 
      assign mgr__std__lane8_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [8]; 
      assign mgr__std__lane8_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [8]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 9                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [9] =   std__mgr__lane9_strm0_ready                 ;   
      assign mgr__std__lane9_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [9]; 
      assign mgr__std__lane9_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [9]; 
      assign mgr__std__lane9_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [9]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [9] =   std__mgr__lane9_strm1_ready                 ;   
      assign mgr__std__lane9_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [9]; 
      assign mgr__std__lane9_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [9]; 
      assign mgr__std__lane9_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [9]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 10                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [10] =   std__mgr__lane10_strm0_ready                 ;   
      assign mgr__std__lane10_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [10]; 
      assign mgr__std__lane10_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [10]; 
      assign mgr__std__lane10_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [10]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [10] =   std__mgr__lane10_strm1_ready                 ;   
      assign mgr__std__lane10_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [10]; 
      assign mgr__std__lane10_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [10]; 
      assign mgr__std__lane10_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [10]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 11                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [11] =   std__mgr__lane11_strm0_ready                 ;   
      assign mgr__std__lane11_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [11]; 
      assign mgr__std__lane11_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [11]; 
      assign mgr__std__lane11_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [11]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [11] =   std__mgr__lane11_strm1_ready                 ;   
      assign mgr__std__lane11_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [11]; 
      assign mgr__std__lane11_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [11]; 
      assign mgr__std__lane11_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [11]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 12                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [12] =   std__mgr__lane12_strm0_ready                 ;   
      assign mgr__std__lane12_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [12]; 
      assign mgr__std__lane12_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [12]; 
      assign mgr__std__lane12_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [12]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [12] =   std__mgr__lane12_strm1_ready                 ;   
      assign mgr__std__lane12_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [12]; 
      assign mgr__std__lane12_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [12]; 
      assign mgr__std__lane12_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [12]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 13                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [13] =   std__mgr__lane13_strm0_ready                 ;   
      assign mgr__std__lane13_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [13]; 
      assign mgr__std__lane13_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [13]; 
      assign mgr__std__lane13_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [13]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [13] =   std__mgr__lane13_strm1_ready                 ;   
      assign mgr__std__lane13_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [13]; 
      assign mgr__std__lane13_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [13]; 
      assign mgr__std__lane13_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [13]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 14                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [14] =   std__mgr__lane14_strm0_ready                 ;   
      assign mgr__std__lane14_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [14]; 
      assign mgr__std__lane14_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [14]; 
      assign mgr__std__lane14_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [14]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [14] =   std__mgr__lane14_strm1_ready                 ;   
      assign mgr__std__lane14_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [14]; 
      assign mgr__std__lane14_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [14]; 
      assign mgr__std__lane14_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [14]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 15                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [15] =   std__mgr__lane15_strm0_ready                 ;   
      assign mgr__std__lane15_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [15]; 
      assign mgr__std__lane15_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [15]; 
      assign mgr__std__lane15_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [15]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [15] =   std__mgr__lane15_strm1_ready                 ;   
      assign mgr__std__lane15_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [15]; 
      assign mgr__std__lane15_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [15]; 
      assign mgr__std__lane15_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [15]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 16                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [16] =   std__mgr__lane16_strm0_ready                 ;   
      assign mgr__std__lane16_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [16]; 
      assign mgr__std__lane16_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [16]; 
      assign mgr__std__lane16_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [16]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [16] =   std__mgr__lane16_strm1_ready                 ;   
      assign mgr__std__lane16_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [16]; 
      assign mgr__std__lane16_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [16]; 
      assign mgr__std__lane16_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [16]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 17                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [17] =   std__mgr__lane17_strm0_ready                 ;   
      assign mgr__std__lane17_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [17]; 
      assign mgr__std__lane17_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [17]; 
      assign mgr__std__lane17_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [17]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [17] =   std__mgr__lane17_strm1_ready                 ;   
      assign mgr__std__lane17_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [17]; 
      assign mgr__std__lane17_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [17]; 
      assign mgr__std__lane17_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [17]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 18                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [18] =   std__mgr__lane18_strm0_ready                 ;   
      assign mgr__std__lane18_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [18]; 
      assign mgr__std__lane18_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [18]; 
      assign mgr__std__lane18_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [18]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [18] =   std__mgr__lane18_strm1_ready                 ;   
      assign mgr__std__lane18_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [18]; 
      assign mgr__std__lane18_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [18]; 
      assign mgr__std__lane18_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [18]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 19                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [19] =   std__mgr__lane19_strm0_ready                 ;   
      assign mgr__std__lane19_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [19]; 
      assign mgr__std__lane19_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [19]; 
      assign mgr__std__lane19_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [19]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [19] =   std__mgr__lane19_strm1_ready                 ;   
      assign mgr__std__lane19_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [19]; 
      assign mgr__std__lane19_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [19]; 
      assign mgr__std__lane19_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [19]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 20                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [20] =   std__mgr__lane20_strm0_ready                 ;   
      assign mgr__std__lane20_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [20]; 
      assign mgr__std__lane20_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [20]; 
      assign mgr__std__lane20_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [20]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [20] =   std__mgr__lane20_strm1_ready                 ;   
      assign mgr__std__lane20_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [20]; 
      assign mgr__std__lane20_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [20]; 
      assign mgr__std__lane20_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [20]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 21                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [21] =   std__mgr__lane21_strm0_ready                 ;   
      assign mgr__std__lane21_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [21]; 
      assign mgr__std__lane21_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [21]; 
      assign mgr__std__lane21_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [21]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [21] =   std__mgr__lane21_strm1_ready                 ;   
      assign mgr__std__lane21_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [21]; 
      assign mgr__std__lane21_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [21]; 
      assign mgr__std__lane21_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [21]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 22                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [22] =   std__mgr__lane22_strm0_ready                 ;   
      assign mgr__std__lane22_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [22]; 
      assign mgr__std__lane22_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [22]; 
      assign mgr__std__lane22_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [22]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [22] =   std__mgr__lane22_strm1_ready                 ;   
      assign mgr__std__lane22_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [22]; 
      assign mgr__std__lane22_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [22]; 
      assign mgr__std__lane22_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [22]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 23                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [23] =   std__mgr__lane23_strm0_ready                 ;   
      assign mgr__std__lane23_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [23]; 
      assign mgr__std__lane23_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [23]; 
      assign mgr__std__lane23_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [23]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [23] =   std__mgr__lane23_strm1_ready                 ;   
      assign mgr__std__lane23_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [23]; 
      assign mgr__std__lane23_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [23]; 
      assign mgr__std__lane23_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [23]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 24                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [24] =   std__mgr__lane24_strm0_ready                 ;   
      assign mgr__std__lane24_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [24]; 
      assign mgr__std__lane24_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [24]; 
      assign mgr__std__lane24_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [24]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [24] =   std__mgr__lane24_strm1_ready                 ;   
      assign mgr__std__lane24_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [24]; 
      assign mgr__std__lane24_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [24]; 
      assign mgr__std__lane24_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [24]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 25                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [25] =   std__mgr__lane25_strm0_ready                 ;   
      assign mgr__std__lane25_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [25]; 
      assign mgr__std__lane25_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [25]; 
      assign mgr__std__lane25_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [25]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [25] =   std__mgr__lane25_strm1_ready                 ;   
      assign mgr__std__lane25_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [25]; 
      assign mgr__std__lane25_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [25]; 
      assign mgr__std__lane25_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [25]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 26                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [26] =   std__mgr__lane26_strm0_ready                 ;   
      assign mgr__std__lane26_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [26]; 
      assign mgr__std__lane26_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [26]; 
      assign mgr__std__lane26_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [26]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [26] =   std__mgr__lane26_strm1_ready                 ;   
      assign mgr__std__lane26_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [26]; 
      assign mgr__std__lane26_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [26]; 
      assign mgr__std__lane26_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [26]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 27                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [27] =   std__mgr__lane27_strm0_ready                 ;   
      assign mgr__std__lane27_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [27]; 
      assign mgr__std__lane27_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [27]; 
      assign mgr__std__lane27_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [27]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [27] =   std__mgr__lane27_strm1_ready                 ;   
      assign mgr__std__lane27_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [27]; 
      assign mgr__std__lane27_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [27]; 
      assign mgr__std__lane27_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [27]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 28                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [28] =   std__mgr__lane28_strm0_ready                 ;   
      assign mgr__std__lane28_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [28]; 
      assign mgr__std__lane28_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [28]; 
      assign mgr__std__lane28_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [28]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [28] =   std__mgr__lane28_strm1_ready                 ;   
      assign mgr__std__lane28_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [28]; 
      assign mgr__std__lane28_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [28]; 
      assign mgr__std__lane28_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [28]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 29                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [29] =   std__mgr__lane29_strm0_ready                 ;   
      assign mgr__std__lane29_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [29]; 
      assign mgr__std__lane29_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [29]; 
      assign mgr__std__lane29_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [29]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [29] =   std__mgr__lane29_strm1_ready                 ;   
      assign mgr__std__lane29_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [29]; 
      assign mgr__std__lane29_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [29]; 
      assign mgr__std__lane29_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [29]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 30                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [30] =   std__mgr__lane30_strm0_ready                 ;   
      assign mgr__std__lane30_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [30]; 
      assign mgr__std__lane30_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [30]; 
      assign mgr__std__lane30_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [30]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [30] =   std__mgr__lane30_strm1_ready                 ;   
      assign mgr__std__lane30_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [30]; 
      assign mgr__std__lane30_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [30]; 
      assign mgr__std__lane30_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [30]; 

      //------------------------------------------------------------------------------------------------------------------------
      // Lane 31                 
      // 
      // Stream 0                 
      assign mrc_cntl_strm_inst[0].std__mrc__lane_ready [31] =   std__mgr__lane31_strm0_ready                 ;   
      assign mgr__std__lane31_strm0_cntl                     =   mrc_cntl_strm_inst[0].mrc__std__lane_cntl  [31]; 
      assign mgr__std__lane31_strm0_data                     =   mrc_cntl_strm_inst[0].mrc__std__lane_data  [31]; 
      assign mgr__std__lane31_strm0_data_valid               =   mrc_cntl_strm_inst[0].mrc__std__lane_valid [31]; 

      // Stream 1                 
      assign mrc_cntl_strm_inst[1].std__mrc__lane_ready [31] =   std__mgr__lane31_strm1_ready                 ;   
      assign mgr__std__lane31_strm1_cntl                     =   mrc_cntl_strm_inst[1].mrc__std__lane_cntl  [31]; 
      assign mgr__std__lane31_strm1_data                     =   mrc_cntl_strm_inst[1].mrc__std__lane_data  [31]; 
      assign mgr__std__lane31_strm1_data_valid               =   mrc_cntl_strm_inst[1].mrc__std__lane_valid [31]; 
