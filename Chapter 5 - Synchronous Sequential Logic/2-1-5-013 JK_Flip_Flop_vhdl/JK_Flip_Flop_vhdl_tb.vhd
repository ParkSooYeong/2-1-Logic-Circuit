library ieee;
use ieee.std_logic_1164.all;

entity JK_Flip_Flop_vhdl_tb is
end JK_Flip_Flop_vhdl_tb;

architecture Behavioral of JK_Flip_Flop_vhdl_tb is

    component JK_Flip_Flop_vhdl
        port (
            J   : in  std_logic;
            K   : in  std_logic;
            clk : in  std_logic;
            rst : in  std_logic;
            Q   : out std_logic
        );
    end component;

    signal J   : std_logic := '0';
    signal K   : std_logic := '0';
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal Q   : std_logic;

begin

    --------------------------------------------------
    -- DUT
    --------------------------------------------------
    DUT : JK_Flip_Flop_vhdl
        port map (
            J   => J,
            K   => K,
            clk => clk,
            rst => rst,
            Q   => Q
        );

    --------------------------------------------------
    -- Clock Generation
    -- Clock Period = 10 ns
    --------------------------------------------------
    clk_process : process
    begin

        while now < 160 ns loop

            clk <= '0';
            wait for 5 ns;

            clk <= '1';
            wait for 5 ns;

        end loop;

        wait;

    end process;

    --------------------------------------------------
    -- Stimulus Process
    --------------------------------------------------
    stim_proc : process
    begin

        ------------------------------------------
        -- Reset
        ------------------------------------------
        rst <= '1';
        wait for 20 ns;

        rst <= '0';
        wait for 10 ns;

        ------------------------------------------
        -- Hold
        -- J=0, K=0
        ------------------------------------------
        J <= '0';
        K <= '0';
        wait for 20 ns;

        ------------------------------------------
        -- Reset
        -- J=0, K=1
        ------------------------------------------
        J <= '0';
        K <= '1';
        wait for 20 ns;

        ------------------------------------------
        -- Set
        -- J=1, K=0
        ------------------------------------------
        J <= '1';
        K <= '0';
        wait for 20 ns;

        ------------------------------------------
        -- Toggle
        -- J=1, K=1
        ------------------------------------------
        J <= '1';
        K <= '1';
        wait for 40 ns;

        wait;

    end process;

end Behavioral;
