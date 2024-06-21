`timescale 1ns/1ps

module Decoder(
	input	[32-1:0] 	instr_i,
	output wire			ALUSrc,
	output wire			RegWrite,
	output wire			Branch,
	output wire [2-1:0]	ALUOp
	);
	
//Internal Signals
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[3-1:0]		Instr_field;
wire	[9-1:0]		Ctrl_o;

/* Write your code HERE */

reg AS, RW, BR;
reg [1:0]AO;

assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];

assign ALUSrc = AS;
assign RegWrite = RW;
assign Branch = BR;
assign ALUOp = AO;

always @(*) begin
	case(opcode)
		7'b0110011: begin
			AS <= 0;
			RW <= 1;
			BR <= 0;
			AO <= 2'b10;
		end
		default: begin
			AS <= 0;
			RW <= 0;
			BR <= 0;
			AO <= 2'b00;
		end
	endcase
end

endmodule
