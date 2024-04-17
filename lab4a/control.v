module control(OP, CISEL, BSEL, OSEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP); // add other inputs and outputs here

  // inputs (add others here)
  input  [2:0]  OP;
  
  // outputs (add others here)
  output        CISEL;
  output BSEL;
  output [1:0] OSEL;
  output SHIFT_LA;
  output SHIFT_LR;
  output LOGICAL_OP;
  

  // reg and internal variable definitions
  
  
  // implement module here (add other control signals below)
  assign CISEL = (OP == 3'b001) ? 1'b1 : 1'b0;
  assign BSEL = (OP == 3'b000) ? 1'b0 : 1'b1;
  assign OSEL = (OP == 3'b000 | OP == 3'b001) ? 2'b00 : ((OP == 3'b010 | OP == 3'b011 | OP == 3'b100) ? 2'b01 : 2'b10);
  assign SHIFT_LA = (OP == 3'b010) ? 1'b1 : 1'b0;
  assign SHIFT_LR = (OP == 3'b011 | OP == 3'b010) ? 1'b1 : 1'b0;
  assign LOGICAL_OP = (OP == 3'b110) ? 1'b0 : 1'b1;
  
endmodule
