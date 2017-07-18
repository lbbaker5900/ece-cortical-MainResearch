set d_area [get_attr [get_die_area] bbox]
set c_area [get_attr [get_core_area] bbox]

# 5um pitch
set dx 5
set dy 5
set lx 0.1
set ly 0.1

#------------------------------------------------------------------------------------------------------------------------------------------------------
# Stack Down Interface

set lane_down [get_terminals -quiet -filter "name =~ std__pe__*"]
set lane_down [add_to_collection $lane_down [get_terminals -quiet -filter "name =~ pe__std__*ready*"] ]

set oob_down [get_terminals -quiet -filter "name =~ std_-pe__oob*"]
set oob_down [add_to_collection $oob_down [get_terminals -quiet -filter "name =~ pe__std__oob*"] ]

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

set data_up [get_terminals -quiet -filter "name =~ pe__stu__*"]
set data_up [add_to_collection $data_up [get_terminals -quiet -filter "name =~ stu__pe__*ready"] ]
sort_collection $data_up -descending {name }

set oob_up [get_terminals -quiet -filter "name =~ pe__stu__oob*"]
set oob_up [add_to_collection $oob_up [get_terminals -quiet -filter "name =~ pe__std__oob*"] ]
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


#--------------------------------------------------
# General
#
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

set gen [get_terminals -quiet -filter "name =~ *sys__pe__peId*"]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ pe__sys__ready"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ pe__sys__complete"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ pe__sys__thisSynchronized"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ sys__pe__allSynchronized"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ clk"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ reset_poweron"] ]


# put top left down
set sy [expr [ lindex [lindex $d_area 1] 1] -$tly ]
set sx [expr [ lindex [lindex $d_area 0] 0] +0    ]

set x $sx
set y $sy


sort_collection $gen    -descending {name }

foreach_in_collection tsv $gen {

  set bbox [list [list [expr $x +0] [expr $y - $ly ]] [list [expr $x + [expr $lx *2]] [expr $y + $ly]]]
  set_attribute -quiet $tsv bbox $bbox
  set_attribute -quiet $tsv status Fixed

  set idx [expr $idx + 1]
  set y [expr $y - $dy]

}

