module ALU_controller (

    input   [1:0]   ALUOp,
    input   [31:0]  Instruction,

    output  reg     [2:0]   ALUControl

);

    wire [5:0] funct;
    assign funct = Instruction[5:0];

    always @(*) begin
        case (ALUOp)
            2'b00:
                ALUControl <= 3'b010; // ADD
            2'b01:
                ALUControl <= 3'b110; // SUB
            2'b10:
                case (funct)
                    6'b100000:
                        ALUControl <= 3'b010; // ADD
                    6'b100010:
                        ALUControl <= 3'b110; // ADD
                    6'b100100:
                        ALUControl <= 3'b000; // AND
                    6'b100101:
                        ALUControl <= 3'b001; // OR
                    6'b101010:
                        ALUControl <= 3'b111; // SLT
                    default: 
                        ALUControl <= 3'b000; // Undefined
                endcase
            2'b11: 
                ALUControl <= 3'b000; // Undefined
            default: 
                ALUControl <= 3'b000;

        endcase
    end

endmodule