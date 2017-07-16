#*********************************************************************************************
#
#    File name   : powerplan.tcl
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



#set begintime [clock seconds]

#source -echo -verbose setup.tcl

#open_mw_lib work/${modname}
#open_mw_cel ${modname}_post_place

set_host_options -max_cores 4


#################################################################
#
#	Errata_IBM_32SOI_02242014_v11.0.pdf
#		54949
#
#	This must be here before PG rail creation for 32 nm kit
#
set_preroute_drc_strategy \
	-ignore_discrete_metal_width_rule \
	-max_layer M6 \
	-min_layer M1
#
#
#################################################################


#################################################################
#
#	Setting the options for synthesizing the rail to an IR drop
#
#	Same as creating a ring and straps, tell the tool which metals 
#		to use for the ring;
#	Unlike befor, do not tell the tool which metal widths to use.
#		The tool will determine it for the IR drop based on DRC rules.
#
#	Here, setting the core-to-ring spacing to 1 micron,
#		and the ring-to-IO offset to 1 micron.
#
#	-extend_strap core_ring | boundary | pad_ring		***** HIERARCHY *****
#		core_ring : extend straps to existing core ring
#		boundary : extends straps to top-level cell boundary
#				and creates power pins
#		pad_ring : extends straps to existing pad ring
#
set_fp_rail_constraints  \
	-set_ring \
	-nets  {VDD VSS}  \
	-horizontal_ring_layer { M5 } -vertical_ring_layer { M4 } \
	-ring_spacing 1 \
	-ring_offset 1 \
	-extend_strap core_ring
#
#
#################################################################


#################################################################
#
#	Create a macro flat route with no ring for hierarchical routing
#
#set_fp_rail_constraints \
#	-set_ring \
#	-nets {VDD VSS} \
#	-extend_strap boundary
#
#
#################################################################


#################################################################
#
#	Set the constraints for straps
#
set_fp_rail_constraints \
	-add_layer \
	-layer M5 \
	-direction horizontal \
	-max_strap 100 \
	-min_strap 5

set_fp_rail_constraints \
	-add_layer \
	-layer M4 \
	-direction vertical \
	-max_strap 100 \
	-min_strap 5
#
#
#################################################################


#################################################################
#
#	power budget in milli-Watts
#
#	voltage supply in Volts
#
#	target voltage drop in milli-Volts
#
#
synthesize_fp_rail \
	-nets {VDD VSS} \
	-voltage_supply 1.2 \
	-synthesize_power_plan \
	-power_budget 1000 \
	-create_virtual_rail M1 \
	-use_strap_ends_as_pads \
	-strap_ends_direction all
#
#
#################################################################


#################################################################
#
#	should check to see if power budget was met before committing
#
#
commit_fp_rail
#
#
#################################################################


#################################################################
#
#	Errata_IBM_32SOI_02242014_v11.0.pdf
#		54949
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
#
#
#################################################################


verify_pg_nets \
	-std_cell_pin_connection check \
	-macro_pin_connection all \
	-pad_pin_connection all


report_timing

check_legality -verbose

save_mw_cel -as ${modname}_post_power_plan

#set endtime [clock seconds]
#set timestr [timef [expr $endtime-$begintime]]
#puts "powerplan.tcl completed successfully (elapsed time: $timestr actual)"
#exit

