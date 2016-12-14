///////////////////////////////////////////////////////////////////////////////
// Module Name  : template
// File name    : template.sv
// Description  : Template for SystemVerilog Models
// Type         : Combinational(structural, dataflow, behavioral), sequential
// Limitations  : None
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25//11/2016
///////////////////////////////////////////////////////////////////////////////


// SystemVerilog is case-sensitive
// keywords are always lowercase


// Interface: I/O Ports
// ~ VHDL Entity
module template(
  // -----------------------------Start Header-------------------------------//
  // EXTERNAL INTERFACE (WHAT IT DOES - BEHAVIOR)
  // [mode] [data-type] (array) [port-name]
  // [mode]: input, output, inout
  // [data-type]: wire(default can be ommited)
  //              integer, real, time, realtime (only simulation)
  //              byte(1-byte int or ASCII character, 2-state)
  //              shortint(2-bytes, signed, 2-state)
  //              int(4-bytes, signed, 2-states)
  //              longint(8 bytes, signed, 2-states)
  //              bit(2-state, unsigned, user defined vector size)
  //              reg (synthesizable, unsigned)
  //              logic(4-state, unsigned, user defined vector size)
  //              2-states : 0,1
  //              4-states : 0, 1, Z, X
  // (array)    : [range]
  //              range: n1:n2  (array size = (|n1-n2| + 1)), n>=0
  // ----------------------------------End Header----------------------------//
  );

  //-----------------------------Start Architecture--------------------------//
  // ~VHDL Architecture

  // Variable declarations
  // ~VHDL signal declarations for internal nodes
  // [data-type] [variable-name];


  // Instantiate existing modules with port maps
  // ~VHDL Component Declaration+Instantiation with port maps
  // [component_name] [component_identifier](port-map: .instance_portname1(net_name),...);
  // Built in gates primitives
  // gateTypeKeyword [instanceName] ( portList )  ;

  //----------------------------------Start Body-----------------------------//
  // HOW IT DOES WHAT IT DOES (HOW IT CREATES THE BEHAVIOR)

  // Continuous Assignment: concurrent process expressed as a single statement
  // assign [variable_1] = [a&l expression with one or more variables];
  // assign [variable_2] = [function calls(but no tasks)];

  // Continuous assignment to express conditional execution
  // assign [variable_2] = [ (boolean_expr)? expr_true : expr_false];

  // Procedural Blocks: process which is concurrent outside and sequential inside
  // - Can update more than 1 variables
  // - Expressed as set of statements that get executed in sequence
  // - Can use local variables for temporary purpose
  // - Control conditions for activation of process
  // - block as a whole executes as a concurrent process
    /* Combinational logic
        always_comb
        begin
            // Procedural assignment statements only
            // Procedural assignement is also called blocking assignment
            a = b|c;
            d = a-c;

            // Conditional Execution
            if( exp )
                //
            else if
                //
            else
                //
        end
    */

  //---------------------------------- End Body -----------------------------//

  //------------------------------ End Architecture--------------------------//
endmodule
