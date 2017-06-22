module pe_cntl ( sys__pe__peId, sti__cntl__oob_cntl, sti__cntl__oob_valid, 
        cntl__sti__oob_ready, sti__cntl__oob_type, sti__cntl__oob_data, 
        cntl__simd__tag_valid, cntl__simd__tag, simd__cntl__tag_ready, 
        cntl__simd__rs0, cntl__simd__rs1, cntl__simd__lane_r128, 
        cntl__simd__lane_r129, cntl__simd__lane_r130, cntl__simd__lane_r131, 
        cntl__simd__lane_r132, cntl__simd__lane_r133, cntl__simd__lane_r134, 
        cntl__simd__lane_r135, stOp_complete, clk, reset_poweron );
  input [5:0] sys__pe__peId;
  input [1:0] sti__cntl__oob_cntl;
  input [3:0] sti__cntl__oob_type;
  input [31:0] sti__cntl__oob_data;
  output [7:0] cntl__simd__tag;
  output [31:0] cntl__simd__rs0;
  output [31:0] cntl__simd__rs1;
  output [1023:0] cntl__simd__lane_r128;
  output [1023:0] cntl__simd__lane_r129;
  output [1023:0] cntl__simd__lane_r130;
  output [1023:0] cntl__simd__lane_r131;
  output [1023:0] cntl__simd__lane_r132;
  output [1023:0] cntl__simd__lane_r133;
  output [1023:0] cntl__simd__lane_r134;
  output [1023:0] cntl__simd__lane_r135;
  input sti__cntl__oob_valid, simd__cntl__tag_ready, stOp_complete, clk,
         reset_poweron;
  output cntl__sti__oob_ready, cntl__simd__tag_valid;
  wire   n_Logic0_, sti__cntl__oob_valid_d1, N578, simd__cntl__tag_ready_d1,
         N624, N639, N640, N641, N642, N643, cntl__simd__lane_r130_e1_23,
         cntl__simd__lane_r130_e1_22, cntl__simd__lane_r130_e1_21,
         cntl__simd__lane_r130_e1_20, cntl__simd__lane_r130_e1_19,
         cntl__simd__lane_r130_e1_18, cntl__simd__lane_r134_e1_23,
         cntl__simd__lane_r134_e1_22, cntl__simd__lane_r134_e1_21,
         cntl__simd__lane_r134_e1_20, cntl__simd__lane_r134_e1_19,
         cntl__simd__lane_r134_e1_18, cntl__simd__lane_r131_e1_23,
         cntl__simd__lane_r131_e1_22, cntl__simd__lane_r131_e1_21,
         cntl__simd__lane_r131_e1_20, cntl__simd__lane_r131_e1_19,
         cntl__simd__lane_r131_e1_18, cntl__simd__lane_r135_e1_23,
         cntl__simd__lane_r135_e1_22, cntl__simd__lane_r135_e1_21,
         cntl__simd__lane_r135_e1_20, cntl__simd__lane_r135_e1_19,
         cntl__simd__lane_r135_e1_18, N5054, from_Sti_OOB_Fifo_0__almost_full,
         from_Sti_OOB_Fifo_0__pipe_valid, from_Sti_OOB_Fifo_0__pipe_read,
         N5103, N5104, N5106, N5107, N5108, N5109, N5110, contained_stOp,
         N5231, N5246, N5247, N5248, N5249, N5250, N5251, N5252, N5253, N5268,
         N5269, N5270, N5271, N5272, N5273, N5274, N5275, N5293, n1, n2, n3,
         n4, n5, n6, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241, n4380, n4381, n4382, n4383, n4384,
         n4385, n4386, n4387, n4388, n4389, n4390, n4391, n4392, n4393, n4394,
         n4395, n4396, n4397, n4398, n4399, n4400, n4401, n4402, n4403, n4404,
         n4405, n4406, n4407, n4408, n4409, n4410, n4411, n4412, n4413, n4414,
         n4415, n4416, n4417, n4418, n4419, n4420, n4421, n4422, n4423, n4424,
         n4425, n4426, n4427, n4428, n4429, n4430, n4431, n4432, n4433, n4434,
         n4435, n4436, n4437, n4438, n4439, n4440, n4441, n4442, n4443, n4444,
         n4445, n4446, n4447, n4448, n4449, n4450, n4451, n4452, n4453, n4454,
         n4455, n4456, n4457, n4458, n4459, n4460, n4461, n4462, n4463, n4464,
         n4465, n4466, n4467, n4468, n4469, n4470, n4471, n4472, n4473, n4474,
         n4475, n4476, n4477, n4478, n4479, n4480, n4481, n4482, n4483, n4484,
         n4485, n4486, n4487, n4488, n4489, n4490, n4491, n4492, n4493, n4494,
         n4495, n4496, n4497, n4498, n4499, n4500, n4501, n4502, n4503, n4504,
         n4505, n4506, n4507, n4508, n4509, n4510, n4511, n4512, n4513, n4514,
         n4515, n4516, n4517, n4518, SYNOPSYS_UNCONNECTED_1,
         SYNOPSYS_UNCONNECTED_2, SYNOPSYS_UNCONNECTED_3,
         SYNOPSYS_UNCONNECTED_4, SYNOPSYS_UNCONNECTED_5,
         SYNOPSYS_UNCONNECTED_6, SYNOPSYS_UNCONNECTED_7,
         SYNOPSYS_UNCONNECTED_8, SYNOPSYS_UNCONNECTED_9,
         SYNOPSYS_UNCONNECTED_10, SYNOPSYS_UNCONNECTED_11,
         SYNOPSYS_UNCONNECTED_12, SYNOPSYS_UNCONNECTED_13,
         SYNOPSYS_UNCONNECTED_14, SYNOPSYS_UNCONNECTED_15,
         SYNOPSYS_UNCONNECTED_16, SYNOPSYS_UNCONNECTED_17,
         SYNOPSYS_UNCONNECTED_18, SYNOPSYS_UNCONNECTED_19,
         SYNOPSYS_UNCONNECTED_20, SYNOPSYS_UNCONNECTED_21,
         SYNOPSYS_UNCONNECTED_22, SYNOPSYS_UNCONNECTED_23,
         SYNOPSYS_UNCONNECTED_24, SYNOPSYS_UNCONNECTED_25,
         SYNOPSYS_UNCONNECTED_26, SYNOPSYS_UNCONNECTED_27,
         SYNOPSYS_UNCONNECTED_28, SYNOPSYS_UNCONNECTED_29,
         SYNOPSYS_UNCONNECTED_30, SYNOPSYS_UNCONNECTED_31,
         SYNOPSYS_UNCONNECTED_32;
  wire   [1:0] sti__cntl__oob_cntl_d1;
  wire   [3:0] sti__cntl__oob_type_d1;
  wire   [31:0] sti__cntl__oob_data_d1;
  wire   [21:1] cntl__simd__rs0_e1;
  wire   [31:0] cntl__simd__rs1_e1;
  wire   [12:0] cntl__simd__lane_r130_e1;
  wire   [12:0] cntl__simd__lane_r134_e1;
  wire   [19:0] cntl__simd__lane_r132_e1;
  wire   [12:0] cntl__simd__lane_r131_e1;
  wire   [12:0] cntl__simd__lane_r135_e1;
  wire   [19:0] cntl__simd__lane_r133_e1;
  wire   [23:0] sourceAddress0;
  wire   [23:0] destinationAddress0;
  wire   [3:0] src_data_type0;
  wire   [23:0] sourceAddress1;
  wire   [23:0] destinationAddress1;
  wire   [3:0] src_data_type1;
  wire   [15:0] numberOfOperands;
  wire   [20:0] stOp_operation;
  wire   [7:0] stOp_optionPtr;
  wire   [1:0] from_Sti_OOB_Fifo_0__pipe_cntl;
  wire   [31:0] from_Sti_OOB_Fifo_0__pipe_data;
  wire   [7:0] pe_cntl_oob_rx_cntl_state;

endmodule
