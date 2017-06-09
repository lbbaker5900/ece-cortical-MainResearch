source setup.tcl
set begintime [clock seconds]
open_mw_lib ./work
open_mw_cel ${modname}_placed

 

 check_tlu_plus_files
 
 source -echo floorplan.tcl
 
 source -echo place.tcl
 
 source -echo powerplan.tcl
 
 source -echo clocksynth.tcl
 
 source -echo filler.tcl
 
 source -echo zrt_route_only.tcl
 
 source -echo streamout.tcl
 
save_mw_cel
close_mw_cel
close_mw_lib

exit

