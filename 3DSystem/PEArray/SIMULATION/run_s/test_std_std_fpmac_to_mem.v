
  begin
    repeat(10) @(negedge clk);

    `include "test_simd_init.vh"
    `include "test_std_idle.vh"


    repeat(10) @(negedge clk);
    reset_poweron = 0;

    repeat(10) @(negedge clk);

    //----------------------------------------
    // 1)
    // Setup two vectors by streaming from external memory
    // To the same bank
    // Type = byte
    // Stream 0 start address
    `include "test_std_init.vh"

    // we sent in 20 32-bit word, so vector is 640-bits long
    numOfTypes = 20;
    numOfExtWords = numOfTypes;
    numOfResidueTypes = 0;
    $display("%t: Number of external words  : %d\n", $time, numOfExtWords);
    $display("%t: Number of bits in final word  : %d\n", $time, numOfResidueTypes);


    `include "test_std_std_fpmac_to_mem_init_step1.vh"
    `include "test_std_std_fpmac_to_mem_generate_stimulus_step1.vh"
    `include "test_std_idle.vh"


//        $display("\n%t: Cumulative result : %d of %d, %d\n", $time, fp_mac_expected_result, $bitstoshortreal(strm0[i0]), $bitstoshortreal(strm1[i0]));
//
    $display("%t: Generated expected FP MAC TO MEM result : %d\n", $time, fp_mac_expected_result);

    $display("%t: Start downstream stimulus\n", $time);
    begin
      fork
        //test_downstream_stimulus();  // doesnt seem to work??
        `include "test_std_stimulus.vh"
      join
    end
    `include "test_std_idle.vh"
    $display("%t: Completed stimulus\n", $time);


    wait (~pe_array_inst.pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);
    wait (pe_array_inst.pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);

    `include "test_simd_init.vh"

    repeat(10) @(negedge clk);
    wait (~pe_array_inst.pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(50) @(negedge clk);


/*

    //----------------------------------------
    // 2) Now copy a vector to a different location
    // Same bank
    // Type = bit
    // all data filled with types
    // Stream 0 start address
     lane0_r130 = 32'h0000_0010;
     lane1_r130 = 32'h0000_1010;
     lane2_r130 = 32'h0000_2010;
     lane3_r130 = 32'h0000_3010;
     lane4_r130 = 32'h0000_4010;
     lane5_r130 = 32'h0000_5010;
     lane6_r130 = 32'h0000_6010;
     lane7_r130 = 32'h0000_7010;
     lane8_r130 = 32'h0000_8010;
     lane9_r130 = 32'h0000_9010;
    lane10_r130 = 32'h0000_a010;
    lane11_r130 = 32'h0000_b010;
    lane12_r130 = 32'h0000_c010;
    lane13_r130 = 32'h0000_d010;
    lane14_r130 = 32'h0000_e010;
    lane15_r130 = 32'h0000_f010;
    // Stream 0 location address
     lane0_r134 = 32'h0000_0500;
     lane1_r134 = 32'h0000_1500;
     lane2_r134 = 32'h0000_2500;
     lane3_r134 = 32'h0000_3500;
     lane4_r134 = 32'h0000_4500;
     lane5_r134 = 32'h0000_5500;
     lane6_r134 = 32'h0000_6500;
     lane7_r134 = 32'h0000_7500;
     lane8_r134 = 32'h0000_8500;
     lane9_r134 = 32'h0000_9500;
    lane10_r134 = 32'h0000_a500;
    lane11_r134 = 32'h0000_b500;
    lane12_r134 = 32'h0000_c500;
    lane13_r134 = 32'h0000_d500;
    lane14_r134 = 32'h0000_e500;
    lane15_r134 = 32'h0000_f500;
    repeat(10) @(negedge clk);
     rs0[0]    = 1'b1;
     rs0[15:1] = `STREAMING_OP_CNTL_OPERATION_NOP_FROM_MEM_TO_MEM ;
    repeat(10) @(negedge clk);
//32'b0000_0000_0000_0000_0000_0000_0000_0001;
    repeat(10) @(negedge clk);
    repeat(10) @(negedge clk);
    wait (~pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);
    wait (pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);
     rs0 = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
    repeat(10) @(negedge clk);
    wait (~pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(50) @(negedge clk);


    //----------------------------------------
    // 3) Now stream vectors to FP_MAC function
    // Same bank
    // Type = bit
    // all data filled with types
    // Stream 0 start address
     lane0_r130 = 32'h0000_0500;
     lane1_r130 = 32'h0000_1500;
     lane2_r130 = 32'h0000_2500;
     lane3_r130 = 32'h0000_3500;
     lane4_r130 = 32'h0000_4500;
     lane5_r130 = 32'h0000_5500;
     lane6_r130 = 32'h0000_6500;
     lane7_r130 = 32'h0000_7500;
     lane8_r130 = 32'h0000_8500;
     lane9_r130 = 32'h0000_9500;
    lane10_r130 = 32'h0000_a500;
    lane11_r130 = 32'h0000_b500;
    lane12_r130 = 32'h0000_c500;
    lane13_r130 = 32'h0000_d500;
    lane14_r130 = 32'h0000_e500;
    lane15_r130 = 32'h0000_f500;
    // Stream 1 start address
     lane0_r131 = 32'h0000_0800;
     lane1_r131 = 32'h0000_1800;
     lane2_r131 = 32'h0000_2800;
     lane3_r131 = 32'h0000_3800;
     lane4_r131 = 32'h0000_4800;
     lane5_r131 = 32'h0000_5800;
     lane6_r131 = 32'h0000_6800;
     lane7_r131 = 32'h0000_7800;
     lane8_r131 = 32'h0000_8800;
     lane9_r131 = 32'h0000_9800;
    lane10_r131 = 32'h0000_a800;
    lane11_r131 = 32'h0000_b800;
    lane12_r131 = 32'h0000_c800;
    lane13_r131 = 32'h0000_d800;
    lane14_r131 = 32'h0000_e800;
    lane15_r131 = 32'h0000_f800;
    // Stream Result address
     lane0_r134 = 32'h0000_0400;
     lane1_r134 = 32'h0001_0400;
     lane2_r134 = 32'h0002_0400;
     lane3_r134 = 32'h0003_0400;
     lane4_r134 = 32'h0004_0400;
     lane5_r134 = 32'h0005_0400;
     lane6_r134 = 32'h0006_0400;
     lane7_r134 = 32'h0007_0400;
     lane8_r134 = 32'h0008_0400;
     lane9_r134 = 32'h0009_0400;
    lane10_r134 = 32'h000a_0400;
    lane11_r134 = 32'h000b_0400;
    lane12_r134 = 32'h000c_0400;
    lane13_r134 = 32'h000d_0400;
    lane14_r134 = 32'h000e_0400;
    lane15_r134 = 32'h000f_0400;
    repeat(10) @(negedge clk);
     rs0[0]    = 1'b1;
     rs0[15:1] = `STREAMING_OP_CNTL_OPERATION_FP_MAC_FROM_MEM_TO_MEM ;
    repeat(10) @(negedge clk);
//32'b0000_0000_0000_0000_0000_0000_0000_0001;
    repeat(10) @(negedge clk);
    repeat(10) @(negedge clk);
    wait (~pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);
    wait (pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);
     rs0 = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
    repeat(10) @(negedge clk);
    wait (~pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(50) @(negedge clk);

    // read result
    fork
      begin
        ldst__memc__read_address   = pe_inst[0].pe.lane0_r134; // FIXME
        // request access to memory
        ldst__memc__request   = 1'b1 ;
        wait (memc__ldst__granted);
        repeat(1) @(posedge clk);
        ldst__memc__read_valid  = 1'b1;
        repeat(1) @(posedge clk);
        ldst__memc__read_valid  = 1'b0;
        // Release access to memory
        repeat(1) @(posedge clk);
        ldst__memc__request   = 1'b0 ;
        repeat(5) @(posedge clk);
      end
      begin
        // check result
        while (~memc__ldst__read_data_valid)
          begin
            @(negedge clk);
          end
         fp_mac_got_result = $bitstoshortreal(memc__ldst__read_data);
          //if (fp_mac_got_result != fp_mac_expected_result)
          if (memc__ldst__read_data != $shortrealtobits(fp_mac_expected_result))
            begin
              $display("%t: #### MEM2MEM: ERROR #### : Expected %d got %d\n", $time, fp_mac_expected_result, fp_mac_got_result);
            end
          else
            begin
              $display("%t: #### MEM2MEM: GOOD #### : Expected %d got %d\n", $time, fp_mac_expected_result, fp_mac_got_result);
            end
      end
    join

*/
  
end
