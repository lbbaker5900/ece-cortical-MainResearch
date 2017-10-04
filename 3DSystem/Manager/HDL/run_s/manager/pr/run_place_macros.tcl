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


source setup.tcl
set begintime [clock seconds]

open_mw_lib ./work/${modname}
open_mw_cel ${modname}_init

source place_macros.tcl
source place_ports.tcl

save_mw_cel -as ${modname}_init_macros_placed
puts "run_place_macros.tcl completed successfully (elapsed time: $timestr actual)"
exit
