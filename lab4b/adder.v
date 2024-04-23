module adder(A, B, CI, Y, C, V);

  // inputs
  input [7:0] A, B;
  input CI;

  // outputs
  output [7:0] Y;
  output C, V;

  /* ADD YOUR CODE BELOW THIS LINE */
  wire [7:0] c;
  
  assign Y[0] = (A[0] ^ B[0] ^ CI);
  assign Y[1] = (A[1] ^ B[1] ^ c[0]);
  assign Y[2] = (A[2] ^ B[2] ^ c[1]);
  assign Y[3] = (A[3] ^ B[3] ^ c[2]);
  assign Y[4] = (A[4] ^ B[4] ^ c[3]);
  assign Y[5] = (A[5] ^ B[5] ^ c[4]);
  assign Y[6] = (A[6] ^ B[6] ^ c[5]);
  assign Y[7] = (A[7] ^ B[7] ^ c[6]);
  
  
  assign c[0] = (A[0] & B[0]) |  (A[0] & CI) | (B[0] & CI); 
  assign c[1] = (A[1] & B[1]) |  (A[1] & c[0]) | (B[1] & c[0]); 
  assign c[2] = (A[2] & B[2]) |  (A[2] & c[1]) | (B[2] & c[1]); 
  assign c[3] = (A[3] & B[3]) |  (A[3] & c[2]) | (B[3] & c[2]); 
  assign c[4] = (A[4] & B[4]) |  (A[4] & c[3]) | (B[4] & c[3]); 
  assign c[5] = (A[5] & B[5]) |  (A[5] & c[4]) | (B[5] & c[4]); 
  assign c[6] = (A[6] & B[6]) |  (A[6] & c[5]) | (B[6] & c[5]); 
  assign c[7] = (A[7] & B[7]) |  (A[7] & c[6]) | (B[7] & c[6]); 

  
  assign C = c[7];
  
  assign V = (c[7] == c[6]) ? 1'b0 : 1'b1;


endmodule
