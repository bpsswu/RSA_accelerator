/*
	module name 	: mod_exp
	@ input			: num_a, num_b, modulus
	@ output		: me_out
	@ description	: me_out = (num_a * num_b) % modulus
*/
module mod_exp(
	clk, rstn, len, modulus);


input clk, rstn;
input [7:0] len;
input [31:0] modulus;


wire [31:0] mm_1_out, mm_2_out;
wire ld_1_end, ld_2_end, mm_1_end, mm_2_end;
wire mm_1_start;

assign mm_1_start = ld_1_end & ld_2_end; // 롱디비전이 어케 작동할지 몰라서 일단은 AND 연결해놓음. 더 복잡해질 수 있음.

/*
uint64_t Z1 = long_div(A, N, len);
uint64_t Z2 = long_div(B, N, len);
long_div ld_1 ();
long_div ld_2 ();
*/
mont_mult mm_1 (clk, rstn, ld_2_end, len, /*num_1*/, /*num_2*/, modulus, mm_1_end, mm_1_out);
mont_mult mm_2 (clk, rstn, mm_1_end, len, mm_1_out, 32'b1, modulus, mm_2_end, mm_2_out);

endmodule
