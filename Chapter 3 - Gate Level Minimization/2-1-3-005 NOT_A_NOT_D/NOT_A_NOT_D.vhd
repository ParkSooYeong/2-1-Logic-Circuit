library ieee;
use ieee.std_logic_1164.all;

entity NOT_A_NOT_D is
	port(A, B, C : in std_logic;
			F		 : out std_logic);
end NOT_A_NOT_D;

architecture Boolean_Equations of NOT_A_NOT_D is
	signal D : std_logic;
	
	begin
		D <= (not A) or B;
		F <= (not D) and C;
end Boolean_Equations;
