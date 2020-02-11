module mux4to1_beh_1
( input wire [3:0] data_in,
  input wire [1:0] ctrl_sel,
  output reg data_out );

  always @ ( * )
  begin
    data_out = data_in[ctrl_sel];
  end
endmodule //mux4to1_beh_1
