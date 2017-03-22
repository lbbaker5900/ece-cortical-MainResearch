#! /bin/bash

PROGNAME=$(basename $0)

# exit on error
set -e
set -o pipefail

# from www.linuxcommand.org/lc3_wss0140.php
error_exit() {
    echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
    #error_exit "$LINENO: An error has occurred."
    #echo "$1" 1>&2
    exit 1
}

/bin/touch $1 ; /bin/rm $1


#DIR=$1
DIR="mti_lib"

if [ ! -d $DIR ];
then
    echo "Create library"
    vlib mti_lib
fi


pushd ../../../PEArray/scripts  
./testbench.py  2>&1  | tee -a ../SIMULATION/sv/$1
./peArray.py 2>&1   | tee -a ../SIMULATION/sv/$1
popd
pushd ../../scripts  
./managerArray.py 2>&1   | tee -a ../SIMULATION/sv/$1
popd
                                                                                                                                                                 
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../SIMULATION/common                   ../../../PEArray/HDL/run_s/common/code/generic_fifo.v       2>&1   | tee -a $1  
vlog     +define+TESTING     +incdir+../../HDL/common +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../SIMULATION/common                   ../../../PEArray/HDL/run_s/pe/code/noc_cntl.v               2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../SIMULATION/common                   ../../HDL/run_s/manager/code/wu_fetch.v                     2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../SIMULATION/common                   ../../HDL/run_s/manager/code/wu_memory.v                    2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../SIMULATION/common                   ../../HDL/run_s/manager/code/manager.v                      2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../SIMULATION/common                   ../../HDL/run_s/manager_array.v                             2>&1   | tee -a $1  
                                                                                                                                                                 








#vsim -c -sv_seed 3 -do "run.do" -novopt top 
#vsim    -sv_seed 3   -l gTranscript  -novopt top &
# transcript file ""
# transcript file 'gTranscript"


