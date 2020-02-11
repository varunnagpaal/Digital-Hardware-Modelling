`timescale 1ns / 1ps

module dff_async_rst_tb;

  // Inputs
  reg clk;
  reg rst;
  reg d;

  // Outputs
  wire q;

  // Instantiate the Unit Under Test (UUT)
  dff_async_rst uut (
  .clk(clk),
  .rst(rst),
  .d(d),
  .q(q)
  );

  task expect;
    input exp_out;
    if (q !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d rst=%0b, d=%0b, q=%0b",
               $time, rst, d, q );

      $display("q should be %0b", exp_out );
      $finish;
    end
   else begin
     $display("At time %0d rst=%0b, d=%0b, q=%0b",
              $time, rst, d, q );
   end
  endtask

  // Clock and async reset stimulus
  initial begin
   clk = 1'b0;
   rst = 1'b1;

   // hold async reset for next 2 cc
   repeat(4) #10 clk = ~clk;

   // deassert reset
   rst  = 1'b0;

   // clock forever
   forever #10 clk = ~clk;
  end

  // Stimulus
  initial begin
    // Initialize Input d to 1 to observe effect of reset
    d = 1'b1;

  	// Observe effect of async reset
  	@(negedge clk);
  	expect(1'b0);

    // wait for reset to deassert
    @(negedge rst);

    // as d is still set to 1, we should get q as 1 next
    @(negedge clk)
    expect(1'b1);

    // set d to 0, we should get q as 0 next
    d = 1'b0;
    @(negedge clk);
    expect(1'b0);

    $display("TEST PASSED");
    $finish;
  end
endmodule
