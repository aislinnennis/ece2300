module control(FS, BSEL, OSEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP); // add other outputs here

  // inputs
  input  [2:0]  FS;

  // constants for the function select
  // good practice that helps readablity
  // and save you from typing lots of numerical constants
  localparam FS_ADD = 3'b000;
  localparam FS_SUB = 3'b001;
  localparam FS_SRA = 3'b010;
  localparam FS_SRL = 3'b011;
  localparam FS_SLL = 3'b100;
  localparam FS_AND = 3'b101;
  localparam FS_OR  = 3'b110;

  /* ADD YOUR CODE BELOW THIS LINE */

  // outputs (add others here)
  output reg BSEL;
  output     CISEL;
  output [1:0] OSEL;
  output SHIFT_LA;
  output SHIFT_LR;
  output LOGICAL_OP;

  // constants for outputs (you can add more)
  // good practice that helps readablity
  // and save you from typing lots of numerical constants
  localparam BSEL_B  = 1'b0;
  localparam BSEL_BN = 1'b1;

  // internal variables (you can add more)

  // implement the control logic here
  always @(*) begin
    case (FS)
      FS_ADD: begin
        BSEL = BSEL_B;
      end
      FS_SUB: begin
        BSEL = BSEL_BN;
      end
      FS_SRA: begin
      end
      FS_SRL: begin
      end
      FS_SLL: begin
      end
      FS_AND: begin
      end
      FS_OR: begin
      end
      default: begin
        BSEL = 1'b0;
      end
    endcase
  end

  /* ADD YOUR CODE ABOVE THIS LINE */

endmodule
