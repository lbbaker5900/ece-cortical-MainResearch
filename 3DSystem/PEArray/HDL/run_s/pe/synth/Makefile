
MODNAME = pe
RTL_DIR = ../code
GATE_DIR = ../synth

$(GATE_DIR)/$(MODNAME)_final.v: $(RTL_DIR)/$(MODNAME).v
	tcsh -c "add synopsys2015 ; \
	dc_shell-t -f run_synth.tcl |& tee run_synth.log"

.PHONY: pt ptsi

pt:
	tcsh -c "add synopsys2015 ; \
	pt_shell -f run_pt.tcl |& tee run_pt.log"

ptsi:
	tcsh -c "add synopsys2015 ; \
	pt_shell -f run_ptsi.tcl |& tee run_ptsi.log"

ptpx:
	tcsh -c "add synopsys2015 ; \
	pt_shell -f run_ptpx.tcl |& tee run_ptpx.log"

lib:
	tcsh -c "add synopsys2015 ; \
	lc_shell -64bit -f run_lib.tcl |& tee run_lib.log"

dw:
	tcsh -c "add synopsys2015 ; \
	unset LM_LICENSE_FILE ; \
	unset SNPSLMD_LICENSE_FILE ; \
	add embedit2013.03 ; \
        ./run_create_dw_proj.ish dw_memories"



clean:
	-rm default.svf
	-rm fixed_names_init
	-rm $(MODNAME)_init.v
	-rm $(MODNAME)_final.v
	-rm *.log
	-rm *.sdf
	-rm *.rpt

