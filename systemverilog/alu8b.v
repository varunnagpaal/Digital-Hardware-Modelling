module alu8b (input wire [7:0] A_in,
              input wire [7:0] B_in,
              input wire       C_in,
              input wire [2:0] Opcode_in,
              output wire [7:0] Result_out,
              output wire       C_out);

  reg [7:0] reg_result;
  reg reg_cout;
  wire [7:0] temp_sum;
  wire temp_cout;

  assign Result_out = reg_result;
  assign C_out = reg_cout;

  assign {temp_cout, temp_sum} = A_in + B_in + C_in;

  always @ ( * ) begin
  reg_cout = 1'b0;  //default carry out
    case (Opcode_in)
      3'b000: // A+B+Cin
              begin
                reg_cout = temp_cout;
                reg_result = temp_sum;
              end
      3'b001: // A-B
              reg_result =  A_in - B_in;
      3'b010: // A & B
              reg_result = A_in & B_in;
      3'b011: // A|B
              reg_result = A_in | B_in;
      3'b100: // A % B
              reg_result = A_in % B_in;
      default:
              reg_result = 8'b0;
    endcase
  end
endmodule // alu8b
