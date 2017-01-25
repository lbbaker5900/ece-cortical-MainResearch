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
import copy
from copy import deepcopy
from copy import copy as copy_copy
from collections import namedtuple
from rcdtype import *
# Plotting
# 
import matplotlib.pyplot as plt
from pylab import *
from matplotlib.colors import BoundaryNorm
from matplotlib.ticker import MaxNLocator
from mpl_toolkits.mplot3d import Axes3D

########################################################################################################################
## Globals

## Memory
WORDSIZE = 32



DEBUG = []

## Create __FILE__ and __LINE__ for prints
## citation:http://stackoverflow.com/questions/6810999/how-to-determine-file-function-and-line-number
class __LINE__(object):
    import sys

    def __repr__(self):
        try:
            raise Exception
        except:
            return str(sys.exc_info()[2].tb_frame.f_back.f_lineno)

__FILE__ = 'dnnConnectivityAndMemoryAllocation.py'

#lineNo = __LINE__()

## Extract class methods and fields for prints
## citation:http://stackoverflow.com/questions/1911281/how-do-i-get-list-of-methods-in-a-python-class
from types import FunctionType
def methods(cls):
    ## too ugly return [x for x, y in cls.__dict__.items() if type(y) == FunctionType]
    return [func for func in dir(cls) if callable(getattr(cls, func)) and not func.startswith("__")]
def fields(cls):
    return vars(cls).keys()



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

########################################################################################################################
## KERNELS

class Kernel():

    def __init__(self, z, y, x):
        self.x = x
        self.y = y
        self.z = z

    

########################################################################################################################
## MEMORY

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
    def __init__(self, numOfChannels, numOfBanksPerChannel, numOfPagesPerBank, sizeOfPage):
        self.numOfChannels           = numOfChannels 
        self.numOfBanksPerChannel    = numOfBanksPerChannel    
        self.numOfPagesPerBank       = numOfPagesPerBank    
        self.sizeOfPage              = sizeOfPage    
        self.Channels                = []
        for ch in range(numOfChannels):
            newChannel = Channel(numOfBanksPerChannel, numOfPagesPerBank, sizeOfPage)
            self.Channels.append(newChannel)

    def __str__(self):
        pLine = ""
        pLine = pLine + 'Channels:{0}:Banks/Channel:{1}:Pages/Bank:{2}:Words/Page:{3}:    '.format(self.numOfChannels, self.numOfBanksPerChannel, self.numOfPagesPerBank, self.sizeOfPage/WORDSIZE)
        pLine = pLine + '\nMethods: {0}                                                   '.format(methods(self))
        pLine = pLine + '\nFields: {0}                                                    '.format(fields(self))
        return pLine

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
        pLine = pLine + '\nMethods: {0}                             '.format(methods(self))
        pLine = pLine + '\nFields: {0}                              '.format(fields(self))
        return pLine



########################################################################################################################
########################################################################################################################
## NETWORK


########################################################################################################################
#----------------------------------------------------------------------------------------------------
# CELL

class Cell():

    def __init__(self, parentLayer, z, y, x):
        # keep track of the {x,y} location of PE processing this cell
        self.PE              = []
        self.originalCell    = self                             # so copies of cell can communicate with original so we can keep track of copies
        self.copiedTo        = []                               # pointer to copied cell. we can extract Memory address of copied cell to create memory copy stats
        self.roiFromSrcCells = np.zeros([2,3], dtype=np.int)    # corners of ROI [[Z,Y,X],[Z,Y,X]] extracted from list of source cells
        self.roi             = np.zeros([2,3], dtype=np.int)    # corners of ROI [[Z,Y,X],[Z,Y,X]] generated when running assignPE in the layer
        # Keep ID locally
        self.Z               = z
        self.Y               = y
        self.X               = x
        # Fanin and fanout of this cell
        self.sourceCells     = []
        self.targetCells     = []
        self.sourcePEs       = []
        self.targetPEs       = []
        self.layerID         = parentLayer.layerID
        self.parentLayer     = parentLayer
        self.memoryLocation  = MemoryLocation(None,0,0,0,0)
        self.kernel          = Kernel(0,0,0)

    #----------------------------------------------------------------------------------------------------
    # ROI
    
    def findROI(self):

        # Parse the source cells and find Y,X corners of ROI
        absCellMin = np.inf
        absCellMax = 0

        for sc in self.sourceCells:
          print sc
          absCellNum = sc.Y*sc.parentLayer.X*sc.parentLayer.Z + sc.X*sc.parentLayer.Z + sc.Z
          if absCellNum < absCellMin :
              absCellMin = absCellNum
              cellMin = sc
          if absCellNum > absCellMax :
              absCellMax = absCellNum
              cellMax = sc
        self.roiFromSrcCells = np.array([[cellMin.Z, cellMin.Y, cellMin.X],[cellMax.Z, cellMax.Y, cellMax.X]])

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
            if (sc.Y == miny) and (sc.X == minx):
                if sc.Z < minz:
                    minz = sc.Z
            if (sc.Y == maxy) and (sc.X == maxx):
                if sc.Z > maxz:
                    maxz = sc.Z

        self.roiFromSrcCells = np.array([[minz, miny, minx], [maxz, maxy, maxx]] )
        """

        return self.roiFromSrcCells

    def getROI(self):
        if not self.roiFromSrcCells.any() :
            return self.findROI()
        else:
            return self.roiFromSrcCells

    #----------------------------------------------------------------------------------------------------
    # print

    def __str__(self):
        pLine = ""
        pLine = pLine + '\nCell:{0},{1},{2}                                               '.format(self.Z, self.Y, self.X)
        pLine = pLine + '\nLayer:{0}                                                      '.format(self.layerID)
        pLine = pLine + '\nPE{{Y,X}} : {0},{1}                                            '.format(self.PE.ID[0], self.PE.ID[1])
        pLine = pLine + '\nMemory:{{Ch, Bank, Page, Word}}:{0},{1},{2},{3}                '.format(self.memoryLocation.channel, self.memoryLocation.bank, self.memoryLocation.page, self.memoryLocation.word)
        pLine = pLine + '\nroi || roiFromSrcCells(findROI()) coords : {0} {1} || {2},{3}  '.format(self.roi[0], self.roi[1], self.roiFromSrcCells[0], self.roiFromSrcCells[1] )
        pLine = pLine + '\nMethods: {0}                                                   '.format(methods(self))
        pLine = pLine + '\nFields: {0}                                                    '.format(fields(self))
        return pLine
        

    #----------------------------------------------------------------------------------------------------


########################################################################################################################
#----------------------------------------------------------------------------------------------------
# LAYER

class Layer():

    def __init__(self, network, layerID, type, X, Y, Z, Kx=0, Ky=0, Kz=0, stride=0):
        self.parentNetwork = network
        self.layerID = layerID
        self.type = type
        self.assignType = 'linearAll'
        #self.assignType = 'linearX'
        self.X = X
        self.Y = Y
        self.Z = Z
        self.Kx = Kx
        self.Ky = Ky
        self.Kz = Kz
        self.stride = stride
        self.cells = []
        # create a 3-D grid of cells

        for z in range(Z):
          yCells = []
          for y in range(Y):
            xCells = []
            for x in range(X):
                newCell = Cell(self, z, y, x)
                xCells.append(newCell)
            yCells.append(xCells)
          self.cells.append(yCells)

    #----------------------------------------------------------------------------------------------------
    # print

    def __str__(self):
        pLine = ""
        pLine = pLine + '\nLayer {0}                    '.format(self.layerID)
        pLine = pLine + '\n{{Z,Y,X}} : {0},{1},{2}      '.format(self.Z, self.Y, self.X)
        pLine = pLine + '\n{{Kz,Ky,Kx}} : {0},{1},{2}   '.format(self.Kz, self.Ky, self.Kx)
        pLine = pLine + '\nMethods: {0}                 '.format(methods(self))
        pLine = pLine + '\nFields: {0}                  '.format(fields(self))
        return pLine
        

    """
    #----------------------------------------------------------------------------------------------------
    # Memory assignment
    #
    # FIXME : now in manager class

    def allocateMemory(self):  
        # - after creating the cells, they will be allocated a state memory location
        initialChannel   = 0
        channelIncrement = 1
        initialBank      = 0
        bankIncrement    = 2
        initialPage      = 0
        pageIncrement    = 1
        initialWord      = 0
        wordIncrement    = 1
        padWordRadix2    = 'Y'

        if padWordRadix2 is 'Y' :
          numberOfAllocatedFeaturess = 2**(math.ceil(math.log(self.Z,2)))

        channel = initialChannel
        bank    = initialBank
        page    = initialPage
        word    = initialWord

        for y in range(self.Y):
          for x in range(self.X):
            for z in range(self.Z):
              self.cells[z][y][x].memoryLocation.channel = int(channel)
              self.cells[z][y][x].memoryLocation.bank    = int(bank)
              self.cells[z][y][x].memoryLocation.page    = int(page)
              self.cells[z][y][x].memoryLocation.word    = int(word)
              
              word = word + wordIncrement
              if padWordRadix2 is 'Y' :
                if word%numberOfAllocatedFeaturess == self.Z:
                    word = (int(word/numberOfAllocatedFeaturess)+1) * numberOfAllocatedFeaturess
              if word == (memory.sizeOfPage/WORDSIZE):
                word = 0
                page = page + pageIncrement
              
              if page == (memory.numOfPagesPerBank):
                page = 0
                bank = bank + bankIncrement
              
              if bank == (memory.numOfBanksPerChannel):
                bank = 0
                channel = channel + channelIncrement
              
              if channel == (memory.numOfChannels):
                channel = 0
    """
              

    def getPreviousLayer(self):
        return self.parentNetwork.getLayer(self.layerID-1)

    #----------------------------------------------------------------------------------------------------
    # PE assignment

    def assignPEs(self, peX, peY): # assign an array of X by Y PE's
        # e.g. each PE will be assigned a set of X-Y-Z feature maps
        # for example, with a 55x55x256 array of feature maps, PE{0,0} may be assigned a 6x6x256 array of feature maps
        # where PE{0,1} may be assigned a 7x7x256 array of feature maps

        # Type:
        # 'linearAll' : total number of cells are spread across 64 PE's
        # 'linearX'   : all cells in a row (e.g. X*f) are allocated across X and evenly assigned to PE's in X dimension. rows are assigned to PE's in Y dimension

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
            
            nx=int(np.floor(self.X*self.Z/peX)) # n is the integer part meaning peX-m PE's will be assigned n columns and m PE's will be assigned n+1 cols
            mx=int(np.remainder(self.X*self.Z, peX))
            lx=peX-mx         # lx PE's are assigned nx cells, peX-lx are assigned nx+1 cells
          
            for y in range(peY):
                for x in range(peX):
                    if x<lx:     # if remainder was 0, all PE's will be assigned nx cells
                        self.peArrayXYcellCount[y][x][1] = int(nx)
                        #print 'DEBUG1 ', y, x
                    else:              
                        #print 'DEBUG2 ', y, x
                        self.peArrayXYcellCount[y][x][1] = int(nx+1)
 
 
 
            ny=int(np.floor(self.Y/peY)) # n is the integer part meaning peX-1 PE's will be assigned n columns and the peXth PE would be assigned X-(peX-1)*n cols
            my=int(np.remainder(self.Y, peY))
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
            #                                                                                          m~1-7
            #                                                                                         |-----|
            n=np.floor(self.Y*self.X*self.Z/(peX*peY)) # n is the integer part meaning pe^2-m PE's will be assigned n columns and m PE's will be assigned n+1 cells
            m=np.remainder(self.Y*self.X*self.Z, (peX*peY))
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
                  #print 'LEE:DEBUG:line 486', self.layerID,':', y, x, self.peArrayXYcellCount[y][x][0]
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
                        for yCell in range(int(self.peArrayXYcellCount[yPe][xPe][0])):
                            for xCell in range(int(self.peArrayXYcellCount[yPe][xPe][1])):
                                # divide by number of features to find column x
                                f=np.remainder(xOffset+xCell,self.Z)
                                x=int((xOffset+xCell)/self.Z)
                                #y=int((yOffset+yCell)/self.Z)
                                y=yCell+yOffset
                                # index is z,y,x
                                try: # FIXME
                                    self.cells[f][y][x].PE = self.parentNetwork.peArray.pe[yPe][xPe]
                                    self.parentNetwork.peArray.addCell(np.array([yPe,xPe]), self.layerID, np.array([f,y,x]))
                                    #print 'LEE:DEBUG:AddCell', self.layerID,':', f ,y ,x
                                    #print 'LEE:DEBUG:', self.layerID,':', yCell, xCell, ':', f ,y ,x, ':', xOffset, yOffset, ':', xPe, yPe, ':', self.peArrayXYcellCount[yPe][xPe], ':', self.Z, self.Y, self.X
                                except:
                                    print 'LEE:ERROR:DEBUG:', self.layerID,':', yCell, xCell, f ,y ,x, xOffset, yOffset, xPe, yPe, self.peArrayXYcellCount[yPe][xPe], self.Z, self.Y, self.X
                                    raise
                        xOffset += int(self.peArrayXYcellCount[yPe][xPe][1])
          
                yOffset += int(self.peArrayXYcellCount[yPe][xPe][0])

        elif (self.assignType == 'linearAll') :
            xOffset = 0 # keep track of the row and col cell number and construct z,y,x location based on number of features and cells per PE
            yOffset = 0 
            yPeCurr = 0
            for pe in range(peY*peX):
                xPe = np.remainder(pe,peX)
                yPe = pe/peX

                if yPe != yPeCurr :
                    yOffset += xOffset
                    xOffset = 0  # keep track of the column cell number and construct z,y,x location based on number of features and cells per PE
                    yPeCurr = yPe
                # We are processing absolute cells yOffset+xOffset+cell
                for cell in range(int(self.peArrayXYcellCount[yPe][xPe][0])):
                    ca = (cell + xOffset + yOffset)
                    #print ca

                    f = np.remainder(ca, self.Z)
                    fa = ca/self.Z
                    x = np.remainder(fa, self.X)
                    y = fa/self.X
                    try: # FIXME
                        self.cells[f][y][x].PE = self.parentNetwork.peArray.pe[yPe][xPe]
                        self.parentNetwork.peArray.addCell(np.array([yPe,xPe]), self.layerID, np.array([f,y,x]))
                    except:
                        print 'LEE:ERROR:DEBUG:', self.layerID,':', cell, pe, f ,y ,x, xOffset, xPe, yPe, self.peArrayXYcellCount[yPe][xPe], self.Z, self.Y, self.X
                        raise
                xOffset += int(self.peArrayXYcellCount[yPe][xPe][0])

        # FIXME
        # Check all cells have been assigned a PE
        for y in range(self.Y):
            for x in range(self.X):
                for f in range(self.Z):
                    if isinstance(self.cells[f][y][x].PE, list): # FIXME
                        print 'LEE:DEBUG:line 550', self.layerID,':', f ,y ,x
                        raise

    #----------------------------------------------------------------------------------------------------
      
    def generateConnections(self):
        # For each cell in this layer, identify the cells from the previous layer that feed this cell and add this cell's PE
        # to the target list
        for y in range(self.Y):
            print 'Updating Layer {0} connections'.format(self.layerID) + ' for features in row :{0}'.format(y)
            for x in range(self.X):
                #print 'Updating Layer {0} connections'.format(self.layerID) + ' for features at row :{0},{1}'.format(y,x)
                for f in range(self.Z):

                    #print self.stride, self.Ky, self.Kx, self.kernelTopOffset, self.kernelLeftOffset
             
                    # Identify the row and columns of the source cells from layer n-1
                    # We are taking the kernel and moving it across the input
                    # Need to account for the 1st kernel and last kernel being outside the edge of the input
                    tmpY = range(max(0, self.kernelTopOffset+y*self.stride), min(self.parentNetwork.Layers[self.layerID-1].Y, self.kernelTopOffset+y*self.stride+self.Ky))
                    tmpX = range(max(0, self.kernelLeftOffset+x*self.stride), min(self.parentNetwork.Layers[self.layerID-1].X, self.kernelLeftOffset+x*self.stride+self.Kx))
             
                    # tmpy,tmpX are the X,Y ROI of the cell (f,y,x)
                    # FIXME: this ROI should match the the findROI method which uses the list of sourceCells to construct the ROI
                    # create corners of ROI
                    self.cells[f][y][x].roi[0] = [                                            0, min(tmpY), min(tmpX)]
                    self.cells[f][y][x].roi[1] = [self.parentNetwork.Layers[self.layerID-1].Z-1, max(tmpY), max(tmpX)]

                    # Cycle thru the source cells and 
                    #   a) add this cells PE to the list of target PE's of the source cell
                    #   b) add this cells ID to the list of target cell's of the source cell
                    #   c) Add the source cells PE to this cells list of source PE's
                    #   d) Add the source cells to this cells list of source cells
                    tgtPE   = self.cells[f][y][x].PE
                    tgtCell = self.cells[f][y][x]
                    for ySrcCell in tmpY:
                        for xSrcCell in tmpX:
                            for fSrcCell in range(self.parentNetwork.Layers[self.layerID-1].Z) :
             
                                srcPE   = self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].PE
                                srcCell = self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell]

                                # a) Update source cells target PE list
                                self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetPEs.append(self.cells[f][y][x].PE)
             
                                # b) Update source cells target cell list
                                self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetCells.append(tgtCell)
                             
                                #srcCell = tuple([fSrcCell, ySrcCell, xSrcCell])
                             
                                # c) Update this cells source PE list
                                if isinstance(srcPE, list): # FIXME
                                    #print __FILE__ + lineNo.__repr__() + 'DEBUG:ERROR: {0}, {1}, {2}'.format(f,y,x)
                                    print 'Foo line 590: {0},{1},{2}'.format(fSrcCell, ySrcCell, xSrcCell)
                                    raise
                                self.cells[f][y][x].sourcePEs.append(srcPE)
             
                                # d) Update this cells source cell list
                                self.cells[f][y][x].sourceCells.append(srcCell)
                     
                #print 'Completed layer {0} connections for features at : {1},{2}'.format(self.layerID, y, x)

        ##----------------------------------------------------------------------------------------------------
        ## remove duplicates
        print 'Removing duplicates in source and target cell lists of Layers {0} and {1} respectively'.format(self.layerID, self.layerID-1)

        for y in range(self.Y):
            for x in range(self.X):
                for f in range(self.Z):
                    try: # FIXME
                        tmpSrcPE = set(self.cells[f][y][x].sourcePEs)
                        self.cells[f][y][x].sourcePEs = list(tmpSrcPE)
                        tmpSrcCell = set(self.cells[f][y][x].sourceCells)
                        self.cells[f][y][x].sourceCells = list(tmpSrcCell)
                    except:
                        #print __FILE__ + lineNo.__repr__() + 'ERROR: {0}, {1}, {2}'.format(f,y,x)
                        print 'Foo line 613'
                        raise

        
        for y in range(self.parentNetwork.Layers[self.layerID-1].Y):
            for x in range(self.parentNetwork.Layers[self.layerID-1].X):
                for f in range(self.parentNetwork.Layers[self.layerID-1].Z):
                    if self.parentNetwork.Layers[self.layerID-1].cells[f][y][x].targetPEs.__len__() > 1: # if only for DEBUG
                        tmpTgtPEs = set(self.parentNetwork.Layers[self.layerID-1].cells[f][y][x].targetPEs)
                        self.parentNetwork.Layers[self.layerID-1].cells[f][y][x].targetPEs = list(tmpTgtPEs)
                        #print '{0},{1},{2}:targetPe.len() = '.format(f, y, x) + str(self.parentNetwork.Layers[self.layerID-1].cells[f][y][x].targetPEs.__len__())
                    tmpTgtCells = set(self.parentNetwork.Layers[self.layerID-1].cells[f][y][x].targetCells)
                    self.parentNetwork.Layers[self.layerID-1].cells[f][y][x].targetCells = list(tmpTgtCells)

        print 'Connections complete from Layer {0} to {1}'.format(self.layerID-1, self.layerID)
                        

    #----------------------------------------------------------------------------------------------------
    def calculateKernelOffset(self):
        # Determine Kernel overlap at edge of input array
        if self.layerID != 0:
            self.kernelLeftOffset = int(((self.parentNetwork.Layers[self.layerID-1].X) - ((self.X-1)*self.stride+self.Kx))/2)
            self.kernelTopOffset  = int(((self.parentNetwork.Layers[self.layerID-1].Y) - ((self.Y-1)*self.stride+self.Ky))/2)
        else:
            self.kernelLeftOffset = 0
            self.kernelTopOffset  = 0
        print 'Layer ', self.layerID, ' left Kernel offset is ', int(self.kernelLeftOffset),  ', top Kernel offset is ', int(self.kernelTopOffset) 

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
    ## Display Routines


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

    #----------------------------------------------------------------------------------------------------
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
        s =  10*(math.log((30000.0/numPts),10))  # s=10 seemed right when there were 3000 point (e.g. 55x55 array)
        s = numOfPEs * s
        sc = plt.scatter(xGrid, yGrid, c=numOfPEs, s=s, vmin=0, vmax=6, cmap=cmap, norm=norm)  # s=size
        plt.colorbar(sc, orientation='vertical')
        plt.show()


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

        plt.show()


    def displayTargetPECounts(self):
         coords = np.array([[0,0],[self.Y,self.X]])
         self.displayTargetPECountsRegion(coords)


    #----------------------------------------------------------------------------------------------------
    def displayPeCellArrangement(self):
        print 'Layer ', self.layerID, ' PE pixel assignments'
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
        print 'Layer ', self.layerID, 'number of cells is ', self.X*self.Y*self.Z

    #----------------------------------------------------------------------------------------------------
    def createCellTargetPEFile(self):
        outFile = 'layer'+ str(self.layerID) + '_cellTargetList.txt'
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
                    pLine = pLine + '\n({1:3},{2:3},{3:3}}} : {4:^20} : {5:<100}  \n'.format(self.layerID, f, y, x, len(self.cells[f][y][x].targetPEs.keys()), self.cells[f][y][x].targetPEs.keys())
        
        pLine = pLine + '\n\nMulti-PE target Cell counts : {0} : {1}'.format(hiLoadCellCount,cellCount)
        
        oFile.write(pLine)
        oFile.close()
                    

    #----------------------------------------------------------------------------------------------------
    def createSourceCellFile(self):
        outFile = 'layer'+ str(self.layerID) + '_sourceCellList.txt'
        oFile = open(outFile, 'w')
        pLine = ''
        pLine = pLine + '\n{0:^13} : {1:^20} : {2:<100}'.format('Cell', 'Number of', ' Cells')
        pLine = pLine + '\n{0:^13} : {1:^20} : {2:<100}'.format(' ', 'Source Cells', ' ')
        
        for y in range(self.Y):
            for x in range(self.X):
                for f in range(self.Z):
                    pLine = pLine + '\n({1:3},{2:3},{3:3}) : {4:^20} : {5:<100}  \n'.format(self.layerID, f, y, x, len(self.cells[f][y][x].sourceCells.keys()), self.cells[f][y][x].sourceCells.keys())
        
        oFile.write(pLine)
        oFile.close()
                    


########################################################################################################################
#----------------------------------------------------------------------------------------------------
# PE

class PE():

    def __init__(self, parentPEarray, numberOfLayers, peId):
        self.ID = peId

        self.processedRegion = []
        self.roi             = []  # array([ yMin, yMax, xMin, xMax ])

        # which cells in layer n are being processed by this pe
        self.cellsProcessed = []
        # cellsProcessed is a vector with each entry being a list of cells this PE processes at a particular layer
        for l in range(numberOfLayers):
          self.cellsProcessed.append([])
          self.processedRegion.append([])
          self.roi.append([])

        self.parentPEarray = parentPEarray

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

        # Parse the source cells and find Y,X corners of ROI

        absCellMin = np.inf
        absCellMax = 0

        for pc in self.cellsProcessed[layerID] :
          for sc in pc.sourceCells:
            absCellNum = sc.Y*sc.parentLayer.X*sc.parentLayer.Z + sc.X*sc.parentLayer.Z + sc.Z
            if absCellNum < absCellMin :
                absCellMin = absCellNum
                cellMin = sc
            if absCellNum > absCellMax :
                absCellMax = absCellNum
                cellMax = sc

        self.roi[layerID] = np.array([[cellMin.Z, cellMin.Y, cellMin.X],[cellMax.Z, cellMax.Y, cellMax.X]])

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
        if not self.roi[layerID].any() :
            return self.findROI(layerID)
        else:
            return self.roi[layerID]

    """
    # Now in manager class
    def memCpyROI(self, layerID):

        # Create a copy of all the ROI cells as these will be copied to each targetPE
        # we also want them in the list in the order of processing
        roi = self.findROI(layerID)
        xLen = self.roi[layerID][3]-self.roi[layerID][2]+1  
        yLen = self.roi[layerID][1]-self.roi[layerID][0]+1
        zLen = self.parentPEarray.parentNetwork.Layers[layerID].Z
        
        roiLayerCells = []
        # FIXME: will PE always process all features at Y,X location
        for roiZ in range(self.parentPEarray.parentNetwork.Layers[layerID-1].Z) :
          roiLayerCellsY = []
          for roiY in range(self.roi[layerID][0], self.roi[layerID][1]+1) :
            roiLayerCellsX = []
            for roiX in range(self.roi[layerID][2], self.roi[layerID][3]+1) :
              # Note: Just using copy using "from copy import copy" creates a numpy array?????
              #       had to use "from copy import copy as copy_copy"
              copiedCell = copy_copy(self.parentPEarray.parentNetwork.Layers[layerID-1].cells[roiZ][roiY][roiX])

              # copied Cell will be in different memory location and we only did a shallow copy
              copiedCell.memoryLocation = MemoryLocation(0,0,0,0)

              # Keep track of copies in original layer cell
              self.parentPEarray.parentNetwork.Layers[layerID-1].cells[roiZ][roiY][roiX].copiedTo.append(copiedCell)
              roiLayerCellsX.append(copiedCell)
            roiLayerCellsY.append(roiLayerCellsX)
          roiLayerCells.append(roiLayerCellsY)
        self.roiCells[layerID] = roiLayerCells
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


    #----------------------------------------------------------------------------------------------------
    # processed Cells
    
    def addCell(self, layerId, cellId):
        # list of cell pointers
        if self.parentPEarray.parentNetwork.Layers[layerId].cells[cellId[0]][cellId[1]][cellId[2]] not in self.cellsProcessed :
            self.cellsProcessed[layerId].append(self.parentPEarray.parentNetwork.Layers[layerId].cells[cellId[0]][cellId[1]][cellId[2]])



########################################################################################################################
#----------------------------------------------------------------------------------------------------
# PE ARRAY

class PEarray():

    def __init__(self, parentNetwork, peY, peX, numberOfLayers):
        self.parentNetwork = parentNetwork
        self.pe = []
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
    def addCell(self, peId, layerId, cellId):
        self.pe[peId[0]][peId[1]].addCell(layerId, cellId)


########################################################################################################################
#----------------------------------------------------------------------------------------------------
# Manager ARRAY

class ManagerArray():

    def __init__(self, parentNetwork, mgrY, mgrX, numberOfLayers):
        self.parentNetwork = parentNetwork
        self.manager = []
        for y in range(mgrY):
            mgrArrayX = []
            for x in range(mgrX):
                mgrArrayX.append(Manager(self, numberOfLayers, np.array([y,x])))
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

    def __init__(self, parentManagerArray, numberOfLayers, mgrId):
        self.ID                 = mgrId
        self.parentManagerArray = parentManagerArray
        self.pe                 = self.parentManagerArray.parentNetwork.peArray.pe[self.ID[0]][self.ID[1]]
        self.roiCells           = []  # copy of ROI of previous layer cells

        for l in range(numberOfLayers):
          self.roiCells.append(None)


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
    # Mem Copy
    # copy ROI from roi in associated PE

    def memCpyROI(self, layerID):

        # Create a copy of all the ROI cells as these will be copied to each manager associated with the PE
        # we also want them in the list in the order of processing
        roi = self.pe.getROI(layerID)
        xLen = roi[1][2]-roi[0][2]+1  
        yLen = roi[1][1]-roi[0][1]+1

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

    #----------------------------------------------------------------------------------------------------
    # Memory assignment

    def allocateMemory(self, memory, layerID):  
        # - after copying the ROI from thwe input array to the manager, they will be allocated a state memory location
        # We can create a DMA transfer from the ROI cell and the original cell
        initialChannel   = 0
        channelIncrement = 1
        initialBank      = 0
        bankIncrement    = 2
        initialPage      = 0
        pageIncrement    = 2
        initialWord      = 0
        wordIncrement    = 1
        padWordRadix2    = 'Y'

        # if the number of features is not radix-2, do we pad features to align radix-2
        numOfFeatures = self.roiCells[layerID].__len__()
        if padWordRadix2 is 'Y' :
          numberOfAllocatedFeatures = 2**(math.ceil(math.log(numOfFeatures,2)))

        channel = initialChannel
        bank    = initialBank
        page    = initialPage
        word    = initialWord

        for y in range(self.roiCells[layerID][0].__len__()):
          for x in range(self.roiCells[layerID][0][0].__len__()):
            for z in range(self.roiCells[layerID].__len__()):
              self.roiCells[layerID][z][y][x].memoryLocation.memory  = memory
              self.roiCells[layerID][z][y][x].memoryLocation.channel = int(channel)
              self.roiCells[layerID][z][y][x].memoryLocation.bank    = int(bank)
              self.roiCells[layerID][z][y][x].memoryLocation.page    = int(page)
              self.roiCells[layerID][z][y][x].memoryLocation.word    = int(word)
              
              channel = channel + channelIncrement
              if channel == (memory.numOfChannels):
                channel = 0
                word = word + wordIncrement
              if padWordRadix2 is 'Y' :
                if word%numberOfAllocatedFeatures == numOfFeatures:
                    word = (int(word/numberOfAllocatedFeatures)+1) * numberOfAllocatedFeatures
              if word == (memory.sizeOfPage/WORDSIZE):
                word = 0
                page = page + pageIncrement
              
              if page == (memory.numOfPagesPerBank):
                page = 0
                bank = bank + bankIncrement
              
              if bank == (memory.numOfBanksPerChannel):
                bank = 0
              



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

    def assignPEs(self):
        #----------------------------------------------------------------------------------------------------
        # create Manager and PE Array
        # First build PE then associate a manager with each PE

        # a) PE's
        self.peArray = PEarray(self, self.peY, self.peX, self.numberOfLayers)
        # assign PE's to each cell of each layer
        for l in self.Layers:
            l.assignPEs(self.peX,self.peY)
            l.calculateKernelOffset()

        # b) Manager's
        self.managerArray = ManagerArray(self, self.peY, self.peX, self.numberOfLayers)

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
    

    
    # In[80]:
    
    try:
        reload(dc)
        print  'dc reloaded'
    except Exception:
        print 'dc not loaded yet'
        
    
    
    # In[81]:
    
    WORDSIZE = 32
    import dnnConnectivityAndMemoryAllocation as dc
    import numpy as np
    
    # Create memory
    memory = dc.Memory(2,32,8,4096)
    
    # Create DNN
    network = dc.Network()
    #                                    X    Y    Z    Kx   Ky   Kz   stride
    #network.addLayer('Input',          224, 224,    3                      ) #    3 
    #network.addLayer('Convolutional',   55,  55,   96,   11,  11,    3,   4 ) #   96,
    #network.addLayer('Convolutional',   27,  27,  256,    5,   5,   96,   2 ) #  256,
    # network.addLayer('Convolutional',   13,  13,  384,    3,   3,  256,   2 ) #  384,
    # network.addLayer('Convolutional',   13,  13,  384,    3,   3,  384,   1 ) #  384,
    # network.addLayer('Fully Connected', 13,  13,  256,    3,   3,  384,   1 ) #  256,
    # network.addLayer('Fully Connected',  1,   1, 4096,   13,  13,  256,   1 ) # 4096,
    # network.addLayer('Fully Connected',  1,   1, 4096,    1,   1, 4096,   1 ) # 4096,
    # network.addLayer('Fully Connected',  1,   1, 1024,    1,   1, 4096,   1 ) # 1024,
    
    #network.addLayer('Input',          224, 224,    3                      ) #    3 
    #network.addLayer('Convolutional',   55,  55,   10,   11,  11,    3,   4 ) #   96,
    network.addLayer('Input',           55,  55,    3,                      ) #   96,
    network.addLayer('Convolutional',   27,  27,    5,    5,   5,    3,   2 ) #  256,
    network.addLayer('Convolutional',   13,  13,   10,    3,   3,    5,   2 ) #  384,
    #network.addLayer('Convolutional',   13,  13,    8,    3,   3,   10,   1 ) #  384,
    #network.addLayer('Fully Connected', 13,  13,    6,    3,   3,    8,   1 ) #  256,
    #network.addLayer('Fully Connected',  1,   1,    6,   13,  13,    6,   1 ) # 4096,
    #network.addLayer('Fully Connected',  1,   1,    4,    1,   1,    6,   1 ) # 4096,
    #network.addLayer('Fully Connected',  1,   1,    4,    1,   1,    4,   1 ) # 1024,
    
    network.assignPEs()
    
    
    
    
    
    
    # In[82]:
    
    for l in range(1, network.numberOfLayers):
      network.Layers[l].generateConnections()
    
    
    # In[83]:
    
    layerID = 1
    network.Layers[layerID].displayTargetPECounts()
    
    
    # In[84]:
    
    numOfPEs = network.Layers[layerID].getTargetPECounts()
    
    
    
    # In[85]:
    
    opt = np.get_printoptions()
    np.set_printoptions(threshold=np.inf)
    #print numOfPEs
    #print numOfPEs.shape
    np.set_printoptions(threshold=1000)
    
    
    # In[86]:
    
    coords = np.array([[0,0],[10,10]])
    network.Layers[1].displayTargetPECountsRegion(coords)
    
    
    # In[87]:
    
    pLine = ''
    for layerID in range(1,network.numberOfLayers):
      for peY in range(network.peY) :
        for peX in range(network.peX) :
          nv = network.peArray.pe[peY][peX].findROI(layerID)
          pLine = pLine + '{0:12},{1:12}  |  '.format(nv[0], nv[1])
          network.managerArray.manager[peY][peX].memCpyROI(layerID)
        pLine = pLine + '\n'
      pLine = pLine + '\n------------------------------------------------------------'
    print pLine
    print nv[0]
    print nv[1]
    
      
    
    
    # In[88]:
    
    layerID = 1
    network.managerArray.manager[0][0].allocateMemory(memory,layerID)
    for y in range(network.managerArray.manager[0][0].roiCells[layerID][0].__len__()):
      for x in range(network.managerArray.manager[0][0].roiCells[layerID][0][0].__len__()):
        for z in range(network.managerArray.manager[0][0].roiCells[layerID].__len__()):
            print network.managerArray.manager[0][0].roiCells[layerID][z][y][x]
    
    
    # In[89]:
    
    pLine = ''
    for layerID in range(0,network.numberOfLayers):
        for y in range(network.peY) :
            for x in range(network.peX) :
                #print network.managerArray.manager[y][x]
                #print network.managerArray.manager[y][x].pe
                pLine = pLine + '{0:5}'.format(str(network.managerArray.manager[y][x].pe.cellsProcessed[layerID].__len__()))
                #for c in network.managerArray.manager[y][x].pe.cellsProcessed[layerID] : 
                #    nv = c.findROI()
                #    print c
            pLine = pLine + '\n'
        pLine = pLine + '\n\n'
    print pLine
    
    
                    
if __name__ == "__main__":main()
    




##----------------------------------------------------------------------------------------------------
##----------------------------------------------------------------------------------------------------
##              HELP
##----------------------------------------------------------------------------------------------------
##----------------------------------------------------------------------------------------------------
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
print pe_0_0.findCellsProcessedRegion(1)

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
plt.show()

levels = MaxNLocator(nbins=4).tick_values(numOfPEs.min(), numOfPEs.max())
levels = np.array([1,2,3,4])

cmap = plt.get_cmap('PiYG')
norm = BoundaryNorm(levels, ncolors=cmap.N, clip=True)

fig, ax = plt.subplots(nrows=1)

im = ax.pcolormesh(xGrid, yGrid, numOfPEs, cmap=cmap, norm=norm)
fig.colorbar(im, ax=ax)
ax.set_title('Number of target PEs')
fig.tight_layout()
plt.show()





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

