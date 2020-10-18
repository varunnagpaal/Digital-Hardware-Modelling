///////////////////////////////////////////////////////////////////////////////
// Module Name  : mux_generic
// File name    : mux_generic.v
// Description  : 2^n:1 Multiplexer with configurable width of data i/o lines
// Type         : Combinational
// Model Style  : behavioral
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 09/09/2019
///////////////////////////////////////////////////////////////////////////////
module mux_generic
#(parameter BUS_WIDTH = 4,
  parameter SEL = 5 )
( input wire [(BUS_WIDTH * (2**SEL) )-1:0] data_in,	// Size of bus is 2^n x Bus_Width
  input wire [SEL-1:0] ctrl_sel,
  output reg [BUS_WIDTH-1:0] data_out );

  always @ ( * )
  begin
    data_out = data_in[ctrl_sel*BUS_WIDTH +: BUS_WIDTH];
  end
endmodule //mux_generic
