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
read_sverilog $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v

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

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=70  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=70"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70"


analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=256,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=70  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=256,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=70"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=256,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=256,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=256,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=256,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=256,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=256,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=70"


analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=2114  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=2114"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2114  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2114"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2114  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2114"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2114  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2114"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=2050  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=2050"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=2050"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=25  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=25"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=24  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=24"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=24  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=24"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=24  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=24"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=24  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=24"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=46  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=46"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=46  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=46"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=46  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=46"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=46  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=46"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=20  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=64,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=20"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=64,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=25  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=25"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=25"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=128,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=128,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=128,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=128,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=128,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18"

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


analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=20  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=20"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=9  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=9"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=27  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=27"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=27  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=27"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=27  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=27"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=29  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=29"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=29  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=29"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=29  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=29"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=29  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=29"


analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=33  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=33"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=33  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=33"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=33  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=33"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=33  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=33"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=31  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=31"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=31  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=31"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=31  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=31"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=31  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=31"


analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=32  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=32"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=32  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=32"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=32  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=32"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=32  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=32"


analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=20  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=20"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=20"


analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=10  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=10"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=10  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=10"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=10  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=10"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=10  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=10"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=9  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=9"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=9"


analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=7  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=7"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=7  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=32,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=7"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7  $RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7  $RTL_COM_DIR/generic_pipelined_fifo.v
elaborate generic_pipelined_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7  $RTL_COM_DIR/generic_pipelined_w_peek_fifo.v
elaborate generic_pipelined_w_peek_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=7"


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

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=70,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=19  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=70,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=19"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=19   $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=19"   

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=70,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=70,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21   $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=21"   

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=82  $RTL_COM_DIR/generic_2port_memory.v
elaborate generic_2port_memory -parameter "GENERIC_MEM_DEPTH=8,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=82"
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=82    $PE_RTL_COM_DIR/generic_fifo.v
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=8,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=82"    

#------------------------------------------------------------------------------------------------------------------------
# Generic Memories
#
analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=50  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=50"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=16384,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=12  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=16384,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=12"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=16384,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=16384,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=65536,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=65536,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=18"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=2048,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=46  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=2048,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=46"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=2048,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=44  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=2048,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=44"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=4096,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=57  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=4096,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=57"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=4096,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=4096,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=21"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8192,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=52  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=8192,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=52"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=8192,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=57  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=8192,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=57"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=57  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=57"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=46  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=46"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=42  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=42"

analyze -format sverilog -library WORK -define GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=12  $RTL_COM_DIR/generic_1port_memory.v
elaborate generic_1port_memory -parameter "GENERIC_MEM_DEPTH=1024,GENERIC_MEM_REGISTERED_OUT=0,GENERIC_MEM_DATA_WIDTH=12"

# <name>

#------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------
# Done
#
if {($modname == "sdp_stream_cntl") || ($modname == "sdp_cntl") || ($modname == "mrc_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/sdp_stream_cntl.v
}
if {($modname == "sdp_request_cntl") || ($modname == "sdp_cntl") || ($modname == "mrc_cntl") || ($modname == "mwc_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/sdp_request_cntl.v
}
if {($modname == "sdp_cntl") || ($modname == "mrc_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/sdp_cntl.v
}

if {($modname == "mrc_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/mrc_cntl.v
}

if {($modname == "mwc_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/mwc_cntl.v
}

if {($modname == "rdp_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/rdp_cntl.v
}

if {($modname == "oob_downstream_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/oob_downstream_cntl.v
}

if {($modname == "wu_decode") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/wu_decode.v
}

if {($modname == "stu_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/stu_cntl.v
}

if {($modname == "wu_memory") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/wu_memory.v
}

if {($modname == "mgr_noc_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/mgr_noc_cntl.v
}

if {($modname == "dram_access_timer") || ($modname == "main_mem_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/dram_access_timer.v
}

if {($modname == "main_mem_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/main_mem_cntl.v
}

if {($modname == "wu_fetch") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/wu_fetch.v
}

if {($modname == "dfi") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/dfi.v
}

if {($modname == "mgr_cntl") || ($modname == "manager")} {
  read_sverilog  $RTL_DIR/mgr_cntl.v
}

if {($modname == "manager")} {
  read_sverilog  $RTL_DIR/manager.v
}


#------------------------------------------------------------------------------------------------------------------------
# WIP
#





#------------------------------------------------------------------------------------------------------------------------
# TBD
#


#suppress_message LINT-28
check_design


