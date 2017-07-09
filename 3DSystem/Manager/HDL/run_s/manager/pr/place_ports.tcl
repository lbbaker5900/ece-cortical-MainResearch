set d_area [get_attr [get_die_area] bbox]
set c_area [get_attr [get_core_area] bbox]

# 5um pitch
set dx 5
set dy 5
set lx 0.1
set ly 0.1

#------------------------------------------------------------------------------------------------------------------------------------------------------
# Stack Down Interface

set lane_down [get_terminals -quiet -filter "name =~ mgr__std__*"]
set lane_down [add_to_collection $lane_down [get_terminals -quiet -filter "name =~ std__mgr__*ready*"] ]

set oob_down [get_terminals -quiet -filter "name =~ mgr__std__oob*"]
set oob_down [add_to_collection $oob_down [get_terminals -quiet -filter "name =~ std__mgr__oob*"] ]

set lane_down [remove_from_collection $lane_down $oob_down]

sort_collection $lane_down -descending {name }
sort_collection $oob_down  -descending {name }



set sx [expr [lindex [lindex $c_area 0] 0] +50]
set sy [expr [lindex [lindex $c_area 1] 1] -50]

set x $sx
set y $sy
set idx 0

foreach_in_collection tsv $lane_down {

  #set_attribute -quiet $tsv owner_port foobar
  #set_attribute -quiet $tsv layer M6
  set bbox [list [list [expr $x -$lx] [expr $y - $ly]] [list [expr $x + $lx] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

  if {$idx == 256} {
    set idx 0
    set rhs $x
    set x $sx
    set y [expr $y - $dy]

  }
}

set sx $rhs

set x [expr $sx +$dx]
set y $sy
set idx 0

foreach_in_collection tsv $oob_down {

  #set_attribute -quiet $tsv owner_port foobar
  #set_attribute -quiet $tsv layer M6
  set bbox [list [list [expr $x -$lx] [expr $y - $ly]] [list [expr $x + $lx] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

  if {$idx == 4} {
    set idx 0
    set rhs $x
    set x $sx
    set y [expr $y - $dy]

  }
}
#------------------------------------------------------------------------------------------------------------------------------------------------------
# Stack Up Interface

set data_up [get_terminals -quiet -filter "name =~ stu__mgr__*"]
set data_up [add_to_collection $data_up [get_terminals -quiet -filter "name =~ mgr__stu__*ready"] ]
sort_collection $data_up -descending {name }

set oob_up [get_terminals -quiet -filter "name =~ stu__mgr__oob*"]
set oob_up [add_to_collection $oob_up [get_terminals -quiet -filter "name =~ std__mgr__oob*"] ]
sort_collection $oob_up -descending {name }

set sx $rhs

set x [expr $sx +$dx]
set y $sy
set idx 0

foreach_in_collection tsv $oob_up {

  #set_attribute -quiet $tsv owner_port foobar
  #set_attribute -quiet $tsv layer M6
  set bbox [list [list [expr $x -$lx] [expr $y - $ly]] [list [expr $x + $lx] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

  if {$idx == 32} {
    set idx 0
    set rhs $x
    set x $sx
    set y [expr $y - $dy]

  }
}

set sx $rhs

set x [expr $sx +$dx]
set y $sy
set idx 0

foreach_in_collection tsv $data_up {

  #set_attribute -quiet $tsv owner_port foobar
  #set_attribute -quiet $tsv layer M6
  set bbox [list [list [expr $x -$lx] [expr $y - $ly]] [list [expr $x + $lx] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

  if {$idx == 32} {
    set idx 0
    set rhs $x
    set x $sx
    set y [expr $y - $dy]

  }
}

#------------------------------------------------------------------------------------------------------------------------------------------------------
# DRAM Interface

# from DRAM

set obj [sort_collection [get_terminals -quiet -filter "name =~ phy__dfi__*"] -descending {name }]

set sx [expr [lindex [lindex $c_area 0] 0] +50]
set sy [expr [lindex [lindex $c_area 0] 0] +50]

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
foreach_in_collection tsv $obj {

  #set_attribute -quiet $tsv owner_port foobar
  #set_attribute -quiet $tsv layer M6
  set bbox [list [list [expr $x -$lx] [expr $y - $ly]] [list [expr $x + $lx] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed


  set idx [expr $idx + 1]
  set x [expr $x + $dx]

  if {$idx == 256} {
    set idx 0
    set rhs $x
    set x $sx
    set y [expr $y + $dy]
  }
  set top $y
}

# to DRAM

set obj [sort_collection [get_terminals -quiet -filter "name =~ dfi__phy__*"] -descending {name }]

set sy [expr $top +$dy]


set x $sx
set y $sy
set idx 0

foreach_in_collection tsv $obj {

  #set_attribute -quiet $tsv owner_port foobar
  #set_attribute -quiet $tsv layer M6
  set bbox [list [list [expr $x -$lx] [expr $y - $ly]] [list [expr $x + $lx] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed
  #create_via -net [get_attr $tsv owner_net] -no_snap -type via_array -master via23 -col 1 -row 1 -at [list $x $y ]
  #create_via -net [get_attr $tsv owner_net] -no_snap -type via_array -master via23 -route_type pg_strap -col 2 -row 1 -x_pitch 4.16 -y_pitch 0.1  -at { 1630.84    80.82 }



  set idx [expr $idx + 1]
  set x [expr $x + $dx]

  if {$idx == 256} {
    set idx 0
    set x $sx
    set y [expr $y + $dy]
  }
}


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
set trx 1.8
set try 1.8
# top left  dx = 1.2
#           dy = 1.8
set tlx 1.2
set tly 1.8
# Bot left  dx = 1.2
#           dy = 1.2
set blx 1.2
set bly 1.2
# Bot right dx = 1.8
#           dy = 1.2
set brx 1.8
set bry 1.2
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
set sx [expr [ lindex [lindex $d_area 1] 0] -$trx]

set x $sx
set y $sy


sort_collection $to_noc_port0    -descending {name }
sort_collection $from_noc_port0  -descending {name }

foreach_in_collection tsv $to_noc_port0 {

  set bbox [list [list [expr $x -$lx] [expr $y - [expr $ly *2]]] [list [expr $x + $lx] [expr $y + 0]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x - $dx]

}

foreach_in_collection tsv $from_noc_port0 {

  set bbox [list [list [expr $x -$lx] [expr $y - [expr $ly *2]]] [list [expr $x + $lx] [expr $y + 0]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x - $dx]

}

foreach_in_collection tsv $mask_noc_port0 {

  set bbox [list [list [expr $x +[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x - $dx]

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


# put top right
set sy [expr [ lindex [lindex $d_area 1] 1] -$try ]
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
  set y [expr $y - $dy]

}

foreach_in_collection tsv $from_noc_port1 {

  set bbox [list [list [expr $x -[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y - $dy]

}
foreach_in_collection tsv $mask_noc_port1 {

  set bbox [list [list [expr $x +[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y - $dy]

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


# put top right
set sy [expr [ lindex [lindex $d_area 0] 1] +0   ]
set sx [expr [ lindex [lindex $d_area 0] 0] +$blx]

set x $sx
set y $sy


sort_collection $to_noc_port2    -descending {name }
sort_collection $from_noc_port2  -descending {name }

foreach_in_collection tsv $to_noc_port2 {

  set bbox [list [list [expr $x -$lx] [expr $y - 0]] [list [expr $x + $lx] [expr $y + [expr $ly *2]]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

}

foreach_in_collection tsv $from_noc_port2 {

  set bbox [list [list [expr $x -$lx] [expr $y - 0]] [list [expr $x + $lx] [expr $y + [expr $ly *2]]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

}

foreach_in_collection tsv $mask_noc_port2 {

  set bbox [list [list [expr $x +[expr $lx *2]] [expr $y - $ly ]] [list [expr $x + 0] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set x [expr $x + $dx]

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


# put top right
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

