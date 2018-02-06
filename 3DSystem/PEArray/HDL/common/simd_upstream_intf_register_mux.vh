
    0 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   = {{`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 3] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 3],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 2] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 2],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 1] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 1],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 0] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 0]}; 
          
        to_Stu_Fifo[0].write_data_lane_valid   = {send_regs_valid[ 3],  
                                                  send_regs_valid[ 2],  
                                                  send_regs_valid[ 1],  
                                                  send_regs_valid[ 0]}; 
          
        case(to_Stu_Fifo[0].write_data_lane_valid)  // synopsys parallel_case  
          4'b0000:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_ONLY           ;  
          4'b0001:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_ONE   ;  
          4'b0011:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_TWO   ;  
          4'b0111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_THREE ;  
          4'b1111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_FOUR  ;  
          
        endcase
          
      end 
    1 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   = {{`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 7] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 7],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 6] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 6],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 5] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 5],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 4] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 4]}; 
          
        to_Stu_Fifo[0].write_data_lane_valid   = {send_regs_valid[ 7],  
                                                  send_regs_valid[ 6],  
                                                  send_regs_valid[ 5],  
                                                  send_regs_valid[ 4]}; 
          
        case(to_Stu_Fifo[0].write_data_lane_valid)  // synopsys parallel_case  
          4'b0000:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_ONLY           ;  
          4'b0001:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_ONE   ;  
          4'b0011:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_TWO   ;  
          4'b0111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_THREE ;  
          4'b1111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_FOUR  ;  
          
        endcase
          
      end 
    2 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   = {{`PE_EXEC_LANE_WIDTH {(send_regs_cntl[11] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[11],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[10] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[10],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 9] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 9],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[ 8] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[ 8]}; 
          
        to_Stu_Fifo[0].write_data_lane_valid   = {send_regs_valid[11],  
                                                  send_regs_valid[10],  
                                                  send_regs_valid[ 9],  
                                                  send_regs_valid[ 8]}; 
          
        case(to_Stu_Fifo[0].write_data_lane_valid)  // synopsys parallel_case  
          4'b0000:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_ONLY           ;  
          4'b0001:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_ONE   ;  
          4'b0011:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_TWO   ;  
          4'b0111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_THREE ;  
          4'b1111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_FOUR  ;  
          
        endcase
          
      end 
    3 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   = {{`PE_EXEC_LANE_WIDTH {(send_regs_cntl[15] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[15],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[14] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[14],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[13] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[13],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[12] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[12]}; 
          
        to_Stu_Fifo[0].write_data_lane_valid   = {send_regs_valid[15],  
                                                  send_regs_valid[14],  
                                                  send_regs_valid[13],  
                                                  send_regs_valid[12]}; 
          
        case(to_Stu_Fifo[0].write_data_lane_valid)  // synopsys parallel_case  
          4'b0000:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_ONLY           ;  
          4'b0001:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_ONE   ;  
          4'b0011:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_TWO   ;  
          4'b0111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_THREE ;  
          4'b1111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_FOUR  ;  
          
        endcase
          
      end 
    4 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   = {{`PE_EXEC_LANE_WIDTH {(send_regs_cntl[19] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[19],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[18] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[18],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[17] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[17],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[16] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[16]}; 
          
        to_Stu_Fifo[0].write_data_lane_valid   = {send_regs_valid[19],  
                                                  send_regs_valid[18],  
                                                  send_regs_valid[17],  
                                                  send_regs_valid[16]}; 
          
        case(to_Stu_Fifo[0].write_data_lane_valid)  // synopsys parallel_case  
          4'b0000:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_ONLY           ;  
          4'b0001:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_ONE   ;  
          4'b0011:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_TWO   ;  
          4'b0111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_THREE ;  
          4'b1111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_FOUR  ;  
          
        endcase
          
      end 
    5 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   = {{`PE_EXEC_LANE_WIDTH {(send_regs_cntl[23] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[23],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[22] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[22],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[21] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[21],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[20] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[20]}; 
          
        to_Stu_Fifo[0].write_data_lane_valid   = {send_regs_valid[23],  
                                                  send_regs_valid[22],  
                                                  send_regs_valid[21],  
                                                  send_regs_valid[20]}; 
          
        case(to_Stu_Fifo[0].write_data_lane_valid)  // synopsys parallel_case  
          4'b0000:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_ONLY           ;  
          4'b0001:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_ONE   ;  
          4'b0011:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_TWO   ;  
          4'b0111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_THREE ;  
          4'b1111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_FOUR  ;  
          
        endcase
          
      end 
    6 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   = {{`PE_EXEC_LANE_WIDTH {(send_regs_cntl[27] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[27],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[26] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[26],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[25] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[25],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[24] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[24]}; 
          
        to_Stu_Fifo[0].write_data_lane_valid   = {send_regs_valid[27],  
                                                  send_regs_valid[26],  
                                                  send_regs_valid[25],  
                                                  send_regs_valid[24]}; 
          
        case(to_Stu_Fifo[0].write_data_lane_valid)  // synopsys parallel_case  
          4'b0000:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_ONLY           ;  
          4'b0001:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_ONE   ;  
          4'b0011:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_TWO   ;  
          4'b0111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_THREE ;  
          4'b1111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_FOUR  ;  
          
        endcase
          
      end 
    7 :
      begin
        // FIXME: Condition on cntl. Not really needed but right now dont ant dc_shell to strip as I suspect we need the cntl signals
        to_Stu_Fifo[0].write_data   = {{`PE_EXEC_LANE_WIDTH {(send_regs_cntl[31] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[31],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[30] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[30],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[29] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[29],  
                                       {`PE_EXEC_LANE_WIDTH {(send_regs_cntl[28] == `COMMON_STD_INTF_CNTL_SOM_EOM)}} & send_regs[28]}; 
          
        to_Stu_Fifo[0].write_data_lane_valid   = {send_regs_valid[31],  
                                                  send_regs_valid[30],  
                                                  send_regs_valid[29],  
                                                  send_regs_valid[28]}; 
          
        case(to_Stu_Fifo[0].write_data_lane_valid)  // synopsys parallel_case  
          4'b0000:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_ONLY           ;  
          4'b0001:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_ONE   ;  
          4'b0011:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_TWO   ;  
          4'b0111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_THREE ;  
          4'b1111:
            to_Stu_Fifo[0].write_type = STU_PACKET_TYPE_TAG_AND_DATA_FOUR  ;  
          
        endcase
          
      end 