/*
	TEST BENCH (long_div)
*/
`timescale 1ns/1ns

module long_div_tb;

reg clk, rstn, md_start;
reg [7:0] len;
reg [31:0] num_in, modulus;
wire md_end;
wire [31:0] ld_out;

long_div ld_tb (clk, rstn, md_start, len, num_in, modulus, md_end, ld_out);

initial clk = 0; always #5 clk = ~clk;

initial begin
	#0 rstn = 0;
	#10 rstn = 1;
end

initial begin
	#0	md_start = 0; len = 27; num_in = 12345; modulus = 128255609;
	#15	md_start = 1;
	#5	md_start = 0;
	#2500
	$display("-----------------------------------------");
	$display("long_div result = %d", ld_out);
	$display("-----------------------------------------");
	$stop;
end

endmodule
