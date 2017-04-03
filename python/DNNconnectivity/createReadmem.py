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
for line in searchFile:
  if FoundOptsPerInst == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_WU_OPT_PER_INST" in data[1]:
      optionsPerInst      = int(data[2])
      FoundOptsPerInst = True
  if FoundOptWidth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_WU_OPT_TYPE_WIDTH" in data[1]:
      optionWidth      = int(data[2])
      FoundOptWidth = True
  if FoundOptValWidth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "MGR_WU_OPT_VALUE_WIDTH" in data[1]:
      optionValueWidth      = int(data[2])
      FoundOptValueWidth = True
searchFile.close()

#print numOfPes, memorySize, numOfLanes, laneWidth
NUMOFEXECLANES = numOfLanes
## Memory
WORDSIZE = laneWidth

FoundDescPtrWidth = False

descPtrWidth      = 17  # default if not found

################################################################################
## FIXME
################################################################################
"""
searchFile = open("../../github/ece-cortical-MainResearch/3DSystem/Manager/HDL/common/descriptor.vh", "r")
for line in searchFile:
  if FoundDescPtrWidth == False:
    data = re.split(r'\s{1,}', line)
    # check define is in 2nd field
    if "DESC_POINTER_WIDTH" in data[1]:
      descPtrWidth      = int(data[2])
      FoundDescPtrWidth = True
searchFile.close()
"""


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

print 'LEE:' + __name__

def main():
    
  # to run within python
  # if True:
    
  print 'LEE: Run main'
    
  try:
      reload(crm)
      print  'crm reloaded'
  except Exception:
      print 'crm not loaded yet'
  
  ########################################################################################################################
  ## Globals


  CREATEFILES     = True
  CREATEANIMATION = False
  DEBUG           = False
  RUNCHECKS       = False

  ########################################################################################################################

  import numpy as np
  import createReadmem as crm
  import dnnConnectivityAndMemoryAllocation as dc
 
  inputFile = open("./outputFiles/latest/manager_0_0/manager_0_0_layer1_WUs.txt", "r")
  descriptors = []
  for line in inputFile:
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
      print descNum, numOfDescriptors, numTuples
      tupleNum = 0
      tupInInstNum = 0
      descComplete = False
      descCycleNum = 0
      #for t in range(numTuples):
      while tupleNum < numTuples :
        t = tupleNum
        # Extract operation
        optionAndValue = instTuples[t].split(':')
        print optionAndValue
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
          optVal = int(optionAndValue[1])
        else :
          print 'ERROR: single tuple but not op or EOD'
        #
        #
        #if not lastTuple:
        # First tuple is the operation, so ignore
        if not tupleNum == 0:
          if getattr(dc.optionType,'MEMORY') == optType :
            # Memory tuple takes 2 tuples, so make sure enough space in current inst
            print 'Memory tuple: ' + str(optionAndValue) + str(tupInInstNum) + str(lastTuple)
            if tupInInstNum < (optionsPerInst-1):
              option[tupInInstNum].append(optType)
              optionValue[tupInInstNum].append(optVal)
              tupInInstNum += 1
              option[tupInInstNum].append(optVal)
              optionValue[tupInInstNum].append(optVal)
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
          print 'Descriptor complete'
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
          print 'instruction #{0}'.format(instNum)
          #  Completed an insruction, now set operation and delineators
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
    pLine = ''
    for c in range(len(op)):
      pLine = pLine + '\n{0:4} {1:4} {2:4}'.format(icntl[c], dcntl[c], op[c])
      for o in range(optionsPerInst):
        pLine = pLine + '{0:4} {1:4} '.format(option[o][c], optionValue[o][c])
    #
    print pLine
