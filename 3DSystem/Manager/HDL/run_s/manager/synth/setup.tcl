# setup name of the clock in your design.
set clkname clk 

# set variable "modname" to the name of topmost module in design

#------------------------------------------------------------------------------------------------------------------------
# Done
#
# set modname  mwc_cntl
# set modname  mgr_cntl
# set modname  sdp_request_cntl
# set modname  sdp_stream_cntl
# set modname  sdp_cntl
# set modname  mrc_cntl
# set modname  rdp_cntl
# set modname  oob_downstream_cntl
# set modname  wu_decode
# set modname  stu_cntl
# set modname  wu_memory
# set modname  mgr_noc_cntl
# set modname  dram_access_timer
# set modname  main_mem_cntl
# set modname  wu_fetch
# set modname  dfi
# set modname  manager


#------------------------------------------------------------------------------------------------------------------------
# WIP
#

set modname manager

#------------------------------------------------------------------------------------------------------------------------
# TBD
#
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

if {$tech == "65nm"} {

  #set CLK_PER 2.6
  #set CLK_PER 3.71
set CLK_PER 10.0
  #set CLK_PER 10.0

} elseif {($tech == "28nm")} {

  #set CLK_PER 2.6
  #set CLK_PER 3.71
set CLK_PER 10.0
  #set CLK_PER 10.0

}


