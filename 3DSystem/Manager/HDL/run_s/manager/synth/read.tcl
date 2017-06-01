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

read_sverilog $RTL_COM_DIR/generic_memory.v
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

#------------------------------------------------------------------------------------------------------------------------
# Generic FIFO's (and memory)
#  - elaborate the memory first

# <rdp_cntl>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=58  $RTL_COM_DIR/generic_memory.v
elaborate generic_memory -parameter "GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=58"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=58   $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=58"   

# <rdp_cntl>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=138  $RTL_COM_DIR/generic_memory.v
elaborate generic_memory -parameter "GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=138"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=138  $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=138"  

# <oob_downstream_cntl>
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=16,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=32  $RTL_COM_DIR/generic_memory.v
elaborate generic_memory -parameter "GENERIC_MEM_DEPTH=16,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=32"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=32  $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=16,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=32"  

# ????????? depth = 70 ????/
# <name>  70x18
# Depth must be %8 - use 72x18
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=70,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18  $RTL_COM_DIR/generic_memory.v
elaborate generic_memory -parameter "GENERIC_MEM_DEPTH=70,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18   $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18"   

# <name>
# Dimensions not allowed - too shallow
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=4,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=82  $RTL_COM_DIR/generic_memory.v
elaborate generic_memory -parameter "GENERIC_MEM_DEPTH=4,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=82"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=4,GENERIC_FIFO_THRESHOLD=2,GENERIC_FIFO_DATA_WIDTH=82    $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=4,GENERIC_FIFO_THRESHOLD=2,GENERIC_FIFO_DATA_WIDTH=82"    

#------------------------------------------------------------------------------------------------------------------------
# Generic Memories
#

# <name>

#------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------
# Done
#
# read_sverilog $RTL_DIR/rdp_cntl.v
# read_sverilog  $RTL_DIR/oob_downstream_cntl.v
# read_sverilog  $RTL_DIR/mgr_noc_cntl.v


#------------------------------------------------------------------------------------------------------------------------
# WIP
#

read_sverilog  $RTL_DIR/mrc_cntl.v


#------------------------------------------------------------------------------------------------------------------------
# TBD
#
# read_sverilog  $RTL_DIR/wu_memory.v
# read_sverilog  $RTL_DIR/sd_memory.v
# read_sverilog  $RTL_DIR/wu_fetch.v
# read_sverilog  $RTL_DIR/wu_decode.v
# read_sverilog  $RTL_DIR/stu_cntl.v
# read_sverilog  $RTL_DIR/rdp_cntl.v
# read_sverilog  $RTL_DIR/manager.v


#suppress_message LINT-28
check_design


