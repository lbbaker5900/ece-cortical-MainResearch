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

#vlog  +incdir+../../MEMORY/65nm/FIFOs/compout/views/sasslnpky2p32x35cm4sw0bk1ltlc1 +incdir+../../HDL/common +define+STREAMINGOPS_CNTL_INCLUDE_REAL_MEMORY ../../HDL/run_s/pe/code/streamingOps_cntl.v
#vlog  +incdir+../../MEMORY/65nm/FIFOs/compout/views/sasslnpky2p32x35cm4sw0bk1ltlc1 +incdir+../../HDL/common ../../HDL/run_s/pe/code/streamingOps_cntl.v
#vlog  +incdir+../../HDL/common +define+DEBUG_NOC_LOOPBACK ../../HDL/run_s/pe/code/noc_cntl.v

# vsim -novopt test_fixture &
# vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt test_fixture &

# vsim -novopt -c -do "run.do" test_fixture
# vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture

