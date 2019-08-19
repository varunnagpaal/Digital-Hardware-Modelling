module alu
#(parameter WIDTH = 8)
( input wire [WIDTH-1:0] in_a,
  input wire [WIDTH-1:0] in_b,
  input wire [2:0] opcode,
  output wire [WIDTH-1:0] alu_out,
  output wire a_is_zero );

  reg reg_alu_out [WIDTH-1:0];

  assign a_is_zero = in_a ? 1'b0: 1'b1;

  always @ ( * )
  begin
      if ( opcode == 3'b000 )
        begin
          reg_alu_out = in_a;
        end
      else if ( opcode == 3'b001 )
        begin
          reg_alu_out = in_a;
        end
      else if ( opcode == 3'b010 )
        begin
          reg_alu_out = in_a + in_b;
        end
      else if ( opcode == 3'b011 )
        begin
          reg_alu_out = in_a & in_b;
        end
      else if ( opcode == 3'b100 )
        begin
          reg_alu_out = in_a ^ in_b;
        end
      else if ( opcode == 3'b101 )
        begin
          reg_alu_out = in_b;
        end
      else if ( opcode == 3'b110 )
        begin
          reg_alu_out = in_a;
        end
      else if ( opcode == 3'b111 )
        begin
          reg_alu_out = in_a;
        end
      else
        begin
          reg_alu_out = in_a;
        end
  end
endmodule alu
