library ieee;
use ieee.std_logic_1164.all;

entity bufif1_vhdl_tb is
end bufif1_vhdl_tb;

architecture behavior of bufif1_vhdl_tb is

    -- Signals for bufif1
    signal buf_in   : std_logic := '0';
    signal control  : std_logic := '0';
    signal buf_out  : std_logic;

    -- Signals for notif1
    signal not_in   : std_logic := '0';
    signal not_out  : std_logic;

begin

    -- Instantiate bufif1_vhdl
    U1: entity work.bufif1_vhdl
        port map (
            buf_in  => buf_in,
            control => control,
            buf_out => buf_out
        );

    -- Instantiate notif1
    U2: entity work.notif1
        port map (
            not_in  => not_in,
            control => control,
            not_out => not_out
        );

    -- Stimulus process
    stim_proc: process
    begin

        -- Case 1: control = 0 → outputs should be 'Z'
        control <= '0';
        buf_in  <= '0';
        not_in  <= '0';
        wait for 10 ns;

        buf_in  <= '1';
        not_in  <= '1';
        wait for 10 ns;

        -- Case 2: control = 1 → normal operation
        control <= '1';

        buf_in <= '0';
        not_in <= '0';
        wait for 10 ns;

        buf_in <= '1';
        not_in <= '1';
        wait for 10 ns;

        buf_in <= '0';
        not_in <= '1';
        wait for 10 ns;

        buf_in <= '1';
        not_in <= '0';
        wait for 10 ns;

        wait;
    end process;

end behavior;
