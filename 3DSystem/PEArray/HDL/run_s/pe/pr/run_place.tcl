
source setup.tcl
set begintime [clock seconds]

open_mw_lib ./work/${modname}
open_mw_cel ${modname}_init

#------------------------------------------------------------------------------------------------------------------------------------------------------
# pr_tut
#------------------------------------------------------------------------------------------------------------------------------------------------------
####place_opt -effort high -optimize_dft -congestion -continue_on_missing_scandef
####
####
####legalize_placement -effort high -incremental 
####
####set_fix_multiple_port_nets -all -buffer_constants
####
####place_opt -effort high -optimize_dft -congestion -continue_on_missing_scandef
####
####legalize_placement -effort high -incremental 
####
####preroute_standard_cells -nets VSS -connect horizontal
####preroute_standard_cells -nets VDD -connect horizontal
####
####
####verify_pg_nets  -pad_pin_connection all
####
####report_timing
####
####save_mw_cel -as ${modname}_placed
####
#------------------------------------------------------------------------------------------------------------------------------------------------------
# end pr_tut
#------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------
# Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------
#


#set begintime [clock seconds]

#source -echo -verbose setup.tcl

#open_mw_lib work/${modname}
#open_mw_cel ${modname}_post_fp

set_host_options -max_cores 4

set_attribute [get_cells -hier -all -filter {ref_name =~ asdr*}] is_fixed true
set_attribute [get_cells -hier -all -filter {ref_name =~ sass*}] is_fixed true

set placer_congestion_effort high

set placer_enable_enhanced_router true

set placer_enable_high_effort_congestion true

set placer_disable_macro_placement_timeout true

set_place_opt_strategy \
	-layer_optimization true \
	-layer_optimization_effort high \
	-consider_routing false

#################################################################
### OTHER USEFULL FLAGS
#
#	-optimize_dft : flag for optimizing scan chains
#
#	-power : ICC does support MMMC modes, in which set_scenario_options command
#		must be set
#
#	-cts : can have clock tree synthesis within placement
#		all constraints for timing must be set first
#
#	-optimize_icgs : used with -cts flag
#
#
place_opt \
	-effort high \
	-area_recovery \
	-optimize_dft \
	-continue_on_missing_scandef
#
#
#################################################################


legalize_placement \
	-effort high \
	-incremental


#################################################################
### OTHER USEFULL FLAGS
#
#	-feedthroughs : buffers to isolate input ports from output ports through
#			out hierarchy
#
#	-outputs : buffers so no cell driver pin drives more than one output port
#
#	-constants : duplicates logic constants
#
#
set_fix_multiple_port_nets \
	-all \
	-buffer_constants
#
#
#################################################################


place_opt \
	-effort high \
	-area_recovery \
	-optimize_dft \
	-congestion \
	-power \
	-continue_on_missing_scandef


legalize_placement \
	-effort high \
	-incremental


report_timing

check_legality -verbose

#save_mw_cel -as ${modname}_post_place

#set endtime [clock seconds]
#set timestr [timef [expr $endtime-$begintime]]
#puts "place.tcl completed successfully (elapsed time: $timestr actual)"
#exit



#------------------------------------------------------------------------------------------------------------------------------------------------------
# end Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------
#
save_mw_cel -as ${modname}_placed

set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_place.tcl completed successfully (elapsed time: $timestr actual)"
exit
