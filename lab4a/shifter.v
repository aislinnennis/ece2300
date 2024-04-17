module shifter(A, LA, LR, Y, C); // add all inputs and outputs inside parentheses

  // inputs
  input [7:0] A;
  input LA;
  input LR;

  // outputs
  output [7:0] Y;
  output C;

  // reg and internal variable definitions
  

  // implement module here
	assign Y[0] = (LR == 0) ? 1'b0 : (LR == 1 & LA == 0) ? A[1] : A[1];
	assign Y[1] = (LR == 0) ? A[0] : (LR == 1 & LA == 0) ? A[2] : A[2];
	assign Y[2] = (LR == 0) ? A[1] : (LR == 1 & LA == 0) ? A[3] : A[3];
	assign Y[3] = (LR == 0) ? A[2] : (LR == 1 & LA == 0) ? A[4] : A[4];
	assign Y[4] = (LR == 0) ? A[3] : (LR == 1 & LA == 0) ? A[5] : A[5];
	assign Y[5] = (LR == 0) ? A[4] : (LR == 1 & LA == 0) ? A[6] : A[6];
	assign Y[6] = (LR == 0) ? A[5] : (LR == 1 & LA == 0) ? A[7] : A[7];
	assign Y[7] = (LR == 0) ? A[6] : (LR == 1 & LA == 0) ? 1'b0 : A[7];
	assign C = (LR == 0) ? A[7] : A[0];
  
endmodule
