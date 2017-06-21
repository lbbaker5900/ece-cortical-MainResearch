#! /usr/bin/env python

if __name__ == "__main__":

  import sys
  import os
  import math
  import random
  import re

  # extract number of pe's
  FoundPe = False
  searchFile = open("../HDL/common/pe_array.vh", "r")
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
  searchFile = open("../HDL/common/pe.vh", "r")
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
  searchFile = open("../HDL/common/noc_cntl.vh", "r")
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



  # Generate stack bus connections

  f = open('../SIMULATION/common/TB_system_stack_bus_downstream_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n            // General control and status                  ,'.format(pe) 
    pLine = pLine + '\n            //sys__pe{0}__peId                               ,'.format(pe) 
    pLine = pLine + '\n            sys__pe{0}__allSynchronized                    ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__sys__thisSynchronized                   ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__sys__ready                              ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__sys__complete                           ,'.format(pe) 
    #
    pLine = pLine + '\n            // OOB controls how the lanes are interpreted  ,'.format(pe) 
    pLine = pLine + '\n            std__pe{0}__oob_cntl                           ,'.format(pe) 
    pLine = pLine + '\n            std__pe{0}__oob_valid                          ,'.format(pe) 
    pLine = pLine + '\n            pe{0}__std__oob_ready                          ,'.format(pe) 
    pLine = pLine + '\n            std__pe{0}__oob_type                           ,'.format(pe) 
    pLine = pLine + '\n            std__pe{0}__oob_data                           ,'.format(pe) 
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n            pe{1}__std__lane{0}_strm{2}_ready       ,'.format(lane,pe,strm)
        pLine = pLine + '\n            std__pe{1}__lane{0}_strm{2}_cntl        ,'.format(lane,pe,strm) 
        pLine = pLine + '\n            std__pe{1}__lane{0}_strm{2}_data        ,'.format(lane,pe,strm) 
        #pLine = pLine + '\n            std__pe{1}__lane{0}_strm{2}_data_mask   ,'.format(lane,pe,strm) 
        pLine = pLine + '\n            std__pe{1}__lane{0}_strm{2}_data_valid  ,'.format(lane,pe,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_stack_bus_downstream_port_declarations.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                  '.format(pe) 
    pLine = pLine + '\n  //input [`PE_PE_ID_RANGE                 ]      sys__pe{0}__peId                ;'.format(pe) 
    pLine = pLine + '\n  input                                         sys__pe{0}__allSynchronized     ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__sys__thisSynchronized    ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__sys__ready               ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__sys__complete            ;'.format(pe) 
    #                                                                                                              
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                  '.format(pe) 
    pLine = pLine + '\n  input [`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe{0}__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  input                                         std__pe{0}__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  output                                        pe{0}__std__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe{0}__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  input [`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe{0}__oob_data            ;'.format(pe) 
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  output                                       pe{1}__std__lane{0}_strm{2}_ready       ;'.format(lane,pe,strm)
        pLine = pLine + '\n  input [`DMA_CONT_STRM_CNTL_RANGE     ]       std__pe{1}__lane{0}_strm{2}_cntl        ;'.format(lane,pe,strm) 
        pLine = pLine + '\n  input [`STREAMING_OP_DATA_WIDTH_RANGE]       std__pe{1}__lane{0}_strm{2}_data        ;'.format(lane,pe,strm) 
        #pLine = pLine + '\n  input [`STREAMING_OP_DATA_WIDTH_RANGE]       std__pe{1}__lane{0}_strm{2}_data_mask   ;'.format(lane,pe,strm) 
        pLine = pLine + '\n  input                                        std__pe{1}__lane{0}_strm{2}_data_valid  ;'.format(lane,pe,strm) 
        pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_stack_bus_downstream_instance_wires.vh', 'w')
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
    pLine = pLine + '\n  wire[`COMMON_STD_INTF_CNTL_RANGE     ]      std__pe{0}__oob_cntl            ;'.format(pe) 
    pLine = pLine + '\n  wire                                        std__pe{0}__oob_valid           ;'.format(pe) 
    pLine = pLine + '\n  wire                                        pe{0}__std__oob_ready           ;'.format(pe) 
    pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_TYPE_RANGE ]      std__pe{0}__oob_type            ;'.format(pe) 
    pLine = pLine + '\n  wire[`STACK_DOWN_OOB_INTF_DATA_RANGE ]      std__pe{0}__oob_data            ;'.format(pe) 
    #                                                             
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  wire                                        pe{1}__std__lane{0}_strm{2}_ready       ;'.format(lane,pe,strm)
        pLine = pLine + '\n  wire [`DMA_CONT_STRM_CNTL_RANGE     ]       std__pe{1}__lane{0}_strm{2}_cntl        ;'.format(lane,pe,strm) 
        pLine = pLine + '\n  wire [`STREAMING_OP_DATA_WIDTH_RANGE]       std__pe{1}__lane{0}_strm{2}_data        ;'.format(lane,pe,strm) 
        #pLine = pLine + '\n  wire [`STREAMING_OP_DATA_WIDTH_RANGE]       std__pe{1}__lane{0}_strm{2}_data_mask   ;'.format(lane,pe,strm) 
        pLine = pLine + '\n  wire                                        std__pe{1}__lane{0}_strm{2}_data_valid  ;'.format(lane,pe,strm) 
        pLine = pLine + '\n'
     
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_general_instance_ports.vh', 'w')
  pLine = ""
  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                                     '.format(pe) 
    pLine = pLine + '\n  //  - doesnt seem to work if you use cb_test for observed signals                                 '.format(pe) 
    pLine = pLine + '\n  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         '.format(pe) 
    pLine = pLine + '\n        .sys__pe{0}__allSynchronized    ( GenStackBus[{0}].sys__pe__allSynchronized           ), '.format(pe) 
    pLine = pLine + '\n        .pe{0}__sys__thisSynchronized   ( GenStackBus[{0}].pe__sys__thisSynchronized          ), '.format(pe) 
    pLine = pLine + '\n        .pe{0}__sys__ready              ( GenStackBus[{0}].pe__sys__ready                     ), '.format(pe) 
    pLine = pLine + '\n        .pe{0}__sys__complete           ( GenStackBus[{0}].pe__sys__complete                  ), '.format(pe) 
    pLine = pLine + '\n'
    #                                                                                                    
                                             
  f.write(pLine)
  f.close()


  f = open('../SIMULATION/common/TB_system_stack_bus_downstream_oob_instance_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    #                                                                                                    
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                                     '.format(pe) 
    pLine = pLine + '\n  //  - doesnt seem to work if you use cb_test for observed signals                                 '.format(pe) 
    pLine = pLine + '\n  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         '.format(pe) 
    pLine = pLine + '\n        .std__pe{0}__oob_cntl           ( DownstreamStackBusOOB[{0}].cb_test.std__pe__oob_cntl          ), '.format(pe) 
    pLine = pLine + '\n        .std__pe{0}__oob_valid          ( DownstreamStackBusOOB[{0}].cb_test.std__pe__oob_valid         ), '.format(pe) 
    pLine = pLine + '\n        .pe{0}__std__oob_ready          ( DownstreamStackBusOOB[{0}].pe__std__oob_ready                 ), '.format(pe) 
    pLine = pLine + '\n        .std__pe{0}__oob_type           ( DownstreamStackBusOOB[{0}].cb_test.std__pe__oob_type          ), '.format(pe) 
    pLine = pLine + '\n        .std__pe{0}__oob_data           ( DownstreamStackBusOOB[{0}].cb_test.std__pe__oob_data          ), '.format(pe) 
    # 
                                             
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_stack_bus_downstream_instance_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n        // PE {1}, Lane {0}                 '.format(lane,pe)
      for strm in range (0, 2):
        pLine = pLine + '\n        //  - doesnt seem to work if you use cb_test for observed signals                                                       '.format(pe) 
        pLine = pLine + '\n        .pe{0}__std__lane{1}_strm{2}_ready         ( DownstreamStackBusLane[{0}][{1}].pe__std__lane_strm{2}_ready              ),      '.format(pe,lane,strm)
        pLine = pLine + '\n        .std__pe{0}__lane{1}_strm{2}_cntl          ( DownstreamStackBusLane[{0}][{1}].cb_test.std__pe__lane_strm{2}_cntl       ),      '.format(pe,lane,strm)
        pLine = pLine + '\n        .std__pe{0}__lane{1}_strm{2}_data          ( DownstreamStackBusLane[{0}][{1}].cb_test.std__pe__lane_strm{2}_data       ),      '.format(pe,lane,strm)
        pLine = pLine + '\n        .std__pe{0}__lane{1}_strm{2}_data_valid    ( DownstreamStackBusLane[{0}][{1}].cb_test.std__pe__lane_strm{2}_data_valid ),      '.format(pe,lane,strm)
        #pLine = pLine + '\n        .std__pe{0}__lane{1}_strm{2}_data_mask     ( DownstreamStackBusLane[{0}][{1}].cb_test.std__pe__lane_strm{2}_data_mask  ),      '.format(pe,lane,strm)
        pLine = pLine + '\n        '
                                             
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_PEonly_system_stack_bus_downstream_instance_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // General control and status                                                                     '.format(pe) 
    pLine = pLine + '\n  //  - doesnt seem to work if you use cb_test for observed signals                                 '.format(pe) 
    pLine = pLine + '\n  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         '.format(pe) 
    pLine = pLine + '\n        .sys__pe{0}__allSynchronized    ( SysOob2PeArray[{0}].cb_test.sys__pe__allSynchronized   ), '.format(pe) 
    pLine = pLine + '\n        .pe{0}__sys__thisSynchronized   ( SysOob2PeArray[{0}].pe__sys__thisSynchronized          ), '.format(pe) 
    pLine = pLine + '\n        .pe{0}__sys__ready              ( SysOob2PeArray[{0}].pe__sys__ready                     ), '.format(pe) 
    pLine = pLine + '\n        .pe{0}__sys__complete           ( SysOob2PeArray[{0}].pe__sys__complete                  ), '.format(pe) 
    #                                                                                                    
    pLine = pLine + '\n  // OOB controls how the lanes are interpreted                                                     '.format(pe) 
    pLine = pLine + '\n  //  - doesnt seem to work if you use cb_test for observed signals                                 '.format(pe) 
    pLine = pLine + '\n  //  - tried all combinations, e.g. cb_test to grab the signal and no cb for checking etc.         '.format(pe) 
    pLine = pLine + '\n        .std__pe{0}__oob_cntl           ( SysOob2PeArray[{0}].cb_test.std__pe__oob_cntl          ), '.format(pe) 
    pLine = pLine + '\n        .std__pe{0}__oob_valid          ( SysOob2PeArray[{0}].cb_test.std__pe__oob_valid         ), '.format(pe) 
    pLine = pLine + '\n        .pe{0}__std__oob_ready          ( SysOob2PeArray[{0}].pe__std__oob_ready                 ), '.format(pe) 
    pLine = pLine + '\n        .std__pe{0}__oob_type           ( SysOob2PeArray[{0}].cb_test.std__pe__oob_type          ), '.format(pe) 
    pLine = pLine + '\n        .std__pe{0}__oob_data           ( SysOob2PeArray[{0}].cb_test.std__pe__oob_data          ), '.format(pe) 
    # 
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n        // PE {1}, Lane {0}                 '.format(lane,pe)
      for strm in range (0, 2):
        pLine = pLine + '\n        //  - doesnt seem to work if you use cb_test for observed signals                                                       '.format(pe) 
        pLine = pLine + '\n        .pe{0}__std__lane{1}_strm{2}_ready         ( SysLane2PeArray[{0}][{1}].pe__std__lane_strm{2}_ready              ),      '.format(pe,lane,strm)
        pLine = pLine + '\n        .std__pe{0}__lane{1}_strm{2}_cntl          ( SysLane2PeArray[{0}][{1}].cb_test.std__pe__lane_strm{2}_cntl       ),      '.format(pe,lane,strm)
        pLine = pLine + '\n        .std__pe{0}__lane{1}_strm{2}_data          ( SysLane2PeArray[{0}][{1}].cb_test.std__pe__lane_strm{2}_data       ),      '.format(pe,lane,strm)
        pLine = pLine + '\n        .std__pe{0}__lane{1}_strm{2}_data_valid    ( SysLane2PeArray[{0}][{1}].cb_test.std__pe__lane_strm{2}_data_valid ),      '.format(pe,lane,strm)
        #pLine = pLine + '\n        .std__pe{0}__lane{1}_strm{2}_data_mask     ( SysLane2PeArray[{0}][{1}].cb_test.std__pe__lane_strm{2}_data_mask  ),      '.format(pe,lane,strm)
        pLine = pLine + '\n        '
                                             
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_system_stack_bus_upstream_instance_ports.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
        pLine = pLine + '\n        //  - doesnt seem to work if you use cb_test for observed signals                                                       '.format(pe) 
        pLine = pLine + '\n        .pe{0}__stu__valid        ( UpstreamStackBus[{0}].pe__stu__valid             ),      '.format(pe)
        pLine = pLine + '\n        .pe{0}__stu__cntl         ( UpstreamStackBus[{0}].pe__stu__cntl              ),      '.format(pe)
        pLine = pLine + '\n        .stu__pe{0}__ready        ( 1\'b1                                            ),      '.format(pe)
        pLine = pLine + '\n        //.stu__pe{0}__ready        ( UpstreamStackBus[{0}].stu__pe__ready     ),      '.format(pe)
        pLine = pLine + '\n        .pe{0}__stu__type         ( UpstreamStackBus[{0}].pe__stu__type              ),      '.format(pe)
        pLine = pLine + '\n        .pe{0}__stu__data         ( UpstreamStackBus[{0}].pe__stu__data              ),      '.format(pe)
        pLine = pLine + '\n        .pe{0}__stu__oob_data     ( UpstreamStackBus[{0}].pe__stu__oob_data          ),      '.format(pe)
        pLine = pLine + '\n        '
                                             
  f.write(pLine)
  f.close()

  #-------------------------------------------------------------------------------------------------------------------------------------
  # Upstream Stack Bus


  # Calculate register selection using cycle number, word/bus widths etc.
  FoundLanes = False
  searchFile = open("../HDL/common/pe.vh", "r")
  for line in searchFile:
    if FoundLanes == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_EXEC_LANES" in data[1]:
        numOfExecLanes = int(data[2])
        FoundLanes = True
  searchFile.close()

  FoundLanes = False
  searchFile = open("../HDL/common/pe.vh", "r")
  for line in searchFile:
    if FoundLanes == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_EXEC_LANE_width" in data[1]:
        execLaneWidth = int(data[2])
        FoundLanes = True
  searchFile.close()

  Found = False
  searchFile = open("../HDL/common/stack_interface.vh", "r")
  for line in searchFile:
    if Found == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "STACK_UP_INTF_DATA_WIDTH" in data[1]:
        stackUpWidth = int(data[2])
        Found = True
  searchFile.close()

  Found = False
  searchFile = open("../HDL/common/pe.vh", "r")
  for line in searchFile:
    if Found == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_EXEC_LANE_WIDTH" in data[1]:
        execLaneWidth = int(data[2])
        Found = True
  searchFile.close()


  f = open('../SIMULATION/common/TB_upstream_stack_bus_lane_extraction.vh', 'w')
  pLine = ""

  # Extrack the lane data from the stack bus based on cycle/transaction number
  regsPerCycle   = stackUpWidth / execLaneWidth
  numberOfCycles = numOfExecLanes / regsPerCycle
  #print regsPerCycle, stackUpWidth, execLaneWidth

  for cycle in range (0, numberOfCycles):
    # Assume little endian
    lsReg = regsPerCycle*cycle
    msReg = regsPerCycle*(cycle+1)-1
    pLine = pLine + '\n    {0} :  // note: in system verilog checker, we increment cycle count 1..8 not 0..7'.format(cycle+1)
    pLine = pLine + '\n      begin'
    for reg in range (0, regsPerCycle):
      regId    = lsReg+reg
      regLsb = (regId%regsPerCycle)*execLaneWidth
      regMsb = regLsb+execLaneWidth-1
      pLine = pLine + '\n        upstream_packet_data [{0}] = upstream_data[{1}:{2}] ; '.format(regId, regMsb, regLsb)
    pLine = pLine + '\n      end '.format(cycle)


  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_PEonly_connect_Dma2Mem.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n                  //----------------------------------------------------------------------------------------------------'
    pLine = pLine + '\n                  // PE {0}'.format(pe)
    pLine = pLine + '\n                  // '
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n                  //--------------------------------------------------'
      pLine = pLine + '\n                  // Lane {1}'.format(pe, lane)
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].dma__memc__write_valid      = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.dma__memc__write_valid{1}        ;'.format(pe, lane)
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].dma__memc__write_address    = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.dma__memc__write_address{1}      ;'.format(pe, lane)
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].dma__memc__write_data       = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.dma__memc__write_data{1}         ;'.format(pe, lane)
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].dma__memc__read_valid       = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.dma__memc__read_valid{1}         ;'.format(pe, lane)
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].dma__memc__read_address     = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.dma__memc__read_address{1}       ;'.format(pe, lane)
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].dma__memc__read_pause       = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.dma__memc__read_pause{1}         ;'.format(pe, lane)
      pLine = pLine + '\n'
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].memc__dma__write_ready      = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.memc__dma__write_ready{1}        ;'.format(pe, lane)
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].memc__dma__read_data        = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.memc__dma__read_data{1}          ;'.format(pe, lane)
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].memc__dma__read_data_valid  = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.memc__dma__read_data_valid{1}    ;'.format(pe, lane)
      pLine = pLine + '\n                  assign Dma2Mem[{0}][{1}].memc__dma__read_ready       = pe_array_inst.pe_inst[{0}].pe.mem_acc_cont.memc__dma__read_ready{1}         ;'.format(pe, lane)
      pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  #-------------------------------------------------------------------------------------------------------------------------------------
  #------------------------------------------------------------------------------------------------------------------------------------------------------

  # Start all the generators and drivers

  f = open('../SIMULATION/common/TB_reset_generators_and_drivers.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n//            begin'                                  
    pLine = pLine + '\n//              ldst_driver[{0}].reset()  ;'.format(pe) 
    pLine = pLine + '\n//            end'
    pLine = pLine + '\n//            begin'                                  
    pLine = pLine + '\n//              mgr[{0}].reset()  ;'.format(pe) 
    pLine = pLine + '\n//            end'
    pLine = pLine + '\n//            begin'                                  
    pLine = pLine + '\n//              oob_drv[{0}].reset()  ;'.format(pe) 
    pLine = pLine + '\n//            end'
    pLine = pLine + '\n//            begin'                                  
    pLine = pLine + '\n//              up_check[{0}].reset()  ;'.format(pe,lane) 
    pLine = pLine + '\n//            end'
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n//            begin'
      pLine = pLine + '\n//              gen[{0}][{1}].reset()  ;'.format(pe,lane) 
      pLine = pLine + '\n//            end'                                    
      pLine = pLine + '\n//            begin'                                  
      pLine = pLine + '\n//              drv[{0}][{1}].reset()  ;'.format(pe,lane) 
      pLine = pLine + '\n//            end'
      pLine = pLine + '\n//            begin'                                  
      pLine = pLine + '\n//              mem_check[{0}][{1}].reset()  ;'.format(pe,lane) 
      pLine = pLine + '\n//            end'
      pLine = pLine + '\n            begin'                                  
      pLine = pLine + '\n              rf_driver[{0}][{1}].reset()  ;'.format(pe,lane) 
      pLine = pLine + '\n            end'
      pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_start_generators_and_drivers.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n            begin'                                  
    pLine = pLine + '\n              ldst_driver[{0}].run()  ;'.format(pe) 
    pLine = pLine + '\n            end'
    pLine = pLine + '\n            begin'                                  
    pLine = pLine + '\n              mgr[{0}].run()  ;'.format(pe) 
    pLine = pLine + '\n            end'
    pLine = pLine + '\n            begin'                                  
    pLine = pLine + '\n              oob_drv[{0}].run()  ;'.format(pe) 
    pLine = pLine + '\n            end'
    pLine = pLine + '\n            begin'                                  
    pLine = pLine + '\n              up_check[{0}].run()  ;'.format(pe,lane) 
    pLine = pLine + '\n            end'
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n            begin'
      pLine = pLine + '\n              gen[{0}][{1}].run()  ;'.format(pe,lane) 
      pLine = pLine + '\n            end'                                    
      pLine = pLine + '\n            begin'                                  
      pLine = pLine + '\n              drv[{0}][{1}].run()  ;'.format(pe,lane) 
      pLine = pLine + '\n            end'
      pLine = pLine + '\n            begin'                                  
      pLine = pLine + '\n              mem_check[{0}][{1}].run()  ;'.format(pe,lane) 
      pLine = pLine + '\n            end'
      pLine = pLine + '\n            begin'                                  
      pLine = pLine + '\n              rf_driver[{0}][{1}].run()  ;'.format(pe,lane) 
      pLine = pLine + '\n            end'
      pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_PEonly_start_generators_and_drivers.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n            begin'                                  
    pLine = pLine + '\n              ldst_driver[{0}].run()  ;'.format(pe) 
    pLine = pLine + '\n            end'
    pLine = pLine + '\n            begin'                                  
    pLine = pLine + '\n              mgr[{0}].run()  ;'.format(pe) 
    pLine = pLine + '\n            end'
    pLine = pLine + '\n            begin'                                  
    pLine = pLine + '\n              oob_drv[{0}].run()  ;'.format(pe) 
    pLine = pLine + '\n            end'
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n            begin'
      pLine = pLine + '\n              gen[{0}][{1}].run()  ;'.format(pe,lane) 
      pLine = pLine + '\n            end'                                    
      pLine = pLine + '\n            begin'                                  
      pLine = pLine + '\n              drv[{0}][{1}].run()  ;'.format(pe,lane) 
      pLine = pLine + '\n            end'
      pLine = pLine + '\n            begin'                                  
      pLine = pLine + '\n              mem_check[{0}][{1}].run()  ;'.format(pe,lane) 
      pLine = pLine + '\n            end'
      pLine = pLine + '\n            begin'                                  
      pLine = pLine + '\n              rf_driver[{0}][{1}].run()  ;'.format(pe,lane) 
      pLine = pLine + '\n            end'
      pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_wait_for_final_operation.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n            begin'
    pLine = pLine + '\n              wait(final_operation[{0}].triggered) ; // we start waiting before the event will occur'.format(pe) 
    pLine = pLine + '\n              //@(final_operation[{0}]) ;'.format(pe) 
    pLine = pLine + '\n              //$display("@%0t LEE: Received final operation event for manager {0}\\n", $time);'.format(pe) 
    pLine = pLine + '\n            end'                                         
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_quiesce_all_generators.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n            begin'
      pLine = pLine + '\n                @vDownstreamStackBusLane[{0}][{1}].cb_test                                      ;'.format(pe,lane) 
      for strm in range (0, 2):
        pLine = pLine + '\n                vDownstreamStackBusLane [{0}][{1}].cb_test.std__pe__lane_strm{2}_data_valid  <= 0  ;'.format(pe,lane,strm) 
      pLine = pLine + '\n            end'                                         
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_PEonly_quiesce_all_generators.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      pLine = pLine + '\n            begin'
      pLine = pLine + '\n                @vSysLane2PeArray[{0}][{1}].cb_test                                      ;'.format(pe,lane) 
      for strm in range (0, 2):
        pLine = pLine + '\n                vSysLane2PeArray [{0}][{1}].cb_test.std__pe__lane_strm{2}_data_valid  <= 0  ;'.format(pe,lane,strm) 
      pLine = pLine + '\n            end'                                         
    pLine = pLine + '\n'

  f.write(pLine)
  f.close()


  f = open('../SIMULATION/common/TB_manager_send_operation_to_generators.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n            fork                                                                                                                                  '.format(lane) 
    pLine = pLine + '\n                // Making sure we create new operand arrays using a deep copy method doesnt seem to be neccessary, but do it anyway (flaky SV)    '.format(lane) 
    pLine = pLine + '\n                //sys_operation_lane[{0}] = new sys_operation_mgr ;                                                                               '.format(lane) 
    pLine = pLine + '\n                // base_operation deep copy also reseeds RNG                                                                                      '.format(lane) 
    pLine = pLine + '\n                sys_operation_lane[{0}] = sys_operation_mgr.copy() ; // deep copy creates new operand arrays                                      '.format(lane) 
    pLine = pLine + '\n                // The copy copies RNG so need to reseed otherwise we will create the same contents for each lane                                 '.format(lane) 
    pLine = pLine + '\n                // sys_operation_lane[{0}].srandom($urandom)       ; // done by deep copy routine                                                 '.format(lane) 
    pLine = pLine + '\n                sys_operation_lane[{0}].Id[1]  =  {0}      ;  // set lane for address generation                                                  '.format(lane) 
    pLine = pLine + '\n                                                                                                                                                  '.format(lane) 
    pLine = pLine + '\n                // Send to driver                                                                                                                 '.format(lane) 
    pLine = pLine + '\n                mgr2gen[{0}].put(sys_operation_lane[{0}])                    ;                                                                    '.format(lane) 
    pLine = pLine + '\n                                                                                                                                                  '.format(lane) 
    pLine = pLine + '\n                // DEBUG                                                                                                                          '.format(lane) 
    pLine = pLine + '\n                /*                                                                                                                                '.format(lane) 
    pLine = pLine + '\n                if (this.Id == 63)                                                                                                                '.format(lane) 
    pLine = pLine + '\n                  begin                                                                                                                           '.format(lane) 
    pLine = pLine + '\n                    sys_operation_lane[{0}].displayOperation();                                                                                   '.format(lane) 
    pLine = pLine + '\n                  end                                                                                                                             '.format(lane) 
    pLine = pLine + '\n                */                                                                                                                                '.format(lane) 
    pLine = pLine + '\n                // now wait for generator                                                                                                         '.format(lane) 
    pLine = pLine + '\n                @mgr2gen_ack[{0}];                                                                                                                '.format(lane) 
    pLine = pLine + '\n            join_none                                                                                                                             '.format(lane) 
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/TB_manager_PEonly_send_operation_to_generators.vh', 'w')
  pLine = ""

  for lane in range (0, numOfExecLanes):
    pLine = pLine + '\n            fork                                                                                                                                  '.format(lane) 
    pLine = pLine + '\n                sys_operation_lane[{0}] = new sys_operation_mgr ;                                                                                 '.format(lane) 
    pLine = pLine + '\n                sys_operation_lane[{0}].Id[1]  =  {0}      ;  // set lane for address generation                                                  '.format(lane) 
    pLine = pLine + '\n                                                                                                                                                  '.format(lane) 
    pLine = pLine + '\n                // Send to driver                                                                                                                 '.format(lane) 
    pLine = pLine + '\n                //$display("@%0t:%s:%0d:LEE: sys_operation_mgr : {{%0d,{0}}}:%h\\n", $time, `__FILE__, `__LINE__, Id, sys_operation_mgr);            '.format(lane) 
    pLine = pLine + '\n                mgr2gen[{0}].put(sys_operation_lane[{0}])                    ;                                                                    '.format(lane) 
    pLine = pLine + '\n                                                                                                                                                  '.format(lane) 
    pLine = pLine + '\n                // now wait for generator                                                                                                         '.format(lane) 
    pLine = pLine + '\n                //sys_operation.displayOperation();                                                                                               '.format(lane) 
    pLine = pLine + '\n                @mgr2gen_ack[{0}];                                                                                                              '.format(lane) 
    pLine = pLine + '\n            join_none                                                                                                                             '.format(lane) 
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()

  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ##----------------------------------------------------------------------------------------------------
  ## Verilog Testbench files


  f = open('../SIMULATION/common/test_mem_to_mem_init_step1.vh', 'w')
  pLine = ""

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Stream start addresses'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Stream 0 start address'
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r134 [{1}] = 32\'h'.format(pe,lane) + hex(lane).split('x')[1] + '010;'

      pLine = pLine + '\n            // Stream 1 start address'
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r135 [{1}] = 32\'h'.format(pe,lane) + hex(lane).split('x')[1] + '800;'

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Type and length of stream'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Set data type and size of stream0 (in types)'.format(pe)
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r132[{1}][19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r132[{1}][15:0]  = numOfTypes;'.format(pe,lane)

      pLine = pLine + '\n            // Set data type and size of stream1 (in types)'.format(pe)
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r133[{1}][19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r133[{1}][15:0]  = numOfTypes;'.format(pe,lane)


  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // Enable and set transfer type'
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(10) @(negedge clk); '
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Enable'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__rs0[0]           = 1\'b1;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Operation'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__rs0[31:1] = `STREAMING_OP_CNTL_OPERATION_NOP_FROM_TWO_EXT_TO_MEM ;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(50) @(negedge clk);'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_mem_to_mem_generate_stimulus_step1.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // PE {0}  '.format(pe)
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):

        pLine = pLine + '\n      fp_mac_expected_result = 0 ;                '.format(lane,strm,pe)
        pLine = pLine + '\n      for (int i0=0; i0<numOfExtWords; i0++)                                                                   '.format(lane,strm,pe)  
        pLine = pLine + '\n        begin                                                                                                  '.format(lane,strm,pe)
        pLine = pLine + '\n          pe{2}_lane{0}_strm{1}[i0]  = (i0 == 0                )  ? $shortrealtobits(11.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                 (i0 == (numOfExtWords-1))  ? $shortrealtobits(44.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                                              $shortrealtobits(2.0*i0) ;                 '.format(lane,strm,pe)
        pLine = pLine + '\n          pe{2}_lane{0}_strm{1}[i0]  = (i0 == 0                )  ? $shortrealtobits(22.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                 (i0 == (numOfExtWords-1))  ? $shortrealtobits(33.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                                              $shortrealtobits(1.0*i0) ;                 '.format(lane,strm,pe)
        pLine = pLine + '\n          fp_mac_expected_result += $bitstoshortreal(pe{2}_lane{0}_strm0[i0]) * $bitstoshortreal(pe{2}_lane{0}_strm1[i0]) ;                '.format(lane,strm,pe)
        pLine = pLine + '\n        end                                                                                                    '.format(lane,strm,pe)

  f.write(pLine)
  f.close()

#! /usr/bin/env python

if __name__ == "__main__":

  import sys
  import os
  import math
  import random
  import re

  # extract number of pe's
  FoundPe = False
  searchFile = open("../HDL/common/pe_array.vh", "r")
  for line in searchFile:
    if FoundPe == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_PE" in data[1]:
        numOfPe = int(data[2])
        FoundPe = True
  searchFile.close()

  # Number of execution lanes in a PE
  FoundLane = False
  searchFile = open("../HDL/common/pe.vh", "r")
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
  searchFile = open("../HDL/common/noc_cntl.vh", "r")
  for line in searchFile:
    if FoundPorts == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "NOC_CONT_NOC_NUM_OF_PORTS" in data[1]:
        numOfPorts = int(data[2])
        FoundPorts = True
  searchFile.close()



  ##-------------------------------------------------------------------------------------------------------------------
  ##-------------------------------------------------------------------------------------------------------------------
  ##-------------------------------------------------------------------------------------------------------------------
  ##-------------------------------------------------------------------------------------------------------------------
  # std std fpmac to mem
  # Two streams on the downstream bus with a multiply-accumulate and the result put in memory

  # Initialize SIMD registers that control stOp system

  f = open('../SIMULATION/common/test_std_std_fpmac_to_mem_init_step1.vh', 'w')
  pLine = ""

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Stream Destination addresses'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Stream 0 Destination address'
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r134 [{1}] = 32\'b'.format(pe,lane) + '{0:0>6}'.format(bin(pe).split('b')[1]) + "_" + '{0:0>5}'.format(bin(lane).split('b')[1]) + '__0_0000_1000_0000;'

      pLine = pLine + '\n            // Stream 1 Destination address'
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r135 [{1}] = 32\'b'.format(pe,lane) + '{0:0>6}'.format(bin(pe).split('b')[1]) + "_" + '{0:0>5}'.format(bin(lane).split('b')[1]) + '__0_1000_0000_0000;'

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Type and length of stream'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Set data type and size of stream0 (in types)'.format(pe)
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r132 [{1}][19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r132 [{1}][15:0]  = numOfTypes;'.format(pe,lane)

      pLine = pLine + '\n            // Set data type and size of stream1 (in types)'.format(pe)
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r133 [{1}][19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r133 [{1}][15:0]  = numOfTypes;'.format(pe,lane)


  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // Enable Stack bus streams'
  pLine = pLine + '\n'


  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // Enable and set transfer type'
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(10) @(negedge clk); '
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Enable'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__rs0[0]           = 1\'b1;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Operation'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__rs0[31:1] = `STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM ;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(50) @(negedge clk);'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_std_std_fpmac_to_mem_generate_stimulus_step1.vh', 'w')
  pLine = ""

  # Create an array holding the streams. Streams will be sent using the  test_std_stimulus.vh

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // PE {0}  '.format(pe)
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):

        pLine = pLine + '\n      fp_mac_expected_result = 0 ;                '.format(lane,strm,pe)
        pLine = pLine + '\n      for (int i0=0; i0<numOfExtWords; i0++)                                                                   '.format(lane,strm,pe)  
        pLine = pLine + '\n        begin                                                                                                  '.format(lane,strm,pe)
        pLine = pLine + '\n          pe{2}_lane{0}_strm{1}[i0]  = (i0 == 0                )  ? $shortrealtobits(11.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                 (i0 == (numOfExtWords-1))  ? $shortrealtobits(44.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                                              $shortrealtobits(2.0*i0) ;                 '.format(lane,strm,pe)
        pLine = pLine + '\n          pe{2}_lane{0}_strm{1}[i0]  = (i0 == 0                )  ? $shortrealtobits(22.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                 (i0 == (numOfExtWords-1))  ? $shortrealtobits(33.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                                              $shortrealtobits(1.0*i0) ;                 '.format(lane,strm,pe)
        pLine = pLine + '\n          fp_mac_expected_result += $bitstoshortreal(pe{2}_lane{0}_strm0[i0]) * $bitstoshortreal(pe{2}_lane{0}_strm1[i0]) ;                '.format(lane,strm,pe)
        pLine = pLine + '\n        end                                                                                                    '.format(lane,strm,pe)

  f.write(pLine)
  f.close()

  ##-------------------------------------------------------------------------------------------------------------------



  ##-------------------------------------------------------------------------------------------------------------------
  # mem std fpmac to mem 
  # One stream on the downstream bus, one stream from memory with a multiply-accumulate and the result put in memory

  # Initialize SIMD registers that control stOp system

  f = open('../SIMULATION/common/test_mem_std_fpmac_to_mem_init_step2.vh', 'w')
  pLine = ""

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // Memory Stream Source addresses'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Stream 0 Source address'
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r130 [{1}] = 32\'b'.format(pe,lane) + '{0:0>6}'.format(bin(pe).split('b')[1]) + "_" + '{0:0>5}'.format(bin(lane).split('b')[1]) + '__0_0000_1000_0000;'
                                                                                                                                                                      
      pLine = pLine + '\n            // Stream 1 Source address'                                                                                                      
      for lane in range (0, numOfExecLanes):                                                                                                                               
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r131 [{1}] = 32\'b'.format(pe,lane) + '{0:0>6}'.format(bin(pe).split('b')[1]) + "_" + '{0:0>5}'.format(bin(lane).split('b')[1]) + '__0_1000_0000_0000;'

  pLine = pLine + '\n'
  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // Memory Destination addresses'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Stream 0 Destination address'
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r134 [{1}] = 32\'b'.format(pe,lane) + '{0:0>6}'.format(bin(pe).split('b')[1]) + "_" + '{0:0>5}'.format(bin(lane).split('b')[1]) + '__0_0000_1000_0000;'
                                                                                                                                                                      
      pLine = pLine + '\n            // Stream 1 Destination address'                                                                                                 
      for lane in range (0, numOfExecLanes):                                                                                                                               
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r135 [{1}] = 32\'b'.format(pe,lane) + '{0:0>6}'.format(bin(pe).split('b')[1]) + "_" + '{0:0>5}'.format(bin(lane).split('b')[1]) + '__0_1000_0000_0000;'

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Type and length of stream'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Set data type and size of stream0 (in types)'.format(pe)
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r132 [{1}][19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r132 [{1}][15:0]  = numOfTypes;'.format(pe,lane)

      pLine = pLine + '\n            // Set data type and size of stream1 (in types)'.format(pe)
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r133 [{1}][19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r133 [{1}][15:0]  = numOfTypes;'.format(pe,lane)


  pLine = pLine + '\n'

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // Enable and set transfer type'
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(10) @(negedge clk); '
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Enable'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.rs0[0]           = 1\'b1;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Operation'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.rs0[31:1] = `STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM ;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(50) @(negedge clk);'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_mem_std_fpmac_to_mem_generate_stimulus_step2.vh', 'w')
  pLine = ""

  # Create an array holding the streams. Streams will be sent using the  test_std_stimulus.vh

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // PE {0}  '.format(pe)
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):

        pLine = pLine + '\n      fp_mac_expected_result = 0 ;                '.format(lane,strm,pe)
        pLine = pLine + '\n      for (int i0=0; i0<numOfExtWords; i0++)                                                                   '.format(lane,strm,pe)  
        pLine = pLine + '\n        begin                                                                                                  '.format(lane,strm,pe)
        pLine = pLine + '\n          pe{2}_lane{0}_strm{1}[i0]  = (i0 == 0                )  ? $shortrealtobits(11.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                 (i0 == (numOfExtWords-1))  ? $shortrealtobits(44.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                                              $shortrealtobits(2.0*i0) ;                 '.format(lane,strm,pe)
        pLine = pLine + '\n          pe{2}_lane{0}_strm{1}[i0]  = (i0 == 0                )  ? $shortrealtobits(22.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                 (i0 == (numOfExtWords-1))  ? $shortrealtobits(33.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                                              $shortrealtobits(1.0*i0) ;                 '.format(lane,strm,pe)
        pLine = pLine + '\n          fp_mac_expected_result += $bitstoshortreal(pe{2}_lane{0}_strm0[i0]) * $bitstoshortreal(pe{2}_lane{0}_strm1[i0]) ;                '.format(lane,strm,pe)
        pLine = pLine + '\n        end                                                                                                    '.format(lane,strm,pe)

  f.write(pLine)
  f.close()

  ##-------------------------------------------------------------------------------------------------------------------



  ##-------------------------------------------------------------------------------------------------------------------
  # std none nop to mem
  # One streams on the downstream bus directly to memory

  # Initialize SIMD registers that control stOp system

  f = open('../SIMULATION/common/test_std_none_nop_to_mem_init_step1.vh', 'w')
  pLine = ""

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Stream Destination addresses'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Stream 0 Destination address'
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r134 [{1}] = 32\'b'.format(pe,lane) + '{0:0>6}'.format(bin(pe).split('b')[1]) + "_" + '{0:0>5}'.format(bin(lane).split('b')[1]) + '__0_0000_1000_0000;'

      pLine = pLine + '\n            // Stream 1 Destination address'
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r135 [{1}] = 32\'b'.format(pe,lane) + '{0:0>6}'.format(bin(pe).split('b')[1]) + "_" + '{0:0>5}'.format(bin(lane).split('b')[1]) + '__0_1000_0000_0000;'

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Type and length of stream'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Set data type and size of stream0 (in types)'.format(pe)
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r132 [{1}][19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r132 [{1}][15:0]  = numOfTypes;'.format(pe,lane)

      pLine = pLine + '\n            // Set data type and size of stream1 (in types)'.format(pe)
      for lane in range (0, numOfExecLanes):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r133 [{1}][19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r133 [{1}][15:0]  = numOfTypes;'.format(pe,lane)


  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // Enable Stack bus streams'
  pLine = pLine + '\n'

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // Enable and set transfer type'
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(10) @(negedge clk); '
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Enable'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.rs0[0]           = 1\'b1;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            // Operation'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.rs0[31:1] = `STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM ;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(50) @(negedge clk);'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_std_none_nop_to_mem_generate_stimulus_step1.vh', 'w')
  pLine = ""

  # Create an array holding the streams. Streams will be sent using the  test_std_stimulus.vh

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // PE {0}  '.format(pe)
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):

        pLine = pLine + '\n      fp_mac_expected_result = 0 ;                '.format(lane,strm,pe)
        pLine = pLine + '\n      for (int i0=0; i0<numOfExtWords; i0++)                                                                   '.format(lane,strm,pe)  
        pLine = pLine + '\n        begin                                                                                                  '.format(lane,strm,pe)
        pLine = pLine + '\n          pe{2}_lane{0}_strm{1}[i0]  = (i0 == 0                )  ? $shortrealtobits(11.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                 (i0 == (numOfExtWords-1))  ? $shortrealtobits(44.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                                              $shortrealtobits(2.0*i0) ;                 '.format(lane,strm,pe)
        pLine = pLine + '\n          pe{2}_lane{0}_strm{1}[i0]  = (i0 == 0                )  ? $shortrealtobits(22.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                 (i0 == (numOfExtWords-1))  ? $shortrealtobits(33.0) :                   '.format(lane,strm,pe)
        pLine = pLine + '\n                                                              $shortrealtobits(1.0*i0) ;                 '.format(lane,strm,pe)
        pLine = pLine + '\n          fp_mac_expected_result += $bitstoshortreal(pe{2}_lane{0}_strm0[i0]) * $bitstoshortreal(pe{2}_lane{0}_strm1[i0]) ;                '.format(lane,strm,pe)
        pLine = pLine + '\n        end                                                                                                    '.format(lane,strm,pe)

  f.write(pLine)
  f.close()

  ##-------------------------------------------------------------------------------------------------------------------



#! /usr/bin/env python

if __name__ == "__main__":

  import sys
  import os
  import math
  import random
  import re

  # extract number of PE's in the array
  FoundPe = False
  FoundLane = False
  searchFile = open("../HDL/common/pe_array.vh", "r")
  for line in searchFile:
    if FoundPe == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_PE" in data[1]:
        numOfPe = int(data[2])
        FoundPe = True
  searchFile.close()

  # Number of execution lanes in a PE
  searchFile = open("../HDL/common/pe.vh", "r")
  for line in searchFile:
    if FoundLane == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_EXEC_LANES" in data[1]:
        numOfExecLanes = int(data[2])
        FoundLane = True
  searchFile.close()

  # Now extract number of banks and dma ports from the mem_acc_cont.vh file
  FoundBanks = False
  FoundDmas = False
  searchFile = open("../HDL/common/mem_acc_cont.vh", "r")
  for line in searchFile:
    if FoundBanks == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "MEM_ACC_CONT_NUM_OF_MEMORY_BANKS" in data[1]:
        numOfBanks = int(data[2])
        FoundBanks = True
    if FoundDmas == False:
      data = re.split(r'\s{1,}', line)
      if "MEM_ACC_CONT_NUM_OF_PORTS" in data[1]:
        numOfMemPorts = int(data[2])
        FoundDmas = True
  searchFile.close()

  # Now extract number of execution lanes
  FoundLanes = False
  searchFile = open("../HDL/common/pe.vh", "r")
  for line in searchFile:
    if FoundLanes == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "PE_NUM_OF_EXEC_LANES" in data[1]:
        numOfExecLanes = int(data[2])
        FoundLanes = True
  searchFile.close()

  # Now extract number of noc ports
  FoundPorts = False
  searchFile = open("../HDL/common/noc_cntl.vh", "r")
  for line in searchFile:
    if FoundPorts == False:
      data = re.split(r'\s{1,}', line)
      # check define is in 2nd field
      if "NOC_CONT_NOC_NUM_OF_PORTS" in data[1]:
        numOfPorts = int(data[2])
        FoundPorts = True
  searchFile.close()

  f = open('../SIMULATION/common/test_variables.vh', 'w')
  pLine = ""

  # Create a vector of external stream values unique for each PE
  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  reg [31:0] pe{0}_lane{1}_strm{2} [0:4095];'.format(pe,lane,strm)
        pLine = pLine + '\n  reg [31:0] pe{0}_lane{1}_strm{2}_tmp     ;'.format(pe,lane,strm)

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_stack_downstream_wires.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n  wire                                        pe{1}__std__lane{0}_strm{2}_ready       ;'.format(lane,pe,strm)
        pLine = pLine + '\n  reg  [`DMA_CONT_STRM_CNTL_RANGE     ]       std__pe{1}__lane{0}_strm{2}_cntl        ;'.format(lane,pe,strm) 
        pLine = pLine + '\n  reg  [`STREAMING_OP_DATA_WIDTH_RANGE]       std__pe{1}__lane{0}_strm{2}_data        ;'.format(lane,pe,strm) 
        #pLine = pLine + '\n  reg  [`STREAMING_OP_DATA_WIDTH_RANGE]       std__pe{1}__lane{0}_strm{2}_data_mask   ;'.format(lane,pe,strm) 
        pLine = pLine + '\n  reg                                         std__pe{1}__lane{0}_strm{2}_data_valid  ;'.format(lane,pe,strm) 
        pLine = pLine + '\n'
     
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_std_init.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n    // Lane {0}                 '.format(lane,pe, strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_cntl        = \'d1         ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data        = \'h5555_AAAA ;'.format(lane,pe,strm)
        #pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data_mask   = \'hFFFF_FFFF ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data_valid  = \'d0         ;'.format(lane,pe,strm)

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_std_idle.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n    // Lane {0}                 '.format(lane,pe)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_cntl        = \'d0         ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data        = \'h1234_5678 ;'.format(lane,pe,strm)
        #pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data_mask   = \'hFFFF_FFFF ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data_valid  = \'d0         ;'.format(lane,pe,strm)

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_simd_init.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.simd__scntl__rs0        = 32\'b0000_0000_0000_0000_0000_0000_0000_0000; '.format(pe,lane)
    #pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.simd__scntl__rs1        = 32\'b0000_0000_0000_0000_0000_0000_0000_0000; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.simd__scntl__rs1        = 32\'b1111_1111_1111_1111_1111_1111_1111_1111; '.format(pe,lane)
    #pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.simd__scntl__rs1        = 32\'b0000_0000_0000_0000_0000_0000_0000_1011; '.format(pe,lane)
    for lane in range (0, numOfExecLanes):
      for reg in range (128, 135+1):
         pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.simd__scntl__lane_r{2} [{1}] = 32\'b0000_0000_0000_0000_0000_0000_0000_0000; '.format(pe,lane,reg)
      
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__request        = 1\'b0 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__released       = 1\'b1 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__write_address  = \'d0 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__write_data     = \'d0 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__read_address   = \'h00 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__write_valid    = 1\'b0; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__read_valid     = 1\'b0; '.format(pe,lane)

  f.write(pLine)
  f.close()


  f = open('../SIMULATION/common/test_std_stimulus.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // PE {0}  '.format(pe)
    for lane in range (0, numOfExecLanes):
      for strm in range (0, 2):
        pLine = pLine + '\n      // Lane {0}, Stream {1}             '.format(lane,strm)
        pLine = pLine + '\n      begin                                                                                                   '.format(lane,strm,pe)
        pLine = pLine + '\n        if (enable_std_stream{1})                                                                               '.format(lane,strm,pe)
        pLine = pLine + '\n          begin                                                                                                   '.format(lane,strm,pe)
        pLine = pLine + '\n            for (int str{1}=0; str{1}<numOfExtWords; str{1}++)                                                    '.format(lane,strm,pe)
        pLine = pLine + '\n              begin                                                                                               '.format(lane,strm,pe)
        pLine = pLine + '\n                std__pe{2}__lane{0}_strm{1}_cntl    = ((str{1} == 0) && (str{1} == (numOfExtWords-1))) ? \'b11 :    '.format(lane,strm,pe)
        pLine = pLine + '\n                                                                 (str{1} == 0)                                    ? \'b01 :    '.format(lane,strm,pe)
        pLine = pLine + '\n                                                                 (str{1} == (numOfExtWords-1))                    ? \'b10 :    '.format(lane,strm,pe)
        pLine = pLine + '\n                                                                                                                    \'b00 ;    '.format(lane,strm,pe)
        pLine = pLine + '\n                std__pe{2}__lane{0}_strm{1}_data        = pe{2}_lane{0}_strm{1}[str{1}];                                          '.format(lane,strm,pe)
        #pLine = pLine + '\n                std__pe{2}__lane{0}_strm{1}_data_mask   = \'hFFFF_FFFF ;                                            '.format(lane,strm,pe)
        pLine = pLine + '\n                std__pe{2}__lane{0}_strm{1}_data_valid  = \'d1 ;                                                    '.format(lane,strm,pe)
        pLine = pLine + '\n                while (~pe{2}__std__lane{0}_strm{1}_ready)                                                          '.format(lane,strm,pe)
        pLine = pLine + '\n                  begin                                                                                           '.format(lane,strm,pe)
        pLine = pLine + '\n                    std__pe{2}__lane{0}_strm{1}_data_valid  = \'d0 ;                                                '.format(lane,strm,pe)
        pLine = pLine + '\n                    @(posedge clk);                                                                             '.format(lane,strm,pe)
        pLine = pLine + '\n                    @(negedge clk);                                                                             '.format(lane,strm,pe)
        pLine = pLine + '\n                  end                                                                                             '.format(lane,strm,pe)
        pLine = pLine + '\n                std__pe{2}__lane{0}_strm{1}_data_valid  = \'d1 ;                                                    '.format(lane,strm,pe)
        pLine = pLine + '\n                @(negedge clk);                                                                                 '.format(lane,strm,pe)
        pLine = pLine + '\n                std__pe{2}__lane{0}_strm{1}_data_valid  = \'d0 ;                                                    '.format(lane,strm,pe)
        pLine = pLine + '\n              end                                                                                                 '.format(lane,strm,pe)
        pLine = pLine + '\n          end                                                                                                 '.format(lane,strm,pe)
        pLine = pLine + '\n      end                                                                                                     '.format(lane,strm,pe)

  f.write(pLine)
  f.close()


  f = open("../SIMULATION/run_s/primarySignal.do", "w")
  pLine = ""
  for lane in range (0, numOfExecLanes):
    for strm in range (0, 2):
      #pLine = pLine + '\n'        
      #pLine = pLine + '\n add wave -noupdate -expand -group XXXX -position insertpoint -radix hexadecimal  {'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane{0}_strm{1}_write_enable}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/streamingOps_cntl/sdp__scntl__lane{0}_strm{1}_write_ready}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/streamingOps_cntl/sdp__scntl__lane{0}_strm{1}_write_complete}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane{0}_strm{1}_read_enable}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/streamingOps_cntl/sdp__scntl__lane{0}_strm{1}_read_ready}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/streamingOps_cntl/sdp__scntl__lane{0}_strm{1}_read_complete}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane{0}_strm{1}_stOp_enable}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/streamingOps_cntl/sdp__scntl__lane{0}_strm{1}_stOp_ready}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/streamingOps_cntl/sdp__scntl__lane{0}_strm{1}_stOp_complete}}'.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/std__pe__lane{0}_strm{1}_cntl      }}'.format(lane,strm) 
      pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix float32      {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/std__pe__lane{0}_strm{1}_data      }}'.format(lane,strm) 
      #pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/std__pe__lane{0}_strm{1}_data_mask }}'.format(lane,strm) 
      pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/std__pe__lane{0}_strm{1}_data_valid}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst/pe_inst[0]/pe/pe__std__lane{0}_strm{1}_ready}}'.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadRequestToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__read_address{1}}}   '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadRequestToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__read_valid{1}}}     '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadRequestToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/memc__dma__read_ready{1}}}     '.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group DmaWriteToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__write_address{1}}}  '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaWriteToMemcLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__write_data{1}}}     '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaWriteToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__write_valid{1}}}    '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaWriteToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/memc__dma__write_ready{1}}}    '.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadResponseFromMemcLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/memc__dma__read_data{1}}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadResponseFromMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid{1}}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadResponseFromMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__read_pause{1}}}     '.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_cntl}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_data}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_data_mask}} '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_data_valid}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_ready}}     '.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_cntl}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_data}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_data_mask}} '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_data_valid}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_ready}}     '.format(lane,strm)
      pLine = pLine + '\n'        
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}}      '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}}      '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask}} '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}}'.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}}        '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}}     '.format(lane,strm)
    pLine = pLine + '\n'        
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}}      '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}}      '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask}} '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}}'.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}}        '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}}     '.format(lane,strm)
    pLine = pLine + '\n'        
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__cp_cntl}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__cp_laneId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__cp_strmId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__cp_type}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__cp_data}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__cp_valid}} '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__cp_ready}} '.format(lane,strm)
  pLine = pLine + '\n'        
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__cp_cntl}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__cp_laneId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__cp_peId}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__cp_strmId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__cp_type}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__cp_data}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__cp_valid}} '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__cp_ready}} '.format(lane,strm)
  pLine = pLine + '\n'        
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__dp_cntl}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__dp_laneId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__dp_peId}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__dp_strmId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__dp_type}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix float32      {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__dp_data}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__dp_valid}} '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__dp_ready}} '.format(lane,strm)
                                                                                                                                                                   
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__dp_cntl}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__dp_laneId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__dp_strmId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__dp_type}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix float32      {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__dp_data}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/noc__scntl__dp_valid}} '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst/pe_inst[0]/pe/noc_cntl/scntl__noc__dp_ready}} '.format(lane,strm)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()



