library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1_beh_vhdl_tb is
end mux_4x1_beh_vhdl_tb;

architecture behavior of mux_4x1_beh_vhdl_tb is

    -- Component Declaration
    component mux_4x1_beh_vhdl
        port (
            in_0, in_1, in_2, in_3 : in std_logic;
            sel : in std_logic_vector(1 downto 0);
            m_out : out std_logic
        );
    end component;

    -- Signals
    signal in_0, in_1, in_2, in_3 : std_logic := '0';
    signal sel : std_logic_vector(1 downto 0) := "00";
    signal m_out : std_logic;

begin

    -- DUT Instantiation
    uut: mux_4x1_beh_vhdl
        port map (
            in_0 => in_0,
            in_1 => in_1,
            in_2 => in_2,
            in_3 => in_3,
            sel  => sel,
            m_out => m_out
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Initial input values
        in_0 <= '0'; in_1 <= '1'; in_2 <= '0'; in_3 <= '1';

        -- Test all select cases
        sel <= "00"; wait for 20 ns; -- expect m_out = in_0
        sel <= "01"; wait for 20 ns; -- expect m_out = in_1
        sel <= "10"; wait for 20 ns; -- expect m_out = in_2
        sel <= "11"; wait for 20 ns; -- expect m_out = in_3

        -- Change input pattern
        in_0 <= '1'; in_1 <= '0'; in_2 <= '1'; in_3 <= '0';

        sel <= "00"; wait for 20 ns;
        sel <= "01"; wait for 20 ns;
        sel <= "10"; wait for 20 ns;
        sel <= "11"; wait for 20 ns;

        -- End simulation
        wait;
    end process;

end behavior;
