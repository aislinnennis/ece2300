/*  alu_test.v
    ECE/ENGRD 2300, Spring 2014

    Author: Saugata Ghose
    Last modified: March 28, 2014

    Description: Skeleton test bench for ALU circuit.
*/

// sets the granularity at which we simulate
/*timescale 1 ns / 1 ps


// name of the top-level module; for us it should always be <module name>_test
// this top-level module should have no inputs or outputs; only internal signals are needed
module alu_test();

  // for all of your input pins, declare them as type reg, and name them identically to the pins
  reg  [7:0]  A;
  reg  [7:0]  B;
  reg  [2:0]  FS;

  // for all of your output pins, declare them as type wire so ModelSim can display them
  wire [7:0]  Y;
  wire        C;
  wire        V;
  wire        N;
  wire        Z;


  // declare a sub-circuit instance (Unit Under Test) of the circuit that you designed
  // make sure to include all ports you want to see, and connect them to the variables above
  alu UUT(
    .A(A),
    .B(B),
    .FS(FS),
    .Y(Y),
    .C(C),
    .V(V),
    .N(N),
    .Z(Z) // remember - no comma after the last port
  );

  // ALL of the initial and always blocks below will work in parallel.
  //   Starting at time t = 0, they will all start counting the number
  //   of ticks.


  // TEST CASES: add your test cases in the block here
  // REMEMBER: separate each test case by delays that are multiples of #100, so we can see
  //    the output for at least one cycle (since we chose a 10 MHz clock)
  initial
  begin
    // Initial values
    A  = 8'h0;
    B  = 8'h0;
    FS = 3'b000;

    // wait at the beginning to make sure that we don't start on a rising clock edge -
    //    this guarantees that we give the flip-flops enough setup time
    #100;


    // EXAMPLE TEST CASE: this is the beginning of the first test case

    // it includes input values...
    A  = 8'h01;
    B  = 8'hff;
    FS = 3'b011;  // SRL

    // ... it includes a wait...
    #100;  // wait for input signals to propagate through circuit

    // ... and it includes a statement that checks all of the outputs against the values we expect, and prints whether the operation was correct
    $display("MSIM>");
    if(Y == 8'h0 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> SRL (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: SRL (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 0), C = %1b (should be 1), V = %1b (should be 0), N = %1b (should be 0), Z = %1b (should be 1)", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // EXAMPLE TEST CASE: this is the end of the first test case


    A  = 8'haa;
    B  = 8'hc3;
    FS = 3'b101;  // AND

    #100;  // wait for input signals to propagate through circuit

    $display("MSIM>");
    if(Y == 8'h82 && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> AND (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    else begin
      $display("MSIM> ERROR: AND (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 82), C = %1b (should be 0), V = %1b (should be 0), N = %1b (should be 1), Z = %1b (should be 0)", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");

    /* ADD YOUR TEST CASES BELOW THIS LINE */
	 
	  // ADD Operation Test Cases
    // Test Case 1: Basic Addition
    /*A = 8'h10;
    B = 8'h20;
    FS = 3'b000; // ADD
    #100;
    $display("ADD Test Case 1: A = %h, B = %h, Y = %h, Expected Y = %h", A, B, Y, 8'h30);

    // Test Case 2: Addition with Overflow
    A = 8'hFF;
    B = 8'h01;
    FS = 3'b000; // ADD
    #100;
    $display("ADD Test Case 2: A = %h, B = %h, Y = %h, Expected Y = %h, V = %b", A, B, Y, 8'h00, V);

    // SUB Operation Test Cases
    // Test Case 1: Basic Subtraction
    A = 8'h20;
    B = 8'h10;
    FS = 3'b001; // SUB
    #100;
    $display("SUB Test Case 1: A = %h, B = %h, Y = %h, Expected Y = %h", A, B, Y, 8'h10);

    // Test Case 2: Subtraction Result Negative
    A = 8'h10;
    B = 8'h20;
    FS = 3'b001; // SUB
    #100;
    $display("SUB Test Case 2: A = %h, B = %h, Y = %h, Expected Y = %h", A, B, Y, 8'hF0);

    // SRA Operation Test Cases
    // Test Case 1: Shift Right Arithmetic (retain sign bit)
    A = 8'h80;
    FS = 3'b010; // SRA
    #100;
    $display("SRA Test Case 1: A = %h, Y = %h, Expected Y = %h", A, Y, 8'hC0);

    // Test Case 2: SRA with odd value
    A = 8'h05;
    FS = 3'b010; // SRA
    #100;
    $display("SRA Test Case 2: A = %h, Y = %h, Expected Y = %h", A, Y, 8'h02);

    // SRL Operation Test Cases
    // Test Case 1: Shift Right Logical
    A = 8'h81;
    FS = 3'b011; // SRL
    #100;
    $display("SRL Test Case 1: A = %h, Y = %h, Expected Y = %h", A, Y, 8'h40);

    // Test Case 2: SRL Zero Case
    A = 8'h00;
    FS = 3'b011; // SRL
    #100;
    $display("SRL Test Case 2: A = %h, Y = %h, Expected Y = %h", A, Y, 8'h00);

    // SLL Operation Test Cases
    // Test Case 1: Shift Left Logical
    A = 8'h01;
    FS = 3'b100; // SLL
    #100;
    $display("SLL Test Case 1: A = %h, Y = %h, Expected Y = %h", A, Y, 8'h02);

    // Test Case 2: SLL with high bit overflow
    A = 8'h80;
    FS = 3'b100; // SLL
    #100;
    $display("SLL Test Case 2: A = %h, Y = %h, Expected Y = %h", A, Y, 8'h00);

    // AND Operation Test Cases
    // Test Case 1: Basic AND
    A = 8'hFF;
    B = 8'h0F;
    FS = 3'b101; // AND
    #100;
    $display("AND Test Case 1: A = %h, B = %h, Y = %h, Expected Y = %h", A, B, Y, 8'h0F);

    // Test Case 2: AND Zero Case
    A = 8'hF0;
    B = 8'h0F;
    FS = 3'b101; // AND
    #100;
    $display("AND Test Case 2: A = %h, B = %h, Y = %h, Expected Y = %h", A, B, Y, 8'h00);

    // OR Operation Test Cases
    // Test Case 1: Basic OR
    A = 8'hA0;
    B = 8'h05;
    FS = 3'b110; // OR
    #100;
    $display("OR Test Case 1: A = %h, B = %h, Y = %h, Expected Y = %h", A, B, Y, 8'hA5);

    // Test Case 2: OR Full Case
    A = 8'hFF;
    B = 8'hFF;
    FS = 3'b110; // OR
    #100;
    $display("OR Test Case 2: A = %h, B = %h, Y = %h, Expected Y = %h", A, B, Y, 8'hFF);

    /* ADD YOUR TEST CASES ABOVE THIS LINE */


    // Once our tests are done, we need to tell ModelSim to explicitly stop once we are
    // done with all of our test cases.
	
    /*$stop;
  end

endmodule
/*  alu_test.v
    ECE/ENGRD 2300, Spring 2014
    
    Author: Saugata Ghose
    Last modified: March 28, 2014
    
    Description: Skeleton test bench for ALU circuit.
*/

// sets the granularity at which we simulate
`timescale 1 ns / 1 ps


// name of the tFS-level module; for us it should always be <module name>_test
// this tFS-level module should have no inputs or outputs; only internal signals are needed
module alu_test();

  // for all of your input pins, declare them as type reg, and name them identically to the pins
  reg  [7:0]  A;
  reg  [7:0]  B;
  reg  [2:0]  FS;

  // for all of your output pins, declare them as type wire so ModelSim can display them
  wire [7:0]  Y;
  wire        C;
  wire        V;
  wire        N;
  wire        Z;

  
  // declare a sub-circuit instance (Unit Under Test) of the circuit that you designed
  // make sure to include all ports you want to see, and connect them to the variables above
  alu UUT(
    .A(A),
    .B(B),
    .FS(FS),
    .Y(Y),
    .C(C),
    .V(V),
    .N(N),
    .Z(Z) // remember - no comma after the last port          
  );

  // ALL of the initial and always blocks below will work in parallel.
  //   Starting at time t = 0, they will all start counting the number
  //   of ticks.

  
  // TEST CASES: add your test cases in the block here
  // REMEMBER: separate each test case by delays that are multiples of #100, so we can see
  //    the output for at least one cycle (since we chose a 10 MHz clock)
  initial
  begin
    // Initial values
    A  = 8'h0;
    B  = 8'h0;
    FS = 3'b000;
     
    // wait at the beginning to make sure that we don't start on a rising clock edge -
    //    this guarantees that we give the flip-flFSs enough setup time
    #100;
    
    
    // EXAMPLE TEST CASE: this is the beginning of the first test case
    
    // it includes input values...
    A  = 8'h01;
    B  = 8'hff;
    FS = 3'b011;  // SRL
    
    // ... it includes a wait...
    #100;  // wait for input signals to prFSagate through circuit
    
    // ... and it includes a statement that checks all of the outputs against the values we expect, and prints whether the FSeration was correct
    $display("MSIM>");
    if(Y == 8'h0 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> SRL (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: SRL (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 0), C = %1b (should be 1), V = %1b (should be 0), N = %1b (should be 0), Z = %1b (should be 1)", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");
    
    // EXAMPLE TEST CASE: this is the end of the first test case

    
    A  = 8'haa;
    B  = 8'hc3;
    FS = 3'b101;  // AND
    
    #100;  // wait for input signals to prFSagate through circuit
    
    $display("MSIM>");
    if(Y == 8'h82 && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> AND (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    else begin
      $display("MSIM> ERROR: AND (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 82), C = %1b (should be 0), V = %1b (should be 0), N = %1b (should be 1), Z = %1b (should be 0)", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");
    
    
    // ADD YOUR TEST CASES BELOW THIS LINE
	 
   // Test Cases for ADD
    // Test Case 1: Basic Addition
    A = 8'h10;
    B = 8'h20;
    FS = 3'b000; // FS for ADD
    #100;
    $display("MSIM>");
    if (Y == 8'h30 && C == 1'b0 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> ADD (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: ADD (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 30), C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");
	 
	 A = 8'b11111111;
    B = 8'b11111111;
    FS = 3'b000; // FS for ADD
    #100;
    $display("MSIM>");
    if (Y == 8'hFE && C == 1'b1 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> ADD (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: ADD (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 30), C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");

	 A = 8'b11111111;
    B = 8'b11111111;
    FS = 3'b000; // FS for ADD
    #100;
    $display("MSIM>");
    if (Y == 8'h00 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> ADD (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: ADD (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 30), C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");


    // Test Case 2: Addition with Overflow
    A = 8'h80;
    B = 8'h80;
    FS = 3'b000; // FS for ADD
    #100;
    $display("MSIM>");
    if (Y == 8'h00 && C == 1'b1 && V == 1'b1 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> ADD (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: ADD (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 00), C = %1b, V = %1b (should be 1), N = %1b, Z = %1b (should be 1)", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // Test Cases for SUB
    // Test Case 1: Basic Subtraction
    A = 8'h50;
    B = 8'h30;
    FS = 3'b001; // FS for SUB
    #100;
    $display("MSIM>");
    if (Y == 8'h20 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> SUB (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: SUB (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 20), C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // Test Case 2: Subtraction Result Negative
    A = 8'h30;
    B = 8'h50;
    FS = 3'b001; // FS for SUB
    #100;
    $display("MSIM>");
    if (Y == 8'hE0 && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> SUB (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: SUB (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be E0), C = %1b, V = %1b, N = %1b (should be 1), Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");
	 
 // SRA Operation Test Cases
    // Test Case 1: Shift Right Arithmetic, normal
    A = 8'hF0;  // Binary: 11110000
    FS = 3'b010; // FS for SRA
    #100;
    $display("MSIM>");
    if (Y == 8'hF8 && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> SRA (FS = %3b) is correct for A = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: SRA (FS = %3b) is incorrect for A = %2h: Y = %2h (should be F8), C = %1b, V = %1b, N = %1b (should be 1), Z = %1b", FS, A, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // Test Case 2: SRA, resulting in zero
    A = 8'h01;  // Binary: 00000001
    FS = 3'b010; // FS for SRA
    #100;
    $display("MSIM>");
    if (Y == 8'h00 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> SRA (FS = %3b) is correct for A = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: SRA (FS = %3b) is incorrect for A = %2h: Y = %2h (should be 00), C = %1b (should be 1), V = %1b, N = %1b, Z = %1b (should be 1)", FS, A, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // SRL Operation Test Cases
    // Test Case 1: Shift Right Logical
    A = 8'h81;  // Binary: 10000001
    FS = 3'b011; // FS for SRL
    #100;
    $display("MSIM>");
    if (Y == 8'h40 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> SRL (FS = %3b) is correct for A = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: SRL (FS = %3b) is incorrect for A = %2h: Y = %2h (should be 40), C = %1b (should be 1), V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // Test Case 2: SRL all bits out
    A = 8'hFF;  // Binary: 11111111
    FS = 3'b011; // FS for SRL
    #100;
    $display("MSIM>");
    if (Y == 8'h7F && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> SRL (FS = %3b) is correct for A = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: SRL (FS = %3b) is incorrect for A = %2h: Y = %2h (should be 7F), C = %1b (should be 1), V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // SLL Operation Test Cases
    // Test Case 1: Shift Left Logical
    A = 8'h01;  // Binary: 00000001
    FS = 3'b100; // FS for SLL
    #100;
    $display("MSIM>");
    if (Y == 8'h02 && C == 1'b0 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> SLL (FS = %3b) is correct for A = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: SLL (FS = %3b) is incorrect for A = %2h: Y = %2h (should be 02), C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // Test Case 2: SLL with overflow from MSB
    A = 8'h80;  // Binary: 10000000
    FS = 3'b100; // FS for SLL
    #100;
    $display("MSIM>");
    if (Y == 8'h00 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> SLL (FS = %3b) is correct for A = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: SLL (FS = %3b) is incorrect for A = %2h: Y = %2h (should be 00), C = %1b (should be 1), V = %1b (should be 1), N = %1b, Z = %1b (should be 1)", FS, A, Y, C, V, N, Z);
    end
    $display("MSIM>");
	 
	 A = 8'h55;  // Binary: 10000000
	 B = 8'h48;
    FS = 3'b100; // FS for SLL
    #100;
    $display("MSIM>");
    if (Y == 8'hAA && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> SLL (FS = %3b) is correct for A = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: SLL (FS = %3b) is incorrect for A = %2h: Y = %2h (should be 00), C = %1b (should be 1), V = %1b (should be 1), N = %1b, Z = %1b (should be 1)", FS, A, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // AND Operation Test Cases
    // Test Case 1: Basic AND
    A = 8'hFF;
    B = 8'h0F;
    FS = 3'b101; // FS for AND
    #100;
    $display("MSIM>");
    if (Y == 8'h0F && C == 1'b0 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> AND (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: AND (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 0F), C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // Test Case 2: AND Resulting in Zero
    A = 8'hA0;
    B = 8'h05;
    FS = 3'b101; // FS for AND
    #100;
    $display("MSIM>");
    if (Y == 8'h00 && C == 1'b0 && V == 1'b0 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> AND (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: AND (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 00), C = %1b, V = %1b, N = %1b, Z = %1b (should be 1)", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");

	 A = 8'hF0;
    B = 8'h55;
    FS = 3'b110; // FS for AND
    #100;
    $display("MSIM>");
    if (Y == 8'hF5 && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> OR (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: OR (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 00), C = %1b, V = %1b, N = %1b, Z = %1b (should be 1)", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // OR Operation Test Cases
    // Test Case 1: Basic OR
    A = 8'hA0;
    B = 8'h05;
    FS = 3'b110; // FS for OR
    #100;
    $display("MSIM>");
    if (Y == 8'hA5 && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> OR (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: OR (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be A5), C = %1b, V = %1b, N = %1b (should be 1), Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");

    // Test Case 2: OR Full Bits Set
    A = 8'hFF;
    B = 8'hFF;
    FS = 3'b110; // FS for OR
    #100;
    $display("MSIM>");
    if (Y == 8'hFF && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> OR (FS = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", FS, A, B, Y, C, V, N, Z);
    end else begin
      $display("MSIM> ERROR: OR (FS = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be FF), C = %1b, V = %1b, N = %1b (should be 1), Z = %1b", FS, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");


    // ADD YOUR TEST CASES ABOVE THIS LINE
    

    // Once our tests are done, we need to tell ModelSim to explicitly stFS once we are
    // done with all of our test cases.
    $stop;
  end 

endmodule
