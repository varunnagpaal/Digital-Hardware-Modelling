module multiplexor_test;

  localparam WIDTH=5;

  reg              sel  ;
  reg  [WIDTH-1:0] in0  ;
  reg  [WIDTH-1:0] in1  ;
  wire [WIDTH-1:0] mux_out;

  multiplexor
  #(
    .WIDTH ( WIDTH )
   )
  multiplexor_inst
  (
    .sel     ( sel     ),
    .in0     ( in0     ),
    .in1     ( in1     ),
    .mux_out ( mux_out ) 
  );

  task expect;
    input [WIDTH-1:0] exp_out;
    if (mux_out !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d sel=%b in0=%b in1=%b mux_out=%b",
               $time, sel, in0, in1, mux_out);
      $display("mux_out should be %b", exp_out);
      $finish;
    end
   else begin
      $display("At time %0d sel=%b in0=%b in1=%b, mux_out=%b",
               $time, sel, in0, in1, mux_out);
   end 
  endtask

  initial begin
    sel=0; in0=5'h15; in1=5'h00; #1 expect (5'h15);
    sel=0; in0=5'h0A; in1=5'h00; #1 expect (5'h0A);
    sel=1; in0=5'h00; in1=5'h15; #1 expect (5'h15);
    sel=1; in0=5'h00; in1=5'h0A; #1 expect (5'h0A);
    $display("TEST PASSED");
    $finish;
  end

endmodule
