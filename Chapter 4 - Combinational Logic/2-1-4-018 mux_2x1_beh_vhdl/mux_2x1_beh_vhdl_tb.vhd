library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_beh_vhdl_tb is
end mux_2x1_beh_vhdl_tb;

architecture behavior of mux_2x1_beh_vhdl_tb is

	-- Component declaration
	component mux_2x1_beh_vhdl
		port (
			A, B : in std_logic;
			enable : in std_logic;
			m_out : out std_logic
		);
	end component;

	-- Testbench signals
	signal A : std_logic := '0';
	signal B : std_logic := '0';
	signal enable : std_logic := '0';
	signal m_out : std_logic;

begin

	-- Instantiate the Unit Under Test (UUT)
	UUT: mux_2x1_beh_vhdl
		port map (
			A => A,
			B => B,
			enable => enable,
			m_out => m_out
		);

	-- Stimulus process
	stim_proc: process
	begin

		A <= '0'; B <= '0'; enable <= '0';
		wait for 10 ns;

		A <= '0'; B <= '1'; enable <= '0';
		wait for 10 ns;

		A <= '1'; B <= '0'; enable <= '0';
		wait for 10 ns;

		A <= '1'; B <= '1'; enable <= '0';
		wait for 10 ns;

		A <= '0'; B <= '0'; enable <= '1';
		wait for 10 ns;

		A <= '0'; B <= '1'; enable <= '1';
		wait for 10 ns;

		A <= '1'; B <= '0'; enable <= '1';
		wait for 10 ns;

		A <= '1'; B <= '1'; enable <= '1';
		wait for 10 ns;

		wait;

	end process;

end behavior;
