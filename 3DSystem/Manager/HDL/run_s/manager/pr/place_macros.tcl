
####    # move_objects -delta {630.590 -1434.220} [get_selection]
####    # move_objects -delta {-354.295 322.200} [get_selection]
####    # move_objects -delta {-178.775 41.400} [get_selection]
####    # move_objects -delta {182.025 -198.000} [get_selection]
####    
#

# Get core area to define placement boundaries
set c_area [get_attr [get_core_area] bbox]

#------------------------------------------------------------------------------------------------------------------------------------------------------
#
set x 50
set y 50 

#change_selection [get_cells -hier -filter "full_name =~ main_mem_cntl/from_dfi_fifo* && ref_name =~ asdr*"]
#
set a [sort_collection [get_cells -hier -filter "full_name =~ main_mem_cntl/from_dfi_fifo* && ref_name =~ asdr*"] -descending {full_name }]

set ref [index_collection $a 0]
set ref_inst [get_attr $ref full_name] 
set refH [get_attr $ref height]
set refW [get_attr $ref width]

set g 20
set fg 50
set x 50
set y 50 

set dx [expr 0 + 0]
set dy [expr $refH + $g]

set llx [expr $x]
set lly [expr $y]

foreach_in_collection hcell $a {
  set hcell_inst [get_attr $hcell full_name] 
  set org "$llx $lly"
  #eval set_attr $hcell origin {$org}
  eval set_attr $hcell_inst origin {$org}
  puts $org

  set lly [expr $lly + $dy]
}

set x [expr [expr $x + $refW] +$g]
set y 50 
puts "$x $y"
#------------------------------------------------------------------------------------------------------------------------------------------------------
# MRC Instance 0

set y 50 

# main inout fifos
set a [sort_collection [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_0*/from_mmc_fifo* && ref_name =~ asdr*"] -descending {full_name }]

set ref [index_collection $a 0]
set ref_inst [get_attr $ref full_name] 
set refH [get_attr $ref height]
set refW [get_attr $ref width]

# Start from RHS
set x [expr [expr [lindex [lindex $c_area 1] 0] - $strm0_fifo_width] - 50]
set x [expr [expr $x - $strm0_fifo_width] - $g]

set dx [expr 0 + 0]
set dy [expr $refH + $g]

set strm0_fifo_lhs [expr $x + 0]
set strm0_fifo_rhs [expr $x + $refW]
set strm0_fifo_width $refW

set llx [expr $x]
set lly [expr $y]

foreach_in_collection hcell $a {
  set hcell_inst [get_attr $hcell full_name] 
  set org "$llx $lly"
  eval set_attr $hcell_inst origin {$org}
  puts $org

  set lly [expr $lly + $dy]
}

set strm0_fifo_top [expr $lly + 0]

set y [expr $lly +0]

set llx [expr $x]
set lly [expr $y]

# to strm fsm
set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_0*/addr_to_strm_fsm_fifo* && ref_name =~ asdr*"] 
set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
set strm0_fn_rhs [expr $x + [get_attr $hcell width]]

set y [expr [expr $lly + [get_attr $hcell height]] +$g]

set llx [expr $x]
set lly [expr $y]

set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_0*/consJump_to_strm_fsm_fifo* && ref_name =~ asdr*"] 
set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
if {$strm0_fn_rhs< [get_attr $hcell width]} {
  set strm0_fn_rhs [expr $x + [get_attr $hcell width]]
}
set y [expr [expr $lly + [get_attr $hcell height]] +$g]

# from WUD
set llx [expr $x]
set lly [expr $y]

set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_0*/from_Wud_Fifo* && ref_name =~ asdr*"] 
set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
if {$strm0_fn_rhs< [get_attr $hcell width]} {
  set strm0_fn_rhs [expr $x + [get_attr $hcell width]]
}

set strm0_fn_top [expr $lly + [get_attr $hcell height]]

# Storage Desc mem 

set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_0*/storageDesc_mem* && ref_name =~ sass*"] 
set hcell_inst [get_attr $hcell full_name] 

set x [expr $strm0_fifo_rhs - [get_attr $hcell width]]
set y $strm0_fifo_top

set llx [expr $x]
set lly [expr $y]

set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
set y [expr [expr $y + [get_attr $hcell height]] +$g]

# Storage Desc ConsJump mem 

set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_0*/storageDescConsJump_mem* && ref_name =~ sass*"] 
set hcell_inst [get_attr $hcell full_name] 

set x [expr $strm0_fifo_rhs - [get_attr $hcell width]]

set llx [expr $x]
set lly [expr $y]

set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
set y [expr [expr $y + [get_attr $hcell height]] +$g]





set y [expr [expr $lly + [get_attr $hcell height]] +$g]
set x [expr [expr $x + $refW] +$g]

#------------------------------------------------------------------------------------------------------------------------------------------------------
# MRC Instance 1

set y 50 

set a [sort_collection [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_1*/from_mmc_fifo* && ref_name =~ asdr*"] -descending {full_name }]

set ref [index_collection $a 0]
set ref_inst [get_attr $ref full_name] 
set refH [get_attr $ref height]
set refW [get_attr $ref width]

# Start from RHS
set x [expr [expr [lindex [lindex $c_area 1] 0] - $strm0_fifo_width] - 50]

set dx [expr 0 + 0]
set dy [expr $refH + $g]

set strm1_fifo_lhs [expr $x + 0]
set strm1_fifo_rhs [expr $x + $refW]
set strm1_fifo_width $refW

set llx [expr $x]
set lly [expr $y]

foreach_in_collection hcell $a {
  set hcell_inst [get_attr $hcell full_name] 
  set org "$llx $lly"
  eval set_attr $hcell_inst origin {$org}
  puts $org

  set lly [expr $lly + $dy]
}

set strm1_fifo_top [expr $lly + 0]

set y [expr $lly +0]

set llx [expr $x]
set lly [expr $y]

# to strm fsm
set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_1*/addr_to_strm_fsm_fifo* && ref_name =~ asdr*"] 
set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
set strm1_fn_rhs [expr $x + [get_attr $hcell width]]

set y [expr [expr $lly + [get_attr $hcell height]] +$g]

set llx [expr $x]
set lly [expr $y]

set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_1*/consJump_to_strm_fsm_fifo* && ref_name =~ asdr*"] 
set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
if {$strm1_fn_rhs< [get_attr $hcell width]} {
  set strm1_fn_rhs [expr $x + [get_attr $hcell width]]
}

set y [expr [expr $lly + [get_attr $hcell height]] +$g]

# from WUD
set llx [expr $x]
set lly [expr $y]

set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_1*/from_Wud_Fifo* && ref_name =~ asdr*"] 
set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
if {$strm1_fn_rhs< [get_attr $hcell width]} {
  set strm1_fn_rhs [expr $x + [get_attr $hcell width]]
}

set strm1_fn_top [expr $lly + [get_attr $hcell height]]

# Storage Desc mem 

set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_1*/storageDesc_mem* && ref_name =~ sass*"] 
set hcell_inst [get_attr $hcell full_name] 

set x [expr $strm1_fifo_rhs - [get_attr $hcell width]]
set y $strm1_fifo_top

set llx [expr $x]
set lly [expr $y]

set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
set y [expr [expr $y + [get_attr $hcell height]] +$g]

# Storage Desc ConsJump mem 

set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_1*/storageDescConsJump_mem* && ref_name =~ sass*"] 
set hcell_inst [get_attr $hcell full_name] 

set x [expr $strm1_fifo_rhs - [get_attr $hcell width]]

set llx [expr $x]
set lly [expr $y]

set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}
set y [expr [expr $y + [get_attr $hcell height]] +$g]




# Bring back to edge of mrc_cntl0
set x [expr [expr [lindex [lindex $c_area 1] 0] - $refW] - 50]
set x [expr [expr $x - $refW] - $fg]
set x $strm0_fifo_lhs


#------------------------------------------------------------------------------------------------------------------------------------------------------
# STUC

set hcell [get_cells -hier -filter "full_name =~ stu_cntl/from_Stu_Fifo* && ref_name =~ asdr*"]

set x $strm0_fifo_lhs

set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$fg]
set x [expr [expr $x + 0] + 0]

#------------------------------------------------------------------------------------------------------------------------------------------------------
# RDP

set hcell [get_cells -hier -filter "full_name =~ rdp_cntl/from_Stuc_Fifo* && ref_name =~ asdr*"]

set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$g]
set x [expr [expr $x + 0] + 0]


set hcell [get_cells -hier -filter "full_name =~ rdp_cntl/storageDestAddr_LocalFifo* && ref_name =~ asdr*"]

set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$g]
set x [expr [expr $x + 0] + 0]


set hcell [get_cells -hier -filter "full_name =~ rdp_cntl/storagePtr_LocalFifo* && ref_name =~ asdr*"]

set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$g]
set x [expr [expr $x + 0] + 0]


set hcell [get_cells -hier -filter "full_name =~ rdp_cntl/from_WuDecode_Fifo* && ref_name =~ asdr*"]

set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$fg]
set x [expr [expr $x + 0] + 0]


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Instruction Memory

set hcell [get_cells -hier -filter "full_name =~ wu_decode/from_WuMemory_Fifo* && ref_name =~ asdr*"]


set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$g]
set x [expr [expr $x + 0] + 0]

#------------------------------------------------------------------------------------------------------------------------------------------------------
# OOB Downstream

set hcell [get_cells -hier -filter "full_name =~ oob_downstream_cntl/from_WuDecoder_Fifo* && ref_name =~ asdr*"]

set x 500
set y 1400 

set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$fg]
set x [expr [expr $x + 0] + 0]

#------------------------------------------------------------------------------------------------------------------------------------------------------
# WU Decode

set hcell [get_cells -hier -filter "full_name =~ wu_memory/instruction_mem* && ref_name =~ sass*"]


set llx [expr $x]
set lly [expr $y]

set hcell_inst [get_attr $hcell full_name] 
set org "$llx $lly"
eval set_attr $hcell_inst origin {$org}

set y [expr [expr $lly + [get_attr $hcell height]] +$fg]
set x [expr [expr $x + 0] + 0]

#------------------------------------------------------------------------------------------------------------------------------------------------------
# NoC 

# Input and Output ports

set a [sort_collection [get_cells -hier -filter "full_name =~ mgr_noc_cntl/Port_from_NoC* && ref_name =~ asdr*"] {full_name }]
set b [sort_collection [get_cells -hier -filter "full_name =~ mgr_noc_cntl/Port_to_NoC*   && ref_name =~ asdr*"] {full_name }]

set ref [index_collection $a 0]
set ref_inst [get_attr $ref full_name] 
set refH [get_attr $ref height]
set refW [get_attr $ref width]

# Create locations
set rx [expr [expr [lindex [lindex $c_area 1] 0] - $refW] - 50]
set lx [expr [lindex [lindex $c_area 0] 0] - 50]

set locations {{50 1400} {50 1800} {1500 1800} {1500 1400}}
set locations [list [list 50 1600] [list 50 1950] [list $rx 1950] [list $rx 1600]]

set dx [expr 0 + 0]
set dy [expr $refH + $g]


set llx [expr $x]
set lly [expr $y]

set idx 0
foreach_in_collection hcell $a {

  if {$idx == 0} {
    set org "[lindex [lindex $locations $idx] 0] [lindex [lindex $locations $idx] 1]"
  } elseif {$idx == 1} {
    set org "[lindex [lindex $locations $idx] 0] [lindex [lindex $locations $idx] 1]"
  } elseif {$idx == 2} {
    set org "[lindex [lindex $locations $idx] 0] [lindex [lindex $locations $idx] 1]"
  } else  {
    set org "[lindex [lindex $locations $idx] 0] [lindex [lindex $locations $idx] 1]"
  }

  #place input
  set hcell_inst [get_attr $hcell full_name] 
  eval set_attr $hcell_inst origin {$org}

  #place output
  set org "[lindex $org 0] [expr [expr [lindex $org 1] +$refH] +$g]"
  set ocell [index_collection $b $idx]
  set ocell_inst [get_attr $ocell full_name] 
  eval set_attr $ocell_inst origin {$org}

  puts [get_attr $hcell bbox]

  set idx [expr $idx +1]
}

# Local Port
set a [sort_collection [get_cells -hier -filter "full_name =~ mgr_noc_cntl/from_local_fifo* && ref_name =~ asdr*"] {full_name }]

set ref [index_collection $a 0]
set ref_inst [get_attr $ref full_name] 
set refH [get_attr $ref height]
set refW [get_attr $ref width]

set x 1200
set y 1800 

set dx [expr 0 + 0]
set dy [expr $refH + $g]


set llx [expr $x]
set lly [expr $y]

set idx 0
foreach_in_collection hcell $a {

  set hcell_inst [get_attr $hcell full_name] 
  set org "$llx $lly"
  eval set_attr $hcell_inst origin {$org}
  set lly [expr $lly + $dy]

  #place input
  set hcell_inst [get_attr $hcell full_name] 
  eval set_attr $hcell_inst origin {$org}

  set idx [expr $idx +1]
}




