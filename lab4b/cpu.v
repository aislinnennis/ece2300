module cpu(CLK, RESET, EN_L, Iin, Din, PC, NextPC, DataA, DataB, DataC, DataD, MW);
  input         CLK;
  input         RESET;
  input         EN_L;
  input  [15:0] Iin;
  input  [7:0]  Din;

  output [7:0]  PC;
  output [7:0]  NextPC;
  output [7:0]  DataA;
  output [7:0]  DataB;
  output [7:0]  DataC;
  output [7:0]  DataD;
  output        MW;

  /* ADD YOUR CODE BELOW THIS LINE */
  // initializing other wires
  wire [2:0] DR; // write address
  wire [2:0] SA; // read address A
  wire [2:0] SB; // read address B
  wire [5:0] IMM;
  wire [7:0] IMM_SE;
  wire MB; // alu input mux select: =0 DataB, =1 IMM
  wire [2:0] FS;
  wire MD; // output mux select: =0 ALU, =1 data RAM
  wire LD; // reg file write enable
  wire [2:0] BS;
  wire [5:0] OFF;
  wire HALT;

  decoder deco (
    .INST(Iin),
    .DR(DR),
    .SA(SA),
    .SB(SB),
    .IMM(IMM),
    .MB(MB),
    .FS(FS),
    .MD(MD),
    .LD(LD),
    .MW(MW),
    .BS(BS),
    .OFF(OFF),
    .HALT(HALT)
  );

  regfile REGG(
    .SA(SA),
    .SB(SB),
    .LD(LD),
    .DR(DR),
    .D_in(DataC),
    .CLK(CLK),
    .DATA_A(DataA),
    .DATA_B(DataB),
	 .RESET(RESET)
  );
 
  SE immediate(
	.IN(IMM),
	.OUT(IMM_SE)
);
 
  wire C;
  wire V;
  wire N;
  wire Z;
  
  alu noice (
    .A(DataA),
    .B(MB ? IMM_SE : DataB),
    .OP(FS),
    .Y(DataD),
    .C(C),
    .V(V),
    .N(N),
    .Z(Z)
  );
  
  wire H;
  
  HALT h(
  .CLK(CLK),
  .HALT(HALT),
  .EN_L(EN_L),
  .H(H)
  );
  
  wire MP;
  assign MP = BS==3'd4 ? 1'b0 : BS==3'd3 ? N : BS==3'd2 ? ~N : BS==3'd1 ? ~Z : Z;
  
  wire [7:0] OFF_SE;

  SE offset(
	.IN(OFF),
	.OUT(OFF_SE)
);
  
  assign NextPC = H ? PC : MP ? PC+8'd2+(OFF_SE<<<1) : PC+8'd2;
 
  always @(posedge CLK) begin
	if (RESET) begin
		PC <= 8'd0;
	end 
	else begin
		PC <= NextPC;
	end
  end
  
  
  assign DataC = MD ? Din : DataD;
  
  /* ADD YOUR CODE ABOVE THIS LINE */

endmodule
