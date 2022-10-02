module main (
	input[31:0] b,
	input[31:0] e,
	input[31:0] m,
	output[31:0] r
);
	wire r;
	assign r = (b**e) % m;
endmodule
