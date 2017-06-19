
    0 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   <= {{`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 3] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 3],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 2] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 2],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 1] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 1],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 0] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 0]}; 
      end 
    1 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   <= {{`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 7] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 7],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 6] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 6],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 5] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 5],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 4] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 4]}; 
      end 
    2 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   <= {{`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[11] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[11],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[10] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[10],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 9] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 9],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[ 8] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[ 8]}; 
      end 
    3 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   <= {{`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[15] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[15],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[14] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[14],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[13] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[13],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[12] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[12]}; 
      end 
    4 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   <= {{`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[19] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[19],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[18] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[18],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[17] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[17],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[16] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[16]}; 
      end 
    5 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   <= {{`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[23] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[23],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[22] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[22],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[21] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[21],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[20] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[20]}; 
      end 
    6 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   <= {{`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[27] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[27],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[26] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[26],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[25] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[25],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[24] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[24]}; 
      end 
    7 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   <= {{`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[31] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[31],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[30] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[30],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[29] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[29],  
                                        {`PE_EXEC_LANE_WIDTH {(simd__sui__regs_cntl_d1[28] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & simd__sui__regs_d1[28]}; 
      end 