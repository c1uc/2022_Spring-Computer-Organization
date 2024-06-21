`timescale 1ns/1ps

module alu_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input				less,       //1 bit less      (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout,       //1 bit carry out (output)
	output reg 			set			//1 bit set
	);

/* Write your code HERE */
wire A_inv;
wire B_inv;

wire W1;
wire W2;

assign A_inv = ~src1;
assign B_inv = ~src2;

MUX2to1 MUX2_1(.src1(src1), .src2(A_inv), .select(Ainvert), .result(W1));
MUX2to1 MUX2_2(.src1(src2), .src2(B_inv), .select(Binvert), .result(W2));

reg W3;
reg W4;
reg W5;

always @(W1, W2, cin) begin
	W3 <= W1 & W2;
	W4 <= W1 | W2;
	W5 <= (W1 ^ W2) ^ cin;
end

wire res;

MUX4to1 MUX4(.src1(W3), .src2(W4), .src3(W5), .src4(less), .select(operation), .result(res));

always @(W1, W5, cin, res, operation) begin
	result <= res;
	set <= W5;
	cout <= ((W1 & cin) | (W2 & cin) | (W1 & W2));
end

endmodule
