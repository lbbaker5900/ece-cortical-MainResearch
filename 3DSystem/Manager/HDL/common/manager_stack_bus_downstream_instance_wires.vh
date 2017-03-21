
  // General control and status                                             
  wire [`PE_PE_ID_RANGE                 ]     sys__mgr__mgrId               ;
  wire                                        mgr__sys__allSynchronized     ;
  wire                                        sys__mgr__thisSynchronized    ;
  wire                                        sys__mgr__ready               ;
  wire                                        sys__mgr__complete            ;
  // OOB carries PE configuration                                           
  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl            ;
  wire                                        mgr__std__oob_valid           ;
  wire                                        std__mgr__oob_ready           ;
  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type            ;
  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data            ;
  // Lane operand bus                 
  wire                                           std__mgr__lane0_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane0_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane0_strm0_data        ;
  wire                                           mgr__std__lane0_strm0_data_valid  ;
  wire                                           std__mgr__lane0_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane0_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane0_strm1_data        ;
  wire                                           mgr__std__lane0_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane1_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane1_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane1_strm0_data        ;
  wire                                           mgr__std__lane1_strm0_data_valid  ;
  wire                                           std__mgr__lane1_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane1_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane1_strm1_data        ;
  wire                                           mgr__std__lane1_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane2_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane2_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane2_strm0_data        ;
  wire                                           mgr__std__lane2_strm0_data_valid  ;
  wire                                           std__mgr__lane2_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane2_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane2_strm1_data        ;
  wire                                           mgr__std__lane2_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane3_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane3_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane3_strm0_data        ;
  wire                                           mgr__std__lane3_strm0_data_valid  ;
  wire                                           std__mgr__lane3_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane3_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane3_strm1_data        ;
  wire                                           mgr__std__lane3_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane4_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane4_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane4_strm0_data        ;
  wire                                           mgr__std__lane4_strm0_data_valid  ;
  wire                                           std__mgr__lane4_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane4_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane4_strm1_data        ;
  wire                                           mgr__std__lane4_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane5_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane5_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane5_strm0_data        ;
  wire                                           mgr__std__lane5_strm0_data_valid  ;
  wire                                           std__mgr__lane5_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane5_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane5_strm1_data        ;
  wire                                           mgr__std__lane5_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane6_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane6_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane6_strm0_data        ;
  wire                                           mgr__std__lane6_strm0_data_valid  ;
  wire                                           std__mgr__lane6_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane6_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane6_strm1_data        ;
  wire                                           mgr__std__lane6_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane7_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane7_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane7_strm0_data        ;
  wire                                           mgr__std__lane7_strm0_data_valid  ;
  wire                                           std__mgr__lane7_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane7_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane7_strm1_data        ;
  wire                                           mgr__std__lane7_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane8_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane8_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane8_strm0_data        ;
  wire                                           mgr__std__lane8_strm0_data_valid  ;
  wire                                           std__mgr__lane8_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane8_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane8_strm1_data        ;
  wire                                           mgr__std__lane8_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane9_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane9_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane9_strm0_data        ;
  wire                                           mgr__std__lane9_strm0_data_valid  ;
  wire                                           std__mgr__lane9_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane9_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane9_strm1_data        ;
  wire                                           mgr__std__lane9_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane10_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane10_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane10_strm0_data        ;
  wire                                           mgr__std__lane10_strm0_data_valid  ;
  wire                                           std__mgr__lane10_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane10_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane10_strm1_data        ;
  wire                                           mgr__std__lane10_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane11_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane11_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane11_strm0_data        ;
  wire                                           mgr__std__lane11_strm0_data_valid  ;
  wire                                           std__mgr__lane11_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane11_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane11_strm1_data        ;
  wire                                           mgr__std__lane11_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane12_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane12_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane12_strm0_data        ;
  wire                                           mgr__std__lane12_strm0_data_valid  ;
  wire                                           std__mgr__lane12_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane12_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane12_strm1_data        ;
  wire                                           mgr__std__lane12_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane13_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane13_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane13_strm0_data        ;
  wire                                           mgr__std__lane13_strm0_data_valid  ;
  wire                                           std__mgr__lane13_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane13_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane13_strm1_data        ;
  wire                                           mgr__std__lane13_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane14_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane14_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane14_strm0_data        ;
  wire                                           mgr__std__lane14_strm0_data_valid  ;
  wire                                           std__mgr__lane14_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane14_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane14_strm1_data        ;
  wire                                           mgr__std__lane14_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane15_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane15_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane15_strm0_data        ;
  wire                                           mgr__std__lane15_strm0_data_valid  ;
  wire                                           std__mgr__lane15_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane15_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane15_strm1_data        ;
  wire                                           mgr__std__lane15_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane16_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane16_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane16_strm0_data        ;
  wire                                           mgr__std__lane16_strm0_data_valid  ;
  wire                                           std__mgr__lane16_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane16_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane16_strm1_data        ;
  wire                                           mgr__std__lane16_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane17_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane17_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane17_strm0_data        ;
  wire                                           mgr__std__lane17_strm0_data_valid  ;
  wire                                           std__mgr__lane17_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane17_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane17_strm1_data        ;
  wire                                           mgr__std__lane17_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane18_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane18_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane18_strm0_data        ;
  wire                                           mgr__std__lane18_strm0_data_valid  ;
  wire                                           std__mgr__lane18_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane18_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane18_strm1_data        ;
  wire                                           mgr__std__lane18_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane19_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane19_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane19_strm0_data        ;
  wire                                           mgr__std__lane19_strm0_data_valid  ;
  wire                                           std__mgr__lane19_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane19_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane19_strm1_data        ;
  wire                                           mgr__std__lane19_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane20_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane20_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane20_strm0_data        ;
  wire                                           mgr__std__lane20_strm0_data_valid  ;
  wire                                           std__mgr__lane20_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane20_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane20_strm1_data        ;
  wire                                           mgr__std__lane20_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane21_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane21_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane21_strm0_data        ;
  wire                                           mgr__std__lane21_strm0_data_valid  ;
  wire                                           std__mgr__lane21_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane21_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane21_strm1_data        ;
  wire                                           mgr__std__lane21_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane22_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane22_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane22_strm0_data        ;
  wire                                           mgr__std__lane22_strm0_data_valid  ;
  wire                                           std__mgr__lane22_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane22_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane22_strm1_data        ;
  wire                                           mgr__std__lane22_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane23_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane23_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane23_strm0_data        ;
  wire                                           mgr__std__lane23_strm0_data_valid  ;
  wire                                           std__mgr__lane23_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane23_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane23_strm1_data        ;
  wire                                           mgr__std__lane23_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane24_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane24_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane24_strm0_data        ;
  wire                                           mgr__std__lane24_strm0_data_valid  ;
  wire                                           std__mgr__lane24_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane24_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane24_strm1_data        ;
  wire                                           mgr__std__lane24_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane25_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane25_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane25_strm0_data        ;
  wire                                           mgr__std__lane25_strm0_data_valid  ;
  wire                                           std__mgr__lane25_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane25_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane25_strm1_data        ;
  wire                                           mgr__std__lane25_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane26_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane26_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane26_strm0_data        ;
  wire                                           mgr__std__lane26_strm0_data_valid  ;
  wire                                           std__mgr__lane26_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane26_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane26_strm1_data        ;
  wire                                           mgr__std__lane26_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane27_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane27_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane27_strm0_data        ;
  wire                                           mgr__std__lane27_strm0_data_valid  ;
  wire                                           std__mgr__lane27_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane27_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane27_strm1_data        ;
  wire                                           mgr__std__lane27_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane28_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane28_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane28_strm0_data        ;
  wire                                           mgr__std__lane28_strm0_data_valid  ;
  wire                                           std__mgr__lane28_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane28_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane28_strm1_data        ;
  wire                                           mgr__std__lane28_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane29_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane29_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane29_strm0_data        ;
  wire                                           mgr__std__lane29_strm0_data_valid  ;
  wire                                           std__mgr__lane29_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane29_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane29_strm1_data        ;
  wire                                           mgr__std__lane29_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane30_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane30_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane30_strm0_data        ;
  wire                                           mgr__std__lane30_strm0_data_valid  ;
  wire                                           std__mgr__lane30_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane30_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane30_strm1_data        ;
  wire                                           mgr__std__lane30_strm1_data_valid  ;
  // Lane operand bus                 
  wire                                           std__mgr__lane31_strm0_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane31_strm0_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane31_strm0_data        ;
  wire                                           mgr__std__lane31_strm0_data_valid  ;
  wire                                           std__mgr__lane31_strm1_ready       ;
  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane31_strm1_cntl        ;
  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane31_strm1_data        ;
  wire                                           mgr__std__lane31_strm1_data_valid  ;