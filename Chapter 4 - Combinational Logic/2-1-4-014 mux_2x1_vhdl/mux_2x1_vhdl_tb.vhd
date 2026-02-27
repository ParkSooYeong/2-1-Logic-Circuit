library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_vhdl_tb is
end mux_2x1_vhdl_tb;

architecture behavior of mux_2x1_vhdl_tb is

    signal A      : std_logic := '0';
    signal B      : std_logic := '0';
    signal sel    : std_logic := '0';
    signal m_out  : std_logic;

begin

    uut: entity work.mux_2x1_vhdl
        port map (
            A => A,
            B => B,
            sel => sel,
            m_out => m_out
        );

    stimulus: process
    begin
        for i in 0 to 7 loop

            if (i / 4) mod 2 = 0 then
                A <= '0';
            else
                A <= '1';
            end if;

            if (i / 2) mod 2 = 0 then
                B <= '0';
            else
                B <= '1';
            end if;

            if (i mod 2) = 0 then
                sel <= '0';
            else
                sel <= '1';
            end if;

            wait for 10 ns;

        end loop;

        wait;
    end process;

end behavior;
