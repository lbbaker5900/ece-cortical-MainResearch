
  // OOB carries PE configuration                                           
  input [`COMMON_STD_INTF_CNTL_RANGE     ]      sti__cntl__oob_cntl            ;
  input                                         sti__cntl__oob_valid           ;
  output                                        cntl__sti__oob_ready           ;
  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      sti__cntl__oob_type            ;
  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      sti__cntl__oob_data            ;