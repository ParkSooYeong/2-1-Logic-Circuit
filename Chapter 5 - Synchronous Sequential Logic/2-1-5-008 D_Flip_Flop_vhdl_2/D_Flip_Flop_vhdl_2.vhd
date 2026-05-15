library ieee;
use ieee.std_logic_1164.all;

entity D_Flip_Flop_vhdl_2 is
	port (D, clk, rst_b : in std_logic;
			Q : out std_logic);
end D_Flip_Flop_vhdl_2;

architecture Behavioral of D_Flip_Flop_vhdl_2 is
begin
	process (clk, rst_b) begin
		if rst_b = '0' then Q <= '0';
		elsif rising_edge(clk) then Q <= D;
		end if;
	end process;
end Behavioral;
