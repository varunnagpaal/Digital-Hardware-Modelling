`timescale 1ns / 1ps

module mux4to1_beh_2_tb;

  // Inputs
  reg [3:0] data_in;
  reg [1:0] ctrl_sel;

  // Outputs
  wire data_out;

  // Instantiate the Unit Under Test (UUT)
  mux4to1_beh_2 uut (
    .data_in(data_in),
    .ctrl_sel(ctrl_sel),
    .data_out(data_out)
  );

  task expect;
    input exp_out;
    if (data_out !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d data_in=%b, ctrl_sel=%b, data_out=%b",
               $time, data_in, ctrl_sel, data_out);
      $display("data_out should be %b", exp_out);
      $finish;
    end
   else begin
     $display("At time %0d data_in=%b, ctrl_sel=%b, data_out=%b",
              $time, data_in, ctrl_sel, data_out);
   end
  endtask

  initial begin
    data_in = 4'b1010;

    ctrl_sel = 2'b00;
    #10 expect(1'b0);

    ctrl_sel = 2'b01;
    #10 expect(1'b1);

    ctrl_sel = 2'b10;
    #10 expect(1'b0);

    ctrl_sel = 2'b11;
    #10 expect(1'b1);

    $display("TEST PASSED");
    $finish;
  end

endmodule
