////////////////////////////////////////////////////////////////////////////////
// Module Name  : Equality comparator (2-bit)
// File name    : comparator_2.sv
// Description  : 2-bit equality comparator  
// Type         : Combinational
// Model Style  : behavioral, structural and dataflow
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 18/05/2019
////////////////////////////////////////////////////////////////////////////////

// Truth Table of 2-bit Comparator:
// A[0] 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1
// A[1] 0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1
// B[0] 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1
// B[1] 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1
// Cout 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1
//
// Boolean Logic Equation of 2-bit Comparator:
// Cout = !A[0].!A[1].!B[0].!B[1] + 
//        !A[0].A[1].!B[0].B[1]   +
//        A[0].!A[1].B[0].!B[1]   +
//        A[0].A[1].B[0].B[1]

`define STRUCTURAL // set default model type

module comparator_2 ( input logic [1:0] A_DI,
                      input logic [1:0] B_DI,
                     output logic       C_DO );

  // Architecture
  `ifdef DATAFLOW // Model Implementation: Dataflow
    logic temp1_D, temp2_D, temp3_D, temp4_D;

    assign temp1_D = ~A_DI[0] & ~A_DI[1] & ~B_DI[0] & ~B_DI[1];
    assign temp2_D = ~A_DI[0] & A_DI[1] & ~B_DI[0] & B_DI[1];
    assign temp3_D = A_DI[0] & ~A_DI[1] & B_DI[0] & ~B_DI[1];
    assign temp4_D = A_DI[0] & A_DI[1] & B_DI[0] & B_DI[1];
    assign C_DO = temp1_D | temp2_D | temp3_D | temp4_D;

  `elsif BEHAVIORAL // Model Implementation: Behavioral
    
    always_comb begin : proc_comb_comp
      var logic temp    
    end

  `elsif STRUCTURAL // Model Implementation: Structural
    logic temp1_D, temp2_D;

    comparator comp1( .A_DI(A_DI[0]), .B_DI(B_DI[0]), .C_DO(temp1_D));
    comparator comp2( .A_DI(A_DI[1]), .B_DI(B_DI[1]), .C_DO(temp2_D));
    and( C_DO, temp1_D, temp2_D );

  `endif  
endmodule // comparator_2