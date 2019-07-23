Lab 4-1 The Address Multiplexor
Objective: To use basic Verilog constructs to describe a simple design.

The address multiplexor selects between the instruction address during
the instruction fetch phase and the operand address during the
instruction execution phase. The output is the in1 value while selected
 (sel is true) and otherwise is the in2 value.

Further Information

A module parameter is a constant that the elaborator can override on a per-
instance basis. You can use the parameter for example to specify input and
output port widths. Declare the parameter either:

- In a module, parameter is specified before the port list, for example:

module multiplexor #(parameter WIDTH=5) (sel, in0, in1, mux_out);
  input              sel;
  input  [WIDTH-1:0] in0, in1;
  output [WIDTH-1:0] mux_out;
  reg    [WIDTH-1:0] mux_out;

module multiplexor #(parameter WIDTH=5) (
  input  wire             sel,
  input  wire [WIDTH-1:0] in0, in1,
  output reg  [WIDTH-1:0] mux_out
);

- As a module item after the port list, for example:

module multiplexor (sel, in0, in1, mux_out);
  parameter WIDTH=5;
  input              sel;
  input  [WIDTH-1:0] in0, in1;
  output [WIDTH-1:0] mux_out;
  reg    [WIDTH-1:0] mux_out;

A port declaration declares a port to a module net or variable. The port does not exist in isolation,
so if you fail to declare the associated net or variable, the port declaration also implicitly
declares a net, by default a wire, having the same name. Nets (whether declared explicitly or implicitly),
and reg variables are scalar unless declared with a range.
You declare a range with the syntax:[left-bound:right-bound]
The bounds have no restrictions other than that they must be constant.

1. Change to the lab4-mux directory and examine the files provided therein:

README.txt         Lab instructions
multiplexor_test.v  Multiplexor test

2. Create the multiplexor.v file, and using your favorite editor, describe therein the
   multiplexor module. Parameterize the multiplexor input and output width so that the
   instantiating module can specify the width of each instance. Assign a default value
   to the parameter.

3. Using the provided test module, test your multiplexor description; enter:

irun multiplexor.v multiplexor_test.v
	You should see the below results:
	At time 1 sel=0 in0=10101 in1=00000, mux_out=10101
	At time 2 sel=0 in0=01010 in1=00000, mux_out=01010
	At time 3 sel=1 in0=00000 in1=10101, mux_out=10101
	At time 4 sel=1 in0=00000 in1=01010, mux_out=01010
	TEST PASSED

4. Correct your multiplexor description as needed.
