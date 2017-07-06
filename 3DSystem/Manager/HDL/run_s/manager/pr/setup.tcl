# setup name of the clock in your design.
set clkname clk

# set variable "modname" to the name of topmost module in design
set modname manager

set GATE_DIR	../synth

#set the number of digits to be used for delay results
set report_default_significant_digits 4

#	32 nm libraries are in ps
#set CLK_PER 5000

# Define a helpful function for printing out time strings
proc timef {sec} {
  set hrs [expr $sec/3600]
  set sec [expr $sec-($hrs*3600)]
  set min [expr $sec/60]
  set sec [expr $sec-($min*60)]
  return "${hrs}h ${min}m ${sec}s"
}

suppress_message TFCHK-014
suppress_message UID-401
suppress_message SDFN-9
suppress_message DDEFW-014
suppress_message DDEFW-015
suppress_message DDEFW-016
suppress_message ZRT-030

#	verilog read in warnings
suppress_message LINT-2
suppress_message LINT-3
suppress_message LINT-5
suppress_message LINT-8
suppress_message LINT-29
suppress_message LINT-31
suppress_message LINT-33
suppress_message LINT-52

#	physical library does not have corresponding logical cell description
suppress_message PSYN-025

#	port re-name to sub-module
suppress_message PSYN-850


#	warnings on the technology file (.tf)
suppress_message TFCHK-014
suppress_message TFCHK-014
suppress_message TFCHK-049
suppress_message TFCHK-050
suppress_message TFCHK-073
suppress_message TFCHK-084


#	wire dropped due to DRC problems
suppress_message PGRT-030

#	wire strap fail - reason: floating pieces removed
suppress_message PGRT-039

#	Port 'signal-port name' cannot inherit its location
#		input signal doesn't drive anything
suppress_message PSYN-1042

suppress_message LINK-5





























