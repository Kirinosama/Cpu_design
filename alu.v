
`include "ctrl_encode_def.v"

module alu(
    input [31:0] A,
    input [31:0] B,
    input [4:0] ALUOp,
    output reg [31:0] C,
	 output reg zero
    );
	

	 always @(A or B or ALUOp) begin
		case(ALUOp)
			`ALUOp_ADDU: C = A + B;         //addu
			`ALUOp_SUBU: C = A - B;         //subu
			`ALUOp_OR: C = A | B; 
			`ALUOp_AND: C = A & B; 
			`ALUOp_EQL: zero=(A==B)?1'b1:1'b0;//beq
			`ALUOp_BNE: zero=(A==B)?1'b0:1'b1;//bne
			`ALUOp_ADD: C = $signed(A) + $signed(B);	
			`ALUOp_SUB: C = $signed(A) - $signed(B);			
			`ALUOp_LUI: C = B << 16;
			`ALUOp_SLL: C = B << A;
			`ALUOp_SRL: C = B >> A;
			`ALUOp_SRA: C = ($signed(B)) >>> A;
			`ALUOp_SLT: C = ($signed(A)<$signed(B))?1'b1:1'b0;
		endcase
	 end
	 


endmodule



