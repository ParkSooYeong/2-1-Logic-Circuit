library ieee;
use ieee.std_logic_1164.all;

entity Ripple_Counter_4bit_vhdl_tb is
end Ripple_Counter_4bit_vhdl_tb;

architecture Behavioral of Ripple_Counter_4bit_vhdl_tb is

    signal t_count : std_logic := '0';
    signal t_reset : std_logic := '0';

    signal t_A0 : std_logic;
    signal t_A1 : std_logic;
    signal t_A2 : std_logic;
    signal t_A3 : std_logic;

begin

    ------------------------------------------------------------
    -- DUT
    ------------------------------------------------------------
    UUT : entity work.Ripple_Counter_4bit_vhdl
        port map (
            count => t_count,
            reset => t_reset,
            A0    => t_A0,
            A1    => t_A1,
            A2    => t_A2,
            A3    => t_A3
        );

    ------------------------------------------------------------
    -- Count Clock
    -- Clock Period = 10 ns
    ------------------------------------------------------------
    clock_process : process
    begin
        while now < 160 ns loop

            t_count <= '0';
            wait for 5 ns;

            t_count <= '1';
            wait for 5 ns;

        end loop;

        wait;
    end process;

    ------------------------------------------------------------
    -- Reset and Stimulus
    ------------------------------------------------------------
    stimulus_process : process
    begin

        --------------------------------------------------------
        -- Initial Reset
        --------------------------------------------------------
        t_reset <= '1';

        wait for 4 ns;

        t_reset <= '0';

        --------------------------------------------------------
        -- Normal Counting
        --------------------------------------------------------
        wait for 100 ns;

        --------------------------------------------------------
        -- Reset During Counting
        --------------------------------------------------------
        t_reset <= '1';

        wait for 4 ns;

        --------------------------------------------------------
        -- Release Reset
        --------------------------------------------------------
        t_reset <= '0';

        --------------------------------------------------------
        -- Continue Counting
        --------------------------------------------------------
        wait for 48 ns;

        wait;

    end process;

end Behavioral;
