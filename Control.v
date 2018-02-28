/******************************************************************* 
* Name:
*	Control.v
* Description:
* 	This module is the control unit for the modular MIPS processor
* VersiÃ³n:  
*	1.0
* Author: 
*	Christian Aparicio Zuleta
* Fecha: 
*	24/02/2018 
*********************************************************************/
module Control (clk, reset, Op, Funct, IorD, ALUControl, ALUSrcB, MemWrite, IRWrite, PCWrite, Branch, PCSrc,ALUSrcA,RegWrite, RegDst, MemtoReg);
input [5:0] Op, Funct;
input clk, reset;
output reg [2:0] ALUControl;
output reg [1:0] ALUSrcB;
output reg IorD,MemWrite, IRWrite, PCWrite, Branch, PCSrc,ALUSrcA,RegWrite, RegDst, MemtoReg;
//States
localparam IDLE = 0;
localparam FETCH = 1;
localparam DECODE = 2;
localparam EXECUTE = 3;
localparam MEMORY = 4;
localparam WRITE_BACK = 5;

//R type instructions
localparam ADD = 'h20;
localparam SLL = 'h00;
localparam SUB = 'h22;

//I type instructions
localparam LUI = 'hf;
localparam ORI = 'hd;
localparam ADDI = 'h8;

reg [2:0] State;
reg reg_ALUSrcA,reg_IorD,reg_RegWrite,reg_RegDst,reg_MemtoReg,reg_MemWrite;
reg [1:0] reg_ALUSrcB; 
reg [2:0] reg_ALUControl;
reg [127:0] STATE_DEBUG;
always@(posedge clk or negedge reset) begin
	if (reset==0)
		State <= IDLE;
	else begin
		case (State)
		IDLE: State <= FETCH;
		FETCH: State <= DECODE;
		DECODE: State <= EXECUTE;
		EXECUTE: State <= MEMORY;
		MEMORY: State <= WRITE_BACK;
		WRITE_BACK: State <= FETCH;
		endcase
	end
end

always@(State,reg_ALUControl,reg_ALUSrcB,reg_ALUSrcA,reg_IorD,reg_RegWrite,reg_RegDst,reg_MemtoReg,reg_MemWrite)begin
	case (State)
		IDLE: 		{IorD, MemWrite, IRWrite, PCWrite, Branch, PCSrc, ALUControl, ALUSrcB, ALUSrcA, RegWrite, RegDst, MemtoReg,STATE_DEBUG} = {15'b0,({128{1'b0}}|"IDLE")};
		FETCH: 		{IorD, MemWrite, IRWrite, PCWrite, Branch, PCSrc, ALUControl, ALUSrcB, ALUSrcA, RegWrite, RegDst, MemtoReg,STATE_DEBUG} = {15'b0_0_1_1_0_0_000_01_0_0_0_0,({128{1'b0}}|"FETCH")};
		DECODE:		{IorD, MemWrite, IRWrite, PCWrite, Branch, PCSrc, ALUControl, ALUSrcB, ALUSrcA, RegWrite, RegDst, MemtoReg,STATE_DEBUG} = {15'b0,({128{1'b0}}|"DECODE")};
		EXECUTE: 	{IorD, MemWrite, IRWrite, PCWrite, Branch, PCSrc, ALUControl, ALUSrcB, ALUSrcA, RegWrite, RegDst, MemtoReg,STATE_DEBUG} = {6'b0_0_0_0_0_0,reg_ALUControl,reg_ALUSrcB,reg_ALUSrcA,3'b0,({128{1'b0}}|"EXECUTE")};
		MEMORY: 		{IorD, MemWrite, IRWrite, PCWrite, Branch, PCSrc, ALUControl, ALUSrcB, ALUSrcA, RegWrite, RegDst, MemtoReg,STATE_DEBUG} = {reg_IorD,8'b0,3'b1_10,reg_RegWrite,reg_RegDst,reg_MemtoReg,({128{1'b0}}|"MEMORY")};
		WRITE_BACK:	{IorD, MemWrite, IRWrite, PCWrite, Branch, PCSrc, ALUControl, ALUSrcB, ALUSrcA, RegWrite, RegDst, MemtoReg,STATE_DEBUG} = {reg_IorD, reg_MemWrite,13'b0,({128{1'b0}}|"WRITE_BACK")};	
		default:		{IorD, MemWrite, IRWrite, PCWrite, Branch, PCSrc, ALUControl, ALUSrcB, ALUSrcA, RegWrite, RegDst, MemtoReg,STATE_DEBUG} = {15'b0,({128{1'b0}}|"DEFAULT")};
	endcase
end

always @(Op, Funct) begin
	if (Op == 0) begin //R type
		{reg_ALUSrcB, reg_ALUSrcA,reg_IorD,reg_RegWrite,reg_RegDst,reg_MemtoReg,reg_MemWrite} <= 8'b00_1_0_1_1_0_0;
		case(Funct)
			ADD: 		reg_ALUControl <= 3'b000;
			SLL: 		reg_ALUControl <= 3'b001;
			SUB: 		reg_ALUControl <= 3'b100;
			default: reg_ALUControl <= 3'b000;
		endcase
	end else begin
		{reg_ALUSrcB,reg_ALUSrcA,reg_IorD,reg_RegWrite,reg_RegDst,reg_MemtoReg,reg_MemWrite} <= 'b10_1_0_1_0_0_0;
		case (Op)
			LUI: 		reg_ALUControl <= 3'b101;
			ORI: 		reg_ALUControl <= 3'b010;
			ADDI:    reg_ALUControl <= 3'b000;
			default: reg_ALUControl <= 3'b101;
		endcase
	end
end

endmodule