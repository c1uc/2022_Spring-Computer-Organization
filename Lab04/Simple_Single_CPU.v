`timescale 1ns/1ps
module Simple_Single_CPU(
    input clk_i,
    input rst_i
);

//Internal Signales
//Control Signales
wire RegWrite;
wire Branch;
wire Jump;
wire WriteBack1;
wire WriteBack0;
wire MemRead;
wire MemWrite;
wire ALUSrcA;
wire ALUSrcB;
wire [2-1:0] ALUOp;
wire PCSrc;
//ALU Flag
wire Zero;

//Datapath
wire [32-1:0] pc_i;
wire [32-1:0] pc_o;
wire [32-1:0] instr;
wire [32-1:0] RegWriteData;
wire [32-1:0] Imm_Gen_o;
wire [32-1:0] Imm_4 = 4;
wire [4-1:0] ALUControlOut;
wire [4-1:0] ALUControlIn;
assign ALUControlIn[3] = instr[30];
assign ALUControlIn[2:0] = instr[14:12];
assign PCSrc = (Branch & Zero) | Jump;

wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire [32-1:0] pc_A;
wire [32-1:0] pc_B;
wire [32-1:0] pc_C;
wire [32-1:0] ALUIn;
wire [32-1:0] ALUResult;
wire [32-1:0] MemResult;
wire [32-1:0] WriteA;

ProgramCounter PC(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .pc_i(pc_i),
    .pc_o(pc_o)
);

Adder Adder_PCPlus4(
    .src1_i(pc_o),
    .src2_i(Imm_4),
    .sum_o(pc_A)
);

Instr_Memory IM(
    .addr_i(pc_o),
    .instr_o(instr)
);

Reg_File RF(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .RSaddr_i(instr[19:15]),
    .RTaddr_i(instr[24:20]),
    .RDaddr_i(instr[11:7]),
    .RDdata_i(RegWriteData),
    .RegWrite_i(RegWrite),
    .RSdata_o(RSdata_o),
    .RTdata_o(RTdata_o)
);


Decoder Decoder(
    .instr_i(instr[6:0]),
    .RegWrite(RegWrite),
    .Branch(Branch),
    .Jump(Jump),
    .WriteBack1(WriteBack1),
    .WriteBack0(WriteBack0),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .ALUOp(ALUOp)
);

Imm_Gen ImmGen(
    .instr_i(instr),
    .Imm_Gen_o(Imm_Gen_o)
);


ALU_Ctrl ALU_Ctrl(
    .instr(ALUControlIn),
    .ALUOp(ALUOp),
    .ALU_Ctrl_o(ALUControlOut)
);

MUX_2to1 MUX_ALUSrcA(
    .data0_i(pc_o),
    .data1_i(RSdata_o),
    .select_i(ALUSrcA),
    .data_o(pc_B)
);

Adder Adder_PCReg(
    .src1_i(pc_B),
    .src2_i(Imm_Gen_o),
    .sum_o(pc_C)
);

MUX_2to1 MUX_PCSrc(
    .data0_i(pc_A),
    .data1_i(pc_C),
    .select_i(PCSrc),
    .data_o(pc_i)
);

MUX_2to1 MUX_ALUSrcB(
    .data0_i(RTdata_o),
    .data1_i(Imm_Gen_o),
    .select_i(ALUSrcB),
    .data_o(ALUIn)
);

alu alu(
    .rst_n(rst_i),
    .src1(RSdata_o),
    .src2(ALUIn),
    .ALU_control(ALUControlOut),
    .Zero(Zero),
    .result(ALUResult)
);

Data_Memory Data_Memory(
    .clk_i(clk_i),
    .addr_i(ALUResult),
    .data_i(RTdata_o),
    .MemRead_i(MemRead),
    .MemWrite_i(MemWrite),
    .data_o(MemResult)
);

MUX_2to1 MUX_WriteBack0(
    .data0_i(ALUResult),
    .data1_i(MemResult),
    .select_i(WriteBack0),
    .data_o(WriteA)
);

MUX_2to1 MUX_WriteBack1(
    .data0_i(WriteA),
    .data1_i(pc_A),
    .select_i(WriteBack1),
    .data_o(RegWriteData)
);

endmodule
