library ieee;
use ieee.std_logic_1164.all;

entity D_latch_vhdl_tb is
end D_latch_vhdl_tb;

architecture Test_Bench of D_latch_vhdl_tb is

    -- Declare stimulus signals
    signal t_D, t_enable : std_logic;

    -- Declare response signal
    signal t_Q : std_logic;

    -- Component declaration
    component D_latch_vhdl
        port (
            D      : in std_logic;
            enable : in std_logic;
            Q      : out std_logic
        );
    end component;

begin

    -- Instantiate Unit Under Test (UUT)
    UUT : D_latch_vhdl
        port map (
            D => t_D,
            enable => t_enable,
            Q => t_Q
        );

    -- Stimulus process
    process
    begin
        -- Initial state
        t_D <= '0';
        t_enable <= '0';
        wait for 10 ns;

        -- Case 1: Enable = 1 → Q follows D
        t_enable <= '1';
        t_D <= '0';
        wait for 10 ns;

        t_D <= '1';
        wait for 10 ns;

        t_D <= '0';
        wait for 10 ns;

        -- Case 2: Enable = 0 → Q holds value
        t_enable <= '0';
        wait for 10 ns;

        t_D <= '1'; -- Q should NOT change
        wait for 10 ns;

        t_D <= '0'; -- Q should NOT change
        wait for 10 ns;

        -- Case 3: Enable = 1 again → Q updates
        t_enable <= '1';
        wait for 10 ns;

        t_D <= '1';
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end Test_Bench;
