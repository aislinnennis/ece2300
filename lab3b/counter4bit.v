module counter4bit(CLK, RESET, ENABLE, COUNT);

input CLK;
input RESET;
input ENABLE;

output  [3:0] COUNT;
reg	[3:0]	COUNT;

always @ (posedge CLK) begin
	if (RESET == 1'b1) begin
		COUNT = 4'b0000;
	end
	else if (ENABLE == 1'b1) begin
		COUNT = COUNT + 4'b0001;
	end
end
endmodule 
