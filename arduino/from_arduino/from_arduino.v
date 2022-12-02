/*
	(FPGA board <-> Arduino board) Interface Test
*/
module from_arduino (
	clk, rstn, data, write, oe,
	rstn_led, write_led, oe_led, comp1, comp2, comp3, data_out_led);
	
input			clk, rstn, write, oe;
inout [31:0]	data;
output			rstn_led, write_led, oe_led, comp1, comp2, comp3;
output [15:0]	data_out_led;

wire rstn_led, write_led, comp1, comp2, comp3;
wire [15:0] data_out_led;

reg [31:0] register_1, register_2, register_3, register_4;
reg [3:0] counter;

assign data = oe ? register_4 : 32'bz;
assign rstn_led = rstn;
assign write_led = write;
assign oe_led = oe;
assign comp1 = (register_1 == 32'h0321_78C4) ? 1 : 0;
assign comp2 = (register_2 == 32'h0000_0011) ? 1 : 0;
assign comp3 = (register_3 == 32'h07A5_0679) ? 1 : 0;
assign data_out_led = data[15:0];

always @ (posedge write or negedge rstn) begin
	if (!rstn) begin
		register_1 <= 0;
		register_2 <= 0;
		register_3 <= 0;
		register_4 <= 0;
		counter <= 0;
	end
	else begin
		if (counter == 0) begin
			counter <= counter + 1;
		end
		else if (counter == 1) begin
			register_1 <= data;
			counter <= counter + 1;
		end
		else if (counter == 2) begin
			register_2 <= data;
			counter <= counter + 1;
		end
		else if (counter == 3) begin
			register_3 <= data;
			counter <= counter + 1;
		end
		else if (counter == 4) begin
			register_4 <= register_1 + register_2;
			counter <= counter + 1;
		end
	end
end

endmodule