`timescale 1ns / 1ps

module counter_updown_tb;

  // Inputs
  reg clk_in;
  reg rst_in;
  reg sync_load_in;
  reg  [11:0] count_in;
  reg updown_in;

  // Outputs
  wire  [11:0] count_out;

  // Instantiate the Unit Under Test (UUT)
  counter_updown uut (
  .clk_in(clk_in),
  .rst_in(rst_in),
  .sync_load_in(sync_load_in),
  .count_in(count_in),
  .updown_in(updown_in),
  .count_out(count_out)
  );

  task expect;
    input [11:0] exp_out;

    if (count_out !== exp_out)
      begin
        $display("TEST FAILED");
        $display("At time %0d rst=%0b, load=%0b, updown=%0b, count_in=%d, count_out=%d",
                 $time, rst_in, sync_load_in, updown_in, count_in, count_out );
        $display("count_out should be %d", exp_out );
        $finish;
      end
    else
      begin
        $display("At time %0d rst=%0b, load=%0b, updown=%0b, count_in=%d, count_out=%d",
                 $time, rst_in, sync_load_in, updown_in, count_in, count_out );
      end
  endtask

  // Clock and async reset stimulus
  initial
  begin
   clk_in = 1'b0;
   rst_in = 1'b1;

   // hold async reset for next 2 cc
   repeat(4) #10 clk_in = ~clk_in;

   // deassert reset
   rst_in  = 1'b0;

   // clock forever
   forever #10 clk_in = ~clk_in;
  end

  // Stimulus
  initial
  begin
    // Initialize Input count_in to 1024 to observe effect of reset
    // no load
    // count up
    count_in = 12'd1024;
    sync_load_in = 1'b0;
    updown_in = 1'b1;

  	// Observe effect of async reset
  	@(negedge clk_in);
  	expect(12'd0);

    // wait for async reset to deassert
    @(negedge rst_in);

    // load count_in value
    sync_load_in = 1'b1;
    @(negedge clk_in);
    expect(12'd1024);

    // stop loading
    sync_load_in = 1'b0;

    // as we are up counting we should see following values
    @(negedge clk_in);
    expect(12'd1025);
    @(negedge clk_in);
    @(negedge clk_in);
    expect(12'd1027);

    // count down
    updown_in = 1'b0;
    @(negedge clk_in);
    expect(12'd1026);

    $display("TEST PASSED");
    $finish;
  end

endmodule // counter_updown_tb
