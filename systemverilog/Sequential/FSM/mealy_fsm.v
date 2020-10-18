module mealy_fsm ( input wire clk,
                   input wire rst,
                   input wire i_input,
                   output reg o_output,
                   output wire [1:0] o_current_state,
                   output wire [1:0] o_next_state
                  );

  reg [1:0] current_state;
  reg [1:0] next_state;

  // Input value enumerations (constants)
  localparam  i_val_a = 1'b0;
  localparam  i_val_b = 1'b1;

  // State assignment (constants)
  localparam  STATE_P = 2'b00;
  localparam  STATE_Q = 2'b01;
  localparam  STATE_R = 2'b10;
  localparam  STATE_T = 2'b11;

  // Current state s(k) = delay[s(k+1)], where s(k+1) = next state
  always @ ( posedge clk, posedge rst ) begin
    if ( rst == 1'b1 ) begin
      current_state <= 2'b0;
    end else if ( clk == 1'b1) begin
      current_state <= next_state;
    end
  end

  assign o_current_state = current_state;
  assign o_next_state = next_state;

  // Next state s(k+1) = f[i(k), s(k)], where i(k) = current input, s(k) = current state, k = current clock cycle
  always @ ( * ) begin
    case (current_state)
      STATE_P: begin
        if (i_input == i_val_a) begin
          next_state = STATE_R;
        end else if (i_input == i_val_b) begin
          next_state = STATE_T;
        end
      end

      STATE_Q: begin
        if (i_input == i_val_a) begin
          next_state = STATE_P;
        end else if (i_input == i_val_b) begin
          next_state = STATE_Q;
        end
      end

      STATE_R: begin
        if (i_input == i_val_a) begin
          next_state = STATE_Q;
        end else if (i_input == i_val_b) begin
          next_state = STATE_R;
        end
      end

      STATE_T: begin
        if (i_input == i_val_a) begin
          next_state = STATE_R;
        end else if (i_input == i_val_b) begin
          next_state = STATE_P;
        end
      end
    endcase
  end

  // Current output O(k) = g[i(k), s(k)], where i(k) = current input, s(k) = current state, k = current clock cycle
  always @ ( * ) begin
    case (current_state)
      STATE_P: begin
        if (i_input == i_val_a) begin
          o_output = 1'b1;
        end else if (i_input == i_val_b) begin
          o_output = 1'b0;
        end
      end

      STATE_Q: begin
        if (i_input == i_val_a) begin
          o_output = 1'b0;
        end else if (i_input == i_val_b) begin
          o_output = 1'b1;
        end
      end

      STATE_R: begin
        if (i_input == i_val_a) begin
          o_output = 1'b1;
        end else if (i_input == i_val_b) begin
          o_output = 1'b0;
        end
      end

      STATE_T: begin
        if (i_input == i_val_a) begin
          o_output = 1'b0;
        end else if (i_input == i_val_b) begin
          o_output = 1'b1;
        end
      end
    endcase
  end
endmodule //mealy_fsm
