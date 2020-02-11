///////////////////////////////////////////////////////////////////////////////
// Module Name  : template_tb
// File name    : template_tb.sv
// Description  : Template for SystemVerilog Testbench
// Type         :
// Limitations  : None
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 19/07/2019
///////////////////////////////////////////////////////////////////////////////

/*
  In Verilog, Timescale macro helps simulator interpret tpd in expressions [#tpd]
  `timescale [reference-timeunit]/[precision-timeunit]

  timeunit - s, ms, us, ns, ps, fs

  [reference-timeunit] => #1 equals reference-timeunit delay
  [precision-timeunit] => all delays should be calculated upto a precision of precision-timeunit

  reference-timeunit >= precision-timeunit
  Note: that only numbers legal for use is timescale directives are 1, 10 and 100

  Timescale can always be later overriden by a new timescale directive
  Note that in case there are multiple modules being compiled with some modules
  having missing timescale directives and some including separate timescale directives,
  then compilation order can change which timescale is used by module with missing timescale
  directive
*/
`timescale 1ns/100ps;

/*
  In SystemVerilog, alternative to timescale macro is as follows:
  module testbench;
    // placed inside module
    // are declarations not directives
    // must be first statement of the module
    // scope limited to module and nested module
    timeunit    1ns;
    timeprecision   100ps;

    logic a, b;

    initial begin
      #20ns a = 1'b0;
      #14   b = 1'b1;
    end
  endmodule

  or

  timeunit 1ns/100ps; // similar to `timescale 1ns/100ps.

  In addition, SV allows to use time literals with time unit can be explicity and arbitrarily
  specified with the time value independently from the declared timescale directive
  Example: 10ps, 1.5ps, 1step (simulation step. no 2step etc.).

  However, SV still scales literal to declared timeunit and rounds it to current time precision
  So timeunit and timeprecision must be specified for the scope where time literals are specified
  Example:

  timeunit    1ns;
  timeprecision   100ps;

  30ns    // 30ns
  1us     // scaled to 1000ns
  4.27ns  // rounded to 4.3 ns
  #1step  // advances simulation by 1 simulation step or timeprecision of 100ps


*/

module Testbench;

  // Always use reg for feeding inputs to DUT
  reg clock, reset;
  reg Astim, Bstim;

  // Always use wire to watch outputs of DUT
  wire Xwatch, Ywatch, Zwatch;

  // Instantiating Device under test (DUT)
  DUTModuleName dut_module_instance( .X(Xwatch), .Y(Ywatch), .Z(Zwatch),
                     .A(Astim), .B(Bstim),
                     .clock(clock)
                    );

/*
  Rule: Always make separate initial blocks for clk and stimulus. The reset can
        be asserted in initial block of clk or stimulus or in a separate initial
        block.

  An initial block as a whole runs only once until all instructions in it finish
  This is unlike always block which can run unlimited number of times each time
  triggered by value change in one or more signals in its sensitivity list.

  Note that there maybe multiple procedural blocks(initial and always) in a
  Verilog module.

  All procedural blocks i.e. initial and alwaus start running in parallel at
  simulation time 0. Each initial block run once until it runs out of
  instructions. In case an initial block has a forever block in the end part of
  its block, it stops executing only when simulation ends.

  As initial block runs only once, it can never be used for enclosing
  synthesizable behavioral code and is therefore only used for purpose of
  testbench. So initial block is non-synthesizable and is ignored by synthesis
  tools.

  Note: There is no way to synchronize two procedural blocks in Verilog
        (initial-initial, initial-always, always-always) [TBU]

  begin-end Block: Statements within begin-end block are executed in sequence
                   A begin-end block maybe synthesizable but only when used for
                   an always block

  fork-join Block:  Statements within a fork-join block are executed in parallel
                    A fork-join block is non-synthesizable
*/
  initial
  begin
    #0    reset = 1'b0;
    #tpd0 reset = 1'b1;
    #tpd1 Astim = 1'b0;
    #tpd2 Bstim = 1'b1;
    #tpd3 Astim = 1'b1;
    //..
    //..
    #tpdn $finish;

    // One may dump simulation responses to a VCD (Value change dump) file
    // at end of the simulation
    $dumpfile( "waveforms.vcd" ); // prepares vcd file to dump verilog variables
    $dumpvars;                    // dumps all variables to the vcd file
  end

  always@(Xwatch, Ywatch, Zwatch)
  begin
/*
    To monitor what is happening during simulation, Verilog provides system
    tasks to write messages to display screen: $display, $write, $strobe,
    $monitor.

    $display and $write:
        generate outputs at exact point at which they are called in simulation
        cycle i.e. before RHS evaluations (before non blocking assignments)
    $monitor
        generates output continuously whenever any one of its arguments changes
        value. i.e after RHS evaluations and non-blovking assignments. Only one
        monitor can be active at a time.
    $strobe
        generates output at end of simulation cycle i.e. it generates output
        with only stable data i.e. after RHS evaluatins (after non blocking
        assignments)
*/
    $display( message_with_format_specifiers_and_delimiter_chars_with_default_newline_at_end,
              verilog_variables_signals );
    $write( message_with_format_specifiers_and_delimiter_chars,
            verilog_variables_signals );
    $monitor( message_with_format_specifiers_and_delimiter_chars,
              verilog_variables_signals );
    $strobe( message_with_format_specifiers_and_delimiter_chars,
             verilog_variables_signals );
  end

  // We can define periodic clock in number of ways
  // Method 1: Using forever inside an initial block to define clock with
  //           variable duty cycle. This is a recommended method.
  parameter ClockHigh = 6, ClockLow = 4; // in defined timescale
  initial
  begin
    // Initialize clock signal
    clock <= 1'b0;

    // forever repeats its body until the simulation terminates
    forever
    begin
      #ClockLow   clock <= 1'b1;
      #ClockHigh  clock <= 1'b0;
    end
    // NOTE: Dont add any statements after first forever block enclosed
    // inside a begin-end block as these statements will never be executed
  end

  // Method 2: Using forever inside an initial block to define clock with
  //           50% duty cycle. This is a recommended method.
  parameter HalfClockPeriod = 2.5;
  initial
  begin
    clock <= 1'b0;

    // forever repeats its body until the simulation terminates
    forever
    begin
      #HalfClockPeriod clock <= ~clock;
    end
    // NOTE: Dont add any statements after first forever block enclosed
    // inside a begin-end block as these statements will never be executed
  end

  // Method 3: Using always to define clock with variable duty cycle
  always
  begin
    clock <= 1'b0;  #ClockLow
    clock <= 1'b1;  #ClockHigh
  end

  // Method 4: Using an intial block to initialize clock and a level
  //           sensitive(to clock) always procedural block to toggle the clock.
  //
  // Problem here is that there is a race between intial and always block to
  // update clock signal. When the initial block writes 0 to clock, at the same
  // time the always block may be reading the clock, complementing it or writing
  // complemented value to it. As there is no way to synchronize two procedural
  // blocks in Verilog, the non-deterministice relative ordering of
  // reading-writing operations from/to clock by initial and always block can
  // produce incorrect clock signal. This method for clock generation is thus
  // not recommended.
  always@(clock)
  begin
    // toggle clock signal after 5 timeunits
    #5 clock <= !clock; // or ~clock
  end

  initial
  begin
    // Initialize clock signal
    #0    clock = 1'b0;

    // Initialize reset
    #0    reset = 1'b0

    // Resetting the design
    #tpd0 reset = 1'b1;
    #tpd1 reset = 1'b0;

    // Starting the stimulus applicaiotn
    #tpd2 Astim = 1'b0;
    #tpd3 Bstim = 1'b1;
    #tpd4 Astim = 1'b1;
    //..
    //..
    // Finishing the stimulus application
    #tpdn $finish;
  end

  // Methods for generating for multiple clocks
  // Method 1: Use fork-join inside an initial begin-end block
  intial
  begin : clkgenblk

    // Initialize clocks
    #0  clk1 <= 1'b0;
      clk2 <= 1'b0;

    // All statements inside fork-join execute in parallel
    fork
      forever
      begin : clk1toggle
        #5 clk1 <= ~clk1;
      end

      forever
      begin : clk2toggle
        #2 clk2 <= ~clk2;
      end
    join
  end

  // Method 2: Make separate initial blocks for two clocks
  parameter Clock1_High = 6, Clock1_Low = 4; // in defined timescale
  initial
  begin : clkgenblk1

    // Initialize clock
    #0 clk1 <= 1'b0;

    // forever repeats its body until the simulation terminates
    forever
    begin : clk1toggle
      #Clock1_Low   clk1 <= 1'b1;
      #Clock1_High  clk1 <= 1'b0;
    end
    // NOTE: Dont add any statements after first forever block enclosed
    // inside a begin-end block as these statements will never be executed
  end

  parameter Clock2_High = 5, Clock2_Low = 5; // in defined timescale
  initial
  begin : clkgenblk2

    // Initialize clock
    #0 clk2 <= 1'b0;

    // forever repeats its body until the simulation terminates
    forever
    begin : clk2toggle
      #Clock2_Low   clk2 <= 1'b1;
      #Clock2_High  clk2 <= 1'b0;
    end
    // NOTE: Dont add any statements after first forever block enclosed
    // inside a begin-end block as these statements will never be executed
  end
endmodule // Testbench
