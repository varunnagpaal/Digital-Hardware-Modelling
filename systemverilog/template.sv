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
    [mode] [object-type] [port-name] {array_range_of_objects}

    [mode]: input(net-type)|output(net-type|variable-type)|inout(net-type)
            input and inout port is always of net type (note: sv allows them to be also variable type. but this is seldom useful)
            output port should be a variable type (example reg) if assigned by a procedural block
                               or a net type (example wire) if driven outside procedural block
    [object-type]: data-type {signed} {array_range_of_data_type}
    [data-type]: net-type|variable-type|logical-type|num_type|other_type
    [array_range_of_data_type]: array_range(msb,lsb)|array_range(lsb,msb), msb>lsb
                                The MSB always is on the left and LSB is always on right of a
                                verilog vector.
    [port-name]: Identifier
    [array_range_of_objects]: array_range(a,b), a<b
  */
);
  // ----------------------------------End Header----------------------------//

  /*
    [array_range(n1,n2)]    : n1:n2  (array size = (|n1-n2| + 1)), n1>=0, n2>=0
                              | base_index -: offset => base_index:base_index-offset+1  // little endian
                              | base_index +: offset => base_index:base_index+offset-1  // little endian

                              logic [31: 0] a_vect; // little endian
                              logic [0 :31] b_vect; // big endian
                              logic [63: 0] dword;
                              integer sel;
                              a_vect[ 0 +: 8] // == a_vect[ 7 : 0]
                              a_vect[15 -: 6] // == a_vect[15 : 10]
                              b_vect[ 0 +: 8] // == b_vect[0 : 7]
                              b_vect[15 -: 6] // == b_vect[10 :15]
                              dword[8*sel +: 8] // variable part-select with fixed width

    [Identifier]: (Alpha|_)Alpha|Num|_|$ (built-in & user defined system tasks and functions
                   start with a $)
    [Alpha]: A-Za-z
    [Num]: 0-9

    [net-type]: wire or tri|uwire|supply0|supply1|tri1|tri0|trireg|triand or wand|trior or wor|
                instance of a net represents physical connection between two entities
                initialized to high impedance state(Z) by simulator (except trireg initialized to X)
                can be "driven" only outside procedural blocks
                receives value driven onto it by its driver(s)
                during simulation, if a net has
                  Z value => driver of net is disabled (in real hardware the situation
                             will either occur for short duration or would not occur because the
                             bus keepers pull the net to a high or low logic state)
                  X value => net is being driven by multiple drivers (in real hardware the situation
                             will either occur for short duration or would not occur)
    [wire or tri]: an interconnection wire.
                   can have multiple drivers
                   only difference between wire and tri is syntax
                   tri and wire completely identical in functionality
                   wire is just a convenient name when one knows the interconnection wire is a
                   single-driver net
                   tri is just a convenient name when one knows the interconnection wire is a
                   multi-driver net
    [uwire]: this net-type is an interconnection wire which only accepts only one driver (verilog 2005)
    [supply0]: VSS or GND
    [supply1]: VDD
    [tri1|tri0]: this net-type is for nets that has pull-up or pull-down resistors
                 When not driven by a driver, the pull-up and pull-down resistors drive it to
                 weak 1/vdd and weak 0/vss
                 When driven by a driver, the net will show the value drive onto it
                 can never be driven to Z
    [trireg]: this net-type is for nets with capacitance on them. has two states: driven and capacitance
              driven state: when net is driven with value 0, 1 or X by a driver,
                            the net will follow the value driven onto it
              capacitance state: when net is not driven by a driver or has Z driven onto it ,
                                then the net will hold the last value
              can never be driven to Z
    [triwand or wand]: when a net is driven by two drivers with same signal strength, then the final
                      value on the net is resolved as the output of an AND gate whose inputs are
                      the output of the two drivers with possibly conflicting output values.
                      models emitter-coupled logic
    [triwor or wor]: when a net is driven by two drivers with same signal strength, then the final
                     value on the net is resolved as the output of an OR gate whose inputs are
                     the output of the two drivers with possibly conflicting output values.
                     models open-collector logic
    [variable-type]: reg|integer|real|time|realtime
                     instance of a variable represents an abstract storage element
                     stores a value until a new value is assigned and holds value even when new value is not assigned
                     initialized to unknown state(X) by simulator i.e. any voltage level b/w VDD/VSS
                     can be "assigned" only inside a procedural block(except real type which is
                     intialized to 0 as it it is only variable type that can hold a Z or X value)
                     can be "read" from inside or outside a procedure
                     during simulation, if a variable has
                       Z value => the value Z was either assigned explicitly (say variable is
                                  one of the drivers of a bus net) or assigned implicitly
                                  the value Z of a net
                       X value => the value X was either assigned explicitly as simulator cannot
                                  resolve value of assigned expression or assigned implicitly
                                  the value X of a net
                     In real hardware, variable has value with either 0 or 1 not Z or X
                     verilog 2001 adds "reg signed"

    [logical-type]: wire( unsigned,
                        4-states,
                        electrical modeling,
                        user defined vector size,
                        compulsory for multi-driver nodes and bidirectional io ports,
                        multi-driver,
                        multi-driver conflicts during simulation resolved using resolution function,
                        a net type,
                        is default or implicit data type,
                        can be ommited for example in ports,
                        can only be connected (continuous assignment = i.e blocking) ,
                        cannot be assigned procedurally,
                        used for combinational logic,
                        globally visible )

                        Note: One can disable implicit data types by using compiler directive
                              such as "'default_nettype none" at end of each verilog file where
                              it needs to be disabled. One can also set an implicit data type
                              by usign adequate type with aforementioned compiler directive
                              compiler would then produce error/warning whenever user doesn't
                              explicitly mentions the data type.

                  logic [num_type_prefix] ( unsigned,
                                            4-states,
                                            electrical modeling,
                                            user defined vector size,
                                            single driver,
                                            multi-driver conflicts unresolved and error messages
                                            generated during compilation or simulation,
                                            sv only)

                                            Verilog   Full SV         Default SV
                                            -------   -------------   ----------
                                            reg sig   var logic sig   logic sig
                                            wire sig  wire logic sig  wire sig

                  bit( unsigned,
                       2-states,
                       non-electrical modeling,
                       user defined vector size.
                       replacement for reg, logic or integer to increase simulation performance
                       as unlike reg, logic or integer which can have 4-states, bit has only 2 states,
                       sv only)

                  reg(unsigned,
                      synthesizable,
                      a variable type,
                      can be assigned only inside a procedural block such as initial/always,
                      represents piece of storage which retains value until next invocation,
                      use blocking assignment(=) for combinational logic,
                      use non-blocking assignment(<=) for sequential logic(ff, latch)

    [num_type] : byte     [num_type_prefix] (1-byte, signed, 2-states, single driver, sv only)
                 shortint [num_type_prefix] (2-bytes, signed, 2-states, single driver, sv only)
                 int      [num_type_prefix] (4-bytes, signed, 2-states, single driver, sv only)
                 longint  [num_type_prefix] (8 bytes, signed, 2-states, single driver, sv only)
                 integer  [num_type_prefix] (4 bytes, signed, 4-states, single driver)
    [num_type_prefix] : signed(default)|unsigned

    [other_type]: real      (double precision float, not 4 -states, only for simulation, not synthesizable)
                  time      (8 bytes, 4-state, only for simulation, not synthesizable)
                  realtime  (same as real, not 4 -states, only for simulation, not synthesizable)
                  short_real (4-byte, sv only)

    [2-states] : 0, 1 (initialized to 0 which hides failure to initialize the design,
                      not recommended to use in rtl code but useful for testbench code
                      as well as clk, rst which are always 0 or 1)
    [4-states] : 0, 1, Z, X (performance overhead during simulation compared to 2-states,
                             exposes failure to initialize the design by showing value x,
                             4-state type when assigned to a 2-state type results in Z/X mapping to 0
                             which hides uninitialized or undriven values,
                             conversion between 4-state and 2-state is bad idea)


    [0] : false, low, logic low, ground, vss
    [1]:  true, high, logic high, power, vdd, vcc
    [Z] : High Impedance, tri-state, Turned off, Not connected, Not driven, open circuited
    [X] : Unknown state - 0 or 1 i.e. any voltage level b/w VDD and VSS. Note SV makes
         no distinction between unknown (state) vs uninitialized/dont care (logic values)
         unlike VHDL where uninitialized(U, never assigned any value) and dont care (-,
         like in K-map) have their own logic values compared to unknown state(logic value X
         when drive strength is strong)

  */

  //-----------------------------Start Architecture--------------------------//
  // ~VHDL Architecture

    /*  Parameters: If parameters are not specified in the module header,
                    they maybe specified here. They are instant specific
                    constants and can be ovverridden while instantiating a
                    module

        parameter_type parameter_name = parameter_value;

        To modify module parameters while instantiating the module, one can
        use following approaches:

        1. use defparam

          my_module inst1(.in1(in11_net), .in2(in12_net), .out(out1_net));
          defparam inst1.param_width = 5;

          my_module inst2(.in1(in21_net), .in2(in22_net), .out(out2_net));
          defparam inst2.param_width = 6;

        2. use parameter value assignment

          // positional parameter override
          my_module #(5) inst1(.in1(in11_net), .in2(in12_net), .out(out1_net) );

          // named parameter override
          my_module #(.width(6)) inst2(.in1(in21_net), .in2(in22_net), .out(out2_net) );


        Local params: These are similar to parameters but are true constants which cannot
                      unlike parameters cannot be ovverridden while instantiating a module.
                      They are used for example for definining enumeration of states of
                      an FSM or within modules that are not instantiated(testbench).
                      Note: localparam cannot be modified by defparam statement

        localparam  param_name = param_value;
    */

    /*
        Internal nets and variable declarations (inter-process communication)
        ~VHDL signal declarations for internal nodes of circuit
        Used for exchange of dynamic(time varying) information between concurrent processes.

        (var) [object-type] [variable-name] {array_range_of_objects} = (initial_value);
        [var]:  an optional keyword to indicate that we are declaring a variable
        [variable-name]: identifier
                         Note: Undeclared identifiers are inferred as net type in Verilog 2001
                               Identifiers with lower/uppercase letters are perceived as distinct
                               No error/warning is reported identifier is used without declaring it
                               To generate error/warnings for undeclared identifiers, it is
                               recommended to use compiler directive " 'default_nettype none"
                               at end of each verilog file where one expects user to explicitly
                               provide the declaration for the identifiers.
        [initial_value]: literal
                         Note: inital_value is not adequate for modeling hardware reset and
                               is generally used for simulation purpose.

        [literal]: [size]'[base][value]
        [size]: positive decimal number of bits(optional).if unsized, then >= 32 bits default size
        [base]: binary(B/b), Octal(O/o), Decimal(D/d), Hexadecimal(H/h).
                optionally has prefix "s" to indicate signed value
        [value]: value that confirms to digits used in base
                use _ as a separator except 1st character
                Z/z or X/x allowed for all bases except Decimal
                can be single Z/z or X/x if basis decimal
                unsigned number
            Some examples of literals
                'h54 : 32-bit hexadecimal
                8'b1101_1100 : 8-bit binary
                10'd999: 10-bit unsigned decimal
                10'ds499: 10-bit signed decimal
                15: 32-bit signed decimal
                12'hxfe: 12 bit hexadecimal
                9'h1_xx01_xxx0: 9-bit binary with x's and z's
                'o91: unsized octal number of size >= 32-bits
                8'b11: 0000_0011
                8'o11: 00_001_001 (9 decimal)
                8'd11: 0000_1011
                8'h11: 0001_0001 (17 decimal)
                'b11: 0000_0000_0000_0000_0000_0000_0000_0011 (unsized hence 32-bit)
                10'h0z: 00_0000_zzzz
                10'hz0: zz_zzzz_0000

                SV allows unsized literals
                logic [5:0] bus;
                bus = '0; // 000000
                bus = '1; // 111111
                bus = 'z; // zzzzzz
                bus = 'x; // xxxxxx
                */

    /*
        Instantiate existing modules with port maps
        ~VHDL Component Declaration+Instantiation with generic values+port maps

        1. Variable is used for connecting to input port of a module instance iff input port is to
        be assigned by a procedural block
        2. Net is used for connecting to input port of a module instance iff input port is driven
        outside a procedural block
        3. Net is used for connecting to output port of a module instance
        4. Net is used for connecting to input-output port of a module instance

        Note: a net can be "driven" by either a net or a variable,
              a variable can be surely "assigned" by a variable however,
              if it can also be "assigned" by a net (very likely) or not is yet to be found out
              Yes indeed
                module some(output reg out_d, input wire in_a, in_b)
                  out_d = in_a && in_b;
                endmodule
    */
    // [component_module_name] [component_identifier] #(optional-generic-map)[(port-map)];
    // port-map: .component_portname1(net_or_var_name),...
    // optional-generic-map: .parameter_name(parameter_value), ...

    // Instantiate built in gates primitives
    // gateTypeKeyword [instanceName] ( portList )  ;

  //----------------------------------Start Body-----------------------------//
  // HOW IT DOES WHAT IT DOES (HOW IT CREATES THE BEHAVIOR)
    /*
    Summary for SystemVerilog based RTL design:
      1. Prefer continuous assignments(blocking) to behaviorally describe
         uncomplicated combinational functions(MISO logic functions, multiplexer).
      2. Do not use procedural blocks other than always_comb, always_ff and always_latch.
      3. In an always_comb block, always use blocking assignments (=). always_comb block allows
         only single driver to a logic type
      4. In always_ff and always_latch blocks, use nonblocking assignments (<=) only.
      5. Do not make #0 (zero delay expression) procedural assignments.
      6. If writing Verilog exclusively,

      ------------------------------------- --------------------------------------------------------
      Data Object or type                   Write method
      ------------------------------------- --------------------------------------------------------
      wire(a net data type)                 continuous assignment(blocking, assign wire = ...;)
                                            to describe combinational logic in dataflow style
                                            always "driven" outside procedural block
      output port(type wire)                -DO-
      inout port(default net type like wire) -DO-.
                                            Note: SV allows i/o port to be variable type also.
                                            but this is seldom useful
                                            "var logic" required for input port to be a 4-state variable type
      reg(a variable data type)             non-blocking assignment(<=): sequential logic, testbench
                                            blocking assignment(=): combinational logic
                                            always "assigned" by a procedural block

      output port(type reg)                 -DO-
      input port(default net type like wire) N.A.
                                            Note: SV allows inout port to be variable type also.
                                            but this is seldom useful
                                            "var logic" required for inout port to be a 4-state variable type
      ------------------------------------- --------------------------------------------------------

      6. If writing SystemVerilog exclusively, use logic type for input/output
         ports, all variables in always blocks, all nets inside the circuit
    */

    /* Continuous assignment (blocking =) with optional delay Tpd>=0
       Models Combinational Logic in dataflow style

        assign [#Tpd] [variable_1 or wire_1] = [a&l expression with one or more variables];
        assign [#Tpd] [variable_2 or wire_2] = [function calls(but no tasks)];

      - blocking assignment i.e. lhs (=) rhs
      - LHS can be wire or logic but not reg.
      - RHS can be input port, literal, wire, logic, bit or reg
      - Timing expressions such as #0.05 or #10 are ignored by the logic
        synthesizer and are useful only in simulation
      - Concurrent process expressed as a single statement
      - Represents single, permanent connections of something to a net(wire is one type of net)
      - The RHS expression is evaluated and assigned to LHS after the optionally
        specified delay has elapsed i.e. if one or more variables in rhs
        expression has just been updated, the rhs expression is evaluated,
        and this resulting value is scheduled for assignment to lhs at Tpd time
        ahead of current simulation time
    */

    /* Continuous assignment used for expressing conditional execution
       (synthesis to combinational logic)(dataflow style)
      - Usually used for writing Mux
      - assign [variable_3 or wire_3] = [ (boolean_expr)? expr_true : expr_false];
    */

    /* Procedural Blocks or Processes
      -  process which executes concurrent outside w.r.t to other processes but
         which executes within itself sequentially like a programming language.
         i.e. concurrent outside and sequential inside
        - Can update more than 1 variable
        - Expressed as set of statements that get executed in sequence
        - Can use local variables for temporary purpose
        - always and initial are two types of procedural blocks
        - Control conditions for activation of process
        - Procedural block as a whole executes as a concurrent process
        - Any procedural block or process consists of set of either blocking
          assignment statements (=) that execute in sequence within process
          to describe combinational logic or non-blocking assignment statements(<=)
          that execute concurrently within process each other to descibe sequential logic
    */

    /*  Describing Combinational logic behaviorally using always Procedural block or Process
        Combinational logic can be expressed behaviorally using always procedural block or
        process construct with a sensitivity list that contains comma separated list of ALL
        inputs of the combinational logic being modeled
        - A procedural block that implements a MIMO truth table or a digital
          logic function(equation) behaviorally
        - The procedural constructs that can be used to  describe combinational
          logic are:
            always_comb,
            always @(*) or
            always@(comma separated list of ALL inputs to the combinational circuits)
    */

    /* Behavioral level Combinational Logic Verilog Style 1 (Recommended) */
    always @(*)
    begin
        // blocking assignment statement1;
        // blocking assignment statement2;
    end

    /* Behavioral level Combinational Logic Verilog Style 2 */
    always @(<comma separated list of ALL combinational inputs>)
    begin
        // blocking assignment statement1;
        // blocking assignment statement2;
    end

    /* Behavioral level Combinational Logic SystemVerilog Style (Recommended) */
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
      // (#[time][timeunit]) as prefix of lhs i.e. #tpd lhs = rhs;
      // ~VHDL variable assignment ":=""
      // i.e Effect of Verilog blocking assignment to a variable is
      // same as effect of VHDL variable update within a process.

      // 1. Blocking assignment with no delay: evalue rhs and assign this
      //    result to LHS immediately.
      a = b|c;          // Assign at 0ns

      // NOTE: always_comb block enforces only a single driver to a logic type

      // 2. Blocking assignment with delay: process execution suspended
      //    until simulation time advances by specified delay (20ns)
      //    Evaluate rhs but assign this result to LHS after specified
      //    time(20ns) has elapsed
      #20ns d = a-c;  // Assign at 20 ns
      #30   k = a*c;  // Assign at 50 ns (assuming timescale is 1ns)

      // Use if-else control block for indicating explicit priority among
      // mutually exclusive events. For example expr1 has higher priority
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
            // TBU: NOTE: below format to specify delay for non-blocking assignment
            // is not correct and is only valid for blocking assignment delays. see
            // below to know how to correctly specify delays for non-blocking assignments
            // called as intra-assignment delay
            #5 p <= 'b1;  // incorrect.  should be p <= #5 'b1;'

        else
            // Procedural assignment statement: prefer non-blocking assignment
            // for describing sequential logic.
            // Non-blocking assignment with no delay specified: Evaluate RHS but
            // defer(schedule) its assignment to LHS until end of current
            // simulation time step.
            // In terms of hardware semantics, this means that all non-blocking
            // assignments happpen in parallel
            // ~VHDL continuous assignment '<='
            x <= a & b;       // zero delay delta representing c2q delay
            y <= a|c;         // zero delay delta representing c2q delay
            z < = a & b | c;

            // Non-blocking assignment with a specified delay: evaluate rhs but
            // defer(schedule) its assignment to LHS until current simulation
            // time advances by specified delay.
            // NOTE unlike blocking delay which is prefix in blocking statement
            // such as #tpd lhs = rhs
            // this type of delay called intra-assignment delay is used for
            // non-blocking assignments has a different format where the delay
            // is specified in-between lhs= and rhs i.e. lhs = #tpd rhs
            // This delay doesn't block or suspend the procedure and procedure
            // continues to execute following assignments and reaches end in zero time
            // however the rhs value is only now assigned after specified delay to lhs
            // relative to the start time of the always block
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

    /* Testbench using procedural block or process
       1. Uses "initial" construct as procedural block
       2. Execution of initial procedural block or process starts at beginning of simulation
       3. When all statements inside initial process or block complete, the process terminates
       4. Is executed only once unlike always consturct which repeats after every completion
          until simulation ends
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
