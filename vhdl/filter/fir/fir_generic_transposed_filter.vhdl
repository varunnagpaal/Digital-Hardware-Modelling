-- Author: Varun Nagpal
-- Net Id: vxn180010
-- VLSI Design Homework 1
-- 3rd Sept, 2018
--
-- Design: Generic Nth order (N+1 taps) Transposed FIR-filter 
-- IN:
--		n-bit sized Input samples
--		m-Bit sized coefficients
-- OUT:
--		n-bit size of output samples. Note: (n+m+N) bit size is that accumulator which is finally quantized to n-bit size to produce output
-- It has maximum:
--		N register delays or N+1 taps
--		N+1 Multiplications
--		N additions



library ieee;
use ieee.std_logic_1164.all;

-- Top level module
entity fir_generic_transposed_filter is
	generic (
			FIR_ORDER: natural := 4;
			XBIT_SIZE: natural := 8;	-- 
			HBIT_SIZE: natural := 8;
			ACUM_SIZE: natural := XBIT_SIZE+HBIT_SIZE+FIR_ORDER; 	-- this is size of accumulator register
			YBIT_SIZE: natural := XBIT_SIZE; 						-- size of out
		);

	port (
		clk: in std_logic;
		rst: in std_logic;
		x_data: in std_logic_vector(XBIT_SIZE-1 downto 0);	-- Input samples
		h_data: in std_logic_vector(HBIT_SIZE-1 downto 0);	-- Coefficients of filter
		y_data: out std_logic_vector(YBIT_SIZE-1 downto 0)	-- Output samples
	);
end fir_generic_transposed_filter;

architecture fir_rtl_arch of fir_generic_transposed_filter is
begin

end fir_rtl_arch;