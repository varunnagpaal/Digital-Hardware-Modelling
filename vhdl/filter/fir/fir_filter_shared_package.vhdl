library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_unsigned.all;

package fir_filter_shared_package is
    
    -- modifiable constants
    constant FIR_ORDER		: natural := 3; 	                                	-- order of the filter (N). Note L = N+1 = taps
    constant X_BIT_SIZE  	: natural := 16;                                		-- bit width (n) of input samples (signed 2's complement)
    constant H_BIT_SIZE  	: natural := 16;                                		-- bit width (m) of coefficients (signed 2's complement)

    -- non-modifiable constants
    constant MULT_BIT_SIZE  : natural := X_BIT_SIZE+H_BIT_SIZE;             		-- bit width (n+m) of signed multiplier
    constant EXTR_BIT_SIZE 	: natural := natural(ceil(log2(real(FIR_ORDER+1))))-1;  -- extra bits for accumulation = ceil(log2(L))-1
    constant Y_BIT_SIZE  	: natural := MULT_BIT_SIZE+EXTR_BIT_SIZE;       		-- bit width of output samples (signed 2's complement) or signed adder

    -- N = no. of register delays or additions
    subtype ADD_REG_TYPE is signed(Y_BIT_SIZE-1 downto 0);
    type ADD_REG_ARRAY is array (0 to FIR_ORDER) of ADD_REG_TYPE;

    -- L = N+1 no. of taps or coefficients or multiplications
    subtype MULT_SIG_TYPE is signed(MULT_BIT_SIZE-1 downto 0);
    type MULT_SIG_ARRAY is array (0 to FIR_ORDER) of MULT_SIG_TYPE;
    subtype COEFF_REG_TYPE is signed(H_BIT_SIZE-1 downto 0);
    type COEFF_REG_ARRAY is array (0 to FIR_ORDER) of COEFF_REG_TYPE;    

end fir_filter_shared_package;

package body fir_filter_shared_package is
    -- empty
end fir_filter_shared_package;