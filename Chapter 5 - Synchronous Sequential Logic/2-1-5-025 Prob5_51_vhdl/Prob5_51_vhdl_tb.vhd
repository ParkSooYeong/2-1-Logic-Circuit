library ieee;
use ieee.std_logic_1164.all;

entity Prob5_51_vhdl_tb is
end Prob5_51_vhdl_tb;

architecture Behavioral of Prob5_51_vhdl_tb is

    component Prob5_51_vhdl
        port(
            x_in  : in  std_logic;
            clk   : in  std_logic;
            reset : in  std_logic;
            y_out : out std_logic
        );
    end component;

    signal t_x_in  : std_logic := '0';
    signal t_clk   : std_logic := '0';
    signal t_reset : std_logic := '0';
    signal t_y_out : std_logic;

begin

    DUT : Prob5_51_vhdl
        port map(
            x_in  => t_x_in,
            clk   => t_clk,
            reset => t_reset,
            y_out => t_y_out
        );

    ------------------------------------------------------------------
    -- Clock Generation (10 ns Period)
    ------------------------------------------------------------------
    clk_process : process
    begin
        while now < 160 ns loop
            t_clk <= '0';
            wait for 5 ns;
            t_clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    ------------------------------------------------------------------
    -- Stimulus
    ------------------------------------------------------------------
    stim_process : process
    begin
        -- Reset
        t_reset <= '0';
        wait for 10 ns;
        t_reset <= '1';

        -- Input sequence
        t_x_in <= '1';
        wait for 20 ns;

        t_x_in <= '0';
        wait for 20 ns;

        t_x_in <= '1';
        wait for 20 ns;

        t_x_in <= '1';
        wait for 20 ns;

        t_x_in <= '0';
        wait for 20 ns;

        t_x_in <= '1';
        wait for 20 ns;

        -- Reset verification
        t_reset <= '0';
        wait for 10 ns;
        t_reset <= '1';

        wait;
    end process;

end Behavioral;
