module mod_exp(clk, rstn, en, A, B, N, len, out);

input clk, rstn, en;
input [31:0] A, B, N, len;
output [31:0] out;

wire [31:0] out;
wire [31:0] Z1, Z2, Z3;
wire end1, end2, end3, end4;

wire [31:0] R;
assign R = 2 ** len;

MM inst_0 (clk, rstn, en, A, R**2, N, Z1, end1);
MM inst_1 (clk, rstn, en, B, R**2, N, Z2, end2);
MM inst_2 (clk, rstn, end1 & end2, Z1, Z2, N, Z3, end3);
MM inst_3 (clk, rstn, end3, Z3, 1, N, out, end4);

endmodule
