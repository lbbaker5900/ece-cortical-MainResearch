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


pushd ../../scripts  
./testbench.py  2>&1  | tee -a ../SIMULATION/sv/$1
./peArray.py 2>&1   | tee -a ../SIMULATION/sv/$1
popd

vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common definition.sv                                                                                  2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common interface.sv                                                                                   2>&1   | tee -a $1  
                                                                                                                                                                 
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/sram.v                                                                                                     2>&1   | tee -a $1  
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/mem_acc_cont.v                                                                                             2>&1   | tee -a $1  
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/dma_cont.v                                                                                                 2>&1   | tee -a $1  
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps.v                                                                                             2>&1   | tee -a $1  
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps_datapath.v                                                                                    2>&1   | tee -a $1  
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/noc_cntl.v                                                                                                 2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common ../../HDL/run_s/pe/code/stack_interface.v                                                                                      2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common ../../HDL/run_s/pe/code/pe_cntl.v                                                                                              2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common ../../HDL/run_s/pe/code/pe.v                                                                                                   2>&1   | tee -a $1  
vlog -sv +incdir+../../MEMORY/65nm/FIFOs/compout/views/sasslnpky2p32x35cm4sw0bk1ltlc1 +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps_cntl.v       2>&1   | tee -a $1                            
vlog -sv +incdir+../../HDL/common ../../HDL/run_s/pe_array.v                                                                                                     2>&1   | tee -a $1  
                                                                                                                                                                 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common base_operation.sv                                                                              2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common driver.sv                                                                                      2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common oob_driver.sv                                                                                  2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common generator.sv                                                                                   2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common manager.sv                                                                                     2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common mem_checker.sv                                                                                 2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common regFile_driver.sv                                                                              2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common loadStore_driver.sv                                                                            2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common environment.sv                                                                                 2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common testbench.sv                                                                                   2>&1   | tee -a $1  
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common top.sv                                                                                         2>&1   | tee -a $1  



vsim -c -sv_seed 3 -do "run.do" -novopt top 
#vsim    -sv_seed 3   -l gTranscript  -novopt top &
# transcript file ""
# transcript file 'gTranscript"


