// 아직 컴파일은 못 해본 버전입니다

/*
	input value = A, B, N, len
	output value = out (=AB mod N)
*/
module mod_exp(clk, rstn, A, B, N, len, out);

input clk, rstn;
input [31:0] A, B, N, len;
output [31:0] out;

reg [31:0] out;

reg [31:0] res_buf_1, res_buf_2, res_buf_3;

long_div inst_0 (clk, rstn, A, N, len, res_buf_1);
long_div inst_1 (clk, rstn, B, N, len, res_buf_2);
MM inst_2 (clk, rstn, res_buf_1, res_buf_2, N, res_buf_3);
MM inst_3 (clk, rstn, res_buf_3, 1, N, out);

endmodule
