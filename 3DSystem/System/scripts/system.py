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

  FoundLanes = False
  searchFile = open("../../PEArray/HDL/common/pe.vh", "r")
  for line in searchFile:
    if FoundLanes == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_EXEC_LANES" in data[1]:
        numOfExecLanes = int(data[2])
        FoundLanes = True
  searchFile.close()


  #----------------------------------------------------------------------------------------------------
  # Declare Manager and PE ports

  # port directions are opposite to Manager and PE, so need a new file

  f = open('../HDL/common/system_stack_bus_upstream_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n    output                                         stu__mgr{0}__valid          ;'.format(pe)
    pLine = pLine + '\n    output  [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr{0}__cntl           ;'.format(pe) 
    pLine = pLine + '\n    input                                          mgr{0}__stu__ready          ;'.format(pe) 
    pLine = pLine + '\n    output  [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr{0}__type           ;'.format(pe) 
    pLine = pLine + '\n    output  [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr{0}__data           ;'.format(pe) 
    pLine = pLine + '\n    output  [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr{0}__oob_data       ;'.format(pe) 
    pLine = pLine + '\n'
    pLine = pLine + '\n    input                                          pe{0}__stu__valid          ;'.format(pe)
    pLine = pLine + '\n    input   [`COMMON_STD_INTF_CNTL_RANGE   ]       pe{0}__stu__cntl           ;'.format(pe) 
    pLine = pLine + '\n    output                                         stu__pe{0}__ready          ;'.format(pe) 
    pLine = pLine + '\n    input   [`STACK_UP_INTF_TYPE_RANGE     ]       pe{0}__stu__type           ;'.format(pe) 
    pLine = pLine + '\n    input   [`STACK_UP_INTF_DATA_RANGE     ]       pe{0}__stu__data           ;'.format(pe) 
    pLine = pLine + '\n    input   [`STACK_UP_INTF_OOB_DATA_RANGE ]       pe{0}__stu__oob_data       ;'.format(pe) 
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_sys_general_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                   '.format(pe) 
    pLine = pLine + '\n  input                                         mgr{0}__sys__allSynchronized     ;'.format(pe) 
    pLine = pLine + '\n  output                                        sys__mgr{0}__thisSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  output                                        sys__mgr{0}__ready               ;'.format(pe) 
    pLine = pLine + '\n  output                                        sys__mgr{0}__complete            ;'.format(pe) 
    pLine = pLine + '\n'
    pLine = pLine + '\n  output                                        sys__pe{0}__allSynchronized     ;'.format(pe) 
    pLine = pLine + '\n  input                                         pe{0}__sys__thisSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  input                                         pe{0}__sys__ready               ;'.format(pe) 
    pLine = pLine + '\n  input                                         pe{0}__sys__complete            ;'.format(pe) 
    pLine = pLine + '\n'
    #                                                                                                              

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_stack_bus_downstream_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #                                                                                                              
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                  '.format(pe) 
    pLine = pLine + '\n  input   [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr{0}__std__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  input                                           mgr{0}__std__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  output                                          std__mgr{0}__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  input   [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr{0}__std__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  input   [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr{0}__std__oob_data            ;'.format(pe) 
    pLine = pLine + '\n'
    pLine = pLine + '\n  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe{0}__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  output                                          std__pe{0}__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  input                                           pe{0}__std__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe{0}__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe{0}__oob_data            ;'.format(pe) 
    pLine = pLine + '\n'
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  output                                            std__mgr{0}__lane{1}_strm{2}_ready       ;'.format(pe,lane,strm)
        pLine = pLine + '\n  input   [`COMMON_STD_INTF_CNTL_RANGE      ]       mgr{0}__std__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  input   [`STACK_DOWN_INTF_STRM_DATA_RANGE ]       mgr{0}__std__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  input                                             mgr{0}__std__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'         
        pLine = pLine + '\n  input                                             pe{0}__std__lane{1}_strm{2}_ready       ;'.format(pe,lane,strm)
        pLine = pLine + '\n  output  [`COMMON_STD_INTF_CNTL_RANGE      ]       std__pe{0}__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  output  [`STACK_DOWN_INTF_STRM_DATA_RANGE ]       std__pe{0}__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  output                                            std__pe{0}__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  #----------------------------------------------------------------------------------------------------
  # Connected Manager and PE ports 

  f = open('../HDL/common/system_stack_bus_downstream_instance_connections.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #                                                                                                              
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                  '.format(pe) 
    pLine = pLine + '\n assign    std__pe{0}__oob_cntl    =    mgr{0}__std__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n assign    std__pe{0}__oob_valid   =    mgr{0}__std__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n assign    pe{0}__std__oob_ready   =    std__mgr{0}__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n assign    std__pe{0}__oob_type    =    mgr{0}__std__oob_type            ;'.format(pe) 
    pLine = pLine + '\n assign    std__pe{0}__oob_data    =    mgr{0}__std__oob_data            ;'.format(pe) 
    pLine = pLine + '\n'
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n assign    std__mgr{0}__lane{1}_strm{2}_ready      =    pe{0}__std__lane{1}_strm{2}_ready        ;'.format(pe,lane,strm)
        pLine = pLine + '\n assign    std__pe{0}__lane{1}_strm{2}_cntl        =    mgr{0}__std__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n assign    std__pe{0}__lane{1}_strm{2}_data        =    mgr{0}__std__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n assign    std__pe{0}__lane{1}_strm{2}_data_valid  =    mgr{0}__std__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()



  f = open('../HDL/common/system_stack_bus_upstream_instance_connections.vh', 'w')
  pLine = ""
  for pe in range (0, numOfPe):
    pLine = pLine + '\n assign    stu__mgr{0}__valid       =    pe{0}__stu__valid          ;'.format(pe)
    pLine = pLine + '\n assign    stu__mgr{0}__cntl        =    pe{0}__stu__cntl           ;'.format(pe) 
    pLine = pLine + '\n assign    stu__pe{0}__ready        =    mgr{0}__stu__ready         ;'.format(pe) 
    pLine = pLine + '\n assign    stu__mgr{0}__type        =    pe{0}__stu__type           ;'.format(pe) 
    pLine = pLine + '\n assign    stu__mgr{0}__data        =    pe{0}__stu__data           ;'.format(pe) 
    pLine = pLine + '\n assign    stu__mgr{0}__oob_data    =    pe{0}__stu__oob_data       ;'.format(pe) 
    pLine = pLine + '\n'
  pLine = pLine + '\n'


  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_general_instance_connections.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                       '.format(pe) 
    pLine = pLine + '\n  assign    sys__pe{0}__allSynchronized     =    mgr{0}__sys__allSynchronized   ;'.format(pe) 
    pLine = pLine + '\n  assign    sys__mgr{0}__thisSynchronized   =    pe{0}__sys__thisSynchronized   ;'.format(pe) 
    pLine = pLine + '\n  assign    sys__mgr{0}__ready              =    pe{0}__sys__ready              ;'.format(pe) 
    pLine = pLine + '\n  assign    sys__mgr{0}__complete           =    pe{0}__sys__complete           ;'.format(pe) 
    pLine = pLine + '\n'
    #                                                                                                              

  f.write(pLine)
  f.close()








  f = open('../HDL/common/manager_sys_general_connections.vh', 'w')
  pLine = ""
  pLine = pLine + '\n  // Send an \'all\' synchronized to all Managers\'s '
  pLine = pLine + '\n  // sys__mgr__thisSyncnronized basically means all the streams in a PE are complete'
  pLine = pLine + '\n  // The PE controller will move to a \'final\' state once it receives sys__pe__allSynchronized'
  pLine = pLine + '\n  wire  mgr__sys__allSynchronized = mgr_inst[0].sys__mgr__thisSynchronized & '  
  for pe in range (1, numOfPe-1):
    pLine = pLine + '\n                                   mgr_inst[{0}].sys__mgr__thisSynchronized & '.format(pe)
  pLine = pLine + '\n                                   mgr_inst[{0}].sys__mgr__thisSynchronized ; '.format(numOfPe-1)

  f.write(pLine)
  f.close()

  f = open('../HDL/common/manager_sys_general_instance_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n               // General control and status                                                 '
  pLine = pLine + '\n               .sys__mgr__mgrId                     ( sys__mgr__mgrId                  ),      '
  pLine = pLine + '\n               .mgr__sys__allSynchronized           ( mgr__sys__allSynchronized        ),      '
  pLine = pLine + '\n               .sys__mgr__thisSynchronized          ( sys__mgr__thisSynchronized       ),      '
  pLine = pLine + '\n               .sys__mgr__ready                     ( sys__mgr__ready                  ),      '
  pLine = pLine + '\n               .sys__mgr__complete                  ( sys__mgr__complete               ),      '

  f.write(pLine)
  f.close()
