module comparator(rs1_data,rs2_data,brUn,breq,brlt);
	input logic [31:0] rs1_data;
	input logic [31:0] rs2_data;
	
	output logic breq,brlt;
	input logic brUn;

	always_comb 
		begin
			if(brUn)
				begin
					breq=(rs1_data==rs2_data)?1:0;
					brlt=(rs1_data<rs2_data)?1:0;
				end
			else
				begin
					breq=($signed(rs1_data)==$signed(rs2_data))?1:0;
					brlt=($signed(rs1_data)<$signed(rs2_data))?1:0;
				end
		end


endmodule