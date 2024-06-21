
`timescale 1ns/1ps

module Imm_Gen(
    input  [31:0] instr_i,
    output reg[31:0] Imm_Gen_o
);

//Internal Signals
wire    [7-1:0] opcode;
wire    [2:0]   func3;
wire    [3-1:0] Instr_field;

assign opcode = instr_i[6:0];
assign func3  = instr_i[14:12];

/* Write your code HERE */

always @(*) begin
	case(opcode) 
		7'b0010011: begin //I-type
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[31:20]};
		end
		7'b0000011: begin //lw = I-type
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[31:20]};
		end
		7'b0100011: begin //sw = S-type
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
		end
		7'b1100011: begin //beq = B-type
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
		end
		7'b1101111: begin //jal = J-type
			Imm_Gen_o <= {{12{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};
		end
		7'b1100111: begin //jalr = I-type
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[31:20]};
		end
		default: begin
			Imm_Gen_o <= 32'b0;
		end
	endcase
end

endmodule
