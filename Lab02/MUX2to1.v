module MUX2to1(
	input      src1,
	input      src2,
	input	   select,
	output reg result
	);
/* Write your code HERE */
always @(src1, src2, select) begin
	case(select)
		1'b0:
			result <= src1;
		1'b1:
			result <= src2;
		default:
			result <= result;
	endcase
end

endmodule
