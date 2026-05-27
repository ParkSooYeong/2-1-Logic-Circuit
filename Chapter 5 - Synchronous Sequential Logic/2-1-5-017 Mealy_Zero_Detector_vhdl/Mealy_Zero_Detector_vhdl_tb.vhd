library ieee;
use ieee.std_logic_1164.all;

entity Mealy_Zero_Detector_vhdl_tb is
end Mealy_Zero_Detector_vhdl_tb;

architecture Behavioral of Mealy_Zero_Detector_vhdl_tb is

    signal t_x_in  : std_logic := '0';
    signal t_clock : std_logic := '0';
    signal t_reset : std_logic := '1';

    signal t_y_out : std_logic;

    constant CLOCK_PERIOD : time := 10 ns;

begin

    --------------------------------------------------
    -- DUT (Device Under Test)
    --------------------------------------------------
    UUT : entity work.Mealy_Zero_Detector_vhdl
        port map (
            x_in  => t_x_in,
            clock => t_clock,
            reset => t_reset,
            y_out => t_y_out
        );

    --------------------------------------------------
    -- Clock Generation
    -- Clock Period = 10 ns (50 MHz)
    --------------------------------------------------
    process
    begin
        while now < 220 ns loop
            t_clock <= '0';
            wait for CLOCK_PERIOD / 2;
            t_clock <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;

        wait;

    end process;

    --------------------------------------------------
    -- Stimulus
    --------------------------------------------------
    process
    begin

        ------------------------------------------
        -- Initial Reset
        ------------------------------------------
        t_reset <= '0';
        wait for 2 ns;
        t_reset <= '1';

        ------------------------------------------
        -- Input Sequence
        ------------------------------------------
        wait for 8 ns;
        t_x_in <= '1';
        -- S0 -> S1

        wait for 20 ns;
        t_x_in <= '0';
        -- S1 -> S0

        wait for 10 ns;
        t_x_in <= '1';

        wait for 10 ns;
        t_x_in <= '0';

        wait for 2 ns;
        t_x_in <= '1';

        wait for 2 ns;
        t_x_in <= '0';

        wait for 16 ns;
        t_x_in <= '1';

        wait for 10 ns;
        t_x_in <= '0';

        wait for 10 ns;
        t_x_in <= '1';

        wait for 10 ns;
        t_x_in <= '0';

        wait for 20 ns;
        t_x_in <= '1';

        wait for 40 ns;
        t_x_in <= '0';

        wait for 10 ns;
        t_x_in <= '1';

        ------------------------------------------
        -- Reset Pulse
        ------------------------------------------
        wait for 7 ns;
        t_reset <= '0';
        wait for 2 ns;
        t_reset <= '1';

        ------------------------------------------
        -- End of Simulation
        ------------------------------------------
        wait;

    end process;

end Behavioral;
