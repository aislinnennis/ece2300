module adder(A, B, FS, Y, C, V); // add all inputs and outputs inside parentheses

  // inputs
  input [7:0] A;
  input [7:0] B;
  input FS;
  
  
  // outputs
  output [7:0] Y;
  output C;
  output V;
  
  // reg and internal variable definitions
  wire [6:0] Cout;
  
  
  assign Y[0] = (A[0] ^ B[0]) ^ FS;
  assign Cout[0] = (FS & B[0]) | (FS & A[0]) | (A[0] & B[0]);
  
  assign Y[1] = (A[1] ^ B[1]) ^ Cout[0];
  assign Cout[1] = (Cout[0] & B[1]) | (FS & A[1]) | (A[1] & B[1]);
  
  assign Y[2] = (A[2] ^ B[2]) ^ Cout[1];
  assign Cout[2] = (Cout[1] & B[2]) | (Cout[1] & A[2]) | (A[2] & B[2]);
  
  assign Y[3] = (A[3] ^ B[3]) ^ Cout[2];
  assign Cout[3] = (Cout[2] & B[3]) | (Cout[2] & A[3]) | (A[3] & B[3]);
  
  assign Y[4] = (A[4] ^ B[4]) ^ Cout[3];
  assign Cout[4] = (Cout[3] & B[4]) | (Cout[3] & A[4]) | (A[4] & B[4]);
  
  assign Y[5] = (A[5] ^ B[5]) ^ Cout[4];
  assign Cout[5] = (Cout[4] & B[5]) | (Cout[4] & A[5]) | (A[5] & B[5]);
  
  assign Y[6] = (A[6] ^ B[6]) ^ Cout[5];
  assign Cout[6] = (Cout[5] & B[6]) | (Cout[5] & A[6]) | (A[6] & B[6]);
  
  assign Y[7] = (A[7] ^ B[7]) ^ Cout[6];
  assign C = (Cout[6] & B[7]) | (Cout[6] & A[7]) | (A[7] & B[7]);
  
  assign V = (C == Cout[6]) ? 1'b0 : 1'b1;
  
endmodule
