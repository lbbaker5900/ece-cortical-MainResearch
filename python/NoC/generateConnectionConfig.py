#! /usr/bin/env python

##*********************************************************************************************
##    File name   : generateConnectionConfig.py
##    Author      : Lee Baker
##    Affiliation : North Carolina State University, Raleigh, NC
##    Date        : Nov 2016
##    email       : lbbaker@ncsu.edu
##    Description : Create a mesh NoC connection file for the workspace/cpp/InterPeNoC routine.
##                  outputfile = nocConfig_mesh8x8.txt
##
##
##*********************************************************************************************
##

#if __name__ == "__main__":

import sys
import os
import math
import random
import re

import numpy as np


PortConnectionSides = {'North' : 'South', 'South' : 'North', 'East' : 'West', 'West' : 'East'}


class Port():

    def __init__(self, parentPE, portId, portState, portNum, destPE):
        self.ID = portId
        self.State         = portState  # 'on'/'off'
        self.Number        = portNum    # 0,1,2,3 - only valid if 'on'
        self.parentPE      = parentPE
        self.DestinationPe = destPE

    def addCell(self, layerId, cellId):
        self.cellsProcessed[layerId].append(cellId)

class PE():

    def __init__(self, parentPeArray, peId):
       
        self.ID = peId
        self.parentPeArray = parentPeArray
        self.ports  = dict()

        # Keep a dictinary of port state so we can generate port numbers
        self.portState = {'North' : 'on', 'South' : 'on', 'East' : 'on', 'West' : 'on'}

        # Determine index of adjacent PEs
        northPe = np.copy(peId)
        northPe[0] -= 1
        eastPe = np.copy(peId)
        eastPe[1] += 1
        southPe = np.copy(peId)
        southPe[0] += 1
        westPe = np.copy(peId)
        westPe[1] -= 1

        # MESH Assignment
        # - set the PE idx connected to by each port
        self.portDestPe     = {'North' : northPe, 'South' : southPe, 'East' : eastPe, 'West' : westPe}
        self.portDestPeSide = PortConnectionSides 
       
        # Top of array there is no north connection
        if (peId[0] == 0) : 
          self.portState['North'] = 'off'
        # Bottom of array there is no south connection
        if (peId[0] == (self.parentPeArray.yDim-1)) : 
          self.portState['South'] = 'off'
        # Left side of array there is no West connection
        if (peId[1] == 0) : 
          self.portState['West'] = 'off'
        # Right side of array there is no East connection
        if (peId[1] == (self.parentPeArray.xDim-1)) : 
          self.portState['East'] = 'off'

        portNumber = 0
        directions = ["North", "East", "South", "West"]
        for p in directions:
            if self.portState[p] == 'on' :
                self.ports[p] = Port(self, p, 'on', portNumber, self.portDestPe[p] )
                #self.portArray.append(Port(self, p, 'on', portNumber ))
                portNumber += 1
            else :
                self.ports[p] = Port(self, p, 'off', [], [] )
                #self.portArray.append(Port(self, p, 'off', [] ))

    def addCell(self, layerId, cellId):
        self.cellsProcessed[layerId].append(cellId)

class PEarray():

    def __init__(self, peY, peX):
        self.yDim = peY
        self.xDim = peX
        self.pe = []
        self.pe = []
        for y in range(peY):
            peArrayX = []
            for x in range(peX):
                peArrayX.append(PE(self, np.array([y,x])))
            self.pe.append(peArrayX)

    def addCell(self, peId, layerId, cellId):
        self.pe[peId[0]][peId[1]].addCell(layerId, cellId)


numberOfPEsInYDirection = 8
numberOfPEsInXDirection = 8
yDim = numberOfPEsInYDirection 
xDim = numberOfPEsInXDirection 

peArray = PEarray(yDim, xDim);

outputFile = "nocConfig_mesh{0}x{1}.txt".format(yDim, xDim)
#f = open('nocConfig_mesh8x8.txt', 'w')
f = open(outputFile, 'w')
pLine = ""

pLine = pLine + '\n'

pLine = pLine + '\n//-------------------------------                 '.format(yDim,xDim)
pLine = pLine + '\n// Network Configuration                          '.format(yDim,xDim)
pLine = pLine + '\n                                                  '.format(yDim,xDim)
pLine = pLine + '\n[Config]                                          '.format(yDim,xDim)
pLine = pLine + '\nNumber of PEs in X direction = {1}                '.format(yDim,xDim)
pLine = pLine + '\nNumber of PEs in Y direction = {0}                '.format(yDim,xDim)
pLine = pLine + '\n                                                  '.format(yDim,xDim)
pLine = pLine + '\n[PE]                                              '.format(yDim,xDim)
pLine = pLine + '\nType = Normal                                     '.format(yDim,xDim)
pLine = pLine + '\n                                                  '.format(yDim,xDim)

for y in range (0, yDim ):
    for x in range (0, xDim ):
        pLine = pLine + '\n//----------------------------------------------------------             '.format(yDim,xDim,y,x)
        pLine = pLine + '\n[PE {0} {1}]                                                             '.format(y,x)
        pLine = pLine + '\nType = Normal                                                            '.format(yDim,xDim,y,x)
        directions = ["North", "East", "South", "West"]
        numberOfValidPorts = 0
        for p in directions:
            if (peArray.pe[y][x].ports[p].State == 'on') :
                numberOfValidPorts += 1
        pLine = pLine + '\nNumber of Ports = {2}                      '.format(y,x,numberOfValidPorts)
        for p in directions:
            if (peArray.pe[y][x].ports[p].State == 'on') :
                port    = peArray.pe[y][x].ports[p].Number
                dy      = peArray.pe[y][x].ports[p].DestinationPe[0]
                dx      = peArray.pe[y][x].ports[p].DestinationPe[1]
                # The .. port is connected to the port ..
                # e.g. North Port is connected to the PE above's south port
                # We have aleardy set which PE the port is connected to, now find the actual port in that PE
                dPort   = peArray.pe[dy][dx].ports[peArray.pe[y][x].portDestPeSide[p]].Number
                pLine = pLine + '\n// PE <{0},{1}> Port {2} Connected to Node <{3},{4}> port {5} '.format(y,x,p,dy,dx,peArray.pe[y][x].portDestPeSide[p])
                pLine = pLine + '\nPort {2} Connected to Node = {3} {4} {5}                      '.format(y,x,port,dy,dx,dPort)
        pLine = pLine + '\n'


pLine = pLine + '\n//-------------------------------'
pLine = pLine + '\n'
pLine = pLine + '\n'
pLine = pLine + '\n//-------------------------------'
pLine = pLine + '\n// Parameters'
pLine = pLine + '\n'
pLine = pLine + '\n[Parameters]'
pLine = pLine + '\n'
pLine = pLine + '\n'
pLine = pLine + '\n//-------------------------------'
pLine = pLine + '\n// Debug'
pLine = pLine + '\n'
pLine = pLine + '\n[Debug]'
pLine = pLine + '\n'
pLine = pLine + '\n// verbosity'
pLine = pLine + '\nVerbosity Level = 3'
pLine = pLine + '\n'
pLine = pLine + '\n'


#        yp1 = y+1
#        ym1 = y-1
#        xp1 = x+1
#        xm1 = x-1

#        pLine = pLine + '\n         //--------                                                                 '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         [PE {2} {3}]                                                             '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Type = Normal                                                            '.format(yDim,xDim,y,x)
#        numberOfPorts = 4
#        if (y == 0 ) :
#            numberOfPorts -= 1
#        if (x == 0 ) :
#            numberOfPorts -= 1
#        pLine = pLine + '\n         Number of Ports = {4}                                            '.format(yDim,xDim,y,x,numberOfPorts)
#        pLine = pLine + '\n         // Port connection : Node[Y,X] , portID    '.format(yDim,xDim,y,x)
#        for port in range (0, numberOfPorts ):
#            # Top left
#            
#            if ((x == 0 ) and (y == 0) and (port == 0))
#                pLine = pLine + '\n         Port {4} Connected to Node = 0 1 2         '.format(yDim,xDim,y,x,port)
#            elif ((x == 0 ) and (y == 0) and (port == 1))
#                pLine = pLine + '\n         Port {4} Connected to Node = 1 0 0         '.format(yDim,xDim,y,x,port)
#            # Top Right
#            elif ((x == (xDim-1) ) and (y == 0) and (port == 0))
#                pLine = pLine + '\n         Port {4} Connected to Node = 1 7 0         '.format(yDim,xDim,y,x,port)
#            elif ((x == (xDim-1) ) and (y == 0) and (port == 1))
#                pLine = pLine + '\n         Port {4} Connected to Node = 0 6 0         '.format(yDim,xDim,y,x,port)
#            # Top 
#            elif ((y == 0) and (port == 0))
#                pLine = pLine + '\n         Port {4} Connected to Node = {2} {7} 0         '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((y == 0) and (port == 1))
#                pLine = pLine + '\n         Port {4} Connected to Node = {5} {3} 0         '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((y == 0) and (port == 2))
#                pLine = pLine + '\n         Port {4} Connected to Node = {2} {8} 0         '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            # Bottom Right
#            elif ((x == (xDim-1) ) and (y == (yDim-1)) and (port == 0))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {6} {3} 0 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((x == (xDim-1) ) and (y == (yDim-1)) and (port == 1))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {2} {8} 1 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            # Bottom Left
#            elif ((x == 0 ) and (y == (yDim-1)) and (port == 0))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {6} {3} 2 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((x == (xDim-1) ) and (y == (yDim-1)) and (port == 1))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {2} {8} 3 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            # Bottom
#            elif ((y == (yDim-1)) and (port == 0))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {6} {3} 2 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((y == (yDim-1)) and (port == 1))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {2} {7} 2 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((y == (yDim-1)) and (port == 2))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {2} {8} 1 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            # Right
#            elif ((x == (xDim-1) ) and (port == 0))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {6} {3} 1 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((x == (xDim-1) ) and (port == 1))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {5} {3} 0 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((x == (xDim-1) ) and (port == 2))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {2} {8} 1 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            # Left
#            elif ((x == 0 ) and (port == 0))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {6} {3} 2 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((x == 0 ) and (port == 1))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {2} {7} 3 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            elif ((x == 0 ) and (port == 2))
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {5} {3} 0 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)
#            # Middle
#            elif (port == 0)
#                #                                                                                                                                                0        1     2 3    4        5     6     7     8
#                pLine = pLine + '\n         Port {4} Connected to Node = {6} {3} 2 '.format(yDim,xDim,y,x,port,yp1,ym1,xp1,xm1)

#        pLine = pLine + '\n         Port 1 Connected to Node = 4 1 0                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n                                                                                                '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         [PE 0 1]                                                                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Type = Normal                                                            '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Number of Ports = 4                                                '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         // Port connection : {Node{Y,X} , portID}    '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 0 Connected to Node = 0 0 0                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 1 Connected to Node = 4 0 0                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 2 Connected to Node = 0 2 0                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 3 Connected to Node = 2 2 0                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n                                                                                                '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         [PE 0 2]                                                                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Type = Normal                                                            '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Number of Ports = 4                                                '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 0 Connected to Node = 0 1 2                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 1 Connected to Node = 2 1 2                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 2 Connected to Node = 0 3 0                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 3 Connected to Node = 1 3 0                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n                                                                                                '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         [PE 0 3]                                                                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Type = Normal                                                            '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Number of Ports = 2                                                '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 0 Connected to Node = 0 2 2                     '.format(yDim,xDim,y,x)
#        pLine = pLine + '\n         Port 1 Connected to Node = 1 2 2                     '.format(yDim,xDim,y,x)








#//--------
#[PE 1 0]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 1 1 0
#Port 1 Connected to Node = 5 1 0
#
#[PE 1 1]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 1 0 0
#Port 1 Connected to Node = 5 0 0
#Port 2 Connected to Node = 1 2 0
#Port 3 Connected to Node = 3 2 0
#
#[PE 1 2]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 1 1 2
#Port 1 Connected to Node = 3 1 2
#Port 2 Connected to Node = 0 3 1
#Port 3 Connected to Node = 1 3 1
#
#[PE 1 3]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 0 2 3
#Port 1 Connected to Node = 1 2 3
#
#
#//--------
#[PE 2 0]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 2 1 0
#Port 1 Connected to Node = 6 1 0
#
#[PE 2 1]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 2 0 0
#Port 1 Connected to Node = 6 0 0
#Port 2 Connected to Node = 0 2 1
#Port 3 Connected to Node = 2 2 1
#
#[PE 2 2]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 0 1 3
#Port 1 Connected to Node = 2 1 3
#Port 2 Connected to Node = 2 3 0
#Port 3 Connected to Node = 3 3 0
#
#[PE 2 3]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 2 2 2
#Port 1 Connected to Node = 3 2 2
#
#
#//--------
#[PE 3 0]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 3 1 0
#Port 1 Connected to Node = 7 1 0
#
#[PE 3 1]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 3 0 0
#Port 1 Connected to Node = 7 0 0
#Port 2 Connected to Node = 1 2 1
#Port 3 Connected to Node = 3 2 1
#
#[PE 3 2]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 1 1 3
#Port 1 Connected to Node = 3 1 3
#Port 2 Connected to Node = 2 3 1
#Port 3 Connected to Node = 3 3 1
#
#[PE 3 3]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 2 2 3
#Port 1 Connected to Node = 3 2 3
#
#//-------------------------------
#[PE 4 0]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 0 1 1
#Port 1 Connected to Node = 4 1 1
#
#[PE 4 1]
#Type = Normal
#Number of Ports = 4
#// Port connection : {Node{Y,X} , portID}
#Port 0 Connected to Node = 0 0 1
#Port 1 Connected to Node = 4 0 1
#Port 2 Connected to Node = 4 2 0
#Port 3 Connected to Node = 6 2 0
#
#[PE 4 2]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 4 1 2
#Port 1 Connected to Node = 6 1 2
#Port 2 Connected to Node = 4 3 0
#Port 3 Connected to Node = 5 3 0
#
#[PE 4 3]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 4 2 2
#Port 1 Connected to Node = 5 2 2
#
#//--------
#[PE 5 0]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 1 1 1
#Port 1 Connected to Node = 5 1 1
#
#[PE 5 1]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 1 0 1
#Port 1 Connected to Node = 5 0 1
#Port 2 Connected to Node = 5 2 0
#Port 3 Connected to Node = 7 2 0
#
#[PE 5 2]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 5 1 2
#Port 1 Connected to Node = 7 1 2
#Port 2 Connected to Node = 4 3 1
#Port 3 Connected to Node = 5 3 1
#
#[PE 5 3]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 4 2 3
#Port 1 Connected to Node = 5 2 3
#
#
#//--------
#[PE 6 0]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 2 1 1
#Port 1 Connected to Node = 6 1 1
#
#[PE 6 1]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 2 0 1
#Port 1 Connected to Node = 6 0 1
#Port 2 Connected to Node = 4 2 1
#Port 3 Connected to Node = 6 2 1
#
#[PE 6 2]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 4 1 3
#Port 1 Connected to Node = 6 1 3
#Port 2 Connected to Node = 6 3 0
#Port 3 Connected to Node = 7 3 0
#
#[PE 6 3]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 6 2 2
#Port 1 Connected to Node = 7 2 2
#
#
#//--------
#[PE 7 0]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 3 1 1
#Port 1 Connected to Node = 7 1 1
#
#[PE 7 1]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 3 0 1
#Port 1 Connected to Node = 7 0 1
#Port 2 Connected to Node = 5 2 1
#Port 3 Connected to Node = 7 2 1
#
#[PE 7 2]
#Type = Normal
#Number of Ports = 4
#Port 0 Connected to Node = 5 1 3
#Port 1 Connected to Node = 7 1 3
#Port 2 Connected to Node = 6 3 1
#Port 3 Connected to Node = 7 3 1
#
#[PE 7 3]
#Type = Normal
#Number of Ports = 2
#Port 0 Connected to Node = 6 2 3
#Port 1 Connected to Node = 7 2 3
#
#//-------------------------------
#
#//-------------------------------
#// Parameters
#
#[Parameters]
#
#
#//-------------------------------
#// Debug
#
#[Debug]
#
#// verbosity
#Verbosity Level = 3
#
#

f.write(pLine)
f.close()

