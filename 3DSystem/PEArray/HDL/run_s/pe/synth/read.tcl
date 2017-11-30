#------------------------------------------------------------
#
# Basic Synthesis Script (TCL format)
#                                  
# Revision History                
#   1/15/03  : Author Shane T. Gehring - from class example
#   2/09/07  : Author Zhengtao Yu      - from class example
#   12/14/07 : Author Ravi Jenkal      - updated to 180 nm & tcl
#
#------------------------------------------------------------

#---------------------------------------------------------
# Read in Verilog file and map (synthesize) onto a generic
# library.
# MAKE SURE THAT YOU CORRECT ALL WARNINGS THAT APPEAR
# during the execution of the read command are fixed 
# or understood to have no impact.
# ALSO CHECK your latch/flip-flop list for unintended 
# latches                                            
#---------------------------------------------------------

read_sverilog $RTL_COM_DIR/generic_1port_memory.v
read_sverilog $RTL_COM_DIR/generic_2port_memory.v
read_sverilog $RTL_COM_DIR/generic_fifo.v
read_sverilog $RTL_COM_DIR/generic_pipelined_fifo.v

#------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------
# Create parameterized modules
# - each FIFO has a corresponding memory
# - dont forget to create memory .db file
#

#------------------------------------------------------------------------------------------------------------------------
# Generic Pipelined FIFO's (and memory)
#  - elaborate the memory first, then generic_fifo then generic_pipelined_fifo


#                                     Registered Depth   Width   Thres
#                                         v        v       v       v
####set gen_pipelined_fifo_options        {
####                                       {  0        8       8       4}
####                                       {  0        8      14       4}
####                                       {  0        8      32       4}
####                                       {  0        8      34       4}
####                                       {  0        8     150       4}
####                                       {  0       16      38       4}
####                                       {  0       16      38       8}
####  }
####set gen_1port_mem_options             {
####                                       {  0      256      32       X}
####                                       {  0      256     149       X}
####                                       {  0      512      32       X}
####                                       {  0     1024      32       X}
####                                       {  0     4096      32       X}
####                                       {  0     8192      32       X}
####  }
####set gen_2port_mem_options             {
####                                       {  0     1024      32       X}
####  }
####
####foreach mem $gen_pipelined_fifo_options {
####  
####  set registered [lindex $mem 0]
####  set depth      [lindex $mem 1]
####  set width      [lindex $mem 2]
####  set threshold  [lindex $mem 3]
####  
####  analyze -format sverilog -library WORK -define      GENERIC_MEM_REGISTERED_OUT=${registered},GENERIC_MEM_DEPTH=${depth},GENERIC_MEM_DATA_WIDTH=${width}                                        $RTL_COM_DIR/generic_2port_memory.v
####  elaborate generic_2port_memory -parameter          "GENERIC_MEM_REGISTERED_OUT=${registered},GENERIC_MEM_DEPTH=${depth},GENERIC_MEM_DATA_WIDTH=${width}"
####  analyze -format sverilog -library WORK -define                                               GENERIC_FIFO_DEPTH=${depth},GENERIC_FIFO_DATA_WIDTH=${width},GENERIC_FIFO_THRESHOLD=${threshold}  $RTL_COM_DIR/generic_fifo.v
####  elaborate generic_fifo -parameter                                                           "GENERIC_FIFO_DEPTH=${depth},GENERIC_FIFO_DATA_WIDTH=${width},GENERIC_FIFO_THRESHOLD=${threshold}"
####  analyze -format sverilog -library WORK -define                                               GENERIC_FIFO_DEPTH=${depth},GENERIC_FIFO_DATA_WIDTH=${width},GENERIC_FIFO_THRESHOLD=${threshold}  $RTL_COM_DIR/generic_pipelined_fifo.v
####  elaborate generic_pipelined_fifo -parameter                                                 "GENERIC_FIFO_DEPTH=${depth},GENERIC_FIFO_DATA_WIDTH=${width},GENERIC_FIFO_THRESHOLD=${threshold}"
####}
####
####foreach mem $gen_1port_mem_options {
####  
####  set registered [lindex $mem 0]
####  set depth      [lindex $mem 1]
####  set width      [lindex $mem 2]
####  
####  analyze -format sverilog -library WORK -define      GENERIC_MEM_REGISTERED_OUT=${registered},GENERIC_MEM_DEPTH=${depth},GENERIC_MEM_DATA_WIDTH=${width}                                        $RTL_COM_DIR/generic_1port_memory.v
####  elaborate generic_2port_memory -parameter          "GENERIC_MEM_REGISTERED_OUT=${registered},GENERIC_MEM_DEPTH=${depth},GENERIC_MEM_DATA_WIDTH=${width}"
####}
####
####
####foreach mem $gen_2port_mem_options {
####  
####  set registered [lindex $mem 0]
####  set depth      [lindex $mem 1]
####  set width      [lindex $mem 2]
####  
####  analyze -format sverilog -library WORK -define      GENERIC_MEM_REGISTERED_OUT=${registered},GENERIC_MEM_DEPTH=${depth},GENERIC_MEM_DATA_WIDTH=${width}                                        $RTL_COM_DIR/generic_2port_memory.v
####  elaborate generic_2port_memory -parameter          "GENERIC_MEM_REGISTERED_OUT=${registered},GENERIC_MEM_DEPTH=${depth},GENERIC_MEM_DATA_WIDTH=${width}"
####}
####
####
####
####
#------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------
# Done
#


if {($modname == "streamingOps") || ($modname == "streamingOps_datapath") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/streamingOps.v
}
if {($modname == "dma_cont") || ($modname == "streamingOps_datapath") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/dma_cont.v
}
if {($modname == "streamingOps_datapath") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/streamingOps_datapath.v
}
if {($modname == "streamingOps_cntl") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/streamingOps_cntl.v
}
if {($modname == "pe_cntl") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/pe_cntl.v
}
if {($modname == "simd_upstream_intf") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/simd_upstream_intf.v
}
if {($modname == "simd_core") || ($modname == "simd_wrapper") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/simd_core.v
}
if {($modname == "simd_wrapper") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/simd_wrapper.v
}
if {($modname == "stack_interface") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/stack_interface.v
}
if {($modname == "mem_acc_cont") || ($modname == "pe")} {
  read_sverilog $RTL_DIR/mem_acc_cont.v
}

#read_sverilog $RTL_DIR/pe.v

#------------------------------------------------------------------------------------------------------------------------
# WIP
#

if {($modname == "pe")} {
  read_sverilog $RTL_DIR/pe.v
}


#------------------------------------------------------------------------------------------------------------------------
# TBD
#
# 


#suppress_message LINT-28
check_design


