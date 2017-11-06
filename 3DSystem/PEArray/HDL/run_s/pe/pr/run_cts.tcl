#*********************************************************************************************
#
#    File name   : run_cts.tcl
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
open_mw_cel ${modname}_power_plan


#------------------------------------------------------------------------------------------------------------------------------------------------------
# pr_tut
#------------------------------------------------------------------------------------------------------------------------------------------------------
####check_legality
####
####set_clock_tree_options -clock_trees $clkname \
####		-insert_boundary_cell true \
####		-ocv_clustering true \
####		-buffer_relocation true \
####		-buffer_sizing true \
####		-gate_relocation true \
####		-gate_sizing true
####		
####set cts_use_debug_mode true
####set cts_do_characterization true
####
####
####clock_opt -fix_hold_all_clocks  -continue_on_missing_scandef
####
##### DEFINING POWER/GROUND NETS AND PINS			 
#####derive_pg_connection -power_net VDD		\
#####			 -ground_net VSS	\
#####			 -power_pin VDD		\
#####			 -ground_pin VSS	
####			 
####preroute_standard_cells -nets VSS -connect horizontal
####preroute_standard_cells -nets VDD -connect horizontal
####
####verify_pg_nets
####verify_pg_nets  -pad_pin_connection all
####
####report_timing

#------------------------------------------------------------------------------------------------------------------------------------------------------
# end pr_tut
#------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------
# Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------


##	for hierarchical flow
#		might have to use inter-clock-balance since all pre-routed modules
#		in top level will be considered their own clock domains and need to
#		be balanced

#source setup.tcl

#set begintime [clock seconds]

#open_mw_lib ./work
#open_mw_cel ${modname}_post_power_plan

set_host_options -max_cores 4

#################################################################
### OTHER USEFULL FLAGS
#
# In Encounter, we generated clock.ctstch files, which are process dependent
#	minDelay == min. insertion delay, typically zero
#	maxSkew == target_skew
#
#	-target_early_delay : insertion delay, default is zero
#	-target_skew : maxSkew from clock.ctstch
#	-max_capactiance (might be same as synthesis)
#	-max_transition : BufMaxTran from clock.ctstch
#	-max_fanout
#
#
set_clock_tree_options \
	-clock_trees $clkname \
	-layer_list {M1 M2 M3 M4 M5} \
	-buffer_relocation true \
	-buffer_sizing true \
	-gate_relocation true \
	-gate_sizing true \
	-logic_level_balance false \
	-ocv_clustering true \
	-ocv_path_sharing true \
	-advanced_drc_fixing true \
	-insert_boundary_cell true \
	-operating_condition max
#
#
#################################################################


set cts_add_clock_domain_name true
set cts_blockage_aware true
set cts_do_characterization true
set cts_enable_drc_fixing_on_data true
set cts_fix_drc_beyond_exceptions true
set cts_region_aware true
set cts_use_debug_mode true

#set_route_mode_options \
#	-zroute true

#route_zrt_clock_tree
	

#################################################################
### PERFORM CLOCK TREE SYNTHESIS
#
### other useful flags
#
#	-only_cts
#	-optimize_dft : clock-aware scan chaning reording
#	
#
clock_opt \
	-fix_hold_all_clocks \
	-inter_clock_balance \
	-update_clock_latency \
	-operating_condition max \
	-continue_on_missing_scandef \
	-area_recovery \
	-power \
	-congestion
#
#
#################################################################


#################################################################
### OTHER USEFULL FLAGS
#
#	-special_via_rule : by default, tool places one large via at wire intersections.
#				this flag allows user to define a matrix of vias to place.
#				Depending on process kit, this is requried.
#
#	-advanced_via_rules : uses "set_preroute_advanced_via_rule" global via rules
#
#	-do_not_route_over_macros : might be required for hierarchical route
#
#
preroute_standard_cells \
	-nets {VDD VSS} \
	-mode rail \
	-connect horizontal \
	-fill_empty_rows \
	-fill_empty_sites \
	-port_filter_mode off \
	-cell_master_filter_mode off \
	-cell_instance_filter_mode off \
	-voltage_area_filter_mode off \
	-remove_floating_pieces \
	-extend_to_boundaries_and_generate_pins

#
#
#################################################################


verify_pg_nets \
	-std_cell_pin_connection check \
	-macro_pin_connection all \
	-pad_pin_connection all


report_timing

check_routeability -error_cell post_clock_synth.err

#------------------------------------------------------------------------------------------------------------------------------------------------------
# end Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------
#
save_mw_cel -as ${modname}_cts
set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_cts.tcl completed successfully (elapsed time: $timestr actual)"
exit
