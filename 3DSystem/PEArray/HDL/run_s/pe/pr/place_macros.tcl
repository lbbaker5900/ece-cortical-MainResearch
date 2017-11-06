
# Get core area to define placement boundaries
set c_area [get_attr [get_core_area] bbox]

set g 20
set fg 50
set x 50
set y 50 

# move_objects -delta {630.590 -1434.220} [get_selection]
# move_objects -delta {-354.295 322.200} [get_selection]
# move_objects -delta {-178.775 41.400} [get_selection]
# move_objects -delta {182.025 -198.000} [get_selection]

get_cells -hier -filter "full_name =~ mem_acc_cont/bank_mem*gmemory/dw_mem*_mem1p*"
get_cells -hier -regexp -filter "full_name =~ mem_acc_cont.*bank_mem_\[0-9\]\[0-9\]__.*gmemory/dw_mem.*_mem1p.*"

#foreach_in_collection hcell [get_cells -hier -filter "full_name =~ mem_acc_cont/bank_mem*gmemory/genblk*_mem1p*"] {
#
#
set dx 216
set dy 106 
set x 620
set y 810 
set llx [expr $x]
set lly [expr $y]
change_selection [get_cells -hier -regexp -filter "full_name =~ mem_acc_cont.*bank_mem_\[0-7\]__.*gmemory/dw_mem.*_mem1p.*"]
foreach_in_collection hcell [get_selection] {
#  set_attr $hcell_inst is_placed false
  set hcell_inst [get_attr $hcell full_name] 
  #puts $hcell
  #puts $hcell_inst
  #puts [get_attr $hcell origin]
  #puts [get_attr $hcell_inst origin]
  set org "$llx $lly"
  #eval set_attr $hcell origin {$org}
  eval set_attr $hcell_inst origin {$org}
  #puts [get_attr $hcell origin]
  #puts [get_attr $hcell_inst origin]
  set lly [expr $lly + $dy]
  #puts $llx 
  #puts $lly
}


set x [expr $x + $dx]
#set y [expr $y + $dy]
set llx [expr $x]
set lly [expr $y]
change_selection [get_cells -hier -regexp -filter "full_name =~ mem_acc_cont.*bank_mem_\[8-9\]__.*gmemory/dw_mem.*_mem1p.* || full_name =~ mem_acc_cont.*bank_mem_1\[0-5\]__.*gmemory/dw_mem.*_mem1p.*"]
foreach_in_collection hcell [get_selection] {
#  set_attr $hcell_inst is_placed false
  set hcell_inst [get_attr $hcell full_name] 
  #puts $hcell
  #puts $hcell_inst
  #puts [get_attr $hcell origin]
  #puts [get_attr $hcell_inst origin]
  set org "$llx $lly"
  #eval set_attr $hcell origin {$org}
  eval set_attr $hcell_inst origin {$org}
  #puts [get_attr $hcell origin]
  #puts [get_attr $hcell_inst origin]
  set lly [expr $lly + $dy]
  #puts $llx 
  #puts $lly
}


set x [expr $x + $dx]
#set y [expr $y + $dy]
set llx [expr $x]
set lly [expr $y]
change_selection [get_cells -hier -regexp -filter "full_name =~ mem_acc_cont.*bank_mem_1\[6-9\]__.*gmemory/dw_mem.*_mem1p.* || full_name =~ mem_acc_cont.*bank_mem_2\[0-3\]__.*gmemory/dw_mem.*_mem1p.*"]
foreach_in_collection hcell [get_selection] {
#  set_attr $hcell_inst is_placed false
  set hcell_inst [get_attr $hcell full_name] 
  #puts $hcell
  #puts $hcell_inst
  #puts [get_attr $hcell origin]
  #puts [get_attr $hcell_inst origin]
  set org "$llx $lly"
  #eval set_attr $hcell origin {$org}
  eval set_attr $hcell_inst origin {$org}
  #puts [get_attr $hcell origin]
  #puts [get_attr $hcell_inst origin]
  set lly [expr $lly + $dy]
  #puts $llx 
  #puts $lly
}


set x [expr $x + $dx]
#set y [expr $y + $dy]
set llx [expr $x]
set lly [expr $y]
change_selection [get_cells -hier -regexp -filter "full_name =~ mem_acc_cont.*bank_mem_2\[4-9\]__.*gmemory/dw_mem.*_mem1p.* || full_name =~ mem_acc_cont.*bank_mem_3\[0-1\]__.*gmemory/dw_mem.*_mem1p.*"]
foreach_in_collection hcell [get_selection] {
#  set_attr $hcell_inst is_placed false
  set hcell_inst [get_attr $hcell full_name] 
  #puts $hcell
  #puts $hcell_inst
  #puts [get_attr $hcell origin]
  #puts [get_attr $hcell_inst origin]
  set org "$llx $lly"
  #eval set_attr $hcell origin {$org}
  eval set_attr $hcell_inst origin {$org}
  #puts [get_attr $hcell origin]
  #puts [get_attr $hcell_inst origin]
  set lly [expr $lly + $dy]
  #puts $llx 
  #puts $lly
}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# PE_CNTL 
#
#--------------------------------------------------
# Option memory 

set hcell [get_cells -hier -filter "full_name =~ pe_cntl/stOp_option_memory* && ref_name =~ asdr*"]

set ref_inst [get_attr $hcell full_name] 
set refH [get_attr $hcell height]
set refW [get_attr $hcell width]

set x 300
set y 400

set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$fg]
set x [expr [expr $x + 0] + 0]


#--------------------------------------------------
# STD OOB

set hcell [get_cells -hier -filter "full_name =~ pe_cntl/from_Sti_OOB* && ref_name =~ asdr*"]

set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$fg]
set x [expr [expr $x + 0] + 0]




