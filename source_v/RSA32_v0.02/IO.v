/*
	module name 	: IO
	@ input			: rstn, write, oe, data
	@ output		: data
	@ description	: encryption test
*/
module IO(
	clk, rstn, write, oe, data,
	led_rstn, led_write, led_oe, IO_end, comp1, comp2, comp3, comp4, counter_1);
	
input clk, rstn, write, oe;
inout [31:0] data;
output wire led_rstn, led_write, led_oe;
output reg IO_end;

output [3:0] counter_1;

output wire comp1, comp2, comp3, comp4;
assign comp1 = (base == 32'h0321_78C4) ? 1 : 0;
assign comp2 = (exponent == 32'h0000_0011) ? 1 : 0;
assign comp3 = (modulus == 32'h07A5_0679) ? 1 : 0;
assign comp4 = (result == 32'h007D_C743) ? 1 : 0;

assign data = oe ? result : 32'bz;
assign led_rstn = rstn;
assign led_write = write;
assign led_oe = oe;

reg [31:0] base, exponent, modulus, result;
reg [3:0] counter_1, counter_2;
reg rsa_start;
wire [31:0] rsa_out;
wire write_p, rsa_end;

ltp inst_btn (
	clk, rstn, write,
	write_p);

RL_binary inst_rsa (
	clk, rstn, rsa_start, base, exponent, modulus,
	rsa_end, rsa_out);

always @ (posedge write_p or negedge rstn) begin
	if (!rstn) begin
		base		<= 0;
		exponent	<= 0;
		modulus		<= 0;
		counter_1	<= 0;
	end
	else begin
		if (counter_1 == 0) begin
			counter_1 <= counter_1 + 1;
			base <= data;
		end
		else if (counter_1 == 1) begin
			counter_1 <= counter_1 + 1;
			exponent <= data;
		end
		else if (counter_1 == 2) begin
			counter_1 <= counter_1 + 1;
			modulus <= data;
		end
		else if (counter_1 == 3) begin
			counter_1 <= counter_1 + 1;
		end
	end
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		rsa_start	<= 0;
		counter_2	<= 0;
		IO_end		<= 0;
		result		<= 0;
	end
	else begin
		if (counter_1 == 4 && counter_2 == 0) begin
			rsa_start <= 1;
			counter_2 <= counter_2 + 1;
		end
		
		if (counter_2 == 1) begin
			rsa_start <= 0;
			counter_2 <= counter_2 + 1;
		end
		
		if (rsa_end) begin
			result <= rsa_out;
			IO_end <= 1;
		end
	end
end

endmodule