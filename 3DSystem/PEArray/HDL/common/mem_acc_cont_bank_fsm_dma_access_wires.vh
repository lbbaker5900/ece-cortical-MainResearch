
  // DMA accesses
        wire read_pause        ;
        wire read_request      ;
        wire read_access       ;
        wire write_request     ;
        wire write_access      ;
        wire read_ready_strm   ;  // ignore all requests until we deassert ready
        wire write_ready_strm  ;  // ignore all requests until we deassert ready