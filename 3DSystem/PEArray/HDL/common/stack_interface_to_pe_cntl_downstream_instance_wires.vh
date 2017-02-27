
  // OOB carries PE configuration                                           
  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      sti__cntl__oob_cntl            ;
  wire                                        sti__cntl__oob_valid           ;
  wire                                        cntl__sti__oob_ready           ;
  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      sti__cntl__oob_type            ;
  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      sti__cntl__oob_data            ;