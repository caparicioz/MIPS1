module Mux4to1
#(
	parameter WORD_LENGTH
)
(
	// Input Ports
	input [1:0]selector,
	input [WORD_LENGTH-1:0]Data_0,
	input [WORD_LENGTH-1:0]Data_1,
	input [WORD_LENGTH-1:0]Data_2,
	input [WORD_LENGTH-1:0]Data_3,
	// Output Ports
	output [WORD_LENGTH-1:0] Mux_Output
);
wire [WORD_LENGTH-1:0] wire_muxa;
wire [WORD_LENGTH-1:0] wire_muxb;
Mux2to1
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Mux_A
(
	.selector(selector[0]),
	.Data_0(Data_0),
	.Data_1(Data_1),
	.Mux_Output(wire_muxa)
);

Mux2to1
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Mux_B
(
	.selector(selector[0]),
	.Data_0(Data_2),
	.Data_1(Data_3),
	.Mux_Output(wire_muxb)
);
Mux2to1
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Mux_C
(
	.selector(selector[1]),
	.Data_0(wire_muxa),
	.Data_1(wire_muxb),
	.Mux_Output(Mux_Output)
);
endmodule