library ieee;
use ieee.std_logic_1164.all;

entity OR_AND_VHDL is
	port(A, B, C : in std_logic;
				E : out std_logic);
end OR_AND_VHDL;

architecture Boolean_Equations of OR_AND_VHDL is
	signal D : std_logic;
	
	begin
		D <= A or B;
		E <= C and D;
end Boolean_Equations;
