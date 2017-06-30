
            // NoC port 0
            output   wire                                         mgr__noc__port0_valid            ,
            output   wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  mgr__noc__port0_cntl             ,
            output   wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  mgr__noc__port0_data             ,
            input    wire                                         noc__mgr__port0_fc               ,
            input    wire                                         noc__mgr__port0_valid            ,
            input    wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  noc__mgr__port0_cntl             ,
            input    wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__mgr__port0_data             ,
            output   wire                                         mgr__noc__port0_fc               ,
            input    wire   [`MGR_MGR_ID_BITMASK_RANGE         ]  sys__mgr__port0_destinationMask  ,

            // NoC port 1
            output   wire                                         mgr__noc__port1_valid            ,
            output   wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  mgr__noc__port1_cntl             ,
            output   wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  mgr__noc__port1_data             ,
            input    wire                                         noc__mgr__port1_fc               ,
            input    wire                                         noc__mgr__port1_valid            ,
            input    wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  noc__mgr__port1_cntl             ,
            input    wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__mgr__port1_data             ,
            output   wire                                         mgr__noc__port1_fc               ,
            input    wire   [`MGR_MGR_ID_BITMASK_RANGE         ]  sys__mgr__port1_destinationMask  ,

            // NoC port 2
            output   wire                                         mgr__noc__port2_valid            ,
            output   wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  mgr__noc__port2_cntl             ,
            output   wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  mgr__noc__port2_data             ,
            input    wire                                         noc__mgr__port2_fc               ,
            input    wire                                         noc__mgr__port2_valid            ,
            input    wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  noc__mgr__port2_cntl             ,
            input    wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__mgr__port2_data             ,
            output   wire                                         mgr__noc__port2_fc               ,
            input    wire   [`MGR_MGR_ID_BITMASK_RANGE         ]  sys__mgr__port2_destinationMask  ,

            // NoC port 3
            output   wire                                         mgr__noc__port3_valid            ,
            output   wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  mgr__noc__port3_cntl             ,
            output   wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  mgr__noc__port3_data             ,
            input    wire                                         noc__mgr__port3_fc               ,
            input    wire                                         noc__mgr__port3_valid            ,
            input    wire   [`COMMON_STD_INTF_CNTL_RANGE       ]  noc__mgr__port3_cntl             ,
            input    wire   [`MGR_NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__mgr__port3_data             ,
            output   wire                                         mgr__noc__port3_fc               ,
            input    wire   [`MGR_MGR_ID_BITMASK_RANGE         ]  sys__mgr__port3_destinationMask  ,

