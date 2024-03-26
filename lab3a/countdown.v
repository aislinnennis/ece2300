module countdown (CLK, RESET, LOAD, DATA, DONE);

input CLK;
input RESET;
input LOAD;
input [9:0] DATA;

output DONE;

reg DONE;
reg [9:0] COUNT;

/* Lab task: assign DONE with the correct value */

always @(posedge CLK) begin
	if (RESET) begin
		COUNT<=10'b0000000000;
		DONE<=1'b1;
	end
	else if (LOAD) begin
		COUNT <= DATA;
		DONE <= 1'b0;
	end
	else begin
		if (COUNT == 10'b0000000001) begin	
			DONE<=1'b1;
		end
		else begin
			DONE<=1'b0;
		end
		COUNT<=COUNT-10'b0000000001;
	end
end

endmodule
