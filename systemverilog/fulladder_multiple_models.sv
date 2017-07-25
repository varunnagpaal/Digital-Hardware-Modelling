/////////////////////////////////////////////////////////////////////////////////////
// Module Name  : fulladder_structural
// File name    : fulladder_structural.sv
// Description  : 1-bit full-adder coded in three styles: behavioral, structural and
//				  dataflow
// Type         : Combinational
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
/////////////////////////////////////////////////////////////////////////////////////

// Truth Table of Full-Adder
// i = 1 to n-bits
//
// A[i]		0	0	0	0	1	1	1	1
// B[i] 	0	0	1	1	0	0	1	1
// Cin[i] 	0	1	0	1	0	1	0	1
// S[i]		0	1	1	0	1	0	0	1
// Cout[i]	0	0	0	1	0	1	1	1
//
// S[i] =  A[i] ^  B[i] ^ C[i]
// Cout[i] = (Cin[i] & ( A[i] ^ B[i] )) | ( A[i] & B[i] )
// or after K-map simplification
// Cout[i] = ( A[i] & B[i] ) | ( B[i] & Cin[i] ) | ( Cin[i] & A[i] )

'define MODEL_TYPE DATAFLOW // set default model type

// Model Interface
module fulladder_multiple_models(
	input logic A_DI;
	input logic B_DI;
	input logic C_DI;
	output logic S_DO;
	output logic C_DO
);

	'ifdef DATAFLOW // Model Implementation: Dataflow

		logic temp_D;

		assign temp_D = A_DI ^ B_DI;
		assign S_DO = temp_D ^ C_DI;
		assign C_DO = C_DI & ( temp_D ) | ( A_DI & B_DI );

	'elsif BEHAVIORAL // Model Implementation: Behavioral

		always_comb
		begin
			var logic temp;
			temp = A_DI ^ B_DI;
			S_DO = temp ^ C_DI;
			C_DO = C_DI & ( temp ) | ( A_DI & B_DI );
		end

	'else // Model Implementation: Structural

		logic temp1_D, temp2_D, temp3_D;

		xor x0( temp1_D, A_DI, B_DI );
		xor x1( S_DO, temp1_D, C_DI );
		and a0( temp2_D, C_DI, temp1_D );
		and a1( temp3_D, A_DI, B_DI );
		or or0( C_DO, temp2_D, temp3_D );

	'endif