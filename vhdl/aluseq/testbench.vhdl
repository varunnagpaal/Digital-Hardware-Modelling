library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Testbench is
  generic( W : natural := 4;
           CLK_CYCLE_TIME : time := 100 ns;
           CLK_HIGH_TIME : time := 50 ns;
           CLK_LOW_TIME : time := 50 ns );
end Testbench;

architecture test of testbench is

  signal clk        : std_logic                       := '0';
  signal rst        : std_logic                       := '1';
  signal data_a     : std_logic_vector(W-1 downto 0)  := (others => '0');   -- input data A
  signal data_b     : std_logic_vector(W-1 downto 0)  := (others => '0');   -- input data B
  signal data_cin   : std_logic                       := '0';               -- carry in or borrow in
  signal ctrl       : std_logic_vector(3 downto 0)    := (others => '0');   -- control signals
  signal data_c     : std_logic_vector(W-1 downto 0)  := (others => '0');   -- output data C
  signal data_cout  : std_logic                       := '0';               -- carry out or borrow out
  signal data_comp  : std_logic_vector(1 downto 0)    := (others => '0');   -- output comparison
  signal valid      : std_logic                       := '0';               -- output valid

begin

  -- create instance of ALU (DUT)
  DUT_ALU: entity work.top(rtl)
       generic map( W => W )
       port map ( clk           => clk,
                  rst           => rst,
                  i_data_a      => data_a,
                  i_data_b      => data_b,
                  i_data_carry  => data_cin,
                  i_ctrl        => ctrl,
                  o_data_c      => data_c,
                  o_data_carry  => data_cout,
                  o_data_comp   => data_comp,
                  o_valid       => valid
                );

  -- Clock generation
  clk_gen: process
  begin
    clk <= '0';
    wait for CLK_LOW_TIME;
    clk <= '1';
    wait for CLK_HIGH_TIME;
  end process clk_gen;

  -- Reset generation
  rst <= '1',
         '0' after 2*CLK_CYCLE_TIME;
             
  -- test vectors
  stimulus : process
  begin
    -- Initialize all to 0 
    data_a <= x"0";
    data_b <= x"0";
    data_cin <= '0';
    ctrl <= ( others => '0' ); -- NOP0
    wait for 2 * CLK_CYCLE_TIME;

    -- test stimulus 1: NOP
    data_a <= x"A";
    data_b <= x"2";
    ctrl <= ( others => '1' ); -- NOPF
    wait for CLK_CYCLE_TIME;

    -- test stimulus 2: {sum, cout} = a+b+cin
    data_a <= x"2";
    data_b <= x"C";
    data_cin <= '1';
    ctrl <= "0001";
    wait for CLK_CYCLE_TIME;

    -- test stimulus 3 : {diff, cout} = a-b-bin
    data_a <= x"F";
    data_b <= x"C";
    data_cin <= '1';
    ctrl <= "0010";
    wait for CLK_CYCLE_TIME;

    -- test stimulus 4: A > B
    data_a <= x"B";
    data_b <= x"F";
    ctrl <= "0011";
    wait for CLK_CYCLE_TIME;    

    -- test stimulus 5: A < B
    data_a <= x"A";
    data_b <= x"E";
    ctrl <= "0100";
    wait for CLK_CYCLE_TIME;

    -- test stimulus 6 : A == B
    data_a <= x"D";
    data_b <= x"D";
    ctrl <= "0101";
    wait for CLK_CYCLE_TIME;

    -- test stimulus 7: right shift
    data_a <= x"F";
    data_b <= x"2";
    ctrl <= "0110";
    wait for CLK_CYCLE_TIME;

    -- test stimulus 8: left shift
    data_a <= x"9";
    data_b <= x"1";
    ctrl <= "0111";
    wait for CLK_CYCLE_TIME;
  end process stimulus;
end architecture test;