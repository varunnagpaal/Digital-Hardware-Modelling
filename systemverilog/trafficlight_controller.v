module trafficlight_controller (input wire clk,
                                input wire rst,
                                output reg light1_green,
                                output reg light1_red,
                                output reg light1_yellow,
                                output reg light2_green,
                                output reg light2_red,
                                output reg light2_yellow);


  reg [1:0] current_state;
  reg [1:0] next_state;
  reg [15:0] counter_value;

  localparam F100HZ_DELAY_60SEC_CC_CNT = 16'd6000;
  localparam F100HZ_DELAY_5SEC_CC_CNT = 16'd500;

  localparam  STATE_GR = 2'b00;
  localparam  STATE_YR = 2'b01;
  localparam  STATE_RG = 2'b10;
  localparam  STATE_RY = 2'b11;

  // Current state s(k) = delay[s(k+1)], where s(k+1) = next state
  always @ ( posedge clk, posedge rst ) begin
    if( rst )
      begin
        current_state <= STATE_GR;
      end
    else
      begin
        current_state <= next_state;
      end
  end

  // Counter for time delays
  always @ (  posedge clk, posedge rst ) begin
  if( rst )
    begin
      counter_value <= 16'b0;
    end
  else
    begin
      case (current_state)
        STATE_GR, STATE_RG:
          // Wait for 60 sec
          if( counter_value < F100HZ_DELAY_60SEC_CC_CNT )
            counter_value <= counter_value + 1'b1;
          else
            counter_value <= 16'b0;

        STATE_YR, STATE_RY:
          // Wait for 5 sec
          if( counter_value < F100HZ_DELAY_5SEC_CC_CNT )
            counter_value <= counter_value + 1'b1;
          else
            counter_value <= 16'b0;
      endcase
    end
  end

  // Next State function: s(k+1) = f[i(k), s(k)]
  always @ ( * ) begin
    case (current_state)
      STATE_GR:
        // Wait for 60 sec
        if( counter_value < F100HZ_DELAY_60SEC_CC_CNT )
          next_state <= STATE_GR;
        else
          next_state <= STATE_YR;

      STATE_YR:
        // Wait for 5 sec
        if( counter_value < F100HZ_DELAY_5SEC_CC_CNT )
          next_state <= STATE_YR;
        else
          next_state <= STATE_RG;

      STATE_RG:
        // Wait for 60 sec
        if( counter_value < F100HZ_DELAY_60SEC_CC_CNT )
          next_state <= STATE_RG;
        else
          next_state <= STATE_RY;

      STATE_RY:
        // Wait for 5 sec
        if( counter_value < F100HZ_DELAY_5SEC_CC_CNT )
          next_state <= STATE_RY;
        else
          next_state <= STATE_GR;

      default:
        next_state <= STATE_GR;
    endcase
  end

  // Output function : o(k) = g[s(k)]
  always @ ( * ) begin
    // default all lights OFF
    light1_green  <= 1'b0;
    light1_red    <= 1'b0;
    light1_yellow <= 1'b0;
    light2_green  <= 1'b0;
    light2_red    <= 1'b0;
    light2_yellow <= 1'b0;

    case (current_state)
      STATE_GR:
        begin
          light1_green <= 1'b1;
          light2_red   <= 1'b1;
        end

      STATE_YR:
        begin
          light1_yellow <= 1'b1;
          light2_red <= 1'b1;
        end

      STATE_RG:
        begin
          light1_red <= 1'b1;
          light2_green <=1'b1;
        end

      STATE_RY:
        begin
          light1_red <= 1'b1;
          light2_yellow <= 1'b1;
        end

      default:
        begin
          light1_green  <= 1'b1;
          light1_red    <= 1'b1;
          light1_yellow <= 1'b1;
          light2_green  <= 1'b1;
          light2_red    <= 1'b1;
          light2_yellow <= 1'b1;
        end
    endcase
  end


endmodule //
