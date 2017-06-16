
set begintime [clock seconds]

source -echo setup.tcl
source -echo import.tcl

source ${modname}_constraints.tcl

#------------------------------------------------------------------------------------------------------------------------------------------------------
# pr_tut
#------------------------------------------------------------------------------------------------------------------------------------------------------
#################################################################
###	FLOORPLAN	 
#################################################################
####create_floorplan -core_utilization 0.85 -start_first_row -flip_first_row -left_io2core 1 -bottom_io2core 1 -right_io2core 1 -top_io2core 1
####
####
##### DEFINING POWER/GROUND NETS AND PINS			 
####derive_pg_connection -power_net VDD		\
####			 -ground_net VSS		\
####			 -power_pin VDD		\
####			 -ground_pin VSS	
####			 
##### CREATING POWER RECTANGULAR RING		
####
####create_rectangular_rings  -nets  {VDD VSS}  -left_offset 0.2 -left_segment_layer M8 -right_offset 0.2 -right_segment_layer M8 -bottom_offset 0.2 -bottom_segment_layer M9 -extend_bh -top_offset 0.2 -top_segment_layer M9
####
####
####
####create_power_straps  -direction horizontal  -nets  {VDD}  -layer M9 -configure  groups_and_step  -num_groups 100  -step 5
####create_power_straps  -direction horizontal  -start_at 2.5 -nets  {VSS}  -layer M9 -configure  groups_and_step  -num_groups 100 -step 5
####create_power_straps  -direction vertical  -nets  {VDD}  -layer M8 -configure  groups_and_step  -num_groups 100 -step 5
####create_power_straps  -direction vertical  -start_at 2.5 -nets  {VSS}  -layer M8 -configure  groups_and_step  -num_groups 100 -step 5
####
####report_timing
####
#------------------------------------------------------------------------------------------------------------------------------------------------------
# end pr_tut
#------------------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------------------------------
# Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------
#
#################################################################
###	FLOORPLAN	 
#
#	keep_macro_place and keep_io_place are REUQIRED for any top hierarchical
#		routes or flat routes with memory and IO cells
#
#	keep_std_cell_place might be useful for hierarchical routes without outer rings...TBD
#

set_fp_placement_strategy \
      -min_distance_between_macros ${MIN_DISTANCE_BETWEEN_MACROS} \
      -sliver_size ${SLIVER_DISTANCE_BETWEEN_MACROS}

if {$modname == "pe" || $modname == "manager"} {

  create_floorplan                      \
        -control_type width_and_height  \
        -core_width ${CHIPLET_WIDTH}    \
        -core_height ${CHIPLET_HEIGHT}  \
        -left_io2core 5                 \
        -bottom_io2core 5               \
        -right_io2core 5                \
        -top_io2core 5

} else {

  create_floorplan \
	-core_utilization ${CORE_UTILIZATION} \
        -core_aspect_ratio ${CORE_ASPECT_RATIO} \
	-left_io2core 5 \
	-bottom_io2core 5 \
	-right_io2core 5 \
	-top_io2core 5
#	-control_type aspect_ratio \
#	-core_utilization 0.3 \
#	-start_first_row \
#	-flip_first_row \
#	-core_aspect_ratio 1.0 \
#	-no_double_back \
#	-top_io2core 5 \
#	-left_io2core 5 \
#	-right_io2core 5 \	
#	-bottom_io2core 5
#	-keep_macro_place \
#	-keep_io_place
#	-core_width
#	-core_height
#	-use_vertical_row \
#	-no_double_back \
#	-start_first_row \
#	-flip_first_row \
#	-keep_std_cell_place \
#	-min_pad_height \
#	-pad_limit 
#
}

#
#
#################################################################


#################################################################
#
#	Avoid floating pins with minimum area errors
#
set_pin_physical_constraints \
	-width 0.2 \
	-depth 0.2 \
	[get_ports *]
#
#
#################################################################


#################################################################
###	DEFINING POWER/GROUND NETS AND PINS	
#
#	cells option useful in hierarchical flow
#
#	create_ports top will be needed for hierarchical flow
#
derive_pg_connection \
	-power_net {VDD} \
	-power_pin {VDD} \
	-ground_net {VSS} \
	-ground_pin {VSS} \
	-create_ports none
#
#################################################################

#------------------------------------------------------------------------------------------------------------------------------------------------------
# end Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------

save_mw_cel -as ${modname}_init
#save_mw_cel
close_mw_cel
close_mw_lib

set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_init.tcl completed successfully (elapsed time: $timestr actual)"
exit
