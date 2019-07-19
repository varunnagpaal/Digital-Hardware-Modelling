////////////////////////////////////////////////////////////////////////////////
// Module Name  : template
// File name    : template.sv
// Description  : Template for SystemVerilog Models
// Type         : Combinational, Sequential
// Limitations  : None
// Model Styles : structural, dataflow, behavioral
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 19/07/2019
////////////////////////////////////////////////////////////////////////////////


/*
  1.SystemVerilog is mostly(not all) case-sensitive unlike VHDL which is case
    (probably mostly) insensitive.
  2.SystemVerilog keywords, built-in system tasks & system functions are always lowercase
  3.Exceptions to case-sensitive SystemVerilog:
    - The letters d, h, o and b that indicate the base in decimal, hexadecimal,
      octal and binary.
    - the hex digits A through F
    - the logic values X and Z
*/

// Interface: I/O Ports
// ~ VHDL Entity
module template
  // ------------------------Start Optional Parameters-----------------------//
  #( parameter <param_1_identifier>, // default value is optional

     // The default value when specified is applied whenever this module is
     // instantiated this default value can be overriden at point when the
     // module is instantiated
     parameter <param_2_identifier> = <param_user_defined_default_value>
  )
  // --------------------------End Optional Parameters-----------------------//

  // -----------------------------Start Header-------------------------------//
  (
   /*
    EXTERNAL INTERFACE (nodes) (WHAT IT DOES - BEHAVIOR)
    [mode] [data-type] (array_dim_1) [port-name] (array_dim_2)

    mode: input, output, inout
    data-type: logical-type|num_type|other_type
    port-name: Identifier
    Identifier: (Alpha|_)Alpha|Num|_|$ (built-in & user defined system tasks and functions start with $)
    Alpha: A-Za-z
    Num: 0-9
    array_dim_1: b:a, b>a
    array_dim_2: c:d, c<d

    [logical-type]: wire( unsigned,
                          4-states,
                          electrical modeling,
                          user defined vector size,
                          compulsory for multi-driver nodes and bidirectional
                          io ports,
                          multi-driver,
                          multi-driver conflicts during simulation resolved
                          using resolution function,
                          is default data type,
                          can be ommited for example in ports,
                          can only be connected and cannot be assigned
                          procedurally,
                          globally visible )

                    logic [num_type_prefix] ( unsigned,
                                              4-states,
                                              electrical modeling,
                                              user defined vector size,
                                              single driver,
                                              multi-driver conflicts unresolved
                                              and issues error )

                    bit( unsigned,
                         2-states,
                         non-electrical modeling,
                         user defined vector size )

                    reg(unsigned,
                        synthesizable,
                        can be assigned only inside a procedural block such as
                        initial, always,
                        represents piece of storage which retains value until
                        next invocation of always block )

     [num_type] : byte      [num_type_prefix] (1-byte , signed, 2-states, single driver)
                  shortint  [num_type_prefix] (2-bytes, signed, 2-states, single driver)
                  int       [num_type_prefix] (4-bytes, signed, 2-states, single driver)
                  longint   [num_type_prefix] (8 bytes, signed, 2-states, single driver)
                  integer   [num_type_prefix] (4 bytes, signed, 4-states, single driver)

     [num_type_prefix] : signed(default)|unsigned

     [other_type]:  real      (only for simulation, not synthesizable)
                    time      (only for simulation, not synthesizable)
                    realtime  (only for simulation, not synthesizable)

     2-states : 0, 1
     4-states : 0, 1, Z, X

     Z - High Impedance, Turned off, Not connected or open circuited
     X - Unknown state - 0 or 1

     (array)    : [range]
     range      : n1:n2  (array size = (|n1-n2| + 1)), n1>=0, n2>=0
     The MSB always is on the left and LSB is always on right of a verilog vector.
    */
);
  // ----------------------------------End Header----------------------------//

  //-----------------------------Start Architecture--------------------------//
  // ~VHDL Architecture

    /*
        If parameters are not specified in the module header, they maybe
        specified here.

        parameter <parameter_name_1> = <paramaeter_name_1_default_value>;
        parameter <parameter_name_2> = <paramaeter_name_2_default_value>;
    */

    /*
        Variable declarations (inter-process communication)
        ~VHDL signal declarations for internal nodes of circuit
        Used for exchange of dynamic(time varying) information between
        concurrent processes.
    */
    // (var) [data-type] [variable-name] = (initial_value);
    // var:  an optional keyword to indicate that we are declaring a variable
    // initial_value: an optional value provided to a variable during
    // declaration.
    // Note: This inital_value is not adequate for modeling hardware reset and
    // is generally used for simulation purpose.

    /*
        Instantiate existing modules with port maps
        ~VHDL Component Declaration+Instantiation with generic values+port maps
    */
    // [component_module_name] [component_identifier] #(optional-generic-map)[(port-map)];
    // port-map: .component_portname1(net_name),...
    // optional-generic-map: .parameter_name(parameter_value), ...

    // Instantiate built in gates primitives
    // gateTypeKeyword [instanceName] ( portList )  ;

  //----------------------------------Start Body-----------------------------//
  // HOW IT DOES WHAT IT DOES (HOW IT CREATES THE BEHAVIOR)
    /*
    Summary for SystemVerilog based RTL design:
      1. Prefer continuous assignments for uncomplicated combinational
         functions(MISO logic functions, multiplexer).
      2. Do not use procedural blocks other than always_comb, always_ff and
         always_latch.
      3. In an always_comb block, always use blocking assignments (=).
      4. In always_ff and always_latch blocks, use nonblocking assignments
         (<=) only.
      5. Do not make #0 (zero delay expression) procedural assignments.
      6. If writing Verilog exclusively,

      ------------------------------  ------------------------------------------
      Data Object or type             Write method
      ------------------------------  ------------------------------------------
      wire(net data types)            continuous assignment(assign wire = ...;)
      reg                             non-blocking assignment(<=) inside always
                                      block (sequential logic), initial
      wire + reg                      blocking assignment(=) inside always
                                      block(combinational logic)
      output port(default type wire)  continuous assignment
      input port(default type wire)   N.A
      ------------------------------  ------------------------------------------

      6. If writing SystemVerilog exclusively, use logic type for input/output
         ports, all variables in always blocks, all nets inside the circuit
    */

    /* Continuous assignment with optional delay Tpd>=0

        assign [#Tpd] [variable_1 or wire_1] = [a&l expression with one or more variables];
        assign [#Tpd] [variable_2 or wire_2] = [function calls(but no tasks)];

      - LHS can be wire or logic but not reg.
      - RHS can be input port, literal, wire, logic, bit or reg
      - Timing expressions such as #0.05 or #10 are ignored by the logic
        synthesizer and are useful only in simulation
      - Concurrent process expressed as a single statement
      - Represents single, permanent connections of something to a net(wire)
      - The RHS expression is evaluated and assigned to LHS after the optionally
        specified delay has elapsed i.e. if one or more variables in rhs
        expression has just been updated, the rhs expression is evaluated,
        and this resulting value is scheduled for assignment to lhs at Tpd time
        ahead of current simulation time
    */

    /* Continuous assignment used for expressing conditional execution
       (synthesis to combinational logic)
      - Usually used for writing Mux
      - assign [variable_3 or wire_3] = [ (boolean_expr)? expr_true : expr_false];
    */

    /* Procedural Blocks
      -  process which executes concurrent outside w.r.t to other processes but
         which executes within itself sequentially.
         i.e. concurrent outside and sequential inside
        - Can update more than 1 variable
        - Expressed as set of statements that get executed in sequence
        - Can use local variables for temporary purpose
        - Control conditions for activation of process
        - Procedural block as a whole executes as a concurrent process
    */

    /*  Combinational logic
        - A procedural block that implements a MIMO truth table or a digital
          logic function(equation)

        always_comb
        begin
          // Variable declaration statements for temporary storage
          // (intra-process)(scope: local to process)
          // (var) [data-type] [variable-name] = (initial_value);
          // lhs must be reg or tbu. rhs can be input port, literal, logic, reg,
          // wire or bit.
          //
          // Procedural assignment statements
          // - blocking (=) or non-blocking assignment (<=).
          //
          // Use blocking assignments to describe combinational logic
          // behaviorally in always_comb block
          //
          // Blocking assignment statements: blocks the execution of process
          // until the statement is executed. Process execution proceeds from
          // one statement to next sequentially blocking each time a statement
          // is encountered. Each statement execution involves evaluation of
          // RHS expression and assignment of this result to LHS expression
          // after 0 delay (unspecified delay) or in specified delay
          // (#[time][timeunit])
          // ~VHDL variable assignment ":=""
          // i.e Effect of Verilog blocking assignment to a variable is
          // same as effect of VHDL variable update within a process.

          // 1. Blocking assignment with no delay: evalue rhs and assign this
          //    result to LHS immediately.
          a = b|c;          // Assign at 0ns

          // 2. Blocking assignment with delay: process execution suspended
          //    until simulation time advances by specified delay (20ns)
          //    Evaluate rhs but assign this result to LHS after specified
          //    time(20ns) has elapsed
          d = #20ns a-c;    // Assign at 20 ns
          k = #30ns a*c;    // Assign at 50 ns

          // Use if-else control block for indicating explicit priority among
          // mutually exclusive events. For example expr1 has hgher priority
          // over expr2.
          If ( expr1 )    blocking assignment statement1;
          else if(expr2)  blocking assignment statement2;
          else            blocking assignment statement3;

          // Use case-endcase control construct when there is no priority
          // among mutually exclusive events. Case alternatives are usually
          // constant but maybe variables. Case expression itself is a
          // variable. For example alt1, alt2 and default have same priority.
          // It is usually used for implementing a lookup table or small
          // memory adressing scheme.
          //
          // NOTE: There is no need to add break statement at the end of a
          //       case statement
          case (expr)
                  alt1:       blocking assignment statement1;
                  alt2:       blocking assignment statement2;
                  default:    blocking assignment default_statement;
          endcase

          // Verilog supports Looping construct in form of a for statement.
          // This mainly helps to generate repetitive sub-structures of a
          // combinational logic block.
          // Note: In SystemVerilog one may use i++ or i=i+1 as loop variable
          //       update statement. However Verilog only supports later i.e
          //       i=i+1 loop variable update statement
          for( loop var init; loop reentry expression; loop var update)
              blocking assignment statement1;
              blocking assignment statement2;
        end

        // Combinational logic can also be expressed using traditional
        // procedural block "always" with the sensitivity list containing all
        // inputs of the combinational logic being modeled

        always@(<list of combinational inputs>)
        begin
            // blocking assignment statement1;
            // blocking assignment statement2;
        end
    */

    /* Sequential Logic

    always_ff @( [posedge/negedge] Clk_CI, optional [posedge/negedge] Rst_RBI )
    begin
        if( ~RST_RBI )
            // Procedural assignment statement: prefer non-blocking for
            // describing sequential logic.
            // Non-blocking assignment with no delay specified: Evaluate RHS but
            // defer(schedule) its assignment to LHS until end of current
            // simulation time step.
            // In terms of hardware semantics, this means that all non-blocking
            // assignments happpen in parallel
            // ~VHDL continuous assignment '<='
            x <= '0;
            y <= '1;
            z < = '0;

            // Non-blocking assignment with a specified delay: evaluate rhs but
            // defer(schedule) its assignment to LHS until current simulation
            // time advances by specified delay
            // TBU
            #5 p <= 'b1;

        else
            // Procedural assignment statement: prefer non-blocking assignment
            // or describing sequential logic.
            // Non-blocking assignment with no delay specified: Evaluate RHS but
            // defer(schedule) its assignment to LHS until end of current
            // simulation time step.
            // In terms of hardware semantics, this means that all non-blocking
            // assignments happpen in parallel
            // ~VHDL continuous assignment '<='
            x <= a & b;
            y <= a|c;
            z < = a & b | c;

            // Non-blocking assignment with a specified delay: evaluate rhs but
            // defer(schedule) its assignment to LHS until current simulation
            // time advances by specified delay
            // TBU
            l <= #20ns a;     // assign at time 20ns ahead of current simulation timepoint
            m <= #30ns a+b-c; // assign at time 30ns ahead of current simulation timepoint
            n <= #5ns b*c;    // assign at time 5ns ahead of current simulation timepoint

            // As assignments made to x,y,z are done using non-blocking
            // assignment, so assign x,y,z with their new values at the end of
            // the process

        // Its is possible to embed procedural blocks inside an always block
        // without using always
        @(posedge Enable)
        begin
                xbus <= 8'b0;
                dbus <= 16'haaff;
        end
    end
    */

    /*  Macros for Compile time Conditional inclusion or exclusion of Verilog

        One can define macros using 'define macro just like in C/C++. Macro
        should be undefined using 'undef as soon as the macro has served its
        purpose possibly in same verilog file where it was defined in first
        place. Example:
            `define IN
            `define OUT
            `define BUS_WIDTH 64

        Also, in Verilog code, the above defined macros are referenced as 'IN,
        'OUT, 'BUS_WIDTH

        One may use `ifdef-`else-`endif or `ifndef-`else-`endif macros just
        like in C, C++ to conditionallyexecute part of Verilog code
        Examples:

        `ifndef DC // If synopsys DC not defined
            // some simulation specific verilog
            // note: $display is a Verilog system task
            $dispay("Running simulator and not synthesis");
        `endif

        `ifdef DC // if synsopsy DC is defined, do something else
            // some synthesizable specific verilog
            // ..
        `else
            // Some simulation specific Verilog
            $display("Running simulation at time %05d\n", $time );
        `endif
    */

  //---------------------------------- End Body -----------------------------//

  //------------------------------ End Architecture--------------------------//
endmodule
