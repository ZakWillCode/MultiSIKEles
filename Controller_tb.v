module controller_tb ();

	reg   ph1, ph2, reset;
     reg Zero;
      reg [31:0]   Instruction;

    wire   MemWrite, MemRead;
    wire   MemtoReg;
    wire   PCWriteCond, PCWrite;
    wire   IorD;
    wire   IRWrite0, IRWrite1, IRWrite2, IRWrite3;
    wire   RegDst;
    wire   RegWrite;
    wire   ALUSrcA;
    wire   [1:0]   ALUSrcB;
    wire   [1:0]   ALUOp;
    wire   [1:0]   PCSource;

	Control uut (
		.ph1(ph1), 
		.ph2(ph2),
		.reset(reset),
		.Zero(Zero),
          	.Instruction(Instruction),
       		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
       		.MemtoReg(MemtoReg),
       		.PCWriteCond(PCWriteCond), 
		.PCWrite(PCWrite),
       		.IorD(IorD),
       		.IRWrite0(IRWrite0),
		.IRWrite1(IRWrite1),
		.IRWrite2(IRWrite2),
		.IRWrite3(IRWrite3),
       		.RegDst(RegDst),
       		.RegWrite(RegWrite),
       		.ALUSrcA(ALUSrcA),
          	.ALUSrcB(ALUSrcB),
          	.ALUOp(ALUOp),
          	.PCSource(PCSource)
	);

	initial begin
	Instruction = 32'b00001000000000000000000000000011;
	reset = 1;
	ph1 = 0;
	ph2 = 0;
	#10
	ph1 = 1;
	#10
	ph2 = 1;
	#10
	ph1 = 0;
	#10
	ph2 = 0;
	#10
	ph1 = 1;
	#10
	ph2 = 1;
	#10
	ph1 = 0;
	#10
	ph2 = 0;
	reset = 0;
		forever begin
			#10
			ph1 = 1;
			#10
			ph2 = 1;
			#10
			ph1 = 0;
			#10
			ph2 = 0;
		end
	end 

endmodule
