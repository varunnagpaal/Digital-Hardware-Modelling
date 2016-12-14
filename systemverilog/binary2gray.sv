///////////////////////////////////////////////////////////////////////////////
// Module Name  : binary2gray
// File name    : binary2gray.sv
// Description  : 4-bit Binary to Gray Converter
// Type         : Pure Combinational - dataflow
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
///////////////////////////////////////////////////////////////////////////////


// Interface: I/O Ports
module binary2gray(
  input logic [3:0] binary_code,
  output logic [3:0] gray_code
  );
  
  //-----------------------------Start Architecture---------------------------//
  
  //--------------------------------Start Body--------------------------------//
  assign gray_code[3] = binary_code[3];
  assign gray_code[2] = binary_code[3] ^ binary_code[2];
  assign gray_code[1] = binary_code[2] ^ binary_code[1];
  assign gray_code[0] = binary_code[1] ^ binary_code[0];
  //-----------------------------------End Body -----------------------------//
  
  //------------------------------ End Architecture--------------------------//
endmodule
