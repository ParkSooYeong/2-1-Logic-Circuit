library ieee;
use ieee.std_logic_1164.all;

entity Add_half_vhdl is
	port (a, b : in std_logic;
			c_out, sum : out std_logic);
end Add_half_vhdl;

architecture Structure of Add_half_vhdl is
	component and2_gate -- Identify component being used
		port (a, b : in std_logic;
				c : out std_logic); -- Identify port of the component
	end component;
	
	component xor2_gate -- Component declaration
		port (a, b : in std_logic;
				c : out std_logic);
	end component;
	
	begin -- Instantiate components and connect ports
		G1 : xor2_gate port map(a, b, sum);
		G2 : and2_gate port map(a, b, c_out);
end Structure;
