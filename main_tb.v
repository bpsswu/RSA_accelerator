`timescale 1ns/1ns
`include "main.v"

module main_tb;

reg CLK;
reg nRST;
reg[15:0] b;
reg[15:0] e;
reg[15:0] m;
wire[15:0] r;

main dut_0 (CLK, nRST, b, e, m, r);


initial CLK = 1;
always #5 CLK = ~CLK;

initial begin
	$dumpfile("main_tb.vcd");
	$dumpvars(0, main_tb);
	#0 nRST = 0;
	#10 nRST = 1;
	b = 435;
	e = 23;
	m = 494;
	#50 
	$display("Test Complete");
	$stop;
end

endmodule


