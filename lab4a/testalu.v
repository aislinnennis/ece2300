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
  wire [7:0] Y_ADDER;
  wire [7:0] Y_SHIFTER;
  wire [7:0] Y_LOGICAL;
  
  wire C_ADDER;
  wire C_SHIFTER;
  wire N_ADDER;
  wire N_LOGICAL;
  wire N_SHIFTER;
  wire Z_ADDER;
  wire Z_SHIFTER;
  wire Z_LOGICAL;
  
  wire CISEL;
  wire BSEL;
  wire [1:0] OSEL;
  wire SHIFT_LA;
  wire SHIFT_LR;
  wire LOGICAL_OP;
  wire CI_ADDER;
  wire [7:0] B_MUX;
  
  assign Y = (OSEL == 2'b00) ? Y_ADDER : ((OSEL == 2'b01) ? Y_SHIFTER : Y_LOGICAL);
  assign B_MUX = (BSEL == 1'b0) ? B : ~B;
  assign CI_ADDER = (CISEL == 1'b1) ? 1'b1 : 1'b0;
  assign N = ((Y[7] == 1'b1) ? 1'b1 : 1'b0);
  assign Z = ((Y == 8'b00000000) ? 1'b1 : 1'b0);
  assign C = (FS == 3'b000 | FS == 3'b001) ? C_ADDER : (FS == 3'b101 || FS == 3'b110) ? 1'b0 : C_SHIFTER;
  
  adder adder1(
  .A(A),
	.B(B_MUX),
	.CI(CI_ADDER),
	.Y(Y_ADDER),
	.C(C_ADDER),
	.V(V)
  );

    control control1(
   .FS(FS),
	 .CISEL(CISEL),
	 .BSEL(BSEL),
	 .OSEL(OSEL),
	 .SHIFT_LA(SHIFT_LA),
	 .SHIFT_LR(SHIFT_LR),
	 .LOGICAL_OP(LOGICAL_OP)
  );

   logical logical1(
   .A(A),
	 .B(B),
   .FS(~(~FS[0] & FS[1] & FS[2])),
	 .Y(Y_LOGICAL)
  );  
  
  shifter shifter1(
	  .A(A),
    .LA(~FS[0] & FS[1] & ~FS[2]),
    .LR((FS[0] & FS[1] & ~FS[2]) | (~FS[0] & FS[1] & ~FS[2])),
 	  .Y(Y_SHIFTER),
	  .C(C_SHIFTER)
  );
  
  /* ADD YOUR CODE ABOVE THIS LINE */


endmodule
