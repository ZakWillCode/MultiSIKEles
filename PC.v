module PC (
	
	input ph1, reset, PCEn,
	input [7:0] pc_in,

	output reg [7:0] pc_out = 8'b0

);
	reg rst;
	always @(posedge ph1) begin
		if (reset) begin
			pc_out <= 8'b0;
			rst <= 1'b1;
		end else if (rst) begin
			rst <= 1'b0;
		end else if (PCEn) begin
			pc_out <= pc_in;
		end
	end
endmodule