module lw_imm_gen(in,cntrl,out);
	input logic [31:0] in;
	input logic [2:0] cntrl;
	output logic [31:0] out;
	
	always_comb
		begin
			case(cntrl)
				3'b000:	out = in;
				3'b001: out = {{16{in[15]}},in[15:0]}; //lh
				3'b010: out = {{24{in[7]}},in[7:0]}; //lb
				3'b011: out = {{16{1'b0}},in[15:0]}; //lhu
				3'b100: out = {{24{1'b0}},in[7:0]}; //lbu
			endcase
		end

endmodule
