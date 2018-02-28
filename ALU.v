/******************************************************************* 
* Name:
*	ALU.v
* Description:
* 	This module is a Behavioral Alu
* Inputs:
*	clk: clock signal
*  reset: reset signal
*  enable: enable signal
*  control: input data that selects the operation to be done
*  A: input data
*	B: Input data
* Outputs:
* 	C: Output data
*  carry: operation overflow 
* Versión:  
*	1.0
* Author: 
*	Christian Aparicio Zuleta
* Fecha: 
*	05/02/2017 
*********************************************************************/
module ALU
#(
	parameter WORD_LENGTH
)
(
	//inputs
	input signed [WORD_LENGTH-1:0] A,
	input signed [WORD_LENGTH-1:0] B,
	input [2:0] Control,
	
	//outputs
	output signed [WORD_LENGTH-1:0] C
); 

//Registros internos
reg signed[WORD_LENGTH-1: 0] reg_C;

//Bloque combinacional
always@* begin
		case(Control[2:0])
				3'd0:	reg_C = A + B;								//Suma
				3'd1: reg_C = B << 4;							//sll
				3'd2: reg_C = A | B;								//Or
				3'd3: reg_C = A & B;								//and
				3'd4: reg_C = A - B;								//Resta
				3'd5: reg_C = {B[15:0],16'b0};				//lui
				default: reg_C = 'h40_0000;
			endcase
end

assign C = reg_C;
endmodule
