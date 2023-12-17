module ALUOut (
    input           ph1, reset,
    input   [7:0]   ALU_result,

    output  reg     [7:0]   ALU_out = 8'b0
);

    always @(posedge ph1) begin
		if (reset) begin
		 ALU_out <= 8'b0;
		end else begin
		 ALU_out <= ALU_result;
		end
	end

endmodule