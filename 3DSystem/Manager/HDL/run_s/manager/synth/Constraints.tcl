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
# Set the synthetic library variable to enable use of 
# desigware blocks
#---------------------------------------------------------
 set synthetic_library [list dw_foundation.sldb]
 
#---------------------------------------------------------
# Specify the worst case (slowest) libraries and       
# slowest temperature/Vcc conditions                   
# This would involve setting up the slow library as the 
# target and setting the link library to the conctenation
# of the target and the synthetic library
#---------------------------------------------------------
#
 set link_library   [concat  "*" $target_library $synthetic_library $mem_lib $regf_lib  ]

#---------------------------------------------------------
# Specify a 5000ps clock period with 50% duty cycle     
# and a skew of 50ps                                 
#---------------------------------------------------------
 set CLK_SKEW 0.05


 create_clock -name $clkname     -period $CLK_PER           -waveform "0 [expr $CLK_PER / 2]" $clkname

 if {($modname == "dfi") || ($modname == "manager")} {

   create_clock -name clk_diram    -period $CLK_PER           -waveform "0 [expr $CLK_PER / 2]" clk_diram
   create_clock -name clk_diram2x  -period [expr $CLK_PER /2] -waveform "0 [expr $CLK_PER / 4]" clk_diram2x

   foreach_in_collection ck [get_ports clk_diram_cq[*]]  {
     #puts [format "%s" [get_attr $ck name]] 
     create_clock -name [format "%s" [get_attr $ck name]] -period $CLK_PER           -waveform "0 [expr $CLK_PER / 2]" [format "%s" [get_attr $ck name]]
   }
  }

 if {($modname == "dfi") || ($modname == "manager")} {

   #create_generated_clock [get_ports clk_diram2x ] -name [format "%s%s" clk_diram 2x ] -source [get_ports clk] -master_clock clk -add -combinational -multiply_by 2
   create_generated_clock [get_ports clk_diram_cntl_ck    ] -name clk_diram_cntl_ck    -source [get_ports clk] -master_clock clk -add -combinational -multiply_by 1

   foreach_in_collection ck [get_ports clk_diram_data_ck[*]]  {

     #puts [format "%s" [get_attr $ck name]] 
     create_generated_clock [format "%s" [get_attr $ck name]] -name [format "%s" [get_attr $ck name]] -source [get_ports clk] -master_clock clk -add -combinational -multiply_by 1

   }
 }

 set_clock_uncertainty $CLK_SKEW $clkname
 if {($modname == "dfi") || ($modname == "manager")} {
   set_clock_uncertainty $CLK_SKEW clk_diram2x 
   set_clock_uncertainty $CLK_SKEW clk_diram   
   foreach_in_collection ck [get_ports clk_diram_cq[*]]  {
     set_clock_uncertainty $CLK_SKEW [format "%s" [get_attr $ck name]]
   }
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
 set_input_delay $IP_DELAY -clock $clkname [remove_from_collection [all_inputs] $clkname]

 if {($modname == "dfi") || ($modname == "manager")} {

   set_input_delay $IP_DELAY -clock clk_diram2x  [remove_from_collection [all_inputs] clk_diram2x ]
   set_input_delay $IP_DELAY -clock clk_diram    [remove_from_collection [all_inputs] clk_diram   ]

   foreach_in_collection ck [get_ports clk_diram_cq[*]]  {

     set_input_delay $IP_DELAY -clock [format "%s" [get_attr $ck name]] [remove_from_collection [all_inputs] [format "%s" [get_attr $ck name]]]

   }
 }

} elseif {($tech == "28nm")} {

 set_input_delay 0.0060452 -clock $clkname [remove_from_collection [all_inputs] $clkname]

 if {($modname == "dfi") || ($modname == "manager")} {

   set_input_delay 0.0060452 -clock clk_diram2x  [remove_from_collection [all_inputs] clk_diram2x ]
   set_input_delay 0.0060452 -clock clk_diram    [remove_from_collection [all_inputs] clk_diram   ]

   foreach_in_collection ck [get_ports clk_diram_cq[*]]  {

     set_input_delay 0.0060452 -clock [format "%s" [get_attr $ck name]] [remove_from_collection [all_inputs] [format "%s" [get_attr $ck name]]]

   }
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

   foreach_in_collection ck [get_ports clk_diram_cq[*]]  {

     set_output_delay $OP_DELAY -clock [format "%s" [get_attr $ck name]] [all_outputs]

   }
 }

} elseif {($tech == "28nm")} {

 set_output_delay 0.0263 -clock $clkname [all_outputs]

 if {($modname == "dfi") || ($modname == "manager")} {

   set_output_delay 0.0263 -clock clk_diram2x  [all_outputs]
   set_output_delay 0.0263 -clock clk_diram    [all_outputs]

   foreach_in_collection ck [get_ports clk_diram_cq[*]]  {

     set_output_delay 0.0263 -clock [format "%s" [get_attr $ck name]] [all_outputs]

   }
 }

}

#---------------------------------------------------------	
# ASSUME being driven by a D-flip-flop                 
#---------------------------------------------------------


if {$tech == "65nm"} {

  set DR_CELL_NAME	SEN_FDPQ_1
  set DR_CELL_PIN	Q
  set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] $clkname]

 if {($modname == "dfi") || ($modname == "manager")} {
    set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] clk_diram2x ]
    set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] clk_diram   ]
    set_driving_cell -lib_cell "$DR_CELL_NAME" -pin "$DR_CELL_PIN" [remove_from_collection [all_inputs] clk_diram_cq*]
 }


} elseif {($tech == "28nm")} {

  set DFF_CELL_NAME DFFQ_X1M_A12TR_C30
  set DFF_CELL_PIN Q
  set_driving_cell -lib_cell $DFF_CELL_NAME -pin $DFF_CELL_PIN [remove_from_collection [all_inputs] $clkname]
 if {($modname == "dfi") || ($modname == "manager")} {
    set_driving_cell -lib_cell $DFF_CELL_NAME -pin $DFF_CELL_PIN [remove_from_collection [all_inputs] clk_diram2x ]
    set_driving_cell -lib_cell $DFF_CELL_NAME -pin $DFF_CELL_PIN [remove_from_collection [all_inputs] clk_diram   ]
    set_driving_cell -lib_cell $DFF_CELL_NAME -pin $DFF_CELL_PIN [remove_from_collection [all_inputs] clk_diram_cq*]
 }

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

  set PORT_LOAD_CELL sc12mc_cmos28hpp_base_rvt_c30_tt_nominal_max_0p90v_25c/DFFNQ_X1M_A12TR_C30/D
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
#--------------------------------------------------------- 
 set_fix_multiple_port_nets -all -buffer_constants [get_designs]


#---------------------------------------------------------
# Dont touch on DW functions
#  - dw mults etc. are found in dw_foundation.sldb and are found during instance search in the sldb
#  - i dont think we dont_touch these instances
#--------------------------------------------------------- 

#---------------------------------------------------------
# Dont touch on memories and regFiles
#--------------------------------------------------------- 
# Seem to have to perform a get_cell first
set acells [get_cell -hier]
if {$tech == "65nm"} {

  set_dont_touch [get_cell -hier -regexp -filter "ref_name =~ asdr.*"]
  set_dont_touch [get_cell -hier -regexp -filter "ref_name =~ sass.*"]

} elseif {($tech == "28nm")} {

  set_dont_touch [get_cell -hier -regexp -filter "ref_name =~ arm_regf.*"]
  set_dont_touch [get_cell -hier -regexp -filter "ref_name =~ arm_sram.*"]

}

#---------------------------------------------------------
# Other Dont touch 
#  - SIMD core
#--------------------------------------------------------- 
if {($modname == "simd_wrapper") || ($modname == "pe")} {
  set_dont_touch [get_cell simd_wrapper/simd_core]
}

set verilogout_show_unconnected_pins true

#---------------------------------------------------------
# Other 
#  - DW FP MAC timing can be ignored as we assume horowitz performance
#--------------------------------------------------------- 
 if {($modname == "streamingOps") || ($modname == "pe")} {
   set_disable_timing [get_cells  -hier *DW_fp_mac*]
 }

#------------------------------------------------------
# During the initial map (synthesis), Synopsys might   
# have built parts (such as adders) using its          
# DesignWare(TM) library.  In order to remap the       
# design to our TSMC025 library AND to create scope    
# for logic reduction, I want to 'flatten out' the     
# DesignWare components.  i.e. Make one flat design    
#                                                      
# 'replace_synthetic' is the cleanest way of doing this
#------------------------------------------------------

replace_synthetic -ungroup

#ungroup -all -flatten

#---------------------------------------------------------
# check the design before optimization  
#---------------------------------------------------------

#---------------------------------------------------------
# check_design checks for consistency of design and issues
# warnings and errors. An error would imply the design is 
# not compilable. See > man check_design for more information.
#---------------------------------------------------------
check_design \
	> ${modname}_${type}_check_design.rpt
#---------------------------------------------------------
# link performs check for presence of the design components 
# instantiated within the design. It makes sure that all the 
# components (either library unit or other designs within the
# heirarchy) are present in the search path and connects all 
# of the disparate components logically to the present design
#---------------------------------------------------------
link 
