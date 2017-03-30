
  // OOB carries PE configuration                                           
  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe__oob_cntl            ;
  wire                                        std__pe__oob_valid           ;
  wire                                        pe__std__oob_ready           ;
  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe__oob_type            ;
  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe__oob_data            ;