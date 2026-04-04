library ieee;
use ieee.std_logic_1164.all;

entity Prob4_43_vhdl is
    port(A : in std_logic;
			S : in std_logic;
			E : in std_logic;
			Q : out std_logic);
end Prob4_43_vhdl;

architecture Behavioral of Prob4_43_vhdl is
	begin
		Q <= A when S = '1' and E = '1' else '0' when S = '0' and E = '1' else 'Z';
end Behavioral;
