library ieee;
use ieee.std_logic_1164.all;

-- Model for exclusive-or component
entity xor2_gate is
	port (A, B : in std_logic;
			C : out std_logic);
end xor2_gate;

architecture Boolean_Equation of xor2_gate is
	begin
		C <= A xor B;
end Boolean_Equation;
