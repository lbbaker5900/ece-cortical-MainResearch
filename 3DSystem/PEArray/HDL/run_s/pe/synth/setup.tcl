# setup name of the clock in your design.
set clkname clk 

# set variable "modname" to the name of topmost module in design

#------------------------------------------------------------------------------------------------------------------------
# Done
#

# set modname streamingOps
# set modname streamingOps_cntl
# set modname dma_cont
# set modname streamingOps_datapath
# set modname pe_cntl
# set modname mem_acc_cont
# set modname simd_upstream_intf
# set modname simd_wrapper

#------------------------------------------------------------------------------------------------------------------------
# WIP
#

set modname pe

#------------------------------------------------------------------------------------------------------------------------
# TBD
#
# set modname pe
# 

# set variable "RTL_DIR" to the HDL directory w.r.t synthesis directory
set RTL_DIR    ../code
set RTL_COM_DIR   ../../../../../PEArray/HDL/run_s/common/code

# set variable "GATE_DIR" to the output directory w.r.t synthesis directory
set GATE_DIR    ../synth

# set variable "type" to a name that distinguishes this synthesis run
set type test

#set the number of digits to be used for delay results
set report_default_significant_digits 4

set CLK_PER 20
