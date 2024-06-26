`timescale 1ns/1ps

module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
);
/* Write your code HERE */

always @(*) begin
	case(ALUOp)
		2'b00: begin //lw, sw
			ALU_Ctrl_o <= 4'b0010;
		end
		2'b01: begin //beq
			ALU_Ctrl_o <= 4'b0110;
		end
		2'b10: begin //R-type arithmatic
			case(instr)
				4'b0000: begin //add
					ALU_Ctrl_o <= 4'b0010;
				end
				4'b1000: begin //sub
					ALU_Ctrl_o <= 4'b0110;
				end
				4'b0111: begin //and
					ALU_Ctrl_o <= 4'b0000;
				end
				4'b0110: begin //or
					ALU_Ctrl_o <= 4'b0001;
				end
                4'b0100: begin //xor
					ALU_Ctrl_o <= 4'b1110;
				end
				4'b0010: begin //slt
					ALU_Ctrl_o <= 4'b0111;
				end
				default: begin
					ALU_Ctrl_o <= 4'b0000;
				end
			endcase
		end
        2'b11: begin //I-type
            case(instr[2:0])
                3'b000: begin // addi
                    ALU_Ctrl_o <= 4'b0010;
                end
                3'b010: begin // slti
                    ALU_Ctrl_o <= 4'b0111;
                end
                3'b001: begin // slli
                    ALU_Ctrl_o <= 4'b1111;
                end
            endcase
        end
		default: begin
			ALU_Ctrl_o <= 4'b0000;
		end
	endcase
end

endmodule
