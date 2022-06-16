module top(clk,rst);
	input logic clk;
	input logic rst;

	//wires for connecting design units
	logic [31:0] pc_in;
	logic [31:0] pc_alu;
	logic [31:0] pc;
	logic [31:0] pc_4;
	logic [31:0] instruc;
	logic [6:0] opcode; //opcode[6:0]
	logic [2:0] f3; //f3[12:14]
	logic [4:0] rs1,rs2,rd;//rd->[11:7], rs1->[19:15], rs2->[24:20]
	logic [6:0] f7;//f7->[31:25]
	logic [8:0] cntrl_bits;
	logic w_en;
	logic [31:0] rd_data;
	logic [31:0] rs1_data;
	logic [31:0] rs2_data;
	logic [31:0] operand_1;
	logic [31:0] operand_2;
	logic [31:0] wb_data;
	
	
	//control signals
	logic pc_sel;
	logic [2:0] imm_sel;
	logic reg_wen;
	logic brUn;
	logic b_sel;
	logic a_sel;
	logic [3:0] alu_sel;
	logic memRw;
	logic [1:0] wb_sel;
	logic [1:0] sw_imm_sel;
	logic [2:0] lw_imm_sel;
	//extended_imm
	logic [31:0] ext_imm;
	//comparator ports
	logic breq;
	logic brlt;
	//data mem ports
	logic [31:0] mem_out;
	logic [31:0] store_extended;
	logic [31:0] lw_extended;
	
	//fetch
	pc u1(pc_in,clk,rst,pc_4,pc);
	
	imem u2(pc,instruc);
	
	//decode 
	assign opcode = instruc[6:0];
	assign f3 = instruc[14:12];
	assign rs1 = instruc[19:15];
	assign rs2 = instruc[24:20];
	assign rd = instruc[11:7];
	assign f7 = instruc[31:25];
	assign cntrl_bits = {instruc[30],f3,instruc[6:2]};

	control u3(cntrl_bits,breq,brlt,pc_sel,imm_sel,reg_wen,brUn,b_sel,a_sel,alu_sel,memRw,wb_sel,sw_imm_sel,lw_imm_sel);
	imm_gen u4(imm_sel,instruc,ext_imm);
	reg_file u5(clk,reg_wen,rd,rs1,rs2,wb_data,rs1_data,rs2_data);
	//comp for branches
	comparator u6(rs1_data,rs2_data,brUn,breq,brlt);
	
	//execute
	alu_op u7(operand_1,operand_2,alu_sel,rd_data);
	
	//rd_data is calculated addr,
	//rs2_data is in case of store, 
	//mem_out is signal to recieve
	sw_imm_gen u8(rs2_data,sw_imm_sel,store_extended);
	//mem
	data_mem u9(clk,rd_data,store_extended,mem_out,memRw);
	lw_imm_gen u10(mem_out,lw_imm_sel,lw_extended);
	
	
	////MUX's
	//bsel mux
	assign operand_2 = b_sel ? ext_imm: rs2_data;//operand2 can either be from reg or imm
	//asel mux
	assign operand_1 = a_sel ? pc : rs1_data;//operand1 can either be pc or rs1
	assign pc_in = pc_sel ? rd_data : pc_4; 
	always_comb//write back mux
		begin
			case(wb_sel)
					2'b00:	wb_data = lw_extended;
					2'b01:	wb_data = rd_data;
					2'b10:	wb_data = pc_4;
					2'b11: 	wb_data = ext_imm;
			endcase
		end
	
endmodule
