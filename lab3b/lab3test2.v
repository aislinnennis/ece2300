// Provided for ECE 2300 Lab 3
module lab3(CLK, RESET, NEXT, PLAYER_A, PLAYER_B, TEST_LOAD, SIGNAL, SCORE_A, SCORE_B, WINNER, STATE, FALSE_START, ADDRESS, DATA);
  input         CLK;
  input         RESET;
  input         NEXT;
  input         PLAYER_A;
  input         PLAYER_B;
  input         TEST_LOAD;

  output        SIGNAL;
  output [3:0]  SCORE_A;
  output [3:0]  SCORE_B;
  output [3:0]  WINNER;
  output [3:0]  STATE;
  output        FALSE_START;
  output [2:0]  ADDRESS;
  output [9:0]  DATA;

  reg    [3:0]  STATE;

  reg [3:0] SCORE_A;
  reg [3:0] SCORE_B;
  reg [3:0] WINNER;
  reg FALSE_START;
  wire LOAD;
  wire DONE;

  reg [3:0] state, next_state;
  
// ---------------- Other Modules ---------------------------
  /* Lab task: instantiate and connect the following modules:
               address_generator
               prandom
               countdown
  */
  
    address_generator instance1(
		.RESET(RESET),
		.CLK(CLK),
		.ADDRESS(ADDRESS)
	);

  	prandom instance2 (
		.ADDRESS(ADDRESS),
		.DATA(DATA)
	);

	countdown instance3(
		.RESET(RESET),
		.CLK(CLK),
		.LOAD(LOAD),
		.DONE(DONE),
		.DATA(STATE == 4'b0010 ? 10'd8 : DATA)
	);

// ---------------- The FSM -----------------------------------
  /* Lab task: PLEASE DEFINE AND ENCODE OTHER STATES */	

  localparam Init = 4'b0000;
  localparam Users_Ready = 4'b0001;
  localparam Counter_Hits = 4'b0010;
  localparam countdown = 4'b0011;
  localparam A_False = 4'b0100;
  localparam B_False = 4'b0101;
  localparam ready = 4'b0110;
  localparam A_Won = 4'b0111;
  localparam B_Won = 4'b1000;
  localparam False_Win = 4'b1001;
  localparam A_False_Win = 4'b1010;
  localparam B_False_Win = 4'b1011;
  localparam Normal_Win = 4'b1100;
  localparam A_Normal_Win = 4'b1101;
  localparam B_Normal_Win = 4'b1110;
 
  assign SIGNAL = ((state == Counter_Hits) | (state == A_Won) | (state == B_Won) | (state == countdown) | (state == ready) | (state == Normal_Win) | (state == False_Win));
  assign LOAD = ((state == Counter_Hits) | (state == Init) | (state == False_Win) | (state == Normal_Win));
  assign ENABLE_A = ((state == A_Won) | (state == B_False));
  assign ENABLE_B = ((state == B_Won) | (state == A_False));
 
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
 
// output logic
  always @(*) begin
 case(state)
    Init: begin WINNER = 4'b0000; STATE = Init; FALSE_START = 0; end
    Users_Ready: begin WINNER = 4'b0000; STATE = Users_Ready; FALSE_START = 0; end
    Counter_Hits: begin WINNER = 4'b0000; STATE = Counter_Hits; FALSE_START = 0; end
    countdown: begin WINNER = 4'b0000; STATE = countdown; FALSE_START = 0; end
    A_False: begin WINNER = 4'b0000; STATE = A_False; FALSE_START = 1; end
    B_False: begin WINNER = 4'b0000; STATE = B_False; FALSE_START = 1; end
    ready: begin WINNER = 4'b0000; STATE = ready; FALSE_START = 0; end
    A_Won: begin WINNER = 4'b1010; STATE = A_Won; FALSE_START = 0; end
    B_Won: begin WINNER = 4'b1011; STATE = B_Won; FALSE_START = 0; end
    False_Win: begin WINNER = 4'b0000; STATE = False_Win; FALSE_START = 1; end
    A_False_Win: begin WINNER = 4'b1010; STATE = A_False_Win; FALSE_START = 1; end
    B_False_Win: begin WINNER = 4'b1011; STATE = B_False_Win; FALSE_START = 1; end
    Normal_Win: begin WINNER = 4'b0000; STATE = Normal_Win; FALSE_START = 0; end
    A_Normal_Win: begin WINNER = 4'b1010; STATE = A_Normal_Win; FALSE_START = 0; end
    B_Normal_Win: begin WINNER = 4'b1011; STATE = B_Normal_Win; FALSE_START = 0; end
    default: begin WINNER = 4'b0000; STATE = Users_Ready; FALSE_START = 0; end
  endcase
end

always @(*) begin
  case(state)
    Init: if(NEXT == 0) next_state = Users_Ready; else next_state = Init;
    Users_Ready: if(~PLAYER_A) next_state = A_False; else if(PLAYER_A & ~PLAYER_B) next_state = B_False; else if(DONE) next_state = Counter_Hits; else next_state = Users_Ready;
    Counter_Hits: if(~PLAYER_A) next_state = A_False; else if(PLAYER_A & ~PLAYER_B) next_state = B_False; else next_state = countdown;
    countdown: if(~PLAYER_A) next_state = A_False; else if(PLAYER_A & ~PLAYER_B) next_state = B_False; else if(DONE) next_state = ready; else next_state = countdown;
    A_False: next_state = False_Win;
    B_False: next_state = False_Win;
    ready: if(~PLAYER_B & PLAYER_A) next_state = B_Won; else if(~PLAYER_A) next_state = A_Won; else next_state = ready;
    A_Won: next_state = Normal_Win;
    B_Won: next_state = Normal_Win;
    False_Win: if(SCORE_A == 4'b0101) next_state = A_False_Win; else if(SCORE_B == 4'b0101) next_state = B_False_Win; else if(~NEXT) next_state = Users_Ready; else next_state = False_Win;
    A_False_Win: next_state = A_False_Win;
    B_False_Win: next_state = B_False_Win;
    Normal_Win: if(SCORE_A == 4'b0101) next_state = A_Normal_Win; else if(SCORE_B == 4'b0101) next_state = B_Normal_Win; else if(~NEXT) next_state = Users_Ready; else next_state = Normal_Win;
    A_Normal_Win: next_state = A_Normal_Win;
    B_Normal_Win: next_state = B_Normal_Win;
  endcase
 end 
endmodule
