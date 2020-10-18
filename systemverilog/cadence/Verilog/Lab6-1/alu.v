module alu
#(parameter WIDTH = 8)
( input wire [WIDTH-1:0] in_a,
  input wire [WIDTH-1:0] in_b,
  input wire [2:0] opcode,
  output reg [WIDTH-1:0] alu_out,
  output wire a_is_zero );

  assign a_is_zero = in_a ? 1'b0: 1'b1;

  always @ ( * )
  begin
      if ( opcode == 3'b000 )
        begin
          alu_out = in_a;
        end
      else if ( opcode == 3'b001 )
        begin
          alu_out = in_a;
        end
      else if ( opcode == 3'b010 )
        begin
          alu_out = in_a + in_b;
        end
      else if ( opcode == 3'b011 )
        begin
          alu_out = in_a & in_b;
        end
      else if ( opcode == 3'b100 )
        begin
          alu_out = in_a ^ in_b;
        end
      else if ( opcode == 3'b101 )
        begin
          alu_out = in_b;
        end
      else if ( opcode == 3'b110 )
        begin
          alu_out = in_a;
        end
      else if ( opcode == 3'b111 )
        begin
          alu_out = in_a;
        end
      else
        begin
          alu_out = in_a;
        end
  end
endmodule // alu
