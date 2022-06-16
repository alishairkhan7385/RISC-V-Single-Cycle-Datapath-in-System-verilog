module data_mem(clk,addr,data_write,data_read,mem_rw);
	input logic clk;
	input logic [31:0] addr;
	input logic [31:0] data_write;
	output logic [31:0] data_read;
	input logic mem_rw;

logic [31:0] mem [0:100];

always_ff @(posedge clk)
	begin
		if(mem_rw)
			mem[addr]<=data_write;
	end
assign data_read = mem[addr];

endmodule
