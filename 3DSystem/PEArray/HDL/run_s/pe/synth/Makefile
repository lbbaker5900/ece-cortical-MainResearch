
MODNAME = pe
INST    = 2
TECH    = 65nm

RTL_DIR = ../code
GATE_DIR = ../synth

$(GATE_DIR)/$(MODNAME)_final.v: $(RTL_DIR)/$(MODNAME).v
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/^ *set modname .*/set modname $(MODNAME)/' setup.tcl ;\
	sed -i -e 's/set tech \"28nm\"/set tech \"$(TECH)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set tech \"65nm\"/set tech \"$(TECH)\"/g' .synopsys_dc.setup ;\
	nice +19 dc_shell-t -f run_synth.tcl |& tee run_synth.log ; \
	mkdir logs.$(TECH)/$(MODNAME) ; \
	mv *rpt *log *.v *.sdc logs.$(TECH)/$(MODNAME)/. "

.PHONY: pt ptsi

pt:
	tcsh -c "add synopsys2015 ; \
	nice +19 pt_shell -f run_pt.tcl |& tee run_pt.log"

saif:
	tcsh -c "add synopsys2015 ; \
	vcd2saif -input ../../../../../System/SIMULATION/sv/${MODNAME}_${INST}.vcd -output ./logs.$(TECH)/$(MODNAME)/$(MODNAME)_$(INST).saif "

ptsi:
	tcsh -c "add synopsys2015 ; \
	nice +19 pt_shell -f run_ptsi.tcl |& tee run_ptsi.log"

ptpx:
	tcsh -c "add synopsys2015 ; \
	nice +19 pt_shell -f run_ptpx.tcl |& tee run_ptpx.log ; \
	mkdir -p logs.$(TECH)/$(MODNAME) ; \
	mv power_ptpx_*.rpt run_ptpx.log logs.$(TECH)/$(MODNAME)/. "

lib:
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set tech \"28nm\"/set tech \"$(TECH)\"/g' .synopsys_lc.setup ;\
	sed -i -e 's/set tech \"65nm\"/set tech \"$(TECH)\"/g' .synopsys_lc.setup ;\
	lc_shell -64bit -f run_lib.tcl |& tee run_lib.log"

dw:
	tcsh -c "add synopsys2015 ; \
	unset LM_LICENSE_FILE ; \
	unset SNPSLMD_LICENSE_FILE ; \
	add embedit2013.03 ; \
        ./run_create_dw_proj.ish dw_memories"


arm:
	tcsh -c "add synopsys2015 ; \
	cd arm_memories  ; \
	../run_create_arm_mem.sh ;\
	/bin/mv *.lib lib/. ; \
	/bin/mv *.v verilog/. ; \
	/bin/mv *.ps documents/. "


update: 
	tcsh -c " \
	sed -i -e 's/^ *set modname .*/set modname $(MODNAME)/' setup.tcl ;\
	sed -i -e 's/set tech \"28nm\"/set tech \"$(TECH)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set tech \"65nm\"/set tech \"$(TECH)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set tech \"28nm\"/set tech \"$(TECH)\"/g' .synopsys_pt.setup ;\
	sed -i -e 's/set tech \"65nm\"/set tech \"$(TECH)\"/g' .synopsys_pt.setup "


clean:
	-rm default.svf
	-rm fixed_names_init
	-rm $(MODNAME)_init.v
	-rm $(MODNAME)_final.v
	-rm *.log
	-rm *.sdf
	-rm *.rpt

