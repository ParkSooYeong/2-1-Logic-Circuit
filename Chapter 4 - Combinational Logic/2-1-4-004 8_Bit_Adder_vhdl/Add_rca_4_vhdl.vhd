library ieee;
use ieee.std_logic_1164.all;

entity Add_rca_4_vhdl is
	port (A, B : in std_logic_vector(3 downto 0);
			c_in : in std_logic;
			c_out : out std_logic;
			sum : out std_logic_vector(3 downto 0));
end Add_rca_4_vhdl;

architecture Structure of Add_rca_4_vhdl is
	component Add_full_vhdl
		port (a, b : in std_logic;
				c_in : in std_logic;
				c_out : out std_logic;
				sum : out std_logic);
	end component;
	
	signal c_in1, c_in2, c_in3 : std_logic;
	
	begin
		M0 : Add_full_vhdl port map(a(0), b(0), c_in, c_in1, sum(0));
		M1 : Add_full_vhdl port map(a(1), b(1), c_in1, c_in2, sum(1));
		M2 : Add_full_vhdl port map(a(2), b(2), c_in2, c_in3, sum(2));
		M3 : Add_full_vhdl port map(a(3), b(3), c_in3, c_out, sum(3));
end Structure;
