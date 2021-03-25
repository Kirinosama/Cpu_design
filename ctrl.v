`include "ctrl_encode_def.v"
`include "instruction_def.v"

module ctrl(
    input [5:0] opcode,
    input [5:0] func,
    output reg [1:0] RegDst,
    output reg ALUSrc,
    output reg MemRead,
    output reg RegWrite,
    output reg MemWrite,
    output reg [1:0] DatatoReg,
    output reg [1:0] PC_sel,
    output reg ExtOp,
    output reg [4:0] ALUCtrl
    );
	
	always @(opcode or func ) begin
		case(opcode)
			//addu,subu
		`INSTR_RTYPE_OP:   // R type  
				case(func)
					//addu
				`INSTR_ADDU_FUNCT:
					begin
						RegDst = 2'b01;
						ALUSrc = 2'b00;
						MemRead = 0;
						RegWrite = 1;
						MemWrite = 0;
						DatatoReg = 2'b00;
						PC_sel = 2'b00;
						ExtOp = 0;
						ALUCtrl = `ALUOp_ADDU;	
						
					end

				//addi
				`INSTR_ADDI_FUNCT:
				begin
					RegDst = 2'b00;
					ALUSrc = 2'b01;
					MemRead = 0;
					RegWrite = 1;
					MemWrite = 0;
					DatatoReg = 2'b00;
					PC_sel = 2'b00;
					ExtOp = 1;
					ALUCtrl = `ALUOp_ADD;		
				end
			
					//subu
				`INSTR_SUBU_FUNCT:
					begin
						RegDst = 2'b01;
						ALUSrc = 2'b00;
						MemRead = 0;
						RegWrite = 1;
						MemWrite = 0;
						DatatoReg = 2'b00;
						PC_sel = 2'b00;
						ExtOp = 0;
						ALUCtrl = `ALUOp_SUBU;		
						
					end								
				
				// sll
				`INSTR_SLL_FUNCT:
				begin
					RegDst = 2'b01; //00写寄存器rt 01写寄存器rd
					AlUSrc = 2'b10; //0 读2 1 立即数
					MemRead = 0;
					RegWrite = 1;
					MemWrite = 0;
					DatatoReg = 2'b00; // 00:Alu 01:Mem
					PC_sel=2'b00; //00 pc+4 01: pc+immediate
					ExtOp = 0; //符号扩展
					ALUCtrl = `ALUOp_SLL;		
				end

				// srl
				`INSTR_SRL_FUNCT:
				begin
					RegDst = 2'b01; //00写寄存器rt 01写寄存器rd
					AlUSrc = 2'b10; //0 读2 1 立即数
					MemRead = 0;
					RegWrite = 1;
					MemWrite = 0;
					DatatoReg = 2'b00; // 00:Alu 01:Mem
					PC_sel=2'b00; //00 pc+4 01: pc+immediate
					ExtOp = 0; //符号扩展
					ALUCtrl = `ALUOp_SRL;		
				end

				// sra
				`INSTR_SLA_FUNCT:
				begin
					RegDst = 2'b01; //00写寄存器rt 01写寄存器rd
					AlUSrc = 2'b10; //01立即数 10用sa 11立即数+sa
					MemRead = 0;
					RegWrite = 1;
					MemWrite = 0;
					DatatoReg = 2'b00; // 00:Alu 01:Mem
					PC_sel=2'b00; //00 pc+4 01: pc+immediate
					ExtOp = 0; //符号扩展
					ALUCtrl = `ALUOp_SRA;		
				end
				//jr
				`INSTR_JR_FUNCT:
				begin
					RegDst = 2'b00; //00写寄存器rt 01写寄存器rd
					AlUSrc = 2'b00; //01立即数 10用sa 11立即数+sa
					MemRead = 0;
					RegWrite = 0;
					MemWrite = 0;
					DatatoReg = 2'b00; // 00:Alu 01:Mem
					PC_sel=2'b11; //00 pc+4 01: pc+immediate 10: j
					ExtOp = 0; //符号扩展
					ALUCtrl = 3'b000;

				//add
				`INSTR_ADD_FUNCT:
				begin
					RegDst = 2'b01; //00写寄存器rt 01写寄存器rd
					AlUSrc = 2'b00; //0 读2 1 立即数
					MemRead = 0;
					RegWrite = 1;
					MemWrite = 0;
					DatatoReg = 2'b00; // 00:Alu 01:Mem
					PC_sel=2'b00; //00 pc+4 01: pc+immediate
					ExtOp = 1; //符号扩展
					ALUCtrl = `ALUOp_ADD;	
				end;

				//sub
				`INSTR_SUB_FUNCT:
				begin
					RegDst = 2'b01; //00写寄存器rt 01写寄存器rd
					AlUSrc = 2'b00; //0 读2 1 立即数
					MemRead = 0;
					RegWrite = 1;
					MemWrite = 0;
					DatatoReg = 2'b00; // 00:Alu 01:Mem
					PC_sel=2'b00; //00 pc+4 01: pc+immediate
					ExtOp = 1; //符号扩展
					ALUCtrl = `ALUOp_SUB;	
				end;	

				//SLT
				`INSTR_SLT_FUNCT:
				begin
					RegDst = 2'b01; //00写寄存器rt 01写寄存器rd
					AlUSrc = 2'b00; //0 读2 1 立即数
					MemRead = 0;
					RegWrite = 1;
					MemWrite = 0;
					DatatoReg = 2'b00; // 00:Alu 01:Mem
					PC_sel=2'b00; //00 pc+4 01: pc+immediate
					ExtOp = 0; //符号扩展
					ALUCtrl = `ALUOp_SLT;		
				end

				endcase//the end of the func
			
			//ori
				`INSTR_ORI_OP:  //6'b001101:
			begin
				RegDst = 2'b00;
				ALUSrc = 2'b01;
				MemRead = 0;
				RegWrite = 1;
				MemWrite = 0;
				DatatoReg = 2'b00;
				PC_sel = 2'b00;
				ExtOp= 0;
				ALUCtrl = `ALUOp_OR;				
			end

			//lui
				`INSTR_LUI_OP:
			begin
				RegDst = 2'b00;
				ALUSrc = 2'b01;
				MemRead = 0;
				RegWrite = 1;
				MemWrite = 0;
				DatatoReg = 2'b00;
				PC_sel = 2'b00;
				ExtOp= 0;
				ALUCtrl = `ALUOp_LUI;				
			end
			
			//or
			`INSTR_OR_OP:
			begin
				RegDst = 2'b01;
				ALUSrc = 2'b00;
				MemRead = 0;
				RegWrite = 1;
				MemWrite = 0;
				DatatoReg = 2'b00;
				PC_sel = 2'b00;
				ExtOp= 0;
				ALUCtrl = `ALUOp_OR;		
			end

			//and
			`INSTR_AND_OP:
			begin
				RegDst = 2'b00;
				ALUSrc = 2'b01;
				MemRead = 0;
				RegWrite = 1;
				MemWrite = 0;
				DatatoReg = 2'b00;
				PC_sel = 2'b00;
				ExtOp= 0;
				ALUCtrl = `ALUOp_AND;	
			end

			//beq 
			`INSTR_BEQ_OP:  
			begin
				RegDst = 2'b00;
				ALUSrc = 2'b00;
				MemRead = 0;
				RegWrite = 0;
				MemWrite = 0;
				DatatoReg = 2'b00;
				PC_sel = 2'b01;
				ExtOp = 0;
				ALUCtrl = `ALUOp_EQL;			
			end

			//bne 
			`INSTR_BNE_OP:  
			begin
				RegDst = 2'b00;
				ALUSrc = 2'b00;
				MemRead = 0;
				RegWrite = 0;
				MemWrite = 0;
				DatatoReg = 2'b00;
				PC_sel = 2'b01;
				ExtOp = 0;
				ALUCtrl = `ALUOp_BNE;			
			end

			//lw
			`INSTR_LW_OP:
			begin
				RegDst = 2'b00
				AlUSrc = 2'b01;
				MemRead = 1;
				RegWrite = 1;
				MemWrite = 0;
				DatatoReg = 2'b01;
				PC_sel=2'b00;
				ExtOp = 1;
				ALUCtrl = `ALUOp_ADD;
			end

			//sw
			`INSTR_SW_OP:
			begin
				RegDst = 2'b01;
				AlUSrc = 2'b01;
				MemRead = 0;
				RegWrite = 0;
				MemWrite = 1;
				DatatoReg = 2'b00;
				PC_sel=2'b00;
				ExtOp = 1;
				ALUCtrl = `ALUOp_ADD;
			end

			// j
			`INSTR_J_OP:
			begin
				RegDst = 2'b00; //00写寄存器rt 01写寄存器rd
				AlUSrc = 2'b00; //01立即数 10用sa 11立即数+sa
				MemRead = 0;
				RegWrite = 0;
				MemWrite = 0;
				DatatoReg = 2'b00; // 00:Alu 01:Mem
				PC_sel=2'b10; //00 pc+4 01: pc+immediate 10: j
				ExtOp = 0; //符号扩展
				ALUCtrl = 3'b000;
			end

			// jal
			`INSTR_JAL_OP:
			begin
				RegDst = 2'b00; //00写寄存器rt 01写寄存器rd
				AlUSrc = 2'b00; //01立即数 10用sa 11立即数+sa
				MemRead = 0;
				RegWrite = 1;
				MemWrite = 0;
				DatatoReg = 2'b00; // 00:Alu 01:Mem
				PC_sel=2'b10; //00 pc+4 01: pc+immediate 10: j
				ExtOp = 0; //符号扩展
				ALUCtrl = 3'b000;
			end

			//SLTI
			`INSTR_SLTI_OP:
			begin
				RegDst = 2'b01; //00写寄存器rt 01写寄存器rd
				AlUSrc = 2'b01; //0 读2 1 立即数
				MemRead = 0;
				RegWrite = 1;
				MemWrite = 0;
				DatatoReg = 2'b00; // 00:Alu 01:Mem
				PC_sel=2'b00; //00 pc+4 01: pc+immediate
				ExtOp = 1; //符号扩展
				ALUCtrl = `ALUOp_SLT;	
			end

			default:
					begin
						RegDst = 2'b00;
						ALUSrc = 2'b00;
						MemRead = 0;
						RegWrite = 0;
						MemWrite = 0;
						DatatoReg = 2'b00;
						PC_sel = 2'b00;
						ExtOp = 0;
						ALUCtrl = 3'b000;
					end
			
		endcase
	 end
	 

endmodule
