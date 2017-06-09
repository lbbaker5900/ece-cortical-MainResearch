
set libList [glob ../synth/dw_memories/compout/views/*/tt1p2v25c/*.lib]
foreach libFile $libList {
  set lName [file tail [file rootname $libFile]]
  echo "Adding device to mw lib : " $lName
  read_lef -lib_name dw_memories -tech_lef_files  /local/home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/lef/5.6/cp65npksdst_m07f0f1.lef  -cell_lef_files  /local/home/lbbaker/Cortical/ece-cortical-MainResearch/3DSystem/Manager/HDL/run_s/manager/synth/dw_memories/compout/views/${lName}/${lName}.plef
}

#read_lef -lib_name dw_memories -tech_lef_files  /local/home/GF065/synopsys/DesignWare_logic_libs/cp65npksdst4.00a/lef/5.6/cp65npksdst_m07f0f1.lef  -cell_lef_files  /local/home/lbbaker/Cortical/ece-cortical-MainResearch/3DSystem/Manager/HDL/run_s/manager/synth/dw_memories/compout/views/sasslnpky1p4096x57cm8sw0ltlc1/sasslnpky1p4096x57cm8sw0ltlc1.plef
exit


