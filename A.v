module A_reg (
    input           ph1, reset,
    input   [7:0]   Read_data_1,

    output  reg     [7:0]   A_data = 8'b00000000
);

    always @(posedge ph1) begin
		if (reset) begin
			A_data <= 8'b00000000;
		end else begin
			A_data <= Read_data_1;
		end
	end

endmodule