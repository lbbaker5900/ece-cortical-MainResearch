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


  f = open('../SIMULATION/common/TB_system_load_dram.vh', 'w')
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

  f.write(pLine)
  f.close()


  f = open("../SIMULATION/sv/mmc.do", "w")

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

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
      for intf in range (0, 3):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/mmc_cntl_cmd_gen_state}}      '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/mmc_cntl_cmd_gen_state_next}} '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request}}                '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_wr_data_available}}      '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_is_read}}        '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_is_write}}       '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_done}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_sequence}}       '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_bank}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_page}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_chan}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_request_line}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_cmd_sequence}}           '.format(mgr,chan,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_GEN_FSM -group CHAN{1} -group STRM{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_cmd_gen_fsm[{1}]/strm_fsm[{2}]/strm_cmd_code_state_next}}    '.format(mgr,chan,intf)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/clear}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/almost_full}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_data}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_tag}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_seq_type}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_strm}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_cmd}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_bank}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/write_page}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_valid}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_read}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_data}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_tag}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_seq_type}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_strm}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_cmd}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_bank}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PO -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_po_fifo[{1}]/pipe_page}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/clear}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/almost_full}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_data}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_tag}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_seq_type}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_strm}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_cmd}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_bank}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/write_page}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_valid}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_read}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_data}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_tag}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_cci}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_seq_type}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_strm}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_cmd}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_bank}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group PC -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pc_fifo[{1}]/pipe_page}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/clear}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/almost_full}}   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_data}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_tag}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_seq_type}}'.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_strm}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_cmd}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_bank}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_page}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/write_line}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_valid}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_read}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_data}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_tag}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_seq_type}}  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_strm}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_cmd}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_bank}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_page}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_SEQ_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_cache_fifo[{1}]/pipe_line}}      '.format(mgr,chan)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_cache_delta_tag}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/mmc_cntl_cmd_check_state}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/mmc_cntl_cmd_check_state_next}}'.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_cache_tag}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_pc_accepted}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_pc_read}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_pc_ready_to_go}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_pc_requested}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_po_accepted}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_po_read}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_po_ready_to_go}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/page_cmd_po_requested}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/cache_cmd_accepted}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/cache_cmd_read}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/cache_cmd_ready_to_go}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/cache_cmd_requested}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/chan}}                         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_bank}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_cache_tag}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_page_cmd}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_pc_tag}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/last_po_tag}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/mmc_cntl_cmd_check_state}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/mmc_cntl_cmd_check_state_next}}'.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_and_cache_tags_synced}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_and_po_tags_synced}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_cache_delta_tag}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_cache_delta_tag_ge0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_cache_delta_tag_gt0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_cache_delta_tag_ne0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_po_delta_tag}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_po_delta_tag_ge0}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_po_delta_tag_gt0}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_po_delta_tag_ne0}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/pc_sequence_is_PCPOCx}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_and_cache_tags_synced}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_cache_delta_tag_ge0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_cache_delta_tag_gt0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_cache_delta_tag_ne0}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group CMD_PASS_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_seq_pass_fsm[{1}]/po_sequence_is_PCPOCx}}        '.format(mgr,chan)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/clear}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/almost_full}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_data}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_cmd}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_strm}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_bank}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/write_page}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_valid}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_data}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_valid}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_data}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_valid}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_data}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_read}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_cmd}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_strm}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_bank}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_page}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_cmd}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_strm}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_bank}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_page}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_cmd}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_strm}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_bank}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group PAGE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_page_cmd_fifo[{1}]/pipe_peek_twoIn_page}}      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/clear}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/almost_full}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_cmd}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_strm}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_bank}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_line}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/write_data}}             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_valid}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_data}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_valid}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_data}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_valid}}   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_data}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_read}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_cmd}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_strm}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_bank}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_line}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_cmd}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_strm}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_bank}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_line}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_cmd}}     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_strm}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_bank}}    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group FINAL_FIFO -group CHAN{1} -group CACHE -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/final_cache_cmd_fifo[{1}]/pipe_peek_twoIn_line}}    '.format(mgr,chan)

  for mgr in range (0, numOfMgr):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/access_set_cmd}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/access_set_page}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/access_set_valid}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/adjacent_bank_request}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cache_cmd_grant_request_cmd}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cache_cmd_grant_request_valid}}        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cache_counter_in}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cache_counter_out}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/can_go}}                               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/can_go_checker_ready}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_bank}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_cmd}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_line}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_page}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_strm}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/chan_final_queue_valid}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_bank_a_page_is_open}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_bank_open_page}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/clk}}                                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/cmd_can_go}}                           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__cntl}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__cntl_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__data}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__data_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__init_done}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__init_done_d1}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__valid}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi__mmc__valid_d1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dram_cmd_mode}}                        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/grant_send_to_stream}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__addr}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__addr_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__bank}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__bank_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cmd0}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cmd0_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cmd1}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cmd1_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cs}}                         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__cs_e1}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__data}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__dfi__data_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__cntl}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__cntl_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__data}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__data_e1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__data_ready}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__data_ready_e1}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__ready}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__ready_e1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__valid}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/mmc__xxx__valid_e1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/page_cmd_grant_request_cmd}}           '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/page_cmd_grant_request_valid}}         '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_pipe_read}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_send_to_stream}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_valid}}                        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/requested_bank}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/requested_line}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/requested_page}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/reset_poweron}}                        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_bank}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_cmd}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_done}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_line}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_page}}                     '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_request}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_access_sequence}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_bank_latched}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_enable}}                          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_is_read_latched}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_is_write_latched}}                '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_line_latched}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_page_latched}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_seq_type}}                        '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_tag}}                             '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_write_data_available}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/strm_write_data_read}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/sys__mgr__mgrId}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/waiting_to_send_to_stream}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/write_data_fifo_output_data}}          '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__bank}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__bank_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__channel}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__channel_d1}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__cntl}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__cntl_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_channel}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_channel_d1}}            '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_cntl}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_cntl_d1}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_mask}}                  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_mask_d1}}               '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_valid}}                 '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__data_valid_d1}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__page}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__page_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__read}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__read_d1}}                    '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__ready}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__ready_d1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__valid}}                      '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__valid_d1}}                   '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__word}}                       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group MMC_GENERAL -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/xxx__mmc__word_d1}}                    '.format(mgr,chan)


  for mgr in range (0, numOfMgr):
      for intf in range (0, 3):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/clear}}            '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/almost_full}}      '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/write}}            '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group WRITE -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/write_data}}       '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_valid}}        '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_read}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_data}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_cntl}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_is_read}}      '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_is_write}}     '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_channel}}      '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_bank}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_page}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_word}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_line}}         '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_som}}          '.format(mgr,intf)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group REQUEST_FIFO -group IN{1} -group READ -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/request_fifo[{1}]/pipe_eom}}          '.format(mgr,intf)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/mmc_cntl_strm_sel_state}}       '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/mmc_cntl_strm_sel_state_next}}  '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/strm_ena[0]/strm}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/strm_ena[1]/strm}}              '.format(mgr,chan)
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SEL_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/channel_strm_select_fsm[{1}]/strm_ena[2]/strm}}              '.format(mgr,chan)

  for mgr in range (0, numOfMgr):
    for chan in range (0, numOfChannels):
        pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group DFI_SEQ_FSM -group CHAN{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/main_mem_cntl/dfi_seq_fsm[{1}]/mmc_cntl_seq_state}}'.format(mgr,chan)

  f.write(pLine)
  f.close()




  f = open("../SIMULATION/sv/sdp.do", "w")

  pLine = ""
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/mgr__stu__ready}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__cntl}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__oob_data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__type}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[0]/manager/stu_cntl/stu__mgr__valid}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/mgr__stu__ready}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__cntl}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__oob_data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__type}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[1]/manager/stu_cntl/stu__mgr__valid}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/mgr__stu__ready}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__cntl}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__oob_data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__type}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[2]/manager/stu_cntl/stu__mgr__valid}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/mgr__stu__ready}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__cntl}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__oob_data}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__type}}'.format(mgr,strm,lane)
  pLine = pLine + '\nadd wave -noupdate -expand -group STU -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[3]/manager/stu_cntl/stu__mgr__valid}}'.format(mgr,strm,lane)



  # provide a default for the format
  mgr  = 0
  strm = 0
  chan = 0
  lane = 0
  for mgr in range (0, numOfMgr):
    for strm in range (0, numOfStrms):
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_ms_lane_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/cj_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/clk}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/completed_streaming}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_cntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_eom}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_som}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_som_eom}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpMemory_value}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/consJumpPtr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/create_response_id}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/desc_processor_strm_ack}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/first_time_thru}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/inc_consJumpPtr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/local_storage_desc_ptr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_ms_lane_start_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_line}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/mem_start_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_chan01_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_chan0_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_chan10_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_chan1_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_cons_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/force_disable_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/generate_requests}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/create_mem_request}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state_next}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/channel_change}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/bank_change}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/page_change}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_addr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_addr_chan}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_addr_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_addr_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_end_addr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_end_addr_chan}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_end_addr_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_end_addr_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_inc_addr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_inc_addr_chan}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_inc_addr_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_inc_addr_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_end_is_cons_tm1_end}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_last_requested_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_bank_last_requested}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/pbc_page_last_requested}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/requests_complete}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/reset_poweron}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_AccessOrder}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_Address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_consJump}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_consJumpCntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdmem_consJumpPtr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_cntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__mem_request_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp__xxx__storage_desc_processing_complete}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdp_cntl_proc_storage_desc_state_next}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__cfg_accessOrder}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__cfg_addr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__cfg_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__complete}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__consJump_cntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__consJump_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__consJump_value}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_bank_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_channel_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_cntl}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_cntl_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_line}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_line_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_page_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_valid}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdpr__sdps__response_id_valid_e1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__cfg_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__complete}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__consJump_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__response_id_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sdps__sdpr__response_id_ready_d1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_accessOrder}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_bank}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_bank_lsb}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_channel}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_cline}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_consJumpPtr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_local_address}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_mgr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_page}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/storage_desc_word}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/strm_transfer_type}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/sys__mgr__mgrId}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/to_strm_fsm_fifo_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__lane_enable}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__mem_request_ready}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__mem_request_ready_d1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__num_lanes}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__num_lanes_m1}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__storage_desc_processing_enable}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__storage_desc_ptr}}'.format(mgr,strm,lane,chan)
      pLine = pLine + '\nadd wave -noupdate -group MGR{0} -group SDPR -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_request_cntl/xxx__sdp__txfer_type}}'.format(mgr,strm,lane,chan)






  # provide a default for the format
  mgr  = 0
  strm = 0
  chan = 0
  lane = 0
  for mgr in range (0, numOfMgr):
    for strm in range (0, numOfStrms):
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/sti__stOp__strm{1}_data_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/sti__stOp__strm{1}_cntl}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/sti__stOp__strm{1}_data}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM01 -radix hexadecimal {{/top/system_inst/pe_array_inst/pe_inst[{0}]/pe/stOp_lane[{2}]/streamingOps_datapath/stOp__sti__strm{1}_ready}}'.format(mgr,strm,lane)
      #
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/xxx__sdp__lane_ready}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp_cntl_stream_cntl_state}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp_cntl_stream_cntl_state_next}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/all_lanes_complete}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/running}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/flush_complete}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/force_flush}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/request_read_diff}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/request_read_diff_eq0}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/request_read_diff_gt0}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/request_read_diff_lt0}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/pipe_data}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[0]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/pipe_data}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group FROM_MMC -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/from_mmc_fifo[1]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_cntl}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_bank}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_page}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_line}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_som}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_mom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_eom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/response_id_in_progress}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[0]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_cntl}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_bank}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_page}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_line}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_som}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_mom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_eom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/response_id_in_progress}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -expand -group RESPONSE_ID -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/response_id_fifo[1]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/block_request[0]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/block_request[1]}}'.format(mgr,strm,lane)
      #
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/get_next_line[0]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/get_next_line[1]}}'.format(mgr,strm,lane)
      #
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp__xxx__get_next_line[0]}} '.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/all_lanes_complete}}'.format(mgr,strm,lane)
      #
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_req_next_line[0][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_req_next_line[1][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_force_req_next_line[0][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_force_req_next_line[1][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_force_req_next_line}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/neither_match[0][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/neither_match[1][{2}]}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp__xxx__get_next_line[0]}} '.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/sdp__xxx__get_next_line[1]}} '.format(mgr,strm,lane)
      #
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_consJumpCntl}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_consJumpValue}}'.format(mgr,strm,lane)
      #
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/all_lanes_loaded_consequtive}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/all_lanes_loaded_jump}}'.format(mgr,strm,lane)
      #
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_loaded_consequtive}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_loaded_jump}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_loading_consequtive}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_loading_jump}}'.format(mgr,strm,lane)
      #
      #
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_addr}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_num_lanes}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_num_lanes_m1}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_order}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_tgt}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_transfer_type}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/addr_to_strm_fsm_fifo[0]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_consJumpCntl}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_consJumpValue}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_eom}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_read}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_som}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/pipe_valid}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/consJump_to_strm_fsm_fifo[0]/write}}'.format(mgr,strm,lane)
      pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/exec_lane_enable}}'.format(mgr,strm,lane)
      #
      #
      for lane in [0,7,15,23,31] :
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sdp_cntl_stream_data_state}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/req_next_line[0]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/force_req_next_line[0]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_match[0]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_next_match[0]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/req_next_line[1]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/force_req_next_line[1]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_match[1]}} '.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_next_match[1]}} '.format(mgr,strm,lane)
        #
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sdp_cntl_stream_data_state}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_channel_ptr}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_bank_ptr}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_line_ptr}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_word_ptr}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_channel_ptr_e1}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_bank_ptr_e1}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_line_ptr_e1}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_word_ptr_e1}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/consequtive_counter_le0}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_data_available}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sent_data_without_increment}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/destination_ready}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/consequtive_counter}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_next_inc_cons_start_address}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/last_consequtive}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sdp_cntl_stream_data_state}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_match[0]}}'.format(mgr,strm,lane) 
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_address_match[1]}}'.format(mgr,strm,lane) 
        #
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_req_next_line[0][{2}]}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lanes_req_next_line[1][{2}]}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/req_next_line_but_not_accepted}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/send_data}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_running}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/lane_data_available}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/destination_ready}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/sdp_cntl_stream_data_state}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/loaded_consequtive}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/loaded_jump}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/loading_consequtive}}'.format(mgr,strm,lane)
        pLine = pLine + '\nadd wave -noupdate -expand -group MGR{0} -expand -group SDPS -group STRM{1} -group LANE{2} -radix hexadecimal {{/top/system_inst/manager_array_inst/mgr_inst[{0}]/manager/mrc_cntl_strm_inst[{1}]/mrc_cntl/sdp_cntl/sdp_stream_cntl/lane_fsm[{2}]/loading_jump}}'.format(mgr,strm,lane)

  f.write(pLine)
  f.close()


