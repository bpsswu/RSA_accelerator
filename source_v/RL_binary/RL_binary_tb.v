/*
	TEST BENCH (RL_binary)
*/
`timescale 1ns/1ns

module RL_binary_tb;

reg clk, rstn, md_start;
reg [31:0] base, exp, modulus;
wire [31:0] r;

RL_binary inst_tb (
	clk, rstn, md_start, base, exp, modulus,
	r);

initial clk = 0; always #5 clk = ~clk;

initial begin
	#0 rstn = 0;
	#10 rstn = 1;
end

initial begin
	#0	md_start = 0; base = 52525252; exp = 17; modulus = 128255609;
	#15	md_start = 1;
	#10	md_start = 0;
	#160000
	$display("-----------------------------------------");
	$display("Input Message = %d", base);
	$display("Cipher Text = %d", r);
	$display("-----------------------------------------");
	
	#0	md_start = 0; base = r; exp = 75431153; modulus = 128255609;
	#15	md_start = 1;
	#15	md_start = 0;
	
	#220000
	$display("-----------------------------------------");
	$display("Cipher Text = %d", base);
	$display("Plain Text = %d", r);
	$display("-----------------------------------------");
	
	$stop;
end

endmodule