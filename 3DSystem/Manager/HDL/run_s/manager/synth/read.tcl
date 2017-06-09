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

# <name>
#
# from_system_fifo
#analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=16,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=350  $RTL_COM_DIR/generic_2port_memory.v
#elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=16,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=350"
#analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=350  $RTL_COM_DIR/generic_fifo.v
#elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=350"
#analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=350  $RTL_COM_DIR/generic_pipelined_fifo.v
#elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=350"

#<mrc_cntl.consJump_to_strm>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=128,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=12  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=128,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=12"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=12  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=12"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=12  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=12"

#<mrc_cntl.addr_to_strm>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=40  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=40"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=40  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=40"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=40  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=40"

#<mrc_cntl.from_mmc>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=2050  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=2050"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=2050  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=2050"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050"


#------------------------------------------------------------------------------------------------------------------------
# Generic FIFO's (and memory)
#  - elaborate the memory first

# <rdp_cntl>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=58  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=58"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=58   $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=58"   

# <rdp_cntl>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=138  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=138"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=138  $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=138"  

# <oob_downstream_cntl>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=16,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=32  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=16,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=32"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=32  $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=32"  

# <mrc_cntl.from_Wud_fifo>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=16,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=50  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=16,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=50"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=50  $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=50"  

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=70,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=70,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18   $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18"   

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=82  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=82"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=82    $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=82"    

#------------------------------------------------------------------------------------------------------------------------
# Generic Memories
#
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=50  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=50"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=16384,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=12  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=16384,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=12"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=4096,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=57  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=4096,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=57"

# <name>

#------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------
# Done
#
# read_sverilog  $RTL_DIR/mrc_cntl.v
# read_sverilog  $RTL_DIR/rdp_cntl.v
# read_sverilog  $RTL_DIR/oob_downstream_cntl.v
# read_sverilog  $RTL_DIR/wu_decode.v
# read_sverilog  $RTL_DIR/stu_cntl.v
# read_sverilog  $RTL_DIR/wu_memory.v


#------------------------------------------------------------------------------------------------------------------------
# WIP
#

 read_sverilog  $RTL_DIR/mgr_noc_cntl.v


#------------------------------------------------------------------------------------------------------------------------
# TBD
#
# read_sverilog  $RTL_DIR/sd_memory.v
# read_sverilog  $RTL_DIR/wu_fetch.v
# read_sverilog  $RTL_DIR/manager.v


#suppress_message LINT-28
check_design


