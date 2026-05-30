library ieee;
use ieee.std_logic_1164.all;

entity Moore_Model_vhdl_tb is
end Moore_Model_vhdl_tb;

architecture Behavioral of Moore_Model_vhdl_tb is

    signal t_x_in   : bit := '0';
    signal t_clock  : bit := '0';
    signal t_reset  : bit := '0';
    signal t_y_out  : bit_vector(1 downto 0);

begin

    -- DUT Instantiation
    UUT : entity work.Moore_Model_vhdl
        port map (
            x_in  => t_x_in,
            clock => t_clock,
            reset => t_reset,
            y_out => t_y_out
        );

    -- Clock Generation (10 ns period)
    clock_process : process
    begin
        while now < 220 ns loop
            t_clock <= '0';
            wait for 5 ns;
            t_clock <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus Process
    stimulus_process : process
    begin
        -- Initial Reset
        t_reset <= '0';
        wait for 2 ns;
        t_reset <= '1';

        -- Input sequence
        wait for 10 ns;  t_x_in <= '0';
        wait for 20 ns;  t_x_in <= '1';
        wait for 20 ns;  t_x_in <= '0';
        wait for 20 ns;  t_x_in <= '1';
        wait for 20 ns;  t_x_in <= '0';
        wait for 20 ns;  t_x_in <= '1';
        wait for 20 ns;  t_x_in <= '0';

        -- Reset test
        wait for 20 ns;  t_reset <= '0';
        wait for 2 ns;   t_reset <= '1';

        -- Additional transitions
        wait for 20 ns;  t_x_in <= '1';
        wait for 20 ns;  t_x_in <= '0';
        wait for 20 ns;  t_x_in <= '1';

        wait;
    end process;

end Behavioral;
