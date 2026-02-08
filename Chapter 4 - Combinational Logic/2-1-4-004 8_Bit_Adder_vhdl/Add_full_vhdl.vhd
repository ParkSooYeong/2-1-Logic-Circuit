library ieee;
use ieee.std_logic_1164.all;

entity Add_full_vhdl is
	port (a, b, c_in : in std_logic;
			c_out, sum : out std_logic);
end Add_full_vhdl;

architecture Structure of Add_full_vhdl is
	component or2_gate
		port (a, b : in std_logic;
				c : out std_logic);
	end component;
	
	component Add_half_vhdl
		port (a, b : in std_logic;
				c_out, sum : out std_logic);
	end component;
	
	signal w1, w2, w3 : std_logic;
	
	begin
		M0 : Add_half_vhdl port map(w2, c_in, w3, sum);
		M1 : Add_half_vhdl port map(a, b, w1, w2);
		G1 : or2_gate port map(w1, w3, c_out);
end Structure;
