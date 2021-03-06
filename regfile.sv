module reg_file(
input         clk,en,
input  [4:0]  write_reg, read_reg1, read_reg2,
input  [31:0] write_data,
output [31:0] read_data1,read_data2
);

reg [31:0] array[31:0];
integer a, i;
initial
begin
array[0]=32'd0;
end
always@(posedge clk)
begin
	if (en)
		array[write_reg]<=write_data;
end
assign read_data1=array[read_reg1];
assign read_data2=array[read_reg2];
task print;
	for(i=0; i<32; i=i+1)
		$display("Register[%h]=%h", i, array[i]);
endtask

endmodule
