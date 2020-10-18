`timescale 1ns / 1ps

module mux_32to1_2b_tb;

	// Inputs
	reg [63:0] data_in;
	reg [4:0] ctrl_sel;

	// Outputs
	wire [1:0] data_out;

	// Variables
	integer i = 0;
	
	// Instantiate the Unit Under Test (UUT)
	mux_32to1_2b uut (
		.data_in(data_in), 
		.ctrl_sel(ctrl_sel), 
		.data_out(data_out)
	);

  task expect;
    input [1:0] exp_out;
    if (data_out !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d ctrl_sel=%b, data_out=%b",
               $time, ctrl_sel, data_out);
      $display("data_out should be %b", exp_out);
      $finish;
    end
   else begin
      $display("At time %0d ctrl_sel=%b, data_out=%b",
               $time, ctrl_sel, data_out);
   end 
  endtask
  
	initial begin
		// Initialize 32 Inputs with repetition of 2'b00, 2'b01, 2'b10, 2'b11
		for( i=0; i<32; i = i+1)
		begin
			data_in[i*2+:2] = i%4;
		end

		// Check if mux produces expected output 
		// for each of the 32 select signal values
		for( i=0; i<32; i = i+1)
		begin
			ctrl_sel = i;
			#10 expect(i%4);
		end
		$display("TEST PASSED");
		$finish;		
	end
      
endmodule

