-- Author: Varun Nagpal
-- Net Id: vxn180010
-- VLSI Design Homework 1
-- 3rd Sept, 2018
--
-- Design: Generic Nth order (N+1 taps) Transposed FIR-filter 
-- IN:
--      n-bit sized Input samples
--      m-Bit sized coefficients
-- OUT:
--      n-bit size of output samples. Note: (n+m+N) bit size is that accumulator which is finally quantized to n-bit size to produce output
-- It has maximum:
--      N register delays or N+1 taps
--      N+1 Multiplications
--      N additions



library ieee;
use ieee.std_logic_1164.all;

-- Top level module
entity fir_generic_transposed_filter is
    generic (
            FIR_ORDER: natural := 4;                                -- order of the filter
            XBIT_SIZE: natural := 8;                                -- bit width of input samples
            HBIT_SIZE: natural := 8;                                -- bit width of coefficients
            ACUM_SIZE: natural := XBIT_SIZE+HBIT_SIZE+FIR_ORDER;    -- bit width of accumulator  register
            YBIT_SIZE: natural := XBIT_SIZE;                        -- bit width of output samples
        );

    port (
        -- Clock and reset
        clk        : in  std_logic;
        rst        : in  std_logic;
        
        -- Sink handshaking interface
        valid_in   : in  std_logic;                                 -- Valid input when acting as sink  
        ready_out  : out std_logic;                                 -- Ready output when acting as sink

        -- Source Handshaking interface
        valid_out  : out std_logic;                                 -- Valid output when acting as source
        ready_in   : in  std_logic;                                 -- Ready input when acting as source

        --  Input samples & coefficients and Output samples
        x_data_in  : in  std_logic_vector(XBIT_SIZE-1 downto 0);    -- Input samples
        h_data_in  : in  std_logic_vector(HBIT_SIZE-1 downto 0);    -- Coefficients of filter
        y_data_out : out std_logic_vector(YBIT_SIZE-1 downto 0)     -- Output samples
    );
end fir_generic_transposed_filter;

architecture fir_rtl_arch of fir_generic_transposed_filter is
begin

end fir_rtl_arch;