
module npc(
	input [31:0] grf_a,
   input [31:0] oldPC,
	 input [31:0] beq_imm,
	 input  beq_zero,    
    input [1:0] PC_sel,   
    output reg [31:0] newPC
    );

	 always @(oldPC or beq_imm or beq_zero or PC_sel) begin
		case(PC_sel)
			2'b00:	newPC = oldPC + 4;
			2'b01:			
				if(beq_zero == 1) newPC = oldPC + 4 + {{14{beq_imm[15]}},beq_imm[15:0],2'b00};//beq
				else newPC = oldPC + 4;	
			2'b10: newPC = 	{(oldPC + 4)[31:28],beq_imm[25:0],2'b00}; //j
			2'b11: newPC = grf_a;
					
		endcase		
	
	 end	 

endmodule
