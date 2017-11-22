###################################################
#
# run_ptpx.tcl
#
# 4/26/2011 W. Rhett Davis (rhett_davis@ncsu.edu)
# updated 4/5/2012, 3/28/2014, 1/26/2015, 8/23/2016
#
#####################################################

set begintime [clock seconds]


source setup.tcl


# setup name of the clock in your design.
set clkname clk

# set variable "modname" to the name of topmost module in design
#set modname pe
set modname_id 2

# set STRIP_PATH to the path of the instance to be analyzed in the VCD file
if {$modname == "pe"} {

  set STRIP_PATH "top/system_inst/pe_array_inst/pe_inst\[2\].pe"

} else {

  set STRIP_PATH "top/system_inst/pe_array_inst/pe_inst\[2\].pe.$modname"

}

# set variable "type" to routed, trialrouted, or unrouted
#set type routed_detail
set type routed_estimate

# set variable "GATE_DIR" to the output directory w.r.t synthesis directory
if {$type eq "routed_estimate"} {

  set GATE_DIR    ../synth/logs.65nm/${modname}/

} else { 

  set GATE_DIR    ../synth/logs.65nm/${modname}/

}

# set variable "PR_DIR" to the HDL & SPEF directory w.r.t synthesis directory
if {$type eq "routed_estimate"} {

  set PR_DIR    ../pr/

} else { 

  set PR_DIR    ../pr/logs.65nm/${modname}/

}

# set PERIOD to the period for power analysis, or -1 for the entire simulation
set PERIOD -1

# set MAX_SIM_TIME to the maximum VCD time, if PERIOD is not -1
set MAX_SIM_TIME 9500


# set variable "corner" to one of the following:
set corner tt1p05v25c 
#set corner ss0p95v125c
#set corner ff1p16v25c

#set the number of digits to be used for delay results
set report_default_significant_digits 4


# Define a helpful function for printing out time strings
proc timef {sec} {
  set hrs [expr $sec/3600]
  set sec [expr $sec-($hrs*3600)]
  set min [expr $sec/60]
  set sec [expr $sec-($min*60)]
  return "${hrs}h ${min}m ${sec}s"
}

set link_library   [concat  $target_library $mem_lib $regf_lib *]
#set link_library "/afs/eos.ncsu.edu/lockers/research/ece/wdavis/tech/synopsys/SAED32/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_${corner}.db *"

if { $type eq "unrouted" } then {

  read_verilog "${GATE_DIR}${modname}_final.v"

} elseif { $type eq "routed_estimate" } then {

  read_verilog "${PR_DIR}${modname}_${type}.v"

} else {

  read_verilog "${PR_DIR}${modname}_${type}.v"

}

current_design $modname

link_design

create_clock -name $clkname -period $CLK_PER $clkname
 if {($modname == "dfi") || ($modname == "manager")} {
   create_generated_clock [get_ports clk_diram2x ] -name clk_diram2x  -source [get_ports clk] -master_clock clk -add -combinational -multiply_by 2
   create_generated_clock [get_ports clk_diram   ] -name clk_diram    -source [get_ports clk] -master_clock clk -add -combinational -multiply_by 1
   create_generated_clock [get_ports clk_diram_cq] -name clk_diram_cq -source [get_ports clk] -master_clock clk -add -combinational -multiply_by 1
 }

if {$tech == "65nm"} {

 set DFF_CKQ 0.638
 set IP_DELAY [expr 0.02 + $DFF_CKQ]
 set_input_delay $IP_DELAY -clock $clkname [remove_from_collection [all_inputs] $clkname]

} elseif {($tech == "28nm")} {

 set_input_delay 0.0060452 -clock $clkname [remove_from_collection [all_inputs] $clkname]

}

if {$tech == "65nm"} {

 set DFF_SETUP 0.546
 set OP_DELAY [expr 0.02 + $DFF_SETUP]
 set_output_delay $OP_DELAY -clock $clkname [all_outputs]
 if {($modname == "dfi") || ($modname == "manager")} {
   set_output_delay 0.0263 -clock clk_diram2x  [all_outputs]
   set_output_delay 0.0263 -clock clk_diram    [all_outputs]
   set_output_delay 0.0263 -clock clk_diram_cq [all_outputs]
 }

} elseif {($tech == "28nm")} {

 set_output_delay 0.0263 -clock $clkname [all_outputs]
 if {($modname == "dfi") || ($modname == "manager")} {
   set_output_delay 0.0263 -clock clk_diram2x  [all_outputs]
   set_output_delay 0.0263 -clock clk_diram    [all_outputs]
   set_output_delay 0.0263 -clock clk_diram_cq [all_outputs]
 }

}

if {$tech == "65nm"} {

  set DR_CELL_NAME SEN_FDPQ_1
  set DR_CELL_PIN Q
  set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] $clkname]
 if {($modname == "dfi") || ($modname == "manager")} {
    set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] clk_diram2x ]
    set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] clk_diram   ]
    set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] clk_diram_cq]
 }


} elseif {($tech == "28nm")} {

  set DFF_CELL_NAME DFFQ_X1M_A12TR_C30
  set DFF_CELL_PIN Q
  set_driving_cell -lib_cell $DFF_CELL_NAME -pin $DFF_CELL_PIN [remove_from_collection [all_inputs] $clkname]
 if {($modname == "dfi") || ($modname == "manager")} {
    set_driving_cell -lib_cell $DFF_CELL_NAME -pin $DFF_CELL_PIN [remove_from_collection [all_inputs] clk_diram2x ]
    set_driving_cell -lib_cell $DFF_CELL_NAME -pin $DFF_CELL_PIN [remove_from_collection [all_inputs] clk_diram   ]
    set_driving_cell -lib_cell $DFF_CELL_NAME -pin $DFF_CELL_PIN [remove_from_collection [all_inputs] clk_diram_cq]
 }

}



set power_enable_analysis TRUE
set power_analysis_mode averaged

if { $type ne "unrouted" } then {

  read_parasitics -format spef "${PR_DIR}${modname}_${type}.spef.max"

}

#check_timing
#update_timing
#report_timing

#####################################################################
#       read switching activity file
#####################################################################
#read_saif "../sim/waves.saif" -strip_path $STRIP_PATH

if { $PERIOD == -1 } then {
  if {$modname == "pe"} {

    if {$type == "routed_estimate"} {

      #read_vcd "../../../../../System/SIMULATION/sv/${modname}_${modname_id}.vcd" -strip_path $STRIP_PATH 
      read_saif "./${modname}_${type}_${modname_id}.saif" -strip_path $STRIP_PATH 

    } else {

      read_saif "./logs.$tech/${modname}/${modname}_${modname_id}.saif" -strip_path $STRIP_PATH 

    }

  } else {

    read_saif "./logs.$tech/pe/pe_2.saif" -strip_path $STRIP_PATH 

  }
}  else {

  if {$modname == "pe"} {

    #read_vcd "../../../../../System/SIMULATION/sv/${modname}_${modname_id}.vcd" -strip_path $STRIP_PATH  -time " 0 $PERIOD"
    read_saif "./logs.$tech/${modname}/${modname}_${modname_id}.saif" -strip_path $STRIP_PATH  -time " 0 $PERIOD"

  } else {

    read_saif "./logs.$tech/pe/pe_2.saif" -strip_path $STRIP_PATH -time " 0 $PERIOD"

  }
}

report_switching_activity -list_not_annotated

#####################################################################
#       check/update/report power
#####################################################################
check_power
update_power
report_power -hierarchy > power_ptpx_${type}_${corner}.rpt


if { $PERIOD != -1 } then {
    set i $PERIOD
    set j [ expr $i + $PERIOD ]
    while { $j < $MAX_SIM_TIME } {
        read_vcd "../../../../../System/SIMULATION/sv"/${modname}_${modname_id}.vcd" -strip_path $STRIP_PATH -time "$i $j"
        update_power
        report_power -hierarchy >> power_ptpx_${corner}.rpt
        set i $j
        set j [ expr $i + $PERIOD ]
    }
}


#exit
