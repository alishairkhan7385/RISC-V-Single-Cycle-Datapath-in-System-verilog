
module TB_S_C_Processor;
reg clk=1,reset;

top dut(clk,reset);

always #50 clk = ~clk;

initial
begin
	reset = 1;
	#100
	reset = 0;
	#16000;
//dut.print();
//$finish;
end

endmodule
