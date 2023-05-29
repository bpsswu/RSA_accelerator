/*
	module name 	: IO
	@ input			: rstn, write, oe, data
	@ output		: data
	@ description	: Interface module with Arduino Mega board
*/
module IO(
	clk, rstn, write, oe, data,
	IO_end);
	
input clk, rstn, write, oe;
inout [31:0] data;
output reg IO_end;

assign data = oe ? result : 32'bz;

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

// “base, exp, mod” are input three times each from the outside.
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

// Indicates the start and end of an RSA operation.
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
			counter_1 <= 0;
			counter_2 <= 0;
			result <= rsa_out;
			IO_end <= 1;
		end
	end
end

endmodule