#! /bin/bash

LIB_DIR=mti_lib

#library: mti_lib
#	vlib $(LIB_DIR)

all : .Py .peTbPy .pePy .mgrPy .sysTbPy .sysPy .dwMgr .dwPe .generic_1port_memory .generic_2port_memory .generic_fifo .generic_pipelined_fifo .sram .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .stack_interface .pe_cntl .simd_wrapper .simd_core .simd_upstream_intf .streamingOps_cntl .pe .pe_array .definition .base_operation .driver .oob_driver .generator .tb_manager .mem_checker .regFile_driver .loadStore_driver .environment .testbench .top 

clean : 
	/bin/rm .peTbPy .pePy .mgrPy .sysTbPy .sysPy .dwMgr .dwPe .generic_1port_memory .generic_2port_memory .generic_fifo .generic_pipelined_fifo .sram .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .stack_interface .pe_cntl .simd_wrapper .simd_core .simd_upstream_intf .streamingOps_cntl .pe .pe_array .definition .base_operation .driver .oob_driver .generator .tb_manager .mem_checker .regFile_driver .loadStore_driver .environment .testbench .top 
	/bin/rm -rf mti_lib
	vlib mti_lib

cleanPy : 
	/bin/rm .Py .peTbPy .pePy .mgrPy .sysTbPy .sysPy 

.peTbPy : ../../../PEArray/scripts/testbench.py
	pushd ../../../PEArray/scripts; ./testbench.py  ; popd
	touch .peTbPy

.pePy : ../../../PEArray/scripts/peArray.py
	pushd ../../../PEArray/scripts; ./peArray.py  ; popd
	touch .pePy

.mgrPy: ../../../Manager/scripts/managerArray.py 
	pushd ../../../Manager/scripts  ; ./managerArray.py ; popd
	touch .mgrPy

.sysTbPy : ../../../System/scripts/testbench.py
	pushd ../../../System/scripts; ./testbench.py  ; popd
	touch .sysTbPy

.sysPy : ../../../System/scripts/system.py
	pushd ../../../System/scripts; ./system.py  ; popd
	touch .sysPy

.Py : .sysPy .sysTbPy .mgrPy .pePy .peTbPy
	touch .Py


#FIXME  : MEM_CHECK_OFF ????
.dwMgr    : ../../../Manager/HDL/run_s/manager/synth/dw_memories/compout/views/*/std*.v 
	vlog -sv +define+VIRAGE_FAST_VERILOG+MEM_CHECK_OFF+VIRAGE_IGNORE_RESET                       +incdir+../../../Manager/HDL/common ../../../Manager/HDL/run_s/manager/synth/dw_memories/compout/views/*/*_fast_func.v           2>&1   | tee -a $1
	vlog -sv +define+_fv+VIRAGE_FAST_VERILOG+MEM_CHECK_OFF+VIRAGE_IGNORE_RESET+VIRL_functiononly +incdir+../../../Manager/HDL/common  /home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/verilog/3.0/cp65npksdst.v       2>&1   | tee -a $1
	touch .dwMgr

.dwPe    : ../../../PEArray/HDL/run_s/pe/synth/dw_memories/compout/views/*/std*.v 
	vlog -sv +define+VIRAGE_FAST_VERILOG+MEM_CHECK_OFF+VIRAGE_IGNORE_RESET                       +incdir+../../../Manager/HDL/common ../../../PEArray/HDL/run_s/pe/synth/dw_memories/compout/views/*/*_fast_func.v           2>&1   | tee -a $1
	vlog -sv +define+_fv+VIRAGE_FAST_VERILOG+MEM_CHECK_OFF+VIRAGE_IGNORE_RESET+VIRL_functiononly +incdir+../../../Manager/HDL/common  /home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/verilog/3.0/cp65npksdst.v       2>&1   | tee -a $1
	touch .dwPe


.generic_1port_memory :  ../../../PEArray/HDL/run_s/common/code/generic_1port_memory.v ../../../Manager/HDL/common/generic_memories.vh
	vlog -sv +define+TESTING  +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_1port_memory.v
	touch .generic_1port_memory
	echo "generic_1port_memory"

.generic_2port_memory :  ../../../PEArray/HDL/run_s/common/code/generic_2port_memory.v ../../../Manager/HDL/common/generic_memories.vh
	vlog -sv +define+TESTING  +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_2port_memory.v
	touch .generic_2port_memory
	echo "generic_2port_memory"

.generic_fifo : ../../../PEArray/HDL/run_s/common/code/generic_fifo.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_fifo.v
	touch .generic_fifo
	echo "generic_fifo"

.generic_pipelined_fifo : ../../../PEArray/HDL/run_s/common/code/generic_pipelined_fifo.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_pipelined_fifo.v
	touch .generic_pipelined_fifo
	echo "generic_pipelined_fifo"


.sram : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/HDL/run_s/pe/code/sram.v  
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     ../../../PEArray/HDL/run_s/pe/code/sram.v  
	echo "sram"
	touch .sram

.mem_acc_cont :  ../../HDL/common/*vh ../../SIMULATION/common/*vh ../../../PEArray/HDL/common/*vh ../../../Manager/HDL/common/*vh           ../../../PEArray/HDL/run_s/pe/code/mem_acc_cont.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common       ../../../PEArray/HDL/run_s/pe/code/mem_acc_cont.v
	echo "mem_acc_cont"
	touch .mem_acc_cont

.dma_cont : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/dma_cont.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/dma_cont.v 
	echo "dma_cont"
	touch .dma_cont

.streamingOps : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh         ../../../PEArray/HDL/run_s/pe/code/streamingOps.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common         ../../../PEArray/HDL/run_s/pe/code/streamingOps.v 
	echo "streamingOps"
	touch .streamingOps

.streamingOps_datapath:    ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/streamingOps_datapath.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/streamingOps_datapath.v 
	echo "streamingOps_datapath"
	touch .streamingOps_datapath

.stack_interface : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/stack_interface.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/stack_interface.v
	echo "stack_interface"
	touch .stack_interface

.pe_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../System/HDL/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh        ../../../PEArray/HDL/run_s/pe/code/pe_cntl.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../System/HDL/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../PEArray/HDL/run_s/pe/code/pe_cntl.v
	echo "pe_cntl"
	touch .pe_cntl

.simd_wrapper : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/simd_wrapper.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/simd_wrapper.v
	echo "simd_wrapper"
	touch .simd_wrapper

.simd_core : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/simd_core.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/simd_core.v
	echo "simd_core"
	touch .simd_core

.simd_upstream_intf : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/simd_upstream_intf.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/simd_upstream_intf.v
	echo "simd_upstream_intf"
	touch .simd_upstream_intf

.streamingOps_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh    ../../../PEArray/HDL/run_s/pe/code/streamingOps_cntl.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../MEMORY/65nm/FIFOs/compout/views/sasslnpky2p32x35cm4sw0bk1ltlc1 ../../../PEArray/HDL/run_s/pe/code/streamingOps_cntl.v 
	echo "streamingOps_cntl"
	touch .streamingOps_cntl

.pe : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh                  ../../../PEArray/HDL/run_s/pe/code/pe.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common                  ../../../PEArray/HDL/run_s/pe/code/pe.v
	echo "pe"
	touch .pe

.pe_array : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh        ../../../PEArray/HDL/run_s/pe_array.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../PEArray/HDL/run_s/pe_array.v 
	echo "pe_array"
	touch .pe_array



.definition :  ../../../PEArray/SIMULATION/sv/definition.sv
	vlog -sv +define+TESTING        +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/definition.sv
	echo "definition"
	touch .definition

.base_operation : ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/base_operation.sv
	vlog -sv +define+TESTING  +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/base_operation.sv
	echo "base_operation"
	touch .base_operation

.driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/driver.sv 
	vlog -sv +define+TESTING        +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/driver.sv 
	echo "driver"
	touch .driver

.oob_driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv ../../../Manager/HDL/common/manager.vh  ../../../PEArray/SIMULATION/sv/oob_driver.sv 
	vlog -sv +define+TESTING +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/oob_driver.sv 
	echo "oob_driver"
	touch .oob_driver

.generator : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/generator.sv
	vlog -sv +define+TESTING +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/generator.sv
	echo "generator"
	touch .generator

.tb_manager : ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/manager.sv
	vlog -sv +define+TESTING+TB_ENABLE_WUD_INITIATE_OP +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/manager.sv
	echo "manager.sv"
	touch .tb_manager

.mem_checker : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/mem_checker.sv
	vlog -sv +define+TESTING  +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/mem_checker.sv
	echo "mem_checker"
	touch .mem_checker

.regFile_driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv  ../../../PEArray/SIMULATION/common/*.vh     ../../../PEArray/SIMULATION/sv/regFile_driver.sv
	vlog -sv +define+TESTING  +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/regFile_driver.sv
	echo "regFile_driver"
	touch .regFile_driver

.loadStore_driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/loadStore_driver.sv
	vlog -sv +define+TESTING +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/loadStore_driver.sv
	echo "loadStore_driver"
	touch .loadStore_driver

.environment : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      environment.sv
	vlog -sv +define+TESTING+TB_ENABLE_WUD_INITIATE_OP +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      environment.sv
	echo "environment"
	touch .environment

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Note: testbench includes environment which incldues all .sv files
#  - make sure any required defines are added to the etsbnech compile
#
.testbench : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      testbench.sv
	vlog -sv +define+TESTING+TB_ENABLE_WUD_INITIATE_OP +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      testbench.sv
	echo "testbench"
	touch .testbench

.top : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh  ../../../PEArray/SIMULATION/common/*.vh       top.sv 
	vlog -sv +define+TESTING +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common        top.sv 
	#vlog -sv +define+TESTING +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common        top.sv 
	echo "top"
	touch .top

vsim : .peTbPy .pePy .mgrPy .sysTbPy .sysPy .generic_1port_memory .generic_2port_memory .generic_fifo .generic_pipelined_fifo .sram .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .stack_interface .pe_cntl .simd_wrapper .simd_core .simd_upstream_intf .streamingOps_cntl .pe .pe_array .definition .base_operation .driver .oob_driver .generator .tb_manager .mem_checker .regFile_driver .loadStore_driver .environment .testbench .top 
	vsim -c -sv_seed 3 -do "run.do" -novopt top 
	grep ERROR transcript ; grep PASS transcript | wc -l
	echo 'Expect 96 passes per pe. 64 = 6144, 4 = 384'

gvsim : .peTbPy .pePy .mgrPy .sysTbPy .sysPy .generic_1port_memory .generic_2port_memory .generic_fifo .generic_pipelined_fifo .sram .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .stack_interface .pe_cntl .simd_wrapper .simd_core .simd_upstream_intf .streamingOps_cntl .pe .pe_array .definition .base_operation .driver .oob_driver .generator .tb_manager .mem_checker .regFile_driver .loadStore_driver .environment .testbench .top 
	vsim    -sv_seed 3   -l gTranscript  -novopt top


.gates : ../../HDL/run_s/pe/synth/logs/pe/pe_final.v ./simGates/pe_cntl.v
	vlog ../../HDL/run_s/pe/synth/logs/pe/pe_final.v 
	vlog -sv +define+TB_PE_ONLY_GATES+TB_ENABLE_REGFILE_DRIVER+TESTING +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common   top.sv 
	echo "top"                                                                           
	touch .top                                                                           
	#                                                                                    
	vlog -sv +define+TB_PE_ONLY_GATES+TB_ENABLE_REGFILE_DRIVER+TESTING +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/mem_checker.sv
	echo "mem_checker"                                                                   
	touch .mem_checker                                                                   
	#                                                                                    
	vlog -sv +define+TB_PE_ONLY_GATES+TB_ENABLE_REGFILE_DRIVER+TESTING +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/sv  ../../../PEArray/SIMULATION/sv/oob_driver.sv 
	echo "oob_driver"
	touch .oob_driver
	#
	# Remember, enviroment re-reads all the SV files
	vlog -sv +define+TB_PE_ONLY_GATES+TB_ENABLE_REGFILE_DRIVER+TESTING+TB_ENABLE_WUD_INITIATE_OP +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv  environment.sv
	echo "environment"                                                                   
	touch .environment                                                                   
	#                                                                                    
	# Remember, testbench includes enviroment
	vlog -sv -sv +define+TB_PE_ONLY_GATES+TB_ENABLE_REGFILE_DRIVER+TESTING+TB_ENABLE_WUD_INITIATE_OP +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      testbench.sv
	echo "testbench"
	touch .testbench
	#
	# modules required to be modified 
	vlog simGates/pe_cntl.v
	#
	echo "gates"
	touch .gates

vsimgates : .gates
	vsim -c -sv_seed 3 -do "run.do" -novopt top 
	grep ERROR transcript ; grep PASS transcript | wc -l
	echo 'Expect 96 passes per pe. 64 = 6144, 4 = 384'

gvsimgates : .gates
	vsim    -sv_seed 3   -l gTranscript  -novopt top
