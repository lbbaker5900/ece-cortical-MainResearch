#! /bin/bash

LIB_DIR=mti_lib

#library: mti_lib
#	vlib $(LIB_DIR)

all : .peTbPy .pePy .mgrPy .sysTbPy .sysPy .generic_fifo .sram .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .noc_cntl .stack_interface .pe_cntl .simd_wrapper .simd_upstream_intf .streamingOps_cntl .pe .pe_array .wu_fetch .wu_decode .wu_memory .oob_downstream_cntl .stu_cntl .rdp_cntl .mrc_cntl .mgr_noc_cntl .manager .manager_array .stack_bus .system .definition .base_operation .driver .oob_driver .generator .tb_manager .mem_checker .upstream_checker .regFile_driver .loadStore_driver .noc_checker .memory_read_proc .system_interfaces .environment .testbench .top 

clean : 
	/bin/rm .peTbPy .pePy .mgrPy .sysTbPy .sysPy .generic_fifo .sram .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .noc_cntl .stack_interface .pe_cntl .simd_wrapper .simd_upstream_intf .streamingOps_cntl .pe .pe_array .wu_fetch .wu_decode .wu_memory .oob_downstream_cntl .stu_cntl .rdp_cntl .mrc_cntl .mgr_noc_cntl .manager .manager_array .stack_bus .system .definition .base_operation .driver .oob_driver .generator .tb_manager .mem_checker .upstream_checker .regFile_driver .loadStore_driver .noc_checker .memory_read_proc .system_interfaces .environment .testbench .top 

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

.generic_fifo : ../../../PEArray/HDL/run_s/common/code/generic_fifo.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_fifo.v
	touch .generic_fifo
	echo "generic_fifo"


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

.noc_cntl:  ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/noc_cntl.v
	vlog     +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/noc_cntl.v
	echo "noc_cntl"
	touch .noc_cntl

.stack_interface : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/stack_interface.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/stack_interface.v
	echo "stack_interface"
	touch .stack_interface

.pe_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh        ../../../PEArray/HDL/run_s/pe/code/pe_cntl.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../PEArray/HDL/run_s/pe/code/pe_cntl.v
	echo "pe_cntl"
	touch .pe_cntl

.simd_wrapper : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/simd_wrapper.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/simd_wrapper.v
	echo "simd_wrapper"
	touch .simd_wrapper

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

.wu_fetch : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/wu_fetch.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/wu_fetch.v
	echo "wu_fetch"
	touch .wu_fetch

.wu_decode : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/wu_decode.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/wu_decode.v
	echo "wu_decode"
	touch .wu_decode
                                                                                                                          
.wu_memory : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/wu_memory.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/wu_memory.v
	echo "wu_memory"
	touch .wu_memory

.oob_downstream_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/oob_downstream_cntl.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/oob_downstream_cntl.v 
	echo "oob_downstream_cntl"
	touch .oob_downstream_cntl

.stu_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/stu_cntl.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/stu_cntl.v
	echo "stu_cntl"
	touch .stu_cntl

.rdp_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/rdp_cntl.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/rdp_cntl.v
	echo "rdp_cntl"
	touch .rdp_cntl

.mrc_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/mrc_cntl.v 
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/mrc_cntl.v 
	echo "mrc_cntl"
	touch .mrc_cntl

.mgr_noc_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/mgr_noc_cntl.v
	vlog     +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/mgr_noc_cntl.v
	echo "mgr_noc_cntl"
	touch .mgr_noc_cntl

.manager : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh        ../../../Manager/HDL/run_s/manager/code/manager.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../Manager/HDL/run_s/manager/code/manager.v
	echo "manager"
	touch .manager

.manager_array : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh        ../../../Manager/HDL/run_s/manager_array.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../Manager/HDL/run_s/manager_array.v
	echo "manager_array"
	touch .manager_array

.stack_bus : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../HDL/run_s/stack_bus.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../HDL/run_s/stack_bus.v
	echo "stack_bus"
	touch .stack_bus

.system : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../HDL/run_s/system.v
	vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../HDL/run_s/system.v
	echo "system"
	touch .system


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
	vlog -sv +define+TESTING  +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/oob_driver.sv 
	echo "oob_driver"
	touch .oob_driver

.generator : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/generator.sv
	vlog -sv +define+TESTING +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/generator.sv
	echo "generator"
	touch .generator

.tb_manager : ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/manager.sv
	vlog -sv +define+TESTING +define+TB_ENABLE_WUD_INITIATE_OP +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/manager.sv
	echo "manager.sv"
	touch .tb_manager

.mem_checker : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/mem_checker.sv
	vlog -sv +define+TESTING  +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/mem_checker.sv
	echo "mem_checker"
	touch .mem_checker

.upstream_checker : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/upstream_checker.sv
	vlog -sv +define+TESTING  +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/upstream_checker.sv
	echo "upstream_checker"
	touch .upstream_checker

.regFile_driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/regFile_driver.sv
	vlog -sv +define+TESTING  +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/regFile_driver.sv
	echo "regFile_driver"
	touch .regFile_driver

.loadStore_driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/loadStore_driver.sv
	vlog -sv +define+TESTING +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../PEArray/SIMULATION/sv/loadStore_driver.sv
	echo "loadStore_driver"
	touch .loadStore_driver

.noc_checker : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      noc_checker.sv
	vlog -sv +define+TESTING  +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      noc_checker.sv
	echo "noc_checker"
	touch .noc_checker

.memory_read_proc : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      memory_read_proc.sv
	vlog -sv +define+TESTING  +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      memory_read_proc.sv
	echo "memory_read_proc"
	touch .memory_read_proc

.system_interfaces : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh        system_interfaces.sv
	vlog +define+TESTING -sv     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common        system_interfaces.sv
	echo "system_interfaces"
	touch .system_interfaces

.environment : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      environment.sv
	vlog -sv +define+TESTING +define+TB_ENABLE_WUD_INITIATE_OP +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      environment.sv
	echo "environment"
	touch .environment
                                                                                                                                                                                                             
.testbench : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      testbench.sv
	vlog -sv +define+TESTING +define+TB_ENABLE_WUD_INITIATE_OP +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      testbench.sv
	echo "testbench"
	touch .testbench

.top : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh        top.sv 
	#vlog -sv +define+TESTING +define+TB_DRIVES_OOB_PACKET +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common        top.sv 
	vlog -sv +define+TESTING +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common        top.sv 
	echo "top"
	touch .top

vsim : .peTbPy .pePy .mgrPy .sysTbPy .sysPy .generic_fifo .sram .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .noc_cntl .stack_interface .pe_cntl .simd_wrapper .simd_upstream_intf .streamingOps_cntl .pe .pe_array .wu_fetch .wu_decode .wu_memory .oob_downstream_cntl .stu_cntl .rdp_cntl .mrc_cntl .mgr_noc_cntl .manager .manager_array .stack_bus .system .definition .base_operation .driver .oob_driver .generator .tb_manager .mem_checker .upstream_checker .regFile_driver .loadStore_driver .noc_checker .memory_read_proc .system_interfaces .environment .testbench .top 
	vsim -c -sv_seed 3 -do "run.do" -novopt top 
	grep ERROR transcript ; grep PASS transcript | wc -l
	echo 'Expect 20480'
	#20480
	grep 'Packet.*sent.*from' transcript  | wc -l ; grep 'Received.*expected packet' transcript  | wc -l
	echo 'Expect 395 <cr> 395'
	#395
	#395

gvsim :
	vsim    -sv_seed 3   -l gTranscript  -novopt top


