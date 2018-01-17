#! /usr/bin/env python

if __name__ == "__main__":

  import sys
  import os
  import math
  import random
  import re

  # extract number of mgr's

  # extract number of pe's
  FoundPe = False
  searchFile = open("../../PEArray/HDL/common/pe_array.vh", "r")
  for line in searchFile:
    if FoundPe == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_ARRAY_NUM_OF_PE" in data[1]:
        numOfPe = int(data[2])
        FoundPe = True
  searchFile.close()
  numOfMgr = numOfPe

  # Number of execution lanes in a PE
  FoundLane = False
  searchFile = open("../../PEArray/HDL/common/pe.vh", "r")
  for line in searchFile:
    if FoundLane == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_EXEC_LANES" in data[1]:
        numOfExecLanes = int(data[2])
        FoundLane = True
  searchFile.close()

  # Number of streams 
  FoundStrm = False
  searchFile = open("../../PEArray/HDL/common/pe.vh", "r")
  for line in searchFile:
    if FoundStrm == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_STREAMS" in data[1]:
        numOfStrms = int(data[2])
        FoundStrm = True
  searchFile.close()

  # Now extract number of noc ports
  FoundPorts = False
  searchFile = open("../../PEArray/HDL/common/noc_cntl.vh", "r")
  for line in searchFile:
    if FoundPorts == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "NOC_CONT_NOC_NUM_OF_PORTS" in data[1]:
        numOfPorts = int(data[2])
        FoundPorts = True
  searchFile.close()



  FoundNumOfChannelsPerDram = False
  searchFile = open("../../Manager/HDL/common/manager.vh", "r")
  for line in searchFile:
    if FoundNumOfChannelsPerDram == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "MGR_DRAM_NUM_CHANNELS" in data[1]:
        numOfChannels = int(data[2])
        FoundNumOfChannelsPerDram = True
  searchFile.close()


  FoundNumOfBanksPerDram = False
  searchFile = open("../../Manager/HDL/common/manager.vh", "r")
  for line in searchFile:
    if FoundNumOfBanksPerDram == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "MGR_DRAM_NUM_BANKS" in data[1]:
        numOfBanks = int(data[2])
        FoundNumOfBanksPerDram = True
  searchFile.close()


  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ## System Verilog Testbench files





  f = open('../SIMULATION/common/TB_system_general_assignments.vh', 'w')
  pLine = ""
  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                                     '
    pLine = pLine + '\n  //  - doesnt seem to work if you use cb_test for observed signals                                 '
    pLine = pLine + '\n  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.   '
    pLine = pLine + '\n  assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__sys__allSynchronized   =  GenStackBus[{0}].sys__pe__allSynchronized                                ; '.format(pe) 
    pLine = pLine + '\n  assign GenStackBus[{0}].pe__sys__thisSynchronized                               =  system_inst.manager_array_inst.mgr_inst[{0}].sys__mgr__thisSynchronized  ; '.format(pe) 
    pLine = pLine + '\n  assign GenStackBus[{0}].pe__sys__ready                                          =  system_inst.manager_array_inst.mgr_inst[{0}].sys__mgr__ready             ; '.format(pe) 
    pLine = pLine + '\n  assign GenStackBus[{0}].pe__sys__complete                                       =  system_inst.manager_array_inst.mgr_inst[{0}].sys__mgr__complete          ; '.format(pe) 
    pLine = pLine + '\n'
    #                                                                                                    
                                             
  f.write(pLine)
  f.close()


  f = open('../SIMULATION/common/TB_system_stack_bus_downstream_oob_assignments.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #                                                                                                    
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                                     '
    pLine = pLine + '\n  //  - doesnt seem to work if you use cb_test for observed signals                                 '
    pLine = pLine + '\n  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         ' 
    pLine = pLine + '\n  assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__std__oob_cntl           =   DownstreamStackBusOOB[{0}].std__pe__oob_cntl             ; '.format(pe) 
    pLine = pLine + '\n  assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__std__oob_valid          =   DownstreamStackBusOOB[{0}].std__pe__oob_valid            ; '.format(pe) 
    pLine = pLine + '\n  assign DownstreamStackBusOOB[{0}].pe__std__oob_ready                             =   system_inst.manager_array_inst.mgr_inst[{0}].std__mgr__oob_ready ; '.format(pe) 
    pLine = pLine + '\n  assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__std__oob_type           =   DownstreamStackBusOOB[{0}].std__pe__oob_type             ; '.format(pe) 
    pLine = pLine + '\n  assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__std__oob_data           =   DownstreamStackBusOOB[{0}].std__pe__oob_data             ; '.format(pe) 
    # 
                                             
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_stack_bus_downstream_assignments.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n        // PE {1}, Lane {0}                 '.format(lane,pe)
      for strm in range (0, numOfStrms):
        pLine = pLine + '\n        //  - doesnt seem to work if you use cb_test for observed signals '
        pLine = pLine + '\n        assign DownstreamStackBusLane[{0}][{1}][{2}].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst[{2}].mrc_cntl.std__mrc__lane_ready [{1}]    ;'.format(pe,lane,strm)
        pLine = pLine + '\n        always @(*)'
        pLine = pLine + '\n          begin'
        pLine = pLine + '\n            system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst[{2}].mrc_cntl.mrc__std__lane_cntl_e1 [{1}]  =   DownstreamStackBusLane[{0}][{1}][{2}].std__pe__lane_strm_cntl       ;'.format(pe,lane,strm)
        pLine = pLine + '\n            system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst[{2}].mrc_cntl.mrc__std__lane_data_e1 [{1}]  =   DownstreamStackBusLane[{0}][{1}][{2}].std__pe__lane_strm_data       ;'.format(pe,lane,strm)
        pLine = pLine + '\n            system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst[{2}].mrc_cntl.mrc__std__lane_valid_e1[{1}]  =   DownstreamStackBusLane[{0}][{1}][{2}].std__pe__lane_strm_data_valid ;'.format(pe,lane,strm)
        pLine = pLine + '\n          end'
        pLine = pLine + '\n        '
                                             
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_stack_bus_downstream_observe.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n        // PE {1}, Lane {0}                 '.format(lane,pe)
      for strm in range (0, numOfStrms):
        pLine = pLine + '\n        //  - doesnt seem to work if you use cb_test for observed signals '
        pLine = pLine + '\n        assign DownstreamStackBusLane[{0}][{1}][{2}].pe__std__lane_strm_ready   =   system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst[{2}].mrc_cntl.std__mrc__lane_ready [{1}]    ;'.format(pe,lane,strm)
        pLine = pLine + '\n        always @(*)'
        pLine = pLine + '\n          begin'
        pLine = pLine + '\n            DownstreamStackBusLane[{0}][{1}][{2}].std__pe__lane_strm_cntl       =   system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst[{2}].mrc_cntl.mrc__std__lane_cntl_e1 [{1}]  ;'.format(pe,lane,strm)
        pLine = pLine + '\n            DownstreamStackBusLane[{0}][{1}][{2}].std__pe__lane_strm_data       =   system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst[{2}].mrc_cntl.mrc__std__lane_data_e1 [{1}]  ;'.format(pe,lane,strm)
        pLine = pLine + '\n            DownstreamStackBusLane[{0}][{1}][{2}].std__pe__lane_strm_data_valid =   system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst[{2}].mrc_cntl.mrc__std__lane_valid_e1[{1}]  ;'.format(pe,lane,strm)
        pLine = pLine + '\n          end'
        pLine = pLine + '\n        '
                                             
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_stack_bus_upstream_assignments.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
        pLine = pLine + '\n        //  - doesnt seem to work if you use cb_test for observed signals '
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__valid                                =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__valid    ;      '.format(pe)
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__cntl                                 =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__cntl     ;      '.format(pe)
        pLine = pLine + '\n        // manager module stu_cntl now driving ready, so just capture state of ready                                                                                                          '
        pLine = pLine + '\n        //assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__stu__ready        =   1\'b1                                                           ;      '.format(pe)
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].stu__pe__ready                                =   system_inst.manager_array_inst.mgr_inst[{0}].mgr__stu__ready    ;      '.format(pe)
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__type                                 =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__type     ;      '.format(pe)
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__data                                 =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__data     ;      '.format(pe)
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__oob_data                             =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__oob_data ;      '.format(pe)
        pLine = pLine + '\n        '
                                             
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_local_toNoc_checker_packet_grab.vh', 'w')
  pLine = ""
  for mgr in range (0, numOfMgr):
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          forever'
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              // Observe NoC packets sent from manager {0}'.format(mgr)
    pLine = pLine + '\n              @(vLocalToNoC[{0}].cb_p);'.format(mgr)
    pLine = pLine + '\n              if ((vLocalToNoC[{0}].locl__noc__dp_valid == 1\'b1))'.format(mgr)
    pLine = pLine + '\n                begin'
    pLine = pLine + '\n                  // Start of packet observed, create new noc packet object and start to fill the fields'
    pLine = pLine + '\n                  local_noc_pkt_sent [{0}] = new();'.format(mgr)
    pLine = pLine + '\n                  noc_sent_packet_complete[{0}] = 0;    '.format(mgr)
    pLine = pLine + '\n                  while(~noc_sent_packet_complete[{0}])     '.format(mgr)
    pLine = pLine + '\n                    begin'
    pLine = pLine + '\n                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {{%0d}}", $time, `__FILE__, `__LINE__, {0});'.format(mgr)
    pLine = pLine + '\n                      //------------------------------'
    pLine = pLine + '\n                      // Examine the header '
    pLine = pLine + '\n                      if ((vLocalToNoC[{0}].locl__noc__dp_valid == 1\'b1) && (vLocalToNoC[{0}].locl__noc__dp_cntl == 2\'b01))  // start-of-packet'.format(mgr)
    pLine = pLine + '\n                        begin'
    pLine = pLine + '\n                          local_noc_pkt_sent [{0}].timeTag              = $time;'.format(mgr)
    pLine = pLine + '\n                          local_noc_pkt_sent [{0}].header_destination_address  = vLocalToNoC[{0}].locl__noc__dp_data     ;'.format(mgr)
    pLine = pLine + '\n                          local_noc_pkt_sent [{0}].header_source               = {0}                                     ;'.format(mgr)
    pLine = pLine + '\n                          local_noc_pkt_sent [{0}].header_address_type         = vLocalToNoC[{0}].locl__noc__dp_desttype ;'.format(mgr)
    pLine = pLine + '\n                          local_noc_pkt_sent [{0}].header_priority             = 1\'b1                                   ;  // _dp is hi-priority'.format(mgr)
    pLine = pLine + '\n                        end'
    pLine = pLine + '\n                      //------------------------------'
    pLine = pLine + '\n                      // Examine the payload '
    pLine = pLine + '\n                      else '
    pLine = pLine + '\n                        begin'
    pLine = pLine + '\n                          if ((vLocalToNoC[{0}].locl__noc__dp_valid == 1\'b1) && (vLocalToNoC[{0}].locl__noc__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple '.format(mgr)
    pLine = pLine + '\n                            begin'
    pLine = pLine + '\n                              // Grab first tuple'
    pLine = pLine + '\n                              //payload_tuple_type       [{0}] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;'.format(mgr)
    pLine = pLine + '\n                              //payload_tuple_extd_value [{0}] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;'.format(mgr)
    pLine = pLine + '\n                              payload_tuple_type       [{0}] = vLocalToNoC[{0}].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;'.format(mgr)
    pLine = pLine + '\n                              payload_tuple_extd_value [{0}] = vLocalToNoC[{0}].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;'.format(mgr)
    pLine = pLine + '\n                              local_noc_pkt_sent [{0}].payload_tuple_type.push_back      (payload_tuple_type      [{0}])    ;'.format(mgr)
    pLine = pLine + '\n                              local_noc_pkt_sent [{0}].payload_tuple_extd_value.push_back(payload_tuple_extd_value[{0}])    ;'.format(mgr)
    pLine = pLine + '\n                              // check if both tuples are valid'
    pLine = pLine + '\n                              if (vLocalToNoC[{0}].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple '.format(mgr)
    pLine = pLine + '\n                                begin'
    pLine = pLine + '\n                                  // Grab second tuple'
    pLine = pLine + '\n                                  //payload_tuple_type       [{0}] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;'.format(mgr)
    pLine = pLine + '\n                                  //payload_tuple_extd_value [{0}] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;'.format(mgr)
    pLine = pLine + '\n                                  payload_tuple_type       [{0}] = vLocalToNoC[{0}].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;'.format(mgr)
    pLine = pLine + '\n                                  payload_tuple_extd_value [{0}] = vLocalToNoC[{0}].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;'.format(mgr)
    pLine = pLine + '\n                                  local_noc_pkt_sent [{0}].payload_tuple_type.push_back      (payload_tuple_type      [{0}])    ;'.format(mgr)
    pLine = pLine + '\n                                  local_noc_pkt_sent [{0}].payload_tuple_extd_value.push_back(payload_tuple_extd_value[{0}])    ;'.format(mgr)
    pLine = pLine + '\n                                end'
    pLine = pLine + '\n                            end'
    pLine = pLine + '\n                          else if (vLocalToNoC[{0}].locl__noc__dp_valid == 1\'b1) // payload is data '.format(mgr)
    pLine = pLine + '\n                            begin'
    pLine = pLine + '\n                              // Grab first data word'
    pLine = pLine + '\n                              payload_data    [{0}] = vLocalToNoC[{0}].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;'.format(mgr)
    pLine = pLine + '\n                              local_noc_pkt_sent [{0}].payload_data.push_back (payload_data      [{0}])    ;'.format(mgr)
    pLine = pLine + '\n                              // check if both tuples are valid'
    pLine = pLine + '\n                              if (vLocalToNoC[{0}].locl__noc__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple '.format(mgr)
    pLine = pLine + '\n                                begin'
    pLine = pLine + '\n                                  // Grab second data word'
    pLine = pLine + '\n                                  payload_data    [{0}] = vLocalToNoC[{0}].locl__noc__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;'.format(mgr)
    pLine = pLine + '\n                                  local_noc_pkt_sent [{0}].payload_data.push_back (payload_data      [{0}])    ;'.format(mgr)
    pLine = pLine + '\n                                end'
    pLine = pLine + '\n                            end'
    pLine = pLine + '\n                        end'
    pLine = pLine + '\n                      //------------------------------'
    pLine = pLine + '\n                      // Check if this is the end of the packet'
    pLine = pLine + '\n                      if ((vLocalToNoC[{0}].locl__noc__dp_valid == 1\'b1) && (vLocalToNoC[{0}].locl__noc__dp_cntl == 2\'b10)) // end of packet'.format(mgr)
    pLine = pLine + '\n                        begin'
    pLine = pLine + '\n                          // packet complete, now determine all destination and place packet in their mailbox'
    pLine = pLine + '\n                          for (int dm=0; dm<`MGR_ARRAY_NUM_OF_MGR; dm++) '
    pLine = pLine + '\n                            begin'
    pLine = pLine + '\n                              if (local_noc_pkt_sent [{0}].header_destination_address[dm] == 1\'b1)'.format(mgr)
    pLine = pLine + '\n                                begin'
    pLine = pLine + '\n                                  $display ("@%0t::%s:%0d:: INFO: NoC Packet sent from {{%0d}} to {{%0d}}", $time, `__FILE__, `__LINE__, {0}, dm);'.format(mgr)
    pLine = pLine + '\n                                  mgr2noc_p [dm].put(local_noc_pkt_sent [{0}]);'.format(mgr)
    pLine = pLine + '\n                                  local_noc_pkt_sent [{0}].displayPacket;'.format(mgr)
    pLine = pLine + '\n                                end'
    pLine = pLine + '\n                            end'
    pLine = pLine + '\n                          noc_sent_packet_complete[{0}] = 1;    '.format(mgr)
    pLine = pLine + '\n                        end'
    pLine = pLine + '\n                      @(vLocalToNoC[{0}].cb_p);'.format(mgr)
    pLine = pLine + '\n                    end  // while'
    pLine = pLine + '\n                end'
    pLine = pLine + '\n            end'
    pLine = pLine + '\n        end'
    pLine = pLine + '\n    '
    #                                                                                                    
                                             
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_local_fromNoc_checker_packet_grab.vh', 'w')
  pLine = ""
  for mgr in range (0, numOfMgr):
    pLine = pLine + '\n        begin'
    pLine = pLine + '\n          forever'
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              // Observe NoC packets received by manager {0}'.format(mgr)
    pLine = pLine + '\n              @(vLocalFromNoC[{0}].cb_p);'.format(mgr)
    pLine = pLine + '\n              if ((vLocalFromNoC[{0}].noc__locl__dp_valid == 1\'b1))'.format(mgr)
    pLine = pLine + '\n                begin'
    pLine = pLine + '\n                  // Start of packet observed, create new noc packet object and start to fill the fields'
    pLine = pLine + '\n                  local_noc_pkt_rcvd [{0}] = new();'.format(mgr)
    pLine = pLine + '\n                  noc_rcvd_packet_complete[{0}] = 0;    '.format(mgr)
    pLine = pLine + '\n                  while(~noc_rcvd_packet_complete[{0}])     '.format(mgr)
    pLine = pLine + '\n                    begin'
    pLine = pLine + '\n                      //$display ("@%0t::%s:%0d:: INFO: NoC Packet transaction from {{%0d}}", $time, `__FILE__, `__LINE__, {0});'.format(mgr)
    pLine = pLine + '\n                      //------------------------------'
    pLine = pLine + '\n                      // Examine the header '
    pLine = pLine + '\n                      if ((vLocalFromNoC[{0}].noc__locl__dp_valid == 1\'b1) && (vLocalFromNoC[{0}].noc__locl__dp_cntl == 2\'b01))  // start-of-packet'.format(mgr)
    pLine = pLine + '\n                        begin'
    pLine = pLine + '\n                          local_noc_pkt_rcvd [{0}].timeTag                     = $time;'.format(mgr)
    pLine = pLine + '\n                          local_noc_pkt_rcvd [{0}].header_destination_address  = vLocalFromNoC[{0}].noc__locl__dp_data     ;'.format(mgr)
    pLine = pLine + '\n                          local_noc_pkt_rcvd [{0}].header_source               = vLocalFromNoC[{0}].noc__locl__dp_mgrId    ;'.format(mgr)
    pLine = pLine + '\n                          local_noc_pkt_rcvd [{0}].header_priority             = 1\'b1                                   ;  // _dp is hi-priority'.format(mgr)
    pLine = pLine + '\n                        end'
    pLine = pLine + '\n                      //------------------------------'
    pLine = pLine + '\n                      // Examine the payload '
    pLine = pLine + '\n                      else '
    pLine = pLine + '\n                        begin'
    pLine = pLine + '\n                          if ((vLocalFromNoC[{0}].noc__locl__dp_valid == 1\'b1) && (vLocalFromNoC[{0}].noc__locl__dp_ptype == `MGR_NOC_CONT_PAYLOAD_TYPE_TUPLES)) // payload is tuple '.format(mgr)
    pLine = pLine + '\n                            begin'
    pLine = pLine + '\n                              // Grab first tuple'
    pLine = pLine + '\n                              //payload_tuple_type       [{0}] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;'.format(mgr)
    pLine = pLine + '\n                              //payload_tuple_extd_value [{0}] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;'.format(mgr)
    pLine = pLine + '\n                              payload_tuple_type       [{0}] = vLocalFromNoC[{0}].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION0_RANGE   ]   ;'.format(mgr)
    pLine = pLine + '\n                              payload_tuple_extd_value [{0}] = vLocalFromNoC[{0}].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE ]   ;'.format(mgr)
    pLine = pLine + '\n                              local_noc_pkt_rcvd [{0}].payload_tuple_type.push_back      (payload_tuple_type      [{0}])    ;'.format(mgr)
    pLine = pLine + '\n                              local_noc_pkt_rcvd [{0}].payload_tuple_extd_value.push_back(payload_tuple_extd_value[{0}])    ;'.format(mgr)
    pLine = pLine + '\n                              // check if both tuples are valid'
    pLine = pLine + '\n                              if (vLocalFromNoC[{0}].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple '.format(mgr)
    pLine = pLine + '\n                                begin'
    pLine = pLine + '\n                                  // Grab second tuple'
    pLine = pLine + '\n                                  //payload_tuple_type       [{0}] = new  [`MGR_WU_OPT_TYPE_WIDTH       ]   ;'.format(mgr)
    pLine = pLine + '\n                                  //payload_tuple_extd_value [{0}] = new  [`MGR_WU_EXTD_OPT_VALUE_WIDTH ]   ;'.format(mgr)
    pLine = pLine + '\n                                  payload_tuple_type       [{0}] = vLocalFromNoC[{0}].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_OPTION1_RANGE   ]   ;'.format(mgr)
    pLine = pLine + '\n                                  payload_tuple_extd_value [{0}] = vLocalFromNoC[{0}].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE ]   ;'.format(mgr)
    pLine = pLine + '\n                                  local_noc_pkt_rcvd [{0}].payload_tuple_type.push_back      (payload_tuple_type      [{0}])    ;'.format(mgr)
    pLine = pLine + '\n                                  local_noc_pkt_rcvd [{0}].payload_tuple_extd_value.push_back(payload_tuple_extd_value[{0}])    ;'.format(mgr)
    pLine = pLine + '\n                                end'
    pLine = pLine + '\n                            end'
    pLine = pLine + '\n                          else if (vLocalFromNoC[{0}].noc__locl__dp_valid == 1\'b1) // payload is data '.format(mgr)
    pLine = pLine + '\n                            begin'
    pLine = pLine + '\n                              // Grab first data word'
    pLine = pLine + '\n                              payload_data    [{0}] = vLocalFromNoC[{0}].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD0_RANGE  ]   ;'.format(mgr)
    pLine = pLine + '\n                              local_noc_pkt_rcvd [{0}].payload_data.push_back (payload_data      [{0}])    ;'.format(mgr)
    pLine = pLine + '\n                              // check if both tuples are valid'
    pLine = pLine + '\n                              if (vLocalFromNoC[{0}].noc__locl__dp_pvalid == `MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_BOTH) // payload is tuple '.format(mgr)
    pLine = pLine + '\n                                begin'
    pLine = pLine + '\n                                  // Grab second data word'
    pLine = pLine + '\n                                  payload_data    [{0}] = vLocalFromNoC[{0}].noc__locl__dp_data[`MGR_NOC_CONT_INTERNAL_DATA_CYCLE_WORD1_RANGE  ]   ;'.format(mgr)
    pLine = pLine + '\n                                  local_noc_pkt_rcvd [{0}].payload_data.push_back (payload_data      [{0}])    ;'.format(mgr)
    pLine = pLine + '\n                                end'
    pLine = pLine + '\n                            end'
    pLine = pLine + '\n                        end'
    pLine = pLine + '\n                      //------------------------------'
    pLine = pLine + '\n                      // Check if this is the end of the packet'
    pLine = pLine + '\n                      if ((vLocalFromNoC[{0}].noc__locl__dp_valid == 1\'b1) && (vLocalFromNoC[{0}].noc__locl__dp_cntl == 2\'b10)) // end of packet'.format(mgr)
    pLine = pLine + '\n                        begin'
    pLine = pLine + '\n                          // packet complete, if source is another SSC, now place in manager received mailbox so it can be matched with a sent packet'
    pLine = pLine + '\n                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {{%0d}} from {{%0d}}", $time, `__FILE__, `__LINE__, {0}, local_noc_pkt_rcvd [{0}].header_source);'.format(mgr)
    pLine = pLine + '\n                          if (local_noc_pkt_rcvd [{0}].header_source != `MGR_ARRAY_HOST_ID)'.format(mgr)
    pLine = pLine + '\n                            begin'
    pLine = pLine + '\n                              noc2mgr_p [{0}].put(local_noc_pkt_rcvd [{0}]);'.format(mgr)
    pLine = pLine + '\n                              local_noc_pkt_rcvd [{0}].displayPacket;'.format(mgr)
    pLine = pLine + '\n                            end'
    pLine = pLine + '\n                          noc_rcvd_packet_complete[{0}] = 1;    '.format(mgr)
    pLine = pLine + '\n                        end'
    pLine = pLine + '\n                      @(vLocalFromNoC[{0}].cb_p);'.format(mgr)
    pLine = pLine + '\n                    end  // while'
    pLine = pLine + '\n                end'
    pLine = pLine + '\n            end // forever'
    pLine = pLine + '\n        end'
    pLine = pLine + '\n    '
    #                                                                                                    
                                             
  f.write(pLine)
  f.close()
  f = open('../SIMULATION/common/TB_system_start_running_processes.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for strm in range (0, numOfStrms):
      pLine = pLine + '\n            begin'
      pLine = pLine + '\n              mr_proc[{0}][{1}].run()  ;'.format(pe,strm) 
      pLine = pLine + '\n            end'                                    
      pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  f = open('../SIMULATION/common/TB_system_dram_load.vh', 'w')
  pLine = ""

  #pLine = pLine + '\n    case (m)'
  #for word in range (0, 64):
  #  pLine = pLine + '\n         {2}:'.format(mgr,chan, word)
  #  pLine = pLine + '\n           begin'
  pLine = pLine + '\n    case (mgr)'
  for mgr in range (0, numOfMgr):
    pLine = pLine + '\n         {0}:'.format(mgr)
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              case (chan)'
    #for chan in range (0, numOfChannels ):
    pLine = pLine + '\n                 0:'.format(mgr)
    pLine = pLine + '\n                    begin'
    pLine = pLine + '\n                      diram.diram_port_arrays[{0}].diram_inst.ram_even.ram.mem[config_intf_word][config_burst][config_index]  = config_data ;'.format(mgr)
    pLine = pLine + '\n                    end'                                    
    pLine = pLine + '\n                 1:'.format(mgr)
    pLine = pLine + '\n                    begin'
    pLine = pLine + '\n                      diram.diram_port_arrays[{0}].diram_inst.ram_odd.ram.mem[config_intf_word][config_burst][config_index]  = config_data ;'.format(mgr)
    pLine = pLine + '\n                    end'                                    
    pLine = pLine + '\n              endcase'
    pLine = pLine + '\n            end'
  pLine = pLine + '\n    endcase'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_dram_read.vh', 'w')
  pLine = ""

  pLine = pLine + '\n    case (mgr)'
  for mgr in range (0, numOfMgr):
    pLine = pLine + '\n         {0}:'.format(mgr)
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              case (chan)'
    #for chan in range (0, numOfChannels ):
    pLine = pLine + '\n                 0:'.format(mgr)
    pLine = pLine + '\n                    begin'
    pLine = pLine + '\n                      status_read_data = diram.diram_port_arrays[{0}].diram_inst.ram_even.ram.mem[config_intf_word][config_burst][config_index]  ;'.format(mgr)
    pLine = pLine + '\n                    end'                                    
    pLine = pLine + '\n                 1:'.format(mgr)
    pLine = pLine + '\n                    begin'
    pLine = pLine + '\n                      status_read_data = diram.diram_port_arrays[{0}].diram_inst.ram_odd.ram.mem[config_intf_word][config_burst][config_index]  ;'.format(mgr)
    pLine = pLine + '\n                    end'                                    
    pLine = pLine + '\n              endcase'
    pLine = pLine + '\n            end'
  pLine = pLine + '\n    endcase'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_dram_entry_status.vh', 'w')
  pLine = ""

  pLine = pLine + '\n    case (mgr)'
  for mgr in range (0, numOfMgr):
    pLine = pLine + '\n         {0}:'.format(mgr)
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              case (chan)'
    #for chan in range (0, numOfChannels ):
    pLine = pLine + '\n                 0:'.format(mgr)
    pLine = pLine + '\n                    begin'
    pLine = pLine + '\n                      status_entry = diram.diram_port_arrays[{0}].diram_inst.ram_even.ram.mem[config_intf_word][config_burst].exists(config_index)  ;'.format(mgr)
    pLine = pLine + '\n                    end'                                    
    pLine = pLine + '\n                 1:'.format(mgr)
    pLine = pLine + '\n                    begin'
    pLine = pLine + '\n                      status_entry = diram.diram_port_arrays[{0}].diram_inst.ram_odd.ram.mem[config_intf_word][config_burst].exists(config_index)  ;'.format(mgr)
    pLine = pLine + '\n                    end'                                    
    pLine = pLine + '\n              endcase'
    pLine = pLine + '\n            end'
  pLine = pLine + '\n    endcase'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_gate_sim_load_readmem.vh', 'w')
  pLine = ""

  for mgr in range (0, numOfMgr):
    pLine = pLine + '\n                  if (mgr == {0})'.format(mgr)
    pLine = pLine + '\n                    begin'
    pLine = pLine + '\n                      $display ("@%0t::%s:%0d:: INFO: Loading Memories of gate level Manager {{%0d}}", $time, `__FILE__, `__LINE__, {0});'.format(mgr)
    for strm in range (0, numOfStrms):
      pLine = pLine + '\n                      //----------------------------------------------------------------------------------------------------'
      pLine = pLine + '\n                      // MRC {0} sdp_request_cntl'.format(strm)
      pLine = pLine + '\n                      $readmemh( "./inputFiles/manager_{0}_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst_{1}__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);'.format(mgr,strm)
      pLine = pLine + '\n                      $readmemh( "./inputFiles/manager_{0}_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[{0}].manager.mrc_cntl_strm_inst_{1}__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);'.format(mgr,strm)
      pLine = pLine + '\n                      '
    pLine = pLine + '\n                      //----------------------------------------------------------------------------------------------------'
    pLine = pLine + '\n                      // MWC sdp_request_cntl'
    pLine = pLine + '\n                      $readmemh( "./inputFiles/manager_{0}_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[{0}].manager.mwc_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);'.format(mgr,strm)
    pLine = pLine + '\n                      $readmemh( "./inputFiles/manager_{0}_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[{0}].manager.mwc_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);'.format(mgr,strm)
    pLine = pLine + '\n                      '
    pLine = pLine + '\n                      //----------------------------------------------------------------------------------------------------'
    pLine = pLine + '\n                      // wu_memory'
    pLine = pLine + '\n                      $readmemh( "./inputFiles/manager_{0}_layer1_instruction_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[{0}].manager.wu_memory.instruction_mem_0__gmemory.dw_mem_mem1p4096x57.u0.mem_core_array);'.format(mgr)
    pLine = pLine + '\n                    end'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_gate_sim_connect_to_dma.vh', 'w')
  pLine = ""
  for mgr in range (0, numOfMgr):
    for lane in range (0, numOfExecLanes ):

       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].dma__memc__write_valid      = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.dma__memc__write_valid0        ;'.format(mgr,lane)
       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].dma__memc__write_address    = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.dma__memc__write_address0      ;'.format(mgr,lane)
       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].dma__memc__write_data       = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.dma__memc__write_data0         ;'.format(mgr,lane)
       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].dma__memc__read_valid       = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.dma__memc__read_valid0         ;'.format(mgr,lane)
       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].dma__memc__read_address     = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.dma__memc__read_address0       ;'.format(mgr,lane)
       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].dma__memc__read_pause       = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.dma__memc__read_pause0         ;'.format(mgr,lane)
                         
       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].memc__dma__write_ready      = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.memc__dma__write_ready0        ;'.format(mgr,lane)
       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].memc__dma__read_data        = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.memc__dma__read_data0          ;'.format(mgr,lane)
       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].memc__dma__read_data_valid  = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.memc__dma__read_data_valid0    ;'.format(mgr,lane)
       pLine = pLine + '\n                            assign Dma2Mem[{0}][{1}].memc__dma__read_ready       = system_inst.pe_array_inst.pe_inst[{0}].pe.stOp_lane_{1}__streamingOps_datapath.dma_cont.memc__dma__read_ready0         ;'.format(mgr,lane)

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_pe_cntl_stop_memory_load.vh', 'w')
  pLine = ""

  pLine = pLine + '\n    case (mgr)'
  for mgr in range (0, numOfMgr):
    pLine = pLine + '\n         {0}:'.format(mgr)
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              `ifdef TB_USES_PE_GATE_NETLIST'
    pLine = pLine + '\n                $readmemh(\"./inputFiles/pe{0}_pe_cntl_stOp_memory.dat\", top.system_inst.pe_array_inst.pe_inst[{0}].pe.pe_cntl.stOp_option_memory_0__gmemory.dw_mem_mem2prf256x149.u0.mem_core_array) ;'.format(mgr)
    pLine = pLine + '\n              `else'
    pLine = pLine + '\n                memFile = \"./inputFiles/pe{0}_pe_cntl_stOp_memory.dat\";'.format(mgr)
    pLine = pLine + '\n                fileDesc = $fopen (memFile, "r");'.format(mgr)
    pLine = pLine + '\n                if (fileDesc == 0)'.format(mgr)
    pLine = pLine + '\n                  begin'.format(mgr)
    pLine = pLine + '\n                    $display("ERROR:generic_1port_memory:LEE:readmem file error : %s ", memFile);'.format(mgr)
    pLine = pLine + '\n                    $finish;'.format(mgr)
    pLine = pLine + '\n                  end'.format(mgr)
    pLine = pLine + '\n                while (!$feof(fileDesc)) '.format(mgr)
    pLine = pLine + '\n                  begin '.format(mgr)
    pLine = pLine + '\n                    void\'($fgets(entry, fileDesc)); '.format(mgr)
    pLine = pLine + '\n                    void\'($sscanf(entry, "@%x %x", memory_address, memory_data));'.format(mgr)
    pLine = pLine + '\n                    //$display("ERROR:LEE:readmem file contents : %s  : Addr:%h, Data:%h", memFile, memory_address, memory_data);'.format(mgr)
    pLine = pLine + '\n                    system_inst.pe_array_inst.pe_inst[{0}].pe.pe_cntl.stOp_option_memory[0].gmemory.mem[memory_address] = memory_data ;'.format(mgr)
    pLine = pLine + '\n                  end'.format(mgr)
    pLine = pLine + '\n                $fclose(fileDesc);'.format(mgr)
    pLine = pLine + '\n              `endif'
    pLine = pLine + '\n            end'
  pLine = pLine + '\n    endcase'

  f.write(pLine)
  f.close()
  f = open('../SIMULATION/common/TB_system_simd_wrapper_simd_option_memory_load.vh', 'w')
  pLine = ""

  pLine = pLine + '\n    case (mgr)'
  for mgr in range (0, numOfMgr):
    pLine = pLine + '\n         {0}:'.format(mgr)
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              `ifdef TB_USES_PE_GATE_NETLIST'
    pLine = pLine + '\n                $readmemh(\"./inputFiles/pe{0}_simd_wrapper_simd_option_memory.dat\", top.system_inst.pe_array_inst.pe_inst[{0}].pe.simd_wrapper.simd_option_memory_0__gmemory.dw_mem_mem1p256x13.u0.mem_core_array) ;'.format(mgr)
    pLine = pLine + '\n              `else'
    pLine = pLine + '\n                memFile = \"./inputFiles/pe{0}_simd_wrapper_simd_option_memory.dat\";'.format(mgr)
    pLine = pLine + '\n                fileDesc = $fopen (memFile, "r");'.format(mgr)
    pLine = pLine + '\n                if (fileDesc == 0)'.format(mgr)
    pLine = pLine + '\n                  begin'.format(mgr)
    pLine = pLine + '\n                    $display("ERROR:generic_1port_memory:LEE:readmem file error : %s ", memFile);'.format(mgr)
    pLine = pLine + '\n                    $finish;'.format(mgr)
    pLine = pLine + '\n                  end'.format(mgr)
    pLine = pLine + '\n                while (!$feof(fileDesc)) '.format(mgr)
    pLine = pLine + '\n                  begin '.format(mgr)
    pLine = pLine + '\n                    void\'($fgets(entry, fileDesc)); '.format(mgr)
    pLine = pLine + '\n                    void\'($sscanf(entry, "@%x %x", memory_address, memory_data));'.format(mgr)
    pLine = pLine + '\n                    //$display("ERROR:LEE:readmem file contents : %s  : Addr:%h, Data:%h", memFile, memory_address, memory_data);'.format(mgr)
    pLine = pLine + '\n                    system_inst.pe_array_inst.pe_inst[{0}].pe.simd_wrapper.simd_option_memory[0].gmemory.mem[memory_address] = memory_data ;'.format(mgr)
    pLine = pLine + '\n                  end'.format(mgr)
    pLine = pLine + '\n                $fclose(fileDesc);'.format(mgr)
    pLine = pLine + '\n              `endif'
    pLine = pLine + '\n            end'
  pLine = pLine + '\n    endcase'

  f.write(pLine)
  f.close()

  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ## Waveform .do files

  f = open("../SIMULATION/sv/allNoc.do", "w")
  pLine = ""
  for mgr in range (0, numOfMgr):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__cp_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__cp_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__cp_type}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__cp_ptype}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__cp_desttype}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__cp_pvalid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__cp_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_type}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_ptype}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_desttype}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_pvalid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__cp_ready}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_ready}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port0_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port0_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port0_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port0_fc}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port1_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port1_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port1_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port1_fc}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port2_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port2_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port2_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port2_fc}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port3_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port3_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port3_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/mgr__noc__port3_fc}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port0_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port0_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port0_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port0_fc}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port1_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port1_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port1_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port1_fc}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port2_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port2_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port2_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port2_fc}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port3_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port3_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port3_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__mgr__port3_fc}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__cp_ready}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_ready}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__cp_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__cp_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__cp_type}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__cp_ptype}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__cp_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__cp_mgrId}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_valid}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_cntl}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_type}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_ptype}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_data}}'.format(mgr)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_mgrId}}'.format(mgr)

  f.write(pLine)
  f.close()




  f = open("../SIMULATION/sv/ram.do", "w")
  pLine = ""
  for mgr in range (0, numOfMgr):

    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -divider -height 17 cmd:clk=1'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/cs_n}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/cmd0}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/cmd1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/baddr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/din}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/dinm}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/dout}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/rdstrb}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -divider -height 17 internal'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/rd_en}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/wr_en}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -divider -height 17 cmd:clk=1'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/cs_n}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/cmd0}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/cmd1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/baddr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/din}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/dinm}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/dout}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/rdstrb}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -divider -height 17 internal'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/rd_en}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/wr_en}}'.format(mgr)

  f.write(pLine)
  f.close()


  f = open("../SIMULATION/sv/mmc.do", "w")

  pLine = ""
  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
      for bank in range (0, numOfBanks):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/a_page_is_open}}                           '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/bank}}                                     '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_adjacent_bank_request}}          '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_checker_ready}}                  '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_cmd_can_go}}                     '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_request_cmd}}                    '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_request_valid}}                  '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_set_cmd}}                        '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_set_page}}                       '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_set_valid}}                      '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/open_page_id}}                             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/adjacent_bank_request}}  '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/cache_read}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/cache_write}}            '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/clk}}                    '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/cmd_can_go}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/dram_acc_sample_state}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/dram_acc_sample_state_next}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/int_request_cmd}}        '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/page_close}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/page_open}}              '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/page_refresh}}           '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/ready}}                  '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_cache_read}}     '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_cache_write}}    '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_cmd}}            '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_page_close}}     '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_page_open}}      '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_page_refresh}}   '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_valid}}          '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/reset_table}}          '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/reset_poweron}}          '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC  -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/sys__mgr__mgrId}}        '.format(mgr,chan,bank)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
      for intf in range (0, 3):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/mmc_cntl_cmd_gen_state}}      '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/mmc_cntl_cmd_gen_state_next}} '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request}}                '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_wr_data_available}}      '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_is_read}}        '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_is_write}}       '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_done}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_sequence}}       '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_bank}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_page}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_chan}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_line}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_cmd_sequence}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_cmd_code_state_next}}    '.format(mgr,chan,intf)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/clear}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/almost_full}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_data}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_tag}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_seq_type}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_strm}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_cmd}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_bank}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_page}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_valid}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_read}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_data}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_tag}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_cci}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_seq_type}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_strm}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_cmd}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_bank}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_page}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/clear}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/almost_full}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_data}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_tag}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_seq_type}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_strm}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_cmd}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_bank}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_page}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_valid}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_read}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_data}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_tag}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_seq_type}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_strm}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_cmd}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_bank}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_page}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/clear}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/almost_full}}   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_data}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_tag}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_seq_type}}'.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_strm}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_cmd}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_bank}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_page}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_line}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_valid}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_read}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_data}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_tag}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_seq_type}}  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_strm}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_cmd}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_bank}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_page}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_line}}      '.format(mgr,chan)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_cache_delta_tag}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/mmc_cntl_cmd_check_state}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/mmc_cntl_cmd_check_state_next}}'.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_cache_tag}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_pc_accepted}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_pc_read}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_pc_ready_to_go}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_pc_requested}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_po_accepted}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_po_read}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_po_ready_to_go}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_po_requested}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/cache_cmd_accepted}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/cache_cmd_read}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/cache_cmd_ready_to_go}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/cache_cmd_requested}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/chan}}                         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_bank}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_cache_tag}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_page_cmd}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_pc_tag}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_po_tag}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/mmc_cntl_cmd_check_state}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/mmc_cntl_cmd_check_state_next}}'.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_and_cache_tags_synced}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_and_po_tags_synced}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_cache_delta_tag}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_cache_delta_tag_ge0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_cache_delta_tag_gt0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_cache_delta_tag_ne0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_po_delta_tag}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_po_delta_tag_ge0}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_po_delta_tag_gt0}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_po_delta_tag_ne0}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_sequence_is_PCPOCx}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_and_cache_tags_synced}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_cache_delta_tag_ge0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_cache_delta_tag_gt0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_cache_delta_tag_ne0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_sequence_is_PCPOCx}}        '.format(mgr,chan)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/clear}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/almost_full}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_data}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_cmd}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_strm}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_bank}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_page}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_valid}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_valid}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_valid}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_data}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_data}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_data}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_cmd}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_cmd}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_cmd}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_bank}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_bank}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_bank}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_page}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_page}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_page}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_strm}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_strm}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_strm}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_read}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/clear}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/almost_full}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_cmd}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_strm}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_bank}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_line}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_data}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_valid}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_valid}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_valid}}   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_data}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_data}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_data}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_cmd}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_cmd}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_cmd}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_bank}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_bank}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_bank}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_strm}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_strm}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_strm}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_line}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_line}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_line}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_read}}               '.format(mgr,chan)

  for mgr in range (0, numOfMgr):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/access_set_cmd}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/access_set_page}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/access_set_valid}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/adjacent_bank_request}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cache_cmd_grant_request_cmd}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cache_cmd_grant_request_valid}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cache_counter_in}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cache_counter_out}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/can_go}}                               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/can_go_checker_ready}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_bank}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_cmd}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_line}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_page}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_strm}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_valid}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_bank_a_page_is_open}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_bank_open_page}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/clk}}                                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_can_go}}                           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__cntl}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__cntl_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__data}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__data_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__init_done}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__init_done_d1}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__valid}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__valid_d1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dram_cmd_mode}}                        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/grant_send_to_stream}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__addr}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__addr_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__bank}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__bank_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cmd0}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cmd0_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cmd1}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cmd1_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cs}}                         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cs_e1}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__data}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__data_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__data_mask}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__data_mask_e1}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__cntl}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__cntl_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__data}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__data_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__data_ready}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__data_ready_e1}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__ready}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__ready_e1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__valid}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__valid_e1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/page_cmd_grant_request_cmd}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/page_cmd_grant_request_valid}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_pipe_read}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_send_to_stream}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_valid}}                        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/requested_bank}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/requested_line}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/requested_page}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/reset_poweron}}                        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_tag}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_bank}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_cmd}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_line}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_page}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_bank_latched}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_sequence}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_request}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_enable}}                          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_done}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_accessing_last_bank}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_is_read_latched}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_is_write_latched}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_line_latched}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_page_latched}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_seq_type}}                        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_tag}}                             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_write_data_available}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_write_data_read}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/sys__mgr__mgrId}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/waiting_to_send_to_stream}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo_output_data}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo_output_data_mask}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__bank}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__bank_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__channel}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__channel_d1}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__cntl}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__cntl_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_channel}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_channel_d1}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_cntl}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_cntl_d1}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_mask}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_mask_d1}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_valid}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_valid_d1}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__page}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__page_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__read}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__read_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__ready}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__ready_d1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__valid}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__valid_d1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__word}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__word_d1}}                    '.format(mgr,chan)


  for mgr in range (0, numOfMgr):
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc_cntl_op_tag_cntl_state      }}            '.format(mgr,intf)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_tag_match       }}            '.format(mgr,intf)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_tag_doesnt_match}}            '.format(mgr,intf)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_matches_tag     }}            '.format(mgr,intf)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_doesnt_match_tag}}            '.format(mgr,intf)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/requested_tag        }}            '.format(mgr,intf)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/operation_tag     }}            '.format(mgr,intf)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/op_tag_pause_count}}            '.format(mgr,intf)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/op_tag_increment  }}            '.format(mgr,intf)
      for intf in range (0, 3):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/clear}}            '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/almost_full}}      '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/write}}            '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/write_data}}       '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_valid}}        '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_read}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_data}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_cntl}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_tag}}          '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_is_read}}      '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_is_write}}     '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_channel}}      '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_bank}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_page}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_word}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_line}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_som}}          '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_eom}}          '.format(mgr,intf)

  for mgr in range (0, numOfMgr):
      for wr_intf in range (0, 1):
        for chan in range (0, numOfChannels):
            pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group WRITE_DATA_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo[{1}]/chan_fifo[{2}]/almost_full}}      '.format(mgr,wr_intf,chan)
            pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group WRITE_DATA_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo[{1}]/chan_fifo[{2}]/write}}            '.format(mgr,wr_intf,chan)
            pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group WRITE_DATA_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo[{1}]/chan_fifo[{2}]/write_data}}       '.format(mgr,wr_intf,chan)
            pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group WRITE_DATA_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo[{1}]/chan_fifo[{2}]/pipe_valid}}        '.format(mgr,wr_intf,chan)
            pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group WRITE_DATA_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo[{1}]/chan_fifo[{2}]/pipe_read}}         '.format(mgr,wr_intf,chan)
            pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group WRITE_DATA_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo[{1}]/chan_fifo[{2}]/pipe_data}}         '.format(mgr,wr_intf,chan)
            pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group WRITE_DATA_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo[{1}]/chan_fifo[{2}]/pipe_has_two}}      '.format(mgr,wr_intf,chan)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/mmc_cntl_strm_sel_state}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/mmc_cntl_strm_sel_state_next}}  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/strm_ena[0]/strm}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/strm_ena[1]/strm}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/strm_ena[2]/strm}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/last_bank_valid}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/last_bank}}                     '.format(mgr,chan)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group DFI_SEQ_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi_seq_fsm[{1}]/mmc_cntl_seq_state}}'.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC -group DFI_SEQ_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dram_cmd_mode}}'.format(mgr,chan)

  f.write(pLine)
  f.close()



  f = open("../SIMULATION/sv/stu.do", "w")

  pLine = ""
  for mgr in range (0, numOfMgr):
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix hexadecimal {{/top/system_inst/stu__mgr{0}__valid   }}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix hexadecimal {{/top/system_inst/stu__mgr{0}__cntl    }}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix hexadecimal {{/top/system_inst/mgr{0}__stu__ready   }}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix hexadecimal {{/top/system_inst/stu__mgr{0}__type    }}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix hexadecimal {{/top/system_inst/stu__mgr{0}__data    }}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix hexadecimal {{/top/system_inst/stu__mgr{0}__oob_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix float32     {{/top/system_inst/stu__mgr{0}__data[127:96]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix float32     {{/top/system_inst/stu__mgr{0}__data[ 95: 64]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix float32     {{/top/system_inst/stu__mgr{0}__data[ 63: 32]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STU -radix float32     {{/top/system_inst/stu__mgr{0}__data[ 31:  0]}}'.format(mgr)


  f.write(pLine)
  f.close()

  f = open("../SIMULATION/sv/std.do", "w")

  pLine = ""
  for mgr in range (0, numOfMgr):
    for lane in [0,7,15,23,31] :
      for strm in range (0, numOfStrms):
          pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STD -radix hexadecimal {{/top/system_inst/mgr{0}__std__lane{1}_strm{2}_data_valid}}'.format(mgr,lane,strm)
          pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STD -radix hexadecimal {{/top/system_inst/mgr{0}__std__lane{1}_strm{2}_cntl      }}'.format(mgr,lane,strm)
          pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STD -radix float32     {{/top/system_inst/mgr{0}__std__lane{1}_strm{2}_data      }}'.format(mgr,lane,strm)
          pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group STD -radix hexadecimal {{/top/system_inst/std__mgr{0}__lane{1}_strm{2}_ready     }}'.format(mgr,lane,strm)


  f.write(pLine)
  f.close()

  f = open("../SIMULATION/sv/sdp.do", "w")

  pLine = ""
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/mgr__stu__ready}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__cntl}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__oob_data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__type}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__valid}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/mgr__stu__ready}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__cntl}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__oob_data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__type}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__valid}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/mgr__stu__ready}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__cntl}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__oob_data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__type}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__valid}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/mgr__stu__ready}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__cntl}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__oob_data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__type}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__valid}}'.format(mgr,strm,lane)



  for mgr in range (0, numOfMgr):
    for lane in [0,7,15,23,31] :
      for strm in range (0, numOfStrms):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group stOp -group LANE{2} -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/sti__stOp__strm{1}_data_valid}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group stOp -group LANE{2} -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/sti__stOp__strm{1}_cntl}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group stOp -group LANE{2} -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/sti__stOp__strm{1}_data}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group stOp -group LANE{2} -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/stOp__sti__strm{1}_ready}}'.format(mgr,strm,lane)
        #


  # provide a default for the format
  mgr  = 0
  strm = 0
  chan = 0
  lane = 0
  for mgr in range (0, numOfMgr):
    for strm in range (0, numOfStrms):
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/clk}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/reset_poweron}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__get_next_line}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__lane_channel_ptr}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__lane_cntl}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__lane_enable}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__lane_valid}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__lane_word_ptr}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__mem_request_valid}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__mem_request_cntl}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__mem_request_channel}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__mem_request_bank}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__mem_request_page}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__mem_request_word}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/xxx__sdp__mem_request_ready}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/xxx__sdp__mem_request_channel_data_valid}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp__xxx__storage_desc_processing_complete}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__cfg_lane_enable}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__cfg_accessOrder}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__cfg_addr}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__cfg_valid}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__complete}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__consJump_cntl}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__consJump_valid}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__consJump_value}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__response_id_bank}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__response_id_channel}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__response_id_cntl}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__response_id_line}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__response_id_page}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdpr__sdps__response_id_valid}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdps__sdpr__cfg_ready}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdps__sdpr__complete}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdps__sdpr__consJump_ready}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdps__sdpr__response_id_ready}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sys__mgr__mgrId}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/xxx__sdp__lane_enable}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/xxx__sdp__lane_ready}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/xxx__sdp__num_lanes}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/xxx__sdp__num_lanes_m1}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/xxx__sdp__storage_desc_processing_enable}}'.format(mgr,strm)
       pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/xxx__sdp__storage_desc_ptr}}'.format(mgr,strm)

  # provide a default for the format
  mgr  = 0
  strm = 0
  chan = 0
  lane = 0
  for mgr in range (0, numOfMgr):
    for strm in range (0, numOfStrms):
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state_next}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_cntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__mem_request_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_cntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_line}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__response_id_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_valid_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_cntl_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_channel_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_bank_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_page_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_line_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__response_id_ready_d1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_is_cons_tm1_end}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_requested_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_requested_mismatch}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_bank_last_requested}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_page_last_requested}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/completed_streaming}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_cntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_eom}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_som}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_som_eom}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_value}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpPtr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/create_response_id}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/desc_processor_strm_ack}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/inc_consJumpPtr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/local_storage_desc_ptr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_ms_lane_start_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_line}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/first_time_thru}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_chan01_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_chan0_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_chan10_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_chan1_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_disable_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/generate_requests}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/create_mem_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/requests_complete}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state_next}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/channel_change}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/bank_change}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/page_change}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_addr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_addr_chan}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_addr_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_addr_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_end_addr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_end_addr_chan}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_end_addr_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_end_addr_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_inc_addr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_inc_addr_chan}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_inc_addr_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_inc_addr_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_AccessOrder}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_Address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_consJump}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_consJumpCntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_consJumpPtr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__storage_desc_processing_complete}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state_next}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__cfg_accessOrder}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__cfg_addr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__cfg_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__complete}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__consJump_cntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__consJump_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__consJump_value}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__cfg_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__complete}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__consJump_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_accessOrder}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_bank_lsb}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_cline}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_consJumpPtr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_local_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_mgr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/strm_transfer_type}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sys__mgr__mgrId}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/stream_proc_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__lane_enable}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__mem_request_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__mem_request_ready_d1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__num_lanes}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__num_lanes_m1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__storage_desc_processing_enable}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__storage_desc_ptr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPR -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__txfer_type}}'.format(mgr,strm,lane,chan)






  # provide a default for the format
  mgr  = 0
  strm = 0
  chan = 0
  lane = 0
  for mgr in range (0, numOfMgr):
    for strm in range (0, numOfStrms):
      for lane in [0,7,15,23,31] :
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group SDPS -group LANE{2} -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/sti__stOp__strm{1}_data_valid}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group SDPS -group LANE{2} -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/sti__stOp__strm{1}_cntl}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group SDPS -group LANE{2} -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/sti__stOp__strm{1}_data}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group SDPS -group LANE{2} -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/stOp__sti__strm{1}_ready}}'.format(mgr,strm,lane)
      #
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/xxx__sdp__lane_ready}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp_cntl_stream_cntl_state}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp_cntl_stream_cntl_state_next}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/all_lanes_complete}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/running}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/flush_complete}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/force_flush}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/request_read_diff}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/request_read_diff_eq0}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/request_read_diff_gt0}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/request_read_diff_lt0}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/exec_lane_enable}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_req_next_line              }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_sending                    }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_address_match              }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/all_lanes_req_next_line          }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/at_least_one_force_req_next_line }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/at_least_one_req_next_line       }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_force_req_next_line        }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/get_next_line                    }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_running                    }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/block_request                    }}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/write_data}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/almost_full}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/pipe_data}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/write_data}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/almost_full}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/pipe_data}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_cntl}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_bank}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_page}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_line}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_som}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_mom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_eom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/response_id_in_progress}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_cntl}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_bank}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_page}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_line}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_som}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_mom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_eom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/response_id_in_progress}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/block_request[0]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/block_request[1]}}'.format(mgr,strm,lane)
      #                                                                                  
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/get_next_line[0]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/get_next_line[1]}}'.format(mgr,strm,lane)
      #                                                                                  
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp__xxx__get_next_line[0]}} '.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/all_lanes_complete}}'.format(mgr,strm,lane)
      #                                                                                  
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_req_next_line[0][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_req_next_line[1][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_force_req_next_line[0][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_force_req_next_line[1][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_force_req_next_line}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/neither_match[0][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/neither_match[1][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp__xxx__get_next_line[0]}} '.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp__xxx__get_next_line[1]}} '.format(mgr,strm,lane)
      #                                                                                  
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_consJumpCntl}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_consJumpValue}}'.format(mgr,strm,lane)
      #                                                                                  
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/all_lanes_loaded_consequtive}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/all_lanes_loaded_jump}}'.format(mgr,strm,lane)
      #                                                                                  
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_loaded_consequtive}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_loaded_jump}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_loading_consequtive}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_loading_jump}}'.format(mgr,strm,lane)
      #                                                                                  
      #                                                                                  
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_addr}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_num_lanes}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_num_lanes_m1}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_lane_enable}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_order}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_tgt}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_transfer_type}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_consJumpCntl}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_consJumpValue}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_eom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_som}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/write}}'.format(mgr,strm,lane)
      #
      #
      for lane in [0,7,15,23,31] :
        #
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sdp_cntl_stream_data_state}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/req_next_line[0]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/force_req_next_line[0]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_match[0]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_next_match[0]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/req_next_line[1]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/force_req_next_line[1]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_match[1]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_next_match[1]}} '.format(mgr,strm,lane)
        #                                                                                  
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sdp_cntl_stream_data_state}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/complete}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_channel_ptr}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_bank_ptr}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_line_ptr}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_word_ptr}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_channel_ptr_e1}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_bank_ptr_e1}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_line_ptr_e1}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_word_ptr_e1}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/consequtive_counter_le0}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_data_available}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sent_data_without_increment}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/destination_ready}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/consequtive_counter}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_next_inc_cons_start_address}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/last_consequtive}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sdp_cntl_stream_data_state}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_match[0]}}'.format(mgr,strm,lane) 
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_match[1]}}'.format(mgr,strm,lane) 
        #                                                                                  
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_req_next_line[0][{2}]}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_req_next_line[1][{2}]}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/req_next_line_but_not_accepted}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/send_data}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_running}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_data_available}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/destination_ready}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sdp_cntl_stream_data_state}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/loaded_consequtive}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/loaded_jump}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/loading_consequtive}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDP -group STRM{1} -group SDPS -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/loading_jump}}'.format(mgr,strm,lane)

  f.write(pLine)
  f.close()


  f = open("../SIMULATION/sv/wu_decode.do", "w")
  pLine = ""
  for mgr in range (0, numOfMgr):
    #                                                              
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wum__wud__valid}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wum__wud__icntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wum__wud__dcntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wum__wud__op}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wum__wud__option_type}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wum__wud__option_value}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__wum__ready}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/write_icntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/write_dcntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/write_op}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/write_option_type}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/write_option_value}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/read_icntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/read_dcntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/read_op}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/read_option_type}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/read_option_value}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/clear}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/empty}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/almost_full}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/read}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/write}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/fifo_pipe_valid}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/fifo_pipe_read}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_valid}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_icntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_dcntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_op}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_option_type}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_option_value}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_read}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_option_type_extd}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_inst_som}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_inst_mom}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_inst_eom}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_desc_som}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_desc_mom}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group FROM_WUM -group FROM_WUM_FIFO -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/from_WuMemory_Fifo[0]/pipe_desc_eom}}'.format(mgr,strm)
    #                                                              
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MCNTL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__mcntl__valid}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MCNTL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__mcntl__dcntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MCNTL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__mcntl__option_type}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MCNTL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__mcntl__option_value}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MCNTL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__mcntl__tag}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MCNTL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/mcntl__wud__ready}}'.format(mgr,strm)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_OOB -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__odc__valid}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_OOB -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__odc__cntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_OOB -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__odc__num_lanes}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_OOB -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__odc__simd_cmd}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_OOB -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__odc__stOp_cmd}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_OOB -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/odc__wud__ready}}'.format(mgr,strm)
    #
    for strm in range (0, numOfStrms):
      #
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__mrc{1}__valid}}'.format(mgr,strm)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__mrc{1}__cntl}}'.format(mgr,strm)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__mrc{1}__option_type}}'.format(mgr,strm)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__mrc{1}__option_value}}'.format(mgr,strm)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_MRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/mrc{1}__wud__ready}}'.format(mgr,strm)
    #                                                              
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_RDP -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__rdp__valid}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_RDP -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__rdp__dcntl}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_RDP -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__rdp__option_type}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_RDP -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__rdp__option_value}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_RDP -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/wud__rdp__tag}}'.format(mgr,strm)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group TO_RDP -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/rdp__wud__ready}}'.format(mgr,strm)
    #                                                              
    numOfOptTuples = 3
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/send_info_to_arg0_mem_cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/send_info_to_arg1_mem_cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/send_info_to_oob_downstream}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/send_info_to_return_proc}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/send_info_to_main_cntl}}'.format(mgr)
    #pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/send_info_to_mem_write}}'.format(mgr)
    for ot in range (0, numOfOptTuples):
      #
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/wu_dec_instr_dec_state}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/wu_dec_instr_dec_state_next}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/contained_num_lanes}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/contained_simd_cmd}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/contained_stOp_cmd}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/decNum}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/num_lanes}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/send_info_to_arg0_mem_cntl}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/send_info_to_arg1_mem_cntl}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/send_info_to_oob_downstream}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/send_info_to_return_proc}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/send_info_to_main_cntl}}'.format(mgr,ot)
      #pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/send_info_to_mem_write}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/simd_cmd}}'.format(mgr,ot)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_DECODE -group INSTR_DEC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_decode/instr_decode[{1}]/stOp_cmd}}'.format(mgr,ot)

  f.write(pLine)
  f.close()


  f = open("../SIMULATION/sv/mwc_cntl.do", "w")

  pLine = ""


  mgr  = 0
  src = 0
  for mgr in range (0, numOfMgr):
    #pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__valid       }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__cntl        }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mmc__mwc__ready       }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__channel     }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__bank        }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__page        }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__word        }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data_valid  }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data_cntl   }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data_channel}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data        }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data_mask   }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mmc__mwc__data_ready  }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc_cntl_input_arb_state }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/enable_rdp_fsm }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/enable_mcntl_fsm }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/storage_desc_address_valid }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/local_storage_desc_ptr }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/sdmem_Address     }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/sdmem_AccessOrder }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/sdmem_consJumpPtr }}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_addr_hit}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_valid}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_accept}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_available}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_next_available}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_bank}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_page}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_data}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_mask}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_accessOrder}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_address_data_valid}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_address}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_channel}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_bank}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_page}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_line}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_word}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_address_e1}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_channel_e1}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_bank_e1}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_page_e1}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_line_e1}}'.format(mgr,src)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_word_e1}}'.format(mgr,src)
    for src in range (0, 2):                             
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/mwc_cntl_extract_desc_state}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/mwc_cntl_extract_desc_state_next}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/enable}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/complete}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_valid}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_read}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_data}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_ptype}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_mem_data}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_pvalid}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_eom}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/contains_storage_ptr}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/contains_data}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/storage_desc_address_valid }}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/storage_desc_ptr}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/storage_desc_ptr_wire}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/storage_desc_ptr_mgr_id}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_clear}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_line_count}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_chan_ptr}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_chan_cline_ptr}}'.format(mgr,src)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group SRC{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_chan_cline_line_ptr}}'.format(mgr,src)

  f.write(pLine)
  f.close()


  f = open("../SIMULATION/sv/dfi.do", "w")

  pLine = ""


  mgr  = 0
  for mgr in range (0, numOfMgr):
    #pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/reset_poweron}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/clk_diram}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/clk_diram2x}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/clk_diram_cq}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/clk_diram_cntl_ck}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/clk_diram_data_ck}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/clk_diram2x_dly}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dram_chan_mode}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/burst_count}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/init_done}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group GEN -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/init_done_d1}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group MMC2DFI -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/mmc__dfi__addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group MMC2DFI -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/mmc__dfi__bank}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group MMC2DFI -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/mmc__dfi__cmd0}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group MMC2DFI -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/mmc__dfi__cmd1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group MMC2DFI -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/mmc__dfi__cs}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group MMC2DFI -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/mmc__dfi__data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group MMC2DFI -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/mmc__dfi__data_mask}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group MMC2DFI -divider -height 17 cmd:dram_cmd_mode=0'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group MMC2DFI -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dram_cmd_mode}}'.format(mgr,chan)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__init_done}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__cntl_e3}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__data_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__data_e2}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__data_e3}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__valid_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__valid_e2}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group DFI2MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__mmc__valid_e3}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__cs}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__cmd1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__cmd0}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__bank}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__data_mask}}'.format(mgr)
    #pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -divider -height 17 cmd:dram_chan_mode=0'.format(mgr)
    #pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dram_chan_mode}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/phy__dfi__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/phy__dfi__data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__addr_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__bank_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__cmd0_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__cmd1_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__cs_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__data_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI -group PHY_INTF -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/dfi/dfi__phy__data_mask_e1}}'.format(mgr)

  f.write(pLine)
  f.close()

  f = open("../SIMULATION/sv/noc.do", "w")

  pLine = ""

  for mgr in range (0, numOfMgr):
    for port in range (0, numOfPorts):
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/mgr__noc__port{1}_cntl}}'.format(mgr,port)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/mgr__noc__port{1}_data}}'.format(mgr,port)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/mgr__noc__port{1}_fc}}'.format(mgr,port)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/mgr__noc__port{1}_valid}}'.format(mgr,port)
 
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/noc__mgr__port{1}_cntl}}'.format(mgr,port)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/noc__mgr__port{1}_data}}'.format(mgr,port)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/noc__mgr__port{1}_fc}}'.format(mgr,port)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/noc__mgr__port{1}_valid}}'.format(mgr,port)
 
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_valid}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_cntl}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_type}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_ptype}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_desttype}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_pvalid}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_data}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_TO_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_ready}}'.format(mgr,port)
    
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_valid}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_cntl}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_mgrId}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_type}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_ptype}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_pvalid}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/noc__locl__dp_data}}'.format(mgr,port)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group LOCAL_FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_noc_cntl/locl__noc__dp_ready}}'.format(mgr,port)


  f.write(pLine)
  f.close()


  f = open("../SIMULATION/sv/oob.do", "w")

  pLine = ""

  for mgr in range (0, numOfMgr):
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group OOB -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/oob_downstream_cntl/mgr__std__oob_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group OOB -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/oob_downstream_cntl/mgr__std__oob_cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group OOB -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/oob_downstream_cntl/mgr__std__oob_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group OOB -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/oob_downstream_cntl/mgr__std__oob_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group OOB -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/oob_downstream_cntl/std__mgr__oob_ready}}'.format(mgr)

  f.write(pLine)
  f.close()

  f = open("../SIMULATION/sv/datapath_fifos.do", "w")

  pLine = ""

  for mgr in range (0, numOfMgr):
    for strm in range (0, numOfStrms):
      for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/almost_full}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/empty}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/write}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/write_data}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/read}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/read_data}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/fifo_pipe_valid}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/fifo_pipe_read}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/pipe_valid}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/pipe_read}}'.format(mgr,strm,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DATAPATH_FIFO -group STRM{1} -group CHAN{2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[{2}]/pipe_data}}'.format(mgr,strm,chan)

  f.write(pLine)
  f.close()

  f = open("../SIMULATION/sv/mwc.do", "w")

  pLine = ""

  for mgr in range (0, numOfMgr):
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/reset_poweron}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__ptype}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix float32      {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__data[63:32]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix float32      {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__data[31:0]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__pvalid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__mgrId}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group MCNTL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mcntl__ready}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group RDP -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/rdp__mwc__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group RDP -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/rdp__mwc__cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group RDP -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/rdp__mwc__ptype}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group RDP -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/rdp__mwc__pvalid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group RDP -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/rdp__mwc__data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group RDP -radix float32      {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/rdp__mwc__data[63:32]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group RDP -radix float32      {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/rdp__mwc__data[31:0]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group RDP -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__rdp__ready}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl__mwc__flush}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/sys__mgr__mgrId}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mmc_ready}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc_cntl_input_arb_state}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc_cntl_input_arb_state_next}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/enable_rdp_fsm}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/rdp_fsm_complete}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/enable_mcntl_fsm}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mcntl_fsm_complete}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc_cntl_extract_desc_state}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_address_data_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_address}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_channel}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_bank}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_page}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_line}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_word}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_address_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_channel_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_bank_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_page_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_line_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/inc_word_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/storage_desc_ptr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/storage_desc_address_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/local_storage_desc_ptr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/sdmem_Address}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/sdmem_AccessOrder}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/sdmem_AccessOrder_latched}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/sdmem_consJumpPtr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_addr_hit}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_available}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_accept}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_next_available}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_bank}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_page}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_mask}}'.format(mgr)
    #pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/held_accessOrder}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/holding_reg_line_count}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/holding_reg_chan_ptr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/holding_reg_chan_cline_ptr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/holding_reg_chan_cline_line_ptr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/pipe_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/pipe_mem_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/holding_reg_clear}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__tag}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__channel}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__bank}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__page}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__word}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mmc__mwc__ready}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data_cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data_channel}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data_mask}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mmc__mwc__data_ready}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 0]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 1]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 2]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 3]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 4]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 5]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 6]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 7]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 8]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[ 9]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[10]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[11]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[12]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[13]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[14]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[15]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[16]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[17]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[18]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[19]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[20]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[21]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[22]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[23]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[24]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[25]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[26]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[27]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[28]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[29]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[30]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[31]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[32]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[33]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[34]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[35]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[36]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[37]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[38]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[39]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[40]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[41]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[42]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[43]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[44]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[45]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[46]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[47]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[48]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[49]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[50]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[51]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[52]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[53]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[54]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[55]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[56]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[57]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[58]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[59]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[60]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[61]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[62]}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group TO_MMC -group WORDS -radix float32  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/mwc__mmc__data[63]}}'.format(mgr)
    for intf in range (2):
        if intf == 0:
          src = "RDP"
        else:
          src = "MCNTL"
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/intf}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/mwc_cntl_extract_desc_state}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/mwc_cntl_extract_desc_state_next}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/enable}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/complete}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_valid}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_read}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_data}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_ptype}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_mem_data}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_pvalid}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/pipe_eom}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/contains_storage_ptr}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/contains_data}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/storage_desc_ptr}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/storage_desc_ptr_wire}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/storage_desc_address_valid}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/storage_desc_ptr_mgr_id}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_clear}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_line_count}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_chan_ptr}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_chan_cline_ptr}}'.format(mgr,intf,src)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MWC -group {2} -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mwc_cntl/intf_fsm[{1}]/holding_reg_chan_cline_line_ptr}}'.format(mgr,intf,src)



  f.write(pLine)
  f.close()



  f = open("../SIMULATION/sv/mgr_cntl.do", "w")

  pLine = ""

  for mgr in range (0, numOfMgr):
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/reset_poweron}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/sys__mgr__mgrId}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/start_of_wu_descriptor}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/middle_of_wu_descriptor}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/end_of_wu_descriptor}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/extended_tuple}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mode_reg_id}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mode_reg_value}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wum_address}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_mgrId}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_ptype}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_pvalid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__noc__cp_ready}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_mgrId}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_ptype}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_pvalid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__noc__dp_ready}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUD -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUD -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__dcntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUD -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__option_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUD -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__option_value}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUD -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__tag}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUD -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wud__ready}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wum__mcntl__inst_count}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__enable_inst_dnld}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__address}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wum__mcntl__ready}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__icntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__dcntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__op}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__option_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__option_value}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group MWC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group MWC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group MWC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group MWC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__flush}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group MWC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__mgrId}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group MWC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__ptype}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group MWC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__pvalid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group MWC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group MWC -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mwc__mcntl__ready}}'.format(mgr)
    #
    #
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUF -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wuf__enable}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUF -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wuf__start_addr}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group WUF -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/xxx__wuf__stall}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__cntl_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__data_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__mgrId_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__ptype_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__pvalid_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__type_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__mwc__valid_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__noc__cp_ready_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__noc__dp_ready_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wud__ready_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__option_value_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__option_type_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__op_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__dcntl_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__icntl_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__address_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wum__mcntl__ready_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__valid_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mcntl__wum__enable_inst_dnld_e1}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FSM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mgr_cntl_main_state}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FSM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mgr_cntl_main_state_next}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FSM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FSM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FSM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FSM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_ptype}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FSM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FSM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_pvalid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FSM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_srcId}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/mwc__mcntl__ready_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_cntl_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_data_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_mgrId_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_ptype_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_pvalid_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_type_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__cp_valid_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_cntl_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_data_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_mgrId_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_ptype_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_pvalid_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_type_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/noc__mcntl__dp_valid_d1}}'.format(mgr)
    #
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__dcntl_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__option_type_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__option_value_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__tag_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group INTF_REGS -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/wud__mcntl__valid_d1}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/almost_full}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/clear}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/intf}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_cntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_eom}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_mem_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_ptype}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_pvalid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_read}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_som}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_srcId}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/pipe_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/write}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_NOC_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_noc_fifo[0]/write_data}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/almost_full}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/clear}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/empty}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/fifo_pipe_read}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/fifo_pipe_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/gvi}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/pipe_dcntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/pipe_option_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/pipe_option_value}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/pipe_read}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/pipe_tag}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/pipe_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/read}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/read_dcntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/read_option_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/read_option_value}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/read_tag}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/write}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/write_dcntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/write_option_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/write_option_value}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MGR_CNTL -group FROM_WUD_FIFO -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mgr_cntl/from_WuDecode_Fifo[0]/write_tag}}'.format(mgr)


  f.write(pLine)
  f.close()

  f = open("../SIMULATION/sv/wu_memory.do", "w")

  pLine = ""

  for mgr in range (0, numOfMgr):
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/reset_poweron}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__address}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__dcntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__enable_inst_dnld}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__icntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__op}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__option_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__option_value}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/reset_poweron}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/sys__mgr__mgrId}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wud__wum__ready}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wuf__wum__addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wuf__wum__read}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__mcntl__inst_count}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__mcntl__ready}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__wud__dcntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__wud__icntl}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__wud__op}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__wud__option_type}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__wud__option_value}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__wud__valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__wuf__stall}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/dcntl_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/icntl_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_count}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__address_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__dcntl_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__enable_inst_dnld_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__icntl_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__op_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__option_type_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__option_value_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/mcntl__wum__valid_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/memory_read}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/memory_valid}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/op_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/option_type_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/option_value_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/valid_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wuf__wum__addr_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wuf__wum__read_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum__mcntl__ready_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/wum_address}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/portA_address}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/portA_enable}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/portA_write}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/portA_write_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/reset_poweron}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/portA_read_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/entry}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/loadMemory}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/memory_address}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/memory_data}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/portA_read}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_MEMORY -group INST_MEM -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_memory/instruction_mem[0]/gmemory/reg_portA_read_data}}'.format(mgr)

  f.write(pLine)
  f.close()


  f = open("../SIMULATION/sv/wu_fetch.do", "w")

  pLine = ""

  for mgr in range (0, numOfMgr):
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/reset_poweron}}'.format(mgr)
    #
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/mcntl__wuf__enable}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/mcntl__wuf__start_addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/xxx__wuf__stall}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/wum__wuf__stall}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/mcntl__wuf__enable_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/mcntl__wuf__start_addr_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/wuf__wum__addr_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/wuf__wum__read_e1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/xxx__wuf__stall_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/wum__wuf__stall_d1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/pc}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/increment_pc}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/stall}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/enable}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/wuf_cntl_state}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/wuf_cntl_state_next}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/wuf__wum__addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group WU_FETCH -group GENERAL -radix hexadecimal  {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/wu_fetch/wuf__wum__read}}'.format(mgr)



  f.write(pLine)
  f.close()




