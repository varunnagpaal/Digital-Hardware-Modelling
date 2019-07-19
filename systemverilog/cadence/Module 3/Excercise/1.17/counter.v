module counter
#(
  parameter integer WIDTH=5
 )
 (
  input  wire clk  ,
  input  wire rst  ,
  input  wire load ,
  input  wire enab ,
  input  wire [WIDTH-1:0] cnt_in ,
  output reg  [WIDTH-1:0] cnt_out 
 );

  reg [WIDTH-1:0] cnt_tmp;

  always @*
    if ( rst  ) cnt_tmp = 0; else
    if ( load ) cnt_tmp = cnt_in; else
    if ( enab ) cnt_tmp = cnt_out + 1; else
                cnt_tmp = cnt_out;

  always @(posedge clk)
    cnt_out <= cnt_tmp;

endmodule
