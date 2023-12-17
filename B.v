module B_reg (
    input           ph1, reset,
    input   [7:0]   Read_data_2,

    output  reg     [7:0]   B_data = 8'b0
);

    always @(posedge ph1) begin
		if (reset) begin
			B_data <= 8'b0;
		end else begin
			B_data <= Read_data_2;
		end
	end

endmodule