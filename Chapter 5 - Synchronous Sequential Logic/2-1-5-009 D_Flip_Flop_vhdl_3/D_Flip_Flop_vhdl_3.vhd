library ieee;
use ieee.std_logic_1164.all;

entity D_Flip_Flop_vhdl_3 is
	port (D, clk, rst : in std_logic;
			Q : out std_logic);
end D_Flip_Flop_vhdl_3;

architecture Behavioral of D_Flip_Flop_vhdl_3 is
begin
	process (clk, rst) begin
		if rst = '1' then Q <= '0';
		elsif falling_edge(clk) then Q <= D;
		end if;
	end process;
end Behavioral;
