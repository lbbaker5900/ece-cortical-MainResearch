
  // DMA accesses
        // this banks dma channel
        wire read_pause        ;
        wire read_request      ;
        wire read_access       ;
        wire write_request     ;
        wire write_access      ;
        wire read_ready_strm   ;  // ignore all requests until we deassert ready
        wire write_ready_strm  ;  // ignore all requests until we deassert ready
        // dma channel 0
        wire read_pause0        ;
        wire read_request0      ;
        wire read_access0       ;
        wire write_request0     ;
        wire write_access0      ;
        wire read_ready_strm0   ;  // ignore all requests until we deassert ready
        wire write_ready_strm0  ;  // ignore all requests until we deassert ready