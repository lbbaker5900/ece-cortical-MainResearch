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

read_sverilog $PE_RTL_COM_DIR/generic_fifo.v

analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=58   $PE_RTL_COM_DIR/generic_fifo.v
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=138  $PE_RTL_COM_DIR/generic_fifo.v
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18   $PE_RTL_COM_DIR/generic_fifo.v
analyze -format sverilog -library WORK -define GENERIC_FIFO_DEPTH=4,GENERIC_FIFO_THRESHOLD=2,GENERIC_FIFO_DATA_WIDTH=82    $PE_RTL_COM_DIR/generic_fifo.v

elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=58"   
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=32,GENERIC_FIFO_THRESHOLD=8,GENERIC_FIFO_DATA_WIDTH=138"  
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=70,GENERIC_FIFO_THRESHOLD=4,GENERIC_FIFO_DATA_WIDTH=18"   
elaborate generic_fifo -parameter "GENERIC_FIFO_DEPTH=4,GENERIC_FIFO_THRESHOLD=2,GENERIC_FIFO_DATA_WIDTH=82"    

read_sverilog $RTL_DIR/rdp_cntl.v

#suppress_message LINT-28
check_design

