#*********************************************************************************************
#
#    File name   : run_fill.tcl
#    Author      : Lee Baker
#    Affiliation : North Carolina State University, Raleigh, NC
#    Date        : Apr 2017
#    email       : lbbaker@ncsu.edu
#
#    Description : 
#
#    leveraged from file supplied by: 
#    Dr. Rhett Davis, North Carolina State University, Raleigh, NC, email: wdavis@ncsu.edu
#    joshua Schabel, North Carolina State University, Raleigh, NC, email: jcledfo3@ncsu.edu
#
#*********************************************************************************************




source setup.tcl
set begintime [clock seconds]
open_mw_lib ./work/${modname}
open_mw_cel ${modname}_cts

source ${modname}_constraints.tcl
source constraints.tcl


set_host_options -max_cores 4


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------

set_host_options -max_cores 4


#################################################################	ADD FILLER CELLS
#
#	if CAP is in the name of a fill cell, it has metal
#
#	-cell_without_metal {...}
#	-cell_without_metal_prefix noMetalFill
#
#
insert_stdcell_filler \
	-cell_with_metal {SEN_FILL32 SEN_FILL16 SEN_FILL8 SEN_FILL4 SEN_FILL2} \
	-cell_with_metal_prefix FILLER \
	-respect_keepout \
	-connect_to_power VDD \
	-connect_to_ground VSS


insert_well_filler \
	-layer NW \
	-higher_edge max \
	-lower_edge min
#
#
#################################################################	RECHECK PG NETS
#
#
preroute_standard_cells \
	-nets {VDD VSS} \
	-mode rail \
	-connect horizontal \
	-fill_empty_rows \
	-port_filter_mode off \
	-cell_master_filter_mode off \
	-cell_instance_filter_mode off \
	-voltage_area_filter_mode off \
	-extend_to_boundaries_and_generate_pins

verify_pg_nets \
	-std_cell_pin_connection check \
	-macro_pin_connection all \
	-pad_pin_connection all


####save_mw_cel -as ${modname}_post_fill



#------------------------------------------------------------------------------------------------------------------------------------------------------
# end Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------
#
save_mw_cel -as ${modname}_fill
set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_fill.tcl completed successfully (elapsed time: $timestr actual)"
exit


