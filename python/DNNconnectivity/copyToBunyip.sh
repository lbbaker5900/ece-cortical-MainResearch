#!/bin/sh

printf "Which test ? : "

read NAME

echo "$NAME"

scp outputFiles/$NAME/*/*.dat lbbaker@bunyip.ece.ncsu.edu:/home/lbbaker/Cortical/ece-cortical-MainResearch/3DSystem/System/SIMULATION/sv/inputFiles/. ; \
scp outputFiles/$NAME/manager_*/manager_*_*_layer1_{group_?_AllGroupMemory.txt,WUs.txt} lbbaker@bunyip.ece.ncsu.edu:/home/lbbaker/Cortical/ece-cortical-MainResearch/3DSystem/System/SIMULATION/sv/configFiles/.


