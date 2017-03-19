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


  #------------------------------------------------------------------------------------------------------------------------------------------------------
  # Manager Arrary

  f = open('../../Manager/HDL/common/system_manager_stack_bus_upstream_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n    input                                          stu__mgr{0}__valid          ;'.format(pe)
    pLine = pLine + '\n    input   [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr{0}__cntl           ;'.format(pe) 
    pLine = pLine + '\n    output                                         mgr{0}__stu__ready          ;'.format(pe) 
    pLine = pLine + '\n    input   [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr{0}__type           ;'.format(pe) 
    pLine = pLine + '\n    input   [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr{0}__data           ;'.format(pe) 
    pLine = pLine + '\n    input   [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr{0}__oob_data       ;'.format(pe) 
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_downstream_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                  '.format(pe) 
    pLine = pLine + '\n  input                                         sys__pe{0}__allSynchronized     ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__sys__thisSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__sys__ready               ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__sys__complete            ;'.format(pe) 
    #                                                                                                              
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                  '.format(pe) 
    pLine = pLine + '\n  input [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr{0}__std__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  input                                         mgr{0}__std__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  output                                        std__mgr{0}__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr{0}__std__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr{0}__std__oob_data            ;'.format(pe) 
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  output                                          std__mgr{0}__lane{1}_strm{2}_ready       ;'.format(pe,lane,strm)
        pLine = pLine + '\n  input [`COMMON_STD_INTF_CNTL_RANGE      ]       mgr{0}__std__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  input [`STACK_DOWN_INTF_STRM_DATA_RANGE ]       mgr{0}__std__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  input                                           mgr{0}__std__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_downstream_instance_wires.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                '.format(pe) 
    pLine = pLine + '\n  //wire[`PE_PE_ID_RANGE                 ]      sys__pe{0}__peId                ;'.format(pe) 
    pLine = pLine + '\n  wire                                        sys__pe{0}__allSynchronized     ;'.format(pe) 
    pLine = pLine + '\n  wire                                        pe{0}__sys__thisSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  wire                                        pe{0}__sys__ready               ;'.format(pe) 
    pLine = pLine + '\n  wire                                        pe{0}__sys__complete            ;'.format(pe) 
    #                                                                                                            
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                '.format(pe) 
    pLine = pLine + '\n  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr{0}__std__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  wire                                        mgr{0}__std__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  wire                                        std__mgr{0}__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr{0}__std__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr{0}__std__oob_data            ;'.format(pe) 
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  wire                                        std__mgr{0}__lane{1}_strm{2}_ready       ;'.format(pe,lane,strm)
        pLine = pLine + '\n  wire [`COMMON_STD_INTF_CNTL_RANGE       ]   mgr{0}__std__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]   mgr{0}__std__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  wire                                        mgr{0}__std__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'
     
  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_downstream_instance_connections.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #
    pLine = pLine + '\n  assign  sys__pe{0}__allSynchronized                 =  mgr_inst[{0}].sys__pe__allSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  assign  mgr_inst[{0}].pe__sys__thisSynchronized     =  pe{0}__sys__thisSynchronized              ;'.format(pe)
    pLine = pLine + '\n  assign  mgr_inst[{0}].pe__sys__ready                =  pe{0}__sys__ready                         ;'.format(pe)
    pLine = pLine + '\n  assign  mgr_inst[{0}].pe__sys__complete             =  pe{0}__sys__complete                      ;'.format(pe)
    #                                                                                                                  
    pLine = pLine + '\n  assign  mgr{0}__std__oob_cntl                       =  mgr_inst[{0}].mgr__std__oob_cntl       ;'.format(pe) 
    pLine = pLine + '\n  assign  mgr{0}__std__oob_valid                      =  mgr_inst[{0}].mgr__std__oob_valid      ;'.format(pe) 
    pLine = pLine + '\n  assign  mgr_inst[{0}].std__mgr__oob_ready           =  std__mgr{0}__oob_ready                 ;'.format(pe)
    pLine = pLine + '\n  assign  mgr{0}__std__oob_tystd                      =  mgr_inst[{0}].mgr__std__oob_tystd      ;'.format(pe) 
    pLine = pLine + '\n  assign  mgr{0}__std__oob_data                       =  mgr_inst[{0}].mgr__std__oob_data       ;'.format(pe) 
    #
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  assign  mgr_inst[{0}].std__mgr__lane{1}_strm{2}_ready   =  std__mgr{0}__lane{1}_strm{2}_ready                  ;'.format(pe,lane,strm)
        pLine = pLine + '\n  assign  mgr{0}__std__lane{1}_strm{2}_cntl               =  mgr_inst[{0}].mgr__std__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  assign  mgr{0}__std__lane{1}_strm{2}_data               =  mgr_inst[{0}].mgr__std__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  assign  mgr{0}__std__lane{1}_strm{2}_data_valid         =  mgr_inst[{0}].mgr__std__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_upstream_instance_wires.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n    wire                                           stu__mgr{0}__valid          ;'.format(pe)
    pLine = pLine + '\n    wire    [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr{0}__cntl           ;'.format(pe) 
    pLine = pLine + '\n    wire                                           mgr{0}__stu__ready          ;'.format(pe) 
    pLine = pLine + '\n    wire    [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr{0}__type           ;'.format(pe) 
    pLine = pLine + '\n    wire    [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr{0}__data           ;'.format(pe) 
    pLine = pLine + '\n    wire    [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr{0}__oob_data       ;'.format(pe) 
    pLine = pLine + '\n'
  pLine = pLine + '\n'
     
  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_upstream_instance_connections.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  assign   mgr_inst[{0}].stu__mgr__valid     =   stu__mgr{0}__valid               ;'.format(pe)
    pLine = pLine + '\n  assign   mgr_inst[{0}].stu__mgr__cntl      =   stu__mgr{0}__cntl                ;'.format(pe)
    pLine = pLine + '\n  assign   mgr__stu{0}__ready                =   mgr_inst[{0}].mgr__stu__ready    ;'.format(pe) 
    pLine = pLine + '\n  assign   mgr_inst[{0}].stu__mgr__type      =   stu__mgr{0}__type                ;'.format(pe)
    pLine = pLine + '\n  assign   mgr_inst[{0}].stu__mgr__data      =   stu__mgr{0}__data                ;'.format(pe)
    pLine = pLine + '\n  assign   mgr_inst[{0}].stu__mgr__oob_data  =   stu__mgr{0}__oob_data            ;'.format(pe)
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_downstream_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n            // General control and status                  ,'.format(pe) 
    pLine = pLine + '\n            //sys__pe{0}__peId                               ,'.format(pe) 
    pLine = pLine + '\n            sys__pe{0}__allSynchronized                    ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__sys__thisSynchronized                   ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__sys__ready                              ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__sys__complete                           ,'.format(pe) 
    #
    pLine = pLine + '\n            // OOB controls the PE                         ,'.format(pe) 
    pLine = pLine + '\n            // For now assume OOB is separate to lanes     ,'.format(pe) 
    pLine = pLine + '\n            mgr{0}__std__oob_cntl                           ,'.format(pe) 
    pLine = pLine + '\n            mgr{0}__std__oob_valid                          ,'.format(pe) 
    pLine = pLine + '\n            std__mgr{0}__oob_ready                          ,'.format(pe) 
    pLine = pLine + '\n            mgr{0}__std__oob_type                           ,'.format(pe) 
    pLine = pLine + '\n            mgr{0}__std__oob_data                           ,'.format(pe) 
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n            std__mgr{0}__lane{1}_strm{2}_ready       ,'.format(pe,lane,strm)
        pLine = pLine + '\n            mgr{0}__std__lane{1}_strm{2}_cntl        ,'.format(pe,lane,strm) 
        pLine = pLine + '\n            mgr{0}__std__lane{1}_strm{2}_data        ,'.format(pe,lane,strm) 
        pLine = pLine + '\n            mgr{0}__std__lane{1}_strm{2}_data_valid  ,'.format(pe,lane,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  #------------------------------------------------------------------------------------------------------------------------------------------------------
  # Manager

  #--------------------------------------------------
  # Downstream Stack Bus

  f = open('../HDL/common/manager_stack_bus_downstream_port_declarations.vh', 'w')
  pLine = ""

  #
  pLine = pLine + '\n  // OOB carries PE configuration                                           '
  pLine = pLine + '\n  output[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl            ;' 
  pLine = pLine + '\n  output                                        mgr__std__oob_valid           ;' 
  pLine = pLine + '\n  input                                         std__mgr__oob_ready           ;' 
  pLine = pLine + '\n  output[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type            ;' 
  pLine = pLine + '\n  output[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data            ;' 
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // Lane operand bus                 '.format(lane)
    pLine = pLine + '\n  input                                            std__mgr__lane{0}_strm0_ready       ;'.format(lane)
    pLine = pLine + '\n  output[`COMMON_STD_INTF_CNTL_RANGE       ]       mgr__std__lane{0}_strm0_cntl        ;'.format(lane) 
    pLine = pLine + '\n  output[`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       mgr__std__lane{0}_strm0_data        ;'.format(lane) 
    pLine = pLine + '\n  output                                           mgr__std__lane{0}_strm0_data_valid  ;'.format(lane) 
    pLine = pLine + '\n  input                                            std__mgr__lane{0}_strm1_ready       ;'.format(lane)
    pLine = pLine + '\n  output[`COMMON_STD_INTF_CNTL_RANGE       ]       mgr__std__lane{0}_strm1_cntl        ;'.format(lane) 
    pLine = pLine + '\n  output[`STACK_DOWN_INTF_STRM_DATA_RANGE  ]       mgr__std__lane{0}_strm1_data        ;'.format(lane) 
    pLine = pLine + '\n  output                                           mgr__std__lane{0}_strm1_data_valid  ;'.format(lane) 
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/manager_stack_bus_downstream_instance_wires.vh', 'w')
  pLine = ""

  pLine = pLine + '\n  // General control and status                                             ' 
  pLine = pLine + '\n  wire [`PE_PE_ID_RANGE                 ]     sys__pe__peId                ;' 
  pLine = pLine + '\n  wire                                        sys__pe__allSynchronized     ;' 
  pLine = pLine + '\n  wire                                        pe__sys__thisSynchronized    ;' 
  pLine = pLine + '\n  wire                                        pe__sys__ready               ;' 
  pLine = pLine + '\n  wire                                        pe__sys__complete            ;' 
  #
  pLine = pLine + '\n  // OOB carries PE configuration                                           '
  pLine = pLine + '\n  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr__std__oob_cntl            ;' 
  pLine = pLine + '\n  wire                                        mgr__std__oob_valid           ;' 
  pLine = pLine + '\n  wire                                        std__mgr__oob_ready           ;' 
  pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr__std__oob_type            ;' 
  pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr__std__oob_data            ;' 
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n  // Lane operand bus                 '.format(lane)
    pLine = pLine + '\n  wire                                           std__mgr__lane{0}_strm0_ready       ;'.format(lane)
    pLine = pLine + '\n  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane{0}_strm0_cntl        ;'.format(lane) 
    pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane{0}_strm0_data        ;'.format(lane) 
    pLine = pLine + '\n  wire                                           mgr__std__lane{0}_strm0_data_valid  ;'.format(lane) 
    pLine = pLine + '\n  wire                                           std__mgr__lane{0}_strm1_ready       ;'.format(lane)
    pLine = pLine + '\n  wire [`COMMON_STD_INTF_CNTL_RANGE       ]      mgr__std__lane{0}_strm1_cntl        ;'.format(lane) 
    pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]      mgr__std__lane{0}_strm1_data        ;'.format(lane) 
    pLine = pLine + '\n  wire                                           mgr__std__lane{0}_strm1_data_valid  ;'.format(lane) 

  f.write(pLine)
  f.close()

  f = open('../HDL/common/manager_stack_bus_downstream_instance_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n               // General control and status                                                 '
  pLine = pLine + '\n               .sys__pe__peId                      ( sys__pe__peId                   ),      '
  pLine = pLine + '\n               .sys__pe__allSynchronized           ( sys__pe__allSynchronized        ),      '
  pLine = pLine + '\n               .pe__sys__thisSynchronized          ( pe__sys__thisSynchronized       ),      '
  pLine = pLine + '\n               .pe__sys__ready                     ( pe__sys__ready                  ),      '
  pLine = pLine + '\n               .pe__sys__complete                  ( pe__sys__complete               ),      '

  pLine = pLine + '\n               // OOB carries PE configuration                                               '
  pLine = pLine + '\n               .mgr__std__oob_cntl                  ( mgr__std__oob_cntl               ),      '
  pLine = pLine + '\n               .mgr__std__oob_valid                 ( mgr__std__oob_valid              ),      '
  pLine = pLine + '\n               .std__mgr__oob_ready                 ( std__mgr__oob_ready              ),      '
  pLine = pLine + '\n               .mgr__std__oob_type                  ( mgr__std__oob_type               ),      '
  pLine = pLine + '\n               .mgr__std__oob_data                  ( mgr__std__oob_data               ),      '
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n               // Lane {0}                 '.format(lane)
    for strm in range (0, 2):
      pLine = pLine + '\n               .std__mgr__lane{0}_strm{1}_ready         ( std__mgr__lane{0}_strm{1}_ready      ),      '.format(lane,strm)
      pLine = pLine + '\n               .mgr__std__lane{0}_strm{1}_cntl          ( mgr__std__lane{0}_strm{1}_cntl       ),      '.format(lane,strm)
      pLine = pLine + '\n               .mgr__std__lane{0}_strm{1}_data          ( mgr__std__lane{0}_strm{1}_data       ),      '.format(lane,strm)
      pLine = pLine + '\n               .mgr__std__lane{0}_strm{1}_data_valid    ( mgr__std__lane{0}_strm{1}_data_valid ),      '.format(lane,strm)
                                             
  f.write(pLine)
  f.close()


  f = open('../HDL/common/manager_stack_bus_downstream_ports.vh', 'w')
  pLine = ""

  pLine = pLine + '\n            // General control and status                ,' 
  pLine = pLine + '\n            sys__mgr__mgrId                              ,' 
  pLine = pLine + '\n            sys__mgr__allSynchronized                    ,' 
  pLine = pLine + '\n            mgr__sys__thisSynchronized                   ,' 
  pLine = pLine + '\n            mgr__sys__ready                              ,' 
  pLine = pLine + '\n            mgr__sys__complete                           ,' 
  #
  pLine = pLine + '\n            // OOB controls how the lanes are interpreted,' 
  pLine = pLine + '\n            mgr__std__oob_cntl                           ,' 
  pLine = pLine + '\n            mgr__std__oob_valid                          ,' 
  pLine = pLine + '\n            std__mgr__oob_ready                          ,' 
  pLine = pLine + '\n            mgr__std__oob_type                           ,' 
  pLine = pLine + '\n            mgr__std__oob_data                           ,' 
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n            // Lane operand bus                 '.format(lane)
    pLine = pLine + '\n            std__mgr__lane{0}_strm0_ready       ,'.format(lane)
    pLine = pLine + '\n            mgr__std__lane{0}_strm0_cntl        ,'.format(lane) 
    pLine = pLine + '\n            mgr__std__lane{0}_strm0_data        ,'.format(lane) 
    pLine = pLine + '\n            mgr__std__lane{0}_strm0_data_valid  ,'.format(lane) 
    pLine = pLine + '\n            std__mgr__lane{0}_strm1_ready       ,'.format(lane)
    pLine = pLine + '\n            mgr__std__lane{0}_strm1_cntl        ,'.format(lane) 
    pLine = pLine + '\n            mgr__std__lane{0}_strm1_data        ,'.format(lane) 
    pLine = pLine + '\n            mgr__std__lane{0}_strm1_data_valid  ,'.format(lane) 
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  #--------------------------------------------------
  # Upstream Stack Bus

  f = open('../HDL/common/system_manager_stack_bus_upstream_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n            stu__mgr{0}__valid          ,'.format(pe)
    pLine = pLine + '\n            stu__mgr{0}__cntl           ,'.format(pe) 
    pLine = pLine + '\n            mgr{0}__stu__ready          ,'.format(pe) 
    pLine = pLine + '\n            stu__mgr{0}__type           ,'.format(pe) 
    pLine = pLine + '\n            stu__mgr{0}__data           ,'.format(pe) 
    pLine = pLine + '\n            stu__mgr{0}__oob_data       ,'.format(pe) 
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_upstream_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n    input                                         stu__mgr{0}__valid          ;'.format(pe)
    pLine = pLine + '\n    input  [`COMMON_STD_INTF_CNTL_RANGE   ]       stu__mgr{0}__cntl           ;'.format(pe) 
    pLine = pLine + '\n    output                                        mgr{0}__stu__ready          ;'.format(pe) 
    pLine = pLine + '\n    input  [`STACK_UP_INTF_TYPE_RANGE     ]       stu__mgr{0}__type           ;'.format(pe) 
    pLine = pLine + '\n    input  [`STACK_UP_INTF_DATA_RANGE     ]       stu__mgr{0}__data           ;'.format(pe) 
    pLine = pLine + '\n    input  [`STACK_UP_INTF_OOB_DATA_RANGE ]       stu__mgr{0}__oob_data       ;'.format(pe) 
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()
