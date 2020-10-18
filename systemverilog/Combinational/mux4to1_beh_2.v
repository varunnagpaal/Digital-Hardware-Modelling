module mux4to1_beh_2
( input wire [3:0] data_in,
  input wire [1:0] ctrl_sel,
  output reg data_out );

  always @ ( * )
  begin
    case(ctrl_sel)
      2'b00: data_out = data_in[0];
      2'b01: data_out = data_in[1];
      2'b10: data_out = data_in[2];
      2'b11: data_out = data_in[3];
    endcase
  end
endmodule //mux4to1_beh_2
