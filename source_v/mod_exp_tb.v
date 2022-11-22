/*
	TEST BENCH (mod_exp)
*/
`timescale 1ns/1ns

module mod_exp_tb;

reg clk, rstn, md_start;
reg [7:0] len;
reg [31:0] num_a, num_b, modulus;
wire [31:0] mm_2_out;
wire mm_2_end;

mod_exp inst_tb (clk, rstn, md_start, len, num_a, num_b, modulus, mm_2_out, mm_2_end);

initial clk = 0; always #5 clk = ~clk;

initial begin
	#0 rstn = 0;
	#10 rstn = 1;
end

initial begin
	#0		md_start = 0; len = 27; num_a = 67676767; num_b = 52525252; modulus = 128255609;
	#15		md_start = 1;
	#10		md_start = 0;
	#6000
	$display("-------------------------------------");
	$display("modulus = %d", modulus);
	$display("mod_exp(%d, %d) = %d", num_a, num_b, mm_2_out);
	$display("-------------------------------------");
	$stop;
end

endmodule
