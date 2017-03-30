
  // OOB carries PE configuration                                           
  input [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl            ;
  input                                         std__pe__oob_valid           ;
  output                                        pe__std__oob_ready           ;
  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type            ;
  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data            ;
