module alu_op(rs1_data,rs2_data,alu_op,rd_data);
	input logic [31:0] rs1_data;
	input logic [31:0] rs2_data;
	input logic [3:0] alu_op;
	output logic [31:0] rd_data;



always_comb begin

	case(alu_op)
			4'b0000: rd_data = rs1_data + rs2_data;//add
			4'b0010: rd_data = rs1_data - rs2_data;//sub
			4'b0011: rd_data = rs1_data ^ rs2_data;//xor
			4'b0100: rd_data = rs1_data | rs2_data;//or
			4'b0101: rd_data = rs1_data & rs2_data;//and
			4'b0110:  rd_data = rs1_data << rs2_data;//shift left logical sll
			4'b0111:  rd_data = rs1_data >> rs2_data;//right shift logical 
			4'b1000:  rd_data = $signed(rs1_data) >>> rs2_data;//shift right arithmetic
			4'b1001:  rd_data = ($signed(rs1_data) < $signed(rs2_data)) ? 1'b1 : 1'b0 ;//slt (set less than)
			4'b1010:  rd_data = (rs1_data <  rs2_data) ? 1'b1 : 1'b0 ;//set less than usigned
	
	endcase
end 
endmodule
