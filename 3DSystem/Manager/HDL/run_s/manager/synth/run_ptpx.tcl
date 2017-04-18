###################################################
#
# run_ptpx.tcl
#
# 4/26/2011 W. Rhett Davis (rhett_davis@ncsu.edu)
# updated 4/5/2012, 3/28/2014, 1/26/2015, 8/23/2016
#
#####################################################

set begintime [clock seconds]


# setup name of the clock in your design.
set clkname HCLK

# set variable "modname" to the name of topmost module in design
set modname CORTEXM0DS

# set STRIP_PATH to the path of the instance to be analyzed in the VCD file
set STRIP_PATH "cortexm0ds_tb/u_cortexm0ds"

# set variable "GATE_DIR" to the output directory w.r.t synthesis directory
set GATE_DIR    ../src/gate/

# set variable "PR_DIR" to the HDL & SPEF directory w.r.t synthesis directory
set PR_DIR    ../../pr/

# set variable "type" to routed, trialrouted, or unrouted
set type unrouted

# set PERIOD to the period for power analysis, or -1 for the entire simulation
set PERIOD -1

# set MAX_SIM_TIME to the maximum VCD time, if PERIOD is not -1
set MAX_SIM_TIME 95295


# set variable "corner" to one of the following:
#set corner tt1p05v25c 
#set corner ss0p95v125c
set corner ff1p16v25c

#set the number of digits to be used for delay results
set report_default_significant_digits 4

set CLK_PER 10
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

if { $type eq "unrouted" } then {
  read_verilog "${GATE_DIR}${modname}_final.v"
} else {
  read_verilog "${PR_DIR}${modname}_${type}.v"
}
current_design $modname

link_design

create_clock -name $clkname -period $CLK_PER $clkname
set_input_delay $IP_DELAY -clock $clkname [remove_from_collection [all_inputs] $clkname]
set_output_delay -clock $clkname 0 [all_outputs]
set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] $clkname]


set power_enable_analysis TRUE
set power_analysis_mode averaged

if { $type ne "unrouted" } then {
  read_parasitics -format spef "${PR_DIR}${modname}_${type}.spef"
}

check_timing
update_timing
report_timing

#####################################################################
#       read switching activity file
#####################################################################
#read_saif "../sim/waves.saif" -strip_path $STRIP_PATH

if { $PERIOD == -1 } then {
  read_vcd "../sim/waves.vcd" -strip_path $STRIP_PATH
}  else {
    read_vcd "../sim/waves.vcd" -strip_path $STRIP_PATH -time " 0 $PERIOD"
}

report_switching_activity -list_not_annotated

#####################################################################
#       check/update/report power
#####################################################################
check_power
update_power
report_power -hierarchy > power_ptpx_${corner}.rpt


if { $PERIOD != -1 } then {
    set i $PERIOD
    set j [ expr $i + $PERIOD ]
    while { $j < $MAX_SIM_TIME } {
	read_vcd "../sim/waves.vcd" -strip_path $STRIP_PATH -time "$i $j"
        update_power
        report_power -hierarchy >> power_ptpx_${corner}.rpt
        set i $j
        set j [ expr $i + $PERIOD ]
    }
}


exit
