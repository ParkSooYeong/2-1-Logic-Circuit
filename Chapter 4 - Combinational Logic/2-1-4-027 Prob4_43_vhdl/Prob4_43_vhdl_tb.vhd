library ieee;
use ieee.std_logic_1164.all;

entity Prob4_43_vhdl_tb is
end Prob4_43_vhdl_tb;

architecture Test_Bench of Prob4_43_vhdl_tb is

    -- Declare stimulus signals
    signal t_A, t_S, t_E : std_logic;

    -- Declare response signal
    signal t_Q : std_logic;

    -- Component declaration
    component Prob4_43_vhdl
        port (
            A : in std_logic;
            S : in std_logic;
            E : in std_logic;
            Q : out std_logic
        );
    end component;

begin

    -- Instantiate Unit Under Test (UUT)
    UUT : Prob4_43_vhdl
        port map (
            A => t_A,
            S => t_S,
            E => t_E,
            Q => t_Q
        );

    -- Stimulus process
    process
    begin
        -- Case 1: Disabled → Output should be 'Z'
        t_A <= '0'; t_S <= '0'; t_E <= '0';
        wait for 10 ns;

        t_A <= '1'; t_S <= '1'; t_E <= '0';
        wait for 10 ns;

        -- Case 2: Enabled, S = 1 → Output follows A
        t_E <= '1'; t_S <= '1'; t_A <= '1';
        wait for 10 ns;

        t_A <= '0';
        wait for 10 ns;

        -- Case 3: Enabled, S = 0 → Output = '0'
        t_S <= '0';
        wait for 10 ns;

        -- Case 4: Disable again → Output = 'Z'
        t_E <= '0';
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end Test_Bench;
