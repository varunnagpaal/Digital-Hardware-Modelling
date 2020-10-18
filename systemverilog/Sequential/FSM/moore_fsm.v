module moore_fsm ( input wire clk,
                   input wire rst,
                   input wire i_input,
                   output reg o_output,
                   output wire [2:0] o_current_state,
                   output wire [2:0] o_next_state
                  );

  reg [2:0] current_state;
  reg [2:0] next_state;

  // Input value enumerations (constants)
  localparam  i_val_a = 1'b0;
  localparam  i_val_b = 1'b1;

  // State assignment (constants)
  localparam  STATE_U = 3'b000;
  localparam  STATE_V = 3'b001;
  localparam  STATE_W = 3'b010;
  localparam  STATE_X = 3'b011;
  localparam  STATE_Y = 3'b100;
  localparam  STATE_Z = 3'b101;

  // Current state s(k) = delay[s(k+1)], where s(k+1) = next state
  always @ ( posedge clk, posedge rst ) begin
    if ( rst == 1'b1 ) begin
      current_state <= 3'b0;
    end else if ( clk == 1'b1) begin
      current_state <= next_state;
    end
  end

  assign o_current_state = current_state;
  assign o_next_state = next_state;

  // Next state s(k+1) = f[i(k), s(k)], where i(k) = current input, s(k) = current state, k = current clock cycle
  always @ ( * ) begin
    case (current_state)
      STATE_U: begin
        if (i_input == i_val_a) begin
          next_state = STATE_Z;
        end else if (i_input == i_val_b) begin
          next_state = STATE_W;
        end
      end

      STATE_V: begin
        if (i_input == i_val_a) begin
          next_state = STATE_Z;
        end else if (i_input == i_val_b) begin
          next_state = STATE_W;
        end
      end

      STATE_W: begin
        if (i_input == i_val_a) begin
          next_state = STATE_X;
        end else if (i_input == i_val_b) begin
          next_state = STATE_U;
        end
      end

      STATE_X: begin
        if (i_input == i_val_a) begin
          next_state = STATE_Y;
        end else if (i_input == i_val_b) begin
          next_state = STATE_X;
        end
      end

      STATE_Y: begin
        if (i_input == i_val_a) begin
          next_state = STATE_V;
        end else if (i_input == i_val_b) begin
          next_state = STATE_Y;
        end
      end

      STATE_Z: begin
        if (i_input == i_val_a) begin
          next_state = STATE_Y;
        end else if (i_input == i_val_b) begin
          next_state = STATE_X;
        end
      end

      default: begin
        // unreachable states. go back to proper state
        next_state = STATE_U;
      end

    endcase
  end

  // Current output O(k) = g[s(k)], where s(k) = current state, k = current clock cycle
  always @ ( * ) begin
    case (current_state)
      STATE_U:  begin
        o_output = 1'b1;
      end

      STATE_V:  begin
        o_output = 1'b0;
      end

      STATE_W:  begin
        o_output = 1'b0;
      end

      STATE_X:  begin
        o_output = 1'b0;
      end

      STATE_Y:  begin
        o_output = 1'b1;
      end

      STATE_Z:  begin
        o_output = 1'b1;
      end

      default:   begin
        // unreachable states
        o_output = 1'b0;
      end
    endcase
  end
endmodule //moore_fsm
