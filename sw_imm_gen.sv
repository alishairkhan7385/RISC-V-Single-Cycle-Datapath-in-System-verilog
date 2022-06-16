module sw_imm_gen(in,cntrl,out);
//in is rs2_data
//cntrl is from cntrl unit which tells which instruction is this,sw,sh,sb
//out is extended
	input logic [31:0] in;
	input logic [1:0] cntrl;
	output logic [31:0] out;
	
	always_comb
		begin
			case(cntrl)
				2'b00: out = in;//sw, no need extension
				2'b01: 	out = {{16{in[15]}},in[15:0]}; //sh
				2'b10: out = {{24{in[7]}},in[7:0]};//sb
			endcase
		end
endmodule
