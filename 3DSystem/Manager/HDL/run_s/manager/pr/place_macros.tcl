
####    # move_objects -delta {630.590 -1434.220} [get_selection]
####    # move_objects -delta {-354.295 322.200} [get_selection]
####    # move_objects -delta {-178.775 41.400} [get_selection]
####    # move_objects -delta {182.025 -198.000} [get_selection]
####    
####    get_cells -hier -filter "full_name =~ main_mem_cntl/from_dfi_fifo* && ref_name =~ asdr*"
####    #foreach_in_collection hcell [get_cells -hier -filter "full_name =~ main_mem_cntl/from_dfi_fifo* && ref_name =~ asdr*"] {
####    #
####    #
set dx [expr 604.980+30]
set dy [expr 51.055+30]
set x 50
set y 50 
set llx [expr $x]
set lly [expr $y]
change_selection [get_cells -hier -filter "full_name =~ main_mem_cntl/from_dfi_fifo* && ref_name =~ asdr*"]
foreach_in_collection hcell [get_selection] {
#  set_attr $hcell_inst is_placed false
  set hcell_inst [get_attr $hcell full_name] 
  puts $hcell
  puts $hcell_inst
  puts [get_attr $hcell origin]
  puts [get_attr $hcell_inst origin]
  set org "$llx $lly"
  #eval set_attr $hcell origin {$org}
  eval set_attr $hcell_inst origin {$org}
  puts [get_attr $hcell origin]
  puts [get_attr $hcell_inst origin]
  set lly [expr $lly + $dy]
  puts $llx 
  puts $lly
}
####    
####    
####    set x [expr $x + $dx]
####    #set y [expr $y + $dy]
####    set llx [expr $x]
####    set lly [expr $y]
####    change_selection [get_cells -hier -regexp -filter "full_name =~ mem_acc_cont.*bank_mem_\[8-9\]__.*gmemory/genblk.*_mem1p.* || full_name =~ mem_acc_cont.*bank_mem_1\[0-5\]__.*gmemory/genblk.*_mem1p.*"]
####    foreach_in_collection hcell [get_selection] {
####    #  set_attr $hcell_inst is_placed false
####      set hcell_inst [get_attr $hcell full_name] 
####      puts $hcell
####      puts $hcell_inst
####      puts [get_attr $hcell origin]
####      puts [get_attr $hcell_inst origin]
####      set org "$llx $lly"
####      #eval set_attr $hcell origin {$org}
####      eval set_attr $hcell_inst origin {$org}
####      puts [get_attr $hcell origin]
####      puts [get_attr $hcell_inst origin]
####      set lly [expr $lly + $dy]
####      puts $llx 
####      puts $lly
####    }
####    
####    
####    set x [expr $x + $dx]
####    #set y [expr $y + $dy]
####    set llx [expr $x]
####    set lly [expr $y]
####    change_selection [get_cells -hier -regexp -filter "full_name =~ mem_acc_cont.*bank_mem_1\[6-9\]__.*gmemory/genblk.*_mem1p.* || full_name =~ mem_acc_cont.*bank_mem_2\[0-3\]__.*gmemory/genblk.*_mem1p.*"]
####    foreach_in_collection hcell [get_selection] {
####    #  set_attr $hcell_inst is_placed false
####      set hcell_inst [get_attr $hcell full_name] 
####      puts $hcell
####      puts $hcell_inst
####      puts [get_attr $hcell origin]
####      puts [get_attr $hcell_inst origin]
####      set org "$llx $lly"
####      #eval set_attr $hcell origin {$org}
####      eval set_attr $hcell_inst origin {$org}
####      puts [get_attr $hcell origin]
####      puts [get_attr $hcell_inst origin]
####      set lly [expr $lly + $dy]
####      puts $llx 
####      puts $lly
####    }
####    
####    
####    set x [expr $x + $dx]
####    #set y [expr $y + $dy]
####    set llx [expr $x]
####    set lly [expr $y]
####    change_selection [get_cells -hier -regexp -filter "full_name =~ mem_acc_cont.*bank_mem_2\[4-9\]__.*gmemory/genblk.*_mem1p.* || full_name =~ mem_acc_cont.*bank_mem_3\[0-1\]__.*gmemory/genblk.*_mem1p.*"]
####    foreach_in_collection hcell [get_selection] {
####    #  set_attr $hcell_inst is_placed false
####      set hcell_inst [get_attr $hcell full_name] 
####      puts $hcell
####      puts $hcell_inst
####      puts [get_attr $hcell origin]
####      puts [get_attr $hcell_inst origin]
####      set org "$llx $lly"
####      #eval set_attr $hcell origin {$org}
####      eval set_attr $hcell_inst origin {$org}
####      puts [get_attr $hcell origin]
####      puts [get_attr $hcell_inst origin]
####      set lly [expr $lly + $dy]
####      puts $llx 
####      puts $lly
####    }
####    
####    
####    
####    
####    #set_attr $hcell_inst origin {$llx $lly}
####    #  change_selection $hcell
####    #  move_objects -ignore_fixed -x $llx -y $lly [get_selection]
####      #move_objects $hcell -x 500 -y 500
####    #set hcell [get_cells -hier -filter "full_name =~ mem_acc_cont/bank_mem*gmemory/genblk*_mem1p*"]
####    #set_attr $hcell origin {500 500}
####    
####    #   set mName [get_attribute ${macro} full_name]
####    #   set mType [get_attribute ${mName} ref_name]
####    #   set mBbox [lindex [get_attribute ${mName} bbox] 0]
####    #   set mOrient [get_attribute ${mName} orientation]
####    #   set_attribute -quiet $hcell origin {50 50}
####    # # Copy termical size from PLL BCK termical (12x12)
####    # set port [get_port LPLL_BCK0_P]
####    # set pname [get_attr $port name];
####    # set term [get_attr [get_terminal $pname] name];
####    # set layer [get_attr [get_terminal $pname] layer];
####    # set dtype 2;
####    # 
####    # set lx [get_attr [get_terminal $term] bbox_llx];
####    # set ly [get_attr [get_terminal $term] bbox_lly];
####    # set ux [get_attr [get_terminal $term] bbox_urx];
####    # set uy [get_attr [get_terminal $term] bbox_ury];
####    # 
####    # set cx [expr $lx + [expr ($ux-$lx)/2]];
####    # set cy [expr $ly + [expr ($uy-$ly)/2]];
####    # set dx [expr $ux-$lx];
####    # set dy [expr $uy-$ly];
####    # 
####    # # Now change terminal layer to tm1 (from c4b) and terminal bbox size
####    # 
####    # set listCMLPorts [get_ports {LS_TX_REFCLK3_ILK_REFCLK_P LS_TX_REFCLK3_ILK_REFCLK_N LS_TX_REFCLK2_P LS_TX_REFCLK2_N LS_TX_REFCLK1_P LS_TX_REFCLK1_N LS_TX_REFCLK0_P LS_TX_REFCLK0_N LS_RX_REFCLK_P LS_RX_REFCLK_N }]
####    # foreach_in_collection port $listCMLPorts {
####    #     set pname [get_attr $port name]; 
####    #     set term [get_attr [get_terminal $pname] name];
####    #     set_attribute [get_terminal $term] layer tm1
####    #     set lx [get_attr [get_terminal $term] bbox_llx];
####    #     set ly [get_attr [get_terminal $term] bbox_lly];
####    #     set ux [get_attr [get_terminal $term] bbox_urx];
####    #     set uy [get_attr [get_terminal $term] bbox_ury];
####    #     set cx [expr $lx + [expr ($ux-$lx)/2]];
####    #     set cy [expr $ly + [expr ($uy-$ly)/2]];
####    #     set lx [expr $cx - [expr $dx/2]];
####    #     set ly [expr $cy - [expr $dy/2]];
####    #     set ux [expr $cx + [expr $dx/2]];
####    #     set uy [expr $cy + [expr $dy/2]];
####    #     set_attr [get_terminal $term] bbox_llx $lx;
####    #     set_attr [get_terminal $term] bbox_lly $ly;
####    #     set_attr [get_terminal $term] bbox_urx $ux;
####    #     set_attr [get_terminal $term] bbox_ury $uy;
####    # }
####    
####    
####    
