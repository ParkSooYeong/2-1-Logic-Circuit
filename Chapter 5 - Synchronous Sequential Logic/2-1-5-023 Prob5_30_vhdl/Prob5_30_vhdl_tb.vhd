library ieee;
use ieee.std_logic_1164.all;

entity Prob5_30_vhdl_tb is
end Prob5_30_vhdl_tb;

architecture Behavioral of Prob5_30_vhdl_tb is

    signal A   : std_logic := '0';
    signal B   : std_logic := '0';
    signal C   : std_logic := '0';
    signal clk : std_logic := '0';

    signal E   : std_logic;
    signal Q   : std_logic;

begin

    -- DUT
    DUT : entity work.Prob5_30_vhdl
        port map (
            A   => A,
            B   => B,
            C   => C,
            clk => clk,
            E   => E,
            Q   => Q
        );

    -- Clock Generation
    -- Clock Period = 10 ns
    process
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
    process
    begin
        A <= '0';
        B <= '0';
        C <= '0';

        wait for 12 ns;
        A <= '1';
        B <= '0';
        C <= '1';

        wait for 20 ns;
        A <= '0';
        B <= '1';
        C <= '1';

        wait for 20 ns;
        A <= '0';
        B <= '0';
        C <= '1';

        wait for 20 ns;
        A <= '1';
        B <= '1';
        C <= '0';

        wait for 20 ns;
        A <= '1';
        B <= '0';
        C <= '1';

        wait for 20 ns;
        A <= '0';
        B <= '0';
        C <= '0';

        wait;

    end process;

end Behavioral;
