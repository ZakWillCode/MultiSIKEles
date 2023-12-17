module Registers (
    input   ph1, reset,
    input   RegWrite,

    input   [4:0]   Read_register_1, Read_register_2,
    input   [4:0]   Write_register,
    input   [7:0]   Write_data,

    output  [7:0]   Read_data_1, Read_data_2
);
    reg     [7:0]   gpr [0:7];
	integer i;

    always @(posedge ph1) begin
        if (reset) begin
		for (i = 0; i < 8; i = i + 1) begin
        		gpr[i] = 8'b00000000;
      		end
        end else begin
            if (RegWrite) begin
		if (!(Write_register == 5'b00000)) begin
			gpr[Write_register] = Write_data;
		end
            end
        end
    end

    assign Read_data_1 = gpr[Read_register_1];
    assign Read_data_2 = gpr[Read_register_2];
endmodule