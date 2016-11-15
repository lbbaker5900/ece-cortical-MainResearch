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
        numOfLane = int(data[2])
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



  f = open('../SIMULATION/common/test_mem_to_mem_init_step1.vh', 'w')
  pLine = ""

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Stream start addresses'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Stream 0 start address'
      for lane in range (0, numOfLane):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r134 = 32\'h'.format(pe,lane) + hex(lane).split('x')[1] + '010;'

      pLine = pLine + '\n            // Stream 1 start address'
      for lane in range (0, numOfLane):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r135 = 32\'h'.format(pe,lane) + hex(lane).split('x')[1] + '800;'

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Type and length of stream'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Set data type and size of stream0 (in types)'.format(pe)
      for lane in range (0, numOfLane):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r132[19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r132[15:0]  = numOfTypes;'.format(pe,lane)

      pLine = pLine + '\n            // Set data type and size of stream1 (in types)'.format(pe)
      for lane in range (0, numOfLane):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r133[19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r133[15:0]  = numOfTypes;'.format(pe,lane)


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
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.rs0[15:1] = `STREAMING_OP_CNTL_OPERATION_NOP_FROM_TWO_EXT_TO_MEM ;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(50) @(negedge clk);'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_mem_to_mem_generate_stimulus_step1.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // PE {0}  '.format(pe)
    for lane in range (0, numOfLane):
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
        numOfLane = int(data[2])
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



  f = open('../SIMULATION/common/test_std_fpmac_to_mem_init_step1.vh', 'w')
  pLine = ""

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Stream start addresses'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Stream 0 start address'
      for lane in range (0, numOfLane):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r134 = 32\'h'.format(pe,lane) + hex(lane).split('x')[1] + '010;'

      pLine = pLine + '\n            // Stream 1 start address'
      for lane in range (0, numOfLane):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r135 = 32\'h'.format(pe,lane) + hex(lane).split('x')[1] + '800;'

  pLine = pLine + '\n'
  pLine = pLine + '\n            // ##################################################'
  pLine = pLine + '\n            // DMA Type and length of stream'
  pLine = pLine + '\n'
  for pe in range (0, numOfPe):
      pLine = pLine + '\n            // Set data type and size of stream0 (in types)'.format(pe)
      for lane in range (0, numOfLane):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r132[19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r132[15:0]  = numOfTypes;'.format(pe,lane)

      pLine = pLine + '\n            // Set data type and size of stream1 (in types)'.format(pe)
      for lane in range (0, numOfLane):
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r133[19:16] = 4\'d4;'.format(pe,lane)
          pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.lane{1}_r133[15:0]  = numOfTypes;'.format(pe,lane)


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
      pLine = pLine + '\n            force pe_array_inst.pe_inst[{0}].pe.rs0[15:1] = `STREAMING_OP_CNTL_OPERATION_FP_MAC_FROM_EXT_TO_MEM ;'.format(pe)
  pLine = pLine + '\n'
  pLine = pLine + '\n            repeat(50) @(negedge clk);'

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_std_fpmac_to_mem_generate_stimulus_step1.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // PE {0}  '.format(pe)
    for lane in range (0, numOfLane):
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
        numOfLane = int(data[2])
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
    for lane in range (0, numOfLane):
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
        pLine = pLine + '\n  reg  [`STREAMING_OP_DATA_WIDTH_RANGE]       std__pe{1}__lane{0}_strm{2}_data_mask   ;'.format(lane,pe,strm) 
        pLine = pLine + '\n  reg                                         std__pe{1}__lane{0}_strm{2}_data_valid  ;'.format(lane,pe,strm) 
        pLine = pLine + '\n'
     
  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_std_init.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfLane):
      for strm in range (0, 2):
        pLine = pLine + '\n    // Lane {0}                 '.format(lane,pe, strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_cntl        = \'d1         ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data        = \'h5555_AAAA ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data_mask   = \'hFFFF_FFFF ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data_valid  = \'d0         ;'.format(lane,pe,strm)

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_std_idle.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    for lane in range (0, numOfLane):
      for strm in range (0, 2):
        pLine = pLine + '\n    // Lane {0}                 '.format(lane,pe)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_cntl        = \'d0         ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data        = \'h1234_5678 ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data_mask   = \'hFFFF_FFFF ;'.format(lane,pe,strm)
        pLine = pLine + '\n    std__pe{1}__lane{0}_strm{2}_data_valid  = \'d0         ;'.format(lane,pe,strm)

  f.write(pLine)
  f.close()

  f = open('../SIMULATION/common/test_simd_init.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.rs0        = 32\'b0000_0000_0000_0000_0000_0000_0000_0000; '.format(pe,lane)
    #pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.rs1        = 32\'b0000_0000_0000_0000_0000_0000_0000_0000; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.rs1        = 32\'b0000_0000_0000_0000_1111_1111_1111_1111; '.format(pe,lane)
    #pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.rs1        = 32\'b0000_0000_0000_0000_0000_0000_0000_1011; '.format(pe,lane)
    for lane in range (0, numOfLane):
      for reg in range (128, 135+1):
         pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.lane{1}_r{2} = 32\'b0000_0000_0000_0000_0000_0000_0000_0000; '.format(pe,lane,reg)
      
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__request   = 1\'b0 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__released  = 1\'b1 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__write_address  = \'d0 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__write_data     = \'d0 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__read_address   = \'h00 ; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__write_valid = 1\'b0; '.format(pe,lane)
    pLine = pLine + '\n    force pe_array_inst.pe_inst[{0}].pe.ldst__memc__read_valid  = 1\'b0; '.format(pe,lane)

  f.write(pLine)
  f.close()


  f = open('../SIMULATION/common/test_std_stimulus.vh', 'w')
  pLine = ""

  for pe in range (0, numOfPe):
    pLine = pLine + '\n  // PE {0}  '.format(pe)
    for lane in range (0, numOfLane):
      for strm in range (0, 2):
        pLine = pLine + '\n      // Lane {0}              '.format(lane)
        pLine = pLine + '\n      begin                                                                                                   '.format(lane,strm,pe)
        pLine = pLine + '\n        for (int str{1}=0; str{1}<numOfExtWords; str{1}++)                                                    '.format(lane,strm,pe)
        pLine = pLine + '\n          begin                                                                                               '.format(lane,strm,pe)
        pLine = pLine + '\n            std__pe{2}__lane{0}_strm{1}_cntl    = ((str{1} == 0) && (str{1} == (numOfExtWords-1))) ? \'b11 :    '.format(lane,strm,pe)
        pLine = pLine + '\n                                                             (str{1} == 0)                                    ? \'b01 :    '.format(lane,strm,pe)
        pLine = pLine + '\n                                                             (str{1} == (numOfExtWords-1))                    ? \'b10 :    '.format(lane,strm,pe)
        pLine = pLine + '\n                                                                                                                \'b00 ;    '.format(lane,strm,pe)
        pLine = pLine + '\n            std__pe{2}__lane{0}_strm{1}_data        = pe{2}_lane{0}_strm{1}[str{1}];                                          '.format(lane,strm,pe)
        pLine = pLine + '\n            std__pe{2}__lane{0}_strm{1}_data_mask   = \'hFFFF_FFFF ;                                            '.format(lane,strm,pe)
        pLine = pLine + '\n            std__pe{2}__lane{0}_strm{1}_data_valid  = \'d1 ;                                                    '.format(lane,strm,pe)
        pLine = pLine + '\n            while (~pe{2}__std__lane{0}_strm{1}_ready)                                                          '.format(lane,strm,pe)
        pLine = pLine + '\n              begin                                                                                           '.format(lane,strm,pe)
        pLine = pLine + '\n                std__pe{2}__lane{0}_strm{1}_data_valid  = \'d0 ;                                                '.format(lane,strm,pe)
        pLine = pLine + '\n                @(posedge clk);                                                                             '.format(lane,strm,pe)
        pLine = pLine + '\n                @(negedge clk);                                                                             '.format(lane,strm,pe)
        pLine = pLine + '\n              end                                                                                             '.format(lane,strm,pe)
        pLine = pLine + '\n            std__pe{2}__lane{0}_strm{1}_data_valid  = \'d1 ;                                                    '.format(lane,strm,pe)
        pLine = pLine + '\n            @(negedge clk);                                                                                 '.format(lane,strm,pe)
        pLine = pLine + '\n            std__pe{2}__lane{0}_strm{1}_data_valid  = \'d0 ;                                                    '.format(lane,strm,pe)
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
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane{0}_strm{1}_write_enable}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane{0}_strm{1}_write_ready}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane{0}_strm{1}_write_complete}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane{0}_strm{1}_read_enable}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane{0}_strm{1}_read_ready}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane{0}_strm{1}_read_complete}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane{0}_strm{1}_stOp_enable}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane{0}_strm{1}_stOp_ready}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StreamControlLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane{0}_strm{1}_stOp_complete}}'.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane{0}_strm{1}_cntl      }}'.format(lane,strm) 
      pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix float32      {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane{0}_strm{1}_data      }}'.format(lane,strm) 
      pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane{0}_strm{1}_data_mask }}'.format(lane,strm) 
      pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane{0}_strm{1}_data_valid}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group ExtToStOpLane{0} -position insertpoint -radix hexadecimal  {{sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane{0}_strm{1}_ready}}'.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadRequestToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__read_address{1}}}   '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadRequestToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__read_valid{1}}}     '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadRequestToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/memc__dma__read_ready{1}}}     '.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group DmaWriteToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__write_address{1}}}  '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaWriteToMemcLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__write_data{1}}}     '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaWriteToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__write_valid{1}}}    '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaWriteToMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/memc__dma__write_ready{1}}}    '.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadResponseFromMemcLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/memc__dma__read_data{1}}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadResponseFromMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid{1}}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaReadResponseFromMemcLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/dma_cont/dma__memc__read_pause{1}}}     '.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_cntl}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_data}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_data_mask}} '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_data_valid}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group DmaToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_ready}}     '.format(lane,strm)
      pLine = pLine + '\n'        
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_cntl}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_data}}      '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_data_mask}} '.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__dma__strm{1}_data_valid}}'.format(lane,strm)
      pLine = pLine + '\n add wave -noupdate -expand -group StOpToDmaLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/dma__stOp__strm{1}_ready}}     '.format(lane,strm)
      pLine = pLine + '\n'        
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}}      '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}}      '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask}} '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}}'.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}}        '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group StOpToNocLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}}     '.format(lane,strm)
    pLine = pLine + '\n'        
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}}      '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix float32      {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}}      '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask}} '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}}'.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}}        '.format(lane,strm)
    pLine = pLine + '\n add wave -noupdate -expand -group NocToStOpLane{0} -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[{0}]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}}     '.format(lane,strm)
    pLine = pLine + '\n'        
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_cntl}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_laneId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_strmId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_type}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_data}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_valid}} '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_ready}} '.format(lane,strm)
  pLine = pLine + '\n'        
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_cntl}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_laneId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_peId}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_strmId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_type}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_data}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_valid}} '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_ready}} '.format(lane,strm)
  pLine = pLine + '\n'        
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_cntl}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_laneId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_peId}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_strmId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_type}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix float32      {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_data}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_valid}} '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_ready}} '.format(lane,strm)
                                                                                                                                                                   
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_cntl}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_laneId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_strmId}}'.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_type}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix float32      {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_data}}  '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_valid}} '.format(lane,strm)
  pLine = pLine + '\n add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {{/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_ready}} '.format(lane,strm)
  pLine = pLine + '\n'

  f.write(pLine)
  f.close()



