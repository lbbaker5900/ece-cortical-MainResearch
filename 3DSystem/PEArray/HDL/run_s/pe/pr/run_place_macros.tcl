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

# Allocate area for SIMD
# 720 sq-um based on info from Josh (850 on a side)
create_placement_blockage -coordinate {{750.0 700.0} {1600.0 1550.0}} -name placement_blockage_simd -type hard
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage } -bbox {{750.0 700.0} {1600.0 1550.0}}
# remove_routing_blockage *
# remove_placement_blockage -all


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
