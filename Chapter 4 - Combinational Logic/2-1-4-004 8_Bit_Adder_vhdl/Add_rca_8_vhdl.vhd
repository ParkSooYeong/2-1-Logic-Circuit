library ieee;
use ieee.std_logic_1164.all;

entity Add_rca_8_vhdl is
	port (a, b : in std_logic_vector(7 downto 0);
			c_in : in std_logic;
			c_out : out std_logic;
			sum : out std_logic_vector(7 downto 0));
end Add_rca_8_vhdl;

architecture Structure of Add_rca_8_vhdl is
	component Add_rca_4_vhdl
		port (a, b : in std_logic_vector(3 downto 0);
				c_in : in std_logic;
				c_out : out std_logic;
				sum : out std_logic_vector(3 downto 0));
	end component;
	
	signal c_in4 : std_logic; -- Connects 4-bit adders
	
	begin
		M0 : Add_rca_4_vhdl port map(a(3 downto 0), b(3 downto 0), c_in, c_in4, sum(3 downto 0));
		M1 : Add_rca_4_vhdl port map(a(7 downto 4), b(7 downto 4), c_in4, c_out, sum(7 downto 4));
end Structure;
