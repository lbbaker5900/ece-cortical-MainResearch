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
import sys
import os

##DEBUG = []

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


class Cell():

    def __init__(self, parentLayer):
        self.PE = np.empty(2)
        # keep track of the {x,y} location of PE processing this cell
        self.peID = np.empty(2)
        # Fanin and fanout of this cell
        self.sourceCells = dict() 
        self.targetCells = dict()
        self.sourcePEs = dict() # index using tuple(PE{x,y}) to find how many cells in PE{x,y} this cell connect to
        self.targetPEs = dict() # index using tuple(PE{x,y}) to find how many cells in PE{x,y} this cell connect to
        self.layerID = parentLayer.layerID
        self.parentLayer = parentLayer



class Layer():

    def __init__(self, network, layerID, type, X, Y, Z, Kx=0, Ky=0, Kz=0, stride=0):
        self.parentNetwork = network
        self.layerID = layerID
        self.type = type
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
                newCell = Cell(self)
                xCells.append(newCell)
            yCells.append(xCells)
          self.cells.append(yCells)

    def getPreviousLayer(self):
        return self.parentNetwork.getLayer(self.layerID-1)

    #----------------------------------------------------------------------------------------------------
    # PE assignment

    def assignPEs(self, peX, peY): # assign an array of X by Y PE's
        # e.g. each PE will be assigned a set of X-Y-Z feature maps
        # for example, with a 55x55x256 array of feature maps, PE{0,0} may be assigned a 6x6x256 array of feature maps
        # where PE{0,1} may be assigned a 7x7x256 array of feature maps

        # Create an array of lists with each PE assigned a list
        # This list will contain index of all cells assigned to the PE

        self.peArrayXYcellCount = []
        for y in range(peY):
          eX = []
          for x in range(peX):
              eX.append(np.zeros(2))
          self.peArrayXYcellCount.append(eX)

        # 
        #                                                  X
        #     |-----------------------------------------------------------------------------------------|
        #            n         
        #     |-------------|-------------|-------------|-------------|-------------|-------------|
        #                                                                                          k~1-7
        #                                                                                         |-----|

        # we add a column to k PE's so k PE's will have 'n+1' columns with the remainder PE's having 'n' columns

        # We know the remainder of X/l is less than peX, so between 1 and 7
        # So now keep iterating by deleting n+1 nitially from X to create Xp, we will reach a point where Xp is an integer multiple of l and 8-l multiples of n+1
        
        nx=np.floor(self.X*self.Z/peX) # n is the integer part meaning peX-1 PE's will be assigned n columns and the peXth PE would be assigned X-(peX-1)*n cols
        #l=peX
        #Xp = self.X
        #while np.remainder(Xp, l) != 0 :
        #   Xp = Xp - (n+1)
        #   l = l-1
        #m=peX-l
        #self.m = m
        #self.l = l
        mx=np.remainder(self.X*self.Z, peX)
        lx=peX-mx
        nxp1 = nx+1
      
        for y in range(peY):
            for x in range(peX):
                if x<lx:
                    self.peArrayXYcellCount[y][x][1] = int(nx)
                    #print 'DEBUG1 ', y, x
                else:              
                    #print 'DEBUG2 ', y, x
                    self.peArrayXYcellCount[y][x][1] = int(nx+1)



        ny=np.floor(self.Y/peY) # n is the integer part meaning peX-1 PE's will be assigned n columns and the peXth PE would be assigned X-(peX-1)*n cols
        my=np.remainder(self.Y, peY)
        ly=peY-my
        nyp1 = ny+1
      
        for y in range(peY):
            for x in range(peX):
                if y<my:            
                    self.peArrayXYcellCount[y][x][0] = int(ny+1)
                else:              
                    self.peArrayXYcellCount[y][x][0] = int(ny)


        # Let each cell in the layer know which PE it is assigned to
        # and let each PE in the PE array know its processing this cell
        # print 'LEE:DEBUG:assign PE:', peY, peX
        yOffset = 0 # keep track of the row cell number and construct z,y,x location based on number of features and cells per PE
        for yPe in range(peY):
            xOffset = 0  # keep track of the column cell number and construct z,y,x location based on number of features and cells per PE
            for xPe in range(peX):
                for yCell in range(int(self.peArrayXYcellCount[yPe][xPe][0])):
                #for i in range(yOffset, yOffset+int(self.peArrayXYcellCount[y][x][0,0])):
                #for j in range(xOffset, xOffset+int(self.peArrayXYcellCount[y][x][0,1])):
                    for xCell in range(int(self.peArrayXYcellCount[yPe][xPe][1])):
                        f=np.remainder(xOffset+xCell,self.Z)
                        x=int((xOffset+xCell)/self.Z)
                        #y=int((yOffset+yCell)/self.Z)
                        y=yCell+yOffset
                        # index is z,y,x
                        try:
                            self.cells[f][y][x].PE = [yPe,xPe]
                            self.parentNetwork.peArray.addCell(np.array([yPe,xPe]), self.layerID, np.array([f,y,x]))
                            #print 'LEE:DEBUG:AddCell', self.layerID,':', f ,y ,x
                            #print 'LEE:DEBUG:', self.layerID,':', yCell, xCell, f ,y ,x, xOffset, yOffset, xPe, yPe, self.peArrayXYcellCount[yPe][xPe], self.Z, self.Y, self.X
                        except:
                            print 'LEE:DEBUG:', self.layerID,':', yCell, xCell, f ,y ,x, xOffset, yOffset, xPe, yPe, self.peArrayXYcellCount[yPe][xPe], self.Z, self.Y, self.X
                            raise
                xOffset += int(self.peArrayXYcellCount[yPe][xPe][1])
            yOffset += int(self.peArrayXYcellCount[yPe][xPe][0])
    #----------------------------------------------------------------------------------------------------
      
    def updateSourceCellsTargetList(self):
        # For each cell in this layer, identify the cells from the previous layer that feed this cell and add this cell's PE
        # to the target list
        for y in range(self.Y):
            for x in range(self.X):
                for f in range(self.Z):

                    #print 'Updating Layer ', self.layerID, ' cell {', y, ',', x, '} target cells'
                    #print self.stride, self.Ky, self.Kx, self.kernelTopOffset, self.kernelLeftOffset
             
                    # Identify the row and columns of the source cells from layer n-1
                    tmpY = range(max(0, self.kernelTopOffset+y*self.stride), min(self.parentNetwork.Layers[self.layerID-1].Y, self.kernelTopOffset+y*self.stride+self.Ky))
                    tmpX = range(max(0, self.kernelLeftOffset+x*self.stride), min(self.parentNetwork.Layers[self.layerID-1].X, self.kernelLeftOffset+x*self.stride+self.Kx))
             
                    #print 'Layer n-1 cells for Layer n cell {', x, ',', y, '}'
                    #print 'Y : ', tmpY
                    #print 'X : ', tmpX
             
                    # Cycle thru the source cells and 
                    #   a) add this cells PE to the list of target PE's of the source cell
                    #   b) add this cells ID to the list of target cell's of the source cell
                    #   c) Add the source cells to this cells list of source cells
                    #   d) Add the source cells PE to this cells list of source PE's
                    for ySrcCell in tmpY:
                        for xSrcCell in tmpX:
                            for fSrcCell in range(self.parentNetwork.Layers[self.layerID-1].Z) :
             
                                #print '{', ySrcCell,',', xSrcCell, '}', type(self.parentNetwork.Layers[self.layerID-1].cells[ySrcCell][xSrcCell].targetPEs)
                                #print list(self.parentNetwork.Layers[self.layerID-1].cells[ySrcCell][xSrcCell].targetPEs.keys())
                                # a) Update source cells target PE list
                                try :
                                    if tuple(list(self.cells[f][y][x].PE)) in self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetPEs:
                                        pass
                                        self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetPEs[tuple(self.cells[f][y][x].PE)] += 1
                                    else:
                                        pass
                                        self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetPEs.update({tuple(list(self.cells[f][y][x].PE)) : 1})
                                except :
                                    print 'LEE:DEBUG:', self.layerID,':', ySrcCell, xSrcCell, f, y, x, tuple(self.cells[0][y][x].PE), tmpY, tmpX
                                    raise
             
                                # b) Update source cells target cell list
                                if tuple([f,y,x]) in self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetCells:
                                    pass
                                    self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetCells[tuple([f,y,x])] += 1
                                else:
                                    pass
                                    self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].targetCells.update({tuple([f,y,x]) : 1})
                             
                                srcPE = tuple(self.parentNetwork.Layers[self.layerID-1].cells[fSrcCell][ySrcCell][xSrcCell].PE)
                                srcCell = tuple([fSrcCell, ySrcCell, xSrcCell])
                             
                                # c) Update this cells source PE list
                                if srcPE in self.cells[f][y][x].sourcePEs :
                                    pass
                                    self.cells[f][y][x].sourcePEs[srcPE] += 1
                                else:
                                    pass
                                    self.cells[f][y][x].sourcePEs.update({srcPE : 1})
             
                                # d) Update this cells source cell list
                                if srcCell in self.cells[f][y][x].sourceCells :
                                    pass
                                    self.cells[f][y][x].sourceCells[srcCell] += 1
                                else:
                                    pass
                                    self.cells[f][y][x].sourceCells.update({srcCell : 1})
                        

    def calculateKernelOffset(self):
        # Determine Kernel overlap at edge of input array
        if self.layerID != 0:
            self.kernelLeftOffset = int(((self.parentNetwork.Layers[self.layerID-1].X) - ((self.X-1)*self.stride+self.Kx))/2)
            self.kernelTopOffset  = int(((self.parentNetwork.Layers[self.layerID-1].Y) - ((self.Y-1)*self.stride+self.Ky))/2)
        else:
            self.kernelLeftOffset = 0
            self.kernelTopOffset  = 0
        print 'Layer ', self.layerID, ' left Kernel offset is ', int(self.kernelLeftOffset),  ', top Kernel offset is ', int(self.kernelTopOffset) 

    def getNumberOfMultiplies(self):
            return self.getNumberOfKernelParameters() * self.getNumberOfCells()

    def getNumberOfAdditions(self):
            return (self.getNumberOfMultiplies() -1) 

    def getNumberOfParameters(self):
            return self.getNumberOfKernelParameters() * self.Z

    def getNumberOfKernelParameters(self):
            return self.Kx*self.Ky*self.Kz

    def getNumberOfCells(self):
            return self.X*self.Y*self.Z

    ##----------------------------------------------------------------------------------------------------
    ## Display Routines


    def displayPeCellArrangement(self):
        print 'Layer ', self.layerID, ' PE pixel assignments'
        for y in range(peY):
            for x in range(peX):
                print '{', y, ',', x, '} : ', self.peArrayXYcellCount[y][x]


    def displayCellPeAssignments(self):
        for y in range(self.Y):
            for x in range(self.X):
                print self.cells[0][y][x].PE, ' ', 
            print

    def displayTargetPEs(self):
        for y in range(self.Y):
            for x in range(self.X):
                print self.cells[0][y][x].targetPEs, '||||', 
            print

    def displayTargetCells(self):
        for y in range(self.Y):
            for x in range(self.X):
                print self.cells[0][y][x].targetCells, '||||', 
            print

    def displaySourcePEs(self):
        for y in range(self.Y):
            for x in range(self.X):
                print self.cells[0][y][x].sourcePEs, '||||', 
            print

    def displaySourceCells(self, cellCoords=[]):
        if len(cellCoords) == 0:
            for y in range(self.Y):
                for x in range(self.X):
                    print self.cells[0][y][x].sourceCells, '||||', 
                print
        else:
            print self.cells[0][cellCoords[0]][cellCoords[1]].sourceCells, '||||', 

    def getSourceCells(self, cellCoords):
        return self.cells[cellCoords[0]][cellCoords[1]][cellCoords[2]].sourceCells

    def getTargetCells(self, cellCoords):
        return self.cells[cellCoords[0]][cellCoords[1]][cellCoords[2]].targetCells

    def getSourcePEs(self, cellCoords):
        return self.cells[cellCoords[0]][cellCoords[1]][cellCoords[2]].sourcePEs

    def getTargetPEs(self, cellCoords):
        return self.cells[cellCoords[0]][cellCoords[1]][cellCoords[2]].targetPEs

    def displayNumberOfCells(self):
        print 'Layer ', self.layerID, 'number of cells is ', self.X*self.Y*self.Z

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
                    


class PE():

    def __init__(self, parentPEarray, numberOfLayers, peId):
        self.ID = peId
        self.cellsProcessed = []
        # cellsProcessed is a vector with each entry being a list of cells this PE processes at a particular layer
        for l in range(numberOfLayers):
          self.cellsProcessed.append([])
        self.parentPEarray = parentPEarray

    def addCell(self, layerId, cellId):
        self.cellsProcessed[layerId].append(cellId)

class PEarray():

    def __init__(self, parentNetwork, peY, peX, numberOfLayers):
        self.parentNetwork = parentNetwork
        self.pe = []
        for y in range(peY):
            peArrayX = []
            for x in range(peX):
                peArrayX.append(PE(self, numberOfLayers, np.array([y,x])))
            self.pe.append(peArrayX)

    def addCell(self, peId, layerId, cellId):
        self.pe[peId[0]][peId[1]].addCell(layerId, cellId)

class Network():

    def __init__(self, peY=8, peX=8, maxNumberOfLayers=10):
        self.numberOfLayers = 0
        self.maxNumberOfLayers = maxNumberOfLayers
        self.Layers = []
        self.peY = peY
        self.peX = peX
        #self.peArray = PEarray(self, peY, peX, self.maxNumberOfLayers)


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
        self.peArray = PEarray(self, self.peY, self.peX, self.numberOfLayers)
        # assign PE's to each cell of each layer
        for l in self.Layers:
            l.assignPEs(self.peX,self.peY)
            l.calculateKernelOffset()

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
      

network = Network()
#                                    X    Y    Z    Kx   Ky   Kz   stride
# network.addLayer('Input',          224, 224,    3                      ) #    3 
# network.addLayer('Convolutional',   55,  55,   96,   11,  11,    3,   4 ) #   96,
# network.addLayer('Convolutional',   27,  27,  256,    5,   5,   96,   2 ) #  256,
# network.addLayer('Convolutional',   13,  13,  384,    3,   3,  256,   2 ) #  384,
# network.addLayer('Convolutional',   13,  13,  384,    3,   3,  384,   1 ) #  384,
# network.addLayer('Fully Connected', 13,  13,  256,    3,   3,  384,   1 ) #  256,
# network.addLayer('Fully Connected',  1,   1, 4096,   13,  13,  256,   1 ) # 4096,
# network.addLayer('Fully Connected',  1,   1, 4096,    1,   1, 4096,   1 ) # 4096,
# network.addLayer('Fully Connected',  1,   1, 1024,    1,   1, 4096,   1 ) # 1024,

network.addLayer('Input',          224, 224,    3                      ) #    3 
network.addLayer('Convolutional',   55,  55,   10,   11,  11,    3,   4 ) #   96,
network.addLayer('Convolutional',   27,  27,    5,    5,   5,   10,   2 ) #  256,
network.addLayer('Convolutional',   13,  13,   10,    3,   3,    5,   2 ) #  384,
network.addLayer('Convolutional',   13,  13,    8,    3,   3,   10,   1 ) #  384,
network.addLayer('Fully Connected', 13,  13,    6,    3,   3,    8,   1 ) #  256,
network.addLayer('Fully Connected',  1,   1,    6,   13,  13,    6,   1 ) # 4096,
network.addLayer('Fully Connected',  1,   1,    4,    1,   1,    6,   1 ) # 4096,
network.addLayer('Fully Connected',  1,   1,    4,    1,   1,    4,   1 ) # 1024,
network.assignPEs()

for l in [1,2,3,4]:
    print l
    network.Layers[l].updateSourceCellsTargetList()
        

# network.updateSourceCellsTargetList()

#print network.Layers[5].displayPeAssignments()
#print 'Targets for layer n-1'
#print network.displayTargetPEs()
#print network.displayTargetCells()
#print network.displaySourcePEs()
#print network.displaySourceCells()

#print network.displaySourceCells(1, np.array([0,0]))

# import LayerPartitioning as l
# reload(l)

if 'DEBUG' in globals():
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

##----------------------------------------------------------------------------------------------------
##----------------------------------------------------------------------------------------------------
##              HELP
##----------------------------------------------------------------------------------------------------
##----------------------------------------------------------------------------------------------------

#from createRoutingTable import *
#network.displayPeAssignments()
#network.displayCellsPerLayer()
#network.updateSourceCellsTargetList()
#
#for l in network.Layers:
#    if l.layerID != 0 :
#        print l.layerID
#        l.updateSourceCellsTargetList()
##        l.assignPEs(8,8)
        
    

