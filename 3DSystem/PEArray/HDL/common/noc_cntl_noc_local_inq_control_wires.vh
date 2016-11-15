
  reg  [`NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  local_inq_type_fromNoc     ;  // latch as we need type to know whether to add EOD at end of current apcket transfer
  reg  [`NOC_CONT_NOC_PACKET_TYPE_RANGE    ]  local_inq_type_fromNoc_p1  ; 