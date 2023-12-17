 `timescale 1ps / 1ps  

module ALU_tb;
	//Inputs
	reg signed [7:0] A, B;
	reg signed [3:0] sel;

	//Outputs
	wire signed [7:0] Y;
	wire [1:0] flag;
	
ALU uut(
        .A(A),
	.B(B),                 
        .sel(sel),
	.flag(flag),
	.Y(Y)
);

always @(*)
	$monitor(A,B,flag,Y);
    initial begin
		A = 8'b00001100;
		B = 8'b00001001;
		sel = 4'b0000;
		#10;
		sel = 4'b0001;
		#10;
		A = 8'b00000000;
		B = 8'b00000000;
		#10;
		A = 8'b11001100;
		B = 8'b11001001;
		#10;
		A = 8'b00001100;
		B = 8'b00001001;
		sel = 4'b0010;
		#10;
		A = 8'b00000000;
		B = 8'b00000000;
		#10;
		A = 8'b11001100;
		B = 8'b11001001;
		#10;
		A = 8'b00001100;
		B = 8'b00001001;
		sel = 4'b0011;
		#10;
		A = 8'b00000000;
		B = 8'b00000000;
		#10;
		A = 8'b11001100;
		B = 8'b11001001;
		#10;
		sel = 4'b0100;
		#10;
		sel = 4'b0101;
		#10;
		sel = 4'b0110;
		#10;
		sel = 4'b0111;
		#10;
		sel = 4'b1000;
		#10;
		#10;
		#10;
		#10;
		#10;
		#10;
    end
endmodule
