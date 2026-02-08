library ieee;
use ieee.std_logic_1164.all;

-- Model for 2-input AND component
entity and2_gate is
	port (A, B : in std_logic;
			C : out std_logic);
end and2_gate;

architecture Boolean_Equation of and2_gate is
	begin
		C <= A and B; -- Logic Operator
end Boolean_Equation;
