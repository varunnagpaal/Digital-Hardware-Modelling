////////////////////////////////////////////////////////////////////////////////
// Module Name  : template_clocking_blocks
// File name    : template_clocking_blocks.sv
// Description  : Template for SystemVerilog Clocking Blocks
// Type         : 
// Limitations  : None
// Model Styles : 
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 14/10/2020
////////////////////////////////////////////////////////////////////////////////

/* Clocking blocks is a verification construct with following purpose:
  - Explicitly defines timing for a set of pre-delcared i/o signals relative to
    a clock signal thereby separating signal timing from signal function.
  - Data outputs driven on an active clock edge by a clocking block have a +ve 
    skew (+ve delay) added to the output transition relative to the active clock
    edge i.e. outputs are driven at time slightly after active clock edge (output hold time).
  - Data inputs sampled on an active clock edge by a clocking block have a -ve 
    skew (-ve delay) added to the input transition relative to the active clock
    edge i.e. inputs are sampled at time slightly before active clock edge (input setup time).
  - Used by a testbench to drive outputs and sample inputs into/from DUT relative
    to a clock signal.
  - Designed to prevent race condition between clock and data signals on active
    clock edges when a testbench drives data into DUT inputs and samples DUT outputs.
  - Declaration of a clocking block is its implicit instantiation.
  - Declared inside a module or an interface.
  - Cannot be declared inside a package or compilation unit scope.
  - Cannot declare signals.
  - Asynchronous signals such as reset should never be driven or sampled through 
    a clocking block.
  - Declares direction of pre-declared testbench i/o signals along with optional 
    explicit skew for each i/o signal.
  - Declares optional default skew for signals whose explicit skew not indicated.
  - When neither default nor explicit skew is declared in clocking block, a default  
    #1step input skew and #0 output skew is applied.
  - Input with #1step skew is sampled at end of previous time step before clocking 
    block event.
  - Output with #0 skew is driven at same moment as clocking block event
  - Skew should be either a 
    - positive number (#6)
    - time literal (#1ns, #2step)
    - edge of clocking block event (posedge, negedge edge)
    - or constant expression (##N for N clock cycles) which may also include parameters
  - ###0 is a special case which means wait for clocking event in this time step 
    but donot wait if it has already occurred
  - Note that: skews are applied to signals only when Testbench outputs are driven 
    or Testbench inputs are sampled synch to clocking block event. Not otherwise 
    i.e. skews are not applied to regular signal drive and signal sampling.
  - for multiple clocks and different signal sets, multiple clocking blocks can be
    defined in the same scope. One of these clocking block can be made default
  - multiple clocking blocks can be defined for same clock with different signal set
  - clocking block can be used to drive or sample signals in other scopes using hierchichal
    expressions. For example at times one might need to sample internal nodes. 
    For this, the hierarchichal expression referring to an out of scope signal
    must be associated (alias) with a virtual signal local to the clocking block
*/

`timescale 1ns/100ps; // = #1/#1step

//  Module: testbench
module testbench;

  // Testbench signals
  logic clk1, clk2;

  // for clock domain clk1
  logic in_data, in_ready;
  logic out_data, out_valid;
  logic dreg_data, dreg_ready;

  // for clock domain clk2
  logic in_data2, in_ready2;
  logic out_data2, out_valid2;
  logic dreg_data2, dreg_ready2;

  // Clock 1 driving logic
  parameter ClockHigh1 = 6, ClockLow1 = 4;  
  initial
  begin
    clk1 <= 1'b0;

    forever
    begin
      #ClockLow1   clk1 <= 1'b1;
      #ClockHigh1  clk1 <= 1'b0;
    end
  end

  // Clock 2 driving logic
  parameter ClockHigh2 = 5, ClockLow2 = 5;  
  initial
  begin
    clk2 <= 1'b0;

    forever
    begin
      #ClockLow2   clk2 <= 1'b1;
      #ClockHigh2  clk2 <= 1'b0;
    end
  end

  // Clocking block 1 for clock 1
  clocking cb1@(posedge clk1);    // 1: clocking edge event
    default input  #1             // 2: input skew is -1
            output #3;            //    output skew is +3

    // other skew examples
    // default input  #1step
    //         output #2;
  
    // testbench signal declarations with optional explicit skew
    input       in_data;        // Implicit input skew of -1
    input   #2  in_ready;       // Explicit input skew of -2
    output      out_data;       // Implicit output skew of +3
    output  #1  out_valid;      // Explicit output skew of +1  

    // Examples of other signal direction with explicit skews
    // input negedge in_ready;
    // input #1step in_data;
    // output posedge out_valid;
    // output #1step out_data;
  endclocking

  // Clocking block 1 is default clocking block
  default clocking cb1;

  // Clocking block 2 based on clock 2
  clocking cb2@(posedge clk2);    // 1: clocking edge event
    default input  #2             // 2: input skew is -2
            output #1;            //    output skew is +1
   
    // testbench signal direction declaration with optional explicit skew
    input negedge in_ready2;
    output posedge out_valid2;
  endclocking

  // Clocking block 22 based on clock 2
  clocking cb22@(posedge clk2);   // 1: clocking edge event
    default input  #2             // 2: input skew is -1
            output #4;            //    output skew is +4
   
    // testbench signal direction declaration with optional explicit skew
    input in_data2;
    output out_data2 = top.dut.data;  // associating an out of scope signal referred by hierarchichal expression to a virtual signal inside this clocking block so that this clocking block can drive it
  endclocking  

  // Testbench
  initial begin
    @(cb1);              // synch to clocking block event

    // Driving Testbench outputs aka DUT inputs
    cb1.out_data <= 1'b1;    // clocking block driven: 3 timeunits skew applied after active clock edge
    out_valid <= 1'b1;      // NOT clocking block driven: no skew applied as this is not driven via clocking block

    // Sampling Testbench inputs aka DUT outputs
    // clocking block automatically samples inputs at specified skew delay before clocking event
    // These sampled values are stored in the clocking block and can be read anytime
    // by reading the signal via clocking block
    @(cb1.in_data);             // synch to clocking block input to be sampled or to specific edge in an input or slice of input vector eg @(posedge cb.in_data[2])
    dreg_data <= cb1.in_data;   // clocking block sampled: -1 skew applied while reading last sample
    dreg_data <= in_data;       // Not clocking block sampled: no skew applied

    dreg_data <= cb1.in_data;   // clocking block sampled: -1 skew applied while reading new sample

    ##3;                        // this 3 cc delay is relative to default clocking block 1. if default clocking block not assigned, will generate compile error
    ##1 cb1.out_data <= 1'b1;   // clocking block driven: 1cc cb1 delay + 3 timeunits output skew applied after active clock edge

    @(cb2);
    cb2.out_valid2 <= ##2 1'b0; // intra-assignment delay of 2 cc + 4 output skew
  end
endmodule: testbench