library ieee;
use ieee.std_logic_1164.all;

entity Prob5_52_vhdl_tb is
end Prob5_52_vhdl_tb;

architecture Behavioral of Prob5_52_vhdl_tb is

    signal t_x_in   : std_logic := '0';
    signal t_clk    : std_logic := '0';
    signal t_reset_b : std_logic := '0';
    signal t_y_out  : std_logic;

begin

    UUT : entity work.Prob5_52_vhdl
        port map (
            x_in    => t_x_in,
            clk     => t_clk,
            reset_b => t_reset_b,
            y_out   => t_y_out
        );

    -- Clock Generation
    process
    begin
        while now < 160 ns loop
            t_clk <= '0';
            wait for 5 ns;

            t_clk <= '1';
            wait for 5 ns;
        end loop;

        wait;
    end process;

    -- Input and Reset Stimulus
    process
    begin

        -- Initial Reset
        t_reset_b <= '0';
        t_x_in <= '0';
        wait for 12 ns;

        -- Release Reset
        t_reset_b <= '1';

        -- S0 -> S1
        t_x_in <= '1';
        wait for 10 ns;

        -- S1 -> S2
        t_x_in <= '1';
        wait for 10 ns;

        -- S2, x_in = 0 -> stay S2, y_out = 1
        t_x_in <= '0';
        wait for 20 ns;

        -- S2 -> S3
        t_x_in <= '1';
        wait for 10 ns;

        -- S3, x_in = 0 -> stay S3, y_out = 1
        t_x_in <= '0';
        wait for 20 ns;

        -- S3 -> S0
        t_x_in <= '1';
        wait for 10 ns;

        -- S0 -> S1
        t_x_in <= '1';
        wait for 10 ns;

        -- S1 -> S1
        t_x_in <= '0';
        wait for 20 ns;

        -- Reset during operation
        t_reset_b <= '0';
        wait for 10 ns;

        -- Release Reset
        t_reset_b <= '1';
        t_x_in <= '0';

        wait for 28 ns;

        wait;
    end process;

end Behavioral;
