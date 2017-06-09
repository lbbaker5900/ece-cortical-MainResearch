

source  setup.tcl

#create_mw_lib \
#               -technology /local/home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/milkyway/tf/cp65npksdst_m07f0f1.tf \
#               -mw_reference_library {/home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/milkyway/cp65npksdst_m07f0f1} \
#               -bus_naming_style {[%d]}  \
#               -open /local/home/lbbaker/Cortical/ece-cortical-MainResearch/3DSystem/Manager/HDL/run_s/manager/pr/dw_memories

create_mw_lib  \
	-technology /home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/milkyway/tf/cp65npksdst_m07f0f1.tf \
	-mw_reference_library {/home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/milkyway/cp65npksdst_m07f0f1 /local/home/lbbaker/Cortical/ece-cortical-MainResearch/3DSystem/Manager/HDL/run_s/manager/pr/dw_memories} \
	-bus_naming_style {[%d]} \
	-open  work/${modname}

# read_verilog -dirty_netlist \
#              ${GATE_DIR}/${modname}_final.v
#



import_designs -format verilog \
	-top ${modname} \
	-cel ${modname} \
	${GATE_DIR}/${modname}_final.v

 read_sdc ${GATE_DIR}/${modname}_tt.sdc
 
save_mw_cel
close_mw_cel
close_mw_lib

exit

