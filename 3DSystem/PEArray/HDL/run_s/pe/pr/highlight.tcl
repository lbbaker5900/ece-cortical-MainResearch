#
#
# To highlight all hard_macros
# Settings - Cells - Color cells by attribute - Off
# then change color
gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting showCellColorAttr -value false
# 

change_selection [get_cells -hier -regexp -filter "full_name =~ pe_cntl.*"]
gui_set_highlight_options -current_color red
gui_change_highlight -add -collection global

change_selection [get_cells -hier -regexp -filter "full_name =~ streamingOps_cntl.*"]
gui_set_highlight_options -current_color blue
gui_change_highlight -add -collection global

change_selection [get_cells -hier -regexp -filter "full_name =~ stOp_lane_.*__streamingOps_datapath/dma_cont/.*"]
gui_set_highlight_options -current_color yellow
gui_change_highlight -add -collection global

change_selection [get_cells -hier -regexp -filter "full_name =~ stOp_lane_.*__streamingOps_datapath/streamingOps/.*"]
gui_set_highlight_options -current_color light_purple
gui_change_highlight -add -collection global

change_selection [get_cells -hier -regexp -filter "full_name =~ mem_acc_cont.*"]
gui_set_highlight_options -current_color green
gui_change_highlight -add -collection global

change_selection  [get_cells -hier -filter "ref_name =~ asdr* || ref_name =~ sass*"]
gui_set_highlight_options -current_color orange
gui_change_highlight -add -collection global


