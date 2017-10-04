# setup name of the clock in your design.
set clkname clk

# set variable "modname" to the name of topmost module in design
set modname manager

set GATE_DIR	../synth

#set the number of digits to be used for delay results
set report_default_significant_digits 4

if {$tech == "65nm"} {

  set CLK_PER 6.0

} elseif {($tech == "28nm")} {

  set CLK_PER 1.0

}


# Define a helpful function for printing out time strings
proc timef {sec} {
  set hrs [expr $sec/3600]
  set sec [expr $sec-($hrs*3600)]
  set min [expr $sec/60]
  set sec [expr $sec-($min*60)]
  return "${hrs}h ${min}m ${sec}s"
}





























