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
  wire  [2:0] ADDRESS;
  wire  [9:0] DATA;

  reg    [3:0]  STATE;
  reg    [3:0]  NEXT_STATE;

  wire  	   DONE;
  reg        SIGNAL;
  reg			   LOAD;
  reg [3:0]  SCORE_A;
  reg [3:0]  SCORE_B;
  reg [3:0]  WINNER;

  // ---------------- The FSM -----------------------------------
  /* Lab task: PLEASE DEFINE AND ENCODE OTHER STATES */

  reg [3:0] state, next_state;

  localparam INIT_STATE = 4'd0, Users_Ready = 4'b0001, Counter_Hits = 4'b0010, A_Wins = 4'b0011, B_Wins = 4'b100;

  // update state FFs
	always @(posedge CLK)
	begin
		if (RESET)
			state <= Init;
		else 
			state <= next_state;
	end

  // nest state logic (combinational)
  /* Lab task: PLEASE FINISH THE NEXT STATE LOGIC */
  always @(*) begin
    case (state)
			Init : if (NEXT == 0) next_state = Users_Ready; else next_state = Init;
			Users_Ready : if (DONE == 1) next_state = Counter_Hits; else next_state = Users_Ready;
			Counter_Hits : if (PLAYER_A == 0) next_state = A_Wins; else if (PLAYER_B == 0) next_state = B_Wins; else next_state = Counter_Hits;
			//if ((PLAYER_A == 0 & PLAYER_B == 0) || (PLAYER_A == 0 & PLAYER_B == 1)) next_state = A_Wins; else if (PLAYER_A == 1 & PLAYER_B == 0) next_state = B_Wins; else if (PLAYER_A == 1 & PLAYER_B == 1) next_state = Counter_Hits; else next_state = Counter_Hits;
			A_Wins : next_state = A_Wins;
			B_Wins : next_state = B_Wins;
			default : next_state = Init;
		endcase
	end

  // Moore output logic (combinational)
  assign FALSE_START = 1'b0; // in part A, FALSE_START is 0
  /* Lab task: PLEASE FINISH THE OUTPUT LOGIC */
 always @(*)
	begin	
		case (state)
			Init : begin
				SCORE_A = 0; 
				SCORE_B = 0; 
				WINNER = 4'b0000; 
				FALSE_START = 0;
				SIGNAL = 0;
				STATE = state;
				end
			Users_Ready : begin
				SCORE_A = 0; 
				SCORE_B = 0; 
				WINNER = 4'b0000; 
				FALSE_START = 0;
				SIGNAL = 0;
				STATE = state;
				end
			Counter_Hits : begin
				SCORE_A = 0; 
				SCORE_B = 0; 
				WINNER = 4'b0000; 
				FALSE_START = 0;
				SIGNAL = 1;
				STATE = state;
				end
			A_Wins : begin
				SCORE_A = 1; 
				SCORE_B = 0; 
				WINNER = 4'b1010; 
				FALSE_START = 0;
				SIGNAL = 1;
				STATE = state;
				end
			B_Wins : begin
				SCORE_A = 0; 
				SCORE_B = 1; 
				WINNER = 4'b1011; 
				FALSE_START = 0;
				SIGNAL = 1;
				STATE = state;
				end
			default: begin
				SCORE_A = 0; 
				SCORE_B = 0; 
				WINNER = 4'b0000;
				FALSE_START = 0;
				STATE = state;
				end
	
		endcase
	end


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
		.DATA(DATA)
	);

endmodule
