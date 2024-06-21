`timescale 1ns/1ps

module alu(
    input                   rst_n,         // negative reset            (input)
    input        [32-1:0]   src1,          // 32 bits source 1          (input)
    input        [32-1:0]   src2,          // 32 bits source 2          (input)
    input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
    output reg   [32-1:0]   result,        // 32 bits result            (output)
    output reg              zero           // 1 bit when the output is 0, zero must be set (output)
);

/* Write your code HERE */

always @(*) begin
	case(ALU_control)
		4'b0000: // AND
			result <= src1 & src2;
		4'b0001: // OR
			result <= src1 | src2;
		4'b0010: // add
			result <= src1 + src2;
		4'b0110: //sub
			result <= src1 - src2;
		4'b0111: // slt
			result <= (src1 < src2);
        4'b1110: // xor
            result <= src1 ^ src2;
        4'b1111: // sll
            result <= src1 << src2;
		default:
			result <= 32'b0;
	endcase
    zero <= (|result == 0);
end

endmodule
