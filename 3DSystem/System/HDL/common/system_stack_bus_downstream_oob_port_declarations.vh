
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
