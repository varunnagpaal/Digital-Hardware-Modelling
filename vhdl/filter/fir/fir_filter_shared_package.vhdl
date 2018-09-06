library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package fir_filter_shared_package is
    
    -- modifiable constants
    constant N          : natural := 3;                                 -- order of the filter (N). Note L = N+1 = taps
    constant N_BITS     : natural := 16;                                -- bit width (n) of input samples (signed 2's complement)
    constant M_BITS     : natural := 16;                                -- bit width (m) of coefficients (signed 2's complement)

    -- non-modifiable constants
    constant MULT_BITS  : natural := N_BITS+M_BITS;                     -- bit width (n+m) of signed multiplier
    constant EXTRA_BITS : natural := natural(ceil(log2(real(N+1))))-1;  -- extra bits for accumulation = ceil(log2(L))-1
    constant Y_BITS     : natural := MULT_BITS+EXTRA_BITS;            	-- bit width of signed adder or output sample

end fir_filter_shared_package;

package body fir_filter_shared_package is
    -- empty
end fir_filter_shared_package;