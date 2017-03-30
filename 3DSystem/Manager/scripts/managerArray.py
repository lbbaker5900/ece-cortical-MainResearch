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
  # General

  f = open('../HDL/common/manager_sys_general_connections.vh', 'w')
  pLine = ""
  pLine = pLine + '\n  // Send an \'all\' synchronized to all Managers\'s '
  pLine = pLine + '\n  // sys__mgr__thisSyncnronized basically means all the streams in a PE are complete'
  pLine = pLine + '\n  // The PE controller will move to a \'final\' state once it receives sys__pe__allSynchronized'
  pLine = pLine + '\n  wire  mgr__sys__allSynchronized = mgr_inst[0].sys__mgr__thisSynchronized & '  
  for pe in range (1, numOfPe-1):
    pLine = pLine + '\n                                   mgr_inst[{0}].sys__mgr__thisSynchronized & '.format(pe)
  pLine = pLine + '\n                                   mgr_inst[{0}].sys__mgr__thisSynchronized ; '.format(numOfPe-1)

  for pe in range (0, numOfPe):
    #
    pLine = pLine + '\n  assign  mgr{0}__sys__allSynchronized                 =  mgr_inst[{0}].mgr__sys__allSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  assign  mgr_inst[{0}].sys__mgr__thisSynchronized     =  sys__mgr{0}__thisSynchronized              ;'.format(pe)
    pLine = pLine + '\n  assign  mgr_inst[{0}].sys__mgr__ready                =  sys__mgr{0}__ready                         ;'.format(pe)
    pLine = pLine + '\n  assign  mgr_inst[{0}].sys__mgr__complete             =  sys__mgr{0}__complete                      ;'.format(pe)
    pLine = pLine + '\n'
    #                                                                                                                  

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

  #------------------------------------------------------------------------------------------------------------------------------------------------------
  # NoC

  
  f = open('../HDL/common/manager_noc_instance_ports.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  .mgr__noc__port{0}_valid           ( mgr__noc__port{0}_valid           ),'.format(port)
    pLine = pLine + '\n  .mgr__noc__port{0}_cntl            ( mgr__noc__port{0}_cntl            ),'.format(port)
    pLine = pLine + '\n  .mgr__noc__port{0}_data            ( mgr__noc__port{0}_data            ),'.format(port)
    pLine = pLine + '\n  .noc__mgr__port{0}_fc              ( noc__mgr__port{0}_fc              ),'.format(port)
    pLine = pLine + '\n  .noc__mgr__port{0}_valid           ( noc__mgr__port{0}_valid           ),'.format(port)
    pLine = pLine + '\n  .noc__mgr__port{0}_cntl            ( noc__mgr__port{0}_cntl            ),'.format(port)
    pLine = pLine + '\n  .noc__mgr__port{0}_data            ( noc__mgr__port{0}_data            ),'.format(port)
    pLine = pLine + '\n  .mgr__noc__port{0}_fc              ( mgr__noc__port{0}_fc              ),'.format(port)
    pLine = pLine + '\n  .sys__mgr__port{0}_destinationMask ( sys__mgr__port{0}_destinationMask ),'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/manager_noc_instance_wires.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  wire                                     mgr__noc__port{0}_valid ;'.format(port)
    pLine = pLine + '\n  wire  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]   mgr__noc__port{0}_cntl  ;'.format(port)
    pLine = pLine + '\n  wire  [`NOC_CONT_NOC_PORT_DATA_RANGE ]   mgr__noc__port{0}_data  ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__mgr__port{0}_fc    ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__mgr__port{0}_valid ;'.format(port)
    pLine = pLine + '\n  wire  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]   noc__mgr__port{0}_cntl  ;'.format(port)
    pLine = pLine + '\n  wire  [`NOC_CONT_NOC_PORT_DATA_RANGE ]   noc__mgr__port{0}_data  ;'.format(port)
    pLine = pLine + '\n  wire                                     mgr__noc__port{0}_fc    ;'.format(port)
    pLine = pLine + '\n  wire  [`MGR_MGR_ID_BITMASK_RANGE     ]   sys__mgr__port{0}_destinationMask ;'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)                
  f.close()                     


  f = open('../HDL/common/noc_interMgr_port_Bitmask_assignments.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for port in range (0, numOfPorts):
      pLine = pLine + '\n    // MGR{0}, Port{1} next hop mask                 '.format(pe,port)
      pLine = pLine + '\n    assign mgr_inst[{0}].sys__mgr__port{1}_destinationMask    = `NOC_CONT_MGR{0}_PORT{1}_DESTINATION_MGR_BITMASK ;'.format(pe,port)

  f.write(pLine)
  f.close()

  # Number of actual ports Per PE (all may not be used)
  portsPerPe = 4

  f = open('../HDL/common/noc_interMgr_connections.vh', 'w')
  pLine = ""

  # extract number of pe's
  FoundNewPe = False
  FoundPort = False
  searchFile = open("../scripts/nocConfig.txt", "r")
  for line in searchFile:
    if "Number of PEs in X direction" in line:
      data = re.split(r'\s{1,}', line)
      arrayX = int(data[7])
      #print arrayX
    elif "Number of PEs in Y direction" in line:
      data = re.split(r'\s{1,}', line)
      arrayY = int(data[7])
      #print arrayY

    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "PE" in data[0]:
      if len(data) == 4 : 
        foundNewPe = True
        for i in range (0, len(data)):
          data[i] = re.sub('[\[\]]', '', data[i])
        srcPe = int(data[1])*arrayX + int(data[2])
        #print 'Generate connections for PE {0} '.format(srcPe)
    if re.search(r"Number of Ports", line) :
      numOfUtilizedPorts = portsPerPe-int(data[4])
      if numOfUtilizedPorts != 0 :
        pLine = pLine + '\n  // Terminate Mgr{0}\'s {1} unused Ports'.format(srcPe,numOfUtilizedPorts )
        for uP in range (int(data[4]), portsPerPe):
          pLine = pLine + '\n  assign mgr_inst[{0}].noc__mgr__port{1}_valid = \'d0 ;'.format(srcPe,uP)
          pLine = pLine + '\n  assign mgr_inst[{0}].noc__mgr__port{1}_cntl  = \'d0 ;'.format(srcPe,uP)
          pLine = pLine + '\n  assign mgr_inst[{0}].noc__mgr__port{1}_data  = \'d0 ;'.format(srcPe,uP)
          pLine = pLine + '\n  assign mgr_inst[{0}].noc__mgr__port{1}_fc    = \'d0 ;'.format(srcPe,uP)
        pLine = pLine + '\n'        
    if re.search(r"Port . Connected to Node", line) :
      #print line
      srcPort  = int(data[1])
      destPe   = int(data[6])*arrayX + int(data[7])
      destPort = int(data[8])
      
      pLine = pLine + '\n  // Connecting Mgr{0} Port{1} to Mgr{2} Port{3}'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n  assign mgr_inst[{2}].noc__mgr__port{3}_valid = mgr_inst[{0}].mgr__noc__port{1}_valid ;'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n  assign mgr_inst[{2}].noc__mgr__port{3}_cntl  = mgr_inst[{0}].mgr__noc__port{1}_cntl  ;'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n  assign mgr_inst[{2}].noc__mgr__port{3}_data  = mgr_inst[{0}].mgr__noc__port{1}_data  ;'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n  assign mgr_inst[{0}].noc__mgr__port{1}_fc    = mgr_inst[{2}].mgr__noc__port{3}_fc    ;'.format(srcPe,srcPort,destPe,destPort)
      pLine = pLine + '\n'        


  f.write(pLine)
  f.close()

  searchFile.close()
  
  f = open('../HDL/common/manager_noc_cntl_noc_ports.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n            // NoC port {0}'.format(port)
    pLine = pLine + '\n            mgr__noc__port{0}_valid            ,'.format(port)
    pLine = pLine + '\n            mgr__noc__port{0}_cntl             ,'.format(port)
    pLine = pLine + '\n            mgr__noc__port{0}_data             ,'.format(port)
    pLine = pLine + '\n            noc__mgr__port{0}_fc               ,'.format(port)
    pLine = pLine + '\n            noc__mgr__port{0}_valid            ,'.format(port)
    pLine = pLine + '\n            noc__mgr__port{0}_cntl             ,'.format(port)
    pLine = pLine + '\n            noc__mgr__port{0}_data             ,'.format(port)
    pLine = pLine + '\n            mgr__noc__port{0}_fc               ,'.format(port)
    pLine = pLine + '\n            sys__mgr__port{0}_destinationMask  ,'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  f = open('../HDL/common/manager_noc_cntl_noc_ports_declaration.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  output                                   mgr__noc__port{0}_valid           ;'.format(port)
    pLine = pLine + '\n  output [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  mgr__noc__port{0}_cntl            ;'.format(port)
    pLine = pLine + '\n  output [`NOC_CONT_NOC_PORT_DATA_RANGE ]  mgr__noc__port{0}_data            ;'.format(port)
    pLine = pLine + '\n  input                                    noc__mgr__port{0}_fc              ;'.format(port)
    pLine = pLine + '\n  input                                    noc__mgr__port{0}_valid           ;'.format(port)
    pLine = pLine + '\n  input  [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  noc__mgr__port{0}_cntl            ;'.format(port)
    pLine = pLine + '\n  input  [`NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__mgr__port{0}_data            ;'.format(port)
    pLine = pLine + '\n  output                                   mgr__noc__port{0}_fc              ;'.format(port)
    pLine = pLine + '\n  input  [`MGR_MGR_ID_BITMASK_RANGE     ]  sys__mgr__port{0}_destinationMask ;'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/noc_to_mgrArray_connection_wires.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  wire                                     mgr__noc__port{0}_valid ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  mgr__noc__port{0}_cntl  ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_DATA_RANGE ]  mgr__noc__port{0}_data  ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__mgr__port{0}_fc    ;'.format(port)
    pLine = pLine + '\n  wire                                     noc__mgr__port{0}_valid ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_CNTL_RANGE ]  noc__mgr__port{0}_cntl  ;'.format(port)
    pLine = pLine + '\n  wire   [`NOC_CONT_NOC_PORT_DATA_RANGE ]  noc__mgr__port{0}_data  ;'.format(port)
    pLine = pLine + '\n  wire                                     mgr__noc__port{0}_fc    ;'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/manager_noc_cntl_noc_ports_instance_ports.vh', 'w')
  pLine = ""

  for port in range (0, numOfPorts):
    pLine = pLine + '\n  // NoC port {0}'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_valid           ( mgr__noc__port{0}_valid           ),'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_cntl            ( mgr__noc__port{0}_cntl            ),'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_data            ( mgr__noc__port{0}_data            ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_fc              ( noc__mgr__port{0}_fc              ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_valid           ( noc__mgr__port{0}_valid           ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_cntl            ( noc__mgr__port{0}_cntl            ),'.format(port)
    pLine = pLine + '\n  .noc__pe__port{0}_data            ( noc__mgr__port{0}_data            ),'.format(port)
    pLine = pLine + '\n  .pe__noc__port{0}_fc              ( mgr__noc__port{0}_fc              ),'.format(port)
    pLine = pLine + '\n  .sys__pe__port{0}_destinationMask ( sys__mgr__port{0}_destinationMask ),'.format(port)
    pLine = pLine + '\n'        
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/manager_noc_connection_wires.vh', 'w')
  pLine = ""

  pLine = pLine + '\n   // Aggregate Control-Path (cp) to NoC '
  pLine = pLine + '\n   wire                                            noc__mcntl__cp_ready      ; '
  pLine = pLine + '\n   wire [`COMMON_STD_INTF_CNTL_RANGE      ] mcntl__noc__cp_cntl       ; '
  pLine = pLine + '\n   wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE           ] mcntl__noc__cp_type       ; '
  pLine = pLine + '\n   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] mcntl__noc__cp_data       ; '
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] mcntl__noc__cp_laneId     ; '
  pLine = pLine + '\n   wire                                            mcntl__noc__cp_strmId     ; '
  pLine = pLine + '\n   wire                                            mcntl__noc__cp_valid      ; '
  pLine = pLine + '\n   // Aggregate Data-Path (cp) from NoC '
  pLine = pLine + '\n   wire                                            mcntl__noc__cp_ready      ; '
  pLine = pLine + '\n   wire [`COMMON_STD_INTF_CNTL_RANGE      ] noc__mcntl__cp_cntl       ; '
  pLine = pLine + '\n   wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE           ] noc__mcntl__cp_type       ; '
  pLine = pLine + '\n   wire [`PE_NOC_INTERNAL_DATA_RANGE             ] noc__mcntl__cp_data       ; '
  pLine = pLine + '\n   wire [`PE_PE_ID_RANGE                         ] noc__mcntl__cp_peId       ; '
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__mcntl__cp_laneId     ; '
  pLine = pLine + '\n   wire                                            noc__mcntl__cp_strmId     ; '
  pLine = pLine + '\n   wire                                            noc__mcntl__cp_valid      ; '
  pLine = pLine + '\n'
  pLine = pLine + '\n   // Aggregate Data-Path (dp) to NoC '
  pLine = pLine + '\n   wire                                            noc__mcntl__dp_ready      ; '
  pLine = pLine + '\n   wire [`COMMON_STD_INTF_CNTL_RANGE      ] mcntl__noc__dp_cntl       ; '
  pLine = pLine + '\n   wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE           ] mcntl__noc__dp_type       ; '
  pLine = pLine + '\n   wire [`PE_PE_ID_RANGE                         ] mcntl__noc__dp_peId       ; '
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] mcntl__noc__dp_laneId     ; '
  pLine = pLine + '\n   wire                                            mcntl__noc__dp_strmId     ; '
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] mcntl__noc__dp_data       ; '
  pLine = pLine + '\n   wire                                            mcntl__noc__dp_valid      ; '
  pLine = pLine + '\n   // Aggregate Data-Path (dp) from NoC '
  pLine = pLine + '\n   wire                                            mcntl__noc__dp_ready      ; '
  pLine = pLine + '\n   wire [`COMMON_STD_INTF_CNTL_RANGE      ] noc__mcntl__dp_cntl       ; '
  pLine = pLine + '\n   wire [`NOC_CONT_NOC_PACKET_TYPE_RANGE           ] noc__mcntl__dp_type       ; '
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_EXEC_LANE_ID_RANGE   ] noc__mcntl__dp_laneId     ; '
  pLine = pLine + '\n   wire                                            noc__mcntl__dp_strmId     ; '
  pLine = pLine + '\n   wire [`STREAMING_OP_CNTL_DATA_RANGE           ] noc__mcntl__dp_data       ; '
  pLine = pLine + '\n   wire                                            noc__mcntl__dp_valid      ; '
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()



  #------------------------------------------------------------------------------------------------------------------------------------------------------
  # Manager Array

  f = open('../HDL/common/system_manager_sys_general_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n            // General control and status                    '.format(pe) 
    pLine = pLine + '\n            mgr{0}__sys__allSynchronized                    ,'.format(pe) 
    pLine = pLine + '\n            sys__mgr{0}__thisSynchronized                   ,'.format(pe) 
    pLine = pLine + '\n            sys__mgr{0}__ready                              ,'.format(pe) 
    pLine = pLine + '\n            sys__mgr{0}__complete                           ,'.format(pe) 
    pLine = pLine + '\n'
    #

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

  f = open('../HDL/common/system_manager_stack_bus_downstream_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #
    pLine = pLine + '\n            //-----------------------------------------------------------'
    pLine = pLine + '\n            // Manager Lane arguments to the PE                          '
    pLine = pLine + '\n'
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n            // manager {0}, lane {1}, stream {2}      '.format(pe,lane,strm) 
        pLine = pLine + '\n            std__mgr{0}__lane{1}_strm{2}_ready       ,'.format(pe,lane,strm)
        pLine = pLine + '\n            mgr{0}__std__lane{1}_strm{2}_cntl        ,'.format(pe,lane,strm) 
        pLine = pLine + '\n            mgr{0}__std__lane{1}_strm{2}_data        ,'.format(pe,lane,strm) 
        pLine = pLine + '\n            mgr{0}__std__lane{1}_strm{2}_data_valid  ,'.format(pe,lane,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_downstream_oob_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #
    pLine = pLine + '\n            // OOB controls the PE                          '.format(pe) 
    pLine = pLine + '\n            // For now assume OOB is separate to lanes      '.format(pe) 
    pLine = pLine + '\n            mgr{0}__std__oob_cntl                           ,'.format(pe) 
    pLine = pLine + '\n            mgr{0}__std__oob_valid                          ,'.format(pe) 
    pLine = pLine + '\n            std__mgr{0}__oob_ready                          ,'.format(pe) 
    pLine = pLine + '\n            mgr{0}__std__oob_type                           ,'.format(pe) 
    pLine = pLine + '\n            mgr{0}__std__oob_data                           ,'.format(pe) 
    pLine = pLine + '\n'
  f.write(pLine)
  f.close()

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

  f = open('../HDL/common/system_manager_sys_general_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                   '.format(pe) 
    pLine = pLine + '\n  output                                        mgr{0}__sys__allSynchronized     ;'.format(pe) 
    pLine = pLine + '\n  input                                         sys__mgr{0}__thisSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  input                                         sys__mgr{0}__ready               ;'.format(pe) 
    pLine = pLine + '\n  input                                         sys__mgr{0}__complete            ;'.format(pe) 
    #                                                                                                              

  f.write(pLine)
  f.close()


  f = open('../HDL/common/system_manager_stack_bus_downstream_oob_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #                                                                                                              
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                  '.format(pe) 
    pLine = pLine + '\n  output  [`COMMON_STD_INTF_CNTL_RANGE     ]      mgr{0}__std__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  output                                          mgr{0}__std__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  input                                           std__mgr{0}__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  output  [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr{0}__std__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  output  [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr{0}__std__oob_data            ;'.format(pe) 
    #                                                             

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_downstream_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  input                                         std__mgr{0}__lane{1}_strm{2}_ready       ;'.format(pe,lane,strm)
        pLine = pLine + '\n  output  [`COMMON_STD_INTF_CNTL_RANGE      ]   mgr{0}__std__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  output  [`STACK_DOWN_INTF_STRM_DATA_RANGE ]   mgr{0}__std__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  output                                        mgr{0}__std__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_sys_general_instance_wires.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                 '.format(pe) 
    pLine = pLine + '\n  wire                                        mgr{0}__sys__allSynchronized     ;'.format(pe) 
    pLine = pLine + '\n  wire                                        sys__mgr{0}__thisSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  wire                                        sys__mgr{0}__ready               ;'.format(pe) 
    pLine = pLine + '\n  wire                                        sys__mgr{0}__complete            ;'.format(pe) 
    pLine = pLine + '\n'
    #                                                                                                            

  f.write(pLine)
  f.close()


  f = open('../HDL/common/system_manager_stack_bus_downstream_oob_instance_wires.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #                                                                                                            
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                '.format(pe) 
    pLine = pLine + '\n  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      mgr{0}__std__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  wire                                        mgr{0}__std__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  wire                                        std__mgr{0}__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      mgr{0}__std__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      mgr{0}__std__oob_data            ;'.format(pe) 
    pLine = pLine + '\n'
    #                                                             
     
  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_downstream_instance_wires.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  wire                                        std__mgr{0}__lane{1}_strm{2}_ready       ;'.format(pe,lane,strm)
        pLine = pLine + '\n  wire [`COMMON_STD_INTF_CNTL_RANGE       ]   mgr{0}__std__lane{1}_strm{2}_cntl        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  wire [`STACK_DOWN_INTF_STRM_DATA_RANGE  ]   mgr{0}__std__lane{1}_strm{2}_data        ;'.format(pe,lane,strm) 
        pLine = pLine + '\n  wire                                        mgr{0}__std__lane{1}_strm{2}_data_valid  ;'.format(pe,lane,strm) 
        pLine = pLine + '\n'
     
  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_downstream_oob_instance_connections.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #                                                                                                                  
    pLine = pLine + '\n  assign  mgr{0}__std__oob_cntl                       =  mgr_inst[{0}].mgr__std__oob_cntl       ;'.format(pe) 
    pLine = pLine + '\n  assign  mgr{0}__std__oob_valid                      =  mgr_inst[{0}].mgr__std__oob_valid      ;'.format(pe) 
    pLine = pLine + '\n  assign  mgr_inst[{0}].std__mgr__oob_ready           =  std__mgr{0}__oob_ready                 ;'.format(pe)
    pLine = pLine + '\n  assign  mgr{0}__std__oob_type                       =  mgr_inst[{0}].mgr__std__oob_type       ;'.format(pe) 
    pLine = pLine + '\n  assign  mgr{0}__std__oob_data                       =  mgr_inst[{0}].mgr__std__oob_data       ;'.format(pe) 
    pLine = pLine + '\n'
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../HDL/common/system_manager_stack_bus_downstream_instance_connections.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
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
    pLine = pLine + '\n  assign   mgr{0}__stu__ready                =   mgr_inst[{0}].mgr__stu__ready    ;'.format(pe) 
    pLine = pLine + '\n  assign   mgr_inst[{0}].stu__mgr__type      =   stu__mgr{0}__type                ;'.format(pe)
    pLine = pLine + '\n  assign   mgr_inst[{0}].stu__mgr__data      =   stu__mgr{0}__data                ;'.format(pe)
    pLine = pLine + '\n  assign   mgr_inst[{0}].stu__mgr__oob_data  =   stu__mgr{0}__oob_data            ;'.format(pe)
    pLine = pLine + '\n'
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

  pLine = pLine + '\n            // OOB controls how the lanes are interpreted,' 
  pLine = pLine + '\n            mgr__std__oob_cntl                           ,' 
  pLine = pLine + '\n            mgr__std__oob_valid                          ,' 
  pLine = pLine + '\n            std__mgr__oob_ready                          ,' 
  pLine = pLine + '\n            mgr__std__oob_type                           ,' 
  pLine = pLine + '\n            mgr__std__oob_data                           ,' 
  #
  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n            // Lane operand bus                  '.format(lane)
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


