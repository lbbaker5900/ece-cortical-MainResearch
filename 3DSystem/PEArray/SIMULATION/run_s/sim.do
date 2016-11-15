
vlog -sv +define+BSUM +incdir+../../HDL/common +incdir+../../SIMULATION/common  test.v
vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture

vlog -sv +define+FP_MAC +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture

vlog -sv +define+FP_MAX +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture

vlog -sv +define+NOC2MEM +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture

vlog -sv +define+MEM2MEM +incdir+../../HDL/common  +incdir+../../SIMULATION/common test.v
vsim +define+VIRAGE_FAST_VERILOG +define+MEM_CHECK_OFF +define+VIRAGE_IGNORE_RESET -novopt -c -do "run.do" test_fixture

