///////////////////////////////////////////////////////////////////////////////
// Module Name  : mux8to1
// File name    : mux8to1.sv
// Description  : 8:1 Multiplexer
// Type         : Combinational - structural, dataflow
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
///////////////////////////////////////////////////////////////////////////////

// Interface: I/O Ports
module mux8to1(
  input logic a,b,c,d,e,f,g,h;
  input logic [2:0] sel;
  output logic y
  );

  //-----------------------------Start Architecture--------------------------//

  //----------------------------------Start Body-----------------------------//
  always_comb
  begin
    case (sel)
        3'b000 : y = a;
        3'b001 : y = b;
        3'b010 : y = c;
        3'b011 : y = d;
        3'b100 : y = e;
        3'b101 : y = f;
        3'b110 : y = g;
        3'b111 : y = h;
    endcase
  end
  //---------------------------------- End Body -----------------------------//

  //------------------------------ End Architecture--------------------------//
endmodule