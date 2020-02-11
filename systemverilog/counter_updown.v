module counter_updown (input wire          clk_in,
                       input wire          rst_in,
                       input wire          sync_load_in,
                       input wire          updown_in,
                       input wire [11:0]   count_in,
                       output reg [11:0]   count_out);

always @ (posedge clk_in, posedge rst_in)
begin
  if ( rst_in  == 1'b1 )
    begin
      count_out <= 12'd0;
    end
  else if ( clk_in == 1'b1 )
    begin
      if( sync_load_in == 1'b1 )
        begin
          count_out <= count_in;
        end
      else
        begin
          if( updown_in == 1'b1 )
            begin
              count_out <= count_out + 1;
            end
          else
            begin
              count_out <= count_out - 1;
            end
        end
    end
end

endmodule
