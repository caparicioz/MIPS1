// Quartus II Verilog Template
// Single Port ROM

module single_port_rom
#(parameter DATA_WIDTH, parameter ADDR_WIDTH, parameter ADDR_SIZE)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the ROM variable
	//reg [7:0] rom[((INSTR_COUNT*4)+ TEXT_BASE_ADDR - 1): TEXT_BASE_ADDR];
	reg [DATA_WIDTH-1:0] rom[ADDR_SIZE-1:0];

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file single_port_rom_init.txt.  Without this file,
	// this design will not compile.

	initial
	begin
		$readmemb("mips1.dat", rom);
	end

	always @ (posedge clk)
	begin
		q <= rom[addr];
	end

endmodule
