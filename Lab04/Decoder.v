
`timescale 1ns/1ps

module Decoder(
    input   [7-1:0]     instr_i,
    output              RegWrite,
    output              Branch,
    output              Jump,
    output              WriteBack1,
    output              WriteBack0,
    output              MemRead,
    output              MemWrite,
    output              ALUSrcA,
    output              ALUSrcB,
    output  [2-1:0]     ALUOp
);

/* Write your code HERE */
reg RegWrite, Branch, Jump, WriteBack1, WriteBack0, MemRead, MemWrite, ALUSrcA, ALUSrcB;
reg [2-1:0] ALUOp;

always @(*) begin
	case (instr_i)
		7'b0110011: begin //R-type
			RegWrite <= 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b0;
			WriteBack1 <= 1'b0;
			WriteBack0 <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrcA <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUOp <= 2'b10;
		end
		7'b0010011: begin //I-type
			RegWrite <= 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b0;
			WriteBack1 <= 1'b0;
			WriteBack0 <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrcA <= 1'b0;
			ALUSrcB <= 1'b1;
			ALUOp <= 2'b00;
		end
		7'b0000011: begin //lw
			RegWrite <= 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b0;
			WriteBack1 <= 1'b0;
			WriteBack0 <= 1'b1;
			MemRead <= 1'b1;
			MemWrite <= 1'b0;
			ALUSrcA <= 1'b0;
			ALUSrcB <= 1'b1;
			ALUOp <= 2'b00;
		end
		7'b0100011: begin //sw
			RegWrite <= 1'b0;
			Branch <= 1'b0;
			Jump <= 1'b0;
			WriteBack1 <= 1'b0;
			WriteBack0 <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b1;
			ALUSrcA <= 1'b0;
			ALUSrcB <= 1'b1;
			ALUOp <= 2'b00;
		end
		7'b1100011: begin //branch
			RegWrite <= 1'b0;
			Branch <= 1'b1;
			Jump <= 1'b0;
			WriteBack1 <= 1'b0;
			WriteBack0 <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrcA <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUOp <= 2'b01;
		end
		7'b1101111: begin //jal
			RegWrite <= 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b1;
			WriteBack1 <= 1'b1;
			WriteBack0 <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrcA <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUOp <= 2'b00;
		end
		7'b1100111: begin //jalr
			RegWrite <= 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b1;
			WriteBack1 <= 1'b1;
			WriteBack0 <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrcA <= 1'b1;
			ALUSrcB <= 1'b0;
			ALUOp <= 2'b00;
		end
		default: begin
			RegWrite <= 1'b0;
			Branch <= 1'b0;
			Jump <= 1'b0;
			WriteBack1 <= 1'b0;
			WriteBack0 <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrcA <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUOp <= 2'b00;
		end
	endcase
end

endmodule

