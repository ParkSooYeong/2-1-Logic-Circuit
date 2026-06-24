library ieee;
use ieee.std_logic_1164.all;

entity Moore_Model_vhdl_2_tb is
end Moore_Model_vhdl_2_tb;

architecture Behavioral of Moore_Model_vhdl_2_tb is

    signal t_x_in  : std_logic := '0';
    signal t_clk   : std_logic := '0';
    signal t_rst_b : std_logic := '0';

    signal t_y_out_1 : std_logic;
    signal t_y_out_2 : std_logic;
    signal t_A       : std_logic;
    signal t_B       : std_logic;

begin

    M1 : entity work.Moore_Model_vhdl_2
        port map (
            x_in  => t_x_in,
            clk   => t_clk,
            rst_b => t_rst_b,
            y_out => t_y_out_1
        );

    M2 : entity work.Moore_Model_STR_vhdl_2
        port map (
            x_in  => t_x_in,
            clk   => t_clk,
            rst_b => t_rst_b,
            y_out => t_y_out_2,
            A     => t_A,
            B     => t_B
        );

    process
    begin
        while now < 200 ns loop
            t_clk <= '0';
            wait for 5 ns;

            t_clk <= '1';
            wait for 5 ns;
        end loop;

        wait;
    end process;

    process
    begin
        t_rst_b <= '0';
        t_x_in  <= '0';

        wait for 5 ns;
        t_rst_b <= '1';

        wait for 10 ns;
        t_x_in <= '1';

        wait for 80 ns;
        t_x_in <= '0';

        wait for 20 ns;
        t_rst_b <= '0';

        wait for 10 ns;
        t_rst_b <= '1';

        wait for 10 ns;
        t_x_in <= '1';

        wait for 50 ns;
        t_x_in <= '0';

        wait;
    end process;

end Behavioral;
