#! /usr/bin/env python

if __name__ == "__main__":

  import sys
  import os
  import math
  import random
  import re

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
    pLine = pLine + '\n  assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__sys__allSynchronized   =   DownstreamStackBusOOB[{0}].sys__pe__allSynchronized                      ; '.format(pe) 
    pLine = pLine + '\n  assign DownstreamStackBusOOB[{0}].pe__sys__thisSynchronized                     =  system_inst.manager_array_inst.mgr_inst[{0}].sys__mgr__thisSynchronized   ; '.format(pe) 
    pLine = pLine + '\n  assign DownstreamStackBusOOB[{0}].pe__sys__ready                                =  system_inst.manager_array_inst.mgr_inst[{0}].sys__mgr__ready              ; '.format(pe) 
    pLine = pLine + '\n  assign DownstreamStackBusOOB[{0}].pe__sys__complete                             =  system_inst.manager_array_inst.mgr_inst[{0}].sys__mgr__complete           ; '.format(pe) 
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
      for strm in range (0, 2):
        pLine = pLine + '\n        //  - doesnt seem to work if you use cb_test for observed signals '
        pLine = pLine + '\n        assign DownstreamStackBusLane[{0}][{1}].pe__std__lane_strm{2}_ready                         =   system_inst.manager_array_inst.mgr_inst[{0}].std__mgr__lane{1}_strm{2}_ready ;      '.format(pe,lane,strm)
        pLine = pLine + '\n        assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__std__lane{1}_strm{2}_cntl          =   DownstreamStackBusLane[{0}][{1}].std__pe__lane_strm{2}_cntl          ;      '.format(pe,lane,strm)
        pLine = pLine + '\n        assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__std__lane{1}_strm{2}_data          =   DownstreamStackBusLane[{0}][{1}].std__pe__lane_strm{2}_data          ;      '.format(pe,lane,strm)
        pLine = pLine + '\n        assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__std__lane{1}_strm{2}_data_valid    =   DownstreamStackBusLane[{0}][{1}].std__pe__lane_strm{2}_data_valid    ;      '.format(pe,lane,strm)
        pLine = pLine + '\n        '
                                             
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_stack_bus_upstream_assignments.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
        pLine = pLine + '\n        //  - doesnt seem to work if you use cb_test for observed signals '
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__valid                                =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__valid    ;      '.format(pe)
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__cntl                                 =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__cntl     ;      '.format(pe)
        pLine = pLine + '\n        assign system_inst.manager_array_inst.mgr_inst[{0}].mgr__stu__ready        =   1\'b1                                                           ;      '.format(pe)
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__type                                 =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__type     ;      '.format(pe)
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__data                                 =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__data     ;      '.format(pe)
        pLine = pLine + '\n        assign UpstreamStackBus[{0}].pe__stu__oob_data                             =   system_inst.manager_array_inst.mgr_inst[{0}].stu__mgr__oob_data ;      '.format(pe)
        pLine = pLine + '\n        '
                                             
  f.write(pLine)
  f.close()

