module Memory_prog (
    input           ph1, reset,
    input           MemRead, MemWrite,
    input   [7:0]   Address,
    input   [7:0]   Write_data,

    output  [7:0]   MemData,
	output [7:0] ans
);

    reg     [7:0]   mem[0:255];
    integer         i;

    always @(posedge ph1) begin
        if (reset) begin
		for (i = 0; i < 256; i = i + 1) begin
        		mem[i] = 8'b00000000;
      		end
            mem[0]  = 8'b00100000; //addi $3, $0, 8;
            mem[1]  = 8'b00000011;
            mem[2]  = 8'b00000000;
            mem[3]  = 8'b00001000;
            mem[4]  = 8'b00100000; //addi $4, $0, 1;
            mem[5]  = 8'b00000100;
            mem[6]  = 8'b00000000;
            mem[7]  = 8'b00000001;
            mem[8]  = 8'b00100000; //addi $5, $0, -1;
            mem[9]  = 8'b00000101;
            mem[10] = 8'b11111111;
            mem[11] = 8'b11111111;
            mem[12] = 8'b00010000; //beq $3, $0, end;
            mem[13] = 8'b01100000;
            mem[14] = 8'b00000000;
            mem[15] = 8'b00010000;
            mem[16] = 8'b00000000; //add $4, $4, $5;
            mem[17] = 8'b10000101; 
            mem[18] = 8'b00100000;
            mem[19] = 8'b00100000;
            mem[20] = 8'b00000000; //sub $5, $4, $5;
            mem[21] = 8'b10000101; 
            mem[22] = 8'b00101000;
            mem[23] = 8'b00100010;
            mem[24] = 8'b00100000; //addi $3, $3, -1;
            mem[25] = 8'b01100011;
            mem[26] = 8'b11111111;
            mem[27] = 8'b11111111;
            mem[28] = 8'b00001000; //j loop
            mem[29] = 8'b00000000;
            mem[30] = 8'b00000000;
            mem[31] = 8'b00000011;
            mem[32] = 8'b10100000; //sb $4, 255($0); 
            mem[33] = 8'b00000100;
            mem[34] = 8'b00000000;
            mem[35] = 8'b11111111;
        end else begin
            if (MemWrite) begin
                mem[Address] = Write_data;
            end
        end    
    end

	assign MemData = MemRead ? mem[Address] : 8'b00000000;
	assign ans = mem[255];


endmodule
