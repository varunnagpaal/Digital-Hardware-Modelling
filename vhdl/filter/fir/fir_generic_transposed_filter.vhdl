-- Author: Varun Nagpal
-- Net Id: vxn180010
-- VLSI Design Homework 1
-- 3rd Sept, 2018
--
-- Design: Generic Nth order (L = N+1 taps) Transposed FIR-filter 
-- IN:
--      n-bit sized Input samples
--      m-Bit sized coefficients
-- OUT:
--      n+m+log2(N+1)-1 bit size of output samples
--
-- Operation requires:
--      N = no. of register delays or additions
--      L = N+1 no. of taps or coefficients or multiplications

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.fir_filter_shared_package.all;

-- Top level module
entity fir_generic_transposed_filter is
    generic (
            FIR_ORDER: natural := N;                               -- order of the filter (N). Note L = N+1 = taps
            XBIT_SIZE: natural := N_BITS;                          -- bit width (n) of input samples (signed 2's complement)
            HBIT_SIZE: natural := M_BITS;                          -- bit width (m) of coefficients (signed 2's complement)
            MULT_SIZE: natural := MULT_BITS;                       -- bit width (n+m) of signed multiplier
            EXTR_SIZE: natural := EXTRA_BITS;                      -- extra bits for accumulation = ceil(log2(L))-1
            YBIT_SIZE: natural := Y_BITS                           -- bit width of output samples (signed 2's complement) or signed adder
        );

    port (
        -- Clock and reset
        clk        : in  std_logic;
        rst        : in  std_logic;
        
        -- Handshaking interface as sink
        valid_x_in  : in  std_logic;                                 -- Valid input sample when acting as sink
        ready_x_out : out std_logic;                                 -- Ready for input samples when acting as sink
        valid_h_in  : in  std_logic;                                 -- Valid coefficient input when acting as sink
        ready_h_out : out std_logic;                                 -- Ready for coefficients when acting as sink

        -- Handshaking interface as source
        valid_out  : out std_logic;                                 -- Valid output when acting as source
        ready_in   : in  std_logic;                                 -- Ready input when acting as source

        --  Input samples & coefficients and Output samples
        x_data_in  : in  std_logic_vector(XBIT_SIZE-1 downto 0);    -- Input samples
        h_data_in  : in  std_logic_vector(HBIT_SIZE-1 downto 0);    -- Coefficients of filter
        y_data_out : out std_logic_vector(YBIT_SIZE-1 downto 0)     -- Output samples
    );
end fir_generic_transposed_filter;

architecture fir_rtl_arch of fir_generic_transposed_filter is
    --      N = no. of register delays or additions
    signal 
    --      L = N+1 no. of taps or coefficients or multiplications
begin
    process(clk, rst)
    begin
        if (rst = '1') then
            ready_out <= '0';
            valid_out <= '0';
        elsif (clk'EVENT  and clk = '1') then
            -- 
            if( ready_in = '1' and valid_in = '1') then

            end if;
        end if;
    end process;
end fir_rtl_arch;