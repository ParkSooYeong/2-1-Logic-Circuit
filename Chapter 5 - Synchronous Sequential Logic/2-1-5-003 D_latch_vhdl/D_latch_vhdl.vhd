library ieee;
use ieee.std_logic_1164.all;

entity D_latch_vhdl is
	port (D, enable : in std_logic;
			Q : out std_logic);
end D_latch_vhdl;

architecture Behavioral of D_latch_vhdl is
begin
	process (enable, D)
	begin
		if enable = '1' then Q <= D;
		end if;
	end process;
end Behavioral;
