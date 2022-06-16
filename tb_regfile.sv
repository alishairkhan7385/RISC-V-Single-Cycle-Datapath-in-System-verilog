module tb_regfile;

logic         clk,en;
logic [4:0]  write_reg, read_reg1, read_reg2;
logic [31:0] write_data;
logic [31:0] read_data1,read_data2;

 reg_file uu(clk,en,write_reg, read_reg1, read_reg2,write_data,read_data1,read_data2);

initial begin
read_reg1=5'd0;
read_reg2=5'd1;
#10;
end
endmodule
