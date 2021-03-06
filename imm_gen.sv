module imm_gen(imm_sel,instruc,imm_out);
	input logic [2:0] imm_sel;
	input logic [31:0] instruc;
	output logic [31:0] imm_out;

always_comb
	begin
		case(imm_sel)
			3'b000://addi lw imm
				begin
					imm_out={{20{instruc[31]}},instruc[31:20]};
				end
			3'b001://sw imm
				begin
					imm_out={{20{instruc[31]}},instruc[31:25],instruc[11:7]};	
				end
			3'b010://branch imm
				begin
					imm_out={{19{instruc[31]}},instruc[31],instruc[7],instruc[30:25],instruc[11:8],1'b0};
				end
			3'b011://j type
				begin
					imm_out={{11{instruc[31]}},instruc[31],instruc[18:12],instruc[19],instruc[30:20],1'b0};
				end
			3'b100://u type
					imm_out={{instruc[31:12]},12'd0};
			3'b101://shamt instructions srai
				begin
					imm_out={{27{1'b0}},instruc[24:20]};
				end

		endcase
	end
endmodule
