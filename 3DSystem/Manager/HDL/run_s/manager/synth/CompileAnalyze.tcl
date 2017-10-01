

# ===================================================	block OPT-1206, removing flip-flops
# set hdlin_preserve_sequential true
# set compile_seqmap_propagate_constants false
# set compile_seqmap_propagate_high_effort false

# uncomment to keep hierarchy
set_ungroup [all_designs] false
set_structure true

#compile -map_effort medium -boundary_optimization -auto_ungroup area
compile -map_effort medium    \
        -area_effort medium

# compile_ultra \
#      -no_autoungroup
#report_fsm

#---------------------------------------------------------
# This is just a sanity check: Write out the design before 
# hold fixing
#---------------------------------------------------------
write -hierarchy -f verilog -o ${modname}_init.v

#---------------------------------------------------------
# Now trace the critical (slowest) path and see if     
# the timing works.                                    
# If the slack is NOT met, you HAVE A PROBLEM and      
# need to redesign or try some other minimization      
# tricks that Synopsys can do                          
#---------------------------------------------------------

report_timing \
	-delay max \
	-nworst 30 \
	> ${modname}_${type}_timing_initial_ss_max.rpt

report_timing \
	-delay min \
	-nworst 30 \
	> ${modname}_${type}_timing_initial_ss_min.rpt

report_cell > ${modname}_${type}_cell_report_initial.rpt

compile -incremental      \
        -area_effort none
#
# 	Now resynthesize the design for the fastest corner   
# 	making sure that hold time conditions are met        
# 	Specify the fastest process corner and lowest temp and highest (fastest) Vcc                            
#
if {$tech == "65nm"} {

  set target_library cp65npksdst_ff1p32vn40c.db
  set link_library cp65npksdst_ff1p32vn40c.db

} elseif {($tech == "28nm")} {

  set target_library sc12mc_cmos28hpp_base_rvt_c30_ff_nominal_min_0p945v_0c.db
  set link_library sc12mc_cmos28hpp_base_rvt_c30_ff_nominal_min_0p945v_0c.db

}

set link_library [concat $link_library dw_foundation.sldb $mem_lib $regf_lib *] 

translate

#
# 	Set the design rule to 'fix hold time violations'    
#
set_fix_hold $clkname

# compile_ultra  \
#      -incremental \
#      -only_design_rule \
#      -no_autoungroup

report_timing \
	-delay min \
	-nworst 30 \
	> ${modname}_${type}_timing_ff_min.rpt

report_timing \
	-delay max \
	-nworst 30 \
	> ${modname}_${type}_timing_ff_max.rpt

#report_timing  > ${modname}_${type}_timing_ff_max.rpt

write_sdf ${modname}_ff.sdf

write_sdc ${modname}_ff.sdc

#
#	recheck for possible new setup violations
#
if {$tech == "65nm"} {

  set target_library cp65npksdst_ss0p9v125c.db
  set link_library cp65npksdst_ss0p9v125c.db

} elseif {($tech == "28nm")} {

  set target_library sc12mc_cmos28hpp_base_rvt_c30_ss_nominal_max_0p765v_110c.db
  set link_library sc12mc_cmos28hpp_base_rvt_c30_ss_nominal_max_0p765v_110c.db

}


set link_library [concat $link_library dw_foundation.sldb $mem_lib $regf_lib *] 

translate

report_timing \
	-delay min \
	-nworst 30 \
	> ${modname}_${type}_timing_ss_min.rpt

report_timing \
	-delay max \
	-nworst 30 \
	> ${modname}_${type}_timing_ss_max.rpt

write_sdf ${modname}_ss.sdf

write_sdc ${modname}_ss.sdc

#
#	switch to typical library to print out
#
if {$tech == "65nm"} {


} elseif {($tech == "28nm")} {


}
if {$tech == "65nm"} {

  set target_library cp65npksdst_tt1p0v25c.db
  set link_library cp65npksdst_tt1p0v25c.db

} elseif {($tech == "28nm")} {

  set target_library sc12mc_cmos28hpp_base_rvt_c30_tt_nominal_max_0p90v_25c.db
  set link_library sc12mc_cmos28hpp_base_rvt_c30_tt_nominal_max_0p90v_25c.db

}

set link_library [concat $link_library dw_foundation.sldb $mem_lib $regf_lib *] 

translate

report_timing \
	-delay min \
	-nworst 30 \
	> ${modname}_${type}_timing_tt_min.rpt

report_timing \
	-delay max \
	-nworst 30 \
	> ${modname}_${type}_timing_tt_max.rpt

#
#	write out area
#
report_cell > ${modname}_${type}_cell_report_final.rpt

#
#	write out gate level netlist in verilog
change_names -rules verilog -hierarchy > ${modname}_${type}_fixed_names_init

write -hierarchy -f verilog -o ${modname}_final.v

write_sdf ${modname}_tt.sdf

write_sdc ${modname}_tt.sdc


report_area > ${modname}_${type}_area_netlist.rpt

report_power > ${modname}_${type}_power_netlist.rpt







