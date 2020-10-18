///////////////////////////////////////////////////////////////////////////////
// Module Name  : register
// File name    : register.sv
// Description  : n-bit register with async reset, synch load and enable
// Type         : Sequential
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 25/11/2016
///////////////////////////////////////////////////////////////////////////////

module register
    #( parameter WIDTH = 8 )
    ( input     logic             clk, rst_n, ld_s, en_s;
      input     logic [WIDTH-1:0] inp;
      input     logic [WIDTH-1:0] inp_ld_s;
      output    logic [WIDTH-1:0] oup
    );

    always_ff @(posedge clk, negedge rst_n)
    begin
        if( ~rst_n )
            oup <= '0;  // shortcut for all bits as 0's
        else
            if( ld_s )
                oup <= inp_ld_s;
            else if( en_s )
                oup <= inp;
    end

endmodule