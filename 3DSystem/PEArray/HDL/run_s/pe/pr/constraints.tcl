#---------------------------------------------------------
# Our first Optimization 'compile' is intended to      
# produce a design that will meet hold-time            
# under worst-case conditions:                         
# 		- slowest process corner                        
# 		- highest operating temperature and lowest Vcc  
# 		- expected worst case clock skew                
#---------------------------------------------------------
#---------------------------------------------------------
# Set the current design to the top level instance name 
# to make sure that you are working on the right design
# at the time of constraint setting and compilation
#---------------------------------------------------------

##################################################
# Revision History: 01/27/2010, by Chanyoun Won
#                   01/19/2011, by Won Ha Choi
#                   01/21/2011, by Zhuo Yan
##################################################

 current_design $modname


#---------------------------------------------------------
# Specify a 5000ps clock period with 50% duty cycle     
# and a skew of 50ps                                 
#---------------------------------------------------------
set CLK_SKEW 0.05


create_clock -name $clkname     -period $CLK_PER           -waveform "0 [expr $CLK_PER / 2]" $clkname

if {($modname == "dfi") || ($modname == "manager")} {
  create_clock -name clk_diram    -period $CLK_PER           -waveform "0 [expr $CLK_PER / 2]" clk_diram
  create_clock -name clk_diram2x  -period [expr $CLK_PER /2] -waveform "0 [expr $CLK_PER / 4]" clk_diram2x
}

foreach_in_collection ck [get_ports clk_diram_cq[*]]  {
  create_clock -name [format "%s" [get_attr $ck name]] -period $CLK_PER           -waveform "0 [expr $CLK_PER / 2]" [format "%s" [get_attr $ck name]]
}

if {($modname == "dfi") || ($modname == "manager")} {

  create_generated_clock [get_ports clk_diram_cntl_ck    ] -name clk_diram_cntl_ck    -source [get_ports clk] -master_clock clk -add -combinational -multiply_by 1

  foreach_in_collection ck [get_ports clk_diram_data_ck[*]]  {

    create_generated_clock [format "%s" [get_attr $ck name]] -name [format "%s" [get_attr $ck name]] -source [get_ports clk] -master_clock clk -add -combinational -multiply_by 1

  }
}

set_clock_uncertainty $CLK_SKEW $clkname

if {($modname == "dfi") || ($modname == "manager")} {
  set_false_path -from [get_clocks clk_diram2x] -to [get_clocks clk        ]
  set_false_path -from [get_clocks clk        ] -to [get_clocks clk_diram2x]
}

#---------------------------------------------------------
# Now set up the 'CONSTRAINTS' on the design:          
# 1.  How much of the clock period is lost in the      
#     modules connected to it                          
# 2.  What type of cells are driving the inputs        
# 3.  What type of cells and how many (fanout) must it 
#     be able to drive                                 
#---------------------------------------------------------

# Following parameters have been modified based on Nangate 45nm library (slow conditional):
# DFF_CKQ, IP_DELAY, DFF_SETUP, OP_DELAY, WIRE_LOAD_EST
# These values are based on simulation. Credited to: Christopher Mineo

#---------------------------------------------------------
# ASSUME being driven by a slowest D-flip-flop         
# The DFF cell has a clock-Q delay of 638 ps          
# EX: 50um M3 has R of 178.57 Ohms and C of 12.5585fF. 0.69RC = 1.55ps, and wire load
# of 50um M3 is 13fF. Therefore, roughly 20ps wire delay is assumed.                
# NOTE: THESE ARE INITIAL ASSUMPTIONS ONLY             
#---------------------------------------------------------
#
if {$tech == "65nm"} {

 set DFF_CKQ 0.638
 set IP_DELAY [expr 0.02 + $DFF_CKQ]
 set all_in [all_inputs]
 set all_in [remove_from_collection $all_in $clkname]

 if {($modname == "dfi") || ($modname == "manager")} {
   set all_in [remove_from_collection $all_in clk_diram2x ]
   set all_in [remove_from_collection $all_in clk_diram   ]
   set all_in [remove_from_collection $all_in clk_diram_cq]
  }

 set_input_delay $IP_DELAY -clock $clkname $all_in

} elseif {($tech == "28nm")} {

 set_input_delay 0.0060452 -clock $clkname    $all_in 

 if {($modname == "dfi") || ($modname == "manager")} {
   set_input_delay 0.0060452 -clock clk_diram    $all_in 
   set_input_delay 0.0060452 -clock clk_diram    $all_in 
   set_input_delay 0.0060452 -clock clk_diram_cq $all_in 
  }
}

#---------------------------------------------------------
# ASSUME this module is driving a D-flip-flip          
# The DFF cell has a set-up time of 546 ps             
# Same wire delay as mentioned above           
# NOTE: THESE ARE INITIAL ASSUMPTIONS ONLY             
#---------------------------------------------------------

if {$tech == "65nm"} {

 set DFF_SETUP 0.546
 set OP_DELAY [expr 0.02 + $DFF_SETUP]
 set_output_delay $OP_DELAY -clock $clkname [all_outputs]

 if {($modname == "dfi") || ($modname == "manager")} {
   set_output_delay $OP_DELAY -clock clk_diram2x  [all_outputs]
   set_output_delay $OP_DELAY -clock clk_diram    [all_outputs]
   set_output_delay $OP_DELAY -clock clk_diram_cq [all_outputs]
  }

} elseif {($tech == "28nm")} {

 set_output_delay 0.0263 -clock $clkname [all_outputs]

 if {($modname == "dfi") || ($modname == "manager")} {
   set_output_delay 0.0263 -clock clk_diram2x  [all_outputs]
   set_output_delay 0.0263 -clock clk_diram    [all_outputs]
   set_output_delay 0.0263 -clock clk_diram_cq [all_outputs]
  }
}

#---------------------------------------------------------	
# ASSUME being driven by a D-flip-flop                 
#---------------------------------------------------------


if {$tech == "65nm"} {

  set DR_CELL_NAME	SEN_FDPQ_1
  set DR_CELL_PIN	Q
  set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" $all_in


} elseif {($tech == "28nm")} {

  set DFF_CELL_NAME DFFQ_X1M_A12TR_C30
  set DFF_CELL_PIN Q
  set_driving_cell -lib_cell $DFF_CELL_NAME -pin $DFF_CELL_PIN all_in

}


#---------------------------------------------------------
# ASSUME the worst case output load is                 
# 4 D-flip-flop (D-inputs) and                         
# 0.013 units of wiring capacitance                     
#---------------------------------------------------------

if {$tech == "65nm"} {

  set PORT_LOAD_CELL cp65npksdst_tt1p0v25c/SEN_FDPQ_1/D
  set WIRE_LOAD_EST   0.013
  set FANOUT          4
  set PORT_LOAD [expr $WIRE_LOAD_EST + $FANOUT * [load_of $PORT_LOAD_CELL]]
  set_load $PORT_LOAD [all_outputs]

} elseif {($tech == "28nm")} {

  set PORT_LOAD_CELL sc12mc_cmos28hpp_base_rvt_c30_ss_nominal_max_0p765v_110c/DFFQ_X1M_A12TR_C30/D
  set WIRE_LOAD_EST   0.013
  set FANOUT          4
  set PORT_LOAD [expr $WIRE_LOAD_EST + $FANOUT * [load_of $PORT_LOAD_CELL]]
  set_load $PORT_LOAD [all_outputs]

}


#---------------------------------------------------------
# Now set the GOALS for the compile                    
# In most cases you want minimum area, so set the      
# goal for maximum area to be 0                        
#---------------------------------------------------------
 set_max_area 0
#---------------------------------------------------------
# This command prevents feedthroughs from input to output and avoids assign statements                 
#------------------------------------------------------ 
 set_fix_multiple_port_nets -all -buffer_constants [get_designs]



#---------------------------------------------------------
# check_design checks for consistency of design and issues
# warnings and errors. An error would imply the design is 
# not compilable. See > man check_design for more information.
#---------------------------------------------------------
check_design \
	> ${modname}_check_design.rpt
#---------------------------------------------------------
# link performs check for presence of the design components 
# instantiated within the design. It makes sure that all the 
# components (either library unit or other designs within the
# heirarchy) are present in the search path and connects all 
# of the disparate components logically to the present design
#---------------------------------------------------------
link 
