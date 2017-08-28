#
#
# To highlight all hard_macros
# Settings - Cells - Color cells by attribute - Off
# then change color
# 

change_selection [get_cells -hier -regexp -filter "full_name =~ mgr_noc_cntl.*"]
gui_set_highlight_options -current_color red
gui_change_highlight -add -collection global

change_selection [get_cells -hier -regexp -filter "full_name =~ main_mem_cntl.*"]
gui_set_highlight_options -current_color blue
gui_change_highlight -add -collection global

change_selection [get_cells -hier -regexp -filter "full_name =~ mrc_cntl.*"]
gui_set_highlight_options -current_color yellow
gui_change_highlight -add -collection global

change_selection [get_cells -hier -regexp -filter "full_name =~ wu_.*"]
gui_set_highlight_options -current_color green
gui_change_highlight -add -collection global


change_selection  [get_cells -hier -filter "ref_name =~ asdr* || ref_name =~ sass*"]
gui_set_highlight_options -current_color orange
gui_change_highlight -add -collection global


set dram  [get_port *dfi* ]
set dram  [add_to_collection $dram [get_port -quiet -filter "name =~ clk_diram_*cq*"] ]
set dram  [add_to_collection $dram [get_port -quiet -filter "name =~ clk_diram_*ck*"] ]
set std   [get_port *std* ]
set stu   [get_port *stu* ]
set other [get_ports *    ]
set other [remove_from_collection $other $dram]
set other [remove_from_collection $other $std ]
set other [remove_from_collection $other $stu ]

change_selection $other
gui_set_highlight_options -current_color light_purple
gui_change_highlight -add -collection global

change_selection $dram
gui_set_highlight_options -current_color light_red
gui_change_highlight -add -collection global

change_selection $std
gui_set_highlight_options -current_color light_blue
gui_change_highlight -add -collection global

change_selection $stu
gui_set_highlight_options -current_color light_green
gui_change_highlight -add -collection global

gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting colorCellHardMacro -value sandybrown
gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting hatchCellHardMacro -value SolidPattern
gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting hatchFillInst -value SolidPattern
gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting selectHighlightOnly -value true
gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting showCellColorAttr -value false

