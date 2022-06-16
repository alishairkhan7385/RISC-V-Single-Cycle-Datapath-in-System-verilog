
module imem(
	input logic [31:0] pc,
	output logic [31:0] intr
		);
logic [31:0] in_mem [1024:0];
logic [31:0] addr;
initial begin
	$readmemb("data.bin",in_mem,0,1024);
	$monitor("imem, %b",in_mem[0]);
end
assign addr = pc >> 2; 
assign intr = in_mem[addr];
endmodule
