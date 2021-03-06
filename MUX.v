
module RegDst_mux(
		input [1:0] RegDst,
		input [20:16] Instrl_rs,
		input [15:11] Instrl_rt,
		output reg [4:0] Reg_rd
    );
	 
	always@(RegDst or Instrl_rs or Instrl_rt)begin
		case(RegDst)
			2'b00: Reg_rd = Instrl_rs[20:16];
			2'b01: Reg_rd = Instrl_rt[15:11];	
			2'b10: Reg_rd = 31;	
		endcase
	end
endmodule



module ALUSrc_muxb(
	input [31:0] grf_out,
	input [31:0] extend_out,
	input ALUSrc,
	output reg [31:0] ALUSrc_mux_out
	);	
	
	always@(grf_out or extend_out or ALUSrc)begin
		if(ALUSrc == 2'b01) ALUSrc_mux_out = extend_out;
		else if(ALUSrc == 2'b11) ALUSrc_mux_out = extend_out;
		else ALUSrc_mux_out = grf_out;
	en
endmodule

module ALUSrc_muxa(
	input [31:0] grf_out,
	input [4:0] SA,
	input ALUSrc,
	output reg [31:0] ALUSrc_mux_out
	);	
	
	always@(grf_out or extend_out or ALUSrc)begin
		if(ALUSrc == 2'b10) ALUSrc_mux_out = {{27{1'b0}},SA};
		else if(ALUSrc == 2'b11) ALUSrc_mux_out = {{27{1'b0}},SA}; 
		else ALUSrc_mux_out = grf_out;
	end
endmodule

module DatatoReg_mux(
	input [31:0] ALU_data,
	input [31:0] Mem_data,
	input [1:0]  DatatoReg,
	output reg [31:0] DatatoReg_out
	);
	
	always@(ALU_data or Mem_data or DatatoReg)begin
		case(DatatoReg)
			2'b00: DatatoReg_out = ALU_data;
			2'b01: DatatoReg_out = Mem_data;			
		endcase
	end
	
	
endmodule
