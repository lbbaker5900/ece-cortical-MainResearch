
##vlog -sv +define+STD_STD_FPMAC_TO_MEM +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
##vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture
##
##vlog -sv +define+STD_NONE_NOP_TO_MEM +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
##vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture
##
##vlog -sv +define+MEM_STD_FPMAC_TO_MEM +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
##vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture
##



##vlog -sv +define+FP_MAX +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
##vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture
##
##vlog -sv +define+BSUM +incdir+../../HDL/common +incdir+../../SIMULATION/common  test.v
##vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture
##
##vlog -sv +define+NOC2MEM +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
##vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture
##
##vlog -sv +define+MEM2MEM +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
##vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture
##

## For interactive sim
##vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt  test_fixture &
