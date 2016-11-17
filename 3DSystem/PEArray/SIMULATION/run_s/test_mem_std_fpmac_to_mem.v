
  begin
    repeat(10) @(negedge clk);

    `include "test_simd_init.vh"
    `include "test_std_idle.vh"


    repeat(10) @(negedge clk);
    reset_poweron = 0;

    repeat(10) @(negedge clk);

    //----------------------------------------
    // 1)
    // Setup a vectors in memory for one of the arguments
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


    `include "test_std_none_nop_to_mem_init_step1.vh"
    `include "test_std_none_nop_to_mem_generate_stimulus_step1.vh"
    `include "test_std_idle.vh"


//        $display("\n%t: Cumulative result : %d of %d, %d\n", $time, fp_mac_expected_result, $bitstoshortreal(strm0[i0]), $bitstoshortreal(strm1[i0]));
//
    $display("%t: Start downstream stimulus\n", $time);
    begin
      fork
        //test_downstream_stimulus();  // doesnt seem to work??
        `include "test_std_stimulus.vh"
      join
    end
    `include "test_std_idle.vh"

    wait (~pe_array_inst.pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);
    wait (pe_array_inst.pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);

    `include "test_simd_init.vh"

    repeat(10) @(negedge clk);
    wait (~pe_array_inst.pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(50) @(negedge clk);

    $display("%t: Completed step 1\n", $time);

    //----------------------------------------
    // 2)
    // Now perform a FP MAC on the streams from Stack stream1 and memory
    // stream 0
    `include "test_std_init.vh"

    // we sent in 20 32-bit word, so vector is 640-bits long
    numOfTypes = 20;
    numOfExtWords = numOfTypes;
    numOfResidueTypes = 0;
    $display("%t: Number of external words  : %d\n", $time, numOfExtWords);
    $display("%t: Number of bits in final word  : %d\n", $time, numOfResidueTypes);


    `include "test_mem_std_fpmac_to_mem_init_step2.vh"
    `include "test_mem_std_fpmac_to_mem_generate_stimulus_step2.vh"
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


    wait (~pe_array_inst.pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);
    wait (pe_array_inst.pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(10) @(negedge clk);

    `include "test_simd_init.vh"

    repeat(10) @(negedge clk);
    wait (~pe_array_inst.pe_inst[0].pe.streamingOps_cntl.complete);
    repeat(50) @(negedge clk);

    $display("%t: Completed stimulus\n", $time);

end
