library ieee;
use ieee.std_logic_1164.all;

entity full_adder_vhdl is
	port (x, y, z : in std_logic;
			S, C : out std_logic);
end full_adder_vhdl;

architecture Structural of full_adder_vhdl is
	signal S1, C1, C2 : std_logic;
	
	component half_adder_vhdl
		port (x, y : in std_logic;
				S, C : out std_logic);
	end component;
	
	begin
		HA1 : half_adder_vhdl port map(S => S1, C => C1, x => x, y => y);
		HA2 : half_adder_vhdl port map(S => S, C => C2, x => S1, y => z);
		C <= C2 or C1;
end Structural;
