`timescale 1ns / 1ps

module alu8b_tb;

	// Inputs
	reg [7:0] A;
  reg [7:0] B;
  reg       Cin;
  reg [2:0] Opcode;

	// Outputs
	wire [7:0] Result;
  wire       Cout;

  // Instantiate the Unit Under Test (UUT)
	alu8b uut (
		.A_in(A),
		.B_in(B),
    .C_in(Cin),
    .Opcode_in(Opcode),
    .Result_out(Result),
    .C_out(Cout)
	);

  task expect;
    input [7:0] exp_result_out;
    input       exp_c_out;
    if ( (Result !== exp_result_out) || (Cout !== exp_c_out)) begin
      $display("TEST FAILED");
      $display("At time %0d A=%h, B=%h, Cin=%h, Opcode=%h, Result=%h, Cout=%h",
               $time, A, B, Cin, Opcode, Result, Cout);
      $display("Result, Cout should be %h", exp_result_out, exp_c_out );
      $finish;
    end
   else begin
     $display("At time %0d A=%h, B=%h, Cin=%h, Opcode=%h, Result=%h, Cout=%h",
              $time, A, B, Cin, Opcode, Result, Cout);
   end
  endtask

	initial begin
    // Check A+B without cout
    A = 8'hAA;
    B = 8'h02;
    Cin = 1'b0;
    Opcode = 3'b000;
    #10 expect(8'hAC, 1'b0);

    // Check A+B with cout
    A = 8'hFE;
    B = 8'h01;
    Cin = 1'b1;
    Opcode = 3'b000;
    #10 expect(8'h00, 1'b1);

    // Check A-B
    A = 8'hFF;
    B = 8'h01;
    Opcode = 3'b001;
    #10 expect(8'hFE, 1'b0);

    // Check A&B with cout
    A = 8'hAA;
    B = 8'h55;
    Opcode = 3'b010;
    #10 expect(8'h00, 1'b0);

    // Check A|B with cout
    A = 8'hAA;
    B = 8'h55;
    Opcode = 4'b011;
    #10 expect(8'hFF, 1'b0);

    // Check A%B with cout
    A = 8'd10;
    B = 8'd3;
    Opcode = 3'b100;
    #10 expect(8'h01, 1'b0);

    // Check wrong opcode
    Opcode = 3'b101;
    #10 expect(8'h00, 1'b0);

    // Check wrong opcode
    Opcode = 3'b110;
    #10 expect(8'h00, 1'b0);

    // Check wrong opcode
    Opcode = 3'b111;
    #10 expect(8'h00, 1'b0);

		$display("TEST PASSED");
		$finish;
	end

endmodule
