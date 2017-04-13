
   // Control-Path (cp) to NoC 
   wire                                             rdp__noc__cp_valid      ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__noc__cp_cntl       ; 
   wire                                             noc__rdp__cp_ready      ; 
   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__noc__cp_type       ; 
   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__noc__cp_ptype      ; 
   wire [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  rdp__noc__cp_desttype   ; 
   wire                                             rdp__noc__cp_pvalid     ; 
   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__noc__cp_data       ; 

   // Data-Path (dp) to NoC 
   wire                                             rdp__noc__dp_valid      ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ]  rdp__noc__dp_cntl       ; 
   wire                                             noc__rdp__dp_ready      ; 
   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  rdp__noc__dp_type       ; 
   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  rdp__noc__dp_ptype      ; 
   wire [`MGR_NOC_CONT_NOC_DEST_TYPE_RANGE       ]  rdp__noc__dp_desttype   ; 
   wire                                             rdp__noc__dp_pvalid     ; 
   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  rdp__noc__dp_data       ; 

   // Data-Path (cp) from NoC 
   wire                                             noc__mcntl__cp_valid    ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ]  noc__mcntl__cp_cntl     ; 
   wire                                             mcntl__noc__cp_ready    ; 
   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  noc__mcntl__cp_type     ; 
   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  noc__mcntl__cp_ptype    ; 
   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  noc__mcntl__cp_data     ; 
   wire [`MGR_MGR_ID_RANGE                       ]  noc__mcntl__cp_mgrId    ; 

   // Data-Path (dp) from NoC 
   wire                                             noc__mcntl__dp_valid    ; 
   wire [`COMMON_STD_INTF_CNTL_RANGE             ]  noc__mcntl__dp_cntl     ; 
   wire                                             mcntl__noc__dp_ready    ; 
   wire [`MGR_NOC_CONT_NOC_PACKET_TYPE_RANGE     ]  noc__mcntl__dp_type     ; 
   wire [`MGR_NOC_CONT_NOC_PAYLOAD_TYPE_RANGE    ]  noc__mcntl__dp_ptype    ; 
   wire [`MGR_NOC_CONT_INTERNAL_DATA_RANGE       ]  noc__mcntl__dp_data     ; 
   wire [`MGR_MGR_ID_RANGE                       ]  noc__mcntl__dp_mgrId    ; 
