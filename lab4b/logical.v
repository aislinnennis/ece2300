module logical(A, B, OA, Y);

  // inputs
  input [7:0] A, B;
  input OA;

  // outputs
  output [7:0] Y;

  /* ADD YOUR CODE BELOW THIS LINE */
	assign Y[7] = ~(OA == 0) ? A[7] | B[7] : A[7] & B[7];
	assign Y[6] = ~(OA == 0) ? A[6] | B[6] : A[6] & B[6];
	assign Y[5] = ~(OA == 0) ? A[5] | B[5] : A[5] & B[5];
	assign Y[4] = ~(OA == 0) ? A[4] | B[4] : A[4] & B[4];
	assign Y[3] = ~(OA == 0) ? A[3] | B[3] : A[3] & B[3];
	assign Y[2] = ~(OA == 0) ? A[2] | B[2] : A[2] & B[2];
	assign Y[1] = ~(OA == 0) ? A[1] | B[1] : A[1] & B[1];
	assign Y[0] = ~(OA == 0) ? A[0] | B[0] : A[0] & B[0];
	
	
	
  

  /* ADD YOUR CODE ABOVE THIS LINE */

endmodule
