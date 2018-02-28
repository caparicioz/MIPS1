/******************************************************************* 
* Name:
*	Mips.v
* Description:
* 	This module implements a modular MIPS processor
* Versión:  
*	1.0
* Author: 
*	Christian Aparicio Zuleta
* Fecha: 
*	05/09/2017 
*********************************************************************/
module MIPS(clk, reset);
//Interface
parameter DATA_WIDTH='d32; 
parameter ADDR_WIDTH='d32;
parameter ADDR_SIZE='d8;
parameter DATA_BASE_ADDRESS='h40_0000;
input clk, reset;

//Wires For control unit
wire [5:0] Op, Funct;
wire [2:0] ALUControl;
wire [1:0] ALUSrcB;
wire IorD, MemWrite, IRWrite, PCWrite, Branch, PCSrc,ALUSrcA,RegWrite, RegDst, MemtoReg, PCEn;

//Wires for blocks
wire [DATA_WIDTH-1:0] PC_PRIMO, PC, Adr, ALUOut, WD, RD, Instr, Data, WD3, RD1, RD2, A, SignImm, SrcA, SrcB, ALUResult;
wire [4:0] A3;


//Regs


//DataPath
Register_pc #(.WORD_LENGTH(DATA_WIDTH), .DATA_BASE_ADDRESS(DATA_BASE_ADDRESS)) PCEnable (.clk(clk), .reset(reset), .enable(PCEn), .Data_Input(PC_PRIMO), .Data_Output(PC));
Mux2to1 #(.WORD_LENGTH(DATA_WIDTH)) MuxIorD (.selector(IorD), .Data_0({12'b0,PC[21:2]}), .Data_1(ALUOut), .Mux_Output(Adr));
Memory #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .ADDR_SIZE(ADDR_SIZE)) Data_Instruction_M (.Adr(Adr), .WD(WD), .WE(MemWrite), .clk(clk), .RD(RD));
Register #(.WORD_LENGTH(DATA_WIDTH)) InstructionRegister (.clk(clk), .reset(reset), .enable(IRWrite), .Data_Input(RD), .Data_Output(Instr));
Register #(.WORD_LENGTH(DATA_WIDTH)) DataRegister (.clk(clk), .reset(reset), .enable(1'b1), .Data_Input(RD), .Data_Output(Data));
Mux2to1 #(.WORD_LENGTH(5)) RegDstMux (.selector(RegDst), .Data_0(Instr[20:16]), .Data_1(Instr[15:11]), .Mux_Output(A3));
Mux2to1 #(.WORD_LENGTH(DATA_WIDTH)) MemtoRegMux (.selector(MemtoReg), .Data_0(ALUOut), .Data_1(Data), .Mux_Output(WD3));
RegisterFile #(.WORD_LENGTH(DATA_WIDTH)) RegisterFileMips (.read_register_1(Instr[25:21]),.read_register_2(Instr[20:16]), .write_register(A3), .write_data(WD3), .write(RegWrite), .clk(clk), .reset(reset), .read_data_1(RD1), .read_data_2(RD2));
Register #(.WORD_LENGTH(DATA_WIDTH)) DataRegister_A (.clk(clk), .reset(reset), .enable(1'b1), .Data_Input(RD1), .Data_Output(A));
Register #(.WORD_LENGTH(DATA_WIDTH)) DataRegister_B (.clk(clk), .reset(reset), .enable(1'b1), .Data_Input(RD2), .Data_Output(WD));
sign_extend datosigno (.Data_in(Instr[15:0]), .Data_out(SignImm));
Mux2to1 #(.WORD_LENGTH(DATA_WIDTH)) ALUSrcAMux (.selector(ALUSrcA), .Data_0(PC), .Data_1(A), .Mux_Output(SrcA));
Mux4to1 #(.WORD_LENGTH(DATA_WIDTH)) ALUSrcBMux (.selector (ALUSrcB), .Data_0(WD), .Data_1(32'd4), .Data_2(SignImm), .Data_3({SignImm[DATA_WIDTH-1:2],2'b0}), .Mux_Output(SrcB));
ALU #(.WORD_LENGTH(DATA_WIDTH)) ALUMIPS (.A(SrcA), .B(SrcB), .Control(ALUControl), .C(ALUResult));
Register #(.WORD_LENGTH(DATA_WIDTH)) RegALUResult (.clk(clk), .reset(reset), .enable(1'b1), .Data_Input(ALUResult), .Data_Output(ALUOut));
Mux2to1 #(.WORD_LENGTH(DATA_WIDTH)) ALUOutMux (.selector(PCSrc), .Data_0(ALUResult), .Data_1(ALUOut), .Mux_Output(PC_PRIMO));
Control uControl (clk, reset, Instr[31:26], Instr[5:0], IorD, ALUControl, ALUSrcB, MemWrite, IRWrite, PCWrite, Branch, PCSrc,ALUSrcA,RegWrite, RegDst, MemtoReg);
//
//Assignments
assign PCEn = PCWrite | Branch;

endmodule