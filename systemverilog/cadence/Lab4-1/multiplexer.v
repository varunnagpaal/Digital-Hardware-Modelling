module multiplexor #(parameter WIDTH=5) ( input wire 				sel,
										                      input wire [WIDTH-1:0] 	in0,
										                      input wire [WIDTH-1:0] 	in1,
										                      output reg [WIDTH-1:0] 	mux_out	);

	always@(*)
	begin
			if( sel == 1'b1)
				mux_out = in1;  //  blocking assignment (=) using reg for combinational logic in always procedural block
			else
				mux_out = in0;  //  blocking assignment (=) using reg for combinational logic in always procedural block
	end
endmodule // multiplexor
