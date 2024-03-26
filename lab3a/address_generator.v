module address_generator(CLK,RESET,ADDRESS);

input CLK;
input RESET;
output [2:0] ADDRESS;

reg [2:0] ADDRESS;

always @(posedge CLK) begin
  /* Lab task: implement RESET logic */
	if (RESET == 1'b1) ADDRESS <= 3'd0;
	else ADDRESS <= ADDRESS + 3'd1;
end

endmodule
