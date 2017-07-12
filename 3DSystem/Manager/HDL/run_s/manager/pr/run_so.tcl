#*********************************************************************************************
#
#    File name   : run_so.tcl
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
open_mw_cel ${modname}_routed

#------------------------------------------------------------------------------------------------------------------------------------------------------
# Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------

set_write_stream_options \
      -map_layer /home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/milkyway/tf/gds2.map \
      -output_filling fill \
      -child_depth 20 \
      -output_outdated_fill  \
      -output_pin  {text geometry}


write_stream -format gds -cells ${modname}_routed ${modname}_routed.gds

extract_rc

write_parasitics -output ${modname}_routed.spef

#write_verilog -pg -no_physical_only_cells xbar_wpg.v

report_timing

write_verilog -no_physical_only_cells ${modname}_routed.v

write_def -output ${modname}.def

save_mw_cel -as ${modname}_routed

write_sdc ${modname}_routed.sdc

report_timing -delay max -path_type full_clock -nworst 10

report_timing -delay min -path_type full_clock -nworst 10
#------------------------------------------------------------------------------------------------------------------------------------------------------
# end Josh
#------------------------------------------------------------------------------------------------------------------------------------------------------

set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_so.tcl completed successfully (elapsed time: $timestr actual)"
exit
