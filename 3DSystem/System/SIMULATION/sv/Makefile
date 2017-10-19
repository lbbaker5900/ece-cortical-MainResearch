#! /bin/bash

LIB_DIR=mti_lib


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#***********************************************************************8
# Note: testbench includes environment which incldues all .sv files
#  - make sure any required defines are added to the testbench compile
#***********************************************************************8

#TB_WHO_DRIVES_OOB=TB_DRIVES_OOB_PACKET
TB_WHO_DRIVES_OOB=TB_DOES_NOT_DRIVE_OOB_PACKET

#TB_WHO_DRIVES_STACK_DOWN_DATA=TB_DRIVES_STACK_DOWN_DATA
TB_WHO_DRIVES_STACK_DOWN_DATA=TB_DOES_NOT_DRIVE_STACK_DOWN_DATA

#TB_WHO_INITIATES_OP=TB_TESTBENCH_MGR_INITIATES_OP
TB_WHO_INITIATES_OP=TB_WUD_INITIATES_OP

#TB_LIMIT_MAX_PROGRAM_COUNT=TB_LIMIT_MAX_PC
TB_LIMIT_MAX_PROGRAM_COUNT=TB_DO_NOT_LIMIT_MAX_PC

TB_LIMIT_MAX_INSTRUCTIONS=TB_LIMIT_MAX_INST
#TB_LIMIT_MAX_INSTRUCTIONS=TB_DO_NOT_LIMIT_MAX_INST

#TB_WHO_DRIVES_SIMD_REGFILE_INPUTS=TB_DRIVES_SIMD_REGFILE_INPUTS
TB_WHO_DRIVES_SIMD_REGFILE_INPUTS=TB_DOES_NOT_DRIVE_SIMD_REGFILE_INPUTS

TB_CAN_MANAGER_PAUSE_WUD=TB_MGR_PAUSES_WUD
#TB_CAN_MANAGER_PAUSE_WUD=TB_MGR_CANNOT_PAUSE_WUD

TB_MANAGER_RTL_OR_GATES=TB_DOES_NOT_USE_MANAGER_GATE_NETLIST
#TB_MANAGER_RTL_OR_GATES=TB_USES_MANAGER_GATE_NETLIST


TB_COMMON_ARG0=TB_COMMON_ARG0

#library: mti_lib
#	vlib $(LIB_DIR)

all : .Py .peTbPy .pePy .mgrPy .sysTbPy .sysPy .dwMgr .armMgr .dwPe .generic_1port_memory .generic_2port_memory .generic_fifo .generic_pipelined_fifo .generic_pipelined_w_peek_fifo .diram4 .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .noc_cntl .stack_interface .pe_cntl .simd_wrapper .simd_core .simd_upstream_intf .streamingOps_cntl .pe .pe_array .wu_fetch .wu_decode .wu_memory .oob_downstream_cntl .stu_cntl .rdp_cntl .mrc_cntl .sdp_cntl .sdp_request_cntl .sdp_stream_cntl .mwc_cntl .mgr_cntl .dram_access_timer .main_mem_cntl .mmc_final_queue .dfi .mgr_noc_cntl .manager .manager_array .stack_bus .system .definition .base_operation .driver .oob_driver .generator .tb_manager .dram_utilities .mem_checker .upstream_checker .regFile_driver .dram_driver .loadStore_driver .noc_checker .memory_read_proc .system_interfaces .interface .environment .testbench .top 

clean : 
	/bin/rm .Py .peTbPy .pePy .mgrPy .sysTbPy .sysPy .dwMgr .armMgr .dwPe .generic_1port_memory .generic_2port_memory .generic_fifo .generic_pipelined_fifo .generic_pipelined_w_peek_fifo .diram4 .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .noc_cntl .stack_interface .pe_cntl .simd_wrapper .simd_core .simd_upstream_intf .streamingOps_cntl .pe .pe_array .wu_fetch .wu_decode .wu_memory .oob_downstream_cntl .stu_cntl .rdp_cntl .mrc_cntl .sdp_cntl .sdp_request_cntl .sdp_stream_cntl .mwc_cntl .mgr_cntl .dram_access_timer .main_mem_cntl .mmc_final_queue .dfi .mgr_noc_cntl .manager .manager_array .stack_bus .system .definition .base_operation .driver .oob_driver .generator .tb_manager .dram_utilities .mem_checker .upstream_checker .regFile_driver .dram_driver .loadStore_driver .noc_checker .memory_read_proc .system_interfaces .interface .environment .testbench .top 
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
# virage_ignore_read_addrx  : does not corrupt memory is ME=1, WE=0 and ADR=X
.dwMgr    : ../../../Manager/HDL/run_s/manager/synth/dw_memories/compout/views/*/std*.v 
	vlog -sv +define+VIRAGE_FAST_VERILOG+MEM_CHECK_OFF+VIRAGE_IGNORE_RESET+virage_ignore_read_addrx                       +incdir+../../../Manager/HDL/common ../../../Manager/HDL/run_s/manager/synth/dw_memories/compout/views/*/*_fast_func.v           2>&1   | tee -a $1
	vlog -sv +define+_fv+VIRAGE_FAST_VERILOG+MEM_CHECK_OFF+VIRAGE_IGNORE_RESET+VIRL_functiononly +incdir+../../../Manager/HDL/common  /home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/verilog/3.0/cp65npksdst.v       2>&1   | tee -a $1
	touch .dwMgr

.armMgr    : ../../../Manager/HDL/run_s/manager/synth/arm_memories/verilog/*.v 
	vlog -sv +define+VIRAGE_FAST_VERILOG+MEM_CHECK_OFF+VIRAGE_IGNORE_RESET                       +incdir+../../../Manager/HDL/common ../../../Manager/HDL/run_s/manager/synth/arm_memories/verilog/*.v                            2>&1   | tee -a $1
	touch .armMgr

.dwPe    : ../../../PEArray/HDL/run_s/pe/synth/dw_memories/compout/views/*/std*.v 
	vlog -sv +define+VIRAGE_FAST_VERILOG+MEM_CHECK_OFF+VIRAGE_IGNORE_RESET+virage_ignore_read_addrx                       +incdir+../../../Manager/HDL/common ../../../PEArray/HDL/run_s/pe/synth/dw_memories/compout/views/*/*_fast_func.v           2>&1   | tee -a $1
	vlog -sv +define+_fv+VIRAGE_FAST_VERILOG+MEM_CHECK_OFF+VIRAGE_IGNORE_RESET+VIRL_functiononly +incdir+../../../Manager/HDL/common  /home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/verilog/3.0/cp65npksdst.v       2>&1   | tee -a $1
	touch .dwPe

.diram4 :  ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ./models/DiRAM4_Verilog_Model/*
	vlog -sv +define+INVERT_CHNL_CLK  +incdir+../../HDL/common+../../SIMULATION/common+../../../PEArray/HDL/common+../../../Manager/HDL/common+./models/DiRAM4_Verilog_Model   ./models/DiRAM4_Verilog_Model/diram4.sv 
	touch .diram4
	echo "diram4"


.generic_1port_memory :  ../../../PEArray/HDL/run_s/common/code/generic_1port_memory.v ../../../Manager/HDL/common/generic_memories.vh
	vlog -sv   +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_1port_memory.v
	touch .generic_1port_memory
	echo "generic_1port_memory"

.generic_2port_memory :  ../../../PEArray/HDL/run_s/common/code/generic_2port_memory.v ../../../Manager/HDL/common/generic_memories.vh
	vlog -sv   +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_2port_memory.v
	touch .generic_2port_memory
	echo "generic_2port_memory"

.generic_fifo : ../../../PEArray/HDL/run_s/common/code/generic_fifo.v 
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_fifo.v
	touch .generic_fifo
	echo "generic_fifo"

.generic_pipelined_fifo : ../../../PEArray/HDL/run_s/common/code/generic_pipelined_fifo.v 
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_pipelined_fifo.v
	touch .generic_pipelined_fifo
	echo "generic_pipelined_fifo"

.generic_pipelined_w_peek_fifo : ../../../PEArray/HDL/run_s/common/code/generic_pipelined_fifo.v 
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common      ../../../PEArray/HDL/run_s/common/code/generic_pipelined_w_peek_fifo.v
	touch .generic_pipelined_w_peek_fifo
	echo "generic_pipelined_w_peek_fifo"


.mem_acc_cont :  ../../HDL/common/*vh ../../SIMULATION/common/*vh ../../../PEArray/HDL/common/*vh ../../../Manager/HDL/common/*vh           ../../../PEArray/HDL/run_s/pe/code/mem_acc_cont.v 
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common       ../../../PEArray/HDL/run_s/pe/code/mem_acc_cont.v
	echo "mem_acc_cont"
	touch .mem_acc_cont

.dma_cont : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/dma_cont.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/dma_cont.v 
	echo "dma_cont"
	touch .dma_cont

.streamingOps : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh         ../../../PEArray/HDL/run_s/pe/code/streamingOps.v 
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common         ../../../PEArray/HDL/run_s/pe/code/streamingOps.v 
	echo "streamingOps"
	touch .streamingOps

.streamingOps_datapath:    ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/streamingOps_datapath.v 
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/streamingOps_datapath.v 
	echo "streamingOps_datapath"
	touch .streamingOps_datapath

.noc_cntl:  ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/noc_cntl.v
	vlog          +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/noc_cntl.v
	echo "noc_cntl"
	touch .noc_cntl

.stack_interface : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/stack_interface.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/stack_interface.v
	echo "stack_interface"
	touch .stack_interface

.pe_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh  ../../../PEArray/SIMULATION/common/*.vh      ../../../PEArray/HDL/run_s/pe/code/pe_cntl.v
	vlog -sv +define+${TB_WHO_DRIVES_SIMD_REGFILE_INPUTS}    +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../PEArray/HDL/run_s/pe/code/pe_cntl.v
	echo "pe_cntl"
	touch .pe_cntl

.simd_wrapper : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/simd_wrapper.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/simd_wrapper.v
	echo "simd_wrapper"
	touch .simd_wrapper

.simd_core : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/simd_core.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/simd_core.v
	echo "simd_core"
	touch .simd_core

.simd_upstream_intf : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../PEArray/HDL/run_s/pe/code/simd_upstream_intf.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../PEArray/HDL/run_s/pe/code/simd_upstream_intf.v
	echo "simd_upstream_intf"
	touch .simd_upstream_intf

.streamingOps_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh    ../../../PEArray/HDL/run_s/pe/code/streamingOps_cntl.v 
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../MEMORY/65nm/FIFOs/compout/views/sasslnpky2p32x35cm4sw0bk1ltlc1 ../../../PEArray/HDL/run_s/pe/code/streamingOps_cntl.v 
	echo "streamingOps_cntl"
	touch .streamingOps_cntl

.pe : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh                  ../../../PEArray/HDL/run_s/pe/code/pe.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common                  ../../../PEArray/HDL/run_s/pe/code/pe.v
	echo "pe"
	touch .pe

.pe_array : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh        ../../../PEArray/HDL/run_s/pe_array.v 
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../PEArray/HDL/run_s/pe_array.v 
	echo "pe_array"
	touch .pe_array

.wu_fetch : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/wu_fetch.v
	vlog -sv +define+${TB_LIMIT_MAX_PROGRAM_COUNT}     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/wu_fetch.v
	echo "wu_fetch"
	touch .wu_fetch

.wu_decode : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/wu_decode.v
	vlog -sv  +define+${TB_CAN_MANAGER_PAUSE_WUD}  +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/wu_decode.v
	echo "wu_decode"
	touch .wu_decode
                                                                                                                          
.wu_memory : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/wu_memory.v
	vlog -sv    +define+${TB_LIMIT_MAX_INSTRUCTIONS}  +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/wu_memory.v
	echo "wu_memory"
	touch .wu_memory

.oob_downstream_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/oob_downstream_cntl.v 
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/oob_downstream_cntl.v 
	echo "oob_downstream_cntl"
	touch .oob_downstream_cntl

.stu_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/stu_cntl.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/stu_cntl.v
	echo "stu_cntl"
	touch .stu_cntl

.rdp_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/rdp_cntl.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/rdp_cntl.v
	echo "rdp_cntl"
	touch .rdp_cntl

.sdp_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/sdp_cntl.v 
	vlog -sv   +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/sdp_cntl.v 
	echo "sdp_cntl"
	touch .sdp_cntl

.sdp_request_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/sdp_request_cntl.v 
	vlog -sv   +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/sdp_request_cntl.v 
	echo "sdp_request_cntl"
	touch .sdp_request_cntl

.sdp_stream_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/sdp_stream_cntl.v 
	vlog -sv   +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/sdp_stream_cntl.v 
	echo "sdp_stream_cntl"
	touch .sdp_stream_cntl

.mrc_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/mrc_cntl.v 
	vlog -sv +define+${TB_WHO_DRIVES_STACK_DOWN_DATA}+${TB_CAN_MANAGER_PAUSE_WUD}   +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/mrc_cntl.v 
	echo "mrc_cntl"
	touch .mrc_cntl

.mwc_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/mwc_cntl.v 
	vlog -sv   +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/mwc_cntl.v 
	echo "mwc_cntl"
	touch .mwc_cntl

.mgr_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/mgr_cntl.v 
	vlog -sv   +define+${TB_LIMIT_MAX_INSTRUCTIONS} +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/mgr_cntl.v 
	echo "mgr_cntl"
	touch .mgr_cntl

.dram_access_timer : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/dram_access_timer.v 
	vlog -sv "+incdir+../../HDL/common" "+incdir+../../SIMULATION/common" "+incdir+../../../PEArray/HDL/common" "+incdir+../../../Manager/HDL/common" ../../../Manager/HDL/run_s/manager/code/dram_access_timer.v
	echo "dram_access_timer"
	touch .dram_access_timer

.main_mem_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/main_mem_cntl.v 
	vlog -sv "+incdir+../../HDL/common" "+incdir+../../SIMULATION/common" "+incdir+../../../PEArray/HDL/common" "+incdir+../../../Manager/HDL/common" ../../../Manager/HDL/run_s/manager/code/main_mem_cntl.v
	echo "main_mem_cntl"
	touch .main_mem_cntl

.mmc_final_queue : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/mmc_final_queue.v 
	vlog -sv "+incdir+../../HDL/common" "+incdir+../../SIMULATION/common" "+incdir+../../../PEArray/HDL/common" "+incdir+../../../Manager/HDL/common" ../../../Manager/HDL/run_s/manager/code/mmc_final_queue.v
	echo "mmc_final_queue"
	touch .mmc_final_queue

.dfi : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/dfi.v 
	vlog -sv "+incdir+../../HDL/common" "+incdir+../../SIMULATION/common" "+incdir+../../../PEArray/HDL/common" "+incdir+../../../Manager/HDL/common" ../../../Manager/HDL/run_s/manager/code/dfi.v
	echo "dfi"
	touch .dfi

.mgr_noc_cntl : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../../Manager/HDL/run_s/manager/code/mgr_noc_cntl.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../../Manager/HDL/run_s/manager/code/mgr_noc_cntl.v
	echo "mgr_noc_cntl"
	touch .mgr_noc_cntl

.manager : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh        ../../../Manager/HDL/run_s/manager/code/manager.v
	vlog -sv +define+${TB_WHO_DRIVES_OOB}+${TB_LIMIT_MAX_INSTRUCTIONS} +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../Manager/HDL/run_s/manager/code/manager.v
	#vlog -sv +define+TESTING     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../Manager/HDL/run_s/manager/code/manager.v
	echo "manager"
	touch .manager

.manager_gates_init : ../../../Manager/HDL/run_s/manager/synth/logs.65nm/manager/manager_final.v 
	vlog -sv +define+${TB_WHO_DRIVES_OOB} +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common   ../../../Manager/HDL/run_s/manager/synth/logs.65nm/manager/manager_init.v 
	echo "manager gates_init"
	touch .manager_gates_init

.manager_gates_synth : ../../../Manager/HDL/run_s/manager/synth/logs.65nm/manager/manager_final.v 
	vlog -sv +define+${TB_WHO_DRIVES_OOB} +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common   ../../../Manager/HDL/run_s/manager/synth/logs.65nm/manager/manager_final.v 
	echo "manager gates_synth"
	touch .manager_gates_synth

.manager_gates_pr : ../../../Manager/HDL/run_s/manager/pr/manager_routed_track.v 
	vlog -sv +define+${TB_WHO_DRIVES_OOB} +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common    ../../../Manager/HDL/run_s/manager/pr/manager_routed_track.v  
	echo "manager gates_pr"
	touch .manager_gates_pr

.manager_array : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/SIMULATION/common/*.vh        ../../../Manager/HDL/run_s/manager_array.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/common        ../../../Manager/HDL/run_s/manager_array.v
	echo "manager_array"
	touch .manager_array

.stack_bus : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../HDL/run_s/stack_bus.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../HDL/run_s/stack_bus.v
	echo "stack_bus"
	touch .stack_bus

.system : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh           ../../HDL/run_s/system.v
	vlog -sv      +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common           ../../HDL/run_s/system.v
	echo "system"
	touch .system


.definition :  ../../../System/SIMULATION/sv/definition.sv
	vlog -sv         +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/definition.sv
	echo "definition"
	touch .definition

.base_operation : ../../HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/base_operation.sv
	vlog -sv   +incdir+../../../Manager/HDL/common+../../HDL/common+../../../PEArray/SIMULATION/common+../../../PEArray/HDL/common+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/base_operation.sv
	echo "base_operation"
	touch .base_operation

.driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/driver.sv 
	vlog -sv         +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/driver.sv 
	echo "driver"
	touch .driver

.oob_driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv ../../../Manager/HDL/common/manager.vh  ../../../System/SIMULATION/sv/oob_driver.sv 
	vlog -sv   +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/oob_driver.sv 
	echo "oob_driver"
	touch .oob_driver

.generator : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/generator.sv
	vlog -sv  +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/generator.sv
	echo "generator"
	touch .generator

.dram_utilities : ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/dram_utilities.sv
	vlog -sv  +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/dram_utilities.sv
	echo "dram_utilities.sv"
	touch .dram_utilities

.tb_manager : .dram_utilities ../../HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/manager.sv
	vlog -sv  +define+${TB_WHO_DRIVES_OOB}+${TB_WHO_INITIATES_OP}+${TB_COMMON_ARG0}+${TB_CAN_MANAGER_PAUSE_WUD}+${TB_MANAGER_RTL_OR_GATES}  +incdir+../../../Manager/HDL/common+../../HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/manager.sv
	echo "manager.sv"
	touch .tb_manager

.mem_checker : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/mem_checker.sv
	vlog -sv   +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/mem_checker.sv
	echo "mem_checker"
	touch .mem_checker

.upstream_checker : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/upstream_checker.sv
	vlog -sv   +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/upstream_checker.sv
	echo "upstream_checker"
	touch .upstream_checker

.regFile_driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv ../../../PEArray/SIMULATION/common/*.vh      ../../../System/SIMULATION/sv/regFile_driver.sv
	vlog -sv   +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/regFile_driver.sv
	echo "regFile_driver"
	touch .regFile_driver

.dram_driver : ../../../PEArray/SIMULATION/common/*.vh ../../../Manager/HDL/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv ../../../PEArray/SIMULATION/common/*.vh      ../../../System/SIMULATION/sv/dram_driver.sv
	vlog -sv   +incdir+../../../PEArray/SIMULATION/common +incdir+../../../Manager/HDL/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv +incdir+../../../PEArray/SIMULATION/common/*.vh    ../../../System/SIMULATION/sv/dram_driver.sv
	echo "dram_driver"
	touch .dram_driver

.loadStore_driver : ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/loadStore_driver.sv
	vlog -sv  +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      ../../../System/SIMULATION/sv/loadStore_driver.sv
	echo "loadStore_driver"
	touch .loadStore_driver

.noc_checker : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      noc_checker.sv
	vlog -sv   +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      noc_checker.sv
	echo "noc_checker"
	touch .noc_checker

.memory_read_proc : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      memory_read_proc.sv
	vlog -sv   +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      memory_read_proc.sv
	echo "memory_read_proc"
	touch .memory_read_proc

.system_interfaces : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh        system_interfaces.sv
	vlog  -sv     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common        system_interfaces.sv
	echo "system_interfaces"
	touch .system_interfaces

.interface : ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh        interface.sv
	vlog  -sv     +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common        interface.sv
	echo "interface"
	touch .interface

# Note: environment includes all .sv files
.environment : .Py .peTbPy .pePy .mgrPy .sysTbPy .sysPy .dwMgr .armMgr .dwPe .definition .base_operation .driver .oob_driver .generator .tb_manager .dram_utilities .mem_checker .upstream_checker .regFile_driver .dram_driver .loadStore_driver .noc_checker .memory_read_proc .system_interfaces .interface  ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      environment.sv
	vlog -sv  +define+${TB_WHO_DRIVES_SIMD_REGFILE_INPUTS}+${TB_LIMIT_MAX_PROGRAM_COUNT}+${TB_LIMIT_MAX_INSTRUCTIONS}+${TB_WHO_DRIVES_STACK_DOWN_DATA}+${TB_WHO_DRIVES_OOB}+${TB_WHO_INITIATES_OP}+${TB_COMMON_ARG0}+${TB_CAN_MANAGER_PAUSE_WUD}+${TB_MANAGER_RTL_OR_GATES} +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      environment.sv
	echo "environment"
	touch .environment
                                                                                                                                                                                                             
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Note: testbench includes environment which includes all .sv files
#  - make sure any required defines are added to the testbench compile
#
.testbench : .environment ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh     ../../../PEArray/SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../PEArray/SIMULATION/sv      testbench.sv
	vlog -sv  +define+${TB_WHO_DRIVES_SIMD_REGFILE_INPUTS}+${TB_LIMIT_MAX_PROGRAM_COUNT}+${TB_LIMIT_MAX_INSTRUCTIONS}+${TB_WHO_DRIVES_STACK_DOWN_DATA}+${TB_WHO_DRIVES_OOB}+${TB_WHO_INITIATES_OP}+${TB_COMMON_ARG0}+${TB_CAN_MANAGER_PAUSE_WUD}+${TB_MANAGER_RTL_OR_GATES}  +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common     +incdir+../../../PEArray/SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../PEArray/SIMULATION/sv      testbench.sv
	echo "testbench"
	touch .testbench

.top : .environment ../../HDL/common/*.vh ../../SIMULATION/common/*.vh ../../../PEArray/HDL/common/*.vh ../../../Manager/HDL/common/*.vh   ../../../PEArray/SIMULATION/common/*.vh      top.sv 
	vlog -sv  +define+${TB_WHO_DRIVES_SIMD_REGFILE_INPUTS}+${TB_LIMIT_MAX_PROGRAM_COUNT}+${TB_LIMIT_MAX_INSTRUCTIONS}+${TB_WHO_DRIVES_STACK_DOWN_DATA}+${TB_WHO_DRIVES_OOB}+${TB_WHO_INITIATES_OP}+${TB_COMMON_ARG0}+${TB_CAN_MANAGER_PAUSE_WUD}+${TB_MANAGER_RTL_OR_GATES}  +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common        top.sv 
	#vlog -sv  +incdir+../../HDL/common +incdir+../../SIMULATION/common +incdir+../../../PEArray/HDL/common +incdir+../../../Manager/HDL/common        top.sv 
	echo "top"
	touch .top

vsim : .peTbPy .pePy .mgrPy .sysTbPy .sysPy .generic_1port_memory .generic_2port_memory .generic_fifo .generic_pipelined_fifo .generic_pipelined_w_peek_fifo .diram4 .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .noc_cntl .stack_interface .pe_cntl .simd_wrapper .simd_core .simd_upstream_intf .streamingOps_cntl .pe .pe_array .wu_fetch .wu_decode .wu_memory .oob_downstream_cntl .stu_cntl .rdp_cntl .mrc_cntl .sdp_cntl .sdp_request_cntl .sdp_stream_cntl .mwc_cntl .mgr_cntl .dram_access_timer .main_mem_cntl .mmc_final_queue .dfi .mgr_noc_cntl .manager .manager_array .stack_bus .system .definition .base_operation .driver .oob_driver .generator .tb_manager .dram_utilities .mem_checker .upstream_checker .regFile_driver .dram_driver .loadStore_driver .noc_checker .memory_read_proc .system_interfaces .environment .testbench .top 
	vsim -c -sv_seed 3 -do "run.do" -novopt top 
	grep ERROR transcript ; grep PASS transcript | wc -l
	echo 'Expect 1952 (24576 in 8x8 mode)'
	grep 'Packet.*sent.*from' transcript  | wc -l ; grep 'Received.*expected packet' transcript  | wc -l
	echo 'Expect 18 <cr> 18 # FIXME'
	echo '(Expect 737 <cr> 732 in 8x8 mode) # FIXME'

gvsim : .peTbPy .pePy .mgrPy .sysTbPy .sysPy .generic_1port_memory .generic_2port_memory .generic_fifo .generic_pipelined_fifo .generic_pipelined_w_peek_fifo .diram4 .mem_acc_cont .dma_cont .streamingOps .streamingOps_datapath .noc_cntl .stack_interface .pe_cntl .simd_wrapper .simd_core .simd_upstream_intf .streamingOps_cntl .pe .pe_array .wu_fetch .wu_decode .wu_memory .oob_downstream_cntl .stu_cntl .rdp_cntl .mrc_cntl .sdp_cntl .sdp_request_cntl .sdp_stream_cntl .mwc_cntl .mgr_cntl .dram_access_timer .main_mem_cntl .mmc_final_queue .dfi .mgr_noc_cntl .manager .manager_array .stack_bus .system .definition .base_operation .driver .oob_driver .generator .tb_manager .dram_utilities .mem_checker .upstream_checker .regFile_driver .dram_driver .loadStore_driver .noc_checker .memory_read_proc .system_interfaces .environment .testbench .top 
	vsim    -sv_seed 3   -l gTranscript  -novopt top


