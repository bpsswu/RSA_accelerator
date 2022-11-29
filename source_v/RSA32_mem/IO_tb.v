/*
	TEST BENCH (IO)
*/
`timescale 1ns/1ns

module IO_tb;

reg clk, rstn, md_start_push;
wire good, bad;

IO inst_tb (
	clk, rstn, md_start_push,
	good, bad);

initial clk = 0; always #5 clk = ~clk;

initial begin
	#0 rstn = 0;
	#10 rstn = 1;
end

initial begin
	#0		md_start_push = 0;
	#300	md_start_push = 1;
	#2700	md_start_push = 0;
	#160000
	$stop;
end

endmodule