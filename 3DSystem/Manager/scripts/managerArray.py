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


  #------------------------------------------------------------------------------------------------------------------------------------------------------
  # Manager Arrary

  f = open('../../Manager/HDL/common/system_manager_stack_bus_upstream_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
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


  #------------------------------------------------------------------------------------------------------------------------------------------------------
  # Manager

  f = open('../HDL/common/manager_stack_bus_downstream_port_declarations.vh', 'w')
  pLine = ""

  #
  pLine = pLine + '\n  // OOB carries PE configuration                                           '.format(lane,mgr,strm) 
  pLine = pLine + '\n  output[`COMMON_STD_INTF_CNTL_RANGE     ]      std__mgr__oob_cntl            ;'.format(lane,mgr,strm) 
  pLine = pLine + '\n  output                                        std__mgr__oob_valid           ;'.format(lane,mgr,strm) 
  pLine = pLine + '\n  input                                         mgr__std__oob_ready           ;'.format(lane,mgr,strm) 
  pLine = pLine + '\n  output[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__mgr__oob_type            ;'.format(lane,mgr,strm) 
  pLine = pLine + '\n  output[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__mgr__oob_data            ;'.format(lane,mgr,strm) 
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // Lane operand bus                 '.format(lane)
    pLine = pLine + '\n  input                                            mgr__std__lane{0}_strm0_ready       ;'.format(lane)
    pLine = pLine + '\n  output[`COMMON_STD_INTF_CNTL_RANGE       ]       std__mgr__lane{0}_strm0_cntl        ;'.format(lane) 
    pLine = pLine + '\n  output[`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       std__mgr__lane{0}_strm0_data        ;'.format(lane) 
    pLine = pLine + '\n  output                                           std__mgr__lane{0}_strm0_data_valid  ;'.format(lane) 
    pLine = pLine + '\n  input                                            mgr__std__lane{0}_strm1_ready       ;'.format(lane)
    pLine = pLine + '\n  output[`COMMON_STD_INTF_CNTL_RANGE       ]       std__mgr__lane{0}_strm1_cntl        ;'.format(lane) 
    pLine = pLine + '\n  output[`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       std__mgr__lane{0}_strm1_data        ;'.format(lane) 
    pLine = pLine + '\n  output                                           std__mgr__lane{0}_strm1_data_valid  ;'.format(lane) 
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()

