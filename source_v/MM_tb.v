`timescale 1ns/1ns
`include "MM.v"

module MM_tb;
reg clk, rstn;
reg [31:0] A, B, N;
wire [31:0] Z;

MM inst_0 (clk, rstn, A, B, N, Z);

initial clk = 0;
always #5 clk = ~clk;

initial begin
	$dumpfile("MM_tb.vcd");
	$dumpvars(0, MM_tb);
	#0
	rstn = 0;
	A = 75431153;
	B = 52525252;
	N = 128255609;
	#7
	rstn = 1;
	#500
	$stop;
end
	
endmodule
