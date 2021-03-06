#!/usr/bin/env python


##*********************************************************************************************
##    File name   : createReadmem.py
##    Author      : Lee Baker
##    Affiliation : North Carolina State University, Raleigh, NC
##    Date        : Mar 2017
##    email       : lbbaker@ncsu.edu
##    Description : Open files created by dnnConnectivityAndMemoryAllocation.py and generate readmem files for simulation
##
##
##*********************************************************************************************
##

import numpy as np
import math
import sys
import os
import inspect
import copy
import time
import re
import pickle   # for saving variables
from copy import deepcopy as copy_deepcopy
from copy import copy as copy_copy
from collections import namedtuple
import operator # for attrgetter
from rcdtype import *

########################################################################################################################
## Create __FILE__ and __LINE__ for prints
## citation:http://stackoverflow.com/questions/6810999/how-to-determine-file-function-and-line-number
def __LINE__():
    try:
        raise Exception
    except:
        return sys.exc_info()[2].tb_frame.f_back.f_lineno

def __FILE__():
    return inspect.currentframe().f_code.co_filename

class __LINE__(object):
    import sys

    def __repr__(self):
        try:
            raise Exception
        except:
            return str(sys.exc_info()[2].tb_frame.f_back.f_lineno)

#__FILE__ = 'dnnConnectivityAndMemoryAllocation.py'

#lineNo = __LINE__()
########################################################################################################################

# Plotting
# 
# Check matplotlib version in case I run on ncsu linux machines that dont support animation
try:
  import matplotlib as mpl
  if (int(mpl.__version__.split('.')[0]) > 1) or  ((int(mpl.__version__.split('.')[0]) == 1) and (int(mpl.__version__.split('.')[1]) >= 4)) :
      del mpl
      import matplotlib.pyplot as plt
      import matplotlib.animation as manimation
      from pylab import *
      from matplotlib.colors import BoundaryNorm
      from matplotlib.ticker import MaxNLocator
      #from mpl_toolkits.mplot3d import Axes3D
  else :
      print '{0}:{1}:WARNING:Matplotlib not loaded, version doesnt support all features required'.format(__FILE__(), __LINE__())
except:
    print '{0}:{1}:WARNING:Matplotlib doesnt exist'.format(__FILE__(), __LINE__())
  
########################################################################################################################
## Globals

# Extract variables from HDL
FoundMemorySize = False
FoundNumOfPes   = False
FoundNumOfLanes = False
FoundLaneWidth  = False
FoundBitsPerCntl = False 

searchFile = open("../../github/ece-cortical-MainResearch/3DSystem/PEArray/HDL/common/common.vh", "r")
for line in searchFile:
  if FoundBitsPerCntl == False :
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "COMMON_STD_INTF_CNTL_WIDTH" in data[1]:
      bitsPerCntl       = int(data[2])
      FoundBitsPerCntl = True
searchFile.close()

searchFile = open("../../github/ece-cortical-MainResearch/3DSystem/PEArray/HDL/common/pe_array.vh", "r")
for line in searchFile:
  if FoundNumOfPes == False :
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "PE_ARRAY_NUM_OF_PE" in data[1]:
      numOfPes       = int(data[2])
      FoundNumOfPes  = True
searchFile.close()

searchFile = open("../../github/ece-cortical-MainResearch/3DSystem/PEArray/HDL/common/pe_array.vh", "r")
for line in searchFile:
  if FoundMemorySize == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "PE_ARRAY_CHIPLET_ADDRESS_WIDTH" in data[1]:
      memorySize      = int(data[2])
      FoundMemorySize = True
searchFile.close()

searchFile = open("../../github/ece-cortical-MainResearch/3DSystem/PEArray/HDL/common/pe.vh", "r")
for line in searchFile:
  if FoundNumOfLanes == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "PE_NUM_OF_EXEC_LANES" in data[1]:
      numOfLanes      = int(data[2])
      FoundNumOfLanes = True
searchFile.close()

searchFile = open("../../github/ece-cortical-MainResearch/3DSystem/PEArray/HDL/common/pe.vh", "r")
for line in searchFile:
  if FoundLaneWidth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "PE_EXEC_LANE_WIDTH" in data[1]:
      laneWidth      = int(data[2])
      FoundLaneWidth = True
searchFile.close()

searchFile = open("../../github/ece-cortical-MainResearch/3DSystem/Manager/HDL/common/manager.vh", "r")
FoundOptsPerInst  = False
FoundOptWidth  = False
FoundOptValWidth  = False
FoundStorageDescMemoryDepth = False
FoundDramChans = False
FoundDramBanks = False
FoundDramPages = False
FoundDramWords = False
FoundOperationWidth = False
FoundOptOrderWidth = False
FoundConsJumpPtrWidth = False
FoundLocalStorageDescMemoryDepth = False
FoundLocalConsJumpMemoryDepth = False
FoundDescToCJRatio = False
FoundCJWidth = False
FoundInstructionMemoryDepth = False
FoundMaxNumOfOperands = False



for line in searchFile:
  if FoundInstructionMemoryDepth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_WU_MEMORY_DEPTH" in data[1]:
      instructionMemoryDepth  = int(data[2])
      FoundInstructionMemoryDepth = True
  #
  if FoundOperationWidth== False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_INST_TYPE_WIDTH" in data[1]:
      bitsPerOperation      = int(data[2])
      FoundOperationWidth= True
  #
  if FoundOptsPerInst == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_WU_OPT_PER_INST" in data[1]:
      optionsPerInst      = int(data[2])
      FoundOptsPerInst = True
  #
  if FoundOptWidth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_WU_OPT_TYPE_WIDTH" in data[1]:
      optionWidth      = int(data[2])
      FoundOptWidth = True
  #
  if FoundOptValWidth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_WU_OPT_VALUE_WIDTH" in data[1]:
      optionValueWidth      = int(data[2])
      FoundOptValueWidth = True
  #
  if FoundOptOrderWidth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_INST_OPTION_ORDER_WIDTH" in data[1]:
      optionOrderWidth      = int(data[2])
      FoundOptOrderWidth = True
  #

  if FoundLocalStorageDescMemoryDepth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_LOCAL_STORAGE_DESC_MEMORY_DEPTH" in data[1]:
      localStorageDescMemoryDepth = int(data[2])
      FoundLocalStorageDescMemoryDepth = True

  if FoundMaxNumOfOperands == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_OP_MAX_NUM_OF_OPERANDS" in data[1]:
      maxNumOfOperands = int(data[2])
      FoundMaxNumOfOperands = True
      maxNumOfOperandsWidth = int(math.log(int(data[2]),2))


  if FoundLocalConsJumpMemoryDepth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_INST_CONS_JUMP_DEPTH" in data[1]:
      localConsJumpMemoryDepth = int(data[2])
      FoundLocalConsJumpMemoryDepth = True

  #
  if FoundCJWidth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_OP_MAX_NUM_OF_OPERANDS" in data[1]:
      cjWidth = int(math.log(int(data[2]),2)) + int(math.log(numOfLanes,2))
      #cjWidth = int(data[2])
      FoundCJWidth = True
  #
 
  #
  if FoundDramChans == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_DRAM_NUM_CHANNELS" in data[1]:
      numOfDramChans = int(data[2])
      FoundDramChans = True
  #
  if FoundDramBanks == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_DRAM_NUM_BANKS" in data[1]:
      numOfDramBanks = int(data[2])
      FoundDramBanks = True
  #
  if FoundDramPages == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_DRAM_NUM_PAGES" in data[1]:
      numOfDramPages = int(data[2])
      FoundDramPages = True
  #
  if FoundDramWords == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_DRAM_PAGE_SIZE" in data[1]:
      numOfDramWords = int(data[2])/32
      FoundDramWords = True
  #
  if FoundStorageDescMemoryDepth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_LOCAL_STORAGE_DESC_MEMORY_DEPTH" in data[1]:
      storageDescMemoryDepth = int(data[2])
      FoundStorageDescMemoryDepth = True

searchFile.close()

#print numOfPes, memorySize, numOfLanes, laneWidth
NUMOFEXECLANES = numOfLanes
## Memory
WORDSIZE = laneWidth




## Extract class methods and fields for prints
## citation:http://stackoverflow.com/questions/1911281/how-do-i-get-list-of-methods-in-a-python-class
from types import FunctionType
def methods(cls):
    ## too ugly return [x for x, y in cls.__dict__.items() if type(y) == FunctionType]
    return [func for func in dir(cls) if callable(getattr(cls, func)) and not func.startswith("__")]
def fields(cls):
    return vars(cls).keys()


def toHexPad(val, pad):
  return str(hex(val).split('x')[1]).zfill(pad)
########################################################################################################################


########################################################################################################################
## MAIN

#print 'LEE:' + __name__

def main():
    
  # to run within python
  # if True:
    
  try:
      reload(dc)
      print  'dc reloaded'
  except Exception:
      print 'dc not loaded yet'
  
  ########################################################################################################################
  ## Globals


  CREATEFILES     = True
  CREATEANIMATION = False
  DEBUG           = False
  RUNCHECKS       = False

  ########################################################################################################################

  import numpy as np
  import dnnConnectivityAndMemoryAllocation as dc
 

  dirStr = './outputFiles/'
  if not os.path.exists(dirStr) :
      print '{0}:{1}:ERROR: {2} doesnt exist '.format(__FILE__(), __LINE__(), dirStr)
      raise
  dirStr = dirStr + 'latest/'
  if not os.path.exists(dirStr) :
      print '{0}:{1}:ERROR: Latest link {2} doesnt exist '.format(__FILE__(), __LINE__(), dirStr)
      raise
  # Find manager array dimensions from network configuration
  inputFile = dirStr + "network_configuration.txt"
  iFile = open(inputFile, "r")
  for line in iFile:
    line = re.sub('[\n ]', '', line)
    if line :
      if not line.startswith('#'):
        config = line.split(':')
        if config[0] == 'arrayY':
          arrayY = int(config[1])
        elif config[0] == 'arrayX':
          arrayX = int(config[1])
  iFile.close()



  for mgrY in range(arrayY):
    for mgrX in range(arrayY):

      #----------------------------------------------------------------------------------------------------
      # Create WU instruction memory

      managerFileExists = True
      layerID = 1
      mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
      if not os.path.exists(mgrDirStr) :
          print '{0}:{1}:WARNING: Directory {2} doesnt exist '.format(__FILE__(), __LINE__(), mgrDirStr)
          managerFileExists = False
      inputFile = mgrDirStr + "manager_{0}_{1}_layer{2}_WUs.txt".format(mgrY, mgrX, layerID)
      if not os.path.isfile(inputFile) :
          print '{0}:{1}:WARNING: Manager file {2} doesnt exist '.format(__FILE__(), __LINE__(), inputFile)
          managerFileExists = False
  
      if managerFileExists :

        iFile = open(inputFile, "r")
   
        descriptors = []
        for line in iFile:
          line = re.sub('[\n ]', '', line)
          if line :
            if not line.startswith('#'):
              descriptors.append(line.split('****'))
        icntl = []
        option = []
        optionValue = []
        for opts in range(optionsPerInst):
            option.append([])
            optionValue.append([])
        op = []
        dcntl = []
        pass
        for listOfDesc in descriptors:
          numOfDescriptors = len(listOfDesc)
          instNum = 0
          descNum = 0
          for desc in listOfDesc:
            print '{0}:{1}:INFO: Manager {2} Layer {3} Descriptor {4} of {5}'.format(__FILE__(), __LINE__(), mgrY*arrayX+mgrX, layerID, descNum,len(listOfDesc))
            print '{0}:{1}:LEE: {2}'.format(__FILE__(), __LINE__(), desc)
            instTuples = desc.split(',')
            # Remove SOD and EOD
            del instTuples[0]
            del instTuples[-1]
            numTuples = len(instTuples)
            print '{0}:{1}:LEE: number of tuples = {2}'.format(__FILE__(), __LINE__(), numTuples)
            #print descNum, numOfDescriptors, numTuples
            tupleNum = 0
            tupInInstNum = 0
            descComplete = False
            descCycleNum = 0
            #for t in range(numTuples):
            while tupleNum < numTuples :
              t = tupleNum
              # Extract operation
              optionAndValue = instTuples[t].split(':')
              #print optionAndValue
              optType = int(optionAndValue[0])
              # test where we are in the desc
              isOp = False
              lastTuple = False
              # First tuple is the operation
              if tupleNum == 0:
                oper = optType
                #op.append(optType)
              elif getattr(dc.optionType, 'NOP') == optType:
                print '{0}:{1}:INFO: Last tuple'.format(__FILE__(), __LINE__())
                lastTuple = True
              elif len(optionAndValue)==2:
                print '{0}:{1}:INFO: Middle tuple: {2}, tuple num = {3}, inst number = {4}, available slots = {5}'.format(__FILE__(), __LINE__(), optionAndValue, tupleNum, tupInInstNum, optionsPerInst )
                optVal = re.sub('[\n ]', '', optionAndValue[1])
              else :
                print '{0}:{1}:ERROR: single tuple but not op or EOD'.format(__FILE__(), __LINE__())
              #
              #
              #if not lastTuple:
              # First tuple is the operation, so ignore
              if not tupleNum == 0:
                if getattr(dc.optionType,'MEMORY') == optType :
                  # Memory tuple takes 2 tuples, so make sure enough space in current inst
                  #print '{0}:{1}:LEE:Memory tuple: {2} {3} {4}'.format(__FILE__(), __LINE__(), str(optionAndValue), str(tupInInstNum), str(lastTuple))
                  # pad and split adderss into bytes
                  # The storage descriptor ptr is PE_Address, so create PE bits, ADdress bits, append and split into bytes
                  # Check to ensure no longer than 24 bits
                  descPtr = optVal.split("_")
                  descPtrAddress = ''
                  peBits = math.log(numOfPes,2)
                  descPtrAddress = descPtrAddress + bin(int(descPtr[0], 16)).split('b')[1].zfill(int(peBits))
                  descPtrAddrBits = math.log(storageDescMemoryDepth,2)
                  print '{0}:{1}:LEE: {2} {3}'.format(__FILE__(), __LINE__(), peBits, descPtrAddrBits )
                  descPtrAddress = descPtrAddress + bin(int(descPtr[1], 16)).split('b')[1].zfill(int(descPtrAddrBits))
                  descPtrHexAddress=str(hex(int(descPtrAddress,2)).split('x')[1]).zfill(6)
                  descPtrAddressBits = peBits + descPtrAddrBits
                  # separate groups of 2 nibbles
                  memBytes = re.findall('.{1,2}', descPtrHexAddress.zfill(6))
                  if len(memBytes) > 3:
                    print '{0}:{1}:ERROR: single tuple but not op or EOD'.format(__FILE__(), __LINE__())
                    raise
                  print '{0}:{1}:LEE: {2} {3}'.format(__FILE__(), __LINE__(), memBytes, descPtr)
                  if tupInInstNum < (optionsPerInst-1):
                    option[tupInInstNum].append(optType)
                    optionValue[tupInInstNum].append(memBytes[0])
                    tupInInstNum += 1
                    option[tupInInstNum].append(memBytes[1])
                    optionValue[tupInInstNum].append(memBytes[2])
                    tupInInstNum += 1
                    if (tupleNum == numTuples-2):
                      print '{0}:{1}:INFO: Last tuple is a memory tuple: {2} of {3}'.format(__FILE__(), __LINE__(), tupleNum, numTuples)
                      lastTuple = True
                      # force a stop
                      tupleNum += 1
                  else:
                    # not enuff space in current instruction for memory option, so pad with NOP and jump to next instruction
                    for pad in range(tupInInstNum, optionsPerInst):
                      option[pad].append(getattr(dc.optionType, 'NOP'))
                      # dont care about value
                      optionValue[pad].append(getattr(dc.optionType, 'NOP'))
                      tupInInstNum += 1
                      tupleNum -= 1
                elif (getattr(dc.optionType,'NUM_OF_ARG0_OPERANDS') == optType) or (getattr(dc.optionType,'NUM_OF_ARG1_OPERANDS') == optType) :
                  if tupInInstNum < (optionsPerInst-1):
                    option[tupInInstNum].append(optType)
                    numOfOperands=bin(int(optVal, 16)).split('b')[1].zfill(int(maxNumOfOperandsWidth))
                    print '{0}:{1}:LEE: numOfOperands {2}'.format(__FILE__(), __LINE__(), numOfOperands)
                    numOfOperandsHex=str(hex(int(numOfOperands,2)).split('x')[1]).zfill(6)
                    numOperandsBytes = re.findall('.{1,2}', numOfOperandsHex.zfill(6))
                    optionValue[tupInInstNum].append(numOperandsBytes [0])
                    tupInInstNum += 1
                    option[tupInInstNum].append(numOperandsBytes [1])
                    optionValue[tupInInstNum].append(numOperandsBytes [2])
                    tupInInstNum += 1
                    if (tupleNum == numTuples-2):
                      print '{0}:{1}:INFO: Last tuple is a numOperand tuple: {2} of {3}'.format(__FILE__(), __LINE__(), tupleNum, numTuples)
                      lastTuple = True
                      # force a stop
                      tupleNum += 1
                  else:
                    # not enuff space in current instruction for memory option, so pad with NOP and jump to next instruction
                    for pad in range(tupInInstNum, optionsPerInst):
                      option[pad].append(getattr(dc.optionType, 'NOP'))
                      # dont care about value
                      optionValue[pad].append(getattr(dc.optionType, 'NOP'))
                      tupInInstNum += 1
                      tupleNum -= 1
                    pass
                else:
                    # non-memory tuple
                    option[tupInInstNum].append(optType)
                    if not lastTuple:
                      optionValue[tupInInstNum].append(optVal)
                    else:
                      optionValue[tupInInstNum].append(getattr(dc.optionType, 'NOP'))
                    tupInInstNum += 1
              if lastTuple:
                # Last tuple
                print '{0}:{1}:LEE:  Last tuple: {2} {3}'.format(__FILE__(), __LINE__(), tupInInstNum, optionsPerInst)
                #print 'Descriptor complete'
                descComplete = True
                # Pad instruction
                for pad in range(tupInInstNum, optionsPerInst):
                  option[pad].append(getattr(dc.optionType, 'NOP'))
                  # dont care about value
                  optionValue[pad].append(getattr(dc.optionType, 'NOP'))
                  tupInInstNum += 1
              #----------------------------------------------------------------------------------------------------
              #  Check if we have completed an instruction
              if (tupInInstNum == optionsPerInst) :
                print '{0}:{1}:LEE:  Completed an instruction: {2}'.format(__FILE__(), __LINE__(), instNum)
                #print 'instruction #{0}'.format(instNum)
                #  Completedd an insruction, now set operation and delineators
                tupInInstNum = 0
                op.append(oper)
                #--------------------------------------------------
                # Instruction Delineation
                if not lastTuple :
                  # we have filled an instruction, set the operation and cntl fields 
                  # Instruction delineation
                  if instNum == 0:
                    icntl.append(getattr(dc.descDelin, 'SOD'))
                  else:
                    icntl.append(getattr(dc.descDelin, 'MOD'))
                else :
                  # Last tuple
                  if instNum == 0 and descNum == numOfDescriptors-1 :
                    icntl.append(getattr(dc.descDelin, 'SOD_EOD'))
                  elif instNum == 0 :
                    icntl.append(getattr(dc.descDelin, 'SOD'))
                  elif descNum == numOfDescriptors-1 :
                    icntl.append(getattr(dc.descDelin, 'EOD'))
                  else :
                    icntl.append(getattr(dc.descDelin, 'MOD'))
                #
                #--------------------------------------------------
                # Descriptor delineation
                if not lastTuple :
                  if descCycleNum == 0 :
                    dcntl.append(getattr(dc.descDelin, 'SOD'))
                  else:
                    dcntl.append(getattr(dc.descDelin, 'MOD'))
                else:
                  if descCycleNum == 0 :
                    dcntl.append(getattr(dc.descDelin, 'SOD_EOD'))
                  else:
                    dcntl.append(getattr(dc.descDelin, 'EOD'))
                instNum += 1
                descCycleNum += 1
              # we have filled an instruction, set the operation and cntl fields 
              tupleNum += 1
            # end for t ...
            descNum += 1
            #getattr(dc.optionType, dc.optionType._fields[0])
          #end for desc ...

        """
        # Create readmem-like ile with entire instruction
        pLine = ''
        for c in range(len(op)):
          pLine = pLine + '{0:>4} {1:>4} {2:>4} '.format(icntl[c], dcntl[c], op[c])
          for o in range(optionsPerInst):
            pLine = pLine + '{0:>4} {1:>4} \n'.format(option[o][c], optionValue[o][c])
        #
        mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
        outputFile = mgrDirStr + "manager_{0}_layer{1}_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
        oFile = open(outputFile, 'w')
        oFile.write(pLine)
        oFile.close()
        """

        # Create individual instruction readmem files
     
        pLine = ''
        mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
        outputFile = mgrDirStr + "manager_{0}_layer{1}_op_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
        oFile = open(outputFile, 'w')
        for c in range(len(op)):
          pLine = pLine + '@{0:>6} {1:>4} \n'.format(toHexPad(c, 6), op[c])
        oFile.write(pLine)
        oFile.close()


        pLine = ''
        mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
        outputFile = mgrDirStr + "manager_{0}_layer{1}_icntl_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
        oFile = open(outputFile, 'w')
        for c in range(len(icntl)):
          pLine = pLine + '@{0:>6} {1:>4} \n'.format(toHexPad(c, 6), icntl[c])
        oFile.write(pLine)
        oFile.close()

        pLine = ''
        mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
        outputFile = mgrDirStr + "manager_{0}_layer{1}_dcntl_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
        oFile = open(outputFile, 'w')
        for c in range(len(dcntl)):
          pLine = pLine + '@{0:>6} {1:>4} \n'.format(toHexPad(c, 6), dcntl[c])
        oFile.write(pLine)
        oFile.close()

        mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
        for o in range(optionsPerInst):
          pLine = ''
          outputFile = mgrDirStr + "manager_{0}_layer{1}_optionType{2}_readmem.dat".format(mgrY*arrayX+mgrX, layerID, o)
          oFile = open(outputFile, 'w')
          for c in range(len(dcntl)):
            pLine = pLine + '@{0:>6} {1:>4} \n'.format(toHexPad(c, 6), option[o][c])
          oFile.write(pLine)
          oFile.close()

        mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
        for o in range(optionsPerInst):
          pLine = ''
          outputFile = mgrDirStr + "manager_{0}_layer{1}_optionValue{2}_readmem.dat".format(mgrY*arrayX+mgrX, layerID, o)
          oFile = open(outputFile, 'w')
          for c in range(len(dcntl)):
            pLine = pLine + '@{0:>6} {1:>4} \n'.format(toHexPad(c, 6), optionValue[o][c])
          oFile.write(pLine)
          oFile.close()



        # Create an aggregate WU instruction memory
     
        pLine = ''
        mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
        outputFile = mgrDirStr + "manager_{0}_layer{1}_instruction_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
        oFile = open(outputFile, 'w')

        for c in range(min(len(icntl), instructionMemoryDepth)):
          instruction = ''
          instruction = bin(int(str(icntl[c]),16)).split('b')[1].zfill(bitsPerCntl) + instruction
          instruction = bin(int(str(dcntl[c]),16)).split('b')[1].zfill(bitsPerCntl) + instruction
          instruction = bin(int(str(op[c]),16)).split('b')[1].zfill(bitsPerOperation) + instruction
          for o in range(optionsPerInst):
            instruction = bin(int(str(option[o][c]),16)).split('b')[1].zfill(optionWidth ) + instruction
            instruction = bin(int(str(optionValue[o][c]),16)).split('b')[1].zfill(optionWidth ) + instruction

          if len(instruction)%4 == 0:
            lenInstInHex = len(instruction)/4
          else :
            lenInstInHex = len(instruction)/4 + 1
          pLine = pLine + '@{0:>6} {1:>{2}} \n'.format(toHexPad(c, 6), toHexPad(int(instruction,2), lenInstInHex), lenInstInHex)
        oFile.write(pLine)
        oFile.close()


        print '{0}:{1}:INFO: Created manager_{2}_{3} instruction readmem files'.format(__FILE__(), __LINE__(), mgrY, mgrX)


      #----------------------------------------------------------------------------------------------------
      # Create Storage Descriptor memory

      #  - Three memories, one containing local start address, one with access order and one with a pointer to consequtive/jump memory
      #  - Two memories, one with cntl delineator and another containing consequtive and jump values in orderA
      #    with last entry being EOD, consequtive

      dirStr = './outputFiles/latest/'
      managerFileExists = True
      layerID = 1
      mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
      if not os.path.exists(mgrDirStr) :
          print '{0}:{1}:WARNING: Directory {2} doesnt exist '.format(__FILE__(), __LINE__(), mgrDirStr)
          managerFileExists = False
      inputFile = mgrDirStr + "manager_{0}_{1}_layer{2}_storageDescriptors.txt".format(mgrY, mgrX, layerID)
      if not os.path.isfile(inputFile) :
          print '{0}:{1}:WARNING: Manager file {2} doesnt exist '.format(__FILE__(), __LINE__(), inputFile)
          managerFileExists = False
      #
      if managerFileExists :
        iFile = open(inputFile, "r")
        storageDescriptors = []
        for line in iFile:
          line = re.sub('[\n]', '', line)
          if line :
            if not line.startswith('#'):
              storageDescriptors.append(line.split(' '))
      #
      nextConsJumpPtr = 0
      consJumpMemory = []
      sdAddress = []
      memAddress = []
      accessOrder = []
      consJumpPtr = []
      cjCntl = []
      for sd in storageDescriptors:
        print '{0}:{1}:INFO: New storage descriptor {2} '.format(__FILE__(), __LINE__(), str(sd))
        sdAddress.append(sd[0])
        del(sd[0])
        addressFields = sd[0].split("_")   
        address = ''
        peBits = math.log(numOfPes,2)
        address = address + bin(int(addressFields[0], 16)).split('b')[1].zfill(int(peBits))
        print address
        channelBits = math.log(numOfDramChans,2)
        address = address + bin(int(addressFields[1], 16)).split('b')[1].zfill(int(channelBits))
        print address
        bankBits = math.log(numOfDramBanks,2)
        address = address + bin(int(addressFields[2], 16)).split('b')[1].zfill(int(bankBits))
        print address
        pageBits = math.log(numOfDramPages,2)
        address = address + bin(int(addressFields[3], 16)).split('b')[1].zfill(int(pageBits))
        print address
        wordBits = math.log(numOfDramWords,2)
        address = address + bin(int(addressFields[4], 16)).split('b')[1].zfill(int(wordBits))
        print address
        numOfAddressBits = int(peBits) + int(channelBits) + int(bankBits) + int(pageBits) + int(wordBits)  + 2 # byte address
        # byte address
        address = address + '00'
        print address

        print 'number of address bits {0} {1} {2} {3} {4} = {5}'.format(int(peBits), int(channelBits), int(bankBits), int(pageBits), int(wordBits), numOfAddressBits)
        print 'number of address bits {0} {1} {2} {3} {4} {5}'.format(bin(int(addressFields[0], 16)).split('b')[1].zfill(int(peBits)), bin(int(addressFields[1], 16)).split('b')[1].zfill(int(channelBits)), bin(int(addressFields[2], 16)).split('b')[1].zfill(int(bankBits)), bin(int(addressFields[3], 16)).split('b')[1].zfill(int(pageBits)), bin(int(addressFields[4], 16)).split('b')[1].zfill(int(wordBits)), '00')
        print re.findall('....', address)

        addressLength = peBits+channelBits+bankBits+pageBits+wordBits+2
        memAddress.append(str(hex(int(address,2)).split('x')[1]).zfill(9))
        print '{0}:{1}:LEE: {2} {3} {4} {5}'.format(__FILE__(), __LINE__(), address, hex(int(address,2)), hex(int(address,2)).split('x')[1], memAddress[-1])
        del(sd[0])
        accessOrder.append(sd[0])
        del(sd[0])
        consJumpPtr.append(str(hex(int(nextConsJumpPtr)).split('x')[1]))
        fieldNum = 0
        # the first field is consequtive value
        consequtiveField = True
        jumpField = False
        while fieldNum < len(sd) :
          #print '{0}:{1}:INFO: processing field {2} of {3} '.format(__FILE__(), __LINE__(), fieldNum, str(sd))
          consJumpMemory.append(sd[fieldNum])
          if consequtiveField:
            # if only one consequitive field
            if fieldNum == 0 and int(sd[fieldNum+1]) == 0:
              cjCntl.append(getattr(dc.descDelin, 'SOD_EOD'))
            elif fieldNum == 0 :
              cjCntl.append(getattr(dc.descDelin, 'SOD'))
            elif int(sd[fieldNum+1]) == 0:
              cjCntl.append(getattr(dc.descDelin, 'EOD'))
            else:
              cjCntl.append(getattr(dc.descDelin, 'MOD'))
          else :
            cjCntl.append(getattr(dc.descDelin, 'MOD'))
          #
          if consequtiveField:
            consequtiveField = False
            jumpField = True
            # jump over valid, if next field is invalid, we'll drop out of the while loop
            fieldNum += 2
          else:
            consequtiveField = True
            jumpField = False
            # jump over consequtive field
            fieldNum += 1
          nextConsJumpPtr += 1
          
      pLine = ''
      mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
      outputFile = mgrDirStr + "manager_{0}_layer{1}_storageDescriptorAddress_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
      oFile = open(outputFile, 'w')
      for c in range(len(sdAddress)):
        pLine = pLine + '@{0:>6} {1:>9} \n'.format(sdAddress[c].zfill(8), memAddress[c].zfill(9))
      oFile.write(pLine)
      oFile.close()
        
      pLine = ''
      mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
      outputFile = mgrDirStr + "manager_{0}_layer{1}_storageDescriptorAccessOrder_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
      oFile = open(outputFile, 'w')
      for c in range(len(sdAddress)):
        pLine = pLine + '@{0:>6} {1:>4} \n'.format(sdAddress[c].zfill(6), accessOrder[c])
      oFile.write(pLine)
      oFile.close()
        
      pLine = ''
      mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
      outputFile = mgrDirStr + "manager_{0}_layer{1}_storageDescriptorPtr_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
      oFile = open(outputFile, 'w')
      for c in range(len(sdAddress)):
        pLine = pLine + '@{0:>6} {1:>4} \n'.format(sdAddress[c].zfill(6), consJumpPtr[c])
      oFile.write(pLine)
      oFile.close()
        
      pLine = ''
      mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
      outputFile = mgrDirStr + "manager_{0}_layer{1}_storageDescriptorConsJumpCntl_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
      oFile = open(outputFile, 'w')
      for c in range(len(cjCntl)):
        pLine = pLine + '@{0:>6} {1:>4} \n'.format(toHexPad(c, 6), cjCntl[c])
      oFile.write(pLine)
      oFile.close()
        
      pLine = ''
      mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
      outputFile = mgrDirStr + "manager_{0}_layer{1}_storageDescriptorConsJumpFields_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
      oFile = open(outputFile, 'w')
      for c in range(len(cjCntl)):
        pLine = pLine + '@{0:>6} {1:>3} \n'.format(toHexPad(c, 6), consJumpMemory[c])
      oFile.write(pLine)
      oFile.close()
        
      # Create aggregate storage desciptor memory
  
      # Aggregate Address/AccessOrder,ConsJump_ptr memory
      pLine = ''
      mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
      outputFile = mgrDirStr + "manager_{0}_layer{1}_storageDescriptor_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
      oFile = open(outputFile, 'w')
      consJumpPtrWidth = int(math.log(localConsJumpMemoryDepth ,2))
      for c in range(len(sdAddress)):
        print 'Manager {0}: Storage Descriptor Entry : {1} of {2}'.format(mgrY*arrayX+mgrX, c, len(memAddress))
        instruction = ''
        instruction = bin(int(accessOrder[c],16)).split('b')[1].zfill(optionOrderWidth) + instruction
        print 'Instruction : {0}'.format(instruction)
        instruction = bin(int(consJumpPtr[c],16)).split('b')[1].zfill(consJumpPtrWidth )[-consJumpPtrWidth:] + instruction
        print 'Instruction : {0}'.format(instruction)
        instruction = bin(int(memAddress[c],16)).split('b')[1].zfill(numOfAddressBits) + instruction
        print 'Instruction : {0}'.format(instruction)
        if len(instruction)%4 == 0:
          lenInstInHex = len(instruction)/4
        else :
          lenInstInHex = len(instruction)/4 + 1
        pLine = pLine + '@{0:>6} {1:>{2}} \n'.format(toHexPad(c, 6), toHexPad(int(instruction,2), lenInstInHex), lenInstInHex)
        
      oFile.write(pLine)
      oFile.close()
        
      # Aggregate cntl/ConsJump memory
      pLine = ''
      mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
      outputFile = mgrDirStr + "manager_{0}_layer{1}_storageDescriptorConsJump_readmem.dat".format(mgrY*arrayX+mgrX, layerID)
      oFile = open(outputFile, 'w')
      for c in range(min(len(cjCntl), localConsJumpMemoryDepth)):
        print 'Cons/Jump Entry : {0} : of {1} entries'.format(c, len(cjCntl))
        instruction = ''
        instruction = bin(int(consJumpMemory[c],16)).split('b')[1].zfill(cjWidth ) + instruction
        print 'Instruction : {0}'.format(instruction)
        instruction = bin(int(str(cjCntl[c]),16)).split('b')[1].zfill(bitsPerCntl) + instruction
        print 'Instruction : {0}'.format(instruction)
        if len(instruction)%4 == 0:
          lenInstInHex = len(instruction)/4
        else :
          lenInstInHex = len(instruction)/4 + 1
        pLine = pLine + '@{0:>6} {1:>{2}} \n'.format(toHexPad(c, 6), toHexPad(int(instruction,2), lenInstInHex), lenInstInHex)
        
      oFile.write(pLine)
      oFile.close()
        


  #------------------------------------------------------------------------------------------------------------------------
  # End main()
  #------------------------------------------------------------------------------------------------------------------------

    
if __name__ == "__main__":main()


