
proc proc_pt {tsv} {
  global idx 
  global x 
  global y 
  global lx 
  global ly 
  global dx 
  global dy 
  global sx 
  global sy 
  global numRows

  set bbox [list [list [expr $x -$lx] [expr $y - $ly]] [list [expr $x + $lx] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y - $dy]

  if {$idx == $numRows} {
    set idx 0
    set y $sy
    set x [expr $x + $dx]

  }
}

proc proc_rt {tsv} {
  global idx 
  global x 
  global y 
  global lx 
  global ly 
  global dx 
  global dy 
  global sx 
  global sy 
  global numRows

  set idx 0
  set y $sy
  set x [expr $x + $dx]
}

#------------------------------------------------------------------------------------------------------------------------------------------------------
# Stack Down Interface
#------------------------------------------------------------------------------------------------------------------------------------------------------
set d_area [get_attr [get_die_area] bbox]
set c_area [get_attr [get_core_area] bbox]

# 5um pitch
set dx 10
set dy 10
set lx 0.1
set ly 0.1

set sx [expr [lindex [lindex $c_area 1] 0] /16]
set sy [expr [lindex [lindex $c_area 1] 1] -50]

set llx [expr $sx -0.5]
set lly [expr $sy -0.5]

set x $sx
set y $sy
set idx 0

set numCols 128
set numRows 16
set rhs [expr $sx + [expr $numCols * $dx]]
for {set lane 0} {$lane < 32} {incr lane} {
  for {set strm 0} {$strm < 2} {incr strm} {

    set tsv [get_terminals -quiet -filter "name =~ [format "mgr__std__lane%s_strm%s_data_valid" $lane $strm]"]
    #puts [get_attr $tsv name]
    proc_pt $tsv

    for {set cntl 0} {$cntl < 2} {incr cntl} {
      set tsv [get_terminals -quiet -filter "name =~ [format "mgr__std__lane%s_strm%s_cntl\[%s\]" $lane $strm $cntl]"]
      proc_pt $tsv
    }

    set tsv [get_terminals -quiet -filter "name =~ [format "std__mgr__lane%s_strm%s_ready" $lane $strm]"]
    proc_pt $tsv

    proc_rt $tsv

    for {set data 0} {$data < 32} {incr data} {
      set tsv [get_terminals -quiet -filter "name =~ [format "mgr__std__lane%s_strm%s_data\[%s\]" $lane $strm $data]"]
      proc_pt $tsv
    }

  }
}

set rhs $x

#create_placement_blockage -coordinate {{147.540 64.4} {778.5 395.6}} -name placement_blockage_std -type hard

#------------------------------------------------------------------------------------------------------------------------------------------------------
# OOB Down Interface

set oob_down [get_terminals -quiet -filter "name =~ mgr__std__oob*"]
set oob_down [add_to_collection $oob_down [get_terminals -quiet -filter "name =~ std__mgr__oob*"] ]

set sx [expr $rhs + [expr $dx * 2]]
#et sy [expr $y - [expr $dy * 5]]

set x $sx
set y $sy

set idx 0

set numCols 32
set numRows 16
set rhs [expr $sx + [expr $numCols * $dx]]


set tsv [get_terminals -quiet -filter "name =~ [format "mgr__std__oob_valid"]"]
#puts [get_attr $tsv name]
proc_pt $tsv

for {set cntl 0} {$cntl < 2} {incr cntl} {
  set tsv [get_terminals -quiet -filter "name =~ [format "mgr__std__oob_cntl\[%s\]" $cntl]"]
  proc_pt $tsv
}

set tsv [get_terminals -quiet -filter "name =~ [format "std__mgr__oob_ready"]"]
proc_pt $tsv

proc_rt $tsv

for {set data 0} {$data < 32} {incr data} {
  set tsv [get_terminals -quiet -filter "name =~ [format "mgr__std__oob_data\[%s\]" $data]"]
  proc_pt $tsv
}

set rhs $x


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Stack Up Interface

set data_up [get_terminals -quiet -filter "name =~ stu__mgr__*"]
set data_up [add_to_collection $data_up [get_terminals -quiet -filter "name =~ mgr__stu__*ready"] ]
sort_collection $data_up -descending {name }

set oob_up [get_terminals -quiet -filter "name =~ stu__mgr__oob*"]
sort_collection $oob_up -descending {name }

set data_up [remove_from_collection $data_up $oob_up]

set sx [expr $rhs + [expr $dx * 4]]

set numCols 32
set numRows 16
set rhs [expr $sx + [expr $numCols * $dx]]

set x $sx
set y $sy
set idx 0


set tsv [get_terminals -quiet -filter "name =~ [format "stu__mgr__valid"]"]
#puts [get_attr $tsv name]
proc_pt $tsv

for {set cntl 0} {$cntl < 2} {incr cntl} {
  set tsv [get_terminals -quiet -filter "name =~ [format "stu__mgr__cntl\[%s\]" $cntl]"]
  proc_pt $tsv
}

for {set type 0} {$type < 4} {incr type} {
  set tsv [get_terminals -quiet -filter "name =~ [format "stu__mgr__type\[%s\]" $type]"]
  proc_pt $tsv
}

set tsv [get_terminals -quiet -filter "name =~ [format "mgr__stu__ready"]"]
proc_pt $tsv

proc_rt $tsv

for {set data 0} {$data < 32} {incr data} {
  set tsv [get_terminals -quiet -filter "name =~ [format "stu__mgr__oob_data\[%s\]" $data]"]
  proc_pt $tsv
}

proc_rt $tsv

for {set data 0} {$data < 128} {incr data} {
  set tsv [get_terminals -quiet -filter "name =~ [format "stu__mgr__data\[%s\]" $data]"]
  proc_pt $tsv
}

set rhs $x

create_placement_blockage -coordinate {{146.04 2476.0} {2271.24 2631.1}} -name placement_blockage_stackBus -type hard

#------------------------------------------------------------------------------------------------------------------------------------------------------
# DRAM Interface

#--------------------------
# from DRAM

set obj [sort_collection [get_terminals -quiet -filter "name =~ phy__dfi__*"] -descending {name }]
set obj_c [remove_from_collection $obj [get_terminals -quiet -filter "name =~ phy__dfi__data*"]]
set obj_clk [add_to_collection $obj [get_terminals -quiet -filter "name =~ clk_diram_*cq*"] ]

set numObjs [sizeof_collection $obj]
#puts $numObjs

set numCols 128
set numRows 34

set sx [expr [lindex [lindex $c_area 1] 0] /16]
set sy [expr [expr [lindex [lindex $c_area 0] 1] +50] + [expr $numRows *$dy]]

set x $sx
set y $sy

set idx 0

# Use via34
# 2 tracks left
# center 4857.8 4857.4 
# M3 tracks vertical on 0.2
#
# 1471.2 1471
# M2 Horiziontal tracks on 0.2
#
set numWords [expr 2048 /32]
#set numWords 4
for {set word 0} {$word < $numWords} {incr word} {

  set tsv [get_terminals -quiet -filter "name =~ [format "clk_diram_cq\[%s\]" $word]"]
  proc_pt $tsv
  set tsv [get_terminals -quiet -filter "name =~ [format "phy__dfi__valid\[%s\]" $word]"]
  proc_pt $tsv

  #proc_rt $tsv

  for {set bit 0} {$bit < 32} {incr bit} {
    set tsv [get_terminals -quiet -filter "name =~ [format "phy__dfi__data\[%s\]" [expr [expr $word *32] +$bit]]"]
    proc_pt $tsv
  }
  
}

create_placement_blockage -coordinate {{146.04 62.9} {781.0 397.1}} -name placement_blockage_fromDram -type hard

#--------------------------
# to DRAM

set obj [sort_collection [get_terminals -quiet -filter "name =~ dfi__phy__*"] -descending {name }]
set obj_c [remove_from_collection $obj [get_terminals -quiet -filter "name =~ dfi__phy__data*"]]
set obj_clk [add_to_collection $obj [get_terminals -quiet -filter "name =~ clk_diram_*ck*"] ]

set numObjs [sizeof_collection $obj]
#puts $numObjs

set sx [expr [lindex [lindex $c_area 1] 0] *0.7]
set sy [expr [expr [lindex [lindex $c_area 0] 1] +50] + [expr $numRows *$dy]]

set x $sx
set y $sy

set idx 0


set tsv [get_terminals -quiet -filter "name =~ [format "clk_diram_cntl_ck" ]"]
proc_pt $tsv
set tsv [get_terminals -quiet -filter "name =~ [format "dfi__phy__cs" ]"]
proc_pt $tsv
for {set cmd 0} {$cmd < 2} {incr cmd} {
  set tsv [get_terminals -quiet -filter "name =~ [format "dfi__phy__cmd%s" $cmd]"]
  proc_pt $tsv
}
for {set bank 0} {$bank < 5} {incr bank} {
  set tsv [get_terminals -quiet -filter "name =~ [format "dfi__phy__bank\[%s\]" $bank]"]
  proc_pt $tsv
}
for {set addr 0} {$addr < 12} {incr addr} {
  set tsv [get_terminals -quiet -filter "name =~ [format "dfi__phy__addr\[%s\]" $addr]"]
  proc_pt $tsv
}

proc_rt $tsv

for {set word 0} {$word < $numWords} {incr word} {
  set tsv [get_terminals -quiet -filter "name =~ [format "clk_diram_data_ck\[%s\]" $word]"]
  proc_pt $tsv
  # For mask
  #set tsv [get_terminals -quiet -filter "name =~ [format "dfi__phy__mask\[%s\]" $word]"]
  proc_pt $tsv
  for {set bit 0} {$bit < 32} {incr bit} {
    set tsv [get_terminals -quiet -filter "name =~ [format "dfi__phy__data\[%s\]" [expr [expr $word *32] +$bit]]"]
    proc_pt $tsv
  }
}

create_placement_blockage -coordinate {{1657.04 62.9} {2301.24 397.1}} -name placement_blockage_toDram -type hard

#------------------------------------------------------------------------------------------------------------------------------------------------------
# NoC
#
set dx 1.2
set dy 1.2
set lx 0.05
set ly 0.05

# place on edge sx = 1.2, sy = 0
# top right dx = 1.8
#           dy = 1.8
set trx [expr 1.8 + [expr $dx * 200]]
set try [expr 1.8 + [expr $dy * 200]]
# top left  dx = 1.2
#           dy = 1.8
set tlx [expr 1.2 + [expr $dx * 200]]
set tly [expr 1.8 + [expr $dy * 200]]
# Bot left  dx = 1.2
#           dy = 1.2
set blx [expr 1.2 + [expr $dx * 200]]
set bly [expr 1.2 + [expr $dy * 200]]
# Bot right dx = 1.8
#           dy = 1.2
set brx [expr 1.8 + [expr $dx * 200]]
set bry [expr 1.2 + [expr $dy * 200]]
#
#
#--------------------------------------------------
# Port 0
#
#
# to NoC
#
set to_noc_port0 [get_terminals -quiet -filter "name =~ *mgr__noc__port0*"]
set to_noc_port0 [add_to_collection $to_noc_port0 [get_terminals -quiet -filter "name =~ noc__mgr__port0_fc"] ]
set to_noc_port0 [remove_from_collection $to_noc_port0 [get_terminals -quiet -filter "name =~ mgr__noc__port0_fc"] ]

# from NoC
set from_noc_port0 [get_terminals -quiet -filter "name =~ *noc__mgr__port0*"]
set from_noc_port0 [add_to_collection $from_noc_port0 [get_terminals -quiet -filter "name =~ mgr__noc__port0_fc"] ]
set from_noc_port0 [remove_from_collection $from_noc_port0 [get_terminals -quiet -filter "name =~ noc__mgr__port0_fc"] ]

# NoC Destination Mask
set mask_noc_port0 [get_terminals -quiet -filter "name =~ *sys__mgr__port0_destinationMask*"]


# put top right
set sy [expr [ lindex [lindex $d_area 1] 1] +0   ]
set sx [expr [ lindex [lindex $d_area 0] 0] +$tlx]

set x $sx
set y $sy


sort_collection $to_noc_port0    -descending {name }
sort_collection $from_noc_port0  -descending {name }

foreach_in_collection tsv $to_noc_port0 {

  set bbox [list [list [expr $x -$lx] [expr $y - [expr $ly *2]]] [list [expr $x + $lx] [expr $y + 0]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

}

foreach_in_collection tsv $from_noc_port0 {

  set bbox [list [list [expr $x -$lx] [expr $y - [expr $ly *2]]] [list [expr $x + $lx] [expr $y + 0]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

}

foreach_in_collection tsv $mask_noc_port0 {

  set bbox [list [list [expr $x +[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

}

#--------------------------------------------------
# Port 1
#
#
# to NoC
#
set to_noc_port1 [get_terminals -quiet -filter "name =~ *mgr__noc__port1*"]
set to_noc_port1 [add_to_collection $to_noc_port1 [get_terminals -quiet -filter "name =~ noc__mgr__port1_fc"] ]
set to_noc_port1 [remove_from_collection $to_noc_port1 [get_terminals -quiet -filter "name =~ mgr__noc__port1_fc"] ]

# from NoC
set from_noc_port1 [get_terminals -quiet -filter "name =~ *noc__mgr__port1*"]
set from_noc_port1 [add_to_collection $from_noc_port1 [get_terminals -quiet -filter "name =~ mgr__noc__port1_fc"] ]
set from_noc_port1 [remove_from_collection $from_noc_port1 [get_terminals -quiet -filter "name =~ noc__mgr__port1_fc"] ]

# NoC Destination Mask
set mask_noc_port1 [get_terminals -quiet -filter "name =~ *sys__mgr__port1_destinationMask*"]


# put bottom right
set sy [expr [ lindex [lindex $d_area 0] 1] +$bry ]
set sx [expr [ lindex [lindex $d_area 1] 0] -0    ]

set x $sx
set y $sy


sort_collection $to_noc_port1    -descending {name }
sort_collection $from_noc_port1  -descending {name }

foreach_in_collection tsv $to_noc_port1 {

  set bbox [list [list [expr $x -[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y + $dy]

}

foreach_in_collection tsv $from_noc_port1 {

  set bbox [list [list [expr $x -[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y + $dy]

}
foreach_in_collection tsv $mask_noc_port1 {

  set bbox [list [list [expr $x +[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y + $dy]

}

#--------------------------------------------------
# Port 2
#
#
# to NoC
#
set to_noc_port2 [get_terminals -quiet -filter "name =~ *mgr__noc__port2*"]
set to_noc_port2 [add_to_collection $to_noc_port2 [get_terminals -quiet -filter "name =~ noc__mgr__port2_fc"] ]
set to_noc_port2 [remove_from_collection $to_noc_port2 [get_terminals -quiet -filter "name =~ mgr__noc__port2_fc"] ]

# from NoC
set from_noc_port2 [get_terminals -quiet -filter "name =~ *noc__mgr__port2*"]
set from_noc_port2 [add_to_collection $from_noc_port2 [get_terminals -quiet -filter "name =~ mgr__noc__port2_fc"] ]
set from_noc_port2 [remove_from_collection $from_noc_port2 [get_terminals -quiet -filter "name =~ noc__mgr__port2_fc"] ]

# NoC Destination Mask
set mask_noc_port2 [get_terminals -quiet -filter "name =~ *sys__mgr__port2_destinationMask*"]


# put bottom right 
set sy [expr [ lindex [lindex $d_area 0] 1] +0   ]
set sx [expr [ lindex [lindex $d_area 1] 0] -$brx]

set x $sx
set y $sy


sort_collection $to_noc_port2    -descending {name }
sort_collection $from_noc_port2  -descending {name }

foreach_in_collection tsv $to_noc_port2 {

  set bbox [list [list [expr $x -$lx] [expr $y - 0]] [list [expr $x + $lx] [expr $y + [expr $ly *2]]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x - $dx]

}

foreach_in_collection tsv $from_noc_port2 {

  set bbox [list [list [expr $x -$lx] [expr $y - 0]] [list [expr $x + $lx] [expr $y + [expr $ly *2]]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x - $dx]

}

foreach_in_collection tsv $mask_noc_port2 {

  set bbox [list [list [expr $x +[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x - $dx]

}

#--------------------------------------------------
# Port 3
#
#
# to NoC
#
set to_noc_port3 [get_terminals -quiet -filter "name =~ *mgr__noc__port3*"]
set to_noc_port3 [add_to_collection $to_noc_port3 [get_terminals -quiet -filter "name =~ noc__mgr__port3_fc"] ]
set to_noc_port3 [remove_from_collection $to_noc_port3 [get_terminals -quiet -filter "name =~ mgr__noc__port3_fc"] ]

# from NoC
set from_noc_port3 [get_terminals -quiet -filter "name =~ *noc__mgr__port3*"]
set from_noc_port3 [add_to_collection $from_noc_port3 [get_terminals -quiet -filter "name =~ mgr__noc__port3_fc"] ]
set from_noc_port3 [remove_from_collection $from_noc_port3 [get_terminals -quiet -filter "name =~ noc__mgr__port3_fc"] ]

# NoC Destination Mask
set mask_noc_port3 [get_terminals -quiet -filter "name =~ *sys__mgr__port3_destinationMask*"]


# put bottom left
set sy [expr [ lindex [lindex $d_area 0] 1] +$bly ]
set sx [expr [ lindex [lindex $d_area 0] 0] +0    ]

set x $sx
set y $sy


sort_collection $to_noc_port3    -descending {name }
sort_collection $from_noc_port3  -descending {name }

foreach_in_collection tsv $to_noc_port3 {

  set bbox [list [list [expr $x +[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y + $dy]

}

foreach_in_collection tsv $from_noc_port3 {

  set bbox [list [list [expr $x +[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y + $dy]

}

foreach_in_collection tsv $mask_noc_port3 {

  set bbox [list [list [expr $x +[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y + $dy]

}
#--------------------------------------------------
# General
#
#

set gen [get_terminals -quiet -filter "name =~ *sys__mgr__mgrId*"]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ sys__mgr__ready"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ sys__mgr__complete"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ sys__mgr__thisSynchronized"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ mgr__sys__allSynchronized"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ clk_diram"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ clk_diram2x"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ clk"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ reset_poweron"] ]


# put top right down
set sy [expr [ lindex [lindex $d_area 1] 1] -$tly ]
set sx [expr [ lindex [lindex $d_area 1] 0] +0    ]

set x $sx
set y $sy


sort_collection $gen    -descending {name }

foreach_in_collection tsv $gen {

  set bbox [list [list [expr $x +0] [expr $y - $ly ]] [list [expr $x - [expr $lx *2]] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y - $dy]

}


