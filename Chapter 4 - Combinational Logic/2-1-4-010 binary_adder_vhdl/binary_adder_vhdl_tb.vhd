library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_adder_vhdl_tb is
end binary_adder_vhdl_tb;

architecture behavior of binary_adder_vhdl_tb is

    -- Component declaration
    component binary_adder_vhdl
        port (
            A, B  : in  std_logic_vector (3 downto 0);
            C_in  : in  std_logic;
            sum   : out std_logic_vector (3 downto 0);
            C_out : out std_logic
        );
    end component;

    -- Test signals
    signal A, B  : std_logic_vector(3 downto 0);
    signal C_in  : std_logic;
    signal sum   : std_logic_vector(3 downto 0);
    signal C_out : std_logic;

begin

    -- DUT Instantiation
    uut: binary_adder_vhdl
        port map (
            A => A,
            B => B,
            C_in => C_in,
            sum => sum,
            C_out => C_out
        );

    -- Stimulus process
    stimulus: process
    begin

        -- Test Case 1
        A <= "0000"; B <= "0000"; C_in <= '0';
        wait for 10 ns;

        -- Test Case 2
        A <= "0101"; B <= "0011"; C_in <= '0';
        wait for 10 ns;

        -- Test Case 3
        A <= "0101"; B <= "0011"; C_in <= '1';
        wait for 10 ns;

        -- Test Case 4 (Carry case)
        A <= "1111"; B <= "0001"; C_in <= '0';
        wait for 10 ns;

        -- Test Case 5
        A <= "1010"; B <= "0101"; C_in <= '1';
        wait for 10 ns;

        -- Test Case 6 (Maximum case)
        A <= "1111"; B <= "1111"; C_in <= '1';
        wait for 10 ns;

        wait;
    end process;

end behavior;
