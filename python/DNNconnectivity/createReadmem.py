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

########################################################################################################################
## Globals

# Extract variables from HDL
FoundMemorySize = False
FoundNumOfPes   = False
FoundNumOfLanes = False
FoundLaneWidth  = False

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
FoundDramChans = False
FoundDramBanks = False
FoundDramPages = False
FoundDramWords = False
for line in searchFile:
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

searchFile.close()

#print numOfPes, memorySize, numOfLanes, laneWidth
NUMOFEXECLANES = numOfLanes
## Memory
WORDSIZE = laneWidth

FoundDescPtrWidth = False

descPtrWidth      = 17  # default if not found



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
        instNum = 0
        pass
        for listOfDesc in descriptors:
          numOfDescriptors = len(listOfDesc)
          descNum = 0
          for desc in listOfDesc:
            instTuples = desc.split(',')
            # Remove SOD and EOD
            del instTuples[0]
            del instTuples[-1]
            numTuples = len(instTuples)
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
                lastTuple = True
              elif len(optionAndValue)==2:
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
                  memBytes = re.findall('.{1,2}', optVal.zfill(6))
                  #print '{0}:{1}:LEE: {2}'.format(__FILE__(), __LINE__(), memBytes)
                  if tupInInstNum < (optionsPerInst-1):
                    option[tupInInstNum].append(optType)
                    optionValue[tupInInstNum].append(memBytes[0])
                    tupInInstNum += 1
                    option[tupInInstNum].append(memBytes[1])
                    optionValue[tupInInstNum].append(memBytes[2])
                    tupInInstNum += 1
                  else:
                    # not enuff space in current instruction for memory option, so pad with NOP and jump to next instruction
                    for pad in range(tupInInstNum, optionsPerInst):
                      option[pad].append(getattr(dc.optionType, 'NOP'))
                      # dont care about value
                      optionValue[pad].append(getattr(dc.optionType, 'NOP'))
                      tupInInstNum += 1
                      tupleNum -= 1
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

        pLine = ''
        mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
        for o in range(optionsPerInst):
          outputFile = mgrDirStr + "manager_{0}_layer{1}_optionType{2}_readmem.dat".format(mgrY*arrayX+mgrX, layerID, o)
          oFile = open(outputFile, 'w')
          for c in range(len(dcntl)):
            pLine = pLine + '@{0:>6} {1:>4} \n'.format(toHexPad(c, 6), option[o][c])
          oFile.write(pLine)
          oFile.close()

        mgrDirStr = dirStr + 'manager_{0}_{1}/'.format(mgrY, mgrX)
        for o in range(optionsPerInst):
          outputFile = mgrDirStr + "manager_{0}_layer{1}_optionValue{2}_readmem.dat".format(mgrY*arrayX+mgrX, layerID, o)
          oFile = open(outputFile, 'w')
          for c in range(len(dcntl)):
            pLine = pLine + '@{0:>6} {1:>4} \n'.format(toHexPad(c, 6), optionValue[o][c])
          oFile.write(pLine)
          oFile.close()

        print '{0}:{1}:INFO: Created {2} '.format(__FILE__(), __LINE__(), outputFile)



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
        channelBits = math.log(numOfDramChans,2)
        address = address + bin(int(addressFields[1], 16)).split('b')[1].zfill(int(channelBits))
        bankBits = math.log(numOfDramBanks,2)
        address = address + bin(int(addressFields[2], 16)).split('b')[1].zfill(int(bankBits))
        pageBits = math.log(numOfDramPages,2)
        address = address + bin(int(addressFields[3], 16)).split('b')[1].zfill(int(pageBits))
        wordBits = math.log(numOfDramWords,2)
        address = address + bin(int(addressFields[4], 16)).split('b')[1].zfill(int(wordBits))
        # byte address
        address = address + '00'

        addressLength = peBits+channelBits+bankBits+pageBits+wordBits+2
        memAddress.append(str(hex(int(address,2)).split('x')[1]).zfill(9))
        print address, hex(int(address,2)), hex(int(address,2)).split('x')[1], memAddress[-1]
        del(sd[0])
        accessOrder.append(sd[0])
        del(sd[0])
        consJumpPtr.append(nextConsJumpPtr )
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
        pLine = pLine + '@{0:>6} {1:>4} \n'.format(toHexPad(c, 6), consJumpMemory[c])
      oFile.write(pLine)
      oFile.close()
        
        
        
  #------------------------------------------------------------------------------------------------------------------------
  # End main()
  #------------------------------------------------------------------------------------------------------------------------

    
if __name__ == "__main__":main()


