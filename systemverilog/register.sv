///////////////////////////////////////////////////////////////////////////////
// Module Name  : register
// File name    : register.sv
// Description  : 8-bit register with async reset, synch load and enable
// Type         : Sequential
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
///////////////////////////////////////////////////////////////////////////////

module register( input logic clk, rst_n, ld_s, en_s;
                 input logic [7:0] inp;
                 output logic [7:0] oup );

    always_ff @(posedge clk, negedge rst_n)
    begin
        if( ~rst_n )
            oup <= '0;  // shortcut for all bits as 0's
        else
            if( ld_s )
                oup <= '1;
            else if(en_s)
                oup <= inp;
    end

endmodule
