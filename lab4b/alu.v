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
  wire BSEL;
  wire CISEL;
  wire [7:0] ADDER_Y;
  wire [7:0] SHIFT_Y;
  wire [7:0] LOGICAL_Y;
  wire SHIFT_LA;
  wire SHIFT_LR;
  wire LOGICAL_OA;
  wire carry_out_add;
  wire carry_out_shift;
  wire overflow;
  wire [1:0] OSEL;
  wire [1:0] CSEL;
  
  
  adder add(
    .A(A),
    .B(BSEL ? B : ~B),
    .CI(CI),
    .Y(ADDER_Y),
    .C(carry_out_add),
    .V(overflow)
  );
  
  
  shifter shift(
    .A(A),
    .LA(SHIFT_LA),
    .LR(SHIFT_LR),
    .Y(SHIFT_Y),
    .C(carry_out_shift)
  );
 
 
  logical logical(
    .A(A),
    .B(B),
    .OA(LOGICAL_OA),
    .Y(LOGICAL_Y)
  ); 
  

   control control(
    .FS(FS),
    .BSEL(BSEL),
    .CISEL(CISEL),
    .OSEL(OSEL),
	 .SHIFT_LA(SHIFT_LA),
	 .SHIFT_LR(SHIFT_LR),
	 .LOGICAL_OA(LOGICAL_OA),
	 .CSEL(CSEL)
  ); 
  
  
  // formula for ternary operator :
 // VALUE = CONDITION ? (WHAT VALUE EQUALS IF CONDITION IS TRUE): (WHAT VALUE EQUALS IF CONDITION IS FALSE);
  //assign Y = ((FS == 3'b000 | FS == 3'b001) ? ADDER_Y : (FS == 3'b010 | FS == 3'b011 | FS == 3'b100) ? SHIFT_Y : LOGICAL_Y);
  assign Y = ((OSEL == 2'b00) ? ADDER_Y : (OSEL == 2'b01) ? SHIFT_Y : LOGICAL_Y);
  assign C = ((CSEL == 2'b00) ? carry_out_add : (CSEL == 2'b01) ? 1'b0 : carry_out_shift);
  assign V = (FS == 3'b000 | FS == 3'b001) ? overflow : 1'b0;
  assign N = Y[7];
  assign Z = (Y == 8'b0);
  assign BI = BSEL ? B : ~B;
  assign CI = CISEL ? 1'b0 : 1'b1;

  /* ADD YOUR CODE ABOVE THIS LINE */
  





endmodule
