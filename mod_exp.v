module mod_exp (
	input[31:0] b,
	input[31:0] e,
	input[31:0] m,
	output[31:0] r
);
	wire r;
	
	wire [31:0]pow_be;

	assign pow_be = b**e;
	assign r = pow_be % m;
endmodule
