module alu_top(CLK50, SW, KEY, LEDR, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
  input         CLK50;
  input  [9:0]  SW;
  input  [3:0]  KEY;

  output [9:0]  LEDR;
  output [6:0]  HEX5;
  output [6:0]  HEX4;
  output [6:0]  HEX3;
  output [6:0]  HEX2;
  output [6:0]  HEX1;
  output [6:0]  HEX0;

  wire   [7:0]  A;
  wire   [7:0]  B;
  wire   [7:0]  Y;
  wire   [2:0]  FS;
  wire          C;
  wire          V;
  wire          N;
  wire          Z;

  alu theALU(
	 .A(A),
	 .B(B),
	 .FS(FS),
	 .Y(Y),
	 .C(C),
	 .V(V),
	 .N(N),
	 .Z(Z)
  );

  dual_reg_in inputs(
	 .CLK(CLK50),
	 .IN(SW[7:0]),
	 .SEL(SW[8]),
	 .WEN_L(KEY[3]),
	 .OUTA(A),
	 .OUTB(B)
  );

  opsel rotate_fs(
	 .CLK(CLK50),
	 .SEL_L(KEY[0]),
	 .OP(FS)
  );

  assign LEDR[9:8] = 2'b0;
  assign LEDR[7] = C;
  assign LEDR[6] = V;
  assign LEDR[5] = N;
  assign LEDR[4] = Z;
  assign LEDR[3] = 1'b0;
  assign LEDR[2:0] = FS;

  // SEVEN-SEGMENT DISPLAY DRIVERS

  hex_to_seven_seg upperBitsOfA(
    .B(A[7:4]),
    .SSEG_L(HEX5)
  );

  hex_to_seven_seg lowerBitsOfA(
    .B(A[3:0]),
    .SSEG_L(HEX4)
  );

  hex_to_seven_seg upperBitsOfB(
    .B(B[7:4]),
    .SSEG_L(HEX3)
  );

  hex_to_seven_seg lowerBitsOfB(
    .B(B[3:0]),
    .SSEG_L(HEX2)
  );
  hex_to_seven_seg upperBitsOfY(
    .B(Y[7:4]),
    .SSEG_L(HEX1)
  );

  hex_to_seven_seg lowerBitsOfY(
    .B(Y[3:0]),
    .SSEG_L(HEX0)
  );

endmodule
