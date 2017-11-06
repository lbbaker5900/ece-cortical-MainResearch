#*********************************************************************************************
#
#    File name   : run_place_macros.tcl
#    Author      : Lee Baker
#    Affiliation : North Carolina State University, Raleigh, NC
#    Date        : Apr 2017
#    email       : lbbaker@ncsu.edu
#
#    Description : 
#
#    leveraged from file supplied by: 
#    Dr. Rhett Davis, North Carolina State University, Raleigh, NC, email: wdavis@ncsu.edu
#    joshua Schabel, North Carolina State University, Raleigh, NC, email: jcledfo3@ncsu.edu
#
#*********************************************************************************************

set begintime [clock seconds]

source setup.tcl

open_mw_lib ./work/${modname}
open_mw_cel ${modname}_init

source ${modname}_constraints.tcl
source constraints.tcl


if {$modname == "pe" || $modname == "manager"} {

  source place_ports.tcl

  if {$USE_CREATE_FP_PLACEMENT =="true"} {

    set_fp_placement_strategy \
      -min_distance_between_macros ${MIN_DISTANCE_BETWEEN_MACROS} \
      -sliver_size ${SLIVER_DISTANCE_BETWEEN_MACROS} \
      -auto_grouping high \
      -macros_on_edge off

    create_fp_placement

  } else {

    source place_macros.tcl

  }
} else {

  set_fp_placement_strategy \
    -min_distance_between_macros ${MIN_DISTANCE_BETWEEN_MACROS} \
    -sliver_size ${SLIVER_DISTANCE_BETWEEN_MACROS} \
    -auto_grouping high \
    -macros_on_edge off

  create_fp_placement

}

save_mw_cel -as ${modname}_init_macros_placed

set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_place_macros.tcl completed successfully (elapsed time: $timestr actual)"
exit
