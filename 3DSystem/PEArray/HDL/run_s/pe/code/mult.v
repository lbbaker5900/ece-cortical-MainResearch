
    // synopsys translate_off
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_mult.v"

     //synopsys translate_on

module mult( clock, inst_a, inst_b, inst_rnd, inst_op, z_inst, status_inst);

// 32-bit
parameter sig_width = 23;
parameter exp_width = 8;
// 64-bit
//parameter sig_width = 52;
//parameter exp_width = 11;
parameter ieee_compliance = 0;

input clock;
input [sig_width+exp_width : 0] inst_a;
input [sig_width+exp_width : 0] inst_b;
input [2 : 0] inst_rnd;
input inst_op;
output [sig_width+exp_width : 0] z_inst;
output [7 : 0] status_inst;

reg [sig_width+exp_width : 0] z_inst;
wire [sig_width+exp_width : 0] z;

reg [7 : 0] status_inst;
wire [7 : 0] status;


always@(posedge clock)
begin
    z_inst<=z;
    status_inst<=status;
end

    // Instance of DW_fp_mult
    DW_fp_mult #(sig_width, 
                 exp_width, 
                 ieee_compliance)
    DW_fp_mult0 ( .a     ( inst_a   ), 
                  .b     ( inst_b   ), 
                  .rnd   ( inst_rnd ), 
                  .z     ( z        ), 
                  .status( status   ));


endmodule
