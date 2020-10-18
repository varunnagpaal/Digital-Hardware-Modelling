// We assume clock with frequency F = 100 MHz or period T = 10 ns
`timescale 1ns / 1ps
module mealy_fsm_tb;

  // Inputs (reg because they are assigned using procedural blocks)
  reg clk;
  reg rst;
  reg inp;

  // outputs
  wire oup;
  wire [1:0] current_state;
  wire [1:0] next_state;

  // Clock Constants
  localparam  CLK_PERIOD = 10;  // in ns

  // Input value enumerations (constants)
  localparam  i_val_a = 1'b0;
  localparam  i_val_b = 1'b1;

  // State assignment (constants)
  localparam  STATE_P = 2'b00;
  localparam  STATE_Q = 2'b01;
  localparam  STATE_R = 2'b10;
  localparam  STATE_T = 2'b11;

  task expect;
    input exp_current_state;
    input exp_oup;
    input exp_next_state;

    if (exp_oup !== oup) begin
      $display("TEST FAILED");
      $display("k=%0d: s(k)=%0d, i(k)=%0b, o(k)=%0b, s(k+1)=%0d",
               $time,
               current_state,
               inp,
               oup,
               next_state );

     $display("Should be k=%0d: s(k)=%0d, i(k)=%0b, o(k)=%0b, s(k+1)=%0d",
              $time,
              exp_current_state,
              inp,
              exp_oup,
              exp_next_state );
      $finish;
    end else begin
      $display("k=%0d: s(k)=%0d, i(k)=%0b, o(k)=%0b, s(k+1)=%0d",
               $time,
               current_state,
               inp,
               oup,
               next_state );
    end
  endtask

  // Instantiate the Unit Under Test (UUT)
  mealy_fsm uut(.clk(clk),
                .rst(rst),
                .i_input(inp),
                .o_output(oup),
                .o_current_state(current_state),
                .o_next_state(next_state));

  // Clock and async reset stimulus
  initial begin
    clk = 1'b0;
    rst = 1'b1;

    // hold sync reset for next 2 cc
    repeat(4) #(CLK_PERIOD/2) clk = ~clk;

    // deassert reset
    rst  = 1'b0;

    // clock forever
    forever #(CLK_PERIOD/2) clk = ~clk;
  end

  // Stimulus and checker
  initial begin

    // Default value
    inp = i_val_a;

    // Observe effect of async reset
    // input same as last
    // expected s(k) = STATE_P, o(k)=1 , s(k+1) = STATE_R
  	@(negedge clk);
  	expect(STATE_P, 1'b1, STATE_R);

    // Wait for reset to Deassert
    @(negedge rst);

    // input same as last
    // expected s(k) = STATE_R, o(k)=1 , s(k+1) = STATE_Q
  	@(negedge clk);
  	expect(STATE_R, 1'b1, STATE_Q);

    // input same as last
    // expected s(k) = STATE_Q, o(k)=0 , s(k+1) = STATE_P
  	@(negedge clk);
  	expect(STATE_Q, 1'b0, STATE_P);

    // wait for last state transition to complete
  	@(posedge clk);

    // Change input
    inp = i_val_b;

    // expected s(k) = STATE_P, o(k)=0 , s(k+1) = STATE_T
  	@(negedge clk);
  	expect(STATE_P, 1'b0, STATE_T);

    // input same as last
    // expected s(k) = STATE_T, o(k)=1 , s(k+1) = STATE_P
  	@(negedge clk);
  	expect(STATE_T, 1'b1, STATE_P);

    $display("TEST PASSED");
    $finish;
  end

endmodule // module mealy_fsm_tb;
