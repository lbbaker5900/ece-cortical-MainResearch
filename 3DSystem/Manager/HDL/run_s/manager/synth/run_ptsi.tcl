###################################################
#
# run_pt.tcl
#
# 4/11/2011 W. Rhett Davis (rhett_davis@ncsu.edu)
# updated 4/5/2012, 3/28/2014, 8/23/2016
#
#####################################################

set begintime [clock seconds]


# setup name of the clock in your design.
set clkname HCLK

# set variable "modname" to the name of topmost module in design
set modname CORTEXM0DS

# set variable "PR_DIR" to the HDL & SPEF directory w.r.t synthesis directory
set PR_DIR    ../../pr/

# set variable "type" to either routed or trialrouted
set type routed

# set variable "corner" to one of the following:
#set corner tt1p05v25c 
set corner ss0p95v125c
#set corner ff1p16v25c


#set the number of digits to be used for delay results
set report_default_significant_digits 4

set CLK_PER 5
set DFF_CKQ 0.638
set MAX_INS_DELAY 1.0
set IP_DELAY [expr $MAX_INS_DELAY + $DFF_CKQ]
set DR_CELL_NAME DFFX1_LVT
set DR_CELL_PIN  Q

# Define a helpful function for printing out time strings
proc timef {sec} {
  set hrs [expr $sec/3600]
  set sec [expr $sec-($hrs*3600)]
  set min [expr $sec/60]
  set sec [expr $sec-($min*60)]
  return "${hrs}h ${min}m ${sec}s"
}

set link_library "saed32lvt_${corner}.db *"

set si_enable_analysis TRUE

read_verilog "${PR_DIR}${modname}_${type}.v"

current_design $modname

link_design

create_clock -name $clkname -period $CLK_PER $clkname
set_input_delay $IP_DELAY -clock $clkname [remove_from_collection [all_inputs] $clkname]
set_output_delay -clock $clkname 0 [all_outputs]
set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] $clkname]
set_false_path -from HRESETn


set_propagated_clock [get_clocks $clkname]

report_timing -delay_type min_max > timing_ptsi_${corner}.rpt

read_parasitics -keep_capacitive_coupling -format spef "${PR_DIR}${modname}_${type}.spef.max"
check_timing -include { no_driving_cell ideal_clocks partial_input_delay \
                        unexpandable_clocks }

report_timing -nosplit -input_pins -transition_time -crosstalk_delta \
      -delay_type max -path_type full_clock_expanded \
      > timing_ptsi_${corner}_${type}_max.rpt
report_clock_timing -type summary > timing_ptsi_${corner}_clock_maxRC.rpt
report_si_bottleneck
#report_delay_calculation -crosstalk -from inst1/pin1 -to inst2/pin2
set_noise_parameters -analysis_type all
report_noise > noise_ptsi_${corner}_${type}.rpt
#report_noise_calculation -below -high -from inst1/pin1 -to inst2/pin2

remove_annotated_parasitics
read_parasitics -keep_capacitive_coupling -format spef "${PR_DIR}${modname}_${type}.spef.min"
report_timing -nosplit -input_pins -transition_time -crosstalk_delta \
      -delay_type min -path_type full_clock_expanded \
      > timing_ptsi_${corner}_${type}_min.rpt
report_clock_timing -type summary > timing_ptsi_${corner}_clock_minRC.rpt

set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_ptsi.tcl completed successfully (elapsed time: $timestr actual)"
exit
