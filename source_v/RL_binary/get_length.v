/*
	module name 	: get_length
	@ input			: num_in
	@ output		: len_out
	@ description	: len_out = length of num_in (ex: 1001 => 4)
*/
module get_length(
	clk, rstn, md_start, num_in, 
	len_out, md_end);

input clk, rstn, md_start;
input [63:0] num_in;
output [7:0] len_out;
output md_end;

reg md_end;
reg [7:0] len_out;
reg [63:0] num;
reg [7:0] i;
reg enable;
wire trig;

assign trig = md_start | md_end;

always @ (posedge trig or negedge rstn) begin
	if (!rstn) begin
		enable <= 0;
	end
	else begin
		enable <= ~(enable);
	end
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		md_end <= 0;
		len_out <= -1;
		i <= 0;
		num <= 0;
	end
	else if (enable) begin
		
		if (md_start) begin
			i <= 0;
		end
	
		if (i == 0) begin
			num <= num_in;
			if (num & 1) begin
				len_out <= 0;
			end
			i <= i + 1;
		end
		else if (i < 64) begin
			num <= (num >> 1);
			if (num & 1) begin
				len_out <= i;
			end
			i <= i + 1;
		end
		else if (i == 64) begin
			md_end <= 1;
			i <= i + 1;
		end
	end
	else if (i == 65) begin
		md_end <= 0;
		i <= i + 1;
	end
end

endmodule