module pc (in,clk,rst,out_4,out);
	input logic [31:0] in;
	input logic clk,rst;
	output logic [31:0] out;
	output logic [31:0] out_4;
always_ff @(posedge clk)
begin 
	if(rst)
		begin
			out<=32'd0;
			out_4<=32'd4;
		end
	else
		begin
			out<=in;
			out_4<=in+32'd4;
		end
end

endmodule
