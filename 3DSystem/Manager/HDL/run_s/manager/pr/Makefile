
MODNAME=wu_memory

all: route

INIT = .init
.PHONY: init
init: $(INIT)
$(INIT): constraints.tcl run_init.tcl ../v/src/gate/$(MODNAME)_final.v
	tcsh -c "add synopsys2015 ; \
	icc_shell -f run_init.tcl |& tee run_init.log ; \
	touch $(INIT)"

PLACE = .place
.PHONY: place
place: $(PLACE)
$(PLACE): $(INIT)
	tcsh -c "add synopsys2015 ; \
	icc_shell -f run_place.tcl |& tee run_place.log ; \
	touch $(PLACE)"

CTS = .cts
.PHONY: cts
cts: $(CTS)
$(CTS): $(PLACE)
	tcsh -c "add synopsys2015 ; \
	icc_shell -f run_cts.tcl |& tee run_cts.log ; \
	touch $(CTS)"

ROUTE = .route
.PHONY: route
route: $(ROUTE)
$(ROUTE): $(CTS)
	tcsh -c "add synopsys2015 ; \
	icc_shell -f run_route.tcl |& tee run_route.log ; \
	touch $(ROUTE)"


crDWlib = .crDWlib
#.PHONY: crDWlib
crDWlib: $(crDWlib)
$(crDWlib): ../synth/$(MODNAME)_final.v
	tcsh -c "add synopsys2015 ; \
	/bin/rm -rf ../pr/dw_memories ; \
	icc_shell -f run_create_mw_lib.tcl |& tee run_create_mw_lib.log ; \
	Milkyway -tcl -galaxy -nogui -file run_create_dw_lib.tcl |& tee run_create_dw_lib.log ; \
	touch $(crDWlib)"

IMPORT = .import
.PHONY: import
import: $(IMPORT)
$(IMPORT): import.tcl setup.tcl ../synth/$(MODNAME)_final.v $(crDWlib)
	tcsh -c "add synopsys2015 ; \
	/bin/mkdir work ; \
	/bin/rm -rf work/$(MODNAME) ; \
	icc_shell -f import.tcl |& tee import.log ; \
	touch $(IMPORT)"


rest = .rest
.PHONY: rest
rest: $(rest)
$(rest): import.tcl setup.tcl ../synth/$(MODNAME)_final.v $(crDWlib) $(IMPORT)
	tcsh -c "add synopsys2015 ; \
	icc_shell -f rest.tcl |& tee rest.log ; \
	touch $(rest)"


gui:
	tcsh -c "add synopsys2015 ; \
	icc_shell -gui"

clean:
	-rm -rf work/*
	-rm icc_output.txt
	-rm -rf *.log
	-rm -rf *.v
	-rm -rf *.def
	-rm -rf *.gds
	-rm -rf net.gcts
	-rm -rf buffer.gcts
	-rm -rf net.acts
	-rm -rf *.min
	-rm -rf *.max
	-rm -rf legalizer_debug_plots
	-rm -f .init .place .cts .route .crDWlib
	-rm -f *.log* *.tcl.*
	-rm -rf Nangate*
	-rm -f skipped_contactCode_vias.sum
