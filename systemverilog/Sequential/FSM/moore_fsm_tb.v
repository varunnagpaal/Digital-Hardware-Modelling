// We assume clock with frequency F = 100 MHz or period T = 10 ns
`timescale 1ns / 1ps
module moore_fsm_tb;

  // Inputs (reg because they are assigned using procedural blocks)
  reg clk;
  reg rst;
  reg inp;

  // outputs
  wire oup;
  wire [2:0] current_state;
  wire [2:0] next_state;

  // Clock Constants
  localparam  CLK_PERIOD = 10;  // in ns

  // Input value enumerations (constants)
  localparam  i_val_a = 1'b0;
  localparam  i_val_b = 1'b1;

  // State assignment (constants)
  localparam  STATE_U = 3'b000;
  localparam  STATE_V = 3'b001;
  localparam  STATE_W = 3'b010;
  localparam  STATE_X = 3'b011;
  localparam  STATE_Y = 3'b100;
  localparam  STATE_Z = 3'b101;

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
  moore_fsm uut(.clk(clk),
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
    // expected s(k) = STATE_U, o(k)=1 , s(k+1) = STATE_Z
  	@(negedge clk);
  	expect(STATE_U, 1'b1, STATE_Z);

    // Wait for reset to Deassert
    @(negedge rst);

    // input same as last
    // expected s(k) = STATE_Z, o(k)=1 , s(k+1) = STATE_Y
  	@(negedge clk);
  	expect(STATE_Z, 1'b1, STATE_Y);

    // input same as last
    // expected s(k) = STATE_Y, o(k)=1 , s(k+1) = STATE_V
  	@(negedge clk);
  	expect(STATE_Y, 1'b1, STATE_V);

    // input same as last
    // expected s(k) = STATE_V, o(k)=0 , s(k+1) = STATE_Z
  	@(negedge clk);
  	expect(STATE_V, 1'b0, STATE_Z);

    // wait for last state transition to complete
  	@(posedge clk);

    // Change input
    inp = i_val_b;

    // expected s(k) = STATE_Z, o(k)=1 , s(k+1) = STATE_X
  	@(negedge clk);
  	expect(STATE_Z, 1'b1, STATE_X);

    // input same as last
    // expected s(k) = STATE_X, o(k)=0 , s(k+1) = STATE_X
  	@(negedge clk);
  	expect(STATE_X, 1'b0, STATE_X);

    // wait for last state transition to complete
  	@(posedge clk);
    
    // Change input
    inp = i_val_a;

    // expected s(k) = STATE_X, o(k)=0 , s(k+1) = STATE_Y
  	@(negedge clk);
  	expect(STATE_X, 1'b0, STATE_Y);

    $display("TEST PASSED");
    $finish;
  end

endmodule // module moore_fsm_tb;
