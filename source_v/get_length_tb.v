`timescale 1ns/1ns

module get_length_tb;

reg clk, rstn, en;
reg [63:0] in;
wire [31:0] length;
wire module_end;

get_length inst_0 (clk, rstn, en, in, length, module_end);

initial clk = 0;
always #5 clk = ~clk;

initial begin
	#0
	rstn = 0;
	en = 0;
	in = 12345;
	#7
	rstn = 1;
	#20
	en = 1;
	#750
	$stop;
end

endmodule
