///////////////////////////////////////////////////////////////////////////////
// Module Name	: binary2gray	
// File name	: binary2gray.sv
// Description	: 4-bit Binary to Gray Converter
// Limitations	: None
// Author		: Varun Nagpal
// Revision|Date: 0.1 | 25//11/2016
///////////////////////////////////////////////////////////////////////////////




// SystemVerilog is case-sensitive
// keywords are always lowercase
// Interface: I/O Ports
// ~ VHDL Entity
module binary2gray(
  // -----------------------------------Header---------------------------------
  // EXTERNAL INTERFACE (WHAT IT DOES - BEHAVIOR)
  // [mode] [data-type] [port-name]
  // [mode]: input, output, inout
  // [data-type]: wire(default can be ommited)
  //              integer, real, time, realtime (only simulation)
  //			  byte(1-byte int or ASCII character, 2-state)  
  //			  shortint(2-bytes, signed, 2-state)
  //			  int(4-bytes, signed, 2-states)
  //			  longint(8 bytes, signed, 2-states)
  //			  bit(2-state, unsigned, user defined vector size)  
  // 			  reg (synthesizable, unsigned)  
  //			  logic(4-state, unsigned, user defined vector size)
  //			  2-states : 0,1
  //			  4-states : 0, 1, Z, X
  // ----------------------------------End Header------------------------------
  input logic [3:0] binary_code,
  input logic enable,
  output logic [3:0] gray_code, tristate
  );
  
  // ----------------------------------Architecture----------------------------
  // ~VHDL Architecture

  // Variable declarations
  // ~VHDL signal declarations for internal nodes
  // [data-type] [port-names];

  // Packed Array:  dimensions declared before the object name (same as Verilog vector width)
  // A packed array is guaranteed to be represented as a contiguous set of bits
  logic [3:0] i1, i2, i3, i4, o1, o2,o3;

  // Unpacked Array:  dimensions declared after the object name (same as Verilog array dimensions)
  // An unpacked array is not guaranteed to be represented as a contiguous set of bits
  // However,  in terms of hardware, both packed and unpacked array are treated or bit-blasted 
  // into a single dimension.
//  logic i5, i6, o4 [3:0];
  
  // Instantiate existing modules with port maps
  // ~VHDL Component Declaration+Instantiation with port maps
  // [component_name] [component_identifier](port-map: .instance_portname1(net_name),...);
  // Built in gates primitives
  // gateTypeKeyword [instanceName] ( portList )  ;
  nand n0(o1[0], i1[0], i2[0]);
  nand n1(o1[1], i1[1], i2[1]);
  nand n2(o1[2], i1[2], i2[2]);
  nand n3(o1[3], i1[3], i2[3]);      
  xor x0(o2[0], i3[0], i4[0]);
  xor x1(o2[1], i3[1], i4[1]);
  xor x2(o2[2], i3[2], i4[2]);
  xor x3(o2[3], i3[3], i4[3]);      
  
  //--------------------------------------Body---------------------------------
  // HOW IT DOES (HOW IT CREATES THE BEHAVIOR)
  assign gray_code[3] = binary_code[3];
  assign gray_code[2] = binary_code[3] ^ binary_code[2];
  assign gray_code[1] = binary_code[2] ^ binary_code[1];
  assign gray_code[0] = binary_code[1] ^ binary_code[0];
  
  // Letters d, h, o and b that indicate the base in decimal, hexadecimal, octal and binary numbers
  // the hex digits A through F, and the logic values X and Z are all case-insensitive  
  assign i1 = 4'b1101;
  assign i2 = 1'hE;
  assign i3 = 1'o7;
  assign i4 = 1'd13;
  assign o3 = '1; // Unsized literal notation: '1 is same as 4'b1111
  assign tristate = enable ? '1 : 'z; // conditional operator is useful for three state buffers
  //-----------------------------------End Body -------------------------------
  
  //------------------------------ End Architecture----------------------------
endmodule