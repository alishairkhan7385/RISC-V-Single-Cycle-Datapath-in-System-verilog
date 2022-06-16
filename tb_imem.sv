module tb_imem;
	logic [31:0] pc;
	logic [31:0] intr;
	
imem dut(pc,intr);
initial begin
pc=32'd0;
end
endmodule
