module ALU (
    input signed   [7:0]   A, B,

    input   [2:0]   ALUControl,

    output  reg             Zero,
    output  reg     [7:0]   ALU_result
);

    always @(*) begin
        case (ALUControl)
            3'b010: begin            //ADD
                ALU_result <= A + B;
            end
            3'b110: begin            //SUB
                ALU_result <= A - B;
            end
            3'b000: begin            //AND
                ALU_result <= A & B;
            end
            3'b001: begin            //OR
                ALU_result <= A | B;
            end
            3'b111: begin            //SLT
                if (A < B)
                    ALU_result <= 8'b00000001;
                else
                    ALU_result <= 8'b00000000;
            end
            default: begin
                Zero <= 1'b0;
                ALU_result <= 8'b00000000;
            end
        endcase
        
        if ((A - B) == 0) begin
            Zero <= 1'b1;
        end else begin
            Zero <= 1'b0;
        end
    end

endmodule