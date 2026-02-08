library ieee;
use ieee.std_logic_1164.all;

-- Model for 2-input OR component
entity or2_gate is
	port (A, B : in std_logic;
			C : out std_logic);
end or2_gate;

architecture Boolean_Equation of or2_gate is
	begin
		C <= A or B; -- Logic Operator
end Boolean_Equation;
