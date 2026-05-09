library ieee;
use ieee.std_logic_1164.all;

entity D_Flip_Flop_vhdl_1 is
	port (D, clk : in std_logic;
			Q : out std_logic);
end D_Flip_Flop_vhdl_1;

architecture Behavioral of D_Flip_Flop_vhdl_1 is
begin
	process(clk)
	begin
		if clk'event and clk = '1' then Q <= D; end if;
	end process;
end Behavioral;
