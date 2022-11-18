module get_length(clk, rstn, en, in, length, module_end);

input clk, rstn, en;
input [63:0] in;
output [31:0] length;
output module_end;

integer i;

reg module_end;
reg [31:0] length;
reg [63:0] data;

always @ (posedge clk or negedge rstn) begin
   if (!rstn) begin
		length <= -1;
		i <= 0;
		data <= in;
		module_end <= 0;
   end
   else if (en) begin
		if (i == 0) begin
			if (data & 1) begin
				length <= 0;
				i <= i + 1;
			end
		end
		else if (i < 64) begin
			data <= data >> 1;
			if (data & 1) begin
				length <= i;
			end
			i <= i + 1;
		end
		else if (i == 64) begin
			module_end <= 1;
			i <= i + 1;
		end
	end
end

endmodule
