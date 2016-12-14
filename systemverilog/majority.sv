///////////////////////////////////////////////////////////////////////////////
// Module Name  : majority
// File name    : majority.sv
// Description  : Majority Function
//                Inputs: a,b,c (odd number of inputs)
//                Output: Equal to majority input state(0 or 1) = ab+bc+ca = (a+b)c+ca
// Type         : Combinational - Structural
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
///////////////////////////////////////////////////////////////////////////////

// Interface: I/O Ports
module majority(
  input logic a,b,c;
  output logic y
  );

  //-----------------------------Start Architecture--------------------------//

  // Variable declarations
  logic n_ab_and, n_ab_or, n_ab_c;


  // Instantiate existing modules with port maps
  and and_ab(n_ab_and, a, b);
  or or_ab(n_ab_or, a, b);
  and and_ab_c(n_ab_c, n_ab_or, c);
  or or_abc(y, n_ab_and, n_ab_c);

  //----------------------------------Start Body-----------------------------//
  //---------------------------------- End Body -----------------------------//

  //------------------------------ End Architecture--------------------------//
endmodule
