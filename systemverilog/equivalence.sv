///////////////////////////////////////////////////////////////////////////////
// Module Name  : equivalence
// File name    : equvalence.sv
// Description  : Outputs high if both inputs are equal
// Type         : Behavioral
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
///////////////////////////////////////////////////////////////////////////////


// Interface: I/O Ports
module equivalence(
  input logic a,b;
  output logic y
  );

  //-----------------------------Start Architecture--------------------------//

  //----------------------------------Start Body-----------------------------//
  // Structurally, this is equivalent to
  // Y = a xnor b
  always_comb
  begin
    if( a == b)
        y = 1'b1;
    else
        y = 1'b0;
  end
  //---------------------------------- End Body -----------------------------//

  //------------------------------ End Architecture--------------------------//
endmodule
