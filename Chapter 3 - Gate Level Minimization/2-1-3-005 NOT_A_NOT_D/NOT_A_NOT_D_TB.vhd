library ieee;
use ieee.std_logic_1164.all;

entity NOT_A_NOT_D_tb is
end NOT_A_NOT_D_tb;

architecture tb of NOT_A_NOT_D_tb is

    -- DUT I/O signals
    signal A : std_logic := '0';
    signal B : std_logic := '0';
    signal C : std_logic := '0';
    signal F : std_logic;

begin

    -- DUT instantiation
    DUT : entity work.NOT_A_NOT_D
        port map (
            A => A,
            B => B,
            C => C,
            F => F
        );

    -- Stimulus process
    stim_proc : process
    begin
        -- ABC = 000
        A <= '0'; B <= '0'; C <= '0';
        wait for 10 ns;

        -- ABC = 001
        A <= '0'; B <= '0'; C <= '1';
        wait for 10 ns;

        -- ABC = 010
        A <= '0'; B <= '1'; C <= '0';
        wait for 10 ns;

        -- ABC = 011
        A <= '0'; B <= '1'; C <= '1';
        wait for 10 ns;

        -- ABC = 100
        A <= '1'; B <= '0'; C <= '0';
        wait for 10 ns;

        -- ABC = 101
        A <= '1'; B <= '0'; C <= '1';
        wait for 10 ns;

        -- ABC = 110
        A <= '1'; B <= '1'; C <= '0';
        wait for 10 ns;

        -- ABC = 111
        A <= '1'; B <= '1'; C <= '1';
        wait for 10 ns;

        -- Stop simulation
        wait;
    end process;

end tb;
