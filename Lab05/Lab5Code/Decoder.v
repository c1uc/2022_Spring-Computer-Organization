`timescale 1ns/1ps

module Decoder(
    input [32-1:0]  instr_i,
    output reg         Branch,
    output reg         ALUSrc,
    output reg         RegWrite,
    output reg [2-1:0] ALUOp,
    output reg         MemRead,
    output reg         MemWrite,
    output reg         MemtoReg,
    output reg         Jump
);

//Internal Signals
wire    [7-1:0]     opcode;
wire    [3-1:0]     funct3;
wire    [3-1:0]     Instr_field;
wire    [9:0]       Ctrl_o;

always @(*) begin
	case (instr_i[6:0])
		7'b0110011: begin //R-type
			RegWrite <= 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b0;
			ALUOp <= 2'b10;
			MemtoReg <= 1'b0;
		end
		7'b0010011: begin //I-type
			RegWrite <= (instr_i[11:7] == 0 && instr_i[19:15] == 0 && instr_i[31:20] == 0) ? 1'b0 : 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b1;
			ALUOp <= 2'b11;
			MemtoReg <= 1'b0;
		end
		7'b0000011: begin //lw
			RegWrite <= 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b0;
			MemRead <= 1'b1;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b1;
			ALUOp <= 2'b00;
			MemtoReg <= 1'b1;
		end
		7'b0100011: begin //sw
			RegWrite <= 1'b0;
			Branch <= 1'b0;
			Jump <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b1;
			ALUSrc <= 1'b1;
			ALUOp <= 2'b00;
			MemtoReg <= 1'b0;
		end
		7'b1100011: begin //branch
			RegWrite <= 1'b0;
			Branch <= 1'b1;
			Jump <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b0;
			ALUOp <= 2'b01;
			MemtoReg <= 1'b0;
		end
		7'b1101111: begin //jal
			RegWrite <= 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b1;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b0;
			ALUOp <= 2'b00;
			MemtoReg <= 1'b0;
		end
		7'b1100111: begin //jalr
			RegWrite <= 1'b1;
			Branch <= 1'b0;
			Jump <= 1'b1;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b0;
			ALUOp <= 2'b00;
			MemtoReg <= 1'b0;
		end
		default: begin
			RegWrite <= 1'b0;
			Branch <= 1'b0;
			Jump <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b0;
			ALUOp <= 2'b00;
			MemtoReg <= 1'b0;
		end
	endcase
end

/* Write your code HERE */
endmodule







