module Instruction_register (
    input           ph1, reset,

    input   [7:0]   MemData,

    input	    IRWrite0, IRWrite1, IRWrite2, IRWrite3,

    output 	reg    	[31:0]  Instruction
);

    reg     [7:0]   data0, data1, data2, data3;

    always @(posedge ph1) begin
        if (reset) begin
            data0 = 8'b00000000;
            data1 = 8'b00000000;
            data2 = 8'b00000000;
            data3 = 8'b00000000;
        end else begin
		if (IRWrite0) begin
			data0 = MemData;
		end else if (IRWrite1) begin
			data1 = MemData;
		end else if (IRWrite2) begin
			data2 = MemData;
		end else if (IRWrite3) begin
			data3 = MemData;
		end
        end

	Instruction <= {data0,data1,data2,data3};

    end
	

endmodule