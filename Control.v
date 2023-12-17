module  Control (
    input   ph1, reset,
    input   Zero,
    input   [31:0]   Instruction,

    output  reg MemWrite, MemRead, 
    output  reg MemtoReg,
    output  reg PCWriteCond, PCWrite,
    output  reg IorD,
    output  reg IRWrite0, IRWrite1, IRWrite2, IRWrite3,
    output  reg RegDst,
    output  reg RegWrite,
    output  reg ALUSrcA,
    output  reg [1:0]   ALUSrcB,
    output  reg [1:0]   ALUOp,
    output  reg [1:0]   PCSource
);
    wire [5:0] Op;
    assign Op = Instruction[31:26];
    reg [3:0] state;

	always @(posedge ph1) begin
        MemRead  = 1'b0;
	MemtoReg = 1'b0;
        MemWrite = 1'b0;
        RegWrite = 1'b0;
	RegDst	 = 1'b0;
        PCWrite  = 1'b0;
        PCWriteCond =1'b0;
        IRWrite0     = 1'b0;
	IRWrite1     = 1'b0;
	IRWrite2     = 1'b0;
	IRWrite3     = 1'b0;

        case (state)
            4'b0000: begin  //0
                MemRead     = 1'b1;
                ALUSrcA     = 1'b0;
                IorD        = 1'b0;
        	IRWrite0    = 1'b1;
		IRWrite1    = 1'b0;
		IRWrite2    = 1'b0;
		IRWrite3    = 1'b0;
                ALUSrcB     = 2'b01;
                ALUOp       = 2'b00;
                PCSource    = 2'b00;
		PCWrite     = 1'b1;
		RegDst      = 1'b0;
		MemtoReg    = 1'b0;

                state       = 4'b0001;
            end    
            4'b0001: begin //1
                MemRead     = 1'b1;
                ALUSrcA     = 1'b0;
                IorD        = 1'b0;
                IRWrite0    = 1'b0;
		IRWrite1    = 1'b1;
		IRWrite2    = 1'b0;
		IRWrite3    = 1'b0;
                ALUSrcB     = 2'b01;
                ALUOp       = 2'b00;
                PCSource    = 2'b00;
		PCWrite     = 1'b1;

                state       = 4'b0010; 
            end  
            4'b0010: begin //2
                MemRead     = 1'b1;
                ALUSrcA     = 1'b0;
                IorD        = 1'b0;
        	IRWrite0    = 1'b0;
		IRWrite1    = 1'b0;
		IRWrite2    = 1'b1;
		IRWrite3    = 1'b0;
                ALUSrcB     = 2'b01;
                ALUOp       = 2'b00;
                PCSource    = 2'b00;
		PCWrite     = 1'b1;
	
                state       = 4'b0011; 
            end  
            4'b0011: begin //3
                MemRead     = 1'b1;
                ALUSrcA     = 1'b0;
                IorD        = 1'b0;
        	IRWrite0    = 1'b0;
		IRWrite1    = 1'b0;
		IRWrite2    = 1'b0;
		IRWrite3    = 1'b1;
                ALUSrcB     = 2'b01;
                ALUOp       = 2'b00;
                PCSource    = 2'b00;
		PCWrite     = 1'b1; 

                state       = 4'b0100;
            end  
            4'b0100: begin //4
                MemRead     = 1'b0;
                ALUSrcA     = 1'b0;
                ALUSrcB     = 2'b11;
                ALUOp       = 2'b00;

                case (Op)
                    6'b000000: begin    //R
                        state   = 4'b1001;
                    end
                    6'b001000: begin    //I
                        state   = 4'b1101;
                    end
                    6'b000100: begin    //BEQ
                        state   = 4'b1011;
                    end
                    6'b000010: begin    //J
                        state   = 4'b1100;
                    end
                    6'b100000: begin    //LB
                        state   = 4'b0101;
                    end
                    6'b101000: begin    //SB
                        state   = 4'b0101;
                    end 
                    default: 
                        state   = 4'b0000; 
                endcase
            end  
            4'b0101: begin //5
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b10;
                ALUOp   = 2'b00;

                if (Op == 6'b100000) begin
                    state = 4'b0110; 
                end else begin 
                    state = 4'b1000; 
		end
            end  
            4'b0110: begin //6
                MemRead = 1'b1;
                IorD    = 1'b1;
            
                state   = 4'b0111;
            end  
            4'b0111: begin //7
                RegDst  = 1'b0;
                RegWrite = 1'b1;
                MemtoReg = 1'b1; 

                state   = 4'b0000;
            end  
            4'b1000: begin //8
                MemWrite = 1'b1;
                IorD    = 1'b1;

                state = 4'b0000;
            end  
            4'b1001: begin //9
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b00;
                ALUOp   = 2'b10;

                state   = 4'b1010;
            end  
            4'b1010: begin //10
                RegDst = 1'b1;
                RegWrite = 1'b1;

                state = 4'b0000;
            end  
            4'b1011: begin //11
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b00;
                ALUOp   = 2'b01;
                PCWriteCond = 1'b1;
                PCSource = 2'b01;

                state   = 4'b0000;
            end 
            4'b1100: begin //12
                PCWrite = 1'b1;
                PCSource = 2'b10;

                state = 4'b0000;
            end
	    4'b1101: begin //13
		ALUSrcA = 1'b1;
		ALUSrcB = 2'b10;
		ALUOp = 2'b00;

		state = 4'b1110;
	    end
	    4'b1110: begin //14
                RegDst = 1'b0;
                RegWrite = 1'b1;

                state = 4'b0000;
            end   
            default:  begin
                MemRead     = 1'b1;
                ALUSrcA     = 1'b0;
                IorD        = 1'b0;
        	IRWrite0    = 1'b1;
		IRWrite1    = 1'b0;
		IRWrite2    = 1'b0;
		IRWrite3    = 1'b0;
                ALUSrcB     = 2'b01;
                ALUOp       = 2'b00;
                PCSource    = 2'b00; 

                state       = 4'b0001;
            end  
        endcase
	
        if (reset) begin
            	state = 4'b0000;
	end
    end

endmodule
