///////////////////////////////////////////////////////////////////////////////
// Module Name  : template
// File name    : template.sv
// Description  : Template for SystemVerilog Models
// Type         : Combinational(structural, dataflow, behavioral), sequential
// Limitations  : None
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25//11/2016
///////////////////////////////////////////////////////////////////////////////


/*
  SystemVerilog is mostly(not all) case-sensitive
  SystemVerilog keywords are always lowercase
  Exceptions to case-sensitive SystemVerilog:
  - The letters d, h, o and b that indicate the base in decimal, hexadecimal, octal and binary numbers,
  - the hex digits A through F
  - the logic values X and Z
*/



// Interface: I/O Ports
// ~ VHDL Entity
module template
  // -----------------------------Start Optional Parameters------------------------//
  #( parameter <param_1_identifier>, // default value is optional
     parameter <param_2_identifier> = <param_user_defined_default_value>
  )
  // -----------------------------End Optional Parameters------------------------//

  // -----------------------------Start Header-------------------------------//
  (
    // EXTERNAL INTERFACE (nodes) (WHAT IT DOES - BEHAVIOR)
    // [mode] [data-type] (array) [port-name]
    // [mode]: input, output, inout
    // [data-type]: [logical-type]|[num_type]|[other_type]

    // [logical-type] :wire(unsigned, 4-states, electrical modeling, user defined vector size,
    //                      compulsory for multi-driver nodes and bidirectional io ports,
    //                      multi-driver, multi-driver conflicts resolved using resolution function during simulation,
    //                      is default data type and can be ommited )
    //                logic [num_type_prefix] (unsigned, 4-states, electrical modeling, user defined vector size,
    //                                        single driver, multi-driver conflicts unresolved and issues error )
    //                bit(unsigned, 2-states, non-electrical modeling, user defined vector size)
    //                reg(unsigned, synthesizable)
    //
    // [num_type] : byte      [num_type_prefix] (1-byte , signed, 2-states, single driver)
    //              shortint  [num_type_prefix]  (2-bytes, signed, 2-states, single driver)
    //              int       [num_type_prefix]  (4-bytes, signed, 2-states, single driver)
    //              longint   [num_type_prefix]  (8 bytes, signed, 2-states, single driver)
    //              integer   [num_type_prefix]   (4 bytes, signed, 4-states, single driver)
    //
    // [num_type_prefix] : signed(default)|unsigned
    //
    // [other_type]:  real (only simulation)
    //                time (only simulation)
    //                realtime (only simulation)
    //
    // 2-states : 0, 1
    // 4-states : 0, 1, Z, X
    //
    // (array)    : [range]
    // range      : n1:n2  (array size = (|n1-n2| + 1)), n1>=0, n2>=0
);
  // ----------------------------------End Header----------------------------//

  //-----------------------------Start Architecture--------------------------//
  // ~VHDL Architecture

    // Variable declarations (inter-process)
    // ~VHDL signal declarations for internal nodes of circuit
    // Used for exchange of dynamic(time varying) information between concurrent processes
    // (var) [data-type] [variable-name] = (initial_value);
    // var:  an optional keyword to indicate that we are declaring a variable
    // initial_value: an optional value provided to a variable during declaration
    // Note that this inital_value is not adequate for modeling hardware reset


    // Instantiate existing modules with port maps
    // ~VHDL Component Declaration+Instantiation with generic values+port maps
    // [component_module_name] [component_identifier] #(optional-generic-map)(port-map);
    // port-map: .component_portname1(net_name),...
    // optional-generic-map: .parameter_name(parameter_value), ...

    // Instantiate built in gates primitives
    // gateTypeKeyword [instanceName] ( portList )  ;

  //----------------------------------Start Body-----------------------------//
  // HOW IT DOES WHAT IT DOES (HOW IT CREATES THE BEHAVIOR)
    /*
    Summary for SystemVerilog based RTL design:
      1. Prefer continuous assigns for uncomplicated combinational functions.
      2. Do not use procedural blocks other than always_comb, always_ff and always_latch.64
      3. In an always_comb block, always use blocking assignments (=).
      4. In always_ff and always_latch blocks, use nonblocking assignments (<=) only.
      5. Do not make #0 (zero delay expression) procedural assignments.
    */

    // Continuous assignment with optional delay Tpd>=0: concurrent process expressed as a single statement
    // The rhs expression is evaluated and assigned to LHS after the optionally specified delay has elapsed
    // i.e. if one or more variables in rhs expression has just been updated, the rhs expression is evaluated,
    // and this resulting value is scheduled for assignment to lhs at Tpd time ahead of current simulation time
    // assign  [#Tpd] [variable_1 or wire_1] = [a&l expression with one or more variables];
    // assign [#Tpd] [variable_2 or wire_2] = [function calls(but no tasks)];

    // Continuous assignment used for expressing conditional execution
    // assign [variable_3 or wire_3] = [ (boolean_expr)? expr_true : expr_false];

    // Procedural Blocks: process which executes concurrent outside w.r.t to other module processes
    // but which executes within itself sequentially. i.e. concurrent outside and sequential inside
    // - Can update more than 1 variable
    // - Expressed as set of statements that get executed in sequence
    // - Can use local variables for temporary purpose
    // - Control conditions for activation of process
    // - block as a whole executes as a concurrent process

    /* Combinational logic: implements a MIMO truth table or digital logic function(equation)
        always_comb
        begin
            // Variable declaration statements for temporary storage(intra-process)(scope: local to process)
            // (var) [data-type] [variable-name] = (initial_value);

            // Procedural assignment statements: blocking assignment (=) or non-blocking assignment (<=)
            // Use blocking assignments for describing combinational logic behaviorally in always_comb block

            // Blocking assignment statements: blocks the execution of process until the statement is executed
            // Process execution proceeds from one statement to next sequentially blocking each time a statement is encountered
            // Each statement execution involves evaluation of RHS expression and assignment of this result to LHS expression
            // ~VHDL variable assignment ":=""


            // 1. Blocking assignment with no delay: evalue rhs and assign this result to LHS immediately.
            a = b|c;          // At 0ns

            // 2. Blocking assignment with delay: process execution suspended until simulation time advances by specified delay (20ns)
            // Evaluate rhs but assign this result to LHS after specified time(20ns) has elapsed
            d = #20ns a-c;    // Assign At 20 ns
            k = #30ns a*c;    // Assign At 50 ns

            // Conditional Execution
            if( exp )
                //
            else if
                //
            else
                //
        end
    */

    /* Sequential Logic
    always_ff @( [posedge/negedge] Clk_CI, optional [posedge/negedge] Rst_RBI )
    begin
        if( ~RST_RBI )
            // Procedural assignment statement: prefer non-blocking for describing sequential logic
            // Non-blocking assignment with no delay specified: Evaluate RHS but defer(schedule)
            // its assignment to LHS until end of current simulation time step
            // ~VHDL continuous assignment '<='
            // In terms of hardware semantics, this means that all non-blocking assignments happpen in parallel
            x <= '0;
            y <= '1;
            z < = '0;

            // Non-blocking assignment with a specified delay: evaluate rhs but defer(schedule)
            // its assignment to LHS until current simulation time advances by specified delay
            // TBU

        else
            // Procedural assignment statement: prefer non-blocking  assignment for describing sequential logic
            // Non-blocking assignment with no delay specified: Evaluate RHS but defer(schedule)
            // its assignment to LHS until end of current simulation time step
            // ~VHDL continuous assignment '<='
            // In terms of hardware semantics, this means that all non-blocking assignments happpen in parallel
            x <= a & b;
            y <= a|c;
            z < = a & b | c;

            // Non-blocking assignment with a specified delay: evaluate rhs but defer(schedule)
            // its assignment to LHS until current simulation time advances by specified delay
            // TBU
            l <= #20ns a;     // assign at time 20ns ahead of current simulation timepoint
            m <= #30ns a+b-c; // assign at time 30ns ahead of current simulation timepoint
            n <= #5ns b*c;    // assign at time 5ns ahead of current simulation timepoint

            // As assignments made to x,y,z are done using non-blocking assignment, so assign
            // x,y,z with their new values at the end of the process
    end
    */

  //---------------------------------- End Body -----------------------------//

  //------------------------------ End Architecture--------------------------//
endmodule