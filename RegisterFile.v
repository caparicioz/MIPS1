/******************************************************************* 
* Name:
*	RegisterFile.v
* Description:
* A sequential multiplier using shift registers and adders is implemented
* Inputs:
*	start: Tells the hardware when is appropiate to begin working 
*  Multiplier:Data to be multiplied
*  Multiplicand: Multiplies multiplier
*	clk: clock signal
*  reset: reset signal
* Outputs:
* 	ready: tells when the data is ready at the output or can begin working
*	Product: the result of the multiplication 
* VersiÃƒÆ’Ã‚Â³n:  
*	1.0
* Author: 
*	Christian Aparicio Zuleta
* Fecha: 
*	04/03/2017 
*********************************************************************/
module RegisterFile 
#(
	parameter WORD_LENGTH = 32,
	parameter NUM_REGISTERS = 32,
	parameter READ_REGISTER_LENGTH = CeilLog(NUM_REGISTERS),
	parameter CONTROL_WORD_LENGTH = CeilLog(WORD_LENGTH)
)
(
	//Inputs
	input [READ_REGISTER_LENGTH-1:0]read_register_1,
	input [READ_REGISTER_LENGTH-1:0]read_register_2,
	input [CONTROL_WORD_LENGTH-1:0]write_register,
	input [WORD_LENGTH-1:0] write_data,
	input write, clk, reset,
	
	//Outputs
	output [WORD_LENGTH-1:0] read_data_1,
	output [WORD_LENGTH-1:0] read_data_2
);
reg [NUM_REGISTERS-1:0] write_select_reg;
wire [WORD_LENGTH-1:0] output_reg [NUM_REGISTERS-1:0];
reg [WORD_LENGTH-1:0] reg_read_data_1;
reg [WORD_LENGTH-1:0] reg_read_data_2;
Register
#(
	.WORD_LENGTH(WORD_LENGTH)
)
RegisterUnit
(
	.clk(clk),
	.reset(reset),
	.Data_Input({WORD_LENGTH{1'b0}}),
	.enable(1'b1),
	.Data_Output(output_reg[0])
	);
integer j;
genvar i;
generate
	for (i = 1; i < NUM_REGISTERS; i = i+1) begin: register_inst 
	Register
	#(
		.WORD_LENGTH(WORD_LENGTH)
	)
	RegisterUnit
	(
		.clk(clk),
		.reset(reset),
		.Data_Input(write_data),
		.enable(write_select_reg[i]),
		.Data_Output(output_reg[i])
	);
	end
endgenerate
//Multiplexer 32:1
always @(read_register_1) begin
	case(read_register_1)
		0: reg_read_data_1 = output_reg[0];
		1: reg_read_data_1 = output_reg[1];
		2: reg_read_data_1 = output_reg[2] ;
		3: reg_read_data_1 = output_reg[3] ;
		4: reg_read_data_1 = output_reg[4] ;
		5: reg_read_data_1 = output_reg[5] ;
		6: reg_read_data_1 = output_reg[6] ;
		7: reg_read_data_1 = output_reg[7] ;
		8: reg_read_data_1 = output_reg[8] ;
		9: reg_read_data_1 = output_reg[9] ;
		10: reg_read_data_1 = output_reg[10] ;
		11: reg_read_data_1 = output_reg[11] ;
		12: reg_read_data_1 = output_reg[12] ;
		13: reg_read_data_1 = output_reg[13] ;
		14: reg_read_data_1 = output_reg[14] ;
		15: reg_read_data_1 = output_reg[15] ;
		16: reg_read_data_1 = output_reg[16] ;
		17: reg_read_data_1 = output_reg[17] ;
		18: reg_read_data_1 = output_reg[18] ;
		19: reg_read_data_1 = output_reg[19] ;
		20: reg_read_data_1 = output_reg[20] ;
		21: reg_read_data_1 = output_reg[21] ;
		22: reg_read_data_1 = output_reg[22] ;
		23: reg_read_data_1 = output_reg[23] ;
		24: reg_read_data_1 = output_reg[24] ;
		25: reg_read_data_1 = output_reg[25] ;
		26: reg_read_data_1 = output_reg[26] ;
		27: reg_read_data_1 = output_reg[27] ;
		28: reg_read_data_1 = output_reg[28] ;
		29: reg_read_data_1 = output_reg[29] ;
		30: reg_read_data_1 = output_reg[30] ;
		31: reg_read_data_1 = output_reg[31] ;	
	endcase
end





always @(read_register_2) begin
	case(read_register_2)
		0: reg_read_data_2= output_reg[0];
		1: reg_read_data_2= output_reg[1];
		2: reg_read_data_2= output_reg[2] ;
		3: reg_read_data_2= output_reg[3] ;
		4: reg_read_data_2= output_reg[4] ;
		5: reg_read_data_2= output_reg[5] ;
		6: reg_read_data_2= output_reg[6] ;
		7: reg_read_data_2= output_reg[7] ;
		8: reg_read_data_2= output_reg[8] ;
		9: reg_read_data_2= output_reg[9] ;
		10: reg_read_data_2= output_reg[10] ;
		11: reg_read_data_2= output_reg[11] ;
		12: reg_read_data_2= output_reg[12] ;
		13: reg_read_data_2= output_reg[13] ;
		14: reg_read_data_2= output_reg[14] ;
		15: reg_read_data_2= output_reg[15] ;
		16: reg_read_data_2= output_reg[16] ;
		17: reg_read_data_2= output_reg[17] ;
		18: reg_read_data_2= output_reg[18] ;
		19: reg_read_data_2= output_reg[19] ;
		20: reg_read_data_2= output_reg[20] ;
		21: reg_read_data_2= output_reg[21] ;
		22: reg_read_data_2= output_reg[22] ;
		23: reg_read_data_2= output_reg[23] ;
		24: reg_read_data_2= output_reg[24] ;
		25: reg_read_data_2= output_reg[25] ;
		26: reg_read_data_2= output_reg[26] ;
		27: reg_read_data_2= output_reg[27] ;
		28: reg_read_data_2= output_reg[28] ;
		29: reg_read_data_2= output_reg[29] ;
		30: reg_read_data_2= output_reg[30] ;
		31: reg_read_data_2= output_reg[31] ;		
	endcase
end

//Configuración One hot enable de 32 registros
always @(write_register, write) begin
			for (j=0; j<NUM_REGISTERS;j=j+1)
				if ((j == write_register) & (write)) write_select_reg[j] = 1'b1;
				else write_select_reg [j] = 1'b0;			
end 
//assign write_select_reg[NUM_REGISTERS-1:0] = {{NUM_REGISTERS-write_register{1'b0}},1'b1,{write_register-1'b1{1'b0}}};
assign read_data_1 = reg_read_data_1;
assign read_data_2 = reg_read_data_2;
/*********************************************************************************************/
 /*Log Function*/
     function integer CeilLog;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog = result;
       end
    endfunction
/*********************************************************************************************/
endmodule