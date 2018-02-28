/******************************************************************* 
* Name:
*	Memory.v
* Description:
* 	This module instances single port ROM and ROM for Instruction/Data Memory
* Inputs:
*	Adr: Common address for both instances
*	WE: Write enable used for RAM
*	WD: Write Data
*	clk: clock
* Outputs:
* 	RD: Output Data
* Versión:  
*	1.0
* Author: 
*	Christian Aparicio Zuleta
* Fecha: 
*	05/05/2017 
*********************************************************************/
module Memory 
#(parameter DATA_WIDTH, parameter ADDR_WIDTH, parameter ADDR_SIZE)
(
	input [ADDR_WIDTH-1:0] Adr,
	input [DATA_WIDTH-1:0] WD,
	input WE, clk,
	output [DATA_WIDTH-1:0] RD
);
wire [DATA_WIDTH-1:0] rom_out;
wire [DATA_WIDTH-1:0] ram_out;

single_port_rom
#(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .ADDR_SIZE(ADDR_SIZE))
ROM
(.addr(Adr), .clk(clk), .q(rom_out));

single_port_ram
#(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH))
RAM
(.data(WD),.addr(Adr), .we(WE), .clk(clk), .q(ram_out));

Mux2to1
#(.WORD_LENGTH(DATA_WIDTH))
Mux_out
(.selector(WE), .Data_0(rom_out), .Data_1(ram_out), .Mux_Output(RD));
endmodule