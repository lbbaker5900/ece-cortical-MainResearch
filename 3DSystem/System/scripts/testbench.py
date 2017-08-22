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
    pLine = pLine + '\n                          // packet complete, now place in manager received mailbox so it can be matched with a sent packet'
    pLine = pLine + '\n                          $display ("@%0t::%s:%0d:: INFO: NoC Packet rcvd to {{%0d}} from {{%0d}}", $time, `__FILE__, `__LINE__, {0}, local_noc_pkt_rcvd [{0}].header_source);'.format(mgr)
    pLine = pLine + '\n                          noc2mgr_p [{0}].put(local_noc_pkt_rcvd [{0}]);'.format(mgr)
    pLine = pLine + '\n                          local_noc_pkt_rcvd [{0}].displayPacket;'.format(mgr)
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




  f = open("../SIMULATION/sv/mmc_channel_bank_status.do", "w")
  pLine = ""
  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
      for bank in range (0, numOfBanks):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/a_page_is_open}}                           '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/bank}}                                     '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_adjacent_bank_request}}          '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_checker_ready}}                  '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_cmd_can_go}}                     '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_request_cmd}}                    '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_request_valid}}                  '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_set_cmd}}                        '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_set_page}}                       '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/chan_bank_set_valid}}                      '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/open_page_id}}                             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/adjacent_bank_request}}  '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/cache_read}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/cache_write}}            '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/clk}}                    '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/cmd_can_go}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/dram_acc_sample_state}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/dram_acc_sample_state_next}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/int_request_cmd}}        '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/page_close}}             '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/page_open}}              '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/page_refresh}}           '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/ready}}                  '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_cache_read}}     '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_cache_write}}    '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_cmd}}            '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_page_close}}     '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_page_open}}      '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_page_refresh}}   '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/request_valid}}          '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/reset_table}}          '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/reset_poweron}}          '.format(mgr,chan,bank)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CHAN{1} -group BANK{2} -group TIMER -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_info[{1}]/bank_info[{2}]/dram_access_timer/sys__mgr__mgrId}}        '.format(mgr,chan,bank)

  f.write(pLine)
  f.close()


  f = open("../SIMULATION/sv/ram.do", "w")
  pLine = ""
  for mgr in range (0, numOfMgr):

    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/cs_n}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/cmd0}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/cmd1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/baddr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/din}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/dout}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/rdstrb}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/cs_n}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/cmd0}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/cmd1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/baddr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/din}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/dout}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group EVEN -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_even/rdstrb}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/cs_n}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/cmd0}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/cmd1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/baddr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/din}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/dout}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/rdstrb}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/clk}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/cs_n}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/cmd0}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/cmd1}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/baddr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/addr}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/din}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/dout}}'.format(mgr)
    pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DRAM -group ODD -radix hexadecimal {{/top/diram/diram_port_arrays[{0}]/diram_inst/ram_odd/rdstrb}}'.format(mgr)

  f.write(pLine)
  f.close()



