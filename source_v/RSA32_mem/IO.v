/*
	module name 	: IO
	@ input			: rstn, md_start_push (Push Button)
	@ output		: good(green led), bad(red led)
	@ description	: encryption test
*/
module IO(
	clk, rstn, md_start_push,
	debug1, debug2, debug3, good, bad);
	
input clk, rstn, md_start_push;
output debug1, debug2, debug3, good, bad;

reg good, bad;
reg [31:0] base, exp, modulus;
wire rsa_end;
wire [31:0] r;
wire md_start;
wire debug1, debug2, debug3;
assign debug1 = rstn;
assign debug2 = md_start_push;
assign debug3 = ~md_start_push;

ltp inst_btn (
	clk, rstn, debug3,
	md_start);

RL_binary inst_rsa (
	clk, rstn, md_start, base, exp, modulus,
	rsa_end, r);

// Value Initialization
always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		base <= 52525252;
		exp <= 17;
		modulus <= 128255609;
	end
	else begin
		base <= 52525252;
		exp <= 17;
		modulus <= 128255609;
	end
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		good <= 0;
		bad <= 0;
	end
	else begin
		
		if (rsa_end) begin
			if (r == 8243011) begin
				good <= 1;
			end
			else begin
				bad <= 1;
			end
		end
		
	end
end

endmodule