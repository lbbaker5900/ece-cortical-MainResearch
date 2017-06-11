# setup name of the clock in your design.
set clkname clk 

# set variable "modname" to the name of topmost module in design

#------------------------------------------------------------------------------------------------------------------------
# Done
#
# set modname  mrc_cntl
# set modname  rdp_cntl
# set modname  oob_downstream_cntl
# set modname  wu_decode
# set modname  stu_cntl
# set modname  wu_memory

#------------------------------------------------------------------------------------------------------------------------
# WIP
#

set modname  mgr_noc_cntl

#------------------------------------------------------------------------------------------------------------------------
# TBD
#
# set modname  sd_memory
# set modname  wu_fetch
# set modname  manager
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

set CLK_PER 2
