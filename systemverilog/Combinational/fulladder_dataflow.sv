////////////////////////////////////////////////////////////////////////////////
// Module Name  : fulladder_dataflow
// File name    : fulladder_dataflow.sv
// Description  : 1-bit full-adder
// Type         : Combinational
// Style        : Dataflow
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
////////////////////////////////////////////////////////////////////////////////

// Truth Table of Full-Adder
// i = 1 to n-bits
//
// A[i]     0 0 0 0 1 1 1 1
// B[i]     0 0 1 1 0 0 1 1
// Cin[i]   0 1 0 1 0 1 0 1
// S[i]     0 1 1 0 1 0 0 1
// Cout[i]  0 0 0 1 0 1 1 1
//
// S[i] =  A[i] ^  B[i] ^ C[i]
// Cout[i] = (Cin[i] & ( A[i] ^ B[i] )) | ( A[i] & B[i] )
// or after K-map simplification
// Cout[i] = ( A[i] & B[i] ) | ( B[i] & Cin[i] ) | ( Cin[i] & A[i] )

module fulladder_dataflow( input  logic A_DI;
                           input  logic B_DI;
                           input  logic C_DI;
                           output logic S_DO;
                           output logic C_DO );

  logic temp_D;

  assign temp_D = A_DI ^ B_DI;
  assign S_DO = temp_D ^ C_DI;
  assign C_DO = C_DI & ( temp_D ) | ( A_DI & B_DI );

endmodule