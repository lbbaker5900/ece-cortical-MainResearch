
                  if (mgr == 0)
                    begin
                      $display ("@%0t::%s:%0d:: INFO: Loading Memories of gate level Manager {%0d}", $time, `__FILE__, `__LINE__, 0);
                      //----------------------------------------------------------------------------------------------------
                      // MRC 0 sdp_request_cntl
                      $readmemh( "./inputFiles/manager_0_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst_0__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_0_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst_0__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // MRC 1 sdp_request_cntl
                      $readmemh( "./inputFiles/manager_0_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst_1__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_0_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[0].manager.mrc_cntl_strm_inst_1__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // MWC sdp_request_cntl
                      $readmemh( "./inputFiles/manager_0_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[0].manager.mwc_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_0_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[0].manager.mwc_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // wu_memory
                      $readmemh( "./inputFiles/manager_0_layer1_instruction_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[0].manager.wu_memory.instruction_mem_0__gmemory.dw_mem_mem1p4096x57.u0.mem_core_array);
                    end
                  if (mgr == 1)
                    begin
                      $display ("@%0t::%s:%0d:: INFO: Loading Memories of gate level Manager {%0d}", $time, `__FILE__, `__LINE__, 1);
                      //----------------------------------------------------------------------------------------------------
                      // MRC 0 sdp_request_cntl
                      $readmemh( "./inputFiles/manager_1_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst_0__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_1_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst_0__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // MRC 1 sdp_request_cntl
                      $readmemh( "./inputFiles/manager_1_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst_1__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_1_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[1].manager.mrc_cntl_strm_inst_1__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // MWC sdp_request_cntl
                      $readmemh( "./inputFiles/manager_1_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[1].manager.mwc_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_1_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[1].manager.mwc_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // wu_memory
                      $readmemh( "./inputFiles/manager_1_layer1_instruction_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[1].manager.wu_memory.instruction_mem_0__gmemory.dw_mem_mem1p4096x57.u0.mem_core_array);
                    end
                  if (mgr == 2)
                    begin
                      $display ("@%0t::%s:%0d:: INFO: Loading Memories of gate level Manager {%0d}", $time, `__FILE__, `__LINE__, 2);
                      //----------------------------------------------------------------------------------------------------
                      // MRC 0 sdp_request_cntl
                      $readmemh( "./inputFiles/manager_2_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst_0__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_2_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst_0__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // MRC 1 sdp_request_cntl
                      $readmemh( "./inputFiles/manager_2_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst_1__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_2_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[2].manager.mrc_cntl_strm_inst_1__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // MWC sdp_request_cntl
                      $readmemh( "./inputFiles/manager_2_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[2].manager.mwc_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_2_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[2].manager.mwc_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // wu_memory
                      $readmemh( "./inputFiles/manager_2_layer1_instruction_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[2].manager.wu_memory.instruction_mem_0__gmemory.dw_mem_mem1p4096x57.u0.mem_core_array);
                    end
                  if (mgr == 3)
                    begin
                      $display ("@%0t::%s:%0d:: INFO: Loading Memories of gate level Manager {%0d}", $time, `__FILE__, `__LINE__, 3);
                      //----------------------------------------------------------------------------------------------------
                      // MRC 0 sdp_request_cntl
                      $readmemh( "./inputFiles/manager_3_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst_0__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_3_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst_0__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // MRC 1 sdp_request_cntl
                      $readmemh( "./inputFiles/manager_3_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst_1__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_3_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[3].manager.mrc_cntl_strm_inst_1__mrc_cntl.sdp_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // MWC sdp_request_cntl
                      $readmemh( "./inputFiles/manager_3_layer1_storageDescriptor_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[3].manager.mwc_cntl.sdp_request_cntl.storageDesc_mem_0__gmemory.dw_mem_mem1p2048x44.u0.mem_core_array);
                      $readmemh( "./inputFiles/manager_3_layer1_storageDescriptorConsJump_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[3].manager.mwc_cntl.sdp_request_cntl.storageDescConsJump_mem_0__gmemory.dw_mem_mem1p4096x21.u0.mem_core_array);
                      
                      //----------------------------------------------------------------------------------------------------
                      // wu_memory
                      $readmemh( "./inputFiles/manager_3_layer1_instruction_readmem.dat", top.system_inst.manager_array_inst.mgr_inst[3].manager.wu_memory.instruction_mem_0__gmemory.dw_mem_mem1p4096x57.u0.mem_core_array);
                    end