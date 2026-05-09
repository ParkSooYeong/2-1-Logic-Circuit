library ieee;
use ieee.std_logic_1164.all;

entity D_Flip_Flop_vhdl_1_tb is
end D_Flip_Flop_vhdl_1_tb;

architecture Test_Bench of D_Flip_Flop_vhdl_1_tb is

    -- Input signals
    signal t_D   : std_logic := '0';
    signal t_clk : std_logic := '0';

    -- Output signal
    signal t_Q   : std_logic;

    -- Component declaration
    component D_Flip_Flop_vhdl_1
        port (
            D   : in std_logic;
            clk : in std_logic;
            Q   : out std_logic
        );
    end component;

begin

    -- Instantiate Unit Under Test (UUT)
    UUT : D_Flip_Flop_vhdl_1
        port map (
            D   => t_D,
            clk => t_clk,
            Q   => t_Q
        );

    -- Clock generation process
    clk_process : process
    begin
        while now < 120 ns loop
            t_clk <= '0';
            wait for 10 ns;
            t_clk <= '1';
            wait for 10 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        t_D <= '0';
        wait for 15 ns;

        t_D <= '1';
        wait for 20 ns;

        t_D <= '0';
        wait for 20 ns;

        t_D <= '1';
        wait for 20 ns;

        t_D <= '0';
        wait;
    end process;

end Test_Bench;
