module decoder(INST); // add outputs

input [15:0] INST;

/* ADD YOUR CODE BELOW THIS LINE */

// declare outputs

/* ADD YOUR CODE ABOVE THIS LINE */

// parse the instruction feilds
wire [3:0] OP;
wire [2:0] RS;
wire [2:0] RT;
wire [2:0] RD;
wire [2:0] FUNCT;
wire [5:0] IMM_INST;

assign OP = INST[15:12];
assign RS = INST[11:9];
assign RT = INST[8:6];
assign RD = INST[5:3];
assign FUNCT = INST[2:0];
assign IMM_INST = INST[5:0];

/* ADD YOUR CODE BELOW THIS LINE */

always @(*) begin
	case (OP)
	// implement decoder logic here
		default: begin
		end
	endcase

end

/* ADD YOUR CODE ABOVE THIS LINE */

endmodule
