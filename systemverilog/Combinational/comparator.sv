////////////////////////////////////////////////////////////////////////////////
// Module Name  : Equality comparator (1-bit)
// File name    : comparator.sv
// Description  : 1-bit equality comparator
// Type         : Combinational
// Model Style  : behavioral, structural and dataflow
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 18/05/2019
////////////////////////////////////////////////////////////////////////////////

// Truth Table of 1-bit Comparator:
// A    0 0 1 1
// B    0 1 0 1
// Cout 1 0 0 1
//
// Logic Equation of 1-bit Comparator:
// Cout = NOR( XOR(A,B) );

`define MODEL_TYPE DATAFLOW // set default model type

module comparator ( input logic A_DI,
                    input logic B_DI,
                   output logic C_DO );

  // Architecture
  `ifdef DATAFLOW // Model Implementation: Dataflow
    logic temp1_D, temp2_D;

    assign temp1_D = A_DI & B_DI;
    assign temp2_D = ~A_DI & ~B_DI;
    assign C_DO = temp1_D | temp2_D; 

  `elsif BEHAVIORAL // Model Implementation: Behavioral
    always_comb
    begin
      var logic temp1_D, temp2_D;;
      temp1_D = A_DI & B_DI;
      temp2_D = ~A_DI & ~B_DI;
      C_DO = C_DO = temp1_D | temp2_D;
    end

  `elsif STRUCTURAL // Model Implementation: Structural
    logic temp1_D;

    xor x0( temp1_D, A_DI, B_DI );
    nor n0( C_DO, temp1_D );
  `endif
endmodule // comparator