library ieee;
use ieee.std_logic_1164.all;

entity D_Flip_Flop_vhdl_3_tb is
end D_Flip_Flop_vhdl_3_tb;

architecture Test_Bench of D_Flip_Flop_vhdl_3_tb is

	component D_Flip_Flop_vhdl_3
		port (
			D, clk, rst : in std_logic;
			Q : out std_logic
		);
	end component;

	signal D, clk, rst, Q : std_logic;

begin

	UUT : D_Flip_Flop_vhdl_3
		port map (
			D => D,
			clk => clk,
			rst => rst,
			Q => Q
		);

	-- Clock generation (shorter period)
	process
	begin
		while now < 80 ns loop
			clk <= '0';
			wait for 5 ns;

			clk <= '1';
			wait for 5 ns;
		end loop;

		wait;
	end process;

	-- Stimulus process
	process
	begin
		-- Initial state
		rst <= '1';
		D <= '0';
		wait for 8 ns;

		-- Release reset
		rst <= '0';

		-- Q should capture D on falling edge
		D <= '1';
		wait for 10 ns;

		D <= '0';
		wait for 10 ns;

		D <= '1';
		wait for 10 ns;

		-- Apply reset again
		rst <= '1';
		wait for 8 ns;

		rst <= '0';
		D <= '0';
		wait for 10 ns;

		wait;
	end process;

end Test_Bench;
