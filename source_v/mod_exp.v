// long_div, MM 모듈을 dummy 모듈로 제작 후,
// 컴파일해 본 결과, 컴파일은 잘 되었습니다.
// 문법 오류는 없는 듯 합니다.

/*
	input value = A, B, N, len
	output value = out (=AB mod N)
*/
module mod_exp(clk, rstn, A, B, N, len, out);

input clk, rstn;
input [31:0] A, B, N, len;
output [31:0] out;

wire [31:0] out;

wire [31:0] res_buf_1, res_buf_2, res_buf_3;

long_div inst_0 (clk, rstn, A, N, len, res_buf_1);
long_div inst_1 (clk, rstn, B, N, len, res_buf_2);
MM inst_2 (clk, rstn, res_buf_1, res_buf_2, N, res_buf_3);
MM inst_3 (clk, rstn, res_buf_3, 1, N, out);

endmodule
