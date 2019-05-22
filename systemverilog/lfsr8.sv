////////////////////////////////////////////////////////////////////////////////
// Module Name  : Linear Feedback Shift Register (LFSR)
// File name    : lfsr8.sv
// Description  : 8-bit LFSR(right shift) based on polynomial: x^8+x^6+x^5+x^4+1
// Type         : Combinational/Sequential
// Model Style  : behavioral, dataflow
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
////////////////////////////////////////////////////////////////////////////////

module lfsr8( input logic Clk_CI;
              input logic Rst_RBI;        // Async active low reset
              input logic Load_SI;        // Sync load
              input logic Ena_SI;         // Sync Enable
              input logic [7:0] Seed_DI;  // Initial seed value (loadable)
             output logic Oup_DO );

//-------------------------------Start Architecture---------------------------//
    // State variables (inter-process)
    logic [7:0] State_DN, State_DP;


//-----------------------------------Start Body-------------------------------//
    // Get next state by calculating MSB using an lfsr function on current state
    // and setting rest of bits to same as present state bit values
    // x^8+x^6+x^5+x^4+1 (for index range 1-8 L to R)
    // as our indexes range is 7:0 in reverse, therefore
    // 8 => 0th bit, 6 => 2nd bit, 5 => 3rd bit, 4 => 4th bit
    assign State_DN[7:0] = {( State_DP[4] ^ State_DP[3] ^ State_DP[2] ^ State_DP[0] ),
                              State_DP[7:1] };

    always_ff @( posedge Clk_CI, negedge Rst_RBI )
    begin
        if( ~Rst_RBI )
            // On reset, load a valid seed
            State_DP[7:0] <= 8'b00000001;
        else
            if( Load_SI )
                // Load user supplied seed
                State_DP[7:0] <= Seed_DI[7:0];
            else if( Ena_SI )
                // Assign next state as current state
                State_DP[7:0] <= State_DN[7:0];
    end

    // Update Output of LFSR
    assign Oup_DO = State_DP[0];
//------------------------------------End Body--------------------------------//

//--------------------------------End Architecture----------------------------//
endmodule