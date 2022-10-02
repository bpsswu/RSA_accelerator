module main (
	input CLK,
	input nRST,
	input[15:0] b,
	input[15:0] e,
	input[15:0] m,
	output[15:0] r
);
	reg r;

	always @(posedge CLK or negedge nRST) begin
		if (!nRST) begin
			r <= 0;
		end
		else begin
			r <= (b**e) % m;
		end
	end
endmodule
