module Memory (
    input           ph1, reset,
    input           MemRead, MemWrite,
    input   [7:0]   Address,
    input   [7:0]   Write_data,

    output  reg		[7:0]   MemData
);

    reg     [7:0]   mem[255:0];
    integer         i;

    initial begin //Not synthesizable in ASIC compilers
        for (i = 0; i < 256; i = i + 1) begin
        	mem[i] <= 8'b00000000;
      	end
    end

    always @(posedge ph1) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1) begin
        	    mem[i] <= 8'b00000000;
      	    end
        end else begin
            if (MemWrite) begin
                mem[Address] <= Write_data;
            end
            if (MemRead) begin
                MemData <= mem[Address];
            end else begin
                MemData <= 8'b00000000;
            end
        end    
    end



endmodule