`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

wire [31:0] carry;
wire carry32;
reg carry0;

reg [1:0] operation;

wire [31:0] res;

wire set;
reg s;

reg Ainvert;
reg Binvert;

always @(ALU_control) begin
	case(ALU_control)
		4'b0000: begin
			Ainvert <= 0;
			Binvert <= 0;
			operation <= 2'b00;
		end
		4'b0001: begin
			Ainvert <= 0;
			Binvert <= 0;
			operation <= 2'b01;
		end
		4'b0010: begin
			Ainvert <= 0;
			Binvert <= 0;
			operation <= 2'b10;
			carry0 <= 1'b0;
		end
		4'b0110: begin
			Ainvert <= 0;
			Binvert <= 1;
			operation <= 2'b10;
			carry0 <= 1'b1;
		end
		4'b0111: begin
			Ainvert <= 0;
			Binvert <= 1;
			operation <= 2'b11;
			carry0 <= 1'b1;
		end
		4'b1100: begin
			Ainvert <= 0;
			Binvert <= 0;
			operation <= 2'b01;
		end
		4'b1101: begin
			Ainvert <= 0;
			Binvert <= 0;
			operation <= 2'b00;
		end
		default: begin
			Ainvert <= 0;
			Binvert <= 0;
			operation <= 2'b00;
			carry0 <= 1'b0;
		end
	endcase
end

always @(res, ALU_control) begin
	case(ALU_control)
		4'b1100:
			result <= ~res;
		4'b1101:
			result <= ~res;
		default:
			result <= res;
	endcase
end

always @(carry32) begin
	case(operation)
		2'b10:
			cout <= carry32;
		default:
			cout <= 1'b0;
	endcase
end

always @(result) begin
	zero <= ~|result;
	overflow <= (((~src1[31] & ~src2[31] & carry[31]) | (src1[31] & src2[31] & ~carry[31])) & (ALU_control == 4'b0010))
				| (((~src1[31] & src2[31] & carry[31]) | (src1[31] & ~src2[31] & ~carry[31])) & (ALU_control == 4'b0110));
end

always @(set) begin
	s <= set;
end

alu_1bit alu0(.result(res[0]), 
			.cout(carry[1]), 
			.src1(src1[0]),
			.src2(src2[0]),
			.Ainvert(Ainvert),
			.Binvert(Binvert),
			.operation(operation),
			.cin(carry0),
			.less(s));

alu_1bit alu31(.result(res[31]), 
			.cout(carry32), 
			.src1(src1[31]),
			.src2(src2[31]),
			.Ainvert(Ainvert),
			.Binvert(Binvert),
			.operation(operation),
			.cin(carry[31]),
			.less(1'b0),
			.set(set));

genvar i;
generate
	for(i = 1; i < 31; i = i + 1) begin
		alu_1bit alu(.result(res[i]), 
			.cout(carry[i + 1]), 
			.src1(src1[i]),
			.src2(src2[i]),
			.Ainvert(Ainvert),
			.Binvert(Binvert),
			.operation(operation),
			.cin(carry[i]),
			.less(1'b0));
	end
endgenerate

endmodule
