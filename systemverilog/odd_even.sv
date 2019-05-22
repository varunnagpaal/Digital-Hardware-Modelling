///////////////////////////////////////////////////////////////////////////////
// Module Name  : odd_even
// File name    : odd_even.sv
// Description  : Odd even parity generator
// Inputs       : Three or more inputs
// Outputs      : Two Outputs:
//                - first output is high if number of high inputs are odd (2n-1)
//                - second output is high if number of high inputs are even (2n)
//                  (0 is neither even nor odd and n > 0)
// Type         : Combinational
// Model Style  : Dataflow
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
///////////////////////////////////////////////////////////////////////////////


// Interface: I/O Ports
module odd_even( input logic a,b,c;
                output logic yodd, yeven );

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