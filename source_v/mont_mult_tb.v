/*
	TEST BENCH (mont_mult)
*/
`timescale 1ns/1ns

module mont_mult_tb;

reg clk, rstn, sig_start;
reg [7:0] len;
reg [31:0] num_1, num_2, modulus;
wire module_end;
wire [31:0] mm_out;

mont_mult inst_0 (clk, rstn, sig_start, len, num_1, num_2, modulus, 
					module_end, mm_out);

initial clk = 0; always #5 clk = ~clk;

initial begin
	#0 rstn = 0;
	#10 rstn = 1;
end

initial begin
	#0		sig_start = 0; len = 27; num_1 = 67676767; num_2 = 52525252; modulus = 128255609;
	#15		sig_start = 1;
	#5		sig_start = 0;
	#1000
	$display("MM(%d, %d) = %d", num_1, num_2, mm_out);
	$stop;
end

endmodule
