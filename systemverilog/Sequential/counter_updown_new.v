module counter_updown (input wire          clk_in,
                       input wire          preset_in,      // synchronous preset
                       input wire          rst_in,         // synchronous reset
                       input wire          updown_in,
                       output reg [9:0]    count_out);

  always @ (posedge clk_in)
  begin
    if ( rst_in  == 1'b1 ) begin
      count_out <= 10'd0;
    end else if ( preset_in == 1'b1 ) begin
      count_out <= 10'd253;
    end else if ( clk_in == 1'b1 )  begin
        if( updown_in == 1'b1 ) begin
          count_out <= count_out + 1;
        end else begin
          count_out <= count_out - 1;
        end
    end
  end
endmodule
