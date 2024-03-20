module countdown(RESET, CLK, LOAD, DATA, DONE);

input CLK;
input LOAD;
input [9:0] DATA;
input RESET;

output DONE;

reg DONE;
reg [9:0] timer;

always @(posedge CLK) begin
	if (RESET) begin
		timer<=10'b0000000000;
		DONE<=1'b1;
	end
	else if (LOAD) begin
		timer <= DATA;
		DONE <= 1'b0;
	end
	else begin
		if (timer == 10'b0000000001) begin	
			DONE<=1'b1;
		end
		else begin
			DONE<=1'b0;
		end
		timer<=timer-10'b0000000001;
	end
end
endmodule
