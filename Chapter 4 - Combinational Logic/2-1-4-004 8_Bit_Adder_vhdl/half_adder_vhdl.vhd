library ieee;
use ieee.std_logic_1164.all;

entity half_adder_vhdl is
	port (x, y : in std_logic;
			S, C : out std_logic);
end half_adder_vhdl;

architecture Dataflow of half_adder_vhdl is
	begin
		S <= x xor y;
		C <= x and y;
end Dataflow;
