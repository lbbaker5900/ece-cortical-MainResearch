
      // Stream 0                 
      assign  mrc_cntl_strm_inst[0].wud__mrc__valid        =  wud__mrc0__valid                      ; 
      assign  mrc_cntl_strm_inst[0].wud__mrc__cntl         =  wud__mrc0__cntl                       ; 
      assign  mrc_cntl_strm_inst[0].wud__mrc__tag          =  wud__mrc0__tag                        ; 
      assign  mrc0__wud__ready                             =  mrc_cntl_strm_inst[0].mrc__wud__ready ; 
      assign  mrc_cntl_strm_inst[0].wud__mrc__option_type  =  wud__mrc0__option_type                ; 
      assign  mrc_cntl_strm_inst[0].wud__mrc__option_value =  wud__mrc0__option_value               ; 

      // Stream 1                 
      assign  mrc_cntl_strm_inst[1].wud__mrc__valid        =  wud__mrc1__valid                      ; 
      assign  mrc_cntl_strm_inst[1].wud__mrc__cntl         =  wud__mrc1__cntl                       ; 
      assign  mrc_cntl_strm_inst[1].wud__mrc__tag          =  wud__mrc1__tag                        ; 
      assign  mrc1__wud__ready                             =  mrc_cntl_strm_inst[1].mrc__wud__ready ; 
      assign  mrc_cntl_strm_inst[1].wud__mrc__option_type  =  wud__mrc1__option_type                ; 
      assign  mrc_cntl_strm_inst[1].wud__mrc__option_value =  wud__mrc1__option_value               ; 
