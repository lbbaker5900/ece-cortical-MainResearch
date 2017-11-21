//---------------------------------------------------------------------------
// Copyright 2016 Tezzaron Semiconductor
//    All Rights Reserved
//    This file includes the confidential information of Tezzaron Semiconductor.
//    The receiver of this confidential information shall not disclose it
//    to any third party and shall protect its confidentiality.
//---------------------------------------------------------------------------
//   Warranty:
//   Use all material in this file at your own risk. 
//   Tezzaron Semiconductor makes no claims about any material
//   contained in this file.
//---------------------------------------------------------------------------
// Rev    Author   Date       Changes
//---------------------------------------------------------------------------
// 0.40   DAC      10/06/15   Added diff clk in/out and BL2 operation
// 0.50   DAC      11/09/15   Added protocol checker
// 0.71   DAC      01/16/16   Added multiple ports and memory initialization
// 0.72   MKS      03/09/16   Added adjacent bank access timing check
// 0.90   DAC      04/06/16   Added training of ports
// 0.91   DAC      05/12/16   Fix PR to PR adj bank timing check
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// Model Macro Definitions
//---------------------------------------------------------------------------
int unsigned DiRAM4_DEBUG_LEVEL = 0; // 0: No Debug (Default)
                                     // 1: Normal Debug
                                     // 2: Verbose Debug

`define mdl_dbg(dbg_level, debug_msg_str) \
   if (DiRAM4_DEBUG_LEVEL >= dbg_level) begin \
      $write ("MDL_DEBUG %s (%0d) @ %0t: %m : ", `__FILE__, `__LINE__, $time); \
      $display(debug_msg_str); \
   end

`define mdl_info    "MDL_INFO ",`__FILE__
`define mdl_warning "MDL_WARNING ",`__FILE__
`define mdl_error   "MDL_ERROR ",`__FILE__
`define mdl_fatal   "MDL_FATAL ",`__FILE__

module diram4 #(
  parameter DO_MEM_INIT = 0,
            // 0: Default value
            // 1: Load MEM_INIT_FILE during init

  parameter MEM_INIT_FILE = "diram4_memory.txt",
            // Name of the file that holds the
            // initial memory data to be pre-loaded
            // For sample format, please see...
            //    (a) diram4_memory.txt.sample_BL_2 or
            //    (b) diram4_memory.txt.sample_BL_8

  parameter PORT_COUNT = 64, 
  parameter ROW_WIDTH  = 12,
  parameter BANK_WIDTH = 5,
  parameter DQ_WIDTH   = 32,
  parameter BL = 2)
(
  input [PORT_COUNT-1:0]                    clk,   // Main Input Clock - 1 GHz
  input [PORT_COUNT-1:0]                    clk_n, // Differential Input Clock
  input [PORT_COUNT-1:0]                    cs_n,
  input [PORT_COUNT-1:0]                    cmd0,
  input [PORT_COUNT-1:0]                    cmd1,
  input [PORT_COUNT-1:0][ ROW_WIDTH-1:0]    addr,
  input [PORT_COUNT-1:0][BANK_WIDTH-1:0]    baddr,
  input [PORT_COUNT-1:0][  DQ_WIDTH-1:0]    d,
  input [PORT_COUNT-1:0][  DQ_WIDTH/32-1:0] dm,
  output[PORT_COUNT-1:0]                    cq,    // Output clock
  output[PORT_COUNT-1:0]                    cq_n,  // Output clock_n
  output[PORT_COUNT-1:0][  DQ_WIDTH-1:0]    q,     // Output
  output[PORT_COUNT-1:0]                    qvld   // Output data valid
);
timeunit 1ps;
timeprecision 1ps;

//---------------------------------------------------------------------------
// Local Parameter
//---------------------------------------------------------------------------
localparam MAX_PORT_COUNT = 64;

//---------------------------------------------------------------------------
// Internal declarations
//---------------------------------------------------------------------------
   int        mem_init_count[PORT_COUNT];
   bit[255:0] mem_init_data[PORT_COUNT][bit[31:0]]; // Array of associative arrays
                                              // One assoc array per port - 64 ports max
   event      read_mem_init_data_event;
//---------------------------------------------------------------------------
// Instantiate PORT_COUNT number of 'diram4_port_model'
//---------------------------------------------------------------------------

for (genvar ii=0; ii < PORT_COUNT; ii++) begin: port_inst

   diram4_port_model # (
      .DQ_WIDTH(DQ_WIDTH),
      .ROW_WIDTH(ROW_WIDTH),
      .BANK_WIDTH(BANK_WIDTH),
      .BL(BL)) single_port_model (
      .clk   (clk[ii]),
      .clk_n (clk_n[ii]),
      .cs_n  (cs_n[ii]),
      .cmd0  (cmd0[ii]),
      .cmd1  (cmd1[ii]),
      .addr  (addr[ii]),
      .baddr (baddr[ii]),
      .d     (d[ii]),
      .cq    (cq[ii]),
      .cq_n  (cq_n[ii]),
      .q     (q[ii]),
      .qvld  (qvld[ii])
   );
end // for - port_inst

//---------------------------------------------------------------------------
// This initial block reads the memory initialization file.
//---------------------------------------------------------------------------
initial begin
   bit    succeed;
   int    load_mem_init_flag;
   string mem_file_name;

   if (PORT_COUNT <= MAX_PORT_COUNT) begin
      $display(`mdl_info,
               $sformatf("(%0d) @ %0t: %m : Configured PORT_COUNT = %0d",
               `__LINE__, $time, PORT_COUNT));
   end else begin
      $display(`mdl_fatal,
               $sformatf("(%0d) @ %0t: %m : Bad Configuration - PORT_COUNT = %0d. MAX_PORT_COUNT = %0d! Stopped simulation!!",
               `__LINE__, $time, PORT_COUNT, MAX_PORT_COUNT));
      $finish; //Stopping simulation
   end

   if ($value$plusargs("DIRAM4_LOAD_MEM_FILE=%s", mem_file_name)) begin
      load_mem_init_flag = 1;
   end else begin
      load_mem_init_flag = DO_MEM_INIT;
      mem_file_name      = MEM_INIT_FILE;
   end

   if (load_mem_init_flag == 0) begin
      $display(`mdl_info,
               $sformatf("(%0d) @ %0t: %m : No file based memory initialization will be done (Default)",
               `__LINE__, $time));
   end else begin
      succeed = 0;
      succeed = initialize_memory_file(PORT_COUNT, BL, mem_file_name);
      if (succeed)
         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : Successfully loaded memory initialization file \"%s\".",
                  `__LINE__, $time, mem_file_name));
      else
         $display(`mdl_warning,
                  $sformatf("(%0d) @ %0t: %m : Unable to successfully load memory file \"%s\". Ignoring...",
                  `__LINE__, $time, mem_file_name));
   end // if (load_mem_init_flag)

   ->read_mem_init_data_event;

end // initial

//---------------------------------------------------------------------------
// This generate block loads the data in the memory model at T=0 that was
// read from the memory initialization file by the above initial block.
//---------------------------------------------------------------------------
for (genvar port_id=0; port_id < PORT_COUNT; port_id++) begin: gen_hier_path
   initial begin //actually write to the multiport_instances
      int        record_cnt;
      bit[31:0]  assoc_array_index;
      bit[7:0]   port_8b;
      bit[1:0]   array_2b;
      bit[3:0]   bank_4b;
      bit[3:0]   slab_4b;
      bit[7:0]   row_8b;
      bit[5:0]   column_6b;
      bit[1:0]   col_lsb_2b;
      bit[20:0]  wr_idx_21b;
      bit[63:0]  wr_data_64b;
      bit[255:0] wr_data_256b;

      int        gen_hier_debug;

      gen_hier_debug = 0; // Default value 0
                          // 0: No Debug
                          // 1: Normal Debug
                          // 2: Verbose Debug

      wait(read_mem_init_data_event.triggered);

      record_cnt = mem_init_count[port_id];
      if (record_cnt > 0) begin // There are some mem_init for this port...
         if (gen_hier_debug >=1)
            $display("DEBUG:@%0t %m: for port_id = %0d record_cnt = %0d", $time, port_id, record_cnt);

         void'(mem_init_data[port_id].first(assoc_array_index));
         do begin

            {port_8b, array_2b, bank_4b, slab_4b, row_8b, column_6b} = assoc_array_index;

            wr_idx_21b = {array_2b[1],
                          bank_4b,
                          slab_4b,
                          row_8b,
                          column_6b[5:2]}; // MSB 4-bits of Column

            wr_data_256b = mem_init_data[port_id][assoc_array_index]; // for BL_8

            if (BL == 2) begin // Default is BL_2
               col_lsb_2b  = column_6b[1:0];
               wr_data_64b = wr_data_256b[63:0];
            end

            if (gen_hier_debug >=1) begin
               $display("DEBUG: record: %0d", record_cnt);
               $display("DEBUG: assoc_array_index = 0x%x, data = 0x%x", assoc_array_index, mem_init_data[port_id][assoc_array_index]);
               $display("DEBUG: \t port_8b    = 0x%x (decimal %0d)", port_8b, port_8b);
               $display("DEBUG: \t array_2b   = 0x%x", array_2b);
               $display("DEBUG: \t bank_4b    = 0x%x", bank_4b);
               $display("DEBUG: \t slab_4b    = 0x%x", slab_4b);
               $display("DEBUG: \t row_8b     = 0x%x", row_8b);
               $display("DEBUG: \t column_6b  = 0x%x", column_6b);
               $display("DEBUG: \t wr_idx_21b = 0x%x", wr_idx_21b);
               if (BL == 2) begin // Default is BL_2
                  $display("DEBUG: \t col_lsb_2b   = 0x%x", col_lsb_2b);
                  $display("DEBUG: \t wr_data_64b   = 0x%x", wr_data_64b);
               end else begin // BL_8
                  $display("DEBUG: \t wr_data_256b  = 0x%x", wr_data_256b);
               end
            end // if (gen_hier_debug)

            if (BL == 2) begin // Default is BL_2
               if (array_2b[0] == 0) begin // Even Channel
                  if (gen_hier_debug >=1)
                     $display("DEBUG:@%0t %m: Issue Write to ram_even of port_id = %0d\t: wr_cnt = 0x%x, wr_idx = 0x%x, wr_data = 0x%x",
                               $time, port_id, col_lsb_2b, wr_idx_21b, wr_data_64b);
                  case (col_lsb_2b)
                     0: port_inst[port_id].single_port_model.ram_even.ram.mem[wr_idx_21b][ 63:  0] = wr_data_64b;
                     1: port_inst[port_id].single_port_model.ram_even.ram.mem[wr_idx_21b][127: 64] = wr_data_64b;
                     2: port_inst[port_id].single_port_model.ram_even.ram.mem[wr_idx_21b][191:128] = wr_data_64b;
                     3: port_inst[port_id].single_port_model.ram_even.ram.mem[wr_idx_21b][255:192] = wr_data_64b;
                  endcase
               end else begin              // Odd Channel
                  if (gen_hier_debug >=1)
                     $display("DEBUG:@%0t %m:Issue Write to ram_odd  of port_id = %0d\t: wr_cnt = 0x%x, wr_idx = 0x%x, wr_data = 0x%x",
                               $time, port_id, col_lsb_2b, wr_idx_21b, wr_data_64b);
                  case (col_lsb_2b)
                     0: port_inst[port_id].single_port_model.ram_odd.ram.mem[wr_idx_21b][ 63:  0] = wr_data_64b;
                     1: port_inst[port_id].single_port_model.ram_odd.ram.mem[wr_idx_21b][127: 64] = wr_data_64b;
                     2: port_inst[port_id].single_port_model.ram_odd.ram.mem[wr_idx_21b][191:128] = wr_data_64b;
                     3: port_inst[port_id].single_port_model.ram_odd.ram.mem[wr_idx_21b][255:192] = wr_data_64b;
                  endcase
               end
            end else begin // BL_8 mode
               if (array_2b[0] == 0) begin // Even Channel
                  if (gen_hier_debug >=1)
                     $display("DEBUG:@%0t %m:Issue Write to ram_even of port_id = %0d\t: wr_idx = 0x%x, wr_data = 0x%x",
                               $time, port_id, wr_idx_21b, wr_data_256b);
                  port_inst[port_id].single_port_model.ram_even.ram.mem[wr_idx_21b] = wr_data_256b;
               end else begin              // Odd Channel
                  if (gen_hier_debug >=1)
                     $display("DEBUG:@%0t %m:Issue Write to ram_odd  of port_id = %0d\t: wr_idx = 0x%x, wr_data = 0x%x",
                               $time, port_id, wr_idx_21b, wr_data_256b);
                  port_inst[port_id].single_port_model.ram_odd.ram.mem[wr_idx_21b] = wr_data_256b;
               end // if (array_2b[0] == 0)
            end // if (BL == 2)

            record_cnt--;

         end while ((mem_init_data[port_id].next(assoc_array_index)));
      end // if (record_cnt)
   end // initial
end // for - gen_hier_path

//---------------------------------------------------------------------------
// This function loads the memory initialization file
//---------------------------------------------------------------------------
function bit initialize_memory_file (int configured_port_count,
                                     int burst_length,
                                     string fname);
   int          fd, line_num;
   int          record_count;
   int          num_of_records;
   byte         char;
   string       line;
   int unsigned port;  // reads the 1st item of the line, 'port number' from the init_mem file.
   int unsigned chan;  // reads the 2nd item of the line, 'channel 0 or 1' from the init_mem file.
   int unsigned b_id;  // reads the 3rd item of the line, 'bank id' from the init_mem file.
   int unsigned p_id;  // reads the 4th item of the line, 'page id' from the init_mem file.
   int unsigned c_addr;// reads the 5th item of the line, 'cache line address' from the init_mem file.
   bit[255:0]   d_256b;// reads the 6th item of the line, 'data' from the init_mem file.
   bit[255:0]   data_mask_for_BL2_mode;

   bit          bad_record_flag;

   bit[7:0]     port_8b;
   bit[1:0]     array_2b;
   bit[3:0]     bank_4b;
   bit[3:0]     slab_4b;
   bit[7:0]     row_8b;
   bit[5:0]     column_6b;

   bit[31:0]    assoc_array_idx;
   bit[255:0]   wr_data_256b;

   int          init_mem_debug;

   init_mem_debug = 0; // Default value 0
                       // 0: No Debug
                       // 1: Normal Debug
                       // 2: Verbose Debug

   data_mask_for_BL2_mode = {192'h0, {64{1'b1}}};

   if (configured_port_count > MAX_PORT_COUNT) begin
      $display(`mdl_error,
               $sformatf("(%0d) @ %0t: %m : Bad Configuration, configured_port_count = %0d, MAX_PORT_COUNT = %0d",
               `__LINE__, $time, configured_port_count, MAX_PORT_COUNT));
      return 0; // failed
   end

   fd = $fopen (fname, "r");
   if (fd == 0) begin
      $display(`mdl_error,
               $sformatf("(%0d) @ %0t: %m : Cannot open memory file \"%s\".",
               `__LINE__, $time, fname));
      return 0; // failed
   end

   $display(`mdl_info,
            $sformatf("(%0d) @ %0t: %m : Opened memory file \"%s\".",
            `__LINE__, $time, fname));

   if (init_mem_debug >=1)
      $display("DEBUG: Processing in BL_%0d mode", burst_length);

   line_num = 0;
   record_count = 0;

   while (!$feof(fd)) begin // saw EOF
      line_num++;
      char = $fgetc(fd);

      // Watch for these following chars...

      if (init_mem_debug >= 2)
         $display("DEBUG: %c or 0x%0h", char, char);

      while ((char == 'h20) || (char == 'h9)) begin // skip these characters at the begining of any line
         char = $fgetc(fd);                         // 0x20  Space (invisible white space chars)
         if (init_mem_debug >= 2)                   // 0x9  is Tab (invisible white space chars)
            $display("DEBUG: %c or 0x%0h", char, char);
      end // while

      if ((char == 'h23) || (char == 'ha)) begin // skip, when see lines begining with these chars
                                                 // 0x23 '#' or 0xa  Newline
         void'($ungetc(char, fd));  // put that char back in the file
         void'($fgets(line, fd));   // get that line from the file, no processing done, throw it away
                                    // Ignore that line as it begins with '#', a comment statement
         if (init_mem_debug >= 2)
            $display("DEBUG: comment or new line %0d: %s", line_num, line);

         continue; // Go to work on the first character of the next line
      end

      // valid line will be processed only when begins with hexadecimal digits
      if (!ishexdigit(char)) begin
         void'($ungetc(char, fd));  // put that char back in the file
         void'($fgets(line, fd));   // get that line from the file, no processing done, throw it away
         // Ignore that line as it does not begin with [0-9, A-F, a-f]
         if (init_mem_debug >= 2)
            $display("DEBUG: unknown line %0d: %s", line_num, line);
         continue; // Go to work on the first character of the next line
      end

      void'($ungetc(char, fd));  // put that char back in the file
      void'($fgets(line, fd));   // get that line from the file, now we will process it...

      if (init_mem_debug >=1)
         $display("DEBUG: Scanning line %0d for record %0d: %s", line_num, record_count+1, line);

      // Load them with illegal values before scanning the record
      port   = '1;
      chan   = '1;
      b_id   = '1;
      p_id   = '1;
      c_addr = '1;

      bad_record_flag = 0;

      void'($sscanf(line, "%x %x %x %x %x %x", port, chan, b_id, p_id, c_addr, d_256b));

      if (port >= configured_port_count) begin
         $display(`mdl_error,
                  $sformatf("(%0d) @ %0t: %m : at Line %0d invalid port_id: 0x%0x (valid 0 to 0x%0x)",
                  `__LINE__, $time, line_num, port, configured_port_count));
         bad_record_flag = 1;
      end

      if (chan > 'h1) begin
         $display(`mdl_error,
                  $sformatf("(%0d) @ %0t: %m : at Line %0d invalid channel_id: 0x%0x (valid 0 to 1)",
                  `__LINE__, $time, line_num, chan));
         bad_record_flag = 1;
      end

      if (b_id > 'h1f) begin
         $display(`mdl_error,
                  $sformatf("(%0d) @ %0t: %m : at Line %0d invalid bank_id: 0x%0x (valid 0 to 0x1f)",
                  `__LINE__, $time, line_num, b_id));
         bad_record_flag = 1;
      end

      if (p_id > 'hfff) begin
         $display(`mdl_error,
                  $sformatf("(%0d) @ %0t: %m : at Line %0d invalid page_id: 0x%0x (valid 0 to 0xfff)",
                  `__LINE__, $time, line_num, p_id));
         bad_record_flag = 1;
      end

      if (burst_length == 2) begin // Default is BL_2
         if (c_addr > 'h3f) begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : at Line %0d invalid cache_addr: 0x%0x (valid 0 to 0x3f)",
                     `__LINE__, $time, line_num, c_addr)); // BL_2
            bad_record_flag = 1;
         end
      end else begin // BL_8
         if (c_addr > 'hf) begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : at Line %0d invalid cache_addr: 0x%0x (valid 0 to 0xf)",
                     `__LINE__, $time, line_num, c_addr)); // BL_8
            bad_record_flag = 1;
         end
      end // if

      if (burst_length == 2) begin // Check data and issue Warning (not ERROR) in BL_2 mode only
         if ((d_256b & ~data_mask_for_BL2_mode) != 256'h0) begin
            $display(`mdl_warning,
                     $sformatf("(%0d) @ %0t: %m : at Line %0d data is more than 64-bits: 0x%0x, will use 0x%0x",
                     `__LINE__, $time, line_num, d_256b, d_256b & data_mask_for_BL2_mode));
            d_256b = d_256b & data_mask_for_BL2_mode;
         end // if
      end // if

      if (bad_record_flag) begin
         $display(`mdl_error,
                  $sformatf("(%0d) @ %0t: %m : Ignore this bad record",
                  `__LINE__, $time));
         continue;
      end

      if (init_mem_debug >=1) begin
         $display("DEBUG: record: %0d", record_count+1);
         $display("DEBUG: \t port_id    = 0x%0x", port);   // 1 of 6
         $display("DEBUG: \t channel_id = 0x%0x", chan);   // 2 of 6
         $display("DEBUG: \t bank_id    = 0x%0x", b_id);   // 3 of 6
         $display("DEBUG: \t page_id    = 0x%0x", p_id);   // 4 of 6
         $display("DEBUG: \t cache_addr = 0x%0x", c_addr); // 5 of 6
         $display("DEBUG: \t data       = 0x%0x", d_256b); // 6 of 6
      end // if

      port_8b   = {2'b0, port[5:0]};
      array_2b  = {b_id[4], chan[0]};
      bank_4b   = b_id[3:0];
      slab_4b   = p_id[11:8];
      row_8b    = p_id[7:0];
      column_6b = c_addr[5:0];
      if (burst_length == 8)
         column_6b = column_6b << 2;

      wr_data_256b = d_256b;

      assoc_array_idx = {port_8b,
                         array_2b,
                         bank_4b,
                         slab_4b,
                         row_8b,
                         column_6b};

      if (init_mem_debug >=1)
         $display("DEBUG: assoc_array entry for port = %0d (0x%2x) and assoc_array_idx = 0x%x",
                   port, port, assoc_array_idx);

      mem_init_data[port][assoc_array_idx] = wr_data_256b; // Build that associative array element

      record_count++;
      mem_init_count[port]++;

   end // while

   num_of_records = record_count;

   $fclose(fd);

   $display(`mdl_info,
            $sformatf("(%0d) @ %0t: %m : Closed memory file \"%s\".",
            `__LINE__, $time, fname));

   if (num_of_records == 0) begin
      $display(`mdl_error,
               $sformatf("(%0d) @ %0t: %m : Not a single valid record for memory initialization, num_of_records =  %0d",
               `__LINE__, $time, num_of_records));
      return 0; // failed
   end else begin
      $display(`mdl_info,
               $sformatf("(%0d) @ %0t: %m : Processed %0d records for memory initialization",
               `__LINE__, $time, num_of_records));
      if (init_mem_debug >=1) begin
         for (int pp=0; pp<PORT_COUNT; pp++)
            $display("DEBUG: for port = %0d, mem_init_count = %0d", pp, mem_init_count[pp]);
      end
   end

   return 1; // succeeded
endfunction : initialize_memory_file

/*********************** Extracted from ASCII Table *************************
DEC 	OCT 	HEX 	BIN 	  Symbol Description
---     ---     ---     --------  ------ -----------
48	060	30	00110000    0	 Zero
49	061	31	00110001    1	 One
50	062	32	00110010    2	 Two
51	063	33	00110011    3	 Three
52	064	34	00110100    4	 Four
53	065	35	00110101    5	 Five
54	066	36	00110110    6	 Six
55	067	37	00110111    7	 Seven
56	070	38	00111000    8	 Eight
57	071	39	00111001    9	 Nine
65	101	41	01000001    A	 Uppercase A
66	102	42	01000010    B	 Uppercase B
67	103	43	01000011    C	 Uppercase C
68	104	44	01000100    D	 Uppercase D
69	105	45	01000101    E	 Uppercase E
70	106	46	01000110    F	 Uppercase F
97	141	61	01100001    a	 Lowercase a
98	142	62	01100010    b	 Lowercase b
99	143	63	01100011    c	 Lowercase c
100	144	64	01100100    d	 Lowercase d
101	145	65	01100101    e	 Lowercase e
102	146	66	01100110    f	 Lowercase f
****************************************************************************/
//---------------------------------------------------------------------------
// This function checks if a character is a hexadecimal digit
// This is similar to C/C++ library function "int isxdigit(int c)"
//---------------------------------------------------------------------------
function bit ishexdigit (byte c);
   if (((c >= 'h30) && (c <= 'h39)) || // A numeral [0..9]
       ((c >= 'h41) && (c <= 'h46)) || // Uppercase [A..F]
       ((c >= 'h61) && (c <= 'h66)))   // Lowercase [a..f]
      return 1;
   else
      return 0;
endfunction : ishexdigit

endmodule : diram4

//==============================================================================

module diram4_port_model #(
  parameter DQ_WIDTH   = 32,
  parameter BANK_WIDTH = 5,
  parameter ROW_WIDTH  = 12,
  parameter COL_WIDTH  = 6,
  parameter CL_PER_PAGE  = 64,
  parameter BITS_PER_PAGE  = 4096,
  parameter BL = 2)
(
  input                     clk,   // Main Input Clock - 1 GHz
  input                     clk_n, // Differential Input Clock pin
  input                     cs_n,
  input                     cmd0,
  input                     cmd1,
  input [ ROW_WIDTH-1:0]    addr,
  input [BANK_WIDTH-1:0]    baddr,
  input [  DQ_WIDTH-1:0]    d,
  input [  DQ_WIDTH/32-1:0] dm,
  output                    cq,
  output                    cq_n,
  output[  DQ_WIDTH-1:0]    q,
  output                    qvld
);

timeunit 1ps;
timeprecision 1ps;

//---------------------------------------------------------------------------
// Local Parameter
//---------------------------------------------------------------------------
`include "diram4_params.svh"
  // Number of input pins undergoing training...
  //  cs_n :  1 +
  //  cmd0 :  1 +
  //  cmd1 :  1 +
  //  addr : 12 +
  // baddr :  5 +
  //     d : 32 =
  // TOTAL : 52
  localparam TRAINING_PATTERN = 16'hE89A;
  localparam NUM_OF_NETS = 53; // Max number of nets to inspect to detect training pattern
  localparam NUM_OF_TRANS_2_REC = 48; // Number of clock transitions to record

//---------------------------------------------------------------------------
// Internal declarations
//---------------------------------------------------------------------------
  bit                       clk_in_dly;
  bit                       clk_out_ddr;
  bit                       port_clk_r;
  bit                       port_clk_f;
  logic                     cs_n_r;
  logic                     cs_n_f;
  logic                     cmd0_r;
  logic                     cmd1_r;
  logic                     cmd0_f;
  logic                     cmd1_f;
  logic [ ROW_WIDTH-1:0]    addr_r;
  logic [BANK_WIDTH-1:0]    baddr_r;
  logic [  DQ_WIDTH-1:0]    din_r;
  logic [  DQ_WIDTH/32-1:0] dinm_r;
  logic [ ROW_WIDTH-1:0]    addr_f;
  logic [BANK_WIDTH-1:0]    baddr_f;
  logic [  DQ_WIDTH-1:0]    din_f;
  logic [  DQ_WIDTH/32-1:0] dinm_f;
  logic [  DQ_WIDTH-1:0]    dout_ddr;
  logic [  DQ_WIDTH-1:0]    dout_r;
  logic [  DQ_WIDTH-1:0]    dout_f;
  logic                     rdstrb_r;
  logic                     rdstrb_f;
  logic                     rdstrb_ddr;

  int                    port_mem_debug;
  bit                    training_mode_flag;
  bit                    training_mode_done;
  int                    added_data_delay[NUM_OF_NETS];
  int                    input_clock_delay;
  int                    add_pad_up_delay;
  int                    output_clock_delay;
  bit                    enable_trng_patt_gen;
  logic [  DQ_WIDTH-1:0] trng_patt_32b;
  logic                  trng_patt_1b;
  logic            [3:0] trng_patt_ctr = 4'hf;
  logic           [15:0] trng_patt = TRAINING_PATTERN;
  int                    user_init_port_clk;
  event                  training_mode_event;

// protocol checker signals
  logic                   command_and_data_valid;
  logic                   count_r;
  logic                   count_f;

// training pattern checker signals
  logic                   delayed_cs_n;        // delayed inputs
  logic                   delayed_cmd0;
  logic                   delayed_cmd1;
  logic  [ ROW_WIDTH-1:0] delayed_addr;
  logic  [BANK_WIDTH-1:0] delayed_baddr;
  logic  [  DQ_WIDTH-1:0] delayed_d;
  logic  [  DQ_WIDTH/32-1:0] delayed_dm;

  logic [NUM_OF_NETS-1:0] delayed_diram_net;   // bus of delayed inputs
  logic [NUM_OF_NETS-1:0]         diram_net;
 
  logic [NUM_OF_NETS-1:0]         diram_net_r; // bus of rising edge sampled inputs
  logic [NUM_OF_NETS-1:0]         diram_net_f; // bus of falling edge sampled inputs



//---------------------------------------------------------------------------
// Initial block to run training algorithm
//---------------------------------------------------------------------------
initial begin
  added_data_delay = '{default:0};

  if ($test$plusargs("DIRAM4_TRAINING_MODE")) begin
    training_mode_flag = 1;
    -> training_mode_event;
    training_mode_done = 0;
    $display(`mdl_info,
             $sformatf("(%0d) @ %0t: %m : DiRAM4 input MUST be trained before read/write transaction is driven",
             `__LINE__, $time));

    fork
       trn_prt_ifc();  // train the prt interface and determine the clock and data delays
    join
  end else begin
    enable_trng_patt_gen = 0;  // LEE: FIXME
    training_mode_flag = 0;
    -> training_mode_event;
    training_mode_done = 0;
    $display(`mdl_info,
             $sformatf("(%0d) @ %0t: %m : DiRAM4 input needs NO training before read/write transaction is driven (Default)",
             `__LINE__, $time));
    input_clock_delay = C_CLK_DLY_IN; // Leave it unchanged at C_CLK_DLY_IN (175ps) as we are not doing training
    output_clock_delay = C_CLK_DLY_OUT; // Leave it unchanged at C_CLK_DLY_OUT (175ps) as we are not doing training
  end
end

assign command_and_data_valid = ~training_mode_flag | training_mode_done;



//---------------------------------------------------------------------------
// create bus of input signals
//---------------------------------------------------------------------------

assign diram_net[diram4_cs_n] = cs_n;
assign diram_net[diram4_cmd0] = cmd0;
assign diram_net[diram4_cmd1] = cmd1;
assign diram_net[diram4_addr11:diram4_addr0] = addr;
assign diram_net[diram4_baddr4:diram4_baddr0] = baddr;
assign diram_net[diram4_d31:diram4_d0] = d;
assign diram_net[diram4_dm] = dm;



//---------------------------------------------------------------------------
// Delay adjustment of input nets after training pattern detection (transport delay modeling)
//---------------------------------------------------------------------------

always @ (cs_n)
   delayed_diram_net[diram4_cs_n] <= #(added_data_delay[diram4_cs_n]) cs_n;

always @ (cmd0)
   delayed_diram_net[diram4_cmd0] <= #(added_data_delay[diram4_cmd0]) cmd0;

always @ (cmd1)
   delayed_diram_net[diram4_cmd1] <= #(added_data_delay[diram4_cmd1]) cmd1;

generate
   for (genvar ii=0; ii<12; ii++) begin
      always @ (addr[ii])
         delayed_diram_net[diram4_addr0+ii] <= #(added_data_delay[diram4_addr0+ii]) addr[ii];
   end
endgenerate

generate
   for (genvar ii=0; ii<5; ii++) begin
      always @ (baddr[ii])
         delayed_diram_net[diram4_baddr0+ii] <= #(added_data_delay[diram4_baddr0+ii]) baddr[ii];
   end
endgenerate

generate
   for (genvar ii=0; ii<32; ii++) begin
      always @ (d[ii])
         delayed_diram_net[diram4_d0+ii] <= #(added_data_delay[diram4_d0+ii]) d[ii];
   end
endgenerate

always @ (dm)
   delayed_diram_net[diram4_dm] <= #(added_data_delay[diram4_dm]) dm;




//---------------------------------------------------------------------------
// Assign to nets for sampling by delayed input clock
//---------------------------------------------------------------------------
assign delayed_cs_n  = delayed_diram_net[diram4_cs_n];
assign delayed_cmd0  = delayed_diram_net[diram4_cmd0];
assign delayed_cmd1  = delayed_diram_net[diram4_cmd1];
assign delayed_addr  = delayed_diram_net[diram4_addr11:diram4_addr0];
assign delayed_baddr = delayed_diram_net[diram4_baddr4:diram4_baddr0];
assign delayed_d     = delayed_diram_net[diram4_d31:diram4_d0];
assign delayed_dm    = delayed_diram_net[diram4_dm];



//---------------------------------------------------------------------------
// Delay the port 2x clock
//---------------------------------------------------------------------------

always @(posedge clk) begin
  clk_in_dly <= #input_clock_delay 1;
end

always @(posedge clk_n) begin
  clk_in_dly <= #input_clock_delay 0;
end

// delayed clk used to generate output port_clk for both channels
always @(clk_in_dly) begin
  clk_out_ddr <= #output_clock_delay clk_in_dly;
end



//---------------------------------------------------------------------------
// Generate even and odd port clocks
// Note: default value of port clock is used to get correct phase alignment
// when not training
//---------------------------------------------------------------------------
initial begin
  if ($value$plusargs("DIRAM4_INIT_CLK=%d", user_init_port_clk)) begin
                           // Default value from diram4_params.svh file
                           // 0: INIT_PORT_CLK is '0'
                           // 1: INIT_PORT_CLK is '1'
                           // 2: INIT_PORT_CLK is random
     if ((user_init_port_clk < 0) || (user_init_port_clk > 2)) begin // trap illegal parameters
           int illegal_init_port_clk;
           illegal_init_port_clk = user_init_port_clk;
           user_init_port_clk = INIT_PORT_CLK;
           $display(`mdl_info,
                    $sformatf("(%0d) @ %0t: %m : Illegal INIT_CLK plusarg = %0d! Using INIT_PORT_CLK = %0d (from diram4_params.svh file)",
                    `__LINE__, $time, illegal_init_port_clk, user_init_port_clk));
     end else if (user_init_port_clk == 2) begin
        wait(training_mode_event.triggered);
        if (training_mode_flag == 1) begin
           user_init_port_clk = $urandom_range(1);
           $display(`mdl_info,
                    $sformatf("(%0d) @ %0t: %m : Using INIT_PORT_CLK = %0d (randomized)",
                    `__LINE__, $time, user_init_port_clk));
        end else begin
           user_init_port_clk = INIT_PORT_CLK;
           $display(`mdl_info,
                    $sformatf("(%0d) @ %0t: %m : INIT_CLK can only be randomized in TRAINING_MODE. Using INIT_PORT_CLK = %0d (from diram4_params.svh file)",
                    `__LINE__, $time, user_init_port_clk));
        end
     end else begin
        $display(`mdl_info,
                 $sformatf("(%0d) @ %0t: %m : Using INIT_PORT_CLK = %0d (from command line)",
                 `__LINE__, $time, user_init_port_clk));
     end
  end else begin
    user_init_port_clk = INIT_PORT_CLK;
     $display(`mdl_info,
              $sformatf("(%0d) @ %0t: %m : Using INIT_PORT_CLK = %0d (from diram4_params.svh file)",
              `__LINE__, $time, user_init_port_clk));
  end

  port_clk_r = user_init_port_clk;
  port_clk_f = user_init_port_clk;
  port_mem_debug = 0; // Default value 0
                      // 0: No Debug
                      // 1: Normal Debug
                      // 2: Verbose Debug
   if (port_mem_debug)
      $display("PORT_DEBUG: Process in BL_%0d mode", BL);
end // initial

// Generate port_clk for "_r" or rising edge channel
always @(posedge clk_out_ddr) begin
  port_clk_r <= ~port_clk_r;
end

// Generate port_clk for "_f" or falling edge channel
always @(negedge clk_out_ddr) begin
  port_clk_f <= ~port_clk_f;
end



//---------------------------------------------------------------------------
// Sample input data
//---------------------------------------------------------------------------
always @(posedge clk_in_dly) begin // sample for "_r" or rising edge channel
  cs_n_r  <= delayed_cs_n;
  cmd0_r  <= delayed_cmd0;
  cmd1_r  <= delayed_cmd1;
  addr_r  <= delayed_addr;
  baddr_r <= delayed_baddr;
  din_r   <= delayed_d;
  dinm_r  <= delayed_dm;

  if (port_mem_debug >= 2)
     $display("PORT_DEBUG_r:@%0t %m:\tposedge clk: cs_n=%0d, cmd1=%0d, cmd0=%0d, addr=0x%0x, baddr=0x%0x, d=0x%0x",
              $time, cs_n, cmd1, cmd0, addr, baddr, d);
end

always @(negedge clk_in_dly) begin // sample for "_f" or falling edge channel
  cs_n_f  <= delayed_cs_n;
  cmd0_f  <= delayed_cmd0;
  cmd1_f  <= delayed_cmd1;
  addr_f  <= delayed_addr;
  baddr_f <= delayed_baddr;
  din_f   <= delayed_d;
  dinm_f  <= delayed_dm;

  if (port_mem_debug >= 2)
     $display("PORT_DEBUG_f:@%0t %m:\tposedge clk: cs_n=%0d, cmd1=%0d, cmd0=%0d, addr=0x%0x, baddr=0x%0x, d=0x%0x",
              $time, cs_n, cmd1, cmd0, addr, baddr, d);
end



//---------------------------------------------------------------------------
// create bus of sampled input data
//---------------------------------------------------------------------------
assign diram_net_r[diram4_cs_n] = cs_n_r;
assign diram_net_r[diram4_cmd0] = cmd0_r;
assign diram_net_r[diram4_cmd1] = cmd1_r;
assign diram_net_r[diram4_addr11:diram4_addr0] = addr_r;
assign diram_net_r[diram4_baddr4:diram4_baddr0] = baddr_r;
assign diram_net_r[diram4_d31:diram4_d0] = din_r;
assign diram_net_r[diram4_dm] = dinm_r;

assign diram_net_f[diram4_cs_n] = cs_n_f;
assign diram_net_f[diram4_cmd0] = cmd0_f;
assign diram_net_f[diram4_cmd1] = cmd1_f;
assign diram_net_f[diram4_addr11:diram4_addr0] = addr_f;
assign diram_net_f[diram4_baddr4:diram4_baddr0] = baddr_f;
assign diram_net_f[diram4_d31:diram4_d0] = din_f;
assign diram_net_f[diram4_dm] = dinm_f;



//---------------------------------------------------------------------------
// Instantiate even and odd port ram models
//---------------------------------------------------------------------------
diram4_ram_model # (
  .DQ_WIDTH(DQ_WIDTH),
  .BANK_WIDTH(BANK_WIDTH),
  .ROW_WIDTH(ROW_WIDTH),
  .COL_WIDTH(COL_WIDTH),
  .CL_PER_PAGE(CL_PER_PAGE),
  .BITS_PER_PAGE(BITS_PER_PAGE),
  .BL(BL)) ram_even(
  .clk         (port_clk_r),
  .cs_n        (cs_n_r | ~command_and_data_valid),
  .cmd0        (cmd0_r),
  .cmd1        (cmd1_r),
  .addr        (addr_r),
  .baddr       (baddr_r),
  .din         (din_r),
  .dinm        (dinm_r),
  .dout        (dout_r),
  .rdstrb      (rdstrb_r),
  .err_count   (count_r),
  .prot_chk_en (command_and_data_valid)
);

diram4_ram_model # (
  .DQ_WIDTH(DQ_WIDTH),
  .BANK_WIDTH(BANK_WIDTH),
  .ROW_WIDTH(ROW_WIDTH),
  .COL_WIDTH(COL_WIDTH),
  .CL_PER_PAGE(CL_PER_PAGE),
  .BITS_PER_PAGE(BITS_PER_PAGE),
  .BL(BL)) ram_odd(
  .clk         (port_clk_f),
  .cs_n        (cs_n_f | ~command_and_data_valid),
  .cmd0        (cmd0_f),
  .cmd1        (cmd1_f),
  .addr        (addr_f),
  .baddr       (baddr_f),
  .din         (din_f),
  .dinm        (dinm_f),
  .dout        (dout_f),
  .rdstrb      (rdstrb_f),
  .err_count   (count_f),
  .prot_chk_en (command_and_data_valid)
);



//---------------------------------------------------------------------------
// DDR Output Mux
//---------------------------------------------------------------------------
always_comb begin
  if (clk_out_ddr) begin
    dout_ddr   = dout_r;
    rdstrb_ddr = rdstrb_r;
  end else begin
    dout_ddr   = dout_f;
    rdstrb_ddr = rdstrb_f;
  end
end

always @(clk_out_ddr) begin
  if (enable_trng_patt_gen) begin
     trng_patt_32b <= {32{trng_patt[trng_patt_ctr]}};
     trng_patt_1b  <= trng_patt[trng_patt_ctr];
     trng_patt_ctr <= trng_patt_ctr - 1;
     if (port_clk_r == 1'b0 && port_clk_f == 1'b0) begin
        trng_patt_ctr[1:0] <= 2'b10; // sync to channel clocks
     end
  end
end // always

assign q    = enable_trng_patt_gen ? trng_patt_32b : dout_ddr;
assign qvld = enable_trng_patt_gen ? trng_patt_1b : rdstrb_ddr;



//---------------------------------------------------------------------------
// DRAM Output Clock
//---------------------------------------------------------------------------
assign cq   =  clk_out_ddr;
assign cq_n = ~clk_out_ddr;



//---------------------------------------------------------------------------
// Protocol checker error counters
//---------------------------------------------------------------------------
prot_chkr_error_counter error_counter(
  .count_r     (count_r),
  .count_f     (count_f)
);



//---------------------------------------------------------------------------
// Task: trn_prt_ifc()
//     Train the port interface and set the input clk and data delays
//---------------------------------------------------------------------------
task trn_prt_ifc();

   //---------------------------------------------------------------------------
   // Internal declarations
   //---------------------------------------------------------------------------
   bit[15:0] detected_pattern;
   bit det_patt_flag[NUM_OF_NETS];
   bit prt_chan_det_patt[NUM_OF_NETS];
   bit input_ports_trained;
   bit never_saw_training_pattern;
   int clock_p_transition_time_array[int];
   int clock_n_transition_time_array[int];
   int data_transition_time_array[NUM_OF_NETS][int];
   bit data_value_array[NUM_OF_NETS][int];
   bit reconstructed_bit_value_array[NUM_OF_NETS][int];
   int reconstructed_trns_time_array[NUM_OF_NETS][int];
   int number_of_transition_seen[NUM_OF_NETS];
   int clk_time_period, half_clk_period, quarter_clk_per;
   int pattern_start_time[NUM_OF_NETS];
   int quarter_clock_sample_time;
   int earliest_pattern_start_time;
   int latest_pattern_start_time;
   int reference_clk_p_transition_time;
   int net_delay[NUM_OF_NETS];
   int longest_net_delay;
   int shortest_net_delay;
   int net_id;
   int dtta_ptr;
   int ba_ptr;

   INP_NET net;
   INP_NET INP_NET_first;
   INP_NET INP_NET_last;
   int INP_NET_num;

   //---------------------------------------------------------------------------
   // Initialize data structure before start analysis
   //---------------------------------------------------------------------------
   enable_trng_patt_gen = 0;
   input_ports_trained = 0;

   INP_NET_num = net.num;
   INP_NET_last = net.last;
   INP_NET_first = net.first;

   //---------------------------------------------------------------------------
   // Delay clock cycles before starting capture
   //---------------------------------------------------------------------------
   repeat (TRN_STRT_CLKS) @(posedge clk);

   //---------------------------------------------------------------------------
   // do..while loop to train the interface
   //---------------------------------------------------------------------------
   do begin
      //Initialize the data structure to capture the input port signals
      never_saw_training_pattern = 1;

      number_of_transition_seen  = '{default: 0};
      det_patt_flag  = '{default: 0};
      pattern_start_time = '{default: 0};
      net_delay = '{default: 0};
      quarter_clock_sample_time = 0;
      earliest_pattern_start_time = 0;
      reference_clk_p_transition_time = 0;
      quarter_clk_per = 0;
      half_clk_period = 0;
      quarter_clk_per = 0;

      for (int ii = 0; ii < NUM_OF_TRANS_2_REC/2; ii++) begin
         clock_p_transition_time_array[ii] = 0;
         clock_n_transition_time_array[ii] = 0;
      end
      for (int jj=0; jj < NUM_OF_NETS; jj++) begin
         for (int kk = 0; kk < NUM_OF_TRANS_2_REC; kk++) begin
            data_transition_time_array[jj][kk] = 0;
            data_value_array[jj][kk] = 0;
            reconstructed_bit_value_array[jj][kk] = 0;
            reconstructed_trns_time_array[jj][kk] = 0;
         end // for
      end // for


      //
      // fork off processes to record clock and data transitions
      //
      fork
         begin : record_clock_transition
            for (int ii = 0; ii < NUM_OF_TRANS_2_REC/2; ii++) begin
               @(posedge clk);
               clock_p_transition_time_array[ii] = $time;
               @(negedge clk);
               clock_n_transition_time_array[ii] = $time;
            end // for
            disable record_net_transition; // stop recording net transistions 
         end // record_clock_transition

         begin : record_net_transition
            for (int jj=0; jj < NUM_OF_NETS; jj++) begin
               automatic int nn = jj; // bcoz of forking - jj disappears, so we copy it to nn
               fork
                  begin
                     repeat (2) @(posedge clk); // don't take samples for first 4 clocks
                                                // we never know if clock is more delayed
                                                // or data is more delayed
                     forever begin
                        @(diram_net[nn]); // any edge of the input net
                        data_transition_time_array[nn][number_of_transition_seen[nn]] = $time;
                        data_value_array[nn][number_of_transition_seen[nn]] = diram_net[nn];
                        number_of_transition_seen[nn] +=1;
                     end // forever
                  end
               join_none
            end // for
         end // record_net_transition

      join // join_all


      // First determine, what is the clock period and half-clock period
      clk_time_period = clock_p_transition_time_array[3] - clock_p_transition_time_array[2];
      half_clk_period = clock_n_transition_time_array[3] - clock_p_transition_time_array[3];
      quarter_clk_per = half_clk_period/2;

      if (clk_time_period > MAXIMUM_CLK_PERIOD) begin
         $display(`mdl_error,
                  $sformatf("(%0d) @ %0t: %m : clk_time_period = %0d (too slow), Allowable MAXIMUM_CLK_PERIOD = %0d.",
                  `__LINE__, $time, clk_time_period, MAXIMUM_CLK_PERIOD));
      end else begin
         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : clk_time_period = %0d, half_clk_period = %0d, quarter_clk_per = %0d.",
                  `__LINE__, $time, clk_time_period, half_clk_period, quarter_clk_per));
      end

      for (net_id = 0, net = INP_NET_first; net_id < INP_NET_num; net_id++, net = net.next) begin
         `mdl_dbg (1, $sformatf("net name is %s (%0d)", net.name, net))
      end

      for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
         net = INP_NET'(net_id);
         `mdl_dbg (1, $sformatf("number_of_transition_seen[%s] = %0d", net.name, number_of_transition_seen[net_id]))
      end // for - net_id

      for (int ii = 0; ii < NUM_OF_TRANS_2_REC/2; ii++) begin
         `mdl_dbg (1, $sformatf("clock_p_transition_time_array[%0d] = %0d", ii, clock_p_transition_time_array[ii]))
         `mdl_dbg (1, $sformatf("clock_n_transition_time_array[%0d] = %0d", ii, clock_n_transition_time_array[ii]))
      end // for

      // process the transition arrays for each net to create arrays of virtually sampled data
      for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
         net = INP_NET'(net_id);
         if (number_of_transition_seen[net_id]) begin
            dtta_ptr = 0;
            ba_ptr = 0;
            quarter_clock_sample_time = data_transition_time_array[net_id][0] + quarter_clk_per;

            while (dtta_ptr < (number_of_transition_seen[net_id] - 2)) begin
               `mdl_dbg (1, $sformatf("quarter_clock_sample_time=%0d, dtta_ptr = %0d",
                         quarter_clock_sample_time, dtta_ptr))

               if ((data_transition_time_array[net_id][dtta_ptr] < quarter_clock_sample_time) &&
                   (quarter_clock_sample_time < data_transition_time_array[net_id][dtta_ptr+1])) begin
                  reconstructed_bit_value_array[net_id][ba_ptr] = data_value_array[net_id][dtta_ptr];
                  reconstructed_trns_time_array[net_id][ba_ptr] = data_transition_time_array[net_id][dtta_ptr];
                  `mdl_dbg (1, $sformatf("At T=%0d: reconstructed_bit_value_array[%0d][%0d] = %1b",
                            reconstructed_trns_time_array[net_id][ba_ptr],
                            net_id, ba_ptr, reconstructed_bit_value_array[net_id][ba_ptr]))
                  ba_ptr++;
                  quarter_clock_sample_time += half_clk_period;
               end else if ((data_transition_time_array[net_id][dtta_ptr+1] < quarter_clock_sample_time) &&
                   (quarter_clock_sample_time < data_transition_time_array[net_id][dtta_ptr+2])) begin
                  reconstructed_bit_value_array[net_id][ba_ptr] = data_value_array[net_id][dtta_ptr+1];
                  reconstructed_trns_time_array[net_id][ba_ptr] = data_transition_time_array[net_id][dtta_ptr+1];
                  `mdl_dbg (1, $sformatf("At T=%0d: reconstructed_bit_value_array[%0d][%0d] = %1b",
                            reconstructed_trns_time_array[net_id][ba_ptr],
                            net_id, ba_ptr, reconstructed_bit_value_array[net_id][ba_ptr]))
                  dtta_ptr++;
                  ba_ptr++;
                  quarter_clock_sample_time += half_clk_period;
               end else begin
                  $display(`mdl_info,
                           $sformatf("(%0d) @ %0t: %m : Detected glitches on input \"%s\"", `__LINE__, $time, net.name));
                  dtta_ptr++;
               end
            end // while
         end else begin
            if (!input_ports_trained) begin
               $display(`mdl_warning,
                        $sformatf("(%0d) @ %0t: %m : No transitions seen for \"%s\" during training of input ports",
                        `__LINE__, $time, net.name));
            end else begin
               `mdl_dbg (1, $sformatf("No transitions seen for \"%s\" after input ports were trained", net.name))
            end // if
         end // if
      end // for - net_id



      // search the sampled data of each net to find the training pattern
      for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
         net = INP_NET'(net_id);
         if (number_of_transition_seen[net_id]) begin
            detected_pattern = {reconstructed_bit_value_array[net_id][0],
                                reconstructed_bit_value_array[net_id][1],
                                reconstructed_bit_value_array[net_id][2],
                                reconstructed_bit_value_array[net_id][3],
                                reconstructed_bit_value_array[net_id][4],
                                reconstructed_bit_value_array[net_id][5],
                                reconstructed_bit_value_array[net_id][6],
                                reconstructed_bit_value_array[net_id][7],
                                reconstructed_bit_value_array[net_id][8],
                                reconstructed_bit_value_array[net_id][9],
                                reconstructed_bit_value_array[net_id][10],
                                reconstructed_bit_value_array[net_id][11],
                                reconstructed_bit_value_array[net_id][12],
                                reconstructed_bit_value_array[net_id][13],
                                reconstructed_bit_value_array[net_id][14],
                                reconstructed_bit_value_array[net_id][15]};
            ba_ptr = 16;
            `mdl_dbg (2, $sformatf("On net %s detected_pattern = 0x%4x (binary : %16b)",
                      net.name, detected_pattern, detected_pattern))
            while ((detected_pattern != TRAINING_PATTERN) && (ba_ptr < reconstructed_bit_value_array[net_id].num)) begin
               detected_pattern = detected_pattern << 1;
               detected_pattern[0] = reconstructed_bit_value_array[net_id][ba_ptr];
               `mdl_dbg (2, $sformatf("on net %s detected_pattern = 0x%4x (binary : %16b)",
                         net.name, detected_pattern, detected_pattern))
               ba_ptr++;
            end // while

            if (detected_pattern == TRAINING_PATTERN) begin
               pattern_start_time[net_id] = reconstructed_trns_time_array[net_id][ba_ptr-16];
               `mdl_dbg (2, $sformatf("pattern_start_time[%s] = %0d", net.name, pattern_start_time[net_id]))
               det_patt_flag[net_id] = 1;
               never_saw_training_pattern = 0; // Reset this flag
               continue; // Once TRAINING_PATTERN is detected process the next 'net_id'
            end else begin
               if (!input_ports_trained) begin
                  $display(`mdl_error,
                           $sformatf("(%0d) @ %0t: %m : No TRAINING_PATTERN seen for \"%s\"!",
                           `__LINE__, $time, net.name));
               end else begin
                  $display(`mdl_info,
                           $sformatf("(%0d) @ %0t: %m : Ports are trained. TRAINING_PATTERN not seen for \"%s\"!",
                           `__LINE__, $time, net.name));
               end // if
            end // if
         end // if
      end // for - net_id


      // if the training pattern was not detected this iteration, determine if the algorithm is done
      if (never_saw_training_pattern) begin
         if (!input_ports_trained) begin
            $display(`mdl_warning,
                     $sformatf("(%0d) @ %0t: %m : Checked all input ports but never received training pattern.",
                     `__LINE__, $time));
         end else begin
            $display(`mdl_info,
                     $sformatf("(%0d) @ %0t: %m : DiRAM4 ouput training signals are being stopped. Training algorithm is done",
                     `__LINE__, $time));
            enable_trng_patt_gen = 0;
            training_mode_done = 1;
         end
      end


      // The first iteration determines the required clock and data delay settings
      if(!input_ports_trained && !never_saw_training_pattern) begin
         earliest_pattern_start_time = clock_p_transition_time_array[NUM_OF_TRANS_2_REC/2-1]; // start from a large value
         for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
            if (det_patt_flag[net_id] == 0)
               continue; // Ignore those nets for which the TRAINING_PATTERN was not detected.
            if (pattern_start_time[net_id] < earliest_pattern_start_time)
               earliest_pattern_start_time = pattern_start_time[net_id];
         end // for - net_id
         `mdl_dbg (1, $sformatf("initial earliest_pattern_start_time = %0d", earliest_pattern_start_time))
         
         // need to also find the latest pattern start time     
         latest_pattern_start_time = 0;
         for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
            if (det_patt_flag[net_id] == 0)
               continue; // Ignore those nets for which the TRAINING_PATTERN was not detected.
            if (pattern_start_time[net_id] > latest_pattern_start_time)
               latest_pattern_start_time = pattern_start_time[net_id];
         end // for - net_id
         `mdl_dbg (1, $sformatf("latest_pattern_start_time = %0d", latest_pattern_start_time))      
      
         // if the latest and earliest pattern start times are too far apart, adjust the early pattern start times
         if ((latest_pattern_start_time - earliest_pattern_start_time) > clk_time_period) begin
            for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
               if (det_patt_flag[net_id] == 0)
                  continue; // Ignore those nets for which the TRAINING_PATTERN was not detected.
               if (pattern_start_time[net_id] < (latest_pattern_start_time - (4 * clk_time_period)))
                  pattern_start_time[net_id] += (8 * clk_time_period); 
            end // for - net_id      
         end
      
         // now find the final earlist pattern start time
         earliest_pattern_start_time = clock_p_transition_time_array[NUM_OF_TRANS_2_REC/2-1]; // start from a large value
         for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
            if (det_patt_flag[net_id] == 0)
               continue; // Ignore those nets for which the TRAINING_PATTERN was not detected.
            if (pattern_start_time[net_id] < earliest_pattern_start_time)
               earliest_pattern_start_time = pattern_start_time[net_id];
         end // for - net_id
         `mdl_dbg (1, $sformatf("final earliest_pattern_start_time = %0d", earliest_pattern_start_time))      
      
         // check that the first clock transition occurred before the data transition times
         // and use the first positive clock transition time as the initial reference clock transition time      
         if (clock_p_transition_time_array[0] > earliest_pattern_start_time) begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : earliest_pattern_start_time = %0d, clock_p_transition_time_array[0] = %0d",
                     `__LINE__, $time, earliest_pattern_start_time, clock_p_transition_time_array[0]));
            $display(`mdl_fatal,
                     $sformatf("(%0d) @ %0t: %m : Unreachable Code: the pattern was detected before clock was seen. Stopped simulation!",
                     `__LINE__, $time));
            $finish; //Stopping simulation
         end else begin
            reference_clk_p_transition_time = clock_p_transition_time_array[0]; // start searching from begining of the array
         end

         // find the closest positive clock transition time that occurs before the earliest pattern start time
         for (int ii = 0; ii < NUM_OF_TRANS_2_REC/2; ii++) begin
            `mdl_dbg (2, $sformatf("clock_p_transition_time_array[%0d] = %0d", ii, clock_p_transition_time_array[ii]))
            if (clock_p_transition_time_array[ii] <= earliest_pattern_start_time) 
               reference_clk_p_transition_time = clock_p_transition_time_array[ii];
            else
               break;
         end // for
         `mdl_dbg (1, $sformatf("reference_clk_p_transition_time = %0d", reference_clk_p_transition_time))

         // find the longest and shortest net delays with respect to the reference clock transition time
         longest_net_delay = 0; // start from a small value
         shortest_net_delay = clock_p_transition_time_array[NUM_OF_TRANS_2_REC/2-1]; // start from a large value
         for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
            net = INP_NET'(net_id);
            if (det_patt_flag[net_id] == 1) begin // Only those nets for which the TRAINING_PATTERN was detected.
               net_delay[net_id] = pattern_start_time[net_id] - reference_clk_p_transition_time;
               $display(`mdl_info,
                        $sformatf("(%0d) @ %0t: %m : net_delay[%s] = %0d", `__LINE__, $time, net.name, net_delay[net_id]));
               if (net_delay[net_id] > longest_net_delay)
                  longest_net_delay = net_delay[net_id];
               if (net_delay[net_id] < shortest_net_delay)
                  shortest_net_delay = net_delay[net_id];
            end // if
         end // for - net_id
         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : longest_net_delay = %0d and shortest_net_delay = %0d",
                  `__LINE__, $time, longest_net_delay, shortest_net_delay));
         if ((longest_net_delay - shortest_net_delay) > MAXIMUM_NET_SKEW) begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Difference between longest and shortest net delay = %0d, Allowable MAXIMUM_NET_SKEW = %0d.",
                     `__LINE__, $time, longest_net_delay - shortest_net_delay, MAXIMUM_NET_SKEW));
         end else begin
            $display(`mdl_info,
                     $sformatf("(%0d) @ %0t: %m : Difference between longest and shortest net delay = %0d, MAXIMUM_NET_SKEW = %0d.",
                     `__LINE__, $time, longest_net_delay - shortest_net_delay, MAXIMUM_NET_SKEW));
         end
         
         // determine the required input clock delay
         if (longest_net_delay > clk_time_period) 
            input_clock_delay = longest_net_delay - clk_time_period + C_CLK_DLY_IN;
         else
            input_clock_delay = longest_net_delay + C_CLK_DLY_IN;
            
         // determine the output clock delay along with any additional delay needed on the clock and data inputs
         if (input_clock_delay < (C_CLK_DLY_IN + C_CLK_DLY_OUT)) begin // 'input_clock_delay' smaller than 350ps
            output_clock_delay = (C_CLK_DLY_IN + C_CLK_DLY_OUT) - input_clock_delay;
            add_pad_up_delay = 0; // no further padding done
         end else begin // 'input_clock_delay' larger than 350ps
            output_clock_delay = C_CLK_DLY_OUT;
            if (longest_net_delay > clk_time_period)
               add_pad_up_delay = 1 * clk_time_period - (longest_net_delay - clk_time_period); 
            else
               add_pad_up_delay = 1 * clk_time_period - longest_net_delay; 
         end

         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : input_clock_delay = %0d (Before padding)", `__LINE__, $time, input_clock_delay));
         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : add_pad_up_delay = %0d", `__LINE__, $time, add_pad_up_delay));

         input_clock_delay += add_pad_up_delay;
         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : input_clock_delay = %0d (First Delay)", `__LINE__, $time, input_clock_delay));
         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : output_clock_delay = %0d", `__LINE__, $time, output_clock_delay));

         for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
            net = INP_NET'(net_id);
            if ((number_of_transition_seen[net_id] != 0) && (det_patt_flag[net_id] != 0)) begin
               added_data_delay[net_id] = longest_net_delay - net_delay[net_id] + add_pad_up_delay;
               $display(`mdl_info,
                        $sformatf("(%0d) @ %0t: %m : added_data_delay[%s] = %0d.",
                        `__LINE__, $time, net.name, added_data_delay[net_id]));
            end // if
         end // for - net_id


         // check the training pattern using the 1x port clocks
         // and adjust delays if not detected
         repeat (10) @(posedge clk);
         prt_chan_trn_chk(prt_chan_det_patt);

         for (int ii=0; ii<NUM_OF_NETS; ii++) begin
            if (det_patt_flag[ii] != prt_chan_det_patt[ii]) begin
               add_pad_up_delay += clk_time_period;
               break;
            end
         end

         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : input_clock_delay = %0d (Before additional padding)", `__LINE__, $time, input_clock_delay));
         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : add_pad_up_delay = %0d", `__LINE__, $time, add_pad_up_delay));
         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : input_clock_delay = %0d (Final Delay)", `__LINE__, $time, input_clock_delay));
         $display(`mdl_info,
                  $sformatf("(%0d) @ %0t: %m : output_clock_delay = %0d", `__LINE__, $time, output_clock_delay));

         for (net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
            net = INP_NET'(net_id);
            if ((number_of_transition_seen[net_id] != 0) && (det_patt_flag[net_id] != 0)) begin
               added_data_delay[net_id] = longest_net_delay - net_delay[net_id] + add_pad_up_delay;
               $display(`mdl_info,
                        $sformatf("(%0d) @ %0t: %m : added_data_delay[%s] = %0d.",
                        `__LINE__, $time, net.name, added_data_delay[net_id]));
            end // if
         end //   


         // run the port channel training check with the new delays
         repeat (10) @(posedge clk);
         prt_chan_trn_chk(prt_chan_det_patt);

         for (int ii=0; ii<NUM_OF_NETS; ii++) begin
            net = INP_NET'(ii);
            if (det_patt_flag[ii] != prt_chan_det_patt[ii]) begin
               // No pattern 
               $display(`mdl_error,
                        $sformatf("(%0d) @ %0t: %m : Failed to detect training pattern with channel clock for \"%s\"",
                        `__LINE__, $time, net.name));
            end
         end

         enable_trng_patt_gen = 1;
         input_ports_trained = 1;
      end // if
   end while (!training_mode_done);

endtask : trn_prt_ifc



//---------------------------------------------------------------------------
// Task: prt_chan_trn_chk()
//     Check for the training pattern using the channel clocks.
//---------------------------------------------------------------------------
task automatic prt_chan_trn_chk (output bit prt_chan_det_patt [NUM_OF_NETS]);

   // packed array of data value for each net (big endian data)
   bit  [NUM_OF_NETS-1:0][0:NUM_OF_TRANS_2_REC-1] prt_data_val = 0;
   int prt_data_ptr[NUM_OF_NETS] = '{default: 0};

   // fork off a process for each net to capture rise and fall data
   // using the channel clocks
   fork begin: capt_prt_data
      for (int jj=0; jj < NUM_OF_NETS; jj++) begin
         automatic int nn = jj;
         fork
            begin
               int prt_data_ptr=0;
               for (int ii = 0; ii < NUM_OF_TRANS_2_REC/4; ii++) begin
                 @(posedge port_clk_r);
                 prt_data_val[nn][prt_data_ptr] = diram_net_r[nn];
                 prt_data_ptr++;
                 @(posedge port_clk_f);
                 prt_data_val[nn][prt_data_ptr] = diram_net_f[nn];
                 prt_data_ptr++;
                 @(negedge port_clk_r);
                 prt_data_val[nn][prt_data_ptr] = diram_net_r[nn];
                 prt_data_ptr++;
                 @(negedge port_clk_f);
                 prt_data_val[nn][prt_data_ptr] = diram_net_f[nn];
                 prt_data_ptr++;
              end // for
            end
         join_none
       end // for each net
    end
    join

    repeat (NUM_OF_TRANS_2_REC/2 + 2) @(posedge port_clk_r);

//  $display("The prt_data_val for net_id 0 is: %12h",  prt_data_val[0]);
//  $display("The prt_data_val for net_id 1 is: %12h",  prt_data_val[1]);
//  $display("The prt_data_val array is: %p",  prt_data_val);

   // go through all of the nets and find the training pattern
   // the pattern should start on quad edge boundary
   prt_chan_det_patt = '{default: 0};
   prt_data_ptr = '{default: 0};
   for (int net_id = 0; net_id < NUM_OF_NETS; net_id++) begin
      while ((prt_data_val[net_id][prt_data_ptr[net_id] +: 16] != TRAINING_PATTERN) && (prt_data_ptr[net_id] < (NUM_OF_TRANS_2_REC - 15)) ) begin
         prt_data_ptr[net_id] += 4;
      end
      if (prt_data_val[net_id][prt_data_ptr[net_id] +: 16] == TRAINING_PATTERN && (prt_data_ptr[net_id] < (NUM_OF_TRANS_2_REC - 15))) begin
           prt_chan_det_patt[net_id] = 1;
      end
   end  // for all nets

endtask : prt_chan_trn_chk



endmodule : diram4_port_model



//==============================================================================

module diram4_ram_model # (
  parameter DQ_WIDTH   = 32,
  parameter BANK_WIDTH = 5,
  parameter ROW_WIDTH  = 12,
  parameter COL_WIDTH  = 6,
  parameter CL_PER_PAGE  = 64,
  parameter BITS_PER_PAGE  = 4096,
  parameter BL = 2) (
  input                   clk,
  input                   cs_n,
  input                   cmd0,
  input                   cmd1,
  input  [ ROW_WIDTH-1:0] addr,
  input  [BANK_WIDTH-1:0] baddr,
  input  [  DQ_WIDTH-1:0] din,
  input  [  DQ_WIDTH/32-1:0] dinm,
  output [  DQ_WIDTH-1:0] dout,
  output                  rdstrb,
  output                  err_count,
  input                   prot_chk_en
);

timeunit 1ps;
timeprecision 1ps;

//---------------------------------------------------------------------------
// Local Parameter
//---------------------------------------------------------------------------
`include "diram4_ram_params.svh"
localparam BANK = (1 << BANK_WIDTH);
localparam IDX_BITS = BANK_WIDTH+ROW_WIDTH+(CL_PER_PAGE-1)*(COL_WIDTH);

localparam MEM_SIZE = (1 << IDX_BITS);

//---------------------------------------------------------------------------
// Declarations
//---------------------------------------------------------------------------

bit [BANK_WIDTH-1:0] wr_bank_addr;
bit [BANK_WIDTH-1:0] rd_bank_addr;
bit [ROW_WIDTH-1:0] row_addr [BANK-1:0];
    bit [CL_PER_PAGE-1:0] col_waddr;
    bit [CL_PER_PAGE-1:0] col_raddr;
bit refr,pc;
bit wr_en,wr_en_dly;
bit [2:0] rd_cnt;
bit [2:0] wr_cnt;
bit [2:0] wr_cnt_mem;
bit [2:0] rd_cnt_mem;
bit rd_en;
bit rd_en_dly,rd_en_dly2,rd_en_dly3;
bit rd_en_mem;
bit [63:0] rd_data     [DQ_WIDTH/32] ;
bit [63:0] rd_data_dly [DQ_WIDTH/32] ;
bit [63:0] rd_data_dly2[DQ_WIDTH/32] ;

// Note that each address points to 64 bit word
// and column address (lsb of index) is loaded from bit 2 upward

bit [(IDX_BITS-1):0] rd_idx;
bit [DQ_WIDTH-1:0] dout_r,dout_f;

bit [(IDX_BITS-1):0] wr_idx;
wire [63:0] wr_data      [DQ_WIDTH/32];
wire [1:0 ] wr_data_mask [DQ_WIDTH/32];
bit [DQ_WIDTH-1:0   ] wr_data_r     ,wr_data_f;
bit [DQ_WIDTH/32-1:0] wr_data_mask_r,wr_data_mask_f;
bit wrclk_dly;
bit rdclk_o;

//---------------------------------------------------------------------------
// Declarations used by protocol checker
//---------------------------------------------------------------------------

bit [11:0] page_addr;
bit  [5:0] cache_line_wr_addr;
bit  [5:0] cache_line_rd_addr;

int unsigned tCRCR;
int unsigned tCRCW;
int unsigned tCRPC;
int unsigned tCWCR;
int unsigned tCWCW;
int unsigned tCWPC;

time tc_PO_PO;
time tc_PO_CW;
time tc_PO_CW_aligned;
time tc_PO_CW_unaligned;
time tc_PO_CR;
time tc_PO_CR_aligned;
time tc_PO_CR_unaligned;
time tc_PO_PC;
time tc_PC_PO;
time tc_PC_PR;
time tc_PR_PO;
time tc_PR_PR;

time tc_PO_PC_adj;
time tc_PO_PR_adj;
time tc_PO_PO_adj;
time tc_PC_PO_adj;
time tc_PC_PR_adj;
time tc_PC_PC_adj;
time tc_PR_PC_adj;
time tc_PR_PO_adj;
time tc_PR_PR_adj;

int delta_PO_PO;
int delta_PO_CW;
int delta_PO_CR;
int delta_PO_PC;
int delta_PC_PO;
int delta_PC_PR;
int delta_PR_PO;
int delta_PR_PR;

int delta_PO_PC_adj;
int delta_PO_PR_adj;
int delta_PO_PO_adj;
int delta_PC_PO_adj;
int delta_PC_PR_adj;
int delta_PC_PC_adj;
int delta_PR_PC_adj;
int delta_PR_PO_adj;
int delta_PR_PR_adj;

int unsigned counter_CR_CR[BANK];
int unsigned counter_CR_CW[BANK];
int unsigned counter_CR_PC[BANK];
int unsigned counter_CW_CR[BANK];
int unsigned counter_CW_CW[BANK];
int unsigned counter_CW_PC[BANK];

time timer_PO_PO[BANK];
time timer_PO_CW[BANK];
time timer_PO_CR[BANK];
time timer_PO_PC[BANK];
time timer_PC_PO[BANK];
time timer_PC_PR[BANK];
time timer_PR_PO[BANK];
time timer_PR_PR[BANK];

fsm_state_e bank_state[BANK];

int debug_flag;
bit protocol_check_flag;

int stop_on_fatal_flag;

logic err_count_logic_p;
logic err_count_logic_n;

//---------------------------------------------------------------------------
// Capture write data on both edges of clock
//---------------------------------------------------------------------------
assign wrclk_dly = clk;

always@(posedge wrclk_dly) begin
  wr_data_r <= din;
  wr_data_mask_r <= dinm;
end
always@(negedge wrclk_dly) begin
  wr_data_f <= din;
  wr_data_mask_f <= dinm;
end

genvar gvi ;
generate
  for (gvi=0; gvi<DQ_WIDTH/32; gvi++)
    begin
      assign wr_data[gvi] = {wr_data_f[gvi*32+31:gvi*32],wr_data_r[gvi*32+31:gvi*32]};
    end
endgenerate
assign wr_data      = {wr_data_f     ,wr_data_r     };
assign wr_data_mask = {wr_data_mask_f,wr_data_mask_r};

//---------------------------------------------------------------------------
// Command decode and capture of row, column and bank addresses
//---------------------------------------------------------------------------

always@(posedge clk) begin

  if (!cmd1 && cmd0 && !cs_n) begin  // cmd1,0 = "01" refresh bank
    refr <= 1;
  end else if (cmd1 && !cmd0 && !cs_n) begin  // cmd1,0 = "10" PreCharge bank
    row_addr[baddr] <= 'b0;
    pc <= 1;
  end else if (cmd1 && cmd0 && !cs_n) begin  // cmd1,0 = "11" RAS 
    row_addr[baddr] <= addr[ROW_WIDTH-1:0];  //open row in bank
  end else begin
    pc <= 0;
    refr <= 0;
  end
end // always

if (CL_PER_PAGE > 1)
  begin
    always@(negedge clk) 
      begin
        if (cmd1 && cmd0 && !cs_n) 
          begin  // cmd1,0 = "11" CAW
            col_waddr <= addr[COL_WIDTH-1:0];
          end 
        else 
          begin
            col_waddr <= col_waddr;
          end
      end
  end

always@(negedge clk) 
  begin
    if (cmd1 && cmd0 && !cs_n) 
      begin  // cmd1,0 = "11" CAW
        wr_bank_addr <= baddr;
        wr_en <= 1;
      end 
    else 
      begin
      wr_bank_addr <= wr_bank_addr;
      if(wr_cnt== 3 || BL==2) 
        begin
          wr_en <= 0;
        end 
      else 
        begin
          wr_en <= wr_en;
        end
    end // if
  end // always
    
if (CL_PER_PAGE > 1)
  begin
    always@(negedge clk) 
      begin
        if (cmd1 && !cmd0 && !cs_n) 
          begin  // cmd1,0 = "10" CAR
            col_raddr <= addr[COL_WIDTH-1:0];
          end 
        else 
          begin
            col_raddr <= col_raddr;
          end // if
      end // always
  end

always@(negedge clk) 
  begin
    if (cmd1 && !cmd0 && !cs_n) 
      begin  // cmd1,0 = "10" CAR
        rd_bank_addr <= baddr;
        rd_en <= 1;
      end 
    else 
      begin
        rd_bank_addr <= rd_bank_addr;
        if(rd_cnt == 3 || BL==2) 
          begin
            rd_en <= 0;
          end 
        else 
          begin
            rd_en <= rd_en;
          end
      end // if
  end // always

//---------------------------------------------------------------------------
// RAM flat address/index
//---------------------------------------------------------------------------
if (CL_PER_PAGE > 1)
  begin
    assign wr_idx =   {wr_bank_addr,row_addr[wr_bank_addr],col_waddr[(COL_WIDTH-1):2]};
    assign rd_idx =   {rd_bank_addr,row_addr[rd_bank_addr],col_raddr[(COL_WIDTH-1):2]};
  end
else
  begin
    assign wr_idx =   {wr_bank_addr,row_addr[wr_bank_addr]};
    assign rd_idx =   {rd_bank_addr,row_addr[rd_bank_addr]};
  end

//---------------------------------------------------------------------------
// Write counter and ECC bit
//---------------------------------------------------------------------------
always@(posedge clk) begin
  wr_en_dly <= wr_en;

  if(wr_cnt== 3) begin
    wr_cnt <= 0;
  end else begin
    if(wr_en) begin
      wr_cnt <= wr_cnt + 1;
    end
  end

end

//---------------------------------------------------------------------------
// Read counter
//---------------------------------------------------------------------------
always@(posedge clk) begin
  if(rd_cnt== 3) begin
    rd_cnt <= 0;
  end else begin
    if(rd_en) begin
      rd_cnt <= rd_cnt + 1;
    end
  end
end

//---------------------------------------------------------------------------
// Instantiate RAM model
//---------------------------------------------------------------------------
assign rd_en_mem  = (BL==2) ? rd_en : (rd_en || rd_en_dly);
assign wr_en_mem  = (BL==2) ? wr_en : (wr_en || wr_en_dly);
if (CL_PER_PAGE > 1)
  begin
    assign wr_cnt_mem = (BL==2) ? col_waddr[1:0]: wr_cnt;
    assign rd_cnt_mem = (BL==2) ? col_raddr[1:0]: rd_cnt;
  end
else
  begin
    assign wr_cnt_mem = 0;
    assign rd_cnt_mem = 0;
  end

	diram4_ram_sparse #(
	  .BL(BL),
	  .MEM_SIZE(MEM_SIZE),
	  .DQ_WIDTH(DQ_WIDTH),
          .BANK_WIDTH(BANK_WIDTH),
          .ROW_WIDTH(ROW_WIDTH),
          .COL_WIDTH(COL_WIDTH),
          .CL_PER_PAGE(CL_PER_PAGE),
	  .IDX_BITS(IDX_BITS)) ram(
	  .clk(clk ),
	  .wr_en(wr_en_mem ),
	  .wr_idx(wr_idx ),
	  .wr_data(wr_data ),
	  .wr_data_mask(wr_data_mask ),
	  .wr_cnt(wr_cnt_mem),
	  .rd_en(rd_en_mem ),
	  .rd_idx(rd_idx ),
	  .rd_cnt(rd_cnt_mem ),
	  .rd_data(rd_data )
	  );

//---------------------------------------------------------------------------
// DDR read data generation
//---------------------------------------------------------------------------
always@(posedge clk) begin
  rd_en_dly <= rd_en;
  rd_en_dly2 <= rd_en_dly;
  rd_en_dly3 <= rd_en_dly2;
  rdclk_o <= rd_en_dly2 || rd_en_dly3;

  if (BL==2)
     rdclk_o <= rd_en_dly2;
  end

genvar m ;
generate
  for (m = 0; m < DQ_WIDTH/32; m++)
    begin
      always@(posedge clk) begin
        begin
          rd_data_dly  [m] <= rd_data     [m];
        end
    end
  end
endgenerate
generate
  for (m = 0; m < DQ_WIDTH/32; m++)
    begin
      always@(negedge clk) begin
        begin
          rd_data_dly2 [m] <= rd_data_dly [m];
        end
    end
  end
endgenerate

generate
  for (m = 0; m < DQ_WIDTH/32; m++)
    begin
      always@(posedge clk) begin
        begin
          dout_r [(m+1)*32-1:m*32] <= rd_data_dly2[m][31:0];
        end
    end
  end
endgenerate

generate
  for (m = 0; m < DQ_WIDTH/32; m++)
    begin
      always@(negedge clk) begin
        begin
          dout_f [(m+1)*32-1:m*32] <= rd_data_dly2[m][63:32];
        end
    end
  end
endgenerate

//---------------------------------------------------------------------------
// Outputs
//---------------------------------------------------------------------------
assign dout = clk ? dout_r : dout_f;
assign rdstrb = rdclk_o;

//---------------------------------------------------------------------------
// Rest of the code used by protocol checker...
//---------------------------------------------------------------------------

assign err_count = err_count_logic_p | err_count_logic_n;

initial begin

  if ($value$plusargs("DIRAM4_DEBUG_ON=%d", debug_flag)) begin
     $display(`mdl_info,
              $sformatf("(%0d) @ %0t: %m : Flag to Debug = %0d (from command line)",
              `__LINE__, $time, debug_flag));
  end else begin
    debug_flag = DEBUG_ON; // parameter as in diram4_ram_params.svh
                           // Default value 0
                           // 0: No Debug
                           // 1: Normal Debug
                           // 2: Verbose Debug
     $display(`mdl_info,
              $sformatf("(%0d) @ %0t: %m : Flag to Debug = %0d (from diram4_ram_params.svh)",
              `__LINE__, $time, debug_flag));
  end

  if ($test$plusargs("DIRAM4_PROT_CHK_OFF"))
    protocol_check_flag = 0;
  else
    protocol_check_flag = ~PROT_CHK_OFF; // parameter as in diram4_ram_params.svh

  if (protocol_check_flag == 1)
    $display(`mdl_info,
             $sformatf("(%0d) @ %0t: %m : DiRAM4 Protocol Check is ON",
             `__LINE__, $time));
  else
    $display(`mdl_info,
             $sformatf("(%0d) @ %0t: %m : DiRAM4 Protocol Check is OFF",
             `__LINE__, $time));

  if (protocol_check_flag == 1) begin

    err_count_logic_p = 0;
    err_count_logic_n = 0;

    stop_on_fatal_flag = 1; // Default
    stop_on_fatal_flag = STOP_ON_FATAL; // parameter as in diram4_ram_params.svh
    if (stop_on_fatal_flag != 0) begin
       stop_on_fatal_flag = 1;
       $display(`mdl_info,
                $sformatf("(%0d) @ %0t: %m : Simulation will stop after DiRAM4 Protocol Checker encounters FATAL (Default)",
                `__LINE__, $time));
    end else begin
       stop_on_fatal_flag = 0;
       $display(`mdl_info,
                $sformatf("(%0d) @ %0t: %m : Simulation will continue after DiRAM4 Protocol Checker encounters FATAL",
                `__LINE__, $time));
    end

    //-----------------------------------------------------
    // time based constraints (not clock based constraints)
    //-----------------------------------------------------
    tc_PO_PO = tPOPO;
    tc_PO_CW_aligned = tPOCWA;
    tc_PO_CW_unaligned = tPOCWU;
    tc_PO_CR_aligned = tPOCRA;
    tc_PO_CR_unaligned = tPOCRU;
    tc_PO_PC = tPOPC;
    tc_PC_PO = tPCPO;
    tc_PC_PR = tPCPR;
    tc_PR_PO = tPRPO;
    tc_PR_PR = tPRPR;

    //-----------------------------------------------------
    // time based constraints for ajacent bank check
    //-----------------------------------------------------
    tc_PO_PC_adj = tadjPOPC;
    tc_PO_PR_adj = tadjPOPR;
    tc_PO_PO_adj = tadjPOPO;
    tc_PC_PO_adj = tadjPCPO;
    tc_PC_PR_adj = tadjPCPR;
    tc_PC_PC_adj = tadjPCPC;
    tc_PR_PC_adj = tadjPRPC;
    tc_PR_PO_adj = tadjPRPO;
    tc_PR_PR_adj = tadjPRPR;

    //-----------------------------------------------------
    // clock count based constraints
    //-----------------------------------------------------
    if(BL == 8) begin
      tCRCR  = tCRCR8 ;
      tCRCW  = tCRCW8 ;
      tCRPC  = tCRPC8 ;
      tCWCR  = tCWCR8 ;
      tCWCW  = tCWCW8 ;
      tCWPC  = tCWPC8 ;
    end else  if(BL == 2) begin
      tCRCR  = tCRCR2 ;
      tCRCW  = tCRCW2 ;
      tCRPC  = tCRPC2 ;
      tCWCR  = tCWCR2 ;
      tCWCW  = tCWCW2 ;
      tCWPC  = tCWPC2 ;
    end else begin
      if (stop_on_fatal_flag) begin
        $display(`mdl_fatal,
                 $sformatf("(%0d) @ %0t: %m : Bad Configuration! BL = %0d. Stopped simulation!",
                 `__LINE__, $time, BL));
        $finish; //Stopping simulation
      end else begin
        $display(`mdl_error,
                 $sformatf("(%0d) @ %0t: %m : Bad Configuration! BL = %0d!!",
                 `__LINE__, $time, BL));
      end
    end

    //-----------------------------------------------------------------------
    // State machine, counter, timer initialization
    //-----------------------------------------------------------------------
    for (int ii = 0; ii < BANK; ii++) begin
      //---------------------------------------------------------------------
      // bank_state initialization
      //---------------------------------------------------------------------
      bank_state[ii] = PAGE_CLOSE; // All banks start from "PAGE_CLOSE" state

      //---------------------------------------------------------------------
      // Counter initialization
      //---------------------------------------------------------------------
      counter_CR_CR[ii]  = 0;
      counter_CR_CW[ii]  = 0;
      counter_CR_PC[ii]  = 0;
      counter_CW_CR[ii]  = 0;
      counter_CW_CW[ii]  = 0;
      counter_CW_PC[ii]  = 0;

      //---------------------------------------------------------------------
      // Timer initialization
      //---------------------------------------------------------------------
      timer_PO_PO[ii] = 0;
      timer_PO_CW[ii] = 0;
      timer_PO_CR[ii] = 0;
      timer_PO_PC[ii] = 0;
      timer_PC_PO[ii] = 0;
      timer_PC_PR[ii] = 0;
      timer_PR_PO[ii] = 0;
      timer_PR_PR[ii] = 0;
    end // for
  end // if (protocol_check_flag == 1) ...
end // initial

//---------------------------------------------------------------------------
// This always block captures commands on posedge of clk
//---------------------------------------------------------------------------
always@(posedge clk) begin
  if ((prot_chk_en == 1) && (protocol_check_flag == 1)) begin
    for (int jj = 0; jj < BANK; jj++) begin

      if (counter_CR_CR[jj] > 0) begin
        counter_CR_CR[jj]--;
        if (debug_flag >= 2)
          $display("DEBUG_p:%0t %m : counter_CR_CR[%0d] = %0d", $time, jj, counter_CR_CR[jj]);
      end

      if (counter_CR_CW[jj] > 0) begin
        counter_CR_CW[jj]--;
        if (debug_flag >= 2)
          $display("DEBUG_p:%0t %m : counter_CR_CW[%0d] = %0d", $time, jj, counter_CR_CW[jj]);
      end

      if (counter_CR_PC[jj] > 0) begin
        counter_CR_PC[jj]--;
        if (debug_flag >= 2)
          $display("DEBUG_p:%0t %m : counter_CR_PC[%0d] = %0d", $time, jj, counter_CR_PC[jj]);
      end

      if (counter_CW_CR[jj] > 0) begin
        counter_CW_CR[jj]--;
        if (debug_flag >= 2)
          $display("DEBUG_p:%0t %m : counter_CW_CR[%0d] = %0d", $time, jj, counter_CW_CR[jj]);
      end

      if (counter_CW_CW[jj] > 0) begin
        counter_CW_CW[jj]--;
        if (debug_flag >= 2)
          $display("DEBUG_p:%0t %m : counter_CW_CW[%0d] = %0d", $time, jj, counter_CW_CW[jj]);
      end

      if (counter_CW_PC[jj] > 0) begin
        counter_CW_PC[jj]--;
        if (debug_flag >= 2)
          $display("DEBUG_p:%0t %m : counter_CW_PC[%0d] = %0d", $time, jj, counter_CW_PC[jj]);
      end
    end // for

    //---------------------------------------------------------------------------
    // Page Operations:-           cmd1, cmd0  : Description
    // (sensitive to posedge)         0     0  | No-Op
    //                                0     1  | PR : Page Refresh
    //                                1     0  | PC : Page Close
    //                                1     1  | PO : Page Open
    //---------------------------------------------------------------------------

    if (~cs_n) begin

      page_addr = addr;
      if ((cmd1 == 0) && (cmd0 == 1)) begin  // cmd1,0 = "01" refresh bank
        if (debug_flag >= 1)
          $display("DEBUG:@%0t %m: Command is PR: Page Refresh - for bank=%0d (0x%0h), page=%0d (0x%0h)",
                   $time, baddr, baddr, page_addr, page_addr);
      end else if ((cmd1 == 1) && (cmd0 == 0)) begin  // cmd1,0 = "10" PreCharge bank or Page Close
        if (debug_flag >= 1)
          $display("DEBUG:@%0t %m: Command is PC: Page Close - for bank=%0d (0x%0h), page=%0d (0x%0h)",
                   $time, baddr, baddr, page_addr, page_addr);
      end else if ((cmd1 == 1) && (cmd0 == 1)) begin  // cmd1,0 = "11" RAS or Page Open
        if (debug_flag >= 1)
          $display("DEBUG:@%0t %m: Command is PO: Page Open - for bank=%0d (0x%0h), page=%0d (0x%0h)",
                   $time, baddr, baddr, page_addr, page_addr);
      end // if

      if (debug_flag >= 2)
          $display("DEBUG:@%0t %m:line %0d:present bank_state[%0d] = %s, cmd1=%b, cmd0=%b",
                    $time, `__LINE__, baddr, bank_state[baddr].name, cmd1, cmd0);

      if (bank_state[baddr] == PAGE_CLOSE) begin
        if ((cmd1 == 0) && (cmd0 == 1)) begin // 2'b01 is PR for PAGE_REFRESH
          bank_state[baddr] = PAGE_REFRESH;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          delta_PC_PR = $time - timer_PC_PR[baddr];
          if(tc_PC_PR > delta_PC_PR) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Close to Page Refresh violation in bank=%0d: min tPCPR is %0d ps, observed %0d ps",
                      `__LINE__, $time, baddr, tc_PC_PR, delta_PC_PR));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Close to Page Refresh violation in bank=%0d: min tPCPR is %0d ps, observed %0d ps",
                      $time, baddr, tc_PC_PR, delta_PC_PR);
          end // if
          timer_PR_PO[baddr] = $time;
          timer_PR_PR[baddr] = $time;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: timer_PR_PO[%0d] = %0d", $time, baddr, timer_PR_PO[baddr]);
            $display("DEBUG:@%0t %m: timer_PR_PR[%0d] = %0d", $time, baddr, timer_PR_PR[baddr]);
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is PO for PAGE_OPEN
          bank_state[baddr] = PAGE_OPEN;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          delta_PC_PO = $time - timer_PC_PO[baddr];
          if(tc_PC_PO > delta_PC_PO) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Close to Page Open violation in bank=%0d: min tPCPO is %0d ps, observed %0d ps",
                      `__LINE__, $time, baddr, tc_PC_PO, delta_PC_PO));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Close to Page Open violation in bank=%0d: min tPCPO is %0d ps, observed %0d ps",
                      $time, baddr, tc_PC_PO, delta_PC_PO);
          end // if
          timer_PO_PO[baddr] = $time;
          timer_PO_CW[baddr] = $time;
          timer_PO_CR[baddr] = $time;
          timer_PO_PC[baddr] = $time;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: timer_PO_CW[%0d] = %0d", $time, baddr, timer_PO_CW[baddr]);
            $display("DEBUG:@%0t %m: timer_PO_CR[%0d] = %0d", $time, baddr, timer_PO_CR[baddr]);
            $display("DEBUG:@%0t %m: timer_PO_PC[%0d] = %0d", $time, baddr, timer_PO_PC[baddr]);
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is PC for PAGE_CLOSE
          //No state change, just timer refresh
          //It is OK if we issue repeated PAGE_CLOSE to the same bank, doesn't break anything.
          bank_state[baddr] = PAGE_CLOSE;
          if (debug_flag >= 2)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          timer_PC_PO[baddr] = $time;
          timer_PC_PR[baddr] = $time;
          if (debug_flag >= 2)
            $display("DEBUG:@%0t %m: timer_PC_PR[%0d] = %0d", $time, baddr, timer_PC_PR[baddr]);
        end // if
      end else if (bank_state[baddr] == PAGE_OPEN) begin
        if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is PC for PAGE_CLOSE
          bank_state[baddr] = PAGE_CLOSE;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          delta_PO_PC = $time - timer_PO_PC[baddr];
          if(tc_PO_PC > delta_PO_PC) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Open to Page Close violation in bank=%0d: min tPOPC is %0d ps, observed %0d ps",
                      `__LINE__, $time, baddr, tc_PO_PC, delta_PO_PC));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Open to Page Close violation in bank=%0d: min tPOPC is %0d ps, observed %0d ps",
                      $time, baddr, tc_PO_PC, delta_PO_PC);
          end // if
          timer_PC_PO[baddr] = $time;
          timer_PC_PR[baddr] = $time;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: timer_PC_PO[%0d] = %0d", $time, baddr, timer_PC_PO[baddr]);
            $display("DEBUG:@%0t %m: timer_PC_PR[%0d] = %0d", $time, baddr, timer_PC_PR[baddr]);
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is PO for PAGE_OPEN
          //No state change, just timer refresh
          bank_state[baddr] = PAGE_OPEN;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          delta_PO_PO = $time - timer_PO_PO[baddr];
          if(tc_PO_PO > delta_PO_PO) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Open to Page Open violation in bank=%0d: min tPOPO is %0d ps, observed %0d ps",
                      `__LINE__, $time, baddr, tc_PO_PO, delta_PO_PO));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Open to Page Open violation in bank=%0d: min tPOPO is %0d ps, observed %0d ps",
                      $time, baddr, tc_PO_PO, delta_PO_PO);
          end // if
          timer_PO_PO[baddr] = $time;
          timer_PO_CW[baddr] = $time;
          timer_PO_CR[baddr] = $time;
          timer_PO_PC[baddr] = $time;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: timer_PO_PO[%0d] = %0d", $time, baddr, timer_PO_PO[baddr]);
            $display("DEBUG:@%0t %m: timer_PO_CW[%0d] = %0d", $time, baddr, timer_PO_CW[baddr]);
            $display("DEBUG:@%0t %m: timer_PO_CR[%0d] = %0d", $time, baddr, timer_PO_CR[baddr]);
            $display("DEBUG:@%0t %m: timer_PO_PC[%0d] = %0d", $time, baddr, timer_PO_PC[baddr]);
          end // if
        end else if ((cmd1 == 0) && (cmd0 == 1)) begin // 2'b01 is PR for PAGE_REFRESH
          if (stop_on_fatal_flag) begin
            $display(`mdl_fatal,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_REFRESH when the Page is OPEN! bank_state[%0d] = %s. Stopped simulation!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
            $finish; //Stopping simulation
          end else begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_REFRESH when the Page is OPEN! bank_state[%0d] = %s!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
          end // if
        end // if
      end else if (bank_state[baddr] == PAGE_REFRESH) begin
        if ((cmd1 == 0) && (cmd0 == 1)) begin // 2'b01 is PR for PAGE_REFRESH
          //No state change, just timer refresh
          bank_state[baddr] = PAGE_REFRESH;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          delta_PR_PR = $time - timer_PR_PR[baddr];
          if(tc_PR_PR > delta_PR_PR) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Refresh to Page Refresh violation in bank=%0d: min tPRPR is %0d ps, observed %0d ps",
                      `__LINE__, $time, baddr, tc_PR_PR, delta_PR_PR));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Refresh to Page Refresh violation in bank=%0d: min tPRPR is %0d ps, observed %0d ps",
                      $time, baddr, tc_PR_PR, delta_PR_PR);
          end // if
          timer_PR_PO[baddr] = $time;
          timer_PR_PR[baddr] = $time;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: timer_PR_PO[%0d] = %0d", $time, baddr, timer_PR_PO[baddr]);
            $display("DEBUG:@%0t %m: timer_PR_PR[%0d] = %0d", $time, baddr, timer_PR_PR[baddr]);
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is PO for PAGE_OPEN
          bank_state[baddr] = PAGE_OPEN;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          delta_PR_PO = $time - timer_PR_PO[baddr];
          if(tc_PR_PO > delta_PR_PO) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Refresh to Page Open violation in bank=%0d: min tPRPO is %0d ps, observed %0d ps",
                      `__LINE__, $time, baddr, tc_PR_PO, delta_PR_PO));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Refresh to Page Open violation in bank=%0d: min tPRPO is %0d ps, observed %0d ps",
                      $time, baddr, tc_PR_PO, delta_PR_PO);
          end // if
          timer_PO_PO[baddr] = $time;
          timer_PO_CW[baddr] = $time;
          timer_PO_CR[baddr] = $time;
          timer_PO_PC[baddr] = $time;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: timer_PO_CW[%0d] = %0d", $time, baddr, timer_PO_CW[baddr]);
            $display("DEBUG:@%0t %m: timer_PO_CR[%0d] = %0d", $time, baddr, timer_PO_CR[baddr]);
            $display("DEBUG:@%0t %m: timer_PO_PC[%0d] = %0d", $time, baddr, timer_PO_PC[baddr]);
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is PC for PAGE_CLOSE
          if (stop_on_fatal_flag) begin
            $display(`mdl_fatal,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_CLOSE when the Page is NOT OPEN! bank_state[%0d] = %s. Stopped simulation!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
            $finish; //Stopping simulation
          end else begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_CLOSE when the Page is NOT OPEN! bank_state[%0d] = %s!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
          end // if
        end // if
      end else if (bank_state[baddr] == CACHE_READ) begin
        if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is PC for PAGE_CLOSE
          bank_state[baddr] = PAGE_CLOSE;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          if(counter_CR_PC[baddr] > 0) begin
            err_count_logic_p = 1;
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cache Read to Page Close violation in bank=%0d, min tCRPC%1d is %0d cycles, observed %0d cycles",
                     `__LINE__, $time, baddr, BL, tCRPC, tCRPC-counter_CR_PC[baddr]));
          end else if (debug_flag >= 1) begin
            $display("CHECK:@%0t %m: No Cache Read to Page Close violation in bank=%0d, min tCRPC%1d is %0d cycles, counter_CR_PC = %0d",
                     $time, baddr, BL, tCRPC, counter_CR_PC[baddr]);
          end // if
          timer_PC_PO[baddr] = $time;
          timer_PC_PR[baddr] = $time;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: timer_PC_PO[%0d] = %0d", $time, baddr, timer_PC_PO[baddr]);
            $display("DEBUG:@%0t %m: timer_PC_PR[%0d] = %0d", $time, baddr, timer_PC_PR[baddr]);
          end // if
        end else if ((cmd1 == 0) && (cmd0 == 1)) begin // 2'b01 is PR for PAGE_REFRESH
          if (stop_on_fatal_flag) begin
            $display(`mdl_fatal,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_REFRESH when the Cache is being READ! bank_state[%0d] = %s. Stopped simulation!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
            $finish; //Stopping simulation
          end else begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_REFRESH when the Cache is being READ! bank_state[%0d] = %s!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is PO for PAGE_OPEN
          if (stop_on_fatal_flag) begin
            $display(`mdl_fatal,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_OPEN when the Cache is being READ! bank_state[%0d] = %s. Stopped simulation!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
            $finish; //Stopping simulation
          end else begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_OPEN when the Cache is being READ! bank_state[%0d] = %s!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
          end // if
        end
      end else if (bank_state[baddr] == CACHE_WRITE) begin
        if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is PC for PAGE_CLOSE
          bank_state[baddr] = PAGE_CLOSE;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          if(counter_CW_PC[baddr] > 0) begin
            err_count_logic_p = 1;
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cache Write to Page Close violation in bank=%0d, min tCWPC%1d is %0d cycles, observed %0d cycles",
                     `__LINE__, $time, baddr, BL, tCWPC, tCWPC-counter_CW_PC[baddr]));
          end else if (debug_flag >= 1) begin
            $display("CHECK:@%0t %m: No Cache Write to Page Close violation in bank=%0d, min tCWPC%1d is %0d cycles, counter_CW_PC = %0d",
                      $time, baddr, BL, tCWPC, counter_CW_PC[baddr]);
          end // if
          timer_PC_PO[baddr] = $time;
          timer_PC_PR[baddr] = $time;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: timer_PC_PO[%0d] = %0d", $time, baddr, timer_PC_PO[baddr]);
            $display("DEBUG:@%0t %m: timer_PC_PR[%0d] = %0d", $time, baddr, timer_PC_PR[baddr]);
          end // if
        end else if ((cmd1 == 0) && (cmd0 == 1)) begin // 2'b01 is PR for PAGE_REFRESH
          if (stop_on_fatal_flag) begin
            $display(`mdl_fatal,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_REFRESH when the Cache is being WRITTEN! bank_state[%0d] = %s. Stopped simulation!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
            $finish; //Stopping simulation
          end else begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_REFRESH when the Cache is being WRITTEN! bank_state[%0d] = %s!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is PO for PAGE_OPEN
          if (stop_on_fatal_flag) begin
            $display(`mdl_fatal,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_OPEN when the Cache is being WRITTEN! bank_state[%0d] = %s. Stopped simulation!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
            $finish; //Stopping simulation
          end else begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cannot PAGE_OPEN when the Cache is being WRITTEN! bank_state[%0d] = %s!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
          end // if
        end
      end // if
      if (debug_flag >= 2)
        $display("DEBUG:@%0t %m: line %0d:next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
    end // if (~cs_n)

    // -------------------------- Adjacent bank checks --------------------------
    // We perform these checks twice:-
    // First for left adjacent bank.
    // Then again for right adjacent bank.
    //---------------------------------------------------------------------------

    for (int nn = 0; nn < 2; nn++) begin
       int adj_bank;

       if (!nn)
          adj_bank = get_left_adj_bank(baddr);
       else
          adj_bank = get_right_adj_bank(baddr);

       if (adj_bank == -1)
          continue; // skip the rest of the code if NO valid adjacent bank,
                    // either left_adj_bank or right_adj_bank

       if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is PC for PAGE_CLOSE
          // see if it violates tadjPOPC or tadjPRPC or tadjPCPC,
          // i.e. if the adjacent bank was in PAGE_OPEN or PAGE_REFRESH or PAGE_CLOSE state

          delta_PO_PC_adj = $time - timer_PO_PC[adj_bank];
          if (tc_PO_PC_adj > delta_PO_PC_adj) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Open to Page Close adj_bank=%0d violation in bank=%0d: min tadjPOPC is %0d ps, observed %0d ps",
                      `__LINE__, $time, adj_bank, baddr, tc_PO_PC_adj, delta_PO_PC_adj));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Open to Page Close adj_bank=%0d violation in bank=%0d: min tadjPOPC is %0d ps, observed %0d ps",
                      $time, adj_bank, baddr, tc_PO_PC_adj, delta_PO_PC_adj);
          end

          delta_PR_PC_adj = $time - timer_PR_PO[adj_bank];
          if (tc_PR_PC_adj > delta_PR_PC_adj) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Refresh to Page Close adj_bank=%0d violation in bank=%0d: min tadjPRPC is %0d ps, observed %0d ps",
                      `__LINE__, $time, adj_bank, baddr, tc_PR_PC_adj, delta_PR_PC_adj));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Refresh to Page Close adj_bank=%0d violation in bank=%0d: min tadjPRPC is %0d ps, observed %0d ps",
                      $time, adj_bank, baddr, tc_PR_PC_adj, delta_PR_PC_adj);
          end

          delta_PC_PC_adj = $time - timer_PC_PR[adj_bank];
          if (tc_PC_PC_adj > delta_PC_PC_adj) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Close to Page Close adj_bank=%0d violation in bank=%0d: min tadjPCPC is %0d ps, observed %0d ps",
                      `__LINE__, $time, adj_bank, baddr, tc_PC_PC_adj, delta_PC_PC_adj));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Close to Page Close adj_bank=%0d violation in bank=%0d: min tadjPCPC is %0d ps, observed %0d ps",
                      $time, adj_bank, baddr, tc_PC_PC_adj, delta_PC_PC_adj);
          end
       end else if ((cmd1 == 0) && (cmd0 == 1)) begin // 2'b01 is PR for PAGE_REFRESH
          // see if it violates tadjPCPR or tadjPOPR or tadjPRPR,
          // i.e. if the adjacent bank was in PAGE_CLOSE or PAGE_OPEN state or PAGE_REFRESH state

          delta_PC_PR_adj = $time - timer_PC_PR[adj_bank];
          if (tc_PC_PR_adj > delta_PC_PR_adj) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Close to Page Refresh adj_bank=%0d violation in bank=%0d: min tadjPCPR is %0d ps, observed %0d ps",
                      `__LINE__, $time, adj_bank, baddr, tc_PC_PR_adj, delta_PC_PR_adj));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Close to Page Refresh adj_bank=%0d violation in bank=%0d: min tadjPCPR is %0d ps, observed %0d ps",
                      $time, adj_bank, baddr, tc_PC_PR_adj, delta_PC_PR_adj);
          end

          delta_PO_PR_adj = $time - timer_PO_PC[adj_bank];
          if (tc_PO_PR_adj > delta_PO_PR_adj) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Open to Page Refresh adj_bank=%0d violation in bank=%0d: min tadjPOPR is %0d ps, observed %0d ps",
                      `__LINE__, $time, adj_bank, baddr, tc_PO_PR_adj, delta_PO_PR_adj));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Open to Page Refresh adj_bank=%0d violation in bank=%0d: min tadjPOPR is %0d ps, observed %0d ps",
                      $time, adj_bank, baddr, tc_PO_PR_adj, delta_PO_PR_adj);
          end

          delta_PR_PR_adj = $time - timer_PR_PO[adj_bank];
          if (tc_PR_PR_adj > delta_PR_PR_adj) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Refresh to Page Refresh adj_bank=%0d violation in bank=%0d: min tadjPRPR is %0d ps, observed %0d ps",
                      `__LINE__, $time, adj_bank, baddr, tc_PR_PR_adj, delta_PR_PR_adj));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Refresh to Page Refresh adj_bank=%0d violation in bank=%0d: min tadjPRPR is %0d ps, observed %0d ps",
                      $time, adj_bank, baddr, tc_PR_PR_adj, delta_PR_PR_adj);
          end
       end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is PO for PAGE_OPEN
          // see if it violates tadjPCPO or tadjPRPO or tadjPOPO,
          // i.e. if the adjacent bank was in PAGE_CLOSE or PAGE_REFRESH or PAGE_OPEN state

          delta_PC_PO_adj = $time - timer_PC_PR[adj_bank];
          if (tc_PC_PO_adj > delta_PC_PO_adj) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Close to Page Open adj_bank=%0d violation in bank=%0d: min tadjPCPO is %0d ps, observed %0d ps",
                      `__LINE__, $time, adj_bank, baddr, tc_PC_PO_adj, delta_PC_PO_adj));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Close to Page Open adj_bank=%0d violation in bank=%0d: min tadjPCPO is %0d ps, observed %0d ps",
                      $time, adj_bank, baddr, tc_PC_PO_adj, delta_PC_PO_adj);
          end

          delta_PR_PO_adj = $time - timer_PR_PO[adj_bank];
          if (tc_PR_PO_adj > delta_PR_PO_adj) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Refresh to Page Open adj_bank=%0d violation in bank=%0d: min tadjPRPO is %0d ps, observed %0d ps",
                      `__LINE__, $time, adj_bank, baddr, tc_PR_PO_adj, delta_PR_PO_adj));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Refresh to Page Open adj_bank=%0d violation in bank=%0d: min tadjPRPO is %0d ps, observed %0d ps",
                      $time, adj_bank, baddr, tc_PR_PO_adj, delta_PR_PO_adj);
          end

          delta_PO_PO_adj = $time - timer_PO_PC[adj_bank];
          if (tc_PO_PO_adj > delta_PO_PO_adj) begin
             err_count_logic_p = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Page Open to Page Open adj_bank=%0d violation in bank=%0d: min tadjPOPO is %0d ps, observed %0d ps",
                      `__LINE__, $time, adj_bank, baddr, tc_PO_PO_adj, delta_PO_PO_adj));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Page Open to Page Open adj_bank=%0d violation in bank=%0d: min tadjPOPO is %0d ps, observed %0d ps",
                      $time, adj_bank, baddr, tc_PO_PO_adj, delta_PO_PO_adj);
          end
       end

    end // for

    if (err_count_logic_n == 1)
      err_count_logic_n = 0;
  end // if ((prot_chk_en == 1) && (protocol_check_flag == 1)) ...
end // always

//---------------------------------------------------------------------------
// This always block captures commands on negedge of clk
//---------------------------------------------------------------------------
always@(negedge clk) begin
  if ((prot_chk_en == 1) && (protocol_check_flag == 1)) begin
    for (int kk = 0; kk < BANK; kk++) begin

      if (counter_CR_CR[kk] > 0) begin
        counter_CR_CR[kk]--;
        if (debug_flag >= 2)
          $display("DEBUG_n:%0t %m : counter_CR_CR[%0d] = %0d", $time, kk, counter_CR_CR[kk]);
      end

      if (counter_CR_CW[kk] > 0) begin
        counter_CR_CW[kk]--;
        if (debug_flag >= 2)
          $display("DEBUG_n:%0t %m : counter_CR_CW[%0d] = %0d", $time, kk, counter_CR_CW[kk]);
      end

      if (counter_CR_PC[kk] > 0) begin
        counter_CR_PC[kk]--;
        if (debug_flag >= 2)
          $display("DEBUG_n:%0t %m : counter_CR_PC[%0d] = %0d", $time, kk, counter_CR_PC[kk]);
      end

      if (counter_CW_CR[kk] > 0) begin
        counter_CW_CR[kk]--;
        if (debug_flag >= 2)
          $display("DEBUG_n:%0t %m : counter_CW_CR[%0d] = %0d", $time, kk, counter_CW_CR[kk]);
      end

      if (counter_CW_CW[kk] > 0) begin
        counter_CW_CW[kk]--;
        if (debug_flag >= 2)
          $display("DEBUG_n:%0t %m : counter_CW_CW[%0d] = %0d", $time, kk, counter_CW_CW[kk]);
      end

      if (counter_CW_PC[kk] > 0) begin
        counter_CW_PC[kk]--;
        if (debug_flag >= 2)
          $display("DEBUG_n:%0t %m : counter_CW_PC[%0d] = %0d", $time, kk, counter_CW_PC[kk]);
      end
    end // for

    //---------------------------------------------------------------------------
    // Read/Write from/to cache:-  cmd1, cmd0  : Description
    // (sensitive to negedge)         1     0  | CR : Cache Read
    //                                1     1  | CW : Cache Write
    //---------------------------------------------------------------------------

    if (~cs_n) begin
      if ((cmd1 == 1) && (cmd0 == 1)) begin  // cmd1,0 = "11" CAW
        cache_line_wr_addr = addr[5:0]; // Only lower 6-bits will be used
        if (debug_flag >= 1)
          $display("DEBUG:@%0t %m: Command is CW: Cache Write - for bank=%0d (0x%0h), cache_line_wr_addr=%0d (0x%0h)",
                   $time, baddr, baddr, cache_line_wr_addr, cache_line_wr_addr);
      end // if

      if ((cmd1 == 1) && (cmd0 == 0)) begin  // cmd1,0 = "10" CAR
        cache_line_rd_addr = addr[5:0]; // Only lower 6-bits will be used
        if (debug_flag >= 1)
          $display("DEBUG:@%0t %m: Command is CR: Cache Read - for bank=%0d (0x%0h), cache_line_rd_addr=%0d (0x%0h)",
                   $time, baddr, baddr, cache_line_rd_addr, cache_line_rd_addr);
      end // if

      if (debug_flag >= 2)
          $display("DEBUG:@%0t %m:line %0d:present bank_state[%0d] = %s, cmd1=%b, cmd0=%b",
                    $time, `__LINE__, baddr, bank_state[baddr].name, cmd1, cmd0);

      if (bank_state[baddr] == PAGE_OPEN) begin
        if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is CR for CACHE_READ
          bank_state[baddr] = CACHE_READ;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          delta_PO_CR = $time - timer_PO_CR[baddr];

          if((BL == 2) && (cache_line_rd_addr[1:0] != 2'b00)) begin // check if it is an unaligned address in BL_2 mode
            tc_PO_CR = tc_PO_CR_unaligned;
            if (debug_flag >= 1)
              $display("DEBUG:@%0t %m: Unaligned Cache Read at bank=%0d (0x%0h), cache_line_rd_addr=%0d (0x%2h), BL=%1d",
                       $time, baddr, baddr, cache_line_rd_addr, cache_line_rd_addr, BL);
            if(tc_PO_CR > delta_PO_CR) begin
              err_count_logic_n = 1;
              $display(`mdl_error,
                       $sformatf("(%0d) @ %0t: %m : Page Open to Cache Read (unaligned) violation in bank=%0d: min tPOCRU is %0d ps, observed %0d ps",
                       `__LINE__, $time, baddr, tc_PO_CR, delta_PO_CR));
            end else if (debug_flag >= 1) begin
              $display("CHECK:@%0t %m: No Page Open to Cache Read (unaligned) violation in bank=%0d: min tPOCRU is %0d ps, observed %0d ps",
                       $time, baddr, tc_PO_CR, delta_PO_CR);
            end
          end else begin // now it is either aligned address in BL_2 mode or BL_8 mode
            tc_PO_CR = tc_PO_CR_aligned;
            if (debug_flag >= 1)
              $display("DEBUG:@%0t %m: Aligned Cache Read at bank=%0d (0x%0h), cache_line_rd_addr=%0d (0x%2h), BL=%1d",
                       $time, baddr, baddr, cache_line_rd_addr, cache_line_rd_addr, BL);
            if(tc_PO_CR > delta_PO_CR) begin
              err_count_logic_n = 1;
              $display(`mdl_error,
                       $sformatf("(%0d) @ %0t: %m : Page Open to Cache Read (aligned) violation in bank=%0d: min tPOCRA is %0d ps, observed %0d ps",
                       `__LINE__, $time, baddr, tc_PO_CR, delta_PO_CR));
            end else if (debug_flag >= 1) begin
              $display("CHECK:@%0t %m: No Page Open to Cache Read (aligned) violation in bank=%0d: min tPOCRA is %0d ps, observed %0d ps",
                       $time, baddr, tc_PO_CR, delta_PO_CR);
            end // if
          end // if
          counter_CR_CR[baddr] = tCRCR;
          counter_CR_CW[baddr] = tCRCW;
          counter_CR_PC[baddr] = tCRPC;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: counter_CR_CR[%0d] = %0d", $time, baddr, counter_CR_CR[baddr]);
            $display("DEBUG:@%0t %m: counter_CR_CW[%0d] = %0d", $time, baddr, counter_CR_CW[baddr]);
            $display("DEBUG:@%0t %m: counter_CR_PC[%0d] = %0d", $time, baddr, counter_CR_PC[baddr]);
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is CW for CACHE_WRITE
          bank_state[baddr] = CACHE_WRITE;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          delta_PO_CW = $time - timer_PO_CW[baddr];

          if((BL == 2) && (cache_line_wr_addr[1:0] != 2'b00)) begin // check if it is an unaligned address in BL_2 mode
            tc_PO_CW = tc_PO_CW_unaligned;
            if (debug_flag >= 1)
              $display("DEBUG:@%0t %m: Unaligned Cache Write at bank=%0d (0x%0h), cache_line_wr_addr=%0d (0x%2h), BL=%1d",
                       $time, baddr, baddr, cache_line_wr_addr, cache_line_wr_addr, BL);
            if(tc_PO_CW > delta_PO_CW) begin
              err_count_logic_n = 1;
              $display(`mdl_error,
                       $sformatf("(%0d) @ %0t: %m : Page Open to Cache Write (unaligned) violation in bank=%0d: min tPOCWU is %0d ps, observed %0d ps",
                       `__LINE__, $time, baddr, tc_PO_CW, delta_PO_CW));
            end else if (debug_flag >= 1) begin
              $display("CHECK:@%0t %m: No Page Open to Cache Write (unaligned) violation in bank=%0d: min tPOCWU is %0d ps, observed %0d ps",
                       $time, baddr, tc_PO_CW, delta_PO_CW);
            end
          end else begin // now it is either aligned address in BL_2 mode or BL_8 mode
            tc_PO_CW = tc_PO_CW_aligned;
            if (debug_flag >= 1)
              $display("DEBUG:@%0t %m: Aligned Cache Write at bank=%0d (0x%0h), cache_line_wr_addr=%0d (0x%2h), BL=%1d",
                       $time, baddr, baddr, cache_line_wr_addr, cache_line_wr_addr, BL);
            if(tc_PO_CW > delta_PO_CW) begin
              err_count_logic_n = 1;
              $display(`mdl_error,
                       $sformatf("(%0d) @ %0t: %m : Page Open to Cache Write (aligned) violation in bank=%0d: min tPOCWA is %0d ps, observed %0d ps",
                       `__LINE__, $time, baddr, tc_PO_CW, delta_PO_CW));
            end else if (debug_flag >= 1) begin
              $display("CHECK:@%0t %m: No Page Open to Cache Write (aligned) violation in bank=%0d: min tPOCWA is %0d ps, observed %0d ps",
                       $time, baddr, tc_PO_CW, delta_PO_CW);
            end // if
          end // if
          counter_CW_CR[baddr] = tCWCR;
          counter_CW_CW[baddr] = tCWCW;
          counter_CW_PC[baddr] = tCWPC;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: counter_CW_CR[%0d] = %0d", $time, baddr, counter_CW_CR[baddr]);
            $display("DEBUG:@%0t %m: counter_CW_CW[%0d] = %0d", $time, baddr, counter_CW_CW[baddr]);
            $display("DEBUG:@%0t %m: counter_CW_PC[%0d] = %0d", $time, baddr, counter_CW_PC[baddr]);
          end // if
        end // if
      end else if ((bank_state[baddr] == PAGE_CLOSE) ||
                   (bank_state[baddr] == PAGE_REFRESH)) begin
        if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is CR for CACHE_READ
          if (stop_on_fatal_flag) begin
            $display(`mdl_fatal,
                     $sformatf("(%0d) @ %0t: %m : cannot read cache as page is closed! bank_state[%0d] = %s. Stopped simulation!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
            $finish; //Stopping simulation
          end else begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : cannot read cache as page is closed! bank_state[%0d] = %s!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is CW for CACHE_WRITE
          if (stop_on_fatal_flag) begin
            $display(`mdl_fatal,
                     $sformatf("(%0d) @ %0t: %m : cannot write cache as page is closed! bank_state[%0d] = %s. Stopped simulation!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
            $finish; //Stopping simulation
          end else begin
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : cannot write cache as page is closed! bank_state[%0d] = %s!",
                     `__LINE__, $time, baddr, bank_state[baddr].name));
          end // if
        end // if
      end else if (bank_state[baddr] == CACHE_READ) begin
        if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is CR for CACHE_READ
          bank_state[baddr] = CACHE_READ;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          if(counter_CR_CR[baddr] > 0) begin
            err_count_logic_n = 1;
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cache Read to Cache Read violation in bank=%0d, min tCRCR%1d is %0d cycles, observed %0d cycles",
                     `__LINE__, $time, baddr, BL, tCRCR, tCRCR-counter_CR_CR[baddr]));
          end else if (debug_flag >= 1) begin
            $display("CHECK:@%0t %m: No Cache Read to Cache Read violation in bank=%0d, min tCRCR%1d is %0d cycles, counter_CR_CR = %0d",
                     $time, baddr, BL, tCRCR, counter_CR_CR[baddr]);
          end // if
          counter_CR_CR[baddr] = tCRCR;
          counter_CR_CW[baddr] = tCRCW;
          counter_CR_PC[baddr] = tCRPC;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: counter_CR_CR[%0d] = %0d", $time, baddr, counter_CR_CR[baddr]);
            $display("DEBUG:@%0t %m: counter_CR_CW[%0d] = %0d", $time, baddr, counter_CR_CW[baddr]);
            $display("DEBUG:@%0t %m: counter_CR_PC[%0d] = %0d", $time, baddr, counter_CR_PC[baddr]);
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is CW for CACHE_WRITE
          bank_state[baddr] = CACHE_WRITE;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          if(counter_CR_CW[baddr] > 0) begin
            err_count_logic_n = 1;
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cache Read to Cache Write violation in bank=%0d, min tCRCW%1d is %0d cycles, observed %0d cycles",
                     `__LINE__, $time, baddr, BL, tCRCW, tCRCW-counter_CR_CW[baddr]));
          end else if (debug_flag >= 1) begin
            $display("CHECK:@%0t %m: No Cache Read to Cache Write violation in bank=%0d, min tCRCW%1d is %0d cycles, counter_CR_CW = %0d",
                     $time, baddr, BL, tCRCW, counter_CR_CW[baddr]);
          end // if
          counter_CW_CR[baddr] = tCWCR;
          counter_CW_CW[baddr] = tCWCW;
          counter_CW_PC[baddr] = tCWPC;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: counter_CW_CR[%0d] = %0d", $time, baddr, counter_CW_CR[baddr]);
            $display("DEBUG:@%0t %m: counter_CW_CW[%0d] = %0d", $time, baddr, counter_CW_CW[baddr]);
            $display("DEBUG:@%0t %m: counter_CW_PC[%0d] = %0d", $time, baddr, counter_CW_PC[baddr]);
          end // if
        end // if
      end else if (bank_state[baddr] == CACHE_WRITE) begin
        if ((cmd1 == 1) && (cmd0 == 0)) begin // 2'b10 is CR for CACHE_READ
          bank_state[baddr] = CACHE_READ;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          if(counter_CW_CR[baddr] > 0) begin
            err_count_logic_n = 1;
            $display(`mdl_error,
                     $sformatf("(%0d) @ %0t: %m : Cache Write to Cache Read violation in bank=%0d, min tCWCR%1d is %0d cycles, observed %0d cycles",
                     `__LINE__, $time, baddr, BL, tCWCR, tCWCR-counter_CW_CR[baddr]));
          end else if (debug_flag >= 1) begin
            $display("CHECK:@%0t %m: No Cache Write to Cache Read violation in bank=%0d, min tCWCR%1d is %0d cycles, counter_CW_CR = %0d",
                     $time, baddr, BL, tCWCR, counter_CW_CR[baddr]);
          end // if
          counter_CR_CR[baddr] = tCRCR;
          counter_CR_CW[baddr] = tCRCW;
          counter_CR_PC[baddr] = tCRPC;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: counter_CR_CR[%0d] = %0d", $time, baddr, counter_CR_CR[baddr]);
            $display("DEBUG:@%0t %m: counter_CR_CW[%0d] = %0d", $time, baddr, counter_CR_CW[baddr]);
            $display("DEBUG:@%0t %m: counter_CR_PC[%0d] = %0d", $time, baddr, counter_CR_PC[baddr]);
          end // if
        end else if ((cmd1 == 1) && (cmd0 == 1)) begin // 2'b11 is CW for CACHE_WRITE
          bank_state[baddr] = CACHE_WRITE;
          if (debug_flag >= 1)
            $display("DEBUG:@%0t %m:line %0d: next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
          if(counter_CW_CW[baddr] > 0) begin
             err_count_logic_n = 1;
             $display(`mdl_error,
                      $sformatf("(%0d) @ %0t: %m : Cache Write to Cache Write violation in bank=%0d, min tCWCW%1d is %0d cycles, observed %0d cycles",
                      `__LINE__, $time, baddr, BL, tCWCW, tCWCW-counter_CW_CW[baddr]));
          end else if (debug_flag >= 1) begin
             $display("CHECK:@%0t %m: No Cache Write to Cache Write violation in bank=%0d, min tCWCW%1d is %0d cycles, counter_CW_CW = %0d",
                      $time, baddr, BL, tCWCW, counter_CW_CW[baddr]);
          end // if
          counter_CW_CR[baddr] = tCWCR;
          counter_CW_CW[baddr] = tCWCW;
          counter_CW_PC[baddr] = tCWPC;
          if (debug_flag >= 1) begin
            $display("DEBUG:@%0t %m: counter_CW_CR[%0d] = %0d", $time, baddr, counter_CW_CR[baddr]);
            $display("DEBUG:@%0t %m: counter_CW_CW[%0d] = %0d", $time, baddr, counter_CW_CW[baddr]);
            $display("DEBUG:@%0t %m: counter_CW_PC[%0d] = %0d", $time, baddr, counter_CW_PC[baddr]);
          end // if
        end // if 
      end // if
      if (debug_flag >= 2)
        $display("DEBUG:@%0t %m: line %0d:next bank_state[%0d] = %s", $time, `__LINE__, baddr, bank_state[baddr].name);
    end // if

    if (err_count_logic_p == 1)
      err_count_logic_p = 0;
  end // if ((prot_chk_en == 1) && (protocol_check_flag == 1)) ...
end // always

//---------------------------------------------------------------------------
// This function returns the left adjacent bank address
// (which is one less than the given bank address).
// If the left bank address is not valid, it returns a '-1'
//---------------------------------------------------------------------------
function int get_left_adj_bank (int bank_addr);
   if ((bank_addr <= 0) ||
       (bank_addr == 16) ||
       (bank_addr >= 32))
      return -1; // no valid adjacent bank
   else
      return (bank_addr - 1);
endfunction : get_left_adj_bank

//---------------------------------------------------------------------------
// This function returns the right adjacent bank address
// (which is one more than the given bank address).
// If the right bank address is not valid, it returns a '-1'
//---------------------------------------------------------------------------
function int get_right_adj_bank (int bank_addr);
   if ((bank_addr < 0) ||
       (bank_addr == 15) ||
       (bank_addr >= 31))
      return -1; // no valid adjacent bank
   else
      return (bank_addr + 1);
endfunction : get_right_adj_bank

endmodule : diram4_ram_model



//==============================================================================

module diram4_ram_sparse #(
  parameter BL=2 ,
  parameter MEM_SIZE = 16,
  parameter DQ_WIDTH = 32,
  parameter BANK_WIDTH = 5,
  parameter ROW_WIDTH  = 12,
  parameter COL_WIDTH  = 6,
  parameter CL_PER_PAGE  = 64,
  parameter BITS_PER_PAGE  = 4096,
  parameter IDX_BITS = 4) (
  input clk,
  input wr_en,
  input [IDX_BITS-1:0] wr_idx,
  input [63:0] wr_data      [DQ_WIDTH/32],
  input [1:0 ] wr_data_mask [DQ_WIDTH/32],
  input [2:0] wr_cnt,
  input rd_en,
  input [IDX_BITS-1:0] rd_idx,
  input [2:0] rd_cnt,
  output bit [63:0] rd_data [DQ_WIDTH/32]
);

timeunit 1ps;
timeprecision 1ps;

localparam NUM_WORDS_PER_INTF_MSB  = $clog2(DQ_WIDTH/32)-1;
localparam WORDS_PER_PAGE = $clog2(BITS_PER_PAGE)-5;

//---------------------------------------------------------------------------
// Declarations
//---------------------------------------------------------------------------
//

// Memory array
bit [31:0] mem [DQ_WIDTH/32] [BL] [int] ;
initial
  begin
    for (int m = 0; m < DQ_WIDTH/32; m++)
      begin
        mem[m][0]  = '{default: 0};
        mem[m][1]  = '{default: 0};
      end
  end

bit sparse_mem_debug = 0; // Default value 0
                          // 0: No Debug
                          // 1: Normal Debug

//---------------------------------------------------------------------------
// Write the memory
//---------------------------------------------------------------------------
always@(posedge clk) begin
  if(wr_en) begin
    case (wr_cnt)
      0: 
        begin
          for (int m = 0; m < DQ_WIDTH/32; m++)
            begin
              if (wr_data_mask[m][0] == 1)
                mem[m][0][wr_idx]  = wr_data[m][31: 0];
              if (wr_data_mask[m][1] == 1)
                mem[m][1][wr_idx]  = wr_data[m][63:32];
            end
        end
    endcase

    if (sparse_mem_debug)
      for (int m = 0; m < DQ_WIDTH/32; m++)
        begin
          $display("DEBUG:@%0t %m:\tWrite: wr_en=%0d, wr_cnt=%0d, wr_idx=0x%6x, wr_data=0x%16x",
                $time, wr_en, wr_cnt, wr_idx, wr_data[m]);
        end
  end // if(wr_en)...
end // always

//---------------------------------------------------------------------------
// Read the memory array
//---------------------------------------------------------------------------
always@(posedge clk) begin
  if(rd_en) begin
    case (rd_cnt)
      0:
        begin
          for (int m = 0; m < DQ_WIDTH/32; m++)
            begin
              rd_data[m][31: 0] <= mem[m][0][rd_idx];
              rd_data[m][63:32] <= mem[m][1][rd_idx];
            end
        end
    endcase

    if (sparse_mem_debug)
      for (int m = 0; m < DQ_WIDTH/32; m++)
        begin
          $display("DEBUG:@%0t %m:\tRead : rd_en=%0d, rd_cnt=%0d, rd_idx=0x%6x, rd_data=0x%16x",
                $time, rd_en, rd_cnt, rd_idx, rd_data[m]);
        end
  end // if(rd_en)...
end // always

//---------------------------------------------------------------------------
// External configuration
//---------------------------------------------------------------------------

function void testFn();
endfunction

bit [BANK_WIDTH-1:0     ] config_bank_addr ;
bit [ROW_WIDTH-1:0      ] config_row_addr  ;
bit [WORDS_PER_PAGE-1:0 ] config_word_addr ;
bit [IDX_BITS-1:0       ] config_index     ;
bit [32-1:0             ] config_data      ;

assign config_index =   {config_bank_addr,config_row_addr};

  bit                                 config_burst      ;
  bit [NUM_WORDS_PER_INTF_MSB:0]      config_intf_word  ;  // word in a burst
  bit                                 config_load       ;

  assign config_burst      = (config_word_addr > 63);
  assign config_intf_word  =  config_word_addr%64;

  genvar m ;
  generate
    for (m = 0; m < DQ_WIDTH/32; m++)
      begin
        always @(posedge config_load)
          begin
            if (m == config_intf_word)
              begin
                mem[m][config_burst][config_index]  = config_data ;
              end
          end
      end
  endgenerate

endmodule : diram4_ram_sparse

//==============================================================================
module prot_chkr_error_counter (
  input count_r,
  input count_f
);

timeunit 1ps;
timeprecision 1ps;

//---------------------------------------------------------------------------
// Local Parameter
//---------------------------------------------------------------------------
`include "diram4_ram_params.svh"

int stop_on_error_count_r;
int stop_on_error_count_f;
int max_error_count;

initial begin
   max_error_count = 0; // Default
   max_error_count = STOP_ON_ERROR; // parameter as in diram4_ram_params.svh
   if (max_error_count == 0) begin
      max_error_count = 0;
      $display(`mdl_info,
               $sformatf("(%0d) @ %0t: %m : Simulation continues after DiRAM4 Protocol Checker encounters ERROR (Default)",
               `__LINE__, $time));
   end else begin
      $display(`mdl_info,
               $sformatf("(%0d) @ %0t: %m : Simulation stops after DiRAM4 Protocol Checker encounters %0d ERRORs",
               `__LINE__, $time, max_error_count));
   end
end // initial

always@(posedge count_r) begin
   stop_on_error_count_r++;
   if ((stop_on_error_count_r + stop_on_error_count_f) <= max_error_count) begin
      $display(`mdl_error,
               $sformatf("(%0d) @ %0t: %m : current_count = %0d, max_count = %0d",
               `__LINE__, $time, stop_on_error_count_r + stop_on_error_count_f, max_error_count));
      if ((stop_on_error_count_r + stop_on_error_count_f) == max_error_count) begin
         $display(`mdl_error,
                  $sformatf("(%0d) @ %0t: %m : Reached max_error_count = %0d. Stopped simulation!",
                  `__LINE__, $time, max_error_count));
         $finish; //Stopping simulation
      end // if
   end // if
end // always

always@(posedge count_f) begin
   stop_on_error_count_f++;
   if ((stop_on_error_count_r + stop_on_error_count_f) <= max_error_count) begin
      $display(`mdl_error,
               $sformatf("(%0d) @ %0t: %m : current_count = %0d, max_count = %0d",
               `__LINE__, $time, stop_on_error_count_r + stop_on_error_count_f, max_error_count));
      if ((stop_on_error_count_r + stop_on_error_count_f) == max_error_count) begin
         $display(`mdl_error,
                  $sformatf("(%0d) @ %0t: %m : Reached max_error_count = %0d. Stopped simulation!",
                  `__LINE__, $time, max_error_count));
         $finish; //Stopping simulation
      end // if
   end // if
end // always

endmodule : prot_chkr_error_counter
//==============================================================================
//                                  THE END
//==============================================================================
