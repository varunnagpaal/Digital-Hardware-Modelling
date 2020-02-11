///////////////////////////////////////////////////////////////////////////////
// Module Name  : mux_32to1_2b
// File name    : mux_32to1_2b.v
// Description  : Instantiates a 2^5=32:1 Multiplexer with 2-bit data bus width
// Type         : Combinational
// Model Style  : behavioral
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 09/09/2019
///////////////////////////////////////////////////////////////////////////////
module mux_32to1_2b( input wire [63:0] data_in,
						input wire [4:0] ctrl_sel,
						output wire [1:0] data_out );

  mux_generic #(.BUS_WIDTH(2), .SEL(5)) mux_32to1_2b_inst(.data_in(data_in),
														  .ctrl_sel(ctrl_sel),
														  .data_out(data_out));
endmodule // mux_generic_top
