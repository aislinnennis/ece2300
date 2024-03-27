// Provided for ECE 2300 Lab 3
module lab3(CLK, RESET, NEXT, PLAYER_A, PLAYER_B, TEST_LOAD, SIGNAL, SCORE_A, SCORE_B, WINNER, STATE, FALSE_START, ADDRESS, DATA);
  input CLK;
  input RESET;
  input NEXT;
  input PLAYER_A;
  input PLAYER_B;
  input TEST_LOAD;

  output SIGNAL;
  output [3:0] SCORE_A;
  output [3:0] SCORE_B;
  output reg [3:0] WINNER;
  output reg [3:0] STATE;
  output reg FALSE_START;
  output [2:0] ADDRESS;
  output [9:0] DATA;
 
  wire LOAD;
  wire DONE;
  wire ENABLE_A;
  wire ENABLE_B;
  
 // ---------------- Other Modules ---------------------------
  /* Lab task: instantiate and connect the following modules:
               address_generator
               prandom
               countdown
  */  
  
  address_generator a (
.CLK(CLK),
.RESET(RESET),
.ADDRESS(ADDRESS)
  );
 
  prandom p (
.ADDRESS(ADDRESS),
.DATA(DATA)
  );
 
  countdown c (
.CLK(CLK),
.LOAD(LOAD),
.RESET(RESET),
.DATA(STATE == 4'b0010 ? 10'd8 : DATA),
.DONE(DONE)
  );

 // ---------------- The FSM -----------------------------------
  /* Lab task: PLEASE DEFINE AND ENCODE OTHER STATES */	
  
  reg [3:0] SCURR, SNEXT;
  localparam init = 4'b0000;
  localparam start = 4'b0001;
  localparam led = 4'b0010;
  localparam countdown = 4'b0011;
  localparam a_false = 4'b0100;
  localparam b_false = 4'b0101;
  localparam ready = 4'b0110;
  localparam a_won = 4'b0111;
  localparam b_won = 4'b1000;
  localparam false_win = 4'b1001;
  localparam a_false_win = 4'b1010;
  localparam b_false_win = 4'b1011;
  localparam normal_win = 4'b1100;
  localparam a_normal_win = 4'b1101;
  localparam b_normal_win = 4'b1110;
 
  assign SIGNAL = ((SCURR == led) | (SCURR == a_won) | (SCURR == b_won) | (SCURR == countdown) | (SCURR == ready) | (SCURR == normal_win) | (SCURR == false_win));
  assign LOAD = ((SCURR == led) | (SCURR == init) | (SCURR == false_win) | (SCURR == normal_win));
  assign ENABLE_A = ((SCURR == a_won) | (SCURR == b_false));
  assign ENABLE_B = ((SCURR == b_won) | (SCURR == a_false));
 
  counter4bit a_count_score (
.CLK(CLK),
.ENABLE(ENABLE_A),
.RESET(RESET),
.COUNT(SCORE_A)
  );
 
  counter4bit b_count_score (
.CLK(CLK),
.ENABLE(ENABLE_B),
.RESET(RESET),
.COUNT(SCORE_B)
  );
 
  //OUTPUTS
  always @(*) begin
 case(SCURR)
init: begin WINNER = 4'b0000; STATE = init; FALSE_START = 0; end
start: begin WINNER = 4'b0000; STATE = start; FALSE_START = 0; end
led: begin WINNER = 4'b0000; STATE = led; FALSE_START = 0; end
countdown: begin WINNER = 4'b0000; STATE = countdown; FALSE_START = 0; end
a_false: begin WINNER = 4'b0000; STATE = a_false; FALSE_START = 1; end
b_false: begin WINNER = 4'b0000; STATE = b_false; FALSE_START = 1; end
ready: begin WINNER = 4'b0000; STATE = ready; FALSE_START = 0; end
a_won: begin WINNER = 4'b1010; STATE = a_won; FALSE_START = 0; end
b_won: begin WINNER = 4'b1011; STATE = b_won; FALSE_START = 0; end
false_win: begin WINNER = 4'b0000; STATE = false_win; FALSE_START = 1; end
a_false_win: begin WINNER = 4'b1010; STATE = a_false_win; FALSE_START = 1; end
b_false_win: begin WINNER = 4'b1011; STATE = b_false_win; FALSE_START = 1; end
normal_win: begin WINNER = 4'b0000; STATE = normal_win; FALSE_START = 0; end
a_normal_win: begin WINNER = 4'b1010; STATE = a_normal_win; FALSE_START = 0; end
b_normal_win: begin WINNER = 4'b1011; STATE = b_normal_win; FALSE_START = 0; end
default: begin WINNER = 4'b0000; STATE = start; FALSE_START = 0; end
endcase
end

//NEXT STATES
always @(*) begin
case(SCURR)
init: if(~NEXT) SNEXT = start; else SNEXT = init;
start: if(~PLAYER_A) SNEXT = a_false; else if(PLAYER_A & ~PLAYER_B) SNEXT = b_false; else if(DONE) SNEXT = led; else SNEXT = start;
led: if(~PLAYER_A) SNEXT = a_false; else if(PLAYER_A & ~PLAYER_B) SNEXT = b_false; else SNEXT = countdown;
  countdown: if(~PLAYER_A) SNEXT = a_false; else if(PLAYER_A & ~PLAYER_B) SNEXT = b_false; else if(DONE) SNEXT = ready; else SNEXT = countdown;
  a_false: SNEXT = false_win;
  b_false: SNEXT = false_win;
  ready: if(~PLAYER_B & PLAYER_A) SNEXT = b_won; else if(~PLAYER_A) SNEXT = a_won; else SNEXT = ready;
    a_won: SNEXT = normal_win;
  b_won: SNEXT = normal_win;
  false_win: if(SCORE_A == 4'b0101) SNEXT = a_false_win; else if(SCORE_B == 4'b0101) SNEXT = b_false_win; else if(~NEXT) SNEXT = start; else SNEXT = false_win;
  a_false_win: SNEXT = a_false_win;
  b_false_win: SNEXT = b_false_win;
  normal_win: if(SCORE_A == 4'b0101) SNEXT = a_normal_win; else if(SCORE_B == 4'b0101) SNEXT = b_normal_win; else if(~NEXT) SNEXT = start; else SNEXT = normal_win;
  a_normal_win: SNEXT = a_normal_win;
  b_normal_win: SNEXT = b_normal_win;
endcase
end
 
//MOVE
always @(posedge CLK) begin
if (RESET) SCURR <= init; else SCURR <= SNEXT;
end

  
endmodule 
