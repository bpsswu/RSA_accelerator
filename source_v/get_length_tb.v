/*
	TEST BENCH (get_length)
*/
`timescale 1ns/1ns

module get_length_tb;

reg clk, rstn, md_start;
reg [63:0] num_in;
wire [7:0] len_out;
wire md_end;

get_length inst_0 (clk, rstn, md_start, num_in, len_out, md_end);

initial clk = 0; always #5 clk = ~clk;

initial begin
	#0 rstn = 0;
	#10 rstn = 1;
end

initial begin
	#0	md_start = 0; num_in = 128255609;
	#15	md_start = 1;
	#5	md_start = 0;
	#1000
	$display("-------------------------------------");
	$display("num = %d", num_in);
	$display("length of num = %d", len_out);
	$display("-------------------------------------");
	$stop;
end

endmodule
