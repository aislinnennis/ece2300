module shifter(A, LA, LR, Y, C);

  // inputs
  input [7:0] A;
  input LA, LR;

  // outputs
  output [7:0] Y;
  output C;

  /* ADD YOUR CODE BELOW THIS LINE */
  wire SHIFT_IN;
  assign SHIFT_IN = LA ? A[7] : 1'b0;
  
  
  assign Y[0] = LR ? A[1] : SHIFT_IN;
  assign Y[1] = LR ? A[2] : A[0];
  assign Y[2] = LR ? A[3] : A[1];
  assign Y[3] = LR ? A[4] : A[2];
  assign Y[4] = LR ? A[5] : A[3];
  assign Y[5] = LR ? A[6] : A[4];
  assign Y[6] = LR ? A[7] : A[5];
  assign Y[7] = LR ? SHIFT_IN : A[6];

  
  assign C = (LR == 1'b0) ? A[7] : (LA == 1'b1) ? A[0] : A[0];

  
  
  /* ADD YOUR CODE ABOVE THIS LINE */

endmodule
