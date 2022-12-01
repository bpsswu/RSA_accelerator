module from_arduino (
	clk, rstn, data, save,
	rstn_led, save_led, comp, data_out);
	
input clk, rstn, save;
input [31:0] data;
output rstn_led, save_led, comp;
output [15:0] data_out;

wire rstn_led, save_led;
wire comp;
wire [15:0] data_out;
reg [31:0] register_1;

assign data_out = data[15:0];
assign comp = (register_1 == 32'hF0F0_F0F0) ? 1 : 0;
assign rstn_led = rstn;
assign save_led = save;

always @ (negedge save or negedge rstn) begin
	if (!rstn) begin
		register_1 <= 0;
	end
	else begin
	
		register_1 <= data;
	
	end
end

endmodule