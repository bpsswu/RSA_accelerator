/*
	module name 	: mod_exp
	@ input			: num_a, num_b, modulus
	@ output		: mm_2_out
	@ description	: mm_2_out = (num_a * num_b) % modulus
*/
module mod_exp(
	clk, rstn, md_start, len, num_a, num_b, modulus,
	mm_2_out, mm_2_end);
// md_start = trigger signal to start the mod_exp module
// len = length of N (modulus)
// mm_2_end = Signal notifying the termination of the mod_exp module

input clk, rstn, md_start;
input [7:0] len;
input [31:0] num_a, num_b, modulus;
output [31:0] mm_2_out;
output mm_2_end;

wire [31:0] ld_1_out, ld_2_out, mm_1_out, mm_2_out;
wire ld_1_end, ld_2_end, mm_1_end, mm_2_end;
reg ch_1, ch_2, mm_1_start;

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		ch_1 <= 0;
		ch_2 <= 0;
		mm_1_start <= 0;
	end
	else begin
	
		if (ld_1_end == 1) begin
			ch_1 <= 1;
		end
		if (ld_2_end == 1) begin
			ch_2 <= 1;
		end
		if (mm_1_start == 1) begin
			ch_1 <= 0;
			ch_2 <= 0;
		end
		mm_1_start <= ch_1 & ch_2;
	end
end

long_div ld_1 (clk, rstn, md_start, len, num_a, modulus, ld_1_end, ld_1_out);
long_div ld_2 (clk, rstn, md_start, len, num_b, modulus, ld_2_end, ld_2_out);
mont_mult mm_1 (clk, rstn, mm_1_start, len, ld_1_out, ld_2_out, modulus, mm_1_end, mm_1_out);
mont_mult mm_2 (clk, rstn, mm_1_end, len, mm_1_out, 32'b1, modulus, mm_2_end, mm_2_out);

endmodule