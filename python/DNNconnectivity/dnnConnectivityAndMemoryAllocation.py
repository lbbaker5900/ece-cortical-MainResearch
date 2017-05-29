#!/usr/bin/env python


##*********************************************************************************************
##    File name   : dnnConnectivityAndMemoryAllocation.py
##    Author      : Lee Baker
##    Affiliation : North Carolina State University, Raleigh, NC
##    Date        : Nov 2016
##    email       : lbbaker@ncsu.edu
##    Description : Construct a DNN and determine PE neuron assignments.
##                  Generate results and to which PE's they are sent.
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


#print sys.argv.__len__()
#print sys.argv[0]
#print sys.argv[1]
#X=int(sys.argv[1])

#numOfPEs = 64
#arrayX = np.sqrt(numOfPEs)
#l=arrayX
#n=np.floor(X/l)
#Xp = X
#while np.remainder(Xp, l) != 0 :
#   Xp = Xp - (n+1)
#   l = l-1
#
#m=8-l

#print int(l), " sets of ", int(Xp/l), " and ", int(m), " sets of ", int((X-Xp)/m)

##----------------------------------------------------------------------------------------------------
## FIXME's
##
## the layer is now a 3-D array of cells but in the lot of cases we only refer to the first cell in the Z-dimension
## => fix where we have .cells[0]...

point = namedtuple("point", "z y x") 
Point = recordtype('Point', 'z y x')

MemoryConfiguration = namedtuple('MemoryConfiguration',\
                                 'numOfChannels        \
                                  numOfBanksPerChannel \
                                  numOfPagesPerBank    \
                                  sizeOfPage          ')
"""
MemoryAllocationOptions = namedtuple('MemoryAllocationOptions',\
                                     'order                    \
                                      initialChannel           \
                                      channelIncrement         \
                                      initialBank              \
                                      bankIncrement            \
                                      initialPage              \
                                      pageIncrement            \
                                      initialWord              \
                                      wordIncrement            \
                                      padWordRadix2           ')
"""
displayOptions = namedtuple('displayOptions', \
                            'pplot            \
                             pprint           \
                             createFile    '  )
displayOptions.__new__.__defaults__ = (False, False, False)

memoryLocationAccessOptions = namedtuple('memoryLocationAccessOptions',\
                                         'allowOverWrite')

########################################################################################################################
## DESCRIPTORS

DescriptorDelin = namedtuple('DescriptorDelin',   \
                                     'WIDTH       \
                                      SOD         \
                                      MOD         \
                                      EOD         \
                                      SOD_EOD     ')
DescriptorDelin.__new__.__defaults__ = (0, 1, 0, 2, 3)
descDelin = DescriptorDelin()
w = int(math.ceil(math.log(len(descDelin)-1,16)))
DescriptorDelin.__new__.__defaults__ = (w, 1, 0, 2, 3)
descDelin = DescriptorDelin()
#descDelin  = DescriptorDelin._make([int(math.ceil(math.log(len(DescriptorDelin._fields)-1,16)))] + range(len(DescriptorDelin._fields)-1))

# FIXME : VERILOG
# must match manager_typedef.vh
DescriptorType = namedtuple('DescriptorType',   \
                                     'WIDTH      \
                                      NOP        \
                                      OP         \
                                      MR         \
                                      MW         ')
descType  = DescriptorType._make([int(math.ceil(math.log(len(DescriptorType._fields)-1,16)))] + range(len(DescriptorType._fields)-1))

OptionType = namedtuple('OptionType',   \
                                     'WIDTH          \
                                      NOP            \
                                      SRC            \
                                      TGT            \
                                      TXFER          \
                                      NUM_OF_LANES   \
                                      stOp           \
                                      simdOp         \
                                      MEMORY        ')
optionType  = OptionType._make([int(math.ceil(math.log(len(OptionType._fields)-1,16)))] + range(len(OptionType._fields)-1))

# Note: For now, with these stOp commands, we will map an option value to the larger regFile streamingOp command, address, number of operands etc. 
# as required by the streamingOp_cntl module in the verilog code
StOpValues = namedtuple('StOpValues',                                                   \
                                     'WIDTH                                             \
                                      NOP                                               \
                                      STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM \
                                      STREAMING_OP_CNTL_OPERATION_STD_NONE_NOP_TO_MEM   \
                                      STREAMING_OP_CNTL_OPERATION_MEM_STD_FP_MAC_TO_MEM \
                                      ')
stOpValues  = StOpValues._make([int(math.ceil(math.log(len(StOpValues._fields)-1,16)))] + range(len(StOpValues._fields)-1))

SIMDValues = namedtuple('SIMDValues',   \
                                     'WIDTH          \
                                      NOP            \
                                      ReLu          ')
simdValues  = SIMDValues._make([int(math.ceil(math.log(len(SIMDValues._fields)-1,16)))] + range(len(SIMDValues._fields)-1))

TGTValues = namedtuple('TGTValues',   \
                                     'WIDTH          \
                                      STACK_DN_ARG0  \
                                      STACK_DN_ARG1  \
                                      STACK_UP       \
                                      NOP            ')
tgtValues  = TGTValues._make([int(math.ceil(math.log(len(TGTValues._fields)-1,16)))] + range(len(TGTValues._fields)-1))
srcValues  = tgtValues

TXFERValues = namedtuple('TXFERValues',              \
                                     'WIDTH          \
                                      BCAST          \
                                      VECTOR         \
                                      NOP            ')
txferValues  = TXFERValues._make([int(math.ceil(math.log(len(TXFERValues._fields)-1,16)))] + range(len(TXFERValues._fields)-1))

OrderValues = namedtuple('OrderValues',              \
                                     'WIDTH          \
                                      cwbp           \
                                      wcbp           \
                                      NOP            ')
orderValues  = OrderValues._make([int(math.ceil(math.log(len(OrderValues._fields)-1,16)))] + range(len(OrderValues._fields)-1))




#------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------
# Create typedef files for verilog

timeStr = time.strftime("%Y%m%d")  # just today
dirStr = './verilogFiles/'
if not os.path.exists(dirStr) :
    os.makedirs(dirStr)
dirStr = dirStr + timeStr + '/'
if not os.path.exists(dirStr) :
    os.makedirs(dirStr)
outFile = dirStr + 'python_typedef.vh'

oFile = open(outFile, 'w')

pLine = '\n'

pLine = pLine + '\ntypedef enum logic [{0:2}:0] {{ '.format(str(int(math.ceil(math.log(len(descType)-1,2))-1)))
for i in range(1,len(descType)-1) :
  pass
  pLine = pLine + '\n                   PY_WU_INST_DESC_TYPE_{0:<8} = {1:>2}, '.format(descType._fields[i].upper(), str(getattr(descType, descType._fields[i])))
i += 1
pLine = pLine + '\n                   PY_WU_INST_DESC_TYPE_{0:<8} = {1:>2} '.format(descType._fields[i].upper(), str(getattr(descType, descType._fields[i])))
pLine = pLine + '\n                           }} {0} ; '.format('python_desc_type')
pLine = pLine + '\n'
pLine = pLine + '\n'

pLine = pLine + '\ntypedef enum logic [{0:2}:0] {{ '.format(str(int(math.ceil(math.log(len(optionType)-1,2))-1)))
for i in range(1,len(optionType)-1) :
  pass
  pLine = pLine + '\n                   PY_WU_INST_OPT_TYPE_{0:<8} = {1:>2}, '.format(optionType._fields[i].upper(), str(getattr(optionType, optionType._fields[i])))
i += 1
pLine = pLine + '\n                   PY_WU_INST_OPT_TYPE_{0:<8} = {1:>2} '.format(optionType._fields[i].upper(), str(getattr(optionType, optionType._fields[i])))
pLine = pLine + '\n                           }} {0} ; '.format('python_option_type')
pLine = pLine + '\n'
pLine = pLine + '\n'

pLine = pLine + '\ntypedef enum logic [{0:2}:0] {{ '.format(str(int(math.ceil(math.log(len(stOpValues)-1,2))-1)))
for i in range(1,len(stOpValues)-1) :
  pass
  pLine = pLine + '\n                   PY_WU_INST_STOP_CMD_{0:<8} = {1:>2}, '.format(stOpValues._fields[i].upper(), str(getattr(stOpValues, stOpValues._fields[i])))
i += 1
pLine = pLine + '\n                   PY_WU_INST_STOP_CMD_{0:<8} = {1:>2} '.format(stOpValues._fields[i].upper(), str(getattr(stOpValues, stOpValues._fields[i])))
pLine = pLine + '\n                           }} {0} ; '.format('python_stOp_type')
pLine = pLine + '\n'
pLine = pLine + '\n'

pLine = pLine + '\ntypedef enum logic [{0:2}:0] {{ '.format(str(int(math.ceil(math.log(len(simdValues)-1,2))-1)))
for i in range(1,len(simdValues)-1) :
  pass
  pLine = pLine + '\n                   PY_WU_INST_SIMD_CMD_{0:<8} = {1:>2}, '.format(simdValues._fields[i].upper(), str(getattr(simdValues, simdValues._fields[i])))
i += 1
pLine = pLine + '\n                   PY_WU_INST_SIMD_CMD_{0:<8} = {1:>2} '.format(simdValues._fields[i].upper(), str(getattr(simdValues, simdValues._fields[i])))
pLine = pLine + '\n                           }} {0} ; '.format('python_simd_type')
pLine = pLine + '\n'
pLine = pLine + '\n'

pLine = pLine + '\ntypedef enum logic [{0:2}:0] {{ '.format(str(int(math.ceil(math.log(len(tgtValues)-1,2))-1)))
for i in range(1,len(tgtValues)-1) :
  pass
  pLine = pLine + '\n                   PY_WU_INST_TGT_TYPE_{0:<8} = {1:>2}, '.format(tgtValues._fields[i].upper(), str(getattr(tgtValues, tgtValues._fields[i])))
i += 1
pLine = pLine + '\n                   PY_WU_INST_TGT_TYPE_{0:<8} = {1:>2} '.format(tgtValues._fields[i].upper(), str(getattr(tgtValues, tgtValues._fields[i])))
pLine = pLine + '\n                           }} {0} ; '.format('python_target_type')
pLine = pLine + '\n'
pLine = pLine + '\n'

# Source values same as target
pLine = pLine + '\ntypedef enum logic [{0:2}:0] {{ '.format(str(int(math.ceil(math.log(len(tgtValues)-1,2))-1)))
for i in range(1,len(tgtValues)-1) :
  pass
  pLine = pLine + '\n                   PY_WU_INST_SRC_TYPE_{0:<8} = {1:>2}, '.format(tgtValues._fields[i].upper(), str(getattr(tgtValues, tgtValues._fields[i])))
i += 1
pLine = pLine + '\n                   PY_WU_INST_SRC_TYPE_{0:<8} = {1:>2} '.format(tgtValues._fields[i].upper(), str(getattr(tgtValues, tgtValues._fields[i])))
pLine = pLine + '\n                           }} {0} ; '.format('python_source_type')
pLine = pLine + '\n'
pLine = pLine + '\n'

pLine = pLine + '\ntypedef enum logic [{0:2}:0] {{ '.format(str(int(math.ceil(math.log(len(txferValues)-1,2))-1)))
for i in range(1,len(txferValues)-1) :
  pass
  pLine = pLine + '\n                   PY_WU_INST_TXFER_TYPE_{0:<8} = {1:>2}, '.format(txferValues._fields[i].upper(), str(getattr(txferValues, txferValues._fields[i])))
i += 1
pLine = pLine + '\n                   PY_WU_INST_TXFER_TYPE_{0:<8} = {1:>2} '.format(txferValues._fields[i].upper(), str(getattr(txferValues, txferValues._fields[i])))
pLine = pLine + '\n                           }} {0} ; '.format('python_transfer_type')
pLine = pLine + '\n'
pLine = pLine + '\n'

pLine = pLine + '\ntypedef enum logic [{0:2}:0] {{ '.format(str(int(math.ceil(math.log(len(orderValues)-1,2))-1)))
for i in range(1,len(orderValues)-1) :
  pass
  pLine = pLine + '\n                   PY_WU_INST_ORDER_TYPE_{0:<8} = {1:>2}, '.format(orderValues._fields[i].upper(), str(getattr(orderValues, orderValues._fields[i])))
i += 1
pLine = pLine + '\n                   PY_WU_INST_ORDER_TYPE_{0:<8} = {1:>2} '.format(orderValues._fields[i].upper(), str(getattr(orderValues, orderValues._fields[i])))
pLine = pLine + '\n                           }} {0} ; '.format('python_order_type')
pLine = pLine + '\n'
pLine = pLine + '\n'

oFile.write(pLine)
oFile.close()
#------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------


########################################################################################################################
## KERNELS

class Kernel():

    def __init__(self, parentCell, dimensions):
        # K is a numpy array with Kz,Ky,Kx
        self.parentCell = parentCell # parentCell
        self.dimensions = dimensions
        self.memoryLocations = []
        for z in range(dimensions[0]):
          yMemLocns = []
          for y in range(dimensions[1]):
            xMemLocns = []
            for x in range(dimensions[2]):
                newMemLocn = MemoryLocation(None,0,0,0,0) # memory location has a pointer to the actual memory and location within that memory
                xMemLocns.append(newMemLocn)
            yMemLocns.append(xMemLocns)
          self.memoryLocations.append(yMemLocns)

    def __str__(self):
        pLine = ""
        pLine = pLine + 'Kz:{0}:Ky:{1}:Kx:{2}    '.format(self.dimensions[0], self.dimensions[1], self.dimensions[2])
        pLine = pLine + '\nMethods: {0}          '.format(methods(self))
        pLine = pLine + '\nFields: {0}           '.format(fields(self))
        return pLine

    def getLinearAddresses(self):
        # A vector of the memory locations
        addresses = []
        for y in range(self.dimensions[1]):
          for x in range(self.dimensions[2]):
            for z in range(self.dimensions[0]):
                addresses.append(self.memoryLocations[z][y][x])
 
        return addresses
        

    
########################################################################################################################
## MEMORY

class StorageDescriptor():

    #The storage descriptor takes the following form :        "Address"        "Increment order"   "consequtive"    "valid" "jump" "valid" ....    "consequtive"    "invalid"
    # In the case of the Memory write, there may be more than one optionType=storage if the result has to be written to multiple managers
    # Only increment the ptr value if a descriptor is actually used. This keeps a tally of the number of descriptors and is the pointer to the next descriptor added
    ptr = 0

    def __init__(self, address, access, accessOrder, consequtive, jump):
      self.Id          = None          # Id also represents the pointer to this descriptor when used in a WU
      self.address     = address     
      self.access      = access        # read/write - not important other thanshows what required the descriptor, so dont use it in the _-eq__ method
      self.accessOrder = accessOrder 
      self.consequtive = consequtive   # list
      self.jump        = jump          # list

    def __str__(self):
        pLine = ""
        pLine = pLine + 'Id:{0}, Address:{1},  Access:{2},  AccessOrder:{3},  '.format(self.Id, self.address, self.access, self.accessOrder)
        for i in range(len(self.consequtive)) :
          if (i != len(self.consequtive)-1) :
            pLine = pLine + '\nConsequtive:{0},  '.format(self.consequtive[i])
          else :
            pLine = pLine + '\nConsequtive:{0}   '.format(self.consequtive[i])
          if (i != len(self.consequtive)-1) :
            pLine = pLine + 'Jump:{0}'.format(self.jump[i])

        return pLine

    def __eq__(self, other):
        return (self.address == other.address) and (self.consequtive == other.consequtive) and (self.jump == other.jump) and (self.accessOrder == other.accessOrder)  

    def printDesc(self):
        pLine = ""

## DiRAM4 memory is channels/banks/pages
class Page():
    ## memory location is a word within a page
    def __init__(self, sizeOfPage):
        self.Words         = []
        for word in range(sizeOfPage/WORDSIZE):
            newWord = 0 # init
            self.Words.append(newWord)

class Bank():
    ## memory location is a word within a page
    def __init__(self, numOfPages, sizeOfPage):
        self.numOfPages    = numOfPages    
        self.openPage      = []
        self.Pages         = []
        for page in range(numOfPages):
            newPage = Page(sizeOfPage)
            self.Pages.append(newPage)

class Channel():
    ## memory location is a word within a page
    def __init__(self, numOfBanks, numOfPagesPerBank, sizeOfPage):
        self.numOfBanks    = numOfBanks    
        self.Banks         = []
        for bank in range(numOfBanks):
            newBank = Bank(numOfPagesPerBank, sizeOfPage)
            self.Banks.append(newBank)

class Memory():
    ## memory location is a word within a page
    #def __init__(self, numOfChannels, numOfBanksPerChannel, numOfPagesPerBank, sizeOfPage):
    def __init__(self, memoryConfiguration):
        self.configuration           = memoryConfiguration
        self.Channels                = []
        # Use a dictionary, dont create a real memory, its too big
        self.store                   = dict()
        self.bankPageTable           = dict()    # key is bank number, value is open page number
        for bank in range(self.configuration.numOfBanksPerChannel):
            self.bankPageTable[bank] = None
            
        """
        for ch in range(self.configuration.numOfChannels):
            newChannel = Channel(self.configuration.numOfBanksPerChannel, self.configuration.numOfPagesPerBank, self.configuration.sizeOfPage)
            self.Channels.append(newChannel)
        """

    def __str__(self):
        pLine = ""
        pLine = pLine + 'Channels:{0}:Banks/Channel:{1}:Pages/Bank:{2}:Words/Page:{3}:    '.format(self.configuration.numOfChannels, self.configuration.numOfBanksPerChannel, self.configuration.numOfPagesPerBank, self.configuration.sizeOfPage/WORDSIZE)
        pLine = pLine + '\nMethods: {0}                                                   '.format(methods(self))
        pLine = pLine + '\nFields: {0}                                                    '.format(fields(self))
        return pLine

    def addEntry(self, memoryLocation, value, options):

        # test if location being used
        if (options.allowOverWrite == True) :
            if (memoryLocation.channel, memoryLocation.bank, memoryLocation.page, memoryLocation.word) in self.store.keys() :
                raise Exception('{0}:{1}:Writing to already allocated location :{2}'.format(__FILE__(), __LINE__(), memoryLocation)) 
            
        self.store[(memoryLocation.channel, memoryLocation.bank, memoryLocation.page, memoryLocation.word)] = value
         
    def numberOfEntries(self):

        return self.store.__len__()
         

## Kernels are usually stored across muliple pages with each page containing 4 weights of 32 kernels
## e.g. page = {K0(0), K1(0), .... K31(0), K0(1), K1(1), .... K31(1), K0(2), K1(2), .... K31(2), K0(3), K1(3), .... K31(3)}
## A page is read and each work is sent to a lane

## Cell state is an ROI to the next layer and is stored contiguously in a page. 
## The order is feature, coordinate where a cell is a part of a feature map where there are Z feature maps with each having a YxX dimension.
## e.g. page = {cell(0,0,0), cell(1,0,0), .... cell(Z-1,0,0), cell(0,1,0), cell(1,1,0) ... cell(Z-1,1,0), cell(0,2,0), cell(1,2,0), ....
## 

class MemoryLocation():
    ## memory location is a word within a page
    def __init__(self, memory, channel, bank, page, word):
        self.memory  = memory ; # pointer to actual memory
        self.channel = channel; # rest is location in the memory
        self.bank    = bank   ;
        self.page    = page   ;
        self.word    = word   ;

    def __str__(self):
        pLine = ""
        pLine = pLine + 'Channel:{0}, Bank:{1}, Page:{2}, Word:{3}  '.format(self.channel, self.bank, self.page, self.word)
        #pLine = pLine + '\nMethods: {0}                             '.format(methods(self))
        #pLine = pLine + '\nFields: {0}                              '.format(fields(self))
        return pLine

    def convertToMemoryAllocationOption(self):
        
        memoryAllocationOptions = MemoryAllocationOptions( order             = ['c', 'w', 'b', 'p'],
                                                           channel           =  self.channel       , 
                                                           channelIncrement  =  1                  , 
                                                           bank              =  self.bank          , 
                                                           bankIncrement     =  2                  , 
                                                           page              =  self.page          , 
                                                           pageIncrement     =  1                  , 
                                                           word              =  self.word          , 
                                                           wordIncrement     =  1                  , 
                                                           padWordRadix2     = False                )
        return memoryAllocationOptions
        


    def compareMemory(self, memory):
        # 
        cmp = True
        if memory != self.memory:
            cmp = False
        return cmp


    def compareAddress(self, address):
        # if address is numpy, it only contains c,b,p,w
        cmp = True
        if 'numpy' not in str(type(address)):
           raise Exception('{0}:{1}:Address not a numpy array'.format(__FILE__(), __LINE__())) 
        else:
            try:
                if address[0] != self.channel:
                    cmp = False
                if address[1] != self.bank:
                    cmp = False
                if address[2] != self.page:
                    cmp = False
                if address[3] != self.word:
                    cmp = False
            except:
               raise Exception('{0}:{1}:Something wrong with address format'.format(__FILE__(), __LINE__())) 
        return cmp

    def asHexString(self):
      hexAddr = ''
      hexAddr = hexAddr + '{0:>{1}}_' .format(toHexPad(self.channel , int(math.ceil(math.log(self.memory.configuration.numOfChannels       ,16))) ), int(math.ceil(math.log(self.memory.configuration.numOfChannels       ,16))))
      hexAddr = hexAddr + '{0:>{1}}_' .format(toHexPad(self.bank    , int(math.ceil(math.log(self.memory.configuration.numOfBanksPerChannel,16))) ), int(math.ceil(math.log(self.memory.configuration.numOfBanksPerChannel,16))))
      hexAddr = hexAddr + '{0:>{1}}_' .format(toHexPad(self.page    , int(math.ceil(math.log(self.memory.configuration.numOfPagesPerBank   ,16))) ), int(math.ceil(math.log(self.memory.configuration.numOfPagesPerBank   ,16))))
      hexAddr = hexAddr + '{0:>{1}} ' .format(toHexPad(self.word    , int(math.ceil(math.log(self.memory.configuration.sizeOfPage/32       ,16))) ), int(math.ceil(math.log(self.memory.configuration.sizeOfPage/32       ,16))))
      return hexAddr

class MemoryAllocationOptions():

    def __init__(self              ,
                 order             ,
                 channel           , 
                 channelIncrement  , 
                 bank              , 
                 bankIncrement     , 
                 page              , 
                 pageIncrement     , 
                 word              , 
                 wordIncrement     , 
                 padWordRadix2     ):
        self.order                    =  order           
        self.channel                  =  channel  
        self.channelIncrement         =  channelIncrement
        self.bank                     =  bank     
        self.bankIncrement            =  bankIncrement   
        self.page                     =  page     
        self.pageIncrement            =  pageIncrement   
        self.word                     =  word     
        self.wordIncrement            =  wordIncrement   
        self.padWordRadix2            =  padWordRadix2   

    def __str__(self):
        pLine = ""
        pLine = pLine + 'order            :{0} '.format(self.order            )
        pLine = pLine + 'channel          :{0} '.format(self.channel   )
        pLine = pLine + 'channelIncrement :{0} '.format(self.channelIncrement )
        pLine = pLine + 'bank             :{0} '.format(self.bank      )
        pLine = pLine + 'bankIncrement    :{0} '.format(self.bankIncrement    )
        pLine = pLine + 'page             :{0} '.format(self.page      )
        pLine = pLine + 'pageIncrement    :{0} '.format(self.pageIncrement    )
        pLine = pLine + 'word             :{0} '.format(self.word      )
        pLine = pLine + 'wordIncrement    :{0} '.format(self.wordIncrement    )
        pLine = pLine + 'padWordRadix2    :{0} '.format(self.padWordRadix2    )
        #pLine = pLine + "\n"
        #pLine = pLine + '\nMethods: {0}                             '.format(methods(self))
        #pLine = pLine + '\nFields: {0}                              '.format(fields(self))
        return pLine

    def increment(self, memory, numOfFeatures):

              # Increments fields based on configuration of memory

              # When incrementing word, if we are placing the features in radix-2 groups increment word numOfFeatures then
              # move to the next radix-2 word
              if self.padWordRadix2  :
                numberOfAllocatedFeatures = 2**(math.math.ceil(math.log(numOfFeatures,2)))

              numOfItems = self.order.__len__()
              incNext = True               # set if the current field is max and next field needs to be incremented
              incNextIdx = 0              # keep track as an increment ripples thru all the fields
              while (incNext) :

                  # incrementing Channel  
                  if self.order[incNextIdx] == 'c' and incNext :
                      # channel
                      self.channel = self.channel + self.channelIncrement
                      if self.channel == (memory.configuration.numOfChannels):
                          self.channel = 0
                          incNext = True
                          incNextIdx = (incNextIdx+1)%numOfItems
                      else :
                          incNext = False
         
                  # word
                  if self.order[incNextIdx] == 'w' and incNext :
                      self.word = self.word + self.wordIncrement
                      if self.padWordRadix2 :
                        if self.word%numberOfAllocatedFeatures == numOfFeatures:
                            self.word = (int(self.word/numberOfAllocatedFeatures)+1) * numberOfAllocatedFeatures
                      if self.word == (memory.configuration.sizeOfPage/WORDSIZE):
                          self.word = 0
                          incNext = True
                          incNextIdx = (incNextIdx+1)%numOfItems
                      else :
                          incNext = False
                      
                  # page
                  if self.order[incNextIdx] == 'p' and incNext :
                      self.page = self.page + self.pageIncrement
                      if self.page == (memory.configuration.numOfPagesPerBank):
                          self.page = 0
                          incNext = True
                          incNextIdx = (incNextIdx+1)%numOfItems
                      else :
                          incNext = False
                      
                  # bank
                  if self.order[incNextIdx] == 'b' and incNext :
                      self.bank = self.bank + self.bankIncrement
                      if self.bank == (memory.configuration.numOfBanksPerChannel):
                          self.bank = 0
                          incNext = True
                          incNextIdx = (incNextIdx+1)%numOfItems
                      else :
                          incNext = False
  

    def ceilingField(self, memory, numOfFeatures, ceilingField):
        
        if ceilingField == 'channel' :
            while(self.channel != 0):
                self.increment(memory, numOfFeatures)
        elif ceilingField == 'bank' :
            while(self.bank != 0):
                self.increment(memory, numOfFeatures)
        elif ceilingField == 'page' :
            while(self.page != 0):
                self.increment(memory, numOfFeatures)
        elif ceilingField == 'word' :
            while(self.word != 0):
                self.increment(memory, numOfFeatures)


    def compareAddress(self, memLocation):
        # if address is numpy, it only contains c,b,p,w
        cmp = True
        if 'bound method MemoryLocation' not in str(memLocation.__str__) :
           raise Exception('{0}:{1}:memLocation not a memoryLocation object'.format(__FILE__(), __LINE__())) 
        else:
            if memLocation.channel != self.channel:
                cmp = False
            if memLocation.bank != self.bank:
                cmp = False
            if memLocation.page != self.page:
                cmp = False
            if memLocation.word != self.word:
                cmp = False
        return cmp

    def delta(self, memLocation):

        # difference between addresses
        # Return delta and new memoryOption
        cmp = True
        if 'bound method MemoryLocation' not in str(memLocation.__str__) :
           print memLocation
           print memLocation.__str__()
           raise Exception('{0}:{1}:memLocation not a memoryLocation object'.format(__FILE__(), __LINE__())) 
        else:
            delta = 0
            mo = copy_copy(self)
            theSame = mo.compareAddress(memLocation)
            while not theSame :
                mo.increment(memLocation.memory, 0)  # set numOfFeatures = 0 as we dont count assuming radix2 jumps
                theSame = mo.compareAddress(memLocation)
                delta += 1

        return [delta, mo]

########################################################################################################################
########################################################################################################################
## NETWORK


########################################################################################################################
#----------------------------------------------------------------------------------------------------
# CELL

class Cell():

    def __init__(self, parentLayer, cId, kernelDimensions, dummy=False) :
        # keep track of the {x,y} location of PE processing this cell
        self.PE              = []
        self.originalCell    = self                             # so copies of cell can communicate with original so we can keep track of copies
        self.copiedTo        = []                               # pointer to copied cell. we can extract Memory address of copied cell to create memory copy stats
        self.roiFromSrcCells = np.zeros([2,3], dtype=np.int)    # corners of ROI [[Z,Y,X],[Z,Y,X]] extracted from list of source cells
        self.roi             = np.zeros([2,3], dtype=np.int)    # corners of ROI [[Z,Y,X],[Z,Y,X]] generated when running assignPE in the layer
        # Keep ID locally
        self.layerID         = parentLayer.ID
        self.parentLayer     = parentLayer
        self.ID               = cId
        #self.Y               = y
        #self.X               = x
        self.absID           = self.ID[1]*self.parentLayer.X*self.parentLayer.Z + self.ID[2]*self.parentLayer.Z + self.ID[0]  # use absolute ID mainly for sorting
        # Fanin and fanout of this cell
        self.sourceCells     = []
        self.targetCells     = []
        self.sourcePEs       = []
        self.targetPEs       = []
        # where is this copy of the cell stored e.g. original cell stored in main memory, copies stored in manager memory
        self.managerLocation = []                           # where is this copy of the cell? original cell will have this field blank, copied cells
                                                            # point to manager where copy is stored
        self.memoryLocation  = MemoryLocation(None,0,0,0,0) # memory location has a pointer to the actual memory and location within that memory
        self.stOpOperation   = 'MAC'                        # default to MAC
        self.simdOperation   = 'ReLu'                       # default to ReLu
        self.kernel          = Kernel(self, kernelDimensions)

        self.dummy           = dummy

    #----------------------------------------------------------------------------------------------------
    # ROI
    
    def findROI(self):

        # Parse the source cells and find Y,X corners of ROI
        absCellMin = np.inf
        absCellMax = 0

        for sc in self.sourceCells:
          print sc
          absCellNum = sc.ID[1]*sc.parentLayer.X*sc.parentLayer.Z + sc.ID[2]*sc.parentLayer.Z + sc.ID[0]
          if absCellNum < absCellMin :
              absCellMin = absCellNum
              cellMin = sc
          if absCellNum > absCellMax :
              absCellMax = absCellNum
              cellMax = sc
        self.roiFromSrcCells = np.array([[cellMin.ID[0], cellMin.ID[1], cellMin.ID[2]],[cellMax.ID[0], cellMax.ID[1], cellMax.ID[2]]])

        """
        minx = np.inf
        miny = np.inf
        minz = np.inf
        maxx = 0
        maxy = 0
        maxz = 0
        for sc in self.sourceCells:
            if sc.Y < miny:
                miny = sc.Y
            if sc.Y > maxy:
                maxy = sc.Y
            if sc.X < minx:
                minx = sc.X
            if sc.X > maxx:
                maxx = sc.X

        # examine cells at corners of ROI to find min and max Z
        for sc in self.sourceCells:
            if (sc.ID[1] == miny) and (sc.ID[2] == minx):
                if sc.ID[0] < minz:
                    minz = sc.ID[0]
            if (sc.Y == maxy) and (sc.X == maxx):
                if sc.ID[0] > maxz:
                    maxz = sc.ID[0]

        self.roiFromSrcCells = np.array([[minz, miny, minx], [maxz, maxy, maxx]] )
        """

        return self.roiFromSrcCells

    def getROI(self):
        if not self.roiFromSrcCells.any() :
            return self.findROI()
        else:
            return self.roiFromSrcCells

    #----------------------------------------------------------------------------------------------------
    # get

    def getROIcells (self):

        # return a lsit of cell pointers
        # parse the list of source cells and find the cell copied to the PE/manager that processes this cell
        roiCells = []
        for sc in self.sourceCells:
            for ct in sc.copiedTo:
                # Remember, some cells will be copied to multiple managers, so find cell copied to this Manager/PE memory
                # FIXME: assumption is that '==' compares pointers
                # if the ROI cell is in the original input ROI and resides in the managers memory who is processing this cell
                if (ct.absID == sc.absID) and (ct.memoryLocation.memory == self.PE.manager.memory):
                    roiCells.append(ct)
        return roiCells


    def getCopiedToLocation(self):

        # return list of lists containing manager ID and memory channel, bank, page and word
        rv = []
        if self.copiedTo.__len__() > 0 :
            for ct in self.copiedTo :
                rv.append([ct.managerLocation.ID, ct.memoryLocation.channel, ct.memoryLocation.bank, ct.memoryLocation.page, ct.memoryLocation.word])
        else:
            if isinstance(self.managerLocation, list) :
                print '{0}:{1}:WARNING:CopiedTo list empty: Layer {2} cell {{{3:^4}  {4:^4}  {5:^4}}}??'.format(__FILE__(), __LINE__(), self.layerID, self.ID[0], self.ID[1], self.ID[2])
            else:
                print '{0}:{1}:ERROR:CopiedTo list empty, not an original cell: Layer {2} cell {{{3:^4}  {4:^4}  {5:^4}}}??'.format(__FILE__(), __LINE__(), self.layerID, self.ID[0], self.ID[1], self.ID[2])

        return rv

    def getGroupID(self):
        # Find in which manager and group this cell is processed
        # Return point to manager and index of group in cellGroups
        mgr = self.PE.manager
        for i in range(mgr.cellGroups[self.layerID].__len__()):
            if self in mgr.cellGroups[self.layerID][i] :
                grpId = i
        if 'grpId' not in locals() :
            print '{0}:{1}:LEE:ERROR:DEBUG:'.format(__FILE__(), __LINE__()), 'Cell not found in any group '
            raise
        
        return [mgr, grpId]

    #----------------------------------------------------------------------------------------------------
    # print

    def __str__(self):
        pLine = ""
        pLine = pLine + '\nCell:{0},{1},{2}                                               '.format(self.ID[0], self.ID[1], self.ID[2])
        pLine = pLine + '\nLayer:{0}                                                      '.format(self.layerID)
        if isinstance(self.PE, list) :  # check if cell is assigned. original cells do not get assigned to a PE only ones that have been copied
            if self.dummy:
                pLine = pLine + '\nPE{{Y,X}} : Not assigned (dummy)          '
            else:
                pLine = pLine + '\nPE{{Y,X}} : Not assigned (maybe an original cell??)          '
        else :
            pLine = pLine + '\nPE{{Y,X}} : {0},{1}                                            '.format(self.PE.ID[0], self.PE.ID[1])
        pLine = pLine + '\nMemory:{{Ch, Bank, Page, Word}}:{0},{1},{2},{3}                '.format(self.memoryLocation.channel, self.memoryLocation.bank, self.memoryLocation.page, self.memoryLocation.word)
        pLine = pLine + '\nroi || roiFromSrcCells(findROI()) coords : {0} {1} || {2},{3}  '.format(self.roi[0], self.roi[1], self.roiFromSrcCells[0], self.roiFromSrcCells[1] )
        pLine = pLine + '\nMethods: {0}                                                   '.format(methods(self))
        pLine = pLine + '\nFields: {0}                                                    '.format(fields(self))
        return pLine
        

    def printROIcells (self):
        pLine = '\n'
        pLine = pLine + '\nLayer : {0}                                                                    '.format(self.layerID)
        pLine = pLine + '\nCell:{0},{1},{2} Source Cells and addresses                                    '.format(self.ID[0], self.ID[1], self.ID[2])
        pLine = pLine + '\nProcessed by Manager/PE : {0},{1}                                              '.format(self.PE.ID[0], self.PE.ID[1])
        pLine = pLine + '\nResult copied to: Manager Channel  Bank  Page  Word                            '
        for ct in self.copiedTo :
            pLine = pLine + '\n                  {0:^3},{1:^3} {2:^7}   {3:^3}   {4:^3}   {5:^3}          '.format(ct.managerLocation.ID[0], ct.managerLocation.ID[1], ct.memoryLocation.channel, ct.memoryLocation.bank, ct.memoryLocation.page, ct.memoryLocation.word)
        pLine = pLine + '\n                                                                               '
        pLine = pLine + '\n source cell       ROI Local memory                                            '.format(self.PE.ID[0], self.PE.ID[1])
        pLine = pLine + '\n Z   Y   X   | Channel  Bank  Page  Word                                       '
        pLine = pLine + '\n--------------------------------------------------------------                 '
        for sc in self.sourceCells:
            for ct in sc.copiedTo:
                # Remember, some cells will be copied to multiple managers, so find cell copied to this Manager/PE memory
                # FIXME: assumption is that '==' compares pointers
                # if the ROI cell is in the original input ROI and resides in the managers memory who is processing this cell
                if (ct.absID == sc.absID) and (ct.memoryLocation.memory == self.PE.manager.memory):
                    if ct.dummy  :
                        pLine = pLine + '\n{0:^3} {1:^3} {2:^3} {7:1}  | {3:^7}   {4:^4}  {5:^4}  {6:^4}  '.format(ct.ID[0], ct.ID[1], ct.ID[2], ct.memoryLocation.channel, ct.memoryLocation.bank, ct.memoryLocation.page, ct.memoryLocation.word,'*')
                    else :
                        pLine = pLine + '\n{0:^3} {1:^3} {2:^3} {7:1}  | {3:^7}   {4:^4}  {5:^4}  {6:^4}  '.format(ct.ID[0], ct.ID[1], ct.ID[2], ct.memoryLocation.channel, ct.memoryLocation.bank, ct.memoryLocation.page, ct.memoryLocation.word,' ')
        pLine = pLine + '\n-------------------------------------------------------'
        return pLine

    def createROIcellsFile(self):

        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'manager_{0}_{1}/'.format(self.PE.ID[0], self.PE.ID[1])
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        outFile = dirStr + 'manager_{0}_{1}_layer{2}_cell_{3}_{4}_{5}_ROIcells.txt'.format(self.PE.ID[0], self.PE.ID[1], self.layerID, self.ID[1], self.ID[2], self.ID[0])

        oFile = open(outFile, 'w')

        pLine = self.printROIcells()
        
        oFile.write(pLine)
        oFile.close()
            

    def printCopiedToMemory(self):

        pLine = '\n'
        pLine = pLine + '\nLayer : {0}                                                      '.format(self.layerID)
        pLine = pLine + '\nCell:{0},{1},{2} Copied To Location(s)                           '.format(self.ID[0], self.ID[1], self.ID[2])
        pLine = pLine + '\n                                                                 '
        pLine = pLine + '\n      Destination Local memory                                   '
        pLine = pLine + '\n Manager : Channel  Bank  Page  Word                             '
        pLine = pLine + '\n------------------------------------------------                 '
        
        if self.copiedTo.__len__() > 0 :
            for ct in self.copiedTo :
                pLine = pLine + '\n {0:>3},{1:>3} : {2:^7}   {3:^4}  {4:^4}  {5:^4}   '.format(ct.managerLocation.ID[0], ct.managerLocation.ID[1], ct.memoryLocation.channel, ct.memoryLocation.bank, ct.memoryLocation.page, ct.memoryLocation.word)
        else:
            # if this is the last layer, the copiedTo field will be empty because there isnt an ROI from the next layer
            if (self.layerID < self.parentLayer.parentNetwork.numberOfLayers-1) :
                if isinstance(self.managerLocation, list) :
                    print '{0}:{1}:WARNING:CopiedTo list empty: Layer {2} cell {{{3:^4}  {4:^4}  {5:^4}}}??'.format(__FILE__(), __LINE__(), self.layerID, self.ID[0], self.ID[1], self.ID[2])
                else:
                    print '{0}:{1}:ERROR:CopiedTo list empty, not an original cell: Layer {2} cell {{{3:^4}  {4:^4}  {5:^4}}}??'.format(__FILE__(), __LINE__(), self.layerID, self.ID[0], self.ID[1], self.ID[2])
        pLine = pLine + '\n-------------------------------------------------------'
        return pLine
            

    def printKernelMemory(self):
        pLine = '\n'
        pLine = pLine + '\nLayer : {0}                                                                    '.format(self.layerID)
        pLine = pLine + '\nCell:{0},{1},{2} Kernel addresses                                              '.format(self.ID[0], self.ID[1], self.ID[2])
        pLine = pLine + '\n                                                                               '
        pLine = pLine + '\n    Kernel Local memory                                          '.format(self.PE.ID[0], self.PE.ID[1])
        pLine = pLine + '\n Channel  Bank  Page  Word                                       '
        pLine = pLine + '\n------------------------------------------------                 '
        
        for Ky in range(self.kernel.dimensions[1]) :
            for Kx in range(self.kernel.dimensions[2]) :
                for Kz in range(self.kernel.dimensions[0]) :
                    pLine = pLine + '\n{0:^7}   {1:^4}  {2:^4}  {3:^4}   '.format(self.kernel.memoryLocations[Kz][Ky][Kx].channel, self.kernel.memoryLocations[Kz][Ky][Kx].bank, self.kernel.memoryLocations[Kz][Ky][Kx].page, self.kernel.memoryLocations[Kz][Ky][Kx].word)
        pLine = pLine + '\n-------------------------------------------------------'
        return pLine

    def printAllMemory(self):
        roiMemory    = self.printROIcells().split('\n')
        kernelMemory = self.printKernelMemory().split('\n')
        kernelShort  = []
        displayStr     = [[],[]]

        # remove just the data
        startAdding = False
        for str in roiMemory :
            if '--' in str:
                startAdding = True
            if startAdding :
              if not '--' in str:
                displayStr[0].append(str)

        startAdding = False
        for str in kernelMemory :
            if '--' in str:
                startAdding = True
            if startAdding :
              if not '--' in str:
                displayStr[1].append(str)

        pLine = '\n'
        pLine = pLine + '\n source cell       ROI Local memory              Kernel Memory                 '.format(self.PE.ID[0], self.PE.ID[1])
        pLine = pLine + '\n Z   Y   X   | Channel  Bank  Page  Word     | Channel  Bank  Page  Word       '
        pLine = pLine + '\n-------------------------------------------------------------------------      '
        for idx in range(displayStr[0].__len__()):
          pLine = pLine + '\n{0} | {1}'.format(displayStr[0][idx], displayStr[1][idx])
        return pLine

    def createAllMemoryFile(self):

        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'manager_{0}_{1}/'.format(self.PE.ID[0], self.PE.ID[1])
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        outFile = dirStr + 'manager_{0}_{1}_layer{2}_cell_{3}_{4}_{5}_AllProcessedMemory.txt'.format(self.PE.ID[0], self.PE.ID[1], self.layerID, self.ID[1], self.ID[2], self.ID[0])

        oFile = open(outFile, 'w')

        pLine = self.printAllMemory()
        
        oFile.write(pLine)
        oFile.close()
    #----------------------------------------------------------------------------------------------------


########################################################################################################################
#----------------------------------------------------------------------------------------------------
# LAYER

class Layer():

    def __init__(self, network, layerID, type, X, Y, Z, Kx=0, Ky=0, Kz=0, stride=0):
        self.parentNetwork = network
        self.ID = layerID
        self.type = type
        self.assignType = ''
        #self.assignType = 'linearX'

        # Dimensions of layer
        # Keep the actual dimensions in origZ, origY, origX and put the padded dimensions in Z,Y,X
     
        self.origX = X
        self.origY = Y
        self.origZ = Z
        # orig.range contains the index of real cells as we do not want to process dummy padded cells
        self.origXrange = range(X)
        self.origYrange = range(Y)
        self.origZrange = range(Z)
        self.X     = X
        self.Y     = Y
        self.Z     = Z


        # Keep track of how much we have padded
        self.padding = np.array([0,0,0])

        # Kernels dimensions of layer
        self.Kx = Kx
        self.Ky = Ky
        self.Kz = Kz
        self.stride = stride

        # Determine of the input image needs padding
        kernelOffsets = self.calculateKernelOffset()
        # we might need to pad input array
        pad = np.array([0,0,0])
        if kernelOffsets[1] < 0:
          print '{0}:{1}:INFO:Layer {2}:Padding each edge of previous layers Y-dimension of input with {3} cells'.format(__FILE__(), __LINE__(), self.ID, abs(kernelOffsets[1]))
          pad[1] = abs(kernelOffsets[1])
        if kernelOffsets[2] < 0:
          print '{0}:{1}:INFO:Layer {2}:Padding each edge of previous layers X-dimension of input with {3} cells'.format(__FILE__(), __LINE__(), self.ID, abs(kernelOffsets[2]))
          pad[2] = abs(kernelOffsets[2])
        if max(pad) > 0 :
            self.parentNetwork.Layers[self.ID-1].padArray(pad)

        # create a 3-D grid of cells ( index is {z,y,x} )
        # This may get padded based on the next layers kernel and stride
        self.cells = []
        for z in range(self.Z):
          yCells = []
          for y in range(self.Y):
            xCells = []
            for x in range(self.X):
                newCell = Cell(self, cId=np.array([z, y, x]), kernelDimensions=np.array([Kz, Ky, Kx]))
                xCells.append(newCell)
            yCells.append(xCells)
          self.cells.append(yCells)

    def padArray(self, pad):

        # The next layer may add pad to this layers input
        # we will pad both edges with the same pad value
        self.padding = pad
        xPad = pad[2]
        yPad = pad[1]
        zPad = pad[0]
        self.Z = self.origZ + 2*zPad
        self.Y = self.origY + 2*yPad
        self.X = self.origX + 2*xPad
        # orig.range contains the index of real cells as we do not want to process dummy padded cells, so ignore padded dummycells
        self.origXrange = range(self.padding[2],self.X-self.padding[2])
        self.origYrange = range(self.padding[1],self.Y-self.padding[1])
        self.origZrange = range(self.padding[0],self.Z-self.padding[0])

        self.cells = []
        for z in range(self.Z):
          yCells = []
          for y in range(self.Y):
            xCells = []
            for x in range(self.X):
                if x < xPad or y < yPad or z < zPad:
                    newCell = Cell(self, cId=np.array([z, y, x]), kernelDimensions=np.array([self.Kz, self.Ky, self.Kx]), dummy=True)
                elif x >= (self.X - xPad) or y >= (self.Y - yPad) or z >= (self.Z - zPad) :
                    newCell = Cell(self, cId=np.array([z, y, x]), kernelDimensions=np.array([self.Kz, self.Ky, self.Kx]), dummy=True)
                else :
                    newCell = Cell(self, cId=np.array([z, y, x]), kernelDimensions=np.array([self.Kz, self.Ky, self.Kx]))
                xCells.append(newCell)
            yCells.append(xCells)
          self.cells.append(yCells)


    #----------------------------------------------------------------------------------------------------
    # print

    def __str__(self):
        pLine = ""
        pLine = pLine + '\nLayer {0}                           '.format(self.ID)
        pLine = pLine + '\nPadded {{Z,Y,X}} : {0},{1},{2}      '.format(self.Z, self.Y, self.X)
        pLine = pLine + '\nOriginal {{Z,Y,X}} : {0},{1},{2}    '.format(self.origZ, self.origY, self.origX)
        pLine = pLine + '\n{{Kz,Ky,Kx}} : {0},{1},{2}          '.format(self.Kz, self.Ky, self.Kx)
        pLine = pLine + '\nMethods: {0}                        '.format(methods(self))
        pLine = pLine + '\nFields: {0}                         '.format(fields(self))
        return pLine
        


    def getPreviousLayer(self):
        return self.parentNetwork.getLayer(self.ID-1)

    #----------------------------------------------------------------------------------------------------
    # PE assignment

    def assignPEs(self, peX, peY, assignType): # assign an array of X by Y PE's
        # e.g. each PE will be assigned a set of X-Y-Z feature maps
        # for example, with a 55x55x256 array of feature maps, PE{0,0} may be assigned a 6x6x256 array of feature maps
        # where PE{0,1} may be assigned a 7x7x256 array of feature maps

        # Type:
        # 'linearAll' : total number of cells are spread across 64 PE's
        # 'linearX'   : all cells in a row (e.g. X*f) are allocated across X and evenly assigned to PE's in X dimension. rows are assigned to PE's in Y dimension

        self.assignType = assignType
        # Create an array of lists with each PE assigned a list
        # This list will contain index of all cells assigned to the PE

        # Create an array of PE values which hold number of cells
        if (self.assignType == 'linearX') :
            # LinearX means [0] holds the number of z,x cells and [1] holds the number of rows
            self.peArrayXYcellCount = []
            for y in range(peY):
              eX = []
              for x in range(peX):
                  eX.append(np.zeros(2, dtype=np.int))
              self.peArrayXYcellCount.append(eX)
        elif (self.assignType == 'linearAll') :
            # LinearAll means [0] holds the number of z,y,x cells
            self.peArrayXYcellCount = []
            for y in range(peY):
              eX = []
              for x in range(peX):
                  eX.append(np.zeros(1, dtype=np.int))
              self.peArrayXYcellCount.append(eX)
 
        if (self.assignType == 'linearX') :
            # 
            #                                                  X*Z
            #     |------------------------------------------------------------------------------------------|
            #           nx         
            #     |-------------|-------------|-------------|-------------|-------------|-------------|
            #                                                                                          mx~1-7
            #                                                                                         |------|
 
            # we add a column to m PE's so k PE's will have 'n+1' columns with the remainder PE's having 'n' columns
 
            # We know the remainder of X/peX is less than peX, so between 0 and 7
            # So now keep iterating by deleting n+1 initially from X to create Xp, we will reach a point where Xp is an integer multiple of l and 8-l multiples of n+1

            # Only process the actual cells not the dummy cells used to pad
            
            nx=int(np.floor(self.origX*self.origZ/peX)) # n is the integer part meaning peX-m PE's will be assigned n columns and m PE's will be assigned n+1 cols
            mx=int(np.remainder(self.origX*self.origZ, peX))
            lx=peX-mx         # lx PE's are assigned nx cells, peX-lx are assigned nx+1 cells
          
            for y in range(peY):
                for x in range(peX):
                    if x<lx:     # if remainder was 0, all PE's will be assigned nx cells
                        self.peArrayXYcellCount[y][x][1] = int(nx)
                        #print 'DEBUG1 ', y, x
                    else:              
                        #print 'DEBUG2 ', y, x
                        self.peArrayXYcellCount[y][x][1] = int(nx+1)
 
 
 
            ny=int(np.floor(self.origY/peY)) # n is the integer part meaning peX-1 PE's will be assigned n columns and the peXth PE would be assigned X-(peX-1)*n cols
            my=int(np.remainder(self.origY, peY))
            ly=peY-my
          
            for y in range(peY):
                for x in range(peX):
                    if y<my:            
                        self.peArrayXYcellCount[y][x][0] = int(ny+1)
                    else:              
                        self.peArrayXYcellCount[y][x][0] = int(ny)

        elif (self.assignType == 'linearAll') :
            # 
            #                                                  X*Y*Z
            #     |-----------------------------------------------------------------------------------------|
            #            n         
            #     |-------------|-------------|-------------|-------------|-------------|-------------|
            #                                                                                          m~1-63
            #                                                                                         |-----|
            n=np.floor(self.origY*self.origX*self.origZ/(peX*peY)) # n is the integer part meaning pe^2-m PE's will be assigned n columns and m PE's will be assigned n+1 cells
            m=np.remainder(self.origY*self.origX*self.origZ, (peX*peY))
            l=peY*peX-m         # l PE's are assigned n cells, pe**2-l are assigned n+1 cells
          
            for y in range(peY):
                for x in range(peX):
                    if (y*peX+x)<l:     # if remainder was 0, all PE's will be assigned nx cells
                        self.peArrayXYcellCount[y][x][0] = int(n)
                        #print 'DEBUG1 ', y, x
                    else:              
                        #print 'DEBUG2 ', y, x
                        self.peArrayXYcellCount[y][x][0] = int(n+1)
 
 
 
        # Let each cell in the layer know which PE it is assigned to
        # and let each PE in the PE array know its processing this cell
        # print 'LEE:DEBUG:assign PE:', peY, peX

        # Cycle thru all PE's

        """
        # FIXME : Calculate total number of cells by counting per PE assignments
        foo = 0
        for y in range(peY):
            for x in range(peX):
                  #print 'LEE:DEBUG:line 486', self.ID,':', y, x, self.peArrayXYcellCount[y][x][0]
                  if (self.assignType == 'linearX') :
                      foo += self.peArrayXYcellCount[y][x][0]*self.peArrayXYcellCount[y][x][1]
                  else :
                      foo += self.peArrayXYcellCount[y][x][0]
                  print foo
        """

        
        if (self.assignType == 'linearX') :
            yOffset = 0 # keep track of the row cell number and construct z,y,x location based on number of features and cells per PE
            for yPe in range(peY):
                xOffset = 0  # keep track of the column cell number and construct z,y,x location based on number of features and cells per PE
                for xPe in range(peX):
          
                        # Cycle thru cells assigned to each PE
                        # Here yCell is row and xCell is the cell from a list of X*Z cells
                        for yCell in range(self.padding[1], int(self.peArrayXYcellCount[yPe][xPe][0]) ):
                            for xCell in range(self.padding[2]*self.Z, int(self.peArrayXYcellCount[yPe][xPe][1]) ):
                                # divide by number of features to find column x
                                f=np.remainder(xOffset+xCell,self.Z)
                                x=int((xOffset+xCell)/self.Z)
                                #y=int((yOffset+yCell)/self.Z)
                                y=yCell+yOffset
                                # index is z,y,x
                                try: # FIXME
                                    self.cells[f][y][x].PE = self.parentNetwork.peArray.pe[yPe][xPe]
                                    self.parentNetwork.peArray.addCell(np.array([yPe,xPe]), self.ID, np.array([f,y,x]))
                                    #print 'LEE:DEBUG:AddCell', self.ID,':', f ,y ,x
                                    #print 'LEE:DEBUG:', self.rID,':', yCell, xCell, ':', f ,y ,x, ':', xOffset, yOffset, ':', xPe, yPe, ':', self.peArrayXYcellCount[yPe][xPe], ':', self.origZ, self.origY, self.origX
                                except:
                                    print '{0}:{1}:LEE:ERROR:DEBUG:'.format(__FILE__(), __LINE__()), self.ID,':', yCell, xCell, f ,y ,x, xOffset, yOffset, xPe, yPe, self.peArrayXYcellCount[yPe][xPe], self.origZ, self.origY, self.origX
                                    raise
                        xOffset += int(self.peArrayXYcellCount[yPe][xPe][1])
          
                yOffset += int(self.peArrayXYcellCount[yPe][xPe][0])

        elif (self.assignType == 'linearAll') :
            # Start by offsetting past the dummy padding cells
            #xOffset = self.padding[2]*self.Z # keep track of the row and col cell number and construct z,y,x location based on number of features and cells per PE
            #yOffset = self.padding[1]*self.X*self.Z 
            offset = self.padding[1]*self.X*self.Z  + self.padding[2]*self.Z
            yPeCurr = 0
            for pe in range(peY*peX):
                xPe = np.remainder(pe,peX)
                yPe = pe/peX

                # keep track of the column cell number and construct z,y,x location based on number of features and cells per PE
                if yPe != yPeCurr :
                    #yOffset += xOffset
                    # When we change rows, skip over the right and left padding dummy cells
                    #xOffset = (self.padding[2]*self.Z)*2
                    yPeCurr = yPe
                # We are processing absolute cells yOffset+xOffset+cell
                # Remember not to include dummy padded cells
                for cell in range(int(self.peArrayXYcellCount[yPe][xPe][0])):
                    #ca = (cell + xOffset + yOffset)
                    #print ca
                    # Increment past dummy cells
                    dummyCell = True
                    while dummyCell :
                        ca = (cell + offset)
                        f = np.remainder(ca, self.Z)
                        fa = ca/self.Z
                        x = np.remainder(fa, self.X)
                        y = fa/self.X
                        # if cell is padding, jump past it
                        if (y not in self.origYrange) or (x not in self.origXrange) :
                            offset += 1
                        else :
                            #print y,x,f
                            dummyCell = False

                    try: # FIXME
                        self.cells[f][y][x].PE = self.parentNetwork.peArray.pe[yPe][xPe]
                        self.parentNetwork.peArray.addCell(np.array([yPe,xPe]), self.ID, np.array([f,y,x]))
                    except:
                        print '{0}:{1}:LEE:ERROR:DEBUG:'.format(__FILE__(), __LINE__()), 'layer ', self.ID,':', cell, pe, ':', f ,y ,x, ':', xOffset, ':', xPe, yPe, ':', self.peArrayXYcellCount[yPe][xPe], ':', self.Z, self.Y, self.X
                        raise
                #xOffset += int(self.peArrayXYcellCount[yPe][xPe][0])
                offset += int(self.peArrayXYcellCount[yPe][xPe][0])

        # FIXME
        # Check all cells have been assigned a PE
        for y in self.origYrange :
            for x in self.origXrange :
                for f in self.origZrange :
                    if isinstance(self.cells[f][y][x].PE, list): # FIXME
                        print '{0}:{1}:LEE:ERROR:DEBUG:'.format(__FILE__(), __LINE__()), self.ID,':', f ,y ,x
                        raise

        # sort the cellsProcessed 
        for yPe in range(peY):
            for xPe in range(peX):
                tmp = sorted(self.parentNetwork.peArray.pe[yPe][xPe].cellsProcessed[self.ID], key=operator.attrgetter('absID'))
                self.parentNetwork.peArray.pe[yPe][xPe].cellsProcessed[self.ID] = tmp
                        
    #----------------------------------------------------------------------------------------------------
      
    def generateConnections(self):
        # For each cell in this layer, identify the cells from the previous layer that feed this cell and add this cell's PE
        # to the target list

        # Now this layer may be padded to accomodate the next layer, so only loop thru original layer cells. The extras are marked as dummy.
        # The padded dummy cells only exist as an ROI input (e.g. activations are not calculated)
        for y in self.origYrange :
            print 'Updating Layer {0} connections'.format(self.ID) + ' for features in row :{0}'.format(y)
            for x in self.origXrange :
                #print 'Updating Layer {0} connections'.format(self.ID) + ' for features at row :{0},{1}'.format(y,x)
                for f in self.origZrange :

                    #print self.stride, self.Ky, self.Kx, self.kernelTopOffset, self.kernelLeftOffset
             
                    # Identify the row and columns of the source cells from layer n-1
                    # We are taking the kernel and moving it across the input
                    # Need to account for the 1st kernel and last kernel being outside the edge of the input
                    # FIXME: we now pad so there is no kernel offset
                    #tmpY = range(max(0, self.kernelTopOffset+y*self.stride), min(self.parentNetwork.Layers[self.ID-1].Y, self.kernelTopOffset+y*self.stride+self.Ky))
                    #tmpX = range(max(0, self.kernelLeftOffset+x*self.stride), min(self.parentNetwork.Layers[self.ID-1].X, self.kernelLeftOffset+x*self.stride+self.Kx))
                    tmpY = range((y-self.padding[1])*self.stride, (y-self.padding[1])*self.stride+self.Ky)
                    tmpX = range((x-self.padding[2])*self.stride, (x-self.padding[2])*self.stride+self.Kx)
             
                    # tmpy,tmpX are the X,Y ROI of the cell (f,y,x)
                    # FIXME: this ROI should match the the findROI method which uses the list of sourceCells to construct the ROI
                    # create corners of ROI
                    self.cells[f][y][x].roi[0] = [                                            0, min(tmpY), min(tmpX)]
                    self.cells[f][y][x].roi[1] = [self.parentNetwork.Layers[self.ID-1].Z-1, max(tmpY), max(tmpX)]

                    # Cycle thru the source cells and 
                    #   a) add this cells PE to the list of target PE's of the source cell
                    #   b) add this cells ID to the list of target cell's of the source cell
                    #   c) Add the source cells PE to this cells list of source PE's
                    #   d) Add the source cells to this cells list of source cells
                    tgtPE   = self.cells[f][y][x].PE
                    tgtCell = self.cells[f][y][x]
                    for ySrcCell in tmpY:
                        for xSrcCell in tmpX:
                            for fSrcCell in range(self.parentNetwork.Layers[self.ID-1].Z) :
                                srcCell = self.parentNetwork.Layers[self.ID-1].cells[fSrcCell][ySrcCell][xSrcCell]
                                try:
                                    srcPE   = srcCell.PE
                                except:
                                    print '{0}:{1}:LEE:ERROR:DEBUG:'.format(__FILE__(), __LINE__()), 'Layer {0}: {1},{2},{3}: {4},{5},{6}: {7},{8}'.format(self.ID, f, y, x, fSrcCell, ySrcCell, xSrcCell, tmpY, tmpX)
                                    pass
                                    raise

                                # a) Update source cells target PE list
                                self.parentNetwork.Layers[self.ID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetPEs.append(self.cells[f][y][x].PE)
             
                                # b) Update source cells target cell list
                                self.parentNetwork.Layers[self.ID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetCells.append(tgtCell)
                             
                                #srcCell = tuple([fSrcCell, ySrcCell, xSrcCell])
                             
                                # c) Update this cells source PE list
                                if isinstance(srcPE, list): # FIXME
                                    # must be a dummy pad cell, but check to be sure
                                    if not srcCell.dummy :
                                        print '{0}:{1}:LEE:ERROR:DEBUG:'.format(__FILE__(), __LINE__()), 'Layer {0}: {1},{2},{3}: {4},{5},{6}: {7},{8}'.format(self.ID, f, y, x, fSrcCell, ySrcCell, xSrcCell, tmpY, tmpX)
                                        raise
                                else :
                                    self.cells[f][y][x].sourcePEs.append(srcPE)
             
                                # d) Update this cells source cell list
                                self.cells[f][y][x].sourceCells.append(srcCell)
                     
                #print 'Completed layer {0} connections for features at : {1},{2}'.format(self.ID, y, x)

        ##----------------------------------------------------------------------------------------------------
        ## remove duplicates
        print 'Removing duplicates in source and target cell lists of Layers {0} and {1} respectively'.format(self.ID, self.ID-1)

        for y in range(self.Y):
            for x in range(self.X):
                for f in range(self.Z):
                    try: # FIXME
                        tmpSrcPE = set(self.cells[f][y][x].sourcePEs)
                        self.cells[f][y][x].sourcePEs = list(tmpSrcPE)
                        tmpSrcCell = set(self.cells[f][y][x].sourceCells)
                        self.cells[f][y][x].sourceCells = list(tmpSrcCell)
                    except:
                        print __FILE__ + lineNo.__repr__() + 'ERROR: {0}, {1}, {2}'.format(f,y,x)
                        raise

        
        for y in range(self.parentNetwork.Layers[self.ID-1].Y):
            for x in range(self.parentNetwork.Layers[self.ID-1].X):
                for f in range(self.parentNetwork.Layers[self.ID-1].Z):
                    if self.parentNetwork.Layers[self.ID-1].cells[f][y][x].targetPEs.__len__() > 1: # if only for DEBUG
                        tmpTgtPEs = set(self.parentNetwork.Layers[self.ID-1].cells[f][y][x].targetPEs)
                        self.parentNetwork.Layers[self.ID-1].cells[f][y][x].targetPEs = list(tmpTgtPEs)
                        #print '{0},{1},{2}:targetPe.len() = '.format(f, y, x) + str(self.parentNetwork.Layers[self.ID-1].cells[f][y][x].targetPEs.__len__())
                    tmpTgtCells = set(self.parentNetwork.Layers[self.ID-1].cells[f][y][x].targetCells)
                    self.parentNetwork.Layers[self.ID-1].cells[f][y][x].targetCells = list(tmpTgtCells)

        ##----------------------------------------------------------------------------------------------------
        ## Sort
        print 'Sort source cell and target cells'
        for y in range(self.Y):
            for x in range(self.X):
                for f in range(self.Z):
                    tmpSc = sorted(self.cells[f][y][x].sourceCells, key=operator.attrgetter('absID'))
                    self.cells[f][y][x].sourceCells = tmpSc
        for y in range(self.parentNetwork.Layers[self.ID-1].Y):
            for x in range(self.parentNetwork.Layers[self.ID-1].X):
                for f in range(self.parentNetwork.Layers[self.ID-1].Z):
                    tmpTc = sorted(self.parentNetwork.Layers[self.ID-1].cells[f][y][x].targetCells, key=operator.attrgetter('absID'))
                    self.parentNetwork.Layers[self.ID-1].cells[f][y][x].targetCells = tmpTc

        print 'Connections complete from Layer {0} to {1}'.format(self.ID-1, self.ID)
                        

    #----------------------------------------------------------------------------------------------------
    """
    def groupCells(self):

        # Form groups with the same ROI.
        # The groups will be used to allocate kernel locations
        # start with cell 0 and form a group
        # When the group is full, set the next cell as firstCell and create a new group
        # Stop when we reach the last cell in the layer
        finalCellAbsId = self.Z*self.Y*self.X
        self.cellGroups = []


        # we use cell 0,0,0 as first cell so start looking at 1,0,0
        absCellId = 0
        while absCellId < finalCellAbsId :
            # Create the coords of the cell
            y = absCellId/(self.X*self.Z)
            yRem = absCellId%(self.X*self.Z)
            x = yRem/self.Z
            z = yRem%self.Z
            firstCell = self.cells[z][y][x]
            group = []
            group.append(firstCell)
            absCellId += 1
            groupCount = 1 # already first cell is on group
            groupComplete = False
            while not groupComplete:
                # Create the coords of the cell
                y = absCellId/(self.X*self.Z)
                yRem = absCellId%(self.X*self.Z)
                x = yRem/self.Z
                z = yRem%self.Z
                c = self.cells[z][y][x]
                # test if cell has same ROI as current group
                if (firstCell.sourceCells == c.sourceCells):
                    group.append(c)
                    groupCount += 1
                else:
                    # different ROI
                    groupComplete = True
                    absCellId -= 1  # we have to use this cell as the first cell of the next group

                if groupCount == NUMOFEXECLANES:
                    groupComplete = True
                if absCellId == finalCellAbsId-1:
                    groupComplete = True

                absCellId += 1

            self.cellGroups.append(group)
    """
                        
                        

    #----------------------------------------------------------------------------------------------------
    def calculateKernelOffset(self):
        # Determine Kernel overlap at edge of input array
        if self.ID != 0:
            self.kernelXOffset = int(((self.parentNetwork.Layers[self.ID-1].X) - ((self.X-1)*self.stride+self.Kx))/2)
            self.kernelYOffset  = int(((self.parentNetwork.Layers[self.ID-1].Y) - ((self.Y-1)*self.stride+self.Ky))/2)
        else:
            self.kernelXOffset = 0
            self.kernelYOffset  = 0

        self.kernelZOffset  = 0  # FIXME : assume no Z padding

        return self.kernelZOffset, self.kernelYOffset,  self.kernelXOffset

    def printKernelOffset(self):
        return 'Layer ', self.ID, ' left Kernel offset is ', int(self.kernelXOffset),  ', top Kernel offset is ', int(self.kernelYOffset) 

    #----------------------------------------------------------------------------------------------------
    def getNumberOfMultiplies(self):
            return self.getNumberOfKernelParameters() * self.getNumberOfCells()

    #----------------------------------------------------------------------------------------------------
    def getNumberOfAdditions(self):
            return (self.getNumberOfMultiplies() -1) 

    #----------------------------------------------------------------------------------------------------
    def getNumberOfParameters(self):
            return self.getNumberOfKernelParameters() * self.Z

    #----------------------------------------------------------------------------------------------------
    def getNumberOfKernelParameters(self):
            return self.Kx*self.Ky*self.Kz

    #----------------------------------------------------------------------------------------------------
    def getNumberOfCells(self):
            return self.X*self.Y*self.Z

    ##----------------------------------------------------------------------------------------------------
    ## Display Routines along with gets for what is displayed


    #----------------------------------------------------------------------------------------------------
    def getTargetPECounts(self):
        # return a grid of PE values the size of the input array Y,X
        zGrid, yGrid, xGrid = np.mgrid[slice(0, self.Z),
                                       slice(0, self.Y),
                                       slice(0, self.X)]
        numOfPEs = np.zeros_like(xGrid, dtype=np.int)

        for y in range(self.Y):
            for x in range(self.X):
                for z in range(self.Z):
                    numOfPEs[z][y][x] = self.cells[z][y][x].targetPEs.__len__()
        return numOfPEs

    def getTargetPECountsRegion(self, coords):
        yGrid, xGrid = np.mgrid[slice(coords[0][0], coords[1][0]), slice(coords[0][1], coords[1][1])]
        numOfPEs = np.zeros_like(xGrid, dtype=np.int)

        pLine = ''
        for y in range(coords[0][0], coords[1][0]):
            for x in range(coords[0][1], coords[1][1]):
                pLine = pLine + '{0},'.format(self.cells[0][y][x].targetPEs.__len__())
                numOfPEs[y-coords[0][0]][x-coords[0][1]] = self.cells[0][y][x].targetPEs.__len__()
            pLine = pLine + '\n'
        return numOfPEs


    def displayTargetPECountsRegion(self, coords):
        yGrid, xGrid = np.mgrid[slice(coords[0][0], coords[1][0]), slice(coords[0][1], coords[1][1])]
        numOfPEs = np.zeros_like(xGrid, dtype=np.int)

        pLine = ''
        for y in range(coords[0][0], coords[1][0]):
            for x in range(coords[0][1], coords[1][1]):
                pLine = pLine + '{0},'.format(self.cells[0][y][x].targetPEs.__len__())
                numOfPEs[y-coords[0][0]][x-coords[0][1]] = self.cells[0][y][x].targetPEs.__len__()
            pLine = pLine + '\n'
        #print pLine

        cmap = plt.cm.get_cmap('RdYlBu')
        #cmap = plt.get_cmap('PiYG')
        levels = np.array([0,1,2,3,4,5])
        norm = BoundaryNorm(levels, ncolors=cmap.N, clip=True)

        # scale point based on number of elements
        # FIXME: this was empirically done
        numPts = 0
        for e in numOfPEs:
          numPts += e.__len__()
        s =  10.0*(math.log((30000.0/numPts),10))  # s=10 seemed right when there were 3000 point (e.g. 55x55 array)
        if s < 0.01:
            s = 0.01
        else:
            s = numOfPEs * s
        sc = plt.scatter(xGrid, yGrid, c=numOfPEs, s=s, vmin=0, vmax=6, cmap=cmap, norm=norm)  # s=size
        plt.colorbar(sc, orientation='vertical')
        plt.gca().invert_yaxis()
        plt.show(block=False)


        """
        fig = plt.figure()
        ax = fig.add_subplot(111)
        # Plot the surface
        #ax.plot_surface(xGrid, yGrid, numOfPEs, color='b')
        cmap = plt.get_cmap('PiYG')
        levels = np.array([0,1,2,3,4])
        norm = BoundaryNorm(levels, ncolors=cmap.N, clip=True)
        p = ax.scatter(xGrid, yGrid, c=numOfPEs, cmap=cmap, norm=norm)
        fig.colorbar(p, ax=ax)
        cb = fig.colorbar(p, orientation='vertical')
        #b = fig.colorbar(p, orientation='vertical')
        """
        
        """
        c = plt.contourf(xGrid,yGrid,numOfPEs, linspace(-1,5,7))
        b = plt.colorbar(c, orientation='vertical')
        lx = plt.xlabel("x")
        ly = plt.ylabel("y")
        """

        """
        c = plt.contour(xGrid,yGrid,numOfPEs)
        l = plt.clabel(c)
        lx = plt.xlabel("x")
        ly = plt.ylabel("y")
        #levels = MaxNLocator(nbins=4).tick_values(numOfPEs.min(), numOfPEs.max())
        levels = np.array([0,1,2,3,4])
        cmap = plt.get_cmap('PiYG')
        norm = BoundaryNorm(levels, ncolors=cmap.N, clip=True)
        fig, ax = plt.subplots(nrows=1)
        im = ax.pcolormesh(xGrid, yGrid, numOfPEs, cmap=cmap, norm=norm)
        fig.colorbar(im, ax=ax)
        ax.set_title('Number of target PEs')
        fig.tight_layout()
        """



    def getTargetPECounts(self):
         coords = np.array([[0,0],[self.Y,self.X]])
         return self.getTargetPECountsRegion(coords)


    def displayTargetPECounts(self):
         coords = np.array([[0,0],[self.Y,self.X]])
         self.displayTargetPECountsRegion(coords)


    #----------------------------------------------------------------------------------------------------
    def displayPeCellArrangement(self):
        print 'Layer ', self.ID, ' PE pixel assignments'
        for y in range(peY):
            for x in range(peX):
                print '{', y, ',', x, '} : ', self.peArrayXYcellCount[y][x]


    #----------------------------------------------------------------------------------------------------
    def displayCellPeAssignments(self):
        for y in range(self.Y):
            for x in range(self.X):
                print self.cells[0][y][x].PE, ' ', 
            print

    #----------------------------------------------------------------------------------------------------
    def displayTargetPEs(self):
        for y in range(self.Y):
            for x in range(self.X):
                print self.cells[0][y][x].targetPEs, '||||', 
            print

    #----------------------------------------------------------------------------------------------------
    def displayTargetCells(self):
        for y in range(self.Y):
            for x in range(self.X):
                print self.cells[0][y][x].targetCells, '||||', 
            print

    #----------------------------------------------------------------------------------------------------
    def displaySourcePEs(self):
        for y in range(self.Y):
            for x in range(self.X):
                print self.cells[0][y][x].sourcePEs, '||||', 
            print

    #----------------------------------------------------------------------------------------------------
    def displaySourceCells(self, cellCoords=[]):
        if len(cellCoords) == 0:
            for y in range(self.Y):
                for x in range(self.X):
                    print self.cells[0][y][x].sourceCells, '||||', 
                print
        else:
            print self.cells[0][cellCoords[0]][cellCoords[1]].sourceCells, '||||', 

    #----------------------------------------------------------------------------------------------------
    def getSourceCells(self, cellCoords):
        return self.cells[cellCoords[0]][cellCoords[1]][cellCoords[2]].sourceCells

    #----------------------------------------------------------------------------------------------------
    def getTargetCells(self, cellCoords):
        return self.cells[cellCoords[0]][cellCoords[1]][cellCoords[2]].targetCells

    #----------------------------------------------------------------------------------------------------
    def getSourcePEs(self, cellCoords):
        return self.cells[cellCoords[0]][cellCoords[1]][cellCoords[2]].sourcePEs

    #----------------------------------------------------------------------------------------------------
    def getTargetPEs(self, cellCoords):
        return self.cells[cellCoords[0]][cellCoords[1]][cellCoords[2]].targetPEs

    #----------------------------------------------------------------------------------------------------
    def displayNumberOfCells(self):
        print 'Layer ', self.ID, 'number of cells is ', self.X*self.Y*self.Z

    #----------------------------------------------------------------------------------------------------
    def createCellTargetPEFile(self):

        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'Layer_{0}/'.format(self.ID)
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        outFile = dirStr + 'layer{0}'.format(self.ID)  + '_cellTargetList.txt'

        oFile = open(outFile, 'w')
        pLine = ''
        pLine = pLine + '\n{0:^13} : {1:^20} : {2:<100}'.format('Cell', 'Number of', ' PEs')
        pLine = pLine + '\n{0:^13} : {1:^20} : {2:<100}'.format(' ', 'PEs', ' ')
        
        cellCount = 0
        hiLoadCellCount = 0
        for y in range(self.Y):
            for x in range(self.X):
                for f in range(self.Z):
                    cellCount+=1
                    if len(self.cells[f][y][x].targetPEs.keys()) > 1 :
                        hiLoadCellCount+=1
                    pLine = pLine + '\n({1:3},{2:3},{3:3}}} : {4:^20} : {5:<100}  \n'.format(self.ID, f, y, x, len(self.cells[f][y][x].targetPEs.keys()), self.cells[f][y][x].targetPEs.keys())
        
        pLine = pLine + '\n\nMulti-PE target Cell counts : {0} : {1}'.format(hiLoadCellCount,cellCount)
        
        oFile.write(pLine)
        oFile.close()
                    

    #----------------------------------------------------------------------------------------------------
    def createSourceCellFile(self):

        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'Layer_{0}/'.format(self.ID)
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        outFile = dirStr + 'layer{0}'.format(self.ID)   + '_sourceCellList.txt'

        oFile = open(outFile, 'w')
        pLine = ''
        pLine = pLine + '\n{0:^13} : {1:^20} : {2:<100}'.format('Cell', 'Number of', ' Cells')
        pLine = pLine + '\n{0:^13} : {1:^20} : {2:<100}'.format(' ', 'Source Cells', ' ')
        
        for y in range(self.Y):
            for x in range(self.X):
                for f in range(self.Z):
                    pLine = pLine + '\n({1:3},{2:3},{3:3}) : {4:^20} : {5:<100}  \n'.format(self.ID, f, y, x, len(self.cells[f][y][x].sourceCells.keys()), self.cells[f][y][x].sourceCells.keys())
        
        oFile.write(pLine)
        oFile.close()
                    


########################################################################################################################
#----------------------------------------------------------------------------------------------------
# PE

class PE():

    def __init__(self, parentPEarray, numberOfLayers, peId):
        self.ID = peId

        #self.processedRegion = []
        self.roi             = []  # array([ {z,y,x}min, {z,y,x}max ])

        # Each element of roi grid will be the same size as the input with each bit indicating the cell is in the ROI
        self.roiGrid         = []

        # which cells in layer n are being processed by this pe
        self.cellsProcessed = []
        # cellsProcessed is a vector with each entry being a list of cells this PE processes at a particular layer
        for l in range(numberOfLayers):
          self.cellsProcessed.append([])
          #self.processedRegion.append([])
          self.roi.append([])
          self.roiGrid.append([])

        self.parentPEarray = parentPEarray

        self.manager       = []  # a manager will be assigned

    #----------------------------------------------------------------------------------------------------
    # print

    def __str__(self):
        pLine = ""
        pLine = pLine + '\nPE {0},{1}               '.format(self.ID[0], self.ID[1])
        cnt = 0
        for roi in self.roi:
           # if its not a np-array then not been set yet
           if isinstance(roi, list):
              pLine = pLine + '\nlayer{0} Not calculated '.format(cnt)
              cnt += 1
           else :
              pLine = pLine + '\nlayer{0} roi coords: {1},{2} '.format(cnt, roi[0], roi[1])
              cnt += 1
        pLine = pLine + '\nMethods: {0}             '.format(methods(self))
        pLine = pLine + '\nFields: {0}              '.format(fields(self))
        return pLine
        
    #----------------------------------------------------------------------------------------------------
    #----------------------------------------------------------------------------------------------------
    # ROI
    
    def findROI(self, layerID):

        # Parse the source cells and find Y,X corners of ROI and fill the roiGrid

        # roiGrid is the same size as the input/previous layer with each entry set to '1' if that cell is in the ROI of this PE
        roiGrid         = np.zeros(shape=(self.parentPEarray.parentNetwork.Layers[layerID-1].Z, \
                                          self.parentPEarray.parentNetwork.Layers[layerID-1].Y, \
                                          self.parentPEarray.parentNetwork.Layers[layerID-1].X), dtype=np.int)

        # each cell in a layer can be identified as the ith cell by counting starting at y=0, x=0 and z=0 and counting 
        absCellMin = np.inf
        absCellMax = 0

        for pc in self.cellsProcessed[layerID] :
          for sc in pc.sourceCells:
            absCellNum = sc.ID[1]*sc.parentLayer.X*sc.parentLayer.Z + sc.ID[2]*sc.parentLayer.Z + sc.ID[0]
            if absCellNum < absCellMin :
                absCellMin = absCellNum
                cellMin = sc
            if absCellNum > absCellMax :
                absCellMax = absCellNum
                cellMax = sc
            try:
                roiGrid[sc.ID[0]][sc.ID[1]][sc.ID[2]] = 1
            except:
                print sc
                print sc.ID[0],sc.ID[1],sc.ID[0]
                raise

        self.roi[layerID]     = np.array([[cellMin.ID[0], cellMin.ID[1], cellMin.ID[2]],[cellMax.ID[0], cellMax.ID[1], cellMax.ID[0]]])
        self.roiGrid[layerID] = roiGrid

        # Right now, all ROIs should contain all features, so test that the last cell has a Z value that is the same as the previos layers Z value
        # remember, layer dimensions are total, so max feature number will be Z-1
        if (self.roi[layerID][1][0] != self.parentPEarray.parentNetwork.Layers[layerID-1].Z-1):
          print '{0}:{1}:ERROR:roi does not include all features  '.format(__FILE__(), __LINE__())
          print '{0}:{1}:ERROR:ROI and previous layer info:       '.format(__FILE__(), __LINE__(), self.roi[layerID][1], self.parentPEarray.parentNetwork.Layers[layerID-1])
          raise

        """
        minx = np.inf
        miny = np.inf
        minz = np.inf
        maxx = 0
        maxy = 0
        maxz = 0
        for pc in self.cellsProcessed[layerID] :
          for sc in pc.sourceCells:
            if sc.Y < miny:
                miny = sc.Y
            if sc.Y > maxy:
                maxy = sc.Y
            if sc.X < minx:
                minx = sc.X
            if sc.X > maxx:
                maxx = sc.X

        # examine cells at corners of ROI to find min and max Z
        for pc in self.cellsProcessed[layerID] :
          for sc in pc.sourceCells:
              if (sc.Y == miny) and (sc.X == minx):
                  if sc.Z < minz:
                      minz = sc.Z
              if (sc.Y == maxy) and (sc.X == maxx):
                  if sc.Z > maxz:
                      maxz = sc.Z

        self.roi[layerID] = np.array([[minz, miny, minx],[maxz, maxy, maxx]])
        """

        return self.roi[layerID]


    def getROI(self, layerID):

        # self.roi[layer] is a numpy array showing start cell and end cell
        # if self.roi[layer] is a list that means it hasnt been created yet as roi is initialized as an list of lists
        if isinstance(self.roi[layerID], list):
            return self.findROI(layerID)
        else:
            return self.roi[layerID]

    """
    def findCellsProcessedRegion(self, layerID):
        minx = np.inf
        miny = np.inf
        maxx = 0
        maxy = 0
        for pc in self.cellsProcessed[layerID] :
          if pc.Y < miny:
              miny = pc.Y
          if pc.Y > maxy:
              maxy = pc.Y
          if pc.X < minx:
              minx = pc.X
          if pc.X > maxx:
              maxx = pc.X
        self.processedRegion[layerID] = np.array([miny, maxy, minx, maxx] )
        return self.processedRegion[layerID]
        #print minx, ",", maxx, ",", miny, ",", maxy
    """


    #----------------------------------------------------------------------------------------------------
    # processed Cells
    
    def addCell(self, layerId, cellId):
        # list of cell pointers
        if self.parentPEarray.parentNetwork.Layers[layerId].cells[cellId[0]][cellId[1]][cellId[2]] not in self.cellsProcessed :
            self.cellsProcessed[layerId].append(self.parentPEarray.parentNetwork.Layers[layerId].cells[cellId[0]][cellId[1]][cellId[2]])


    #----------------------------------------------------------------------------------------------------
    # Display along with gets for what is displayed
    
    #----------------------------------------------------------------------------------------------------
    def displayROIgridRegion(self, params) : #layerID, coords, Display):

        if 'plot' in params.keys():
            plotEnable = params['plot']
        else :
            plotEnable = False
        
        if 'print' in params.keys():
            printEnable = params['print']
        else :
            printEnable = False
        
        try :
            layerID = params['layer']
            coords  = params['coords']
        except:
            print '{0}:{1}:ERROR:PE {2},{3}: Bad parameters'.format(__FILE__(), __LINE__(), self.ID[0], self.ID[1])
            return

        yGrid, xGrid = np.mgrid[slice(coords[0][0], coords[1][0]+1), slice(coords[0][1], coords[1][1]+1)]
        tmpRoiGrid = np.zeros_like(xGrid, dtype=np.int)

        pLine = '\n'
        for y in   range(coords[0][0], coords[1][0]+1):
          for x in range(coords[0][1], coords[1][1]+1):
            zCnt = 0
            for z in range(self.roiGrid[layerID].__len__()):
              try:
                pLine = pLine + '{0:1}'.format(self.roiGrid[layerID][z][y][x])
                zCnt += self.roiGrid[layerID][z][y][x]
              except:
                print layerID,z,y,x
                raise
            tmpRoiGrid[y-coords[0][0]][x-coords[0][1]] = zCnt
            pLine = pLine + ' '
          pLine = pLine + '\n'

        if printEnable: print pLine

        if plotEnable: 

            # Find number of points and scale point based on number of elements
            # FIXME: this was empirically done
            num_pts = 0
            for e in tmpRoiGrid:
              num_pts += e.__len__()
            pt_scale =  10.0*(math.log((30000.0/num_pts),10))  # s=10 seemed right when there were 3000 point (e.g. 55x55 array)
            if pt_scale < 1.1: pt_scale = 1.1
            
            cp_info = np.zeros(num_pts, dtype=[('position', int, 2   ),  \
                                               ('size'    , int, 1   ),  \
                                               ('color'   , float, 4 )])  

            # scatter wants x first so put x in zero location
            cp_info['position'][:, 1] =          np.concatenate(yGrid     )                
            cp_info['position'][:, 0] =          np.concatenate(xGrid     )               
            cp_info['size'    ]       = np.concatenate(pt_scale*tmpRoiGrid)
            

            yLim   = (coords[0][0]-1, coords[1][0]+1)
            xLim   = (coords[0][1]-1, coords[1][1]+1)
            xVals  = range(coords[0][0], coords[1][0]+1)
            yVals  = range(coords[0][1], coords[1][1]+1)

            fig = plt.figure(figsize=(7, 7))
            ax = fig.add_axes([0.10, 0.10, 0.8, 0.8], frameon=False) # r,l,w,h
            #ax = fig.add_axes([0, 0, 1, 1], frameon=False) # r,l,w,h
            ax.set_xlim(xLim[0]-1, xLim[1]+1)  , ax.set_xticks(xVals)
            ax.set_ylim(yLim[0]-1, yLim[1]+1)  , ax.set_yticks(yVals)
            titleStr = 'Layer {0} PE {1},{2} ROI'.format(layerID, self.ID[0], self.ID[1]) 
            plt.text(0.5, 1.08, titleStr,        \
                  horizontalalignment='center',  \
                  fontsize=14,                   \
                  transform = ax.transAxes)
            #ax.set_xlim(-1, xLim) # , ax.set_xticks([])
            #ax.set_ylim(-1, yLim) # , ax.set_yticks([])
              
            cmap = plt.cm.get_cmap('RdYlBu')
            scat = ax.scatter(cp_info['position'][::1, 0], cp_info['position'][::1, 1],   \
                              s=cp_info['size'],                                          \
                              vmin=0, vmax=6,                                             \
                              cmap=cmap                                                   )
            plt.gca().invert_yaxis()
            ax.xaxis.set_tick_params(labeltop='on')
            ax.yaxis.set_tick_params(labelright='on')
            for item in ([ax.title, ax.xaxis.label, ax.yaxis.label] +  ax.get_xticklabels() + ax.get_yticklabels()):
                item.set_fontsize(10)

            plt.show(block=False)


            
    def displayROIgrid(self, layerID):

         # Make sure self.roiGrid has been created
         if isinstance(self.roiGrid[layerID], list) :
             self.findROI(layerID)

         coords = np.array([[0,0],[self.roiGrid[layerID][0].__len__()-1,self.roiGrid[layerID][0][0].__len__()-1]])

         params = {'display' : True, 'coords' : coords, 'layer' : layerID, 'plot' : True, 'print' : False}

         self.displayROIgridRegion(params)


    def getROIgridRegion(self, layerID, coords):

        yGrid, xGrid = np.mgrid[slice(coords[0][0], coords[1][0]+1), slice(coords[0][1], coords[1][1]+1)]
        tmpRoiGrid = np.zeros_like(xGrid, dtype=np.int)

        yRange = range(coords[0][0], coords[1][0]+1)
        xRange = range(coords[0][1], coords[1][1]+1)
        for y in yRange :
          #for x in range(self.roiGrid[layerID][0][0].__len__()):
          for x in xRange :
            # display the Y,X locations as a sized point to reflect how many features are set
            zCnt = 0
            for z in range(self.roiGrid[layerID].__len__()):
              try:
                zCnt += self.roiGrid[layerID][z][y][x]
              except:
                print layerID,z,y,x
                raise
            tmpRoiGrid[y-coords[0][0]][x-coords[0][1]] = zCnt

        return [tmpRoiGrid, xGrid, yGrid]

    def getROIgrid(self, layerID):

         # Make sure self.roiGrid has been created
         if isinstance(self.roiGrid[layerID], list) :
             self.findROI(layerID)

         coords = np.array([[0,0],[self.roiGrid[layerID][0].__len__()-1,self.roiGrid[layerID][0][0].__len__()-1]])
         return self.getROIgridRegion(layerID, coords)

    #----------------------------------------------------------------------------------------------------
    def displayCellsProcessedRegion(self, layerID, coords, dispOptions):

        # Return fig,plt,array if plot is True
        # otherwise return the array

        zGrid, yGrid, xGrid = np.mgrid[slice(0, self.parentPEarray.parentNetwork.Layers[layerID].Z), \
                                       slice(coords[0][0], coords[1][0]+1),                          \
                                       slice(coords[0][1], coords[1][1]+1)]
        tmpCellsProcessed        = np.zeros_like(xGrid, dtype=np.int)
        # when we do a 2D scatter plot, z is reflected in size of point
        tmpCellsProcessedForPlot = np.zeros_like(xGrid[0], dtype=np.int) # create Y,X array

        for pc in self.cellsProcessed[layerID] :
          if (pc.ID[1] >= coords[0][0]) and (pc.ID[1] <= coords[1][0]) :
            if (pc.ID[2] >= coords[0][1]) and (pc.ID[2] <= coords[1][1]) :
              pass
              tmpCellsProcessed[pc.ID[0]][pc.ID[1]][pc.ID[2]] += 1

        pLine = '\n'
        for y in range(tmpCellsProcessed[0].__len__()) :
          for x in range(tmpCellsProcessed[0][0].__len__()) :
            zCnt = 0
            for z in range(tmpCellsProcessed.__len__()) :
              try:
                pLine = pLine + '{0:1}'.format(tmpCellsProcessed[z][y][x])
                zCnt += tmpCellsProcessed[z][y][x]
              except:
                print layerID,z,y,x
                raise
            # number of features processed at this Y,X location
            tmpCellsProcessedForPlot[y][x] += zCnt
            pLine = pLine + ' '
          pLine = pLine + '\n'

        if dispOptions.pprint :
            print pLine

        xG = np.concatenate(xGrid[0])
        yG = np.concatenate(yGrid[0])
        cP = np.concatenate(tmpCellsProcessedForPlot)

        if dispOptions.pplot :

            #print pLine
            # Now plot
            cmap = plt.cm.get_cmap('RdYlBu')
 
            # scale point based on number of elements
            # FIXME: this was empirically done
            numPts = 0
            for e in tmpCellsProcessedForPlot:
              numPts += e.__len__()
            s =  10.0*(math.log((30000.0/numPts),10))  # s=10 seemed right when there were 3000 point (e.g. 55x55 array)
            if s < 0.01:
                s = 0.01
            else:
                s = tmpCellsProcessedForPlot* s
            
            #fig = plt.figure()
            fig, ax = plt.subplots()
            sc = ax.scatter(xG, yG, c=cP, s=s, vmin=0, vmax=6, cmap=cmap)  # s=size
            plt.gca().invert_yaxis()
            plt.show(block=False)

        if dispOptions.pplot:
            retVal = [cP, xG, yG, fig, sc, ]
        else :
            retVal = [cP, xG, yG]
        return retVal
            
    def displayCellsProcessed(self, layerID, dispOptions):
        coords = np.array([[0,0],[self.parentPEarray.parentNetwork.Layers[layerID].Y-1, self.parentPEarray.parentNetwork.Layers[layerID].X-1]])
        return self.displayCellsProcessedRegion(layerID, coords, dispOptions)

########################################################################################################################
#----------------------------------------------------------------------------------------------------
# PE ARRAY

class PEarray():

    def __init__(self, parentNetwork, peY, peX, numberOfLayers):
        self.parentNetwork = parentNetwork
        self.pe = []
        self.Y = peY
        self.X = peY
        for y in range(peY):
            peArrayX = []
            for x in range(peX):
                peArrayX.append(PE(self, numberOfLayers, np.array([y,x])))
            self.pe.append(peArrayX)

    #----------------------------------------------------------------------------------------------------
    # print

    def __str__(self):
        pLine = ""
        pLine = pLine + '\nPE Array'
        pLine = pLine + '\nPEs:{{Y,X}} : {0},{1}'.format(self.pe[0].__len__(), self.pe.__len__())
        pLine = pLine + '\nMethods: {0}'.format(methods(self))
        pLine = pLine + '\nFields: {0}'.format(fields(self))
        return pLine
        
    #----------------------------------------------------------------------------------------------------
    # 

    #----------------------------------------------------------------------------------------------------
    def addCell(self, peId, layerId, cellId):
        self.pe[peId[0]][peId[1]].addCell(layerId, cellId)

    #----------------------------------------------------------------------------------------------------
    # Determine all PE ROIs
    def findROIall(self, layerID):

        for yPe in range(self.Y) :
          for xPe in range(self.X) :
            self.pe[yPe][xPe].findROI(layerID)


    #----------------------------------------------------------------------------------------------------
    # Display
    
    #----------------------------------------------------------------------------------------------------
    # Animations
    
    def createProcessedCellsAnimation(self, layerID, dispOptions):
        pass
        global lId
        global cp_info
        global pt_scale
        global scat
        
        lId = layerID
        
        rv = self.pe[0][0].displayCellsProcessed(layerID=layerID, dispOptions=displayOptions())  # displayOptions are default False
        c = rv[0]
        x = rv[1]
        y = rv[2]
        
        num_pts = c.__len__()
        xLim  = np.array([0, self.parentNetwork.Layers[lId].X-1])
        yLim  = np.array([0, self.parentNetwork.Layers[lId].Y-1])
        xVals = range(xLim.min(), xLim.max()+1)
        yVals = range(yLim.min(), yLim.max()+1)
 
        cp_info = np.zeros(num_pts, dtype=[('position', int, 2   ),  \
                                           ('size'    , int, 1   ),  \
                                           ('color'   , float, 4 )])  
        # scatter wants x first so put x in zero location
        cp_info['position'][:, 1] = y
        cp_info['position'][:, 0] = x
        pt_scale =  10.0*(math.log((30000.0/num_pts),10))  # s=10 seemed right when there were 3000 point (e.g. 55x55 array)
        if pt_scale < 1.01: pt_scale = 1.01
        cp_info['size'    ]       = pt_scale*c
        
        numframes = self.Y*self.X
        
        fig = plt.figure(figsize=(7, 7))
        ax = fig.add_axes([0.10, 0.10, 0.8, 0.8], frameon=False) # r,l,w,h
        #ax = fig.add_axes([0, 0, 1, 1], frameon=False) # r,l,w,h
        ax.set_xlim(xLim[0]-1, xLim[1]+1)  , ax.set_xticks(xVals)
        ax.set_ylim(yLim[0]-1, yLim[1]+1)  , ax.set_xticks(yVals)
        titleStr = 'Layer {0} cells processed by PEs'.format(layerID) 
        plt.text(0.5, 1.08, titleStr,        \
              horizontalalignment='center',  \
              fontsize=14,                   \
              transform = ax.transAxes)
          
        cmap = plt.cm.get_cmap('RdYlBu')
        scat = ax.scatter(cp_info['position'][::1, 0], cp_info['position'][::1, 1],   \
                          s=cp_info['size'],                                          \
                          vmin=0, vmax=6,                                             \
                          cmap=cmap                                                   )
        plt.gca().invert_yaxis()
        ax.xaxis.set_tick_params(labeltop='on')
        ax.yaxis.set_tick_params(labelright='on')
        for item in ([ax.title, ax.xaxis.label, ax.yaxis.label] +  ax.get_xticklabels() + ax.get_yticklabels()):
            item.set_fontsize(10)
        
        ani = manimation.FuncAnimation(fig, self.update_plot_cellsProcessed,    \
                                      frames=xrange(numframes),  \
                                      interval = 1000,           \
                                      repeat   = False,           \
                                      blit     = False           )  # causes an error if True
        #                             fargs=(layerID)         )
        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'pe_array_/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        vidStr = dirStr + 'Layer_{0}_cells_processedby_PEs.mp4'.format(layerID) 
        #ani.save(vidStr,codec='mpeg4', fps=4)
        if dispOptions.createFile:
          ani.save(vidStr,codec='mpeg4') # , fps=4)
        #ani.save(vidStr,codec='mpeg4',writer=manimation.FFMpegFileWriter(extra_args=['--verbose-debug'])) # , fps=4)
        plt.show(block=False)


    def update_plot_cellsProcessed(self, frame_number):
        xPe = np.remainder(frame_number,8)
        yPe = frame_number/8
        rv = self.pe[yPe][xPe].displayCellsProcessed(layerID=lId, dispOptions=displayOptions())
        c = rv[0]
        x = rv[1]
        y = rv[2]
        cp_info['position'][::1, 0] = x
        cp_info['position'][::1, 1] = y
        cp_info['size'    ]       = pt_scale*c
        scat.set_sizes(cp_info['size'])
        scat.set_offsets(cp_info['position'])


    #----------------------------------------------------------------------------------------------------
    
    def createROIAnimation(self, layerID, dispOptions):
        pass
        global lId
        global cp_info
        global pt_scale
        global scat
        
        lId = layerID
        # Get initial display from PE 0,0
        rv = self.pe[0][0].getROIgrid(layerID=layerID)
        c = concatenate(rv[0])
        x = concatenate(rv[1])
        y = concatenate(rv[2])

        num_pts = c.__len__()
        xLim  = (rv[1].min(), rv[1].max())
        yLim  = (rv[2].min(), rv[2].max())
        xVals = range(rv[1].min(), rv[1].max()+1)
        yVals = range(rv[2].min(), rv[2].max()+1)
 
        cp_info = np.zeros(num_pts, dtype=[('position', int, 2   ),  \
                                           ('size'    , int, 1   ),  \
                                           ('color'   , float, 4 )])  
        # scatter wants x first so put x in zero location
        cp_info['position'][:, 1] = y
        cp_info['position'][:, 0] = x
        pt_scale =  10.0*(math.log((30000.0/num_pts),10))  # s=10 seemed right when there were 3000 point (e.g. 55x55 array)
        if pt_scale < 10.0: pt_scale = 10.0
        cp_info['size'    ]       = pt_scale*c
        
        numframes = self.Y*self.X
        
        fig = plt.figure(figsize=(7, 7))
        ax = fig.add_axes([0.1, 0.1, 0.8, 0.8], frameon=False) # r,l,w,h
        ax.set_xlim(xLim[0]-1, xLim[1]+1)  , ax.set_xticks(xVals)
        ax.set_ylim(yLim[0]-1, yLim[1]+1)  , ax.set_yticks(yVals)
        titleStr = 'Layer {0} PE ROI'.format(layerID) 
        plt.text(0.5, 1.08, titleStr,        \
              horizontalalignment='center',  \
              fontsize=14,                   \
              transform = ax.transAxes)
          
        cmap = plt.cm.get_cmap('RdYlBu')
        scat = ax.scatter(cp_info['position'][::1, 0], cp_info['position'][::1, 1],   \
                          s=cp_info['size'],                                          \
                          vmin=0, vmax=6,                                             \
                          cmap=cmap                                                   )
        plt.gca().invert_yaxis()
        ax.xaxis.set_tick_params(labeltop='on')
        ax.yaxis.set_tick_params(labelright='on')
        for item in ([ax.title, ax.xaxis.label, ax.yaxis.label] +  ax.get_xticklabels() + ax.get_yticklabels()):
            item.set_fontsize(10)
        
        ani = manimation.FuncAnimation(fig, self.update_plot_roi, \
                                      frames=xrange(numframes),   \
                                      interval = 1000,             \
                                      repeat   = False,            \
                                      blit     = False            )  # causes an error if True
        #                             fargs=(layerID)         )
        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'pe_array_/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        vidStr = dirStr + 'Layer_{0}_PE_ROI.mp4'.format(layerID) 
        #ani.save(vidStr,codec='mpeg4', fps=4)
        if dispOptions.createFile:
          ani.save(vidStr,codec='mpeg4') # , fps=4)
        #ani.save(vidStr,codec='mpeg4',writer=manimation.FFMpegFileWriter(extra_args=['--verbose-debug'])) # , fps=4)
        plt.show(block=False)

    def update_plot_roi(self, frame_number):
        xPe = np.remainder(frame_number,8)
        yPe = frame_number/8
        c, x, y = self.pe[yPe][xPe].getROIgrid(layerID=lId)
        cp_info['position'][::1, 0] = concatenate(x)
        cp_info['position'][::1, 1] = concatenate(y)
        cp_info['size'    ]         = concatenate( pt_scale*c)
        scat.set_sizes(cp_info['size'])
        scat.set_offsets(cp_info['position'])



########################################################################################################################
#----------------------------------------------------------------------------------------------------
# Manager ARRAY

class ManagerArray():

    def __init__(self, parentNetwork, mgrY, mgrX, numberOfLayers, memoryType):
        self.parentNetwork = parentNetwork
        self.manager = []
        self.Y = mgrY
        self.X = mgrY
        for y in range(mgrY):
            mgrArrayX = []
            for x in range(mgrX):
                mgrArrayX.append(Manager(self, numberOfLayers, np.array([y,x]), memoryType))
            self.manager.append(mgrArrayX)

    #----------------------------------------------------------------------------------------------------
    # print

    def __str__(self):
        pLine = ""
        pLine = pLine + '\nManager Array             '
        pLine = pLine + '\nManagers:{{Y,X}} : {0},{1}'.format(self.manager[0].__len__(), self.manager.__len__())
        pLine = pLine + '\nMethods: {0}              '.format(methods(self))
        pLine = pLine + '\nFields: {0}               '.format(fields(self))
        return pLine
        
    #----------------------------------------------------------------------------------------------------
    def addCell(self, peId, layerId, cellId):
        self.pe[peId[0]][peId[1]].addCell(layerId, cellId)


########################################################################################################################
#----------------------------------------------------------------------------------------------------
# Manager

class Manager():

    def __init__(self, parentManagerArray, numberOfLayers, mId, memoryType):
        self.ID                 = mId
        self.parentManagerArray = parentManagerArray
        self.absID              = int(mId[0]*self.parentManagerArray.X + mId[1])
        # add pointers between manager and PE
        self.pe                 = self.parentManagerArray.parentNetwork.peArray.pe[self.ID[0]][self.ID[1]]
        self.parentManagerArray.parentNetwork.peArray.pe[self.ID[0]][self.ID[1]].manager = self

        self.roiCells           = []  # copy of ROI of previous layer cells, constructed during memCpyROI
                                     
        self.memory                          = Memory(memoryType)
        self.memoryROIallocationOptions      = []      # For layer n, how memory was assigned to ROI
        self.memoryKernelAllocationOptions   = []      # For layer n, how memory was assigned to group kernels
        for l in range(numberOfLayers):
            self.memoryROIallocationOptions.append(None)        # For layer n, how memory was assigned to ROI
            self.memoryKernelAllocationOptions.append(None)     # For layer n, how memory was assigned to group kernels

        self.cellGroups                  = []  # groups of cells with same ROI
        self.numberOfStorageDescriptors  = 0
        self.storageDescriptors          = []
        """
        self.kernelStorageDescriptors = []
        self.roiStorageDescriptors    = []
        self.writeStorageDescriptors  = []
        """
 
        # Layer specific
        for l in range(numberOfLayers):
          self.roiCells.append(None)
          self.cellGroups.append([])
          self.storageDescriptors.append([])
          """
          self.kernelStorageDescriptors.append([])
          self.roiStorageDescriptors.append([])
          self.writeStorageDescriptors.append([])
          """
          pass


    #----------------------------------------------------------------------------------------------------
    # print

    def __str__(self):
        pLine = ""
        pLine = pLine + '\nManager {0},{1} '.format(self.ID[0], self.ID[1])
        pLine = pLine + '\nMethods: {0}    '.format(methods(self))
        pLine = pLine + '\nFields: {0}     '.format(fields(self))
        return pLine
        
    #----------------------------------------------------------------------------------------------------

    #----------------------------------------------------------------------------------------------------
    # WU related
    # 
    def createWUs(self, layerID):  
        
        # We need to describe the common ROI,  the address of the kernels and the destination manager(s) and address.
        # The ROI isnt consequitve in memory so describe with a starting address and a list of consequtive words and jumps to the next word
        # The kernels are consequitve in memory and we need to just describe ??? FIXME - WIP

        # The common technique for determining if a group of addresses are continuous if to create a dummpy memory location based on where the first cell is stored, 
        # and then increment that dummpy location and compare against the address of the next cell.
        # If the address is continuous, then count number of continuous. 
        # If its not continuous, then log the number of contigous, log the "jump" to the next location and restart count.

        wuOps          = []
        wuRois         = []
        wuKernels      = []
        wuDestinations = []
        gId            = 0

        # For each group in the Manager
        for g in self.cellGroups[layerID] : 

            numberOfCellsInGroup = g.__len__()

            #------------------------------------------------------------
            # a)
            # Get the common operation(s) for the group
            wuOp = {'SIMD Operation': None, 'stOp Operation': None}
            wuOp['SIMD Operation'] = g[0].simdOperation
            wuOp['stOp Operation'] = g[0].stOpOperation
            wuOps.append(wuOp)


            #------------------------------------------------------------
            # b)
            # Get the common ROI for the group
            wuRoi = {'StartAddress': None, 'Consequtive': [], 'Jump': [], 'Order' : []}
            # The ROI for all cells in a group are the same, so just use the first cell
            #for c in g[0]:
            roi = g[0].getROIcells()
            # Create a memory option type from first cells memory location
            memoryOption          = roi[0].memoryLocation.convertToMemoryAllocationOption()
            memoryOption.order    = self.memoryROIallocationOptions[layerID].order
            wuRoi['Order']        = memoryOption.order
            wuRoi['StartAddress'] = roi[0].memoryLocation
            cnt = 0  # count how many consequtive memory locations
            # use the memoryOption increment method and compare with address of next cell
            #memoryOption.increment(roi[0].memoryLocation.memory, 0)
            for rc in roi:
                if rc.memoryLocation.compareAddress(np.array([memoryOption.channel, memoryOption.bank, memoryOption.page, memoryOption.word])):
                    cnt += 1
                    memoryOption.increment(rc.memoryLocation.memory, 0)
                else:
                    wuRoi['Consequtive'].append(cnt)
                    rv = memoryOption.delta(rc.memoryLocation)  # returns [delta, <new memOption>]
                    jump = rv[0] # a jump of '0' would be the next location
                    wuRoi['Jump'].append(jump)
                    memoryOption = rv[1]
                    cnt = 1
                    memoryOption.increment(rc.memoryLocation.memory, 0)
            if cnt > 0 :
                wuRoi['Consequtive'].append(cnt)
            wuRois.append(wuRoi)

            #------------------------------------------------------------
            # c)
            # Describe the kernel(s) as a starting address based on the first cell in the group and then a group of tuples showing number of 
            # consequtive locations and jumps to next location

            # Get the kernel memory for each cell as a vector
            kernelAddresses = []
            for c in g:
                kernelAddresses.append(c.kernel.getLinearAddresses())

            # RUNCHECK : make sure all kernels sizes are the same
            entriesdInKernel = kernelAddresses[0].__len__()
            for cNum in range(1,numberOfCellsInGroup) :
                if entriesdInKernel != kernelAddresses[cNum].__len__() :
                    raise Exception('{0}:{1}:Manager {2},{3}:Kernel sizes are different in group {4}'.format(__FILE__(), __LINE__(), ID[0], ID[1], gId)) 

            # Start incrementing thru memory and make sure there are no discontinuities
            wuKernel = {'StartAddress': None, 'Consequtive': [], 'Jump': [], 'Order' : [], 'NumberOfCells' : None}
            memoryOption              = kernelAddresses[0][0].convertToMemoryAllocationOption()
            memoryOption.order        = self.memoryKernelAllocationOptions[layerID].order # use order from original group kernel assignment
            wuKernel['Order']         = memoryOption.order
            wuKernel['StartAddress']  = kernelAddresses[0][0]
            wuKernel['NumberOfCells'] = numberOfCellsInGroup
            cnt = 0  # count how many consequtive memory locations
            #memoryOption.increment(kernelAddresses[0][0].memory, 0)
            for kIdx in range(kernelAddresses[0].__len__()) :
                for cNum in range(numberOfCellsInGroup) :
                    if kernelAddresses[cNum][kIdx].compareAddress(np.array([memoryOption.channel, memoryOption.bank, memoryOption.page, memoryOption.word])):
                        cnt += 1
                        memoryOption.increment(kernelAddresses[cNum][kIdx].memory, 0)
                    else:
                        wuKernel['Consequtive'].append(cnt)
                        rv = memoryOption.delta(kernelAddresses[cNum][kIdx])  # returns [delta, <new memOption>]
                        wuKernel['Jump'].append(rv[0])
                        memoryOption = rv[1]
                        cnt = 1
                        memoryOption.increment(kernelAddresses[cNum][kIdx].memory, 0)
            if cnt > 0 :
                wuKernel['Consequtive'].append(cnt)
            wuKernels.append(wuKernel)
      

            #------------------------------------------------------------
            # d)
            # Describe the destination(s) as a ManagerID, starting address and consequitve/jump tuples. Output a warning if there are any jumps

            #--------------------
            # RUNCHECK
            # Make sure all copiedTo lists are the same length and contain the same managers
            numOfCopiedTo = g[0].copiedTo.__len__()
            for c in g[1:] :
                if c.copiedTo.__len__() != numOfCopiedTo :
                    raise Exception('{0}:{1}:Layer {2}:First cell {3},{4},{5} in group {6} has a different number of copiedTo lists than {7},{8},{9}'.format(__FILE__(), __LINE__(), layerID, g[0].ID[0], g[0].ID[1], g[0].ID[2], gId, c.ID[0], c.ID[1], c.ID[2] )) 
            
            for i in range(numOfCopiedTo) :
                mgr = g[0].copiedTo[i].managerLocation
                cCnt = 0
                for c in g[1:] :
                    try:
                        if mgr != c.copiedTo[i].managerLocation :
                            raise Exception('{0}:{1}:Manager {2},{3}:Layer {4}:Group {5}: First cell {6},{7},{8} has a different manager than cell {9},{10},{11}'.format(__FILE__(), __LINE__(), self.ID[0], self.ID[1], layerID, gId, g[0].ID[0], g[0].ID[1], g[0].ID[2], c.ID[0], c.ID[1], c.ID[2] )) 
                    except:
                            raise Exception('{0}:{1}:Manager {2},{3}:Layer {4}:Group {5}: Access issue with cell {6},{7},{8} copied to index {9}'.format(__FILE__(), __LINE__(), self.ID[0], self.ID[1], layerID, gId, c.ID[0], c.ID[1], c.ID[2], i))
                    cCnt += 1

            #--------------------
            # Make sure that a common destination manager is storing each cell state in contiguous memory
            # For each destination manager, make sure each cell in the group is writing to consequtive locations and create an output WU
            # So create a dummpy memory location based on where the first cell is stored, and then increment that dummpy location and compare against the address of the next cell.
            # If the address is continuous, then count number of cintoinuos. 
            # If its not continuous, then log the "jump" to the next location.
            wuDestination = []
            for ctIdx in range(numOfCopiedTo) :
                wuPerMgrDestination = {'Manager': None, 'StartAddress': None, 'Consequtive': [], 'Jump': [], 'Order' : [], 'NumberOfCells' : None}
                memoryOption         = g[0].copiedTo[ctIdx].memoryLocation.convertToMemoryAllocationOption()
                # We need to know how the next layer stores its input
                memoryOption.order                   = self.memoryROIallocationOptions[layerID+1].order # use order from original group ROI assignment
                wuPerMgrDestination['Order']         = memoryOption.order
                wuPerMgrDestination['Manager']       = g[0].copiedTo[ctIdx].managerLocation
                wuPerMgrDestination['StartAddress']  = g[0].copiedTo[ctIdx].memoryLocation
                wuPerMgrDestination['NumberOfCells'] = numberOfCellsInGroup
                cnt = 0  # count how many consequtive memory locations
                for cIdx in range(numberOfCellsInGroup) :
                    if g[cIdx].copiedTo[ctIdx].memoryLocation.compareAddress(np.array([memoryOption.channel, memoryOption.bank, memoryOption.page, memoryOption.word])):
                        cnt += 1
                        memoryOption.increment(g[cIdx].copiedTo[ctIdx].memoryLocation.memory, 0)
                    else:
                        wuPerMgrDestination['Consequtive'].append(cnt)
                        rv = memoryOption.delta(g[cIdx].copiedTo[ctIdx].memoryLocation)  # returns [delta, <new memOption>]
                        wuPerMgrDestination['Jump'].append(rv[0])
                        memoryOption = rv[1]
                        cnt = 1
                        memoryOption.increment(g[cIdx].copiedTo[ctIdx].memoryLocation.memory, 0)
                if cnt > 0 :
                    wuPerMgrDestination['Consequtive'].append(cnt)
                wuDestination.append(wuPerMgrDestination)

            wuDestinations.append(wuDestination)

            gId += 1
            
        return [wuOps, wuRois, wuKernels, wuDestinations]
                        
    # print WU's
    # 
    def printWUs(self, layerID):  

        [opWu, roiWu, kerWu, destWu] = self.createWUs(layerID)
        WUs = []
        # Create a header for the WU file
        pLine = '# Each WU will have four descriptors, an operation descriptor, an arg0 or ROI descriptor, an arg1 or Kernel descriptor and a destination descriptor. Note: within a WU descriptors separated by "|"'
        pLine = '# The descriptors will take the following format delineated with SOD/EOD (start-of-desc/end-of-desc):'
        pLine = pLine + '\n# SOD, ' + '"DescType" : {0:^20}, '.format('"Operations"')   + '"OptionType" : {0:^16}, '.format('"stOp"')   + '"Option" : {0:^14}, '.format('"STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM"')      + '"OptionType" : {0:^16}, '.format('"SIMD"')     + '"Option" : {0:^10}, '.format('"ReLu"')   + '"OptionType" : {0:^16}, '.format('"Null"') 
        pLine = pLine + '\n# SOD, ' + '"DescType" : {0:^20}, '.format('"Memory Read"')  + '"OptionType" : {0:^16}, '.format('"target"') + '"Option" : {0:^14}, '.format('"Stack Arg0"')                                             + '"OptionType" : {0:^16}, '.format('"Transfer"') + '"Option" : {0:^10}, '.format('"BCast"')  + '"OptionType" : {0:^16}, '.format('"numLanes"') + '"Option" : {0:^10}, '.format('"N"') + '"OptionType" : {0:^16}, '.format('"storage"') + '"Option" : {0:^100}, '.format('{0:^24}'.format('"Address (ROI)"')        + '{0:^15}'.format('"Increment order"') + '{0:^20}'.format('"consequtive"') + '{0:^8}'.format('"valid"') + '{0:^7}'.format('"jump"') + '{0:^8}'.format('"valid" .... ')) + '"OptionType" : {0:^16}, '.format('"Null"') + "EOD"
        pLine = pLine + '\n# SOD, ' + '"DescType" : {0:^20}, '.format('"Memory Read"')  + '"OptionType" : {0:^16}, '.format('"target"') + '"Option" : {0:^14}, '.format('"Stack Arg1"')                                             + '"OptionType" : {0:^16}, '.format('"Transfer"') + '"Option" : {0:^10}, '.format('"Vector"') + '"OptionType" : {0:^16}, '.format('"numLanes"') + '"Option" : {0:^10}, '.format('"N"') + '"OptionType" : {0:^16}, '.format('"storage"') + '"Option" : {0:^100}, '.format('{0:^24}'.format('"Address (Kernel)"')     + '{0:^15}'.format('"Increment order"') + '{0:^20}'.format('"consequtive"') + '{0:^8}'.format('"valid"') + '{0:^7}'.format('"jump"') + '{0:^8}'.format('"valid" .... ')) + '"OptionType" : {0:^16}, '.format('"Null"') + "EOD"
        pLine = pLine + '\n# SOD, ' + '"DescType" : {0:^20}, '.format('"Memory Write"') + '"OptionType" : {0:^16}, '.format('"source"') + '"Option" : {0:^14}, '.format('"Stack"')                                                  + '"OptionType" : {0:^16}, '.format('"Transfer"') + '"Option" : {0:^10}, '.format('"Vector"') + '"OptionType" : {0:^16}, '.format('"numLanes"') + '"Option" : {0:^10}, '.format('"N"') + '"OptionType" : {0:^16}, '.format('"storage"') + '"Option" : {0:^100}, '.format('{0:^24}'.format('"Address (next Layer)"') + '{0:^15}'.format('"Increment order"') + '{0:^20}'.format('"consequtive"') + '{0:^8}'.format('"valid"') + '{0:^7}'.format('"jump"') + '{0:^8}'.format('"valid" .... ')) + '"OptionType" : {0:^16}, '.format('"Null"') + "EOD"
        pLine = pLine + '\n'
        pLine = pLine + '\n# The storage option takes the following form : ' + '{0:^24}'.format('"Address"') + '{0:^15}'.format('"Increment order"') + '{0:^20}'.format('"consequtive"') + '{0:^8}'.format('"valid"') + '{0:^7}'.format('"jump"') + '{0:^8}'.format('"valid" .... ') + '{0:^20}'.format('"consequtive"') + '{0:^8}'.format('"invalid"') 

        pLine = pLine + '\n# In the case of the Memory write, there may be more than one optionType=storage if the result has to be written to multiple managers'
        pLine = pLine + '\n# Address format = "Mgr, Local/Global, channel, bank, page, word"'
        pLine = pLine + '\n'
        pLine = pLine + '\n# Field lengths:'
        pLine = pLine + '\n# Delineator      : {0:^{1}}, '.format(int(math.ceil(math.log(len(descDelin  )-1,2))), int(math.ceil(math.log(len(descDelin  )-1,10))))
        pLine = pLine + '\n# Descriptor Type : {0:^{1}}, '.format(int(math.ceil(math.log(len(descType   )-1,2))), int(math.ceil(math.log(len(descType   )-1,10))))
        pLine = pLine + '\n# Option Type     : {0:^{1}}, '.format(int(math.ceil(math.log(len(optionType )-1,2))), int(math.ceil(math.log(len(optionType )-1,10))))
        optValLen = max(len(stOpValues), len(simdValues), len(tgtValues), len(txferValues), len(orderValues))
        pLine = pLine + '\n# Option Value    : {0:^{1}}, '.format(int(math.ceil(math.log(    optValLen   -1,2))), int(math.ceil(math.log(    optValLen   -1,10))))

        WUs.append(pLine)

        separatorStr = '****  '

        # Create WU's and add to file
        for n in range(roiWu.__len__()) :
            op  = opWu[n]
            roi = roiWu[n]
            ker = kerWu[n]
            dest = destWu[n]

            #----------------------------------------------------------------------------------------------------
            # OPERATION Descriptor
            #  - streamingOp = FP MAC 
            #  - SIMD = ReLu
            
            opDescRowStr = ''
            opDescRowStr = opDescRowStr + '{0:^{1}}, '.format(toHexPad(descDelin.SOD         , descDelin .WIDTH ), descDelin .WIDTH ) 
            opDescRowStr = opDescRowStr + '{0:^{1}}, '.format(toHexPad(descType.OP           , descType  .WIDTH ), descType  .WIDTH )         
            # option tuples                                                                  
            opDescRowStr = opDescRowStr + '{0:^{1}}: '.format(toHexPad(optionType.stOp       , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(stOpValues.STREAMING_OP_CNTL_OPERATION_STD_STD_FP_MAC_TO_MEM, stOpValues.WIDTH), stOpValues.WIDTH )
            opDescRowStr = opDescRowStr + '{0:^{1}}: '.format(toHexPad(optionType.simdOp     , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(simdValues.ReLu                                             , simdValues.WIDTH), simdValues.WIDTH )
            opDescRowStr = opDescRowStr + '{0:^{1}}, '.format(toHexPad(optionType.NOP        , optionType.WIDTH ), optionType.WIDTH )   
            opDescRowStr = opDescRowStr + '{0:^{1}}  '.format(toHexPad(descDelin.EOD         , descDelin .WIDTH ), descDelin .WIDTH ) 

            
            #----------------------------------------------------------------------------------------------------
            # MEMORY_READ Descriptor and text file
            #  - BCast to arg0

            #--------------------------------------------------
            # Descriptor

            # Address is chiplet wide address, so include Manager ID in msb's
            roiAddress = '{0:>{1}}_' .format(toHexPad(self.absID                  , int(math.ceil(math.log(self.parentManagerArray.Y*self.parentManagerArray.X          ,16))) ), int(math.ceil(math.log(self.parentManagerArray.Y*self.parentManagerArray.X          ,16))))
            roiAddress = roiAddress + roi['StartAddress'].asHexString()
            # remember to remove any spaces when adding fields to descriptor
            readDesc   = StorageDescriptor(roiAddress.replace(" ",""), 'read', roi['Order'], [], [] )

            #--------------------------------------------------
            # Text file

            roiRowStr = ''
            roiRowStr = roiRowStr + '{0:^{1}}, '.format(toHexPad(descDelin.SOD               , descDelin .WIDTH ), descDelin .WIDTH ) 
            roiRowStr = roiRowStr + '{0:^{1}}, '.format(toHexPad(descType.MR                 , descType  .WIDTH ), descType  .WIDTH )         
            # option tuples
            roiRowStr = roiRowStr + '{0:^{1}}: '.format(toHexPad(optionType.TGT              , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(tgtValues.STACK_DN_ARG0 , tgtValues  .WIDTH), tgtValues  .WIDTH )
            roiRowStr = roiRowStr + '{0:^{1}}: '.format(toHexPad(optionType.TXFER            , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(txferValues.BCAST       , txferValues.WIDTH), txferValues.WIDTH )
            roiRowStr = roiRowStr + '{0:^{1}}: '.format(toHexPad(optionType.NUM_OF_LANES     , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(ker['NumberOfCells']    , 2                ), txferValues.WIDTH )
            #  - memory option
            # Construct storage descriptor
            # - save storage descriptor and ptr to storage descriptor as option value
            roiRowStr = roiRowStr + '{0:^{1}}: '.format(toHexPad(optionType         .MEMORY  , optionType.WIDTH                                                                      ), optionType.WIDTH                                                                     )   

            
            #roiRowStr = roiRowStr + roiAddress

            """
            roiRowStr = roiRowStr + '{0:>{1}}_' .format(toHexPad(roi['StartAddress'].channel , int(math.ceil(math.log(roi['StartAddress'].memory.configuration.numOfChannels       ,16))) ), int(math.ceil(math.log(roi['StartAddress'].memory.configuration.numOfChannels       ,16))))
            roiRowStr = roiRowStr + '{0:>{1}}_' .format(toHexPad(roi['StartAddress'].bank    , int(math.ceil(math.log(roi['StartAddress'].memory.configuration.numOfBanksPerChannel,16))) ), int(math.ceil(math.log(roi['StartAddress'].memory.configuration.numOfBanksPerChannel,16))))
            roiRowStr = roiRowStr + '{0:>{1}}_' .format(toHexPad(roi['StartAddress'].page    , int(math.ceil(math.log(roi['StartAddress'].memory.configuration.numOfPagesPerBank   ,16))) ), int(math.ceil(math.log(roi['StartAddress'].memory.configuration.numOfPagesPerBank   ,16))))
            roiRowStr = roiRowStr + '{0:>{1}} ' .format(toHexPad(roi['StartAddress'].word    , int(math.ceil(math.log(roi['StartAddress'].memory.configuration.sizeOfPage/32       ,16))) ), int(math.ceil(math.log(roi['StartAddress'].memory.configuration.sizeOfPage/32       ,16))))
            """
            #roiRowStr = roiRowStr + '{0:>{1}} ' .format(getattr(orderValues, ''.join(  roi['Order'])), orderValues.WIDTH)

            # descriptor access order added during descriptor creation
            for c in range(len(roi['Consequtive'])) :
                #roiRowStr = roiRowStr + '{0:>4} '.format(toHexPad(roi['Consequtive'][c],4))
                readDesc.consequtive.append(toHexPad(roi['Consequtive'][c],3))
                try :
                    #roiRowStr = roiRowStr + '1 {0:>3} '.format(toHexPad(roi['Jump'][c], 3))
                    readDesc.jump.append(toHexPad(roi['Jump'][c], 3))
                except:
                    pass
            # Add descriptor to manager list
            descPtr = self.addStorageDescriptor(layerID, readDesc)  
            # add value to storage tuple
            roiRowStr = roiRowStr + '{0:>{1}}_' .format(toHexPad(self.absID                  , int(math.ceil(math.log(self.parentManagerArray.Y*self.parentManagerArray.X          ,16))) ), int(math.ceil(math.log(self.parentManagerArray.Y*self.parentManagerArray.X          ,16))))
            roiRowStr = roiRowStr + '{0:^{1}}, '    .format(toHexPad(descPtr, int(math.ceil(math.log(math.pow(descPtrWidth,2),16)))), int(math.ceil(math.log(math.pow(descPtrWidth,2),16))) )

            #roiRowStr = roiRowStr + '0, '
            #  - memory option end
            roiRowStr = roiRowStr + '{0:^{1}}, '    .format(toHexPad(optionType.NOP   , optionType.WIDTH ), optionType.WIDTH )   
            roiRowStr = roiRowStr + '{0:^{1}}  '    .format(toHexPad(descDelin.EOD    , descDelin .WIDTH ), descDelin .WIDTH ) 
            pass

            # Store the descriptor
            #self.roiStorageDescriptors[layerID].append(readDesc)
            #self.storageDescriptors[layerID].append(readDesc)


            #----------------------------------------------------------------------------------------------------
            # MEMORY_READ Descriptor
            #  - Vector to arg1
            # Address is a chiplet wdide address, so include Manager ID as msb's of address
            kerAddress = '{0:>{1}}_' .format(toHexPad(self.absID                  , int(math.ceil(math.log(self.parentManagerArray.Y*self.parentManagerArray.X          ,16))) ), int(math.ceil(math.log(self.parentManagerArray.Y*self.parentManagerArray.X          ,16))))
            kerAddress = kerAddress + ker['StartAddress'].asHexString()
            readDesc   = StorageDescriptor(kerAddress.replace(" ",""), 'read', ker['Order'], [], [] )



            kerRowStr = '{0:^{1}}, '.format(toHexPad(descDelin.SOD               , descDelin .WIDTH ), descDelin .WIDTH ) 
            kerRowStr = kerRowStr + '{0:^{1}}, '.format(toHexPad(descType.MR                 , descType  .WIDTH ), descType  .WIDTH )         
            # option tuples
            kerRowStr = kerRowStr + '{0:^{1}}: '.format(toHexPad(optionType.TGT              , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(tgtValues.STACK_DN_ARG1 , tgtValues  .WIDTH), tgtValues  .WIDTH )
            kerRowStr = kerRowStr + '{0:^{1}}: '.format(toHexPad(optionType.TXFER            , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(txferValues.VECTOR      , txferValues.WIDTH), txferValues.WIDTH )
            kerRowStr = kerRowStr + '{0:^{1}}: '.format(toHexPad(optionType.NUM_OF_LANES     , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(ker['NumberOfCells']    , 2                ), txferValues.WIDTH )

            #  - memory option
            # Construct storage descriptor
            # - save storage descriptor and ptr to storage descriptor as option value
            kerRowStr = kerRowStr + '{0:^{1}}: '.format(toHexPad(optionType         .MEMORY  , optionType.WIDTH                                                                      ), optionType.WIDTH                                                                     )   
            #kerRowStr = kerRowStr + kerAddress

            """
            kerRowStr = kerRowStr + '{0:>{1}}_' .format(toHexPad(ker['StartAddress'].channel , int(math.ceil(math.log(ker['StartAddress'].memory.configuration.numOfChannels       ,16))) ), int(math.ceil(math.log(ker['StartAddress'].memory.configuration.numOfChannels       ,16))))
            kerRowStr = kerRowStr + '{0:>{1}}_' .format(toHexPad(ker['StartAddress'].bank    , int(math.ceil(math.log(ker['StartAddress'].memory.configuration.numOfBanksPerChannel,16))) ), int(math.ceil(math.log(ker['StartAddress'].memory.configuration.numOfBanksPerChannel,16))))
            kerRowStr = kerRowStr + '{0:>{1}}_' .format(toHexPad(ker['StartAddress'].page    , int(math.ceil(math.log(ker['StartAddress'].memory.configuration.numOfPagesPerBank   ,16))) ), int(math.ceil(math.log(ker['StartAddress'].memory.configuration.numOfPagesPerBank   ,16))))
            kerRowStr = kerRowStr + '{0:>{1}} ' .format(toHexPad(ker['StartAddress'].word    , int(math.ceil(math.log(ker['StartAddress'].memory.configuration.sizeOfPage/32       ,16))) ), int(math.ceil(math.log(ker['StartAddress'].memory.configuration.sizeOfPage/32       ,16))))
            """

            # descriptor access order added during descriptor creation
            #kerRowStr = kerRowStr + '{0:>{1}} ' .format(getattr(orderValues, ''.join(  ker['Order'])), orderValues.WIDTH)
            for c in range(len(ker['Consequtive'])) :
                #kerRowStr = kerRowStr + '{0:>4} '.format(toHexPad(ker['Consequtive'][c],4))
                readDesc.consequtive.append(toHexPad(ker['Consequtive'][c],3))
                try :
                    #kerRowStr = kerRowStr + '1 {0:>3} '.format(toHexPad(ker['Jump'][c], 3))
                    readDesc.jump.append(toHexPad(ker['Jump'][c], 3))
                except:
                    pass
            # Add descriptor to manager list
            descPtr = self.addStorageDescriptor(layerID, readDesc)  
            kerRowStr = kerRowStr + '{0:>{1}}_' .format(toHexPad(self.absID                  , int(math.ceil(math.log(self.parentManagerArray.Y*self.parentManagerArray.X          ,16))) ), int(math.ceil(math.log(self.parentManagerArray.Y*self.parentManagerArray.X          ,16))))
            kerRowStr = kerRowStr + '{0:^{1}}, '    .format(toHexPad(descPtr, int(math.ceil(math.log(math.pow(descPtrWidth,2),16)))), int(math.ceil(math.log(math.pow(descPtrWidth,2),16))) )

            #kerRowStr = kerRowStr + '0, '
            #  - memory option end
            kerRowStr = kerRowStr + '{0:^{1}}, '    .format(toHexPad(optionType.NOP   , optionType.WIDTH ), optionType.WIDTH )   
            kerRowStr = kerRowStr + '{0:^{1}}  '    .format(toHexPad(descDelin.EOD    , descDelin .WIDTH ), descDelin .WIDTH ) 
            pass

            # Store the descriptor
            #self.storageDescriptors[layerID].append(readDesc)
            #self.kernelStorageDescriptors[layerID].append(readDesc)


            #----------------------------------------------------------------------------------------------------
            # MEMORY_WRITE Descriptor
            #  - Vector to memory
            dRowStr = ''
            dRowStr =   dRowStr + '{0:^{1}}, '.format(toHexPad(descDelin.SOD           , descDelin .WIDTH ), descDelin .WIDTH ) 
            dRowStr =   dRowStr + '{0:^{1}}, '.format(toHexPad(descType.MW             , descType  .WIDTH ), descType  .WIDTH )         
            # option tuples
            dRowStr =   dRowStr + '{0:^{1}}: '.format(toHexPad(optionType.SRC          , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(srcValues.STACK_UP       , srcValues  .WIDTH), srcValues  .WIDTH )
            dRowStr =   dRowStr + '{0:^{1}}: '.format(toHexPad(optionType.TXFER        , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(txferValues.VECTOR       , txferValues.WIDTH), txferValues.WIDTH )
            dRowStr =   dRowStr + '{0:^{1}}: '.format(toHexPad(optionType.NUM_OF_LANES , optionType.WIDTH ), optionType.WIDTH )   + '{0:^{1}}, '.format(toHexPad(dest[0]['NumberOfCells'] , 2                ), txferValues.WIDTH )

            #dRowStr = dRowStr + '{0:>2} '.format(toHexPad(dest.__len__(), 2))
            #  - memory option
            for d in dest :

                # Create a storage descriptor for each destination
                destAddress =   '{0:>{1}}_' .format(toHexPad(  d['Manager'].absID        , int(math.ceil(math.log(  d['Manager'].parentManagerArray.Y*d['Manager'].parentManagerArray.X  ,16))) ), int(math.ceil(math.log(  d['Manager'].parentManagerArray.Y*d['Manager'].parentManagerArray.X   ,16))))
                destAddress =   destAddress + d['StartAddress'].asHexString()
                writeDesc   =   StorageDescriptor(destAddress.replace(" ",""), 'write', d['Order'], [], [] )

                # Construct storage descriptor
                # - save storage descriptor and ptr to storage descriptor as option value
                dRowStr =   dRowStr + '{0:^{1}}: '.format(toHexPad(optionType         .MEMORY  , optionType.WIDTH                                                                      ), optionType.WIDTH                                                                     )   

                #dRowStr =   dRowStr + destAddress
                """
                dRowStr =   dRowStr + '{0:>{1}}_' .format(toHexPad(  d['StartAddress'].channel , int(math.ceil(math.log(  d['StartAddress'].memory.configuration.numOfChannels                 ,16))) ), int(math.ceil(math.log(  d['StartAddress'].memory.configuration.numOfChannels                  ,16))))
                dRowStr =   dRowStr + '{0:>{1}}_' .format(toHexPad(  d['StartAddress'].bank    , int(math.ceil(math.log(  d['StartAddress'].memory.configuration.numOfBanksPerChannel          ,16))) ), int(math.ceil(math.log(  d['StartAddress'].memory.configuration.numOfBanksPerChannel           ,16))))
                dRowStr =   dRowStr + '{0:>{1}}_' .format(toHexPad(  d['StartAddress'].page    , int(math.ceil(math.log(  d['StartAddress'].memory.configuration.numOfPagesPerBank             ,16))) ), int(math.ceil(math.log(  d['StartAddress'].memory.configuration.numOfPagesPerBank              ,16))))
                dRowStr =   dRowStr + '{0:>{1}} ' .format(toHexPad(  d['StartAddress'].word    , int(math.ceil(math.log(  d['StartAddress'].memory.configuration.sizeOfPage/32                 ,16))) ), int(math.ceil(math.log(  d['StartAddress'].memory.configuration.sizeOfPage/32                  ,16))))
                """
                #dRowStr =   dRowStr + '{0:>{1}} ' .format(getattr(orderValues, ''.join(  d['Order'])), orderValues.WIDTH)
                
                # descriptor access order added during descriptor creation
                #dRowStr =   dRowStr + '{0:>4} '.format(toHexPad(orderValues.''.join(d['Order']), orderValues.WIDTH))
                for c in range(len(d['Consequtive'])) :
                    #dRowStr = dRowStr + '{0:>4} '.format(toHexPad(d['Consequtive'][c],4))
                    writeDesc.consequtive.append(toHexPad(d['Consequtive'][c],3))
                    try :
                        #dRowStr = dRowStr + '1 {0:>3} '.format(toHexPad(d['Jump'][c], 3))
                        writeDesc.jump.append(toHexPad(d['Jump'][c], 3))
                    except:
                        pass
                # Add descriptor to destination manager list
                descPtr = d['Manager'].addStorageDescriptor(layerID, writeDesc)  
                #descPtr = self.addStorageDescriptor(layerID, writeDesc)  
                # Memory descriptor pointer is Mgr_localDescAddress
                dRowStr = dRowStr + '{0:>{1}}_' .format(toHexPad(  d['Manager'].absID        , int(math.ceil(math.log(  d['Manager'].parentManagerArray.Y*d['Manager'].parentManagerArray.X  ,16))) ), int(math.ceil(math.log(  d['Manager'].parentManagerArray.Y*d['Manager'].parentManagerArray.X   ,16))))
                dRowStr = dRowStr + '{0:^{1}}, '    .format(toHexPad(descPtr, int(math.ceil(math.log(math.pow(descPtrWidth,2),16)))), int(math.ceil(math.log(math.pow(descPtrWidth,2),16))) )
                #dRowStr = dRowStr + '0, '

                # Store the descriptor and return the descriptor pointer
                #self.storageDescriptors[layerID].append(writeDesc)
                #self.writeStorageDescriptors[layerID].append(writeDesc)

            #  - memory option end
            dRowStr =   dRowStr + '{0:^{1}}, '    .format(toHexPad(optionType.NOP   , optionType.WIDTH ), optionType.WIDTH )   
            dRowStr =   dRowStr + '{0:^{1}}  '    .format(toHexPad(descDelin.EOD    , descDelin .WIDTH ), descDelin .WIDTH ) 

            WUs.append(opDescRowStr + separatorStr + roiRowStr + separatorStr + kerRowStr + separatorStr + dRowStr)

        return WUs

      

    # save WU's
    # 
    def createWUfiles(self, layerID):  
  
        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'manager_{0}_{1}/'.format(self.ID[0], self.ID[1])
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        outFile = dirStr + 'manager_{0}_{1}_layer{2}_WUs.txt'.format(self.ID[0], self.ID[1], layerID)

        oFile = open(outFile, 'w')

        wus = self.printWUs(layerID)
        pLine = ''
        for wu in wus :
            pLine = pLine + wu + '\n'
        
        oFile.write(pLine)
        oFile.close()
        pass

    def createStorageDescriptorFiles(self, layerID):  
  
        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'manager_{0}_{1}/'.format(self.ID[0], self.ID[1])
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        outFile = dirStr + 'manager_{0}_{1}_layer{2}_storageDescriptors.txt'.format(self.ID[0], self.ID[1], layerID)

        oFile = open(outFile, 'w')

        pLine = ''
        pLine = pLine + '# ID Address(mgr,chan,bank,page,word) Order Consequtive Valid Jump Consequtive Valid Jump .... Invalid\n'
        for storageDesc in self.storageDescriptors[layerID] :
          pLine = pLine + '{0:^{1}} '    .format(toHexPad(storageDesc.Id, int(math.ceil(math.log(math.pow(descPtrWidth,2),16)))), int(math.ceil(math.log(math.pow(descPtrWidth,2),16))) )
          pLine = pLine + storageDesc.address + ' ' 
          pLine = pLine + '{0:>{1}} ' .format(getattr(orderValues, ''.join(  storageDesc.accessOrder)), orderValues.WIDTH)
          for c in range(len(storageDesc.consequtive)) :
              pLine = pLine + '{0:>3} '.format(toHexPad(int(storageDesc.consequtive[c],16)-1,3))
              try :
                  pLine = pLine + '1 {0:>3} '.format(toHexPad(int(storageDesc.jump[c],16)+1,3))
              except:
                  pass
          pLine = pLine + '0\n'
        
        oFile.write(pLine)
        oFile.close()
        pass


    # When we create a storage descriptor, we will search the existing list of descriptors to see if it already exists,
    # if it does, then simply return the pointer, if it doesnt, add it to the list and increment the static pointer in the storage class
    def addStorageDescriptor(self, layerID, newStorageDesc):  
      if self.numberOfStorageDescriptors == 0 :
          #print '{0}:{1}:LEE:INFO:DEBUG: First descriptor for layer {2}: {3}'.format(__FILE__(), __LINE__(), layerID, newStorageDesc)
          #newStorageDesc.Id = StorageDescriptor.ptr  # assign this descriptors ptr to the static pointer in the class. Note: this gets incremented for all managers, so sue different method
          newStorageDesc.Id = 0
          self.storageDescriptors[layerID].append(newStorageDesc)
          newPtr = newStorageDesc.Id
          self.numberOfStorageDescriptors += 1                 # pointer to the next descriptor
      else :
        #print '{0}:{1}:LEE:ERROR:DEBUG: Current number of storage descriptors = {2}, New descriptor = {3}'.format(__FILE__(), __LINE__(), len(self.storageDescriptors[layerID]), newStorageDesc)
        for storageDesc in self.storageDescriptors[layerID] :
          #print '{0}:{1}:LEE:ERROR:DEBUG:'.format(__FILE__(), __LINE__()), storageDesc
          if storageDesc == newStorageDesc :
            existingPtr = storageDesc.Id  # return descriptor already stored in this manager
            #print '{0}:{1}:LEE:ERROR:DEBUG: Use existing descriptor ptr {2}'.format(__FILE__(), __LINE__(), existingPtr)
            return existingPtr
        # Descriptor not in list
        #newStorageDesc.Id = StorageDescriptor.ptr  # assign this descriptors ptr to the static pointer in the class
        newStorageDesc.Id = self.numberOfStorageDescriptors 
        self.storageDescriptors[layerID].append(newStorageDesc)
        self.numberOfStorageDescriptors += 1                 # pointer to the next descriptor in this manager
        StorageDescriptor.ptr += 1                 # Keep track of all storage pointers across all managers
        newPtr = newStorageDesc.Id
        #print '{0}:{1}:LEE:ERROR:DEBUG: Add new descriptor ptr {2}'.format(__FILE__(), __LINE__(), newPtr)
      #print '{0}:{1}:LEE:ERROR:DEBUG: Returning ptr = {2}'.format(__FILE__(), __LINE__(), newPtr)
      return newPtr
          
        

    #----------------------------------------------------------------------------------------------------

    #----------------------------------------------------------------------------------------------------
    # Mem Copy
    # copy ROI from roi in associated PE

    """
    def memCpyROI(self, layerID):

        # Create a copy of all the ROI cells as these will be copied to each manager associated with the PE
        # we also want them in the list in the order of processing

        # what ROI does the PE need?
        # ROI's are stored as a start cell and end cell in {z,y,x}. If the assignment method is linearX, then start and end
        # are the top left and bottom right of a square ROI.
        # If its a linearAll assignment, then the ROI are the start and end of a contiguous list of cells

        roi = self.pe.getROI(layerID)
        xLen = roi[1][2]-roi[0][2]+1  
        yLen = roi[1][1]-roi[0][1]+1
        zLen = roi[1][0]-roi[0][0]+1

        # Get dimensions of previous layer which is where we get the ROI cells
        roiLayerZ = self.parentManagerArray.parentNetwork.Layers[layerID-1].Z
        roiLayerY = self.parentManagerArray.parentNetwork.Layers[layerID-1].Y
        roiLayerX = self.parentManagerArray.parentNetwork.Layers[layerID-1].X

        print '{0}:{1}:LEE:DEBUG:roi:{2}'.format(__FILE__(), __LINE__(), roi)
        absCellNumMax = roi[1][1]*roiLayerX*roiLayerZ + roi[1][2]*roiLayerZ + roi[1][0]
        absCellNumMin = roi[0][1]*roiLayerX*roiLayerZ + roi[0][2]*roiLayerZ + roi[0][0]
        print '{0}:{1}:LEE:DEBUG:roi cell range (abs):{2} <-> {3} '.format(__FILE__(), __LINE__(), absCellNumMax, absCellNumMin)

        # copy all features
        #zLen = roi[1][0]-roi[0][0]+1
        zLen = self.parentManagerArray.parentNetwork.Layers[layerID].Z
        
        roiLayerCells = []

        # FIXME: will PE always process all features at Y,X location
        for roiZ in range(self.parentManagerArray.parentNetwork.Layers[layerID-1].Z) :
          roiLayerCellsY = []
          for roiY in range(roi[0][1], roi[1][1]+1) :
            roiLayerCellsX = []
            for roiX in range(roi[0][2], roi[1][2]+1) :
              # Note: Just using copy using "from copy import copy" creates a numpy array?????
              #       had to use "from copy import copy as copy_copy"
              copiedCell = copy_copy(self.parentManagerArray.parentNetwork.Layers[layerID-1].cells[roiZ][roiY][roiX])

              # copied Cell will be in different memory location and we only did a shallow copy
              copiedCell.memoryLocation = MemoryLocation(None,0,0,0,0) # just provide dummy memory for now

              # Keep track of copies in original layer cell
              self.parentManagerArray.parentNetwork.Layers[layerID-1].cells[roiZ][roiY][roiX].copiedTo.append(copiedCell)
              roiLayerCellsX.append(copiedCell)
            roiLayerCellsY.append(roiLayerCellsX)
          roiLayerCells.append(roiLayerCellsY)

        self.roiCells[layerID] = roiLayerCells

        return roiLayerCells
    """

    def memCpyROI(self, layerID):

        # Create a copy of all the ROI cells as these will be copied to each manager associated with the PE
        # we also want them in the list in the order of processing

        # what ROI does the PE need?
        # ROI's are stored as a start cell and end cell in {z,y,x}. If the assignment method is linearX, then start and end
        # are the top left and bottom right of a square ROI.
        # If its a linearAll assignment, then the ROI are the start and end of a contiguous list of cells

        # Get dimensions of previous layer which is where we get the ROI cells
        roiLayerZ = self.parentManagerArray.parentNetwork.Layers[layerID-1].Z
        roiLayerY = self.parentManagerArray.parentNetwork.Layers[layerID-1].Y
        roiLayerX = self.parentManagerArray.parentNetwork.Layers[layerID-1].X

        # First create a list of pointers then remove duplicates
        roiLayerCellsList = []
        for pc in self.pe.cellsProcessed[layerID]:
            for sc in pc.sourceCells:
              # Add to list
              roiLayerCellsList.append(sc)
        # Remove duplicates
        tmp = set(roiLayerCellsList)
        roiLayerCellsList = list(tmp)

        roiLayerCells = []
        for sc in roiLayerCellsList:
            # Note: Just using copy using "from copy import copy" creates a numpy array?????
            #       had to use "from copy import copy as copy_copy"
            copiedCell = copy_copy(sc)
            # Temporarily add the absolute value of the cell to allow sorting
            # FIXME: absID is now one of the cell fields
            #copiedCell.absID = sc.ID[1]*roiLayerX*roiLayerZ + sc.ID[2]*roiLayerZ + sc.ID[0]
            # copied Cell will be in different manager and memory location and we only did a shallow copy
            copiedCell.managerLocation = self
            copiedCell.memoryLocation  = MemoryLocation(None,0,0,0,0) # just provide dummy memory for now

            # Keep track of copies in original layer cell
            sc.copiedTo.append(copiedCell)  # FIXME: need to clean

            roiLayerCells.append(copiedCell)
        
        # Now sort so at least they are in ascending order
        tmp = sorted(roiLayerCells, key=operator.attrgetter('absID'))
        roiLayerCells = tmp
        self.roiCells[layerID] = roiLayerCells

        return roiLayerCells


    #----------------------------------------------------------------------------------------------------
    # Memory assignment

    def allocateRoiMemory(self, layerID, allocateOptions):  
        # - after copying the ROI from the input array to the manager, they will be allocated a state memory location
        # We can create a DMA transfer from the ROI cell and the original cell
        # 
        # Keep copy of starting and ending allocate options
        # if the method is being given the memories existing allocationOptions, then just use existng
        # if its a new option, then overwite
        self.memoryROIallocationOptions[layerID]       = copy_copy(allocateOptions)  # we will need to order of allocation for WU creation
        try :
            if self.currentMemoryAllocationOptions != allocateOptions :
                self.initialMemoryAllocationOptions    = copy_copy(allocateOptions)
                self.currentMemoryAllocationOptions    = copy_copy(self.initialMemoryAllocationOptions)
            else :
                self.initialMemoryAllocationOptions    = copy_copy(self.currentMemoryAllocationOptions)
        except:
            # this must be the first time we are allocating memory
            self.initialMemoryAllocationOptions    = copy_copy(allocateOptions)
            self.currentMemoryAllocationOptions    = copy_copy(self.initialMemoryAllocationOptions)

        # if the number of features is not radix-2, do we pad features to align radix-2
        numOfFeatures = self.parentManagerArray.parentNetwork.Layers[layerID-1].Z

        if not isinstance(self.roiCells[layerID],list):
            self.roiCells[layerID]
            print '{0}:{1}:WARNING:roi cell array doesnt yet exist, copy from main memory'.format(__FILE__(), __LINE__())
            self.memCpyROI(layerID)


        for rc in self.roiCells[layerID]:
              rc.memoryLocation.memory  = self.memory
              rc.memoryLocation.channel = int(self.currentMemoryAllocationOptions.channel)
              rc.memoryLocation.bank    = int(self.currentMemoryAllocationOptions.bank)
              rc.memoryLocation.page    = int(self.currentMemoryAllocationOptions.page)
              rc.memoryLocation.word    = int(self.currentMemoryAllocationOptions.word)
              # add entry to memory
              memLocnOption = memoryLocationAccessOptions(allowOverWrite=False)
              rv = self.memory.addEntry(rc.memoryLocation, None, memLocnOption )
              
              self.currentMemoryAllocationOptions.increment(self.memory, numOfFeatures)
              
        # Return a memory option object that uses the increment options from the input options object but
        # sets the initial values from the last channel, bank, page and word used during this allocation

        # return options which is the next location that would have been used
        return self.currentMemoryAllocationOptions
        

    #----------------------------------------------------------------------------------------------------
    def groupCells(self, layerID):

        # Form groups with the same ROI.
        # The groups will be used to allocate kernel locations
        # start with cell 0 and form a group
        # When the group is full, set the next cell as firstCell and create a new group
        # Stop when we reach the last cell in the layer

        # Make sure we havent run it already
        if self.cellGroups[layerID].__len__() == 0 :

            # we use cell 0,0,0 as first cell so start looking at 1,0,0
            cCnt = 0
            numOfCells = self.pe.cellsProcessed[layerID].__len__()
            while cCnt < numOfCells :
                # Create the coords of the cell
                #print '{0}:{1}:new group at {2}'.format(__FILE__(), __LINE__(), cCnt)
                firstCell = self.pe.cellsProcessed[layerID][cCnt]
                group = []
                group.append(firstCell)
       
                groupCount = 1 # already first cell is on group
                groupComplete = False
                cCnt      += 1
                # make sure the last cell in the list isnt in its own group
                if cCnt == numOfCells:
                    groupComplete = True
       
                while not groupComplete:
                    # Get next cell
                    c = self.pe.cellsProcessed[layerID][cCnt]
                    # test if cell has same ROI as current group
                    # FIXME: will assume for now that the kernel operation needs to be the same across the group
                    if ((firstCell.sourceCells == c.sourceCells) and (firstCell.stOpOperation == c.stOpOperation)) :
                        group.append(c)
                        groupCount += 1
                    else:
                        # different ROI
                        groupComplete = True
                        # we have to use this cell as the first cell of the next group
                        cCnt      -= 1 
       
                    if groupCount == NUMOFEXECLANES:
                        groupComplete = True
       
                    cCnt      += 1
       
                    if cCnt == numOfCells:
                        groupComplete = True
       
                self.cellGroups[layerID].append(group)
        else:
            print '{0}:{1}:Layer {2} cell grouping already run???'.format(__FILE__(), __LINE__(), layerID)

    def allocateGroupMemory(self, layerID, allocateOptions):  

        # Take a group and assign each cells kernel to a lane in a page.
        # Each page has enough words for two arguments and 32 lanes = 2048 bits
        # The ROI will be fanned out from one page to all lanes and the kernel page will be read
        # and each word sent to each lane with words arranged in the page as: Word(lane,kernelWord)
        # word(0,0), word(1,0) ... word(31,0), word(0,1) .. word(31,1)
        self.memoryKernelAllocationOptions[layerID] = copy_copy(allocateOptions)  # how memory was assigned to group kernels
        pass
        # Get kernel dimensions from first cell in the group
        memLocnOption = memoryLocationAccessOptions(allowOverWrite=False)
        for g in self.cellGroups[layerID] :
            kernelDimension = g[0].kernel.dimensions
            #print kernelDimension
            for Ky in range(kernelDimension[1]) :
                for Kx in range(kernelDimension[2]) :
                    for Kz in range(kernelDimension[0]) :
                        for c in g :
                            c.kernel.memoryLocations[Kz][Ky][Kx].memory  = self.memory
                            c.kernel.memoryLocations[Kz][Ky][Kx].channel = allocateOptions.channel
                            c.kernel.memoryLocations[Kz][Ky][Kx].bank    = allocateOptions.bank
                            c.kernel.memoryLocations[Kz][Ky][Kx].page    = allocateOptions.page
                            c.kernel.memoryLocations[Kz][Ky][Kx].word    = allocateOptions.word
                            rv = self.memory.addEntry(c.kernel.memoryLocations[Kz][Ky][Kx], None, memLocnOption )
                            allocateOptions.increment(self.memory, self.memory.configuration.sizeOfPage/WORDSIZE)
                        # 
                        #allocateOptions.increment(self.memory, self.memory.configuration.sizeOfPage/WORDSIZE)

        return allocateOptions


    #----------------------------------------------------------------------------------------------------
    def printRoiMemoryAllocation(self, layerID):
        pLine = '\n'
        pLine = pLine + '\nManager:{0},{1} ROI Memory Contents                     '.format(self.ID[0], self.ID[1])
        pLine = pLine + '\n       Location               Original Cell         '
        pLine = pLine + '\n Channel  Bank  Page  Word  |   Z   Y   X           '
        pLine = pLine + '\n-------------------------------------------------------'
        for rc in self.roiCells[layerID]:
            pLine = pLine + '\n {3:^7}  {4:^4}  {5:^4}  {6:^4}  |  {0:^3} {1:^3} {2:^3}  '.format(rc.ID[0], rc.ID[1], rc.ID[2], rc.memoryLocation.channel, rc.memoryLocation.bank, rc.memoryLocation.page, rc.memoryLocation.word)
        return pLine
        

    def createRoiMemoryAllocationFile(self, layerID):

        #timeStr = time.strftime("%Y%m%d-%H%M%S")
        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'manager_{0}_{1}/'.format(self.ID[0], self.ID[1])
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        outFile = dirStr + 'manager_{0}_{1}_layer{2}_ROImemoryAllocation.txt'.format(self.ID[0], self.ID[1], layerID)

        oFile = open(outFile, 'w')

        pLine = self.printRoiMemoryAllocation(layerID)

        oFile.write(pLine)
        oFile.close()


    def printAllGroupMemory(self, layerID, group):
  
        # Create an array with a column showing the ROI address and additional columns for each cell in the group
        # and its kernel addresses
        # Also include where the result of the cell activation needs to be written

        # Create the fromMemoryStr array containing destination Manager/PE and local address within that manager
        fromMemoryStr     = [[]]  # first column is ROI address
        for i in range(self.cellGroups[layerID][group].__len__()): 
            fromMemoryStr.append([])     # add column for each cell in the group

        # Create the toMemoryStr array
        # make it the same dimensions as the fromMemoryStr but the ROI column will remain blank
        toMemoryStr     = [[]]  # first column is a dummy
        for i in range(self.cellGroups[layerID][group].__len__()): 
            # add column for each cell in the group to contain the destination address once the cell activation is complete
            toMemoryStr.append([])     
                         
        # Find the cell with the maximum number of destination PE's (should be the same as group most likely contains same {y,x} but different features)
        numOfCopiedToPeMax = 0
        for gc in self.cellGroups[layerID][group]:
            numOfCopiedToPe = gc.originalCell.copiedTo.__len__()
            if numOfCopiedToPeMax < numOfCopiedToPe :
                numOfCopiedToPeMax = numOfCopiedToPe 

        # Populate the toMemoryStr array
        idx = 1
        for gc in self.cellGroups[layerID][group] :
            copiedToMemory = gc.originalCell.printCopiedToMemory().split('\n')
            startAdding = False
            for str in copiedToMemory :
                if '--' in str:
                    startAdding = True
                if startAdding :
                  if not '--' in str:
                    toMemoryStr[idx].append(str)
            idx += 1


        # get the ROI of the first cell in the group (they are all the same) and print
        # Then get the memory for all the cells kernels and concatenate in one file
        
        try:
            firstCell = self.cellGroups[layerID][group][0]
        except:
            print '{0}:{1}:ERROR:Manager {2},{3}:Layer {4}:No group {5}??'.format(__FILE__(), __LINE__(), self.ID[0], self.ID[1], layerID, group)
            raise

        roiMemory    = firstCell.printROIcells().split('\n')

        # remove just the data
        startAdding = False
        for str in roiMemory :
            if '--' in str:
                startAdding = True
            if startAdding :
              if not '--' in str:
                fromMemoryStr[0].append(str)

        idx = 1
        for gc in self.cellGroups[layerID][group]:
            kernelMemory = gc.printKernelMemory().split('\n')
            startAdding = False
            for str in kernelMemory :
                if '--' in str:
                    startAdding = True
                if startAdding :
                  if not '--' in str:
                    fromMemoryStr[idx].append(str)
            idx += 1

        pLine = '\n                                              '
        for gc in self.cellGroups[layerID][group]:
            pLine = pLine + '|    Target Cell {{z,y,x}} {0:>3},{1:>3},{2:>3}      '.format(gc.ID[0], gc.ID[1], gc.ID[2])
        pLine = pLine + '|'
        pLine = pLine + '\n                                              |'
        for col in range(1,idx) :
            pLine = pLine + '                                         |'
        pLine = pLine + '\n                                              '
        for gc in self.cellGroups[layerID][group]:
            pLine = pLine + '|           Destination(s)                '
        pLine = pLine + '|'
        pLine = pLine + '\n                                              |'
        for cell in range(1,idx) :
            pLine = pLine + '  Manager  Channel  Bank  Page  Word     |'
        for row in range(numOfCopiedToPeMax) :
            pLine = pLine + '\n                                              |'
            for col in range(1,idx) :
                pLine = pLine + '{0} |'.format(toMemoryStr[col][row])
        pLine = pLine + '\n                                              |'
        for col in range(1,idx) :
            pLine = pLine + '                                         |'

        pLine = pLine + '\n source cell   |     ROI Local memory         '
        for gc in self.cellGroups[layerID][group]:
            pLine = pLine + '|                 Kernel Memory           '.format(gc.ID[1], gc.ID[2], gc.ID[0])
        pLine = pLine + '|'
        pLine = pLine + '\n Z   Y   X     | Channel  Bank  Page  Word    '
        for cell in range(1,idx) :
            pLine = pLine + '|           Channel  Bank  Page  Word     '
        pLine = pLine + '|'
        pLine = pLine + '\n-------------------------------------------'
        for cell in range(1,idx) :
            pLine = pLine + '--------------------------------------------'
        for row in range(fromMemoryStr[0].__len__()):
            pLine = pLine + '\n{0} | '.format(fromMemoryStr[0][row])
            for col in range(1,idx) :
                pLine = pLine + '          {0} | '.format(fromMemoryStr[col][row])
        return pLine

    def createAllGroupMemoryFile(self, layerID, group):

        timeStr = time.strftime("%Y%m%d")  # just today
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + 'manager_{0}_{1}/'.format(self.ID[0], self.ID[1])
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        outFile = dirStr + 'manager_{0}_{1}_layer{2}_group_{3}_AllGroupMemory.txt'.format(self.ID[0], self.ID[1], layerID, group)

        oFile = open(outFile, 'w')

        pLine = self.printAllGroupMemory(layerID, group)
        
        oFile.write(pLine)
        oFile.close()
  

########################################################################################################################
#----------------------------------------------------------------------------------------------------
# NETWORK

class Network():

    def __init__(self, peY=8, peX=8, maxNumberOfLayers=10):
        self.numberOfLayers = 0
        self.maxNumberOfLayers = maxNumberOfLayers
        self.Layers = []
        self.peY = peY
        self.peX = peX
        #self.peArray = PEarray(self, peY, peX, self.maxNumberOfLayers)

        # Save network configuration
        dirStr = './outputFiles/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        dirStr = dirStr + timeStr + '/'
        if not os.path.exists(dirStr) :
            os.makedirs(dirStr)
        outFile = dirStr + 'network_configuration.txt'
        oFile = open(outFile, 'w')
        pLine = '# Configuration'
        pLine = pLine + '\narrayY:{0}'.format(self.peY)
        pLine = pLine + '\narrayX:{0}'.format(self.peX)
        oFile.write(pLine)
        oFile.close()

    #----------------------------------------------------------------------------------------------------
    # print

    def __str__(self):
        pLine = ""
        pLine = pLine + '\nNetwork       '
        pLine = pLine + '\nLayers:{0}    '.format(self.numberOfLayers)
        pLine = pLine + '\nMethods: {0}  '.format(methods(self))
        pLine = pLine + '\nFields: {0}   '.format(fields(self))
        return pLine
        
    #----------------------------------------------------------------------------------------------------

    def addLayer(self, type, X, Y, Z, Kx=0, Ky=0, Kz=0, stride=0):
        if self.numberOfLayers != self.maxNumberOfLayers:
            layer = Layer(self, self.numberOfLayers, type, X, Y, Z, Kx, Ky, Kz, stride)
            self.Layers.append(layer)
            self.numberOfLayers += 1
        else:
            print '**** CANNOT exceed ', self.maxNumberOfLayers, ' layers ****'

    def getLayer(self, l):
        return self.Layers[l]

    def assignPEs(self, cellAssignType):
        #----------------------------------------------------------------------------------------------------
        # create PE Array
        # First build PE then later associate a manager with each PE

        # a) PE's
        self.peArray = PEarray(self, self.peY, self.peX, self.numberOfLayers)
        # assign PE's to each cell of each layer
        for l in self.Layers:
            l.assignPEs(self.peX,self.peY, cellAssignType)
            #l.calculateKernelOffset()

    def assignManagers(self, memoryType):
        #----------------------------------------------------------------------------------------------------
        # create Manager and PE Array
        # First build PE then associate a manager with each PE

        # b) Manager's
        self.managerArray = ManagerArray(self, self.peY, self.peX, self.numberOfLayers, memoryType)

    def updateSourceCellsTargetList(self):
        for l in self.Layers:
            if l.layerID != 0:
                l.updateSourceCellsTargetList()

    def getNumberOfCells(self, internal=1):
        totalNumberOfInternalCells = 0
        totalNumberOfCells = 0
        for l in self.Layers:
            totalNumberOfCells += l.getNumberOfCells()
            if l.layerID > 0 :
                totalNumberOfInternalCells += l.getNumberOfCells()
        if internal == 1 :
            return totalNumberOfInternalCells
        else :
            return totalNumberOfCells
      
    def getNumberOfParameters(self):
        totalNumberOfParameters = 0
        for l in self.Layers :
            if l.layerID > 0 :
                totalNumberOfParameters += l.getNumberOfParameters()
        return totalNumberOfParameters
      
    def getNumberOfAdditions(self):
        totalNumberOfAdditions = 0
        for l in self.Layers :
            if l.layerID > 0 :
                totalNumberOfAdditions += l.getNumberOfAdditions()
        return totalNumberOfAdditions
      
    def getNumberOfMultiplies(self):
        totalNumberOfMultiplies = 0
        for l in self.Layers :
            if llayerID > 0 :
                totalNumberOfMultiplies += l.getNumberOfMultiplies()
        return totalNumberOfMultiplies
      

    def displayPeAssignments(self):
        for l in self.Layers:
            print 'Layer ', l.layerID
            l.displayPeAssignments()
            
    def displayTargetPEs(self):
        for l in self.Layers:
            print 'Target PEs for Layer ', l.layerID
            l.displayTargetPEs()
            
    def displayTargetCells(self):
        for l in self.Layers:
            print 'Target cells for Layer ', l.layerID
            l.displayTargetCells()
            
    def displaySourcePEs(self):
        for l in self.Layers:
            print 'Source PEs for Layer ', l.layerID
            l.displaySourcePEs()
            
    def displaySourceCells(self, layerID=[], cellCoords=[]):
        if not layerID:
            for l in self.Layers:
                print 'Source cells for Layer ', l.layerID
                l.displaySourceCells()
        else:
            if len(cellCoords) == 0:
                print 'Source cells for Layer ', layerID
                self.Layers[layerID].displaySourceCells()
            else:
                print 'Source cells for Layer ', layerID
                self.Layers[layerID].displaySourceCells(cellCoords)
            
    def getSourceCells(self, layerID, cellCoords):
        return self.Layers[layerID].getSourceCells(cellCoords)
            
    def getTargetCells(self, layerID, cellCoords):
        return self.Layers[layerID].getTargetCells(cellCoords)
            
    def getSourcePEs(self, layerID, cellCoords):
        return self.Layers[layerID].getSourcePEs(cellCoords)
            
    def getTargetPEs(self, layerID, cellCoords):
        return self.Layers[layerID].getTargetPEs(cellCoords)
            
    def displayCellsPerLayer(self):
        totalNumberOfInternalCells = 0
        totalNumberOfCells = 0
        for l in range(self.numberOfLayers):
            self.Layers[l].displayNumberOfCells()
            totalNumberOfCells += self.Layers[l].getNumberOfCells()
            if l > 0 :
                totalNumberOfInternalCells += self.Layers[l].getNumberOfCells()
        print 'Total number of cells is ', totalNumberOfCells
        print 'Total number of internal cells is ', totalNumberOfInternalCells
      

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

    import dnnConnectivityAndMemoryAllocation as dc
    import numpy as np
    
    #------------------------------------------------------------------------------------------------------------------------
    # Create main system memory
    # In practice, this holds the input image. Portions of the input image are transferred to each Manager/PE based on aggregating
    # the ROI of each cell processed by the manager/PE 
    mainMemoryConfig = dc.MemoryConfiguration(numOfChannels=2,numOfBanksPerChannel=32,numOfPagesPerBank=128,sizeOfPage=4096)
    mainMemory = dc.Memory(mainMemoryConfig)
    
    #------------------------------------------------------------------------------------------------------------------------
    #------------------------------------------------------------------------------------------------------------------------
    # Create DNN

    #------------------------------------------------------------------------------------------------------------------------
    # Create Network

    # This only creates a network class with a few empty fields such as number of layers
    # The number of PE's are defaulted to 8x8 (peY=8, peX=8). These can be changed by providing values in the arguments.
    # No objects
    network = dc.Network()

    #------------------------------------------------------------------------------------------------------------------------
    # Create Layers

    # We now add layers. For each layer added, create an array of cell objects.
    # The dimensions of the Layers cells are stored in three sets of z,y,x fields
    #   Z,Y,X                              : this is the dimension of the cell array after it has been padded to accomodate the dimensiosn and stride of the next layer
    #   origZ,origY,origX                  : this is the original dimension of the cell array prior to padding
    #   origZrange, origYrange, origXrange : a list of indexes of "real" cells within the padded array

    # For alllayers except zero, the previous layer is checked to see if the kernels fit exactly into the previous layers array of cells.
    # If it doesnt fit, it pads the previous layer by adding dummy cells.
    # Each cell has a z,y,x ID and an absolute ID starting from 0,0,0.
    # Each cell has a memory location which is initialized to null and a kernel with an array of null memory locations based on the dimensions of the kernel
    #                                    X    Y    Z    Kx   Ky   Kz   stride
    #network.addLayer('Input',          224, 224,    3                       ) #    3 First layer does not have a kernel
    #network.addLayer('Convolutional',   55,  55,   96,   11,  11,    3,   4 ) #   96,
    #network.addLayer('Convolutional',   27,  27,  256,    5,   5,   96,   2 ) #  256,
    #network.addLayer('Convolutional',   13,  13,  384,    3,   3,  256,   2 ) #  384,
    #network.addLayer('Convolutional',   13,  13,  384,    3,   3,  384,   1 ) #  384,
    #network.addLayer('Fully Connected', 13,  13,  256,    3,   3,  384,   1 ) #  256,
    #network.addLayer('Fully Connected',  1,   1, 4096,   13,  13,  256,   1 ) # 4096,
    #network.addLayer('Fully Connected',  1,   1, 4096,    1,   1, 4096,   1 ) # 4096,
    #network.addLayer('Fully Connected',  1,   1, 1024,    1,   1, 4096,   1 ) # 1024,
    
    # Small
    network.addLayer('Input',           55,  55,    4,                      ) #   96,
    network.addLayer('Convolutional',   27,  27,   4,    5,   5,    4,   2 ) #  256,
    network.addLayer('Convolutional',   13,  13,  8,    3,   3,   4,   2 ) #  384,
    network.addLayer('Convolutional',   13,  13,  4,    3,   3,   8,   1 ) #  384,
    
    # FC-7
    #network.addLayer('Input',         4096,    1,    1,                      ) #   96,
    #network.addLayer('Convolutional', 4096,    1,    1, 4096,   1,    1,   0 ) #  256,
    #network.addLayer('Convolutional', 1024,    1,    1, 4096,   1,    1,   0 ) #  384,
    
    #network.addLayer('Input',           55,  55,    3,                      ) #   96,
    #network.addLayer('Convolutional',   27,  27,  128,    5,   5,    3,   2 ) #  256,
    #network.addLayer('Convolutional',   13,  13,   64,    3,   3,  128,   2 ) #  384,
    #network.addLayer('Convolutional',   13,  13,   32,    3,   3,   64,   1 ) #  384,
    #network.addLayer('Convolutional',   13,  13,   64,    3,   3,   32,   1 ) #  384,
    #
    
    
    #------------------------------------------------------------------------------------------------------------------------
    # Create PEs and assign cells for each layer

    # Create processing engines and assign each layers cell to the array of PEs
    # Creates an array of PE objects based on peY and peX.
    # For each layer, assigns a PE to process each cell in that layer. Each PE has a cellsProcessed list. When assigning, padded dummy cells are ignored.
    print '{0}:{1}:Assign PEs:'.format(__FILE__(), __LINE__())
    network.assignPEs('linearAll')


    #------------------------------------------------------------------------------------------------------------------------
    # Create Managers 

    # Create Managers with memory and assign array memory type
    # Will contain a roiCells list which is a list of cells that are used as input to the PE associated with the manager.
    # Will contain a cellGroups list which is a list of cells processed by the associated PE that share a common ROI

    print '{0}:{1}:Assign Managers:'.format(__FILE__(), __LINE__())
    #mgrMemoryConfig = dc.MemoryConfiguration(numOfChannels=2,numOfBanksPerChannel=32,numOfPagesPerBank=4096,sizeOfPage=4096)
    mgrMemoryConfig = dc.MemoryConfiguration(numOfChannels=2,numOfBanksPerChannel=32,numOfPagesPerBank=128,sizeOfPage=4096)
    network.assignManagers(mgrMemoryConfig)
    
    
    #------------------------------------------------------------------------------------------------------------------------
    # Create connections

    # parses each "real" cell in the layer and updates fields
    #   all the cells that connect to the "real" cell have their targetPE and targetCells lists update
    #   the "real" cells sourceCell and sourcePE lists are updated with the list of source cells and the PE's that contain the source cells state
    #   any lists of cells are sorted by their absolute ID

    for l in range(1, network.numberOfLayers):
      print '{0}:{1}:Generate connections for layer {2}:'.format(__FILE__(), __LINE__(), l)
      network.Layers[l].generateConnections()
    
    

    #------------------------------------------------------------------------------------------------------------------------
    #  at this point the network contains all connection information
    #------------------------------------------------------------------------------------------------------------------------




    #------------------------------------------------------------------------------------------------------------------------
    # DMA main to local memory


    #----------------------------------------------------------------
    # 1) Make copies of the ROI cells 

    # For each cell processed in a manager, make a copy of the cell and place in the managers roiCells[<layer>] list
    # This simply makes copies of the cells, the actual memory locations are performed later by allocateRoiMemory

    for mgrY in range(network.managerArray.Y):
        for mgrX in range(network.managerArray.X):
            print '{0}:{1}:Mem cpy ROI for manager {2},{3}'.format(__FILE__(), __LINE__(), mgrY, mgrX)
            for l in range(1, network.numberOfLayers):

                # Copy aggregate ROI from main memory to local manager memory
                rv = network.managerArray.manager[mgrY][mgrX].memCpyROI(l)



    #----------------------------------------------------------------
    # 2) ROI cell Memory Assignment

    # For each ROI in a manager, assign a memory location 
    #    - parse the sorted roiCells list
    #    - assignment is based on some memory allocation options 
    #      e.g. typcally for ROI, we are placing each cell in consequitve words as these are broadcast to a list of grouped cells

    # 2)a)
    # Create an array of options as a start point for each managers memory ROI allocation

    # as we allocate memory for a layer ROI copied from main memory, the allocate memory routine will return the next memory location avaliable
    # this will be the start point for the next layers memoryAllocation
    peMemoryAllocationOptions = dc.MemoryAllocationOptions( order             = ['c', 'w', 'b', 'p'],
                                                            channel           =  0                  , 
                                                            channelIncrement  =  1                  , 
                                                            bank              =  0                  , 
                                                            bankIncrement     =  2                  , 
                                                            page              =  0                  , 
                                                            pageIncrement     =  1                  , 
                                                            word              =  0                  , 
                                                            wordIncrement     =  1                  , 
                                                            padWordRadix2     = False                )

    ROIlastMemory = dict() # key will be (layer, mgrY, mgrX)
    for mgrY in range(network.managerArray.Y):
        for mgrX in range(network.managerArray.X):
            mgrMemOptions = copy_copy(peMemoryAllocationOptions)
            ROIlastMemory[(mgrY, mgrX)] = mgrMemOptions 


    # 2)b) Assign the managers list of roi cells to a memory location based on the parameters in ROIlastMemory[<mgrY>][<mgrX>]

    for mgrY in range(network.managerArray.Y):
        for mgrX in range(network.managerArray.X):
            print '{0}:{1}:ROI memory allocations for manager {2},{3}'.format(__FILE__(), __LINE__(), mgrY, mgrX)
            for l in range(1, network.numberOfLayers):

                # Copy aggregate ROI from main memory to local manager memory
                #rv = network.managerArray.manager[mgrY][mgrX].memCpyROI(l)

                ROIlastMemory[(mgrY, mgrX)] = network.managerArray.manager[mgrY][mgrX].allocateRoiMemory(l, ROIlastMemory[(mgrY, mgrX)])

                    

    #------------------------------------------------------------------------------------------------------------------------
    # Kernel Manager memory assignments

    # Use the memory configuration used during ROI memory assignment
    #  - kernels are stored on a lane basis, so change the memory assignment to increment word by 32
    #    and word increment first in order
    #  - do not store on radix2 alignment
    #  - First create groups of cells that share the same ROI.
    #    Then store each kernel ofset in the page by the cell number in the group
    # 

    for mgrY in range(network.managerArray.Y):
        for mgrX in range(network.managerArray.X):
            print '{0}:{1}:Kernel memory allocations for manager {2},{3}'.format(__FILE__(), __LINE__(), mgrY, mgrX)
            for l in range(1, network.numberOfLayers):
                # Take last memory location from ROI assignment
                kernelMemoryAllocationOptions = ROIlastMemory[(mgrY, mgrX)]
                kernelMemoryAllocationOptions.order         = ['w', 'c', 'b', 'p']
                kernelMemoryAllocationOptions.padWordRadix2 = False
                # Start on a page boundary
                kernelMemoryAllocationOptions.ceilingField(network.managerArray.manager[mgrY][mgrX].memory, 0, 'word')
                ROIlastMemory[(mgrY, mgrX)] = network.managerArray.manager[mgrY][mgrX].groupCells(l)
                ROIlastMemory[(mgrY, mgrX)] = network.managerArray.manager[mgrY][mgrX].allocateGroupMemory(l, kernelMemoryAllocationOptions)




    #------------------------------------------------------------------------------------------------------------------------
    #  at this point the states of each cell in the layers are assigned in menmory along with each cells Kernel weights
    #------------------------------------------------------------------------------------------------------------------------


    #------------------------------------------------------------------------------------------------------------------------
    # File Creation

    if CREATEFILES :
        # Note:Last array hasnt been copied beccause there is no next layer ROI, so expected WARNINGS
        for l in range(1, network.numberOfLayers):
            for mgrY in range(network.managerArray.Y):
                for mgrX in range(network.managerArray.X):
                    for grp in range(network.managerArray.manager[mgrY][mgrX].cellGroups[l].__len__()):
                        network.managerArray.manager[mgrY][mgrX].createAllGroupMemoryFile(l,grp)

    if CREATEFILES :
        # For a
        pYmin = 0  # .1
        pYmax = 1  # .3
        pXmin = 0  # .1
        pXmax = 1  # .3
        print '{0}:{1}:Create memory locations for layer {2}'.format(__FILE__(), __LINE__(), l)
        for y in   range(int(network.Layers[l].Y*pYmin), int(network.Layers[l].Y*pYmax)) :
          for x in range(int(network.Layers[l].X*pXmin), int(network.Layers[l].X*pXmax)) :
            for z in range(network.Layers[l].Z) :

                #print '{0}:{1}:Create ROI memory locations for layer {2}, cell {3},{4},{5}'.format(__FILE__(), __LINE__(), l, z, y, x)
                network.Layers[l].cells[z][y][x].createROIcellsFile()

                # create a file that contains the memory location and the source cell ID of all the cells in the entire ROI of the manager/PE
                # Uses the managers roiCells[<layer>] list
                network.managerArray.manager[mgrY][mgrX].createRoiMemoryAllocationFile(l)

    if CREATEFILES :
        print '{0}:{1}:INFO:Create Work Unit files'.format(__FILE__(), __LINE__(), l)
        # Do layer 1 only for now
        for l in [1] :
            for mgrY in range(network.managerArray.Y):
                for mgrX in range(network.managerArray.X):
                    print '{0}:{1}:INFO:Create Work Unit files for manager {2},{3} layer {4}'.format(__FILE__(), __LINE__(), mgrY, mgrX, l)
                    network.managerArray.manager[mgrY][mgrX].createWUfiles(l)
        # Create WU's for all managers before creating storage descriptor files because managers create descriptors in other managers
        for l in [1] :
            for mgrY in range(network.managerArray.Y):
                for mgrX in range(network.managerArray.X):
                    print '{0}:{1}:INFO:Create Work Unit files for manager {2},{3} layer {4}'.format(__FILE__(), __LINE__(), mgrY, mgrX, l)
                    network.managerArray.manager[mgrY][mgrX].createStorageDescriptorFiles(l)

    #------------------------------------------------------------------------------------------------------------------------
    # Checks

    # anything to make sure the code works
    if RUNCHECKS :
        print '{0}:{1}:INFO:RUNCHECKS'.format(__FILE__(), __LINE__(), l)
        # Make sure all cells are assigned to a group
        # Create a list from all the groups then test if each original cell is in the group
        # Also make sure dummy cells are NOT in a group
        layerID = 1
        l = layerID
        for l in range(1, network.numberOfLayers):
            print '{0}:{1}:INFO:Layer {2}:Making sure no dummy, duplicates or missing cells in the groups'.format(__FILE__(), __LINE__(), l)
            #cntGroupCells = 0
            aggregateGroup = []
            for mgrY in range(network.managerArray.Y):
                for mgrX in range(network.managerArray.X):
                    for grp in network.managerArray.manager[mgrY][mgrX].cellGroups[l]:
                        aggregateGroup = aggregateGroup + grp
                        #cntGroupCells += grp.__len__()
            #print cntGroupCells
            # Create a list of original cells
            aggOrigCellList = []
            for cc in aggregateGroup :
                aggOrigCellList.append(cc)
            layerCells = network.Layers[l].cells
            cellCount = 0
            for z in range(layerCells.__len__()):
                for y in range(layerCells[0].__len__()):
                    for c in layerCells[z][y] :
                        cellCount += 1
                        cellInList = c in aggregateGroup
                        if c.dummy and cellInList:
                            print '{0}:{1}:ERROR:layer {2} dummy cell {3},{4},{5} in a cell group'.format(__FILE__(), __LINE__(), l, y,x,z)
                        if (not c.dummy) and (not cellInList):
                            print '{0}:{1}:ERROR:layer {2} real cell {3},{4},{5} not in a cell group'.format(__FILE__(), __LINE__(), l, y,x,z)
            # make sure there arent duplicates in the groups
            #print cellCount
            numCells = aggOrigCellList.__len__()
            tmp = set(aggOrigCellList)
            aggOrigCellList = list(tmp)
            if (numCells != aggOrigCellList.__len__()) and (numCells !=  network.Layers[l].origZ*network.Layers[l].origY*network.Layers[l].origX)  :
                 expectedCellCount = network.Layers[l].origZ*network.Layers[l].origY*network.Layers[l].origX
                 print '{0}:{1}:ERROR:layer {2} : {3} duplicate cells in groups totalling {4} that should total {5} '.format(__FILE__(), __LINE__(), l, numCells-aggOrigCellList.__len__(), numCells, network.Layers[l].origZ*network.Layers[l].origY*network.Layers[l].origX)


    #------------------------------------------------------------------------------------------------------------------------
    # Misc

    # Plots

    if CREATEANIMATION :
        for l in range(1, network.numberOfLayers):
            network.peArray.createProcessedCellsAnimation(l, dc.displayOptions(pplot=True, pprint=False, createFile=False))  
            plt.show()
            network.peArray.createROIAnimation(l, dc.displayOptions(pplot=True, pprint=False, createFile=False)) 
            plt.show()
    

    print '{0}:{1}:END:'.format(__FILE__(), __LINE__())

    #------------------------------------------------------------------------------------------------------------------------
    # End main()
    #------------------------------------------------------------------------------------------------------------------------

    
if __name__ == "__main__":main()
    

"""
for y in range(8):
  for x in range(8):
    for lcg in network.managerArray.manager[y][x].cellGroups:
      for cg in lcg:
        print cg.__len__()
"""

"""
# In[33]:

peX = 0
peY = 0
layerID = 1
#print network.peArray.pe[peY][peX].roi[layerID]
#for l in range(1, network.numberOfLayers):
#  network.peArray.pe[peY][peX].getROI(l)
#  network.peArray.pe[peY][peX].displayROIgrid(l)
#  plt.show()

#------------------------------------------------------------------------------------------------------------------------
# 

for l in range(1, network.numberOfLayers):
    print '{0}:{1}:Determine ROI for layer {2}:'.format(__FILE__(), __LINE__(), l)
    network.peArray.findROIall(l)
    # Form groups with the same ROI.
    # The groups will be used to allocate kernel locations  

if CREATEANIMATION :
    for l in range(1, network.numberOfLayers):
        network.peArray.createProcessedCellsAnimation(l, dc.displayOptions())
        plt.show()
        network.peArray.createROIAnimation(l, dc.displayOptions())
        plt.show()

peMemoryAllocationOptions = dc.MemoryAllocationOptions( order             = ['c', 'w', 'b', 'p'],
                                                        channel           =  0                  , 
                                                        channelIncrement  =  1                  , 
                                                        bank              =  0                  , 
                                                        bankIncrement     =  2                  , 
                                                        page              =  0                  , 
                                                        pageIncrement     =  1                  , 
                                                        word              =  0                  , 
                                                        wordIncrement     =  1                  , 
                                                        padWordRadix2     = True                )

"""

"""
kernelMemoryAllocationOptions = peMemoryAllocationOptions 
kernelMemoryAllocationOptions.order         = ['w', 'c', 'b', 'p']
kernelMemoryAllocationOptions.padWordRadix2 = False
"""
"""
for y in range(1):
  for x in range(4):
    for z in range(3):
      p = network.Layers[1].cells[z][y][x].printKernelMemory()
      print p
"""
"""
for z in range(32):
    network.Layers[1].cells[z][0][0].createAllMemoryFile()
"""



##----------------------------------------------------------------------------------------------------
##----------------------------------------------------------------------------------------------------
##              HELP
##----------------------------------------------------------------------------------------------------
##----------------------------------------------------------------------------------------------------
"""
import dnnConnectivityAndMemoryAllocation as dc
"""
"""
print 'file = {0}, line = {1}'.format(__FILE__(), __LINE__())
"""
    
"""
import numpy as np
import math
import sys
import os
import copy
from copy import deepcopy
from copy import copy as copy_copy
from collections import namedtuple
from rcdtype import *
# Plotting
# 
import matplotlib.pyplot as plt
import matplotlib.animation as manimation
from pylab import *
from matplotlib.colors import BoundaryNorm
from matplotlib.ticker import MaxNLocator


def test_update_plot(frame_number):
    cp_info['position'][::1, 0] = x
    cp_info['position'][::1, 1] = y
    cp_info['size'    ]       = pt_scale*c[frame_number]
    scat.set_sizes(cp_info['size'])
    scat.set_offsets(cp_info['position'])


numframes = 10
num_pts = 20
y = linspace(0,18,num=num_pts)
x = range(num_pts)
c = np.random.random((numframes, num_pts))
 

cp_info = np.zeros(num_pts, dtype=[('position', float, 2   ),  \
                                   ('size'    , int, 1   ),  \
                                   ('color'   , float, 4 )])  
cp_info['position'][:, 0] = y
cp_info['position'][:, 1] = x
pt_scale =  10.0*(math.log((30000.0/num_pts),10))  # s=10 seemed right when there were 3000 point (e.g. 55x55 array)
cp_info['size'    ]       = pt_scale*c[0]

xLim = num_pts +1
yLim = num_pts +1
fig = plt.figure(figsize=(7, 7))
ax = fig.add_axes([0.05, 0.05, 0.9, 0.9], frameon=False) # r,l,w,h
#ax = fig.add_axes([0, 0, 1, 1], frameon=True) # r,l,w,h
ax.set_xlim(-1, xLim)  , ax.set_xticks(x)
ax.set_ylim(-1, yLim)  , ax.set_yticks(y)
#ax.set_ylim(ax.get_ylim()[::-1])
for item in ([ax.title, ax.xaxis.label, ax.yaxis.label] +  ax.get_xticklabels() + ax.get_yticklabels()):
    item.set_fontsize(8)
  
cmap = plt.cm.get_cmap('RdYlBu')
#                                 x                     y
scat = ax.scatter(cp_info['position'][::1, 0], cp_info['position'][::1, 1],   \
                  s=cp_info['size'],                                          \
                  vmin=0, vmax=6,                                             \
                  cmap=cmap)#                                                   \
#                  origin='lower'                                                )
plt.gca().invert_yaxis()
#plt.gca().invert_xaxis()
#ax.spines['bottom'].set_position(('axes',0.5)) # move the lower axes up but data stays as is
ax.xaxis.set_tick_params(labeltop='on')
ax.yaxis.set_tick_params(labelright='on')

ani = manimation.FuncAnimation(fig, test_update_plot,    \
                              frames=xrange(numframes),  \
                              interval = 1000,            \
                              repeat   = False,           \
                              blit     = False           )
#                             fargs=(layerID)         )
writer=ani.FFMpegWriter(bitrate=500)
vidStr = 'fooVideo.mp4'.format(layerID) 
#ani.save(vidStr,codec='mpeg4', writer=writer, fps=4)
ani.save(vidStr,codec='mpeg4') #, fps=4)
plt.show(block=True)


"""


"""
import numpy as np
import math
import sys
import os
import copy
from copy import deepcopy
from copy import copy as copy_copy
from collections import namedtuple
from rcdtype import *
# Plotting
# 
import matplotlib.pyplot as plt
import matplotlib.animation as manimation
from pylab import *
from matplotlib.colors import BoundaryNorm
from matplotlib.ticker import MaxNLocator

WORDSIZE = 32
import dnnConnectivityAndMemoryAllocation as dc
import numpy as np


# Create memory
mainMemoryConfig = dc.MemoryConfiguration(2,32,8,4096)
mainMemory = dc.Memory(mainMemoryConfig)

# Create DNN
network = dc.Network()
network.addLayer('Input',          224, 224,    3                       ) #    3 
network.addLayer('Convolutional',   55,  55,    4,    8,   8,    3,   4 ) #   96,
network.addLayer('Convolutional',   27,  27,    8,    5,   5,    4,   2 ) #  256,

network.assignPEs('linearX')

for l in range(1, network.numberOfLayers):
  network.Layers[l].generateConnections()

layerID = 1
c, x, y = network.peArray.pe[0][0].displayCellsProcessed(layerID=layerID,noDisplay=True)

num_pts = c.__len__()
cp_info = np.zeros(num_pts, dtype=[('position', int, 2   ),  \
                                   ('size'    , int, 1   ),  \
                                   ('color'   , float, 4 )])  
cp_info['position'][:, 0] = y
cp_info['position'][:, 1] = x
s =  10.0*(math.log((30000.0/num_pts),10))  # s=10 seemed right when there were 3000 point (e.g. 55x55 array)
cp_info['size'    ]       = s*c

numframes = network.peArray.Y*network.peArray.X

fig = plt.figure(figsize=(7, 7))
ax = fig.add_axes([0, 0, 1, 1], frameon=False)
#ax.set_xlim(0, 1), ax.set_xticks([])
#ax.set_ylim(0, 1), ax.set_yticks([])
  
cmap = plt.cm.get_cmap('RdYlBu')
scat = plt.scatter(cp_info['position'][:, 0], cp_info['position'][:, 1],   \
                  s=cp_info['size'],                                      \
                  vmin=0, vmax=6,                                         \
                  cmap=cmap)
plt.gca().invert_yaxis()
plt.gca().invert_xaxis()

def update_plot(frame_number):
    xPe = np.remainder(frame_number,8)
    yPe = frame_number/8
    c, x, y = network.peArray.pe[yPe][xPe].displayCellsProcessed(layerID=layerID,noDisplay=True)
    cp_info['position'][:, 0] = y
    cp_info['position'][:, 1] = x
    cp_info['size'    ]       = c
    scat.set_sizes(cp_info['size'])
    scat.set_offsets(cp_info['position'])

ani = manimation.FuncAnimation(fig, update_plot,         \
                              frames=xrange(numframes),  \
                              interval = 1000,            \
                              repeat   = True,           \
                              blit     = False           )
plt.show()

"""
"""
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.animation as manimation

def update_plot(i, data, scat):
    scat.set_array(data[i])
    return scat,

numframes = 100
numpoints = 10
color_data = np.random.random((numframes, numpoints))
x, y, c = np.random.random((3, numpoints))

fig = plt.figure()
scat = plt.scatter(x, y, c=c, s=100)

ani = manimation.FuncAnimation(fig, update_plot, frames=xrange(numframes),
                              fargs=(color_data, scat))
plt.show(block=False)

"""
"""
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation


# Create new Figure and an Axes which fills it.
fig = plt.figure(figsize=(7, 7))
ax = fig.add_axes([0.05, 0.05, 0.9, 0.9], frameon=False)
ax.set_xlim(0, 1), ax.set_xticks([])
ax.set_ylim(0, 1), ax.set_yticks([])

# Create rain data
n_drops = 50
rain_drops = np.zeros(n_drops, dtype=[('position', float, 2),  \
                                      ('size',     float, 1),  \
                                      ('growth',   float, 1),  \
                                      ('color',    float, 4)])  

# Initialize the raindrops in random positions and with
# random growth rates.
rain_drops['position'] = np.random.uniform(0, 1, (n_drops, 2))
rain_drops['growth'] = np.random.uniform(50, 200, n_drops)

# Construct the scatter which we will update during animation
# as the raindrops develop.
scat = ax.scatter(rain_drops['position'][:, 0], rain_drops['position'][:, 1],   \
                  s=rain_drops['size'], lw=0.5, edgecolors=rain_drops['color'], \
                  facecolors='none')


def update(frame_number):
    # Get an index which we can use to re-spawn the oldest raindrop.
    current_index = frame_number % n_drops
    pass
    # Make all colors more transparent as time progresses.
    rain_drops['color'][:, 3] -= 1.0/len(rain_drops)
    rain_drops['color'][:, 3] = np.clip(rain_drops['color'][:, 3], 0, 1)
    pass
    # Make all circles bigger.
    rain_drops['size'] += rain_drops['growth']
    pass
    # Pick a new position for oldest rain drop, resetting its size,
    # color and growth factor.
    rain_drops['position'][current_index] = np.random.uniform(0, 1, 2)
    rain_drops['size'][current_index] = 5
    rain_drops['color'][current_index] = (0, 0, 0, 1)
    rain_drops['growth'][current_index] = np.random.uniform(50, 200)
    pass
    # Update the scatter collection, with the new colors, sizes and positions.
    scat.set_edgecolors(rain_drops['color'])
    scat.set_sizes(rain_drops['size'])
    scat.set_offsets(rain_drops['position'])


# Construct the animation, using the update function as the animation
# director.
animation = FuncAnimation(fig, update, interval=1000)
plt.show()
"""



"""
pylab inline
import dnnConnectivityAndMemoryAllocation as dc
from dnnConnectivityAndMemoryAllocation import *
network.displayPeAssignments()
network.displayCellsPerLayer()
network.updateSourceCellsTargetList()

for l in network.Layers:
    if l.layerID != 0 :
        print l.layerID
        l.updateSourceCellsTargetList()
#        l.assignPEs(8,8)

#print network.Layers[0].cells[0][0][1].memoryLocation
#print memory

#for y in range(2):
#  for x in range(224):
#    for z in range(3):
#      print '{{{0},{1},{2}}}:{3}'.format(z,y,x,network.Layers[0].cells[z][y][x].memoryLocation)

 foo = Cell(network.Layers[1],1,2,3)
"""
"""
c_1_0_0_4 = dc.network.Layers[1].cells[0][0][4]
pe_0_0 = network.peArray.pe[0][0]
pass
if c_1_0_0_4 in pe_0_0.cellsProcessed[1]:
    print 'foo1'
print pe_0_0.findROI(1)
#print pe_0_0.findCellsProcessedRegion(1)

c_0_0_0_16 = network.Layers[0].cells[0][0][16]
tc_0_0_0_16 = c_0_0_0_16.targetCells
if c_1_0_0_4 in tc_0_0_0_16:
    print 'foo2'
if c_0_0_0_16 in c_1_0_0_4.sourceCells:
    print 'foo3'

print network.peArray.pe[0][0].findROI(1)
print network.peArray.pe[1][1].findROI(1)
print network.peArray.pe[2][2].findROI(1)
print network.peArray.pe[7][7].findROI(1)
"""





"""
network.Layers[0].displayTargetPECounts()

lid = 0
yGrid, xGrid = np.mgrid[slice(0, network.Layers[lid].Y),  slice(0, network.Layers[lid].X)]

numOfPEs = network.Layers[lid].getTargetPECounts()

c = plt.contourf(xGrid,yGrid,numOfPEs, linspace(-0.5,4.5,6))
b = plt.colorbar(c, orientation='vertical')
#l = plt.clabel(c)
lx = plt.xlabel("x")
ly = plt.ylabel("y")
plt.show(block=False)

levels = MaxNLocator(nbins=4).tick_values(numOfPEs.min(), numOfPEs.max())
levels = np.array([1,2,3,4])

cmap = plt.get_cmap('PiYG')
norm = BoundaryNorm(levels, ncolors=cmap.N, clip=True)

fig, ax = plt.subplots(nrows=1)

im = ax.pcolormesh(xGrid, yGrid, numOfPEs, cmap=cmap, norm=norm)
fig.colorbar(im, ax=ax)
ax.set_title('Number of target PEs')
fig.tight_layout()
plt.show(block=False)





layerID = 1
cell = np.array([0, 20,20])
pe = np.array([0,1])

sc = network.getSourceCells(layerID, cell)
sck=sc.keys()
sck.sort()
sck
tc = network.getTargetCells(layerID, cell)
tck=tc.keys()
tck.sort()
tck
sp = network.getSourcePEs(layerID, cell)
spk=sp.keys()
spk.sort()
spk
tp = network.getTargetPEs(layerID, cell)
tpk=tp.keys()
tpk.sort()
tpk
for peY in range(8):
    for peX in range(8):
        cp = network.peArray.pe[peY][peX].cellsProcessed[layerID]
        len(cp)




layerID = 1
cell = np.array([0, 20,20])
pe = np.array([0,1])
cp = network.peArray.pe[pe[0]][pe[1]].cellsProcessed[layerID]
pass
minx = np.inf
miny = np.inf
maxx = 0
maxy = 0
for c in range(cp.__len__()):
    if cp[c][1] < miny:
        miny = cp[c][1]
    if cp[c][1] > maxy:
        maxy = cp[c][1]
    if cp[c][2] < minx:
        minx = cp[c][2]
    if cp[c][2] > maxx:
        maxx = cp[c][2]

print minx, ",", maxx, ",", miny, ",", maxy




layerID = 1
PE = np.array([0, 0])
pe = network.peArray.pe[PE[0]][PE[1]]
processedCells = pe.cellsProcessed[layerID]
pCells = []
sCells = []
for cellId in processedCells:
    #print cellId
    pc = network.Layers[layerID].cells[cellId[0]][cellId[1]][cellId[2]]
    sCellIds = pc.sourceCells
    for sc in sCellIds:
      c = network.Layers[layerID-1].cells[sc[0]][sc[1]][sc[2]]
      if sCells.count(c) == 0: # avoid duplicates
        sCells.append(network.Layers[layerID-1].cells[sc[0]][sc[1]][sc[2]])
minx = np.inf
miny = np.inf
maxx = 0
maxy = 0
for sc in sCells:
    if sc.Y < miny:
        miny = sc.Y
    if sc.Y > maxy:
        maxy = sc.Y
    if sc.X < minx:
        minx = sc.X
    if sc.X > maxx:
                maxx = sc.X
          


"""




##----------------------------------------------------------------------------------------------------
##----------------------------------------------------------------------------------------------------
##              CITATIONS
##----------------------------------------------------------------------------------------------------
##----------------------------------------------------------------------------------------------------

##----------------------------------------------------------------------------------------------------
# put in paper
##----------------------------------------------------------------------------------------------------

"""
@Article{Hunter:2007,
  Author    = {Hunter, J. D.},
  Title     = {Matplotlib: A 2D graphics environment},
  Journal   = {Computing In Science \& Engineering},
  Volume    = {9},
  Number    = {3},
  Pages     = {90--95},
  abstract  = {Matplotlib is a 2D graphics package used for Python
  for application development, interactive scripting, and
  publication-quality image generation across user
  interfaces and operating systems.},
  publisher = {IEEE COMPUTER SOC},
  doi = {10.1109/MCSE.2007.55},
  year      = 2007
}

"""


##----------------------------------------------------------------------------------------------------
# Do not put in paper
##----------------------------------------------------------------------------------------------------

"""
@misc{stackoverflow1,
  title = {Stack Overflow 1},
  author={Various},
  howpublished = {\url{http://stackoverflow.com/questions/6810999/how-to-determine-file-function-and-line-number}},
  note = {Accessed: 2017-01-16}
}
@misc{stackoverflow2,
  title = {Stack Overflow 2},
  author={Various},
  howpublished = {\url{http://stackoverflow.com/questions/1911281/how-do-i-get-list-of-methods-in-a-python-class}},
  note = {Accessed: 2017-01-16}
}
@misc{stackoverflow3,
  title = {Stack Overflow 3},
  author={Various},
  howpublished = {\url{http://kestrel.nmt.edu/~raymond/software/python_notes/paper004.html}},
  note = {Accessed: 2017-XX-XX}
}



# URL Example
@misc{stackoverflow<n>,
  title = {Stack Overflow <n>},
  author={Various},
  howpublished = {\url{}},
  note = {Accessed: 2017-XX-XX}
}
"""

