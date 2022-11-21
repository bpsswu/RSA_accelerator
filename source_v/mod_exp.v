module mod_exp(clk, rstn, en, A, B, N, len, out);

input clk, rstn;
input [31:0] A, B, N, len;
output [31:0] out;

wire [31:0] out;
wire 
wire [31:0] Z1, Z2, Z3;

MM inst_0 (clk, rstn, en, A, R**2, N, Z1);
MM inst_1 ();
MM inst_2 (clk, rstn, res_buf_1, res_buf_2, N, res_buf_3);
MM inst_3 (clk, rstn, res_buf_3, 1, N, out);

endmodule

module MM(clk, rstn, en, A, B, N, Z, module_end);
