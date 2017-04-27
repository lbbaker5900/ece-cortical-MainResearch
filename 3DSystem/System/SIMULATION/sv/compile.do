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
pushd ../../../Manager/scripts  
./managerArray.py 2>&1   | tee -a ../SIMULATION/sv/$1
popd
pushd ../../scripts  
./testbench.py  2>&1  | tee -a ../SIMULATION/sv/$1
./system.py 2>&1   | tee -a ../SIMULATION/sv/$1
popd
                                                                                                                                                                 


vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/common/code/generic_fifo.v                          2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/pe/code/sram.v                                      2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/pe/code/mem_acc_cont.v                              2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/pe/code/dma_cont.v                                  2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/pe/code/streamingOps.v                              2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/pe/code/streamingOps_datapath.v                     2>&1   | tee -a $1  
vlog     +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/pe/code/noc_cntl.v                                  2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/pe/code/stack_interface.v                           2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common                                                                              ../../../PEArray/HDL/run_s/pe/code/pe_cntl.v                                   2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/pe/code/simd_wrapper.v                              2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../PEArray/HDL/run_s/pe/code/simd_upstream_intf.v                        2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                            +incdir+../../MEMORY/65nm/FIFOs/compout/views/sasslnpky2p32x35cm4sw0bk1ltlc1 ../../../PEArray/HDL/run_s/pe/code/streamingOps_cntl.v                         2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common                                                                              ../../../PEArray/HDL/run_s/pe/code/pe.v                                        2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common                                                                              ../../../PEArray/HDL/run_s/pe_array.v                                          2>&1   | tee -a $1  
                                                                                                                          


vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../Manager/HDL/run_s/manager/code/wu_fetch.v                             2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../Manager/HDL/run_s/manager/code/wu_decode.v                             2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../Manager/HDL/run_s/manager/code/wu_memory.v                            2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../Manager/HDL/run_s/manager/code/oob_downstream_cntl.v                            2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../Manager/HDL/run_s/manager/code/stu_cntl.v                             2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../Manager/HDL/run_s/manager/code/rdp_cntl.v                             2>&1   | tee -a $1  
vlog     +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../../Manager/HDL/run_s/manager/code/mgr_noc_cntl.v                         2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common                                                                              ../../../Manager/HDL/run_s/manager/code/manager.v                              2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common                                                                              ../../../Manager/HDL/run_s/manager_array.v                                     2>&1   | tee -a $1  


vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../HDL/run_s/stack_bus.v                                                    2>&1   | tee -a $1  
vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common                                                                                                                         ../../HDL/run_s/system.v                                                       2>&1   | tee -a $1  


vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/definition.sv                                   2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/environment.sv                                  2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/base_operation.sv                               2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/driver.sv                                       2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/oob_driver.sv                                   2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/generator.sv                                    2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/manager.sv                                      2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/mem_checker.sv                                  2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/upstream_checker.sv                             2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/regFile_driver.sv                               2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/loadStore_driver.sv                             2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/environment.sv                                  2>&1   | tee -a $1  
vlog -sv +define+TESTING                                                                                                                                          +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/testbench.sv                                    2>&1   | tee -a $1  
                                                                                                                                                                                                             


vlog +define+TESTING -sv     +incdir+../../HDL/common +incdir+../../SIMULATION/common                                                                                                                        +incdir+../../../PEArray/HDL/common                                                                          top.sv                                                                         2>&1   | tee -a $1  




vsim -c -sv_seed 3 -do "run.do" -novopt top 
#vsim    -sv_seed 3   -l gTranscript  -novopt top &
# transcript file ""
# transcript file 'gTranscript"


