#*********************************************************************************************
#
#    File name   : Makefile
#    Author      : Lee Baker
#    Affiliation : North Carolina State University, Raleigh, NC
#    Date        : Apr 2017
#    email       : lbbaker@ncsu.edu
#
#    Description : 
#
#    leveraged from file supplied by: 
#    Dr. Rhett Davis, North Carolina State University, Raleigh, NC, email: wdavis@ncsu.edu
#
#*********************************************************************************************

TECH    = 65nm
CORNER  = typical

MODNAME=manager

all: route

crDWlib = .crDWlib
#.PHONY: crDWlib
crDWlib: $(crDWlib)
$(crDWlib): ../synth/dw_memories/compout/views/*/*.plef
	tcsh -c "add synopsys2015 ; \
	/bin/rm -rf ../pr/dw_memories ; \
	nice +19 icc_shell -f run_create_mw_lib.tcl |& tee run_create_mw_lib.log ; \
	Milkyway -tcl -galaxy -nogui -file run_create_dw_lib.tcl |& tee run_create_dw_lib.log ; \
	touch $(crDWlib)"

INIT = .init
.PHONY: init
init: $(INIT)
$(INIT): $(crDWlib) run_init.tcl ../synth/logs.65nm/manager/$(MODNAME)_final.v 
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_init.tcl |& tee run_init.log ; \
	touch $(INIT)"

PLACE_MACROS = .place_macros
.PHONY: place_macros
place_macros: $(PLACE_MACROS)
$(PLACE_MACROS): $(INIT) run_place_macros.tcl 
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_place_macros.tcl |& tee run_place_macros.log ; \
	touch $(PLACE_MACROS)"

PLACE = .place
.PHONY: place
place: $(PLACE)
$(PLACE): $(PLACE_MACROS) run_place.tcl
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_place.tcl |& tee run_place.log ; \
	touch $(PLACE)"

PP = .pp
.PHONY: pp
pp: $(PP)
$(PP): $(PLACE) run_pp.tcl
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_pp.tcl |& tee run_pp.log ; \
	touch $(PP)"

CTS = .cts
.PHONY: cts
cts: $(CTS)
$(CTS): $(PP) run_cts.tcl
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_cts.tcl |& tee run_cts.log ; \
	touch $(CTS)"

FILL = .fill
.PHONY: fill
fill: $(FILL)
$(FILL): $(CTS) run_fill.tcl
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_fill.tcl |& tee run_fill.log ; \
	touch $(FILL)"

ROUTE_TRACK = .route_track
.PHONY: route_track
route_track: $(ROUTE_TRACK)
$(ROUTE_TRACK): $(FILL) run_route_track.tcl
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_route_track.tcl |& tee run_route_track.log ; \
	touch $(ROUTE_TRACK)"

ROUTE_DETAIL = .route_detail
.PHONY: route_detail
route_detail: $(ROUTE_DETAIL)
$(ROUTE_DETAIL): $(FILL) run_route_detail.tcl
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_route_detail.tcl |& tee run_route_detail.log ; \
	touch $(ROUTE_DETAIL)"

ROUTE = .route
.PHONY: route
route: $(ROUTE)
$(ROUTE): $(FILL) run_route.tcl
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_route.tcl |& tee run_route.log ; \
	touch $(ROUTE)"

SO = .so
.PHONY: so
so: $(SO)
$(SO): $(ROUTE) run_so.tcl
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f run_so.tcl |& tee run_so.log ; \
	touch $(SO)"


#----------------------------------------------------------------------------------------------------
## DO NOT USE

IMPORT = .import
.PHONY: import
import: $(IMPORT)
$(IMPORT): import.tcl setup.tcl ../synth/$(MODNAME)_final.v $(crDWlib)
	tcsh -c "add synopsys2015 ; \
	/bin/mkdir work ; \
	/bin/rm -rf work/$(MODNAME) ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f import.tcl |& tee import.log ; \
	touch $(IMPORT)"


rest = .rest
.PHONY: rest
rest: $(rest)
$(rest): import.tcl setup.tcl ../synth/$(MODNAME)_final.v $(crDWlib) $(IMPORT)
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	nice +19 icc_shell -f rest.tcl |& tee rest.log ; \
	touch $(rest)"

#----------------------------------------------------------------------------------------------------

gui:
	tcsh -c "add synopsys2015 ; \
	sed -i -e 's/set corner \"typical\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
	sed -i -e 's/set corner \"slow\"/set corner \"$(CORNER)\"/g' .synopsys_dc.setup ;\
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
	-rm -f .init .place .cts .route .crDWlib .pp .so .fill
	-rm -f *.log* *.tcl.*
	-rm -rf Nangate*
	-rm -f skipped_contactCode_vias.sum
