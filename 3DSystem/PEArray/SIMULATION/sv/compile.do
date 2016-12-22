
/bin/rm log

pushd ../../scripts  
./testbench.py > ../SIMULATION/sv/log 2>&1 
./peArray.py >> ../SIMULATION/sv/log 2>&1 
popd

vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common definition.sv       >> log 2>&1 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common interface.sv      >> log 2>&1 

vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/sram.v      >> log 2>&1 
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/mem_acc_cont.v      >> log 2>&1 
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/dma_cont.v      >> log 2>&1 
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps.v      >> log 2>&1 
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps_datapath.v      >> log 2>&1 
vlog +incdir+../../HDL/common ../../HDL/run_s/pe/code/noc_cntl.v      >> log 2>&1 
vlog -sv +incdir+../../HDL/common ../../HDL/run_s/pe/code/stack_interface.v      >> log 2>&1 
vlog -sv  +incdir+../../HDL/common ../../HDL/run_s/pe/code/pe.v      >> log 2>&1 
vlog -sv  +incdir+../../MEMORY/65nm/FIFOs/compout/views/sasslnpky2p32x35cm4sw0bk1ltlc1 +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps_cntl.v      >> log 2>&1 
vlog -sv  +incdir+../../HDL/common ../../HDL/run_s/pe_array.v      >> log 2>&1 

vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common base_operation.sv      >> log 2>&1 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common driver.sv      >> log 2>&1 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common generator.sv      >> log 2>&1 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common mem_checker.sv      >> log 2>&1 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common regFile_driver.sv      >> log 2>&1 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common loadStore_driver.sv      >> log 2>&1 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common environment.sv      >> log 2>&1 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common testbench.sv      >> log 2>&1 
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common top.sv      >> log 2>&1 



vsim -c -sv_seed 3 -do "run.do" -novopt top 
#vsim    -sv_seed 3              -novopt top &

