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

    set tsv [get_terminals -quiet -filter "name =~ [format "std__pe__lane%s_strm%s_data_valid" $lane $strm]"]
    #puts [get_attr $tsv name]
    proc_pt $tsv

    for {set cntl 0} {$cntl < 2} {incr cntl} {
      set tsv [get_terminals -quiet -filter "name =~ [format "std__pe__lane%s_strm%s_cntl\[%s\]" $lane $strm $cntl]"]
      proc_pt $tsv
    }

    set tsv [get_terminals -quiet -filter "name =~ [format "pe__std__lane%s_strm%s_ready" $lane $strm]"]
    proc_pt $tsv

    proc_rt $tsv

    for {set data 0} {$data < 32} {incr data} {
      set tsv [get_terminals -quiet -filter "name =~ [format "std__pe__lane%s_strm%s_data\[%s\]" $lane $strm $data]"]
      proc_pt $tsv
    }

  }
}

set rhs $x

#------------------------------------------------------------------------------------------------------------------------------------------------------
# OOB Down Interface

set oob_down [get_terminals -quiet -filter "name =~ std__pe__oob*"]
set oob_down [add_to_collection $oob_down [get_terminals -quiet -filter "name =~ pe__std__oob*"] ]

set sx [expr $rhs + [expr $dx * 2]]
#et sy [expr $y - [expr $dy * 5]]

set x $sx
set y $sy

set idx 0

set numCols 32
set numRows 16
set rhs [expr $sx + [expr $numCols * $dx]]


set tsv [get_terminals -quiet -filter "name =~ [format "std__pe__oob_valid"]"]
#puts [get_attr $tsv name]
proc_pt $tsv

for {set cntl 0} {$cntl < 2} {incr cntl} {
  set tsv [get_terminals -quiet -filter "name =~ [format "std__pe__oob_cntl\[%s\]" $cntl]"]
  proc_pt $tsv
}

set tsv [get_terminals -quiet -filter "name =~ [format "pe__std__oob_ready"]"]
proc_pt $tsv

proc_rt $tsv

for {set data 0} {$data < 32} {incr data} {
  set tsv [get_terminals -quiet -filter "name =~ [format "std__pe__oob_data\[%s\]" $data]"]
  proc_pt $tsv
}

set rhs $x



#------------------------------------------------------------------------------------------------------------------------------------------------------
# Stack Up Interface

set data_up [get_terminals -quiet -filter "name =~ pe__stu__*"]
set data_up [add_to_collection $data_up [get_terminals -quiet -filter "name =~ stu__pe__*ready"] ]
sort_collection $data_up -descending {name }

set oob_up [get_terminals -quiet -filter "name =~ pe__stu__oob*"]
sort_collection $oob_up -descending {name }

set data_up [remove_from_collection $data_up $oob_up]

set sx [expr $rhs + [expr $dx * 4]]

set numCols 32
set numRows 16
set rhs [expr $sx + [expr $numCols * $dx]]

set x $sx
set y $sy
set idx 0


set tsv [get_terminals -quiet -filter "name =~ [format "pe__stu__valid"]"]
#puts [get_attr $tsv name]
proc_pt $tsv

for {set cntl 0} {$cntl < 2} {incr cntl} {
  set tsv [get_terminals -quiet -filter "name =~ [format "pe__stu__cntl\[%s\]" $cntl]"]
  proc_pt $tsv
}

for {set type 0} {$type < 4} {incr type} {
  set tsv [get_terminals -quiet -filter "name =~ [format "pe__stu__type\[%s\]" $type]"]
  proc_pt $tsv
}

set tsv [get_terminals -quiet -filter "name =~ [format "stu__pe__ready"]"]
proc_pt $tsv

proc_rt $tsv

for {set data 0} {$data < 32} {incr data} {
  set tsv [get_terminals -quiet -filter "name =~ [format "pe__stu__oob_data\[%s\]" $data]"]
  proc_pt $tsv
}

proc_rt $tsv

for {set data 0} {$data < 128} {incr data} {
  set tsv [get_terminals -quiet -filter "name =~ [format "pe__stu__data\[%s\]" $data]"]
  proc_pt $tsv
}

set rhs $x

create_placement_blockage -coordinate {{146.04 2476.0} {2271.24 2631.1}} -name placement_blockage_stackBus -type hard



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

set gen [get_terminals -quiet -filter "name =~ *sys__pe__peId*"]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ pe__sys__ready"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ pe__sys__complete"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ pe__sys__thisSynchronized"] ]
set gen [add_to_collection $gen [get_terminals -quiet -filter "name =~ sys__pe__allSynchronized"] ]
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


