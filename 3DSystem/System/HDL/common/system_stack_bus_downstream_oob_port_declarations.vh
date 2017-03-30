
  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr0__std__oob_cntl            ;
  input                                           mgr0__std__oob_valid           ;
  output                                          std__mgr0__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr0__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr0__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe0__oob_cntl            ;
  output                                          std__pe0__oob_valid           ;
  input                                           pe0__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe0__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe0__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr1__std__oob_cntl            ;
  input                                           mgr1__std__oob_valid           ;
  output                                          std__mgr1__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr1__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr1__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe1__oob_cntl            ;
  output                                          std__pe1__oob_valid           ;
  input                                           pe1__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe1__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe1__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr2__std__oob_cntl            ;
  input                                           mgr2__std__oob_valid           ;
  output                                          std__mgr2__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr2__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr2__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe2__oob_cntl            ;
  output                                          std__pe2__oob_valid           ;
  input                                           pe2__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe2__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe2__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr3__std__oob_cntl            ;
  input                                           mgr3__std__oob_valid           ;
  output                                          std__mgr3__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr3__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr3__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe3__oob_cntl            ;
  output                                          std__pe3__oob_valid           ;
  input                                           pe3__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe3__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe3__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr4__std__oob_cntl            ;
  input                                           mgr4__std__oob_valid           ;
  output                                          std__mgr4__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr4__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr4__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe4__oob_cntl            ;
  output                                          std__pe4__oob_valid           ;
  input                                           pe4__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe4__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe4__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr5__std__oob_cntl            ;
  input                                           mgr5__std__oob_valid           ;
  output                                          std__mgr5__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr5__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr5__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe5__oob_cntl            ;
  output                                          std__pe5__oob_valid           ;
  input                                           pe5__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe5__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe5__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr6__std__oob_cntl            ;
  input                                           mgr6__std__oob_valid           ;
  output                                          std__mgr6__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr6__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr6__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe6__oob_cntl            ;
  output                                          std__pe6__oob_valid           ;
  input                                           pe6__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe6__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe6__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr7__std__oob_cntl            ;
  input                                           mgr7__std__oob_valid           ;
  output                                          std__mgr7__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr7__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr7__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe7__oob_cntl            ;
  output                                          std__pe7__oob_valid           ;
  input                                           pe7__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe7__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe7__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr8__std__oob_cntl            ;
  input                                           mgr8__std__oob_valid           ;
  output                                          std__mgr8__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr8__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr8__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe8__oob_cntl            ;
  output                                          std__pe8__oob_valid           ;
  input                                           pe8__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe8__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe8__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr9__std__oob_cntl            ;
  input                                           mgr9__std__oob_valid           ;
  output                                          std__mgr9__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr9__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr9__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe9__oob_cntl            ;
  output                                          std__pe9__oob_valid           ;
  input                                           pe9__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe9__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe9__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr10__std__oob_cntl            ;
  input                                           mgr10__std__oob_valid           ;
  output                                          std__mgr10__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr10__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr10__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe10__oob_cntl            ;
  output                                          std__pe10__oob_valid           ;
  input                                           pe10__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe10__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe10__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr11__std__oob_cntl            ;
  input                                           mgr11__std__oob_valid           ;
  output                                          std__mgr11__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr11__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr11__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe11__oob_cntl            ;
  output                                          std__pe11__oob_valid           ;
  input                                           pe11__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe11__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe11__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr12__std__oob_cntl            ;
  input                                           mgr12__std__oob_valid           ;
  output                                          std__mgr12__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr12__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr12__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe12__oob_cntl            ;
  output                                          std__pe12__oob_valid           ;
  input                                           pe12__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe12__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe12__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr13__std__oob_cntl            ;
  input                                           mgr13__std__oob_valid           ;
  output                                          std__mgr13__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr13__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr13__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe13__oob_cntl            ;
  output                                          std__pe13__oob_valid           ;
  input                                           pe13__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe13__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe13__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr14__std__oob_cntl            ;
  input                                           mgr14__std__oob_valid           ;
  output                                          std__mgr14__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr14__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr14__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe14__oob_cntl            ;
  output                                          std__pe14__oob_valid           ;
  input                                           pe14__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe14__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe14__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr15__std__oob_cntl            ;
  input                                           mgr15__std__oob_valid           ;
  output                                          std__mgr15__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr15__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr15__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe15__oob_cntl            ;
  output                                          std__pe15__oob_valid           ;
  input                                           pe15__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe15__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe15__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr16__std__oob_cntl            ;
  input                                           mgr16__std__oob_valid           ;
  output                                          std__mgr16__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr16__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr16__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe16__oob_cntl            ;
  output                                          std__pe16__oob_valid           ;
  input                                           pe16__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe16__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe16__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr17__std__oob_cntl            ;
  input                                           mgr17__std__oob_valid           ;
  output                                          std__mgr17__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr17__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr17__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe17__oob_cntl            ;
  output                                          std__pe17__oob_valid           ;
  input                                           pe17__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe17__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe17__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr18__std__oob_cntl            ;
  input                                           mgr18__std__oob_valid           ;
  output                                          std__mgr18__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr18__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr18__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe18__oob_cntl            ;
  output                                          std__pe18__oob_valid           ;
  input                                           pe18__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe18__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe18__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr19__std__oob_cntl            ;
  input                                           mgr19__std__oob_valid           ;
  output                                          std__mgr19__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr19__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr19__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe19__oob_cntl            ;
  output                                          std__pe19__oob_valid           ;
  input                                           pe19__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe19__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe19__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr20__std__oob_cntl            ;
  input                                           mgr20__std__oob_valid           ;
  output                                          std__mgr20__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr20__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr20__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe20__oob_cntl            ;
  output                                          std__pe20__oob_valid           ;
  input                                           pe20__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe20__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe20__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr21__std__oob_cntl            ;
  input                                           mgr21__std__oob_valid           ;
  output                                          std__mgr21__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr21__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr21__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe21__oob_cntl            ;
  output                                          std__pe21__oob_valid           ;
  input                                           pe21__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe21__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe21__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr22__std__oob_cntl            ;
  input                                           mgr22__std__oob_valid           ;
  output                                          std__mgr22__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr22__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr22__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe22__oob_cntl            ;
  output                                          std__pe22__oob_valid           ;
  input                                           pe22__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe22__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe22__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr23__std__oob_cntl            ;
  input                                           mgr23__std__oob_valid           ;
  output                                          std__mgr23__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr23__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr23__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe23__oob_cntl            ;
  output                                          std__pe23__oob_valid           ;
  input                                           pe23__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe23__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe23__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr24__std__oob_cntl            ;
  input                                           mgr24__std__oob_valid           ;
  output                                          std__mgr24__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr24__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr24__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe24__oob_cntl            ;
  output                                          std__pe24__oob_valid           ;
  input                                           pe24__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe24__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe24__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr25__std__oob_cntl            ;
  input                                           mgr25__std__oob_valid           ;
  output                                          std__mgr25__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr25__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr25__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe25__oob_cntl            ;
  output                                          std__pe25__oob_valid           ;
  input                                           pe25__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe25__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe25__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr26__std__oob_cntl            ;
  input                                           mgr26__std__oob_valid           ;
  output                                          std__mgr26__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr26__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr26__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe26__oob_cntl            ;
  output                                          std__pe26__oob_valid           ;
  input                                           pe26__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe26__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe26__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr27__std__oob_cntl            ;
  input                                           mgr27__std__oob_valid           ;
  output                                          std__mgr27__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr27__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr27__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe27__oob_cntl            ;
  output                                          std__pe27__oob_valid           ;
  input                                           pe27__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe27__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe27__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr28__std__oob_cntl            ;
  input                                           mgr28__std__oob_valid           ;
  output                                          std__mgr28__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr28__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr28__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe28__oob_cntl            ;
  output                                          std__pe28__oob_valid           ;
  input                                           pe28__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe28__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe28__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr29__std__oob_cntl            ;
  input                                           mgr29__std__oob_valid           ;
  output                                          std__mgr29__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr29__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr29__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe29__oob_cntl            ;
  output                                          std__pe29__oob_valid           ;
  input                                           pe29__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe29__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe29__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr30__std__oob_cntl            ;
  input                                           mgr30__std__oob_valid           ;
  output                                          std__mgr30__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr30__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr30__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe30__oob_cntl            ;
  output                                          std__pe30__oob_valid           ;
  input                                           pe30__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe30__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe30__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr31__std__oob_cntl            ;
  input                                           mgr31__std__oob_valid           ;
  output                                          std__mgr31__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr31__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr31__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe31__oob_cntl            ;
  output                                          std__pe31__oob_valid           ;
  input                                           pe31__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe31__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe31__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr32__std__oob_cntl            ;
  input                                           mgr32__std__oob_valid           ;
  output                                          std__mgr32__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr32__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr32__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe32__oob_cntl            ;
  output                                          std__pe32__oob_valid           ;
  input                                           pe32__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe32__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe32__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr33__std__oob_cntl            ;
  input                                           mgr33__std__oob_valid           ;
  output                                          std__mgr33__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr33__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr33__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe33__oob_cntl            ;
  output                                          std__pe33__oob_valid           ;
  input                                           pe33__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe33__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe33__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr34__std__oob_cntl            ;
  input                                           mgr34__std__oob_valid           ;
  output                                          std__mgr34__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr34__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr34__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe34__oob_cntl            ;
  output                                          std__pe34__oob_valid           ;
  input                                           pe34__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe34__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe34__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr35__std__oob_cntl            ;
  input                                           mgr35__std__oob_valid           ;
  output                                          std__mgr35__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr35__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr35__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe35__oob_cntl            ;
  output                                          std__pe35__oob_valid           ;
  input                                           pe35__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe35__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe35__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr36__std__oob_cntl            ;
  input                                           mgr36__std__oob_valid           ;
  output                                          std__mgr36__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr36__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr36__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe36__oob_cntl            ;
  output                                          std__pe36__oob_valid           ;
  input                                           pe36__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe36__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe36__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr37__std__oob_cntl            ;
  input                                           mgr37__std__oob_valid           ;
  output                                          std__mgr37__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr37__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr37__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe37__oob_cntl            ;
  output                                          std__pe37__oob_valid           ;
  input                                           pe37__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe37__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe37__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr38__std__oob_cntl            ;
  input                                           mgr38__std__oob_valid           ;
  output                                          std__mgr38__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr38__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr38__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe38__oob_cntl            ;
  output                                          std__pe38__oob_valid           ;
  input                                           pe38__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe38__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe38__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr39__std__oob_cntl            ;
  input                                           mgr39__std__oob_valid           ;
  output                                          std__mgr39__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr39__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr39__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe39__oob_cntl            ;
  output                                          std__pe39__oob_valid           ;
  input                                           pe39__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe39__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe39__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr40__std__oob_cntl            ;
  input                                           mgr40__std__oob_valid           ;
  output                                          std__mgr40__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr40__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr40__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe40__oob_cntl            ;
  output                                          std__pe40__oob_valid           ;
  input                                           pe40__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe40__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe40__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr41__std__oob_cntl            ;
  input                                           mgr41__std__oob_valid           ;
  output                                          std__mgr41__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr41__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr41__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe41__oob_cntl            ;
  output                                          std__pe41__oob_valid           ;
  input                                           pe41__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe41__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe41__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr42__std__oob_cntl            ;
  input                                           mgr42__std__oob_valid           ;
  output                                          std__mgr42__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr42__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr42__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe42__oob_cntl            ;
  output                                          std__pe42__oob_valid           ;
  input                                           pe42__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe42__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe42__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr43__std__oob_cntl            ;
  input                                           mgr43__std__oob_valid           ;
  output                                          std__mgr43__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr43__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr43__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe43__oob_cntl            ;
  output                                          std__pe43__oob_valid           ;
  input                                           pe43__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe43__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe43__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr44__std__oob_cntl            ;
  input                                           mgr44__std__oob_valid           ;
  output                                          std__mgr44__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr44__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr44__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe44__oob_cntl            ;
  output                                          std__pe44__oob_valid           ;
  input                                           pe44__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe44__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe44__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr45__std__oob_cntl            ;
  input                                           mgr45__std__oob_valid           ;
  output                                          std__mgr45__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr45__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr45__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe45__oob_cntl            ;
  output                                          std__pe45__oob_valid           ;
  input                                           pe45__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe45__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe45__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr46__std__oob_cntl            ;
  input                                           mgr46__std__oob_valid           ;
  output                                          std__mgr46__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr46__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr46__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe46__oob_cntl            ;
  output                                          std__pe46__oob_valid           ;
  input                                           pe46__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe46__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe46__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr47__std__oob_cntl            ;
  input                                           mgr47__std__oob_valid           ;
  output                                          std__mgr47__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr47__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr47__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe47__oob_cntl            ;
  output                                          std__pe47__oob_valid           ;
  input                                           pe47__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe47__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe47__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr48__std__oob_cntl            ;
  input                                           mgr48__std__oob_valid           ;
  output                                          std__mgr48__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr48__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr48__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe48__oob_cntl            ;
  output                                          std__pe48__oob_valid           ;
  input                                           pe48__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe48__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe48__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr49__std__oob_cntl            ;
  input                                           mgr49__std__oob_valid           ;
  output                                          std__mgr49__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr49__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr49__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe49__oob_cntl            ;
  output                                          std__pe49__oob_valid           ;
  input                                           pe49__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe49__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe49__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr50__std__oob_cntl            ;
  input                                           mgr50__std__oob_valid           ;
  output                                          std__mgr50__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr50__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr50__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe50__oob_cntl            ;
  output                                          std__pe50__oob_valid           ;
  input                                           pe50__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe50__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe50__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr51__std__oob_cntl            ;
  input                                           mgr51__std__oob_valid           ;
  output                                          std__mgr51__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr51__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr51__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe51__oob_cntl            ;
  output                                          std__pe51__oob_valid           ;
  input                                           pe51__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe51__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe51__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr52__std__oob_cntl            ;
  input                                           mgr52__std__oob_valid           ;
  output                                          std__mgr52__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr52__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr52__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe52__oob_cntl            ;
  output                                          std__pe52__oob_valid           ;
  input                                           pe52__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe52__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe52__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr53__std__oob_cntl            ;
  input                                           mgr53__std__oob_valid           ;
  output                                          std__mgr53__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr53__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr53__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe53__oob_cntl            ;
  output                                          std__pe53__oob_valid           ;
  input                                           pe53__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe53__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe53__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr54__std__oob_cntl            ;
  input                                           mgr54__std__oob_valid           ;
  output                                          std__mgr54__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr54__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr54__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe54__oob_cntl            ;
  output                                          std__pe54__oob_valid           ;
  input                                           pe54__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe54__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe54__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr55__std__oob_cntl            ;
  input                                           mgr55__std__oob_valid           ;
  output                                          std__mgr55__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr55__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr55__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe55__oob_cntl            ;
  output                                          std__pe55__oob_valid           ;
  input                                           pe55__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe55__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe55__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr56__std__oob_cntl            ;
  input                                           mgr56__std__oob_valid           ;
  output                                          std__mgr56__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr56__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr56__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe56__oob_cntl            ;
  output                                          std__pe56__oob_valid           ;
  input                                           pe56__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe56__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe56__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr57__std__oob_cntl            ;
  input                                           mgr57__std__oob_valid           ;
  output                                          std__mgr57__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr57__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr57__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe57__oob_cntl            ;
  output                                          std__pe57__oob_valid           ;
  input                                           pe57__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe57__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe57__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr58__std__oob_cntl            ;
  input                                           mgr58__std__oob_valid           ;
  output                                          std__mgr58__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr58__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr58__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe58__oob_cntl            ;
  output                                          std__pe58__oob_valid           ;
  input                                           pe58__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe58__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe58__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr59__std__oob_cntl            ;
  input                                           mgr59__std__oob_valid           ;
  output                                          std__mgr59__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr59__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr59__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe59__oob_cntl            ;
  output                                          std__pe59__oob_valid           ;
  input                                           pe59__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe59__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe59__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr60__std__oob_cntl            ;
  input                                           mgr60__std__oob_valid           ;
  output                                          std__mgr60__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr60__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr60__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe60__oob_cntl            ;
  output                                          std__pe60__oob_valid           ;
  input                                           pe60__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe60__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe60__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr61__std__oob_cntl            ;
  input                                           mgr61__std__oob_valid           ;
  output                                          std__mgr61__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr61__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr61__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe61__oob_cntl            ;
  output                                          std__pe61__oob_valid           ;
  input                                           pe61__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe61__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe61__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr62__std__oob_cntl            ;
  input                                           mgr62__std__oob_valid           ;
  output                                          std__mgr62__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr62__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr62__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe62__oob_cntl            ;
  output                                          std__pe62__oob_valid           ;
  input                                           pe62__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe62__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe62__oob_data            ;

  // OOB controls how the lanes are interpreted                                  
  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr63__std__oob_cntl            ;
  input                                           mgr63__std__oob_valid           ;
  output                                          std__mgr63__oob_ready           ;
  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr63__std__oob_type            ;
  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr63__std__oob_data            ;

  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe63__oob_cntl            ;
  output                                          std__pe63__oob_valid           ;
  input                                           pe63__std__oob_ready           ;
  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe63__oob_type            ;
  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe63__oob_data            ;
