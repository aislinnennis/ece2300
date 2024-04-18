module alu(A, B, FS, Y, C, V, N, Z);
  input  [7:0]  A;
  input  [7:0]  B;
  input  [2:0]  FS;

  output [7:0]  Y;
  output        C;
  output        V;
  output        N;
  output        Z;


  /* ADD YOUR CODE BELOW THIS LINE */

  adder ad(
    .A(),
    .B(),
    .CI(),
    .Y(),
    .C(),
    .V()
  );

  /* ADD YOUR CODE ABOVE THIS LINE */


endmodule
