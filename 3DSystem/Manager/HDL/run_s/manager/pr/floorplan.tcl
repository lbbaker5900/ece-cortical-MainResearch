

#################################################################
###	FLOORPLAN	 
#
#	keep_macro_place and keep_io_place are REUQIRED for any top hierarchical
#		routes or flat routes with memory and IO cells
#
#	keep_std_cell_place might be useful for hierarchical routes without outer rings...TBD
#
create_floorplan \
	-core_utilization 0.3 \
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

save_mw_cel -as ${modname}_post_fp



