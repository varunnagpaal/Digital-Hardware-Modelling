module register_timing
	#( parameter WIDTH = 8,
	   parameter SETUP_TIME = 1.09ns,
	   parameter HOLD_TIME = 0.60ns,
	   parameter PROP_DELAY = 0.92ns
	)
	(
	  input logic CLK_CI;
	  input logic RST_RB;
	  input logic [WIDTH-1:0] Data_DI;
	  output logic [WIDTH-1:0] Qd_DO
	);

	logic [WIDTH-1:0] data_D;

	// Verify setup and hold time requirements for DQ-FF bistable
	specify
		$setup ( Data_DI, posedge CLK_CI, SETUP_TIME ); // data event, clock event, time constraint
		$hold  ( posedge CLK_CI, Data_DI, HOLD_TIME ); 	// clock event, data event, time constraint
	endspecify

	always_ff @(posedge CLK_CI or negedge RST_RB) begin : proc_q
		i'f(~RST_RB) begin
			data_D <= '0;
		end else begin
			data_D <= Data_DI;
		end
	end

	assign #PROP_DELAY Qd_DO = data_D;

endmodule // register_timing

