module driver
  #(parameter WIDTH = 8)
  ( input wire data_in [WIDTH-1:0],
    input wire data_en,
    output wire data_out [WIDTH-1:0]
  );

  assign data_out = data_en ? data_out:WIDTH'bz;

endmodule
