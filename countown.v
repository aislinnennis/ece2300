module countdown (CLK, RESET, LOAD, DATA, DONE);

input CLK;
input RESET;
input LOAD;
input [9:0] DATA;

output DONE;

reg DONE;
reg [9:0] COUNT;

/* Lab task: assign DONE with the correct value */

always @ (posedge CLK) begin
	if (RESET == 1'b1) begin 
		COUNT <= 10'd0;
		DONE <= 1'b1;
	end

	else if (LOAD == 1'b1) begin
		COUNT <= DATA;
		DONE <=1'b0;
	end

	else begin
		COUNT <= COUNT - 10'd1;
		DONE <= 1'b1;
	end
end
