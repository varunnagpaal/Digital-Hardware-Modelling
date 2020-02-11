module dff_async_rst (input wire clk,
                      input wire rst,
                      input wire d,
                      output reg q );

  // active high async  reset
  always @ ( posedge clk, posedge rst ) begin
    if (rst)  q <= 1'b0;
    else      q <= d;
  end
endmodule //dff_async_rst
