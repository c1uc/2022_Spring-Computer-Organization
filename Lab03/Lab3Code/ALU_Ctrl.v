`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr,
	input		[2-1:0]	ALUOp,
	output	reg [4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */

always @(*) begin
	if(ALUOp == 2'b10) begin
		if(instr == 4'b0000) begin // add
			ALU_Ctrl_o <= 4'b0010;
		end
		else if(instr == 4'b1000) begin // sub
			ALU_Ctrl_o <= 4'b0110;
		end
		else if(instr == 4'b0111) begin // and
			ALU_Ctrl_o <= 4'b0000;
		end
		else if(instr == 4'b0110) begin // or
			ALU_Ctrl_o <= 4'b0001;
		end
		else if(instr == 4'b0100) begin // xor
			ALU_Ctrl_o <= 4'b1000;
		end
		else if(instr == 4'b0010) begin // slt
			ALU_Ctrl_o <= 4'b0111;
		end
		else if(instr == 4'b0001) begin // sll
			ALU_Ctrl_o <= 4'b1001;
		end
		else if(instr == 4'b1101) begin // sra
			ALU_Ctrl_o <= 4'b1010;
		end
		else begin
			ALU_Ctrl_o <= 4'b0000;
		end
	end
	else begin
		ALU_Ctrl_o <= 4'b0000;
	end
end

endmodule
