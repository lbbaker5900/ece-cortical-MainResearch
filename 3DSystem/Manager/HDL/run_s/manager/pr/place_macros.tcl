
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

set g 20
set fg 50
set x 50
set y 50 

set dx [expr 0 + 0]
set dy [expr $refH + $g]

set llx [expr $x]
set lly [expr $y]

#
#
#### #change_selection [get_cells -hier -filter "full_name =~ main_mem_cntl/from_dfi_fifo* && ref_name =~ asdr*"]
#### #
#### set a [sort_collection [get_cells -hier -filter "full_name =~ main_mem_cntl/from_dfi_fifo* && ref_name =~ asdr*"] -descending {full_name }]
#### 
#### set ref [index_collection $a 0]
#### set ref_inst [get_attr $ref full_name] 
#### set refH [get_attr $ref height]
#### set refW [get_attr $ref width]
#### 
#### set g 20
#### set fg 50
#### set x 50
#### set y 50 
#### 
#### set dx [expr 0 + 0]
#### set dy [expr $refH + $g]
#### 
#### set llx [expr $x]
#### set lly [expr $y]
#### 
#### foreach_in_collection hcell $a {
####   set hcell_inst [get_attr $hcell full_name] 
####   set org "$llx $lly"
####   #eval set_attr $hcell origin {$org}
####   eval set_attr $hcell_inst origin {$org}
####   puts $org
#### 
####   set lly [expr $lly + $dy]
#### }
#### 
#### set x [expr [expr $x + $refW] +$g]
#### set y 50 
#### puts "$x $y"
#### 
#### 
#------------------------------------------------------------------------------------------------------------------------------------------------------
# MRC Instance 0
#scan [get_attr [get_port $port] bbox] "{%f %f} {%f %f}" llx lly urx ury

set inst 0


set mrc_lly 475
set mrc_llx 100

foreach inst {0 1} {

    # main inout fifos
    set a [sort_collection [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_${inst}*/from_mmc_fifo* && ref_name =~ asdr*"] -descending {full_name }]
    
    set ref [index_collection $a 0]
    set ref_inst [get_attr $ref full_name] 
    set refH [get_attr $ref height]
    set refW [get_attr $ref width]
    
    # Start from LHS
    
    set x $mrc_llx
    set y $mrc_lly
    
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
      #puts $org
    
      set lly [expr $lly + $dy]
    }
    
    
    set mrc_ury $urx
    set mrc_urx $ury
    
    set strm0_fifo_top [expr $lly + 0]
    
    set y [expr $lly +0]
    
    set llx [expr $x]
    set lly [expr $y]
    
    # to strm fsm
    set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_${inst}*/addr_to_strm_fsm_fifo* && ref_name =~ asdr*"] 
    set hcell_inst [get_attr $hcell full_name] 
    set org "$llx $lly"
    eval set_attr $hcell_inst origin {$org}
    set urx [expr $llx + [get_attr $hcell width ]]
    set ury [expr $lly + [get_attr $hcell height]]
    
    set strm0_fn_rhs [expr $x + [get_attr $hcell width]]
    
    set y [expr [expr $lly + [get_attr $hcell height]] +$g]
    
    set llx [expr $x]
    set lly [expr $y]
    
    set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_${inst}*/consJump_to_strm_fsm_fifo* && ref_name =~ asdr*"] 
    set hcell_inst [get_attr $hcell full_name] 
    set org "$llx $lly"
    eval set_attr $hcell_inst origin {$org}
    set urx [expr $llx + [get_attr $hcell width ]]
    set ury [expr $lly + [get_attr $hcell height]]
    
    if {$strm0_fn_rhs< [get_attr $hcell width]} {
      set strm0_fn_rhs [expr $x + [get_attr $hcell width]]
    }
    set y [expr [expr $lly + [get_attr $hcell height]] +$g]
    
    set strm0_fn_top [expr $lly + [get_attr $hcell height]]
    
    # Storage Desc mem 
    
    set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_${inst}*/storageDesc_mem* && ref_name =~ sass*"] 
    set hcell_inst [get_attr $hcell full_name] 
    
    # place level with rhs of fifo or to the right of widest block to the left
    if {$strm0_fn_rhs > [expr $strm0_fifo_rhs - [get_attr $hcell width]]} {
      set x [expr $strm0_fn_rhs + $g]
    } else {
      set x [expr $strm0_fifo_rhs - [get_attr $hcell width]]
    }
    set y $strm0_fifo_top
    
    set llx [expr $x]
    set lly [expr $y]
    
    set org "$llx $lly"
    eval set_attr $hcell_inst origin {$org}
    set urx [expr $llx + [get_attr $hcell width ]]
    set ury [expr $lly + [get_attr $hcell height]]
    
    set mrc_urx $urx
    
    set y [expr $lly + [get_attr $hcell height]]
    set x $llx
    
    # from WUD
    set lly [expr [expr $y] + $g]
    set llx [expr [expr $x] +  0]
    
    set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_${inst}*/from_Wud_Fifo* && ref_name =~ asdr*"] 
    set hcell_inst [get_attr $hcell full_name] 
    set org "$llx $lly"
    eval set_attr $hcell_inst origin {$org}
    set urx [expr $llx + [get_attr $hcell width ]]
    set ury [expr $lly + [get_attr $hcell height]]
    
    set wud_llx $llx
    set wud_lly $lly
    set wud_ury $ury
    set wud_urx $urx
    
    if {$strm0_fn_rhs < [get_attr $hcell width]} {
      set strm0_fn_rhs [expr $x + [get_attr $hcell width]]
    }
    
    # response ID fifo
    set lly [expr [expr $wud_ury] + $g]
    set llx [expr [expr $wud_llx] +  0]
    
    set a [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_${inst}*/response_id_fifo* && ref_name =~ asdr*"] 
    foreach_in_collection hcell $a {
      set hcell_inst [get_attr $hcell full_name] 
      set org "$llx $lly"
      eval set_attr $hcell_inst origin {$org}
      set urx [expr $llx + [get_attr $hcell width ]]
      set ury [expr $lly + [get_attr $hcell height]]
    
      set lly [expr [expr $ury] + $g]
      set llx [expr [expr $llx] +  0]
    
    }
    
    
    # Storage Desc ConsJump mem 
    
    set hcell [get_cells -hier -filter "full_name =~ mrc_cntl_strm_inst_${inst}*/storageDescConsJump_mem* && ref_name =~ sass*"] 
    set hcell_inst [get_attr $hcell full_name] 
    
    set x [expr [expr $wud_llx + [get_attr $hcell width]] + $g]
    set y $wud_lly
    
    set llx [expr $x]
    set lly [expr $y + $g]
    
    set org "$llx $lly"
    eval set_attr $hcell_inst origin {$org}
    set urx [expr $llx + [get_attr $hcell width ]]
    set ury [expr $lly + [get_attr $hcell height]]
    
    set mrc_ury $ury
    
    set y [expr [expr $lly + [get_attr $hcell height]] +$g]
    set x [expr [expr $x + $refW] +$g]
    
    set mrc_llx [expr $mrc_urx + $g]

    #puts $mrc_llx
    #puts $mrc_lly
    #puts $mrc_urx
    #puts $mrc_ury

}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# STUC

set_attr [get_cells -hier -filter "full_name =~ stu_cntl/from_Stu_Fifo* && ref_name =~ asdr*"  ] origin "1375 2175"

#------------------------------------------------------------------------------------------------------------------------------------------------------
# RDP

set_attr [get_cells -hier -filter "full_name =~ rdp_cntl/from_WuDecode_Fifo* && ref_name =~ asdr*"       ] origin "1375 2095"
set_attr [get_cells -hier -filter "full_name =~ rdp_cntl/storagePtr_LocalFifo* && ref_name =~ asdr*"     ] origin "1375 2005"
set_attr [get_cells -hier -filter "full_name =~ rdp_cntl/storageDestAddr_LocalFifo* && ref_name =~ asdr*"] origin "1375 1945"
set_attr [get_cells -hier -filter "full_name =~ rdp_cntl/from_Stuc_Fifo* && ref_name =~ asdr*"           ] origin "1375 1850"

#------------------------------------------------------------------------------------------------------------------------------------------------------
# WU

set_attr [get_cells -hier -filter "full_name =~ wu_decode/from_WuMemory_Fifo* && ref_name =~ asdr*"] origin "1800 1825"
set_attr [get_cells -hier -filter "full_name =~ wu_memory/instruction_mem* && ref_name =~ sass*"   ] origin "1800 1900"

#------------------------------------------------------------------------------------------------------------------------------------------------------
# OOB Downstream

set_attr [get_cells -hier -filter "full_name =~ oob_downstream_cntl/from_WuDecoder_Fifo* && ref_name =~ asdr*"] origin "1550 2265"


#------------------------------------------------------------------------------------------------------------------------------------------------------
# MWC
#
#
set_attr [get_cells -hier -filter "full_name =~ mwc_cntl/input_intf_fifo_0* && ref_name =~ asdr*"                       ]  origin "1950 1425"
set_attr [get_cells -hier -filter "full_name =~ mwc_cntl/input_intf_fifo_1* && ref_name =~ asdr*"                       ]  origin "1950 1280"
set_attr [get_cells -hier -filter "full_name =~ mwc_cntl/sdp_request_cntl/storageDesc_mem_* && ref_name =~ sass*"       ]  origin "1870 1010"
set_attr [get_cells -hier -filter "full_name =~ mwc_cntl/sdp_request_cntl/storageDescConsJump_mem* && ref_name =~ sass*"]  origin "2021 810"

#------------------------------------------------------------------------------------------------------------------------------------------------------
# NoC 

# Input and Output ports

set fromNoC [sort_collection [get_cells -hier -filter "full_name =~ mgr_noc_cntl/Port_from_NoC* && ref_name =~ asdr*"] {full_name }]
set toNoC   [sort_collection [get_cells -hier -filter "full_name =~ mgr_noc_cntl/Port_to_NoC*   && ref_name =~ asdr*"] {full_name }]

set port_to_locations   {{75 2450} {1950 500} {1950 200} {75  200}}
set port_from_locations {{75 2300} {1950 350} {1950  50} {75   50}}

set ref [index_collection $fromNoC 0]
set ref_inst [get_attr $ref full_name] 
set refH [get_attr $ref height]
set refW [get_attr $ref width]

set idx 0
foreach_in_collection hcell $toNoC {
  set_attr $hcell origin [lindex $port_to_locations $idx]
  set idx [expr $idx +1]
}

set idx 0
foreach_in_collection hcell $fromNoC {
  set_attr $hcell origin [lindex $port_from_locations $idx]
  set idx [expr $idx +1]
}

# Local Port
set_attr [get_cells -hier -filter "full_name =~ mgr_noc_cntl/from_local_fifo_0* && ref_name =~ asdr*"] origin "1470 1650"
set_attr [get_cells -hier -filter "full_name =~ mgr_noc_cntl/from_local_fifo_1* && ref_name =~ asdr*"] origin "1470 1560"





