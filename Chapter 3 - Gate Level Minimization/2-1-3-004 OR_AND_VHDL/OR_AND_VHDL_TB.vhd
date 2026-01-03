library ieee;
use ieee.std_logic_1164.all;

entity OR_AND_VHDL_TB is
end OR_AND_VHDL_TB;

architecture behavior of OR_AND_VHDL_TB is

    -- Component declaration
    component OR_AND_VHDL
        port(
            A, B, C : in  std_logic;
            E       : out std_logic
        );
    end component;

    -- Testbench signals
    signal A_tb : std_logic := '0';
    signal B_tb : std_logic := '0';
    signal C_tb : std_logic := '0';
    signal E_tb : std_logic;

begin

    -- Instantiate the DUT (Device Under Test)
    DUT : OR_AND_VHDL
        port map(
            A => A_tb,
            B => B_tb,
            C => C_tb,
            E => E_tb
        );

    -- Stimulus process
    stim_proc : process
    begin
        -- A B C = 000
        A_tb <= '0'; B_tb <= '0'; C_tb <= '0';
        wait for 10 ns;

        -- 001
        A_tb <= '0'; B_tb <= '0'; C_tb <= '1';
        wait for 10 ns;

        -- 010
        A_tb <= '0'; B_tb <= '1'; C_tb <= '0';
        wait for 10 ns;

        -- 011
        A_tb <= '0'; B_tb <= '1'; C_tb <= '1';
        wait for 10 ns;

        -- 100
        A_tb <= '1'; B_tb <= '0'; C_tb <= '0';
        wait for 10 ns;

        -- 101
        A_tb <= '1'; B_tb <= '0'; C_tb <= '1';
        wait for 10 ns;

        -- 110
        A_tb <= '1'; B_tb <= '1'; C_tb <= '0';
        wait for 10 ns;

        -- 111
        A_tb <= '1'; B_tb <= '1'; C_tb <= '1';
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end behavior;
