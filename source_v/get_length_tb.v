`timescale 1ns/1ns

module get_length_tb;

reg clk, rstn;
reg [63:0] in;
wire [31:0] length;

get_length inst_0 (clk, rstn, in, length);

initial clk = 0;
always #5 clk = ~clk;

initial begin
	#0
	rstn = 0;
	in = 12345;
	#7
	rstn = 1;
	#500
	$stop;
end

endmodule
