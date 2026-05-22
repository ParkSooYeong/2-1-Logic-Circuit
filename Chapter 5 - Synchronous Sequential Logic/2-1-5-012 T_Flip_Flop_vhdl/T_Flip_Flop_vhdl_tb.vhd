library ieee;
use ieee.std_logic_1164.all;

entity T_Flip_Flop_vhdl_tb is
end T_Flip_Flop_vhdl_tb;

architecture testbench of T_Flip_Flop_vhdl_tb is

    signal T   : std_logic := '0';
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal Q   : std_logic;

begin

    -- DUT
    uut : entity work.T_Flip_Flop_vhdl
        port map (
            T   => T,
            clk => clk,
            rst => rst,
            Q   => Q
        );

    -- Clock generation
    clk_process : process
    begin
        while now < 160 ns loop
            clk <= '0';
            wait for 5 ns;

            clk <= '1';
            wait for 5 ns;
        end loop;

        wait;
    end process;

    -- Stimulus
    stim_process : process
    begin

        -- Reset
        rst <= '1';
        T <= '0';
        wait for 10 ns;

        -- Release reset
        rst <= '0';
        wait for 20 ns;

        -- Toggle mode
        T <= '1';
        wait for 40 ns;

        -- Hold mode
        T <= '0';
        wait for 30 ns;

        -- Toggle again
        T <= '1';
        wait for 40 ns;

        -- Reset test
        rst <= '1';
        wait for 10 ns;

        rst <= '0';
        wait for 10 ns;

        wait;

    end process;

end testbench;
