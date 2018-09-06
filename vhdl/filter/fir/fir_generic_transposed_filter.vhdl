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
    -- N = no. of register delays or additions
    subtype ADD_REG_TYPE is std_logic_vector(YBIT_SIZE-1 downto 0);
    type ADD_REG_ARRAY is array (0 to FIR_ORDER-1) of ADD_REG_TYPE;

    -- L = N+1 no. of taps or coefficients or multiplications
    subtype MULT_SIG_TYPE is std_logic_vector(MULT_SIZE-1 downto 0);
    type MULT_SIG_ARRAY is array (0 to FIR_ORDER) of MULT_SIG_TYPE;
    subtype COEFF_REG_TYPE is std_logic_vector(HBIT_SIZE-1 downto 0);
    type COEFF_REG_ARRAY is array (0 to FIR_ORDER) of COEFF_REG_TYPE;

    signal adder_mem_array          : ADD_REG_ARRAY;                            -- array of N memory (registers) blocks to store adder outputs
    signal multiplier_sigs          : MULT_SIG_ARRAY;                           -- array of L = N+1 multipler signals
    signal coefficient_mem_array    : COEFF_REG_ARRAY;                          -- array of L = N+1 memory (registers) blocks to store coefficients
    signal coeff_cnt                : integer range 0 to FIR_ORDER;           -- counter for reading L = N+1 coefficients
    signal coeff_cnt_next           : integer range 0 to FIR_ORDER;
    
    signal input_sample_mem         : std_logic_vector(XBIT_SIZE-1 downto 0);   -- register to store input data sample
    signal output_sample_mem        : std_logic_vector(YBIT_SIZE-1 downto 0);   -- register to store output data sample

    signal ready_h_out_sig          : std_logic;
    signal ready_x_out_sig          : std_logic;
    signal valid_out_sig            : std_logic;
begin
    
    ready_x_out <= ready_x_out_sig;
    ready_h_out <= ready_h_out_sig;
    valid_out   <= valid_out_sig;

    read_coefficients: process(clk, rst)
    begin
        if (rst = '1') then
            ready_h_out_sig <= '1';
        elsif (clk'EVENT  and clk = '1') then
            if ( ready_h_out_sig = '1' and valid_h_in = '1' ) then
                -- while reading coefficients, deassert ready_x_out_sig
                -- once coefficients are read, deassert ready_h_out_sig and assert ready_x_out_sig to start reading samples
            end if;
        end if;
    end process read_coefficients;

    read_samples: process(clk, rst)
    begin
        if (rst = '1') then
            ready_x_out_sig <= '0';
        elsif (clk'EVENT  and clk = '1') then
            if ( ready_x_out_sig = '1' and valid_x_in = '1' ) then
                -- when reading samples, deassert ready_h_out_sig
            end if;
        end if;
    end process read_samples;

    --coeff_read_counter: process(clk, rst)
    --begin
    --    if ( rst = '1') then
    --        coeff_cnt <= 0;
    --    elsif (clk'EVENT and clk = '1') then
    --        if ( ready_h_out_sig = '1' and valid_h_in = '1' ) then
    --            if ( coeff_cnt = FIR_ORDER ) then
    --                coeff_cnt <= 0;
    --            else
    --                coeff_cnt <= coeff_cnt + 1;    
    --            end if;
    --        end if;
    --    end if;
    --end process coeff_read_counter;


   coeff_read_counter: process(clk, rst)
    begin
        if ( rst = '1') then
            coeff_cnt <= 0;
        elsif (clk'EVENT and clk = '1') then
            coeff_cnt <= coeff_cnt_next;    
        end if;
    end process coeff_read_counter;

    -- Next state logic
    coeff_cnt_next <= 0 when (coeff_cnt = FIR_ORDER) else 
                             coeff_cnt + 1;
end fir_rtl_arch;