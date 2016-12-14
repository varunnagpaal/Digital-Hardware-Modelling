///////////////////////////////////////////////////////////////////////////////
// Module Name  : odd_even
// File name    : odd_even.sv
// Description  : Three or more inputs
//                Two Outputs:
//                - first output is high if number of high inputs are odd (2n-1),n>0
//                - second output is high if number of high inputs are even (2n),n>0
//                  (0 is neither even nor odd)
// Type         : Dataflow
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
///////////////////////////////////////////////////////////////////////////////


// Interface: I/O Ports
module odd_even(
  input logic a,b,c;
  output logic yodd, yeven
  );

  //-----------------------------Start Architecture--------------------------//
  logic temp;

  //----------------------------------Start Body-----------------------------//
  always_comb
  begin
    temp = a ^ b;
    yodd = temp ^ c;
    yeven = ( temp & c ) | ( a & b & (~c) );
  end
  //---------------------------------- End Body -----------------------------//

  //------------------------------ End Architecture--------------------------//
endmodule
