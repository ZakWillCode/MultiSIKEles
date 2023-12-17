module MC_MIPS_TL (

    input           ph1, ph2, reset,
    input   [7:0]   MemData,

    output          MemRead, MemWrite,
    output  [7:0]   Address, Write_data

);
    //Wires
    wire [7:0]  pc_in, pc_out;
    wire [7:0]  RegData;
    wire [4:0]  Write_register;
    wire [7:0]  Read_data_1, Read_data_2;
    wire [7:0]  A, B;
    wire [7:0]  ALU_result;
    wire [2:0]  ALUControl;
    wire [7:0]  ALU_out;
    wire [7:0]  Jump_address;
	wire [7:0] A_data, B_data, A_out, B_out;


    //Controller wires
    wire Zero;
    wire [31:0]   Instruction;
    wire MemtoReg;
    wire PCWriteCond, PCWrite;
    wire IorD;
    wire [3:0]   IRWrite;
    wire RegDst;
    wire RegWrite;
    wire ALUSrcA;
    wire [1:0]   ALUSrcB;
    wire [1:0]   ALUOp;
    wire [1:0]   PCSource;
   

    //Assign a wire
    wire [4:0] inst2521, inst2016, inst1511;
    assign inst2521 = Instruction[25:21];
    assign inst2016 = Instruction[20:16];
    assign inst1511 = Instruction[15:11];

    //Hold a 1 bit value;
    wire [7:0] one;
    assign one = 8'b00000001;

    PC pc (
	.reset(reset),
	.ph1(ph1),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    mux2_1 iord(
        .A(pc_in),
        .B(ALU_out),
        .Y(Address),
        .sel(IorD)
    );

    Memory memory (
        .ph1(ph1),
        .reset(reset),
        .Address(Address),
        .Write_data(B_out),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemData(MemData)
    );

    Instruction_register instruction_register (
        .ph1(ph1),
        .reset(reset),
        .MemData(MemData),
        .Instruction(Instruction),
        .IRWrite(IRWrite)
    );

    Memory_data_register memory_data_register (
        .ph2(ph2),
        .reset(reset),
        .MemData(MemData),
        .RegData(RegData)
    );

    mux2_1 memtoreg (
        .sel(MemtoReg),
        .A(ALU_out),
        .B(RegData),
        .Y(Write_data)
    );

    mux2_1_5b regdst (
        .sel(RegDst),
        .A(inst2016),
        .B(inst1511),
        .Y(Write_register)
    );

    Registers registers (
        .ph1(ph1),
        .reset(reset),
        .Read_register_1(inst2521),
        .Read_register_2(inst2016),
        .Write_register(Write_register),
        .Write_data(Write_data),
        .RegWrite(RegWrite),
        .Read_data_1(Read_data_1),
        .Read_data_2(Read_data_2)
    );

    A_reg a_reg (
        .ph2(ph2),
        .reset(reset),
        .Read_data_1(Read_data_1),
        .A_data(A_data)
    );

    B_reg b_reg (
        .ph2(ph2),
        .reset(reset),
        .Read_data_2(Read_data_2),
        .B_data(B_data)
    );

    mux2_1 alusca (
        .A(pc_out),
        .B(A_data),
        .Y(A),
        .sel(ALUSrcA)
    );

    mux4_1 alusrcb (
        .A(B_data),
        .B(one),
        .C(RegData),
        .D(RegData),
        .Y(B),
        .sel(ALUSrcB)
    );

    ALU alu (
        .ALUControl(ALUControl),
        .A(A),
        .B(B),
        .ALU_result(ALU_result),
        .Zero(Zero)
    );

    ALU_controller alu_controller (
        .Instruction(Instruction),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );

    ALUOut aluout (
        .ph2(ph2),
        .reset(reset),
        .ALU_result(ALU_result),
        .ALU_out(ALU_out)
    );

    SL2 shift_left2 (
        .Instruction(Instruction),
        .Jump_address(Jump_address)
    );

    mux4_1 pcsource (
        .A(ALU_result),
        .B(ALU_out),
        .C(Jump_address),
        .D(Jump_address),
        .Y(pc_in),
        .sel(PCSource)
    );

    Control control (
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
        .IRWrite(IRWrite),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .ALUOp(ALUOp),
        .PCSource(PCSource)
    );

endmodule
