// We assume clock with frequency F = 100 Hz or period T = 10 ms
`timescale 1ms/1us
module trafficlight_controller_tb;

  // Inputs
  reg clk;
  reg rst;

  // outputs
  wire light1_green;
  wire light1_red;
  wire light1_yellow;
  wire light2_green;
  wire light2_red;
  wire light2_yellow;

  // Constants
  localparam  CLK_PERIOD = 10;  // in ms

  task expect;
    input light1_green_exp;
    input light1_red_exp;
    input light1_yellow_exp;
    input light2_green_exp;
    input light2_red_exp;
    input light2_yellow_exp;

    if ((light1_green_exp !== light1_green) ||
        (light1_red_exp !== light1_red) ||
        (light1_yellow_exp !== light1_yellow) ||
        (light2_green_exp !== light2_green) ||
        (light2_red_exp !== light2_red) ||
        (light2_yellow_exp !== light2_yellow)) begin
      $display("TEST FAILED");
      $display("At time %0d: light1_green=%0b, light1_red=%0b, light1_yellow=%0b, light2_green=%0b, light2_red=%0b, light2_yellow=%0b",
               $time,
               light1_green, light1_red, light1_yellow,
               light2_green, light2_red, light2_yellow);

      $display("Should be light1_green=%0b, light1_red=%0b, light1_yellow=%0b, light2_green=%0b, light2_red=%0b, light2_yellow=%0b",
                light1_green_exp, light1_red_exp, light1_yellow_exp,
                light2_green_exp, light2_red_exp, light2_yellow_exp );
      $finish;
    end
   else begin
     $display("At time %0d: light1_green=%0b, light1_red=%0b, light1_yellow=%0b, light2_green=%0b, light2_red=%0b, light2_yellow=%0b",
              $time,
              light1_green, light1_red, light1_yellow,
              light2_green, light2_red, light2_yellow);
   end

  endtask

  // Instantiate the Unit Under Test (UUT)
  trafficlight_controller uut(.clk(clk),
                              .rst(rst),
                              .light1_green(light1_green),
                              .light1_red(light1_red),
                              .light1_yellow(light1_yellow),
                              .light2_green(light2_green),
                              .light2_red(light2_red),
                              .light2_yellow(light2_yellow));

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

    // Wait for reset to Deassert
    @(negedge rst);

    // On reset the expected state: L1 - G, L2 - R
    expect( 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0);

    // After 60 sec or 6000 cc, the expected state: L1 - Y, L2 -R
    #60010 expect( 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0);

    // After 5 sec or 500 cc, the expected state: L1 - R, L2 -G
    #5010 expect( 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0);

    // After 60 sec or 6000 cc, the expected state: L1 - R, L2 -Y
    #60010 expect( 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1);

    // After 5 sec or 500 cc, the expected state: L1 - G, L2 -R
    #5010 expect( 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0);

    $display("TEST PASSED");
    $finish;
  end
  
endmodule // module trafficlight_controller_tb;
