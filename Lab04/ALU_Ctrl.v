
`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output      [4-1:0] ALU_Ctrl_o
);
wire [2:0] func3;
assign func3 = instr[2:0];
/* Write your code HERE */

reg ALU_Ctrl_o;

always @(*) begin
	case(ALUOp)
		2'b00: begin //lw, sw
			ALU_Ctrl_o <= 4'b0010;
		end
		2'b01: begin //beq
			ALU_Ctrl_o <= 4'b0110;
		end
		2'b10: begin
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
				4'b0010: begin //slt
					ALU_Ctrl_o <= 4'b0111;
				end
				default: begin
					ALU_Ctrl_o <= 4'b0000;
				end
			endcase
		end
		default: begin
			ALU_Ctrl_o <= 4'b0000;
		end
	endcase
end

endmodule

