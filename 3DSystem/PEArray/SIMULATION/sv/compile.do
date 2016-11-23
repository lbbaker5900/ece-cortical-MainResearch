
vlog  +incdir+../../HDL/common ../../HDL/run_s/pe/code/sram.v
vlog  +incdir+../../HDL/common ../../HDL/run_s/pe/code/mem_acc_cont.v
vlog  +incdir+../../HDL/common ../../HDL/run_s/pe/code/dma_cont.v
vlog  +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps.v
vlog  +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps_datapath.v
vlog  +incdir+../../HDL/common ../../HDL/run_s/pe/code/noc_cntl.v
vlog  +incdir+../../HDL/common ../../HDL/run_s/pe/code/stack_interface.v
vlog  +incdir+../../HDL/common ../../HDL/run_s/pe/code/pe.v
vlog  +incdir+../../MEMORY/65nm/FIFOs/compout/views/sasslnpky2p32x35cm4sw0bk1ltlc1 +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps_cntl.v
vlog  +incdir+../../HDL/common ../../HDL/run_s/pe_array.v

vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common definition.sv
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common base_operation.sv
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common interface.sv
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common driver.sv
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common generator.sv
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common mem_checker.sv
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common environment.sv
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common testbench.sv
vlog -sv +incdir+../../HDL/common +incdir+../../SIMULATION/common top.sv



#vsim -c -sv_seed 3 -do "run.do" -novopt top 
#vsim    -sv_seed 3              -novopt top &

