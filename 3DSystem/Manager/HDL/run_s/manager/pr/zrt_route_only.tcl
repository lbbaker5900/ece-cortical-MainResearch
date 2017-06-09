

set_host_options -max_cores 4


#################################################################	DELAY CALCULATION MODES
#
#	Elmore : fast, less accurate
#	AWE : slow, more accurate
#	Arnoldi : slowest; solves convergence issues in AWE, keeps synopsys from hanging
#
#	-preroute elmore | awe
#	-routed_clock elmore | arnoldi
#	-postroute elmore | arnoldi
#
#
set_delay_calculation_options \
	-preroute elmore \
	-routed_clock elmore \
	-postroute elmore \
	-awe_effort high \
	-arnoldi_effort high
#
#
#################################################################	SIGNAL INTEGRITY ANALYSIS
#
#
set_si_options \
	-delta_delay true \
	-static_noise true \
	-timing_window true \
	-min_delta_delay true \
	-route_xtalk_prevention true
#
#
#################################################################	ROUTING LAYER CONSTRAINTS
#
#	ZRT-130
#
set_net_routing_layer_constraints \
	-max_layer_mode allow_pin_connection \
	-min_layer_mode soft \
	-min_layer_name M1 -max_layer_name M6 {*}
#
#
#################################################################	ROUTE OPTIONS
#
#	May only apply to route_opt, not route_zrt
#
set_route_options \
	-groute_timing_driven true \
	-groute_timing_driven_weight 3 \
	-groute_skew_control true \
	-groute_skew_weight 3 \
	-groute_congestion_weight 5 \
	-groute_clock_routing balanced \
	-groute_incremental true \
	-track_assign_timing_driven true \
	-track_assign_timing_driven_weight 1 \
	-droute_connect_tie_off true \
	-droute_connect_open_nets true \
	-droute_reroute_user_wires false \
	-droute_CTS_nets minor_change_only \
	-droute_single_row_column_via_array optimize \
	-droute_stack_via_less_than_min_area add_metal_stub \
	-droute_stack_via_less_than_min_area_cost 0 \
	-poly_pin_access auto \
	-drc_distance diagonal \
	-same_net_notch check_and_fix \
	-fat_wire_check merge_then_check \
	-merge_fat_wire_on  preroute_signal \
	-fat_blockage_as fat_wire \
	-wire_contact_eol_rule check_and_fix \
	-enable_user_enter_sub_route_type false
#
#
#################################################################	ENABLE ZRT ROUTE
#	May only apply to route_opt and route_detail
#
set_route_mode_options -zroute true
#
#
#################################################################	ROUTE ZRT COMMON OPTIONS
#
#	-plan_group_aware : off | all_routing | top_level_routing_only		-> hierarchy
#
set_route_zrt_common_options \
	-reroute_clock_shapes true \
	-reroute_user_shapes false \
	-plan_group_aware off \
	-child_process_net_threshold -1 \
	-verbose 1 \
	-connect_floating_shapes true \
	-rc_driven_setup_effort_level high \
	-route_top_boundary_mode stay_half_min_space_inside \
	-global_max_layer_mode allow_pin_connection \
	-global_min_layer_mode soft \
	-net_max_layer_mode allow_pin_connection \
	-net_min_layer_mode soft \
	-post_incremental_detail_route_fix_soft_violations true \
	-route_soft_rule_effort_level high \
	-post_detail_route_fix_soft_violations true \
	-post_eco_route_fix_soft_violations true \
	-post_group_route_fix_soft_violations true \
	-tie_off_mode rail_only \
	-rotate_default_vias false
#
#
#################################################################	ROUTE ZRT GLOBAL ROUTE OPTIONS
#
#
set_route_zrt_global_options \
	-layer_based_congestion_map true \
	-timing_driven true \
	-timing_driven_effort high \
	-crosstalk_driven false \
	-effort high \
	-force_full_effort true
#
#
#################################################################	ROUTE ZRT TRACK ROUTE OPTIONS
#
#
set_route_zrt_track_options \
	-crosstalk_driven true \
	-timing_driven true
#
#
#################################################################	ROUTE ZRT DETAIL ROUTE OPTIONS
#
#	FYI - ANTENNA_X1M_19TH is a munaully placed antenna fix cell
#		Tool does not route it
#
set_route_zrt_detail_options \
	-antenna true \
	-antenna_fixing_preference use_diodes \
	-check_pin_min_area_min_length true \
	-check_port_min_area_min_length true \
	-diode_insertion_mode new \
	-diode_libcell_names {SEN_TIEDIN_1} \
	-diode_preference new \
	-drc_convergence_effort high \
	-timing_driven true \
	-insert_diodes_during_routing true \
	-optimize_tie_off_effort_level high \
	-optimize_wire_via_effort_level high
#
#
#################################################################	ROUTE ZRT - GLOBAL
#
#
route_zrt_global \
	-effort high \
	-congestion_map_only false \
	-exploration false

verify_zrt_route \
	-open_net true \
	-report_all_open_nets true \
	-drc true \
	-antenna true \
	-voltage_area true

save_mw_cel -as ${modname}_post_global_route
#
#
#################################################################	ROUTE ZRT - TRACK
#
#	
route_zrt_track

verify_zrt_route \
	-open_net true \
	-report_all_open_nets true \
	-drc true \
	-antenna true \
	-voltage_area true

save_mw_cel -as ${modname}_post_track_route
#
#
#################################################################	ROUTE ZRT - DETAIL
#
#
route_zrt_detail \
	-max_number_iterations 100 \
	-incremental true

verify_zrt_route \
	-open_net true \
	-report_all_open_nets true \
	-drc true \
	-antenna true \
	-voltage_area true

save_mw_cel -as ${modname}_post_detail_route_1
#
#
#################################################################	ROUTE OTPIMIZATION
#
#
set_si_options \
	-route_xtalk_prevention true

route_opt \
	-stage detail \
	-area_recovery \
	-effort high \
	-incremental \
	-only_area_recovery

route_opt \
	-stage detail \
	-effort high \
	-incremental \
	-only_hold_time

route_opt \
	-stage detail \
	-xtalk_reduction \
	-effort high \
	-incremental

route_opt \
	-stage detail \
	-effort high \
	-incremental \
	-only_power_recovery

route_opt \
	-stage detail \
	-effort high \
	-incremental \
	-only_design_rule


verify_zrt_route \
	-open_net true \
	-report_all_open_nets true \
	-drc true \
	-antenna true \
	-voltage_area true

save_mw_cel -as ${modname}_post_opt_route
#
#
#################################################################	FOCAL optimization
#
#
focal_opt -setup_endpoints all -effort high

focal_opt -hold_enpoints all -effort high

focal_opt -drc_nets all -effort high

focal_opt -drc_pins all -effort high

#focal_opt -power -effort high

save_mw_cel -as ${modname}_post_opt_focal
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


verify_zrt_route \
	-open_net true \
	-report_all_open_nets true \
	-drc true \
	-antenna true \
	-voltage_area true
#
#
#################################################################

save_mw_cel -as ${modname}_routed



